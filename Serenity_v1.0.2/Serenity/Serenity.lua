-----------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Nethaera on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 08.16.2006
------------------------------------------------------------------------------------------------------

-- Default Configuations
-- In case configuations are lost or version is changed
Default_SerenityConfig = {
	Version = SerenityData.Version;       	-- The version from Localization.lua
	ProvisionContainer = 4;                 -- Where food/water is stored.  furthest bag on the keft
	ProvisionSort = true;                   -- Sort food and drink
	ProvisionDestroy = false;               -- Destroy Excess food and dirnk
	ConcentrationAlert = true;				-- Unused
	ShowSpellTimers = false;					-- Show spell timers
	ShowSpellTimerButton = true;           -- Hidden anchor
	ShowCooldowns = true;
	ShowDurations = true;
	ShowShackleUndead = true;
	ShowSpellEffects = true;
	HPLimit = 85;							-- Eat food when under this amount
	MPLimit = 100;							-- Drink water when under this amount
	Button = 4;								-- Main button function.  1 = eat/drink, 2 = Evocation, 3 = ShackleUndead
	Circle = 2;								-- Outside circle display.  0 = None 1 = HP, 2 = Mana, 3 = Potion Cooldown
	PotionOrder = 2;         			-- 1 Weakest Potion first  2 Greatest Potion first
	ButtonText = true;						-- Show item count on buttons
	PotionCountText = true;						-- Show food count
	DrinkCountText = true;						-- Show drink count
	HolyCandleCountText = false;                     -- Show arcane powder count
	FeatherCountText = true;                    -- Show light feather count
	SacredCandleCountText = false;                       -- Show Sacred candle count on buttons
	PotionCooldownText = true;               -- Show Potion cooldown
	SpellButtonText = false;               -- Show evocation cooldown
	SerenityLockServ = true;
	SerenityAngle = 216;      --          \/          \/
	StonePosition = {true, true, true, true, true, true, true, true, true};
	StoneLocation = {	
	"SerenityDrinkButton",
	"SerenityPotionButton",
	"SerenityDispelButton",
	"SerenityLeftSpellButton",
	"SerenityMiddleSpellButton",
	"SerenityRightSpellButton",
	"SerenityBuffMenuButton",
	"SerenityMountButton",
	"SerenitySpellMenuButton",	
	};
	SerenityToolTip = true;
	LeftSpell = 10;
	MiddleSpell = 4;
	RightSpell = 13;
	NoDragAll = false;
	SpellMenuPos = 34;
	SpellMenuAnchor = -6;
	BuffMenuPos = 34;
	BuffMenuAnchor = 20;
	ChatMsg = true;
	ChatType = true;
	SerenityLanguage = GetLocale();
	ShowCount = true;
	CountType = 5;                  -- Inside sphere display.  0 = None, 1 = Drink, 2 = Potion count, 3 = Health, 4 = Health%, 5 = Mana, 6 = Mana%, 7 = Potion Cooldown
	ConcentrationScale = 100;
	SerenityButtonScale = 110;
	SerenityStoneScale = 110;
	SerenityColor = "Aqua";
	Sound = true;
	SpellTimerPos = 1;
	SpellTimerJust = "LEFT";
	Potion = 1;                       -- I dont remember what this is
	Graphical = true;
	Yellow = true;
	SensListe = 1;
	SM = false;                         -- Short message
	QuickBuff = false;
	ShackleScale = 100;
	ShackleWarn = true;
	ShackleBreak = true;
	ShackleWarnTime = 7;
	ShackleMessage = true;
	ResMessage = true;			-- <> Use to be Spell Message.  
	TeleportMessage = true;	-- <> Not used in Serenity
	SteedMessage = false;
	CooldownTimers = true;
	CombatTimers = true;
	Restock	= true;					-- Ask me if I want to restock.  If false, don't restock at all 
	RestockConfirm = true;			-- Don't bother asking, just restock
	RestockHolyCandle = 0;			-- Restock to 10 Rune of Teleportation
	RestockSacredCandle = 0;			-- Restock to 10 Rune of Spells
	Skin = 1;
	AutoSkin = 1;
};

SerenityConfig = {};
local Debug = false;
Serenity_Loaded = false;

-- Detect installation of mod
local SerenityRL = true;

-- Initialization of the variables used by Serenity for spells
local SpellCastName = nil;
local SpellCastRank = nil;
local SpellTargetName = nil;
local SpellTargetLevel = nil;
local SpellCastTime = 0;
local FocusFade = false;
local Shadowform = false;
local LightwellCharges = 5;
local FiveSec = 0;
local FiveSecBackup = 0;
-- Initialization of the tables to manage timers
-- One for spell timers, one for mob groups, and the last allows the association of a timer and graphic frame
-- Le dernier permet l'association d'un timer à une frame graphique
SpellTimer = {};
local SpellGroup = {
	Name = {"Rez", "Main", "Cooldown"},
	SubName = {" ", " ", " "},
	Visible = {true, true, true}
};

local TimerTable = {};
for i = 1, 50, 1 do
	TimerTable[i] = false;
end
SerenityPrivate = {
	-- Menus: Shows buff and Spell
	SpellShow = false;
	SpellMenuShow = false;
	BuffShow = false;
	BuffMenuShow = false;

	-- Menus: Allows the progressive disappearance of the Spell menu (transparency) 
	AlphaSpellMenu = 1;
	AlphaSpellVar = 0;
	SpellVisible = false;

	-- Menus: Allows the progressive disappearance of the buff menu (transparency) 
	AlphaBuffMenu = 1;
	AlphaBuffVar = 0;
	BuffVisible = false;

	-- Menus : Allows recasting of the last spell by middle clicking
	LastSpell = 0;
	LastBuff = 0;
	ResMess = nil;
	-- For ShackleUndead alerts
	ShackleTarget = nil;
	ShackleWarning = false;
	ShackleWarnTime = 0;
	ShackleMess = nil;
	ShackleBreakTime = 0;
	
	-- Cooldown vars
	PotionCooldown = 0;
	PotionCooldownText = "";

	-- Message vars
	ResMess = 0;
	SteedMess = 0;
	RezMess = 0;
	TPMess = 0;
	-- Other vars
	Sitting = false;
	checkInv = true;
 	LoadCheck = true;
 	AQ = false;
 	ChatSilence = false;
};
local debuff = {
	-- Shadow Vulnerability
	shadowCount = 0;
	shadowDuration = 0;
	shadowChance = 1.00;
	shadowApplied = 0;
	-- ShackleUndead Diminishing returns
	drTarget = nil;
	drApplied = 0;
	drDuration = 15;
	drPlayer = false;
	drReset = 0;
};

-- List Buttons available for the mage in each menu
local SpellMenuCreate = {};
local BuffMenuCreate = {};

-- Variable uses to manage mounting
Mount = {
 	Name = "none";
	Title = "none";
	Icon = 0;
	Location = {nil, nil};
	Available = false;
	AQChecked = false;
	Checked = false;
	AQMount = false;
}
local PlayerCombat = false;


-- Variables used for arcane concentration
local Concentration = false;
--local AntiFearInUse = false;				-- Disabled... Haven't found a use yet 
local ConcentrationID = -1;

-- Variables used for provision management
-- (mainly counting)
local Provision = 0;
local ProvisionContainer = 4;
local ProvisionSlot = {};
-- local ProvisionID = 1;
local ProvisionMP = 0;
local ProvisionTime = 0;
local FiveSecTime = 0;

-- Variable uses for spellcasting
-- (mainly counting)
SerenityRacialID = 0;
local Count = {
	HolyCandle = 0;
	SacredCandle = 0;
	LightFeather = 0;					
	ManaPotion = 0;
	HealingPotion = 0;
	Drink = 0;
	PotionLastRank = nil;
	PotionLastName = "none";
	DrinkLastRank = nil;
	DrinkLastName = "none";
}
local start = 0;
local duration = 0;
local ManaSpell = { };
local ManaID = { };
-- Variables used for the Spell button mangement and use of the reagents
local Skin = {
	[1] = "Holy",
	[2] = "Shadow",
	[3] = "Bleu",
	[4] = "Turquoise",
}
function Serenity_PotionDefault()
Potion = {
	-- Mana Potion
	[1] = {
		["Name"] = "Mana Potion";
		["Level"] = 0;
		["EnergyMin"] = 0;
		["EnergyMax"] = 0;
		["PvP"] = false;
		["OnHand"] = false;
		["Location"] = {nil, nil};
		["Mode"] = 1;		
		["RankID"] = 0;    
	},
	-- Healing Potion
	[2] = {
		["Name"] = "Healing Potion";
		["Level"] = 0;
		["EnergyMin"] = 0;
		["EnergyMax"] = 0;
		["PvP"] = false;
		["OnHand"] = false;
		["Location"] = {nil, nil};
		["Mode"] = 1;		
		["RankID"] = 0;    
	},
	-- Drinks
	[3] = {
		["Name"] = "Drink";
		["Level"] = 0;
		["Energy"] = 0;
		["Length"] = 0;
		["Conjured"] = false;
		["OnHand"] = false;
		["Location"] = {nil, nil};
		["Mode"] = 1;		
		["RankID"] = 0;    
	},
};
end
Serenity_PotionDefault();
local StoneMaxRank = {0, 0, 0, 0};
local PotionLocation = {nil,nil};
local DrinkLocation = {nil,nil};
local HearthstoneOnHand = false;
local HearthstoneLocation = {nil,nil};

-- Variables used for trading
local SerenityTradeRequest = false;
local Trading = false;
local TradingNow = 0;

-- Additional variables moved here to try to reduce garbage
local curTime = GetTime();
local timerDisplay = "";
local update = false;
local frameName;
local frameItem;
local Sphere = {
 	["display"] = "",
	["color"] = 0,
	["texture"] = 0,
};
SerenityButtonTexture = { 
	["Skin"] = 0,
	["Text"] = "",
	["Circle"] = 0,
	["Stones"] = { 
		["Base"] = { },
		["Highlight"] = { },
		["Text"] = { },
		["Other"] = { },
	},
	["Spellmenu"] = { 
		["Base"] = { },
		["Highlight"] = { },
		["Other"] = { },
		},
	["Buffmenu"] = { 
		["Base"] = { },
		["Highlight"] = { },
		["Other"] = { },
	},
};
for i=1, 10, 1 do
	SerenityButtonTexture.Stones.Base[i] = 0
	SerenityButtonTexture.Stones.Highlight[i] = 0
	SerenityButtonTexture.Stones.Other[i] = 0
end
for i=1, 8, 1 do
	SerenityButtonTexture.Spellmenu.Base[i] = 0
	SerenityButtonTexture.Spellmenu.Highlight[i] = 0
	SerenityButtonTexture.Spellmenu.Other[i] = 0
end
for i=1, 13, 1 do
	SerenityButtonTexture.Buffmenu.Base[i] = 0
	SerenityButtonTexture.Buffmenu.Highlight[i] = 0
	SerenityButtonTexture.Buffmenu.Other[i] = 0
end
local SortActif;
-- Texture Information for SerenityReordering organization
Serenity_SerenityReorderTexture = { };
-- Management of the tooltips Serenity allows (without the money frame)
local Original_GameTooltip_ClearMoney;
local Serenity_In = true;

------------------------------------------------------------------------------------------------------
-- FUNCTIONS SERENITY APPLIES WHEN YOU LOG IN
------------------------------------------------------------------------------------------------------


-- Function applied to login
function Serenity_OnLoad()
	-- Allows to locate spells? (Permet de repérer les sorts lancés)
	Serenity_Hook("UseAction", "Serenity_UseAction", "before");
	Serenity_Hook("CastSpell", "Serenity_CastSpell", "before");
	Serenity_Hook("CastSpellByName", "Serenity_CastSpellByName", "before");
	
	-- Recording events intercepted by Serenity
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	SerenityButton:RegisterEvent("BAG_UPDATE");
	SerenityButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	SerenityButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	SerenityButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	SerenityButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	SerenityButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	SerenityButton:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	SerenityButton:RegisterEvent("PLAYER_REGEN_DISABLED");
	SerenityButton:RegisterEvent("PLAYER_REGEN_ENABLED");
	SerenityButton:RegisterEvent("MERCHANT_SHOW");
	SerenityButton:RegisterEvent("MERCHANT_CLOSED");
	SerenityButton:RegisterEvent("SPELLCAST_START");
	SerenityButton:RegisterEvent("SPELLCAST_FAILED");
	SerenityButton:RegisterEvent("SPELLCAST_INTERRUPTED");
	SerenityButton:RegisterEvent("SPELLCAST_STOP");
	SerenityButton:RegisterEvent("LEARNED_SPELL_IN_TAB");
	SerenityButton:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	SerenityButton:RegisterEvent("PLAYER_TARGET_CHANGED");
	SerenityButton:RegisterEvent("TRADE_REQUEST");
	SerenityButton:RegisterEvent("TRADE_REQUEST_CANCEL");
	SerenityButton:RegisterEvent("TRADE_SHOW");
	SerenityButton:RegisterEvent("TRADE_CLOSED");
	SerenityButton:RegisterEvent("VARIABLES_LOADED");
	SerenityButton:RegisterEvent("PLAYER_LOGIN");
	SerenityButton:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	
	-- Recording of the graphic components 
	SerenityButton:RegisterForDrag("LeftButton");
	SerenityButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	SerenityButton:SetFrameLevel(1);

	-- recording console commands
	SlashCmdList["SerenityCommand"] = Serenity_SlashHandler;
	SLASH_SerenityCommand1 = "/seren";
	SLASH_SerenityCommand2 = "/serenity";

end


-- Function applied once parameters of the mods charged 
function Serenity_LoadVariables()
	if Serenity_Loaded or UnitClass("player") ~= SERENITY_UNIT_PRIEST then
		return
	end
	Serenity_Initialize();
	Serenity_Loaded = true ;
end

------------------------------------------------------------------------------------------------------
-- SERENITY FUNCTIONS
------------------------------------------------------------------------------------------------------

-- Function launched to the update of the interface (main) -- every 0.1 seconds 
function Serenity_OnUpdate()
	-- The function is used only if Serenity is initialized and the player is a mage
	if (not Serenity_Loaded) and UnitClass("player") ~= SERENITY_UNIT_PRIEST then
		return;
	end
	-- Only used if loaded and player is not a mage --

	
	-- Check inventory after loading screen
	if SerenityPrivate.LoadCheck then
	    Serenity_BagExplore();
		Serenity_SpellSetup();
	    SerenityPrivate.LoadCheck = false;
 	end
	-- Management of Provisions: Sorting every second
	curTime = GetTime();
	if FiveSec > 0 and curTime - FiveSecTime > 5/16 then
		FiveSecTime = curTime;
		FiveSec = FiveSec - 5/16;
	end
	if ((curTime-ProvisionTime) >= 1) then
		-- Adjust timers
		ProvisionTime = curTime;		
		if SerenityPrivate.ShackleWarning == true then 
			SerenityPrivate.ShackleWarnTime = SerenityPrivate.ShackleWarnTime - 1;
		end
		if SerenityConfig.ShackleBreak and SerenityPrivate.ShackleBreakTime >= 0 then
			SerenityPrivate.ShackleBreakTime = SerenityPrivate.ShackleBreakTime -1;
			if SerenityPrivate.ShackleBreakTime <= 0 then SerenityPrivate.ShackleTarget = nil;  end
		end
		if SerenityPrivate.PotionCooldown > 0 then
			SerenityPrivate.PotionCooldown = SerenityPrivate.PotionCooldown - 1;
			SerenityPrivate.PotionCooldownText = Serenity_TimerFunction(SerenityPrivate.PotionCooldown);
		elseif SerenityPrivate.PotionCooldown <= 0 then
			SerenityPrivate.PotionCooldown = 0;
		    SerenityPrivate.PotionCooldownText = "";
		end
	end
	-- Management of ShackleUndead stuff
	Serenity_ShackleCheck("warn");
	Shadowform = Serenity_UnitHasBuff("player",SERENITY_SPELL_TABLE[53].Name);
