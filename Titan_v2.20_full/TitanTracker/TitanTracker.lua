--------------------------------------------------------------------------
-- TitanTracker.lua 
--------------------------------------------------------------------------
--[[
TitanTracker
	Plugin for Titan Panel to toggle users Find, Track and Sense abilites.
	Can be used to replace the Minimap Tracking icon. 

v0.10 (January 7, 2006 20:50 PST)
- German localization fix (thanks sub0 and Pwnage)

v0.09 (January 6, 2006 10:30 PST)
- updated toc# for 1.9 patch

v0.08 (September 29, 2005 19:00 PST)
- updated toc# for 1.70 patch
- updated for Titan Panel 1.24+

v0.07 (June 9, 2005 09:30 PST)
- removed testing code that was causing an error when left-clicking 

v0.06 (June 7, 2005 20:30 PST)
- toc updated for 1.50 patch

v0.05 (June 5, 2005 02:49 PST)
- German localization (thanks Kaesemuffin)

v0.04 (June 1, 2005 20:29 PST)
- uses the current tracking icon for the Titan Panel icon
- ability to turn off Minimap Tracking icon

v0.03 (May 31, 2005 12:30 PST)
- updated for Titan Panel version 1.22
- added 'Track Nothing' toggle

v0.01 (May 20, 2005 06:00 PST)
- Initial Release

TODO: Minor translations for French and German.  Complete translation
       for Korean.
]]--

TITAN_TRACKER_ID = "Tracker";

TITAN_TRACKER_ICON = "Interface\\Icons\\Ability_Hunter_Pathfinding";

TrackerData = {

	SortTable = { };
	
	initSort = function()
		for k, v in TrackerData.TrackingAbilities do
			local newOrderInfo = { name = k, order = v.spellNum };
			table.insert(TrackerData.SortTable, newOrderInfo);
		end
		table.sort(TrackerData.SortTable, function(a,b) return (a.name < b.name); end);
	end;

	TrackingAbilities = {
                [TITAN_TRACKER_SPELL_FIND_HERBS]       = { spellNum = 1 },
                [TITAN_TRACKER_SPELL_FIND_MINERALS]    = { spellNum = 2 },
                [TITAN_TRACKER_SPELL_FIND_TREASURE]    = { spellNum = 3 },
                [TITAN_TRACKER_SPELL_TRACK_BEASTS]     = { spellNum = 4 },
                [TITAN_TRACKER_SPELL_TRACK_DEMONS]     = { spellNum = 5 },
                [TITAN_TRACKER_SPELL_TRACK_DRAGONKIN]  = { spellNum = 6 },
                [TITAN_TRACKER_SPELL_TRACK_ELEMENTALS] = { spellNum = 7 },
                [TITAN_TRACKER_SPELL_TRACK_GIANTS]     = { spellNum = 8 },
                [TITAN_TRACKER_SPELL_TRACK_HIDDEN]     = { spellNum = 9 },
                [TITAN_TRACKER_SPELL_TRACK_HUMANOIDS]  = { spellNum = 10 },
                [TITAN_TRACKER_SPELL_TRACK_UNDEAD]     = { spellNum = 11 },
                [TITAN_TRACKER_SPELL_SENSE_DEMONS]     = { spellNum = 12 },
                [TITAN_TRACKER_SPELL_SENSE_UNDEAD]     = { spellNum = 13 },
	};
}

--
-- OnFunctions
--
function TitanPanelTrackerButton_OnLoad()

	local iconTexture = GetTrackingTexture();
	
	if ( iconTexture == nil ) then
		iconTexture = TITAN_TRACKER_ICON;
	end
	--TitanPanelTracker_ChatPrint(":texture="..iconTexture.."\n");
	
	this.registry = { 
		id = TITAN_TRACKER_ID,
		menuText = TITAN_TRACKER_MENU_TEXT, 
		buttonTextFunction = "TitanPanelTrackerButton_GetButtonText",	
		tooltipTitle = TITAN_TRACKER_TOOLTIP,
		tooltipTextFunction = "TitanPanelTrackerButton_GetTooltipText",
		icon = iconTexture,
	    iconWidth = 20,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			HideMinimap = TITAN_NIL,
		}
	};

	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");

