--[[  ]]
local zBarOptionCheckButtons = {
	{name=ZBAR_ATTR_HIDE,var="hide",tooltip=ZBAR_TIP_HIDE},
	{name=ZBAR_ATTR_NAME,var="name",tooltip=ZBAR_TIP_NAME},
	{name=ZBAR_ATTR_LOCK,var="hideTab",tooltip=ZBAR_TIP_LOCK},
	{name=ZBAR_ATTR_AUTOALPHA,var="autoAlpha",tooltip=ZBAR_TIP_AOTUALPHA},
	{name=ZBAR_ATTR_FUNNY1,var="arrangement",value="funny1",tooltip=ZBAR_TIP_FUNNY1},
	{name=ZBAR_ATTR_FUNNY2,var="arrangement",value="funny2",tooltip=ZBAR_TIP_FUNNY2},
	{name=ZBAR_ATTR_AOTUPOP,var="autoPop",tooltip=ZBAR_TIP_AOTUPOP},
	{name=ZBAR_ATTR_AOTUHIDE,var="autoHide",tooltip=ZBAR_TIP_AOTUHIDE},
	{name=ZBAR_ATTR_HOTKEY,var="hideHotkey",tooltip=ZBAR_TIP_HOTKEY},
	{name=ZBAR_ATTR_LOCKBUTTON,tooltip=ZBAR_TIP_LOCKBUTTON},
	{name=ZBAR_ATTR_HIDEGRID,tooltip=ZBAR_TIP_HIDEGRID},
}

local zBarOptionSliders = {
	{name=ZBAR_SLIDER_NUM,var="num",min=1,max=12,step=1,setFunc=nil,tooltip=ZBAR_TIP_NUM},
	{name=ZBAR_SLIDER_NUMPERLINE,var="linenum",min=1,max=12,step=1,setFunc=nil,tooltip=ZBAR_TIP_NUMPERLINE},
	{name=ZBAR_SLIDER_SCALE,var="scale",min=0.5,max=1.5,step=0.001,factor=100,setFunc=nil,tooltip=ZBAR_TIP_SCALE},
	{name=ZBAR_SLIDER_INSECT,var="inset",min=0,max=20,step=2,setFunc=nil,tooltip=ZBAR_TIP_INSECT},
}

--[[ Register Slash Command ]]--
SlashCmdList["ZBAR"] = function(msg)
    zBarOption:OpenForBar(zBar1)
end
SLASH_ZBAR1 = "/zbar"

local tmp
--[[
    CheckButton OnClick functions
--]]
-- show / hide bar
zBarOptionCheckButtons[1].onChecked = function()
    zBarOption.bar:Hide()
end
zBarOptionCheckButtons[1].unChecked = function()
	zBarOption.bar:Show()
    if zBarOption.bar:GetID() == 15 then return end
	zBar_UpdateButtons(zBarOption.bar)
	zBar_UpdateArrangement(zBarOption.bar)
end
-- show / hide name
zBarOptionCheckButtons[2].onChecked = function()
    getglobal(zBarOption.bar:GetName().."Tab"):Show()
    getglobal(zBarOption.bar:GetName().."Tab"):SetText(ZBAR_NAMES[zBarOption.bar:GetID()])
end
zBarOptionCheckButtons[2].unChecked = function()
    if (zBarOptionAttr3:GetChecked()) then
        getglobal(zBarOption.bar:GetName().."Tab"):Hide()
    end
    getglobal(zBarOption.bar:GetName().."Tab"):SetText("")
end
-- lock / unlock bar, show / hide tab
zBarOptionCheckButtons[3].onChecked = function()
    getglobal(zBarOption.bar:GetName().."Tab"):Hide()
end
zBarOptionCheckButtons[3].unChecked = function()
    getglobal(zBarOption.bar:GetName().."Tab"):Show()
end
-- set auto alpha mode
zBarOptionCheckButtons[4].onChecked = function()
    zBar_SetAlpha(0.3, zBarOption.bar)
end
zBarOptionCheckButtons[4].unChecked = function()
    zBarOption.bar:SetAlpha(1)
    getglobal(zBarOption.bar:GetName().."Tab"):SetAlpha(0.5)
end
-- funny arrangement 1
zBarOptionCheckButtons[5].onChecked = function()
    zBarOptionAttr6:SetChecked(false)
    zBar_UpdateArrangement(zBarOption.bar)
    zBar.Bars[zBarOption.bar:GetID()].linenum = nil
    zBarOptionSlider2Thumb:Hide()
end
zBarOptionCheckButtons[5].unChecked = function()
    zBarOptionSlider2:SetValue(2)
    zBarOptionSlider2:SetValue(1)
end
-- funny arrangement 2
zBarOptionCheckButtons[6].onChecked = function()
    zBarOptionAttr5:SetChecked(false)
    zBar_UpdateArrangement(zBarOption.bar)
    zBar.Bars[zBarOption.bar:GetID()].linenum = nil
    zBarOptionSlider2Thumb:Hide()
end
zBarOptionCheckButtons[6].unChecked = function()
    zBarOptionSlider2:SetValue(2)
    zBarOptionSlider2:SetValue(1)
