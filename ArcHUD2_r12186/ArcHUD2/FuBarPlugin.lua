--
-- ArcHUDFu -- a FuBar button interface to ArcHUD
--

-- Only load if ArcHUD is already loaded
if not ArcHUD then return end

local dewdrop = AceLibrary("Dewdrop-2.0")

ArcHUDFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
ArcHUDFu:RegisterDB("ArcHUDDB")
ArcHUDFu.hasIcon = "Interface\\Icons\\Ability_Hunter_Pathfinding"
ArcHUDFu.cannotDetachTooltip = true
ArcHUDFu.independentProfile = true
ArcHUDFu.hideWithoutStandby = true

function ArcHUDFu:OnMenuRequest(level, value, x, valueN_1, valueN_2, valueN_3, valueN_4)
	ArcHUD.createDDMenu(level, value, true)
	if(level == 1) then
		dewdrop:AddLine()
	end
end
