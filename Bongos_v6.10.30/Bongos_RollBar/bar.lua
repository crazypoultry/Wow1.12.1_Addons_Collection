--[[
	BRollBar
		A movable frame for rolling on items
--]]

local function RollFrame_OnShow()
	local texture, name, count, quality, bindOnPickUp = GetLootRollItemInfo(this.rollID)

	if bindOnPickUp then
		this:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 } } )
		getglobal(this:GetName().."Corner"):SetTexture("Interface\\DialogFrame\\UI-DialogBox-Gold-Corner")
		getglobal(this:GetName().."Decoration"):Show()
	else
		this:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 } } )
		getglobal(this:GetName().."Corner"):SetTexture("Interface\\DialogFrame\\UI-DialogBox-Corner")
		getglobal(this:GetName().."Decoration"):Hide()
	end

	getglobal("BRollBarFrame"..this:GetID().."IconFrameIcon"):SetTexture(texture)
	getglobal("BRollBarFrame"..this:GetID().."Name"):SetText(name)

	local color = ITEM_QUALITY_COLORS[quality]
	getglobal("BRollBarFrame"..this:GetID().."Name"):SetVertexColor(color.r, color.g, color.b)
end

local function RollFrame_OpenNewFrame(id, rollTime)
	for i=1, NUM_GROUP_LOOT_FRAMES do
		local frame = getglobal("BRollBarFrame"..i)
		if not frame:IsVisible() then
			frame.rollID = id
			frame.rollTime = rollTime
			getglobal("BRollBarFrame"..i.."Timer"):SetMinMaxValues(0, rollTime)
			frame:Show()
			return
		end
	end
end

--[[ Config Functions ]]--

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu")
	menu:SetWidth(220)
	menu:SetHeight(120)
	menu:SetText("Roll Bar")

	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider")
	scaleSlider:SetPoint("TOPLEFT", menu, "TOPLEFT", 10, -42)

	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider")
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24)
end

local function ShowMenu(bar)
	if not BongosRollBarMenu then
		CreateConfigMenu("BongosRollBarMenu")
		BongosRollBarMenu.frame = bar
	end

	BongosRollBarMenu.onShow = 1

	BongosRollBarMenuScale:SetValue(bar:GetScale() * 100)
	BongosRollBarMenuOpacity:SetValue(bar:GetAlpha() * 100)

	BMenu.ShowForBar(BongosRollBarMenu, bar)
	BongosRollBarMenu.onShow = nil
end

--[[ Startup ]]--

local function OnCreate(bar)
	for i=1, NUM_GROUP_LOOT_FRAMES do
		getglobal("GroupLootFrame"..i):UnregisterAllEvents()
	end
	GroupLootFrame_OpenNewFrame = RollFrame_OpenNewFrame

	local rollFrame1 = CreateFrame("Frame", "BRollBarFrame1", bar, "GroupLootFrameTemplate")
	rollFrame1:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", 4, 2)
	rollFrame1:SetScript("OnShow", RollFrame_OnShow)
	rollFrame1:SetID(1)

	for i=2, NUM_GROUP_LOOT_FRAMES do
		local rollFrame = CreateFrame("Frame", "BRollBarFrame" .. i, bar, "GroupLootFrameTemplate")
		rollFrame:SetPoint("BOTTOM", "BRollBarFrame" .. (i-1), "TOP", 0, 3)
		rollFrame:SetScript("OnShow", RollFrame_OnShow)
		rollFrame:SetID(i)
	end
end

BProfile.AddStartup(function()
	local bar = BBar.Create("roll", "BRollBar", "BRollBarSets", ShowMenu, 1, nil, OnCreate)
	bar:SetWidth(340); bar:SetHeight(472)

	if not bar:IsUserPlaced() then
		bar:SetPoint("LEFT", UIParent)
	end
end)