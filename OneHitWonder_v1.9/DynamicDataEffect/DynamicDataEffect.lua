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
	Currently it is set up to gather tooltips on demand, rather than immediately on change.
	This is to prevent lagging the game.
	
	I will use scheduling to prevent lagging later.
	Hmm... it seems this does not lag the game at all, or at least not very much. 
	The effects are cached until they need to be updated, by the way, so this might be a viable way to go.
	Asking for effects = retrieving them if necessary.

]]


DYNAMICDATA_EFFECT_MAX_PLAYER_BUFFS		= 16;
DYNAMICDATA_EFFECT_MAX_PLAYER_DEBUFFS	= 8;

-- constant - indicates an expire time of "never"
DYNAMICDATA_EFFECT_EXPIRES_NEVER = -1;
-- constant - indicates an expire time of "unknown"
DYNAMICDATA_EFFECT_EXPIRES_UNKNOWN = -2;

DYNAMICDATA_EFFECTTYPE_BUFF = "Buff";
DYNAMICDATA_EFFECTTYPE_DEBUFF = "Debuff";


--[[
	Information returned by the DynamicData.effect.get*EffectInfo() methods

An array is returned with the following values

	name					-- the name of the effect
	strings					-- an array with strings that represent the tooltip of the effect
	texture					-- the pathname to the effects texture
	expires					-- contains DYNAMICDATA_EFFECT_EXPIRES_NEVER if it never expires, otherwise the time when it will expire
	buffIndex				---contains the buffIndex of the effect or nil if no such thing

]]--



