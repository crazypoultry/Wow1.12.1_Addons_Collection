--Razorgore
LVBM_RG_NAME		= "Razorgore the Untamed";
LVBM_RG_DESCRIPTION	= "Provides a timer for beginning of the add spawn.";
LVBM_RG_YELL		= "Intruders have breached the hatchery! Sound the alarm! Protect the eggs at all costs!";

LVBM_RG_CONTROLLER	= "Grethok the Controller";


--Vaelastrasz
LVBM_VAEL_NAME			= "Vaelastrasz the Corrupt";
LVBM_VAEL_DESCRIPTION	= "Announces Burning Adrenaline.";
LVBM_VAEL_SEND_WHISPER	= "Send whisper";
LVBM_VAEL_SET_ICON		= "Set icon";

LVBM_VAEL_BA_WARNING	= "*** %s is burning ***";
LVBM_VAEL_BA_WHISPER	= "You are burning!";
LVBM_VAEL_BA			= "Burning Adrenaline";

LVBM_VAEL_BA_REGEXP			= "([^%s]+) (%w+) afflicted by Burning Adrenaline.";
LVBM_VAEL_BA_FADES_REGEXP	= "Burning Adrenaline fades from ([^%s]+)%.";

--Lashlayer
LVBM_LASHLAYER_NAME	= "Broodlord Lashlayer";
LVBM_LASHLAYER_YELL	= "None of your kind should be here! You've doomed only yourselves!";

--Firemaw/Ebonroc/Flamegor
LVBM_FIREMAW_NAME				= "Firemaw";
LVBM_FIREMAW_DESCRIPTION		= "Provides a timer for Wing Buffet.";
LVBM_EBONROC_NAME				= "Ebonroc";
LVBM_EBONROC_DESCRIPTION		= "Provides a timer for Wing Buffet and announces Shadow of Ebonroc.";
LVBM_EBONROC_SET_ICON			= "Set icon"
LVBM_FLAMEGOR_NAME				= "Flamegor";
LVBM_FLAMEGOR_DESCRIPTION		= "Provides a timer for Wing Buffet and announces Frenzy.";
LVBM_FLAMEGOR_ANNOUNCE_FRENZY	= "Announce frenzy";

LVBM_FIREMAW_FIREMAW			= "Firemaw";
LVBM_EBONROC_EBONROC			= "Ebonroc";
LVBM_FLAMEGOR_FLAMEGOR			= "Flamegor";

LVBM_FIREMAW_WING_BUFFET		= "Firemaw begins to cast Wing Buffet.";
LVBM_EBONROC_WING_BUFFET		= "Ebonroc begins to cast Wing Buffet.";
LVBM_FLAMEGOR_WING_BUFFET		= "Flamegor begins to cast Wing Buffet.";

LVBM_FIREMAW_SHADOW_FLAME		= "Firemaw begins to cast Shadow Flame.";
LVBM_EBONROC_SHADOW_FLAME		= "Ebonroc begins to cast Shadow Flame.";
LVBM_FLAMEGOR_SHADOW_FLAME		= "Flamegor begins to cast Shadow Flame.";

LVBM_SHADOW_FLAME_WARNING		= "*** Shadow Flame in 2 sec ***";
LVBM_WING_BUFFET_WARNING		= "*** Wing Buffet in %s sec ***";
LVBM_EBONROC_SHADOW_WARNING		= "*** %s has Shadow of Ebonroc ***";
LVBM_FLAMEGOR_FRENZY			= "%s goes into a frenzy!";
LVBM_FLAMEGOR_FRENZY_ANNOUNCE   	= "*** Frenzy ***";

LVBM_EBONROC_SHADOW_REGEXP		= "([^%s]+) (%w+) afflicted by Shadow of Ebonroc.";
LVBM_EBONROC_SHADOW_REGEXP2		= "Shadow of Ebonroc fades from ([^%s]+)%.";

LVBM_SBT["Wing Buffet"]			= "Wing Buffet";
LVBM_SBT["Wing Buffet Cast"]	= "Wing Buffet Cast";
LVBM_SBT["Shadow Flame Cast"]	= "Shadow Flame Cast";


--Chromaggus
LVBM_CHROMAGGUS_NAME				= "Chromaggus";
LVBM_CHROMAGGUS_DESCRIPTION			= "Provides timers for his breaths and announces the vulnerability.";
LVBM_CHROMAGGUS_ANNOUNCE_FRENZY			= "Announce frenzy";
LVBM_CHROMAGGUS_ANNOUNCE_VULNERABILITY		= "Announce vulnerability"
LVBM_CHROMAGGUS_BREATH_1			= "Breath 1";
LVBM_CHROMAGGUS_BREATH_2			= "Breath 2";

LVBM_CHROMAGGUS_BREATH_CAST_WARNING		= "*** Chromaggus begins to cast %s ***"
LVBM_CHROMAGGUS_BREATH_WARNING			= "*** %s in 10 sec ***"

LVBM_CHROMAGGUS_BREATH_REGEXP			= "Chromaggus begins to cast ([%w%s]+)";
LVBM_CHROMAGGUS_VULNERABILITY_REGEXP		= "[^%s]+ [^%s]+ (%w+) Chromaggus for (%d+) ([^%s]+) damage";
LVBM_CHROMAGGUS_CHROMAGGUS			= "Chromaggus";

LVBM_CHROMAGGUS_FRENZY_EXPR			= "%s goes into a killing frenzy!";
LVBM_CHROMAGGUS_FRENZY_ANNOUNCE			= "*** Frenzy ***";

LVBM_CHROMAGGUS_VULNERABILITY_EXPR		= "%s flinches as its skin shimmers.";
LVBM_CHROMAGGUS_VULNERABILITY_ANNOUNCE		= "*** Vulnerability changed ***";

