OneRaid.Events = { elapsed = 0 };

function OneRaid.Events:OnLoad()

	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("SPELLCAST_START");
    this:RegisterEvent("SPELLCAST_INTERRUPTED");
    this:RegisterEvent("SPELLCAST_STOP");
    this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("RESURRECT_REQUEST");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("CONFIRM_SUMMON");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	
end

function OneRaid.Events:OnUpdate(elapsed)

	this.elapsed = this.elapsed or 0;
	
	if (not this.firstLoad) then
		local angle = OneRaid_Options.iconAngle or 0;
		OneRaid_Icon:ClearAllPoints();
		OneRaid_Icon:SetPoint("CENTER", "Minimap", "CENTER", (80 * cos(angle)) - 1, (80 * sin(angle)) - 1);
		OneRaid.Group:LoadFrames();
		OneRaid:AddonMessage("RELOAD");		
		this.firstLoad = 1;
	end
	
	for k, v in OneRaid.blackList do
		if (v <= GetTime()) then
			OneRaid.blackList[k] = nil;
		end
	end
	
	if (this.elapsed >= 1) then
		for k, v in OneRaid.Unit.data do
			for cooldown, timeLeft in v.cooldowns or {} do
				timeLeft = timeLeft - this.elapsed;
				if (timeLeft <= 0) then
					v.cooldowns[cooldown] = nil;
				else
					v.cooldowns[cooldown] = timeLeft;
				end
			end

			--[[for buff, timeLeft in v.buffs do			
				timeLeft = timeLeft - this.elapsed;
				if (timeLeft <= 0) then
					v.buffs[buff] = nil;
				else
					v.buffs[buff] = timeLeft;
				end
			end]]
		end

		--[[local i = 0;
		local index = GetPlayerBuff(i, "HELPFUL");
		while (index >= 0) do
		
			local timeLeft = ceil(GetPlayerBuffTimeLeft(index));
			
			if (timeLeft > 0 and OneRaid.Unit.data[UnitName("player")]) then
				if (not OneRaid.Unit.data[UnitName("player")].buffs[index + 1]) then
					
					OneRaid:AddonMessage("BUFF", index + 1, timeLeft);
					
				elseif (abs(timeLeft - OneRaid.Unit.data[UnitName("player")].buffs[index + 1]) >= 5) then
					
					OneRaid:AddonMessage("BUFF", index + 1, timeLeft);
					
				end
			end
			i = i + 1;
			index = GetPlayerBuff(i, "HELPFUL");
			
		end]]
		
		this.elapsed = 0;
	else
		this.elapsed = this.elapsed + elapsed;
	end
	
end

function OneRaid.Events:OnEvent()

	if (type(self[event] == "function") and self[event]) then
        self[event](self);
    end
	
end

function OneRaid.Events:PLAYER_ENTER_COMBAT()
	
	OneRaid.inCombat = 1;
	
end

function OneRaid.Events:PLAYER_LEAVE_COMBAT()

	OneRaid.inCombat = nil;

end

function OneRaid.Events:CHAT_MSG_WHISPER()

	OneRaid:AFKCommand(arg1, arg2, event);

end

function OneRaid.Events:PARTY_MEMBERS_CHANGED()

	if (GetNumRaidMembers() == 0) then
	
		for k, v in OneRaid.Group.frames do
			if (not v.inactive) then
				if (not OneRaid_Options.Groups[v.name].hide) then
					if (OneRaid_Options.Groups[v.name].hide) then return; end
					
					if (OneRaid_Options.Groups[v.name].tankMonitor) then
						OneRaid.Group:DeactivateTankMonitorFrame(v.name);
						OneRaid.Group:CreateFrame(v.name, v.style);
					else
						v.units = {};
						v.unitNames = {};
						v.unitGroup = {};
						OneRaid.Group:Filter(v);
					end
				end
			end
		end
	
	end
	
	if (OneRaid.inviting and GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 and not OneRaid.converted) then
		OneRaid.converted = 1;
		OneRaid:Timer(2, nil, "ConvertToRaid");
		OneRaid:Timer(3, OneRaid, "InviteGuild", 1);
	end
	if (OneRaid.reforming and GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 and not OneRaid.converted) then
		OneRaid.converted = 1;
		OneRaid:Timer(2, nil, "ConvertToRaid");
		OneRaid:Timer(3, OneRaid, "ReformRaid", 1);
	end
	
