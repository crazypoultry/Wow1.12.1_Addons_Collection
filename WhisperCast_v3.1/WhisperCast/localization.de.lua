
if ( GetLocale() == "deDE" ) then -- German

-- ü - \195\188
-- Ü - \195\156
-- ö - \195\182
-- Ö - \195\150
-- ä - \195\164
-- Ä - \195\134
-- ß - \195\159

    WCLocale.UI.rank = "(Rang %d)"
    WCLocale.UI.rankMatch = "^Rang (%d+)$"

    -- german triggers are added to the english triggers

    WCLocale.PRIEST.Power_Word_Fortitude = "Machtwort: Seelenstärke"
    wc_prepend( WCLocale.PRIEST.Power_Word_Fortitude_trigger, { "ss", "seelen", "seelenstärke", "ausdauer", "seele" } )
    WCLocale.PRIEST.Prayer_of_Fortitude = "Gebet der Seelenstärke"
    wc_prepend( WCLocale.PRIEST.Prayer_of_Fortitude_trigger, { "gruppen ss", "gruppen seelen", "gruppen seelenstärke", "gruppen ausdauer" , "gruppen seele", "gdss", "gss", "gds", "gebet" } )
    WCLocale.PRIEST.Prayer_of_Spirit = "Gebet der Willenskraft"
    wc_prepend( WCLocale.PRIEST.Prayer_of_Spirit_trigger, { "willgebet" } )
    WCLocale.PRIEST.Prayer_of_Shadow_Protection = "Gebet des Schattenschutzes"
    wc_prepend( WCLocale.PRIEST.Prayer_of_Shadow_Protection_trigger, { "schattengebet" } )
    WCLocale.PRIEST.Shadow_Protection = "Schattenschutz"
    wc_prepend( WCLocale.PRIEST.Shadow_Protection_trigger, { "schatten", "schattenschutz" } )
    WCLocale.PRIEST.Divine_Spirit = "Göttlicher Willen"
    wc_prepend( WCLocale.PRIEST.Divine_Spirit_trigger, { "weisheit", "wille" } )
    WCLocale.PRIEST.Power_Infusion = "Seele der Macht"
    wc_prepend( WCLocale.PRIEST.Power_Infusion_trigger, { "macht", "d\195\164mmitsch" } )
    WCLocale.PRIEST.Power_Word_Shield = "Machtwort: Schild"
    wc_prepend( WCLocale.PRIEST.Power_Word_Shield_trigger, { "schild" } )
    WCLocale.PRIEST.Dispel_Magic = "Magiebannung"
    wc_prepend( WCLocale.PRIEST.Dispel_Magic_trigger, { "bannen", "magie" } )
    WCLocale.PRIEST.Abolish_Disease = "Krankheit aufheben"
    wc_prepend( WCLocale.PRIEST.Abolish_Disease_trigger, { "krankheit", "krank" } )
    WCLocale.PRIEST.Cure_Disease = "Krankheit heilen"
    wc_prepend( WCLocale.PRIEST.Cure_Disease_trigger, { "cure disease" } )
    WCLocale.PRIEST.Fear_Ward = "Furcht-Zauberschutz"
    wc_prepend( WCLocale.PRIEST.Fear_Ward_trigger, { "furcht", "zauberschutz", "furchtbarriere", "barriere" } )
    WCLocale.PRIEST.Fear_Ward_rank = { 20 }

    WCLocale.MAGE.Arcane_Intellect = "Arkane Intelligenz"
    wc_prepend( WCLocale.MAGE.Arcane_Intellect_trigger, { "intellekt", "intelligenz", "arkan" } )
    WCLocale.MAGE.Arcane_Brilliance = "Arkane Brillanz"
    wc_prepend( WCLocale.MAGE.Arcane_Brilliance_trigger, { "gruppen ai", "gruppen int", "brillanz", "brillianz" } )
    WCLocale.MAGE.Dampen_Magic = "Magiedämpfer"
    wc_prepend( WCLocale.MAGE.Dampen_Magic_trigger, { "dämpfer", "dampfer", "dämpfen", "dampfen" } )
    WCLocale.MAGE.Amplify_Magic = "Magie verstärken"
    wc_prepend( WCLocale.MAGE.Amplify_Magic_trigger, { "verstärken", "verstarken" } )
    WCLocale.MAGE.Remove_Lesser_Curse = "Geringen Fluch aufheben"
    wc_prepend( WCLocale.MAGE.Remove_Lesser_Curse_trigger, { "fluch" } )

    WCLocale.DRUID.Mark_of_the_Wild = "Mal der Wildnis"
    wc_prepend( WCLocale.DRUID.Mark_of_the_Wild_trigger, { "mal", "mdw" } )
    WCLocale.DRUID.Gift_of_the_Wild = "Gabe der Wildnis"
    -- can't append english triggers for gift of the wild, gift=poison in german
    WCLocale.DRUID.Gift_of_the_Wild_trigger = { "gotw", "group mark", "gabe", "gruppen mal", "gdw" }
    WCLocale.DRUID.Thorns = "Dornen"
    wc_prepend( WCLocale.DRUID.Thorns_trigger, { "dornen" } )
    WCLocale.DRUID.Innervate = "Anregen"
    wc_prepend( WCLocale.DRUID.Innervate_trigger, { "anregen" } )
    WCLocale.DRUID.Remove_Curse = "Fluch aufheben"
    wc_prepend( WCLocale.DRUID.Remove_Curse_trigger, { "fluch" } )
    WCLocale.DRUID.Abolish_Poison = "Vergiftung aufheben"
    wc_prepend( WCLocale.DRUID.Abolish_Poison_trigger, { "gift" } )
    WCLocale.DRUID.Cure_Poison = "Vergiftung heilen"
    wc_prepend( WCLocale.DRUID.Cure_Poison_trigger, { "gift" } )

    WCLocale.PALADIN.Blessing_of_Might = "Segen der Macht"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Might_trigger, { "macht", "sdm" } )
    WCLocale.PALADIN.Blessing_of_Wisdom = "Segen der Weisheit"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Wisdom_trigger, { "weisheit", "sdw" } )
    WCLocale.PALADIN.Blessing_of_Freedom = "Segen der Freiheit"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Freedom_trigger, { "freiheit", "sdf" } )
    WCLocale.PALADIN.Blessing_of_Freedom_rank = { 18 }
    WCLocale.PALADIN.Blessing_of_Light = "Segen des Lichts"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Light_trigger, { "licht", "sdl" } )
    WCLocale.PALADIN.Blessing_of_Sacrifice = "Segen der Opferung"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Sacrifice_trigger, { "opferung", "opfer", "opfern", "sdo" } )
    WCLocale.PALADIN.Blessing_of_Kings = "Segen der Könige"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Kings_trigger, { "könige", "könig", "konige", "konig", "sdk" } )
    WCLocale.PALADIN.Blessing_of_Salvation = "Segen der Rettung"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Salvation_trigger, { "rettung", "sdr" } )
    WCLocale.PALADIN.Blessing_of_Sanctuary = "Segen des Refugiums"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Sanctuary_trigger, { "refugium", "ref" } )
    WCLocale.PALADIN.Blessing_of_Protection = "Segen des Schutzes"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Protection_trigger, { "schutz", "sds" } )
    WCLocale.PALADIN.Cleanse = "Reinigung des Glaubens"
    wc_prepend( WCLocale.PALADIN.Cleanse_trigger, { "bannen", "magie" } )
    WCLocale.PALADIN.Purify = "Läutern"
    wc_prepend( WCLocale.PALADIN.Purify_trigger, { "gift", "krankheit", "krank" } )
    WCLocale.PALADIN.Greater_Blessing_of_Might = "Gro\195\159er Segen der Macht"
    wc_prepend( WCLocale.PALADIN.Greater_Blessing_of_Might_trigger , { "gmacht", "gsdm" } ) 
    WCLocale.PALADIN.Greater_Blessing_of_Wisdom = "Gro\195\159er Segen der Weisheit"
    wc_prepend( WCLocale.PALADIN.Greater_Blessing_of_Wisdom_trigger, { "gweisheit", "gsdw" } ) 
    WCLocale.PALADIN.Greater_Blessing_of_Light = "Gro\195\159er Segen des Lichts"
    wc_prepend( WCLocale.PALADIN.Greater_Blessing_of_Light_trigger , { "glicht", "gsdl" } ) 
    WCLocale.PALADIN.Greater_Blessing_of_Kings = "Gro\195\159er Segen der K\195\182nige"
    wc_prepend( WCLocale.PALADIN.Greater_Blessing_of_Kings_trigger , { "gkings", "gsdk" } ) 
    WCLocale.PALADIN.Greater_Blessing_of_Salvation = "Gro\195\159er Segen der Rettung"
    wc_prepend( WCLocale.PALADIN.Greater_Blessing_of_Salvation_trigger, { "grettung", "gsdr" } )
    WCLocale.PALADIN.Greater_Blessing_of_Sanctuary = "Gro\195\159er Segen des Refugiums"
    wc_prepend( WCLocale.PALADIN.Greater_Blessing_of_Sanctuary_trigger, { "grefugium", "gsdref" } )


    WCLocale.SHAMAN.Cure_Poison = "Vergiftung heilen"
    wc_prepend( WCLocale.SHAMAN.Cure_Poison_trigger, { "gift" } )
    WCLocale.SHAMAN.Cure_Disease = "Krankheit heilen"
    wc_prepend( WCLocale.SHAMAN.Cure_Disease_trigger, { "krankheit", "krank" } )
    WCLocale.SHAMAN.Water_Breathing = "Wasseratmung"
    wc_prepend( WCLocale.SHAMAN.Water_Breathing_trigger, { "tauchen", "atmung", "wasser atmung" } )

    WCLocale.WARLOCK.Unending_Breath = "Unendlicher Atem"
    wc_prepend( WCLocale.WARLOCK.Unending_Breath_trigger, { "tauchen", "atmung", "wasser atmung" } )
    WCLocale.WARLOCK.Detect_Greater_Invisibility = "Große Unsichtbarkeit entdecken"
    wc_prepend( WCLocale.WARLOCK.Detect_Greater_Invisibility_trigger, { "unsicht", "unsichtbar" } )
    WCLocale.WARLOCK.Ritual_of_Summoning = "Ritual der Beschwörung"
    wc_prepend( WCLocale.WARLOCK.Ritual_of_Summoning_trigger, { "beschwörung", "beschworung" } ) -- my best guess
end
