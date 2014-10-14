--[[
	Paging.lua
		Scripts for the Paging panel of the Bongos Options menu
--]]

local ROWS = 7
local COLS = 3
local frameName

local function sortList(bar1, bar2)
	if tonumber(bar1.id) and tonumber(bar2.id) then
		return bar1.id < bar2.id
	elseif not(tonumber(bar1.id) or tonumber(bar2.id)) then
		return bar1.id < bar2.id
	elseif tonumber(bar1.id) then
		return false
	end
	return true
end

function BOptionsPaging_OnMousewheel(scrollframe, direction)
	local scrollbar = getglobal(scrollframe:GetName() .. "ScrollBar")
	scrollbar:SetValue(scrollbar:GetValue() - direction * (scrollbar:GetHeight() / 2))
	BOptionsPagingScrollBar_Update()
end

function BOptionsPaging_OnLoad()
	frameName = this:GetName()

	local allButton = CreateFrame("CheckButton", frameName .. "All", this, "BOptionsPagingButton")
	allButton:SetPoint("TOPLEFT", this, "TOPLEFT", 4, 4)
	allButton:SetText(BONGOS_OPTIONS_ALL)
	allButton:SetScript("OnClick", function()
		for i = 1, BActionBar.GetNumber() do
			BActionBar.SetPaging(i, this:GetChecked())
		end
		BOptionsPagingScrollBar_Update()
	end)

	local firstOfRow
	for i = 1, ROWS do
		local button = CreateFrame("CheckButton", frameName .. (i-1)*COLS + 1, this, "BOptionsPagingButton")
		if not firstOfRow then
			button:SetPoint("TOPLEFT", allButton, "BOTTOMLEFT")
		else
			button:SetPoint("TOPLEFT", firstOfRow, "BOTTOMLEFT")
		end
		firstOfRow = button
		for j = 2, COLS do
			local button = CreateFrame("CheckButton", frameName .. (i-1)*COLS + j, this, "BOptionsPagingButton")
			button:SetPoint("LEFT", frameName .. (i-1)*COLS + j-1, "RIGHT", 34, 0)
		end
	end
end

function BOptionsPaging_OnShow()
	this.onShow = 1

	getglobal(frameName .. "Skip"):SetMinMaxValues(0, BActionBar.GetNumber() - 1)
	getglobal(frameName .. "SkipHigh"):SetText(BActionBar.GetNumber() - 1)
	getglobal(frameName .. "Skip"):SetValue(BActionSets.g.skip or 0)

	BOptionsPagingScrollBar_Update()

	this.onShow = nil
end

function BOptionsPagingScrollBar_Update()
	local numButtons = ROWS*COLS
	local size = BActionBar.GetNumber()
	local offset = getglobal(frameName .. 'ScrollFrame').offset

	FauxScrollFrame_Update(getglobal(frameName .. 'ScrollFrame'), size, ROWS*COLS, COLS)

	for index = 1, numButtons do
		local rIndex = index + offset
		local button = getglobal(frameName .. index)

		if rIndex <= size then
			button:SetText(rIndex)
			button:SetChecked(BActionBar.CanPage(rIndex))
			button:Show()
		else
			button:Hide()
		end
	end
end