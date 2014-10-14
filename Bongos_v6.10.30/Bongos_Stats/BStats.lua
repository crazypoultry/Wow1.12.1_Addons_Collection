--[[
	BongosStats
		A movable memory, latency and fps display for Bongos

	Version History
		10/8/5
			Initial release
		10/11/5
			Updated for Bongos 0.4.0/Patch 1800
		12/16/05
			Made the text bigger
			Added a seperate keybinding
		8/14/6
			Made into a full Bongos Bar
		10/27/6
			Modified to use MiB instead of MB
			Added customization options
--]]

local UPDATE_DELAY = 1

local function Update(bar)
	local barName = bar:GetName()

	local fpsText = getglobal(barName .. "FPS")
	if bar.sets.showFPS then
		fpsText:SetText(format("%.1f", GetFramerate()) .. "FPS")
	else
		fpsText:SetText('')
	end

	local memoryText = getglobal(barName .. "Memory")
	if bar.sets.showMemory then
		memoryText:SetText(format("%.3f", gcinfo() / 1024).."MB")
	else
		memoryText:SetText('')
	end

	local latencyText = getglobal(barName .. "Latency")
	if bar.sets.showLatency then
		local _, _, latency = GetNetStats()
		if (latency > PERFORMANCEBAR_MEDIUM_LATENCY) then
			latencyText:SetTextColor(1, 0, 0)
		elseif (latency > PERFORMANCEBAR_LOW_LATENCY) then
			latencyText:SetTextColor(1, 1, 0)
		else
			latencyText:SetTextColor(0, 1, 0)
		end
		latencyText:SetText(latency .. "ms")
	else
		latencyText:SetText('')
	end

	local width = fpsText:GetStringWidth() + memoryText:GetStringWidth() + latencyText:GetStringWidth()
	if width == 0 then
		bar:SetWidth(24)
	else
		bar:SetWidth(width + 4)
	end
end

local function OnUpdate()
	if this.toNextUpdate <= 0 then
		this.toNextUpdate = UPDATE_DELAY
		Update(this)
	else
		this.toNextUpdate = this.toNextUpdate - arg1
	end
end

--[[ Menu Functions ]]--

local function ShowFPS(enable)
	if enable then
		BStatsSets.showFPS = 1
	else
		BStatsSets.showFPS = nil
	end
	Update(BongosStats)
end

local function ShowMemory(enable)
	if enable then
		BStatsSets.showMemory = 1
	else
		BStatsSets.showMemory = nil
	end
	Update(BongosStats)
end

local function ShowLatency(enable)
	if enable then
		BStatsSets.showLatency = 1
	else
		BStatsSets.showLatency = nil
	end
	Update(BongosStats)
end

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu")
	menu:SetText("Stats Bar")
	menu:SetWidth(220); menu:SetHeight(236)

	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate")

	local fpsButton = CreateFrame("CheckButton", name .. "FPS", menu, "BongosCheckButtonTemplate")
	fpsButton:SetScript("OnClick", function() ShowFPS(this:GetChecked()) end)
	fpsButton:SetPoint("TOP", hideButton, "BOTTOM", 0, 4)
	fpsButton:SetText(BONGOS_STATS_SHOW_FPS)

	local memoryButton = CreateFrame("CheckButton", name .. "Memory", menu, "BongosCheckButtonTemplate")
	memoryButton:SetScript("OnClick", function() ShowMemory(this:GetChecked()) end)
	memoryButton:SetPoint("TOP", fpsButton, "BOTTOM", 0, 4)
	memoryButton:SetText(BONGOS_STATS_SHOW_MEMORY)

	local latencyButton = CreateFrame("CheckButton", name .. "Latency", menu, "BongosCheckButtonTemplate")
	latencyButton:SetScript("OnClick", function() ShowLatency(this:GetChecked()) end)
	latencyButton:SetPoint("TOP", memoryButton, "BOTTOM", 0, 4)
	latencyButton:SetText(BONGOS_STATS_SHOW_LATENCY)

	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider")
	scaleSlider:SetPoint("TOPLEFT", latencyButton, "BOTTOMLEFT", 2, -10)

	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider")
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24)
	
	return menu
end

local function ShowMenu(bar)
	local menuName = 'BongosStatsBarMenu'
	local menu = getglobal(menuName)

	if not menu then
		menu = CreateConfigMenu(menuName)
		menu.frame = bar
	end

	menu.onShow = 1

	getglobal(menuName .. 'Hide'):SetChecked(not bar.sets.vis)
	getglobal(menuName .. 'FPS'):SetChecked(bar.sets.showFPS)
	getglobal(menuName .. 'Memory'):SetChecked(bar.sets.showMemory)
	getglobal(menuName .. 'Latency'):SetChecked(bar.sets.showLatency)
	getglobal(menuName .. 'Scale'):SetValue(bar:GetScale() * 100)
	getglobal(menuName .. 'Opacity'):SetValue(bar:GetAlpha() * 100)

	BMenu.ShowForBar(menu, bar)

	menu.onShow = nil
end

--[[ Startup ]]--

local function OnCreate(bar)
	local name = bar:GetName()

	local fpsText = bar:CreateFontString(name .. "FPS")
	fpsText:SetFontObject("GameFontNormalLarge")
	fpsText:SetPoint("LEFT", bar)

	local memoryText = bar:CreateFontString(name .. "Memory")
	memoryText:SetFontObject("GameFontHighlightLarge")
	memoryText:SetPoint("LEFT", fpsText, "RIGHT", 2, 0)

	local latencyText = bar:CreateFontString(name .. "Latency")
	latencyText:SetFontObject("GameFontHighlightLarge")
	latencyText:SetPoint("LEFT", memoryText, "RIGHT", 2, 0)
end

BProfile.AddStartup(function()
	if not BStatsSets then
		BStatsSets = {
			vis = 1,
			showMemory = 1,
			showLatency = 1,
			showFPS = 1,
		}
	end

	local bar = BBar.Create("stats", "BongosStats", "BStatsSets", ShowMenu, nil, nil, OnCreate)
	bar:SetWidth(120); bar:SetHeight(20)
	bar.toNextUpdate = 0
	bar:SetScript("OnUpdate", OnUpdate)

	if not bar:IsUserPlaced() then
		bar:SetPoint("CENTER", UIParent)
	end
end)