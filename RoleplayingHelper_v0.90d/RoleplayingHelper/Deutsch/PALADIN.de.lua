if ( GetLocale() == "deDE" ) then

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- ä = \195\164 (z.B. Jäger = J\195\164ger)
-- Ä = \195\132 (z.B. Ärger = \195\132rger)
-- ö = \195\182 (z.B. schön = sch\195\182n)
-- Ö = \195\150 (z.B. Ödipus = \195\150dipus)
-- ü = \195\188 (z.B. Rüstung = R\195\188stung)
-- Ü = \195\156 (z.B. Übung = \195\156bung)
-- ß = \195\159 (z.B. Straße = Stra\195\159e)
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.PALADIN = {"Meine Ehre gebietet es mir, euch vom Antliz dieser Welt zu tilgen!", "Wer flieht, wird gejagt!", "Kommt her und erwartet die reinigende Kraft eines Paladins!", "Es kann auch Gesetz sein, dem Willen und Rat eines Einzigen zu folgen!", "Macht euch bereit gel\195\164utert zu werden!", "Ich werde euer leiden beenden!", "F\195\188rchtet euch nicht! Ich bringe euch das Licht!", "Meine Hand ist zum Segen erhoben! Meine Klinge \195\188brigens auch", "M\195\182ge mir das Licht beistehen!", "M\195\182ge mir das heilige Wort beistehen!", "F\195\188r das Licht!", "F\195\188r die Allianz!", "Ich verteidige das Gute! Also musst du sterben!", }
RPWORDLIST.entercombat.PALADIN.emote = {}
RPWORDLIST.entercombat.PALADIN.customemote = {}
RPWORDLIST.entercombat.PALADIN.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.PALADIN = {"Man soll keine Dummheit zweimal begehen, die Auswahl ist schlie\195\159lich gro\195\159 genug!", "Wieder einmal hat das Gute gesiegt!",}
RPWORDLIST.leavecombat.PALADIN.emote = {}
RPWORDLIST.leavecombat.PALADIN.customemote = {}
RPWORDLIST.leavecombat.PALADIN.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.PALADIN = {"Ich habe keine Angst! Das Licht wird mich besch\195\188tzen!", "Ich f\195\188rchte mich nicht, denn meine gesegnete R\195\188stung wird mich vor weiteren Schaden bewahren!", }
RPWORDLIST.hurt.PALADIN.emote = {}
RPWORDLIST.hurt.PALADIN.customemote = {}
RPWORDLIST.hurt.PALADIN.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.PALADIN = {"Das Licht sch\195\188tzt mich!", "Mein Glaube hat mich vor Schaden bewahrt!", }
RPWORDLIST.absorb.PALADIN.emote = {}
RPWORDLIST.absorb.PALADIN.customemote = {}
RPWORDLIST.absorb.PALADIN.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.PALADIN = {}
RPWORDLIST.block.PALADIN.emote = {}
RPWORDLIST.block.PALADIN.customemote = {}
RPWORDLIST.block.PALADIN.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.PALADIN = {}
RPWORDLIST.dodge.PALADIN.emote = {}
RPWORDLIST.dodge.PALADIN.customemote = {}
RPWORDLIST.dodge.PALADIN.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.PALADIN = {}
RPWORDLIST.miss.PALADIN.emote = {}
RPWORDLIST.miss.PALADIN.customemote = {}
RPWORDLIST.miss.PALADIN.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.PALADIN = {}
RPWORDLIST.parry.PALADIN.emote = {}
RPWORDLIST.parry.PALADIN.customemote = {}
RPWORDLIST.parry.PALADIN.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.PALADIN = {"Ich reinige die Welt vor eurer Pr\195\164senz!",  "Ich werde eurem Unwesen ein Ende bereiten!", "Das Licht gibt mir Kraft!", "Ich sp\195\188re die St\195\164rke des Lichts in mir!", "Ich habe eiserne Prinzipien! Und wenn sie Euch nicht gefallen, habe ich noch andere", }
RPWORDLIST.youcrit.PALADIN.emote = {}
RPWORDLIST.youcrit.PALADIN.customemote = {}
RPWORDLIST.youcrit.PALADIN.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.PALADIN = {"Das reinigende Feuer hat euch erleuchtet!", "Das Wort eines Paladins ist Gesetz!", "Das Wort eines Paladins wirkt sich auf die Dunkelheit verheerend aus!", "Das Licht ist st\195\164rker als die Dunkelheit!", "Die heiligen Kr\195\164fte str\195\182men durch mich!",  }
RPWORDLIST.youcritspell.PALADIN.emote = {}
RPWORDLIST.youcritspell.PALADIN.customemote = {}
RPWORDLIST.youcritspell.PALADIN.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.PALADIN = {}
RPWORDLIST.youheal.PALADIN.emote = {}
RPWORDLIST.youheal.PALADIN.customemote = {}
RPWORDLIST.youheal.PALADIN.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.PALADIN = {}
RPWORDLIST.youcritheal.PALADIN.emote = {}
RPWORDLIST.youcritheal.PALADIN.customemote = {}
RPWORDLIST.youcritheal.PALADIN.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.PALADIN = {}
RPWORDLIST.npctalksfriend.PALADIN.emote = {}
RPWORDLIST.npctalksfriend.PALADIN.customemote = {}
RPWORDLIST.npctalksfriend.PALADIN.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.PALADIN = {}
RPWORDLIST.npctalksenemy.PALADIN.emote = {}
RPWORDLIST.npctalksenemy.PALADIN.customemote = {}
RPWORDLIST.npctalksenemy.PALADIN.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.PALADIN = {
	"Im Namen Gottes! Ich bin am Leben!",
	"Man sah das ich gut war, nun bin ich wieder da!",
	"Das Gute wird niemals vergehen!",
	"Ich habe das Licht gesehen!",
	"Das Licht hat mich zur\195\188ckgebracht.",
	"Ich werde nicht eher ruhen bevor das B\195\182se vernichtet ist!",
	"Ich diene dem Licht.... Ich kann nicht ruhen solange meine Aufgabe nicht vollbracht ist.",
	"Genug geruht. Es ist wieder Zeit meinen heiligen Kreuzzug fortzusetzen!", 
	}
