--[[

AddOn: 	 	Panza

Base Version: 	4.0

--]]

PANZA_VERSION		= "4.122";	-- This only needs to be defined in this file.

function Panza_ErrorWithStack(msg)
	PA.LastError = msg.."\n"..debugstack();
	if (PA:CheckMessageLevel("Core", 2)) then
		PA:Message4(PA.LastError);
	end
	_ERRORMESSAGE(msg);
end

seterrorhandler(Panza_ErrorWithStack);

if (PA==nil) then
	PA = {};
else
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Panza: A conflict exists with another Addon. Check for variables that begin with PA, and contact support!", 1, 1, 0.5);
	end
	return;
end
PA.GUIFrames				= {}; -- List for GUI Frames
PA.OptionsMenuTree			= {}; -- Options Menu Tree

---------------------------
-- Classes PA will work for
---------------------------
PA.AllowedClasses 	= {PALADIN=true, PRIEST=true, DRUID=true, SHAMAN=true, MAGE=true};
PANZA_HYBRID 		= "Hybrid"; -- replaced later

------------------------------------------
-- 3.0 Information for myAddons 2 support
------------------------------------------
PANZA_TITLE			= "Panza";
PANZA_RELEASEDATE	= "October 3, 2006";
PANZA_AUTHOR		= "PADevs Team";
PANZA_EMAIL			= "wow-pa-devs@lists.sourceforge.net"
PANZA_WEBSITE		= "http://ui.worldofwar.net/ui.php?id=1042";

------------
-- Constants
------------
PANZA_MAX_PARTY			= 5;
PANZA_MAX_RAID			= 40;

PANZA_IGNORE_FAILED		= 6; 	-- Time in seconds for which players will be ignored after a spell failure
PANZA_FAILED_INC 		= 0; 	-- Every 5 fails this will be added to the ignore time
PANZA_PANIC_RAMP_INC	= 5; 	-- Ammount to increase health thresholds for panic trigger
PANZA_PANIC_RAMP_DELAY	= 0.5; 	-- Time between panic presses below which ramp is increased
PANZA_PANIC_RAMP_RESET	= 10; 	-- Time between panic presses after which ramp is reset
PANZA_PANIC_RESET		= 30; 	-- Time after which panic is reset
PANZA_STUCK				= { "ability_ensnare", -- Texture matches for debuffs that can be removed by BoF
							"nature_earthbind",
							"nature_stranglevines", 
							"frost_chainsofice",
							"nature_naturetouchdecay",
							}; 

-- Spell state enumerations
PA_SPELL_FREE		= "Free";
PA_SPELL_SET		= "Set";
PA_SPELL_DIFFERENT	= "Different";
PA_SPELL_EXTERNAL	= "External";

-----------------------------------------------------------------------------------------------------
-- General Variables
-- 1.2 Fix _Paladin_is_Ready was added to initiate PA:Initialize only once when the Addon Loads.
--			This happens during the first PLAYER_ENTERING_WORLD event.
--
-----------------------------------------------------------------------------------------------------
local _In_Instance 	= false;
_Paladin_is_Ready 	= false;

