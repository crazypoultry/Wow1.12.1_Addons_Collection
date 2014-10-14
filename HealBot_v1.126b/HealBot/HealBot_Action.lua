local headerno=0;

HealBot_Action_HealGroup = {
  "player",
  "pet",
  "party1",
  "party2",
  "party3",
  "party4",
};

HealBot_Action_HealTarget = {
};

HealBot_Action_HealButtons = {
};

HealBot_Action_UnitButtons = {
};

function HealBot_Action_AddDebug(msg)
  HealBot_AddDebug("Action: " .. msg);
end

function HealBot_HealthColor(unit,hlth,maxhlth)
  if HealBot_UnitDebuff[unit] then
    local debuff, tmp, debuff_type = UnitDebuff(unit,1, 1)
    if not debuff then
      HealBot_UnitDebuff[unit] = nil;
      HealBot_UnitDebuff[unit.."_debuff_texture"]=nil
    else
      return HealBot_Config.CDCBarColour[HealBot_UnitDebuff[unit]].R,
             HealBot_Config.CDCBarColour[HealBot_UnitDebuff[unit]].G,
             HealBot_Config.CDCBarColour[HealBot_UnitDebuff[unit]].B,
             HealBot_Config.Barcola[HealBot_Config.Current_Skin];
    end
  end
  local text = UnitName(unit);
  if not HealBot_HealsIn[text] then
    HealBot_HealsIn[text]=0;
  end
  
  local pct = hlth+HealBot_HealsIn[text];
  if pct<maxhlth then
   pct=pct/maxhlth;
  else
    pct=1;
  end
  
  local r,g,b = 1.0, 1.0, 0.0;
  local a=HealBot_Config.Barcola[HealBot_Config.Current_Skin];
  if pct>HealBot_Config.AlertLevel then
    a=HealBot_Config.bardisa[HealBot_Config.Current_Skin];
  end

  if pct>=0.98 then r = 0.0; end
  if pct<0.98 and pct>=0.65 then r=2.94-(pct*3); end 
  if pct<=0.64 and pct>0.31 then g=(pct-0.31)*3; end 
  if pct<=0.31 then g = 0.0; end
  return r,g,b,a;
end

function HealBot_Action_HealthBar(button)
  local name = button:GetName();
  return getglobal(name.."Bar");
end

function HealBot_Action_HealthBar2(button)
  local name = button:GetName();
  return getglobal(name.."Bar2");
end

function HealBot_AlwaysHeal()
  return HealBot_Config.EnableHealthy==1
end

function HealBot_MayHeal(unit)
  if not UnitName(unit) or not HealBot_Heals[unit] then return false end
  if unit ~= 'target' then return true end
  if not HealBot_Config.TargetHeals or UnitCanAttack("player",unit) then return false end
  return true;
end

function HealBot_ShouldHeal(unit)
  if HealBot_UnitDebuff[unit] and not UnitIsDeadOrGhost(unit) then
    if HealBot_Range_Check(unit, 30)==1 then
      return true;
    end
  end
  return HealBot_MayHeal(unit) and UnitHealth(unit)>0 and not UnitIsDeadOrGhost(unit)
    and (UnitHealth(unit)<UnitHealthMax(unit)*HealBot_Config.AlertLevel or HealBot_AlwaysHeal());
end

function HealBot_Action_ShouldHealSome()
  return table.foreach(HealBot_Action_HealButtons, function (index,button)
    if (HealBot_ShouldHeal(button.unit)) then return button.unit; end
  end);
end

function HealBot_MustHeal(unit)
  return HealBot_ShouldHeal(unit) and UnitHealth(unit)<UnitHealthMax(unit)*HealBot_Config.AlertLevel
end

function HealBot_Action_MustHealSome()
  return table.foreach(HealBot_Action_HealButtons, function (index,button)
    if (HealBot_MustHeal(button.unit)) then return button.unit; end
  end);
end

function HealBot_CanHeal(unit)
  local SHeal = HealBot_ShouldHeal(unit)
  if SHeal then
    local spell = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Left"))
    if not spell then spell = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Middle")) end
    if not spell then spell = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Right")) end
    if not spell then spell = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Button4")) end
    if not spell then spell = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Button5")) end
    if not spell then
      return false
    else
      return true
    end
  end
  return false
end

function HealBot_Action_EnableButton(button)
  local unit = button.unit;
  local hlth=UnitHealth(unit);
  local maxhlth=UnitHealthMax(unit);
  local name = UnitName(unit);
  local bar = HealBot_Action_HealthBar(button);
  local bar2 = HealBot_Action_HealthBar2(button);    
  local btexture=HealBot_Config.btexture[HealBot_Config.Current_Skin];
  local bheight=HealBot_Config.bheight[HealBot_Config.Current_Skin];
  local sr=HealBot_Config.btextenabledcolr[HealBot_Config.Current_Skin];
  local sg=HealBot_Config.btextenabledcolg[HealBot_Config.Current_Skin];
  local sb=HealBot_Config.btextenabledcolb[HealBot_Config.Current_Skin];
  local sa=HealBot_Config.btextenabledcola[HealBot_Config.Current_Skin];
  local r,g,b,a = HealBot_HealthColor(button.unit,hlth,maxhlth)
  local btextheight=HealBot_Config.btextheight[HealBot_Config.Current_Skin]
  local bwidth = HealBot_Config.bwidth[HealBot_Config.Current_Skin]
  local textlen = floor(5+(((bwidth*1.8)/btextheight)-(btextheight/2)))-2

  bar:SetMinMaxValues(0,maxhlth);
  bar:SetValue(hlth);
  if HealBot_HealsIn[name] then
    bar2:SetMinMaxValues(0,maxhlth);
    bar2:SetValue(hlth+HealBot_HealsIn[name]);
  else
    bar2:SetValue(0);
  end
  bar.txt = getglobal(bar:GetName().."_text");
  if (not HealBot_IsCasting and HealBot_CanHeal(unit)) then
