--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the Sea people, the Cosmos team and finally the nice (but strange) people at 
	 #cosmostesters and Blizzard.
	
	CosmosUI URL:
	http://www.cosmosui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

DYNAMICDATA_ACTION_MAXIMUM_NUMBER = 120;

--[[

	Note: 
	Currently it is set up to gather actions on change.
	This is may lag the game.
]]



--[[
	Information returned by the DynamicData.action.get*ActionInfo() methods

An array is returned with the following values

	name					-- the name of the action
	strings					-- an array with strings that represent the tooltip of the action
	texture					-- the pathname to the actions texture

]]--



-- Action information
DynamicData.action = {

-- public functions	

	-- 
	-- addOnActionUpdateHandler (func)
	--
	--  Adds a function name that will be called on action updates.
	--  Function will have one paremeter - id, which may be nil.
	--
	addOnActionUpdateHandler = function (func)
		return DynamicData.util.addOnWhateverHandler(DynamicData.action.OnActionUpdateHandlers, func);
	end;

	-- 
	-- removeOnActionUpdateHandler (func)
	--
	--  Removes the specified function, so that it will not be called on inventory updates.
	--
	removeOnActionUpdateHandler = function (func)
		return DynamicData.util.removeOnWhateverHandler(DynamicData.action.OnActionUpdateHandlers, func);
	end;

	-- 
	-- getActionInfo (id)
	--
	--  Retrieves an array with action information of the action associated with the id.
	--
	getActionInfo = function (id) 
		if ( ( not DynamicData.action.actions ) ) then
			DynamicData.action.actions = {};
		end
		if ( DynamicData.action.actions[id] ) then
			return DynamicData.action.actions[id];
		else
			if ( not id ) then
				return DynamicData.action.createEmptyActionArray();
			end
			local actionInfo = DynamicData.action.retrieveActionInfo(id);
			return actionInfo;
		end
	end;
	
	-- 
	-- getMatchingActionId (name, texture)
	--
	--  Returns the id of a matching actions id or nil if no such action can be found.
	--  Setting a parameter to nil means that it will be disregarded.
	--
	getMatchingActionId = function (name, texture, startId)
		if ( not startId ) then startId = 1; end
		local id = 1;
		local actionInfo = nil;
		for id = startId, DYNAMICDATA_ACTION_MAXIMUM_NUMBER do
			actionInfo = DynamicData.action.getActionInfo(id);
			if (
				( ( not name ) or ( actionInfo.name == name ) ) and
				( ( not texture ) or ( actionInfo.texture == texture ) ) ) then
				return id;
			end
		end
		return nil;
	end;
	
	-- 
	-- getSpellAsActionId (spellName, spellRank, texture)
	--
	--  Returns the id of a matching action id or nil if no such action can be found.
	--  Setting a parameter to nil means that it will be disregarded.
	--
	getSpellAsActionId = function (spellName, spellRank, texture)
		local found = false;
		local actionInfo = nil;
		local spellRankAsNumber = nil;
		if ( spellRank ) then
			if ( type(spellRank) == "string" ) then
				if ( strlen(spellRank) > 0 ) then
					spellRankAsNumber = tonumber(spellRank);
				else
					spellRank = nil;
				end
			else
				spellRankAsNumber = spellRank;
			end
		end
		local curId = 0;
		while ( not found ) do
			curId = curId + 1;
			curId = DynamicData.action.getMatchingActionId(spellName, texture, curId);
			if ( curId == nil ) then
				return nil;
			end
			if ( not spellRank ) then
				found = true;
			else
				actionInfo = DynamicData.action.getActionInfo(curId);
				local rankStr = nil;
				if ( ( actionInfo.strings[1] ) and ( actionInfo.strings[1].right) ) then
					rankStr = actionInfo.strings[1].right;
				end
				if ( rankStr ) then
					if ( spellRankAsNumber ) then
						-- TODO: improve pattern recognition - WILL require localization.
						if ( strfind(rankStr, spellRank) ) then
							found = true;
						end
					elseif ( rankStr == spellRank ) then
						found = true;
					end
				end
			end
		end
		
		return curId;
	end;
	
	-- 
	-- updateActions (id)
	--
	--  Updates the actions of a specific id or everything.
	--
	updateActions = function (id) 
		tmp = "";
		if ( id ) then
			DynamicData.action.actions[id] = nil;
			tmp = id;
		else
			DynamicData.action.actions = {};
		end
		params = {
			func = DynamicData.action.doUpdateActions,
			params = { id },
			allowInitialUpdate = 1,
			schedulingName = "DynamicData_action_UpdateActions_"..tmp,
		};
		DynamicData.util.postpone(params);
	end;


	--
	-- getActionCount (id)
	--
	--  Retrieves the count of the action associated with the id.
	--
	getActionCount = function(id)
		if ( ( id < 1 ) or ( id > DYNAMICDATA_ACTION_MAXIMUM_NUMBER ) ) then
			return 0;
		end
		return GetActionCount(id);
	end;

	--
	-- getActionCooldown (id)
	--
	--  Retrieves the cooldown of the action associated with the id.
	--  It is returned as three values - start, duration and enable.
	--
	getActionCooldown = function(id)
		local start = 0;
		local duration = 0;
		local enable = 0;
		if ( ( id < 1 ) or ( id > DYNAMICDATA_ACTION_MAXIMUM_NUMBER ) ) then
		else
			start, duration, enable = GetActionCooldown(id);
		end
		return start, duration, enable;
	end;

	--
	-- getActionCooldown (id)
	--
	--  Retrieves the cooldown of the action associated with the id.
	--  It is returned as an array - use result.start, result.duration and result.enable to access the variables.
	--
	getActionCooldownArray = function(id)
		local cooldownArray = {};
		if ( ( id < 1 ) or ( id > DYNAMICDATA_ACTION_MAXIMUM_NUMBER ) ) then
			cooldownArray = { [1] = 0, [2] = 0, [3] = 0, start = 0, duration = 0, enable = 0 };
		else
			local start, duration, enable = GetActionCooldown(id);
			cooldownArray = { [1] = start, [2] = duration, [3] = enable };
			cooldownArray.start = start;
			cooldownArray.duration = duration;
			cooldownArray.enable = enable;
		end
		return cooldownArray;
	end;
	

	--
	-- isActionReady (id)
	--
	--  Determines if the action is ready. Uses isActionUsable and getActionCooldown.
	--
	isActionReady = function(id)
		local isUsable = DynamicData.action.isActionUsable(id);
		if ( isUsable ) then
			local cooldown = DynamicData.action.getActionCooldownArray(id);
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
	-- isActionUsable (id)
	--
	--  Determines if the action is usable. Does not regard the cooldown.
	--
	isActionUsable = function(id)
		if ( ( id < 1 ) or ( id > DYNAMICDATA_ACTION_MAXIMUM_NUMBER ) ) then
			return false;
		end
		local isUsable, notEnoughMana = IsUsableAction(id);
		if ( ( isUsable ) and ( not notEnoughMana ) ) then
			return true;
		else	
			return false;
		end
	end;

-- protected functions

	--
	-- retrieveActionInfo (id)
	--
	--  Retrieves data about a specific action. Returns nil if given an invalid id.
	--
	retrieveActionInfo = function (id)
		if ( ( id < 1 ) or ( id > DYNAMICDATA_ACTION_MAXIMUM_NUMBER ) ) then
			return nil;
		end
		local texture = GetActionTexture(id);
		if ( not texture ) then
			return DynamicData.action.createEmptyActionArray();
		end
		local tooltipName = "DynamicDataTooltip";
		local tooltip = getglobal(tooltipName);
		DynamicData.util.clearTooltipStrings(tooltipName);
		DynamicData.util.protectTooltipMoney();
		tooltip:SetAction(id);
		DynamicData.util.unprotectTooltipMoney();
		local element = {};
		element.id = id;
		element.strings = DynamicData.util.getTooltipStrings(tooltipName);
		element.texture = texture;
		if ( ( element.strings ) and ( element.strings[1] ) and ( element.strings[1].left ) ) then
			element.name = element.strings[1].left;
		else
			element.name = "";
		end
		DynamicData.action.actions[id] = actionInfo;
		return element;
	end;

	-- 
	-- doUpdateActions (id)
	--
	--  Updates a specified action or ALL actions.
	--
	doUpdateActions = function (id) 
		if ( id ) then
			DynamicData.action.actions[id] = {};
			DynamicData.action.actions[id] = DynamicData.action.retrieveActionInfo(id);
			DynamicData.util.notifyWhateverHandlers(DynamicData.action.OnActionUpdateHandlers, id);
		else
			DynamicData.action.doUpdateAllActions();
		end
	end;

	-- 
	-- doUpdateAllActions (idsPerIteration, currentId)
	--
	--  Updates all actions, by chunking the info pulling.
	--
	doUpdateAllActions = function (idsPerIteration, currentId) 
		if ( not idsPerIteration ) then
			idsPerIteration = DYNAMICDATA_DEFAULT_NUMBER_OF_TOOLTIP_SCANS_PER_UPDATE;
		end
		if ( idsPerIteration == -1 ) then
			return;
		end
		if ( not currentId ) then
			-- do chunking
			Cosmos_ScheduleByName("DynamicData_action_doUpdateActions", 0.1, DynamicData.action.doUpdateActions, idsPerIteration, 1);
			return;
		else
			-- overwrite scheduled event
			Cosmos_ScheduleByName("DynamicData_action_doUpdateActions", 0.1, DynamicData.action.doUpdateActions, -1);
		end
		if ( currentId <= DYNAMICDATA_ACTION_MAXIMUM_NUMBER ) then
			local maxId = currentId + idsPerIteration - 1;
			DynamicData.action.doUpdateActionsRange(currentId, maxId);
			currentId = maxId+1;
		end
		if ( currentId <= DYNAMICDATA_ACTION_MAXIMUM_NUMBER ) then
			Cosmos_ScheduleByName("DynamicData_action_doUpdateActions", 0.1, DynamicData.action.doUpdateActions, idsPerIteration, currentId);
		else
			DynamicData.util.notifyWhateverHandlers(DynamicData.action.OnActionUpdateHandlers);
		end
	end;
	
	-- 
	-- doUpdateActionsRange (idStart, idEnd)
	--
	--  Updates a range of actions.
	--
	doUpdateActionsRange = function (idStart, idEnd)
		for i = idStart, idEnd do
			DynamicData.action.actions[i] = DynamicData.action.retrieveActionInfo(i);
		end
	end;

-- private functions	

	--
	-- OnLoad ()
	--
	--  Sets up the DynamicData.action for operation.
	--  In this case, it retrieves the IDs for the inventory slots.
	--
	OnLoad = function ()
		DynamicData.action.actions = {};
		DynamicData.action.doUpdateActions();
	end;

	--
	-- createEmptyActionArray ()
	-- 
	--  creates an empty action array
	--
	createEmptyActionArray = function ()
		local actionArray = {};
		local baseAction = nil;
		if ( not baseAction ) then
			baseAction = DynamicData.action.defaultAction;
		end
		for k, v in baseAction do
			actionArray[k] = v;
		end
		return actionArray;
	end;

-- variables

	defaultAction = {
		name = "",
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
	};

	-- Contains action data about the different actions.
	actions = nil;

	-- Contains the function pointers to functions that want to be called whenever the actions updates.
	-- Will be called AFTER the DynamicData has parsed the actions.
	OnActionUpdateHandlers = {};	

};

