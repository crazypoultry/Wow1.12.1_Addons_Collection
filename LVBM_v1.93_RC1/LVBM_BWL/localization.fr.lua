-- -------------------------------------------- --
-- La Vendetta Boss Mods / French Localization  --
--                        By Proreborn et cr0k  --
-- -------------------------------------------- --

if ( GetLocale() == "frFR" ) then	

--Razorgore
LVBM_RG_NAME		= "Tranchetripe l'Indompt\195\169";
LVBM_RG_DESCRIPTION	= "Affiche un timer au d\195\169but du spawn d'adds.";

LVBM_RG_CONTROLLER	= "Grethok le Controleur";


--Vaelastrasz
LVBM_VAEL_NAME			= "Vaelastrasz le Corrompu";
LVBM_VAEL_DESCRIPTION		= "Annonce <Mont\195\169e d'adrenaline>.";
LVBM_VAEL_SEND_WHISPER		= "Envoyer des whisps";
LVBM_VAEL_SET_ICON		= "Mettre ic\195\180ne";

LVBM_VAEL_BA_WARNING		= "*** ! %s a la bombe! ***";
LVBM_VAEL_BA_WHISPER		= "Vous avez la bombe!";
LVBM_VAEL_BA			= "Mont\195\169e d'adr\195\169naline";

LVBM_VAEL_BA_REGEXP		= "([^%s]+) (%w+) a la Mont\195\169e d'Adr\195\169naline.";
LVBM_VAEL_BA_FADES_REGEXP	= "Mont\195\169e d'Adr\195\169naline dispara\195\174t de ([^%s]+)%.";

--Lashlayer
LVBM_LASHLAYER_NAME	= "Seigneur des Couv\195\169es Lashlayer";
LVBM_LASHLAYER_YELL	= "Aucun de votre esp\195\168ce ne devra\195\174t \195\170tre ici!";

--Firemaw/Ebonroc/Flamegor
LVBM_FIREMAW_NAME			= "Gueule de Feu";
LVBM_FIREMAW_DESCRIPTION		= "Affiche un timer pour la<Frappe d'Aile.";
LVBM_EBONROC_NAME			= "Roch\195\169b\195\168ne";
LVBM_EBONROC_DESCRIPTION		= "Affiche un timer pour la Frappe d'Aile et la Ombre de Roch\195\169b\195\168ne.";
LVBM_EBONROC_SET_ICON			= "Mettre ic\195\180ne"
LVBM_FLAMEGOR_NAME			= "Flamegor";
LVBM_FLAMEGOR_DESCRIPTION		= "Affiche un timer pour<Frappe d'aile et annonce Fr\195\169n\195\169sie";
LVBM_FLAMEGOR_ANNOUNCE_FRENZY		= "Annonce Fr\195\169n\195\169sie";

LVBM_FIREMAW_FIREMAW			= "Gueule de Feu";
LVBM_EBONROC_EBONROC			= "Roch\195\169b\195\168ne";
LVBM_FLAMEGOR_FLAMEGOR			= "Flamegor";

LVBM_FIREMAW_WING_BUFFET		= "Gueule%-de%-feu commence \195\160 lancer Frappe des ailes.";
LVBM_EBONROC_WING_BUFFET		= "Roch\195\169b\195\168ne commence \195\160 lancer Frappe des ailes.";
LVBM_FLAMEGOR_WING_BUFFET		= "Flamegor commence \195\160 lancer Frappe des ailes.";

LVBM_FIREMAW_SHADOW_FLAME		= "Gueule%-de%-feu commence \195\160 lancer Flamme d'ombre.";
LVBM_EBONROC_SHADOW_FLAME		= "Roch\195\169b\195\168ne commence \195\160 lancer Flamme d'ombre.";
LVBM_FLAMEGOR_SHADOW_FLAME		= "Flamegor commence \195\160 lancer Flamme d'ombre.";