--    button:Enable();
    HealBot_Enabled[unit]=true;
    bar:SetStatusBarColor(r,g,b,HealBot_Config.Barcola[HealBot_Config.Current_Skin]);
    bar2:SetStatusBarColor(r,g,b,HealBot_Config.BarcolaInHeal[HealBot_Config.Current_Skin]);
    if HealBot_Config.SetClassColourText==1 then
      sr,sg,sb = HealBot_Action_ClassColour(unit);
      sa = 1;
    elseif HealBot_UnitDebuff[unit] then
      sr=HealBot_Config.btextcursecolr[HealBot_Config.Current_Skin];
      sg=HealBot_Config.btextcursecolg[HealBot_Config.Current_Skin];
      sb=HealBot_Config.btextcursecolb[HealBot_Config.Current_Skin];
      sa=HealBot_Config.btextcursecola[HealBot_Config.Current_Skin];
    end
  else
--    button:Disable();
    HealBot_Enabled[unit]=nil;
    if HealBot_Ressing[UnitName(unit)] then
      if UnitIsDeadOrGhost(unit) then
        sr=0.2;
        sg=1.0;
        sb=0.2;
        sa=1;
      else
        HealBot_Ressing[UnitName(unit)]=nil
        sr=HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin];
        sg=HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin];
        sb=HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin];
        sa=HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin];
      end
    else
      sr=HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin];
      sg=HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin];
      sb=HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin];
      sa=HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin];
    end
    bar:SetStatusBarColor(r,g,b,HealBot_Config.bardisa[HealBot_Config.Current_Skin]);
    bar2:SetStatusBarColor(r,g,b,HealBot_Config.bardisa[HealBot_Config.Current_Skin]);
  end

  if HealBot_Config.ShowClassOnBar==1 then
    if UnitClass(unit) then
      if HealBot_Config.ShowClassOnBarWithName==1 then
        name=UnitClass(unit)..":"..name;
      else
        name=UnitClass(unit);
      end
    end
  end
  
  local barText ="";
  if HealBot_Config.ShowHealthOnBar==1 and maxhlth then
    if HealBot_Config.BarHealthType==1 then
      barText=" ("..hlth-maxhlth..")"
    else
      barText=" ("..floor((hlth/maxhlth)*100).."%)"
    end
	textlen=textlen-string.len(barText)
	if textlen<1 then textlen=1; end
  end
     
  if string.len(name)>textlen then
    barText = string.sub(name,1,textlen) .. '..'..barText;
  else
    barText = name..barText;
  end
  bar.txt:SetText(barText);
  bar.txt:SetTextColor(sr,sg,sb,sa);
end

function HealBot_Action_EnableButtons()
  table.foreach(HealBot_Action_HealButtons, function (index,button)
    HealBot_Action_EnableButton(button);
  end);
end
  
function HealBot_Action_RefreshButton(button)
  if not button then return end
  if type(button)~="table" then DEFAULT_CHAT_FRAME:AddMessage("***** "..type(button)) end
  local unit = button.unit;
  if HealBot_MayHeal(unit) then
    HealBot_Action_EnableButton(button)
  end
end

function HealBot_Action_ResetSkin()
  HealBot_Action_PartyChanged()
  if HealBot_Options:IsVisible() then 
    HealBot_DiseaseColorpick:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_MagicColorpick:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_PoisonColorpick:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_CurseColorpick:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_EnTextColorpick:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_EnTextColorpickin:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_DisTextColorpick:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_DebTextColorpick:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..HealBot_Config.btexture[HealBot_Config.Current_Skin]);
    HealBot_SetSkinColours()
  end
end

function HealBot_Action_RefreshButtons()
  table.foreach(HealBot_Action_HealButtons, function (index,button)
    HealBot_Action_RefreshButton(button);
  end);
end

function HealBot_Action_RefreshButtons(unit)
  if unit and HealBot_Action_UnitButtons[unit] then
    table.foreach(HealBot_Action_UnitButtons[unit], function (index,button)
      HealBot_Action_RefreshButton(button);
    end);
  else
    table.foreach(HealBot_Action_HealButtons, function (index,button)
      HealBot_Action_RefreshButton(button);
    end);
  end
end

function HealBot_Action_PositionButton(button,OsetX,OsetY,bwidth,bheight,checked,header)
  local brspace=HealBot_Config.brspace[HealBot_Config.Current_Skin] or 3;
  if header then
    headerno=headerno+1;
    local headerobj=getglobal("HealBot_Action_Header"..headerno);
    local tmpY=OsetY
    headerobj:SetText(header)
    headerobj:Show();
    headerobj:ClearAllPoints();
    headerobj:SetHeight(bheight);
    headerobj:SetWidth(bwidth);
    headerobj:SetPoint("TOPLEFT","HealBot_Action","TOPLEFT",OsetX,-OsetY);
    headerobj:Disable();
    OsetY = OsetY+headerobj:GetHeight()+brspace;
  else
    local unit = button.unit;
    button:SetText(" ");
    if (HealBot_MayHeal(unit)) then
      button:Show();
      button:ClearAllPoints();
      button:SetHeight(bheight);
      button:Enable();
      if checked then
        button:SetWidth(bwidth-14);
        button:SetPoint("TOPLEFT","HealBot_Action","TOPLEFT",OsetX+14,-OsetY);
      else
        button:SetWidth(bwidth);
        button:SetPoint("TOPLEFT","HealBot_Action","TOPLEFT",OsetX,-OsetY);
      end
      OsetY = OsetY+button:GetHeight()+brspace;
    else
      button:Hide();
    end
  end
  return OsetY;
end

function HealBot_Action_SetHeightWidth(width,height,bwidth)
  if HealBot_ActionHeight then
    HealBot_Action:SetHeight(HealBot_ActionHeight);
  end
  if HealBot_Config.GrowUpwards==1 then
    local left,bottom = HealBot_Action:GetLeft(),HealBot_Action:GetBottom();
    if left and bottom then
      if HealBot_Config.PanelAnchorX==-1 then HealBot_Config.PanelAnchorX=left; end
      if HealBot_Config.PanelAnchorY==-1 then HealBot_Config.PanelAnchorY=bottom; end
      HealBot_Action:ClearAllPoints();
      HealBot_Action:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",HealBot_Config.PanelAnchorX,HealBot_Config.PanelAnchorY);
    end
  else
    local left,top = HealBot_Action:GetLeft(),HealBot_Action:GetTop();
    if left and top then
      HealBot_Action:ClearAllPoints();
      HealBot_Action:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",left,top);
    end
  end
  HealBot_Action:SetHeight(height);
  HealBot_ActionHeight = height;
  HealBot_Action:SetWidth(width+bwidth+10)
