OneRaid 	= {
	version = "4.0.4";
	tasks = {},
	tanks = {},
	flagged	= {},
	voice = {},
	cureId = {},
	blackList = {},
};

function OneRaid:OnLoad()
	
	this:RegisterEvent("VARIABLES_LOADED");

end

function OneRaid:OnEvent()

	if (type(self[event] == "function") and self[event]) then
        self[event](self);
    else
        self:Print("Unhandled event: " .. event, 1, 0, 0);
    end
	
end

function OneRaid:OnUpdate(elapsed)
	
	this.elapsed = this.elapsed or 0;

	if (table.getn(OneRaid.tasks) > 0) then
	    for k, v in OneRaid.tasks do
	    	if (v.runTime <= GetTime()) then
	    		if (v.class) then
					if (type(v.params) == "table" and not v.globalParam) then
						v.class[v.func](v.class, v.params[1], v.params[2], v.params[3], v.params[4], v.params[5]);
					else
						v.class[v.func](v.class, v.params);
					end
				else
					if (type(v.params) == "table" and not v.globalParam) then
						v.func(v.params[1], v.params[2], v.params[3], v.params[4], v.params[5]);
					else
						v.func(v.params);
					end
				end
	    		table.remove(OneRaid.tasks, k);
	    	end
	    end
	end

end



---





function OneRaid:Print(msg, r, g, b)

	DEFAULT_CHAT_FRAME:AddMessage("ØR: " .. msg, OneRaid_Options.raidInfoColor.r, OneRaid_Options.raidInfoColor.g, OneRaid_Options.raidInfoColor.b);

end

function OneRaid:GetUnit(name)
	
	if (GetNumRaidMembers() > 0) then
		for i = 1, GetNumRaidMembers() do
			if (UnitName("raid" .. i) == name) then
				return "raid" .. i, i;
			end
		end
	elseif (GetNumPartyMembers() > 0) then
		if (UnitName("player") == name) then
			return "player";
		end
		for i = 1, GetNumPartyMembers() do
			if (UnitName("party" .. i) == name) then
				return "party" .. i;
			end
		end
	end
	
	return nil;

end

function OneRaid:GetRaidRank(member)

	if (GetNumRaidMembers() > 0) then
		for i = 1, GetNumRaidMembers() do
			local name, rank = GetRaidRosterInfo(i);
			if (name == member) then
				return rank;
			end
		end
	else
		if (IsPartyLeader() and UnitName("player") == member) then
			return 2;
		end
		for i = 1, GetNumPartyMembers() do
			if (UnitName("party" .. i) == member) then
				if (UnitIsPartyLeader("party" .. i)) then
					return 2;
				else
					return 0;
				end
			end
		end
	end
	
	return 0;
	
end

function OneRaid:FilterUnit(unit)

	if (GetNumRaidMembers() > 0) then
		if (string.find(unit, "^raid(%d+)$")) then
        	return unit;
		end
	elseif (GetNumPartyMembers() > 0) then
		if (string.find(unit, "^party(%d+)$")) then
			return unit;
		end
	end
	
	if (unit == "player") then
        return unit;
	end
	
	return nil;
	
end

function OneRaid:Timer(length, class, func, params, globalParam)

	local runTime = GetTime() + length;
	
	table.insert(OneRaid.tasks, { class = class, func = func, runTime = runTime, params = params, globalParam = globalParam });

end

function OneRaid:FormatTime(curTime)

	local seconds, minutes, hours;

	hours = floor(curTime / 60 / 60);
	curTime = curTime - (hours * 60 * 60);
	minutes = floor(curTime / 60);
	curTime = curTime - (minutes * 60);
	seconds = floor(curTime);

	local out = nil;
	local hr, min, sec;

	if (hours <= 1) then
	    hr = " hour ";
	else
	    hr = " hours ";
	end

	if (minutes <= 1) then
	    min = " min ";
	else
	    min = " mins ";
	end

	if (seconds <= 1) then
		sec = " sec";
	else
	    sec = " secs";
	end

	if (hours > 0) then
		out = hours .. hr;
		if (minutes > 0) then
		    out = out .. minutes .. min;
		end
	end

	if (minutes > 0 and not out) then
	    out = minutes .. min;
	    if (seconds > 0) then
	        out = out .. seconds .. sec;
		end
	end

	if (not out) then
	    out = seconds .. sec;
	end

	return out;

end

function OneRaid:SendVersion()

	local ct_bm, bw, ktm, loot = 0, 0, 0, 0;
	
	if (IsAddOnLoaded("CT_BossMods")) then
		ct_bm = 1;
	end
	if (IsAddOnLoaded("BigWigs")) then
		bw = 1;
	end
	if (IsAddOnLoaded("KLHThreatMeter")) then
		ktm = 1;
	end
	if (IsAddOnLoaded("OneLoot")) then
		loot = 1;
	end
	
	self:AddonMessage("VERSION", OneRaid.version, ct_bm, bw, ktm, loot);