LVBM_SHADOW_FLAME_WARNING		= "*** Flamme d'Ombre dans 2 sec ***";
LVBM_WING_BUFFET_WARNING		= "*** Frappe d'Aile dans %s sec ***";
LVBM_EBONROC_SHADOW_WARNING		= "*** %s a l'Ombre de Roch\195\169b\195\168ne ***";
LVBM_FLAMEGOR_FRENZY			= "%s est en mode Fr\195\169n\195\169sie ***ATTENTION***!";

LVBM_EBONROC_SHADOW_REGEXP		= "([^%s]+) (%w+) est affect\195\169 par l'Ombre de Roch\195\169b\195\168ne.";
LVBM_EBONROC_SHADOW_REGEXP2		= "Ombre de Roch\195\169b\195\168ne disparaît de ([^%s]+)%.";

LVBM_SBT["Wing Buffet"]			= "Frappe des ailes";
LVBM_SBT["Wing Buffet Cast"]		= "lancer Frappe des ailes";
LVBM_SBT["Shadow Flame Cast"]		= "lancer Flamme d'ombre";


--Chromaggus
LVBM_CHROMAGGUS_NAME				= "Chromaggus";
LVBM_CHROMAGGUS_DESCRIPTION			= "Affiche un timer pour les Souffles et annonce la vuln\195\169rabilit\195\169.";
LVBM_CHROMAGGUS_ANNOUNCE_FRENZY			= "Annonce <Fr\195\169n\195\169sie>";
LVBM_CHROMAGGUS_ANNOUNCE_VULNERABILITY		= "Annonce la vuln\195\169rabilit\195\169"
LVBM_CHROMAGGUS_BREATH_1			= "Souffle 1";
LVBM_CHROMAGGUS_BREATH_2			= "Souffle 2";

LVBM_CHROMAGGUS_BREATH_CAST_WARNING		= "*** Chromaggus commence \195\160 lancer %s ***"
LVBM_CHROMAGGUS_BREATH_WARNING			= "*** %s dans 10 sec ***"

LVBM_CHROMAGGUS_BREATH_REGEXP			= "Chromaggus commence \195\160 lancer ([%w%s]+)";
LVBM_CHROMAGGUS_VULNERABILITY_REGEXP		= "[^%s]+ [^%s]+ (%w+) Chromaggus pour (%d+) ([^%s]+) dommages";
LVBM_CHROMAGGUS_CHROMAGGUS			= "Chromaggus";

LVBM_SBT["Breath 1"]	= "Souffle 1";
LVBM_SBT["Breath 2"]	= "Souffle 2";

--Nefarian
LVBM_NEFARIAN_NAME		= "Nefarian";
LVBM_NEFARIAN_DESCRIPTION	= "Affiche un timer pour chaque <Appel de Classe>.";
LVBM_NEFARIAN_BLOCK_HEALS	= "Bloquer les heals pendant l' <Appel de Classe Pr\195\170tres>";
LVBM_NEFARIAN_UNEQUIP_BOW	= "D\195\169s\195\169quiper arcs/fusils avant chaque <Appel de classe>";

LVBM_NEFARIAN_FEAR_WARNING			= "*** Fear dans 1.5 sec ***";
LVBM_NEFARIAN_PHASE2_WARNING			= "*** Nefarian arrive dans - 15 sec ***";
LVBM_NEFARIAN_CLASS_CALL_WARNING		= "*** Appel de classe IMMINENT ***";
LVBM_NEFARIAN_SHAMAN_WARNING			= "*** Appel Shaman - totems ***";
LVBM_NEFARIAN_PALA_WARNING			= "*** Appel Paladin - B\195\169n\195\169diction de Protection sur Nefarian pendant 10 secs ***";
LVBM_NEFARIAN_DRUID_WARNING			= "*** Appel Druide - En forme de F\195\169lin ***";
LVBM_NEFARIAN_PRIEST_WARNING			= "*** Appel Priest - Arr\195\170tez de heal ***";
LVBM_NEFARIAN_WARRIOR_WARNING			= "*** Appel Warrior - Posture Berserker ***";
LVBM_NEFARIAN_ROGUE_WARNING			= "*** Appel Rogue - T\195\169l\195\169port\195\169s et Immobilis\195\169s ***";
LVBM_NEFARIAN_WARLOCK_WARNING			= "*** Appel Warlock - Arriv\195\169e des Infernaux ***";
LVBM_NEFARIAN_HUNTER_WARNING			= "*** Appel Hunter - Arcs/Fusils \195\160 0 Durabilit\195\169 ***";
LVBM_NEFARIAN_MAGE_WARNING			= "*** Appel Mage - Polymorph Imminent DISPELL ***";
LVBM_NEFARIAN_PRIEST_CALL			= "Appel de classe Pr\195\170tre";
LVBM_NEFARIAN_HEAL_BLOCKED			= "Vous n'\195\170tes pas autoris\195\169 \195\160 cast %s pendant l'Appel de Classe Pr\195\170tre!";
LVBM_NEFARIAN_UNEQUIP_ERROR			= "Erreur survenue lors du changement de votre arc/fusil."
LVBM_NEFARIAN_EQUIP_ERROR			= "Erreur survenue lors de l'\195\169quipement de votre arc/fusil."

