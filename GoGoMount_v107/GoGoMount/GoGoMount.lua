BINDING_HEADER_GOGOHEADER = "GoGoMount"

---------
function GoGo_OnLoad()
---------
	SlashCmdList["GOGOMOUNT"] = function(msg) GoGo_Slash(msg) end
	SLASH_GOGOMOUNT1 = "/gogo"
end --function

---------
function GoGo_Slash(msg)
---------
	msg = string.lower(msg)
	if msg == "spell" then
		if GoGo_NoSpellMounts then
			GoGo_NoSpellMounts = nil
			GoGo_Msg(GoGo_SpellEnableString)
		else
			GoGo_NoSpellMounts = true
			GoGo_Msg(GoGo_SpellDisableString)
		end --if
	else
		GoGo_Go()
	end --if
end --function

---------
function GoGo_Go()
---------
	local GoGo_Mounted = GoGo_IsMounted()
	if GoGo_Mounted then
		CancelPlayerBuff(GoGo_Mounted)
	else
		local location = GetRealZoneText()
		if UnitAffectingCombat("player") then
			GoGo_GotMounts = GoGo_GetMounts(GoGo_WtfMounts)
		elseif location == "Ahn'Qiraj" then
			GoGo_GotMounts = GoGo_GetMounts(GoGo_Bugs)
		else
			GoGo_GotMounts = GoGo_GetMounts(GoGo_Mounts)
		end --if
		if table.getn(GoGo_GotMounts) == 0 then
			return
		else
			math.randomseed(math.random(1337) + GetTime() * 1000)
			GoGo_Mount = GoGo_GotMounts[math.random(table.getn(GoGo_GotMounts))]
		end --if
		if GoGo_Mount.spell then
			CastSpellByName(GoGo_Mount.name)
		else
			CloseMerchant()
			UseContainerItem(GoGo_Mount.bag, GoGo_Mount.slot)
		end --if
	end --if
end --function

---------
function GoGo_IsMounted()
---------
	local count = 0
	while (GetPlayerBuff(count , "HELPFUL|HARMFUL|PASSIVE") ~= -1) do
		local index = GetPlayerBuff(count , "HELPFUL|HARMFUL|PASSIVE")
		GoGo_Tooltip:SetOwner(UIParent,"ANCHOR_NONE")
		GoGo_Tooltip:SetPlayerBuff(index)
		if string.find(GoGo_TooltipTextLeft2:GetText() or "", GoGo_MountString) then return index end
		if string.find(GoGo_TooltipTextLeft1:GetText() or "", GoGo_WolfString) then return index end
		if string.find(GoGo_TooltipTextLeft1:GetText() or "", GoGo_CheetahString) then return index end
		count = count + 1
	end --while
end --function

---------
function GoGo_GetMounts(all)
---------
	local list = {}
	if (table.getn(all) > 0) then
		for bag = 0, NUM_BAG_FRAMES do
			for slot = 1, GetContainerNumSlots(bag) do
				local name = GetContainerItemLink(bag, slot) or ""
				for index, value in ipairs(all) do
					if string.find(name, value) then table.insert(list, {name = name, bag = bag, slot = slot}) end
				end --for
			end --for
		end --for
	end --if
	if not GoGo_NoSpellMounts then
		local _, class = UnitClass("player")
		if all[class] then
			local count = 1
			while GetSpellName(count, "spell") do
				local name = GetSpellName(count, "spell")
				if (name == all[class]) then table.insert(list, {name = name, spell = true}) end
				count = count + 1
			end --while
		end --if
	end --if
	if (table.getn(list) > 0) then
		return list
	elseif (all == GoGo_Mounts) then
		return GoGo_GetMounts(GoGo_NubMounts)
	elseif (all == GoGo_NubMounts) then
		return GoGo_GetMounts(GoGo_WtfMounts)
	elseif (all == GoGo_WtfMounts) then
		return list
	else
		return GoGo_GetMounts(GoGo_Mounts)
	end --if
end --function

---------
function GoGo_Msg(msg)
---------
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00e000GoGo: |r"..msg)
	end --if
end --function
