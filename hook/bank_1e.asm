.bank $1E, $C000

; 번역된 결과 메시지 호출만 연결, 공통 $CB4C는 원본 유지
.org $C456
    jmp CallInterface
.org $D022
    jmp CallInterface

; 결과 메시지의 캐시를 원본 폰트 대신 선택
.org $C44D
    ldx #$A8

; 선택한 모드로 새 게임 시작
.org $C475
    lda #$0C
    jsr CallTextHandler
    jmp $C484
; 기술 선택 상한
.org $CD36
    lda #$0D
    jsr CallTextHandler
    jmp $CD45
; 스테이지 시작 위치
.org $CF13
    lda #$0E
    jsr CallTextHandler
    jmp $CF2D
; 새 구간의 체력
.org $CC28
    lda #$0F
    jsr CallTextHandler
    jmp $CC39
; 보스 격파 확인과 화염사자 다음 구간
.org $CD8F
    lda #$11
    jmp CallTextHandler
; 클리어 후 다음 보스 또는 원본 엔딩
.org $CE0C
    lda #$12
    jmp CallTextHandler
; 보스 러쉬 사망 시 시작 메뉴로 복귀
.org $CDF9
    lda #$13
    jmp CallTextHandler

; 보스 방 안의 스크롤 위치까지 원본 방식으로 화면을 채움
.org $CC6A
    lda #$14
    jsr CallTextHandler
    bne $CC4A
    bcc StageTilesReady
    ror $FD
    asl $89
    jsr $D5CC
FillInitialCollision:
    jsr $E478
    sec
    lda $FD
    sbc #$08
    sta $FD
    bne FillInitialCollision
StageTilesReady:
    jmp $CC8B

; 로딩 중 정보창을 6줄로 작성하고 체력, 메달 수를 표시
.org $CCB1
    lda #$15
    jsr CallTextHandler
    nop
; 하트 두 줄을 8픽셀 아래로 이동
.org $C53F
    ldy #$73
.org $C546
    ldy #$93
; 메달 개수: 원본 BCD 계산 후 8×16으로 출력.
.org $C5B2
    lda #$16
    jsr CallTextHandler
    jmp $C5DC
; 기술 선택, 일시정지 해제, 변신 해제 시 같은 스킬명 출력
.org $CD50
    lda #$18
    jmp CallTextHandler
.org $CE92
    lda #$18
    jsr CallTextHandler
    nop
    nop
    nop
.org $DCE1
    lda #$18
    jsr CallTextHandler
    nop
    nop
    nop
; 정보창 IRQ: 네 번째 CHR 슬롯은 $BA/$BB. 앞의 세 슬롯은 원본 유지.
; 원본과 같은 32사이클 뒤에 $D0E3의 화면 분할을 실행
.org $D0CB
    lda $2D
    lsr a
    lsr a
    ora #$0A
    sta $C008
    lda #$0B
    sta $C00C
    nop
    nop
    nop
    nop
    nop
    jmp $D0E3

; 정보창 6행을 첫 픽셀부터 표시. $27은 세로 미세 스크롤이 2라 하단이 넘어감
.org $D0E3
    lda #$07 ; 타일 위치는 $2700 그대로, 세로 미세 스크롤만 0
