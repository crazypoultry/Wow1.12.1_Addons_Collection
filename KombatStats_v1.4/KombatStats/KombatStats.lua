local compost = AceLibrary("Compost-2.0")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")

local parser = ParserLib:GetInstance("1.1")

KombatStats = {} 

KombatStats.version = "1.4"



-- KombatStats.debug = true;

local self = KombatStats

self.DEFAULT_BUTTON_WIDTH = 150	-- This is the width of 'constant frame width' option.
self.MAX_WIDTH = 250
self.MIN_WIDTH = 50

self.MAX_SCALE = 1.5
self.MIN_SCALE = 0.5


local ui = {}
ui.currDataset = "all"
ui.currCategory = "attack"


local playerName = UnitName("player")


function KombatStats:Debug(msg)
	if self.debug then
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end

KombatStats.events = {
	"CHAT_MSG_COMBAT_SELF_HITS",
	"CHAT_MSG_COMBAT_SELF_MISSES",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_COMBAT_PET_HITS",
	"CHAT_MSG_COMBAT_PET_MISSES",
	"CHAT_MSG_SPELL_PET_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
	"CHAT_MSG_SPELL_PET_BUFF",
	"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"

};

KombatStats.colors = {
	attack       = "ff0000",
	defend    	= "ff7f00",
	heal     = "00ff00",

	copper    = "eda55f",
	
}

function KombatStats:Colorize(hexColor, text)
	return "|cff" .. tostring(hexColor or 'ffffff') .. tostring(text) .. "|r"
end


function KombatStats:OnLoad()
	
	this:RegisterEvent( "VARIABLES_LOADED" );
	
	-- Slash commands.
	SLASH_KOMBATSTATS1 = "/kombatstats";
	SLASH_KOMBATSTATS2 = "/ks";
	
	SlashCmdList["KOMBATSTATS"] = self.SlashCmdHandler;	
	

	
end



function KombatStats:OnEvent()
	
	if event == "VARIABLES_LOADED" then
		
		KombatStats:OnInitialize()
		
		
	elseif event == "PLAYER_REGEN_DISABLED" then
	
		
		self:StartCombat()
		
		
	elseif event == "PLAYER_REGEN_ENABLED" then
	
		self:EndCombat()

	end
	
end

function KombatStats:OnInitialize() 

	if not KombatStats_Data then 
	
		KombatStats_Data = {
			allStats = {},
			allDPS = {},
		}
	end
	
	if not KombatStats_Skills then
		KombatStats_Skills = {}	
	end
	 
	self.stats = {
		session = {},
		last = {}
	}
	self.dps = {
		session = {},
		last = {}
	}
	
	self.stats.all = KombatStats_Data.allStats
	self.dps.all = KombatStats_Data.allDPS
	
	self.skills = KombatStats_Skills
	
	self.vars = {
		inCombat = false,
		combatTime = nil,
	}

	if not KombatStats_Settings then 
		KombatStats_Settings = {
			version = self.version,
			showButton = true,
			showDPS = true,
			showDTPS = true
		} 		
	end
	
	
	self.settings = KombatStats_Settings
	
	
	-- Pre 1.0 version data will be cleared.
	if not self.settings.version then
		for i in self.settings do
			self.settings[i] = nil
		end
	end
	
	-- Old version check
	if self.settings.version ~= self.version then
		-- Add later.	
		self.settings.version = self.version
	end
	
	local _, c = UnitClass("player")
	if c == "WARRIOR" or c == "DRUID" then
		self.canShapeshift = true
	end
	
	
	if not self.settings.disabled then self:OnEnable() end	
	if self.settings.showButton then self:ShowDPS() end

	if self.settings.frameScale then self:UpdateScale() end
	

end

function KombatStats:OnEnable()

	if self.enabled then return end
	-- For DPS and Last fight data set.
	
	KombatStatsFrame:RegisterEvent( "PLAYER_REGEN_DISABLED" );
	KombatStatsFrame:RegisterEvent( "PLAYER_REGEN_ENABLED" );
	
	for i, event in KombatStats.events do
		parser:RegisterEvent("KombatStats", event, self.OnCombatEvent);
	end
	
	self.settings.disabled = nil;	
	self.enabled = true 
	
	self:Update();

	
	
end

function KombatStats:OnDisable()

	if not self.enabled then return end
	KombatStatsFrame:UnregisterAllEvents();
	parser:UnregisterAllEvents("KombatStats");
	KombatStats.settings.disabled = true;
	self.enabled = false
	self:Update();
end

function KombatStats.SlashCmdHandler(cmd)
	
	if cmd == "show" then 
		self.settings.showButton = true
		self:ShowDPS() 
	elseif cmd == "hide" then
		self.settings.showButton = false
		self:HideDPS()
	elseif cmd == "stats" then
		self:ToggleFrame(KombatStatsFrame)
	elseif cmd == "stop" then
		self:OnDisable()
	elseif cmd == "start" then
		self:OnEnable()
	else
		self:ShowSlashHelp()
	end

end

function KombatStats:ShowSlashHelp()

	for i, v in self.loc.SLASH_HELPS do
		DEFAULT_CHAT_FRAME:AddMessage(v)
	end

end

function KombatStats.OnCombatEvent(event, info)

	if info.type ~= "hit" and info.type ~= "heal"	and info.type ~= "miss" then	return 	end
	
	local petName = UnitName("pet")
	local name
	
	if info.type == "hit" and info.skill ~= ParserLib_MELEE and info.skill ~= ParserLib_DAMAGESHIELD then
		self:SetSkillElement(info.skill, info.element)	
	end
	
	if info.source == ParserLib_SELF or info.source == petName then	
		local category
		if info.type ~= "heal" then category = "attack" else category = "heal" end
		
		if info.source == ParserLib_SELF then name = playerName else name = petName end
		self:AddStats(name, category, info)
		self:AddDPS(name, category, info.amount)

	end
	
	
	if info.victim == ParserLib_SELF or info.victim == petName then
		if info.type ~= "heal" then
		
			if info.victim == ParserLib_SELF then name = playerName else name = petName end
			
			self:AddStats(name, "defend", info)
			self:AddDPS(name, "defend", info.amount)
		end
	end
	
	self:Update()

end


function KombatStats:SetSkillElement(skill, element)

	element = self:GetElementType(element)
	
	if self.skills[skill] and self.skills[skill] ~= element then
		self:Debug(string.format("%s was %s, now is %s.", skill, self.skills[skill], element or "nil") )
	end
	
	self.skills[skill] = element
end

function KombatStats:GetSkillElement(skill)
	if self.skills[skill] then
		return self:GetElementString(self.skills[skill])
	end
	-- return nil
end

function KombatStats:GetElementType(element)
	if not element then return "physical"
	elseif element == SPELL_SCHOOL0_CAP then return "physical"
	elseif element == SPELL_SCHOOL1_CAP then return "holy"
	elseif element == SPELL_SCHOOL2_CAP then return "fire"
	elseif element == SPELL_SCHOOL3_CAP then return "nature"
	elseif element == SPELL_SCHOOL4_CAP then return "frost"
	elseif element == SPELL_SCHOOL5_CAP then return "shadow"
	elseif element == SPELL_SCHOOL6_CAP then return "arcane"
	else 
		self:Debug("Unknown element type " .. element)
	end
