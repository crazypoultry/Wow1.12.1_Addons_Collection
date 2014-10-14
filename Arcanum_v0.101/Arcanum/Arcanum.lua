-------------------------------------------------------------------------------------------------------
-- Arcanum

-- Addon pour Mage inspiré du célébre Necrosis
-- Gestion des buffs, des portails et Compteur de Composants

-- Remerciements aux auteurs de Necrosis

-- Auteur Lenny415

-- Serveur:
-- Uliss, Nausicaa, Solcarlus, Thémys on Medivh EU
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------

-- FONCTIONS GENERALES EN RELATION AVEC LE FICHIER XML

------------------------------------------------------------------------------------------------------


Default_ArcanumConfig = {
	Version = ArcanumData.Version;
	ChatType = true;
	Tooltip = 1;
	PortalMessage = true;
    InsideDisplay = 1;
    Display = {true, --DisplayHearthstone
    true,--DisplayManaGem
    true,--DisplayEvocation
    true,--DisplayIceBlock
    true,--DisplayColdSnap
    true,--DisplayIntell
    true,--DisplayArmor
    true,--DisplayBandage
    };
    HealthColor = {
    r = 0,
    g = 1,
    b = 0,
    };
    ManaColor = {
    r = 0,
    g = 0,
    b = 1,
    };
    ButtonColor = {
    r = 0,
    g = 1,
    b = 1,
    };
    
    MinimapIcon = true;
    MinimapIconPos = 360;
    
    EvocationLimit = 20;
	LevelBuff = true;
    ConsumeFood =  "Right";
    RandMount =  false;
	
	ReagentSort = true;
	ReagentContainer = 3;
	ReagentBuy = true;
	Powder = 20;
	Teleport = 10;
	Portal = 10;
	
	InterfaceVersion = 1;
    BuffType = 0;
	BuffButton =  true;
	ArmorButton =  true;
	MagicButton =  true;
	PortalButton =  true;
	MountButton =  true;
	FoodButton =  true;
	WaterButton =  true;
	ManaGemButton =  true;
    LeftClick = 1;
    MiddleClick = 2;
    RightClick = 3;
    ButtonsOrder = {1,2,3,4,5,6,7,8,9,10};
    
	
    LastBuff = 4;
    LastArmor = 2;
    LastMagic = 7;
    LastPortal = 1;
    LastMount = 1;
    
	ArcanumLockServ = true;
	Toggle = true;
	NoDragAll = false;
	BuffMenuPos = "x";
	ArmorMenuPos = "x";
	MagicMenuPos = "x";
	PortalMenuPos = "x";
    MountMenuPos = "x";
    ArcanumButtonxPos = 550;
    ArcanumButtonyPos = 450;
	ArcanumButtonScale = 100;
	ArcanumAngle = 108;
	
	ArcanumLanguage = GetLocale();
}

-- Variables utilisés pour la gestion des composants
-- (principalement comptage)
local ArcanumArcanePowder = nil;
local ArcanumRuneOfTeleportation = nil;
local ArcanumRuneOfPortals = nil;
local ArcanumLightFeathers = nil;
local ReagentBought = false;

local LastItemsCount = nil;
local FoodLocationCount, WaterLocationCount;
local WaterCount = nil;
local WaterLocation = {nil,nil,nil};
local FoodCount = nil;
local FoodLocation = {nil,nil,nil};
local ManaGemCount = nil;
local ManaGemExists = {nil, nil, nil, nil};
local ManaGemLocation = {{nil,nil}, {nil,nil}, {nil,nil}, {nil,nil}};

local IceblockDone = false;
local IceblockWait = false;
local IceblockWaitTimer = nil;
local HearthstoneLocation = {nil,nil};
local MountLocation = {nil,nil};
local MountName = {nil};
local MountIcon = {nil};
local AQMountLocation = {nil,nil};
local AQMountName = {nil};
local AQMountIcon = {nil};
local MountAQ = nil;

local MerchantOpened = false;
local PlayerName, PlayerLevel = nil;
local Loaded = false;
local PlayerZone = nil;
local playerClass, englishClass = nil;

local TPMess = 0;
local RandMount = 0;
Dest = {"Darnassus", "Ironforge", "Stormwind", "Orgrimmar", "Thunder Bluff", "Undercity"};

-- Menus : Permet l'affichage des menus de buff...
local BuffShow = false;
local BuffMenuShow = false;
local ArmorShow = false;
local ArmorMenuShow = false;
local MagicShow = false;
local MagicMenuShow = false;
local PortalShow = false;
local PortalMenuShow = false;
local MountShow = false;
local MountMenuShow = false;

-- Menus : Permet la disparition progressive du menu des buffs (transparence)
local AlphaBuffMenu = 1;
local AlphaBuffVar = 0;
local BuffVisible = false;

-- Menus : Permet la disparition progressive du menu des armures (transparence)
local AlphaArmorMenu = 1;
local AlphaArmorVar = 0;
local ArmorVisible = false;

-- Menus : Permet la disparition progressive du menu des magies (transparence)
local AlphaMagicMenu = 1;
local AlphaMagicVar = 0;
local MagicVisible = false;

-- Menus : Permet la disparition progressive du menu des portails (transparence)
local AlphaPortalMenu = 1;
local AlphaPortalVar = 0;
local PortalVisible = false;

-- Menus : Permet la disparition progressive du menu des montures (transparence)
local AlphaMountMenu = 1;
local AlphaMountVar = 0;
local MountVisible = false;

local AlphaDisplay = 1;
local AlphaDisplayVar = 0;
local DisplayFadingLimit = 0;
local DisplayFadingWay = -1;

-- Liste des boutons disponible pour le démoniste dans chaque menu
local BuffMenuCreate = {};
local ArmorMenuCreate = {};
local MagicMenuCreate = {};
local PortalMenuCreate = {};
local MountMenuCreate = {};

local xBuffMenuPos = nil;
local xArmorMenuPos = nil;
local xMagicMenuPos = nil;
local xPortalMenuPos = nil;
local xMountMenuPos = nil;
local yBuffMenuPos = nil;
local yArmorMenuPos = nil;
local yMagicMenuPos = nil;
local yPortalMenuPos = nil;
local yMountMenuPos = nil;

local UIPath = "Interface\\AddOns\\Arcanum\\UI\\"
        
local ArcanumLeftButtonClick = {};
local ArcanumMiddleButtonClick = {};
local ArcanumRightButtonClick = {};
local ArcanumInsideDisplayClick = {};

local Buff_Minlvl = {1, 4, 17, 32, 46};
local Amplify_Minlvl = {18, 30, 42, 54};
local Dampen_Minlvl = {12, 24, 36, 48, 60};
local Water_Minlvl = {0, 5, 15, 25, 35, 45, 55};

local ArcanumTradeNB = 1;
local ArcanumTradeFoodNB = 1;
local ArcanumTradeWaterNB = 1;
local ArcanumTradeNow = false;
local ArcanumTradeOpened = false;
local ArcanumTradeAccept = false;
local ArcanumTradeAcceptT = 0;
local ArcanumTradeAcceptTimer = 1.5;

local IceblockReady = false;
local IceblockCounter = 0;

local SelectedOrderButton;

local ArcanumT = 0;
local ArcanumButtonDisplayT = 1;
local ArcanumButtonDisplayTimer = 10;
local ArcanumButtonDisplayValue = 1;
local ArcanumButtonDisplayImage = nil;
local ArcanumButtonDisplayFlashing = false;
local ArcanumButtonDisplayTexture;

local ArcanumButtonDisplayTexture = {nil, nil, nil, nil, nil, nil, nil, nil};
local CoolDown = {
    {nil, true, HearthstoneLocation[1], HearthstoneLocation[2]},
    {nil, true, ManaGemLocation[1][1], ManaGemLocation[1][2]},
    {nil, true, ARCANUM_SPELL_TABLE.ID[26], nil},
    {nil, true, ARCANUM_SPELL_TABLE.ID[32], nil},
    {nil, true, ARCANUM_SPELL_TABLE.ID[33], nil},
    {nil, true, ARCANUM_SPELL_TABLE.ID[26], nil},
    {nil, true, ARCANUM_SPELL_TABLE.ID[32], nil},
    {nil, true, ARCANUM_SPELL_TABLE.ID[33], nil},
    };
------------------------------------------------------------------------------------------------------

-- FONCTIONS DE L'INTERFACE

------------------------------------------------------------------------------------------------------

-- Fonction applique au chargement
function Arcanum_OnLoad()
	playerClass, englishClass = UnitClass("player");
	if englishClass == "MAGE" then
		this:RegisterForDrag("LeftButton");
		this:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp");
	
		-- Enregistrement des événements interceptés par ARCANUM
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
        this:RegisterEvent("PLAYER_LEAVING_WORLD");
        this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("SPELLCAST_START");
		this:RegisterEvent("SPELLCAST_FAILED");
		this:RegisterEvent("SPELLCAST_INTERRUPTED");
		this:RegisterEvent("SPELLCAST_STOP");
		this:RegisterEvent("LEARNED_SPELL_IN_TAB");
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
        this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
        this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		this:RegisterEvent("PLAYER_TARGET_CHANGED");
		this:RegisterEvent("TRADE_REQUEST");
		this:RegisterEvent("TRADE_REQUEST_CANCEL");
		this:RegisterEvent("TRADE_SHOW");
		this:RegisterEvent("TRADE_CLOSED");
        this:RegisterEvent("TRADE_ACCEPT_UPDATE");
        this:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
		this:RegisterEvent("MERCHANT_SHOW");
        this:RegisterEvent("MERCHANT_CLOSED");
		this:RegisterEvent("PLAYER_LEVEL_UP");

	
		-- Enregistrement des commandes console
		SlashCmdList["Arcanum"] = Arcanum_Slash;
		SLASH_Arcanum1 = "/arcanum";
		SLASH_Arcanum2 = "/arca";
	end
end

-- Fonction d'initialisation
function Arcanum_Initialize()
	if englishClass == "MAGE" then
		-- On charge (ou on créé) la configuration pour le joueur et on l'affiche sur la console
		if ArcanumConfig == nil or ArcanumConfig.Version ~= Default_ArcanumConfig.Version then
			ArcanumConfig = {};
			ArcanumConfig = Default_ArcanumConfig;
            if (ArcanumConfig.ArcanumLanguage == "enUS") or (ArcanumConfig.ArcanumLanguage == "enGB") then
                Arcanum_Localization_Dialog_En();
            elseif (ArcanumConfig.ArcanumLanguage == "deDE") then
                Arcanum_Localization_Dialog_De();
            else
                Arcanum_Localization_Dialog_Fr();
            end
			Arcanum_Msg(ARCANUM_MESSAGE.Interface.DefaultConfig, "USER");
			ArcanumButton:ClearAllPoints();
		else
            if (ArcanumConfig.ArcanumLanguage == "enUS") or (ArcanumConfig.ArcanumLanguage == "enGB") then
                Arcanum_Localization_Dialog_En();
            elseif (ArcanumConfig.ArcanumLanguage == "deDE") then
                Arcanum_Localization_Dialog_De();
            else
                Arcanum_Localization_Dialog_Fr();
            end
			Arcanum_Msg(ARCANUM_MESSAGE.Interface.UserConfig, "USER");
		end
		
		-- Recupertation du nom du joueur
		PlayerName = UnitName("player");
		PlayerLevel = UnitLevel("player");

        Arcanum_LoadConfig();
        
		-- Chargement des sorts du joueur
		Arcanum_SpellSetup();
        
        if ArcanumConfig.LastPortal == 1 then
            for i = 14, 19 do
                if ARCANUM_SPELL_TABLE.ID[i] ~= nil then
                    ArcanumConfig.LastPortal = i;
                    break;
                end
            end
        end
        if ARCANUM_SPELL_TABLE.ID[2] == nil then
            ArcanumConfig.LastArmor = 1;
        end
		
		--Chargements de l'UI et décompte des composants
		Arcanum_BagExplore();
		Arcanum_InitButtons();
		if (ArcanumConfig.ArcanumLockServ == false) then
			Arcanum_UpdateMenuPos();
		else
			Arcanum_UpdateButtonsScale();
		end

		Arcanum_ButtonSetup();
        Arcanum_LoadIcons();
        ArcanumMinimapButtonTexture:SetTexture(ARCANUM_SPELL_TABLE.Texture[4]);
        ArcanumMinimapButtonTexture2:SetTexture(UIPath.."ButtonCircle");
        ArcanumMinimapButtonTexture2:SetVertexColor(ArcanumConfig.ButtonColor.r, ArcanumConfig.ButtonColor.g, ArcanumConfig.ButtonColor.b);
        
        ArcanumButtonTexture:SetTexture(UIPath.."ArcanumN");
        ArcanumOrderButtonTexture:SetTexture(UIPath.."ArcanumN");
        ArcanumOrderButtonTexture2:SetTexture(UIPath.."Overlay");
        ArcanumButtonTexture3:SetTexture(UIPath.."Overlay");
        
		if ArcanumConfig.Toggle == false then
			Arcanum_HideUI();
			Arcanum_Msg(ARCANUM_MESSAGE.Interface.InitOff, "USER");
		else
			Arcanum_Msg(ARCANUM_MESSAGE.Interface.InitOn, "USER");
		end
	else
        ArcanumConfig = {};
		Arcanum_HideUI();
	end
end

-- Fonction permettant le dplacement d'lments de Arcanum sur l'écran
function Arcanum_OnDragStart(button)
	if (button == "ArcanumIcon") then GameTooltip:Hide(); end

	button:StartMoving();
end

-- Fonction arrêtant le déplacement d'éléments de ARCANUM sur l'écran
function Arcanum_OnDragStop(button)
	if (button == "ArcanumIcon") then Arcanum_BuildTooltip("OVERALL"); end
    button:StopMovingOrSizing();
end

-- Fonction lance  la mise  jour de l'interface (main) -- toutes les 0,1 secondes environ
function Arcanum_OnUpdate()
	--Si c'est la premiere update on initialize
	if Loaded == false then
		Arcanum_Initialize();
		Loaded = true;
	end

	if englishClass == "MAGE" then
        Arcanum_MenuFading();
        Arcanum_DisplayFading();
        ArcanumT =  ArcanumT + arg1;
        if ArcanumT >= ArcanumButtonDisplayT then
            ArcanumButtonDisplayT = ArcanumButtonDisplayT + 0.5;
            Arcanum_Cooldown();
            ArcanumButton_TextDisplay();
        end
        
        if ArcanumT >= ArcanumButtonDisplayTimer then
            ArcanumButton_ImageDisplay();
            ArcanumT = 0;
            ArcanumButtonDisplayT = 1;
        end
        
        if ArcanumTradeAccept == true then
            ArcanumTradeAcceptT = ArcanumTradeAcceptT + arg1
            if ArcanumTradeAcceptT > ArcanumTradeAcceptTimer then
                ArcanumTradeAccept = false
                AcceptTrade();
            end
        end
        
        if IceblockDone == true then
            IceblockCounter = IceblockCounter + arg1;
            if IceblockCounter >= 3 then
                IceblockReady = true;
                IceblockCounter = 0;
            end
        end
        
		-- On met  jour la localisation du joueur
		PlayerZone = GetRealZoneText();
	end
end

function Arcanum_OnEvent(event)
	if (not Loaded) or englishClass ~= "MAGE" then 
		return;
	end
    if (event == "PLAYER_ENTERING_WORLD") then
        this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("SPELLCAST_START");
		this:RegisterEvent("SPELLCAST_FAILED");
		this:RegisterEvent("SPELLCAST_INTERRUPTED");
		this:RegisterEvent("SPELLCAST_STOP");
		this:RegisterEvent("LEARNED_SPELL_IN_TAB");
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
        this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
        this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		this:RegisterEvent("PLAYER_TARGET_CHANGED");
		this:RegisterEvent("TRADE_REQUEST");
		this:RegisterEvent("TRADE_REQUEST_CANCEL");
		this:RegisterEvent("TRADE_SHOW");
		this:RegisterEvent("TRADE_CLOSED");
        this:RegisterEvent("TRADE_ACCEPT_UPDATE");
        this:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
		this:RegisterEvent("MERCHANT_SHOW");
        this:RegisterEvent("MERCHANT_CLOSED");
		this:RegisterEvent("PLAYER_LEVEL_UP");

    elseif (event == "PLAYER_LEAVING_WORLD") then
        this:UnregisterEvent("BAG_UPDATE");
		this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		this:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		this:UnregisterEvent("PLAYER_REGEN_DISABLED");
		this:UnregisterEvent("PLAYER_REGEN_ENABLED");
		this:UnregisterEvent("SPELLCAST_START");
		this:UnregisterEvent("SPELLCAST_FAILED");
		this:UnregisterEvent("SPELLCAST_INTERRUPTED");
		this:UnregisterEvent("SPELLCAST_STOP");
		this:UnregisterEvent("LEARNED_SPELL_IN_TAB");
		this:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
        this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
        this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		this:UnregisterEvent("PLAYER_TARGET_CHANGED");
		this:UnregisterEvent("TRADE_REQUEST");
		this:UnregisterEvent("TRADE_REQUEST_CANCEL");
		this:UnregisterEvent("TRADE_SHOW");
		this:UnregisterEvent("TRADE_CLOSED");
        this:UnregisterEvent("TRADE_ACCEPT_UPDATE");
        this:UnregisterEvent("TRADE_PLAYER_ITEM_CHANGED");
		this:UnregisterEvent("MERCHANT_SHOW");
        this:UnregisterEvent("MERCHANT_CLOSED");
		this:UnregisterEvent("PLAYER_LEVEL_UP");
    
  -- Changement de couleur suivant le mode Combat
    elseif (event == "PLAYER_REGEN_DISABLED") then
        Arcanum_CombatDisableIcons();
    elseif (event == "PLAYER_REGEN_ENABLED") then
        Arcanum_CombatEnableIcons();
    -- Si un nouveau sort est apris, on rafraichie le tableau des sorts
    elseif (event == "LEARNED_SPELL_IN_TAB") then
        Arcanum_SpellSetup();
        Arcanum_ButtonSetup();
        Arcanum_CreateMenu();
        Arcanum_LoadIcons();
    -- Gestion de la fin de l'incantation des sorts
    elseif (event == "SPELLCAST_STOP") then
        Arcanum_SpellManagement();
    -- Quand le mage commence  incanter un sort, on intercepte le nom de celui-ci
    -- On sauve également le nom de la cible du sort ainsi que son niveau
    elseif (event == "SPELLCAST_START") then
        SpellCastName = arg1;
        SpellTargetName = UnitName("target");
        if not SpellTargetName then
            SpellTargetName = "";
        end
        SpellTargetLevel = UnitLevel("target");
        if not SpellTargetLevel then
            SpellTargetLevel = "";
        end
    -- Quand le mage stoppe son incantation, on relache le nom de celui-ci
    elseif (event == "SPELLCAST_FAILED") or (event == "SPELLCAST_INTERRUPTED") then
        SpellCastName = nil;
        SpellCastRank = nil;
        SpellTargetName = nil;
        SpellTargetLevel = nil;
    elseif event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" then
        
    elseif event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" then

    elseif event == "TRADE_REQUEST" or event == "TRADE_SHOW" then
        if ArcanumTradeNow == true then
            Arcanum_Trade();
            ArcanumTradeOpened = true;
            ArcanumTradeAcceptT = 0;
            ArcanumtTradeAccept = true;
            ArcanumTradeNow = false;
        end
    elseif event == "TRADE_REQUEST_CANCEL" or event == "TRADE_CLOSED" then
        ArcanumTradeNB = 1;
        ArcanumTradeFoodNB = 1;
        ArcanumTradeWaterNB = 1;
        ArcanumTradeOpened = false;
    elseif event=="TRADE_ACCEPT_UPDATE" then
    elseif event=="TRADE_PLAYER_ITEM_CHANGED" then
        ArcanumTradeNB = ArcanumTradeNB + 1;
    elseif (event == "BAG_UPDATE") then
        Arcanum_BagExplore();
        Arcanum_CreateMenu();
        Arcanum_LoadIconsV();
        Arcanum_EDIcons();
        if (ArcanumConfig.Powder > ArcanumArcanePowder or ArcanumConfig.Teleport > ArcanumRuneOfTeleportation or ArcanumConfig.Portal > ArcanumRuneOfPortals) then
            ReagentBought = false;
        end
    elseif (event == "MERCHANT_SHOW") then
        MerchantOpened = true;
        if ArcanumConfig.ReagentBuy == true then
            if ReagentBought == false then
                Arcanum_AutoBuy();
            end
        end
    elseif (event == "MERCHANT_CLOSED") then
        MerchantOpened = false;
    elseif (event == "PLAYER_LEVEL_UP") then
        PlayerLevel = UnitLevel("player");
    end
