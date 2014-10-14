--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the Sea people, the Cosmos team and finally the nice (but strange) people at 
	 #cosmostesters and Blizzard.
	
	CosmosUI URL:
	http://www.cosmosui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

--[[

	Note: 
	Currently it is set up to gather spells on change.
	This is may lag the game.
]]



--[[
	Information returned by the DynamicData.spell.get*SpellInfo() methods

An array is returned with the following values

	id						-- the id of the spell
	spellBook				-- the spellBook of the spell
	name					-- the name of the spell
	rank					-- the rank of the spell (if any, empty string otherwise);
	realRank				-- a number representing the rank of the spell (if any, empty string otherwise);
	strings					-- an array with strings that represent the tooltip of the spell
	texture					-- the pathname to the spells texture
	passive					-- if true, this spell is passive, if not, it is not

]]--



-- Spell information
DynamicData.spell = {

-- public functions	

	-- 
	-- addOnSpellUpdateHandler (func)
	--
	--  Adds a function name that will be called on spell updates.
	--  Function will have one paremeter - id and spellBook, id may be nil.
	--
	addOnSpellUpdateHandler = function (func)
		return DynamicData.util.addOnWhateverHandler(DynamicData.spell.OnSpellUpdateHandlers, func);
	end;

	-- 
	-- removeOnSpellUpdateHandler (func)
	--
	--  Removes the specified function, so that it will not be called on inventory updates.
	--
	removeOnSpellUpdateHandler = function (func)
		return DynamicData.util.removeOnWhateverHandler(DynamicData.spell.OnSpellUpdateHandlers, func);
	end;

	-- 
	-- getSpellInfo (id, spellBook)
	--
	--  Retrieves an array with spell information of the spell associated with the id.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	getSpellInfo = function (id, spellBook) 
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		if ( ( not DynamicData.spell.spells ) ) then
			DynamicData.spell.spells = {};
		end
		if ( ( not DynamicData.spell.spells[spellBook] ) ) then
			DynamicData.spell.spells[spellBook] = {};
		end
		if ( DynamicData.spell.spells[spellBook][id] ) then
			return DynamicData.spell.spells[spellBook][id];
		else
			if ( not id ) then
				return DynamicData.spell.createEmptySpellArray();
			end
			local spellInfo = DynamicData.spell.retrieveSpellInfo(id, spellBook);
			DynamicData.spell.spells[spellBook][id] = spellInfo;
			DynamicData.util.notifyWhateverHandlers(DynamicData.spell.OnSpellUpdateHandlers, id, spellBook);
			return spellInfo;
		end
	end;
	
	
	
	-- 
	-- getMatchingSpellId (name, rank, spellBook, texture)
	--
	--  Returns the id of a matching spells id or nil if no such spell can be found.
	--  Setting a parameter to nil means that it will be disregarded.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	getMatchingSpellId = function (name, rank, spellBook, texture, startId)
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		if ( not startId ) then startId = 1; end
		local id = startId-1;
		local spellInfo = nil;
		local ok = true;
		local realRank = nil;
		if ( rank ) then
			realRank = DynamicData.spell.getRankFromString(rank);
		end
		while (ok) do
			id = id + 1;
			spellInfo = DynamicData.spell.getSpellInfo(id, spellBook);
			if ( ( not spellInfo ) or ( ( not spellInfo.name ) or ( strlen(spellInfo.name) <= 0 ) ) ) then
				return nil;
			end
			if (
				( ( not name ) or ( spellInfo.name == name ) ) and
				( ( not rank ) or ( DynamicData.spell.getRankFromString(spellInfo.rank) == realRank ) ) and
				( ( not texture ) or ( spellInfo.texture == texture ) ) ) then
				return id;
			end
		end
		return nil;
	end;
	
	-- 
	-- getHighestSpellId (name, spellBook, texture)
	--
	--  Returns the id of the highest ranked spell matching the parameters, or nil if no such spell is found.
	--  Setting a parameter to nil means that it will be disregarded.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	getHighestSpellId = function (name, spellBook, texture)
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		if ( not startId ) then startId = 1; end
		local id = 0;
		local spellInfo = nil;
		local done = false;
		local spellInfo = nil;
		local highestId = nil;
		local highestRank = nil;
		local currentRank = nil;
		while ( not done ) do
			id = id + 1;
			id = DynamicData.spell.getMatchingSpellId(name, nil, spellBook, texture, id);
			if ( not id ) then
				return highestId;
			end
			spellInfo = DynamicData.spell.getSpellInfo(id, spellBook);
			currentRank = DynamicData.spell.getRankFromString(spellInfo.rank);
			if ( ( not highestRank ) or ( spellInfo.realRank > highestRank ) ) then
				if ( currentRank ) then
					highestRank = currentRank;
				end
				highestId = id;
			end
		end
		return highestId;
	end;
	
	-- 
	-- updateSpells (id, spellBook)
	--
	--  Updates the spells of a specific id or everything.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	updateSpells = function (id, spellBook) 
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		tmp = spellBook;
		if ( id ) then
			DynamicData.spell.spells[id] = nil;
			tmp = tmp.."_"..id;
		else
			DynamicData.spell.spells = {};
		end
		params = {
			func = DynamicData.spell.doUpdateSpells,
			params = { id, spellBook },
			allowInitialUpdate = 1,
			schedulingName = "DynamicData_spell_UpdateSpells_"..tmp,
		};
		DynamicData.util.postpone(params);
	end;


	--
	-- getSpellCooldown (id, spellBook)
	--
	--  Retrieves the cooldown of the spell associated with the id.
	--  It is returned as three values - start, duration and enable.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	getSpellCooldown = function(id, spellBook)
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		local start = 0;
		local duration = 0;
		local enable = 0;
		start, duration, enable = GetSpellCooldown(id, spellBook);
		return start, duration, enable;
	end;

	--
	-- getSpellCooldownArray (id, spellBook)
	--
	--  Retrieves the cooldown of the spell associated with the id.
	--  It is returned as an array - use result.start, result.duration and result.enable to access the variables.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	getSpellCooldownArray = function(id, spellBook)
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		local cooldownArray = {};
		local start, duration, enable = GetSpellCooldown(id, spellBook);
		cooldownArray = { [1] = start, [2] = duration, [3] = enable };
		cooldownArray.start = start;
		cooldownArray.duration = duration;
		cooldownArray.enable = enable;
		return cooldownArray;
	end;
	

	--
	-- isSpellReady (id, spellBook)
	--
	--  Determines if the spell is ready. Uses isSpellUsable and getSpellCooldown.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	isSpellReady = function(id, spellBook)
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		local isUsable = DynamicData.spell.isSpellUsable(id, spellBook);
		if ( isUsable ) then
			local cooldown = DynamicData.spell.getSpellCooldownArray(id, spellBook);
			if ( cooldown.start == 0 ) and ( cooldown.duration == 0 ) then
				-- TODO: handle enable here
				return true;
			else
				local curTime = GetTime();
				if ( cooldown.start + cooldown.duration < GetTime() ) then
					return true;
				else
					return false;
				end
			end
		end
		return false;
	end;
	
	--
	-- isSpellUsable (id)
	--
	--  Determines if the spell is usable. Does not regard the cooldown.
	--  Defaults to true if spell is not in the action bar(s).
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	isSpellUsable = function(id, spellBook)
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		if ( DynamicData.action ) and ( DynamicData.action.getSpellAsActionId ) and ( DynamicData.action.isActionUsable ) then
			local spellName, rankName = GetSpellName(id, spellBook);
			local actionId = DynamicData.action.getSpellAsActionId(spellName, rankName, GetSpellTexture(id, spellBook));
			if ( not actionId ) or ( actionId == -1 ) then
				return true;
			else
				return DynamicData.action.isActionUsable(actionId);
			end
		else
			return true;
		end
	end;

	--
	-- getRankFromString (rankName)
	--
	--  Retrieves a rank number from a rank string.
	--
	getRankFromString = function(rankName)
		if ( type(rankName) == "string" ) then
			local index = strfind(rankName, TEXT(DYNAMICDATA_RANK));
			if ( index ) then
				index = index + strlen(TEXT(DYNAMICDATA_RANK));
				rankName = strsub(rankName, index+1);
			end
			while ( strsub(rankName, 1, 1) == " ") do
				rankName = strsub(rankName, 2);
			end
			local rank = tonumber(rankName);
			return rank;
		elseif ( type(rankName) == "number" ) then
			return rankName;
		else
			return nil;
		end
	end;

-- protected functions

	--
	-- retrieveSpellInfo (id)
	--
	--  Retrieves data about a specific spell. Returns nil if given an invalid id.
	--  spellBook is assumed to be BOOKTYPE_SPELL unless specified
	--
	retrieveSpellInfo = function (id, spellBook)
		if ( not spellBook ) then spellBook = BOOKTYPE_SPELL; end
		if ( not id ) or ( type(id) ~= "number" ) or ( id <= -1 ) then
			return DynamicData.spell.createEmptySpellArray();
		end
		local spellName, rankName = GetSpellName(id, spellBook);
		if ( not spellName ) then
			return DynamicData.spell.createEmptySpellArray();
		end
		local texture = GetSpellTexture(id, spellBook);
		if ( not texture ) then
			return DynamicData.spell.createEmptySpellArray();
		end
		local tooltipName = "DynamicDataTooltip";
		local tooltip = getglobal(tooltipName);
		DynamicData.util.clearTooltipStrings(tooltipName);
		DynamicData.util.protectTooltipMoney();
		tooltip:SetSpell(id, spellBook);
		DynamicData.util.unprotectTooltipMoney();
		local element = {};
		element.id = id;
		element.spellBook = spellBook;
		element.strings = DynamicData.util.getTooltipStrings(tooltipName);
		element.texture = texture;
		element.passive = IsSpellPassive(id, spellBook);
		element.name = spellName;
		element.rank = rankName;
		element.realRank = DynamicData.spell.getRankFromString(rankName);
		return element;
	end;

	-- 
	-- doUpdateSpells (id, spellBook)
	--
	--  Updates a specified spell or ALL spells.
	--  If spellBook is not specified, all spellbooks are updated.
	--
	doUpdateSpells = function (id, spellBook) 
		local safe = DynamicData.util.safeToUseTooltips();
		if ( not safe ) then
			if ( id ) then
				Cosmos_ScheduleByName("DynamicData_spell_doUpdateSpells", 0.1, DynamicData.spell.doUpdateSpells, id, spellBook);
			else
				Cosmos_ScheduleByName("DynamicData_spell_doUpdateSpellsUnspecified", 0.1, DynamicData.spell.doUpdateSpells, id, spellBook);
			end
			return;
		end
		if ( not DynamicData.spell.spells ) then
			DynamicData.spell.spells = {};
		end
		if (spellBook) and ( not DynamicData.spell.spells[spellBook] ) then
			DynamicData.spell.spells[spellBook] = {};
		end
		if ( id ) then
			if ( not spellBook ) then
				DynamicData.spell.doUpdateSpells(id, BOOKTYPE_SPELL);
				DynamicData.spell.doUpdateSpells(id, BOOKTYPE_PET);
				return;
			end
			DynamicData.spell.spells[spellBook][id] = {};
			DynamicData.spell.spells[spellBook][id] = DynamicData.spell.retrieveSpellInfo(id, spellBook);
			DynamicData.util.notifyWhateverHandlers(DynamicData.spell.OnSpellUpdateHandlers, id, spellBook);
		else
			--[[
			if ( not spellBook ) then
				DynamicData.spell.doUpdateSpells(id, BOOKTYPE_SPELL);
				DynamicData.spell.doUpdateSpells(id, BOOKTYPE_PET);
				return;
			end
			DynamicData.spell.spells[spellBook] = {};
			local i = 0;
			local ok = true;
			local spellInfo = nil;
			while ( ok ) do
				i = i + 1;
				spellInfo = DynamicData.spell.retrieveSpellInfo(i, spellBook);
				if ( ( spellInfo.name ) and ( strlen(spellInfo.name) > 0 ) ) then
					DynamicData.spell.spells[spellBook][i] = spellInfo;
				else
					ok = false;
				end
			end
			DynamicData.util.notifyWhateverHandlers(DynamicData.spell.OnSpellUpdateHandlers, nil, spellBook);
			]]--
			DynamicData.spell.doUpdateAllSpells();
		end
	end;

	-- 
	-- doUpdateAllSpells (idsPerIteration, currentId, spellBook)
	--
	--  Updates all spells, by chunking the info pulling.
	--
	doUpdateAllSpells = function (idsPerIteration, currentId, spellBook) 
		if ( not idsPerIteration ) then
			idsPerIteration = DYNAMICDATA_DEFAULT_NUMBER_OF_TOOLTIP_SCANS_PER_UPDATE;
		end
		if ( idsPerIteration == -1 ) then
			return;
		end
		if ( not spellBook ) then
			spellBook = BOOKTYPE_SPELL;
		end
		if ( not currentId ) then
			-- do chunking
			Cosmos_ScheduleByName("DynamicData_spell_doUpdateSpells", 0.1, DynamicData.spell.doUpdateSpells, idsPerIteration, 1, spellBook);
			return;
		else
			-- overwrite scheduled event
			Cosmos_ScheduleByName("DynamicData_spell_doUpdateSpells", 0.1, DynamicData.spell.doUpdateSpells, -1);
		end
		local maxId = currentId + idsPerIteration - 1;
		local ok = true;
		for i = currentId, maxId do
			spellInfo = DynamicData.spell.retrieveSpellInfo(i, spellBook);
			if ( ( spellInfo.name ) and ( strlen(spellInfo.name) > 0 ) ) then
				DynamicData.spell.spells[spellBook][i] = spellInfo;
			else
				ok = false;
				break;
			end
		end
		currentId = maxId+1;
		if ( ok ) then
			Cosmos_ScheduleByName("DynamicData_spell_doUpdateSpells", 0.1, DynamicData.spell.doUpdateSpells, idsPerIteration, currentId, spellBook);
		else
			DynamicData.util.notifyWhateverHandlers(DynamicData.spell.OnSpellUpdateHandlers, nil, spellBook);
			local nextSpellBook = DynamicData.spell.getNextSpellBook(spellBook);
			if ( nextSpellBook ) then
				Cosmos_ScheduleByName("DynamicData_spell_doUpdateSpells", 0.1, DynamicData.spell.doUpdateSpells, idsPerIteration, 1, nextSpellBook);
			end
		end
	end;
	
	--
	-- getNextSpellBook (spellBook)
	--
	--  Retrieves the next spellbook after the indicated spellbook or nil if there is no other spellbook.
	--
	getNextSpellBook = function (spellBook)
		if ( spellBook == BOOKTYPE_SPELL ) then
			return BOOKTYPE_PET;
		else
			return nil;
		end
	end;


-- private functions	

	--
	-- OnLoad ()
	--
	--  Sets up the DynamicData.spell for operation.
	--  In this case, it retrieves the IDs for the inventory slots.
	--
	OnLoad = function ()
		DynamicData.spell.spells = {};
		DynamicData.spell.doUpdateSpells();
	end;

	--
	-- createEmptySpellArray ()
	-- 
	--  creates an empty spell array
	--
	createEmptySpellArray = function ()
		local spellArray = {};
		local baseSpell = nil;
		if ( not baseSpell ) then
			baseSpell = DynamicData.spell.defaultSpell;
		end
		for k, v in baseSpell do
			spellArray[k] = v;
		end
		return spellArray;
	end;

-- variables

	defaultSpell = {
		name = "",
		rank = "",
		strings = {
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
			[5] = {},
			[6] = {},
			[7] = {},
			[8] = {},
			[9] = {},
			[10] = {},
			[11] = {},
			[12] = {},
			[13] = {},
			[14] = {},
			[15] = {}
		},
		texture = "",
		passive = false
	};

	-- Contains spell data about the different spells.
	spells = nil;

	-- Contains the function pointers to functions that want to be called whenever the spells updates.
	-- Will be called AFTER the DynamicData has parsed the spells.
	OnSpellUpdateHandlers = {};	

};

