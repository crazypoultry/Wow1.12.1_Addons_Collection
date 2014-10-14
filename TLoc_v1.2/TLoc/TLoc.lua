--[[

	Target Locator 1.2 by Mortymer

--]]

TLoc_COMMAND = "/tloc"
TLoc_HELP = "help"
TLoc_CLEAR_TARGET_SET = "rset"
TLoc_RELATIVE = "abs"
TLoc_LOCK = "lock"
TLoc_SCALE = "scale"
TLoc_ALPHA = "alpha"

TLoc_HELP_TEXT = {
		"TLoc commands:",
		TLoc_CLEAR_TARGET_SET .. ": Set the range for reaching target (default 1).",
		TLoc_RELATIVE .. ": Toggle between relative and absolute mode (default relative).",
		TLoc_LOCK .. ": Lock/Unlock the compass (default locked).",
		TLoc_SCALE .. " #: Scale the compass by # (default 1).",
		TLoc_ALPHA .. " #: Set the compass alpha value to # (default 1).",
}

TLoc_CONFIG = {CLEAR_RANGE=1, RELATIVE=true, LOCKED=true, SCALE=1, ALPHA=1}

TLoc_UPDATE_RATE = 0.1

local playerArrow

function TLoc_SlashCommandHandler(msg)
	local index
	local value
	local x
	local y
	local command

	if (string.find(msg,"%a+") ~= nil) then
		x,y,command = string.find(msg,"(%a+)")
		command = string.lower(command)
	end
   
	if (command == nil) then
		for index, value in TLoc_HELP_TEXT do
			DEFAULT_CHAT_FRAME:AddMessage(value)
		end
	elseif (command == TLoc_RELATIVE) then
		TLoc_Relative()
	elseif (command == TLoc_CLEAR_TARGET_SET) then 
		TLoc_RSet(msg)
	elseif (command == TLoc_HELP) then
		for index, value in TLoc_HELP_TEXT do
			DEFAULT_CHAT_FRAME:AddMessage(value)
		end
	elseif (command == TLoc_LOCK) then
		TLoc_Lock()
	elseif (command == TLoc_SCALE) then 
		TLoc_Scale(msg)
	elseif (command == TLoc_ALPHA) then 
		TLoc_Alpha(msg)
	end
end

function TLoc_OnLoad()
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	TLocFrame.TimeSinceLastUpdate = 0
	local obs = {Minimap:GetChildren()}
	for i = 1, getn(obs), 1 do
		if (obs[i]:IsObjectType("Model") and
				obs[i]:GetModel() == 
				"Interface\\Minimap\\MinimapArrow") then
			playerArrow = obs[i]
			break
		end
	end
	SLASH_TLoc1 = TLoc_COMMAND
	SlashCmdList["TLoc"] = function(msg)
		TLoc_SlashCommandHandler(msg)
	end
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Target Locator loaded.")
	end
end

function TLoc_OnUpdate(arg1)
	TLocFrame.TimeSinceLastUpdate = TLocFrame.TimeSinceLastUpdate + arg1
	if (TLocFrame.TimeSinceLastUpdate > TLoc_UPDATE_RATE) then
      		TLoc_UpdateCompass()
		TLocGFX_SetTexture()
		TLocFrame.TimeSinceLastUpdate = 0
	end
end

function TLoc_OnEvent()
	if (event == "PLAYER_TARGET_CHANGED") then
		TLoc_UpdateCompass()
	elseif (event == "VARIABLES_LOADED") then
		if (TLoc_CONFIG.LOCKED) then
			TLocGFXFrame:EnableMouse(false)
		else
			TLocGFXFrame:EnableMouse(true)
		end
		TLocGFXFrame:SetScale(TLoc_CONFIG.SCALE)
		TLocGFXFrame:SetAlpha(TLoc_CONFIG.ALPHA)
		SetMapToCurrentZone()
	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		SetMapToCurrentZone()
	end
