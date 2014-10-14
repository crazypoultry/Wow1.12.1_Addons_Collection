--[[
	Bongos_XP\xpBar.lua
		Scripts for the Bongos XP bar
--]]

local DEFAULT_HEIGHT = 14
local DEFAULT_SIZE = 0.75

local xpBar, restBar, text, bg
local WatchRep, WatchXP

--[[ OnX Functions ]]--

local function OnRepEvent()
	if restBar:IsShown() then
		local name, reaction, min, max, value = GetWatchedFactionInfo()
		if name then
			max = max - min
			value = value - min

			local color = FACTION_BAR_COLORS[reaction]
			bg:SetVertexColor(color.r * 0.25, color.g * 0.25, color.b * 0.25, 0.5)
			xpBar:SetStatusBarColor(color.r, color.g, color.b)
			xpBar:SetMinMaxValues(0, max)
			xpBar:SetValue(value)

			text:SetText(value .. " / " .. max)
		else
			WatchXP()
		end
	end
end

function WatchRep()
	restBar:SetValue(0)
	restBar:UnregisterAllEvents()
	restBar:SetScript("OnEvent", OnRepEvent)
	restBar:RegisterEvent("UPDATE_FACTION")
	restBar:SetStatusBarColor(0, 0, 0, 0)

	OnRepEvent()
end

local function OnXPEvent()
	if restBar:IsShown() then
		if GetWatchedFactionInfo() then
			WatchRep()
		else
			local value = UnitXP("player")
			local max = UnitXPMax("player")

			xpBar:SetMinMaxValues(0, max)
			xpBar:SetValue(value)

			restBar:SetMinMaxValues(0, max)
			if GetXPExhaustion() then
				restBar:SetValue(value + GetXPExhaustion())
			else
				restBar:SetValue(0)
			end
			text:SetText(max - value .. " tnl")
		end
	end
end

function WatchXP()
	restBar:UnregisterAllEvents()
	restBar:SetScript("OnEvent", OnXPEvent)
	restBar:RegisterEvent("UPDATE_FACTION")
	restBar:RegisterEvent("PLAYER_LOGIN")
	restBar:RegisterEvent("PLAYER_LEVEL_UP")
	restBar:RegisterEvent("PLAYER_XP_UPDATE")
	restBar:RegisterEvent("UPDATE_EXHAUSTION")

	restBar:SetStatusBarColor(0.25, 0.25, 1)
	xpBar:SetStatusBarColor(0.6, 0, 0.6)
	bg:SetVertexColor(0.3, 0, 0.3, 0.6)

	OnXPEvent()
end

--[[ Configuration ]]--

local function SetSize(percent)
	if BXPBar.sets.vertical then
		BXPBar:SetHeight(UIParent:GetHeight() / UIParent:GetScale() * (percent or DEFAULT_SIZE))
	else
		BXPBar:SetWidth(UIParent:GetWidth() / UIParent:GetScale() * (percent or DEFAULT_SIZE))
	end
	BXPBar.sets.size = percent
end

--yes, a weird name
local function SetHeight(value)
	if BXPBar.sets.vertical then
		BXPBar:SetWidth(value or DEFAULT_HEIGHT)
	else
		BXPBar:SetHeight(value or DEFAULT_HEIGHT)
	end
	BXPBar.sets.height = value
end

--set how tall/wide the xp bar should be
local function SetVertical(vertical)
	if vertical then
		xpBar:SetOrientation("VERTICAL")
		xpBar:SetStatusBarTexture(BONGOS_XP_VERTICAL_TEXTURE)

		restBar:SetOrientation("VERTICAL")
		restBar:SetStatusBarTexture(BONGOS_XP_VERTICAL_TEXTURE)
		bg:SetTexture(BONGOS_XP_VERTICAL_TEXTURE)
		BXPBar.sets.vertical = 1
	else
		xpBar:SetOrientation("HORIZONTAL")
		xpBar:SetStatusBarTexture(BONGOS_XP_HORIZONTAL_TEXTURE)

		restBar:SetOrientation("HORIZONTAL")
		restBar:SetStatusBarTexture(BONGOS_XP_HORIZONTAL_TEXTURE)
		bg:SetTexture(BONGOS_XP_HORIZONTAL_TEXTURE)
		BXPBar.sets.vertical = nil
	end

	SetSize(BXPBar.sets.size)
	SetHeight(BXPBar.sets.height)
end

