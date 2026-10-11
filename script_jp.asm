; .loadtable "jp_table.txt", "utf-8"
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
.dw EndingStory_01
.dw EndingStory_02
.dw EndingStory_03
.dw FinalBoss_02

.bank 0x04, 0x8000

.org 0x8492
Amida_01:
; .string "あみだくじ<NL>あみだくじ<PAGE>ひいてたのしい<NL>あみだくじ<END>"

.org 0x84B2
Amida_02:
; .string "Aコースに あたりました<NL>まわってポン!で<PAGE>おたのしみ ください<END>"

.org 0x84D5
Amida_03:
; .string "Bコースに あたりました<NL>まくってカンカンで<JUMP>"

.org 0x84EC
.dw Amida_06

.org 0x84EE
Amida_04:
; .string "Cコースに あたりました<NL>ふくびきガラガラで<JUMP>"

.org 0x8508
.dw Amida_06

.org 0x850A
Amida_05:
; .string "Dコースに あたりました<NL>グサッといっぱつで<JUMP>"

.org 0x8523
.dw Amida_06

.org 0x84C9

Amida_06:
; .string "おたのしみ ください<END>"

.org 0x85BD
MinigameCommon_01:
; .string "コインが<NL>たりません<PAGE>つぎの<NL>ステージは<PAGE>たくさん<NL>あつめてネ!<END>"

.org 0x85E1
MinigameCommon_02:
; .string "もう、おしまい<NL>で～す。<PAGE>つぎのステージも<NL>がんばってネ!<END>"

.org 0x85EF
MinigameCommon_03:
; .string "つぎのステージも<NL>がんばってネ!<END>"

.org 0x8568
MinigameSpin_01:
; .string "がっぽりふやそう<NL>まわってポン!<PAGE>コイン2まいで<NL>メダル1まいと<PAGE>こうかんだよ<END>"

.org 0x8525
MinigameLottery_01:
; .string "まわすだけ～の<NL>ふくびきガラガラ<PAGE>コイン3まいで<NL>いっかい まわせます。<PAGE>じゅうじキー で<NL>グルグルまわしてネ!<END>"

.org 0x8658
MinigameStab_01:
; .string "さしてかいかん<NL>グサッといっぱつ<PAGE>さあ、はりきってまいりましょう!<END>"

.org 0x8596
MinigameColor_01:
; .string "いろをあてて、1UP<NL>まくってカンカン<PAGE>コイン5まいで1かいの<NL>おたのしみ<END>"

.org 0x8617
MinigameColor_02:
; .string "きいろは 7UP<NL>みどりは 5UP<PAGE>あかか、あおなら 3UP<NL>しろなら 1UP<PAGE>さて、つぎのいろは<NL>なにいろだと おもう?<END>"

.org 0x8640
MinigameColor_03:
; .string "さて、つぎのいろは<NL>なにいろだと おもう?<END>"

.org 0x8604
MinigameColor_04:
; .string "おたのしみ<NL>いただけましたか?<JUMP>"

.org 0x8615
.dw MinigameCommon_03

.bank 0x05, 0xA000

.org 0xB2C5
BossIntro_01:
; .string "ヌワッ ハッ ハッ<NL>ハッ ハッ<END>"

.org 0xB2D5
BossIntro_02:
; .string "おれのなは、ガラモス<NL>ちきゅうのしはいしゃだ<END>"

.org 0xB2EE
BossIntro_03:
; .string "おこさまのくせに<NL>よくここまできたな<NL>ドラキュラくん<END>"

.org 0xB30B
BossIntro_04:
; .string "しかし、それもここまでだ<NL>おれさまが じきじきに<NL>やっつけてやろう<END>"

.org 0xB332
BossAfterBattle_01:
; .string "これでかったと<NL>おもうなよ<END>"

.org 0xB341
BossAfterBattle_02:
; .string "そいじゃ<NL>またね<END>"

.org 0xB34B
Ability_01:
; .string "ホーミングのたまを おぼえたよ～ん!<END>"

.org 0xB360
Ability_02:
; .string "さくれつだんを おぼえたぞぁ!<END>"

