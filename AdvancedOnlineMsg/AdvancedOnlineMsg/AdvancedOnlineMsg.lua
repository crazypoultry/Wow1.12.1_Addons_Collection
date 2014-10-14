function AOnlineM_Variables()
	this:UnregisterEvent("VARIABLES_LOADED") -- I hope we dont need that from now on
	-- all the rest of init
	if AOnlineM_Save == nil then -- if there is a nil value in the subvariables its not my fault :p
		AOnlineM_default()
	end

	-- this:RegisterEvent("CHAT_MSG_SYSTEM") -- its registered for ChatFrame_OnEvent so we dont need it
	SLASH_AONLINEM_GWHO1 = "/gwho"
	SlashCmdList["AONLINEM_GWHO"] = AOnlineM_GWho

	SLASH_AONLINEM_SETTINGS1 = "/aom" -- hope this does not collide :)
	SlashCmdList["AONLINEM_SETTINGS"] = AOnlineM_Slashhandler
	GuildRoster() -- fetch information from guild roster
end

function AOnlineM_default ()
	AOnlineM_Save = {}
	AOnlineM_Save.printpatternON  = "<ccolor><name> : <colordddddd><level> : <color00ff00><rank> : <colorffff00><zone> : <color00ff00><online>"
	AOnlineM_Save.printpatternOFF = "<ccolor><name> : <color888888><level> : <colorff0000><rank> : <colorffff00><zone> : <colorff0000><online>"
	AOnlineM_Save.showON = true
	AOnlineM_Save.showOFF = true
end

function AOnlineM_Nil (var) -- used to kill those f*** nil values
	if var ~= nil then
		return var
	end
	return "-"
end

function AOnlineM_NilN (var) -- used to kill those f*** nil values - Numbers
	if var ~= nil then
		return var
	end
	return 0
end

function AOnlineM_Help()
		local ontxt = "|cff33cc00on|cffffffff"
		if AOnlineM_Save.showON ~= true then
			ontxt = "|cffff3300off|cffffffff"
		end
		local offtxt = "|cff33cc00on|cffffffff"
		if AOnlineM_Save.showOFF ~= true then
			ontxt = "|cffff3300off|cffffffff"
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff use |cff99ccff/aom showon|cffffffff to toggle online msg. ["..ontxt.."]")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff use |cff99ccff/aom showoff|cffffffff to toggle offline msg. ["..offtxt.."]")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff use |cff99ccff/aom seton {pattern}|cffffffff to set the layout of the online msg")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff use |cff99ccff/aom setoff {pattern}|cffffffff to set the layout of the offline msg")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff use |cff99ccff/aom pattern|cffffffff for further info about pattern")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff use |cff99ccff/aom reset|cffffffff to reset everything irreversible to default")
		
end

function AOnlineM_PHelp()
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff OnlineMsg Pattern is:  |cff99ccff"..AOnlineM_Save.printpatternON)
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff OfflineMsg Pattern is: |cff99ccff"..AOnlineM_Save.printpatternOFF)
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff Available tags are")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <name> |cffdfdfdfName")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <rank> |cffdfdfdfGuildrank (e.g. Guildmaster)")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <rankIndex> |cffdfdfdfGuildrank expressed as number")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <level> |cffdfdfdfLevel")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <class> |cffdfdfdfClass (e.g. Warrior)")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <zone> |cffdfdfdfZone (e.g. Winterspring)")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <note> |cffdfdfdfPlayernote")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <officernote> |cffdfdfdfOfficernote")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <online> |cffdfdfdf'online' or 'offline'")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <status> |cffdfdfdfStatus (e.g. <AFK>, <DND>)")
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cff99ccff <colorRRGGBB> |cffdfdfdfthe following text will be colored RRGGBB (e.g. <colorffffff>=white)")
end

