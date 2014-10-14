--[[
path: /FlexTotem/
filename: FlexTotem.lua
version: 1.12a
date: 30/8/2006 (clears totems when you die)
localization: Supports the English, German, French and Chinese client.
	For the French and German client the translation of chat messages is incomplete and will partially show in english.
credits: Thanks to the developers of TotemTimers and FlexBar. 
	Thanks to Redskull, LeDentiste, Pearz and others for localization.
author: Kasper Bruins <k.s.bruins@uvt.nl>

FlexTotem: Adds totem events to Flexbar and adds totem timers and a totem stomper option to FlexBar buttons.
]]--

--
-- CLIENT INDEPENDENT DATA
--

TOTEM_VERSION = "1.11c";

TOTEM_DEFAULT_STOMP_BUTTON = 90;
TOTEM_DEFAULT_AIR_BUTTON = 91;
TOTEM_DEFAULT_WATER_BUTTON = 92;
TOTEM_DEFAULT_FIRE_BUTTON = 93;
TOTEM_DEFAULT_EARTH_BUTTON = 94;
TOTEM_DEFAULT_THRESHOLD = 10;
TOTEM_DEFAULT_INTERVAL = 500;
TOTEM_ICON_REGEX = "Interface\\Icons\\(.+)";

CurrentTotems = {};

TotemData = {};

TotemData[TOTEM_DISEASE_CLEANSING] = {};
TotemData[TOTEM_DISEASE_CLEANSING].duration = 120;
TotemData[TOTEM_DISEASE_CLEANSING].hits = 5;
TotemData[TOTEM_DISEASE_CLEANSING].icon = "Spell_Nature_DiseaseCleansingTotem";
TotemData[TOTEM_DISEASE_CLEANSING].element = TOTEM_WATER;

TotemData[TOTEM_EARTHBIND] = {};
TotemData[TOTEM_EARTHBIND].duration = 45; 
TotemData[TOTEM_EARTHBIND].hits = 5;
TotemData[TOTEM_EARTHBIND].icon = "Spell_Nature_StrengthOfEarthTotem02";
TotemData[TOTEM_EARTHBIND].element = TOTEM_EARTH;

TotemData[TOTEM_FIRE_NOVA] = {};
TotemData[TOTEM_FIRE_NOVA].duration = 4;
TotemData[TOTEM_FIRE_NOVA].hits = 5;
TotemData[TOTEM_FIRE_NOVA].icon = "Spell_Fire_SealOfFire"
TotemData[TOTEM_FIRE_NOVA].element = TOTEM_FIRE;

TotemData[TOTEM_FIRE_RESISTANCE] = {};
TotemData[TOTEM_FIRE_RESISTANCE].duration = 120;
TotemData[TOTEM_FIRE_RESISTANCE].hits = 5;
TotemData[TOTEM_FIRE_RESISTANCE].icon = "Spell_FireResistanceTotem_01"; 
TotemData[TOTEM_FIRE_RESISTANCE].element = TOTEM_WATER;

TotemData[TOTEM_FLAMETONGUE] = {};
TotemData[TOTEM_FLAMETONGUE].duration = 120;
TotemData[TOTEM_FLAMETONGUE].hits = 5;
TotemData[TOTEM_FLAMETONGUE].icon = "Spell_Nature_GuardianWard";
TotemData[TOTEM_FLAMETONGUE].element = TOTEM_FIRE;

TotemData[TOTEM_FROST_RESISTANCE] = {};
TotemData[TOTEM_FROST_RESISTANCE].duration = 120;
TotemData[TOTEM_FROST_RESISTANCE].hits = 5;
TotemData[TOTEM_FROST_RESISTANCE].icon = "Spell_FrostResistanceTotem_01"; 
TotemData[TOTEM_FROST_RESISTANCE].element = TOTEM_FIRE;

TotemData[TOTEM_GRACE_OF_AIR] = {};
TotemData[TOTEM_GRACE_OF_AIR].hits = 5;
TotemData[TOTEM_GRACE_OF_AIR].duration = 120;
TotemData[TOTEM_GRACE_OF_AIR].icon = "Spell_Nature_InvisibilityTotem";
TotemData[TOTEM_GRACE_OF_AIR].element = TOTEM_AIR;

TotemData[TOTEM_GROUNDING] = {};
TotemData[TOTEM_GROUNDING].duration = 45;
TotemData[TOTEM_GROUNDING].hits = 5;
TotemData[TOTEM_GROUNDING].icon = "Spell_Nature_GroundingTotem";
TotemData[TOTEM_GROUNDING].element = TOTEM_AIR;

TotemData[TOTEM_HEALING_STREAM] = {} ;
TotemData[TOTEM_HEALING_STREAM].duration = 60;
TotemData[TOTEM_HEALING_STREAM].hits = 5;
TotemData[TOTEM_HEALING_STREAM].icon = "INV_Spear_04";
TotemData[TOTEM_HEALING_STREAM].element = TOTEM_WATER;

TotemData[TOTEM_MAGMA] = {};
TotemData[TOTEM_MAGMA].duration = 20;
TotemData[TOTEM_MAGMA].hits = 5;
TotemData[TOTEM_MAGMA].icon = "Spell_Fire_SelfDestruct";
TotemData[TOTEM_MAGMA].element = TOTEM_FIRE;

TotemData[TOTEM_MANA_SPRING] = {};
TotemData[TOTEM_MANA_SPRING].duration = 60;
TotemData[TOTEM_MANA_SPRING].hits = 5;
TotemData[TOTEM_MANA_SPRING].icon = "Spell_Nature_ManaRegenTotem";
TotemData[TOTEM_MANA_SPRING].element = TOTEM_WATER;

TotemData[TOTEM_MANA_TIDE] = {};
TotemData[TOTEM_MANA_TIDE].duration = 12;
TotemData[TOTEM_MANA_TIDE].hits = 5;
TotemData[TOTEM_MANA_TIDE].icon = "Spell_Frost_SummonWaterElemental";
TotemData[TOTEM_MANA_TIDE].element = TOTEM_WATER;

TotemData[TOTEM_NATURE_RESISTANCE] = {};
TotemData[TOTEM_NATURE_RESISTANCE].duration = 120;
TotemData[TOTEM_NATURE_RESISTANCE].hits = 5;
TotemData[TOTEM_NATURE_RESISTANCE].icon = "Spell_Nature_NatureResistanceTotem";
TotemData[TOTEM_NATURE_RESISTANCE].element = TOTEM_AIR;

TotemData[TOTEM_POISON_CLEANSING] = {};
TotemData[TOTEM_POISON_CLEANSING].duration = 120;
TotemData[TOTEM_POISON_CLEANSING].hits = 5;
TotemData[TOTEM_POISON_CLEANSING].icon = "Spell_Nature_PoisonCleansingTotem";
TotemData[TOTEM_POISON_CLEANSING].element = TOTEM_WATER;

TotemData[TOTEM_SEARING] = {};
TotemData[TOTEM_SEARING].hits = 5;
TotemData[TOTEM_SEARING][1] = { };
TotemData[TOTEM_SEARING][1].duration = 30;
TotemData[TOTEM_SEARING][2] = { };
TotemData[TOTEM_SEARING][2].duration = 35;
TotemData[TOTEM_SEARING][3] = { };
TotemData[TOTEM_SEARING][3].duration = 40;
TotemData[TOTEM_SEARING][4] = { };
TotemData[TOTEM_SEARING][4].duration = 45;
TotemData[TOTEM_SEARING][5] = { };
TotemData[TOTEM_SEARING][5].duration = 50;
TotemData[TOTEM_SEARING][6] = { };
TotemData[TOTEM_SEARING][6].duration = 55;
TotemData[TOTEM_SEARING].icon = "Spell_Fire_SearingTotem";
TotemData[TOTEM_SEARING].element = TOTEM_FIRE;

TotemData[TOTEM_SENTRY] = {};
TotemData[TOTEM_SENTRY].duration = 300;
TotemData[TOTEM_SENTRY].hits = 100;
TotemData[TOTEM_SENTRY].icon = "Spell_Nature_RemoveCurse";
TotemData[TOTEM_SENTRY].element = TOTEM_AIR;

