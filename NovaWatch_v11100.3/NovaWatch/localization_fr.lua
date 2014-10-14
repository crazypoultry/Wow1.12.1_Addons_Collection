-- French localization

if( GetLocale() == "frFR" ) then

NOVAWATCH_SPELL = "Nova de givre"

NOVAWATCH_TEXT_ENABLED = "NovaWatch: Activ\195\169"
NOVAWATCH_TEXT_DISABLED = "NovaWatch: D\195\169sactiv\195\169"

NOVAWATCH_TEXT_LOADED = "NovaWatch " .. NOVAWATCH_VERSION .. " Charg\195\169 - /novawatch"
NOVAWATCH_TEXT_WORLD_NOT_LOADED = "Le monde n'est pas charg\195\169, attendez s'il vous plait..."
NOVAWATCH_TEXT_PROFILECLEARED = "NovaWatch: Vos r\195\169glages sont incompatibles avec cette version, votre profil a \195\169t\195\169 supprim\195\169.\nNovaWatch: Merci de configurer NovaWatch avec /novawatch"
NOVAWATCH_TEXT_LOCKED = "NovaWatch: Frame verrouill\195\169"
NOVAWATCH_TEXT_UNLOCKED = "NovaWatch: Frame d\195\169verrouill\195\169"
NOVAWATCH_TEXT_INVERSION_ON = "NovaWatch: Statusbar diminue."
NOVAWATCH_TEXT_INVERSION_OFF = "NovaWatch: Statusbar augmente."
NOVAWATCH_TEXT_VERBOSE_ON = "NovaWatch: Debug On."
NOVAWATCH_TEXT_VERBOSE_OFF = "NovaWatch: Debug Off."
NOVAWATCH_TEXT_COUNTER_ON = "NovaWatch: Compteur activ\195\169."
NOVAWATCH_TEXT_COUNTER_OFF = "NovaWatch: Compteur d\195\169sactiv\195\169."
NOVAWATCH_TEXT_DECIMALS_ON = "NovaWatch: Affiche les d\195\169cimales du compteur."
NOVAWATCH_TEXT_DECIMALS_OFF = "NovaWatch: Cache les d\195\169cimales du compteur."
NOVAWATCH_TEXT_ANNOUNCE_CAST = " lanc\195\169 sur " 
NOVAWATCH_TEXT_ANNOUNCE_BREAK = NOVAWATCH_SPELL .. " a \195\169t\195\169 cass\195\169 de "
NOVAWATCH_TEXT_ANNOUNCE_FADE = NOVAWATCH_SPELL .. " s'est dissip\195\169 de " 
NOVAWATCH_TEXT_ANNOUNCE_LEAVECOMBAT = "NovaWatch: Tu as quitt\195\169 le combat."

NOVAWATCH_LABEL_ENABLE = "Activer NovaWatch"
NOVAWATCH_LABEL_VERBOSE = "Debug"
NOVAWATCH_LABEL_CLOSE = "Fermer"
NOVAWATCH_LABEL_MOVE = "D\195\169verrouiller"
NOVAWATCH_LABEL_MOVE2 = "Verrouiller"
NOVAWATCH_LABEL_COUNTER = "Affiche un compteur additionnel"
NOVAWATCH_LABEL_COUNTER_DIGITS = "Affiche les millisecondes"
NOVAWATCH_LABEL_DIRECTION_LABEL = "Direction:"
NOVAWATCH_LABEL_COLOR_LABEL = "Couleur:"
NOVAWATCH_LABEL_TRANSPARENCY = "Transparence"
NOVAWATCH_LABEL_SCALING = "Echelle de la barre"
NOVAWATCH_LIST_DIRECTIONS = { 
					{ name = "Augmentation", value = 1 },
					{ name = "Diminution", value = 2 }
}

NOVAWATCH_HELP1  = " - Configurer avec '/novawatch option'"
NOVAWATCH_HELP2  = "Options:"
NOVAWATCH_HELP3  = " on       : Activer NovaWatch"
NOVAWATCH_HELP4  = " off      : D\195\169sactiver NovaWatch"
NOVAWATCH_HELP5  = " lock     : V\195\169rrouille la position des barres et active NovaWatch"
NOVAWATCH_HELP6  = " unlock   : Vous permez de d\195\169placer les barres de NovaWatch"
NOVAWATCH_HELP7  = " invert   : Utilise l'autre sens de remplissage pour les barre (en augmentant / en diminuant)"
NOVAWATCH_HELP8  = " counter  : Montre/cache un compteur au dessus de la barre de progression" 
NOVAWATCH_HELP9  = " decimals : Affichage du compteur a chiffres"
NOVAWATCH_HELP10 = " verbose  : Debug mode On/Off"
NOVAWATCH_HELP11 = " status   : Affiche la configuration actuelle."

NOVAWATCH_EVENT_ON = "(.+) subit les effets de " .. NOVAWATCH_SPELL .. "."
NOVAWATCH_EVENT_CAST = "Vous lancez " .. NOVAWATCH_SPELL .. " sur (.+)." 
NOVAWATCH_EVENT_BREAK = "(.+) n'est plus sous l'influence de " .. NOVAWATCH_SPELL .. "."
NOVAWATCH_EVENT_OFF = NOVAWATCH_SPELL .. " sur (.+) vient de se dissiper."
NOVAWATCH_EVENT_DEATH = "(.+) meurt."

end