end

function OneRaid:SendTanks()

	if (IsRaidLeader()) then
		if (getn(OneRaid.tanks) > 0) then
			local tanks = OneRaid.tanks;
			self:AddonMessage("TANK", "remAll");
			for k, v in tanks do
				self:AddonMessage("TANK", "add", v);
			end
		else
			self:AddonMessage("TANK", "request");
		end
	end
	
end

function OneRaid:SendCooldowns()

	if (not OneRaid.Unit.data[UnitName("player")]) then return; end
	if (not OneRaid.Unit.data[UnitName("player")].cooldowns) then return; end
	
	local cooldowns = OneRaid.Unit.data[UnitName("player")].cooldowns;
	
	for k, v in cooldowns do
		self:AddonMessage("COOLDOWN", k, v);
	end

end

function OneRaid:SendBuffTimes()
	
	local i = 0;
	local index = GetPlayerBuff(i, "HELPFUL");
	while (index >= 0) do
	
		local timeLeft = ceil(GetPlayerBuffTimeLeft(index));
		
		if (timeLeft > 0) then
			OneRaid:AddonMessage("BUFF", index + 1, timeLeft);
		end

		i = i + 1;
		index = GetPlayerBuff(i, "HELPFUL");
		
	end
	
end

function OneRaid:AddonMessage(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

	local args = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 };

	local message = event;
	local type = "RAID";
	
	for k, v in args do	
		message = message .. "¦" .. v;
	end
	
	if (GetNumBattlefieldPositions() > 0) then
		type = "BATTLEGROUND";
	end
		
	SendAddonMessage("ØR", message, type);

end

function OneRaid:GetTalentInfo(sender)

	local talents = "";
	
	for i = 1, GetNumTalentTabs(), 1 do
		for y = 1, GetNumTalents(i), 1 do
			local name, icon, tier, col, rank = GetTalentInfo(i, y);
			talents = talents .. rank;
		end
	end
	
	self:AddonMessage("TALENTS", sender, UnitClass("player"), talents);

end

function OneRaid:LoadBuffs()

	self.buffs = {};
	for k, v in OneRaid_Options.buffs do
		OneRaid.buffs[v.name] = v;
		if (v.groupName) then
			self.buffs[v.groupName] = v;
		end
	end
	
	self.debuffs = {};
	for k, v in OneRaid_Options.debuffs do
		self.debuffs[v.name] = v;
	end
	
	self.statusBuffs = {};
	for k, v in OneRaid_Options.statusBuffs do
		self.statusBuffs[v.name] = v;
	end
	
	self.statusDebuffs = {};
	for k, v in OneRaid_Options.statusDebuffs do
		self.statusDebuffs[v.name] = v;
	end
	
	self.cureDebuffs = {};
	for k, v in OneRaid_Options.cureDebuffs do
		self.cureDebuffs[v.name] = v;
	end
	
end

function OneRaid:LoadClassPriority()

	self.classSort = {};
	for k, v in OneRaid_Options.classPriority do
		self.classSort[v] = k;
	end
	
end

function OneRaid:CureDebuffs(monitorUnit)

	--Can cast some type of cure
	if (OneRaid_Options["cure"  .. ONERAID_DEBUFF_TYPE_MAGIC] or
		OneRaid_Options["cure"  .. ONERAID_DEBUFF_TYPE_DISEASE] or
		OneRaid_Options["cure"  .. ONERAID_DEBUFF_TYPE_POISON] or
		OneRaid_Options["cure"  .. ONERAID_DEBUFF_TYPE_CURSE]) then
		
		local slot =
			OneRaid.cureId[ONERAID_DEBUFF_TYPE_MAGIC] or
			OneRaid.cureId[ONERAID_DEBUFF_TYPE_DISEASE] or
			OneRaid.cureId[ONERAID_DEBUFF_TYPE_POISON] or
			OneRaid.cureId[ONERAID_DEBUFF_TYPE_CURSE];
		
		if (slot) then
			--Cures are on cooldown.
			local start, duration, enable = GetActionCooldown(slot);
			if (start > 0 and duration > 0 and enable > 0) then
				return;
			end
		end

	else
		return;
	end

    local lastTarget = nil;
	local debuffFound = nil;
	local debuffUnit = nil;

	local inCombat = OneRaid.inCombat;

    -- Remember previous target
    if (not UnitName("target")) then
        lastTarget = nil;
    elseif (not UnitIsFriend("player", "target")) then
        lastTarget = "Enemy";
    else
        lastTarget = UnitName("target");
    end

	----
	--1: Get Unit Array
    local units = self:GetUnitArray(monitorUnit);

	----
	--2: Cure Charm first.
	for i, unit in units do
		if (UnitIsCharmed(unit) and not UnitIsFriend("player", "target")) then
			if (UnitClass("player") == ONERAID_PRIEST or UnitClass("player") == ONERAID_SHAMAN) then
				debuffFound, debuffUnit = self:CureDebuff(unit, "Charm", "Charm");
				if (debuffFound) then break; end
			end
		end
	end

	----
	--3: Cure normal debuffs.
	if (not debuffFound) then
		for i, unit in units do
			OneRaid.inCombat = nil;
			local debuff, type = self:IsUnitCurable(unit);
			if (debuff) then
				debuffFound, debuffUnit = self:CureDebuff(unit, debuff, type);
				if (debuffFound) then break; end
			end
		end
	end

	----
    --4: If no debuffs were cured, display a message.
    if (not debuffFound) then
        UIErrorsFrame:AddMessage(ONERAID_CANNOT_CURE, 1.0, 0.6, 0.4, 1.0, UIERRORS_HOLD_TIME);
    else
		if (UnitExists(debuffUnit)) then
        	UIErrorsFrame:AddMessage(string.format(ONERAID_CURING_DEBUFF, debuffFound, UnitName(debuffUnit)), 1.0, 0.6, 0.4, 1.0, UIERRORS_HOLD_TIME);
        end
    end

    -- re-acquire pre-cure target
    if (not lastTarget) then
        ClearTarget();
    elseif (lastTarget == "Enemy") then
        TargetLastEnemy();
    else
        TargetByName(lastTarget);
    end

    if (inCombat and not OneRaid.inCombat) then
    	self:Timer(.3, nil, AttackTarget);
	end

