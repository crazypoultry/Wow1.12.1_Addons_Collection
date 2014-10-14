XpCounter_Config = { }
-- "version"
-- "tooltip"
-- "overlay_show"
-- "overlay_locked"
-- "overlay_tooltip
-- "overlay_tooltip_anchor"
-- "overlay_text"
-- "xp_count"
-- "time"
-- "time_update"
-- "played_hours"
-- "played_minutes"
-- "kills"
-- "avg_kill_xp"

local XpCounter_Version = "0.13"
local XpCounter_time_hours = ""
local XpCounter_time_minutes = ""
local XpCounter_time_lvlup_hours = ""
local XpCounter_time_lvlup_minutes = ""
local XpCounter_xp = ""
local XpCounter_xp_max = ""
local XpCounter_xp_left = ""
local XpCounter_xp_percent = ""
local XpCounter_xp_rest = ""
local XpCounter_xp_epm = ""
local XpCounter_kills_left = 0
local XpCounter_Old_ExhaustionToolTipText = ""

function XpCounter_OnLoad()
	-- hide overlay
	XpCounter_Overlay:Hide()
	-- register slash commands
	SLASH_XpCounter1 = "/XpCounter"
	SLASH_XpCounter2 = "/xpc"
	SlashCmdList["XpCounter"] = XpCounter_SlashCmd
	-- register events
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_XP_UPDATE")
	this:RegisterEvent("PLAYER_LEVEL_UP")
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")	
	-- hook functions
	XpCounter_Old_ExhaustionToolTipText = ExhaustionToolTipText
	ExhaustionToolTipText = XpCounter_ExhaustionToolTipText
end

function XpCounter_Event()
	if ((event == "PLAYER_XP_UPDATE") or (event == "PLAYER_LEVEL_UP")) then
		XpCounter_Update()
	elseif (event == "CHAT_MSG_COMBAT_XP_GAIN") then
		XpCounter_Config["kills"] = XpCounter_Config["kills"] + 1
		local x = string.sub(arg1, string.find(arg1, "%d+"))
		if (XpCounter_Config["avg_kill_xp"] == 0) then
			XpCounter_Config["avg_kill_xp"] = x
		else
			XpCounter_Config["avg_kill_xp"] = math.ceil((XpCounter_Config["avg_kill_xp"] + x) / 2)
		end
		XpCounter_Update()
	elseif (event == "VARIABLES_LOADED") then	
		-- display about message
		XpCounter_print(string.format(XpCounter_msg_Loaded, XpCounter_Version, GetLocale()))
		-- check profile
		if (XpCounter_Config["version"] == nil) then
			XpCounter_CreateProfile()
		elseif (XpCounter_Config["version"] < XpCounter_Version) then
			XpCounter_UpdateProfile()
		end		
		-- set time
		XpCounter_time_hours   = 0
		XpCounter_time_minutes = 0
		local seconds = XpCounter_Config["time_update"] - XpCounter_Config["time"]
		local minutes = (math.floor(seconds / 60)) + XpCounter_Config["played_minutes"]
		XpCounter_Config["played_hours"] = (math.floor(minutes / 60)) + XpCounter_Config["played_hours"]
		XpCounter_Config["played_minutes"] = math.mod(minutes, 60)
		XpCounter_Config["time"] = GetTime()
		if ( (XpCounter_Config["played_hours"] ~= 0) or (XpCounter_Config["played_minutes"] ~= 0) ) then
			XpCounter_print(string.format(XpCounter_msg_Time, XpCounter_Config["played_hours"], XpCounter_Config["played_minutes"]))
		end	
		-- show overlay 
		if (XpCounter_Config["overlay_show"] == 1) then
			XpCounter_Overlay:Show()
		end	
	elseif (event == "PLAYER_ENTERING_WORLD") then
		-- set some values
		XpCounter_xp = UnitXP("player")
		XpCounter_Update()
	end
end

