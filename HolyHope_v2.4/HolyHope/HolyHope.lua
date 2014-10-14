------------------------------------------------------------------------------------------------------
-- HolyHope 2.4

-- Addon pour Paladin
-- Gestion des benedictions et Compteur de sympbole des rois

-- Remerciements aux auteurs de Necrosis et KingsCounter

-- Remerciements speciaux à Erosenin, guilde Exodius, Designer de HolyHope

-- Auteur Freeman 
-- Pour reporter un bug ou une idée d'amélioration: THEFREEMAN55@free.fr

-- Serveur:
-- Freeman, guilde Exodius, Ner'Zhul FR
------------------------------------------------------------------------------------------------------

-- Initialisation

HolyHope_Config = nil;

HolyHope_DefaultConfig = {
 ["BlessingScale"] = 100;
 ["BlessingToogle"] = true;
 ["MountScale"] = 100;
 ["MountToogle"] = true;
 ["Movable"] = true;
 ["RedemptionToogle"] = true;
 ["RedemptionLenght"] = 50;
 ["SealScale"] = 100;
 ["SealToogle"] = true;
 ["Tooltip"] = 1;
 ["WrathToogle"] = true;
 ["WrathLenght"] = 50;
}

local auto_attack = false;
local CheckSeal = 1;
local combat = false;
local HolyHopeMounted = false;
local HolyHopeKings = 0;
local HearthstoneOnHand = false;
local HearthstoneLocation = {nil,nil};
local JudgementCD = 0;
local QuirajiMount = false;
local QuirajiMountLocation = {nil,nil};
local QuirajiMountOnHand = false;
local Load = false;
local MountOnHand = false;
local MountLocation = {nil,nil};
local MoveRedemption = false;
local MoveWrath = false;
local Original_Weap;
local PlayerFaction;
local PlayerName;
local PlayerZone;
local ReckCharges = 0; -- Charges de Reckoning
local SavedType;
local TimeMove;
local TypeBlessing = 0; -- 0 benediction perso, 1 benediction de classe



 
------------------------------------------------------------------------------------------------------

-- FONCTIONS DE L'INTERFACE

------------------------------------------------------------------------------------------------------

-- Fonction permettant le déplacement d'éléments de HolyHope sur l'écran
function HolyHope_OnDragStart(button)
  if (HolyHope_Config.Movable) then
	  button:StartMoving();
	else
	  return;
	end
end

-- Fonction arrêtant le déplacement d'éléments de HolyHope sur l'écran
function HolyHope_OnDragStop(button)
	button:StopMovingOrSizing();
end

-- Fonction lancée à la mise à jour de l'interface (main) -- toutes les 0,1 secondes environ
function HolyHope_OnUpdate()


  local start, duration, cooldown;
  
  if (Load == false) then
    HolyHope_Initialize();
    HolyHope_Toogle();
    Load = true;
  end
	
	-- On met à jour le cooldown de liberté
	if (HOLYHOPE_SPELL_TABLE.ID[9] ~= 0) then
	  start, duration = GetSpellCooldown(HOLYHOPE_SPELL_TABLE.ID[9], BOOKTYPE_SPELL);
	  if (start > 0 and duration > 0) then
	   cooldown =  floor(duration - ( GetTime() - start)) + 1;
      HolyHopeFreedomCooldown:SetText(cooldown);
    else
      HolyHopeFreedomCooldown:SetText("");
    end
  end
  
  -- On met à jour le cooldown du jugement
	if (HOLYHOPE_SPELL_TABLE.ID[23] ~= 0) then
	  start, duration = GetSpellCooldown(HOLYHOPE_SPELL_TABLE.ID[23], BOOKTYPE_SPELL);
	  if (start > 0 and duration > 0) then
	    JudgementCD =  floor(duration - ( GetTime() - start)) + 1;
      HolyHopeJudgementCooldown:SetText(JudgementCD);
      CheckSeal = 0;
    else
      HolyHopeJudgementCooldown:SetText("");
      if (CheckSeal) then
        HolyHope_OnEvent("PLAYER_AURAS_CHANGED");
      end
    end
  end
  
  -- On met à jour les cooldowns généraux
  if (HOLYHOPE_SPELL_TABLE.ID[3] ~= 0) then
    start, duration = GetSpellCooldown(HOLYHOPE_SPELL_TABLE.ID[3], BOOKTYPE_SPELL);
	  if (start > 0 and duration > 0) then
	    cooldown =  floor(duration - ( GetTime() - start)) + 1;
      for index = 1, 20, 1 do
        getglobal("Cooldown"..index):SetText(cooldown);
      end
    else
      for index = 1, 20, 1 do
        getglobal("Cooldown"..index):SetText("");
      end
    end
  end
  
  -- Si le Paladin peut caster le marteaux du courroux on affiche l'icone
  if (MoveWrath == false) then -- SI le Paladin ne veut pas bouger le boutton du marteau du courroux
  if (HOLYHOPE_SPELL_TABLE.ID[24] ~= 0) and (HolyHope_Config.WrathToogle) then -- Si le Paladin à le sort
    if (UnitCanAttack("player","target")) then -- Si le Paladin peut attaquer la cible
      local health = UnitHealth("target");
	    local maxhealth = UnitHealthMax("target"); 
	    local healthpercent = floor(health/maxhealth*100);
      if (health > 0) and (healthpercent < 20) and (UnitMana("player") >= HOLYHOPE_SPELL_TABLE.Mana[24]) then
        -- On met à jour le cooldown du marteau de courroux
        start, duration = GetSpellCooldown(HOLYHOPE_SPELL_TABLE.ID[24], BOOKTYPE_SPELL);
	      if (start > 0 and duration > 0) then
	        cooldown =  floor(duration - ( GetTime() - start)) + 1;
          HolyHopeWrathCooldown:SetText(cooldown);
        else
          HolyHopeWrathCooldown:SetText("");
        end
      HolyHopeWrathButton:Show();
      else
        HolyHopeWrathButton:Hide();
      end
    else
      HolyHopeWrathButton:Hide();
    end
  end 
  else
    HolyHope_MoveButton();
  end
  
  -- Si le Paladin peut caster Rédemption on affiche l'icone
  if (MoveRedemption == false) then -- Si le Paladin ne veut pas bouger le boutton de rédemption
    if (UnitIsDeadOrGhost("target")) then -- Si la cible est morte ou en fantome
      if (HOLYHOPE_SPELL_TABLE.ID[25] ~= 0) and (HolyHope_Config.RedemptionToogle) then -- Si le Paladin à le sort
        if (combat == false) and (UnitMana("player") >= HOLYHOPE_SPELL_TABLE.Mana[25]) then --Si Hors combat
          if (PlayerFaction == UnitFactionGroup("Target")) then -- Si la cible est de la même faction
            HolyHopeRedemptionButton:Show();
          else
            HolyHopeRedemptionButton:Hide();
          end
        else
          HolyHopeRedemptionButton:Hide();
        end
      else
        HolyHopeRedemptionButton:Hide();
      end
    else
      HolyHopeRedemptionButton:Hide();
    end
  else
    HolyHope_MoveButton();
  end        
      