TotemData[TOTEM_STONECLAW] = {};
TotemData[TOTEM_STONECLAW].duration = 15;
TotemData[TOTEM_STONECLAW][1] = { };
TotemData[TOTEM_STONECLAW][1].hits = 206;
TotemData[TOTEM_STONECLAW][2] = { };
TotemData[TOTEM_STONECLAW][2].hits = 276;
TotemData[TOTEM_STONECLAW][3] = { };	
TotemData[TOTEM_STONECLAW][3].hits = 316;
TotemData[TOTEM_STONECLAW][4] = { };
TotemData[TOTEM_STONECLAW][4].hits = 346;
TotemData[TOTEM_STONECLAW][5] = { };
TotemData[TOTEM_STONECLAW][5].hits = 426;
TotemData[TOTEM_STONECLAW][6] = { };
TotemData[TOTEM_STONECLAW][6].hits = 486;
TotemData[TOTEM_STONECLAW].icon = "Spell_Nature_StoneClawTotem";
TotemData[TOTEM_STONECLAW].element = TOTEM_EARTH;

TotemData[TOTEM_STONESKIN] = {};
TotemData[TOTEM_STONESKIN].hits = 5;
TotemData[TOTEM_STONESKIN].duration = 120;
TotemData[TOTEM_STONESKIN].icon = "Spell_Nature_StoneSkinTotem";
TotemData[TOTEM_STONESKIN].element = TOTEM_EARTH;

TotemData[TOTEM_STRENGTH_OF_EARTH] = {};
TotemData[TOTEM_STRENGTH_OF_EARTH].hits = 5;
TotemData[TOTEM_STRENGTH_OF_EARTH].duration = 120;
TotemData[TOTEM_STRENGTH_OF_EARTH].icon = "Spell_Nature_EarthBindTotem";
TotemData[TOTEM_STRENGTH_OF_EARTH].element = TOTEM_EARTH;

TotemData[TOTEM_TRANQUIL_AIR] = {};
TotemData[TOTEM_TRANQUIL_AIR].duration = 120;
TotemData[TOTEM_TRANQUIL_AIR].hits = 5;
TotemData[TOTEM_TRANQUIL_AIR].icon = "Spell_Nature_Brilliance"; 
TotemData[TOTEM_TRANQUIL_AIR].element = TOTEM_AIR;

TotemData[TOTEM_TREMOR] = {};
TotemData[TOTEM_TREMOR].duration = 120;
TotemData[TOTEM_TREMOR].hits = 5;
TotemData[TOTEM_TREMOR].icon = "Spell_Nature_TremorTotem";
TotemData[TOTEM_TREMOR].element = TOTEM_EARTH;

TotemData[TOTEM_WINDFURY] = {};
TotemData[TOTEM_WINDFURY].duration = 120;
TotemData[TOTEM_WINDFURY].hits = 5;
TotemData[TOTEM_WINDFURY].icon = "Spell_Nature_Windfury";
TotemData[TOTEM_WINDFURY].element = TOTEM_AIR;

TotemData[TOTEM_WINDWALL] = {};
TotemData[TOTEM_WINDWALL].duration = 120;
TotemData[TOTEM_WINDWALL].hits = 5;
TotemData[TOTEM_WINDWALL].icon = "Spell_Nature_EarthBind";
TotemData[TOTEM_WINDWALL].element = TOTEM_AIR;

TotemData[TotemData[TOTEM_DISEASE_CLEANSING].icon] = TOTEM_DISEASE_CLEANSING;
TotemData[TotemData[TOTEM_EARTHBIND].icon] = TOTEM_EARTHBIND;
TotemData[TotemData[TOTEM_FIRE_NOVA].icon] = TOTEM_FIRE_NOVA;
TotemData[TotemData[TOTEM_FIRE_RESISTANCE].icon] = TOTEM_FIRE_RESISTANCE;
TotemData[TotemData[TOTEM_FROST_RESISTANCE].icon] = TOTEM_FROST_RESISTANCE;
TotemData[TotemData[TOTEM_FLAMETONGUE].icon] = TOTEM_FLAMETONGUE;
TotemData[TotemData[TOTEM_GRACE_OF_AIR].icon] = TOTEM_GRACE_OF_AIR;
TotemData[TotemData[TOTEM_GROUNDING].icon] = TOTEM_GROUNDING;
TotemData[TotemData[TOTEM_HEALING_STREAM].icon] = TOTEM_HEALING_STREAM;
TotemData[TotemData[TOTEM_MAGMA].icon] = TOTEM_MAGMA;
TotemData[TotemData[TOTEM_MANA_SPRING].icon] = TOTEM_MANA_SPRING;
TotemData[TotemData[TOTEM_MANA_TIDE].icon] = TOTEM_MANA_TIDE;
TotemData[TotemData[TOTEM_NATURE_RESISTANCE].icon] = TOTEM_NATURE_RESISTANCE;
TotemData[TotemData[TOTEM_POISON_CLEANSING].icon] = TOTEM_POISON_CLEANSING;
TotemData[TotemData[TOTEM_SEARING].icon] = TOTEM_SEARING;
TotemData[TotemData[TOTEM_SENTRY].icon] = TOTEM_SENTRY;
TotemData[TotemData[TOTEM_STONECLAW].icon] = TOTEM_STONECLAW;
TotemData[TotemData[TOTEM_STONESKIN].icon] = TOTEM_STONESKIN;
TotemData[TotemData[TOTEM_STRENGTH_OF_EARTH].icon] = TOTEM_STRENGTH_OF_EARTH;
TotemData[TotemData[TOTEM_TRANQUIL_AIR].icon] = TOTEM_TRANQUIL_AIR;
TotemData[TotemData[TOTEM_TREMOR].icon] = TOTEM_TREMOR;
TotemData[TotemData[TOTEM_WINDFURY].icon] = TOTEM_WINDFURY;
TotemData[TotemData[TOTEM_WINDWALL].icon] = TOTEM_WINDWALL;

--
-- FLEXBAR CONDITIONS
--

FBConditions["hasair"] = 
	function(target)
		if not target then 
			if CurrentTotems[TOTEM_AIR] then return true else return false end
		end
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_AIR] then return false end

		local index, value
		for index, value in pairs(target) do
			if string.lower(CurrentTotems[TOTEM_AIR].totem) == string.lower(value) then 
				return true
			end
		end
		return false
	end

FBConditions["hasearth"] = 
	function(target)
		if not target then 
			if CurrentTotems[TOTEM_EARTH] then return true else return false end
		end
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_EARTH] then return false end

		local index, value
		for index, value in pairs(target) do
			if string.lower(CurrentTotems[TOTEM_EARTH].totem) == string.lower(value) then 
				return true
			end
		end
		return false
	end

FBConditions["hasfire"] = 
	function(target)
		if not target then 
			if CurrentTotems[TOTEM_FIRE] then return true else return false end
		end
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_FIRE] then return false end

		local index, value
		for index, value in pairs(target) do
			if string.lower(CurrentTotems[TOTEM_FIRE].totem) == string.lower(value) then 
				return true
			end
		end
		return false
	end

FBConditions["haswater"] = 
	function(target)
		if not target then 
			if CurrentTotems[TOTEM_WATER] then return true else return false end
		end
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_WATER] then return false end

		local index, value
		for index, value in pairs(target) do
			if string.lower(CurrentTotems[TOTEM_WATER].totem) == string.lower(value) then 
				return true
			end
		end
		return false
	end

FBConditions["hasairrank"] = 
	function(target)
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_AIR] then return false end

		local index, value
		for index, value in pairs(target) do
			if CurrentTotems[TOTEM_AIR].rank == value then 
				return true
			end
		end
		return false
	end

FBConditions["hasearthrank"] = 
	function(target)
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_EARTH] then return false end

		local index, value
		for index, value in pairs(target) do
			if CurrentTotems[TOTEM_EARTH].rank == value then 
				return true
			end
		end
		return false
	end

FBConditions["hasfirerank"] = 
	function(target)
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_FIRE] then return false end

		local index, value
		for index, value in pairs(target) do
			if CurrentTotems[TOTEM_FIRE].rank == value then 
				return true
			end
		end
		return false
	end

FBConditions["haswaterrank"] = 
	function(target)
		if type(target) ~= "table" then
			target = { target }
		end
	
		if not CurrentTotems[TOTEM_WATER] then return false end

		local index, value
		for index, value in pairs(target) do
			if CurrentTotems[TOTEM_WATER].rank == value then 
				return true
			end
		end
		return false
	end

--
-- FLEXTOTEM INITIALIZATION FUNCTIONS
--

function Totem_Enable() 
	FlexTotem:RegisterEvent("VARIABLES_LOADED");
	FlexTotem:RegisterEvent("SPELLCAST_STOP");
	FlexTotem:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	FlexTotem:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	FlexTotem:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	FlexTotem:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	FlexTotem:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
end

