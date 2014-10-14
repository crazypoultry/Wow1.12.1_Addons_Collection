--[[
	Bongos_ActionBar\context.lua
		Handles contextual paging
		Contextual paging switches a bar based on the reaction of the player's implied target
		Essentially, this allows the user to make a bar switch pages when targeting an enemy unit
--]]

local watcher
local quickPaged
local UPDATE_DELAY = 0.01

local CreateContextWatcher

--[[ Context Event Watching ]]--

local function UpdateContext()
	if BContextSets then
		if not(UnitExists('target') and UnitCanAttack("player", "target")) or quickPaged then
			for barList, offset in pairs(BContextSets) do
				Bongos_ForBarID(barList, BActionBar.SetContextOffset, offset)
			end
		else
			for barList, offset in pairs(BContextSets) do
				Bongos_ForBarID(barList, BActionBar.SetContextOffset, 0)
			end
		end
	end
end

local function UpdateContextWatcher()
	if not(BContextSets and next(BContextSets)) then
		if watcher then
			watcher:Hide()
		end
	else
		if watcher then
			watcher:Show()
		else
			CreateContextWatcher()
		end
	end
	UpdateContext()
end

function CreateContextWatcher()
	watcher = CreateFrame('Frame')

	watcher:SetScript('OnEvent', UpdateContext)
	watcher:RegisterEvent('PLAYER_TARGET_CHANGED')

	watcher.update = 0
	watcher:SetScript('OnUpdate', function()
		if this.update <= 0 then
			if quickPaged then
				if not BActionSets_IsSelfCastHotkeyDown() then
					quickPaged = nil
					UpdateContext()
				end
			else
				if BActionSets_IsSelfCastHotkeyDown() then
					quickPaged = true
					UpdateContext()
				end
			end
			this.update = UPDATE_DELAY
		else
			this.update = this.update - arg1
		end
	end)
end

--[[ Usable Functions ]]--

BContext = {
	Add = function(barList, offset)
		assert(barList, 'No barList given')

		if BContextSets then
			BContextSets[barList] = offset
		else
			BContextSets = { [barList] = offset }
		end
		UpdateContextWatcher()
	end,

	Remove = function(barList)
		assert(barList, 'No barList given')

		if BContextSets then
			BContextSets[barList] = nil
			Bongos_ForBarID(barList, BActionBar.SetContextOffset, 0)
		end
		UpdateContextWatcher()
	end
}

--[[ Startup ]]--

BProfile.RegisterForSave('BContextSets')
BProfile.AddStartup(UpdateContextWatcher)