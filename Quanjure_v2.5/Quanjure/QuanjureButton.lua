function QuanjureButton_OnClick(button)
	if button == "RightButton" then
		if not IsControlKeyDown() and not IsShiftKeyDown() then
			if(Quanjure_Config[QPlayer]["DropDownFix"] ~= nil) then
				Quanjure_ToggleDropDownMenu(1, nil, QuanjureDropdown);
			else
				ToggleDropDownMenu(1, nil, QuanjureDropdown);
			end
		end
	
	
	elseif button == "LeftButton" then
		quanjure();
	end
end

function QuanjureButton_Init()
	if(Quanjure_Config[QPlayer]["QuanjureButtonShown"]) then
		QuanjureButtonFrame:Show();
	else
		QuanjureButtonFrame:Hide();
	end
end

function QuanjureButton_Toggle()
	if(QuanjureButtonFrame:IsVisible()) then
		QuanjureButtonFrame:Hide();
		Quanjure_Config[QPlayer]["QuanjureButtonShown"] = false;
	else
		QuanjureButtonFrame:Show();
		Quanjure_Config[QPlayer]["QuanjureButtonShown"] = true;
	end
	QuanjureCheck3:SetChecked(Quanjure_Config[QPlayer]["QuanjureButtonShown"]);
end

function QuanjureButton_UpdatePosition()
	if Quanjure_Config[QPlayer]["QuanjureButtonPosition"] == nil then
		Quanjure_Config[QPlayer]["QuanjureButtonPosition"] = 0;
	end
	QuanjureButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(Quanjure_Config[QPlayer]["QuanjureButtonPosition"])),
		(78 * sin(Quanjure_Config[QPlayer]["QuanjureButtonPosition"])) - 55
	);
end

function QuanjureButton_BeingDragged()
	if(IsShiftKeyDown()) then
    	local xpos,ypos = GetCursorPosition() 
    	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 
	
    	xpos = xmin-xpos/UIParent:GetScale()+70 
    	ypos = ypos/UIParent:GetScale()-ymin-70 

    	QuanjureButton_SetPosition(math.deg(math.atan2(ypos,xpos)));
    end;
end

function QuanjureButton_SetPosition(v)
    if(v < 0) then
        v = v + 360;
    end

    Quanjure_Config[QPlayer]["QuanjureButtonPosition"] = v;
    QuanjureButton_UpdatePosition();
end

function QuanjureButton_OnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText("Quanjure "..QUANJURE_VERSION);    
    GameTooltip:AddLine("|cFFFFFFFF" .. QUANJURE_TOOLTIP .. "|r");
    GameTooltip:Show();
end


--------------------------
-- Drop down menu stuff --
--------------------------

function QuanjureDropdown_OnLoad()
	UIDropDownMenu_Initialize(this, QuanjureDropdown_Initialize, "MENU");
end

function QuanjureDropdown_Initialize()
	local dropdown;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	QuanjureDropdown_InitButtons();
end