end

function HolyHope_OnEvent(event)

  -- Changement de couleur suivant le mode Combat
	if (event == "PLAYER_REGEN_DISABLED") then
    combat = true;
    HolyHope_UpdateMainButton();
  elseif (event == "PLAYER_REGEN_ENABLED") then
    combat = false;
    HolyHope_UpdateMainButton();
    
  -- On met la bonne icone du jugement suivant si le Paladin à un Sceau d'activé
  elseif (event == "PLAYER_AURAS_CHANGED") then  
    if (HolyHope_SealUp() and JudgementCD <= 1) then
      HolyHopeButton2:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Judgement");
    else
      HolyHopeButton2:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Judgement2");
    end
         
  -- Si un nouveau sort est appris, on rafraichie le tableau des sorts
  elseif (event == "LEARNED_SPELL_IN_TAB" or event == "CHARACTER_POINTS_CHANGED") then
	  HolyHope_SpellSetup();
	  HolyHope_UpdateIcons();
	  HolyHope_UpdateButtonsLocation();
	  
	-- Si le contenu du sac change, on met à jour le nombre de symbole des rois
	-- Et on met l'affichage qui correspond
  elseif (event == "BAG_UPDATE") then
	  if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) ~= OriginalWeap then
	  	auto_attack = false;
		  ReckCharges = 0;
		  HolyHope_UpdateMainButton();
	  end    
	-- On met à jour les symboles des rois
	  HolyHopeKings = HolyHope_CountKings();
	  HolyHope_UpdateMainButton();

  --On supprime la bénédiction différée si la cible prochaine n'est pas buffable
  elseif (event == "PLAYER_TARGET_CHANGED") then
	  if not(UnitIsFriend("player","target")) then
	    RAZ_DelayedBlessing();	
	  end
	  if SavedType ~= nil then	
	    HolyHope_CastBlessing(SavedType,"LeftButton");
	  end	

  --Récupération du proc Reckoning  
  elseif ( event == "CHAT_MSG_SPELL_SELF_BUFF" ) then
    if ( auto_attack == false ) then       
      if (ReckCharges < 4) then
        if ( string.find(arg1, RECKONING) ~= nil ) then 
          ReckCharges = ReckCharges + 1;
          OriginalWeap = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"));
          -- Affichage du Reckoning
          HolyHope_UpdateMainButton()
        end
      end
    end

  --Gestion du mode de combat pour vidange des charges Reckoning
  elseif ( event == "PLAYER_ENTER_COMBAT" ) then
    auto_attack = true;

  --Condition de suppression des charges Reckoning: Sortie de combat
  elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
    auto_attack = false;
	  ReckCharges = 0;
	  HolyHope_UpdateMainButton();

  --Condition de suppression des charges Reckoning: Mort
  elseif ( event == "PLAYER_DEAD" ) then
    auto_attack = false;
    ReckCharges = 0;
    HolyHope_UpdateMainButton();
    
  --Condition de suppression des charges Reckoning: Toucher la cible
  elseif ( event == "CHAT_MSG_COMBAT_SELF_HITS" ) then
    if ( string.find(arg1, YOUHIT) ~= nil or string.find(arg1, YOUCRIT) ~= nil) then
      ReckCharges = 0;
      HolyHope_UpdateMainButton();
	  end

  --Condition de suppression des charges Reckoning: Rater la cible
  elseif ( event == "CHAT_MSG_COMBAT_SELF_MISSES" ) then
    ReckCharges = 0;
    HolyHope_UpdateMainButton();
  end
end

-- Aspet des benedictions pour lancement differee en cas de non-cible
function RAZ_DelayedBlessing()
	SavedType=nil;
	SetCursor("nil");
	HolyHopeMightButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Might");
	HolyHopeWisdomButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Wisdom");
end


-- Gestion du clic sur HolyHope
-- Clique gauche: Passe HolyHope en mode benediction Individuel/Classe
-- Clique droit: Pierre de Foyer
function HolyHope_OnClick(button)
  if button == "RightButton" then
   HolyHope_UseItem("Hearthstone");
  else
    if (TypeBlessing == 0) then
      TypeBlessing = 1;
		  HideUIPanel(HolyHopeMightButton);
		  HideUIPanel(HolyHopeWisdomButton);
		  HideUIPanel(HolyHopeSalvationButton);
		  HideUIPanel(HolyHopeLightButton);
	   	HideUIPanel(HolyHopeKingsButton);
	   	HideUIPanel(HolyHopeSanctuaryButton);
	   	if (HOLYHOPE_SPELL_TABLE.ID[11] ~= 0) then
		    ShowUIPanel(HolyHopeMightUpButton);
		  end
		  if (HOLYHOPE_SPELL_TABLE.ID[12] ~= 0) then
		    ShowUIPanel(HolyHopeWisdomUpButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[13] ~= 0) then
		    ShowUIPanel(HolyHopeSalvationUpButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[14] ~= 0) then
		    ShowUIPanel(HolyHopeLightUpButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[15] ~= 0) then
		    ShowUIPanel(HolyHopeKingsUpButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[16] ~= 0) then
		    ShowUIPanel(HolyHopeSanctuaryUpButton);
		  end  
    else
      TypeBlessing= 0;
		  if (HOLYHOPE_SPELL_TABLE.ID[3] ~= 0) then
		    ShowUIPanel(HolyHopeMightButton);
		  end
		  if (HOLYHOPE_SPELL_TABLE.ID[4] ~= 0) then
		    ShowUIPanel(HolyHopeWisdomButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[5] ~= 0) then
		    ShowUIPanel(HolyHopeSalvationButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[6] ~= 0) then
		    ShowUIPanel(HolyHopeLightButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[7] ~= 0) then
		    ShowUIPanel(HolyHopeKingsButton);
		  end
      if (HOLYHOPE_SPELL_TABLE.ID[8] ~= 0) then
		    ShowUIPanel(HolyHopeSanctuaryButton);
		  end
		  HideUIPanel(HolyHopeMightUpButton);
		  HideUIPanel(HolyHopeWisdomUpButton);
		  HideUIPanel(HolyHopeSalvationUpButton);
		  HideUIPanel(HolyHopeLightUpButton);
		  HideUIPanel(HolyHopeKingsUpButton);
		  HideUIPanel(HolyHopeSanctuaryUpButton);  
    end
  GameTooltip:Hide();
  end
end

