-- Raid Roster information
--
-- This builds two arrays, one for raid/party members
-- one for any mobs targeted by raid/party members
--
-- These are only generated once per update then every other
-- window can just refer to these as needed

-- The arrays
OZ_RaidRoster = {}
OZ_PlayerParty = nil


-- Functions in here:
-- OZ_SetupRaidRoster()		- Initialising the data
-- OZ_UpdateRoster()		- Fill in current raid members
-- OZ_UpdateTargets()		- Find all unique targets

-- register & handle these events instead:
--RAID_ROSTER_UPDATE
--RAID_TARGET_UPDATE - Icons
--PARTY_MEMBER_DISABLE - offline/dead
--PARTY_MEMBER_ENABLE - online/rezzed
--PARTY_MEMBERS_CHANGED - raid groups changed
--PARTY_LEADER_CHANGED
--UNIT_AURA			- Buff/debuff
--UNIT_HEALTH
--UNIT_MANA
--UNIT_MAXHEALTH
--UNIT_MAXMANA

OZ_ICON_LIST = {
					"Interface\\AddOns\\OzRaid\\star",
					"Interface\\AddOns\\OzRaid\\circle",
					"Interface\\AddOns\\OzRaid\\diamond",
					"Interface\\AddOns\\OzRaid\\triangle",
					"Interface\\AddOns\\OzRaid\\moon",
					"Interface\\AddOns\\OzRaid\\square",
					"Interface\\AddOns\\OzRaid\\cross",
					"Interface\\AddOns\\OzRaid\\skull",
					"Interface\\GroupFrame\\UI-Group-LeaderIcon",
					"Interface\\GroupFrame\\UI-Group-MasterLooter"
				};

function OZ_SetupRaidRoster()
	local x

	OZ_RaidRoster = {
		["nMembers"]	= 0,
		["member"]		= {},
		["nTargets"]	= 0,
		["target"]		= {},
	}

	for x = 1 , 40 do
		OZ_RaidRoster.member[x] = {
			["name"]		= "name"..x,
			["unit"]		= "player",
			["rank"]		= 0,
			["subgroup"]	= 0,
			["level"]		= 0,
			["class"]		= "Mage",
			["fileName"]	= "MAGE",
			["zone"]		= "Offline",
			["online"]		= nil,
			["isDead"]		= nil,

			["unit"]		= "player",
			["colour"]		= {["r"]=1.0, ["g"]=0.0, ["b"]=0.0, ["a"]=1.0},

			["range"]		= nil,
			["health"]		= 0,
			["maxHealth"]	= 1000,
			["mana"]		= 0,
			["maxMana"]		= 1000,
			["offline"]		= nil,
		};
	end
	
	for x = 1 , 10 do
		OZ_RaidRoster.target[x] = {
			["name"]		= "name"..x,
			["unit"]		= "playertarget",
		};
	end
end

-- Fill in bar data for window 'n'
function OZ_GetMemberData(n, unit)
	if(unit == nil) then
		return
	end
	local class,fileName = UnitClass(unit)
	local dest = OZ_RaidRoster.member[n]
	dest.unit 		= unit
	dest.name		= UnitName(unit)
	dest.rank		= 0
	dest.subgroup	= 1
	dest.level		= UnitLevel(unit)
	dest.class		= class
	dest.fileName	= fileName
	dest.zone		= nil
	dest.online		= UnitIsConnected(unit)
	dest.isDead		= UnitIsDeadOrGhost(unit)

	OZ_SetExtraMemberData(n)
end

function OZ_SetExtraMemberData(n)
	local m, c
	local dest = OZ_RaidRoster.member[n]
	local unit = dest.unit
	dest.isDead		= UnitIsDeadOrGhost(unit)
	dest.online		= UnitIsConnected(unit)
	if( (dest.online) and (not dest.isDead))then
		m,c = UnitManaMax( unit ),UnitMana( unit )
		dest.mana	= c
		dest.maxMana	= m
		m,c = UnitHealthMax( unit ),UnitHealth( unit )
		dest.health		= c
		dest.maxHealth	= m
	else
		dest.maxHealth = 1
		dest.health	= 0
		dest.maxMana	= 1
		dest.health	= 0
	end
	dest.range	= CheckInteractDistance(unit, 4)

	if( (dest.range) and (CheckInteractDistance(unit, 1)) )then
		dest.range = 2
	end

	if(dest.online)then
		dest.offline = nil
	elseif(not dest.offline)then
		dest.offline = GetTime()
	end

	if(dest.rank == 2)then
		dest.icon = OZ_ICON_LIST[9]
	else
		dest.icon = nil
	end
	local rt = GetRaidTargetIndex(unit)
	dest.iconVal = rt
	if(rt)then
		dest.icon = OZ_ICON_LIST[rt]
	end
end

function OZ_UpdateRoster()
	local i
	OZ_PlayerParty = nil
	OZ_RaidRoster.inParty = nil
	OZ_RaidRoster.solo = nil

