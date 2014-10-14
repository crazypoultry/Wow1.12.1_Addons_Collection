--[[
	ui.lua
		A UI for Ludwig
--]]

LWUI_SHOWN = 14
LWUI_STEP = LWUI_SHOWN

local DEFAULT_FILTER = "any"
local ITEM_SIZE = 24
local displayList, displayChanged --all things to display on the list
local filter = {}

--[[
	OnX Functions
--]]

function LudwigUI_OnLoad()
	local frameName = this:GetName()
	
	local offset = -6
	local item = CreateFrame("Button", frameName .. "Item1", this, "LudwigItem")
	item:SetPoint("TOPLEFT", frameName .. "Search", "BOTTOMLEFT", 2, offset)
	item:SetPoint("BOTTOMRIGHT", frameName .. "ScrollFrame", "TOPLEFT", -2, offset - ITEM_SIZE)
	item:SetID(1)
	
	offset = -2
	for i = 2, LWUI_SHOWN do
		item = CreateFrame("Button", frameName .. "Item" .. i, this, "LudwigItem")
		item:SetPoint("TOPLEFT", frameName .. "Item" .. i-1, "BOTTOMLEFT", 0, offset)
		item:SetPoint("BOTTOMRIGHT", frameName .. "Item" .. i-1, "BOTTOMRIGHT", 0, offset - ITEM_SIZE)
		item:SetID(2)
	end
	this:SetHeight(72 + ((-offset) + ITEM_SIZE)*LWUI_SHOWN)
	this:GetParent():SetHeight(72 + ((-offset) + ITEM_SIZE)*LWUI_SHOWN)
end

function LudwigUI_OnShow()
	displayChanged = true
	Ludwig_Reload()
end

function LudwigUI_OnHide()
	displayList = nil
	collectgarbage()
end

function LudwigUIFilter_OnLoad()
	if BagnonDB and BagnonDB.GetPlayers then
		this:SetHeight(this:GetHeight() + 36)

		local dropDown = CreateFrame("Frame", "LudwigUIFilterPlayer", this, "LudwigDropDown")
		dropDown:SetScript("OnShow", function() LudwigUI_Player_OnShow() end)
		dropDown:SetPoint("TOPLEFT", this:GetName() .. "LevelRange", "BOTTOMLEFT", -16, -6)
		
		getglobal(this:GetName() .. "Quality"):SetPoint("TOPLEFT", dropDown, "BOTTOMLEFT", 0, -6)
	end
end

function LudwigUIFilter_OnShow()
	this:GetParent():SetWidth(this:GetParent():GetWidth() + this:GetWidth())
	LudwigUIFilterToggle:LockHighlight()
end

function LudwigUIFilter_OnHide()
	this:GetParent():SetWidth(this:GetParent():GetWidth() - this:GetWidth())
	LudwigUIFilterToggle:UnlockHighlight()
end

function LudwigUIText_OnTextChanged()
	filter.name = this:GetText()
	displayChanged = 1
	LudwigUIScrollBar_Update()
end

function LudwigUI_SetMinLevel(level)
	filter.minLevel = level
	displayChanged = 1
	LudwigUIScrollBar_Update()
end

function LudwigUI_SetMaxLevel(level)
	filter.maxLevel = level
	displayChanged = 1
	LudwigUIScrollBar_Update()
end

function LudwigUI_OnMousewheel(scrollframe, direction)
	local scrollbar = getglobal(scrollframe:GetName() .. "ScrollBar")
	scrollbar:SetValue(scrollbar:GetValue() - direction * (scrollbar:GetHeight() / 2))
	LudwigUIScrollBar_Update()
end

function LudwigUIItem_OnEnter()
	GameTooltip:SetOwner(this)
	GameTooltip:SetHyperlink(Ludwig_GetLink(this:GetID()))
	GameTooltip:ClearAllPoints()
