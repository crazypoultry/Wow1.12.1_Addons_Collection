-- hshh
if (GetLocale() == "zhCN") then
-- ============================================================================
-- Simplified Chinese
-- ============================================================================
	TTST_GENERAL				= "常规设置";
	TTST_DRUID					= "德鲁伊";
	TTST_HUNTER					= "猎人";
	TTST_HUNTER_PET				= "猎人宠物";
	TTST_MAGE					= "法师";
	TTST_PALADIN				= "圣骑士";
	TTST_PRIEST					= "牧师";
	TTST_ROGUE					= "盗贼";
	TTST_SHAMAN					= "萨满祭司";
	TTST_WARLOCK				= "术士";
	TTST_WARLOCK_PET			= "术士宠物";
	TTST_WARRIOR				= "战士";

	TTST_AlphabeticalClassList =
		{
		TTST_GENERAL,
		TTST_DRUID,
		TTST_HUNTER,
		TTST_HUNTER_PET,
		TTST_MAGE,
		TTST_PALADIN,
		TTST_PRIEST,
		TTST_ROGUE,
		TTST_SHAMAN,
		TTST_WARLOCK,
		TTST_WARLOCK_PET,
		TTST_WARRIOR,
		};

-- ============================================================================
-- Localizable strings used in the settings window.
-- ============================================================================

	TTST_SETTINGS_COLORS						= "颜色";
	TTST_SETTINGS_HELP							= "帮助";
	TTST_SETTINGS_SETTINGS						= "设置";

	-- Strings appearing in the general settings window.
	TTST_SETTINGS_GENERAL_DISABLEAUTOMESSAGES	= "禁止自动发送提示信息";
	TTST_SETTINGS_GENERAL_ENABLED				= "TTSpellTimer 启用";
	TTST_SETTINGS_GENERAL_HIDEBACKGROUND		= "隐藏计时窗口背景";
	TTST_SETTINGS_GENERAL_MOVE					= "移动计时窗口";
	TTST_SETTINGS_GENERAL_MOVEDONE				= "完成";
	TTST_SETTINGS_GENERAL_SCALING				= "TTSpellTimer缩放";

	-- Strings appearing in the settings window.
	TTST_SETTINGS_HEADER						= "TTSpellTimer设置";
	TTST_SETTINGS_SPELLLIST_HEIGHT				= 20;

	TTST_SETTINGS_OPTIONS_ENABLED				= "计时启用";
	TTST_SETTINGS_OPTIONS_ENABLED_CHAT_MSG		= "自动发送提示信息启用";

	TTST_SETTINGS_OPTIONS_CHAT_HEADER			= "自动发送提示信息";
	TTST_SETTINGS_OPTIONS_CHAT_PRECAST			= "准备施法提示";
	TTST_SETTINGS_OPTIONS_CHAT					= "完成施法提示";
	TTST_SETTINGS_OPTIONS_EMOTE					= "表情";
	TTST_SETTINGS_OPTIONS_PARTY					= "队伍";
	TTST_SETTINGS_OPTIONS_RAID					= "团队";
	TTST_SETTINGS_OPTIONS_SAY					= "说";
	TTST_SETTINGS_OPTIONS_YELL					= "喊";
	TTST_SETTINGS_OPTIONS_CHAT_DISABLED			= "(由常规设置中禁用)";

	TTST_SETTINGS_OPTIONS_DISPLAY_HEADER		= "显示";
	TTST_SETTINGS_OPTIONS_SPELLNAME				= "显示法术名称";
	TTST_SETTINGS_OPTIONS_TARGETNAME			= "显示目标名称";
	TTST_SETTINGS_OPTIONS_AUTOREMOVE			= "退出战斗后移除该计时器";

-- ============================================================================
-- Localizable spell ranks.
-- ============================================================================

	TTST_SPELL_RANK_DEFAULT				= "等级 *";
	TTST_SPELL_RANK_1					= "等级 1";
	TTST_SPELL_RANK_2					= "等级 2";
	TTST_SPELL_RANK_3					= "等级 3";
	TTST_SPELL_RANK_4					= "等级 4";
	TTST_SPELL_RANK_5					= "等级 5";
	TTST_SPELL_RANK_6					= "等级 6";
	TTST_SPELL_RANK_7					= "等级 7";
	TTST_SPELL_RANK_8					= "等级 8";
	TTST_SPELL_RANK_9					= "等级 9";
	TTST_SPELL_RANK_10					= "等级 10";

