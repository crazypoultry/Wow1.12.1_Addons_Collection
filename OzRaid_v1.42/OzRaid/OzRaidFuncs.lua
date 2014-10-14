
OZ_InputFunctions = {}
OZ_SortFunctions = {}
OZ_ColourFunctions = {}
OZ_HeadingFunctions = {}
local i

function OZ_SetupFunctions()
-----------------------INPUT-------------------------
	OZ_InputFunctions =	{
							{	["pFunction"]	= "OZ_InputRaidMembersHealth",
								["text"]		= "Party/Raid Members Health",
							},
							{	["pFunction"]	= "OZ_InputRaidMembersMana",
								["text"]		= "Party/Raid Members Mana",
							},
							{	["pFunction"]	= "OZ_InputAggregatedClassHealth",
								["text"]		= "Health (by Class)",
							},
							{	["pFunction"]	= "OZ_InputAggregatedClassMana",
								["text"]		= "Mana (by Class)",
							},
							{	["pFunction"]	= "OZ_InputPartyMembersHealth",
								["text"]		= "Party Members Health",
							},
							{	["pFunction"]	= "OZ_InputPartyMembersMana",
								["text"]		= "Party Members Mana",
							},

							{	["pFunction"]	= "OZ_InputRaidTargetsHealth",
								["text"]		= "Target Health",
							},
--							{	["pFunction"]	= "OZ_InputAllHealth",
--								["text"]		= "Players & Targets Health",
--							},
						};

-----------------------SORT-------------------------
	OZ_SortFunctions	= {
							{	["pFunction"]	= "OZ_SortByValueDown",
								["text"]		= "Bar Length (asc)",
							},
							{	["pFunction"]	= "OZ_SortByInjured",
								["text"]		= "Health Status",
							},
							{	["pFunction"]	= "OZ_SortBySubGroup",
								["text"]		= "Group",
							},
							{	["pFunction"]	= "OZ_SortByClass",
								["text"]		= "Class",
							},
							{	["pFunction"]	= "OZ_SortByRange",
								["text"]		= "Range",
							},
							{	["pFunction"]	= "OZ_SortByIcon",
								["text"]		= "Raid Icon",
							},
							
						};

	OZ_HeadingFunctions	= {
							{	["pFunction"]	= "OZ_HeadingHealth",
								["text"]		= "Injured/Healthy Heading",
							},
							{	["pFunction"]	= "OZ_HeadingStatus",
								["text"]		= "Injured/Healthy Heading",
							},
							{	["pFunction"]	= "OZ_HeadingGroup",
								["text"]		= "Group Heading",
							},
							{	["pFunction"]	= "OZ_HeadingClass",
								["text"]		= "Class Heading",
							},
							{	["pFunction"]	= "OZ_HeadingRange",
								["text"]		= "Range Heading",
							},
							{	["pFunction"]	= "OZ_EmptyFunction",
								["text"]		= "Icon",
							},
						};
-----------------------FORMAT-------------------------
	OZ_ColourFunctions ={
							{	["pFunction"]	= "OZ_ColourByClass",
								["text"]		= "Colour by class",
							},
							{	["pFunction"]	= "OZ_ColourHealth",
								["text"]		= "Health - Green/Red",
							},
							{	["pFunction"]	= "OZ_ColourMana",
								["text"]		= "Mana - Blue/Purple",
							},
							{	["pFunction"]	= "OZ_ColourHealthBlueParty",
								["text"]		= "Party Blue, Rest Green",
							},
						};
end

function OZ_EmptyFunction(n)
	return 0;
end

-------------------------------------------------------------------------
--   INPUT FUNCTIONS
--
--   These functions initialise the bar arrays with the initial data
--
-------------------------------------------------------------------------
function OZ_InputAddMembers(n)
	-- Go through the raid roster and add all members to thistables bars...
	local i,p
	p = OZ_Input.nBars
	local class = OZ_Config[n].filter.class
	local group = OZ_Config[n].filter.group
	if( OZ_RaidRoster.nMembers>0 ) then
		for i = 1,OZ_RaidRoster.nMembers do
			-- Filter for class & group
			local member = OZ_RaidRoster.member[i]
			if( class[member.fileName] == 1) then
				if( group[member.subgroup] == 1)then
					p = p+1
					local dest = OZ_Input.bar[p]
					dest.roster = i
					dest.target = 0
					dest.sortWeight = 0
				end
			end
		end
	end
	OZ_Input.nBars = p
