-- ============================================================================
-- TTSpellTimerSpellData.lua
--
-- Copyright (c) Matthew Johnson.  All rights reserved.
--
-- This work may be freely adapted and distributed as long as this notice remains intact.
-- This work may NOT be (re)sold or included in any compilations that are (re)sold.
--
-- ============================================================================

TTST_TotemType =
	{
	Air = 1,
	Earth = 2,
	Fire = 3,
	Water = 4,
	};

TTST_TotemStateCurrent =
	{
	[TTST_TotemType.Air]	= nil,
	[TTST_TotemType.Earth]	= nil,
	[TTST_TotemType.Fire]	= nil,
	[TTST_TotemType.Water]	= nil,
	};

TTST_TotemStateFunc =
	function (event, totemType, totemName)

		-- On spellcast stop, remove any totems of the same type and
		-- then record this totem's type.
		if (event == "SPELLCAST_STOP") then

			if (TTST_TotemStateCurrent[totemType] ~= nil) then
				TTST_RemoveTimerByName(TTST_TotemStateCurrent[totemType]);
				TTST_TotemStateCurrent[totemType] = nil;
			end

			TTST_TotemStateCurrent[totemType] = totemName;

		end

		return false;

	end;

TTST_SpellState =
	{
	None = 0,
	Queued = 1,
	};

TTST_SpellMapping = {};

TTST_TimeFormat =
	{
	Default = 1,		-- Blizzard default time
	MMSSTT = 2,			-- Minutes : Seconds . Tenths
	};

-- ============================================================================
-- This data structure contains all of the default values for each spell to be
-- timed/monitored.
-- ============================================================================

