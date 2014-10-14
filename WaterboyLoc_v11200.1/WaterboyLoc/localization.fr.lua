-- Version: French
-- author: Faerian
-- Last Update: 02/10/2006


if ( GetLocale() == "frFR" ) then
	Waterboy.GemsStats = { 	[1] = { name="agate de mana", level=28, mana=530, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[2] = { name="jade de mana", level=38, mana=800, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[3] = { name="citrine de mana", level=48, mana=1130, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[4] = { name="rubis de mana", level=58, mana=1470, present=false, spellid=nil, texture = nil, OnCoolDown = false }}

Waterboy.WaterStats = { ["Rang 1"] = { name="Eau invoqu\195\169e", level=1, mana=151, cost=60 },
						["Rang 2"] = { name="Eau fra\195\174che invoqu\195\169e", level=5, mana=436, cost=105 },
						["Rang 3"] = { name="Eau purifi\195\169e invoqu\195\169e", level=15, mana=835, cost=180 },
						["Rang 4"] = { name="Eau de source invoqu\195\169e", level=25, mana=1344, cost=285 },
						["Rang 5"] = { name="Eau min\195\169rale invoqu\195\169e", level=35, mana=1992, cost=420 },
						["Rang 6"] = { name="Eau p\195\169tillante invoqu\195\169e", level=45, mana=2934, cost=585 },
						["Rang 7"] = { name="Eau cristalline invoqu\195\169e", level=55, mana=4200, cost=780 } }

Waterboy.FoodStats = {  ["Rang 1"] = { name="Muffin invoqu\195\169", level=1, hp=61, cost=60 },
						["Rang 2"] = { name="Pain invoqu\195\169", level=5, hp=243, cost=105 },
						["Rang 3"] = { name="Pain de voyage invoqu\195\169", level=15, hp=552, cost=180 },
						["Rang 4"] = { name="Pain noir invoqu\195\169", level=25, hp=875, cost=285 },
						["Rang 5"] = { name="Pain de route invoqu\195\169", level=35, hp=1392, cost=420 },
						["Rang 6"] = { name="Pain au lait invoqu\195\169", level=45, hp=2148, cost=585 },
						["Rang 7"] = { name="Roul\195\169s \195\160 la cannelle invoqu\195\169s", level=55, hp=3180, cost=705 } }

	
WaterboyOptInfo = {--ONLY CHANGE text AND tooltip!!!! NEVER CHANGE OTHER VARIABLES OR NOTHING WILL WORK ANYMORE
	["WaterboyReset"] = { default=nil, type="Check", opt="Reset", text="Reset apr\195\168s l'\195\169change", tooltip="Si coch\195\169, les slots d\'\195\169change seront vid\195\169s automatiquement apr\195\168s l\'\195\169change." },
	["WaterboyAuto"] =  { default=nil, type="Check", opt="Auto", text="Echange auto", tooltip="Si coch\195\169, les \195\169changes que vous initiez seront automatiquement valid\195\169s" },
	["WaterboyIconPos"] = { default=256, type="Slider", opt="IconPos", text="Bouton de la Minimap", tooltip="Faites glisser pour bouger l\'icone de Waterboy autour de la minimap.", min=0,max=360,step=1 },
	["WaterboyAlpha"] = { default=100, type="Slider", opt="Alpha", text="Transparence", tooltip="Faites glisser pour changer la transparence de la fen\195\168tre principale.", min=10,max=100,step=1 },
	["WaterboyOnScreen"] = { default=nil, type="Check", opt="OnScreen", text="Garder \195\160 l\'\195\169cran", tooltip="Si coch\195\169, la fen\195\168tre sera minimis\195\169e au lieu d\'\195\170tre ferm\195\169e." },
	["WaterboyAnchor"] = { default=nil, type="Check", opt="Anchor", text="Ancrer en bas", tooltip="Si coch\195\169, la fen\195\168tre s\'\195\169tendra vers le haut." },
	["WaterboyShowIcon"] = { default=true, type="Check", opt="ShowIcon", text=" ", tooltip="Si coch\195\169, une icone de Waterboy apparaitra sur le bord de la minimap." },
	["WaterboyScale"] = { default=100, type="Slider", opt="Scale", text="Echelle", tooltip="Faites glisser pour changer la taille de la fen\195\168tre principale.", min=50,max=150,step=10 },
	["WaterboyLock"] = { default=nil, type="Check", opt="Lock", text="Verrouiller la Position", tooltip="Si coch\195\169, la fen\195\168tre principale ne sera pas d\195\169placable." },
	["WaterboyMinimized"] = { default=false, type="Flag", opt="Minimized" },
	["WaterboyDrink"] = { default=nil, type="Check", opt="Drink", text="Clic droit pour boire", tooltip="Si coch\195\169, un clic droit sur l'icone de la minimap vous fera boire et manger au lieu d\'ouvrir l\'\195\169cran des options." },
	["WaterboyGem"] = { default=nil, type="Check", opt="ManaGem", text="Clic droit pour utiliser une gemme", tooltip="Si coch\195\169, un clic droit sur l'icone de la minimap vous fera utiliser la plus haute gemme disponible au lieu d\'ouvrir l\'\195\169cran des options." }
		}
				
WB_CONJUREWATER = "Invocation d\'eau" 
WB_CONJUREFOOD = "Invocation de nourriture" 

WB_CLASS_MAGE = "Mage"

WB_MSG_SLASHCOMMANDS = "Commandes de Waterboy :"
WB_MSG_TOGGLEWINDOW = "Affiche/Cache la fen\195\170tre"
WB_MSG_RESET = "Restaurer les valeurs par defaut"
WB_MSG_TRADE = "Lancer l'\195\169change"
WB_MSG_READY = "Pr\195\170t \195\160 \195\169changer"
WB_MSG_REQLEVEL = "Necessite le niveau "
WB_MSG_RESTORES = "Restaure "
WB_MSG_MANA = " mana"
WB_MSG_HP = " pv"
WB_MSG_CANT = " ne peut pas "
WB_MSG_THIS = " \195\167a"
WB_MSG_CANTTRADE = "Impossible d\'\195\169changer avec : "
WB_MSG_NOTHING = ". Vous n'avez rien \195\160 \195\169changer."
WB_MSG_TOOFAR = ". Trop loin."
WB_MSG_NOTARFET = "<Pas de cible>"

WB_ACTION_EAT = "manger"
WB_ACTION_DRINK = "boire"

WB_BUTTON_TRADE = "Echange"
WB_BUTTON_RESET = "Reset"
WB_BUTTON_DEFAULT = "Defaut"

WB_WB_OPTIONS = "Options de Waterboy"
WB_TOOLTIP_MINIMAP = "Waterboy"

WB_ANCHOR_MOUSEOVER = "Clic gauche pour fermer.\nClic droit pour les options."

WB_HELP_TRADESLOTHEADER = "Slots d\'\195\169change"
WB_HELP_TRADESLOTMSG = "D\195\169placez les objets (ou shift+click) de gauche sur ces slots.  C'est ce que vous donnerez lors de l'\195\169change.\n\nCliquez sur ces slots pour les vider."

BINDING_NAME_WBTRADE = "Echange"
BINDING_NAME_WBTOGGLE = "Affiche/cache Waterboy"

WB_GEM_PATTERN = "Invocation d\'une? (.*)"
WB_GEM_AGATE = "agathe de mana"
WB_GEM_JADE = "jade de mana"
WB_GEM_RUBY = "rubis de mana"
WB_GEM_CITRINE = "citrine de mana"
WB_GEM_READY = "Gemme prete"
end