end

function OZ_InputAddPartyMembers(n)
	-- Go through the raid roster and add all members to thistables bars...
	local i,p
	p = OZ_Input.nBars
	local class = OZ_Config[n].filter.class
	if( OZ_RaidRoster.nMembers>0 ) then
		for i = 1,OZ_RaidRoster.nMembers do
			-- Filter for class & group
			local member = OZ_RaidRoster.member[i]
			if( member.subgroup == OZ_PlayerParty)then
				if( class[member.fileName] == 1) then
					p = p+1
					local dest = OZ_Input.bar[p]
					dest.roster = i
					dest.target = 0
					dest.sortWeight = 0
				end
			end
		end
	end
	OZ_Input.nBars = p
end

function OZ_InputAddTargets(n)
	-- Go through the raid roster and add all members to thistables bars...
	local i,p
	if( OZ_RaidRoster.nTargets>0 ) then
		for i = 1,OZ_RaidRoster.nTargets do
			p = OZ_Input.nBars + i
			local dest = OZ_Input.bar[p]
			dest.roster = 0
			dest.target = i
			dest.sortWeight = 0
		end
	end
	OZ_Input.nBars = OZ_Input.nBars + OZ_RaidRoster.nTargets
end

function OZ_InputAddHealth()
	local i
	local rt = OZ_RaidRoster.target
	local rm = OZ_RaidRoster.member
	if( OZ_Input.nBars>0 ) then
		for i=1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			local p
			if(bar.roster > 0)then
				p = rm[bar.roster]
			else
				p = rt[bar.target]
			end
			if(p)then
				bar.unit	= p.unit
				bar.class	= p.fileName
				bar.max		= p.maxHealth
				bar.current	= p.health
			else
				bar.unit	= nil
				bar.class	= "TARGET"
				bar.max		= 1000
				bar.current	= 0
			end
		end
	end
end

function OZ_InputAddMana()
	local i
	local rt = OZ_RaidRoster.target
	local rm = OZ_RaidRoster.member
	if( OZ_Input.nBars>0 ) then
		for i=1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			local p
			if(bar.roster > 0)then
				p = rm[bar.roster]
			else
				p = rt[bar.target]
			end
			bar.unit	= p.unit
			bar.class	= p.fileName
			bar.max		= p.maxMana
			bar.current	= p.mana
		end
	end
end

function OZ_InputRaidMembersHealth(n)
	OzRaid_UpdateUnitData()
	if(not OZ_Config[n].hideGlow)then
		OzRaid_UpdateTargetData()
	end
	OZ_Input.nBars = 0
	OZ_InputAddMembers(n)
	OZ_InputAddHealth()
end

function OZ_InputRaidMembersMana(n)
	OzRaid_UpdateUnitData()
	if(not OZ_Config[n].hideGlow)then
		OzRaid_UpdateTargetData()
	end
	OZ_Input.nBars = 0
	OZ_InputAddMembers(n)
	OZ_InputAddMana()
end

function OZ_InputPartyMembersHealth(n)
	OzRaid_UpdateUnitData()
	if(not OZ_Config[n].hideGlow)then
		OzRaid_UpdateTargetData()
	end
	OZ_Input.nBars = 0
	OZ_InputAddPartyMembers(n)
	OZ_InputAddHealth()
end

function OZ_InputPartyMembersMana(n)
	OzRaid_UpdateUnitData()
	if(not OZ_Config[n].hideGlow)then
		OzRaid_UpdateTargetData()
	end
	OZ_Input.nBars = 0
	OZ_InputAddPartyMembers(n)
	OZ_InputAddMana()
end

function OZ_InputRaidTargetsHealth(n)
	OzRaid_UpdateTargetData()
	OZ_Input.nBars = 0
	OZ_InputAddTargets(n)
	OZ_InputAddHealth()
end

function OZ_InputAllHealth(n)
	OzRaid_UpdateUnitData()
	OzRaid_UpdateTargetData()
	OZ_Input.nBars = 0
	OZ_InputAddMembers(n)
	OZ_InputAddTargets(n)
	OZ_InputAddHealth()
