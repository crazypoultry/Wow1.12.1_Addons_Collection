
-- Default Config
Default_Servitude_Config = {
		Version = ServitudeProp.Version;

		VWAutoShadow = false;
		VWAutoShadowRatio = 0.66;
		VWAutoSacrif = true;
		VWAutoSacrifCombat = true;		
		VWSacrificeAlert = true;
		VWAutoSacrifPetRatio = 0.20;
		VWAutoSacrifPlayerRatio = 0.20;
		
		ImpSmartFireshield = false;
		ImpSmartFireshieldNeutral = true;
		ImpSmartFireshieldSolo = false;
		ImpSmartFireshieldAlways = false;
		ImpFireShieldAlert = true;
		
		ScbAutoInvisib = true;
		ScbAutoInvisibManaRatio = 0.5;
		ScbInvisDelay = false;
		ScbSeduceCOS = true;
		ScbSeduceCOE = false;
		ScbSeduceAnnounce = true;
		ScbSeduceAnnounceRaid = false;		
		
--		ScbSeduceFollow = false;
		ScbSeduceAlert = true;
--		ScbAlwaysSeduce = false;

		FHNonCombatDevour = true;
		FHHungerDevour = true;
		FHHungerDevourRatio = 1.0;
		FHPartyDevour = true;
		FHDevourSelf = false;
		FHDevourPets = false;
		FHDevourIgnoreSelf = false;
		FHRaidDevour = false;
		FHDevourMindVision = false;
		FHSpellLockPVP = true;
		FHSpellLockPVE = true;
		FHDisableNotification = false;
		FHClassAsPriority = false;
		FHPriorityUnitOnly = false;
		FHDevourAlert = true;
		FHSpellLockAlert = true;
		
		OneButton = false;
		HealthWarning = true;
		HealthWarningRatio = 0.30;
		HealthWarningVocal = true;
}

-----------------------------------------------------------------------------------
--
-- Workaround functions to handle a problem where the money field of a tooltip
-- will get hidden whenever tooltips are invoked.
-- 
-- Code by Telo.  From his post:
--   "Whenever a tooltip is set, the game sends a CLEAR_TOOLTIP event, which causes GameTooltip_OnEvent to call 
--   GameTooltip_ClearMoney, hiding the money frame for GameTooltip. There doesn't appear to be any identifying 
--   information sent with the CLEAR_TOOLTIP event that would allow GameTooltip_OnEvent to discriminate between 
--   its tooltip and others, so simply hooking this function doesn't appear to help. I've worked around the 
--   issue for my code by using something similar to the following code wherever I use a hidden tooltip."
--   (http://forums.worldofwarcraft.com/thread.aspx?fn=wow-interface-customization&t=16768&tmp=1#post16768)
--
-----------------------------------------------------------------------------------
--[[

local sOriginal_GameTooltip_ClearMoney;
local function Servitude_MoneyToggle()
    if( sOriginal_GameTooltip_ClearMoney ) then
        GameTooltip_ClearMoney = sOriginal_GameTooltip_ClearMoney;
        sOriginal_GameTooltip_ClearMoney = nil;
    else
        sOriginal_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
        GameTooltip_ClearMoney = Servitude_GameTooltip_ClearMoney;
    end
end
function Servitude_GameTooltip_ClearMoney()
    -- Intentionally empty; don't clear money while we use hidden tooltips
end
]]--

Magical_Debuff_List = {};
Pet_Action_List = {};
Pet_Mana_Cost = {};
Devour_Order = {[1] = InCombatDivider};
Spell_Lock_List = {};
Spell_Lock_Order = {[1] = SpellLockDivider};
Class_Order = {[1] = ClassDivider};
FireShieldClass_Order = {[1] = ClassDivider};
Devour_Priority = {};
Unit_Priority = {};
Class_Priority = {};
FireShieldClass_Priority = {};
Spell_Priority = {};
IgnoreUnit = {};
ServitudeAlert_Hide = false;
PetActionQueue = {};

-- Default Message color
Servitude_RED   = 1.0;
Servitude_GREEN = 1.0;
Servitude_BLUE  = 1.0;
Servitude_ALPHA = 1.0;

-- Debug Variables

local DebugMsg = false;
local ErrorMsg = true;
local DebugMode = false;

-- Runtime Variables
local IsPlayerInCombat = false;
local IsPetInCombat = false;

local nextCheck = GetTime();
local raidCheck = GetTime();
local partyCheck = GetTime();
local shieldCheck = GetTime() + 8;
local petUpdate = GetTime();
local CycleLength = 0.30;
local FHIsHungry = true;
local Loaded = false;
local DevourAlerted = false;
local DispelAlerted = false;
local FireShieldAlerted = false;
local sedTarget = "";
local hasSeduced = false;
local reactivateMelee = false;
local meleeEnabled = false;
local invisDelay = GetTime();
local sacDelay = GetTime();
local consDelay = GetTime();
local healthDelay = GetTime();
local ignoreTime = GetTime();
local alertTime = GetTime();
local SpellLockCheck = GetTime();
local SedHoldLOPDelay = GetTime();
local SedHoldLOP = false;
local SedEnableLOP = false;
--local keepSeduced = false;
local shieldIndex = nil;
local soulIndex = nil;
--local sedCheck = GetTime();
local SpellsLoaded = false;
local PetBarLoaded = false;
local PetSpellsInitialized = false;
local PriorityUnitName = nil;
local PriorityUnitID = nil;
local ServCOS = nil;
local ServCOE = nil;


local targetVar = {};

-- Loader
function Servitude_OnLoad()
	-- Cannot load the whole thing until player's class is determined
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	-- Register Slash Command
    	SlashCmdList["SERVITUDE"] = Servitude_SlashCmd;
	SLASH_SERVITUDE1 = "/servitude";
	SLASH_SERVITUDE2 = "/serv";
end

function Servitude_Init()
	if Loaded then
		return;
	elseif (UnitClass("player") ~= ServitudeLocalization.Class and not DebugMode) then
		if UnitClass("player") ~= nil then
			ServitudeMessage(DebugMsg, "Servitude Not Loaded: Player is a " .. UnitClass("player"));
		end
		if (ServitudeAlert_Hide) then
			ServitudeAlertAnchor:Hide();
		end		
		return;
	else
		Loaded = true;
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.WelcomeMsg);
	end

-- Hide the ServitudeAlert message frame
	if (ServitudeAlert_Hide) then
		ServitudeAlertAnchor:Hide();
	end
	-- First install or upgrade, Load Variable from default and show config window
	if type(Servitude_Config) ~= "table" or not TableTypeMatch(Default_Servitude_Config, Servitude_Config) or (Servitude_Config.Version ~= Default_Servitude_Config.Version) then
		Servitude_Config = {};
		Servitude_Config = Default_Servitude_Config;
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.LoadDefault);
	end

	if (TableSize(Magical_Debuff_List) ~= (table.getn(Devour_Order) - 1) or TableSize(Magical_Debuff_List) < 1)  then
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.DebuffDatabaseCorrupted);
		if (GetLocale() == "frFR") then
			Magical_Debuff_List = {};
			Devour_Order = {};
			Magical_Debuff_List = FR_Magical_Debuff_List;
			Devour_Order = FR_Devour_Order;
		elseif (GetLocale() == "deDE") then
			Magical_Debuff_List = {};
			Devour_Order = {};
			Magical_Debuff_List = DE_Magical_Debuff_List;
			Devour_Order = DE_Devour_Order;
		else
			Magical_Debuff_List = {};
			Devour_Order = {};			
			Magical_Debuff_List = English_Magical_Debuff_List;
			Devour_Order = English_Devour_Order;
		end
		BuffDatabase_BuildArray();
	else
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.DebuffDatabaseVerified, TableSize(Magical_Debuff_List));
		BuffDatabase_BuildArray();
	end

	if (TableSize(Spell_Lock_List) ~= (table.getn(Spell_Lock_Order) - 1) or TableSize(Spell_Lock_List) < 1)  then
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.SpellDatabaseCorrupted);
		if (GetLocale() == "frFR") then
			Spell_Lock_List = {};
			Spell_Lock_Order = {};
			Spell_Lock_List = FR_Spell_Lock_List;
			Spell_Lock_Order = FR_Spell_Lock_Order;
		elseif (GetLocale() == "deDE") then
			Spell_Lock_List = {};
			Spell_Lock_Order = {};
			Spell_Lock_List = DE_Spell_Lock_List;
			Spell_Lock_Order = DE_Spell_Lock_Order;
		else
			Spell_Lock_List = {};
			Spell_Lock_Order = {};
			Spell_Lock_List = English_Spell_Lock_List;
			Spell_Lock_Order = English_Spell_Lock_Order;
		end
		SpellDatabase_BuildArray();
	else
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.SpellDatabaseVerified, TableSize(Spell_Lock_List));
		SpellDatabase_BuildArray();		
	end

	if (TableSize(FireShieldClass_Order) < 10) then
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.FireShieldClassDatabaseCorrupted);
		if (GetLocale() == "frFR") then			
			FireShieldClass_Order = {};
			FireShieldClass_Order = FR_Class_Order;
		elseif (GetLocale() == "deDE") then
			FireShieldClass_Order = {};
			FireShieldClass_Order = DE_Class_Order;		
		else
			FireShieldClass_Order = {};
			FireShieldClass_Order = English_Class_Order;		
		end
		FireShieldClassDatabase_BuildArray();
	else
		FireShieldClassDatabase_BuildArray();
	end
	
	if (TableSize(Class_Order) < 10) then
		ServitudeMessage(ErrorMsg, ServitudeChatMsg.ClassDatabaseCorrupted);
		if (GetLocale() == "frFR") then			
			Class_Order = {};
			Class_Order = FR_Class_Order;
		elseif (GetLocale() == "deDE") then
			Class_Order = {};
			Class_Order = DE_Class_Order;
		else
			Class_Order = {};
			Class_Order = English_Class_Order;
		end
		ClassDatabase_BuildArray();
	else
		ClassDatabase_BuildArray();
	end
	
	StoreCOS();
	StoreCOE();
	
	
	-- Register Events	
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
    this:RegisterEvent("SPELLS_CHANGED");
    this:RegisterEvent("LEARNED_SPELL_IN_TAB");	
--	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_AURA");
--	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_PET");
--	this:RegisterEvent("PET_BAR_SHOWGRID");
	this:RegisterEvent("PET_BAR_UPDATE");
	
	-- Events from MezHelper
--	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");

	-- events for Spell Lock
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	
	-- event for detecting Dark Pact has been cast
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");

	-- Replacing existing event functions
--	Original_PetActionBarFrame_OnUpdate = PetActionBarFrame_OnUpdate;
--	PetActionBarFrame_OnUpdate = Servitude_PetActionBarFrame_OnUpdate;

	-- Replacing existing event functions
--	Original_PetActionBar_Update = PetActionBar_Update;
--	PetActionBar_Update = Servitude_PetActionBar_Update;


