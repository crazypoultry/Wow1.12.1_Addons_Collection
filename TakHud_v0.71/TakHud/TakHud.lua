---------
function TakHud_OnLoad()
---------
	SlashCmdList["TAKHUD"] = function(msg) TakHud_SlashCmd(msg) end
	SLASH_TAKHUD1 = "/takhud"
	SLASH_TAKHUD2 = "/thud"
	TakHud_PlayerName = UnitName("player")
	_, TakHud_PlayerClass = UnitClass("player")
	TakHud_SettingsVersion = 0.7
end --function

---------
function TakHud_OnUpdate(elapsed)
---------
	if not TakHud_Timer then return end
	if TakHud_Timer > 0 then
		TakHud_Timer = TakHud_Timer - elapsed
	else
		if TakHud_Settings["targettarget"].enabled then
			TakHud_BarUpdate(TakHud_TargetTargetBar)
		end --if
		TakHud_BuffUpdate()
		TakHud_Timer = 0.1
	end --if
end --function

---------
function TakHud_OnEvent(event)
---------
	if event == "VARIABLES_LOADED" then
		TakHud_Bars = {
			["playerhealth"] = TakHud_PlayerHealthBar,
			["playerenergy"] = TakHud_PlayerEnergyBar,
			["targethealth"] = TakHud_TargetHealthBar,
			["targetenergy"] = TakHud_TargetEnergyBar,
			["targettarget"] = TakHud_TargetTargetBar,
		}
		TakHud_LoadSettings()
		TakHud_LoadBars()
		TakHud_LoadBuffs()
		TakHud_Timer = 0.1
	elseif event == "PLAYER_AURAS_CHANGED" then
		if not TakHud_Timer then return end
		for loc, buff in pairs(TakHud_Buffs) do
			if buff.name ~= "CP" then buff.check = true end
		end --for
		TakHud_BuffUpdate()
	elseif event == "PLAYER_COMBO_POINTS" then
		if not TakHud_Timer then return end
		TakHud_ComboUpdate()
	else
		if not TakHud_Timer then return end
		if event == "PLAYER_ENTER_COMBAT" then TakHud_InCombat = true
		elseif event == "PLAYER_LEAVE_COMBAT" then TakHud_InCombat = false
		elseif event == "PLAYER_REGEN_DISABLED" then TakHud_NoRegen = true
		elseif event == "PLAYER_REGEN_ENABLED" then TakHud_NoRegen = false
		end --if
		for barid, bar in pairs(TakHud_Bars) do
			TakHud_BarUpdate(bar)
		end --for
	end --if
end --function

---------
function TakHud_SlashCmd(msg)
---------
	local cmd, msg = TakHud_ParseSlashCmd(string.lower(msg or ""))
	if not cmd then
		TakHud_Msg("|cff0080ff/thud move|lock||reset|r to drag bars around on screen")
		TakHud_Msg("|cff0080ff/thud edit|save|r to edit bar patterns and tracked buffs")
		TakHud_Msg("|cff0080ff/thud always|combat|disable|r to set when bars are shown")
	elseif TakHud_SlashFunctions[cmd] then
		local func = TakHud_SlashFunctions[cmd]
		if msg then
			if TakHud_Bars[msg] then
				func(TakHud_Bars[msg])
			else
				return
			end --if
		else
			for barid, bar in pairs(TakHud_Bars) do
				func(bar)
			end --for
		end --if
	end --if
end --function

---------
function TakHud_ParseSlashCmd(msg)
---------
	if msg then
		local cmdstart, cmdend, cmd = string.find(msg, "(%S+)")
		if cmd then
			local msg = string.sub(msg, cmdend + 2)
			if (msg == "") then msg = nil end
			return cmd, msg
		end --if
 	end --if
end --function

---------
function TakHud_LoadSettings()
---------
	if ((not TakHud_Settings) or (TakHud_Settings.version ~= TakHud_SettingsVersion)) then
		TakHud_Settings = {}
		local settings = TakHud_Settings
		local defaults = TakHud_Defaults
		settings.version = TakHud_SettingsVersion 
		for barid, bar in pairs(TakHud_Bars) do
			settings[barid] = {}
			if defaults[barid].target == "player" then
				settings[barid].enabled = "combat"
			else
				settings[barid].enabled = "always"
			end --if
			settings[barid].pattern = defaults[barid].pattern
			if defaults[barid][string.lower(TakHud_PlayerClass)] then
				settings[barid].left = defaults[barid][string.lower(TakHud_PlayerClass)].left
			else
				settings[barid].left = ""
			end --if
			if defaults[barid][string.lower(TakHud_PlayerClass)] then
				settings[barid].right = defaults[barid][string.lower(TakHud_PlayerClass)].right
			else
				settings[barid].right = ""
			end --if
		end --for
	end --if
