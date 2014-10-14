-- Constants
TITAN_QUANJURE_ID = "Quanjure";
TITAN_QUANJURE_RIGHT_ID = "QuanjureRight";
Quanjure_Portaling = false;

function TitanQuanjure_OnLoad()
	this.registry = { 
		id = TITAN_QUANJURE_ID,
		menuText = "Quanjure",
		buttonTextFunction = "TitanQuanjure_GetButtonText",
		tooltipTitle = "Quanjure",
		tooltipTextFunction = "TitanQuanjure_GetTooltipText",
		frequency = 0.9, 
		icon = "Interface\\Icons\\INV_Drink_18",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};
end

function TitanQuanjureRight_OnLoad()
	this.registry = { 
		id = TITAN_QUANJURE_RIGHT_ID,
		menuText = "Quanjure (" .. QUANJURE_TITAN_RIGHTSIDE .. ")",
		tooltipTitle = "Quanjure",
		tooltipTextFunction = "TitanQuanjure_GetTooltipText",
		frequency = 1, 
		icon = "Interface\\Icons\\INV_Drink_18",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
		}
	};
end

function TitanQuanjure_GetButtonText(id)
	local retstr = "";
	if (TitanGetVar(TITAN_QUANJURE_ID, "ShowLabelText")) then
		local portals;
		if(UnitFactionGroup("player") == QUANJURE_HORDE) then
			portals = QUANJURE_PORTALS_HORDE;
		else
			portals = QUANJURE_PORTALS_ALLIANCE;
		end
		local portalpos = nil;
		local portaltime = 0;
		local portalnum = 0;
		local portalstring = "";
		for i=1,3,1 do
			local portalpos = Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL .. ": " .. portals[i]);
			if portalpos ~= nil then
				local start,duration = GetSpellCooldown(portalpos, SpellBookFrame.bookType);
				if start ~= 0 and portaltime < floor(duration - (GetTime() - start)) then
					portaltime = floor(duration - (GetTime() - start));
					portalnum = i;
					if portaltime > 1 then Quanjure_Portaling = true end;
				end
			end
		end
		if portaltime > 0 and Quanjure_Portaling then
			retstr = portals[portalnum] .. " (" .. portaltime .. ")";
			if portaltime <= 1 then Quanjure_Portaling = false end;
		else
			retstr = "Quanjure";
		end
	end
	return retstr;
end

function TitanQuanjure_GetTooltipText()
	local retstr = TitanUtils_GetGreenText(QUANJURE_TITAN_TOOLTIP_CONJURE);
	return retstr;
end

function TitanQuanjure_OnClick(button)
	if ( button == "LeftButton" ) then
		quanjure();
	end
end

function TitanPanelRightClickMenu_PrepareQuanjureRightMenu()
	TitanPanelRightClickMenu_PrepareQuanjureMenu(TITAN_QUANJURE_RIGHT_ID)
end

