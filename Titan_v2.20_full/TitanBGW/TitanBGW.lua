--================================================================================================
--
-- Battle Ground Warning v1.1.11200
--
-- Programming by Dash from idea by Valthar on EU Server Kul Tiras
--     
-- Guild web site: www.gofguild.com
--
-- History:
-- 2006-05-26, Created
-- 2006-05-30, Taged for release of version 1.0.11000
-- 2006-08-28, Version updated to v1.1.11200
--================================================================================================
-- Titan defines
--
TITAN_COLOR_TOOLTIP =		"|cff00ff00";
TITAN_BGW_ID =				"BGW";
TITAN_BGW_MENU_TEXT =		"BG Warning";
TITAN_BGW_TOOLTIP_TITLE =	"BG Warning";
TITAN_BGW_VERSION =	        "v1.1.11200";
TITAN_BGW_TOOLTIP_TEXT =	"Hint: Click to toggle";
TITAN_BGW_BUTTON_ICON =		"Interface\\Icons\\Ability_Hunter_BeastCall.blp";
--================================================================================================
-- Titan functions
--
function TitanPanelBGWButton_GetBtnText()
	return "BGW";
end

function TitanPanelBGWButton_GetTooltipText()
	return TITAN_COLOR_TOOLTIP..TITAN_BGW_TOOLTIP_TEXT;
end

function TitanPanelBGWButton_OnLoad()
	this.registry = {
		id =					TITAN_BGW_ID,
		menuText =				TITAN_BGW_MENU_TEXT,
		tooltipTitle =			TITAN_BGW_TOOLTIP_TITLE.." "..TITAN_BGW_VERSION,
		buttonTextFunction =	"TitanPanelBGWButton_GetBtnText",
		tooltipTextFunction =	"TitanPanelBGWButton_GetTooltipText",
		icon =					TITAN_BGW_BUTTON_ICON,
		iconWidth =				16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			Lock = 1,
			ShowFrame = 1
			}
		};
		
end

function TitanPanelBGWButton_OnClick(arg1)
	if(arg1 == "LeftButton") then
		if(BGWFrame:IsVisible()) then
			BGWFrame:Hide();
		else
			BGWFrame:Show();
		end
	end
end

function TitanPanelRightClickMenu_PrepareBGWMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_BGW_ID].menuText.." "..TITAN_BGW_VERSION);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_BGW_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
--
-- End Titan functions
--================================================================================================

