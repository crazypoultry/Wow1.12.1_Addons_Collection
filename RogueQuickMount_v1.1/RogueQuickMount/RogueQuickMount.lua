--[[ 
	********************************************************************
	Do not change anything below here unless you know what your doing.
	There shouldn't be any reason for you to change anything below here.
	********************************************************************
]]--


COLOR_WHITE 		= "|cffffffff";
COLOR_RED	    	= "|cffff0000";
COLOR_GREEN	    	= "|cff00ff00";
COLOR_BLUE	    	= "|cff0000ff";
COLOR_PURPLE    	= "|cff700090";
COLOR_YELLOW    	= "|cffffff00";
COLOR_ORANGE    	= "|cffff6d00";
COLOR_GREY	    	= "|cff808080";
COLOR_GOLD	    	= "|cffcfb52b"; 
COLOR_NEON_BLUE	    = "|cff4d4dff";
COLOR_END		    = "|r";

function RQM_OnInit()
	InCombat = false;
	RQM_Save = {
		['PrimaryAbility']	    	= "Stealth";
		['PrimaryAbilityID']		= nil;
		['SecondaryAbilityActive']	= true;
		['SecondaryAbility']		= "Vanish";
		['SecondaryAbilityID']	    = nil;
		['Icon']			        = true;
	};
	-- Slash Commands
	SlashCmdList["ROUGEQUICKMOUNT"] = function(msg) RQM_Config(msg); end
	setglobal("SLASH_ROUGEQUICKMOUNT1", "/rqm");
	RQM_Msg(RQM_TITLE .. RQM_VERSION .. RQM_LOADED);
end

function RQM_OnEvent(event)
	if event == "TAXIMAP_OPENED" then
	    mountIndex = RQM_Player_Is_Mounted()
            if mountIndex then
                CancelPlayerBuff(mountIndex)
            end
	elseif event == "VARIABLE_LOADED" then
		RQM_Msg("Variables Loaded");
		RQM_Save['PrimaryAbilityID'] = RQM_FindSpell(RQM_Save['PrimaryAbility']);
		if(RQM_Save['SecondaryAbilityActive'] == true) then
			RQM_Save['SecondaryAbilityID'] = RQM_FindSpell(RQM_Save['SecondaryAbility']);
		end
		if (RQM_Save['Icon'] == false) then
			ShapeshiftBarFrame:Hide();
		end
	elseif event == "LEARNED_SPELL_IN_TAB" then
		RQM_Save['PrimaryAbilityID'] = RQM_FindSpell(RQM_Save['PrimaryAbility']);
		if(RQM_Save['SecondaryAbilityActive']) then
			RQM_Save['SecondaryAbilityID'] = RQM_FindSpell(RQM_Save['SecondaryAbility']);
		end
	elseif event == "PLAYER_ENTERING_WORLD" then InCombat = false;
	elseif event == "PLAYER_REGEN_DISABLED" then InCombat = true;
	elseif event == "PLAYER_REGEN_ENABLED" then InCombat = false;
	end
end

function RQM_Msg(msg)
    if(DEFAULT_CHAT_FRAME) then
        DEFAULT_CHAT_FRAME:AddMessage(msg);
    end
end

function RQM_OnReset() 
	RQM_Save['PrimaryAbilityID'] = RQM_FindSpell( RQM_Save['PrimaryAbility']);
	if(RQM_Save['SecondaryAbilityActive']) then
		RQM_Save['SecondaryAbilityID'] = RQM_FindSpell(RQM_Save['SecondaryAbility']);		
	end
end

function RQM_Config(msg)
	local args = {n=0}
	local strFlag;
	local function helper(word) table.insert(args, word) end
	string.gsub(msg, "[_%w]+", helper);
	if (args[1] ~= '') and (args[1] ~= nil) then
		strFlag = string.upper(args[1])
	end

	if (strFlag == 'ENABLE') then 
		RQM_Save['SecondaryAbilityActive'] = true;
		RQM_Msg(RQM_SECONDARY_ABILITY ..  ": " .. RQM_ENABLE);
	elseif (strFlag == 'DISABLE') then 
		RQM_Save['SecondaryAbilityActive'] = false;
		RQM_Msg(RQM_SECONDARY_ABILITY ..  ": " .. RQM_DISABLE);
	elseif (strFlag == 'ABILITIES') then
		if (args[2] == nil) or (args[2] == '') then
			RQM_Msg(RQM_NO_ABILITY);
		else
			RQM_Save['PrimaryAbility'] = args[2];
			if (args[3] == nil) or (args[3] == '')  then
				RQM_Save['SecondaryAbility'] = ''
				RQM_Msg(RQM_NO_SECONDARY);
				RQM_Save['SecondaryAbilityActive'] = false;
			else
				RQM_Save['SecondaryAbility'] = args[3];
				RQM_Save['SecondaryAbilityActive'] = true;
			end
			RQM_Msg(COLOR_GOLD .. RQM_TITLE .. COLOR_END);
			RQM_Msg("   " .. RQM_ASSIGNED .. COLOR_BLUE .. RQM_Save['PrimaryAbility'] .. COLOR_END
						.." " .. COLOR_RED ..  RQM_Save['SecondaryAbility'] .. COLOR_END);
			RQM_OnReset();			
		end
	elseif (strFlag == 'SHOW') then 
		RQM_Save['Icon'] = true;
		ShapeshiftBarFrame:Show();
		RQM_Msg(RQM_ICON ..  ": " .. RQM_ENABLE);
	elseif (strFlag == 'HIDE') then 
		RQM_Save['Icon'] = false;
		ShapeshiftBarFrame:Hide();
		RQM_Msg(RQM_ICON ..  ": " .. RQM_DISABLE);
	elseif (strFlag == 'VARS') then
		RQM_Msg(RQM_PRIMARY_ABILITY .. ": " .. RQM_Save['PrimaryAbility']);
		RQM_Msg(RQM_PRIMARY_ABILITY_ID .. ": "  .. RQM_Save['PrimaryAbilityID']);
		if(RQM_Save['SecondaryAbilityActive']) then 
			strActive = RQM_ENABLE;
		else 
			strActive = RQM_DISABLE; 
		end;
		RQM_Msg(RQM_SECONDARY_ABILITY .." " .. strActive);
		RQM_Msg(RQM_SECONDARY_ABILITY .. ": " .. RQM_Save['SecondaryAbility']);
		RQM_Msg(RQM_SECONDARY_ABILITY_ID .. ": " .. RQM_Save['SecondaryAbilityID']);
	else
		RQM_Help();
	end	