end

OZ_AGG = {
	["TARGET"] = {0,0},
	["DRUID"] = {0,0},
	["HUNTER"] = {0,0},
	["MAGE"] = {0,0},
	["PALADIN"] = {0,0},
	["PRIEST"] = {0,0},
	["ROGUE"] = {0,0},
	["SHAMAN"] = {0,0},
	["WARLOCK"] = {0,0},
	["WARRIOR"] = {0,0},
};

function OZ_InputAggregatedClassHealth(n)
	OZ_Input.nBars = 0
	local class
	local i,key,value
	for key,value in pairs(OZ_AGG) do
		value[0] = 0
		value[1] = 0
	end
	if( OZ_RaidRoster.nMembers>0 ) then
		for i = 1,OZ_RaidRoster.nMembers do
			local member = OZ_RaidRoster.member[i]
			class = member.fileName
			OZ_AGG[class][0]	= OZ_AGG[class][0] + member.health
			OZ_AGG[class][1]	= OZ_AGG[class][1] + member.maxHealth
		end
	end
	i = 0
	for key,value in pairs(OZ_AGG) do
		if( (value[1] > 0) and (OZ_Config[n].filter.class[key]) ) then
			i = i+1
			local bar = OZ_Input.bar[i]
			bar.roster	= 0
			bar.target	= 0
			bar.current	= value[0]
			bar.max		= value[1]
			bar.class	= key
			bar.unit	= nil
		end
	end
	OZ_Input.nBars = i
end

function OZ_InputAggregatedClassMana(n)
	OZ_Input.nBars = 0
	local class
	local i,key,value
	for key,value in pairs(OZ_AGG) do
		value[0] = 0
		value[1] = 0
	end
	if( OZ_RaidRoster.nMembers>0 ) then
		for i = 1,OZ_RaidRoster.nMembers do
			local member = OZ_RaidRoster.member[i]
			class = member.fileName
			OZ_AGG[class][0]	= OZ_AGG[class][0] + member.mana
			OZ_AGG[class][1]	= OZ_AGG[class][1] + member.maxMana
		end
	end
	i = 0
	for key,value in pairs(OZ_AGG) do
		if( (value[1] > 0) and (OZ_Config[n].filter.class[key]) ) then
			i = i+1
			local bar = OZ_Input.bar[i]
			bar.roster	= 0
			bar.target	= 0
			bar.current	= value[0]
			bar.max		= value[1]
			bar.class	= key
			bar.unit	= nil
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."IN: "..key.." val = "..bar.current.."/"..bar.max);
		end
	end
	OZ_Input.nBars = i
end

function OZ_InputDebugRange(n)
	local i
	for i = 1,20 do
		OZ_Input.bar[i].roster	= 0
		OZ_Input.bar[i].target	= 0
		OZ_Input.bar[i].current	= 100
		OZ_Input.bar[i].max		= 100
		if( CheckInteractDistance("target", i) )then
			OZ_Input.bar[i].value	= 1
		else
			OZ_Input.bar[i].value	= 0.1
		end
		OZ_Input.bar[i].class	= "MAGE"
		OZ_Input.bar[i].unit	= target
		OZ_Input.bar[i].buffs	= {}
		OZ_Input.bar[i].debuff	= nil
	end
	OZ_Input.nBars = 20
end
-------------------------------------------------------------------------
--   FILTER FUNCTIONS
--
--   These functions initialise the bar arrays with the initial data
--
-------------------------------------------------------------------------
function OZ_FilterRemoveBar(n,i)
	-- Simplest way to remove a bar is to copy the last entry 
	-- into position 'i' and reduce the bar count by 1.
	if(i <= OZ_Input.nBars) then
		if(i < OZ_Input.nBars) then
			local currBar = OZ_Input.bar[i]
			local lastBar = OZ_Input.bar[OZ_Input.nBars]
			currBar.roster	= lastBar.roster
			currBar.target	= lastBar.target			
			currBar.current	= lastBar.current			
			currBar.max		= lastBar.max		
			currBar.value	= lastBar.value
			currBar.class	= lastBar.class
			currBar.unit	= lastBar.unit
			local j
			for j = 1,OZ_MAX_BUFFS do
				currBar.buffs[j]	= lastBar.buffs[j]
			end
			currBar.debuff	= lastBar.debuff
		end
		OZ_Input.nBars = OZ_Input.nBars - 1
	end
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Player REMOVED");
end

