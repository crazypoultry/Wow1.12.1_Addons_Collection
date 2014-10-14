
local IFrameFactory = IFrameFactory("1.0")

local function onUpdate()
	local remaining = this.heal[5] - ( GetTime() - this.heal[4])
	if (remaining > 0) then
		local pos = this.bar:GetWidth() / this.heal[5] * (this.heal[5] - remaining)
		this.bar:SetValue(this.heal[5] - remaining)
		this.spark:ClearAllPoints()
		this.spark:SetPoint("CENTER", this.bar, "LEFT", pos, 0)
	else
		HealSyncClear(this.heal[1])
		HealSyncUpdate()
	end
end

local FactoryInterface = { }
IFrameFactory:Register("HealSync", "Button", FactoryInterface)

function FactoryInterface:Create(name)
	local frame = CreateFrame("Frame", name, UIParent)
	frame:SetWidth(256)
	frame:SetHeight(20)
	
	local backdropTable = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 12,
		edgeSize = 12,
		insets = {
			left = 2,
			right = 2,
			top = 2,
			bottom = 2
		}
	}
	
	frame:SetBackdrop(backdropTable)
	frame:SetBackdropBorderColor(0, 0, 0, 1)
	frame:SetBackdropColor(0, 0, 0, 1)
	
	frame.bar = CreateFrame("StatusBar", nil, UIParent)
	frame.bar:Show()
	frame.bar:SetWidth(248)
	frame.bar:SetHeight(12)
	frame.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar", "BORDER")
	frame.bar:SetStatusBarColor(1.0, 1.0, 1.0, 0.7)
	frame.bar:ClearAllPoints()
	frame.bar:SetPoint("CENTER", frame, "CENTER", 0, 0)
	frame.bar:SetParent(frame)
	
	frame.caster = frame.bar:CreateFontString(nil, "OVERLAY")
	frame.caster:Show()
	frame.caster:SetFontObject(GameFontNormal)
	frame.caster:SetWidth(100)
	frame.caster:SetHeight(20)
	frame.caster:ClearAllPoints()
	frame.caster:SetPoint("LEFT", frame, "LEFT", 8, 0)
	frame.caster:SetJustifyH("CENTER")
	frame.caster:SetTextColor(1.0, 0.82, 0)
	
	frame.spell = frame.bar:CreateFontString(nil, "OVERLAY")
	frame.spell:Show()
	frame.spell:SetFontObject(GameFontNormal)
	frame.spell:SetWidth(130)
	frame.spell:SetHeight(20)
	frame.spell:ClearAllPoints()
	frame.spell:SetPoint("RIGHT", frame, "RIGHT", -8, 0)
	frame.spell:SetJustifyH("CENTER")
	frame.spell:SetTextColor(1.0, 0.82, 0)
	
	frame.spark = frame.bar:CreateTexture(nil, "OVERLAY")
	frame.spark:SetWidth(32)
	frame.spark:SetHeight(32)
	frame.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	frame.spark:Show()
	frame.spark:SetBlendMode("ADD")
	frame.spark:ClearAllPoints()
	frame.spark:SetPoint("CENTER", frame.bar, "LEFT", 0, 0)
	frame.spark:SetParent(frame.bar)
	
	frame:SetScript("OnUpdate", onUpdate)
	
	return frame
end

function FactoryInterface:Destroy(frame)
	return frame
end