-- Effect information - what buffs/debuffs the player, his party, pet and target currently has
DynamicData.effect = {

-- public functions	

	-- 
	-- addOnEffectUpdateHandler (func)
	--
	--  Adds a function name that will be called on effect updates.
	--  Function will have one paremeter - unit, which may be nil.
	--
	addOnEffectUpdateHandler = function (func)
		return DynamicData.util.addOnWhateverHandler(DynamicData.effect.OnEffectUpdateHandlers, func);
	end;

	-- 
	-- removeOnEffectUpdateHandler (func)
	--
	--  Removes the specified function, so that it will not be called on inventory updates.
	--
	removeOnEffectUpdateHandler = function (func)
		return DynamicData.util.removeOnWhateverHandler(DynamicData.effect.OnEffectUpdateHandlers, func);
	end;

	-- 
	-- getEffectInfos (unit)
	--
	--  Retrieves an array with effect information of the unit.
	--
	getEffectInfos = function (unit) 
		if ( not unit ) then
			return nil;
		end
		unit = DynamicData.effect.getFixedUnit(unit);
		if ( unit == "mouseover" ) then
			return nil;
		end
		if ( ( not DynamicData.effect.effects ) ) then
			DynamicData.effect.oldEffects = {};
			DynamicData.effect.effects = {};
		end

		DynamicData.effect.updateInProgress[unit] = false;		
		--the buffs can be cached but be out of date
		if ( (unit ~= "target") and ( DynamicData.effect.effects[unit] ) and 
			( DynamicData.effect.effects[unit].buffs ) and ( DynamicData.effect.effects[unit].debuffs ) ) then
			return DynamicData.effect.effects[unit];
		else
			if ( not unit ) then
				return DynamicData.effect.createEmptyEffectArray();
			end
			local effectInfo = nil;
			if ( UnitExists(unit) ) then
				local curBuff, curDebuff = DynamicData.effect.getUnitEffects(unit);
				effectInfo = { };
				effectInfo.buffs = curBuff;
				effectInfo.debuffs = curDebuff;
			else
				effectInfo = DynamicData.effect.createEmptyEffectArray();
			end
			DynamicData.effect.effects[unit] = effectInfo;
			return effectInfo;
		end
	end;
	
	-- 
	-- getEffectInfo (unit, name, texture)
	--
	--  Retrieves an effect information that matches the specified parameters.
	--  Either or both can be specified, and they can be a string or a table with string values.
	--
	getEffectInfo = function (unit, name, texture) 
		--_print("getEffectInfo")
		if ( not name ) and ( not texture ) then
			if ( not DD_EFFECT_NIL_DEBUG ) then
				DEFAULT_CHAT_FRAME:AddMessage("DD effect Error - name and texture was BOTH nil. Grr!");
				DD_EFFECT_NIL_DEBUG = 1;
			end
			return nil;
		end
		unit = DynamicData.effect.getFixedUnit(unit);
		local hasRightName = false;
		local hasRightTexture = false;
		
		local nameList = {};
		if ( not name ) then
		elseif ( type(name) == "table" ) then
			nameList = name;
		else
			nameList = { name };
		end
		
		local textureList = {};
		if ( not texture ) then
		elseif ( type(texture) == "table" ) then
			textureList = texture;
		else
			textureList = { texture };
		end
		
		local effectInfos = DynamicData.effect.getEffectInfos(unit);
						
		for k, v in effectInfos do
			for key, effect in v do
				hasRightName = DynamicData.util.isStringInList(effect.name, nameList);
				hasRightTexture = DynamicData.util.isStringInList(effect.texture, textureList);
				if ( ( ( getn(nameList) <= 0) or ( hasRightName ) ) 
					and ( ( getn(textureList) <= 0) or ( hasRightTexture ) ) ) then
					return effect;
				end
			end
		end
		return nil;
	end;
	
	-- 
	-- hasEffectInfo (unit, name, texture))
	--
	--  Returns true if the effect is in place.
	--
	hasEffectInfo = function (unit, name, texture)
		unit = DynamicData.effect.getFixedUnit(unit);
		local effectInfo = DynamicData.effect.getEffectInfo(unit, name, texture);
		if ( effectInfo ) then
			return true;
		else
			return false;
		end
	end;
	
	-- 
	-- updateEffects (unit)
	--
	--  Updates the effects of a specific unit or everyone.
	--
	updateEffects = function (unit) 
		tmp = "";
		local curTime = GetTime();
		if ( not DynamicData.effect.oldEffectsExpiryTime ) then
			DynamicData.effect.oldEffectsExpiryTime = {};
		end
		if ( unit ) then
			unit = DynamicData.effect.getFixedUnit(unit);
			if ( not DynamicData.util.isStringInList(unit, DynamicData.effect.validUnits) ) then
				--DEFAULT_CHAT_FRAME:AddMessage(format("Invalid unit %s updated!", unit), 1, 1, 0);
				return;
			end
			if ( DynamicData.effect.effects[unit] ) and ( DynamicData.effect.effects[unit].buffs ) then
				if ( not DynamicData.effect.oldEffectsExpiryTime[unit] ) or ( DynamicData.effect.oldEffectsExpiryTime[unit] <= curTime ) then
					DynamicData.effect.oldEffects[unit] = DynamicData.effect.effects[unit];
					DynamicData.effect.oldEffectsExpiryTime[unit] = curTime + 30;
				end
			end
			DynamicData.effect.effects[unit] = nil;
			if ( UnitIsDead(unit) ) and ( not UnitIsPlayer(unit) ) then
				DynamicData.effect.effects[unit] = {};
				for effectType, effectList in DynamicData.effect.deadNPCEffects do
					DynamicData.effect.effects[unit][effectType] = {};
					for effectIndex, effectTable in effectList do
						table.insert(DynamicData.effect.effects[unit][effectType], effectTable);
					end
				end
				return;
			end
			tmp = "_"..unit;
		else
			for k, v in DynamicData.effect.validUnits do
				DynamicData.effect.oldEffects[v] = {};
				DynamicData.effect.oldEffectsExpiryTime[v] = nil;
			end
			for k, v in DynamicData.effect.effects do
				DynamicData.effect.oldEffectsExpiryTime[k] = curTime + 30;
				DynamicData.effect.oldEffects[k] = v;
			end
			DynamicData.effect.effects = {};
			for k, v in monitoredUnits do
				Cosmos_ScheduleByName(format("DynamicData_effect_UpdateEffects_%s", v), 1, DynamicData.util.doNothing);
			end
		end
		if ( DynamicData.effect.updateInProgress[unit] ) then
			return;
		end
		DynamicData.effect.updateInProgress[unit] = true;
		--DynamicData.util.notifyWhateverHandlers(DynamicData.effect.OnEffectUpdateHandlers);
		params = {
			func = DynamicData.effect.doUpdateEffects,
			params = { unit },
			allowInitialUpdate = 0,
			schedulingName = "DynamicData_effect_UpdateEffects"..tmp,
		};
		-- do not do this until we get better handling
		DynamicData.util.postpone(params);
	end;