function Totem_Refresh()
	if (TotemSettings.debug == nil) then TotemSettings.debug = false; end
	if (TotemSettings.notify == nil) then TotemSettings.notify = true; end
	if (TotemSettings.advanced == nil) then TotemSettings.advanced = false; end
	if (TotemSettings.button_stomp == nil) then TotemSettings.button_stomp = TOTEM_DEFAULT_STOMP_BUTTON; end
	if (TotemSettings.button_air == nil) then TotemSettings.button_air = TOTEM_DEFAULT_AIR_BUTTON; end
	if (TotemSettings.button_water == nil) then TotemSettings.button_water = TOTEM_DEFAULT_WATER_BUTTON; end
	if (TotemSettings.button_fire == nil) then TotemSettings.button_fire = TOTEM_DEFAULT_FIRE_BUTTON; end
	if (TotemSettings.button_earth == nil) then TotemSettings.button_earth = TOTEM_DEFAULT_EARTH_BUTTON; end
	if (TotemSettings.threshold == nil) then TotemSettings.threshold = TOTEM_DEFAULT_THRESHOLD; end
	if (TotemSettings.interval == nil) then TotemSettings.interval = TOTEM_DEFAULT_INTERVAL / 1000; end
	if (TotemSettings.preset == nil) then TotemSettings.preset = TOTEM_DEFAULT_PRESET; end
	if (TotemSettings.prefix ~= nil) then TotemSettings.prefix = nil; end
end

function Totem_Reset()
	TotemSettings.debug = false;
	TotemSettings.notify = true;
	TotemSettings.advanced = false;
	TotemSettings.threshold = TOTEM_DEFAULT_THRESHOLD;
	TotemSettings.interval = TOTEM_DEFAULT_INTERVAL / 1000;
	TotemSettings.prefix = TOTEM_DEFAULT_PREFIX;
end

function Totem_Setup()
	if (not TotemSettings) then
		TotemSettings = {};
		Totem_Reset();
		TotemSettings.button_air = TOTEM_DEFAULT_AIR_BUTTON;
		TotemSettings.button_earth = TOTEM_DEFAULT_EARTH_BUTTON;
		TotemSettings.button_fire = TOTEM_DEFAULT_FIRE_BUTTON;
		TotemSettings.button_water = TOTEM_DEFAULT_WATER_BUTTON;
		TotemSettings.button_stomp = TOTEM_DEFAULT_STOMP_BUTTON;
	else
		Totem_Refresh();
	end

	TotemState = 0;
	
	if not StompData then
		StompData = {}
		StompData.total = 0;
		for n=1, 4 do
			StompData[n] = {};
			StompData[n].icon = ""; StompData[n].button = 0; StompData[n].element = "";
		end
	end

	Totem_CurrentStomp = TotemSettings.button_stomp;	
	Totem_CheckStomp();

	Totem_Notify(gsub(TOTEM_SETTINGS_LOADED, "$V", TOTEM_VERSION), not TotemSettings.notify, true);
end
	
--
-- FLEXTOTEM HOOKED FUNCTIONS
--

function Totem_SetupHooks()
	Totem_HookFunctions = {};
	Totem_HookFunctions["UseAction"] = UseAction;
	UseAction = function(id, book, target) 
		Totem_UseAction(id, book, target); 
		Totem_HookFunctions["UseAction"](id, book, target); 
	end;
	Totem_HookFunctions["CastSpell"] = CastSpell;
	CastSpell = function(id, book) 
		Totem_CastSpell(id, book); 
		Totem_HookFunctions["CastSpell"](id, book); 
	end;
	Totem_HookFunctions["CastSpellByName"] = CastSpellByName;
	CastSpellByName = function(name)
		Totem_CastSpellByName(name);
		Totem_HookFunctions["CastSpellByName"](name);
	end;
end

function Totem_CastSpell(id, book)
	TotemState = nil;
	local name, r = GetSpellName(id, book);
	name = string.gfind(name, TOTEM_NAME_REGEX)();
	if name then
		if TotemData[name] then
			local start, duration = GetSpellCooldown(id,book);
			if start == 0 and duration == 0 then
				Totem = {};
				Totem["rank"] = 0;
				Totem["totem"] = name;
				Totem["element"] = TotemData[name].element;
				if r then 
					r = string.gfind(r, TOTEM_RANK_REGEX)();
					if r then
						Totem["rank"] = tonumber(r);
					end
				end
				TotemState = true;
			end
		end
	end
end

function Totem_UseAction(id, number, target)
	TotemState = nil;
	local start, duration = GetActionCooldown(id);
	local isUsable, notEnoughMana = IsUsableAction(id)
	if( start == 0 and duration == 0 and isUsable and not notEnoughMana ) then
		FlexBarTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		FlexBarTooltipTextRight1:SetText(nil);	
		FlexBarTooltip:SetAction(id);
		local name = FlexBarTooltipTextLeft1:GetText();
		if name then
			name = string.gfind(name, TOTEM_NAME_REGEX)();
			if name then
				if TotemData[name] then
					Totem = {};
					Totem["totem"] = name;
					Totem["rank"] = 0;
					Totem["element"] = TotemData[name].element;
					local rank = FlexBarTooltipTextRight1:GetText();	
					if rank then 
						rank = string.gfind(rank, TOTEM_RANK_REGEX)();
						if rank then
							Totem["rank"] = tonumber(rank);
						end
					end
					TotemState = true;
				end
			end
		end
	end
end

function Totem_CastSpellByName(name)
	local id = Totem_GetSpellID(name)
	if not id then
		return;
	end
	TotemState = nil;
	local name, r = GetSpellName(id, BOOKTYPE_SPELL);
	name = string.gfind(name, TOTEM_NAME_REGEX)();
	if name then
		if TotemData[name] then
			local start, duration = GetSpellCooldown(id, BOOKTYPE_SPELL);
			if start == 0 and duration == 0 then
				Totem = {};
				Totem["rank"] = 0;
				Totem["totem"] = name;
				Totem["element"] = TotemData[name].element;
				if r then 
					r = string.gfind(r, TOTEM_RANK_REGEX)();
					if r then
						Totem["rank"] = tonumber(r);
					end
				end
				TotemState = true;
			end
		end
	end
end		

--
-- FLEXTOTEM BUTTON FUNCTIONS
--

function Totem_ClearCursor()
	if (CursorHasItem() or CursorHasSpell()) then
		PickupSpell(1, "spell"); -- Doing this twice is a safe way to clear cursor
		if (CursorHasSpell() or CursorHasItem()) then 
			PickupSpell(1, "spell"); 
		end
	end
	PutItemInBackpack();
end

function Totem_DropSpell(button, spell)
	if spell == "" then
		Totem_ClearCursor();
		PickupAction(button);
		Totem_ClearCursor();
	else
		id = Totem_GetSpellID(spell);
		if id then
			Totem_ClearCursor();
			PickupSpell(id, BOOKTYPE_SPELL);
			PlaceAction(button);
			Totem_ClearCursor();
		end
	end
end

function Totem_ChangeText(id, text)
	if id>0 then
		local button, frame = FB_GetWidgets(id)
		FBState[id]["hotkeytext"] = text
		FB_TextSub(id)
		FlexBarButton_UpdateUsable(button)
		FlexBarButton_UpdateHotkeys(button)
		if FBSavedProfile[FBProfileName] == nil then
			FBSavedProfile[FBProfileName] = {}
		end
		local util = Utility_Class:New()
		FBSavedProfile[FBProfileName][id].State = util:TableCopy(FBState[id])
	end
end

function Totem_Remap(id, nid)
	local button, frame = FB_GetWidgets(id)
	FBState[id]["remap"] = nid
	button:SetID(FBState[id]["remap"])
	FlexBarButton_Update(button)
	FlexBarButton_UpdateState(button)
	if FBSavedProfile[FBProfileName] == nil then
		FBSavedProfile[FBProfileName] = {}
	end
	if FBSavedProfile[FBProfileName][id] then
		local util = Utility_Class:New()
		FBSavedProfile[FBProfileName][id].State = util:TableCopy(FBState[id]);
		return true;
	end
	return false;
end

--
-- FLEXTOTEM STOMPER FUNCTIONS
--

function Totem_Stomp()
	if TotemSettings then
		local id = FBState[TotemSettings.button_stomp]["remap"];
		UseAction(id);
	end
end

function Totem_UpdateStomp(button)
	if (button ~= Totem_CurrentStomp) then
		Totem_Debug("Stomper changed from button " .. Totem_CurrentStomp .. " to button " .. button .. ".");
		Totem_CurrentStomp = button;
		local b = Totem_Remap(TotemSettings.button_stomp, button);
		if not b then Totem_CurrentStomp = 0; end
	end