end

-- Gestion du clic sur Arcanum
-- Clique gauche: Passe Arcanum en mode buff Individuel/Classe
-- Clique droit: Pierre de Foyer

function Arcanum_OnClick(button)
    if (button == "LeftButton") then
	    Arcanum_Click(ArcanumConfig.LeftClick);
    elseif (button == "MiddleButton") then
        Arcanum_Click(ArcanumConfig.MiddleClick);
    elseif (button == "RightButton") then
        Arcanum_Click(ArcanumConfig.RightClick);
    end
end

-- Création et Affichage des bulles d'aides
function Arcanum_BuildTooltip(button, anchor, type)
	--on verifie que les aides sont activés
	if (ArcanumConfig.Tooltip == 1) then
		-- Definie à qui apartient la bulle d'aide
		GameTooltip:SetOwner(button, anchor);
		if (type == "Mount") then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TRANSLATION.Mounting.." "..MountName[ArcanumConfig.LastMount].."\n"..ARCANUM_MESSAGE.Tooltip.MiddleClick..ARCANUM_TRANSLATION.Hearth));
            if (CoolDown[1][1] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.Cooldown..CoolDown[1][1]));
			end
        elseif (type == "Buff") and ArcanumConfig.LastBuff ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastBuff].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastBuff]));
		elseif (type == "ArcaneIntellect") then
			GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[4]));
		elseif (type == "ArcaneBrilliance") then
			GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[5]));
		elseif (type == "Magic") and ArcanumConfig.LastMagic ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastMagic].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastMagic]));
		elseif (type == "AmplifyMagic") then
			GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[7]));
		elseif (type == "DampenMagic") then
			GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[6]));
		elseif (type == "Armor") and ArcanumConfig.LastArmor ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastArmor].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastArmor]));
		elseif (type == "FrostArmor") then
			if (ARCANUM_SPELL_TABLE.ID[2] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[2]));
			elseif (ARCANUM_SPELL_TABLE.ID[1] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[1]));
			end
		elseif (type == "MageArmor") then
			GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[3]));
		elseif (type == "Food") then
			GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[8]));
		elseif (type == "Water") then
			GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[9]));
		elseif (type == "ManaGem") then
			if (ARCANUM_SPELL_TABLE.ID[13] ~= nil and ManaGemExists[1] == false) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[13]));
			elseif (ARCANUM_SPELL_TABLE.ID[12] ~= nil and ManaGemExists[2] == false) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[12]));
			elseif (ARCANUM_SPELL_TABLE.ID[11] ~= nil and ManaGemExists[3] == false) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[11]));
			elseif (ARCANUM_SPELL_TABLE.ID[10] ~= nil and ManaGemExists[4] == false) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[10]));
			end
		elseif (type == "Portal") and ArcanumConfig.LastPortal ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastPortal].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastPortal]));
		elseif (type == "Teleport1") then
			if (ARCANUM_SPELL_TABLE.ID[14] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[14]));
			elseif (ARCANUM_SPELL_TABLE.ID[17] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[17]));
			end
		elseif (type == "Teleport2") then
			if (ARCANUM_SPELL_TABLE.ID[15] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[15]));
			elseif (ARCANUM_SPELL_TABLE.ID[18] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[18]));
			end   
		elseif (type == "Teleport3") then
			if (ARCANUM_SPELL_TABLE.ID[16] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[16]));
			elseif (ARCANUM_SPELL_TABLE.ID[19] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[19]));
			end
		elseif (type == "Portal1") then
			if (ARCANUM_SPELL_TABLE.ID[20] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[20]));
			elseif (ARCANUM_SPELL_TABLE.ID[23] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[23]));
			end
		elseif (type == "Portal2") then
			if (ARCANUM_SPELL_TABLE.ID[21] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[21]));
			elseif (ARCANUM_SPELL_TABLE.ID[24] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[24]));
			end
		elseif (type == "Portal3") then
			if (ARCANUM_SPELL_TABLE.ID[22] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[22]));
			elseif (ARCANUM_SPELL_TABLE.ID[25] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg("Mana : "..ARCANUM_SPELL_TABLE.Mana[25]));
			end
			-- Soit c'est le bouton principal
		elseif (type == "Main") then
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumArcanePowder).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.ArcanePowder));
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumRuneOfTeleportation).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.RuneOfTeleportation));
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumRuneOfPortals).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.RuneOfPortals));
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumLightFeathers).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.LightFeathers));
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.LeftClick..ARCANUM_CLICK[ArcanumConfig.LeftClick]));
            GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.MiddleClick..ARCANUM_CLICK[ArcanumConfig.MiddleClick]));
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.RightClick..ARCANUM_CLICK[ArcanumConfig.RightClick]));
        elseif (type == "Minimap") then
            GameTooltip:AddLine(Arcanum_ColoredMsg("Arcanum").."|CFFFFFFFF: ".."\n"..ARCANUM_MESSAGE.Tooltip.Minimap);
		elseif (type == "SpellTimer") then
            Arcanum_MoneyToggle();
            ArcanumTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2]);
            local itemName = tostring(ArcanumTooltipTextLeft5:GetText());
            GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA[type].Text));
            if string.find(itemName, ARCANUM_TRANSLATION.Cooldown) then
                GameTooltip:AddLine(Arcanum_MsgAddColor(ARCANUM_TRANSLATION.Hearth.." - "..itemName));
            else
                GameTooltip:AddLine(Arcanum_MsgAddColor(ARCANUM_TOOLTIP_DATA[type].Right..GetBindLocation()));
            end
        end
		-- On affiche
		GameTooltip:Show();
	
	elseif (ArcanumConfig.Tooltip == 2) then
		-- Definie  qui apartient la bulle d'aide
		GameTooltip:SetOwner(button, anchor);
		if (type == "Mount") then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TRANSLATION.Mounting.." "..MountName[ArcanumConfig.LastMount].."\n"..ARCANUM_MESSAGE.Tooltip.MiddleClick..ARCANUM_TRANSLATION.Hearth));
            if (CoolDown[1][1] ~= nil) then
				GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.Cooldown..CoolDown[1][1]));
			end
        elseif (type == "Buff") and ArcanumConfig.LastBuff ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastBuff].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastBuff]));
		elseif (type == "ArcaneIntellect") then
			GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[4],1);
		elseif (type == "ArcaneBrilliance") then
			GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[5],1);
		elseif (type == "Magic") and ArcanumConfig.LastMagic ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastMagic].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastMagic]));
		elseif (type == "AmplifyMagic") then
			GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[7],1);
		elseif (type == "DampenMagic") then
			GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[6],1);
		elseif (type == "Armor") and ArcanumConfig.LastArmor ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastArmor].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastArmor]));
		elseif (type == "FrostArmor") then
			if (ARCANUM_SPELL_TABLE.Mana[2] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[2],1);
			elseif (ARCANUM_SPELL_TABLE.Mana[1] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[1],1);
			end
		elseif (type == "MageArmor") then
			GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[3],1);
		elseif (type == "Food") then
			GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[8],1);
		elseif (type == "Water") then
			GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[9],1);
		elseif (type == "ManaGem") then
			if (ARCANUM_SPELL_TABLE.ID[13] ~= nil and ManaGemExists[1] == false) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[13],1);
			elseif (ARCANUM_SPELL_TABLE.ID[12] ~= nil and ManaGemExists[2] == false) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[12],1);
			elseif (ARCANUM_SPELL_TABLE.ID[11] ~= nil and ManaGemExists[3] == false) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[11],1);
			elseif (ARCANUM_SPELL_TABLE.ID[10] ~= nil and ManaGemExists[4] == false) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[10],1);
			end
		elseif (type == "Portal") and ArcanumConfig.LastPortal ~= 0 then
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA.LastSpell.."\n"..ARCANUM_SPELL_TABLE.Name[ArcanumConfig.LastPortal].."\nMana : "..ARCANUM_SPELL_TABLE.Mana[ArcanumConfig.LastPortal]));
		elseif (type == "Teleport1") then
			if (ARCANUM_SPELL_TABLE.ID[14] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[14],1);
			elseif (ARCANUM_SPELL_TABLE.ID[17] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[17],1);
			end
		elseif (type == "Teleport2") then
			if (ARCANUM_SPELL_TABLE.ID[15] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[15],1);
			elseif (ARCANUM_SPELL_TABLE.ID[18] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[18],1);
			end   
		elseif (type == "Teleport3") then
			if (ARCANUM_SPELL_TABLE.ID[16] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[16],1);
			elseif (ARCANUM_SPELL_TABLE.ID[19] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[19],1);
			end
		elseif (type == "Portal1") then
			if (ARCANUM_SPELL_TABLE.ID[20] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[20],1);
			elseif (ARCANUM_SPELL_TABLE.ID[23] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[23],1);
			end
		elseif (type == "Portal2") then
			if (ARCANUM_SPELL_TABLE.ID[21] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[21],1);
			elseif (ARCANUM_SPELL_TABLE.ID[24] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[24],1);
			end
		elseif (type == "Portal3") then
			if (ARCANUM_SPELL_TABLE.ID[22] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[22],1);
			elseif (ARCANUM_SPELL_TABLE.ID[25] ~= nil) then
				GameTooltip:SetSpell(ARCANUM_SPELL_TABLE.ID[25],1);
			end
		-- Soit c'est le bouton principal
		elseif (type == "Main") then
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumArcanePowder).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.ArcanePowder));
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumRuneOfTeleportation).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.RuneOfTeleportation));
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumRuneOfPortals).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.RuneOfPortals));
			GameTooltip:AddLine(Arcanum_MsgAddColor("<white>"..ArcanumLightFeathers).." "..Arcanum_ColoredMsg(ARCANUM_ITEM.LightFeathers));
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.LeftClick..ARCANUM_CLICK[ArcanumConfig.LeftClick]));
            GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.MiddleClick..ARCANUM_CLICK[ArcanumConfig.MiddleClick]));
			GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.RightClick..ARCANUM_CLICK[ArcanumConfig.RightClick]));
        elseif (type == "Minimap") then
            GameTooltip:AddLine("|CFF0050FFAr|CFF0080FFca|CFF00B0FFnum|CFFFFFFFF: ".."\n"..ARCANUM_MESSAGE.Tooltip.Minimap);
		elseif (type == "SpellTimer") then
            Arcanum_MoneyToggle();
            ArcanumTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2]);
            local itemName = tostring(ArcanumTooltipTextLeft5:GetText());
            GameTooltip:AddLine(Arcanum_ColoredMsg(ARCANUM_TOOLTIP_DATA[type].Text));
            if string.find(itemName, ARCANUM_TRANSLATION.Cooldown) then
                GameTooltip:AddLine(Arcanum_MsgAddColor(ARCANUM_TRANSLATION.Hearth.." - "..itemName));
            else
                GameTooltip:AddLine(Arcanum_MsgAddColor(ARCANUM_TOOLTIP_DATA[type].Right..GetBindLocation()));
            end
        end
		-- On affiche
		GameTooltip:Show();
	end
end

function Arcanum_CallToolTip(Id)
    ToolTipList = {
    {},
    {},
    {},
    {"Buff", "ArcaneIntellect", "ArcaneBrilliance"},
    {"Armor", "FrostArmor", "MageArmor"},
    {"Magic", "DampenMagic", "AmplifyMagic"},
    {},
    {"Portal", "Teleport1", "Portal1"}, 
    {nil, "Teleport2", "Portal2"},
    {nil, "Teleport3", "Portal3"},
    };
    if ArcanumConfig.InterfaceVersion == 1 then
        Arcanum_BuildTooltip(this,"ANCHOR_CURSOR",ToolTipList[Id][1]);
    else
        if ArcanumConfig.BuffType == 0 then
            Arcanum_BuildTooltip(this,"ANCHOR_CURSOR",ToolTipList[Id][2]);
        else
            Arcanum_BuildTooltip(this,"ANCHOR_CURSOR",ToolTipList[Id][3]);
        end
    end
end
------------------------------------------------------------------------------------------------------

-- FONCTIONS DE CHARGEMENT DE LA CONFIGURATION

------------------------------------------------------------------------------------------------------

function Arcanum_LoadConfig()
	if (ArcanumConfig.ChatType) then ArcanumChatType_Button:SetChecked(1); end
	if (ArcanumConfig.PortalMessage) then ArcanumPortalMessage_Button:SetChecked(1); end
    if (ArcanumConfig.Display[1]) then ArcanumDisplayHearthStone_Button:SetChecked(1); end
    if (ArcanumConfig.Display[2]) then ArcanumDisplayManaGem_Button:SetChecked(1); end
    if (ArcanumConfig.Display[3]) then ArcanumDisplayEvocation_Button:SetChecked(1); end
    if (ArcanumConfig.Display[4]) then ArcanumDisplayIceBlock_Button:SetChecked(1); end
    if (ArcanumConfig.Display[5]) then ArcanumDisplayColdSnap_Button:SetChecked(1); end
    if (ArcanumConfig.Display[6]) then ArcanumDisplayIntell_Button:SetChecked(1); end
    if (ArcanumConfig.Display[7]) then ArcanumDisplayArmor_Button:SetChecked(1); end
    if (ArcanumConfig.Display[8]) then ArcanumDisplayBandage_Button:SetChecked(1); end
	
	if (ArcanumConfig.Toggle) then ArcanumToggle_Button:SetChecked(1); end
	if (ArcanumConfig.NoDragAll) then
		ArcanumLock_Button:SetChecked(1);
		Arcanum_NoDrag();
		ArcanumButton:RegisterForDrag("");
	end
	if (ArcanumConfig.ArcanumLockServ) then ArcanumIconsLock_Button:SetChecked(1); end
	if (ArcanumConfig.BuffMenuPos == "y") then ArcanumBuffMenu_Button:SetChecked(1); end
	if (ArcanumConfig.ArmorMenuPos == "y") then ArcanumArmorMenu_Button:SetChecked(1); end
	if (ArcanumConfig.MagicMenuPos == "y") then ArcanumMagicMenu_Button:SetChecked(1); end
	if (ArcanumConfig.PortalMenuPos == "y") then ArcanumPortalMenu_Button:SetChecked(1); end
    if (ArcanumConfig.MountMenuPos == "y") then ArcanumMountMenu_Button:SetChecked(1); end
	
	if (ArcanumConfig.ReagentSort) then ArcanumReagentSort_Button:SetChecked(1); end
	if (ArcanumConfig.ReagentBuy) then ArcanumReagentBuy_Button:SetChecked(1); end
	
	if (ArcanumConfig.LevelBuff) then ArcanumLevelBuff_Button:SetChecked(1); end
    if ArcanumConfig.ConsumeFood == "Right" then
        ArcanumConsumeRightFood_Button:SetChecked(1);
    else
        ArcanumConsumeLeftFood_Button:SetChecked(1);
    end
    if (ArcanumConfig.RandMount) then ArcanumRandMount_Button:SetChecked(1); end
	
	if (ArcanumConfig.InterfaceVersion == 1)then
		ArcanumInterfaceVersion_Button:SetChecked(1);
	else
		ArcanumInterfaceVersion2_Button:SetChecked(1);
	end
	if (ArcanumConfig.BuffButton) then ArcanumBuffButton_Button:SetChecked(1); end
	if (ArcanumConfig.ArmorButton) then ArcanumArmorButton_Button:SetChecked(1); end
	if (ArcanumConfig.MagicButton) then ArcanumMagicButton_Button:SetChecked(1); end
	if (ArcanumConfig.PortalButton) then ArcanumPortalButton_Button:SetChecked(1); end
	if (ArcanumConfig.MountButton) then ArcanumMountButton_Button:SetChecked(1); end
	if (ArcanumConfig.FoodButton) then ArcanumFoodButton_Button:SetChecked(1); end
	if (ArcanumConfig.WaterButton) then ArcanumWaterButton_Button:SetChecked(1); end
	if (ArcanumConfig.ManaGemButton) then ArcanumManaGemButton_Button:SetChecked(1); end
    if (ArcanumConfig.MinimapIcon) then ArcanumMinimapIcon_Button:SetChecked(1); end
	
	if ArcanumConfig.ArcanumLanguage == "deDE" then
		ArcanumLanguage_Slider:SetValue(3);
	elseif ArcanumConfig.ArcanumLanguage == "enUS" then
		ArcanumLanguage_Slider:SetValue(2);
	else
		ArcanumLanguage_Slider:SetValue(1);
	end
	ArcanumLanguage_SliderText:SetText(Arcanum_ColoredMsg("Langue / Language / Sprache"));
	ArcanumLanguage_SliderLow:SetText("");
	ArcanumLanguage_SliderHigh:SetText("");
	
	-- Paramtères des glissières
	ArcanumTooltip_SliderText:SetText(Arcanum_ColoredMsg("Tooltips"));
	ArcanumTooltip_SliderLow:SetText("");
	ArcanumTooltip_SliderHigh:SetText("");
	ArcanumTooltip_Slider:SetValue(ArcanumConfig.Tooltip);
	
    ArcanumEvocationLimit_Slider:SetValue(ArcanumConfig.EvocationLimit);
    ArcanumEvocationLimit_SliderLow:SetText("0 %");
	ArcanumEvocationLimit_SliderHigh:SetText("100 %");
    
	ArcanumBag_Slider:SetValue(4 - ArcanumConfig.ReagentContainer);
	ArcanumBag_SliderLow:SetText("5");
	ArcanumBag_SliderHigh:SetText("1");
    ArcanumPowder_EditBox:SetTextColor(0,0.5,1);
	ArcanumPowder_EditBox:SetNumber(ArcanumConfig.Powder);
	ArcanumPowder_EditBox:SetNumeric(true);
    ArcanumTeleport_EditBox:SetTextColor(0,0.5,1);
	ArcanumTeleport_EditBox:SetNumber(ArcanumConfig.Teleport);
	ArcanumTeleport_EditBox:SetNumeric(true);
    ArcanumPortal_EditBox:SetTextColor(0,0.5,1);
	ArcanumPortal_EditBox:SetNumber(ArcanumConfig.Portal);
	ArcanumPortal_EditBox:SetNumeric(true);

	ArcanumButtonRotate_Slider:SetValue(ArcanumConfig.ArcanumAngle);
	ArcanumButtonRotate_SliderLow:SetText("0");
	ArcanumButtonRotate_SliderHigh:SetText("360");
	ArcanumButtonScale_Slider:SetValue(ArcanumConfig.ArcanumButtonScale);
	ArcanumButtonScale_SliderLow:SetText("50 %");
	ArcanumButtonScale_SliderHigh:SetText("150 %");
	ArcanumButton:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
    
    ArcanumMinimapRotate_Slider:SetValue(ArcanumConfig.MinimapIconPos);
    ArcanumMinimapRotate_SliderLow:SetText("0");
	ArcanumMinimapRotate_SliderHigh:SetText("360");
    
	if ArcanumConfig.NoDragAll then
		Arcanum_NoDrag();
		ArcanumButton:RegisterForDrag("");
	else
		Arcanum_Drag();
		ArcanumButton:RegisterForDrag("LeftButton");
	end
	Arcanum_LanguageInitialize();