end

function HealBot_Action_SetHealButton(index,unit)
  if not index then
    HealBot_Action_HealButtons = {};
    HealBot_Action_UnitButtons = {};
    return nil
  end
  local button = getglobal("HealBot_Action_HealUnit"..index);
  button.unit = unit;
  if unit then
    table.insert(HealBot_Action_HealButtons,button);
    if not HealBot_Action_UnitButtons[unit] then HealBot_Action_UnitButtons[unit] = {} end
    table.insert(HealBot_Action_UnitButtons[unit],button);
  else
    button:Hide();
  end
  return button;
end

function HealBot_Action_PartyChanged()

if not HealBot_IsFighting then

  local numBars = 0;
  local numHeaders = 0;
  local TempMaxH=0;
  local HeaderPos = {};
  HealBot_Enabled = {};
  
  for j=1,15 do
    local headerobj=getglobal("HealBot_Action_Header"..j);
    headerobj:SetText(" ")
    headerobj:Hide();
  end

  local bwidth = HealBot_Config.bwidth[HealBot_Config.Current_Skin] or 85;
  local sr=HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin] or 0.4;
  local sg=HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin] or 0.4;
  local sb=HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin] or 0.4;
  local sa=HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin] or 0.6;
  local bheight=HealBot_Config.bheight[HealBot_Config.Current_Skin] or 18;
  local btexture=HealBot_Config.btexture[HealBot_Config.Current_Skin] or 5;
  local bcspace=HealBot_Config.bcspace[HealBot_Config.Current_Skin] or 4;
  local cols=HealBot_Config.numcols[HealBot_Config.Current_Skin] or 2;
  local btextheight=HealBot_Config.btextheight[HealBot_Config.Current_Skin] or 10;
  local abortsize=HealBot_Config.abortsize[HealBot_Config.Current_Skin] or 10;
  local checked_start=0;
  local checked_end=0;
  headerno=0;
  
  for j=1,41 do
    HealBot_Action_SetHealButton(j,nil);
  end
  for j=51,60 do
    HealBot_Action_SetHealButton(j,nil);
  end
    HealBot_Action_SetHealButton();
    local i = 0;
    local last = 0;
    local GroupValid=numBars;
    last = last+6
    if HealBot_Config.GroupHeals==1 then
       if HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 then
        HeaderPos[i+1] = HEALBOT_OPTIONS_GROUPHEALS
      end
      for _,unit in ipairs(HealBot_Action_HealGroup) do
        if not HealBot_Action_UnitButtons[unit] and HealBot_MayHeal(unit) then
          i = i+1;
          HealBot_Action_SetHealButton(i,unit);
          numBars=numBars+1;
        end
        if i==last then break end
      end
    end
    if numBars>GroupValid and HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 then
      numBars=numBars+1;
      numHeaders=numHeaders+1;
    end
    
    last = last+10
    local TankValid=numBars;
    if HealBot_Config.TankHeals==1 then
      if GetNumRaidMembers()>0 and CT_RA_MainTanks then
       if HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 then
        HeaderPos[i+1] = HEALBOT_OPTIONS_TANKHEALS
       end
        for j=1,10 do
          if CT_RA_MainTanks[j] then
            for k=1,GetNumRaidMembers() do
              local unit = "raid"..k;
              local PossibleMT=1;

              if UnitInParty(unit) and HealBot_Config.GroupHeals==1 then 
                if not UnitIsUnit(unit, "player") then
                  PossibleMT=0;
                end
              end
              if PossibleMT==1 then 
                if UnitName(unit)==CT_RA_MainTanks[j] then
                  if not HealBot_Action_UnitButtons[unit] and HealBot_MayHeal(unit) then
                    i = i+1;
                    HealBot_Action_SetHealButton(i,unit);
                    numBars=numBars+1;
                  end
                end
              end
            end
          end
        if i==last then break end
        end
      end
    end
    if numBars>TankValid and HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 then
      numBars=numBars+1;
      numHeaders=numHeaders+1;
    end
    
    last = last+10;
    local h=50;
    local TargetValid=numBars;
    if HealBot_Config.TargetHeals==1 then
      if HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 then
        HeaderPos[i+1] = HEALBOT_OPTIONS_TARGETHEALS
      end
      for _,unit in ipairs(HealBot_Action_HealTarget) do
        if not HealBot_Action_UnitButtons[unit] and HealBot_MayHeal(unit) then
          i = i+1;
          h = h+1;
          if checked_start==0 then checked_start=i; end
          checked_end=i;
          HealBot_Action_SetHealButton(h,unit);
          local check = getglobal("HealBot_Action_HealUnit"..h.."Check");
          check.unit = unit;
          check:SetChecked(1);
          check:Show();
          numBars=numBars+1;
        end
        if i==last then break end
      end

      last = last+1
      unit = HealBot_TargetName()
      if not HealBot_Action_UnitButtons[unit] and HealBot_MayHeal("target") then
        i = i+1;
        h = h+1;
        if h<61 then
          HealBot_Action_SetHealButton(h,"target");
          local check = getglobal("HealBot_Action_HealUnit"..h.."Check");

          check:SetChecked(0);
          check.unit = unit;
          if check.unit then
            if checked_start==0 then checked_start=i; end
            checked_end=i;          
            check:Show();
          else
            check:Hide();
          end
        else
          HealBot_Action_SetHealButton(i,"target");
        end
        numBars=numBars+1;
      end
    end
    if numBars>TargetValid and HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 then
      numBars=numBars+1;
      numHeaders=numHeaders+1;
    end

    last = last+40
    local ExtraValid=numBars;
    if HealBot_Config.EmergencyHeals==1 and GetNumRaidMembers()>0 then
      local order = {};
      local units = {};
      if HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 and HealBot_Config.ExtraOrder==1 then
        HeaderPos[i+1] = HEALBOT_OPTIONS_EMERGENCYHEALS
        numBars=numBars+1;
        numHeaders=numHeaders+1;
      end
      if HealBot_Config.EmergIncMonitor==1 then
          for j=1,40 do
            local PossibleEmerg=1;
            local unit = "raid"..j;
            local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(j);
            if not name then name="not known" end
            if not class then class="not known" end
            if not subgroup then subgroup="not known" end
            
            if not HealBot_Config.ExtraIncGroup[subgroup] then
              PossibleEmerg=0;
            end            
            if UnitInParty(unit) and HealBot_Config.GroupHeals==1 then
              PossibleEmerg=0;
            end
            if PossibleEmerg==1 then 
              if not HealBot_Action_UnitButtons[unit] and HealBot_MayHeal(unit) then
                if HealBot_Config.ExtraOrder==1 then
                  order[unit] = name;
                elseif HealBot_Config.ExtraOrder==2 then
                  order[unit] = class;
                elseif HealBot_Config.ExtraOrder==3 then
                  order[unit] = subgroup;
                else
                  order[unit] = 0-UnitHealthMax(unit);
                  if UnitHealthMax(unit)>TempMaxH then TempMaxH=UnitHealthMax(unit); end
                end
                table.insert(units,unit);
                numBars=numBars+1;
              end
            end
          end
      else
          for j=1,40 do
 
            local unit = "raid"..j;
            local Class = UnitClass(unit);
            local ProcessUnit = 0;
            local PossibleEmerg=1;
            local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(j);
            if not name then name="not known" end
            if not class then class="not known" end
            if not subgroup then subgroup="not known" end

            if not HealBot_Config.ExtraIncGroup[subgroup] then
              PossibleEmerg=0;
            end                     
            if HealBot_EmergInc[Class]==1 then 
              ProcessUnit = 1;
            end
            if UnitInParty(unit) and HealBot_Config.GroupHeals==1 then
              PossibleEmerg=0;
            end

            if ProcessUnit==1 and PossibleEmerg==1 then
              if not HealBot_Action_UnitButtons[unit] and HealBot_MayHeal(unit) then
                if HealBot_Config.ExtraOrder==1 then
                  order[unit] = name;
                elseif HealBot_Config.ExtraOrder==2 then
                  order[unit] = class;
                elseif HealBot_Config.ExtraOrder==3 then
                  order[unit] = subgroup;
                else
                  order[unit] = 0-UnitHealthMax(unit);
                  if UnitHealthMax(unit)>TempMaxH then TempMaxH=UnitHealthMax(unit); end
                end
                table.insert(units,unit);
                numBars=numBars+1;
              end
            end
          end
        end
      table.sort(units,function (a,b)
        if order[a]<order[b] then return true end
        if order[a]>order[b] then return false end
        return a<b
      end)
      local TempSort="init"
      TempMaxH=ceil(TempMaxH/1000)*1000;
      
        for j=1,40 do
          if not units[j] then break end
          local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(strsub(units[j], 5));
          if HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 and HealBot_Config.ExtraOrder==2 and TempSort~=class then 
            TempSort=class
            HeaderPos[i+1] = class
            numBars=numBars+1;
            numHeaders=numHeaders+1;
          end
          if HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 and HealBot_Config.ExtraOrder==3 and TempSort~=subgroup then
            TempSort=subgroup
            HeaderPos[i+1] = HEALBOT_OPTIONS_GROUPHEALS..subgroup
            numBars=numBars+1;
            numHeaders=numHeaders+1;
          end
          if HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 and HealBot_Config.ExtraOrder==4 and TempMaxH>UnitHealthMax(units[j]) then
            TempMaxH=TempMaxH-1000
            HeaderPos[i+1] = ">"..tostring(TempMaxH/1000).."k"
            numBars=numBars+1;
            numHeaders=numHeaders+1;
          end
          i = i+1;
          HealBot_Action_SetHealButton(i,units[j]);
          if i==last then break end
        end
    end
    if numBars==ExtraValid+1 and HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]==1 then
      HeaderPos[i+1] = nil;
      numBars=numBars-1;
    end
  
  OffsetY = 10;
  OffsetX = 10;
  MaxOffsetY=0;
  
  if cols>(numBars-numHeaders) then
    cols=numBars-numHeaders;
  end

  local h=1;
  local i=0;
  local z=1;
  
  table.foreach(HealBot_Action_HealButtons, function (index,button)
    i=i+1;
    local checked=false;
    local header;

    if HeaderPos[i] then
      header=HeaderPos[i];
      OffsetY = HealBot_Action_PositionButton(nil,OffsetX,OffsetY,bwidth,bheight,checked,header);
      if h==ceil((numBars)/cols) and z<numBars then
        h=0;
        if MaxOffsetY<OffsetY then MaxOffsetY = OffsetY; end
        OffsetY = 10;
        OffsetX = OffsetX + bwidth+bcspace; 
    --    z=z+1;
      end
      h=h+1;
      z=z+1;
    end

    if checked_start<=i and checked_end>=i then checked=true; end
    OffsetY = HealBot_Action_PositionButton(button,OffsetX,OffsetY,bwidth,bheight,checked,nil);
    if h==ceil((numBars)/cols) and z<numBars then
      h=0;
      if MaxOffsetY<OffsetY then MaxOffsetY = OffsetY; end
      OffsetY = 10;
      OffsetX = OffsetX + bwidth+bcspace; 
    end
    z=z+1;
    h=h+1;
    local bar = HealBot_Action_HealthBar(button);
    local bar2 = HealBot_Action_HealthBar2(button);
    bar.txt = getglobal(bar:GetName().."_text");
    bar:SetHeight(bheight);
    bar:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..btexture);
    bar.txt:SetTextHeight(btextheight);
    local barScale = bar:GetScale();
    bar:SetScale(barScale + 0.01);
    bar:SetScale(barScale);
    bar2:SetHeight(bheight);
    bar2:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..btexture);
  end);

  if MaxOffsetY<OffsetY then MaxOffsetY = OffsetY; end

  if HealBot_Config.HideOptions==1 then
    HealBot_Action_OptionsButton:Hide();
  else
    HealBot_Action_OptionsButton:SetPoint("BOTTOM","HealBot_Action","BOTTOM",0,10);
    HealBot_Action_OptionsButton:Show();
    MaxOffsetY = MaxOffsetY+30;
  end  
  
  if HealBot_Config.HideAbort==1 then
    HealBot_Action_AbortButton:Hide();
  else
    local bar = HealBot_Action_HealthBar(HealBot_Action_AbortButton);
    local width=(bwidth-12)+(OffsetX/(6-(abortsize/3)));

    bar.txt = getglobal(bar:GetName().."_text");
    bar.txt:SetTextColor(sr,sg,sb,sa);
    bar.txt:SetText(HEALBOT_ACTION_ABORT);
    bar:SetStatusBarTexture("Interface\\AddOns\\HealBot\\images\\bar"..btexture);
    bar:SetMinMaxValues(0,100);
    bar:SetValue(100);
    bar:ClearAllPoints();
    bar:SetHeight(bheight+abortsize);
    bar:SetWidth(width);
    bar:SetStatusBarColor(0.1,0.1,0.4,0);
    MaxOffsetY = MaxOffsetY+30+abortsize;
    HealBot_Action_AbortButton:ClearAllPoints();
    HealBot_Action_AbortButton:SetWidth(width)
    HealBot_Action_AbortButton:SetHeight(bheight+abortsize);
    if HealBot_Config.HideOptions==1 then
       HealBot_Action_AbortButton:SetPoint("BOTTOM","HealBot_Action","BOTTOM",0,10);
       bar:SetPoint("BOTTOM","HealBot_Action","BOTTOM",0,10);
    else
       HealBot_Action_AbortButton:SetPoint("BOTTOM","HealBot_Action_OptionsButton","TOP",0,10);
       bar:SetPoint("BOTTOM","HealBot_Action_OptionsButton","TOP",0,10);
    end    
    HealBot_Action_AbortButton:Show();
  end



  HealBot_Action_SetHeightWidth(OffsetX, MaxOffsetY+10, bwidth);
 end
 HealBot_Action_RefreshButtons();