--[[
	local _, link, _, iLevel = select(2, GetItemInfo(this:GetID())
	GameTooltip:AddLine('Item Level: ' .. iLevel)
--]]
	if this:GetLeft() < (UIParent:GetRight() / 2) then
		if this:GetTop() < (UIParent:GetTop() / 3) then
			GameTooltip:SetPoint("BOTTOMLEFT", this, "BOTTOMRIGHT", -4, -3)
		else
			GameTooltip:SetPoint("TOPLEFT", this, "TOPRIGHT", -4, 3)
		end
	else
		if this:GetTop() < (UIParent:GetTop() / 3) then
			GameTooltip:SetPoint("BOTTOMRIGHT", this, "BOTTOMLEFT", -4, -3)
		else
			GameTooltip:SetPoint("TOPRIGHT", this, "TOPLEFT", -4, 3)
		end
	end
	
	GameTooltip:Show()
end

function LudwigUI_Load()
	if LudwigUIFilterPlayer then
		UIDropDownMenu_Initialize(LudwigUIFilterPlayer, LudwigUI_Player_Initialize)
	end
	UIDropDownMenu_Initialize(LudwigUIFilterQuality, LudwigUI_Quality_Initialize)
	UIDropDownMenu_Initialize(LudwigUIFilterType, LudwigUI_Type_Initialize)
	UIDropDownMenu_Initialize(LudwigUIFilterSubType, LudwigUI_SubType_Initialize)
	UIDropDownMenu_Initialize(LudwigUIFilterEquipSlot, LudwigUI_EquipSlot_Initialize)
end

--[[
	Scrollbar Functions
--]]

function LudwigUIScrollBar_Update()
	--update list only if there are changes
	if not displayList or displayChanged then
		displayChanged = nil
		displayList = Ludwig_GetItems(filter.name, filter.quality, filter.type, filter.subType, filter.loc, filter.minLevel, filter.maxLevel, filter.player)
	end
	
	local size = table.getn(displayList)
	LudwigUITitle:SetText(format(LUDWIG_TITLE, size))
	FauxScrollFrame_Update(LudwigUIScrollFrame, size, LWUI_SHOWN, LWUI_STEP)
	
	local offset = LudwigUIScrollFrame.offset
	for index = 1, LWUI_SHOWN, 1 do
		local rIndex = index + offset
		local lwb = getglobal("LudwigUIItem".. index)

		if rIndex < size + 1 then
			local id = displayList[rIndex]
			lwb:SetText(Ludwig_GetName(id, true))
			lwb:SetID(id)
			getglobal(lwb:GetName() ..  "Texture"):SetTexture(Ludwig_GetTexture(id))
			lwb:Show()
		else
			lwb:Hide()
		end
	end
end

--[[ 
	Dropdown Menus 
--]]

function LudwigUI_Refresh()
	Ludwig_Reload()
	displayChanged = 1
	LudwigUIScrollBar_Update()
end

--Filter reset
function LudwigUI_ResetFilters()
	for i in pairs(filter) do
		filter[i] = nil
	end
	
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterQuality, DEFAULT_FILTER)
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterType, DEFAULT_FILTER)
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterSubType, DEFAULT_FILTER)
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterEquipSlot, DEFAULT_FILTER)
	
	UIDropDownMenu_Initialize(LudwigUIFilterQuality, LudwigUI_Quality_Initialize)
	UIDropDownMenu_Initialize(LudwigUIFilterType, LudwigUI_Type_Initialize)
	UIDropDownMenu_Initialize(LudwigUIFilterSubType, LudwigUI_SubType_Initialize)
	UIDropDownMenu_Initialize(LudwigUIFilterEquipSlot, LudwigUI_EquipSlot_Initialize)
	
	if LudwigUIFilterPlayer then
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterPlayer, DEFAULT_FILTER)
		UIDropDownMenu_Initialize(LudwigUIFilterPlayer, LudwigUI_Player_Initialize)
	end
	
	displayChanged = 1
	LudwigUIScrollBar_Update()
end

local function AddItem(text, action, value, selectedValue)
	local info = {}
	info.text = text
	info.func = action
	info.value = value
	if value == selectedValue then
		info.checked = 1
	end
	UIDropDownMenu_AddButton(info)
end

--[[ Quality ]]--

function LudwigUI_Quality_OnShow()
	UIDropDownMenu_Initialize(this, LudwigUI_Quality_Initialize)
	UIDropDownMenu_SetWidth(88, this)
end

function LudwigUI_Quality_OnClick()
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterQuality, this.value)
	
	if this.value == DEFAULT_FILTER then
		filter.quality = nil
	else
		filter.quality = this.value
	end
	
	displayChanged = 1
	LudwigUIScrollBar_Update()
end

--add all buttons to the dropdown menu
function LudwigUI_Quality_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(LudwigUIFilterQuality) or DEFAULT_FILTER
	
	AddItem(LUDWIG_FILTER_ANY, LudwigUI_Quality_OnClick, DEFAULT_FILTER, selectedValue)
	for i = 6, 0, -1 do
		local _,_,_,hex = GetItemQualityColor(i)
		AddItem(hex .. getglobal("ITEM_QUALITY" .. i .. "_DESC") .. "|r", LudwigUI_Quality_OnClick, i, selectedValue)
	end
	
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterQuality, selectedValue)
end

--[[ Type ]]--

function LudwigUI_Type_OnShow()
	UIDropDownMenu_Initialize(this, LudwigUI_Type_Initialize)
	UIDropDownMenu_SetWidth(128, this)
end

function LudwigUI_Type_OnClick()
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterType, this.value)
	
	--category change, so reset subtype
	filter.subType = nil
	if this.value == DEFAULT_FILTER then
		filter.type = nil
	else
		filter.type = LudwigUI_GetType(this.value)
	end	
	
	if not filter.subType then
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterSubType, DEFAULT_FILTER)
		UIDropDownMenu_Initialize(LudwigUIFilterSubType, LudwigUI_SubType_Initialize)
	end
	if not filter.type then
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterEquipSlot, DEFAULT_FILTER)
		UIDropDownMenu_Initialize(LudwigUIFilterEquipSlot, LudwigUI_EquipSlot_Initialize)
	end	
	displayChanged = true
	
	LudwigUIScrollBar_Update()
end