--	if curTime >= debuff.drReset and debuff.drPlayer then
--		debuff.drTarget = nil;
--		debuff.drApplied = 0;
--		debuff.drDuration = 15;
--		debuff.drPlayer = false;
--		debuff.drReset = 0;
--		SpellCastName = SERENITY_SPELL_TABLE[67].Name;
--		SpellTargetName = creatureName;
--		Serenity_SpellManagement();
--	end
	----------------------------------------------------------
	-- Management of mage spells
	----------------------------------------------------------
	
	-- Management of Spell menu
	if SerenityPrivate.SpellShow then
		Serenity_UpdateSpellMenuIcons();	
		if GetTime() >= SerenityPrivate.AlphaSpellVar and SerenityPrivate.AlphaSpellMenu > 0 and (not SerenityPrivate.SpellVisible) then
			SerenityPrivate.AlphaSpellVar = GetTime() + 0.1;
			SerenitySpellMenu1:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenitySpellMenu2:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenitySpellMenu3:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenitySpellMenu4:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenitySpellMenu5:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenitySpellMenu6:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenitySpellMenu7:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenitySpellMenu8:SetAlpha(SerenityPrivate.AlphaSpellMenu);
			SerenityPrivate.AlphaSpellMenu = SerenityPrivate.AlphaSpellMenu - 0.1;
		end
		if SerenityPrivate.AlphaSpellMenu <= 0.0 then
			Serenity_SpellMenu();
		end
	end

	-- Management of buff menu
	if SerenityPrivate.BuffShow then
		Serenity_UpdateBuffMenuIcons();
		if GetTime() >= SerenityPrivate.AlphaBuffVar and SerenityPrivate.AlphaBuffMenu > 0 and (not SerenityPrivate.BuffVisible) then
			SerenityPrivate.AlphaBuffVar = GetTime() + 0.1;
			SerenityBuffMenu1:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu2:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu3:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu4:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu5:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu6:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu7:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu8:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu9:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu10:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu11:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu12:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityBuffMenu13:SetAlpha(SerenityPrivate.AlphaBuffMenu);
			SerenityPrivate.AlphaBuffMenu = SerenityPrivate.AlphaBuffMenu - 0.1;
		end
		if SerenityPrivate.AlphaBuffMenu <= 0.0 then
			Serenity_BuffMenu();
		end
	end
	
	-- Management of spell timers
	if SerenityConfig.ShowSpellTimerButton and (not SerenitySpellTimerButton:IsVisible()) then
		ShowUIPanel(SerenitySpellTimerButton);
	elseif not SerenityConfig.ShowSpellTimerButton and SerenitySpellTimerButton:IsVisible() then
		HideUIPanel(SerenitySpellTimerButton);
	end
	timerDisplay = "";
	update = false;
	if ((curTime - SpellCastTime) >= 1) then
		SpellCastTime = curTime;
		update = true;
	end
	
	-- updates buttons every second
	-- accepts the trade if transfer is in progress
	-- Parcours du tableau des Timers
	if SerenityConfig.ShowSpellTimers then
		local GraphicalTimer = {texte = {}, TimeMax = {}, Time = {}, titre = {}, temps = {}, Gtimer = {}};
		if SpellTimer[1] ~= nil then		
			for index = 1, table.getn(SpellTimer), 1 do
				if SpellTimer[index] ~= nil then
					if (GetTime() <= SpellTimer[index].TimeMax) then
						-- Crê¢´ion de l'affichage des timers
						timerDisplay, SpellGroup, GraphicalTimer, TimerTable = Serenity_DisplayTimer(timerDisplay, index, SpellGroup, SpellTimer, GraphicalTimer, TimerTable);
					end
					-- Action every second
					if (update) then
						-- Finished timers are removed
						curTime = GetTime();
						if curTime >= (SpellTimer[index].TimeMax - 0.5) and SpellTimer[index].TimeMax ~= -1 then
							SpellTimer, TimerTable = Serenity_RetraitTimerParIndex(index, SpellTimer, TimerTable);
							index = 0;
							break;
						end
						-- If the target of the spell is not reached (resists)
						if SpellTimer and (SpellTimer[index].Type == 4 or SpellTimer[index].Type == 5)
							and SpellTimer[index].Target == UnitName("target")
							then
							-- On triche pour laisser le temps au mob de bien sentir qu'il est dê£µffé¡ž^
							-- Cheats by leaving timer on mob to detect that it is debuffed
							if curTime >= ((SpellTimer[index].TimeMax - SpellTimer[index].Time) + 1.5)
								and SpellTimer[index] ~= 6 then
								if not Serenity_UnitHasEffect("target", SpellTimer[index].Name) and 
									not Serenity_UnitHasBuff("target", SpellTimer[index].Name) then
									SpellTimer, TimerTable = Serenity_RetraitTimerParIndex(index, SpellTimer, TimerTable);
									index = 0;
									break;
								end
							end
						end
					end
				end
			end
		else
			for i = 1, 10, 1 do
				if getglobal("SerenityTarget"..i.."Text"):IsShown() then
					getglobal("SerenityTarget"..i.."Text"):Hide();
				end
			end
		end

		if SerenityConfig.ShowSpellTimers and SerenityConfig.Graphical then
			-- If posting text timers
			if not SerenityConfig.Graphical then
				-- Coloration de l'affichage des timers
				timerDisplay = Serenity_MsgAddColor(timerDisplay);
				-- Posting the timers
				SerenityListSpells:SetText(timerDisplay);
			else
				SerenityListSpells:SetText("");			
			end
			for i = 4, table.getn(SpellGroup.Name) do
				SpellGroup.Visible[i] = false;
			end
		else
			if (SerenitySpellTimerButton:IsVisible()) then
				SerenityListSpells:SetText("");
				HideUIPanel(SerenitySpellTimerButton);
			end
		end
	end

	Serenity_UpdateIcons();
end

-- Functions lauched according to the intercepted events
function Serenity_OnEvent(event)
	if (event == "PLAYER_LOGIN") then
		Serenity_LoadVariables();
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		Serenity_In = true;
		SerenityPrivate.LoadCheck = true;
	elseif (event == "PLAYER_LEAVING_WORLD") then
		Serenity_In = false;
		SerenityPrivate.LoadCheck = false;
	end
	-- Traditional test:  Is the player a mage?
	-- did the mod load?
	if (not Serenity_Loaded) or (not Serenity_In) or UnitClass("player") ~= SERENITY_UNIT_PRIEST then
		return;
	end

	-- If bag concents changed, checks to make sure provisions are in the selected bag
	if (event == "BAG_UPDATE") then
		if not SerenityPrivate.LoadCheck then
			Serenity_BagExplore();
		end
	-- Management of the end of spellcasting
	elseif (event == "SPELLCAST_FAILED") or (event == "SPELLCAST_INTERRUPTED") then
		FiveSec = 0;
		SpellCastName = nil;
		SpellCastRank = nil;
		SpellTargetName = nil;
		SpellTargetLevel = nil;
	elseif (event == "SPELLCAST_STOP") then
		FiveSecBackup = FiveSec;
		FiveSec = 5;
		Serenity_ShackleCheck("stop",SpellCastName,SpellTargetName);
		-- See if it is a racial spell that has a cooldown
		if SpellCastName == SERENITY_SPELL_TABLE[9].Name or
			SpellCastName == SERENITY_SPELL_TABLE[11].Name or
			SpellCastName == SERENITY_SPELL_TABLE[12].Name or
			SpellCastName == SERENITY_SPELL_TABLE[54].Name then
			RacialUp = false;		
		-- Check if it is fade for cooldown purposes
		elseif SpellCastName == SERENITY_SPELL_TABLE[10].Name then
			FadeUp = false;
		-- Check if it is scream
		elseif SpellCastName == SERENITY_SPELL_TABLE[45].Name then
			ScreamUp = false;
		end
		-- Special Double timer effects
		------------------------------------
		-- Power Word: Shield and Weakened Soul
		if SpellCastName == SERENITY_SPELL_TABLE[39].Name then
			Serenity_SpellManagement();
			SpellCastName = SERENITY_SPELL_TABLE[61].Name
			SpellCastTarget = UnitName("target");
			SpellCastLevel = UnitLevel("target");
		-- Lightwell adjusted to show charges
		elseif SpellCastName == SERENITY_SPELL_TABLE[24].Name then
			LightwellCharges = 5;
			SpellCastName = SERENITY_SPELL_TABLE[29].Name
			LightwellUp = false;
		--- Vampiric Embrace Cooldown added in
		elseif SpellCastName == SERENITY_SPELL_TABLE[60].Name then
			Serenity_SpellManagement()
			SpellCastName = SERENITY_SPELL_TABLE[69].Name
			SpellTargetName = UnitName("target");
			SpellTargetLevel = UnitLevel("target");
		-- Devouring Plague Cooldown added in
		elseif SpellCastName == SERENITY_SPELL_TABLE[5].Name then
			Serenity_SpellManagement()
			SpellCastName = SERENITY_SPELL_TABLE[6].Name
			SpellTargetName = UnitName("target");
			SpellTargetLevel = UnitLevel("target");
		end
		--- DO IT!
		--------------------------------------
		if SpellCastName ~= SERENITY_SPELL_TABLE[59].Name then -- Not Touch of Weakness
			Serenity_SpellManagement();
		end			
		
			
		SerenityPrivate.Sitting = false;
	-- When the mage begins to cast a spell, it grabs the name of the spell and saves the name of the spells target's level
	elseif (event == "SPELLCAST_START") then
		SerenityPrivate.Sitting = false;
		SpellCastName = arg1;
		SpellTargetName = UnitName("target");
		-- See if it is a corpse and retrieve the name
		if not SpellTargetName then
			local corpse = GameTooltipTextLeft1:GetText();
			if corpse ~= nil then
				for corpseName in string.gfind(corpse, SERENITY_CORPSE_SRCH) do
					SpellTargetName = corpseName;
				end
			end
		end
		-- If there is no corpse but a mouseover, try that.
		if not SpellTargetName and UnitName("mouseover") ~= nil then
			SpellTargetName = UnitName("mouseover");
		end
		-- Okay give up.  no name.
		if not SpellTargetName then
			SpellTargetName = "";
		end
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end	
		Serenity_ShackleCheck("start",SpellCastName,SpellTargetName);
		Serenity_ChatMessage(SpellCastName, SpellTargetName);
	-- When the mage stops casting, clear spell data
	-- Flag if the trade window is open, in order to be able to trade provisions automatically
	elseif event == "TRADE_REQUEST" or event == "TRADE_SHOW" then
		SerenityTradeRequest = true;
--		Serenity_BagCheck("Force");
	elseif event == "TRADE_REQUEST_CANCEL" or event == "TRADE_CLOSED" then
		SerenityTradeRequest = false;
--		Serenity_BagCheck("Update");
    elseif event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" then  -- WINTERSCHILL will go here
 		for creatureName, spell in string.gfind(arg1, SERENITY_DEBUFF_SRCH) do
   			-- Shadow Vulnerability
			if spell == SERENITY_SPELL_TABLE[62].Name
				or spell == SERENITY_SPELL_TABLE[63].Name
				or spell == SERENITY_SPELL_TABLE[64].Name
				or spell == SERENITY_SPELL_TABLE[65].Name
				or spell == SERENITY_SPELL_TABLE[66].Name then
    			for thistimer=table.getn(SpellTimer), 1, -1 do
					if 	SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[62].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[63].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[64].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[65].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[66].Name
						then
						SpellTimer, TimerTable = Serenity_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable);
					end
				end
				SpellCastName = spell;
				SpellTargetName = creatureName;
				Serenity_SpellManagement(); 
			-- Touch of Weakness
			elseif  spell == SERENITY_SPELL_TABLE[59].Name then
				SpellCastName = spell;
				SpellTargetName = creatureName;
				Serenity_SpellManagement();   			
			end
		end
	-- If mage learns a new spel/rank, the new information is obtained
	-- If the mage  learns new spell from buff or spell, button is recreated
	elseif (event == "LEARNED_SPELL_IN_TAB") then
		Serenity_SpellSetup();
		Serenity_CreateMenu();
		Serenity_ButtonSetup();
	
	-- At the end of combat, stop announcing Concentration
	-- And removes the timers for that mob
	elseif (event == "PLAYER_REGEN_ENABLED") then
		PlayerCombat = false;
		if SerenityConfig.ShowSpellTimers then
			SpellGroup, SpellTimer, TimerTable = Serenity_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable);
			for i = 1, 10, 1 do
				frameName = "SerenityTarget"..i.."Text";
				frameItem = getglobal(frameName);
				if frameItem:IsShown() then
					frameItem:Hide();
				end
			end
		end
	-- Peronsal actions -- "Buffs"
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then 
		Serenity_SelfEffect("BUFF");
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS") then
		for creatureName, spell in string.gfind(arg1, SERENITY_GAIN_SRCH) do
			-- Lightwell renew timer
			if spell == SERENITY_SPELL_TABLE[68].Name then
				SpellTargetName = creatureName;
				TargetByName(creatureName);
				SpellTargetLevel = UnitLevel("target");
				TargetLastTarget();
				SpellCastName = SERENITY_SPELL_TABLE[68].Name
				Serenity_SpellManagement();
				LightwellCharges = LightwellCharges - 1;
				for thistimer=table.getn(SpellTimer), 1, -1 do
					if 	SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[25].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[26].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[27].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[28].Name
						or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[29].Name
						then						
						SpellTimer[thistimer].Name = SERENITY_SPELL_TABLE[24+LightwellCharges].Name;
					end
				end
			end
			if spell == SERENITY_SPELL_TABLE[21].Name then
				SpellCastName = SERENITY_SPELL_TABLE[21].Name;
				SpellTargetName = creatureName;
				SpellTargetLevel = UnitLevel("target");
				Serenity_SpellManagement();
			end
		end
	-- Personal actions -- "Debuffs"
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_SELF" or event == "CHAT_MSG_SPELL_BREAK_AURA" then
		Serenity_SelfEffect("DEBUFF");
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" then
		for spell, creatureName in string.gfind(arg1, SERENITY_FADE_SRCH) do
			Serenity_ShackleCheck("break",spell,creatureName);
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		PlayerCombat = true;
	elseif event == "MERCHANT_SHOW" then
		Serenity_MerchantCheck();
	elseif event == "MERCHANT_CLOSED" then
		StaticPopup_Hide("SERENITY_RESTOCK_CONFIRMATION");
		Serenity_BagExplore();
	-- End of the loading screen
	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		if string.find(GetRealZoneText(),"Ahn'Qiraj") and not string.find(GetRealZoneText(),"Gates") and not string.find(GetRealZoneText(),"Ruins") then
			if SerenityPrivate.AQ == false then
				SerenityPrivate.AQ = true;
				Mount.AQChecked = false;
			end
		elseif SerenityPrivate.AQ == true then
			SerenityPrivate.AQ = false;
			Mount.AQMount = false;
			Mount.AQChecked = false;
			Mount.Available = false;
		end
		Serenity_BagExplore();
	end     
	return;
end

------------------------------------------------------------------------------------------------------
-- SERENITY FUNCTION "ON EVENT"
------------------------------------------------------------------------------------------------------

-- Events : PLAYER_ENTERING_WORLD and  PLAYER_LEAVING_WORLD
-- Function applied to each loading screen
-- When leaving a zone, stop supervising events
-- When done loading, starts monitoring again
-- Basically, speeds up loading time
function Serenity_RegisterManagement(RegistrationType)
	if RegistrationType == "IN" then
		SerenityButton:RegisterEvent("BAG_UPDATE");
		SerenityButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		SerenityButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
		SerenityButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		SerenityButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		SerenityButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		SerenityButton:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		SerenityButton:RegisterEvent("PLAYER_REGEN_DISABLED");
		SerenityButton:RegisterEvent("PLAYER_REGEN_ENABLED");
		SerenityButton:RegisterEvent("MERCHANT_SHOW");
		SerenityButton:RegisterEvent("MERCHANT_CLOSED");
		SerenityButton:RegisterEvent("SPELLCAST_START");
		SerenityButton:RegisterEvent("SPELLCAST_FAILED");
		SerenityButton:RegisterEvent("SPELLCAST_INTERRUPTED");
		SerenityButton:RegisterEvent("SPELLCAST_STOP");
		SerenityButton:RegisterEvent("LEARNED_SPELL_IN_TAB");
		SerenityButton:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		SerenityButton:RegisterEvent("PLAYER_TARGET_CHANGED");
		SerenityButton:RegisterEvent("TRADE_REQUEST");
		SerenityButton:RegisterEvent("TRADE_REQUEST_CANCEL");
		SerenityButton:RegisterEvent("TRADE_SHOW");
		SerenityButton:RegisterEvent("TRADE_CLOSED");
		SerenityButton:RegisterEvent("VARIABLES_LOADED");
        SerenityButton:RegisterEvent("PLAYER_LOGIN");
		SerenityButton:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	else
		SerenityButton:UnregisterEvent("BAG_UPDATE");
		SerenityButton:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		SerenityButton:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
		SerenityButton:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		SerenityButton:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		SerenityButton:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		SerenityButton:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		SerenityButton:UnregisterEvent("PLAYER_REGEN_DISABLED");
		SerenityButton:UnregisterEvent("PLAYER_REGEN_ENABLED");
		SerenityButton:UnregisterEvent("MERCHANT_SHOW");
		SerenityButton:UnregisterEvent("MERCHANT_CLOSED");
		SerenityButton:UnregisterEvent("SPELLCAST_START");
		SerenityButton:UnregisterEvent("SPELLCAST_FAILED");
		SerenityButton:UnregisterEvent("SPELLCAST_INTERRUPTED");
		SerenityButton:UnregisterEvent("SPELLCAST_STOP");
		SerenityButton:UnregisterEvent("LEARNED_SPELL_IN_TAB");
		SerenityButton:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		SerenityButton:UnregisterEvent("PLAYER_TARGET_CHANGED");
		SerenityButton:UnregisterEvent("TRADE_REQUEST");
		SerenityButton:UnregisterEvent("TRADE_REQUEST_CANCEL");
		SerenityButton:UnregisterEvent("TRADE_SHOW");
		SerenityButton:UnregisterEvent("TRADE_CLOSED");
		SerenityButton:UnregisterEvent("VARIABLES_LOADED");
        SerenityButton:UnregisterEvent("PLAYER_LOGIN");
--		SerenityButton:UnregisterEvent("ZONE_CHANGED_NEW_AREA");  Needs to be registered even while zoning
	end
	return;
end

function Serenity_SelfEffect(action)
	if action == "BUFF" then
		-- Elune's Grace
		if  string.find(arg1, SERENITY_SPELL_TABLE[9].Name) and SERENITY_SPELL_TABLE[9].ID ~= nil then
			RacialUp = false;
			SerenityBuffMenu7:SetNormalTexture("Interface\\Addons\\Serenity\\UI\\ElunesGrace-03");
		end
		-- Feedback
		if  string.find(arg1, SERENITY_SPELL_TABLE[12].Name) and SERENITY_SPELL_TABLE[12].ID ~= nil then
			RacialUp = false;
			SerenityBuffMenu10:SetNormalTexture("Interface\\Addons\\Serenity\\UI\\Feedback-03");
		end
		-- Inner Focus
		if  string.find(arg1, SERENITY_SPELL_TABLE[19].Name) and SERENITY_SPELL_TABLE[19].ID ~= nil then
			FocusUp = false;
			SerenityBuffMenu11:SetNormalTexture("Interface\\Addons\\Serenity\\UI\\InnerFocus-03");
		end
		-- Lightwell
		if  string.find(arg1, SERENITY_SPELL_TABLE[68].Name) and SERENITY_SPELL_TABLE[24].ID ~= nil then
			SpellCastName = SERENITY_SPELL_TABLE[68].Name;
			SpellTargetName = UnitName("player");
			SpellTargetLevel = "";
			Serenity_SpellManagement();
			LightwellCharges = LightwellCharges - 1;
			for thistimer=table.getn(SpellTimer), 1, -1 do
				if 	SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[25].Name
					or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[26].Name
					or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[27].Name
					or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[28].Name
					or SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[29].Name
					then						
					SpellTimer[thistimer].Name = SERENITY_SPELL_TABLE[24+LightwellCharges].Name;
				end
			end			
		end
	else
		if string.find(arg1, SERENITY_SPELL_TABLE[19].Name) then
		   SpellCastName = SERENITY_SPELL_TABLE[19].Name
		   FocusFade = true;
		   Serenity_SpellManagement()
		end
		-- Change Inner Focus button when mage doesnt have Inner Focus up
      if  string.find(arg1, SERENITY_SPELL_TABLE[49].Name) and SERENITY_SPELL_TABLE[49].ID ~= nil then
			FocusUp = false;
		end
	end
	return;
end