-- protected functions

	--
	-- getBuffTexture ( unit, buffIndex, debuff)
	--
	--  retrieves the buff texture from the unit. handles any unit.
	--
	getBuffTexture = function ( unit, buffIndex, debuff )
		--_print("getBuffTexture")
		unit = DynamicData.effect.getFixedUnit(unit);
		--_print(format("%s %d",unit,buffIndex))
		local texture = nil;
		if ( buffIndex > -1 ) then
			if ( unit == "player" ) then
				texture = GetPlayerBuffTexture(buffIndex);
			elseif ( debuff ) then
				texture = UnitDebuff(unit, buffIndex);
			else
				texture = UnitBuff(unit, buffIndex);
			end
		end
		--_print(texture)
		return texture;
	end;

	--
	-- getOldBuffData(unit, texture, debuff)
	--
	--  retrieves old buff data
	--
	getOldBuffData = function (unit, texture, debuff)
		if ( DynamicData.effect.oldEffects ) and ( DynamicData.effect.oldEffects[unit] ) then
			local arr = DynamicData.effect.oldEffects[unit].buffs;
			if ( debuff ) then
				arr = DynamicData.effect.oldEffects[unit].debuffs;
			end
			if ( arr ) then
				for k, v in arr do
					if ( v.texture == texture ) then
						return v;
					end
				end
			end
		end
		return nil;
	end;


	--
	-- getBuffData (unit, buffIndex, debuff)
	--
	--  Retrieves data about a specific buff on the specified unit.
	--
	getBuffData = function (unit, buffIndex, debuff)
		unit = DynamicData.effect.getFixedUnit(unit);
		if (buffIndex ~= -1) then
			local texture = DynamicData.effect.getBuffTexture(unit, buffIndex, debuff);
			if ( not texture ) then
				return nil;
			end
			local oldData = DynamicData.effect.getOldBuffData(unit, texture, debuff);
			if ( oldData ) then
				if ( unit == "player" ) then
					if ( oldData.expires ~= DYNAMICDATA_EFFECT_EXPIRES_NEVER ) then
						oldData.expires = GetTime()+GetPlayerBuffTimeLeft(buffIndex);
					end
				end
				return oldData;
			end
			-- Kinesia. Fixing tooltips.
			--local tooltipName = "DynamicDataTooltip";
			--local tooltip = getglobal(tooltipName);
			--DynamicData.util.clearTooltipStrings(tooltipName);
			--DynamicData.util.protectTooltipMoney();
			
			DynamicDataTooltip:SetOwner(UIParent);
			DynamicDataTooltipTextLeft1:SetText('');
			
			if ( not debuff ) then
				DynamicDataTooltip:SetUnitBuff(unit, buffIndex);
			else
				DynamicDataTooltip:SetUnitDebuff(unit, buffIndex);
			end
			--DynamicData.util.unprotectTooltipMoney();
			buffName = DynamicDataTooltipTextLeft1:GetText()
		
			local element = {};
			element.debuff = debuff;
			element.buffIndex = buffIndex;
			element.texture = texture;
			element.name = buffName
			element.strings = DynamicData.util.getTooltipStrings("DynamicDataTooltip");
			if ( ( element.strings ) and ( element.strings[1] ) and ( element.strings[1].left ) ) then
				element.name = element.strings[1].left;
			end
			element.expires = DYNAMICDATA_EFFECT_EXPIRES_UNKNOWN;
			return element;
		end
		return nil;
	end;

	--
	-- refreshEffects = function (unit)
	--
	--  Refreshes effects info for the specified unit.
	--
	refreshEffects = function (unit)
		unit = DynamicData.effect.getFixedUnit(unit);
		local needToUpdate = false;
		if ( not UnitExists(unit) ) then
			DynamicData.effect.effects[unit] = {};
			return false;
		end
		if ( DynamicData.effect.effects[unit] ) then
			local texture = nil;
			local curTime = GetTime();
			
			local buffs, debuffs = DynamicData.effect.getTextureList(unit);
			local currentTextures = {}
			currentTextures.buffs = buffs;
			currentTextures.debuffs = debuffs;
			local index = nil;
			
			for effectType, effectTable in DynamicData.effect.effects[unit] do
				for effectIndex, effect in effectTable do
					if ( not effect.buffIndex ) then
						needToUpdate = true;
						break;
					end
					index = DynamicData.util.getIndexInList(effect.texture, currentTextures[effectType]);
					if ( index ) then
						table.remove(currentTextures[effectType], index);
						if ( unit == "player" ) then
							if ( not effect.untilCancelled ) or ( effect.untilCancelled ~= 1 ) then
								effect.expires = curTime+GetPlayerBuffTimeLeft(effect.buffIndex);
							end
						end
					else
						needToUpdate = true;
						break;
					end
				end
				if ( needToUpdate ) then
					break;
				end
			end
		else
			needToUpdate = true;
		end
		if ( needToUpdate ) then
			DynamicData.effect.updateEffects(unit);
			DynamicData.effect.getEffectInfos(unit);
		end
		return needToUpdate;
	end;

	--
	-- getPlayerBuffData = function (buffIndex, untilCancelled)
	--
	--  Retrieves data about a specific buff.
	--
	getPlayerBuffData = function (buffIndex, untilCancelled)
		local tooltipName = "DynamicDataTooltip";
		local tooltip = getglobal(tooltipName);
		if ( ( not tooltipName ) or ( not tooltip ) ) then
			tooltipName = "DynamicDataTooltip";
			tooltip = getglobal(tooltipName);
		end
		if ( not tooltip ) then
			return nil;
		end
	
		local texture = GetPlayerBuffTexture(buffIndex);
		if ( not texture ) then
			return nil;
		end
		local oldData = DynamicData.effect.getOldBuffData("player", texture, debuff);
		if ( oldData ) then
			oldData.untilCancelled = untilCancelled;
			if ( untilCancelled == 1 ) then
				oldData.expires = DYNAMICDATA_EFFECT_EXPIRES_NEVER;
			else
				oldData.expires = GetTime()+GetPlayerBuffTimeLeft(buffIndex);
			end
			return oldData;
		end
	
		local element = {};
		element.texture = texture;
		element.buffIndex = buffIndex;
		element.untilCancelled = untilCancelled;
		DynamicData.util.clearTooltipStrings(tooltipName);
		DynamicData.util.protectTooltipMoney();
		tooltip:SetPlayerBuff(buffIndex);
		DynamicData.util.unprotectTooltipMoney();
		if ( untilCancelled == 1 ) then
			element.expires = DYNAMICDATA_EFFECT_EXPIRES_NEVER;
		else
			element.expires = GetTime()+GetPlayerBuffTimeLeft(buffIndex);
		end
		element.strings = DynamicData.util.getTooltipStrings(tooltipName);
		if ( ( element.strings ) and ( element.strings[1] ) and ( element.strings[1].left ) ) then
			element.name = element.strings[1].left;
		else
			element.name = "";
		end
		return element;
	end;

	--
	-- getPlayerTrackingBuffStrings ()
	--
	--  Retrieves tooltip info about the tracking buff.
	--
	getPlayerTrackingBuffStrings = function ()
		local tooltipName = "DynamicDataTooltip";
		local tooltip = getglobal(tooltipName);
		if ( not tooltip ) then
			return nil;
		end
		DynamicData.util.clearTooltipStrings(tooltipName);
		DynamicData.util.protectTooltipMoney();
		tooltip:SetTrackingSpell();
		DynamicData.util.unprotectTooltipMoney();
		
		local strings = DynamicData.util.getTooltipStrings(tooltipName);
		return strings;
	end;

	--
	-- getPlayerTextureList(unit)
	--
	--  retrieves a list of textures.
	--
	getPlayerTextureList = function()
		local buffFilter = "HELPFUL|PASSIVE";
		local buffs = {};
		local debuffs = {};
		local element = nil;
		for id = 0, (DYNAMICDATA_EFFECT_MAX_PLAYER_BUFFS-1) do
			buffIndex, untilCancelled = GetPlayerBuff(id, buffFilter);
			if ( buffIndex >= 0 ) then
				element = DynamicData.effect.getBuffTexture("player", buffIndex, false);
				if ( element ) then
					table.insert(buffs, element);
				end
			end
		end
		local buffFilter = "HARMFUL";
		for id = 0, (DYNAMICDATA_EFFECT_MAX_PLAYER_DEBUFFS-1) do
			buffIndex, untilCancelled = GetPlayerBuff(id, buffFilter);
			if ( buffIndex >= 0 ) then
				element = DynamicData.effect.getBuffTexture("player", buffIndex, true);
				if ( element ) then
					table.insert(debuffs, element);
				end
			end
		end
		return buffs, debuffs;
	end;
	
	--
	-- getTextureList(unit)
	--
	--  retrieves a list of textures.
	--
	getTextureList = function(unit)
		unit = DynamicData.effect.getFixedUnit(unit);
		if ( unit == "player" ) then
			return DynamicData.effect.getPlayerTextureList();
		else
			local buffs = {};
			local debuffs = {};
			local texture = nil;
			for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
				texture = DynamicData.effect.getBuffTexture(unit, i);
				if ( texture ) then
					table.insert(buffs, texture);
				end
			end
			for i = 0, MAX_PARTY_TOOLTIP_DEBUFFS do
				texture = DynamicData.effect.getBuffTexture(unit, i, true);
				if ( texture ) then
					table.insert(debuffs, texture);
				end
			end
			return buffs, debuffs;
		end
	end;

	--
	-- getPlayerEffects ()
	--
	--  Retrieves player effects.
	--  Needs special handling from other units.
	--
	getPlayerEffects = function()
		local tooltipName = "DynamicDataTooltip";
		local currentBuffs = {};
		local currentDebuffs = {};
		local isDebuff = false;
		local id = 0;
		local buffIndex, untilCancelled;
		local buffFilter = "HELPFUL|PASSIVE";
		for id = 0, 15 do
			buffIndex, untilCancelled = GetPlayerBuff(id, buffFilter);
			if ( buffIndex >= 0 ) then
				element = DynamicData.effect.getPlayerBuffData(buffIndex, untilCancelled, tooltipName);
				if ( element ) then
					element.effectType = DYNAMICDATA_EFFECTTYPE_BUFF;
					table.insert(currentBuffs, element);
				end
			end
		end
		local buffFilter = "HARMFUL";
		for id = 0, 7 do
			buffIndex, untilCancelled = GetPlayerBuff(id, buffFilter);
			if ( buffIndex >= 0 ) then
				element = DynamicData.effect.getPlayerBuffData(buffIndex, untilCancelled, tooltipName);
				if ( element ) then
					element.effectType = DYNAMICDATA_EFFECTTYPE_DEBUFF;
					table.insert(currentDebuffs, element);
				end
			end
		end
		local icon = GetTrackingTexture();
		if ( icon ) then
			local strings = DynamicData.effect.getPlayerTrackingBuffStrings();
			local trackBuffName = "";
			if ( ( strings ) and ( strings[1] ) and ( strings[1].left ) ) then
				trackBuffName = strings[1].left;
			end
			buffData = {};
			buffData.texture = icon;
			buffData.name = trackBuffName;
			buffData.strings = strings;
			buffData.expires = DYNAMICDATA_BUFF_EXPIRES_NEVER;
			table.insert(currentBuffs, buffData);
		end
		return currentBuffs, currentDebuffs;
	end;

	--
	-- getUnitEffects (unit)
	--
	--  Retrieves the effects of a specific unit
	--  Needs special handling from other units.
	--
	getUnitEffects = function (unit)
		--_print("getUnitEffects")
		unit = DynamicData.effect.getFixedUnit(unit);
		if ( ( not unit ) or ( type(unit) ~= "string" ) ) then
			return;
		end
		if ( DynamicData.util.safeToUseTooltips ) then
			if ( not DynamicData.util.safeToUseTooltips() ) then
				if ( Cosmos_ScheduleByName ) then
					Cosmos_ScheduleByName("DynamicData_effect_getUnitEffects_"..unit, 1, DynamicData.effect.getUnitEffects, unit);
				end
				return;
			end
		end
		
		local buffData = nil;
		
		DynamicData.effect.effects[unit] = {};
		
		local currentBuffs = {};
		local currentDebuffs = {};
	
		if ( unit ~= "player" ) then
			for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
				buffData = DynamicData.effect.getBuffData(unit, i);
				if ( buffData ) then
					buffData.effectType = DYNAMICDATA_EFFECTTYPE_BUFF;
					table.insert(currentBuffs, buffData);
				end
			end
			for i = 0, MAX_PARTY_TOOLTIP_DEBUFFS do
				buffData = DynamicData.effect.getBuffData(unit, i, true);
				if ( buffData ) then
					buffData.effectType = DYNAMICDATA_EFFECTTYPE_DEBUFF;
					table.insert(currentDebuffs, buffData);
				end
			end
		else
			currentBuffs, currentDebuffs = DynamicData.effect.getPlayerEffects();
		end
		
		return currentBuffs, currentDebuffs;
	end;


	-- 
	-- doUpdateUnitEffects (unit)
	--
	--  Updates a units effects.
	--
	doUpdateUnitEffects = function (unit) 
		unit = DynamicData.effect.getFixedUnit(unit);
		DynamicData.effect.effects[unit] = nil;
		
		if ( UnitExists(unit) ) then
			--DynamicData.effect.effects[unit] = DynamicData.effect.getUnitEffects(unit);
		else
			DynamicData.effect.effects[unit] = DynamicData.effect.createEmptyEffectArray()
		end
	end;

	-- 
	-- doUpdateEffects ()
	--
	--  Updates the effects of the specified unit.
	--
	doUpdateEffects = function (unit) 
		unit = DynamicData.effect.getFixedUnit(unit);
		local safe = DynamicData.util.safeToUseTooltips();
		if ( not safe ) then
			if ( unit ) then
				Cosmos_ScheduleByName("DynamicData_effect_doUpdateEffects", 0.1, DynamicData.effect.doUpdateEffects, unit);
			else
				Cosmos_ScheduleByName("DynamicData_effect_doUpdateEffectsUnspecified", 0.1, DynamicData.effect.doUpdateEffects);
			end
			return;
		end
		if ( unit ) then
			--DynamicData.effect.oldEffects[unit] = DynamicData.effect.effects[unit];
			DynamicData.effect.effects[unit] = nil;
			tmp = unit;
		else
			--DynamicData.effect.oldEffects = DynamicData.effect.effects;
			DynamicData.effect.effects = {};
		end
		DynamicData.util.notifyWhateverHandlers(DynamicData.effect.OnEffectUpdateHandlers);
		
		--[[
		if ( unit ) then
			DynamicData.effect.doUpdateUnitEffects(unit);
		else
			for key, value in DynamicData.effect.monitoredUnits do
				DynamicData.effect.doUpdateUnitEffects(value);
			end
		end
		local func = nil;
		for k, v in DynamicData.effect.OnEffectUpdateHandlers do
			func = v;
			func(unit);
		end
		]]--
	end;
	
