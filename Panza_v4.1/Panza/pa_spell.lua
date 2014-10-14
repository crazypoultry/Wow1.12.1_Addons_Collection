--[[

pa_spell.lua
Panza General Spell Functions
Revision 4.0

10-01-06 "for in pairs()" for BC
--]]

function PA:SetupSpells()

	------------------------------------
	-- Rank levels of each spell we cast
	------------------------------------
	PA.Spells["Levels"]		= {};

	if (PA.PlayerClass=="PALADIN") then
		PA.Spells.Levels["bol"]			= {40, 50, 60};
		PA.Spells.Levels["bom"]			= {4, 12, 22, 32, 42, 52, 60};
		PA.Spells.Levels["bow"]			= {14, 24, 34, 44, 54, 60};
		PA.Spells.Levels["bosal"]		= {26};
		PA.Spells.Levels["bosan"]		= {20, 30, 40, 50, 60};
		PA.Spells.Levels["bok"]			= {20};
		PA.Spells.Levels["bop"]			= {10, 24, 38};
		PA.Spells.Levels["bosaf"]		= {46, 54};
		PA.Spells.Levels["bof"]			= {18};
		PA.Spells.Levels["gbom"]		= {50, 60};
		PA.Spells.Levels["gbow"]		= {50, 60};
		PA.Spells.Levels["gbol"]		= {50};
		PA.Spells.Levels["gbok"]		= {50};
		PA.Spells.Levels["gbosal"]		= {50};
		PA.Spells.Levels["gbosan"]		= {50};
		PA.Spells.Levels["fury"]		= {16};
		PA.Spells.Levels["HEAL"]		= {1, 6, 14, 22, 30 ,38, 46, 54, 60};	-- Holy Light
		PA.Spells.Levels["FLASH"]		= {20, 26, 34, 42, 50, 58};				-- Flash of Light

	elseif (PA.PlayerClass=="PRIEST") then
		PA.Spells.Levels["fort"]		= {1,12,24,36,48,60};
		PA.Spells.Levels["fward"]		= {20};
		PA.Spells.Levels["pws"]			= {6,12,18,24,30,36,42,48,54,60};
		PA.Spells.Levels["sprt"]		= {30,40,50,60};
		PA.Spells.Levels["sprot"]		= {30,42,56};
		PA.Spells.Levels["pof"]			= {48,60};
		PA.Spells.Levels["pos"]			= {60};
		PA.Spells.Levels["HOT"]			= {8,14,20,26,32,38,44,50,56,60};	-- Renew
		PA.Spells.Levels["HEAL"]		= {16, 22, 28, 34};					-- Heal
		PA.Spells.Levels["FLASH"]		= {20, 26, 32, 38, 44, 50, 56};		-- Flash Heal
		PA.Spells.Levels["LESSERHEAL"]	= {1, 4, 10};						-- Lesser Heal
		PA.Spells.Levels["GREATERHEAL"]	= {40, 46, 52, 58, 60};				-- Greater Heal
		PA.Spells.Levels["cdis"]		= {14};								-- Cure Disease
		PA.Spells.Levels["adis"]		= {32};								-- Abolish Disease
		PA.Spells.Levels["dmag"]		= {18, 36};							-- Dispel Magic
		PA.Spells.Levels["ifire"]		= {12, 20, 30, 40, 50, 60};			-- Inner Fire
		PA.Spells.Levels["pinf"]		= {40};								-- Power Infusion
		PA.Spells.Levels["toweak"]		= {10, 20, 30, 40, 50, 60};			-- Touch of Weakness

	elseif (PA.PlayerClass=="DRUID") then
		PA.Spells.Levels["motw"]		= {1,10,20,30,40,50,60};						-- Mark of the Wild
		PA.Spells.Levels["gotw"]		= {50,60};										-- Gift of the Wild
		PA.Spells.Levels["thorns"]		= {6,14,24,34,44,54,60};
		PA.Spells.Levels["HOT"]			= {4,10,16,22,28,34,40,46,52,58,60};			-- Rejuvination
		PA.Spells.Levels["HEAL"]		= {1, 8, 14, 20, 26, 32, 38, 44, 50, 56, 60};	-- Healing Touch
		PA.Spells.Levels["FLASH"]		= {12, 18, 24, 30, 36, 42, 48, 54, 60};			-- Regrowth
		PA.Spells.Levels["apoi"]		= {26};											-- Abolish Poison

	elseif (PA.PlayerClass=="SHAMAN") then
		PA.Spells.Levels["HEAL"]		= {1, 6, 12, 18, 24, 32, 40, 48, 56, 60};	-- Healing Wave
		PA.Spells.Levels["FLASH"]		= {20, 28, 36, 44, 52, 60};					-- Lesser Healing Wave
		PA.Spells.Levels["lshld"]		= {8, 16, 24, 32, 40, 48, 56};				-- Lightning Shield
		PA.Spells.Levels["rbiter"]		= {1, 8, 16, 24, 34, 44, 54};				-- Rock Biter Weapon
		PA.Spells.Levels["ftwep"]		= {10, 18, 26, 36, 46, 56};					-- Flame Tounge Weapon
		PA.Spells.Levels["fbwep"]		= {20, 28, 38, 48, 58};						-- Frostband Weapon
		PA.Spells.Levels["wfwep"]		= {30, 40, 50, 60};							-- Windfury Weapon
		PA.Spells.Levels["wbreath"]		= {22};										-- Water Breathing
		PA.Spells.Levels["wwalk"]		= {28};										-- Water Waling

	elseif (PA.PlayerClass=="MAGE") then
		PA.Spells.Levels["ai"]		= {1, 14, 28, 42, 56};							-- Arcane Intellect
		PA.Spells.Levels["dmagic"]	= {12, 24, 36, 48, 60};							-- Dampen Magic
		PA.Spells.Levels["amagic"]	= {18, 30, 42, 54};								-- Amplify Magic
		PA.Spells.Levels["farm"]	= {1, 10, 20};									-- Frost Armor
		PA.Spells.Levels["iarm"]	= {30, 40, 50, 60};								-- Ice Armor
		PA.Spells.Levels["marm"]	= {34, 46, 58};									-- Mage Armor
		PA.Spells.Levels["rlc"]		= {18};											-- Remove Lesser Curse

	end

	PA.Spells["HealType"]	= {};
	PA.Spells.HealType.HEAL			= "HEAL";
	PA.Spells.HealType.GREATERHEAL	= "HEAL";
	PA.Spells.HealType.FLASH		= "FLASH";
	PA.Spells.HealType.LESSERHEAL	= "FLASH";
	PA.Spells.HealType.HOT			= "HOT";
	PA.Spells.HealType.GROUPHEAL	= "GROUPHEAL";

	---------------------------------------------------------------------
	-- Base cast times of each spell
	--  Matches to Levels above i.e. by rank
	--  Only need upto the last change anything later is assumed the same
	---------------------------------------------------------------------
	PA.Spells["BaseCastTime"]	= {};
	if (PA.PlayerClass=="PALADIN") then
		PA.Spells.BaseCastTime["HEAL"]			= {2.5};						-- Holy Light
		PA.Spells.BaseCastTime["FLASH"]			= {1.5};						-- Flash of Light
	elseif (PA.PlayerClass=="PRIEST") then
		PA.Spells.BaseCastTime["HEAL"]			= {3.0};						-- Heal
		PA.Spells.BaseCastTime["FLASH"]			= {1.5};						-- Flash Heal
		PA.Spells.BaseCastTime["LESSERHEAL"]	= {1.5, 2.0, 2.5};				-- Lesser Heal
		PA.Spells.BaseCastTime["GREATERHEAL"]	= {3.0};						-- Greater Heal
	elseif (PA.PlayerClass=="DRUID") then
		PA.Spells.BaseCastTime["HEAL"]			= {1.5, 2.0, 2.5, 3.0, 3.5};	-- Healing Touch
		PA.Spells.BaseCastTime["FLASH"]			= {2.0};						-- Regrowth
	elseif (PA.PlayerClass=="SHAMAN") then
		PA.Spells.BaseCastTime["HEAL"]			= {1.5, 2.0, 2.5, 3.0}; 		-- Healing Wave
		PA.Spells.BaseCastTime["FLASH"]			= {1.5}; 						-- Lesser Healing Wave
	end


	-- Spell Update Tracker for Changed Spells
	------------------------------------------
	PA.Spells.Changed 			= false;
	PA.Spells.ChangedTimer		= 0;

	---------------------
	-- Failues not to log
	---------------------
	PA.IgnoreFails = {};
	PA.IgnoreFails[SPELL_FAILED_MOVING]			= true;
	PA.IgnoreFails[SPELL_FAILED_NOT_STANDING]	= true;
	PA.IgnoreFails[SPELL_FAILED_SILENCED] 		= true;
	PA.IgnoreFails[SPELL_FAILED_STUNNED] 		= true;
end

function PA:GetFullSpell(short, prefix)
	local FullName;
	local Spell = PA.SpellBook[short];
	if (Spell==nil) then
		if (prefix==nil) then
			return nil;
		end
		return "";
	end
	FullName = Spell.Name;
	if (prefix~=nil) then
		FullName = prefix..FullName;
	end
	return FullName;
end

function PA:ExtractTextureName(text)
	local _, _, TextureName = string.find(text, "[%w_]+\\[%w_]+\\Spell_([%w_]+)")
	if (TextureName==nil) then
		_, _, TextureName = string.find(text, "[%w_]+\\[%w_]+\\([%w_]+)")
	end
	return TextureName;
end

------------------------------------------------------------------------------------
-- Find which tab spells are in as some textures are reused e.g. First Aid and BoSaf
------------------------------------------------------------------------------------
function PA:DetermineSpellTabs()
	--Match by texture as this is language independant
	local TabMatch = {};
	TabMatch["Ability_Kick"]				= "General";
	if (PA.PlayerClass=="PALADIN") then
		TabMatch["Holy_HolyBolt"]			= "Holy";
		TabMatch["Holy_DevotionAura"]		= "Protection";
		TabMatch["Holy_AuraOfLight"]		= "Retribution";
	elseif (PA.PlayerClass=="PRIEST") then
		TabMatch["Holy_WordFortitude"]		= "Discipline";
		TabMatch["Holy_HolyBolt"]			= "Holy";
		TabMatch["Shadow_ShadowWordPain"]	= "Shadow Magic";
	elseif (PA.PlayerClass=="DRUID") then
		TabMatch["Nature_StarFall"]			= "Balance";
		TabMatch["Nature_HealingTouch"]		= "Restoration";
	elseif (PA.PlayerClass=="SHAMAN") then
		TabMatch["Nature_Lightning"]		= "Elemental Combat";
		TabMatch["Nature_LightningShield"]	= "Enhancement";
		TabMatch["Nature_MagicImmunity"]	= "Restoration";
	elseif (PA.PlayerClass=="MAGE") then
		TabMatch["Holy_MagicalSentry"]		= "Arcane";
		TabMatch["Fire_FireBolt02"]			= "Fire";
		TabMatch["Frost_FrostBolt02"]		= "Frost";
	end
	local Tabs = {};
	for i = 1, MAX_SKILLLINE_TABS do
		local Name, Texture, Offset, Count = GetSpellTabInfo(i);
		if (Texture~=nil) then
			local TextureName = PA:ExtractTextureName(Texture)
			if (TextureName~=nil) then
				local TabName = TabMatch[TextureName];
				if (TabName~= nil) then
					--print("TAB="..Offset+1);
					Tabs[Offset+1] = TabName;
				end
			end
		end
	end
	return Tabs;
end

function PA:GetSpellProperty(spell, property, rank)
	if (PA.SpellBook==nil or PA.SpellBook[spell]==nil) then
		return nil;
	end
	if (rank==nil) then
		return PA.SpellBook[spell][property];
	end
	if (PA.SpellBook[spell][rank]==nil) then
		return nil;
	end
	return PA.SpellBook[spell][rank][property];
end
----------------------------------------------------------------------
-- Scans spellbook for spell ids, heal ammounts and blessing durations
----------------------------------------------------------------------
function PA:ScanSpellbook()

	PA["SpellBook"] 	= {Buffs={}, GroupBuffs={}, DeDebuffs={}, Range={}, ORange={}, SRange={}, Seals={}, Damage={}, SpellCanTarget={}};
	PA.Spells["Short"] 	= {};
	PA.Spells["Lookup"]	= {};
	PA.Spells["Default"]= {};
	PA.SingleToGroup = {};

	PA.CheckSpell = nil;
	if (PASettings.Damage==nil) then
		PASettings.Damage = {};
	end

	local Tabs = PA:DetermineSpellTabs();

	local Count = 0;
	local Match = {};

	if (PA.PlayerClass=="PALADIN") then
		--Match by texture as this is language independant
		Match["Holy_FistOfJustice"]				= {Short="bom",				Tab="Retribution",	ABRange=true,	Buff=true,	BuffId=1, Priority={solo=3, party=4, raid=4, bg=3, pet=2}, Exclude={PRIEST=1,MAGE=1,WARLOCK=1}, LevelBased=true, SpellCanTarget=true};
		Match["Holy_SealOfWisdom"]				= {Short="bow",				Tab="Holy",			ABRange=true,	Buff=true,	BuffId=1, Priority={solo=1, party=2, raid=3, bg=1, pet=0}, Exclude={WARRIOR=1,ROGUE=1}, LevelBased=true};
		Match["Holy_PrayerOfHealing02"]			= {Short="bol",				Tab="Holy",			ABRange=true,	Buff=true,	BuffId=1, Priority={solo=0, party=5, raid=5, bg=4, pet=3}, LevelBased=true};
		Match["Magic_MageArmor"]				= {Short="bok",				Tab="Protection",	ABRange=true,	Buff=true,	BuffId=1, Priority={solo=2, party=3, raid=2, bg=2, pet=1}, LevelBased=true};
		Match["Holy_SealOfSalvation"]			= {Short="bosal",			Tab="Protection",	ABRange=false,	Buff=true,	BuffId=1, Priority={solo=0, party=1, raid=1, bg=0, pet=0, Special={PALADIN={party=0, raid=7}}}, Exclude={WARRIOR=1,ROGUE=1}, Target="pr", LevelBased=true};
		Match["Nature_LightningShield"]			= {Short="bosan",			Tab="Protection",	ABRange=true,	Buff=true,	BuffId=1, Priority={solo=4, party=6, raid=6, bg=5, pet=4}, LevelBased=true};
		Match["Holy_SealOfProtection"]			= {Short="bop",				Tab="Protection",	ABRange=false,	Buff=true,	BuffId=1, LevelBased=true};
		Match["Holy_SealOfSacrifice"]			= {Short="bosaf",			Tab="Protection",	ABRange=true,	Buff=true,	BuffId=1, Target="pr", LevelBased=true};
		Match["Holy_SealOfValor"]				= {Short="bof",				Tab="Protection",	ABRange=true,	Buff=true,	BuffId=1, LevelBased=true};
		Match["Holy_GreaterBlessingofKings"]	= {Short="gbom",			Tab="Retribution",	ABRange=true,	Buff=true,	BuffId=1, Target="C", Group="bom",   Component="kings", LevelBased=true, SpellCanTarget=true};
		Match["Holy_GreaterBlessingofWisdom"]	= {Short="gbow",			Tab="Holy", 		ABRange=true,	Buff=true,	BuffId=1, Target="C", Group="bow",   Component="kings", LevelBased=true, SpellCanTarget=true};
		Match["Holy_GreaterBlessingofLight"]	= {Short="gbol",			Tab="Holy", 		ABRange=true,	Buff=true,	BuffId=1, Target="C", Group="bol",   Component="kings", LevelBased=true, SpellCanTarget=true};
		Match["Magic_GreaterBlessingofKings"]	= {Short="gbok",			Tab="Protection",	ABRange=true,	Buff=true,	BuffId=1, Target="C", Group="bok",   Component="kings", LevelBased=true, SpellCanTarget=true};
		Match["Holy_GreaterBlessingofSalvation"]= {Short="gbosal",			Tab="Protection",	ABRange=false,	Buff=true,	BuffId=1, Target="C", Group="bosal", Component="kings", LevelBased=true, SpellCanTarget=true};
		Match["Holy_GreaterBlessingofSanctuary"]= {Short="gbosan",			Tab="Protection",	ABRange=true,	Buff=true,	BuffId=1, Target="C", Group="bosan", Component="kings", LevelBased=true, SpellCanTarget=true};
		Match["Holy_HolyBolt"]					= {Short="HEAL",			Tab="Holy", 		ABRange=true, SpellCanTarget=true};
		Match["Holy_FlashHeal"]					= {Short="FLASH",			Tab="Holy", 		ABRange=true};
		Match["Holy_Purify"]					= {Short="pf",				Tab="Holy", 		ABRange=true,	DeDebuff={Priority=1, Disease=true, Poison=true}, SpellCanTarget=true};
		Match["Holy_Renew"]						= {Short="cl",				Tab="Holy", 		ABRange=true,	DeDebuff={Priority=2, Disease=true, Poison=true, Magic=true}};
		Match["Nature_TimeStop"]				= {Short="di",				Tab="Protection", 	ABRange=true};
		Match["Holy_RighteousFury"]				= {Short="judge",			Tab="Retribution",	ABRange=false,	ABORange=true, SetHWFlag=false};
		Match["Spell_Holy_SealOfMight"]			= {Short="hoj",				Tab="Protection",	ABRange=false,	ABORange=true,	Debuff=true};
		Match["Holy_Excorcism_02"]				= {Short="exo",				Tab="Holy", 		ABRange=false,  ABORange=false, ABSRange=true, Damage=true};
		Match["Holy_Resurrection"]				= {Short="rez",				Tab="Holy", 		ABRange=false,  ABORange=false, ABSRange=true, SpellCanTarget=true};
		Match["Holy_Heal"]						= {Short="HEALSPECIAL",		Tab="Holy",			Range=false,	SetHWFlag=false};
		Match["Holy_SealOfFury"]				= {Short="fury",			Tab="Protection",	Range=false, 	Buff=true,	BuffId=2};
		Match["Holy_LayOnHands"]				= {Short="loh",				Tab="Holy", 		ABRange=true, SpellCanTarget=true};
		Match["Holy_SearingLight"]				= {Short="hs",				Tab="Holy", 		ABRange=true,   ABORange=true, Damage=true, SpellCanTarget=true};
		Match["Ability_ThunderClap"]			= {Short="how",				Tab="Holy", 		ABRange=false,  ABORange=true, Damage=true};
		Match["Holy_HealingAura"]				= {Short="sol",				Tab="Holy", 		ABRange=false, 	Seal=true};
		Match["Holy_RighteousnessAura"]			= {Short="sow",				Tab="Holy", 		ABRange=false, 	Seal=true};
		Match["Ability_ThunderBolt"]			= {Short="sor",				Tab="Holy", 		ABRange=false, 	Seal=true, Damage=true};
		Match["Holy_SealOfWrath"]				= {Short="soj",				Tab="Protection", 	ABRange=false, 	Seal=true};
		Match["Ability_Warrior_InnerRage"]		= {Short="soc",				Tab="Retribution", 	ABRange=false, 	Seal=true, Damage=true};
		Match["Holy_HolySmite"]					= {Short="sotc",			Tab="Retribution", 	ABRange=false, 	Seal=true};
		PA.DefaultBuff = "bom";
		PA.CheckSpells = {bom={Order=1, Dur=true}, HEAL={Order=2, Dur=false}};
		PA.ShieldSpell = "bop";
		PA.ShieldBlock = "Forbearance";
		PA.CycleBuff = "bom";
		PA.NearBuff = "bom";
		PA.HealBuff = "HEAL";
		PA.NextHeal = {HEAL="FLASH"};
		PA.LowManaType  = "FLASH";
		PA.Spells.Default.Heal	= "HEAL";
		PA.Spells.Default.Panic	= "HEAL";
		PA.Spells.Default.Cure	= "pf";
		PA.Spells.Default.Bless	= "bom";
		PA.Spells.Default.Rez	= "rez";
	elseif (PA.PlayerClass=="PRIEST") then
		Match["Holy_WordFortitude"]				= {Short="fort",			Tab="Discipline",	ABRange=true,	Buff=true,	BuffId=1, Priority={solo=1, party=1, raid=1, bg=1, pet=1}, SpellCanTarget=true};
		Match["Holy_DivineSpirit"]				= {Short="sprt",			Tab="Discipline",	ABRange=true,	Buff=true,	BuffId=2, Priority={solo=2, party=2, raid=2, bg=2, pet=2}};
		Match["Holy_PowerWordShield"]			= {Short="pws",				Tab="Discipline",	ABRange=true,	Buff=true,	BuffId=3, Target="P", SpellCanTarget=true};
		Match["Shadow_AntiShadow"]				= {Short="sprot",			Tab="Shadow Magic",	ABRange=true,	Buff=true,	BuffId=4};
		Match["Holy_Excorcism"]					= {Short="fward",			Tab="Holy",			ABRange=true,	Buff=true, 	BuffId=5};
		Match["Holy_InnerFire"]					= {Short="ifire",			Tab="Discipline",	Range=false, 	Buff=true, 	BuffId=6};
		Match["Holy_PowerInfusion"]				= {Short="pinf",			Tab="Discipline",	ABRange=true,	Buff=true,  BuffId=7};
		Match["Shadow_DeadofNight"]				= {Short="toweak",			Tab="Shadow Magic",	Range=false, 	Buff=true,  BuffId=8, Duration=600};
		Match["Holy_PrayerOfFortitude"]			= {Short="pof",				Tab="Discipline",	ABRange=true,	Buff=true,	BuffId=1, Target="P", Group="fort", Component={"holycandles","sacredcandles"}};
		Match["Holy_PrayerofSpirit"]			= {Short="pos",				Tab="Discipline",	ABRange=true,	Buff=true,	BuffId=2, Target="P", Group="sprt", Component="sacredcandles"};
		Match["Frost_WindWalkOn"]				= {Short="HEALSPECIAL",		Tab="Discipline",	Range=false,	CastTime="Left2", ManaCost=false, SetHWFlag=false}; -- Inner Focus
		Match["Holy_LesserHeal"]				= {Short="LESSERHEAL",		Tab="Holy", 		ABRange=true};
		Match["Holy_LesserHeal02"]				= {Short="LESSERHEAL",		Tab="Holy",			ABRange=true};
		Match["Holy_GreaterHeal"]				= {Short="GREATERHEAL",		Tab="Holy", 		ABRange=true};
		Match["Holy_FlashHeal"]					= {Short="FLASH",			Tab="Holy", 		ABRange=true, SpellCanTarget=true};
		Match["Holy_Heal"]						= {Short="HEAL",			Tab="Holy",			ABRange=true};
		Match["Holy_Heal02"]					= {Short="HEAL",			Tab="Holy",			ABRange=true};
		Match["Holy_PrayerOfHealing02"]			= {Short="GROUPHEAL",		Tab="Holy",			ABRange=false};
		Match["Holy_Renew"]						= {Short="HOT",				Tab="Holy", 		ABRange=true, LevelBased=true, Duration=true};
		Match["Holy_Resurrection"]				= {Short="rez",				Tab="Holy", 		ABRange=false,  ABORange=false, ABSRange=true, SpellCanTarget=true};
		Match["Holy_HolySmite"]					= {Short="smite",			Tab="Holy",			ABRange=false,	ABORange=true, Damage=true};
		Match["Holy_NullifyDisease"]			= {Short="cdis",			Tab="Holy", 		ABRange=true,	DeDebuff={Priority=1, Disease=true}, SpellCanTarget=true};
		Match["Nature_NullifyDisease"]			= {Short="adis",			Tab="Holy", 		ABRange=true, 	DeDebuff={Priority=1, Disease=true}, LevelBased=true};
		Match["Holy_DispelMagic"]				= {Short="dmag",			Tab="Discipline", 	ABRange=true, 	DeDebuff={Priority=2, Magic=true}};
		Match["Shadow_UnholyFrenzy"]			= {Short="mblast",			Tab="Shadow Magic",	ABRange=false,	ABORange=true, Damage=true};
		Match["Holy_SearingLight"]				= {Short="hfire",			Tab="Holy",			ABRange=false,	ABORange=true, Damage=true};
		PA.DefaultBuff = "fort";
		PA.CheckSpells = {fort={Order=1, Dur=true}, LESSERHEAL={Order=2, Dur=false}};
		PA.ShieldSpell = "pws";
		PA.ShieldBlock = "WeakSoul";
		PA.CycleBuff = "fort";
		PA.NearBuff = "fort";
		PA.HealBuff = "LESSERHEAL";
		PA.NextHeal = {GREATERHEAL="HEAL", HEAL="FLASH", FLASH="LESSERHEAL"};
		PA.LowManaType  = "HOT";
		PA.HoTBuff = "renew";
		PA.Spells.Default.Heal	= "LESSERHEAL";
		PA.Spells.Default.Panic	= "LESSERHEAL";
		PA.Spells.Default.Cure	= "cdis";
		PA.Spells.Default.Bless	= "fort";
		PA.Spells.Default.Rez	= "rez";
	elseif (PA.PlayerClass=="DRUID") then
		Match["Nature_Regeneration#Name"]		= {Short="motw",		Tab="Restoration",		ABRange=true, 	Buff=true,	BuffId=1, Priority={solo=1, party=1, raid=1, bg=1, pet=1}, SpellCanTarget=true};
		Match["Nature_Thorns"]					= {Short="thorns",		Tab="Balance",			ABRange=true,	Buff=true, 	BuffId=2, Priority={solo=2, party=2, raid=2, bg=2, pet=2}};
		Match["Nature_Regeneration#Left5"]		= {Short="gotw", 		Tab="Restoration",		ABRange=false, 	Buff=true,	BuffId=1, Target="P", Group="motw", Component={"berries", "thornroot"}};
		Match["Nature_Rejuvenation"] 			= {Short="HOT",  		Tab="Restoration",		LevelBased=true, Duration=true};
		Match["Nature_ResistNature"]			= {Short="FLASH", 		Tab="Restoration"};
		Match["Nature_HealingTouch"]			= {Short="HEAL",		Tab="Restoration",		ABRange=true, SpellCanTarget=true};
		Match["Nature_Reincarnation"]			= {Short="rez",			Tab="Restoration",		ABRange=false,  ABORange=false, ABSRange=true, SpellCanTarget=true};
		Match["Nature_CrystalBall"]				= {Short="HEALSPECIAL",	Tab="Balance",			Range=false, SetHWFlag=false}; -- Oman of Clarity
		Match["Nature_RavenForm"]				= {Short="HEALSPECIAL",	Tab="Restoration",		Range=false, SetHWFlag=false}; -- Nature's Swiftness
		Match["Holy_RemoveCurse"]				= {Short="rcur",		Tab="Restoration",		ABRange=true, 	DeDebuff={Priority=1, Curse=true}, SpellCanTarget=true};
		Match["Nature_NullifyPoison_02"]		= {Short="apoi",		Tab="Restoration",		ABRange=true, 	DeDebuff={Priority=1, Poison=true}, LevelBased=true};
		Match["Nature_AbolishMagic"]			= {Short="wrath",		Tab="Balance",			ABRange=false,	ABORange=true, Damage=true};
		Match["Nature_Tranquility"]				= {Short="GROUPHEAL",	Tab="Restoration",		ABRange=false,	Range=20};
		PA.DefaultBuff = "motw";
		PA.CheckSpells = {motw={Order=1, Dur=true}, HEAL={Order=2, Dur=false}};
		PA.CycleBuff = "motw";
		PA.NearBuff = "motw";
		PA.HealBuff = "HEAL";
		PA.NextHeal = {};
		PA.LowManaType  = "HOT";
		PA.HoTBuff = "rejuv";
		PA.HoTBuff2 = "regro";
		PA.Spells.Default.Heal	= "HEAL";
		PA.Spells.Default.Panic	= "HEAL";
		PA.Spells.Default.Cure	= "rcur";
		PA.Spells.Default.Bless	= "motw";
		PA.Spells.Default.Rez	= "rez";
	elseif (PA.PlayerClass=="SHAMAN") then
		Match["Nature_MagicImmunity"]			= {Short="HEAL",		Tab="Restoration", 		ABRange=true, SpellCanTarget=true};
		Match["Nature_HealingWaveLesser"]		= {Short="FLASH",		Tab="Restoration", 		ABRange=true};
		Match["Nature_HealingWaveGreater"]		= {Short="GROUPHEAL",		Tab="Restoration",		ABRange=false, Range=40};
		Match["Nature_Regenerate"]				= {Short="rez",			Tab="Restoration",		ABRange=false,  ABORange=false, ABSRange=true, SpellCanTarget=true};
		Match["Nature_RemoveDisease"]			= {Short="cd",			Tab="Restoration",		ABRange=true,	DeDebuff={Priority=2, Disease=true}};
		Match["Nature_NullifyPoison"]			= {Short="cp",			Tab="Restoration",		ABRange=true,	DeDebuff={Priority=1, Poison=true}, SpellCanTarget=true};
		Match["Nature_RavenForm"]				= {Short="HEALSPECIAL",	Tab="Restoration",		ABRange=false, SetHWFlag=false};
		Match["Fire_FlameShock"]				= {Short="fshock",		Tab="Elemental Combat", ABRange=false, ABORange=true, Duration=true, Damage=true};
		Match["Nature_EarthShock"]				= {Short="eshock",		Tab="Elemental Combat", ABRange=false, ABORange=true, Duration=true, Damage=true};
		Match["Nature_ChainLightning"]			= {Short="clight",		Tab="Elemental Combat", ABRange=false, ABORange=true, Duration=true, Damage=true};
		Match["Fire_FlameShock"]				= {Short="flshock",		Tab="Elemental Combat", ABRange=false, ABORange=true, Duration=true, Damage=true};
		Match["Nature_Lightning"]				= {Short="lbolt",		Tab="Elemental Combat", ABRange=false, ABORange=true, Duration=true, Damage=true};
		Match["Fire_FlameTounge"]				= {Short="ftwep",		Tab="Enhancement",		Range=false, Buff=true, BuffId=1, WeaponEnchant=true};
		Match["Frost_FrostBrand"]				= {Short="fbwep",		Tab="Enhancement",		Range=false, Buff=true, BuffId=1, WeaponEnchant=true};
		Match["Nature_RockBiter"]				= {Short="rbiter",		Tab="Enhancement",		Range=false, Buff=true, BuffId=1, WeaponEnchant=true, Priority={solo=1, party=1, raid=1, bg=1, pet=1}};
		Match["Nature_Cyclone"]					= {Short="wfwep",		Tab="Enhancement",		Range=false, Buff=true, BuffId=1, WeaponEnchant=true};
		Match["Nature_LightningShield"]			= {Short="lshld",		Tab="Enhancement",		Range=false, Buff=true, BuffId=2, Priority={solo=2, party=2, raid=2, bg=2, pet=2}};
		Match["Shadow_DemonBreath"]				= {Short="wbreath",		Tab="Enhancement",		ABrange=true,	Range=false, Buff=true, BuffId=3};
		Match["Frost_WindWalkOn"]				= {Short="wwalk",		Tab="Enhancement",		ABrange=true,	Range=false, Buff=true, BuffId=3};
		PA.DefaultBuff 							= "rbiter";
		PA.CheckSpells = {fshock={Order=1, Dur=true}, HEAL={Order=2, Dur=false}};
		PA.CycleBuff = "rbiter";
		PA.NearBuff = nil;
		PA.HealBuff = "HEAL";
		PA.NextHeal = {HEAL="FLASH"};
		PA.LowManaType  = "FLASH";
		PA.Spells.Default.Heal	= "HEAL";
		PA.Spells.Default.Panic	= "HEAL";
		PA.Spells.Default.Cure	= "cp";
		PA.Spells.Default.Bless	= "rbiter";
		PA.Spells.Default.Rez	= "rez";
	elseif (PA.PlayerClass=="MAGE") then
		Match["Holy_MagicalSentry"]				= {Short="ai",		Tab="Arcane",		ABRange=true,	Buff=true,	BuffId=1, Priority={solo=1, party=1, raid=1, bg=1, pet=1}, Exclude={WARRIOR=1,ROGUE=1}, LevelBased=true, SpellCanTarget=true};
		Match["Nature_AbolishMagic"]			= {Short="dmagic", 	Tab="Arcane",		ABRange=true,	Buff=true,	BuffId=2};
		Match["Holy_FlashHeal"]					= {Short="amagic",	Tab="Arcane",		ABRange=true, 	Buff=true,	BuffId=3};
		Match["Frost_FrostArmor02#Name"]		= {Short="farm",	Tab="Frost",		Range=false, Buff=true,	BuffId=4, MaxMana=200, Priority={solo=2, party=2, raid=2, bg=2, pet=2}};
		Match["Frost_FrostArmor02#Mana2"]		= {Short="iarm",	Tab="Frost",		Range=false, Buff=true,	BuffId=4};
		Match["MageArmor"]						= {Short="marm",	Tab="Arcane",		Range=false, Buff=true,	BuffId=4};
		Match["Nature_RemoveCurse"]				= {Short="rlc",		Tab="Arcane",		ABRange=true, 	DeDebuff={Priority=1, Curse=true}, SpellCanTarget=true};
		Match["Frost_FrostBolt02"]				= {Short="fbolt",	Tab="Frost",		ABRange=false,	ABORange=true, Damage=true};
		Match["Frost_IceStorm"]					= {Short="bliz",	Tab="Frost",		ABRange=false,  ABORange=true, Damage=true};
		Match["Fire_SelfDestruct"]				= {Short="fstrike", Tab="Fire",			ABRange=false,  ABORange=true, Damage=true};
		Match["Fire_FlameBolt"]					= {Short="fball",	Tab="Fire",			ABRange=false,  ABORange=true, Damage=true};
		Match["Nature_StarFall"]				= {Short="amiss",	Tab="Arcane",		ABRange=false,  ABORange=true, Damage=true};
		PA.DefaultBuff 							= "ai";
		PA.CheckSpells = {ai={Order=1, Dur=true}};
		PA.CycleBuff = "ai";
		PA.NearBuff = "ai";
		PA.HealBuff = nil;
		PA.NextHeal = {};
		PA.LowManaType  = nil;
		PA.Spells.Default.Heal	= nil;
		PA.Spells.Default.Panic	= nil;
		PA.Spells.Default.Cure	= "rlc";
		PA.Spells.Default.Bless	= "ai";
		PA.Spells.Default.Rez	= nil;
	end

	-- Remember buff, debuff and seal textures for looking-up later
	PA.buffKeys = {};
	PA.buffKeysTooltips = {};
	PA.debuffKeys = {};
	for TextureLong, value in pairs(Match) do
		local _, _, Texture, Tooltip = string.find(TextureLong, "([^#]*)#?([^#]*)");
		--PA:Debug("Texture=", Texture, " Tooltip=", Tooltip);
		if (value.Buff==true or value.Seal==true) then
			if (value.WeaponEnchant==true) then
				PA.buffKeys[value.Short] = "WeaponEnchant";
			else
				PA.buffKeys[value.Short] = Texture;
			end
			if (Tooltip~=nil and string.len(Tooltip)>0) then
				PA.buffKeysTooltips[value.Short] = "Name";
			end
		end
		if (value.Debuff==true) then
			PA.debuffKeys[value.Short] = Texture;
		end
	end

	local i = 1;
	local CurrentTab = Tabs[1];
	local Debug = false;
	local Debug2 = false;
	local Debug3 = false;
	--PA:ShowText("===SCAN SPELLS===", "");
	while (true) do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		local Texture = GetSpellTexture(i, BOOKTYPE_SPELL);
		if (spellName==nil or Texture==nil) then
			do break end
		end

		local TextureShort = PA:ExtractTextureName(Texture);
		--PA:Debug(spellName, " (", spellRank, ") Tex=", TextureShort);
		if (TextureShort==nil) then
			do break end
		end

		if (Tabs[i]~=nil) then
			CurrentTab = Tabs[i];
		end

		if (Debug==true) then
			if (i==1) then
				PA:Message("Spell book scan...");
			end
			PA:Message(i.." "..spellName .. "(" .. spellRank .. ") Texture="..TextureShort);
		end

		PA:ResetTooltip();
		PanzaTooltip:SetSpell(i, BOOKTYPE_SPELL);

		local SpellMatch = Match[TextureShort.."#Left5"];
		if (SpellMatch~=nil) then
			local Left5 = PanzaTooltipTextLeft5:GetText();
			if (Left5==nil) then
				SpellMatch = Match[TextureShort.."#Name"];
			end
		else
			SpellMatch = Match[TextureShort.."#Name"];
			if (SpellMatch==nil) then
				SpellMatch = Match[TextureShort];
			end
		end

		local ManaCost = 0;
		if (SpellMatch~=nil) then
			-------------------------
			-- Extract the Mana Costs
			-------------------------
			if (SpellMatch.ManaCost~=false) then
				local ManaText = PanzaTooltipTextLeft2:GetText();
				if (ManaText~=nil) then
					--PA:ShowText(Short, " ManaText=", ManaText);
					local Mana = PA:ExtractNumbers(ManaText);
					if (Mana~=nil) then
						if (Debug) then
							PA:Message("Spell "..spellName.."(Rank "..spellRank..") Mana: "..Mana);
						end
						ManaCost = tonumber(Mana);
					end
				end

				-- Check mana to try and differentiate spells (e.g. Frost/Ice Armor)
				if (SpellMatch.MaxMana~=nil and ManaCost>SpellMatch.MaxMana) then
					SpellMatch = Match[TextureShort.."#Mana2"];
				end

			end

			if (SpellMatch~=nil and SpellMatch.Tab==CurrentTab) then
				if (Debug2) then
					PA:Message("MATCH  "..i.." "..spellName.." - "..Short.." (" .. spellRank .. ") Texture="..TextureShort);
				end
				--PA:ShowText("MATCH  "..i.." "..spellName.." - "..Short.." (" .. spellRank .. ") Texture="..TextureShort);
				PA.Spells.Lookup[spellName] = SpellMatch.Short;
			else
				SpellMatch = nil;
			end
		end

		if (SpellMatch~=nil and SpellMatch.Short~=nil) then

			Debug3 = (SpellMatch.Short=="FLASH");
			Count = Count + 1;
			if (Debug) then
				PA:Message("Short="..SpellMatch.Short.." Texture="..TextureShort);
			end
			--PA:Debug("Short=", SpellMatch.Short);
			--PA:ShowText("Texture=", TextureShort);


			local CheckSpell = PA.CheckSpells[SpellMatch.Short];
			--PA:ShowText("Short=", SpellMatch.Short, " CheckSpell=", CheckSpell);
			if (CheckSpell~=nil and (PA.CheckSpell==nil or CheckSpell.Order<PA.CheckSpell.Order)) then
				PA.CheckSpell = CheckSpell;
				PA.CheckSpell.Short = SpellMatch.Short;
			end

			if (SpellMatch.Buff==true) then
				if (SpellMatch.Group~=nil) then
					PA.SpellBook.GroupBuffs[SpellMatch.Short] = SpellMatch.Component;
					PA.SingleToGroup[SpellMatch.Group] = SpellMatch.Short;
				else
					PA.SpellBook.Buffs[SpellMatch.Short] = true;
				end
			end

			if (SpellMatch.DeDebuff~=nil) then
				PA.SpellBook.DeDebuffs[SpellMatch.Short] = SpellMatch.DeDebuff;
			end
			
			if (SpellMatch.SpellCanTarget~=nil) then
				PA.SpellBook.SpellCanTarget[SpellMatch.Short] = SpellMatch.SpellCanTarget;
			end

			if (SpellMatch.Damage==true and PA.SpellBook.Damage[spellName]==nil) then
				--PA:ShowText("Adding Damage Spell: ", spellName);
				PA.SpellBook.Damage[spellName] = SpellMatch.Short;
				if (PASettings.Damage[SpellMatch.Short]==nil) then
					PA:ResetDamageSpell(SpellMatch.Short);
				end
			end

			if (SpellMatch.Seal==true) then
				PA.SpellBook.Seals[SpellMatch.Short] = Texture;
			end

			if (spellRank==nil) then
				spellRank = 0;
			else
				if (Debug) then
					PA:Message("spellRank: "..spellRank);
				end
				if (string.find(spellRank, PANZA_RANK)) then
					spellRank = PA:GetRank(spellRank);
				else
					spellRank = 0;
				end
			end

			if (PA.SpellBook[SpellMatch.Short]==nil) then
				PA.SpellBook[SpellMatch.Short] = {Name = spellName, MinRank = spellRank, MaxRank = spellRank, Index = i, Texture = Texture, BuffId=SpellMatch.BuffId, Target=SpellMatch.Target, Exclude=SpellMatch.Exclude, Priority=SpellMatch.Priority, LevelBased=SpellMatch.LevelBased, SetHWFlag=SpellMatch.SetHWFlag};
			end
			if (PA.SpellBook[SpellMatch.Short].MinRank>spellRank) then
				PA.SpellBook[SpellMatch.Short].MinRank = spellRank;
			end
			if (PA.SpellBook[SpellMatch.Short].MaxRank<spellRank) then
				PA.SpellBook[SpellMatch.Short].MaxRank = spellRank;
				PA.SpellBook[SpellMatch.Short].Index = i;
			end

			PA.SpellBook[SpellMatch.Short][spellRank] = {};

			if (Debug) then
				PA:Message("Cooldown: "..spellName.." ("..spellRank..") saved index="..i);
			end

			-----------------------------------------------------------------------
			-- Extract the min/max effects (e.g. how much can be healed by)
			-----------------------------------------------------------------------
			local MinMaxText = PanzaTooltipTextLeft4:GetText();
			if (MinMaxText~=nil) then
				if (SpellMatch.Short=="HOT") then
					-- Heal: HOT  xx over yy. Improved HoT xx to xx over yy
					-- TOTEST: if this works for all locs
					local Start, __, Min, Max = string.find(MinMaxText, PANZA_MATCH_POINTS_SPREAD);
					if (Start==nil) then
						Start, __, Max = string.find(MinMaxText, " (%d+) .* %d+");
						if (Start==nil) then
							PA:Message("Core",1,"Error extracting HoT: "..MinMaxText);
						else
							Min=Max;
						end
					end

					if (Start~=nil) then
						if (Debug) then
							-- PA:Message("HoT MinMaxText="..MinMaxText);
							-- PA:Message("HoT Start="..Start);
							-- PA:Message("HoT Min="..Min);
							-- PA:Message("HoT Max="..Max);
							PA:Message("HOT "..spellName.."(Rank "..spellRank..") Min: "..Min.." Max: "..Max);
						end
						PA.SpellBook[SpellMatch.Short][spellRank]["Min"] = tonumber(Min);
						PA.SpellBook[SpellMatch.Short][spellRank]["Max"] = tonumber(Max);
					end
				else
					-- Heal: Min to Max range
					local Start, _, Min, Max = string.find(MinMaxText, PANZA_MATCH_POINTS_SPREAD);
					if (Start~=nil) then
						--  if there is more that one then get the second one (for Holy Shock)
						local _, _, Min2, Max2 = string.find(MinMaxText, PANZA_MATCH_POINTS_SPREAD, Start);
						if (Min2~=nil and Max2~=nil) then
							Min = Min2;
							Max = Max2;
						end
						if (Debug) then
							PA:Message("Spell "..spellName.."(Rank "..spellRank..") Min: "..Min..", Max: "..Max);
						end
						PA.SpellBook[SpellMatch.Short][spellRank]["Min"] = tonumber(Min);
						PA.SpellBook[SpellMatch.Short][spellRank]["Max"] = tonumber(Max);
					end
				end
			end

			----------------------
			-- Store the Mana Cost
			----------------------
			PA.SpellBook[SpellMatch.Short][spellRank]["Mana"] = ManaCost;

			------------------------
			-- Extract the Cast Time
			------------------------
			local CastTimeText;
			if (SpellMatch.CastTime~=nil) then
				CastTimeText = getglobal("PanzaTooltipText"..SpellMatch.CastTime):GetText();
			else
				CastTimeText = PanzaTooltipTextLeft3:GetText();
			end
			if (CastTimeText~=nil) then
				local CastTime = PA:ExtractNumbers(CastTimeText);
				--PA:Debug(SpellMatch.Short, " ", CastTimeText, " CastTime=", CastTime);
				if (CastTime~=nil) then
					if (Debug) then
						PA:Message("Spell "..spellName.."(Rank "..spellRank..") CastTime: "..CastTime);
					end
					--PA:Debug("Spell "..spellName.."(Rank "..spellRank..") CastTime: "..CastTime);
					CastTime	= gsub(CastTime, ",", ".", 1);
					PA.SpellBook[SpellMatch.Short][spellRank]["CastTime"] = tonumber(CastTime);
				end
			end

			-------------------------
			-- Extract the Range
			-------------------------
			local Range = SpellMatch.Range;
			if (Range==nil) then
				local RangeText;
				if (SpellMatch.Short=="GROUPHEAL") then
					RangeText = PanzaTooltipTextLeft4:GetText();
					--PA:ShowText("GROUPHEAL RangeText=", RangeText);
					if (RangeText~=nil) then
						Range = PA:ExtractNumbers(RangeText);
					end
					--PA:ShowText("Range=", Range);
				else
					RangeText = PanzaTooltipTextRight2:GetText();
					if (RangeText==nil) then
						RangeText = PanzaTooltipTextLeft2:GetText();
					end
					--PA:Debug("RangeText=", RangeText);
					if (RangeText~=nil) then
						Range = PA:ExtractNumbers(RangeText);
					end
				end
			end
			--PA:Debug("Range=", Range);

			if (Range~=nil and Range~=false) then
				if (Debug) then
					PA:Message("Spell "..spellName.."(Rank "..spellRank..") Range: "..Range);
				end

				Range = tonumber(Range);
				PA.SpellBook[SpellMatch.Short][spellRank]["Range"] = Range;
				PA.SpellBook[SpellMatch.Short]["Range"] = Range;
				--
				-- Remember spells for ranges for Action Bar range checking
				if (SpellMatch.ABRange==true) then
					if (PA.SpellBook.Range[Range]==nil) then
						PA.SpellBook.Range[Range] = {};
					end
					PA.SpellBook.Range[Range][SpellMatch.Short] = true;
				end
				if (SpellMatch.ABORange==true) then
					if (PA.SpellBook.ORange[Range]==nil) then
						PA.SpellBook.ORange[Range] = {};
					end
					PA.SpellBook.ORange[Range][SpellMatch.Short] = true;
				end
				if (SpellMatch.ABSRange==true) then
					PA.SpellBook.SRange[SpellMatch.Short] = true;
				end
			end

			-------------------------------------------
			-- Extract the Duration
			-------------------------------------------
			if (SpellMatch.Buff==true or SpellMatch.Duration~=nil) then
			
				local Duration;
				if (tonumber(SpellMatch.Duration)~=nil) then
					Duration = SpellMatch.Duration;
				else
					local Text = PanzaTooltipTextLeft5:GetText();
					if (Text==nil) then
						Text = PanzaTooltipTextLeft4:GetText();
					end
					--PA:Debug("Dur: Short=", SpellMatch.Short);
					--PA:Debug("Dur: Text=", Text);
					if (Text~=nil) then
						Duration = PA:ExtractDuration(Text);
					end
				end
				
				if (Duration~=nil) then
					PA.SpellBook[SpellMatch.Short].Duration = Duration;
					PA.SpellBook[SpellMatch.Short][spellRank].Duration = Duration;
				end
			end
		end
		i = i + 1;
	end
	PA.SpellBookVerified = false;
	return Count;
end

----------------------------------------------------
-- Extracts duration from tooltip text,
--   returns duration in seconds or nil if not found
----------------------------------------------------
function PA:ExtractDuration(text)
	--PA:ShowText("text=", text);
	for _, Match in pairs(PANZA_DURATION_HOUR) do
		--PA:ShowText("Match=", Match);
		local _, _, Duration = string.find(text, Match);
		if (Duration~=nil) then
			return tonumber(Duration) * 3600;
		end
	end
	for _, Match in pairs(PANZA_DURATION_MIN) do
		local _, _, Duration = string.find(text, Match);
		if (Duration~=nil) then
			return tonumber(Duration) * 60;
		end
	end
	for _, Match in pairs(PANZA_DURATION_SEC) do
		local _, _, Duration = string.find(text, Match);
		if (Duration~=nil) then
			return tonumber(Duration);
		end
	end
	return nil;
end

----------------------------------------
-- List all spells known by Index number
----------------------------------------
function PA:ShowSpells()
	PA:Message("ID Name (Short) Ranks Min-Max CastTime Duration Range CoolDown");
	for Short, Spell in pairs(PA.SpellBook) do
		if (Spell.Index~=nil) then
			local Duration;
			local CastTime;
			local Ranks;
			local MinMax = " -";
			if (Spell.MinRank==nil or Spell.MinRank==0) then
				Ranks = " NoRanks";
			else
				Ranks = " "..PANZA_RANK.." "..tostring(Spell.MinRank).."-"..tostring(Spell.MaxRank);
				if (Spell[Spell.MinRank].Min~=nil) then
					MinMax = " "..tostring(Spell[Spell.MinRank].Min).."-"..tostring(Spell[Spell.MaxRank].Max);
				end
			end
			if (Spell[Spell.MinRank].CastTime==nil) then
				CastTime = "  InstantCast";
			else
				CastTime = "  Cast="..Spell[Spell.MinRank].CastTime;
				if (Spell[Spell.MaxRank].CastTime~=nil and Spell[Spell.MinRank].CastTime~=Spell[Spell.MaxRank].CastTime) then
					CastTime = CastTime.."-"..Spell[Spell.MaxRank].CastTime;
				end
				CastTime = CastTime.." "..SECONDS_ABBR_P1;
			end
			if (Spell.Duration==nil) then
				Duration = "  None";
			else
				Duration = "  Dur="..Spell.Duration.." "..SECONDS_ABBR_P1;
			end
			if (Spell.Range==nil) then
				Range = "  None";
			else
				Range = "  "..format(SPELL_RANGE, Spell.Range);
			end
			local CoolDown = "";
			local CoolTime = GetSpellCooldown(Spell.Index, BOOKTYPE_SPELL);
			if (CoolTime>0) then
				CoolDown = "  CD="..CoolTime.." "..SECONDS_ABBR_P1;
			else
				CoolDown = "  Ready";
			end
			PA:Message(Spell.Index.." "..tostring(Spell.Name).." ("..Short..")"..Ranks..MinMax..CastTime..Duration..Range..CoolDown);
		end
	end
