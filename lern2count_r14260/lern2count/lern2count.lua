ltc = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0","AceConsole-2.0")
local Glib = AceLibrary("Gratuity-2.0")

local Scolour = "|cffffffff"
local Rcolour = "|cff00FF33"

local Plugins = {}

local CostList = {}
local ReagentList = {}

function ltc:OnInitialize()
	self.CountList = {}
end

function ltc:OnEnable()
	self:RegisterEvent("UNIT_MANA","PowerUpdate")
	self:RegisterEvent("UNIT_RAGE","PowerUpdate")
	self:RegisterEvent("UNIT_ENERGY","PowerUpdate")
	self:RegisterEvent("BAG_UPDATE",function() ltc:ReagentListUpdate() end)
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED",function() ltc:PowerUpdate("player") end) --some addons have a tendency to eat the counts on target changing.

	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED","BarUpdate")
	self:RegisterEvent("ACTIONBAR_HIDEGRID","BarUpdate")
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED","BarUpdate")
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE","BarUpdate")
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED","BarUpdate")

     self:ScheduleEvent(self.DelayedUpdate, 1, self) --Delay initializing the addon a second, thats enough for everything to finish what its doing (I hope)

	self:RegisterEvent("PLAYER_REGEN_DISABLED",function() self.combat = true end)
	self:RegisterEvent("PLAYER_REGEN_ENABLED",function() self.combat = false end)

	self.CountList = {}
end

function ltc:DelayedUpdate()

	self:CountListUpdate()
	self:CostAndReagentListUpdate()
	ltc:PowerUpdate("player")

end

function ltc:RegisterPlugin(a)

	local func = ltc[a]
	table.insert(Plugins, func)
end

function ltc:CountListUpdate()

	self.CountList = {}
	for _, func in ipairs(Plugins) do
	 	func(self)
	end
end

function ltc:CostAndReagentListUpdate()
	CostList = {}
	ReagentList = {}
	
	local i, j, Cost
	for _,t in ipairs(self.CountList) do
		for stringo,AId in pairs(t) do
			Glib:SetAction(AId)
			
            self.PowerType = UnitPowerType("player")

            if( self.PowerType == 0 ) then
				i,j,Cost = Glib:Find("(%d+) "..MANA)
			elseif (self.PowerType == 1) then
				i,j,Cost = Glib:Find("(%d+) "..RAGE)
			elseif(self.PowerType == 3) then
				i,j,Cost = Glib:Find("(%d+) "..ENERGY)
			end
			
			Cost = tonumber(Cost)
			CostList[stringo] = Cost
			
			local _,_,Reagent = Glib:Find(SPELL_REAGENTS.."(.+)")
			local ReagentCount = self:GetInvCount(Reagent)
			if(ReagentCount == 0) then ReagentCount = nil end
			
            ReagentList[stringo] = ReagentCount
		end
	end

end

function ltc:ReagentListUpdate()
	ReagentList = {}

	for _,t in pairs(self.CountList) do
		for stringo,AId in pairs(t) do
			Glib:SetAction(AId)

			local _,_,Reagent = Glib:Find(SPELL_REAGENTS.."(.+)")
			local ReagentCount = self:GetInvCount(Reagent)
			if(ReagentCount == 0) then ReagentCount = nil end
			
            ReagentList[stringo] = ReagentCount
		end
	end
end

function ltc:PowerUpdate(unit)

	if(unit == "player") then
		local Cost, Ticks, PowerCount

		self.PowerType = UnitPowerType("player")
		self.PowerAmount = UnitMana("player")

		for idx,t in pairs(self.CountList) do
			for stringo,AId in pairs(t) do

				Cost, Ticks, PowerCount = nil,nil,nil
				Glib:SetAction(AId)
				
				Cost = CostList[stringo]
				local ReagentCount = ReagentList[stringo]

				if(Cost) then
					if(self.PowerType == 3)then
						PowerCount = ceil( (Cost - self.PowerAmount) / 20 )
						if(PowerCount <= 0) then PowerCount = "" end
					else
						PowerCount = floor(self.PowerAmount/Cost)
					end
				end
				
				local RetVal

				if(self.Combat) then
					if(ReagentCount) then
						if(PowerCount and (PowerCount > ReagentCount)) then
							RetVal = PowerCount
							RetVal = Scolour..RetVal.."|r"
						else
							RetVal = ReagentCount
							RetVal = Rcolour..RetVal.."|r"
						end
					elseif(PowerCount) then
						RetVal = PowerCount
						RetVal = Scolour..RetVal.."|r"
					end
				else
					if(ReagentCount) then
						RetVal = ReagentCount
						RetVal = Rcolour..RetVal.."|r"
					elseif(PowerCount) then
						RetVal = PowerCount
						RetVal = Scolour..RetVal.."|r"
					end
				end
				if(RetVal) then
					local text = getglobal(stringo)
					text:SetText(RetVal)
					RetVal = nil
				end

			end
		end
	end
end

function ltc:GetInvCount(item)
	local val = 0
	for b = 0, NUM_BAG_FRAMES do
     	for s = 1, GetContainerNumSlots(b) do
			local c = GetContainerItemLink(b, s) or ""
			local _, _, tid = string.find(c, "item:(%d+):%d+:%d+:%d+")
			local id = tonumber(tid)
			if(id ~= nil) then
				local cName = GetItemInfo(id)
				if (cName == item) then
					local _, amt = GetContainerItemInfo(b, s)
					val = val+ amt
				end
			end
		end
	end
	return val
end

function ltc:BarUpdate(slot)
	self:ScheduleEvent(self.DelayedUpdate, 0.1, self)
end
