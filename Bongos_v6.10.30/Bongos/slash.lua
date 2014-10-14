--[[
	slash
		Slash command handler for Bongos
		All commands start with /bg or /bongos
		
	Valid strings for <bar>:
		<number> - an action bar
		bags - bag bar
		menu - menu bar
		pet - pet bar
		class - class bar
		stats - stat bar
		all - all bars
--]]

local function GetRestofMessage(args)
	if args[2] then
		local name = args[2]
		for i = 3, table.getn(args) do
			name = name .. " " .. args[i]
		end
		return name
	end
end

--Display commands
local function ShowCommands()
	BMsg(BONGOS_COMMANDS)
	BMsg(BONGOS_SHOW_OPTIONS)
	BMsg(BONGOS_SHOW_HELP)
	
	--bar commands
	BMsg(BONGOS_LOCK)
	BMsg(BONGOS_UNLOCK)
	BMsg(BONGOS_SHOW)
	BMsg(BONGOS_HIDE)
	BMsg(BONGOS_TOGGLE)
	BMsg(BONGOS_SET_SCALE)
	BMsg(BONGOS_SET_OPACITY)
	BMsg(BONGOS_SET_STICKY)

	--Profile commands
	BMsg(BONGOS_LOAD_PROFILE)
	BMsg(BONGOS_SAVE_PROFILE)
	BMsg(BONGOS_DELETE_PROFILE)
	BMsg(BONGOS_RESET)
	BMsg(BONGOS_SET_DEFAULT_PROFILE)
	BMsg(BONGOS_CLEAR_DEFAULT_PROFILE)
	
	BMsg(BONGOS_REUSE)
end

--Slash handler
SlashCmdList["BongosCOMMAND"] = function(msg)
	if msg == "" then
		if BongosOptions then
			BongosOptions:Show()
		else
			local _, _, _, enabled = GetAddOnInfo("Bongos_Options")
			if enabled then
				LoadAddOn("Bongos_Options")
			else
				ShowCommands()
			end
		end		
	else
		local args = {}
		for word in string.gfind(msg, "[^%s]+") do
			table.insert(args, word)
		end
		local cmd = string.lower(args[1])
		
		if cmd == "help" or cmd == "?" then
			ShowCommands()
		elseif cmd == "lock" then
			Bongos_SetLock(true)
		elseif cmd == "unlock" then
			Bongos_SetLock(nil)
		elseif cmd == "stickybars" then
			Bongos_SetStickyBars(string.lower(args[2]) == "on")
		elseif cmd == "show" then
			for i = 2, table.getn(args) do
				Bongos_ForBar(string.lower(args[i]), BBar.Show, 1)
			end
		elseif cmd == "hide" then
			for i = 2, table.getn(args) do
				Bongos_ForBar(string.lower(args[i]), BBar.Hide, 1)
			end
		elseif cmd == "toggle" then
			for i = 2, table.getn(args) do
				Bongos_ForBar(string.lower(args[i]), BBar.Toggle, 1)
			end
		elseif cmd == "scale" then
			local size = table.getn(args)
			local scale = tonumber(args[size])
			for i = 2, size - 1 do
				Bongos_ForBar(string.lower(args[i]), BBar.SetScale, scale, 1)
			end
		elseif cmd == "setalpha" then
			local size = table.getn(args)
			local alpha = tonumber(args[size])
			for i = 2, size - 1 do
				Bongos_ForBar(string.lower(args[i]), BBar.SetAlpha, alpha, 1)
			end
		elseif cmd == "reset" then
			BProfile.Reset()
		elseif cmd == "load" then
			BProfile.Load(GetRestofMessage(args))
		elseif cmd == "save" then
			BProfile.Save(GetRestofMessage(args))
		elseif cmd == "delete" then
			BProfile.Delete(GetRestofMessage(args))
		elseif cmd == "setdefault" then
			BProfile.SetDefault(GetRestofMessage(args))
		elseif cmd == "cleardefault" then
			BProfile.SetDefault(nil)
		elseif cmd == "reuse" then
			Bongos_Reuse(string.lower(args[2]) == "on")
		else
			BMsg(format(BONGOS_UNKNOWN_COMMAND, cmd or 'nil'))
		end
	end
end
SLASH_BongosCOMMAND1 = "/bongos"
SLASH_BongosCOMMAND2 = "/bob"