function QuanjureDropdown_InitButtons()
	local spacer = {}
	spacer.disabled = 1;
	local info = {};
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
	
	info = {};
	info.text = "Quanjure by Quantuvis";
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Version " .. QUANJURE_VERSION;
	info.disabled = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	info.text = QUANJURE_DATE;
	UIDropDownMenu_AddButton(info);
	UIDropDownMenu_AddButton(spacer);
	
	if (UnitClass("Player") == QUANJURE_MAGE and UnitLevel("Player") > 19) then
		if(teleCount == 1) then	plural = QUANJURE_PORTALS_SINGULAR else plural = QUANJURE_PORTALS_PLURAL end
	
		info = {};
		info.text = QUANJURE_PORTALS_TELEPORT .. " (" .. Quanjure_HighlightText(teleCount .. " " .. plural) .. ")";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		if(teleCount > 0) then
			for i=1,3,1 do
				if Quanjure_GetSpellPosition(QUANJURE_PORTALS_TELEPORT .. ": " .. portals[i]) ~= nil then
					info = {};
					info.text = portals[i];
					info.value = QUANJURE_PORTALS_TELEPORT .. ": " .. portals[i];
					info.notCheckable = 1;
					info.func = function() Quanjure_Tele() end;
					UIDropDownMenu_AddButton(info);
				end
			end
		end
	end
	
	
	if (UnitClass("Player") == QUANJURE_MAGE and UnitLevel("Player") > 39) then
		UIDropDownMenu_AddButton(spacer);
		if(portalCount == 1) then plural = QUANJURE_PORTALS_SINGULAR else plural = QUANJURE_PORTALS_PLURAL end
		
		info = {};
		info.text = QUANJURE_PORTALS_PORTAL .. " (" .. Quanjure_HighlightText(portalCount .. " " ..plural) .. ")"
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		if(portalCount > 0) then
			
			for i=1,3,1 do
				if Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL .. ": " .. portals[i]) ~= nil then
					info = {};
					info.text = portals[i];
					info.value = QUANJURE_PORTALS_PORTAL .. ": " .. portals[i];
					info.notCheckable = 1;
					info.func = function() Quanjure_Tele() end;
					UIDropDownMenu_AddButton(info);
				elseif GetLocale() == "frFR" then -- Hardcoded fix for french localization inconsistency with "Portail: "'s trailing space.
					if Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL_FR .. ": " .. portals[i]) ~= nil then
						info = {};
						info.text = portals[i];
						info.value = QUANJURE_PORTALS_PORTAL_FR .. ": " .. portals[i];
						info.notCheckable = 1;
						info.func = function() Quanjure_Tele() end;
						UIDropDownMenu_AddButton(info);
					end
				end
			end
		end
	end	
	
	if(Quanjure_ItemCount(QUANJURE_HEARTHSTONE) > 0) then
		if (UnitClass("Player") == QUANJURE_MAGE) then UIDropDownMenu_AddButton(spacer); end;
		info = {};
		info.text = QUANJURE_HEARTHSTONE .. " (" .. Quanjure_HearthCD() .. ")";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = GetBindLocation();
		info.notCheckable = 1;
		info.func = function() Quanjure_Consume(QUANJURE_HEARTHSTONE); end;
		UIDropDownMenu_AddButton(info);
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
		UIDropDownMenu_AddButton(spacer);
		info = {};
		info.text = QUANJURE_MISC_TITLE;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		for i=1,getn(miscStuff) do
			local cooldownText = "";
			if ( miscStuff[i][1] == Q_NIL and miscStuff[i][2] == Q_NIL ) then 
				start,duration = GetSpellCooldown(Quanjure_GetSpellPosition(miscStuff[i][3]), SpellBookFrame.bookType);
				if ( start == 0 ) then cooldownText = " (" .. QUANJURE_READY .. ")" else cooldownText = " (" .. Quanjure_HighlightText(Quanjure_GetTimeText(duration-floor(GetTime()-start))) .. ")" end
				info = {};
				info.text = miscStuff[i][3] .. cooldownText
				info.notCheckable = 1;
				info.func = function() CastSpellByName(miscStuff[i][3]); end;
				UIDropDownMenu_AddButton(info);
			else
				if ( miscStuff[i][1] == Q_NIL ) then
					start, duration = GetInventoryItemCooldown("player", miscStuff[i][2]);
					if ( start == 0 ) then cooldownText = " (" .. QUANJURE_READY .. ")" else cooldownText = " (" .. Quanjure_HighlightText(Quanjure_GetTimeText(duration-floor(GetTime()-start))) .. ")" end
				else 
					start, duration = GetContainerItemCooldown(miscStuff[i][1], miscStuff[i][2]);
					if ( start == 0 or (GetTime() - (start + duration)) > -30) then cooldownText = " (" .. QUANJURE_BAG .. ")" else cooldownText = " (" .. Quanjure_HighlightText(Quanjure_GetTimeText(duration-floor(GetTime()-start))) .. ")" end
				end
				
				info = {};
				info.text = miscStuff[i][3] .. cooldownText
				info.notCheckable = 1;
				info.value = miscStuff[i];
				info.func = function() Quanjure_UseTrinket(); end;
				UIDropDownMenu_AddButton(info);
			end
		end
	end
	
	UIDropDownMenu_AddButton(spacer);
	info = {};
	info.text = QUANJURE_OPTIONS;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	info = {};
	info.text = QUANJURE_SETUP;
	info.notCheckable = 1;
	info.func = function() Quanjure_Toggle(); end;
	UIDropDownMenu_AddButton(info);
	info = {};
	info.text = "Hide Minimap Button";
	info.notCheckable = 1;
	info.func = function() QuanjureButton_Toggle(); end;
	UIDropDownMenu_AddButton(info);
