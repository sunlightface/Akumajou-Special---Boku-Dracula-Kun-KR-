.loadtable "kr_table.txt", "utf-8"
.bank 0x04, 0x8000

.org 0x82DC
.dw Amida_01
.dw Amida_01
.dw Amida_01
.dw Amida_01
.dw Amida_01
.dw Amida_01
.dw Amida_01
.dw Amida_01
.dw Amida_01
.dw Amida_02
.dw Amida_03
.dw Amida_04
.dw Amida_05

.bank 0x04, 0x8000

.org 0x8C80
.dw MinigameStab_01
.dw MinigameLottery_01
.dw MinigameSpin_01
.dw MinigameColor_01
.dw MinigameCommon_01
.dw MinigameCommon_02
.dw MinigameColor_04
.dw MinigameColor_02
.dw MinigameColor_03

.bank 0x05, 0xA000

.org 0xB249
.dw BossIntro_01
.dw BossIntro_01
.dw BossIntro_02
.dw BossIntro_03
.dw BossIntro_04
.dw BossAfterBattle_01
.dw BossAfterBattle_02
.dw Ability_01
.dw Ability_02
.dw Ability_03
.dw Ability_04
.dw Ability_05
.dw QuizIntro_01
.dw QuizIntro_02
.dw QuizIntro_03
.dw QuizIntro_04
.dw QuizRules_01
.dw QuizRules_03
.dw QuizRules_04
.dw QuizQuestion02_01
.dw QuizQuestion02_02
.dw QuizAnswer_01
.dw QuizAnswer_02
.dw QuizLose_01
.dw QuizLose_02
.dw QuizLose_03
.dw QuizWin_01
.dw QuizWin_02
.dw QuizRules_02
.dw QuizQuestion03_01
.dw QuizQuestion03_02
.dw QuizQuestion04_01
.dw QuizQuestion04_02
.dw QuizQuestion05_01
.dw QuizQuestion05_02
.dw QuizQuestion06_01
.dw QuizQuestion06_02
.dw QuizQuestion07_01
.dw QuizQuestion07_02
.dw QuizQuestion08_01
.dw QuizQuestion08_02
.dw QuizQuestion09_01
.dw QuizQuestion09_02
.dw QuizQuestion10_01
.dw QuizQuestion10_02
.dw QuizQuestion11_01
.dw QuizQuestion11_02
.dw FinalBoss_01
.dw QuizQuestion01_01
.dw QuizQuestion01_02
.dw QuizQuestion12_01
.dw QuizQuestion12_02
.dw QuizQuestion13_01
.dw QuizQuestion13_02
.dw QuizQuestion14_01
.dw QuizQuestion14_02
.dw EndingEpilogue_01
.dw $B78C 				; おしまい "이야기 끝."으로 이미지라 스크립트로 따로 만들지 않아 기존 포인터만 기재 
.dw EndingStory_01
.dw EndingStory_02
.dw EndingStory_03
.dw FinalBoss_02

.bank 0x0B, 0xA000

.org 0xA8B2
.dw Ui_ResultNothing

.org 0xA8B4
.dw Ui_ColorCounters

.org 0xA8B6
.dw Ui_ColorRewards

.org 0xA8B8
.dw Ui_ColorMiss

.org $A91E
.dw Ui_QuizChoiceNumbers

.org 0xA922
.dw Ui_SpinCounters

.org 0xA924
.dw Ui_SpinWin

.org 0xA926
.dw Ui_SpinMiss

.org 0xA928
.dw Ui_LotteryCountersA

.org 0xA92A
.dw Ui_LotteryMiss

.org 0xA92C
.dw Ui_LotteryWin3

.org 0xA92E
.dw Ui_LotteryWin1

.org 0xA930
.dw Ui_LotteryWin5

.org 0xA932
.dw Ui_LotteryCountersB

.org 0xA936
.dw Ui_GameOver

.org 0xA948
.dw Ui_StartMenu

.org 0xA954
.dw Ui_ColorYellow

.org 0xA956
.dw Ui_ColorGreen

.org 0xA958
.dw Ui_ColorRed

.org 0xA95A
.dw Ui_ColorBlue

.org 0xA95C
.dw Ui_ColorWhite

.org 0xA964
.dw Ui_StabCounters

