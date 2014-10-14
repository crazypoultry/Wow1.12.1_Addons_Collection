--============================================================================================
--=============================TOTAlert 1.02 独孤傲雪=========================================
--====终于更新了TOTAlert了，现在版本为1.02。代码几乎完全重写，优化了界面。功能上并没有什么====
--====变动，所以如果对原来的版本有感情完全可以不更新。加入了报警开启和关闭功能，颜色选择采====
--====系统的模板，比上个版本简化了些。报警文字加上了闪烁效果，比以前的更醒目，OT后闪烁5次。===
--==================================感谢你的支持==============================================
local TOTWarningCount = 0;
local PlayerName = UnitName("player");
local TargetOfTarget_Time_Elapsed_Rate = 0.2;
local TargetOfTarget_Time_Elapsed = 0;
local flashTimeHold = 0;
local holdTime = 0;

TOTAlertMode = {};
TOTAlertWarning = {};
TOTAlertMove = {};
TOTAlertAlertEnable = {}
TOTAlertHPEnable = {};
TOTAlert_Config = {
  ConfigText = {
  TOTAlertDTHM_Text = "DPS模式";
  TOTAlertWarningMod_Text = "醒目报警模式";
  TOTAlertMove_Text = "智能移动模式";
  TOTAlertAlert_Text = "启用报警功能";
  TOTAlertHP_Text = "显示TOT百分比";};
  TextColor = {r = 1.0, g = 0.0, b = 0.0};  
  }

function TOTAlertFrame_OnLoad()  
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");	
	this:RegisterEvent("VARIABLES_LOADED");	
end

function TOTAlertFrame_OnUpdate(arg1)
	TargetOfTarget_Time_Elapsed = TargetOfTarget_Time_Elapsed + arg1;
	if (TargetOfTarget_Time_Elapsed > TargetOfTarget_Time_Elapsed_Rate) then
	    if (TOTAlertAlertEnable[PlayerName] == 0) then
	      TOTAlert_Go();	
	      TargetOfTarget_Time_Elapsed = 0;
	    end
	end
end 

function TOTAlert_Command(cmd)
    if (cmd) then
        if (cmd == "mode") then
            TOTAlertDTHM_Mode()           
        elseif (cmd == "warning") then
            TOTAlerWarningFont_Mode()           
        elseif (cmd == "move") then
            TOTAlertMove_Mode()
	elseif (cmd == "alert") then
	    TOTAlertAlert_Mode()
        else
            DEFAULT_CHAT_FRAME:AddMessage("按住SHIFT可以拖动窗口到任意位置\n左键单击窗口即可选中目标的目标\n以下是可用的命令:",0,1,0);
            DEFAULT_CHAT_FRAME:AddMessage("/tot mode - 切换模式:DPS ,Tank, and Healer",0,1,0);
            DEFAULT_CHAT_FRAME:AddMessage("/tot warning - 切换提示文本模式:小字/醒目",0,1,0);       
            DEFAULT_CHAT_FRAME:AddMessage("/tot move - 切换移动模式:手动/智能",0,1,0);
	    DEFAULT_CHAT_FRAME:AddMessage("/tot alert - 启用/关闭报警",0,1,0);
        end        
    end
end