end

function TLoc_Relative()
	if (not TLoc_CONFIG.RELATIVE) then 
		TLoc_CONFIG.RELATIVE = true
		DEFAULT_CHAT_FRAME:AddMessage("Compass set to relative mode.")
	else
		TLoc_CONFIG.RELATIVE = false
		DEFAULT_CHAT_FRAME:AddMessage("Compass set to absolute mode.")
	end
end

function TLoc_RSet(msg)
	if (string.find(msg,"%d+") ~= nil) then
		x = string.find(msg,"%d+")
		y = string.len(msg)
		TLoc_CONFIG.CLEAR_RANGE = 
				tonumber(string.sub(string.lower(msg),x,y))
		DEFAULT_CHAT_FRAME:AddMessage(
				"Clear Target range set to: "..TLoc_CONFIG.CLEAR_RANGE)
	else
		LOC_CONFIG.CLEAR_RANGE = 1
	end
end

function TLoc_Lock()
	if (TLoc_CONFIG.LOCKED) then
		TLoc_CONFIG.LOCKED = false
		TLocGFXFrame:EnableMouse(true)
		DEFAULT_CHAT_FRAME:AddMessage("Compass unlocked.")
	else
		TLoc_CONFIG.LOCKED = true
		TLocGFXFrame:EnableMouse(false)
		DEFAULT_CHAT_FRAME:AddMessage("Compass locked.")
	end
end

function TLoc_Scale(msg)
	if (string.find(msg,"%d+") ~= nil) then
		x = string.find(msg,"%d+")
		y = string.len(msg)
		TLoc_CONFIG.SCALE = 
				tonumber(string.sub(string.lower(msg),x,y))
		DEFAULT_CHAT_FRAME:AddMessage(
				"Scale set to: "..TLoc_CONFIG.SCALE)
	else
		TLoc_CONFIG.SCALE = 1
	end
	TLocGFXFrame:SetScale(TLoc_CONFIG.SCALE)
end

function TLoc_Alpha(msg)
	if (string.find(msg,"%d+") ~= nil) then
		x = string.find(msg,"%d+")
		y = string.len(msg)
		TLoc_CONFIG.ALPHA = 
				tonumber(string.sub(string.lower(msg),x,y))
		DEFAULT_CHAT_FRAME:AddMessage(
			"	Alpha set to: "..TLoc_CONFIG.ALPHA)
	else
		TLoc_CONFIG.ALPHA = 1
	end
	TLocGFXFrame:SetAlpha(TLoc_CONFIG.ALPHA)
end

function TLoc_UpdateCompass()
	if (UnitIsUnit("target", "player") or (not UnitInParty("target") and not UnitInRaid("target"))) then
		TLocGFXFrame:Hide()
		return
	end
	local tx,ty = GetPlayerMapPosition("target")
	if (not tx or not ty or (tx == 0 and ty == 0)) then
		TLocGFXFrame:Hide()
		return
	end
	tx = tx
	ty = ty
	local px, py = GetPlayerMapPosition("player")
	px = px
	py = py
	local dist = 1000000*math.sqrt((px - tx)*(px - tx) + (py - ty)*(py - ty))/230
	if (dist < TLoc_CONFIG.CLEAR_RANGE) then 
		TLocGFXFrame:Hide()
		return
	end
	local pdir = (playerArrow:GetFacing()) / (math.pi/180) + 90
	if (pdir > 360) then
		pdir = pdir - 360
	end
	dir = 180 - math.deg(math.atan2((py-ty), (px-tx)))
	if (not TLoc_CONFIG.RELATIVE) then
		tdir = dir
	else
		local ttdir = 90 - (pdir - dir)
		if (ttdir > 360) then
			ttdir = ttdir - 360
		elseif (ttdir < 0) then
			ttdir = ttdir + 360
		end
		tdir = ttdir
	end
	TLocGFXFrame:Show()
end