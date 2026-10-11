.bank $1F, $E000

; carry=1로 시작해서 적 생성 금지 플래그($21)를 우회
.org $FF6E
    sec
    jmp $FF76

.org $FDA3
    jsr PrepareScreenUpdate

.org $FDDA
    jsr RestoreDataBank
    jmp $FD9D

.org $FFA8
CallInterface:
    sta InterfaceCommand
    ldx $2C
    lda #$01
    bne SaveCallerBank
CallTextHandler:
    tay
    lda $8000
    asl a
    tax
    tya
SaveCallerBank:
    tay
    txa
    pha
    lda #$0F
    sta DataBank
    sta $AFFF
    lda #$10
    sta $8FFF
    tya
    jsr RunTextCommand
    tay
    pla
    tax
    jsr $D5DA
    ldx $1E
    tya
    rts

RestoreDataBank:
    cpx #$10
    bne RestoreBankPair
    ldx DataBank
    dex
RestoreBankPair:
    inx
    stx $AFFF
    rts

PrepareScreenUpdate:
    lda $8000
    cmp #$08
    bne UpdateScroll
    jsr FlushBuffer
UpdateScroll:
    jmp $FDF9
FixedHooksEnd:
