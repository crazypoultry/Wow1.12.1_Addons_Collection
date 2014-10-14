BT2n52 = Bartender:NewModule("Bartender_n52")

function BT2n52:OnEnable()
	Bar1Button4:ClearAllPoints()
	Bar1Button4:SetPoint("TOP", Bar1Button1, "BOTTOM", 0, 0)
	Bar1Button9:ClearAllPoints()
	Bar1Button9:SetPoint("TOP", Bar1Button4, "BOTTOM", 0, 0)
	Bar1Button2:ClearAllPoints()
	Bar1Button2:SetPoint("BOTTOM", Bar1Button6, "TOP", 0, 0)
	Bar1Button3:ClearAllPoints()
	Bar1Button3:SetPoint("BOTTOM", Bar1Button8, "TOP", 0, 0)
	Bar1:SetHeight(116)
	Bar1:SetWidth(184)
end