end

function KombatStats:GetElementString(element)
	if not element then return SPELL_SCHOOL0_CAP
	elseif element == "physical" then return SPELL_SCHOOL0_CAP
	elseif element == "holy" then return SPELL_SCHOOL1_CAP
	elseif element == "fire" then return SPELL_SCHOOL2_CAP
	elseif element == "nature" then return SPELL_SCHOOL3_CAP
	elseif element == "frost" then return SPELL_SCHOOL4_CAP
	elseif element == "shadow" then return SPELL_SCHOOL5_CAP
	elseif element == "arcane" then return SPELL_SCHOOL6_CAP
	else 
		self:Debug("Unknown element type " .. element)
	end	
end

-----------------------------
---------- Stats------------
-----------------------------

-- Get an empty stats table, the values filled with 0.
function KombatStats:AcquireNewStats()

	if self.emptyStats and table.getn(self.emptyStats) > 0 then
		return table.remove(self.emptyStats)
	else return {
		hit = {
			count = 0,
			minimum = 0,
			maximum = 0,
			total = 0,
		},
		crit = {
			count = 0,
			minimum = 0,
			maximum = 0,
			total = 0,
		},
		dot = {
			count = 0,
			minimum = 0,
			maximum = 0,
			total = 0,
		},
		miss = 0,
		dodge  = 0,
		parry = 0,
		deflect = 0,
		resist = 0,
		block = 0,
	}
	end

end


-- Reclaim the stats table, return count of table reclaimed.
function KombatStats:ReclaimStats(stats, depth)

	-- Validity check.
	if not stats or type(stats) ~= "table" then return end
		
	if depth and depth > 0 then	-- Recurse.
	
		local count = 0
		for i, v in stats do
			count = count + self:ReclaimStats(v, depth-1)
		end
		return count
		
	else	-- This should be the stats table.
	
		-- Validity check.
		if not stats.dodge then return 0 end
		
		for i in stats do
			if type(stats[i]) == "table" then 
				for j in stats[i] do
					stats[i][j] = 0
				end
			else
				stats[i] = 0
			end			
		end		
		if not self.emptyStats then self.emptyStats = {} end		
		table.insert(self.emptyStats, stats)
		return 1
		
	end
	
end


function KombatStats:ExistStats(dataset, name, category, skill)
	if not self.stats[dataset][name] 
	or not self.stats[dataset][name][category] 
	or not self.stats[dataset][name][category][skill] then
		return false
	end	
	return true
end


function KombatStats:GetStats(dataset, name, category, skill)

	if not self.stats[dataset][name] then
		local t = compost:Acquire()
		t.attack = {}
		t.defend = {}
		t.heal = {}		
		self.stats[dataset][name] = t	
	end
	
	if not self.stats[dataset][name][category][skill] then
		self.stats[dataset][name][category][skill] = self:AcquireNewStats()
	end
	
	return self.stats[dataset][name][category][skill]
end

function KombatStats:AddStats(name, category, info)

	local skill

	if category == "defend" and info.skill ~= ParserLib_MELEE and info.skill ~= ParserLib_DAMAGESHIELD then
	
		skill = self:GetSkillElement(info.skill)
		if not skill then return end
		
		if info.element and skill ~= info.element then -- This is quite impossible.
			self:Debug(string.format("%s is %s but got %s in database.", info.skill, info.element or 'nil', skill))
		end
	else	
		if info.skill == ParserLib_MELEE then 
			if name == playerName and category == "attack" and self.canShapeshift then
				skill = self:GetShapeshiftID()
			else
				skill = 0 
			end
		elseif info.skill == ParserLib_DAMAGESHIELD then
			skill = self.loc.SKILL_DAMAGE_SHIELD
		else
			skill = info.skill		
		end
	end
	
	
	-- If this never did any damage, it might be a debuff, ignore it.
	if info.type == "miss" and not ( 
		self:ExistStats("last", name, category, skill) or self:ExistStats("all", name, category, skill) 
	) then return end
	

	-- Did a simple check that CB, GB should appear on melee attacks only.
	if info.skill ~= ParserLib_MELEE and ( info.isGlancing or info.isCrushing ) then
		self:Debug("Crushing/Glancing blow appeared on non-melee attacks!")
	end

	local lastStats = self:GetStats("last", name, category, skill)
	local sessionStats = self:GetStats("session", name, category, skill)
	local allStats = self:GetStats("all", name, category, skill)

	if info.amount then	-- Hit

		-- partial block is a block.
		if info.amountBlock then
			lastStats.block = lastStats.block + 1	
			sessionStats.block = sessionStats.block + 1	
			allStats.block = allStats.block + 1	
		end
		
		if self.settings.skipAbsorb and info.amountAbsorb then return end
		if self.settings.skipResist and info.amountResist then return end
		if self.settings.skipBlock and info.amountBlock then return end
		if self.settings.skipVulnerable and info.amountVulnerable then return end	
	
		local hitType		
		
		if info.isCrit then 
			hitType = "crit" 
		elseif info.isDOT then 
			hitType = "dot" 
		else 
			if info.skill == ParserLib_MELEE and ( info.isGlancing or info.isCrushing ) then
				hitType = "dot"	-- use DOT field to record GB / CB.
			else
				hitType = "hit" 
			end
		end	
		
		lastStats[hitType].count = lastStats[hitType].count + 1
		sessionStats[hitType].count = sessionStats[hitType].count + 1
		allStats[hitType].count = allStats[hitType].count + 1
		
		if lastStats[hitType].minimum == 0 or ( info.amount > 0 and lastStats[hitType].minimum > info.amount ) then
			lastStats[hitType].minimum = info.amount
		end
		if sessionStats[hitType].minimum == 0 or ( info.amount > 0 and sessionStats[hitType].minimum > info.amount ) then
			sessionStats[hitType].minimum = info.amount
		end
		if allStats[hitType].minimum == 0 or ( info.amount > 0 and allStats[hitType].minimum > info.amount ) then
			allStats[hitType].minimum = info.amount
		end
		
		if lastStats[hitType].maximum < info.amount then
			lastStats[hitType].maximum = info.amount
		end
		if sessionStats[hitType].maximum < info.amount then
			sessionStats[hitType].maximum = info.amount
		end
		if allStats[hitType].maximum < info.amount then
			allStats[hitType].maximum = info.amount
		end
		
		lastStats[hitType].total = lastStats[hitType].total + info.amount
		sessionStats[hitType].total = sessionStats[hitType].total + info.amount
		allStats[hitType].total = allStats[hitType].total + info.amount
	
	else	-- Miss
	
		-- These are not recorded.
		if info.missType == "immune" or info.missType == "evade" or info.missType == "reflect" or info.missType == "absorb" then 
			return end
			
		lastStats[info.missType] = lastStats[info.missType] + 1	
		sessionStats[info.missType] = sessionStats[info.missType] + 1	
		allStats[info.missType] = allStats[info.missType] + 1	
	
	end
	
	self:StatsFrame_Refresh()
	

end