function OZ_FilterBars(n)
	local i = 1
	local removed
	local status = OZ_Config[n].filter.status
	while (i <= OZ_Input.nBars) do
		removed = 0
		local statusValid = 1

		if( OZ_Input.bar[i].roster > 0 ) then
			local player = OZ_RaidRoster.member[ OZ_Input.bar[i].roster ]
			-- Player
			if( not status.dead and player.isDead ) then
				removed = 1
			elseif( player.online ) then
				if(not status.online ) then
					removed = 1
				end
			else
				if(not status.offline ) then
					removed = 1
				end
			end
			if( removed == 0)then
				if( player.range ) then
					if( player.range == 2) then
						if( not status.close ) then
							removed = 1
						end
					else
						if( not status.inrange ) then
							removed = 1
						end
					end
				elseif( not status.outofrange ) then
					removed = 1
				end
				if( removed == 0 )then
					if(not player.online or  player.isDead )then
						statusValid = nil
					end
				end
			end
		end
		-- TODO Add mob filtering

		if(removed == 0) then
			local currBar = OZ_Input.bar[i]
			if( currBar.max > 0)then
				currBar.value	= currBar.current / currBar.max
			else
				currBar.value	= 0
			end
			if( currBar.value > 1 )then
				currBar.value = 1
			elseif( currBar.value < 0 )then
				currBar.value = 0
			end
			if(statusValid)then
				if( currBar.value < OZ_Config[n].filter.injuredVal ) then
					if( not status.injured ) then
						removed = 1
					end
				else
					if( not status.healthy) then
						removed = 1
					end
				end
			end
		end
		if( removed == 1)then
			OZ_FilterRemoveBar(n,i)
		else
			i = i+1
		end
	end	
end

-------------------------------------------------------------------------
--   SORT FUNCTIONS
--
--   These functions generate a sorting weight & sort the bars
--		- return '1' if the sort must be directly applied
--		-  anything that has discrete values can be 
-------------------------------------------------------------------------
function OZ_SortByValueDown(n, scale)
	local i
	if(scale)then
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			bar.sortWeight = bar.sortWeight*scale + bar.value
		end
	else
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			bar.sortWeight = bar.value
		end
	end
	return 1
end

function OZ_SortBySubGroup(n, scale)
	local i
	if(scale)then
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			if(bar.roster > 0) then
				bar.sortWeight = bar.sortWeight + OZ_RaidRoster.member[bar.roster].subgroup * scale
			end
		end
	else
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			if(bar.roster > 0) then
				bar.sortWeight = OZ_RaidRoster.member[bar.roster].subgroup
			end
		end
	end
	return nil
end
local OZ_SORT_CLASS_WEIGHT = {
	["TARGET"] = 0,
	["DRUID"] = 1,
	["HUNTER"] = 2,
	["MAGE"] = 3,
	["PALADIN"] = 4,
	["PRIEST"] = 5,
	["ROGUE"] = 6,
	["SHAMAN"] = 7,
	["WARLOCK"] = 8,
	["WARRIOR"] = 9,
};


function OZ_SortByClass(n, scale)
	local i
	if(scale)then
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			local class = bar.class
			if(class) then
				bar.sortWeight = bar.sortWeight + OZ_SORT_CLASS_WEIGHT[class]*scale
			else
				bar.sortWeight = 0
			end
		end
	else
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			local class = bar.class
			if(class) then
				bar.sortWeight = OZ_SORT_CLASS_WEIGHT[class]
			end
		end
	end
	return nil
end

function OZ_SortByIcon(n, scale)
	local i
	for i = 1,OZ_Input.nBars do
		local bar = OZ_Input.bar[i]
		local val
		if(bar.roster > 0) then
			val = OZ_RaidRoster.member[bar.roster].iconVal
		elseif(bar.target > 0) then
			val = OZ_RaidRoster.target[bar.target].iconVal
		end
		if( not val )then
			val = 9
		end
		if(scale)then
			bar.sortWeight = bar.sortWeight + val*scale
		else
			bar.sortWeight = val
		end
	end
	return nil
