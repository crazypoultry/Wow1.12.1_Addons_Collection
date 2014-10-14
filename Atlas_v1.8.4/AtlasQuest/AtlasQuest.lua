-- ********************************************************
-- *          This is AtlasQuest v 3.17.49! enjoy ;)      *
-- ********************************************************
-- *                                                      *
-- * Author: Asurn                                        *
-- *                                                      *
-- * Translation:                                         *
-- * EN: Asurn                                            *
-- * DE: Asurn                                            *
-- * FR:                                                  *
-- * CN: DIY                                              *
-- ********************************************************
-- *  What does AtlasQuest?                               *
-- *++++++++++++++++++++++++++++++++++++++++++++++++++++++*
-- *                                                      *
-- *AtlasQuest shows you information about                *
-- *Quests in every Instances.                            *
-- *+ The official Story (taken from www.wow.europe.com)  *
-- *                                                      *
-- * - Shown Information:                                 *
-- * Questname, Questlevel, Attainded level to get        *
-- * the Quest, Where you get the Quest, Questrewards,    *
-- * a note about the Quest, the Quest aftert his quest   *
-- * and the prequest                                     *
-- *                                                      *
-- *                                                      *
-- *                                                      *
-- *                                                      *
-- ********************************************************

-- Farben
local PURPLE = "|cff999999"; -- grey atm -- removed/useless atm
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local GREY = "|cff9F3FFF"; --purple now ^^
local BLUE = "|cff0070dd";
local ORANGE = "|cffff6090"; -- it is rosa now
local YELLOW = "|cffffff00";
local BLACK = "|c0000000f";
local DARKGREEN = "|cff008000";
local BLUB = "|cffd45e19";

-- Quest Color
local Grau = "|cff9d9d9d"
local Gruen = "|cff1eff00"
local Orange = "|cffFF8000"
local Rot = "|cffFF0000"
local Gelb = "|cffFFd200"
local Blau = "|cff0070dd"

--Variablen -> need explaination / register TO DO!

local Initialized = nil; -- Die Variablen sind noch nicht geladen

Allianceorhorde = 1; --variable um festzulegen ob horde oder allianz angezeigt wird

local EnglishFraction = ""; --nötig um festzustellen welcher fraktion man angehört

local LocalizedFraction = ""; -- nötig um festzustellen welcher fraktion man angehört

AQINSTANZ = 1; -- momentan angezeigtes Instanzbild (siehe AtlasQuest_Instanzen.lua)

AQINSTATM = ""; -- variable um zu sehn ob sich AQINSTANZ verändert hat (siehe function AtlasQuestSetTextandButtons())

--AQ_ShownSide = "Left"  -- Legt die seite fest auf der das AQ Panle angezeigt wird

--AQAtlasAuto (option beim atlas öffnen AQpanel automatisch anzeigen 1=Ja 2=Nein)

AQ_ShownSide = "Left"
AQAtlasAuto = 1;
AQNOColourCheck = nil;
AtlasQuestHelp = {};
AtlasQuestHelp[1] = "[/aq + availeable command: help, left/right, show/hide, autoshow\ndownload adress:\nhttp://ui.worldofwar.net/ui.php?id=3069, http://www.curse-gaming.com/de/wow/addons-4714-1-atlasquest.html]";

local AtlasQuest_Defaults = {
  ["Version"] =  "3.17.49",
  [UnitName("player")] = {
    ["ShownSide"] = "Left",
    ["AtlasAutoShow"] = 1,
    ["NOColourCheck"] = nil,
    ["CheckQuestlog"] = nil,
    ["SetFraction"] = nil,
    ["EquipCompare"] = nil,
  },
};

AQ = {};
-------------------------------------------------------------------------
---------------------------------- FUNKTIONEN ---------------------------
-------------------------------------------------------------------------

--******************************************
------------------/////Events: OnEvent//////
--******************************************

--------------------------------
-- called when the player starts the game loads the variables
--------------------------------
function AtlasQuest_OnEvent()
   if (event == "VARIABLES_LOADED") then
      VariablesLoaded = 1; -- Daten sind vollständig geladen
   else
      AtlasQuest_Initialize(); -- Spieler betritt die Welt / Initialisiere die Daten
   end
