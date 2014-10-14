TITAN_MAINMENU_ID = "MainMenu";
TITAN_MAINMENU_THRESHOLD_TABLE = {
	Values = { 0.5, 0.75 },
	Colors = { GREEN_FONT_COLOR, NORMAL_FONT_COLOR, RED_FONT_COLOR },
}


function TitanPanelMainMenuButton_OnLoad()
	this.registry = {
		id = TITAN_MAINMENU_ID,
		menuText = TITAN_MAINMENU_MENU_TEXT,
	};	

	this:RegisterEvent("MAINMENU_UPDATE");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	this:RegisterEvent("UNIT_MODEL_CHANGED");
end

function TitanPanelMainMenuButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_MAINMENU_ID);		
end

function TitanPanelChar_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_CHAR);

	local keyBinding = GetBindingKey("TOGGLECHARACTER0");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_CHAR_HINT);

end

function TitanPanelSpells_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_SPELLS);

	local keyBinding = GetBindingKey("TOGGLESPELLBOOK");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_SPELLS_HINT);

end

function TitanPanelTalents_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_TALENTS);

	local keyBinding = GetBindingKey("TOGGLETALENTS");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_TALENTS_HINT);
end

function TitanPanelQuest_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_QUEST);

	local keyBinding = GetBindingKey("TOGGLEQUESTLOG");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_QUEST_HINT);

end

function TitanPanelSocial_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_SOCIAL);

	local keyBinding = GetBindingKey("TOGGLESOCIAL");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_SOCIAL_HINT);

end

function TitanPanelWorldMap_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_WORLDMAP);

	local keyBinding = GetBindingKey("TOGGLEWORLDMAP");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_WORLDMAP_HINT);

end

function TitanPanelGameMenu_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_MAINMENU);

	local keyBinding = GetBindingKey("TOGGLEGAMEMENU");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_MAINMENU_HINT);

end

function TitanPanelHelp_OnEvent()

	TitanTooltip_SetPanelTooltip(TITAN_MAINMENU_ID);
	this.tooltipTitle = TEXT(TITAN_HELP);

	local keyBinding = GetBindingKey("TOGGLEHELPMENU");
	if ( keyBinding ) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end

	this.tooltipText = TEXT(TITAN_HELP_HINT);

end

function TitanPanelRightClickMenu_PrepareMainMenuMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_MAINMENU_ID].menuText);
	
	local info = {};
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_MAINMENU_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end