end

function HealBot_Action_Reset()
  HealBot_Action:ClearAllPoints();
  HealBot_Action:SetPoint("TOP","MinimapCluster","BOTTOM",7,10);
  HealBot_Action_HealTarget = {};
  HealBot_Action_PartyChanged();
end

function HealBot_Action_ClassColour(unit)
  local ClassColourR,ClassColourG,ClassColourB = 0,1,0;
  local class=HealBot_UnitClass(unit);
  if class=="DRUID" then
    ClassColourR,ClassColourG,ClassColourB = 1.0,0.49,0.04;
  elseif class=="HUNTER" then
    ClassColourR,ClassColourG,ClassColourB = 0.67,0.83,0.45;
  elseif class=="MAGE" then
    ClassColourR,ClassColourG,ClassColourB = 0.41,0.8,0.94;
  elseif class=="PALADIN" then
    ClassColourR,ClassColourG,ClassColourB = 0.96,0.55,0.73;
  elseif class=="PRIEST" then
    ClassColourR,ClassColourG,ClassColourB = 1.0,1.0,1.0;
  elseif class=="ROGUE" then
    ClassColourR,ClassColourG,ClassColourB = 1.0,0.96,0.41;
  elseif class=="SHAMAN" then
    ClassColourR,ClassColourG,ClassColourB = 0.96,0.55,0.73;
  elseif class=="WARLOCK" then
    ClassColourR,ClassColourG,ClassColourB = 0.58,0.51,0.79;
  elseif class=="WARRIOR" then
    ClassColourR,ClassColourG,ClassColourB = 0.78,0.61,0.43;
  end
  return ClassColourR,ClassColourG,ClassColourB;
