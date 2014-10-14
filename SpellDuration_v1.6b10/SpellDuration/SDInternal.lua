----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Internal Functions]
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- ACTIONBAR
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDUseButton
----------------------------------------------------------------------------------------------------
function SDUseButton(rank)

	if(not rank) then
		SDSpell["Rank"] = 0;
	else
		for n in string.gfind (rank, SD_RANK_REGEX) do
			SDSpell["Rank"] = tonumber(n);
		end
		getglobal("SpellDurationTooltipTextRight1"):SetText(nil);
	end
	
	local index, spell;
	if(SDVars.RegisteredRace) then
		for index, spell in SDRacialTable[SDVars.Race] do
			if(string.find(spell.name, SDEvent["SpellName"])) then
				SDEvent["SpellName"] = spell.name;
				break;
			end
		end
		index = nil; spell = nil;
	end
	
	if(not SDVars.RegisteredClass) then return; end
	if(not SDEvent["Target"]) then SDEvent["Target"] = 0; end
	for index, spell in SDSpellsTable[SDVars.Class] do
		if(string.find(spell.name, SDEvent["SpellName"])) then
			if(spell.aoe) then SDEvent["Target"] = SDGlobal.AoE; end
			SDEvent["SpellName"] = spell.name;
			
			if(spell.selfcast and SDEvent["Target"] == UnitName("player")) then
				SDEvent["SpellName"] = "";
				return;
			end
			
			if(spell.caststop) then
				SDEvent["Target"] = math.random(10000000000);
			end
			
			-- Initialize the duration for spells that has some Talent improvements or a greater spell rank 
			local improved = SDSetDuration(SDEvent["SpellName"], SDSpell["Rank"]);
			
			if(not SDSpell["Rank"]) then SDSpell["Rank"] = "nil"; end
			
			-- If the bar isn't visible from any kind of reason iterate on the queue and eliminate it
			local pointer, queue;
			for pointer, queue in SDQueueTable do
				if(not getglobal(queue.frame):IsVisible()) then
					SDSendMsg(queue.frame);
					queue.finish = GetTime();
					table.remove(SDQueueTable, pointer);
				end
			end
			
			if(spell.casting or spell.special) then
				-- Do Nothing
			else
				if(spell.environment or spell.caststop) then return; end
				SDQueueUpdate(SDEvent["SpellName"], SDEvent["Target"], GetTime());
			end
			return;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- QUEUE
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDQueueUpdate
----------------------------------------------------------------------------------------------------
function SDQueueUpdate(spellName, unit, time)

	local size = table.getn(SDQueueTable);
	local index, spell;
	
	-- If there was a recast handle it properly and nullify all values for this bar
	for index, spell in SDSpellsTable[SDVars.Class] do
		if(spellName == spell.name) then
			if(size >= 1) then
				local pointer, queue;
				for pointer, queue in SDQueueTable do
					if((spellName == queue.spell and unit == queue.target) or (spellName == queue.spell and queue.spellId == "HuntersMark")) then
						if(string.find(queue.frame, "SpellDurationBar")) then
							local BarFrame = getglobal(queue.frame);
							local StatusBar = getglobal(queue.frame.."StatusBar");
							local Spark = getglobal(queue.frame.."StatusBarSpark");
							BarFrame:SetAlpha(1);
							StatusBar:SetStatusBarColor(1.0, 0.7, 0.0);
							Spark:SetPoint("CENTER", StatusBar:GetName(), "LEFT", 0, 0);
						end
						queue.target = unit;
						queue.start = time;
						queue.finish = time + spell.duration;
						queue.spell = spell.name;
						queue.player = SDEvent["IsPlayer"];
						break;
					end
				end
			else
				return;
			end
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDQueueFades
----------------------------------------------------------------------------------------------------
function SDQueueFades(spellName, unit, time)
	-- Checking for critter match
	if(SDIsCritter(unit)) then return; end
	-- Check if MY target still affected by the spell
	if(not SDIsSpellDone(spellName)) then return; end
	local pointer, queue;
	-- Iterate through the queue intend to eliminate the spell which didn't end but the effect got broken
	for pointer, queue in SDQueueTable do
		if(not SDUnitDeathSpellIgnored(queue.spellId)) then
			if(spellName == queue.spell and unit == queue.target and SDEvent["Tapped"]) then
				queue.finish = time; 
				break;
			end
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDQueueRemove
----------------------------------------------------------------------------------------------------
function SDQueueRemove(mode, unit)
	local size = table.getn(SDQueueTable);
	if(size >= 1) then
		local pointer, queue;
		for pointer, queue in SDQueueTable do
			if(not SDUnitDeathSpellIgnored(queue.spellId)) then
				if(mode == "ALL") then
					queue.finish = GetTime();
				elseif(mode == "MOBS") then
					if(not queue.player) then queue.finish = GetTime(); end
				elseif(mode == "TARGET") then
					if(queue.target == unit and SDEvent["Tapped"]) then
						local t = 0;
						local p, q;
						-- Iterate through the queue and see if we have identical targetss
						for p, q in SDQueueTable do
							if(unit == q.target) then t = t + 1; end
						end
						if(t == 1) then queue.finish = GetTime(); end
						return;
					end
				end
			end
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDQueueRemoveSpellsOnCombat
----------------------------------------------------------------------------------------------------
function SDQueueRemoveSpellsOnCombat()
	local size = table.getn(SDQueueTable);
	if(size >= 1) then
		local pointer, queue, kill;
		for pointer, queue in SDQueueTable do
			kill = false;
			if(queue.spellId == "Distract") then
				kill = true;
			end
			if(kill) then queue.finish = GetTime(); end
		end
	end
