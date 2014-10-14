local HealBot_Options_ComboButtons_Button=1;
local HealBot_Options_DisComboButtons_Button=1;

function HealBot_Options_AddDebug(msg)
  HealBot_AddDebug("Options: " .. msg);
end

function HealBot_Options_Pct_OnLoad(this,text)
  this.text = text;
  getglobal(this:GetName().."Text"):SetText(text);
  getglobal(this:GetName().."Low"):SetText("0%");
  getglobal(this:GetName().."High"):SetText("100%");
  this:SetMinMaxValues(0.00,1.00);
  this:SetValueStep(0.01);
end

function HealBot_Options_Pct_OnLoad_MinMax(this,text,Min,Max)
  this.text = text;
  local MinTxt,MaxTxt

  MinTxt=(Min*100).."%";
  MaxTxt=(Max*100).."%";

  getglobal(this:GetName().."Text"):SetText(text);
  getglobal(this:GetName().."Low"):SetText(MinTxt);
  getglobal(this:GetName().."High"):SetText(MaxTxt);
  this:SetMinMaxValues(Min,Max);
  this:SetValueStep(0.01);
end

function HealBot_Options_val_OnLoad(this,text,Min,Max)
  this.text = text;

  getglobal(this:GetName().."Text"):SetText(text);
  getglobal(this:GetName().."Low"):SetText(Min);
  getglobal(this:GetName().."High"):SetText(Max);
  this:SetMinMaxValues(Min,Max);
  this:SetValueStep(1);
end

function HealBot_Options_Pct_OnValueChanged(this)
  local pct = math.floor(this:GetValue()*100+0.5);
  getglobal(this:GetName().."Text"):SetText(this.text .. " (" .. pct .. "%)");
  return this:GetValue();
end


function HealBot_Options_NewSkin_OnTextChanged(this)
  local text= this:GetText()
  if string.len(text)>0 then
    HealBot_Options_NewSkinb:Enable();
  else
    HealBot_Options_NewSkinb:Disable();
  end
end

