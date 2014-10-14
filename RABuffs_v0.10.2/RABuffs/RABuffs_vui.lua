-- RABuffs_vui.lua
--  Handles the visual user interface as well as event-triggered routines.
-- Version 0.10.1

RABui_BarCount = 0;
RABui_Settings_TabCount = 4;

RABui_ccBarColorId = 0; -- Bar ID of the change color dialog bar.
RABui_MenuBar = nil; -- Bar ID of the bar menu bar.

RABui_UpdateId = 0;
RABui_NextUpdate = 0;
RABui_LastShiftState = 0; -- Shift*1+Alt*2

RAB_BarDetail_SelectedGroups = {true,true,true,true,true,true,true,true};
RAB_BarDetail_SelectedClasses = {m=true,l=true,p=true,r=true,d=true,h=true,s=true,w=true,a=true};
RAB_BarDetail_SelectedType = ""; -- AddBar Bar Type
RAB_BarDetail_Output = "";
RAB_BarDetail_EditBarId = 0; -- 0 = new bar

RAB_LoadShow = "";
RABui_IsUIShown = true;

StaticPopupDialogs["RAB_BARDETAIL_OUT_WHISPERTARGET"] = {
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 30,
	whileDead = 1,
	timeout = 0,
	hideOnEscape = 1
};


-- Loading Sequence
function RABui_OnLoad()
 this:RegisterEvent("PLAYER_ENTERING_WORLD");
 this:RegisterEvent("LEARNED_SPELL_IN_TAB");

 -- StaticPopup
 StaticPopupDialogs["RAB_BARDETAIL_OUT_WHISPERTARGET"].EditBoxOnEnterPressed = RABui_BarDetail_WhisperAccept;
 StaticPopupDialogs["RAB_BARDETAIL_OUT_WHISPERTARGET"].OnAccept = RABui_BarDetail_WhisperAccept;
end
function RABui_OnEvent()
 local i, j;
 
 if (event == "PLAYER_ENTERING_WORLD") then
  if (RAB_Lock ~= 0) then
   RAB_Lock = 0;
   RABui_UpdateBars();
   sRAB_Localize(false, true);
  end

  RABui_Settings_SelectUTab(1);
  if (RAB_LoadShow == "welcome") then
   ShowUIPanel(RAB_SettingsFrame);
   RABui_Settings_SelectTab(1);
   RABui_Settings_SelectUTab(2);
   RABui_IsUIShown = true;
   RABFrame:Show();
  elseif (RAB_LoadShow == "changelog") then
   ShowUIPanel(RAB_SettingsFrame);
   RABui_Settings_SelectTab(1);
   RABui_Settings_SelectUTab(3);
  elseif (RAB_LoadShow == "versionwarn") then
   StaticPopup_Show ("RAB_MSG");
  end
  RAB_LoadShow = "";
  this:UnregisterEvent("PLAYER_ENTERING_WORLD");

 elseif (event == "LEARNED_SPELL_IN_TAB") then
  sRAB_Localize(false, true);
 end
end
function RABui_UpdateVisibility()
 if (arg2 == -1 and RABui_IsUIShown) then
  RABFrame:Show();
 elseif (arg2 == -1 and not RABui_IsUIShown) then
  RABFrame:Hide();
 elseif ((arg1 == 0 and RABui_Settings.showsolo)  or
         (arg1 == 1 and RABui_Settings.showparty) or
         (arg1 == 2 and RABui_Settings.showraid) ) then
  RABFrame:Show();
 else
  RABFrame:Hide();
 end
end
function RABui_Hide()
 RABFrame:Hide();
end
function RABui_Load()
 sRAB_Localize(true,false);
 if (RAB_ChatFrame_OnEvent ~= nil) then
  RAB_RealChatFrame_OnEvent = ChatFrame_OnEvent;
  ChatFrame_OnEvent = RAB_ChatFrame_OnEvent;
 end

 RABui_SyncBars();
 if (RABui_Settings.enableGreeting) then
  RAB_Print(string.format(sRAB_Greeting,RABuffs_Version),"ok");
 end

 RAB_Settings_BL_Update();
 if (RABui_IsUIShown == false) then
  RABui_Hide();
 end

 GameTooltip.SetUnitBuffOrig = GameTooltip.SetUnitBuff;
 GameTooltip.SetUnitBuff = RABui_GameTooltip_SetUnitBuff;

 return "remove";
end

function RABui_SyncBars()
 local i
 for i = 1, table.getn(RABui_Bars) do
  if (i > RABui_BarCount) then
   RABui_CreateBar(i);
   RABui_BarCount = i;
  end
  getglobal("RAB_Bar" .. i):Show();
  getglobal("RAB_Bar" .. i .. "Tex"):SetTexture("Interface\\AddOns\\RABuffs\\bar.tga");
  getglobal("RAB_Bar" .. i .. "Tex2"):SetTexture("Interface\\AddOns\\RABuffs\\bar.tga");
  getglobal("RAB_Bar" .. i .. "Tex"):SetVertexColor(RABui_Bars[i].color[1],RABui_Bars[i].color[2],RABui_Bars[i].color[3]);
  getglobal("RAB_Bar" .. i .. "Tex2"):SetVertexColor(RABui_Bars[i].color[1],RABui_Bars[i].color[2],RABui_Bars[i].color[3]);
  RABui_SetBarText(i,RABui_Bars[i].label .. (RABui_Bars[i].extralabel == nil and "" or RABui_Bars[i].extralabel));
 end
 for i=table.getn(RABui_Bars)+1,RABui_BarCount do
  getglobal("RAB_Bar" .. i):Hide();
 end
 RABFrame:SetHeight(10+table.getn(RABui_Bars)*12);
 RABui_Settings_Layout_SyncList();
end
function RABui_UpdateBars()
 local i;
 for i = 1,table.getn(RABui_Bars) do
  RABui_UpdateBar(i);
 end
end
function RABui_SetBarValue(barid, cur, fade, max)
 if (max == nil) then max = tonumber(fade); fade = 0; end
 if (tonumber(cur) > tonumber(max)) then max = tonumber(cur); end
 local bar = getglobal("RAB_Bar" .. barid);
 if (bar ~= nil and (cur ~= bar.cur or max ~= bar.max or fade ~= bar.fade)) then
  bar.cur, bar.max, bar.fade = cur, max, fade;
  if (cur-fade > 0) then
   getglobal("RAB_Bar" .. barid .. "Tex"):SetWidth(bar:GetWidth()*(cur-fade)/max);
  else
   getglobal("RAB_Bar" .. barid .. "Tex"):SetWidth(0.01); 
  end
  if (cur > 0) then
   getglobal("RAB_Bar" .. barid .. "Tex2"):SetWidth(bar:GetWidth()*cur/max);
  else
   getglobal("RAB_Bar" .. barid .. "Tex2"):SetWidth(0.01);
  end
 end
end
function RABui_SetBarText(barid, text)
 getglobal("RAB_Bar" .. barid):SetText(text);
end
function RABui_GetBarValue(barid)
 return tonumber(getglobal("RAB_Bar" .. barid).cur), tonumber(getglobal("RAB_Bar" .. barid).max);
end


-- Menus
function RABui_Menu_OnLoad()
 UIDropDownMenu_Initialize(this, RABui_Menu_Initialize, "MENU");
end
function RABui_Menu_Initialize()
	UIDropDownMenu_AddButton({text=sRAB_Settings_UIHeader,isTitle=1}, UIDROPDOWNMENU_MENU_LEVEL);
	UIDropDownMenu_AddButton({text=sRAB_Menu_HideWindow,notCheckable=1, func= function () RABFrame:Hide(); RAB_Print(sRAB_Menu_HiddenWindow); end});
	UIDropDownMenu_AddButton({text=sRAB_Menu_Settings,notCheckable=1, func = function () RABui_Settings_SelectTab(1); ShowUIPanel(RAB_SettingsFrame); end})
	UIDropDownMenu_SetWidth(75,RAB_Menu);