end



-----------------------
-- Utility Functions --
-----------------------

function Quanjure_HighlightText(text)
	if (text) then
		return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function Quanjure_Tele(target)
	if this.value then target = this.value end;
	local qparty = GetNumPartyMembers();
	local qraid = GetNumRaidMembers() ;
	local qtype = strsub(target,0,4);
	if((qparty > 0 or qraid > 0) and qtype == strsub(QUANJURE_PORTALS_TELEPORT,0,4)) then
		Quanjure_Spam("|cFFFF0000".. QUANJURE_PORTALS_TELEPORT_WARNING .. "|r",1);
	elseif((qparty == 0 and qraid == 0) and qtype == strsub(QUANJURE_PORTALS_PORTAL,0,4)) then
		Quanjure_Spam("|cFFFF0000" .. QUANJURE_PORTALS_PORTAL_WARNING .. "|r",1);
	end
	
	if Quanjure_Dismount() then
		Quanjure_Spam(QUANJURE_DISMOUNTING);
	else
		CastSpellByName(target);
	end
end

function Quanjure_HearthCD()
	local start,duration,_,cool,hearthcd
	for i=NUM_BAG_FRAMES,0,-1 do
		for j=GetContainerNumSlots(i),1,-1 do
			if (Quanjure_GetItemName(i,j) == QUANJURE_HEARTHSTONE) then 
				y = i;
				z = j;
			end
		end
	end
	start,duration,_= GetContainerItemCooldown(y,z)
	if(start == 0) then return "|cFFFFFFFF" .. QUANJURE_READY .. "|r" end;
	return Quanjure_HighlightText(Quanjure_GetTimeText(duration-floor(GetTime()-start-60)));
end


function Quanjure_GetTimeText(s)
	if (s < 0) then
		return "N/A";
	end
	
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	local padding = "";
	
	local timeText = "";
	if (hours ~= 0) then
		timeText = timeText..hours..":";
	end
	if (minutes < 10 and hours > 0) then padding = "0" end
	timeText = timeText..padding..minutes..":";
	
	if seconds < 10 then padding = "0" end
	timeText = timeText..padding..seconds;
	
	return timeText;
end

function Quanjure_UseTrinket(val)
	local trinketArray
	if this.value then
		trinketArray = this.value;
	else
		trinketArray = val;
	end
	if trinketArray[1] == Q_NIL then
		UseInventoryItem(trinketArray[2]);
	else
		PickupContainerItem(trinketArray[1],trinketArray[2]);
		AutoEquipCursorItem();
	end
end