-- event : SPELLCAST_STOP
-- Allows to manage all that once touches with the fates their successful incantation 
function Serenity_SpellManagement()
	SortActif = false;
	if (SpellCastName) then
		if Mount.Available then
			if string.find(SpellCastName, Mount.Title) then
				SerenityMountButton:SetNormalTexture("Interface\\Addons\\Serenity\\UI\\MountButton"..Mount.Icon.."-02");
				return;
			end
		end
		if SerenityConfig.ShowSpellTimers then
			-- Pour les autres sorts castés, tentative de timer si valable
			for spell=1, table.getn(SERENITY_SPELL_TABLE), 1 do
				if SpellCastName == SERENITY_SPELL_TABLE[spell].Name then -- and not (spell == 10) then  <--- and the spell isn't Enslave Demon
					-- If a timer already exists, it is updated
					for thisspell=1, table.getn(SpellTimer), 1 do
						if SpellTimer[thisspell].Name == SpellCastName
							and SpellTimer[thisspell].Target == SpellTargetName
							and SpellTimer[thisspell].TargetLevel == SpellTargetLevel
							and SERENITY_SPELL_TABLE[spell].Type ~= 4
							then
							-- -- Si c'est sort lancé déjà présent sur un mob, on remet le timer à fond
							-- If the timer is already there, reapply it and put it on the bottom
								SpellTimer[thisspell].Time = SERENITY_SPELL_TABLE[spell].Length;
								SpellTimer[thisspell].TimeMax = floor(GetTime() + SERENITY_SPELL_TABLE[spell].Length);
								-- adjusts the duration for ShackleUndead based on the rank
								if spell == 49 then
									if SpellCastRank == nil then SpellCastRank = SERENITY_SPELL_TABLE[49].Rank; end
									SpellTimer[thisspell].Time = 20 + (SpellCastRank * 10)
									SpellTimer[thisspell].TimeMax = floor(GetTime() + 20 + (SpellCastRank * 10));																				
								end
							SortActif = true;
							break;
						end
						-- Si c'est un banish sur une nouvelle cible, on supprime le timer précédent
						-- If it is ShackleUndead on a new target, remove the old ShackleUndead timer
						if SpellTimer[thisspell].Name == SpellCastName	and spell == 49
							and
								(SpellTimer[thisspell].Target ~= SpellTargetName
								or SpellTimer[thisspell].TargetLevel ~= SpellTargetLevel)
							then
							SpellTimer, TimerTable = Serenity_RetraitTimerParIndex(thisspell, SpellTimer, TimerTable);
							SortActif = false;
							break;
						end
						if SortActif then break; end
					end
					if not SortActif and SERENITY_SPELL_TABLE[spell].Type ~= 0	 then
						if spell == 49 then
							SERENITY_SPELL_TABLE[spell].Length = 20 + (SpellCastRank * 10);
						end                                    
						if spell ~= 19 or FocusFade then
							SpellGroup, SpellTimer, TimerTable = Serenity_InsertTimerParTable(spell, SpellTargetName, SpellTargetLevel, SpellGroup, SpellTimer, TimerTable);
							FocusFade = false;
						end
						break;
					end
				end
			end
		end
	end
	SpellCastName = nil;
	SpellCastRank = nil;
	return;
end

--  Prepares sound and announcements for ShackleUndead
function Serenity_ShackleCheck(type,spell,creatureName)
	if type == "start" then
		-- Send chat message for ShackleUndead
	elseif type == "stop" then
	    if SerenityConfig.ShackleWarn and spell == SERENITY_SPELL_TABLE[49].Name then
			if SpellCastRank == nil then
				SpellCastRank = SERENITY_SPELL_TABLE[49].Rank
			end
			SerenityPrivate.ShackleWarnTime = 20 + (SpellCastRank * 10) - SerenityConfig.ShackleWarnTime;
			SerenityPrivate.ShackleBreakTime = 20 + (SpellCastRank * 10);
			SerenityPrivate.ShackleWarning = true;
			SerenityPrivate.ShackleTarget = creatureName;
		end
	elseif type == "warn" then
	    if SerenityConfig.Sound and SerenityConfig.ShackleWarn and SerenityPrivate.ShackleWarning
			and SerenityPrivate.ShackleWarnTime <= 0 then
			PlaySoundFile(SERENITY_SOUND.ShackleWarn);
			SerenityPrivate.ShackleWarning = false;
			SerenityPrivate.ShackleWarnTime = 0;
		end
	elseif type == "break" and creatureName == SerenityPrivate.ShackleTarget then
		if spell == SERENITY_SPELL_TABLE[49].Name then
			if SerenityConfig.Sound and SerenityConfig.ShackleBreak and SerenityPrivate.ShackleTarget == creatureName then
				PlaySoundFile(SERENITY_SOUND.ShackleBreak);
				SerenityPrivate.ShackleTarget = nil;
			end
           	for thistimer=table.getn(SpellTimer), 1, -1 do
				if 	SpellTimer[thistimer].Name == SERENITY_SPELL_TABLE[49].Name
				    and SpellTimer[thistimer].Target == creatureName then
					SpellTimer, TimerTable = Serenity_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable);
					break;
				end
			end
			SerenityPrivate.ShackleWarning = false;
			SerenityPrivate.ShackleWarnTime = 0;
			SerenityPrivate.ShackleTarget = nil;
		end
	end
end

-- CHAT MESSAGES! WEE <>
function Serenity_ChatMessage(spell, creatureName)
 	if SerenityPrivate.ChatSilence or not SerenityConfig.ChatMsg then
		SerenityPrivate.ChatSilence = false;
    	return;
	else
		-- Mount
		if Mount.Available then
			if spell == Mount.Title then
				if SerenityConfig.SteedMessage and string.find(SpellCastName, Mount.Title) then
	    			if not SerenityConfig.SM then
						local tempnum = random(1, table.getn(SERENITY_STEED_MESSAGE));
						while tempnum == SerenityPrivate.SteedMess and table.getn(SERENITY_STEED_MESSAGE) >= 2 do
							tempnum = random(1, table.getn(SERENITY_STEED_MESSAGE));
						end
						SerenityPrivate.SteedMess = tempnum;
						Serenity_Msg(Serenity_MsgReplace(SERENITY_STEED_MESSAGE[tempnum], nil, nil, Mount.Title), "SAY");
					end					
				end
			end
		end
		-- ShackleUndead
		
		if spell == SERENITY_SPELL_TABLE[49].Name then
			if SerenityConfig.ShackleMessage then
				local tempnum = random(1, table.getn(SERENITY_SHACKLE_MESSAGE));
				while tempnum == SerenityPrivate.ShackleMess and table.getn(SERENITY_SHACKLE_MESSAGE) >= 2 do
					tempnum = random(1, table.getn(SERENITY_SHACKLE_MESSAGE));
				end
				SerenityPrivate.ShackleMess = tempnum;
				Serenity_Msg(Serenity_MsgReplace(SERENITY_SHACKLE_MESSAGE[tempnum], creatureName), "GROUP");
			end
		elseif spell == SERENITY_SPELL_TABLE[48].Name then
			if SerenityConfig.ResMessage then
				local tempnum = random(1, table.getn(SERENITY_RES_MESSAGE));
				while tempnum == SerenityPrivate.ResMess and table.getn(SERENITY_RES_MESSAGE) >= 2 do
					tempnum = random(1, table.getn(SERENITY_RES_MESSAGE));
				end
				SerenityPrivate.ResMess = tempnum;
				Serenity_Msg(Serenity_MsgReplace(SERENITY_RES_MESSAGE[tempnum], creatureName), "SAY");
			end
		end
	end
end


-- Event: MERCHANT_SHOW
-- Checks to see if the player needs to restock
function Serenity_MerchantCheck()
	local MerchItems = GetMerchantNumItems()
	local Purchase = false;
	local color;
 	local display = false;
	for item= 1, MerchItems do
		local itemString = GetMerchantItemInfo(item)
		if itemString == SERENITY_ITEM.HolyCandle or itemString == SERENITY_ITEM.SacredCandle then
--			Serenity_BagCheck("Force");
			-- Check For teleports
			if SERENITY_SPELL_TABLE[41].Rank == 1 then
				display = true;
				color = (Count.HolyCandle / SerenityConfig.RestockHolyCandle) * 100;
				if (SerenityConfig.RestockHolyCandle - Count.HolyCandle) > 0 then
					Purchase = true;
				end
			end
			if display then
				Serenity_Msg(Serenity_MsgAddColor(SERENITY_ITEM.HolyCandle..": "..SerenityTimerColor(color)..Count.HolyCandle.."/"..SerenityConfig.RestockHolyCandle), "USER");
            	display = false;
			end
            -- Check for Spells
			if SERENITY_SPELL_TABLE[43].ID or SERENITY_SPELL_TABLE[44].ID then
				display = true;
				color = (Count.SacredCandle / SerenityConfig.RestockSacredCandle) * 100;
				if (SerenityConfig.RestockSacredCandle - Count.SacredCandle) > 0 then
					Purchase = true;
				end
			end
			if display then
				Serenity_Msg(Serenity_MsgAddColor(SERENITY_ITEM.SacredCandle..": "..SerenityTimerColor(color)..Count.SacredCandle.."/"..SerenityConfig.RestockSacredCandle), "USER");
				display = false;
			end
			if Purchase then
				Serenity_RestockConfirm();
			end
			break;
		end
	end
end

function Serenity_RestockConfirm()
	Serenity_BagExplore();
	if SerenityConfig.Restock then
    	if SerenityConfig.RestockConfirm then
    		StaticPopup_Show("SERENITY_RESTOCK_CONFIRMATION");
    	else
    		Serenity_Restock();
    	end
    end
end
function Serenity_Restock()
	local MerchItems = GetMerchantNumItems()
	local RestockCount = { };
	local RestockNames = { 
		[1] = SERENITY_ITEM.HolyCandle; 
		[2] = SERENITY_ITEM.SacredCandle;
	};	
	if SERENITY_SPELL_TABLE[41].ID then
		RestockCount[1] = SerenityConfig.RestockHolyCandle - Count.HolyCandle;
	end
	if SERENITY_SPELL_TABLE[43].ID or SERENITY_SPELL_TABLE[44].ID then
		RestockCount[2] = SerenityConfig.RestockSacredCandle - Count.SacredCandle;
	end
	for item= 1, MerchItems do
		for i = 1, table.getn(RestockCount) do
			local itemString = GetMerchantItemInfo(item)
			if itemString == RestockNames[i] and RestockCount[i] > 0 then
				Serenity_Msg(SERENITY_MESSAGE.Information.Restocked..RestockCount[i].." "..RestockNames[i], "USER");
				local buycycles = floor(RestockCount[i] / 20) + 1
				for cycle=1, buycycles, 1 do
					if RestockCount[i] > 20 then
						BuyMerchantItem(item, 20);
						RestockCount[i] = RestockCount[i] - 20;
					elseif RestockCount[i] > 0 then
						BuyMerchantItem(item, RestockCount[i]);
						RestockCount[i] = RestockCount[i] - RestockCount[i];
					end
--					Serenity_BagCheck("Update");
				end	
			end
		end
	end
end
StaticPopupDialogs["SERENITY_RESTOCK_CONFIRMATION"] = {
    text = "Restock Candles?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
	Serenity_Restock();
    end,
    OnShow = function()
	end,
    timeout = 0,
};


------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF THE INTERFACE -- BONDS XML 
------------------------------------------------------------------------------------------------------

-- By right clicking on Serenity, one eats/drings or opens the control panels 
function Serenity_Toggle(button, keybind)
	local Ctrl = IsControlKeyDown()
	if Ctrl and keybind then Ctrl = not Ctrl; end
	if button == "LeftButton" then		
		if SerenityConfig.Button == 1 then
			Serenity_UseItem("Drink", "LeftButton");
		elseif SerenityConfig.Button == 2 then
			Serenity_UseItem("Potion","LeftButton");
		elseif SerenityConfig.Button == 3 then
			Serenity_UseItem("Potion","RightButton")
		elseif SerenityConfig.Button == 4 then
			CastSpell(SERENITY_SPELL_TABLE[10].ID, "spell");
		elseif SerenityConfig.Button == 5 then
			CastSpell(SERENITY_SPELL_TABLE[45].ID, "spell");
		elseif SerenityConfig.Button == 6 then
			CastSpell(SERENITY_SPELL_TABLE[53].ID, "spell");
		elseif SerenityConfig.Button == 7 then
			CastSpell(SERENITY_SPELL_TABLE[49].ID, "spell");
		elseif SerenityConfig.Button == 8 then
			CastSpell(SERENITY_SPELL_TABLE[39].ID, "spell");
		elseif SerenityConfig.Button == 101 then
			if sheepSafeConfig.warning then
				sheepSafeConfig.warning = false;
			end
			SheepSafe();
		end
		return;
	end
	
	if (SerenityGeneralFrame:IsVisible()) then
		HideUIPanel(SerenityGeneralFrame);
		return;
	else
		if SerenityConfig.SM then
			Serenity_Msg("!!! Short Messages: <brightGreen>On", "USER");
		end
		ShowUIPanel(SerenityGeneralFrame);
		SerenityGeneralTab_OnClick(1);
		return;
	end
end

-- Function allowing the movement of elements of Serenity on the screen 
function Serenity_OnDragStart(button)
	if (button == "SerenityIcon") then GameTooltip:Hide(); end
	button:StartMoving();
end

-- Function stopping the displacement of elements of Serenity on the screen 
function Serenity_OnDragStop(button)
	if (button == "SerenityIcon") then Serenity_BuildTooltip("OVERALL"); end
	button:StopMovingOrSizing();
end

-- Function alternating Timers graphs and Timers texts 
function Serenity_HideGraphTimer()
	for i = 1, 50, 1 do
		local elements = {"Text", "Bar", "Texture", "OutText"}
		if SerenityConfig.Graphical then
			if TimerTable[i] then
				for j = 1, 4, 1 do
					frameName = "SerenityTimer"..i..elements[j];
					frameItem = getglobal(frameName);
					frameItem:Show();
				end
			end
		else
			for j = 1, 4, 1 do
				frameName = "SerenityTimer"..i..elements[j];
				frameItem = getglobal(frameName);
				frameItem:Hide();
			end
		end
	end
end

