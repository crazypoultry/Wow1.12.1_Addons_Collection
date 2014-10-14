function CCWatch_ConfigBuff()

-- required attributes: GROUP, LENGTH, DIMINISHES
--  ETYPE = Effect Type : ETYPE_CC Pure CC(Stun/Root), ETYPE_DEBUFF Debuff(Snare/DoT,...), ETYPE_BUFF Buff
--  GROUP = Bar this CC is placed on
--  LENGTH = Duration of CC
--  DIMINISHES = 0 never diminishes, 1 = always diminishes, 2 = diminishes on players only
-- optional attributes PVPCC, COMBO
--  PVPCC = if PVPCC exists this value will be used as the base max for a Player target
--  COMBO = if COMBO exists then Combo Points will be added to CC duration
--
-- TARGET, PLAYER, TIMER_START, TIMER_END, DIMINISH are required for all and should be initialized empty
-- MONITOR is required for all and should be initialized to true

-- Rogue - Target Buffs

-- Priest - Buffs

-- Mage - Buffs

-- Druid - Buffs

-- Hunter - Buffs

-- Paladin - Buffs

-- Warlock - Buffs

-- Warrior - Buffs

-- Specific - Buffs

-- Forsaken
CCWATCH.CCS[CCWATCH_WOTF] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 5,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	MONITOR = true
}

-- Human
CCWATCH.CCS[CCWATCH_PERCEPTION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 20,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	MONITOR = true
}

end