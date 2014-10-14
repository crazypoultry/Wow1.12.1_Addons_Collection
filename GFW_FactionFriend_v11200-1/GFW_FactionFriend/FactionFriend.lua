------------------------------------------------------
-- FactionFriend.lua
------------------------------------------------------

FFF_Config = {};
FFF_BankCount = {};
FFF_LastBarSwitchTime = 0;

function FFF_OnLoad()

	FFF_Orig_ReputationWatchBar_Update = ReputationWatchBar_Update;
	ReputationWatchBar_Update = FFF_ReputationWatchBar_Update;
	
	FFF_Orig_ReputationWatchBar_OnEnter = ReputationWatchBar:GetScript("OnEnter");
	ReputationWatchBar:SetScript("OnEnter", FFF_ReputationWatchBar_OnEnter);
	FFF_Orig_ReputationWatchBar_OnLeave = ReputationWatchBar:GetScript("OnLeave");
	ReputationWatchBar:SetScript("OnLeave", FFF_ReputationWatchBar_OnLeave);
	
	this:RegisterEvent("UPDATE_FACTION");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_CONTROL_GAINED");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	
	table.insert(UISpecialFrames,"FFF_OptionsFrame");	

	-- Register Slash Commands
	SLASH_FFF1 = "/factionfriend";
	SLASH_FFF2 = "/ff";
	SlashCmdList["FFF"] = function(msg)
		if FFF_OptionsFrame:IsVisible() then
			HideUIPanel(FFF_OptionsFrame);
		else
			ShowUIPanel(FFF_OptionsFrame);
		end
	end
	
end