end

function RABui_MoveBar(barid, direction)
	local abuff = RABui_Bars[barid+direction]; 
	RABui_Bars[barid+direction] = RABui_Bars[barid]; RABui_Bars[barid] = abuff;
	RABui_SyncBars();
end

function RABui_OnUpdate(elapsed)
 local i;
 
 if (RABui_NextUpdate < GetTime()) then    
  RABui_UpdateId = (RABui_UpdateId > 10 and 0 or RABui_UpdateId) + 1;
  for i=1,table.getn(RABui_Bars) do
   if (math.mod(RABui_UpdateId,RABui_Bars[i].priority) == 0 or RABui_TooltipBar == i) then
    RABui_UpdateBar(i);
   end
  end
  RABui_NextUpdate = GetTime() + RABui_Settings.updateInterval;
 end
 local shiftstate = (IsShiftKeyDown() and 1 or 0) + (IsAltKeyDown() and 2 or 0);
 if (shiftstate ~= RABui_LastShiftState) then
  RABui_LastShiftState = shiftstate;
  if (RABui_TooltipBar ~= nil and RABui_TooltipBar ~= 0) then
   RABui_UpdateTooltip(RABui_TooltipBar);
  end
 end
end
function RABui_UpdateBar(barid)
 local i, line, cl;
 local buffed, fading, total, misc = RAB_CallRaidBuffCheck(RABui_Bars[barid].cmd, false, false);

 RABui_SetBarValue(barid, buffed, fading, total);

 RABui_Bars[barid].extralabel = (misc == nil and "" or misc);

 local bartext = RABui_Bars[barid].label .. RABui_Bars[barid].extralabel;
 if (RABui_TooltipBar == barid) then
  bartext = buffed .. " / " .. total .. (total > 0 and " (" .. floor(buffed*100/total) .. "%)" or "");
  RABui_UpdateTooltip(barid);
 end
 RABui_SetBarText(barid, bartext);
end
function RABui_ChangeBarColor_Done()
 if (RABui_ccBar ~= 0) then
  local r,g,b = ColorPickerFrame:GetColorRGB();
  RABui_Bars[RABui_ccBar].color = {r,g,b};
  RABui_SyncBars();
 end
end
function RABui_ChangeBarColor_Cancel(prev)
 RABui_Bars[RABui_ccBar].color = prev
 RABui_ccBar = 0;
 RABui_SyncBars();
end

-- Handles Bar Events
function RABui_BarOnEnter()
 RABui_UpdateTooltip(this:GetID());
end
function RABui_UpdateTooltip(id)
	RAB_Tooltip:SetOwner(RABFrame, "ANCHOR_LEFT");
	RABui_TooltipBar = id;

	local index, info, l;
	local info;

	local buffed, fading, total, misc, mhead, hhead, mtext, htext, invert, raw, rawsort, rawgroup = RAB_CallRaidBuffCheck(RABui_Bars[id].cmd, true, false);
	local _,_,bcmd = string.find(RABui_Bars[id].cmd,"^(%a+)");
	local og,cg, pline,linepeoplecount = 0,"","",0;
	if (raw ~= nil) then
	 l = 0;
	 local showwhat = (invert == true);
	 if (IsShiftKeyDown()) then showwhat = not showwhat; end
	 RAB_Tooltip:AddLine(showwhat and hhead or mhead);
	 for i=1,table.getn(raw) do
	  if (raw[i] ~= nil and raw[i].class ~= nil and raw[i].buffed == showwhat) then
	   line = raw[i]; l = l +1;
	   line.append = line.append ~= nil and line.append or "";
 	   cg = rawgroup and string.format(rawgroup, line[rawsort]) or string.format(sRAB_Core_GroupFormat,line.group);
	   linepeoplecount = linepeoplecount + 1;
	   if ((og ~= cg or rawgroup == false or rawgroup == nil) and og ~= 0 or linepeoplecount > 5) then
  	    RAB_Tooltip:AddDoubleLine(pline, og);
	    pline = "";
	    linepeoplecount = 1;
	   end
	   og = cg;
	   pline = pline .. (pline == "" and "" or ", ") .. RABui_Tooltip_FormatNick(line.name, line.class, line.unit, line.append) .. (line.fade ~= nil and " (" .. RAB_TimeFormatOffset(line.fade) .. ")" or "");
	  end
	 end
         if (og ~= 0) then
	  RAB_Tooltip:AddDoubleLine(pline, og);	
	 end
	 if (l == 0) then
	  RAB_Tooltip:AddLine(sRAB_Tooltip_NoOne);
	  if (showwhat == false and buffed > 0 and RAB_Buffs[bcmd].recast ~= nil) then
	   table.sort(raw,function(a,b)  return tonumber(tostring(a.fade) == "nil" and 9999 or tostring(a.fade)) < tonumber(tostring(b.fade) == "nil" and 9999 or tostring(b.fade)); end);
	   if (raw[1].fade ~= nil and raw[1].fade < RAB_Buffs[bcmd].recast*60) then   
	    RAB_Tooltip:SetOwner(RABFrame, "ANCHOR_LEFT");
	    RAB_Tooltip:AddLine(string.format(sRAB_Tooltip_FadeSoon,RAB_Buffs[bcmd].name));
	    for i=1,10 do
		if (raw[i] ~= nil and raw[i].fade ~= nil and raw[i].fade < RAB_Buffs[bcmd].recast*60) then
		 RAB_Tooltip:AddDoubleLine(RABui_Tooltip_FormatNick(raw[i].name, raw[i].class, raw[i].unit, raw[i].append),RAB_TimeFormatOffset(raw[i].fade));
		end
	    end
	   end
	  end
	 end
	else
	 RABui_TooltipBar = nil;
	 return;
	end
	local shiftnote = (IsShiftKeyDown() and sRAB_Tooltip_ReleaseToInvert or sRAB_Tooltip_HoldToInvert);
	local outTarget,n = "";
	if (RABui_Bars[id].out == "RAID" and UnitInRaid("player")) then outTarget = strlower(CHAT_MSG_RAID);
	elseif ((RABui_Bars[id].out == "RAID" or RABui_Bars[id].out == "PARTY" or RABui_Bars[id].out == nil) and GetNumPartyMembers() > 0) then outTarget = strlower(CHAT_MSG_PARTY);
	elseif (RABui_Bars[id].out == "OFFICER") then outTarget = sRAB_Settings_BarDetail_Output_Officer;
	elseif (string.find(tostring(RABui_Bars[id].out),"^CHANNEL:") ~= nil) then _,_,n = string.find(RABui_Bars[id].out,"^CHANNEL:(.+)"); outTarget = n;
	elseif (string.find(tostring(RABui_Bars[id].out),"^WHISPER:") ~= nil) then _,_,n = string.find(RABui_Bars[id].out,"^WHISPER:(.+)"); outTarget = n .. sRAB_Settings_BarDetail_Output_WhisperSuffix;
	end
	if (outTarget ~= "") then outTarget = string.format(sRAB_Tooltip_ClickToOutput,outTarget) .. " "; end
	if ((RAB_Buffs[bcmd].castClass == RAB_UnitClass("player") and sRAB_SpellNames[bcmd] ~= nil) or RAB_Buffs[bcmd].buffFunc ~= nil) then
	 local tip = "";
	 if (RAB_Buffs[bcmd].buffFunc == nil) then
	  tip = RAB_DefaultCastingHandler("tip",RABui_Bars[id].cmd);
	 else
	  tip = RAB_Buffs[bcmd].buffFunc("tip",RABui_Bars[id].cmd);
	 end
	 if (type(tip) == "string" and tip ~= "") then RAB_Tooltip:AddLine(tip); end
	end
	if (RABui_Settings.dummymode) then RAB_Tooltip:AddLine(outTarget .. shiftnote); end
	RAB_Tooltip:Show();

	RAB_Tooltip:ClearAllPoints();
	local anchorPoint = "RIGHT";
	local relativePoint = "LEFT";
	local xOffset = -4;

	local x,y = RABFrame:GetCenter();
	local screenWidth = UIParent:GetWidth();
	if (x~=nil and screenWidth~=nil) then
		if (x < (screenWidth / 2)) then
			anchorPoint = "LEFT";
			relativePoint = "RIGHT";
			xOffset = 4;
		end
	end

	RAB_Tooltip:SetPoint(anchorPoint, "RAB_Bar" .. id, relativePoint, xOffset, 0);

	local vcur, vmax = RABui_GetBarValue(id);
	RABui_SetBarText(id, vcur .. " / " .. vmax .. (vmax > 0 and " (" .. floor(vcur*100/vmax) .. "%)" or ""));
