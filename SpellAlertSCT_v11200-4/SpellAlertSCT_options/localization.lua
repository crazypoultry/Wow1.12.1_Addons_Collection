SASCTOPTIONS_Toggle = "Enable SpellAlertSCT"
SASCTOPTIONS_Crit = "Display Messages as Crits"
SASCTOPTIONS_TargetOnly = "Messages from Selected Target Only"
SASCTOPTIONS_ReTarget = "Retarget on Feign Death"
SASCTOPTIONS_Compact = "Compact Message Style (Enemy + Thorns)"
SASCTOPTIONS_Colorize = "Colorize Effect (|cff68ccefEnemy|cffffffff gains |cffff0000Thorns|cfffdd000) - Ignores other color options"
SASCTOPTIONS_Emotes = "Alert to Emotes"
SASCTOPTIONS_BossWarns = "Enable Boss Warnings (Like original SpellAlert)"
SASCTOPTIONS_TargetIndicator = "Target Indicator"

SASCTOPTIONS_MustHitEnter = "Hit Enter to save the changes to this field, Escape to cancel"

SASCTOPTIONS_Style = { name="Animation Style", tooltipText = "Which animation type to use", table = {[1] = "Vertical (Default)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down", [5] = "Angled Up", [6] = "Sprinkler", [7] = "Message", [8] = "Damage"}};
SASCTOPTIONS_FrameSlider = { name="Frame", minValue = 1, maxValue = 2, valueStep = 1, minText="1", maxText="2", tooltipText = "Which SCT Frame to output to"};

if (GetLocale()=="koKR") then
	-- Korean by gygabyte
	SASCTOPTIONS_Toggle = "SpellAlertSCT 활성화"
	SASCTOPTIONS_Crit = "치명타로써 메시지 표시"
	SASCTOPTIONS_TargetOnly = "선택한 대상의 주문만 메시지로 표시"
	SASCTOPTIONS_ReTarget = "죽은척하기 재타겟"
	SASCTOPTIONS_Compact = "압축된 메시지 형태 (예 : 적 + 가시)"
	SASCTOPTIONS_Colorize = "색상화 효과 (예 : |cff68ccef적|cffffffff이 |cffff0000가시|cfffdd000 효과를 얻었습니다) - 다른 색상 설정은 무시됩니다"
	SASCTOPTIONS_Emotes = "감정 표현 경고"
	SASCTOPTIONS_BossWarns = "보스 경고 활성화 (과거의 SpellAlert과 같은 효과)"
	SASCTOPTIONS_TargetIndicator = "대상 문자열"

	SASCTOPTIONS_MustHitEnter = "변경 사항을 적용하실려면 엔터를 입력하세요. (취소 : ESC)"


	SASCTOPTIONS_Style = { name="움직임 형태", tooltipText = "글자의 움직임 형태를 선택합니다.", table = {[1] = "세로 (보통)",[2] = "무지개",[3] = "가로",[4] = "아래로 모나게", [5] = "위로 모나게", [6] = "물뿌리개", [7] = "메시지", [8] = "???"}};
	SASCTOPTIONS_FrameSlider = { name="프레임", minValue = 1, maxValue = 2, valueStep = 1, minText="1", maxText="2", tooltipText = "표시되는 SCT 프레임의 방향을 설정합니다"};

end