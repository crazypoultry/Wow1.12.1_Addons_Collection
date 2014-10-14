--[[
	actionBarGlobal.lua
		This panel does things like enabling altcast, toggling range coloring, etc
--]]

local frameName

--[[ Panel ]]--

function BOptionsActionBarGlobal_OnLoad()
	frameName = this:GetName()
end

function BOptionsActionBarGlobal_OnShow()
	this.onShow = 1

	getglobal(frameName .. "LockButtons"):SetChecked(BActionSets_ButtonsLocked())
	getglobal(frameName .. "ShowGrid"):SetChecked(BActionSets_ShowGrid())

	getglobal(frameName .. "Tooltips"):SetChecked(BActionSets_TooltipsShown())
	getglobal(frameName .. "Range"):SetChecked(BActionSets_ColorOutOfRange())
	getglobal(frameName .. "MacroText"):SetChecked(not BActionSets_MacrosShown())
	getglobal(frameName .. "HotkeysText"):SetChecked(not BActionSets_HotkeysShown())

	local r, g, b = BActionSets_GetRangeColor()
	getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(r, g, b)

	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "QuickMove"), BActionSets_GetQuickMoveMode())

	getglobal(frameName .. "NumActionBars"):SetValue(BActionBar:GetNumber())
	this.onShow = nil
end

--[[ Quick Move Dropdown ]]--

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

function BOptionsQuickMove_OnShow()
	UIDropDownMenu_Initialize(this, BOptionsQuickMove_Initialize)
	UIDropDownMenu_SetWidth(72, this)
end

local function QuickMove_OnClick()
	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "QuickMove"), this.value)
	BActionSets_SetQuickMoveMode(this.value)
end

function BOptionsQuickMove_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(getglobal(frameName .. "QuickMove"))

	AddDropdownButton("None", nil, selectedValue, QuickMove_OnClick)
	AddDropdownButton("Shift", 1, selectedValue, QuickMove_OnClick)
	AddDropdownButton("Control", 2, selectedValue, QuickMove_OnClick)
	AddDropdownButton("Alt", 3, selectedValue, QuickMove_OnClick)
end

--[[ Out of Range Coloring Functions ]]--

--set the background of the frame between opaque/transparent
function BOptionsRangeColor_OnClick()
	if ColorPickerFrame:IsShown() then
		ColorPickerFrame:Hide()
	else
		local red, green, blue = BActionSets_GetRangeColor()

		ColorPickerFrame.func = BOptionsRangeColor_ColorChange
		ColorPickerFrame.cancelFunc = BOptionsRangeColor_CancelChanges

		getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(red, green, blue)
		ColorPickerFrame:SetColorRGB(red, green, blue)
		ColorPickerFrame.previousValues = {r = red, g = green, b = blue}

		ShowUIPanel(ColorPickerFrame)
	end
end

function BOptionsRangeColor_ColorChange()
	local r, g, b = ColorPickerFrame:GetColorRGB()

	BActionSets_SetRangeColor(r, g, b)

	getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(r, g, b)
end

function BOptionsRangeColor_CancelChanges()
	local prevValues = ColorPickerFrame.previousValues

	BActionSets_SetRangeColor(prevValues.r, prevValues.g, prevValues.b)

	getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(prevValues.r, prevValues.g, prevValues.b)
end