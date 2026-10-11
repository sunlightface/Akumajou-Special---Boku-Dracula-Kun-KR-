.bank $10, $8000
    .db $08 ; 원본 NMI/사운드가 읽는 PRG 쌍 번호

.definelabel DataBank,       $07F6
.definelabel FlushRequested, $07F7
.definelabel FirstFontBank,       $07F8
.definelabel SecondFontBank,      $07F9
.definelabel InterfaceCommand,      $07FE
.definelabel Error,          $07FF

; 원본 UI가 보존하던 $07-$17은 호출 전후 보존
.definelabel ScriptPointer,    $00
.definelabel Packet,    $02
.definelabel TileAddress,      $04
.definelabel CharacterIndex,    $06
.definelabel TileDirection,       $07
.definelabel Mask,      $08
.definelabel Count,     $09
.definelabel InterfaceHasText,   $0A
.definelabel CommandState,      $0B
.definelabel RunCount,  $0C
.definelabel RunValue,  $0D
.definelabel RunStep,   $0E
.definelabel Control,   $0F
.definelabel Map,       $10
.definelabel MapBank,   $12
.definelabel MapCount,  $13
.definelabel CharacterHigh,    $14
.definelabel CharacterLow,    $15
.definelabel UpperTile,     $16
.definelabel LowerTile,     $17

; 공통 진입/복귀로 CallTextHandler -> RunTextCommand
RunTextCommand:
    tay
    ldx #$00
SaveScratch:
    lda $07,x
    pha
    inx
    cpx #$11
    bne SaveScratch
    lda #$00
    sta FlushRequested
    tya
    cmp #$0A
    bcc DispatchTextCommand
    cmp #$15
    bcs DispatchStatusCommand
    jsr RunBossCommand
    jmp DispatchReturn
DispatchStatusCommand:
    jsr RunStatusCommand
    jmp DispatchReturn
DispatchTextCommand:
    cmp #$00
    beq DispatchText
    cmp #$01
    bne DispatchNumbers
    jsr DrawInterface
    jmp DispatchReturn
DispatchNumbers:
    cmp #$09
    beq DispatchDialogueClear
    cmp #$08
    beq DispatchClear
    cmp #$07
    beq DispatchLotteryFrame
    cmp #$06
    beq DispatchAmida
    cmp #$05
    beq DispatchPassword
    jsr DrawNumber
    jmp DispatchReturn
DispatchPassword:
    jsr UpdatePassword
    jmp DispatchReturn
DispatchAmida:
    jsr DrawAmidaLabels
    jmp DispatchReturn
DispatchLotteryFrame:
    jsr DrawLotteryFrame
    jmp DispatchReturn
DispatchClear:
    jsr CompleteLotteryClear
    jmp DispatchReturn
DispatchDialogueClear:
    jsr SetDialogueClearArea
    jmp DispatchReturn
DispatchText:
    jsr ProcessDialogue
DispatchReturn:
    tay
    ldx #$10
RestoreScratch:
    pla
    sta $07,x
    dex
    bpl RestoreScratch
    tya
    rts

SetDataBank:
    sta DataBank
    sta $AFFF
    rts

ReadScriptByte:
    lda #$0F
    jsr SetDataBank
    ldy #$00
    lda (ScriptPointer),y
    inc ScriptPointer
    bne ReadByteDone
    inc ScriptPointer+1
ReadByteDone:
    rts

; 대사 주소로 그룹 ID를 찾음
FindDialogueGroup:
    ldy #$01
    lda (Packet),y
    beq GroupMissing
    cmp ScriptPointer+1
    bne GroupNext
    dey
    lda (Packet),y
    cmp ScriptPointer
    bne GroupNext
    ldy #$02
    lda (Packet),y
    rts
GroupNext:
    clc
    lda Packet
    adc #$03
    sta Packet
    bcc FindDialogueGroup
    inc Packet+1
    jmp FindDialogueGroup
GroupMissing:
    lda #$FF
    rts

; 그룹 ID로 글꼴 뱅크와 글자 매핑을 불러옴
SelectFontGroup:
    jsr LoadFontMap
    ldx #$02
    lda $FF
    and #$10
    beq SelectBackgroundSlots
    ldx #$06
SelectBackgroundSlots:
    lda FirstFontBank
    sta $24,x
    lda SecondFontBank
    sta $25,x
    rts