end --function

---------
function TakHud_LoadBars()
---------
	for barid, bar in pairs(TakHud_Bars) do
		bar.id = barid
		bar.mode = TakHud_Defaults[barid].mode
		bar.target = TakHud_Defaults[barid].target
		bar.scheme = TakHud_Defaults[barid].scheme
		bar.text = getglobal(bar:GetName().."Text")
		bar.bar = getglobal(bar:GetName().."Bar")
		bar.locked = true
		if not bar:IsUserPlaced() then
			TakHud_BarReset(bar)
		end --if
		if TakHud_Settings[barid].enabled then
			TakHud_BarOn(bar)
			TakHud_BarUpdate(bar)
		else
			TakHud_BarOff(bar)
			TakHud_BarUpdate(bar)
		end --if
	end --for
end --function

---------
function TakHud_LoadBuffs()
---------
	TakHud_Buffs = {}
	for barid, bar in pairs(TakHud_Bars) do
		if TakHud_Settings[barid].left ~= "" then
			TakHud_Buffs[getglobal(bar:GetName().."Left")] = {name = TakHud_Settings[barid].left, check = true}
		end --if
		if TakHud_Settings[barid].right ~= "" then
			TakHud_Buffs[getglobal(bar:GetName().."Right")] = {name = TakHud_Settings[barid].right, check = true}
		end --if
	end --for
end --function

---------
function TakHud_BarUpdate(bar, target)
---------
	if not bar.locked then
		bar.text:SetText(bar.id)
		bar.bar:SetMinMaxValues(0, 1)
		bar.bar:SetValue(0)
		bar:Show()
		return
	end --if
	if bar.editing then
		bar:Hide()
		return
	end --if
	if target then if target ~= bar.target then return end end
	if not TakHud_Settings[bar.id].enabled then return end
	if not UnitExists(bar.target) then bar:Hide() return end
	TakHud_GetBarData(bar)
	if bar.max == 0 then bar:Hide() return end
	bar.bar:SetMinMaxValues(0, bar.max)
	bar.bar:SetValue(bar.cur)
	local color = TakHud_GetBarColor(bar)
	bar.bar:SetStatusBarColor(color[1], color[2], color[3], 0.7)
	local text = TakHud_GetBarText(bar)
	bar.text:SetText(text)
	if TakHud_Settings[bar.id].enabled == "always" then
		bar:Show()
	elseif TakHud_Settings[bar.id].enabled == "combat" then
		if (TakHud_InCombat or TakHud_NoRegen) then
			bar:Show()
		elseif bar.target == "player" then
			if (bar.type and (bar.type == 1) and (bar.cur == 0)) then
				bar:Hide()
			elseif bar.cur ~= bar.max then
				bar:Show()
			else
				bar:Hide()
			end --if
		else
			bar:Hide()
		end --if
	end --if
end --function

---------
function TakHud_GetBarData(bar)
---------
	bar.name = UnitName(bar.target)
	if UnitIsPlayer(bar.target) then
		bar.class, bar.classEN = UnitClass(bar.target)
	else
		bar.class = "Mob"; bar.classEN = "MOB"
	end --if
	bar.level = UnitLevel(bar.target)
	if bar.level < 0 then
		bar.level = "Boss"
	end --if
	if bar.mode == "health" then
		bar.cur = UnitHealth(bar.target)
		bar.max = UnitHealthMax(bar.target)
		bar.type = nil
	elseif bar.mode == "energy" then
		bar.cur = UnitMana(bar.target)
		bar.max = UnitManaMax(bar.target)
		bar.type = UnitPowerType(bar.target)
	end --if
	bar.def = bar.max - bar.cur
	bar.frac = math.floor((bar.cur * 100 / bar.max) + 0.5)
end --function

---------
function TakHud_GetBarText(bar)
---------
	local line
	line = TakHud_Settings[bar.id].pattern
	line = string.gsub(line, "&name", bar.name)
	line = string.gsub(line, "&class", bar.class)
	line = string.gsub(line, "&level", bar.level)
	line = string.gsub(line, "&cur", bar.cur)
	line = string.gsub(line, "&max", bar.max)
	line = string.gsub(line, "&frac", bar.frac)
	if bar.def > 0 then
		line = string.gsub(line, "&def", "|cffff1919-"..bar.def.."|r")
	else
		line = string.gsub(line, "&def", "")
	end --if
	if bar.scheme == "target" then
		if bar.name == TakHud_PlayerName then
			line = ">> "..line.." <<"
		end --if
	end --if
	return line