.org 0xA966
.dw Ui_ColorWin7

.org 0xA968
.dw Ui_ColorWin5

.org 0xA96A
.dw Ui_ColorWin3

.org 0xA96C
.dw Ui_ColorWin3

.org 0xA96E
.dw Ui_ColorWin1

.org 0xA970
.dw Ui_PasswordScreen

.org 0xA972
.dw Ui_PasswordMoon

.org 0xA974
.dw Ui_PasswordDark

.org 0xA976
.dw Ui_PasswordCloud

.org 0xA978
.dw Ui_PasswordRain

.org 0xA97A
.dw Ui_PasswordSummer

.org 0xA97C
.dw Ui_PasswordTomorrow

.org 0xA97E
.dw Ui_PasswordDawn

.org 0xA952
.dw Ui_ColorFrame

.org 0xAF03
Ui_ColorFrame:
.dw $2000 + ($02 * $20) + $11 ; $2051
.db $B0, $FC, $0C, $BE, $B1
.db $FE
.dw $2000 + ($03 * $20) + $11 ; $2071
.db $BD, $FC, $0C, $00, $BD
.db $FE
.dw $2000 + ($04 * $20) + $11 ; $2091
.db $BD, $FC, $0C, $00, $BD
.db $FE
.dw $2000 + ($05 * $20) + $11 ; $20B1
.db $BD, $FC, $0C, $00, $BD
.db $FE
.dw $2000 + ($06 * $20) + $11 ; $20D1
.db $BD, $FC, $0C, $00, $BD
.db $FE
.dw $2000 + ($07 * $20) + $11 ; $20F1
.db $BD, $FC, $0C, $00, $BD
.db $FE
.dw $2000 + ($08 * $20) + $11 ; $2111
.db $BD, $FC, $0C, $00, $BD
.db $FE
.dw $2000 + ($09 * $20) + $11 ; $2131
.db $B2, $FC, $0C, $BE, $B3
.db $FF

.bank $0F, $A000

Amida_01:
.stringn "사다리 타기<NL>사다리 타기<PAGE>뽑기가 즐거운<NL>사다리 타기<END>"

Amida_02:
.stringn "A코스에 당첨됐습니다<NL>돌리고 퐁!에서<PAGE>즐겨 주세요<END>"

Amida_03:
.stringn "B코스에 당첨됐습니다<NL>뒤집고 땡땡에서<JUMP>"
.dw Amida_06

Amida_04:
.stringn "C코스에 당첨됐습니다<NL>빙글빙글 복권에서<JUMP>"
.dw Amida_06

Amida_05:
.stringn "D코스에 당첨됐습니다<NL>푹하고 한 방에서<JUMP>"
.dw Amida_06

Amida_06:
.stringn "즐겨 주세요<END>"

; 네임테이블 한 줄은 32칸($20바이트). X와 Y는 0부터 시작
; PPU 주소에서 시작 주소를 뺀 뒤, $20으로 나누면 몫이 Y, 나머지가 X
; 예시) $2092 - $2000 = $92, Y = $92 / $20 = $04, X = $92 % $20 = $12
; 결과는 $2092 = $2000 + ($04 * $20) + $12
; PPU 주소 = 시작 주소 + (Y * $20) + X
Ui_AmidaBoard:
.dw $2000 + ($04 * $20) + $12	; $2092
.stringn "A코스 돌리고 퐁   "
.db $FE
.dw $2000 + ($06 * $20) + $12	; $20D2
.stringn "B코스 뒤집고 땡땡  "
.db $FE
.dw $2000 + ($08 * $20) + $12	; $2112
.stringn "C코스 빙글빙글 복권 "
.db $FE
.dw $2000 + ($0A * $20) + $12	; $2152
.stringn "D코스 푹하고 한 방 "
.db $FF

Ui_AmidaCourseLabels:
.dw $2000 + ($19 * $20) + $04	; $2324
.db $11, $20
.db $FE
.dw $2000 + ($1A * $20) + $04	; $2344
.db $12, $21
.db $FE
.dw $2000 + ($19 * $20) + $08	; $2328
.db $11, $20
.db $FE
.dw $2000 + ($1A * $20) + $08	; $2348
.db $12, $21
.db $FE
.dw $2000 + ($19 * $20) + $0C	; $232C
.db $11, $20
.db $FE
.dw $2000 + ($1A * $20) + $0C	; $234C
.db $12, $21
.db $FE
.dw $2000 + ($19 * $20) + $10	; $2330
.db $11, $20
.db $FE
.dw $2000 + ($1A * $20) + $10	; $2350
.db $12, $21
.db $FF