end

function TitanPanelTrackerButton_OnEvent()

	if ( event == "PLAYER_AURAS_CHANGED" ) then
		
		local iconTexture = GetTrackingTexture();
		
		if ( iconTexture == nil) then
			iconTexture = TITAN_TRACKER_ICON;
		end
		
		--TitanPanelTracker_ChatPrint("texture="..iconTexture.."\n");
		
		TitanPlugins[TITAN_TRACKER_ID].icon = iconTexture;
		
		if ( TitanGetVar(TITAN_TRACKER_ID, "HideMinimap") ) then
			MiniMapTrackingFrame:Hide();
		end
    end

	TitanPanelButton_UpdateButton(TITAN_TRACKER_ID);	
	TitanPanelButton_UpdateTooltip();
end 

--
-- Titan functions
--
function TitanPanelTrackerButton_GetButtonText(id)
	local id = TitanUtils_GetButton(id, true);

	local buttonRichText = "";
	return TITAN_TRACKER_BUTTON_LABEL, buttonRichText;
end

function TitanPanelTrackerButton_GetTooltipText()
	
	local tooltipRichText = "";
	
	local currTexture = GetTrackingTexture();
	
	if ( currTexture == nil) then
		tooltipRichText = "Tracking is off\n";
    else
		tooltipRichText = TitanPanelTracker_FindTracking(currTexture).."\n";
	end
	
	tooltipRichText = tooltipRichText..TitanUtils_GetGreenText(TITAN_TRACKER_TOOLTIP_TEXT);
	return tooltipRichText;
end

--
-- create right-click dropdown menu
--
function TitanPanelRightClickMenu_PrepareTrackerMenu() 

	local k,v;
	local numTrack = 0
	
	local info = {};
	
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then		
		if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then
			info = {};
			info.text = TITAN_TRACKER_ABOUT_POPUP_TEXT;
			info.value = "AboutTextPopUP";
			info.notClickable = 1;
			info.isTitle = 0;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end

	local trackingTexture = GetTrackingTexture();
	
	-- get the list of current find/track/sense abilities
	local TrackerAbilityList = TitanPanelTracker_BuildList();

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_TRACKER_ID].menuText);
	
	for k, v in TrackerAbilityList.SortTable do
		if ( TrackerAbilityList.SortTable[k].order > 0 ) then
			--TitanPanelTracker_ChatPrint("TheList:"..TrackerAbilityList.SortTable[k].name..":"..TrackerAbility.SortTable[k].order);		
			info = {};
			numTrack = numTrack + 1;
			info.value = TrackerAbilityList.SortTable[k].order;
			info.text = TrackerAbilityList.SortTable[k].name;
			info.func = TitanPanelTracker_CastSpell;
			info.checked = (trackingTexture == GetSpellTexture(TrackerAbilityList.SortTable[k].order, 1));
			UIDropDownMenu_AddButton(info);
		end
	end

	info = {};
	if ( numTrack == 0 ) then
		info.value = "notrack";
		info.text = TITAN_TRACKER_NOTHING_TEXT;
		UIDropDownMenu_AddButton(info);
	else
		if ( GetTrackingTexture() ~= nil ) then
			TitanPanelRightClickMenu_AddSpacer();
			info.text = TITAN_TRACKER_STOP_TRACKING;
			info.value = "stoptracking";
			info.func = CancelTrackingBuff;
			UIDropDownMenu_AddButton(info);
		end
	end
	
	TitanPanelRightClickMenu_AddSpacer();
	
	-- toggle minimap tracking icon
	info = {};
	info.text = TITAN_TRACKER_HIDE_MINIMAP;
	info.value = TITAN_TRACKER_ID;
	info.func = TitanPanelTracker_ToggleMinimap;
	info.checked = TitanGetVar(TITAN_TRACKER_ID, "HideMinimap");
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_TRACKER_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,TITAN_TRACKER_ID,TITAN_PANEL_MENU_FUNC_HIDE);

	-- info about plugin
	info = {};
	info.text = TITAN_TRACKER_ABOUT_TEXT;
	info.value = "DisplayAbout";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