TTST_SpellDataDefault =
	{
	Settings =
		{
		DisableAutoMessages = "yes",
		Disabled = "no",
		HideBackground = "yes",
		MaxTimersToShow = 8,
		TimerScaling = 1.0,
		TimerColors =
			{
			Default = { r = 1, g = 1, b = 1 },
			Warning = { r = 1, g = 1, b = 0 },
			Critical = { r = 1, g = 0, b = 0 },
			SpellName = { r = 1, g = 1, b = 1 },
			TargetName = { r = 1, g = 1, b = 1 },
			},
		TimerFrameAnchor = nil,
		TimerFramePosition = { x = nil, y = nil },
		TimeFormat = TTST_TimeFormat.MMSSTT,
		},
	Spells =
		{
-- ============================================================================
-- Druid spells.
-- ============================================================================
		[TTST_SPELL_ABOLISH_POISON] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 5, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = true,
				Texture = "Interface\\Icons\\Spell_Nature_NullifyPoison_02",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = false,
				EnabledAutoMessage = false,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CHALLENGING_ROAR] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Ability_Druid_ChallangingRoar",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_DEMORALIZING_ROAR] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 30, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Ability_Druid_DemoralizingRoar",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_ENTANGLING_ROOTS] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Nature_StrangleVines",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 12, Warning = 12, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 15, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 18, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_4] = { Start = 21, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_5] = { Start = 24, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_6] = { Start = 27, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_StrangleVines",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Entangling %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_FAERIE_FIRE] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Nature_FaerieFire",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 40, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_FaerieFire",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_FAERIE_FIRE_FERAL] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Nature_FaerieFire",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 40, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_FaerieFire",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_HIBERNATE] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Nature_Sleep",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 20, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 30, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 40, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_Sleep",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Sleeping %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_INNERVATE] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 20, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = true,
				Texture = "Interface\\Icons\\Spell_Nature_Lightning",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_INSECT_SWARM] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Nature_InsectSwarm",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_InsectSwarm",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_MOONFIRE] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Nature_StarFall",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 9, Warning = 9, Critical = 5 },
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_StarFall",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_RAKE] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Druid_Disembowel",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 9, Warning = 9, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Ability_Druid_Disembowel",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_REBIRTH] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 0, Warning = 0, Critical = 0 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_Reincarnation",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = false,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_REGROWTH] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 21, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = true,
				Texture = "Interface\\Icons\\Spell_Nature_ResistNature",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_REJUVENATION] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = true,
				Texture = "Interface\\Icons\\Spell_Nature_Rejuvenation",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_RIP] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_GhoulFrenzy",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Ability_GhoulFrenzy",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SOOTHE_ANIMAL] =
			{
			Class = TTST_DRUID,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Hunter_BeastSoothe",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Ability_Hunter_BeastSoothe",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Hunter spells.
-- ============================================================================
		[TTST_SPELL_CONCUSSIVE_SHOT] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Frost_Stun",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 4, Warning = 4, Critical = 4 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Frost_Stun",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_COUNTERATTACK] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 5, Warning = 5, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Warrior_Challange",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_HUNTERS_MARK] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Hunter_SniperShot",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Hunter_SniperShot",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SCARE_BEAST] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Druid_Cower",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 10, Warning = 10, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 15, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 20, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Druid_Cower",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Fearing %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SCATTER_SHOT] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_GolemStormBolt",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 4, Warning = 4, Critical = 4 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_GolemStormBolt",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SCORPID_STING] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Hunter_CriticalShot",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 20, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Hunter_CriticalShot",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SERPENT_STING] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Hunter_Quickshot",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Hunter_Quickshot",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_VIPER_STING] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Hunter_AimedShot",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Hunter_AimedShot",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_WING_CLIP] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Rogue_Trip",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Rogue_Trip",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_WYVERN_STING] =
			{
			Class = TTST_HUNTER,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "INV_Spear_02",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\INV_Spear_02",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Hunter Pet spells.
-- ============================================================================
		[TTST_SPELL_PET_BESTIAL_WRATH] =
			{
			Class = TTST_HUNTER_PET,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Druid_FerociousBite",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PET_INTIMIDATION] =
			{
			Class = TTST_HUNTER_PET,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_Devour",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 3, Warning = 3, Critical = 3 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Devour",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PET_SCREECH] =
			{
			Class = TTST_HUNTER_PET,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_Hunter_Pet_Bat",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 4, Warning = 4, Critical = 4 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Hunter_Pet_Bat",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PET_SCORPID_POISON] =
			{
			Class = TTST_HUNTER_PET,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_PoisonSting",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 8 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_PoisonSting",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Mage spells.
-- ============================================================================
		[TTST_SPELL_BLAST_WAVE] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Holy_Excorcism",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_CONE_OF_COLD] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 5, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents =
					{
					[TTST_SPELL_TALENT_PERMAFROST] =
						{
						Ranks = { 1, 1.5, 2, 2.5, 3 },
						TalentId = 2,
						TreeId = 2,
						},
					},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Frost_Glacier",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_COUNTERSPELL] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Frost_IceShock",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Frost_IceShock",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_FIREBALL] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Fire_FlameBolt",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 6, Warning = 6, Critical = 5 },
					[TTST_SPELL_RANK_2] = { Start = 6, Warning = 6, Critical = 5 },
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Fire_FlameBolt",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_FLAMESTRIKE] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Fire_SelfDestruct",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_FROST_NOVA] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Frost_FrostNova",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_FROSTBOLT] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Frost_FrostBolt02",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 5, Warning = 5, Critical = 5 },
					[TTST_SPELL_RANK_2] = { Start = 6, Warning = 6, Critical = 5 },
					[TTST_SPELL_RANK_3] = { Start = 6, Warning = 6, Critical = 5 },
					[TTST_SPELL_RANK_4] = { Start = 7, Warning = 7, Critical = 5 },
					[TTST_SPELL_RANK_5] = { Start = 7, Warning = 7, Critical = 5 },
					[TTST_SPELL_RANK_6] = { Start = 8, Warning = 8, Critical = 5 },
					[TTST_SPELL_RANK_7] = { Start = 8, Warning = 8, Critical = 5 },
					[TTST_SPELL_RANK_DEFAULT] = { Start = 9, Warning = 9, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Frost_FrostBolt02",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_POLYMORPH] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Polymorph",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 20, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 30, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 40, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_DEFAULT] = { Start = 50, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_Polymorph",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Sheeping %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PYROBLAST] =
			{
			Class = TTST_MAGE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Fire_Fireball02",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Fire_Fireball02",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Paladin spells.
-- ============================================================================
		[TTST_SPELL_CONSECRATION] =
			{
			Class = TTST_PALADIN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 8 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Holy_InnerFire",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_HAMMER_OF_JUSTICE] =
			{
			Class = TTST_PALADIN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Holy_SealOfMight",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 3, Warning = 3, Critical = 3 },
					[TTST_SPELL_RANK_2] = { Start = 4, Warning = 4, Critical = 4 },
					[TTST_SPELL_RANK_3] = { Start = 5, Warning = 5, Critical = 5 },
					[TTST_SPELL_RANK_4] = { Start = 6, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Holy_SealOfMight",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_REPENTANCE] =
			{
			Class = TTST_PALADIN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Holy_PrayerOfHealing",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Holy_PrayerOfHealing",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_TURN_UNDEAD] =
			{
			Class = TTST_PALADIN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Holy_TurnUndead",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 10, Warning = 10, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 15, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 20, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Holy_TurnUndead",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Fearing %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Priest spells.
-- ============================================================================
		[TTST_SPELL_ABOLISH_DISEASE] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 20, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = true,
				Texture = "Interface\\Icons\\Spell_Nature_NullifyDisease",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_DEVOURING_PLAGUE] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_BlackPlague",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 24, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Shadow_BlackPlague",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_HEX_OF_WEAKNESS] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_FingerOfDeath",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Shadow_FingerOfDeath",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_HOLY_FIRE] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Holy_SearingLight",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Holy_SearingLight",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_MIND_CONTROL] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_ShadowWordDominate",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 60, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Shadow_ShadowWordDominate",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Mind Controling %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_MIND_SOOTHE] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Holy_MindSooth",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Holy_MindSooth",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Mind Soothing %t.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_POWER_WORD_SHIELD] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = true,
				Texture = "Interface\\Icons\\Spell_Holy_PowerWordShield",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Shielding %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PSYCHIC_SCREAM] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Shadow_PsychicScream",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Psychic Scream.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_RENEW] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = true,
				Texture = "Interface\\Icons\\Spell_Holy_Renew",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SHACKLE_UNDEAD] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Nature_Slow",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 30, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 40, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 50, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Nature_Slow",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Shackling %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SHADOW_WORD_PAIN] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_ShadowWordPain",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 18, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents =
					{
					[TTST_SPELL_TALENT_IMPROVED_SHADOW_WORD_PAIN] =
						{
						Ranks = { 3, 6 },
						TalentId = 4,
						TreeId = 3,
						},
					},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SILENCE] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_ImpPhaseShift",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 5, Warning = 5, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Shadow_ImpPhaseShift",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_VAMPIRIC_EMBRACE] =
			{
			Class = TTST_PRIEST,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_UnsummonBuilding",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 60, Warning = 30, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				TargetRequired = false,
				Texture = "Interface\\Icons\\Spell_Shadow_UnsummonBuilding",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Rogue spells.
-- ============================================================================
		[TTST_SPELL_BLIND] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_MindSteal",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_MindSteal",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CHEAP_SHOT] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_CheapShot",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 4, Warning = 4, Critical = 4 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_CheapShot",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_DISTRACT] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Rogue_Distract",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_EXPOSE_ARMOR] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Warrior_Riposte",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 30, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Warrior_Riposte",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_GARROTE] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 18, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents =
					{
					[TTST_SPELL_TALENT_IMPROVED_GARROTE] =
						{
						Ranks = { 3, 6 },
						TalentId = 8,
						TreeId = 3,
						},
					},
				Texture = "Interface\\Icons\\Ability_Rogue_Garrote",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_GOUGE] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_Gouge",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 4, Warning = 4, Critical = 4 },
 					},
				State = TTST_SpellState.None,
				Talents =
					{
					[TTST_SPELL_TALENT_IMPROVED_GOUGE] =
						{
						Ranks = { 0.5, 1, 1.5 },
						TalentId = 1,
						TreeId = 2,
						},
					},
				Texture = "Interface\\Icons\\Ability_Gouge",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_HEMORRHAGE] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_LifeDrain",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_LifeDrain",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_KICK] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_Kick",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 5, Warning = 5, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Kick",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_KIDNEY_SHOT] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Rogue_KidneyShot",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 1, Warning = 5, Critical = 5 },
					[TTST_SPELL_RANK_2] = { Start = 2, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Rogue_KidneyShot",
				Unique = false,
				ComboModifier = 1,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PREMEDITATION] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_Possession",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_RIPOSTE] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Warrior_Challange",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},
		[TTST_SPELL_RUPTURE] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Rogue_Rupture",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Rogue_Rupture",
				Unique = false,
				ComboModifier = 4,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},
		[TTST_SPELL_SAP] =
			{
			Class = TTST_ROGUE,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_Sap",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 25, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 35, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 45, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Sap",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Sapping %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Shaman spells.
-- ============================================================================
		[TTST_SPELL_DISEASE_CLEANSING_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Water, TTST_SPELL_DISEASE_CLEANSING_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_DiseaseCleansingTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_EARTHBIND_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Earth, TTST_SPELL_EARTHBIND_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 45, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_EARTH_SHOCK] =
			{
			Class = TTST_SHAMAN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 2, Warning = 2, Critical = 2 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_EarthShock",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_FIRE_NOVA_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Fire, TTST_SPELL_FIRE_NOVA_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 5, Warning = 5, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Fire_SealOfFire",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_FIRE_RESISTANCE_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Water, TTST_SPELL_FIRE_RESISTANCE_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_FireResistanceTotem_01",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_FLAME_SHOCK] =
			{
			Class = TTST_SHAMAN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Fire_FlameShock",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 12, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Fire_FlameShock",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_FLAMETONGUE_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Fire, TTST_SPELL_FLAMETONGUE_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_GuardianWard",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_FROST_RESISTANCE_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Fire, TTST_SPELL_FROST_RESISTANCE_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_FrostResistanceTotem_01",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_FROST_SHOCK] =
			{
			Class = TTST_SHAMAN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Frost_FrostShock",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 8 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Frost_FrostShock",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_GRACE_OF_AIR_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Air, TTST_SPELL_GRACE_OF_AIR_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_InvisibilityTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_GROUNDING_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Air, TTST_SPELL_GROUNDING_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 45, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_GroundingTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_HEALING_STREAM_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Water, TTST_SPELL_HEALING_STREAM_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 60, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\INV_Spear_04",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_MAGMA_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Fire, TTST_SPELL_MAGMA_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 20, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Fire_SelfDestruct",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_MANA_SPRING_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Water, TTST_SPELL_MANA_SPRING_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 60, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_ManaRegenTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_MANA_TIDE_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Water, TTST_SPELL_MANA_TIDE_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_NATURE_RESISTANCE_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Air, TTST_SPELL_NATURE_RESISTANCE_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_NatureResistanceTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_POISON_CLEANSING_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Water, TTST_SPELL_POISON_CLEANSING_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_PoisonCleansingTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_REINCARNATION] =
			{
			Class = TTST_SHAMAN,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 60, Warning = 30, Critical = 15 },
 					},
				State = TTST_SpellState.None,
				Talents =
					{
					[TTST_SPELL_TALENT_IMPROVED_REINCARNATION] =
						{
						Ranks = { -10, -20 },
						TalentId = 3,
						TreeId = 3,
						},
					},
				Texture = "Interface\\Icons\\Spell_Nature_Reincarnation",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = false,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_SEARING_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Fire, TTST_SPELL_SEARING_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 30, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 35, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 40, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_4] = { Start = 45, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_5] = { Start = 50, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_DEFAULT] = { Start = 55, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Fire_SearingTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_SENTRY_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Air, TTST_SPELL_SENTRY_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 300, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_RemoveCurse",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_STONECLAW_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Earth, TTST_SPELL_STONECLAW_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_StoneClawTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_STONESKIN_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Earth, TTST_SPELL_STONESKIN_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_StoneSkinTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_STRENGTH_OF_EARTH_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Earth, TTST_SPELL_STRENGTH_OF_EARTH_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_EarthBindTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_TRANQUIL_AIR_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Air, TTST_SPELL_TRANQUIL_AIR_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_Brilliance",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_TREMOR_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Earth, TTST_SPELL_TREMOR_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_TremorTotem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_WINDFURY_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Air, TTST_SPELL_WINDFURY_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_Windfury",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_WINDWALL_TOTEM] =
			{
			Class = TTST_SHAMAN,
			EventHandler =
				function ()
					return TTST_TotemStateFunc(event, TTST_TotemType.Air, TTST_SPELL_WINDWALL_TOTEM);
				end,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 30, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_EarthBind",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

-- ============================================================================
-- Warlock spells.
-- ============================================================================
		[TTST_SPELL_BANISH] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_Cripple",
				Description = TTST_DESC_BANISH,
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 20, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 30, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_Cripple",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Banishing %target%.",
					MessagePreCast = nil,
					Enabled = { Say = true, Yell = false, Party = true, Raid = true, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_CORRUPTION] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_AbominationExplosion",
				Description = TTST_DESC_CORRUPTION,
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 12, Warning = 10, Critical = 5 },
					[TTST_SPELL_RANK_2] = { Start = 15, Warning = 10, Critical = 5 },
					[TTST_SPELL_RANK_DEFAULT] = { Start = 18, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_AbominationExplosion",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_AGONY] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_CurseOfSargeras",
				Description = TTST_DESC_CURSE_OF_AGONY,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 24, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_DOOM] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_AuraOfDarkness",
				Description = TTST_DESC_CURSE_OF_DOOM,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 60, Warning = 30, Critical = 15 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_AuraOfDarkness",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_EXHAUSTION] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_GrimWard",
				Description = TTST_DESC_CURSE_OF_EXHAUSTION,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 12, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_GrimWard",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_RECKLESSNESS] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_UnholyStrength",
				Description = TTST_DESC_CURSE_OF_RECKLESSNESS,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_UnholyStrength",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_SHADOW] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_CurseOfAchimonde",
				Description = TTST_DESC_CURSE_OF_SHADOW,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 300, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_CurseOfAchimonde",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_THE_ELEMENTS] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_ChillTouch",
				Description = TTST_DESC_CURSE_OF_THE_ELEMENTS,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 300, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_ChillTouch",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_TONGUES] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_CurseOfTounges",
				Description = TTST_DESC_CURSE_OF_TONGUES,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 30, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_CurseOfTounges",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_CURSE_OF_WEAKNESS] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_CurseOfMannoroth",
				Description = TTST_DESC_CURSE_OF_WEAKNESS,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 120, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_DEATH_COIL] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Description = TTST_DESC_DEATH_COIL,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 3, Warning = 3, Critical = 3 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_DeathCoil",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_ENSLAVE_DEMON] =
			{
			Class = TTST_WARLOCK,
			EventHandler =
				function ()

					if (event == "PET_UI_CLOSE") then

						-- Enslave demon is special in that only one demon can be enslaved at a time.
						-- We might as well clean up any remaining enslave demon timers.
						TTST_RemoveTimerByName(TTST_SPELL_ENSLAVE_DEMON);

						return true;

					elseif (event == "SPELLCAST_STOP") then

						-- If we've stopped casting enslave demon, make sure we get future notification
						-- when the pet arrives and breaks;
						TTST_CreateEventQueue(TTST_SPELL_ENSLAVE_DEMON, "UNIT_PET", nil, nil);

						-- Reset this spell's state or else the next queue won't work.
						TTST_GetSpellProperties(TTST_SPELL_ENSLAVE_DEMON).State = TTST_SpellState.None;
						
						TTST_CreateEventQueue(TTST_SPELL_ENSLAVE_DEMON, "PET_UI_CLOSE", nil, nil, 305);

						return true;

					elseif (event == "UNIT_PET" and arg1 == "player") then

						-- The player's pet changed, so find out if it is enslaved.
						if (TTST_FindDebuffByName("pet", TTST_GetSpellProperties(TTST_SPELL_ENSLAVE_DEMON).DebuffName)) then

							TTST_RemoveTimerByName(TTST_SPELL_ENSLAVE_DEMON);

							TTST_CreateTimer(TTST_SPELL_ENSLAVE_DEMON, TTST_SPELL_RANK_1, UnitName("pet"));

							return true;

						end

					end

					-- Since we don't handle the given event, just return false.
					return false;

				end,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_EnslaveDemon",
				Description = TTST_DESC_ENSLAVE_DEMON,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 300, Warning = 60, Critical = 30 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_EnslaveDemon",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Enslaving %target%.",
					MessagePreCast = nil,
					Enabled = { Say = true, Yell = false, Party = true, Raid = true, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_FEAR] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_Possession",
				Description = TTST_DESC_FEAR,
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 10, Warning = 10, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 15, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 20, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_Possession",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Fearing %target%.",
					MessagePreCast = nil,
					Enabled = { Say = true, Yell = false, Party = true, Raid = true, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_HELLFIRE] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Description = TTST_DESC_HELLFIRE,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Fire_Incinerate",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = false,
				EnabledAutoMessage = false,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_HOWL_OF_TERROR] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Description = TTST_DESC_HOWL_OF_TERROR,
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 10, Warning = 10, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 15, Warning = 15, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_DeathScream",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Howl of Terror!",
					MessagePreCast = nil,
					Enabled = { Say = true, Yell = false, Party = true, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_IMMOLATE] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Fire_Immolation",
				Description = TTST_DESC_IMMOLATE,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Fire_Immolation",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_INFERNO] =
			{
			Class = TTST_WARLOCK,
			EventHandler =
				function ()

					if (event == "PET_UI_CLOSE") then

						-- Enslave demon is special in that only one demon can be enslaved at a time.
						-- We might as well clean up any remaining enslave demon timers.
						TTST_RemoveTimerByName(TTST_SPELL_INFERNO);

						return true;

					elseif (event == "SPELLCAST_STOP") then

						-- If we've stopped casting enslave demon, make sure we get future notification
						-- when the pet arrives and breaks;
						TTST_CreateEventQueue(TTST_SPELL_INFERNO, "UNIT_PET", nil, nil);

						-- Reset this spell's state or else the next queue won't work.
						TTST_GetSpellProperties(TTST_SPELL_INFERNO).State = TTST_SpellState.None;
						
						TTST_CreateEventQueue(TTST_SPELL_INFERNO, "PET_UI_CLOSE", nil, nil, 305);

						return true;

					elseif (event == "UNIT_PET" and arg1 == "player") then

						-- The player's pet changed, so find out if it is enslaved.
						if (TTST_FindDebuffByName("pet", TTST_GetSpellProperties(TTST_SPELL_INFERNO).DebuffName)) then

							TTST_RemoveTimerByName(TTST_SPELL_INFERNO);

							TTST_CreateTimer(TTST_SPELL_INFERNO, TTST_SPELL_RANK_1, UnitName("pet"));

							return true;

						end

					end

					-- Since we don't handle the given event, just return false.
					return false;

				end,
			Events = {},
			Properties =
				{
				DebuffName = "Spell_Shadow_EnslaveDemon",
				Description = TTST_DESC_INFERNO,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 300, Warning = 60, Critical = 30 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_EnslaveDemon",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_RITUAL_OF_DOOM] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Description = TTST_DESC_RITUAL_OF_DOOM,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 0, Warning = 0, Critical = 0 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_AntiMagicShell",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Calling forth a Doomguard.  Please assist.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = false,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_RITUAL_OF_SUMMONING] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Description = TTST_DESC_RITUAL_OF_SUMMONING,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 0, Warning = 0, Critical = 0 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_Twilight",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = "Summoning %target%.  Please assist.",
					Enabled = { Say = true, Yell = false, Party = true, Raid = true, Emote = false },
					},
				AutoRemove = false,
				Enabled = false,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_SIPHON_LIFE] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_Requiem",
				Description = TTST_DESC_SIPHON_LIFE,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 30, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_Requiem",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SOULSTONE_RESURRECTION] =
			{
			Class = TTST_WARLOCK,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Description = TTST_DESC_SOULSTONE_RESURRECTION,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 1800, Warning = 600, Critical = 60 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_SoulGem",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "%target% has been Soulstoned.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = true, Emote = false },
					},
				AutoRemove = false,
				Enabled = false,
				EnabledAutoMessage = true,
				ShowSpellName = false,
				ShowTargetName = false,
				},
			},

