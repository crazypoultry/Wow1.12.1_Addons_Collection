-- Initialisation

SpiritSphere_Config = {};

SpiritSphere_DefaultConfig = {
 ["Movable"] = true;
 ["Tooltip"] = 1;
 ["BlessingToogle"] = true;
 ["SealToogle"] = true;
 ["MountToogle"] = true;
}

local SpiritSphereMounted = false;
local SpiritSphereKings = 0;
local HearthstoneOnHand = false;
local HearthstoneLocation = {nil,nil};
local QuirajiMountOnHand = false;
local QuirajiMountLocation = {nil,nil};
local MountOnHand = false;
local MountLocation = {nil,nil};
local TypeBlessing = 0; -- 0 benediction perso, 1 benediction de classe
local combat = false;
local PlayerName;
local load = false;
local QuirajiMount = false;
local PlayerZone;
 

------------------------------------------------------------------------------------------------------

-- INTERFACE

------------------------------------------------------------------------------------------------------

-- Fonction permettant le déplacement d'éléments de SpiritSphere sur l'écran
function SpiritSphere_OnDragStart(button)
  if (SpiritSphere_Config.Movable) then
	  button:StartMoving();
	else
	  return;
	end
end

-- Fonction arrêtant le déplacement d'éléments de SpiritSphere sur l'écran
function SpiritSphere_OnDragStop(button)
	button:StopMovingOrSizing();
end

-- Fonction lancée à la mise à jour de l'interface (main) -- toutes les 0,1 secondes environ
function SpiritSphere_OnUpdate()
  local number = 320;
  local count = -1;
  local start, duration, cooldown, cooldownb;
  
  --Si c'est la premiere update on initialize
  if (load == false) then
    SpiritSphere_Initialize();
    SpiritSphere_Toogle();   
    load = true;
  end
    
  -- On met à jour les symboles des rois
	SpiritSphereKings = SpiritSphere_CountKings()
	if (SpiritSphereKings == 0) then
	  SpiritSphereKingsCount:SetText("");
	else
	  SpiritSphereKingsCount:SetText(SpiritSphereKings);
	end
	
	-- On met à jour le cooldown de liberté
	if (SpiritSphere_SPELL_TABLE.ID[9] ~= 0) then
	  start, duration = GetSpellCooldown(SpiritSphere_SPELL_TABLE.ID[9], BOOKTYPE_SPELL);
	  if (start > 0 and duration > 0) then
	   cooldown =  floor(duration - ( GetTime() - start)) + 1;
      SpiritSphereFreedomCooldown:SetText(cooldown);
    else
      SpiritSphereFreedomCooldown:SetText("");
    end
  end
  
  -- On met à jour le cooldown du jugement
	if (SpiritSphere_SPELL_TABLE.ID[23] ~= 0) then
	  start, duration = GetSpellCooldown(SpiritSphere_SPELL_TABLE.ID[23], BOOKTYPE_SPELL);
	  if (start > 0 and duration > 0) then
	   cooldownb =  floor(duration - ( GetTime() - start)) + 1;
      SpiritSphereJudgementCooldown:SetText(cooldownb);
    else
      SpiritSphereJudgementCooldown:SetText("");
    end
  end
  
  -- On met la bonne icone du jugement suivant si le Paladin à un Sceau d'activé
  if (SpiritSphere_SealUp() and cooldownb == nil) then
    SpiritSphereButton2:SetNormalTexture("Interface\\Addons\\SpiritSphere\\UI\\Judgement");
  else
    SpiritSphereButton2:SetNormalTexture("Interface\\Addons\\SpiritSphere\\UI\\Judgement2");
  end
  
  -- On met à jour les cooldowns généraux
  if (SpiritSphere_SPELL_TABLE.ID[3] ~= 0) then
    start, duration = GetSpellCooldown(SpiritSphere_SPELL_TABLE.ID[3], BOOKTYPE_SPELL);
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
	-- On met à jour la localisation du joueur
	PlayerZone = GetRealZoneText();
	
 	-- Gestion de l'affichage du fond en fontion du nombre de symboles
 	if (combat == false) then
	  if (SpiritSphereKings <= number) then
	    while (SpiritSphereKings <= number) do
	     number = number - 10;
	      count = count +1;
	    end
	    count = SpiritSphereKings;
	   	 SpiritSphereButton:SetNormalTexture("Interface\\Addons\\SpiritSphere\\UI\\Symbol"..count);
	  else
	   	SpiritSphereButton:SetNormalTexture("Interface\\Addons\\SpiritSphere\\UI\\Symbol0");
	  end
  end
  