function XpCounter_SlashCmd(msg)
	local arg = ""
	local x = 0
	x = string.find(msg, " ")
	if (x ~= nil) then 
		arg = string.sub(msg, x+1)
		msg = string.sub(msg, 0, x-1)
	end
	if (msg == "show") then
		XpCounter_Config["overlay_show"] = 1
		XpCounter_Overlay:Show()
		XpCounter_Update()
		XpCounter_print(XpCounter_msg_Cmd_Show)
	elseif (msg == "hide") then
		XpCounter_Config["overlay_show"] = 0
		XpCounter_Overlay:Hide()
		XpCounter_print(XpCounter_msg_Cmd_Hide)
	elseif (msg == "lock") then
		XpCounter_Config["overlay_locked"] = 1
		XpCounter_print(XpCounter_msg_Cmd_Lock)
	elseif (msg == "unlock") then
		XpCounter_Config["overlay_locked"] = 0
		XpCounter_print(XpCounter_msg_Cmd_Unlock)
	elseif (msg == "reset") then
		XpCounter_Config["time"] = GetTime()
		XpCounter_Config["time_update"] = XpCounter_Config["time"]
		XpCounter_Config["played_hours"] = 0
		XpCounter_Config["played_minutes"] = 0
		XpCounter_Config["xp_count"] = 0
		XpCounter_Config["kills"] = 0	
		XpCounter_Config["avg_kill_xp"] = 0	
		XpCounter_Update()
		XpCounter_print(XpCounter_msg_Cmd_Reset)
	elseif (msg == "update") then
		XpCounter_Update()
		XpCounter_print(XpCounter_msg_Cmd_Update)
	elseif (msg == "tooltip_show") then
		if (XpCounter_Config["tooltip"] == 1) then
			XpCounter_Config["tooltip"] = 0
			XpCounter_print(XpCounter_msg_Cmd_Tooltip_off)
		else
			XpCounter_Config["tooltip"] = 1
			XpCounter_print(XpCounter_msg_Cmd_Tooltip_on)
		end
	elseif (msg == "tooltip_show_overlay") then
		if (XpCounter_Config["overlay_tooltip"] == 1) then
			XpCounter_Config["overlay_tooltip"] = 0
			XpCounter_print(XpCounter_msg_Cmd_Overlay_Tooltip_off)
		else
			XpCounter_Config["overlay_tooltip"] = 1
			XpCounter_print(XpCounter_msg_Cmd_Overlay_Tooltip_on)
		end
	elseif (msg == "tooltip_anchor_overlay") then
		if (XpCounter_Config["overlay_tooltip_anchor"] == 1) then
			XpCounter_Config["overlay_tooltip_anchor"] = 0
			XpCounter_print(XpCounter_msg_Cmd_Anchor_Overerlay_Tooltip_off)
		else
			XpCounter_Config["overlay_tooltip_anchor"] = 1
			XpCounter_print(XpCounter_msg_Cmd_Anchor_Overerlay_Tooltip_on)
		end			
	elseif ((msg == "set_overlay_text") or (msg == "sot")) then
		XpCounter_Config["overlay_text"] = arg
		XpCounter_print(string.format(XpCounter_msg_Cmd_Anchor_Overerlay_SetText, XpCounter_Config["overlay_text"]))
		XpCounter_UpdateOverlay()	
	elseif ((msg == "set_overlay_text_help") or (msg == "sot_help")) then	
		XpCounter_help(XpCounter_msg_Help_Format_Overlay, 1, 1)
	else
		XpCounter_help(XpCounter_msg_Help, 1)
	end
end

