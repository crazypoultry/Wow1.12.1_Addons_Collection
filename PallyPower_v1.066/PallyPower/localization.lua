PallyPower_Version = "1.066"
  SLASH_PALLYPOWER1 = "/pp"
  SLASH_PALLYPOWER2 = "/pallypower"

 PallyPower_BlessingID = { };
PallyPower_BlessingID[0] = "Wisdom";
PallyPower_BlessingID[1] = "Might";
PallyPower_BlessingID[2] = "Salvation";
PallyPower_BlessingID[3] = "Light";
PallyPower_BlessingID[4] = "Kings";
PallyPower_BlessingID[5] = "Sanctuary";

PallyPower_BlessingTalentSearch = "Improved Blessing of (.*)";
PallyPower_BlessingSpellSearch = "Greater Blessing of (.*)";
PallyPower_Rank1 = "Rank 1"
PallyPower_RankSearch = "Rank (.*)"
PallyPower_Symbol = "Symbol of Kings"

-- _,class = UnitClass("player") returns....
PallyPower_Paladin = "PALADIN"

-- Used... ClassID .. ": Blessing of "..BlessingID
PallyPower_BuffFrameText = ": Blessing of "
PallyPower_Have = "Have: "
PallyPower_Need = "Need: "
PallyPower_NotHere = "Not Here: "
PallyPower_Dead = "Dead: "

PallyPower_BuffBarTitle = "Pally Buffs (%d)"

--- By Lines... Keep People the same, feel free to add yourself in the _Credits3 line if your localizing
--- And feel free to add a friend or two to special thanks
PallyPower_Credits1 = "Pally Power - by Aznamir"
PallyPower_Credits2 = "Version "..PallyPower_Version
PallyPower_Credits3 = ""
PallyPower_Credits4 = "Originaly by Sneakyfoot of Resurrection of Nathrezim"
PallyPower_Credits5 = "Special Thanks: Gnarf, Blackoz"

-- Buff name, Class Name
PallyPower_CouldntFind = "Couldn't find a target for %s on %s!"

-- Buff name, Class name, Person Name
PallyPower_Casting = "Casting %s on %s (%s)"
-- Reporting
PallyPower_Assignments1 = "--- Paladin assignments ---"
PallyPower_Assignments2 = "--- end of assignments ---"

 PallyPower_ClassID = { };
PallyPower_ClassID[0] = "Warrior";
PallyPower_ClassID[1] = "Rogue";
PallyPower_ClassID[2] = "Priest";
PallyPower_ClassID[3] = "Druid";
PallyPower_ClassID[4] = "Paladin";
PallyPower_ClassID[5] = "Hunter";
PallyPower_ClassID[6] = "Mage";
PallyPower_ClassID[7] = "Warlock";

--XML
PALLYPOWER_CLEAR = "Clear";
PALLYPOWER_REFRESH = "Refresh";
PALLYPOWER_OPTIONS = "Options";
PALLYPOWER_OPTIONS_TITLE = "Pally Power Options";
PALLYPOWER_OPTIONS_SCAN = "Scan Frequency (seconds):";
PALLYPOWER_OPTIONS_SCAN2 = "Poll Per Frame: ";
PALLYPOWER_OPTIONS_FEEDBACK_CHAT = "Show feedback in chat";
PALLYPOWER_OPTIONS_SMARTBUFFS = "Smart Buffs";
if (GetLocale() == "deDE") then
	-- by Nextorus @ EU-Alexstrasza (nexter@walsweer.de)
    PallyPower_BlessingID[0] = "Weisheit";
    PallyPower_BlessingID[1] = "Macht";
    PallyPower_BlessingID[2] = "Rettung";
    PallyPower_BlessingID[3] = "Lichts";
    PallyPower_BlessingID[4] = "K\195\182nige";
    PallyPower_BlessingID[5] = "Refugiums";

    PallyPower_BlessingTalentSearch = "Verbesserter Segen de[rs] (.*)";
    PallyPower_BlessingSpellSearch = "Gro\195\159er Segen de[rs] (.*)";

    PallyPower_Rank1 = "Rang 1";
    PallyPower_RankSearch = "Rang (.*)";
    PallyPower_Symbol = "Symbol der K\195\182nige"

    -- _,class = UnitClass("player") returns....
    PallyPower_Paladin = "PALADIN";

    -- Used... ClassID .. ": Segen des "..BlessingID
    PallyPower_BuffFrameText = ": Segen der ";
    PallyPower_BuffFrameText_Alt = ": Segen des ";
    PallyPower_Have = "Hat: ";
    PallyPower_Need = "Braucht: ";
    PallyPower_NotHere = "Nicht hier: ";
    PallyPower_Dead = "Tot: ";

    PallyPower_BuffBarTitle = "Pally Buffs (%d)";

    --- By Lines... Keep People the same, feel free to add yourself in the _Credits3 line if your localizing
    --- And feel free to add a friend or two to special thanks
    PallyPower_Credits1 = "Pally Power - von Gnarf aka Sneakyfoot";
    PallyPower_Credits2 = "Version "..PallyPower_Version;
    PallyPower_Credits3 = "Deutsche Lokalisierung von Nextorus";
    PallyPower_Credits4 = "Erstellt f\195\188r Resurrection auf Nathrezim";
    PallyPower_Credits5 = "Vielen Dank an: Falline, Indada, Pinch, Tir, Ossijeanne";

    -- Buff name, Class Name
    PallyPower_CouldntFind = "Konnte kein Ziel finden f\195\188r %s auf %s!";

    -- Buff name, Class name, Person Name
    PallyPower_Casting = "Spreche %s auf %s (%s)";

     PallyPower_ClassID = { };
    PallyPower_ClassID[0] = "Krieger";
    PallyPower_ClassID[1] = "Schurke";
    PallyPower_ClassID[2] = "Priester";
    PallyPower_ClassID[3] = "Druide";
    PallyPower_ClassID[4] = "Paladin";
    PallyPower_ClassID[5] = "J\195\164ger";
    PallyPower_ClassID[6] = "Magier";
    PallyPower_ClassID[7] = "Hexenmeister";

    -- XML Localization
    PALLYPOWER_CLEAR = "L\195\182schen";
    PALLYPOWER_REFRESH = "Neu abfragen";
