.bank $07, $A000
; 플레이어의 보스전 시작 위치
.org $BF29
    lda #$10
    jsr CallTextHandler
    jmp $BF3D

; 원본 잔기 계산 뒤, 잔기와 스테이지 번호를 8×16으로 출력
.org $BF6C
    lda #$17
    jmp CallTextHandler
	
; 기술 아이콘 Y: 원본 $C5에서 10픽셀 아래로
.org $BFC4
    .db $CF
.org $BFC8
    .db $CF
