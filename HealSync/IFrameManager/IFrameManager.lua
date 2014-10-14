
local IFrameFactory = IFrameFactory("1.0")

IFrameManager = {
	frameList = { },
}


local baseInterface = { }
local interfaceMetatable = { __index = baseInterface }

function baseInterface:getName(frame)
	return frame:GetName()
end

function baseInterface:getBorder(frame)
	return 0, 0, 0, 0
end

function IFrameManager:Interface()
	local iface = { }
	setmetatable(iface, interfaceMetatable)
	return iface
end

function IFrameManager:Register(frame, iface)
	if (getmetatable(iface) == interfaceMetatable) then
		self.frameList[frame] = iface
	else
		DEFAULT_CHAT_FRAME:AddMessage("wrong metatable for frame: "..frame:GetName())
	end
end

function IFrameManager:Enable()
	if (self.isEnabled) then
		return
	end
	
	for frame, iface in self.frameList do
		frame.IFrameManager = IFrameFactory:Create("IFrameManager", "Capsule")
		frame.IFrameManager.label:SetText(iface:getName(frame))
	end
	
	IFrameManagerButton:SetNormalTexture("Interface\\AddOns\\IFrameManager\\Textures\\MinimapButton-Highlight")
	self.isEnabled = true
	
	IFrameManager:Refresh()
end

function IFrameManager:Refresh()
	if (self.isEnabled == nil) then
		return
	end
	
	for frame, iface in self.frameList do
		local capsule = frame.IFrameManager
		local t, r, b, l = iface:getBorder(frame)
		
		local cScale = capsule:GetEffectiveScale()
		local fScale = frame:GetEffectiveScale()
		
		local cX = frame:GetLeft() or (capsule:GetLeft() + l) / fScale * cScale
		local cY = frame:GetBottom() or (capsule:GetBottom() + b) / fScale * cScale
		
		capsule:SetWidth(frame:GetWidth() + l + r)
		capsule:SetHeight(frame:GetHeight() + t + b)
		
		capsule.label:SetWidth(capsule:GetWidth() - 8)
		
		capsule:SetParent(frame:GetParent())
		capsule:SetScale(frame:GetScale())
		
		capsule:ClearAllPoints()
		capsule:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", cX - l, cY - b)
		
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", capsule, "CENTER", (l - r) / 2, (b - t) / 2)
	end
end

function IFrameManager:Disable()
	if (self.isEnabled == nil) then
		return
	end
	
	for frame, iface in self.frameList do
		local capsule = frame.IFrameManager
		frame.IFrameManager = nil
		
		local x, y = frame:GetLeft(), frame:GetBottom()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x, y)
		frame:SetUserPlaced(true)
		capsule:SetUserPlaced(false)
		
		IFrameFactory:Destroy("IFrameManager", "Capsule", capsule)
		frame.IFrameManager = nil
	end
	
	IFrameManagerButton:SetNormalTexture("Interface\\AddOns\\IFrameManager\\Textures\\MinimapButton-Normal")
	self.isEnabled = nil
end

function IFrameManager:Toggle()
	if (self.isEnabled) then
		IFrameManager:Disable()
	else
		IFrameManager:Enable()
	end
end


SLASH_IFrameManager1 = "/ifm"

SlashCmdList["IFrameManager"] = function(msg)
	if (msg == "start") then
		IFrameManager:Enable()
	elseif (msg == "stop") then
		IFrameManager:Disable()
	end
end