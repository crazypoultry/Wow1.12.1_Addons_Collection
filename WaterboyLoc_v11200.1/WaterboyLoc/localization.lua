Waterboy.WaterStats = { 		["Rank 1"] = { name="Conjured Water", level=1, mana=151, cost=60 },
						["Rank 2"] = { name="Conjured Fresh Water", level=5, mana=436, cost=105 },
						["Rank 3"] = { name="Conjured Purified Water", level=15, mana=835, cost=180 },
						["Rank 4"] = { name="Conjured Spring Water", level=25, mana=1344, cost=285 },
						["Rank 5"] = { name="Conjured Mineral Water", level=35, mana=1992, cost=420 },
						["Rank 6"] = { name="Conjured Sparkling Water", level=45, mana=2934, cost=585 },
						["Rank 7"] = { name="Conjured Crystal Water", level=55, mana=4200, cost=780 } }

Waterboy.FoodStats = {  		["Rank 1"] = { name="Conjured Muffin", level=1, hp=61,cost=60 },
						["Rank 2"] = { name="Conjured Bread", level=5, hp=243, cost=105 },
						["Rank 3"] = { name="Conjured Rye", level=15, hp=552, cost=180 },
						["Rank 4"] = { name="Conjured Pumpernickel", level=25, hp=875, cost=285 },
						["Rank 5"] = { name="Conjured Sourdough", level=35, hp=1392, cost=420 },
						["Rank 6"] = { name="Conjured Sweet Roll", level=45, hp=2148, cost=585 },
						["Rank 7"] = { name="Conjured Cinnamon Roll", level=55, hp=3180, cost=705 } }

Waterboy.GemsStats = { 			[1] = { name="Mana Agate", level=28, mana=530, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[2] = { name="Mana Jade", level=38, mana=800, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[3] = { name="Mana Citrine", level=48, mana=1130, present=false, spellid=nil, texture = nil, OnCoolDown = false },
						[4] = { name="Mana Ruby", level=58, mana=1470, present=false, spellid=nil, texture = nil, OnCoolDown = false }}

						
WaterboyOptInfo = {--ONLY CHANGE text AND tooltip!!!! NEVER CHANGE OTHER VARIABLES OR NOTHING WILL WORK ANYMORE
	["WaterboyReset"] = { default=nil, type="Check", opt="Reset", text="Reset After Trade", tooltip="When checked, trade slots will be cleared after each trade" },
	["WaterboyAuto"] =  { default=nil, type="Check", opt="Auto", text="Auto Trade", tooltip="When checked, trades initiated by you will attempt to be automatically completed." },
	["WaterboyIconPos"] = { default=256, type="Slider", opt="IconPos", text="Minimap Button", tooltip="Slide this to change the position of the Waterboy icon around the minimap.", min=0,max=360,step=1 },
	["WaterboyAlpha"] = { default=100, type="Slider", opt="Alpha", text="Transparency", tooltip="Slide this to change the transparency of the main window.", min=10,max=100,step=1 },
	["WaterboyOnScreen"] = { default=nil, type="Check", opt="OnScreen", text="Keep On Screen", tooltip="When checked, the window will minimize instead of hiding on ESC or close." },
	["WaterboyAnchor"] = { default=nil, type="Check", opt="Anchor", text="Anchor At Bottom", tooltip="When checked, the window will expand upwards when maximized." },
	["WaterboyShowIcon"] = { default=true, type="Check", opt="ShowIcon", text=" ", tooltip="When checked, a Waterboy icon will show on the edge of the minimap." },
	["WaterboyScale"] = { default=100, type="Slider", opt="Scale", text="Scale", tooltip="Slide this to change the scaling of the main window.", min=50,max=150,step=10 },
	["WaterboyLock"] = { default=nil, type="Check", opt="Lock", text="Lock Window Position", tooltip="When checked, the main window will not be movable." },
	["WaterboyMinimized"] = { default=false, type="Flag", opt="Minimized" },
	["WaterboyDrink"] = { default=nil, type="Check", opt="Drink", text="Right click to drink", tooltip="When checked, a right-click on the minimap icon will make you drink and eat instead of open the option panel." },
	["WaterboyGem"] = { default=nil, type="Check", opt="ManaGem", text="Right click to use a gem", tooltip="When checked, a right-click on the minimap icon will make you use the highest gem avalaible  instead of open the option panel." }
	}

WB_CONJUREWATER = "Conjure Water" 
WB_CONJUREFOOD = "Conjure Food" 

WB_CLASS_MAGE = "Mage"

WB_MSG_SLASHCOMMANDS = "Waterboy slash commands:"
WB_MSG_TOGGLEWINDOW = "toggle window"
WB_MSG_RESET = "reset defaults"
WB_MSG_TRADE = "initiate trade"
WB_MSG_READY = "Ready to Serve"
WB_MSG_REQLEVEL = "Requires level "
WB_MSG_RESTORES = "Restores "
WB_MSG_MANA = " mana"
WB_MSG_HP = " hp"
WB_MSG_CANT = " can't "
WB_MSG_THIS = " this"
WB_MSG_CANTTRADE = "Can't trade with "
WB_MSG_NOTHING = ". You have nothing to give."
WB_MSG_TOOFAR = ". Too far away."
WB_MSG_NOTARFET = "<no target>"
WB_MSG_SUMMON = "summon food/water"
WB_MSG_SUMMON2 = "note: /wb make must be within a macro to work"
WB_MSG_ENOUGH = "Waterboy: You have sufficient food/water to make a trade."
WB_MSG_SLOT_LL = "Waterboy: Drag food/water to the trade slots to set up what to summon."
WB_MSG_NODRINK = "Waterboy: Nothing to drink."

WB_ACTION_EAT = "eat"
WB_ACTION_DRINK = "drink"

WB_BUTTON_TRADE = "Trade"
WB_BUTTON_RESET = "reset"
WB_BUTTON_DEFAULT = "Default"
WB_BUTTON_MAKE = "Make"

WB_WB_OPTIONS = "Waterboy Options"
WB_TOOLTIP_MINIMAP = "Open Waterboy Window"

WB_ANCHOR_MOUSEOVER = "Left-click to close.\nRight-click for options."

WB_HELP_TRADESLOTHEADER = "Trade Slots"
WB_HELP_TRADESLOTMSG = "Drag (or shift+click) items to the left onto these slots.  These will be the items you give in the trade.\n\nClick these slots to clear them."

BINDING_NAME_WBTRADE = "Waterboy Trade"
BINDING_NAME_WBTOGGLE = "Toggle Waterboy"
BINDING_NAME_WBMAKE = "Make Food/Water"

WB_GEM_PATTERN = "Conjure (.*)"
WB_GEM_AGATE = "Mana Agate"
WB_GEM_JADE = "Mana Jade"
WB_GEM_RUBY = "Mana Ruby"
WB_GEM_CITRINE = "Mana Citrine"
WB_GEM_READY = "Gem Ready"