-- Efface toutes les positions des bouttons
function HolyHope_ClearAllPoints()

  HolyHopeButton:ClearAllPoints();
	HolyHopeButton2:ClearAllPoints();
	HolyHopeMountButton:ClearAllPoints();
	
	HolyHopeMightButton:ClearAllPoints();
  HolyHopeWisdomButton:ClearAllPoints();
	HolyHopeSalvationButton:ClearAllPoints();
	HolyHopeLightButton:ClearAllPoints();
  HolyHopeKingsButton:ClearAllPoints();
	HolyHopeSanctuaryButton:ClearAllPoints();
	HolyHopeFreedomButton:ClearAllPoints();
	HolyHopeSacrificeButton:ClearAllPoints();	          
	HolyHopeMightUpButton:ClearAllPoints();
	HolyHopeWisdomUpButton:ClearAllPoints();
	HolyHopeSalvationUpButton:ClearAllPoints();
	HolyHopeLightUpButton:ClearAllPoints();	
  HolyHopeKingsUpButton:ClearAllPoints();            
	HolyHopeSanctuaryUpButton:ClearAllPoints();
	
	HolyHopeSCommandButton:ClearAllPoints();
	HolyHopeSCrusaderButton:ClearAllPoints();
	HolyHopeSJusticeButton:ClearAllPoints();
	HolyHopeSLightButton:ClearAllPoints();
	HolyHopeSRighteousnessButton:ClearAllPoints();
	HolyHopeSWisdomButton:ClearAllPoints();
	
end

function HolyHope_UpdateButtonScale(button)
  
  if (button == "Button") then
	  HolyHopeButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeMightButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeWisdomButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeSalvationButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeLightButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeKingsButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeSanctuaryButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeFreedomButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeSacrificeButton:SetScale(HolyHope_Config.BlessingScale / 100);	          
	  HolyHopeMightUpButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeWisdomUpButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeSalvationUpButton:SetScale(HolyHope_Config.BlessingScale / 100);
	  HolyHopeLightUpButton:SetScale(HolyHope_Config.BlessingScale / 100);	
    HolyHopeKingsUpButton:SetScale(HolyHope_Config.BlessingScale / 100);            
	  HolyHopeSanctuaryUpButton:SetScale(HolyHope_Config.BlessingScale / 100);	
	elseif (button == "Button2") then
	  HolyHopeButton2:SetScale(HolyHope_Config.SealScale / 100);
	  HolyHopeSJusticeButton:SetScale(HolyHope_Config.SealScale / 100);
	  HolyHopeSRighteousnessButton:SetScale(HolyHope_Config.SealScale / 100);
	  HolyHopeSCrusaderButton:SetScale(HolyHope_Config.SealScale / 100);
	  HolyHopeSCommandButton:SetScale(HolyHope_Config.SealScale / 100);
	  HolyHopeSWisdomButton:SetScale(HolyHope_Config.SealScale / 100);
	  HolyHopeSLightButton:SetScale(HolyHope_Config.SealScale / 100);
	else
	  HolyHopeMountButton:SetScale(HolyHope_Config.MountScale / 100);
	end
  
end

-- On cachent les benedictions si le paladin ne les a pas
function HolyHope_UpdateIcons()
  
  if (HOLYHOPE_SPELL_TABLE.ID[1] == 0 and HOLYHOPE_SPELL_TABLE.ID[2] == 0) then
    HideUIPanel(HolyHopeMountButton);
  end  
  if (HOLYHOPE_SPELL_TABLE.ID[3] == 0) then
    HideUIPanel(HolyHopeMightButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[4] == 0) then
    HideUIPanel(HolyHopeWisdomButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[5] == 0) then
    HideUIPanel(HolyHopeSalvationButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[6] == 0) then
    HideUIPanel(HolyHopeLightButton);
  else
  end 
  if (HOLYHOPE_SPELL_TABLE.ID[7] == 0) then
    HideUIPanel(HolyHopeKingsButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[8] == 0) then
    HideUIPanel(HolyHopeSanctuaryButton);
  else
  end 
  if (HOLYHOPE_SPELL_TABLE.ID[9] == 0) then
    HideUIPanel(HolyHopeFreedomButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[10] == 0) then
    HideUIPanel(HolyHopeSacrificeButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[11] == 0) then
    HideUIPanel(HolyHopeMightUpButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[12] == 0) then
    HideUIPanel(HolyHopeWisdomUpButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[13] == 0) then
    HideUIPanel(HolyHopeSalvationUpButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[14] == 0) then
    HideUIPanel(HolyHopeLightUpButton);
  else
  end 
  if (HOLYHOPE_SPELL_TABLE.ID[15] == 0) then
    HideUIPanel(HolyHopeKingsUpButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[16] == 0) then
    HideUIPanel(HolyHopeSanctuaryUpButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[17] == 0) then
    HideUIPanel(HolyHopeSCommandButton);    
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[18] == 0) then
    HideUIPanel(HolyHopeSCrusaderButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[19] == 0) then
    HideUIPanel(HolyHopeSJusticeButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[20] == 0) then
    HideUIPanel(HolyHopeSLightButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[21] == 0) then
    HideUIPanel(HolyHopeSRighteousnessButton);
  else
  end
  if (HOLYHOPE_SPELL_TABLE.ID[22] == 0) then
    HideUIPanel(HolyHopeSWisdomButton);
  else
  end 
end

-- Place les bouttons au bon endroit suivant la taille des bouttons
function HolyHope_UpdateButtonsLocation()
  local NBRScale = 1.15;
	local BlessingIndexScale = -24;
	local SealIndexScale = -135;
	local IndexAdd = 45;
	
	HolyHopeKingsButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeKingsUpButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSJusticeButton:SetPoint("CENTER", "HolyHopeButton2", "CENTER", ((40 * NBRScale) * cos(SealIndexScale)), ((40 * NBRScale) * sin(SealIndexScale)));
  BlessingIndexScale = BlessingIndexScale + IndexAdd;
  SealIndexScale = SealIndexScale + IndexAdd;
	HolyHopeLightButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeLightUpButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	BlessingIndexScale = BlessingIndexScale + IndexAdd;
	SealIndexScale = SealIndexScale + IndexAdd;
	HolyHopeMightButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeMightUpButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSRighteousnessButton:SetPoint("CENTER", "HolyHopeButton2", "CENTER", ((40 * NBRScale) * cos(SealIndexScale)), ((40 * NBRScale) * sin(SealIndexScale)));
  BlessingIndexScale = BlessingIndexScale + IndexAdd;
  SealIndexScale = SealIndexScale + IndexAdd;
	HolyHopeWisdomButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeWisdomUpButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSCrusaderButton:SetPoint("CENTER", "HolyHopeButton2", "CENTER", ((40 * NBRScale) * cos(SealIndexScale)), ((40 * NBRScale) * sin(SealIndexScale)));
  BlessingIndexScale = BlessingIndexScale + IndexAdd;
  SealIndexScale = SealIndexScale + IndexAdd;
	HolyHopeSalvationButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSalvationUpButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSCommandButton:SetPoint("CENTER", "HolyHopeButton2", "CENTER", ((40 * NBRScale) * cos(SealIndexScale)), ((40 * NBRScale) * sin(SealIndexScale)));
  BlessingIndexScale = BlessingIndexScale + IndexAdd;
  SealIndexScale = SealIndexScale + IndexAdd;
	HolyHopeSanctuaryButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSanctuaryUpButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	BlessingIndexScale = BlessingIndexScale + IndexAdd;
	SealIndexScale = SealIndexScale + IndexAdd;
	HolyHopeFreedomButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSWisdomButton:SetPoint("CENTER", "HolyHopeButton2", "CENTER", ((40 * NBRScale) * cos(SealIndexScale)), ((40 * NBRScale) * sin(SealIndexScale)));
  BlessingIndexScale = BlessingIndexScale + IndexAdd;
  SealIndexScale = SealIndexScale + IndexAdd;
	HolyHopeSacrificeButton:SetPoint("CENTER", "HolyHopeButton", "CENTER", ((40 * NBRScale) * cos(BlessingIndexScale)), ((40 * NBRScale) * sin(BlessingIndexScale)));
	HolyHopeSLightButton:SetPoint("CENTER", "HolyHopeButton2", "CENTER", ((40 * NBRScale) * cos(SealIndexScale)), ((40 * NBRScale) * sin(SealIndexScale)));