end


function OZ_SortByInjured(n, scale)
	local i
	local filter = OZ_Config[n].filter
	if(scale)then
		for i = 1,OZ_Input.nBars do
			local val
			local bar = OZ_Input.bar[i]
			if(bar.roster > 0) then
				if(not OZ_RaidRoster.member[bar.roster].online) then
					val = 4
				elseif(OZ_RaidRoster.member[bar.roster].isDead) then
					val = 3
				end		
			end
			if(not val)then
				if( bar.value < filter.injuredVal ) then
					val = bar.value
				else
					val = 2
				end
			end
			bar.sortWeight = bar.sortWeight + val*scale
		end
	else
		for i = 1,OZ_Input.nBars do
			local val
			local bar = OZ_Input.bar[i]
			if(bar.roster > 0) then
				if(not OZ_RaidRoster.member[bar.roster].online) then
					val = 4
				elseif(OZ_RaidRoster.member[bar.roster].isDead) then
					val = 3
				end		
			end
			if(not val)then
				if( bar.value < filter.injuredVal ) then
					val = bar.value
				else
					val = 2
				end
			end
			bar.sortWeight = val
		end
	end
	return 1
end

function OZ_SortByRange(n, scale)
	local i
	if(scale)then
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			local val
			if(bar.roster > 0) then
				if( OZ_RaidRoster.member[bar.roster].range )then
					val = 3 - OZ_RaidRoster.member[bar.roster].range
				else
					val = 9
				end
			elseif(bar.target > 0) then
				if( OZ_RaidRoster.target[bar.target].range )then
					val = 3 - OZ_RaidRoster.target[bar.target].range
				else
					val = 9
				end
			else
				val = 1
			end
			bar.sortWeight = bar.sortWeight + val*scale
		end
	else
		for i = 1,OZ_Input.nBars do
			local bar = OZ_Input.bar[i]
			if(bar.roster > 0) then
				if( OZ_RaidRoster.member[bar.roster].range )then
					bar.sortWeight = 3 - OZ_RaidRoster.member[bar.roster].range
				else
					bar.sortWeight = 9
				end
			elseif(bar.target > 0) then
				if( OZ_RaidRoster.target[bar.target].range )then
					bar.sortWeight = 3 - OZ_RaidRoster.target[bar.target].range
				else
					bar.sortWeight = 9
				end
			else
				bar.sortWeight = 1
			end
		end
	end
	return nil
end

-------------------------------------------------------------------------
--   COLOUR FUNCTIONS
--
--   Functions for setting bar colours
--
-------------------------------------------------------------------------
OZ_CLASS_COLOURS = {
		DRUID	= RAID_CLASS_COLORS["DRUID"],
		HUNTER	= RAID_CLASS_COLORS["HUNTER"],
		MAGE	= RAID_CLASS_COLORS["MAGE"],
		PALADIN	= RAID_CLASS_COLORS["PALADIN"],
		PRIEST	= RAID_CLASS_COLORS["PRIEST"],
		ROGUE	= RAID_CLASS_COLORS["ROGUE"],
		SHAMAN	= RAID_CLASS_COLORS["SHAMAN"],
		WARLOCK	= RAID_CLASS_COLORS["WARLOCK"],
		WARRIOR	= RAID_CLASS_COLORS["WARRIOR"],

		TARGET	= {r=1.0,g=0.5,b=0.2,a=1.0},

		RANGED	= {r=0.0,g=1.0,b=0.7,a=1.0},
		MELEE	= {r=1.0,g=0.7,b=0.1,a=1.0},
		HEALERS	= {r=1.0,g=0.7,b=0.7,a=1.0},
		TANKS	= {r=1.0,g=0.3,b=0.1,a=1.0},
	};

function OZ_ColourByClass(n)
	-- Set bar colour based on the class
	local i
	for i = 1,OZ_Bars[n].nBars do
--		OZ_Bars[n].bar[i].colour = RAID_CLASS_COLORS[OZ_Bars[n].bar[i].class]
		local bar = OZ_Bars[n].bar[i]
		local dest = bar.colour
		local col = OZ_CLASS_COLOURS[bar.class]
		dest.r = col.r
		dest.g = col.g
		dest.b = col.b
	end