LoadFontMap:
    asl a
    sta RunValue
    asl a
    clc
    adc RunValue
    tay
    lda #$0E
    jsr SetDataBank
    lda ChrCacheGroups+$2000,y
    sta FirstFontBank
    iny
    lda ChrCacheGroups+$2000,y
    sta SecondFontBank
    iny
    lda ChrCacheGroups+$2000,y
    sta MapBank
    iny
    lda ChrCacheGroups+$2000,y
    sta Map
    iny
    lda ChrCacheGroups+$2000,y
    clc
    adc #$20
    sta Map+1
    iny
    lda ChrCacheGroups+$2000,y
    sta MapCount
    rts

; 정렬된 16비트 고유번호를 이진 검색, 레코드 크기는 4바이트
FindGlyph:
    lda MapBank
    jsr SetDataBank
    lda #$00
    sta RunValue
    lda MapCount
    sta RunStep
GlyphSearch:
    lda RunValue
    cmp RunStep
    bcs GlyphMissing
    clc
    adc RunStep
    lsr a
    sta Control
    asl a
    asl a
    tay
    lda (Map),y
    cmp CharacterHigh
    bcc GlyphRight
    bne GlyphLeft
    iny
    lda (Map),y
    cmp CharacterLow
    bcc GlyphRight
    bne GlyphLeft
    iny
    lda (Map),y
    sta UpperTile
    iny
    lda (Map),y
    sta LowerTile
    rts
GlyphLeft:
    lda Control
    sta RunStep
    jmp GlyphSearch
GlyphRight:
    lda Control
    clc
    adc #$01
    sta RunValue
    jmp GlyphSearch
GlyphMissing:
    lda #$01
    sta Error
    lda #$FE
    sta UpperTile
    lda #$FF
    sta LowerTile
    rts

; $B8C1 -> CallTextHandler(0) -> ProcessDialogue
ProcessDialogue:
    lda #$00
    sta $D5
    sta Error
    lda $78
    sta ScriptPointer
    lda $79
    sta ScriptPointer+1
    lda #(DialogueLinks & $FF)
    sta Packet
    lda #(DialogueLinks / $100)
    sta Packet+1
    jsr FindDialogueGroup
    cmp #$FF
    bne TextGroupFound
    lda #$02
    sta Error
    jmp TextEnd
TextGroupFound:
    jsr SelectFontGroup
    clc
    lda $78
    adc $7A
    sta ScriptPointer
    lda $79
    adc #$00
    sta ScriptPointer+1
    jsr ReadScriptByte
    inc $7A
    cmp #$FC
    bcc TextGlyph
    jmp TextControl
TextGlyph:
    sta CharacterHigh
    jsr ReadScriptByte
    inc $7A
    sta CharacterLow
    jsr FindGlyph
    lda $7D
    sta TileAddress
    lda $7E
    sta TileAddress+1
    jsr QueueGlyph
    inc $7D
    bne TextSound
    inc $7E
TextSound:
    lda $CE
    bne TextQuiet
    lda CharacterHigh
    cmp #$80
    bne TextAudible
    lda CharacterLow
    beq TextQuiet
TextAudible:
    lda #$01
    rts
TextQuiet:
    lda #$00
    rts
TextControl:
    sta $D5
    cmp #$FC
    beq TextJump
    cmp #$FD
    beq TextQuiet
    cmp #$FE
    beq TextNewline
TextEnd:
    lda #$FF
    sta $D5
    inc $7F
    inc $77
    jmp TextQuiet
TextJump:
    jsr ReadScriptByte
    sta CharacterLow
    jsr ReadScriptByte
    sta $79
    lda CharacterLow
    sta $78
    lda #$00
    sta $7A
    ; 원본 $04의 FC 처리는 원래 뱅크를 읽으므로, 주소 처리 후 PAGE로 반환.
    lda #$FD
    sta $D5
    jmp TextQuiet
TextNewline:
    clc
    lda $7B
    adc #$40
    sta $7B
    sta $7D
    lda $7C
    adc #$00
    sta $7C
    sta $7E
    jmp TextQuiet

ReserveBuffer:
    clc
    adc $1E
    bcs ReserveFlush
    cmp #$A0
    bcc ReserveDone
ReserveFlush:
    lda #$01
    sta FlushRequested
ReserveWait:
    lda FlushRequested
    bne ReserveWait
ReserveDone:
    rts
WriteBuffer:
    ldy $1E
    sta $0300,y
    inc $1E
    rts
FlushBuffer:
    lda FlushRequested
    beq FlushDone
    jsr $FE52
    jsr $C83F
    lda $FE
    sta $2001
    lda #$00
    sta FlushRequested