function KombatStats:GetShapeshiftID()
	local size, name, active;
	size = GetNumShapeshiftForms();
	for i=1, size, 1 do
		_, name, active = GetShapeshiftFormInfo(i);
		if active then return i end
	end
	return 0;
end


function KombatStats:GetShapeshiftName(id)

	if id == 0 or not id then return "" end
	
	local _, name = GetShapeshiftFormInfo(id)
	if name then return " (" .. name .. ")" end
	
	return ""
end

function KombatStats:AddLastFightData()
	
	local from = self.stats.last	
	local datasets = compost:Acquire()
	table.insert(datasets, "session")
	table.insert(datasets, "all")
	local stats
	for i, dataset in datasets do
		for name in from do
			for category in from[name] do
				for skill in from[name][category] do
					for key, value in from[name][category][skill] do
						local stats = self:GetStats(dataset, name, category, skill)
						
						if type(value) == "number" then
							stats[key] = stats[key] + value							
						else -- table
							stats[key].count = stats[key].count + value.count
							stats[key].total = stats[key].total + value.total
							if stats[key].minimum == 0 or ( stats[key].minimum > value.minimum and value.minimum > 0 ) then stats[key].minimum = value.minimum end
							if stats[key].maximum < value.maximum then stats[key].maximum = value.maximum end
						end
					end
				end
			end
		end
	end
	compost:Reclaim(datasets)
end

function KombatStats:GetTotalDamage(dataset, char, category)

	local total = 0

	if not self.stats[dataset][char] or not self.stats[dataset][char][category] then return 0 end

	for i, stats in self.stats[dataset][char][category] do
		total = total + stats.hit.total + stats.crit.total + stats.dot.total
	end
	
	return total
	
end


function KombatStats:GetTotal(dataset, char, category)
	
	local result = self:AcquireNewStats()

	if not self.stats[dataset][char] or not self.stats[dataset][char][category] then return result end
	
	for skill, stats in self.stats[dataset][char][category] do

		for key, value in stats do
			if type(value) == "number" then
			
				result[key] = result[key] + value							
				
			else -- table
			
				if key == "dot" and type(skill) == "number" then	 -- melee
					result.hit.count = result.hit.count + value.count
					result.hit.total = result.hit.total + value.total
					if result.hit.minimum == 0 or ( result.hit.minimum > value.minimum and value.minimum > 0 ) then result.hit.minimum = value.minimum end
					if result.hit.maximum < value.maximum then result.hit.maximum = value.maximum end
				else
					result[key].count = result[key].count + value.count
					result[key].total = result[key].total + value.total
					if result[key].minimum == 0 or ( result[key].minimum > value.minimum and value.minimum > 0 ) then result[key].minimum = value.minimum end
					if result[key].maximum < value.maximum then result[key].maximum = value.maximum end
				end
			end
		end

	end
	
	return result

end

-----------------------------
---------- DPS ------------
-----------------------------
function KombatStats:AcquireNewDPS()
	if self.emptyDPS and table.getn(self.emptyDPS) > 0 then
		return table.remove(self.emptyDPS)
	else
		return {
			duration = 0,
			attack = 0,
			defend = 0,
			heal = 0,
		}
	end
end

function KombatStats:ReclaimDPS(dpsStats, depth)

	-- Validity check.
	if not dpsStats or type(dpsStats) ~= "table" then return end
		
	if depth and depth > 0 then	-- Recurse.
	
		local count = 0
		for i, v in dpsStats do
			count = count + self:ReclaimStats(v, depth-1)
		end
		return count
		
	else	-- This should be the stats table.
	
		-- Validity check.
		if not dpsStats.duration then return 0 end
		
		for i in dpsStats do
			dpsStats[i] = 0
		end
			
		if not self.emptyDPS then self.emptyDPS = {} end		
		table.insert(self.emptyDPS, dpsStats)
		return 1
		
	end
end

function KombatStats:StartCombat()

	-- Clear last fight data.
	self:ReclaimStats(self.stats.last, 3)	
	compost:Reclaim(self.stats.last, 2)
	self.stats.last = compost:Acquire()

	self:ReclaimDPS(self.dps.last, 1)	
	compost:Reclaim(self.dps.last)
	self.dps.last = compost:Acquire()

	self.vars.inCombat = true
	self.vars.combatTime = GetTime()
	
end

function KombatStats:EndCombat()
	self:AddLastFightDPS()
	self.vars.inCombat = false
end


function KombatStats:GetDPS(dataset, char, category)
	if not self.dps[dataset][char] then return 0 end
	
	local duration = self:GetDuration(dataset, char)
	if duration < 1 then duration = 1 end
	return tonumber(string.format("%.1f",self.dps[dataset][char][category] / duration))
	
end



function KombatStats:GetDuration(dataset, char)
	if not self.dps[dataset][char] then return 0 end
	return self.dps[dataset][char].duration
end

function KombatStats:GetAmount(dataset, char, category)
	if not self.dps[dataset][char] then return 0 end
	return self.dps[dataset][char][category]
end

function KombatStats:AddDPS(char, category, amount)
	if not self.vars.inCombat then return end

	if not amount then amount = 0 end
	
	if not self.dps.last[char] then
		self.dps.last[char] = self:AcquireNewDPS()
	end
	
	self.dps.last[char][category] = self.dps.last[char][category] + amount
	self.dps.last[char].duration = GetTime() - self.vars.combatTime
	
end

function KombatStats:AddLastFightDPS()
	
	local from = self.dps.last	
	local datasets = compost:Acquire()
	table.insert(datasets, "session")
	table.insert(datasets, "all")

	for i, dataset in datasets do
		for name in self.dps.last do
			if not self.dps[dataset][name] then self.dps[dataset][name] = self:AcquireNewDPS() end
			for j in self.dps.last[name] do
				self.dps[dataset][name][j] = self.dps[dataset][name][j] + self.dps.last[name][j]
			end
		end
	end

	compost:Reclaim(datasets)	
end

function KombatStats:PurgeDPS(name)
	
	if self.dps.all[name] then
		self:ReclaimDPS(self.dps.all[name])
		self.dps.all[name] = nil
	end
	if self.dps.session[name] then
		self:ReclaimDPS(self.dps.session[name])
		self.dps.session[name] = nil
	end
	if self.dps.last[name] then
		self:ReclaimDPS(self.dps.last[name])
		self.dps.last[name] = nil
	end
	
	if self.currentChar == name then
		self.currentChar = nil
	end

end



------------------------------------------------
-- Methods shared by KombatStatsFu
------------------------------------------------
-- the "self" in these methods might be KombatStats or KombatStatsFu, remember to handle it carefully.