--[[ Menu Functions ]]--

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu")
	menu:SetText("XP Bar")
	menu:SetWidth(220)
	menu:SetHeight(264)

	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate")

	local verticalButton = CreateFrame("CheckButton", name .. "Vertical", menu, "BongosCheckButtonTemplate")
	verticalButton:SetScript("OnClick", function()
		SetVertical(this:GetChecked())
		if this:GetChecked() then
			getglobal(this:GetParent():GetName() .. "SizeText"):SetText("Height")
			getglobal(this:GetParent():GetName() .. "HeightText"):SetText("Width")
		else
			getglobal(this:GetParent():GetName() .. "SizeText"):SetText("Width")
			getglobal(this:GetParent():GetName() .. "HeightText"):SetText("Height")
		end
	end)
	verticalButton:SetPoint("TOP", hideButton, "BOTTOM", 0, 4)
	verticalButton:SetText(BONGOS_XP_VERTICAL)

	local sizeSlider = CreateFrame("Slider", name .. "Size", menu, "BongosSlider")
	sizeSlider:SetPoint("TOPLEFT", name .. "Vertical", "BOTTOMLEFT", 2, -10)
	sizeSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			SetSize(this:GetValue() / 100)
		end
		getglobal(this:GetName() .. "ValText"):SetText(this:GetValue())
	end)
	sizeSlider:SetValueStep(1)
	sizeSlider:SetMinMaxValues( 0, 100 )
	getglobal(name .. "SizeLow"):SetText("0%")
	getglobal(name .. "SizeHigh"):SetText("100%")

	local heightSlider = CreateFrame("Slider", name .. "Height", menu, "BongosSlider")
	heightSlider:SetPoint("TOP", sizeSlider, "BOTTOM", 0, -24)
	heightSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			SetHeight(this:GetValue())
		end
		getglobal(this:GetName() .. "ValText"):SetText(this:GetValue())
	end)
	heightSlider:SetValueStep(1)
	heightSlider:SetMinMaxValues( 0, 96 )
	getglobal(name .. "HeightLow"):SetText(0)
	getglobal(name .. "HeightHigh"):SetText(96)

	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider")
	scaleSlider:SetPoint("TOP", heightSlider, "BOTTOM", 0, -24)

	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider")
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24)
end

local function ShowMenu(bar)
	if not BongosXPBarMenu then
		CreateConfigMenu("BongosXPBarMenu")
		BongosXPBarMenu.frame = bar
	end

	BongosXPBarMenu.onShow = 1

	BongosXPBarMenuVertical:SetChecked(bar.sets.vertical)
	if bar.sets.vertical then
		BongosXPBarMenuSizeText:SetText(BONGOS_XP_HEIGHT)
		BongosXPBarMenuHeightText:SetText(BONGOS_XP_WIDTH)
	else
		BongosXPBarMenuSizeText:SetText(BONGOS_XP_WIDTH)
		BongosXPBarMenuHeightText:SetText(BONGOS_XP_HEIGHT)
	end

	BongosXPBarMenuSize:SetValue((bar.sets.size or DEFAULT_SIZE) * 100)
	BongosXPBarMenuHeight:SetValue(bar.sets.height or DEFAULT_HEIGHT)
	BongosXPBarMenuScale:SetValue(bar:GetScale() * 100)
	BongosXPBarMenuOpacity:SetValue(bar:GetAlpha() * 100)

	BMenu.ShowForBar(BongosXPBarMenu, bar)
	BongosXPBarMenu.onShow = nil
end

--[[ Startup Functions ]]--

local function OnCreate(parent)
	parent:SetFrameStrata('BACKGROUND')

	local parentName = parent:GetName()
	restBar = CreateFrame("StatusBar", parentName .. "XPRest", parent)
	restBar:SetAllPoints(parent)
	restBar:SetAlpha(parent:GetAlpha())
	restBar:SetClampedToScreen(true)

	bg = restBar:CreateTexture(restBar:GetName() .. "Background", "BACKGROUND")
	bg:SetAllPoints(restBar)

	xpBar = CreateFrame("StatusBar", parentName .. "XP", restBar)
	xpBar:EnableMouse(true)
	xpBar:SetClampedToScreen(true)
	xpBar:SetAllPoints(restBar)
	xpBar:SetAlpha(restBar:GetAlpha())
	xpBar:SetScript('OnEnter', function() text:Show() end)
	xpBar:SetScript('OnLeave', function() text:Hide() end)

	text = xpBar:CreateFontString(xpBar:GetName() .. "Text", "OVERLAY")
	text:SetFontObject(GameFontHighlight)
	text:SetNonSpaceWrap(false)
	text:SetAllPoints(xpBar)
	text:SetJustifyH('CENTER')
	text:SetJustifyV('CENTER')
	text:Hide()
	
	return restbar
end

BProfile.AddStartup(function()
	local bar = BBar.Create("xp", "BXPBar", "BXPBarSets", ShowMenu, nil, nil, OnCreate)
	if not bar:IsUserPlaced() then
		bar:SetPoint("TOP", UIParent, "TOP", 0, -32)
	end
	SetVertical(bar.sets.vertical)

	if GetWatchedFactionInfo() then
		WatchRep()
	else
		WatchXP()
	end
end)
Infield.AddRescaleAction(function() SetVertical(BXPBar.sets.vertical) end)