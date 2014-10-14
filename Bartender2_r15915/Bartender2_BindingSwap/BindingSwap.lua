BT2BindingSwap = Bartender:NewModule("bindingswap", "AceEvent-2.0")
BINDING_HEADER_BARTENDER2BINDINGSWAP = "Bartender2 BindingSwap"
BINDING_NAME_SWAP1 = "Swap to bar 1"
BINDING_NAME_SWAP2 = "Swap to bar 2"
BINDING_NAME_SWAP3 = "Swap to bar 3"
BINDING_NAME_SWAP4 = "Swap to bar 4"
BINDING_NAME_SWAP5 = "Swap to bar 5"
BINDING_NAME_SWAP6 = "Swap to bar 6"

local bars = nil
local keyBindings = nil

local function BT2BindingSwap_PopulateBars()
	local names = {
		"ActionButton", "Multiactionbar1button", "Multiactionbar2button",
		"Multiactionbar3button", "Multiactionbar4button", "Shapeshiftbutton"
	}
	bars = {}
	for i = 1, 6 do
		bars[i] = {}
		for k = 1, 12 do
			table.insert(bars[i], names[i]..k)
		end
	end
end

local function BT2BindingSwap_PopulateBindings()
	keyBindings = {}
	for i = 1, 12 do
		keyBindings[i] = GetBindingKey("ACTIONBUTTON"..i)
	end
end

function BT2BindingSwap:ApplyToBar(barNumber)
	if not bars then BT2BindingSwap_PopulateBars() end
	if not bars[barNumber] then return end
	if not keyBindings then BT2BindingSwap_PopulateBindings() end

	for k, v in pairs(bars[barNumber]) do
		SetBinding(keyBindings[k], v)
	end
	self:UpdateHotkeys(barNumber)
end

local _G = getfenv(0)
function BT2BindingSwap:UpdateHotkeys(barNumber)
	for i = 1, 5 do
		if i ~= barNumber then
			for j = 1, 12 do
				local buttonHk = _G["Bar"..i.."Button"..j.."HK"]
				if buttonHk then buttonHk:SetText("") end
			end
		end
	end
end