end

function OneRaid:GetUnitArray(monitorUnit)

	local added = {};
	local units = {};
	
	if (monitorUnit) then
	
		tinsert(units, monitorUnit);
		
	else
	
		--1: Add target.
		if (UnitIsFriend("player", "target") or (UnitIsCharmed("target") and not UnitIsFriend("player", "target")) and not OneRaid.blackList[UnitName("target")]) then		
			tinsert(units, "target");
			added[UnitName("target")] = 1;
		end
	
		--2: Add player.
		if (not added[UnitName("player")]) then
	 		tinsert(units, "player");
	 		added[UnitName("player")] = 1;
	 	end
	
		--3: Add units on priority list.
		for i, player in OneRaid_Options.curePriority do
			local unit = self:GetUnit(player);
			if (unit and not added[UnitName(unit)] and not OneRaid.blackList[UnitName(unit)]) then
				tinsert(units, unit);
				added[UnitName(unit)] = 1;
			end
		end
	
		--4: Add party members.
		local min = getn(units) + 1;
		for i = 1, GetNumPartyMembers() do
			local unit = "party" .. i;
			if (not added[UnitName(unit)] and not OneRaid.blackList[UnitName(unit)]) then
				tinsert(units, random(min, getn(units) + 1), unit);
				added[UnitName(unit)] = 1;
			end
		end
	
		--5: Add raid members.
		local min = getn(units) + 1;
		for i = 1, GetNumRaidMembers() do
		    local unit = "raid" .. i;
		    if (not added[UnitName(unit)] and not OneRaid.blackList[UnitName(unit)]) then
		    	tinsert(units, random(min, getn(units) + 1), unit);
		    	added[UnitName(unit)] = 1;
		    end
		end
		
		--6: Add pet
		if (UnitExists("pet")) then
			tinsert(units, "pet");
		end
	
		--7: Add party pets.
		for i = 1, GetNumPartyMembers() do
			local unit = "partypet" .. i;
			if (UnitExists(unit)) then
				tinsert(units, unit);
			end
		end
	
		--8: Add raid pets
		for i = 1, GetNumRaidMembers() do
			local unit = "raidpet" .. i;
			if (UnitExists(unit)) then
				tinsert(units, unit);
			end
		end
	
	end
	
	return units;

end

function OneRaid:IsUnitCurable(unit)

    local i = 1;
    local rdebuff = nil;
    local rdebuffType = nil;

    while (UnitDebuff(unit, i)) do

		OneRaid_Cure_TooltipTextLeft1:SetText(nil);
        OneRaid_Cure_Tooltip:SetUnitDebuff(unit, i);

        local debuff 		= OneRaid_Cure_TooltipTextLeft1:GetText();
		local texture, stack, debuffType = UnitDebuff(unit, i);
		
		local cureSpell = self:GetCureSpell(unit, debuffType);

		if (cureSpell and debuffType and OneRaid_Options["cure" .. debuffType]) then

        	--Unit is not curable if "Ignore Spells" are found.
        	if (OneRaid_Options.cureDebuffs[debuff]) then
        	
        		if (OneRaid_Options.cureDebuffs[debuff].ignore) then
        			return nil;
        		end

				if (not OneRaid_Options.cureDebuffs[debuff][UnitClass(unit)]) then
					rdebuff = debuff;
					rdebuffType = debuffType;
					break;
				end
			else
				rdebuff = debuff;
				rdebuffType = debuffType;
				break;
			end
        	
		end

        i = i + 1;
    end

    return rdebuff, rdebuffType;

end

