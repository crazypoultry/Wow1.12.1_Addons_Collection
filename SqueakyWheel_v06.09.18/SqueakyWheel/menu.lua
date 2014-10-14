SqueakyWheel.CheckArray = {"lock","displaySolo","displayParty","displayRaid","displayEmergency","priority","textClassColor","barClassColor","showAll","displayPets","priorityGroup1","priorityGroup2","priorityGroup3","priorityGroup4","priorityGroup5","priorityGroup6","priorityGroup7","priorityGroup8"}
SqueakyWheel.CheckTipArray = {"Lock the SqueakyWheel Frame","show SqueakyWheel when solo","show SqueakyWheel when in a party","show SqueakyWheel when in a raid","Replace CT_RaidAssist Emergency Monitor with SqueakyWheel","Enable Class Priorities","Use Class Colors for text","Use Class Colors for Bars","Always Show Bars","Display Pets","Group 1 Assignment","Group 2 Assignment","Group 3 Assignment","Group 4 Assignment","Group 5 Assignment","Group 6 Assignment","Group 7 Assignment","Group 8 Assignment"}
SqueakyWheel.CheckTextArray = {"Lock Window","Display Solo","Display in Party","Display in Raid","Emergency Monitor","Enable Priorities","Class Text Colors","Class Bar Colors","Always Show","Display Pets","1","2","3","4","5","6","7","8"}
SqueakyWheel.SliderArray = {"prioritySELF","priorityPARTY","priorityDRUID","priorityHUNTER","priorityMAGE","priorityPALADIN","priorityPRIEST","priorityROGUE","prioritySHAMAN","priorityWARLOCK","priorityWARRIOR","priorityPET","priorityMT","minHealth","healthBars","blacklistDuration","deltaMax","deltaWeight","barHeight","barWidth","barSpacing","priorityMana","priorityRage","priorityEnergy","priorityGroups","priorityAggro"}
SqueakyWheel.SliderMinArray = {0,0,0,0,0,0,0,0,0,0,0,0,0,.5,2,0,1,1,6,10,0,0,0,0,0,0}
SqueakyWheel.SliderMaxArray = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,15,10,30,20,30,300,10,1,1,1,1,100}
SqueakyWheel.SliderTicArray = {.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.05,1,1,1,1,1,1,1,.1,.1,.1,.1,5}
SqueakyWheel.SliderTipArray = { "Additional Priority of You","Additional Priority of Your Party","Additional Priority of Druids","Additional Priority of Hunters","Additional Priority of Mages","Additional Priority of Paladins","Additional Priority of Priests","Additional Priority of Rogues","Additional Priority of Shaman","Additional Priority of Warlocks","Additional Priority of Warriors","Additional Priority of Pets","Additional Priority of CT_RaidAssist Main Tanks and Personal Targets","Minimum Health Threshold","Number of Health Bars to Display","Duration of Blacklist for failed spells","Number of Seconds to track Squeakiness","Importance of one second of Squeakiness","Height of Displayed Health Bars","Width of Displayed Health Bars","Spacing in between Displayed Health Bars","Additional Priority of full Rage","Additional Priority of full Mana","Additional Priority of full Energy","Additional Priority of Assigned Groups","Additional Priority of Aggroing"}
SqueakyWheel.SliderTextArray = { "Self priority","Current Party priority","Druid priority","Hunter priority","Mage priority","Paladin priority","Priest priority","Rogue priority","Shaman priority","Warlock priority","Warrior priority","Pet priority","MT Priority","Health Threshold","Health Bars","Blacklist Duration","Squeak Duration","Squeak Weight","Bar Height","Bar Width","Bar Spacing","Rage priority","Mana priority","Energy priority","Assigned Group Priority","Aggro priority"}
SqueakyWheel.SliderColorArray = {nil,nil,RAID_CLASS_COLORS["DRUID"],RAID_CLASS_COLORS["HUNTER"],RAID_CLASS_COLORS["MAGE"],RAID_CLASS_COLORS["PALADIN"],RAID_CLASS_COLORS["PRIEST"],RAID_CLASS_COLORS["ROGUE"],RAID_CLASS_COLORS["SHAMAN"],RAID_CLASS_COLORS["WARLOCK"],RAID_CLASS_COLORS["WARRIOR"],nil,RAID_CLASS_COLORS["WARRIOR"],nil,nil,nil,nil,nil,nil,nil,nil,ManaBarColor[1],ManaBarColor[0],ManaBarColor[3],nil,nil}

function SqueakyWheel.FrameOnLoad()
  tinsert(UISpecialFrames,"SqueakyMenu")
  PanelTemplates_SetNumTabs(SqueakyMenu, 3)
  SqueakyMenu.selectedTab=1
  PanelTemplates_UpdateTabs(SqueakyMenu)
  SqueakyWheel.ColorGUI()
end