end
function RABui_Tooltip_FormatNick(name, c, u, append)
 local nick = "";
 if (not UnitIsVisible(u)) then nick = "|cffaaaaaa" .. name .. "|r";
 elseif (not RAB_IsSanePvP(u)) then nick = "|cff00ff33" .. name .. "|r";
 else nick = RAB_Chat_Colors[c] .. name .. "|r";
 end
 return nick .. (append ~= nil and RAB_Chat_Colors[c] .. append .. "|r" or "");
end
function RABui_BarOnLeave()
 local id = this:GetID();
 RABui_TooltipBar = 0;
 RABui_SetBarText(id,RABui_Bars[id].label .. RABui_Bars[id].extralabel);
 RAB_Tooltip:Hide();
end
function RABui_BarOnClick()
 local id = this:GetID();
 local _, _, cmd = string.find(RABui_Bars[id].cmd, "(%a+)");

 if (arg1 == "LeftButton" and IsControlKeyDown()) then
  RAB_BuffCheckOutput(RABui_Bars[id].cmd,RABui_Bars[id].out ~= nil and RABui_Bars[id].out or "RAID",IsShiftKeyDown());
 elseif (arg1 == "LeftButton" and RAB_Buffs[cmd] ~= nil) then
  local doOut = true;
  if (RAB_Buffs[cmd].buffFunc ~= nil) then
   doOut = not RAB_Buffs[cmd].buffFunc("cast", RABui_Bars[id].cmd);
  else
   doOut = not RAB_DefaultCastingHandler("cast", RABui_Bars[id].cmd);   
  end
  if (doOut and RABui_Settings.showsampleoutputonclick) then
   RAB_BuffCheckOutput(RABui_Bars[id].cmd,"CONSOLE",IsShiftKeyDown());
  end
 end
end

function RABui_BarDetail_SetBarData(id)
 local query, priority, groups, classes, label = "", 5, "", "", "";

 if (id == 0) then
  RAB_BarDetail_Header:SetText(sRAB_AddBarFrame_AddBar);
  RAB_BarDetail_Accept:SetText(sRAB_AddBarFrame_Add);
  RAB_BarDetail_Remove:Hide();
  RAB_BarDetail_Output = "RAID";
 else
  RAB_BarDetail_Header:SetText(sRAB_AddBarFrame_EditBar);
  RAB_BarDetail_Accept:SetText(sRAB_AddBarFrame_Edit);
  RAB_BarDetail_Remove:Show();
  _, _, query, groups, classes = string.find(RABui_Bars[id].cmd,"(%a+) ?(%d*) ?(%a*)");
  label, priority, RAB_BarDetail_Output = RABui_Bars[id].label, RABui_Bars[id].priority, RABui_Bars[id].out;
 end

 if (groups == "" or groups == nil) then
  RAB_BarDetail_SelectedGroups = {true,true,true,true,true,true,true,true};
 else
  RAB_BarDetail_SelectedGroups = {false,false,false,false,false,false,false,false};
  for grp in string.gfind(groups,"(%d)") do
   RAB_BarDetail_SelectedGroups[tonumber(grp)] = true;
  end
 end
 if (classes == "" or classes == nil) then
  RAB_BarDetail_SelectedClasses = {m=true,l=true,p=true,r=true,d=true,h=true,s=true,w=true,a=true};
 else
  RAB_BarDetail_SelectedClasses = {m=false,l=false,p=false,r=false,d=false,h=false,s=false,w=false,a=false};
  for grp in string.gfind(classes,"(%a)") do
   RAB_BarDetail_SelectedClasses[grp] = true;
  end
 end

 RAB_BarDetail_Label:SetText(label);

 RAB_BarDetail_SelectedType = query;
 UIDropDownMenu_SetSelectedValue(RAB_BarDetail_Type,query);
 UIDropDownMenu_SetText((query ~= nil and RAB_Buffs[query] ~= nil) and RAB_Buffs[query].name or "", RAB_BarDetail_Type);

 UIDropDownMenu_SetSelectedValue(RAB_BarDetail_OutputTarget, RAB_BarDetail_Output);
 local outtext = sRAB_Settings_BarDetail_Output_RaidParty;
 if (RAB_BarDetail_Output == "PARTY") then			outtext = sRAB_Settings_BarDetail_Output_Party;
 elseif (RAB_BarDetail_Output == "OFFICER") then		outtext = sRAB_Settings_BarDetail_Output_Officer;
 elseif (string.find(RAB_BarDetail_Output,"^CHANNEL:") ~= nil) then	_,_,n = string.find(RAB_BarDetail_Output,"^CHANNEL:(.+)"); outtext = n;
 elseif (string.find(RAB_BarDetail_Output,"^WHISPER:") ~= nil) then	_,_,n = string.find(RAB_BarDetail_Output,"^WHISPER:(.+)"); outtext = n .. sRAB_Settings_BarDetail_Output_WhisperSuffix; UIDropDownMenu_SetSelectedValue(RAB_BarDetail_OutputTarget,"WHISPER");
 end
 UIDropDownMenu_SetText(outtext,RAB_BarDetail_OutputTarget);

 RAB_BarDetail_Priority:SetValue(11 - (priority == nil and 5 or priority));

 RABui_BarDetail_BarGroups_UpdateText();
 RABui_BarDetail_BarClasses_UpdateText();

 RAB_BarDetail_EditBarId = id;
end
function RABui_BarDetail_Priority_SetTooltip()
 if (RABui_Settings ~= nil and RABui_Settings.updateInterval ~= nil) then
  GameTooltip:SetOwner(getglobal(this:GetName() .. "Thumb"),"ANCHOR_BOTTOMLEFT",40,5);
  GameTooltip:AddLine(string.format(sRAB_Settings_BarDetail_PriorityTip,RABui_Settings.updateInterval * (11-this:GetValue())));
  if (RAB_BarDetail_Priority.shouldShowTip) then
   GameTooltip:Show();
  end
 end
end


function RABui_BarDetail_BarGroups_ToggleGroup()
 local grp=tonumber(this.value);
 RAB_BarDetail_SelectedGroups[grp] = not RAB_BarDetail_SelectedGroups[grp];
 RABui_BarDetail_BarGroups_UpdateText();