--	Original_TogglePetAutocast = TogglePetAutocast;
--	TogglePetAutocast = Servitude_TogglePetAutocast;
end

function Servitude_SlashCmd(msg)
	if (UnitClass("player") ~= ServitudeLocalization.Class and not DebugMode) then
		ServitudeMessage(ErrorMsg, "Servitude is a warlock addon. Player is a " .. UnitClass("player") .. ".");
		return;
	else
-- Borrowing some code from AssistHelper
		local _, _, cmd, arg1 = string.find( msg, "%s*(%S*)%s*(.*)" );
		cmd = string.lower(cmd);
		if cmd == "set" then
			Servitude_CmdSet( arg1 );
		elseif cmd == "clear" then
			Servitude_CmdClear();
		elseif cmd == "help" then
			ServitudeMessage(ErrorMsg, "Type /servitude or /serv to open the config panel.");
			ServitudeMessage(ErrorMsg, "Type /servitude set {name} or /serv set {name} to set the Priority Unit for Auto-Devour. If optional name is not present, the players target will be used. The unit MUST be in your party or raid group.");
			ServitudeMessage(ErrorMsg, "Type /servitude clear or /serv clear to clear the Priority Unit.");
			ServitudeMessage(ErrorMsg, "Type /servitude show or /serv show to show the Servitude Message frame.");
			ServitudeMessage(ErrorMsg, "Type /servitude help or /serv help to show this information.");
			ServitudeMessage(ErrorMsg, "Please note: Due to an API change, Servitude can no longer cast pet spells without player interaction.");
		elseif cmd == "show" then
			Servitude_CmdShow();
		else	
			ServitudeConfigFrame:Show();
		end
	end
end

function Servitude_CmdSet( name )
	if name ~= nil and string.len(name) > 0 then
		local UnitCheck = GetUnitInGroup(name);
		if UnitCheck ~= nil then
			PriorityUnitName = name;
			PriorityUnitID = UnitCheck;
			ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit is set as "..PriorityUnitName..". They will be scanned before anyone else.");
		else
			ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit must be in your party or raid.");
		end
	elseif UnitName("target") == nil then
		PriorityUnitName = nil;
		PriorityUnitID = nil;
		ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit has been cleared.");
	elseif UnitIsPlayer("target") and UnitIsFriend("target","player") then		
		local UnitCheck = GetUnitInGroup(UnitName("target"));
		if UnitCheck ~= nil then
			PriorityUnitName = string.lower(UnitName("target"));
			PriorityUnitID = UnitCheck;
			ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit is set as "..PriorityUnitName..". They will be scanned before anyone else.");
		else
			ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit must be in your party or raid.");
		end		
	end
end

function Servitude_CmdClear()
	PriorityUnitName = nil;
	PriorityUnitID = nil;
	ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit has been cleared.");
end

function Servitude_CmdShow()
	ServitudeAlert_Hide = false;
	ServitudeAlertAnchor:Show();	
end

function GetUnitInGroup(pname)
	if GetNumRaidMembers() > 0 then
		local i;
		for i = 1, GetNumRaidMembers(), 1 do
			if strlower(UnitName("raid"..i)) == strlower(pname) then
				return "raid"..i;
			end
		end	
	elseif GetNumPartyMembers() > 0 then
		local i;
		for i = 1, GetNumPartyMembers(), 1 do
			if strlower(UnitName("party"..i)) == strlower(pname) then
				return "party"..i;
			end
		end	
	else
		return nil;
	end	
end

-- check each variable in two tables making sure their variable type match.
function TableTypeMatch(table1, table2)
	for key,value in pairs(table1) do
		if type(table1[key]) ~= type(table2[key]) then
			return false
		end
	end
	return true;
end

function TableSize(t)
	local i = 0;
	for key,value in pairs(t) do
		i = i + 1;
	end
	return i;
end

function ServitudeConfigFrame_OnShow()
	ServitudeConfigFrameLoadSetting(Servitude_Config);
end

function ServitudeConfigFrameOkay_OnClick()
	ServitudeConfigFrameSaveSetting(Servitude_Config);
	ServitudeConfigFrame:Hide();
end

function ServitudeConfigFrameLoadSetting(configset)
	local DebugMsg = false;
	for key,value in pairs(configset) do
		ServitudeMessage(DebugMsg, key, value);
		if key == "Version" then
			-- do nothing
		elseif type(value) == "boolean"  then
			local nametag = getglobal(key .. "_CheckButton");
			if type(nametag) ~= "nil" then
				if value then
					nametag:SetChecked(1);
				else
					nametag:SetChecked(0);
				end
				nametag.tooltipText = ConfigObjectTooltip[key];

				nametag = getglobal(key .. "_CheckButtonText");
				nametag:SetText(ConfigObjectText[key]);
				nametag:SetTextColor(1,1,1);
			else
				ServitudeMessage(ErrorMsg, ServitudeChatMsg.ObjectLoadFail, key, "(", value, ")");
			end
		elseif type(value) == "number" then
			local nametag = getglobal(key .. "_Slider");
			if type(nametag) ~= "nil" then
				nametag:SetValue(value * 100);

				nametag = getglobal(key .. "_SliderLow");
				nametag:SetText("0%");
				nametag = getglobal(key .. "_SliderHigh");
				nametag:SetText("100%");

				nametag = getglobal(key .. "_SliderText");
				nametag:SetText(ConfigObjectText[key]);
			else
				ServitudeMessage(ErrorMsg, ServitudeChatMsg.ObjectLoadFail, key, "(", value, ")");
			end
		end
	end
end

function ServitudeConfigFrameSaveSetting(configset)
	for key,oldvalue in pairs(configset) do
		if key == "Version" then
			-- do nothing
		elseif type(oldvalue) == "boolean"  then
			local nametag = getglobal(key .. "_CheckButton");
			if type(nametag) ~= "nil" then
				local newvalue = not not nametag:GetChecked();
				if newvalue ~= oldvalue then
					configset[key] = newvalue;
					ServitudeMessage(DebugMsg, key, "has been updated from", oldvalue,"to", newvalue)
				end
			else
				ServitudeMessage(ErrorMsg, ServitudeChatMsg.ObjectSaveFail, key, "(", oldvalue, ")");
			end
		elseif type(oldvalue) == "number" then
			local nametag = getglobal(key .. "_Slider");
			if type(nametag) ~= "nil" then
				local newvalue = nametag:GetValue() / 100;
				if (oldvalue ~= newvalue) then
					configset[key] = newvalue;
					ServitudeMessage(DebugMsg, key, "has been updated from", oldvalue,"to", newvalue);
				end
			else
				ServitudeMessage(ErrorMsg, ServitudeChatMsg.ObjectSaveFail, key, "(", oldvalue, ")");
			end
		end
	end
end

-- Looping function that excutes once every set duration
function Servitude_OnUpdate()
	if (not Loaded or not PetBarLoaded) then
		return;
	end
	if PetActionQueue["SpellLock"] ~= nil and GetTime() > SpellLockCheck then
		PetActionQueue["SpellLock"] = nil;
	end
	if (GetTime() < nextCheck) then
		return;
	end
	local DebugMsg = false;
	ServitudeMessage(DebugMsg, "On Update");
	DataMineDevourableDebuff();

	nextCheck = GetTime() + CycleLength;
	
--	if (PetBarLoaded and not PetSpellsInitialized) then	
--		Intialize_Pet_Action_State();
--		return;
--	end
	
--	if (not SpellsLoaded and PetSpellsInitialized) then
	if (not SpellsLoaded) then	
		Build_ManaCosts();
		return;
	end

--	if (not SpellsLoaded or not PetSpellsInitialized or not GetPetActionsUsable()) then
	if (not SpellsLoaded or not GetPetActionsUsable()) then	
		return;
	end
--	if SedHoldLOP and GetTime() > SedHoldLOPDelay then
--		SedHoldLOP = false;
--		UpdateLOPState();
--	end
	if (not UnitAffectingCombat("pet") and not UnitAffectingCombat("player")) then
		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
			CheckInvisibility();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet2) then
			CheckConsumeShadow();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet4 and Pet_Action_List[ServitudeLocalization.Magic5] ~= nil) then
			CheckDevourMagic();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet5 and Pet_Action_List[ServitudeLocalization.Magic10] ~= nil) then
			CheckDispelMagic();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet1 and Pet_Action_List[ServitudeLocalization.Magic7] ~= nil) then
			CheckFireShield();
		end
	else
		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet4 and Pet_Action_List[ServitudeLocalization.Magic5] ~= nil) then
			CheckDevourMagic();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet5 and Pet_Action_List[ServitudeLocalization.Magic10] ~= nil) then
			CheckDispelMagic();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet1 and Pet_Action_List[ServitudeLocalization.Magic7] ~= nil) then
			CheckFireShield();
		end
	end
end


-- Event handler
function Servitude_OnEvent(event)
	local DebugMsg = false;

--	if (event == "UNIT_NAME_UPDATE" and arg1 == "player") then
--	if (event == "VARIABLES_LOADED") then
	if (event == "PET_BAR_UPDATE") then
		local i;
		local DebugMsg = false;
		if (not PetBarLoaded) then
			PetBarLoaded = true;
		end					
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name,_,_,_,_,_,_ = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			else return
			end
--			ServitudeMessage(DebugMsg, "Pet Action "..name.." added as index "..i);
--			if (name == ServitudeLocalization.Magic1) then
--				MakePetActionAutoCastable (i, Servitude_Config.ScbAutoInvisib);
--			elseif (name == ServitudeLocalization.Magic4) then
--				MakePetActionAutoCastable (i, Servitude_Config.VWAutoSacrif);
--			elseif (name == ServitudeLocalization.Magic3) then
--				MakePetActionAutoCastable (i, Servitude_Config.VWAutoShadow);
--			end
		end

	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") then
		local spellname;
		local caster;
		local DebugMsg = false;
		ServitudeMessage(DebugMsg, "Casting detected");
		for caster, spellname in string.gfind(arg1, ServitudeLocalization.CastString) do
			if (not Spell_Lock_List[spellname]) then
				Spell_Lock_List[spellname] = "Observed";
				local SpellNumber = table.getn(Spell_Lock_Order) + 1;
				Spell_Lock_Order[SpellNumber] = spellname;
				if not Servitude_Config.FHDisableNotification then
					ServitudeMessage(ErrorMsg, ServitudeChatMsg.NewSpellObserved, spellname );
				end	
			elseif UnitCreatureFamily("pet") == ServitudeLocalization.Pet4 and UnitHealth("pet") > 0 and Pet_Action_List[ServitudeLocalization.Magic9] ~= nil and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic9].Mana then 
				if Servitude_Config.FHSpellLockPVP and UnitName("target") == caster and UnitIsPlayer("target") and ((UnitIsEnemy("target", "player") and UnitIsPVP("target") and UnitIsPVP("player")) or (UnitCanAttack("target", "player") and UnitCanAttack("player", "target"))) then
					local DebugMsg = false;
					ServitudeMessage(DebugMsg, "PVP Spell Lock event detected");
					if SpellHasLockRequested(spellname) and IsPetActionAvailable(ServitudeLocalization.Magic9) then