Ability_01:
.stringn "유도탄을 배웠어~!<END>"

Ability_02:
.stringn "작렬탄을 배웠다!<END>"

Ability_03:
.stringn "박쥐로 변신할 수 있어~!<END>"

Ability_04:
.stringn "적을 얼리는 냉동탄이다~!<END>"

Ability_05:
.stringn "이제 천장도 걸어 다닐 수 있겠군<END>"

MinigameCommon_01:
.stringn "코인이<NL>부족합니다<PAGE>다음<NL>스테이지에서는<PAGE>많이<NL>모아 주세요!<END>"

MinigameCommon_02:
.stringn "이제 끝<NL>이에요~<PAGE>다음 스테이지도<NL>힘내세요!<END>"

MinigameCommon_03:
.stringn "다음 스테이지도<NL>힘내세요!<END>"

MinigameSpin_01:
.stringn "잔뜩 불려 보자<NL>돌리고 퐁!<PAGE>코인 2개로<NL>메달 1개와<PAGE>교환할 수<NL>있어요<END>"

MinigameLottery_01:
.stringn "돌리기만 하면 돼~<NL>빙글빙글 복권<PAGE>코인 3개로 한 번<NL>돌릴 수 있습니다.<PAGE>십자키로<NL>빙글빙글 돌려 주세요!<END>"	

MinigameStab_01:
.stringn "찌르는 쾌감<NL>푹하고 한 방<PAGE>자, 힘차게 시작해 봅시다!<END>"

MinigameColor_01:
.stringn "색을 맞혀서 1UP<NL>뒤집고 땡땡<PAGE>코인 5개로 한 번<NL>즐길 수 있어요<END>"

MinigameColor_02:                       
.stringn "노랑은 7UP<NL>초록은 5UP<PAGE>빨강, 파랑이면 3UP<NL>하양이면 1UP<PAGE>자, 다음 색은<NL>무슨 색일 것 같아?<END>"

MinigameColor_03:
.stringn "자, 다음 색은<NL>무슨 색일 것 같아?<END>"

MinigameColor_04:
.stringn "재미있게<NL>즐기셨나요?<JUMP>"
.dw MinigameCommon_03

BossIntro_01:
.stringn "으하하하!<NL>하하!<END>"

BossIntro_02:
.stringn "내 이름은 가라모스<NL>지구의 지배자다<END>"

BossIntro_03:
.stringn "어린애 주제에<NL>용케 여기까지 왔구나<NL>드라큘라군<END>"

BossIntro_04: ; 
.stringn "하지만, 그것도<NL>여기까지다<NL>내가 직접 해치워 주마<END>" ; 그것도 [여기까지다]

BossAfterBattle_01:
.stringn "이걸로 이겼다고<NL>생각하지 마라<END>"

BossAfterBattle_02:
.stringn "그럼 또 보자<END>"

QuizIntro_01:
.stringn "잘 왔어<NL>나는<NL>이 스테이지의 보스인<END>"

QuizIntro_02:
.stringn "여신쨩이야<END>"

QuizIntro_03:
.stringn "나는 싸우는 건<NL>싫어하니까<END>"

QuizIntro_04:
.stringn "퀴즈로 승부하자<END>"

QuizRules_01:
.stringn "규칙은 간단해<NL>먼저 3문제를 맞힌<NL>사람이 이기는 거야<END>"

QuizRules_02:
.stringn "하지만 실수하면<NL>라이프를 하나<NL>가져갈 거야<END>"

QuizRules_03:
.stringn "답을 알겠으면<NL>버튼을 눌러 줘<END>"

QuizRules_04:
.stringn "그럼, 문제<END>"

QuizAnswer_01:
.stringn "정답~<END>"

QuizAnswer_02:
.stringn "아쉽네~<END>"

QuizLose_01:
.stringn "네가 졌어<NL>드라큘라쨩<END>"