end

function Arcanum_LanguageInitialize()
    ArcanumLocalization();
	-- Localisation du XML
	ArcanumVersion:SetText(Arcanum_ColoredMsg(ArcanumData.AppName).."|CFFFFFFFF "..ArcanumData.Version.." by "..ArcanumData.Author);
	
	ArcanumGeneralPageText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Menu1));
	ArcanumMessagePlayer_Section:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.MessageMenu1));
	ArcanumChatType_Option:SetText(ARCANUM_CONFIGURATION.ChatType);
	ArcanumPortalMessage_Option:SetText(ARCANUM_CONFIGURATION.PortalMessage);
    ArcanumButtonDisplay_Section:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ArcanumButtonDisplay));
    ArcanumInsideDisplayDD:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.InsideDisplay));
    ArcanumDisplayHearthStone_Option:SetText(ARCANUM_CONFIGURATION.DisplayHearthStone);
    ArcanumDisplayManaGem_Option:SetText(ARCANUM_CONFIGURATION.DisplayManaGem);
    ArcanumDisplayEvocation_Option:SetText(ARCANUM_CONFIGURATION.DisplayEvocation);
    ArcanumDisplayIceBlock_Option:SetText(ARCANUM_CONFIGURATION.DisplayIceBlock);
    ArcanumDisplayColdSnap_Option:SetText(ARCANUM_CONFIGURATION.DisplayColdSnap);
    ArcanumDisplayIntell_Option:SetText(ARCANUM_CONFIGURATION.DisplayIntell);
    ArcanumDisplayArmor_Option:SetText(ARCANUM_CONFIGURATION.DisplayArmor);
    ArcanumDisplayBandage_Option:SetText(ARCANUM_CONFIGURATION.DisplayBandage);
    ArcanumHealthColor_Button:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.HealthColor));
	ArcanumManaColor_Button:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ManaColor));
    ArcanumButtonColor_Button:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ButtonColor));
	
	ArcanumLevelBuff_Option:SetText(ARCANUM_CONFIGURATION.LevelBuff);
    ArcanumEvocationLimit_SliderText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.EvocationLimit));
    ArcanumConsumeLeftFood_Option:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ConsumeLeftFood));
    ArcanumConsumeRightFood_Option:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ConsumeRightFood));
    ArcanumRandMount_Option:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.RandMount));
	ArcanumDeleteFood_Button:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.DeleteFood));
	ArcanumDeleteWater_Button:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.DeleteWater));
	ArcanumDeleteManaGem_Button:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.DeleteManaGem));
	
	ArcanumReagentSort_Option:SetText(ARCANUM_CONFIGURATION.ReagentSort);
	ArcanumBag_SliderText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ReagentBag));
	ArcanumReagentBuy_Option:SetText(ARCANUM_CONFIGURATION.ReagentBuy);
	ArcanumReagent_Section:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Reagent));
	ArcanumPowder_Section:SetText(ARCANUM_CONFIGURATION.Powder);
	ArcanumTeleport_Section:SetText(ARCANUM_CONFIGURATION.Teleport);
	ArcanumPortal_Section:SetText(ARCANUM_CONFIGURATION.Portal);
	
	ArcanumToggle_Option:SetText(ARCANUM_CONFIGURATION.Toggle);
	ArcanumInterfaceVersion_Option:SetText(ARCANUM_CONFIGURATION.InterfaceVersion);
	ArcanumInterfaceVersion2_Option:SetText(ARCANUM_CONFIGURATION.InterfaceVersion2);
	ArcanumLock_Option:SetText(ARCANUM_CONFIGURATION.Lock);
	ArcanumIconsLock_Option:SetText(ARCANUM_CONFIGURATION.IconsLock);
	ArcanumMenuPosition_Section:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.MenuPosition));
	ArcanumBuffMenu_Option:SetText(ARCANUM_CONFIGURATION.BuffMenu);
	ArcanumArmorMenu_Option:SetText(ARCANUM_CONFIGURATION.ArmorMenu);
	ArcanumMagicMenu_Option:SetText(ARCANUM_CONFIGURATION.MagicMenu);
	ArcanumPortalMenu_Option:SetText(ARCANUM_CONFIGURATION.PortalMenu);
    ArcanumMountMenu_Option:SetText(ARCANUM_CONFIGURATION.MountMenu);
	ArcanumButtonRotate_SliderText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ArcanumRotation));
	ArcanumButtonScale_SliderText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ArcanumSize));
	
    ArcanumButton_Option:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Button));
    ArcanumOrder_Option:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Order));
    ArcanumBuffButton_Option:SetText(ARCANUM_CONFIGURATION.BuffButton);
	ArcanumArmorButton_Option:SetText(ARCANUM_CONFIGURATION.ArmorButton);
	ArcanumMagicButton_Option:SetText(ARCANUM_CONFIGURATION.MagicButton);
	ArcanumPortalButton_Option:SetText(ARCANUM_CONFIGURATION.PortalButton);
	ArcanumMountButton_Option:SetText(ARCANUM_CONFIGURATION.MountButton);
	ArcanumFoodButton_Option:SetText(ARCANUM_CONFIGURATION.FoodButton);
	ArcanumWaterButton_Option:SetText(ARCANUM_CONFIGURATION.WaterButton);
    ArcanumMinimapIcon_Option:SetText(ARCANUM_CONFIGURATION.MinimapIcon);
	ArcanumManaGemButton_Option:SetText(ARCANUM_CONFIGURATION.ManaGemButton);
    ArcanumLeftClick:SetText(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.LeftClick));
    ArcanumMiddleClick:SetText(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.MiddleClick));
    ArcanumRightClick:SetText(Arcanum_ColoredMsg(ARCANUM_MESSAGE.Tooltip.RightClick));
    ArcanumMinimapRotate_SliderText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.ArcanumMinimapIconPos.." "..ArcanumConfig.MinimapIconPos.."°"));
    ClearTable(ArcanumLeftButtonClick);
    for i = 1, table.getn(ARCANUM_CLICK) do
        table.insert(ArcanumLeftButtonClick, ARCANUM_CLICK[i]);
    end
    ClearTable(ArcanumMiddleButtonClick);
    for i = 1, table.getn(ARCANUM_CLICK) do
        table.insert(ArcanumMiddleButtonClick, ARCANUM_CLICK[i]);
    end
    ClearTable(ArcanumRightButtonClick);
    for i = 1, table.getn(ARCANUM_CLICK) do
        table.insert(ArcanumRightButtonClick, ARCANUM_CLICK[i]);
    end
    ClearTable(ArcanumInsideDisplayClick);
    for i = 1, table.getn(ARCANUM_INSIDE_DISPLAY) do
        table.insert(ArcanumInsideDisplayClick, ARCANUM_INSIDE_DISPLAY[i]);
    end
    UIDropDownMenu_SetSelectedID(ArcanumLeftClickDropDown, ArcanumConfig.LeftClick);
    UIDropDownMenu_SetSelectedID(ArcanumMiddleClickDropDown, ArcanumConfig.MiddleClick);
    UIDropDownMenu_SetSelectedID(ArcanumRightClickDropDown, ArcanumConfig.RightClick);
    UIDropDownMenu_SetText(ARCANUM_CLICK[ArcanumConfig.LeftClick], ArcanumLeftClickDropDown);
    UIDropDownMenu_SetText(ARCANUM_CLICK[ArcanumConfig.MiddleClick], ArcanumMiddleClickDropDown);
    UIDropDownMenu_SetText(ARCANUM_CLICK[ArcanumConfig.RightClick], ArcanumRightClickDropDown);
    
    UIDropDownMenu_SetSelectedID(ArcanumInsideDisplayDropDown, ArcanumConfig.InsideDisplay);
    UIDropDownMenu_SetText(ARCANUM_INSIDE_DISPLAY[ArcanumConfig.InsideDisplay], ArcanumInsideDisplayDropDown);
end

------------------------------------------------------------------------------------------------------

-- FONCTIONS DE GESTION DES FENETRES DE CONFIGURATION

------------------------------------------------------------------------------------------------------

function ArcanumGeneralTab_OnClick(id)
	local TabName;
	for index = 1, 5, 1 do
		TabName = getglobal("ArcanumGeneralTab"..index);
		if index == id then
			TabName:SetChecked(1);
		else
			TabName:SetChecked(nil);
		end
	end
	if id == 1 then
		ShowUIPanel(ArcanumMessageMenu);
		HideUIPanel(ArcanumSpellsMenu);
		HideUIPanel(ArcanumReagentMenu);
		HideUIPanel(ArcanumGraphOptionMenu);
		HideUIPanel(ArcanumButtonOptionMenu);
        HideUIPanel(ArcanumTradeMenu);
		ArcanumGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		ArcanumGeneralPageText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Menu1));
	elseif id == 2 then
		HideUIPanel(ArcanumMessageMenu);
		ShowUIPanel(ArcanumSpellsMenu);
		HideUIPanel(ArcanumReagentMenu);
		HideUIPanel(ArcanumGraphOptionMenu);
		HideUIPanel(ArcanumButtonOptionMenu);
        HideUIPanel(ArcanumTradeMenu);
		ArcanumGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		ArcanumGeneralPageText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Menu2));
	elseif id == 3 then
		HideUIPanel(ArcanumMessageMenu);
		HideUIPanel(ArcanumSpellsMenu);
		ShowUIPanel(ArcanumReagentMenu);
		HideUIPanel(ArcanumGraphOptionMenu);
		HideUIPanel(ArcanumButtonOptionMenu);
        HideUIPanel(ArcanumTradeMenu);
		ArcanumGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		ArcanumGeneralPageText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Menu3));
	elseif id == 4 then
		HideUIPanel(ArcanumMessageMenu);
		HideUIPanel(ArcanumSpellsMenu);
		HideUIPanel(ArcanumReagentMenu);
		ShowUIPanel(ArcanumGraphOptionMenu);
		HideUIPanel(ArcanumButtonOptionMenu);
        HideUIPanel(ArcanumTimerMenu);
        HideUIPanel(ArcanumTradeMenu);
		ArcanumGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		ArcanumGeneralPageText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Menu4));
	elseif id == 5 then
		HideUIPanel(ArcanumMessageMenu);
		HideUIPanel(ArcanumSpellsMenu);
		HideUIPanel(ArcanumReagentMenu);
		HideUIPanel(ArcanumGraphOptionMenu);
		ShowUIPanel(ArcanumButtonOptionMenu);
        HideUIPanel(ArcanumTradeMenu);
		ArcanumGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		ArcanumGeneralPageText:SetText(Arcanum_ColoredMsg(ARCANUM_CONFIGURATION.Menu5));
	end
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE GESTION DES COMPOS A ACHETER

------------------------------------------------------------------------------------------------------
function Arcanum_AutoBuy()
	local ReagentCount = {ArcanumConfig.Powder - ArcanumArcanePowder, ArcanumConfig.Teleport - ArcanumRuneOfTeleportation, ArcanumConfig.Portal - ArcanumRuneOfPortals};
	local ReagentName = {ARCANUM_ITEM.ArcanePowder, ARCANUM_ITEM.RuneOfTeleportation, ARCANUM_ITEM.RuneOfPortals};
	local ReagentBuyCount = 0;
    if ARCANUM_SPELL_TABLE.ID[5] == nil then
        ReagentCount[1] = 0;
    end
    if (ARCANUM_SPELL_TABLE.ID[14] == nil and ARCANUM_SPELL_TABLE.ID[15] == nil and ARCANUM_SPELL_TABLE.ID[16] == nil) and (ARCANUM_SPELL_TABLE.ID[17] == nil and ARCANUM_SPELL_TABLE.ID[18] == nil and ARCANUM_SPELL_TABLE.ID[19] == nil) then
        ReagentCount[2] = 0;
    end
    if (ARCANUM_SPELL_TABLE.ID[20] == nil and ARCANUM_SPELL_TABLE.ID[21] == nil and ARCANUM_SPELL_TABLE.ID[22] == nil) and (ARCANUM_SPELL_TABLE.ID[23] == nil and ARCANUM_SPELL_TABLE.ID[24] == nil and ARCANUM_SPELL_TABLE.ID[25] == nil) then
        ReagentCount[3] = 0;
    end
    if ReagentCount[1] ~= 0 or ReagentCount[2] ~= 0 or ReagentCount[3] ~= 0 then
        local NumItems = GetMerchantNumItems()
        for j = 1, NumItems do
            for i = 1, 3 do
                local slotItemString = GetMerchantItemInfo(j)
                if slotItemString == ReagentName[i] and ReagentCount[i] > 0 then
                    Arcanum_Msg(ARCANUM_MESSAGE.Autobuy..ReagentCount[i].." "..ReagentName[i], "USER");
                    ReagentBuyCount = ReagentCount[i] / 10;
                    for k = 1, ReagentBuyCount do
                        BuyMerchantItem(j, 10);
                        ReagentCount[i] = ReagentCount[i] - 10;
                    end
                    if ReagentCount[i] > 0 then
                        BuyMerchantItem(j, ReagentCount[i]);
                        ReagentCount[i] = ReagentCount[i] - ReagentCount[i];
                    end
                    --CloseMerchant();
                    ReagentBought = true;
                end
            end
        end
        if ArcanumConfig.ReagentSort == true then
            Arcanum_ReagentSwitch();
        end
    end
end

function Arcanum_Trade()
    if UnitExists("target") and UnitIsFriend("player","target") and UnitIsPlayer("target") and not UnitIsUnit("player","target") then
        if (FoodCount > 0 or WaterCount > 0)  and ArcanumTradeNB <= 6 then
            if ArcanumTradeOpened == false then
                InitiateTrade("target");
            end
            Arcanum_FoodWaterSweep(UnitLevel("target"));
            local playerClass, englishClass = UnitClass("target");

            if englishClass ~= "WARRIOR" or englishClass ~= "ROGUE" then
                if table.getn(FoodLocation) >= ceil((ArcanumTradeNB) / 2) then
                    PickupContainerItem(FoodLocation[ceil((ArcanumTradeNB) / 2)][1], FoodLocation[ceil((ArcanumTradeNB) / 2)][2]);
                    if CursorHasItem() then
                        DropItemOnUnit("target");
                    end
                end
                if table.getn(WaterLocation) >= ceil((ArcanumTradeNB) / 2) then
                    PickupContainerItem(WaterLocation[ceil((ArcanumTradeNB) / 2)][1], WaterLocation[ceil((ArcanumTradeNB) / 2)][2]);
                    if CursorHasItem() then
                        DropItemOnUnit("target");
                    end
                end
            else
                PickupContainerItem(FoodLocation[ArcanumTradeNB][1], FoodLocation[ArcanumTradeNB][2]);
                if CursorHasItem() then
                    DropItemOnUnit("target");
                end
            end
            ArcanumTradeAcceptT = 0;
            ArcanumTradeAccept = true;
        end
    end
end

function ArcanumTradeFood()
    if UnitExists("target") and UnitIsFriend("player","target") and UnitIsPlayer("target") and not UnitIsUnit("player","target") then
        Arcanum_FoodWaterSweep(UnitLevel("target"));
        PickupContainerItem(FoodLocation[ArcanumTradeFoodNB][1], FoodLocation[ArcanumTradeFoodNB][2]);
        if CursorHasItem() then
            DropItemOnUnit("target");
        end
        ArcanumTradeAcceptT = 0;
        ArcanumTradeAccept = true;
        ArcanumTradeFoodNB = ArcanumTradeFoodNB + 1;
    end
end

function ArcanumTradeWater()
    if UnitExists("target") and UnitIsFriend("player","target") and UnitIsPlayer("target") and not UnitIsUnit("player","target") then
        Arcanum_FoodWaterSweep(UnitLevel("target"));
        PickupContainerItem(WaterLocation[ArcanumTradeWaterNB][1], WaterLocation[ArcanumTradeWaterNB][2]);
        if CursorHasItem() then
            DropItemOnUnit("target");
        end            
        ArcanumTradeAcceptT = 0;
        ArcanumTradeAccept = true;
        ArcanumTradeWaterNB = ArcanumTradeWaterNB + 1;
    end
end

function Arcanum_FoodWaterSweep(Level)

    local FoodLevel, WaterLevel;
    FoodLocationCount = 0;
    WaterLocationCount = 0;
    local FoodWaterLevel;
    
    for j = ARCANUM_SPELL_TABLE.Rank[8], 1, -1 do
        if Level >= Water_Minlvl[j] then
            FoodWaterLevel = j;
            break;
        end
    end

    ClearTable(FoodLocation);
    ClearTable(WaterLocation);
    for container = 0, 4, 1 do
        for slot = 1, GetContainerNumSlots(container), 1 do
            Arcanum_MoneyToggle();
            ArcanumTooltip:SetBagItem(container, slot);
            local itemName = ArcanumTooltipTextLeft1:GetText();
            if itemName == ARCANUM_FOOD[FoodWaterLevel] then
                local _, itemCount = GetContainerItemInfo(container, slot);
                table.insert(FoodLocation, {container, slot, itemCount});
                FoodLocationCount = FoodLocationCount + 1;
            elseif itemName == ARCANUM_WATER[FoodWaterLevel] then
                local _, itemCount = GetContainerItemInfo(container, slot);
                table.insert(WaterLocation, {container, slot, itemCount});
                WaterLocationCount = WaterLocationCount + 1;
            end
        end
    end
    if FoodLocationCount > 0 then
        for i = 1, FoodLocationCount - 1 do
            local j = i + 1;
            while FoodLocation[i][3] < 20 do
                FoodWaterSwitch(FoodLocation, i, j)
                j = j + 1;
            end
        end
    end
    if WaterLocationCount > 0 then
        for i = 1, WaterLocationCount - 1 do
            local j = i + 1;
            while WaterLocation[i][3] < 20 do
                FoodWaterSwitch(WaterLocation, i, j)
                j = j + 1;
            end
        end
    end
end

function FoodWaterSwitch(table, a, b)
    local _, itemCount = GetContainerItemInfo(table[b][1], table[b][2]);
    table[a][3] = itemCount;
    _, itemCount = GetContainerItemInfo(table[a][1], table[a][2]);
    table[b][3] = itemCount;
    PickupContainerItem(table[a][1], table[a][2]);
    PickupContainerItem(table[b][1], table[b][2]);
end
------------------------------------------------------------------------------------------------------

-- FONCTIONS DE GESTION DES SACS (LOCALISATION ET COMPTABILISATION DES COMPOSANTS, OBJETS INVOQUES)

------------------------------------------------------------------------------------------------------

-- destroy water, food and managem item
function Arcanum_DeleteItem(Type)
   	for container = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(container), 1 do
            if (Type == "Food") then
                for i = 1, table.getn(ARCANUM_FOOD) do
                    Arcanum_MoneyToggle();
			        ArcanumTooltip:SetBagItem(container, slot);
			        local itemName = ArcanumTooltipTextLeft1:GetText();
                    if (itemName == ARCANUM_FOOD[i]) then
                       PickupContainerItem(container, slot);
                        if (CursorHasItem()) then DeleteCursorItem(); end
                    end
                end
            elseif (Type == "Water") then
                for i = 1, table.getn(ARCANUM_WATER) do
                    Arcanum_MoneyToggle();
			        ArcanumTooltip:SetBagItem(container, slot);
			        local itemName = ArcanumTooltipTextLeft1:GetText();
                    if (itemName == ARCANUM_WATER[i]) then
                        PickupContainerItem(container, slot);
                        if (CursorHasItem()) then DeleteCursorItem(); end
                    end
                end
            else
                for i = 1, table.getn(ARCANUM_MANAGEM) do
                    Arcanum_MoneyToggle();
			        ArcanumTooltip:SetBagItem(container, slot);
			        local itemName = ArcanumTooltipTextLeft1:GetText();
                    if (itemName == ARCANUM_MANAGEM[i]) then
                        PickupContainerItem(container, slot);
                        if (CursorHasItem()) then DeleteCursorItem(); end
                    end
                end
            end
        end
    end
	