-- ============================================================================
-- Warlock Pet spells.
-- ============================================================================
		[TTST_SPELL_PET_SEDUCTION] =
			{
			Class = TTST_WARLOCK_PET,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_MindSteal",
				Description = TTST_DESC_PET_SEDUCTION,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_MindSteal",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Seducing %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = true, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PET_SPELL_LOCK] =
			{
			Class = TTST_WARLOCK_PET,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Shadow_MindRot",
				Description = TTST_DESC_PET_SEDUCTION,
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 6, Warning = 6, Critical = 8 },
					[TTST_SPELL_RANK_2] = { Start = 8, Warning = 8, Critical = 8 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_MindRot",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = "Spell locking %target%.",
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = true, Raid = true, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

-- ============================================================================
-- Warrior spells.
-- ============================================================================
		[TTST_SPELL_BERSERKER_RAGE] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 30, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_AncestralGuardian",
				Unique = true,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = false,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_CHALLENGING_SHOUT] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_BullRush",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_CONCUSSION_BLOW] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_ThunderBolt",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 5, Warning = 5, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_ThunderBolt",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_DEMORALIZING_SHOUT] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 30, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents =
					{
					[TTST_SPELL_TALENT_BOOMING_VOICE] =
						{
						Ranks = { 3, 6, 9, 12, 15 },
						TalentId = 1,
						TreeId = 2,
						},
					},
				Texture = "Interface\\Icons\\Ability_Warrior_WarCry",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_DISARM] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Warrior_Disarm",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents =
					{
					[TTST_SPELL_TALENT_IMPROVED_DISARM] =
						{
						Ranks = { 1, 2, 3 },
						TalentId = 11,
						TreeId = 3,
						},
					},
				Texture = "Interface\\Icons\\Ability_Warrior_Disarm",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_HAMSTRING] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_ShockWave",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 15, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_ShockWave",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_INTIMIDATING_SHOUT] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 8, Warning = 8, Critical = 5 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_GolemThunderClap",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_MOCKING_BLOW] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Warrior_PunishingBlow",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_MORTAL_STRIKE] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Warrior_SavageBlow",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 10, Warning = 10, Critical = 5 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Warrior_SavageBlow",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_PIERCING_HOWL] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Shadow_DeathScream",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},

		[TTST_SPELL_PUMMEL] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "INV_Gauntlets_04",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 4, Warning = 4, Critical = 4 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\INV_Gauntlets_04",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_REND] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Ability_Gouge",
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 9, Warning = 9, Critical = 9 },
					[TTST_SPELL_RANK_2] = { Start = 12, Warning = 12, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 15, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_4] = { Start = 18, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_DEFAULT] = { Start = 21, Warning = 15, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Gouge",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SHIELD_BASH] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 6, Warning = 6, Critical = 6 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Warrior_ShieldBash",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_SUNDER_ARMOR] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = "Warrior_Sunder",
				Duration =
					{
					[TTST_SPELL_RANK_DEFAULT] = { Start = 30, Warning = 20, Critical = 10 },
 					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Ability_Warrior_Sunder",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = true,
				},
			},

		[TTST_SPELL_THUNDER_CLAP] =
			{
			Class = TTST_WARRIOR,
			EventHandler = nil,
			Events = {},
			Properties =
				{
				DebuffName = nil,
				Duration =
					{
					[TTST_SPELL_RANK_1] = { Start = 10, Warning = 10, Critical = 10 },
					[TTST_SPELL_RANK_2] = { Start = 14, Warning = 10, Critical = 10 },
					[TTST_SPELL_RANK_3] = { Start = 18, Warning = 15, Critical = 10 },
					[TTST_SPELL_RANK_4] = { Start = 22, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_5] = { Start = 26, Warning = 20, Critical = 10 },
					[TTST_SPELL_RANK_6] = { Start = 30, Warning = 20, Critical = 10 },
					},
				State = TTST_SpellState.None,
				Talents = {},
				Texture = "Interface\\Icons\\Spell_Nature_ThunderClap",
				Unique = false,
				},
			UserProperties =
				{
				AutoChat =
					{
					Message = nil,
					MessagePreCast = nil,
					Enabled = { Say = false, Yell = false, Party = false, Raid = false, Emote = false },
					},
				AutoRemove = true,
				Enabled = true,
				EnabledAutoMessage = true,
				ShowSpellName = true,
				ShowTargetName = false,
				},
			},
		},
	};