end
-- set auto pop up mode
zBarOptionCheckButtons[7].onChecked = function()
    zBarOptionAttr8:SetChecked(false)
    zBar.Bars[zBarOption.bar:GetID()][zBarOptionCheckButtons[8].var] = nil
    zBar_UpdateMinimize(zBarOption.bar)
end
zBarOptionCheckButtons[7].unChecked = function()
    zBar_UpdateMinimize(zBarOption.bar,true)
end
-- set auto hide mode
zBarOptionCheckButtons[8].onChecked = function()
    zBarOptionAttr7:SetChecked(false)
    zBar.Bars[zBarOption.bar:GetID()][zBarOptionCheckButtons[7].var] = nil
    zBar_UpdateMinimize(zBarOption.bar,true)
end
zBarOptionCheckButtons[8].unChecked = function()
    zBar_UpdateMinimize(zBarOption.bar,true)
end
-- show / hide hotkeys
zBarOptionCheckButtons[9].onChecked = function()
    zBar_UpdateHotkeys(zBarOption.bar)
end
zBarOptionCheckButtons[9].unChecked = function()
    zBar_UpdateHotkeys(zBarOption.bar)
end
--[[
	Slider ValueChanged functions
--]]
-- set num of buttons
zBarOptionSliders[1].setFunc = function()
    zBar.Bars[zBarOption.bar:GetID()].num = this:GetValue()
    zBar_UpdateButtons(zBarOption.bar)
    zBar_UpdateArrangement(zBarOption.bar)
end
-- set num per line
zBarOptionSliders[2].setFunc = function()
    zBarOptionAttr5:SetChecked(false)
    zBarOptionAttr6:SetChecked(false)
    zBarOptionSlider2Thumb:Show()

    
    tmp = zBarOption.bar:GetID()
    value = zBar.Bars[tmp]
    
    -- linenum can't greater than num
	local num = this:GetValue()
    if num > value.num then
        this:SetValue(value.num)
        return
    end
	
	zBar.Bars[tmp].arrangement = "line"
    zBar.Bars[tmp].linenum = this:GetValue()
    zBar_UpdateArrangement(zBarOption.bar)
end
-- set scale
zBarOptionSliders[3].setFunc = function()
    zBar.Bars[zBarOption.bar:GetID()].scale = this:GetValue()
    zBarOption.bar:SetScale(this:GetValue())
    -- set edit box text
	tmp = getglobal(this:GetName().."EditBox")
	tmp:SetText(floor(100 * this:GetValue()))
	tmp:HighlightText()
end
-- set button spacing
zBarOptionSliders[4].setFunc = function()
    zBar.Bars[zBarOption.bar:GetID()].inset = this:GetValue()
    zBar_UpdateArrangement(zBarOption.bar)
end
--[[ Buttons ]]--
function zBarOptionReset_OnClick()
    zBarOption.bar:ClearAllPoints()
    zBarOption.bar:SetPoint("CENTER",UIParent,"CENTER",0,0)
    zBarOptionSlider3:SetValue(1)
    zBar.Bars[zBarOption.bar:GetID()].hide = nil
    zBarOption.bar:Show()
end
--[[
	Select bar, Open Option Frame
--]]
local function zBarOption_OpenForBar(self,bar)
	local index = bar:GetID()
	self.bar = getglobal(ZBARS[index])
    
	-- set bar selector button checked
	tmp = getglobal("zBarOptionBar"..index)
	tmp:SetChecked(true)
	tmp:SetTextColor(0.1,1,0.1)
    -- unchecked others
	for i=1,15 do
		tmp = getglobal("zBarOptionBar"..i)
		if i ~= index and tmp:GetChecked() then
			tmp:SetChecked(false)
			tmp:SetTextColor(1,0.82,0)
		end
	end

	-- read the saved variables, init options
    
    -- re enable check buttons and sliders
    for i in zBarOptionCheckButtons do
        getglobal("zBarOptionAttr"..i):Enable()
    end
    for i=1,4 do
        getglobal("zBarOptionSlider"..i):Show()
    end
    
	-- check buttons
	for i,value in zBarOptionCheckButtons do
		tmp = getglobal("zBarOptionAttr"..i)
		if value.var then
			if value.value then
				tmp:SetChecked(zBar.Bars[index][value.var] == value.value)
			else
				tmp:SetChecked(zBar.Bars[index][value.var])
			end
		end
	end
    zBarOptionAttr10:SetChecked(LOCK_ACTIONBAR == "1")
    zBarOptionAttr11:SetChecked(ALWAYS_SHOW_MULTIBARS ~= "1" and ALWAYS_SHOW_MULTIBARS ~= 1)
    
	-- sliders
	zBarOptionSlider3:SetValue(bar:GetScale())
    if index < 15 then
        local t1 = zBar.Bars[index].num
        zBarOptionSlider1:SetMinMaxValues(1, zBar.Bars[index].max or 12)
        zBarOptionSlider1High:SetText(zBar.Bars[index].max or 12)
        if index == 14 then
            -- shapeshift bar num must be correct
            zBarOptionSlider1:SetValue( GetNumShapeshiftForms() )
        else
            zBarOptionSlider1:SetValue(t1 or zBarOptionSliders[1].min)
        end
        local t2 = zBar.Bars[index].linenum
        zBarOptionSlider2:SetMinMaxValues(1, zBar.Bars[index].max or 12)
        zBarOptionSlider2High:SetText(zBar.Bars[index].max or 12)
        if t2 then
            zBarOptionSlider2:SetValue(t2)
        else
            zBarOptionSlider2Thumb:Hide()
        end
        zBarOptionSlider4:SetValue(zBar.Bars[index][zBarOptionSliders[4].var] or zBarOptionSliders[4].min)
    end
    
    -- disables
    if index == 11 or index == 14 then
        -- pet bar and shapeshift bar can't be hidden by user
        zBarOptionAttr1:Disable()
    end
    if index == 13 then
        -- micro bar can't set inset
        zBarOptionSlider4:Hide()
    end
    if index > 10 and index < 15 then
        zBarOptionAttr7:Disable()
        zBarOptionAttr8:Disable()
        zBarOptionAttr9:Disable()
    end
    if index == 15 then
        -- XP bar can only do show / hide
        for i=1,4 do
            getglobal("zBarOptionSlider"..i):Hide()
        end
        for i in zBarOptionCheckButtons do
            if i > 1 then getglobal("zBarOptionAttr"..i):Disable() end
        end
    end
    
	-- show frame
	self:Show()
