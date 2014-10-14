----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration
----------------------------------------------------------------------------------------------------

-- Global vars table
SDVars = { 
	Alpha = SDGlobal.Alpha,
	Class = "",
	Race = "",
	RegisteredClass = false,
	RegisteredRace = false,
};

-- Used to catch the spell attributes
SDSpell = {
	["Id"] = nil,
	["Book"] = nil,
	["Rank"] = 0,
}

-- Used to manipulate some of the addons data inside the events 
SDEvent = {
	["SpellName"] = nil,
	["RejectedSpellName"] = nil,
	["Target"] = nil,
	["Casting"] = false,
	["Tapped"] = false,
	["InCombat"] = false,
	["IsPlayer"] = false,
	["ComboPoint"] = 0,
}

-- [Event: UNIT_AURA] The debuff list the targets have
SDBarDebuffs = { };
SDBuffDebuffs = { };

-- Spells queue
SDQueueTable = { };

-- Players standing in queue for diminishing return
--SDDiminishTable = { };
 
 -- Chat messages parsing table
SDCombatMsg = { 
	["AFFLICTED"] = string.gsub(AURAADDEDOTHERHARMFUL,"%%s","(.+)"),
	["PREFORM"] = string.gsub(SIMPLEPERFORMSELFOTHER,"%%s","(.+)"),
	["SELFAURA"] = string.gsub(AURAADDEDSELFHELPFUL,"%%s","(.+)"),
	["CAST"] = string.gsub(SPELLCASTGOSELFTARGETTED,"%%s","(.+)"),
	["REMOVED"] = string.gsub(AURADISPELOTHER,"%%s","(.+)"),
	["FADESOFF"] = string.gsub(AURAREMOVEDOTHER,"%%s","(.+)"),
	["HOSTILEDIES"] = string.gsub(UNITDIESOTHER,"%%s","(.+)"),
	["HITS"] = string.gsub(SPELLLOGSELFOTHER,"%%s","(.+)"),
	["CRITS"] = string.gsub(SPELLLOGCRITSELFOTHER,"%%s","(.+)"),
};

----------------------------------------------------------------------------------------------------
-- USED ON EVENTS FUNCTIONS
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDOnLoad
----------------------------------------------------------------------------------------------------
function SDOnLoad()
	SDVars.Class = UnitClass("player");
	SDVars.Race = UnitRace("player");
	-- Register / Unregister Events
	SDRegisterEvents();
end

