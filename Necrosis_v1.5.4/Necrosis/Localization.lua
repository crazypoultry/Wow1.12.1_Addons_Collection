------------------------------------------------------------------------------------------------------
-- Necrosis LdC
--
-- Créateur initial (US) : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Implémentation de base (FR) : Tilienna Thorondor
-- Reprise du projet : Lomig & Nyx des Larmes de Cenarius, Kael'Thas
-- 
-- Skins et voix Françaises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements spéciaux pour Sadyre (JoL)
-- Version 28.06.2006-1
------------------------------------------------------------------------------------------------------



NecrosisData = {};
NecrosisData.Version = "1.5.2";
NecrosisData.Author = "Lomig & Nyx";
NecrosisData.AppName = "Necrosis";
NecrosisData.Label = NecrosisData.AppName.." "..NecrosisData.Version.." by "..NecrosisData.Author;


-- Raccourcis claviers
BINDING_HEADER_NECRO_BIND = "Necrosis";
   
BINDING_NAME_SOULSTONE = "Pierre d'\195\162me / Soulstone";
BINDING_NAME_HEALTHSTONE = "Pierre de soins / Healthstone";
BINDING_NAME_SPELLSTONE = "Pierre de sort / Spellstone";
BINDING_NAME_FIRESTONE = "Pierre de feu / Firestone";
BINDING_NAME_STEED = "Monture / Steed";
BINDING_NAME_WARD = "Gardien de l'ombre / Shadow Ward";
BINDING_NAME_CURSE = "Cast Selected Curse";
BINDING_NAME_BANNISH = "Banish";
BINDING_NAME_ENSLAVE = "Enslave";
BINDING_NAME_HOT = "Howl of Terror";
BINDING_NAME_FEAR = "Fear";
BINDING_NAME_DRAINSOUL = "Drain Soul";
BINDING_NAME_SCALEDTAPLIFE = "Scaled Tap Life (Kimilly)";

-- sylvette - ported scaled life tap from Kimilly
SCALEDLIFETAP_LIFETAPSPELL = ""
SCALEDLIFETAP_LIFETAPTALENT = ""
SCALEDLIFETAP_RANKTEXT=""
SCALEDLIFETAP_RANKREGEXP=""