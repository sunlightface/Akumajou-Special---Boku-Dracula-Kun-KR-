.definelabel BossRushActive, $07FA
.definelabel BossRushPhase,  $07FB
.definelabel BossRushHealth, $07FC
.definelabel BossScrollStart, $07FD

RunBossCommand:
    cmp #$0A
    beq DrawStartMenu
    cmp #$0B
    beq UpdateStartMenu
    cmp #$0C
    bne BossCommandSkill
    jmp StartSelectedGame
BossCommandSkill:
    cmp #$0D
    bne BossCommandPosition
    jmp GetSkillLimit
BossCommandPosition:
    cmp #$0E
    bne BossCommandHealth
    jmp SetStagePosition
BossCommandHealth:
    cmp #$0F
    bne BossCommandPlayer
    jmp SetStageHealth
BossCommandPlayer:
    cmp #$10
    bne BossCommandClear
    jmp SetPlayerPosition
BossCommandClear:
    cmp #$11
    bne BossCommandNext
    jmp CheckBattleEnd
BossCommandNext:
    cmp #$12
    bne BossCommandGameOver
    jmp FinishStage
BossCommandGameOver:
    cmp #$13
    bne BossCommandScroll
    jmp FinishGameOver
BossCommandScroll:
    jmp CheckStageLoaded

DrawStartMenu:
    lda #$00
    sta BossRushActive
    sta BossRushPhase
    sta $34
    lda #$52
    sta InterfaceCommand
    jmp DrawInterface

UpdateStartMenu:
    lda $F8
    bmi AcceptStartMenu
    and #$2C
    beq PaintStartCursor
    and #$08
    bne PreviousStartItem
    inc $34
    lda $34
    cmp #$03
    bcc StartItemChanged
    lda #$00
    beq StoreStartItem
PreviousStartItem:
    lda $34
    bne DecreaseStartItem
    lda #$03
DecreaseStartItem:
    sec
    sbc #$01
StoreStartItem:
    sta $34
StartItemChanged:
    lda #$4D
    jsr $FE83
PaintStartCursor:
    ldy $34
    lda StartCursorY,y
    sta $051E
    tya
    and #$01
    clc
    adc #$33
    sta $0500
    rts
AcceptStartMenu:
    lda #$00
    sta $78
    sta BossRushActive
    lda $34
    cmp #$02
    bne StartMenuAccepted
    lda #$01
    sta BossRushActive
    lda #$00
    sta $34
StartMenuAccepted:
    inc $19
    rts
StartCursorY:
    .db $4C, $64, $7C

StartSelectedGame:
    jsr $C4CD
    sta $19
    sta $23
    sta $34
    lda #$03
    sta $32
    sta $66
    lda BossRushActive
    beq StartSelectedDone
    lda #$00
    sta $32
    sta $3C
    sta $63
    sta BossRushPhase
    lda #$03
    sta BossRushHealth
    lda #$A0
    sta $20
StartSelectedDone:
    rts

GetSkillLimit:
    lda BossRushActive
    beq OriginalSkillLimit
    lda #$05
    rts
OriginalSkillLimit:
    lda $3C
    ldy $1F
    beq ClampSkillLimit
    lda $07DC
ClampSkillLimit:
    cmp #$05
    bcc SkillLimitDone
    lda #$05
SkillLimitDone:
    rts

SetStagePosition:
    lda #$00
    sta BossScrollStart
    lda BossRushActive
    bne SetBossPosition
    ldx $52
    ldy $53
    lda $63
    beq StoreStagePosition
    lda $3C
    cmp #$02
    bne CheckpointPosition
    sta $62
CheckpointPosition:
    ldx $54
    ldy $55
    jmp StoreStagePosition
SetBossPosition:
    ldy $3C
    lda BossScrollOffsets,y
    sta BossScrollStart
    lda BossRoomX,y
    tax
    lda BossRoomY,y
    tay
    lda $3C
    cmp #$08
    bne StoreStagePosition
    lda BossRushPhase
    beq StoreStagePosition
    lda #$01
    sta $94
    lda #$80
    sta BossScrollStart
    ldx #$04
    ldy #$00
StoreStagePosition:
    stx $81
    stx $61
    sty $83
    rts
	
; 스테이지 1~9의 보스 방과 방 안의 가로 스크롤 시작값
BossRoomX:
    .db $01 
    .db $28 
    .db $06 
    .db $10 
    .db $00 
    .db $09 
    .db $00 
    .db $0B 
    .db $01 
BossRoomY:
    .db $00
    .db $00
    .db $03 
    .db $00
    .db $00 
    .db $03 
    .db $00 
    .db $02
    .db $03 