function OneRaid:GetCureSpell(unit, debuffType)
	
	local cureSpell = nil;
	
	if (UnitClass("player") == ONERAID_PRIEST) then
    	if (debuffType == ONERAID_DEBUFF_TYPE_MAGIC) then
    		if (OneRaid_Options.lowVersion) then
    			cureSpell = ONERAID_SPELL_DISPEL_MAGIC1;
    		else
    			cureSpell = ONERAID_SPELL_DISPEL_MAGIC2;
    		end
    	elseif (debuffType == ONERAID_DEBUFF_TYPE_DISEASE) then
    		if (OneRaid_Options.lowVersion) then
    			cureSpell = ONERAID_SPELL_CURE_DISEASE;
    		else
    			cureSpell = ONERAID_SPELL_ABOLISH_DISEASE;
    		end
    	end
   	elseif (UnitClass("player") == ONERAID_DRUID) then
    	if (debuffType == ONERAID_DEBUFF_TYPE_POISON) then
    		if (OneRaid_Options.lowVersion) then
    			cureSpell = ONERAID_SPELL_CURE_POISON;
    		else
    			cureSpell = ONERAID_SPELL_ABOLISH_POISON;
    		end
    	elseif (debuffType == ONERAID_DEBUFF_TYPE_CURSE) then
    		cureSpell = ONERAID_SPELL_REMOVE_CURSE;
    	end
    elseif (UnitClass("player") == ONERAID_SHAMAN) then
    	if (debuffType == ONERAID_DEBUFF_TYPE_POISON) then
   			cureSpell = ONERAID_SPELL_CURE_POISON;
    	elseif (debuffType == ONERAID_DEBUFF_TYPE_DISEASE) then
    		cureSpell = ONERAID_SPELL_CURE_DISEASE;
    	elseif (debuffType == "Charm") then
    		cureSpell = ONERAID_SPELL_PURGE;
    	end
    elseif (UnitClass("player") == ONERAID_PALADIN) then
    	if (debuffType == ONERAID_DEBUFF_TYPE_POISON) then
   			cureSpell = ONERAID_SPELL_PURIFY;
    	elseif (debuffType == ONERAID_DEBUFF_TYPE_DISEASE) then
    		cureSpell = ONERAID_SPELL_PURIFY;
    	elseif (debuffType == ONERAID_DEBUFF_TYPE_MAGIC) then
    		cureSpell = ONERAID_SPELL_CLEANSE;
    	end
    elseif (UnitClass("player") == ONERAID_MAGE) then
    	if (debuffType == ONERAID_DEBUFF_TYPE_CURSE) then
   			cureSpell = ONERAID_SPELL_REMOVE_LESSER_CURSE;
    	end
    end
    
    return cureSpell;
    
end

function OneRaid:CureDebuff(unit, debuff, debuffType)

    local charmed = nil;    
    
    if (debuff == "Charm") then
    	charmed = 1;
		debuffType = ONERAID_DEBUFF_TYPE_MAGIC;
	end
	
	local cureSpell = self:GetCureSpell(unit, debuffType);

    if (OneRaid_Options["cure" .. debuffType] or charmed) then

	    -- If the player has an actionid mapped to this debuff type, and has an action mapped to that action ID, validate it.
	    if (self.cureId[debuffType] and HasAction(self.cureId[debuffType])) then
	
	        OneRaid_Action_TooltipTextLeft1:SetText(nil);
	        OneRaid_Action_TooltipTextRight1:SetText(nil);
	        OneRaid_Action_Tooltip:SetAction(self.cureId[debuffType]);
	
	        local actionTitle = OneRaid_Action_TooltipTextLeft1:GetText();
	        local actionRank = nil;
	
	        if (actionTitle) then
	            actionRank = OneRaid_Action_TooltipTextRight1:GetText();
	        end
	
	        if (actionRank) then
	            actionTitle = actionTitle .. "(" .. actionRank .. ")";
	        end
	
	        -- If the action mapped to the previously stored actionid is not the expected cure spell, retrieve the new actionid
	        if (actionTitle ~= cureSpell) then
	            -- This will come out "nil" if the spell is no longer mapped
	            self.cureId[debuffType] = self:FindActionID(cureSpell);
	        end
	    else
	        OneRaid.cureId[debuffType] = self:FindActionID(cureSpell);
	    end
	
	    -- Final check to see if the proper spell is mapped
	    if (not self.cureId[debuffType]) then
	    	self:Print(string.format(ONERAID_HOTKEY_CURE, UnitName(unit), cureSpell));
	    else
	        -- The spell is mapped. Cure the target if it's in range.
	        if (self:CheckActionRange(unit, self.cureId[debuffType])) then
	
	        	TargetUnit(unit);
	        	UseAction(self.cureId[debuffType]);
	        	OneRaid.inCombat = nil;
	
	            return debuff, unit;
	        end
	    end
    end

    return nil;

end