--						CastPetActionByName(ServitudeLocalization.Magic9);
						if Servitude_Config.OneButton then
							DisplayMessage(ServitudeNotificationMsg.SpellLockPVP..ServitudeNotificationMsg.Primary, spellname);
						else
							DisplayMessage(ServitudeNotificationMsg.SpellLockPVP..ServitudeNotificationMsg.Secondary, spellname);
						end
						PetActionQueue["SpellLock"] = true;
						SpellLockCheck = GetTime() + 3;
						if Servitude_Config.FHSpellLockAlert then
							PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\SpellLock.mp3");
						end	
					end
				elseif Servitude_Config.FHSpellLockPVE and UnitName("target") == caster and UnitIsEnemy("target", "player") and (not UnitIsPlayer("target")) then
					local DebugMsg = false;
					ServitudeMessage(DebugMsg, "PVE Spell Lock event detected");
					if SpellHasLockRequested(spellname) and IsPetActionAvailable(ServitudeLocalization.Magic9) then
--						CastPetActionByName(ServitudeLocalization.Magic9);
						if Servitude_Config.OneButton then
							DisplayMessage(ServitudeNotificationMsg.SpellLockPVE..ServitudeNotificationMsg.Primary, spellname);
						else
							DisplayMessage(ServitudeNotificationMsg.SpellLockPVE..ServitudeNotificationMsg.Secondary, spellname);
						end	
						PetActionQueue["SpellLock"] = true;
						SpellLockCheck = GetTime() + 3;
						if Servitude_Config.FHSpellLockAlert then
							PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\SpellLock.mp3");
						end	
					end	
				end	
			end	
		end
		
	elseif event == "UNIT_HEALTH" and arg1 == "pet" then
--		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
--			UpdateSoothState();
		if UnitCreatureFamily("pet") == ServitudeLocalization.Pet2 then
			if (Servitude_Config.VWAutoSacrif) then
				if (not Servitude_Config.VWAutoSacrifCombat) then
					CheckSacrifice();
				elseif Servitude_Config.VWAutoSacrifCombat and (UnitAffectingCombat("player") or UnitAffectingCombat("pet")) then
					CheckSacrifice();
				end	
			end
--			UpdateTauntState();			
--		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet4) then
--			FHIsHungry = (UnitHealth("pet") <= (Servitude_Config.FHHungerDevourRatio * UnitHealthMax("pet")));
--			UpdateSpellLockState();		
		end
		if Servitude_Config.HealthWarning and UnitAffectingCombat("player") then
			CheckHealth();
		end
	elseif event == "UNIT_HEALTH" and arg1 == "player" then
		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet2) then
			if (Servitude_Config.VWAutoSacrif) then
				if (not Servitude_Config.VWAutoSacrifCombat) then
					CheckSacrifice();
				elseif Servitude_Config.VWAutoSacrifCombat and UnitAffectingCombat("player") then
					CheckSacrifice();
				end	
			end
--			UpdateTauntState();			
		end	
	elseif (event == "UNIT_PET" and arg1 == "player") then
		NewTime = GetTime();
		SpellsLoaded = false;
		PetBarLoaded = false;
		PetSpellsInitialized = false;
		PetActionQueue = {};
		SedHoldLOP = false;
		SedEnableLOP = false;
		SedHoldLOPDelay = NewTime;
		IgnoreUnit = {};
		ignoreTime = NewTime;
		shieldCheck = NewTime;
		alertTime = NewTime;
-- Check for enter or leave combat		
	elseif (event == "PLAYER_REGEN_DISABLED") then
		IsPlayerInCombat = true;
	elseif (event == "PET_ATTACK_START") then
		IsPetInCombat = true;
--		Intialize_Pet_Action_State();
	elseif (event == "PET_ATTACK_STOP") then
		IsPetInCombat = false;	
	elseif (event == "PLAYER_REGEN_ENABLED")then
		if Servitude_Config.ImpFireboltDisable then
--			DisableFirebolt();
		end
		IsPlayerInCombat = false;
		IsPetInCombat = false;		
		sedTarget = "";
		hasSeduced = false;