end

--------------------------------
-- Stellt fest ob die Variablen geladen werden müssen
-- oder legt sie neu fest
--------------------------------
function AtlasQuest_Initialize()
  if (Initialized or (not VariablesLoaded)) then
    return;
  end
  if (not AtlasQuest_Options) then
    AtlasQuest_Options = AtlasQuest_Defaults;
    DEFAULT_CHAT_FRAME:AddMessage("AtlasQuest Options database not found. Generating...");
  elseif (not AtlasQuest_Options[UnitName("player")]) then
    DEFAULT_CHAT_FRAME:AddMessage("Generate default database for this character");
    AtlasQuest_Options[UnitName("player")] = AtlasQuest_Defaults[UnitName("player")]
  end
  if (type(AtlasQuest_Options[UnitName("player")]) == "table") then
    AQVersionCheck();
    AtlasQuest_LoadData();
  end
  Initialized = 1;
end

--------------------------------
-- NewVersion check
--------------------------------
function AQVersionCheck()
 if (AtlasQuest_Options["Version"] == nil or AtlasQuest_Options["Version"] ~= AtlasQuest_Defaults["Version"] ) then
   AtlasQuest_Options["Version"] = AtlasQuest_Defaults["Version"];
   DEFAULT_CHAT_FRAME:AddMessage("First load after updating to "..ATLASQUEST_VERSION);
 end
end
--------------------------------
-- loads the saved varaibales
--------------------------------
function AtlasQuest_LoadData()
  -- Which side
  if(AtlasQuest_Options[UnitName("player")]["ShownSide"] ~= nil) then
    AQ_ShownSide = AtlasQuest_Options[UnitName("player")]["ShownSide"];
  end
  -- atlas autoshow
  if(AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"] ~= nil) then
    AQAtlasAuto = AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"];
  end
  -- Colour Check? if nil = no cc; if true = cc
  AQNOColourCheck = AtlasQuest_Options[UnitName("player")]["NOColourCheck"];
  -- Finished??
  for i=1, 38 do
   for b=1, 18 do
    AQ[ "AQFinishedQuest_Inst"..i.."Quest"..b ] = AtlasQuest_Options[UnitName("player")]["AQFinishedQuest_Inst"..i.."Quest"..b]
    AQ[ "AQFinishedQuest_Inst"..i.."Quest"..b.."_HORDE" ] = AtlasQuest_Options[UnitName("player")]["AQFinishedQuest_Inst"..i.."Quest"..b.."_HORDE"]
   end
  end
  --AQCheckQuestlog
  AQCheckQuestlog = AtlasQuest_Options[UnitName("player")]["CheckQuestlog"];
  -- Fraction option
  AQSetFraction = AtlasQuest_Options[UnitName("player")]["SetFraction"];
  -- EquipCompare
  AQEquipCompare = AtlasQuest_Options[UnitName("player")]["EquipCompare"];
  if (AQEquipCompare ~= nil and EquipCompare_RegisterTooltip) then
     EquipCompare_UnregisterTooltip(AtlasQuestTooltip);
  elseif (AQEquipCompare == nil and EquipCompare_RegisterTooltip) then
     EquipCompare_RegisterTooltip(AtlasQuestTooltip);
  end
end

--------------------------------
-- Speichert die Variablen
--------------------------------
function AtlasQuest_SaveData()
  AtlasQuest_Options[UnitName("player")]["ShownSide"] = AQ_ShownSide;
  AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"] = AQAtlasAuto;
  AtlasQuest_Options[UnitName("player")]["ColourCheck"] = AQNOColourCheck;
  AtlasQuest_Options[UnitName("player")]["CheckQuestlog"] = AQCheckQuestlog;
  AtlasQuest_Options[UnitName("player")]["SetFraction"] = AQSetFraction;
  AtlasQuest_Options[UnitName("player")]["EquipCompare"] = AQEquipCompare;
end

------------------ Events: OnEvent -> end

--******************************************
------------------/////Events: Onload//////
--******************************************

--------------------------------
-- Call OnLoad set Variables and hides the panel
--------------------------------
function AQ_OnLoad()
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
    this:RegisterEvent("VARIABLES_LOADED");
    AQSetFont(); -- change the font if CN is used
    AQFraktionCheck();
    AQSetButtontext(); -- translation for all buttons
    AQTEXTonload();
    if ( AtlasFrame ) then
    	AQATLASMAP = AtlasMap:GetTexture()
    else
	AQATLASMAP = 36;
    end
    this:RegisterForDrag("LeftButton");
    AQSlashCommandfunction();
	--ersmal nicht anzeigen
    HideUIPanel(AtlasQuestFrame);
    HideUIPanel(AtlasQuestInsideFrame);
    HideUIPanel(AtlasQuestOptionFrame);
    --AQAtlasVersionCheck();
    AQUpdateNOW = true;
end


--------------------------------
-- Font Function
-- change font if CN is used
------------------------------
--AQ_Font = "Fonts\FRIZQT__.TTF"
function AQSetFont()
    -- AQRIGHTOptionTEXT:SetFont("FRIZQT__.TTF",7,"OUTLINE, MONOCHROME") -- WHY THE HELL DOES THIS NOT WORK?
    -- AQLEFTOptionTEXT:SetFontObject("GameFontNormal") --works :)