---------------------------------------------------------------------------------------------
-- Variables for Cycle Blessing and Healing
-- 1.21.6B  	added counters for party raid and pets for both to support the new CycleBless code
-- 1.21.61B 	added the activity monitor to insure that cycles get finished before they reset
-- 1.31		New Failed List for Cyclebless
-- 2.1		PA prefixes all variables
----------------------------------------------------------------------------------------------
function PA:ResetCycles()
	PA["Cycles"]					= {};
	PA.Cycles["Group"]				= {};
	PA.Cycles.Group["Reset"]		= false;
	PA.Cycles.Group["NextBless"]	= -1;
	PA.Cycles.Group["Mode"]			= '';
	PA.Cycles.Group["Count"]		= 0;
	PA.Cycles.Group["Done"]			= 0;
	PA.Cycles.Group["DoneWho"]		= {};
	PA.Cycles.Group["Fail"]			= {};
	PA.Cycles.Group["Dead"]			= {};
	PA.Cycles.Group["OutOfRange"]	= {};
	PA.Cycles.Group["NoPVP"]		= {};
	PA.Cycles.Group["Disconnected"]	= {};
	PA.Cycles.Group["Skipped"]		= {};

	PA.Cycles["UseGreaterBlessings"]= false;

	------------------------------------------------------------------------------
	-- Variable for Healing used in BestHeal and Announcements and recursive calls
	------------------------------------------------------------------------------
	PA.Cycles["Heal"]		 		= {};
	PA.Cycles.Heal["Timer"]			= 0;
	PA.Cycles.Heal["BaseBonus"]		= 0;
	PA.Cycles.Heal["Bonus"]			= 0;
	PA.Cycles.Heal["ForceFlash"]	= false;
	PA.Cycles.Heal["ForceHeal"]		= false;
	PA.Cycles.Heal["Mode"]			= nil;
	PA.Cycles.Heal["CD"]			= 0;
	PA.Cycles.Heal["Target"]		= {partytarget=nil,raidtarget=nil,partyhealth=nil,raidhealth=nil};

	------------------------------------------------------
	-- Variables used to track the nearby player blessings
	------------------------------------------------------
	PA.Cycles["Near"]				= {};
	PA.Cycles.Near["Count"]			= 0;
	PA.Cycles.Near["Timer"]			= 0;

	--------------------------------------------------------------------------------------------------------
	-- Variable to Track Spellcasts (Internal Cooldown, Failure Detection by Spell Type and Name with Target
	--------------------------------------------------------------------------------------------------------
	PA.Cycles["Spell"]					= {};
	PA.Cycles.Spell["Abort"]			= false;
	PA.Cycles.Spell["AbortMsg"]			= false;
	PA.Cycles.Spell["Type"]				= "blank";
	PA.Cycles.Spell["Active"] 			= {spell="blank", rank=0, target="blank", defclass="blank", msgtype="blank", msginfo="blank", owner=nil, Group=false};
	PA.Cycles.Spell["CoopTimer"]		= 0;
	PA.Cycles.Spell["HoTimer"]			= 0;
	PA.Cycles.Spell["BuffCheckTimer"]	= 0;
	PA.Cycles.Spell["HealCheckTimer"]	= 0;
	PA.Cycles.Spell["Timer"]			= {start=0, current=0};

	---------------------------------------------------------------------
	-- 1.31 Timer and Variables for the Buff Expire Warning System (BEWS)
	---------------------------------------------------------------------
	PA.Cycles["Buff"]			= { Timer=0, Saving=false, Spell="blank", Warn=0, Set=false, Final=false };

	------------
	-- Anti-Spam
	------------
	PA.LastMsg = {};
end

PA:ResetCycles();

------------------------------------------------------------
-- 2.0 Item Bonus Support (Using new PA. Variable name)
------------------------------------------------------------
PA["Inventory"]				= { Timer=0, Changed=false };

------------------------------------------------------------
-- 2.1 Action indices
------------------------------------------------------------
PA.ActionId = {};
PA.OffenseActionId = {};
PA.SpecialActionId = {};
PA.MacroRanges = {};

----------
-- Globals
----------
PA.InCombat					= false;
PA.ForceCombat				= false;
PA.Dueling					= false;

PA.SymbolKingsCount			= 0;
PA.SymbolDivinityCount		= 0;
PA.FeatherCount				= 0;
PA.HolyCanCount				= 0;
PA.SacredCanCount			= 0;

PA.SpellCheckCount			= 0;
PA.LastFailedSpell			= nil;
PA.chatframe				= nil;
PA.BarTest					= false;
PA.SpellBookVerified		= false;
PA.MouseInitialized			= false;
PA.CastingNow				= false;
PA.UpdateChat				= {Timer=0, Changed=false};
PA.UpdateActionBar			= {Timer=0, Changed=false};
PA.SpellBookCheck 			= {Timer=0};
PA["ChatFrames"]			= {};
PA["DamageLastGood"]		= {};
PA["HealBuffTip"] 			= {};
PA["Spells"]				= {};
PA["PAM_Tooltips"] 			= {};
PA["PAMCustom_Tooltips"]	= {};
PA["Opts_Tooltips"]			= {};
PA["PHM_Tooltips"] 			= {};
PA["PHMBias_Tooltips"]		= {};
PA["PBM_Tooltips"] 			= {};
PA["PBMIndi_Tooltips"] 		= {};
PA["DCB_Tooltips"] 			= {};
PA["PPM_Tooltips"] 			= {};
PA["PFM_Tooltips"]			= {};
PA["PCM_Tooltips"]			= {};
PA["PAW_Tooltips"]			= {};
PA["PCS_Tooltips"]			= {};
PA["POM_Tooltips"]			= {};
PA["PMM_Tooltips"]			= {};
PA["Bars_Tooltips"]			= {};
PA["Healing"]				= {};
PA["Offense"]				= {};
PA.MT						= {}; -- Main Tank list
PA.MTTT						= {}; -- Main Tanks Target's Target List
PA.GroupBuffs				= {};

-- Panza Cooperative Healing Message Throttle System
PA.CoOp 					= {};
PA.CoOp["LastMessageTime"]	= 0;
PA.CoOp["MinMsgInterval"]	= 0.30;

--------------------------------------------------------------------------------------------------
-- Active Frames. This list is also used to enable all supported frames by default in PanzaPMM.lua
--------------------------------------------------------------------------------------------------
PA.PMMSupport = {
	["CTRA"]=false,
	["Bliz_Player"]=false,
	["Bliz_Party"]=false,
	["Bliz_Pet"]=false,
	["Bliz_Target"]=false,
	["DUF"]=false,
	["PERL"]=false,
	["AG"]=false,
	["ORA"]=false,
	["SATRINA"]=false,
	["SAGE"]=false,
	["PERFECT"]=false,
	["ER"]=false,
	["SQUISHY"]=false;
	};

------------------------------------------------
-- Options listed in PMM based on PA.PlayerClass
------------------------------------------------
PA["clickmodeList"]={
	["PRIEST"]	= {"Unassigned","Heal","Buff","Cure","Rez","PowerWord:Shield"},
	["PALADIN"]	= {"Unassigned","Heal","Buff","Cure","Rez","Lay on Hands","Protection"},
	["DRUID"]	= {"Unassigned","Heal","Buff","Cure","Rez"},
	["SHAMAN"]	= {"Unassigned","Heal","Buff","Cure","Rez"},
	["MAGE"]	= {"Unassigned","Buff","Cure"},
	};

------------------------------------------------------------------------------------------------
-- PA:PMM_Defaults will set PASettings.clickmode to the value of PA.defaultClick[PA.PlayerClass]
------------------------------------------------------------------------------------------------
PA.defaultClick={
	['PRIEST']={
			['shiftLeftButton']=2,['shiftMiddleButton']=4,['shiftRightButton']=3,
			['ctrlLeftButton']=6,['ctrlMiddleButton']=1,['ctrlRightButton']=5,
			['altLeftButton']=1,['altMiddleButton']=1,['altRightButton']=1,
	},
	['PALADIN']={
			['shiftLeftButton']=2,['shiftMiddleButton']=4,['shiftRightButton']=3,
			['ctrlLeftButton']=6,['ctrlMiddleButton']=1,['ctrlRightButton']=5,
			['altLeftButton']=1,['altMiddleButton']=1,['altRightButton']=1,
	},
	['DRUID']={
			['shiftLeftButton']=2,['shiftMiddleButton']=4,['shiftRightButton']=3,
			['ctrlLeftButton']=1,['ctrlMiddleButton']=1,['ctrlRightButton']=5,
			['altLeftButton']=1,['altMiddleButton']=1,['altRightButton']=1,
	},
	['SHAMAN']={
			['shiftLeftButton']=2,['shiftMiddleButton']=4,['shiftRightButton']=3,
			['ctrlLeftButton']=1,['ctrlMiddleButton']=1,['ctrlRightButton']=5,
			['altLeftButton']=1,['altMiddleButton']=1,['altRightButton']=1,
	},
	['MAGE']={
			['shiftLeftButton']=2,['shiftMiddleButton']=1,['shiftRightButton']=3,
			['ctrlLeftButton']=1,['ctrlMiddleButton']=1,['ctrlRightButton']=1,
			['altLeftButton']=1,['altMiddleButton']=1,['altRightButton']=1,
	},
};

---------------------
-- UnitFrames we save
---------------------
PANZA_CTRA_AssistFrame_OnClick=nil;
PANZA_CTRA_AssistFrame_OnClick=nil;
PANZA_PlayerFrame_OnClick=nil;
PANZA_PartyMemberFrame_OnClick=nil;
PANZA_PartyMemberPetFrame_OnClick=nil;
PANZA_TargetFrame_OnClick=nil;
PANZA_DUF_UnitFrame_OnClick=nil;
PANZA_DUF_Element_OnClick=nil;
PANZA_SatrinaPlayerFrame_OnClick = nil;
PANZA_SatrinaPetFrame_OnClick = nil;
PANZA_SatrinaPartyMemberFrame_OnClick = nil;
PANZA_SatrinaTargetFrame_OnClick = nil;
PANZA_SFrame_OnClick = nil;
PANZA_PerfectRaidCustomClick = nil;
PANZA_oRA_MainTankFramesCustomClick = nil;
PANZA_ER_RaidPulloutButton_OnClick = nil;
PANZA_ER_MainTankButton_OnClick = nil;
PANZA_SquishyCustomClick = nil;


------------------
-- Saved Variables
------------------
Panza 	= nil;
PAState = nil;

-------------------------------------------------------------------------------
-- Variables for myAddons support
-- Updated for Version 2.5
-------------------------------------------------------------------------------
PanzaDetails = {
		name		= PANZA_TITLE,
		version		= PANZA_VERSION,
		releaseDate	= PANZA_RELEASEDATE,
		author		= PANZA_AUTHOR,
		email		= PANZA_EMAIL,
		website		= PANZA_WEBSITE,
		category	= MYADDONS_CATEGORY_CLASS,
		optionsframe	= "PanzaOptsFrame"
		};

function PA:ExtractMatchStrings()
	--------------------------------------------------------------------------------
	-- Match strings used to find if target is a pet/minion/creation and who owns it
	--------------------------------------------------------------------------------
	PANZA_MATCH_PET			= gsub(UNITNAME_TITLE_PET, "%%s", "(.*)", 1);
	PANZA_MATCH_MINION		= gsub(UNITNAME_TITLE_MINION, "%%s", "(.*)", 1);
	PANZA_MATCH_CHARM		= gsub(UNITNAME_TITLE_CHARM, "%%s", "(.*)", 1);
	PANZA_MATCH_CREATION	= gsub(UNITNAME_TITLE_CREATION, "%%s", "(.*)", 1);
	PANZA_MATCH_GUARDIAN	= gsub(UNITNAME_TITLE_GUARDIAN, "%%s", "(.*)", 1);

	PANZA_MATCH_FAILED_TITLE = gsub(gsub(gsub(SPELLFAILCASTSELF, "%.", "%%."), "%%s", "(.*)"), "%%%d%$s", "(.*)");

	----------------------------------------------------------
	-- Match strings used to extract spell info from spellbook
	----------------------------------------------------------
	PANZA_MATCH_POINTS_SPREAD	= gsub(SPELL_POINTS_SPREAD_TEMPLATE, "%%%.1f", "(%%%d+)", 2);

	-------------------------------------------
	-- Match string used to extract corpse name
	-------------------------------------------
	PANZA_MATCH_CORPSE = gsub(CORPSE_TOOLTIP, "%%s", "(.*)", 1);
end

PA:ExtractMatchStrings();

------------------------------------------------------------------
-- Safe version of Blizzard API function UnitName()
--
-- will not return nil
------------------------------------------------------------------
function PA:UnitName(unit)
	if (unit==nil) then
		return "target";
	end
	unit = string.lower(unit);
	if (unit=="blank" or unit=="corpse") then
		return "target";
	end
	local Status, UName, Realm = pcall(PA_UnitName_Safe, unit);
	if (not Status) then
		PA:ShowText(PA_RED.."Error in UnitName protected call: ", UName);
		return "target";
	end
	if (UName==nil or UName==UNKNOWNOBJECT) then
		return "target";
	end
	if (Realm~=nil) then 
		return UName.."-"..Realm;
	end
	return UName;
end

function PA_UnitName_Safe(unit)
	if unexpected_condition then error() end
	return UnitName(unit);
end