end

function HealBot_Action_RefreshTooltip(unit)
  if HealBot_Config.ShowTooltip==0 then return end
  if not unit then unit = HealBot_Action_TooltipUnit end
  if not unit then return end;

  local hlth=UnitHealth(unit);
  local maxhlth=UnitHealthMax(unit);

  local spellLeft = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Left"));
  local spellMiddle = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Middle"));
  local spellRight = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Right"));
  local spellButton4 = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Button4"));
  local spellButton5 = HealBot_GetHealSpell(unit,HealBot_Action_SpellPattern("Button5"));
  local linenum = 1
  
  HealBot_Action_Tooltip_ClearLines();
  
  if HealBot_Config.Tooltip_ShowTarget==1 then
    if UnitName(unit) then
      local cr,cg,cb = HealBot_Action_ClassColour(unit);
      HealBot_Action_Tooltip_SetLineLeft(UnitName(unit).." ("..UnitClass(unit)..")",cr,cg,cb,linenum)  
      if hlth and maxhlth then
        local r,g,b,a=HealBot_HealthColor(unit,hlth,maxhlth);
        HealBot_Action_Tooltip_SetLineRight(hlth.."/"..maxhlth.." (-"..maxhlth-hlth..")",r,g,b,linenum) 
      end
    end
  end
    
    if HealBot_Config.Tooltip_ShowSpellDetail==1 then

      if spellLeft then
        linenum=linenum+2
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONLEFT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellLeft,1,1,0,linenum) 
        linenum=HealBot_Action_Tooltip_SpellInfo(spellLeft,linenum);
      end
      if spellMiddle then
        linenum=linenum+2
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONMIDDLE.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellMiddle,1,1,0,linenum) 
        linenum=HealBot_Action_Tooltip_SpellInfo(spellMiddle,linenum);
      end
      if spellRight then
        linenum=linenum+2
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONRIGHT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellRight,1,1,0,linenum) 
        linenum=HealBot_Action_Tooltip_SpellInfo(spellRight,linenum);
      end
      if spellButton4 then
        linenum=linenum+2
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON4.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellButton4,1,1,0,linenum) 
        linenum=HealBot_Action_Tooltip_SpellInfo(spellButton4,linenum);
      end
      if spellButton5 then
        linenum=linenum+2
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON5.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellButton5,1,1,0,linenum) 
        linenum=HealBot_Action_Tooltip_SpellInfo(spellButton5,linenum);
      end
    else
      if spellLeft then 
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0,linenum) 
        HealBot_Action_Tooltip_SetLineRight(HealBot_Action_Tooltip_SpellSummary(spellLeft),1,1,1,linenum) 
      end
      if spellMiddle then 
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONMIDDLE..":",1,1,0,linenum) 
        HealBot_Action_Tooltip_SetLineRight(HealBot_Action_Tooltip_SpellSummary(spellMiddle),1,1,1,linenum) 
      end
      if spellRight then 
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0,linenum) 
        HealBot_Action_Tooltip_SetLineRight(HealBot_Action_Tooltip_SpellSummary(spellRight),1,1,1,linenum) 
      end
      if spellButton4 then 
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON4..":",1,1,0,linenum) 
        HealBot_Action_Tooltip_SetLineRight(HealBot_Action_Tooltip_SpellSummary(spellButton4),1,1,1,linenum) 
      end
      if spellButton5 then 
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON5..":",1,1,0,linenum) 
        HealBot_Action_Tooltip_SetLineRight(HealBot_Action_Tooltip_SpellSummary(spellButton5),1,1,1,linenum) 
      end
    end      
    if HealBot_Config.Tooltip_Recommend==1 then
      local Instant_check=0;
      if HealBot_Config.Tooltip_ShowSpellDetail==1 then linenum=linenum+1; end
      linenum=linenum+1
      HealBot_Action_Tooltip_SetLineLeft(HEALBOT_TOOLTIP_RECOMMENDTEXT,0.8,0.8,0,linenum) 
      Instant_check=0;
      Instant_check,linenum=HealBot_Action_Tooltip_CheckForInstant(unit,spellLeft,"upd",linenum,Instant_check);
      Instant_check,linenum=HealBot_Action_Tooltip_CheckForInstant(unit,spellMiddle,"upd",linenum,Instant_check);
      Instant_check,linenum=HealBot_Action_Tooltip_CheckForInstant(unit,spellRight,"upd",linenum,Instant_check);
      Instant_check,linenum=HealBot_Action_Tooltip_CheckForInstant(unit,spellButton4,"upd",linenum,Instant_check);
      Instant_check,linenum=HealBot_Action_Tooltip_CheckForInstant(unit,spellButton5,"upd",linenum,Instant_check);
      if Instant_check==0 then
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft("  None",0.4,0.4,0.4,linenum) 
      end
    end

    local height = 20 
    local width = 0
    for i = 1, linenum do
      local txtL = getglobal("HealBot_TooltipTextL" .. i)
      local txtR = getglobal("HealBot_TooltipTextR" .. i)
      height = height + txtL:GetHeight() + 2
      if (txtL:GetWidth() + txtR:GetWidth() + 25 > width) then
        width = txtL:GetWidth() + txtR:GetWidth() + 25
      end
    end
    HealBot_Tooltip:SetWidth(width)
    HealBot_Tooltip:SetHeight(height)
    HealBot_Tooltip:ClearAllPoints();
    if HealBot_Config.TooltipPos>1 then
      if HealBot_Config.TooltipPos==2 then
        HealBot_Tooltip:SetPoint("TOPRIGHT","HealBot_Action","TOPLEFT",0,0);
      elseif HealBot_Config.TooltipPos==3 then
        HealBot_Tooltip:SetPoint("TOPLEFT","HealBot_Action","TOPRIGHT",0,0);
      elseif HealBot_Config.TooltipPos==4 then
        HealBot_Tooltip:SetPoint("BOTTOM","HealBot_Action","TOP",0,0);
      else
        HealBot_Tooltip:SetPoint("TOP","HealBot_Action","BOTTOM",0,0);
      end
    else
      HealBot_Tooltip:SetPoint("BOTTOMRIGHT","WorldFrame","BOTTOMRIGHT",-105,105);
    end
    HealBot_Tooltip:Show();