end


-- Afiche l'icone du boutton principal en fonction du nombre de Symbole des rois
function HolyHope_UpdateMainButton()
  local number = 320;
  local count = -1;

  -- Gestion de l'affichage du fond en fontion du nombre de symboles et des charges de retribution
  if (ReckCharges > 0) then
    ChatFrame1:AddMessage("ReckCharge"..ReckCharges);
    HolyHopeButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\ReckCharge"..ReckCharges);
 	else
    if (combat == false) then
	    if (HolyHopeKings <= number) then
	      while (HolyHopeKings <= number) do
	        number = number - 10;
	        count = count +1;
	      end
	      count = 32 - count;
	      HolyHopeButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Symbol"..count);
	    else
	   	  HolyHopeButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Symbol32");
	    end
	    -- Affichage chiffré
	    if (HolyHopeKings == 0) then
	      HolyHopeMainCount:SetText("");
	    else
	      HolyHopeMainCount:SetText(HolyHopeKings);
	    end
	  else
	    HolyHopeButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\HolyHopeC");
	  end
	end
end

-- Creation et Affichage des bulles d'aides
function HolyHope_BuildTooltip(button, anchor, type)

  -- Creation des aides partiels
  if (HolyHope_Config.Tooltip == 1) then
    -- Definie à qui apartient la bulle d'aide
    GameTooltip:SetOwner(button, anchor);
    if (type == "Mount") then
      -- Soit c'est la monture epique
      if HOLYHOPE_SPELL_TABLE.ID[2] ~= 0 then
	   	  GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[2]);
	    -- Soit c'est la monture classique
	    elseif HOLYHOPE_SPELL_TABLE.ID[1] ~= 0 then
		    GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[1]);
		  end
    elseif (type == "Might") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[3]);
    elseif (type == "Wisdom") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[4]);
    elseif (type == "Salvation") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[5]);
    elseif (type == "Light") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[6]);
    elseif (type == "Kings") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[7]);
    elseif (type == "Sanctuary") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[8]);
    elseif (type == "Freedom") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[9]);
    elseif (type == "Sacrifice") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[10]);
    elseif (type == "MightUp") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[11]);
    elseif (type == "WisdomUp") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[12]);
    elseif (type == "SalvationUp") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[13]);
    elseif (type == "LightUp") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[14]);
    elseif (type == "KingsUp") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[15]);
    elseif (type == "SanctuaryUp") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[16]);
    elseif (type == "SCommand") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[17]);
    elseif (type == "SCrusader") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[18]);
    elseif (type == "SJustice") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[19]);
    elseif (type == "SLight") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[20]);
    elseif (type == "SRighteousness") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[21]);
    elseif (type == "SWisdom") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[22]);
    elseif (type == "Wrath") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[24]);
    elseif (type == "Redemption") then
      GameTooltip:AddLine("Mana : "..HOLYHOPE_SPELL_TABLE.Mana[25]);
    -- Soit c'est le bouton principal
    elseif (type == "HolyHopeButton") then
      GameTooltip:AddLine(HOLYHOPE_MESSAGE.TOOLTIP.Clic);
      -- Gestion mode de benediction
      if (TypeBlessing == 0) then
        GameTooltip:AppendText(HOLYHOPE_MESSAGE.TOOLTIP.NotUp);
      else
        GameTooltip:AppendText(HOLYHOPE_MESSAGE.TOOLTIP.Up);
      end
      GameTooltip:AddLine(HOLYHOPE_MESSAGE.TOOLTIP.RightClic);
    elseif (type == "HolyHopeButton2") then
      GameTooltip:AddLine(HOLYHOPE_MESSAGE.TOOLTIP.Judgement);
    end
    
    -- Creation des aides totals
    elseif (HolyHope_Config.Tooltip == 2) then
    -- Definie à qui apartient la bulle d'aide
    GameTooltip:SetOwner(button, anchor);
    if (type == "Mount") then
      -- Soit c'est la monture epique
      if HOLYHOPE_SPELL_TABLE.ID[2] ~= 0 then
	   	  GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[2],1);
	    -- Soit c'est la monture classique
	    else
		    GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[1],1);
		  end
    elseif (type == "Might") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[3],1);
    elseif (type == "Wisdom") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[4],1);
    elseif (type == "Salvation") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[5],1);
    elseif (type == "Light") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[6],1);
    elseif (type == "Kings") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[7],1);
    elseif (type == "Sanctuary") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[8],1);
    elseif (type == "Freedom") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[9],1);
    elseif (type == "Sacrifice") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[10],1);
    elseif (type == "MightUp") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[11],1);
    elseif (type == "WisdomUp") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[12],1);
    elseif (type == "SalvationUp") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[13],1);
    elseif (type == "LightUp") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[14],1);
    elseif (type == "KingsUp") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[15],1);
    elseif (type == "SanctuaryUp") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[16],1);
    elseif (type == "SCommand") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[17],1);
    elseif (type == "SCrusader") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[18],1);
    elseif (type == "SJustice") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[19],1);
    elseif (type == "SLight") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[20],1);
    elseif (type == "SRighteousness") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[21],1);
    elseif (type == "SWisdom") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[22],1);
    elseif (type == "Wrath") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[24],1);
    elseif (type == "Redemption") then
      GameTooltip:SetSpell(HOLYHOPE_SPELL_TABLE.ID[25],1);
    -- Soit c'est le bouton principal
    elseif (type == "HolyHopeButton") then
      GameTooltip:AddLine(HOLYHOPE_MESSAGE.TOOLTIP.Clic);
      -- Gestion mode de benediction
      if (TypeBlessing == 0) then
        GameTooltip:AppendText(HOLYHOPE_MESSAGE.TOOLTIP.NotUp);
      else
        GameTooltip:AppendText(HOLYHOPE_MESSAGE.TOOLTIP.Up);
      end
      GameTooltip:AddLine(HOLYHOPE_MESSAGE.TOOLTIP.RightClic);
    elseif (type == "HolyHopeButton2") then
      GameTooltip:AddLine(HOLYHOPE_MESSAGE.TOOLTIP.Judgement);
    end
  end
  -- On affiche
  GameTooltip:Show();
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE GETION DU MENU