end

function OZ_ColourHealth(n)
	-- Set bar colour based on the class
	local i
	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local dest = bar.colour
		local val = bar.value
		local a

		if( val == 1.0 ) then
			dest.r=0
			dest.g=0.7
			dest.b=0
		elseif( val > 0.75) then
			a = (1.75 - val)
			dest.r=a
			dest.g=1.0
			dest.b=0
		elseif( val > 0.25) then
			a = (val - 0.25) * 1.4
			dest.r=1
			dest.g=a
			dest.b=0
		else
			dest.r=1
			dest.g=0
			dest.b=0
		end
	end
end

function OZ_ColourMana(n)
	-- Set bar colour based on the class
	local i
	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local dest = bar.colour
		local val = bar.value
		local a
		dest.b=1
		if( val == 1.0 ) then
			dest.r=0.2
			dest.g=0.2
		elseif( val > 0.5) then
			a = (val - 0.5)*2
			dest.r=0.1
			dest.g=1-a
		elseif( val > 0.25) then
			a = (val - 0.25) * 3
			dest.r=1-a
			dest.g=a
		else
			dest.r=0.7
			dest.g=0
		end
	end
end

function OZ_ColourHealthBlueParty(n)
	-- Set bar colour based on the class
	local i

	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local dest = bar.colour
		local val = bar.value
		local a
		if( (bar.roster > 0) and
			(OZ_RaidRoster.member[bar.roster].subgroup == OZ_PlayerParty) )then
			dest.b=1
			if( val == 1.0 ) then
				dest.r=0.2
				dest.g=0.2
			elseif( val > 0.5) then
				a = (val - 0.5)*2
				dest.r=0.1
				dest.g=1-a
			elseif( val > 0.25) then
				a = (val - 0.25) * 3
				dest.r=1-a
				dest.g=a
			else
				dest.r=0.7
				dest.g=0
			end
		else		
			dest.b=0
			if( val == 1.0 ) then
				dest.r=0
				dest.g=0.7
			elseif( val > 0.75) then
				a = (1.75 - val)
				dest.r=a
				dest.g=1.0
			elseif( val > 0.25) then
				a = (val - 0.25) * 1.4
				dest.r=1
				dest.g=a
			else
				dest.r=1
				dest.g=0
			end
		end
	end
end
-------------------------------------------------------------------------
--   ICON FUNCTIONS
--
--   Functions to determine what icon to apply to a bar
--
-------------------------------------------------------------------------


-------------------------------------------------------------------------
--   BUFF FUNCTIONS
--
--   Functions to select up to OZ_MAX_BUFFS buffs/debuffs to show on each bar
--
-------------------------------------------------------------------------
function OZ_ShowPlayerBuffs(n)
	local i,j,curr,removed,texture,num,type,key,value
	i = 1
	local status = OZ_Config[n].filter.status
	while(i <= OZ_Input.nBars) do
		curr = 0
		removed = nil
		local bar = OZ_Input.bar[i]
		local buffList = nil
		if(bar.unit)then

			bar.debuff = nil
			bar.nBuffs = 0

--			for j = 1,8 do
			j = 1	-- Only get the first for now
				if(bar.roster > 0)then
					texture, num, type = UnitDebuff(bar.unit, j, 1)
				else
					texture, num, type = UnitBuff(bar.unit, j, 1)
				end
				if(texture)then
					if(status.curable)then
						bar.debuff = texture
					else
						removed = 1
					end
--					break
				else
					if(not status.notcurable)then
						removed = 1
					end
--					break;
				end
--			end