function KombatStats:GetText()
	
	local ks = KombatStats
		
	if not ks.settings.disabled then
		
		local label, text, petLabel, petText
		
		if ks.settings.hideLabel then
			label = ""
			petLabel = ""
		else
			label = ks.loc.LABEL_DPS
			petLabel = ks.loc.LABEL_PET
		end

		text = ""
		local name = UnitName("player")
		local pet = UnitName("pet")

		local dps
		
		local duration
		
		if ks.settings.showDPS then 
			if ks.settings.mergeDPS and pet then
				
				local petDuration = ks:GetDuration("last", pet)				
				duration = ks:GetDuration("last", name)
				if duration < petDuration then duration = petDuration end
				if duration < 1 then duration = 1 end			
			
				dps = ( ks:GetAmount("last", name, "attack") + ks:GetAmount("last", pet, "attack") ) / duration
				dps = string.format("%.1f", dps)
			else
				dps = ks:GetDPS("last", name, "attack")
			end
			text = text .. "/" .. ks:Colorize(ks.colors.attack, dps) 
		end
		
		if ks.settings.showDTPS then 
			if ks.settings.mergeDPS and pet then
				dps = ( ks:GetAmount("last", name, "defend") + ks:GetAmount("last", pet, "defend") ) / duration
				dps = string.format("%.1f", dps)
			else
				dps = ks:GetDPS("last", name, "defend")
			end
			text = text .. "/" .. ks:Colorize(ks.colors.defend, dps) 
		end

		if ks.settings.showHPS then 
			if ks.settings.mergeDPS and pet then
				dps = ( ks:GetAmount("last", name, "heal") + ks:GetAmount("last", pet, "heal") ) / ks:GetDuration("last", name)
				dps = string.format("%.1f", dps)
			else
				dps = ks:GetDPS("last", name, "heal")
			end
			text = text .. "/" .. ks:Colorize(ks.colors.heal, dps) 
		end

		if string.sub(text, 1, 1) == "/" then text = string.sub(text, 2) end
		if text == "" then label = "" end


		petText = ""
		if pet or not ks.settings.autoHidePet then
			if ks.settings.showPetDPS then petText = petText .. "/" .. ks:Colorize(ks.colors.attack, ks:GetDPS("last", pet, "attack")) end
			if ks.settings.showPetDTPS then petText = petText .. "/" .. ks:Colorize(ks.colors.defend, ks:GetDPS("last", pet, "defend")) end
			if ks.settings.showPetHPS then petText = petText .. "/" .. ks:Colorize(ks.colors.heal, ks:GetDPS("last", pet, "heal")) end
			if string.sub(petText, 1, 1) == "/" then petText = string.sub(petText, 2) end		
		end
	 	if petText == "" then petLabel = "" end
		
		-- Do not turn everything off!
		if text == "" and label == "" and petText == "" and petLabel == "" then
			label = ks.loc.LABEL_DPS
		end
			
		local t = compost:Acquire()
		table.insert(t, label)
		table.insert(t, text)
		table.insert(t, petLabel)
		table.insert(t, petText)
		
		local result = table.concat(t, " ")
		--button:SetText( table.concat(t, " ") )		
		compost:Reclaim(t)
		return result
		
	else	-- KombatStats is disabled.
	
		return ks.loc.PAUSED
		--button:SetText( "|cff9d9d9d" .. ks.loc.PAUSED .. "|r" )
	
	end
		
	
end
function KombatStats:UpdateText()

	local ks = KombatStats

	local button;
	if self == ks then
		-- If this is called from KombatStats, do nothing when DPS frame is not shown.
		if not ( self.dpsButton and self.dpsButton:IsShown() ) then return end			
		self:UpdateButtonWidth()
		button = self.dpsButton
	else
		button = self
	end
	
	button:SetText( ks:GetText() )
	
end

function KombatStats:UpdateTooltip()
	
	local ks = KombatStats;
	
	if not ks.currentChar then	ks.currentChar = UnitName("player") end
			
	local name = ks.currentChar
	
	tablet:SetTitle(name)
	tablet:SetHint(ks.loc.TOOLTIP_HINT)

	
	local cat
	for dataset in ks.dps do
		cat = tablet:AddCategory(
			'columns', 3,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0,
			'text', ks.loc[dataset],
			'text2', string.format("%ds", ks:GetDuration(dataset, name)),
			'text3', ks.loc.TOTAL
		);
		
		cat:AddLine()

		cat:AddLine(
			'text', ks.loc.DPS,
			'text2', ks:GetDPS(dataset, name, "attack"),
			'text3', ks:GetAmount(dataset, name, "attack")
		)
		cat:AddLine(
			'text', ks.loc.DTPS,
			'text2', ks:GetDPS(dataset, name, "defend"),
			'text3', ks:GetAmount(dataset, name, "defend")
		)
		cat:AddLine(
			'text', ks.loc.HPS,
			'text2', ks:GetDPS(dataset, name, "heal"),
			'text3', ks:GetAmount(dataset, name, "heal")
		)
		
		cat:AddLine()
		
	end
		
end
	
function KombatStats:ToggleOption(option)
	KombatStats.settings[option] = not KombatStats.settings[option]
	
	if option == "disabled" then
		if KombatStats.settings.disabled then
			KombatStats:OnDisable()
		else
			KombatStats:OnEnable()
		end
	end
		
	self:UpdateText()

	
end

