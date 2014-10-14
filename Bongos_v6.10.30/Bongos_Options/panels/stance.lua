--[[
	stance.lua
		This panel does things for enablin
--]]

local frameName, selectedButton
local listSize = 14

local function StanceIDToName(stanceID)
	if stanceID then
		local _, class = UnitClass('player')
		if BONGOS_STANCE_LIST[class] then
			return BONGOS_STANCE_LIST[class][stanceID] or 'Unknown'
		else
			return 'Unknown'
		end
	end
end

--[[ Buttons ]]--

function BOptionsStanceButton_OnClick(clickedButton)
	for i = 1, listSize do
		getglobal(frameName .. i):UnlockHighlight()
	end
	clickedButton:LockHighlight()
	selectedButton = clickedButton
end

function BOptionsStance_Save()
	local startBar = tonumber(getglobal(frameName .. "StanceAddBarsMin"):GetText())
	local endBar = tonumber(getglobal(frameName .. "StanceAddBarsMax"):GetText()) or startBar
	local stanceID = UIDropDownMenu_GetSelectedValue(getglobal(frameName .. "StanceAddStance")) or -1
	local offset = tonumber(getglobal(frameName .. "StanceAddOffset"):GetText())

	if not(startBar and endBar and stanceID and offset) then return end

	local barList
	if startBar == endBar then
		barList = startBar
	else
		barList = startBar .. '-' .. endBar
	end
	if stanceID == -1 then
		BContext.Add(barList, offset)
	else
		BStance.Add(barList, stanceID, offset)
	end

	BOptionsStance_UpdateScrollBar()
	getglobal(frameName..'StanceAdd'):Hide()
end

function BOptionsStance_Delete()
	if selectedButton then
		local stanceID = selectedButton.stanceID
		local barList = selectedButton.barList
		if stanceID == -1 then
			BContext.Remove(barList)
		else
			BStance.Remove(barList, stanceID)
		end
		BOptionsStance_UpdateScrollBar()
	end
end

function BOptionsStance_AddNew()
	getglobal(frameName..'StanceAdd'):Show()
end

function BOptionsStanceBarsMin_OnTextChanged()
	if not this:GetParent().onShow then
		local minBar = tonumber(this:GetText()) or 1
		local maxBox = getglobal(this:GetParent():GetName() .. 'Max')
		local maxBar = tonumber(maxBox:GetText()) or 1

		if maxBar <= minBar then
			maxBox:SetText(minBar)
		end
	end
end

function BOptionsStanceBarsMax_OnFocusLost()
	if not this:GetParent().onShow then
		local maxBar = tonumber(this:GetText()) or 1
		local minBar = tonumber(getglobal(this:GetParent():GetName() .. 'Min'):GetText()) or 1

		if maxBar < minBar then
			this:SetText(minBar)
		end
	end
end

function BOptionsStanceBars_OnShow()
	this.onShow = true

	thisName = this:GetName()
	local minBar = tonumber(getglobal(thisName .. 'Min'):GetText()) or 1
	if not minBar or minBar <= 1 then
		getglobal(thisName .. 'Min'):SetText(1)
	end

	local maxBar = tonumber(getglobal(thisName .. 'Max'):GetText())
	if not maxBar or maxBar <= minBar then
		getglobal(thisName .. 'Max'):SetText(minBar)
	end

	this.onShow = nil
end

function BOptionsStanceOffset_OnShow()
	if not tonumber(this:GetText()) then
		this:SetText(0)
	end
end

--[[ Stance Adder Dialog ]]--

--event listing
local function AddDropdownButton(text, value, selectedValue, action)
	local info = {}
	info.text = text
	info.func = action
	info.value = value
	if value == selectedValue then
		info.checked = 1
	end
	UIDropDownMenu_AddButton(info)
end

local function StanceStance_OnClick()
	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "StanceAddStance"), this.value)
end

local function StanceStance_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(getglobal(frameName .. "StanceAddStance"))
	
	local _, class = UnitClass('player')
	local stances = BONGOS_STANCE_LIST[class]
	if stances then
		if not selectedValue then
			selectedValue = 1
		end
		for stanceID, stanceName in pairs(stances) do
			if stanceID ~= 0 then
				AddDropdownButton(stanceName, stanceID, selectedValue, StanceStance_OnClick)
			end
		end
	end
	if not selectedValue then
		selectedValue = -1
	end
	AddDropdownButton(BONGOS_STANCE_FRIENDLY, -1, selectedValue, StanceStance_OnClick)
	
	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "StanceAddStance"), selectedValue)
end

function BOptionsStanceStance_OnShow()
	UIDropDownMenu_Initialize(this, StanceStance_Initialize)
	UIDropDownMenu_SetWidth(108, this)
end

--[[ Panel ]]--

function BOptionsStance_UpdateScrollBar()
	local scrollFrame = getglobal(frameName .. 'ScrollFrame')
	local offset = scrollFrame.offset
	local startIndex = offset
	local i = 0

	if BStanceSets then
		for stanceID, stanceList in pairs(BStanceSets) do
			for barList, amount in pairs(stanceList) do
				i = i + 1
				if i > offset and (i + offset) <= listSize then
					local button = getglobal(frameName .. i - offset)
					button:SetText(format(BONGOS_STANCE_TEXT, StanceIDToName(stanceID), barList, tonumber(amount or 0)))
					button.isContext = nil
					button.barList = barList
					button.stanceID = stanceID
					button:Show()
				end
			end
		end
	end

	if BContextSets then
		for barList, amount in pairs(BContextSets) do
			i = i + 1
			if i > offset and (i + offset) <= listSize then
				local button = getglobal(frameName .. i - offset)
				button:SetText(format(BONGOS_STANCE_TEXT, BONGOS_STANCE_FRIENDLY, barList, tonumber(amount or 0)))
				button.isContext = true
				button.barList = barList
				button.stanceID = -1
				button:Show()
			end
		end
	end

	for j = i+1, listSize do
		getglobal(frameName .. j):Hide()
	end

	FauxScrollFrame_Update(scrollFrame, i, listSize, listSize)
end

function BOptionsStance_OnLoad()
	frameName = this:GetName()
	local size = 19

	local button = CreateFrame("Button", frameName .. 1, this, "BongosOptionsStanceButton")
	button:SetPoint("TOPLEFT", this, "TOPLEFT", 4, -4)
	button:SetPoint("BOTTOMRIGHT", this, "TOPRIGHT", -24, -size)
	button:SetID(1)

	for i = 2, listSize do
		button = CreateFrame("Button", frameName .. i, this, "BongosOptionsStanceButton")
		button:SetPoint("TOPLEFT", frameName .. i-1, "BOTTOMLEFT", 0, -1)
		button:SetPoint("BOTTOMRIGHT", frameName .. i-1, "BOTTOMRIGHT", 0, -size)
		button:SetID(i)
	end
end

function BOptionsStance_OnShow()
	BOptionsStance_UpdateScrollBar()
end

function BOptionsStance_OnMousewheel(scrollframe, direction)
	local scrollbar = getglobal(scrollframe:GetName() .. "ScrollBar")
	scrollbar:SetValue(scrollbar:GetValue() - direction * (scrollbar:GetHeight() / 2))

	BOptionsStance_UpdateScrollBar()
end