end

function SpiritSphere_OnEvent(event)
  -- Changement de couleur suivant le mode Combat
	if (event == "PLAYER_REGEN_DISABLED") then
    SpiritSphereButton:SetNormalTexture("Interface\\Addons\\SpiritSphere\\UI\\SpiritSphereC");
    combat = true;
  elseif (event == "PLAYER_REGEN_ENABLED") then
    combat = false;      
  -- Si un nouveau sort est apris, on rafraichie le tableau des sorts
  elseif (event == "LEARNED_SPELL_IN_TAB") then
	   	SpiritSphere_SpellSetup();
  end
end


-- Gestion du clic sur SpiritSphere
-- Clique gauche: Passe SpiritSphere en mode bénédiction Individuel/Classe
-- Clique droit: Pierre de Foyer

function SpiritSphere_OnClick(button)
  if button == "RightButton" then
   SpiritSphere_UseItem("Hearthstone");
  else
    if (TypeBlessing == 0) then
      TypeBlessing = 1;
		  HideUIPanel(SpiritSphereMightButton);
		  HideUIPanel(SpiritSphereWisdomButton);
		  HideUIPanel(SpiritSphereSalvationButton);
		  HideUIPanel(SpiritSphereLightButton);
	   	HideUIPanel(SpiritSphereKingsButton);
	   	HideUIPanel(SpiritSphereSanctuaryButton);
	   	if (SpiritSphere_SPELL_TABLE.ID[11] ~= 0) then
		    ShowUIPanel(SpiritSphereMightUpButton);
		  end
		  if (SpiritSphere_SPELL_TABLE.ID[12] ~= 0) then
		    ShowUIPanel(SpiritSphereWisdomUpButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[13] ~= 0) then
		    ShowUIPanel(SpiritSphereSalvationUpButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[14] ~= 0) then
		    ShowUIPanel(SpiritSphereLightUpButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[15] ~= 0) then
		    ShowUIPanel(SpiritSphereKingsUpButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[16] ~= 0) then
		    ShowUIPanel(SpiritSphereSanctuaryUpButton);
		  end  
    else
      TypeBlessing= 0;
		  if (SpiritSphere_SPELL_TABLE.ID[3] ~= 0) then
		    ShowUIPanel(SpiritSphereMightButton);
		  end
		  if (SpiritSphere_SPELL_TABLE.ID[4] ~= 0) then
		    ShowUIPanel(SpiritSphereWisdomButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[5] ~= 0) then
		    ShowUIPanel(SpiritSphereSalvationButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[6] ~= 0) then
		    ShowUIPanel(SpiritSphereLightButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[7] ~= 0) then
		    ShowUIPanel(SpiritSphereKingsButton);
		  end
      if (SpiritSphere_SPELL_TABLE.ID[8] ~= 0) then
		    ShowUIPanel(SpiritSphereSanctuaryButton);
		  end
		  HideUIPanel(SpiritSphereMightUpButton);
		  HideUIPanel(SpiritSphereWisdomUpButton);
		  HideUIPanel(SpiritSphereSalvationUpButton);
		  HideUIPanel(SpiritSphereLightUpButton);
		  HideUIPanel(SpiritSphereKingsUpButton);
		  HideUIPanel(SpiritSphereSanctuaryUpButton);  
    end
  GameTooltip:Hide();
  end
end