function KombatStats:MenuSettings(level, value)
	
	local ks = KombatStats;

	if level == 1 then

		dewdrop:AddLine(
			'text', ks.loc.MENU_PAUSE,
			'tooltipTitle', ks.loc.MENU_PAUSE,
			'tooltipText', ks.loc.TOOLTIP_PAUSE,
			'arg1', self,
			'arg2', 'disabled',
			'func', 'ToggleOption',
			'checked', KombatStats.settings.disabled
		);
		
		dewdrop:AddLine(
			'text', ks.loc.MENU_LOCK,
			'tooltipTitle', ks.loc.MENU_LOCK,
			'tooltipText', ks.loc.TOOLTIP_LOCK,
			'arg1', self,
			'arg2', 'lockFrame',
			'func', 'ToggleOption',
			'checked', KombatStats.settings.lockFrame
		);
		
		dewdrop:AddLine(
			'text', ks.loc.MENU_SCALE,
			'tooltipTitle', ks.loc.MENU_SCALE,
			'tooltipText', ks.loc.TOOLTIP_SCALE,
			'hasArrow', true,
			'hasSlider', true,
			'sliderTop', ks.MAX_SCALE * 100 .. '%',
			'sliderBottom', ks.MIN_SCALE * 100 .. '%',
			'sliderValue', ks.settings.frameScale,
			'sliderFunc', function(value)
				ks.settings.frameScale = value
				ks:UpdateScale()
				return string.format("%d%%", ks:GetCurrentScale() * 100 )
			end
		);
		
		dewdrop:AddLine();		
		
		dewdrop:AddLine(
			'text', ks.loc.DPS,
			'isTitle', true
		);
		
		dewdrop:AddLine(
			'text', ks.loc.MENU_TEXT_SHOW,
			'tooltipTitle', ks.loc.MENU_TEXT_SHOW,
			'tooltipText', ks.loc.TOOLTIP_TEXT_SHOW,
			'hasArrow', true,
			'value', 'dps_frame'
		)

		dewdrop:AddLine(
			'text', ks.loc.MENU_TOOLTIP_SHOW,
			'tooltipTitle', ks.loc.MENU_TOOLTIP_SHOW,
			'tooltipText', ks.loc.TOOLTIP_TOOLTIP_SHOW,
			'hasArrow', true,
			'value', 'character'
		)

		dewdrop:AddLine(
			'text', ks.loc.MENU_MERGE_DPS,
			'tooltipTitle', ks.loc.MENU_MERGE_DPS,
			'tooltipText', ks.loc.TOOLTIP_MERGE_DPS,
			'arg1', self,
			'arg2', 'mergeDPS',
			'func', 'ToggleOption',
			'checked', KombatStats.settings.mergeDPS
		)

		dewdrop:AddLine(
			'text', ks.loc.MENU_AUTO_HIDE_PET,
			'tooltipTitle', ks.loc.MENU_AUTO_HIDE_PET,
			'tooltipText', ks.loc.TOOLTIP_AUTO_HIDE_PET,
			'arg1', self,
			'arg2', 'autoHidePet',
			'func', 'ToggleOption',
			'checked', KombatStats.settings.autoHidePet
		)
		
		
		dewdrop:AddLine(
			'text', ks.loc.MENU_HIDE_LABEL,
			'tooltipTitle', ks.loc.MENU_HIDE_LABEL,
			'tooltipText', ks.loc.TOOLTIP_HIDE_LABEL,
			'arg1', self,
			'arg2', 'hideLabel',
			'func', 'ToggleOption',
			'checked', ks.settings.hideLabel
		);
		
		if ks.settings.buttonWidth then
		
			dewdrop:AddLine(
				'text', ks.loc.MENU_CONSTANT_WIDTH,
				'tooltipTitle', ks.loc.MENU_CONSTANT_WIDTH,
				'tooltipText', ks.loc.TOOLTIP_CONSTANT_WIDTH,
				'func', function() 
						ks.settings.buttonWidth = nil
						self:Update() 
					end,
				'checked', true,
				'hasArrow', true, 	
				'hasSlider', true,
				'sliderTop', ks.MAX_WIDTH,
				'sliderBottom', ks.MIN_WIDTH,
				'sliderValue', ( ks.settings.buttonWidth - ks.MIN_WIDTH ) / (ks.MAX_WIDTH - ks.MIN_WIDTH),
				'sliderFunc', function(value)
					ks.settings.buttonWidth = value * (ks.MAX_WIDTH - ks.MIN_WIDTH) + ks.MIN_WIDTH
					ks:UpdateButtonWidth()
					return ks.settings.buttonWidth
				end
			);
			
			
			
		else

			dewdrop:AddLine(
				'text', ks.loc.MENU_CONSTANT_WIDTH,
				'tooltipTitle', ks.loc.MENU_CONSTANT_WIDTH,
				'tooltipText', ks.loc.TOOLTIP_CONSTANT_WIDTH,
				'func', function() 
						ks.settings.buttonWidth = ks.DEFAULT_BUTTON_WIDTH 
						self:Update() 
					end
			);
		
		end

		
	
		dewdrop:AddLine(
			'text', ks.loc.MENU_CLEAR_DPS,
			'tooltipTitle', ks.loc.MENU_CLEAR_DPS,
			'tooltipText', ks.loc.TOOLTIP_CLEAR_DPS,
			'hasArrow', true,
			'value', 'clearDPS'
		);
		
		dewdrop:AddLine()
		
		dewdrop:AddLine(
			'text', ks.loc.STATS,
			'isTitle', true
		);



		dewdrop:AddLine(
			'text',  ks.loc.MENU_STATS_SKIP_ABSORB,
			'tooltipTitle', ks.loc.MENU_STATS_SKIP_ABSORB,
			'tooltipText', ks.loc.TOOLTIP_STATS_SKIP_ABSORB,
			'func', 'ToggleOption',
			'arg1', self,
			'arg2', 'skipAbsorb',
			'checked',  ks.settings.skipAbsorb
		)
		dewdrop:AddLine(
			'text',  ks.loc.MENU_STATS_SKIP_RESIST,
			'tooltipTitle', ks.loc.MENU_STATS_SKIP_RESIST,
			'tooltipText', ks.loc.TOOLTIP_STATS_SKIP_RESIST,
			'func', 'ToggleOption',
			'arg1', self,
			'arg2', 'skipResist',
			'checked',  ks.settings.skipResist
		)
		dewdrop:AddLine(
			'text',  ks.loc.MENU_STATS_SKIP_BLOCK,
			'tooltipTitle', ks.loc.MENU_STATS_SKIP_BLOCK,
			'tooltipText', ks.loc.TOOLTIP_STATS_SKIP_BLOCK,
			'func', 'ToggleOption',
			'arg1', self,
			'arg2', 'skipBlock',
			'checked',  ks.settings.skipBlock
		)
		dewdrop:AddLine(
			'text',  ks.loc.MENU_STATS_SKIP_VULNERABLE,
			'tooltipTitle', ks.loc.MENU_STATS_SKIP_VULNERABLE,
			'tooltipText', ks.loc.TOOLTIP_STATS_SKIP_VULNERABLE,
			'func', 'ToggleOption',
			'arg1', self,
			'arg2', 'skipVulnerable',
			'checked',  ks.settings.skipVulnerable
		)
					

	elseif level == 2 then
	
		if value == 'dps_frame' then

			dewdrop:AddLine(
				'text', ks.loc.PLAYER_DPS,
				'arg1', self,
				'arg2', 'showDPS',
				'func', 'ToggleOption',
				'checked', KombatStats.settings.showDPS
			);
			dewdrop:AddLine(
				'text', ks.loc.PLAYER_DTPS,
				'arg1', self,
				'arg2', 'showDTPS',
				'func', 'ToggleOption',
				'checked', KombatStats.settings.showDTPS
			);
			dewdrop:AddLine(
				'text', ks.loc.PLAYER_HPS,
				'arg1', self,
				'arg2', 'showHPS',
				'func', 'ToggleOption',
				'checked', KombatStats.settings.showHPS
			);

			dewdrop:AddLine(
				'text', ks.loc.PET_DPS,
				'arg1', self,
				'arg2', 'showPetDPS',
				'func', 'ToggleOption',
				'checked',  ks.settings.showPetDPS
			);
			dewdrop:AddLine(
				'text', ks.loc.PET_DTPS,
				'arg1', self,
				'arg2', 'showPetDTPS',
				'func', 'ToggleOption',
				'checked',  ks.settings.showPetDTPS
			);
			dewdrop:AddLine(
				'text', ks.loc.PET_HPS,
				'arg1', self,
				'arg2', 'showPetHPS',
				'func', 'ToggleOption',
				'checked',  ks.settings.showPetHPS
			);
		elseif value == 'character' then
			if  ks.dps.all then
				for name in  ks.dps.all do
					dewdrop:AddLine(
						'text', name,
						'func', function(name)  ks.currentChar = name end,
						'arg1', name,
						'closeWhenClicked', true
					)
				end
			end	
		elseif value == 'clearDPS' then
			if  ks.dps.all then
				for name in  ks.dps.all do
					dewdrop:AddLine(
						'text', name,
						'func', function(name) ks:PurgeDPS(name) end,
						'arg1', name,
						'closeWhenClicked', true
					)
				end
			end					
		end
		
		

	
	end

end


-----------------------------
------------ UI ------------
-----------------------------