function FFF_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	elseif( event == "PLAYER_LEAVING_WORLD" ) then
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		this:RegisterEvent("BAG_UPDATE");
	elseif( event == "PLAYER_CONTROL_GAINED" ) then
		if (FFF_OnTaxi) then
			FFF_OnTaxi = nil;
			FFF_CheckZone();
		end
	elseif ( event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED" ) then
		if (UnitOnTaxi("player")) then
			FFF_OnTaxi = 1;
			return;
		end
		FFF_CheckZone();
	elseif ( event == "CHAT_MSG_COMBAT_FACTION_CHANGE" ) then
		if (FFF_Config.NoRepGained) then return; end
		
		local currentZone = GetRealZoneText();
		local zoneFaction = FFF_ZoneFactions[UnitFactionGroup("player")][currentZone] or FFF_ZoneFactions.Neutral[currentZone];
		if (FFF_FACTION_STANDING_INCREASED == nil) then
			FFF_FACTION_STANDING_INCREASED = GFWUtils.FormatToPattern(FACTION_STANDING_INCREASED);
		end
		local _, _, factionName = string.find(arg1, FFF_FACTION_STANDING_INCREASED);
		if (FFF_Config.NoZones) then
			local watchedFaction = GetWatchedFactionInfo();
			if (watchedFaction ~= factionName and GetTime() - FFF_LastBarSwitchTime > 5) then
				FFF_SetWatchedFaction(factionName);
			end
		else
			if (not zoneFaction or zoneFaction == factionName) then
				local watchedFaction = GetWatchedFactionInfo();
				if (watchedFaction ~= factionName and GetTime() - FFF_LastBarSwitchTime > 5) then
					FFF_SetWatchedFaction(factionName);
				end
			end
		end
	elseif ( event == "BAG_UPDATE") then
		FFF_ReputationWatchBar_Update();
	elseif ( event == "UNIT_INVENTORY_CHANGED") then
		if (arg1 == "player") then
			FFF_ReputationWatchBar_Update();
		end
	elseif( event == "BANKFRAME_OPENED" ) then
		FFF_ScanBank();
	end
end

function FFF_CheckZone()
	if (FFF_Config.NoZones) then return; end
	
	local currentZone = GetRealZoneText();
	local zoneFaction = FFF_ZoneFactions[UnitFactionGroup("player")][currentZone] or FFF_ZoneFactions.Neutral[currentZone];
	if (zoneFaction) then
		local watchedFaction = GetWatchedFactionInfo();
		if (watchedFaction ~= zoneFaction and GetTime() - FFF_LastBarSwitchTime > 5) then
			FFF_SetWatchedFaction(zoneFaction);
		end
	end
end

function FFF_SetWatchedFaction(factionName)
	for index = 1, GetNumFactions() do
		local name = GetFactionInfo(index);
		if (name == factionName and not IsFactionInactive(index)) then
			SetWatchedFactionIndex(index);
			FFF_LastBarSwitchTime = GetTime();
			break;
		end
	end
end

function FFF_ScanBank()
	FFF_BankCount = {};
	
	local bagList = { BANK_CONTAINER };
	for i=NUM_BAG_SLOTS+1, (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS), 1 do
		table.insert(bagList, i);
	end
	
	for index, bagID in pairs(bagList) do
		local size = GetContainerNumSlots(bagID);
		if (size) then
			for slotID = size, 1, -1 do
				local link = GetContainerItemLink(bagID, slotID);
				if (link) then
					local _, _, itemID = string.find(link, "item:(%d+)");
					itemID = tonumber(itemID);
					if (itemID and FFF_IsFactionItem(itemID)) then
						local _, itemCount = GetContainerItemInfo(bagID, slotID);
						FFF_BankCount[itemID] = (FFF_BankCount[itemID] or 0) + itemCount;
					end
				end
			end
		end
	end
end

function FFF_IsFactionItem(itemID)
	for factionName, factionInfo in pairs(FFF_ItemInfo) do
		for quest, qInfo in pairs(factionInfo) do
			for id, qtyPerTurnin in pairs(qInfo.items) do
				if (id == itemID) then 
					return true; 
				end
			end
		end
	end
end

function FFF_GetItemCount(itemID)
	--if (itemID == 21436) then return 35; end	-- debug
	if (FFF_BankCount == nil) then
		FFF_BankCount = {};
	end
	return (FFF_BankCount[itemID] or 0) + FFF_CountItemInBags(itemID);
end

function FFF_CountItemInBags(itemID)
	local count = 0;
	for i = 0, NUM_BAG_FRAMES do
		for j = 1, GetContainerNumSlots(i) do
			local link = GetContainerItemLink(i, j)
			if (link) then
				local _, _, id = string.find(link, "item:(%d+)")
				if (tonumber(id) == itemID) then
					local _, stack = GetContainerItemInfo(i, j)
					count = count + stack;
				end
			end
		end
	end
	return count;
end

function FFF_GetWatchedFactionPotential(withReport)

	local factionName, standing, min, max, value = GetWatchedFactionInfo();
	local factionInfo = FFF_ItemInfo[factionName];
	if (factionInfo == nil) then return 0; end
	
	local totalPotential = 0;
	local reportLines;
	if (withReport) then
		if (FFF_BankCount == nil) then
			FFF_BankCount = {};
		end
		reportLines = {};
	end
	local multiplier = 1;
	local _, race = UnitRace("player");
	if (race == "Human") then
		multiplier = 1.1;
	end
	local itemsAccountedFor = {};
	for quest, qInfo in pairs(factionInfo) do
		if ((qInfo.minStanding and standing >= qInfo.minStanding) or not qInfo.minStanding) then
			if ((qInfo.maxStanding and standing <= qInfo.maxStanding) or not qInfo.maxStanding) then
				local potentialValue = 0;
				
				local turninCounts = {};
				local reportItemLines = {};
				for itemID, qtyPerTurnin in pairs(qInfo.items) do
					local countInBags = FFF_GetItemCount(itemID) - (itemsAccountedFor[itemID] or 0);
					--GFWUtils.Print(countInBags.."x "..GFWUtils.ItemLink(itemID))
					local turnins = math.floor(countInBags / qtyPerTurnin);
					itemsAccountedFor[itemID] = turnins * qtyPerTurnin;
					table.insert(turninCounts, turnins);
					if (withReport and turnins > 0) then
						local itemLink = GFWUtils.ItemLink(itemID);
						local lineItem = string.format(FFF_REPORT_LINE_ITEM, turnins * qtyPerTurnin, itemLink);
						if (FFF_BankCount[itemID] and FFF_BankCount[itemID] > 0) then
							lineItem = lineItem ..string.format(FFF_COUNT_IN_BANK, FFF_BankCount[itemID]);
						end
						table.insert(reportItemLines, lineItem);
					end
				end
				--DevTools_Dump(turninCounts);
				
				local numTurnins;
				local reportLineHeader;
				if (table.getn(turninCounts) == 1) then
					numTurnins = turninCounts[1];
				elseif (table.getn(turninCounts) > 1) then
					numTurnins = math.min(unpack(turninCounts));
				else
					numTurnins = 0;
				end
				potentialValue = numTurnins * qInfo.value * multiplier;
				
				if (qInfo.maxValue and standing == qInfo.maxStanding) then
					if (value >= qInfo.maxValue) then
						potentialValue = 0;
					end
					local maxPotential = qInfo.maxValue - value;
					potentialValue = math.min(potentialValue, maxPotential);
				end
				if (potentialValue > 0 and withReport) then
					local reportLineHeader = string.format(FFF_REPORT_NUM_POINTS, potentialValue);
					if (numTurnins > 1 and not qInfo.useItem) then
						reportLineHeader = reportLineHeader ..string.format(FFF_REPORT_NUM_TURNINS, numTurnins);
					end
					reportLineHeader = reportLineHeader ..":";
					table.insert(reportLines, {[reportLineHeader] = reportItemLines});
				end
				
				totalPotential = totalPotential + potentialValue;
			end
		end
	end
	return totalPotential, reportLines;

end

function FFF_ReputationWatchBar_Update(newLevel)
	
	FFF_Orig_ReputationWatchBar_Update(newLevel);

	local name, reaction, min, max, value = GetWatchedFactionInfo();
	if (not name) then return; end
	
	-- Normalize values
	max = max - min;
	value = value - min;
	min = 0;

	local itemsValue = FFF_GetWatchedFactionPotential();
	local tickSet = math.max(((value + itemsValue) / max) * ReputationWatchStatusBar:GetWidth(), 0);
	FFF_ReputationTick:ClearAllPoints();
	if (tickSet > ReputationWatchStatusBar:GetWidth() or itemsValue == 0 or FFF_Config.NoShowPotential) then
	    FFF_ReputationTick:Hide();
	    FFF_ReputationExtraFillBarTexture:Hide();
	else
	    FFF_ReputationTick:Show();
	    FFF_ReputationTick:SetPoint("CENTER", "ReputationWatchStatusBar", "LEFT", tickSet, 0);
	    local color = FACTION_BAR_COLORS[reaction];
	    FFF_ReputationExtraFillBarTexture:Show();
	    FFF_ReputationExtraFillBarTexture:SetPoint("TOPRIGHT", "ReputationWatchStatusBar", "TOPLEFT", tickSet, 0);
	    FFF_ReputationExtraFillBarTexture:SetVertexColor(color.r, color.g, color.b, 0.15);
	
	end

end

function FFF_ReputationTick_Tooltip()

	local x,y;
	x,y = FFF_ReputationTick:GetCenter();
	if ( FFF_ReputationTick:IsVisible() ) then
		if ( x >= ( GetScreenWidth() / 2 ) ) then
			GameTooltip:SetOwner(FFF_ReputationTick, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(FFF_ReputationTick, "ANCHOR_RIGHT");
		end
	else
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	end
	
	local potential, reportLines = FFF_GetWatchedFactionPotential(1);
	local tooltipText = string.format(REPUTATION_TICK_TOOLTIP, potential);
	local name, reaction, min, max, value = GetWatchedFactionInfo();
    local color = FACTION_BAR_COLORS[reaction];
	
	local standingName = getglobal("FACTION_STANDING_LABEL"..reaction);
	if (UnitSex("player") == 3) then
		local standingName = getglobal("FACTION_STANDING_LABEL"..reaction.."_FEMALE");
	end
	GameTooltip:SetText(name..": "..standingName, color.r, color.g, color.b);

	if (potential == 0) then return; end

	GameTooltip:AddLine(tooltipText);
	for _, reportLine in pairs(reportLines) do
		for reportHeader, itemLines in pairs(reportLine) do
			local r, g, b = HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b;
			GameTooltip:AddDoubleLine(reportHeader, itemLines[1], r, g, b, r, g, b);
			if (table.getn(itemLines) > 1) then
				for i = 2, table.getn(itemLines) do
					GameTooltip:AddDoubleLine(" ", itemLines[i], r, g, b, r, g, b);
				end
			end
		end
	end
	GameTooltip:Show();

end

function FFF_ReputationWatchBar_OnEnter()
	FFF_Orig_ReputationWatchBar_OnEnter();
	if (FFF_Config.NoShowPotential) then return; end
	FFF_ReputationTick_Tooltip();
	FFF_ShowingTooltip = true;
end

function FFF_ReputationWatchBar_OnLeave()
	FFF_Orig_ReputationWatchBar_OnLeave();
	if (FFF_ShowingTooltip) then
		GameTooltip:Hide();
		FFF_ShowingTooltip = false;
	end
end

-- Options window
-- All options are the inverse of their checkboxes; this way we store nothing in SV if default.
FFF_OptionsText = {
	["Zones"] = FFF_OPTION_ZONES,
	["RepGained"] = FFF_OPTION_REP_GAINED,
	["ShowPotential"] = FFF_OPTION_SHOW_POTENTIAL,
};

function FFF_OptionsShow()

	local version = GetAddOnMetadata("GFW_FactionFriend", "Version");
	FFF_VersionText:SetText("v. "..version);

	for option, description in FFF_OptionsText do
		local button = getglobal("FFF_OptionsButton_"..option);
		local text = getglobal("FFF_OptionsButton_"..option.."Text");
		
		if (button and text) then
			button:SetChecked(not FFF_Config["No"..option]);
			text:SetText(description);
		end
	end
	
end

function FFF_OptionsClick()
	local button = this:GetName();
	local option = string.gsub(button, "FFF_OptionsButton_", "");
	FFF_Config["No"..option] = not this:GetChecked();
end