-- On place les boutons des sort autour du Principal, on les cachent si le paladin ne les a pas
function SpiritSphere_UpdateIcons()
  
  if (SpiritSphere_SPELL_TABLE.ID[1] == 0 and SpiritSphere_SPELL_TABLE.ID[2] == 0) then
    HideUIPanel(SpiritSphereMountButton);
  end  
  if (SpiritSphere_SPELL_TABLE.ID[3] == 0) then
    HideUIPanel(SpiritSphereMightButton);
  else
  SpiritSphereMightButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", 17, 42);
  end
  if (SpiritSphere_SPELL_TABLE.ID[4] == 0) then
    HideUIPanel(SpiritSphereWisdomButton);
  else
  SpiritSphereWisdomButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", -17, 42);
  end
  if (SpiritSphere_SPELL_TABLE.ID[5] == 0) then
    HideUIPanel(SpiritSphereSalvationButton);
  else
  SpiritSphereSalvationButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", -42, 17);
  end
  if (SpiritSphere_SPELL_TABLE.ID[6] == 0) then
    HideUIPanel(SpiritSphereLightButton);
  else
  SpiritSphereLightButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", 42, 17);
  end 
  if (SpiritSphere_SPELL_TABLE.ID[7] == 0) then
    HideUIPanel(SpiritSphereKingsButton);
  else
  SpiritSphereKingsButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", 42, -17);
  end
  if (SpiritSphere_SPELL_TABLE.ID[8] == 0) then
    HideUIPanel(SpiritSphereSanctuaryButton);
  else
    SpiritSphereSanctuaryButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", -42, -17);
  end 
  if (SpiritSphere_SPELL_TABLE.ID[9] == 0) then
    HideUIPanel(SpiritSphereFreedomButton);
  else
  SpiritSphereFreedomButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", 17, -41);
  end
  if (SpiritSphere_SPELL_TABLE.ID[10] == 0) then
    HideUIPanel(SpiritSphereSacrificeButton);
  else
  SpiritSphereSacrificeButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", -17, -41);
  end
  if (SpiritSphere_SPELL_TABLE.ID[11] == 0) then
    HideUIPanel(SpiritSphereMightUpButton);
  else
  SpiritSphereMightUpButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", 17, 42);
  end
  if (SpiritSphere_SPELL_TABLE.ID[12] == 0) then
    HideUIPanel(SpiritSphereWisdomUpButton);
  else
  SpiritSphereWisdomUpButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", -17, 42);
  end
  if (SpiritSphere_SPELL_TABLE.ID[13] == 0) then
    HideUIPanel(SpiritSphereSalvationUpButton);
  else
  SpiritSphereSalvationUpButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", -42, 17);
  end
  if (SpiritSphere_SPELL_TABLE.ID[14] == 0) then
    HideUIPanel(SpiritSphereLightUpButton);
  else
  SpiritSphereLightUpButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", 42, 17);
  end 
  if (SpiritSphere_SPELL_TABLE.ID[15] == 0) then
    HideUIPanel(SpiritSphereKingsUpButton);
  else
  SpiritSphereKingsUpButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", 42, -17);
  end
  if (SpiritSphere_SPELL_TABLE.ID[16] == 0) then
    HideUIPanel(SpiritSphereSanctuaryUpButton);
  else
    SpiritSphereSanctuaryUpButton:SetPoint("CENTER", "SpiritSphereButton", "CENTER", -42, -17);
  end
  if (SpiritSphere_SPELL_TABLE.ID[17] == 0) then
    HideUIPanel(SpiritSphereSCommandButton);    
  else
    SpiritSphereSCommandButton:SetPoint("CENTER", "SpiritSphereButton2", "CENTER", -34, 31);
  end
  if (SpiritSphere_SPELL_TABLE.ID[18] == 0) then
    HideUIPanel(SpiritSphereSCrusaderButton);
  else
    SpiritSphereSCrusaderButton:SetPoint("CENTER", "SpiritSphereButton2", "CENTER", -47, 0);
  end
  if (SpiritSphere_SPELL_TABLE.ID[19] == 0) then
    HideUIPanel(SpiritSphereSJusticeButton);
  else
    SpiritSphereSJusticeButton:SetPoint("CENTER", "SpiritSphereButton2", "CENTER", 34, -31);
  end
  if (SpiritSphere_SPELL_TABLE.ID[20] == 0) then
    HideUIPanel(SpiritSphereSLightButton);
  else
    SpiritSphereSLightButton:SetPoint("CENTER", "SpiritSphereButton2", "CENTER", 47, 0);
  end
  if (SpiritSphere_SPELL_TABLE.ID[21] == 0) then
    HideUIPanel(SpiritSphereSRighteousnessButton);
  else
    SpiritSphereSRighteousnessButton:SetPoint("CENTER", "SpiritSphereButton2", "CENTER", -34, -31);
  end
  if (SpiritSphere_SPELL_TABLE.ID[22] == 0) then
    ChatFrame1:AddMessage("test");
    HideUIPanel(SpiritSphereSWisdomButton);
  else
    SpiritSphereSWisdomButton:SetPoint("CENTER", "SpiritSphereButton2", "CENTER", 34, 31);
  end 
end

