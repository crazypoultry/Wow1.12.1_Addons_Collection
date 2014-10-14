
local CommChannel = CommChannel("1.0")

local PatternList = {
	{ "SPELLCASTOTHERSTART", { 1, 2 } },			-- "%s begins to cast %s."
	{ "HEALEDCRITOTHEROTHER", { 1, 2, 3, 4 } },		-- "%s's %s critically heals %s for %d."
	{ "HEALEDCRITOTHERSELF", { 1, 2, 3 } },		-- "%s's %s critically heals you for %d."
	{ "HEALEDOTHEROTHER", { 1, 2, 3, 4 } },		-- "%s's %s heals %s for %d."
	{ "HEALEDOTHERSELF", { 1, 2, 3 } },		-- "%s's %s heals you for %d."
}

local function BuildPattern(tbl, cb)
	tbl[1] = getglobal(tbl[1])
	
	tbl[1] = string.gsub(tbl[1],"([%^%(%)%.%[%]%*%+%-%?])","%%%1")
	tbl[1] = string.gsub(tbl[1],"%%s","(.-)")
	tbl[1] = string.gsub(tbl[1],"%%d","(%%d+)")
	
	if (string.find(tbl[1], "%$")) then
		local i = 1
		
		tbl[2] = { }
		
		for i in string.gfind(tbl[1],"%%(%d)%$.") do
			table.insert(tbl[2], tonumber(i))
			i = i + 1
		end
		
		tbl[1] = string.gsub(tbl[1],"%%%d%$s","(.-)")
		tbl[1] = string.gsub(tbl[1],"%%%d%$d","(%%d+)")
	end
	
	tbl[1] = string.gsub(tbl[1],"%$","%%$")
	
	if (string.sub(tbl[1], -4) == "(.-)") then
		tbl[1] = string.sub(tbl[1], 0, -5) .. "(.+)"
	end
	
	tbl[1] = "^"..tbl[1].."$"
	
	tbl[3] = cb
end

local SpellList = { }

local function getUnitID(name)
	local numRaidMembers = GetNumRaidMembers()
	for raidID=1,numRaidMembers do
		local unitName = GetRaidRosterInfo(raidID)
		if (unitName == name) then
			return "raid"..raidID
		end
	end
	
	local numPartyMembers = GetNumPartyMembers()
	for partyID=1,numPartyMembers do
		local unitName = UnitName("party"..partyID)
		if (unitName == name) then
			return "party"..partyID
		end
	end
	
	if (name == UnitName("player")) then
		return "player"
	end
	
	return nil
end

local function avg(tbl)
	local total = 0
	
	for _, val in ipairs(tbl) do
		total = total + val[2] - val[1]
	end
		
	return total / table.getn(tbl)
end

local function start(caster, spell)
	if (SpellList[spell] == nil) then
		return
	end
	
	local casterID = getUnitID(caster) or (debug and "player")
	if (casterID == nil) then
		return
	end
	
	local target = UnitName(casterID.."target") or (debug and UnitName("player"))
	if (target == nil) then
		return
	end
	
	if (debug) then
		target = UnitName("player")
	end
	
	if (getUnitID(target) == nil) then
		return
	end
	
	local n = table.getn(SpellList[spell])
	local tbl = n == 16 and table.remove(SpellList[spell]) or { }
	tbl[1], tbl[2] = GetTime(), GetTime() + 3
	table.insert(SpellList[spell], 1, tbl)
	
	local castTime = avg(SpellList[spell])
	
	
--	DEFAULT_CHAT_FRAME:AddMessage(""..caster.." => "..target.." - "..spell.." - "..string.format("%.1f", castTime).." ("..(table.getn(SpellList[spell]))..")")
	
	-- let's assume 100ms local lag
	local _, _, localLag = GetNetStats()
	local module = CommChannel.Channels["RAID"]["HSC"]
	arg4 = caster
	module:S(target, spell, castTime, 100)
end

local function stop(caster, spell)
	SpellList[spell] = SpellList[spell] or { }
	
	local tbl = SpellList[spell][1]
	if (tbl == nil) then
		return
	end
	
	if (GetTime() - tbl[1] > 6) then
		tbl[2] = tbl[1] + 3
	else
		tbl[2] = GetTime()
	end
end

local function SPELLCASTOTHERSTART(caster, spell)
	start(caster, spell)
end
local function HEALEDCRITOTHEROTHER(caster, spell, target, amount)
	stop(caster, spell)
end
local function HEALEDCRITOTHERSELF(caster, spell, amount)
	stop(caster, spell)
end
local function HEALEDOTHEROTHER(caster, spell, target, amount)
	stop(caster, spell)
end
local function HEALEDOTHERSELF(caster, spell, amount)
	stop(caster, spell)
end

BuildPattern(PatternList[1], SPELLCASTOTHERSTART)
BuildPattern(PatternList[2], HEALEDCRITOTHEROTHER)
BuildPattern(PatternList[3], HEALEDCRITOTHERSELF)
BuildPattern(PatternList[4], HEALEDOTHEROTHER)
BuildPattern(PatternList[5], HEALEDOTHERSELF)

local r = { }
local function onEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		SpellList = { }
	else
		for name, tbl in ipairs(PatternList) do
			r[3], _, r[1], r[2] = string.find(arg1, tbl[1])
			if (r[3]) then
				return tbl[3](r[tbl[2][1]], r[tbl[2][2]])
			end
		end
	end
end

this = CreateFrame("Frame")
this:RegisterEvent("PLAYER_ENTERING_WORLD")
this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF")
this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF")
this:SetScript("OnEvent", onEvent)

SLASH_HSS1 = "/hss"
SlashCmdList["HSS"] = function(msg)
	SpellList = { }
end