end

--
-- Tracker functions
--
function TitanPanelTracker_CastSpell()
	--TitanPanelTracker_ChatPrint("Cast Spell#:"..this.value);
	CastSpell(this.value, 0);	
			
	if ( TitanGetVar(TITAN_TRACKER_ID, "HideMinimap") ) then
			MiniMapTrackingFrame:Hide();
	end
end
	
--
-- build list of players find/track/sense abilities
--
function TitanPanelTracker_BuildList()
	local i = 1;
	local numTrack = 0;
	
	local TrackerAbilityList = TrackerData;

	for k,v in TrackerAbilityList.TrackingAbilities do
		--TitanPanelTracker_ChatPrint("BuildList:"..k..":"..TrackerAbilityList.TrackingAbilities[k].spellNum);
		TrackerAbilityList.TrackingAbilities[k].spellNum = 0;
	end
	
	while (true) do
		local spellName, spellRank = GetSpellName(i, SpellBookFrame.bookType);
		if (not spellName) then
			do break end;
		elseif ( TrackerAbilityList.TrackingAbilities[spellName] ) then
			TrackerAbilityList.TrackingAbilities[spellName].spellNum = i;
		end
		i = i + 1;
	end

	TrackerAbilityList.SortTable = {};

	TrackerAbilityList.initSort();
	
	return TrackerAbilityList;
end

--
-- Find what is currently being tracked, return string for tooltip
--
function TitanPanelTracker_FindTracking(theTexture)
	if ( theTexture == TITAN_TRACKER_ICON_FIND_HERBS ) then
		return TITAN_TRACKER_SPELL_FIND_HERBS;
	elseif ( theTexture == TITAN_TRACKER_ICON_FIND_MINERALS) then
		return TITAN_TRACKER_SPELL_FIND_MINERALS;
	elseif ( theTexture == TITAN_TRACKER_ICON_FIND_TREASURE ) then
		return TITAN_TRACKER_SPELL_FIND_TREASURE;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_BEASTS ) then
		return TITAN_TRACKER_SPELL_TRACK_BEASTS;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_HUMANOIDS ) then
		return TITAN_TRACKER_SPELL_TRACK_HUMANOIDS;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_HIDDEN ) then
		return TITAN_TRACKER_SPELL_TRACK_HIDDEN ;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_ELEMENTALS ) then
		return TITAN_TRACKER_SPELL_TRACK_ELEMENTALS;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_UNDEAD ) then
		return TITAN_TRACKER_SPELL_TRACK_UNDEAD;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_DEMONS ) then
		return TITAN_TRACKER_SPELL_TRACK_DEMONS;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_GIANTS ) then
		return TITAN_TRACKER_SPELL_TRACK_GIANTS;
	elseif ( theTexture == TITAN_TRACKER_ICON_TRACK_DRAGONKIN ) then 
		return TITAN_TRACKER_SPELL_TRACK_DRAGONKIN;
	elseif ( theTexture == TITAN_TRACKER_ICON_SENSE_UNDEAD ) then
		return TITAN_TRACKER_SPELL_SENSE_UNDEAD;
	elseif ( theTexture == TITAN_TRACKER_ICON_SENSE_DEMONS ) then
		return TITAN_TRACKER_SPELL_SENSE_DEMONS;
	else
		return "No Match!";
	end
end

--
-- toggle the Minimap Tracking Icon
--
function TitanPanelTracker_ToggleMinimap()
	if ( TitanGetVar(TITAN_TRACKER_ID, "HideMinimap") ) then
		TitanSetVar(TITAN_TRACKER_ID,"HideMinimap",nil);
		MiniMapTrackingFrame:Show();
	else
		TitanSetVar(TITAN_TRACKER_ID,"HideMinimap",1);
		MiniMapTrackingFrame:Hide();
	end
end	
	
function TitanPanelTracker_ChatPrint(msg)
        DEFAULT_CHAT_FRAME:AddMessage(msg);
end