end --function

---------
function TakHud_GetBarColor(bar)
---------
	local color
	if bar.scheme == "health" then
		color = TakHud_Colors["health"][25 * math.ceil(bar.frac / 25)]
	elseif bar.scheme == "energy" then
		color = TakHud_Colors["energy"][bar.type]
	elseif bar.scheme == "target" then
		if bar.name == TakHud_PlayerName then
			color = "self"
		else
			color = string.lower(bar.classEN)
		end --if
	end --if
	return TakHud_Colors[color]
end --function

---------
function TakHud_BarOn(bar)
---------
	for eventid, event in pairs(TakHud_Defaults[bar.id].events) do
		bar:RegisterEvent(event)
	end --for
end --function

---------
function TakHud_BarOff(bar)
---------
	bar:UnregisterAllEvents()
	bar:Hide()
end --function

---------
function TakHud_BarMove(bar)
---------
	if bar.editing then TakHud_BarSave(bar) end
	bar.locked = false
	TakHud_BarUpdate(bar)
end --function

---------
function TakHud_BarLock(bar)
---------
	bar.locked = true
	TakHud_BarUpdate(bar)
end --function

---------
function TakHud_BarReset(bar)
---------
	if bar.editing then TakHud_BarSave(bar) end
	local pos = TakHud_Defaults[bar.id].position
	bar:ClearAllPoints()
	bar:SetPoint("TOP", "UIParent", "CENTER", pos.x, pos.y)
end --function

---------
function TakHud_BarEdit(bar)
---------
	if not bar.locked then TakHud_BarLock(bar) end
	bar.editing = true
	TakHud_BarUpdate(bar)
	getglobal(bar:GetName().."EditTextBox"):SetText(TakHud_Settings[bar.id].pattern)
	getglobal(bar:GetName().."EditLeftBox"):SetText(TakHud_Settings[bar.id].left)
	getglobal(bar:GetName().."EditRightBox"):SetText(TakHud_Settings[bar.id].right)
	getglobal(bar:GetName().."Edit"):Show()
end --function

---------
function TakHud_BarSave(bar)
---------
	getglobal(bar:GetName().."Edit"):Hide()
	if bar.editing then
		TakHud_Settings[bar.id].pattern = getglobal(bar:GetName().."EditTextBox"):GetText()
		TakHud_Settings[bar.id].left = getglobal(bar:GetName().."EditLeftBox"):GetText()
		TakHud_Settings[bar.id].right = getglobal(bar:GetName().."EditRightBox"):GetText()
	end --if
	bar.editing = false
	TakHud_BarUpdate(bar)
	TakHud_LoadBuffs()
end --function

---------
function TakHud_BarEnable(bar, switch)
---------
	TakHud_Settings[bar.id].enabled = switch
	if switch then
		TakHud_BarOn(bar)
	else
		TakHud_BarOff(bar)
	end --if
	TakHud_LoadBars()
end --function

---------
function TakHud_BuffUpdate()
---------
	for loc, buff in pairs(TakHud_Buffs) do
		if buff.check then
			if TakHud_BuffFind(loc, buff) then
				loc:Show()
			else
				buff.check = false
				loc:Hide()
			end --if
		end --if
	end --for
end --function

---------
function TakHud_BuffFind(loc, buff)
---------
	local left = 0
	while (GetPlayerBuff(left , "HELPFUL|HARMFUL|PASSIVE") >= 0) do
		TakHud_Tooltip:SetOwner(UIParent,"ANCHOR_NONE")
		local index = GetPlayerBuff(left , "HELPFUL|HARMFUL|PASSIVE")
		TakHud_Tooltip:SetPlayerBuff(index)
		local tip = TakHud_TooltipTextLeft1:GetText() or ""
		if tip == buff.name then
			left = math.floor(GetPlayerBuffTimeLeft(left))
			if left <= 9 then
				color = TakHud_Colors["red"]
			else
				color = TakHud_Colors["yellow"]
			end --if
			loc:SetTextColor(color[1], color[2], color[3])
			loc:SetText(left)
			return left
		else
			left = left + 1
		end --if
	end --while
	return nil
end --function