FlushDone:
    rts

DrawInterface:
    lda #$00
    sta Error
    lda #$0B
    jsr SetDataBank
    lda InterfaceCommand
    asl a
    tay
    lda #$00
    adc #$FF
    sta Mask
    lda $A8A4,y
    sta ScriptPointer
    lda $A8A5,y
    sta ScriptPointer+1
    ; 번역 UI 호출 지점에서만 진입
    lda InterfaceCommand
    and #$7F
    tax
    lda InterfaceGroups,x
    cmp #$FF
    bne InterfaceTranslated
    lda #$02
    sta Error
    rts
InterfaceTranslated:
    cmp #$80
    beq InterfaceCurrentMap
    jsr SelectFontGroup
    jmp ProcessInterface
InterfaceCurrentMap:
    jsr LoadCurrentFontMap
ProcessInterface:
    lda #$00
    sta Count
InterfaceHeader:
    lda #$00
    sta InterfaceHasText
    lda #$01
    sta TileDirection
    jsr ReadScriptByte
    cmp #$02
    bne UiAddress
    lda #$20
    sta TileDirection
    jsr ReadScriptByte
UiAddress:
    sta TileAddress
    jsr ReadScriptByte
    sta TileAddress+1
ReadInterface:
    jsr ReadScriptByte
    cmp #$FE
    beq UiNextHeader
    cmp #$FD
    bcs UiDone
    cmp #$FB
    beq UiRepeat
    cmp #$FC
    beq UiRepeat
    cmp #$80
    bcc UiTile
    cmp #$8D
    bcs UiTile
    sta CharacterHigh
    jsr ReadScriptByte
    sta CharacterLow
    jsr FindGlyph
    lda UpperTile
    and Mask
    sta UpperTile
    lda LowerTile
    and Mask
    sta LowerTile
    lda #$01
    sta InterfaceHasText
    jsr BufferInterfaceGlyph
    jmp UiAdvance
UiTile:
    and Mask
    jsr BufferInterfaceTile
UiAdvance:
    lda TileDirection
    jsr MoveInterfaceCursor
    jmp ReadInterface
UiRepeat:
    and #$01
    sta RunStep
    jsr ReadScriptByte
    sta RunCount
    jsr ReadScriptByte
    and Mask
    sta RunValue
UiRepeatLoop:
    lda RunCount
    beq ReadInterface
    lda RunValue
    jsr BufferInterfaceTile
    clc
    lda RunValue
    adc RunStep
    sta RunValue
    lda TileDirection
    jsr MoveInterfaceCursor
    dec RunCount
    jmp UiRepeatLoop
UiNextHeader:
    jsr CommitInterface
    jmp InterfaceHeader
UiDone:
    jsr CommitInterface
    lda #$00
    rts
MoveInterfaceCursor:
    clc
    adc TileAddress
    sta TileAddress
    bcc UiMoved
    inc TileAddress+1
UiMoved:
    rts

BufferInterfaceTile:
    sta LowerTile
    lda #$00
    sta UpperTile
BufferInterfaceGlyph:
    lda TileDirection
    cmp #$01
    beq UiHorizontal
    lda InterfaceHasText
    bne UiVerticalGlyph
    lda LowerTile
    jmp QueueTile
UiVerticalGlyph:
    sec
    lda TileAddress
    sbc #$20
    sta TileAddress
    lda TileAddress+1
    sbc #$00
    sta TileAddress+1
    jsr QueueGlyph
    lda #$20
    jmp MoveInterfaceCursor
UiHorizontal:
    lda Count
    bne UiAppend
    lda #$28
    jsr ReserveBuffer
    lda $1E
    sta Packet
    tax
    lda #$04
    sta $0300,x
    sta $0314,x
    lda TileAddress
    sta $0315,x
    sec
    sbc #$20
    sta $0301,x
    lda TileAddress+1
    sta $0316,x
    sbc #$00
    sta $0302,x
UiAppend:
    lda Packet
    clc
    adc Count
    tax
    lda UpperTile
    sta $0304,x
    lda LowerTile
    sta $0318,x
    inc Count
    lda Count
    cmp #$10
    beq CommitInterface
    rts

; 이미 읽은 타일을 두 개의 연속 행 패킷으로 묶어서 문자열 다시 읽지 않음
CommitInterface:
    lda Count
    bne UiCommitRows
    rts
UiCommitRows:
    ldx Packet
    sta $0303,x
    sta $0317,x
    clc
    adc #$04
    sta Control
    lda InterfaceHasText
    beq UiLowerRowOnly
    txa
    clc
    adc Control
    tax
