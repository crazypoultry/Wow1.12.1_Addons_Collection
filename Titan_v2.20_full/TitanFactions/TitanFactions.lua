--------------------------------------------------------------------------
-- Global variables
--------------------------------------------------------------------------
TITAN_FACTIONS_VERSION = "1.2.1"
TITAN_FACTIONS_ID = "Factions"
TITAN_FACTIONS_ICON = "Interface\\AddOns\\TitanFactions\\Artwork\\TitanFactions"
TITAN_FACTIONS_ABOUT_POPUP_TEXT = TitanUtils_GetGreenText("Titan Panel [Factions]").."\n"..TitanUtils_GetNormalText(TITAN_FACTIONS_VERSION..": ")..TitanUtils_GetHighlightText(TITAN_FACTIONS_VERSION).."\n"..TitanUtils_GetNormalText(TITAN_FACTIONS_ABOUT_OAUTHOR..": ")..TitanUtils_GetHighlightText("Corgi").."\n"..TitanUtils_GetNormalText(TITAN_FACTIONS_ABOUT_CAUTHOR..": ")..TitanUtils_GetHighlightText("Phanx")


--------------------------------------------------------------------------
-- Maximum units for each standing
--------------------------------------------------------------------------
Units = { }
Units[1] = 36000	-- Hated
Units[2] = 3000		-- Hostile
Units[3] = 3000		-- Unfriendly
Units[4] = 3000		-- Neutral
Units[5] = 6000		-- Friendly
Units[6] = 12000	-- Honored
Units[7] = 21000	-- Revered
Units[8] = 1000		-- Exalted


--------------------------------------------------------------------------
-- Faction Text Colors
--------------------------------------------------------------------------
FactionTextHated = " |cff8b0000"..FACTION_STANDING_LABEL1.."|r"
FactionTextHostile = " |cffff0000"..FACTION_STANDING_LABEL2.."|r"
FactionTextUnfriendly = " |cffff8C00"..FACTION_STANDING_LABEL3.."|r"
FactionTextNeutral = " |cffc0c0c0"..FACTION_STANDING_LABEL4.."|r"
FactionTextFriendly = " |cffffffff"..FACTION_STANDING_LABEL5.."|r"
FactionTextHonored = " |cff00ff00"..FACTION_STANDING_LABEL6.."|r"
FactionTextRevered = " |cff4169e1"..FACTION_STANDING_LABEL7.."|r"
FactionTextExalted = " |cff9932cc"..FACTION_STANDING_LABEL8.."|r"


--------------------------------------------------------------------------
-- OnFunctions
--------------------------------------------------------------------------

function TitanPanelFactionsButton_OnLoad()

	this.registry = {
		id = TITAN_FACTIONS_ID,
		version = TITAN_FACTIONS_VERSION,
		menuText = TITAN_FACTIONS_MENU_TEXT,
		buttonTextFunction = "TitanPanelFactionsButton_GetButtonText",
		tooltipTitle = TITAN_FACTIONS_TOOLTIP,
		tooltipTextFunction = "TitanPanelFactionsButton_GetTooltipText",
		icon = TITAN_FACTIONS_ICON,
	    iconWidth = 16,
	    category = "Information",
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowRaw = TITAN_NIL,
			ShowBoth = TITAN_NIL,
			HideInactive = TITAN_NIL,
			HideExalted = TITAN_NIL,
			ShowSession = TITAN_NIL,
			ShowRunecloth = TITAN_NIL,
			ShowMonitor = TITAN_NIL,
			MonitorBlizzard = TITAN_NIL,
			MonitorFaction = TITAN_NIL,
		}
	}

	this:RegisterEvent("UPDATE_FACTION")
	this:RegisterEvent("PLAYER_LOGIN")

end