-- Création et Affichage des bulles d'aides
function SpiritSphere_BuildTooltip(button, anchor, type)

  -- Creation des aides partiels
  if (SpiritSphere_Config.Tooltip == 1) then
    -- Definie à qui apartient la bulle d'aide
    GameTooltip:SetOwner(button, anchor);
    if (type == "Mount") then
      -- Soit c'est la monture épique
      if SpiritSphere_SPELL_TABLE.ID[2] ~= 0 then
	   	  GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[2]);
	    -- Soit c'est la monture classique
	    elseif SpiritSphere_SPELL_TABLE.ID[1] ~= 0 then
		    GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[1]);
		  end
    elseif (type == "Might") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[3]);
    elseif (type == "Wisdom") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[4]);
    elseif (type == "Salvation") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[5]);
    elseif (type == "Light") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[6]);
    elseif (type == "Kings") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[7]);
    elseif (type == "Sanctuary") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[8]);
    elseif (type == "Freedom") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[9]);
    elseif (type == "Sacrifice") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[10]);
    elseif (type == "MightUp") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[11]);
    elseif (type == "WisdomUp") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[12]);
    elseif (type == "SalvationUp") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[13]);
    elseif (type == "LightUp") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[14]);
    elseif (type == "KingsUp") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[15]);
    elseif (type == "SanctuaryUp") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[16]);
    elseif (type == "SCommand") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[17]);
    elseif (type == "SCrusader") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[18]);
    elseif (type == "SJustice") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[19]);
    elseif (type == "SLight") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[20]);
    elseif (type == "SRighteousness") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[21]);
    elseif (type == "SWisdom") then
      GameTooltip:AddLine("Mana : "..SpiritSphere_SPELL_TABLE.Mana[22]);
    -- Soit c'est le bouton principal
    elseif (type == "SpiritSphereButton") then
      GameTooltip:AddLine(SpiritSphere_MESSAGE.TOOLTIP.Clic);
      -- Gestion mode de bénédiction
      if (TypeBlessing == 0) then
        GameTooltip:AppendText(SpiritSphere_MESSAGE.TOOLTIP.NotUp);
      else
        GameTooltip:AppendText(SpiritSphere_MESSAGE.TOOLTIP.Up);
      end
      GameTooltip:AddLine(SpiritSphere_MESSAGE.TOOLTIP.RightClic);
    elseif (type == "SpiritSphereButton2") then
      GameTooltip:AddLine(SpiritSphere_MESSAGE.TOOLTIP.Judgement);
    end
    -- On affiche
    GameTooltip:Show();
    
    -- Creation des aides totals
    elseif (SpiritSphere_Config.Tooltip == 2) then
    -- Definie à qui apartient la bulle d'aide
    GameTooltip:SetOwner(button, anchor);
    if (type == "Mount") then
      -- Soit c'est la monture épique
      if SpiritSphere_SPELL_TABLE.ID[2] ~= 0 then
	   	  GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[2],1);
	    -- Soit c'est la monture classique
	    else
		    GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[1],1);
		  end
    elseif (type == "Might") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[3],1);
    elseif (type == "Wisdom") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[4],1);
    elseif (type == "Salvation") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[5],1);
    elseif (type == "Light") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[6],1);
    elseif (type == "Kings") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[7],1);
    elseif (type == "Sanctuary") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[8],1);
    elseif (type == "Freedom") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[9],1);
    elseif (type == "Sacrifice") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[10],1);
    elseif (type == "MightUp") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[11],1);
    elseif (type == "WisdomUp") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[12],1);
    elseif (type == "SalvationUp") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[13],1);
    elseif (type == "LightUp") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[14],1);
    elseif (type == "KingsUp") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[15],1);
    elseif (type == "SanctuaryUp") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[16],1);
    elseif (type == "SCommand") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[17],1);
    elseif (type == "SCrusader") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[18],1);
    elseif (type == "SJustice") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[19],1);
    elseif (type == "SLight") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[20],1);
    elseif (type == "SRighteousness") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[21],1);
    elseif (type == "SWisdom") then
      GameTooltip:SetSpell(SpiritSphere_SPELL_TABLE.ID[22],1);
    -- Soit c'est le bouton principal
    elseif (type == "SpiritSphereButton") then
      GameTooltip:AddLine(SpiritSphere_MESSAGE.TOOLTIP.Clic);
      -- Gestion mode de bénédiction
      if (TypeBlessing == 0) then
        GameTooltip:AppendText(SpiritSphere_MESSAGE.TOOLTIP.NotUp);
      else
        GameTooltip:AppendText(SpiritSphere_MESSAGE.TOOLTIP.Up);
      end
      GameTooltip:AddLine(SpiritSphere_MESSAGE.TOOLTIP.RightClic);
    elseif (type == "SpiritSphereButton2") then
      GameTooltip:AddLine(SpiritSphere_MESSAGE.TOOLTIP.Judgement);
    end
    -- On affiche
    GameTooltip:Show();
  end
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE GETION DU MENU

------------------------------------------------------------------------------------------------------