UiLowerRowOnly:
    lda Packet
    clc
    adc #$14
    tay
UiCompact:
    lda $0300,y
    sta $0300,x
    iny
    inx
    dec Control
    bne UiCompact
    stx $1E
    lda #$00
    sta Count
    rts

; 8×16 글자 출력, 좌표와 타일만 받음
QueueGlyph:
    lda #$06
    jsr ReserveBuffer
    lda #$02
    jsr WriteBuffer
    lda TileAddress
    jsr WriteBuffer
    lda TileAddress+1
    jsr WriteBuffer
    lda UpperTile
    jsr WriteBuffer
    lda LowerTile
    jsr WriteBuffer
    lda #$FF
    jsr WriteBuffer
    rts

QueueTile:
    pha
    lda #$05
    jsr ReserveBuffer
    lda #$04
    jsr WriteBuffer
    lda TileAddress
    jsr WriteBuffer
    lda TileAddress+1
    jsr WriteBuffer
    lda #$01
    jsr WriteBuffer
    pla
    jmp WriteBuffer


DrawNumber:
    sta CommandState
    ldx $19
    cpx #$06
    bcc NumbersGroup
    lda #$04
    sta Error
    lda #$00
    rts
NumbersGroup:
    jsr LoadCurrentFontMap
    lda #$00
    sta Packet
NumbersPosition:
    lda #$04
    jsr SetDataBank
    lda #$A3
    sta ScriptPointer
    lda #$AB
    sta ScriptPointer+1
    lda #$03
    sta Count
    lda CommandState
    cmp #$03
    bne NumberAddress
    lda #$1D
    sta ScriptPointer
    lda #$AC
    sta ScriptPointer+1
    dec Count
NumberAddress:
    lda $19
    asl a
    clc
    adc Packet
    tay
    lda (ScriptPointer),y
    beq NumbersDone
    sta TileAddress
    iny
    lda (ScriptPointer),y
NumbersPositionHi:
    sta TileAddress+1
    sec
    lda TileAddress
    sbc #$20
    sta TileAddress
    lda TileAddress+1
    sbc #$00
    sta TileAddress+1
    lda #$00
    sta CharacterIndex
NumberDigit:
    lda CommandState
    cmp #$03
    beq LifeDigit
    ldx CharacterIndex
    cpx #$02
    beq CounterUnits
    lda $DB,x
    and #$0F
    jmp NumberEncode
CounterUnits:
    lda InterfaceCommand
    jmp NumberEncode
LifeDigit:
    lda $32
    ldx CharacterIndex
    bne LifeUnits
    lsr a
    lsr a
    lsr a
    lsr a
LifeUnits:
    and #$0F
NumberEncode:
    clc
    adc #$0F
    sta CharacterLow
    lda #$83
    sta CharacterHigh
    jsr FindGlyph
    jsr QueueGlyph
    inc TileAddress
    bne NumberNext
    inc TileAddress+1
NumberNext:
    inc CharacterIndex
    dec Count
    bne NumberDigit
    lda Packet
    bne NumbersDone
    lda #$0C
    sta Packet
    jmp NumbersPosition
NumbersDone:
    lda InterfaceCommand
    ora #$F0
    rts

UpdatePassword:
    lda #$00
    sta CommandState
    sta Error
    lda $F8
    and #$10
    beq PasswordEditing
    jmp PasswordCheck
PasswordEditing:
    lda #$13
    jsr SelectFontGroup
    ldx $DB
    lda $FA
    and #$0C
    beq PasswordCursor
    sta Mask
    and $F8
    beq PasswordRepeat
    sta $DD
    sta $DC
PasswordRepeat:
    inc $DC
    bne PasswordRepeatReady
    lda #$FF
    sta $DD
PasswordRepeatReady:
    lda $DC
    ldy $DD
    bne PasswordRepeatFast
    cmp #$80
    bcc PasswordBlink
PasswordRepeatFast:
    and #$07
    bne PasswordBlink
    lda Mask
    and #$08
    beq PasswordNextCharacter
    lda $D8,x
    beq PasswordWrapLast
    dec $D8,x
    jmp PasswordChanged
PasswordWrapLast:
    lda #PasswordCharacterCount-1
    sta $D8,x
    jmp PasswordChanged
PasswordNextCharacter:
    inc $D8,x
    lda $D8,x
    cmp #PasswordCharacterCount
    bcc PasswordChanged
    lda #$00
    sta $D8,x