end
function RABui_BarDetail_BarGroups_ToggleAll()
 local i;
 for i=2,8 do
  RAB_BarDetail_SelectedGroups[i] = not RAB_BarDetail_SelectedGroups[1];
 end
 RAB_BarDetail_SelectedGroups[1] = not RAB_BarDetail_SelectedGroups[1];
 RABui_BarDetail_BarGroups_UpdateText();
end
function RABui_BarDetail_BarGroups_UpdateText()
 local i, sb, gc = 0,"",0;
 for i=1,8 do
  if (RAB_BarDetail_SelectedGroups[i]) then
   sb = (sb == "" and "" or (sb .. ", ")) .. i;
   gc = gc + 1;
  end
 end
 if (gc == 8) then
  UIDropDownMenu_SetText(sRAB_Settings_BarDetail_GroupsAll, RAB_BarDetail_Groups);
 elseif (gc >= 1) then
  UIDropDownMenu_SetText(string.format(sRAB_Settings_BarDetail_GroupsSome,sb), RAB_BarDetail_Groups);
 else
  UIDropDownMenu_SetText(sRAB_Settings_BarDetail_GroupsAll, RAB_BarDetail_Groups);
 end
end
function RABui_BarDetail_BarGroups_OnLoad()
 UIDropDownMenu_Initialize(this, RABui_BarDetail_BarGroups_Initialize);
 UIDropDownMenu_SetWidth(175,RAB_BarDetail_Groups);
end
function RABui_BarDetail_BarGroups_Initialize()
 local i, alltrue = 1, true;
 for i=1,8 do
  alltrue = alltrue and RAB_BarDetail_SelectedGroups[i];
 end
 for i=1,8 do
  UIDropDownMenu_AddButton({text="Group " .. i,value=i,checked=(RAB_BarDetail_SelectedGroups[i]==true),func=RABui_BarDetail_BarGroups_ToggleGroup,keepShownOnClick=1,justifyH="CENTER"});
 end
 DropDownList1.maxWidth = 170;
 UIDropDownMenu_AddButton({text=sRAB_AddBar_ToggleAll,notCheckable=1,func=RABui_BarDetail_BarGroups_ToggleAll,justifyH="CENTER"});
end

function RABui_BarDetail_BarClasses_ToggleClass()
 RAB_BarDetail_SelectedClasses[this.value] = not RAB_BarDetail_SelectedClasses[this.value];
 RABui_BarDetail_BarClasses_UpdateText();
end
function RABui_BarDetail_BarClasses_ToggleAll()
 local key, st, val = "", not RAB_BarDetail_SelectedClasses["m"];
 
 for key, val in RAB_BarDetail_SelectedClasses do
  RAB_BarDetail_SelectedClasses[key] = st;
 end
 RABui_BarDetail_BarClasses_UpdateText();
end
function RABui_BarDetail_BarClasses_UpdateText()
 local sb, gc, fgc, key, val = "",0,0;
 local ignoreString = "-";
 if (RAB_BarDetail_SelectedType ~= "" and RAB_BarDetail_SelectedType ~= nil and RAB_Buffs[RAB_BarDetail_SelectedType] ~= nil and RAB_Buffs[RAB_BarDetail_SelectedType].ignoreClass ~= nil) then
  ignoreString = RAB_Buffs[RAB_BarDetail_SelectedType].ignoreClass;
 end

 for key, val in RAB_ClassShort do
  if ((val ~= "s" or UnitFactionGroup("player") == "Horde") and (val ~= "a" or UnitFactionGroup("player") == "Alliance")) then
   if (string.find(ignoreString,val) == nil) then
    fgc = fgc + 1;
    if (RAB_BarDetail_SelectedClasses[val]) then
     sb = (sb == "" and "" or (sb .. ", ")) .. key;
     gc = gc + 1;
    end
   end
  end
 end
 if (gc == fgc or gc == 0) then
  UIDropDownMenu_SetText(sRAB_Settings_BarDetail_ClassesAll, RAB_BarDetail_Classes);
 elseif (fgc >= 1) then
  UIDropDownMenu_SetText(string.format(sRAB_Settings_BarDetail_ClassesSome,sb), RAB_BarDetail_Classes);
 else
  UIDropDownMenu_SetText(sRAB_Settings_BarDetail_ClassesAll, RAB_BarDetail_Classes);
 end
end
function RABui_BarDetail_BarClasses_OnLoad()
 UIDropDownMenu_Initialize(this, RABui_BarDetail_BarClasses_Initialize);
 UIDropDownMenu_SetWidth(175,RAB_BarDetail_Classes);
end
function RABui_BarDetail_BarClasses_Initialize()
 local key, val;
 for key, val in RAB_ClassShort do
  if ((val ~= "s" or UnitFactionGroup("player") == "Horde") and (val ~= "a" or UnitFactionGroup("player") == "Alliance")) then
   if (RAB_BarDetail_SelectedType == "" or RAB_BarDetail_SelectedType == nil or RAB_Buffs[RAB_BarDetail_SelectedType] == nil or RAB_Buffs[RAB_BarDetail_SelectedType].ignoreClass == nil or string.find(RAB_Buffs[RAB_BarDetail_SelectedType].ignoreClass,val) == nil) then
    UIDropDownMenu_AddButton({text=key .. "s",value=val,checked=(RAB_BarDetail_SelectedClasses[val]==true),func=RABui_BarDetail_BarClasses_ToggleClass,keepShownOnClick=1,justifyH="CENTER"});
   end
  end
 end
 DropDownList1.maxWidth = 170;
 UIDropDownMenu_AddButton({text=sRAB_AddBar_ToggleAll,func=RABui_BarDetail_BarClasses_ToggleAll,notCheckable=1,justifyH="CENTER"});
end

function RABui_BarDetail_OutputTarget_OnLoad()
 UIDropDownMenu_Initialize(this, RABui_BarDetail_OutputTarget_Initialize);
 UIDropDownMenu_SetWidth(125,this);
end
function RABui_BarDetail_OutputTarget_Initialize()
	local key,val,i;
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		UIDropDownMenu_AddButton({text=sRAB_Settings_BarDetail_Output_RaidParty,value="RAID",func=RABui_BarDetail_OutputTarget_OnClick,checked=(RAB_BarDetail_Output == "RAID")});
		UIDropDownMenu_AddButton({text=sRAB_Settings_BarDetail_Output_Party,value="PARTY",func=RABui_BarDetail_OutputTarget_OnClick,checked=(RAB_BarDetail_Output == "PARTY")});
		UIDropDownMenu_AddButton({text=sRAB_Settings_BarDetail_Output_Officer,value="OFFICER",func=RABui_BarDetail_OutputTarget_OnClick,checked=(RAB_BarDetail_Output == "OFFICER")});
		UIDropDownMenu_AddButton({text=sRAB_Settings_BarDetail_Output_Channel,value="CHANNEL",hasArrow=1});
		UIDropDownMenu_AddButton({text=sRAB_Settings_BarDetail_Output_Whisper,value="WHISPER",func=RABui_BarDetail_OutputTarget_OnClick,checked=(string.find(RAB_BarDetail_Output,"WHISPER:") ~= nil)});
	elseif (UIDROPDOWNMENU_MENU_VALUE == "CHANNEL") then
		for i=1,10 do
			id, name = GetChannelName(i);
			if (name ~= nil and name ~= RAB_gSync_Channel and name ~= CT_RA_Channel and name ~= DamageMeters_syncChannel and string.find(name," ") == nil) then
				UIDropDownMenu_AddButton({text=name,value="CHANNEL:" .. name,func=RABui_BarDetail_OutputTarget_OnClick},2);
			end
		end
	end