-- Affichage du menu par la commande
function SpiritSphere_Slash()
  SpiritSphereMenu:Show();	
end

-- Gestion de la validation du menu
function SpiritSphere_Menu_OnClick()
  
  -- Gestion de l'affichage de la partit Bénédiction
  if (SpiritSphereCheckBlessing:GetChecked() == 1) then
    SpiritSphere_Config.BlessingToogle = true;
    ChatFrame1:AddMessage("Totemsphere wird jetzt angezeigt.");
  else
    SpiritSphere_Config.BlessingToogle = false;
    ChatFrame1:AddMessage("Totemsphere wird nicht mehr angezeigt.");
  end
  -- Gestion de l'affichage de la partit Sceau
  if (SpiritSphereCheckSeal:GetChecked() == 1) then
    SpiritSphere_Config.SealToogle = true;
  else
    SpiritSphere_Config.SealToogle = false;
  end
  -- Gestion de l'affichage de la partit Monture
  if (SpiritSphereCheckMount:GetChecked() == 1) then
    SpiritSphere_Config.MountToogle = true;
  else
    SpiritSphere_Config.MountToogle = false;
  end
  SpiritSphere_Toogle();
  
  -- Gestion du choix du type d'aide
  if (SpiritSphereTooltipsTotal:GetChecked() == 1) then
    SpiritSphere_Config.Tooltip = 2;
  elseif (SpiritSphereTooltipsPartial:GetChecked() == 1) then
    SpiritSphere_Config.Tooltip = 1;
  else
    SpiritSphere_Config.Tooltip = 0;
  end

  SpiritSphereMenu:Hide();
end