end

function Totem_AdvancedStomp()
	local n, stomped = false;
	for n=1, StompData.total do
		if (CurrentTotems[StompData[n].element]) then
			if ((CurrentTotems[StompData[n].element].icon ~= StompData[n].icon)
  				or (CurrentTotems[StompData[n].element].duration < TotemSettings.threshold)) then
				local start, duration, enable = GetActionCooldown(StompData[n].button);
				if (duration < 2) then 
					Totem_UpdateStomp(StompData[n].button); 
					stomped = true;
					break;
				end;
			end
		else 
			local start, duration, enable = GetActionCooldown(StompData[n].button);
			if (duration < 2) then 
				Totem_UpdateStomp(StompData[n].button); 
				stomped = true;
				break;
			end;
		end
	end
	if (not stomped) then Totem_UpdateStomp(TotemSettings.button_stomp); end
end

function Totem_CheckStomp()
	if (StompData.total > 0) then
		if (TotemSettings.advanced) then 
			Totem_AdvancedStomp();
		else 
			local n, stomped = false;
			for n=1, StompData.total do
				if (CurrentTotems[StompData[n].element]) then
					if (CurrentTotems[StompData[n].element].icon ~= StompData[n].icon) then 
						Totem_UpdateStomp(StompData[n].button); 
						stomped = true;
						break;
					end
				else 
					Totem_UpdateStomp(StompData[n].button); 
					stomped = true;
					break;
				end
			end
			if (not stomped) then Totem_UpdateStomp(TotemSettings.button_stomp); end
		end
	end
end

function Totem_SetStomp()
	local button = FBLastSource;
	if not GetActionTexture(button) then Totem_Error("That button doesn't seem to have an action."); return; end;
	local text = string.gfind(GetActionTexture(button), TOTEM_ICON_REGEX)();
	local element; if TotemData[text] then element = TotemData[TotemData[text]].element; end
	if (element == nil) then Totem_Error("You can only put totems on the stomper list."); return; end

	Totem_Debug("Trying to add button " .. button .. " (" .. TotemData[text] .. ") to the stomper sequence.");

	local e=0;
	for n=1, StompData.total do if (StompData[n].element == element) then e = n; end; end

	if (e == 0) then
		StompData.total = StompData.total + 1;
		StompData[StompData.total].element = element;
		StompData[StompData.total].icon = text;
		StompData[StompData.total].button = button;
		Totem_ChangeText(button, StompData.total);
	else
		if (StompData[e].button == button) then
			for n=1, StompData.total do
				Totem_ChangeText(StompData[n].button, "");
				StompData[n].button = 0;
				StompData[n].icon = "";
				Totem_UpdateStomp(TotemSettings.button_stomp);
			end
			StompData.total = 0; 
		else 
			Totem_ChangeText(StompData[e].button, "");
			StompData[e].element = element;
			StompData[e].icon = text;
			StompData[e].button = button;
			Totem_ChangeText(button, e);
		end
	end
	Totem_CheckStomp();
end

function Totem_SaveStomp(name)
	if name == "" then
		Totem_Error("You have to provide a name for the sequence.");
	else
		local s = "";		
		if StompData.total>0 then
			local n;
			for n=1, StompData.total do
				if (s ~= "") then s = s .. "," end
				s = s .. StompData[n].button .. "," .. TotemData[StompData[n].icon];
			end
		end
		if not TotemSettings.stomp then TotemSettings.stomp = {} end
		TotemSettings.stomp[name] = s;
	end
end

function Totem_LoadStomp(name)
	if name == "" then 		
		Totem_Error("You have to provide a name for the sequence.");
	else 
		local l = false;
		if TotemSettings.stomp then
			if TotemSettings.stomp[name] then
				for n=1, StompData.total do
					Totem_ChangeText(StompData[n].button, "");
					StompData[n].button = 0;
					StompData[n].icon = "";
					Totem_UpdateStomp(TotemSettings.button_stomp);
					StompData.total = 0;
				end
				local x,y,e1a,e1b,e2a,e2b,e3a,e3b,e4a,e4b = string.find( TotemSettings.stomp[name], "([^,]*),*([^,]*),*([^,]*),*([^,]*),*([^,]*),*([^,]*),*([^,]*),*([^,]*)");
				if e1a~="" then
					StompData[1].button = e1a + 0;
					StompData[1].icon = TotemData[e1b].icon;
					StompData[1].element = TotemData[e1b].element;
					Totem_ChangeText(StompData[1].button, "1");
					StompData.total = 1;
					if e2a~="" then
						StompData[2].button = e2a + 0;
						StompData[2].icon = TotemData[e2b].icon;
						StompData[2].element = TotemData[e2b].element;
						Totem_ChangeText(StompData[2].button, "2");
						StompData.total = 2;
						if e3a~="" then 
							StompData[3].button = e3a + 0;
							StompData[3].icon = TotemData[e3b].icon;
							StompData[3].element = TotemData[e3b].element;									Totem_ChangeText(StompData[3].button, "3");
							StompData.total = 3;
							if e4a~="" then 
								StompData[4].button = e4a + 0;
								StompData[4].icon = TotemData[e4b].icon;
								StompData[4].element = TotemData[e4b].element;
								Totem_ChangeText(StompData[4].button, "4");
								StompData.total = 4;
							end
						end
					end
				end
				Totem_CheckStomp(); l = true;
			end
		end
		if not l then 
			Totem_Error("Stomper sequence not found."); return false;
		else
			return true;
		end
	end
end

--
-- FLEXTOTEM MISCELANIOUS FUNCTIONS
--

function Totem_Execute(command)
	FBEventArgs = nil;
	FBcmd:Dispatch(command);
end

function Totem_GetSpellID(spellname)
	local i,done,name,id,spellrank=1,false;
	_,_,spellrank = string.find(spellname,TOTEM_RANK_NAME_REGEX);
	spellname = string.gsub(spellname,TOTEM_RANK_NAME_REGEX,"");
	if not spellrank then
		spellname = string.gsub(spellname, "%(%)", "");
	end
	while not done do
		name,rank = GetSpellName(i,BOOKTYPE_SPELL);
		if not name then
			done = true;
		elseif (name==spellname and not spellrank) or (name==spellname and rank==spellrank) then
			id = i;
		end 
		i = i + 1;
	end
	return id
end

function Totem_EventName(element)
	if (element == TOTEM_EARTH) then 
		return "Earth";
	elseif (element == TOTEM_AIR) then
		return "Air";
	elseif (element == TOTEM_WATER) then
		return "Water";
	elseif (element == TOTEM_FIRE) then
		return "Fire";
	end	
end

function Totem_TotemName(name)
	return gsub(TOTEM_NAME_STRING, "$N", name);
end

function Totem_FormatTime(seconds)
	local d, h, m, s;
	local text;
		if(seconds <= 0) then
			text = "";
		elseif(seconds < 3600) then
			d, h, m, s = ChatFrame_TimeBreakDown(seconds);
			if (m>10) then
				text = format("%02d:%02d", m, s);
			else
				text = format("%01d:%02d", m, s);
			end

		else
			text = "1 hr+";
		end

	return text;
end

--
-- FLEXTOTEM DEFAULT CONFIGURATION FUNCTIONS
--