end

---------------------------------------------------
-- List all spells in the spellbook by Index number
---------------------------------------------------
function PA:ListAllSpells()
	local i = 1;
	PA:ResetTooltip();
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end

		PA:Message(i.." "..spellName .. '(' .. spellRank .. ')' );

		PanzaTooltip:SetSpell(i, BOOKTYPE_SPELL);

		for j=1, PanzaTooltip:NumLines() do
		    local mytext = getglobal("PanzaTooltipTextLeft"..j);
			PA:DisplayText("Left"..j.." =", mytext:GetText());
		    mytext = getglobal("PanzaTooltipTextRight"..j);
			PA:DisplayText("Right"..j.."=", mytext:GetText());
		end

		i = i + 1;
	end
end

-------------------------------------------------
-- Create spell name based on spell name and rank
-------------------------------------------------
function PA:CombineSpell(spell, rank)
	if (rank and rank > 0) then
		return spell.."("..PANZA_RANK.." "..rank..")";
	else
		return spell.."()";
	end
end

---------------------------------------------------------------------------
-- Create spell name for display based on spell name and rank (if in debug)
---------------------------------------------------------------------------
function PA:CombineSpellDisplay(spell, rank)
	if (rank and rank > 0 and (PASettings.Switches.MsgLevel["Core"]>4 or PASettings.Switches.ShowRanks.enabled)) then
		return spell.."("..PANZA_RANK.." "..rank..")";
	else
		return spell;
	end
end

-----------------------------------------
-- Convert (Rank x) to numeric rank value
-----------------------------------------
function PA:GetRank(rank)
	--PA:Message("PA:GetRank args "..rank);
	local start, stop, rnk = string.find(rank, "(%d+)");
    if (rnk==nil) then
    	return 0;
    else
 		--PA:Message("PA:GetRank rank Value="..rnk);
		return (tonumber(rnk));
	end
end

----------------------------------------------------
-- Find out if certain spell is in the PA Spellbook
--  Can only accept short spell names
--  Rank is optional
-----------------------------------------------------
function PA:SpellInSpellBook(shortSpell, rank)
	if (PA.Spells==nil or PA.Spells.Lookup==nil or shortSpell==nil) then
		return false;
	end
	--PA:Debug("longSpell=", longSpell);
	--PA:Debug("rank=", rank);
	--PA:Debug("shortSpell=", shortSpell);
	if (shortSpell==nil or PA.SpellBook[shortSpell]==nil) then
		return false;
	end
	if (rank==nil) then
		return (PA.SpellBook[shortSpell]~=nil);
	end
	return (PA.SpellBook[shortSpell].MaxRank>=rank);
end


-------------------------------------------------------------------------
-- Get Cooldown for Spell and See if we can cast
-- spell is either the spell name or the short name
-- Returns true if spell can be cast or false and the cooldown time if available
-- This function should always be called before a CastSpell is called
-------------------------------------------------------------------------
function PA:GetSpellCooldown(spell, skipMessage)
	PA:Debug("PA:GetSpellCooldown spell=", spell, " skip=", skipMessage);
	local name=nil;

	if (spell==nil) then
		return false;
	end

	local shortSpell = PA.Spells.Lookup[spell];
	if (shortSpell==nil) then
		shortSpell = spell;
	end

	if (shortSpell~=nil and PA.SpellBook[shortSpell]~=nil and PA.SpellBook[shortSpell].Name~=nil) then
		name = PA.SpellBook[shortSpell].Name
	else
		name=shortSpell;
	end

	--PA:Debug("shortSpell=", shortSpell, " SpellBook=", PA.SpellBook[shortSpell]);
	if (shortSpell~=nil and PA.SpellBook[shortSpell]~=nil) then
		local SpellId = PA.SpellBook[shortSpell].Index;
		--PA:Debug("SpellId=", SpellId);
		if (SpellId~=nil and SpellId>0) then
			local spstart, spdur, flag = GetSpellCooldown(SpellId, BOOKTYPE_SPELL);
			--PA:Debug("spstart=", spstart, " spdur=", spdur, " flag=", flag);
			if (spdur==0.001) then -- special case for HEALSPECIAL + nature swiftness, spell up so cooldown unknown
				return false, 10000;
			else
				if (spstart>0 and spdur>0) then
					if (skipMessage~=true) then
						if (PA:CheckMessageLevel("Core", 2)) then
							PA:Message4(format(PA_YEL..PANZA_COOLDOWN, spdur - GetTime() + spstart, name));
						end
					end
					return false, spdur - GetTime() + spstart;
				end
			end
		else
			if (skipMessage~=true) then
				if (PA:CheckMessageLevel("Core", 4)) then
					PA:Message4("SpellId for "..spell.." nil");
				end
			end
			return false;
		end
	else
		if (skipMessage~=true) then
			if (PA:CheckMessageLevel("Core", 4)) then
				PA:Message4("ShortSpell for "..spell.." nil");
			end
		end
		return false;
	end
	return true;
end