function HealBot_Options_NewSkinb_OnClick(this)
  HealBot_Config.numcols[HealBot_Options_NewSkin:GetText()] = HealBot_Config.numcols[HealBot_Config.Current_Skin]
  HealBot_Config.btexture[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btexture[HealBot_Config.Current_Skin]
  HealBot_Config.bcspace[HealBot_Options_NewSkin:GetText()] = HealBot_Config.bcspace[HealBot_Config.Current_Skin]
  HealBot_Config.brspace[HealBot_Options_NewSkin:GetText()] = HealBot_Config.brspace[HealBot_Config.Current_Skin]
  HealBot_Config.bwidth[HealBot_Options_NewSkin:GetText()] = HealBot_Config.bwidth[HealBot_Config.Current_Skin]
  HealBot_Config.bheight[HealBot_Options_NewSkin:GetText()] = HealBot_Config.bheight[HealBot_Config.Current_Skin]
  HealBot_Config.btextenabledcolr[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextenabledcolr[HealBot_Config.Current_Skin]
  HealBot_Config.btextenabledcolg[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextenabledcolg[HealBot_Config.Current_Skin]
  HealBot_Config.btextenabledcolb[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextenabledcolb[HealBot_Config.Current_Skin]
  HealBot_Config.btextenabledcola[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextenabledcola[HealBot_Config.Current_Skin]
  HealBot_Config.btextdisbledcolr[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin]
  HealBot_Config.btextdisbledcolg[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin]
  HealBot_Config.btextdisbledcolb[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin]
  HealBot_Config.btextdisbledcola[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin]
  HealBot_Config.btextcursecolr[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextcursecolr[HealBot_Config.Current_Skin]
  HealBot_Config.btextcursecolg[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextcursecolg[HealBot_Config.Current_Skin]
  HealBot_Config.btextcursecolb[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextcursecolb[HealBot_Config.Current_Skin]
  HealBot_Config.btextcursecola[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextcursecola[HealBot_Config.Current_Skin]
  HealBot_Config.backcola[HealBot_Options_NewSkin:GetText()] = HealBot_Config.backcola[HealBot_Config.Current_Skin]
  HealBot_Config.Barcola[HealBot_Options_NewSkin:GetText()] = HealBot_Config.Barcola[HealBot_Config.Current_Skin]
  HealBot_Config.BarcolaInHeal[HealBot_Options_NewSkin:GetText()] = HealBot_Config.BarcolaInHeal[HealBot_Config.Current_Skin]
  HealBot_Config.backcolr[HealBot_Options_NewSkin:GetText()] = HealBot_Config.backcolr[HealBot_Config.Current_Skin]
  HealBot_Config.backcolg[HealBot_Options_NewSkin:GetText()] = HealBot_Config.backcolg[HealBot_Config.Current_Skin]
  HealBot_Config.backcolb[HealBot_Options_NewSkin:GetText()] = HealBot_Config.backcolb[HealBot_Config.Current_Skin]
  HealBot_Config.borcolr[HealBot_Options_NewSkin:GetText()] = HealBot_Config.borcolr[HealBot_Config.Current_Skin]
  HealBot_Config.borcolg[HealBot_Options_NewSkin:GetText()] = HealBot_Config.borcolg[HealBot_Config.Current_Skin]
  HealBot_Config.borcolb[HealBot_Options_NewSkin:GetText()] = HealBot_Config.borcolb[HealBot_Config.Current_Skin]
  HealBot_Config.borcola[HealBot_Options_NewSkin:GetText()] = HealBot_Config.borcola[HealBot_Config.Current_Skin]
  HealBot_Config.btextheight[HealBot_Options_NewSkin:GetText()] = HealBot_Config.btextheight[HealBot_Config.Current_Skin]
  HealBot_Config.bardisa[HealBot_Options_NewSkin:GetText()] = HealBot_Config.bardisa[HealBot_Config.Current_Skin]
  HealBot_Config.abortsize[HealBot_Options_NewSkin:GetText()] = HealBot_Config.abortsize[HealBot_Config.Current_Skin]
  HealBot_Config.babortcolr[HealBot_Options_NewSkin:GetText()] = HealBot_Config.babortcolr[HealBot_Config.Current_Skin]
  HealBot_Config.babortcolg[HealBot_Options_NewSkin:GetText()] = HealBot_Config.babortcolg[HealBot_Config.Current_Skin]
  HealBot_Config.babortcolb[HealBot_Options_NewSkin:GetText()] = HealBot_Config.babortcolb[HealBot_Config.Current_Skin]
  HealBot_Config.babortcola[HealBot_Options_NewSkin:GetText()] = HealBot_Config.babortcola[HealBot_Config.Current_Skin]
  HealBot_Config.ShowHeader[HealBot_Options_NewSkin:GetText()] = HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]

  table.insert(HealBot_Skins,2,HealBot_Options_NewSkin:GetText())
  HealBot_Config.Skin_ID = 2;
  HealBot_Config.Skins = HealBot_Skins;  HealBot_Config.Current_Skin = HealBot_Options_NewSkin:GetText();
  HealBot_Options_SetSkins()
  HealBot_Options_NewSkin:SetText("")
end

function HealBot_Options_DeleteSkin_OnClick(this)
  if HealBot_Config.Current_Skin~=HEALBOT_SKINS_STD then
    HealBot_Config.numcols[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btexture[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.bcspace[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.brspace[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.bwidth[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.bheight[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextenabledcolr[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextenabledcolg[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextenabledcolb[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextenabledcola[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextdisbledcolr[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextdisbledcolg[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextdisbledcolb[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextdisbledcola[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextcursecolr[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextcursecolg[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextcursecolb[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextcursecola[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.backcola[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.Barcola[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.BarcolaInHeal[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.backcolr[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.backcolg[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.backcolb[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.borcolr[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.borcolg[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.borcolb[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.borcola[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.btextheight[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.bardisa[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.abortsize[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.babortcolr[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.babortcolg[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.babortcolb[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.babortcola[HealBot_Options_SkinsText:GetText()] = nil
    HealBot_Config.ShowHeader[HealBot_Options_SkinsText:GetText()] = nil
    table.remove(HealBot_Skins,HealBot_Config.Skin_ID)
    HealBot_Config.Skin_ID = 1;
    HealBot_Config.Skins = HealBot_Skins;  
    HealBot_Config.Current_Skin = HEALBOT_SKINS_STD;
    HealBot_Options_SetSkins()
  end
end

function HealBot_Options_ShowHeaders_OnLoad(this)
  getglobal(this:GetName().."Text"):SetText(HEALBOT_OPTIONS_SHOWHEADERS);
end

function HealBot_Options_ShowHeaders_OnClick(this)
  HealBot_Config.ShowHeader[HealBot_Config.Current_Skin] = this:GetChecked();
  HealBot_Action_ResetSkin()
end
    
function HealBot_Options_BarTextureS_OnValueChanged(this)
  HealBot_Config.btexture[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_BarHeightS_OnValueChanged(this)
  HealBot_Config.bheight[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_BarWidthS_OnValueChanged(this)
  HealBot_Config.bwidth[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_BarNumColsS_OnValueChanged(this)
  HealBot_Config.numcols[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_BarBRSpaceS_OnValueChanged(this)
  HealBot_Config.brspace[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_BarBCSpaceS_OnValueChanged(this)
  HealBot_Config.bcspace[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_FontHeight_OnValueChanged(this)
  HealBot_Config.btextheight[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_AbortBarSize_OnValueChanged(this)
  HealBot_Config.abortsize[HealBot_Config.Current_Skin] = this:GetValue();
  getglobal(this:GetName().."Text"):SetText(this.text .. ": " .. this:GetValue());
  HealBot_Action_ResetSkin()
end

function HealBot_Options_ActionAlpha_OnValueChanged(this)
  HealBot_Config.backcola[HealBot_Config.Current_Skin] = HealBot_Options_Pct_OnValueChanged(this);
end

function HealBot_Options_BarAlpha_OnValueChanged(this)
  HealBot_Config.Barcola[HealBot_Config.Current_Skin] = HealBot_Options_Pct_OnValueChanged(this);
  HealBot_Action_ResetSkin()
end

function HealBot_Options_BarAlphaInHeal_OnValueChanged(this)
  HealBot_Config.BarcolaInHeal[HealBot_Config.Current_Skin] = HealBot_Options_Pct_OnValueChanged(this);
  HealBot_Action_ResetSkin()
end

function HealBot_Options_BarAlphaDis_OnValueChanged(this)
  HealBot_Config.bardisa[HealBot_Config.Current_Skin] = HealBot_Options_Pct_OnValueChanged(this);
  HealBot_Action_ResetSkin()
end

local HealBot_ColourObjWaiting
function HealBot_SkinColorpick_OnClick(SkinType)
  HealBot_ColourObjWaiting=SkinType;

  if SkinType=="En" then
    HealBot_UseColourPick(HealBot_Config.btextenabledcolr[HealBot_Config.Current_Skin],
                          HealBot_Config.btextenabledcolg[HealBot_Config.Current_Skin],
                          HealBot_Config.btextenabledcolb[HealBot_Config.Current_Skin],
                          HealBot_Config.btextenabledcola[HealBot_Config.Current_Skin]);
  elseif SkinType=="Dis" then
    HealBot_UseColourPick(HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin],
                          HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin],
                          HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin],
                          HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin])
  elseif SkinType=="Debuff" then
    HealBot_UseColourPick(HealBot_Config.btextcursecolr[HealBot_Config.Current_Skin],
                          HealBot_Config.btextcursecolg[HealBot_Config.Current_Skin],
                          HealBot_Config.btextcursecolb[HealBot_Config.Current_Skin],
                          HealBot_Config.btextcursecola[HealBot_Config.Current_Skin])
  elseif SkinType=="Back" then
    HealBot_UseColourPick(HealBot_Config.backcolr[HealBot_Config.Current_Skin],
                          HealBot_Config.backcolg[HealBot_Config.Current_Skin],
                          HealBot_Config.backcolb[HealBot_Config.Current_Skin],
                          HealBot_Config.backcola[HealBot_Config.Current_Skin])
  elseif SkinType=="Bor" then
    HealBot_UseColourPick(HealBot_Config.borcolr[HealBot_Config.Current_Skin],
                          HealBot_Config.borcolg[HealBot_Config.Current_Skin],
                          HealBot_Config.borcolb[HealBot_Config.Current_Skin],
                          HealBot_Config.borcola[HealBot_Config.Current_Skin])
  elseif SkinType=="Abort" then
    HealBot_UseColourPick(HealBot_Config.babortcolr[HealBot_Config.Current_Skin],
                          HealBot_Config.babortcolg[HealBot_Config.Current_Skin],
                          HealBot_Config.babortcolb[HealBot_Config.Current_Skin],
                          HealBot_Config.babortcola[HealBot_Config.Current_Skin])
  end
end

function HealBot_SetSkinColours()
  local btextheight=HealBot_Config.btextheight[HealBot_Config.Current_Skin] or 10;
  
  HealBot_EnTextColorpick:SetStatusBarColor(0,1,0,HealBot_Config.Barcola[HealBot_Config.Current_Skin]);
  HealBot_EnTextColorpickin:SetStatusBarColor(0,1,0,HealBot_Config.Barcola[HealBot_Config.Current_Skin]*HealBot_Config.BarcolaInHeal[HealBot_Config.Current_Skin]);
  HealBot_DisTextColorpick:SetStatusBarColor(0,1,0,HealBot_Config.bardisa[HealBot_Config.Current_Skin]);
  HealBot_EnTextColorpickt:SetTextColor(
    HealBot_Config.btextenabledcolr[HealBot_Config.Current_Skin],
    HealBot_Config.btextenabledcolg[HealBot_Config.Current_Skin],
    HealBot_Config.btextenabledcolb[HealBot_Config.Current_Skin],
    HealBot_Config.btextenabledcola[HealBot_Config.Current_Skin]);
  HealBot_DisTextColorpickt:SetTextColor(
    HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin],
    HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin],
    HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin],
    HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin]);
  HealBot_DebTextColorpickt:SetTextColor(
    HealBot_Config.btextcursecolr[HealBot_Config.Current_Skin],
    HealBot_Config.btextcursecolg[HealBot_Config.Current_Skin],
    HealBot_Config.btextcursecolb[HealBot_Config.Current_Skin],
    HealBot_Config.btextcursecola[HealBot_Config.Current_Skin]);
  HealBot_BackgroundColorpick:SetStatusBarColor(
    HealBot_Config.backcolr[HealBot_Config.Current_Skin],
    HealBot_Config.backcolg[HealBot_Config.Current_Skin],
    HealBot_Config.backcolb[HealBot_Config.Current_Skin],
    HealBot_Config.backcola[HealBot_Config.Current_Skin]);
  HealBot_BorderColorpick:SetStatusBarColor(
    HealBot_Config.borcolr[HealBot_Config.Current_Skin],
    HealBot_Config.borcolg[HealBot_Config.Current_Skin],
    HealBot_Config.borcolb[HealBot_Config.Current_Skin],
    HealBot_Config.borcola[HealBot_Config.Current_Skin]);
  HealBot_AbortColorpick:SetStatusBarColor(
    HealBot_Config.babortcolr[HealBot_Config.Current_Skin],
    HealBot_Config.babortcolg[HealBot_Config.Current_Skin],
    HealBot_Config.babortcolb[HealBot_Config.Current_Skin],
    HealBot_Config.babortcola[HealBot_Config.Current_Skin]);

  HealBot_Action:SetBackdropColor(
    HealBot_Config.backcolr[HealBot_Config.Current_Skin],
    HealBot_Config.backcolg[HealBot_Config.Current_Skin],
    HealBot_Config.backcolb[HealBot_Config.Current_Skin], 
    HealBot_Config.backcola[HealBot_Config.Current_Skin]);
  HealBot_Action:SetBackdropBorderColor(
    HealBot_Config.borcolr[HealBot_Config.Current_Skin],
    HealBot_Config.borcolg[HealBot_Config.Current_Skin],
    HealBot_Config.borcolb[HealBot_Config.Current_Skin],
    HealBot_Config.borcola[HealBot_Config.Current_Skin]);

    HealBot_EnTextColorpickt:SetTextHeight(btextheight);
    HealBot_DisTextColorpickt:SetTextHeight(btextheight);
    HealBot_DebTextColorpickt:SetTextHeight(btextheight);
    HealBot_EnTextColorpickt:SetText(HEALBOT_SKIN_ENTEXT);
    HealBot_DisTextColorpickt:SetText(HEALBOT_SKIN_DISTEXT);
    HealBot_DebTextColorpickt:SetText(HEALBOT_SKIN_DEBTEXT);
    local barScale = HealBot_EnTextColorpick:GetScale();
    HealBot_EnTextColorpick:SetScale(barScale + 0.01);
    HealBot_EnTextColorpick:SetScale(barScale);
    HealBot_DisTextColorpick:SetScale(barScale + 0.01);
    HealBot_DisTextColorpick:SetScale(barScale);
    HealBot_DebTextColorpick:SetScale(barScale + 0.01);
    HealBot_DebTextColorpick:SetScale(barScale);
   
  HealBot_Action_PartyChanged()
end

function HealBot_Options_AlertLevel_OnValueChanged(this)
  HealBot_Config.AlertLevel = HealBot_Options_Pct_OnValueChanged(this);
  HealBot_Action_Refresh();
end


function HealBot_Options_AutoShow_OnLoad(this)
  getglobal(this:GetName().."Text"):SetText(HEALBOT_OPTIONS_AUTOSHOW);
end

function HealBot_Options_AutoShow_OnClick(this)
  HealBot_Config.AutoClose = this:GetChecked() or 0;
  HealBot_Action_Refresh();
end

function HealBot_Options_ShowClassOnBar_OnLoad(this)
  getglobal(this:GetName().."Text"):SetText(HEALBOT_OPTIONS_SHOWCLASSONBAR);
end

function HealBot_Options_ShowClassOnBar_OnClick(this)
  HealBot_Config.ShowClassOnBar = this:GetChecked() or 0;
  if HealBot_Config.ShowClassOnBar==0 then
    HealBot_Options_ShowClassOnBarWithName:Disable();
  else
    HealBot_Options_ShowClassOnBarWithName:Enable();
  end
  HealBot_Action_Refresh();
end

function HealBot_Options_ShowClassOnBarWithName_OnLoad(this)
  getglobal(this:GetName().."Text"):SetText(HEALBOT_OPTIONS_SHOWCLASSNAME);
end

function HealBot_Options_ShowClassOnBarWithName_OnClick(this)
  HealBot_Config.ShowClassOnBarWithName = this:GetChecked() or 0;
  HealBot_Action_Refresh();
end

function HealBot_Options_PanelSounds_OnLoad(this)
  getglobal(this:GetName().."Text"):SetText(HEALBOT_OPTIONS_PANELSOUNDS);
end

function HealBot_Options_PanelSounds_OnClick(this)
  HealBot_Config.PanelSounds = this:GetChecked() or 0;
end


function HealBot_Options_ActionLocked_OnLoad(this)
  getglobal(this:GetName().."Text"):SetText(HEALBOT_OPTIONS_ACTIONLOCKED);
end

function HealBot_Options_ActionLocked_OnClick(this)
  HealBot_Config.ActionLocked = this:GetChecked() or 0;
end


function HealBot_Options_GroupHeals_OnLoad(this,text)
  this.text = text
  getglobal(this:GetName().."Text"):SetText(this.text);
end


function HealBot_Options_GroupHeals_OnClick(this)
  HealBot_Config.GroupHeals = this:GetChecked() or 0;
  HealBot_RecalcParty();
end


function HealBot_Options_TankHeals_OnLoad(this,text)
  this.text = text
  getglobal(this:GetName().."Text"):SetText(this.text);
end

function HealBot_Options_TankHeals_OnClick(this)
  HealBot_Config.TankHeals = this:GetChecked() or 0;
  HealBot_RecalcParty();
end


function HealBot_Options_TargetHeals_OnLoad(this,text)
  this.text = text
  getglobal(this:GetName().."Text"):SetText(this.text);
end

function HealBot_Options_TargetHeals_OnClick(this)
  HealBot_Config.TargetHeals = this:GetChecked() or 0;
  HealBot_RecalcParty();
end


function HealBot_Options_EmergencyHeals_OnLoad(this,text)
  this.text = text
  getglobal(this:GetName().."Text"):SetText(this.text);
end

function HealBot_Options_EmergencyHeals_OnClick(this)
  HealBot_Config.EmergencyHeals = this:GetChecked() or 0;
  HealBot_RecalcParty();
end

function HealBot_Options_OverHeal_OnValueChanged(this)
  HealBot_Config.OverHeal = HealBot_Options_Pct_OnValueChanged(this);
end

function HealBot_Options_EFGroup_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_EFGroup_OnClick(this,id)
  if this:GetChecked() then
    HealBot_Config.ExtraIncGroup[id] = true;
  else
    HealBot_Config.ExtraIncGroup[id] = false;
  end
  HealBot_RecalcParty();
end

function HealBot_Options_EFClass_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_EFClass_OnClick(this)
    if HealBot_Config.EmergencyFClass==1 then
      HealBot_Config.EmergIncMelee[HEALBOT_DRUID] = HealBot_Options_EFClassDruid:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_HUNTER] = HealBot_Options_EFClassHunter:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_MAGE] = HealBot_Options_EFClassMage:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_PALADIN] = HealBot_Options_EFClassPaladin:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_PRIEST] = HealBot_Options_EFClassPriest:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_ROGUE] = HealBot_Options_EFClassRogue:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_SHAMAN] = HealBot_Options_EFClassShaman:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_WARLOCK] = HealBot_Options_EFClassWarlock:GetChecked() or 0;
      HealBot_Config.EmergIncMelee[HEALBOT_WARRIOR] = HealBot_Options_EFClassWarrior:GetChecked() or 0;
    elseif HealBot_Config.EmergencyFClass==2 then
      HealBot_Config.EmergIncRange[HEALBOT_DRUID] = HealBot_Options_EFClassDruid:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_HUNTER] = HealBot_Options_EFClassHunter:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_MAGE] = HealBot_Options_EFClassMage:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_PALADIN] = HealBot_Options_EFClassPaladin:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_PRIEST] = HealBot_Options_EFClassPriest:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_ROGUE] = HealBot_Options_EFClassRogue:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_SHAMAN] = HealBot_Options_EFClassShaman:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_WARLOCK] = HealBot_Options_EFClassWarlock:GetChecked() or 0;
      HealBot_Config.EmergIncRange[HEALBOT_WARRIOR] = HealBot_Options_EFClassWarrior:GetChecked() or 0;
    elseif HealBot_Config.EmergencyFClass==3 then
      HealBot_Config.EmergIncHealers[HEALBOT_DRUID] = HealBot_Options_EFClassDruid:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_HUNTER] = HealBot_Options_EFClassHunter:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_MAGE] = HealBot_Options_EFClassMage:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_PALADIN] = HealBot_Options_EFClassPaladin:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_PRIEST] = HealBot_Options_EFClassPriest:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_ROGUE] = HealBot_Options_EFClassRogue:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_SHAMAN] = HealBot_Options_EFClassShaman:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_WARLOCK] = HealBot_Options_EFClassWarlock:GetChecked() or 0;
      HealBot_Config.EmergIncHealers[HEALBOT_WARRIOR] = HealBot_Options_EFClassWarrior:GetChecked() or 0;
    elseif HealBot_Config.EmergencyFClass==4 then
      HealBot_Config.EmergIncCustom[HEALBOT_DRUID] = HealBot_Options_EFClassDruid:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_HUNTER] = HealBot_Options_EFClassHunter:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_MAGE] = HealBot_Options_EFClassMage:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_PALADIN] = HealBot_Options_EFClassPaladin:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_PRIEST] = HealBot_Options_EFClassPriest:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_ROGUE] = HealBot_Options_EFClassRogue:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_SHAMAN] = HealBot_Options_EFClassShaman:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_WARLOCK] = HealBot_Options_EFClassWarlock:GetChecked() or 0;
      HealBot_Config.EmergIncCustom[HEALBOT_WARRIOR] = HealBot_Options_EFClassWarrior:GetChecked() or 0;
    end
  if HealBot_Config.EmergIncMonitor>10 then
     HealBot_Action_PartyChanged();
  end
end


function HealBot_Options_CastNotify_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_CastNotify_OnClick(this,id)
  if HealBot_Config.CastNotify>0 then
    getglobal("HealBot_Options_CastNotify"..HealBot_Config.CastNotify):SetChecked(nil);
  end
  HealBot_Config.CastNotify = id;
  if HealBot_Config.CastNotify>0 then
    getglobal("HealBot_Options_CastNotify"..HealBot_Config.CastNotify):SetChecked(1);
  end
end

function HealBot_ComboButtons_Button_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_ComboButtons_Button_OnClick(this,id)
  if HealBot_Options_ComboButtons_Button>0 then
    getglobal("HealBot_ComboButtons_Button"..HealBot_Options_ComboButtons_Button):SetChecked(nil);
  end
  HealBot_Options_ComboButtons_Button = id;
  if HealBot_Options_ComboButtons_Button>0 then
    getglobal("HealBot_ComboButtons_Button"..HealBot_Options_ComboButtons_Button):SetChecked(1);
  end
  HealBot_Options_ComboClass_Text()
end

function HealBot_DisComboButtons_Button_OnClick(this,id)
  if HealBot_Options_DisComboButtons_Button>0 then
    getglobal("HealBot_ComboDisButtons_Button"..HealBot_Options_DisComboButtons_Button):SetChecked(nil);
  end
  HealBot_Options_DisComboButtons_Button = id;
  if HealBot_Options_DisComboButtons_Button>0 then
    getglobal("HealBot_ComboDisButtons_Button"..HealBot_Options_DisComboButtons_Button):SetChecked(1);
  end
  HealBot_Options_DisComboClass_Text()
end


function HealBot_Options_HideOptions_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_HideOptions_OnClick(this)
  HealBot_Config.HideOptions = this:GetChecked() or 0;
  HealBot_Action_PartyChanged();
end

function HealBot_Options_HideAbort_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_HideAbort_OnClick(this)
  HealBot_Config.HideAbort = this:GetChecked() or 0;
  HealBot_Action_PartyChanged();
end

function HealBot_Options_ShowTooltip_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_ShowTooltip_OnClick(this)
  HealBot_Config.ShowTooltip = this:GetChecked() or 0;
end

function HealBot_Options_ShowTooltipTarget_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_ShowTooltipTarget_OnClick(this)
  HealBot_Config.Tooltip_ShowTarget = this:GetChecked() or 0;
end

function HealBot_Options_ShowTooltipSpellDetail_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_ShowTooltipSpellDetail_OnClick(this)
  HealBot_Config.Tooltip_ShowSpellDetail = this:GetChecked() or 0;
end

function HealBot_Options_ShowTooltipInstant_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_ShowTooltipInstant_OnClick(this)
  HealBot_Config.Tooltip_Recommend = this:GetChecked() or 0;
end

function HealBot_Options_ShowDebuffWarning_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_ShowDebuffWarning_OnClick(this)
  HealBot_Config.ShowDebuffWarning = this:GetChecked() or 0;
end

function HealBot_Options_SoundDebuffWarning_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_SoundDebuffWarning_OnClick(this)
  HealBot_Config.SoundDebuffWarning = this:GetChecked() or 0;
  if HealBot_Config.SoundDebuffWarning==0 then
    HealBot_WarningSound1:Disable();
    HealBot_WarningSound2:Disable();
    HealBot_WarningSound3:Disable();
  else
    HealBot_WarningSound1:Enable();
    HealBot_WarningSound2:Enable();
    HealBot_WarningSound3:Enable();
  end
end

function HealBot_WarningSound_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_WarningSound_OnClick(this,id)
  if HealBot_Config.SoundDebuffPlay>0 then
    getglobal("HealBot_WarningSound"..HealBot_Config.SoundDebuffPlay):SetChecked(nil);
  end
  HealBot_Config.SoundDebuffPlay = id;
  if HealBot_Config.SoundDebuffPlay>0 then
    getglobal("HealBot_WarningSound"..HealBot_Config.SoundDebuffPlay):SetChecked(1);
    if this then
      HealBot_PlaySound(HealBot_Config.SoundDebuffPlay)
    end
  end
end

function HealBot_Options_BarTextInClassColour_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_BarTextInClassColour_OnClick(this)
  HealBot_Config.SetClassColourText = this:GetChecked() or 0;
  HealBot_Action_PartyChanged();
end

function HealBot_Options_ShowHealthOnBar_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_ShowHealthOnBar_OnClick(this)
  HealBot_Config.ShowHealthOnBar = this:GetChecked() or 0;
  if HealBot_Config.ShowHealthOnBar==0 then
    HealBot_BarHealthType1:Disable();
    HealBot_BarHealthType2:Disable();
  else
    HealBot_BarHealthType1:Enable();
    HealBot_BarHealthType2:Enable();
  end
  HealBot_Action_PartyChanged();
end

function HealBot_BarHealthType_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_BarHealthType_OnClick(this,id)
  if HealBot_Config.ShowHealthOnBar>0 then
    getglobal("HealBot_BarHealthType"..HealBot_Config.BarHealthType):SetChecked(nil);
  end
  HealBot_Config.BarHealthType = id;
  if HealBot_Config.BarHealthType>0 then
    getglobal("HealBot_BarHealthType"..HealBot_Config.BarHealthType):SetChecked(1);
    HealBot_Action_PartyChanged();
  end
end

function HealBot_Options_GrowUpwards_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_GrowUpwards_OnClick(this)
  HealBot_Config.GrowUpwards = this:GetChecked() or 0;
  HealBot_Action_PartyChanged();
end


function HealBot_Options_QualityRange_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_QualityRange_OnClick(this)
  HealBot_Config.QualityRange = this:GetChecked() or 0;
  HealBot_Action_PartyChanged();
end

function HealBot_Options_ProtectPvP_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_ProtectPvP_OnClick(this)
  HealBot_Config.ProtectPvP = this:GetChecked() or 0;
  HealBot_Action_Refresh();
end

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

local HealBot_Options_EmergencyFClass_List = {
  HEALBOT_CLASSES_MELEE,
  HEALBOT_CLASSES_RANGES,
  HEALBOT_CLASSES_HEALERS,
  HEALBOT_CLASSES_CUSTOM,
}

function HealBot_Options_EmergencyFClass_DropDown()
  for i=1, getn(HealBot_Options_EmergencyFClass_List), 1 do
    local info = {};
    info.text = HealBot_Options_EmergencyFClass_List[i];
    info.func = HealBot_Options_EmergencyFClass_OnSelect;
    UIDropDownMenu_AddButton(info);
  end
end

function HealBot_Options_EmergencyFClass_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_EmergencyFClass,HealBot_Options_EmergencyFClass_DropDown)
end

function HealBot_Options_EmergencyFClass_Refresh(onselect)
  if not HealBot_Config.EmergencyFClass then return end
  if not onselect then HealBot_Options_EmergencyFClass_Initialize() end  -- or wrong menu may be used !
  UIDropDownMenu_SetSelectedID(HealBot_Options_EmergencyFClass,HealBot_Config.EmergencyFClass)
end

function HealBot_Options_EmergencyFClass_OnLoad(this)
  HealBot_Options_EmergencyFClass_Initialize()
  UIDropDownMenu_SetWidth(110)
end

function HealBot_Options_EmergencyFClass_OnSelect()
  HealBot_Config.EmergencyFClass = this:GetID()
  HealBot_Options_EmergencyFClass_Refresh(true)
  HealBot_Options_EFClass_Reset()
end

function HealBot_Options_EFClass_Reset()
  if HealBot_Config.EmergencyFClass==1 then
    HealBot_Options_EFClassDruid:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_DRUID]);
    HealBot_Options_EFClassHunter:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_HUNTER]);
    HealBot_Options_EFClassMage:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_MAGE]);
    HealBot_Options_EFClassPaladin:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_PALADIN]);
    HealBot_Options_EFClassPriest:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_PRIEST]);
    HealBot_Options_EFClassRogue:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_ROGUE]);
    HealBot_Options_EFClassShaman:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_SHAMAN]);
    HealBot_Options_EFClassWarlock:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_WARLOCK]);
    HealBot_Options_EFClassWarrior:SetChecked(HealBot_Config.EmergIncMelee[HEALBOT_WARRIOR]);
  elseif HealBot_Config.EmergencyFClass==2 then
    HealBot_Options_EFClassDruid:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_DRUID]);
    HealBot_Options_EFClassHunter:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_HUNTER]);
    HealBot_Options_EFClassMage:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_MAGE]);
    HealBot_Options_EFClassPaladin:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_PALADIN]);
    HealBot_Options_EFClassPriest:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_PRIEST]);
    HealBot_Options_EFClassRogue:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_ROGUE]);
    HealBot_Options_EFClassShaman:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_SHAMAN]);
    HealBot_Options_EFClassWarlock:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_WARLOCK]);
    HealBot_Options_EFClassWarrior:SetChecked(HealBot_Config.EmergIncRange[HEALBOT_WARRIOR]);
  elseif HealBot_Config.EmergencyFClass==3 then
    HealBot_Options_EFClassDruid:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_DRUID]);
    HealBot_Options_EFClassHunter:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_HUNTER]);
    HealBot_Options_EFClassMage:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_MAGE]);
    HealBot_Options_EFClassPaladin:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_PALADIN]);
    HealBot_Options_EFClassPriest:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_PRIEST]);
    HealBot_Options_EFClassRogue:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_ROGUE]);
    HealBot_Options_EFClassShaman:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_SHAMAN]);
    HealBot_Options_EFClassWarlock:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_WARLOCK]);
    HealBot_Options_EFClassWarrior:SetChecked(HealBot_Config.EmergIncHealers[HEALBOT_WARRIOR]);
  elseif HealBot_Config.EmergencyFClass==4 then
    HealBot_Options_EFClassDruid:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_DRUID]);
    HealBot_Options_EFClassHunter:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_HUNTER]);
    HealBot_Options_EFClassMage:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_MAGE]);
    HealBot_Options_EFClassPaladin:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_PALADIN]);
    HealBot_Options_EFClassPriest:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_PRIEST]);
    HealBot_Options_EFClassRogue:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_ROGUE]);
    HealBot_Options_EFClassShaman:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_SHAMAN]);
    HealBot_Options_EFClassWarlock:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_WARLOCK]);
    HealBot_Options_EFClassWarrior:SetChecked(HealBot_Config.EmergIncCustom[HEALBOT_WARRIOR]);
  end
