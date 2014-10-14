--[[
	BCastBar
		A Bongos based cast bar
--]]

local function AdjustWidth(castingBar)
	local castingBarName = castingBar:GetName()

	local textWidth = getglobal(castingBarName .. "Text"):GetStringWidth()
	if getglobal(castingBarName .. "Time"):IsShown() then
		textWidth = textWidth + 36
	end

	local diff = textWidth * 1.25 - castingBar.normalWidth
	if diff > 0 then
		diff = textWidth * 1.25 - castingBar:GetWidth()
	else
		diff = castingBar.normalWidth - castingBar:GetWidth()
	end

	if diff ~= 0 then
		castingBar:GetParent():SetWidth(castingBar:GetParent():GetWidth() + diff)
		castingBar:SetWidth(castingBar:GetWidth() + diff)

		getglobal(castingBarName .. "Border"):SetWidth( getglobal(castingBarName .. "Border"):GetWidth() + (diff * 1.32))
		getglobal(castingBarName .. "Flash"):SetWidth( getglobal(castingBarName .. "Flash"):GetWidth() + (diff * 1.32))
	end
end

--[[ Event Functions ]]--

local function OnSpellStart(bar)
	bar.startTime = GetTime()
	bar.maxValue = bar.startTime + (arg2 / 1000)
	bar.holdTime = 0
	bar.casting = 1
	bar.fadeOut = nil
	bar.mode = "casting"

	local barName = bar:GetName()
	getglobal(barName .. "Spark"):Show()
	getglobal(barName .. "Text"):SetText(arg1)

	bar:SetStatusBarColor(1, 0.7, 0)
	bar:SetMinMaxValues(bar.startTime, bar.maxValue)
	bar:SetValue(bar.startTime)
	bar:SetAlpha(bar:GetParent():GetAlpha())
	bar:Show()
end

local function OnSpellStop(bar, isSpellStop)
	if not bar:IsVisible() then
		bar:Hide()
	elseif bar:IsShown() then
		bar.flash = 1
		bar.fadeOut = 1
		bar.mode = "flash"
		if isSpellStop then
			bar.casting = nil
		else
			bar.channeling = nil
		end

		local barName = bar:GetName()
		getglobal(barName .. "Spark"):Hide()
		getglobal(barName .. "Flash"):SetAlpha(0)
		getglobal(barName .. "Flash"):Show()

		bar:SetValue(bar.maxValue)
		bar:SetStatusBarColor(0.0, 1.0, 0.0)
	end
end

local function OnSpellFailed(bar, spellFailed)
	bar.casting = nil
	bar.fadeOut = 1
	bar.holdTime = GetTime() + CASTING_BAR_HOLD_TIME

	local barName = bar:GetName()
	getglobal(barName .. "Spark"):Hide()
	if spellFailed then
		getglobal(barName .. "Text"):SetText(FAILED)
	else
		getglobal(barName .. "Text"):SetText(INTERRUPTED)
	end

	bar:SetValue(bar.maxValue)
	bar:SetStatusBarColor(1, 0, 0)
end

local function OnSpellDelayed(bar)
	bar.startTime = bar.startTime + (arg1 / 1000)
	bar.maxValue = bar.maxValue + (arg1 / 1000)

	bar:SetMinMaxValues(bar.startTime, bar.maxValue)
end

local function OnChannelStart(bar)
	bar.holdTime = 0
	bar.channeling = 1
	bar.maxValue = 1
	bar.startTime = GetTime()
	bar.duration = arg1 / 1000
	bar.endTime = bar.startTime + bar.duration
	bar.casting = nil
	bar.fadeOut = nil

	local barName = bar:GetName()
	getglobal(barName .. "Spark"):Show()
	getglobal(barName .. "Text"):SetText(arg2)

	bar:SetStatusBarColor(1, 0.7, 0)
	bar:SetMinMaxValues(bar.startTime, bar.endTime)
	bar:SetValue(bar.endTime)
	bar:SetAlpha(bar:GetParent():GetAlpha())
	bar:Show()
end

local function OnChannelUpdate(bar)
	local origDuration = bar.endTime - bar.startTime
	bar.endTime = GetTime() + (arg1 / 1000)
	bar.startTime = bar.endTime - origDuration

	bar:SetMinMaxValues(bar.startTime, bar.endTime)
end

local function OnEvent()
	if event == "SPELLCAST_START" then
		OnSpellStart(this)
	elseif event == "SPELLCAST_STOP" or event == "SPELLCAST_CHANNEL_STOP" then
		OnSpellStop(this, event == "SPELLCAST_STOP")
	elseif event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
		if this:IsShown() and not this.channeling then
			OnSpellFailed(this, event == "SPELLCAST_FAILED")
		end
	elseif event == "SPELLCAST_DELAYED" then
		if this:IsShown() then
			OnSpellDelayed(this)
		end
	elseif event == "SPELLCAST_CHANNEL_START" then
		OnChannelStart(this)
	elseif event == "SPELLCAST_CHANNEL_UPDATE" then
		if this:IsShown() then
			OnChannelUpdate(this)
		end
	end
end

--[[ OnUpdate Functions ]]--