-- private functions	

	--
	-- OnLoad ()
	--
	--  Sets up the DynamicData.effect for operation.
	--  In this case, it retrieves the IDs for the inventory slots.
	--
	OnLoad = function ()
		DynamicData.effect.oldEffects = {};
		DynamicData.effect.effects = {};
		for key, value in DynamicData.effect.monitoredUnits do
			DynamicData.effect.doUpdateUnitEffects(value);
		end
	end;

	--
	-- createEmptyEffectArray ()
	-- 
	--  creates an empty effect array
	--
	createEmptyEffectArray = function ()
		local effectArray = {};
		effectArray.buffs = {};
		effectArray.debuffs = {};
		return effectArray;
	end;

-- variables

	-- Contains effect data about the different units.
	effects = nil;

	-- Contains the function pointers to functions that want to be called whenever the effects updates.
	-- Will be called AFTER the DynamicData has parsed the effects.
	OnEffectUpdateHandlers = {};	

	monitoredUnits = {
		"player",
		"pet",
		"party1",
		"party2",
		"party3",
		"party4",
		"target"
	};

	validUnits = {
		"player",
		"pet",
		"party1",
		"party2",
		"party3",
		"party4",
		"target",
		"mouseover"
	};
	
	oldEffectsExpiryTime = {};

	initiateUpdateEffects = function ( unit ) 
		unit = DynamicData.effect.getFixedUnit(unit);
		if ( DYNAMICDATA_OPTIMIZE ) and ( DYNAMICDATA_OPTIMIZE == 1 ) then
			DynamicData.effect.refreshEffects(unit);
		else
			DynamicData.effect.updateEffects(unit);
		end
	end;

	updateInProgress = {};

	deadNPCEffects = {
		buffs = {},
		debuffs = {}
	};
	
	
	getFixedUnit = function (unit)
		local tmp = tonumber(unit);
		if ( tmp ) then
			return "party"..tmp;
		else
			return unit;
		end
	end;

};