function XpCounter_Update()
	XpCounter_Config["time_update"] = GetTime()
	-- xp count	
	local xpplus = (UnitXP("player") - XpCounter_xp)
	if (xpplus < 0) then
		xpplus = XpCounter_xp_max - XpCounter_xp
		xpplus = xpplus + UnitXP("player")
	end
	XpCounter_Config["xp_count"] = XpCounter_Config["xp_count"] + xpplus
	-- xp, xpmax & xp left
	XpCounter_xp       = UnitXP("player")
	XpCounter_xp_max   = UnitXPMax("player")
	XpCounter_xp_left = XpCounter_xp_max - XpCounter_xp	
	if (XpCounter_xp_left < 0) then
		XpCounter_xp_left = 0
	end
	-- xp percent
	XpCounter_xp_percent = (XpCounter_xp / XpCounter_xp_max) * 1000
	XpCounter_xp_percent = math.floor(XpCounter_xp_percent + 0.5)
	XpCounter_xp_percent = XpCounter_xp_percent / 10
	if (XpCounter_xp_percent < 0) then
		XpCounter_xp_percent = 0
	end
	-- time
	local seconds = GetTime() - XpCounter_Config["time"]
	local minutes = (math.floor(seconds / 60)) + XpCounter_Config["played_minutes"]
	XpCounter_time_hours   = (math.floor(minutes / 60)) + XpCounter_Config["played_hours"]
	XpCounter_time_minutes = math.mod(minutes, 60)
	if (XpCounter_time_minutes < 10) then 
		XpCounter_time_minutes = "0"..XpCounter_time_minutes
	end
	-- epm
	minutes = minutes + (XpCounter_Config["played_hours"] * 60)
	if (minutes <= 1) then
		minutes = 1
	end
	XpCounter_xp_epm = XpCounter_Config["xp_count"] / (minutes)
	XpCounter_xp_epm = XpCounter_xp_epm * 100
	XpCounter_xp_epm = math.floor(XpCounter_xp_epm +0.5)
	XpCounter_xp_epm = XpCounter_xp_epm / 100
	XpCounter_xp_eph = XpCounter_xp_epm * 60
	-- time to levelup
	if (XpCounter_xp_epm <= 0) then
		XpCounter_time_lvlup_minutes = 0
		XpCounter_time_lvlup_hours = 0
	else
		XpCounter_time_lvlup_minutes = math.floor(XpCounter_xp_left / XpCounter_xp_epm)
		XpCounter_time_lvlup_hours = math.floor(XpCounter_time_lvlup_minutes / 60)
		XpCounter_time_lvlup_minutes = math.mod(XpCounter_time_lvlup_minutes, 60)			
	end
	-- bonus xp
	XpCounter_xp_rest = GetXPExhaustion();
	if ( (not XpCounter_xp_rest) or (XpCounter_xp_rest <= 0) ) then
		XpCounter_xp_rest = 0;
	end
	-- kills left
	if ((XpCounter_Config["avg_kill_xp"] == nil) or (XpCounter_Config["avg_kill_xp"] == 0)) then
		XpCounter_kills_left = "n.a."
	else
		XpCounter_kills_left = math.ceil(XpCounter_xp_left / XpCounter_Config["avg_kill_xp"])
	end
	-- update
	if (XpCounter_Config["overlay_show"] == 1) then
		XpCounter_UpdateOverlay()
	end	
end

function XpCounter_UpdateOverlay()
	msg = XpCounter_Config["overlay_text"]
	if (string.find(msg, "#xp_act#")) then
		msg = string.gsub(msg, "#xp_act#", XpCounter_xp)
	end
	if (string.find(msg, "#xp_max#")) then
		msg = string.gsub(msg, "#xp_max#", XpCounter_xp_max)
	end	
	if (string.find(msg, "#xp_perc#")) then
		msg = string.gsub(msg, "#xp_perc#", XpCounter_xp_percent)
	end	
	if (string.find(msg, "#xp_left#")) then
		msg = string.gsub(msg, "#xp_left#", XpCounter_xp_left)
	end			
	if (string.find(msg, "#xp_rested#")) then
		msg = string.gsub(msg, "#xp_rested#", XpCounter_xp_rest)
	end
	if (string.find(msg, "#xp#")) then
		msg = string.gsub(msg, "#xp#", XpCounter_Config["xp_count"])
	end
	if (string.find(msg, "#time_played#")) then
		msg = string.gsub(msg, "#time_played#", XpCounter_time_hours.."h"..XpCounter_time_minutes.."m")
	end
	if (string.find(msg, "#time_left#")) then
		msg = string.gsub(msg, "#time_left#", XpCounter_time_lvlup_hours.."h"..XpCounter_time_lvlup_minutes.."m")
	end
	if (string.find(msg, "#eph#")) then
		msg = string.gsub(msg, "#eph#", XpCounter_xp_eph)
	end
	if (string.find(msg, "#epm#")) then
		msg = string.gsub(msg, "#epm#", XpCounter_xp_epm)
	end
	if (string.find(msg, "#kills#")) then
		msg = string.gsub(msg, "#kills#", XpCounter_Config["kills"])
	end
	if (string.find(msg, "#avg_kill_xp#")) then
		msg = string.gsub(msg, "#avg_kill_xp#", XpCounter_Config["avg_kill_xp"])
	end
	if (string.find(msg, "#kills_left#")) then
		msg = string.gsub(msg, "#kills_left#", XpCounter_kills_left)
	end
	XpCounter_Overlay_ExpText:SetText(msg)