--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Scanning buffs for bar "..i);
			if(not removed)then
				for j = 1,24 do
					if(bar.roster > 0)then
						texture = UnitBuff(bar.unit, j)
						buffList = OZ_Config[n].buffsPlayer
					else
						texture = UnitDebuff(bar.unit, j)
						buffList = OZ_Config[n].buffsMob
					end

					if(texture) then
						for key,value in ipairs(buffList) do
							local watched = value[3] 
							if( texture == watched )then
								if(status.buffed)then
									-- This buff is a watched buff - yay!
									curr = curr + 1
									OZ_SortMap[curr*2 - 1] = 5-value[1]
									OZ_SortMap[curr*2] = key
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."  Found, key = "..key);
									break;
								else
									removed = 1
									break
								end
							end
						end
					else
						break
					end
					if(removed)then
						break
					end
				end
				if( (curr == 0)and(not status.notbuffed) )then
					removed = 1
				end
			end
		end
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."  Found buffs x "..curr);
		if(removed)then
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."  REMOVING bar "..i);
			OZ_FilterRemoveBar(n,i)
		else
			if(curr > 0)then
				-- We found some buffs to show...
				if(curr > 1)then
					OZ_internalMergeSort2(curr * 2)
					if(curr > OZ_MAX_BUFFS)then
						curr = OZ_MAX_BUFFS
					end
				end

				-- Now add them to bars...
				for j = 1,curr do
					local a = OZ_SortMap[j*2]
					bar.buffs[j]	 = buffList[ a ][3]
					bar.buffNames[j] = buffList[ a ][2]
				end
			end
			if(curr < OZ_MAX_BUFFS) then
				for j = curr+1,OZ_MAX_BUFFS do
					bar.buffs[j] = nil
					bar.buffNames[j] =nil
				end
			end
			i = i + 1
		end
	end
end

-------------------------------------------------------------------------
--   HEADING FUNCTIONS
--
--   Functions to set bar heading
--
-------------------------------------------------------------------------
function OZ_HeadingHealth(n)
	local state = 1
	local i
	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local val = bar.value
		if( (val<1) and (state == 1) ) then
			bar.header = "Low"
			state = 2
		end
		if( (val==1) and (state < 3) ) then
			bar.header = "Full"
			state = 3
		elseif(State == 2)then
			-- We are amongst the 'injured' list - clear headers
			bar.header = nil
		end			
	end
end

function OZ_HeadingStatus(n)
	local state = 1
	local i
	local injuredVal = OZ_Config[n].filter.injuredVal
	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local val = bar.value

		if( (val<injuredVal) and (state == 1) ) then
			bar.header = "Injured"
			state = 2
		elseif(state < 3)then
			bar.header = nil
		end

		if( (val>injuredVal) and (state < 3) ) then
			if( not bar.header )then
				-- Only tag 'healthy' if there is no other heading
				bar.header = "Healthy"
			end
			state = 3
		end

		local online,dead
		if( bar.roster > 0 ) then
			local member = OZ_RaidRoster.member[ bar.roster ]
			online = member.online
			dead = member.isDead
		elseif( bar.target > 0 ) then
			local target = OZ_RaidRoster.target[ bar.target ]
			online = target.online
			dead = target.isDead
		else
			online = 1
			dead = nil
		end

		if( not online and state<4 )then
			bar.header = "Offline"
			state = 4
		end
		if( not online and state<5 )then
			bar.header = "Dead"
			state = 5
		end
	end
end

function OZ_HeadingGroup(n)
	local i
	local state = -1
	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local val
		if( bar.roster > 0 ) then
			val = OZ_RaidRoster.member[ bar.roster ].subgroup
		elseif(  bar.target > 0 ) then
			val = OZ_RaidRoster.target[ bar.target ].subgroup
		else
			 val = 0
		end
		if( val ~= state) then
			if(val == 0) then
				bar.header = "Mobs"
			else
				bar.header = "Group "..val
			end
			state = val
		end			
	end
end

function OZ_HeadingClass(n)
	local state = ""
	local i
	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local curr = bar.class
		if( state ~= curr )then
			bar.header = curr
			state = curr
		end
	end
end

function OZ_HeadingRange(n)
	local state = -1
	local i
	for i = 1,OZ_Bars[n].nBars do
		local bar = OZ_Bars[n].bar[i]
		local val
		if( bar.roster > 0 ) then
			val = OZ_RaidRoster.member[ bar.roster ].range
		elseif(  bar.target > 0 ) then
			val = OZ_RaidRoster.target[ bar.target ].range
		else
			val = nil
		end
		if( val ~= state) then
			if(val)then
				if(val == 2)then
					bar.header = "Close"
				else
					bar.header = "In Range"
				end
			else
				bar.header = "Out of Range"
			end
			state = val
		end			
	end
end

