ZHunterMod_Saved = {}

BINDING_HEADER_ZAspectHeader = "ZAspect Buttons"
BINDING_HEADER_ZTrackHeader = "ZTrack Buttons"
BINDING_HEADER_ZTrapHeader = "ZTrap Buttons"
BINDING_HEADER_ZPetHeader = "ZPet Buttons"

ZHunterModTooltip = CreateFrame("GameTooltip", "ZHunterModTooltip", nil, "GameTooltipTemplate")

function ZHunterMod_AlignButtons()
	ZHunterButtonTrack:ClearAllPoints()
	ZHunterButtonTrack:SetPoint("TOP", ZHunterButtonAspect, "BOTTOM", 0, -15)
	ZHunterButtonTrap:ClearAllPoints()
	ZHunterButtonTrap:SetPoint("TOP", ZHunterButtonTrack, "BOTTOM", 0, -15)
	ZHunterAIStripDisplay:ClearAllPoints()
	ZHunterAIStripDisplay:SetPoint("TOP", ZHunterButtonTrap, "BOTTOM", 0, -10)
end

function ZMarkTarget()
	if not UnitExists("target") then return end
	for i=1, 40 do
		if not UnitDebuff("target", i) then break end
		ZHunterModTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		ZHunterModTooltip:SetUnitDebuff("target", i)
		local spell = ZHunterModTooltipTextLeft1:GetText()
		if spell == ZHUNTER_HUNTERSMARK then
			return
		end
	end
	CastSpellByName(ZHUNTER_HUNTERSMARK)
	return 1
end

SLASH_ZHunterMod1 = "/ZHunter"
SlashCmdList["ZHunterMod"] = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage("Possible Slash Commands: \"/zaspect\", \"/ztrack\", \"/ztrap\", \"/zpet\", \"/zcastbar\", \"/ztranq\", \"/zammo\", \"/zstrip\", \"/zfeignhealth\", \"/zantidaze\", \"/zpetattack\"", 0, 1, 1)
end