----------------------------------------------------------------------------------------------------
-- Name		: SDOnEvent
----------------------------------------------------------------------------------------------------
function SDOnEvent(event)
	if(event == "VARIABLES_LOADED") then
		SDTablesInit();
		SDHooked();
		-- Create slash events
		SLASH_SD1 = "/sd";
		SLASH_SD2 = "/sdhelp";
		SlashCmdList["SD"] = SDSlashHandler;
		-- 
		-- Temporary solution to support the previous version (Will be removed in Spell Duration 2.0)
		--
		if(SDConfig.BarsOnly == 0) then
			SDConfig.BarsOnly = false;
		elseif(SDConfig.BarsOnly == 1) then
			SDConfig.BarsOnly = true;
		end
		return;
	end
	if(event == "UNIT_COMBAT") then
		-- If the target rejected the spell return
		if(arg1 == "target") then
			if(arg2 == "DODGE" 
			or arg2 == "BLOCK" 
			or arg2 == "PARRY" 
			or arg2 == "MISS"
			or arg2 == "EVADE" 
			or arg2 == "IMMUNE"
			or arg2 == "DEFLECT"
			or arg2 == "REFLECT"
			or arg2 == "INTERRUPT" 
			or arg2 == "RESIST") then
				if(SDEvent["Casting"]) then 
					SDEvent["Casting"] = false;
					SDEvent["SpellName"] = "";
				end
				SDEvent["Target"] = 0;
			end
		end
	end
	if(event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
		-- Whenever the spell failed make sure to initialize the value back to default
		if(SDEvent["Casting"]) then 
			SDEvent["Casting"] = false;
			SDEvent["SpellName"] = "";
		end
		SDEvent["Target"] = 0;
	end
	if(event == "SPELLCAST_STOP") then
		-- Yes, I was the one who fired the event, we can safely process the rest of the data
		for index, spell in SDSpellsTable[SDVars.Class] do
			if(SDEvent["SpellName"] == spell.name) then
				SDEvent["RejectedSpellName"] = spell.name;
				if(spell.caststop and SDEvent["Target"] ~= 0) then
					if(spell.icon and spell.icon ~= "" and not SDConfig.BarsOnly) then
						SDBuffCreate(spell.name, SDEvent["Target"], GetTime());
					else
						SDBarCreate(spell.name, SDEvent["Target"], GetTime());
					end
				end
				return;
			end
		end
	end
	if(event == "CHAT_MSG_SPELL_BREAK_AURA") then
		for target, spellName in string.gfind(arg1, SDCombatMsg["REMOVED"]) do
			SDQueueFades(spellName, target, GetTime());
			return;
		end
	elseif(event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
		for spellName, target in string.gfind(arg1, SDCombatMsg["FADESOFF"]) do
			SDQueueFades(spellName, target, GetTime());
			return;
		end
	elseif(event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		for target in string.gfind(arg1, SDCombatMsg["HOSTILEDIES"]) do
			SDQueueRemove("TARGET", target);
			return;
		end
	elseif(event == "PLAYER_DEAD") then
		SDQueueRemove("ALL");
		return;
	elseif(event == "PLAYER_TARGET_CHANGED") then
		SDEvent["Tapped"] = false;
		if(UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) then
		-- Do Nothing
		elseif(UnitIsTappedByPlayer("target")) then
			SDEvent["Tapped"] = true;
		end
	elseif(event == "PLAYER_COMBO_POINTS") then
		SDEvent["ComboPoint"] = GetComboPoints();
		return;
	elseif(event == "PLAYER_REGEN_ENABLED") then
		SDEvent["InCombat"] = false;
		SDQueueRemove("MOBS");
		return;
	elseif(event == "PLAYER_REGEN_DISABLED") then
		SDQueueRemoveSpellsOnCombat();
		SDEvent["InCombat"] = true;
		return;
	end
end

----------------------------------------------------------------------------------------------------
-- INITIALIZATION
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDRegisterEvents
----------------------------------------------------------------------------------------------------
function SDRegisterEvents()
	local index, class, race;
	for index, class in SDClassTable do
		if(SDVars.Class == class) then
			SDVars.RegisteredClass = true;
			-- Bar Frame Reg
			SpellDurationBarDragFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			SpellDurationBarDragFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
			SpellDurationBarDragFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
			SpellDurationBarDragFrame:RegisterEvent("UNIT_AURA");
			SpellDurationBarDragFrame:RegisterForDrag("LeftButton");
			-- Buff Frame Reg
			SpellDurationBuffDragFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			SpellDurationBuffDragFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
			SpellDurationBuffDragFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
			SpellDurationBuffDragFrame:RegisterEvent("UNIT_AURA");
			SpellDurationBuffDragFrame:RegisterForDrag("LeftButton");
		end
	end
	index = nil;
	for index, race in SDRaceTable do
		if(SDVars.Race == race) then
			SDVars.RegisteredRace = true;
			SpellDurationRacialBarDragFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			SpellDurationRacialBarDragFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
			SpellDurationRacialBarDragFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
			SpellDurationRacialBarDragFrame:RegisterForDrag("LeftButton");
			if(SDVars.Race == SDRaceTable.Troll) then
				SpellDurationBerserkerFrame:RegisterForDrag("LeftButton");
			end
		end
	end
	
	if(SDVars.RegisteredClass == false) then
		-- Bar Frame Reg
		SpellDurationBarDragFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		SpellDurationBarDragFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		SpellDurationBarDragFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		SpellDurationBarDragFrame:UnregisterEvent("UNIT_AURA");
		-- Buff Frame Reg
		SpellDurationBuffDragFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		SpellDurationBuffDragFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		SpellDurationBuffDragFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		SpellDurationBuffDragFrame:UnregisterEvent("UNIT_AURA");
	end
	if(SDVars.RegisteredRace == false) then
		SpellDurationRacialBarDragFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		SpellDurationRacialBarDragFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		SpellDurationRacialBarDragFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	end
	
	if(SDVars.RegisteredClass == true or SDVars.RegisteredRace == true) then
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("ADDON_LOADED");
		--this:RegisterEvent("UNIT_COMBAT");
		this:RegisterEvent("SPELLCAST_FAILED");
		this:RegisterEvent("SPELLCAST_INTERRUPTED");
		this:RegisterEvent("SPELLCAST_STOP");
		this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
		this:RegisterEvent("PLAYER_DEAD");
		this:RegisterEvent("PLAYER_COMBO_POINTS");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_TARGET_CHANGED");
	else
		this:UnregisterEvent("VARIABLES_LOADED");
		this:UnregisterEvent("ADDON_LOADED");
		--this:UnregisterEvent("UNIT_COMBAT");
		this:UnregisterEvent("SPELLCAST_FAILED");
		this:UnregisterEvent("SPELLCAST_INTERRUPTED");
		this:UnregisterEvent("SPELLCAST_STOP");
		this:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
		this:UnregisterEvent("PLAYER_DEAD");
		this:UnregisterEvent("PLAYER_COMBO_POINTS");
		this:UnregisterEvent("PLAYER_REGEN_ENABLED");
		this:UnregisterEvent("PLAYER_REGEN_DISABLED");
		this:UnregisterEvent("PLAYER_TARGET_CHANGED");
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDTablesInit
----------------------------------------------------------------------------------------------------
function SDTablesInit()
	local index, spell;
	for index, spell in SDSpellsTable[SDVars.Class] do
		spell.name = SDLocalizedSpellsTable[SDVars.Class][index].name;
		spell.stop = true;
	end
	if(SDVars.RegisteredRace) then
		index = nil; spell = nil;
		for index, spell in SDRacialTable[SDVars.Race] do
			spell.name = SDLocalizedRacialTable[SDVars.Race][index].name;
			spell.stop = true;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDHooked
----------------------------------------------------------------------------------------------------
function SDHooked()
	SDHookTable = { };
	-- Blizzard
	SDHookTable["BlizzCastingBar"] = CastingBarFrame_OnUpdate;
	CastingBarFrame_OnUpdate = function()
		SDHookTable["BlizzCastingBar"]();
		SDCastingBarFrame_OnUpdate();  
	end;
	SDHookTable["UseAction"] = UseAction;
	UseAction = function(id,book,onself) 
		SDUseAction(id, book); 
		SDHookTable["UseAction"](id,book,onself); 
	end;
	SDHookTable["CastSpell"] = CastSpell;
	CastSpell = function(id, book) 
		SDCastSpell(id, book); 
		SDHookTable["CastSpell"](id, book); 
	end;
	SDHookTable["CastSpellByName"] = CastSpellByName;
	CastSpellByName = function(spellName) 
		SDCastSpellByName(spellName); 
		SDHookTable["CastSpellByName"](spellName); 
	end;
	-- Addons Support
	SDHookTable["eCastingBar"] = eCastingBar_OnUpdate;
	eCastingBar_OnUpdate = function(frame)
		SDHookTable["eCastingBar"](frame);
		SDeCastingBar_OnUpdate(frame);  
	end;
	SDHookTable["DHUD"] = DHUD_OnUpdate;
	DHUD_OnUpdate = function()
		SDHookTable["DHUD"]();
		SDDHUD_OnUpdate();  
	end;
	if(otravi_CastingBar) then
		SDHookTable["otravi"] = otravi_CastingBar.OnUpdate;
		otravi_CastingBar.OnUpdate = function()
			SDHookTable["otravi"]();
			SDOtravi_OnUpdate();  
		end;
	end
end