end

function OneRaid.Events:RAID_ROSTER_UPDATE()

	if (OneRaid.promoting) then return; end
	
	for k, v in OneRaid.Group.frames do
		if (not v.inactive) then
			if (not OneRaid_Options.Groups[v.name].hide) then
			
				if (OneRaid_Options.Groups[v.name].tankMonitor) then
					OneRaid.Group:DeactivateTankMonitorFrame(v.name);
					OneRaid.Group:CreateFrame(v.name, v.style);
				else
					v.units = {};
					v.unitNames = {};
					v.unitGroup = {};
					OneRaid.Group:Filter(v);
				end
			end
		end
	end
	
	if (IsRaidLeader()) then
		for i = 1, GetNumRaidMembers() do
			local name, rank = GetRaidRosterInfo(i);
			if (rank == 0 and OneRaid_Options.autoPromote[name]) then
				OneRaid.promoting = 1;
				PromoteToAssistant(name);
			end
		end
		if (OneRaid.promoting) then
			OneRaid:Timer(1, nil, function() OneRaid.promoting = nil; end);	
		end
	end
	
	if (OneRaid.memberMoved) then
		OneRaid:ResetRaidPositions(OneRaid.memberMoved);
	end	

end

function OneRaid.Events:SPELLCAST_START()

	if (OneRaid.endCast ~= arg1) then return; end
	
	if (OneRaid.endCast == ONERAID_SPELL_RESURRECTION or
		OneRaid.endCast == ONERAID_SPELL_REDEMPTION or
		OneRaid.endCast == ONERAID_SPELL_REBIRTH or
		OneRaid.endCast == ONERAID_SPELL_ANCESTRAL_SPIRIT) then
		
		OneRaid:AddonMessage("REZ", "start", OneRaid.spellTarget);
	end
	
	if (OneRaid.endCast == ONERAID_SPELL_SUMMON) then
		OneRaid:AddonMessage("SUMMON", "start", OneRaid.spellTarget);
	end

end

function OneRaid.Events:SPELLCAST_STOP()

	if (OneRaid.endCast == ONERAID_SPELL_RESURRECTION or
		OneRaid.endCast == ONERAID_SPELL_REDEMPTION or
		OneRaid.endCast == ONERAID_SPELL_REBIRTH or
		OneRaid.endCast == ONERAID_SPELL_ANCESTRAL_SPIRIT) then
		
		OneRaid:AddonMessage("REZ", "stop", OneRaid.spellTarget);
	end

	if (OneRaid.endCast == ONERAID_SPELL_SUMMON) then
		OneRaid:AddonMessage("SUMMON", "stop", OneRaid.spellTarget);
	end

	if (OneRaid.endCast == ONERAID_SPELL_REBIRTH) then
		OneRaid:AddonMessage("COOLDOWN", ONERAID_SPELL_REBIRTH, 1800);
	end
	
	if (OneRaid.endCast == ONERAID_SPELL_SOULSTONE) then
	    OneRaid:AddonMessage("COOLDOWN", ONERAID_SPELL_SOULSTONE, 1800);
	end
	
	if (OneRaid.endCast) then 
      	OneRaid.endCast = nil
       	OneRaid.spellTarget = nil
       	OneRaid.spell = nil
   	end
	
end

function OneRaid.Events:SPELLCAST_INTERRUPTED()

	if (OneRaid.endCast == ONERAID_SPELL_RESURRECTION or
		OneRaid.endCast == ONERAID_SPELL_REDEMPTION or
		OneRaid.endCast == ONERAID_SPELL_REBIRTH or
		OneRaid.endCast == ONERAID_SPELL_ANCESTRAL_SPIRIT) then
		
		OneRaid:AddonMessage("REZ", "stop", OneRaid.spellTarget);
	end

	if (OneRaid.endCast == ONERAID_SPELL_SUMMON) then
		OneRaid:AddonMessage("SUMMON", "stop", OneRaid.spellTarget);
	end
	
	if (OneRaid.endCast) then 
      	OneRaid.endCast = nil
       	OneRaid.spellTarget = nil
       	OneRaid.spell = nil
   	end
	