function TitanPanelFactionsButton_OnEvent(event)

	if ( event == "UPDATE_FACTION" ) then

		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 ) then
			TitanPanelFactions_UpdateMonitor()
			TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
		end
		TitanPanelButton_UpdateTooltip()

	elseif ( event == "PLAYER_LOGIN") then

		-- @NYRINE: show session rep gain
		faction_sessionStart = { }
		local NumFactions = GetNumFactions()
		local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched
		local factionIndex
		for factionIndex=1, NumFactions do
			faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched = GetFactionInfo(factionIndex)
			if ( not faction_isHeader ) then
				faction_sessionStart[faction_name] = faction_barValue
			end
		end

	end

end

--------------------------------------------------------------------------
-- Titan functions
--------------------------------------------------------------------------
function TitanPanelFactionsButton_GetButtonText(id)
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowLabelText") == 1 ) then
		local buttonRichText = ""
		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 and (TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction") ~= nil) ) then

			if ( TitanGetVar(TITAN_FACTIONS_ID, "MonitorBlizzard" ) == 1 ) then
				-- we want to sync the monitored and watched factions
				local wfaction_name, wfaction_standingID, wfaction_barMin, wfaction_barMax, wfaction_barValue = GetWatchedFactionInfo()
				-- do we have a watched faction?
				if ( wfaction_name and not string.find(TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction"), wfaction_name) ) then
					-- we're not already monitoring our watched faction, so get monitor text and set it
					local NumFactions = GetNumFactions()
					local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched
					local factionIndex
					for factionIndex=1, NumFactions do
						faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched = GetFactionInfo(factionIndex)
						if ( faction_name == wfaction_name ) then
							if ( faction_atWarWith ) then
								atWarText = TitanUtils_GetRedText(" (AW)")
							else
								atWarText = ""
							end
							monitorText = TitanUtils_GetGreenText(faction_name)..atWarText..":".."\t"..TitanPanelFactions_FindRep(faction_standingID).." ("
							if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
								monitorText = monitorText..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")\n"
							elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
								local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
								monitorText = monitorText..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..") ("..bval.."%)\n"
							else
								local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
								monitorText = monitorText..bval.."%)\n"
							end
							TitanSetVar(TITAN_FACTIONS_ID, "MonitorFaction", monitorText)
							-- quit looping, we found it
							break
						end
					end
				end
			end

			buttonRichText = format(TITAN_FACTIONS_BUTTON_TEXT, TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction"))
		else
			buttonRichText = TITAN_FACTIONS_BUTTON_LABEL
		end

		return buttonRichText
	end
end


function TitanPanelFactionsButton_GetTooltipText()

	local tooltipRichText = ""

	local NumFactions = GetNumFactions()

	local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith
	local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched

	local factionIndex

	for factionIndex=1, NumFactions do

		faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched = GetFactionInfo(factionIndex)

		if ( faction_name == TITAN_FACTIONS_INACTIVE and TitanGetVar(TITAN_FACTIONS_ID, "HideInactive") == 1 ) then
			break
		end

		if ( not faction_isHeader ) then
			if ( TitanGetVar(TITAN_FACTIONS_ID, "HideExalted") == 1 and faction_standingID == 8 ) then
				-- do nothing
			else
				-- Contributed by Nyrine in FuBar_Factions comments on WoWInterface.
				if ( faction_atWarWith ) then
					atWarText = TitanUtils_GetRedText(" (AW)")
				else
					atWarText = ""
				end

				tooltipRichText = tooltipRichText..TitanUtils_GetGreenText(faction_name)..atWarText.."\t"..TitanPanelFactions_FindRep(faction_standingID)

				if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
					tooltipRichText = tooltipRichText.."  ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")"
				elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
					local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
					tooltipRichText = tooltipRichText.."  ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")  ("..bval.."%)"
				else
					local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
					tooltipRichText = tooltipRichText.."  ("..bval.."%)"
				end

				if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRunecloth") == 1 ) then
					if ( 
						faction_name == TITAN_FACTIONS_DARKSPEAR_TROLLS or
						-- @PHANX: temp fix for mysterious bug in German client, not detecting Darkspear Trolls for runecloth counting
						string.find(faction_name, TITAN_FACTIONS_DARKSPEAR_TROLLS) or
						faction_name == TITAN_FACTIONS_ORGRIMMAR or 
						faction_name == TITAN_FACTIONS_THUNDER_BLUFF or 
						faction_name == TITAN_FACTIONS_UNDERCITY or 
						faction_name == TITAN_FACTIONS_DARNASSUS or 
						faction_name == TITAN_FACTIONS_GNOMEREGAN_EXILES or 
						faction_name == TITAN_FACTIONS_IRONFORGE or 
						faction_name == TITAN_FACTIONS_STORMWIND_CITY 
					) then
						local rval = math.floor( ( (42000 - faction_barValue) / 50 ) + 0.5 )
						if ( rval > 0 ) then
							tooltipRichText = tooltipRichText.."  |cffffaec8("..rval.." RC)|r"
						end
					end
				end

				-- @NYRINE: show session rep gain
				-- @PHANX: toggle showing session rep gain
				if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowSession") == 1 ) then
					if ( not faction_sessionStart[faction_name] ) then
						faction_sessionStart[faction_name] = 0
					end
					faction_sessionGain = faction_barValue - faction_sessionStart[faction_name]
					if ( faction_sessionGain ~= 0 ) then
						tooltipRichText = tooltipRichText.."  ["..faction_sessionGain.."]"
					end
				end

				tooltipRichText = tooltipRichText.."\n"
			end
		else
			tooltipRichText = tooltipRichText.."\n"..TitanUtils_GetNormalText(faction_name).."\n"
		end
	end

	-- remove the last \n
	tooltipRichText = string.sub(tooltipRichText, 1, string.len(tooltipRichText)-1)

	return tooltipRichText
end

--------------------------------------------------------------------------
-- create 2nd level right-click menu
--------------------------------------------------------------------------
function TitanPanelRightClickMenu_PrepareFactionsMenu()

	local info = {}

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then
			info = {}
			info.text = TITAN_FACTIONS_ABOUT_POPUP_TEXT
			info.value = "AboutTextPopUP"
			info.notClickable = 1
			info.isTitle = 0
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		end

		if ( UIDROPDOWNMENU_MENU_VALUE == "Monitor" ) then

			info = {}
			info.text = TITAN_FACTIONS_MONITOR_TOGGLE_TEXT
			info.func = TitanPanelFactions_MonitorToggle
			info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor")
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

			info = {}
			info.text = TITAN_FACTIONS_MONITORBLIZZARD_TOGGLE_TEXT
			info.func = TitanPanelFactions_MonitorBlizzardToggle
			info.checked = TitanGetVar(TITAN_FACTIONS_ID, "MonitorBlizzard")
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

			info = {}
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

			local NumFactions = GetNumFactions()

			local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith
			local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched

			local factionIndex

			for factionIndex=1, NumFactions do

				info = {}
				info.text = ""

				faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched = GetFactionInfo(factionIndex)

				-- Added ability to hide inactive factions (Phanx)
				if ( faction_name == TITAN_FACTIONS_INACTIVE and TitanGetVar(TITAN_FACTIONS_ID, "HideInactive") == 1 ) then
					break
				end

				if ( not faction_isHeader ) then

					if ( TitanGetVar(TITAN_FACTIONS_ID, "HideExalted") == 1 and faction_standingID == 8 ) then
						-- do nothing
					else
						-- Contributed by Nyrine in FuBar_Factions comments on WoWInterface.
						if ( faction_atWarWith ) then
							atWarText = TitanUtils_GetRedText(" (AW)")
						else
							atWarText = ""
						end

						info.text = info.text..TitanUtils_GetGreenText(faction_name)..atWarText..":".."\t"..TitanPanelFactions_FindRep(faction_standingID).." ("

						if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
							info.text = info.text..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")\n"
						elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
							local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
							info.text = info.text..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..") ("..bval.."%)\n"
						else
							local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
							info.text = info.text..bval.."%)\n"
						end

						info.value = info.text

						info.func = TitanPanelFactions_SetMonitorFaction

						info.checked = nil

						if ( info.text == TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction") ) then
							info.checked = 1
						end

						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
					end
				end

			end
		end

		return
	end

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_FACTIONS_ID].menuText)

	-- monitor
	info = {}
	info.text = TITAN_FACTIONS_MONITOR
	info.value = "Monitor"
	info.hasArrow = 1
	UIDropDownMenu_AddButton(info)

	info = {}
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	info = {}
	info.text = TITAN_FACTIONS_SHOW_RAW
	info.func = TitanPanelFactions_ShowRawToggle
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw")
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	info = {}
	info.text = TITAN_FACTIONS_SHOW_BOTH
	info.func = TitanPanelFactions_ShowBothToggle
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth")
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	info = {}
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	info = {}
	info.text = TITAN_FACTIONS_SHOW_SESSION
	info.func = TitanPanelFactions_ShowSessionToggle
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowSession")
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)

	info = {}
	info.text = TITAN_FACTIONS_SHOW_RUNECLOTH
	info.func = TitanPanelFactions_ShowRuneclothToggle
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowRunecloth")
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)

	info = {}
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	info = {}
	info.text = TITAN_FACTIONS_HIDE_INACTIVE
	info.func = TitanPanelFactions_HideInactiveToggle
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "HideInactive")
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)

	info = {}
	info.text = TITAN_FACTIONS_HIDE_EXALTED
	info.func = TitanPanelFactions_HideExaltedToggle
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "HideExalted")
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)

	info = {}
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	TitanPanelRightClickMenu_AddToggleIcon(TITAN_FACTIONS_ID)
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_FACTIONS_ID)
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_FACTIONS_ID, TITAN_PANEL_MENU_FUNC_HIDE)

	-- info about plugin
	info = {}
	info.text = TITAN_FACTIONS_ABOUT_TEXT
	info.value = "DisplayAbout"
	info.hasArrow = 1
	UIDropDownMenu_AddButton(info)

