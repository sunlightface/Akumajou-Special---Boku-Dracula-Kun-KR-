; 하단 정보창: $2700부터 6줄. 글꼴은 네 번째 CHR 슬롯의 $C0~$FF
.definelabel StatusAddress, $07
.definelabel StatusLength,  $08
.definelabel StatusHalf,    $09
.definelabel StatusTiles,   $0A
.definelabel StatusValue,   $10

; $15=초기 화면, $16=메달 수, $17=잔기/스테이지, $18=스킬명.
RunStatusCommand:
    cmp #$15
    beq InitializeStatusPanel
    cmp #$16
    bne StatusNumberCommand
    jmp DrawMedalCount
StatusNumberCommand:
    cmp #$17
    bne StatusSkillCommand
    jmp DrawStatusNumbers
StatusSkillCommand:
    jmp DrawSkillName

; 스테이지 로딩 중, 화면 표시를 켜기 전에 작성한다.
InitializeStatusPanel:
    lda #$00
    sta $9000
    jsr $C83F
    lda $FF
    and #$7B ; 화면을 끈 상태에서 PPU 주소를 한 칸씩 증가
    sta $2000
    lda $2002
    lda #$27
    sta $2006
    lda #$00
    sta $2006
    ldx #$00
StatusFrameLoop:
    lda StatusFrame,x
    sta $2007
    inx
    cpx #$C0
    bne StatusFrameLoop
    lda #$27
    sta $2006
    lda #$F0
    sta $2006
    lda #$00
    ldx #$10
StatusAttributeLoop:
    sta $2007
    dex
    bne StatusAttributeLoop
    sta $60 ; A=0: 원본의 하트, 팔레트 교대 갱신을 하트부터 시작
    jsr $C525
    jsr $C5A1
    jsr $C83F
    lda $23
    sta $9000
    rts

DrawMedalCount:
    lda $5E
    jsr StatusDigit
    sta StatusTiles
    lda $5D
    lsr a
    lsr a
    lsr a
    lsr a
    jsr StatusDigit
    sta StatusTiles+1
    lda $5D
    and #$0F
    jsr StatusDigit
    sta StatusTiles+2
    lda #$03
    sta StatusLength
    lda #$35 ; $2735: 메달 개수 세 자리
    sta StatusAddress
    jmp DrawStatusText

DrawStatusNumbers:
    lda $00 ; 원본에서 계산한 잔기 BCD 값
    sta StatusValue
    lsr a
    lsr a
    lsr a
    lsr a
    jsr StatusDigit
    sta StatusTiles
    lda StatusValue
    and #$0F
    jsr StatusDigit
    sta StatusTiles+1
    lda #$02
    sta StatusLength
    lda #$3B ; $273B: 잔기 두 자리.
    sta StatusAddress
    jsr DrawStatusText
    lda $07DC
    bne StatusStageNumber
    lda $3C
StatusStageNumber:
    clc
    adc #$01
    jsr StatusDigit
    sta StatusTiles
    lda #$01
    sta StatusLength
    lda #$68 ; $2768: 스킬명과 같은 X의 스테이지 번호
    sta StatusAddress
    jmp DrawStatusText

StatusDigit:
    asl a
    clc
    adc #$C0
    rts

DrawSkillName:
    lda $AC ; $02~$07: 노멀, 유도탄, 작렬탄, 박쥐, 냉동탄, 거꾸로.
    sec
    sbc #$02
    asl a
    clc
    adc $AC
    sec
    sbc #$02
    tay
    lda #$FE
    sta StatusTiles
    sta StatusTiles+4
    ldx #$00
StatusSkillLoop:
    lda StatusSkillNames,y
    sta StatusTiles+1,x
    iny
    inx
    cpx #$03
    bne StatusSkillLoop
    lda #$05
    sta StatusLength
    lda #$27 ; $2727: 스킬명. 짧은 이름 뒤의 이전 글자도 지운다
    sta StatusAddress
    jmp DrawStatusText
StatusSkillNames:
    .db $E2, $E4, $FE ; 노멀
    .db $E6, $E8, $EA ; 유도탄
    .db $EC, $EE, $EA ; 작렬탄
    .db $F0, $F2, $FE ; 박쥐
    .db $FA, $FC, $EA ; 냉동탄
    .db $F4, $F6, $F8 ; 거꾸로

DrawStatusText:
    lda #$00
    sta StatusHalf
