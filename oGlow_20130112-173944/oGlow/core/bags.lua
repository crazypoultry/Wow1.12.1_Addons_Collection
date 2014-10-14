-- Globally used
local G = getfenv(0)
local select = select
local oGlow = oGlow

-- Containers
local GetContainerItemLink = GetContainerItemLink
local GetItemInfo = GetItemInfo

-- Addon
local frame = CreateFrame"Frame"
frame:Hide()

local ContainerFrame1 = ContainerFrame1
local bid, self, link, size, name, q
local update = function(bag, id)
	size = bag.size
	name = bag:GetName()
	for i=1, size do
		bid = size - i + 1
		self = G[name.."Item"..bid]
		link = GetContainerItemLink(id, i)

		if(link and not oGlow.preventBags) then
			q = select(3, GetItemInfo(link))
			oGlow(self, q)
		elseif(self.bc) then
			self.bc:Hide()
		end
	end
end

local delay = 0
local up = {}
frame:SetScript("OnUpdate", function(self, elapsed)
	delay = delay + elapsed
	if(delay > .05) then
		for id in pairs(up) do
			update(id, id:GetID())
			up[id] = nil
		end

		delay = 0
		self:Hide()
	end
end)

local cf
frame:SetScript("OnEvent", function(self, event, id)
	local cf
	for _, bag in ipairs(ContainerFrame1.bags) do
		bag = _G[bag]
		if(bag:GetID() == id) then
			cf = bag
			break
		end
	end

	if(cf and cf:IsShown()) then
		up[cf] = true
		frame:Show()
	end
end)

local self
hooksecurefunc("ContainerFrame_OnShow", function()
	self = this
	if(ContainerFrame1.bagsShown > 0) then
		frame:RegisterEvent"BAG_UPDATE"
		up[self] = true
		frame:Show()
	end
end)

hooksecurefunc("ContainerFrame_OnHide", function()
	if(ContainerFrame1.bagsShown == 0) then
		frame:UnregisterEvent"BAG_UPDATE"
		up[self] = nil
		frame:Hide()
	end
end)

oGlow.updateBags = update