end

--------------------------------------------------------------------------------

local HealBot_Options_ExtraSort_List = {
  HEALBOT_SORTBY_NAME,
  HEALBOT_SORTBY_CLASS,
  HEALBOT_SORTBY_GROUP,
  HEALBOT_SORTBY_MAXHEALTH,
}

function HealBot_Options_ExtraSort_DropDown()
  for i=1, getn(HealBot_Options_ExtraSort_List), 1 do
    local info = {};
    info.text = HealBot_Options_ExtraSort_List[i];
    info.func = HealBot_Options_ExtraSort_OnSelect;
    UIDropDownMenu_AddButton(info);
  end
end

function HealBot_Options_ExtraSort_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_ExtraSort,HealBot_Options_ExtraSort_DropDown)
end

function HealBot_Options_ExtraSort_Refresh(onselect)
  if not HealBot_Config.ExtraOrder then return end
  if not onselect then HealBot_Options_ExtraSort_Initialize() end  -- or wrong menu may be used !
  UIDropDownMenu_SetSelectedID(HealBot_Options_ExtraSort,HealBot_Config.ExtraOrder)
end

function HealBot_Options_ExtraSort_OnLoad(this)
  HealBot_Options_ExtraSort_Initialize()
  UIDropDownMenu_SetWidth(110)