function OneRaid:FindActionID(action)

    for i = 1, 120 do

        if (HasAction(i)) then

            OneRaid_Action_TooltipTextLeft1:SetText(nil);

            OneRaid_Action_TooltipTextRight1:SetText(nil);
            OneRaid_Action_Tooltip:SetAction(i);

            local actionTitle = OneRaid_Action_TooltipTextLeft1:GetText();
            local actionRank = nil;

            if (actionTitle) then
                actionRank = OneRaid_Action_TooltipTextRight1:GetText();
            end

            if (actionRank) then
                actionTitle = actionTitle .. "(" .. actionRank .. ")";
            end

            if (actionTitle == action) then
            	return i;
            end

        end

    end

    return nil;

end

function OneRaid:CheckActionRange(unit, action)

    if (not UnitIsVisible(unit)) then
    	return nil;
    end

	if (unit ~= "player") then
        TargetUnit(unit);
        OneRaid.inCombat = nil;
        if (IsActionInRange(action) == 1) then
            return 1;
        else
            return nil;
        end
    else
        return 1;
    end

end

function OneRaid:GetDurability()

	local items = { 1, 2, 3, 5, 6, 7, 8, 9, 10, 16, 17, 18 };

	local broken = 0;
	local curDur = 0;
	local maxDur = 0;

	for i, item in items do
	    OneRaid_Durability_Tooltip:ClearLines();
	    OneRaid_Durability_Tooltip:SetInventoryItem("player", item);
		for j = 1, OneRaid_Durability_Tooltip:NumLines() do
			local line = getglobal("OneRaid_Durability_TooltipTextLeft" .. j):GetText();
			local a, b, min, max = string.find (line, "Durability (%d+) / (%d+)");

			if (min and max) then
				if (tonumber(min) == 0) then
				    broken = broken + 1;
				end
				curDur = curDur + tonumber(min);
				maxDur = maxDur + tonumber(max);
				break;
			end
		end
	end

	return floor((curDur / maxDur) * 100), broken;

end

function OneRaid:GetResists()

	local resists = {};
	
	for i = 2, 6 do
    	base, total = UnitResistance("player", i);
    	resists[i] = total;
	end
	
	return resists;
    	
end

function OneRaid:GetItemCount(item)

	local num = 0;

	for bag = 0, 4 do
	    for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot)
			if (itemLink) then
				local found, found, color, id, name = string.find(itemLink, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r");
				if (name == item) then
				  a, numItem, b, c, d = GetContainerItemInfo(bag, slot);
				  num = num + numItem;
				end
			end
		end
	end

	return num;

end

function OneRaid:ReformRaid(converted)

	local invites = 4 - GetNumPartyMembers();
	
	OneRaid.reforming = 1;
	OneRaid.converted = converted;
	
	for i, name in OneRaid.CurrentRaid do
		if (not OneRaid.invited[name] and name ~= UnitName("player") and not OneRaid:GetUnit(name)) then					
			InviteByName(name);
			OneRaid.invited[name] = 1;
			if (not converted) then
				invites = invites - 1;
				if (invites == 0) then
					break;
				end
			end
		end
	end
	
	if (converted) then
		OneRaid.reforming = nil;
		SetLootMethod("FreeForAll");
	end
end	

function OneRaid:InviteGuild(converted)

	GuildRoster();

	local ranks = {}
	for i = 1, GetNumGuildMembers() do
		local name, rank, rankIndex = GetGuildRosterInfo(i);
		ranks[string.lower(rank)] = rankIndex;
	end
		
	OneRaid.inviting = 1;
	OneRaid.converted = converted;

	local offline = GetGuildRosterShowOffline();
	local selection = GetGuildRosterSelection();
	SetGuildRosterShowOffline(0);
	SetGuildRosterSelection(0);

	local invites = 4 - GetNumPartyMembers();

	for i = 1, GetNumGuildMembers() do
		local invite = 1;
		local iRank = nil;
		local iZone = nil;
		
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);

		--Correct Zone
		if (OneRaid.inviteZone) then
			if (string.lower(zone) == OneRaid.inviteZone) then
				iZone = 1;
			end
		else
			iZone = 1;
		end
		
		--Correct Rank
		if (OneRaid.inviteRank) then
			if (ranks[string.lower(rank)] <= ranks[OneRaid.inviteRank]) then
				iRank = 1;
			end
		else
			iRank = 1;
		end
		
		--Correct Level, Zone, Rank
		if (level <= OneRaid.inviteMax and level >= OneRaid.inviteMin) then
			if (OneRaid.inviteRank and not iRank) then
				invite = nil;
			end
			if (OneRaid.inviteZone and not iZone) then
				invite = nil;
			end	
		else
			invite = nil;			
		end		

		if (invite and not OneRaid.invited[name] and name ~= UnitName("player") and not self:GetUnit(name)) then
			InviteByName(name);
			OneRaid.invited[name] = 1;
			if (not converted) then
				invites = invites - 1;
				if (invites == 0) then
					break;
				end
			end
		end
	end

	if (converted) then
		OneRaid.inviting = nil;
		SendChatMessage(ONERAID_INVITE_DONE, "GUILD");
		SetLootMethod("FreeForAll");
	end

	SetGuildRosterShowOffline(offline);
	SetGuildRosterSelection(selection);