local x = nil
    if ( GetLocale() == "zhCN" and x ~= nil) then
      -- option frame
      AQCaptionOptionTEXT:SetFontObject("AQCNFontBIG");
      AQAutoshowOptionTEXT:SetFontObject("AQCNFontVERYSmall");
      AQLEFTOptionTEXT:SetFontObject("AQCNFontVERYSmall");
      AQRIGHTOptionTEXT:SetFontObject("AQCNFontVERYSmall");
      AQColourOptionTEXT:SetFontObject("AQCNFontVERYSmall");
      AQCheckQuestlogTEXT:SetFontObject("AQCNFontVERYSmall");
      AQSetFractionTEXT:SetFontObject("AQCNFontVERYSmall");
      -- button text
      for i=1, 18 do
        getglobal(AQBUTTONTEXT..i):SetFontObject("AQCNFontVERYSmall");
      end
      -- inside panel
      Questueberschrift:SetFontObject("AQCNFontBIG");
      QuestLeveltext:SetFontObject("AQCNFont");
      QuestAttainLeveltext:SetFontObject("AQCNFont");
      Prequesttext:SetFontObject("AQCNFont");
      StoryTEXT:SetFontObject("AQCNFontBIG");
      REWARDstext:SetFontObject("AQCNFontBIG");
      AQFQ_TEXT:SetFontObject("AQCNFont");
      AQPageCount:SetFontObject("AQCNFontBIG");
    end
end

--------------------------------
-- Slahs command added
------------------------------
function AQSlashCommandfunction()
    SlashCmdList["ATLASQ"]=atlasquest_command;
	SLASH_ATLASQ1="/aq";
	SLASH_ATLASQ2="/atlasquest";
end

-------------------------------
-- Atlas Version Check (deaktiviert)
-------------------------------
function AQAtlasVersionCheck()
   -- if (ATLAS_VERSION == "1.8") then
   --     --do nothing
   --   else
   --       ChatFrame1:AddMessage(ATLAS_VERSIONWARNINGTEXT);
   -- end -- momentan nutzlos und fehleranfällig vll spätere wieder einführung
end

------------------------------
-- check the fraction and set the check button --disabeld
-------------------------------
function AQFraktionCheck()
  --  EnglishFraction, LocalizedFraction = UnitFactionGroup("player");
  --  if ( EnglishFraction == "Horde") then
  --     Allianceorhorde = 2;
  --     AQHCB:SetChecked(true);
  --     AQACB:SetChecked(false);
  --  end
end