function LudwigUI_Type_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(LudwigUIFilterType) or DEFAULT_FILTER
	
	AddItem(LUDWIG_FILTER_ANY, LudwigUI_Type_OnClick, DEFAULT_FILTER, selectedValue)
	for i, text in pairs({GetAuctionItemClasses()}) do
		AddItem(text, LudwigUI_Type_OnClick, i, selectedValue)
	end

	UIDropDownMenu_SetSelectedValue(LudwigUIFilterType, selectedValue)
end

--[[ Subtype ]]--

function LudwigUI_SubType_OnShow()
	UIDropDownMenu_Initialize(this, LudwigUI_SubType_Initialize)
	UIDropDownMenu_SetWidth(128, this)
end

function LudwigUI_SubType_OnClick()
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterSubType, this.value)
	
	filter.loc = nil
	if this.value == DEFAULT_FILTER then
		filter.subType = nil
	else
		filter.subType = LudwigUI_GetSubType(this.value)
	end
	if not filter.loc then
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterEquipSlot, DEFAULT_FILTER)
		UIDropDownMenu_Initialize(LudwigUIFilterEquipSlot, LudwigUI_EquipSlot_Initialize)
	end
	
	displayChanged = true
	LudwigUIScrollBar_Update()
end

function LudwigUI_SubType_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(LudwigUIFilterSubType) or DEFAULT_FILTER
	
	AddItem(LUDWIG_FILTER_ANY, LudwigUI_SubType_OnClick, DEFAULT_FILTER, selectedValue)
	local iType = UIDropDownMenu_GetSelectedValue(LudwigUIFilterType)
	if tonumber(iType) then
		for i, text in pairs({GetAuctionItemSubClasses(iType)}) do	
			AddItem(text, LudwigUI_SubType_OnClick, i, selectedValue)
		end
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterSubType, selectedValue)
	else
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterSubType, DEFAULT_FILTER)
	end
end

--[[ Equip Slot ]]--

function LudwigUI_EquipSlot_OnShow()
	UIDropDownMenu_Initialize(this, LudwigUI_EquipSlot_Initialize)
	UIDropDownMenu_SetWidth(128, this)
end

function LudwigUI_EquipSlot_OnClick()
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterEquipSlot, this.value)
	
	if this.value == DEFAULT_FILTER then
		filter.loc = nil
	else
		filter.loc = LudwigUI_GetEquipSlot(this.value)
	end
	
	displayChanged = true
	LudwigUIScrollBar_Update()
end

function LudwigUI_EquipSlot_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(LudwigUIFilterEquipSlot) or DEFAULT_FILTER
	
	AddItem(LUDWIG_FILTER_ANY, LudwigUI_EquipSlot_OnClick, DEFAULT_FILTER, selectedValue)
	local iType = tonumber(UIDropDownMenu_GetSelectedValue(LudwigUIFilterType))
	local sType = tonumber(UIDropDownMenu_GetSelectedValue(LudwigUIFilterSubType))
	if iType and sType then
		for i, text in pairs({GetAuctionInvTypes(iType, sType)}) do	
			AddItem(getglobal(text), LudwigUI_EquipSlot_OnClick, i, selectedValue)
		end
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterEquipSlot, selectedValue)
	else
		UIDropDownMenu_SetSelectedValue(LudwigUIFilterEquipSlot, DEFAULT_FILTER)
	end
end

--[[ Player ]]--

function LudwigUI_Player_OnShow()
	UIDropDownMenu_Initialize(this, LudwigUI_Player_Initialize)
	UIDropDownMenu_SetWidth(126, this)
end

function LudwigUI_Player_OnClick()
	UIDropDownMenu_SetSelectedValue(LudwigUIFilterPlayer, this.value)
	
	if this.value == DEFAULT_FILTER then
		filter.player = nil
	else
		filter.player = this.value
	end	
	
	displayChanged = true
	LudwigUIScrollBar_Update()
end

function LudwigUI_Player_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(LudwigUIFilterPlayer) or DEFAULT_FILTER
	
	AddItem(LUDWIG_FILTER_ANY, LudwigUI_Player_OnClick, DEFAULT_FILTER, selectedValue)
	for player in BagnonDB.GetPlayers() do
		AddItem(player, LudwigUI_Player_OnClick, player, selectedValue)
	end

	UIDropDownMenu_SetSelectedValue(LudwigUIFilterPlayer, selectedValue)
end

--[[ Utility Functions ]]--

function LudwigUI_GetSubType(index)
	local iType = tonumber(UIDropDownMenu_GetSelectedValue(LudwigUIFilterType))
	if iType then
		local list = {GetAuctionItemSubClasses(iType)}
		return list[index]
	end
end

function LudwigUI_GetType(index)
	local list = {GetAuctionItemClasses()}
	return list[index]
end

function LudwigUI_GetEquipSlot(index)
	local iType = tonumber(UIDropDownMenu_GetSelectedValue(LudwigUIFilterType))
	if iType then
		local sType = tonumber(UIDropDownMenu_GetSelectedValue(LudwigUIFilterSubType))
		if sType then
			local list = {GetAuctionInvTypes(iType, sType)}
			return list[index]
		end
	end
end