end

function OneRaid.Events:SPELLCAST_FAILED()

	--Cure failed to cast for some reason.. line of sight, etc.. blacklist player for 3 seconds.
	if (OneRaid.endCast == ONERAID_SPELL_ABOLISH_DISEASE or
		OneRaid.endCast == ONERAID_SPELL_ABOLISH_POISON	or
		OneRaid.endCast == ONERAID_SPELL_CLEANSE or
		OneRaid.endCast == ONERAID_SPELL_CURE_DISEASE or
		OneRaid.endCast == ONERAID_SPELL_CURE_POISON or
		OneRaid.endCast == ONERAID_SPELL_DISPEL_MAGIC or
		OneRaid.endCast == ONERAID_SPELL_PURGE or
		OneRaid.endCast == ONERAID_SPELL_PURIFY	or
		OneRaid.endCast == ONERAID_SPELL_REMOVE_CURSE or
		OneRaid.endCast == ONERAID_SPELL_REMOVE_LESSER_CURSE) then
		
		OneRaid.blackList[OneRaid.spellTarget] = GetTime() + 3;
	
	end
	
	if (OneRaid.endCast) then 
      	OneRaid.endCast = nil
       	OneRaid.spellTarget = nil
       	OneRaid.spell = nil
   	end

end

function OneRaid.Events:RESURRECT_REQUEST()

	OneRaid:AddonMessage("REZZED");

end

function OneRaid.Events:PLAYER_DEAD()

	local ss = HasSoulstone();
	
	if (ss == ONERAID_SPELL_REINCARNATION) then
		OneRaid:AddonMessage("SOULSTONE", 1);
	elseif (ss) then
		OneRaid:AddonMessage("SOULSTONE");
	end
	
end
	
function OneRaid.Events:CONFIRM_SUMMON()

	OneRaid:AddonMessage("SUMMONED");

end

function OneRaid.Events:CHAT_MSG_SYSTEM()

	if (string.find(arg1, ONERAID_AFK_REGEX)) then
		OneRaid.afk = 1;
		OneRaid:AddonMessage("AFK", "on");
	elseif (string.find(arg1, CLEARED_AFK)) then
		OneRaid.afk = nil;
		OneRaid:AddonMessage("AFK", "off");
	end
	
	if (string.find(arg1, ONERAID_JOINED_REGEX)) then
		OneRaid:AddonMessage("RELOAD");
	end		
	
end

function OneRaid.Events:PLAYER_ENTERING_WORLD()

	OneRaid:AddonMessage("ZONED");
	
end










function OneRaid.Events:CHAT_MSG_ADDON()
	
	if (arg1 ~= "ØR") then return; end
	
	local player = UnitName("player");
	if (player == "Aurto" or player == "Medium" or player == "Aurta") then
		ChatFrame3:AddMessage(arg4 .. ": " .. arg2);
	end
	
	if (arg3 == "GUILD") then OneRaid:Print("Convert to RAID AddonMessages"); end
	
	local arg = {};
	local found, found, event, args = string.find(arg2, "^([^¦]+)(.*)$");
	for a in string.gfind(args, "[^¦]+") do
		tinsert(arg, a);
	end
	
	if (type(self["ADDON_" .. event]) == "function") then
		self["ADDON_" .. event](self, arg4, arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9]);
	end

end

function OneRaid.Events:ADDON_GET_TALENTS(sender, player)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end
	
	if (strlower(UnitName("player")) == strlower(player)) then
		OneRaid:GetTalentInfo(sender);
	end
	
end

function OneRaid.Events:ADDON_TALENTS(sender, player, class, talents)

	talents = "http://www.worldofwarcraft.com/info/classes/" .. strlower(class) .. "/talents.html?" .. talents;
	
	if (player == UnitName("player")) then
		OneRaid.talent = talents;
		StaticPopup_Show("ONERAID_COPYTALENT");
	end

end