PasswordChanged:
    lda #$22
    sta CommandState
    jmp PasswordBlink
PasswordCursor:
    lda $F8
    and #$03
    beq PasswordBlink
    lsr a
    bcc PasswordCursorLeft
    cpx #$02
    beq PasswordBlink
    inc $DB
    jmp PasswordCursorMoved
PasswordCursorLeft:
    cpx #$00
    beq PasswordBlink
    dec $DB
PasswordCursorMoved:
    lda #$00
    sta $DC
    sta $DD
    lda #$4D
    sta CommandState
    lda $D8,x
    jmp PasswordPaint
PasswordBlink:
    lda $1B
    and #$04
    beq PasswordPaint
    lda $D8,x
PasswordPaint:
    stx CharacterIndex
    asl a
    tay
    lda PasswordCharacters,y
    sta CharacterHigh
    lda PasswordCharacters+1,y
    sta CharacterLow
    jsr FindGlyph
    lda CharacterIndex
    asl a
    clc
    adc #$6A ; 입력 글자 시작 위치: $216A
    sta TileAddress
    lda #$21
    sta TileAddress+1
    jsr QueueGlyph
    lda CommandState
    rts

PasswordCheck:
    ldy #$00
    lda #$00
    sta $3C
PasswordCheckWord:
    lda #$00
    sta Mask
    ldx #$00
PasswordCheckCharacter:
    lda PasswordAnswers,y
    cmp $D8,x
    beq PasswordCheckNext
    dec Mask
PasswordCheckNext:
    inx
    iny
    cpx #$03
    bcc PasswordCheckCharacter
    lda Mask
    beq PasswordAccepted
    inc $3C
    cpy #$15
    bcc PasswordCheckWord
    lda #$00
    sta $3C
PasswordAccepted:
    lda #$00
    sta $34
    rts

; 숫자는 현재 선택된 CHR의 map을 사용
LoadCurrentFontMap:
    ldx #$02
    lda $FF
    and #$10
    beq VisibleSlots
    ldx #$06
VisibleSlots:
    lda $24,x
    sec
    sbc #$80
    lsr a
    jmp LoadFontMap

; 사다리 고정 문구
DrawAmidaLabels:
    lda #$3C
    sta $24
    lda #$3D
    sta $25
    lda #$00
    jsr SelectFontGroup
    lda #$FF
    sta Mask
    lda #(Ui_AmidaBoard & $FF)
    sta ScriptPointer
    lda #(Ui_AmidaBoard / $100)
    sta ScriptPointer+1
    jsr ProcessInterface
    lda #(Ui_AmidaCourseLabels & $FF)
    sta ScriptPointer
    lda #(Ui_AmidaCourseLabels / $100)
    sta ScriptPointer+1
    jmp ProcessInterface


; 빙글빙글 복권 창
DrawLotteryFrame:
    lda #$36
    sta $24
    lda #$37
    sta $25
    lda #$04
    jsr SelectFontGroup
    lda #$FF
    sta Mask
    lda #(Ui_LotteryFrameA & $FF)
    sta ScriptPointer
    lda #(Ui_LotteryFrameA / $100)
    sta ScriptPointer+1
    jsr ProcessInterface
    lda #(Ui_LotteryFrameB & $FF)
    sta ScriptPointer
    lda #(Ui_LotteryFrameB / $100)
    sta ScriptPointer+1
    jmp ProcessInterface


; 복권 결과 지우기
CompleteLotteryClear:
    ldx $1E
    lda #(($2000 + ($10 * $20) + $12) / $100)
    sta $0307,x
    lda #(($2400 + ($10 * $20) + $12) / $100)
    sta $0311,x
    txa
    clc
    adc #$14
    sta $1E
    rts

; 대사창 지우기
SetDialogueClearArea:
    lda $19
    cmp #$03
    bne OriginalClearArea
    lda #(($2000 + ($03 * $20) + $12) & $FF)
    sta $7B
    lda #(($2000 + ($03 * $20) + $12) / $100)
    sta $7C
    lda #$06
    rts
OriginalClearArea:
    asl a
    tay
    lda #$04
    jsr SetDataBank
    lda $A31A,y
    sta $7B
    lda $FF
    lsr a
    lda $A31B,y
    bcc ClearAreaReady
    ora #$04
ClearAreaReady:
    sta $7C
    lda #$04
    rts

.include "code_cave\dialogue_links.asm"
.include "code_cave\password_tables.asm"
.include "code_cave\bos_rush.asm"
.include "code_cave\status_panel.asm"