StatusTextRow:
    lda #$01
    jsr $CBF9
    lda StatusAddress
    jsr $CBFB
    lda #$27
    jsr $CBFB
    ldy #$00
StatusTextTile:
    lda StatusTiles,y
    clc
    adc StatusHalf
    jsr $CBFB
    iny
    cpy StatusLength
    bne StatusTextTile
    jsr $C57F
    inc StatusHalf
    lda StatusHalf
    cmp #$02
    beq StatusTextDone
    lda StatusAddress
    clc
    adc #$20
    sta StatusAddress
    jmp StatusTextRow
StatusTextDone:
    rts

; 각 행은 32칸. X는 타일 단위
; $51=창 내부 공백. $50=창 바깥/아이콘 안의 검정 배경
StatusFrame:
; 1행 PPU $2700 위 테두리
.db $50, $5A																		; X00~01: 바깥 배경/왼쪽 모서리
.db $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C 						; X02~13: 가로 테두리
.db $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C	; X14~29: 가로 테두리
.db $5B, $50																		; X30~31: 오른쪽 모서리/바깥 배경

; 2행 PPU $2720
.db $50, $59, $51																	; X00~02: 바깥 배경/왼쪽 세로선/여백
.db $6D, $6E, $6E, $6F 																; X03~06: 기술 아이콘의 작은 네모
.db $51, $E2, $E4, $51, $51, $51, $51 												; X07~13: 기술명 위쪽과 여백
.db $80, $81, $82, $83 																; X14~17: 얼굴 바탕 1/4
.db $51
.db $D4, $D8, $C0, $C0, $C0 														; X19~23: 메달용 0/=/개수 세 자리 위쪽
.db $51
.db $D6, $D8, $C0, $C0																; X25~28: P/=/잔기 두 자리 위쪽
.db $51
.db $59, $50 																		; X30~31: 오른쪽 세로선/바깥 배경

; 3행 PPU $2740
.db $50, $59, $51																	; X00~02: 바깥 배경/ 왼쪽 세로선/여백
.db $5E, $50, $50, $5F																; X03~06: 기술 아이콘의 작은 네모
.db $51, $E3, $E5, $51, $51, $51, $51												; X07~13: 기술명 아래쪽과 여백
.db $90, $01, $01, $93																; X14~17: 얼굴 바탕 2/4
.db $51
.db $D5, $D9, $C1, $C1, $C1															; X19~23: 메달용 0/=/개수 세 자리 아래쪽
.db $51
.db $D7, $D9, $C1, $C1																; X25~28: P/=/잔기 두 자리 아래쪽
.db $51
.db $59, $50																		; X30~31: 오른쪽 세로선/바깥 배경

; 4행 PPU $2760
.db $50, $59, $51 																	; X00~02: 바깥 배경/왼쪽 세로선/여백
.db $5E, $50, $50, $5F																; X03~06: 기술 아이콘의 작은 네모
.db $51, $C2, $60, $DC, $62, $E0, $51 												; X07~13: 여백/숫자/스테이지 위쪽/공백
.db $A0, $A1, $A2, $A3 																; X14~17: 얼굴 바탕 3/4
.db $51
.db $51, $51, $51, $51, $51, $51, $51, $51, $51, $51, $51							; X19~29: 하트 표시 영역의 초기 공백
.db $59, $50																		; X30~31: 오른쪽 세로선 / 바깥 배경

; 5행 PPU $2780
.db $50, $59, $51																	; X00~02: 바깥 배경/왼쪽 세로선/여백
.db $7D, $7E, $7E, $7F																; X03~06: 기술 아이콘의 작은 네모
.db $51, $C3, $61, $DD, $63, $E1, $51												; X07~13: 여백/숫자/스테이지 아래쪽/공백  
.db $B0, $B1, $B2, $B3																; X14~17: 얼굴 바탕 4/4
.db $51
.db $51, $51, $51, $51, $51, $51, $51, $51, $51, $51, $51							; X19~29: 하트 표시 영역의 초기 공백
.db $59, $50																		; X30~31: 오른쪽 세로선/바깥 배경

; 6행 PPU $27A0 아래 테두리
.db $50, $5C																		; X00~01: 바깥 배경/왼쪽 모서리
.db $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C						; X02~13: 가로 테두리
.db $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C	; X14~29: 가로 테두리
.db $5D, $50																		; X30~31: 오른쪽 모서리/바깥 배경