end
function RABui_BarDetail_OutputTarget_OnClick()
	if (this.value ~= "WHISPER") then
		UIDropDownMenu_SetSelectedValue(RAB_BarDetail_OutputTarget, this.value);
		RAB_BarDetail_Output = this.value;
		ToggleDropDownMenu(1, nil, RAB_BarDetail_OutputTarget);
	elseif (this.value == "WHISPER") then
		StaticPopup_Show ("RAB_BARDETAIL_OUT_WHISPERTARGET");
	end
end
function RABui_BarDetail_WhisperAccept(pa1,pa2,pa3)
 local wtNick = getglobal(this:GetParent():GetName().."EditBox"):GetText();
 if (string.find(wtNick,"[ !@#$%^&*()_+-=\|;':\",./<>?]") == nil) then
  UIDropDownMenu_SetSelectedValue(RAB_BarDetail_OutputTarget, "WHISPER");
  UIDropDownMenu_SetText(wtNick .. sRAB_Settings_BarDetail_Output_WhisperSuffix,RAB_BarDetail_OutputTarget);
  RAB_BarDetail_Output = "WHISPER:" .. wtNick;
 end
end

function RABui_GameTooltip_SetUnitBuff(obj, unit, bId)
 obj.SetUnitBuffOrig(obj, unit, bId);
 local tex = tostring(RAB_TextureToBuff(tostring(UnitBuff(unit, bId))));
 if (RAB_BuffTimers ~= nil and RAB_BuffTimers[UnitName(unit) .. "." .. tex] ~= nil) then
  local tLeft = RAB_BuffTimers[UnitName(unit) .. "." .. tex] - GetTime();
  if (tLeft > 0) then
   obj:AddLine(string.format(sRAB_Tooltip_TimeLeft,RAB_TimeFormatOffset(tLeft)));
  end
 end
end

function RABui_BarDetail_BuffType_OnLoad()
 RABui_AddFrameDropDown_Prepare();
 UIDropDownMenu_Initialize(this, RABui_BarDetail_BuffType_Initialize);
 UIDropDownMenu_SetWidth(125,RAB_BarDetail_Type);
end
function RABui_AddFrameDropDown_Prepare()
	local buffs = {};
	local id = 1;
	for key, val in RAB_Buffs do
		if (val.name ~= nil and val.noUI == nil and val.type ~= "dummy") then
			buffs[id] = {name=val.name,castby="Miscellaneous",key=key}
			if (val.castClass ~= nil) then
				buffs[id].castby = val.castClass;
			end
			if (val.type == "special") then
				buffs[id].tooltip = val.description;		
				buffs[id].tooltitle = val.name;
			elseif (val.type == "debuff") then
				buffs[id].castby = "Debuff";
			end
			id = id + 1;
		end
	end
	table.sort(buffs,function (a,b) return (a.name < b.name) end);
	RAB_ADFDD_Buffs = buffs;
	RAB_ADFDD_Cats = {};
	for key,val in buffs do
		if (RAB_ADFDD_Cats[val.castby] == nil) then
			cb = val.castby;
			if (cb == "Miscellaneous" or cb == "Debuff" or cb == "Item") then
				cb = "z" .. cb;
			end
			tinsert(RAB_ADFDD_Cats,cb);
		end
	end
	table.sort(RAB_ADFDD_Cats);
	local obuff = "";
	for key,val in RAB_ADFDD_Cats do
		if (val ~= obuff) then
			obuff = val;
			if (strsub(val,1,1) == "z") then
				RAB_ADFDD_Cats[key] = strsub(val,2);
			end
		else
			RAB_ADFDD_Cats[key] = nil;
		end
	end
end
function RABui_BarDetail_BuffType_Initialize()
	local key,val,i; i = 1;
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		for key,val in RAB_ADFDD_Cats do
			UIDropDownMenu_AddButton({text=val,value=val,hasArrow=1,notCheckable=1});
		end
	else
		for key,val in RAB_ADFDD_Buffs do
			if (val.castby == UIDROPDOWNMENU_MENU_VALUE) then
				ischeck = nil;
				if (val.key == RAB_BarDetail_SelectedType) then
					ischeck = 1;
				end
				UIDropDownMenu_AddButton({text=val.name,value=val.key,func=RABui_AddFrameDropDown_OnClick,checked=ischeck,tooltipText=val.tooltip,tooltipTitle=val.tooltitle},2);
				i = i + 1;
			end
		end
	end
end
function RABui_AddFrameDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(RAB_BarDetail_Type, this.value);
	RAB_BarDetail_SelectedType = this.value;
	ToggleDropDownMenu(1, nil, RAB_BarDetail_Type);
end
function RABui_AddBar_Accept()
 local i, group, class, alltrue, key, val = 0,"", "", true;
 for i=1,8 do
  alltrue = alltrue and RAB_BarDetail_SelectedGroups[i];
  if (RAB_BarDetail_SelectedGroups[i] == true) then
   group = (group == "" and " " or group) .. i;
  end
 end
 if (alltrue) then groups = ""; end
 alltrue = true;
 for key, val in RAB_ClassShort do
  alltrue = alltrue and RAB_BarDetail_SelectedClasses[val];
  if (RAB_BarDetail_SelectedClasses[val] == true) then
   class = (class == "" and " " or class) .. val;
  end
 end
 if (alltrue) then class = ""; end
 if (RAB_BarDetail_SelectedType ~= nil and RAB_BarDetail_SelectedType ~= "" and RAB_Buffs[RAB_BarDetail_SelectedType] ~= nil) then
  if (RAB_Buffs[RAB_BarDetail_SelectedType].ignoreClass ~= nil) then
   class = string.gsub(class,"[" .. RAB_Buffs[RAB_BarDetail_SelectedType].ignoreClass .. "]","");
  end
  RABui_AddBar(RAB_BarDetail_SelectedType .. group .. class, RAB_BarDetail_Label:GetText(), 11-RAB_BarDetail_Priority:GetValue(),RAB_BarDetail_Output);  
 end
end
function RABui_AddBar(bartype, barlabel, barpriority,outputTarget)
	if (RAB_BarDetail_EditBarId == 0) then
		tinsert(RABui_Bars,{label=barlabel,cmd=bartype,color={1,1,1},priority=barpriority,extralabel="",out=outputTarget});
		RABui_SyncBars();
	else
		RABui_Bars[RAB_BarDetail_EditBarId].label = barlabel;
		RABui_Bars[RAB_BarDetail_EditBarId].cmd = bartype;
		RABui_Bars[RAB_BarDetail_EditBarId].priority = barpriority;
		RABui_Bars[RAB_BarDetail_EditBarId].out = outputTarget;
		RABui_SyncBars();
	end
end

function RABui_SSH_Color(val)
 val = string.gsub(val,"(%b[])", function (a) return strsub(a,2,1) == "|" and a or (HIGHLIGHT_FONT_COLOR_CODE .. "[" .. strsub(a,2,-2) .. "]" .. FONT_COLOR_CODE_CLOSE) end);
 val = string.gsub(val,"(%b{})", function (a) return strsub(a,2,1) == "|" and a or ("|cffC0C0C0" .. "[" .. strsub(a,2,-2) .. "]" .. FONT_COLOR_CODE_CLOSE) end);
 val = string.gsub(val,"(%b_=)", function (a) return strsub(a,2,1) == "|" and a or (HIGHLIGHT_FONT_COLOR_CODE .. strsub(a,2,-2) .. FONT_COLOR_CODE_CLOSE) end);
 val = string.gsub(val,"(%b-+)", function (a) return strsub(a,2,1) == "|" and a or (GREEN_FONT_COLOR_CODE .. strsub(a,2,-2) .. FONT_COLOR_CODE_CLOSE) end);
 return val;
