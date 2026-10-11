.bank $04, $8000

; 뒤집고 땡땡은 대사창 내부 6행, 나머지는 원래 대사 위치부터 4행을 지우기
; 지울 시작 주소와 행 수를 설정한 뒤 원본 지우기 루프를 사용
.org $81F7
    lda #$09
    jsr CallTextHandler
    tay
    jmp $8210

; 사다리 화면의 CHR 설정과 고정 문구 출력.
.org $80DA
    lda #$06
    jsr CallTextHandler
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

; 복권 결과 글자를 지울 때 8×16 글자의 위, 아래 두 행을 모두 지우기
; 첫 화면과 스크롤용 두 번째 화면에 함께 적용
.org $8FA9
    lda #(($2000 + ($0F * $20) + $12) & $FF)
.org $8FB1
    lda #(($2000 + ($10 * $20) + $12) & $FF)
.org $8FE5
    lda #$08
    jsr CallTextHandler
    nop

; 미니게임의 메달 수, 검 개수, 남은 횟수를 8×16 숫자로 출력
.org $8B48
    sta InterfaceCommand
    stx $DD
    lda #$02
    jsr CallTextHandler
    ldx $DD
    rts

; 남은 잔기: $32의 BCD 두 자리를 출력
.org $8BBB
    stx $DD
    tya
    pha
    lda #$03
    jsr CallTextHandler
    pla
    tay
    ldx $DD
    rts

.org $86D1
    jsr CallInterface
.org $88BB
    jsr CallInterface
.org $8954
    jsr CallInterface
.org $9061
    jmp CallInterface
.org $906C
    jmp CallInterface
.org $90DA
    jsr CallInterface
.org $92F1
    jmp CallInterface
.org $9738
    jsr CallInterface
.org $993D
    jsr CallInterface
.org $9945
    jsr CallInterface
.org $9952
    jsr CallInterface
.org $9990
    jmp CallInterface
.org $99A2
    jmp CallInterface
.org $99B3
    jsr CallInterface
.org $99BB
    jmp CallInterface
	
; 뒤집고 땡땡 빨단 점 선택 커서 조정
.org $9A78
ColorCursorX:
.db $92, $92, $CB, $CB, $CB
.org $9A7D
ColorCursorY:
.db $1C, $2C, $1C, $2C, $3C

; 각 미니게임의 첫 화면에 사용할 글꼴 그룹 지정
; 돌리고 퐁!
.org $86B4
    ldx #$86		

; 빙글빙글 복권
.org $8D15
    lda #$07
    jsr CallTextHandler
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

; 푹하고 한 방
.org $9318
    ldx #$8A

; 뒤집고 땡땡
.org $981B
    ldx #$8C

; 대사 시작 좌표, MinigameCommon도 해당 게임의 좌표에서 출력됨
.org $831E
SpinDialoguePosition:
.dw $2000 + ($11 * $20) + $17 ; $2237

.org $8320
ColorDialoguePosition:
.dw $2000 + ($03 * $20) + $12 ; $2072

.org $8322
LotteryDialoguePosition:
.dw $2000 + ($0B * $20) + $12 ; $2172

.org $8324
StabDialoguePosition:
.dw $2000 + ($17 * $20) + $08 ; $22E8

;동적 숫자 좌표
.org $8BA7
SpinNumberPosition:
.dw $2000 + ($04 * $20) + $18 ; $2098
.org $8C21
SpinLivesPosition:
.dw $2000 + ($08 * $20) + $19 ; $2119

.org $8BA9
ColorNumberPosition:
.dw $2000 + ($06 * $20) + $13 ; $20D3
.org $8C23
ColorLivesPosition:
.dw $2000 + ($06 * $20) + $1A ; $20DA

.org $8BAB
LotteryNumberPositionA:
.dw $2000 + ($0E * $20) + $13 ; $21D3
.org $8C25
LotteryLivesPositionA:
.dw $2000 + ($0E * $20) + $1A ; $21DA

.org $8BAD
StabNumberPosition:
.dw $2000 + ($19 * $20) + $0B ; $232B
.org $8C27
StabLivesPosition:
.dw $2000 + ($19 * $20) + $14 ; $2334

.org $8BB7
LotteryNumberPositionB:
.dw $2400 + ($0E * $20) + $13 ; $25B3
.org $8C31
LotteryLivesPositionB:
.dw $2400 + ($0E * $20) + $1A ; $25BA