---------
function TakHud_ComboUpdate()
---------
	local combo = GetComboPoints()
	local color
	if combo == 5 then
		color = TakHud_Colors["red"]
	elseif combo > 0 then
		color = TakHud_Colors["yellow"]
	else
		for loc, buff in pairs(TakHud_Buffs) do
			if buff.name == "CP" then
				loc:Hide()
			end --if
		end --for
		return
	end --if
	for loc, buff in pairs(TakHud_Buffs) do
		if buff.name == "CP" then
			loc:SetTextColor(color[1], color[2], color[3])
			loc:SetText(combo)
			loc:Show()
		end --if
	end --for
end --function

TakHud_Colors = {
	["red"] = {0.8, 0.0, 0.0},
	["green"] = {0.0, 0.8, 0.0},
	["blue"] = {0.0, 0.0, 0.8},
	["yellow"] = {0.8, 0.8, 0.0},
	["orange"] = {0.8, 0.4, 0.0},
	["grey"] = {0.5, 0.5, 0.5},
	["druid"] = {1.0, 0.49, 0.04},
	["hunter"] = {0.67, 0.83, 0.45},
	["mage"] = {0.41, 0.8, 0.94},
	["paladin"] = {0.96, 0.55, 0.73},
	["priest"] = {1.0, 1.0, 1.0},
	["rogue"] = {1.0, 0.96, 0.41},
	["shaman"] = {0.96, 0.55, 0.73},
	["warlock"] = {0.58, 0.51, 0.79},
	["warrior"] = {0.78, 0.61, 0.43},
	["mob"] = {0.5, 0.5, 0.5},
	["self"] = {0.8, 0.0, 0.0},
	["health"] = {[100] = "green", [75] = "yellow", [50] = "orange", [25] = "red", [0] = "grey"},
	["energy"] = {[0] = "blue", [1] = "red", [2] = "orange", [3] = "yellow"},
}

TakHud_SlashFunctions = {
	["move"] = TakHud_BarMove,
	["lock"] = TakHud_BarLock,
	["reset"] = TakHud_BarReset,
	["edit"] = TakHud_BarEdit,
	["save"] = TakHud_BarSave,
	["always"] = function(bar) TakHud_BarEnable(bar, "always") end,
	["combat"] = function(bar) TakHud_BarEnable(bar, "combat") end,
	["disable"] = function(bar) TakHud_BarEnable(bar) end,
}	

TakHud_Defaults = {
	["playerhealth"] = {
		["pattern"] = "&cur / &max",
		["position"] = {x = 0, y = -120},
		["mode"] = "health",
		["target"] = "player",
		["scheme"] = "health",
		["events"] = {"UNIT_HEALTH", "UNIT_MAXHEALTH", "PLAYER_ENTERING_WORLD"},
	},
	["playerenergy"] = {
		["pattern"] = "&cur / &max",
		["position"] = {x = 0, y = -136},
		["mode"] = "energy",
		["target"] = "player",
		["scheme"] = "energy",
		["events"] = {"UNIT_ENERGY", "UNIT_MAXENERGY", "UNIT_MANA", "UNIT_MAXMANA", "UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_DISPLAYPOWER", "PLAYER_ENTERING_WORLD"},
		["rogue"] = {left = "Slice and Dice", right = "CP"},
		["warrior"] = {left = "Battle Shout", right = ""},
	},
	["targethealth"] = {
		["pattern"] = "&name &frac%",
		["position"] = {x = 0, y = -168},
		["mode"] = "health",
		["target"] = "target",
		["scheme"] = "health",
		["events"] = {"UNIT_HEALTH", "UNIT_MAXHEALTH", "PLAYER_TARGET_CHANGED"},
	},
	["targetenergy"] = {
		["pattern"] = "&frac%",
		["position"] = {x = 0, y = -184},
		["mode"] = "energy",
		["target"] = "target",
		["scheme"] = "energy",
		["events"] = {"UNIT_ENERGY", "UNIT_MAXENERGY", "UNIT_MANA", "UNIT_MAXMANA", "UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_DISPLAYPOWER", "PLAYER_TARGET_CHANGED"},
	},
	["targettarget"] = {
		["pattern"] = "&name - &class",
		["position"] = {x = 0, y = -152},
		["mode"] = "health",
		["target"] = "targettarget",
		["scheme"] = "target",
		["events"] = {"PLAYER_TARGET_CHANGED"},
	},
}

---------
function TakHud_Msg(msg)
---------
	if DEFAULT_CHAT_FRAME and msg then
		DEFAULT_CHAT_FRAME:AddMessage("TakHud: "..msg)
	end --if
end --function