.org 0xB373
Ability_03:
; .string "こうもりに、へンシンできるよ～ん!<END>"

.org 0xB386
Ability_04:
; .string "てきをかためるレイトウだんだ～!<END>"

.org 0xB399
Ability_05:
; .string "これで、てんじょうも あるけちゃうぜ<END>"

.org 0xB3AF
QuizIntro_01:
; .string "よくきたわね<NL>あたしは<NL>このステージのボスの<END>"

.org 0xB3C8
QuizIntro_02:
; .string "めがみちゃんよ<END>"

.org 0xB3D1
QuizIntro_03:
; .string "あたしは、けんかは<NL>きらいだから<END>"

.org 0xB3E3
QuizIntro_04:
; .string "クイズで<NL>しょうぶしましょ<END>"

.org 0xB3F4
QuizRules_01:
; .string "ルールはかんたんよ<NL>さきに3もんせいかい<NL>したものが、かちよ<END>"

.org 0xB49D
QuizRules_02:
; .string "でも、おてつきすると<NL>ライフをひとつ<NL>もらうわよ<END>"

.org 0xB414
QuizRules_03:
; .string "こたえが、わかったら<NL>ボタンを おしてね<END>"

.org 0xB42B
QuizRules_04:
; .string "では、もんだい<END>"

.org 0xB435
QuizAnswer_01:
; .string "あったりー<END>"

.org 0xB43B
QuizAnswer_02:
; .string "ざーんねん<END>"

.org 0xB442
QuizLose_01:
; .string "あんたのまけよ<NL>ドラキュラちゃん<END>"

.org 0xB454
QuizLose_02:
; .string "グッバイ<NL>ドラキュラちゃん<END>"

.org 0xB465
QuizLose_03:
; .string "あなたのことは<NL>わすれない・・・<END>"

.org 0xB476
QuizWin_01:
; .string "あなたのかちよ<NL>ドラキュラちゃん<END>"

.org 0xB488
QuizWin_02:
; .string "つぎのステージへ<NL>いってちょうだい<END>"

.org 0xB6A2
QuizQuestion01_01:
; .string "わたしのすんでいる<NL>くには、どこ?<END>"

.org 0xB6B6
QuizQuestion01_02:
; .string "ブラジル<NL>アメリカ<NL>さいたまけん<END>"

.org 0xB4B7
QuizQuestion02_01:
; .string "わたしは、どこの<NL>くにからの おくりもの?<END>"

.org 0xB4CE
QuizQuestion02_02:
; .string "フランス<NL>イギリス<NL>さいたまけん<END>"

.org 0xB4E0
QuizQuestion03_01:
; .string "いまアメリカじんが、1ばん<NL>よくつかう にほんごは?<END>"

.org 0xB4FF
QuizQuestion03_02:
; .string "ニンジャ<NL>ニンテンドー<NL>セ<END>"

.org 0xB50F
QuizQuestion04_01:
; .string "つぎのしまのうち、1ばん<NL>みなみは どのしま?<END>"

.org 0xB52A
QuizQuestion04_02:
; .string "ハワイ<NL>サイパン<NL>グアム<END>"

.org 0xB539
QuizQuestion05_01:
; .string "コナミのゲームミュージックの<NL>バンドのなまえは、どれ?<END>"

.org 0xB55A
QuizQuestion05_02:
; .string "とけいはくらぶ<NL>くけいはくらぶ<NL>テレフ<END>"

.org 0xB570
QuizQuestion06_01:
; .string "いま、なんもんめ?<END>"

.org 0xB57A
QuizQuestion06_02:
; .string "4もんめ<NL>5もんめ<NL>6もんめ<END>"

.org 0xB589
QuizQuestion07_01:
; .string "2ステージのボスは<NL>なんだったでしょう<END>"

.org 0xB5A1
QuizQuestion07_02:
; .string "ヤンバルクイナくん<NL>かせいじん<NL>にわとりさん<END>"

.org 0xB5BA
QuizQuestion08_01:
; .string "キショウえいせいは、ひまわり<NL>では ホウソウえいせいは?<END>"

.org 0xB5D8
QuizQuestion08_02:
; .string "うめ<NL>さくら<NL>ゆり<END>"