elseif (GetLocale() == "frFR") then

-- by Gagou @ EU-Drek'Thar (thomas@ranchon.org)
    PallyPower_BlessingID = { };
    PallyPower_BlessingID[0] = "de sagesse";
    PallyPower_BlessingID[1] = "de puissance";
    PallyPower_BlessingID[2] = "de salut";
    PallyPower_BlessingID[3] = "de lumi\195\168re";
    PallyPower_BlessingID[4] = "des rois";
    PallyPower_BlessingID[5] = "du sanctuaire";
    
    PallyPower_BlessingTalentSearch = "B\195\169n\195\169diction (.*) am\195\169lior\195\169e";
    PallyPower_BlessingSpellSearch = "B\195\169n\195\169diction (.*) sup\195\169rieure";
    PallyPower_Rank1 = "Rang 1"
    PallyPower_RankSearch = "Rang (.*)"
    PallyPower_Symbol = "Symbole des rois"
    
    -- _,class = UnitClass("player") returns....
    PallyPower_Paladin = "PALADIN"
    
    -- Used... ClassID .. ": B\195\169n\195\169diction de "..BlessingID
    PallyPower_BuffFrameText = ": B\195\169n\195\169diction de "
    PallyPower_Have = "A : "
    PallyPower_Need = "Besoin : "
    PallyPower_NotHere = "Pas ici : "
    PallyPower_Dead = "Mort : "
    
    PallyPower_BuffBarTitle = "Pally Buffs (%d)"
    
    --- By Lines... Keep People the same, feel free to add yourself in the _Credits3 line if your localizing
    --- And feel free to add a friend or two to special thanks
    PallyPower_Credits1 = "Pally Power - by Gnarf aka Sneakyfoot"
    PallyPower_Credits2 = "Version "..PallyPower_Version
    PallyPower_Credits3 = "Localisation Francaise par Gagou"
    PallyPower_Credits4 = "Made for Resurrection of Nathrezim"
    PallyPower_Credits5 = "Special Thanks: Falline, Indada, Pinch, Tir"
    
    -- Buff name, Class Name
    PallyPower_CouldntFind = "Ne peut trouver une cible pour b\195\169n\195\169diction %s sur %s!"
    
    -- Buff name, Class name, Person Name
    PallyPower_Casting = "Lance b\195\169n\195\169diction %s sur %s (%s)"
    
    
     PallyPower_ClassID = { };
    PallyPower_ClassID[0] = "Guerrier";
    PallyPower_ClassID[1] = "Voleur";
    PallyPower_ClassID[2] = "Pr\195\170tre";
    PallyPower_ClassID[3] = "Druide";
    PallyPower_ClassID[4] = "Paladin";
    PallyPower_ClassID[5] = "Chasseur";
    PallyPower_ClassID[6] = "Mage";
    PallyPower_ClassID[7] = "D\195\169moniste";
    
    --XML
    PALLYPOWER_CLEAR = "Nettoyer";
    PALLYPOWER_REFRESH = "Rafraichir";

end
