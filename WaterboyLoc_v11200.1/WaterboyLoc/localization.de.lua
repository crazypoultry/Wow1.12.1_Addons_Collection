if ( GetLocale() == "deDE" ) then
	
Waterboy.WaterStats = { 		["Rang 1"] = { name="Herbeigezaubertes Wasser", level=1, mana=151, cost=60 },
						["Rang 2"] = { name="Herbeigezaubertes frisches Wasser", level=5, mana=436, cost=105 },
						["Rang 3"] = { name="Herbeigezaubertes gel\195\164utertes Wasser", level=15, mana=835, cost=180 },
						["Rang 4"] = { name="Herbeigezaubertes Quellwasser", level=25, mana=1344, cost=285 },
						["Rang 5"] = { name="Herbeigezaubertes Mineralwasser", level=35, mana=1992, cost=420 },
						["Rang 6"] = { name="Herbeigezaubertes Sprudelwasser", level=45, mana=2934, cost=585 },
						["Rang 7"] = { name="Herbeigezaubertes Kristallwasser", level=55, mana=4200, cost=780 } }

Waterboy.FoodStats = {  		["Rang 1"] = { name="Herbeigezauberter Muffin", level=1, hp=61, cost=60 },
						["Rang 2"] = { name="Herbeigezaubertes Brot", level=5, hp=243, cost=105 },
						["Rang 3"] = { name="Herbeigezaubertes Roggenbrot", level=15, hp=552, cost=180 },
						["Rang 4"] = { name="Herbeigezauberter Pumpernickel", level=25, hp=875, cost=285 },
						["Rang 5"] = { name="Herbeigezauberter Sauerteig", level=35, hp=1392, cost=420 },
						["Rang 6"] = { name="Herbeigezaubertes Milchbr\195\182tchen", level=45, hp=2148, cost=585 },
						["Rang 7"] = { name="Herbeigezauberte Zimtschnecke", level=55, hp=3180, cost=705 } }