function TOTAlertFrame_OnEvent(event)  
    if (event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_TARGET_CHANGED") then
        totWarningCount = 0;        
    end
    if (event == "VARIABLES_LOADED") then     
        
        if (TOTAlertMode[PlayerName] == nil) then
            TOTAlertMode[PlayerName] = {};
            TOTAlertMode[PlayerName] = 0;
            DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 设置为默认模式...");
        end
        if (TOTAlertWarning[PlayerName] == nil) then
            TOTAlertWarning[PlayerName] = {};
            TOTAlertWarning[PlayerName] = 1;
            DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 提示方式设置为默认模式...");
        end               
        if (TOTAlertMove[PlayerName] == nil) then
            TOTAlertMove[PlayerName] = {};
            TOTAlertMove[PlayerName] = 0;
            DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 移动方式设置为默认模式...");       
        end
	if (TOTAlertAlertEnable[PlayerName] == nil) then
	    TOTAlertAlertEnable[PlayerName] = {};
	    TOTAlertAlertEnable[PlayerName] = 0;
            DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 报警模式设置为默认模式...");
	end
	if (TOTAlertHPEnable[PlayerName] == nil) then
	    TOTAlertHPEnable[PlayerName] = {};
	    TOTAlertHPEnable[PlayerName] = 0;           
	end
	
	if (TOTAlertMode[PlayerName] == 0) then 
                TOTAlertDPSFrame:Show();
                TOTAlertHealerFrame:Hide();
                TOTAlertTankFrame:Hide();
        elseif (TOTAlertMode[playerName] == 1) then
                TOTAlertDPSFrame:Hide();
                TOTAlertHealerFrame:Hide();
                TOTAlertTankFrame:Show(); 
        elseif (TOTAlertMode[playername] == 2) then
                TOTAlertDPSFrame:Hide();
                TOTAlertHealerFrame:Show();
                TOTAlertTankFrame:Hide(); 
        end
        SLASH_TOT1 = "/tot";
	SlashCmdList["TOT"] = TOTAlert_Command;
    end  
end

function TOTAlert_Go()
  if (GetNumPartyMembers()>0 or GetNumRaidMembers()>0 or UnitExists("pet")) then
    if (UnitExists("target")) then                                  
                    if (UnitExists("targettarget")) then
                           if (TOTAlertMode[PlayerName] == 0) then  --DPS
                              if (UnitIsUnit("targettarget", "player") and UnitCanAttack("player", "target")) then                               
                                if (totWarningCount == 0) then
                                    if (TOTAlertWarning[PlayerName] == 0) then
                                        UIErrorsFrame:AddMessage(UnitName("target").." 已把目标对准你!",1,0,0,1,3);
                                        PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
                                    elseif (TOTAlertWarning[PlayerName] == 1) then
                                        TOTAlert_BigWarningFrame_Show(UnitName("target").." 已把目标对准你!");                                                                              
                                        PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
                                     end
                                   totWarningCount = 1;
                                end                               
                              else
                                 totWarningCount = 0;     
                              end
                            elseif (TOTAlertMode[PlayerName] == 1) then  -- Tank mode          
                              if ( UnitIsUnit("targettarget", "player") ) then                            
                                    totWarningCount = 0;                                   
                              else
                                if ( aggroWarningCount == 0 and UnitCanAttack("player", "target")) then                                    
                                        if (TOTAlertWarning[PlayerName] == 0) then                    
                                            UIErrorsFrame:AddMessage("你已失去对目标"..UnitName("target").."的仇恨!",1,0,0,1,3);
                                            PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
                                        elseif (TOTAlertWarning[PlayerName] == 1) then
                                            TOTAlert_BigWarningFrame_Show("你已失去对目标 "..UnitName("target").."的仇恨!");                                                                                       
                                            PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
                                        end
                                        totWarningCount = 1;
                                end                                                               
                             end           
                            elseif (TOTAlertMode[PlayerName] == 2) then   -- Healer Mode                              
                                 if (UnitIsFriend("player", "target")) then
                                    if (UnitIsUnit("target","targettargettarget")) then
                                       if (totWarningCount == 0) then                                                 
                                            if (TOTAlertWarning[PlayerName] == 0) then
                                                UIErrorsFrame:AddMessage(UnitName("target").." 正在抗怪 "..UnitName("targettarget"),1,0,0,1,3);
                                            elseif (TOTAlertWarning[PlayerName] == 1) then
                                                TOTAlert_BigWarningFrame_Show(UnitName("target").." 正在抗怪 "..UnitName("targettarget"));                                                    
                                            end
                                            totWarningCount = 1;
                                        end
                                    elseif (UnitIsUnit("player","targettargettarget")) then
                                         if (totWarningCount == 0) then                                                 
                                            if (TOTAlertWarning[PlayerName] == 0) then
                                                UIErrorsFrame:AddMessage("你OT了 请暂时停止治疗",1,0,0,1,3);
                                            elseif (TOTAlertWarning[PlayerName] == 1) then
                                                TOTAlert_BigWarningFrame_Show("你OT了 请暂时停止治疗");                                                        
                                            end
                                            totWarningCount = 1;
                                         end
                                     else
                                       totWarningCount = 0;
                                    end
                                else
                                  if (UnitIsUnit("player","targettarget")) then                                  
                                     if (totWarningCount == 0) then
                                        if (TOTAlertWarning[PlayerName] == 0) then
                                            UIErrorsFrame:AddMessage(UnitName("target").." 已把目标对准你!",1,0,0,1,3);
                                            PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
                                        elseif (TOTAlertWarning[PlayerName] == 1) then
                                            TOTAlert_BigWarningFrame_Show(UnitName("target").." 已把目标对准你!");                                                   
                                            PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
                                        end
                                        totWarningCount = 1;
                                     end
                                  else                                 
                                    totWarningCount = 0;                  
                                  end                             
                                end                   
                             end                                          
                    end                           
        end        
    end                 
 end         
      

function TOTAlert(text, skull)
     TOTAlertText:SetText(text);          
     TOTAlertNotifyBar:SetAlpha(.8);           
     if (UnitHealthMax("targettarget") > 100) then
          local thingy = UnitHealth("targettarget") / UnitHealthMax("targettarget");
          thingy = thingy * 100;
          TOTAlertNotifyBar:SetValue(thingy); 
	  TOTAlertHPText:SetText(math.floor(thingy+0.5).."%");	  
     else
          TOTAlertNotifyBar:SetValue(UnitHealth("targettarget"));
	  TOTAlertHPText:SetText(UnitHealth("targettarget").."%");	
     end       	   
    
     if (skull == 1) then	      
          TOTAlertWarningFrame:Show();
     else
          TOTAlertWarningFrame:Hide();        
     end 
end

function TOTFrame_OnUpdate()
     if (UnitExists("target")) then
          TOTAlertFrame:Show();
	  TOTAlertText:Show();
          if UnitExists("targettarget") then
	        if UnitName("targettarget") == UnitName("player") then
	           if (UnitName("target") ~= UnitName("player")) then
	                  TOTAlert("＊＊＊ 你 ＊＊＊",1);
	           else 
	                  TOTAlert("＊＊＊ 你 ＊＊＊",0); 
	           end
	        else 
	                  TOTAlert(UnitName("targettarget"),0);
	        end
          else 
                TOTAlert("＊＊无目标＊＊",0);
          end
     else
          TOTAlertFrame:Hide();
          TOTAlertText:Hide();
     end                 
     if (TOTAlertMove[PlayerName] == 0) then
          TOTSMove() 
     end
     if (TOTAlertHPEnable[PlayerName] == 0) then
          TOTAlertHPText:Show();
     else
          TOTAlertHPText:Hide();
     end
end

function TOTAlert_TargetUnit()
    AssistUnit("target");
    TOTWarningCount = 0;
end

function TOTAlert_BigWarningFrame_OnLoad()
	TOTAlert_BigWarningFrame:Hide();
end

function TOTAlert_BigWarningFrame_OnUpdate(arg1)     
     flashTimeHold = flashTimeHold + arg1; 
     holdTime = holdTime + arg1; 
     if (flashTimeHold > 0.05) then  
         flashTimeHold = 0; 
	 local alpha = TOTAlert_BigWarningFrame:GetAlpha();
	 if (ShowFlashWarning) then
	     alpha = alpha - 0.1; 
	     if (alpha < 0) then
	         alpha = 0; 
		 ShowFlashWarning = nil; 
		 if (holdTime > 6) then
     		      TOTAlert_BigWarningFrame:Hide(); 
		 end 
	     end 
	 else 
	     alpha = alpha + 0.1; 
	     if (alpha > 1) then
	         alpha = 1; 
		 ShowFlashWarning = 1; 
	     end 
         end 
	 TOTAlert_BigWarningFrame:SetAlpha(alpha); 
    end 
end 

function TOTAlert_BigWarningFrame_Show(message)     
	if (message) then
	   TOTAlert_BigWarningFrame_Text:SetText(message);
        end
        TOTAlert_BigWarningFrame_Text:SetTextColor(TOTAlert_Config.TextColor.r, TOTAlert_Config.TextColor.g, TOTAlert_Config.TextColor.b)
        TOTAlert_BigWarningFrame:Show();
        ShowFlashWarning = nil 
        TOTAlert_BigWarningFrame:SetAlpha(0) 
        flashTimeHold = 0 
        holdTime = 0 
end 

function TOTSMove()             
    if (UnitExists("target")) then 
      local BuffIndex1 = UnitBuff("target", 1) 
      local DeBuffIndex1 = UnitDebuff("target", 1) 
      local BuffIndex7 = UnitDebuff("target", 7) 
      TOTAlertFrame:ClearAllPoints() 
        if (UnitIsFriend("player", "target")) then 
           if (BuffIndex7) then 
              TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrameDebuff7", "BOTTOMLEFT", -4, -3) 
           elseif (DeBuffIndex1) then 
              TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrameDebuff1", "BOTTOMLEFT", -4, -3) 
           elseif (BuffIndex1) then 
              TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrameBuff1", "BOTTOMLEFT", -4, -3) 
           else 
	      TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 1, 30) 
           end 
        else 
	   if (BuffIndex1) then 
              TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrameBuff1", "BOTTOMLEFT", -4, -3) 
           elseif (BuffIndex7) then 
              TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrameDebuff7", "BOTTOMLEFT", -4, -3) 
           elseif (DeBuffIndex1) then 
              TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrameDebuff1", "BOTTOMLEFT", -4, -3) 
           else 
	      TOTAlertFrame:SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 1, 30) 
           end 
        end 
   end 
