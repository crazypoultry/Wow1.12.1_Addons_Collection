--[[
	actionBarGlobal.lua
		This panel does things like enabling altcast, toggling range coloring, etc
--]]

local frameName

--[[ Panel ]]--

function BOptionsSelfCast_OnLoad()
	frameName = this:GetName()
end

function BOptionsSelfCast_OnShow()
	this.onShow = 1

	getglobal(frameName .. "RightClickSelfCast"):SetChecked(BActionSets_RightClickSelfCasts())
	getglobal(frameName .. "SelfCast"):SetChecked(GetCVar("autoSelfCast"))

	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "AltCast"), BActionSets_GetSelfCastMode())

	this.onShow = nil
end

--[[  Altcast Key Dropdown ]]--

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

function BOptionsAltCast_OnShow()
	UIDropDownMenu_Initialize(this, BOptionsAltCast_Initialize)
	UIDropDownMenu_SetWidth(72, this)
end

local function AltCast_OnClick()
	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "AltCast"), this.value)
	BActionSets_SetSelfCastMode(this.value)
end

--add all buttons to the dropdown menu
function BOptionsAltCast_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(getglobal(frameName .. "AltCast"))

	AddDropdownButton("None", nil, selectedValue, AltCast_OnClick)
	AddDropdownButton("Alt", 1, selectedValue, AltCast_OnClick)
	AddDropdownButton("Control", 2, selectedValue, AltCast_OnClick)
	AddDropdownButton("Shift", 3, selectedValue, AltCast_OnClick)
end