------------------------------------------------------------------------------------------------------

-- Affichage du menu par la commande
function HolyHope_Slash()

  -- Initialisation du menu
  if (HolyHope_Config.BlessingToogle) then
    HolyHopeCheckBlessing:SetChecked(1);
  else
    HolyHopeCheckBlessing:SetChecked(nil);
  end
  if (HolyHope_Config.SealToogle) then
    HolyHopeCheckSeal:SetChecked(1);
  else
    HolyHopeCheckSeal:SetChecked(nil);
  end
  if (HolyHope_Config.MountToogle) then
    HolyHopeCheckMount:SetChecked(1);
  else
    HolyHopeCheckMount:SetChecked(nil);
  end
  if (HolyHope_Config.WrathToogle) then
    HolyHopeCheckWrath:SetChecked(1);
  else
    HolyHopeCheckWrath:SetChecked(nil);
  end
  WrathLenght:SetValue(HolyHope_Config.WrathLenght);
  if (HolyHope_Config.RedemptionToogle) then
    HolyHopeCheckRedemption:SetChecked(1);
  else
    HolyHopeCheckRedemption:SetChecked(nil);
  end
  RedemptionLenght:SetValue(HolyHope_Config.RedemptionLenght);
  HolyHopeButtonScale:SetValue(HolyHope_Config.BlessingScale);
  HolyHopeButton2Scale:SetValue(HolyHope_Config.SealScale);
  HolyHopeMountButtonScale:SetValue(HolyHope_Config.MountScale);
  if (HolyHope_Config.Tooltip == 0) then
    HolyHopeTooltipsOff:SetChecked(1);
  else
    HolyHopeTooltipsOff:SetChecked(nil);
  end
  if (HolyHope_Config.Tooltip == 1) then
   HolyHopeTooltipsPartial:SetChecked(1);
  else
    HolyHopeTooltipsPartial:SetChecked(nil);
  end
  if (HolyHope_Config.Tooltip == 2) then
    HolyHopeTooltipsTotal:SetChecked(1);
  else
    HolyHopeTooltipsTotal:SetChecked(nil);
  end
  -- On Affiche le menu, par defaut on est sur l'onglet des Options generales
  HolyHopeMenu:Show();
  HolyHope_SwitchTab(1);
  	
end

-- Gestion du changement d'onglet
function HolyHope_SwitchTab(arg)
  local TabName;
  
  -- Surligne l'onglet selectionné, remet à la normal les autres
	for index = 1, 2, 1 do
		TabName = getglobal("HolyHopeTab"..index);
		if index == arg then
			TabName:SetChecked(1);
		else
			TabName:SetChecked(nil);
		end
	end
	
	if (arg == 1) then
	  HolyHopeCheckMenu:Show();
	  HolyHopePopupMenu:Hide();
	elseif (arg == 2) then
	  HolyHopePopupMenu:Show();
	  HolyHopeCheckMenu:Hide();
	end
	
end