function OneRaid.Events:ADDON_SAY(sender, message)

	OneRaid_Message_Frame:AddMessage(sender .. ": " .. message);
	
end

function OneRaid.Events:ADDON_TANK(sender, action, tank)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end
	
	if (action ~= "remAll" and action ~= "request") then
		if (not tank or not OneRaid:GetUnit(tank)) then
			return;
		end
	end
	
	if (action == "remAll") then
		OneRaid.tanks = {};
	elseif (action == "add") then
		local found = nil;
		for k, v in OneRaid.tanks do
			if (v == tank) then
				found = 1;
				break;
			end
		end
		if (not found) then
			tinsert(OneRaid.tanks, tank);
		else
			return;
		end
	elseif (action == "rem") then
		local found = nil;
		for k, v in OneRaid.tanks do
			if (v == tank) then
				found = k;				
				break;
			end
		end
		if (found) then
			tremove(OneRaid.tanks, found);
		else
			return;
		end
	elseif (action == "request") then
		if (IsRaidOfficer() and not IsRaidLeader()) then
			if (getn(OneRaid.tanks) > 0) then
				local tanks = OneRaid.tanks;
				OneRaid:AddonMessage("TANK", "remAll");
				for k, v in tanks do
					OneRaid:AddonMessage("TANK", "add", v);
				end
			else
				OneRaid:AddonMessage("TANK", "remAll");
			end
		end
	end	
	
	for k, v in OneRaid.Group.frames do
		if (OneRaid_Options.Groups[v.name] and OneRaid_Options.Groups[v.name].tankMonitor) then
			OneRaid.Group:DeactivateTankMonitorFrame(v.name);
			OneRaid.Group:CreateFrame(v.name, v.style);
		end
	end

end

function OneRaid.Events:ADDON_BUFF(sender, index, timeLeft)

	--OneRaid.Unit.data[sender] = OneRaid.Unit.data[sender] or { cooldowns = {}, buffs = {}, debuffs = {} };
	
	--OneRaid.Unit.data[sender].buffs[tonumber(index)] = tonumber(timeLeft);

end

function OneRaid.Events:ADDON_SOUND(sender, sound)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end
	
	if (not OneRaid_Options.disableSound) then
		PlaySoundFile(sound);
	end
	
end

function OneRaid.Events:ADDON_DURABILITY_REQUEST(sender)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end
	
	if (sender == UnitName("player")) then
		OneRaid.RaidInfo.durability = {};
		OneRaid_RaidInfo_Durability_Frame:Show();
	end
	
	local dur, broken = OneRaid:GetDurability();
	
	OneRaid:AddonMessage("DURABILITY", sender, dur, broken);
	
end

function OneRaid.Events:ADDON_DURABILITY(sender, target, dur, broken)

	if (target == UnitName("player")) then
		tinsert(OneRaid.RaidInfo.durability, { name = sender, durability = tonumber(dur), broken = tonumber(broken) });
		OneRaid.RaidInfo:Durability_OnUpdate();
	end

end

function OneRaid.Events:ADDON_RESISTS_REQUEST(sender)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end
	
	if (sender == UnitName("player")) then
		OneRaid.RaidInfo.resists = {};
		OneRaid_RaidInfo_Resists_Frame:Show();
	end
	
	local resists = OneRaid:GetResists();
	
	OneRaid:AddonMessage("RESISTS", sender, resists[6], resists[2], resists[3], resists[4], resists[5]);
	
end

function OneRaid.Events:ADDON_RESISTS(sender, target, arcane, fire, nature, frost, shadow)

	if (target == UnitName("player")) then
		tinsert(OneRaid.RaidInfo.resists, { name = sender, arcane = arcane, fire = fire, nature = nature, frost = frost, shadow = shadow });
		OneRaid.RaidInfo:Resists_OnUpdate();
	end

end

