-------------------------------------------------------------------------------
-- French localization (Corrected by the Grinch)
-- Last Update 08.30.06 (From Release Testversion13a)
-------------------------------------------------------------------------------

if GetLocale() == "frFR" then

  CLEANCHAT_WHO_RESULTS_PATTERN = "%d+ joueur[s]? au total";

  CLEANCHAT_TRANSLATE_CLASS = {
    ["Chasseur"] = "HUNTER",
    ["D\195\169moniste"] = 1,
    ["Pr\195\170tre"]    = 2,
    ["Paladin"]          = 3,
    ["Mage"]             = 4,
    ["Voleur"]           = 6,
    ["Druide"]           = 7,
    ["Chaman"]           = 8,
    ["Guerrier"]         = 9
  };

  CLEANCHAT_LOADED = " chargé";
  CLEANCHAT_LOADED_CACHE = CLEANCHAT_VERSION .. " chargé (%d noms)";

  CLEANCHAT_MYADDONS_DESCRIPTION = "Supprime les préfixes [Groupe], [Raid], [Officier] et [Guilde] dans les messages de discussion.";
  CLEANCHAT_MYADDONS_RELEASEDATE = "13 octobre 2006";

  CLEANCHAT_CHANNELS = {
    {},
    { ["__PREFIX"] = "\. ",
      ["Général"] = "",
      ["Commerce"] = "" },
    { ["__PREFIX"] = "\. ",
      ["Général"] = "",
      ["Commerce"] = "",
      ["DéfenseLocale"] = "",
      ["DéfenseUniverselle"] = "",
      ["RechercheGroupe"] = "",
      ["RecrutementDeGuilde"] = "" },
    { ["__PREFIX"] = "\. ",
      ["Général"] = "",
      ["Commerce"] = "",
      ["DéfenseLocale"] = "",
      ["DéfenseUniverselle"] = "",
      ["RechercheGroupe"] = "",
      ["RecrutementDeGuilde"] = "" },
    { ["__PREFIX"] = "%d\. ",
      ["Général"] = "G",
      ["Commerce"] = "C",
      ["DéfenseLocale"] = "DL",
      ["DéfenseUniverselle"] = "DU",
      ["RechercheGroupe"] = "LFG",
      ["RecrutementDeGuilde"] = "RG" },
    { ["__PREFIX"] = "%d\. ",
      ["Général"] = "G",
      ["Commerce"] = "C",
      ["DéfenseLocale"] = "DL",
      ["DéfenseUniverselle"] = "DU",
      ["RechercheGroupe"] = "LFG",
      ["RecrutementDeGuilde"] = "RG" } };

  CLEANCHAT_PREFIX_RAID = {
    [false] = CHAT_RAID_GET,
    [true]  = "%s :\32" };

  CLEANCHAT_PREFIX_PARTY = {
    [false] = CHAT_PARTY_GET,
    [true]  =  "%s�:\32" };

  CLEANCHAT_PREFIX_OFFICER = {
    [false] = CHAT_OFFICER_GET,
    [true]  = "%s�:\32" };

  CLEANCHAT_PREFIX_GUILD = {
    [false] = CHAT_GUILD_GET,
    [true]  = "%s :\32" };

  CLEANCHAT_PREFIX_RAIDLEADER = {
    [false] = CHAT_RAID_LEADER_GET,
    [true]  = "[Cr] %s :\32" };

  CLEANCHAT_PREFIX_RAIDWARNING = {
    [false] = CHAT_RAID_WARNING_GET,
    [true]  = "[Ar] %s :\32" };

  CLEANCHAT_PREFIX_BG = {
    [false] = CHAT_BATTLEGROUND_GET,
    [true]  = "[BG] %s:\32"
  };
  
  CLEANCHAT_PREFIX_BGLEADER = {
    [false] = CHAT_BATTLEGROUND_LEADER_GET,
    [true]  = "[BGL] %s:\32"
  };
  CLEANCHAT_HELP = { HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Afficher l'interface.",
                     HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat status" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Afficher les paramètres." };

  CLEANCHAT_STATUSMSG = "Status%d: " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s";

  CLEANCHAT_STATUS1 = {
    [true] = "Le préfixe de discussion n'est pas affiché.",
    [false] = "Le préfixe de discussion est affiché." };

  CLEANCHAT_STATUS2A = {
    [true] = "Changer la couleur des noms est activé.",
    [false] = "Changer la couleur des noms est désactivé." };

  CLEANCHAT_STATUS2B = {
    [true]  = { [true]  = "Changement de couleur par classe est activé.",
                [false] = "Changement de couleur par classe est désactivé." },
    [false] = { [true]  = "",
                [false] = "" } };

  CLEANCHAT_STATUS3 = {

    "Tous les noms des canaux sont affichés",
    "Noms des canaux [Général] et [Commerce] ne sont pas affichés",
    "Noms des canaux [Général], [Commerce], [RechercheGroupe] et [DéfenseLocale] ne sont pas affichés",
    "Cacher tous les noms des canaux",
    "Utiliser les abréviations : G - [Général], C - [Commerce], LFG - [RechercheGroupe]",
    "Utiliser les abréviations et cacher les autres noms de canaux" };

  CLEANCHAT_STATUS4 = "Couleur personnalisée pour %s %s %s%s";
  CLEANCHAT_STATUS5 = { "membres de guilde", "amis", "autres", "membres de groupe", "membre de raid", "noms sans infos de classe", "moi-même" };
  CLEANCHAT_STATUS6 = "Utiliser une couleur aléatoire si un nom ne remplie\n                                   aucuns des critères ci-dessus]"

  -- GUI
  BINDING_NAME_CLEANCHAT_GUI = "Basculer GUI";
  CLEANCHAT_CHECKBOX_PREFIX = "Cacher les préfixes [Groupe], [Raid], [RecurtementdeGuilde] und,\n[Officier] et abréger raid ainsi qu' bataille.";
  CLEANCHAT_CHANNELS_LABEL = "Options canaux :";
  CLEANCHAT_COLORIZE_NICKS = "Coloriser les noms dans les messages de discussions :";
  CLEANCHAT_USE_CLASS_COLORS = "Utiliser le code couleurs par classe (seulemnent Groupe/Raid)";
  CLEANCHAT_USE_CURSORKEYS = "Activer la touche curseur pendant l'écriture d'un message (sans la touche ALT)";
  CLEANCHAT_HIDE_CHATBUTTONS = "Cacher les boutons de la fenêtre de discussion";

  CLEANCHAT_COLLECTDATA = "Autorise l'utilisation de la commande /who";
  CLEANCHAT_SHOWLEVEL = "Affiche le level dans la fenêtre de discussion"
  CLEANCHAT_MOUSEWHEEL = "Utilise la molette pour défiler";
  CLEANCHAT_PERSISTENT = "Enregistrer les infos collectées";
  CLEANCHAT_POPUP = "Afficher le message de discussion sur l'écran si il contient votre nom";
  CLEANCHAT_IGNORE_EMOTES = "Ne pas coloriser les noms pour les emotes";

end