---------------------------------
-- set the button text
---------------------------------
function AQSetButtontext()
      STORYbutton:SetText(AQStoryB);
      OPTIONbutton:SetText(AQOptionB);
      AQOptionCloseButton:SetText(AQ_OK);
      AtlasQuestUeberschrift:SetText(ATLASQUEST_VERSION);
      AQCaptionOptionTEXT:SetText(AQOptionsCaptionTEXT);
      AQAutoshowOptionTEXT:SetText(AQOptionsAutoshowTEXT);
      AQLEFTOptionTEXT:SetText(AQOptionsLEFTTEXT);
      AQRIGHTOptionTEXT:SetText(AQOptionsRIGHTTEXT);
      AQColourOptionTEXT:SetText(AQOptionsCCTEXT);
      AQFQ_TEXT:SetText(AQFinishedTEXT);
      AQCheckQuestlogTEXT:SetText(AQQLColourChange);
      AQSetFractionTEXT:SetText(AQOptionsSetFractionTEXT);
      AQEquipCompareOptionTEXT:SetText(WHITE .. AQOptionEquipCompareTEXT)
end

---------------------------------
-- show the loaded text
---------------------------------
function AQTEXTonload()
    ChatFrame1:AddMessage(ATLASQUEST_VERSION..GREY.." = loaded, by ASURN");
    ChatFrame1:AddMessage(GREY.."type /aq or /atlasquest show the version number");
    ChatFrame1:AddMessage(RED.."Attention:"..GREY.."You need Atlas or AlphaMap to use AtlasQuest");
end

---------------------------------
--  Slashcommand!! show/hide panel + Version Message
---------------------------------
function atlasquest_command(param)

  -- Version text (AQ and Atlas(if there) and Alphamap (if there))
  ChatFrame1:AddMessage(ATLASQUEST_VERSION);
  if (AtlasFrame ~= nil) then
    ChatFrame1:AddMessage("Atlasversion: "..ATLAS_VERSION);
  end
  if (AlphaMapFrame ~= nil) then
    ChatFrame1:AddMessage("AlphaMapversion: "..ALPHA_MAP_VERSION);
  end

  --help text
  if (param == "help") then
    ChatFrame1:AddMessage(RED..AQHelpText);
  -- hide show function
  elseif (param == "show") then
      ShowUIPanel(AtlasQuestFrame);
      ChatFrame1:AddMessage("Shows AtlasQuest");
  elseif (param == "hide") then
      HideUIPanel(AtlasQuestFrame);
      HideUIPanel(AtlasQuestInsideFrame);
      ChatFrame1:AddMessage("Hides AtlasQuest");
  -- right/left show function
  elseif (param == "right") then
     AQRIGHTOption_OnClick();
  elseif (param == "left") then
     AQLEFTOption_OnClick();
  -- Options
  elseif ((param == "option") or (param == "config")) then
      ShowUIPanel(AtlasQuestOptionFrame);
  --test messages
  elseif (param == "test") then
     AQTestmessages();
  -- autoshow
  elseif (param == "autoshow") then
     AQAutoshowOption_OnClick()
  -- CC
  elseif (param == "colour") then
     AQColourOption_OnClick();
  else
    ChatFrame1:AddMessage(RED..param..WHITE.." Unnown command!! Use '/aq help'");
  end
end

---------------------------------
--  testmessages
---------------------------------
function AQTestmessages()
  --[[   local Testquestname = "1. Supplies to Tannok";
     local Testquestname2 = "Supplies to Tannok";
     local Testquestname3 = strsub(Testquestname, 4)

     ChatFrame1:AddMessage("TEST/DEBUG - Quest");
     BLA = GetNumQuestLogEntries();
     ChatFrame1:AddMessage("Quest entries "..BLA);
     for questIndex=1, BLA do
     BLAX = {
     [questIndex] = GetQuestLogTitle(questIndex);
     };
     ChatFrame1:AddMessage("Quest name des Quests ["..questIndex.."]: "..BLAX[questIndex]);
     ChatFrame1:AddMessage(type(BLAX[questIndex]));
     if (BLAX[questIndex] == Testquestname) then
      ChatFrame1:AddMessage("Test1 bestanden");
     end
     if (BLAX[questIndex] == Testquestname2) then
      ChatFrame1:AddMessage("Test2 bestanden :(");
     end
     end
     ChatFrame1:AddMessage(BLAX[4]);
     ChatFrame1:AddMessage(Testquestname2);
     ChatFrame1:AddMessage(type(BLAX[4]));
     ChatFrame1:AddMessage(type(Testquestname2));
     if (BLAX[4] == Testquestname2) then
      ChatFrame1:AddMessage("!!!");
     else
      ChatFrame1:AddMessage(":(");
     end
     ChatFrame1:AddMessage("Test3!!! :"..Testquestname3);
     if (BLAX[4] == Testquestname3) then
      ChatFrame1:AddMessage("!!!");
     else
      ChatFrame1:AddMessage(":(");
     end
     ]]