-- ============================================================================
-- This data structure contains all of the user customized data.  It is the
-- user's saved variables structure for this addon.
-- ============================================================================
TTST_SpellDataUser =
	{
	Settings = {},
	Spells = {},
	};

-- ============================================================================
-- What follows are functions for accessing the above spell data.  The fuction
-- will first check to see if the data has been customized by the user.  If it
-- has then the user customized data will be returned.  If the data has not
-- been customized, then the default data will be returned.
-- ============================================================================

-- ============================================================================
-- GetSpellData
-- ============================================================================
function TTST_GetSpellData(spellName)

	-- This is some special casing for the various polymorph spells.  Instead
	-- of having one entry for each, we'll just bundle them all together.
	if (string.find(spellName, TTST_SPELL_POLYMORPH)) then
		spellName = TTST_SPELL_POLYMORPH;
	end

	return TTST_SpellDataDefault.Spells[spellName];

end

-- ============================================================================
-- GetSpellDuration
--
-- Returns the start, warning, and critical levels for the given spell and
-- rank.
-- ============================================================================
function TTST_GetSpellDuration(spellName, spellRank)

	-- This is some special casing for the various polymorph spells.  Instead
	-- of having one entry for each, we'll just bundle them all together.
	if (string.find(spellName, TTST_SPELL_POLYMORPH)) then
		spellName = TTST_SPELL_POLYMORPH;
	end

	local spellProperties = TTST_GetSpellProperties(spellName);

	if (spellProperties ~= nil) then

		local duration = spellProperties.Duration[spellRank];

		-- If there is no duration for the given rank, then use the "*" rank.
		if (duration == nil) then
			duration = spellProperties.Duration[TTST_SPELL_RANK_DEFAULT];
		end

		-- If there still isn't a duration, then we're screwed.
		if (duration ~= nil) then
			return duration.Start, duration.Warning, duration.Critical;
		end

	end

	return nil;