end

function Arcanum_ReagentSwitch()
	local offset = 0;
	for container = 0, 4, 1 do
		if (container ~= ArcanumConfig.ReagentContainer) then
			for slot = 1, GetContainerNumSlots(container), 1 do
				Arcanum_MoneyToggle();
				ArcanumTooltip:SetBagItem(container, slot);
				local itemInfo = tostring(ArcanumTooltipTextLeft1:GetText());
				if (itemInfo == ARCANUM_ITEM.ArcanePowder or itemInfo == ARCANUM_ITEM.RuneOfTeleportation or itemInfo == ARCANUM_ITEM.RuneOfPortals) then
					Arcanum_FindSlot(container, slot, offset);
					offset = offset + 1;
				end
			end
		end
	end
	-- Aprs avoir tout dplacer, il faut retrouver les emplacements des pierres, etc, etc...
	Arcanum_BagExplore();
end

-- Pendant le dplacement des fragments, il faut trouver un nouvel emplacement aux objets dplacs :)
function Arcanum_FindSlot(Index, Slot, offset)
	for slot = 1, GetContainerNumSlots(ArcanumConfig.ReagentContainer), 1 do
		Arcanum_MoneyToggle();
 		ArcanumTooltip:SetBagItem(ArcanumConfig.ReagentContainer, slot);
 		local itemInfo = tostring(ArcanumTooltipTextLeft1:GetText());
		if (itemInfo ~= ARCANUM_ITEM.ArcanePowder and itemInfo ~= ARCANUM_ITEM.RuneOfTeleportation and itemInfo ~= ARCANUM_ITEM.RuneOfPortals) then
			PickupContainerItem(Index, Slot);
			PickupContainerItem(ArcanumConfig.ReagentContainer, slot + offset);
			break;
		end
	end
end

function Arcanum_BagExplore()
	LastItemsCount = {ArcanumArcanePowder, ArcanumRuneOfTeleportation, ArcanumRuneOfPortals, ArcanumLightFeathers, FoodCount, WaterCount};
	ArcanumArcanePowder = 0;
	ArcanumRuneOfTeleportation = 0;
	ArcanumRuneOfPortals = 0;
	ArcanumLightFeathers = 0;
	ManaGemCount = 0;
	FoodCount = 0;
	WaterCount = 0;
	ManaGemExists = {false, false, false, false};
	ClearTable(FoodLocation);
	ClearTable(WaterLocation);
	MountLocation = {nil, nil};
	MountName = {nil};
	MountIcon = {nil};
	AQMountLocation = {nil, nil};
	AQMountName = {nil};
	AQMountIcon = {nil};
	for container = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(container), 1 do
			Arcanum_MoneyToggle();
			ArcanumTooltip:SetBagItem(container, slot);
			local itemName = ArcanumTooltipTextLeft1:GetText();
			if itemName then
				-- On prend le nombre d'item en stack sur le slot
				local texture, itemCount, locked, quality, readable = GetContainerItemInfo(container, slot);
				if itemName == ARCANUM_ITEM.Hearthstone then
                    ArcanumButtonDisplayTexture[1] = texture;
                    HearthstoneLocation = {container,slot}; 
                end
				if itemName == ARCANUM_ITEM.ArcanePowder then ArcanumArcanePowder = ArcanumArcanePowder + itemCount; end
				if itemName == ARCANUM_ITEM.RuneOfTeleportation then ArcanumRuneOfTeleportation = ArcanumRuneOfTeleportation + itemCount; end
				if itemName == ARCANUM_ITEM.RuneOfPortals  then ArcanumRuneOfPortals = ArcanumRuneOfPortals + itemCount; end
				if itemName == ARCANUM_ITEM.LightFeathers  then ArcanumLightFeathers = ArcanumLightFeathers + itemCount; end
				--Recherche de la monture
				for i = 1, table.getn(MOUNT), 1 do
					for j = 1, table.getn(MOUNT[i]), 1 do
						if (itemName == MOUNT[i][j]) then
							table.insert(MountLocation, {container,slot});
							table.insert(MountName, itemName);
							table.insert(MountIcon, texture);
							for k = 1, table.getn(MOUNT_PREFIX) do
								MountName[table.getn(MountName)] = string.gsub(MountName[table.getn(MountName)], MOUNT_PREFIX[k] , "");
							end
						end
					end
				end
				--Recherche de la monture qiraji
				for i = 1, table.getn(QIRAJ_MOUNT), 1 do
					if (itemName == QIRAJ_MOUNT[i]) then
                        table.insert(AQMountLocation, {container,slot});
                        table.insert(AQMountName, itemName);
                        table.insert(AQMountIcon, texture);
                        if quality == 5 then
                            table.insert(MountLocation, {container,slot});
                            table.insert(MountName, itemName);
                            table.insert(MountIcon, texture);
                            MountAQ = table.getn(AQMountLocation);
                        end
                        break;
                    end
				end
                
				--Recherche de la gemme de mana
				if (itemName == ARCANUM_MANAGEM[4]) then
					ManaGemLocation[1] = {container,slot};
					ManaGemExists[1] = true;
					ManaGemCount = ManaGemCount + 1;
				end
				if (itemName == ARCANUM_MANAGEM[3]) then
					ManaGemLocation[2] = {container,slot};
					ManaGemExists[2] = true;
					ManaGemCount = ManaGemCount + 1;
				end
				if (itemName == ARCANUM_MANAGEM[2]) then
					ManaGemLocation[3] = {container,slot};
					ManaGemExists[3] = true;
					ManaGemCount = ManaGemCount + 1;
				end
				if (itemName == ARCANUM_MANAGEM[1]) then
					ManaGemLocation[4] = {container,slot};
					ManaGemExists[4] = true;
					ManaGemCount = ManaGemCount + 1;
				end
				--Recherche du pain
				local rank = ARCANUM_SPELL_TABLE.Rank[8];
				if itemName == ARCANUM_FOOD[rank] then
					table.insert(FoodLocation, {container, slot, itemCount});
					FoodCount = FoodCount + itemCount;
				end
				--Recherche de l'eau
				local rank = ARCANUM_SPELL_TABLE.Rank[9];
				if itemName == ARCANUM_WATER[rank] then
					table.insert(WaterLocation, {container, slot,itemCount});
					WaterCount = WaterCount + itemCount;
 				end
			end
		end
	end
    for i = 1, table.getn(AQMountLocation) do
        if i ~= MountAQ then
            table.insert(MountLocation, {AQMountLocation[i][1],AQMountLocation[i][2]});
            table.insert(MountName, AQMountName[i]);
            table.insert(MountIcon, AQMountIcon[i]);
        end
    end
    if ArcanumConfig.LastMount > table.getn(MountLocation) and table.getn(MountLocation) > 0 then
        ArcanumConfig.LastMount = 1;
    elseif table.getn(MountLocation) == 0 then
        ArcanumConfig.LastMount = 0;
    end
end

function ClearTable(Table)
	for i = 0, table.getn(Table) do
		table.remove(Table)
	end
end

-- Fonction pour gérer les actions effectuées par Arcanum au clic sur un boutton
function Arcanum_UseItem(type,button)
    if MerchantOpened == false then
        -- Fonction pour utiliser une pierre de foyer dans l'inventaire
        if (type == "Hearthstone") then
            -- Trouve les items utilisés par Arcanum
            if (HearthstoneLocation[1] ~= nil) then
                -- on l'utilise
                UseContainerItem(HearthstoneLocation[1], HearthstoneLocation[2]);
            -- soit il n'y en a pas dans l'inventaire, on affiche un message d'erreur
            else
                Arcanum_Msg(ARCANUM_MESSAGE.Error.NoHearthstone, "USER");
            end
        end
        
        if (type == "Evocation") then
            if ARCANUM_SPELL_TABLE.ID[26] ~= nil then
                if (math.ceil(UnitMana("player") / UnitManaMax("player") * 100)) <= ArcanumConfig.EvocationLimit then
                    CastSpell(ARCANUM_SPELL_TABLE.ID[26], "spell");
                end
            end
        end
        
        if (type == "Iceblock") then
            if ARCANUM_SPELL_TABLE.ID[32] ~= nil then
                if IceblockDone == true and IceblockReady == true then
                    CastSpell(ARCANUM_SPELL_TABLE.ID[32], "spell");
                    IceblockDone = false;
                elseif IceblockDone == false then
                    if CoolDown[5][1] == nil then
                        SpellStopCasting();
                        CastSpell(ARCANUM_SPELL_TABLE.ID[32], "spell");
                        IceblockDone = true;
                    else
                        if ARCANUM_SPELL_TABLE.ID[33] ~= nil then
                            if CoolDown[4][1] == nil then
                                SpellStopCasting();
                                CastSpell(ARCANUM_SPELL_TABLE.ID[33], "spell");
                            end
                        end
                    end
                end
            end 
        end
            
        -- Si on clic sur le bouton de nourriture
        if (type == "Food") then
            if (button == "RightButton") then
                if (UnitExists("target") and UnitIsPlayer("target")) then
                    for i = ARCANUM_SPELL_TABLE.Rank[8], 1, -1 do
                        if UnitLevel("target") >= Water_Minlvl[i] then
                            local FoodName = ARCANUM_SPELL_TABLE.Name[8].."("..ARCANUM_TRANSLATION.Rank.." "..i..")";
                            CastSpellByName(FoodName, "spell");
                            break;
                        end
                    end
                else
                    CastSpell(ARCANUM_SPELL_TABLE.ID[8], "spell");
                end
            elseif (button == "LeftButton") then
                if FoodCount ~= 0 then
                    if ArcanumConfig.ConsumeFood == "Right" then
                        UseContainerItem(FoodLocation[1][1], FoodLocation[1][2]);
                    else
                        UseContainerItem(FoodLocation[table.getn(FoodLocation)][1], FoodLocation[table.getn(FoodLocation)][2]);
                    end
                end
            else
                ArcanumTradeFood();
            end
        end
    
        -- Si on clic sur le bouton d'eau
        if (type == "Water") then
            if (button == "RightButton") then
                if (UnitExists("target") and UnitIsPlayer("target")) then
                    for i = ARCANUM_SPELL_TABLE.Rank[9], 1, -1 do
                        if UnitLevel("target") >= Water_Minlvl[i] then
                            local WaterName = ARCANUM_SPELL_TABLE.Name[9].."("..ARCANUM_TRANSLATION.Rank.." "..i..")";
                            CastSpellByName(WaterName, "spell");
                            break;
                        end
                    end
                else
                    CastSpell(ARCANUM_SPELL_TABLE.ID[9], "spell");
                end
            elseif (button == "LeftButton") then
                if WaterCount ~= 0 then
                    if ArcanumConfig.ConsumeFood == "Right" then
                        UseContainerItem(WaterLocation[1][1], WaterLocation[1][2]);
                    else
                        UseContainerItem(WaterLocation[table.getn(WaterLocation)][1], WaterLocation[table.getn(WaterLocation)][2]);
                    end
                end
            else
                ArcanumTradeWater();
            end
        end
            
        -- Si on clic sur le bouton de la gemme de mana
        if (type == "ManaGem") then
            if (button == "RightButton") then
                if (ARCANUM_SPELL_TABLE.ID[13] ~= nil and ManaGemExists[1] == false) then
                    CastSpell(ARCANUM_SPELL_TABLE.ID[13], "spell");
                elseif (ARCANUM_SPELL_TABLE.ID[12] ~= nil and ManaGemExists[2] == false) then
                    CastSpell(ARCANUM_SPELL_TABLE.ID[12], "spell");
                elseif (ARCANUM_SPELL_TABLE.ID[11] ~= nil and ManaGemExists[3] == false) then
                    CastSpell(ARCANUM_SPELL_TABLE.ID[11], "spell");
                elseif (ARCANUM_SPELL_TABLE.ID[10] ~= nil and ManaGemExists[4] == false) then
                    CastSpell(ARCANUM_SPELL_TABLE.ID[10], "spell");
                end
            elseif (ManaGemExists[1] == true) then
                UseContainerItem(ManaGemLocation[1][1], ManaGemLocation[1][2]);
                ManaGemCount = ManaGemCount - 1;
            elseif (ManaGemExists[2] == true) then
                UseContainerItem(ManaGemLocation[2][1], ManaGemLocation[2][2]);
                ManaGemCount = ManaGemCount - 1;
            elseif (ManaGemExists[3] == true) then
                UseContainerItem(ManaGemLocation[3][1], ManaGemLocation[3][2]);
                ManaGemCount = ManaGemCount - 1;
            elseif (ManaGemExists[4] == true) then
                UseContainerItem(ManaGemLocation[4][1], ManaGemLocation[4][2]);
                ManaGemCount = ManaGemCount - 1;
            end
        end
    end
end

---------------------------------------------------------------------------------------------

-- FONCTIONS DE RECENSEMENT DES SORTS

---------------------------------------------------------------------------------------------

-- Créé la liste des sorts connus par le mage, et les classe par rangs.
function Arcanum_SpellSetup()
	
	local CurrentSpells = {
		ID = {},
		Name = {},
		subName = {},
	};
	
	local spellID = 1;
	local Invisible = 0;
	local InvisibleID = 0;

	-- On va parcourir tous les sorts possedés par le Mage
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL);
		if not spellName then
			do break end
		end

		if (spellName) then
			-- Pour les sorts avec des rangs numérotés, on compare pour chaque sort les rangs 1 à 1
			-- Le rang suprieur est conservé
			if (string.find(subSpellName, ARCANUM_TRANSLATION.Rank)) then
				local found = false;
				local rank = tonumber(strsub(subSpellName, 6, strlen(subSpellName)));
				for index=1, table.getn(CurrentSpells.Name), 1 do
					if string.find(CurrentSpells.Name[index],spellName) then
						found = true;
						if (CurrentSpells.subName[index] < rank) then
							CurrentSpells.ID[index] = spellID;
							CurrentSpells.subName[index] = rank;
						end
						break;
					end
				end
				-- Les plus grands rangs de chacun des sorts à rang numérotés sont insérés dans la table
				if (not found) then
					table.insert(CurrentSpells.ID, spellID);
					table.insert(CurrentSpells.Name, spellName);
					table.insert(CurrentSpells.subName, rank);
				end
			else
				table.insert(CurrentSpells.ID, spellID);
				table.insert(CurrentSpells.Name, spellName);
				table.insert(CurrentSpells.subName, 0);
			end
		end
		spellID = spellID + 1;
	end

	-- On met à jour la liste des sorts d'arcanum en fonction de la liste complete des sorts de mage
    for spell = 1, table.getn(ARCANUM_SPELL_TABLE.Name), 1 do
		for index = 1, table.getn(CurrentSpells.Name), 1 do
			if (CurrentSpells.Name[index] == ARCANUM_SPELL_TABLE.Name[spell]) then
				ARCANUM_SPELL_TABLE.ID[spell] = CurrentSpells.ID[index];
				ARCANUM_SPELL_TABLE.Rank[spell] = CurrentSpells.subName[index];
				ARCANUM_SPELL_TABLE.Mana[spell] = Arcanum_ManaCost(CurrentSpells.ID[index]);
                ARCANUM_SPELL_TABLE.Texture[spell] = GetSpellTexture(CurrentSpells.ID[index], BOOKTYPE_SPELL);
			end
		end
	end
    
    ArcanumButtonDisplayTexture = {
        ArcanumButtonDisplayTexture[1],
        ArcanumButtonDisplayTexture[2],
        ARCANUM_SPELL_TABLE.Texture[26],
        ARCANUM_SPELL_TABLE.Texture[32],
        ARCANUM_SPELL_TABLE.Texture[33],
        ARCANUM_SPELL_TABLE.Texture[4],
        ARCANUM_SPELL_TABLE.Texture[1],
        ARCANUM_SPELL_TABLE.Texture[34],
    };
end

function Arcanum_ManaCost(spellID)
	Arcanum_MoneyToggle();
	ArcanumTooltip:SetSpell(spellID,1);
	local _, _, ManaCost = string.find(ArcanumTooltipTextLeft2:GetText(), "(%d+)");
	Arcanum_MoneyToggle();
	return tonumber(ManaCost);
end

function Arcanum_MoneyToggle()
	for index=1, 10 do
		local text = getglobal("ArcanumTooltipTextLeft"..index);
		text:SetText(nil);
		text = getglobal("ArcanumTooltipTextRight"..index);
		text:SetText(nil);
	end
	ArcanumTooltip:Hide();
	ArcanumTooltip:SetOwner(WorldFrame, "ANCHOR_NONE"); 
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE GESTION DES COMMANDES SLASH

------------------------------------------------------------------------------------------------------

-- Gestion de la commande
function Arcanum_Slash(msg)
	if (ArcanumGeneralFrame:IsVisible()) then
		HideUIPanel(ArcanumGeneralFrame);
		return;
	else
		ShowUIPanel(ArcanumGeneralFrame);
		ArcanumGeneralTab_OnClick(1);
		return;
	end
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE GETION DE L'ICONE DE LA MINIMAP

------------------------------------------------------------------------------------------------------

function Arcanum_MinimapMoveButton()
	ArcanumMinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(ArcanumConfig.MinimapIconPos)), (80 * sin(ArcanumConfig.MinimapIconPos)) - 52);
end

function ArcanumIconDragging()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/Minimap:GetEffectiveScale()+70
	ypos = ypos/Minimap:GetEffectiveScale()-ymin-70

	ArcanumConfig.IconPos = math.deg(math.atan2(ypos,xpos))
	
    move_button();
end

function move_button()
    local xpos,ypos
	local angle = ArcanumConfig.IconPos or 0

	if ItemRack_Settings.SquareMinimap=="ON" then
		-- brute force method until trig solution figured out - min/max a point on a circle beyond square
		xpos = 110 * cos(angle)
		ypos = 110 * sin(angle)
		xpos = math.max(-82,math.min(xpos,84))
		ypos = math.max(-86,math.min(ypos,82))
	else
		xpos = 80*cos(angle)
		ypos = 80*sin(angle)
	end

	ArcanumMinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-xpos,ypos-52)
end

------------------------------------------------------------------------------------------------------

-- FONCTIONS DE GESTION DES BOUTONS DE L'UI

------------------------------------------------------------------------------------------------------

function Arcanum_ButtonSetup()
    if ArcanumConfig.Toggle == true then
        if ArcanumConfig.MinimapIcon == true then
            ShowUIPanel(ArcanumMinimapButton);
        else
            HideUIPanel(ArcanumMinimapButton);
        end
        if (ArcanumConfig.InterfaceVersion == 1) then
            Arcanum_ArcanumButtonSetup();
        else
            Arcanum_Arcanum2ButtonSetup();
        end
	end
end

