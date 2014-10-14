
-- French
if ( GetLocale() == "frFR" ) then

-- é = \195\169
-- è = \195\168

    WCLocale.UI.rank = "(Rang %d)"
    WCLocale.UI.rankMatch = "^Rang (%d+)$"

--[[ example beta translation from google
    -- interface text translations
    WCLocale.UI.text.queueSummaryFail = " (échouer %d)"
    WCLocale.UI.text.queueBriefDisabled = "Éteint"
    WCLocale.UI.text.queueBriefEmpty = "Vide"
    WCLocale.UI.text.queueBriefQueued = "%d à la queue"
    WCLocale.UI.text.queueBriefUnavailable = "Indisponible"

    WCLocale.UI.text.queueFeedbackQueued = "Faire la queue %s sur %s"
    WCLocale.UI.text.queueFeedbackDuplicate = "Supplément %s sur %s"
    WCLocale.UI.text.queueFeedbackCleared = "La file d'attente s'est dégagée"

    WCLocale.UI.text.spellsNone = "Aucun orthographie pour %s"
    WCLocale.UI.text.spellsUnknown = "Charme inconnu %s"
    WCLocale.UI.text.spellsNotLearned = "Vous n'avez pas appris le charme %s"
    WCLocale.UI.text.spellsLevelTooLow = "Niveau de cible trop basw"

    WCLocale.UI.text.castingCantCast = "Ne peut pas mouler %s sur %s, %s"
    WCLocale.UI.text.castingCantTarget = "Ne peut pas viser %s pour %s"
    WCLocale.UI.text.castingOutOfRange = "%s est hors de gamme de %s"
    WCLocale.UI.text.castingCasting = "Bâti %s sur %s"

    WCLocale.UI.text.dropdownEnable = "Permettez s'queue"
    WCLocale.UI.text.dropdownGroupOnly = "Queue d'attente group/raid seulement"
    WCLocale.UI.text.dropdownCombatOnly = "Cuirs épais de fonte dans le combat"
    WCLocale.UI.text.dropdownHideWhispers = "Chuchoter assortis de peau"
    WCLocale.UI.text.dropdownSoundSub = "Bruit de jeu quand"
    WCLocale.UI.text.dropdownSoundFirstQueue = "Le premier charme est aligné"
    WCLocale.UI.text.dropdownSoundQueueEmpty = "La file d'attente est vide"
    WCLocale.UI.text.dropdownMatchingSub = "Assortiment de déclenchement"
    WCLocale.UI.text.dropdownMatchingExact = "Exigez le chuchoter"
    WCLocale.UI.text.dropdownMatchingStart = "Début de chuchoter"
    WCLocale.UI.text.dropdownMatchingAny = "Tout mot dans le chuchoter"
    WCLocale.UI.text.dropdownDisabledSub = "Éteint orthographie"
    WCLocale.UI.text.dropdownFlashQueue = "File d'attente instantanée si non vide"
    WCLocale.UI.text.dropdownMinimize = "Minimiser"
    WCLocale.UI.text.dropdownHide = "Dissimuler"
    WCLocale.UI.text.dropdownCast = "Jeter"
    WCLocale.UI.text.dropdownClear = "Évacuer"

    WCLocale.UI.text.buttonTextCast = "Jeter"
    WCLocale.UI.text.buttonTextClear = "Évacuer"
    WCLocale.UI.text.mouseoverMinimize = "Minimiser"
    WCLocale.UI.text.mouseoverHide = "Dissimuler"
    WCLocale.UI.text.mouseoverTitanHint = "Left-click to Cast\nShift left-click to Clear"
]]

    -- spell/trigger translations
    WCLocale.PRIEST.Power_Word_Fortitude = "Mot de pouvoir : Robustesse"
    wc_prepend( WCLocale.PRIEST.Power_Word_Fortitude_trigger, { "robust", "robustesse" } )
    WCLocale.PRIEST.Prayer_of_Fortitude = "Prière de robustesse"
    wc_prepend( WCLocale.PRIEST.Prayer_of_Fortitude_trigger, { "groupe robust", "groupe robustesse" } )
    WCLocale.PRIEST.Shadow_Protection = "Protection contre l\'ombre"
    wc_prepend( WCLocale.PRIEST.Shadow_Protection_trigger, { "l\'ombre", "lombre" } )
    WCLocale.PRIEST.Divine_Spirit = "Esprit divin"
    wc_prepend( WCLocale.PRIEST.Divine_Spirit_trigger, { "esprit", "sagesse" } )
    WCLocale.PRIEST.Power_Word_Shield = "Mot de pouvoir : Bouclier"
    wc_prepend( WCLocale.PRIEST.Power_Word_Shield_trigger, { "bouclier" } )
    WCLocale.PRIEST.Dispel_Magic = "Dissiper la magie"
    wc_prepend( WCLocale.PRIEST.Dispel_Magic_trigger, { "dissipe", "magie" } )
    WCLocale.PRIEST.Abolish_Disease = "Abolir maladie"
    wc_prepend( WCLocale.PRIEST.Abolish_Disease_trigger, { "maladie" } )
    WCLocale.PRIEST.Cure_Disease = "Guérison des maladies"
    wc_prepend( WCLocale.PRIEST.Cure_Disease_trigger, { "cure disease" } )
    WCLocale.PRIEST.Fear_Ward = "Gardien de peur"
    wc_prepend( WCLocale.PRIEST.Fear_Ward_trigger, { "gardien", "peur" } )

    WCLocale.MAGE.Arcane_Intellect = "Intelligence des arcanes"
    wc_prepend( WCLocale.MAGE.Arcane_Intellect_trigger, { "int", "arcane" } )
    WCLocale.MAGE.Arcane_Brilliance = "Illumination des arcanes"
    wc_prepend( WCLocale.MAGE.Arcane_Brilliance_trigger, { "illum", "illumine", "groupe int", "groupe arcane" } )
    WCLocale.MAGE.Dampen_Magic = "Atténuer la magie"
    wc_prepend( WCLocale.MAGE.Dampen_Magic_trigger, { "atténue", "attenue" } )
    WCLocale.MAGE.Amplify_Magic = "Amplification de la magie"
    wc_prepend( WCLocale.MAGE.Amplify_Magic_trigger, { "amplifie" } )
    WCLocale.MAGE.Remove_Lesser_Curse = "Délivrance de la malédiction mineure"
    wc_prepend( WCLocale.MAGE.Remove_Lesser_Curse_trigger, { "malédiction", "malediction" } )

    WCLocale.DRUID.Mark_of_the_Wild = "Marque de la nature"
    wc_prepend( WCLocale.DRUID.Mark_of_the_Wild_trigger, { "marque" } )
    WCLocale.DRUID.Gift_of_the_Wild = "Cadeau de la nature"
    wc_prepend( WCLocale.DRUID.Gift_of_the_Wild_trigger, { "cadeau", "groupe marque" } )
    WCLocale.DRUID.Thorns = "Epines"
    wc_prepend( WCLocale.DRUID.Thorns_trigger, { "epines" } )
    WCLocale.DRUID.Innervate = "Innervation"
    wc_prepend( WCLocale.DRUID.Innervate_trigger, { "innervation" } )
    WCLocale.DRUID.Remove_Curse = "Délivrance de la malédiction"
    wc_prepend( WCLocale.DRUID.Remove_Curse_trigger, { "malédiction", "malediction"} )
    WCLocale.DRUID.Abolish_Poison = "Abolir le poison"