local itemId = Inst1Quest1ID1
local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemTexture
  = GetItemInfo(itemId);
ChatFrame1:AddMessage("Test ID!");
ChatFrame1:AddMessage("itemName, itemLink, itemQuality, itemLevel:");
ChatFrame1:AddMessage(itemName..","..itemLink..","..itemQuality..","..itemLevel);
ChatFrame1:AddMessage("itemType, itemSubType, itemCount, itemTexture:");
ChatFrame1:AddMessage(itemType..","..itemSubType..","..itemCount..","..itemTexture);
end

------------------ Events: Onload -> end





--******************************************
------------------////// Events: OnUpdate//////
--******************************************

---------------------------------
--  On Update function
-- check which programm is used( atlas or am)
-- hide panel if instanze is 36(=nothing)
---------------------------------
function AQ_OnUpdate(arg1)
  local previousValue = AQINSTANZ;

        AQ_AtlasOrAMVISCheck(); -- Show whether atlas or am is shown atm

        ------- SEE AtlasQuest_Instanzen.lua
        if (AtlasORAlphaMap == "Atlas") then
           AtlasQuest_Instanzenchecken();
        elseif (AtlasORAlphaMap == "AlphaMap") then
           AtlasQuest_InstanzencheckAM();
        end

        -- Hides the panel if the map which is shown no quests have (map = 36)
       if ( AQINSTANZ == 36) then
             HideUIPanel(AtlasQuestFrame);
             HideUIPanel(AtlasQuestInsideFrame);
       elseif (( AQINSTANZ ~= previousValue ) or (AQUpdateNOW ~= nil)) then
           AtlasQuestSetTextandButtons();
           AQUpdateNOW = nil
           AQ_SetCaption();
       elseif ((AtlasORAlphaMap == "AlphaMap") and (AlphaMapAlphaMapFrame:IsVisible() == nil)) then
           HideUIPanel(AtlasQuestFrame);
           HideUIPanel(AtlasQuestInsideFrame);
       end
end

---------------------------------
--  Show whether atlas or am is shown atm
---------------------------------
function AQ_AtlasOrAMVISCheck()
        if ((AtlasFrame ~= nil) and (AtlasFrame:IsVisible())) then
           AtlasORAlphaMap = "Atlas";
        elseif (AlphaMapFrame:IsVisible()) then
           AtlasORAlphaMap = "AlphaMap";
        end
end
---------------------------------
--  AlphaMap parent change
---------------------------------
function AQ_AtlasOrAlphamap()
        if ((AtlasFrame ~= nil) and (AtlasFrame:IsVisible())) then
           AtlasORAlphaMap = "Atlas";
           --
           AtlasQuestFrame:SetParent(AtlasFrame);
           if (AQ_ShownSide == "Right" ) then
               AtlasQuestFrame:ClearAllPoints();
               AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 511, -80);
           else
               AtlasQuestFrame:ClearAllPoints();
               AtlasQuestFrame:SetPoint("TOP","AtlasFrame", -503, -80);
           end
           AtlasQuestInsideFrame:SetParent(AtlasFrame);
           AtlasQuestInsideFrame:ClearAllPoints();
           AtlasQuestInsideFrame:SetPoint("TOPLEFT","AtlasFrame", 18, -84);
        elseif ((AlphaMapFrame ~= nil) and (AlphaMapFrame:IsVisible())) then
           AtlasORAlphaMap = "AlphaMap";
           --
           AtlasQuestFrame:SetParent(AlphaMapFrame);
           if (AQ_ShownSide == "Right" ) then
             AtlasQuestFrame:ClearAllPoints();
             AtlasQuestFrame:SetPoint("TOP","AlphaMapFrame", 400, -107);
           else
             AtlasQuestFrame:ClearAllPoints();
             AtlasQuestFrame:SetPoint("TOPLEFT","AlphaMapFrame", -195, -107);
           end
           AtlasQuestInsideFrame:SetParent(AlphaMapFrame);
           AtlasQuestInsideFrame:ClearAllPoints();
           AtlasQuestInsideFrame:SetPoint("TOPLEFT","AlphaMapFrame", 1, -108);
        end
