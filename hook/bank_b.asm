.bank $0B, $A000

.org $B0A9
    lda #$0A
    jsr CallTextHandler
.org $B13B
    jmp CallInterface

; 시작 메뉴
.org $B0F8
    lda #$0B
    jmp CallTextHandler

; 아래 테두리: $2228부터 가로선 16개.
.org $B0CB
    lda #$28
    jsr $CBFB
    lda #$22
    jsr $CBFB
    lda #$10 ; 가로선 개수
    jsr $CBFB
    lda #$BE ; 가로선 타일
    jsr $CBFB

    ; 기존 CHR 설정 유지
    ldx #$3C
    stx $24
    inx
    stx $25

    nop
    nop
    nop
    nop
    nop
	
; 얼굴 표정 말풍선
.org $AB03
    .db $6F 
.org $AB0D
    .db $6F 
.org $AB18
    .db $6F 
	
.org $AAFA
    .db $4C
.org $AB6C
    .db $4C
.org $AB75
    .db $4C
.org $AB7E
    .db $4C
.org $AB87
    .db $4C
.org $AB90
    .db $4C
.org $AB99
    .db $4C

; 거꾸로, 박쥐 사용 후 말풍선 자리와 얼굴을 함께 복구
.org $A8CC
    .dw RestoreStatusFace
	
; 사용하지 않는 원본 8×8 기술명 자리에 복구 데이터 배치
.org $AB22
RestoreStatusFace:
    .db $4C, $27, $51, $51			; $274C: 말풍선 위쪽을 공백으로.
    .db $F9, $20, $E0, $51			; $276C: 가려진 '지' 위쪽과 여백 복구.
    .db $FE
    .db $6F, $27, $A1, $A2			; $276F: 평상시 얼굴.
    .db $F9, $1F, $FB, $04, $B0, $FF
	
; 얼굴 위 표정 평상, 충전 모두 8픽셀 아래로 배치
.bank $0A, $8000
.org $80A6
    lda #$D7 						; 원본 $CD + 8