function KombatStats:ShowDPS()
	if not self.dpsButton then
	
		if not self.settings.dpsButtonOffsetX then self.settings.dpsButtonOffsetX = GetScreenWidth() / 2 end
		if not self.settings.dpsButtonOffsetY then self.settings.dpsButtonOffsetY = - GetScreenHeight() / 2 end
		
		local f = CreateFrame("Button", nil, UIParent)
		
		f:SetFrameStrata("DIALOG")
		f:SetHeight(24)
		f:SetWidth( self:GetButtonWidth() )
		f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", self.settings.dpsButtonOffsetX,self.settings.dpsButtonOffsetY)
		
		f:SetFont("Fonts\\FRIZQT__.TTF",11)
		f:SetBackdrop({
			bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize=16, tileSize=16, tile=true,
			insets={left=5, right=5, top=5, bottom=5}
		})
		
		f:SetBackdropColor(0,0,0,1)
		f:SetClampedToScreen(true)
		f:SetMovable(true)
		f:RegisterForDrag("LeftButton")
		f:SetScript("OnDragStart", 
			function() 
				if not self.settings.lockFrame then
					this:StartMoving()
					this.isMoving = true
				end
			end
		)
		f:SetScript("OnDragStop", 
			function() 
				if not self.settings.lockFrame then				
					this:StopMovingOrSizing()
					this.isMoving = false
					_, _, _, self.settings.dpsButtonOffsetX, self.settings.dpsButtonOffsetY = f:GetPoint()
				end
			end
		)
		f:SetScript("OnClick", 
			function() 
				KombatStats:ToggleFrame(KombatStatsFrame) 
			end		
		)
		
		dewdrop:Register(f,
			'children', function(level, value) self:MenuSettings(level, value) end
		)
			
		tablet:Register(f,
			'children', function() self:UpdateTooltip() end,
			'point', function(parent) return "TOPLEFT", "BOTTOMLEFT" end
		)
		

		self.dpsButton = f
		
		self:UpdateScale()
	end
	
	self.dpsButton:Show()
	self:Update()

end

function KombatStats:HideDPS()
	if self.dpsButton then
		self.dpsButton:Hide()
	end
end

function KombatStats:Update()
	if self.dpsButton then 
		self:UpdateText()
		tablet:Refresh(self.dpsButton) 
	end
	self:StatsFrame_Refresh()
end

function KombatStats:GetCurrentScale()
	return self.settings.frameScale * ( self.MAX_SCALE - self.MIN_SCALE ) + self.MIN_SCALE 
end

function KombatStats:UpdateScale()

	if not self.settings.frameScale then return end
	
	local scale = self.settings.frameScale * (self.MAX_SCALE - self.MIN_SCALE) + self.MIN_SCALE
	
	KombatStatsFrame:SetScale(scale)
	if self.dpsButton then
		self.dpsButton:SetScale(scale)
	end
	
end

function KombatStats:GetButtonWidth()
	if self.settings.buttonWidth then return self.settings.buttonWidth end
	if self.settings.disabled then return 60 end
	
	local count = 0
	if self.settings.showDPS then count = count + 1 end
	if self.settings.showDTPS then count = count + 1 end
	if self.settings.showHPS then count = count + 1 end
	
	if UnitName("pet") or not self.settings.autoHidePet then
		if self.settings.showPetDPS then count = count + 1 end
		if self.settings.showPetDTPS then count = count + 1 end
		if self.settings.showPetHPS then count = count + 1 end
	end
	
	if not self.settings.hideLabel then count = count + 1 end
	if count == 0 then count = 1 end
	return count * 40
end

function KombatStats:UpdateButtonWidth()
	if self.dpsButton then
		self.dpsButton:SetWidth( self:GetButtonWidth() )
	end
end
function KombatStats:StatsFrame_OnShow()

	if not this.localized then
		KombatStatsFrameCountTitle:SetText(self.loc.COUNT)
		KombatStatsFrameCountPercent:SetText(self.loc.PERCENT)
		KombatStatsFrameMinTitle:SetText(self.loc.MINIMUM)
		KombatStatsFrameAvgTitle:SetText(self.loc.AVERAGE)
		KombatStatsFrameMaxTitle:SetText(self.loc.MAXIMUM)
		KombatStatsFrameTotalTitle:SetText(self.loc.TOTAL)
		KombatStatsFrameTotalPercent:SetText(self.loc.PERCENT)
		KombatStatsFrameHitTitle:SetText(self.loc.HIT)
		KombatStatsFrameCritTitle:SetText(self.loc.CRIT)
		KombatStatsFrameDOTTitle:SetText(self.loc.DOT)
		KombatStatsFrameCountTitle1:SetText(self.loc.COUNT)
		KombatStatsFramePercentTitle1:SetText(self.loc.PERCENT)
		KombatStatsFrameCountTitle2:SetText(self.loc.COUNT)
		KombatStatsFramePercentTitle2:SetText(self.loc.PERCENT)
		KombatStatsFrameMissTitle:SetText(self.loc.MISS)
		KombatStatsFrameDodgeTitle:SetText(self.loc.DODGE)
		KombatStatsFrameParryTitle:SetText(self.loc.PARRY)
		KombatStatsFrameBlockTitle:SetText(self.loc.BLOCK)
		KombatStatsFrameDeflectTitle:SetText(self.loc.DEFLECT)
		KombatStatsFrameResistTitle:SetText(self.loc.RESIST)

		KombatStatsDatasetText:SetText(self.loc[ui.currDataset]);	


		this.localized = true
	end
	
	if not ui.currChar then 
		ui.currChar = UnitName("player");
	end
	
	if not ui.currSkill then
		ui.currSkill = self.loc.SKILL_TOTAL
	end

	KombatStatsCharText:SetText(ui.currChar);
	KombatStatsSkillText:SetText(ui.currSkill);
	
	KombatStats:StatsFrame_Refresh()
	
end

function KombatStats:StatsFrame_OnHide()
	if dewdrop:IsOpen(KombatStatsFrameCharButton) then
		dewdrop:Close()
	end
	
	if dewdrop:IsOpen(KombatStatsFrameSkillButton) then
		dewdrop:Close()
	end
	