function AOnlineM_Slashhandler(cmd)
	if cmd == nil or cmd == "" then -- no search specified
		AOnlineM_Help()
		return
	end
	cmd = string.gsub (cmd, "^%s+", "") -- remove leading spaces
	
	if string.find(string.lower(cmd), "^pattern") then
		AOnlineM_PHelp()
		return
	end

	if string.find(string.lower(cmd), "^reset") then
		AOnlineM_default()
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff defaults loaded.")
		return
	end

	if string.find(string.lower(cmd), "^showon") then
		AOnlineM_Save.showON = not AOnlineM_Save.showON
		local ontxt = "|cff33cc00on|cffffffff"
		if AOnlineM_Save.showON ~= true then
			ontxt = "|cffff3300off|cffffffff"
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff Online msg now ["..ontxt.."]")
		return
	end

	if string.find(string.lower(cmd), "^showoff") then
		AOnlineM_Save.showOFF = not AOnlineM_Save.showOFF
		local ontxt = "|cff33cc00on|cffffffff"
		if AOnlineM_Save.showOFF ~= true then
			ontxt = "|cffff3300off|cffffffff"
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff Offline msg now ["..ontxt.."]")
		return
	end

	if string.find(string.lower(cmd), "^seton") then
		AOnlineM_Save.printpatternON = string.sub(cmd, 7)
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff OnlineMsg Pattern is:  |cff99ccff"..AOnlineM_Save.printpatternON)
		DEFAULT_CHAT_FRAME:AddMessage(AOnlineM_Print ("TestName", "Guild Master", 1, 60, "Hunter", "Winterspring", "<playernote>", "<officernote>", 1, "AFK"))
		return
	end

	if string.find(string.lower(cmd), "^setoff") then
		AOnlineM_Save.printpatternOFF = string.sub(cmd, 8)
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[AOM]|cffffffff OfflineMsg Pattern is: |cff99ccff"..AOnlineM_Save.printpatternOFF)
		DEFAULT_CHAT_FRAME:AddMessage(AOnlineM_Print ("TestName", "Guild Master", 1, 60, "Hunter", "Winterspring", "<playernote>", "<officernote>", 0, "AFK"))
		return
	end

	AOnlineM_Help()
end

function AOnlineM_GWho(cmd)
-- search for cmd in the guildroster and printout to DEFAULT_CHAT_FRAME

	if cmd == nil or cmd == "" then -- no search specified
		DEFAULT_CHAT_FRAME:AddMessage("|cff33cccc[gwho]|cffffffff use /gwho <searchstring> to search the guildroster")
		return
	end
	
	cmd = string.gsub (cmd, "^%s+", "") -- remove leading spaces
	GuildRoster() -- try to get new data from server
	local found = false -- did we find something?
	DEFAULT_CHAT_FRAME:AddMessage ("|cff33cccc[gwho]|cffffffff -- results for ["..cmd.."] --")

	for i = 1, GetNumGuildMembers(true) do
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
		local combined = AOnlineM_Nil(name).." "..AOnlineM_Nil(rank).." "..AOnlineM_NilN(level).." "..AOnlineM_Nil(class).." "..AOnlineM_Nil(zone).." "..AOnlineM_Nil(note).." "..AOnlineM_Nil(officernote)
--		DEFAULT_CHAT_FRAME:AddMessage("> "..combined)
		if string.find(string.lower(combined), string.lower(cmd), 1, true) then -- plain txt search case insensitive 
			found = true
			DEFAULT_CHAT_FRAME:AddMessage(AOnlineM_Print (name, rank, rankIndex, level, class, zone, note, officernote, online, status))
		end
	end
	if found == false then
		DEFAULT_CHAT_FRAME:AddMessage ("|cff33cccc[gwho]|cffffffff nothing found")
	end
end

function AOnlineM_Print (name, rank, rankIndex, level, class, zone, note, officernote, online, status)
	if AOnlineM_Save.printpatternON == nil then return "ERROR in AdvancedOnlineMsg" end
	if AOnlineM_Save.printpatternOFF == nil then return "ERROR in AdvancedOnlineMsg" end

	-- some nil checks
	name = AOnlineM_Nil(name);
	rank = AOnlineM_Nil(rank);
	rankIndex = AOnlineM_NilN(rankIndex); -- number
	level = AOnlineM_NilN(level); -- number
	class = AOnlineM_Nil(class);
	zone = AOnlineM_Nil(zone);
	note = AOnlineM_Nil(note);
	officernote = AOnlineM_Nil(officernote);
	online = AOnlineM_NilN(online); -- 1 or nil
	status = AOnlineM_Nil(status);
	
	-- set pattern to the string used for formatting
	local pattern = AOnlineM_Save.printpatternON
	local onlinetxt = "online" -- we dont want to show 0 or 1
	if online ~= 1 then
		pattern = AOnlineM_Save.printpatternOFF
		onlinetxt = "offline"
	end
	pattern = string.gsub (pattern, "<color(.-)>", "|cff%1") -- replace colors
	if online == 1 then
		pattern = string.gsub (pattern, "<name>", "|Hplayer:"..name.."|h["..name.."]|h", 1, true)
	else
		pattern = string.gsub (pattern, "<name>", name, 1, true)
	end
	pattern = string.gsub (pattern, "<rank>", rank, 1, true)
	pattern = string.gsub (pattern, "<rankIndex>", rankIndex, 1, true)
	pattern = string.gsub (pattern, "<level>", level, 1, true)
	pattern = string.gsub (pattern, "<class>", class, 1, true)
	pattern = string.gsub (pattern, "<zone>", zone, 1, true)
	pattern = string.gsub (pattern, "<note>", note, 1, true)
	pattern = string.gsub (pattern, "<officernote>", officernote, 1, true)
	pattern = string.gsub (pattern, "<online>", onlinetxt, 1, true)
	pattern = string.gsub (pattern, "<status>", status, 1, true)
	local tempcolor = AOnlineM_CCC[class]
	if tempcolor == nil then tempcolor = "|cffdddddd" end
	pattern = string.gsub (pattern, "<ccolor>", tempcolor, 1, true)
	--DEFAULT_CHAT_FRAME:AddMessage (pattern) -- finally print -- 
	return pattern