-- Off-screen DropDown prevention - Ripped from TitanUtils
function Quanjure_ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	if ( not level ) then
		level = 1;
	end
	UIDROPDOWNMENU_MENU_LEVEL = level;
	UIDROPDOWNMENU_MENU_VALUE = value;
	local listFrame = getglobal("DropDownList"..level);
	local listFrameName = "DropDownList"..level;
	local tempFrame;
	local point, relativePoint, relativeTo;
	if ( not dropDownFrame ) then
		tempFrame = this:GetParent();
	else
		tempFrame = dropDownFrame;
	end
	if ( listFrame:IsVisible() and (UIDROPDOWNMENU_OPEN_MENU == tempFrame:GetName()) ) then
		listFrame:Hide();
	else
		-- Hide the listframe anyways since it is redrawn OnShow() 
		listFrame:Hide();
		
		-- Frame to anchor the dropdown menu to
		local anchorFrame;

		if ( not dropDownFrame ) then
			dropDownFrame = this:GetParent();
		end
		UIDROPDOWNMENU_OPEN_MENU = dropDownFrame:GetName();
		listFrame:ClearAllPoints();
		-- If there's no specified anchorName then use left side of the dropdown menu
		if ( not anchorName ) then
			-- See if the anchor was set manually using setanchor
			if ( dropDownFrame.xOffset ) then
				xOffset = dropDownFrame.xOffset;
			end
			if ( dropDownFrame.yOffset ) then
				yOffset = dropDownFrame.yOffset;
			end
			if ( dropDownFrame.point ) then
				point = dropDownFrame.point;
			end
			if ( dropDownFrame.relativeTo ) then
				relativeTo = dropDownFrame.relativeTo;
			else
				relativeTo = UIDROPDOWNMENU_OPEN_MENU.."Left";
			end
			if ( dropDownFrame.relativePoint ) then
				relativePoint = dropDownFrame.relativePoint;
			end
		elseif ( anchorName == "cursor" ) then
			relativeTo = "UIParent";
			local cursorX, cursorY = GetCursorPosition();
			if ( not xOffset ) then
				xOffset = 0;
			end
			if ( not yOffset ) then
				yOffset = 0;
			end
			xOffset = cursorX + xOffset;
			yOffset = cursorY + yOffset;
		else
			relativeTo = anchorName;
		end
		if ( not xOffset or not yOffset ) then
			xOffset = 8;
			yOffset = 22;
		end
		if ( not point ) then
			point = "TOPLEFT";
		end
		if ( not relativePoint ) then
			relativePoint = "BOTTOMLEFT";
		end
		listFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset);

		getglobal(listFrameName.."Backdrop"):Hide();
		getglobal(listFrameName.."MenuBackdrop"):Show();
		
		UIDropDownMenu_Initialize(dropDownFrame, dropDownFrame.initialize, nil, level);
		-- If no items in the drop down don't show it
		if ( listFrame.numButtons == 0 ) then
			return;
		end


		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		-- I overwrote this part to fix Blizzard's offscreen bug
		listFrame:Show();
		local offscreenX, offscreenY = Quanjure_GetOffscreen(listFrame);
		if(offscreenX == 0) then offscreenX = nil else offscreenX = 1 end;
		if(offscreenY == 0) then offscreenY = nil else offscreenY = 1 end;
		if ( offscreenY ) then
			listFrame:ClearAllPoints();
			listFrame:SetPoint("TOPRIGHT", relativeTo, "TOPLEFT", xOffset, -yOffset);
		end
	end
end

function Quanjure_GetOffscreen(frame)
	local offscreenX, offscreenY;

	if ( frame and frame:GetLeft() and frame:GetLeft() * frame:GetEffectiveScale() < UIParent:GetLeft() * UIParent:GetEffectiveScale() ) then
		offscreenX = -1;
	elseif ( frame and frame:GetRight() and frame:GetRight() * frame:GetEffectiveScale() > UIParent:GetRight() * UIParent:GetEffectiveScale() ) then
		offscreenX = 1;
	else
		offscreenX = 0;
	end

	if ( frame and frame:GetTop() and frame:GetTop() * frame:GetEffectiveScale() > UIParent:GetTop() * UIParent:GetEffectiveScale() ) then
		offscreenY = -1;
	elseif ( frame and frame:GetBottom() and frame:GetBottom() * frame:GetEffectiveScale() < UIParent:GetBottom() * UIParent:GetEffectiveScale() ) then
		offscreenY = 1;
	else
		offscreenY = 0;
	end
end