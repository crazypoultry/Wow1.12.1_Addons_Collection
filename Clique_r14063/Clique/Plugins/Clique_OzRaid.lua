local Plugin = Clique:NewModule("OzRaid")
Plugin.fullname = "OzRaid"

function Plugin:Test()
return IsAddOnLoaded("OzRaid")
end

function Plugin:OnEnable()
OzRaidCustomClick = self.OnClick
end

function Plugin:OnDisable()
OzRaidCustomClick = nil
end

function Plugin.OnClick(button, unit)
if not Clique:OnClick(button, unit) then
if button == "LeftButton" then 
TargetUnit(unit)
elseif button == "RightButton" then 
Clique:UnitMenu(unit)
end
end
end