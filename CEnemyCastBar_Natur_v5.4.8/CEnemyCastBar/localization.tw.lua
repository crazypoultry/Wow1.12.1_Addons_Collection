-- CEnemyCastBar Chinese Traditional localization file
-- Maintained by: Kuraki, Suzuna
-- Last updated:
-- Revision History:
--    09/01/2006  * 5.1.7 zhTW support init
--    09/07/2006  * 5.1.7 zhTW support test 1
--    09/11/2006  * 5.1.7 zhTW support test 2
--    09/18/2006  * 5.1.7 zhTW support final
--    09/25/2006  * 5.2.7 zhTW support init
--    09/26/2006  * 5.2.7 zhTW support test 1
--    09/29/2006  * 5.3.0 zhTW support
--    10/03/2006  * 5.3.0b zhTW support

if ( GetLocale() == "zhTW" ) then

    -- Internally Spell Name
    CECB_SPELL_BLOOD_SIPHON = "血液虹吸";
    CECB_SPELL_FIRST_LOCUST_SWARM = "第一次蝗蟲風暴";
    CECB_SPRLL_DISRUPTING_SHOUT = "混亂怒吼";
    CECB_SPELL_DARK_GLARE = "黑暗閃耀";
    CECB_SPELL_STUN_DR    = "擊暈遞減";
    CECB_SPELL_NEF_CALLS  = "奈法利安點名";
    CECB_SPELL_MOB_SPAWN  = "怪物出生";
    CECB_SPELL_LANDING    = "降落" ;
    CECB_SPELL_SUBMERGE   = "暫時消失";
    CECB_SPELL_KNOCKBACK  = "群體擊退";
    CECB_SPELL_SONS_OF_FLAME = "烈焰之子";
    CECB_SPELL_MOB_SPAWN_45SEC = "怪物出生 (45秒)";
    CECB_SPELL_ENRAGED_MODE1 = "激怒模式 ";
    CECB_SPELL_ENRAGED_MODE2 = "激怒模式";
    CECB_SPELL_ENRAGE = "激怒";
    CECB_SPELL_BECOME_ENRAGED = "變得狂暴!";
    CECB_SPELL_15SEC_DOOM_CD = "15秒末日CD!";
    CECB_SPELL_FIRST_INVITABLE_DOOM = "第一次無可避免的末日";
    CECB_SPELL_COMES_DOWN = "下來了";
    CECB_SPELL_FIRST_TELEPORT = "第一次傳送";
    CECB_SPELL_ON_PLATFORM = "上台";
    CECB_SPELL_TELEPORT_CD = "傳送 CD";
    CECB_SPELL_TWIN_TELEPORT = "雙子傳送";
    CECB_SPELL_FIRST_DARK_GLARE = "第一次黑暗閃耀";
    CECB_SPELL_DECIMATE = "屠殺";
    CECB_SPELL_WEB_SPRAY = "撒網";
    CECB_SPELL_WEAKENED = "變虛弱!";
    CECB_SPELL_ENTER_ENRAGED_MODE = "進入激怒模式";
    CECB_SPELL_BERSERK_MODE = "狂暴模式";
    CECB_SPELL_ENTER_BERSERK_MODE = "進入狂暴模式";
    CECB_SPELL_UNTIL_STONEFORM = "石化狀態";
    CECB_SPELL_FIRST_WINGBUFFET = "第一次龍翼打擊";
    CECB_SPELL_FRENZY_CD = "狂亂 (CD)";
    CECB_SPELL_KILLING_FRENZY = "殺戮狂暴";
    CECB_SPELL_BOSS_INCOMING = "Boss 來了!";
    CECB_SPELL_DEEP_BREATH = "深呼吸";
    CECB_SPELL_POSSIBLE_OURO_SUBMERGE = "可能發生的奧羅潛水";

    CECB_SPELL_1ST_TRAINEES_INCOME = "第一次小兵到來";
    CECB_SPELL_1ST_DK_INCOME = "第一次死期到來";
    CECB_SPELL_1ST_RIDER_INCOME = "第一次騎兵到來";
    CECB_SPELL_TRAINEES_INCOME = "小兵到來";
    CECB_SPELL_DK_INCOME = "死亡騎士到來";
    CECB_SPELL_RIDER_INCOME = "騎兵到來";

    CECB_SPELL_SMALL_EYE_P1 = "小眼睛階段一";
    CECB_SPELL_SMALL_EYE_P2 = "小眼睛階段二";
    CECB_SPELL_FIRST_SMALL_EYE_P2 = "第一次小眼睛階段二";
    CECB_SPELL_AFTER_WEAKENED_EYES = "虛弱之後的眼睛";

    CEnemyCastBar_Spells = {

        -- IMPORTANT: Maybe some spells which cause debuffs have to be moved to CEnemyCastBar_Afflicitions to be shown
        -- "t=x" defines the normal length of the castbar. "d=x" will add a cooldown timer for spells with a casttime and for gains.
        -- "g=0" prevents a bar if a player gains this spell. "g=x" shows a bar of x seconds instead of "t=x" if it's a gain.
        -- "i=x" shows a bar of x seconds additional to "t" (everytime)

        -- All Classes
            -- General
        ["爐石"] = {t=10.0, icontex="INV_Misc_Rune_01"};

            -- Trinkets & Racials
        ["脆弱護甲"] =              {t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
        ["能量無常"] =              {t=20.0, d=120, icontex="Spell_Lightning_LightningBolt01"}; -- gain
        ["充沛之力"] =              {t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
        ["短暫強力"] =              {t=15.0, d=90, icontex="Spell_Holy_MindVision"}; -- gain
        ["祕法強化"] =              {t=15.0, d=180, icontex="Spell_Nature_Lightning"}; -- gain
        ["大規模殺傷性魔法"] =      {t=20.0, d=180, icontex="Spell_Fire_WindsofWoe"}; -- gain
        ["祕法潛能"] =              {t=20.0, d=180, icontex="Spell_Arcane_StarFire"}; -- gain
        ["能量護盾"] =              {t=20.0, d=180, icontex="Spell_Nature_CallStorm"}; -- gain
        ["輝煌之光"] =              {t=20.0, d=180, icontex="Spell_Holy_MindVision"}; -- gain
        ["亡靈意志"] =              {t=5.0, d=120, icontex="Spell_Shadow_RaiseDead"}; -- gain
        ["感知"] =                  {t=20.0, d=180, icontex="Spell_Nature_Sleep"}; -- gain
        ["瑪爾里的思想加速"] =      {t=30.0, d=180, icontex="INV_ZulGurubTrinket"}; -- gain
        ["戰爭踐踏"] =              {t=0.5, d=120, icontex="Ability_WarStomp"};
        ["石像形態"] =              {t=8.0, d=180, icontex="Spell_Shadow_UnholyStrength"};

        ["大地之擊"] =              {t=20.0, d=120, icontex="Spell_Nature_AbolishMagic"}; -- gain
        ["生命賜福"] =              {t=20.0, d=300, icontex="INV_Misc_Gem_Pearl_05"}; -- gain
        ["自然之盟"] =              {t=20.0, d=300, icontex="Spell_Nature_SpiritArmor"}; -- gain

            -- Engineering
        --["冰霜反射器"] =            {t=5.0, d=300.0, icontex="Spell_Frost_FrostWard"}; -- gain
        --["暗影反射器"] =            {t=5.0, d=300.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
        --["火焰反射器"] =            {t=5.0, d=300.0, icontex="Spell_Fire_SealOfFire"}; -- gain
        ["寒冰偏斜器"] =            {t=5.0, d=300.0, icontex="Spell_Frost_FrostWard"}; -- gain
        ["快速暗影反射器"] =        {t=5.0, d=300.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
        ["高輻射烈焰反射器"] =      {t=5.0, d=300.0, icontex="Spell_Fire_SealOfFire"}; -- gain

            -- First Aid
        ["急救"] =              {t=8.0, d=60, icontex="Spell_Holy_Heal"}; -- gain
        ["亞麻繃帶"] =          {t=3.0, icontex="INV_Misc_Bandage_15"};
        ["厚亞麻繃帶"] =        {t=3.0, icontex="INV_Misc_Bandage_18"};
        ["絨線繃帶"] =          {t=3.0, icontex="INV_Misc_Bandage_14"};
        ["厚絨線繃帶"] =        {t=3.0, icontex="INV_Misc_Bandage_17"};
        ["絲質繃帶"] =          {t=3.0, icontex="INV_Misc_Bandage_01"};
        ["厚絲質繃帶"] =        {t=3.0, icontex="INV_Misc_Bandage_02"};
        ["魔紋繃帶"] =          {t=3.0, icontex="INV_Misc_Bandage_19"};
        ["厚魔紋繃帶"] =        {t=3.0, icontex="INV_Misc_Bandage_20"};
        ["符文布繃帶"] =        {t=3.0, icontex="INV_Misc_Bandage_11"};
        ["厚符文布繃帶"] =      {t=3.0, icontex="INV_Misc_Bandage_12"};

        -- Druid
        ["治療之觸"] =    {t=3.0, icontex="Spell_Nature_HealingTouch"};
        ["癒合"] =        {t=2.0, g=21.0, icontex="Spell_Nature_ResistNature"};
        ["複生"] =        {t=2.0, d=1800.0, icontex="Spell_Nature_Reincarnation"};
        ["星火術"] =      {t=3.0, icontex="Spell_Arcane_StarFire"};
        ["憤怒"] =        {t=1.5, icontex="Spell_Nature_AbolishMagic"};
        ["糾纏根鬚"] =    {t=1.5, icontex="Spell_Nature_StrangleVines"};
        ["急奔"] =        {t=15.0, d=300.0, icontex="Ability_Druid_Dash"}; -- gain
        ["休眠"] =        {t=1.5, icontex="Spell_Nature_Sleep"};
        ["安撫動物"] =    {t=1.5, icontex="Ability_Hunter_BeastSoothe"};
        ["樹皮術"] =      {t=15.0, d=60, icontex="Spell_Nature_StoneClawTotem"}; -- gain
        ["啟動"] =        {t=20.0, icontex="Spell_Nature_Lightning"}; -- gain
        ["傳送：月光林地"] =   {t=10.0, icontex="Spell_Arcane_TeleportMoonglade"};
        ["猛虎之怒"] =    {t=6.0, icontex="Ability_Mount_JungleTiger"}; -- gain
        ["狂暴回復"] =    {t=10.0, d=180.0, icontex="Ability_BullRush"}; -- gain
        ["回春術"] =      {t=12.0, icontex="Spell_Nature_Rejuvenation"}; -- gain
        ["驅毒術"] =      {t=8.0, icontex="Spell_Nature_NullifyPoison_02"}; -- gain
        ["寧靜"] =        {t=10.0, d=300.0, icontex="Spell_Nature_Tranquility"};
	["自然之握"] = 		{t=45, d=60, icontex="Spell_Nature_NaturesWrath"}; -- talent gain
	--["颶風術"] = {t=1.5, icontex=""};
	--["Lifebloom"] = {t=7, icontex=""}; -- gain

        -- Hunter
        ["瞄準射擊"] = {t=3.0, d=6.0, icontex="INV_Spear_07"};
        ["恐嚇野獸"] = {t=1.0, d=30.0, icontex="Ability_Druid_Cower"};
        ["亂射"] = {t=6.0, d=60.0, icontex="Ability_Marksmanship"};
        ["解散寵物"] = {t=5.0, icontex="Spell_Nature_SpiritWolf"};
        ["復活寵物"] = {t=10.0, icontex="Ability_Hunter_BeastSoothe"};
        ["野獸之眼"] = {t=2.0, icontex="Ability_EyeOfTheOwl"};
        ["急速射擊"] = {t=15.0, d=300.0, icontex="Ability_Hunter_RunningShot"}; -- gain
        ["威懾"] = {t=10, d=300.0, icontex="Ability_Whirlwind"}; -- gain
        ["多重射擊"] = {d=10.0, icontex="Ability_UpgradeMoonGlaive"};
	["狂野怒火"] = {t=18, d=120.0, icontex="Ability_Druid_FerociousBite"}; -- Pet gain
	--["The Beast Within"] = {t=18, d=120, icontex=""}; -- gain, Talent


        -- Mage
        ["寒冰箭"] = {t=2.5, icontex="Spell_Frost_FrostBolt02"};
        ["火球術"] = {t=3.0, icontex="Spell_Fire_FlameBolt"};
        ["造水術"] = {t=3.0, icontex="INV_Drink_18"};
        ["造食術"] = {t=3.0, icontex="INV_Misc_Food_33"};
        ["製造魔法紅寶石"] = {t=3.0, icontex="INV_Misc_Gem_Ruby_01"};
        ["製造魔法黃水晶"] = {t=3.0, icontex="INV_Misc_Gem_Opal_01"};
        ["製造魔法翡翠"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_02"};
        ["製造魔法瑪瑙"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_01"};
        ["變形術"] = {t=1.5, icontex="Spell_Nature_Polymorph"};
        ["變豬術"] = {t=1.5, icontex="Spell_Magic_PolymorphPig"};
        ["變龜術"] = {t=1.5, icontex="Ability_Hunter_Pet_Turtle"};
        ["炎爆術"] = {t=6.0, icontex="Spell_Fire_Fireball02"};
        ["灼燒"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
        ["烈焰風暴"] = {t=3.0, r="死爪地卜師", a=2.5, icontex="Spell_Fire_SelfDestruct"};
        ["緩落術"] = {t=30.0, icontex="Spell_Magic_FeatherFall"}; -- gain
        ["傳送：達納蘇斯"] = {t=10.0, icontex="Spell_Arcane_PortalDarnassus"};
        ["傳送：雷霆崖"] = {t=10.0, icontex="Spell_Arcane_PortalThunderBluff"};
        ["傳送：鐵爐堡"] = {t=10.0, icontex="Spell_Arcane_PortalIronForge"};
        ["傳送：奧格瑪"] = {t=10.0, icontex="Spell_Arcane_PortalOrgrimmar"};
        ["傳送：暴風城"] = {t=10.0, icontex="Spell_Arcane_PortalStormWind"};
        ["傳送：幽暗城"] = {t=10.0, icontex="Spell_Arcane_PortalUnderCity"};
        ["傳送門：達納蘇斯"] = {t=10.0, icontex="Spell_Arcane_TeleportDarnassus"};
        ["傳送門：雷霆崖"] = {t=10.0, icontex="Spell_Arcane_TeleportThunderBluff"};
        ["傳送門：鐵爐堡"] = {t=10.0, icontex="Spell_Arcane_TeleportIronForge"};
        ["傳送門：奧格瑪"] = {t=10.0, icontex="Spell_Arcane_TeleportOrgrimmar"};
        ["傳送門：暴風城"] = {t=10.0, icontex="Spell_Arcane_TeleportStormWind"};
        ["傳送門：幽暗城"] = {t=10.0, icontex="Spell_Arcane_TeleportUnderCity"};
        ["防護火焰結界"] = {t=30.0, icontex="Spell_Fire_FireArmor"}; -- gain
        ["防護冰霜結界"] = {t=30.0, icontex="Spell_Frost_FrostWard"}; -- gain
        ["喚醒"] = {t=8.0, icontex="Spell_Nature_Purge"}; -- gain
        ["寒冰屏障"] = {t=10.0, d=300.0, icontex="Spell_Frost_Frost"}; -- gain
        ["寒冰護體"] = {d=30.0, icontex="Spell_Ice_Lament"};
        ["閃現術"] = {d=15.0, icontex="Spell_Arcane_Blink"};
		    ["隱形術"] = {t=8, d=300, icontex=""}; -- gain
		--["Ice Lance"] = {t=1.5, icontex=""};
		--["Waterbolt"] = {t=2.5, icontex=""}; -- Mage Talent ('Pet' Spell)


        -- Paladin
        ["聖光術"] = {t=2.5, icontex="Spell_Holy_HolyBolt"};
        ["聖光閃現"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
        ["召喚戰馬"] = {t=3.0, g=0.0, icontex="Ability_Mount_Charger"};
        ["召喚軍馬"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
        ["憤怒之錘"] = {t=1.0, d=6.0, icontex="Ability_ThunderClap"};
        ["神聖憤怒"] = {t=2.0, d=60.0, icontex="Spell_Holy_Excorcism"};
        ["超渡不死生物"] = {t=1.5, d=30.0, icontex="Spell_Holy_TurnUndead"};
        ["救贖"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
        ["聖佑術"] = {t=8.0, d=300.0, icontex="Spell_Holy_Restoration"}; -- gain
        ["聖盾術"] = {t=12.0, d=300.0, icontex="Spell_Holy_DivineIntervention"}; -- gain
        ["自由祝福"] = {t=16.0, icontex="Spell_Holy_SealOfValor"}; -- gain
        ["保護祝福"] = {t=10.0, d=300.0, icontex="Spell_Holy_SealOfProtection"}; -- gain
        ["犧牲祝福"] = {t=30.0, icontex="Spell_Holy_SealOfSacrifice"}; -- gain
        ["復仇"] = {t=8.0, icontex="Ability_Racial_Avatar"}; -- gain, Talent
		--["Avenging Wrath"] = {t=20, d=180, icontex=""}; -- gain
		--["Divine Illumination"] = {t=10, d=180, icontex=""}; -- gain, Talent
		--["Avenger's Shild"] = {t=1, d=30, icontex=""}; -- Talent

        -- Priest
        ["強效治療術"] = {t=2.5, g=15, icontex="Spell_Holy_GreaterHeal"};
        ["治療術"] = {t=2.5, icontex="Spell_Holy_Heal"};
        ["快速治療"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
        ["復活術"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
        ["懲擊"] = {t=2.0, icontex="Spell_Holy_HolySmite"};
        ["心靈震爆"] = {t=1.5, d=8.0, icontex="Spell_Shadow_UnholyFrenzy"};
        ["精神控制"] = {t=3.0, g=0.0, icontex="Spell_Shadow_ShadowWordDominate"};
        ["法力燃燒"] = {t=3.0, icontex="Spell_Shadow_ManaBurn"};
        ["神聖之火"] = {t=3.0, icontex="Spell_Holy_SearingLight"};
        ["安撫心靈"] = {t=1.5, icontex="Spell_Holy_MindSooth"};
        ["治療禱言"] = {t=3.0, icontex="Spell_Holy_PrayerOfHealing02"};
        ["束縛不死生物"] = {t=1.5, icontex="Spell_Nature_Slow"};
        ["漸隱術"] = {t=10.0, d=30.0, icontex="Spell_Magic_LesserInvisibilty"}; -- gain
        ["恢復"] = {t=15.0, icontex="Spell_Holy_Renew"}; -- gain
        ["驅除疾病"] = {t=20.0, icontex="Spell_Nature_NullifyDisease"}; -- gain
        ["回饋"] = {t=15.0, icontex="Spell_Shadow_RitualOfSacrifice"}; -- gain
        ["靈感"] = {t=15.0, icontex="INV_Shield_06"}; -- gain (target), Talent
        ["注入能量"] = {t=15.0, d=180, icontex="Spell_Holy_PowerInfusion"}; -- gain, Talent
        ["專注施法"] = {t=6.0, icontex="Spell_Arcane_Blink"}; -- gain, Talent
        ["真言術：盾"] = {t=30, d=15.0, icontex="Spell_Holy_PowerWordShield"};
        ["信仰護盾"] = {t=30.0, icontex="Spell_Holy_BlessingOfProtection"}; -- gain, Priest Tier 3 [Vestments of Faith] 4/9 Proc
		["Inner Focus"] = {d=180, icontex="Spell_Frost_WindWalkOn"}; -- gain, Talent
		--["Mass Dispel"] = {t=1.5, icontex=""};
		--["Binding Heal"] = {t=1.5, icontex=""};
		--["Pain Suppression"] = {t=8, d=180, icontex=""}; -- gain, Talent
		--["Vampiric Touch"] = {t=1.5, icontex=""}; -- Talent

        -- Rogue
        ["解除陷阱"] = {t=2.0, icontex="Spell_Shadow_GrimWard"};
        ["疾跑"] = {t=15.0, d=300.0, icontex="Ability_Rogue_Sprint"}; -- gain
        ["開鎖"] = {t=5.0, icontex="Spell_Nature_MoonKey"};
        ["閃避"] = {t=15.0, d=300, icontex="Spell_Shadow_ShadowWard"}; -- gain
        ["消失"] = {t=10.0, d=300, icontex="Ability_Vanish"}; -- gain
        ["劍刃亂舞"] = {t=15.0, d=120, icontex="Ability_Rogue_SliceDice"}; -- gain

        ["速效毒藥 VI"] = {t=3.0, icontex="Ability_Poisons"};
        ["致命毒藥 V"] = {t=3.0, icontex="Ability_Rogue_DualWeild"};
        ["致殘毒藥"] = {t=3.0, icontex="Ability_PoisonSting"};
        ["致殘毒藥 II"] = {t=3.0, icontex="Ability_PoisonSting"};
        ["麻痹毒藥"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
        ["麻痹毒藥 II"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
        ["麻痹毒藥 III"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		    ["能量刺激"] = {t=15, d=300, icontex=""}; -- gain, Talent
		--["Cloak of Shadows"] = {t=5, d=120, icontex=""}; -- gain, Talent

        -- Shaman
        ["次級治療波"] = {t=1.5, icontex="Spell_Nature_HealingWaveLesser"};
        ["治療波"] = {t=2.5, icontex="Spell_Nature_MagicImmunity"}; -- talent
        ["先祖之魂"] = {t=10.0, icontex="Spell_Nature_Regenerate"};
        ["閃電鏈"] = {t=2.5, d=6.0, icontex="Spell_Nature_ChainLightning"};
        ["幽魂之狼"] = {t=1.0, icontex="Spell_Nature_SpiritWolf"};
        ["星界傳送"] = {t=10.0, icontex="Spell_Nature_AstralRecal"};
        ["治療鏈"] = {t=2.5, icontex="Spell_Nature_HealingWaveGreater"};
        ["閃電箭"] = {t=3.0, icontex="Spell_Nature_Lightning"};
        ["視界術"] = {t=2.0, icontex="Spell_Nature_FarSight"};
        ["石爪圖騰"] = {t=15.0, d=30.0, icontex="Spell_Nature_StoneClawTotem"}; -- '?-- works? -- gain
        ["法力之潮圖騰"] = {t=15.0, d=300.0, icontex="Spell_Frost_SummonWaterElemental"}; -- '?-- works? -- gain
        ["火焰新星圖騰"] = {t=5.0, d=15.0, icontex="Spell_Fire_SealOfFire"}; -- '?-- works? -- gain
        ["風暴打擊"] = {t=12.0, d=25, icontex="Spell_Holy_SealOfMight"}; -- gain
        ["先祖堅韌"] = {t=15.0, icontex="Spell_Nature_UndyingStrength"}; -- gain (target), Talent
        ["治療之路"] = {t=15.0, icontex="Spell_Nature_HealingWay"}; -- gain (target), Talent
        ["根基圖騰"] = {d=15.0, icontex="Spell_Nature_GroundingTotem"}; -- works?
		    ["元素專精"] = {d=180, icontex="Spell_Nature_WispHeal"}; -- gain, Talent
		--["Shamanistic Rage"] = {t=30, d=120, icontex=""}; -- gain, Talent


        -- Warlock
        ["暗影箭"] = {t=2.5, icontex="Spell_Shadow_ShadowBolt"};
        ["獻祭"] = {t=1.5, icontex="Spell_Fire_Immolation"};
        ["靈魂之火"] = {t=4.0, d=60.0, icontex="Spell_Fire_Fireball02"};
        ["灼熱之痛"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
        ["召喚恐懼戰馬"] = {t=3.0, g=0.0, icontex="Ability_Mount_Dreadsteed"};
        ["召喚地獄戰馬"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
        ["召喚小鬼"] = {t=6.0, icontex="Spell_Shadow_Imp"};
        ["召喚魅魔"] = {t=6.0, icontex="Spell_Shadow_SummonSuccubus"};
        ["召喚虛空行者"] = {t=6.0, icontex="Spell_Shadow_SummonVoidWalker"};
        ["召喚地獄獵犬"] = {t=6.0, icontex="Spell_Shadow_SummonFelHunter"};
        ["恐懼術"] = {t=1.5, icontex="Spell_Shadow_Possession"};
        ["恐懼嚎叫"] = {t=2.0, d=40.0, g=0.0, icontex="Spell_Shadow_DeathScream"};
        ["放逐術"] = {t=1.5, icontex="Spell_Shadow_Cripple"};
        ["召喚儀式"] = {t=5.0, icontex="Spell_Shadow_Twilight"};
        ["末日儀式"] = {t=10.0, icontex="Spell_Shadow_AntiMagicShell"};
        ["製造法術石"] = {t=5.0, icontex="INV_Misc_Gem_Sapphire_01"};
        ["製造靈魂石"] = {t=3.0, icontex="Spell_Shadow_SoulGem"};
        ["製造治療石"] = {t=3.0, icontex="INV_Stone_04"};
        ["製造極效治療石"] = {t=3.0, icontex="INV_Stone_04"};
        ["製造火焰石"] = {t=3.0, icontex="INV_Ammo_FireTar"};
        ["奴役惡魔"] =  {t=3.0, icontex="Spell_Shadow_EnslaveDemon"};
        ["地獄火"] = {t=2.0, d=3600, icontex="Spell_Fire_Incinerate"};
        ["防護暗影結界"] =    {t=30.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
        ["詛咒增幅"] =  {t=30.0, d=180, icontex="Spell_Shadow_Contagion"}; -- gain
		--["Seed of Corruption"] = {t=2, icontex=""};
		--["Ritual of Souls"] = {t=3, d=300, icontex=""};
		    ["燒盡"] = {t=2.5, icontex=""};

            -- Imp
            ["火焰箭"] =   {t=1.5, icontex="Spell_Fire_FireBolt"};

            -- Succubus
            ["誘惑"] =    {t=1.5, icontex="Spell_Shadow_MindSteal"};
            ["安撫之吻"] =  {t=4.0, d=4.0, icontex="Spell_Shadow_SoothingKiss"};

            -- Voidwalker
            ["吞噬暗影"] = {t=10.0, icontex="Spell_Shadow_AntiShadow"}; -- gain

        -- Warrior
        ["血性狂暴"] = {t=10.0, d=60, icontex="Ability_Racial_BloodRage"}; -- gain
        ["嗜血"] = {t=8.0, icontex="Spell_Nature_BloodLust"}; -- gain
        ["盾牆"] = {t=10.0, d=1800.0, icontex="Ability_Warrior_ShieldWall"}; -- gain
        ["魯莽"] = {t=15.0, d=1800.0, icontex="Ability_CriticalStrike"}; -- gain
        ["反擊風暴"] = {t=15.0, d=1800.0, icontex="Ability_Warrior_Challange"}; -- gain
        ["狂暴之怒"] = {t=10.0, d=30, icontex="Spell_Nature_AncestralGuardian"}; -- gain
        ["破釜沉舟"] = {t=20.0, d=600, icontex="Spell_Holy_AshesToAshes"}; -- gain
	--["破釜沉舟"] = {t=20.0, d=480, icontex="Spell_Holy_AshesToAshes"}; -- gain
        ["死亡之願"] = {t=30.0, d=180, icontex="Spell_Shadow_DeathPact"}; -- gain
        -- ["狂怒"] = {t=12.0, icontex="Spell_Shadow_UnholyFrenzy"}; -- gain
        ["盾牌格擋"] = {t=5.5, icontex="Ability_Defend"}; -- gain, 1 Talent point in impr. block
		--["Victory Rush"] = {t=30, icontex=""}; -- gain
		    ["法術反轉"] = {t=5, d=10, icontex=""}; -- gain


        -- Mobs
        ["縮小"] = {t=3.0, icontex="Spell_Ice_MagicDamage"};
        ["女妖詛咒"] = {t=2.0, icontex="Spell_Nature_Drowsy"};
        ["暗影箭雨"] = {t=3.0, icontex="Spell_Shadow_ShadowBolt"};
        ["殘廢術"] = {t=3.0, icontex="Spell_Shadow_Cripple"};
        ["黑暗治療"] = {t=3.5, icontex="Spell_Shadow_ChillTouch"}; -- gain
        ["靈魂凋零"] = {t=2.0, icontex="Spell_Holy_HarmUndeadAura"};
        ["陣風"] = {t=2.0, icontex="Spell_Nature_EarthBind"};
        ["黑泥術"] = {t=3.0, icontex="Spell_Shadow_CallofBone"};
        ["毒性箭"] = {t=2.0, icontex="Spell_Nature_CorrosiveBreath"};
        ["含毒噴濺"] = {t=2.0, icontex="Spell_Nature_CorrosiveBreath"};
        ["野性回復"] = {t=3.0, g=0, icontex="Spell_Nature_Rejuvenation"};
        ["死木詛咒"] = {t=2.0, icontex="Spell_Shadow_GatherShadows"};
        ["血之詛咒"] = {t=2.0, icontex="Spell_Shadow_RitualOfSacrifice"};
        ["黑暗污泥"] = {t=5.0, icontex="Spell_Shadow_CreepingPlague"};
        ["瘟疫之雲"] = {t=2.0, icontex="Spell_Shadow_CallofBone"};
        ["遊蕩瘟疫"] = {t=2.0, icontex="Spell_Shadow_CallofBone"};
        ["凋零之觸"] = {t=2.0, icontex="Spell_Nature_Drowsy"};
        ["熱疫疲倦"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
        ["覆體之網"] = {t=2.0, icontex="Spell_Nature_EarthBind"};
        ["水晶凝視"] = {t=2.0, icontex="Ability_GolemThunderClap"};
	["Flamespit"] = {t=3.0, icontex="Spell_Fire_FlameBolt"}; --! translate
	["Lizard Bolt"] = {t=2.0, icontex="Spell_Nature_Lightning"}; --! translate
	["Plague Mind"] = {t=4.0, icontex="Spell_Shadow_CallofBone"}; --! translate


    }

    CEnemyCastBar_Raids = {

        -- "mcheck" to only show a bar if cast from this mob. Shows a spell if the mobname is a part of 'mcheck'. mcheck="Ragnaros - Princess Yauj" possible!
        -- "m" sets a mob's name for the castbar; "i" shows a second bar; "r" sets a different CastTime for this Mob (r = "Mob1 Mob2 Mob3" possible *g*)
        -- "active" only allows this spell to be an active cast, no afflictions and something else!
        -- "global" normally is used for afflictions to be shown even it's not your target, but here the important feature is that the castbar won't be updated if active!
        -- "checktarget" checks if the mob casted this spell is your current target. Normally this isn't done with RaidSpells.
        -- "icasted" guides this spell through the instant cast protection
        -- checkevent="Event1 - Event2" to bind spells to only trigger a castbar if these events were fired. (Example: checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" )
        -- checkengage="true" will only trigger a castbar if the engage protection is running! (Used for Yauj fear for example to prevent CBs at other Mobs that fear players within AQ!)
        -- aZone="InstanceName" to only allow this spell to trigger a CastBar in the specific (Main)Zone. (Not the minimap zone, but the big global Zone e.g. Stormwind, not Trade District! Example: aZone="Ahn'Qiraj"
        -- aBar="NextSpellName" will trigger the defined spell instantly when the source CastBar runs out (e.g. 'Dark Glare'). Will only do that if the User is in combat or dead! Won't broadcast the next triggered spell to the raid!
        -- pBar="NextSpellName" will trigger the defined spell instantly when the source CastBar APPEARS! (e.g. 'Web Spray'). Won't broadcast the next triggered spell to the raid!
        -- delBar="SpellName" will delete the defined spell instantly when the source CastBar runs out! (e.g. 'Locust Swarm').
        -- tchange={"SpellName", duration1, duration2} will change the duration of defined Spell when the CastBar runs out (e.g. tchange={"Inevitable Doom", 30, 15} for '15 sec Doom CD!' Bar). Duration1 is applied (reset) if the EngageProtection is disabled and the player enters combat the next time! Enables the EngageProtection!

        -- Naxxramas

		["Necro Stalker"] = {t=1800.0, c="cooldown", global="true", m="Respawn", icontex="Spell_Holy_Resurrection"};

            -- Anub'Rekhan
            [CECB_SPELL_FIRST_LOCUST_SWARM] = {t=90, c="cooldown", icontex="Spell_Nature_InsectSwarm"};
            ["蝗蟲風暴"] = {t=23, i=3, c="gains", delBar="蝗蟲風暴 CD", aBar="蝗蟲風暴 CD", active="true", icontex="Spell_Nature_InsectSwarm"};
            ["蝗蟲風暴 CD"] = {t=70, c="cooldown", icontex="Spell_Nature_InsectSwarm"};

            -- Patchwerk
            [CECB_SPELL_ENRAGED_MODE1] = {t=420, c="cooldown", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally!

            -- Razuvious
            [CECB_SPRLL_DISRUPTING_SHOUT] = {t=25, c="cooldown", active="true", icontex="Ability_Creature_Disease_02"};

            -- Gluth
            ["恐嚇咆哮"] = {t=20.0, c="cooldown", m="古魯斯", icontex="Ability_Devour"}; -- Gluth Fears every 20seconds
            [CECB_SPELL_DECIMATE] = {t=105, c="cooldown", active="true", icontex="Ability_Creature_Disease_02"};

            -- Maexxna
            [CECB_SPELL_WEB_SPRAY] = {t=40, c="cooldown", pBar="梅克絲娜之子", m="梅克絲娜", aZone="納克薩瑪斯", icontex="Ability_Ensnare"};
            ["梅克絲娜之子"] = {t=30, c="cooldown", pBar="纏繞的蜘蛛網 CD", icontex="INV_Misc_MonsterSpiderCarapace_01"};
            ["纏繞的蜘蛛網 CD"] = {t=20, c="cooldown", icontex="Spell_Nature_Web"};

            -- Thaddius
            ["兩極移形"] = {t=30, i=3, c="cooldown", pBar=CECB_SPELL_BECOME_ENRAGED, mcheck="泰迪斯", icontex="Spell_Nature_Lightning"};
            ["力量澎湃"] = {t=10, c="gains", mcheck="Stalagg", icontex="Spell_Shadow_SpectralSight"};
            [CECB_SPELL_BECOME_ENRAGED] = {t=290, c="cooldown", global="true", tchange={CECB_SPELL_BECOME_ENRAGED, 290, 0}, icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally! -- wont be updated

            -- Faerlina
            [CECB_SPELL_ENRAGE] = {t=60, c="cooldown", mcheck="大寡婦費琳娜", icontex="Spell_Shadow_UnholyFrenzy"};
            ["寡婦之擁"] = {t=30, c="cooldown", mcheck="大寡婦費琳娜", icontex="Spell_Arcane_Blink"}; -- Fearlina

            -- Loatheb
            [CECB_SPELL_15SEC_DOOM_CD] = {t=299, tchange={"無可避免的末日", 30, 15}, c="cooldown", m="洛斯伯", icontex="Spell_Shadow_NightOfTheDead"}; -- don't translate, used internally!
            [CECB_SPELL_FIRST_INVITABLE_DOOM] = {t=120, c="cooldown", m="洛斯伯", icontex="Spell_Shadow_NightOfTheDead"}; -- don't translate, used internally!
            ["無可避免的末日"] = {t=30, c="cooldown", m="洛斯伯", icontex="Spell_Shadow_NightOfTheDead"};

            ["召喚孢子"] = {t=12.5, icasted="true", c="cooldown", mcheck="洛斯伯", icontex="Spell_Nature_AbolishMagic"};
            ["解除洛斯伯身上的詛咒"] = {t=0.1, icasted="true", c="cooldown", pBar="詛咒已解除", mcheck="洛斯伯"};
            ["詛咒已解除"] = {t=30, c="cooldown", icontex="Spell_Nature_RemoveCurse"};

		-- Gothik
		-- don't translate, ALL used internally!
		[CECB_SPELL_COMES_DOWN] = {t=270, c="cooldown", aBar="del1", icontex="Spell_Shadow_RaiseDead"};
		["del1"] = {t=0.1, pBar="del2", delBar=CECB_SPELL_TRAINEES_INCOME};
		["del2"] = {t=0.1, pBar="del3", delBar=CECB_SPELL_DK_INCOME};
		["del3"] = {t=0.1, delBar=CECB_SPELL_RIDER_INCOME};
		
		[CECB_SPELL_1ST_TRAINEES_INCOME] = {t=27, c="cooldown", aBar=CECB_SPELL_TRAINEES_INCOME, icontex="INV_Misc_Head_Undead_01"};
		[CECB_SPELL_1ST_DK_INCOME] = {t=77, c="cooldown", aBar=CECB_SPELL_DK_INCOME, icontex="Spell_Shadow_ShadowWard"};
		[CECB_SPELL_1ST_RIDER_INCOME] = {t=137, c="cooldown", aBar=CECB_SPELL_RIDER_INCOME, icontex="Ability_Mount_Undeadhorse"};
		[CECB_SPELL_TRAINEES_INCOME] = {t=20, c="cooldown", aBar=CECB_SPELL_TRAINEES_INCOME, icontex="INV_Misc_Head_Undead_01"};
		[CECB_SPELL_DK_INCOME] = {t=25, c="cooldown", aBar=CECB_SPELL_DK_INCOME, icontex="Spell_Shadow_ShadowWard"};
		[CECB_SPELL_RIDER_INCOME] = {t=30, c="cooldown", aBar=CECB_SPELL_RIDER_INCOME, icontex="Ability_Mount_Undeadhorse"};


            -- Noth
            ["閃現術"] = {t=30, c="cooldown", mcheck="瘟疫者諾斯", aZone="納克薩瑪斯", icontex="Spell_Arcane_Blink"}; --Noth blinks every 30sec, agro reset.
            [CECB_SPELL_FIRST_TELEPORT] = {t=90, c="cooldown", aBar="上台 1", aZone="納克薩瑪斯", icontex="Spell_Nature_AstralRecalGroup"};
            ["上牆 1"] = {t=70, c="cooldown", aBar="第二次傳送", icontex="Spell_Nature_AstralRecalGroup"};
            ["第二次傳送"] = {t=110, c="cooldown", aBar="上台 2", icontex="Spell_Nature_AstralRecalGroup"};
            ["上牆 2"] = {t=95, c="cooldown", aBar="第三次傳送", icontex="Spell_Nature_AstralRecalGroup"};
            ["第三次傳送"] = {t=180, c="cooldown", aBar="上台 3", icontex="Spell_Nature_AstralRecalGroup"};
            ["上牆 3"] = {t=120, c="cooldown", icontex="Spell_Nature_AstralRecalGroup"};

            -- Heigan
            [CECB_SPELL_ON_PLATFORM] = {t=45, c="cooldown", aBar=CECB_SPELL_TELEPORT_CD, icontex="INV_Enchant_EssenceAstralLarge"};
            [CECB_SPELL_TELEPORT_CD] = {t=90, c="cooldown", icontex="INV_Enchant_EssenceAstralLarge"};

		-- Sapphiron
		["生命吸取警報"] = {t=24, c="cooldown", m="薩菲隆", aZone="納克薩瑪斯", icontex="Spell_Shadow_LifeDrain02"};

        -- Ahn'Qiraj

            -- 40 Man
                ["黑曜石根除者"] = {t=1800.0, c="cooldown", global="true", m="重生", icontex="Spell_Holy_Resurrection"};

                -- Twin Emperors
                [CECB_SPELL_TWIN_TELEPORT] = {t=30.0, c="cooldown", icasted="true", icontex="Spell_Arcane_Blink"};
                ["爆炸蟲"] = {t=5.0, c="gains", icontex="Spell_Fire_Fire"};
                ["變形包"] = {t=5.0, c="gains", icontex="Ability_Hunter_Pet_Scorpid"};

                -- Ouro
                ["沙塵爆裂"] = {t=2.0, c="hostile", mcheck="奧羅", icontex="Spell_Nature_Cyclone"};
                ["橫掃"] = {t=21, i=1.0, c="cooldown", mcheck="奧羅", icontex="Spell_Nature_Thorns"};

                ["召喚奧羅土堆"] = {t="0.1", delBar=CECB_SPELL_POSSIBLE_OURO_SUBMERGE, icasted="true", pBar="潛水"};
                ["潛水"] = {t=30, c="cooldown", delBar="奧羅潛水", aBar=CECB_SPELL_POSSIBLE_OURO_SUBMERGE, icontex="INV_Qiraj_OuroHide"};
                [CECB_SPELL_POSSIBLE_OURO_SUBMERGE] = {t=90, c="cooldown", pBar="奧羅潛水", icontex="Spell_Shadow_DemonBreath"};
                ["奧羅潛水"] = {t=180, c="cooldown", icontex="Spell_Shadow_DemonBreath"};


                -- C'Thun
		        [CECB_SPELL_FIRST_DARK_GLARE] = {t=48, c="cooldown", aBar=CECB_SPELL_DARK_GLARE, icontex="Spell_Nature_CallStorm"}; -- don't translate, used internally!
		        [CECB_SPELL_WEAKENED] = {t=45, c="gains", delBar=CECB_SPELL_SMALL_EYE_P2, aBar=CECB_SPELL_AFTER_WEAKENED_EYES, icontex="Ability_Hunter_SniperShot"}; -- don't translate, used internally!
		        [CECB_SPELL_DARK_GLARE] = {t=86, i=40, c="cooldown", active="true", aBar=CECB_SPELL_DARK_GLARE, icontex="Spell_Nature_CallStorm"}; -- don't translate, used internally!
		        [CECB_SPELL_SMALL_EYE_P1] = {t=45, c="cooldown", aBar=CECB_SPELL_SMALL_EYE_P1, icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
		        [CECB_SPELL_FIRST_SMALL_EYE_P2] = {t=42, c="cooldown", aBar=CECB_SPELL_SMALL_EYE_P2, icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
		        [CECB_SPELL_SMALL_EYE_P2] = {t=30, c="cooldown", aBar=CECB_SPELL_SMALL_EYE_P2, icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
		        [CECB_SPELL_AFTER_WEAKENED_EYES] = {t=38, c="cooldown", aBar=CECB_SPELL_SMALL_EYE_P2, icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!

                -- Skeram
                ["魔爆術"] = {t=1.2, c="hostile", mcheck="預言者斯克拉姆", icontex="Spell_Nature_WispSplode"};

                -- Sartura (Twin Emps enrage + Hakkar enrage)
                ["旋風斬"] = {t=15.0, c="gains", mcheck="沙爾圖拉", icontex="Ability_Whirlwind"};
                [CECB_SPELL_ENRAGED_MODE2] = {t=900, r="沙爾圖拉 哈卡", a=600, c="cooldown", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally! +if player enters combat and target are twins!
                [CECB_SPELL_ENTER_ENRAGED_MODE] = {t=3, c="gains", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally!

                -- Huhuran
                [CECB_SPELL_BERSERK_MODE] = {t=300, c="cooldown", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally! if player enters combat and target is Huhuran!
                [CECB_SPELL_ENTER_BERSERK_MODE] = {t=3, c="gains", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally!
                ["翼龍釘刺"] = {t=25, c="cooldown", m="哈霍蘭公主", aZone="安其拉神廟", checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE - CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", icontex="INV_Spear_02"};

                -- Yauj
                ["恐懼術"] = {t=20, c="cooldown", checkengage="true", m="亞爾基公主", aZone="安其拉神廟", checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE - CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", icontex="Spell_Shadow_Possession"};
                ["強效治療術"] = {t=2.0, c="hostile", m="亞爾基公主", mcheck="亞爾基公主", icontex="Spell_Holy_Heal"};


            -- 20 Man

                ["爆炸"] = {t=6.0, c="hostile", icontex="Spell_Fire_SelfDestruct"};

                -- Ossirian
                ["祕法虛弱"] = {t=45, c="gains", mcheck="無疤者奧斯里安", icontex="INV_Misc_QirajiCrystal_01"};
                ["火焰虛弱"] = {t=45, c="gains", mcheck="無疤者奧斯里安", icontex="INV_Misc_QirajiCrystal_02"};
                ["自然虛弱"] = {t=45, c="gains", mcheck="無疤者奧斯里安", icontex="INV_Misc_QirajiCrystal_03"};
                ["冰霜虛弱"] = {t=45, c="gains", mcheck="無疤者奧斯里安", icontex="INV_Misc_QirajiCrystal_04"};
                ["暗影虛弱"] = {t=45, c="gains", mcheck="無疤者奧斯里安", icontex="INV_Misc_QirajiCrystal_05"};

                -- Moam
                [CECB_SPELL_UNTIL_STONEFORM] = {t=90, c="grey", icontex="Spell_Shadow_UnholyStrength"}; -- don't translate, used internally!
                ["充能"] = {t=90, c="gains", icontex="Spell_Nature_Cyclone"};

        -- Zul'Gurub

            -- Hakkar
            [CECB_SPELL_BLOOD_SIPHON] = {t=90.0, c="cooldown", mcheck="哈卡", checkevent="CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", icontex="Spell_Shadow_LifeDrain02"};

        -- Molten Core

		-- Shazzrah
		["沙斯拉爾之門"] = {t=45.0, c="cooldown", icasted="true", icontex="Spell_Arcane_Blink"};

            -- Lucifron
            ["末日降臨"] = {t=20.0, c="cooldown", m="魯西弗隆", icontex="Spell_Shadow_NightOfTheDead"};
            ["魯西弗隆的詛咒"] = {t=20.0, c="cooldown", m="魯西弗隆", icontex="Spell_Shadow_BlackPlague"};

            -- Magmadar
            ["恐慌"] = {t=30.0, c="cooldown", m="瑪格曼達", icontex="Spell_Shadow_DeathScream"};

            -- Gehennas
            ["基赫納斯的詛咒"] = {t=30.0, c="cooldown", m="基赫納斯", icontex="Spell_Shadow_GatherShadows"};

            -- Geddon
            ["地獄火"] = {t=8.0, c="gains", mcheck="迦頓男爵", icontex="Spell_Fire_Incinerate"};

            -- Majordomo
            ["魔法反射"] = {t=30.0, i=10.0, c="cooldown", m="管理者埃克索圖斯", aZone="熔火之心", icontex="Spell_Frost_FrostShock"};
            ["傷害反射護盾"] = {t=30.0, i=10.0, c="cooldown", m="管理者埃克索圖斯", icontex="Spell_Nature_LightningShield"};

            -- Ragnaros
            [CECB_SPELL_SUBMERGE] = {t=180.0, c="cooldown", icontex="Spell_Fire_Volcano"}; -- don't translate, used internally!
            [CECB_SPELL_KNOCKBACK] = {t=28.0, c="cooldown", icontex="Ability_Kick"}; -- don't translate, used internally!
            [CECB_SPELL_SONS_OF_FLAME] = {t=90.0, c="cooldown", icontex="ell_Fire_LavaSpawn"}; -- don't translate, used internally!

        -- Onyxia
            ["火息術"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Fire"};
            [CECB_SPELL_DEEP_BREATH] = {t=5.0, c="hostile", icontex="Spell_Fire_Incinerate"};

        -- Blackwing Lair

            -- Razorgore
            [CECB_SPELL_MOB_SPAWN_45SEC] = {t=45.0, c="cooldown", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!

            -- Firemaw/Flamegor/Ebonroc
            ["龍翼打擊"] = {t=31.5, i=1.2, c="cooldown", r="Onyxia", a=0, icontex="INV_Misc_MonsterScales_14"};
            [CECB_SPELL_FIRST_WINGBUFFET] = {t=30.0, c="cooldown", icontex="INV_Misc_MonsterScales_14"}; -- don't translate, used internally! if player enters combat and target is firemaw or flamegor this castbar appears to catch the first wingbuffet!
            ["暗影烈焰"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Incinerate"};

            -- Flamegor
            [CECB_SPELL_FRENZY_CD] = {t=10.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!

            -- Chromaggus
            ["冰霜灼燒"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Frost_ChillingBlast"};
            ["時間流逝"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Arcane_PortalOrgrimmar"};
            ["點燃軀體"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Fire_Fire"};
            ["腐蝕酸液"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Nature_Acid_01"};
            ["焚燒"] = {t=60.0, i=2.0, c="cooldown", active="true", mcheck="克洛瑪古斯", icontex="Spell_Fire_FlameShock"};
            [CECB_SPELL_KILLING_FRENZY] = {t=15.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!
                -- Chromaggus, Flamegor, Magmadar etc.
            ["狂暴"] = {t=8.0, c="gains", checktarget="true", icontex="INV_Misc_MonsterClaw_03"};

            -- Neferian/Onyxia
            ["低沉咆哮"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, active="true", icontex="Spell_Shadow_Charm"};

            -- Nefarian
            [CECB_SPELL_NEF_CALLS] = {t=30.0, c="gains", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!
            [CECB_SPELL_MOB_SPAWN] = {t=8.0, c="hostile", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!
            [CECB_SPELL_LANDING] = {t=10.0, c="hostile", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!

        -- Outdoor

            -- Azuregos
            ["法力風暴"] = {t=10.0, c="hostile", icontex="Spell_Frost_IceStorm"};

        -- Other

            [CECB_SPELL_BOSS_INCOMING] = {t=0}; -- don't translate, used internally!

    }


    CEnemyCastBar_Afflictions = {

    -- Warning: only add Spells with the "CEnemyCastBar_SPELL_AFFLICTED" pattern here!
    -- fragile="true", if mob with the same name dies, the bar won't be removed
    -- multi="true", the bar is not removed if debuff fades earlier (usefull if one spell is allowed to produce multiple afflictions)
    -- stun="true", flags all spells which use the same Diminishing Return timer. These 8 Spells were tested to use one and the same timer.
        -- stuntype="true", forces non stun="true" CastBars to use the stun-color
    -- death="true", removes the castbar although it is a "fragile"
    -- periodicdmg="true" -> don't update and remove those castbars, only allows periodic damage done by yourself
    -- spellDR="true", triggers a separate class DR Timer;
        -- always(!) use spellDR together with sclass="PlayersCLASS", or you will produce errors!
    -- affmob="true", this stun triggers a class specific DR Timer on a mob (not player), too
    -- drshare="name", all spells with the same drshare name will trigger the same DR Timer called 'name'
    -- checkclass="classname", will only show this spell to specified class
    -- tskill={talentTab, talentNumber, talentTimeBonus, talentClass, offset, relativeTimeBonus(optional) }, adds "talentTimeBonus" to the duration of this skill depending on invested skillpoints! "Offset" is additionally added to the duration if at least one talentpoint is invested.
    -- more to tskill: if "talentTimeBonus" is 0 then the relativeTimeBonus(optional) is used (percentage), needed for hunters talent
    -- plevel={durationBonusPerSkillLevel, PlayerLevelAbleToLearnNewSkillLevel (e.g. 60, 40, 20), exchangeLowestLevelWith "0" ALWAYS!} (correct examples are below)
    -- aZone="InstanceName" to only allow this spell to trigger a CastBar in the specific (Main)Zone. (Not the minimap zone, but the big global Zone e.g. Stormwind, not Trade District! Example: aZone="Ahn'Qiraj"
    -- blockZone="ZoneName" blocks the spell for the specified Zone (example: blockZone="Ahn'Qiraj" for 'Entangling Roots')
	-- cpinterval=X, reduces spell duration by X for every ComboPoint lower than 5 (maximum); ALWAYS use with cpclass="CHARACTERCLASS"!

        -- Naturfreund | Warrior Afflicions
        ["嘲諷"] = {t=3.0, multi="true", icontex="Spell_Nature_Reincarnation"};
        ["懲戒痛擊"] = {t=6.0, multi="true", icontex="Ability_Warrior_PunishingBlow"};
        ["挑戰怒吼"] = {t=6, multi="true", icontex="Ability_BullRush"};
        ["斷筋"] = {t=15.0, icontex="Ability_ShockWave"};
        ["刺耳怒吼"] = {t=6.0, icontex="Spell_Shadow_DeathScream"};
            ["盾擊 - 沉默"] = {t=4, solo="true", icontex="Ability_Warrior_ShieldBash"};
            ["震盪猛擊"] = {t=5, solo="true", stun="true", icontex="Ability_ThunderBolt"};
            ["衝鋒擊昏"] = {t=1, solo="true", stun="true", icontex="Ability_Warrior_Charge"};
            ["攔截昏迷"] = {t=3, solo="true", stun="true", icontex="Ability_Rogue_Sprint"};
            ["復仇昏迷"] = {t=3, solo="true", stuntype="true", icontex="Ability_Warrior_Revenge"};
            ["破膽怒吼"] = {t=8, solo="true", icontex="Ability_GolemThunderClap"};
            ["繳械"] = {t=10, solo="true", icontex="Ability_Warrior_Disarm"};
            ["致死打擊"] = {t=10, solo="true", icontex="Ability_Warrior_SavageBlow"};
        ["挫志怒吼"] = {t=30, checkclass="WARRIOR", icontex="Ability_Warrior_WarCry"};
        ["雷霆一擊"] = {t=30, checkclass="WARRIOR", icontex="Spell_Nature_ThunderClap"};
            -- periodic damage spells
                ["撕裂"] = {t=21, periodicdmg="true", icontex="Ability_Gouge"};

        -- Naturfreund | Mage Afflicions
        ["衝擊波"] = {t=6.0, solo="true", stuntype="true", icontex="Spell_Holy_Excorcism_02"};
	      ["減速術"] = {t=15.0, icontex=""};
            ["冰霜新星"] = {t=8.0, magecold="true", icontex="Spell_Frost_FrostNova"};
            ["霜寒刺骨"] = {t=5.0, magecold="true", icontex="Spell_Frost_FrostArmor"};
            ["冰凍"] = {t=5.0, magecold="true", icontex="Spell_Frost_IceStorm"};
            ["冰錐術"] = {t=8.0, magecold="true", icontex="Spell_Frost_Glacier"}; -- slightly improved with talents (+1 sec)
            ["寒冰箭"] = {t=9, magecold="true", icontex="Spell_Frost_FrostBolt02"}; -- slightly improved with talents (+1 sec)
            ["深冬之寒"] = {t=15, magecold="true", icontex="Spell_Frost_ChillingBlast"};
            ["火焰易傷"] = {t=30, magecold="true", icontex="Spell_Fire_SoulBurn"};
        ["變形術"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="變形術", sclass="MAGE", icontex="Spell_Nature_Polymorph"};
        ["變豬術"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="變形術", sclass="MAGE", icontex="Spell_Magic_PolymorphPig"};
        ["變龜術"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="變形術", sclass="MAGE", icontex="Ability_Hunter_Pet_Turtle"};
            ["法術反制 - 沉默"] = {t=4, solo="true", icontex="Spell_Frost_IceShock"};
            -- periodic damage spells
                ["火焰衝擊"] = {t=8, periodicdmg="true", icontex="Spell_Fire_SelfDestruct"};

        -- Naturfreund | Hunter Afflicions
        ["摔絆"] = {t=10, icontex="Ability_Rogue_Trip"};
            ["強化震盪射擊"] = {t=3, solo="true", stuntype="true", icontex="Spell_Frost_Stun"};
        ["冰凍陷阱"] = {t=20.0, plevel={5, 60, 40, 0}, tskill={3, 7, 0, "HUNTER", 0, 0.15}, fragile="true", spellDR="true", sclass="HUNTER", icontex="Spell_Frost_ChainsOfIce"};
        ["破甲虛弱"] = {t=7.0, checkclass="HUNTER", icontex="Ability_Hunter_SniperShot"};
        ["震盪射擊"] = {t=4, icontex="Spell_Frost_Stun"};
        ["蝮蛇釘刺"] = {t=8, checkclass="HUNTER", icontex="Ability_Hunter_AimedShot"};
	["反擊"] = {t=5, icontex="Ability_Warrior_Challange"};
	["毒蠍釘刺"] = {t=20, checkclass="HUNTER", icontex="Ability_Hunter_CriticalShot"};
            ["翼龍釘刺"] = {t=12, solo="true", icontex="INV_Spear_02"};
            ["驅散射擊"] = {t=4.0, solo="true", icontex="Ability_GolemStormBolt"};
            -- periodic damage spells
                ["毒蛇釘刺"] = {t=15, periodicdmg="true", icontex="Ability_Hunter_Quickshot"};

        -- Naturfreund | Priest Afflicions
        ["暗影易傷"] = {t=15, magecold="true", icontex="Spell_Shadow_ShadowBolt"};
        ["安撫心靈"] = {t=15, icontex="Spell_Holy_MindSooth"};
        ["束縛不死生物"] = {t=50, plevel={10, 60, 40, 0}, fragile="true", spellDR="true", sclass="PRIEST", icontex="Spell_Nature_Slow"};
            ["心靈尖嘯"] = {t=8, solo="true", icontex="Spell_Shadow_PsychicScream"};
            ["沉默"] = {t=5, solo="true", icontex="Spell_Shadow_ImpPhaseShift"};
            -- periodic damage spells
                ["暗言術：痛"] = {t=18, tskill={3, 4, 3, "PRIEST", 0}, periodicdmg="true", icontex="Spell_Shadow_ShadowWordPain"};
                ["噬靈瘟疫"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_BlackPlague"};
                ["神聖之火"] = {t=10, periodicdmg="true", directhit="true", icontex="Spell_Holy_SearingLight"};
		--["Vampiric Touch"] = {t=15, periodicdmg="true", icontex=""};

        -- Naturfreund | Warlock Afflicions
        ["放逐術"] = {t=30, plevel={10, 48, 0}, fragile="true", icontex="Spell_Shadow_Cripple"};
        -- Succubus
        ["誘惑"] = {t=15, fragile="true", spellDR="true", sclass="WARLOCK", drshare="誘惑, 恐懼術", icontex="Spell_Shadow_MindSteal"};
            ["恐懼術"] = {t=20, solo="true", spellDR="true", sclass="WARLOCK", drshare="誘惑, 恐懼術", icontex="Spell_Shadow_Possession"};
        ["疲勞詛咒"] = {t=12, icontex="Spell_Shadow_GrimWard"};
            ["語言詛咒"] = {t=30, checkclass="WARLOCK", icontex="Spell_Shadow_CurseOfTounges"};
            ["厄運詛咒"] = {t=60, checkclass="WARLOCK", icontex="Spell_Shadow_AuraOfDarkness"};
            -- periodic damage spells
                ["痛苦詛咒"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_CurseOfSargeras"};
                ["腐蝕術"] = {t=18, periodicdmg="true", icontex="Spell_Shadow_AbominationExplosion"};
                ["獻祭"] = {t=15, periodicdmg="true", directhit="true", icontex="Spell_Fire_Immolation"};
                ["生命虹吸"] = {t=30, periodicdmg="true", icontex="Spell_Shadow_Requiem"};
		--["Seed of Corruption"] = {t=18, periodicdmg="true", icontex=""};

            ["暗影灼燒"] = {t=5, periodicdmg="true", icontex="Spell_Shadow_ScourgeBuild"}; -- special case

        -- Naturfreund | Rogue Afflicions
        ["致殘毒藥"] = {t=12, icontex="Ability_PoisonSting"};
        ["悶棍"] = {t=45, plevel={10, 48, 28, 0}, fragile="true", spellDR="true", sclass="ROGUE", drshare="悶棍, 鑿擊", icontex="Ability_Sap"};
            ["腎擊"] = {t=6, cpinterval=1, cpclass="ROGUE", solo="true", stuntype="true", spellDR="true", sclass="ROGUE", affmob="true", icontex="Ability_Rogue_KidneyShot"}; -- own DR
            ["偷襲"] = {t=4, solo="true", stun="true", icontex="Ability_CheapShot"};
            ["鑿擊"] = {t=4, tskill={2, 1, 0.5, "ROGUE", 0}, solo="true", stuntype="true", spellDR="true", sclass="ROGUE", drshare="悶棍, 鑿擊", icontex="Ability_Gouge"}; -- normal 4sec impr. 5.5sec (no DR)
            ["致盲"] = {t=10, solo="true", spellDR="true", sclass="ROGUE", icontex="Spell_Shadow_MindSteal"};
            ["腳踢 - 沉默"] = {t=2, solo="true", icontex="Ability_Kick"};
            ["還擊"] = {t=6, solo="true", icontex="Ability_Warrior_Disarm"};
            ["破甲"] = { t=30.0, checkclass="ROGUE", icontex="Ability_Warrior_Riposte" };
            -- periodic damage spells
                ["絞喉"] = {t=18, periodicdmg="true", icontex="Ability_Rogue_Garrote"};
                ["割裂"] = {t=16, cpinterval=2, cpclass="ROGUE", periodicdmg="true", icontex="Ability_Rogue_Rupture"};

        -- Naturfreund | Druid Afflicions
        ["低吼"] = {t=3, multi="true", icontex="Ability_Physical_Taunt"};
        ["挑戰咆哮"] = {t=6, multi="true", icontex="Ability_Druid_ChallangingRoar"};
	      ["颶風術"] =	{t=6, spellDR="true", sclass="DRUID", icontex=""};
	--["Maim"] = {t=6, cpinterval=1, cpclass="DRUID", spellDR="true", sclass="DRUID", solo="true", icontex=""};
        ["糾纏根鬚"] = {t=27, fragile="true", death="true", blockZone="安其拉", spellDR="true", sclass="DRUID", icontex="Spell_Nature_StrangleVines"};
        ["休眠"] = {t=40, plevel={10, 58, 38, 0}, fragile="true", icontex="Spell_Nature_Sleep"};
            ["重擊"] = {t=4, tskill={2, 4, 0.5, "DRUID", 0}, plevel={1, 46, 30, 0}, solo="true", stun="true", icontex="Ability_Druid_Bash"};
            ["突襲"] = {t=2, tskill={2, 4, 0.5, "DRUID", 0}, solo="true", stun="true", icontex="Ability_Druid_SupriseAttack"};
            ["野性衝鋒"] = {t=4, solo="true", icontex="Ability_Hunter_Pet_Bear"};
        ["精靈之火"] = {t=40, checkclass="DRUID", icontex="Spell_Nature_FaerieFire"};
        ["精靈之火（野性）"] = {t=0, tskill={2, 14, 0, "DRUID", 40, 0}, checkclass="DRUID", icontex="Spell_Nature_FaerieFire"}; -- only druids with the talent see the spell
        ["挫志咆哮"] = {t=30, checkclass="DRUID", icontex="Ability_Druid_DemoralizingRoar"};
	--["Mangle"] =	{t=10, checkclass="DRUID", icontex=""};
            -- periodic damage spells
                ["蟲群"] = {t=12, periodicdmg="true", icontex="Spell_Nature_InsectSwarm"};
                ["月火術"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Nature_StarFall"};
                ["撕扯"] = {t=12, periodicdmg="true", icontex="Ability_GhoulFrenzy"};

        -- Naturfreund | Paladin Afflicions
            ["制裁之錘"] = {t=6, solo="true", stun="true", icontex="Spell_Holy_SealOfMight"};
            ["懺悔"] = {t=6, solo="true", icontex="Spell_Holy_PrayerOfHealing"};

        -- Naturfreund | Shaman Afflicions
        ["冰霜震擊"] = {t=8.0, magecold="true", spellDR="true", sclass="SHAMAN", icontex="Spell_Frost_FrostShock"};
            -- periodic damage spells
                ["烈焰震擊"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Fire_FlameShock"};


    -- Naturfreund | Raidencounter Afflicions
    -- gobal="true" creates a castbar even without a target!

        -- Naxxramas
        ["致死傷口"] = {t=15, global="true", icontex="Ability_CriticalStrike"}; -- Gluth's Healing Debuff
        ["變異注射"] = {t=10.0, global="true", icontex="Spell_Shadow_CallofBone"}; -- Grobbulus' Mutagen
        ["纏繞的蜘蛛網"] = {t=60.0, global="true", icontex="Spell_Nature_Web"}; -- Maexxna Web Wraps 3 people after a random ammount of time
        ["墓地毒"] = {t=30.0, global="true", icontex="Ability_Creature_Poison_03"}; -- Maexxna MT -healing Debuff(poison)
	["爆裂法力"] = {t=5, global="true", icontex="Spell_Nature_WispSplode"}; -- Kel'Thuzads Mana Bomb --! correct? "Detonate Mana"

        -- Zul'Gurub
        ["金度的欺騙"] = {t=20, global="true", icontex="Spell_Shadow_UnholyFrenzy"}; -- Delusions of Jin'do
        ["導致瘋狂"] = {t=9.5, global="true", icontex="Spell_Shadow_ShadowWordDominate"}; -- Hakkars Mind Control
        ["威懾凝視"] = {t=5.7, global="true", icontex="Spell_Shadow_Charm"}; -- Mandokir's Gaze

        -- MC
        ["活化炸彈"] = {t=8, global="true", icontex="INV_Enchant_EssenceAstralSmall"}; -- Geddon's Bomb

        -- BWL
        ["燃燒"] = {t=10.0, global="true", aZone="Blackwing Lair", icontex="Spell_Fire_Incinerate"}; -- Razorgores (and Drakkisaths) Burning
        ["燃燒刺激"] = {t=20.0, global="true", icontex="INV_Gauntlets_03"}; -- Vaelastrasz BA
        ["埃博諾克之影"] = {t=8.0, global="true", icontex="Spell_Shadow_GatherShadows"}; -- Ebonroc selfheal debuff

        -- AQ40
        ["充實"] = {t=20, global="true", icontex="Spell_Shadow_Charm"}; -- Skeram MindControl
        ["瘟疫"] = {t=40, global="true", icontex="Spell_Shadow_CurseOfTounges"}; -- Anubisath Defenders Plague
        ["糾纏"] = {t=10, global="true", icontex="Spell_Nature_StrangleVines"}; -- Fankriss the Unyielding's Entangle

        -- AQ20
        ["麻痹"] = {t=10, global="true", aZone="安其拉廢墟", icontex="Ability_Creature_Poison_05"}; -- Ayamiss the Hunter

        -- Non Boss DeBuffs:
        ["強效變形術"] = {t=20.0, fragile="true", icontex="Spell_Nature_Brilliance"}; -- Polymorph of BWL Spellbinders


    -- REMOVALS
    -- just to remove the bar if this spell fades (t is useless here) | only the spells in "CEnemyCastBar_Afflictions" are checked by the "fade-engine"
        -- Moam
        ["充能"] = {t=0, global="true"};
        -- Other
        ["狂暴"] = {t=0, global="true"};
        [CECB_SPELL_STUN_DR] = {t=0}; -- don't translate, used internally! clear the dimishing return timer if mob dies


    }

    -- Spell Interruptions
    NECB_Interruptions = "地震術, 鑿擊, 突襲, 昏迷, 攔截昏迷, 驅散射擊, 戰爭踐踏, 變豬術, 恐懼, 制裁之錘, 悶棍, 衝鋒擊昏, 昏迷衝擊, 昏迷猛擊, 誘惑, 腎擊, 偷襲, 震盪猛擊, 強化震盪射擊, 翼龍釘刺, 復仇昏迷, 破膽怒吼, 變龜術, 心靈尖嘯, 重擊, 衝擊波, 束縛不死生物, 放逐術, 致盲, 精神控制";


    -- Zul'Gurub
    CEnemyCastBar_HAKKAR_NAME           = "哈卡";
    CEnemyCastBar_HAKKAR_YELL           = "驕傲會將你送上絕路";

    -- Naxxramas
    CEnemyCastBar_HEIGAN_YELL1          = "我看到你了……";
    CEnemyCastBar_HEIGAN_YELL2          = "你是我的了。";
    CEnemyCastBar_HEIGAN_YELL3          = "你……就是下一個。";
    CEnemyCastBar_HEIGAN_TELEPORT_YELL  = "你的生命正走向終結。";

    CEnemyCastBar_FAER_YELL1            = "跪下求饒吧，懦夫！";
    CEnemyCastBar_FAER_YELL2            = "休想從我面前逃掉！";
    CEnemyCastBar_FAER_YELL3            = "逃啊！有本事就逃啊！";
    CEnemyCastBar_FAER_YELL4            = "以主人之名，殺了他們！";

    CEnemyCastBar_PATCHWERK_NAME        = "縫補者";

    CEnemyCastBar_GOTHIK_YELL           = "你愚蠢地尋找自己的困境";

    CEnemyCastBar_ANUB_NAME             = "阿努比瑞克漢";

    CEnemyCastBar_ANUB_YELL1            = "一些小點心……";
    CEnemyCastBar_ANUB_YELL2            = "對，跑吧！那樣傷口出血就更多了！";
    CEnemyCastBar_ANUB_YELL3            = "你們逃不掉的。";

    CEnemyCastBar_RAZUVIOUS_NAME        = "拉祖維斯";
    CEnemyCastBar_RAZUVIOUS_NAME_PAT    = "拉祖維斯";
    CEnemyCastBar_FAERLINA_NAME         = "大寡婦費琳娜";
    CEnemyCastBar_FAERLINA_NAME_PAT     = "大寡婦費琳娜";
    CEnemyCastBar_GOTHIK_NAME           = "高希";
    CEnemyCastBar_GOTHIK_NAME_PAT       = "高希";
    CEnemyCastBar_NOTH_NAME             = "諾斯";
    CEnemyCastBar_NOTH_NAME_PAT         = "諾斯";
    CEnemyCastBar_HEIGAN_NAME           = "海根";
    CEnemyCastBar_HEIGAN_NAME_PAT       = "海根";

	CEnemyCastBar_SAPPHIRON_NAME	= "薩菲隆";

    -- AQ40
    CEnemyCastBar_SARTURA_NAME          = "沙爾圖拉";
    CEnemyCastBar_SARTURA_NAME_PAT      = "沙爾圖拉";
    CEnemyCastBar_HUHURAN_NAME          = "哈霍蘭公主";
    CEnemyCastBar_HUHURAN_NAME_PAT      = "哈霍蘭公主";
    CEnemyCastBar_VEKLOR_NAME           = "維克洛爾";
    CEnemyCastBar_VEKNILASH_NAME        = "維克尼拉斯";
    CEnemyCastBar_YAUJ_NAME             = "亞爾基公主";
    CEnemyCastBar_YAUJ_NAME_PAT         = "亞爾基公主";
    CEnemyCastBar_DETECTED_NAME         = "偵測到";
    CEnemyCastBar_KRI_NAME              = "克里勳爵";
    CEnemyCastBar_KRI_NAME_PAT          = "克里勳爵";
    CEnemyCastBar_VEM_NAME              = "維姆";
    CEnemyCastBar_GLUTH_NAME            = "古魯斯";
    CEnemyCastBar_MAEXXAN_NAME          = "梅克絲娜";
    CEnemyCastBar_LOATHEB_NAME          = "洛斯伯";
    CEnemyCastBar_OURO_NAME             = "奧羅";
    CEnemyCastBar_TWINS_NAME            = "雙子";


    CEnemyCastBar_SARTURA_CALL          = "我判你死刑！";
    CEnemyCastBar_SARTURA_CRAZY         = "變得憤怒了！";

    CEnemyCastBar_HUHURAN_CRAZY         = "變得狂暴起來！";

    CEnemyCastBar_CTHUN_NAME1           = "克蘇恩之眼";
    CEnemyCastBar_CTHUN_NAME2           = "克蘇恩";
    CEnemyCastBar_CTHUN_WEAKENED        = "變弱了！";

    -- Ruins of AQ
    CEnemyCastBar_MOAM_NAME             = "莫阿姆";
    CEnemyCastBar_MOAM_STARTING         = "因神態失常而坐立不安。";

    -- MC
    CEnemyCastBar_RAGNAROS_NAME         = "拉格納羅斯";

    CEnemyCastBar_RAGNAROS_STARTING     = "現在輪到你們了！";
    CEnemyCastBar_RAGNAROS_KICKER       = "感受薩弗隆的烈焰吧！";
    CEnemyCastBar_RAGNAROS_SONS         = "出現吧，我的奴僕";

	-- Onyxia
    CenemyCastBar_ONYXIA_NAME           = "奧妮克希亞";

    -- BWL
    CEnemyCastBar_CHROMAGGUS            = "克洛瑪古斯";

    CEnemyCastBar_NEFARIUS_NAME         = "奈法利斯";
    CEnemyCastBar_NEFARIAN_NAME         = "奈法利安";

    CEnemyCastBar_GRETHOK_NAME          = "黑翼控制者";
    CEnemyCastBar_GRETHOK_NAME_PAT      = "黑翼控制者";

    CEnemyCastBar_RAZORGORE_NAME        = "狂野的拉佐格爾";

    CEnemyCastBar_RAZORGORE_CALL        = "入侵者";

    CEnemyCastBar_FIREMAW_NAME          = "費爾默";
    CEnemyCastBar_EBONROC_NAME          = "埃博諾克";
    CEnemyCastBar_FLAMEGOR_NAME         = "弗萊格爾";
    CEnemyCastBar_FLAMEGOR_FRENZY       = "變得狂暴起來！";
    CEnemyCastBar_CHROMAGGUS_FRENZY     = "變得極為狂暴！";

    CEnemyCastBar_NEFARIAN_STARTING     = "讓遊戲開始吧！";
    CEnemyCastBar_NEFARIAN_LAND         = "幹得好，我的手下。";
    CEnemyCastBar_NEFARIAN_SHAMAN_CALL  = "薩滿，讓我看看";
    CEnemyCastBar_NEFARIAN_DRUID_CALL   = "德魯伊和你們愚蠢的";
    CEnemyCastBar_NEFARIAN_WARLOCK_CALL = "術士，不要隨便去玩";
    CEnemyCastBar_NEFARIAN_PRIEST_CALL  = "牧師！如果你要繼續";
    CEnemyCastBar_NEFARIAN_HUNTER_CALL  = "獵人和你那討厭的豌豆射擊";
    CEnemyCastBar_NEFARIAN_WARRIOR_CALL = "戰士，我知道你應該比較抗打";
    CEnemyCastBar_NEFARIAN_ROGUE_CALL   = "盜賊？不要躲了";
    CEnemyCastBar_NEFARIAN_PALADIN_CALL = "聖騎士……聽說你有無數條命";
    CEnemyCastBar_NEFARIAN_MAGE_CALL    = "還有法師？";

    -- ONY
    CEnemyCastBar_ONY_DB                = "深深地吸了一口氣";


    -- Event Pattern
    CEnemyCastBar_MOB_DIES                  = "(.+)死亡"
    CEnemyCastBar_SPELL_GAINS               = "(.+)獲得了(.+)的效果。"
    CEnemyCastBar_SPELL_CAST                = "(.+)開始施放(.+)。";
    CEnemyCastBar_SPELL_PERFORM             = "(.+)開始施展(.+)。"
    CEnemyCastBar_SPELL_CASTS               = "(.+)施放了(.+)。"
    CEnemyCastBar_SPELL_AFFLICTED           = "(.+)受到了(.+)效果的影響";
    CEnemyCastBar_SPELL_AFFLICTED2          = "(.+)受到(.+)的傷害";
    CEnemyCastBar_SPELL_DAMAGE              = "(.+)的(.+)使(.+)受到了(.+)";

    -- Natufreund
    CEnemyCastBar_SPELL_HITS                = "(.+)的(.+)擊中(.+)造成(.+)";
    --                          mob spell   target      damage
    CEnemyCastBar_SPELL_DAMAGE_SELFOTHER    = "你的(.+)使(.+)受到了(.+)";

    CEnemyCastBar_SPELL_FADE                = "(.+)效果從(.+)身上消失。";
    --                          effect          mob

    CEnemyCastBar_SPELL_REMOVED             = "(.+)的(.+)被(.+)移除了。" -- correct pattern for engl. client?
    --                          mob spell
    -- It is an extra check to see if an affliction has fade off

    CEnemyCastBar_SPELL_HITS_SELFOTHER      = "你的(.+)擊中(.+)造成(.+)";
    --                              spell          mob  (damage)
    CEnemyCastBar_SPELL_CRITS_SELFOTHER     = "你的(.+)對(.+)致命一擊造成(.+)";

    CEnemyCastBar_SPELL_INTERRUPTED             = "你打斷了(.+)的(.+)";
    --                                  mob spell
    CEnemyCastBar_SPELL_INTERRUPTED_OTHER           = "(.+)打斷了(.+)的(.+)";
    --                          interrupter mob spell

    CECB_SELF1  = "你";
    CECB_SELF2  = "你";

    -- Class Call Name
    CECB_CLASS_DRUIDS   = "德魯伊們";
    CECB_CLASS_HUNTERS  = "獵人們";
    CECB_CLASS_MAGES    = "法師們";
    CECB_CLASS_PALADINS = "聖騎士們";
    CECB_CLASS_PRIESTS  = "牧師們";
    CECB_CLASS_ROGUES   = "盜賊們";
    CECB_CLASS_SHAMANS  = "薩滿們";
    CECB_CLASS_WARLOCKS = "術士們";
    CECB_CLASS_WARRIORS = "戰士們";

    -- Zone Name
    CECB_ZONE_AHNQIRAJ = "安其拉";
    CECB_ZONE_NAXXRAMAS = "納克薩瑪斯";

    -- Misc
    CECB_MISC_IMMUNE = "免疫";

end
