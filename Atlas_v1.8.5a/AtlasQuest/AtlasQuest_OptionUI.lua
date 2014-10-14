local WHITE = "|cffFFFFFF";
local GREY = "|cff999999"; -- really grey
---------------------------------
-- Initialisiert das Optiosn panel
-- und setzt die hacken nach den variabeln
---------------------------------
function AtlasQuestOptionFrame_OnShow()
    --autoshow
    if (AQAtlasAuto == 2) then
       AQAutoshowOption:SetChecked(false);
    end
    --left/right
    if (AQ_ShownSide == "Left") then
       AQRIGHTOption:SetChecked(false);
       AQLEFTOption:SetChecked(true);
    else
       AQRIGHTOption:SetChecked(true);
       AQLEFTOption:SetChecked(false);
    end
    -- Colour Check
    if (AQNOColourCheck) then
       AQColourOption:SetChecked(false);
    else
       AQColourOption:SetChecked(true);
    end
    --AQCheckQuestlog
    if (AQCheckQuestlog == nil) then
      AQCheckQuestlogButton:SetChecked(true);
    else
      AQCheckQuestlogButton:SetChecked(false);
    end
    -- SetFraction
    if (AQSetFraction == nil) then
      AQSetFractionOption:SetChecked(true);
    else
      AQSetFractionOption:SetChecked(false);
    end
    -- Equip Compare support
    if( not EquipCompare_RegisterTooltip ) then
      AQEquipCompareOption:Disable();
      AQEquipCompareOptionTEXT:SetText(GREY .. AQOptionEquipCompareTEXT)
    else
      AQEquipCompareOption:Enable();
      AQEquipCompareOptionTEXT:SetText(WHITE .. AQOptionEquipCompareTEXT)
      if (AQEquipCompare == nil) then
        AQEquipCompareOption:SetChecked(true);
      else
        AQEquipCompareOption:SetChecked(false);
      end
    end
end

---------------------------------
-- Autoshow option
---------------------------------
function AQAutoshowOption_OnClick()
          if (AQAtlasAuto == 1) then
            AQAtlasAuto = 2;
            ChatFrame1:AddMessage(AQAtlasAutoOFF);
            AQAutoshowOption:SetChecked(false);
          else
            AQAtlasAuto = 1;
            ChatFrame1:AddMessage(AQAtlasAutoON);
            AQAutoshowOption:SetChecked(true);
          end
          AtlasQuest_SaveData();
end


---------------------------------
-- Right option
---------------------------------
function AQRIGHTOption_OnClick()
     if ((AtlasFrame ~= nil) and (AtlasORAlphaMap == "Atlas")) then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 511, -80);
     elseif (AtlasORAlphaMap == "AlphaMap") then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AlphaMapFrame", 400, -107);
     end
     AQRIGHTOption:SetChecked(true);
     AQLEFTOption:SetChecked(false);
     if (AQ_ShownSide ~= "Right") then
       ChatFrame1:AddMessage(AQShowRight);
     end
     AQ_ShownSide = "Right";
     AtlasQuest_SaveData();
end

---------------------------------
-- Left option
---------------------------------
function AQLEFTOption_OnClick()
    if ((AtlasFrame ~= nil) and (AtlasORAlphaMap == "Atlas") and ( AQ_ShownSide == "Right") ) then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AtlasFrame", -503, -80);
     elseif ((AtlasORAlphaMap == "AlphaMap") and ( AQ_ShownSide == "Right") ) then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOPLEFT","AlphaMapFrame", -195, -107);
     end
     AQRIGHTOption:SetChecked(false);
     AQLEFTOption:SetChecked(true);
     if (AQ_ShownSide ~= "Left") then
       ChatFrame1:AddMessage(AQShowLeft);
     end
     AQ_ShownSide = "Left";
     AtlasQuest_SaveData();
end

---------------------------------
-- Colour Check
-- if AQNOColourCheck = true then NO Colour Check
---------------------------------
function AQColourOption_OnClick()
    if (AQNOColourCheck) then
      AQNOColourCheck = nil;
      AQColourOption:SetChecked(true);
      ChatFrame1:AddMessage(AQCCON);
    else
      AQNOColourCheck = true;
      AQColourOption:SetChecked(false);
      ChatFrame1:AddMessage(AQCCOFF);
    end
    AtlasQuest_SaveData();
    AQUpdateNOW = true;
end

---------------------------------
-- CheckQuestlog option
---------------------------------
function AQCheckQuestlogButton_OnClick()
          if (AQCheckQuestlog == nil) then
            AQCheckQuestlog = "no";
            AQCheckQuestlogButton:SetChecked(false);
          else
            AQCheckQuestlog = nil;
            AQCheckQuestlogButton:SetChecked(true);
          end
          AtlasQuest_SaveData();
          AQUpdateNOW = true;
end

---------------------------------
-- Set the Fraction you see first when you open AQ
---------------------------------
function AQSetFractionOption_OnClick()
 if (AQSetFraction == nil) then
   AQSetFraction = "bla";
   AQSetFractionOption:SetChecked(false);
 else
   AQSetFraction = nil;
   AQSetFractionOption:SetChecked(true);
 end
 AtlasQuest_SaveData();
end

---------------------------------
-- sets whether you use EquipCompare or not
---------------------------------
function AQEquipCompareOption_OnClick()
  if (AQEquipCompare == nil and EquipCompare_RegisterTooltip) then
     AQEquipCompareOption:SetChecked(false);
     AQEquipCompare = "THIS SHIT IS NOT NIL";
     EquipCompare_UnregisterTooltip(AtlasQuestTooltip);
  elseif (AQEquipCompare ~= nil and EquipCompare_RegisterTooltip) then
     AQEquipCompareOption:SetChecked(true);
     AQEquipCompare = nil;
     EquipCompare_RegisterTooltip(AtlasQuestTooltip);
  end
  AtlasQuest_SaveData();
end