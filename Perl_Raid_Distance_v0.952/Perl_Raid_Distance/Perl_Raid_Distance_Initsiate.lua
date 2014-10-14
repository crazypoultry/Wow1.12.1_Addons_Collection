
---------------
-- Variables --
---------------

-- Ver
PRD_Ver = 0.952;
PRD_Debug = false;

-- Saved config
PRD_Config = {};

-- Saved config
PRD_Running = {
	["Enable"] = 1,
	["Yards"] = 30,
	["RetriveMethod"] = 3,	-- 1, use spell   2, InteractDist  3, auto
	["DisplayMethod"] = 1,	-- 1, Alpha only   2, Alpha + CloseBorder   3, Alpha + AwayBorder,    4, Alpha + Close&Away-border
	["Alpha"] = {
		["Range"] = 0.2,
		["Offline"] = 0.1,
		["Dead"] = 0.1
	},
	["CloseBorderColor"]	= {0, 1, 0},
	["AwayBorderColor"]		= {1, 0, 0},
	["DefaultBorderColor"]	= {0.5, 0.5, 0.5}
};

-- Stage -1: Disabled
-- State 0: Not loaded
-- State 1: Normal
-- State 2: Dead, waiting
-- State 3: Casting
-- State 4: Mounted
PRD_State = 0;

PRD_CurrentSpell = nil;
PRD_Retrive = nil;
PRD_Display = nil;
PRD_TmpKey = nil;
PRD_LastSpell = "";

-- Define spells to use
PRD_Spells = {
	[30] = {
		["DRUID"] = "Mark of the Wild(Rank 1)",
		["HUNTER"] = nil,
		["MAGE"] = "Arcane Intellect(Rank 1)",
		["PALADIN"] = "Blessing of Might(Rank 1)",
		["PRIEST"] = "Power Word: Fortitude(Rank 1)",
		["ROGUE"] = nil,
		["SHAMAN"] = "Purge(Rank 1)",
		["WARLOCK"] = "Unending Breath",
		["WARRIOR"] = nil
		},
	[40] = {
		["DRUID"] = "Rejuvenation(Rank 1)",
		["HUNTER"] = nil,
		["MAGE"] = "Arcane Brilliance(Rank 1)",
		["PALADIN"] = "Holy Light(Rank 2)",
		["PRIEST"] = "Lesser Heal(Rank 2)",
		["ROGUE"] = nil,
		["SHAMAN"] = "Healing Wave(Rank 2)",
		["WARLOCK"] = "Unending Breath",
		["WARRIOR"] = nil
		}
};

PRD_MabyMounts = {
	["Interface\\Icons\\Ability_Mount_PinkTiger"] = 1,
	["Interface\\Icons\\Ability_Mount_WhiteTiger"] = 1,
	["Interface\\Icons\\Spell_Nature_Swiftness"] = 1,
	["Interface\\Icons\\INV_Misc_Foot_Kodo"] = 1,
	["Interface\\Icons\\Ability_Mount_JungleTiger"] =1
}