-- ============================================================================
-- Localizable talent names.
-- ============================================================================

	TTST_SPELL_TALENT_BOOMING_VOICE					= "震耳嗓音";
	TTST_SPELL_TALENT_IMPROVED_DISARM				= "强化缴械";
	TTST_SPELL_TALENT_IMPROVED_GARROTE				= "强化绞喉";
	TTST_SPELL_TALENT_IMPROVED_GOUGE				= "强化凿击";
	TTST_SPELL_TALENT_IMPROVED_POWER_WORD_SHIELD	= "强化真言术：盾";
	TTST_SPELL_TALENT_IMPROVED_SHADOW_WORD_PAIN		= "强化暗言术：痛";
	TTST_SPELL_TALENT_PERMAFROST					= "极寒冰霜";

-- ============================================================================
-- Localizable spell names.
-- ============================================================================

	-- Druid
	TTST_SPELL_ABOLISH_POISON			= "驱毒术";
	TTST_SPELL_CHALLENGING_ROAR			= "挑战咆哮";
	TTST_SPELL_DEMORALIZING_ROAR		= "挫志咆哮";
	TTST_SPELL_ENTANGLING_ROOTS			= "纠缠根须";
	TTST_SPELL_FAERIE_FIRE				= "精灵之火";
	TTST_SPELL_FAERIE_FIRE_FERAL		= "精灵之火（野性）";
	TTST_SPELL_HIBERNATE				= "休眠";
	TTST_SPELL_INNERVATE				= "激活";
	TTST_SPELL_INSECT_SWARM				= "虫群";
	TTST_SPELL_MOONFIRE					= "月火术";
	TTST_SPELL_RAKE						= "扫击";
	TTST_SPELL_REBIRTH					= "复生";
	TTST_SPELL_REGROWTH					= "愈合";
	TTST_SPELL_REJUVENATION				= "回春术";
	TTST_SPELL_RIP						= "撕扯";
	TTST_SPELL_SOOTHE_ANIMAL			= "安抚动物";

	-- Hunter
	TTST_SPELL_CONCUSSIVE_SHOT			= "震荡射击";
	TTST_SPELL_COUNTERATTACK			= "反击";
	TTST_SPELL_HUNTERS_MARK				= "猎人印记";
	TTST_SPELL_SCARE_BEAST				= "恐吓野兽";
	TTST_SPELL_SCATTER_SHOT				= "驱散射击";
	TTST_SPELL_SCORPID_STING			= "毒蝎钉刺";
	TTST_SPELL_SERPENT_STING			= "毒蛇钉刺";
	TTST_SPELL_VIPER_STING				= "蝰蛇钉刺";
	TTST_SPELL_WING_CLIP				= "摔绊";
	TTST_SPELL_WYVERN_STING				= "翼龙钉刺";

	-- Hunter Pet
	TTST_SPELL_PET_BESTIAL_WRATH		= "狂野怒火";
	TTST_SPELL_PET_INTIMIDATION			= "胁迫";
	TTST_SPELL_PET_SCREECH				= "狂怒释放";
	TTST_SPELL_PET_SCORPID_POISON		= "蝎毒";

	-- Mage
	TTST_SPELL_BLAST_WAVE				= "冲击波";
	TTST_SPELL_CONE_OF_COLD				= "冰锥术";
	TTST_SPELL_COUNTERSPELL				= "法术反制";
	TTST_SPELL_FIREBALL					= "火球术";
	TTST_SPELL_FLAMESTRIKE				= "烈焰风暴";
	TTST_SPELL_FROST_NOVA				= "冰霜新星";
	TTST_SPELL_FROSTBOLT				= "寒冰箭";
	TTST_SPELL_POLYMORPH				= "变形术";
	TTST_SPELL_PYROBLAST				= "炎爆术";

	-- Paladin
	TTST_SPELL_CONSECRATION				= "奉献";
	TTST_SPELL_HAMMER_OF_JUSTICE		= "制裁之锤";
	TTST_SPELL_JUDGEMENT				= "审判";
	TTST_SPELL_REPENTANCE				= "忏悔";
	TTST_SPELL_SEAL_OF_COMMAND			= "命令圣印";
	TTST_SPELL_SEAL_OF_FURY				= "愤怒圣印";
	TTST_SPELL_SEAL_OF_JUSTICE			= "公正圣印";
	TTST_SPELL_SEAL_OF_LIGHT			= "光明圣印";
	TTST_SPELL_SEAL_OF_RIGHTEOUSNESS	= "正义圣印";
	TTST_SPELL_SEAL_OF_THE_CRUSDAER		= "十字军圣印";
	TTST_SPELL_SEAL_OF_WISDOM			= "智慧圣印";
	TTST_SPELL_TURN_UNDEAD				= "超度亡灵";

	-- Priest
	TTST_SPELL_ABOLISH_DISEASE			= "驱除疾病";
	TTST_SPELL_DEVOURING_PLAGUE			= "暗影之波";
	TTST_SPELL_HEX_OF_WEAKNESS			= "虚弱妖术";
	TTST_SPELL_HOLY_FIRE				= "神圣之火";
	TTST_SPELL_MIND_CONTROL				= "精神控制";
	TTST_SPELL_MIND_SOOTHE				= "安抚心灵";
	TTST_SPELL_POWER_WORD_SHIELD		= "真言术：盾";
	TTST_SPELL_PSYCHIC_SCREAM			= "心灵尖啸";
	TTST_SPELL_RENEW				 	= "恢复";
	TTST_SPELL_SHACKLE_UNDEAD			= "束缚亡灵";
	TTST_SPELL_SHADOW_WORD_PAIN			= "暗言术：痛";
	TTST_SPELL_SILENCE					= "沉默";
	TTST_SPELL_VAMPIRIC_EMBRACE			= "吸血鬼的拥抱";

	-- Rogue
	TTST_SPELL_BLIND					= "致盲";
	TTST_SPELL_CHEAP_SHOT				= "偷袭";
	TTST_SPELL_DISTRACT					= "扰乱";
	TTST_SPELL_EXPOSE_ARMOR				= "破甲";
	TTST_SPELL_GARROTE					= "绞喉";
	TTST_SPELL_GOUGE					= "凿击";
	TTST_SPELL_HEMORRHAGE				= "出血";
	TTST_SPELL_KICK						= "脚踢";
	TTST_SPELL_KIDNEY_SHOT				= "肾击";
	TTST_SPELL_PREMEDITATION			= "预谋";
	TTST_SPELL_RIPOSTE					= "还击";
	TTST_SPELL_RUPTURE					= "割裂";
	TTST_SPELL_SAP						= "闷棍";

	-- Shaman
	TTST_SPELL_DISEASE_CLEANSING_TOTEM	= "祛病图腾";
	TTST_SPELL_EARTHBIND_TOTEM			= "地缚图腾";
	TTST_SPELL_EARTH_SHOCK				= "地震术";
	TTST_SPELL_FIRE_NOVA_TOTEM			= "火焰新星图腾";
	TTST_SPELL_FIRE_RESISTANCE_TOTEM	= "抗火图腾";
	TTST_SPELL_FLAME_SHOCK				= "烈焰震击";
	TTST_SPELL_FLAMETONGUE_TOTEM		= "火舌图腾";
	TTST_SPELL_FROST_RESISTANCE_TOTEM	= "抗寒图腾";
	TTST_SPELL_FROST_SHOCK				= "冰霜震击";
	TTST_SPELL_GRACE_OF_AIR_TOTEM		= "风之优雅图腾";
	TTST_SPELL_GROUNDING_TOTEM			= "根基图腾";
	TTST_SPELL_HEALING_STREAM_TOTEM		= "治疗之泉图腾";
	TTST_SPELL_MAGMA_TOTEM				= "熔岩图腾";
	TTST_SPELL_MANA_SPRING_TOTEM		= "法力之泉图腾";
	TTST_SPELL_MANA_TIDE_TOTEM			= "法力之潮图腾";
	TTST_SPELL_NATURE_RESISTANCE_TOTEM	= "自然抗性图腾";
	TTST_SPELL_POISON_CLEANSING_TOTEM	= "清毒图腾";
	TTST_SPELL_SEARING_TOTEM			= "灼热图腾";
	TTST_SPELL_SENTRY_TOTEM				= "岗哨图腾";
	TTST_SPELL_STONECLAW_TOTEM			= "石爪图腾";
	TTST_SPELL_STONESKIN_TOTEM			= "石肤图腾";
	TTST_SPELL_STRENGTH_OF_EARTH_TOTEM	= "大地之力图腾";
	TTST_SPELL_TRANQUIL_AIR_TOTEM		= "宁静之风图腾";
	TTST_SPELL_TREMOR_TOTEM				= "战栗图腾";
	TTST_SPELL_WINDFURY_TOTEM			= "风怒图腾";
	TTST_SPELL_WINDWALL_TOTEM			= "风墙图腾";

	-- Warlock
	TTST_SPELL_BANISH					= "放逐术";
	TTST_SPELL_CORRUPTION				= "腐蚀";
	TTST_SPELL_CURSE_OF_AGONY			= "痛苦诅咒";
	TTST_SPELL_CURSE_OF_DOOM			= "厄运诅咒";
	TTST_SPELL_CURSE_OF_EXHAUSTION		= "疲劳诅咒";
	TTST_SPELL_CURSE_OF_RECKLESSNESS	= "鲁莽诅咒";
	TTST_SPELL_CURSE_OF_SHADOW			= "暗影诅咒";
	TTST_SPELL_CURSE_OF_THE_ELEMENTS	= "元素诅咒";
	TTST_SPELL_CURSE_OF_TONGUES			= "语言诅咒";
	TTST_SPELL_CURSE_OF_WEAKNESS		= "虛弱诅咒";
	TTST_SPELL_DEATH_COIL				= "死亡缠绕";
	TTST_SPELL_ENSLAVE_DEMON			= "奴役恶魔";
	TTST_SPELL_FEAR						= "恐惧术";
	TTST_SPELL_HELLFIRE					= "地狱烈焰";
	TTST_SPELL_HOWL_OF_TERROR			= "恐惧嚎叫";
	TTST_SPELL_IMMOLATE					= "献祭";
	TTST_SPELL_INFERNO					= "地狱火";
	TTST_SPELL_RITUAL_OF_DOOM			= "召唤末日守卫";
	TTST_SPELL_RITUAL_OF_SUMMONING		= "召唤仪式";
	TTST_SPELL_SIPHON_LIFE				= "生命虹吸";
	TTST_SPELL_SOULSTONE_RESURRECTION	= "灵魂石复活";

	-- Warlock Pet
	TTST_SPELL_PET_SEDUCTION			= "诱惑";
	TTST_SPELL_PET_SPELL_LOCK			= "法术封锁";

	-- Warrior
	TTST_SPELL_BERSERKER_RAGE			= "狂暴之怒";
	TTST_SPELL_CHALLENGING_SHOUT		= "挑战怒吼";
	TTST_SPELL_CONCUSSION_BLOW			= "震荡猛击";
	TTST_SPELL_DEMORALIZING_SHOUT		= "挫志怒吼";
	TTST_SPELL_DISARM					= "缴械";
	TTST_SPELL_HAMSTRING				= "断筋";
	TTST_SPELL_INTIMIDATING_SHOUT		= "破胆怒吼";
	TTST_SPELL_MOCKING_BLOW				= "惩戒痛击";
	TTST_SPELL_MORTAL_STRIKE			= "致死打击";
	TTST_SPELL_PIERCING_HOWL			= "刺耳怒吼";
	TTST_SPELL_PUMMEL					= "拳击";
	TTST_SPELL_REND						= "撕裂";
	TTST_SPELL_SHIELD_BASH				= "盾击";
	TTST_SPELL_SUNDER_ARMOR				= "破甲攻击";
	TTST_SPELL_THUNDER_CLAP				= "雷霆一击";
end