-- Function managing the Sphere buttons
function Serenity_BuildTooltip(button, type, anchor)
    
	-- If the position of the sphere buttons is bad, bye bye!
	if not SerenityConfig.SerenityToolTip then
		return;
	end

	-- Looks to see if Evocation or Wards is up
	local startRacial, durationRacial, startFocus, durationFocus, startLightwell, durationLightwell, startInfusion, durationInfusion,
		startScream, durationScream, startFade, durationFade, startPotion, durationPotion;
	local SerenityRacialID = 0;
	-- Elune's Grace
	if SERENITY_SPELL_TABLE[9].ID then
		startRacial, durationRacial = GetSpellCooldown(SERENITY_SPELL_TABLE[9].ID, BOOKTYPE_SPELL);
		SerenityRacialID = 9;
	else
		startRacial = 1;
		durationRacial = 1;
	end
	-- Fade
	if SERENITY_SPELL_TABLE[10].ID then
		startFade, durationFade = GetSpellCooldown(SERENITY_SPELL_TABLE[10].ID, BOOKTYPE_SPELL);
	else	
		startFade = 1;
		durationFade = 1;
	end
	-- Fear Ward
	if SERENITY_SPELL_TABLE[11].ID then
		startRacial, durationRacial = GetSpellCooldown(SERENITY_SPELL_TABLE[11].ID, BOOKTYPE_SPELL);
		SerenityRacialID = 11;
	else
		start = 1;
		duration = 1;
	end
	-- Feedback
	if SERENITY_SPELL_TABLE[12].ID then
		startRacial, durationRacial = GetSpellCooldown(SERENITY_SPELL_TABLE[12].ID, BOOKTYPE_SPELL);
		SerenityRacialID = 12;
	else
		start = 1;
		duration = 1;
	end
	-- Inner Focus
	if SERENITY_SPELL_TABLE[19].ID then
		startFocus, durationFocus = GetSpellCooldown(SERENITY_SPELL_TABLE[19].ID, BOOKTYPE_SPELL);
	else
		start = 1;
		duration = 1;
	end
	-- Lightwell
	if SERENITY_SPELL_TABLE[24].ID then
		startLightwell, durationLightwell = GetSpellCooldown(SERENITY_SPELL_TABLE[24].ID, BOOKTYPE_SPELL);
	else
		start = 1;
		duration = 1;
	end
	-- Power Infusion
	if SERENITY_SPELL_TABLE[47].ID then
		startInfusion, durationInfusion = GetSpellCooldown(SERENITY_SPELL_TABLE[47].ID, BOOKTYPE_SPELL);
	else
		start = 1;
		duration = 1;
	end
	-- Scream
	if SERENITY_SPELL_TABLE[45].ID then
		startScream, durationScream = GetSpellCooldown(SERENITY_SPELL_TABLE[45].ID, BOOKTYPE_SPELL);
	else	
		start = 1;
		duration = 1;
	end	
	-- Shadowguard
	if SERENITY_SPELL_TABLE[54].ID then
		SerenityRacialID = 54;
		startRacial = 0;
		durationRacial = 0;
	end
	-- Touch of Weakness
	if SERENITY_SPELL_TABLE[59].ID then
		SerenityRacialID = 59;
		startRacial = 0;
		durationRacial = 0;
	end
	-- Creation of the Sphere buttons...
	GameTooltip:SetOwner(button, anchor);
	if type ~= "Racial" then
		GameTooltip:SetText(SerenityTooltipData[type].Label);
	else
		GameTooltip:SetText("|c00FFFFFF"..SERENITY_SPELL_TABLE[SerenityRacialID].Name.."|r");
	end
	-- ..... For the main Sphere
	if (type == "Main") then
		GameTooltip:AddLine(Potion[1].Name..": "..Count.ManaPotion);
		GameTooltip:AddLine(Potion[2].Name..": "..Count.HealingPotion);
		GameTooltip:AddLine(Potion[3].Name..": "..Count.Drink);
		if SERENITY_SPELL_TABLE[41].Rank == 1 then
			GameTooltip:AddLine(SerenityTooltipData.Main.HolyCandle..Count.HolyCandle);
		end
		if SERENITY_SPELL_TABLE[41].Rank == 2 or SERENITY_SPELL_TABLE[43].ID ~= nil or SERENITY_SPELL_TABLE[44].ID ~= nil then
			GameTooltip:AddLine(SerenityTooltipData.Main.SacredCandle..Count.SacredCandle);
		end
		GameTooltip:AddLine(SerenityTooltipData.Main.LightFeather..Count.LightFeather);
	elseif (type == "Mount") then
		GameTooltip:SetText(SerenityTooltipData[type].Label..Mount.Title.."|r");
		Serenity_MoneyToggle();
		SerenityTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		local itemName = tostring(SerenityTooltipTextLeft5:GetText());
  		if string.find(itemName, SERENITY_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(SERENITY_TRANSLATION.Hearth.." - "..itemName);
		else
			GameTooltip:AddLine(SerenityTooltipData["SpellTimer"].Right..GetBindLocation());
		end
	-- Potion
	elseif (type == "Potion") then
	    GameTooltip:SetText("|c00FFFFFF"..Potion[1].Name.." ("..Count.ManaPotion..")");
		for i = 1, 2, 1 do
		if Potion[i].Mode == 2 then
		    	Serenity_MoneyToggle();
	           	start, duration, enable = GetContainerItemCooldown(Potion[i].Location[1], Potion[i].Location[2]);
				if start > 0 and duration > 0 then
					local seconde = duration - ( GetTime() - start)
					GameTooltip:AddLine("Cooldown: "..Serenity_TimerFunction(seconde));
					GameTooltip:AddLine(" ");
   					break;
  				end
			end
		end	 	
		GameTooltip:AddLine(SerenityTooltipData.Potion.Text[1]..Potion[1].EnergyMin.."-"..Potion[1].EnergyMax.." MP");
		GameTooltip:AddLine(SerenityTooltipData.Alt.Left..Potion[2].Name.." ("..Potion[2].EnergyMin.."-"..Potion[2].EnergyMax.." HP)");
	-- ..... For the timer buttons
	elseif (type == "SpellTimer") then
		Serenity_MoneyToggle();
		SerenityTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		local itemName = tostring(SerenityTooltipTextLeft5:GetText());
		GameTooltip:AddLine(SerenityTooltipData[type].Text);
		if string.find(itemName, SERENITY_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(SERENITY_TRANSLATION.Hearth.." - "..itemName);
		else
			GameTooltip:AddLine(SerenityTooltipData[type].Right..GetBindLocation());
		end
		
	-- ..... For the Concentration button
	elseif (type == "Fortitude") then
		if SERENITY_SPELL_TABLE[38].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[38].Mana.." Mana");
		end
		if SERENITY_SPELL_TABLE[41].ID ~= nil then
			GameTooltip:AddLine(SerenityTooltipData.Alt.Left..SERENITY_SPELL_TABLE[41].Name.." ("..SERENITY_SPELL_TABLE[41].Mana.." Mana)"..SerenityTooltipData.Alt.Right);
			if SERENITY_SPELL_TABLE[41].Rank == 1 then
				GameTooltip:AddLine(SERENITY_ITEM.HolyCandle..": "..Count.HolyCandle);
			elseif SERENITY_SPELL_TABLE[41].Rank == 2 then
				GameTooltip:AddLine(SERENITY_ITEM.SacredCandle..": "..Count.SacredCandle);
			end
		end
	elseif (type == "DivineSpirit") then
		if SERENITY_SPELL_TABLE[8].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[8].Mana.." Mana");
		end
		if SERENITY_SPELL_TABLE[44].ID ~= nil then
			GameTooltip:AddLine(SerenityTooltipData.Alt.Left..SERENITY_SPELL_TABLE[44].Name.." ("..SERENITY_SPELL_TABLE[44].Mana.." Mana)"..SerenityTooltipData.Alt.Right);
			GameTooltip:AddLine(SERENITY_ITEM.SacredCandle..": "..Count.SacredCandle);
		end
	elseif (type == "ShadowProtection") then
		if SERENITY_SPELL_TABLE[51].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[51].Mana.." Mana");
		end
		if SERENITY_SPELL_TABLE[43].ID ~= nil then
			GameTooltip:AddLine(SerenityTooltipData.Alt.Left..SERENITY_SPELL_TABLE[43].Name.." ("..SERENITY_SPELL_TABLE[43].Mana.." Mana)"..SerenityTooltipData.Alt.Right);
			GameTooltip:AddLine(SERENITY_ITEM.SacredCandle..": "..Count.SacredCandle);
		end
	elseif (type == "InnerFire") then
		if SERENITY_SPELL_TABLE[20].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[20].Mana.." Mana");
		end
	elseif (type == "ShadowProtection") then
		if SERENITY_SPELL_TABLE[51].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[51].Mana.." Mana");
		end
	elseif (type == "Levitate") then
		if SERENITY_SPELL_TABLE[22].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[22].Mana.." Mana");
			GameTooltip:AddLine(SERENITY_ITEM.LightFeather..": "..Count.LightFeather);
		end
	elseif (type == "Racial") then
		if SERENITY_SPELL_TABLE[SerenityRacialID].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[SerenityRacialID].Mana.." Mana");
			if startRacial > 0 and durationRacial > 0 and not RacialUp then
				GameTooltip:AddLine("Cooldown : "..Serenity_TimerFunction(durationRacial - (GetTime() - startRacial)));
			else
				RacialUp = true;
			end		
		end
	elseif (type == "InnerFocus") then
		if startFocus > 0 and durationFocus > 0 and not FocusUp then
			GameTooltip:AddLine("Cooldown : "..Serenity_TimerFunction(durationFocus - (GetTime() - startFocus)));
		else
		    FocusUp = true;
		end		
	elseif (type == "PowerInfusion") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[37].Mana.." Mana");
		if startInfusion > 0 and durationInfusion > 0 and not InfusionUp then
			GameTooltip:AddLine("Cooldown : "..Serenity_TimerFunction(durationInfusion - (GetTime() - startInfusion)));
		else
		    InfusionUp = true;
		end
	elseif (type == "Shadowform") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[53].Mana.." Mana");
	elseif (type == "Resurrection") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[48].Mana.." Mana");
	elseif (type == "Lightwell") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[24].Mana.." Mana");
		if startLightwell > 0 and durationLightwell > 0 and not LightwellUp then
			GameTooltip:AddLine("Cooldown : "..Serenity_TimerFunction(durationLightwell - (GetTime() - startLightwell)));
		else
		    LightwellUp = true;
		end
	elseif (type == "MindControl") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[33].Mana.." Mana");
	elseif (type == "MindVision") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[36].Mana.." Mana");
	elseif (type == "MindSoothe") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[35].Mana.." Mana");
	elseif (type == "Fade") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[10].Mana.." Mana");
		if startFade > 0 and durationFade > 0 and not FadeUp then
			GameTooltip:AddLine("Cooldown : "..Serenity_TimerFunction(durationFade - (GetTime() - startFade)));
		else
		    FadeUp = true;
		end
	elseif (type == "Scream") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[45].Mana.." Mana");
		if startScream > 0 and durationScream > 0 and not ScreamUp then
			GameTooltip:AddLine("Cooldown : "..Serenity_TimerFunction(durationScream - (GetTime() - startScream)));
		else
		    ScreamUp = true;
		end
	elseif (type == "ShackleUndead") then
		GameTooltip:AddLine(SERENITY_SPELL_TABLE[49].Mana.." Mana");
	elseif (type == "Drink") then
		GameTooltip:SetText("|c00FFFFFF"..Potion[3].Name.." ("..Count.Drink..")|r");		
		GameTooltip:AddLine(SerenityTooltipData.Potion.Text[1]..Potion[3].Energy.." Mana"..SerenityTooltipData.Potion.Text[2]..Potion[3].Length.." sec");
	elseif (type == "Dispel") then
		if SERENITY_SPELL_TABLE[7].ID then
			GameTooltip:AddLine(SERENITY_SPELL_TABLE[7].Mana.." Mana");
		end
		if SERENITY_SPELL_TABLE[1].ID then
			GameTooltip:AddLine(SerenityTooltipData.Alt.Left..SERENITY_SPELL_TABLE[1].Name.." ("..SERENITY_SPELL_TABLE[1].Mana.." Mana)"..SerenityTooltipData.Alt.Right);
		elseif SERENITY_SPELL_TABLE[31].ID then
			GameTooltip:AddLine(SerenityTooltipData.Alt.Left..SERENITY_SPELL_TABLE[3].Name.." ("..SERENITY_SPELL_TABLE[3].Mana.." Mana)"..SerenityTooltipData.Alt.Right);
		end
	elseif (type == "Buff") and SerenityPrivate.LastBuff ~= 0 then
		GameTooltip:AddLine(SerenityTooltipData.LastSpell.Left..SERENITY_SPELL_TABLE[SerenityPrivate.LastBuff].Name..SerenityTooltipData.LastSpell.Right);
	elseif (type == "Spell") and SerenityPrivate.LastSpell ~= 0 then
		GameTooltip:AddLine(SerenityTooltipData.LastSpell.Left..SERENITY_SPELL_TABLE[SerenityPrivate.LastSpell].Name..SerenityTooltipData.LastSpell.Right);
	end
	-- And done, Showing!
	GameTooltip:Show();
end
function Serenity_BuildSpellTooltip(button, side, anchor)
	local spell, type;
	if side == "Left" then 
		spell = SerenityConfig.LeftSpell;
	elseif side == "Middle" then
		spell = SerenityConfig.MiddleSpell;
	else
		spell = SerenityConfig.RightSpell;
	end
	if spell == 1 then
		if SERENITY_SPELL_TABLE[38].ID then
			type = "Fortitude";
		end
	elseif spell == 2 then
		if SERENITY_SPELL_TABLE[8].ID then
			type = "DivineSpirit";
		end
	elseif spell == 3 then
		if SERENITY_SPELL_TABLE[51].ID then
			type = "ShadowProtection";
		end
	elseif spell == 4 then
		if SERENITY_SPELL_TABLE[20].ID then
			type = "InnerFire";
		end
	elseif spell == 5 then
		if SERENITY_SPELL_TABLE[23].ID then
			type = "Levitate";
		end
	elseif spell == 6 then
		if SerenityRacialID ~= 0 then
			type = "Racial";
		end
	elseif spell == 7 then
	    if SERENITY_SPELL_TABLE[19].ID then
			type = "InnerFocus";
	    end
	elseif spell == 8 then
	    if SERENITY_SPELL_TABLE[37].ID then
			type = "PowerInfusion";
		end
	elseif spell == 9 then
	    if SERENITY_SPELL_TABLE[53].ID then
			type = "Shadowform";
		end
	elseif spell == 10 then
	    if SERENITY_SPELL_TABLE[10].ID then
			type = "Fade";
		end
	elseif spell == 11 then
	    if SERENITY_SPELL_TABLE[24].ID then
			type = "Lightwell";
		end
	elseif spell == 12 then
	    if SERENITY_SPELL_TABLE[48].ID then
			type = "Resurrection";
		end
	elseif spell == 13 then
	    if SERENITY_SPELL_TABLE[45].ID then
			type = "Scream";
		end
	elseif spell == 14 then
	    if SERENITY_SPELL_TABLE[33].ID then
			type = "MindControl";
		end
	elseif spell == 15 then
	    if SERENITY_SPELL_TABLE[35].ID then
			type = "MindSoothe";
		end
	elseif spell == 16 then
	    if SERENITY_SPELL_TABLE[36].ID then
			type = "MindVision";
		end
	elseif spell == 17 then
		if SERENITY_SPELL_TABLE[49].ID then
			type = "ShackleUndead";
		end
	end
	if type then
		Serenity_BuildTooltip(button, type, anchor);
	end
end
function Serenity_BuildShieldTooltip(button, anchor)
	if SERENITY_SPELL_TABLE[23].ID then
    	Serenity_BuildTooltip(button, "IceBarrier", anchor);
    else
    	Serenity_BuildTooltip(button, "ManaShield", anchor);
    end