-------------------------------------------------------------------------------
-- 1.21 Functions to track Spell Casting
-- 2.0 	Updated to use Cycle.Spell Data and all Heal Announcement moved to here
--	Otherwise known as PAM now.
-------------------------------------------------------------------------------
function PA:SpellcastStart()
	local spell,ChatLanguage,PartyTxt,PrivateTxt,SecondSuffix,CastTime = nil,nil,nil,nil,".",0;
	local ShortSpell;

	-- Set casting flag
	PA.CastingNow = true;

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4(PANZA_EVENT_START);
	end

	---------------------------------------------------------------------------------------------
	-- Are we casting a healing spell? HOT Spells are Instant cast and do not trigger this event.
	---------------------------------------------------------------------------------------------
	if (PA:SpellInSpellBook("HEAL") and string.find(arg1, PA.SpellBook.HEAL.Name)) then
		ShortSpell = "HEAL";
	end

	if (PA:SpellInSpellBook("FLASH") and string.find(arg1, PA.SpellBook.FLASH.Name)) then
		ShortSpell = "FLASH";
	end

	if (PA:SpellInSpellBook("GREATERHEAL") and string.find(arg1, PA.SpellBook.GREATERHEAL.Name)) then
		ShortSpell = "GREATERHEAL";
	end

	if (PA:SpellInSpellBook("LESSERHEAL") and string.find(arg1, PA.SpellBook.LESSERHEAL.Name)) then
		ShortSpell = "LESSERHEAL";
	end


	----------------------------------
	-- Are we rezzing?
	----------------------------------
	if (PA:SpellInSpellBook("rez") and string.find(arg1, PA.SpellBook.rez.Name)) then
		ShortSpell = "rez";
	end

	if (PA:SpellInSpellBook(ShortSpell)) then
		spell = PA.SpellBook[ShortSpell].Name;
	end


	if (PA:CheckMessageLevel("Core",5)) then
		if (spell) then PA:Message4("SpellCastStart(): Casting "..spell); end
	end

	--------------------------------------------------
	-- We are casting a heal/rez so get it's cast time
	--------------------------------------------------
	local unit = PA.Cycles.Spell.Active.target;
	if (spell and unit~=nil and unit~="blank") then

		local UName = nil;
		if (PA.Cycles.Spell.Active.msgtype=="ManualRez") then
			UName = "Corpse";
			--PA:ShowText("Extracting Corpse info from tooltip: ", UName);
			local CorpseInfo = GameTooltipTextLeft1:GetText();
			--PA:ShowText("Corpse Full=", CorpseInfo);
			if (CorpseInfo~=nil) then
				_, _, UName = string.find(CorpseInfo, PANZA_MATCH_CORPSE);
				unit = PA:FindUnitFromName(UName);
				PA.Cycles.Spell.Active.target = unit;
			end
			if (unit==nil) then
				unit = "Corpse";
				PA.Cycles.Spell.Active.target = unit;
			end
		else
			UName = PA:UnitName(unit);
		end
		PA.Cycles.Spell.Active.Name = UName;

		if (UName~="target") then
			local CastTime = arg2/1000;

			if (ShortSpell=="rez") then
				local RezMessage        = PA:Format(PASettings["RezMessage"], UName,                   CastTime, PA.PlayerName);
				local WhisperRezMessage = PA:Format(PASettings["RezMessage"], PANZA_MSG_RESURRECT_YOU, CastTime, PA.PlayerName);
				PA:MultiMessage(RezMessage, nil, WhisperRezMessage,
								PASettings.Switches.MsgGroup.Rez,
								unit,
								"Rez", true);
			else

				----------------------
				-- 1.31 Reset watchdog
				----------------------
				PA.Cycles.Heal.Timer = 0;

				------------------------------------------------------------------------------------
				-- If we report healing Progress, Talk about healing events, or we are in Debug Mode
				------------------------------------------------------------------------------------
				if (PASettings.Switches.MsgLevel.Heal > 0 and PA.Cycles.Spell.Active.target~="blank") then

					local Message = format(PANZA_NOTIFY, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), PA.Cycles.Heal.Bonus, UName, CastTime, SecondSuffix);
					-- If the Spell is Flash and MsgLevel >= 2 or
					-- If the spell is Holy/L/G Heal etc and MsgLevel >= 1 then send it.
					if ((ShortSpell=="FLASH" and PASettings.Switches.MsgLevel.Heal >= 2) or
						((ShortSpell=="HEAL" or ShortSpell=="LESSERHEAL" or ShortSpell=="GREATERHEAL") and PASettings.Switches.MsgLevel.Heal >= 1)) then



						local WhisperMessage = format(PANZA_NOTIFY, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), PA.Cycles.Heal.Bonus, PANZA_MSG_RESURRECT_YOU, CastTime, SecondSuffix);
						PA:MultiMessage(Message, nil, WhisperMessage,
										PASettings.Switches.MsgGroup.Heal,
										PA.Cycles.Spell.Active.target,
										"Heal");

					elseif ((ShortSpell=="FLASH" and PASettings.Switches.MsgLevel.Heal >= 1) or
							((ShortSpell=="HEAL" or ShortSpell=="LESSERHEAL" or ShortSpell=="GREATERHEAL") and PASettings.Switches.MsgLevel.Heal >= 1)) then
						if (PA:CheckMessageLevel("Heal", 1)) then
							PA:Message4(Message);
						end
					end
				end

				------------------------------------------------------------------------------------------------------------
				-- Broadcast new healing message if the PanzaComm addon is installed and we have cooperative healing enabled.
				------------------------------------------------------------------------------------------------------------
				if (PA.Cycles.Spell.Active.target~="blank") then
					if (ShortSpell=="GREATERHEAL" or ShortSpell=="HEAL" or ShortSpell=="LESSERHEAL" or ShortSpell=="FLASH") then
						local who = PA:UnitName(PA.Cycles.Spell.Active.target);
						local me = PA.PlayerName;
						local spell = PA.Cycles.Spell.Active.spell;
						local rank= PA.Cycles.Spell.Active.rank;

						if (PA:CheckMessageLevel("Coop",5)) then
							PA:Message4("(Coop) Broadcast Spell="..spell.." Rank="..rank);
						end

						local healamount; -- send avg amount expected.
						if (PA.Cycles.Heal.Average==nil) then
							local healmin = PA.SpellBook[ShortSpell][rank].Min;
							local healmax = PA.SpellBook[ShortSpell][rank].Max;
							local healbonus = PA.Cycles.Heal.Bonus;
							healamount = math.floor((healmax + healmin) / 2 + healbonus);
						else
							healamount = math.floor(PA.Cycles.Heal.Average);
						end
						local hot = 0;	-- Not a hot spell, set it to 0.

						-- Create our own table entry

						PA.Healing[who] = (PA.Healing[who] or {});

						PA.Healing[who][me] = (PA.Healing[who][me] or {});

						PA.Healing[who][me]["HEAL"] = {
							["Heal"] = healamount,		-- amount expected (avg expected results)
							["HoT"] = hot,				-- 0 for all heals except hot
							["Spell"] = spell,			-- name of spell
							["Status"] = "Active",		-- Active
							["CastTime"] = CastTime,	-- seconds to hit
							["TimeLeft"] = CastTime };	-- remaining time to hit

						if (PASettings.Heal.Bars.OwnBars==true) then
							PA:UpdateCurrentHealBar(who, false);
						end

						-- Mark the message. We can send it later if Needed.
						PA.Healing[who][me]["HEAL"].Timestamp = GetTime();

						-- Make sure we do not spam messages to the channel
						if (PASettings.Heal.Coop.enabled==true and PanzaComm_Message and (PA.CoOp.LastMessageTime + PA.CoOp.MinMsgInterval) < GetTime()) then
							PA.CoOp.LastMessageTime = GetTime();
							PanzaComm_Message("Panza", "Update, " ..who..", "..spell..", "..healamount..", "..hot..", "..CastTime..", "..CastTime);
							PA.Healing[who][me]["HEAL"].MessageSent = true;

						else
							if (PA:CheckMessageLevel("Coop",3)) then
								PA:Message4("(CoOp) Message Throttle occured on Update in SpellCastStart().");
							end
							PA.Healing[who][me]["HEAL"].MessageSent = false;
						end
					end
				end
			end
		end
	end
end

----------------------------
-- Process Spell Cast Delays
----------------------------
function PA:SpellcastDelayed()
	local txt,PartyTxt,msg,delayedTime,secondSuffix=nil,nil,nil,arg1/1000,'.';

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4(PANZA_EVENT_DELAYED);
	end

	-------------------------------------
	-- Only concerned with Healing Spells
	-------------------------------------
	if (PA.Cycles.Spell.Type == 'Heal') then


		local Name = PA:UnitName(PA.Cycles.Spell.Active.target);
		local DisplayName = Name;
		if (Name~="target") then
			if (PA.Cycles.Spell.Active.owner~=nil) then
				if (Name==UNKNOWNOBJECT) then
					Name = "target";
					DisplayName = Name;
				else
					DisplayName = Name.." ("..format(UNITNAME_TITLE_PET, PA.Cycles.Spell.Active.owner)..")";
					Name = PA.Cycles.Spell.Active.owner .. "_" .. Name;
				end
			end
		else
			DisplayName = PA.Cycles.Spell.Active.target;
		end

		if (delayedTime~=1) then
			secondSuffix='s'
		end

		-----------------------------------------------------------------------------------------
		-- 2.0 Check and see if displaying it is worth it. If it will display as 0.0, forget it.
		-----------------------------------------------------------------------------------------
		txt = string.format('%.1f', delayedTime);

		----------------------------------------------------------------
		-- Broadcast updated casting time and update current healing bar
		----------------------------------------------------------------
		if (txt ~= "0.0") then
			local who = Name;
			local me = PA.PlayerName;

			if (who~=nil and PA.Healing[who]~=nil and PA.Healing[who][me]~=nil and PA.Healing[who][me]["HEAL"] ~=nil and PA.Healing[who][me]["HEAL"].Heal~=nil) then
				local TimeLeft = PA.Healing[who][me]["HEAL"].TimeLeft + delayedTime;
				local CastTime = PA.Healing[who][me]["HEAL"].CastTime + delayedTime;

				-- Update our data
				PA.Healing[who][me]["HEAL"].TimeLeft = TimeLeft;
				PA.Healing[who][me]["HEAL"].CastTime = CastTime;

				if (PASettings.Heal.Bars.OwnBars==true) then
					PA:UpdateCurrentHealBar(who, false);
				end

				-- Mark the message. We can send it later if needed.
				PA.Healing[who][me]["HEAL"].Timestamp = GetTime();

				-- Make sure we do not spam messages to the channel
				if (PASettings.Heal.Coop.enabled==true and PanzaComm_Message and (PA.CoOp.LastMessageTime + PA.CoOp.MinMsgInterval) < GetTime()) then
					PA.CoOp.LastMessageTime = GetTime();
					PanzaComm_Message("Panza", "Update, " ..who..", "..PA.Healing[who][me]["HEAL"].Spell..", "..PA.Healing[who][me]["HEAL"].Heal..", "..PA.Healing[who][me]["HEAL"].HoT..", "..CastTime..", "..TimeLeft);
					PA.Healing[who][me]["HEAL"].MessageSent = true;
				else
					if (PA:CheckMessageLevel("Coop",3)) then
						PA:Message4("(CoOp) Message Throttle occured on Update in SpellCastDelayed()");
					end
					PA.Healing[who][me]["HEAL"].MessageSent = false;
				end
			end
		end

		------------------------------------------------------------------------------------------
		-- 2.0 Use settings to determine what to say and whom to say it to if spell delays happen
		------------------------------------------------------------------------------------------
		if (txt ~= '0.0' and (PASettings.Switches.HealProgress == true or PASettings.Switches.MsgLevel.Heal >= 3)) then

			local Message = format(PANZA_NOTIFY_DELAY, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), PA.Cycles.Heal.Bonus, DisplayName, delayedTime, secondSuffix);
			if (PASettings.Switches.MsgLevel.Heal>=3 and PASettings.Switches.HealProgress==true) then

				local WhisperMessage = format(PANZA_NOTIFY_DELAY, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), PA.Cycles.Heal.Bonus, PANZA_MSG_RESURRECT_YOU, delayedTime, secondSuffix);
				PA:MultiMessage(Message, nil, WhisperMessage,
								PASettings.Switches.MsgGroup.Heal,
								PA.Cycles.Spell.Active.target,
								"Heal");

			else
				if (PA:CheckMessageLevel("Heal", 1)) then
					PA:Message4(Message);
				end
			end
		end
	end
end

--------------------------------
-- Spellcast Interrupted Handler
--------------------------------
function PA:SpellcastInterrupted()
	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4(PANZA_EVENT_INTERRUPTED);
	end

	-- Reset casting flag
	PA.CastingNow = false;

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("Interrupted Spell Type: "..PA.Cycles.Spell.Type);
	end

	if (PA.Cycles.Spell.Type ~= "blank") then

		local Name = UnitName(PA.Cycles.Spell.Active.target);
		local DisplayName = Name;
		if (Name~=nil) then
			if (PA.Cycles.Spell.Active.owner~=nil) then
				if (Name==UNKNOWNOBJECT) then
					Name = "Target";
					DisplayName = Name;
				else
					DisplayName = Name.." ("..format(UNITNAME_TITLE_PET, PA.Cycles.Spell.Active.owner)..")";
					Name = PA.Cycles.Spell.Active.owner .. "_" .. Name;
				end
			end
		else
			Name = "Target";
			DisplayName = PA.Cycles.Spell.Active.target;
		end

		-- Broadcast heal spell failure
		if (PA.Cycles.Spell.Type == 'Heal') then
			if (PanzaFrame_HealCurrent~=nil) then
				PanzaFrame_HealCurrent:Hide();
			end
			if (PA:CheckMessageLevel("Heal",5)) then
				PA:Message4("SpellCastInterrupted() Sending Heal Fail Message.");
			end
			local who = Name;
			local spell = PA.Cycles.Spell.Active.spell;

			--[[
			if (PA.Healing[who] ~= nil and PA.PlayerName~=nil) then
				if (PA.Healing[who][PA.PlayerName] ~= nil) then
					PA.Healing[who][PA.PlayerName]["HEAL"].TimeLeft = -1;
					PA.Healing[who][PA.PlayerName]["HEAL"].Status = "FAIL";
				end
			end
			--]]
			-- Make sure we do not spam messages to the channel
			if (PASettings.Heal.Coop.enabled==true and PanzaComm_Message and (PA.CoOp.LastMessageTime + PA.CoOp.MinMsgInterval) < GetTime()) then
				PA.CoOp.LastMessageTime = GetTime();
				PanzaComm_Message("Panza", "Fail, "..who.." ,"..spell..", 0, 0, 0, -1");
			else
				if (PA:CheckMessageLevel("Coop",3)) then
					PA:Message4("(CoOp) Message Throttle occured on Update in SpellCastInterrupted().");
				end
			end
		end

		-- Check if we send fail notices out at all
		-------------------------------------------
		if (PASettings.Switches.NotifyFail == true ) then
			if (PA.Cycles.Spell.Type == 'Heal') then
				if (PA:IsInParty() and UnitInParty(PA.Cycles.Spell.Active.target) and
					PASettings.Switches.MsgGroup.Heal.Party == true) then
					PA:Notify2('PARTY',format(PANZA_NOTIFY_INTERRUPT_HEAL,PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank),PA.Cycles.Heal.Bonus, DisplayName));
				elseif (PA:IsInRaid() and UnitInRaid(PA.Cycles.Spell.Active.target) and
					PASettings.Switches.MsgGroup.Heal.Raid == true) then
					PA:Notify2('RAID',format(PANZA_NOTIFY_INTERRUPT_HEAL,PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank),PA.Cycles.Heal.Bonus, DisplayName));
				else
					if (PA:CheckMessageLevel("Heal", 1)) then
						PA:Message4(format(PA_RED..PANZA_NOTIFY_INTERRUPT_HEAL,PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank),PA.Cycles.Heal.Bonus, DisplayName));
					end
				end
			else
				if (PA:CheckMessageLevel("Core", 1)) then
					PA:Message4(format(PA_RED..PANZA_NOTIFY_INTERRUPT,PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), DisplayName));
				end
			end
		else
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(format(PA_RED..PANZA_NOTIFY_INTERRUPT,PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), DisplayName));
			end
		end

		PA.Cycles.Spell.Active.success = false;
		PA.Cycles.Spell.Type = "blank";
		PA.Cycles.Spell.Active.target = "blank";
	end