end

-- ============================================================================
-- GetSpellProperties
--
-- The user can not customize these properties so get them straigh from the
-- spell data.
-- ============================================================================
function TTST_GetSpellProperties(spellName)

	local spellData = TTST_GetSpellData(spellName);

	if (spellData ~= nil) then

		return spellData.Properties;

	end

	return nil;

end

-- ============================================================================
-- GetSpellUserProperties
--
-- Returns the set of data that the user can customize.
-- ============================================================================
function TTST_GetSpellUserProperties(spellName)

	-- This is some special casing for the various polymorph spells.  Instead
	-- of having one entry for each, we'll just bundle them all together.
	if (string.find(spellName, TTST_SPELL_POLYMORPH)) then
		spellName = TTST_SPELL_POLYMORPH;
	end

	local spellDataUser = TTST_SpellDataUser.Spells[spellName];

	-- First check to see if the user has overridden any properties.
	if (spellDataUser ~= nil and spellDataUser.UserProperties ~= nil) then

		return spellDataUser.UserProperties;

	end

	-- No user properties have been overridden, so use the default values.
	return TTST_SpellDataDefault.Spells[spellName].UserProperties;

end

-- ============================================================================
-- RemoveSpellUserProperties
--
-- Removes the customized user properties for the named spell.
-- ============================================================================
function TTST_RemoveSpellUserProperties(spellName)

	-- Verify the spell name is a real spell that we can configure.
	if (TTST_GetSpellProperties(spellName) ~= nil) then

		TTST_SetSpellUserProperties(spellName, nil);

	end