end
function KombatStats:StatsFrame_Refresh()

	if not KombatStatsFrame:IsShown() then return end
	
	local isMelee
	
	if type(ui.currSkill) == "number" then isMelee = true end
	
	local countTotal, damageTotal, damageTotalPercent, toHit,
		hitAverage, critAverage, dotAverage,
		hitRatio, critRatio, hitDmgRatio, critDmgRatio, dotDmgRatio,
		missRatio, dodgeRatio, blockRatio, parryRatio, deflectRatio, resistRatio;
	
	local attack;

	if ui.currSkill == self.loc.SKILL_TOTAL then
		attack = self:GetTotal(ui.currDataset, ui.currChar, ui.currCategory)
	else	
		if not self:ExistStats(ui.currDataset, ui.currChar, ui.currCategory, ui.currSkill ) then 
			KombatStats:StatsFrame_Clear() 
			return 
		else
			attack = self:GetStats(ui.currDataset, ui.currChar, ui.currCategory, ui.currSkill)
		end
	end

	-- Attack's total count.
	countTotal = attack.hit.count + attack.crit.count + attack.dodge + attack.parry + attack.block + attack.deflect + attack.resist + attack.miss
	toHit = attack.hit.count + attack.crit.count
	if isMelee then
		toHit = toHit + attack.dot.count
		countTotal = countTotal + attack.dot.count
	end
	
	toHit = 100 * toHit / countTotal
	
	-- Attack's total damage.
	damageTotal = attack.hit.total + attack.crit.total + attack.dot.total;
		
	-- Attack's % of damgae over all attacks.
	if ui.currSkill == self.loc.SKILL_TOTAL then
		damageTotalPercent = 100;
	else
		damageTotalPercent = -- string.format(
--			"%d%%",
			100 * damageTotal / self:GetTotalDamage(ui.currDataset, ui.currChar, ui.currCategory)
--		)
	end
	
	
	KombatStatsFrameSummaryText:SetText(
		string.format(
			self.loc.SUMMARY,
			countTotal,
			toHit,
			damageTotal,
			damageTotalPercent
		)
	)
		
	-- Set to 1 to prevent divide by zero in the calculations below.
	if countTotal == 0 then
		countTotal = 1;
	end

	-- Hit count.
	hitRatio = string.format("%d%%", 100 * attack.hit.count / countTotal );
	KombatStatsFrameHitCountPercent:SetText( hitRatio );
	KombatStatsFrameHitCount:SetText( attack.hit.count );
		
	-- Hit total.
	hitDmgRatio = string.format("%d%%", 100 * attack.hit.total / damageTotal );
	KombatStatsFrameHitTotalPercent:SetText( hitDmgRatio );
	KombatStatsFrameHitTotal:SetText( attack.hit.total );
	
	KombatStatsFrameHitMin:SetText( attack.hit.minimum );	
	KombatStatsFrameHitMax:SetText( attack.hit.maximum );
	
	-- Hit average.
	if attack.hit.count == 0 then
		hitAverage = 0;
	else
		hitAverage = string.format("%d", attack.hit.total / attack.hit.count );
	end
	
	KombatStatsFrameHitAvg:SetText( hitAverage );
	

	-- crit count
	critRatio = string.format("%d%%", 100 * attack.crit.count / countTotal );
	KombatStatsFrameCritCountPercent:SetText( critRatio );
	KombatStatsFrameCritCount:SetText( attack.crit.count );
	


	-- crit total.
	critDmgRatio = string.format("%d%%", 100 * attack.crit.total / damageTotal );
	KombatStatsFrameCritTotalPercent:SetText( critDmgRatio );
	KombatStatsFrameCritTotal:SetText( attack.crit.total );
	
	KombatStatsFrameCritMin:SetText( attack.crit.minimum );	
	KombatStatsFrameCritMax:SetText( attack.crit.maximum );
	
	-- crit average.
	if attack.crit.count == 0 then
		critAverage = 0;
	else
		critAverage = string.format("%d", attack.crit.total / attack.crit.count );
	end
	
	KombatStatsFrameCritAvg:SetText( critAverage );

	
	
	
	-- DOT might be CB or GB.
	if isMelee then	 -- melee
		if ui.currCategory == "attack" then
			KombatStatsFrameDOTTitle:SetText(self.loc.GB)
		else
			KombatStatsFrameDOTTitle:SetText(self.loc.CB)
		end
	else
		KombatStatsFrameDOTTitle:SetText(self.loc.DOT)
	end
	
	--  DOT count.
	KombatStatsFrameDOTCount:SetText( attack.dot.count );
	
	if isMelee then
		KombatStatsFrameDOTCountPercent:SetJustifyH("right")
		KombatStatsFrameDOTCountPercent:SetText( string.format("%d%%", 100 * attack.dot.count / countTotal ) )
	else
		KombatStatsFrameDOTCountPercent:SetJustifyH("center")
		KombatStatsFrameDOTCountPercent:SetText("-")
	end
	

	-- DOT total.
	dotDmgRatio	= string.format("%d%%", 100 * attack.dot.total / damageTotal );
	KombatStatsFrameDOTTotalPercent:SetText( dotDmgRatio );
	KombatStatsFrameDOTTotal:SetText( attack.dot.total );
	
	KombatStatsFrameDOTMin:SetText( attack.dot.minimum );	
	KombatStatsFrameDOTMax:SetText( attack.dot.maximum );
	
	-- DOT average.
	if attack.dot.count == 0 then
		dotAverage = 0;
	else
		dotAverage = attack.dot.total / attack.dot.count;
		dotAverage = string.format("%d", dotAverage);
	end
	
	KombatStatsFrameDOTAvg:SetText( dotAverage );
			
			
		-- Misc info.
	missRatio = string.format("%d%%", 100 * attack.miss / countTotal ) 
	dodgeRatio = string.format("%d%%", 100 * attack.dodge / countTotal ) 
	parryRatio = string.format("%d%%", 100 * attack.parry / countTotal )
	blockRatio = string.format("%d%%", 100 * attack.block / countTotal )
	deflectRatio = string.format("%d%%", 100 * attack.deflect / countTotal ) 
	resistRatio = string.format("%d%%", 100 * attack.resist / countTotal ) 
		
	KombatStatsFrameMissPercent:SetText( missRatio );
	KombatStatsFrameMissCount:SetText( attack.miss );
	KombatStatsFrameDodgePercent:SetText( dodgeRatio );
	KombatStatsFrameDodgeCount:SetText( attack.dodge );
	KombatStatsFrameParryPercent:SetText( parryRatio );
	KombatStatsFrameParryCount:SetText( attack.parry );
	KombatStatsFrameBlockPercent:SetText( blockRatio );
	KombatStatsFrameBlockCount:SetText( attack.block );
	KombatStatsFrameDeflectPercent:SetText( deflectRatio );
	KombatStatsFrameDeflectCount:SetText( attack.deflect );
	KombatStatsFrameResistPercent:SetText( resistRatio );
	KombatStatsFrameResistCount:SetText( attack.resist );
	
	
	if ui.currSkill == self.loc.SKILL_TOTAL then
		self:ReclaimStats(attack)
	end
	
end

function KombatStats:UpdateSummary()

end