end

function HealBot_Action_Tooltip_SpellInfo(spell,linenum)
  local text
  if HealBot_Spells[spell] then
    if HealBot_Spells[spell].HealsDur>0 then
      linenum=linenum+1
      HealBot_Action_Tooltip_SetLineLeft(HEALBOT_WORDS_CAST..": "..HealBot_Spells[spell].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,linenum) 
      HealBot_Action_Tooltip_SetLineRight("Mana: "..HealBot_Spells[spell].Mana,0.5,0.5,1,linenum) 
      if HealBot_Spells[spell].HealsMax>0 then
        local Heals = HEALBOT_HEAL.." "
        if HealBot_Spells[spell].Shield then
          Heals = HEALBOT_TOOLTIP_SHIELD.." "
        end
        if HealBot_Spells[spell].HealsMin<HealBot_Spells[spell].HealsMax then
          text=Heals..format("%d", HealBot_Spells[spell].HealsMin + HealBot_Spells[spell].RealHealing) .." "..HEALBOT_WORDS_TO.." "..format("%d",HealBot_Spells[spell].HealsMax + HealBot_Spells[spell].RealHealing)
        else
          text=Heals..format("%d", HealBot_Spells[spell].HealsMax + HealBot_Spells[spell].RealHealing)
        end
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(text,1,1,1,linenum)
      end
      if HealBot_Spells[spell].HealsExt>0 then
        text=HEALBOT_HEAL.." "..HealBot_Spells[spell].HealsDur.." "..HEALBOT_WORDS_OVER.." "..HealBot_Spells[spell].Duration-HealBot_Spells[spell].CastTime.." sec."
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(text,1,1,1,linenum)
      end
      if not HealBot_Spells[spell].Shield then
        text=HEALBOT_TOOLTIP_ITEMBONUS.." +"..HealBot_GetBonus().." | "..HEALBOT_TOOLTIP_ACTUALBONUS.." +"..HealBot_Spells[spell].RealHealing.." "
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft(text,0.8,0.8,0.8,linenum)
      end
    end
  end
  return linenum
end

function HealBot_Action_Tooltip_SpellSummary(spell)
  local ret_val = "  ";
  if HealBot_Spells[spell] then
    if HealBot_Spells[spell].HealsDur>0 then
      if HealBot_Spells[spell].HealsMax>0 then
        local Heals = " "..HEALBOT_HEAL.." ";
        if HealBot_Spells[spell].Shield then
          Heals = " "..HEALBOT_TOOLTIP_SHIELD.." ";
        end
        if HealBot_Spells[spell].HealsMin<HealBot_Spells[spell].HealsMax then
          ret_val=ret_val..Heals..format("%d", ((HealBot_Spells[spell].HealsMin+HealBot_Spells[spell].HealsMax)/2) + HealBot_Spells[spell].RealHealing); 
        else
          ret_val=ret_val..Heals..format("%d", HealBot_Spells[spell].HealsMax + HealBot_Spells[spell].RealHealing);
        end
      end
      if HealBot_Spells[spell].HealsExt>0 then
        ret_val=ret_val.." HoT "..HealBot_Spells[spell].HealsDur;
      end
      ret_val=ret_val.." "..HEALBOT_WORDS_FOR.." "..HealBot_Spells[spell].Mana.." Mana";
    end
  end
  if string.len(ret_val)<5 then ret_val = " - "..spell; end
  return ret_val