end

function RABui_Settings_SelectTab(id)
 local obj = PanelTemplates_GetSelectedTab(RAB_SettingsFrame);
 for i= 1, 4 do
  if (i == id) then
   getglobal("RAB_Settings_TabFrame" .. i):Show(); 
   PanelTemplates_SelectTab(getglobal("RAB_SettingsFrameTab" .. i));
  else
   getglobal("RAB_Settings_TabFrame" .. i):Hide();
   PanelTemplates_DeselectTab(getglobal("RAB_SettingsFrameTab" .. i));
  end
 end
end
function RABui_Settings_SelectUTab(id)
 RAB_Settings_TabFrame1.selectedTab = id;
 PanelTemplates_SelectTab(getglobal("RAB_Settings_TabFrame1Tab" .. id));
 PanelTemplates_UpdateTabs(RAB_Settings_TabFrame1);
 if (id == 1) then
  RAB_Settings_Tab1HTML:SetText("<html><body><h1 align=\"center\">" .. sRAB_Settings_UIHeader .. "</h1>" .. sRAB_Settings_Welcome .. "<br/><br/>" .. sRAB_Settings_ReleaseNotes .. sRAB_Settings_Version .. "</body></html>");
 elseif (id == 2) then
  RAB_Settings_Tab1HTML:SetText(sRAB_IntroText);
 elseif (id == 3) then
  RAB_Settings_Tab1HTML:SetText(sRAB_ChangeLog2);
 end
 RAB_Settings_Tab1ScrollFrame:UpdateScrollChildRect();
 RAB_Settings_Tab1ScrollFrame:SetVerticalScroll(0);
end

function RABui_Settings_ToggleOption(option)
 if (RABui_Settings[option] ~= nil) then
  RABui_Settings[option] = not RABui_Settings[option]; 
 else
  RAB_Print("ASSERT: Option '" .. option .. "' not set.","warn");
 end
end
function RABui_Settings_InitOption()
 this.name = strsub(this:GetName(),strlen("RAB_Settings_")+1);
 getglobal(this:GetName() .. "Text"):SetText(getglobal("sRAB_Settings_Option_" .. this.name));
 this.tooltipText = getglobal("sRAB_Settings_Option_" .. this.name .. "_Description");
 this:SetChecked(RABui_Settings[this.name] and 1 or 0);
end


function RAB_Settings_BL_Init()
 local key, val, i, sort;
 RAB_BL_Buffs = {};
 for key, val in RAB_Buffs do
  if (val.castClass ~= nil) then
   sort = (val.castClass == "Item" and "zItem" or (val.castClass == "Monster" and "zMonster" or val.castClass));
  elseif (val.type == "special") then
   sort = "zSpecial";
  elseif (val.type == "debuff") then
   sort = "zDebuff";
  else
   sort = "zMisc";
  end
  if (val.notInList == nil) then
   tinsert(RAB_BL_Buffs,{key=key,sort=sort,sort2=sort .. ":" .. tostring(val.name)});
  end
 end
 table.sort(RAB_BL_Buffs,function (a,b) return a.sort2 < b.sort2 end);
 os = ""; i = 0;
 while (i < table.getn(RAB_BL_Buffs)) do
  i = i + 1;
  if (RAB_BL_Buffs[i].sort ~= os) then
   os = RAB_BL_Buffs[i].sort;
   tinsert(RAB_BL_Buffs,i,"header:" .. os);
  else
   RAB_BL_Buffs[i] = RAB_BL_Buffs[i].key;
  end
 end
end
function RAB_Settings_BL_Update()
 if (RAB_BL_Buffs == nil) then
  RAB_Settings_BL_Init();
 end
 FauxScrollFrame_Update(RAB_Settings_BuffListScrollBar,table.getn(RAB_BL_Buffs),RAB_BL_Count,16);
 local offset,i = FauxScrollFrame_GetOffset(RAB_Settings_BuffListScrollBar), 0;
 
 for i=offset+1,offset+RAB_BL_Count do
  if (RAB_BL_Buffs[i] ~= nil) then
   RAB_Settings_BL_ShowBuff(i-offset,RAB_BL_Buffs[i]);
  end
 end
end
function RAB_Settings_BL_ShowBuff(line,bkey)
 local obj = "RAB_Settings_BuffList" .. line;
 if (string.find(bkey,"header:(%w+)")) then
  _, _, bkey = string.find(bkey,"header:z?(.+)");
  getglobal(obj .. "Name"):SetTextColor(NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b);
  getglobal(obj .. "Name"):SetText(bkey);
  getglobal(obj .. "Query"):SetText("");
  getglobal(obj .. "Type"):SetText("");
  getglobal(obj):Disable();
 else
  getglobal(obj):Enable();
  getglobal(obj .. "Name"):SetTextColor(1,1,1);
  getglobal(obj .. "Name"):SetText(RAB_Buffs[bkey].name);
  getglobal(obj .. "Query"):SetText(bkey);
  getglobal(obj .. "Type"):SetText(RAB_Settings_BL_BuffType(bkey));
 end
 if (RABui_Settings_BL_LockHighlightOn == bkey) then
  getglobal(obj):LockHighlight();
 else
  getglobal(obj):UnlockHighlight();
 end
end
function RAB_Settings_BL_BuffType(bkey)
 local btype = sRAB_Settings_BuffList_Buff;
  if (RAB_Buffs[bkey].bigcast ~= nil) then btype = sRAB_Settings_BuffList_Groupbuff;
  elseif (RAB_Buffs[bkey].type ~= nil and getglobal("sRAB_Settings_BuffList_" .. RAB_Buffs[bkey].type) ~= nil) then btype = getglobal("sRAB_Settings_BuffList_" .. RAB_Buffs[bkey].type);
  elseif (RAB_Buffs[bkey].sfunc ~= nil) then btype = sRAB_Settings_BuffList_Dunno;
  end
 return btype;
end
function RAB_Settings_BL_Click()
 local _, _, id = string.find(this:GetName(),"(%d+)$")
 id = tonumber(id);
 bkey = RAB_BL_Buffs[FauxScrollFrame_GetOffset(RAB_Settings_BuffListScrollBar)+id];
 RABui_Settings_BL_LockHighlightOn = bkey; RAB_Settings_BL_Update();
 RABui_Settings_BL_DetailFrame_SetBuff(bkey); 