end
--[[
	Frame OnX
--]]
function zBarOption_OnLoad()
	-- register events
	this:RegisterForDrag("LeftButton")
	this:RegisterEvent("VARIABLES_LOADED")
	-- set backdrop
	this:SetBackdropBorderColor(0.5,0.5,0.5)
	this:SetBackdropColor(0,0,0)
	-- frame functions
	this.OpenForBar = zBarOption_OpenForBar
    -- init function
    zBarOptionSlider3EditBox:SetScript("OnEnterPressed", function()
        zBarOptionSlider3:SetValue(this:GetNumber()*0.01)
    end)
    zBarOptionSlider3EditBox:SetScript("OnEscapePressed", function()
        zBarOption:Hide()
    end)
end

function zBarOption_OnEvent()
	if event=="VARIABLES_LOADED" then
		-- radio buttons
		for i=1,15 do
			tmp = getglobal("zBarOptionBar"..i)
			tmp:SetText(ZBAR_NAMES[i])
			if not ZBARS[i] then tmp:Disable() end
		end
		-- check buttons
		for index,value in zBarOptionCheckButtons do
			tmp = getglobal("zBarOptionAttr"..index)
			tmp:SetText(value.name)
			tmp.tooltipText = value.tooltip
		end
		-- Sliders
		for index,value in zBarOptionSliders do
			tmp = getglobal("zBarOptionSlider"..index.."Text")
			tmp:SetText(value.name)
			tmp = getglobal("zBarOptionSlider"..index)
			tmp:SetMinMaxValues(value.min,value.max)
			tmp:SetValueStep(value.step)
			tmp.tooltipText = value.tooltip
			tmp:SetScript("OnValueChanged", value.setFunc)
			
			if value.factor then
				getglobal("zBarOptionSlider"..index.."Low"):SetText(value.min * value.factor .. "%")
				getglobal("zBarOptionSlider"..index.."High"):SetText(value.max * value.factor .. "%")
			else
				getglobal("zBarOptionSlider"..index.."Low"):SetText(value.min)
				getglobal("zBarOptionSlider"..index.."High"):SetText(value.max)
			end
		end
		zBarOptionSlider3EditBox:SetFocus(true)
				
		this:UnregisterEvent("VARIABLES_LOADED")
	end
end
--[[
	Widget OnX
--]]
-- radio buttons, bar selector
function zBarRadioButton_OnClick()
	PlaySound("igMainMenuOptionCheckBoxOn")
	zBarOption:OpenForBar(getglobal(ZBARS[this:GetID()]))
end
-- check buttons, option setter
function zBarCheckButton_OnClick()
	if this:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOn")
	else
		PlaySound("igMainMenuOptionCheckBoxOff")
	end

    -- save the option value
    value = zBarOptionCheckButtons[this:GetID()]
	if value.var then
        if this:GetChecked() then
            if value.value then
                zBar.Bars[zBarOption.bar:GetID()][value.var] = value.value
            else
                zBar.Bars[zBarOption.bar:GetID()][value.var] = true
            end
            value.onChecked()
        else
            zBar.Bars[zBarOption.bar:GetID()][value.var] = nil
            value.unChecked()
        end
	end
end
function zBarLockButton_OnClick()
    PlayClickSound()
    if this:GetChecked() then
        LOCK_ACTIONBAR = "1"
    else
        LOCK_ACTIONBAR = nil
    end
end
function zBarHideGrid_OnClick()
    PlayClickSound()
    if this:GetChecked() then
        ALWAYS_SHOW_MULTIBARS = nil
    else
        ALWAYS_SHOW_MULTIBARS = "1"
    end
    MultiActionBar_UpdateGridVisibility()
end