end

function HealBot_Action_Tooltip_CheckForInstant(unit,spell,upd,linenum,check)
  if HealBot_Spells[spell] then
    if HealBot_Spells[spell].CastTime == 0 then
      if HealBot_UnitAffected(unit,HealBot_Spells[spell].Buff) then return check,linenum end;  
      if HealBot_UnitAffected(unit,HealBot_Spells[spell].Debuff) then return check,linenum end;
      if upd=="upd" then
        linenum=linenum+1
        HealBot_Action_Tooltip_SetLineLeft("  "..spell,1,1,1,linenum)
      end
    else
      return check,linenum;
    end
  else
    return check,linenum
  end
  return check+1,linenum;
end

function HealBot_Action_RefreshDisabledTooltip(unit)
  if HealBot_Config.ShowTooltip==0 then return end
  if not unit then return end;

  local class=UnitClass("Player");
  local combo=HealBot_Config.DisKeyCombo[class];
  local linenum=1;
  local AltKey="";
  if IsAltKeyDown() then AltKey="Alt"; end
  
  HealBot_Action_Tooltip_ClearLines();
  
  if HealBot_Config.Tooltip_ShowTarget==1 then
    if UnitName(unit) then
      local cr,cg,cb = HealBot_Action_ClassColour(unit);
      HealBot_Action_Tooltip_SetLineLeft(UnitName(unit),cr,cg,cb,linenum)  
      HealBot_Action_Tooltip_SetLineRight(UnitClass(unit),cr,cg,cb,linenum) 
      linenum=linenum+1
    end
  end
  
  if combo[AltKey.."Left"] then
    HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONLEFT..": "..combo[AltKey.."Left"],1,1,0,linenum) 
    linenum=linenum+1
  end
  if combo[AltKey.."Middle"] then
    HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONMIDDLE..": "..combo[AltKey.."Middle"],1,1,0,linenum) 
    linenum=linenum+1
  end
  if combo[AltKey.."Right"] then
    HealBot_Action_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONRIGHT..": "..combo[AltKey.."Right"],1,1,0,linenum) 
  end


    local height = 20 
    local width = 0
    for i = 1, linenum do
      local txtL = getglobal("HealBot_TooltipTextL" .. i)
      local txtR = getglobal("HealBot_TooltipTextR" .. i)
      height = height + txtL:GetHeight() + 2
      if (txtL:GetWidth() + txtR:GetWidth() + 25 > width) then
        width = txtL:GetWidth() + txtR:GetWidth() + 25
      end
    end
    HealBot_Tooltip:SetWidth(width)
    HealBot_Tooltip:SetHeight(height)
    HealBot_Tooltip:ClearAllPoints();
    if HealBot_Config.TooltipPos>1 then
      if HealBot_Config.TooltipPos==2 then
        HealBot_Tooltip:SetPoint("TOPRIGHT","HealBot_Action","TOPLEFT",0,0);
      elseif HealBot_Config.TooltipPos==3 then
        HealBot_Tooltip:SetPoint("TOPLEFT","HealBot_Action","TOPRIGHT",0,0);
      elseif HealBot_Config.TooltipPos==4 then
        HealBot_Tooltip:SetPoint("BOTTOM","HealBot_Action","TOP",0,0);
      else
        HealBot_Tooltip:SetPoint("TOP","HealBot_Action","BOTTOM",0,0);
      end
    else
      HealBot_Tooltip:SetPoint("BOTTOMRIGHT","WorldFrame","BOTTOMRIGHT",-105,105);
    end
    HealBot_Tooltip:Show();
end

function HealBot_Action_Tooltip_SetLineLeft(Text,R,G,B,linenum)
  local txtL = getglobal("HealBot_TooltipTextL" .. linenum)
  txtL:SetTextColor(R,G,B)
  txtL:SetText(Text)
  txtL:Show()
end

function HealBot_Action_Tooltip_SetLineRight(Text,R,G,B,linenum)
  local txtR = getglobal("HealBot_TooltipTextR" .. linenum)
  txtR:SetTextColor(R,G,B)
  txtR:SetText(Text)
  txtR:Show()
end

function HealBot_Action_Tooltip_ClearLines()
  for j=1,30 do
    local txtL = getglobal("HealBot_TooltipTextL" .. j)
    local txtR = getglobal("HealBot_TooltipTextR" .. j)
    txtL:SetText(" ")
    txtR:SetText(" ")
    txtL:Hide()
    txtR:Hide()
  end
end

function HealBot_Action_ShowTooltip(this)
  if HealBot_Config.ShowTooltip==0 then return end
  if not this.unit then return end;
  if not this:IsEnabled() then return end;
 -- GameTooltip_SetDefaultAnchor(HealBot_Tooltip,this);

  
  HealBot_Action_TooltipUnit = this.unit;
  HealBot_Action_RefreshTooltip(this.unit);
end

function HealBot_Action_ShowDisabledTooltip(this)
  if HealBot_Config.ShowTooltip==0 then return end
  if not this.unit then return end;
  
  HealBot_Action_TooltipUnit = nil;
  HealBot_Action_RefreshDisabledTooltip(this.unit);
end

function HealBot_Action_HideTooltip(this)
  if HealBot_Config.ShowTooltip==0 then return end
  HealBot_Tooltip:Hide();
  HealBot_Action_TooltipUnit = nil;
end

function HealBot_Action_Refresh(unit)
  if (UnitIsDeadOrGhost("player")) or (UnitOnTaxi("player")) then
    if HealBot_Config.AutoClose==1 and HealBot_Config.ActionVisible~=0 then 
      HideUIPanel(HealBot_Action); 
    else
      HealBot_Action_RefreshButtons(unit);
    end
    return;
  end
  HealBot_Action_RefreshButtons(unit);
  if not HealBot_IsFighting then
    if (HealBot_Action_MustHealSome()) then
      ShowUIPanel(HealBot_Action);
    elseif HealBot_AbortButton==0 then
      ShowUIPanel(HealBot_Action);
    elseif (not HealBot_Action_ShouldHealSome()) then
      if HealBot_AbortButton==1 and HealBot_Config.AutoClose==1 and HealBot_Config.ActionVisible~=0 then 
        HideUIPanel(HealBot_Action);
      end
    end
  end
end