end

function HealBot_Options_ExtraSort_OnSelect()
  HealBot_Config.ExtraOrder = this:GetID()
  HealBot_Options_ExtraSort_Refresh(true)
  HealBot_Action_PartyChanged()
end

--------------------------------------------------------------------------------

local HealBot_Options_EmergencyFilter_List = {
  HEALBOT_CLASSES_ALL,
  HEALBOT_DRUID,
  HEALBOT_HUNTER,
  HEALBOT_MAGE,
  HEALBOT_PALADIN,
  HEALBOT_PRIEST,
  HEALBOT_ROGUE,
  HEALBOT_SHAMAN,
  HEALBOT_WARLOCK,
  HEALBOT_WARRIOR,
  HEALBOT_CLASSES_MELEE,
  HEALBOT_CLASSES_RANGES,
  HEALBOT_CLASSES_HEALERS,
  HEALBOT_CLASSES_CUSTOM,
}

function HealBot_Options_EmergencyFilter_DropDown()
  for i=1, getn(HealBot_Options_EmergencyFilter_List), 1 do
    local info = {};
    info.text = HealBot_Options_EmergencyFilter_List[i];
    info.func = HealBot_Options_EmergencyFilter_OnSelect;
    UIDropDownMenu_AddButton(info);
  end
end

function HealBot_Options_CDCMonitor_DropDown()
  for i=1, getn(HealBot_Options_EmergencyFilter_List), 1 do
    local info = {};
    info.text = HealBot_Options_EmergencyFilter_List[i];
    info.func = HealBot_Options_CDCMonitor_OnSelect;
    UIDropDownMenu_AddButton(info);
  end
end

function HealBot_Options_EmergencyFilter_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_EmergencyFilter,HealBot_Options_EmergencyFilter_DropDown)
end

function HealBot_Options_CDCMonitor_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_CDCMonitor,HealBot_Options_CDCMonitor_DropDown)
end

function HealBot_Options_EmergencyFilter_Refresh(onselect)
  if not HealBot_Config.EmergIncMonitor then return end
  if not onselect then HealBot_Options_EmergencyFilter_Initialize() end  -- or wrong menu may be used !
  UIDropDownMenu_SetSelectedID(HealBot_Options_EmergencyFilter,HealBot_Config.EmergIncMonitor)
end

function HealBot_Options_CDCMonitor_Refresh(onselect)
  if not HealBot_Config.CDCMonitor then return end
  if not onselect then HealBot_Options_CDCMonitor_Initialize() end  -- or wrong menu may be used !
  UIDropDownMenu_SetSelectedID(HealBot_Options_CDCMonitor,HealBot_Config.CDCMonitor)