end

-- ============================================================================
-- SetSpellUserProperties
--
-- The user has customized some data, so make sure we save it for next time.
-- ============================================================================
function TTST_SetSpellUserProperties(spellName, userProperties)

	-- This is some special casing for the various polymorph spells.  Instead
	-- of having one entry for each, we'll just bundle them all together.
	if (string.find(spellName, TTST_SPELL_POLYMORPH)) then
		spellName = TTST_SPELL_POLYMORPH;
	end

	local spellDataUser = TTST_SpellDataUser.Spells[spellName];

	if (spellDataUser == nil) then

		TTST_SpellDataUser.Spells[spellName] = {};
		spellDataUser = TTST_SpellDataUser.Spells[spellName];

	end

	spellDataUser.UserProperties = userProperties;

end

-- ============================================================================
-- GetGeneralSettings
--
-- Returns the set of data that the user can customize.
-- ============================================================================
function TTST_GetGeneralSettings()

	local settings = {};
	for k, v in TTST_SpellDataDefault.Settings do
		settings[k] = v;
	end

	if (TTST_SpellDataUser.Settings.DisableAutoMessages) then
		settings.DisableAutoMessages = TTST_SpellDataUser.Settings.DisableAutoMessages;
	end

	if (TTST_SpellDataUser.Settings.Disabled) then
		settings.Disabled = TTST_SpellDataUser.Settings.Disabled;
	end

	if (TTST_SpellDataUser.Settings.HideBackground) then
		settings.HideBackground = TTST_SpellDataUser.Settings.HideBackground;
	end

	if (TTST_SpellDataUser.Settings.TimerFramePosition) then
		settings.TimerFramePosition = TTST_SpellDataUser.Settings.TimerFramePosition;
	end

	if (TTST_SpellDataUser.Settings.TimerScaling) then
		settings.TimerScaling = TTST_SpellDataUser.Settings.TimerScaling;
	end

	if (TTST_SpellDataUser.Settings.TimerFrameAnchor) then
		settings.TimerFrameAnchor = TTST_SpellDataUser.Settings.TimerFrameAnchor;
	end
	
	if (TTST_SpellDataUser.Settings.TimeFormat) then
		settings.TimeFormat = TTST_SpellDataUser.Settings.TimeFormat;
	end

	return settings;

end

-- ============================================================================
-- SetGeneralSettings
--
-- The user has customized some data, so make sure we save it for next time.
-- ============================================================================
function TTST_SetGeneralSettings(generalSettings)

	if (generalSettings == nil) then
		generalSettings = {};
	end

	for k, v in generalSettings do
		TTST_SpellDataUser.Settings[k] = v;
	end

end

function TTST_InitializeSpellMapping()

	for key in TTST_SpellDataDefault.Spells do
		TTST_SpellMapping[strupper(key)] = key;
	end

end