QuizLose_02:
.stringn "굿바이<NL>드라큘라쨩<END>"

QuizLose_03:
.stringn "너를 잊지 않을게...<END>"

QuizWin_01:
.stringn "네가 이겼어<NL>드라큘라쨩<END>"

QuizWin_02:
.stringn "다음 스테이지로 가 줘<END>"

QuizQuestion01_01:
.stringn "내가 살고 있는<NL>나라는 어디?<END>"

QuizQuestion01_02:
.stringn "브라질<NL>미국<NL>사이타마현<END>"

QuizQuestion02_01:
.stringn "나는 어느 나라에서<NL>온 선물일까?<END>"

QuizQuestion02_02:
.stringn "프랑스<NL>영국<NL>사이타마현<END>"

QuizQuestion03_01:
.stringn "지금 미국인이 가장<NL>많이 쓰는 일본어는?<END>"

QuizQuestion03_02:
.stringn "닌자<NL>닌텐도<NL>세...<END>"

QuizQuestion04_01:
.stringn "다음 섬 중에서 가장<NL>남쪽에 있는 섬은?<END>"

QuizQuestion04_02:
.stringn "하와이<NL>사이판<NL>괌<END>"

QuizQuestion05_01:
.stringn "코나미 게임 음악<NL>밴드의 이름은?<END>"

QuizQuestion05_02:
.stringn "시계 클럽<NL>구형파 클럽<NL>테레프<END>"

QuizQuestion06_01:
.stringn "지금 몇 번째 문제?<END>"

QuizQuestion06_02:
.stringn "4번째<NL>5번째<NL>6번째<END>"

QuizQuestion07_01:
.stringn "2스테이지의 보스는<NL>무엇이었을까요?<END>"

QuizQuestion07_02:
.stringn "얀바루쿠이나군<NL>화성인<NL>니와토리상<END>"

QuizQuestion08_01:
.stringn "기상위성은 히마와리<NL>그럼 방송위성은?<END>"

QuizQuestion08_02:
.stringn "매화<NL>벚꽃<NL>백합<END>"

QuizQuestion09_01:
.stringn "악마성 전설의<NL>주인공 이름은?<END>"

QuizQuestion09_02:
.stringn "시나몬<NL>시몬<NL>랄프<END>"

QuizQuestion10_01:
.stringn "코나미 하면 고베. 다음 중<NL>고베에 없는 것은<NL>어느 것?<END>"

QuizQuestion10_02:
.stringn "이진칸<NL>마린타워<NL>차이나타운<END>"

QuizQuestion11_01:
.stringn "에비스마루라는 녀석이<NL>나왔던 게임은?<END>"

QuizQuestion11_02:
.stringn "힘내라 고에몽<NL>푸얀<NL>고에몽2<END>"

QuizQuestion12_01:
.stringn "내 몸은<NL>무엇으로 만들어졌을까요?<END>"

QuizQuestion12_02:
.stringn "돌<NL>구리<NL>고기<END>"

QuizQuestion13_01:
.stringn "내가 왼손에<NL>들고 있는 것은 무엇?<END>"

QuizQuestion13_02:
.stringn "독립 선언서<NL>퀴즈 문제집<NL>야한 책<END>"

QuizQuestion14_01:
.stringn "1스테이지의 보스는<NL>무엇이었을까요?<END>"

QuizQuestion14_02:
.stringn "마도사 부자<NL>용<NL>니와토리 부자<END>"

FinalBoss_01:
.stringn "잘도 여기까지 왔구나<NL>드라큘라군!<NL>하지만 이 우주의 제왕<END>"

FinalBoss_02:
.stringn "가라모스 킹님에게<NL>맞서는 자에게는<NL>죽음만이 있을 뿐!!<END>"

EndingStory_01:
.stringn "드라큘라군이 가라모스를 쓰러뜨렸다는<NL><NL>소문은 순식간에 마계에 퍼지고...<END>"

EndingStory_02:
.stringn "드라큘라군의 부하가 되고 싶다는 마물들이<NL><NL>점점 늘어났습니다. 그리고...<END>"

EndingStory_03:
.stringn "드라큘라군은 다시 대마왕으로<NL><NL>불리게 되었습니다.<END>"

