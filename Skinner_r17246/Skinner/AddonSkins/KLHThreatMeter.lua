
function Skinner:KLHThreatMeter()

	self:removeRegions(_G["KLHTM_TitleFrame"])
	self:applySkin(_G["KLHTM_Frame"])
	
	local frame = CreateFrame("frame", nil, KLHTM_TitleFrame)
	frame:SetFrameLevel(2)
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMLEFT", KLHTM_TitleFrame, "BOTTOMLEFT", -5, -5)
	frame:SetPoint("BOTTOMRIGHT", KLHTM_TitleFrame, "BOTTOMRIGHT", 5, -5)
	frame:SetPoint("TOPLEFT", KLHTM_TitleFrame, "TOPLEFT", -5, 5)
	frame:SetPoint("TOPRIGHT", KLHTM_TitleFrame, "TOPRIGHT", 5, 5)
	self:applySkin(frame, nil, 0)

end