function Arcanum_ArcanumButtonSetup()
    ShowUIPanel(ArcanumButton);
	if (ARCANUM_SPELL_TABLE.ID[8] ~= nil and ArcanumConfig.FoodButton == true) then
		ShowUIPanel(ArcanumButton1);
        ShowUIPanel(OrderButton1);
    else
        HideUIPanel(ArcanumButton1);
        HideUIPanel(OrderButton1);
	end
	if (ARCANUM_SPELL_TABLE.ID[9] ~=nil and ArcanumConfig.WaterButton == true) then
		ShowUIPanel(ArcanumButton2);
        ShowUIPanel(OrderButton2);
    else
        HideUIPanel(ArcanumButton2);
        HideUIPanel(OrderButton2);
	end
	if ((ARCANUM_SPELL_TABLE.ID[10] ~= nil or ARCANUM_SPELL_TABLE.ID[11] ~= nil or ARCANUM_SPELL_TABLE.ID[12] ~= nil or ARCANUM_SPELL_TABLE.ID[13] ~= nil) and ArcanumConfig.ManaGemButton == true) then
		ShowUIPanel(ArcanumButton3);
        ShowUIPanel(OrderButton3);
    else
        HideUIPanel(ArcanumButton3);
        HideUIPanel(OrderButton3);
	end
    if (table.getn(BuffMenuCreate) > 0 and ArcanumConfig.BuffButton == true) then
		ShowUIPanel(ArcanumButton4);
        ShowUIPanel(OrderButton4);
    else
        HideUIPanel(ArcanumButton4);
        HideUIPanel(OrderButton4);
	end
    if (table.getn(ArmorMenuCreate) > 0 and ArcanumConfig.ArmorButton == true) then
		ShowUIPanel(ArcanumButton5);
        ShowUIPanel(OrderButton5);
    else
        HideUIPanel(ArcanumButton5);
        HideUIPanel(OrderButton5);
	end
	if (table.getn(MagicMenuCreate) > 0 and ArcanumConfig.MagicButton == true) then
		ShowUIPanel(ArcanumButton6);
        ShowUIPanel(OrderButton6);
    else
        HideUIPanel(ArcanumButton6);
        HideUIPanel(OrderButton6);
	end
    if (table.getn(MountMenuCreate) > 0 and ArcanumConfig.MountButton == true) then
		ShowUIPanel(ArcanumButton7);
        ShowUIPanel(OrderButton7);
    else
        HideUIPanel(ArcanumButton7);
        HideUIPanel(OrderButton7);
	end
	if (table.getn(PortalMenuCreate) > 0 and ArcanumConfig.PortalButton == true) then
		ShowUIPanel(ArcanumButton8);
        ShowUIPanel(OrderButton8);
    else
        HideUIPanel(ArcanumButton8);
        HideUIPanel(OrderButton8);
	end
    HideUIPanel(ArcanumButton9);
    HideUIPanel(ArcanumButton10);
    HideUIPanel(OrderButton9);
    HideUIPanel(OrderButton10);
end

function Arcanum_Arcanum2ButtonSetup()
    ShowUIPanel(ArcanumButton);
	if (ARCANUM_SPELL_TABLE.ID[8] ~= nil and ArcanumConfig.FoodButton == true) then
        ShowUIPanel(ArcanumButton1);
        ShowUIPanel(OrderButton1);
    else
		HideUIPanel(ArcanumButton1);
        HideUIPanel(OrderButton1);
	end
	if (ARCANUM_SPELL_TABLE.ID[9] ~=nil and ArcanumConfig.WaterButton == true) then
        ShowUIPanel(ArcanumButton2);
        ShowUIPanel(OrderButton2);
    else
        HideUIPanel(ArcanumButton2);
        HideUIPanel(OrderButton2);
    end
	if ((ARCANUM_SPELL_TABLE.ID[10] ~= nil or ARCANUM_SPELL_TABLE.ID[11] ~= nil or ARCANUM_SPELL_TABLE.ID[12] ~= nil or ARCANUM_SPELL_TABLE.ID[13] ~= nil) and ArcanumConfig.ManaGemButton == true) then
        ShowUIPanel(ArcanumButton3);
        ShowUIPanel(OrderButton3);
    else
        HideUIPanel(ArcanumButton3);
        HideUIPanel(OrderButton3);
	end
	if (ArcanumConfig.LastMount ~= 0 and ArcanumConfig.MountButton == true) then
        ShowUIPanel(ArcanumButton7);
        ShowUIPanel(OrderButton7);
    else
        HideUIPanel(ArcanumButton7);
        HideUIPanel(OrderButton7);
	end
	if (ArcanumConfig.BuffType == 0) then
		if ((ARCANUM_SPELL_TABLE.ID[1] ~= nil or ARCANUM_SPELL_TABLE.ID[2] ~= nil) and ArcanumConfig.ArmorButton == true) then
            ShowUIPanel(ArcanumButton5);
            ShowUIPanel(OrderButton5);
        else
            HideUIPanel(ArcanumButton5);
            HideUIPanel(OrderButton5);
		end
		if (ARCANUM_SPELL_TABLE.ID[4] ~= nil and ArcanumConfig.BuffButton == true) then
            ShowUIPanel(ArcanumButton4);
            ShowUIPanel(OrderButton4);
        else
            HideUIPanel(ArcanumButton4);
            HideUIPanel(OrderButton4);
		end
		if (ARCANUM_SPELL_TABLE.ID[6] ~= nil and ArcanumConfig.MagicButton == true) then
            ShowUIPanel(ArcanumButton6);
            ShowUIPanel(OrderButton6);
        else
            HideUIPanel(ArcanumButton6);
            HideUIPanel(OrderButton6);
		end
		if (ArcanumConfig.PortalButton == true) then
			if (ARCANUM_SPELL_TABLE.ID[14] ~= nil or ARCANUM_SPELL_TABLE.ID[17] ~= nil) then
                ShowUIPanel(ArcanumButton8);
                ShowUIPanel(OrderButton8);
            else
                HideUIPanel(ArcanumButton8);
                HideUIPanel(OrderButton8);
			end
			if (ARCANUM_SPELL_TABLE.ID[15] ~= nil or ARCANUM_SPELL_TABLE.ID[18] ~= nil) then
                ShowUIPanel(ArcanumButton9);
                ShowUIPanel(OrderButton9);
            else
                HideUIPanel(ArcanumButton9);
                HideUIPanel(OrderButton9);
			end
			if (ARCANUM_SPELL_TABLE.ID[16] ~= nil or ARCANUM_SPELL_TABLE.ID[19] ~= nil) then
                ShowUIPanel(ArcanumButton10);
                ShowUIPanel(OrderButton10);
            else
                HideUIPanel(ArcanumButton10);
                HideUIPanel(OrderButton10);
			end
		end
	else
		if (ARCANUM_SPELL_TABLE.ID[3] ~= nil and ArcanumConfig.ArmorButton == true) then
		    ShowUIPanel(ArcanumButton5);
            ShowUIPanel(OrderButton5);
        else
            HideUIPanel(ArcanumButton5);
            HideUIPanel(OrderButton5);
		end
		if (ARCANUM_SPELL_TABLE.ID[5] ~= nil and ArcanumConfig.BuffButton == true) then
			ShowUIPanel(ArcanumButton4);
            ShowUIPanel(OrderButton4);
        else
            HideUIPanel(ArcanumButton4);
            HideUIPanel(OrderButton4);
		end
		if (ARCANUM_SPELL_TABLE.ID[7] ~= nil and ArcanumConfig.MagicButton == true) then
			ShowUIPanel(ArcanumButton6);
            ShowUIPanel(OrderButton6);
        else
            HideUIPanel(ArcanumButton6);
            HideUIPanel(OrderButton6);
		end
		if (ArcanumConfig.PortalButton == true) then
			if (ARCANUM_SPELL_TABLE.ID[20] ~= nil or ARCANUM_SPELL_TABLE.ID[23] ~= nil) then
				ShowUIPanel(ArcanumButton8);
                ShowUIPanel(OrderButton8);
            else
                HideUIPanel(ArcanumButton8);
                HideUIPanel(OrderButton8);
			end
			if (ARCANUM_SPELL_TABLE.ID[21] ~= nil or ARCANUM_SPELL_TABLE.ID[24] ~= nil) then
				ShowUIPanel(ArcanumButton9);
                ShowUIPanel(OrderButton9);
            else
                HideUIPanel(ArcanumButton9);
                HideUIPanel(OrderButton9);
			end
			if (ARCANUM_SPELL_TABLE.ID[22] ~= nil or ARCANUM_SPELL_TABLE.ID[25] ~= nil) then
				ShowUIPanel(ArcanumButton10);
                ShowUIPanel(OrderButton10);
            else
                HideUIPanel(ArcanumButton10);
                HideUIPanel(OrderButton10);
			end
		end
	end
end

function Arcanum_HideUI()
    HideUIPanel(ArcanumMinimapButton);
	HideUIPanel(ArcanumButton);
	HideUIPanel(ArcanumButton1);
	HideUIPanel(ArcanumButton2);
	HideUIPanel(ArcanumButton3);
	HideUIPanel(ArcanumButton4);
	HideUIPanel(ArcanumButton5);
	HideUIPanel(ArcanumButton6);
	HideUIPanel(ArcanumButton7);
	HideUIPanel(ArcanumButton8);
    HideUIPanel(ArcanumButton9);
	HideUIPanel(ArcanumButton10);
end

function Arcanum_InitButtons()
    ArcanumButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", ArcanumConfig.ArcanumButtonxPos, ArcanumConfig.ArcanumButtonyPos);
	ArcanumButton1:SetPoint("CENTER", "ArcanumButton", "CENTER", 0, 48);
	ArcanumButton2:SetPoint("CENTER", "ArcanumButton", "CENTER", 28, 39);
	ArcanumButton3:SetPoint("CENTER", "ArcanumButton", "CENTER", 45, 15);
	ArcanumButton4:SetPoint("CENTER", "ArcanumButton", "CENTER", 45, -15);
   	ArcanumButton5:SetPoint("CENTER", "ArcanumButton", "CENTER", 28, -39);
	ArcanumButton6:SetPoint("CENTER", "ArcanumButton", "CENTER", 0, -48);
	ArcanumButton7:SetPoint("CENTER", "ArcanumButton", "CENTER", -28, 39);
	ArcanumButton8:SetPoint("CENTER", "ArcanumButton", "CENTER", -45, 15);
	ArcanumButton9:SetPoint("CENTER", "ArcanumButton", "CENTER", -45, -15);
	ArcanumButton10:SetPoint("CENTER", "ArcanumButton", "CENTER", -28, -39);
end

------------------------------------------------------------------------------------------------------

-- FONCTIONS DE GESTION DES ICONES DE L'UI

------------------------------------------------------------------------------------------------------

function Arcanum_LoadIconsV2()
    ArcanumButton4Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[4 + ArcanumConfig.BuffType]);
    OrderButton4Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[4 + ArcanumConfig.BuffType]);
    
    ArcanumButton5Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[2 + ArcanumConfig.BuffType]);
    OrderButton5Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[2 + ArcanumConfig.BuffType]);
    
    ArcanumButton6Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[6 + ArcanumConfig.BuffType]);
    OrderButton6Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[6 + ArcanumConfig.BuffType]);
    
    if ArcanumConfig.BuffType == 0 then
        for i = 14, 16 do
            if (ARCANUM_SPELL_TABLE.ID[i] ~= nil) then
                getglobal("ArcanumButton"..(i-6).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i]);
                getglobal("OrderButton"..(i-6).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i]);
            elseif (ARCANUM_SPELL_TABLE.ID[i+3] ~= nil) then
                getglobal("ArcanumButton"..(i-6).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i+3]);
                getglobal("OrderButton"..(i-6).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i+3]);
            end
        end
    else
        for i = 20, 22 do
            if (ARCANUM_SPELL_TABLE.ID[i] ~= nil) then
                getglobal("ArcanumButton"..(i-12).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i]);
                getglobal("OrderButton"..(i-12).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i]);
            elseif (ARCANUM_SPELL_TABLE.ID[i+3] ~= nil) then
                getglobal("ArcanumButton"..(i-12).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i+3]);
            end
        end
    end
end

function Arcanum_LoadIconsV1()
    ArcanumButton4Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastBuff]);
    OrderButton4Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastBuff]);
    ArcanumButton4Menu1Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[4]);
    ArcanumButton4Menu2Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[5]);
    
    
    ArcanumButton5Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastArmor]);
    OrderButton5Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastArmor]);
    ArcanumButton5Menu1Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[2]);
    ArcanumButton5Menu2Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[3]);
    
    ArcanumButton6Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastMagic]);
    OrderButton6Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastMagic]);
    ArcanumButton6Menu1Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[6]);
    ArcanumButton6Menu2Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[7]);
    
    ArcanumButton8Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastPortal]);
    OrderButton8Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastPortal]);
    for i = 14, 16 do
        if (ARCANUM_SPELL_TABLE.ID[i] ~= nil) then
            getglobal("ArcanumButton8Menu"..(i-13).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i]);
        elseif (ARCANUM_SPELL_TABLE.ID[i+3] ~= nil) then
            getglobal("ArcanumButton8Menu"..(i-13).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i+3]);
        end
    end
    for i = 20, 22 do
        if (ARCANUM_SPELL_TABLE.ID[i] ~= nil) then
            getglobal("ArcanumButton8Menu"..(i-16).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i]);
        elseif (ARCANUM_SPELL_TABLE.ID[i+3] ~= nil) then
            getglobal("ArcanumButton8Menu"..(i-16).."Texture"):SetTexture(ARCANUM_SPELL_TABLE.Texture[i+3]);
        end
    end
end

function Arcanum_LoadIconsV()

    
    CoolDown[1][3] = HearthstoneLocation[1];
    CoolDown[1][4] = HearthstoneLocation[2];
    CoolDown[2][3] = ManaGemLocation[1][1];
    CoolDown[2][4] = ManaGemLocation[1][2];
    CoolDown[3][3] = ARCANUM_SPELL_TABLE.ID[26];
    CoolDown[4][3] = ARCANUM_SPELL_TABLE.ID[32];
    CoolDown[5][3] = ARCANUM_SPELL_TABLE.ID[33];
    CoolDown[6][3] = ARCANUM_SPELL_TABLE.ID[26];
    CoolDown[7][3] = ARCANUM_SPELL_TABLE.ID[32];
    CoolDown[8][3] = ARCANUM_SPELL_TABLE.ID[33];
    
    for i = 1, 10 do
        getglobal("ArcanumButton"..i.."Texture2"):SetTexture(UIPath.."ButtonCircle");
        getglobal("OrderButton"..i.."Texture2"):SetTexture(UIPath.."ButtonCircle");
        if i == 4 or i == 5 or i == 6 then
            for j = 1, 2 do
                getglobal("ArcanumButton"..i.."Menu"..j.."Texture2"):SetTexture(UIPath.."ButtonCircle");
            end
        elseif i == 7 or i == 8 then
            for j = 1, 6 do
                getglobal("ArcanumButton"..i.."Menu"..j.."Texture2"):SetTexture(UIPath.."ButtonCircle");
            end
        end
    end
    
    if ARCANUM_SPELL_TABLE.Rank[8] ~= nil then
        ArcanumButton1Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[8]);
        OrderButton1Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[8]);
    end
    
    if ARCANUM_SPELL_TABLE.Rank[9] ~= nil then
        ArcanumButton2Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[9]);
        OrderButton2Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[9]);
    end
    
    Arcanum_ManaGemIcons();
    
    if ArcanumConfig.LastMount ~= 0 then
        ArcanumButton7Texture:SetTexture(MountIcon[ArcanumConfig.LastMount]);
        OrderButton7Texture:SetTexture(MountIcon[ArcanumConfig.LastMount]);
	end
    for i = 1, 6 do
        getglobal("ArcanumButton7Menu"..i.."Texture"):SetTexture(MountIcon[i]);
    end
end

function Arcanum_LoadIcons()
    Arcanum_LoadIconsV();
    if ArcanumConfig.InterfaceVersion == 1 then
        Arcanum_LoadIconsV1();
    else
        Arcanum_LoadIconsV2();
    end
    Arcanum_EDIcons();
end

function Arcanum_ManaGemIcons()
    if (ManaGemExists[1] == true) then
        ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[13]);
        OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[13]);
        ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[13];
	elseif (ManaGemExists[2] == true) then
        ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[12]);
        OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[12]);
        ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[12];
	elseif (ManaGemExists[3] == true) then
        ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[11]);
        OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[11]);
        ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[11];
	elseif (ManaGemExists[4] == true) then
        ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[10]);
        OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[10]);
        ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[10];
	else
		if (ARCANUM_SPELL_TABLE.ID[13] ~= nil) then
            ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[13]);
            OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[13]);
            ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[13];
		elseif (ARCANUM_SPELL_TABLE.ID[12] ~= nil) then
            ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[12]);
            OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[12]);
            ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[12];
		elseif (ARCANUM_SPELL_TABLE.ID[11] ~= nil) then	
            ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[11]);
            OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[11]);
            ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[11];
		elseif (ARCANUM_SPELL_TABLE.ID[10] ~= nil) then	
            ArcanumButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[10]);
            OrderButton3Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[10]);
            ArcanumButtonDisplayTexture[2] = ARCANUM_SPELL_TABLE.Texture[10];
		end
	end
end

function Arcanum_EDIconsV()
    if ARCANUM_SPELL_TABLE.Rank[8] ~= nil then
        if FoodCount == 0 then
            ArcanumFoodCount:SetText("");
            ArcanumButton1Texture:SetDesaturated(1);
        else
            ArcanumFoodCount:SetText(FoodCount);
            ArcanumButton1Texture:SetDesaturated(nil);
        end
    end
    if ARCANUM_SPELL_TABLE.Rank[9] ~= nil then
        if WaterCount == 0 then
            ArcanumWaterCount:SetText("");
            ArcanumButton2Texture:SetDesaturated(1);
        else
            ArcanumWaterCount:SetText(WaterCount);
            ArcanumButton2Texture:SetDesaturated(nil);
        end
    end
    if (ManaGemExists[1] == true or ManaGemExists[2] == true or ManaGemExists[3] == true or ManaGemExists[4] == true) then
        ArcanumButton3Texture:SetDesaturated(nil);
	else
        ArcanumButton3Texture:SetDesaturated(1);
	end
end

function Arcanum_EDIconsV1()
    if ArcanumArcanePowder == 0 then
        ArcanumButton4Text:SetText("");
        ArcanumArcanePowderCount:SetText("");
        ArcanumButton4Menu2Texture:SetDesaturated(1);
        if ArcanumConfig.LastBuff == 5 then
            ArcanumButton4Texture:SetDesaturated(1);
        else
            ArcanumButton4Texture:SetDesaturated(nil);
        end 
    else
        ArcanumArcanePowderCount:SetText(ArcanumArcanePowder);
        ArcanumButton4Menu2Texture:SetDesaturated(nil);
        ArcanumButton4Texture:SetDesaturated(nil);
        if ArcanumConfig.LastBuff == 5 then
            ArcanumButton4Text:SetText(ArcanumArcanePowder);
        else
            ArcanumButton4Text:SetText("");
        end     
    end
    
    if ArcanumConfig.LastPortal >= 14 and ArcanumConfig.LastPortal <=19 then
        if ArcanumRuneOfTeleportation == 0 then
            ArcanumButton8Text:SetText("");
            ArcanumButton8Texture:SetDesaturated(1);
        else
            ArcanumButton8Text:SetText(ArcanumRuneOfTeleportation);
            ArcanumButton8Texture:SetDesaturated(nil);
        end
    else
        if ArcanumRuneOfPortals == 0 then
            ArcanumButton8Text:SetText("");
            ArcanumButton8Texture:SetDesaturated(1);
        else
            ArcanumButton8Text:SetText(ArcanumRuneOfPortals);
            ArcanumButton8Texture:SetDesaturated(nil);
        end
    end
    if ArcanumRuneOfTeleportation == 0 then
        ArcanumTeleport1Count:SetText("");
        ArcanumTeleport2Count:SetText("");
        ArcanumTeleport3Count:SetText("");
        ArcanumButton8Menu1Texture:SetDesaturated(1);
        ArcanumButton8Menu2Texture:SetDesaturated(1);
        ArcanumButton8Menu3Texture:SetDesaturated(1);
    else
        ArcanumTeleport1Count:SetText(ArcanumRuneOfTeleportation);
        ArcanumTeleport2Count:SetText(ArcanumRuneOfTeleportation);
        ArcanumTeleport3Count:SetText(ArcanumRuneOfTeleportation);
        ArcanumButton8Menu1Texture:SetDesaturated(nil);
        ArcanumButton8Menu2Texture:SetDesaturated(nil);
        ArcanumButton8Menu3Texture:SetDesaturated(nil);
    end
    if ArcanumRuneOfPortals == 0 then
        ArcanumPortal1Count:SetText("");
        ArcanumPortal2Count:SetText("");
        ArcanumPortal3Count:SetText("");
        ArcanumButton8Menu4Texture:SetDesaturated(1);
        ArcanumButton8Menu5Texture:SetDesaturated(1);
        ArcanumButton8Menu6Texture:SetDesaturated(1);
    else
        ArcanumPortal1Count:SetText(ArcanumRuneOfPortals);
        ArcanumPortal2Count:SetText(ArcanumRuneOfPortals);
        ArcanumPortal3Count:SetText(ArcanumRuneOfPortals);
        ArcanumButton8Menu4Texture:SetDesaturated(nil);
        ArcanumButton8Menu5Texture:SetDesaturated(nil);
        ArcanumButton8Menu6Texture:SetDesaturated(nil);
    end
    
    
    