end

-- Count players who get a group buff
function PA:StoreGroupBuffRecipients(targetUnit, name, spell, shortSpell, castClass, spellType)

	local Blessed = 0;
	local TotalInGroup = 0;
	local Message;

	local Target = PA:GetSpellProperty(shortSpell, "Target");
	PA:Debug("StoreGroupBuffRecipients Target=", Target);
	if (Target=="C") then -- Class based
		local NumberToCheck;
		local UnitBase;
		if (PA:IsInRaid()) then
			NumberToCheck = PANZA_MAX_RAID; -- Includes self
			UnitBase = "raid";
		else
			NumberToCheck = PANZA_MAX_PARTY - 1; -- Excludes self
			UnitBase = "party";
			PA:Debug("Target Class=", castClass, " OurClass==", PA.PlayerClass);
			if (castClass==PA.PlayerClass) then
				if (PA:UnitHasBlessing("player", shortSpell, false)) then
					if (PA:CheckMessageLevel("Bless", 3)) then
						PA:Message4("  Adding Spell entry for self");
					end
					PA:AddSpell("player", PA.PlayerName, shortSpell, spellType, PA.PlayerClass);
					PA:IncDone(PA.PlayerName);
					Blessed = Blessed + 1;
					TotalInGroup = TotalInGroup + 1;
				else
					PA:Debug("Self not got buff ", shortSpell);
				end
				if (not PA:IsInParty()) then
					NumberToCheck = 0;
				end
			end
		end

		for Index = 1, NumberToCheck do
			local Unit = UnitBase..Index;
			if (UnitExists(Unit)) then
				local __, Class = UnitClass(Unit);
				--PA:ShowText("Unit=", Unit, " Target Class=", castClass, " Unit Class=", Class);
				if (Class~=nil and Class==castClass) then
					local UName = PA:UnitName(Unit);
					--PA:ShowText("UName=", UName, " Visible=", UnitIsVisible(Unit));
					if (UName~="target") then
						if (UnitIsVisible(Unit)) then
							if (PA:UnitHasBlessing(Unit, shortSpell, false)) then
								if (PA:CheckMessageLevel("Bless", 3)) then
									PA:Message4("  Adding Spell entry for "..UName.." ("..Unit..")");
								end
								PA:AddSpell(Unit, UName, shortSpell, spellType, Class);
								PA:IncDone(UName);
								Blessed = Blessed + 1;
							else
								PA:Debug("Unit ", Unit," not got buff ", shortSpell);
							end
						end
					end
					TotalInGroup = TotalInGroup + 1;
				end
			end
		end
		Message = "Blessed "..PA:Capitalize(PA.ClassName[castClass]).." with "..spell.." "..Blessed.."/"..TotalInGroup;
	else
		-- Add for each party member
		local NumberToCheck = PANZA_MAX_PARTY - 1; -- Excludes self
		local UnitBase = "party";
		--PA:ShowText("Target Class=", PA.Cycles.Spell.Active.Class, " OurClass==", PA.PlayerClass);
		if (PA:UnitHasBlessing("player", shortSpell, false)) then
			if (PA:CheckMessageLevel("Bless", 3)) then
				PA:Message4("  Adding Spell entry for self");
			end
			PA:AddSpell("player", PA.PlayerName, shortSpell, spellType, PA.PlayerClass);
			PA:IncDone(PA.PlayerName);
			Blessed = Blessed + 1;
		end
		TotalInGroup = TotalInGroup + 1;
		if (not PA:IsInParty()) then
			NumberToCheck = 0;
		end

		for Index = 1, NumberToCheck do
			local Unit = UnitBase..Index;
			if (UnitExists(Unit)) then
				--PA:ShowText("Unit=", Unit, " Target Class=", castClass, " Unit Class=", Class);
				local UName = PA:UnitName(Unit);
				--PA:ShowText("UName=", UName, " Visible=", UnitIsVisible(Unit));

				if (UName~="target") then
					if (UnitIsVisible(Unit)) then
						if (PA:UnitHasBlessing(Unit, shortSpell, false)) then
							if (PA:CheckMessageLevel("Bless", 3)) then
								PA:Message4("  Adding Spell entry for "..UName.." ("..Unit..")");
							end
							PA:AddSpell(Unit, UName, shortSpell, spellType, Class);
							PA:IncDone(UName);
							Blessed = Blessed + 1;
						end
					end
				end
				TotalInGroup = TotalInGroup + 1;
			end
		end
		Message = "Blessed Party with "..spell.." "..Blessed.."/"..TotalInGroup;
	end
	PA:AddGroupSpell(targetUnit, name, castClass, shortSpell, spellType, castClass, TotalInGroup, Blessed, Target);

	PA:MultiMessage(Message, nil, nil, PASettings.Switches.MsgGroup.Bless, targetUnit, "Bless");

	if (PA.Cycles.Group.Count>1) then
		if (PASettings.Switches.ShowBlessingProgress.enabled or PA.Cycles.Group.Count==PA.Cycles.Group.Done) then
			if (PA:CheckMessageLevel("Bless", 1)) then
				PA:Message4(format(PANZA_BLESS_COUNT, PA.Cycles.Group.Done, PA.Cycles.Group.Count, PA:Percent(PA.Cycles.Group.Done, PA.Cycles.Group.Count)));
			end
		end

		if (PA.Cycles.Group.Count==PA.Cycles.Group.Done) then
			PA:DisplayMissingBlessings();
		end
	end
end

------------------------------------------------------------------------------
-- Spellcast Stop Event Handler
-- 1.31 Spells on Success have a Stop Event. Use this event for messages sent.
------------------------------------------------------------------------------
function PA:SpellcastStop()

	-- Reset casting flag
	PA.CastingNow = false;

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4(PANZA_EVENT_STOP);
	end
	PA:Debug("PA:SpellcastStop() ", PA.Cycles.Spell.Type);
	PA:Debug("(SpellcastStop) spell=", PA.Cycles.Spell.Active.spell, " target=", PA.Cycles.Spell.Active.target);

	---------------------------------------------------------
	-- Dont let PAM process spells that do not have hook data
	---------------------------------------------------------
	if (PA.Cycles.Spell.Type~="blank" and PA.Cycles.Spell.Active.spell and PA.Cycles.Spell.Active.target and PA.Cycles.Spell.Active.target~="blank" and PA.Cycles.Spell.Active.target~="Corpse") then

		local Name = PA.Cycles.Spell.Active.Name;
		if (Name==nil) then
			Name = PA:UnitName(PA.Cycles.Spell.Active.target);
		end
		local DisplayName = Name;
		if (Name~="target") then
			if (PA.Cycles.Spell.Active.owner~=nil) then -- This is a pet
				if (Name==UNKNOWNOBJECT) then
					Name = "Target";
					DisplayName = Name;
				else
					DisplayName = Name.." ("..format(UNITNAME_TITLE_PET, PA.Cycles.Spell.Active.owner)..")";
					Name = PA.Cycles.Spell.Active.owner .. "_" .. Name;
				end
			end
			PA:RemoveFromFailed(nil, Name);
		else
			Name = "Target";
			DisplayName = PA.Cycles.Spell.Active.target;
		end

		if (PA.Cycles.Spell.Type=="Rez") then
			--PA:ShowText("Rez adding ", Name, " ", GetTime());
			PA.Rez[Name] = GetTime(); -- Remember players we have recently rezzed

		------------
		-- Blessings
		------------
		elseif (PA.Cycles.Spell.Type=="Bless") then

			--PA:ShowText("Buff cast");
			if (PA:CheckMessageLevel("Bless", 5)) then
				PA:Message4("Remember blessings");
			end
			--PA:ShowText("Spell=", PA.Cycles.Spell.Active.spell);
			local ShortSpell = PA.Spells.Lookup[PA.Cycles.Spell.Active.spell];
			local ___, Class = UnitClass(PA.Cycles.Spell.Active.target);

			--PA:ShowText("ShortSpell=", ShortSpell, " Class==", Class, " Gt=", PA.SpellBook.GroupBuffs[ShortSpell]);

			-----------------------------
			-- Add blessing to spell List
			-----------------------------
			if (PA.SpellBook.GroupBuffs[ShortSpell]~=nil and PA.Cycles.Spell.Active.owner==nil) then

				--PA:ShowText("Group buff Done=", PA.Cycles.Group.Done);
				if (PA:CheckMessageLevel("Bless", 3)) then
					if (PA.Cycles.Spell.Active.spell~=nil) then PA:Message4("Spell="..PA.Cycles.Spell.Active.spell);end
				end

				PA.GroupBuffs[GetTime()] = {Target=PA.Cycles.Spell.Active.target, Name=Name, Spell=PA.Cycles.Spell.Active.spell, ShortSpell=ShortSpell, CastClass=PA.Cycles.Spell.Active.Class, SpellType=PA.Cycles.Spell.Type};

				PA.Cycles.Spell.Abort 		= false;
				PA.Cycles.Spell.AbortMsg 	= false;
				PA.Cycles.Spell.Type 		= "blank";
				PA.Cycles.Spell["Active"] 	= {spell="blank", rank=0, target="blank", defclass="blank", msgtype="blank", msginfo="blank", owner=nil, Group=false};
				PA.Cycles.Spell["Timer"]	= {start=0, current=0};

				return;

			end

			PA:Debug("Normal buff Done=", PA.Cycles.Group.Done);
			if (Name~=nil) then
				if (PA.Cycles.Spell.Type == "Bless") then
					--PA:ShowText("Adding Spell entry for "..Name.." ("..PA.Cycles.Spell.Active.target..")", "  Spell="..PA.Cycles.Spell.Active.spell);
					if (PA:CheckMessageLevel("Bless", 3)) then
						PA:Message4("Adding Spell entry for "..Name.." ("..PA.Cycles.Spell.Active.target..")");
					end
					if (PA:CheckMessageLevel("Bless", 3)) then
						PA:Message4("  Spell="..PA.Cycles.Spell.Active.spell);
					end
					PA:AddSpell(PA.Cycles.Spell.Active.target, Name, ShortSpell, PA.Cycles.Spell.Type, Class);
					if (PA.Cycles.Spell.Active.msgtype=="CycleBless") then
						PA:IncDone(Name);
					end
				end
			end

			---------------------------------------
			-- If defclass is blank, it wasn't Auto
			---------------------------------------
			if (PA.Cycles.Spell.Active.defclass=="blank") then
				PA.Cycles.Spell.Active.defclass = "(Pick)";
			end

			------------------------------------------------------------
			-- Process Special Announcements that will be local anyway
			-- After each message is processed the hooks MUST be cleared
			------------------------------------------------------------

			---------------------------------
			-- Process Successfull Cyclebless
			---------------------------------
			PA:Debug("msgtype=", PA.Cycles.Spell.Active.msgtype);
			if (PA.Cycles.Spell.Active.msgtype=="CycleBless") then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("Processing CycleBless");
				end

				PA.Cycles.Spell.Active.msginfo = format(PANZA_HASSPELL,
					DisplayName,
					PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank),
					PA.Cycles.Spell.Active.defclass);

				PA:MultiMessage(PA.Cycles.Spell.Active.msginfo, nil, nil,
								PASettings.Switches.MsgGroup.Bless,
								PA.Cycles.Spell.Active.target,
								"Bless");

				if (PA.Cycles.Group.Count > 1) then
					if (PASettings.Switches.ShowBlessingProgress.enabled or PA.Cycles.Group.Count==PA.Cycles.Group.Done) then
						if (PA:CheckMessageLevel("Bless", 1)) then
							PA:Message4(format(PANZA_BLESS_COUNT, PA.Cycles.Group.Done, PA.Cycles.Group.Count, PA:Percent(PA.Cycles.Group.Done, PA.Cycles.Group.Count)));
						end
					end

					if (PA.Cycles.Group.Count==PA.Cycles.Group.Done) then
						PA:DisplayMissingBlessings();
					end
				end

				--------------------------------------------------
				-- Reset Special Process hook data for Cycle Bless
				--------------------------------------------------
				PA.Cycles.Spell.Active.msgtype = "blank";
				PA.Cycles.Spell.Active.msginfo = "blank";

			else

				local Message 		 = format(PANZA_NOTIFY_BLESS_STOP, PA.Cycles.Spell.Active.defclass, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), DisplayName);
				local WhisperMessage = format(PANZA_NOTIFY_BLESS_STOP, PA.Cycles.Spell.Active.defclass, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), PANZA_MSG_RESURRECT_YOU);
				PA:MultiMessage(Message, nil, WhisperMessage,
								PASettings.Switches.MsgGroup.Bless,
								PA.Cycles.Spell.Active.target,
								"Bless");
			end

		------------------------
		-- It was a Curing Spell
		------------------------
		elseif (PA.Cycles.Spell.Type == 'Cure') then
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Cure Announcements");
			end

			local Message 		 = format(PANZA_NOTIFY_CURE_STOP, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), DisplayName);
			local WhisperMessage = format(PANZA_NOTIFY_CURE_STOP, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), PANZA_MSG_RESURRECT_YOU);
			PA:MultiMessage(Message, nil, WhisperMessage,
							PASettings.Switches.MsgGroup.Cure,
							PA.Cycles.Spell.Active.target,
							"Cure");

		-------------------------------
		-- Process a panic mode message
		-------------------------------
		elseif (PA.Cycles.Spell.Type == 'Panic') then
			if (Name~=nil and PA.Spells.Lookup[PA.Cycles.Spell.Active.spell]=="bop") then
				if (PA:CheckMessageLevel("Bless", 5)) then
					PA:Message4("Adding Spell entry for "..Name.."("..PA.Cycles.Spell.Active.target..")");
					PA:Message4("  Spell="..PA.Cycles.Spell.Active.spell);
				end
				PA:AddSpell(PA.Cycles.Spell.Active.target, Name, "bop", PA.Cycles.Spell.Type, Class);

			end
			-- Blessing succeeded, remove from failed list
			PA:RemoveFromFailed(nil, Name);
			if (PA:CheckMessageLevel("Heal", 5)) then
				PA:Message4("Panic Announcements");
			end
			if (PA:CheckMessageLevel("Heal", 1)) then
				PA:Message4(format(PANZA_NOTIFY_PANIC_STOP, PA_RED, PA_YEL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), DisplayName));
			end


		--------------------------------------
		-- Process Heal over Time (HoT) Spells
		--------------------------------------
		elseif (PA.Cycles.Spell.Type == "Heal" and PA.Spells.Lookup[PA.Cycles.Spell.Active.spell]=="HOT") then
			----------------------
			-- 1.31 Reset watchdog
			----------------------
			PA.Cycles.Heal.Timer = 0;

			------------------------------------------------------------------------------------
			-- If we report healing Progress, Talk about healing events, or we are in Debug Mode
			------------------------------------------------------------------------------------
			if (PASettings.Switches.MsgLevel.Heal>0 and PA.Cycles.Spell.Active.target~="blank") then
				
				local Message = format(PANZA_NOTIFY_HOT, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,(PA.Cycles.Spell.Active.rank or 1)), (PA.Cycles.Heal.Bonus or 0), DisplayName);
				-- If MsgLevel >= 2
				if (PASettings.Switches.MsgLevel.Heal >= 2) then

					local WhisperMessage = format(PANZA_NOTIFY_HOT, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,(PA.Cycles.Spell.Active.rank or 1)), (PA.Cycles.Heal.Bonus or 0), PANZA_MSG_RESURRECT_YOU);
					PA:MultiMessage(Message, nil, WhisperMessage,
									PASettings.Switches.MsgGroup.Heal,
									PA.Cycles.Spell.Active.target,
									"Heal");

				-------------------------------------------------------------
				-- Otherwise use a local Message
				-------------------------------------------------------------
				else
					if (PA:CheckMessageLevel("Heal", 1)) then
						PA:Message4(Message);
					end
				end
			end

			---------------------------------------------
			-- Broadcast HoT Healing spell (Coop Healing)
			---------------------------------------------
			if (PA.Spells.Lookup[PA.Cycles.Spell.Active.spell]=="HOT") then
				local who = PA:UnitName(PA.Cycles.Spell.Active.target);
				local me=PA.PlayerName;
				local spell=PA.Cycles.Spell.Active.spell;
				local rank=(PA.Cycles.Spell.Active.rank or 1); -- rank cannot be nil. This is nil protection.
				local ShortSpell="HOT";
				
				if (rank==0) then rank=1; end;  -- There are no un-ranked HoT healing spells. This is nil protection.
				
				if (PA:CheckMessageLevel("Coop",5)) then
					PA:Message4("(Coop) Broadcast Spell="..spell.." Rank="..rank);
				end

				local healmin=PA.SpellBook[ShortSpell][rank].Min;
				local healmax=PA.SpellBook[ShortSpell][rank].Max;
				local healbonus=(PA.Cycles.Heal.Bonus or 0);							-- (or 0 is nil protection)
				local healamount=math.floor(healmin+((healmax-healmin)/2)+healbonus); 	-- avg amount expected total
				local Duration = PA.SpellBook[ShortSpell][rank].Duration;				-- Duration of Spell
				local healtick = math.floor((healamount / Duration) * 3);				-- One Tick amnount (initial hit)
				local hot=healamount;													-- Hot spell total.

				-- Create our own table entry

				PA.Healing[who] = (PA.Healing[who] or {});
				PA.Healing[who][me] = (PA.Healing[who][me] or {});

				PA.Healing[who][me]["HOT"] = {
					["Heal"] = healtick, 			-- amount expected (one tick)
					["HoT"] = hot,					-- Total Expected
					["Spell"] = spell,
					["Status"] = "Active",
					["CastTime"] = 0,				-- Instant Cast
					["TimeLeft"] = Duration  		-- Remaining HoT (Seconds)
					};

				-- Mark the message. We can send it later if needed.
				PA.Healing[who][me]["HOT"].Timestamp = GetTime();

				-- Make sure we do not spam messages to the channel
				if (PASettings.Heal.Coop.enabled==true and PanzaComm_Message and (PA.CoOp.LastMessageTime + PA.CoOp.MinMsgInterval) < GetTime()) then
					PA.CoOp.LastMessageTime = GetTime();
					PanzaComm_Message("Panza", "Update, "..who.." ,"..spell..", "..healtick..", "..hot..", 0, "..Duration);
					PA.Healing[who][me]["HOT"].MessageSent = true;
				else
					if (PA:CheckMessageLevel("Coop", 3)) then
						PA:Message4("(CoOp) Message Throttle occured on Update (Hot Begin).");
					end
					PA.Healing[who][me]["HOT"].MessageSent = false;
				end
			end

		-- Otherwise its a regular heal spell that hit, remove the current heal bars, and send Stop Message
		elseif (PA.Cycles.Spell.Type == "Heal") then
			if (PASettings.Heal.Coop.enabled==true and PanzaComm_Message and (PA.CoOp.LastMessageTime + PA.CoOp.MinMsgInterval) < GetTime()) then
				PA.CoOp.LastMessageTime = GetTime();
				PanzaComm_Message("Panza", "Stop, "..PA:UnitName(PA.Cycles.Spell.Active.target).." ,"..PA.Cycles.Spell.Active.spell..", 0, 0, 0, -1");
			else
				if (PA:CheckMessageLevel("Coop",3)) then
					PA:Message4("(CoOp) Message Throttle occured on Update (Heal Stop).");
				end
			end
			if (PanzaFrame_HealCurrent~=nil) then
				PanzaFrame_HealCurrent:Hide();
			end
		end
	end

	-------------------------------------------------------------
	-- 2.0 Reset PA.Cycles.Spell Data
	-- 3.1 Reset Abort message indicator each time a spell lands
	-------------------------------------------------------------
	PA.Cycles.Spell.Abort 		= false;
	PA.Cycles.Spell.AbortMsg 	= false;
	PA.Cycles.Spell.Type 		= "blank";
	PA.Cycles.Spell["Active"] 	= {spell="blank", rank=0, target="blank", defclass="blank", msgtype="blank", msginfo="blank", owner=nil, Group=false};
	PA.Cycles.Spell["Timer"]	= {start=0, current=0};

