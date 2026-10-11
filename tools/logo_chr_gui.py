"""타이틀 로고: 편집용 19×11 CHR BIN 내보내기 / 수정본 임포트.
최종 CHR 2KiB와 PRG $01:$B18D용 압축 배치 BIN을 저장한다.
Python 표준 라이브러리만 사용. ROM/ASM은 직접 수정하지 않는다.
"""
from pathlib import Path
import tkinter as tk
from tkinter import filedialog, messagebox
import tempfile

ROOT = Path(__file__).resolve().parents[1]
ROM = ROOT / 'Akumajou Special - Boku Dracula Kun (J).nes'
MAP_OFFSET = 0x319D
MAP_SIZE = 0xC3
X, Y, W, H = 7, 3, 19, 11

# NES 색상 미리보기. 에뮬레이터의 표시 팔레트에 따라 RGB 색감은 달라질 수 있다.
NES_RGB = (
    '7C7C7C','0000FC','0000BC','4428BC','940084','A80020','A81000','881400',
    '503000','007800','006800','005800','004058','000000','000000','000000',
    'BCBCBC','0078F8','0058F8','6844FC','D800CC','E40058','F83800','E45C10',
    'AC7C00','00B800','00A800','00A844','008888','000000','000000','000000',
    'F8F8F8','3CBCF8','6888FC','9878F8','F878F8','F85898','F87858','FCA044',
    'F8B800','B8F818','58D854','58F898','00E8D8','787878','000000','000000',
    'FCFCFC','A4E4FC','B8B8F8','D8B8F8','F8B8F8','F8A4C0','F0D0B0','FCE0A8',
    'F8D878','D8F878','B8F8B8','B8F8D8','00FCFC','F8D8F8','000000','000000',
)


def read_title_palette(path):
    rom = Path(path).read_bytes()
    bank = rom[16+7*8192:16+8*8192]
    address = int.from_bytes(bank[0x1811:0x1813], 'little') + 0x1F*13
    data = bank[address-0xA000:address-0xA000+13]
    if len(data) != 13:
        raise ValueError('타이틀 팔레트를 읽을 수 없습니다.')
    return [bytes([data[0] & 0x3F]) + data[1+i*3:4+i*3] for i in range(4)]


