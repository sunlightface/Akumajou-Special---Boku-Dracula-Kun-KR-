.bank $05, $A000

; 원본 $B8C1: LDY $7A / LDA ($78),Y
.org $B8C1
    lda #$00
    jsr CallTextHandler
    beq TextSilent
    lda #$22
    jmp $FE83
TextSilent:
    rts

; 세 입력칸은 선택표의 0번(공백)으로 시작
.org $B990
    lda #$00

.org $B9A2
    lda #$05
    jsr CallTextHandler
    beq PasswordSilent
    jmp $FE83
PasswordSilent:
    rts

; 퀴즈 보기 번호
.org $AE58
    jsr CallInterface

.org $B987
    jmp CallInterface
.org $B99F
    jmp CallInterface

; 여신짱 퀴즈 보기 선택 커서로 픽셀 단위
.org $ADEB
    .db $64 ; X
.org $AEDA
    .db $22 ; Y 시작 값

.org $AF5C
    .db $22, $22 + $10, $22 + $20

; 스태프 롤 시작
.org $BC31
    jsr LoadStaffFont
.org $BE1A
    .dw StaffRollTiles

; 번역 대사를 뱅크 $0F로 옮긴 빈자리에 스태프 롤 확장
; $B249 포인터 표 뒤부터 사용하며 $B78C 엔딩 그림은 보존
.org $B2C5
LoadStaffFont:
    jsr $BDDD
    lda #StaffRoll_ChrFirst
    sta $26
    lda #StaffRoll_ChrSecond
    sta $27
    rts

.definelabel StaffRoll_ChrFirst, $B6
.definelabel StaffRoll_ChrSecond, $B7
StaffRollTiles:

; 제작진
.db $0E, $CC, $CA, $D2, $FF													; 0행: 제작진 위쪽
.db $0E, $CD, $CB, $D3, $FF													; 1행: 제작진 아래쪽

; 프로그래머
.db $08, $F0, $9E, $84, $9A, $A8, $FF										; 2행: 프로그래머 위쪽
.db $08, $F1, $9F, $85, $9B, $A9, $FF										; 3행: 프로그래머 아래쪽
.db $00

; 무라타 시로
.db $0D, $AC, $98, $E2, $FE, $B8, $9E, $FF									; 5행: 무라타 시로 위쪽
.db $0D, $AD, $99, $E3, $FE, $B9, $9F, $FF									; 6행: 무라타 시로 아래쪽

; 에비스 에츠노부
.db $0D, $BE, $B2, $B6, $FE, $BE, $D4, $8E, $B0, $FF						; 7행: 에비스 에츠노부 위쪽
.db $0D, $BF, $B3, $B7, $FE, $BF, $D5, $8F, $B1, $FF						; 8행: 에비스 에츠노부 아래쪽

; 야마모토 야스히로
.db $0C, $BC, $A6, $AA, $E6, $FE, $BC, $B6, $F8, $9E, $FF					; 9행: 야마모토 야스히로 위쪽
.db $0C, $BD, $A7, $AB, $E7, $FE, $BD, $B7, $F9, $9F, $FF					; 10행: 야마모토 야스히로 아래쪽

; 캐릭터 디자이너
.db $08, $DA, $A4, $E4, $FE, $96, $C8, $C6, $8A, $FF						; 11행: 캐릭터 디자이너 위쪽
.db $08, $DB, $A5, $E5, $FE, $97, $C9, $C7, $8B, $FF						; 12행: 캐릭터 디자이너 아래쪽
.db $00																		; 13행: 빈 줄(8픽셀)

; 요시모토 요이치
.db $0C, $C2, $B8, $AA, $E6, $FE, $C2, $C6, $D6, $FF						; 14행: 요시모토 요이치 위쪽
.db $0C, $C3, $B9, $AB, $E7, $FE, $C3, $C7, $D7, $FF						; 15행: 요시모토 요이치 아래쪽

; 후지오카 켄지
.db $0C, $F6, $D0, $C0, $D8, $FE, $DC, $D0, $FF								; 16행: 후지오카 켄지 위쪽
.db $0C, $F7, $D1, $C1, $D9, $FE, $DD, $D1, $FF								; 17행: 후지오카 켄지 아래쪽

; 야나이 카즈노리 — 시작 18행, X=13타일
.db $0D, $BC, $88, $C6, $FE, $D8, $CE, $8E, $A2, $FF						; 18행: 야나이 카즈노리 위쪽
.db $0D, $BD, $89, $C7, $FE, $D9, $CF, $8F, $A3, $FF						; 19행: 야나이 카즈노리 아래쪽
.db $00
.db $10, $5A, $FF															; 21행: 원본 별 장식

; 사운드
.db $08, $B4, $C4, $94, $FF													; 22행: 사운드 위쪽
.db $08, $B5, $C5, $95, $FF													; 23행: 사운드 아래쪽

; 타사카 신지
.db $0D, $E2, $B4, $D8, $FE, $BA, $D0, $FF									; 24행: 타사카 신지 위쪽
.db $0D, $E3, $B5, $D9, $FE, $BB, $D1, $FF									; 25행: 타사카 신지 아래쪽
.db $00