function OneRaid.Events:ADDON_ITEM_REQUEST(sender, item)

	--if (OneRaid:GetRaidRank(sender) == 0 or not item) then return; end	
		
	local found, found, color, id, name = string.find(item, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r");
	
	if (found) then
		item = name;
	end
	
	if (sender == UnitName("player")) then
		OneRaid.RaidInfo.item = {};
		OneRaid.RaidInfo.itemName = item;
		OneRaid_RaidInfo_Item_Frame:Show();
	end
	
	local count = OneRaid:GetItemCount(item);
	
	OneRaid:AddonMessage("ITEM", sender, count);

end

function OneRaid.Events:ADDON_ITEM(sender, target, count)

	if (target == UnitName("player") and tonumber(count) > 0) then
		tinsert(OneRaid.RaidInfo.item, { name = sender, count = tonumber(count) });
		OneRaid.RaidInfo:Item_OnUpdate();
	end

end

function OneRaid.Events:ADDON_RELOAD(sender)

	OneRaid:SendTanks();
	OneRaid:SendVersion();
	OneRaid:SendCooldowns();
	OneRaid:SendBuffTimes();
	
	if (OneRaid.Unit.data[UnitName("player")] and OneRaid.Unit.data[UnitName("player")].afk) then
		OneRaid:Timer(1, OneRaid, "AddonMessage", { "AFK", "on" });
	end

end

function OneRaid.Events:ADDON_SWAP(sender, player1, player2)

	if (OneRaid:GetRaidRank(sender) == 0 or GetNumRaidMembers() == 0) then return; end

	if (IsRaidLeader()) then
		local unit1, index1 = OneRaid:GetUnit(player1);
		local unit2, index2 = OneRaid:GetUnit(player2);
		
		if (index1 and index2) then
			SwapRaidSubgroup(index1, index2);
		end
	end

end

function OneRaid.Events:ADDON_MOVE(sender, player, group)

	if (OneRaid:GetRaidRank(sender) == 0 or GetNumRaidMembers() == 0) then return; end
	
	if (IsRaidLeader()) then
		local unit, index = OneRaid:GetUnit(player);

		SetRaidSubgroup(index, tonumber(group));
	end

end

function OneRaid.Events:ADDON_MA(sender, ma)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end
	
	for k, v in OneRaid.Group.frames do
		if (OneRaid_Options.Groups[v.name].tankMonitor) then
			local style = OneRaid_Options.UnitStyles[v.style];
			if (style.backgroundType == 7) then
				if (v.frames[OneRaid.mainAssist]) then
					v.frames[OneRaid.mainAssist][1]:SetBackdropColor(0, 0, 0, 0);
				end
				if (v.frames[ma]) then
					v.frames[ma][1]:SetBackdropColor(style.maColor.r, style.maColor.g, style.maColor.b, style.maColor.a);
				end
			end
		end
	end
	
	if (ma == "clear") then
		OneRaid.mainAssist = nil;
		OneRaid:Print(ONERAID_MA_CLEARED);
	elseif (ma ~= OneRaid.mainAssist) then
		OneRaid.mainAssist = ma;
		OneRaid:Print(string.format(ONERAID_MA_SET, ma));
	end
	
end

function OneRaid.Events:ADDON_DISBAND(sender)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end
	
	OneRaid:Print(string.format(ONERAID_DISBAND, sender));
	LeaveParty();
	OneRaid:Timer(2, nil, "LeaveParty");
	
end

function OneRaid.Events:ADDON_REFORM(sender)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end

	OneRaid:Print(string.format(ONERAID_REFORM, sender));
	LeaveParty();
	OneRaid:Timer(2, nil, "LeaveParty");

end

function OneRaid.Events:ADDON_READY_REQUEST(sender)

	if (OneRaid:GetRaidRank(sender) == 0) then return; end

	OneRaid:Print(string.format(ONERAID_READY_CHECK_BEGIN, sender));
	PlaySoundFile("Sound\\Spells\\PVPThroughQueue.wav");
	StaticPopup_Show("ONERAID_READYREQUEST");
	OneRaid:Timer(10, OneRaid, "Print", ONERAID_READY_CHECK_DONE);
    
 end
 
 function OneRaid.Events:ADDON_PASSWORD(sender, target, command)

	if (target == UnitName("player")) then
		if (command == "accepted") then
			OneRaid:Print(ONERAID_COMMAND_ACCEPTED);
		elseif (command == "denied") then
			OneRaid:Print(ONERAID_COMMAND_DENIED);
		end
	end

end