end

function HealBot_Options_EmergencyFilter_OnLoad(this)
  HealBot_Options_EmergencyFilter_Initialize()
  UIDropDownMenu_SetWidth(110)
end

function HealBot_Options_CDCMonitor_OnLoad(this)
  HealBot_Options_CDCMonitor_Initialize()
  UIDropDownMenu_SetWidth(100)
end

function HealBot_Options_EmergencyFilter_OnSelect()
  HealBot_Config.EmergIncMonitor = this:GetID()
  HealBot_Options_EmergencyFilter_Refresh(true)
  HealBot_Options_EmergencyFilter_Reset()
end

function HealBot_Options_EmergencyFilter_Reset()
  
  HealBot_EmergInc[HEALBOT_DRUID] = 0;
  HealBot_EmergInc[HEALBOT_HUNTER] = 0;
  HealBot_EmergInc[HEALBOT_MAGE] = 0;
  HealBot_EmergInc[HEALBOT_PALADIN] = 0;
  HealBot_EmergInc[HEALBOT_PRIEST] = 0;
  HealBot_EmergInc[HEALBOT_ROGUE] = 0;
  HealBot_EmergInc[HEALBOT_SHAMAN] = 0;
  HealBot_EmergInc[HEALBOT_WARLOCK] = 0;
  HealBot_EmergInc[HEALBOT_WARRIOR] = 0;
  if HealBot_Config.EmergIncMonitor==1 then
    HealBot_EmergInc[HEALBOT_DRUID] = 1;
    HealBot_EmergInc[HEALBOT_HUNTER] = 1;
    HealBot_EmergInc[HEALBOT_MAGE] = 1;
    HealBot_EmergInc[HEALBOT_PALADIN] = 1;
    HealBot_EmergInc[HEALBOT_PRIEST] = 1;
    HealBot_EmergInc[HEALBOT_ROGUE] = 1;
    HealBot_EmergInc[HEALBOT_SHAMAN] = 1;
    HealBot_EmergInc[HEALBOT_WARLOCK] = 1;
    HealBot_EmergInc[HEALBOT_WARRIOR] = 1;
  elseif HealBot_Config.EmergIncMonitor==2 then
    HealBot_EmergInc[HEALBOT_DRUID] = 1;
  elseif HealBot_Config.EmergIncMonitor==3 then
    HealBot_EmergInc[HEALBOT_HUNTER] = 1;
  elseif HealBot_Config.EmergIncMonitor==4 then
    HealBot_EmergInc[HEALBOT_MAGE] = 1;
  elseif HealBot_Config.EmergIncMonitor==5 then
    HealBot_EmergInc[HEALBOT_PALADIN] = 1;
  elseif HealBot_Config.EmergIncMonitor==6 then
    HealBot_EmergInc[HEALBOT_PRIEST] = 1;
  elseif HealBot_Config.EmergIncMonitor==7 then
    HealBot_EmergInc[HEALBOT_ROGUE] = 1;
  elseif HealBot_Config.EmergIncMonitor==8 then
    HealBot_EmergInc[HEALBOT_SHAMAN] = 1;
  elseif HealBot_Config.EmergIncMonitor==9 then
    HealBot_EmergInc[HEALBOT_WARLOCK] = 1;
  elseif HealBot_Config.EmergIncMonitor==10 then
    HealBot_EmergInc[HEALBOT_WARRIOR] = 1;
  elseif HealBot_Config.EmergIncMonitor==11 then
    HealBot_EmergInc[HEALBOT_DRUID] = HealBot_Config.EmergIncMelee[HEALBOT_DRUID];
    HealBot_EmergInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncMelee[HEALBOT_HUNTER];
    HealBot_EmergInc[HEALBOT_MAGE] = HealBot_Config.EmergIncMelee[HEALBOT_MAGE];
    HealBot_EmergInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncMelee[HEALBOT_PALADIN];
    HealBot_EmergInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncMelee[HEALBOT_PRIEST];
    HealBot_EmergInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncMelee[HEALBOT_ROGUE];
    HealBot_EmergInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncMelee[HEALBOT_SHAMAN];
    HealBot_EmergInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncMelee[HEALBOT_WARLOCK];
    HealBot_EmergInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncMelee[HEALBOT_WARRIOR];
  elseif HealBot_Config.EmergIncMonitor==12 then
    HealBot_EmergInc[HEALBOT_DRUID] = HealBot_Config.EmergIncRange[HEALBOT_DRUID];
    HealBot_EmergInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncRange[HEALBOT_HUNTER];
    HealBot_EmergInc[HEALBOT_MAGE] = HealBot_Config.EmergIncRange[HEALBOT_MAGE];
    HealBot_EmergInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncRange[HEALBOT_PALADIN];
    HealBot_EmergInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncRange[HEALBOT_PRIEST];
    HealBot_EmergInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncRange[HEALBOT_ROGUE];
    HealBot_EmergInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncRange[HEALBOT_SHAMAN];
    HealBot_EmergInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncRange[HEALBOT_WARLOCK];
    HealBot_EmergInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncRange[HEALBOT_WARRIOR];
  elseif HealBot_Config.EmergIncMonitor==13 then
    HealBot_EmergInc[HEALBOT_DRUID] = HealBot_Config.EmergIncHealers[HEALBOT_DRUID];
    HealBot_EmergInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncHealers[HEALBOT_HUNTER];
    HealBot_EmergInc[HEALBOT_MAGE] = HealBot_Config.EmergIncHealers[HEALBOT_MAGE];
    HealBot_EmergInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncHealers[HEALBOT_PALADIN];
    HealBot_EmergInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncHealers[HEALBOT_PRIEST];
    HealBot_EmergInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncHealers[HEALBOT_ROGUE];
    HealBot_EmergInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncHealers[HEALBOT_SHAMAN];
    HealBot_EmergInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncHealers[HEALBOT_WARLOCK];
    HealBot_EmergInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncHealers[HEALBOT_WARRIOR];
  elseif HealBot_Config.EmergIncMonitor==14 then
    HealBot_EmergInc[HEALBOT_DRUID] = HealBot_Config.EmergIncCustom[HEALBOT_DRUID];
    HealBot_EmergInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncCustom[HEALBOT_HUNTER];
    HealBot_EmergInc[HEALBOT_MAGE] = HealBot_Config.EmergIncCustom[HEALBOT_MAGE];
    HealBot_EmergInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncCustom[HEALBOT_PALADIN];
    HealBot_EmergInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncCustom[HEALBOT_PRIEST];
    HealBot_EmergInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncCustom[HEALBOT_ROGUE];
    HealBot_EmergInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncCustom[HEALBOT_SHAMAN];
    HealBot_EmergInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncCustom[HEALBOT_WARLOCK];
    HealBot_EmergInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncCustom[HEALBOT_WARRIOR];
  end

  HealBot_Action_PartyChanged()
end

function HealBot_Options_CDCMonitor_OnSelect()
  HealBot_Config.CDCMonitor = this:GetID()
  HealBot_Options_CDCMonitor_Refresh(true)
  HealBot_Options_CDCMonitor_Reset()
end