end

function OneRaid:AFKCommand(message, sender, event)

	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_FOLLOW, event)) then
		FollowByName(sender);
		return;
	end

	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_JOIN, event)) then
		AcceptGroup();
		return;
	end

	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_DECLINE, event)) then
		DeclineGroup();
		return;
	end

	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_DISBAND, event)) then
		LeaveParty();
		return;
	end

	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_PROMOTE, event, 1)) then		
		PromoteByName(sender);
		return;
	end
	
	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_TRADE, event, 1)) then		
		AcceptTrade(sender);
		return;
	end

	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_REZ, event)) then
		AcceptResurrect();
		return;
	end

	if (OneRaid:IsCommand(sender, message, ONERAID_COMMAND_SUMMON, event)) then
		ConfirmSummon();
		return;
	end

end

function OneRaid:IsCommand(sender, message, command, chatType, password)

	if (string.find(message, "%[") or string.find(message, "%]")) then
		return nil;
	end

	message = string.lower(message);
	command = string.lower(command);

	if (chatType == "CHAT_MSG_WHISPER") then
		if (password) then
			
			local found, found, cmd, pass = string.find(message, "^(%w+)%s-(%w-)$");

			if (cmd == command) then

				if (not pass) then
					self:Print(ONERAID_COMMAND_DENIED);
					self:AddonMessage("PASSWORD", sender, "denied");
					return nil;
				end
				
				if (OneRaid_Options.password) then
					if (pass == OneRaid_Options.password) then
						self:Print(ONERAID_COMMAND_ACCEPTED);
						self:AddonMessage("PASSWORD", sender, "accepted");
						return 1;	
					else
						self:Print(ONERAID_COMMAND_DENIED);
						self:AddonMessage("PASSWORD", sender, "denied");
						return nil;
					end
				else
					self:Print(ONERAID_COMMAND_DENIED);
					self:AddonMessage("PASSWORD", sender, "denied");
					return nil;
				end
			end
			
		else
			if (message == command) then
				self:Print(ONERAID_COMMAND_ACCEPTED);
				self:AddonMessage("PASSWORD", sender, "accepted");
				return 1;
			end
		end
	end

	return nil;

end

function OneRaid:ResetRaidPositions(index)

	local groups = {};
	OneRaid.memberMoved = nil;
		
	for i = 1, GetNumRaidMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
		if (not groups[subgroup]) then
			groups[subgroup] = { size = 0, names = {} };
		end
		groups[subgroup].size = groups[subgroup].size + 1;
		table.insert(groups[subgroup].names, name);
	end
	
	for i = index, GetNumRaidMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
		
		if (OneRaid.savedRaid[name] and OneRaid.savedRaid[name] ~= subgroup) then
			if (groups[OneRaid.savedRaid[name]] and groups[OneRaid.savedRaid[name]].size == 5) then							
				--Group full, find someone that doesnt belong there
				for k, v in groups[OneRaid.savedRaid[name]].names do
					if (OneRaid.savedRaid[v] ~= OneRaid.savedRaid[name]) then
						OneRaid.memberMoved = i;
						local unit1, index1 = self:GetUnit(name);
						local unit2, index2 = self:GetUnit(v);
						SwapRaidSubgroup(index1, index2);
						break;				
					end
				end
			else
				--Group not full, just move the player
				OneRaid.MemberMoved = i;
				local unit, index = self:GetUnit(name);
				SetRaidSubgroup(index, OneRaid.savedRaid[name]);
			end
		end
		if (OneRaid.memberMoved) then
			return;
		end
	end
	
	OneRaid.memberMoved = nil;

end

------

function OneRaid:VARIABLES_LOADED()

	if (not OneRaid_Options) then
		OneRaid_Options = OneRaid_DefaultOptions;
	end
	
	self:LoadBuffs();
	self:LoadClassPriority();
	
	if (OneRaid.version ~= OneRaid_Options.version) then
		OneRaid_VersionNotes:Show();
		OneRaid_Options.version = OneRaid.version;
	end
	
	self:Print(string.format(ONERAID_LOADED, OneRaid.version));
	
	if (OneRaid_Options.unlockMessageFrame) then
		OneRaid_Message_Frame_BackDrop:Show();
	else
		OneRaid_Message_Frame_BackDrop:Hide();
	end
	
	if (OneRaid_Options.disableStickyOfficer) then
		ChatTypeInfo["OFFICER"].sticky = nil;
	else
		ChatTypeInfo["OFFICER"].sticky = 1;
	end
	
	if (OneRaid_Options.disableStickyChannel) then
		ChatTypeInfo["CHANNEL"].sticky = nil;
	else
		ChatTypeInfo["CHANNEL"].sticky = 1;
	end

