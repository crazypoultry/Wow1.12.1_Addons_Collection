-- This statement will load any translation that is present or default to English.
function KC_AutoRepair_Locals_deDE()
	local locals = KC_AUTOREPAIR_LOCALS;

	locals.name = "KC_AutoRepair"
	locals.desc = "Ein kleines Addon zur Erinnerung an anf\195\164llige Reparaturen."

	locals.on = "An"
	locals.off = "Aus"

	locals.prompt = {};
	locals.prompt.title = "KC_AutoRepair Prompt"
	locals.prompt.both = "Beide"
	locals.prompt.inventory = "Inventar"
	locals.prompt.equipment = "Ausr\195\188stung"
	locals.prompt.line1 = "Reparaturkosten Eures Inventars:"
	locals.prompt.line2 = "Reparaturkosten Eurer Ausr\195\188stung:"
	locals.prompt.line3 = "Reparaturkosten f\195\188r beides:"

	locals.config = {};
	locals.config.title = "KC_AutoRepair Config"
	locals.config.prompt = "Prompt"
	locals.config.verbose = "Verbose"
	locals.config.skipinv = "SkipInv"
	locals.config.mincost = "MinCost"
	locals.config.threshold = "Threshold"
	locals.config.set = "Set"

	locals.config.tips = {};
	locals.config.tips.prompt1 = "Prompt Hilfe"
	locals.config.tips.prompt2 = "De-/Aktiviert Anzeige des Best\195\164tigungs-Dialogs."
	locals.config.tips.skipinv1 = "SkipInv Hilfe"
	locals.config.tips.skipinv2 = "De-/Aktiviert automatische Reparatur Eures Inventars."
	locals.config.tips.verbose1 = "Verbose Hilfe"
	locals.config.tips.verbose2 = "De-/Aktiviert Anzeige langer Dialoge."
	locals.config.tips.threshold1 = "Threshold Hilfe"
	locals.config.tips.threshold2 = "Setzt den Grenzbetrag, der in den Feldern links angezeigt wird."
	locals.config.tips.threshold3 = "Muss geklickt werden, um den Effekt zu erzielen."
	locals.config.tips.mincost1 = "MinCost Hilfe"
	locals.config.tips.mincost2 = "Setzt den Mindestbetrag, der in den Feldern links angezeigt wird."
	locals.config.tips.mincost3 = "Muss geklickt werden, um den Effekt zu erzielen."

	locals.colors = {};
	locals.colors.silver = "Silber";
	locals.colors.copper = "Kupfer";
	locals.colors.gold = "Gold";

	locals.errors = {};
	locals.errors.noamt = "Kein Betrag eingegeben";
	locals.errors.notcopper = "|cffff6633Wert muss numerisch sein (Einheit: Kupfer)."
	locals.errors.noacegui = "|cffff6633Du musst AceGUI installiert haben, um dieses Feature nutzen zu k\195\182nnen."

	locals.msgs = {};
	locals.msgs.both = "|cfff5f530Eure gesamten Reparaturkosten betrugen [%s|cfff5f530]."
	locals.msgs.inventory = "|cfff5f530Die Reparaturkosten Eures Inventars betrugen [%s|cfff5f530]."
	locals.msgs.equipment = "|cfff5f530Die Reparaturkosten Eurer Ausr\195\188stung betrugen [%s|cfff5f530]."


	locals.chat = {};
	locals.chat.togmsg = "|cfff5f530Du hast [|cff66ff33%s|cfff5f530] auf [|cff66ff33%s|cfff5f530] gesetzt."
	locals.chat.commands = {"/kcar", "/ar", "/KC_AutoRepair", "/AutoRepair"}
	locals.chat.options = {
		{
			option = "prompt", -- Don't Localize
			desc = "De-/Aktiviert Anzeige des Best\195\164tigungs-Dialogs.",
			method = "TogPrompt", -- Don't Localize
		},
		{
			option = "skipinv", -- Don't Localize
			desc = "De-/Aktiviert automatische Reparatur Eures Inventars.",
			method = "TogSkipinv", -- Don't Localize
		},
		{
			option = "verbose", -- Don't Localize
			desc = "De-/Aktiviert Anzeige langer Dialoge.",
			method = "TogVerbose", -- Don't Localize
		},
		{
			option = "mincost", -- Don't Localize
			desc = "Setzt den Mindestbetrag (Einheit: Kupfer).",
			method = "SetMinCost", -- Don't Localize
			input = TRUE, -- Don't Localize
		},
		{
			option = "threshold", -- Don't Localize
			desc = "Setzt den Grenzbetrag (Einheit: Kupfer).",
			method = "SetThreshold", -- Don't Localize
			input = TRUE, -- Don't Localize
		},
		{
			option = "report",
			desc = "Zeigt die aktuellen Einstellungen an.",
			method = "Report", -- Don't Localize
		},
		{
			option = "config",
			desc = "\195\150ffnet das Konfigurationsfenster.",
			method = "TogConfig", -- Don't Localize
		}
	}
end