-- Active ou Desactive HolyHope (attention pour la desactivation on cache les bouttons, l'addon tourne toujours)
function HolyHope_Toogle()
  -- Partie Benediction
  if (HolyHope_Config.BlessingToogle == false) then
    HideUIPanel(HolyHopeButton);
		HideUIPanel(HolyHopeMightButton);
		HideUIPanel(HolyHopeWisdomButton);
		HideUIPanel(HolyHopeSalvationButton);
		HideUIPanel(HolyHopeLightButton);
		HideUIPanel(HolyHopeFreedomButton);
		HideUIPanel(HolyHopeSacrificeButton);
		HideUIPanel(HolyHopeKingsButton);
		HideUIPanel(HolyHopeSanctuaryButton);
    HideUIPanel(HolyHopeMountUpButton);
		HideUIPanel(HolyHopeMightUpButton);
		HideUIPanel(HolyHopeWisdomUpButton);
		HideUIPanel(HolyHopeSalvationUpButton);
		HideUIPanel(HolyHopeLightUpButton);
		HideUIPanel(HolyHopeKingsUpButton);
		HideUIPanel(HolyHopeSanctuaryUpButton);
		ChatFrame1:AddMessage(HOLYHOPE_MESSAGE.SLASH.InitOn);
  else
    if (TypeBlessing == 0) then
		  ShowUIPanel(HolyHopeMightButton);
		  ShowUIPanel(HolyHopeWisdomButton);
		  ShowUIPanel(HolyHopeSalvationButton);
		  ShowUIPanel(HolyHopeLightButton);
		 	ShowUIPanel(HolyHopeKingsButton);
		  ShowUIPanel(HolyHopeSanctuaryButton);
		else  
		  ShowUIPanel(HolyHopeMightUpButton);
		  ShowUIPanel(HolyHopeWisdomUpButton);
		  ShowUIPanel(HolyHopeSalvationUpButton);
		  ShowUIPanel(HolyHopeLightUpButton);
		  ShowUIPanel(HolyHopeKingsUpButton);
		  ShowUIPanel(HolyHopeSanctuaryUpButton);
		end
		ShowUIPanel(HolyHopeButton);
    ShowUIPanel(HolyHopeFreedomButton);
		ShowUIPanel(HolyHopeSacrificeButton);		
  end
  -- Partie Sceau
  if (HolyHope_Config.SealToogle == false) then
    HideUIPanel(HolyHopeButton2);
		HideUIPanel(HolyHopeSCommandButton);
		HideUIPanel(HolyHopeSCrusaderButton);
		HideUIPanel(HolyHopeSJusticeButton);
		HideUIPanel(HolyHopeSLightButton);
		HideUIPanel(HolyHopeSRighteousnessButton);
		HideUIPanel(HolyHopeSWisdomButton);
	else
	  ShowUIPanel(HolyHopeButton2);
		ShowUIPanel(HolyHopeSCommandButton);
		ShowUIPanel(HolyHopeSCrusaderButton);
		ShowUIPanel(HolyHopeSJusticeButton);
		ShowUIPanel(HolyHopeSLightButton);
		ShowUIPanel(HolyHopeSRighteousnessButton);
		ShowUIPanel(HolyHopeSWisdomButton);
	end
	-- Partit Monture
	if(HolyHope_Config.MountToogle == false) then
	  HideUIPanel(HolyHopeMountButton);
	else
	  ShowUIPanel(HolyHopeMountButton);
	end
	-- On place les icones
	HolyHope_UpdateIcons();
	HolyHope_UpdateButtonsLocation();
	
	-- Si le joueur n'est pas Paladin, on cache HolyHope
	if UnitClass("player") ~= HOLYHOPE_UNIT_PALADIN then
	  -- La partie benedictions
		HideUIPanel(HolyHopeButton);
		HideUIPanel(HolyHopeMountButton);
		HideUIPanel(HolyHopeMightButton);
		HideUIPanel(HolyHopeWisdomButton);
		HideUIPanel(HolyHopeSalvationButton);
		HideUIPanel(HolyHopeLightButton);
		HideUIPanel(HolyHopeFreedomButton);
		HideUIPanel(HolyHopeSacrificeButton);
		HideUIPanel(HolyHopeKingsButton);
		HideUIPanel(HolyHopeSanctuaryButton);
    HideUIPanel(HolyHopeMountUpButton);
		HideUIPanel(HolyHopeMightUpButton);
		HideUIPanel(HolyHopeWisdomUpButton);
		HideUIPanel(HolyHopeSalvationUpButton);
		HideUIPanel(HolyHopeLightUpButton);
		HideUIPanel(HolyHopeKingsUpButton);
		HideUIPanel(HolyHopeSanctuaryUpButton);
		-- La partie sceaux
    HideUIPanel(HolyHopeButton2);
		HideUIPanel(HolyHopeSCommandButton);
		HideUIPanel(HolyHopeSCrusaderButton);
		HideUIPanel(HolyHopeSJusticeButton);
		HideUIPanel(HolyHopeSLightButton);
		HideUIPanel(HolyHopeSRighteousnessButton);
		HideUIPanel(HolyHopeSWisdomButton);	
  end  
end

-- Si l'on apuis sur le boutton pour deplacer Redemption ou marteaux du courroux
function HolyHope_MoveButtonClick(arg)
  TimeMove = GetTime();
  HolyHope_Config.Movable = true;
  if (arg == "Redemption") then
    MoveRedemption = true;
    HolyHopeRedemptionButton:Show();
  elseif (arg == "Wrath") then
    MoveWrath = true;  
    HolyHopeWrathButton:Show();
  end
end

-- Affiche l'icone du marteau du courroux et permet de la deplacer
function HolyHope_MoveButton()
  if ((GetTime()- TimeMove) <=10) then
    HolyHopeWrathCooldown:SetText(floor(11-(GetTime()-TimeMove)));
    HolyHopeRedemptionCooldown:SetText(floor(11-(GetTime()-TimeMove)));
  else
    MoveWrath = false;
    MoveRedemption = false;
    HolyHope_Config.Movable = false;
    HolyHopeWrathCooldown:SetText("");
    HolyHopeRedemptionCooldown:SetText("");
  end
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE HOLYHOPE

------------------------------------------------------------------------------------------------------

-- Fonction d'initialisation
function HolyHope_Initialize()

  -- Si il n'y a pas de sauvegare on charge le profil par defaut
  if (HolyHope_Config == nil) then
    HolyHope_Config = HolyHope_DefaultConfig;
  end 
  
  --Previention d'une nouvelle version sans supression des sauvegardes
  if (HolyHope_Config.BlessingScale == nil) then
    HolyHope_Config.BlessingScale = 100;
  end
  if (HolyHope_Config.BlessingToogle == nil) then
    HolyHope_Config.BlessingToogle = true;
  end
  if (HolyHope_Config.SealToogle == nil) then
    HolyHope_Config.SealToogle = true;
  end
  if (HolyHope_Config.Movable == nil) then
    HolyHope_Config.Movable = true;
  end
  if (HolyHope_Config.MountScale == nil) then
    HolyHope_Config.MountScale = 100;
  end
  if (HolyHope_Config.MountToogle == nil) then
    HolyHope_Config.MountToogle = true;
  end
  if (HolyHope_Config.RedemptionToogle == nil) then
    HolyHope_Config.RedemptionToogle = true;
  end
  if (HolyHope_Config.RedemptionLenght == nil) then
    HolyHope_Config.RedemptionLenght = 50;
  end
  if (HolyHope_Config.SealScale == nil) then
    HolyHope_Config.SealScale = 100;
  end
  if (HolyHope_Config.Tooltip == nil) then
    HolyHope_Config.Tooltip = 1;
  end
  if (HolyHope_Config.WrathToogle == nil) then
    HolyHope_Config.WrathToogle = true;
  end
  if (HolyHope_Config.WrathLenght == nil) then
    HolyHope_Config.WrathLenght = 50;
  end   

  -- Chargement des sorts du joueur
  HolyHope_SpellSetup();
  
  -- Initialisation du marteau du courroux
  if (HOLYHOPE_SPELL_TABLE.ID[24] ~= 0) then
    HolyHopeWrathButton:SetNormalTexture(GetSpellTexture(HOLYHOPE_SPELL_TABLE.ID[24], BOOKTYPE_SPELL));
  end
  
  -- Initialisation de Redemption
  if (HOLYHOPE_SPELL_TABLE.ID[25] ~= 0) then
    HolyHopeRedemptionButton:SetNormalTexture(GetSpellTexture(HOLYHOPE_SPELL_TABLE.ID[25], BOOKTYPE_SPELL));
  end
  
  -- On compte le nombre de Symbole des rois dans le sac
  -- on fait comme si le sac etait update... 
  HolyHope_OnEvent("BAG_UPDATE");
  
  -- On regle la taille des bouttons suivant les configurations utilisateur
  HolyHope_UpdateButtonScale("Button");
  HolyHope_UpdateButtonScale("Button2");
  HolyHope_UpdateButtonScale("Mount");

  -- Enregistrement des commandes console
	SlashCmdList["HolyHope"] = HolyHope_Slash;
	SLASH_HolyHope1 = "/holyhope";
	SLASH_HolyHope2 = "/hh";

  -- Recuperation du nom du joueur
  PlayerName = UnitName("player");
  
  -- Recuperation de la faction du joueur
  PlayerFaction = UnitFactionGroup("Player");
   
  -- Enregistrement des evenements interceptes par HolyHope
  this:RegisterEvent("LEARNED_SPELL_IN_TAB");
  this:RegisterEvent("CHARACTER_POINTS_CHANGED");
  this:RegisterEvent("BAG_UPDATE");
  this:RegisterEvent("PLAYER_AURAS_CHANGED");
  this:RegisterEvent("PLAYER_REGEN_ENABLED");
  this:RegisterEvent("PLAYER_REGEN_DISABLED");
  this:RegisterEvent("PLAYER_TARGET_CHANGED");
  this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
  this:RegisterEvent("PLAYER_ENTER_COMBAT");
  this:RegisterEvent("PLAYER_LEAVE_COMBAT");
  this:RegisterEvent("PLAYER_DEAD");
  this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
  this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
  
  -- Message de chargement de l'addon
  ChatFrame1:AddMessage(HOLYHOPE_MESSAGE.SLASH.InitOn);
end

-- 3 fonctions de recherche pour plus de specificite: 
-- il vaut mieux perdre 15sec de copie-coller/modif que X fois de cycle machine pour rien^^

-- Trouve la localisation de la pierre de foyer dans le sac
function HolyHope_FindHearthstone()
local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
	    	if string.find(itemName, HOLYHOPE_ITEM.Hearthstone) then
					HearthstoneOnHand = true;
					HearthstoneLocation = {bag,slot};
				else
				  HeathstoneOnHand = false;
				end
			end
		end
	end
end

-- Trouve la localisation de la monture quiraji dans le sac
function HolyHope_FindQuirajiMount()
local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
        if string.find(itemName, HOLYHOPE_ITEM.QuirajiMount) then
					QuirajiMountOnHand = true;
					QuirajiMountLocation = {bag,slot};  
 				end
			end
		end
	end
end

-- Trouve la localisation des montures dans le sac
function HolyHope_FindMount()
local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
	    	if string.find(itemName, MOUNT_ITEM.ReinsMount) then
					MountLocation = {bag,slot};
					MountOnHand = true;
				elseif string.find(itemName, MOUNT_ITEM.RamMount) then
				  -- Execption anglaise
				  if string.find(itemName, "Ramstein") or string.find(itemName, "Rambling") then
				  else
					 MountLocation = {bag,slot};
					 MountOnHand = true;
					end
				elseif string.find(itemName, MOUNT_ITEM.BridleMount) then
					MountLocation = {bag,slot};
					MountOnHand = true;
				elseif string.find(itemName, MOUNT_ITEM.BridleMount2) then
					MountLocation = {bag,slot};
					MountOnHand = true;
				elseif string.find(itemName, MOUNT_ITEM.BridleMount3) then
					MountLocation = {bag,slot};
					MountOnHand = true;
				elseif string.find(itemName, MOUNT_ITEM.MechanostriderMount) then
					MountLocation = {bag,slot};
					MountOnHand = true;
				end
			end
		end
	end
end

-- Renvoi le nombre de symbole des rois contenus dans les sacs
function HolyHope_CountKings()
	local kings = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..HOLYHOPE_ITEM.Kings.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					kings = kings + count;
				end
			end
		end
	end
	return kings;
end

-- Fonction pour utiliser un item
function HolyHope_UseItem(type,button)

	-- utiliser une pierre de foyer dans l'inventaire
  if (type == "Hearthstone") then
    -- Trouve les items utilise par HolyHope
    HolyHope_FindHearthstone();
    if (HearthstoneOnHand) then
		-- on l'utilise
		UseContainerItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		-- soit il n'y en a pas dans l'inventaire, on affiche un message d'erreur
		else
		  ChatFrame1:AddMessage(HOLYHOPE_MESSAGE.nohearthstone);
		end

	-- Si on clic sur le bouton de monture
	elseif (type == "Mount") then
	  -- Trouve les montures
    HolyHope_FindQuirajiMount();
    HolyHope_FindMount();
    -- On met à jour la localisation du joueur
	  PlayerZone = GetRealZoneText();
	  -- Clic Gauche: Monture paladin
	  if (button == "LeftButton") then
      -- Si le Paladin est à AQ et qu'il a la monture
      if (QuirajiMountOnHand and PlayerZone == "Ahn'Qiraj") then	
        UseContainerItem(QuirajiMountLocation[1], QuirajiMountLocation[2]); 
		  else
		    -- Soit c'est la monture epique
		    if HOLYHOPE_SPELL_TABLE.ID[2] ~= 0 then
		  	  CastSpell(HOLYHOPE_SPELL_TABLE.ID[2], "spell");
		    -- Soit c'est une autre monture
		    elseif (MountOnHand) then
		      UseContainerItem(MountLocation[1], MountLocation[2]); 	
	   	  -- Soit c'est la monture classique
	   	  else
		  	  CastSpell(HOLYHOPE_SPELL_TABLE.ID[1], "spell");
	   	  end
  	  end
  	-- Clic Droit: Monture normal (si le paladin en à une)
  	elseif (MountLocation[1] ~= nil) then
      UseContainerItem(MountLocation[1], MountLocation[2]);
    end

  -- Si on clic sur le marteau du courroux
  elseif (type == "Wrath") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[24], "spell");
  
  -- Si on clic sur Redemption
  elseif (type == "Redemption") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[25], "spell");  	
  end
  