function Totem_Remove()
	local n=1;
	while n<=FBEvents.n do
		local event = FBEvents[n]["command"] .. " on='" .. FBEvents[n]["on"] .. "'";
		if FBEvents[n]["targettext"] ~= "Target=No target" then event = event .. " " .. FBEvents[n]["targettext"]; end
		if FBEvents[n]["if"] then event = event .. " if='" .. FBEvents[n]["if"] .. "'"; end
		if string.find(FBEvents[n]["command"], "Totem_SetStomp()") then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"".. event .. "\" because it calls SetStomp.");
		elseif string.find(FBEvents[n]["targettext"], TotemSettings.button_air) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it uses the air button as target.");
		elseif string.find(FBEvents[n]["targettext"], TotemSettings.button_earth) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it uses the earth button as target.");
		elseif string.find(FBEvents[n]["targettext"], TotemSettings.button_fire) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it uses the fire button as target.");
		elseif string.find(FBEvents[n]["targettext"], TotemSettings.button_water) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it uses the water button as target.");
		elseif string.find(FBEvents[n]["targettext"], TotemSettings.button_stomp) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it uses the stomper button as target.");
		elseif string.find(FBEvents[n]["command"], "button=[%[ %d]*" .. TotemSettings.button_air) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it changes the air button.");
		elseif string.find(FBEvents[n]["command"], "button=[%[ %d]*" .. TotemSettings.button_earth) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it changes the earth button.");
		elseif string.find(FBEvents[n]["command"], "button=[%[ %d]*" .. TotemSettings.button_fire) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it changes the fire button.");
		elseif string.find(FBEvents[n]["command"], "button=[%[ %d]*" .. TotemSettings.button_water) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it changes the water button.");
		elseif string.find(FBEvents[n]["command"], "button=[%[ %d]*" .. TotemSettings.button_stomp) then
			table.remove(FBEvents, n); Totem_Debug("Removed event \"" .. event .. "\" because it changes the stomper button.");
		else
			n = n + 1;
		end
	end
	local util = Utility_Class:New()
	FB_CreateQuickDispatch();
	FBSavedProfile[FBProfileName].Events = util:TableCopy(FBEvents);
	if FBState[TotemSettings.button_air]["group"] == TotemSettings.button_air then
		Totem_Execute("hide group=" .. TotemSettings.button_air);
		Totem_Execute("scale group=" .. TotemSettings.button_air .. " scale=10");
		Totem_Execute("text group=" .. TotemSettings.button_air .. " text=''");
		Totem_Execute("text3 group=" .. TotemSettings.button_air .. " text=''");
		Totem_Execute("horizontalgroup group=" .. TotemSettings.button_air .. " height=2 padding=3");
		FB_DisbandGroup(TotemSettings.button_air);
	end

	Totem_Remap(TotemSettings.button_air, TotemSettings.button_air);
	Totem_Remap(TotemSettings.button_earth, TotemSettings.button_earth);
	Totem_Remap(TotemSettings.button_fire, TotemSettings.button_fire);
	Totem_Remap(TotemSettings.button_water, TotemSettings.button_water);
	Totem_UpdateStomp(TotemSettings.button_stomp);

	getglobal("FlexTimer" .. TotemSettings.button_air .. "Time"):SetText("");
	getglobal("FlexTimer" .. TotemSettings.button_water .. "Time"):SetText("");
	getglobal("FlexTimer" .. TotemSettings.button_fire .. "Time"):SetText("");
	getglobal("FlexTimer" .. TotemSettings.button_earth .. "Time"):SetText("");

	TotemSettings.button_stomp = TOTEM_DEFAULT_STOMP_BUTTON;
	TotemSettings.button_air = TOTEM_DEFAULT_AIR_BUTTON;
	TotemSettings.button_water = TOTEM_DEFAULT_WATER_BUTTON;
	TotemSettings.button_fire = TOTEM_DEFAULT_FIRE_BUTTON;
	TotemSettings.button_earth = TOTEM_DEFAULT_EARTH_BUTTON;
	
	StompData.total = 0;
end

function Totem_Update()
	local start = TotemSettings.button_stomp;

	for n = start, start + 27 do Totem_DropSpell(n, ""); end

	Totem_DropSpell(start + 5, Totem_TotemName(TOTEM_SENTRY));
	Totem_DropSpell(start + 6, Totem_TotemName(TOTEM_WINDWALL));
	Totem_DropSpell(start + 7, Totem_TotemName(TOTEM_WINDFURY));
	Totem_DropSpell(start + 8, Totem_TotemName(TOTEM_NATURE_RESISTANCE));
	Totem_DropSpell(start + 9, Totem_TotemName(TOTEM_GRACE_OF_AIR));
	Totem_DropSpell(start + 10, Totem_TotemName(TOTEM_GROUNDING));

	Totem_DropSpell(start + 11, Totem_TotemName(TOTEM_MANA_TIDE));
	Totem_DropSpell(start + 12, Totem_TotemName(TOTEM_FIRE_RESISTANCE));
	Totem_DropSpell(start + 13, Totem_TotemName(TOTEM_DISEASE_CLEANSING));
	Totem_DropSpell(start + 14, Totem_TotemName(TOTEM_POISON_CLEANSING));
	Totem_DropSpell(start + 15, Totem_TotemName(TOTEM_MANA_SPRING));
	Totem_DropSpell(start + 16, Totem_TotemName(TOTEM_HEALING_STREAM));

	Totem_DropSpell(start + 17, Totem_TotemName(TOTEM_FROST_RESISTANCE));
	Totem_DropSpell(start + 18, Totem_TotemName(TOTEM_FLAMETONGUE));
	Totem_DropSpell(start + 19, Totem_TotemName(TOTEM_FIRE_NOVA));
	Totem_DropSpell(start + 20, Totem_TotemName(TOTEM_SEARING));
	Totem_DropSpell(start + 21, Totem_TotemName(TOTEM_MAGMA));

	Totem_DropSpell(start + 22, Totem_TotemName(TOTEM_STONECLAW));
	Totem_DropSpell(start + 23, Totem_TotemName(TOTEM_STONESKIN));
	Totem_DropSpell(start + 24, Totem_TotemName(TOTEM_STRENGTH_OF_EARTH));
	Totem_DropSpell(start + 25, Totem_TotemName(TOTEM_TREMOR));
	Totem_DropSpell(start + 26, Totem_TotemName(TOTEM_EARTHBIND));

	Totem_DropSpell(start + 27, Totem_TotemName(TOTEM_TRANQUIL_AIR));
end