end

--------------------------------------
-- Some failures shouldn't be recorded
--------------------------------------
function PA:IgnoreFailedSpell(whyFailed)
	if (whyFailed~=nil) then
		return (PA.IgnoreFails[whyFailed]~=nil)
	end
	return false;
end

-------------------------
-- Spellcast Fail Handler
-------------------------
function PA:SpellcastFail()

	-- Reset casting flag
	PA.CastingNow = false;

	local UName = nil;
	local FailedMessage = PA.LastFailedSpell;
	local WhatFailed, WhyFailed = nil, nil;
	PA.LastFailedSpell = nil;
	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4(PANZA_EVENT_FAIL);
	end
	if (FailedMessage~=nil) then
		__, __, WhatFailed, WhyFailed = string.find(FailedMessage, PANZA_MATCH_FAILED_TITLE);
		if (WhatFailed==nil) then
			WhatFailed= "Unknown";
			WhyFailed = FailedMessage;
		end
		if (PA:CheckMessageLevel("Core", 5)) then
			if (WhatFailed~=nil) then PA:Message4(" What: "..WhatFailed);end
		end
		if (PA:CheckMessageLevel("Core", 5)) then
			if (WhyFailed~=nil) then PA:Message4(" Why:  "..WhyFailed);end
		end
	else
		WhyFailed = "Unknown";
	end
	
	if (PA.Cycles.Spell.Type ~= "blank" and PA.Cycles.Spell.Type ~= nil) then
		if (PA.Cycles.Spell.Active.target~="blank") then

			if (PASettings.Heal.HoTOnMove==true and PA.Cycles.Spell.Type=="Heal" and WhyFailed==SPELL_FAILED_MOVING and PA:SpellInSpellBook("HOT") and not PA:UnitHasBlessing(PA.Cycles.Spell.Active.target, PA.HoTBuff)) then
				if (PA:CheckMessageLevel("Heal", 3)) then
					PA:Message4("HOT whilst moving check WhyFailed="..tostring(WhyFailed));
				end
				local CastWhileMoving = format(CAST_WHILE_MOVING, "");
				if (WhyFailed==SPELL_FAILED_MOVING or string.find(CastWhileMoving, WhyFailed)~=nil) then
					--PA:ShowText("Moving violation");
					-- Cast Instant Heal
					if (PA:CheckMessageLevel("Heal", 3)) then
						PA:Message4("Moving so cast "..PA:GetSpellProperty("HOT", "Name").." on "..PA.Cycles.Spell.Active.target);
					end
					if (PA:HealGivenSpell(PA.Cycles.Spell.Active.target, "HOT", PA.Cycles.Heal.Amount, PA.Cycles.Heal.HealingGearBonus, PA.Cycles.Heal.BuffBonus, 1.0, nil, PA.Cycles.Heal.HwayBonus)) then
						return;
					end
				end
			end
			UName = PA:UnitName(PA.Cycles.Spell.Active.target);

			if (PA:CheckMessageLevel("Core",5)) then
				PA:Message4("Target="..PA.Cycles.Spell.Active.target.." Name="..UName.." type="..PA.Cycles.Spell.Type);
			end

			if (not PA:IgnoreFailedSpell(WhyFailed)) then
				-----------------------------------
				-- Remember a Failed Spells
				-----------------------------------
				if (PA:CheckMessageLevel("Core", 3)) then
					PA:Message4("Processing Failed Spell");
				end

				-----------------
				-- Store Failures
				-----------------
				local totalfail = PA:TableSize(PA.Cycles.Group.Fail);
				if (totalfail==0) then
				   PA.Cycles.Group.Fail = {};
				end

				if (PA:CheckMessageLevel("Core", 3)) then
					PA:Message4("Total failures so far: "..totalfail);
				end

				if (PA.Cycles.Spell.Active.owner~=nil) then
					UName = PA.Cycles.Spell.Active.owner .. "_" .. UName;
				end

				if (PA.Cycles.Group.Fail[UName]==nil or PA.Cycles.Group.Fail[UName].unit==nil) then
					if (PA:CheckMessageLevel("Core", 3)) then
						PA:Message4("New failure "..UName);
					end
					PA.Cycles.Group.Fail[UName] = {unit=PA.Cycles.Spell.Active.target, count=1, Time = GetTime(), LastSpell = PA.Cycles.Spell.Active.spell, LastReason = WhyFailed};
				else
					if (PA:CheckMessageLevel("Core", 3)) then
						PA:Message4("Existing failure "..UName);
					end
					PA.Cycles.Group.Fail[UName].count = PA.Cycles.Group.Fail[UName].count + 1;
					PA.Cycles.Group.Fail[UName].Time = GetTime();
					PA.Cycles.Group.Fail[UName].LastReason = WhyFailed;
				end
				if (PA:CheckMessageLevel("Core", 3)) then
					PA:Message4("New count: "..PA:TableSize(PA.Cycles.Group.Fail));
					PA:Message4("Incrementing Failed list for "..UName.."  (Count="..PA.Cycles.Group.Fail[UName].count..")");
				end
				--PA:ListFailed();
			else
				PA.AbortCurrentLoop = true;
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("Failure ignored");
				end
			end

			if (PA.Cycles.Spell.Type == 'Heal') then

				if (PanzaFrame_HealCurrent~=nil) then
					PanzaFrame_HealCurrent:Hide();
				end

				local Message = format(PANZA_NOTIFY_FAIL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), UName);
				if (PASettings.Switches.NotifyFail == true) then

					local MessageWhisper = format(PANZA_NOTIFY_FAIL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), PANZA_MSG_RESURRECT_YOU);
					PA:MultiMessage(Message, nil, MessageWhisper,
									PASettings.Switches.MsgGroup.Heal,
									PA.Cycles.Spell.Active.target,
									"Heal");
				else
					if (PA:CheckMessageLevel("Heal", 1)) then
						PA:Message4(Message);
					end
				end

				----------------------------------
				--- Broadcast our failure for CoOP
				----------------------------------
				if (PA.Spells.Lookup[PA.Cycles.Spell.Active.spell]=="HOT" or PA.Spells.Lookup[PA.Cycles.Spell.Active.spell]=="HEAL") then
					local type=nil;
					local who=UName;
					local me = PA.PlayerName;
					local spell=PA.Cycles.Spell.Active.spell;

					-- Update our own table entry

					PA.Healing[who] 		= (PA.Healing[who] or {});
					PA.Healing[who][me] 		= (PA.Healing[who][me] or {});

					if (PA.Spells.Lookup[PA.Cycles.Spell.Active.spell]=="HOT") then
						type="HOT";
					elseif (PA.Spells.Lookup[PA.Cycles.Spell.Active.spell]=="HEAL") then
						type="HEAL";
					else
						type="UNKNOWN";
					end

					if (type ~= "UNKNOWN") then
						PA.Healing[who][me][type] 	= (PA.Healing[who][me][type] or {});

						if (PA.Healing[who][me][type].Spell ~= nil and PA.Healing[who][me][type].Spell == spell) then
							PA.Healing[who][me][type].TimeLeft = -1;
							PA.Healing[who][me][type].Status = "FAIL";

							-- Mark the message. We can send it later if needed.
							PA.Healing[who][me][type].Timestamp = GetTime();

							PA:UpdateCurrentHealBar(who,true);

							-- Make sure we do not spam messages to the channel
							if (PASettings.Heal.Coop.enabled==true and PanzaComm_Message and (PA.CoOp.LastMessageTime + PA.CoOp.MinMsgInterval) < GetTime()) then
								PA.CoOp.LastMessageTime = GetTime();
								PanzaComm_Message("Panza", "Fail, " ..who..", "..spell..",0 ,0 ,0, -1");
								PA.Healing[who][me][type].MessageSent = true;
							else
								if (PA:CheckMessageLevel("Coop",3)) then
									PA:Message4("(CoOp) Message Throttle occured on Failure Update.");
								end
								PA.Healing[who][me][type].MessageSent = false;
							end
						else
							if (PA:CheckMessageLevel("Coop",2)) then
								PA:Message4("(CoOp) Spell not in DB \"Heal\" or \"HOT\" : "..spell.." on "..UName);
							end
						end
					end
				end

			elseif (PA.Cycles.Spell.Type == "Bless") then

				local Message = format(PANZA_NOTIFY_FAIL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), UName);
				if (PASettings.Switches.NotifyFail == true) then

					local MessageWhisper = format(PANZA_NOTIFY_FAIL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), PANZA_MSG_RESURRECT_YOU);
					PA:MultiMessage(Message, nil, MessageWhisper,
									PASettings.Switches.MsgGroup.Bless,
									PA.Cycles.Spell.Active.target,
									"Bless");
				else
					if (PA:CheckMessageLevel("Bless", 1)) then
						PA:Message4(Message);
					end
				end

				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("Message Type="..PA.Cycles.Spell.Active.msgtype);
				end

				-------------------------------------------------
				-- Reset PAM hooks, and do it Last. Must be Done.
				-------------------------------------=-----------
				PA.Cycles.Spell.Active.msginfo ="blank";
				PA.Cycles.Spell.Active.msgtype ="blank";


			elseif (PA.Cycles.Spell.Type == "Cure") then

				local Message = format(PANZA_NOTIFY_FAIL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), UName);
				if (PASettings.Switches.NotifyFail == true) then

					local MessageWhisper = format(PANZA_NOTIFY_FAIL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell,PA.Cycles.Spell.Active.rank), PANZA_MSG_RESURRECT_YOU);
					PA:MultiMessage(Message, nil, MessageWhisper,
									PASettings.Switches.MsgGroup.Cure,
									PA.Cycles.Spell.Active.target,
									"Cure");
				else
					if (PA:CheckMessageLevel("Cure", 1)) then
						PA:Message4(Message);
					end
				end

			elseif (PA.Cycles.Spell.Type == "Panic") then
				if (PA:CheckMessageLevel("Heal", 1)) then
					PA:Message4(format(PA_RED..PANZA_NOTIFY_PANIC_FAIL, PA:CombineSpellDisplay(PA.Cycles.Spell.Active.spell, PA.Cycles.Spell.Active.rank), UName));
				end
				PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
			end

		else
			PA:Message(PA_RED..PANZA_NOTIFY_FAIL_UNKNOWN);
		end

		PA.Cycles.Spell.Active.success = false;
	end

	------------------------------
	-- 2.1 Reset PA.Cycles.Spell Data
	-- 3.1 ported abort code from 3.03
	------------------------------
	PA.Cycles.Spell.AbortMsg = false;
	PA.Cycles.Spell.Abort = false;
	PA.Cycles.Spell.Type = "blank";
	PA.Cycles.Spell["Active"] = {spell="blank", rank=0, target="blank", defclass="blank", msgtype="blank", msginfo="blank", owner=nil, Group=false};
	PA.Cycles.Spell["Timer"]  = {start=0, current=0};