end
-- Function updating the Serenity buttons and giving the state of the Evocation button
function Serenity_UpdateIcons()
	if Shadowform then 
		SerenityConfig.Skin = 2;
	else
		SerenityConfig.Skin = 1;
	end
	-- Create icons for SerenityReordering in the button menu
	local mana = UnitMana("player");

	for i=1, 9, 1 do
		if SerenityButtonTexture.Stones.Highlight[i] ~= SerenityConfig.Skin then
			getglobal(SerenityConfig.StoneLocation[i]):SetHighlightTexture("Interface\\Addons\\Serenity\\UI\\"..Skin[SerenityConfig.Skin].."\\BaseMenu-02");
			local texture = getglobal(SerenityConfig.StoneLocation[i]):GetHighlightTexture() 
			texture:SetBlendMode("BLEND") -- use "ADD" for additive highlight 
			getglobal(SerenityConfig.StoneLocation[i]):SetHighlightTexture(texture) 	
			SerenityButtonTexture.Stones.Highlight[i] = SerenityConfig.Skin 
		end
	end
	
	-------------------------------------
	-- Posting main Serenity sphere
	-------------------------------------
 	if SerenityConfig.CountType == 0 then     -- None
		Sphere.display = "";
	elseif SerenityConfig.CountType == 1 then
		if SERENITY_SPELL_TABLE[41].ID then
			if SERENITY_SPELL_TABLE[41].Rank == 2 then
				Sphere.display = Count.SacredCandle;
			else
				Sphere.display = Count.HolyCandle.." / "..Count.SacredCandle;
			end
		else
			Sphere.display = Count.HolyCandle.." / "..Count.SacredCandle;
		end
	elseif SerenityConfig.CountType == 2 then -- Drinks
	    Sphere.display = Count.Drink;
	elseif SerenityConfig.CountType == 3 then -- Mana Potion and Healing Potion
		Sphere.display = Count.ManaPotion.." / "..Count.HealingPotion;
	elseif SerenityConfig.CountType == 4 then -- HP Current
		Sphere.color = SerenityTimerColor(((UnitHealth("player") / UnitHealthMax("player")) * 100));
		Sphere.display = Serenity_MsgAddColor(Sphere. 	color..tostring(UnitHealth("player")));
	elseif SerenityConfig.CountType == 5 then -- HP Percent
		Sphere.color = SerenityTimerColor(((UnitHealth("player") / UnitHealthMax("player")) * 100));
		Sphere.display = floor(UnitHealth("player") / UnitHealthMax("player") * 100);
		Sphere.display = Serenity_MsgAddColor(Sphere.color .. tostring(Sphere.display).."%");
	elseif SerenityConfig.CountType == 6 then -- MP Current
		Sphere.display = tostring(UnitMana("player"));
	elseif SerenityConfig.CountType == 7 then -- MP Percent
		Sphere.display = floor(UnitMana("player") / UnitManaMax("player") * 100);
		Sphere.display = tostring(Sphere.display).."%";
	elseif SerenityConfig.CountType == 8 then -- Potion cooldown
		if SerenityPrivate.PotionCooldownText == "" then
			Sphere.display = "Ready";
		else
			Sphere.display = SerenityPrivate.PotionCooldownText;		
		end
	end
	if SerenityButtonTexture.Text ~= Sphere.display then
		SerenityShardCount:SetText(Serenity_MsgAddColor(Sphere.display));
		SerenityButtonTexture.Text = Sphere.display;
	end
	----------------------------------------
	-- Set outer circle display
	----------------------------------------
	if SerenityConfig.Circle == 5 then
		Sphere.texture = floor(Count.SacredCandle or 1 / SerenityConfig.RestockSacredCandle or 1) / floor(SerenityConfig.RestockSacredCandle or 1 / 16);
	elseif SerenityConfig.Circle == 4 then
		Sphere.texture = 16 - floor(FiveSec /(5/16));
		if FiveSec == 0 then Sphere.texture = 32; end
	elseif SerenityConfig.Circle == 3 then
		if SerenityPrivate.PotionCooldown > 0 then
			Sphere.texture = 16 - (floor(SerenityPrivate.PotionCooldown / (120/16)));			
		else
			Sphere.texture = 32;
		end
	-- if outer circle shows MP
	elseif SerenityConfig.Circle == 2 then
		Sphere.texture = floor(UnitMana("player") / (UnitManaMax("player") / 16));
		if Sphere.texture == 16 then Sphere.texture = 32; end
	-- If outer circle shows HP
	elseif SerenityConfig.Circle == 1 then
		Sphere.texture = floor(UnitHealth("player") / (UnitHealthMax("player") / 16));
		if Sphere.texture == 16 then Sphere.texture = 32; end
	end
	if SerenityButtonTexture.Circle ~= Sphere.texture then
		SerenityButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\"..Skin[SerenityConfig.Skin].."\\Shard"..Sphere.texture);
		SerenityButtonTexture.Circle = Sphere.texture;
	end
	
	-- Potion Button
	-----------------------------------------------
	if SerenityButtonTexture.Stones.Base[2] ~= Potion[1].RankID then
		SerenityPotionButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\Potion0"..Potion[1].RankID.."-01");
		SerenityButtonTexture.Stones.Base[2] = Potion[1].RankID;
	end
	-- Drink Button
	-----------------------------------------------

	local Water = "Water";
	if Potion[3].RankID < 10 then
		Water = "Water0";
	end
	if Serenity_UnitHasBuff("player",SERENITY_TRANSLATION.Drink) and Count.Drink > 0 then
		SerenityDrinkButton:LockHighlight();
	elseif Count.Drink > 0 and not PlayerCombat then 				-- Have Drink and not in combat
		SerenityDrinkButton:UnlockHighlight();
		SerenityDrinkButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\"..Water..Potion[3].RankID.."-01");
	else												-- No Drink or in combat
		SerenityDrinkButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\"..Water..Potion[3].RankID.."-03");			
	end

	-- Mount Button
	-----------------------------------------------
	
	if Serenity_UnitHasBuff("player",Mount.Title) then
		SerenityMountButton:LockHighlight();
	elseif Mount.Available then
		SerenityMountButton:UnlockHighlight();
		if PlayerCombat and SerenityButtonTexture.Stones.Base[8] ~= 3 then
			SerenityMountButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\MountButton"..Mount.Icon.."-03");
			SerenityButtonTexture.Stones.Base[8] = 3;
		elseif SerenityButtonTexture.Stones.Base[8] ~= 1 then
			SerenityMountButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\MountButton"..Mount.Icon.."-01");
			SerenityButtonTexture.Stones.Base[8] = 1;
		end
	end

	-- Spell Menu Button
	----------------------------------------------
	if SerenityButtonTexture.Stones.Base[9] ~= SerenityConfig.Skin then
		SerenitySpellMenuButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\"..Skin[SerenityConfig.Skin].."\\SpellMenuButton-01")
		SerenityButtonTexture.Stones.Base[9] = SerenityConfig.Skin;
	end
	-- Timer Buttons
	-----------------------------------------------
	if HearthstoneLocation[1] then
		start, duration, enable = GetContainerItemCooldown(HearthstoneLocation[1], HearthstoneLocation[2]);
		if duration > 20 and start > 0 then
			if SerenityButtonTexture.Stones.Base[10] ~= 1 then
				SerenitySpellTimerButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\SpellTimerButton-Cooldown");
				SerenityButtonTexture.Stones.Base[10] = 1;
			end
		elseif SerenityButtonTexture.Stones.Base[10] ~= 2 then			
			SerenitySpellTimerButton:SetNormalTexture("Interface\\AddOns\\Serenity\\UI\\SpellTimerButton-Normal");
			SerenityButtonTexture.Stones.Base[10] = 2;
		end
	end
	
	-- Spell Buttons
	---------------------------------------------------
	local spellButton = {"SerenityLeftSpellButton", "SerenityMiddleSpellButton", "SerenityRightSpellButton"};
	local spellNumber = { SerenityConfig.LeftSpell, SerenityConfig.MiddleSpell, SerenityConfig.RightSpell };
	local spellEnable, texture;
	for i=1, 3, 1 do
		spellEnable = false;
		if spellNumber[i] == 1 then		
			texture = "Interface\\AddOns\\Serenity\\UI\\Fortitude-01";
			if SERENITY_SPELL_TABLE[38].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[38].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\Fortitude-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\Fortitude-01";
				end
			end
		elseif spellNumber[i] == 2 then
			texture = "Interface\\AddOns\\Serenity\\UI\\DivineSpirit-01";
			if SERENITY_SPELL_TABLE[8].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[8].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\DivineSpirit-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\DivineSpirit-01";
				end
			end
		elseif spellNumber[i] == 3 then			
			texture = "Interface\\AddOns\\Serenity\\UI\\ShadowProtection-01";
			if SERENITY_SPELL_TABLE[51].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[51].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\ShadowProtection-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\ShadowProtection-01";
				end
			end
		elseif spellNumber[i] == 4 then			
			texture = "Interface\\AddOns\\Serenity\\UI\\InnerFire-01";
			if SERENITY_SPELL_TABLE[20].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[20].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\InnerFire-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\InnerFire-01";
				end
			end
		elseif spellNumber[i] == 5 then			
			texture = "Interface\\AddOns\\Serenity\\UI\\Levitate-01";
			if SERENITY_SPELL_TABLE[23].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[20].Mana > mana and Count.LightFeather > 0 then
					texture = "Interface\\AddOns\\Serenity\\UI\\Levitate-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\Levitate-01";
				end
			end
		elseif spellNumber[i] == 6 then			
			texture = "Interface\\AddOns\\Serenity\\UI\\FearWard-03";
			if SERENITY_SPELL_TABLE[11].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[11].ID, "spell");
				if SERENITY_SPELL_TABLE[11].Mana > mana or
					start > 0 and duration > 0 and not RacialUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\FearWard-03";
				else
					RacialUp = true
					texture = "Interface\\AddOns\\Serenity\\UI\\FearWard-01";
				end
			elseif SERENITY_SPELL_TABLE[9].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[9].ID, "spell");
				if SERENITY_SPELL_TABLE[9].Mana > mana or
					start > 0 and duration > 0 and not RacialUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\ElunesGrace-03";
				else
					RacialUp = true;
					texture = "Interface\\AddOns\\Serenity\\UI\\ElunesGrace-01";
				end
			elseif SERENITY_SPELL_TABLE[54].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[54].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\Shadowguard-03";
				else
					texture = "Interface\\AddOns\\Serenity\\UI\\Shadowguard-01";
				end
			elseif SERENITY_SPELL_TABLE[59].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[59].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\TouchOfWeakness-03";
				else
					texture = "Interface\\AddOns\\Serenity\\UI\\TouchOfWeakness-01";
				end
			elseif SERENITY_SPELL_TABLE[12].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[12].ID, "spell");
				if SERENITY_SPELL_TABLE[12].Mana > mana or
					start > 0 and duration > 0 and not RacialUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\Feedback-03";
				else
					RacialUp = true;
					texture = "Interface\\AddOns\\Serenity\\UI\\Feedback-01";
				end
			end
		elseif spellNumber[i] == 7 then			
			texture = "Interface\\AddOns\\Serenity\\UI\\InnerFocus-01";
			if SERENITY_SPELL_TABLE[19].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[19].ID, "spell");
				if start > 0 and duration > 0 and not FocusUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\InnerFocus-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					FocusUp = true;
					texture = "Interface\\AddOns\\Serenity\\UI\\InnerFocus-01";
				end
			end
		elseif spellNumber[i] == 8 then			
			texture = "Interface\\AddOns\\Serenity\\UI\\PowerInfusion-01";
			if SERENITY_SPELL_TABLE[37].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[37].ID, "spell");
				if SERENITY_SPELL_TABLE[37].Mana > mana or
					start > 0 and duration > 0 and not InfusionUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\PowerInfusion-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					InfusionUp = true;
					texture = "Interface\\AddOns\\Serenity\\UI\\PowerInfusion-01";
				end
			end
		elseif spellNumber[i] == 9 then			
			texture = "Interface\\AddOns\\Serenity\\UI\\Shadowform-01";
			if SERENITY_SPELL_TABLE[53].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[53].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\Shadowform-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\Shadowform-01";
				end
			end
		elseif spellNumber[i] == 10 then
			texture = "Interface\\AddOns\\Serenity\\UI\\Fade-01";
			if SERENITY_SPELL_TABLE[10].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[10].ID, "spell");
				if SERENITY_SPELL_TABLE[10].Mana > mana or
					start > 0 and duration > 0 and not FadeUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\Fade-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					FadeUp = true;
					texture = "Interface\\AddOns\\Serenity\\UI\\Fade-01";
				end
			end			
		elseif spellNumber[i] == 11 then
			texture = "Interface\\AddOns\\Serenity\\UI\\Lightwell-01";
			if SERENITY_SPELL_TABLE[24].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[24].ID, "spell");
				if SERENITY_SPELL_TABLE[24].Mana > mana or
					start > 0 and duration > 0 and not LightwellUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\Lightwell-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\Lightwell-01";
				end
			end
		elseif spellNumber[i] == 12 then
			texture = "Interface\\AddOns\\Serenity\\UI\\Resurrection-01";
			if SERENITY_SPELL_TABLE[48].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[48].Mana > mana and not Shadowform then
					texture = "Interface\\AddOns\\Serenity\\UI\\Resurrection-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\Resurrection-01";
				end
			end
		elseif spellNumber[i] == 13 then
			texture = "Interface\\AddOns\\Serenity\\UI\\Scream-01";
			if SERENITY_SPELL_TABLE[45].ID ~= nil then
				spellEnable = true;
				local start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[45].ID, "spell");
				if SERENITY_SPELL_TABLE[45].Mana > mana or
					start > 0 and duration > 0 and not ScreamUp then
					texture = "Interface\\AddOns\\Serenity\\UI\\Scream-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\Scream-01";
				end
			end
		elseif spellNumber[i] == 14 then
			texture = "Interface\\AddOns\\Serenity\\UI\\MindControl-01";
			if SERENITY_SPELL_TABLE[33].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[33].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\MindControl-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\MindControl-01";
				end
			end
		elseif spellNumber[i] == 15 then
			texture = "Interface\\AddOns\\Serenity\\UI\\MindSoothe-01";
			if SERENITY_SPELL_TABLE[35].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[35].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\MindSoothe-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\MindSoothe-01";
				end
			end
		elseif spellNumber[i] == 16 then
			texture = "Interface\\AddOns\\Serenity\\UI\\MindVision-01";
			if SERENITY_SPELL_TABLE[36].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[36].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\MindVision-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\MindVision-01";
				end
			end
		elseif spellNumber[i] == 17 then
			texture = "Interface\\AddOns\\Serenity\\UI\\ShackleUndead-01";
			if SERENITY_SPELL_TABLE[49].ID ~= nil then
				spellEnable = true;
				if SERENITY_SPELL_TABLE[49].Mana > mana then
					texture = "Interface\\AddOns\\Serenity\\UI\\ShackleUndead-03";
				elseif SerenityButtonTexture.Stones.Base[3+i] ~= 1 then
					texture = "Interface\\AddOns\\Serenity\\UI\\ShackleUndead-01";
				end
			end	
		else
			texture = "Interface\\AddOns\\Serenity\\UI\\Shard";			
			getglobal(spellButton[i]):Disable();
		end
		if spellEnable then
			getglobal(spellButton[i]):Enable()
		else
			texture = string.sub(texture, 1, string.len(texture)-1)..3;
			getglobal(spellButton[i]):Disable();
		end
		if SerenityButtonTexture.Stones.Base[3+i] ~= tonumber(string.sub(texture, string.len(texture)-1)) then
			getglobal(spellButton[i]):SetNormalTexture(texture);			
			SerenityButtonTexture.Stones.Base[3+i] = tonumber(string.sub(texture, string.len(texture)-1));
		end

	end
	if Serenity_SerenityReorderTexture[1] == nil or SerenityReorderRecheck then
		for i=1, 9, 1 do
			Serenity_SerenityReorderTexture[i] = tostring(getglobal(SerenityConfig.StoneLocation[i]):GetNormalTexture():GetTexture());			
		end
		SerenityReorderRecheck = false;
	end
	--		Serenity_ButtonTextUpdate()
end

function Serenity_UpdateBuffMenuIcons()
	-- Buff Menu Buttons
	-----------------------------------------------
	-- Coloration du bouton en grisé¡³i pas assez de mana
	local mana = UnitMana("player")
	local ManaSpell = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
	local ManaID = {38, 8, 51, 20, 23, 11, 9, 54, 59, 12, 19, 37, 53}
	
	for i=1, 13, 1 do
		if SERENITY_SPELL_TABLE[ManaID[i]].ID and ManaID[i] ~= 19 then
			if SERENITY_SPELL_TABLE[ManaID[i]].Mana > mana then
				ManaSpell[i] = 3;
			end
		end
	end
	
	if SERENITY_SPELL_TABLE[11].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[11].ID, "spell");
		if 	start > 0 and duration > 0 and not RacialUp then
			ManaSpell[6] = 3;
		else
			RacialUp = true			
		end
	end
	if SERENITY_SPELL_TABLE[9].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[9].ID, "spell");
		if start > 0 and duration > 0 and not RacialUp then
			ManaSpell[7] = 3;
		else
			RacialUp = true;
		end
	end
	if SERENITY_SPELL_TABLE[12].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[12].ID, "spell");
		if start > 0 and duration > 0 and not RacialUp then
			ManaSpell[10] = 3;
		else
			RacialUp = true;
		end
	end
	if SERENITY_SPELL_TABLE[19].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[19].ID, "spell");
		if start > 0 and duration > 0 and not FocusUp then
			ManaSpell[11] = 3;
		else
			FocusUp = true;
		end
	end
	if SERENITY_SPELL_TABLE[37].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[37].ID, "spell");
		if start > 0 and duration > 0 and not InfusionUp then
			ManaSpell[12] = 3;
		else
			InfusionUp = true;
		end
	end
	if Count.LightFeather <= 0 then ManaSpell[5] = 3; end
	if Shadowform then 
		SerenityBuffMenu13:LockHighlight();
	else
		SerenityBuffMenu13:UnlockHighlight();
	end
	for i=1, 13, 1 do
		if SerenityButtonTexture.Buffmenu.Base[i] ~= ManaSpell[i] then
			local texture = getglobal("SerenityBuffMenu"..i):GetNormalTexture():GetTexture()
			texture = string.sub(texture, 1, string.len(texture)-1)..ManaSpell[i];
			getglobal("SerenityBuffMenu"..i):SetNormalTexture(texture);
			SerenityButtonTexture.Buffmenu.Base[i] = ManaSpell[i];
		end
	end
	for i=1, 13, 1 do
		if SerenityButtonTexture.Buffmenu.Highlight[i] ~= SerenityConfig.Skin then
			getglobal("SerenityBuffMenu"..i):SetHighlightTexture("Interface\\Addons\\Serenity\\UI\\"..Skin[SerenityConfig.Skin].."\\BaseBuff-02");
			local texture = getglobal("SerenityBuffMenu"..i):GetHighlightTexture();
			texture:SetBlendMode("BLEND") -- use "ADD" for additive highlight 
			getglobal("SerenityBuffMenu"..i):SetHighlightTexture(texture)	
			SerenityButtonTexture.Buffmenu.Highlight[i] = SerenityConfig.Skin;
		end
	end
end

function Serenity_UpdateSpellMenuIcons()
	-- Spell Menu buttons
	-----------------------------------------------
	local mana = UnitMana("player")
	ManaSpell = {1, 1, 1, 1, 1, 1, 1, 1};
	ManaID = {10, 24, 48, 45, 33, 35, 38, 49}

	-- Grey the button if not enough Mana
	for i = 1, 8, 1 do
		if SERENITY_SPELL_TABLE[ManaID[i]].ID then
			if SERENITY_SPELL_TABLE[ManaID[i]].Mana > mana then
				ManaSpell[i] = 3;
			end
		end
	end

	-- Grey if it is on cooldown
	if SERENITY_SPELL_TABLE[45].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[45].ID, "spell");
		if start > 0 and duration > 0 and not ScreamUp then
			ManaSpell[4] = 3;
		else
			ScreamUp = true;
		end
	end
	if SERENITY_SPELL_TABLE[10].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[10].ID, "spell");
		if start > 0 and duration > 0 and not FadeUp then
			ManaSpell[1] = 3;
		end
	end
	if SERENITY_SPELL_TABLE[24].ID then
		start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[24].ID, "spell");
		if start > 0 and duration > 0 and not LightwellUp then
			ManaSpell[2] = 3;
		end
	end
	if Shadowform or PlayerCombat then ManaSpell[3] = 3; end
	-- Normal Texture
	for i=1, 8, 1 do
		if SerenityButtonTexture.Spellmenu.Base[i] ~= ManaSpell[i] then
			local texture = getglobal("SerenitySpellMenu"..i):GetNormalTexture():GetTexture()
			texture = string.sub(texture, 1, string.len(texture)-1)..ManaSpell[i];
			getglobal("SerenitySpellMenu"..i):SetNormalTexture(texture);
			SerenityButtonTexture.Spellmenu.Base[i] = ManaSpell[i];
		end
	end	
	-- Highlight Texture
	for i=1, 8, 1 do
		if SerenityButtonTexture.Spellmenu.Highlight[i] ~= SerenityConfig.Skin then
			getglobal("SerenitySpellMenu"..i):SetHighlightTexture("Interface\\Addons\\Serenity\\UI\\"..Skin[SerenityConfig.Skin].."\\BaseBuff-02");
			local texture = getglobal("SerenitySpellMenu"..i):GetHighlightTexture();
			texture:SetBlendMode("BLEND") -- use "ADD" for additive highlight 
			getglobal("SerenitySpellMenu"..i):SetHighlightTexture(texture)	
			SerenityButtonTexture.Spellmenu.Highlight[i] = SerenityConfig.Skin;
		end
	end
end

-- Allows User to sort Button Order

function SerenityReorder_OnLoad()
  SerenityReorder_Selected = 0
  SerenityReorder_UpdateOrder()
end


function SerenityReorder_OnClick()
  local id = this:GetID()
  if SerenityReorder_Selected == id then
    SerenityReorder_Selected = 0
  else
    SerenityReorder_Selected = id
  end
  SerenityReorder_UpdateOrder()
end

function SerenityReorder_ValidateButtons()
  SerenityReorderLeft:Disable()
  SerenityReorderRight:Disable()
  if SerenityReorder_Selected>1 then
    SerenityReorderLeft:Enable()
  end
  if SerenityReorder_Selected>0 and SerenityReorder_Selected<9 then
    SerenityReorderRight:Enable()
  end
end

function SerenityReorder_UpdateOrder()
  for i=1,9 do
    if SerenityReorder_Selected==i then
      getglobal("SerenityReorder"..i):LockHighlight()
    else
      getglobal("SerenityReorder"..i):UnlockHighlight()
    end
    getglobal("SerenityReorder"..i.."Icon"):SetTexture(Serenity_SerenityReorderTexture[i])
  end
  SerenityReorder_ValidateButtons()
end

-- moves SerenityReorder_Table entry from SerenityReorder_Select in dir direction (1 or -1)
function SerenityReorder_Move_OnClick(dir)
  local id = SerenityReorder_Selected
  local temp = Serenity_SerenityReorderTexture[id]
  local temp2 = SerenityConfig.StoneLocation[id]
  Serenity_SerenityReorderTexture[id] = Serenity_SerenityReorderTexture[id+dir]
  Serenity_SerenityReorderTexture[id+dir] = temp
  SerenityConfig.StoneLocation[id] = SerenityConfig.StoneLocation[id+dir]
  SerenityConfig.StoneLocation[id+dir] = temp2;
  SerenityReorder_Selected = SerenityReorder_Selected+dir
  SerenityReorder_UpdateOrder()
  Serenity_UpdateButtonsScale();
end

------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF STONES AND STUFF
------------------------------------------------------------------------------------------------------

-- T'AS QU'A SAVOIR OU T'AS MIS TES AFFAIRES !
function Serenity_ProvisionSetup()
	ProvisionSlotID = 1;
	for slot=1, table.getn(ProvisionSlot), 1 do
		table.remove(ProvisionSlot, slot);
	end
	for slot=1, GetContainerNumSlots(SerenityConfig.ProvisionContainer), 1 do
		table.insert(ProvisionSlot, nil);
	end
end