function TitanPanelRightClickMenu_PrepareQuanjureMenu(buttonid)
	if buttonid ~= TITAN_QUANJURE_RIGHT_ID then buttonid = TITAN_QUANJURE_ID end
	local teleCount = Quanjure_ItemCount(QUANJURE_REAGENTS_TELEPORT);
	local portalCount = Quanjure_ItemCount(QUANJURE_REAGENTS_PORTAL);
	local plural = "";
	local portals, bgtrinkets;
	local miscStuff = {};
	if(UnitFactionGroup("player") == QUANJURE_HORDE) then
		portals = QUANJURE_PORTALS_HORDE;
		bgtrinkets = QUANJURE_MISC_BG_HORDE;
	else
		portals = QUANJURE_PORTALS_ALLIANCE;
		bgtrinkets = QUANJURE_MISC_BG_ALLIANCE;
	end
	
	if (UnitClass("Player") == QUANJURE_MAGE and UnitLevel("Player") > 19) then
		if(teleCount == 1) then	plural = QUANJURE_PORTALS_SINGULAR else plural = QUANJURE_PORTALS_PLURAL end
		TitanPanelRightClickMenu_AddTitle(QUANJURE_PORTALS_TELEPORT .. " (" .. TitanUtils_GetHighlightText(teleCount .. " " .. plural) .. ")", UIDROPDOWNMENU_MENU_LEVEL);
		if(teleCount > 0) then
			for i=1,3,1 do
				if Quanjure_GetSpellPosition(QUANJURE_PORTALS_TELEPORT .. ": " .. portals[i]) ~= nil then
					TitanPanelRightClickMenu_AddCommand(portals[i], QUANJURE_PORTALS_TELEPORT .. ": " .. portals[i], "Quanjure_Tele", UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
	end
	
	if (UnitClass("Player") == QUANJURE_MAGE and UnitLevel("Player") > 39) then
		TitanPanelRightClickMenu_AddSpacer();
		if(portalCount == 1) then plural = QUANJURE_PORTALS_SINGULAR else plural = QUANJURE_PORTALS_PLURAL end
		TitanPanelRightClickMenu_AddTitle(QUANJURE_PORTALS_PORTAL .. " (" .. TitanUtils_GetHighlightText(portalCount .. " " ..plural) .. ")", UIDROPDOWNMENU_MENU_LEVEL);
		if(portalCount > 0) then
			for i=1,3,1 do
				if Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL .. ": " .. portals[i]) ~= nil then
					TitanPanelRightClickMenu_AddCommand(portals[i], QUANJURE_PORTALS_PORTAL .. ": " .. portals[i], "Quanjure_Tele", UIDROPDOWNMENU_MENU_LEVEL);
				elseif GetLocale() == "frFR" then -- Hardcoded fix for french localization inconsistency with "Portail: "'s trailing space.
					if Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL_FR .. ": " .. portals[i]) ~= nil then
						TitanPanelRightClickMenu_AddCommand(portals[i], QUANJURE_PORTALS_PORTAL_FR .. ": " .. portals[i], "Quanjure_Tele", UIDROPDOWNMENU_MENU_LEVEL);
					end
				end
			end
		end
	end	
		
	if(Quanjure_ItemCount(QUANJURE_HEARTHSTONE) > 0) then
		if (UnitClass("Player") == QUANJURE_MAGE) then TitanPanelRightClickMenu_AddSpacer() end;
		TitanPanelRightClickMenu_AddTitle(QUANJURE_HEARTHSTONE .. " (" .. Quanjure_HearthCD() .. ")", UIDROPDOWNMENU_MENU_LEVEL);
		TitanPanelRightClickMenu_AddCommand(GetBindLocation(), "hearth", "TitanQuanjure_Hearth", UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	
	
	for i=1,getn(QUANJURE_MISC_ENGINEER) do
		local trinkx,trinky = Quanjure_FindItem(nil,nil,QUANJURE_MISC_ENGINEER[i], nil, nil);
		if trinky > Q_NIL then table.insert(miscStuff, {trinkx,trinky,QUANJURE_MISC_ENGINEER[i]}) end
	end
	for i=1,getn(bgtrinkets) do
		local trinkx,trinky = Quanjure_FindItem(nil,nil,bgtrinkets[i], nil, nil);
		if trinky > Q_NIL then table.insert(miscStuff, {trinkx,trinky,bgtrinkets[i]}) end
	end
	for i=1,getn(QUANJURE_MISC_SPELLS) do
		if Quanjure_GetSpellPosition(QUANJURE_MISC_SPELLS[i]) ~= nil then
			table.insert(miscStuff, {Q_NIL,Q_NIL,QUANJURE_MISC_SPELLS[i]})
		end
	end
	if getn(miscStuff) > 0 then
		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddTitle(QUANJURE_MISC_TITLE, UIDROPDOWNMENU_MENU_LEVEL);
		for i=1,getn(miscStuff) do
			local cooldownText = "";
			if ( miscStuff[i][1] == Q_NIL and miscStuff[i][2] == Q_NIL ) then 
				start,duration = GetSpellCooldown(Quanjure_GetSpellPosition(miscStuff[i][3]), SpellBookFrame.bookType);
				if ( start == 0 ) then cooldownText = " (" .. QUANJURE_READY .. ")" else cooldownText = " (" .. TitanUtils_GetHighlightText(TitanUtils_GetAbbrTimeText(duration-floor(GetTime()-start))) .. ")" end
				TitanPanelRightClickMenu_AddCommand(miscStuff[i][3] .. cooldownText, miscStuff[i][3], "TitanQuanjure_Spell", UIDROPDOWNMENU_MENU_LEVEL);
			else
				if ( miscStuff[i][1] == Q_NIL ) then
					start, duration = GetInventoryItemCooldown("player", miscStuff[i][2]);
					if ( start == 0 ) then cooldownText = " (" .. QUANJURE_READY .. ")" else cooldownText = " (" .. TitanUtils_GetHighlightText(TitanUtils_GetAbbrTimeText(duration-floor(GetTime()-start))) .. ")" end
				else 
					start, duration = GetContainerItemCooldown(miscStuff[i][1], miscStuff[i][2]);
					if ( start == 0 or (GetTime() - (start + duration)) > -30) then cooldownText = " (" .. QUANJURE_BAG .. ")" else cooldownText = " (" .. TitanUtils_GetHighlightText(TitanUtils_GetAbbrTimeText(duration-floor(GetTime()-start))) .. ")" end
				end
				TitanPanelRightClickMenu_AddCommand(miscStuff[i][3] .. cooldownText, miscStuff[i], "TitanQuanjure_Trinket", UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle(QUANJURE_TITAN_OPTIONS, UIDROPDOWNMENU_MENU_LEVEL);
	TitanPanelRightClickMenu_AddCommand(QUANJURE_SETUP, "", "Quanjure_Toggle", UIDROPDOWNMENU_MENU_LEVEL);
	
	local info = {};
	info.text = QUANJURE_MINIMAP_SETUP;
	info.func = QuanjureButton_Toggle;
	info.value = QUANJURE_MINIMAP_SETUP;
	info.checked = Quanjure_Config[QPlayer]["QuanjureButtonShown"];
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	if buttonid == TITAN_QUANJURE_ID then 
		TitanPanelRightClickMenu_AddToggleIcon(buttonid);
		TitanPanelRightClickMenu_AddToggleLabelText(buttonid);
	end
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, buttonid, TITAN_PANEL_MENU_FUNC_HIDE);
end



function TitanQuanjure_Spell()
	CastSpellByName(this.value);
end

function TitanQuanjure_Trinket()
	local trinketArray = this.value;
	if trinketArray[1] == Q_NIL then
		UseInventoryItem(trinketArray[2]);
	else
		PickupContainerItem(trinketArray[1],trinketArray[2]);
		AutoEquipCursorItem();
	end
end

function TitanQuanjure_Hearth()
	Quanjure_Consume(QUANJURE_HEARTHSTONE);
end