BossScrollOffsets:
    .db $00
    .db $00
    .db $00
    .db $00
    .db $00 
    .db $70 
    .db $00
    .db $80 
    .db $00 

SetStageHealth:
    lda BossRushActive
    beq OriginalStageHealth
    lda #$00
    sta $32
    lda BossRushHealth
    sta $AA
    rts
OriginalStageHealth:
    lda $66
    ldx $07DD
    cpx #$02
    bne StoreStageHealth
    lda #$50
    sta $32
    lda #$7F
StoreStageHealth:
    sta $AA
    rts

SetPlayerPosition:
    lda BossRushActive
    bne SetBossPlayer
    lda #$07
    jsr SetDataBank
    lda $63
    lsr a
    lda $3C
    rol a
    asl a
    tax
    lda $BFA2,x
    sta $053C
    lda $BFA3,x
    sta $051E
    rts
SetBossPlayer:
    lda #$40
    sta $053C
    lda #$80
    sta $051E
    lda $3C
    cmp #$02
    bne BossPlayerFloor
    sta $62
    lda #$70
    sta $FC
    lda #$20
    sta $051E
    rts
BossPlayerFloor:
    cmp #$06
    bne BossPlayerScroll
    lda #$FF
    sta $D0 
    sta $C2
    lda #$48
    sta $87 
    lda #$90
    sta $051E
    lda #$02
    sta $042B
    sta $042C
    lda #$13
    jmp DrawOriginalInterface
BossPlayerScroll:
    cmp #$07
    bne BossPlayerOffset
    lda #$C0
    sta $053C
    rts
BossPlayerOffset:
    cmp #$05
    beq EnterPlatformBoss
    cmp #$08
    bne BossPlayerReady
    lda BossRushPhase
    beq BossPlayerReady
    lda #$90
    sta $053C
    lda #$09
    sta $87
    jmp ResumeRobotEntry
EnterPlatformBoss:
    lda #$80
    sta $053C
    lda #$40
    sta $051E
    lda #$06
    sta $87
AlignBossPosition:
    sec
    lda $0548
    sbc BossScrollStart
    sta $0548
    lda $05A2
    sbc #$00
    sta $05A2
BossPlayerReady:
    rts

ResumeRobotEntry:
    lda #$07
    jsr SetDataBank
    jsr $B1E6
    lda #$0A
    sta $05CD
    lda #$03
    sta $05BB
    lda #$FF
    sta $D3
    lda #$80
    sta $051E
    jmp AlignBossPosition

CheckStageLoaded:
    lda $81
    cmp $61
    bne StageLoadPending
    lda $FD
    cmp BossScrollStart
    bne StageLoadPending
    lda #$0F
    sta $8E
    sta $8F
    lda #$00
    cmp BossScrollStart
    lda #$00
    rts
StageLoadPending:
    lda #$01
    rts

CheckBattleEnd:
    lda BossRushActive
    beq OriginalBattleEnd
    lda #$00
    sta $32
    lda $3C
    cmp #$08
    bne OriginalBattleEnd
    lda BossRushPhase
    bne OriginalBattleEnd
    lda $94
    and #$01
    beq OriginalBattleEnd
    lda $AA
    sta BossRushHealth
    inc BossRushPhase
    lda #$00
    sta $34
    sta $19
    sta $63
    rts
OriginalBattleEnd:
    lda $91
    beq BattleEndDone
    lda $3A
    jmp $CD95
BattleEndDone:
    rts

FinishStage:
    lda #$00
    sta $19
    sta $34
    lda $3C
    cmp #$08
    beq StartEnding
    lda BossRushActive
    beq OriginalNextStage
    lda $AA
    sta BossRushHealth
    inc $3C
    lda $3C
    cmp #$04
    bne NextBossReady
    inc $3C
NextBossReady:
    lda #$00
    sta $63
    sta $1F
    sta $23
    sta $77
    sta BossRushPhase
    lda #$03
    sta $18
    rts
OriginalNextStage:
    inc $18
    rts
StartEnding:
    lda #$08
    sta $18
    rts

FinishGameOver:
    lda BossRushActive
    beq DrawGameOver
    lda #$00
    sta BossRushActive
    sta BossRushPhase
    sta $19
    sta $34
    lda #$01
    sta $18
DrawGameOver:
    lda #$06

DrawOriginalInterface:
    tay
    lda $2C
    pha
    lda #$10
    sta $2C
    lda #$11
    jsr SetDataBank
    tya
    jsr $CB4C
    pla
    sta $2C
    rts
