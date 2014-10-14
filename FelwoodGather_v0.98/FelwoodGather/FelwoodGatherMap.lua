--[[
FelwoodGather map functions
Timer manager for felwood fruit gathering.
Author: nor3
]]--

FELWOODGATHER_MAP_INTERVAL = 0.5;

FelwoodGatherMap_Config={
	alpha = 0.5,
	scale = 1.0,
	autoshow = false,
	posx = 100,
	posy = 50,
	lock = false
};

FWG_MapCoords = {
	offset_x = 0.319336,
	offset_y = 0.046875,
	width=0.25,
	height=0.75911458
};

FelwoodGather_ClassColor={
	[FWG_HUNTER] = { r = 0.67, g = 0.83, b = 0.45 },
	[FWG_WARLOCK] = { r = 0.58, g = 0.51, b = 0.79 },
	[FWG_PRIEST] = { r = 1.0, g = 1.0, b = 1.0 },
	[FWG_PALADIN] = { r = 0.96, g = 0.55, b = 0.73 },
	[FWG_MAGE] = { r = 0.41, g = 0.8, b = 0.94 },
	[FWG_ROGUE] = { r = 1.0, g = 0.96, b = 0.41 },
	[FWG_DRUID] = { r = 1.0, g = 0.49, b = 0.04 },
	[FWG_SHAMAN] = { r = 0.96, g = 0.55, b = 0.73 },
	[FWG_WARRIOR] = { r = 0.78, g = 0.61, b = 0.43 }
};


-- tooltip support
function FelwoodGatherMap_SetToolTipText(tooltip)
	local unitButton;
	local newLineString = "";
	local tooltipText = "";
	-- Check object
	for n, Objs in FelwoodGather_WorldObjs do 
		mapPOI = getglobal("FWG_FramePOI"..n);
		if ( mapPOI:IsVisible() and MouseIsOver(mapPOI) ) then
			tooltipText = tooltipText..newLineString..mapPOI.toolTip;
			newLineString = "\n";
		end
	end

	-- Check player
	if ( MouseIsOver(FWG_Player) ) then
		tooltipText = tooltipText..newLineString..UnitName(FWG_Player.unit);
		newLineString = "\n";
	end
	-- Check party
	if (GetNumRaidMembers() == 0 ) then
		for i=1, MAX_PARTY_MEMBERS do
			unitButton = getglobal("FWG_Party"..i);
			if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
				tooltipText = tooltipText..newLineString..UnitName(unitButton.unit);
				newLineString = "\n";
			end
		end
	else
		--Check Raid
		for i=1, MAX_RAID_MEMBERS do
			unitButton = getglobal("FWG_Raid"..i);
			if ( unitButton:IsVisible() and MouseIsOver(unitButton) and not UnitIsUnit("player", unitButton.unit) ) then
				tooltipText = tooltipText..newLineString..UnitName(unitButton.unit);
				newLineString = "\n";
			end
		end
	end
	tooltip:SetText(tooltipText);
	tooltip:Show();
end
function FelwoodGatherMap_SetupToolTip(id)
	tooltip = getglobal("FWG_Tooltip");
	local mapPOI = getglobal("FWG_FramePOI"..id);
	local x, y = mapPOI:GetCenter();
	local parentX, parentY = mapPOI:GetParent():GetCenter();
	if ( x > parentX ) then
		tooltip:SetOwner(mapPOI, "ANCHOR_LEFT");
	else
		tooltip:SetOwner(mapPOI, "ANCHOR_RIGHT");
	end
	FelwoodGatherMap_SetToolTipText(tooltip);
end

function FelwoodGatherMap_SetupPCToolTip(this)
	tooltip = getglobal("FWG_Tooltip");
	local x, y = this:GetCenter();
	local parentX, parentY = this:GetParent():GetCenter();
	if ( x > parentX ) then
		tooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		tooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	FelwoodGatherMap_SetToolTipText(tooltip);
end


function FelwoodGatherMap_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	FWG_MapTitle:SetText(FELWOODGATHERMAP_TITLE);
end