end

-- Cast la benediction passe en argument, gère l'autotarget en clic droit
function HolyHope_CastBlessing(type,button)

  local WisdomRank, MightRank, DiffRank;
  
   -- Gestion de l'auto target au clic droit (debut)
  if (button == "RightButton") then
   TargetByName(PlayerName);
  end
	
  --Sauvegarde de la bene pour lancement differe ajuste au niveau si pas de cible
	RAZ_DelayedBlessing();
	SavedType=type;
	if (UnitName("target") ~=nil) then
    RAZ_DelayedBlessing(); 
  end
	
	-- Si on clic sur le bouton de la benediction de puissance
	if (type == "Might") then
	if (UnitName("target") ~=nil) then

	  if (TypeBlessing == 0) then
	    if (UnitLevel("Target") >= 52) then
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[3], "spell");
	    elseif (UnitLevel("Target") >= 42) then
	      if HOLYHOPE_SPELL_TABLE.Rank[3] >= 6 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[3] - 6; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[3] - DiffRank, "spell");
	    elseif (UnitLevel("Target") >= 32) then
	      if HOLYHOPE_SPELL_TABLE.Rank[3] >= 5 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[3] - 5; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[3] - DiffRank, "spell");
	    elseif (UnitLevel("Target") >= 22) then
	      if HOLYHOPE_SPELL_TABLE.Rank[3] >= 4 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[3] - 4; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[3] - DiffRank, "spell");
	    elseif (UnitLevel("Target") >= 12) then
	      if HOLYHOPE_SPELL_TABLE.Rank[3] >= 3 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[3] - 3; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[3] - DiffRank, "spell");
	    elseif (UnitLevel("Target") >= 4) then
	      if HOLYHOPE_SPELL_TABLE.Rank[3] >= 2 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[3] - 2; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[3] - DiffRank, "spell");
	    else  
	      if HOLYHOPE_SPELL_TABLE.Rank[3] >= 1 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[3] - 1; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[3] - DiffRank, "spell");
	    end
	  else
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[11], "spell");
	  end
	  else
	    SetCursor("CAST_CURSOR");
      HolyHopeMightButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Might2");
	  end

	-- Si on clic sur le bouton de la benediction de sagesse
	elseif (type == "Wisdom") then
	  if (UnitName("target") ~=nil) then
	  if (TypeBlessing == 0) then

	    if (UnitLevel("Target") >= 54) then
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[4], "spell");
	    elseif (UnitLevel("Target") >= 44) then
	      if HOLYHOPE_SPELL_TABLE.Rank[4] >= 5 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[4] - 5; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[4] - DiffRank, "spell");
	    elseif (UnitLevel("Target") >= 34) then
	      if HOLYHOPE_SPELL_TABLE.Rank[4] >= 4 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[4] - 4; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[4] - DiffRank, "spell");
	    elseif (UnitLevel("Target") >= 24) then
	      if HOLYHOPE_SPELL_TABLE.Rank[4] >= 3 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[4] - 3; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[4] - DiffRank, "spell");
	    elseif (UnitLevel("Target") >= 14) then
	      if HOLYHOPE_SPELL_TABLE.Rank[4] >= 2 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[4] - 2; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[4] - DiffRank, "spell");
	    else 
	      if HOLYHOPE_SPELL_TABLE.Rank[4] >= 1 then DiffRank = HOLYHOPE_SPELL_TABLE.Rank[4] - 1; else DiffRank = 0; end
	      CastSpell(HOLYHOPE_SPELL_TABLE.ID[4] - DiffRank, "spell");
	    end	    	        
	  else
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[12], "spell");
	  end
	  else
	    SetCursor("CAST_CURSOR");
	    HolyHopeWisdomButton:SetNormalTexture("Interface\\Addons\\HolyHope\\UI\\Wisdom2");
	  end

	-- Si on clic sur le bouton de la benediction de salut
	elseif (type == "Salvation") then

	   if (TypeBlessing == 0) then
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[5], "spell");
	  else
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[13], "spell");
	  end
	
	-- Si on clic sur le bouton de la benediction de lumière
	elseif (type == "Light") then

	  if (TypeBlessing == 0) then
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[6], "spell");
	  else
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[14], "spell");
	  end

  -- Si on clic sur le bouton de la benediction des rois
	elseif (type == "Kings") then

	  if (TypeBlessing == 0) then
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[7], "spell");
	  else
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[15], "spell");
	  end
	
	-- Si on clic sur le bouton de la benediction de sanctuaire
	elseif (type == "Sanctuary") then

	  if (TypeBlessing == 0) then
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[8], "spell");
	  else
	    CastSpell(HOLYHOPE_SPELL_TABLE.ID[16], "spell");
	  end

  elseif (type == "Freedom") then

	  CastSpell(HOLYHOPE_SPELL_TABLE.ID[9], "spell");
	
	elseif (type == "Sacrifice") then
	  CastSpell(HOLYHOPE_SPELL_TABLE.ID[10], "spell");
	
	end
	
	-- Gestion de l'auto target au clic droit (fin)
  if (button == "RightButton") then
	TargetLastTarget();		  
  end
    