end
function RABui_Settings_BL_DetailFrame_SetBuff(cmd)
 local key, val, usedTextureSlots;
 RAB_BuffDetail_Header:SetText(RAB_Buffs[cmd].name);
 RAB_BuffDetail_SummaryText:SetText(RAB_Settings_BL_BuffType(bkey) .. " " .. (RAB_Buffs[bkey].castClass ~= nil and string.format(sRAB_Settings_BuffList_ToolTip_CastBy,(RAB_Chat_Colors[RAB_Buffs[bkey].castClass] ~= nil and RAB_Chat_Colors[RAB_Buffs[bkey].castClass] or NORMAL_FONT_COLOR_CODE) .. RAB_Buffs[bkey].castClass .. "|r") or ""));
 usedTextureSlots = 0;
 if (RAB_Buffs[cmd].textures ~= nil) then
  for key, val in RAB_Buffs[cmd].textures do
   usedTextureSlots = usedTextureSlots + 1;
   if (usedTextureSlots < 4) then
    getglobal("RAB_BuffDetail_TexBut" .. usedTextureSlots .. "Tex"):SetTexture("Interface\\Icons\\" .. val);
    getglobal("RAB_BuffDetail_TexBut" .. usedTextureSlots).spellId = sRAB_SpellIDs[(usedTextureSlots == 1 and cmd or (RAB_Buffs[cmd].bigcast ~= nil and RAB_Buffs[cmd].bigcast or "dummy"))];
   end
  end
 end
 for i=1,3 do
  if (i > usedTextureSlots) then
   getglobal("RAB_BuffDetail_TexBut" .. i):Hide();
  else
   getglobal("RAB_BuffDetail_TexBut" .. i):Show();
  end
 end
 local detail = (RAB_Buffs[cmd].description ~= nil and "\n" .. RAB_Buffs[cmd].description or "") .. (RAB_Buffs[cmd].type == "dummy" and sRAB_Settings_BuffList_DummyDesc .. "\n" or "") .. (RAB_Buffs[cmd].noUI ~= nil and "\n" .. sRAB_Settings_BuffList_NoUI or "");
 if (RAB_Buffs[cmd].priority ~= nil) then
  local priarr = {};
  for key, val in RAB_Buffs[cmd].priority do
   tinsert(priarr,{c=strupper(strsub(key,1,1)) .. strsub(key,2),p=val});
  end
  table.sort(priarr,function (a,b) return a.p > b.p end)
  local pribuff, prilast = "", -999;
  for i=1,table.getn(priarr) do
   if (priarr[i].p == prilast) then
    pribuff = pribuff .. (pribuff ~= "" and NORMAL_FONT_COLOR_CODE .. ", |r" or "") .. RAB_Chat_Colors[priarr[i].c] .. priarr[i].c .. "|r";
   else
    pribuff = pribuff .. (pribuff ~= "" and NORMAL_FONT_COLOR_CODE .. " > |r" or "") .. RAB_Chat_Colors[priarr[i].c] .. priarr[i].c .. "|r";
   end
   prilast = priarr[i].p;
  end
  detail = detail .. "\n\n" .. string.format(sRAB_Settings_BuffList_Detail_Priority,pribuff);
 end
 if (RAB_Buffs[cmd].bigcast ~= "") then
  if (RAB_Buffs[cmd].bigsort == "group") then
   detail = detail .. "\n\n" .. string.format(sRAB_Settings_BuffList_Detail_Group,RAB_Buffs[cmd].bigthreshold);
  elseif (RAB_Buffs[cmd].bigsort == "class") then
   detail = detail .. "\n\n" .. string.format(sRAB_Settings_BuffList_Detail_Class,RAB_Buffs[cmd].bigthreshold);
  end
 end
 RAB_BuffDetail_DetailText:SetText(detail);
 RAB_BuffDetailFrame:Show();
end
function RABui_Settings_BL_DetailFrame_OnHide()
 RABui_Settings_BL_LockHighlightOn = "";
 RAB_Settings_BL_Update();
 RAB_BuffDetailFrame:Hide();
end

-- Note: Those things need to be rewritten to account for the faux offset if we're going to be supporting more bars than we can display at once.
-- Just change the way barid resolves to the bar you're moving (locking and unlocking highlight, though, is a problem. Disable moving until edit is done?)
function RABui_Settings_Layout_MoveBarUp(barid)
 if (RAB_BarDetailFrame:IsShown()) then RAB_BarDetailFrame:Hide() end
 RABui_MoveBar(barid+FauxScrollFrame_GetOffset(RAB_Settings_LayoutScrollBar),-1);
end
function RABui_Settings_Layout_MoveBarDown (barid)
 if (RAB_BarDetailFrame:IsShown()) then RAB_BarDetailFrame:Hide() end
 RABui_MoveBar(barid+FauxScrollFrame_GetOffset(RAB_Settings_LayoutScrollBar),1);
end
function RABui_Settings_Layout_SelectBar(barid)
 if (barid == 20) then
  RABui_BarDetail_SetBarData(0);
  RABui_MenuBar = -1;
 else
  barid = barid + FauxScrollFrame_GetOffset(RAB_Settings_LayoutScrollBar);
  RABui_MenuBar = barid;
  RABui_BarDetail_SetBarData(barid);
 end
 RAB_BarDetailFrame:Show();
 RABui_Settings_Layout_SyncList();
end
function RABui_Settings_Layout_DetailFrame_OnHide()
 RABui_MenuBar = 0;
 RABui_Settings_Layout_SyncList();
 RAB_BarDetailFrame:Hide(); -- OnHide fires when tab/window is closed, the detailframe itself isn't flagged as hidden in those cases.
end
function RABui_Settings_BarLine_SwatchOnClick(id)
 id = id+FauxScrollFrame_GetOffset(RAB_Settings_LayoutScrollBar);
 RABui_ccBar = id;
 ColorPickerFrame.func = RABui_ChangeBarColor_Done;
 ColorPickerFrame.cancelFunc = RABui_ChangeBarColor_Cancel;
 ColorPickerFrame.previousValues = RABui_Bars[id].color;
 ColorSwatch:SetTexture(RABui_Bars[id].color[1], RABui_Bars[id].color[2], RABui_Bars[id].color[3]);
 ColorPickerFrame:SetColorRGB(RABui_Bars[id].color[1], RABui_Bars[id].color[2], RABui_Bars[id].color[3]);
 ColorPickerFrame:Show();
end
function RABui_Settings_Layout_SetBar(ui, id)
 if (id == -1) then
  getglobal("RAB_Settings_BarLine" .. ui):Hide();
 else
  getglobal("RAB_Settings_BarLine" .. ui):Show();
  getglobal("RAB_Settings_BarLine" .. ui .. "Name"):SetText(RABui_Bars[id].label);
  getglobal("RAB_Settings_BarLine" .. ui .. "SwatchNormalTexture"):SetVertexColor(RABui_Bars[id].color[1],RABui_Bars[id].color[2],RABui_Bars[id].color[3]);
  _, _, temp = string.find(RABui_Bars[id].cmd,"^(%a+)");
  query = RAB_Buffs[temp] ~= nil and RAB_Buffs[temp].name or temp;
  getglobal("RAB_Settings_BarLine" .. ui .. "Query"):SetText(query);
  if (id == table.getn(RABui_Bars)) then 
   getglobal("RAB_Settings_BarLine" .. ui .. "MoveDown"):Disable();
  else 
   getglobal("RAB_Settings_BarLine" .. ui .. "MoveDown"):Enable(); 
  end
  if (id == 1) then
   getglobal("RAB_Settings_BarLine" .. ui .. "MoveUp"):Disable();
  else
   getglobal("RAB_Settings_BarLine" .. ui .. "MoveUp"):Enable();
  end
  if (id == RABui_MenuBar) then
   getglobal("RAB_Settings_BarLine" .. ui):LockHighlight();
  else
   getglobal("RAB_Settings_BarLine" .. ui):UnlockHighlight();
  end
 end
end
function RABui_Settings_Layout_SyncList()
 FauxScrollFrame_Update(RAB_Settings_LayoutScrollBar,table.getn(RABui_Bars)+1,RAB_BarList_Count,16);
 local offset,i = FauxScrollFrame_GetOffset(RAB_Settings_LayoutScrollBar), 0;

 for i=offset+1,offset+RAB_BarList_Count do
  if (RABui_Bars[i] ~= nil) then
   RABui_Settings_Layout_SetBar(i-offset,i);
  else
   RABui_Settings_Layout_SetBar(i-offset,-1);
  end
 end
 if (offset+RAB_BarList_Count > table.getn(RABui_Bars)) then
  RAB_Settings_BarLine20:SetPoint("TOP",getglobal("RAB_Settings_BarLine" .. (table.getn(RABui_Bars)-offset)),"BOTTOM");
  RAB_Settings_BarLine20:Show();
  if (RABui_MenuBar == -1) then
   RAB_Settings_BarLine20:LockHighlight();
  else
   RAB_Settings_BarLine20:UnlockHighlight();
  end
 else
  RAB_Settings_BarLine20:Hide();
 end