-- Function that looks for items to trade (Potion/drink
function Serenity_TradeExplore(type)
  	for container=0, 4, 1 do
	    for slot=1, GetContainerNumSlots(container), 1 do
			Serenity_MoneyToggle();
   			SerenityTooltip:SetBagItem(container, slot);
            local itemName = tostring(SerenityTooltipTextLeft1:GetText());
            _, _, locked = GetContainerItemInfo(container, slot);
			if itemName == type and not locked then
				PickupContainerItem(container, slot);
	        	if ( CursorHasItem() ) then  
	        		if SerenityTradeRequest then
	        			DropItemOnUnit("npc");
	        			break;
	        		else
	        			DropItemOnUnit("target");
	       				break;
					end
				end
			end
	    end
	end
end

-- checks an item to see if it is a mount
function Serenity_MountCheck(itemName, container, slot)
	if UnitLevel("player") < 40 then
		return;
	end
	if SerenityPrivate.AQ == true then
		if Serenity_AQMountCheck(itemName, container, slot) or Mount.AQMount then
			return;
		end
	end
	for icon=1, table.getn(SERENITY_MOUNT_TABLE), 1 do
		for i=1, table.getn(SERENITY_MOUNT_TABLE[icon]), 1 do
			if itemName == SERENITY_MOUNT_TABLE[icon][i] then
			   	Mount.Available = true;
			   	Mount.Name = SERENITY_MOUNT_TABLE[icon][i];
				Mount.Title = Mount.Name;
			   	for p=1, table.getn(SERENITY_MOUNT_PREFIX), 1 do
			   	    if strfind(Mount.Name, SERENITY_MOUNT_PREFIX[p]) then
				    	Mount.Title = strsub(Mount.Name, strlen(SERENITY_MOUNT_PREFIX[p])+1);
					end
			   	end
                Serenity_Msg("Mount Located: "..Mount.Title,"USER");
				if icon < 10 then
			   		Mount.Icon = "0"..icon;
			   	else
					Mount.Icon = icon;
			   	end
			   	Mount.Location = {container, slot}
			   	break;
			end
		end
	end	
end
-- Checks an item to see if it is an AQ mount
function Serenity_AQMountCheck(itemName, container, slot)
	for i=1, table.getn(SERENITY_AQMOUNT_TABLE), 1 do
		if itemName == SERENITY_AQMOUNT_TABLE[i] then
		   	Mount.Available = true;
		   	Mount.Name = SERENITY_AQMOUNT_TABLE[i];
			Mount.Title = SERENITY_AQMOUNT_NAME[i+1];
            Serenity_Msg("AQ Mount Located: "..Mount.Title,"USER");
			Mount.Icon = "A"..i;
		   	Mount.Location = {container, slot}
		   	Mount.AQMount = true;
		   	return true;
		end
	end
end
-- Checks an item to see if it is a potion
function Serenity_PotionCheck(itemName, container, slot)
	local found = false;
	for i=table.getn(SERENITY_MANA_POTION), 1, -1 do
		if itemName == SERENITY_MANA_POTION[i].Name then
			found = true;
			local _, ItemCount = GetContainerItemInfo(container, slot);
			if SERENITY_MANA_POTION[i].PvP and GetNumBattlefieldScores() <= 0 then
			-- Skip it
			else
				if i > Potion[1].RankID  and SERENITY_MANA_POTION[i].Level <= UnitLevel("player") then
					Count.ManaPotion = ItemCount;
					Potion[1].Name = SERENITY_MANA_POTION[i].Name;
					Potion[1].Level = SERENITY_MANA_POTION[i].Level;
					Potion[1].EnergyMin = SERENITY_MANA_POTION[i].EnergyMin;
					Potion[1].EnergyMax = SERENITY_MANA_POTION[i].EnergyMax;
					Potion[1].PvP = SERENITY_MANA_POTION[i].PvP;
					Potion[1].OnHand = true;
					Potion[1].Location = {container, slot};
					Potion[1].Mode = 2;
					Potion[1].RankID = i;
				elseif i == Potion[1].RankID then
					Count.ManaPotion = Count.ManaPotion + ItemCount;
				end
				break;
			end
		end
	end
	if not found then
		for i=table.getn(SERENITY_HEALING_POTION), 1, -1 do
			if itemName == SERENITY_HEALING_POTION[i].Name then
				found = true;
				local _, ItemCount = GetContainerItemInfo(container, slot);
				if SERENITY_HEALING_POTION[i].PvP and GetNumBattlefieldScores() <= 0 then
				-- Skip it
				else
					if i > Potion[2].RankID  and SERENITY_HEALING_POTION[i].Level <= UnitLevel("player") then
						Count.HealingPotion = ItemCount;
						Potion[2].Name = SERENITY_HEALING_POTION[i].Name;
						Potion[2].Level = SERENITY_HEALING_POTION[i].Level;
						Potion[2].EnergyMin = SERENITY_HEALING_POTION[i].EnergyMin;
						Potion[2].EnergyMax = SERENITY_HEALING_POTION[i].EnergyMax;
						Potion[2].PvP = SERENITY_HEALING_POTION[i].PvP;
						Potion[2].OnHand = true;
						Potion[2].OnHand = true;
						Potion[2].Location = {container, slot};
						Potion[2].Mode = 2;
						Potion[2].RankID = i;
					elseif i == Potion[2].RankID then	
						Count.HealingPotion = Count.HealingPotion + ItemCount;
					end
					break;
				end				
			end
		end
	end
end

--Check to see if an item is a drink
function Serenity_DrinkCheck(itemName, container, slot)
	local found = false;
	for i=table.getn(SERENITY_DRINK), 1, -1 do
		if itemName == SERENITY_DRINK[i].Name then
			found = true;
			local _, ItemCount = GetContainerItemInfo(container, slot);
			if i > Potion[3].RankID and SERENITY_DRINK[i].Level <= UnitLevel("player") then
				Count.Drink = ItemCount;
				Potion[3].Name = SERENITY_DRINK[i].Name;
				Potion[3].Level = SERENITY_DRINK[i].Level;
				Potion[3].Energy = SERENITY_DRINK[i].Energy;
				Potion[3].Length = SERENITY_DRINK[i].Length;
				Potion[3].Conjured = SERENITY_DRINK[i].Conjured;
				Potion[3].Onhand = true;
				Potion[3].Location = {container, slot};
				Potion[3].Mode = 2;
				Potion[3].RankID = i;
			elseif i == Potion[3].RankID then
				Count.Drink = Count.Drink + ItemCount;
			end
			break;
		end
	end
end
-- Funtion that inventories mage reagents: feathers, runes, powder, etc
function Serenity_BagExplore()
	local provision = Provision;
	Count.ManaPotion = 0;
	Count.HealingPotion = 0;
	Count.Drink = 0;
	Count.HolyCandle = 0;
	Count.SacredCandle = 0;
	Count.LightFeather = 0;
	HearthstoneOnHand = false;
	Serenity_PotionDefault();
	-- For each bag
	for container=0, 4, 1 do
		-- For each slot
		for slot=1, GetContainerNumSlots(container), 1 do
			Serenity_MoneyToggle();
			SerenityTooltip:SetBagItem(container, slot);
			local itemName = tostring(SerenityTooltipTextLeft1:GetText());
			-- If the bag is defined for provisions
			-- skip the value of the table whichr represents that bag slot (not the foodstuff)
			if (container == SerenityConfig.ProvisionContainer) then
				if itemName ~= PotionName and itemName ~= DrinkName then
					ProvisionSlot[slot] = nil;
				end
			end
			-- In the case of a nonempty slot
			if itemName ~= "nil" then
				-- Find the number of items in the slot
				local _, ItemCount = GetContainerItemInfo(container, slot);
				-- If it is a reagent, add it to the count
				if itemName == PotionName then Count.ManaPotion = Count.ManaPotion + ItemCount;
				elseif itemName == DrinkName then Count.Drink = Count.Drink + ItemCount;
--				elseif itemName == SERENITY_ITEM.ArcanePowder then Count.ArcanePowder = Count.ArcanePowder + ItemCount;
				elseif itemName == SERENITY_ITEM.LightFeather then Count.LightFeather = Count.LightFeather + ItemCount;
				elseif itemName == SERENITY_ITEM.HolyCandle then Count.HolyCandle = Count.HolyCandle + ItemCount;
				elseif itemName == SERENITY_ITEM.SacredCandle then Count.SacredCandle = Count.SacredCandle + ItemCount;
				-- Same thing for Potions
				elseif string.find(itemName, SERENITY_ITEM.Potion) or string.find(itemName, SERENITY_ITEM.Draught) then
					Serenity_PotionCheck(itemName, container, slot);
				-- Again for Drinks
				else
					for i=1, table.getn(SERENITY_DRINK_SRCH), 1 do
						if string.find(itemName, SERENITY_DRINK_SRCH[i]) then
							Serenity_DrinkCheck(itemName, container, slot);
							break;
						end
					end
				end
				-- Hearthstone
				if HearthstoneLocation == {container,slot} and itemName ~= SERENITY_ITEM.Hearthstone
				    or HearthstoneOnHand == false then
					if string.find(itemName, SERENITY_ITEM.Hearthstone) then
						HearthstoneOnHand = true;
						HearthstoneLocation = {container,slot};
					end
				end
				-- Mount
    			if Mount.Location[1] == container and Mount.Location[2] == slot and itemName ~= Mount.Name then
					Mount.Available = false;
				end
				if SerenityPrivate.AQ and not Mount.AQChecked and not Mount.AQMount then
					Mount.Available = false;
				end
				if not Mount.Available and not Mount.Checked then
				 	Serenity_MountCheck(itemName, container, slot);
				end
			end
		end
	end
	-- If there are more provisions than the defined bag can hold, warn the player
	if (Provision > provision and Provision == GetContainerNumSlots(SerenityConfig.ProvisionContainer)) then
		if (ProvisionsDestroy) then
			Serenity_Msg(SERENITY_MESSAGE.Bag.FullPrefix..GetBagName(SerenityConfig.SoulshardContainer)..SERENITY_MESSAGE.Bag.FullDestroySuffix);
		else
			Serenity_Msg(SERENITY_MESSAGE.Bag.FullPrefix..GetBagName(SerenityConfig.SoulshardContainer)..SERENITY_MESSAGE.Bag.FullSuffix);
		end
	end
	if SerenityPrivate.AQ then
		Mount.AQChecked = true;
	end
	Mount.Checked = true;
end

------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF SPELLS
------------------------------------------------------------------------------------------------------



-- Show or Hide the spell button to each new learned spell
function Serenity_ButtonSetup()
	if SerenityConfig.SerenityLockServ then
		Serenity_NoDrag();
		Serenity_UpdateButtonsScale();
	else
		HideUIPanel(SerenitySpellMenuButton);
		HideUIPanel(SerenityBuffMenuButton);
		HideUIPanel(SerenityMountButton);
		HideUIPanel(SerenityDispelButton);
		HideUIPanel(SerenityDrinkButton);
		HideUIPanel(SerenityPotionButton);
		HideUIPanel(SerenityMiddleSpellButton);
		HideUIPanel(SerenityLeftSpellButton);
		HideUIPanel(SerenityRightSpellButton);
		
        if SerenityConfig.StonePosition[1] then
			ShowUIPanel(SerenityDrinkButton);
		end
		if SerenityConfig.StonePosition[2] then
			ShowUIPanel(SerenityPotionButton);
		end
		if SerenityConfig.StonePosition[3] and 
			SERENITY_SPELL_TABLE[7].ID or SERENITY_SPELL_TABLE[1].ID or SERENITY_SPELL_TABLE[3].ID then
			ShowUIPanel(SerenityDispelButton);
		end
		if SerenityConfig.StonePosition[4] then
		    ShowUIPanel(SerenityLeftSpellButton);
		end
		if SerenityConfig.StonePosition[5] then
			ShowUIPanel(SerenityMiddleSpellButton);
		end		
		if SerenityConfig.StonePosition[6] then
		    ShowUIPanel(SerenityRightSpellButton);
		end		
		if SerenityConfig.StonePosition[7] and BuffMenuCreate ~= {} then
			ShowUIPanel(SerenityBuffMenuButton);
		end
		if SerenityConfig.StonePosition[8] then
			ShowUIPanel(SerenityMountButton);
		end
		if SerenityConfig.StonePosition[9] and SpellMenuCreate ~= {} then
			ShowUIPanel(SerenitySpellMenuButton);
		end
	end
end 

																

-- My favorite function! It makes the list of the spells known by the mage, and classifies them by rank
-- For the stones, it selects the highest rank
function Serenity_SpellSetup()
	Serenity_SpellTableBuild()	
	local CurrentStone = {
		ID = {},
		Name = {},
		subName = {}
	};

	local CurrentSpells = {
		ID = {},
		Name = {},
		subName = {}
	};
	
	local spellID = 1;
	local Invisible = 0;
	local InvisibleID = 0;

	-- Looks through all spells known by the mage
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL);
		if not spellName then
			do break end
		end
		-- For the spells with numbered ranks , compares for each spell ranks 1 to 1    
		-- The higher rank is preserved 
		if (string.find(subSpellName, SERENITY_TRANSLATION.Rank)) then
			local found = false;
			local _, _, rank = string.find(subSpellName, SERENITY_TRANSLATION.Rank .. " (.+)");
			rank = tonumber(rank);
			for index=1, table.getn(CurrentSpells.Name), 1 do
				if (CurrentSpells.Name[index] == spellName) then
			found = true;
					if (CurrentSpells.subName[index] < rank) then
						CurrentSpells.ID[index] = spellID;
						CurrentSpells.subName[index] = rank;
					end
					break;
				end
			end
			-- The largest ranks of each numbered spell with row are inserted in the table
			if (not found) then
				table.insert(CurrentSpells.ID, spellID);
				table.insert(CurrentSpells.Name, spellName);
				table.insert(CurrentSpells.subName, rank);
			end
		end
		spellID = spellID + 1;
	end

	-- Updates the list of the spells with the new ranks
	for spell=1, table.getn(SERENITY_SPELL_TABLE), 1 do
		for index = 1, table.getn(CurrentSpells.Name), 1 do
			if (SERENITY_SPELL_TABLE[spell].Name == CurrentSpells.Name[index])	then
					SERENITY_SPELL_TABLE[spell].ID = CurrentSpells.ID[index];
					SERENITY_SPELL_TABLE[spell].Rank = CurrentSpells.subName[index];
			end
   		end
	end


	for spellID=1, MAX_SPELLS, 1 do
        local spellName, subSpellName = GetSpellName(spellID, "spell");
		if (spellName) then
			for index=1, table.getn(SERENITY_SPELL_TABLE), 1 do
				if SERENITY_SPELL_TABLE[index].Name == spellName then
					Serenity_MoneyToggle();
					SerenityTooltip:SetSpell(spellID, 1);
					local _, _, ManaCost = string.find(SerenityTooltipTextLeft2:GetText(), "(%d+)");
					if not SERENITY_SPELL_TABLE[index].ID then
						SERENITY_SPELL_TABLE[index].ID = spellID;
					end
					SERENITY_SPELL_TABLE[index].Mana = tonumber(ManaCost);
				end
			end
		end
	end
	local _, _, _, _, rankSWP, _= GetTalentInfo(3,4) -- 2pt +3sec duration per point
	local _, _, _, _, rankScream, _= GetTalentInfo(3,6) -- 2pt -2sec cooldown per point
	local _, _, _, _, rankMindBlast, _= GetTalentInfo(3,7) -- 5pt -0.5sec cooldown per point
	local _, _, _, _, rankFade, _= GetTalentInfo(3,9) -- 2pt -3sec cooldown per point
	SERENITY_SPELL_TABLE[52].Length = SERENITY_SPELL_TABLE[52].Length + (rankSWP * 3)
	SERENITY_SPELL_TABLE[45].Length = SERENITY_SPELL_TABLE[45].Length - (rankScream * 2)
	SERENITY_SPELL_TABLE[32].Length = SERENITY_SPELL_TABLE[32].Length - (rankMindBlast * 0.5)
	SERENITY_SPELL_TABLE[10].Length = SERENITY_SPELL_TABLE[10].Length - (rankFade * 2)
	if UnitRace("player") == SERENITY_TRANSLATION.NightElf then
		SerenityRacialID = 9;
	elseif UnitRace("player") == SERENITY_TRANSLATION.Troll then
		SerenityRacialID = 54;
	elseif UnitRace("player") == SERENITY_TRANSLATION.Dwarf then
		SerenityRacialID = 11;
	elseif UnitRace("player") == SERENITY_TRANSLATION.Forsaken then
		SerenityRacialID = 59
	elseif UnitRace("player") == SERENITY_TRANSLATION.Human then
		SerenityRacialID = 12
	end
end

-- Function of extraction of attribute of spells
-- F(type=string, string, int) -> Spell=table
function Serenity_FindSpellAttribute(type, attribute, array)
	for index=1, table.getn(SERENITY_SPELL_TABLE), 1 do
		if string.find(SERENITY_SPELL_TABLE[index][type], attribute) then return SERENITY_SPELL_TABLE[index][array]; end
	end
	return nil;
end

-- Function to cast Shadowbolt with the Shadow Trance button
-- Needs to know the highest rank
--function Serenity_CastShadowbolt()
--	local spellID = Serenity_FindSpellAttribute("Name", SERENITY_NIGHTFALL.BoltName, "ID");
--	if (spellID) then
--		CastSpell(spellID, "spell");
--	else
--		Serenity_Msg(SERENITY_NIGHTFALL_TEXT.NoBoltSpell, "USER");
--	end
--end

------------------------------------------------------------------------------------------------------
-- OTHER FUNCTIONS
------------------------------------------------------------------------------------------------------

-- Update text on Serenity buttons
--[[function Serenity_ButtonTextUpdate()
	if SerenityConfig.PotionCooldownText then
		SerenityPotionCooldown:SetText(SerenityPrivate.PotionCooldownText);
	else
		SerenityPotionCooldown:SetText("");
	end
	if SerenityConfig.PotionCountText then
--		SerenityPotionCount:SetText(Count.ManaPotion);
	else
		SerenityPotionCount:SetText("");
	end
	if SerenityConfig.DrinkCountText then
		SerenityDrinkCount:SetText(Count.Drink);
	else
		SerenityDrinkCount:SetText("");
	end
	if SerenityConfig.FeatherCountText then
		SerenityFeatherCount:SetText(Count.LightFeather);
	else
		SerenityFeatherCount:SetText("");
	end
	if SerenityConfig.RuneCountText then
		SerenityTeleportCount1:SetText(Count.HolyCandle);
		SerenityTeleportCount2:SetText(Count.HolyCandle);
		SerenityTeleportCount3:SetText(Count.HolyCandle);
		SerenityTeleportCount4:SetText(Count.HolyCandle);
		SerenityTeleportCount5:SetText(Count.HolyCandle);
		SerenityTeleportCount6:SetText(Count.HolyCandle);
		SerenitySpellCount1:SetText(Count.SacredCandle);
		SerenitySpellCount2:SetText(Count.SacredCandle);
		SerenitySpellCount3:SetText(Count.SacredCandle);
		SerenitySpellCount4:SetText(Count.SacredCandle);
		SerenitySpellCount5:SetText(Count.SacredCandle);
		SerenitySpellCount6:SetText(Count.SacredCandle);
	else
		SerenityTeleportCount1:SetText("");
		SerenityTeleportCount2:SetText("");
		SerenityTeleportCount3:SetText("");
		SerenityTeleportCount4:SetText("");
		SerenityTeleportCount5:SetText("");
		SerenityTeleportCount6:SetText("");
		SerenitySpellCount1:SetText("");
		SerenitySpellCount2:SetText("");
		SerenitySpellCount3:SetText("");
		SerenitySpellCount4:SetText("");
		SerenitySpellCount5:SetText("");
		SerenitySpellCount6:SetText("");
		
	end	
end
]]--
-- Converts seconds into minutes:seconds
function Serenity_TimerFunction(seconde)
	local affiche, minute, time
	if seconde <= 59 then
		return tostring(floor(seconde));
	else
		minute = tostring(floor(seconde/60))
		seconde = mod(seconde, 60);
		if seconde < 10 then
			time = "0"..tostring(floor(seconde));
		else
			time = tostring(floor(seconde));
		end
		affiche = minute..":"..time;
		return affiche;
	end		
end