end

--------------------------------------------------------------------------
-- Factions functions
--------------------------------------------------------------------------
-- Round function
function round(x)
	return floor(x+0.5)
end

function TitanPanelFactions_UpdateMonitor()

	if ( TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction") ~= nil ) then
		local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched
		local tmp_faction = ""
		local NumFactions = GetNumFactions()
		local factionIndex
		for factionIndex = 1, NumFactions do
			faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched = GetFactionInfo(factionIndex)
			if ( string.find(TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction"), faction_name) ) then
				-- Contributed by Nyrine in FuBar_Factions comments on WoWInterface.
				if ( faction_atWarWith ) then
					atWarText = TitanUtils_GetRedText(" (AW)")
				else
					atWarText = ""
				end
				tmp_faction = TitanUtils_GetGreenText(faction_name)..atWarText..":".."\t"..TitanPanelFactions_FindRep(faction_standingID).." ("
				if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
					tmp_faction = tmp_faction..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")\n"
				elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
					local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
					tmp_faction = tmp_faction..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..") ("..bval.."%)\n"
				else
					local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
					tmp_faction = tmp_faction..bval.."%)\n"
				end
				TitanSetVar(TITAN_FACTIONS_ID, "MonitorFaction", tmp_faction)
				break
			end
		end
	elseif ( TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction") == nil and TitanGetVar(TITAN_FACTIONS_ID, "MonitorBlizzard") == 1 ) then
		-- we don't have a monitored faction, and we want to monitor the watched faction

		local wfaction_name, wfaction_standingID, wfaction_barMin, wfaction_barMax, wfaction_barValue = GetWatchedFactionInfo()

		-- do we have a watched faction?
		if ( wfaction_name ) then

			-- we have a watched faction, get more info
			local NumFactions = GetNumFactions()
			local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched
			local factionIndex
			for factionIndex=1, NumFactions do
				faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched = GetFactionInfo(factionIndex)
				if ( faction_name == wfaction_name ) then
					if ( faction_atWarWith ) then
						atWarText = TitanUtils_GetRedText(" (AW)")
					else
						atWarText = ""
					end
					monitorText = TitanUtils_GetGreenText(faction_name)..atWarText..":".."\t"..TitanPanelFactions_FindRep(faction_standingID).." ("
					if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
						monitorText = monitorText..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")\n"
					elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
						local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
						monitorText = monitorText..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..") ("..bval.."%)\n"
					else
						local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
						monitorText = monitorText..bval.."%)\n"
					end

					-- set watched faction as monitored faction
					TitanSetVar(TITAN_FACTIONS_ID, "MonitorFaction", monitorText)

					break
				end
			end
		end
	end

end

function TitanPanelFactions_MonitorToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowMonitor", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowMonitor", 1)
		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowLabelText") ~= 1 ) then
			TitanSetVar(TITAN_FACTIONS_ID, "ShowLabelText", 1)
		end
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_MonitorBlizzardToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "MonitorBlizzard") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "MonitorBlizzard", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "MonitorBlizzard", 1)
	end
--	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 ) then
			TitanPanelFactions_UpdateMonitor()
