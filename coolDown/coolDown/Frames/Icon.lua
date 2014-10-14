
local FactoryInterface = { }
IFrameFactory("1.0"):Register("coolDown", "Icon", FactoryInterface)

function FactoryInterface:Create(name)
	local frame = CreateFrame("Frame", name, UIParent)
	frame:SetWidth(30)
	frame:SetHeight(30)

	frame.texture = frame:CreateTexture(nil, "ARTWORK")
	frame.texture:SetWidth(28)
	frame.texture:SetHeight(28)
	frame.texture:SetPoint("CENTER", frame, "CENTER", 0, 0)

	frame.border = frame:CreateTexture(nil, "OVERLAY")
	frame.border:SetWidth(30)
	frame.border:SetHeight(30)
	frame.border:SetTexture("Interface\\Buttons\\UI-Debuff-Border")
	frame.border:SetPoint("CENTER", frame, "CENTER", 0, 0)
	frame.border:SetVertexColor(0, 0, 0, 1)

	return frame
end

function FactoryInterface:Destroy(frame)
	return frame
end