--		keepSeduced = false;
		if Servitude_Config.VWAutoSacrifCombat then
			PetActionQueue = {};
		elseif (not Servitude_Config.VWAutoSacrifCombat) and PetActionQueue["Sacrifice"] ~= nil then
			PetActionQueue = {};
			PetActionQueue["Sacrifice"] = true;
		end
		if (Servitude_Config.ScbInvisDelay and GetTime() + 10 > invisDelay) then
			invisDelay = GetTime() + 10;
		end	


	elseif event == "CHAT_MSG_SPELL_PET_DAMAGE" and (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
		local _, _, target = string.find(arg1, ServitudeLocalization.SedString);
		local DebugMsg = false;
		if (target == UnitName("pet")) then
			invisDelay = GetTime() + 20;
			hasSeduced = true;
			SedHoldLOP = true;			
			SedHoldLOPDelay = GetTime() + 25;
--			if (not Servitude_Config.ScbSmartLOP and CheckLOPState() == true) then
--				SedEnableLOP = true;
--			end
--			UpdateLOPState();
			ServitudeMessage(DebugMsg, "Detected starting seduction event. Target is "..sedTarget);
		end
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
		local DebugMsg = false;
		ServitudeMessage(DebugMsg, "Detected aura fade");
		local _, _, target = string.find(arg1, ServitudeLocalization.FadeString);			
		if target == sedTarget and hasSeduced == true then
			if Servitude_Config.OneButton then
				DisplayMessage(ServitudeNotificationMsg.SeductionNotification..ServitudeNotificationMsg.Primary);
			else
				DisplayMessage(ServitudeNotificationMsg.SeductionNotification..ServitudeNotificationMsg.Secondary);
			end
			if Servitude_Config.ScbSeduceAlert then
				PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Seduction.mp3");
			end	
			SedHoldLOPDelay = GetTime() + 5;
--			ReSeduceTarget(sedTarget);
--			ServitudeMessage(DebugMsg, "Attempting to re-seduce");
--			sedCheck = GetTime() + 2.25;
		end

--	elseif event == "CHAT_MSG_SPELL_BREAK_AURA" then
--		local DebugMsg = false;			
--		local _, _, target = string.find(arg1, "(.+)'s Seduction fades.");
--		if target == sedTarget and hasSeduced == true then
--			ServitudeMessage(DebugMsg, "Detected Seduce break. Clearing Seduce states.");
--			sedTarget = "";
--			hasSeduced = false;
--		end
		
	-- Dark Pact event
	elseif event == "CHAT_MSG_SPELL_SELF_BUFF" then
		local DebugMsg = false;
		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
			ServitudeMessage(DebugMsg, "Detected Self buff, with Succubus");
			if string.find(arg1, ServitudeLocalization.DarkPactString) then
				ServitudeMessage(DebugMsg, "Detected Dark Pact String");
				if (GetTime() + 5 > invisDelay) then
					invisDelay = GetTime() + 5;
				end
			end			
		end
	elseif (event == "LEARNED_SPELL_IN_TAB" or event == "SPELLS_CHANGED") then
		StoreCOS();
		StoreCOE();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		Servitude_Init();			
	end
end

-- message function that prints variable to default chat frame
function ServitudeMessage(visible, ...)
	for i = 1,arg.n do
		if type(arg[i]) == "nil" then
			arg[i] = "(nil)";
		elseif type(arg[i]) == "boolean" and arg[i] then
			arg[i] = "(true)";
		elseif type(arg[i]) == "boolean" and not arg[i] then
			arg[i] = "(false)";
		end
	end

	if (visible) then
		DEFAULT_CHAT_FRAME:AddMessage("Servitude: " .. table.concat (arg, " "), 0.5, 0.5, 1);
	end
end
--[[
function UpdateSoothState()
	if (not Servitude_Config.ScbSmartSooth) then
		return;
	end
	if Pet_Action_List[ServitudeLocalization.Magic2] ~= nil then
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(Pet_Action_List[ServitudeLocalization.Magic2]);
		local DesireSoothState = (UnitHealth("pet") < (Servitude_Config.ScbSmartSoothRatio * UnitHealthMax("pet")));
		if (not autoCastEnabled) == DesireSoothState then				
				Original_TogglePetAutocast(Pet_Action_List[ServitudeLocalization.Magic2]);
		end
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end
			if (name == ServitudeLocalization.Magic2) then
				local DesireSoothState = (UnitHealth("pet") < (Servitude_Config.ScbSmartSoothRatio * UnitHealthMax("pet")));
				if (not autoCastEnabled) == DesireSoothState then
					Original_TogglePetAutocast(i);
				end
			end
		end
	end	
end

function UpdateLOPState()
	local DebugMsg = false;
	if (not Servitude_Config.ScbSmartLOP and not SedHoldLOP and not SedEnableLOP) then
		return;
	end
	if Pet_Action_List[ServitudeLocalization.Magic11] ~= nil then		
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(Pet_Action_List[ServitudeLocalization.Magic11]);
		if SedHoldLOP == true then
			DesireLOPState = false;
			ServitudeMessage(DebugMsg, "SedHoldLOP is true");
		elseif SedEnableLOP == true then
			DesireLOPState = true;
			SedEnableLOP = false;
			ServitudeMessage(DebugMsg, "SedEnableLOP is true");
		else
			ServitudeMessage(DebugMsg, "SedHoldLOP is false");
			DesireLOPState = (UnitMana("pet") > (Servitude_Config.ScbSmartLOPRatio * UnitManaMax("pet")));
		end	
		if  (not autoCastEnabled) == DesireLOPState then				
				Original_TogglePetAutocast(Pet_Action_List[ServitudeLocalization.Magic11]);
		end
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end
			if (name == ServitudeLocalization.Magic11) then
				if SedHoldLOP == true then
					DesireLOPState = false;
					ServitudeMessage(DebugMsg, "SedHoldLOP is true - for loop");
				else
					ServitudeMessage(DebugMsg, "SedHoldLOP is false - for loop");
					DesireLOPState = (UnitMana("pet") > (Servitude_Config.ScbSmartLOPRatio * UnitManaMax("pet")));
				end	
				if (not autoCastEnabled) == DesireLOPState then
					Original_TogglePetAutocast(i);
				end
			end
		end
	end	
end

function UpdateFireboltState()
	if (not Servitude_Config.ImpSmartFirebolt) then
		return;
	end
	if Pet_Action_List[ServitudeLocalization.Magic13] ~= nil then
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(Pet_Action_List[ServitudeLocalization.Magic13]);
		local DesireFireboltState = (UnitMana("pet") > (Servitude_Config.ImpSmartFireboltRatio * UnitManaMax("pet")));
		if (not autoCastEnabled) == DesireFireboltState then				
				Original_TogglePetAutocast(Pet_Action_List[ServitudeLocalization.Magic13]);
		end
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end
			if (name == ServitudeLocalization.Magic13) then
				local DesireFireboltState = (UnitMana("pet") > (Servitude_Config.ImpSmartFireboltRatio * UnitManaMax("pet")));
				if (not autoCastEnabled) == DesireFireboltState then
					Original_TogglePetAutocast(i);
				end
			end
		end
	end	
end

function UpdateTauntState()
	if (not Servitude_Config.VWAutoTaunt) then
		return;
	end
	local DesireTauntState = false;
	if Pet_Action_List[ServitudeLocalization.Magic6] ~= nil then
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(Pet_Action_List[ServitudeLocalization.Magic6]);
		if not UnitExists("pettarget") then
			DesireTauntState = true;
		else			
			if (Servitude_Config.VWAutoTauntBanish and HasDebuff("pettarget", ServitudeLocalization.Magic12)) then
				DesireTauntState = false;
			else
				DesireTauntState = (UnitHealth("pettarget") > (Servitude_Config.VWAutoTauntRatio * 100));
			end
		end		
		if (not autoCastEnabled) == DesireTauntState then
				local DebugMsg = false;
				ServitudeMessage(DebugMsg, "Toggling from List. Action is "..Pet_Action_List[ServitudeLocalization.Magic6]);
				Original_TogglePetAutocast(Pet_Action_List[ServitudeLocalization.Magic6]);
		end
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end
			if (name == ServitudeLocalization.Magic6) then
				if not UnitExists("pettarget") then
					DesireTauntState = true;
				else					
					if (Servitude_Config.VWAutoTauntBanish and HasDebuff("pettarget", ServitudeLocalization.Magic12)) then
						DesireTauntState = false;
					else
						DesireTauntState = (UnitHealth("pettarget") > (Servitude_Config.VWAutoTauntRatio * 100));
					end
				end		
				if (not autoCastEnabled) == DesireTauntState then
					local DebugMsg = false;
					ServitudeMessage(DebugMsg, "Toggling from for loop. Action is "..name);				
					Original_TogglePetAutocast(i);
				end
			end
		end
	end	
end

function UpdateFireshieldState()
	if (not Servitude_Config.ImpSmartFireshield) then
		return;
	end
	if Pet_Action_List[ServitudeLocalization.Magic7] ~= nil then
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(Pet_Action_List[ServitudeLocalization.Magic7]);
		if autoCastEnabled then
			Original_TogglePetAutocast(Pet_Action_List[ServitudeLocalization.Magic7]);
		end
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end			
			if (name == ServitudeLocalization.Magic7) then
				if autoCastEnabled then
					Original_TogglePetAutocast(i);
				end
			end
		end
	end	
end



function UpdateSpellLockState()
	if not (Servitude_Config.FHSpellLockPVP or Servitude_Config.FHSpellLockPVE) then
		return;
	end
	if Pet_Action_List[ServitudeLocalization.Magic9] ~= nil then
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(Pet_Action_List[ServitudeLocalization.Magic9]);
		if autoCastEnabled then
			Original_TogglePetAutocast(Pet_Action_List[ServitudeLocalization.Magic9]);
		end
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end			
			if (name == ServitudeLocalization.Magic9) then
				if autoCastEnabled then
					Original_TogglePetAutocast(i);
				end
			end
		end
	end	
end

]]--
-- Checking functions to see if a player needs to press a button for something.

function CheckInvisibility()
	local DebugMsg = false;
	if GetTime() > invisDelay and Pet_Action_List[ServitudeLocalization.Magic1] ~= nil and Servitude_Config.ScbAutoInvisib and (not isUnitBuffUp("pet", ServitudeLocalization.Buff3) and (not UnitDebuff("pet", 1))) then
		if UnitMana("pet") > (UnitManaMax("pet") * Servitude_Config.ScbAutoInvisibManaRatio) then
		  ServitudeMessage(DebugMsg, "CheckInvisibility: Status Tests Passed");
			DisplayMessage(ServitudeNotificationMsg.InvisNotification..ServitudeNotificationMsg.Primary);
			PetActionQueue["Invis"] = true;
			invisDelay = GetTime() + 10;
		end
	end
end

function CheckSacrifice()
	local debug = false;
	if GetTime() > sacDelay and Servitude_Config.VWAutoSacrif then
		if UnitHealth("pet") > 0 and ((UnitHealth("pet") <= UnitHealthMax("pet") * Servitude_Config.VWAutoSacrifPetRatio) or (UnitHealth("player") <= UnitHealthMax("player") * Servitude_Config.VWAutoSacrifPlayerRatio)) and (not isUnitBuffUp("player", ServitudeLocalization.Buff1)) then
			ServitudeMessage(DebugMsg, "CheckSacrifice: Status Tests Passed");
			if Servitude_Config.OneButton then
				DisplayMessage(ServitudeNotificationMsg.Sacrifice..ServitudeNotificationMsg.Primary);
			else
				DisplayMessage(ServitudeNotificationMsg.Sacrifice..ServitudeNotificationMsg.Secondary);
			end
			PetActionQueue["Sacrifice"] = true;
			if Servitude_Config.VWSacrificeAlert then
				PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Sacrifice.mp3");
			end	
			sacDelay = GetTime() + 10;
	--		CastPetActionByName(ServitudeLocalization.Magic4);
	--		FindSoulLink("player");
	--		if soulIndex ~= nil then
	--			CancelPlayerBuff(soulIndex);
	--		end
		elseif ((UnitHealth("pet") > UnitHealthMax("pet") * Servitude_Config.VWAutoSacrifPetRatio) and (UnitHealth("player") > UnitHealthMax("player") * Servitude_Config.VWAutoSacrifPlayerRatio)) then
			PetActionQueue["Sacrifice"] = nil;
		end
	end
end

function CheckConsumeShadow()
	local DebugMsg = false;
	if GetTime() > consDelay and Servitude_Config.VWAutoShadow then
		if (UnitHealth("pet") < UnitHealthMax("pet") * Servitude_Config.VWAutoShadowRatio) and (UnitMana("pet") > UnitManaMax("pet") / 3) then
			ServitudeMessage(DebugMsg, "CastConsumeShadow: Status Tests Passed");
			DisplayMessage(ServitudeNotificationMsg.ConsumeShadows..ServitudeNotificationMsg.Primary);
			PetActionQueue["ConsumeShadows"] = true;
			consDelay = GetTime() + 10;
	--		CastPetActionByName(ServitudeLocalization.Magic3);
		elseif (UnitHealth("pet") > UnitHealthMax("pet") * Servitude_Config.VWAutoShadowRatio) then
			PetActionQueue["ConsumeShadows"] = nil;
		end
	end
end

function CheckDevourMagic()
	-- Check if spell is available
	if not IsPetActionAvailable(ServitudeLocalization.Magic5) or UnitHealth("pet") <= 0 then
		return;

	-- In combat
	elseif (UnitAffectingCombat("player") or UnitAffectingCombat("pet")) then
		if (Servitude_Config.FHHungerDevour and FHIsHungry) then
			SearchAndDevourMagic();
		end

	-- Not in combat
	else 
		if Servitude_Config.FHNonCombatDevour then
			SearchAndDevourMagic();
		end
	end
end

function CheckDispelMagic()
	-- Check if spell is available
	if not IsPetActionAvailable(ServitudeLocalization.Magic10) or UnitHealth("pet") <= 0 then
		return;

	-- In combat
	elseif (UnitAffectingCombat("player") or UnitAffectingCombat("pet")) then
		if (Servitude_Config.FHHungerDevour) then
			SearchAndDispelMagic();
		end

	-- Not in combat
	else 
		if Servitude_Config.FHNonCombatDevour then
			SearchAndDispelMagic();
		end
	end
end

function CheckFireShield()
	local DebugMsg = false;
	ServitudeMessage(DebugMsg, "Pre-Check Fire Shield");
	if UnitHealth("pet") > 0 and Pet_Action_List[ServitudeLocalization.Magic7] ~= nil and ((Servitude_Config.ImpSmartFireshield or Servitude_Config.ImpSmartFireshieldSolo or Servitude_Config.ImpSmartFireshieldAlways) and (GetTime() > shieldCheck) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic7].Mana) then
		if GetTime() > alertTime then				
			FireShieldAlerted = false;			
			alertTime = GetTime() + 8;
		end
		ServitudeMessage(DebugMsg, "In-Check Fire Shield");
		shieldIndex = nil;
		reactivateMelee = false;
		meleeEnabled = false;
--		UpdateFireshieldState();
		shieldCheck = GetTime() + 5.0;
		if GetNumPartyMembers() > 0 and (Servitude_Config.ImpSmartFireshield or Servitude_Config.ImpSmartFireshieldAlways) then
			local i;
			for i = 1, GetNumPartyMembers(), 1 do
				local iClass = UnitClass("party" .. i);
				if (ClassHasFireShieldPriority(iClass) or Servitude_Config.ImpSmartFireshieldAlways) then
					if ShouldFireShield("party" .. i) then
--						IgnoreUnit["party"..i] = true;
--						FireshieldTarget("party" .. i);
						if not FireShieldAlerted then
							DisplayMessage(ServitudeNotificationMsg.FireShieldRequired..ServitudeNotificationMsg.Primary);
							if Servitude_Config.ImpFireShieldAlert then
								PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\FireShield.mp3");
							end	
							FireShieldAlerted = true;
						end
					end
				end
			end
			if Servitude_Config.ImpSmartFireshieldAlways or ClassHasFireShieldPriority("Warlock") then
				if ShouldFireShield("player") == true then						
--					FireshieldTarget("player");
					if not FireShieldAlerted then
						DisplayMessage(ServitudeNotificationMsg.FireShieldRequired..ServitudeNotificationMsg.Primary);
						if Servitude_Config.ImpFireShieldAlert then
							PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\FireShield.mp3");
						end	
						FireShieldAlerted = true;
					end
				end
			end
		elseif ((Servitude_Config.ImpSmartFireshieldSolo or Servitude_Config.ImpSmartFireshieldAlways) and GetNumRaidMembers() < 1 and GetNumPartyMembers() < 1 and ShouldFireShield("player") == true) then
		ServitudeMessage(DebugMsg, "Fire Shield: Solo and or always");
--			FireshieldTarget("player");
			if not FireShieldAlerted then
				ServitudeMessage(DebugMsg, "Fire Shield: About to display message");
				DisplayMessage(ServitudeNotificationMsg.FireShieldRequired..ServitudeNotificationMsg.Primary);
				if Servitude_Config.ImpFireShieldAlert then
					PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\FireShield.mp3");
				end
				FireShieldAlerted = true;
			end				
		end
	end		
end

function CheckHealth()
	local debug = false;
	if GetTime() > healthDelay and Servitude_Config.HealthWarning and UnitHealth("pet") > 0 and (UnitHealth("pet") <= UnitHealthMax("pet") * Servitude_Config.HealthWarningRatio) then
		ServitudeMessage(DebugMsg, "CheckHealth: Status Tests Passed");
		DisplayMessage(ServitudeNotificationMsg.HealthLow);
		if Servitude_Config.HealthWarningVocal then
			PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Dying.mp3");
		end	
		healthDelay = GetTime() + 10;
	end
