-----------------------------------------------------------------------------
-- FuBar stuff
-----------------------------------------------------------------------------

local Tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.0"):new("FuBar_oRA2CooldownFu")
local Dewdrop = AceLibrary("Dewdrop-2.0")

oRA2CooldownFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

oRA2CooldownFu:RegisterDB("oRA2CooldownFuDB")
oRA2CooldownFu:RegisterDefaults('profile', 
	{
		showDruid	= true,
		showWarlock	= true,
		showShaman	= true,
		cooldownData = { },
	}
)

oRA2CooldownFu.version = "1.0." .. string.sub("$Revision: 9785 $", 12, -3)
oRA2CooldownFu.date = string.sub("$Date: 2006-09-02 10:55:39 +0930 (Sat, 02 Sep 2006) $", 8, 17)
oRA2CooldownFu.hasIcon = "Interface\\Icons\\Spell_Nature_TimeStop"
oRA2CooldownFu.defaultPosition = 'LEFT'
oRA2CooldownFu.hideWithoutStandby = true
oRA2CooldownFu.independentProfile = true

oRA2CooldownFu.OnMenuRequest = 
{
	handler = oRA2CooldownFu,
	type = 'group',
	args = 
	{
		showDruid = 
		{
			type = "toggle",
			order = 100,
			name = L["Show Druids"],
			desc = L["Shows cooldown of combat resurrections in tooltip."],
			get = function() return oRA2CooldownFu.db.profile.showDruid end,
			set = function() oRA2CooldownFu.db.profile.showDruid = not oRA2CooldownFu.db.profile.showDruid oRA2CooldownFu:UpdateDisplay() end
		},
		showWarlock = 
		{
			type = "toggle",
			order = 101,
			name = L["Show Warlocks"],
			desc = L["Shows cooldown of soulstones in tooltip."],
			get = function() return oRA2CooldownFu.db.profile.showWarlock end,
			set = function() oRA2CooldownFu.db.profile.showWarlock = not oRA2CooldownFu.db.profile.showWarlock oRA2CooldownFu:UpdateDisplay() end
		},
		showShaman = 
		{
			type = "toggle",
			order = 102,
			name = L["Show Shaman"],
			desc = L["Shows ankh cooldown timer in tooltip."],
			get = function() return oRA2CooldownFu.db.profile.showShaman end,
			set = function() oRA2CooldownFu.db.profile.showShaman = not oRA2CooldownFu.db.profile.showShaman oRA2CooldownFu:UpdateDisplay() end
		},
	},
}

function oRA2CooldownFu:OnInitialize()
end

function oRA2CooldownFu:OnEnable()
    self:RegisterEvent("RAID_ROSTER_UPDATE", "RaidChanged")
    self:RaidChanged()
end

function oRA2CooldownFu:OnDisable()
end

function oRA2CooldownFu:RaidChanged()
	if GetNumRaidMembers() > 0 then
		self:ScheduleRepeatingEvent("oRA2CooldownFuTimer", self.TimerTick, 1, self)
	else
		self:CancelScheduledEvent("oRA2CooldownFuTimer")
	end
	self:UpdateDisplay()
end

function oRA2CooldownFu:OnTextUpdate()
	if GetNumRaidMembers() > 0 then
		self:SetText(L["Active"])
	else
		self:SetText(L["Inactive"])
	end
end

function oRA2CooldownFu:TimerTick()
	self:UpdateTooltip()
end

function oRA2CooldownFu:OnTooltipUpdate()
	if GetNumRaidMembers() <= 0 then return end
	
	local currentTime = time()
	local classTable = { }
	local usable =
	{
		["WARLOCK"] = 0,
		["SHAMAN"] = 0,
		["DRUID"] = 0,
	}
	local total =
	{
		["WARLOCK"] = 0,
		["SHAMAN"] = 0,
		["DRUID"] = 0,
	}

	for i=1,40 do
		local name, _, _, _, _, fileName, _, online, isDead = GetRaidRosterInfo(i)
		
		if not name then break end
		
		local process = false
		
		if fileName == "WARLOCK" then
			if self.db.profile.showWarlock then process = true end
		elseif fileName == "DRUID" then
			if self.db.profile.showDruid then process = true end
		elseif fileName == "SHAMAN" then
			if self.db.profile.showShaman then process = true end
		end

		if process then
			if not classTable[fileName] then classTable[fileName] = { } end
		
			local expiryTime = self.db.profile.cooldownData[name]

			total[fileName] = total[fileName] + 1
			if not online then 
				classTable[fileName][50000+i] = i
			elseif not expiryTime or expiryTime <= currentTime then
				if isDead then
					if fileName == "SHAMAN" then
						classTable[fileName][10000+i] = i
						usable[fileName] = usable[fileName] + 1
					else
						classTable[fileName][30000+i] = i
					end
				else
					classTable[fileName][20000+i] = i
					usable[fileName] = usable[fileName] + 1
				end
			else
				local timeRemaining = expiryTime-currentTime
				classTable[fileName][40000+timeRemaining+i] = i
			end
		end		
	end

	for class,t in classTable do
		local cat = Tablet:AddCategory('text', L[class.."header"],
									   'hideBlankLine', true,
									   'columns', 2,
									   'child_indentation', 5,
									   'text2', "("..usable[class].."/"..total[class]..")")
		local colour = RAID_CLASS_COLORS[class]

		-- Sort the table so that we can prioritize: shaman ankh > ready > dead ready > not ready > offline
		-- We do this by putting the priorities into an array, sorting the array, then iterating it
		local a = { }
		for n in t do table.insert(a, n) end
		table.sort(a)

		for _,i in ipairs(a) do
			local index = t[i]
			local name, _, _, _, _, _, _, online, isDead = GetRaidRosterInfo(index)
			
			local expiryTime = self.db.profile.cooldownData[name]

			local text 
			local stateColour = { 0, 1, 0 }
			
			if not online then 
				text = L["Offline"] 
				stateColour = { 1, 0, 0 }
			elseif not expiryTime or expiryTime <= currentTime then
				text = L["Ready"]
				if isDead then
					if class == "SHAMAN" then
						stateColour = { 1, 1, 0 }
					else
						stateColour = { 1, 0, 0 }
					end
				end
			else
				text = date("!%M:%S", expiryTime-currentTime)
				stateColour = { 1, 0, 0 }
			end

			cat:AddLine('text', name,
						'textR', colour.r,
						'textG', colour.g,
						'textB', colour.b,
						'text2', text,
						'text2R', stateColour[1],
						'text2G', stateColour[2],
						'text2B', stateColour[3])
		end
	end
	
end

-----------------------------------------------------------------------------
-- oRA2 stuff
-----------------------------------------------------------------------------

assert( oRA, "oRA not found!")

oRA2CooldownFuItem = oRA:NewModule(L["ora2cooldownfuparticipant"])
oRA2CooldownFuItem.defaults = { }
oRA2CooldownFuItem.participant = true
oRA2CooldownFuItem.name = L["Participant/CooldownFu"]

function oRA2CooldownFuItem:OnInitialize()
	self.debugFrame = ChatFrame5
end

function oRA2CooldownFuItem:OnEnable()
	self:RegisterCheck("CD", "oRA_Cooldown")
end

function oRA2CooldownFuItem:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterCheck("CD")
end

function oRA2CooldownFuItem:oRA_Cooldown( msg, author)
--	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)

	local _, _, num, cooldown = string.find(msg, "^CD (%d+) (%d+)$");
	oRA2CooldownFu.db.profile.cooldownData[author] = time() + tonumber(cooldown)*60	
end

-----------------------------------------------------------------------------