end


function Arcanum_EDIconsV2()
    if ArcanumConfig.BuffType == 0 then
        ArcanumButton4Text:SetText("");
        ArcanumButton4Texture:SetDesaturated(nil);
        if ArcanumRuneOfTeleportation == 0 then
            ArcanumButton8Text:SetText("");
            ArcanumButton9Text:SetText("");
            ArcanumButton10Text:SetText("");
            ArcanumButton8Texture:SetDesaturated(1);
            ArcanumButton9Texture:SetDesaturated(1);
            ArcanumButton10Texture:SetDesaturated(1);
        else
            ArcanumButton8Text:SetText(ArcanumRuneOfTeleportation);
            ArcanumButton9Text:SetText(ArcanumRuneOfTeleportation);
            ArcanumButton10Text:SetText(ArcanumRuneOfTeleportation);
            ArcanumButton8Texture:SetDesaturated(nil);
            ArcanumButton9Texture:SetDesaturated(nil);
            ArcanumButton10Texture:SetDesaturated(nil);
        end
    else
        if ArcanumArcanePowder == 0 then
            ArcanumButton4Text:SetText("");
            ArcanumButton4Texture:SetDesaturated(1);
        else
            ArcanumButton4Text:SetText(ArcanumArcanePowder);
            ArcanumButton4Texture:SetDesaturated(nil);
        end
        if ArcanumRuneOfPortals == 0 then
            ArcanumButton8Text:SetText("");
            ArcanumButton9Text:SetText("");
            ArcanumButton10Text:SetText("");
            ArcanumButton8Texture:SetDesaturated(1);
            ArcanumButton9Texture:SetDesaturated(1);
            ArcanumButton10Texture:SetDesaturated(1);
        else
            ArcanumButton8Text:SetText(ArcanumRuneOfPortals);
            ArcanumButton9Text:SetText(ArcanumRuneOfPortals);
            ArcanumButton10Text:SetText(ArcanumRuneOfPortals);
            ArcanumButton8Texture:SetDesaturated(nil);
            ArcanumButton9Texture:SetDesaturated(nil);
            ArcanumButton10Texture:SetDesaturated(nil);
        end
    end
end


function Arcanum_EDIcons()
    Arcanum_EDIconsV();
    if ArcanumConfig.InterfaceVersion == 1 then
        Arcanum_EDIconsV1();
    else
        Arcanum_EDIconsV2();
    end
end


function Arcanum_CombatDisableIcons()
    if ARCANUM_SPELL_TABLE.ID[8] ~= nil then
        ArcanumButton1Texture:SetDesaturated(1);
    end
    if ARCANUM_SPELL_TABLE.ID[9] ~= nil then
        ArcanumButton2Texture:SetDesaturated(1);
    end
	if ArcanumConfig.LastMount ~= 0 then
        ArcanumButton7Texture:SetDesaturated(1);
    end
    ArcanumButtonTexture:SetTexture(UIPath.."ArcanumC");
end

function Arcanum_CombatEnableIcons()
    if FoodCount ~= 0 and ARCANUM_SPELL_TABLE.ID[8] ~= nil then
        ArcanumButton1Texture:SetDesaturated(nil);
    end
    if WaterCount ~= 0 and ARCANUM_SPELL_TABLE.ID[9] ~= nil then
        ArcanumButton2Texture:SetDesaturated(nil);
    end
    if ArcanumConfig.LastMount ~= 0 then
        ArcanumButton7Texture:SetDesaturated(nil);
    end
    ArcanumButtonTexture:SetTexture(UIPath.."ArcanumN");
end

------------------------------------------------------------------------------------------------------

-- FONCTIONS DE GESTION DES COMPORTEMENTS DES BOUTONS DE L'UI

------------------------------------------------------------------------------------------------------

-- Fonction (XML) pour rétablir les points d'attache par dfaut des boutons
function Arcanum_ClearAllPoints()
	ArcanumButton1:ClearAllPoints();
	ArcanumButton2:ClearAllPoints();
	ArcanumButton3:ClearAllPoints();
	ArcanumButton4:ClearAllPoints();
	ArcanumButton5:ClearAllPoints();
	ArcanumButton6:ClearAllPoints();
	ArcanumButton7:ClearAllPoints();
	ArcanumButton8:ClearAllPoints();
    ArcanumButton9:ClearAllPoints();
    ArcanumButton10:ClearAllPoints();
end

-- Fonction (XML) pour étendre la propriété NoDrag() du bouton principal d'Arcanum sur tous ses boutons
function Arcanum_NoDrag()
	ArcanumButton1:RegisterForDrag("");
	ArcanumButton2:RegisterForDrag("");
	ArcanumButton3:RegisterForDrag("");
	ArcanumButton4:RegisterForDrag("");
	ArcanumButton5:RegisterForDrag("");
	ArcanumButton6:RegisterForDrag("");
	ArcanumButton7:RegisterForDrag("");
	ArcanumButton8:RegisterForDrag("");
    ArcanumButton9:RegisterForDrag("");
    ArcanumButton10:RegisterForDrag("");
end

-- Fonction (XML) inverse de celle du dessus
function Arcanum_Drag()
    ArcanumButton1:RegisterForDrag("LeftButton");
	ArcanumButton2:RegisterForDrag("LeftButton");
	ArcanumButton3:RegisterForDrag("LeftButton");
	ArcanumButton4:RegisterForDrag("LeftButton");
	ArcanumButton5:RegisterForDrag("LeftButton");
	ArcanumButton6:RegisterForDrag("LeftButton");
	ArcanumButton7:RegisterForDrag("LeftButton");
	ArcanumButton8:RegisterForDrag("LeftButton");
    ArcanumButton9:RegisterForDrag("LeftButton");
    ArcanumButton10:RegisterForDrag("LeftButton");
end

function Arcanum_MovableIcons()
		ArcanumButton1:SetPoint("CENTER", "UIParent", "CENTER", -161,-100);
		ArcanumButton2:SetPoint("CENTER", "UIParent", "CENTER",-125,-100);
		ArcanumButton3:SetPoint("CENTER", "UIParent", "CENTER", -89,-100);
		ArcanumButton4:SetPoint("CENTER", "UIParent", "CENTER", -53,-100);
		ArcanumButton5:SetPoint("CENTER", "UIParent", "CENTER", -17,-100);
		ArcanumButton6:SetPoint("CENTER", "UIParent", "CENTER", 17,-100);
		ArcanumButton7:SetPoint("CENTER", "UIParent", "CENTER", 53,-100);
		ArcanumButton8:SetPoint("CENTER", "UIParent", "CENTER", 89,-100);
		ArcanumButton9:SetPoint("CENTER", "UIParent", "CENTER", 125,-100);
		ArcanumButton10:SetPoint("CENTER", "UIParent", "CENTER", 161, -100);
end

function Arcanum_UpdateButtonsScale()
	local NBRScale = (100 + (ArcanumConfig.ArcanumButtonScale - 85)) / 100;
	if ArcanumConfig.ArcanumButtonScale <= 95 then
		NBRScale = 1.1;
	end
	if ArcanumConfig.ArcanumLockServ then
		Arcanum_ClearAllPoints();
		local indexScale = -18;
        NBRScale = 1.15;
        for index = 1, 10, 1 do
			getglobal("ArcanumButton"..ArcanumConfig.ButtonsOrder[index]):SetPoint("CENTER", "ArcanumButton", "CENTER", ((40 * NBRScale) * cos(ArcanumConfig.ArcanumAngle-indexScale)), ((40 * NBRScale) * sin(ArcanumConfig.ArcanumAngle-indexScale)));
			getglobal("OrderButton"..ArcanumConfig.ButtonsOrder[index]):SetPoint("CENTER", "ArcanumOrderButton", "CENTER", (32 * cos(ArcanumConfig.ArcanumAngle-indexScale)), (32 * sin(ArcanumConfig.ArcanumAngle-indexScale)));
			if ArcanumConfig.ButtonsOrder[index] == 4 and BuffMenuCreate ~= {} then
				xBuffMenuPos = ((40 * NBRScale) * cos(ArcanumConfig.ArcanumAngle-indexScale))
                yBuffMenuPos = ((40 * NBRScale) * sin(ArcanumConfig.ArcanumAngle-indexScale));
			end	
			if ArcanumConfig.ButtonsOrder[index] == 5 and PortalMenuCreate ~= {} then
                xArmorMenuPos = ((40 * NBRScale) * cos(ArcanumConfig.ArcanumAngle-indexScale))
                yArmorMenuPos = ((40 * NBRScale) * sin(ArcanumConfig.ArcanumAngle-indexScale));
			end
			if ArcanumConfig.ButtonsOrder[index] == 6 and MountMenuCreate ~= {} then
                xMagicMenuPos = ((40 * NBRScale) * cos(ArcanumConfig.ArcanumAngle-indexScale))
                yMagicMenuPos = ((40 * NBRScale) * sin(ArcanumConfig.ArcanumAngle-indexScale));
			end
			if ArcanumConfig.ButtonsOrder[index] == 7 and ArmorMenuCreate ~= {} then
                xMountMenuPos = ((40 * NBRScale) * cos(ArcanumConfig.ArcanumAngle-indexScale))
                yMountMenuPos = ((40 * NBRScale) * sin(ArcanumConfig.ArcanumAngle-indexScale));
			end	
			if ArcanumConfig.ButtonsOrder[index] == 8 and MagicMenuCreate ~= {} then
                xPortalMenuPos = ((40 * NBRScale) * cos(ArcanumConfig.ArcanumAngle-indexScale))
                yPortalMenuPos = ((40 * NBRScale) * sin(ArcanumConfig.ArcanumAngle-indexScale));
			end
            indexScale = indexScale + 36;
        end
        
        ArcanumButton1:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton2:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton3:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton4:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton5:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton6:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton7:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton8:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton9:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
        ArcanumButton10:SetScale(ArcanumConfig.ArcanumButtonScale / 100);
	end
	Arcanum_CreateMenu();
end

function Arcanum_MenuPos(button)
	local a, b, c, x, y = button:GetPoint("CENTER");
	x = ((32 * x) / 40);
	y = ((32 * y) / 40);
	return x, y;
end

function Arcanum_IntSign(Value)
	local Result;
	if math.abs(Value) == Value then
		Result = 1;
	else
		Result = -1;
	end
	return Result;
end

function Arcanum_UpdateMenuPos()
	local a, b, c, x, y = ArcanumButton4:GetPoint("CENTER");
	local a1, b1, c1, x1, y1 = ArcanumButton:GetPoint("CENTER");
	xBuffMenuPos = x-x1;
	yBuffMenuPos = y-y1;
	a, b, c, x, y = ArcanumButton5:GetPoint("CENTER");
	xArmorMenuPos = x-x1;
	yArmorMenuPos = y-y1;
	a, b, c, x, y = ArcanumButton6:GetPoint("CENTER");
	xMagicMenuPos = x-x1;
	yMagicMenuPos = y-y1;
	a, b, c, x, y = ArcanumButton8:GetPoint("CENTER");
	xPortalMenuPos = x-x1;
	yPortalMenuPos = y-y1;
    a, b, c, x, y = ArcanumButton7:GetPoint("CENTER");
	xMountMenuPos = x-x1;
	yMountMenuPos = y-y1;
	Arcanum_CreateMenu();
end

------------------------------------------------------------------------------------------------------

-- FONCTIONS DE GESTION DES BOUTONS MENUS DE L'UI

------------------------------------------------------------------------------------------------------

-- A chaque changement du livre des sorts, au démarrage du mod, ainsi qu'au changement de sens du menu on reconstruit les menus des sorts
function Arcanum_CreateMenu()
	BuffMenuCreate = {};
	ArmorMenuCreate = {};
	MagicMenuCreate = {};
	PortalMenuCreate = {};
    MountMenuCreate = {};
	local menuVariable = nil;
	local BuffButtonPosition = 0;
	local ArmorButtonPosition = 0;
	local MagicButtonPosition = 0;
	local PortalButtonPosition = 0;
    local MountButtonPosition = 0;
    
	-- On cache toutes les icones des buffs
	for i = 1, 2, 1 do
		menuVariable = getglobal("ArcanumButton4Menu"..i);
		menuVariable:Hide();
	end
	-- On cache toutes les icones des armures
	for i = 1, 2, 1 do
		menuVariable = getglobal("ArcanumButton5Menu"..i);
		menuVariable:Hide();
	end
	-- On cache toutes les icones des magies
	for i = 1, 2, 1 do
		menuVariable = getglobal("ArcanumButton6Menu"..i);
		menuVariable:Hide();
	end
	-- On cache toutes les icones des portails
	for i = 1, 6, 1 do
		menuVariable = getglobal("ArcanumButton8Menu"..i);
		menuVariable:Hide();
	end
    -- On cache toutes les icones des montures
	for i = 1, 4, 1 do
		menuVariable = getglobal("ArcanumButton7Menu"..i);
		menuVariable:Hide();
	end
	
	-- Affichage des boutons des buffs si les sorts existent
	if (ARCANUM_SPELL_TABLE.ID[4] ~= nil) then
		menuVariable = getglobal("ArcanumButton4Menu1");
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "ArcanumButton4", "CENTER", 3000, 3000);
		BuffButtonPosition = 1;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if (ARCANUM_SPELL_TABLE.ID[5] ~= nil) then
		menuVariable = getglobal("ArcanumButton4Menu2");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "ArcanumButton4", "CENTER", 3000, 3000);
		else
			if ArcanumConfig.BuffMenuPos == "x" then
				menuVariable:SetPoint("CENTER", "ArcanumButton4Menu"..BuffButtonPosition, "CENTER", (Arcanum_IntSign(xBuffMenuPos) * 32), 0);
			else
				menuVariable:SetPoint("CENTER", "ArcanumButton4Menu"..BuffButtonPosition, "CENTER", 0, (Arcanum_IntSign(yBuffMenuPos) * 32));
			end
		end
		BuffButtonPosition = 2;
		table.insert(BuffMenuCreate, menuVariable);
	end
	-- Maintenant que tous les boutons sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	for i = 1, table.getn(BuffMenuCreate), 1 do
		ShowUIPanel(BuffMenuCreate[i]);
	end
		
	-- Affichage des boutons des armures si les sorts existent
	if (ARCANUM_SPELL_TABLE.ID[2] ~= nil or ARCANUM_SPELL_TABLE.ID[1] ~= nil) then
		menuVariable = getglobal("ArcanumButton5Menu1");
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "ArcanumButton5", "CENTER", 3000, 3000);
		ArmorButtonPosition = 1;
		table.insert(ArmorMenuCreate, menuVariable);
	end
	if (ARCANUM_SPELL_TABLE.ID[3] ~= nil) then
		menuVariable = getglobal("ArcanumButton5Menu2");
		menuVariable:ClearAllPoints();
		if ArmorButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "ArcanumButton5", "CENTER", 3000, 3000);
		else
			if ArcanumConfig.ArmorMenuPos == "x" then
				menuVariable:SetPoint("CENTER", "ArcanumButton5Menu"..ArmorButtonPosition, "CENTER", (Arcanum_IntSign(xArmorMenuPos) * 32), 0);
			else
				menuVariable:SetPoint("CENTER", "ArcanumButton5Menu"..ArmorButtonPosition, "CENTER", 0, (Arcanum_IntSign(yArmorMenuPos) * 32));
			end
		end
		ArmorButtonPosition = 2;
		table.insert(ArmorMenuCreate, menuVariable);
	end
	-- Maintenant que tous les boutons sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	for i = 1, table.getn(ArmorMenuCreate), 1 do
		ShowUIPanel(ArmorMenuCreate[i]);
	end
	
	-- Affichage des boutons des magies si les sorts existent
	if (ARCANUM_SPELL_TABLE.ID[6] ~= nil) then
		menuVariable = getglobal("ArcanumButton6Menu1");
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "ArcanumButton6", "CENTER", 3000, 3000);
		MagicButtonPosition = 1;
		table.insert(MagicMenuCreate, menuVariable);
	end
	if (ARCANUM_SPELL_TABLE.ID[7] ~= nil) then
		menuVariable = getglobal("ArcanumButton6Menu2");
		menuVariable:ClearAllPoints();
		if MagicButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "ArcanumButton6", "CENTER", 3000, 3000);
		else
			if ArcanumConfig.MagicMenuPos == "x" then
				menuVariable:SetPoint("CENTER", "ArcanumButton6Menu"..MagicButtonPosition, "CENTER", (Arcanum_IntSign(xMagicMenuPos) * 32), 0);
			else
				menuVariable:SetPoint("CENTER", "ArcanumButton6Menu"..MagicButtonPosition, "CENTER", 0, (Arcanum_IntSign(yMagicMenuPos) * 32));
			end
		end
		MagicButtonPosition = 2;
		table.insert(MagicMenuCreate, menuVariable);
	end
	-- Maintenant que tous les boutons sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	for i = 1, table.getn(MagicMenuCreate), 1 do
		ShowUIPanel(MagicMenuCreate[i]);
	end
	
	-- Affichage des boutons des portails si les sorts existent
	for i = 14, 16 do
		if (ARCANUM_SPELL_TABLE.ID[i] ~= nil or ARCANUM_SPELL_TABLE.ID[i+3] ~= nil) then
			menuVariable = getglobal("ArcanumButton8Menu"..i-13);
			menuVariable:ClearAllPoints();
			if PortalButtonPosition == 0 then
				menuVariable:SetPoint("CENTER", "ArcanumButton8", "CENTER", 3000, 3000);
			else
				if ArcanumConfig.PortalMenuPos == "x" then
					menuVariable:SetPoint("CENTER", "ArcanumButton8Menu"..PortalButtonPosition, "CENTER", (Arcanum_IntSign(xPortalMenuPos) * 32), 0);
				else
					menuVariable:SetPoint("CENTER", "ArcanumButton8Menu"..PortalButtonPosition, "CENTER", 0, (Arcanum_IntSign(yPortalMenuPos) * 32));
				end
			end
			PortalButtonPosition = i-13;
			table.insert(PortalMenuCreate, menuVariable);
		end
	end
	for i = 20, 22 do
		if (ARCANUM_SPELL_TABLE.ID[i] ~= nil or ARCANUM_SPELL_TABLE.ID[i+3] ~= nil) then
			menuVariable = getglobal("ArcanumButton8Menu"..i-16);
			menuVariable:ClearAllPoints();
			if PortalButtonPosition == 0 then
				menuVariable:SetPoint("CENTER", "ArcanumButton8", "CENTER", 3000, 3000);
			else
				if ArcanumConfig.PortalMenuPos == "x" then
					menuVariable:SetPoint("CENTER", "ArcanumButton8Menu"..PortalButtonPosition, "CENTER", (Arcanum_IntSign(xPortalMenuPos) * 32), 0);
				else
					menuVariable:SetPoint("CENTER", "ArcanumButton8Menu"..PortalButtonPosition, "CENTER", 0, (Arcanum_IntSign(yPortalMenuPos) * 32));
				end
			end
			PortalButtonPosition = i-16;
			table.insert(PortalMenuCreate, menuVariable);
		end
	end
	-- Maintenant que tous les boutons sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	for i = 1, table.getn(PortalMenuCreate), 1 do
		ShowUIPanel(PortalMenuCreate[i]);
	end
    
    -- Affichage des boutons des montures en fonction du nombre de monture présente
    local MountNB;
    if table.getn(MountLocation) > 6 then
        MountNB = 6;
    else
        MountNB = table.getn(MountLocation);
    end
	for i = 1, MountNB do
		menuVariable = getglobal("ArcanumButton7Menu"..i);
		menuVariable:ClearAllPoints();
		if MountButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "ArcanumButton7", "CENTER", 3000, 3000);
		else
			if ArcanumConfig.MountMenuPos == "x" then
				menuVariable:SetPoint("CENTER", "ArcanumButton7Menu"..MountButtonPosition, "CENTER", (Arcanum_IntSign(xMountMenuPos) * 32), 0);
			else
				menuVariable:SetPoint("CENTER", "ArcanumButton7Menu"..MountButtonPosition, "CENTER", 0, (Arcanum_IntSign(yMountMenuPos) * 32));
			end
		end
		MountButtonPosition = i;
		table.insert(MountMenuCreate, menuVariable);
	end
	-- Maintenant que tous les boutons sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	for i = 1, table.getn(MountMenuCreate), 1 do
		ShowUIPanel(MountMenuCreate[i]);
	end
    