.org 0xB5E2
QuizQuestion09_01:
; .string "あくまじょうでんせつの<NL>しゅじんこうのなまえは?<END>"

.org 0xB5FE
QuizQuestion09_02:
; .string "シナモン<NL>シモン<NL>ラルフ<END>"

.org 0xB60B
QuizQuestion10_01:
; .string "コナミといえば、こうべ。つぎ<NL>のうち こうべにないものは<NL>どれ?<END>"

.org 0xB631
QuizQuestion10_02:
; .string "いじんかん<NL>マリンタワー<NL>ちゅうかがい<END>"

.org 0xB647
QuizQuestion11_01:
; .string "エビスまるってやつが<NL>でてたゲームは?<END>"

.org 0xB65F
QuizQuestion11_02:
; .string "がんばれ ゴエモン<NL>プーヤン<NL>ゴエモン2<END>"

.org 0xB6C9
QuizQuestion12_01:
; .string "わたしのからだは<NL>なにで、できているでしょう<END>"

.org 0xB6E4
QuizQuestion12_02:
; .string "いし<NL>どう<NL>にく<END>"

.org 0xB6EE
QuizQuestion13_01:
; .string "わたしが、ひだりてに<NL>もっているものはなに?<END>"

.org 0xB707
QuizQuestion13_02:
; .string "どくりつせんげんしょ<NL>クイズのもんだいしゅう<NL>エッチなほん<END>"

.org 0xB729
QuizQuestion14_01:
; .string "1ステージのボスは<NL>なんだったでしょう<END>"

.org 0xB741
QuizQuestion14_02:
; .string "まどうしさんおやこ<NL>りゅうさん<NL>にわとりさんおやこ<END>"

.org 0xB679
FinalBoss_01:
; .string "よくぞ ここまできた、<NL>ドラキュラくん! しかし<NL>この うちゅう ていおう<END>"

.org 0xB82D
FinalBoss_02:
; .string "ガラモス・キング さまに<NL>はむかうものは し ある<NL>のみ!!<END>"

.org 0xB7BF
EndingStory_01:
; .string "ドラキュラくんが、ガラモスをたおした という<NL><NL>うわさは、あっというまに まかいにひろまって・・・<END>"

.org 0xB7F4
EndingStory_02:
; .string "ドラキュラくんの てしたになりたい、という まもの<NL><NL>たちが、どんどん ふえていきました。 そして・・・<END>"

.org 0xB795
EndingStory_03:
; .string "ドラキュラくんは、ふたたび だいまおう と<NL><NL>よばれるように、なりました。<END>"

.org 0xB75C
EndingEpilogue_01:
; .string "でも うかうかしてたら ムチつかいのおにーさんが<NL>     やっつけにくるかもしれないヨ。<END>"


; 엔딩 스태프 롤 원문. 원본 CHR $3E/$3F 사용.
; 원본은 [X 좌표, 타일열, $FF] 형식. $00=빈 줄, $FD=연출 전환, $FE=종료.
; 아래 문자열은 원문 전사이며 일반 대사 데이터가 아니다. 탁점/반탁점 행은 본문과 합쳐 표기.
; 원본 데이터 포인터: .bank $05 / .org $BE1A → $BE1C
.bank $05, $A000

.org $BE1C
StaffRoll_Title:
; .string "スタッフ"

.org $BE23
StaffRoll_Programmer:
; .string "プログラマー"

.org $BE31
StaffRoll_Murata:
; .string "むらた しろう"

.org $BE3A
StaffRoll_Ebisu:
; .string "えびす えつのぶ"

.org $BE4E
StaffRoll_Yamamoto:
; .string "やまもと やすひろ"

.org $BE5A
StaffRoll_CharacterDesigner:
; .string "キャラ・デザイナー"

.org $BE6A
StaffRoll_Yoshimoto:
; .string "よしもと よういち"

.org $BE75
StaffRoll_Fujioka:
; .string "ふじおか けんじ"

.org $BE88
StaffRoll_Yanai:
; .string "やない かずのり"

.org $BE9A
StaffRoll_Sound:
; .string "サウンド"

