.definelabel StaffRoll_ChrFirst, $B6
.definelabel StaffRoll_ChrSecond, $B7
KrStaffRollTiles:
; StaffRoll_Title: 제작진
    .db $0E, $CC, $CA, $D2, $FF
    .db $0E, $CD, $CB, $D3, $FF
    .db $00
; StaffRoll_Programmer: 프로그래머
    .db $08, $F0, $9E, $84, $9A, $A8, $FF
    .db $08, $F1, $9F, $85, $9B, $A9, $FF
    .db $00
; StaffRoll_Murata: 무라타 시로
    .db $0D, $AC, $98, $E2, $FE, $B8, $9E, $FF
    .db $0D, $AD, $99, $E3, $FE, $B9, $9F, $FF
; StaffRoll_Ebisu: 에비스 에츠노부
    .db $0D, $BE, $B2, $B6, $FE, $BE, $D4, $8E, $B0, $FF
    .db $0D, $BF, $B3, $B7, $FE, $BF, $D5, $8F, $B1, $FF
    .db $00
; StaffRoll_Yamamoto: 야마모토 야스히로
    .db $0C, $BC, $A6, $AA, $E6, $FE, $BC, $B6, $F8, $9E, $FF
    .db $0C, $BD, $A7, $AB, $E7, $FE, $BD, $B7, $F9, $9F, $FF
    .db $00
; StaffRoll_CharacterDesigner: 캐릭터 디자이너
    .db $08, $DA, $A4, $E4, $FE, $96, $C8, $C6, $8A, $FF
    .db $08, $DB, $A5, $E5, $FE, $97, $C9, $C7, $8B, $FF
    .db $00
; StaffRoll_Yoshimoto: 요시모토 요이치
    .db $0C, $C2, $B8, $AA, $E6, $FE, $C2, $C6, $D6, $FF
    .db $0C, $C3, $B9, $AB, $E7, $FE, $C3, $C7, $D7, $FF
; StaffRoll_Fujioka: 후지오카 켄지
    .db $0C, $F6, $D0, $C0, $D8, $FE, $DC, $D0, $FF
    .db $0C, $F7, $D1, $C1, $D9, $FE, $DD, $D1, $FF
; StaffRoll_Yanai: 야나이 카즈노리
    .db $0D, $BC, $88, $C6, $FE, $D8, $CE, $8E, $A2, $FF
    .db $0D, $BD, $89, $C7, $FE, $D9, $CF, $8F, $A3, $FF
    .db $00
    .db $00
    .db $10, $5A, $FF
; StaffRoll_Sound: 사운드
    .db $08, $B4, $C4, $94, $FF
    .db $08, $B5, $C5, $95, $FF
; StaffRoll_Tasaka: 타사카 신지
    .db $0D, $E2, $B4, $D8, $FE, $BA, $D0, $FF
    .db $0D, $E3, $B5, $D9, $FE, $BB, $D1, $FF
    .db $00
; StaffRoll_Minami: 미나미 사토코
    .db $0D, $AE, $88, $AE, $FE, $B4, $E6, $DE, $FF
    .db $0D, $AF, $89, $AF, $FE, $B5, $E7, $DF, $FF
    .db $00
    .db $00
    .db $10, $5A, $FF
; StaffRoll_Package: 패키지
    .db $08, $EE, $E0, $D0, $FF
    .db $08, $EF, $E1, $D1, $FF
; StaffRoll_Sumida: 스미다 히로미
    .db $0D, $B6, $AE, $90, $FE, $F8, $9E, $AE, $FF
    .db $0D, $B7, $AF, $91, $FE, $F9, $9F, $AF, $FF
; StaffRoll_Matsuda: 마츠다 히로시
    .db $0D, $A6, $D4, $90, $FE, $F8, $9E, $B8, $FF
    .db $0D, $A7, $D5, $91, $FE, $F9, $9F, $B9, $FF
    .db $00
    .db $00
    .db $10, $5A, $FF
    .db $00
; StaffRoll_PlanningSupport: 기획 협력
    .db $08, $86, $F4, $FE, $F2, $9C, $FF
    .db $08, $87, $F5, $FE, $F3, $9D, $FF
    .db $00
; StaffRoll_Tanaka: 타나카 키미에
    .db $0D, $E2, $88, $D8, $FE, $E0, $AE, $BE, $FF
    .db $0D, $E3, $89, $D9, $FE, $E1, $AF, $BF, $FF
    .db $00
    .db $00
; StaffRoll_PartyCoordinator: 파티 코디네이터
    .db $08, $EC, $E8, $FE, $DE, $96, $8C, $C6, $E4, $FF
    .db $08, $ED, $E9, $FE, $DF, $97, $8D, $C7, $E5, $FF
; StaffRoll_Ebisumaru: 에비스마루
    .db $0D, $BE, $B2, $B6, $A6, $A0, $FF
    .db $0D, $BF, $B3, $B7, $A7, $A1, $FF
    .db $00
; StaffRoll_Planner: 기획
    .db $08, $86, $F4, $FF
    .db $08, $87, $F5, $FF
    .db $00
; StaffRoll_PlannerName: 요시모토 요이치
    .db $0C, $C2, $B8, $AA, $E6, $FE, $C2, $C6, $D6, $FF
    .db $0C, $C3, $B9, $AB, $E7, $FE, $C3, $C7, $D7, $FF
    .db $00
; StaffRoll_Director: 감독
    .db $08, $80, $92, $FF
    .db $08, $81, $93, $FF
    .db $00
; StaffRoll_DirectorName: 무라타 시로
    .db $0D, $AC, $98, $E2, $FE, $B8, $9E, $FF
    .db $0D, $AD, $99, $E3, $FE, $B9, $9F, $FF
    .db $00
    .db $00
    .db $00
    .db $10, $5A, $FF
    .db $00
    .db $00
    .db $00
; StaffRoll_Production: 기획 제작
    .db $0D, $86, $F4, $FE, $CC, $CA, $FF
    .db $0D, $87, $F5, $FE, $CD, $CB, $FF
    .db $00
; StaffRoll_Team: 팀
    .db $08, $EA, $FE, $FE, $FE, $68, $69, $4C, $4D, $4E, $4F, $6E, $6F, $FF
    .db $08, $EB, $FE, $FE, $FE, $78, $79, $5C, $5D, $5E, $5F, $7E, $7F, $FF
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
; StaffRoll_PresentedBy: 제공
    .db $0F, $CC, $82, $FF
    .db $0F, $CD, $83, $FF
    .db $00
    .db $FD
    .db $00
    .db $0F, $04, $05, $06, $FF
    .db $0F, $14, $15, $16, $FF
    .db $0D, $07, $08, $09, $0A, $0B, $0C, $FF
    .db $0D, $17, $18, $19, $1A, $1B, $1C, $FF
    .db $0E, $0D, $0E, $0F, $FF
    .db $0E, $1D, $1E, $1F, $FF
    .db $0D, $02, $03, $10, $11, $12, $13, $FF
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
    .db $FE