function Totem_Default(start, scale1, scale2, padding, x, y, align)
	Totem_Remove();

	TotemSettings.button_stomp = start;
	TotemSettings.button_air = start + 1;
	TotemSettings.button_earth = start + 4;
	TotemSettings.button_fire = start + 3;
	TotemSettings.button_water = start + 2;

	Totem_Remap(TotemSettings.button_air, TotemSettings.button_air);
	Totem_Remap(TotemSettings.button_earth, TotemSettings.button_earth);
	Totem_Remap(TotemSettings.button_fire, TotemSettings.button_fire);
	Totem_Remap(TotemSettings.button_water, TotemSettings.button_water);
	Totem_UpdateStomp(TotemSettings.button_stomp);

	Totem_Update();

	local n;
	local dim = 38 * (scale1 / 10); local dim2 = 38 * (scale2 / 10);
	local dir = 1; local tdim = 0; if align == "top" then dir = -1; tdim = -(19 - padding) * (scale1 / 10); end
	FBState[start]["xcoord"] = x; FBState[start]["ycoord"] = y;
	for n = 1, 5 do
		if n<5 then
			FBState[start + n]["xcoord"] = x + (n - 1) * (dim + padding);
			FBState[start + n]["ycoord"] = y;
		else 
			FBState[start]["xcoord"] = x + (n - 1) * (dim + padding);
			FBState[start]["ycoord"] = y;
		end		
	end
	for n = 0, 6 do
		if (n==6) then
			FBState[start + 27]["xcoord"] = x + (dim - dim2) / 2;
			FBState[start + 27]["ycoord"] = y + tdim + dir * (n + 1) * (dim2 + padding);
		else 
			FBState[start + 10 - n]["xcoord"] = x + (dim - dim2) / 2;
			FBState[start + 10 - n]["ycoord"] = y + tdim + dir * (n + 1) * (dim2 + padding);
			FBState[start + 16 - n]["xcoord"] = x + (dim + padding) + (dim - dim2) / 2;
			FBState[start + 16 - n]["ycoord"] = y + tdim + dir * (n + 1) * (dim2 + padding);
		end
	end
	for n = 0, 4 do
		FBState[start + 21 - n]["xcoord"] = x + 2 * (dim + padding) + (dim - dim2) / 2;
		FBState[start + 21 - n]["ycoord"] = y + tdim + dir * (n + 1) * (dim2 + padding);
		FBState[start + 26 - n]["xcoord"] = x + 3 * (dim + padding) + (dim - dim2) / 2;
		FBState[start + 26 - n]["ycoord"] = y + tdim + dir * (n + 1) * (dim2 + padding);
	end
	for n = start, start + 27 do
		local button, frame = FB_GetWidgets(n)
		FlexBarButton_Update(button)
		FB_SaveState(n)
	end
	for n = start, start + 27 do if FBState[n]["group"] then FB_DisbandGroup(FBState[n]["group"]); end; end
	Totem_Execute("group button=" .. start .. "-" .. start + 27 .. " anchor=" .. start + 1);
	Totem_Execute("show group=" .. start + 1);
	Totem_Execute("text3 text='%d' group=" .. start + 1);
	Totem_Execute("unlock group=" .. start + 1);
	Totem_Execute("showgrid group=" .. start + 1);
	Totem_Execute("fade alpha=10 group=" .. start + 1);
	Totem_Execute("text text='' group=" .. start + 1);
	Totem_Execute("scale button=" .. start .. "-" .. start + 4 .. " scale=" .. scale1);
	Totem_Execute("scale button=" .. start + 5 .. "-" .. start + 27 .. " scale=" .. scale2);
	Totem_Execute("advanced button=" .. start .. "-" .. start + 4 .. " state='off'");
	Totem_Execute("advanced button=" .. start + 5 .. "-" .. start + 27 .. " state='on'");
	
	Totem_Execute("runscript on='rightbuttonclick' script='Totem_SetStomp()' target=" .. start + 5 .. "-" .. start + 27);
	Totem_Execute("show on='mouseenterbutton' button=" .. start + 5 .. "-" .. start + 27 .. " target=" .. start + 1 .. "-" .. start + 4);
	Totem_Execute("hide on='mouseleavegroup' button=" .. start + 5 .. "-" .. start + 27 .. " target=" .. start + 1);

	Totem_Execute("fade alpha=3 on='profileloaded' button=" .. start + 1 .. "-" .. start + 4);
	Totem_Execute("fade alpha=3 on='loseair' button=" .. start + 1);
	Totem_Execute("fade alpha=3 on='loseearth' button=" .. start + 4);
	Totem_Execute("fade alpha=3 on='losefire' button=" .. start + 3);
	Totem_Execute("fade alpha=3 on='losewater' button=" .. start + 2);
	Totem_Execute("fade alpha=10 on='gainair' button=" .. start + 1);
	Totem_Execute("fade alpha=10 on='gainearth' button=" .. start + 4);
	Totem_Execute("fade alpha=10 on='gainfire' button=" .. start + 3);
	Totem_Execute("fade alpha=10 on='gainwater' button=" .. start + 2);

	Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 5 .. " on='gainair' target='" .. TOTEM_SENTRY .. "'");
	Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 6 .. " on='gainair' target='" .. TOTEM_WINDWALL .. "'");
	Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 7 .. " on='gainair' target='" .. TOTEM_WINDFURY .. "'");
	Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 8 .. " on='gainair' target='" .. TOTEM_NATURE_RESISTANCE .. "'");
	Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 9 .. " on='gainair' target='" .. TOTEM_GRACE_OF_AIR .. "'");
	Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 10 .. " on='gainair' target='" .. TOTEM_GROUNDING .. "'");

	-- Fix for the apostrophe in the french totem name causing trouble - the localization string is also used for placing the spell.
	if (GetLocale() == "frFR") then
		Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 27 .. " on='gainair' target='de Tranquillit\195\169 de l\\'air'"); 
	else
		Totem_Execute("remap button=" .. start + 1 .. " base=" .. start + 27 .. " on='gainair' target='" .. TOTEM_TRANQUIL_AIR .. "'");
	end

	Totem_Execute("remap button=" .. start + 2 .. " base=" .. start + 11 .. " on='gainwater' target='" .. TOTEM_MANA_TIDE .. "'");
	Totem_Execute("remap button=" .. start + 2 .. " base=" .. start + 12 .. " on='gainwater' target='" .. TOTEM_FIRE_RESISTANCE .. "'");
	Totem_Execute("remap button=" .. start + 2 .. " base=" .. start + 13 .. " on='gainwater' target='" .. TOTEM_DISEASE_CLEANSING .. "'");
	Totem_Execute("remap button=" .. start + 2 .. " base=" .. start + 14 .. " on='gainwater' target='" .. TOTEM_POISON_CLEANSING .. "'");
	Totem_Execute("remap button=" .. start + 2 .. " base=" .. start + 15 .. " on='gainwater' target='" .. TOTEM_MANA_SPRING .. "'");
	Totem_Execute("remap button=" .. start + 2 .. " base=" .. start + 16 .. " on='gainwater' target='" .. TOTEM_HEALING_STREAM .. "'");

	Totem_Execute("remap button=" .. start + 3 .. " base=" .. start + 17 .. " on='gainfire' target='" .. TOTEM_FROST_RESISTANCE .. "'");
	Totem_Execute("remap button=" .. start + 3 .. " base=" .. start + 18 .. " on='gainfire' target='" .. TOTEM_FLAMETONGUE .. "'");
	Totem_Execute("remap button=" .. start + 3 .. " base=" .. start + 19 .. " on='gainfire' target='" .. TOTEM_FIRE_NOVA .. "'");
	Totem_Execute("remap button=" .. start + 3 .. " base=" .. start + 20 .. " on='gainfire' target='" .. TOTEM_SEARING .. "'");
	Totem_Execute("remap button=" .. start + 3 .. " base=" .. start + 21 .. " on='gainfire' target='" .. TOTEM_MAGMA .. "'");

	Totem_Execute("remap button=" .. start + 4 .. " base=" .. start + 22 .. " on='gainearth' target='" .. TOTEM_STONECLAW .. "'");
	Totem_Execute("remap button=" .. start + 4 .. " base=" .. start + 23 .. " on='gainearth' target='" .. TOTEM_STONESKIN .. "'");
	Totem_Execute("remap button=" .. start + 4 .. " base=" .. start + 24 .. " on='gainearth' target='" .. TOTEM_STRENGTH_OF_EARTH .. "'");
	Totem_Execute("remap button=" .. start + 4 .. " base=" .. start + 25 .. " on='gainearth' target='" .. TOTEM_TREMOR .. "'");
	Totem_Execute("remap button=" .. start + 4 .. " base=" .. start + 26 .. " on='gainearth' target='" .. TOTEM_EARTHBIND .. "'");
end

--
-- FLEXTOTEM CHAT DISPLAY FUNCTIONS
--

function Totem_Debug(msg)
	msg = "|cff50ff50FlexTotem: |cffb0ffb0" .. msg;
	if TotemSettings ~= nil then
		if TotemSettings.debug then DEFAULT_CHAT_FRAME:AddMessage(msg); end
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function Totem_Error(msg)
	msg = "|cffff5050FlexTotem: |cffff9090" .. msg;
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function Totem_Notify(msg, silent, name)
	if not silent then
		if name then msg = "|cffffff50FlexTotem: |cffffffb0" .. msg; end
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

--
-- FLEXTOTEM TOTEM TRACKING FUNCTIONS
--

function Totem_CreateTotem()
	local at;
	if Totem then
		if TotemData[Totem["totem"]] then

			at = {};

			at.icon = TotemData[Totem["totem"]].icon;

			if( not TotemData[Totem["totem"]][Totem["rank"]] ) then
				at.duration = TotemData[Totem["totem"]].duration;
				at.hits = TotemData[Totem["totem"]].hits;
			else
				if( TotemData[Totem["totem"]][Totem["rank"]].duration ) then
					at.duration = TotemData[Totem["totem"]][Totem["rank"]].duration;
				else
					at.duration = TotemData[Totem["totem"]].duration;
				end
				if( TotemData[Totem["totem"]][Totem["rank"]].hits ) then
					at.hits = TotemData[Totem["totem"]][Totem["rank"]].hits;
				else
					at.hits = TotemData[Totem["totem"]].hits;
				end
			end

			at.damage = 0;

			nameTalent, icon, iconx, icony, currRank, maxRank = GetTalentInfo(1,9);
			Totem_ImprovedFireNova = currRank;
			
			if (Totem_ImprovedFireNova and Totem["totem"] == TOTEM_FIRE_NOVA) then
				at.duration = at.duration - Totem_ImprovedFireNova;
			end;

			at.action = Totem["action"];
			at.number = Totem["number"];
			at.target = Totem["target"];
			at.totem = Totem["totem"];
			at.rank = Totem["rank"];
			at.element = Totem["element"];

			Totem_Debug( "Created "..at.element..":"..at.totem .. " (Rank " .. at.rank .. ") for ".. at.duration.."s with "..at.hits.." hitpoints.");

			CurrentTotems[Totem["element"]] = at;
			CurrentTotems[Totem["totem"]] = at;

			Totem = nil;

			FB_RaiseEvent("Gain" .. Totem_EventName(at.element), at.totem);
			FB_RaiseEvent("TotemChanged", at.element);
		end
	end
	Totem_CheckStomp();
end

function Totem_DestroyTotem(totem)
	if CurrentTotems[totem] then
		local e = CurrentTotems[totem].element; local t = totem;
		Totem_Debug( "Destroyed "..e..":"..t..".");
		CurrentTotems[CurrentTotems[totem].element] = nil;
		CurrentTotems[totem] = nil;
		FB_RaiseEvent("Lose" .. Totem_EventName(e), t);
		FB_RaiseEvent("TotemChanged", e);
	end
	Totem_CheckStomp();
end