end

-- Cast le sceau passer en argument, juge le sceau en clic droit
function HolyHope_CastSeal(type,button)

  if (type == "Judgement") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[23], "spell");
  end
  
  if (type == "Command") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[17], "spell");
  elseif (type == "Crusader") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[18], "spell");
  elseif (type == "Justice") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[19], "spell");
  elseif (type == "Light") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[20], "spell");
  elseif (type == "Righteousness") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[21], "spell");
  elseif (type == "Wisdom") then
    CastSpell(HOLYHOPE_SPELL_TABLE.ID[22], "spell");
  end
  
end

-- Gestion des buff pour l'affichage de l'icone du jugement
function isUnitBuffUp(sUnitname, sBuffname) 
  local iIterator = 1
  while (UnitBuff(sUnitname, iIterator)) do
    if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then
      return true;
    end
    iIterator = iIterator + 1
  end
  return false;
end

-- Gestion des buff pour l'affichage de l'icone du jugement
function HolyHope_SealUp()
  -- Si un sceau est actif on return true, on met la verification des sceau à 1
  CheckSeal = 1;
  -- Sceau d'autorite
  if (isUnitBuffUp("player", "Ability_Warrior_InnerRage")) then
    return true;
  -- Sceau du croise
  elseif (isUnitBuffUp("player", "Spell_Holy_HolySmite")) then
    return true;
  -- Sceau de justice
  elseif (isUnitBuffUp("player", "Spell_Holy_SealOfWrath")) then
    return true;
  -- Sceau de lumière
  elseif (isUnitBuffUp("player", "Spell_Holy_HealingAura")) then
    return true;
  -- Sceau de piete
  elseif (isUnitBuffUp("player", "Ability_ThunderBolt")) then
    return true;
  -- Sceau de sagesse
  elseif (isUnitBuffUp("player", "Spell_Holy_RighteousnessAura")) then
    return true;
  end
  return false;
end
  
---------------------------------------------------------------------------------------------

-- FONCTION REPRIT SUR NECROSIS, merci à son auteur.

---------------------------------------------------------------------------------------------

-- Creee la liste des sorts connus par le Paladin, et les classe par rangs.
function HolyHope_SpellSetup()
	
	local CurrentSpells = {
		ID = {},
		Name = {},
		subName = {}
	};
	
	local spellID = 1;
	local Invisible = 0;
	local InvisibleID = 0;

	-- On va parcourir tous les sorts possedes par le Paladin
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL);
		
		if not spellName then
			do break end
		end
		
		if (spellName) then
			-- Pour les sorts avec des rangs numerotes, on compare pour chaque sort les rangs 1 à 1
			-- Le rang superieur est conserve
			if (string.find(subSpellName, HOLYHOPE_TRANSLATION.Rank)) then
				local found = false;
				local rank = tonumber(strsub(subSpellName, 6, strlen(subSpellName)));
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
				-- Les plus grands rangs de chacun des sorts à rang numerotes sont inseres dans la table
				if (not found) then
					table.insert(CurrentSpells.ID, spellID);
					table.insert(CurrentSpells.Name, spellName);
					table.insert(CurrentSpells.subName, rank);
				end
			end
		end
		spellID = spellID + 1;
	end

	-- On met à jour la liste des sorts avec les nouveaux rangs
	for spell=1, table.getn(HOLYHOPE_SPELL_TABLE.Name), 1 do
		for index=1, table.getn(CurrentSpells.Name), 1 do
			if (HOLYHOPE_SPELL_TABLE.Name[spell] == CurrentSpells.Name[index]) then
				HOLYHOPE_SPELL_TABLE.ID[spell] = CurrentSpells.ID[index];
				HOLYHOPE_SPELL_TABLE.Rank[spell] = CurrentSpells.subName[index];
			end
		end
	end
	
  for index=1, table.getn(HOLYHOPE_SPELL_TABLE.Name), 1 do
		HOLYHOPE_SPELL_TABLE.ID[index] = 0;
	end
	for spellID=1, MAX_SPELLS, 1 do
        local spellName, subSpellName = GetSpellName(spellID, "spell");
		if (spellName) then
			for index=1, table.getn(HOLYHOPE_SPELL_TABLE.Name), 1 do
				if HOLYHOPE_SPELL_TABLE.Name[index] == spellName then
			    HolyHope_MoneyToggle();
	        GameTooltip:SetSpell(spellID,1);
          local _, _, ManaCost = string.find(GameTooltipTextLeft2:GetText(), "(%d+)");
          HolyHope_MoneyToggle();
					HOLYHOPE_SPELL_TABLE.ID[index] = spellID;
					HOLYHOPE_SPELL_TABLE.Mana[index] = tonumber(ManaCost);
				end
			end
		end
	end
	
end

function HolyHope_MoneyToggle()
	for index=1, 10 do
		local text = getglobal("GameTooltipTextLeft"..index);
			text:SetText(nil);
			text = getglobal("GameTooltipTextRight"..index);
			text:SetText(nil);
	end
	GameTooltip:Hide();
	GameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE"); 
end