; 미나미 사토코 — 시작 27행, X=13타일
.db $0D, $AE, $88, $AE, $FE, $B4, $E6, $DE, $FF								; 27행: 미나미 사토코 위쪽
.db $0D, $AF, $89, $AF, $FE, $B5, $E7, $DF, $FF								; 28행: 미나미 사토코 아래쪽
.db $00
.db $10, $5A, $FF															; 30행: 원본 별 장식

; 패키지
.db $08, $EE, $E0, $D0, $FF													; 31행: 패키지 위쪽
.db $08, $EF, $E1, $D1, $FF													; 32행: 패키지 아래쪽

; 스미다 히로미
.db $0D, $B6, $AE, $90, $FE, $F8, $9E, $AE, $FF								; 33행: 스미다 히로미 위쪽
.db $0D, $B7, $AF, $91, $FE, $F9, $9F, $AF, $FF								; 34행: 스미다 히로미 아래쪽

; 마츠다 히로시 — 시작 35행, X=13타일
.db $0D, $A6, $D4, $90, $FE, $F8, $9E, $B8, $FF								; 35행: 마츠다 히로시 위쪽
.db $0D, $A7, $D5, $91, $FE, $F9, $9F, $B9, $FF								; 36행: 마츠다 히로시 아래쪽
.db $00
.db $00
.db $10, $5A, $FF															; 39행: 원본 별 장식
.db $00

; 기획 협력
.db $08, $86, $F4, $FE, $F2, $9C, $FF										; 41행: 기획 협력 위쪽
.db $08, $87, $F5, $FE, $F3, $9D, $FF										; 42행: 기획 협력 아래쪽

; 타나카 키미에
.db $0D, $E2, $88, $D8, $FE, $E0, $AE, $BE, $FF								; 43행: 타나카 키미에 위쪽
.db $0D, $E3, $89, $D9, $FE, $E1, $AF, $BF, $FF								; 44행: 타나카 키미에 아래쪽
.db $00

; 파티 코디네이터
.db $08, $EC, $E8, $FE, $DE, $96, $8C, $C6, $E4, $FF						; 46행: 파티 코디네이터 위쪽
.db $08, $ED, $E9, $FE, $DF, $97, $8D, $C7, $E5, $FF						; 47행: 파티 코디네이터 아래쪽

; 에비스마루
.db $0D, $BE, $B2, $B6, $A6, $A0, $FF										; 48행: 에비스마루 위쪽
.db $0D, $BF, $B3, $B7, $A7, $A1, $FF										; 49행: 에비스마루 아래쪽

; 기획
.db $08, $86, $F4, $FF														; 50행: 기획 위쪽
.db $08, $87, $F5, $FF														; 51행: 기획 아래쪽
.db $00

; 요시모토 요이치
.db $0C, $C2, $B8, $AA, $E6, $FE, $C2, $C6, $D6, $FF						; 53행: 요시모토 요이치 위쪽
.db $0C, $C3, $B9, $AB, $E7, $FE, $C3, $C7, $D7, $FF						; 54행: 요시모토 요이치 아래쪽

; 감독 — 시작 55행, X=8타일
.db $08, $80, $92, $FF														; 55행: 감독 위쪽
.db $08, $81, $93, $FF														; 56행: 감독 아래쪽
.db $00

; 무라타 시로
.db $0D, $AC, $98, $E2, $FE, $B8, $9E, $FF									; 58행: 무라타 시로 위쪽
.db $0D, $AD, $99, $E3, $FE, $B9, $9F, $FF									; 59행: 무라타 시로 아래쪽
.db $00
.db $00
.db $10, $5A, $FF															; 62행: 원본 별 장식
.db $00
.db $00
.db $00

; 기획 제작
.db $0D, $86, $F4, $FE, $CC, $CA, $FF										; 66행: 기획 제작 위쪽
.db $0D, $87, $F5, $FE, $CD, $CB, $FF										; 67행: 기획 제작 아래쪽

; 팀
.db $08, $EA, $FE, $FE, $FE, $68, $69, $4C, $4D, $4E, $4F, $6E, $6F, $FF	; 68행: 팀 위쪽 + 원본 제작 그림
.db $08, $EB, $FE, $FE, $FE, $78, $79, $5C, $5D, $5E, $5F, $7E, $7F, $FF	; 69행: 팀 아래쪽 + 원본 제작 그림
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00

; 제공
.db $0F, $CC, $82, $FF														; 80행: 제공 위쪽
.db $0F, $CD, $83, $FF														; 81행: 제공 아래쪽
.db $00
.db $FD																		; 83행: 원본 로고 색상 처리 시작
.db $00
.db $0F, $04, $05, $06, $FF													; 84행: KONAMI 로고
.db $0F, $14, $15, $16, $FF													; 85행: KONAMI 로고
.db $0D, $07, $08, $09, $0A, $0B, $0C, $FF									; 86행: KONAMI 로고
.db $0D, $17, $18, $19, $1A, $1B, $1C, $FF									; 87행: KONAMI 로고
.db $0E, $0D, $0E, $0F, $FF													; 88행: KONAMI 로고
.db $0E, $1D, $1E, $1F, $FF													; 89행: KONAMI 로고
.db $0D, $02, $03, $10, $11, $12, $13, $FF									; 90행: KONAMI 로고
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $00
.db $FE																		; 스태프 롤 종료