Waterboy.GemsStats = { 			[1] = { name="Manaachat", level=28, mana=530, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[2] = { name="Manajadestein", level=38, mana=800, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[3] = { name="Manacitrin", level=48, mana=1130, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[4] = { name="Manarubin", level=58, mana=1470, present=false, spellid=nil, texture = nil, OnCoolDown = false }}

						
WaterboyOptInfo = {--ONLY CHANGE text AND tooltip!!!! NEVER CHANGE OTHER VARIABLES OR NOTHING WILL WORK ANYMORE
	["WaterboyReset"] = { default=nil, type="Check", opt="Reset", text="Reset nach dem Handel", tooltip="Wenn ausgew\195\164hlt werden die Handels Slots nach jedem Handel zur\195\188ckgesetzt." },
	["WaterboyAuto"] =  { default=nil, type="Check", opt="Auto", text="Auto Handel", tooltip="Wenn ausgew\195\164hlt wird versucht, alle von dir angefangenen Handel atomatisch zu akzeptieren." },
	["WaterboyIconPos"] = { default=256, type="Slider", opt="IconPos", text="Minimap Button", tooltip="Dieser Regler \195\164ndert die Position des Minimap Buttons um die Minimap.", min=0,max=360,step=1 },
	["WaterboyAlpha"] = { default=100, type="Slider", opt="Alpha", text="Transparenz", tooltip="Dieser Regler \195\164ndert die Transparenz des Hauptfensters.", min=10,max=100,step=1 },
	["WaterboyOnScreen"] = { default=nil, type="Check", opt="OnScreen", text="Sichtbar bleiben", tooltip="Wenn ausgew\195\164hlt wird das Fenster minimiert anstatt sich zu verstecken." },
	["WaterboyAnchor"] = { default=nil, type="Check", opt="Anchor", text="Am Boden verankern", tooltip="Wenn ausgew\195\164hlt wird das Fenster - falls maximiert- nach oben aufklappen." },
	["WaterboyShowIcon"] = { default=true, type="Check", opt="ShowIcon", text=" ", tooltip="Wenn ausgew\195\164hlt wird ein WaterBoy Icon neben der MiniMap angezeigt." },
	["WaterboyScale"] = { default=100, type="Slider", opt="Scale", text="Skalieren", tooltip="Dieser Regler \195\164ndert die Gr\195\182sse des Hauptfensters.", min=50,max=150,step=10 },
	["WaterboyLock"] = { default=nil, type="Check", opt="Lock", text="Fensterposition sperren", tooltip="Wenn ausgew\195\164hlt kann das Hauptfenster nicht verschoben werden." },
	["WaterboyDrink"] = { default=nil, type="Check", opt="Drink", text="Rechtsklicken zum Trinken", tooltip="Wenn ausgew\195\164hlt l\195\164sst dich ein Rechtsklick auf den Minimap Button essen und trinken, anstatt das Optionsfenster zu \195\182ffnen" },
	["WaterboyGem"] = { default=nil, type="Check", opt="ManaGem", text="Rechtsklick stellt einen Mana-Stein her", tooltip="enn ausgew\195\164hlt l\195\164sst dich ein Rechtsklick auf den Minimap Button den h\195\182chsten Mana-Stein herstellen, anstatt das Optionsfenster zu \195\182ffnen." } 
}

WB_CONJUREWATER = "Wasser herbeizaubern" 
WB_CONJUREFOOD = "Essen herbeizaubern" 

WB_CLASS_MAGE = "Magier"

WB_MSG_SLASHCOMMANDS = "Waterboy Slash-Kommandos:" 
WB_MSG_TOGGLEWINDOW = "Fenster umschalten"
WB_MSG_RESET = "Einstellungen zur\195\188cksetzen"
WB_MSG_TRADE = "Handel wird gestartet"
WB_MSG_READY = "Fertig f\195\188r Ausgabe"
WB_MSG_REQLEVEL = "Ben\195\182tigt Level "
WB_MSG_RESTORES = "Stellt "
WB_MSG_MANA = " Mana wieder her"
WB_MSG_HP = " Gesundheit wieder her"
WB_MSG_CANT = " kann nicht "
WB_MSG_THIS = " dieses"
WB_MSG_CANTTRADE = "Kann nicht handeln mit: "
WB_MSG_NOTHING = ". Du hast nichts zu Geben."
WB_MSG_TOOFAR = ". Zu weit entfernt."
WB_MSG_NOTARFET = "<kein Ziel>"
WB_MSG_SUMMON = "Essen/Wasser herbeizaubern"
WB_MSG_SUMMON2 = "Notiz: /wb make finktioniert nur innerhalb von Makros"
WB_MSG_ENOUGH = "Waterboy: Du hast genug Essen/Wasser um zu Handeln."
WB_MSG_SLOT_LL = "Waterboy: Ziehe die Anzahl des Essens/Wasser in das Handelsfenster zum Herstellen."
WB_MSG_NODRINK = "Waterboy: Nichts zu trinken vorhanden."

WB_ACTION_EAT = "essen"
WB_ACTION_DRINK  ="trinken"

WB_BUTTON_TRADE = "handel"
WB_BUTTON_RESET = "Reset"
WB_BUTTON_DEFAULT = "Standard"
WB_BUTTON_MAKE = "machen"

WB_WB_OPTIONS = "Waterboy Optionen"
WB_TOOLTIP_MINIMAP = "Waterboy Fenster \195\182ffnen"

WB_ANCHOR_MOUSEOVER = "Linksklick zum Schliessen.\nRechtsklick f\195\188r die Optionen."

WB_HELP_TRADESLOTHEADER = "Handels Slots"
WB_HELP_TRADESLOTMSG = "Ziehe (oder shift+Klick) Gegenst\195\164nde links in diese Slots.  Diese Gegenst\195\164nde werden damit zum Handel freigegeben.\n\nZum leeren auf den Slot klicken."

BINDING_NAME_WBTRADE = "Waterboy: handeln"
BINDING_NAME_WBTOGGLE = "Waterboy umschalten"
BINDING_NAME_WBMAKE = "Wasser/Essen herstellen"

WB_GEM_PATTERN = "(.*) herbeizaubern"
WB_GEM_AGATE = "Manaachat"
WB_GEM_JADE = "Manajadestein"
WB_GEM_RUBY = "Manarubin"
WB_GEM_CITRINE = "Manacitrin"
WB_GEM_READY = "Stein fertig"
end