LVBM_SBT["Breath 1"]	= "Breath 1";
LVBM_SBT["Breath 2"]	= "Breath 2";

--Nefarian
LVBM_NEFARIAN_NAME			= "Nefarian";
LVBM_NEFARIAN_DESCRIPTION		= "Provides timers for class calls.";
LVBM_NEFARIAN_BLOCK_HEALS		= "Block heals during priest call";
LVBM_NEFARIAN_UNEQUIP_BOW		= "Unequip bow/gun before class calls";

LVBM_NEFARIAN_SYNCKILLS_INFO		= "Sync Drakonid Kills in Phase1";

LVBM_NEFARIAN_FEAR_WARNING		= "*** Fear in 1.5 sec ***";
LVBM_NEFARIAN_PHASE2_WARNING		= "*** Nefarian inc - 15 sec ***";
LVBM_NEFARIAN_CLASS_CALL_WARNING	= "*** Class call soon ***";
LVBM_NEFARIAN_SHAMAN_WARNING		= "*** Shaman call - totems ***";
LVBM_NEFARIAN_PALA_WARNING		= "*** Paladin call - Blessing of Protection ***";
LVBM_NEFARIAN_DRUID_WARNING		= "*** Druid call - cat form ***";
LVBM_NEFARIAN_PRIEST_WARNING		= "*** Priest call - stop healing ***";
LVBM_NEFARIAN_WARRIOR_WARNING		= "*** Warrior call - berserker stance ***";
LVBM_NEFARIAN_ROGUE_WARNING		= "*** Rogue call - ported and rooted ***";
LVBM_NEFARIAN_WARLOCK_WARNING		= "*** Warlock call - infernals ***";
LVBM_NEFARIAN_HUNTER_WARNING		= "*** Hunter call - bows/guns broken ***";
LVBM_NEFARIAN_MAGE_WARNING		= "*** Mage call - polymorph ***";
LVBM_NEFARIAN_PRIEST_CALL		= "Priest Call";
LVBM_NEFARIAN_HEAL_BLOCKED		= "You are not allowed to cast %s during a priest call!";
LVBM_NEFARIAN_UNEQUIP_ERROR		= "Error while unequipping your bow/gun."
LVBM_NEFARIAN_EQUIP_ERROR		= "Error while equipping your bow/gun."

LVBM_NEFARIAN_DRAKONID_DOWN = {};
LVBM_NEFARIAN_DRAKONID_DOWN[1] = "Black Drakonid dies.";
LVBM_NEFARIAN_DRAKONID_DOWN[2] = "Blue Drakonid dies.";
LVBM_NEFARIAN_DRAKONID_DOWN[3] = "Green Drakonid dies.";
LVBM_NEFARIAN_DRAKONID_DOWN[4] = "Bronze Drakonid dies.";
LVBM_NEFARIAN_DRAKONID_DOWN[5] = "Red Drakonid dies.";
LVBM_NEFARIAN_DRAKONID_DOWN[6] = "Chromatic Drakonid dies.";

LVBM_NEFARIAN_KILLCOUNT			= "Current kill count: %d";

LVBM_NEFARIAN_BLOCKED_SPELLS	= {
	["Flash Heal"]			= 1.5,
	["Greater Heal"]		= 2.5,
	["Prayer of Healing"]	= 3,
	["Heal"]				= 2.5,
	["Lesser Heal"]			= 1.5,
--	["Holy Nova"]			= 0,
}

LVBM_NEFARIAN_CAST_SHADOW_FLAME	= "Nefarian begins to cast Shadow Flame.";
LVBM_NEFARIAN_CAST_FEAR			= "Nefarian begins to cast Bellowing Roar.";
LVBM_NEFARIAN_YELL_PHASE1		= "Let the games begin!";
LVBM_NEFARIAN_YELL_PHASE2		= "Well done, my minions. The mortals' courage begins to wane! Now, let's see how they contend with the true Lord of Blackrock Spire!!!";
LVBM_NEFARIAN_YELL_PHASE3		= "Impossible! Rise my minions!  Serve your master once more!";
LVBM_NEFARIAN_YELL_SHAMANS		= "Shamans, show me";
LVBM_NEFARIAN_YELL_PALAS		= "Paladins... I've heard you have many lives. Show me.";
LVBM_NEFARIAN_YELL_DRUIDS		= "Druids and your silly shapeshifting. Lets see it in action!";
LVBM_NEFARIAN_YELL_PRIESTS		= "Priests! If you're going to keep healing like that, we might as well make it a little more interesting!";
LVBM_NEFARIAN_YELL_WARRIORS		= "Warriors, I know you can hit harder than that! Lets see it!";
LVBM_NEFARIAN_YELL_ROGUES		= "Rogues? Stop hiding and face me!";
LVBM_NEFARIAN_YELL_WARLOCKS		= "Warlocks, you shouldn't be playing with magic you don't understand. See what happens?";
LVBM_NEFARIAN_YELL_HUNTERS		= "Hunters and your annoying pea-shooters!";
LVBM_NEFARIAN_YELL_MAGES		= "Mages too? You should be more careful when you play with magic...";
LVBM_NEFARIAN_YELL_DEAD			= "This cannot be! I am the master here! You mortals are nothing to my kind! Do you hear me? Nothing!";

LVBM_SBT["Class call CD"] 	= "Class call CD";
LVBM_SBT["Druid call"] 	= "Druid call";
LVBM_SBT["Priest call"] 	= "Priest call";
LVBM_SBT["Warrior call"] 	= "Warrior call";
LVBM_SBT["Rogue call"] 	= "Rogue call";
LVBM_SBT["Mage call"] 	= "Mage call";