function HealBot_Action_SpellPattern(button)
  local combos = HealBot_Config.KeyCombo[UnitClass("player")]
  if not combos then return nil end
  local press = button;
  if IsAltKeyDown() then press = "Alt"..press end
  if IsControlKeyDown() then press = "Ctrl"..press end
  if IsShiftKeyDown() then press = "Shift"..press end
  return combos[press]
end

function HealBot_Decode_Button(button)
  if button=="RightButton" then
    button="Right";
  elseif button=="MiddleButton" then
    button="Middle";
  elseif button=="Button4" then
    button="Button4";
  elseif button=="Button5" then
    button="Button5";
  else
    button="Left";
  end
  return button
end

function HealBot_Action_Disabled_Clicks(unit,button)
  local class=UnitClass("Player");
  local combo=HealBot_Config.DisKeyCombo[class];
  local AltKey="";
  if IsAltKeyDown() then AltKey="Alt"; end
  
  if combo[AltKey..button]==HEALBOT_DISABLED_TARGET then
    TargetUnit(unit);
  elseif combo[AltKey..button] then
    HealBot_CastSpellOnFriend(combo[AltKey..button],unit);
  end
  if combo[AltKey..button]==HEALBOT_RESURRECTION or combo[AltKey..button]==HEALBOT_REBIRTH or combo[AltKey..button]==HEALBOT_REDEMPTION or combo[AltKey..button]==HEALBOT_ANCESTRALSPIRIT then
    HealBot_IamRessing=UnitName(unit);
  end

end
--------------------------------------------------------------------------------------------------
-- Widget_OnFoo functions
--------------------------------------------------------------------------------------------------

function HealBot_Action_HealUnit_OnLoad(this)
  this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
end

function HealBot_Action_HealUnit_OnEnter(this)
  if HealBot_Enabled[this.unit] then
    HealBot_Action_ShowTooltip(this);
  else
    if not (UnitIsDeadOrGhost("player")) and not (UnitOnTaxi("player")) and not HealBot_IsFighting then
      HealBot_Action_ShowDisabledTooltip(this);
    end
  end
end

function HealBot_Action_HealUnit_OnLeave(this)
  HealBot_Action_HideTooltip(this);
end

function HealBot_Action_HealUnit_OnClick(this,button)
  local decode_button = HealBot_Decode_Button(button);
  if HealBot_Enabled[this.unit] then
    HealBot_HealUnit(this.unit,HealBot_Action_SpellPattern(decode_button));
  else
    if not (UnitIsDeadOrGhost("player")) and not (UnitOnTaxi("player")) and not HealBot_IsFighting then
      HealBot_Action_Disabled_Clicks(this.unit,decode_button)
    end
  end
end

function HealBot_Action_HealUnitCheck_OnClick(this)
  if not this.unit then return end
  if this:GetChecked() then
    table.insert(HealBot_Action_HealTarget,this.unit)
  else
    for i=1,table.getn(HealBot_Action_HealTarget) do
      if HealBot_Action_HealTarget[i]==this.unit then
        table.remove(HealBot_Action_HealTarget,i);
        break;
      end
    end
  end
  HealBot_Action_PartyChanged();
end

function HealBot_Action_OptionsButton_OnClick(this)
    HealBot_TogglePanel(HealBot_Options);
end

function HealBot_Action_AbortButton_OnClick(this)
  SpellStopCasting();
  HealBot_OnEvent_SpellcastStop(nil)
end

local HealBot_CT_RA_UpdateMTs_Old;
function HealBot_CT_RA_UpdateMTs()
  local value = HealBot_CT_RA_UpdateMTs_Old();
  return value;
end

function HealBot_CT_RaidAssist_DEAD()
--  if (type(CT_RA_MemberFrame_OnClick)=="function") then
--    HealBot_CT_RA_CustomOnClickFunction_Old = CT_RA_CustomOnClickFunction;
--    CT_RA_CustomOnClickFunction = HealBot_CT_RA_CustomOnClickFunction;
--  end
--  if (type(CT_RA_UpdateMTs)=="function") then
--    HealBot_CT_RA_UpdateMTs_Old = CT_RA_UpdateMTs;
--    CT_RA_UpdateMTs = HealBot_CT_RA_UpdateMTs;
--  end
end

--------------------------------------------------------------------------------------------------
-- Frame_OnFoo functions
--------------------------------------------------------------------------------------------------

function HealBot_Action_OnLoad(this)
--  HealBot_CT_RaidAssist();
end

function HealBot_Action_OnShow(this)
  if HealBot_Config.PanelSounds==1 then
    PlaySound("igAbilityOpen");
  end
  HealBot_Config.ActionVisible = 1
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
end

function HealBot_Action_OnHide(this)
  HealBot_StopMoving(this);
  HealBot_Config.ActionVisible = 0
end

function HealBot_Action_OnMouseDown(this,button)
  if button~="RightButton" then
    if HealBot_Config.ActionLocked==0 then
      HealBot_StartMoving(this);
    end
  end
end

function HealBot_Action_OnMouseUp(this,button)
  if button~="RightButton" then
    HealBot_StopMoving(this);
  elseif not HealBot_IsFighting then
    HealBot_Action_OptionsButton_OnClick();
  end
end

function HealBot_Action_OnClick(this,button)
--  HealBot_Action_AddDebug("OnClick("..button..")");
end

function HealBot_Action_OnDragStart(this,button)
  if HealBot_Config.ActionLocked==0 then
    HealBot_StartMoving(this);
  end
end

function HealBot_Action_OnDragStop(this)
  HealBot_StopMoving(this);
end

-- http://www.flexbarforums.com/viewtopic.php?t=66
function HealBot_Action_OnKey(this,key,state)
  local command = GetBindingAction(key); 
  if command then 
    DEFAULT_CHAT_FRAME:AddMessage(key.." "..state.." "..(command or "nil"));
    keystate = state
    RunBinding(command,keystate)
  end 
  DEFAULT_CHAT_FRAME:AddMessage("HealBot_Action_OnKey - "..key);
  if key=="SHIFT" or key=="CTRL" or key=="ALT" then
    DEFAULT_CHAT_FRAME:AddMessage((IsShiftKeyDown() or 0).." "..(IsControlKeyDown() or 0).." "..(IsAltKeyDown() or 0));
    HealBot_Action_Refresh();
  end
end