--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Updating roster");
	local nMembers = GetNumRaidMembers()
	if( nMembers == 0 ) then

		-- Not a raid - either lone or in party
		-- Add ourselves...
		OZ_PlayerParty = 1
		OZ_RaidRoster.nMembers = 1
		OZ_GetMemberData(1,"player")
		if(UnitIsPartyLeader("player")) then
			OZ_RaidRoster.member[1].rank = 2
		end
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: PARTY: Add me");
		OZ_RaidRoster.solo = 1

		nMembers = GetNumPartyMembers()
		if(nMembers > 0) then
			OZ_RaidRoster.inParty = 1
			OZ_RaidRoster.solo = nil
			for i = 1,nMembers do
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: PARTY: Add party"..i);
				OZ_RaidRoster.nMembers = OZ_RaidRoster.nMembers + 1
				OZ_GetMemberData(OZ_RaidRoster.nMembers, "party"..i)
				if(UnitIsPartyLeader("party"..i)) then
					OZ_RaidRoster.member[OZ_RaidRoster.nMembers].rank = 2
				end
			end
		end
	else
		OZ_RaidRoster.nMembers = 0;
		for i = 1,40 do
			local name,rank,subgroup,level,class,fileName,zone,online,isDead
			name,rank,subgroup,level,class,fileName,zone,online,isDead = GetRaidRosterInfo(i)
			if(name) then
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: RAID: Add "..name);
				OZ_RaidRoster.nMembers = OZ_RaidRoster.nMembers + 1
				local dest = OZ_RaidRoster.member[OZ_RaidRoster.nMembers]
				dest.unit = "raid"..i

				dest.name		= name
				dest.rank		= rank
				dest.subgroup	= subgroup
				dest.level		= level
				dest.class		= class
				dest.fileName	= fileName
				dest.zone		= zone
				dest.online		= online
				dest.isDead		= isDead

				if( UnitIsUnit("player", dest.unit) )then
					OZ_PlayerParty = subgroup
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Mygroup = "..subgroup);
				end

				OZ_SetExtraMemberData(OZ_RaidRoster.nMembers)
			end
		end
	end
end


function OZ_UpdateTargets()
	local i,j
	OZ_RaidRoster.nTargets = 0;
	local m = OZ_RaidRoster.nMembers
	for i = 1,m do
		local player = OZ_RaidRoster.member[i]
		player.hasAggro = nil
		OZ_UpdateTargetData( player.unit )
	end

	local t = OZ_RaidRoster.nTargets
	if(t>0)then
		for j = 1,t do
			if(OZ_RaidRoster.target[j] and OZ_RaidRoster.target[j].unit)then
				local targetted = OZ_RaidRoster.target[j].unit.."target"
				if(UnitExists(targetted))then
					for i= 1,m do
						local dest = OZ_RaidRoster.member[i]
						if(UnitIsUnit(targetted,dest.unit))then
							if(dest.hasAggro)then
								dest.hasAggro = dest.hasAggro + 0.25
							else
								dest.hasAggro = 0.5
							end
							break
						end
					end
				end
			end
		end
	end
end

function OZ_UpdateTargetData(unit)
	local t = unit.."target"
	if( UnitExists(t) and
		(UnitCanAttack("player",t)) and
		(not UnitIsCivilian(t)) and
		(not UnitIsDead(t)) ) then

		-- We have a valid target
		-- check if we have already counted this one...
		if( OZ_RaidRoster.nTargets > 0 ) then
			for n = 1,OZ_RaidRoster.nTargets do
				if( UnitIsUnit( t, OZ_RaidRoster.target[n].unit ) ) then
					return
				end
			end
		end

		-- Ok, this target is a mob, and is notyet in the list
		OZ_RaidRoster.nTargets = OZ_RaidRoster.nTargets + 1
		local dest = OZ_RaidRoster.target[OZ_RaidRoster.nTargets]
		if(not dest)then
			dest = {}
		end
		dest.unit		= t
		dest.name		= UnitName(t)
		dest.level		= UnitLevel(t)
		dest.rank		= 0
		dest.subgroup	= 0
		dest.class		= "Mob"
		dest.fileName	= "TARGET"
		dest.zone		= nil
		dest.online		= 1
		dest.isDead		= UnitIsDead(t)

		local m, c
		if( not dest.isDead )then
			m,c = UnitManaMax( t ),UnitMana( t )
			dest.mana		= c
			dest.maxMana	= m

			m,c = UnitHealthMax( t ),UnitHealth( t )
			dest.health		= c
			dest.maxHealth	= m

			local rt = GetRaidTargetIndex(unit)
			dest.iconVal = rt
			if(rt)then
				dest.icon = OZ_ICON_LIST[rt]
			else
				dest.icon = nil
			end
		else
			dest.health		= 0
			dest.maxHealth	= 100
			dest.mana	= 0
			dest.maxMana	= 100
		end
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Health =  "..dest.health);
		dest.range	= CheckInteractDistance(t, 4)
		if( (dest.range) and (CheckInteractDistance(t, 1)) )then
			dest.range = 2
		end
	end
end