LVBM_NEFARIAN_BLOCKED_SPELLS	= {
	["Flash Heal"]			= 1.5,
	["Greater Heal"]		= 2.5,
	["Prayer of Healing"]	= 3,
	["Heal"]				= 2.5,
	["Lesser Heal"]			= 1.5,
}

LVBM_NEFARIAN_CAST_SHADOW_FLAME		= "Nefarian commence \195\160 lancer Flamme d'ombre.";
LVBM_NEFARIAN_CAST_FEAR			= "Nefarian commence \195\160 lancer Rugissement puissant.";
LVBM_NEFARIAN_YELL_PHASE1		= "Que les jeux commencent !";
LVBM_NEFARIAN_YELL_PHASE2		= "Beau travail ! Le courage des mortels commence \195\160 faiblir ! Voyons maintenant s'ils peuvent lutter contre le v\195\169ritable seigneur du pic Blackrock !";
LVBM_NEFARIAN_YELL_PHASE3		= "C'est impossible ! Relevez-vous, serviteurs ! Servez une nouvelle fois votre maître !";
LVBM_NEFARIAN_YELL_SHAMANS		= "Chamans, montrez%-moi";
LVBM_NEFARIAN_YELL_PALAS		= "Les paladins... J'en entendu dire que vous aviez de nombreuses vie... Montrez-moi.";
LVBM_NEFARIAN_YELL_DRUIDS		= "Les druides et leur stupides changements de forme. Voyons ce qu'ils donnent en vrai...";
LVBM_NEFARIAN_YELL_PRIESTS		= "Pr\195\170tres ! Si vous continuez \195\160 soigner comme ça, nous pourrions rendre le processus plus int\195\169ressant !";
LVBM_NEFARIAN_YELL_WARRIORS		= "Guerriers, je sais que vous pouvez frapper plus fort que ça ! Voyons ça !";
LVBM_NEFARIAN_YELL_ROGUES		= "Voleurs, arr\195\170tez de vous cacher et affrontez-moi !";
LVBM_NEFARIAN_YELL_WARLOCKS		= "D\195\169monistes, vous ne devriez pas jouer avec une magie qui vous d\195\169passe. Vous voyez ce qui arrive ?";
LVBM_NEFARIAN_YELL_HUNTERS		= "Ah, les chasseurs et les stupides sarbacanes !";
LVBM_NEFARIAN_YELL_MAGES		= "Les mages aussi ? Vous devriez \195\170etre plus prudents lorsque vous jouez avec la magie.";
LVBM_NEFARIAN_YELL_DEAD			= "C'est impossible ! Je suis le Maître ici ! Vous, mortels, n'êtes rien pour nous ! Vous entendez ? Rien !";

LVBM_SBT["Class call CD"] 	= "Appel de classe CD";
LVBM_SBT["Druid call"] 		= "Appel de classe Druide";
LVBM_SBT["Priest call"] 	= "Appel de classe Pr\195\170tre";
LVBM_SBT["Warrior call"] 	= "Appel de classe Guerrier";
LVBM_SBT["Rogue call"] 		= "Appel de classe Voleur";
LVBM_SBT["Mage call"] 		= "Appel de classe Mage";

end