-- Casts Ice block if available.  Otherwise, attempts to cast cold snap.
function Serenity_ColdBlock()
 	start, duration = GetSpellCooldown(SERENITY_SPELL_TABLE[41].ID, BOOKTYPE_SPELL);
 	local cooldown = duration - (GetTime() - start);
	Serenity_Msg("cooldown: "..floor(cooldown), "USER");
	if (cooldown < 1.5) or (cooldown < 298 and cooldown > 290) then
        SpellStopCasting();
		CastSpell(SERENITY_SPELL_TABLE[41].ID, "spell");
 	else
		CastSpell(SERENITY_SPELL_TABLE[42].ID, "spell");
	end
end


function Nethaera_FrostyBolt(Clearcast,PI)
	if Clearcast then
		SpellStopCasting();
		CastSpell(SERENITY_SPELL_TABLE[5].ID, "spell");
 	elseif floor(( UnitHealth("player") or 1 ) / ( UnitHealthMax("player") or 1)*100) < 50 or PI
	 	and GetActionCooldown(41)==0 then
	 	CastSpellByName("Berserking") SpellStopCasting();
	end
end

-- Scans the players target, the player, and their party/raid for curses and removes the first one found.
function Serenity_Decursive(type)
	if IsAddOnLoaded("decursive") then
		Dcr_Clean()
	else
		local group, size, unit, afflicted, debuffDispelType, debuffName;
		if GetNumRaidMembers() > 0 then
			group = "raid";
			size = GetNumRaidMembers();
		else
			group = "party";
			size = GetNumPartyMembers();
		end
		for i=-1, size, 1 do
			-- If a target is found, stop searching
			if afflicted ~= nil then
				break;
			-- Check target first
			elseif i == -1 then
				if (UnitExists("target") and UnitIsFriend("player", "target") and UnitName("target") ~= UnitName("player")) then
					unit = "target";
				else
					unit = "player"
				end
			-- Check player next
			elseif i == 0 then
				unit = "player";
			-- Then check everyone else
			else
				unit = group..i;
			end
			for index=1, 16, 1 do
				_, _, debuffDispelType = UnitDebuff(unit, index);
				if debuffDispelType == type then
					if type ~= "Disease" or not Serenity_UnitHasBuff(unit, SERENITY_SPELL_TABLE[1].Name) then
						afflicted = unit;
						Serenity_MoneyToggle();
						SerenityTooltip:SetUnitDebuff(unit, index);
						debuffName = tostring(SerenityTooltipTextLeft1:GetText());
						break;
					end
				end
			end
		end
	
		if afflicted ~= nil then
			local targetChange;
			if UnitName(afflicted) ~= UnitName("target") then
				TargetUnit(afflicted);
				targetChange = true;
			end
			if type == "Magic" then
				CastSpell(SERENITY_SPELL_TABLE[7].ID, "spell");
				Serenity_Msg(Serenity_MsgAddColor(SERENITY_SPELL_TABLE[7].Name..": <darkBlue>"..UnitName("target").."<white> (<darkPurple1>"..debuffName.."<white>)"), "USER");
			else
				if SERENITY_SPELL_TABLE[1].ID then
					CastSpell(SERENITY_SPELL_TABLE[1].ID, "spell");
					Serenity_Msg(Serenity_MsgAddColor(SERENITY_SPELL_TABLE[1].Name..": <darkBlue>"..UnitName("target").."<white> (<lightGreen1>"..debuffName.."<white>)"), "USER");
				else
					CastSpell(SERENITY_SPELL_TABLE[3].ID, "spell");
					Serenity_Msg(Serenity_MsgAddColor(SERENITY_SPELL_TABLE[3].Name..": <darkBlue>"..UnitName("target").."<white> (<darkGreen>"..debuffName.."<white>)"), "USER");
				end
			end
			if targetChange then TargetLastTarget(); end
		else
			if type == "Magic" then
				CastSpell(SERENITY_SPELL_TABLE[7].ID, "spell");
			else
				Serenity_Msg("No "..type.." found", "USER");
			end 
		end
	end
end
-- Randomly choses which ShackleUndead spell to cast
function Serenity_Metamorph()
   	local morphs = {49, 48, 52};
   	local availableMorphs = {};
   	local spells = 0;
	for i=1, table.getn(morphs), 1 do
   		if SERENITY_SPELL_TABLE[morphs[i]].ID then
   			spells = spells + 1;
   			availableMorphs[spells] = morphs[i];
   		end
	end
   	CastSpell(SERENITY_SPELL_TABLE[availableMorphs[random(1,table.getn(availableMorphs))]].ID, "spell");
end

-- Function to know if a unit undergoes an effect 
-- F(string, string)->bool
function Serenity_UnitHasEffect(unit, effect)
	local index = 1;
	while UnitDebuff(unit, index) do
		Serenity_MoneyToggle();
		SerenityTooltip:SetUnitDebuff(unit, index);
		local DebuffName = tostring(SerenityTooltipTextLeft1:GetText());
   		if (string.find(DebuffName, effect)) then
			return true;
		end
		index = index+1;
	end
	return false;
end

-- Function to check the presence of a buff on the unit.
-- Strictly identical to UnitHasEffect, but as WoW distinguishes Buff and DeBuff, so we have to.
function Serenity_UnitHasBuff(unit, effect)
	local index = 1;
	while UnitBuff(unit, index) do
	-- Here we'll cheat a little. checking a buff or debuff return the internal spell name, and not the name we give at start
		-- So we use an API widget that will use the internal name to return the known name.
		-- For example, the "Curse of Agony" spell is internaly known as "Spell_Shadow_CurseOfSargeras". Much easier to use the first one than the internal one.
		Serenity_MoneyToggle();
		SerenityTooltip:SetUnitBuff(unit, index);
		local BuffName = tostring(SerenityTooltipTextLeft1:GetText());
   		if BuffName == effect then
			return true, index;
		end
		index = index+1;
	end
	return false;
end


-- Allows the player to get concentration
--function Serenity_UnitHasConcentration()
--	local ID = -1;
--	for buffID = 0, 24, 1 do
--		local buffTexture = GetPlayerBuffTexture(buffID);
--		if buffTexture == nil then break end
--		if strfind(buffTexture, "Spell_Shadow_Manaburn") then
--			ID = buffID;
--			break
--		end
--	end
--	ConcentrationID = ID;
--end

-- Function to manage the actions carried out by Serenity with the click on a button 
function Serenity_UseItem(type,button,keybind)
	local Ctrl = IsControlKeyDown();
	if Ctrl and keybind then Ctrl = not Ctrl; end
	-- Function to use a hearthstone in the inventory   
	-- If there is one in the inventory and you right-click
	if type == "Hearthstone" and button == "RightButton" then
		if (HearthstoneOnHand) then
			-- Use
			UseContainerItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		-- If there isn't one in the inventory and you right-click
		else
			Serenity_Msg(SERENITY_MESSAGE.Error.NoHearthStone, "USER");
		end
	-- If you click on  the Potion :
	elseif type == "Potion" then  
		local potionType = 1;
		if button == "RightButton" then
			potionType = 2;
		end
		if (UnitMana("player") == UnitManaMax("player")) and potionType == 1 then   -- Max mana! Not going to waste it
			Serenity_Msg(SERENITY_MESSAGE.Error.FullMana, "USER");
		elseif (UnitHealth("player") == UnitHealthMax("player")) and potionType == 2 then   -- Max Health! Not going to waste it
			Serenity_Msg(SERENITY_MESSAGE.Error.FullHealth, "USER");
		else
			if Potion[potionType].OnHand then
			start, duration, enable = GetContainerItemCooldown(Potion[potionType].Location[1], Potion[potionType].Location[2]);
				if start > 0 and duration > 0 then
					Serenity_Msg(SERENITY_MESSAGE.Error.PotionCooldown, "USER");
				else
					SpellStopCasting();
					UseContainerItem(Potion[potionType].Location[1], Potion[potionType].Location[2]);
					if not string.find(Potion[potionType].Name, SERENITY_ITEM.Healthstone) then
						SerenityPrivate.PotionCooldown = 120;
					end
				end
			else
				if potionType == 1 then
					Serenity_Msg(SERENITY_MESSAGE.Error.NoManaPotionPresent, "USER");
				else
					Serenity_Msg(SERENITY_MESSAGE.Error.NoHealingPotionPresent, "USER");
				end
			end
		end
	-- Now for food
	elseif type == "Drink" and button == "LeftButton" and not Ctrl then
		if Count.Drink > 0 then
			if (UnitMana("player") == UnitManaMax("player")) then   -- Max mana! Not going to waste it
				Serenity_Msg(SERENITY_MESSAGE.Error.FullMana, "USER");
			else
				UseContainerItem(Potion[3].Location[1], Potion[3].Location[2]);
				SerenityPrivate.Sitting = true;
			end
		else
			Serenity_Msg(SERENITY_MESSAGE.Error.NoDrink, "USER");
		end
	-- Mount button
	elseif type == "Mount" and button == "LeftButton" then
		-- Soit c'est la monture épique
		if Mount.Available then
   			UseContainerItem(Mount.Location[1], Mount.Location[2]);
		-- Soit c'est la monture classique
		else
			Serenity_Msg(SERENITY_MESSAGE.Error.NoRiding, "USER");
			Mount.Checked = false;
			Serenity_BagExplore();
		end
	elseif type == "Mount" and button == "RightButton" then
	    if (HearthstoneOnHand) then
			-- Use
			UseContainerItem(HearthstoneLocation[1], HearthstoneLocation[2]);
			-- If there isn't one in the inventory and you right-click
		else
			Serenity_Msg(SERENITY_MESSAGE.Error.NoHearthStone, "USER");
		end
	end
-- 	Serenity_BagCheck("Update");
end

function Serenity_MoneyToggle()
	for index=1, 10 do
		local text = getglobal("SerenityTooltipTextLeft"..index);
			text:SetText(nil);
			text = getglobal("SerenityTooltipTextRight"..index);
			text:SetText(nil);
	end
	SerenityTooltip:Hide();
	SerenityTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
end

function Serenity_GameTooltip_ClearMoney()
    -- Intentionally empty; don't clear money while we use hidden tooltips
end


--Function to place the buttons around Serenity (and to grow/shrink the interface…) 
function Serenity_UpdateButtonsScale()
	local NBRScale = (100 + (SerenityConfig.SerenityButtonScale - 85)) / 100;
	if SerenityConfig.SerenityButtonScale <= SerenityConfig.SerenityStoneScale then
		NBRScale = 1.1;
	end
	if SerenityConfig.SerenityLockServ then
		Serenity_ClearAllPoints();
		HideUIPanel(SerenitySpellMenuButton);
		HideUIPanel(SerenityBuffMenuButton);
		HideUIPanel(SerenityMountButton);
		HideUIPanel(SerenityDispelButton);
		HideUIPanel(SerenityDrinkButton);
		HideUIPanel(SerenityPotionButton);
		HideUIPanel(SerenityMiddleSpellButton);
		HideUIPanel(SerenityLeftSpellButton);
		HideUIPanel(SerenityRightSpellButton);
		local dispelButton = false;
		if SERENITY_SPELL_TABLE[7].ID or SERENITY_SPELL_TABLE[1].ID or SERENITY_SPELL_TABLE[3].ID then
			dispelButton = true;
		end
		local indexScale = -18;
			for index=1, 9, 1 do
				if SerenityConfig.StonePosition[1] and SerenityConfig.StoneLocation[index] == "SerenityDrinkButton" then
					SerenityDrinkButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
                    SerenityDrinkButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityDrinkButton);
					indexScale = indexScale + 36;
				end
				if SerenityConfig.StonePosition[2] and SerenityConfig.StoneLocation[index] == "SerenityPotionButton" then
					SerenityPotionButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
					SerenityPotionButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityPotionButton);
					indexScale = indexScale + 36;
				end
				if SerenityConfig.StonePosition[3] and SerenityConfig.StoneLocation[index] == "SerenityDispelButton"  and dispelButton then
					SerenityDispelButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
					SerenityDispelButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityDispelButton);
					indexScale = indexScale + 36;
				end
				if SerenityConfig.StonePosition[4] and SerenityConfig.StoneLocation[index] == "SerenityLeftSpellButton" then
					SerenityLeftSpellButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
                    SerenityLeftSpellButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityLeftSpellButton);
					indexScale = indexScale + 36;
				end
				if SerenityConfig.StonePosition[5] and SerenityConfig.StoneLocation[index] == "SerenityMiddleSpellButton" then
					SerenityMiddleSpellButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
                    SerenityMiddleSpellButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityMiddleSpellButton);
					indexScale = indexScale + 36;
				end	
				if SerenityConfig.StonePosition[6] and SerenityConfig.StoneLocation[index] == "SerenityRightSpellButton" then
					SerenityRightSpellButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
                    SerenityRightSpellButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityRightSpellButton);
					indexScale = indexScale + 36;
				end
				if SerenityConfig.StonePosition[7] and SerenityConfig.StoneLocation[index] == "SerenityBuffMenuButton" and BuffMenuCreate ~= {} then
					SerenityBuffMenuButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
                    SerenityBuffMenuButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityBuffMenuButton);
					indexScale = indexScale + 36;
				end
				if SerenityConfig.StonePosition[8] and SerenityConfig.StoneLocation[index] == "SerenityMountButton" then
					SerenityMountButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
                    SerenityMountButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenityMountButton);
					indexScale = indexScale + 36;
				end
				if SerenityConfig.StonePosition[9] and SerenityConfig.StoneLocation[index] == "SerenitySpellMenuButton" and SpellMenuCreate ~= {} then
					SerenitySpellMenuButton:SetPoint("CENTER", "SerenityButton", "CENTER", ((40 * NBRScale) * cos(SerenityConfig.SerenityAngle-indexScale)), ((40 * NBRScale) * sin(SerenityConfig.SerenityAngle-indexScale)));
                    SerenitySpellMenuButton:SetScale(SerenityConfig.SerenityStoneScale / 100);
					ShowUIPanel(SerenitySpellMenuButton);
					indexScale = indexScale + 36;
				end
		end
	end
end 

-- breaks up slash command lines into a table
function MsgToTable(msg)
	if not msg then return end
 	local t = {};
 	for w in string.gfind( msg, "%S+" ) do
 		tinsert( t, w )
 	end
 	return t;
end
-- function to change the order of the buttons, via slash command (/seren order)
function Serenity_ButtonOrder(msg)
 	local arg = MsgToTable(msg)
 	local temploc;
	for i=1, 9, 1 do
		temploc = SerenityConfig.StoneLocation[i];
		SerenityConfig.StoneLocation[i] = tonumber(arg[i+1]);
		SerenityConfig.StoneLocation[tonumber(arg[i+1])] = i;
	end    	
	Serenity_UpdateButtonsScale();
end

-- Function (XML) to restore the buttons around the sphere
function Serenity_ClearAllPoints()
	SerenityPotionButton:ClearAllPoints();
	SerenityDrinkButton:ClearAllPoints();
	SerenityDispelButton:ClearAllPoints();
	SerenityLeftSpellButton:ClearAllPoints();
	SerenityMiddleSpellButton:ClearAllPoints();
	SerenityRightSpellButton:ClearAllPoints();
	SerenityMountButton:ClearAllPoints();
	SerenitySpellMenuButton:ClearAllPoints();
	SerenityBuffMenuButton:ClearAllPoints();
end

-- Function (XML) to extend the NoDrag property () principal button of Serenity on all its buttons 
function Serenity_NoDrag()
	SerenityPotionButton:RegisterForDrag("");
	SerenityDrinkButton:RegisterForDrag("");
	SerenityDispelButton:RegisterForDrag("");
	SerenityLeftSpellButton:RegisterForDrag("");
	SerenityMiddleSpellButton:RegisterForDrag("");
	SerenityRightSpellButton:RegisterForDrag("");
	SerenityMountButton:RegisterForDrag("");
	SerenitySpellMenuButton:RegisterForDrag("");
	SerenityBuffMenuButton:RegisterForDrag("");
end

-- Function (XML) opposite of above
function Serenity_Drag()
	SerenityPotionButton:RegisterForDrag("LeftButton");
	SerenityDrinkButton:RegisterForDrag("LeftButton");
	SerenityDispelButton:RegisterForDrag("LeftButton");
	SerenityLeftSpellButton:RegisterForDrag("LeftButton");
	SerenityMiddleSpellButton:RegisterForDrag("LeftButton");
	SerenityRightSpellButton:RegisterForDrag("LeftButton");
	SerenityMountButton:RegisterForDrag("LeftButton");
	SerenitySpellMenuButton:RegisterForDrag("LeftButton");
	SerenityBuffMenuButton:RegisterForDrag("LeftButton");
end

-- Opening of the buff menu
function Serenity_BuffMenu(button,keybind)
	if BuffMenuCreate[1] == nil then return; end
	local Ctrl = IsControlKeyDown();
	if Ctrl and keybind then Ctrl = not Ctrl; end
	if button == "RightButton" and SerenityPrivate.LastBuff ~= 0 then
		Serenity_SpellCast(SerenityPrivate.LastBuff);
		return;
	end
	SerenityPrivate.BuffMenuShow = not SerenityPrivate.BuffMenuShow;
	if not SerenityPrivate.BuffMenuShow then
		SerenityPrivate.BuffShow = false;
		SerenityPrivate.BuffVisible = false;
		SerenityBuffMenuButton:UnlockHighlight();
		BuffMenuCreate[1]:ClearAllPoints();
		BuffMenuCreate[1]:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
		SerenityPrivate.AlphaBuffMenu = 1;
	else
		SerenityPrivate.BuffShow = true;
		SerenityBuffMenuButton:LockHighlight();
		-- If right click, the menu of buff remains open 
		if button == "MiddleButton" or Ctrl then
			SerenityPrivate.BuffVisible = true;
		end
		-- If there aren't any buffs, don't do anything
		if BuffMenuCreate == nil then
			return;
		end
		-- If not the icons are displayed
		SerenityBuffMenu1:SetAlpha(1);
		SerenityBuffMenu2:SetAlpha(1);
		SerenityBuffMenu3:SetAlpha(1);
		SerenityBuffMenu4:SetAlpha(1);
		SerenityBuffMenu5:SetAlpha(1);
		SerenityBuffMenu6:SetAlpha(1);
		SerenityBuffMenu7:SetAlpha(1);
		SerenityBuffMenu8:SetAlpha(1)
		SerenityBuffMenu9:SetAlpha(1)
		SerenityBuffMenu10:SetAlpha(1)
		SerenityBuffMenu11:SetAlpha(1)
		SerenityBuffMenu12:SetAlpha(1)
		SerenityBuffMenu13:SetAlpha(1)
		BuffMenuCreate[1]:ClearAllPoints();		
		BuffMenuCreate[1]:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31) , SerenityConfig.BuffMenuAnchor);
		SerenityPrivate.AlphaSpellVar = GetTime() + 3;
		SerenityPrivate.AlphaBuffVar = GetTime() + 6;
	end