function HealBot_Options_CDCMonitor_Reset()

  HealBot_CDCInc[HEALBOT_DRUID] = 0;
  HealBot_CDCInc[HEALBOT_HUNTER] = 0;
  HealBot_CDCInc[HEALBOT_MAGE] = 0;
  HealBot_CDCInc[HEALBOT_PALADIN] = 0;
  HealBot_CDCInc[HEALBOT_PRIEST] = 0;
  HealBot_CDCInc[HEALBOT_ROGUE] = 0;
  HealBot_CDCInc[HEALBOT_SHAMAN] = 0;
  HealBot_CDCInc[HEALBOT_WARLOCK] = 0;
  HealBot_CDCInc[HEALBOT_WARRIOR] = 0;
  if HealBot_Config.CDCMonitor==1 then
    HealBot_CDCInc[HEALBOT_DRUID] = 1;
    HealBot_CDCInc[HEALBOT_HUNTER] = 1;
    HealBot_CDCInc[HEALBOT_MAGE] = 1;
    HealBot_CDCInc[HEALBOT_PALADIN] = 1;
    HealBot_CDCInc[HEALBOT_PRIEST] = 1;
    HealBot_CDCInc[HEALBOT_ROGUE] = 1;
    HealBot_CDCInc[HEALBOT_SHAMAN] = 1;
    HealBot_CDCInc[HEALBOT_WARLOCK] = 1;
    HealBot_CDCInc[HEALBOT_WARRIOR] = 1;
  elseif HealBot_Config.CDCMonitor==2 then
    HealBot_CDCInc[HEALBOT_DRUID] = 1;
  elseif HealBot_Config.CDCMonitor==3 then
    HealBot_CDCInc[HEALBOT_HUNTER] = 1;
  elseif HealBot_Config.CDCMonitor==4 then
    HealBot_CDCInc[HEALBOT_MAGE] = 1;
  elseif HealBot_Config.CDCMonitor==5 then
    HealBot_CDCInc[HEALBOT_PALADIN] = 1;
  elseif HealBot_Config.CDCMonitor==6 then
    HealBot_CDCInc[HEALBOT_PRIEST] = 1;
  elseif HealBot_Config.CDCMonitor==7 then
    HealBot_CDCInc[HEALBOT_ROGUE] = 1;
  elseif HealBot_Config.CDCMonitor==8 then
    HealBot_CDCInc[HEALBOT_SHAMAN] = 1;
  elseif HealBot_Config.CDCMonitor==9 then
    HealBot_CDCInc[HEALBOT_WARLOCK] = 1;
  elseif HealBot_Config.CDCMonitor==10 then
    HealBot_CDCInc[HEALBOT_WARRIOR] = 1;
  elseif HealBot_Config.CDCMonitor==11 then
    HealBot_CDCInc[HEALBOT_DRUID] = HealBot_Config.EmergIncMelee[HEALBOT_DRUID];
    HealBot_CDCInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncMelee[HEALBOT_HUNTER];
    HealBot_CDCInc[HEALBOT_MAGE] = HealBot_Config.EmergIncMelee[HEALBOT_MAGE];
    HealBot_CDCInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncMelee[HEALBOT_PALADIN];
    HealBot_CDCInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncMelee[HEALBOT_PRIEST];
    HealBot_CDCInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncMelee[HEALBOT_ROGUE];
    HealBot_CDCInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncMelee[HEALBOT_SHAMAN];
    HealBot_CDCInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncMelee[HEALBOT_WARLOCK];
    HealBot_CDCInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncMelee[HEALBOT_WARRIOR];
  elseif HealBot_Config.CDCMonitor==12 then
    HealBot_CDCInc[HEALBOT_DRUID] = HealBot_Config.EmergIncRange[HEALBOT_DRUID];
    HealBot_CDCInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncRange[HEALBOT_HUNTER];
    HealBot_CDCInc[HEALBOT_MAGE] = HealBot_Config.EmergIncRange[HEALBOT_MAGE];
    HealBot_CDCInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncRange[HEALBOT_PALADIN];
    HealBot_CDCInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncRange[HEALBOT_PRIEST];
    HealBot_CDCInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncRange[HEALBOT_ROGUE];
    HealBot_CDCInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncRange[HEALBOT_SHAMAN];
    HealBot_CDCInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncRange[HEALBOT_WARLOCK];
    HealBot_CDCInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncRange[HEALBOT_WARRIOR];
  elseif HealBot_Config.CDCMonitor==13 then
    HealBot_CDCInc[HEALBOT_DRUID] = HealBot_Config.EmergIncHealers[HEALBOT_DRUID];
    HealBot_CDCInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncHealers[HEALBOT_HUNTER];
    HealBot_CDCInc[HEALBOT_MAGE] = HealBot_Config.EmergIncHealers[HEALBOT_MAGE];
    HealBot_CDCInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncHealers[HEALBOT_PALADIN];
    HealBot_CDCInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncHealers[HEALBOT_PRIEST];
    HealBot_CDCInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncHealers[HEALBOT_ROGUE];
    HealBot_CDCInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncHealers[HEALBOT_SHAMAN];
    HealBot_CDCInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncHealers[HEALBOT_WARLOCK];
    HealBot_CDCInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncHealers[HEALBOT_WARRIOR];
  elseif HealBot_Config.CDCMonitor==14 then
    HealBot_CDCInc[HEALBOT_DRUID] = HealBot_Config.EmergIncCustom[HEALBOT_DRUID];
    HealBot_CDCInc[HEALBOT_HUNTER] = HealBot_Config.EmergIncCustom[HEALBOT_HUNTER];
    HealBot_CDCInc[HEALBOT_MAGE] = HealBot_Config.EmergIncCustom[HEALBOT_MAGE];
    HealBot_CDCInc[HEALBOT_PALADIN] = HealBot_Config.EmergIncCustom[HEALBOT_PALADIN];
    HealBot_CDCInc[HEALBOT_PRIEST] = HealBot_Config.EmergIncCustom[HEALBOT_PRIEST];
    HealBot_CDCInc[HEALBOT_ROGUE] = HealBot_Config.EmergIncCustom[HEALBOT_ROGUE];
    HealBot_CDCInc[HEALBOT_SHAMAN] = HealBot_Config.EmergIncCustom[HEALBOT_SHAMAN];
    HealBot_CDCInc[HEALBOT_WARLOCK] = HealBot_Config.EmergIncCustom[HEALBOT_WARLOCK];
    HealBot_CDCInc[HEALBOT_WARRIOR] = HealBot_Config.EmergIncCustom[HEALBOT_WARRIOR];
  end

  HealBot_Action_PartyChanged()
end

--------------------------------------------------------------------------------

function HealBot_Options_Skins_DropDown()
  for i=1, getn(HealBot_Skins), 1 do
    local info = {};
    info.text = HealBot_Skins[i];
    info.func = HealBot_Options_Skins_OnSelect;
    UIDropDownMenu_AddButton(info);
  end
end

function HealBot_Options_Skins_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_Skins,HealBot_Options_Skins_DropDown)
end

function HealBot_Options_Skins_Refresh(onselect)
  if not HealBot_Config.Skin_ID then return end
  if not onselect then HealBot_Options_Skins_Initialize() end  -- or wrong menu may be used !
  UIDropDownMenu_SetSelectedID(HealBot_Options_Skins,HealBot_Config.Skin_ID)
end

function HealBot_Options_Skins_OnLoad(this)
  HealBot_Options_Skins_Initialize()
  UIDropDownMenu_SetWidth(100)
end

function HealBot_Options_Skins_OnSelect()
  HealBot_Config.Skin_ID = this:GetID()
  HealBot_Options_Skins_Refresh(true)
  if this:GetID()>=1 then
    HealBot_Config.Current_Skin = this:GetText()
    HealBot_Options_SetSkins()
  end
end

--------------------------------------------------------------------------------

local HealBot_Options_TooltipPos_List = {
  HEALBOT_TOOLTIP_POSDEFAULT,
  HEALBOT_TOOLTIP_POSLEFT,
  HEALBOT_TOOLTIP_POSRIGHT,
  HEALBOT_TOOLTIP_POSABOVE,
  HEALBOT_TOOLTIP_POSBELOW,
}

function HealBot_Options_TooltipPos_DropDown()
  for i=1, getn(HealBot_Options_TooltipPos_List), 1 do
    local info = {};
    info.text = HealBot_Options_TooltipPos_List[i];
    info.func = HealBot_Options_TooltipPos_OnSelect;
    UIDropDownMenu_AddButton(info);
  end
end

function HealBot_Options_TooltipPos_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_TooltipPos,HealBot_Options_TooltipPos_DropDown)
end

function HealBot_Options_TooltipPos_Refresh(onselect)
  if not HealBot_Config.TooltipPos then return end
  if not onselect then HealBot_Options_TooltipPos_Initialize() end  -- or wrong menu may be used !
  UIDropDownMenu_SetSelectedID(HealBot_Options_TooltipPos,HealBot_Config.TooltipPos)
end

function HealBot_Options_TooltipPos_OnLoad(this)
  HealBot_Options_TooltipPos_Initialize()
  UIDropDownMenu_SetWidth(128)
end

function HealBot_Options_TooltipPos_OnSelect()
  HealBot_Config.TooltipPos = this:GetID()
  HealBot_Options_TooltipPos_Refresh(true)
end

--------------------------------------------------------------------------------

local HealBot_Options_ComboClass_List = {
  HEALBOT_DRUID,
  HEALBOT_PALADIN,
  HEALBOT_PRIEST,
  HEALBOT_SHAMAN,
}

function HealBot_Options_GetDebuffSpells_List(class)
  local DebuffSpells = HealBot_Debuff_Spells[class];
  return DebuffSpells;
end

function HealBot_Options_CDCButLeft_DropDown()
  local classEN=HealBot_UnitClass("player")
  if classEN=="PRIEST" or classEN=="DRUID" or classEN=="PALADIN" or classEN=="SHAMAN" then
    local class=UnitClass("Player");
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(class)
    local info = {};
    info.text = HEALBOT_WORDS_NONE;
    info.func = HealBot_Options_CDCButLeft_OnSelect;
    UIDropDownMenu_AddButton(info);
    for i=1, getn(DebuffSpells_List), 1 do
      local spell=HealBot_GetSpellName(HealBot_GetSpellId(DebuffSpells_List[i]));
      if spell then
        local info = {};
        info.text = spell;
        info.func = HealBot_Options_CDCButLeft_OnSelect;
        UIDropDownMenu_AddButton(info);
      end
    end
  end
end

function HealBot_Options_CDCButRight_DropDown()
  local classEN=HealBot_UnitClass("player")
  if classEN=="PRIEST" or classEN=="DRUID" or classEN=="PALADIN" or classEN=="SHAMAN" then
    local class=UnitClass("Player");
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(class)
    local info = {};
    info.text = HEALBOT_WORDS_NONE;
    info.func = HealBot_Options_CDCButRight_OnSelect;
    UIDropDownMenu_AddButton(info);
    for i=1, getn(DebuffSpells_List), 1 do
      local spell=HealBot_GetSpellName(HealBot_GetSpellId(DebuffSpells_List[i]));
      if spell then
        local info = {};
        info.text = spell;
        info.func = HealBot_Options_CDCButRight_OnSelect;
        UIDropDownMenu_AddButton(info);
      end
    end
  end
end

function HealBot_Options_CDCButLeft_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_CDCButLeft,HealBot_Options_CDCButLeft_DropDown)
end

function HealBot_Options_CDCButRight_Initialize()
  UIDropDownMenu_Initialize(HealBot_Options_CDCButRight,HealBot_Options_CDCButRight_DropDown)
end

function HealBot_Options_CDCButLeft_Refresh(onselect)
  local set_id=1;
  local class=UnitClass("Player");
  if not onselect then HealBot_Options_CDCButLeft_Initialize() end 
  set_id = HealBot_Config.Debuff_Left[class];
  UIDropDownMenu_SetSelectedID(HealBot_Options_CDCButLeft,set_id)
