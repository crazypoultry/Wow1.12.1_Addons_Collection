ItemRackFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "FuBarPlugin-2.0")

local Tablet = AceLibrary("Tablet-2.0")

local IR_outdated
if tonumber(ItemRack_Version) and tonumber(ItemRack_Version)>1.82 then IR_outdated = nil
else IR_outdated = true end

ItemRackFu.version = "2.0." .. string.sub("$Revision: 9785 $", 12, -3)
ItemRackFu.date = string.sub("$Date: 2006-09-02 03:25:39 +0200 (Sa, 02 Sep 2006) $", 8, 17)
ItemRackFu.hasIcon = true
ItemRackFu.hasNoColor = true
ItemRackFu.cannotDetachTooltip = true
ItemRackFu.cannotAttachToMinimap = true

function ItemRackFu:OnInitialize()
	self.options = {
		type = "group",
		args = {
			text = {
				name = "Open ItemRack Settings",
				type = "execute",
				desc = "Open ItemRack Settings Dialog",
				func = function()
					ItemRack_Sets_Toggle()
				end,
				disabled = function() return IR_outdated end,
			}
		}
	}
	
	self.OnMenuRequest = self.options
end

function ItemRackFu:OnEnable()
	TitanPanelItemRackButton = FuBarPluginItemRackFuFrame -- Fake the Titan Panel Button so that ItemRack's built in functions fire properly.
end

function ItemRackFu:OnDisable()
	TitanPanelItemRackButton = nil
end

function ItemRackFu:OnTooltipUpdate()
	if IR_outdated then
		Tablet:SetHint("ItemRack v1.83+ required.")
	else
		Tablet:SetHint("Left-click to choose a set.")
	end
end

function ItemRackFu:UpdateText()
	local _,setName,setIcon = ItemRack_GetUserSets()
	if setName then
		self:SetIcon(setIcon)
		self:SetText(setName)
	end
end

function ItemRackFu:OnClick()
	if IR_outdated then
		self:Print("ItemRack version 1.83 or greater is required to open sets from FuBar.")
	else
		if ItemRack_MenuFrame:IsVisible() then
			ItemRack_MenuFrame:Hide()
		else
			ItemRack_BuildMenu(20,"TITAN")
		end
	end
end

-- triggered by ItemRack on draw_inv
function ItemRack_UpdatePlugins()
	ItemRackFu:UpdateText()
end