function SqueakyWheel.FrameOnShow()
  SqueakyWheel.TabButtonHandler(getglobal("SqueakyMenuTab"..SqueakyMenu.selectedTab))
end

function SqueakyWheel.ColorGUI()
  getglobal("SqueakySlider3Text"):SetTextColor(RAID_CLASS_COLORS["DRUID"])
  getglobal("SqueakySlider4Text"):SetTextColor(RAID_CLASS_COLORS["HUNTER"])
  getglobal("SqueakySlider5Text"):SetTextColor(RAID_CLASS_COLORS["MAGE"])
  getglobal("SqueakySlider6Text"):SetTextColor(RAID_CLASS_COLORS["PALADIN"])
  getglobal("SqueakySlider7Text"):SetTextColor(RAID_CLASS_COLORS["PRIEST"])
  getglobal("SqueakySlider8Text"):SetTextColor(RAID_CLASS_COLORS["ROGUE"])
  getglobal("SqueakySlider9Text"):SetTextColor(RAID_CLASS_COLORS["SHAMAN"])
  getglobal("SqueakySlider10Text"):SetTextColor(RAID_CLASS_COLORS["WARLOCK"])
  getglobal("SqueakySlider11Text"):SetTextColor(RAID_CLASS_COLORS["WARRIOR"])
end

function SqueakyWheel.TabButtonHandler(tab)
  local id = tab:GetID()
  SqueakyWheel.Debug("TabButtonHandler"..id)
  local title
  for i = 1,3 do 
    title = getglobal("SqueakyTab"..i)
    if title then
      if ""..i == ""..id then
        title:Show()
	getglobal("SqueakyFrameTitleText"):SetText(tab:GetText())
      else
        title:Hide()
      end
    end
  end
end

function SqueakyWheel.SliderOnShow()
  if not SqueakyConfig then this:GetParent():Hide() return end
  local SqueakyVal = SqueakyConfig[SqueakyWheel.SliderArray[this:GetID()]] or 0
  this:SetMinMaxValues(SqueakyWheel.SliderMinArray[this:GetID()],SqueakyWheel.SliderMaxArray[this:GetID()])
  this:SetValueStep(SqueakyWheel.SliderTicArray[this:GetID()])
  this:SetValue(SqueakyVal)
  getglobal(this:GetName().."Text"):SetText(SqueakyWheel.SliderTextArray[this:GetID()]..": "..
                                            string.format("%.1f",SqueakyVal))
  local c = SqueakyWheel.SliderColorArray[this:GetID()]
  if c then
    getglobal(this:GetName().."Text"):SetTextColor(c.r,c.g,c.b)
  end
  getglobal(this:GetName().."Low"):SetText(SqueakyWheel.SliderMinArray[this:GetID()])
  getglobal(this:GetName().."High"):SetText(SqueakyWheel.SliderMaxArray[this:GetID()])
end

function SqueakyWheel.SliderOnValueChanged()
  if not SqueakyConfig then this:GetParent():Hide() return end
  getglobal(this:GetName().."Text"):SetText(SqueakyWheel.SliderTextArray[this:GetID()]..": "..
                      string.format("%.1f",this:GetValue()))
  if SqueakyConfig[SqueakyWheel.SliderArray[this:GetID()]] then
    SqueakyConfig[SqueakyWheel.SliderArray[this:GetID()]] = this:GetValue()
  end
  SqueakyWheel.Clear()
end

function SqueakyWheel.SliderOnEnter()
  if not SqueakyConfig then this:GetParent():Hide() return end
  local msg = SqueakyWheel.SliderTipArray[this:GetID()]
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetBackdropColor(0.0, 0.0, 0.0)
  if msg ~= nil then GameTooltip:SetText(msg, 1.0, 1.0, 1.0) end
end

function SqueakyWheel.CheckOnShow(this)
  if not SqueakyConfig then this:GetParent():Hide() return end
  local SqueakyVal = SqueakyConfig[SqueakyWheel.CheckArray[this:GetID()]]
  if SqueakyVal then
    this:SetChecked(1)
  else
    this:SetChecked(0)
  end
  SqueakyVal = nil
  getglobal(this:GetName().."Text"):SetText(SqueakyWheel.CheckTextArray[this:GetID()])
end

function SqueakyWheel.CheckOnClick()
  if not SqueakyConfig then this:GetParent():Hide() return end
  if this:GetChecked() then
    SqueakyConfig[SqueakyWheel.CheckArray[this:GetID()]] = 1
  else
    SqueakyConfig[SqueakyWheel.CheckArray[this:GetID()]] = nil
  end
  SqueakyWheel.Clear()
end

function SqueakyWheel.CheckOnEnter()
  if not SqueakyConfig then this:GetParent():Hide() return end
  local msg = SqueakyWheel.CheckTipArray[this:GetID()]
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetBackdropColor(0.0, 0.0, 0.0)
  if msg ~= nil then GameTooltip:SetText(msg, 1.0, 1.0, 1.0) end
end