end

-- Cast functions are functions that do a series of checks to make sure it is right time to cast the spell

function CastInvisibility()	
	CastPetActionByName(ServitudeLocalization.Magic1);
end

function CastSacrifice()	
	CastPetActionByName(ServitudeLocalization.Magic4);
-- 1.8 puts the buff on the pet so we don't need to cancel it anymore	
--	FindSoulLink("player");
--	if soulIndex ~= nil then
--		CancelPlayerBuff(soulIndex);
--	end	
end

function CastConsumeShadow()
		CastPetActionByName(ServitudeLocalization.Magic3);
end

function CastDevourMagic()
	-- Check if spell is available
	if not IsPetActionAvailable(ServitudeLocalization.Magic5) then
		return;		
	end
	DevourMagicOnArray();
end

function CastDispelMagic()
	-- Check if spell is available
	if not IsPetActionAvailable(ServitudeLocalization.Magic10) then
		return;
	end
	DispelMagicOnArray();
end

function CastFireShield()
	local DebugMsg = false;
	ServitudeMessage(DebugMsg, "Pre-Cast Fire Shield");
	if ((Servitude_Config.ImpSmartFireshield or Servitude_Config.ImpSmartFireshieldSolo or Servitude_Config.ImpSmartFireshieldAlways) and Pet_Action_List[ServitudeLocalization.Magic7] ~= nil and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic7].Mana) then
		if GetTime() > ignoreTime then
			IgnoreUnit = {};
			ServitudeMessage(DebugMsg, "Cleared Ignore Unit");
			ignoreTime = GetTime() + 5;
		end
		ServitudeMessage(DebugMsg, "Fire Shield: After clearing Ignore unit");
		shieldIndex = nil;
		reactivateMelee = false;
		meleeEnabled = false;
--		UpdateFireshieldState();		
		if GetNumPartyMembers() > 0 and (Servitude_Config.ImpSmartFireshield or Servitude_Config.ImpSmartFireshieldAlways) then
			local i;
			for i = 1, GetNumPartyMembers(), 1 do
				local iClass = UnitClass("party" .. i);
				if (ClassHasFireShieldPriority(iClass) or Servitude_Config.ImpSmartFireshieldAlways) then
					if ((IgnoreUnit["party"..i] ~= true) and ShouldFireShield("party" .. i)) then
						IgnoreUnit["party"..i] = true;
						FireshieldTarget("party" .. i);
						return;
					end
				end
			end
			if Servitude_Config.ImpSmartFireshieldAlways or ClassHasFireShieldPriority("Warlock") then
				if (IgnoreUnit["player"] ~= true) and ShouldFireShield("player") == true then
					IgnoreUnit["player"] = true;
					FireshieldTarget("player");
				end
			end
		elseif ((Servitude_Config.ImpSmartFireshieldSolo or Servitude_Config.ImpSmartFireshieldAlways) and GetNumRaidMembers() < 1 and GetNumPartyMembers() < 1 and (IgnoreUnit["player"] ~= true) and ShouldFireShield("player") == true) then
			ServitudeMessage(DebugMsg, "Fire Shield: About to cast");
			FireshieldTarget("player");
			IgnoreUnit["player"] = true;
		end
	end		
end


function CastSpellLock()
	if UnitCanAttack("target", "player") and UnitCanAttack("player", "target") then
		CastPetActionByName(ServitudeLocalization.Magic9);
	end	
end

function CastSeduction(STarget)
	local DebugMsg = false;
	if sedTarget ~= nil and string.len(sedTarget) > 0 and UnitName("pettarget") == sedTarget then
		reactivateMelee = false;
		StoreCurrentTarget();
		if PlayerFrame.inCombat then
			ServitudeMessage(DebugMsg, "Player is in Melee combat");
			reactivateMelee = true;
		end		
		ClearTarget();
		CastPetActionByName(ServitudeLocalization.Magic8);
		RetrieveStoredTarget();
		if reactivateMelee == true then
			AttackTarget();
			ServitudeMessage(DebugMsg, "Attempting to attack again");
		end
	else
		if UnitExists("target") then			
			sedTarget = UnitName("target");
			ServitudeMessage(DebugMsg, "Unit name is "..UnitName("target"));
			if Servitude_Config.ScbSeduceCOS and ServCOS ~= nil then				
				if not HasDebuff("target", ServitudeLocalization.Magic15) then
					ServitudeMessage(DebugMsg, "Attempting to CoS via CastSpell");
					CastSpell(ServCOS, SpellBookFrame.bookType);					
				end
			elseif Servitude_Config.ScbSeduceCOE and ServCOE ~= nil then
				if not HasDebuff("target", ServitudeLocalization.Magic16) then
					ServitudeMessage(DebugMsg, "Attempting to CoE via CastSpell");
					CastSpell(ServCOE, SpellBookFrame.bookType);					
				end
			end	
			if Servitude_Config.ScbSeduceAnnounceRaid and GetNumRaidMembers() > 0 then
				if UnitIsEnemy("target","player") then
					SendChatMessage(UnitName("target")..ServitudeChatMsg.SeductionMessage, "RAID");
				end	
			elseif Servitude_Config.ScbSeduceAnnounce and GetNumPartyMembers() > 0 then
				if UnitIsEnemy("target","player") then
					SendChatMessage(UnitName("target")..ServitudeChatMsg.SeductionMessage, "PARTY");
				end	
			end
--			sedHealth = UnitHealth("target");
--			keepSeduced = true;
			PetFollow();
			CastPetActionByName(ServitudeLocalization.Magic8);
			PetAttack();
--			sedCheck = GetTime() + 2.25;
		end
	end	
end	

function SearchAndDevourMagic()
	meleeEnabled = false;
	reactivateMelee = false;
	if GetTime() > ignoreTime then
		Unit_Priority = {};
		DevourAlerted = false;
		IgnoreUnit = {};
		ignoreTime = GetTime() + 5;
		PetActionQueue["DevourMagic"] = nil;
	end
	if PriorityUnitID ~= nil and PriorityUnitName ~= nil and UnitName(PriorityUnitID) ~= nil then		
		if string.lower(UnitName(PriorityUnitID)) == string.lower(PriorityUnitName) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic5].Mana then
			if (IgnoreUnit[PriorityUnitID] ~= true) and UnitIsVisible(PriorityUnitID) and HasDevourableDebuff(PriorityUnitID) then
				IgnoreUnit[PriorityUnitID] = true;
--				if Servitude_Config.FHClassAsPriority then					
					Unit_Priority[PriorityUnitID] = 1;
					if not DevourAlerted then
						DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
						PetActionQueue["DevourMagic"] = true;
						if Servitude_Config.FHDevourAlert then
							PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
						end
						DevourAlerted = true;
						ignoreTime = GetTime() + 5;
					end
--				else	
--					DevourMagicOnTarget(PriorityUnitID);
--				end					
			end	
		else
			ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit must be in your party or raid. Unit name does not match stored unit's name. Please set a new Priority Unit.");
			PriorityUnitID = nil;
			PriorityUnitName = nil;
		end
		if Servitude_Config.FHPriorityUnitOnly then
--			if Servitude_Config.FHClassAsPriority then
--				DevourMagicOnArray();
				return;
--			else	
--				return;
--			end
		end
	end
	if IgnoreUnit["pet"] ~= true and Servitude_Config.FHDevourSelf and (not Servitude_Config.FHDevourIgnoreSelf) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic5].Mana then
		if HasDevourableDebuff("pet") then
--			if Servitude_Config.FHClassAsPriority then
				IgnoreUnit["pet"] = true;
				Unit_Priority["pet"] = 1;
				if not DevourAlerted then
					DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
					PetActionQueue["DevourMagic"] = true;
					if Servitude_Config.FHDevourAlert then
						PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
					end					
					DevourAlerted = true;
					ignoreTime = GetTime() + 5;
				end
--			else
--				DevourMagicOnTarget("pet");
--				return;				
--			end	
		end
	end	
	if IgnoreUnit["player"] ~= true and HasDevourableDebuff("player") and (HasBuff("player", ServitudeLocalization.Buff11) or Pet_Action_List[ServitudeLocalization.Buff11]==nil) and ClassHasDevourPriority(UnitClass("player")) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic5].Mana then
		IgnoreUnit["player"] = true;
--		if Servitude_Config.FHClassAsPriority then	
			Unit_Priority["player"] = 1;
			if not DevourAlerted then
				DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
				PetActionQueue["DevourMagic"] = true;
				if Servitude_Config.FHDevourAlert then
					PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
				end				
				DevourAlerted = true;
				ignoreTime = GetTime() + 5;
			end			
--		else	
--			DevourMagicOnTarget("player");
--		end	
	end
	if Servitude_Config.FHPartyDevour and GetNumPartyMembers() > 0 and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic5].Mana then
		if GetTime() > partyCheck then
			local i;				
			partyCheck = GetTime() + 1.00;
			for i = 1, GetNumPartyMembers(), 1 do					
				if (IgnoreUnit["party"..i] ~= true) and UnitIsVisible("party" .. i) and (HasBuff("party" .. i, ServitudeLocalization.Buff11) or Pet_Action_List[ServitudeLocalization.Buff11]==nil) and ClassHasDevourPriority(UnitClass("party" .. i)) then
					if HasDevourableDebuff("party" .. i) then
						IgnoreUnit["party"..i] = true;
						if Servitude_Config.FHClassAsPriority then							
							Unit_Priority["party" .. i] = Class_Priority[UnitClass("party"..i)];
						else
							Unit_Priority["party"..i] = 1;
--							DevourMagicOnTarget("party" .. i);
						end
						if not DevourAlerted then
							DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
							PetActionQueue["DevourMagic"] = true;
							if Servitude_Config.FHDevourAlert then
								PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
							end							
							DevourAlerted = true;
							ignoreTime = GetTime() + 5;
						end						
					end
				end
			end
			if (Servitude_Config.FHDevourPets) then
				local i;
				for i = 1,GetNumPartyMembers(),1 do
					if UnitExists("partypet"..i) and (IgnoreUnit["partypet"..i] ~= true) and UnitIsVisible("partypet" .. i) and (HasBuff("partypet" .. i, ServitudeLocalization.Buff11) or Pet_Action_List[ServitudeLocalization.Buff11]==nil) then
						if HasDevourableDebuff("partypet" .. i) then
							IgnoreUnit["partypet"..i] = true;
							if Servitude_Config.FHClassAsPriority then
								Unit_Priority["partypet" .. i] = 10;
							else
								Unit_Priority["partypet" .. i] = 3;