EndingEpilogue_01:
.stringn "하지만 방심하고 있으면 채찍 쓰는 형아가<NL>     쓰러뜨리러 올지도 몰라.<END>"

StaffRoll_Title:
.stringn "제작진<END>"

StaffRoll_Programmer:
.stringn "프로그래머<END>"

StaffRoll_Murata:
.stringn "무라타 시로<END>"

StaffRoll_Ebisu:
.stringn "에비스 에츠노부<END>"

StaffRoll_Yamamoto:
.stringn "야마모토 야스히로<END>"

StaffRoll_CharacterDesigner:
.stringn "캐릭터 디자이너<END>"

StaffRoll_Yoshimoto:
.stringn "요시모토 요이치<END>"

StaffRoll_Fujioka:
.stringn "후지오카 켄지<END>"

StaffRoll_Yanai:
.stringn "야나이 카즈노리<END>"

StaffRoll_Sound:
.stringn "사운드<END>"

StaffRoll_Tasaka:
.stringn "타사카 신지<END>"

StaffRoll_Minami:
.stringn "미나미 사토코<END>"

StaffRoll_Package:
.stringn "패키지<END>"

StaffRoll_Sumida:
.stringn "스미다 히로미<END>"

StaffRoll_Matsuda:
.stringn "마츠다 히로시<END>"

StaffRoll_PlanningSupport:
.stringn "기획 협력<END>"

StaffRoll_Tanaka:
.stringn "타나카 키미에<END>"

StaffRoll_PartyCoordinator:
.stringn "파티 코디네이터<END>"

StaffRoll_Ebisumaru:
.stringn "에비스마루<END>"

StaffRoll_Planner:
.stringn "기획<END>"

StaffRoll_PlannerName:
.stringn "요시모토 요이치<END>"

StaffRoll_Director:
.stringn "감독<END>"

StaffRoll_DirectorName:
.stringn "무라타 시로<END>"

StaffRoll_Production:
.stringn "기획 제작<END>"

StaffRoll_Team:
.stringn "팀<END>"

StaffRoll_PresentedBy:
.stringn "제공<END>"

; 여신짱 보기 번호 좌표
Ui_QuizChoiceNumbers:
.dw $2400 + ($05 * $20) + $0D	; $24AD
.stringn "1"
.db $FE
.dw $2400 + ($07 * $20) + $0D	; $24ED
.stringn "2"
.db $FE
.dw $2400 + ($09 * $20) + $0D	; $252D
.stringn "3"
.db $FF

Ui_StartMenu:
.db $02
.dw $2000 + ($05 * $20) + $07			; $20A7
.db $B0, $FC, $0B, $BD, $B2, $FE, $02
.dw $2000 + ($05 * $20) + $18			; $20B8
.db $B1, $FC, $0B, $BD, $B3
.db $FE
.dw $2000 + ($09 * $20) + $0C			; $210C
.stringn "처음부터 스타트"
.db $FE
.dw $2000 + ($0C * $20) + $0C			; $216C
.stringn "이어서 스타트"
.db $FE
.dw $2000 + ($0F * $20) + $0C			; $21CC
.stringn "보스 러쉬"
.db $FF

Ui_GameOver:
.dw $2000 + ($0E * $20) + $0F			; $21CF
.stringn "계속하기"
.db $FE
.dw $2000 + ($12 * $20) + $0F			; $224F
.stringn "그만하기"
.db $FF

Ui_PasswordScreen:
.dw $2000 + ($0A * $20) + $09			; $2149 
.stringn "드라큘라군은"
.db $FE
.dw $2000 + ($0C * $20) + $0A 			; $218A
.stringn "      의 차례에"
.db $FE
.dw $2000 + ($0E * $20) + $10 			; $21D0
.stringn "부활한다."
.db $FE
.dw $2000 + ($08 * $20) + $0D 			; $210B
.stringn "부활의 주문"
.db $FE
.dw $2000 + ($0D * $20) + $0A 			; $21AA
.db $BE, $00, $BE, $00, $BE, $FE
.dw $2000 + ($07 * $20) + $08 			; $20E8
.db $BE, $BE, $BE, $BE, $BE, $FE       	; 제목 왼쪽 가로선: 2칸 -> 5칸
.dw $2000 + ($07 * $20) + $13 			; $20F3
.db $BE, $BE, $BE, $BE, $BE, $FE, $02	; 제목 오른쪽 가로선: 2칸 -> 5칸
.dw $2000 + ($07 * $20) + $07			; $20E7 
.db $B0, $FC, $07, $BD, $B2, $FE, $02
.dw $2000 + ($07 * $20) + $18			; $20F8 
.db $B1, $FC, $07, $BD, $B3, $FE
.dw $2000 + ($0F * $20) + $08			; $21E8
.db $FC, $10, $BE
.db $FF