end 

function TOTAlertDTHM_Mode()
            if (TOTAlertMode[PlayerName] == 0) then       
                TOTAlertMode[PlayerName] = 1;
                TOTAlert_Config.ConfigText.TOTAlertDTHM_Text = "TANK模式";
                DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 已切换到坦克模式",0,1,0);
		TOTAlertDPSFrame:Hide();
                TOTAlertHealerFrame:Hide();
                TOTAlertTankFrame:Show();		
            elseif (TOTAlertMode[PlayerName] == 1) then  
                TOTAlertMode[PlayerName] = 2;
                TOTAlert_Config.ConfigText.TOTAlertDTHM_Text = "治疗者模式";
		TOTAlertDPSFrame:Hide();
                TOTAlertHealerFrame:Show();
                TOTAlertTankFrame:Hide();
                DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 已切换到治疗者模式",1,0,0);    
            elseif (TOTAlertMode[PlayerName] == 2) then
                TOTAlertMode[PlayerName] = 0;
                TOTAlert_Config.ConfigText.TOTAlertDTHM_Text = "DPS模式"
		TOTAlertDPSFrame:Show();
                TOTAlertHealerFrame:Hide();
                TOTAlertTankFrame:Hide();
                DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 已切换到DPS输出者模式",0,0,1);
            end 