function Totem_TotemDamage(totem, damage)
	if ( CurrentTotems[totem] ) then
		CurrentTotems[totem].damage = CurrentTotems[totem].damage + damage;
		if ( CurrentTotems[totem].damage >= CurrentTotems[totem].hits ) then
			Totem_Debug(CurrentTotems[totem].totem .. " took " .. CurrentTotems[totem].damage .. " damage out of " .. CurrentTotems[totem].hits .. " hitpoints.");
			local button = 0;
			if (CurrentTotems[totem].element == TOTEM_AIR) then button = TotemSettings.button_air;
			elseif (CurrentTotems[totem].element == TOTEM_EARTH) then button = TotemSettings.button_earth;
			elseif (CurrentTotems[totem].element == TOTEM_FIRE) then button = TotemSettings.button_fire;
			elseif (CurrentTotems[totem].element == TOTEM_WATER) then button = TotemSettings.button_water; end
			if (button>0) then getglobal("FlexTimer" .. button .. "Time"):SetText(""); end
			Totem_DestroyTotem(totem);
		end
	end
end

--
-- FLEXTOTEM EVENTS
--

function Totem_OnUpdate(arg1)
	if( UnitClass("player") == TOTEM_SHAMAN ) then

	Totem_CurrentInterval = Totem_CurrentInterval + arg1;
	if (Totem_CurrentInterval > TotemSettings.interval) then
		local tdata = CurrentTotems[TOTEM_AIR];
		if tdata then
			if ( tdata.duration < 0 ) then
				Totem_DestroyTotem(tdata.totem);
			else
				tdata.duration = tdata.duration - Totem_CurrentInterval;
				getglobal("FlexTimer" .. TotemSettings.button_air .. "Time"):SetText(Totem_FormatTime(tdata.duration));
			end
		end
		tdata = CurrentTotems[TOTEM_WATER];
		if tdata then
			if ( tdata.duration < 0 ) then
				Totem_DestroyTotem(tdata.totem);
			else
				tdata.duration = tdata.duration - Totem_CurrentInterval;
				getglobal("FlexTimer" .. TotemSettings.button_water .. "Time"):SetText(Totem_FormatTime(tdata.duration));
			end
		end
		tdata = CurrentTotems[TOTEM_FIRE];
		if tdata then
			if ( tdata.duration < 0 ) then
				Totem_DestroyTotem(tdata.totem);
			else
				tdata.duration = tdata.duration - Totem_CurrentInterval;
				getglobal("FlexTimer" .. TotemSettings.button_fire .. "Time"):SetText(Totem_FormatTime(tdata.duration));
			end
		end
		tdata = CurrentTotems[TOTEM_EARTH];
		if tdata then
			if ( tdata.duration < 0 ) then
				Totem_DestroyTotem(tdata.totem);
			else
				tdata.duration = tdata.duration - Totem_CurrentInterval;
				getglobal("FlexTimer" .. TotemSettings.button_earth .. "Time"):SetText(Totem_FormatTime(tdata.duration));
			end
		end
		if (TotemSettings.advanced) then Totem_AdvancedStomp(); end
		Totem_CurrentInterval = 0;
	end

	end
end

function Totem_OnLoad()
	SlashCmdList["FLEXTOTEM"] = Totem_SlashCommand;
	SLASH_FLEXTOTEM1 = "/flextotem"; 

	Totem_CurrentInterval = 0;

	if( UnitClass("player") == TOTEM_SHAMAN ) then
		Totem_Enable();
		Totem_SetupHooks();
	end;
end

