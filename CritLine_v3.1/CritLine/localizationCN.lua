-------------------------------------------------------------------------------
--                               CritLine                        	     --
--                               English Localization                        --
-------------------------------------------------------------------------------




function CritLine_LocalizeCN()
	
	NORMAL_HIT_TEXT = "普通攻击";
	NORMAL_TEXT = "普通";
	CRIT_TEXT = "致命一击";

	CRITLINE_OPTION_SPLASH_TEXT = "显示产生新纪录的字样";
	CRITLINE_OPTION_SPLASHCRIT_TEXT = "显示重击特效";
	CRITLINE_OPTION_PLAYSOUNDS_TEXT = "播放声音.";
	CRITLINE_OPTION_FILTER_ATTACKS_TEXT = "不统计战斗伤害.";
	CRITLINE_OPTION_SCREENCAP_TEXT = "打破纪录时截图.";
	CRITLINE_OPTION_LVLADJ_TEXT = "使用级别矫正.";
	CRITLINE_OPTION_FILTER_HEALING_TEXT = "不计算治疗法术.";
	CRITLINE_OPTION_RESET_TEXTALL = "重置所有角色纪录.";
	CRITLINE_OPTION_RESET_TEXT = "重置这个角色的纪录.";
	CRITLINE_OPTION_TOOLTIP_TEXT = "Show ToolTipSummary";
		
	CRITLINE_NEW_RECORD_MSG = "新的 %s 记录!"; --e.g. New Ambush Record!

	COMBAT_HIT = "你击中(.+)造成(%d+)点伤害"; --COMBATHITSELFOTHER
	COMBAT_CRIT	= "你对(.+)造成(%d+)的致命一击伤害";
			
	SPELL_HIT = "你的(.+)击中(.+)造成(%d+)点伤害";
	SPELL_HIT2 = "你的(.+)击中(.+)造成(%d+)点(.+)伤害";
	SPELL_HIT3 = "empty";
	SPELL_CRIT = "你的(.+)对(.+)造成(%d+)的致命一击伤害";
	SPELL_CRIT2 = "你的(.+)致命一击对(.+)造成(%d+)点(.+)伤害";
	SPELL_CRIT3 = "empty";

	SPELL_HIT_HEAL = "你的(.+)治疗了(.+)(%d+)点生命值.";
	SPELL_CRIT_HEAL = "你的(.+)对(.+)产生极效治疗效果，恢复了(%d+)点生命值.";
	
	HEALINGPOTIONS = "治疗药水";
end