.org $BEA3
StaffRoll_Tasaka:
; .string "たさか しんじ"

.org $BEB0
StaffRoll_Minami:
; .string "みなみ さとこ"

.org $BEBE
StaffRoll_Package:
; .string "パッケージ"

.org $BECC
StaffRoll_Sumida:
; .string "すみだ ひろみ"

.org $BED8
StaffRoll_Matsuda:
; .string "まつだ ひろし"

.org $BEEA
StaffRoll_PlanningSupport:
; .string "きかく きょうりょく"

.org $BEF7
StaffRoll_Tanaka:
; .string "たなか きみえ"

.org $BF02
StaffRoll_PartyCoordinator:
; .string "えんかい たんとう"

.org $BF0D
StaffRoll_Ebisumaru:
; .string "エビス まる"

.org $BF19
StaffRoll_Planner:
; .string "プランナー"

.org $BF24
StaffRoll_PlannerName:
; .string "よしもと よういち"

.org $BF30
StaffRoll_Director:
; .string "ディレクター"

.org $BF3C
StaffRoll_DirectorName:
; .string "むらた しろう"

.org $BF4E
StaffRoll_Production:
; .string "きかく・せいさく"

.org $BF59
StaffRoll_Team:
; .string "チーム"

.org $BF7B
StaffRoll_PresentedBy:
; .string "ぷれぜんてっどばい"

; 메뉴·결과 문구

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

.org 0xA9FF
Ui_ResultNothing:
.dw $2000 + ($0E * $20) + $08 ; $21C8
.db $8F
; .string "   "
.org 0xAA05
.db $8F, $FE
.dw $2000 + ($0F * $20) + $08 ; $21E8
; .string "さんねんてした。なにもないよ～ん!"
.org 0xAA1A
.db $FF

.org 0xAA1B
Ui_ColorCounters:
.dw $2000 + ($05 * $20) + $12 ; $20B2
; .string "あと"
.org 0xAA1F
.db $F9, $24
; .string "かい"
.org 0xAA23
.db $F9, $07
; .string "のこり"
.org 0xAA28
.db $F9, $2A
; .string "にん"
.org 0xAA2C
.db $FF

.org 0xAA2D
Ui_ColorRewards:
.dw $2000 + ($06 * $20) + $13 ; $20D3
; .string "きいろ7"
.org 0xAA33
.db $0C
; .string "  あか3"
.org 0xAA39
.db $0C, $F9, $21, $8F
; .string "     あお3"
.org 0xAA45
.db $0C, $F9, $40
; .string "みとり5"
.org 0xAA4C
.db $0C
; .string "  しろ1"
.org 0xAA52
.db $0C, $FF

.org 0xAA54
Ui_ColorMiss:
.dw $2000 + ($07 * $20) + $12 ; $20F2
.db $8F
; .string "   "
.org 0xAA5A
.db $8F, $F9, $20
; .string "さんねんてした～"
.org 0xAA65
.db $FF

.org $ACF4
Ui_QuizChoiceNumbers:
.dw $2400 + ($05 * $20) + $0D ; $24AD
.db $F1 ; 1
.db $F9, $40
.db $F2 ; 2 ($24ED)
.db $F9, $80
.db $F3 ; 3 ($252D)
.db $FF

.org 0xACFE
Ui_SpinCounters:
.dw $2000 + ($02 * $20) + $17 ; $2057
.db $8F, $F9, $1F
; .string "メタル"
.org 0xAD06
.db $F9, $45
; .string "まい"
.org 0xAD0A
.db $F9, $9F
; .string "のこり"
.org 0xAD0F
.db $F9, $C5
; .string "にん"
.org 0xAD13
.db $FF

.org 0xAD14
Ui_SpinWin:
.dw $2000 + ($12 * $20) + $18 ; $2258
; .string "おおあたり～"
.org 0xAD1C
.db $FF

.org 0xAD1D
Ui_SpinMiss:
.dw $2000 + ($11 * $20) + $1B ; $223B
.db $8F, $F9, $1D
; .string "おおはすれ～"
.org 0xAD28
.db $FF

