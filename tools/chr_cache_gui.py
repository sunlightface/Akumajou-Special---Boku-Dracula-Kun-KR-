"""NES CHR-ROM cache builder. Run: python chr_cache_gui.py"""
from __future__ import annotations

import json
import re
from pathlib import Path
import tkinter as tk
from tkinter import ttk, filedialog, messagebox

from PIL import Image, ImageDraw, ImageFont, ImageTk
from fontTools.ttLib import TTFont

ROOT = Path(__file__).resolve().parents[1]
LEGACY_RESERVED = [48, 49, 50, 51, 61, 62]
OPTIONAL_RESERVED = (48, 49, 50, 51, 61, 62, 124)
ALWAYS_RESERVED = {126, 127}


def reserved_tiles(group):
    # Projects saved before this option retain their original allocation.
    selected = group.get('reserved_tiles', LEGACY_RESERVED)
    if not isinstance(selected, list) or any(type(i) is not int or i not in OPTIONAL_RESERVED for i in selected):
        raise ValueError('예약 타일 설정 오류')
    return set(selected) | ALWAYS_RESERVED


def free_tiles(group):
    reserved = reserved_tiles(group)
    # Preserve the existing single-bank boss layouts when exporting the project.
    half = group.get('glyph_half')
    if half is not None:
        if half not in (0, 1):raise ValueError('글꼴 뱅크 설정 오류')
        reserved |= set(range(64,128) if half == 0 else range(64))
        if half == 0:reserved.add(63)
    return [i for i in range(128) if i not in reserved]


def staff_roll_stream(group, records):
    """Pre-encode the original scrolling format; no runtime font conversion."""
    lookup = {char: (u, l) for _, u, l, char in records}
    lookup[' '] = (0xFE, 0xFE)  # $FF terminates a row in the original format.
    output = bytearray()
    texts = iter(line.replace('<END>', '') for line in group['text'].splitlines() if line.strip())
    lines = ['; Generated from the StaffRoll group. Original scrolling row format.',
             '; $00: empty row; $FD: logo effect; $FE: end; row: X, tiles, $FF.',
             'KrStaffRollTiles:']
    for item in group['scroll_rows']:
        if 'raw' in item:
            data = bytes(item['raw'])
            lines.append('    .db ' + ', '.join(f'${v:02X}' for v in data))
            output.extend(data)
            continue
        text, x = next(texts, None), item['x']
        if text is None or '<' in text or '>' in text:
            raise ValueError('스태프 롤은 원문 순서대로 한 항목을 한 줄에 입력하세요.')
        if not 1 <= x <= 31 or x + len(text) > 32:
            raise ValueError('스태프 롤 행의 X 좌표/길이 오류')
        lines.append('; ' + item['label'] + ': ' + text)
        for half in (0, 1):
            tiles = [lookup[c][half] for c in text]
            tiles += item.get('suffix_tiles', [[], []])[half]
            if 0xFF in tiles or x + len(tiles) > 32:
                raise ValueError('스태프 롤 행 길이 또는 종료 바이트 충돌')
            data = bytes([x, *tiles, 0xFF])
            output.extend(data)
            lines.append('    .db ' + ', '.join(f'${v:02X}' for v in data))
    # The reused original dialogue area ends before the retained ending graphic.
    if len(output) > 0xB75C - 0xB2D1:
        raise ValueError('스태프 롤 데이터가 원본 재사용 공간을 초과합니다.')
    if next(texts, None) is not None:raise ValueError('스태프 롤 항목 수가 원본과 다릅니다.')
    return bytes(output), '\n'.join(lines) + '\n'
CONTROLS = {'JUMP', 'PAGE', 'NL', 'END'}


def number(value):
    return int(str(value).strip().replace('$', '0x'), 0)