end

-- Ouverture du menu des buffs
function Arcanum_BuffMenu(button)
	if (button == "LeftButton" and ArcanumConfig.LastBuff ~= 0) then
		Arcanum_BuffCast(ArcanumConfig.LastBuff);
		return;
	end
	BuffMenuShow = not BuffMenuShow;
	if not BuffMenuShow then
		BuffShow = false;
		BuffVisible = false;
		BuffMenuCreate[1]:ClearAllPoints();
		BuffMenuCreate[1]:SetPoint("CENTER", "ArcanumButton4", "CENTER", 3000, 3000);
		AlphaBuffMenu = 1;
	else
		BuffShow = true;
		-- Si clic milieu, le menu de buff reste ouvert
		if button == "MiddleButton" then
			BuffVisible = true;
		end
		-- S'il n'existe aucun buff on ne fait rien
		if BuffMenuCreate == nil then
			return;
		end
		-- Sinon on affiche les icones
		ArcanumButton4Menu1:SetAlpha(1);
		ArcanumButton4Menu2:SetAlpha(1);
		BuffMenuCreate[1]:ClearAllPoints();
		BuffMenuCreate[1]:SetPoint("CENTER", "ArcanumButton4", "CENTER", xBuffMenuPos, yBuffMenuPos);
		AlphaBuffVar = GetTime() + 6;
	end
end

-- Gestion des casts du menu des buffs
function Arcanum_BuffCast(type)
	local TargetEnemy = false;
	if (not (UnitIsFriend("player", "target"))) then
		TargetUnit("player");
		TargetEnemy = true;
	end
	if (type == 4) then
		if ArcanumConfig.LevelBuff == true then
			if (UnitExists("target")) then
				for i = ARCANUM_SPELL_TABLE.Rank[4], 1, -1 do
					if UnitLevel("target") >= Buff_Minlvl[i] then
						local BuffName = ARCANUM_SPELL_TABLE.Name[4].."("..ARCANUM_TRANSLATION.Rank.." "..i..")";
						CastSpellByName(BuffName, "spell");
						break;
					end
				end
			end
		else
			CastSpell(ARCANUM_SPELL_TABLE.ID[4], "spell");
		end
	else
		CastSpell(ARCANUM_SPELL_TABLE.ID[type], "spell");
	end
	
	ArcanumConfig.LastBuff = type;
    if ArcanumConfig.InterfaceVersion == 1 then
        ArcanumButton4Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastBuff]);
        OrderButton4Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastBuff]);
        if ArcanumArcanePowder == 0 then
            ArcanumButton4Text:SetText("");
            if ArcanumConfig.LastBuff == 5 then
                ArcanumButton4Texture:SetDesaturated(1);
            else
                ArcanumButton4Texture:SetDesaturated(nil);
            end 
        else
            ArcanumButton4Texture:SetDesaturated(nil);
            if ArcanumConfig.LastBuff == 5 then
                ArcanumButton4Text:SetText(ArcanumArcanePowder);
            else
                ArcanumButton4Text:SetText("");
            end     
        end
    end
    
	if TargetEnemy then TargetLastTarget(); end
	AlphaBuffMenu = 1;
	AlphaBuffVar = GetTime() + 3;
end

-- Ouverture du menu des armures
function Arcanum_ArmorMenu(button)
	if button == "LeftButton" and ArcanumConfig.LastArmor ~= 0 then
		Arcanum_ArmorCast(ArcanumConfig.LastArmor);
		return;
	end
	ArmorMenuShow = not ArmorMenuShow;
	if not ArmorMenuShow then
		ArmorShow = false;
		ArmorVisible = false;
		ArmorMenuCreate[1]:ClearAllPoints();
		ArmorMenuCreate[1]:SetPoint("CENTER", "ArcanumButton5", "CENTER", 3000, 3000);
		AlphaArmorMenu = 1;
	else
		ArmorShow = true;
		-- Si clic milieu, le menu de buff reste ouvert
		if button == "MiddleButton" then
			ArmorVisible = true;
		end
		-- S'il n'existe aucun buff on ne fait rien
		if ArmorMenuCreate == nil then
			return;
		end
		-- Sinon on affiche les icones
		ArcanumButton5Menu1:SetAlpha(1);
		ArcanumButton5Menu2:SetAlpha(1);
		ArmorMenuCreate[1]:ClearAllPoints();
		ArmorMenuCreate[1]:SetPoint("CENTER", "ArcanumButton5", "CENTER", xArmorMenuPos, yArmorMenuPos);
		AlphaArmorVar = GetTime() + 6;
	end
end

-- Gestion des casts du menu des buffs
function Arcanum_ArmorCast(type)
	-- Si le mage possède l'armure de glace
	if (ARCANUM_SPELL_TABLE.ID[type] ~= nil) then
		CastSpell(ARCANUM_SPELL_TABLE.ID[type], "spell");
        ArcanumConfig.LastArmor = type;
	else
		CastSpell(ARCANUM_SPELL_TABLE.ID[1], "spell");
        ArcanumConfig.LastArmor = 1;
	end

    if ArcanumConfig.InterfaceVersion == 1 then
        ArcanumButton5Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastArmor]);
        OrderButton5Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastArmor]);
    end
	AlphaArmorMenu = 1;
	AlphaArmorVar = GetTime() + 3;
end

-- Ouverture du menu des armures
function Arcanum_MagicMenu(button)
	if button == "LeftButton" and ArcanumConfig.LastMagic ~= 0 then
		Arcanum_MagicCast(ArcanumConfig.LastMagic);
		return;
	end
	MagicMenuShow = not MagicMenuShow;
	if not MagicMenuShow then
		MagicShow = false;
		MagicVisible = false;
		MagicMenuCreate[1]:ClearAllPoints();
		MagicMenuCreate[1]:SetPoint("CENTER", "ArcanumButton6", "CENTER", 3000, 3000);
		AlphaMagicMenu = 1;
	else
		MagicShow = true;
		-- Si clic milieu, le menu de buff reste ouvert
		if button == "MiddleButton" then
			MagicVisible = true;
		end
		-- S'il n'existe aucun buff on ne fait rien
		if MagicMenuCreate == nil then
			return;
		end
		-- Sinon on affiche les icones
		ArcanumButton6Menu1:SetAlpha(1);
		ArcanumButton6Menu2:SetAlpha(1);
		MagicMenuCreate[1]:ClearAllPoints();
		MagicMenuCreate[1]:SetPoint("CENTER", "ArcanumButton6", "CENTER", xMagicMenuPos, yMagicMenuPos);
		AlphaMagicVar = GetTime() + 6;
	end
end

-- Gestion des casts du menu des buffs
function Arcanum_MagicCast(type)
	local TargetEnemy = false;
	if (not (UnitIsFriend("player", "target"))) and type ~= 9 then
		TargetUnit("player");
		TargetEnemy = true;
	end
    if ArcanumConfig.LevelBuff == true then
		if (UnitExists("target")) then
			for i = ARCANUM_SPELL_TABLE.Rank[type], 1, -1 do
                if type == 7 then
                    if UnitLevel("target") >= Amplify_Minlvl[i] then
                        local BuffName = ARCANUM_SPELL_TABLE.Name[7].."("..ARCANUM_TRANSLATION.Rank.." "..i..")";
                        CastSpellByName(BuffName, "spell");
                        break;
                    end
                elseif type == 6 then
                    if UnitLevel("target") >= Dampen_Minlvl[i] then
                        local BuffName = ARCANUM_SPELL_TABLE.Name[6].."("..ARCANUM_TRANSLATION.Rank.." "..i..")";
                        CastSpellByName(BuffName, "spell");
                        break;
                    end
                end
			end
		end
	else
		CastSpell(ARCANUM_SPELL_TABLE.ID[type], "spell");
	end
	
	ArcanumConfig.LastMagic = type;
    if ArcanumConfig.InterfaceVersion == 1 then
        ArcanumButton6Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastMagic]);
        OrderButton6Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastMagic]);
    end
	if TargetEnemy then TargetLastTarget(); end
	AlphaMagicMenu = 1;
	AlphaMagicVar = GetTime() + 3;
end

-- Ouverture du menu des portails
function Arcanum_PortalMenu(button)
	if button == "LeftButton" and ArcanumConfig.LastPortal ~= 0 then
		Arcanum_PortalCast(ArcanumConfig.LastPortal);
		return;
	end
	
	PortalMenuShow = not PortalMenuShow;
	if not PortalMenuShow then
		PortalShow = false;
		PortalVisible = false;
		PortalMenuCreate[1]:ClearAllPoints();
		PortalMenuCreate[1]:SetPoint("CENTER", "ArcanumButton8", "CENTER", 3000, 3000);
		AlphaPortalMenu = 1;
	else
		PortalShow = true;
		-- Si clic milieu, le menu des portails reste ouvert
		if button == "MiddleButton" then
			PortalVisible = true;
		end
		-- S'il n'existe aucun portail on ne fait rien
		if PortalMenuCreate[1] == nil then
			return;
		end
		-- Sinon on affiche les icones
		ArcanumButton8Menu1:SetAlpha(1);
		ArcanumButton8Menu2:SetAlpha(1);
		ArcanumButton8Menu3:SetAlpha(1);
		ArcanumButton8Menu4:SetAlpha(1);
		ArcanumButton8Menu5:SetAlpha(1);
		ArcanumButton8Menu6:SetAlpha(1);
		PortalMenuCreate[1]:ClearAllPoints();
		PortalMenuCreate[1]:SetPoint("CENTER", "ArcanumButton8", "CENTER", xPortalMenuPos, yPortalMenuPos);
		AlphaPortalVar = GetTime() + 6;
	end
end

-- Gestion des casts du menu des portails
function Arcanum_PortalCast(type)
	local ville;
	if (ARCANUM_SPELL_TABLE.ID[type] ~= nil) then
  		CastSpell(ARCANUM_SPELL_TABLE.ID[type], "spell");
		ville = type - 19;
		ArcanumConfig.LastPortal = type;
	elseif (ARCANUM_SPELL_TABLE.ID[type+3] ~= nil) then
		CastSpell(ARCANUM_SPELL_TABLE.ID[type+3], "spell");
		ville = type - 16;
		ArcanumConfig.LastPortal = type + 3;
	end
    if ArcanumConfig.InterfaceVersion == 1 then
        ArcanumButton8Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastPortal]);
        OrderButton8Texture:SetTexture(ARCANUM_SPELL_TABLE.Texture[ArcanumConfig.LastPortal]);
        if ArcanumConfig.LastPortal >= 14 and ArcanumConfig.LastPortal <=19 then
            if ArcanumRuneOfTeleportation == 0 then
                ArcanumButton8Text:SetText("");
                ArcanumButton8Texture:SetDesaturated(1);
            else
                ArcanumButton8Text:SetText(ArcanumRuneOfTeleportation);
                ArcanumButton8Texture:SetDesaturated(nil);
            end
        else
            if ArcanumRuneOfPortals == 0 then
                ArcanumButton8Text:SetText("");
                ArcanumButton8Texture:SetDesaturated(1);
            else
                ArcanumButton8Text:SetText(ArcanumRuneOfPortals);
                ArcanumButton8Texture:SetDesaturated(nil);
            end
        end
    end
	AlphaPortalMenu = 1;
	AlphaPortalVar = GetTime() + 3;
	
	if ArcanumConfig.PortalMessage == true and type >= 20 then
		local tempnum = random(1, table.getn(ARCANUM_PORTAL_MESSAGES));
		while tempnum == TPMess and table.getn(ARCANUM_PORTAL_MESSAGES) >= 2 do
			tempnum = random(1, table.getn(ARCANUM_PORTAL_MESSAGES));
		end
		TPMess = tempnum;
		for i = 1, table.getn(ARCANUM_PORTAL_MESSAGES[tempnum]) do
			Arcanum_Msg(Arcanum_MsgReplace(ARCANUM_PORTAL_MESSAGES[tempnum][i], ville), "WORLD");
		end
	end
end

function Arcanum_MountMenu(button)
    if button == "LeftButton" and ArcanumConfig.LastMount ~= 0 then
		Arcanum_MountCast(ArcanumConfig.LastMount);
		return;
    elseif button == "MiddleButton" then
        Arcanum_UseItem("Hearthstone");
        return;
	end
	
	MountMenuShow = not MountMenuShow;
	if not MountMenuShow then
		MountShow = false;
		MountVisible = false;
		MountMenuCreate[1]:ClearAllPoints();
		MountMenuCreate[1]:SetPoint("CENTER", "ArcanumButton7", "CENTER", 3000, 3000);
		AlphaMountMenu = 1;
	else
		MountShow = true;
		-- Si clic milieu, le menu des monture reste ouvert
		if button == "MiddleButton" then
			MountVisible = true;
		end
		-- S'il n'existe aucune monture on ne fait rien
		if MountMenuCreate[1] == nil then
			return;
		end
		-- Sinon on affiche les icones
		ArcanumButton7Menu1:SetAlpha(1);
		ArcanumButton7Menu2:SetAlpha(1);
		ArcanumButton7Menu3:SetAlpha(1);
		ArcanumButton7Menu4:SetAlpha(1);
        ArcanumButton7Menu5:SetAlpha(1);
		ArcanumButton7Menu6:SetAlpha(1);
		MountMenuCreate[1]:ClearAllPoints();
		MountMenuCreate[1]:SetPoint("CENTER", "ArcanumButton7", "CENTER", xMountMenuPos, yMountMenuPos);
		AlphaMountVar = GetTime() + 6;
	end
end

function Arcanum_MountCast(type, button)
    if button == "MiddleButton" then
        Arcanum_UseItem("Hearthstone");
        return;
	end
    local Mounted = nil;
    for i = 0, 23 do
        buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|PASSIVE");
        if ( buffIndex < 0 ) then
            break;
        elseif ( untilCancelled ) then
            ArcanumTooltip:SetPlayerBuff(buffIndex);
            if (ArcanumTooltipTextLeft2:IsShown()) then
                text = ArcanumTooltipTextLeft2:GetText();
                if (text) then
                    _, _, speed = string.find(text, MOUNT_SPEED);
                    if (speed) then
                        Mounted = i;
                    end
                end
            end
        end
    end
    if Mounted == nil then
        if ArcanumConfig.RandMount == true then
            local randnum;
            if GetRealZoneText() == "Ahn'Qiraj" then
                randnum = random(1, table.getn(AQMountLocation));
            else
                randnum = random(1, table.getn(MountLocation) - table.getn(AQMountLocation));
            end
            if table.getn(AQMountLocation) > 1 then
                while randnum == RandMount do
                    if GetRealZoneText() == "Ahn'Qiraj" then
                        randnum = random(1, table.getn(AQMountLocation));
                    else
                        randnum = random(1, table.getn(MountLocation) - table.getn(AQMountLocation));
                    end
                end
            end
            RandMount = randnum;
            if GetRealZoneText() == "Ahn'Qiraj" then
                UseContainerItem(AQMountLocation[RandMount][1], AQMountLocation[RandMount][2]);
            else
                UseContainerItem(MountLocation[RandMount][1], MountLocation[RandMount][2]);
            end
            ArcanumButton7Texture:SetTexture(MountIcon[RandMount]);
            OrderButton7Texture:SetTexture(MountIcon[RandMount]);
            ArcanumConfig.LastMount = RandMount;
        else
            UseContainerItem(MountLocation[type][1], MountLocation[type][2]);
            ArcanumButton7Texture:SetTexture(MountIcon[type]);
            OrderButton7Texture:SetTexture(MountIcon[type]);
            ArcanumConfig.LastMount = type;
        end
    else
        CancelPlayerBuff(Mounted);
    end
	AlphaMountMenu = 1;
	AlphaMountVar = GetTime() + 3;
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE GESTION DES COMBOBOX

------------------------------------------------------------------------------------------------------

function ArcanumInsideDisplayDropDown_Initialize()
	local index;
	local info = {};
	
	for i in pairs(ArcanumInsideDisplayClick) do
		info.text = ArcanumInsideDisplayClick[i];
		info.checked = nil;
		info.func = ArcanumInsideDisplayDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function ArcanumInsideDisplayDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(ArcanumInsideDisplayDropDown, this:GetID());
    ArcanumConfig.InsideDisplay = this:GetID();
end

function ArcanumLeftClickDropDown_Initialize()
	local index;
	local info = {};
	
	for i in pairs(ArcanumLeftButtonClick) do
		info.text = ArcanumLeftButtonClick[i];
		info.checked = nil;
		info.func = ArcanumLeftClickDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function ArcanumLeftClickDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(ArcanumLeftClickDropDown, this:GetID());
    ArcanumConfig.LeftClick = this:GetID();
end

function ArcanumMiddleClickDropDown_Initialize()
	local index;
	local info = {};
	
	for i in pairs(ArcanumMiddleButtonClick) do
		info.text = ArcanumMiddleButtonClick[i];
		info.checked = nil;
		info.func = ArcanumMiddleClickDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function ArcanumMiddleClickDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(ArcanumMiddleClickDropDown, this:GetID());
    ArcanumConfig.MiddleClick = this:GetID();
end

function ArcanumRightClickDropDown_Initialize()
	local index;
	local info = {};
	
	for i in pairs(ArcanumRightButtonClick) do
		info.text = ArcanumRightButtonClick[i];
		info.checked = nil;
		info.func = ArcanumRightClickDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function ArcanumRightClickDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(ArcanumRightClickDropDown, this:GetID());
    ArcanumConfig.RightClick = this:GetID(); 
end

function Arcanum_FillClickTable(table)
    ClearTable(table);
    for i = 1, table.getn(ARCANUM_CLICK) do
        table.insert(table, ARCANUM_CLICK[i]);
    end
end

function Arcanum_Click(button)
    if (button == 1) then
        Arcanum_UseItem("Evocation");
    elseif (button == 2) then
        if (UnitHealth("Player") < UnitHealthMax("Player")) then
            Arcanum_UseItem("Food", "LeftButton");
        end
        if (UnitMana("Player") < UnitManaMax("Player")) then
            Arcanum_UseItem("Water", "LeftButton");
        end
    elseif (button == 3) then
        if (ArcanumConfig.InterfaceVersion == 2) then
            if (ArcanumConfig.BuffType == 0) then
                --On passe de 'Solo' à 'en groupe'
                if (ARCANUM_SPELL_TABLE.ID[3] ~= nil or ARCANUM_SPELL_TABLE.ID[5] ~= nil or ARCANUM_SPELL_TABLE.ID[7] ~= nil or ARCANUM_SPELL_TABLE.ID[20] ~= nil or ARCANUM_SPELL_TABLE.ID[21] ~= nil or ARCANUM_SPELL_TABLE.ID[22] ~= nil or ARCANUM_SPELL_TABLE.ID[23] ~= nil or ARCANUM_SPELL_TABLE.ID[24] ~= nil or ARCANUM_SPELL_TABLE.ID[25] ~= nil) then
                    ArcanumConfig.BuffType = 1;
                    Arcanum_Arcanum2ButtonSetup();
                    Arcanum_LoadIconsV2();
                end
            else
                --On passe de 'en groupe' à 'Solo'
                ArcanumConfig.BuffType = 0;
                Arcanum_Arcanum2ButtonSetup();
                Arcanum_LoadIconsV2();
            end
		    GameTooltip:Hide();
        end
    elseif (button == 4) then
        if (ArcanumGeneralFrame:IsVisible()) then
            HideUIPanel(ArcanumGeneralFrame);
            return;
        else
            ShowUIPanel(ArcanumGeneralFrame);
            ArcanumGeneralTab_OnClick(1);
            return;
        end
        GameTooltip:Hide();
    elseif (button == 5) then
        Arcanum_UseItem("ManaGem", "LeftButton");
    elseif (button == 6) then
        Arcanum_UseItem("Iceblock");
    elseif (button == 7) then
        Arcanum_Trade();
        ArcanumTradeNow = true;
    elseif (button == 8) then
        Arcanum_UseItem("Hearthstone");
    end
