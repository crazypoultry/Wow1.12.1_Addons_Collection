function kic_Locals_koKR()
--KIC = {
--SETSYN  = "설정 화면|대화창|소리|캐릭|시작 [활성|비활성|전환]",
--TIMESYN = "시간 [잔여|서버|지역]",
--}

KIC = {
--SEARCHFILTER1 = gsub(LOOT_ITEM_CREATED_SELF, "%%.-s", ".-Hitem:(.-):.-"),
--SEARCHFILTER2 = gsub(LOOT_ITEM_PUSHED_SELF, "%%.-s", ".-Hitem:(.-):.-"),
--UNLEARNFILTER = gsub(ERR_SPELL_UNLEARNED_S, "%%.-s", "(.*)"),
SEARCHFILTER1 = "^.-Hitem:(.-):.-|1을;를; 만들었습니다.",
SEARCHFILTER3 = "^.-Hitem:(.-):.-|1을;를; %d개 만들었습니다.",
SEARCHFILTER2 = "^아이템을 획득했습니다: .-Hitem:(.-):.-",
UNLEARNFILTER = "^(.*) 습득을 취소했습니다.",
SETSYN  = "설정 화면|대화창|소리|캐릭터|시작시 [활성|비활성|전환]",
TIMESYN = "시간 [잔여|서버|지역]",
ITEMS = {
	["7076"]  = {t = 86400,  i = 1,   c = 1}, -- Essence of Earth
	["7078"]  = {t = 86400,  i = 1,   c = 1},  -- Essence of Fire
	["7082"]  = {t = 86400,  i = 1,   c = 1}, -- Essence of Air
	["7080"]  = {t = 86400,  i = 1,   c = 1}, -- Essence of Water
	["12803"] = {t = 86400,  i = 1,   c = 1}, -- Living Essence
	["12808"] = {t = 86400,  i = 1,   c = 1}, -- Essence of Undeath
	["12360"] = {t = 172800, i = 1,   c = 0}, -- Arcanite Bar
	["15409"] = {t = 259200, i = 2,   c = 0}, -- Refined Deeprock Salt
	["14342"] = {t = 345600, i = 3,   c = 0}, -- Mooncloth
	["17202"] = {t = 86400,  i = 4,   c = 1}, -- Snowball
	["7068"]  = {t = 600,    i = 1,   c = 1}, -- Elemental Fire
	["21536"] = {t = 86400,  i = 5,   c = 0}, -- Elune Stone
	["11024"] = {t = 600,    i = 6,   c = 0}, -- 늘푸른 약초 주머니
	}
}
ace:RegisterGlobals({
    version 	= 1.01,
    translation = "koKR",
    ACEG_MAP_ONOFF = {[0]="|cffff5050비활성|r",[1]="|cff00ff00활성|r"},
})
-- Info for Ace
KIC.NAME        = "KeepItCool"
KIC.DESCRIPTION	= "전문기술의 재사용 대기시간 표시."

-- Tradeskill categories. Shown in the reminders, with KIC.REMIND.
KIC.CAT = {
	"변환",  
	"소금 정제기", 	
	"달빛 옷감",     
	"눈뭉치 제조기 9000",
	"엘룬의 등불",
	"늘푸른 주머니"
}
-- Profession names. Used to check whether a particular profession is unlearned, by scanning the message that appears when you unlearn a skill, for example "You have unlearned Alchemy."
KIC.PROF = {
	["연금술"]        = 1,
	["가죽 세공"] = 2,
	["재봉술"]      = 3,
	["기계공학"]    = 4
}