--								DevourMagicOnTarget("partypet" .. i);
							end
							if not DevourAlerted then
								DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
								PetActionQueue["DevourMagic"] = true;
								if Servitude_Config.FHDevourAlert then
									PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
								end								
								DevourAlerted = true;
								ignoreTime = GetTime() + 5;
							end													
						end					
					end					
				end
			end
		end	
	end	
	if Servitude_Config.FHRaidDevour and GetNumRaidMembers() > 0 and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic5].Mana then
		if GetTime() > raidCheck then
			local i;
			raidCheck = GetTime() + 1.00;
			for i = 1, GetNumRaidMembers(), 1 do				
				if (IgnoreUnit["raid"..i] ~= true) and UnitIsVisible("raid" .. i) and HasDevourableDebuff("raid" .. i) and ClassHasDevourPriority(UnitClass("raid" .. i)) then
					IgnoreUnit["raid"..i] = true;
					if Servitude_Config.FHClassAsPriority then						
						Unit_Priority["raid" .. i] = Class_Priority[UnitClass("raid"..i)];
					else
						Unit_Priority["raid" .. i] = 2;
--						DevourMagicOnTarget("raid" .. i);
					end
					if not DevourAlerted then
						DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
						PetActionQueue["DevourMagic"] = true;
						if Servitude_Config.FHDevourAlert then
							PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
						end						
						DevourAlerted = true;
						ignoreTime = GetTime() + 5;
					end
				end
			end
			if (Servitude_Config.FHDevourPets) then
				local i;
				for i = 1,GetNumRaidMembers(),1 do				
					if UnitExists("raidpet"..i) and (IgnoreUnit["raidpet"..i] ~= true) and UnitIsVisible("raidpet" .. i) then
						if HasDevourableDebuff("raidpet" .. i) then
							IgnoreUnit["raidpet"..i] = true;
							if Servitude_Config.FHClassAsPriority then
								Unit_Priority["raidpet" .. i] = 10;
							else
								Unit_Priority["raidpet" .. i] = 4;
--								DevourMagicOnTarget("raidpet" .. i);
							end
							if not DevourAlerted then
								DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
								PetActionQueue["DevourMagic"] = true;
								if Servitude_Config.FHDevourAlert then
									PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
								end								
								DevourAlerted = true;
								ignoreTime = GetTime() + 5;
							end
						end					
					end					
				end
			end
		end
	end	
	if IgnoreUnit["pet"] ~= true and (not Servitude_Config.FHDevourSelf) and (not Servitude_Config.FHDevourIgnoreSelf) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic5].Mana then
		if HasDevourableDebuff("pet") then
			IgnoreUnit["pet"] = true;
			if Servitude_Config.FHClassAsPriority then
				Unit_Priority["pet"] = 10;
			else
				Unit_Priority["pet"] = 2;
--				DevourMagicOnTarget("pet");
			end
			if not DevourAlerted then
				DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
				PetActionQueue["DevourMagic"] = true;
				if Servitude_Config.FHDevourAlert then
					PlaySoundFile("Interface\\AddOns\\Servitude\\Sounds\\Debuffed.mp3");
				end				
				DevourAlerted = true;
				ignoreTime = GetTime() + 5;
			end			
		end
	end
--	if Servitude_Config.FHClassAsPriority then
--		DevourMagicOnArray();
--	end	
end	

function SearchAndDispelMagic()
	meleeEnabled = false;
	reactivateMelee = false;		
	if GetTime() > ignoreTime then
		Unit_Priority = {};
		DispelAlerted = false;
		IgnoreUnit = {};
		ignoreTime = GetTime() + 5;
		PetActionQueue["DispelMagic"] = nil;
	end
	if PriorityUnitID ~= nil and PriorityUnitName ~= nil and UnitName(PriorityUnitID) ~= nil then
		if string.lower(UnitName(PriorityUnitID)) == string.lower(PriorityUnitName) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic10].Mana then
			if (IgnoreUnit[PriorityUnitID] ~= true) and UnitIsVisible(PriorityUnitID) and HasDevourableDebuff(PriorityUnitID) then
				IgnoreUnit[PriorityUnitID] = true;
--				if Servitude_Config.FHClassAsPriority then					
					Unit_Priority[PriorityUnitID] = 1;
					if not DispelAlerted then
						DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
						PetActionQueue["DispelMagic"] = true;
						DispelAlerted = true;
						ignoreTime = GetTime() + 5;
					end
--				else	
--					DispelMagicOnTarget(PriorityUnitID);
--				end					
			end	
		else
			ServitudeMessage(ErrorMsg, "Auto-Devour Priority Unit must be in your party or raid. Unit name does not match stored unit's name. Please set a new Priority Unit.");
			PriorityUnitID = nil;
			PriorityUnitName = nil;
		end
		if Servitude_Config.FHPriorityUnitOnly then
--			if Servitude_Config.FHClassAsPriority then
--				DispelMagicOnArray();
				return;
--			else	
--				return;
--			end
		end
	end	
	if IgnoreUnit["pet"] ~= true and (Servitude_Config.FHDevourSelf) and (not Servitude_Config.FHDevourIgnoreSelf) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic10].Mana then
		if HasDevourableDebuff("pet") then
--			if Servitude_Config.FHClassAsPriority then
				IgnoreUnit["pet"] = true;
				Unit_Priority["pet"] = 1;
				if not DispelAlerted then
					DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
					PetActionQueue["DispelMagic"] = true;
					DispelAlerted = true;
					ignoreTime = GetTime() + 5;
				end
--			else	
--				DispelMagicOnTarget("pet");
--				return;
--			end	
		end
	end	
	if IgnoreUnit["player"] ~= true and HasDevourableDebuff("player") and ClassHasDevourPriority(UnitClass("player")) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic10].Mana then
		IgnoreUnit["player"] = true;
--		if Servitude_Config.FHClassAsPriority then
			Unit_Priority["player"] = 1;
			if not DispelAlerted then
				DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
				PetActionQueue["DispelMagic"] = true;
				DispelAlerted = true;
				ignoreTime = GetTime() + 5;
			end
--		else	
--			DispelMagicOnTarget("player");
--		end	
	end	
	if Servitude_Config.FHPartyDevour and GetNumPartyMembers() > 0 and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic10].Mana then
		if GetTime() > partyCheck then
			local i;				
			partyCheck = GetTime() + 1.00;
			for i = 1, GetNumPartyMembers(), 1 do					
				if (IgnoreUnit["party"..i] ~= true) and UnitIsVisible("party" .. i) and HasDevourableDebuff("party" .. i) and ClassHasDevourPriority(UnitClass("party" .. i)) then
					IgnoreUnit["party"..i] = true;
					if Servitude_Config.FHClassAsPriority then						
						Unit_Priority["party" .. i] = Class_Priority[UnitClass("party"..i)];
					else
						Unit_Priority["party" .. i] = 1;
--						DispelMagicOnTarget("party" .. i);
					end	
					if not DispelAlerted then
						DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
						PetActionQueue["DispelMagic"] = true;
						DispelAlerted = true;
						ignoreTime = GetTime() + 5;
					end
				end
			end
			if (Servitude_Config.FHDevourPets) then
				local i;
				for i = 1, GetNumPartyMembers(), 1 do				
					if UnitExists("partypet"..i) and (IgnoreUnit["partypet"..i] ~= true) and UnitIsVisible("partypet" .. i) then
						if HasDevourableDebuff("partypet" .. i) then
							IgnoreUnit["partypet"..i] = true;
							if Servitude_Config.FHClassAsPriority then
								Unit_Priority["partypet" .. i] = 10;
							else
								Unit_Priority["partypet" .. i] = 3;
--								DispelMagicOnTarget("partypet" .. i);
							end
							if not DispelAlerted then
								DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
								PetActionQueue["DispelMagic"] = true;
								DispelAlerted = true;
								ignoreTime = GetTime() + 5;
							end
						end					
					end					
				end
			end			
		end	
	end	
	if Servitude_Config.FHRaidDevour and GetNumRaidMembers() > 0 and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic10].Mana then
		if GetTime() > raidCheck then
			local i;
			raidCheck = GetTime() + 1.00;
			for i = 1, GetNumRaidMembers(), 1 do
				if (IgnoreUnit["raid"..i] ~= true) and UnitIsVisible("raid" .. i) and HasDevourableDebuff("raid" .. i) and ClassHasDevourPriority(UnitClass("raid" .. i)) then
					IgnoreUnit["raid"..i] = true;
					if Servitude_Config.FHClassAsPriority then						
						Unit_Priority["raid" .. i] = Class_Priority[UnitClass("raid"..i)];
					else
						Unit_Priority["raid" .. i] = 2;
--						DispelMagicOnTarget("raid" .. i);
					end
					if not DispelAlerted then
						DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
						PetActionQueue["DispelMagic"] = true;
						DispelAlerted = true;
						ignoreTime = GetTime() + 5;
					end
				end
			end
			if (Servitude_Config.FHDevourPets) then
				local i;
				for i = 1, GetNumRaidMembers(), 1 do			
					if UnitExists("raidpet"..i) and (IgnoreUnit["raidpet"..i] ~= true) and UnitIsVisible("raidpet" .. i) then
						if HasDevourableDebuff("raidpet" .. i) then
							IgnoreUnit["raidpet"..i] = true;
							if Servitude_Config.FHClassAsPriority then
								Unit_Priority["raidpet" .. i] = 10;
							else
								Unit_Priority["raidpet" .. i] = 4;
--								DispelMagicOnTarget("raidpet" .. i);
							end
							if not DispelAlerted then
								DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
								PetActionQueue["DispelMagic"] = true;
								DispelAlerted = true;
								ignoreTime = GetTime() + 5;
							end
						end					
					end					
				end
			end						
		end
	end	
	if (not Servitude_Config.FHDevourSelf) and (not Servitude_Config.FHDevourIgnoreSelf) and UnitMana("pet") > Pet_Mana_Cost[ServitudeLocalization.Magic10].Mana then
		if HasDevourableDebuff("pet") then
			if Servitude_Config.FHClassAsPriority then
				Unit_Priority["pet"] = 10;
			else
				Unit_Priority["pet"] = 2;
--				DispelMagicOnTarget("pet");
			end
			if not DispelAlerted then
				DisplayMessage(ServitudeNotificationMsg.DebuffsDetected..ServitudeNotificationMsg.Primary);
				PetActionQueue["DispelMagic"] = true;
				DispelAlerted = true;
				ignoreTime = GetTime() + 5;
			end			
		end
	end
--	if Servitude_Config.FHClassAsPriority then
--		DispelMagicOnArray();
--	end	
end

function DataMineDevourableDebuff()
	StoreDevourableDebuff("target");
	StoreDevourableDebuff("player");
	StoreDevourableDebuff("pet");
end

-- DataMine Debuffs
function StoreDevourableDebuff(target)
	local i = 1;