function FelwoodGatherMap_OnMap(x, y) 
	return (
			(x >= 0) and 
--			(x <= 256) and
			(x <= 384) and
			(y >= 0) and
			(y <= 551));
end

function FelwoodGatherMap_CalcMapCoords(x, y)
	local mx, my;
	mx = (x-FWG_MapCoords.offset_x) * FelwoodGather_WorldMapDetailFrameWidth -1;
	my = (y-FWG_MapCoords.offset_y) * FelwoodGather_WorldMapDetailFrameHeight - 1;
	return mx, my;
end

function FelwoodGatherMap_OnUpdate(elapsed)
	if (not FelwoodGatherMap_UpdateTimer) then
		FelwoodGatherMap_UpdateTimer = 0;
	else
		FelwoodGatherMap_UpdateTimer = FelwoodGatherMap_UpdateTimer + elapsed;
		if (FelwoodGatherMap_UpdateTimer > FELWOODGATHER_MAP_INTERVAL) then
			FelwoodGatherMap_UpdateTimer = 0;
			FelwoodGatherMap_Draw();
		end
	end

end
function FelwoodGatherMap_CheckParty()
	FelwoodGatherMap_PartyInfo = {};
	for i=1, MAX_PARTY_MEMBERS do
		if (UnitName("party"..i) ~= nil ) then
			FelwoodGatherMap_PartyInfo[UnitName("party"..i)] = UnitClass("party"..i);
		end
	end
end

function FelwoodGatherMap_Draw()
	x, y = GetPlayerMapPosition("player");
	x, y = FelwoodGatherMap_CalcMapCoords(x, y);
	if (FelwoodGatherMap_OnMap(x,y) ) then
		FWG_Player:SetPoint("CENTER", "FWG_WrapperFrame", "TOPLEFT", x, -y); 
		FWG_Player:Show();
	else 
		FWG_Player:Hide();
	end

	if (GetNumRaidMembers() > 0) then
--		for i=1, MAX_PARTY_MEMBERS do
--			partyMemberFrame = getglobal("FWG_Party"..i);
--			partyMemberFrame:Hide();
--		end
		for i=1, MAX_RAID_MEMBERS do
			local unit = "raid"..i;
			partyX, partyY = GetPlayerMapPosition(unit);
			partyMemberFrame = getglobal("FWG_Raid"..i);
			if ( (partyX ~= 0 or partyY ~= 0) and not UnitIsUnit(unit, "player") ) then
				-- raid rosters that is not in same group			
				partyX, partyY = FelwoodGatherMap_CalcMapCoords(partyX, partyY);
 				if (FelwoodGatherMap_OnMap(partyX, partyY)) then 
	 				partyMemberFrame:SetPoint("CENTER", "FWG_WrapperFrame", "TOPLEFT", partyX, -partyY);
	 				color = FelwoodGather_ClassColor[UnitClass(unit)];
	 				getglobal("FWG_Raid"..i.."Icon"):SetVertexColor(color.r, color.g, color.b);
					partyMemberFrame:Show();
				else
					partyMemberFrame:Hide();
				end
			else
				partyMemberFrame:Hide();
			end
		end
	else
		for i=1, MAX_RAID_MEMBERS do
			partyMemberFrame = getglobal("FWG_Raid"..i);
			partyMemberFrame:Hide();
		end
	end
	if (GetNumPartyMembers() > 0) then
		for i=1, MAX_PARTY_MEMBERS do
			partyX, partyY = GetPlayerMapPosition("party"..i);
			partyMemberFrame = getglobal("FWG_Party"..i);
			if ( partyX == 0 and partyY == 0 ) then
				partyMemberFrame:Hide();
			else
				partyX, partyY = FelwoodGatherMap_CalcMapCoords(partyX, partyY);
				FelwoodGather_DebugPrint("party"..i.." "..partyX.." "..partyY);
				if ( FelwoodGatherMap_OnMap(partyX, partyY)) then
					FelwoodGather_DebugPrint("party"..i.." drawing");
					partyMemberFrame:SetPoint("CENTER", "FWG_WrapperFrame", "TOPLEFT", partyX, -partyY);
	 				color = FelwoodGather_ClassColor[UnitClass("party"..i)];