.org 0xAD29
Ui_LotteryCountersA:
.dw $2000 + ($0C * $20) + $12 ; $2192
; .string "あと"
.org 0xAD2D
.db $F9, $24
; .string "かい"
.org 0xAD31
.db $F9, $07
; .string "のこり"
.org 0xAD36
.db $F9, $2A
; .string "にん"
.org 0xAD3A
.db $FF

.org 0xAD3B
Ui_LotteryMiss:
.dw $2000 + ($0E * $20) + $13 ; $21D3
.db $8F, $F9, $1F
; .string "はすれ～"
.org 0xAD44
.db $FE
.dw $2400 + ($0E * $20) + $13 ; $25D3
.db $8F, $F9, $1F
; .string "はすれ～"
.org 0xAD4E
.db $FF

.org 0xAD4F
Ui_LotteryWin3:
.dw $2000 + ($0E * $20) + $1C ; $21DC
.db $9F, $F9, $16
; .string "おおあたり～ 3アッフ"
.org 0xAD5F
.db $FE
.dw $2400 + ($0E * $20) + $1C ; $25DC
.db $9F, $F9, $16
; .string "おおあたり～ 3アッフ"
.org 0xAD70
.db $FF

.org 0xAD71
Ui_LotteryWin1:
.dw $2000 + ($0E * $20) + $1A ; $21DA
.db $9F, $8F, $F9, $18
; .string "あたり～ 1アッフてす"
.org 0xAD82
.db $FE
.dw $2400 + ($0E * $20) + $1A ; $25DA
.db $9F, $8F, $F9, $18
; .string "あたり～ 1アッフてす"
.org 0xAD94
.db $FF

.org 0xAD95
Ui_LotteryWin5:
.dw $2000 + ($0E * $20) + $12 ; $21D2
.db $8F, $F9, $08, $9F, $F9, $20
; .string "てた～! 5アッフ"
.org 0xADA6
.db $FE
.dw $2400 + ($0E * $20) + $12 ; $25D2
.db $8F, $F9, $08, $9F, $F9, $20
; .string "てた～! 5アッフ"
.org 0xADB8
.db $FF

.org 0xADB9
Ui_LotteryCountersB:
.dw $2400 + ($0C * $20) + $12 ; $2592
; .string "あと"
.org 0xADBD
.db $F9, $24
; .string "かい"
.org 0xADC1
.db $F9, $07
; .string "のこり"
.org 0xADC6
.db $F9, $2A
; .string "にん"
.org 0xADCA
.db $FF

.org 0xADDF
Ui_GameOver:
.dw $2000 + ($0D * $20) + $10 ; $21B0
.db $8F, $F9, $1F
; .string "つつける"
.org 0xADE8
.db $F9, $9F
; .string "もうやめる"
.org 0xADEF
.db $FF

.org 0xAE72
Ui_StartMenu:
.db $02
.dw $2000 + ($05 * $20) + $07 ; $20A7
.db $B0, $FC, $08, $BD, $B2, $FE, $02
.dw $2000 + ($05 * $20) + $18 ; $20B8
.db $B1, $FC, $08, $BD, $B3, $FE
.dw $2000 + ($08 * $20) + $0C ; $210C
; .string "さいしょからスタート"
.org 0xAE90
.db $F9, $60
; .string "とちゅうからスタート"
.org 0xAE9C
.db $FF

.org 0xAF3A
Ui_ColorYellow:
.dw $2000 + ($08 * $20) + $13 ; $2113
; .string "きいろ 7UP"
.org 0xAF43
.db $FF

.org 0xAF44
Ui_ColorGreen:
.dw $2000 + ($07 * $20) + $14 ; $20F4
.db $8F, $F9, $1F
; .string "みとり 5UP"
.org 0xAF50
.db $FF

.org 0xAF51
Ui_ColorRed:
.dw $2000 + ($08 * $20) + $13 ; $2113
; .string "あか  3UP"
.org 0xAF5A
.db $FF

.org 0xAF5B
Ui_ColorBlue:
.dw $2000 + ($08 * $20) + $13 ; $2113
; .string "あお  3UP"
.org 0xAF64
.db $FF