end

--------------------------------------------------------------------------
-- Cast the spell passed on the target passed
--	true indicates success, false indicates failure
--------------------------------------------------------------------------
function PA:CastSpell(spell, unit)
	local success 	= true;
	local switched	= false;
	local curefallback 	= nil;

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("Casting spell: "..spell.." on "..unit);
	end

	---------------------------------------------------------------------------
	-- Clear the current target if this is a friend
	-- or else will be cast on in place of the real target
	-- Do not do this for an enemy as it is not necessary
	-- and would occur an interruption of fight
	-- Also do not clear target or flag if this IS who we intend to cast on.
	-- This Fix was originally in 1.01 and has been moved here
	---------------------------------------------------------------------------
	if (UnitIsFriend("player", "target") and not UnitIsUnit(unit, "target")) then
		switched = true;
		ClearTarget();
	end

	-----------------------------------------------------------------------------
	--- Fix for Priest Dispel Magic
	--- Need to check here if we can dispel on target, or switch. For now, switch
	-----------------------------------------------------------------------------
	if (PA.SpellBook["dmag"]~=nil and string.find(spell,PA.SpellBook["dmag"].Name)) then
		if (PA:CheckMessageLevel("Cure",4)) then
			PA:Message4("(CURE) Switching targets to use "..spell);
		end
		switched = true;
		curefallback = PA.InCombat
		ClearTarget();
	end

	-----------------------------------------------------------------
	-- Set the Spell Tracking Data for Times (Internal Cooldown)
	-----------------------------------------------------------------
	PA.Cycles.Spell["Timer"]  = {start=GetTime(), current=GetTime()};

	CastSpellByName(spell);

	if (unit) then
		SpellTargetUnit(unit);
	end

	if (SpellIsTargeting()) then
		success = false;
		SpellStopTargeting();
	end

	---------------------------------------------------------------------------------------------
	-- If needed (see above) target the previous friendly target or enemy in case of dispel magic
	---------------------------------------------------------------------------------------------
	if (switched == true) then
		if (curefallback~=nil and curefallback==true) then
			TargetLastEnemy();
			AttackTarget();
			PA.ForceCombat=true;
		else
			TargetLastTarget();
		end
	end

	return success;
end

function PA:CountBuffedPlayers()
	local TotalBuffs = 0;
	if (PACurrentSpells~=nil and PACurrentSpells.Indi~=nil and PA.SpellBook~=nil) then
		for Name, Set in pairs(PACurrentSpells.Indi) do
			for Id, SpellInfo in pairs(Set) do
				if (SpellInfo.Reset~=true) then
					TotalBuffs = TotalBuffs + 1;
					break;
				end
			end
		end
	end
	return TotalBuffs;
end

function PA:CleanupSpells()
	-- Clean-up spells
	if (PACurrentSpells~=nil and PACurrentSpells.Indi~=nil and PA.SpellBook~=nil) then
		for Name, Set in pairs(PACurrentSpells.Indi) do
			PA:Debug("(CleanupSpells) Name=", Name);
			for Id, SpellInfo in pairs(Set) do
				local Duration = PA:GetSpellProperty(SpellInfo.Short, "Duration");
				if (Duration==nil) then
					break; --Spells not set-up yet
				end
				PA:Debug("(CleanupSpells) Id=", Name, " Time=", GetTime() - SpellInfo.Time, " ", Duration);
				local TimeSinceCast = GetTime() - SpellInfo.Time;
				if (TimeSinceCast>(Duration+30) or TimeSinceCast<0) then
					if (PA:CheckMessageLevel("Core", 5)) then
						PA:Message4("Removing stale spell for "..PA_GREN..Name..PA_WHITE.." - "..PA_BLUE..tostring(SpellInfo.Spell).." "..format("%.0f",SpellInfo.Time));
					end
					PA:Debug("(CleanupSpells) Removing stale spell for ", Name, " - ", SpellInfo.Spell, " ",SpellInfo.Time);
					PACurrentSpells.Indi[Name][Id] = nil;
				else
					PA:Debug("(CleanupSpells) Spell OK");
				end
			end
			if (PA:TableSize(PACurrentSpells.Indi[Name])==0) then
				PA:Debug("(CleanupSpells) Remove whole entry");
				PACurrentSpells.Indi[Name] = nil;
			end
		end
	end

	-- Clean-up group spells
	if (PACurrentSpells~=nil and PACurrentSpells.Group~=nil and PA.SpellBook~=nil) then
		for GroupId, Set in pairs(PACurrentSpells.Group) do
			PA:Debug("GroupId=", GroupId);
			for Id, SpellInfo in pairs(Set) do
				local Duration = PA:GetSpellProperty(SpellInfo.Short, "Duration");
				if (Duration==nil) then
					break; --Spells not set-up yet
				end
				PA:Debug("Id=", Name, " Time=", GetTime() - SpellInfo.Time, " ", Duration);
				local TimeSinceCast = GetTime() - SpellInfo.Time;
				if (TimeSinceCast>(Duration+30) or TimeSinceCast<0) then
					if (PA:CheckMessageLevel("Core", 5)) then
						PA:Message4("Removing stale spell for "..PA_GREN..GroupId..PA_WHITE.." - "..PA_BLUE..tostring(SpellInfo.Spell).." "..SpellInfo.Time);
					end
					PA:Debug( "Removing stale spell for ", GroupId, " - ", SpellInfo.Spell, " ",SpellInfo.Time);
					PACurrentSpells.Group[GroupId][Id] = nil;
				else
					PA:Debug("Spell OK");
				end
			end
			PA:Debug("Group Size=", (PA:TableSize(PACurrentSpells.Group[GroupId])));
			if (PA:TableSize(PACurrentSpells.Group[GroupId])==0) then
				PA:Debug("Remove whole entry");
				PACurrentSpells.Group[GroupId] = nil;
			end
		end
	end

	-- Clean-up failed spells
	if (PA.Cycles.Group.Fail~=nil) then
		for key, value in pairs(PA.Cycles.Group.Fail) do
			if ((GetTime() - value.Time - math.floor(value.count / 5) * PANZA_FAILED_INC)>PANZA_IGNORE_FAILED*3) then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("Removing stale failed spell for "..PA_GREN..key..PA_WHITE.." - "..PA_BLUE..value.LastReason.." "..format("%.0f", value.Time));
				end
				PA.Cycles.Group.Fail[key] = nil;
			end
		end
	end

	-- Clean-up recently rezzed players
	if (PA.Rez~=nil) then
		for key, value in pairs(PA.Rez) do
			if ((GetTime() - value)>120) then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("Removing stale recent rez record for "..PA_GREN..key..PA_WHITE.." -  "..format("%.0f",value));
				end
				--PA:ShowText("Removing stale recent rez record for ", key, " -  ", format("%.0f",value));
				PA.Rez[key] = nil;
			end
		end
	end

end

function PA:AddSpell(unit, name, short, spellType, class)
	PA:RemoveFromFailed(nil, name);
	local Id = PA:GetSpellProperty(short, "BuffId");
	--PA:ShowText("AddSpell for unit=", unit, " name=", name, " spellType=", spellType, " class=", class, " Id=", Id);
	if (Id~=nil) then
		if (unit=="target") then
			unit = PA:FindUnitFromName(name, unit);
		end
		if (PACurrentSpells.Indi[name]==nil) then
			PACurrentSpells.Indi[name] = {};
		end
		PACurrentSpells.Indi[name][Id] = {Unit=unit, Short=short, Spell=PA:GetSpellProperty(short, "Name"), Time=GetTime(), Type=spellType, Class=class};
	end
end

function PA:AddGroupSpell(unit, name, groupid, short, spellType, class, total, count, target)
	local Id = PA:GetSpellProperty(short, "BuffId");
	--PA:ShowText("AddGroupSpell for unit=", unit, " name=", name, " groupid=", groupid, " spellType=", spellType, " class=", class, " total=", total, " count=", count, " Id=", Id);
	if (Id~=nil) then
		if (unit=="target") then
			unit = PA:FindUnitFromName(name);
		end
		if (PACurrentSpells.Group[groupid]==nil) then
			PACurrentSpells.Group[groupid] = {};
		end
		PACurrentSpells.Group[groupid][Id] = {Unit=unit, Name=name, Short=short, Spell=PA:GetSpellProperty(short, "Name"), Time=GetTime(), Type=spellType, Class=class, TotalInGroup=total, Count=count, Target=target};
	end
end

-- Remove group spells if there are no individual spells for that group
function PA:CheckGroupBuffs()
	for GroupId, GroupSet in pairs(PACurrentSpells.Group) do
		--PA:ShowText("GroupId=", GroupId);
		for GroupSpellId, GroupSpellInfo in pairs(GroupSet) do
			local Found = false;
			if (GroupSpellInfo.Target=="C") then
				for Name, IndiSet in pairs(PACurrentSpells.Indi) do
					--PA:ShowText("Name=", Name);
					for IndiId, IndiSpellInfo in pairs(IndiSet) do
						--PA:ShowText("InitId=",IndiId);
						if (IndiSpellInfo.Class==GroupSpellInfo.Class and IndiSpellInfo.Short==GroupSpellInfo.Short) then
							Found = true;
							break;
						end
					end
					if (Found) then
						break;
					end
				end
			else
				Found = true;
			end
			if (not Found) then
				PACurrentSpells.Group[GroupId][GroupSpellId] = nil;
			end
		end
		if (PA:TableSize(PACurrentSpells.Group[GroupId])==0) then
			PACurrentSpells.Group[GroupId] = nil;
		end
	end
end

function PA:RemoveUnitSpell(unit, name)
	if (name==nil) then
		name = PA:UnitName(unit);
		if (name~="target" and not UnitIsPlayer(unit)) then
			local Owner = PA:GetUnitsOwner(unit);
			if (Owner==nil) then
				return;
			end
			name = Owner.."_"..name;
		end
	end
	if (name~="target" and PACurrentSpells.Indi[name]~=nil) then
		if (PA:CheckMessageLevel("Bless", 5)) then
			PA:Message4("Removing "..name.." from Spell list");
		end
		PACurrentSpells.Indi[name] = nil;
		PA:CheckGroupBuffs();
	end
end

function PA:RemoveFromFailed(unit, name)
	if (name==nil and unit~="blank" and unit~="Corpse") then
		name = PA:UnitName(unit);
		if (name~="target" and not UnitIsPlayer(unit)) then
			local Owner = PA:GetUnitsOwner(unit);
			if (Owner==nil) then
				return;
			end
			name = Owner.."_"..name;
		end
	end
	if (name~="target") then
		if (PA.Cycles.Group.Fail[name]~=nil) then
			if (PA:CheckMessageLevel("Bless", 5)) then
				PA:Message4("Removing "..name.." from Fail list");
			end
			PA.Cycles.Group.Fail[name] = nil;
		end
	end
end