--	 				color = RAID_CLASS_COLORS[string.upper(UnitClass("party"..i))];
	 				getglobal("FWG_Party"..i.."Icon"):SetVertexColor(color.r, color.g, color.b);
					partyMemberFrame:Show();
				else 
					partyMemberFrame:Hide();
				end
			end
		end
	end
	local corpseX, corpseY = GetCorpseMapPosition();
	if ( corpseX == 0 and corpseY == 0 ) then
		FWG_Corpse:Hide();
	else
		corpseX, corpseY = FelwoodGatherMap_CalcMapCoords(corpseX, corpseY);
		if (FelwoodGatherMap_OnMap(corpseX, corpseY) ) then
			FWG_Corpse:SetPoint("CENTER", "FWG_WrapperFrame", "TOPLEFT", corpseX, -corpseY);
			FWG_Corpse:Show();
		end
	end
	for n, Objs in FelwoodGather_WorldObjs do 
		-- set texture
		local mapPOITexture = getglobal("FWG_FramePOI"..n.."Texture");
		if (mapPOITexture == nil) then 
			FelwoodGather_Print("get texture failed" .. n);
		else 
			mapPOITexture:SetTexture(Objs.texture);
			if ( Objs.isThere == false ) then
				mapPOITexture:SetVertexColor(0.5, 0.5, 0.5, 1);
			else 
				mapPOITexture:SetVertexColor(1,1,1,1);
			end
			mapPOITexture:SetWidth(FelwoodGather_Config.scale);
			mapPOITexture:SetHeight(FelwoodGather_Config.scale);
		end
		-- draw icon
		local mapPOI = getglobal("FWG_FramePOI"..n);

		mnX = (Objs.x/100 - FWG_MapCoords.offset_x) * FelwoodGather_WorldMapDetailFrameWidth;
		mnY = -(Objs.y/100 - FWG_MapCoords.offset_y )* FelwoodGather_WorldMapDetailFrameHeight;
		mapPOI:SetPoint("CENTER", "FWG_WrapperFrame", "TOPLEFT", mnX, mnY);
		mapPOI:SetWidth(FelwoodGather_Config.scale);
		mapPOI:SetHeight(FelwoodGather_Config.scale);

		-- calculate estimation time
		if (Objs.timer == 0) then
			eta = nil;
			etatext = FWG_NO_TIMER;
		else
			eta = (Objs.timer + FELWOODGATHER_TIMER) - GetTime();
			if(eta < 0 ) then
				est = "-";
			else 
				est = "";
			end
			d, h, m, s = ChatFrame_TimeBreakDown(math.abs(eta));
			etatext = format("%s%02d:%02d", est, m, s);
		end

		seentext = "";
		if (Objs.firstSeen ~= 0) then
			spent = GetTime() - Objs.firstSeen;
			d, h, m, s = ChatFrame_TimeBreakDown(spent);
			seentext = format(FWG_FIRSTSEEN_FORMAT, h,m,s);
		else
			seentext = FWG_NO_TIMER;
		end
		mapPOI.toolTip = format(FWG_TOOLTIP_TEXT, Objs.item, Objs.location, etatext, seentext);
		mapPOI.toolTip = mapPOI.toolTip  .. format(FWG_TOOLTIP_TEXT_EXT, Objs.times);

		local mapPOILabel = getglobal("FWG_FramePOI"..n.."Label");
		if (mapPOILabel == nil) then 
			FelwoodGather_Print("failed to get FWG_FramePOI"..n.."Label");
		else 
			mapPOILabel:SetText(etatext);
			if (FelwoodGather_Latest.index == n ) then
				mapPOILabel:SetTextColor(FelwoodGather_LabelColorHighlight.r, 
							FelwoodGather_LabelColorHighlight.g, 
							FelwoodGather_LabelColorHighlight.b);
			else
				if ( Objs.timer == 0 ) then
					mapPOILabel:SetTextColor(
						FelwoodGather_LabelColorPast.r, 
						FelwoodGather_LabelColorPast.g, 
						FelwoodGather_LabelColorPast.b);
				else
					if( eta < 0) then
						mapPOILabel:SetTextColor(
							FelwoodGather_LabelColorWarn2.r, 
							FelwoodGather_LabelColorWarn2.g, 
							FelwoodGather_LabelColorWarn2.b);
					elseif (Objs.status == 2) then
						mapPOILabel:SetTextColor(
							FelwoodGather_LabelColorWarn2.r, 
							FelwoodGather_LabelColorWarn2.g, 
							FelwoodGather_LabelColorWarn2.b);
					elseif (Objs.status == 1) then
						mapPOILabel:SetTextColor(
							FelwoodGather_LabelColorWarn1.r, 
							FelwoodGather_LabelColorWarn1.g, 
							FelwoodGather_LabelColorWarn1.b);
					else
						mapPOILabel:SetTextColor(
							FelwoodGather_LabelColorNormal.r, 
							FelwoodGather_LabelColorNormal.g, 
							FelwoodGather_LabelColorNormal.b);
					end
				end
			end
			mapPOILabel:Show();
		end
	end