Ui_PasswordMoon:
.dw $2000 + ($0C * $20) + $0A ; $218A 
.stringn "달 밤"
.db $FF

Ui_PasswordDark:
.dw $2000 + ($0C * $20) + $0A ; $218A
.stringn "깊 은 밤"
.db $FF

Ui_PasswordCloud:
.dw $2000 + ($0C * $20) + $0A ; $218A
.stringn "흐 린 날"
.db $FF

Ui_PasswordRain:
.dw $2000 + ($0C * $20) + $0A ; $218A
.stringn "이 슬 비"
.db $FF

Ui_PasswordSummer:
.dw $2000 + ($0C * $20) + $0A ; $218A
.stringn "한 여 름"
.db $FF

Ui_PasswordTomorrow:
.dw $2000 + ($0C * $20) + $0A ; $218A
.stringn "내 일"
.db $FF

Ui_PasswordDawn:
.dw $2000 + ($0C * $20) + $0A ; $218A
.stringn "새 벽"
.db $FF

Ui_StabCounters:
.dw $2000 + ($18 * $20) + $0A ; $230A
.stringn "검"
.db $FE
.dw $2000 + ($19 * $20) + $0E ; $232E
.stringn "자루"
.db $FE
.dw $2000 + ($18 * $20) + $11 ; $2311
.stringn "남은"
.db $FE
.dw $2000 + ($19 * $20) + $16 ; $2336
.stringn "명"
.db $FF

Ui_SpinCounters:
.dw $2000 + ($03 * $20) + $16 ; $2076
.stringn "메달"
.db $FE
.dw $2000 + ($04 * $20) + $1C ; $209C
.stringn "개"
.db $FE
.dw $2000 + ($07 * $20) + $16 ; $20F6
.stringn "남은"
.db $FE
.dw $2000 + ($08 * $20) + $1C ; $211C
.stringn "명"
.db $FE

;따로 포인터가 존재하지 않음 그래서 바로 밑에 이어씀
Ui_SpinTitle:
.dw $2000 + ($07 * $20) + $06 ; $20E6
.stringn "돌리고 "
.db $FE

Ui_SpinFrame:
.dw $2000 + ($09 * $20) + $05 ; $2125
.db $BD
.db $FE
.dw $2000 + ($09 * $20) + $0A ; $212A
.db $BD
.db $FE
.dw $2000 + ($0A * $20) + $05 ; $2145
.db $35, $BE, $BE, $BE, $BE, $36
.db $FE

Ui_SpinPong:
.dw $2000 + ($08 * $20) + $06 ; $2106
.db $2B, $2C, $2D, $2E
.db $FE
.dw $2000 + ($09 * $20) + $06 ; $2126
.db $31, $32, $33, $34
.db $FF

Ui_SpinWin:
.dw $2000 + ($12 * $20) + $18 ; $2258
.stringn "대박 당첨~"
.db $FF

Ui_SpinMiss:
.dw $2000 + ($12 * $20) + $18 ; $2258
.stringn "완전 꽝~"
.db $FF

Ui_ColorCounters:
.dw $2000 + ($04 * $20) + $12 ; $2092
.stringn "앞으로"
.db $FE
.dw $2000 + ($06 * $20) + $16 ; $20D6
.stringn "회"
.db $FE
.dw $2000 + ($04 * $20) + $19 ; $2099
.stringn "남은"
.db $FE
.dw $2000 + ($06 * $20) + $1C ; $20DC
.stringn "명"
.db $FF