end


function Arcanum_Cooldown()
    local start, duration;
 
    CoolDown[2][3], CoolDown[2][4] = nil;
    for i = 1, 4 do
        if (ManaGemExists[i] == true) then
            CoolDown[2][3] = ManaGemLocation[i][1];
            CoolDown[2][4] = ManaGemLocation[i][2];
        end
    end
    
    for i = 1, table.getn(CoolDown) - 3 do
        start, duration = 0;
        if (CoolDown[i][3] ~= nil) then
            if (CoolDown[i][4] == nil) then
                start, duration = GetSpellCooldown(CoolDown[i][3], "spell");
            else
                start, duration = GetContainerItemCooldown(CoolDown[i][3], CoolDown[i][4]);
            end
            if (start > 0 and duration > 0) then
                cooldown = duration - GetTime() + start;
                if cooldown > 60 then
                    CoolDown[i][1] = tostring(math.ceil(cooldown / 60)).."m";
                else
                    CoolDown[i][1] = tostring(math.ceil(cooldown)).."s";
                end
                if CoolDown[i][2] == true and cooldown > 10 then
                    CoolDown[i][2] = false;
                end
            else
                CoolDown[i][1] = nil;
            end
        end
    end

    CoolDown[6][1] = nil;
    CoolDown[7][1] = nil;
    CoolDown[8][1] = nil;
    --Temps restant d'intell et armure
    for i = 0, 23 do
        buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|HARMFUL|PASSIVE");
        if ( buffIndex < 0 ) then
            break;
        elseif ( untilCancelled ) then
            ArcanumTooltip:SetPlayerBuff(buffIndex);
            if (ArcanumTooltipTextLeft1:IsShown()) then
                local text = ArcanumTooltipTextLeft1:GetText();
                local time = GetPlayerBuffTimeLeft(buffIndex)
                if time ~= nil then
                    if time > 60 then
                        time = tostring(math.ceil(time / 60)).."m";
                    else
                        time = tostring(math.ceil(time)).."s";
                    end
                end
                if (text) then
                    if (text == ARCANUM_SPELL_TABLE.Name[1] or text == ARCANUM_SPELL_TABLE.Name[2]) then
                        ArcanumButtonDisplayTexture[7] = ARCANUM_SPELL_TABLE.Texture[1];
                        CoolDown[7][1] = time;
                        if CoolDown[7][2] == true then
                            CoolDown[7][2] = false;
                        end
                    elseif (text == ARCANUM_SPELL_TABLE.Name[3]) then
                        ArcanumButtonDisplayTexture[7] = ARCANUM_SPELL_TABLE.Texture[3];
                        CoolDown[7][1] = time;
                        if CoolDown[7][2] == true then
                            CoolDown[7][2] = false;
                        end
                    elseif (text == ARCANUM_SPELL_TABLE.Name[4]) then
                        ArcanumButtonDisplayTexture[6] = ARCANUM_SPELL_TABLE.Texture[4];
                        CoolDown[6][1] = time;
                        if CoolDown[6][2] == true then
                            CoolDown[6][2] = false;
                        end
                    elseif (text == ARCANUM_SPELL_TABLE.Name[5]) then
                        ArcanumButtonDisplayTexture[6] = ARCANUM_SPELL_TABLE.Texture[5];
                        CoolDown[6][1] = time;
                        if CoolDown[6][2] == true then
                            CoolDown[6][2] = false;
                        end
                    elseif (text == ARCANUM_BANDAGE) then
                        CoolDown[8][1] = time;
                        if CoolDown[8][2] == true then
                            CoolDown[8][2] = false;
                        end
                    end
                end
            end
        end
    end
end

function Arcanum_MenuFading()
    local curTime = GetTime();
	-- Gestion du menu des Buffs
	if BuffShow then
		if GetTime() >= AlphaBuffVar and AlphaBuffMenu > 0 and (not BuffVisible) then
			AlphaBuffVar = GetTime() + 0.1;
			ArcanumButton4Menu1:SetAlpha(AlphaBuffMenu);
			ArcanumButton4Menu2:SetAlpha(AlphaBuffMenu);
			AlphaBuffMenu = AlphaBuffMenu - 0.1;
		end
		if AlphaBuffMenu <= 0 then
			Arcanum_BuffMenu();
		end
	end
	if ArmorShow then
		if GetTime() >= AlphaArmorVar and AlphaArmorMenu > 0 and (not ArmorVisible) then
			AlphaArmorVar = GetTime() + 0.1;
			ArcanumButton5Menu1:SetAlpha(AlphaArmorMenu);
			ArcanumButton5Menu2:SetAlpha(AlphaArmorMenu);
			AlphaArmorMenu = AlphaArmorMenu - 0.1;
		end
		if AlphaArmorMenu <= 0 then
			Arcanum_ArmorMenu();
		end
	end
	if MagicShow then
		if GetTime() >= AlphaMagicVar and AlphaMagicMenu > 0 and (not MagicVisible) then
			AlphaMagicVar = GetTime() + 0.1;
			ArcanumButton6Menu1:SetAlpha(AlphaMagicMenu);
			ArcanumButton6Menu2:SetAlpha(AlphaMagicMenu);
			AlphaMagicMenu = AlphaMagicMenu - 0.1;
		end
		if AlphaMagicMenu <= 0 then
			Arcanum_MagicMenu();
		end
	end
	-- Gestion du menu des portails
	if PortalShow then
		if GetTime() >= AlphaPortalVar and AlphaPortalMenu > 0 and (not PortalVisible) then
			AlphaPortalVar = GetTime() + 0.1;
			ArcanumButton8Menu1:SetAlpha(AlphaPortalMenu);
			ArcanumButton8Menu2:SetAlpha(AlphaPortalMenu);
			ArcanumButton8Menu3:SetAlpha(AlphaPortalMenu);
			ArcanumButton8Menu4:SetAlpha(AlphaPortalMenu);
			ArcanumButton8Menu5:SetAlpha(AlphaPortalMenu);
			ArcanumButton8Menu6:SetAlpha(AlphaPortalMenu);
			AlphaPortalMenu = AlphaPortalMenu - 0.1;
		end
		if AlphaPortalMenu <= 0 then
			Arcanum_PortalMenu();
		end
	end
    -- Gestion du menu des montures
	if MountShow then
		if GetTime() >= AlphaMountVar and AlphaMountMenu > 0 and (not MountVisible) then
			AlphaMountVar = GetTime() + 0.1;
			ArcanumButton7Menu1:SetAlpha(AlphaMountMenu);
			ArcanumButton7Menu2:SetAlpha(AlphaMountMenu);
			ArcanumButton7Menu3:SetAlpha(AlphaMountMenu);
			ArcanumButton7Menu4:SetAlpha(AlphaMountMenu);
            ArcanumButton7Menu5:SetAlpha(AlphaMountMenu);
			ArcanumButton7Menu6:SetAlpha(AlphaMountMenu);
			AlphaMountMenu = AlphaMountMenu - 0.1;
		end
		if AlphaMountMenu <= 0 then
			Arcanum_MountMenu();
		end
	end
end


function Arcanum_SpellManagement()

end

function Arcanum_SelectButtonOrder(Id)
    SelectedOrderButton = Id;
    for i = 1, 10 do
        Button = getglobal("OrderButton"..i.."Texture2");
        Button:SetTexture(UIPath.."ButtonCircle");
    end
    Button = getglobal("OrderButton"..Id.."Texture2");
    Button:SetVertexColor(ArcanumConfig.ButtonColor.r, ArcanumConfig.ButtonColor.g, ArcanumConfig.ButtonColor.b);
end

function Arcanum_SwitchButtonOrder(Way)
    if SelectedOrderButton ~= nil then
        local Temp = Arcanum_FindButton(SelectedOrderButton);
        if Temp == 1 and Way == -1 then
            ArcanumConfig.ButtonsOrder[Temp] = ArcanumConfig.ButtonsOrder[10];
            ArcanumConfig.ButtonsOrder[10] = SelectedOrderButton;
        elseif Temp == 10 and Way == 1 then
            ArcanumConfig.ButtonsOrder[Temp] = ArcanumConfig.ButtonsOrder[1];
            ArcanumConfig.ButtonsOrder[1] = SelectedOrderButton;
        else
            ArcanumConfig.ButtonsOrder[Temp] = ArcanumConfig.ButtonsOrder[Temp + Way];
            ArcanumConfig.ButtonsOrder[Temp + Way] = SelectedOrderButton;
        end
        Arcanum_UpdateButtonsScale();
    end
end

function Arcanum_FindButton(Id)
    for i = 1, table.getn(ArcanumConfig.ButtonsOrder) do
        if ArcanumConfig.ButtonsOrder[i] == Id then
            return i;
        end
    end
end







function Arcanum_ButtonMouseOver(button, menu)
    local Button;
    if menu == nil then
        if button <= 10 then
            Button = getglobal("ArcanumButton"..button.."Texture2");
        else
            Button = getglobal("OrderButton"..(button-10).."Texture2");
        end
    else
        Button = getglobal("ArcanumButton"..button.."Menu"..menu.."Texture2");
    end
    Button:SetVertexColor(ArcanumConfig.ButtonColor.r, ArcanumConfig.ButtonColor.g, ArcanumConfig.ButtonColor.b);
end

function Arcanum_ButtonNormal(button, menu)
    local Button;
    if menu == nil then
        if button <= 10 then
            Button = getglobal("ArcanumButton"..button.."Texture2");
        else
            Button = getglobal("OrderButton"..(button-10).."Texture2");
        end
    else
        Button = getglobal("ArcanumButton"..button.."Menu"..menu.."Texture2");
    end
    if SelectOrderButton ~= nil then
        if button ~= (SelectedOrderButton + 10) then
            Button:SetVertexColor(1, 1, 1);
        end
    else
        Button:SetVertexColor(1, 1, 1);
    end
end





function ArcanumButton_TextDisplay()
    ArcanumButtonDisplay = {
        {"|CFF00FF00"..tostring(UnitHealth("player")), floor(UnitHealth("player") / UnitHealthMax("player") * 100)},
        {"|CFF0000FF"..tostring(UnitMana("player")), floor(UnitMana("player") / UnitManaMax("player") * 100)},
        CoolDown[2][1],
        CoolDown[3][1],
        CoolDown[4][1],
        CoolDown[5][1],
        IntellCooldown,
        ArmorCooldown,
        BandageCooldown,
    };

    --local size = 58 * p;
    --ArcanumButtonTexture3:SetHeight(size);
	--ArcanumButtonTexture3:SetTexCoord(0, 1, (1-p), 1);
    
    local p = UnitHealth("player") / UnitHealthMax("player");
    p = floor(UnitMana("player") / UnitManaMax("player"));
    Arcanum_DisplayMana(ArcanumButtonDisplay[2][2]);
    Arcanum_DisplayHealth(ArcanumButtonDisplay[1][2]);
    
    if ArcanumButtonDisplayImage == nil and ArcanumConfig.InsideDisplay < 3 then
        ArcanumButtonText:SetText(ArcanumButtonDisplay[ArcanumConfig.InsideDisplay][1].."\n"..ArcanumButtonDisplay[ArcanumConfig.InsideDisplay][2].."%");
    else
        ArcanumButtonText:SetText("");
    end
    
    if (CoolDown[2][1] ~= nil) then
		ArcanumManaGemCooldown:SetText(CoolDown[2][1]);
	elseif ManaGemCount ~= 0 then
		ArcanumManaGemCooldown:SetText(ManaGemCount);
	else
		ArcanumManaGemCooldown:SetText("");
	end
end

function ArcanumButton_ImageDisplay()
    ArcanumButtonDisplayImage = Arcanum_DisplayNextImage();
    ArcanumButton_TextDisplay();
    if ArcanumButtonDisplayImage ~= nil then
        ArcanumButtonTexture2:SetTexture(ArcanumButtonDisplayTexture[ArcanumButtonDisplayImage]);
        CoolDown[ArcanumButtonDisplayImage][2] = true;
    else
        ArcanumButtonTexture2:SetTexture(nil);
    end
end

function Arcanum_DisplayNextImage()
    local Next = nil;
    for j = 1, 8 do
        if ArcanumConfig.Display[j] == true then
            if CoolDown[j][1] == nil and CoolDown[j][2] == false then
                Next = j;
                return Next;
            end
        end
    end
    return Next;
end

function Arcanum_DisplayNext(start)
    local Next = nil;
    for i = 1, 2 do
        for j = start + 1, 9 do
            if ArcanumConfig.Display[j] == true then
                if ArcanumButtonDisplay[j] ~= nil then
                    if ArcanumConfig.DisplayWhenReady == true then
                    else
                        Next = j;
                        return Next;
                    end
                else
                    Next = j;
                    return Next;
                end
            end
        end
        start = 0;
    end
    return Next;
end

function Arcanum_DisplayFading()
    --if ArcanumConfig.DisplayWhenReady == true and ArcanumButtonDisplay[ArcanumButtonDisplayValue] ~= nil then
        if DisplayFadingLimit == 0 then
            if AlphaDisplay <= DisplayFadingLimit then
                DisplayFadingWay = - DisplayFadingWay;
                DisplayFadingLimit = 1;
            end
        else
            if AlphaDisplay >= DisplayFadingLimit then
                DisplayFadingWay = - DisplayFadingWay;
                DisplayFadingLimit = 0;
            end
        end
        if GetTime() >= AlphaDisplayVar then
			AlphaDisplayVar = GetTime() + 0.1;
            ArcanumButtonTexture2:SetAlpha(AlphaDisplay);
            AlphaDisplay = AlphaDisplay + (DisplayFadingWay * (0.1/1));
            if AlphaDisplay < 0 then
                AlphaDisplay = 0;
            elseif AlphaDisplay > 1 then
                AlphaDisplay = 1;
            end
		end
    --end
end

function Arcanum_RotateTexture(t, angle)
    local H = 1 / (2 * cos(45));
    local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
    ULx, ULy = H * cos(angle - 135) + 0.5, H * sin(angle - 135) + 0.5;
	LLx, LLy = H * cos(angle + 135) + 0.5, H * sin(angle + 135) + 0.5;
	URx, URy = H * cos(angle - 45) + 0.5, H * sin(angle - 45) + 0.5;
	LRx, LRy = H * cos(angle + 45) + 0.5, H * sin(angle + 45) + 0.5;
	t:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

function Arcanum_DisplayMana(p)
    for i = 1, 100 do
        angle = - 1.8 * (i-1);
        Arcanum_RotateTexture(getglobal("ArcanumButtonManaTexture"..i), angle)
        if i <= (100-p) then
            getglobal("ArcanumButtonManaTexture"..i):SetTexture(nil);
        else
            getglobal("ArcanumButtonManaTexture"..i):SetTexture(UIPath.."Circle");
        end
        if p >= 50 then
            getglobal("ArcanumButtonManaTexture"..i):SetVertexColor(ArcanumConfig.ManaColor.r, ArcanumConfig.ManaColor.g, ArcanumConfig.ManaColor.b);
        else
            getglobal("ArcanumButtonManaTexture"..i):SetVertexColor(ArcanumConfig.ManaColor.r+1, ArcanumConfig.ManaColor.g, ArcanumConfig.ManaColor.b);
        end
        getglobal("ArcanumButtonManaTexture"..i):SetBlendMode("BLEND");
    end
end

function Arcanum_DisplayHealth(p)
    for i = 1, 100 do
        angle = 1.8 * i;
        Arcanum_RotateTexture(getglobal("ArcanumButtonHealthTexture"..i), angle)
        if i <= (100-p) then
            getglobal("ArcanumButtonHealthTexture"..i):SetTexture(nil);
        else
            getglobal("ArcanumButtonHealthTexture"..i):SetTexture(UIPath.."Circle");
        end
        getglobal("ArcanumButtonHealthTexture"..i):SetVertexColor(ArcanumConfig.HealthColor.r, ArcanumConfig.HealthColor.g, ArcanumConfig.HealthColor.b);
        getglobal("ArcanumButtonHealthTexture"..i):SetBlendMode("BLEND");
    end
end

function Arcanum_HealthColor()
    ArcanumConfig.HealthColor.r,ArcanumConfig.HealthColor.g,ArcanumConfig.HealthColor.b = ColorPickerFrame:GetColorRGB();
end

function Arcanum_ManaColor()
    ArcanumConfig.ManaColor.r,ArcanumConfig.ManaColor.g,ArcanumConfig.ManaColor.b = ColorPickerFrame:GetColorRGB();
end

function Arcanum_ButtonColor()
    ArcanumConfig.ButtonColor.r,ArcanumConfig.ButtonColor.g,ArcanumConfig.ButtonColor.b = ColorPickerFrame:GetColorRGB();
    ArcanumMinimapButtonTexture2:SetVertexColor(ArcanumConfig.ButtonColor.r, ArcanumConfig.ButtonColor.g, ArcanumConfig.ButtonColor.b);
end

function Arcanum_CancelHealthColor()
	local color = ColorPickerFrame.previousValues;
	--ColorPickerFrame:SetBackdropColor(color.r, color.g, color.b);
    ArcanumConfig.HealthColor = color;
end

function Arcanum_CancelManaColor()
	local color = ColorPickerFrame.previousValues;
	--ColorPickerFrame:SetBackdropColor(color.r, color.g, color.b);
    ArcanumConfig.ManaColor = color;
end

function Arcanum_CancelButtonColor()
	local color = ColorPickerFrame.previousValues;
	--ColorPickerFrame:SetBackdropColor(color.r, color.g, color.b);
    ArcanumConfig.ButtonColor = color;
end

function Arcanum_HealthColorClick()
    local color = {};
    color.r = ArcanumConfig.HealthColor.r;
    color.g = ArcanumConfig.HealthColor.g;
    color.b = ArcanumConfig.HealthColor.b;
    ColorPickerFrame.previousValues = color;
    ColorPickerFrame.cancelFunc = Arcanum_CancelHealthColor;
    ColorPickerFrame.func = Arcanum_HealthColor;
    ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
    ColorPickerFrame:Show();
end

function Arcanum_ManaColorClick()
    local color = {};
    color.r = ArcanumConfig.ManaColor.r;
    color.g = ArcanumConfig.ManaColor.g;
    color.b = ArcanumConfig.ManaColor.b;
    ColorPickerFrame.previousValues = color;
    ColorPickerFrame.cancelFunc = Arcanum_CancelManaColor;
    ColorPickerFrame.func = Arcanum_ManaColor;
    ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
    ColorPickerFrame:Show();
end

function Arcanum_ButtonColorClick()
    local color = {};
    color.r = ArcanumConfig.ButtonColor.r;
    color.g = ArcanumConfig.ButtonColor.g;
    color.b = ArcanumConfig.ButtonColor.b;
    ColorPickerFrame.previousValues = color;
    ColorPickerFrame.cancelFunc = Arcanum_CancelButtonColor;
    ColorPickerFrame.func = Arcanum_ButtonColor;
    ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
    ColorPickerFrame:Show();
end