RPWORDLIST.resurrect.PALADIN.emote = {"PRAY",}
RPWORDLIST.resurrect.PALADIN.customemote = {}
RPWORDLIST.resurrect.PALADIN.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Paladin Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Protection
--=====================================================================--
-- No spells with Cast Times (not Instant or Channeled)

--=====================================================================--
-- Retribution
--=====================================================================--
-- No spells with Cast Times (not Instant or Channeled)

--=====================================================================--
-- Holy                                                                  
--=====================================================================--
RPWORDLIST.holy_light.PALADIN = {}
RPWORDLIST.holy_light.PALADIN.emote = {}
RPWORDLIST.holy_light.PALADIN.customemote = {}
RPWORDLIST.holy_light.PALADIN.random = {}
       
RPWORDLIST.flash_of_light.PALADIN = {}
RPWORDLIST.flash_of_light.PALADIN.emote = {}
RPWORDLIST.flash_of_light.PALADIN.customemote = {}
RPWORDLIST.flash_of_light.PALADIN.random = {}

RPWORDLIST.turn_undead.PALADIN = {}
RPWORDLIST.turn_undead.PALADIN.emote = {}
RPWORDLIST.turn_undead.PALADIN.customemote = {}
RPWORDLIST.turn_undead.PALADIN.random = {}

RPWORDLIST.summon_warhorse.PALADIN = {}
RPWORDLIST.summon_warhorse.PALADIN.emote = {}
RPWORDLIST.summon_warhorse.PALADIN.customemote = {}
RPWORDLIST.summon_warhorse.PALADIN.random = {}

RPWORDLIST.hammer_of_wrath.PALADIN = {}
RPWORDLIST.hammer_of_wrath.PALADIN.emote = {}
RPWORDLIST.hammer_of_wrath.PALADIN.customemote = {}
RPWORDLIST.hammer_of_wrath.PALADIN.random = {}

RPWORDLIST.holy_wrath.PALADIN = {}
RPWORDLIST.holy_wrath.PALADIN.emote = {}
RPWORDLIST.holy_wrath.PALADIN.customemote = {}
RPWORDLIST.holy_wrath.PALADIN.random = {}

end