end
            
function TOTAlerWarningFont_Mode()   
      if (TOTAlertWarning[PlayerName] == 0) then   
          TOTAlertWarning[PlayerName] = 1; 
          TOTAlert_Config.ConfigText.TOTAlertWarningMod_Text = "醒目报警模式";
          DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的提示信息切换到醒目模式",0,1,0);
      elseif (TOTAlertWarning[PlayerName] == 1) then    
          TOTAlertWarning[PlayerName] = 0;  
          TOTAlert_Config.ConfigText.TOTAlertWarningMod_Text = "普通报警模式";        
          DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的提示信息切换到普通模式",1,0,0);                
       end
end

function TOTAlertMove_Mode()
     if (TOTAlertMove[PlayerName] == 0) then
          TOTAlertMove[PlayerName] = 1
          TOTAlert_Config.ConfigText.TOTAlertMove_Text = "手动移动模式";
          DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的移动模式切换成手动移动模式",0,1,0);
     elseif (TOTAlertMove[PlayerName] == 1) then
          TOTAlertMove[PlayerName] = 0
          TOTAlert_Config.ConfigText.TOTAlertMove_Text = "智能移动模式";
          DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的移动模式切换成智能移动模式",0,1,0);
      end
end

function TOTAlertAlert_Mode()
     if (TOTAlertAlertEnable[PlayerName] == 0) then
         TOTAlertAlertEnable[PlayerName] = 1; 
         TOTAlert_Config.ConfigText.TOTAlertAlert_Text = "启用报警功能";
         DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的报警功能已经关闭",0,1,0);
     elseif (TOTAlertAlertEnable[PlayerName] == 1) then
         TOTAlertAlertEnable[PlayerName] = 0; 
         TOTAlert_Config.ConfigText.TOTAlertAlert_Text = "禁用报警功能";
         DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的报警功能已经打开",0,1,0);
     end
