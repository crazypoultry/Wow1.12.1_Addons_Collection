local dewdrop = AceLibrary:GetInstance("Dewdrop-2.0")
local bagID, slot, itemName
local table = {
	type= 'group',
	args = {
		Header = {
			name = "-",
			type = "header",
			order = 1,
		},
		MainHand = {
			name = "Main Hand",
			type = 'execute',
			desc = "Apply",
			func = function()
				UseContainerItem(bagID, slot)
				PickupInventoryItem(16)
				EquipCursorItem(slot)
			end,
			order = 2,
		},		
		OffHand = {
			name = "Off Hand",
			type = 'execute',
			desc = "Apply",
			func = function()
				UseContainerItem(bagID, slot)
				PickupInventoryItem(17)
				EquipCursorItem(slot)
			end,
			order = 3,
		}	
	}
}
local Tenchants = {
	--[[ Rogue love
	]]
	[6947]	= true,		-- Instant Poison
	[6949]	= true,		-- Instant Poison II
	[6950]	= true,		-- Instant Poison III
	[8926]	= true,		-- Instant Poison IV
	[8927]	= true,		-- Instant Poison V
	[8928]	= true,		-- Instant Poison VI
	[3775]	= true,		-- Crippling Poison
	[3776]	= true,		-- Crippling Poison II
	[2892]	= true,		-- Deadly Poison
	[2893]	= true,		-- Deadly Poison II
	[8984]	= true,		-- Deadly Poison III
	[8985]	= true,		-- Deadly Poison IV
	[20844]	= true,		-- Deadly Poison V
	[5237]	= true,		-- Mind-numbing Poison
	[6951]	= true,		-- Mind-numbing Poison II
	[9186]	= true,		-- Mind-numbing Poison III
	[10918]	= true,		-- Wound Poison
	[10920]	= true,		-- Wound Poison II
	[10921]	= true,		-- Wound Poison III
	[10922]	= true,		-- Wound Poison IV
	--[[ Sharpening Stones
	]]
	[23122] = true,		-- Consecrated Sharpening Stone
	[18262] = true,		-- Elemental Sharpening Stone
	[2863] = true,			-- Coarse Sharpening Stone
	[12404] = true,		-- Dense Sharpening Stone
	[2871] = true,			-- Heavy Sharpening Stone
	[2862] = true,			-- Rough Sharpening Stone
	[7964] = true,			-- Solid Sharpening Stone
	--[[ Weightstones
	]]
	[3240] = true,			-- Coarse Weightstone
	[12643] = true,		-- Dense Weightstone
	[3241] = true,			-- Heavy Weightstone
	[3239] = true,			-- Rough Weightstone
	[7965] = true,			-- Solid Weightstone	
	--[[ Wizard oils
	]]
	[23123] = true,		-- Blessed Wizard Oil
	[20749] = true,		-- Brilliant Wizard Oil
	[20746] = true,		-- Lesser Wizard Oil
	[20744] = true,		-- Minor Wizard Oil
	[20750] = true,		-- Wizard Oil
	--[[ Mana oils
	]]
	[20748] = true,		-- Brilliant Mana Oil
	[20747] = true,		-- Lesser Mana Oil
	[20745] = true,		-- Minor Mana Oil
	--[[ Fishing lures
	]]
	[6533] = true,			-- Aquadynamic Fish Attractor
	[6532] = true,			-- Bright Baubles
	[6530] = true,			-- Nightcrawlers
	[6529] = true,			-- Shiny Bauble
}

 oApplication= AceLibrary("AceAddon-2.0"):new("AceHook-2.0")

function oApplication:OnInitialize()
end

function oApplication:OnEnable()
	self:Hook("ContainerFrameItemButton_OnClick")
end
--[[ From PT
]]
function oApplication:GetID(item)
	if type(item) == "number" then return item
	elseif type(item) == "string" then
		local _, _, id = string.find(item, "item:(%d+):%d+:%d+:%d+")
		if id then return tonumber(id) end
	end
end

function oApplication:ContainerFrameItemButton_OnClick(a1, a2)
	if ( a1 == "RightButton" and not  TradeFrame:IsShown() and not BankFrame:IsShown()) then
		local id = self:GetID(GetContainerItemLink(this:GetParent():GetID(), this:GetID()))
		if(id and Tenchants[id]) then
			bagID = this:GetParent():GetID()
			slot = this:GetID()
			local name = GetItemInfo(id)
			table.args.Header.name = name
			dewdrop:Open(UIParent, 'children', function() dewdrop:FeedAceOptionsTable(table) end,'cursorX', true, 'cursorY', true)
		else
			return self.hooks["ContainerFrameItemButton_OnClick"].orig(a1, a2)
		end
	else
		return self.hooks["ContainerFrameItemButton_OnClick"].orig(a1, a2)
	end
end