end

function HealBot_Options_CDCButRight_Refresh(onselect)
  local set_id;
  local class=UnitClass("Player");
  if not onselect then HealBot_Options_CDCButRight_Initialize() end 
  set_id = HealBot_Config.Debuff_Right[class];
  UIDropDownMenu_SetSelectedID(HealBot_Options_CDCButRight,set_id)
end

function HealBot_Options_ComboClass_Text()
  local class=UnitClass("Player");
  local combo = HealBot_Config.KeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
  if combo then
    HealBot_Options_Click:SetText(combo[button] or "")
    HealBot_Options_Shift:SetText(combo["Shift"..button] or "")
    HealBot_Options_Ctrl:SetText(combo["Ctrl"..button] or "")
    HealBot_Options_ShiftCtrl:SetText(combo["ShiftCtrl"..button] or "")
  end
end

function HealBot_Options_DisComboClass_Text()
  local class=UnitClass("Player");
  local combo = HealBot_Config.DisKeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_DisComboButtons_Button)
  if combo then
    HealBot_Options_DisClick:SetText(combo[button] or "")
    HealBot_Options_DisAlt:SetText(combo["Alt"..button] or "")
  end
end

function HealBot_Options_CDCButLeft_OnLoad(this)
  HealBot_Options_CDCButLeft_Initialize()
  UIDropDownMenu_SetWidth(140)
end

function HealBot_Options_CDCButRight_OnLoad(this)
  HealBot_Options_CDCButRight_Initialize()
  UIDropDownMenu_SetWidth(140)
end

function HealBot_Options_CDCButLeft_OnSelect()
  local class=UnitClass("Player");
  HealBot_Config.Debuff_Left[class] = this:GetID();
  HealBot_Options_CDCButLeft_Refresh(true)
  HealBot_Config.CDCLeftText[class]=HealBot_Options_CDCButLeftText:GetText();
  if this:GetID()>1 then
    HealBot_Options_CDC_SetCombo(HealBot_Options_CDCButLeftText:GetText(), "Left", class)
  end    
  HealBot_DebuffPriority = HealBot_Debuff_Types[HealBot_Options_CDCButLeftText:GetText()];
  HealBot_Options_Debuff_Reset()
end

function HealBot_Options_CDCButRight_OnSelect()
  local class=UnitClass("Player");
  HealBot_Config.Debuff_Right[class] = this:GetID();
  HealBot_Options_CDCButRight_Refresh(true)
  HealBot_Config.CDCRightText[class]=HealBot_Options_CDCButRightText:GetText();
  if this:GetID()>1 then
    HealBot_Options_CDC_SetCombo(HealBot_Options_CDCButRightText:GetText(), "Right", class)
  end    
  HealBot_Options_Debuff_Reset()
end

function HealBot_Options_CDC_SetCombo(spell, button, class)
  local combo = HealBot_Config.KeyCombo[class]
  combo["Alt"..button] = spell
end

function HealBot_Options_ComboClass_Button(id)
  local button = "Left"
  if id==2 then button = "Middle"; end
  if id==3 then button = "Right"; end
  if id==4 then button = "Button4"; end
  if id==5 then button = "Button5"; end
  return button;
end


function HealBot_Options_Debuff_Reset()
  local classEN=HealBot_UnitClass("player")
  if classEN=="PRIEST" or classEN=="DRUID" or classEN=="PALADIN" or classEN=="SHAMAN" then
    local spell = HealBot_Config.CDCLeftText[UnitClass("player")];
    HealBot_DebuffWatch = {[HEALBOT_DISEASE_en]="NO", [HEALBOT_MAGIC_en]="NO", [HEALBOT_POISON_en]="NO", [HEALBOT_CURSE_en]="NO" }
    if spell ~= "None" then
      table.foreach(HealBot_Debuff_Types[spell], function (index,debuff)
        HealBot_DebuffWatch[debuff]="YES";
      end)
    end
    spell = HealBot_Config.CDCRightText[UnitClass("player")];
    if spell ~= "None" then
      table.foreach(HealBot_Debuff_Types[spell], function (index,debuff)
        HealBot_DebuffWatch[debuff]="YES";
      end)
    end
  end
end

function HealBot_Colorpick_OnClick(CDCType)
  HealBot_ColourObjWaiting=CDCType;
  HealBot_UseColourPick(HealBot_Config.CDCBarColour[CDCType].R,HealBot_Config.CDCBarColour[CDCType].G,HealBot_Config.CDCBarColour[CDCType].B, nil)
end

function HealBot_Returned_Colours()
  local A = OpacitySliderFrame:GetValue();
  A = ((0-A)+1);
  if HealBot_ColourObjWaiting=="En" then
    HealBot_Config.btextenabledcolr[HealBot_Config.Current_Skin],
    HealBot_Config.btextenabledcolg[HealBot_Config.Current_Skin],
    HealBot_Config.btextenabledcolb[HealBot_Config.Current_Skin] = ColorPickerFrame:GetColorRGB();
    HealBot_Config.btextenabledcola[HealBot_Config.Current_Skin] = A;
  elseif HealBot_ColourObjWaiting=="Dis" then
    HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin],
    HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin],
    HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin] = ColorPickerFrame:GetColorRGB();
    HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin] = A;
  elseif HealBot_ColourObjWaiting=="Debuff" then
    HealBot_Config.btextcursecolr[HealBot_Config.Current_Skin],
    HealBot_Config.btextcursecolg[HealBot_Config.Current_Skin],
    HealBot_Config.btextcursecolb[HealBot_Config.Current_Skin] = ColorPickerFrame:GetColorRGB();
    HealBot_Config.btextcursecola[HealBot_Config.Current_Skin] = A;
  elseif HealBot_ColourObjWaiting=="Back" then
    HealBot_Config.backcolr[HealBot_Config.Current_Skin],
    HealBot_Config.backcolg[HealBot_Config.Current_Skin],
    HealBot_Config.backcolb[HealBot_Config.Current_Skin] = ColorPickerFrame:GetColorRGB();
    HealBot_Config.backcola[HealBot_Config.Current_Skin] = A;
  elseif HealBot_ColourObjWaiting=="Bor" then
    HealBot_Config.borcolr[HealBot_Config.Current_Skin],
    HealBot_Config.borcolg[HealBot_Config.Current_Skin],
    HealBot_Config.borcolb[HealBot_Config.Current_Skin] = ColorPickerFrame:GetColorRGB();
    HealBot_Config.borcola[HealBot_Config.Current_Skin] = A;
  elseif HealBot_ColourObjWaiting=="Abort" then
    HealBot_Config.babortcolr[HealBot_Config.Current_Skin],
    HealBot_Config.babortcolg[HealBot_Config.Current_Skin],
    HealBot_Config.babortcolb[HealBot_Config.Current_Skin] = ColorPickerFrame:GetColorRGB();
    HealBot_Config.babortcola[HealBot_Config.Current_Skin] = A;
  else
    HealBot_Config.CDCBarColour[HealBot_ColourObjWaiting].R,
    HealBot_Config.CDCBarColour[HealBot_ColourObjWaiting].G,
    HealBot_Config.CDCBarColour[HealBot_ColourObjWaiting].B = ColorPickerFrame:GetColorRGB();
  end
  HealBot_SetSkinColours()
  HealBot_SetCDCBarColours()
end
ColorPickerFrame.func = HealBot_Returned_Colours

function HealBot_UseColourPick(R, G, B, A)
  if ColorPickerFrame:IsVisible() then 
    ColorPickerFrame:Hide();
  elseif A then
    ColorPickerFrame.hasOpacity = true;
    ColorPickerFrame.opacity = A;
    ColorPickerFrame:ClearAllPoints();
    ColorPickerFrame:SetPoint("TOPLEFT","HealBot_Options","TOPRIGHT",0,-152);
    ColorPickerFrame:Show();
    OpacitySliderFrame:SetValue(1-A);
    ColorPickerFrame:SetColorRGB(R, G, B);
  else
    ColorPickerFrame.hasOpacity = false;
    ColorPickerFrame:ClearAllPoints();
    ColorPickerFrame:SetPoint("TOPLEFT","HealBot_Options","TOPRIGHT",0,-152);
    ColorPickerFrame:Show();
    ColorPickerFrame:SetColorRGB(R, G, B);
  end
  return ColorPickerFrame:GetColorRGB();
end



function HealBot_SetCDCBarColours()
  HealBot_DiseaseColorpick:SetStatusBarColor(HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].R,
                                             HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].G,
                                             HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].B,
                                             HealBot_Config.Barcola[HealBot_Config.Current_Skin]);
  HealBot_MagicColorpick:SetStatusBarColor(HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].R,
                                           HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].G,
                                           HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].B,
                                           HealBot_Config.Barcola[HealBot_Config.Current_Skin]);
  HealBot_PoisonColorpick:SetStatusBarColor(HealBot_Config.CDCBarColour[HEALBOT_POISON_en].R,
                                            HealBot_Config.CDCBarColour[HEALBOT_POISON_en].G,
                                            HealBot_Config.CDCBarColour[HEALBOT_POISON_en].B,
                                            HealBot_Config.Barcola[HealBot_Config.Current_Skin]);
  HealBot_CurseColorpick:SetStatusBarColor(HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].R,
                                           HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].G,
                                           HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].B,
                                           HealBot_Config.Barcola[HealBot_Config.Current_Skin]);
  HealBot_DebTextColorpick:SetStatusBarColor(HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].R,
                                             HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].G,
                                             HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].B,
                                             HealBot_Config.Barcola[HealBot_Config.Current_Skin])
end

--------------------------------------------------------------------------------