--  wc_prepend( WCLocale.DRUID.Abolish_Poison_trigger, { "poison" } ) -- same as english
    WCLocale.DRUID.Cure_Poison = "Guérison du poison"
--  wc_prepend( WCLocale.DRUID.Cure_Poison_trigger, { "poison" } ) -- same as english

    WCLocale.PALADIN.Blessing_of_Might = "Bénédiction de puissance"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Might_trigger, { "puissance" } )
    WCLocale.PALADIN.Blessing_of_Wisdom = "Bénédiction de sagesse"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Wisdom_trigger, { "sagesse" } )
    WCLocale.PALADIN.Blessing_of_Freedom = "Bénédiction de liberté"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Freedom_trigger, { "liberté", "liberte" } )
    WCLocale.PALADIN.Blessing_of_Light = "Bénédiction de lumière"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Light_trigger, { "lumière", "lumiere" } )
    WCLocale.PALADIN.Blessing_of_Sacrifice = "Bénédiction de sacrifice"
--  wc_prepend( WCLocale.PALADIN.Blessing_of_Sacrifice_trigger, { "sacrifice" } ) -- same as english
    WCLocale.PALADIN.Blessing_of_Kings = "Bénédiction des rois"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Kings_trigger, { "roi", "rois" } )
    WCLocale.PALADIN.Blessing_of_Salvation = "Bénédiction de salut"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Salvation_trigger, { "salut" } )
    WCLocale.PALADIN.Blessing_of_Sanctuary = "Bénédiction du sanctuaire"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Sanctuary_trigger, { "sanctuaire" } )
    WCLocale.PALADIN.Blessing_of_Protection = "Bénédiction de protection"
    wc_prepend( WCLocale.PALADIN.Blessing_of_Protection_trigger, { "protection" } )
    WCLocale.PALADIN.Cleanse = "Epuration"
    wc_prepend( WCLocale.PALADIN.Cleanse_trigger, { "epuration", "dissiper", "magie" } )
    WCLocale.PALADIN.Purify = "Purification"
    wc_prepend( WCLocale.PALADIN.Purify_trigger, { "purifie", "maladie" } )

    WCLocale.SHAMAN.Cure_Poison = "Guérison du poison"
--  wc_prepend( WCLocale.SHAMAN.Cure_Poison_trigger, { "poison"} ) -- same as english
    WCLocale.SHAMAN.Cure_Disease = "Guérison des maladies"
    wc_prepend( WCLocale.SHAMAN.Cure_Disease_trigger, { "maladie" } )
    WCLocale.SHAMAN.Water_Breathing = "Respiration aquatique"
    wc_prepend( WCLocale.SHAMAN.Water_Breathing_trigger, { "l\'eau", "leau" } )

    WCLocale.WARLOCK.Unending_Breath = "Respiration interminable"
    wc_prepend( WCLocale.WARLOCK.Unending_Breath_trigger, { "l\'eau", "leau" } )
    WCLocale.WARLOCK.Detect_Greater_Invisibility = "Détecte l\'invisibilité supérieure"
--  wc_prepend( WCLocale.WARLOCK.Detect_Greater_Invisibility_trigger, { "invisible" } ) -- same as english
    WCLocale.WARLOCK.Ritual_of_Summoning = "Rituel d\'invocation"
    wc_prepend( WCLocale.WARLOCK.Ritual_of_Summoning_trigger, { "invoquant", "invocation" } )
end