--	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_SetMonitorFaction()

	local wasMonitoringBlizzard = 0

	-- @PHANX: temporarily disable watch sync so button text update doesn't prevent us changing monitored faction
	if ( TitanGetVar(TITAN_FACTIONS_ID, "MonitorBlizzard") == 1 ) then
		TitanSetVar(TITAN_FACTIONS_ID, "MonitorBlizzard", nil)
		wasMonitoringBlizzard = 1
	end

	TitanSetVar(TITAN_FACTIONS_ID, "MonitorFaction", this.value)

	-- @PHANX: if we disabled watch sync, enable it now and update watched faction to match new monitored faction
	if ( wasMonitoringBlizzard == 1 ) then

		local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue
		local faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched
		local NumFactions = GetNumFactions()
		local factionIndex
		for factionIndex = 1, NumFactions do
			faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed, faction_isWatched = GetFactionInfo(factionIndex)
			if ( string.find(TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction"), faction_name) ) then
				SetWatchedFactionIndex(factionIndex)
				break
			end
		end

		TitanSetVar(TITAN_FACTIONS_ID, "MonitorBlizzard", 1)

	end

	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_ShowRawToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowRaw", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowRaw", 1)
		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
			TitanSetVar(TITAN_FACTIONS_ID, "ShowBoth", nil)
		end
	end
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 ) then
			TitanPanelFactions_UpdateMonitor()
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_ShowBothToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowBoth", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowBoth", 1)
		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
			TitanSetVar(TITAN_FACTIONS_ID, "ShowRaw", nil)
		end
	end
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 ) then
			TitanPanelFactions_UpdateMonitor()
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_ShowSessionToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowSession") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowSession", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowSession", 1)
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_ShowRuneclothToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRunecloth") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowRunecloth", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowRunecloth", 1)
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_HideInactiveToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "HideInactive") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "HideInactive", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "HideInactive", 1)
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_HideExaltedToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "HideExalted") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "HideExalted", nil)
	else
		TitanSetVar(TITAN_FACTIONS_ID, "HideExalted", 1)
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID)
end

function TitanPanelFactions_FindRep(standingID)
	if ( standingID == 0 ) then
		return UNKNOWN -- unknown
	elseif ( standingID == 1 ) then
		return FactionTextHated -- hated
	elseif ( standingID == 2) then
		return FactionTextHostile -- hostile
	elseif ( standingID == 3) then
		return FactionTextUnfriendly -- unfriendly
	elseif ( standingID == 4) then
		return FactionTextNeutral -- neutral
	elseif ( standingID == 5) then
		return FactionTextFriendly -- friendly
	elseif ( standingID == 6) then
		return FactionTextHonored -- honored
	elseif ( standingID == 7) then
		return FactionTextRevered -- revered
	elseif ( standingID == 8) then
		return FactionTextExalted -- exalted
	end
end

--------------------------------------------------------------------------
-- debug
--------------------------------------------------------------------------
function TitanPanelFactions_ChatPrint(msg)
        DEFAULT_CHAT_FRAME:AddMessage(msg)
end