local function UpdateCasting(bar)
	local status = GetTime()
	if status > bar.maxValue then
		status = bar.maxValue
	end

	local sparkPosition = ((status - bar.startTime) / (bar.maxValue - bar.startTime)) * bar:GetWidth()
	if sparkPosition < 0 then
		sparkPosition = 0
	end

	local barName = bar:GetName()
	getglobal(barName .. "Time"):SetText(format("%.1f", bar.maxValue - status))
	getglobal(barName .. "Flash"):Hide()
	getglobal(barName .. "Spark"):SetPoint("CENTER", bar, "LEFT", sparkPosition, 2)
	bar:SetValue(status)

	AdjustWidth(bar)
end

local function UpdateChanneling(bar)
	local time = GetTime()
	if time >= bar.endTime then
		bar.channeling = nil
		bar.fadeOut = 1
	else
		local remain = bar.endTime - time
		local value = bar.startTime + remain
		local sparkPosition = ((value - bar.startTime) / (bar.endTime - bar.startTime)) * bar:GetWidth()
		local barName = bar:GetName()

		getglobal(barName .. "Time"):SetText(format("%.1f", remain))
		getglobal(barName .. "Flash"):Hide()
		getglobal(barName .. "Spark"):SetPoint("CENTER", bar, "LEFT", sparkPosition, 2)
		bar:SetValue(value)

		AdjustWidth(bar)
	end
end

local function UpdateFlash(bar)
	local flash = getglobal(bar:GetName() .. "Flash")
	local parentAlpha = bar:GetParent():GetAlpha()
	local alpha = flash:GetAlpha() + CASTING_BAR_FLASH_STEP * parentAlpha

	if alpha < parentAlpha then
		flash:SetAlpha(alpha)
	else
		flash:SetAlpha(parentAlpha)
		bar.flash = nil
	end
end

local function UpdateFade(bar)
	local alpha = bar:GetAlpha() - CASTING_BAR_ALPHA_STEP * bar:GetParent():GetAlpha()
	if alpha > 0 then
		bar:SetAlpha(alpha)
	else
		bar.fadeOut = nil
		bar:Hide()
	end
end

local function OnUpdate()
	if this.casting then
		UpdateCasting(this)
	elseif this.channeling then
		UpdateChanneling(this)
	elseif GetTime() < this.holdTime then
		return
	elseif this.flash then
		UpdateFlash(this)
	elseif this.fadeOut then
		UpdateFade(this)
	end
end

--[[ CastingBar Constructor ]]--

local function CastingBar_Create(parent)
	local bar = CreateFrame("StatusBar", parent:GetName() .. "CastBar", parent, "BongosCastingBarTemplate")
	bar.normalWidth = bar:GetWidth()
	bar.holdTime = 0

	bar:SetScript("OnUpdate", OnUpdate)
	bar:SetScript("OnEvent", OnEvent)

	bar:RegisterEvent("SPELLCAST_START")
	bar:RegisterEvent("SPELLCAST_STOP")
	bar:RegisterEvent("SPELLCAST_FAILED")
	bar:RegisterEvent("SPELLCAST_INTERRUPTED")
	bar:RegisterEvent("SPELLCAST_DELAYED")
	bar:RegisterEvent("SPELLCAST_CHANNEL_START")
	bar:RegisterEvent("SPELLCAST_CHANNEL_UPDATE")
	bar:RegisterEvent("SPELLCAST_CHANNEL_STOP")

	return bar
end

--[[ Config Functions ]]--

local function ToggleText(bar, enable)
	local castingBar = getglobal(bar:GetName() .. 'CastBar')

	if enable then
		getglobal(castingBar:GetName() .. "Time"):Show()
		bar.sets.showText = 1
	else
		getglobal(castingBar:GetName() .. "Time"):Hide()
		bar.sets.showText = nil
	end

	AdjustWidth(castingBar)
end

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu")
	menu:SetWidth(220)
	menu:SetHeight(150)
	menu:SetText("Cast Bar")

	local timeButton = CreateFrame("CheckButton", name .. "Time", menu, "BongosCheckButtonTemplate")
	timeButton:SetScript("OnClick", function() ToggleText(this:GetParent().frame, this:GetChecked()) end)
	timeButton:SetPoint("TOPLEFT", menu, "TOPLEFT", 8, -28)
	timeButton:SetText(BONGOS_CASTBAR_SHOW_TIME)

	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider")
	scaleSlider:SetPoint("TOPLEFT", timeButton, "BOTTOMLEFT", 2, -10)

	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider")
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24)
end

local function ShowMenu(bar)
	if not BongosCastBarMenu then
		CreateConfigMenu("BongosCastBarMenu")
		BongosCastBarMenu.frame = bar
	end

	BongosCastBarMenu.onShow = 1

	BongosCastBarMenuTime:SetChecked(bar.sets.showText)
	BongosCastBarMenuScale:SetValue(bar:GetScale() * 100)
	BongosCastBarMenuOpacity:SetValue(bar:GetAlpha() * 100)

	BMenu.ShowForBar(BongosCastBarMenu, bar)
	BongosCastBarMenu.onShow = nil
end

--[[ Startup ]]--

local function OnCreate(bar)
	CastingBarFrame:UnregisterAllEvents()
	CastingBarFrame:Hide()

	local castingBar = CastingBar_Create(bar)
	castingBar:SetPoint("TOPLEFT", bar, "TOPLEFT", 8, -12)
end

BProfile.AddStartup(function()
	local bar = BBar.Create("cast", "BCastBar", "BCastBarSets", ShowMenu, 1, nil, OnCreate)
	bar:SetWidth(212); bar:SetHeight(30)

	if not bar:IsUserPlaced() then
		bar:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	end
	ToggleText(bar, bar.sets.showText)
end)