end

---------------------------------
--  Set the ZoneName
---------------------------------
function AQ_SetCaption()
    Ueberschriftborder:SetText();
    for i=1, 38 do
       if ( (AQINSTANZ == i) and (getglobal("Inst"..i.."Caption") ~= nil)) then
          Ueberschriftborder:SetText(getglobal("Inst"..i.."Caption"))
       end
    end
end

---------------------------------
--  Set the Buttontext and the buttons if availeable
--  and check whether its a other inst or not -> works fine
--  added: Check for Questline arrows
--  Questline arrows are shown if InstXQuestYFQuest = "true"
--  QuestStart icon are shown if InstXQuestYPreQuest = "true"
---------------------------------
function AtlasQuestSetTextandButtons()
local AQQuestlevelf
local AQQuestfarbe
local AQQuestfarbe2
   if (AQINSTATM ~= AQINSTANZ) then
      HideUIPanel(AtlasQuestInsideFrame);
   end
       if (Allianceorhorde == 1) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..AQINSTANZ.."QAA") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..AQINSTANZ.."QAA"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, 18 do
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b.."FQuest")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\Glues\\Login\\UI-BackArrow")
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             elseif (getglobal("Inst"..AQINSTANZ.."Quest"..b.."PreQuest")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\PetitionGossipIcon")
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             else
                HideUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             if (AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b ] == 1) then
               getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\BinderGossipIcon")
               ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             AQQuestlevelf = tonumber(getglobal("Inst"..AQINSTANZ.."Quest"..b.."_Level"));
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b) ~= nil) then
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 100) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   end
                   if (AQNOColourCheck) then
                      AQQuestfarbe = Gelb;
                   end
                   if ( AQQuestlevelf == 100 or AQCompareQLtoAQ(b)) then
                      AQQuestfarbe = Blau;
                   end
                   if ( AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b ] == 1) then
                     AQQuestfarbe = WHITE;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..AQINSTANZ.."Quest"..b));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
       if (Allianceorhorde == 2) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..AQINSTANZ.."QAH") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..AQINSTANZ.."QAH"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, 18 do
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b.."FQuest_HORDE")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\Glues\\Login\\UI-BackArrow")
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             elseif (getglobal("Inst"..AQINSTANZ.."Quest"..b.."PreQuest_HORDE")) then
                getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\PetitionGossipIcon")
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             else
                HideUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             if (AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b.."_HORDE" ] == 1) then
               getglobal("AQQuestlineArrow_"..b):SetTexture("Interface\\GossipFrame\\BinderGossipIcon")
               ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             if (getglobal("Inst"..AQINSTANZ.."Quest"..b.."_HORDE") ~= nil) then
                AQQuestlevelf = tonumber(getglobal("Inst"..AQINSTANZ.."Quest"..b.."_HORDE_Level"));
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 100) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   end
                   if (AQNOColourCheck) then
                      AQQuestfarbe = Gelb;
                   end
                   if ( AQQuestlevelf == 100 or AQCompareQLtoAQ(b)) then
                      AQQuestfarbe = Blau;
                   end
                   if ( AQ[ "AQFinishedQuest_Inst"..AQINSTANZ.."Quest"..b.."_HORDE" ] == 1) then
                     AQQuestfarbe = WHITE;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..AQINSTANZ.."Quest"..b.."_HORDE"));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
end

