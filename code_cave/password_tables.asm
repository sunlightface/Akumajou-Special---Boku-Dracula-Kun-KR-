.definelabel PasswordCharacterCount, 18
PasswordCharacters:
    .db $80, $00 ; 공백
    .db $84, $08 ; 깊
    .db $84, $86 ; 날
    .db $84, $92 ; 내
    .db $85, $13 ; 달
    .db $86, $55 ; 름
    .db $86, $5E ; 린
    .db $86, $EF ; 밤
    .db $87, $18 ; 벽
    .db $87, $5B ; 비
    .db $87, $BD ; 새
    .db $88, $41 ; 슬
    .db $88, $EC ; 여
    .db $89, $5B ; 은
    .db $89, $6D ; 이
    .db $89, $70 ; 일
    .db $8C, $05 ; 한
    .db $8C, $77 ; 흐

PasswordAnswers:
    .db $04, $07, $00 ; 달밤
    .db $01, $0D, $07 ; 깊은밤
    .db $11, $06, $02 ; 흐린날
    .db $0E, $0B, $09 ; 이슬비
    .db $10, $0C, $05 ; 한여름
    .db $03, $0F, $00 ; 내일
    .db $0A, $08, $00 ; 새벽