def palette_group(blocks, tile_x, tile_y):
    attrs = blocks[1][1]
    value = attrs[(tile_y//4)*8+tile_x//4]
    shift = ((tile_y%4)//2)*4 + ((tile_x%4)//2)*2
    return (value >> shift) & 3


def save_bin_set(outputs):
    """GUI와 일괄 변환에서 같은 저장 경로를 사용한다."""
    pending = []
    try:
        for destination, content in outputs.items():
            destination = Path(destination)
            with tempfile.NamedTemporaryFile(dir=destination.parent, delete=False) as file:
                pending.append((Path(file.name), destination))
                file.write(content)
        for temporary, destination in pending:
            temporary.replace(destination)
    finally:
        for temporary, _ in pending:
            temporary.unlink(missing_ok=True)


def decode_map(data):
    """원본 C8AE 명령을 풀고 각 블록의 PPU 주소를 보존한다."""
    p = 0
    blocks = []
    address = int.from_bytes(data[p:p+2], 'little')
    p += 2
    out = bytearray()
    loop_start = None
    remaining = 0
    for _ in range(10000):
        c = data[p]
        p += 1
        if c == 0xFF:
            blocks.append((address, bytes(out)))
            return blocks
        if c == 0x7F:
            blocks.append((address, bytes(out)))
            address = int.from_bytes(data[p:p+2], 'little')
            p += 2
            out = bytearray()
        elif c == 0x70:
            loop_start = p
        elif 0x70 < c < 0x7F:
            remaining = remaining - 1 if remaining else c - 0x70
            if remaining:
                if loop_start is None:
                    raise ValueError('배치 반복 명령 오류')
                p = loop_start
        elif 0 < c < 0x60:
            out.extend([data[p]] * c)
            p += 1
        elif 0x60 <= c < 0x70:
            out.extend((data[p] + i) & 255 for i in range(max(1, c & 15)))
            p += 1
        elif 0x80 < c < 0xC0:
            n = c & 0x7F
            out.extend(data[p:p+n])
            p += n
        elif 0xC0 < c < 0xFF:
            n = c & 0x3F
            high = data[p] & 0xF0
            for i in range(n):
                low = ((data[p+(i+1)//2] >> 4) if i & 1 else data[p+(i+1)//2]) & 15
                out.append(high | low)
            p += n // 2 + 1
        else:
            raise ValueError(f'지원하지 않는 배치 명령 ${c:02X}')
    raise ValueError('배치 데이터가 끝나지 않습니다.')


def compress(data):
    """C8AE와 C9ED가 함께 읽는 반복/리터럴 명령만 사용한다."""
    n = len(data)
    best = [None] * (n + 1)
    best[n] = b''
    for i in range(n-1, -1, -1):
        options = []
        for count in range(1, min(63, n-i)+1):
            options.append(bytes([0x80+count]) + data[i:i+count] + best[i+count])
        for count in range(1, min(95, n-i)+1):
            if data[i+count-1] != data[i]:
                break
            options.append(bytes([count, data[i]]) + best[i+count])
        best[i] = min(options, key=len)
    return best[0]


def encode_map(blocks):
    result = b'\x7f'.join(address.to_bytes(2, 'little') + compress(data)
                           for address, data in blocks) + b'\xff'
    if len(result) > MAP_SIZE:
        raise ValueError(f'배치 데이터 {len(result)}바이트: 원본 공간 {MAP_SIZE}바이트 초과.\n'
                         '저장하지 않습니다. 타일 배치를 단순하게 수정해 주세요.')
    assert decode_map(result) == blocks
    return result.ljust(MAP_SIZE, b'\xff')


def read_rom(path):
    rom = Path(path).read_bytes()
    if rom[:4] != b'NES\x1a' or rom[6] & 4:
        raise ValueError('트레이너 없는 NES ROM이 필요합니다.')
    prg_size = rom[4] * 16384
    if prg_size not in (0x20000, 0x40000):
        raise ValueError('일본어 원본 또는 확장 ROM을 선택하세요.')
    # 원본 로고의 압축 데이터와 CHR 앞쪽 두 뱅크를 사용한다.
    raw = rom[MAP_OFFSET:MAP_OFFSET+MAP_SIZE]
    blocks = decode_map(raw)
    if [a for a, _ in blocks] != [0x2400, 0x27C0]:
        raise ValueError('이 게임의 로고 배치 데이터가 아닙니다.')
    chr_start = 16 + prg_size
    low_chr = rom[chr_start+0x30*1024:chr_start+0x32*1024]
    if len(low_chr) != 2048:
        raise ValueError('CHR 데이터를 읽을 수 없습니다.')
    return blocks, low_chr


def tile(chr_data, number):
    return chr_data[number*16:(number+1)*16]


def logo_indices():
    return [y*32+x for y in range(Y, Y+H) for x in range(X, X+W)]


def export_packed(chr_data, low_chr, blocks):
    data = low_chr + chr_data
    layout = blocks[0][1]
    return b''.join(tile(data, layout[i]) for i in logo_indices())


def rebuild(chr_data, low_chr, blocks, packed, rom_path=ROM):
    if len(packed) != W*H*16:
        raise ValueError(f'편집용 BIN은 {W}×{H}타일, {W*H*16}바이트여야 합니다.')
    positions = logo_indices()
    inside = set(positions)
    old_layout = blocks[0][1]
    protected = {n for i, n in enumerate(old_layout) if i not in inside and n >= 128}
    new_chr = bytearray(chr_data)
    # 저작권/START는 배경 map이 아닌 CB4C의 UI 번호 2로 출력된다.
    # $0B:$A9B0에서 시작하며 번호 1의 START 문구로 이어진다.
    rom = Path(rom_path).read_bytes()
    bank = rom[16+0x0B*8192:16+0x0C*8192]
    cursor = int.from_bytes(bank[0x8A8:0x8AA], 'little') - 0xA000 + 2
    shared = set()
    while True:
        command = bank[cursor]
        cursor += 1
        if command == 0xFF:
            break
        if command == 0xFE:
            cursor += 2
        elif command in (0xFB, 0xFC):
            count, value = bank[cursor:cursor+2]
            cursor += 2
            shared.update(range(value, value+count) if command == 0xFB else [value])
        elif command < 0xF9 or command == 0xFA:
            shared.add(command)
        else:
            raise ValueError('저작권/START 출력 데이터의 형식이 다릅니다.')
    shared = {number for number in shared if number >= 128}
    chr_start = 16 + rom[4] * 16384 + 0x32 * 1024
    original_chr = rom[chr_start:chr_start+2048]
    for number in shared:
        offset = (number-128)*16
        new_chr[offset:offset+16] = original_chr[offset:offset+16]
    protected.update(shared)
    layout = bytearray(old_layout)
    wanted = [packed[i:i+16] for i in range(0, len(packed), 16)]
    assigned = {}
    # 로고에서 사용하던 낮은 뱅크 타일(배경 $11 등)은 그림이 같으면 재사용.
    for number in sorted(set(old_layout[i] for i in positions) | protected):
        pixels = tile(low_chr + new_chr, number)
        if pixels in wanted:
            assigned.setdefault(pixels, number)
    used = protected | {n for n in assigned.values() if n >= 128}
    free = iter(n for n in range(128, 256) if n not in used)
    for pixels in wanted:
        if pixels not in assigned:
            number = next(free, None)
            if number is None:
                raise ValueError('로고 타일이 $32/$33의 128칸을 초과합니다. 저장하지 않습니다.')
            assigned[pixels] = number
            new_chr[(number-128)*16:(number-127)*16] = pixels
    for i, pixels in zip(positions, wanted):
        layout[i] = assigned[pixels]
    new_blocks = [(blocks[0][0], bytes(layout)), *blocks[1:]]
    encoded = encode_map(new_blocks)
    return bytes(new_chr), encoded, new_blocks


class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title('드라큘라군 로고 BIN 편집')
        self.rom_path = ROM
        self.chr_path = ROOT / 'logo_chr_rom.bin'
        self.blocks = self.chr_data = self.low_chr = None
        bar = tk.Frame(self)
        bar.pack(fill='x', padx=10, pady=10)
        tk.Button(bar, text='ROM 선택', command=self.choose_rom).pack(side='left')
        tk.Button(bar, text='CHR 열기', command=self.choose_chr).pack(side='left', padx=6)
        tk.Button(bar, text='편집용 BIN 익스포트', command=self.export).pack(side='left')
        tk.Button(bar, text='수정 BIN 임포트·저장', command=self.import_save).pack(side='left', padx=6)
        self.canvas = tk.Canvas(self, width=W*8*4, height=H*8*4, bg='black', highlightthickness=0)
        self.canvas.pack(padx=10)
        self.status = tk.StringVar(value='CHR을 열어 주세요.')
        tk.Label(self, textvariable=self.status, justify='left').pack(anchor='w', padx=10, pady=8)
        tk.Label(self, text='편집용: 19×11타일 NES 2bpp BIN · CHR 에디터 가로 폭 19타일\n'
                 '최종 저장: CHR 2KiB + 압축 map 195바이트 · 원본 팔레트와 map 속성으로 표시', justify='left').pack(anchor='w', padx=10, pady=(0,10))
        if self.rom_path.exists() and self.chr_path.exists():
            self.load(self.chr_path)

    def choose_rom(self):
        path = filedialog.askopenfilename(title='일본어 원본/확장 ROM', filetypes=[('NES ROM', '*.nes')])
        if path:
            self.rom_path = Path(path)
            self.load(self.chr_path)

    def choose_chr(self):
        path = filedialog.askopenfilename(initialdir=ROOT, filetypes=[('CHR BIN', '*.bin')])
        if path:
            self.load(Path(path))

    def load(self, path):
        try:
            blocks, low = read_rom(self.rom_path)
            palettes = read_title_palette(self.rom_path)
            data = path.read_bytes()
            if len(data) != 2048:
                raise ValueError('$32/$33 CHR BIN은 2048바이트여야 합니다.')
            companion = path.with_name(path.stem + '_map.bin')
            if companion.exists():
                candidate = decode_map(companion.read_bytes())
                if [a for a, _ in candidate] != [a for a, _ in blocks] or [len(b) for _, b in candidate] != [len(b) for _, b in blocks]:
                    raise ValueError('짝이 되는 map BIN의 구조가 다릅니다.')
                blocks = candidate
            self.chr_path, self.chr_data, self.low_chr, self.blocks = path, data, low, blocks
            self.palettes = palettes
            self.preview()
        except Exception as error:
            messagebox.showerror('열기 실패', str(error))

    def preview(self):
        packed = export_packed(self.chr_data, self.low_chr, self.blocks)
        img = tk.PhotoImage(width=W*8, height=H*8)
        for cy in range(H):
            for y in range(8):
                row = []
                for cx in range(W):
                    group = palette_group(self.blocks, X+cx, Y+cy)
                    colors = ['#'+NES_RGB[c & 0x3F] for c in self.palettes[group]]
                    pixels = packed[(cy*W+cx)*16:(cy*W+cx+1)*16]
                    row.extend(colors[((pixels[y] >> (7-x)) & 1) | (((pixels[y+8] >> (7-x)) & 1) << 1)] for x in range(8))
                img.put('{'+' '.join(row)+'}', to=(0,cy*8+y))
        self.picture = img.zoom(4,4)
        self.canvas.delete('all')
        self.canvas.create_image(0,0,anchor='nw',image=self.picture)
        self.status.set(f'{self.chr_path.name} · CHR $32/$33 · 로고 19×11타일')

    def export(self):
        if self.blocks is None:
            return
        path = filedialog.asksaveasfilename(initialdir=self.chr_path.parent,
            initialfile=self.chr_path.stem+'_logo_19x11.bin', defaultextension='.bin')
        if path:
            try:
                if Path(path).resolve() in (self.chr_path.resolve(), self.rom_path.resolve(), self.chr_path.with_name(self.chr_path.stem+'_map.bin').resolve()):
                    raise ValueError('편집용 BIN은 원본 CHR/ROM/map과 다른 이름으로 저장하세요.')
                Path(path).write_bytes(export_packed(self.chr_data,self.low_chr,self.blocks))
                self.status.set('편집용 BIN 저장 완료. CHR 에디터 가로 폭을 19타일로 맞추세요.')
            except Exception as error:
                messagebox.showerror('익스포트 실패', str(error))

    def import_save(self):
        if self.blocks is None:
            return
        source = filedialog.askopenfilename(title='수정한 19×11 로고 BIN', initialdir=self.chr_path.parent, filetypes=[('BIN', '*.bin')])
        if not source:
            return
        try:
            data, encoded, blocks = rebuild(self.chr_data,self.low_chr,self.blocks,Path(source).read_bytes(),self.rom_path)
            target = filedialog.asksaveasfilename(title='최종 CHR BIN 저장', initialdir=self.chr_path.parent,
                initialfile=self.chr_path.stem+'_edited.bin', defaultextension='.bin')
            if not target:
                return
            target = Path(target)
            companion = target.with_name(target.stem+'_map.bin')
            if any(p.resolve() in (Path(source).resolve(),self.rom_path.resolve()) for p in (target,companion)):
                raise ValueError('편집용 BIN이나 ROM을 덮어쓸 수 없습니다.')
            if (target.exists() or companion.exists()) and not messagebox.askyesno('덮어쓰기', f'{target.name}\n{companion.name}\n두 파일을 저장할까요?'):
                return
            save_bin_set({target: data, companion: encoded})
            self.chr_path,self.chr_data,self.blocks = target,data,blocks
            self.preview()
            messagebox.showinfo('저장 완료', f'{target.name}: CHR $32/$33\n{companion.name}: PRG $01:$B18D\n\nincbin 예시는 tools/logo_chr_gui.md를 참고하세요.')
        except Exception as error:
            messagebox.showerror('저장 실패', str(error))


if __name__ == '__main__':
    App().mainloop()
