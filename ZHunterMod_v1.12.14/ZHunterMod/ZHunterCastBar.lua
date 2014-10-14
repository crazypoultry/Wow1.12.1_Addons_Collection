ZHunterMod_Saved["ZHunterCastBar"] = {}
ZHunterMod_Saved["ZHunterCastBar"]["autoshot"] = nil
ZHunterMod_Saved["ZHunterCastBar"]["aimedshot"] = nil

ZHunterCastBar_AutoShot = nil
ZHunterCastBar_LastSpell = nil

function ZHunterCastBar_CastAimed()
	if ZHunterMod_Saved["ZHunterCastBar"]["aimedshot"] and ZHunterCastBar.spell ~= ZHUNTER_AIMED then
		local min = GetTime()
		local max = min + ZHunterCastBar_GetCastSpeed()
		ZHunterCastBar:SetStatusBarColor(1.0, 0.7, 0.0)
		ZHunterCastBarSpark:Show()
		ZHunterCastBar:SetMinMaxValues(min, max)
		ZHunterCastBar:SetValue(min)
		ZHunterCastBarTextLeft:SetText(ZHUNTER_AIMED)
		ZHunterCastBar:SetAlpha(1.0)
		ZHunterCastBar.casting = 1
		ZHunterCastBar.fadeOut = nil
		ZHunterCastBar:Show()
		ZHunterCastBar.spell = ZHUNTER_AIMED
	end
end

function ZHunterCastBar_CastAuto(useold)
	if ZHunterMod_Saved["ZHunterCastBar"]["autoshot"] then
		local min, max
		if useold and ZHunterCastBar.min and ZHunterCastBar.max then
			min = ZHunterCastBar.min
			max = ZHunterCastBar.max
		else
			min = GetTime()
			max = min + UnitRangedDamage("player")
		end
		ZHunterCastBar:SetStatusBarColor(0.0, 0.5, 1.0)
		ZHunterCastBarSpark:Show()
		ZHunterCastBar.min = min
		ZHunterCastBar.max = max
		ZHunterCastBar:SetMinMaxValues(min, max)
		ZHunterCastBar:SetValue(min)
		ZHunterCastBarTextLeft:SetText(ZHUNTER_AUTO)
		ZHunterCastBar:SetAlpha(1.0)
		ZHunterCastBar.casting = 1
		ZHunterCastBar.fadeOut = nil
		ZHunterCastBar:Show()
		ZHunterCastBar.spell = ZHUNTER_AUTO
	end
end

function ZHunterCastBar_OnEvent()
	if event == "START_AUTOREPEAT_SPELL" then
		ZHunterCastBar_AutoShot = 1
	elseif event == "STOP_AUTOREPEAT_SPELL" then
		ZHunterCastBar_AutoShot = nil
		if ZHunterCastBar.spell ~= ZHUNTERAIMED then
			ZHunterCastBar_FlashBar()
		end
	elseif event == "SPELLCAST_STOP" then
		if ZHunterCastBar_AutoShot and ZHunterMod_Saved["ZHunterCastBar"]["autoshot"] then
			local visible = ZHunterCastBar:IsVisible()
			local value, max = ZHunterCastBar:GetMinMaxValues()
			value = ZHunterCastBar:GetValue()
			value = max - value
			if not ZHunterCastBar_LastSpell or ZHunterCastBar_LastSpell == ZHUNTER_AUTO or not visible or (visible and value < 0.1) then
				ZHunterCastBar_CastAuto()
			end
		else
			ZHunterCastBar_FlashBar()
		end
		ZHunterCastBar_LastSpell = nil
	elseif event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
		if ZHunterCastBar.spell ~= ZHUNTER_AUTO then
			if ZHunterCastBar_AutoShot then
				ZHunterCastBar_CastAuto(1)
			else
				ZHunterCastBar_Interrupted()
			end
		end
		ZHunterCastBar_LastSpell = nil
	elseif event == "SPELLCAST_DELAYED" then
		if ZHunterCastBar:IsShown() and ZHunterCastBar.spell == ZHUNTER_AIMED then
			local min, max = ZHunterCastBar:GetMinMaxValues()
			local delay = arg1 / 1000
			min = min + delay
			max = max + delay
			ZHunterCastBar:SetMinMaxValues(min, max)
		end
	end
end

function ZHunterCastBar_OnLoad()
	this:RegisterEvent("START_AUTOREPEAT_SPELL")
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL")
	this:RegisterEvent("SPELLCAST_INTERRUPTED")
	this:RegisterEvent("SPELLCAST_FAILED")
	this:RegisterEvent("SPELLCAST_STOP")
	this:RegisterEvent("SPELLCAST_DELAYED")
	this:SetMinMaxValues(0, 1)
	this:SetValue(1)
end

function ZHunterCastBar_GetCastSpeed()
	local speedmin = UnitRangedDamage("player")
	local speedmax, text
	if speedmin > 0 then
		ZHunterCastBar_Tooltip:SetOwner(UIParent, "ANCHOR_NONE")
		ZHunterCastBar_Tooltip:SetInventoryItem("player", 18)
		for i=1,10 do
			text = getglobal("ZHunterCastBar_TooltipTextRight"..i)
			if text:IsVisible() then
				_, _, speedmax = string.find(text:GetText(), "([%,%.%d]+)")
				if speedmax then
					if not tonumber(speedmax) then
						speedmax = string.gsub(speedmax, "%,", "%.")
					end
					break
				end
			end
		end
	end
	local speed = 1
	if tonumber(speedmax) then
		speed = speedmax / speedmin
	end
	speed = (3.0 / speed) + 0.6
	return speed
end