end

-- Popup

function OneRaid:DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:DropDown_Init(); end, "MENU");

end

function OneRaid:DropDown_Init()
	
	local info = {};
	
	info.text = ONERAID;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = ONERAID_OPTIONS;
	info.func = function() OneRaid_Options_Frame:Show(); end
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = ONERAID_GROUP_OPTIONS;
	info.func = function()
		for k, v in OneRaid_Options.Groups do
			OneRaid.GroupOptions:EditGroup(k);
			return;
		end
		OneRaid.GroupOptions:NewGroup();
	end
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = ONERAID_UNIT_STYLE_OPTIONS;
	info.func = function() OneRaid.UnitStyle:EditStyle("Default"); end
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
end







---------  Function Hooks

OneRaid_CastSpell_Old = CastSpell;
function OneRaid_CastSpell_New(id, tab)
	OneRaid_CastSpell_Old(id, tab);
	OneRaid_SpellCast_Tooltip:SetSpell(id, tab);
	
	local spell = OneRaid_SpellCast_TooltipTextLeft1:GetText();
	
	if (SpellIsTargeting()) then
		OneRaid.spell = spell;
	else
		OneRaid.endCast = spell;
		OneRaid.spellTarget = UnitName("target");
	end
end
CastSpell = OneRaid_CastSpell_New;

OneRaid_CastSpellByName_Old = CastSpellByName;
function OneRaid_CastSpellByName_New(spell, self)
	OneRaid_CastSpellByName_Old(spell, self);
   
   	if SpellIsTargeting() then
       	OneRaid.spell = spell;
   	else
		OneRaid.endCast = spell;
		if (self) then
			OneRaid.spellTarget = UnitName("player");
		else
			OneRaid.spellTarget = UnitName("target");
		end
	end
end
CastSpellByName = OneRaid_CastSpellByName_New;

OneRaid_UseAction_Old = UseAction
function OneRaid_UseAction_New(a1, a2, a3)
   	OneRaid_UseAction_Old(a1, a2, a3);
   
   	if GetActionText(a1) then return; end
   
   	OneRaid_SpellCast_Tooltip:SetAction(a1);
   	local spell = OneRaid_SpellCast_TooltipTextLeft1:GetText();
   
   	if SpellIsTargeting() then
    	OneRaid.spell = spell;
   	else
       	OneRaid.endCast = spell;
		OneRaid.spellTarget = UnitName("target");
   	end
end
UseAction = OneRaid_UseAction_New

OneRaid_SpellTargetUnit_Old = SpellTargetUnit
function OneRaid_SpellTargetUnit_New(unit)
   OneRaid_SpellTargetUnit_Old(unit);
  
   	if (OneRaid.spell) then
       	OneRaid.endCast = OneRaid.spell;
      	OneRaid.spellTarget = UnitName(unit);
       	OneRaid.spell = nil;
   	end
end
SpellTargetUnit = OneRaid_SpellTargetUnit_New;

OneRaid_TargetUnit_Old = TargetUnit
function OneRaid_TargetUnit_New(unit)
   	OneRaid_TargetUnit_Old(unit);
   
  	if (OneRaid.spell) then
       	OneRaid.endCast = OneRaid.spell;
      	OneRaid.spellTarget = UnitName(unit);
       	OneRaid.spell = nil;
   	end
end
TargetUnit = OneRaid_TargetUnit_New;

OneRaid_SpellStopTargeting_Old = SpellStopTargeting
function OneRaid_SpellStopTargeting_New()
   	OneRaid_SpellStopTargeting_Old()
   
 	if (OneRaid.spell) then
      	OneRaid.spell = nil;
       	OneRaid.endCast = nil;
       	OneRaid.spellTarget = nil;
   end
end
SpellStopTargeting = OneRaid_SpellStopTargeting_New;

function OneRaid_OnMouseDown()
  	if (arg1 == "LeftButton") then
    	local targetName;
       
       	if (OneRaid.spell and UnitExists("mouseover")) then
        	targetName = UnitName("mouseover")
       	elseif (OneRaid.spell and GameTooltipTextLeft1:IsVisible()) then
			local _, _, name = string.find(GameTooltipTextLeft1:GetText(), "^Corpse of (.+)$");
			if (name) then
				targetName = name;
			end
		end

       	if (OneRaid.spell and targetName) then
           	OneRaid.endCast = OneRaid.spell
           	OneRaid.spellTarget = targetName
           	OneRaid.spell = nil
       	end
   	end
end

local oldFunc = WorldFrame:GetScript("OnMouseDown");
if (oldFunc) then
  	WorldFrame:SetScript("OnMouseDown", function() oldFunc(); OneRaid_OnMouseDown(); end );
else
   	WorldFrame:SetScript("OnMouseDown", OneRaid_OnMouseDown);
end

