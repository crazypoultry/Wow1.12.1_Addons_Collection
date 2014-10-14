--[[ 
	slash.lua
		Slash command handler for Ludwig
		
	Commands:
		/lw or /ludwig
			start of a command, shows the UI if its enabled
		/lw refresh
			resets the database
		/lw minquality <value>
			sets the minimum quality of items to be viewable
		/lw <name>
			prints a list of items matching <name>
--]]

local PrintMsg = function(msg) DEFAULT_CHAT_FRAME:AddMessage(msg, 0, 0.9, 0) end

local function PrintList(name, list, startTime)
	PrintMsg(format(LUDWIG_MATCH_COUNT, table.getn(list), name))
	for i, link in pairs(list) do 
		PrintMsg(Ludwig_GetHyperLink(link))
		if i > 9 then break end
	end
	collectgarbage()
	PrintMsg(format(LUDWIG_GENTIME, GetTime() - startTime))
end

local function ListItemsOfName(name)
	local startTime = GetTime()
	local list = Ludwig_GetItems(name)
	
	if list then
		PrintList(name, list, startTime)
	else
		collectgarbage()
		PrintMsg(format(LUDWIG_UNKNOWN_NAME, name))
	end
end

--[[ Initialize Slash Command Handler ]]--
SlashCmdList["LudwigSlashCOMMAND"] = function(msg)
	if not msg or msg == "" and LudwigUIParent then
		LudwigUIParent:Show()
	else
		local _, _, cmd, arg1 = string.find(string.lower(msg), "%-(%w+)%s?(%d*)")
		if cmd then
			if cmd == "refresh" then
				Ludwig_Reload()
				PrintMsg(LUDWIG_DATABSE_REFRESHED)
			elseif cmd == "minquality" then
				if tonumber(arg1) then 
					Ludwig_SetMinQuality(tonumber(arg1))
					PrintMsg(format(LUDWIG_MINQUALITY_SET, arg1))
				end
			else
				PrintMsg(format(LUDWIG_UNKNOWN_COMMAND, cmd))
			end
		else
			ListItemsOfName(msg)
		end
	end
end
SLASH_LudwigSlashCOMMAND1 = "/lw"
SLASH_LudwigSlashCOMMAND2 = "/ludwig"