-- Active ou Desactive SpiritSphere (attention pour la desactivation on cache les boutons, l'addon tourne toujours)
function SpiritSphere_Toogle()
  -- Partie Bénédiction
  if (SpiritSphere_Config.BlessingToogle == false) then
    HideUIPanel(SpiritSphereButton);
		HideUIPanel(SpiritSphereMightButton);
		HideUIPanel(SpiritSphereWisdomButton);
		HideUIPanel(SpiritSphereSalvationButton);
		HideUIPanel(SpiritSphereLightButton);
		HideUIPanel(SpiritSphereFreedomButton);
		HideUIPanel(SpiritSphereSacrificeButton);
		HideUIPanel(SpiritSphereKingsButton);
		HideUIPanel(SpiritSphereSanctuaryButton);
    HideUIPanel(SpiritSphereMountUpButton);
		HideUIPanel(SpiritSphereMightUpButton);
		HideUIPanel(SpiritSphereWisdomUpButton);
		HideUIPanel(SpiritSphereSalvationUpButton);
		HideUIPanel(SpiritSphereLightUpButton);
		HideUIPanel(SpiritSphereKingsUpButton);
		HideUIPanel(SpiritSphereSanctuaryUpButton);
		ChatFrame1:AddMessage(SpiritSphere_MESSAGE.SLASH.InitOn);
  else
    if (TypeBlessing == 0) then
		  ShowUIPanel(SpiritSphereMightButton);
		  ShowUIPanel(SpiritSphereWisdomButton);
		  ShowUIPanel(SpiritSphereSalvationButton);
		  ShowUIPanel(SpiritSphereLightButton);
		 	ShowUIPanel(SpiritSphereKingsButton);
		  ShowUIPanel(SpiritSphereSanctuaryButton);
		else  
		  ShowUIPanel(SpiritSphereMightUpButton);
		  ShowUIPanel(SpiritSphereWisdomUpButton);
		  ShowUIPanel(SpiritSphereSalvationUpButton);
		  ShowUIPanel(SpiritSphereLightUpButton);
		  ShowUIPanel(SpiritSphereKingsUpButton);
		  ShowUIPanel(SpiritSphereSanctuaryUpButton);
		end
		ShowUIPanel(SpiritSphereButton);
    ShowUIPanel(SpiritSphereFreedomButton);
		ShowUIPanel(SpiritSphereSacrificeButton);		
  end
  -- Partie Sceau
  if (SpiritSphere_Config.SealToogle == false) then
    HideUIPanel(SpiritSphereButton2);
		HideUIPanel(SpiritSphereSCommandButton);
		HideUIPanel(SpiritSphereSCrusaderButton);
		HideUIPanel(SpiritSphereSJusticeButton);
		HideUIPanel(SpiritSphereSLightButton);
		HideUIPanel(SpiritSphereSRighteousnessButton);
		HideUIPanel(SpiritSphereSWisdomButton);
	else
	  ShowUIPanel(SpiritSphereButton2);
		ShowUIPanel(SpiritSphereSCommandButton);
		ShowUIPanel(SpiritSphereSCrusaderButton);
		ShowUIPanel(SpiritSphereSJusticeButton);
		ShowUIPanel(SpiritSphereSLightButton);
		ShowUIPanel(SpiritSphereSRighteousnessButton);
		ShowUIPanel(SpiritSphereSWisdomButton);
	end
	-- Partit Monture
	if(SpiritSphere_Config.MountToogle == false) then
	  HideUIPanel(SpiritSphereMountButton);
	else
	  ShowUIPanel(SpiritSphereMountButton);
	end
	-- On place les icones
	SpiritSphere_UpdateIcons();
	
	-- Si le joueur n'est pas Paladin, on cache SpiritSphere
	if UnitClass("player") ~= SpiritSphere_UNIT_PALADIN then
	  -- La partie bénédictions
		HideUIPanel(SpiritSphereButton);
		HideUIPanel(SpiritSphereMountButton);
		HideUIPanel(SpiritSphereMightButton);
		HideUIPanel(SpiritSphereWisdomButton);
		HideUIPanel(SpiritSphereSalvationButton);
		HideUIPanel(SpiritSphereLightButton);
		HideUIPanel(SpiritSphereFreedomButton);
		HideUIPanel(SpiritSphereSacrificeButton);
		HideUIPanel(SpiritSphereKingsButton);
		HideUIPanel(SpiritSphereSanctuaryButton);
    HideUIPanel(SpiritSphereMountUpButton);
		HideUIPanel(SpiritSphereMightUpButton);
		HideUIPanel(SpiritSphereWisdomUpButton);
		HideUIPanel(SpiritSphereSalvationUpButton);
		HideUIPanel(SpiritSphereLightUpButton);
		HideUIPanel(SpiritSphereKingsUpButton);
		HideUIPanel(SpiritSphereSanctuaryUpButton);
		-- La partie sceaux
    HideUIPanel(SpiritSphereButton2);
		HideUIPanel(SpiritSphereSCommandButton);
		HideUIPanel(SpiritSphereSCrusaderButton);
		HideUIPanel(SpiritSphereSJusticeButton);
		HideUIPanel(SpiritSphereSLightButton);
		HideUIPanel(SpiritSphereSRighteousnessButton);
		HideUIPanel(SpiritSphereSWisdomButton);	
  end
  
end

------------------------------------------------------------------------------------------------------

-- FONCTION DE SpiritSphere

------------------------------------------------------------------------------------------------------

-- Fonction d'initialisation
function SpiritSphere_Initialize()

  if (SpiritSphere_Config == nil) then
    SpiritSphere_Config = SpiritSphere_DefaultConfig;
  end

  -- Chargement des sorts du joueur
  SpiritSphere_SpellSetup();

  -- Enregistrement des commandes console
	SlashCmdList["SpiritSphere"] = SpiritSphere_Slash;
	SLASH_SpiritSphere1 = "/spiritsphere";
	SLASH_SpiritSphere2 = "/ssphere";

  -- Recupertation du nom du joueur
  PlayerName = UnitName("player");
  
  -- Initialisation du menu
  if (SpiritSphere_Config.BlessingToogle) then
    SpiritSphereCheckBlessing:SetChecked(1);
  else
    SpiritSphereCheckBlessing:SetChecked(nil);
  end
  if (SpiritSphere_Config.SealToogle) then
    SpiritSphereCheckSeal:SetChecked(1);
  else
    SpiritSphereCheckSeal:SetChecked(nil);
  end
  if (SpiritSphere_Config.MountToogle) then
    SpiritSphereCheckMount:SetChecked(1);
  else
    SpiritSphereCheckMount:SetChecked(nil);
  end
  if (SpiritSphere_Config.Tooltip == 0) then
    SpiritSphereTooltipsOff:SetChecked(1);
  else
    SpiritSphereTooltipsOff:SetChecked(nil);
  end
  if (SpiritSphere_Config.Tooltip == 1) then
    SpiritSphereTooltipsPartial:SetChecked(1);
  else
    SpiritSphereTooltipsPartial:SetChecked(nil);
  end
  if (SpiritSphere_Config.Tooltip == 2) then
    SpiritSphereTooltipsTotal:SetChecked(1);
  else
    SpiritSphereTooltipsTotal:SetChecked(nil);
  end
   
  -- Enregistrement des événements interceptés par SpiritSphere
  this:RegisterEvent("LEARNED_SPELL_IN_TAB");
  this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
  this:RegisterEvent("PLAYER_REGEN_ENABLED");
  this:RegisterEvent("PLAYER_REGEN_DISABLED");
  
  -- Message de chargement de l'addon
  ChatFrame1:AddMessage(SpiritSphere_MESSAGE.SLASH.InitOn);
end

-- 3 fonctions de recherche pour plus de spécificité: 
-- il vaut mieux perdre 15sec de copié-coller/modif que X fois de cycle machine pour rien^^

-- Trouve la localisation de la pierre de foyer dans le sac
function SpiritSphere_FindHearthstone()
local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
	    	if string.find(itemName, SpiritSphere_ITEM.Hearthstone) then
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
function SpiritSphere_FindQuirajiMount()
local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
        if string.find(itemName, SpiritSphere_ITEM.QuirajiMount) then
					QuirajiMountOnHand = true;
					QuirajiMountLocation = {bag,slot};  
 				end
			end
		end
	end
end

-- Trouve la localisation des montures dans le sac
function SpiritSphere_FindMount()
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
function SpiritSphere_CountKings()
	local kings = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..SpiritSphere_ITEM.Kings.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					kings = kings + count;
				end
			end
		end
	end
	return kings;
end

-- Fonction pour utiliser un item
function SpiritSphere_UseItem(type,button)

	-- utiliser une pierre de foyer dans l'inventaire
  if (type == "Hearthstone") then
    -- Trouve les items utilisé par SpiritSphere
    SpiritSphere_FindHearthstone();
    if (HearthstoneOnHand) then
		-- on l'utilise
		UseContainerItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		-- soit il n'y en a pas dans l'inventaire, on affiche un message d'erreur
		else
		ChatFrame1:AddMessage(SpiritSphere_MESSAGE.nohearthstone);
		end

	-- Si on clic sur le bouton de monture
	elseif (type == "Mount") then
	 -- Trouve les montures
   SpiritSphere_FindQuirajiMount();
   SpiritSphere_FindMount();
    -- Si le Paladin est à AQ et qu'il a la monture
    if (QuirajiMountOnHand and PlayerZone == "Ahn'Qiraj") then	
      UseContainerItem(QuirajiMountLocation[1], QuirajiMountLocation[2]); 
		else
		  -- Soit c'est la monture épique
		  if SpiritSphere_SPELL_TABLE.ID[2] ~= 0 then
		  	CastSpell(SpiritSphere_SPELL_TABLE.ID[2], "spell");
		  -- Soit c'est une autre monture
		  elseif (MountOnHand) then
		    UseContainerItem(MountLocation[1], MountLocation[2]); 	
	   	-- Soit c'est la monture classique
	   	else
		  	CastSpell(SpiritSphere_SPELL_TABLE.ID[1], "spell");
	   	end
  	end	
  end
  
end

-- Cast la bénédiction passé en argument, gère l'autotarget en clic droit
function SpiritSphere_CastBlessing(type,button)
  
   -- Gestion de l'auto target au clic droit (debut)
  if (button == "RightButton") then
   TargetByName(PlayerName);
  end
	
	-- Si on clic sur le bouton de la bénédiction de puissance
	if (type == "Might") then
	  if (TypeBlessing == 0) then
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[3], "spell");
	  else
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[11], "spell");
	  end
	
	-- Si on clic sur le bouton de la bénédiction de sagesse
	elseif (type == "Wisdom") then
	   if (TypeBlessing == 0) then
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[4], "spell");
	  else
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[12], "spell");
	  end
	
	-- Si on clic sur le bouton de la bénédiction de salut
	elseif (type == "Salvation") then
	   if (TypeBlessing == 0) then
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[5], "spell");
	  else
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[13], "spell");
	  end
	
	-- Si on clic sur le bouton de la bénédiction de lumière
	elseif (type == "Light") then
	  if (TypeBlessing == 0) then
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[6], "spell");
	  else
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[14], "spell");
	  end

  -- Si on clic sur le bouton de la bénédiction des rois
	elseif (type == "Kings") then
	  if (TypeBlessing == 0) then
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[7], "spell");
	  else
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[15], "spell");
	  end
	
	-- Si on clic sur le bouton de la bénédiction de sanctuaire
	elseif (type == "Sanctuary") then
	  if (TypeBlessing == 0) then
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[8], "spell");
	  else
	    CastSpell(SpiritSphere_SPELL_TABLE.ID[16], "spell");
	  end

  elseif (type == "Freedom") then
	  CastSpell(SpiritSphere_SPELL_TABLE.ID[9], "spell");
	
	elseif (type == "Sacrifice") then
	  CastSpell(SpiritSphere_SPELL_TABLE.ID[10], "spell");
	
	end
	
	-- Gestion de l'auto target au clic droit (fin)
  if (button == "RightButton") then
    TargetLastTarget(); 
  end
    