end

function TOTAlertHP_Mode()
     if (TOTAlertHPEnable[PlayerName] == 0) then
         TOTAlertHPEnable[PlayerName] = 1; 
         TOTAlert_Config.ConfigText.TOTAlertHP_Text = "显示TOT百分比";
         DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的百分比功能已经关闭",0,1,0);
     elseif (TOTAlertHPEnable[PlayerName] == 1) then
         TOTAlertHPEnable[PlayerName] = 0; 
         TOTAlert_Config.ConfigText.TOTAlertHP_Text = "隐藏TOT百分比";
         DEFAULT_CHAT_FRAME:AddMessage("TOTAlert 的百分比功能已经打开",0,1,0);
     end
      
end

function TOTAlertFrame_OnClick(arg1)
	if (arg1 == "RightButton") then
	    ToggleDropDownMenu(1, nil, TOTAlertFrameDropDown, "TOTAlertFrame", 0, 5)
	    PlaySound("UChatScrollButton");
	elseif (arg1 == "LeftButton") then            
            TOTAlert_TargetUnit(); 
        end
end

function TOTAlert_CreateDropDown()
	local button = {};
--~ 标题
	button.text = "TOTAlert 正式版" 
	button.isTitle = 1 
	button.notCheckable = 1 
	UIDropDownMenu_AddButton(button)		
--~ 报警模式调节       
	button.text = TOTAlert_Config.ConfigText.TOTAlertDTHM_Text;
	button.func = TOTAlertDTHM_Mode;
	button.isTitle = nil;
	button.disabled = nil;
	UIDropDownMenu_AddButton(button)
--~ 报警字体调节        
	button.text = TOTAlert_Config.ConfigText.TOTAlertWarningMod_Text; 
	button.func = TOTAlerWarningFont_Mode;
	button.isTitle = nil; 
	button.disabled = nil;
	UIDropDownMenu_AddButton(button)
--~ 移动模式调节       
	button.text = TOTAlert_Config.ConfigText.TOTAlertMove_Text;
	button.func = TOTAlertMove_Mode;
	button.isTitle = nil;
	button.disabled = nil;
	UIDropDownMenu_AddButton(button);
--~显示/隐藏目标百分比
        button.text = TOTAlert_Config.ConfigText.TOTAlertHP_Text; 
	button.func = TOTAlertHP_Mode;
	button.isTitle = nil; 
	button.disabled = nil;
	UIDropDownMenu_AddButton(button)
--~启用/禁用报警/选择颜色     
        local TOTalertorgColor = TOTAlert_Setcolor();
        button.text = TOTAlert_Config.ConfigText.TOTAlertAlert_Text 
        button.isTitle = nil;
	button.disabled = nil;
        button.hasColorSwatch = 1 
        button.r = TOTalertorgColor.r 
        button.g = TOTalertorgColor.g 
        button.b = TOTalertorgColor.b 
        button.swatchFunc = TOTAlert_GetColor
        button.func = TOTAlertAlert_Mode
        UIDropDownMenu_AddButton(button)
end

function TOTAlert_Setcolor()  
   if (TOTAlert_Config.TextColor) then 
      return TOTAlert_Config.TextColor 
   else 
      TOTAlert_Config.TextColor = {r = 1.0, g = 0.0, b = 0.0} 
      return TOTAlert_Config.TextColor
   end 
end 

function TOTAlert_GetColor() 
    local r,g,b = ColorPickerFrame:GetColorRGB() 
    TOTAlert_SetPreColor(r, g, b) 
end

function TOTAlert_SetPreColor(R, G, B) 
    if (not TOTAlert_Config.TextColor.TextColor) then 
       TOTAlert_Config.TextColor = {} 
    end 
    TOTAlert_Config.TextColor.r = R 
    TOTAlert_Config.TextColor.g = G 
    TOTAlert_Config.TextColor.b = B 
end
      
function TOTAlertDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, TOTAlert_CreateDropDown, "MENU");	
end