.org 0xAF65
Ui_ColorWhite:
.dw $2000 + ($08 * $20) + $13 ; $2113
; .string "しろ  1UP"
.org 0xAF6E
.db $FF

.org 0xAFD7
Ui_StabCounters:
.dw $2000 + ($18 * $20) + $0A ; $230A
; .string "けん"
.org 0xAFDB
.db $F9, $24
; .string "ほん"
.org 0xAFDF
.db $F9, $07
; .string "のこり"
.org 0xAFE4
.db $F9, $2C
; .string "にん"
.org 0xAFE8
.db $FF

.org 0xAF6F
Ui_ColorWin7:
.dw $2000 + ($07 * $20) + $1C ; $20FC
.db $9F, $F9, $16
; .string "おおあたり～!7アッフ!"
.org 0xAF80
.db $FF

.org 0xAF81
Ui_ColorWin5:
.dw $2000 + ($07 * $20) + $1B ; $20FB
.db $9F, $F9, $17
; .string "やったあ～!5アッフ!"
.org 0xAF91
.db $FF

.org 0xAF92
Ui_ColorWin3:
.dw $2000 + ($07 * $20) + $1B ; $20FB
.db $9F, $F9, $17
; .string "あったり～ 3アッフ!"
.org 0xAFA2
.db $FF

.org 0xAFA3
Ui_ColorWin1:
.dw $2000 + ($07 * $20) + $1A ; $20FA
.db $9F, $F9, $18
; .string "ラッキ～!1アッフ!"
.org 0xAFB2
.db $FF

.org 0xAFE9
Ui_PasswordScreen:
.dw $2000 + ($08 * $20) + $09 ; $2109
.db $8F, $F9, $20
; .string "トラキ"
.org 0xAFF1
.db $FA
; .string "ラくんは"
.org 0xAFF6
.db $F9, $49, $8F, $F9, $61
; .string "あ あ あ の はんに"
.org 0xB006
.db $F9, $81, $BE
; .string " "
.org 0xB00A
.db $BE
; .string " "
.org 0xB00C
.db $BE, $F9, $A7
; .string "ふっかつ する。"
.org 0xB017
.db $FE
.dw $2000 + ($06 * $20) + $11 ; $20D1
.db $8F, $F9, $17, $BE, $BE
; .string " ふっかつの しゅもん "
.org 0xB02B
.db $BE, $BE, $FE, $02
.dw $2000 + ($07 * $20) + $07 ; $20E7
.db $B0, $FC, $07, $BD, $B2, $FE, $02
.dw $2000 + ($07 * $20) + $18 ; $20F8
.db $B1, $FC, $07, $BD, $B3, $FE
.dw $2000 + ($0F * $20) + $08 ; $21E8
.db $FC, $10, $BE, $FF

.org 0xB046
Ui_PasswordMoon:
.dw $2000 + ($0B * $20) + $0A ; $216A
; .string "つ き よ"
.org 0xB04D
.db $FF

.org 0xB04E
Ui_PasswordDark:
.dw $2000 + ($0B * $20) + $0A ; $216A
; .string "や み よ"
.org 0xB055
.db $FF

.org 0xB056
Ui_PasswordCloud:
.dw $2000 + ($0B * $20) + $0A ; $216A
; .string "く も り"
.org 0xB05D
.db $FF

.org 0xB05E
Ui_PasswordRain:
.dw $2000 + ($0B * $20) + $0A ; $216A
; .string "こ さ め"
.org 0xB065
.db $FF

.org 0xB066
Ui_PasswordSummer:
.dw $2000 + ($0B * $20) + $0A ; $216A
; .string "ま な つ"
.org 0xB06D
.db $FF

.org 0xB06E
Ui_PasswordTomorrow:
.dw $2000 + ($0B * $20) + $0A ; $216A
; .string "あ し た"
.org 0xB075
.db $FF

.org 0xB076
Ui_PasswordDawn:
.dw $2000 + ($0B * $20) + $0A ; $216A
; .string "よ あ け"
.org 0xB07D
.db $FF

; Ui_SpinTitle:
; .dw $2000 + ($06 * $20) + $06 ; $20C6
; .string "まわって"
; .db $FF