-- The following entries are displayed by KIC. Anywhere where it says %s will be replaced with the text in the commment on the same line, in the order they are listed. If you want to change the order, change the %s to %x$s, where x is the order number you want there. For example: "%1$s%3$s%2$s" -- a, b, c would turn out as "acb"
-- The message displayed when a cooldown is detected.
KIC.ADD           = "%s 쿨다운 감지, %s 스케쥴에 추가합니다!" -- One of the items in KIC.CAT, cooldown length.
-- The message displayed when a cooldown is done
KIC.REMIND        = "%s 쿨다운 만료!" -- One of the items in KIC.CAT.
KIC.REMOTEREMIND  = "%s 쿨다운 만료 (%s)!" -- One of the items in KIC.CAT, the character that the CD has finished for.
-- The message displayed when there is nothing to report from db
KIC.EMPTYDB       = "관리중인 쿨다운 없음."
-- Reset messages
KIC.RESETASK      = "초기화 하시겠습니까? '/킵 초기화 확인' 명령을 입력하세요."
KIC.RESET         = "데이터 베이스 초기화."
-- Options
KIC.REPORT  = { -- These will be displayed in the settings report (/kic report) as well as when the player uses /kic set.
	screen  = "화면:",
	chat    = "대화창:",
	sound   = "소리:",
	across  = "다른 캐릭터:",
	startup = "시작시 알림:"
}

-- Values used in /kic set
KIC.ON = "활성"
KIC.OFF = "비활성"
KIC.TOG = "전환"

-- Report. Used for /kic reportdata.
KIC.DATAREPORT = "쿨다운 보고서" 
KIC.REMAINING  = " 남았습니다." -- Mind the leading space!
KIC.READY      = "사용 가능!"

-- Errors
KIC.ERR_INPUT 	  = "|cffff3333오류:|r 잘못된 입렵입니다. 형식: '/킵 %s'. 첨부파일에서 사용법을 확인하세요."

-- Chat handler locals
KIC.COMMANDS    = {"/킵", "/kic"}
KIC.CMD_OPTIONS	= {
	{
		option = "쿨",
		desc   = "관리중인 쿨다운 보기.",
		method = "ReportData" -- Leave this line alone
	},
	{
		option = "초기화",
		desc   = "데이터 베이스 초기화.",
		method = "Reset", -- Leave this line alone
		args   = {
			{
				option = "확인",
				desc   = "데이터 베이스 초기화.",
				method = "ReallyReset" -- Leave this line alone
			}
		}
	},
	{
		option = "설정",
		desc   = "현재 설정 확인/수정. 형식: '/킵 "..KIC.SETSYN.."'. 첨부파일에서 사용법을 확인하세요.",
		method = "SetOpt", -- Leave this line alone
		input  = TRUE
	},
--  All below here new in 1.3.0 
	{
		option = "시간",
		desc   = "현재 시간 설정 확인/수정. 형식: '/킵 "..KIC.TIMESYN.."'. 첨부파일에서 사용법을 확인하세요.",
		method = "SetTime", -- Leave this line alone
	}
}

KIC.REAGENT  = "히카리가 말하길 |cffffe000재료 변환을 잊지 마세요!|r" -- Message shown with every reminder
KIC.MENUSET  = "알림 설정" -- FuBar menu item
KIC.MENU = { -- This is the submenu for KIC.MENUSET, and corresponds to the options in /kic set x.
	screen   = "화면에 표시",
	chat     = "대화창에 표시",
	sound    = "소리로 알림",
	across   = "다른 캐릭터 알림",
	startup  = "시작시 알림"
}
KIC.MENUTIME  = "형식 설정" -- FuBar menu item
KIC.TIMEOPTS  = { -- These will be displayed with KIC.TIMEREPORT in the settings report (/kic report) as well as when the player uses /kic time or the FuBar menu.
	remaining = "남은 시간",
	game      = "서버 시간",
	["local"] = "지역 시간" -- 'local' is a reserved word, that's why it's quoted. You shouldn't translate that part though, only what's to the right of the = mark. =)
}
KIC.TIMEREPORT = "쿨다운을 보여줄 형식 " -- Goes with KIC.TIMEOPTS.

end