OneRaid_ConfirmSummon_OnAccept_Old = StaticPopupDialogs["CONFIRM_SUMMON"].OnAccept;
OneRaid_ConfirmSummon_OnCancel_Old = StaticPopupDialogs["CONFIRM_SUMMON"].OnCancel;
function OneRaid_ConfirmSummon_OnAccept_New()
	OneRaid:AddonMessage("SUMMONCLICKED");
	OneRaid_ConfirmSummon_OnAccept_Old();
end
function OneRaid_ConfirmSummon_OnCancel_New()
	OneRaid:AddonMessage("SUMMONCLICKED");
	OneRaid_SendChannelMessage("SumCancelled");
end
StaticPopupDialogs["CONFIRM_SUMMON"].OnAccept = OneRaid_ConfirmSummon_OnAccept_New;
StaticPopupDialogs["CONFIRM_SUMMON"].OnCancel = OneRaid_ConfirmSummon_OnCancel_New;

OneRaid_UseSoulstone_Old = UseSoulstone;
function OneRaid_UseSoulstone_New()
	local text = HasSoulstone();
	if (text and text == ONERAID_SPELL_REINCARNATION) then
		local cooldown;
		for i = 1, GetNumTalentTabs(), 1 do
			for y = 1, GetNumTalents(i), 1 do
				local name, _, _, _, currRank = GetTalentInfo(i, y);
				if ( name == ONERAID_SPELL_IMP_REINCARNATION ) then
					cooldown = 60 - (currRank * 10);
					break;
				end
			end
			if (cooldown) then
				break;
			end
		end
		if (not cooldown) then
			cooldown = 60;
		end
		self:AddonMessage("COOLDOWN", ONERAID_SPELL_REINCARNATION, cooldown * 60);
	end
	OneRaid_UseSoulstone_Old();
end
UseSoulstone = OneRaid_UseSoulstone_New;

OneRaid_ChatFrame_OnEvent_Old = ChatFrame_OnEvent;
function OneRaid_ChatFrame_OnEvent_New(event)

	if (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_RAID_WARNING") then
		local rank = OneRaid:GetRaidRank(arg2);
		OneRaid.rankColor = rank or 0;
		if (rank and rank > 0) then
			OneRaid_AddMessage_Old = this.AddMessage;
			this.AddMessage = OneRaid_AddMessage_New;
			OneRaid_ChatFrame_OnEvent_Old(event);
			this.AddMessage = OneRaid_AddMessage_Old;
			return;
		end
	end
	OneRaid_ChatFrame_OnEvent_Old(event);

end
ChatFrame_OnEvent = OneRaid_ChatFrame_OnEvent_New;

function OneRaid_AddMessage_New(obj, msg, r, g, b)

	local color;

	if (OneRaid.rankColor == 1) then
		color = OneRaid_Options.assistantColor;
	elseif (OneRaid.rankColor == 2) then
		color = OneRaid_Options.leaderColor;
	end

	local colorString = format("|c00%.2x%.2x%.2x", floor(color.r * 255), floor(color.g * 255), floor(color.b * 255))

	return OneRaid_AddMessage_Old(obj, string.gsub(msg, "(|Hplayer:.-|h%[)([%w]+)(%])", "%1" .. colorString .. "%2|r%3"), r, g, b);

end


--Static Popups

StaticPopupDialogs["ONERAID_READYREQUEST"] = {
	text = ONERAID_READY_CHECK,
	button1 = YES,
	OnAccept = function()
		if (OneRaid.Unit.data[UnitName("player")].afk) then
			SendChatMessage("", "AFK");
		end
	end,
	OnCancel = function()
		if (not OneRaid.Unit.data[UnitName("player")].afk) then
			SendChatMessage("", "AFK");
		end
	end,
	timeout = 10
};

StaticPopupDialogs["ONERAID_DEFAULTS"] = {
	text = ONERAID_LOAD_DEFAULTS,
	button1 = YES,
	button2 = CANCEL,
	OnAccept = function()
		for k, v in OneRaid.Group.frames do
			if (OneRaid_Options.Groups[v.name].tankMonitor) then
				OneRaid.Group:DeactivateTankMonitorFrame(v.name);
			else
				OneRaid.Group:DeactivateFrame(v.name);
			end
		end
		
		OneRaid_Options = OneRaid_DefaultOptions;
		OneRaid:VARIABLES_LOADED();
		
		for k, v in OneRaid_Options.Groups do
			OneRaid.Group:CreateFrame(v.name, v.style);
			OneRaid.Group:UpdatePosition(getglobal("OneRaid_Group_" .. v.name));
		end
	end,
	timeout = 10
};

StaticPopupDialogs["ONERAID_COPYTALENT"] = {
	text = ONERAID_COPY_TALENT_STRING,
	button1 = ACCEPT,
	button2 = CLOSE,
	hasEditBox = 1,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetText(OneRaid.talent);
		getglobal(this:GetName().."EditBox"):SetFocus();
		getglobal(this:GetName().."EditBox"):HighlightText();
		OneRaid.talent = nil;
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};