end

-- Cast le sceau passer en argument, juge le sceau en clic droit
function SpiritSphere_CastSeal(type,button)

local time;

  if (type == "Judgement") then
    CastSpell(SpiritSphere_SPELL_TABLE.ID[23], "spell");
  end
  
  if (type == "Command") then
    CastSpell(SpiritSphere_SPELL_TABLE.ID[17], "spell");
  elseif (type == "Crusader") then
    CastSpell(SpiritSphere_SPELL_TABLE.ID[18], "spell");
  elseif (type == "Justice") then
    CastSpell(SpiritSphere_SPELL_TABLE.ID[19], "spell");
  elseif (type == "Light") then
    CastSpell(SpiritSphere_SPELL_TABLE.ID[20], "spell");
  elseif (type == "Righteousness") then
    CastSpell(SpiritSphere_SPELL_TABLE.ID[21], "spell");
    SpellStopCasting();
  elseif (type == "Wisdom") then
    CastSpell(SpiritSphere_SPELL_TABLE.ID[22], "spell");
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
function SpiritSphere_SealUp()
  -- Si un sceau est actif on return true
  -- Sceau d'autorité
  if (isUnitBuffUp("player", "Ability_Warrior_InnerRage")) then
    return true;
  -- Sceau du croisé
  elseif (isUnitBuffUp("player", "Spell_Holy_HolySmite")) then
    return true;
  -- Sceau de justice
  elseif (isUnitBuffUp("player", "Spell_Holy_SealOfWrath")) then
    return true;
  -- Sceau de lumière
  elseif (isUnitBuffUp("player", "Spell_Holy_HealingAura")) then
    return true;
  -- Sceau de piété
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