function KombatStats:StatsFrame_Clear()
		
		KombatStatsFrameSummaryText:SetText("");

		-- Hit.
		KombatStatsFrameHitCountPercent:SetText( "" );
		KombatStatsFrameHitCount:SetText( "" );
		KombatStatsFrameHitTotalPercent:SetText( "" );
		KombatStatsFrameHitTotal:SetText( "" );
		KombatStatsFrameHitMin:SetText( "" );	
		KombatStatsFrameHitMax:SetText( "" );
		KombatStatsFrameHitAvg:SetText( "" );
		
		--  Crit.
		KombatStatsFrameCritCountPercent:SetText( "" );
		KombatStatsFrameCritCount:SetText( "" );
		KombatStatsFrameCritTotalPercent:SetText( "" );
		KombatStatsFrameCritTotal:SetText( "" );
		KombatStatsFrameCritMin:SetText( "" );	
		KombatStatsFrameCritMax:SetText( "" );
		KombatStatsFrameCritAvg:SetText( "" );

		--  DOT.
		KombatStatsFrameDOTTitle:SetText(self.loc.DOT)
		KombatStatsFrameDOTCount:SetText( "" );
		KombatStatsFrameDOTCountPercent:SetJustifyH("center");
		KombatStatsFrameDOTCountPercent:SetText( "-" );
		KombatStatsFrameDOTTotalPercent:SetText( "" );
		KombatStatsFrameDOTTotal:SetText( "" );
		KombatStatsFrameDOTMin:SetText( "" );	
		KombatStatsFrameDOTMax:SetText( "" );
		KombatStatsFrameDOTAvg:SetText( "" );
			
			
		-- Misc info.
		KombatStatsFrameMissPercent:SetText( "" );
		KombatStatsFrameMissCount:SetText( ""  );
		KombatStatsFrameDodgePercent:SetText( ""  );
		KombatStatsFrameDodgeCount:SetText( ""  );
		KombatStatsFrameParryPercent:SetText( ""  );
		KombatStatsFrameParryCount:SetText( ""  );
		KombatStatsFrameBlockPercent:SetText( ""  );
		KombatStatsFrameBlockCount:SetText( ""  );
		KombatStatsFrameDeflectPercent:SetText( ""  );
		KombatStatsFrameDeflectCount:SetText( ""  );
		KombatStatsFrameResistPercent:SetText(""  );
		KombatStatsFrameResistCount:SetText( ""  );
	
end

function KombatStats:Dataset_OnClick()

	
	if ui.currDataset == "all" then
		ui.currDataset = "session";
	elseif ui.currDataset == "session" then
		ui.currDataset = "last";
	else
		ui.currDataset = "all";
	end

	KombatStatsDatasetText:SetText(self.loc[ui.currDataset]);
	KombatStats:StatsFrame_Refresh();
	
end

function KombatStats:Category_OnClick()
	
	if ui.currCategory == "attack" then
		ui.currCategory = "defend";
		KombatStatsFrameCategoryButton:SetNormalTexture("Interface\\Icons\\Ability_Defend");
	elseif ui.currCategory == "defend" then
		ui.currCategory = "heal";
		KombatStatsFrameCategoryButton:SetNormalTexture("Interface\\Icons\\Spell_Holy_HolyBolt");
	else
		ui.currCategory = "attack";
		KombatStatsFrameCategoryButton:SetNormalTexture("Interface\\Icons\\INV_Weapon_ShortBlade_05");
	end
	
	ui.currSkill = nil
	KombatStats:StatsFrame_OnShow();
	
end

function KombatStats:CharButton_OnClick()


	if not IsShiftKeyDown() then
		
		if not this.initDewdrop then
			dewdrop:Register(this,
				'children', function() KombatStats:CharButton_DropDown() end,
				'point', 'TOPLEFT',
				'relativePoint', 'BOTTOMLEFT',
				'dontHook', true
			)						
			this.initDewdrop = true
		end

		dewdrop:Open(this)
		
		
	else
		
		if not ui.currChar or not self.stats[ui.currDataset][ui.currChar] then return end
		
		self:ReclaimStats(self.stats[ui.currDataset][ui.currChar], 2)
		compost:Reclaim( self.stats[ui.currDataset][ui.currChar], 1)
		self.stats[ui.currDataset][ui.currChar] = nil
		ui.currChar = nil
		
		KombatStats:StatsFrame_OnShow()
			
	end
end

function KombatStats:CharButton_DropDown()

	local text = KombatStatsCharText:GetText()
	
	local hasData
	for name in self.stats[ui.currDataset] do
		dewdrop:AddLine(
			'text', name,
			'notCheckable', true,
			'closeWhenClicked', true,
			'func', KombatStats.CharDropDown_OnClick,
			'arg1', self,
			'arg2', name
		)
		if not hasData then hasData = true end
	end
	
	-- At least show player as an option.
	if not hasData then
		dewdrop:AddLine(
			'text', playerName,
			'notCheckable', true,
			'closeWhenClicked', true,
			'func', KombatStats.CharDropDown_OnClick,
			'arg1', self,
			'arg2', playerName
		)	
	end
	
	

end

function KombatStats:CharDropDown_OnClick(name)	
	ui.currChar = name
	ui.currSkill = nil
	KombatStats:StatsFrame_OnShow()	

end

function KombatStats:SkillButton_OnClick()
	if not IsShiftKeyDown() then
		
		if not this.initDewdrop then
			dewdrop:Register(this,
				'children', function() KombatStats:SkillButton_DropDown() end,
				'point', 'TOPLEFT',
				'relativePoint', 'BOTTOMLEFT',
				'dontHook', true
			)						
			this.initDewdrop = true
		end

		dewdrop:Open(this)
				
	else
	
		if not self:ExistStats(ui.currDataset, ui.currChar, ui.currCategory, ui.currSkill) then return end
		self:ReclaimStats(self.stats[ui.currDataset][ui.currChar][ui.currCategory][ui.currSkill])
		self.stats[ui.currDataset][ui.currChar][ui.currCategory][ui.currSkill] = nil
		ui.currSkill = self.loc.SKILL_TOTAL
		KombatStats:StatsFrame_OnShow()

	end
end

function KombatStats:SkillButton_DropDown()


	if ui.currChar and self.stats[ui.currDataset][ui.currChar] and self.stats[ui.currDataset][ui.currChar][ui.currCategory] then
		-- Load attack list.
		local info, skillName
		for skill in self.stats[ui.currDataset][ui.currChar][ui.currCategory] do
		
			if type(skill) == "number" then -- melee attack.
				skillName = self.loc.SKILL_MELEE .. self:GetShapeshiftName(skill)
			else
				skillName = skill
			end
			

			dewdrop:AddLine(
				'text', skillName,
				'notCheckable', true,
				'closeWhenClicked', true,
				'func', KombatStats.SkillDropDown_OnClick,
				'arg1', self,
				'arg2', skillName,
				'arg3', skill
			)
		end
	end

	-- The "Total" attack.

	dewdrop:AddLine(
		'text', self.loc.SKILL_TOTAL,
		'notCheckable', true,
		'closeWhenClicked', true,
		'func', KombatStats.SkillDropDown_OnClick,
		'arg1', self,
		'arg2', self.loc.SKILL_TOTAL,
		'arg3', self.loc.SKILL_TOTAL
	)

end

function KombatStats:SkillDropDown_OnClick(skillName, skillID)

	ui.currSkill = skillID
	KombatStatsSkillText:SetText(skillName)
	
	KombatStats:StatsFrame_Refresh();
end

function KombatStats:ToggleFrame(frame, switch)
	if switch == true then
		if not frame:IsShown() then
			frame:Show();
		end		
	elseif switch == false then
		if frame:IsShown() then
			frame:Hide();
		end
	else
		if frame:IsShown() then
			frame:Hide();
		else
			frame:Show();
		end
		
	end
end

function KombatStats:Button_OnEnter()

	local tooltipString = this:GetName() .. "_Tooltip";
	
	if self.loc[tooltipString] then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(self.loc[tooltipString]);	
	end
	
	
end

function KombatStats:Button_OnLeave()
	GameTooltip:Hide();
end


function KombatStats:GetParser()
	return parser
end