--	Servitude_MoneyToggle();
	while UnitDebuff(target, i) do		
		ServitudeTooltipTextLeft1:SetText(nil);
		ServitudeTooltipTextRight1:SetText(nil);
		ServitudeTooltipTextLeft2:SetText(nil);		
		ServitudeTooltip:SetUnitDebuff(target, i);		
		local DebuffName = ServitudeTooltipTextLeft1:GetText();
		local DebuffType = ServitudeTooltipTextRight1:GetText();
		if (DebuffType == ServitudeLocalization.Bufftype) then
			local DebuffDesc = ServitudeTooltipTextLeft2:GetText();
			if DebuffDesc == nil then
				DebuffDesc = ServitudeLocalization.NoDesc;
			end
			if (not Magical_Debuff_List[DebuffName]) then
				Magical_Debuff_List[DebuffName] = DebuffDesc;

				local DebuffNumber = table.getn(Devour_Order) + 1;
				Devour_Order[DebuffNumber] = DebuffName;
				if not Servitude_Config.FHDisableNotification then
					ServitudeMessage(ErrorMsg, ServitudeChatMsg.NewDebuffObserved, DebuffName );
				end	
			else
				Magical_Debuff_List[DebuffName] = DebuffDesc;
			end
		end
		i = i + 1;
	end
--	Servitude_MoneyToggle();
end

--function DebuffHasCombatPriority(name)
--		local DebuffName = name;
--		local i = 1;
--		while Devour_Order[i] ~= InCombatDivider do
--			if Devour_Order[i] == DebuffName then
--				return true;
--			end
--			i = i + 1;
--		end
--		return false;
--end

function DebuffHasCombatPriority(name)
	local DebuffName = name;
	if Devour_Priority[DebuffName] == true then
		return true;
	else
		return false;
	end
end

--function ClassHasDevourPriority(name)
--		local ClassName = name;
--		local i = 1;
--		while Class_Order[i] ~= ClassDivider do
--			if Class_Order[i] == ClassName then
--				return true;
--			end
--			i = i + 1;
--		end
--		return false;
--end

function ClassHasFireShieldPriority(name)
	local ClassName = name;
	if FireShieldClass_Priority[ClassName] == true then
		return true;
	else
		return false;
	end
end

function ClassHasDevourPriority(name)
	local ClassName = name;
	if Class_Priority[ClassName] ~= nil then
		return true;
	else
		return false;
	end
end

--function SpellHasLockRequested(name)
--		local spelllockname = name;
--		local i = 1;
--		while Spell_Lock_Order[i] ~= SpellLockDivider do
--			if Spell_Lock_Order[i] == spelllockname then
--				return true;
--			end
--			i = i + 1;
--		end
--		return false;
--end

function SpellHasLockRequested(name)
	local SpellName = name;
	if Spell_Priority[SpellName] == true then
		return true;
	else
		return false;
	end
end

-- search for magic debuff on unit
function HasDevourableDebuff(target)
	local i = 1;
--	Servitude_MoneyToggle();
	while UnitDebuff(target, i) do
		ServitudeTooltipTextRight1:SetText(nil);
		ServitudeTooltipTextLeft1:SetText(nil);
		ServitudeTooltip:SetUnitDebuff(target, i);
		local DebuffType = ServitudeTooltipTextRight1:GetText();
		local DebuffName = ServitudeTooltipTextLeft1:GetText();
		if (DebuffType == ServitudeLocalization.Bufftype and (DebuffName ~= ServitudeLocalization.Buff4 or Servitude_Config.FHDevourMindVision) and DebuffName ~= ServitudeLocalization.Buff5 and (DebuffName ~= ServitudeLocalization.Buff12 or (UnitCanAttack("player", target) or UnitIsUnit("player",target)))) then
			if UnitAffectingCombat("player") or UnitAffectingCombat("pet") then
				if DebuffHasCombatPriority(DebuffName) then
--					Servitude_MoneyToggle();
					return DebuffName;
				end
			else
--				Servitude_MoneyToggle();
				return DebuffName;
			end
		end
		i = i + 1;
	end
--	Servitude_MoneyToggle();
	return nil;
end

-- Targets the unit and cast devour magic
function DevourMagicOnTarget (target)
		StoreCurrentTarget();
		if PlayerFrame.inCombat then
			meleeEnabled = true;
		end
		TargetUnit(target);
		if UnitIsFriend("target", "player") and meleeEnabled then
			reactivateMelee = true;
		end	
		CastPetActionByName(ServitudeLocalization.Magic5);
		RetrieveStoredTarget();
		if reactivateMelee == true then
			AttackTarget();
		end
end

function DevourMagicOnArray()
	for unit, priority in Unit_Priority do
		if priority == 1 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 2 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 3 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 4 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	if not Servitude_Config.FHClassAsPriority then
		return;
	end		
	for unit, priority in Unit_Priority do
		if priority == 5 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 6 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 7 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 8 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 9 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 10 then
			if HasDevourableDebuff(unit) then
				DevourMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
end

function DispelMagicOnTarget (target)
		StoreCurrentTarget();
		if PlayerFrame.inCombat then
			meleeEnabled = true;
		end
		TargetUnit(target);
		if UnitIsFriend("target", "player") and meleeEnabled then
			reactivateMelee = true;
		end	
		CastPetActionByName(ServitudeLocalization.Magic10);
		RetrieveStoredTarget();
		if reactivateMelee == true then
			AttackTarget();
		end
end

function DispelMagicOnArray()
	for unit, priority in Unit_Priority do
		if priority == 1 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 2 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 3 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 4 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	if not Servitude_Config.FHClassAsPriority then
		return;
	end	
	for unit, priority in Unit_Priority do
		if priority == 5 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 6 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 7 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 8 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 9 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
	for unit, priority in Unit_Priority do
		if priority == 10 then
			if HasDevourableDebuff(unit) then
				DispelMagicOnTarget(unit);
				Unit_Priority[unit] = nil;
			end
		end
	end
end	

function FireshieldTarget(Ftarget)		
		StoreCurrentTarget();
		if PlayerFrame.inCombat then
			meleeEnabled = true;
		end
		local tname = UnitName(Ftarget);
		TargetByName(tname);
		if (tname == UnitName("target")) then
			if UnitIsFriend("target", "player") and meleeEnabled then
				reactivateMelee = true;
			end
			CastPetActionByName(ServitudeLocalization.Magic7);
			RetrieveStoredTarget();
			if reactivateMelee == true then
				AttackTarget();
			end			
		else return;
		end				
end

-- Tries to do a better job than the give API target function
function StoreCurrentTarget()
	if not UnitExists("target") then
		targetVar.type = "empty";
	elseif UnitIsEnemy("target", "player") and UnitIsPlayer("target") then
		targetVar.type = "pcenemy";
		targetVar.name = UnitName("target");
	elseif UnitIsEnemy("target", "player") then
		targetVar.type = "enemy";
	elseif UnitIsPlayer("target") then
		targetVar.type = "player";
		targetVar.name = UnitName("target");
	else
		targetVar.type = "other";
		targetVar.name = UnitName("target");
	end
end

function RetrieveStoredTarget()
	if targetVar.type == "empty" then
		ClearTarget();
	elseif targetVar.type == "pcenemy" then
		TargetByName(targetVar.name);
	elseif targetVar.type == "enemy" then
		TargetLastEnemy();
	else
		TargetByName(targetVar.name);
	end
end

function IsPlayerMounted()
	return isUnitBuffUp("player","Mount") or isUnitBuffUp("player",ServitudeLocalization.Buff2);
end

function IsPetActionAvailable(inputname)
	if Pet_Action_List[inputname] ~= nil then
		local startTime, duration, enabled = GetPetActionCooldown(Pet_Action_List[inputname]);
		if startTime == 0 and duration == 0 and enabled ~= 0 then
			return true;
		else
			return false;
		end			
	else	
		local i;
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if (name == inputname) then
				local startTime, duration, enabled = GetPetActionCooldown(i);
				if startTime == 0 and duration == 0 and enabled ~= 0 then
					return true;
				else
					return false;
				end
			end
		end
	end	
end

function CastPetActionByName (inputname)
--	if IsPlayerMounted() or (not GetPetActionsUsable()) then
--	if (not GetPetActionsUsable()) then
--		return;
--	end	
	if Pet_Action_List[inputname] ~= nil then
		local startTime, duration, enabled = GetPetActionCooldown(Pet_Action_List[inputname]);
		if startTime == 0 and duration == 0 and enabled ~= 0 then			
			CastPetAction(Pet_Action_List[inputname]);
		end			
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end			
			if (name == inputname) then
				local startTime, duration, enabled = GetPetActionCooldown(i);
				if startTime == 0 and duration == 0 and enabled ~= 0 then					
					CastPetAction(i);
				end
			end
		end
	end	
end

function Build_ManaCosts()
-- borrowing some code from Necrosis to determine mana costs
	Pet_Mana_Cost = {};
	for ID=1, 12, 1 do
--		Servitude_MoneyToggle();		
		ServitudeTooltipTextLeft1:SetText(nil);
		ServitudeTooltipTextLeft2:SetText(nil);
		ServitudeTooltip:SetSpell(ID, "pet");
--		Servitude_MoneyToggle();
		local spellName = ServitudeTooltipTextLeft1:GetText();
		if (spellName) then
			-- Set loaded here to ensure it has loaded
			if (not SpellsLoaded) then
				SpellsLoaded = true;				
			end
			local spellMana = strlower(tostring(ServitudeTooltipTextLeft2:GetText()));
			local sMana = strlower(MANA);
-- French displays mana costs differently, example: Mana: 115. Not sure about German yet.	
			if GetLocale() == "frFR" then
				if (string.find(spellMana, sMana)) then
					spellMana = tonumber(strsub(spellMana, 7));
				else
					spellMana = 0;
				end				
			else
				if (string.find(spellMana, sMana)) then
					spellMana = tonumber(strsub(spellMana, 1, strlen(spellMana)-5));
				else
					spellMana = 0;
				end				
			end
			Pet_Mana_Cost[spellName] = {Name = spellName,Mana = spellMana};
		end	
	end
end

function Build_Pet_Action_List()
	local i;
	Pet_Action_List = {};
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
		if name ~= nil then
			Pet_Action_List[name] = i;
		end			
	end
end

--Loops through active buffs looking for a string match
--Origin Zorlen's hunter functions
function isUnitBuffUp(sUnitname, sBuffname)
	local DebugMsg = false;
  local iIterator = 1;
  while (UnitBuff(sUnitname, iIterator)) do
   	ServitudeMessage(DebugMsg, UnitBuff(sUnitname, iIterator));
    if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then
      return true;
    end
    iIterator = iIterator + 1;
  end
  return false;
end

--function FindSoulLink(sUnitname)
--  local DebugMsg = false;
--  local iIterator = 1;
--  soulIndex = nil;
--  Servitude_MoneyToggle();
--  while (UnitBuff(sUnitname, iIterator)) do	
--   	ServitudeMessage(DebugMsg, UnitBuff(sUnitname, iIterator));
--	ServitudeTooltipTextLeft1:SetText(nil);
--	ServitudeTooltip:SetUnitBuff(sUnitname, iIterator);
--	local BuffName = ServitudeTooltipTextLeft1:GetText();	
--    if BuffName == ServitudeLocalization.Buff8 then
--      soulIndex = iIterator;
--	  Servitude_MoneyToggle();
--	  return;
--    end
--    iIterator = iIterator + 1;
--  end
--  Servitude_MoneyToggle();
--end