---------------------------------
-- Colours quest blue if they are in your questlog
---------------------------------
function AQCompareQLtoAQ(Quest)
local TotalQuestEntries
local CurrentQuestnum
local OnlyQuestNameRemovedNumber
local Questisthere
local x
local y
local z
local count

  if (AQCheckQuestlog == nil) then -- Option to turn the check on or off
    if (Quest == nil) then  -- added for use in button text to change the caption dunno whether i add it or not
      Quest = AQSHOWNQUEST;
    end
    if (Quest <= 9) then
      if (Allianceorhorde == 1) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest), 4)
      elseif (Allianceorhorde == 2) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest.."_HORDE"), 4)
      end
    elseif (Quest > 9) then
      if (Allianceorhorde == 1) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest), 5)
      elseif (Allianceorhorde == 2) then
        OnlyQuestNameRemovedNumber = strsub(getglobal("Inst"..AQINSTANZ.."Quest"..Quest.."_HORDE"), 5)
      end
    end
    --this checks should be done everytime when the questupdate event gets executed
    TotalQuestEntries = GetNumQuestLogEntries();
    for CurrentQuestnum=1, TotalQuestEntries do
      x, y, z = GetQuestLogTitle(CurrentQuestnum)
      TotalQuestsTable = {
        [CurrentQuestnum] = x,
      };
      if ((CT_QuestLevels_ShowQuestLevels ~= nil) and (CT_QuestLevels_ShowQuestLevels == 1)) then
        count = 4;
        if (y > 10) then
          count = count + 2;
        else
          count = count + 1;
        end
        if ((z == ELITE ) or ( z == RAID ) or ( z == "Dungeon" ) or ( z == "Donjon" )) then
          count = count + 1;
        end
        TotalQuestsTable = {
          [CurrentQuestnum] = strsub(x, count)
         };
      end
      --expect this
      if (TotalQuestsTable[CurrentQuestnum] == OnlyQuestNameRemovedNumber) then
        Questisthere = 1;
      end
    end
    if (Questisthere == 1) then
      return true;
    else
      return false;
    end
    --
  else
    return false;
  end
end

------------------ Events: OnUpdate -> End

--******************************************
------------------ /////Events: Atlas_OnShow //////
--******************************************

---------------------------------
-- Shows the AQ panel with atlas (option adden!)
---------------------------------
function Atlas_OnShow()
    if ( AQAtlasAuto == 1) then
     ShowUIPanel(AtlasQuestFrame);
    else
     HideUIPanel(AtlasQuestFrame);
    end
    HideUIPanel(AtlasQuestInsideFrame);
   -- AQ_AtlasOrAlphamap();
   if (AQ_ShownSide == "Right") then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 511, -80);
  end
end

------------------ Events: Atlas_OnShow -> End

--******************************************
------------------//// OnEnter/OnLeave ITEM ANZEIGEN ///////
--******************************************

---------------------------------
-- hide tooltip
---------------------------------
function AtlasQuestItem_OnLeave()
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
        if(AtlasQuestTooltip:IsVisible()) then
            AtlasQuestTooltip:Hide();
        end
end