function ZHunterCastBar_OnUpdate()
	local min, max = ZHunterCastBar:GetMinMaxValues()
	if this.casting then
		local status = GetTime()
		if status > max then
			status = max
		end
		ZHunterCastBarTextRight:SetText(format("%0.1f",max-status))
		ZHunterCastBar:SetValue(status)
		ZHunterCastBarFlash:Hide()
		local sparkPosition = ((status - min) / (max - min)) * 195
		if sparkPosition < 0 then
			sparkPosition = 0
		end
		ZHunterCastBarSpark:SetPoint("CENTER", ZHunterCastBar, "LEFT", sparkPosition, 0)
	elseif this.flash then
		local alpha = ZHunterCastBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP
		if alpha < 1 then
			ZHunterCastBarFlash:SetAlpha(alpha)
		else
			ZHunterCastBarFlash:SetAlpha(1.0)
			this.flash = nil
		end
	elseif this.fadeOut then
		local alpha = this:GetAlpha() - CASTING_BAR_ALPHA_STEP
		if alpha > 0 then
			this:SetAlpha(alpha)
		else
			this.fadeOut = nil
			this:Hide()
		end
	end
end

function ZHunterCastBar_Interrupted()
	if ZHunterCastBar:IsShown() then
		local min,max = ZHunterCastBar:GetMinMaxValues()
		ZHunterCastBar:SetValue(max)
		ZHunterCastBar:SetStatusBarColor(1.0, 0.0, 0.0)
		ZHunterCastBarSpark:Hide()
		ZHunterCastBarTextLeft:SetText("Interrupted")
		ZHunterCastBarFlash:SetAlpha(0.0)
		ZHunterCastBarFlash:Show()
		ZHunterCastBar.casting = nil
		ZHunterCastBar.flash = 1
		ZHunterCastBar.fadeOut = 1
	end
	ZHunterCastBar.spell = ""
end

function ZHunterCastBar_FlashBar()
	if not ZHunterCastBar:IsVisible() then
		ZHunterCastBar:Hide()
	end
	if ZHunterCastBar:IsShown() then
		local min, max = ZHunterCastBar:GetMinMaxValues()
		ZHunterCastBar:SetValue(max)
		ZHunterCastBar:SetStatusBarColor(0.0, 1.0, 0.0)
		ZHunterCastBarSpark:Hide()
		ZHunterCastBarFlash:SetAlpha(0.0)
		ZHunterCastBarFlash:Show()
		ZHunterCastBar.casting = nil
		ZHunterCastBar.flash = 1
		ZHunterCastBar.fadeOut = 1
	end
end

ZHunterCastBar_CastSpell = CastSpell
function CastSpell(spell, tab, a, b, c, d, e)
	local name = GetSpellName(spell, tab)
	ZHunterCastBar_LastSpell = name
	if name == ZHUNTER_AIMED then
		ZHunterCastBar_CastAimed()
	end
	return ZHunterCastBar_CastSpell(spell, tab, a, b, c, d, e)
end

ZHunterCastBar_UseAction = UseAction
function UseAction(slot, checkCursor, onSelf, a, b, c, d, e)
	ZHunterCastBar_Tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	ZHunterCastBar_Tooltip:SetAction(slot)
	local name = ZHunterCastBar_TooltipTextLeft1:GetText()
	ZHunterCastBar_LastSpell = name
	if name == ZHUNTER_AIMED then
--		local usable, oom = IsUsableAction(slot)
--		local range = IsActionInRange(slot)
--		if usable and range and range > 0 and not oom then
			ZHunterCastBar_CastAimed()
--		end
	end
	return ZHunterCastBar_UseAction(slot, checkCursor, onSelf, a, b, c, d, e)
end

ZHunterCastBar_CastSpellByName = CastSpellByName
function CastSpellByName(spell, onSelf, a, b, c, d, e)
	local _, _, name = string.find(spell or "", "([%w%'%s]+)")
	ZHunterCastBar_LastSpell = name
	if name == ZHUNTER_AIMED then
		ZHunterCastBar_CastAimed()
	end
	return ZHunterCastBar_CastSpellByName(spell, onSelf, a, b, c, d, e)
end

SLASH_ZHunterCastBar1 = "/zcastbar"
SlashCmdList["ZHunterCastBar"] = function(msg)
	if msg == "move" then
		if ZHunterCastBarMove:IsVisible() then
			ZHunterCastBarMove:Hide()
			ZHunterCastBar:Hide()
		else
			ZHunterCastBarMove:Show()
			ZHunterCastBar:Show()
			ZHunterCastBar:SetAlpha(1)
		end
	elseif msg == "auto" then
		if ZHunterMod_Saved["ZHunterCastBar"]["autoshot"] then
			ZHunterMod_Saved["ZHunterCastBar"]["autoshot"] = nil
			DEFAULT_CHAT_FRAME:AddMessage("Auto Shot casting bar disabled.", 0, 1, 1)
		else
			ZHunterMod_Saved["ZHunterCastBar"]["autoshot"] = 1
			DEFAULT_CHAT_FRAME:AddMessage("Auto Shot casting bar enabled.", 0, 1, 1)
		end
	elseif msg == "aimed" then
		if ZHunterMod_Saved["ZHunterCastBar"]["aimedshot"] then
			ZHunterMod_Saved["ZHunterCastBar"]["aimedshot"] = nil
			DEFAULT_CHAT_FRAME:AddMessage("Aimed Shot casting bar disabled.", 0, 1, 1)
		else
			ZHunterMod_Saved["ZHunterCastBar"]["aimedshot"] = 1
			DEFAULT_CHAT_FRAME:AddMessage("Aimed Shot casting bar enabled.", 0, 1, 1)
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Possible Commands: \"move\", \"auto\", \"aimed\"", 0, 1, 1)
	end
end