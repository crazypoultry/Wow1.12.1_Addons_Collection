--[[
	Bongos_ActionBar\stance.lua
		Handles stances.  Stances are things like when a druid switches to bear form, a warrior switches to fury stance, or a rogue switches into stealth.
		BStance allows the user to make a bar automatically change pages when one of those events occurs
		
--]]

--[[ Usable Functions ]]--

BStance = {
	state = 0,
	
	Add = function(barList, id, offset)
		assert(barList, 'No barList given')
		assert(id, 'No stanceID given')
		
		if not BStanceSets then
			BStanceSets = {}
		end
		if not BStanceSets[id] then
			BStanceSets[id] = {}
		end

		if offset then
			BStanceSets[id][barList] = offset
			BEvent:CallEvent('BONGOS_STANCE_UPDATE', BStance.state)
		else
			BStance.Remove(barList, id)
		end
	end,
	
	Remove = function(barList, id)
		assert(barList, 'No barList given')
		assert(id, 'No stanceID given')
		
		if BStanceSets and BStanceSets[id] then
			BStanceSets[id][barList] = nil
			Bongos_ForBarID(barList, BActionBar.SetStanceOffset, 0)

			if not next(BStanceSets[id]) then
				BStanceSets[id] = nil
			end
		end
	end
}

--[[ Stance Events ]]--

--[[
	Warrior Stance IDs
		1 = battle
		2 = defensive
		3 = fury
--]]
local function WatchWarriorEvents()
	BEvent:AddAction("UPDATE_BONUS_ACTIONBAR", function()
		BStance.state = GetBonusBarOffset()
		BEvent:CallEvent('BONGOS_STANCE_UPDATE', BStance.state)
	end)
end

--[[
	Rogue Stance IDs
		0 = normal
		1 = stealthed
--]]
local function WatchRogueEvents()
	BEvent:AddAction("UPDATE_BONUS_ACTIONBAR", function()
		BStance.state = GetBonusBarOffset()
		BEvent:CallEvent('BONGOS_STANCE_UPDATE', BStance.state)
	end)
end

--[[
	Druid Stance IDs
		0 = caster
		1 = bear
		2 = aquatic
		3 = cat
		4 = travel
		5 = moonkin
		6 = prowl
--]]
local function WatchDruidEvents()
	--form check
	BEvent:AddAction("UPDATE_BONUS_ACTIONBAR", function()
		BStance.state = 0
		for i = 1, 5 do
			local _,_, active = GetShapeshiftFormInfo(i)
			if active then
				BStance.state = i
				break
			end
		end
		BEvent:CallEvent('BONGOS_STANCE_UPDATE', BStance.state)
	end)

	--prowl check
	BEvent:AddAction("PLAYER_AURAS_CHANGED", function()
		local _,_, active = GetShapeshiftFormInfo(3)
		if active then
			if Bongos_IsBuffActive(BONGOS_DRUID_PROWL) then
				BStance.state = 6
			else
				BStance.state = 3
			end
			BEvent:CallEvent('BONGOS_STANCE_UPDATE', BStance.state)
		end
	end)
end

--[[
	Priest Stance IDs
		0 = caster
		1 = shadowform
--]]
local function WatchPriestEvents()
	--shadowform check
	BEvent:AddAction("PLAYER_AURAS_CHANGED", function()
		if Bongos_IsBuffActive(BONGOS_PRIEST_SHADOWFORM) then
			BStance.state = 1
		else
			BStance.state = 0
		end
		BEvent:CallEvent('BONGOS_STANCE_UPDATE', BStance.state)
	end)
end

--[[ Startup ]]--

local function AddStanceScripts()
	--Load stance switching scripts
	local _, class = UnitClass('player')
	if class == 'WARRIOR' then
		WatchWarriorEvents()
	elseif class == 'ROGUE' then
		WatchRogueEvents()
	elseif class == 'DRUID' then
		WatchDruidEvents()
	elseif class == 'PRIEST' then
		WatchPriestEvents()
	end

	--stance switching
	BEvent:AddAction('BONGOS_STANCE_UPDATE', function()
		if BStanceSets then
			if not arg1 or arg1 == 0 then
				for _, list in pairs(BStanceSets) do
					for barList in pairs(list) do
						Bongos_ForBarID(barList, BActionBar.SetStanceOffset, 0)
					end
				end
			elseif BStanceSets[arg1] then
				for barList, offset in pairs(BStanceSets[arg1]) do
					Bongos_ForBarID(barList, BActionBar.SetStanceOffset, offset)
				end
			end
		end
	end)
end

local function LoadDefaultStances()
	local _, class = UnitClass('player')
	if class == 'DRUID' then
		BStance.Add(1, 3, 6) --cat
		BStance.Add(1, 6, 7) --prowl
		BStance.Add(1, 1, 8) --bear
		BStance.Add(1, 5, 9) --moonkin
	elseif class == 'ROGUE' then
		BStance.Add(1, 1, 6) --stealthed
	elseif class == 'WARRIOR' then
		BStance.Add(1, 1, 6) --battle stance
		BStance.Add(1, 2, 7) --defensive stance
		BStance.Add(1, 3, 8) --fury stance
	elseif class == 'PRIEST' then
		BStance.Add(1, 1, 6) --shadowform
	end
end

local function LoadSettings()
	if not BStanceSets then
		LoadDefaultStances()
	end
	AddStanceScripts()
end

BProfile.RegisterForSave('BStanceSets')
BProfile.AddStartup(LoadSettings)