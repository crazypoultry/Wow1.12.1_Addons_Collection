-- Translated by Gamefaq

local L = AceLibrary("AceLocale-2.0"):new("Detox")

L:RegisterTranslations("koKR", function() return {

	-- menu/options
	["Clean group"] = "디버프 해제",
	["Will attempt to clean a player in your raid/party."] = "공격대원과 파티원에게 디버프 해제를 시도합니다.",
	["Play sound if unit needs decursing"] = "해제가 필요한 사람이 있을 시 경고음",
	["Show detoxing in scrolling combat frame"] = "SCT에 해제 메시지 출력",
	["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."] = "SCT5를 사용중일때 WOW 기본 SCT 대신해서 해제 메시지를 출력합니다.",
	["Seconds to blacklist"] = "블랙리스트 설정 시간",
	["Units that are out of Line of Sight will be blacklisted for the set duration."] = "시야에서 벗어난 구성원은 설정 시간동안 블랙리스트가 됩니다.",
	["Max debuffs shown"] = "최대 디버프 표시",
	["Defines the max number of debuffs to display in the live list."] = "해제할 수 있는 목록에 표시할 최대 디버프의 수를 정의합니다.",
	["Update speed"] = "업데이트 속도",
	["Defines the speed the live list is updated, in seconds."] = "해제할 수 있는 목록을 업데이트 할 속도를 초단위로 정의합니다.",
	["Detaches the live list from the Detox icon."] = "Detox 아이콘에서 해제할 수 있는 목록을 분리시킵니다.",
	["Show live list"] = "해제할 수 있는 목록 표시",
	["Options for the live list."] = "해제할 수 있는 목록 설정.",
	["Live list"] = "해제할 수 있는 목록",
	
	-- Filtering
	["Filter"] = "필터(무시)",
	["Options for filtering various debuffs and conditions."] = "여러가지의 디버프와 상태를 필터링할 옵션",
	["Debuff"] = "디버프",
	["Filter by debuff and class."] = "디버프와 직업에 따른 필터",
	["Classes to filter for: %s."] = "직업 필터: %s.",
	["Toggle filtering %s on %s."] = "토글 필터 %s 직업 %s.",
	["Adds a new debuff to the class submenus."] = "새로운 디버프를 직업 하위메뉴에 추가합니다.",
	["Add"] = "추가",
	["Removes a debuff from the class submenus."] = "디버프를 직업 하위메뉴에서 삭제합니다.",
	["Remove %s from the class submenus."] = "%s|1을;를; 직업 하위메뉴에서 삭제합니다.",
	["Remove"] = "삭제",
	["<debuff name>"] = "<디버프 이름>",
	["Filter stealthed units"] = "은신한 플레이어 무시",
	["It is recommended not to cure stealthed units."] = "은신한 플레이어를 치료하지 않습니다.",
	["Filter Abolished units"] = "무효화 할 수 있는 플레이어 무시",
	["Skip units that have an active Abolish buff."] = "스스로 무효화 할 수 있는 버프를 가진 플레이어는 무시합니다.",
	["Filter pets"] = "소환수 무시",
	["Pets are also your friends."] = "자신과 파티원/공격대원의 소환수를 무시합니다.",
	["Filter by type"] = "종류별 무시",
	["Only show debuffs you can cure."] = "자신이 치료할 수 있는 디버프만 표시합니다.",
	["Filter by range"] = "거리별 무시",
	["Only show units in range."] = "치료할수 있는 거리내의 디버프만 표시합니다.",

	-- Priority list
	["Priority"] = "우선 순위",
	["These units will be priorized when curing."] = "해당 플레이어를 우선적으로 치료합니다.",
	["Show priorities"] = "우선 순위 표시",
	["Displays who is prioritized in the live list."] = "해제할 수 있는 목록에 우선적으로 치료할 대상을 표시합니다.",
	["Priorities"] = "우선 해제 대상",
	["Can't add/remove current target to priority list, it doesn't exist."] = "우선 순위 목록에 현재 대상을 추가하거나 삭제할 수 없습니다, 대상이 존재하지 않습니다.",
	["Can't add/remove current target to priority list, it's not in your raid."] = "우선 순위 목록에 현재 대상을 추가하거나 삭제할 수 없습니다, 대상은 공격대원이 아닙니다.",
	["%s was added to the priority list."] = "%s|1이;가; 우선 순위 목록에 추가 되었습니다.",
	["%s has been removed from the priority list."] = "%s|1이;가; 우선 순위 목록에서 삭제 되었습니다.",
	["Nothing"] = "없음",
	["Prioritize %s."] = "%s|1을;를; 우선 해제 합니다.",
	["Every %s"] = "모든 %s",
	["Prioritize every %s."] = "모든 %s|1을;를; 우선 해제 합니다.",
	["Groups"] = "파티",
	["Prioritize by group."] = "파티별 우선.",
	["Group %s"] = "파티 %s",
	["Prioritize group %s."] = "%s 파티를 우선 해제 합니다.",
	["Class %s"] = "직업 %s",

	-- bindings
	["Clean group"] = "디버프 해제",
	["Toggle target priority"] = "대상 우선순위 전환",
	["Toggle target class priority"] = "대상 직업 우선순위 전환",
	["Toggle target group priority"] = "대상 파티 우선순위 전환",

	-- spells and potions
	["Dreamless Sleep"] = "숙면",
	["Greater Dreamless Sleep"] = "상급 숙면",
	["Ancient Hysteria"] = "고대의 격분",
	["Ignite Mana"] = "마나 점화",
	["Tainted Mind"] = "부패한 정신",
	["Magma Shackles"] = "용암 족쇄",
	["Cripple"] = "신경 마비",
	["Frost Trap Aura"] = "냉기의 덫",
	["Dust Cloud"] = "먼지 구름",
	["Widow's Embrace"] = "귀부인의 은총",
	["Curse of Tongues"] = "언어의 저주",
	["Sonic Burst"] = "음파 폭발",
	["Thunderclap"] = "천둥벼락",
	["Delusions of Jin'do"] = "진도의 망상",
	

	["Magic"] = "마법",
	["Charm"] = "현혹",
	["Curse"] = "저주",
	["Poison"] = "독",
	["Disease"] = "질병",
	
	["Cleaned %s"] = "%s|1을;를; 치료합니다.",
	
	["Rank (%d+)"] = "(%d+) 레벨"

} end)