-- Creée la liste des sorts connus par le Paladin, et les classe par rangs.
function SpiritSphere_SpellSetup()
	
	local CurrentSpells = {
		ID = {},
		Name = {},
		subName = {}
	};
	
	local spellID = 1;
	local Invisible = 0;
	local InvisibleID = 0;

	-- On va parcourir tous les sorts possedés par le Paladin
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL);
		
		if not spellName then
			do break end
		end
		
		if (spellName) then
			-- Pour les sorts avec des rangs numérotés, on compare pour chaque sort les rangs 1 à 1
			-- Le rang supérieur est conservé
			if (string.find(subSpellName, SpiritSphere_TRANSLATION.Rank)) then
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
				-- Les plus grands rangs de chacun des sorts à rang numérotés sont insérés dans la table
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
	for spell=1, table.getn(SpiritSphere_SPELL_TABLE.Name), 1 do
		for index=1, table.getn(CurrentSpells.Name), 1 do
			if (SpiritSphere_SPELL_TABLE.Name[spell] == CurrentSpells.Name[index]) then
				SpiritSphere_SPELL_TABLE.ID[spell] = CurrentSpells.ID[index];
				SpiritSphere_SPELL_TABLE.Rank[spell] = CurrentSpells.subName[index];
			end
		end
	end
	
  for index=1, table.getn(SpiritSphere_SPELL_TABLE.Name), 1 do
		SpiritSphere_SPELL_TABLE.ID[index] = 0;
	end
	for spellID=1, MAX_SPELLS, 1 do
        local spellName, subSpellName = GetSpellName(spellID, "spell");
		if (spellName) then
			for index=1, table.getn(SpiritSphere_SPELL_TABLE.Name), 1 do
				if SpiritSphere_SPELL_TABLE.Name[index] == spellName then
			    SpiritSphere_MoneyToggle();
	        GameTooltip:SetSpell(spellID,1);
          local _, _, ManaCost = string.find(GameTooltipTextLeft2:GetText(), "(%d+)");
          SpiritSphere_MoneyToggle();
					SpiritSphere_SPELL_TABLE.ID[index] = spellID;
					SpiritSphere_SPELL_TABLE.Mana[index] = tonumber(ManaCost);
				end
			end
		end
	end
	
end

function SpiritSphere_MoneyToggle()
	for index=1, 10 do
		local text = getglobal("GameTooltipTextLeft"..index);
			text:SetText(nil);
			text = getglobal("GameTooltipTextRight"..index);
			text:SetText(nil);
	end
	GameTooltip:Hide();
	GameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE"); 
end
