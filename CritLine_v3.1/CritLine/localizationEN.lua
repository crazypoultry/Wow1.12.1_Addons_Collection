-------------------------------------------------------------------------------
--                               CritLine                        	     --
--                               English Localization                        --
-------------------------------------------------------------------------------




function CritLine_LocalizeEN()
	
	NORMAL_HIT_TEXT = "Normal Hit";
	NORMAL_TEXT = "Normal";
	CRIT_TEXT = "Crit";

	CRITLINE_OPTION_SPLASH_TEXT = "Display new high record splash screen";
	CRITLINE_OPTION_SPLASHCRIT_TEXT = "Display critically splash screen";
	CRITLINE_OPTION_PLAYSOUNDS_TEXT = "Play Sounds.";
	CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "Do not count combatdamage.";
	CRITLINE_OPTION_SCREENCAP_TEXT = "Take screen capture on new records.";
	CRITLINE_OPTION_LVLADJ_TEXT = "Use Level Adjustment.";
	CRITLINE_OPTION_FILTER_HEALING_TEXT = "Do not count healing spells.";
	CRITLINE_OPTION_RESET_TEXTALL = "Reset All Characters.";
	CRITLINE_OPTION_RESET_TEXT = "Reset this Character.";
	CRITLINE_OPTION_TOOLTIP_TEXT = "Show ToolTipSummary";
		
	CRITLINE_NEW_RECORD_MSG = "New %s Record!"; --e.g. New Ambush Record!

	COMBAT_HIT = "You hit (.+) for (%d+)."; --COMBATHITSELFOTHER
	COMBAT_CRIT	= "You crit (.+) for (%d+).";
			
	SPELL_HIT = "Your (.+) hits (.+) for (%d+).";
	SPELL_HIT2 = "empty";
	SPELL_HIT3 = "empty";
	SPELL_CRIT = "Your (.+) crits (.+) for (%d+).";
	SPELL_CRIT2 = "empty";
	SPELL_CRIT3 = "empty";

	SPELL_HIT_HEAL = "Your (.+) heals (.+) for (%d+).";
	SPELL_CRIT_HEAL = "Your (.+) critically heals (.+) for (%d+).";
	
	HEALINGPOTIONS = "Healing Potion";
end