function HealBot_Options_EditBox_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_Click_OnTextChanged(this)
  local class=UnitClass("Player");
  local combo = HealBot_Config.KeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
  combo[button] = this:GetText()
end

function HealBot_Options_Shift_OnTextChanged(this)
  local class=UnitClass("Player");
  local combo = HealBot_Config.KeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
  combo["Shift"..button] = this:GetText()
end

function HealBot_Options_Ctrl_OnTextChanged(this)
  local class=UnitClass("Player");
  local combo = HealBot_Config.KeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
  combo["Ctrl"..button] = this:GetText()
end

function HealBot_Options_ShiftCtrl_OnTextChanged(this)
  local class=UnitClass("Player");
  local combo = HealBot_Config.KeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
  combo["ShiftCtrl"..button] = this:GetText()
end

function HealBot_Options_DisClick_OnTextChanged(this)
  local class=UnitClass("Player");
  local combo = HealBot_Config.DisKeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_DisComboButtons_Button)
  combo[button] = this:GetText()
end

function HealBot_Options_DisAlt_OnTextChanged(this)
  local class=UnitClass("Player");
  local combo = HealBot_Config.DisKeyCombo[class]
  local button = HealBot_Options_ComboClass_Button(HealBot_Options_DisComboButtons_Button)
  combo["Alt"..button] = this:GetText()
end

function HealBot_Options_EnableHealthy_OnLoad(this,text)
  getglobal(this:GetName().."Text"):SetText(text);
end

function HealBot_Options_EnableHealthy_OnClick(this)
  HealBot_Config.EnableHealthy = this:GetChecked() or 0;
  HealBot_Action_EnableButtons();
end

--------------------------------------------------------------------------------

function HealBot_Options_Defaults_OnClick(this)
  HealBot_Options_CastNotify_OnClick(nil,0);
--  HealBot_Config = HealBot_ConfigDefaults;
  table.foreach(HealBot_ConfigDefaults, function (key,val)
    HealBot_Config[key] = val;
  end);
  HealBot_Options_OnShow(HealBot_Options);
  HealBot_RecalcSpells();
  HealBot_Action_Reset();
  HealBot_Config.ActionVisible = HealBot_Action:IsVisible();
end

function HealBot_Options_OnLoad(this)
  table.insert(UISpecialFrames,this:GetName());

  -- Tabs
  PanelTemplates_SetNumTabs(this,6);
  this.selectedTab = 1; 
  PanelTemplates_UpdateTabs(this);
  HealBot_Options_ShowPanel(this.selectedTab);
end

function HealBot_Options_OnShow(this)
  HealBot_Skins = HealBot_Config.Skins;
  HealBot_Options_SetSkins()
  HealBot_Options_ActionLocked:SetChecked(HealBot_Config.ActionLocked);
  HealBot_Options_AlertLevel:SetValue(HealBot_Config.AlertLevel);
  HealBot_Options_AutoShow:SetChecked(HealBot_Config.AutoClose);
  HealBot_Options_PanelSounds:SetChecked(HealBot_Config.PanelSounds);
  HealBot_Options_GroupHeals:SetChecked(HealBot_Config.GroupHeals);
  if CT_RA_MainTanks then
    HealBot_Options_TankHeals:SetChecked(HealBot_Config.TankHeals);
  else
    HealBot_Options_TankHeals:Disable();
    HealBot_Options_TankHealsText:SetTextColor(0.6,0.6,0.6,0.75);
  end
  HealBot_Options_TargetHeals:SetChecked(HealBot_Config.TargetHeals);
  HealBot_Options_EmergencyHeals:SetChecked(HealBot_Config.EmergencyHeals);
  HealBot_Options_OverHeal:SetValue(HealBot_Config.OverHeal);
  HealBot_Options_CastNotify_OnClick(nil,HealBot_Config.CastNotify);
  HealBot_Options_HideOptions:SetChecked(HealBot_Config.HideOptions);
  HealBot_Options_ShowTooltip:SetChecked(HealBot_Config.ShowTooltip);
  HealBot_Options_GrowUpwards:SetChecked(HealBot_Config.GrowUpwards);
  HealBot_Options_ShowClassOnBar:SetChecked(HealBot_Config.ShowClassOnBar);
  HealBot_Options_ShowHealthOnBar:SetChecked(HealBot_Config.ShowHealthOnBar);
  HealBot_Options_QualityRange:SetChecked(HealBot_Config.QualityRange);
  HealBot_Options_ProtectPvP:SetChecked(HealBot_Config.ProtectPvP);
  HealBot_Options_SoundDebuffWarning:SetChecked(HealBot_Config.SoundDebuffWarning);
  HealBot_Options_ShowTooltipTarget:SetChecked(HealBot_Config.Tooltip_ShowTarget);
  HealBot_Options_ShowTooltipSpellDetail:SetChecked(HealBot_Config.Tooltip_ShowSpellDetail);
  HealBot_Options_ShowTooltipInstant:SetChecked(HealBot_Config.Tooltip_Recommend);
  HealBot_Options_ShowClassOnBarWithName:SetChecked(HealBot_Config.ShowClassOnBarWithName);
  HealBot_Options_BarTextInClassColour:SetChecked(HealBot_Config.SetClassColourText);
  HealBot_Options_HideAbort:SetChecked(HealBot_Config.HideAbort);
  HealBot_WarningSound_OnClick(nil,HealBot_Config.SoundDebuffPlay)
  if HealBot_Config.SoundDebuffWarning>0 then
    HealBot_WarningSound1:Enable();
    HealBot_WarningSound2:Enable();
    HealBot_WarningSound3:Enable();
  else
    HealBot_WarningSound1:Disable();
    HealBot_WarningSound2:Disable();
    HealBot_WarningSound3:Disable();
  end
  if HealBot_Config.ShowHealthOnBar>0 then
    HealBot_BarHealthType1:Enable();
    HealBot_BarHealthType2:Enable();
  else
    HealBot_BarHealthType1:Disable();
    HealBot_BarHealthType2:Disable();
  end
  HealBot_BarHealthType_OnClick(nil,HealBot_Config.BarHealthType)
  HealBot_Options_ShowDebuffWarning:SetChecked(HealBot_Config.ShowDebuffWarning);
  HealBot_Options_EmergencyFilter_Refresh()
  HealBot_Options_EmergencyFClass_Refresh();
  HealBot_Options_EFClass_Reset();
  HealBot_Options_CDCButLeft_Refresh()
  HealBot_Options_CDCButRight_Refresh()
  HealBot_SetCDCBarColours()
  HealBot_Options_CDCMonitor_Refresh()
  HealBot_ComboButtons_Button_OnClick(nil,HealBot_Options_ComboButtons_Button);
  HealBot_DisComboButtons_Button_OnClick(nil,HealBot_Options_DisComboButtons_Button);
  HealBot_Options_EnableHealthy:SetChecked(HealBot_Config.EnableHealthy);
  HealBot_Options_NewSkinb:Disable();
  HealBot_Options_ExtraSort_Refresh();
  HealBot_Options_TooltipPos_Refresh();
  HealBot_Options_SetEFGroups()
end

function HealBot_Options_SetEFGroups()
  for id=1,8 do
    if HealBot_Config.ExtraIncGroup[id] then 
      getglobal("HealBot_Options_EFGroup"..id):SetChecked(1)
    else
      getglobal("HealBot_Options_EFGroup"..id):SetChecked(nil)
    end
  end
end

function HealBot_Options_SetSkins()
  HealBot_Options_Skins_Refresh()
  HealBot_Options_BarAlpha:SetValue(HealBot_Config.Barcola[HealBot_Config.Current_Skin]);
  HealBot_Options_BarAlphaInHeal:SetValue(HealBot_Config.BarcolaInHeal[HealBot_Config.Current_Skin]);
  HealBot_Options_BarTextureS:SetValue(HealBot_Config.btexture[HealBot_Config.Current_Skin])
  HealBot_Options_BarHeightS:SetValue(HealBot_Config.bheight[HealBot_Config.Current_Skin])
  HealBot_Options_BarWidthS:SetValue(HealBot_Config.bwidth[HealBot_Config.Current_Skin])
  HealBot_Options_BarNumColsS:SetValue(HealBot_Config.numcols[HealBot_Config.Current_Skin])
  HealBot_Options_BarBRSpaceS:SetValue(HealBot_Config.brspace[HealBot_Config.Current_Skin])
  HealBot_Options_BarBCSpaceS:SetValue(HealBot_Config.bcspace[HealBot_Config.Current_Skin])
  HealBot_Options_FontHeight:SetValue(HealBot_Config.btextheight[HealBot_Config.Current_Skin])
  HealBot_Options_BarAlphaDis:SetValue(HealBot_Config.bardisa[HealBot_Config.Current_Skin])
  HealBot_Options_AbortBarSize:SetValue(HealBot_Config.abortsize[HealBot_Config.Current_Skin])
  HealBot_Options_ShowHeaders:SetChecked(HealBot_Config.ShowHeader[HealBot_Config.Current_Skin] or 0)
  HealBot_SetSkinColours()
  if HealBot_Config.Current_Skin==HEALBOT_SKINS_STD then
    HealBot_Options_DeleteSkin:Disable();
  else
    HealBot_Options_DeleteSkin:Enable();
  end
end

HealBot_Options_CurrentPanel = 0;

function HealBot_Options_ShowPanel(id)
  if HealBot_Options_CurrentPanel>0 then
    getglobal("HealBot_Options_Panel"..HealBot_Options_CurrentPanel):Hide();
  end
  HealBot_Options_CurrentPanel = id;
  if HealBot_Options_CurrentPanel>0 then
    getglobal("HealBot_Options_Panel"..HealBot_Options_CurrentPanel):Show();
  end
end