---------------------------------
-- show tooltip
-- update: function added to check whether there is a ID or not
-- update perhaps useless if hide function works -> but will stay
---------------------------------
function AtlasQuestItem_OnEnter()
           if ( Allianceorhorde == 1) then
               if (getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN) ~= nil) then
                 if (getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN) ~= nil) then
                  if(GetItemInfo(getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN)) ~= nil) then
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                         AtlasQuestTooltip:SetHyperlink("item:"..getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN)..":0:0:0");
                        AtlasQuestTooltip:Show();
                  else
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasQuestTooltip:ClearLines();
                        AtlasQuestTooltip:AddLine(RED..AQERRORNOTSHOWN);
                        AtlasQuestTooltip:AddLine(AQERRORASKSERVER);
                        AtlasQuestTooltip:Show();
                  end
                 end
               end
           else
               if (getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE") ~= nil) then
                 if (getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE") ~= nil) then
                  if(GetItemInfo(getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE")) ~= nil) then
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasQuestTooltip:SetHyperlink("item:"..getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE")..":0:0:0");
                        AtlasQuestTooltip:Show();
                  else
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasQuestTooltip:ClearLines();
                        AtlasQuestTooltip:AddLine(RED..AQERRORNOTSHOWN);
                        AtlasQuestTooltip:AddLine(AQERRORASKSERVER);
                        AtlasQuestTooltip:Show();
                  end
                 end
               end
           end
end

---------------------------------
-- ask Server right-click
-- + shift click to send link
-- + str click for dressroom
-- BIG THANKS TO Daviesh and ATLASLOOT for the CODE
---------------------------------
function AtlasQuestItem_OnClick(arg1)
local SHOWNID
local name
local nameDATA
local colour
local itemName, itemQuality
if ( Allianceorhorde == 1) then
  SHOWNID = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN);
  colour = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN);
  nameDATA = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN);
else
  SHOWNID = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE");
  colour = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN.."_HORDE");
  nameDATA = getglobal("Inst"..AQINSTANZ.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN.."_HORDE");
end
        if(arg1=="RightButton") then
                   AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                   AtlasQuestTooltip:SetHyperlink("item:"..SHOWNID..":0:0:0");
                   AtlasQuestTooltip:Show();
                   DEFAULT_CHAT_FRAME:AddMessage(AQSERVERASK.."["..colour..nameDATA..WHITE.."]"..AQSERVERASKInformation);
        elseif(ChatFrameEditBox:IsVisible() and IsShiftKeyDown()) then
            if (GetItemInfo(SHOWNID)) then
              itemName, _, itemQuality = GetItemInfo(SHOWNID);
              local r, g, b, hex = GetItemQualityColor(itemQuality);
              itemtext = hex..itemName;
		      ChatFrameEditBox:Insert(hex.."|Hitem:"..SHOWNID..":0:0:0|h["..itemName.."]|h|r");
		    else
		      DEFAULT_CHAT_FRAME:AddMessage("Item unsafe! Right click to get the item ID")
		      ChatFrameEditBox:Insert("["..nameDATA.."]");
		    end
		--If control-clicked, use the dressing room
        elseif(IsControlKeyDown() and GetItemInfo(SHOWNID)) then
          DressUpItemLink(SHOWNID);
		end
end

------------------ OnEnter/OnLeave ITEM ANZEIGEN -> END

---------------------------------
-- only added for the SetFraction option
---------------------------------
function AQ_OnShow()
  if (AQSetFraction ~= nil) then
    Allianceorhorde = 2;
    AQHCB:SetChecked(true);
    AQACB:SetChecked(false);
  else
    Allianceorhorde = 1;
    AQHCB:SetChecked(false);
    AQACB:SetChecked(true);
  end
  AtlasQuestSetTextandButtons()
end
-------------------------------------------------------------------------------------------------------------------

--|cffff0000 - Spieler 1 (Rot)
--|cff0000ff - Spieler 2 (Blau)
--|cff00ffff - Spieler 3 (Blaugrau)
--|cff6f2583 - Spieler 4 (Lila)
--|cffffff00 - Spieler 5 (Gelb)
--|cffd45e19 - Spieler 6 (Orange)
--|cff00ff00 - Spieler 7 (Grün)
--|cffff8080 - Spieler 8 (Rosa)
--|cff808080 - Spieler 9 (Grau)
--|cff8080ff - Spieler 10 (Hellblau)
--|cff008000 - Spieler 11 (Dunkelgrün)
--|cff4d2903 - Spieler 12 (Braun)




--Chatframe1:AddMessage("text") fügt eine nachricht ins allgemeine chatfenster ein
--message("Text") gibt eine fehelrmeldung mit dem text wieder

--    AQINSTANZ :
-- 1  = VC     21 = BSF
-- 2  = WC     22 = STRAT
-- 3  = RFA    23 = AQ20
-- 4  = ULD    24 = STOCKADE
-- 5  = BRD    25 = TEMPLE
-- 6  = BWl    26 = AQ40
-- 7  = BFD    27 = ZUL
-- 8  = LBRS   28 = ZG
-- 9  = UBRS   29 = GNOMERE
-- 10 = DME    30 = DRAGONS
-- 11 = DMN    31 = AZUREGOS
-- 12 = DMW    32 = KAZZAK
-- 13 = MARA   33 = AV
-- 14 = MC     34 = AB
-- 15 = NAXX   35 = WS
-- 16 = ONY    36 = REST
-- 17 = HUEGEL 37 = HCBloodFurnaces
-- 18 = KRAL   38 = HCShatteredHalls
-- 19 = KLOSTER
-- 20 = SCHOLO