end

----------------------------------------------------------------------------------------------------
-- SPELLS
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDSetDuration
-- Comment	: Set the spell rank duration 
----------------------------------------------------------------------------------------------------
function SDSetDuration(abilityName, abilityRank)
	local index = 1;
	local talent = "";
	local duration = 0;
	local spell, talentRank;
	
	-- If the ability is not found on the Talent table it means no special treatment needed, now get out !
	if(not SDTalentTable[abilityName]) then return false; end
	
	-- Retrieve the talent name of this spell
	index = nil; spell = nil;
	for index, spell in SDLocalizedSpellsTable[SDVars.Class] do
		if(abilityName == spell.name) then 
			talent = spell.talent;
			break;
		end
	end
	
	-- If a talent name was found for this spell iterate through the talents and see whats the talent rank
	if(talent ~= "") then
		local tabs = GetNumTalentTabs();
		local talents, name, rank;
		for t=1, tabs do
			talents = GetNumTalents(t);
			for i = 1, talents do
				name, _, _, _, rank, _ = GetTalentInfo(t,i);
				if(name == talent) then 
					talentRank = rank;
					break;
				end
			end
		end
	end
	
	-- Get the spell rank duration from the Talent table
	index = nil; spell = nil;
	for index, spell in SDTalentTable[abilityName] do
		-- If the spell duration is equal for all the ranks just set the fixed duration value
		if(spell.rank == 0) then 
			duration = spell.duration;
			-- Special case for Kidney Shot :(
			if(abilityName == SDLocalizedSpellsTable[SDClassTable.Rogue][3].name) then
				duration = SDEvent["ComboPoint"]; 
				if(abilityRank == 2) then duration = SDEvent["ComboPoint"] + 1; end
			end 
			-- Special case for Rupture :(
			if(abilityName == SDLocalizedSpellsTable[SDClassTable.Rogue][14].name) then
				if(SDEvent["ComboPoint"] == 1) then duration = 8; end
				if(SDEvent["ComboPoint"] == 2) then duration = 10; end
				if(SDEvent["ComboPoint"] == 3) then duration = 12; end
				if(SDEvent["ComboPoint"] == 4) then duration = 14; end
				if(SDEvent["ComboPoint"] == 5) then duration = 16; end
			end 
			break; 
		end
		if(abilityRank == spell.rank) then 
			duration = spell.duration;
			break;
		end
	end
	
	-- If a talent rank was found add the duration needed to the total duration
	if(talentRank) then
		index = nil; spell = nil;
		for index, spell in SDTalentTable[talent] do
			if(talentRank == spell.rank) then
				if(spell.fraction) then
					duration = duration + ((duration / 100)*spell.duration)
				else
					duration = duration + spell.duration;
				end 
				break;
			end
		end
	end
	
	-- Initialize the duration for this ability
	index = nil; spell = nil;
	for index, spell in SDSpellsTable[SDVars.Class] do
		if(abilityName == spell.name) then 
			spell.duration = duration;
			return true;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDGetSpellID
----------------------------------------------------------------------------------------------------
function SDGetSpellID(spellName)
	if(spellName) then spellName = strlower(spellName); end
	local i, done, sName, sRank, pName, pRank, id, spellRank=1, false;
	_, _, spellRank = string.find(spellName,"%((rank %d+)%)");
	spellName = string.gsub(spellName,"%(rank %d+%)","");
	spellName = string.gsub(spellName,"%(()%)","");
	if(spellRank) then spellRank = strlower(spellRank); end
	while not done do
		sName, sRank = GetSpellName(i,BOOKTYPE_SPELL);
		pName, pRank = GetSpellName(i,BOOKTYPE_PET);
		if(sName) then sName = strlower(sName); end
		if(sRank) then sRank = strlower(sRank); end
		if(pName) then pName = strlower(pName); end
		if(pRank) then pRank = strlower(pRank); end
		if(not sName and not pName) then
			done = true;
		elseif((sName == spellName and not spellRank)
		or (sName == spellName and sRank == spellRank))
		or ((pName == spellName and not spellRank) 
		or (pName == spellName and pRank == spellRank))then
			id = i;
		end 
		i = i + 1;
	end
	return id
end

----------------------------------------------------------------------------------------------------
-- Name		: SDIsSpellID
----------------------------------------------------------------------------------------------------
function SDIsSpellID(id)	
	local tabs = GetNumSpellTabs();
	local spells;
	for t = 1, tabs do
		_, _, _, spells = GetSpellTabInfo(t);
		for s = 1, spells do
			if(s == id) then return true; end
		end
	end
	return false;
end

----------------------------------------------------------------------------------------------------
-- Name		: SDIsSpellDone
----------------------------------------------------------------------------------------------------
function SDIsSpellDone(spellName)
	local i = 1;
	local spell;
	SpellDurationTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	while(UnitDebuff("target", i)) do
		SpellDurationTooltip:SetUnitDebuff("target", i);
		spell = SpellDurationTooltipTextLeft1:GetText();
		if(spellName == spell) then return false; end
		i = i + 1;
	end
	return true;
end

----------------------------------------------------------------------------------------------------
-- Name		: SDUnitDeathSpellIgnored
----------------------------------------------------------------------------------------------------
function SDUnitDeathSpellIgnored(spellId)
	if(spellId == "FrostTrap") then
		return true;
	elseif(spellId == "Flare") then
		return true;
	end
	return false;
end

----------------------------------------------------------------------------------------------------
-- UNIT
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDIsCritter
----------------------------------------------------------------------------------------------------
function SDIsCritter(unit)
	local index, critter
	-- Checking for critter match and return true otherwise false
	for index, critter in SDCritterTable do
		if(unit == critter) then
			return true; 
		end
	end
	return false;
end

--[[--------------------------------------------------------------------------------------------------
-- Name		: SDDiminishingHandler
----------------------------------------------------------------------------------------------------
function SDDiminishingHandler(spellName, playerName, time, duration)

	local factor = 0;
	local index, player, spell;
	
	-- If this spell doesn't suffer from diminishing return get out and return the duration
	for index, spell in SDSpellsTable[SDVars.Class] do
		if(spellName == spell.name and not spell.diminish) then return duration; end
	end
	
	table.insert(SDDiminishTable, {
		name = playerName,
		spell = spellName,
		limit = 0,
		diminishing = time,
		factor = 0,
	});
	
	-- Clear diminishing return when the current time is higher then diminishing time plus the interval
	index = nil;
	for index, player in SDDiminishTable do
		if(GetTime() > (player.diminishing+SDGlobal.DiminishInterval)) then
			table.remove(SDDiminishTable, index);
		end
	end
	
	-- Set the diminishing return values for each spell being casted for this player
	index = nil; player = nil;
	for index, player in SDDiminishTable do
		if(playerName == player.name and spellName == player.spell) then
			if(player.limit <= 4) then
				player.diminishing = GetTime();
				player.limit = player.limit + 1;
				player.factor = (duration/player.limit);
				if(player.limit == 4) then player.factor = 0; end
				factor = player.factor;
				break; 
			end
		end
	end
	
	-- Remove any enrty in the table which its limit is zero
	index = nil; player = nil;
	for index, player in SDDiminishTable do
		if(player.limit == 0) then table.remove(SDDiminishTable, index); end
	end
	return factor;
end

----------------------------------------------------------------------------------------------------
-- Name		: SDDiminishingReset
----------------------------------------------------------------------------------------------------
function SDDiminishingReset(type)

	local index, player, size;
	
	-- Clear diminishing return when this is dead
	size = table.getn(SDDiminishTable);
	if(size >= 1) then
		for index, player in SDDiminishTable do
			if(type == player.name) then
				table.remove(SDDiminishTable, index);
			end
		end
	end
end]]