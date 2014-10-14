-- WARNING
-- THE COMMENTED OUT ABILITIES ARE THERE FOR A REASON
-- PLEASE DO NOT UNCOMMENT THEM, OTHERWISE THINGS WILL PROBABLY BREAK

if ( GetLocale() == "frFR" ) then

	-- Internal Spell Names
	CECB_SPELL_STUN_DR = "Stun DR";
	CECB_SPELL_FRENZY_CD = "Frenzy (CD)";

	CEnemyCastBar_Spells = {

		-- IMPORTANT: Maybe some spells which cause debuffs have to be moved to CEnemyCastBar_Afflicitions to be shown
		-- "t=x" defines the normal length of the castbar. "d=x" will add a cooldown timer for spells with a casttime and for gains.
		-- "g=0" prevents a bar if a player gains this spell. "g=x" shows a bar of x seconds instead of "t=x" if it's a gain.
		-- "i=x" shows a bar of x seconds additional to "t" (everytime)

		-- All Classes
			-- General
		["Pierre de foyer"] = {t=10.0, icontex="INV_Misc_Rune_01"};
		
			-- Trinkets & Racials
		["Armure fragile"] = 					{t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
		["Pouvoir Instable"] = 					{t=20.0, d=120, icontex="Spell_Lightning_LightningBolt01"}; -- gain
		["Force Sup\195\169rieure"] = 				{t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
		["Pouvoir \195\169ph\195\169m\195\168re"] = 		{t=15.0, d=90, icontex="Spell_Holy_MindVision"}; -- gain
		["Puissance des Arcanes"] = 				{t=15.0, d=180, icontex="Spell_Nature_Lightning"}; -- gain
		["Destruction Massive"] = 				{t=20.0, d=180, icontex="Spell_Fire_WindsofWoe"}; -- gain
		["Pouvoir des Arcanes"] = 				{t=20.0, d=180, icontex="Spell_Arcane_StarFire"}; -- gain
		["Bouclier dynamis\195\169"] = 				{t=20.0, d=180, icontex="Spell_Nature_CallStorm"}; -- gain
		["Lumi\195\168re \195\169clatante"] = 			{t=20.0, d=180, icontex="Spell_Holy_MindVision"}; -- gain
		["Volont\195\169 des R\195\169prouv\195\169s"] = 	{t=5.0, d=120, icontex="Spell_Shadow_RaiseDead"}; -- gain
		["Perception"] = 					{t=20.0, d=180, icontex="Spell_Nature_Sleep"}; -- gain
		["Acc\195\169l\195\169ration mentale de Mar'li"] = 	{t=30.0, d=180, icontex="INV_ZulGurubTrinket"}; -- gain
		["Choc martial"] = 					{t=0.5, d=120, icontex="Ability_WarStomp"};
		["Forme de pierre"] =					{t=8.0, d=180, icontex="Spell_Shadow_UnholyStrength"};

		["Choc de terre"] = 					{t=20.0, d=120, icontex="Spell_Nature_AbolishMagic"}; -- gain
		["Don de vie"] = 					{t=20.0, d=300, icontex="INV_Misc_Gem_Pearl_05"}; -- gain
		["Alignement sur la nature"] = 				{t=20.0, d=300, icontex="Spell_Nature_SpiritArmor"}; -- gain

			-- Engineering
	        ["R\195\169flectogivre"] = 				{t=5.0, d=300.0, icontex="Spell_Frost_FrostWard"}; -- gain
	        ["R\195\169flectombre"] = 				{t=5.0, d=300.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
	        ["R\195\169flectofeu"] = 				{t=5.0, d=300.0, icontex="Spell_Fire_SealOfFire"}; -- gain

			-- First Aid
		["Premiers soins"] = 					{t=8.0, d=60, icontex="Spell_Holy_Heal"}; -- gain
		["Bandage en lin"] = 					{t=3.0, icontex="INV_Misc_Bandage_15"};
		["Bandage \195\169pais en lin"] = 			{t=3.0, icontex="INV_Misc_Bandage_18"};
		["Bandage en laine"] = 					{t=3.0, icontex="INV_Misc_Bandage_14"};
		["Bandage \195\169pais en laine"] = 			{t=3.0, icontex="INV_Misc_Bandage_17"};
		["Bandage en soie"] = 					{t=3.0, icontex="INV_Misc_Bandage_01"};
		["Bandage \195\169pais en soie"] = 			{t=3.0, icontex="INV_Misc_Bandage_02"};
		["Bandage en tissu de mage"] = 				{t=3.0, icontex="INV_Misc_Bandage_19"};
		["Bandage \195\169pais en tissu de mage"] = 		{t=3.0, icontex="INV_Misc_Bandage_20"};
		["Bandage en \195\169toffe runique"] = 			{t=3.0, icontex="INV_Misc_Bandage_11"};
		["Bandage \195\169pais en \195\169toffe runique"] = 	{t=3.0, icontex="INV_Misc_Bandage_12"};
		                                                                                                                      
		-- Druid                                                                                                              
		["Toucher gu\195\169risseur"] = 			{t=3.0, icontex="Spell_Nature_HealingTouch"};
		["R\195\169tablissement"] = 				{t=2.0, g=21.0, icontex="Spell_Nature_ResistNature"};
		["Renaissance"] = 					{t=2.0, d=1800.0, icontex="Spell_Nature_Reincarnation"};
		["Feu stellaire"] = 					{t=3.0, icontex="Spell_Arcane_StarFire"};
		["Col\195\168re"] = 					{t=1.5, icontex="Spell_Nature_AbolishMagic"};
		["Sarments"] = 						{t=1.5, icontex="Spell_Nature_StrangleVines"};
		["C\195\169l\195\169rit\195\169"] = 			{t=15.0, d=300.0, icontex="Ability_Druid_Dash"}; -- gain
		["Hibernation"] = 					{t=1.5, icontex="Spell_Nature_Sleep"};
		["Apaiser les animaux"] = 				{t=1.5, icontex="Ability_Hunter_BeastSoothe"};
		["Ecorce"] = 						{t=15.0, d=60, icontex="Spell_Nature_StoneClawTotem"}; -- gain
		["Innervation"] = 					{t=20.0, icontex="Spell_Nature_Lightning"}; -- gain
		["T\195\169l\195\169portation : Moonglade"] = 		{t=10.0, icontex="Spell_Arcane_TeleportMoonglade"};
		["Fureur du tigre"] = 					{t=6.0, icontex="Ability_Mount_JungleTiger"}; -- gain
		["R\195\169g\195\169n\195\169ration fr\195\169n\195\169tique"] = 	{t=10.0, d=180.0, icontex="Ability_BullRush"}; -- gain
		["R\195\169cup\195\169ration"] = 			{t=12.0, icontex="Spell_Nature_Rejuvenation"}; -- gain
		["Abolir le poison"] = 					{t=8.0, icontex="Spell_Nature_NullifyPoison_02"}; -- gain
		["Tranquilit\195\169"] = 	{t=10.0, d=300.0, icontex="Spell_Nature_Tranquility"};
		["Emprise de la nature"] = 		{t=45, d=60, icontex="Spell_Nature_NaturesWrath"}; -- talent gain
		--["Cyclone"] = 		{t=1.5, icontex=""};
		--["Fleur de vie"] = 		{t=7, icontex=""}; -- gain
		
		-- Hunter                                                 
		["Vis\195\169e"] = 		{t=3.0, d=6.0, icontex="INV_Spear_07"};
		["Effrayer une b\195\170te"] = 	{t=1.0, d=30.0, icontex="Ability_Druid_Cower"};
		["Salve"] = 			{t=6.0, d=60.0, icontex="Ability_Marksmanship"};
		["Renvoyer le familier"] = 	{t=5.0, icontex="Spell_Nature_SpiritWolf"};
		["Ressusciter le familier"] = 	{t=10.0, icontex="Ability_Hunter_BeastSoothe"};
		["Oeil de la b\195\170te"] = 	{t=2.0, icontex="Ability_EyeOfTheOwl"};
		["Tir rapide"] = 		{t=15.0, d=300.0, icontex="Ability_Hunter_RunningShot"}; -- gain
		["Dissuasion"] = 		{t=10, d=300.0, icontex="Ability_Whirlwind"}; -- gain
		["Fl\195\168ches multiples"] = 	{d=10.0, icontex="Ability_UpgradeMoonGlaive"};
		["Courroux bestial"] = 		{t=18, d=120.0, icontex="Ability_Druid_FerociousBite"}; -- Pet gain
		--["La b\195\170te int\195\169rieure"] = 	{t=18, d=120, icontex=""}; -- gain, Talent


		-- Mage
		["Eclair de givre"] = {t=2.5, icontex="Spell_Frost_FrostBolt02"};
		["Boule de feu"] = {t=3.0, icontex="Spell_Fire_FlameBolt"};
		["Invocation d'eau"] = {t=3.0, icontex="INV_Drink_18"};
		["Invocation de nourriture"] = {t=3.0, icontex="INV_Misc_Food_33"};
		["Invocation d'un rubis de mana"] = {t=3.0, icontex="INV_Misc_Gem_Ruby_01"};
		["Invocation d'une citrine de mana"] = {t=3.0, icontex="INV_Misc_Gem_Opal_01"};
		["Invocation d'une jade de mana"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_02"};
		["Invocation d'une agate de mana"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_01"};
		["M\195\169tamorphose"] = {t=1.5, icontex="Spell_Nature_Polymorph"};
		["M\195\169tamorphose : cochon"] = {t=1.5, icontex="Spell_Magic_PolymorphPig"};
		["M\195\169tamorphose : tortue"] = {t=1.5, icontex="Ability_Hunter_Pet_Turtle"};
		["Explosion pyrotechnique"] = {t=6.0, icontex="Spell_Fire_Fireball02"};
		["Br\195\187lure"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
		["Choc de flammes"] = {t=3.0, r="Eveilleur Griffemort", a=2.5, icontex="Spell_Fire_SelfDestruct"};
		["Chute lente"] = {t=30.0, icontex="Spell_Magic_FeatherFall"}; -- gain
		["Portail : Darnassus"] = {t=10.0, icontex="Spell_Arcane_PortalDarnassus"};
		["Portail : Thunder Bluff"] = {t=10.0, icontex="Spell_Arcane_PortalThunderBluff"};
		["Portail : Ironforge"] = {t=10.0, icontex="Spell_Arcane_PortalIronForge"};
		["Portail : Orgrimmar"] = {t=10.0, icontex="Spell_Arcane_PortalOrgrimmar"};
		["Portail : Stormwind"] = {t=10.0, icontex="Spell_Arcane_PortalStormWind"};
		["Portail : Undercity"] = {t=10.0, icontex="Spell_Arcane_PortalUnderCity"};
		["T\195\169l\195\169portation : Darnassus"] = {t=10.0, icontex="Spell_Arcane_TeleportDarnassus"};
		["T\195\169l\195\169portation : Thunder Bluff"] = {t=10.0, icontex="Spell_Arcane_TeleportThunderBluff"};
		["T\195\169l\195\169portation : Ironforge"] = {t=10.0, icontex="Spell_Arcane_TeleportIronForge"};
		["T\195\169l\195\169portation : Orgrimmar"] = {t=10.0, icontex="Spell_Arcane_TeleportOrgrimmar"};
		["T\195\169l\195\169portation : Stormwind"] = {t=10.0, icontex="Spell_Arcane_TeleportStormWind"};
		["T\195\169l\195\169portation : Undercity"] = {t=10.0, icontex="Spell_Arcane_TeleportUnderCity"};
		["Gardien de feu"] = {t=30.0, icontex="Spell_Fire_FireArmor"}; -- gain
		["Gardien de givre"] = {t=30.0, icontex="Spell_Frost_FrostWard"}; -- gain
		["Evocation"] = {t=8.0, icontex="Spell_Nature_Purge"}; -- gain
		["Parade de glace"] = {t=10.0, d=300.0, icontex="Spell_Frost_Frost"}; -- gain
		["Barri\195\168re de glace"] = {d=30.0, icontex="Spell_Ice_Lament"};
		["Transfert"] = {d=15.0, icontex="Spell_Arcane_Blink"};
		--["Invisibilit\195\169"] = {t=8, d=300, icontex=""}; -- gain
		--["Javelot de glace"] = {t=1.5, icontex=""};
		--["Eclair d'eau"] = {t=2.5, icontex=""}; -- Mage Talent ('Pet' Spell)

		
		-- Paladin
		["Lumi\195\168re sacr\195\169e"] = {t=2.5, icontex="Spell_Holy_HolyBolt"};
		["Eclair lumineux"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
		["Invocation d'un destrier"] = {t=3.0, g=0.0, icontex="Ability_Mount_Charger"};
		["Invocation d'un Cheval de Guerre"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
		["Marteau de courroux"] = {t=1.0, d=6.0, icontex="Ability_ThunderClap"};
		["Col\195\168re divine"] = {t=2.0, d=60.0, icontex="Spell_Holy_Excorcism"};
		["Renvoi des morts-vivants"] = {t=1.5, d=30.0, icontex="Spell_Holy_TurnUndead"};
		["R\195\169demption"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
		["Protection divine"] = {t=8.0, d=300.0, icontex="Spell_Holy_Restoration"}; -- gain
		["Bouclier divin"] = {t=12.0, d=300.0, icontex="Spell_Holy_DivineIntervention"}; -- gain
		["Sceau de libert\195\169"] = {t=16.0, icontex="Spell_Holy_SealOfValor"}; -- gain
		["Sceau de protection"] = {t=10.0, d=300.0, icontex="Spell_Holy_SealOfProtection"}; -- gain
		["Blessing of Sacrifice"] = {t=30.0, icontex="Spell_Holy_SealOfSacrifice"}; -- gain
		["Vengeance"] = {t=8.0, icontex="Ability_Racial_Avatar"}; -- gain, Talent
		--["Courroux vengeur"] = {t=20, d=180, icontex=""}; -- gain
		--["Illumination divine"] = {t=10, d=180, icontex=""}; -- gain, Talent
		--["Bouclier du vengeur"] = {t=1, d=30, icontex=""}; -- Talent

	
		-- Priest
		["Soins sup\195\169rieurs"] = {t=2.5, g=15, icontex="Spell_Holy_GreaterHeal"};
		["Soins"] = {t=2.5, icontex="Spell_Holy_Heal"};
		["Soins rapides"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
		["R\195\169surrection"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
		["Ch\195\162timent"] = {t=2.0, icontex="Spell_Holy_HolySmite"};
		["Attaque mentale"] = {t=1.5, d=8.0, icontex="Spell_Shadow_UnholyFrenzy"};
		["Contr\195\180le mental"] = {t=3.0, g=0.0, icontex="Spell_Shadow_ShadowWordDominate"};
		["Br\195\187lure de mana"] = {t=3.0, icontex="Spell_Shadow_ManaBurn"};
		["Feu int\195\169rieur"] = {t=3.0, icontex="Spell_Holy_SearingLight"};
		["Apaisement"] = {t=1.5, icontex="Spell_Holy_MindSooth"};
		["Pri\195\168re de soins"] = {t=3.0, icontex="Spell_Holy_PrayerOfHealing02"};
		["Entraves des morts-vivants"] = {t=1.5, icontex="Spell_Nature_Slow"};
		["Oubli"] = {t=10.0, d=30.0, icontex="Spell_Magic_LesserInvisibilty"}; -- gain
		["R\195\169novation"] = {t=15.0, icontex="Spell_Holy_Renew"}; -- gain
		["Abolir maladie"] = {t=20.0, icontex="Spell_Nature_NullifyDisease"}; -- gain
		["R\195\169action"] = {t=15.0, icontex="Spell_Shadow_RitualOfSacrifice"}; -- gain
		["Inspiration"] = {t=15.0, icontex="INV_Shield_06"}; -- gain (target), Talent
		["Infusion de puissance"] = {t=15.0, icontex="Spell_Holy_PowerInfusion"}; -- gain, Talent
		["Incantation focalis\195\169e"] = {t=6.0, icontex="Spell_Arcane_Blink"}; -- gain, Talent
		["Mot de pouvoir : Bouclier"] = {t=30, d=15.0, icontex="Spell_Holy_PowerWordShield"}; -- gain
		["Armure de la Foi"] = {t=30.0, icontex="Spell_Holy_BlessingOfProtection"}; -- gain, Priest Tier 3 [Vestments of Faith] 4/9 Proc
		["Focalisation am\195\169lior\195\169e"] = {d=180, icontex="Spell_Frost_WindWalkOn"}; -- gain, Talent
		--["Dissipation de masse"] = {t=1.5, icontex=""};
		--["Soins de lien"] = {t=1.5, icontex=""};
		--["Suppression de la douleur"] = {t=8, d=180, icontex=""}; -- gain, Talent
		--["Toucher vampirique"] = {t=1.5, icontex=""}; -- Talent


		-- Rogue
		["D\195\169sarmement de pi\195\168ge"] = {t=2.0, icontex="Spell_Shadow_GrimWard"};
		["Sprint"] = {t=15.0, d=300.0, icontex="Ability_Rogue_Sprint"}; -- gain
		["Crochetage"] = {t=5.0, icontex="Spell_Nature_MoonKey"};
		["Evasion"] = {t=15.0, d=300, icontex="Spell_Shadow_ShadowWard"}; -- gain
		["Disparition"] = {t=10.0, d=300, icontex="Ability_Vanish"}; -- gain
		["Deluge de lames"] = {t=15.0, d=120, icontex="Ability_Rogue_SliceDice"}; -- gain

		["Poison instantan\195\169 VI"] = {t=3.0, icontex="Ability_Poisons"};
		["Poison mortel V"] = {t=3.0, icontex="Ability_Rogue_DualWeild"};
		["Poison affaiblissant"] = {t=3.0, icontex="Ability_PoisonSting"};
		["Poison affaiblissant II"] = {t=3.0, icontex="Ability_PoisonSting"};
		["Poison de distraction mentale"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Poison de distraction mentale II"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Poison de distraction mentale III"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		--["Pous\195\169e d'adr\195\169naline"] = {t=15, d=300, icontex=""}; -- gain, Talent
		--["Cape d'ombre"] = {t=5, d=120, icontex=""}; -- gain, Talent

		
		-- Shaman
		["Vague de soins inf\195\169rieurs"] = {t=1.5, icontex="Spell_Nature_HealingWaveLesser"};
		["Vague de soins"] = {t=2.5, icontex="Spell_Nature_MagicImmunity"}; -- talent
		["Esprit ancestral"] = {t=10.0, icontex="Spell_Nature_Regenerate"};
		["Cha\195\174ne d'\195\169clairs"] = {t=1.5, d=6.0, icontex="Spell_Nature_ChainLightning"}; -- Talent counted
		["Loup fant\195\180me"] = {t=1.0, icontex="Spell_Nature_SpiritWolf"};
		["Rappel astral"] = {t=10.0, icontex="Spell_Nature_AstralRecal"};
		["Salve de gu\195\169rison"] = {t=2.5, icontex="Spell_Nature_HealingWaveGreater"};
		["Eclair"] = {t=2.0, icontex="Spell_Nature_Lightning"}; -- Talent counted
		["Double vue"] = {t=2.0, icontex="Spell_Nature_FarSight"};
		["Totem de Griffes de pierre"] = {t=15.0, d=30.0, icontex="Spell_Nature_StoneClawTotem"}; -- gain
		["Totem Fontaine de mana"] = {t=15.0, d=300.0, icontex="Spell_Frost_SummonWaterElemental"}; -- gain
		["Totem Nova de feu"] = {t=5.0, d=15.0, icontex="Spell_Fire_SealOfFire"}; -- gain
		["Courroux naturel"] = {t=12.0, d=25, icontex="Spell_Holy_SealOfMight"}; -- gain
		["Robustesse des anciens"] = {t=15.0, icontex="Spell_Nature_UndyingStrength"}; -- gain (target), Talent
		["Flots de soins"] = {t=15.0, icontex="Spell_Nature_HealingWay"}; -- gain (target), Talent
		["Totem de Gl\195\168be"] = {d=15.0, icontex="Spell_Nature_GroundingTotem"}; -- works?
		["Ma\195\174trise \195\169l\195\169mentaire"] = {d=180, icontex="Spell_Nature_WispHeal"}; -- gain, Talent
		--["Rage du chaman"] = {t=30, d=120, icontex=""}; -- gain, Talent

		
		-- Warlock
		["Trait de l'ombre"] = {t=2.5, icontex="Spell_Shadow_ShadowBolt"};
		["Immolation"] = {t=1.5, icontex="Spell_Fire_Immolation"};
		["Feu de l'\195\162me"] = {t=4.0, d=60.0, icontex="Spell_Fire_Fireball02"};
		["Douleur br\195\187lante"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
		["Invocation d'un Destrier de l'Effroi"] = {t=3.0, g=0.0, icontex="Ability_Mount_Dreadsteed"};
		["Invocation d'un palefroi corrompu"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
		["Invocation d'un diablotin"] = {t=6.0, icontex="Spell_Shadow_Imp"};
		["Invocation d'une succube"] = {t=6.0, icontex="Spell_Shadow_SummonSuccubus"};
		["Invocation d'un marcheur du Vide"] = {t=6.0, icontex="Spell_Shadow_SummonVoidWalker"};
		["Invocation d'un chasseur corrompu"] = {t=6.0, icontex="Spell_Shadow_SummonFelHunter"};
		["Peur"] = {t=1.5, icontex="Spell_Shadow_Possession"};
		["Hurlement de terreur"] = {t=2.0, d=40.0, g=0.0, icontex="Spell_Shadow_DeathScream"};
		["Bannir"] = {t=1.5, icontex="Spell_Shadow_Cripple"};
		["Rituel d'invocation"] = {t=5.0, icontex="Spell_Shadow_Twilight"};
		["Rituel de mal\195\169diction"] = {t=10.0, icontex="Spell_Shadow_AntiMagicShell"};
		["Cr\195\169ation de Pierre de sort"] = {t=5.0, icontex="INV_Misc_Gem_Sapphire_01"};
		["Cr\195\169ation de Pierre d'\195\162me"] = {t=3.0, icontex="Spell_Shadow_SoulGem"};
		["Cr\195\169ation de Pierre de soins"] = {t=3.0, icontex="INV_Stone_04"};
		["Cr\195\169ation de Pierre de soins majeure"] = {t=3.0, icontex="INV_Stone_04"};
		["Cr\195\169ation de Pierre de feu"] = {t=3.0, icontex="INV_Ammo_FireTar"};
		["Asservir d\195\169mon"] = {t=3.0, icontex="Spell_Shadow_EnslaveDemon"};
		["Infernal"] = {t=2.0, d=3600, icontex="Spell_Fire_Incinerate"};
		["Gardien de l'ombre"] = {t=30.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
		["Mal\195\169diction amplifi\195\169e"] = {t=30.0, d=180, icontex="Spell_Shadow_Contagion"}; -- gain
		--["Graine de Corruption"] = {t=2, icontex=""};
		--["Rituel des \195\162mes"] = {t=3, d=300, icontex=""};
		--["Incin\195\169rer"] = {t=2.5, icontex=""};
        	   
			-- Imp
			["Eclair de Feu"] = {t=1.5, icontex="Spell_Fire_FireBolt"};
			
			-- Succubus
			["S\195\169duction"] = {t=1.5, icontex="Spell_Shadow_MindSteal"};
			["Baiser apaisant"] = {t=4.0, d=4.0, icontex="Spell_Shadow_SoothingKiss"};
			
			-- Voidwalker
			["Consumer les ombres"] = {t=10.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
		
		-- Warrior
		["Rage sanguinaire"] = {t=10.0, d=60, icontex="Ability_Racial_BloodRage"}; -- gain
		["Sanguinaire"] = {t=8.0, icontex="Spell_Nature_BloodLust"}; -- gain
		["Mur protecteur"] = {t=10.0, d=1800.0, icontex="Ability_Warrior_ShieldWall"}; -- gain
		["T\195\169m\195\169rit\195\169"] = {t=15.0, d=1800.0, icontex="Ability_CriticalStrike"}; -- gain
		["Repr\195\169sailles"] = {t=15.0, d=1800.0, icontex="Ability_Warrior_Challange"}; -- gain
		["Rage berserker"] = {t=10.0, d=30, icontex="Spell_Nature_AncestralGuardian"}; -- gain
	        ["Dernier rempart"] = {t=20.0, d=600, icontex="Spell_Holy_AshesToAshes"}; -- gain
		--["Dernier rempart"] = {t=20.0, d=480, icontex="Spell_Holy_AshesToAshes"}; -- gain
	        ["Souhait mortel"] = {t=30.0, d=180, icontex="Spell_Shadow_DeathPact"}; -- gain
	        -- ["Enrager"] = {t=12.0, icontex="Spell_Shadow_UnholyFrenzy"}; -- gain
		["Ma\195\174trise du blocage"] = {t=5.5, icontex="Ability_Defend"}; -- gain, 1 Talent point in impr. block
		--["Ivresse de la victoire"] = {t=30, icontex=""}; -- gain
		--["Renvoi de sort"] = {t=5, d=10, icontex=""}; -- gain


		-- Mobs
	        ["Rapetisser"] = {t=3.0, icontex="Spell_Ice_MagicDamage"};
	        ["Mal\195\169diction de la Banshee"] = {t=2.0, icontex="Spell_Nature_Drowsy"};
	        ["Salve de Traits de l'ombre"] = {t=3.0, icontex="Spell_Shadow_ShadowBolt"};
	        ["Faiblesse"] = {t=3.0, icontex="Spell_Shadow_Cripple"};
	        ["Gu\195\169rison t\195\169n\195\169breuse"] = {t=3.5, icontex="Spell_Shadow_ChillTouch"}; -- gain
		["D\195\169cr\195\169pitude spirituelle"] = {t=2.0, icontex="Spell_Holy_HarmUndeadAura"};
		["Bourrasque"] = {t=2.0, icontex="Spell_Nature_EarthBind"};
		["Limace noire"] = {t=3.0, icontex="Spell_Shadow_CallofBone"};
		["Eclair toxique"] = {t=2.0, icontex="Spell_Nature_CorrosiveBreath"};
		["Crachat empoisonn\195\169"] = {t=2.0, icontex="Spell_Nature_CorrosiveBreath"};
		["R\195\169g\195\169n\195\169ration sauvage"] = {t=3.0, g=0, icontex="Spell_Nature_Rejuvenation"};
		["Mal\195\169diction des Mort-bois"] = {t=2.0, icontex="Spell_Shadow_GatherShadows"};
		["Mal\195\169diction du Sang"] = {t=2.0, icontex="Spell_Shadow_RitualOfSacrifice"};
		["Limace des t\195\169n\195\168bres"] = {t=5.0, icontex="Spell_Shadow_CreepingPlague"};
		["Nu\195\169e de peste"] = {t=2.0, icontex="Spell_Shadow_CallofBone"};
		["Peste galopante"] = {t=2.0, icontex="Spell_Shadow_CallofBone"};
		["Toucher de fl\195\169trissement"] = {t=2.0, icontex="Spell_Nature_Drowsy"};
		["Fatigue fi\195\168vreuse"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Rets enveloppants"] = {t=2.0, icontex="Spell_Nature_EarthBind"};
		["Regard de cristal"] = {t=2.0, icontex="Ability_GolemThunderClap"};
		["Crachat de flammes"] = {t=3.0, icontex="Spell_Fire_FlameBolt"};
		["Trait de l\195\169zard"] = {t=2.0, icontex="Spell_Nature_Lightning"};
		["Esprit pestif\195\169r\195\169"] = {t=4.0, icontex="Spell_Shadow_CallofBone"};

		
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
			["First Locust Swarm"] = {t=90, c="cooldown", icontex="Spell_Nature_InsectSwarm"};
			["Essaim de sauterelles"] = {t=23, i=3, c="gains", delBar="Essaim de sauterelles CD", aBar="Essaim de sauterelles CD", active="true", icontex="Spell_Nature_InsectSwarm"}; --? to be checked!
			["Essaim de sauterelles CD"] = {t=70, c="cooldown", icontex="Spell_Nature_InsectSwarm"};

			-- Patchwerk
			["Enraged Mode"] = {t=420, c="cooldown", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally!

			-- Razuvious
			["Cri perturbant"] = {t=25, c="cooldown", active="true", icontex="Ability_Creature_Disease_02"};

			-- Gluth
			["Rugissement terrifiant"] = {t=20.0, c="cooldown", m="Gluth", icontex="Ability_Devour"}; -- Gluth Fears every 20seconds
			["D\195\169cimer"] = {t=105, c="cooldown", active="true", icontex="Ability_Creature_Disease_02"};

			-- Maexxna
			["Jet de rets"] = {t=40, c="cooldown", pBar="Petite araign\195\169e", m="Maexxna", aZone="Naxxramas", icontex="Ability_Ensnare"};
			["Petite araign\195\169e"] = {t=30, c="cooldown", pBar="Entoilage CD", icontex="INV_Misc_MonsterSpiderCarapace_01"};
			["Entoilage CD"] = {t=20, c="cooldown", icontex="Spell_Nature_Web"};

			-- Thaddius
			["Changement de polarit\195\169"] = {t=30, i=3, c="cooldown", mcheck="Thaddius", pBar="Becomes enraged!", icontex="Spell_Nature_Lightning"};
			["Vague de puissance"] = {t=10, c="gains", mcheck="Stalagg", icontex="Spell_Shadow_SpectralSight"};
			["Becomes enraged!"] = {t=290, c="cooldown", global="true", tchange={"Becomes enraged!", 290, 0}, icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally! -- wont be updated

			-- Faerlina
			["Enrager"] = {t=60, c="cooldown", mcheck="Grande veuve Faerlina", icontex="Spell_Shadow_UnholyFrenzy"};
			["Etreinte de la veuve"] = {t=30, c="cooldown", mcheck="Grande veuve Faerlina", icontex="Spell_Arcane_Blink"}; -- Fearlina

			-- Loatheb
			["15 sec Doom CD!"] = {t=299, tchange={"Mal\195\169diction in\195\169vitable", 30, 15}, c="cooldown", m="Horreb", icontex="Spell_Shadow_NightOfTheDead"}; -- don't translate, used internally!
			["First Inevitable Doom"] = {t=120, c="cooldown", m="Horreb", icontex="Spell_Shadow_NightOfTheDead"}; -- don't translate, used internally!
			["Mal\195\169diction in\195\169vitable"] = {t=30, c="cooldown", m="Horreb", icontex="Spell_Shadow_NightOfTheDead"};

			["Invocation de spore"] = {t=12.5, icasted="true", c="cooldown", mcheck="Horreb", icontex="Spell_Nature_AbolishMagic"};
			["D\195\169livrance de la mal\195\169diction sur Horreb"] = {t=0.1, icasted="true", c="cooldown", pBar="Curses Removed", mcheck="Horreb"};
			["Curses Removed"] = {t=30, c="cooldown", icontex="Spell_Nature_RemoveCurse"}; -- TRANSLATE TO Above PBAR only

			-- Gothik
			-- don't translate, ALL used internally!
			["Comes Down"] = {t=270, c="cooldown", aBar="del1", icontex="Spell_Shadow_RaiseDead"};
			["del1"] = {t=0.1, pBar="del2", delBar="Trainees INC"};
			["del2"] = {t=0.1, pBar="del3", delBar="Deathknights INC"};
			["del3"] = {t=0.1, delBar="Rider INC"};
			
			["First Trainees"] = {t=27, c="cooldown", aBar="Trainees INC", icontex="INV_Misc_Head_Undead_01"};
			["First Deathknights"] = {t=77, c="cooldown", aBar="Deathknights INC", icontex="Spell_Shadow_ShadowWard"};
			["First Rider"] = {t=137, c="cooldown", aBar="Rider INC", icontex="Ability_Mount_Undeadhorse"};
			["Trainees INC"] = {t=20, c="cooldown", aBar="Trainees INC", icontex="INV_Misc_Head_Undead_01"};
			["Deathknights INC"] = {t=25, c="cooldown", aBar="Deathknights INC", icontex="Spell_Shadow_ShadowWard"};
			["Rider INC"] = {t=30, c="cooldown", aBar="Rider INC", icontex="Ability_Mount_Undeadhorse"};

			-- Noth
			["Transfert"] = {t=30, c="cooldown", mcheck="Noth le Porte%-peste", aZone="Naxxramas", icontex="Spell_Arcane_Blink"}; --Noth blinks every 30sec, agro reset.
			["First Teleport"] = {t=90, c="cooldown", aBar="On Balcony 1", aZone="Naxxramas", icontex="Spell_Nature_AstralRecalGroup"};
			["On Balcony 1"] = {t=70, c="cooldown", aBar="Second Teleport", icontex="Spell_Nature_AstralRecalGroup"};
			["Second Teleport"] = {t=110, c="cooldown", aBar="On Balcony 2", icontex="Spell_Nature_AstralRecalGroup"};
			["On Balcony 2"] = {t=95, c="cooldown", aBar="Third Teleport", icontex="Spell_Nature_AstralRecalGroup"};
			["Third Teleport"] = {t=180, c="cooldown", aBar="On Balcony 3", icontex="Spell_Nature_AstralRecalGroup"};
			["On Balcony 3"] = {t=120, c="cooldown", icontex="Spell_Nature_AstralRecalGroup"};

			-- Heigan
			["On Platform"] = {t=45, c="cooldown", aBar="Teleport CD", icontex="INV_Enchant_EssenceAstralLarge"};
			["Teleport CD"] = {t=90, c="cooldown", icontex="INV_Enchant_EssenceAstralLarge"};

			-- Sapphiron
			["Life Drain"] = {t=24, c="cooldown", m="Sapphiron", aZone="Naxxramas", icontex="Spell_Shadow_LifeDrain02"}; --! translate spell!

		-- Ahn'Qiraj
		
			-- 40 Man
				["Eradicateur d'obsidienne"] = {t=1800.0, c="cooldown", global="true", m="Respawn", icontex="Spell_Holy_Resurrection"};
	
				-- Twin Emperors
				["T\195\169l\195\169portation des jumeaux"] = {t=30.0, c="cooldown", icasted="true", icontex="Spell_Arcane_Blink"};
				["Explosion de l'insecte"] = {t=5.0, c="gains", icontex="Spell_Fire_Fire"};
				["Mutation de l'insecte"] = {t=5.0, c="gains", icontex="Ability_Hunter_Pet_Scorpid"};

				-- Ouro
				["Explosion de sable"] = {t=2.0, c="hostile", mcheck="Ouro", icontex="Spell_Nature_Cyclone"};
				["Balayer"] = {t=21, i=1.0, c="cooldown", mcheck="Ouro", icontex="Spell_Nature_Thorns"};

				["Invocation de Monticules d'Ouro"] = {t="0.1", delBar="Possible Ouro Submerge", icasted="true", pBar="Submerged"};
				["Submerged"] = {t=30, c="cooldown", delBar="Ouro Submerges", aBar="Possible Ouro Submerge", icontex="INV_Qiraj_OuroHide"};
				["Possible Ouro Submerge"] = {t=90, c="cooldown", pBar="Ouro Submerges", icontex="Spell_Shadow_DemonBreath"};
				["Ouro Submerges"] = {t=180, c="cooldown", icontex="Spell_Shadow_DemonBreath"};

				-- C'Thun
				["First Dark Glare"] = {t=48, c="cooldown", aBar="Dark Glare", icontex="Spell_Nature_CallStorm"}; -- don't translate, used internally!
				["Weakened!"] = {t=45, c="gains", delBar="Small Eyes P2", aBar="After Weakened Eyes", icontex="Ability_Hunter_SniperShot"}; -- don't translate, used internally!
				["Dark Glare"] = {t=86, i=40, c="cooldown", active="true", aBar="Dark Glare", icontex="Spell_Nature_CallStorm"}; -- don't translate, used internally!
				["Small Eyes P1"] = {t=45, c="cooldown", aBar="Small Eyes P1", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
				["First Small Eyes P2"] = {t=42, c="cooldown", aBar="Small Eyes P2", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
				["Small Eyes P2"] = {t=30, c="cooldown", aBar="Small Eyes P2", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
				["After Weakened Eyes"] = {t=38, c="cooldown", aBar="Small Eyes P2", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!

				-- Skeram
				["Explosion des arcanes"] = {t=1.2, c="hostile", mcheck="Le Proph\195\168te Skeram", icontex="Spell_Nature_WispSplode"};

				-- Sartura (Twin Emps enrage + Hakkar enrage)
				["Tourbillon"] = {t=15.0, c="gains", mcheck="Garde de guerre Sartura", icontex="Ability_Whirlwind"};
				["Enraged mode"] = {t=900, r="Sartura Hakkar", a=600, c="cooldown", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally! +if player enters combat and target are twins!
				["Enters Enraged mode"] = {t=3, c="gains", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally!

				-- Huhuran
				["Berserk mode"] = {t=300, c="cooldown", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally! if player enters combat and target is Huhuran!
				["Enters Berserk mode"] = {t=3, c="gains", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally!
				["Piq\195\187re de wyverne"] = {t=25, c="cooldown", m="Huhuran", aZone="Ahn'Qiraj", checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE - CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", icontex="INV_Spear_02"};

				-- Yauj
				["Peur"] = {t=20, c="cooldown", checkengage="true", m="Yauj", aZone="Ahn'Qiraj", checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE - CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", icontex="Spell_Shadow_Possession"};
				["Soins exceptionnels"] = {t=2.0, c="hostile", m="Yauj", mcheck="Princesse Yauj", icontex="Spell_Holy_Heal"};

			-- 20 Man

				["Exploser"] = {t=6.0, c="hostile", icontex="Spell_Fire_SelfDestruct"};

				-- Ossirian
				["Sensibilit\195\169 aux Arcanes"] = {t=45, c="gains", mcheck="Ossirian l'Intouch\195\169", icontex="INV_Misc_QirajiCrystal_01"};
				["Sensibilit\195\169 au Feu"] = {t=45, c="gains", mcheck="Ossirian l'Intouch\195\169", icontex="INV_Misc_QirajiCrystal_02"};
				["Sensibilit\195\169 \195\160 la Nature"] = {t=45, c="gains", mcheck="Ossirian l'Intouch\195\169", icontex="INV_Misc_QirajiCrystal_03"};
				["Sensibilit\195\169 au Givre"] = {t=45, c="gains", mcheck="Ossirian l'Intouch\195\169", icontex="INV_Misc_QirajiCrystal_04"};
				["Sensibilit\195\169 \195\160 l'Ombre"] = {t=45, c="gains", mcheck="Ossirian l'Intouch\195\169", icontex="INV_Misc_QirajiCrystal_05"};
	
				-- Moam
				["Until Stoneform"] = {t=90, c="grey", icontex="Spell_Shadow_UnholyStrength"}; -- don't translate, used internally!
				["Dynamiser"] = {t=90, c="gains", icontex="Spell_Nature_Cyclone"};


		-- Zul'Gurub

			-- Hakkar
			["Siphon de sang"] = {t=90, c="cooldown", mcheck="Hakkar", checkevent="CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", icontex="Spell_Shadow_LifeDrain02"};
		
		-- Molten Core

			-- Shazzrah
			["Porte de Shazzrah"] = {t=45.0, c="cooldown", icasted="true", icontex="Spell_Arcane_Blink"};
		
			-- Lucifron
			["Mal\195\169diction imminente"] = {t=20, c="cooldown", m="Lucifron", icontex="Spell_Shadow_NightOfTheDead"};
			["Mal\195\169diction de Lucifron"] = {t=20, c="cooldown", m="Lucifron", icontex="Spell_Shadow_BlackPlague"};
		
			-- Magmadar
			["Panique"] = {t=30, c="cooldown", m="Magmadar", icontex="Spell_Shadow_DeathScream"};

			-- Gehennas
			["Mal\195\169diction de Gehennas"] = {t=30, c="cooldown", m="Gehennas", icontex="Spell_Shadow_GatherShadows"};

			-- Geddon
			["Infernal"] = {t=8.0, c="gains", mcheck="Baron Geddon", icontex="Spell_Fire_Incinerate"};

			-- Majordomo
			["Renvoi de la magie"] = {t=30, i=10.0, c="cooldown", m="Majordomo", aZone="C\197\147ur du Magma", icontex="Spell_Frost_FrostShock"};
			["Bouclier de d\195\169g\195\162ts"] = {t=30, i=10.0, c="cooldown", m="Majordomo", icontex="Spell_Nature_LightningShield"};
			
			-- Ragnaros
			["Submerge"] = {t=180.0, c="cooldown", icontex="Spell_Fire_Volcano"}; -- don't translate, used internally!
			["Knockback"] = {t=28.0, c="cooldown", icontex="Ability_Kick"}; -- don't translate, used internally!
			["Sons of Flame"] = {t=90.0, c="cooldown", icontex="ell_Fire_LavaSpawn"}; -- don't translate, used internally!

		-- Onyxia
			["Souffle de flammes"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Fire"};
			["Deep Breath"] = {t=5.0, c="hostile", icontex="Spell_Fire_Incinerate"}; 
			
		-- Blackwing Lair

			-- Razorgore
			["Mob Spawn (45sec)"] = {t=45.0, c="cooldown", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!

			-- Firemaw/Flamegor/Ebonroc
			["Frappe des ailes"] = {t=31.5, i=1.2, c="cooldown", r="Onyxia", a=0, icontex="INV_Misc_MonsterScales_14"};
			["First Wingbuffet"] = {t=30.0, c="cooldown", icontex="INV_Misc_MonsterScales_14"};  -- don't translate, used internally! if player enters combat and target is firemaw or flamegor this castbar appears to catch the first wingbuffet!
			["Flamme d'ombre"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Incinerate"}; 
			
			-- Flamegor
			[CECB_SPELL_FRENZY_CD] = {t=10.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!
			
			-- Chromaggus
			["Br\195\187lure de givre"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Frost_ChillingBlast"};
			["Trou de temps"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Arcane_PortalOrgrimmar"};
			["Enflammer la chair"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Fire_Fire"};
			["Acide corrosif"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Nature_Acid_01"};
			["Incin\195\169rer"] = {t=60, i=2.0, c="cooldown", active="true", mcheck="Chromaggus", icontex="Spell_Fire_FlameShock"};
			["Killing Frenzy"] = {t=15.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!
				-- Chromaggus, Flamegor, Magmadar etc.
			["Fr\195\169n\195\169sie"] = {t=8.0, c="gains", checktarget="true", icontex="INV_Misc_MonsterClaw_03"};

			-- Neferian/Onyxia
			["Rugissement puissant"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, active="true", icontex="Spell_Shadow_Charm"};
			
			-- Nefarian
			["Nefarian calls"] = {t=30.0, c="gains", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!
			["Mob Spawn"] = {t=8.0, c="hostile", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!
			["Landing"] = {t=10.0, c="hostile", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!
			
		-- Outdoor
		
			-- Azuregos
			["Temp\195\170te de mana"] = {t=10.0, c="hostile", icontex="Spell_Frost_IceStorm"};

		-- Other

			["Boss incoming"] = {t=0}; -- don't translate, used internally!

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
		["Provocation"] = {t=3.0, multi="true", icontex="Spell_Nature_Reincarnation"};
		["Coup railleur"] = {t=6.0, multi="true", icontex="Ability_Warrior_PunishingBlow"};
		["Cri de d\195\169fi"] = {t=6, multi="true", icontex="Ability_BullRush"};
	        ["Brise-genou"] = {t=15.0, icontex="Ability_ShockWave"};
	        ["Hurlement per\195\167ant"] = {t=6.0, icontex="Spell_Shadow_DeathScream"};
			["Coup de bouclier - silencieux"] = {t=4, solo="true", icontex="Ability_Warrior_ShieldBash"};
			["Bourrasque"] = {t=5, solo="true", stun="true", icontex="Ability_ThunderBolt"};
			["Charge \195\169tourdissante"] = {t=1, solo="true", stun="true", icontex="Ability_Warrior_Charge"};
			["Interception \195\169tourdissante"] = {t=3, solo="true", stun="true", icontex="Ability_Rogue_Sprint"};
			["Etourdissement vengeur"] = {t=3, solo="true", stuntype="true", icontex="Ability_Warrior_Revenge"};
			["Cri d'intimidation"] = {t=8, solo="true", icontex="Ability_GolemThunderClap"};
			["D\195\169sarmement"] = {t=10, solo="true", icontex="Ability_Warrior_Disarm"};
			["Frappe mortelle"] = {t=10, solo="true", icontex="Ability_Warrior_SavageBlow"};
		["Cri d\195\169moralisant"] = {t=30, checkclass="WARRIOR", icontex="Ability_Warrior_WarCry"};
		["Coup de tonnerre"] = {t=30, checkclass="WARRIOR", icontex="Spell_Nature_ThunderClap"};
			-- periodic damage spells
				["Pourfendre"] = {t=21, periodicdmg="true", icontex="Ability_Gouge"};

		-- Naturfreund | Mage Afflicions
		["Vague explosive"] = {t=6.0, solo="true", stuntype="true", icontex="Spell_Holy_Excorcism_02"};
		--["Lenteur"] = {t=15.0, icontex=""};
			["Nova de givre"] = {t=8.0, magecold="true", icontex="Spell_Frost_FrostNova"};
			["Morsure du givre"] = {t=5.0, magecold="true", icontex="Spell_Frost_FrostArmor"};
			["Transir"] = {t=5.0, magecold="true", icontex="Spell_Frost_IceStorm"};
			["C\195\180ne de froid"] = {t=8.0, magecold="true", icontex="Spell_Frost_Glacier"}; -- slightly improved with talents (+1 sec)
			["Eclair de givre"] = {t=9, solo="true", magecold="true", icontex="Spell_Frost_FrostBolt02"}; -- slightly improved with talents (+1 sec)
			["Froid hivernal"] = {t=15, magecold="true", icontex="Spell_Frost_ChillingBlast"};
			["Vuln\195\169rabilit\195\169 au Feu"] = {t=30, magecold="true", icontex="Spell_Fire_SoulBurn"};
		["M\195\169tamorphose"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="M\195\169tamorphose", sclass="MAGE", icontex="Spell_Nature_Polymorph"};
		["M\195\169tamorphose : cochon"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="M\195\169tamorphose", sclass="MAGE", icontex="Spell_Magic_PolymorphPig"};
		["M\195\169tamorphose : tortue"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="M\195\169tamorphose", sclass="MAGE", icontex="Ability_Hunter_Pet_Turtle"};
			["Contresort - Silencieux"] = {t=4, solo="true", icontex="Spell_Frost_IceShock"};
			-- periodic damage spells
				["Choc de flammes"] = {t=8, periodicdmg="true", icontex="Spell_Fire_SelfDestruct"};

		-- Naturfreund | Hunter Afflicions
	        ["Coupure d'ailes"] = {t=10, icontex="Ability_Rogue_Trip"};
			["Trait de choc am\195\169lior\195\169"] = {t=3, solo="true", stuntype="true", icontex="Spell_Frost_Stun"};
	        ["Effet Pi\195\168ge givrant"] = {t=20.0, plevel={5, 60, 40, 0}, tskill={3, 7, 0, "HUNTER", 0, 0.15}, fragile="true", spellDR="true", sclass="HUNTER", icontex="Spell_Frost_ChainsOfIce"};
		["Perce-faille"] = {t=7.0, checkclass="HUNTER", icontex="Ability_Hunter_SniperShot"};
		["Trait de choc"] = {t=4, icontex="Spell_Frost_Stun"}; 
		["Morsure de vip\195\168re"] = {t=8, checkclass="HUNTER", icontex="Ability_Hunter_AimedShot"}; 
		["Contre-attaque"] = {t=5, icontex="Ability_Warrior_Challange"};
		["Piq\195\187re de scorpide"] = {t=20, checkclass="HUNTER", icontex="Ability_Hunter_CriticalShot"};
			["Piq\195\187re de wyverne"] = {t=12, solo="true", icontex="INV_Spear_02"};
			["Fl\195\168che de dispersion"] = {t=4.0, solo="true", icontex="Ability_GolemStormBolt"};
			-- periodic damage spells
				["Morsure de serpent"] = {t=15, periodicdmg="true", icontex="Ability_Hunter_Quickshot"};

		-- Naturfreund | Priest Afflicions
		["Vuln\195\169rabilit\195\169 \195\160 l'Ombre"] = {t=15, magecold="true", icontex="Spell_Shadow_ShadowBolt"};
		["Apaisement"] = {t=15, icontex="Spell_Holy_MindSooth"};
		["Entraves des morts-vivants"] = {t=50, plevel={10, 60, 40, 0}, fragile="true", spellDR="true", sclass="PRIEST", icontex="Spell_Nature_Slow"};
			["Cri psychique"] = {t=8, solo="true", icontex="Spell_Shadow_PsychicScream"};
			["Silence"] = {t=5, solo="true", icontex="Spell_Shadow_ImpPhaseShift"};
			-- periodic damage spells
				["Mot de l'ombre : Douleur"] = {t=18, tskill={3, 4, 3, "PRIEST", 0}, periodicdmg="true", icontex="Spell_Shadow_ShadowWordPain"};
				["Peste d\195\169vorante"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_BlackPlague"};
				["Flammes sacr\195\169es"] = {t=10, periodicdmg="true", directhit="true", icontex="Spell_Holy_SearingLight"};
				--["Toucher vampirique"] = {t=15, periodicdmg="true", icontex=""};

		-- Naturfreund | Warlock Afflicions
		["Bannir"] = {t=30, plevel={10, 48, 0}, fragile="true", icontex="Spell_Shadow_Cripple"};
		-- Succubus
		["S\195\169duction"] = {t=15, fragile="true", spellDR="true", sclass="WARLOCK",  drshare="S\195\169d., Peur", icontex="Spell_Shadow_MindSteal"};
			["Peur"] = {t=20, solo="true", spellDR="true", sclass="WARLOCK",  drshare="S\195\169d., Peur", icontex="Spell_Shadow_Possession"};
		["Mal\195\169diction de fatigue"] = {t=12, icontex="Spell_Shadow_GrimWard"};
			["Mal\195\169diction des langages"] = {t=30, checkclass="WARLOCK", icontex="Spell_Shadow_CurseOfTounges"};
			["Mal\195\169diction funeste"] = {t=60, checkclass="WARLOCK", icontex="Spell_Shadow_AuraOfDarkness"};
			-- periodic damage spells
				["Mal\195\169diction d'agonie"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_CurseOfSargeras"};
				["Corruption"] = {t=18, periodicdmg="true", icontex="Spell_Shadow_AbominationExplosion"};
				["Immolation"] = {t=15, periodicdmg="true", directhit="true", icontex="Spell_Fire_Immolation"};
				["Siphon de vie"] = {t=30, periodicdmg="true", icontex="Spell_Shadow_Requiem"};
				--["Graine de Corruption"] = {t=18, periodicdmg="true", icontex=""};
			["Br\195\187lure de l'ombre"] = {t=5, periodicdmg="true", icontex="Spell_Shadow_ScourgeBuild"}; -- special case

		-- Naturfreund | Rogue Afflicions
	        ["Poison affaiblissant"] = {t=12, icontex="Ability_PoisonSting"};
	        ["Assommer"] = {t=45, plevel={10, 48, 28, 0}, fragile="true", spellDR="true", sclass="ROGUE", drshare="Assommer, Suriner", icontex="Ability_Sap"};
			["Aiguillon perfide"] = {t=6, cpinterval=1, cpclass="ROGUE", solo="true", stuntype="true", spellDR="true", sclass="ROGUE", affmob="true", icontex="Ability_Rogue_KidneyShot"}; -- own DR
			["Coup bas"] = {t=4, solo="true", stun="true", icontex="Ability_CheapShot"};
			["Suriner"] = {t=4, tskill={2, 1, 0.5, "ROGUE", 0}, solo="true", stuntype="true", spellDR="true", sclass="ROGUE", drshare="Assommer, Suriner", icontex="Ability_Gouge"}; -- normal 4sec impr. 5.5sec (no DR)
			["C\195\169cit\195\169"] = {t=10, solo="true", spellDR="true", sclass="ROGUE", icontex="Spell_Shadow_MindSteal"};
			["Coup de pied - Silencieux"] = {t=2, solo="true", icontex="Ability_Kick"};
			["Riposte"] = {t=6, solo="true", icontex="Ability_Warrior_Disarm"};
			["Exposer l'armure"] = { t=30.0, checkclass="ROGUE", icontex="Ability_Warrior_Riposte" };
			-- periodic damage spells
				["Garrot"] = {t=18, periodicdmg="true", icontex="Ability_Rogue_Garrote"};
				["Rupture"] = {t=16, cpinterval=2, cpclass="ROGUE", periodicdmg="true", icontex="Ability_Rogue_Rupture"};

		-- Naturfreund | Druid Afflicions
	        ["Grondement"] = {t=3, multi="true", icontex="Ability_Physical_Taunt"};
	        ["Rugissement provocateur"] = {t=6, multi="true", icontex="Ability_Druid_ChallangingRoar"};
		--["Cyclone"] =	{t=6, spellDR="true", sclass="DRUID", icontex=""};
		--["Estropier"] = {t=6, cpinterval=1, cpclass="DRUID", spellDR="true", sclass="DRUID", solo="true", icontex=""};
		["Sarments"] = {t=27, fragile="true", death="true", blockZone="Ahn'Qiraj", spellDR="true", sclass="DRUID", icontex="Spell_Nature_StrangleVines"};
		["Hibernation"] = {t=40, plevel={10, 58, 38, 0}, fragile="true", icontex="Spell_Nature_Sleep"};
			["Sonner"] = {t=4, tskill={2, 4, 0.5, "DRUID", 0}, plevel={1, 46, 30, 0}, solo="true", stun="true", icontex="Ability_Druid_Bash"};
			["Traquenard"] = {t=2, tskill={2, 4, 0.5, "DRUID", 0}, solo="true", stun="true", icontex="Ability_Druid_SupriseAttack"};
			["Charge farouche"] = {t=4, solo="true", icontex="Ability_Hunter_Pet_Bear"};
		["Lucioles"] = {t=40, checkclass="DRUID", icontex="Spell_Nature_FaerieFire"};
		["Lucioles (farouche)"] = {t=0, tskill={2, 14, 0, "DRUID", 40, 0}, checkclass="DRUID", icontex="Spell_Nature_FaerieFire"}; -- only druids with the talent see the spell
		["Rugissement d\195\169moralisant"] = {t=30, checkclass="DRUID", icontex="Ability_Druid_DemoralizingRoar"};
		--["Mutilation"] = {t=10, checkclass="DRUID", icontex=""};
			-- periodic damage spells
				["Essaim d'insectes"] = {t=12, periodicdmg="true", icontex="Spell_Nature_InsectSwarm"};
				["Eclat lunaire"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Nature_StarFall"};
				["D\195\169chirure"] = {t=12, periodicdmg="true", icontex="Ability_GhoulFrenzy"};

		-- Naturfreund | Paladin Afflicions
			["Marteau de la justice"] = {t=6, solo="true", stun="true", icontex="Spell_Holy_SealOfMight"};
			["Repentir"] = {t=6, solo="true", icontex="Spell_Holy_PrayerOfHealing"};

		-- Naturfreund | Shaman Afflicions
		["Horion de givre"] = {t=8.0, magecold="true", spellDR="true", sclass="SHAMAN", icontex="Spell_Frost_FrostShock"};
			-- periodic damage spells
				["Horion de flammes"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Fire_FlameShock"};


	-- Naturfreund | Raidencounter Afflicions
	-- gobal="true" creates a castbar even without a target!

		-- Naxxramas, AQ
		["Blessure mortelle"] = {t=15, global="true", icontex="Ability_CriticalStrike"}; -- Gluth's Healing Debuff
		["Injection mutante"] = {t=10.0, global="true", icontex="Spell_Shadow_CallofBone"}; -- Grobbulus' Mutagen
		["Entoilage"] = {t=60.0, global="true", icontex="Spell_Nature_Web"}; -- Maexxna Web Wraps 3 people after a random ammount of time
		["Poison n\195\169crotique"] = {t=30.0, global="true", icontex="Ability_Creature_Poison_03"}; --! validate -- Maexxna MT -healing Debuff(poison)
		["Detonate de mana"] = {t=5, global="true", icontex="Spell_Nature_WispSplode"}; -- Kel'Thuzads Mana Bomb --! translate "Detonate Mana"

		-- Zul'Gurub
		["Illusions de Jin'do"] = {t=20, global="true", icontex="Spell_Shadow_UnholyFrenzy"}; -- Delusions of Jin'do
		["Rendre frou"] = {t=9.5, global="true", icontex="Spell_Shadow_ShadowWordDominate"}; -- Hakkars Mind Control
		["Regard mena\195\167ant"] = {t=5.7, global="true", icontex="Spell_Shadow_Charm"}; -- Mandokir's Gaze

		-- MC
		["Bombe vivante"] = {t=8, global="true", icontex="INV_Enchant_EssenceAstralSmall"}; -- Geddon's Bomb

		-- BWL
		["D\195\169flagration"] = {t=10.0, global="true", aZone="Repaire de l'Aile noire", icontex="Spell_Fire_Incinerate"}; -- Razorgores (and Drakkisaths) Burning
		["Mont\195\169e d'adr\195\169naline"] = {t=20.0, global="true", icontex="INV_Gauntlets_03"}; -- Vaelastrasz BA
		["Ombre d'Ebonroc"] = {t=8.0, global="true", icontex="Spell_Shadow_GatherShadows"}; -- Ebonroc selfheal debuff

		-- AQ40
		["Accomplissement v\195\169ritable"] = {t=20, global="true", icontex="Spell_Shadow_Charm"}; -- Skeram MindControl
		["Peste"] = {t=40, global="true", icontex="Spell_Shadow_CurseOfTounges"}; -- Anubisath Defenders Plague
		["Enchev\195\170trement"] = {t=10, global="true", icontex="Spell_Nature_StrangleVines"}; -- Fankriss the Unyielding's Entangle

		-- AQ20
		["Paralysie"] = {t=10, global="true", aZone="Ruines d'Ahn'Qiraj", icontex="Ability_Creature_Poison_05"}; -- Ayamiss the Hunter

		-- Non Boss DeBuffs:
		["M\195\169tamorphose sup\195\169rieure"] = {t=20.0, fragile="true", icontex="Spell_Nature_Brilliance"}; -- Polymorph of BWL Spellbinders


	-- REMOVALS
	-- just to remove the bar if this spell fades (t is useless here) | only the spells in "CEnemyCastBar_Afflictions" are checked by the "fade-engine"
		-- Moam
		["Dynamiser"] = {t=0, global="true"};
		-- Other
		["Fr\195\169n\195\169sie"] = {t=0, global="true"};
		[CECB_SPELL_STUN_DR] = {t=0}; -- don't translate, used internally! clear the dimishing return timer if mob dies


	}

	-- Spell Interruptions
	NECB_Interruptions = "Horion de terre, Suriner, Traquenard, Etourdir, Interception \195\169tourdissante, Fl\195\168che de dispersion, Choc martial, M\195\169tamorphose : cochon, Peur, Marteau de la justice, Assommer, Charge \195\169tourdissante, Explosion paralysante, Coup \195\169tourdissant, S\195\169duction, Aiguillon perfide, Coup bas, Bourrasque, Trait de choc am\195\169lior\195\169, Piq\195\187re de wyverne, Etourdissement vengeur, Cri d'intimidation, M\195\169tamorphose : tortue, Cri psychique, Sonner, Vague explosive, Entraves des morts-vivants, Bannir, C\195\169cit\195\169, Contr\195\180le mental";

	-- Zul'Gurub
	CEnemyCastBar_HAKKAR_YELL			= "ANNONCE LA FIN DE VOTRE MONDE";

	-- Naxxramas
	CEnemyCastBar_HEIGAN_YELL1			= "Je vous vois...";
	CEnemyCastBar_HEIGAN_YELL2			= "Vous \195\170tes \195\160 moi, maintenant.";
	CEnemyCastBar_HEIGAN_YELL3			= "Tu es... le suivant.";
	CEnemyCastBar_HEIGAN_TELEPORT_YELL		= "Votre fin est venue.";

	CEnemyCastBar_FAER_YELL1			= "Vous ne pouvez pas m'\195\169chapper !";
	CEnemyCastBar_FAER_YELL2			= "Tuez-les au nom du ma\195\174tre !";
	CEnemyCastBar_FAER_YELL3			= "Fuyez tant que vous le pouvez !";
	CEnemyCastBar_FAER_YELL4			= "A genoux, vermisseau !";

	CEnemyCastBar_PATCHWERK_NAME			= "Patchwerk";

	CEnemyCastBar_GOTHIK_YELL			= "Dans votre folie, vous avez provoqu\195\169 votre propre mort.";

	CEnemyCastBar_ANUB_YELL1			= "Rien qu'une petite bouch\195\169e";
	CEnemyCastBar_ANUB_YELL2			= "Oui, courez ! Faites circulez le sang !";
	CEnemyCastBar_ANUB_YELL3			= "Nulle part pour s'enfuir.";

	-- AQ40
	CEnemyCastBar_SARTURA_CALL			= "Vous serez jug\195\169s pour avoir profan\195\169 ces lieux sacr\195\169s";
	CEnemyCastBar_SARTURA_CRAZY			= "devient fou furieux";

	CEnemyCastBar_HUHURAN_CRAZY			= "entre dans une rage d\195\169mente";

	CEnemyCastBar_CTHUN_NAME1	 		= "Oeil de C'Thun";
	CEnemyCastBar_CTHUN_WEAKENED			= "est affaibli";

	-- Ruins of AQ
	CEnemyCastBar_MOAM_STARTING			= "sent votre peur.";

	-- MC
	CEnemyCastBar_RAGNAROS_STARTING			= "^ET MAINTENANT,";
	CEnemyCastBar_RAGNAROS_KICKER			= "^GO\195\155TEZ";
	CEnemyCastBar_RAGNAROS_SONS	 		= "^VENEZ, MES SERVITEURS";

	-- BWL
	CEnemyCastBar_RAZORGORE_CALL			= "Sonnez l'alarme";

	CEnemyCastBar_FIREMAW_NAME			= "Gueule-de-feu";
	CEnemyCastBar_EBONROC_NAME			= "Ebonroc";
	CEnemyCastBar_FLAMEGOR_NAME			= "Flamegor";	
	CEnemyCastBar_FLAMEGOR_FRENZY			= "est pris de fr\195\169n\195\169sie";
	CEnemyCastBar_CHROMAGGUS_FRENZY			= "entre dans une sanglante fr\195\169n\195\169sie";
	
	CEnemyCastBar_NEFARIAN_STARTING			= "Que les jeux commencent";
	CEnemyCastBar_NEFARIAN_LAND			= "Beau travail";
	CEnemyCastBar_NEFARIAN_SHAMAN_CALL		= "Chamans, montrez moi";
	CEnemyCastBar_NEFARIAN_DRUID_CALL		= "Les druides et leur stupides";
	CEnemyCastBar_NEFARIAN_WARLOCK_CALL		= "D\195\169monistes, vous ne devriez pas jouer";
	CEnemyCastBar_NEFARIAN_PRIEST_CALL		= "Pr\195\170tres ! Si vous continuez";
	CEnemyCastBar_NEFARIAN_HUNTER_CALL		= "Ah, les chasseurs et les stupides";
	CEnemyCastBar_NEFARIAN_WARRIOR_CALL		= "Guerriers, je sais que vous pouvez frapper plus fort";
	CEnemyCastBar_NEFARIAN_ROGUE_CALL		= "Voleurs, arr\195\170tez de vous cacher";
	CEnemyCastBar_NEFARIAN_PALADIN_CALL		= "Les paladins";
	CEnemyCastBar_NEFARIAN_MAGE_CALL		= "Les mages aussi";

	-- ONY
	CEnemyCastBar_ONY_DB				= "prend une grande inspiration..."; 
	

	-- Event Pattern
	CEnemyCastBar_MOB_DIES					= "(.+) meurt"
	CEnemyCastBar_SPELL_GAINS 				= "(.+) gagne (.+)."
	CEnemyCastBar_SPELL_CAST 				= "(.+) commence \195\160 lancer (.+)."
	CEnemyCastBar_SPELL_PERFORM				= "(.+) commence \195\160 ex\195\169cuter (.+)."
	CEnemyCastBar_SPELL_CASTS				= "(.+) lance (.+)."
	CEnemyCastBar_SPELL_AFFLICTED				= "(.+) (.+) les effets de (.+).";
	CEnemyCastBar_SPELL_AFFLICTED2				= "-- dummy --";
	CEnemyCastBar_SPELL_DAMAGE 				= "(.+) de (.+) inflige \195\160 (.+) (%d+)";
	--							spell 	from 			mob damage <- correct order here? tell me pls
	-- Naturfreund
	CEnemyCastBar_SPELL_HITS 				= "(.+) de (.+) touche (.+) pour (.+) points de";
	--							spell	mob		target	damage
	CEnemyCastBar_SPELL_DAMAGE_SELFOTHER			= "Votre (.+) inflige (.+) \195\160 (.+).";

	CEnemyCastBar_SPELL_FADE 				= "(.+) sur (.+) vient de se dissiper.";
	--							effect		mob <- correct order here? tell me pls

	CEnemyCastBar_SPELL_REMOVED 				= "(.+) n'est plus sous l'influence de (.+)."
	--							mob	spell <- correct order here? tell me pls

	CEnemyCastBar_SPELL_HITS_SELFOTHER			= "Votre (.+) touche (.+) et lui inflige (.+).";
	--								spell	 	mob		(damage)
	CEnemyCastBar_SPELL_CRITS_SELFOTHER			= "Votre (.+) inflige un coup critique \195\160 (.+) %((.+)%).";

	CEnemyCastBar_SPELL_INTERRUPTED				= "(.+) lance un (.+) que vous interrompez.";
	--							mob		spell
	CEnemyCastBar_SPELL_INTERRUPTED_OTHER			= "(.+) interrompt (.+) qui lance (.+).";
	--							interrupter	mob		spell

	CECB_SELF1	= "Vous";
	CECB_SELF2	= "vous";

	CECB_MISC_IMMUNE = "immune";

end
