-- All round strings
IOM_STRING_TITLE = "InviteOMatic";

if ( GetLocale() == "deDE" ) then
    -- German Localization
    IOM_STRING_LOADED = "Geladen";
    IOM_STRING_DEBUG = "Fehleranalyse";
    IOM_STRING_INVITESPAM = "Bitte verlasst eure bestehenden Gruppen, es besteht bereits eine Schlachtgruppe, oder befördert mich wenigstens, damit ich helfen kann, miteinzuladen =)";
    IOM_STRING_AIGSPAM = "Da du bereits einer Gruppe angehörst, kannst du nicht automatisch in die Schlachtgruppe geladen werden. Wenn du der Schlachtgruppe beitreten möchtest, verlasse bitte deine bestehende Gruppe und sende mir eine Antwort mit dem Wort: invite";
    IOM_STRING_ADDON_DISABLED = "Addon ist deaktiviert, aktiviere es mit: /iom enable";
    IOM_STRING_DISABLED = "Deaktiviert";
    IOM_STRING_ENABLED = "Aktiviert";
    IOM_STRING_UNKNOWN_OPTION = "Unbekannte Option:";
    IOM_STRING_PANIC = "panische Auflösung der Gruppe, und Deaktivierung des automatischen Einladens";
else
    --English Localization
    IOM_STRING_LOADED = "Loaded";
    IOM_STRING_DEBUG = "Debug";
    IOM_STRING_INVITESPAM = "Please leave your groups, i have the raid group, (Or at least Promote me so i can help invite =)";
    IOM_STRING_AIGSPAM = "Since you appear to already be grouped you could not be auto-invited to the raid. If you want to join the raid, please leave your group and send me a whisper with the word: invite";
    IOM_STRING_ADDON_DISABLED = "Addon is disabled, enable with: /iom enable";
    IOM_STRING_DISABLED = "Disabled";
    IOM_STRING_ENABLED = "Enabled";
    IOM_STRING_UNKNOWN_OPTION = "Unknown option:";
    IOM_STRING_PANIC = "Panic disbanding group, and disabling autoinvite";
end