Ui_ColorRewards:
.dw $2000 + ($04 * $20) + $13 ; $2093
.stringn "노랑7"
.db $0C
.db $FE
.dw $2000 + ($04 * $20) + $1A ; $209A
.stringn "빨강3"
.db $0C
.db $FE
.dw $2000 + ($06 * $20) + $1A ; $20DA
.stringn "파랑3"
.db $0C
.db $FE
.dw $2000 + ($06 * $20) + $13 ; $20D3
.stringn "초록5"
.db $0C
.db $FE
.dw $2000 + ($08 * $20) + $1A ; $211A
.stringn "하양1"
.db $0C
.db $FF

Ui_ColorMiss:
.dw $2000 + ($08 * $20) + $12 ; $2112
.stringn "아쉽네요~   "
.db $FF

Ui_ColorYellow:
.dw $2000 + ($08 * $20) + $13 ; $2113
.stringn "노랑 7UP   "
.db $FF

Ui_ColorGreen:
.dw $2000 + ($08 * $20) + $13 ; $2113
.stringn "초록 5UP   "
.db $FF

Ui_ColorRed:
.dw $2000 + ($08 * $20) + $13 ; $2113
.stringn "빨강 3UP   "
.db $FF

Ui_ColorBlue:
.dw $2000 + ($08 * $20) + $13 ; $2113
.stringn "파랑 3UP   "
.db $FF

Ui_ColorWhite:
.dw $2000 + ($08 * $20) + $13 ; $2113
.stringn "하양 1UP   "
.db $FF

Ui_ColorWin1:
.dw $2000 + ($08 * $20) + $12 ; $2112
.stringn "럭키~! 1UP!   "
.db $FF

Ui_ColorWin3:
.dw $2000 + ($08 * $20) + $12 ; $2112
.stringn "당첨~ 3UP!   "
.db $FF

Ui_ColorWin5:
.dw $2000 + ($08 * $20) + $12 ; $2112
.stringn "해냈다~! 5UP!  "
.db $FF

Ui_ColorWin7:
.dw $2000 + ($08 * $20) + $12 ; $2112
.stringn "대박 당첨~! 7UP!"
.db $FF

Ui_LotteryCountersA:
.dw $2000 + ($0C * $20) + $12 ; $2192
.stringn "앞으로"
.db $FE
.dw $2000 + ($0E * $20) + $16 ; $21D6
.stringn "회"
.db $FE
.dw $2000 + ($0C * $20) + $19 ; $2199
.stringn "남은"
.db $FE
.dw $2000 + ($0E * $20) + $1C ; $21DC
.stringn "명"
.db $FF

Ui_LotteryCountersB:
.dw $2400 + ($0C * $20) + $12 ; $2592
.stringn "앞으로"
.db $FE
.dw $2400 + ($0E * $20) + $16 ; $25B6
.stringn "회"
.db $FE
.dw $2400 + ($0C * $20) + $19 ; $2599
.stringn "남은"
.db $FE
.dw $2400 + ($0E * $20) + $1C ; $25BC
.stringn "명"
.db $FF

Ui_LotteryMiss:
.dw $2000 + ($10 * $20) + $12 ; $2212
.stringn "꽝~"
.db $FE
.dw $2400 + ($10 * $20) + $12 ; $2612
.stringn "꽝~"
.db $FF

Ui_LotteryWin1:
.dw $2000 + ($10 * $20) + $12 ; $2212
.stringn "당첨~ 1UP입니다"
.db $FE
.dw $2400 + ($10 * $20) + $12 ; $2612
.stringn "당첨~ 1UP입니다"
.db $FF

Ui_LotteryWin3:
.dw $2000 + ($10 * $20) + $12 ; $2212
.stringn "대박 당첨~ 3UP"
.db $FE
.dw $2400 + ($10 * $20) + $12 ; $2612
.stringn "대박 당첨~ 3UP"
.db $FF

Ui_LotteryWin5:
.dw $2000 + ($10 * $20) + $12 ; $2212
.stringn "나왔다~! 5UP"
.db $FE
.dw $2400 + ($10 * $20) + $12 ; $2612
.stringn "나왔다~! 5UP"
.db $FF

; ↑↑↓↓←→←→BA
Ui_ResultNothing:
.dw $2000 + ($0F * $20) + $08 ; $21E8
.stringn "아쉽네요. 아무것도 없어요~!"
.db $FF