end

function FelwoodGatherMap_PingMap(arg1)
	--TODO
end

function FelwoodGatherMap_OnEvent()
	if ( event == "ADDON_LOADED") then
		if( arg1 == FELWOODGATHER_FELWOODGATHER ) then
		end
	elseif (event == "VARIABLES_LOADED") then

		local playerName = UnitName("player");
		UIDropDownMenu_Initialize(FWG_MapConextMenu, FelwoodGatherMap_ContextMenu_Initialize, "MENU");
		-- TODO make charscter depends settings.
		if ((playerName) and (playerName ~= UNKNOWNOBJECT)) then
			if( FelwoodGatherMap_Config.alpha == nil ) then
				FelwoodGatherMap_Config.alpha = 0.5;
			end
			if( FelwoodGatherMap_Config.scale == nil ) then
				FelwoodGatherMap_Config.scale = 1.0;
			end
			if( FelwoodGatherMap_Config.autoshow == nil ) then
				FelwoodGatherMap_Config.autoshow = false;
			end
			if( FelwoodGatherMap_Config.posx == nil ) then
				FelwoodGatherMap_Config.posx = 100;
			end
			if( FelwoodGatherMap_Config.posy == nil ) then
				FelwoodGatherMap_Config.posy = 50;
			end
			if( FelwoodGatherMap_Config.lock == nil ) then
				FelwoodGatherMap_Config.lock = false;
			end
		end
		FelwoodGatherMap_Options_Init();
	elseif ( event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") then
		local curZone = GetRealZoneText();
		if( (curZone ~= nil) and curZone == FWG_FELWOOD_MAPNAME) then
			if(FelwoodGatherMap_Config.autoshow == true) then
				FelwoodGatherMap_ShowFrame();
			end
		else
			FWG_Frame:Hide();
		end
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
--		FelwoodGatherMap_CheckParty();
	else
		FelwoodGather_Print("Unknown event: "..event);
	end
end


function FelwoodGatherMap_UpdateAlpha()
	FWG_WrapperFrame:SetAlpha(FelwoodGatherMap_Config.alpha);

end

function FelwoodGatherMap_UpdateScale()

	local x, y, halfx, halfy, newx, newy, old;
	x = FWG_Frame:GetLeft();
	y = FWG_Frame:GetBottom();

	FWG_Frame:ClearAllPoints();
	FWG_Frame:SetPoint("CENTER", "UIParent", "CENTER");

	halfx = (FWG_Frame:GetLeft() * 2);
	halfy = (FWG_Frame:GetBottom() * 2);
	
	old = FWG_Frame:GetScale();
	FWG_Frame:SetScale(FelwoodGatherMap_Config.scale);
	FelwoodGatherMap_Config.scale = FWG_Frame:GetScale();
	old = old - FWG_Frame:GetScale();
	if old ~= 0 then
		FWG_Frame:ClearAllPoints();
		FWG_Frame:SetPoint("CENTER", "UIParent", "CENTER");

		newx = (FWG_Frame:GetLeft() * 2);
		newy = (FWG_Frame:GetBottom() * 2);

		x = ((newx / halfx) * x);
		y = ((newy / halfy) * y);
		FWG_Frame:ClearAllPoints();
		FWG_Frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
	else
		FWG_Frame:ClearAllPoints();
		FWG_Frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
	end

end

function FelwoodGatherMap_SavePosition()
	if(FWG_Frame:GetLeft() == nil) then
		FelwoodGatherMap_Config.posx = 100;
	else
		FelwoodGatherMap_Config.posx = FWG_Frame:GetLeft();
	end
	if(FWG_Frame:GetBottom() == nil) then
		FelwoodGatherMap_Config.posy = 50;
	else
		FelwoodGatherMap_Config.posy = FWG_Frame:GetBottom();
	end
end

function FelwoodGatherMap_RestorePosition()
	FWG_Frame:ClearAllPoints();
	FWG_Frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", FelwoodGatherMap_Config.posx, FelwoodGatherMap_Config.posy);
end

function FelwoodGatherMap_ResetMapPosition()
	FelwoodGatherMap_Config.posx = 100;
	FelwoodGatherMap_Config.posy = 50;
	FWG_Frame:ClearAllPoints();
	FWG_Frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", FelwoodGatherMap_Config.posx, FelwoodGatherMap_Config.posy);
end

function FelwoodGatherMap_ShowFrame()
	FelwoodGatherMap_UpdateAlpha();
	FWG_Frame:Show();
	FelwoodGatherMap_UpdateScale();
	FelwoodGatherMap_RestorePosition();
end

function FelwoodGatherMap_ToggleMapWindow()
	if (FWG_Frame:IsVisible()) then
		FWG_Frame:Hide();
	else
		local curZone = GetRealZoneText();
		if( (curZone ~= nil) and curZone == FWG_FELWOOD_MAPNAME) then
			FelwoodGatherMap_ShowFrame();
			FELWOODGATHER_ACTIVE = true;
		else
			FelwoodGather_Print(FELWOODGATHER_ONLY_IN_FELWOOD);
		end
	end
end



function FelwoodGatherMap_ContextMenu_Initialize()
	local info = {};

	if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
	else
		info.isTitle = true;
		info.text = FELWOODGATHER_FELWOODGATHER.." "..FELWOODGATHER_VERSION;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = FELWOODGATHER_LOCKWINDOW;
		info.func = FelwoodGatherMap_Menu_ToggleLockWindow;
		info.checked = FelwoodGatherMap_Config.lock;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = FELWOODGATHER_MAPCONFIG;
		info.func = FelwoodGatherMap_ToggleMapConfigWindow;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_ShareTimer;
		info.text = FELWOODGATHER_SHARETIMER;
		UIDropDownMenu_AddButton(info);
	end
end

function FelwoodGatherMap_ToggleMapConfigWindow()
	if(FelwoodGatherMap_OptionsFrame:IsVisible()) then
		FelwoodGatherMap_OptionsFrame:Hide();
	else
		FelwoodGatherMap_OptionsFrame:Show();
	end
end

function FelwoodGatherMap_Menu_ToggleLockWindow() 
	if (FelwoodGatherMap_Config.lock ) then
		FelwoodGatherMap_Config.lock = false;
	else 
		FelwoodGatherMap_Config.lock = true;
	end
end

function FelwoodGatherMap_OnContextMenu(button)
	ToggleDropDownMenu(1, nil, FWG_MapConextMenu, FWG_MapTitle, 0, 0);
end

function FelwoodGatherMap_Options_OnLoad()
	UIPanelWindows['FelwoodGatherMap_OptionsFrame'] = {area = 'center', pushable = 0};
	FelwoodGatherMap_OptionsFrameTitle:SetText(FELWOODGATHERMAP_OPTIONS);
	
end

function FelwoodGatherMap_Options_Init()
	FelwoodGatherMap_SliderAlpha:SetValue(FelwoodGatherMap_Config.alpha);
	FelwoodGatherMap_SliderScale:SetValue(FelwoodGatherMap_Config.scale);
	FelwoodGatherMap_AutoShow:SetChecked(FelwoodGatherMap_Config.autoshow);
end

function FelwoodGatherMap_Options_OnHide()
	
end