end

function AOnlineM_Printplayer (name, online, argument1)
-- by providing the online information we force the printfunction to use the correct information

--	SetGuildRosterShowOffline(true); -- we dont need that?!
	GuildRoster()
	for i = 1, GetNumGuildMembers(true) do
		local Nname, Nrank, Nranki, Nlevel, Nclass, Nzone, Nnote, Nofficernote, Nonline, Nstatus = GetGuildRosterInfo(i, true)
		if (Nname == name) then
			return AOnlineM_Print (Nname, Nrank, Nranki, Nlevel, Nclass, Nzone, Nnote, Nofficernote, online, Nstatus)
		end -- if Nname
	end -- for
	return argument1 -- return unaltered version
end

function AOnlineM_colorencode (table)
	if table == nil then return "cffffffff" end
	return format("|cff%2x%2x%2x", table.r*255, table.g*255, table.b*255)
end

function AOnlineM_OnEvent() -- this is just used for init
	if event=="VARIABLES_LOADED" then
		AOnlineM_Variables()
		AOnlineM_Class = {}
		AOnlineM_Class[AOnlineM_DRUID] = "DRUID"
		AOnlineM_Class[AOnlineM_HUNTER] = "HUNTER"
		AOnlineM_Class[AOnlineM_MAGE] = "MAGE"
		AOnlineM_Class[AOnlineM_PALADIN] = "PALADIN"
		AOnlineM_Class[AOnlineM_PRIEST] = "PRIEST"
		AOnlineM_Class[AOnlineM_ROGUE] = "ROGUE"
		AOnlineM_Class[AOnlineM_SHAMAN] = "SHAMAN"
		AOnlineM_Class[AOnlineM_WARLOCK] = "WARLOCK"
		AOnlineM_Class[AOnlineM_WARRIOR] = "WARRIOR"
		AOnlineM_CCC = {}
		AOnlineM_CCC[AOnlineM_DRUID]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_DRUID]])
		AOnlineM_CCC[AOnlineM_HUNTER]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_HUNTER]])
		AOnlineM_CCC[AOnlineM_MAGE]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_MAGE]])
		AOnlineM_CCC[AOnlineM_PALADIN]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_PALADIN]])
		AOnlineM_CCC[AOnlineM_PRIEST]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_PRIEST]])
		AOnlineM_CCC[AOnlineM_ROGUE]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_ROGUE]])
		AOnlineM_CCC[AOnlineM_WARLOCK]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_WARLOCK]])
		AOnlineM_CCC[AOnlineM_WARRIOR]=AOnlineM_colorencode(RAID_CLASS_COLORS[AOnlineM_Class[AOnlineM_WARRIOR]])
	
	end
end

local AOnlineM_CFEO_original; -- evil hooking :)

function AOnlineM_CFEO (event)
	if event ~= "CHAT_MSG_SYSTEM" then
		return AOnlineM_CFEO_original(event) -- call the original CFEO
	end
	-- Event == CHAT_MSG_SYSTEM from here on
	
	if arg1==nil or arg1 == "" then 
		return AOnlineM_CFEO_original(event) 
	end
	
	if AOnlineM_Save.showOFF then
		local _, _, name = string.find (arg1, format(ERR_FRIEND_OFFLINE_S, "(.+)"))
		if (name ~= nil) then
			arg1 = AOnlineM_Printplayer (name, 0, arg1) -- modify arg1 
			return AOnlineM_CFEO_original(event) -- modified arg1 to CFOE
		end
	end
	if AOnlineM_Save.showON then
		local onlinestring = string.sub(ERR_FRIEND_ONLINE_SS, 20) -- cut the playerlink
		if string.find (arg1, onlinestring) then
			local pattern = string.gsub (ERR_FRIEND_ONLINE_SS, '[%|%[%]%.%:]','#') -- replace special characters by #
			local arg1mod = string.gsub (arg1, '[%|:%[%]%.]','#') -- replace special characters by #
			pattern = string.format (pattern, '(.+)', '(.+)') -- replace %s by (.+)
			local _, _, name, _ = string.find (arg1mod, pattern)
			if (name ~= nil) then
				arg1 = AOnlineM_Printplayer (name, 1, arg1) -- print player information : login
				return AOnlineM_CFEO_original(event) -- modified arg1 to CFOE
			end -- if name
		end
	end
	return AOnlineM_CFEO_original(event) -- if everything fails, just use the original
end

function AOnlineM_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
	AOnlineM_CFEO_original = ChatFrame_OnEvent
	ChatFrame_OnEvent = AOnlineM_CFEO
end