;------------------------------------
; 빙글빙글 복권: 8×16 글자에 맞춰 대사창 확장.
; 첫 화면 대사창
Ui_LotteryFrameA:
.dw $2000 + ($0A * $20) + $11 ; $2151
.db $1A, $FC, $0C, $1B, $1C
.db $FE
.dw $2000 + ($0B * $20) + $11 ; $2171
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2000 + ($0C * $20) + $11 ; $2191
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2000 + ($0D * $20) + $11 ; $21B1
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2000 + ($0E * $20) + $11 ; $21D1
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2000 + ($0F * $20) + $11 ; $21F1
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2000 + ($10 * $20) + $11 ; $2211
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2000 + ($11 * $20) + $11 ; $2231
.db $20, $FC, $0C, $1B, $21

; 첫 화면의 안내판
.db $FE
.dw $2000 + ($02 * $20) + ($15) ; $2055
.db $E4, $E6, $06 				; 노랑 위
.db $FE
.dw $2000 + ($03 * $20) + ($15) ; $2075
.db $E5, $E7 					; 노랑 아래
.db $FE
.dw $2000 + ($04 * $20) + ($15) ; $2095
.db $E8, $E6 					; 파랑 위
.db $FE
.dw $2000 + ($05 * $20) + ($15) ; $20B5
.db $E9, $E7 					; 파랑 아래
.db $FE
.dw $2000 + ($06 * $20) + ($15) ; $20D5
.db $EA, $EC 					; 빨강 위
.db $FE
.dw $2000 + ($07 * $20) + ($15) ; $20F5
.db $EB, $ED 					; 빨강 아래
.db $FE
.dw $2000 + ($08 * $20) + ($15) ; $2115
.db $EE, $F0 					; 하양 위
.db $FE
.dw $2000 + ($09 * $20) + ($15) ; $2135
.db $EF, $F1 					; 하양 아래
.db $FE
.dw $2000 + ($08 * $20) + ($1A) ; $211A
.db $F2, $06 					; 꽝 위
.db $FE
.dw $2000 + ($09 * $20) + ($1A) ; $213A
.db $F3 						; 꽝 아래
.db $FF

; 스크롤 시 대사창
Ui_LotteryFrameB:
.dw $2400 + ($0A * $20) + $11 ; $2571
.db $1A, $FC, $0C, $1B, $1C
.db $FE
.dw $2400 + ($0B * $20) + $11 ; $2591
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2400 + ($0C * $20) + $11 ; $25B1
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2400 + ($0D * $20) + $11 ; $25D1
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2400 + ($0E * $20) + $11 ; $25F1
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2400 + ($0F * $20) + $11 ; $2611
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2400 + ($10 * $20) + $11 ; $2631
.db $1D, $FC, $0C, $00, $1D
.db $FE
.dw $2400 + ($11 * $20) + $11 ; $2651
.db $20, $FC, $0C, $1B, $21

; 스크롤 시 안내판
.db $FE
.dw $2400 + ($02 * $20) + ($15) ; $2455
.db $E4, $E6, $06 				; 노랑 위
.db $FE
.dw $2400 + ($03 * $20) + ($15) ; $2475
.db $E5, $E7 					; 노랑 아래
.db $FE
.dw $2400 + ($04 * $20) + ($15) ; $2495
.db $E8, $E6 					; 파랑 위
.db $FE
.dw $2400 + ($05 * $20) + ($15) ; $24B5
.db $E9, $E7 					; 파랑 아래
.db $FE
.dw $2400 + ($06 * $20) + ($15) ; $24D5
.db $EA, $EC 					; 빨강 위
.db $FE
.dw $2400 + ($07 * $20) + ($15) ; $24F5
.db $EB, $ED 					; 빨강 아래
.db $FE
.dw $2400 + ($08 * $20) + ($15) ; $2515
.db $EE, $F0 					; 하양 위
.db $FE
.dw $2400 + ($09 * $20) + ($15) ; $2535
.db $EF, $F1 					; 하양 아래
.db $FE
.dw $2400 + ($08 * $20) + ($1A) ; $251A
.db $F2, $06 					; 꽝 위
.db $FE
.dw $2400 + ($09 * $20) + ($1A) ; $253A
.db $F3 						; 꽝 아래
.db $FF

