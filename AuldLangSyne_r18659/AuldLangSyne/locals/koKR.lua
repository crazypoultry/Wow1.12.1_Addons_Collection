--[[ $Id: koKR.lua 15765 2006-11-02 20:01:23Z fenlis $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("AuldLangSyne")

L:RegisterTranslations("koKR", function()
	return {
		["AuldLangSyne"] = "AuldLangSyne 친구목록",
		["Options for AuldLangSyne."] = "AuldLangSyne 친구목록에 대한 설정입니다.",

		--options
		["data"] = "데이터",
		["Random data-management functions"] = "여러가지 데이터 관리 기능입니다.",
		["clear"] = "삭제",
		["Clear stored data"] = "저장된 데이터를 삭제합니다.",
		["dump"] = "덤프",
		["Print stored data"] = "저장된 데이터를 출력합니다.",
		["ctimport"] = "CT 불러오기",
		["Import notes for this realm from CT_PlayerNotes"] = "CT_PlayerNotes 에서 이 서버에 대한 메모를 불러옵니다.",
		["backup"] = "백업",
		["Options for backing up and restoring your friends list"] = "백업과 친구 목록 저장에 대한 설정입니다.",
		["save"] = "저장",
		["Take a snapshot of your current friends list"] = "현재 친구 목록을 저장합니다.",
		["load"] = "불러오기",
		["Restore a snapshot of your friends list, wiping out your current friends list"] = "백업된 친구 목록을 복원합니다.",

		["show"] = "표시",
		["Choose what information to display"] = "표시할 정보를 선택합니다.",
		["Turns display of PVP ranks on and off."] = "PVP 계급 표시를 활성화 혹은 비활성화 합니다.",
		["PVP rank numbers"] = "PVP 계급 번호",
		["Turns display of PVP rank numbers on and off."] = "PVP 계급 번호 표시를 활성화 혹은 비활성화 합니다.",
		["Guild"] = "길드",
		["Turns display of guild membership on and off."] = "길드 표시를 활성화 혹은 비활성화 합니다.",
		["Colors"] = "색상",
		["Choose which elements to color"] = "색상 사항을 선택합니다.",
		["Name"] = "이름",
		["Turns coloring names by gender on and off."] = "성별에 대한 이름 색상화를 활성화 혹은 비활성화 합니다.",
		["Class"] = "직업",
		["Turns coloring class names on and off."] = "직업 색상화를 활성화 혹은 비활성화 합니다.",
		["Compact mode"] = "간략한 모드",
		["Turns compact friends list on and off."] = "간략한 친구 목록 기능을 활성화 혹은 비활성화 합니다.",
		["Compact mode levels"] = "간략한 모드 레벨",
		["Turns display of levels in compact mode on and off."] = "간략한 모드에 레벨 표시를 활성화 혹은 비활성화 합니다.",
		["Note in player tooltip"] = "플레이어 툴팁 메모",
		["Turns display of player notes in tooltips on and off."] = "툴팁에 플레이어 메모를 표시하는 기능을 활성화 혹은 비활성화 합니다.",
		["Note on logon"] = "접속 메모",
		["Turns display of player notes on logon on and off."] = "접속시 플레이어 메모를 표시하는 기능을 활성화 혹은 비활성화 합니다.",
		["Note on /who"] = "/누구 메모",
		["Turns display of player notes when you /who them on and off."] = "/누구 실행 시 플레이어 메모 표시를 켜거나 끕니다.",
		
		-- output text
		["Detected an older database version.  Upgrading!"] = "이전 버전의 데이터베이스가 발견되었습니다. 갱신 중!",
		[" day"] = " 일",
		[" hour"] = " 시간",
		[" minute"] = " 분",
		["s"] = "",
		[" ago"] = " 전",
		["Friend: "] = "친구: ",
		["Guild: "] = "길드: ",
		["Ignore: "] = "제외: ",
		["This slot is currently empty."] = "해당 슬롯은 현재 비어있습니다.",
		["Backed up %d friends to slot %d"] = "%d명의 친구를 %d 슬롯으로 백업",
		["Editing note for %s"] = "%s 메모 수정",
		["Click to edit"] = "클릭 : 수정",
		["Edit note"] = "메모 편집",
		["Confirm"] = "확인",
		["Cancel"] = "취소",
    
	}
end)
