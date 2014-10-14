-- LootSpy Localisation
-- By: mymycracra
-- Language: frFR
-- Updated: 29/11/06

if ( GetLocale() == "frFR" ) then

-- Slash Command Feedback
LS_ENABLED = "LootSpy activ/195/169.";
LS_DISABLED = "LootSpy desactiv/195/169.";
LS_LOCKED = "LootSpy bloqu/195/169.";
LS_UNLOCKED = "LootSpy d/195/169bloqu/195/169.";
LS_SPAMOFF = "LootSpy affiche toutes les informations concernant les loots.";
LS_SPAMON = "LootSpy cache les informations types: 'X a choisit Y pour [Objet]'.";
LS_NEWFADE = "Le temps d'afficahge de la frame de LootSpy: ";
LS_FADEWRONG = "Erreur: Le temps d'affichage doit /195/170tre positif ou nul (en seconde).";

-- Frame Text
LS_NEED = "Besoin";
LS_GREED = "Cupidit/195/169";
LS_PASSED = "Pass/195/169";
LS_NEEDERS = "Besoin:";

-- Chat String Identification
LS_NEEDSTRING = "choisi Besoin pour";
LS_GREEDSTRING = "choisi Cupidit/195/169 pour";
LS_PASSEDSTRING = "a pass/195/169 pour";
LS_ALLPASSED = "Tout le monde a pass/195/169 pour: ";
LS_ITEMWON1 = "Vous avez gagn/195/169: ";
LS_ITEMWON2 = " a gagn/195/169: ";

LootSpy_GetLootData = function(arg)
arg = string.gsub(arg," a choisi ",":");
arg = string.gsub(arg," avez choisi ",":");
arg = string.gsub(arg," a ",":");
arg = string.gsub(arg," avez ",":");
arg = string.gsub(arg," pour: ","|");
arg = string.gsub(arg," a gagn/195/169: ",":|");
arg = string.gsub(arg," avez gagn/195/169: ",":|");
arg = string.gsub(arg,"Vous",UnitName("player"));
local playerName = string.sub(arg,1,strfind(arg,":")-1);
local itemName = string.sub(arg,strfind(arg,"|")+1,string.len(arg));
local rollType = string.sub(arg,strfind(arg,":")+1,strfind(arg,"|")-1);
return itemName,playerName,rollType;
end

end