function HasBuff(sUnitname, sBuffname)
	local DebugMsg = false;
	local iIterator = 1;
--	Servitude_MoneyToggle();
	while (UnitBuff(sUnitname, iIterator)) do	
		ServitudeMessage(DebugMsg, UnitBuff(sUnitname, iIterator));
		ServitudeTooltipTextLeft1:SetText(nil);
		ServitudeTooltip:SetUnitBuff(sUnitname, iIterator);
		local BuffName = ServitudeTooltipTextLeft1:GetText();	
		if BuffName == sBuffname then
--			Servitude_MoneyToggle();
			return true;
		end
		iIterator = iIterator + 1;
	end
--	Servitude_MoneyToggle();
	return false;
end

function HasDebuff(sUnitname, sDebuffname)
	local i = 1;
--	Servitude_MoneyToggle();
	while UnitDebuff(sUnitname, i) do
		ServitudeTooltipTextLeft1:SetText(nil);
		ServitudeTooltip:SetUnitDebuff(sUnitname, i);
		local DebuffName = ServitudeTooltipTextLeft1:GetText();
		if DebuffName == sDebuffname then			
			return true;			
		end
		i = i + 1;
	end
--	Servitude_MoneyToggle();
	return false;
end

-- Borrowed function from BuffBot (thanks Gaff)

function DisplayMessage(msg,ServSpell)
	local DebugMsg = false;	
--[[	
	if color == 'green' then r = 0; b = 0 end
	if color == 'blue' then r = 0; g = 0 end
	if color == 'red' then g = 0; b = 0;r = 0.8 end
	if color == 'purple' then g = 0 end
	if color == 'black' then r = 0; g = 0; b = 0 end
]]--
	if not ServitudeNormalFrame then return end
	ServitudeMessage(DebugMsg, "About to try to add message to Alert Frame");
	if ServSpell ~= nil then
		ServitudeNormalFrame:AddMessage(ServSpell.." :  "..msg, Servitude_RED, Servitude_GREEN, Servitude_BLUE, Servitude_ALPHA, UIERRORS_HOLD_TIME);
	else
		ServitudeNormalFrame:AddMessage(msg, Servitude_RED, Servitude_GREEN, Servitude_BLUE, Servitude_ALPHA, UIERRORS_HOLD_TIME);
	end	
end

--[[
function DisplayMessage(msg, color)

--	if _silent then return end

	-- defaults to white
	local r = 1
	local g = 1
	local b = 1
	
	if color == 'green' then r = 0; b = 0 end
	if color == 'blue' then r = 0; g = 0 end
	if color == 'red' then g = 0; b = 0;r = 0.8 end
	if color == 'purple' then g = 0 end
	if color == 'black' then r = 0; g = 0; b = 0 end
	
	if not UIErrorsFrame then return end

	UIErrorsFrame:AddMessage(msg, r, g, b, 1.0, UIERRORS_HOLD_TIME)
	
end
]]--

function ShouldFireShield(sUnitname)
	local DebugMsg = false;
	local sLevel = UnitLevel(sUnitname);
	local servLevel = UnitLevel("player");
	ServitudeMessage(DebugMsg, "Pre-Pet_Action_List check");
	if (UnitAffectingCombat(sUnitname) == UnitAffectingCombat("player") and Pet_Action_List[ServitudeLocalization.Magic7] ~= nil and UnitIsVisible(sUnitname) and (sLevel + 10 >= servLevel)) then
		ServitudeMessage(DebugMsg, "Post-Pet_Action_List check");
		local fireshieldZone = GetMinimapZoneText();
		local fireshieldNeutral = false;
		local DebugMsg = false;
		local iIterator = 1;
		local shieldActive = false;
		local thornsActive = false;
		local bloodpactActive = false;
		local retributionActive = false;
		if (Servitude_Config.ImpSmartFireshieldNeutral == true) and (fireshieldZone == "Booty Bay" or fireshieldZone == "Everlook" or fireshieldZone == "Ratchet" or fireshieldZone == "The Salty Sailor Tavern" or fireshieldZone == "Gadgetzan") then
			fireshieldNeutral = true;
		end
		if (fireshieldNeutral == true and sUnitname ~= "player") then
			return false;
		end	
--		Servitude_MoneyToggle();
		while (UnitBuff(sUnitname, iIterator)) do			
			ServitudeMessage(DebugMsg, UnitBuff(sUnitname, iIterator));
			ServitudeTooltipTextLeft1:SetText(nil);
			ServitudeTooltip:SetUnitBuff(sUnitname, iIterator);	
			local BuffName = ServitudeTooltipTextLeft1:GetText();	
			if BuffName == ServitudeLocalization.Buff6 then
				shieldActive = true;
				shieldIndex = iIterator;
			elseif BuffName == ServitudeLocalization.Buff7 then
				thornsActive = true;
			elseif BuffName == ServitudeLocalization.Buff9 then
				bloodpactActive = true;
			elseif BuffName == ServitudeLocalization.Buff10	then
				retributionActive = true;
			end
			iIterator = iIterator + 1;
		end
--		Servitude_MoneyToggle();
		if fireshieldNeutral == true then
			if (sUnitname == "player" and shieldActive == true) then			
				CancelPlayerBuff(shieldIndex);
			end
			return false;
		end	
		if bloodpactActive == true then
			if (not thornsActive) and (not shieldActive) and (not retributionActive) then
				return true;
			else
				return false;
			end	
		else
			return false;
		end
	else
		return false;
	end
end

--[[
function CheckLOPState()
	local DebugMsg = false;
	if Pet_Action_List[ServitudeLocalization.Magic11] ~= nil then		
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(Pet_Action_List[ServitudeLocalization.Magic11]);
		MyLOPState = true;
		if  (not autoCastEnabled) == MyLOPState then				
			return false;
		else
			return true;
		end
	else
		local i;
		Pet_Action_List = {};
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
			if name ~= nil then
				Pet_Action_List[name] = i;
			end
			MyLOPState = true;
			if (name == ServitudeLocalization.Magic11) then			
				if (not autoCastEnabled) == MyLOPState then
					return false;
				else
					return true;
				end
			end
		end
	end	
end
]]--
function ServitudeAlert_Test()
	DisplayMessage(ServitudeNotificationMsg.ServitudeAlertTest);
end

function Servitude_ChooseColor()
	ColorPickerFrame.func = Servitude_SetColor;
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacityFunc = Servitude_SetOpacity;
	ColorPickerFrame.opacity = 1.0 - Servitude_ALPHA;
	ColorPickerFrame:SetColorRGB(Servitude_RED, Servitude_GREEN, Servitude_BLUE);
	ColorPickerFrame.previousValues = {r = Servitude_RED, g = Servitude_GREEN, b = Servitude_BLUE, opacity = (1.0 - Servitude_ALPHA)};
	ColorPickerFrame.cancelFunc = Servitude_CancelColor;
	ShowUIPanel(ColorPickerFrame);
end

-- this is the values as they are set
function Servitude_SetColor()
	Servitude_RED, Servitude_GREEN, Servitude_BLUE = ColorPickerFrame:GetColorRGB();
end

-- this si the opacity as they are set
function Servitude_SetOpacity()
	Servitude_ALPHA = 1.0 - OpacitySliderFrame:GetValue();
end

-- they changed thier minds
function Servitude_CancelColor()
	Servitude_RED   = ColorPickerFrame.previousValues.r;
	Servitude_GREEN = ColorPickerFrame.previousValues.g;
	Servitude_BLUE  = ColorPickerFrame.previousValues.b;
	Servitude_ALPHA = 1.0 - ColorPickerFrame.previousValues.opacity;
end

function StoreCOS()
	local id;
	for id = 1, 180, 1 do
		local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
		if spellName and string.find(spellName, ServitudeLocalization.Magic15, 1, true) then
			ServCOS = id;
		end
	end
end

function StoreCOE()
	local id;
	for id = 1, 180, 1 do
		local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
		if spellName and string.find(spellName, ServitudeLocalization.Magic16, 1, true) then
			ServCOE = id;
		end
	end
end

-- Pet Action buttons

function CastPrimaryPetAction()
	local DebugMsg = false;
	if Servitude_Config.OneButton then
		CastPetActionQueue();
	else
		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
			CastInvisibility();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet2) then
			if UnitAffectingCombat("pet") then
				CastPetActionByName(ServitudeLocalization.Magic14);
			else	
				CastConsumeShadow();
			end	
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet4) then
			CastDevourMagic();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet5) then
			CastDispelMagic();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet1) then
			CastFireShield();
			ServitudeMessage(DebugMsg, "Attempted to CastFireShield");
		end
	end	
end

function CastSecondaryPetAction()
	if Servitude_Config.OneButton then
-- By request, moved to Primary button in 1 button mode.	
--		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
--			CastSeduction();
--		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet4) then
		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet4) then
			CastPetActionByName(ServitudeLocalization.Magic5);
		end	
	else
		if (UnitCreatureFamily("pet") == ServitudeLocalization.Pet3) then
			CastSeduction();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet2) then
			CastSacrifice();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet4) then
			CastSpellLock();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet5) then
	--		CastDispelMagic();
		elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet1) then
	--		CastFireShield();
		end
	end	
end

function CastPetActionQueue()
	if PetActionQueue["SpellLock"] ~= nil then
		PetActionQueue["SpellLock"] = nil;
		CastSpellLock();
	elseif PetActionQueue["DevourMagic"] ~= nil then
		if IsPetActionAvailable(ServitudeLocalization.Magic5) then
			PetActionQueue["DevourMagic"] = nil;
			CastDevourMagic();
		end	
	elseif PetActionQueue["DispelMagic"] ~= nil then
		PetActionQueue["DispelMagic"] = nil;
		CastDispelMagic();
	elseif PetActionQueue["Sacrifice"] ~= nil then
		PetActionQueue["Sacrifice"] = nil;
		CastSacrifice();
	elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet2 and UnitAffectingCombat("pet")) then
		CastPetActionByName(ServitudeLocalization.Magic14);
	elseif PetActionQueue["ConsumeShadows"] ~= nil then
		PetActionQueue["ConsumeShadows"] = nil;
		CastConsumeShadow();
	elseif UnitCreatureFamily("pet") == ServitudeLocalization.Pet3 and (UnitCreatureType("target")=="Humanoid" or UnitIsPlayer("target") or UnitCreatureType("pettarget")=="Humanoid" or UnitIsPlayer("pettarget")) and ((UnitCanAttack("target", "player") and UnitCanAttack("player", "target")) or (UnitCanAttack("pettarget", "player") and UnitCanAttack("player", "pettarget"))) then
		CastSeduction();		
	elseif PetActionQueue["Invis"] ~= nil then
		PetActionQueue["Invis"] = nil;
		CastInvisibility();
	elseif (UnitCreatureFamily("pet") == ServitudeLocalization.Pet1) then
		CastFireShield();		
	end
end