end

function RQM_Help()
	RQM_Msg(RQM_TITLE .. RQM_VERSION .. RQM_HELP1);
	RQM_Msg(RQM_HELP2);
	RQM_Msg(RQM_HELP3);
	RQM_Msg(RQM_HELP4);
	RQM_Msg(RQM_HELP5);
	RQM_Msg(RQM_HELP6);
	RQM_Msg(RQM_HELP7);
	RQM_Msg(RQM_HELP8);
	RQM_Msg(RQM_HELP9);
end

function RQM_FindSpell(spell)
	local i = 1
	while (spell ~= '') and (spell ~= nil) do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		if (string.find(spellName, spell)) then 
			return i; 
		end
		i = i + 1
	end	
	return -1;
end

function RQM_inCombat() 
	return InCombat;
end

function RQM_Activate(param)
	local shiftDown = IsShiftKeyDown();
	if (RQM_Save['PrimaryAbilityID'] == -1) or (RQM_Save['PrimaryAbilityID'] == nil) then
		RQM_OnReset();
	end
	mountIndex = RQM_Player_Is_Mounted()
	if mountIndex then
		CancelPlayerBuff(mountIndex)
	else
		if not (RQM_inCombat()) then
			if (shiftDown) then
				RQM_Mount()
			elseif (RQM_Save['PrimaryAbilityID'] ~= -1) and (RQM_Save['PrimaryAbilityID'] ~= nil) then
				CastSpell(RQM_Save['PrimaryAbilityID'], 1);
			end
		else
			if (shiftDown) then 
				if (RQM_Save['SecondaryAbilityActive'] == false) then 
					if (RQM_Save['SecondaryAbilityID'] ~= -1) and (RQM_Save['SecondaryAbilityID'] ~= nil) then
						CastSpell(RQM_Save['SecondaryAbilityID'], 1);
					end
				end
			elseif (RQM_Save['SecondaryAbilityActive'] == true) then 
				if (RQM_Save['SecondaryAbilityID'] ~= -1) and (RQM_Save['SecondaryAbilityID'] ~= nil) then
					CastSpell(RQM_Save['SecondaryAbilityID'], 1); 	
				end
			end
		end
	end
end

function RQM_Mount()
	mountIndex = RQM_Player_Is_Mounted()
	if mountIndex then
		CancelPlayerBuff(mountIndex)
	else
		RQM_Populate_Mounts()
		if (NumAQMounts > 0) and (GetMinimapZoneText() == "Ahn'Qiraj") then
			x = math.random(1,NumAQMounts)
			UseContainerItem(RQM_AQ_Mounts[x].bag,RQM_AQ_Mounts[x].slot)
		elseif (NumMounts > 0) then
			x = math.random(1,NumMounts)
			UseContainerItem(RQM_Mounts[x].bag,RQM_Mounts[x].slot)
		else
			RQM_Msg("RQM: No mounts in bag.")
		end
	end
end

function RQM_Populate_Mounts()
	
	RQM_AQ_Mounts = {}
	RQM_Mounts = {}
	
	NumAQMounts = 0;
	NumMounts = 0;
	
	local i = 1;
	for _,AQMountName in RQM_AQ_Mounts do
		b,s = RQM_GetMountBagSlot(AQMountName)
		if b and s then
			RQM_AQ_Mounts[i] = {bag=b, slot=s}
			i = i + 1
			NumAQMounts = NumAQMounts + 1
		end
	end
	
	i = 1
	for _,mountName in RQM_Epic_Mounts do
		b,s = RQM_GetMountBagSlot(mountName)
		if b and s then
			RQM_Mounts[i] = {bag=b, slot=s}
			NumMounts = NumMounts + 1
			i = i + 1
		end
	end

	if NumMounts == 0 then
		i = 1
		for _,mountName in RQM_Normal_Mounts do
			b,s = RQM_GetMountBagSlot(mountName)
			if b and s then
				RQM_Mounts[i] = {bag=b, slot=s}
				NumMounts = NumMounts + 1
				i = i + 1
			end
		end
	end
end

function RQM_Player_Is_Mounted()
	local i=0
	if not RougeQuickMountMasterTooltip:IsOwned(WorldFrame) then 
		RougeQuickMountMasterTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
	end
	while GetPlayerBuff(i, "HELPFUL") ~= -1 do
		RougeQuickMountMasterTooltip:ClearLines()
		local newI = GetPlayerBuff(i, "HELPFUL")
		RougeQuickMountMasterTooltip:SetPlayerBuff(newI)
		if strfind(RougeQuickMountMasterTooltipTextLeft2:GetText() or "", "Increases speed by") then
			return newI
		end
		i=i+1
	end
end

function RQM_GetMountBagSlot(itemName)
	for bag = 0,4 do
		for slot = 1, GetContainerNumSlots(bag) do
			link = GetContainerItemLink(bag, slot)
			if link and strfind(link, itemName) then
				return bag, slot
			end
		end
	end
end