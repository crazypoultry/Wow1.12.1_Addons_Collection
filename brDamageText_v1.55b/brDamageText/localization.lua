--[[ ----------------------- Localization File ----------------------- ]]--
--[[ ----------------------- English & Default ----------------------- ]]--
BRDAMAGETEXT_TOOLTIP_ID = {};
BRDAMAGETEXT_TOOLTIP_ID[1] = "Damage will be displayed in the default TargetFramePortrait";
BRDAMAGETEXT_TOOLTIP_ID[2] = "Damage will be displayed in an small own Frame";
BRDAMAGETEXT_TOOLTIP_ID[3] = "Damage will be displayed in the Perl Classic TargetFramePortrait";
BRDAMAGETEXT_TOOLTIP_ID[4] = "Damage will be displayed in the Nurfed TargetFrame";

BRDAMAGETEXT_TOOLTIP_BORDER = "Check this option to display the border of the own frame";
BRDAMAGETEXT_TOOLTIP_MOVEABLE = "Check this option to enable moving of the small own Frame";
BRDAMAGETEXT_TOOLTIP_DOTS = "Check this option to display Dots";
BRDAMAGETEXT_TOOLTIP_WORDS = "Check this option to display Words like Absorbed, Missed, Parried, etc";
BRDAMAGETEXT_TOOLTIP_FADE = "Check this option to let the damage fade out even when you have no target selected";
BRDAMAGETEXT_TOOLTIP_FONTNAME = "Select the Fontname.";
BRDAMAGETEXT_TOOLTIP_FONTSIZE = "Changes the Fontsize.";

BRDAMAGETEXT_OPTIONS_CAPTION = GetAddOnMetadata("brDamageText", "Title").." Options";
BRDAMAGETEXT_OPTIONS_DISPLAY = "Display";
BRDAMAGETEXT_OPTIONS_BORDER = "show border";
BRDAMAGETEXT_OPTIONS_MOVEABLE = "Frame is moveable"
BRDAMAGETEXT_OPTIONS_DOTS = "show dots";
BRDAMAGETEXT_OPTIONS_WORDS = "show words";
BRDAMAGETEXT_OPTIONS_FADE = "fadeout with no target"
BRDAMAGETEXT_OPTIONS_FONTNAME = "Fontname";
BRDAMAGETEXT_OPTIONS_FONTSIZE = "Fontsize";

BRDAMAGETEXT_SELFTARGET = {};
BRDAMAGETEXT_SELFTARGET = { "you", "your" };

BRDAMAGETEXT_SPELLIGNORE = {};
BRDAMAGETEXT_SPELLIGNORE.IMPROVEDSHADOWBOLT	= "Improved Shadow Bolt";
BRDAMAGETEXT_SPELLIGNORE.WINTERCHILL		= "Winter's Chill";
BRDAMAGETEXT_SPELLIGNORE.SHADOWVULNERABILITY	= "Shadow Vulnerability";

if ( GetLocale() == "deDE" ) then
--[[ ----------------------------- German ---------------------------- ]]--
	BRDAMAGETEXT_TOOLTIP_ID[1] = "Der Schaden wird im standard TargetFramePortrait angezeigt";
	BRDAMAGETEXT_TOOLTIP_ID[2] = "Der Schaden wird in einem eigenem Frame angezeigt";
	BRDAMAGETEXT_TOOLTIP_ID[3] = "Der Schaden wird im Perl Classic TargetFramePortrait angezeigt";
	BRDAMAGETEXT_TOOLTIP_ID[4] = "Der Schaden wird im Nurfed TargetFrame angezeigt";
	
	BRDAMAGETEXT_TOOLTIP_BORDER = "Aktiviere diese Option um den Rahmen des eigenen Frames anzuzeigen";
	BRDAMAGETEXT_TOOLTIP_MOVEABLE = "Aktiviere diese Option um den eigenen Frame beweglich zu machen";
	BRDAMAGETEXT_TOOLTIP_DOTS = "Aktiviere diese Option um Dots anzuzeigen";
	BRDAMAGETEXT_TOOLTIP_WORDS = "Aktiviere diese Option um W\195\182rter, wie z.B. Absorbiert und Verfehlt anzuzeigen";
	BRDAMAGETEXT_TOOLTIP_FADE = "Aktiviere diese Option um den Schaden ausblenden zu lassen, selbst wenn man kein Target mehr selektiert hat";
	BRDAMAGETEXT_TOOLTIP_FONTNAME = "W\195\164hle die Schriftart";
	BRDAMAGETEXT_TOOLTIP_FONTSIZE = "\195\164ndert die Schriftgr\195\182sse";
	
	BRDAMAGETEXT_OPTIONS_CAPTION = GetAddOnMetadata("brDamageText", "Title").." Optionen";
	BRDAMAGETEXT_OPTIONS_DISPLAY = "Anzeige";
	BRDAMAGETEXT_OPTIONS_BORDER = "Zeige Rahmen";
	BRDAMAGETEXT_OPTIONS_MOVEABLE = "Rahmen ist beweglich"
	BRDAMAGETEXT_OPTIONS_DOTS = "Zeige Dots";
	BRDAMAGETEXT_OPTIONS_WORDS = "Zeige W\195\182rter";
	BRDAMAGETEXT_OPTIONS_FADE = "Ausblenden auch ohne Target"
	BRDAMAGETEXT_OPTIONS_FONTNAME = "Schriftart";
	BRDAMAGETEXT_OPTIONS_FONTSIZE = "Schriftgr\195\182sse";

	BRDAMAGETEXT_SELFTARGET = { "euch", "euch ", "euer", "eure", "ihr" };

	BRDAMAGETEXT_SPELLIGNORE.IMPROVEDSHADOWBOLT	= "Verbesserter Schattenblitz";
	BRDAMAGETEXT_SPELLIGNORE.WINTERCHILL		= "Winterk\195\164lte";
	BRDAMAGETEXT_SPELLIGNORE.SHADOWVULNERABILITY	= "Schattenverwundbarkeit";

elseif ( GetLocale() == "frFR" ) then
--[[ ----------------------------- French ---------------------------- ]]--
	BRDAMAGETEXT_SPELLIGNORE.IMPROVEDSHADOWBOLT	= "Trait de l'ombre amélioré";
	BRDAMAGETEXT_SPELLIGNORE.WINTERCHILL		= "Froid hivernal";
	BRDAMAGETEXT_SPELLIGNORE.SHADOWVULNERABILITY	= "Vulnérabilité à l'Ombre";

end