end
function RABui_BarDetail_RemoveBar()
 tremove(RABui_Bars, RABui_MenuBar);
 RABui_SyncBars();
 RAB_BarDetailFrame:Hide();
end
function RABui_Settings_localizationSelector_OnLoad()
 UIDropDownMenu_Initialize(this, RABui_Settings_localizationSelector_Menu);
 UIDropDownMenu_SetWidth(250, this);
end
function RABui_Settings_localizationSelector_Menu(level, key)
 if (not level) then level = 1; end
 if (level == 1) then
  UIDropDownMenu_AddButton({text=sRAB_Settings_Localization_vui,notCheckable=1,value="vui",hasArrow=1},level);
  UIDropDownMenu_AddButton({text=sRAB_Settings_Localization_out,notCheckable=1,value="out",hasArrow=1},level);
 elseif (this.value == "vui" or this.value == "out") then
  for key, val in sRAB_LOCALIZATION do
   local s = strupper(key);
   local uses, lang, author, desc = getglobal("sRAB_Localization_" .. s .. "_CAPABILITIES"), getglobal("sRAB_Localization_" .. s .. "_NATIVE"), getglobal("sRAB_Localization_" .. s .. "_AUTHOR"), getglobal("sRAB_Localization_" .. s .. "_DESCRIPTION");
   if (string.find(uses,"|" .. this.value .. "|") ~= nil) then
    UIDropDownMenu_AddButton({text=lang,value=key,tooltipTitle=lang,tooltipText=desc,checked=(key == getglobal("sRAB_LOCALIZATION_" .. this.value) and 1 or 0),arg1=this.value,arg2=key,func=RABui_Settings_localizationSelector_SetLocale},level);
   end
  end
 end
end
function RABui_Settings_localizationSelector_SetLocale(element, locale)
 if (element == "vui") then
  RABui_Settings.uilocale = locale;
 elseif (element == "out") then
  RABui_Settings.outlocale = locale;
 end
 sRAB_Localize(true,false);
 RABui_Settings_localizationSelector_UpdateText();
 ToggleDropDownMenu(1, nil, RAB_Settings_localizationSelector);
end
function RABui_Settings_localizationSelector_UpdateText()
 local a1, a2 = getglobal("sRAB_Localization_" .. strupper(sRAB_LOCALIZATION_vui) .. "_NATIVE"), getglobal("sRAB_Localization_" .. strupper(sRAB_LOCALIZATION_out) .. "_NATIVE");
 UIDropDownMenu_SetText(string.format(sRAB_Settings_Localization_TextFormat,a1,a2),RAB_Settings_localizationSelector);
end

function RABui_Localize()
 RAB_Settings_BuffList0Name:SetText(sRAB_Settings_BuffList_Name);
 RAB_Settings_BuffList0Query:SetText(sRAB_Settings_BuffList_Query);
 RAB_Settings_BuffList0Type:SetText(sRAB_Settings_BuffList_Type);
 RAB_Settings_BarLine0Name:SetText(sRAB_Settings_BuffList_Name);
 RAB_Settings_BarLine0Query:SetText(sRAB_Settings_BuffList_Query);
 RAB_Settings_BarLine0Position:SetText(sRAB_Settings_BarList_Position);
 RAB_SettingsTitleText:SetText(sRAB_Settings_UIHeader);
 RAB_SettingsFrameTab1:SetText(sRAB_Settings_Tab1Overview);
 RAB_SettingsFrameTab2:SetText(sRAB_Settings_TabBuffs);
 RAB_SettingsFrameTab3:SetText(sRAB_Settings_TabLayout);
 RAB_SettingsFrameTab4:SetText(sRAB_Settings_TabSettings);
 RAB_Settings_TabFrame1Tab1:SetText(sRAB_Settings_Tab1Overview);
 RAB_Settings_TabFrame1Tab2:SetText(sRAB_Settings_Tab1Welcome);
 RAB_Settings_TabFrame1Tab3:SetText(sRAB_Settings_Tab1Changelog);
 RAB_Settings_TabFrame2Header:SetText(sRAB_Settings_BuffList_Header);
 RAB_Settings_TabFrame2Description:SetText(sRAB_Settings_BuffList_Description);
 RAB_Settings_TabFrame3Header:SetText(sRAB_Settings_Layout_Header);
 RAB_Settings_TabFrame3Description:SetText(sRAB_Settings_Layout_Description); 
 RAB_Settings_BarLine20:SetText(sRAB_Settings_Layout_AddNewBar);
 RAB_Settings_TabFrame4Header:SetText(sRAB_Settings_Settings_Header);
 RAB_Settings_TabFrame4Description:SetText(sRAB_Settings_Settings_Description); 
 RAB_Settings_Buffing:SetText(sRAB_Settings_Settings_Buffing);
 RAB_Settings_VUIConfig:SetText(sRAB_Settings_Settings_VUIConfig);
 RAB_BarDetail_LabelText:SetText(sRAB_Settings_BarDetail_Label);
 RAB_BarDetail_QueryText:SetText(sRAB_Settings_BarDetail_Query);
 RAB_BarDetail_OutputText:SetText(sRAB_Settings_BarDetail_OutputTarget);
 RAB_BarDetail_LimitsText:SetText(sRAB_Settings_BarDetail_Limits);
 RAB_BarDetail_Remove:SetText(sRAB_Settings_BarDetail_Remove);
 RAB_BarDetail_PriorityText:SetText(sRAB_Settings_BarDetail_Priority);
 RAB_BarDetail_PriorityLow:SetText(sRAB_Settings_BarDetail_PriorityLess);
 RAB_BarDetail_PriorityHigh:SetText(sRAB_Settings_BarDetail_PriorityMore);
 RAB_Title:SetText(sRAB_Settings_UIHeader);
 StaticPopupDialogs["RAB_BARDETAIL_OUT_WHISPERTARGET"].text = sRAB_Settings_BarDetail_WhisperPrompt;

 PanelTemplates_UpdateTabs(RAB_Settings_TabFrame1);
 PanelTemplates_UpdateTabs(RAB_SettingsFrame);
 for i=1,4 do
  if (i < 4) then
   PanelTemplates_TabResize(0,getglobal("RAB_Settings_TabFrame1Tab" .. i));
  end
   PanelTemplates_TabResize(0,getglobal("RAB_SettingsFrameTab" .. i));
 end
 RABui_Settings_localizationSelector_UpdateText();
end
function RABui_BarRedraw()
 this.fadetime =  this.fadetime and  this.fadetime or 0;
 if (this.fade ~= nil and this.fade > 0 and this.fadetime < GetTime()) then
  this.fadetime = GetTime()+0.04;
  getglobal(this:GetName() .. "Tex2"):SetAlpha(cos(GetTime()*180)*0.2+0.5);
 end
end
function RABui_CreateBar(id)
 local ptr = CreateFrame("Button","RAB_Bar" .. id, RABFrame,"RAB_Bar");
 ptr:SetID(id);
 ptr:SetPoint("TOPLEFT",RABFrame,"TOPLEFT",4,-12*(id-1)-5);
 ptr:Show();
end
function RAB_TimeFormatOffset(tmr)
 if (tmr > 60) then
  return ceil(tmr/60) .. "m";
 else
  return ceil(tmr) .. "s";
 end
end

RAB_Core_Register("PLAYER_LOGIN", "loadui", RABui_Load);
RAB_Core_Register("RAB_GROUPSTATUS","uiVisibility",RABui_UpdateVisibility);