end

-- Opening the Spell menu
function Serenity_SpellMenu(button)
	if button == "RightButton" and SerenityPrivate.LastSpell ~= 0 then
		Serenity_SpellCast(SerenityPrivate.LastSpell);
		return;
	end
	-- If they aren't any teleport spells dont do anything
	if SpellMenuCreate[1] == nil then
		return;
	end

	SerenityPrivate.SpellMenuShow = not SerenityPrivate.SpellMenuShow;
	if not SerenityPrivate.SpellMenuShow then
		SerenityPrivate.SpellShow = false;
		SerenityPrivate.SpellVisible = false;
		SerenitySpellMenuButton:UnlockHighlight();
		SpellMenuCreate[1]:ClearAllPoints();			
		SpellMenuCreate[1]:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);		
		SerenityPrivate.AlphaSpellMenu = 1;
	else
		SerenityPrivate.SpellShow = true;
		SerenitySpellMenuButton:LockHighlight();
		-- If right click, the Spell menu remains open 
		if button == "MiddleButton" or Ctrl then
			SerenityPrivate.SpellVisible = true;
		end
		-- Sinon on affiche les icones (on les déplace sur l'écran)
		SerenitySpellMenu1:SetAlpha(1);
		SerenitySpellMenu2:SetAlpha(1);
		SerenitySpellMenu3:SetAlpha(1);
		SerenitySpellMenu4:SetAlpha(1);
		SerenitySpellMenu5:SetAlpha(1);
		SerenitySpellMenu6:SetAlpha(1);
		SerenitySpellMenu7:SetAlpha(1);
		SerenitySpellMenu8:SetAlpha(1);
		SpellMenuCreate[1]:ClearAllPoints();		
		SpellMenuCreate[1]:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31) , SerenityConfig.SpellMenuAnchor);
		
		SerenityPrivate.AlphaSpellVar = GetTime() + 3;
	end
end

-- Whenever the spell book changes, when the mod loads, and when the menu is rotated eith the spell menus
function Serenity_CreateMenu()
	SpellMenuCreate = {};
	BuffMenuCreate = {};
	local menuVariable = nil;
	local SpellButtonPosition = 0;
	local BuffButtonPosition = 0;
	
	-- Hide Spell menu
	for i = 1, 8, 1 do
		menuVariable = getglobal("SerenitySpellMenu"..i);
		menuVariable:Hide();
	end
	-- Hide buff menu
	for i = 1, 13, 1 do
		menuVariable = getglobal("SerenityBuffMenu"..i);
		menuVariable:Hide();
	end
	-- Start placing Spells on the menu
	if SERENITY_SPELL_TABLE[10].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu1");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 1;
		table.insert(SpellMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[24].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu2");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 2;
		table.insert(SpellMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[48].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu3");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 3;
		table.insert(SpellMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[36].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu4");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 4;
		table.insert(SpellMenuCreate, menuVariable);
	end

	if SERENITY_SPELL_TABLE[33].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu5");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 5;
		table.insert(SpellMenuCreate, menuVariable);
	end
	
	if SERENITY_SPELL_TABLE[35].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu6");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 6;
		table.insert(SpellMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[36].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu7");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 7;
		table.insert(SpellMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[49].ID ~= nil then
		menuVariable = getglobal("SerenitySpellMenu8");
		menuVariable:ClearAllPoints();
		if SpellButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "SerenitySpellMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenitySpellMenu"..SpellButtonPosition, "CENTER", ((36 / SerenityConfig.SpellMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		SpellButtonPosition = 8;
		table.insert(SpellMenuCreate, menuVariable);
	end
	-- Now that all the buttons are placed the ones beside the others (out of the screen), the available ones are displayed
	for i = 1, table.getn(SpellMenuCreate), 1 do
		ShowUIPanel(SpellMenuCreate[i]);
	end

	-- If Ice Armor exists, it is posted on the buff menu
	if SERENITY_SPELL_TABLE[38].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu1");
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
		menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		BuffButtonPosition = 1;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[8].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu2");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 2;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[51].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu3");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 3;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[20].ID ~= nil or SERENITY_SPELL_TABLE[23].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu4");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 4;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[23].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu5");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 5;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[11].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu6");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 6;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[9].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu7");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 7;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[54].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu8");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 8;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[59].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu9");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 9;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[12].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu10");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 10;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[19].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu11");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 11;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[37].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu12");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 12;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if SERENITY_SPELL_TABLE[53].ID ~= nil then
		menuVariable = getglobal("SerenityBuffMenu13");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "SerenityBuffMenuButton", "CENTER", 3000, 3000);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		else
			menuVariable:SetPoint("CENTER", "SerenityBuffMenu"..BuffButtonPosition, "CENTER", ((36 / SerenityConfig.BuffMenuPos) * 31), 0);
			menuVariable:SetScale(SerenityConfig.SerenityStoneScale / 100);
		end
		BuffButtonPosition = 13;
		table.insert(BuffMenuCreate, menuVariable);
	end

	-- Now that all the buttons are placed the ones beside the others (out of the screen), the available ones are posted 
	for i = 1, table.getn(BuffMenuCreate), 1 do
		ShowUIPanel(BuffMenuCreate[i]);
	end
end


-- management of spell button casting
function Serenity_SpellButtonCast(side, click)
	local spell, type;
	if side == "Left" then 
		spell = SerenityConfig.LeftSpell;
	elseif side == "Middle" then
		spell = SerenityConfig.MiddleSpell;
	else 
		spell = SerenityConfig.RightSpell;
	end
	-- assign spell based on settings
	if spell == 1 then
		type = 38; -- Fortitude / Prayer of
	elseif spell == 2 then
		type = 8;  -- Divine Spirit / Prayer of
	elseif spell == 3 then
		type = 51; -- Shadow Protection / Prayer of
	elseif spell == 4 then
		type = 20; -- Inner Fire
	elseif spell == 5 then
		type = 23; -- Levitate
	elseif spell == 6 then
		type = SerenityRacialID; -- Racial Spell
	elseif spell == 7 then
		type = 19; -- Inner Focus
	elseif spell == 8 then
		type = 37; -- Power Infusion
	elseif spell == 9 then
		type = 53; -- Shadowform
	elseif spell == 10 then
		type = 10; -- Fade
	elseif spell == 11 then
		type = 24; -- Lightwell
	elseif spell == 12 then
		type = 48; -- Resurrection
	elseif spell == 13 then
		type = 45; -- Psychic Scream
	elseif spell == 14 then
		type = 33; -- Mind control
	elseif spell == 15 then
		type = 35; -- Mind Soothe
	elseif spell == 16 then
		type = 36; -- Mind Vision
	elseif spell == 17 then
		type = 49; -- Shackle Undead
	end
	Serenity_SpellCast(type, click, true);
end
-- management of buff menu casting
function Serenity_SpellCast(type, click, save)
    if SerenityPrivate.Sitting then
		DoEmote("stand");
	end
	local TargetEnemy = false;
	if not UnitIsFriend("player","target") or not UnitExists("target") or IsAltKeyDown() then
		if type ~= 33 and type ~= 35 and type ~= 36 and type ~= 49 then
			TargetUnit("player");
			TargetEnemy = true;
		end
	end
	-- If the mage has frost armor but not ice armor
	if click == "RightButton" then
		-- Fortitude or Prayer of Fortitude
		if type == 38 and SERENITY_SPELL_TABLE[41].ID ~= nil then
			type = 41;
			CastSpell(SERENITY_SPELL_TABLE[type].ID, "spell");
		-- Divine Spirit or Prayer of Spirit
		elseif type == 8 and SERENITY_SPELL_TABLE[44].ID ~= nil then
			type = 44;
			CastSpell(SERENITY_SPELL_TABLE[type].ID, "spell");
		-- Shadow protection or Prayer of Shadow protection
		elseif type == 51 and SERENITY_SPELL_TABLE[43].ID ~= nil then
			type = 43;
			CastSpell(SERENITY_SPELL_TABLE[type].ID, "spell");
		elseif type == 7 then
			Serenity_Decursive("Disease");
		else
			CastSpell(SERENITY_SPELL_TABLE[type].ID, "spell");
		end
	else
		-- Power Word: Fortitude, depending on target's level
		if type == 38 then
			for i=SERENITY_SPELL_TABLE[type].Rank, 1, -1 do
				if UnitLevel("target") >= (i * 12) - 22 then
					CastSpellByName(SERENITY_SPELL_TABLE[type].Name.."("..SERENITY_TRANSLATION.Rank.." "..i..")");
					break;
				end
			end
		-- Divine Spirit, depending on target's level
		elseif type == 8 then
			local success = false;
			for i=SERENITY_SPELL_TABLE[type].Rank, 1, -1 do 
				if UnitLevel("target") >= 8 + (i * 12) then
					CastSpellByName(SERENITY_SPELL_TABLE[type].Name.."("..SERENITY_TRANSLATION.Rank.." "..i..")");
					success = true;
					break;
				end
			end
			if not success then 
				Serenity_Msg(SERENITY_MESSAGE.Error.TargetLevelToLow, "USER");
			end
		-- Shadow Protection, depending on target's level
		elseif type == 51 then
			local success = false;
			for i=SERENITY_SPELL_TABLE[type].Rank, 1, -1 do
				if UnitLevel("target") >= 22 + (i * 8) then
					CastSpellByName(SERENITY_SPELL_TABLE[type].Name.."("..SERENITY_TRANSLATION.Rank.." "..i..")");
					success = true;
					break;
				end
			end			
			if not success then 
				Serenity_Msg(SERENITY_MESSAGE.Error.TargetLevelToLow, "USER");
			end
		-- Dispel magic, decursively
		elseif type == 7 then
			if not SERENITY_SPELL_TABLE[7].ID then
				Serenity_Decursive("Disease");
			else 
				Serenity_Decursive("Magic");
			end
		-- Abolish/Cure Disease, decursively
		elseif type == 1 then
			Serenity_Decursive("Disease");
		-- Levitate
		elseif type == 23 then
			if Count.LightFeather <= 0 then
				Serenity_Msg(SERENITY_MESSAGE.Error.LightFeatherNotPresent, "USER");
			else
				CastSpell(SERENITY_SPELL_TABLE[type].ID, "spell");
			end
		-- Shadowform
		elseif type == 53 then
			local ShadowformIndex;
			Shadowform, ShadowformIndex = Serenity_UnitHasBuff("player", SERENITY_SPELL_TABLE[type].Name)
			if Shadowform then
				if ShadowformIndex then
					Serenity_Msg(tostring(Shadowform)..ShadowformIndex,"USER");
					CancelPlayerBuff(ShadowformIndex-1);
				end
			else
				CastSpell(SERENITY_SPELL_TABLE[type].ID, "spell");
			end
		else
			CastSpell(SERENITY_SPELL_TABLE[type].ID, "spell");
		end
		if type ~= 1 and type ~= 7 and save ~= "none" then
			if save == "buff" then
				SerenityPrivate.LastBuff = type;
			elseif save == "spell" then
				SerenityPrivate.LastSpell = type;
			end
		end
	end
	if TargetEnemy then TargetLastTarget(); end
	SerenityPrivate.AlphaBuffMenu = 1;
	SerenityPrivate.AlphaBuffVar = GetTime() + 3;
end

-- Function allowing the display of the various pages of the config menu
function SerenityGeneralTab_OnClick(id)
	local TabName;
	for index=1, 5, 1 do
		TabName = getglobal("SerenityGeneralTab"..index);
		if index == id then
			TabName:SetChecked(1);
		else
			TabName:SetChecked(nil);
		end
	end
	if id == 1 then
		ShowUIPanel(SerenityInventoryMenu);
		HideUIPanel(SerenityMessageMenu);
		HideUIPanel(SerenityButtonMenu);
		HideUIPanel(SerenityTimerMenu);
		HideUIPanel(SerenityGraphOptionMenu);
		SerenityGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		SerenityGeneralPageText:SetText(SERENITY_CONFIGURATION.Menu1);
	elseif id == 2 then
		HideUIPanel(SerenityInventoryMenu);
		ShowUIPanel(SerenityMessageMenu);
		HideUIPanel(SerenityButtonMenu);
		HideUIPanel(SerenityTimerMenu);
		HideUIPanel(SerenityGraphOptionMenu);
		SerenityGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		SerenityGeneralPageText:SetText(SERENITY_CONFIGURATION.Menu2);
	elseif id == 3 then
		SerenityReorder_UpdateOrder()
		HideUIPanel(SerenityInventoryMenu);
		HideUIPanel(SerenityMessageMenu);
		ShowUIPanel(SerenityButtonMenu);
		HideUIPanel(SerenityTimerMenu);
		HideUIPanel(SerenityGraphOptionMenu);
		SerenityGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		SerenityGeneralPageText:SetText(SERENITY_CONFIGURATION.Menu3);
	elseif id == 4 then
		HideUIPanel(SerenityInventoryMenu);
		HideUIPanel(SerenityMessageMenu);
		HideUIPanel(SerenityButtonMenu);
		ShowUIPanel(SerenityTimerMenu);
		HideUIPanel(SerenityGraphOptionMenu);
		SerenityGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		SerenityGeneralPageText:SetText(SERENITY_CONFIGURATION.Menu4);
	elseif id == 5 then
		HideUIPanel(SerenityInventoryMenu);
		HideUIPanel(SerenityMessageMenu);
		HideUIPanel(SerenityButtonMenu);
		HideUIPanel(SerenityTimerMenu);
		ShowUIPanel(SerenityGraphOptionMenu);
		SerenityGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		SerenityGeneralPageText:SetText(SERENITY_CONFIGURATION.Menu5);
	end
end



-- Bon, pour pouvoir utiliser le Timer sur les sorts instants, j'ai été obligé de m'inspirer de Cosmos
-- Comme je ne voulais pas rendre le mod dépendant de Sea, j'ai repris ses fonctions
-- Apparemment, la version Stand-Alone de ShardTracker a fait pareil :) :)
Serenity_Hook = function (orig,new,type)
	if(not type) then type = "before"; end
	if(not Hx_Hooks) then Hx_Hooks = {}; end
	if(not Hx_Hooks[orig]) then
		Hx_Hooks[orig] = {}; Hx_Hooks[orig].before = {}; Hx_Hooks[orig].before.n = 0; Hx_Hooks[orig].after = {}; Hx_Hooks[orig].after.n = 0; Hx_Hooks[orig].hide = {}; Hx_Hooks[orig].hide.n = 0; Hx_Hooks[orig].replace = {}; Hx_Hooks[orig].replace.n = 0; Hx_Hooks[orig].orig = getglobal(orig);
	else
		for key,value in Hx_Hooks[orig][type] do if(value == getglobal(new)) then return; end end
	end
	Serenity_Push(Hx_Hooks[orig][type],getglobal(new)); setglobal(orig,function(...) Serenity_HookHandler(orig,arg); end);
end

Serenity_HookHandler = function (name,arg)
	local called = false; local continue = true; local retval;
	for key,value in Hx_Hooks[name].hide do
		if(type(value) == "function") then if(not value(unpack(arg))) then continue = false; end called = true; end
	end
	if(not continue) then return; end
	for key,value in Hx_Hooks[name].before do
		if(type(value) == "function") then value(unpack(arg)); called = true; end
	end
	continue = false;
	local replacedFunction = false;
	for key,value in Hx_Hooks[name].replace do
		if(type(value) == "function") then
			replacedFunction = true; if(value(unpack(arg))) then continue = true; end called = true;
		end
	end
	if(continue or (not replacedFunction)) then retval = Hx_Hooks[name].orig(unpack(arg)); end
	for key,value in Hx_Hooks[name].after do
		if(type(value) == "function") then value(unpack(arg)); called = true;end
	end
	if(not called) then setglobal(name,Hx_Hooks[name].orig); Hx_Hooks[name] = nil; end
	return retval;
end

function Serenity_Push (table,val)
	if(not table or not table.n) then return nil; end
	table.n = table.n+1;
	table[table.n] = val;
end

function Serenity_UseAction(id, number, onSelf)
	Serenity_MoneyToggle();
	SerenityTooltip:SetAction(id);
	local tip = tostring(SerenityTooltipTextLeft1:GetText());
	if tip then
		SpellCastName = tip;
		SpellTargetName = UnitName("target");
		if not SpellTargetName then
			SpellTargetName = "";
		end
		SpellTargetLevel = UnitLevel("target");
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end
	end
end

function Serenity_CastSpell(spellId, spellbookTabNum)
	local Name, Rank = GetSpellName(spellId, spellbookTabNum);
	if Rank ~= nil then
    		local _, _, Rank2 = string.find(Rank, "(%d+)");
        	SpellCastRank = tonumber(Rank2);
	end
	SpellCastName = Name;

	SpellTargetName = UnitName("target");
	if not SpellTargetName then
		SpellTargetName = "";
	end
	SpellTargetLevel = UnitLevel("target");
	if not SpellTargetLevel then
		SpellTargetLevel = "";
	end
end

function Serenity_CastSpellByName(Spell)
	local _, _, Name = string.find(Spell, "(.+)%(");
	local _, _, Rank = string.find(Spell, "([%d]+)");

	if Rank ~= nil then
    		local _, _, Rank2 = string.find(Rank, "(%d+)");
        	SpellCastRank = tonumber(Rank2);
	end

	if not Name then
		_, _, Name = string.find(Spell, "(.+)");
	end
	SpellCastName = Name;

	SpellTargetName = UnitName("target");
	if not SpellTargetName then
		SpellTargetName = "";
	end
	SpellTargetLevel = UnitLevel("target");
	if not SpellTargetLevel then
		SpellTargetLevel = "";
	end
end

function SerenityTimer(nom, duree)
	local Cible = UnitName("target");
	local Niveau = UnitLevel("target");
	local truc = 6;
	if not Cible then
		Cible = "";
		truc = 2;
	end
	if not Niveau then
		Niveau = "";
	end

	SpellGroup, SpellTimer, TimerTable = SerenityTimerX(nom, duree, truc, Cible, Niveau, SpellGroup, SpellTimer, TimerTable);
end

function SerenitySpellCast(name)
	if string.find(name, "coa") then
		SpellCastName = SERENITY_SPELL_TABLE[22].Name;
		SpellTargetName = UnitName("target");
		if not SpellTargetName then
			SpellTargetName = "";
		end
		SpellTargetLevel = UnitLevel("target");
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end
		CastSpell(SERENITY_SPELL_TABLE[22].ID, "spell");
	end	
end
