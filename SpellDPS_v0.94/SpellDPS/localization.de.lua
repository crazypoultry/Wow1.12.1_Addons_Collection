-- German localization provided by ArtureLeCoiffeur

if(GetLocale()=="deDE") then

    -- Displayed text formatting
    SpellDPS_XPS = {"(%.1f Schaden pro Sekunde)", "(%.1f Heilung pro Sekunde)"};
    SpellDPS_XPM = {"%.2f spm", "%.2f hpm"};
    SpellDPS_TX  = {"%d Schaden insgesamt", "%d Heilung insgesamt"};

    -- Tooltip parsing templates, prelude
    SpellDPS_Mana   = "^(%d+) Mana";
    SpellDPS_Cast1  = "^Wirken in (%d+) Sek.";
    SpellDPS_Cast2  = "^Wirken in (%d+),(%d) Sek.";
    SpellDPS_Weapon = "^Ben..tigt %a+[Ww]affe";
    SpellDPS_Totem  = "Werkzeuge: .*%a+%-Totem";

    -- Tooltip parsing templates, detect spells that don't consume mana
    SpellDPS_Manaless = {
        "Verzweifeltes Gebet"
    }

    -- Tooltip parsing templates, description
    -- {effect index; low#, high#, sec#1, #2, sec#2, flag}
    SpellDPS_Desc = {
    {1; {1,2,0,4,3,0}; " (%d+) bis (%d+) .* %a+schaden .* (%d+) Sek%. .* (%d+) .+schaden"};
    {1; {2,3,1,0,0,1}; " (%d+) Sek%. lang pro Sekunde (%d+) bis (%d+) .*schaden"};
    {1; {2,2,1,0,0,1}; " (%d+) Sek%. lang pro Sekunde (%d+) .*schaden"};
    {1; {0,0,0,2,1,1}; " (%d+) Sek%. lang.* (%d+) .*schaden"};
    {1; {1,1,0,3,2,0}; " (%d+) Punkt%(e%) Feuerschaden sowie (%d+) Sek%. lang (%d+) Punkt%(e%) Feuerschaden"};
    {1; {2,3,1,0,0,2}; " (%d+) Sek%. lang .* alle 2 Sekunden.* (%d+) bis (%d+) Punkt%(e%) Feuerschaden"};
    {1; {2,2,1,0,0,2}; " (%d+) Sek%. lang .* alle 2 Sekunden.* (%d+) Punkt%(e%) Feuerschaden"};
    {1; {1,2,0,0,0,0}; " (%d+) bis (%d+) .*schaden"};
    {1; {1,1,0,0,0,0}; " Distanzschaden um (%d+)"};
    {1; {1,1,0,0,0,0}; " (%d+) Punkt%(e%) Schaden"};
    {1; {1,1,0,0,0,0}; " um (%d+) Punkt%(e%) erh..ht"};
    {1; {1,1,0,0,0,0}; " (%d+) .*schaden"};
    {1; {0,0,0,2,1,0}; " (%d+) Sek%. lang (%d+) .*schaden"};
    {2; {0,0,0,2,1,0}; "^Heilt .+ (%d+) Sek%. lang um (%d+)"};
    {2; {0,0,0,1,2,0}; "^Heilt .+ um (%d+) .+ (%d+) Sek%. lang"};
    {2; {1,2,0,0,0,0}; "(%d+) bis (%d+) .* [Hh]eil"};
    {2; {1,2,0,0,0,0}; "[Hh]eilt .* (%d+) bis (%d+)"};
    {2; {0,0,0,2,1,0}; "alle (%d+) Sek%. (%d+) Punkt%(e%) Gesundheit"};
    {2; {0,0,0,2,1,0}; "(%d+) Sek%. lang in jeder Sekunde (%d+) Punkt%(e%) Gesundheit"};
    {2; {0,0,0,2,1,-4}; "(%d+) Min%. lang .* alle 2 Sekunden um (%d+)"};
    {1; {2,3,0,1,-60,-1}; "Absorbiert (%d+) .*[Ss]chaden.+ Entzieht dem Ziel (%d+),(%d) Punkt%(e%) Mana"};
    {1; {0,0,0,1,2,0}; "[Aa]bsorbiert.* (%d+) .*[Ss]chaden%. H..lt (%d+) Sek%. lang an"};
    {1; {0,0,0,1,2,-3}; "[Aa]bsorbiert.* (%d+) .*[Ss]chaden%. H..lt (%d+) Min%. lang an"};
    {1; {1,2,0,0,0,-2}; "^Entzieht dem Ziel (%d+) bis (%d+) Punkte Mana"};
    {1; {2,2,1,0,0,0}; " (%d+) Sek%. lang (%d+) Mana"};
    }

end