function Totem_OnEvent(event)
	if event=="VARIABLES_LOADED" then
		Totem_Setup();
	elseif event=="SPELLCAST_STOP" then
		if TotemState then
			Totem_CreateTotem();
		end
		TotemState = nil;
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or 
		event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or
		event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or
		event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" ) then

		for num, regex in TOTEM_DAMAGE_REGEX do
			match = { string.gfind(arg1, regex)() };
			if ( table.getn(match) >= 1 ) then
				Totem_TotemDamage(match[1], match[3]);
				break;
			end
		end
	elseif (event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH") then
		if (arg1 == UNITDIESSELF) then
			if CurrentTotems[TOTEM_AIR] then Totem_DestroyTotem(CurrentTotems[TOTEM_AIR].totem) end
			if CurrentTotems[TOTEM_EARTH] then Totem_DestroyTotem(CurrentTotems[TOTEM_EARTH].totem) end
			if CurrentTotems[TOTEM_FIRE] then Totem_DestroyTotem(CurrentTotems[TOTEM_FIRE].totem) end
			if CurrentTotems[TOTEM_WATER] then Totem_DestroyTotem(CurrentTotems[TOTEM_WATER].totem) end
			getglobal("FlexTimer" .. TotemSettings.button_air .. "Time"):SetText("");
			getglobal("FlexTimer" .. TotemSettings.button_earth .. "Time"):SetText("");
			getglobal("FlexTimer" .. TotemSettings.button_fire .. "Time"):SetText("");
			getglobal("FlexTimer" .. TotemSettings.button_water .. "Time"):SetText("");
			Totem_CheckStomp();			
		end
	end
end

function Totem_SlashCommand(msg)
	if( UnitClass("player") == TOTEM_SHAMAN ) then
		local x, y, silent, command, param = string.find( msg, "%s*([&]?)(%S*)%s*(.*)" );
		if silent ~= "" then silent = true else silent = false end
		if not TotemSettings.notify then silent = true end
		command = string.lower(command);

		if ( command == "debug" ) then
			local on = not TotemSettings.debug; if param == "on" then on = true elseif param == "off" then on = false end
			TotemSettings.debug = on;
			if on then 
				Totem_Notify(TOTEM_SETTINGS_DEBUG_ENABLED, silent, true);
			else
				Totem_Notify(TOTEM_SETTINGS_DEBUG_DISABLED, silent, true);
			end
		elseif ( command == "advanced" ) then
			local on = not TotemSettings.advanced; if param == "on" then on = true elseif param == "off" then on = false end
			TotemSettings.advanced = on;
			if on then 
				Totem_Notify(TOTEM_SETTINGS_ADVANCED_ENABLED, silent, true);
			else
				Totem_Notify(TOTEM_SETTINGS_ADVANCED_DISABLED, silent, true);
			end
		elseif ( command == "threshold" ) then
			local button = -1; if (param ~= "") then button = button + param + 1; end
			if (button == -1) then
				Totem_Notify(gsub(TOTEM_SETTINGS_THRESHOLD, "$T", TotemSettings.threshold), silent, true);
			else 
				TotemSettings.threshold = button;
				Totem_Notify(gsub(TOTEM_SETTINGS_THRESHOLD, "$T", TotemSettings.threshold), silent, true);
			end
		elseif ( command == "interval" ) then
			local button = -1; if (param ~= "") then button = button + param + 1; end
			if (button == -1) then
				Totem_Notify(gsub(TOTEM_SETTINGS_INTERVAL, "$T", TotemSettings.interval * 1000), silent, true);
			else 
				TotemSettings.interval = button / 1000;
				Totem_Notify(gsub(TOTEM_SETTINGS_INTERVAL, "$T", button), silent, true);
			end
		elseif ( command == "silent" ) then
			local on = not TotemSettings.notify; if param == "on" then on = false elseif param == "off" then on = true end
			TotemSettings.notify = on;
			if on then 
				Totem_Notify(TOTEM_SETTINGS_SILENT_DISABLED, false, true);
			else
				Totem_Notify(TOTEM_SETTINGS_SILENT_ENABLED, false, true);
			end
		elseif ( command == "reset" ) then
			Totem_Reset();
			Totem_Notify(TOTEM_SETTINGS_RESET, silent, true);
		elseif ( command == "earth" ) then		
			local button = 0; if (param ~= "") then button = button + param + 0; end
			if (button >0 and button <= 120) then	
				getglobal("FlexTimer" .. TotemSettings.button_earth .. "Time"):SetText("");				
				TotemSettings.button_earth = button;
				Totem_Notify(gsub(gsub(TOTEM_SETTINGS_BUTTON_CONFIRM, "$E", TOTEM_EARTH), "$B", button), silent, true);
			else
				Totem_Error(button.." is not a valid buttonnumber.");
			end				
		elseif ( command == "fire" ) then		
			local button = 0; if (param ~= "") then button = button + param + 0; end
			if (button >0 and button <= 120) then	
				getglobal("FlexTimer" .. TotemSettings.button_fire .. "Time"):SetText("");				
				TotemSettings.button_fire = button;
				Totem_Notify(gsub(gsub(TOTEM_SETTINGS_BUTTON_CONFIRM, "$E", TOTEM_FIRE), "$B", button), silent, true);
			else
				Totem_Error(button.." is not a valid buttonnumber.");
			end				
		elseif ( command == "water" ) then	
			local button = 0; if (param ~= "") then button = button + param + 0; end
			if (button >0 and button <= 120) then	
				getglobal("FlexTimer" .. TotemSettings.button_water .. "Time"):SetText("");				
				TotemSettings.button_water = button;
				Totem_Notify(gsub(gsub(TOTEM_SETTINGS_BUTTON_CONFIRM, "$E", TOTEM_WATER), "$B", button), silent, true);
			else
				Totem_Error(button.." is not a valid buttonnumber.");
			end				
		elseif ( command == "air" ) then	
			local button = 0; if (param ~= "") then button = button + param + 0; end	
			if (button >0 and button <= 120) then	
				getglobal("FlexTimer" .. TotemSettings.button_air .. "Time"):SetText("");				
				TotemSettings.button_air = button;
				Totem_Notify(gsub(gsub(TOTEM_SETTINGS_BUTTON_CONFIRM, "$E", TOTEM_AIR), "$B", button), silent, true);
			else
				Totem_Error(button.." is not a valid buttonnumber.");
			end				
		elseif ( command == "stomp" ) then		
			if param ~= "" then 
				button = param + 0;
				if (button >0 and button <= 120) then	
					Totem_UpdateStomp(TotemSettings.button_stomp);
					TotemSettings.button_stomp = button;
					Totem_Notify(gsub(TOTEM_SETTINGS_BUTTON_STOMP, "$B", button), silent, true);
					Totem_CheckStomp();
				else
					Totem_Error(button.." is not a valid buttonnumber.");
				end				
			else
				Totem_Stomp();
			end
		elseif ( command == "preset" ) then
			if param ~= "" then TotemSettings.preset = param; end
			Totem_Notify(gsub(TOTEM_SETTINGS_REPORT_PRESET, "$P", TotemSettings.preset), silent, true);
		elseif ( command == "buttons" ) then		
			Totem_Notify(TOTEM_AIR .. " " .. TotemSettings.button_air .. " | " .. TOTEM_EARTH .. " " .. TotemSettings.button_earth .. " | " .. TOTEM_FIRE .. " " .. TotemSettings.button_fire .. " | " .. TOTEM_WATER .. " " .. TotemSettings.button_water .. " | " .. TOTEM_STOMP .. " " .. TotemSettings.button_stomp, silent, true); 
		elseif ( command == "save" ) then
			Totem_SaveStomp(param);
			Totem_Notify(gsub(TOTEM_SETTINGS_SAVE, "$S", param), silent, true);
		elseif ( command == "load" ) then
			if Totem_LoadStomp(param) then 
				Totem_Notify(gsub(TOTEM_SETTINGS_LOAD, "$S", param), silent, true); 
			end
		elseif ( command == "lock" ) then
			if FBState[TotemSettings.button_air]["group"] == TotemSettings.button_air then
				local on = true; if FBState[TotemSettings.button_air]["locked"] then on = false; end
				if param == "on" then on = true elseif param == "off" then on = false end
				if on then 
					Totem_Execute("lock group=" .. TotemSettings.button_air);
					Totem_Execute("lockicon group=" .. TotemSettings.button_air);
					Totem_Execute("hidegrid group=" .. TotemSettings.button_air);
					Totem_Execute("text3 text='' group=" .. TotemSettings.button_air);
					Totem_Notify(TOTEM_SETTINGS_LOCK_ENABLED, silent, true);
				else
					Totem_Execute("unlock group=" .. TotemSettings.button_air);
					Totem_Execute("lockicon group=" .. TotemSettings.button_air .. " off='true'");
					Totem_Execute("showgrid group=" .. TotemSettings.button_air);
					Totem_Execute("text3 text='%d' group=" .. TotemSettings.button_air);
					Totem_Notify(TOTEM_SETTINGS_LOCK_DISABLED, silent, true);
				end
			else
				Totem_Error("Lock only works for the default configuration.");
			end
		elseif ( command == "remove" ) then
			StaticPopupDialogs["FLEXREMOVE"] = {
			        text = TOTEM_SETTINGS_REMOVE_WARNING,
			        button1 = YES,
			        button2 = NO,
			       	OnAccept = function()
					Totem_Remove()
			        end,
			        timeout = 0,
			        exclusive = 1,
			       	whileDead = 1,
			        interruptCinematic = 1
			};
			StaticPopup_Show("FLEXREMOVE");
		elseif ( command == "update" ) then
			StaticPopupDialogs["FLEXUPDATE"] = {
			        text = TOTEM_SETTINGS_UPDATE_WARNING,
			        button1 = YES,
			        button2 = NO,
			       	OnAccept = function()
					Totem_Update()
			        end,
			        timeout = 0,
			        exclusive = 1,
			       	whileDead = 1,
			        interruptCinematic = 1
			};
			StaticPopup_Show("FLEXUPDATE");
		elseif ( command == "default" ) then
			if param=="help" then
				for n in TOTEM_DEFAULT do
					if n==1 then 
						Totem_Notify(TOTEM_DEFAULT[n], false, true);
					else
						Totem_Notify(TOTEM_DEFAULT[n], false, false);
					end
				end
			else	
				local button = string.gfind(param, "start=(%d+)")();
				if button == nil then button = 90; else button = button + 0; end
				local padding = string.gfind(param, "padding=(%d+)")();
				if padding == nil then padding = 3; else padding = padding + 0; end
				local scale1 = string.gfind(param, "scale1=(%d+)")();
				if scale1 == nil then scale1 = 10; else scale1 = scale1 + 0; end
				local scale2 = string.gfind(param, "scale2=(%d+)")();
				if scale2 == nil then scale2 = 8; else scale2 = scale2 + 0; end
				local x = string.gfind(param, "x=(%d+)")();
				if x == nil then x = 300; else x = x + 0; end
				local y = string.gfind(param, "y=(%d+)")();
				if y == nil then y = 300; else y = y + 0; end
				local align = string.gfind(param, "align=(%w+)")();
				if not (align=="bottom" or align=="top") then align = "bottom"; end

				if (button >0 and button<=120-27) then
				
					StaticPopupDialogs["FLEXDEFAULT"] = {
					        text = gsub(gsub(TOTEM_SETTINGS_DEFAULT_WARNING, "$A", button), "$Z", button + 27),
				        	button1 = YES,
					        button2 = NO,
				        	OnAccept = function()
							Totem_Default(button, scale1, scale2, padding, x, y, align)
					        end,
					        timeout = 0,
					        exclusive = 1,
				        	whileDead = 1,
					        interruptCinematic = 1
					};
					StaticPopup_Show("FLEXDEFAULT");
				else 
					Totem_Error(button.." is not a valid buttonnumber.");
				end
			end
		elseif ( command == "report" ) then
			local preset = TotemSettings.preset; if param ~= "" then preset = param; end
			local s = "";		
			if StompData.total>0 then
				local n; local t = {};
				t[TOTEM_AIR] = ""; t[TOTEM_EARTH] = ""; t[TOTEM_FIRE] = ""; t[TOTEM_WATER] = "";
				for n=1, StompData.total do
					if (s ~= "") then if (n == StompData.total) then s = s .. " & "; else s = s .. ", "; end end
					local c = TotemData[StompData[n].icon];
					s = s .. c;
					t[TotemData[c].element]=c;
				end
				Totem_Debug("Command is '" .. preset .. "' and totems are '" .. s .. "'.");
				preset = gsub(preset, "$a", t[TOTEM_AIR]);
				preset = gsub(preset, "$e", t[TOTEM_EARTH]);
				preset = gsub(preset, "$f", t[TOTEM_FIRE]);
				preset = gsub(preset, "$w", t[TOTEM_WATER]);
				preset = gsub(preset, "$s", s);
				FBEventArgs = nil; FB_Execute_Command(preset);
			else
				Totem_Notify(TOTEM_SETTINGS_NO_SEQUENCE, silent, true);
			end
		elseif ( command == "help" or command =="?" ) then
			for n in TOTEM_HELP do
				if n==1 then 
					Totem_Notify(TOTEM_HELP[n], false, true);
				else
					Totem_Notify(TOTEM_HELP[n], false, false);
				end
			end
		else
			for n in TOTEM_SLASH do
				if n==1 then 
					Totem_Notify(TOTEM_SLASH[n], false, true);
				else
					Totem_Notify(TOTEM_SLASH[n], false, false);
				end
			end
		end
	else
		Totem_Error("Only available to the Shaman class.");
	end
end 