end


function XpCounter_CreateProfile(options)
	XpCounter_Config = {}
	XpCounter_Config["version"] = XpCounter_Version
	XpCounter_Config["tooltip"] = 1
	XpCounter_Config["overlay_show"] = 0
	XpCounter_Config["overlay_locked"] = 0
	XpCounter_Config["overlay_tooltip"] = 1
	XpCounter_Config["overlay_tooltip_anchor"] = 0	
	XpCounter_Config["overlay_text"] = "#xp_act#/#xp_max# (#xp_perc#% +#xp_rested#) #xp_left# XP left :: #kills# kills (#avg_kill_xp# XP) #kills_left# left :: #XP in #time_played# (#eph# / #epm#) #time_left# left"
	XpCounter_Config["xp_count"] = 0
	XpCounter_Config["time"] = GetTime()
	XpCounter_Config["time_update"] = XpCounter_Config["time"]
	XpCounter_Config["played_hours"] = 0
	XpCounter_Config["played_minutes"] = 0
	XpCounter_Config["kills"] = 0
	XpCounter_Config["avg_kill_xp"] = 0
	if (options ~= 'silent') then
		XpCounter_print(string.format(XpCounter_msg_CreateProfile, UnitName("player")))
	end
end

function XpCounter_UpdateProfile()
	old = XpCounter_Config
	XpCounter_CreateProfile('silent')
	for key,value in old do 
		if (key ~= 'version') then
			XpCounter_Config[key] = value
		end	
	end
	XpCounter_print(string.format(XpCounter_msg_UpdateProfile, UnitName("player")))
end

function XpCounter_locked()
	return XpCounter_Config["overlay_locked"];
end

function XpCounter_ToolTip_show()
	if (XpCounter_Config["overlay_tooltip"] == 1) then 
		if (XpCounter_Config["overlay_tooltip_anchor"] == 1) then 
			GameTooltip:SetOwner(XpCounter_Overlay, "ANCHOR_CURSOR")
		else
			 GameTooltip_SetDefaultAnchor(GameTooltip, XpCounter_Overlay);
		end
		GameTooltip:SetText(XpCounter_GetToolTipText())
		GameTooltip:Show()
	end
end

function XpCounter_ToolTip_hide()
	GameTooltip:Hide()
end

function XpCounter_ExhaustionToolTipText()
	XpCounter_Old_ExhaustionToolTipText()
	if (XpCounter_Config["tooltip"] == 1) then
		GameTooltip:SetText(XpCounter_GetToolTipText())
		GameTooltip:Show()
	else
		XpCounter_Old_ExhaustionToolTipText()
	end
end

function XpCounter_GetToolTipText()
	-- xp, xpmax, xpproc, xpleft, xprest, hours, minutes, xpcount, epm, eph, kills, avg_kill_xp, kills_left, lvlup_hours, lvlup_minutes
	return string.format(XpCounter_msg_ToolTip, 
							XpCounter_xp, 
							XpCounter_xp_max, 
							XpCounter_xp_percent, 
							XpCounter_xp_left, 
							XpCounter_xp_rest, 
							XpCounter_time_hours, 
							XpCounter_time_minutes, 
							XpCounter_Config["xp_count"], 
							XpCounter_xp_eph, 
							XpCounter_xp_epm, 
							XpCounter_Config["kills"], 
							XpCounter_Config["avg_kill_xp"], 
							XpCounter_kills_left, 
							XpCounter_time_lvlup_hours, 
							XpCounter_time_lvlup_minutes )
end	
	
function XpCounter_help(msg, parse, masked)
	for key,val in msg do
		if (parse ~= nil) then
			x, y = string.find(val, "%[[^%]]+%]")
			if (y ~= nil) then
				x = string.sub(val, x+1, y-1)
				x = "|cff666666"..string.upper(x).."|cffffffff"
				if (masked ~= nil) then
					x = "|cffffcc00#|cffffffff"..x.."|cffffcc00#|cffffffff"
				else
					x = x.." - "
				end	
				val = string.gsub(val, "%[[^%]]+%]", x, 1)			
			end			
		end
		XpCounter_print(val)
	end
end

function XpCounter_print(msg)
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("[XpCounter] "..msg)
	end
end