def read_table(path):
    chars, ids = {}, {}
    for line in Path(path).read_text(encoding='utf-8-sig').splitlines():
        if not line or line.startswith(';') or '=' not in line:
            continue
        key, char = line.split('=', 1)
        if not re.fullmatch(r'[0-9A-Fa-f]{4}', key):
            continue
        code = int(key, 16)
        if code >> 8 >= 0xFC:
            raise ValueError(f'제어코드와 충돌하는 번호: {key}')
        if len(char) != 1:
            raise ValueError(f'한 글자가 아닌 테이블 항목: {key}={char}')
        if char in chars and chars[char] != code:
            raise ValueError(f'문자 번호 중복: {char}')
        if code in ids and ids[code] != char:
            raise ValueError(f'고유번호 중복: {key}')
        chars[char], ids[code] = code, char
    return chars, ids


def encode_tile(im, top, ink):
    result = bytearray(16)
    for y in range(8):
        for x in range(8):
            if im.getpixel((x, top+y)):
                if ink & 1:
                    result[y] |= 1 << (7-x)
                if ink & 2:
                    result[y+8] |= 1 << (7-x)
    return result


def decode_chr(data):
    im = Image.new('RGB', (128, 64))
    colors = ['#101010', '#666666', '#aaaaaa', '#ffffff']
    for i in range(128):
        tile = data[i*16:i*16+16]
        for y in range(8):
            for x in range(8):
                c = ((tile[y] >> (7-x)) & 1) | (((tile[y+8] >> (7-x)) & 1) << 1)
                im.putpixel((i%16*8+x, i//16*8+y), tuple(bytes.fromhex(colors[c][1:])))
    return im


def build(config, group):
    base = Path(config['base']).read_bytes()
    if len(base) != 2048:
        raise ValueError('원본 BIN은 정확히 2048바이트여야 합니다.')
    table, ids = read_table(config['table'])
    space = number(config['space'])
    if not 0 <= space < 0xFC00:
        raise ValueError('공백 번호 범위: $0000–$FBFF')
    if space in ids and ids[space] != ' ':
        raise ValueError('공백 번호가 다른 문자와 충돌합니다.')
    if ' ' in table and table[' '] != space:
        raise ValueError('공백 번호가 kr_table.txt와 다릅니다.')
    if any(base[i*16:(i+1)*16] != bytes(16) for i in (126, 127)):
        raise ValueError('예약 공백 타일 126/127이 비어 있지 않습니다. 원본을 확인하세요.')
    tokens = re.findall(r'<([^<>]+)>', group['text'])
    unknown = sorted(set(tokens)-CONTROLS)
    if unknown:
        raise ValueError('알 수 없는 제어코드: '+', '.join(unknown))
    text = re.sub(r'<(?:JUMP|PAGE|NL|END)>', '', group['text'])
    chars = set(text)-set(' \t\r\n')
    fixed_text = group.get('fixed_chars', '')
    if not isinstance(fixed_text, str) or re.search(r'<[^>]*>', fixed_text):
        raise ValueError('동일 배치에는 제어코드 없이 문자만 입력하세요.')
    fixed = set(fixed_text)-set(' \t\r\n')
    chars |= fixed
    missing = sorted(chars-set(table))
    if missing:
        raise ValueError('테이블 미등록 문자: '+ ' '.join(f'{c} (U+{ord(c):04X})' for c in missing))
    free = free_tiles(group)
    capacity = len(free)//2
    if len(chars) > capacity:
        raise ValueError(f'{len(chars)}자 / 최대 {capacity}자: 용량 초과로 생성할 수 없습니다.')
    size, ox, oy = (int(config[k]) for k in ('size', 'x', 'y'))
    threshold, ink = int(config['threshold']), int(config['ink'])
    if not 1 <= threshold <= 255 or ink not in (1, 2, 3):
        raise ValueError('임계값은 1–255, 픽셀 색 번호는 1–3이어야 합니다.')
    font = ImageFont.truetype(config['font'], size)
    with TTFont(config['font']) as tf:
        cmap = tf.getBestCmap() or {}
        absent = [c for c in chars if ord(c) not in cmap]
    if absent:
        raise ValueError('TTF에 없는 글자: '+' '.join(sorted(absent)))
    output = bytearray(base)
    records, glyphs = [], []
    ordered = sorted(fixed, key=table.get) + sorted(chars-fixed, key=table.get)
    for i, char in enumerate(ordered):
        canvas = Image.new('L', (72, 80))
        ImageDraw.Draw(canvas).text((32+ox, 32+oy), char, font=font, fill=255)
        canvas = canvas.point(lambda p: 255 if p >= threshold else 0)
        bbox = canvas.getbbox()
        if bbox and (bbox[0] < 32 or bbox[1] < 32 or bbox[2] > 40 or bbox[3] > 48):
            raise ValueError(f'「{char}」가 8×16 영역 밖으로 잘립니다. 크기·X·Y를 조절하세요.')
        glyph = canvas.crop((32, 32, 40, 48))
        if not glyph.getbbox():
            raise ValueError(f'「{char}」에 표시할 픽셀이 없습니다.')
        upper, lower = free[i*2:i*2+2]
        output[upper*16:(upper+1)*16] = encode_tile(glyph, 0, ink)
        output[lower*16:(lower+1)*16] = encode_tile(glyph, 8, ink)
        records.append((table[char], upper+0x80, lower+0x80, char))
        glyphs.append(glyph)
    space_tiles = group.get('space_tiles', [0xFE, 0xFF])
    if len(space_tiles)!=2 or any(type(i) is not int or not 0x80<=i<=0xFF for i in space_tiles):
        raise ValueError('공백 타일 설정 오류')
    if group.get('glyph_half') == 0:
        output[63*16:64*16] = bytes(16)
    records.append((space, *space_tiles, '공백'))
    records.sort()
    assert all(output[i*16:(i+1)*16] == base[i*16:(i+1)*16] for i in reserved_tiles(group))
    return bytes(output), records, glyphs


def export_project(config, groups, folder):
    if not groups:
        raise ValueError('그룹을 추가하세요.')
    if len(groups) > 64:
        raise ValueError('확장 CHR 영역에는 최대 64그룹을 배치할 수 있습니다.')
    built = []
    names = set()
    for group in groups:
        name = group['name']
        if not re.fullmatch(r'[A-Za-z][A-Za-z0-9_]{0,47}', name) or name.upper() in {'CON','PRN','AUX','NUL',*[f'COM{i}' for i in range(1,10)],*[f'LPT{i}' for i in range(1,10)]}:
            raise ValueError('그룹 이름은 영문자로 시작하는 영문·숫자·밑줄(48자 이내)을 사용하세요.')
        if name.lower() in names:
            raise ValueError('중복 그룹 이름: '+name)
        names.add(name.lower())
        try:
            built.append((group, *build(config, group)))
        except (ValueError, OSError) as e:
            raise ValueError(f'{name}: {e}') from e
    bank = number(config['prg'])
    first = number(config['chr'])
    if not 0x0E <= bank <= 0x1D:
        raise ValueError('PRG 뱅크는 새 영역 $0E–$1D를 지정하세요.')
    if first < 0x80 or first+2*len(groups) > 0x100:
        raise ValueError('CHR 확장 영역 $80–$FF 범위를 벗어납니다.')
    prg_size = 6*len(groups) + sum(len(records)*4 for _,_,records,_ in built)
    if prg_size > 0x2000:
        raise ValueError('그룹 표와 배치표가 한 8KiB PRG 뱅크를 초과합니다.')
    files = {}
    prg = ['ChrCacheGroups:']
    for i, (group, data, records, glyphs) in enumerate(built):
        cb = first+i*2
        slots=group.get('chr_slots', [cb, cb+1])
        if len(slots)!=2 or any(type(v) is not int or not 0<=v<=255 for v in slots):
            raise ValueError('CHR 슬롯 설정 오류')
        prg += [f'    .db ${slots[0]:02X}, ${slots[1]:02X}, ${bank:02X}',
                f'    .dw {group["name"]}_FontMap', f'    .db {len(records)}']
    for group, data, records, glyphs in built:
        name = group['name']
        mapping = [f'{name}_FontMap:']
        mapping += [f'    .db ${code>>8:02X}, ${code&255:02X}, ${upper:02X}, ${lower:02X} ; {char}'
                for code,upper,lower,char in records]
        files[name+'_map.asm'] = ('\n'.join(mapping)+'\n').encode('utf-8-sig')
        files[name+'.chr.bin'] = data
        if 'scroll_rows' in group:
            _, scroll_asm = staff_roll_stream(group, records)
            cb = first + groups.index(group)*2
            definitions = (f'.definelabel StaffRoll_ChrFirst, ${cb:02X}\n'
                           f'.definelabel StaffRoll_ChrSecond, ${cb+1:02X}\n')
            scroll_asm = scroll_asm.replace('KrStaffRollTiles:', definitions+'KrStaffRollTiles:')
            files[name+'_scroll.asm'] = scroll_asm.encode('utf-8-sig')
    chr_lines = []
    for i, (group, *_) in enumerate(built):
        prg.append(f'.include "map\{group["name"]}_map.asm"')
        chr_lines += [f'.bank ${first+i*2:02X}, $0000',
                      f'.incbin "assets\{group["name"]}.chr.bin"']
    files['prg_groups.asm'] = ('\n'.join(prg)+'\n').encode('utf-8-sig')
    files['chr_groups.asm'] = ('\n'.join(chr_lines)+'\n').encode('utf-8-sig')
    folder = Path(folder)
    protected = {Path(config[k]).resolve() for k in ('base','font','table')}
    if any((folder/name).resolve() in protected for name in files):
        raise ValueError('출력 파일이 입력 파일을 덮어쓸 수 없습니다.')
    folder.mkdir(parents=True, exist_ok=True)
    for name,data in files.items():
        (folder/name).write_bytes(data)
    return len(groups), len(groups)*2048, prg_size


class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title('NES 8×16 CHR-ROM 캐시 생성기')
        self.geometry('1120x850')
        self.groups = []
        self.current = None
        self.project_path = None
        self.dirty = False
        defaults = dict(base=str(ROOT/'assets'/'chrrom_og.bin'), table=str(ROOT/'kr_table.txt'),
                        font=str(ROOT/'tools'/'갈무리-에슘길체12pt,7x11.ttf'), size='16', x='0', y='8',
                        threshold='128', ink='3', space='$8000', prg='$0E', chr='$80')
        self.vars = {k: tk.StringVar(value=v) for k,v in defaults.items()}
        top = ttk.Frame(self, padding=8); top.pack(fill='x')
        for row,(k,label) in enumerate([('base','원본 CHR BIN'),('font','출력용 TTF'),('table','전체 문자 테이블')]):
            ttk.Label(top,text=label).grid(row=row,column=0,sticky='w')
            ttk.Entry(top,textvariable=self.vars[k]).grid(row=row,column=1,sticky='ew',padx=5)
            ttk.Button(top,text='찾기',command=lambda key=k:self.pick(key)).grid(row=row,column=2)
        top.columnconfigure(1,weight=1)
        opts=ttk.Frame(self,padding=8);opts.pack(fill='x')
        for i,(k,label) in enumerate([('size','글꼴 px'),('x','X'),('y','Y'),('threshold','임계값'),('ink','색 번호'),('space','공백 ID')]):
            ttk.Label(opts,text=label).grid(row=0,column=i*2)
            ttk.Entry(opts,textvariable=self.vars[k],width=7).grid(row=0,column=i*2+1,padx=4)
        toolbar=ttk.Frame(self,padding=8);toolbar.pack(fill='x')
        for label,fn in [('프로젝트 열기',self.open_project),('프로젝트 저장',self.save_project),('그룹 추가',self.add),('그룹 삭제',self.delete),('위로',lambda:self.move(-1)),('아래로',lambda:self.move(1))]:
            ttk.Button(toolbar,text=label,command=fn).pack(side='left',padx=2)
        ttk.Button(toolbar,text='그룹 간 동일 배치',command=self.edit_shared_layout).pack(side='left',padx=2)
        body=ttk.Panedwindow(self,orient='horizontal');body.pack(fill='both',expand=True,padx=8)
        left=ttk.Frame(body);right=ttk.Frame(body);body.add(left,weight=1);body.add(right,weight=4)
        self.list=tk.Listbox(left,exportselection=False,width=23);self.list.pack(fill='both',expand=True)
        self.list.bind('<<ListboxSelect>>',self.select)
        self.name=tk.StringVar()
        ttk.Label(right,text='그룹 이름 (영문·숫자·밑줄)').pack(anchor='w')
        ttk.Entry(right,textvariable=self.name).pack(fill='x')
        reservations=ttk.LabelFrame(right,text='예약 타일 — 체크하면 글자 배치에서 제외 (그룹별)')
        reservations.pack(fill='x',pady=4)
        self.reserved_vars={i:tk.BooleanVar(value=True) for i in OPTIONAL_RESERVED}
        for tile,var in self.reserved_vars.items():
            ttk.Checkbutton(reservations,text=str(tile),variable=var,command=self.changed).pack(side='left',padx=5)
        self.layout_status=tk.StringVar()
        ttk.Label(right,textvariable=self.layout_status,wraplength=800).pack(anchor='w')
        self.editor=tk.Text(right,height=9,wrap='word',undo=True);self.editor.pack(fill='both',expand=True)
        self.editor.bind('<<Modified>>',self.modified)
        ttk.Button(right,text='분석 / 미리보기',command=self.preview).pack(anchor='w',pady=4)
        self.status=tk.StringVar(value='대사를 입력하고 분석하세요. ~, ・ 같은 기호도 포함합니다.')
        ttk.Label(right,textvariable=self.status,wraplength=820).pack(anchor='w')
        self.canvas=tk.Canvas(right,height=195,background='#202020');self.canvas.pack(fill='x')
        self.tree=ttk.Treeview(right,columns=('id','char','upper','lower'),show='headings',height=6)
        for k,label in [('id','고유번호'),('char','글자'),('upper','BG 상단'),('lower','BG 하단')]:self.tree.heading(k,text=label);self.tree.column(k,width=100)
        self.tree.pack(fill='x')
        bottom=ttk.Frame(self,padding=8);bottom.pack(fill='x')
        for k,label in [('chr','CHR 시작 뱅크'),('prg','표 PRG 뱅크')]:
            ttk.Label(bottom,text=label).pack(side='left');ttk.Entry(bottom,textvariable=self.vars[k],width=8).pack(side='left',padx=5)
        ttk.Button(bottom,text='전체 내보내기',command=self.export).pack(side='right')
        ttk.Label(self,text='출력: prg_groups.asm(그룹 표 + 맵 include), chr_groups.asm(bank + incbin), 그룹별 map.asm·BIN. 개별 맵에는 배치 지시문이 없습니다.',wraplength=1080).pack(anchor='w',padx=10,pady=5)
        for v in [*self.vars.values(), self.name]:v.trace_add('write',self.changed)
        self.protocol('WM_DELETE_WINDOW',self.close)
        self.add()

    def changed(self,*_):self.dirty=True
    def modified(self,*_):
        if self.editor.edit_modified():self.dirty=True;self.editor.edit_modified(False)
    def config_values(self):return {k:v.get() for k,v in self.vars.items()}
    def pick(self,key):
        path=filedialog.askopenfilename()
        if path:self.vars[key].set(path)
    def commit(self):
        if self.current is not None:
            self.groups[self.current].update(name=self.name.get().strip(),text=self.editor.get('1.0','end-1c'),
                reserved_tiles=[i for i,v in self.reserved_vars.items() if v.get()])
    def edit_shared_layout(self):
        self.commit()
        if not self.groups:return
        dialog=tk.Toplevel(self)
        dialog.title('그룹 간 동일 배치')
        dialog.transient(self)
        dialog.grab_set()
        ttk.Label(dialog,text='같은 위치를 사용할 그룹을 선택하세요. Ctrl/Shift로 여러 개를 선택할 수 있습니다.').pack(padx=12,pady=8)
        choices=tk.Listbox(dialog,selectmode='extended',exportselection=False,height=14,width=55)
        choices.pack(fill='both',expand=True,padx=12)
        for i,group in enumerate(self.groups):choices.insert('end',f'{i:02d}  {group["name"]}')
        current=self.groups[self.current].get('fixed_chars','') if self.current is not None else ''
        for i,group in enumerate(self.groups):
            if (current and group.get('fixed_chars','')==current) or i==self.current:choices.selection_set(i)
        ttk.Label(dialog,text='동일 배치 문자 — 본문에 없는 문자도 캐시에 포함됩니다.\n선택한 그룹의 기존 설정을 교체합니다. 빈칸으로 적용하면 해제됩니다.').pack(padx=12,pady=8)
        entry=tk.Text(dialog,height=3,width=55,wrap='word')
        entry.pack(fill='x',padx=12)
        entry.insert('1.0',current)
        def apply():
            selected=choices.curselection()
            if not selected:
                messagebox.showerror('선택 필요','그룹을 선택하세요.',parent=dialog);return
            fixed=entry.get('1.0','end-1c').strip()
            if fixed and len(selected)<2:
                messagebox.showerror('선택 필요','동일 배치할 그룹을 두 개 이상 선택하세요.',parent=dialog);return
            try:
                candidates=[]
                for index in selected:
                    candidate=dict(self.groups[index],fixed_chars=fixed)
                    build(self.config_values(),candidate)
                    candidates.append((index,candidate))
            except Exception as exc:
                messagebox.showerror('적용 불가',f'{candidate["name"]}: {exc}',parent=dialog);return
            for index,candidate in candidates:
                if not fixed:candidate.pop('fixed_chars',None)
                self.groups[index]=candidate
            self.dirty=True
            self.refresh(self.current)
            dialog.destroy()
        buttons=ttk.Frame(dialog);buttons.pack(pady=10)
        ttk.Button(buttons,text='선택 그룹에 적용',command=apply).pack(side='left',padx=5)
        ttk.Button(buttons,text='취소',command=dialog.destroy).pack(side='left',padx=5)
    def refresh(self,index):
        self.list.delete(0,'end')
        for i,g in enumerate(self.groups):self.list.insert('end',f'{i:02d}  {g["name"]}')
        self.current=index
        self.name.set(self.groups[index]['name'] if index is not None else '')
        reserved=reserved_tiles(self.groups[index]) if index is not None else set(OPTIONAL_RESERVED)
        for tile,var in self.reserved_vars.items():var.set(tile in reserved)
        fixed=self.groups[index].get('fixed_chars','') if index is not None else ''
        self.layout_status.set('동일 배치 문자: '+fixed if fixed else '동일 배치: 없음 (고유번호순 배치)')
        self.editor.delete('1.0','end')
        if index is not None:
            self.editor.insert('1.0',self.groups[index]['text']);self.list.selection_set(index)
        self.canvas.delete('all');self.tree.delete(*self.tree.get_children());self.status.set('分析 / 미리보기를 눌러 현재 그룹을 확인하세요.'.replace('分析','분석'))
    def select(self,*_):
        sel=self.list.curselection()
        if sel and sel[0]!=self.current:self.commit();self.refresh(sel[0])
    def add(self):
        self.commit();i=1
        while any(g['name']==f'Group{i:02d}' for g in self.groups):i+=1
        self.groups.append({'name':f'Group{i:02d}','text':'','reserved_tiles':list(OPTIONAL_RESERVED)});self.refresh(len(self.groups)-1)
    def delete(self):
        if self.current is not None and messagebox.askyesno('그룹 삭제','선택한 그룹을 프로젝트에서 삭제할까요?'):
            self.groups.pop(self.current);self.refresh(min(self.current,len(self.groups)-1) if self.groups else None)
    def move(self,delta):
        self.commit()
        if self.current is None:return
        j=self.current+delta
        if 0<=j<len(self.groups):self.groups[j],self.groups[self.current]=self.groups[self.current],self.groups[j];self.refresh(j)
    def preview(self):
        self.commit()
        if self.current is None:return
        try:
            data,records,glyphs=build(self.config_values(),self.groups[self.current])
            self.tree.delete(*self.tree.get_children())
            for code,u,l,c in records:self.tree.insert('','end',values=(f'{code:04X}',c,f'{u:02X}',f'{l:02X}'))
            atlas=decode_chr(data).resize((384,192),Image.Resampling.NEAREST)
            self.photo=ImageTk.PhotoImage(atlas);self.canvas.delete('all');self.canvas.create_image(0,0,image=self.photo,anchor='nw')
            for tile in reserved_tiles(self.groups[self.current]):
                x,y=tile%16*24,tile//16*24;self.canvas.create_rectangle(x,y,x+24,y+24,outline='#ff9933')
            sheet=Image.new('RGB',(240,192),'#101010')
            for i,g in enumerate(glyphs):sheet.paste(g.convert('RGB').resize((16,32),Image.Resampling.NEAREST),((i%15)*16,(i//15)*40))
            self.glyphphoto=ImageTk.PhotoImage(sheet);self.canvas.create_image(398,0,image=self.glyphphoto,anchor='nw')
            capacity=len(free_tiles(self.groups[self.current]))//2
            self.status.set(f'{len(glyphs)}/{capacity}자 · 공백 별도 · 왼쪽: CHR 128타일(주황=보존), 오른쪽: 정렬된 8×16 글꼴')
        except Exception as e:self.status.set(str(e));messagebox.showerror('생성 불가',str(e))
    def save_project(self):
        self.commit();path=filedialog.asksaveasfilename(defaultextension='.json',filetypes=[('캐시 프로젝트','*.json')])
        if not path:return False
        try:
            Path(path).write_text(json.dumps({'version':1,'config':self.config_values(),'groups':self.groups},ensure_ascii=False,indent=2),encoding='utf-8')
            self.project_path=path;self.dirty=False;return True
        except Exception as e:messagebox.showerror('저장 실패',str(e));return False
    def discard(self):
        if not self.dirty:return True
        answer=messagebox.askyesnocancel('프로젝트 저장','현재 프로젝트를 저장할까요?')
        return self.save_project() if answer else answer is False
    def open_project(self):
        if not self.discard():return
        path=filedialog.askopenfilename(filetypes=[('캐시 프로젝트','*.json')])
        if not path:return
        try:
            obj=json.loads(Path(path).read_text(encoding='utf-8-sig'))
            if obj.get('version')!=1 or not isinstance(obj.get('groups'),list):raise ValueError('지원하지 않는 프로젝트입니다.')
            for g in obj['groups']:
                if not isinstance(g.get('name'),str) or not isinstance(g.get('text'),str):raise ValueError('그룹 형식 오류')
            for k,v in obj['config'].items():
                if k in ('base', 'font', 'table') and not Path(v).is_file():
                    for directory in (ROOT, ROOT/'assets', ROOT/'tools'):
                        candidate = directory/Path(v).name
                        if candidate.is_file():
                            v = str(candidate)
                            break
                if k in self.vars:self.vars[k].set(v)
            self.groups=obj['groups'];self.refresh(0 if self.groups else None);self.project_path=path;self.dirty=False
        except Exception as e:messagebox.showerror('열기 실패',str(e))
    def export(self):
        self.commit();folder=filedialog.askdirectory(title='내보낼 폴더')
        if not folder:return
        if any(Path(folder).iterdir()) and not messagebox.askyesno('출력 갱신','같은 이름의 출력 파일을 덮어씁니다. 계속할까요?'):return
        try:
            count,size,prg=export_project(self.config_values(),self.groups,folder)
            messagebox.showinfo('내보내기 완료',f'{count}그룹 · CHR {size//1024}KiB · PRG 표 {prg}바이트\n{folder}')
        except Exception as e:messagebox.showerror('내보내기 실패',str(e))
    def close(self):
        if self.discard():self.destroy()


if __name__ == '__main__':
    App().mainloop()
