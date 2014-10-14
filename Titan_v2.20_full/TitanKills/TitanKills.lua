--Kills To Level : Titan Enabled
--Craig Willis
--17/05/05

local TITAN_KTL_ID = "KTL";

KTL_Version="0.46";
KTL_Frame = 2;
KTL_State = 1;
KTL_AvgCalc = 0;
KTL_AvgKills = 0;
KTL_RK	= 0;
KTL_NK  = 0;
KTL_Q	= 0;
KTL_LABEL = TITAN_KTL_BUTTON_LABEL;
KTL_STRING = "";
KTL_QUEST_STATE = 1;

local usingT = 0;
local KTL_XP;
local KTL_MAXXP; --Needed to remove calc error when leveling
local KTL_LITTLE_R = 0;  --Needed to remove calc error when low rested.
local KTL_COMBAT = 0;
local KTL_SMALL = 0;

KTL_CHAT_FRAME = getglobal("ChatFrame"..KTL_Frame);

function TitanPanelKTLButton_OnLoad()
	this.registry = {
		id = TITAN_KTL_ID,
		menuText = TITAN_KTL_MENU_TEXT,
		buttonTextFunction = "TitanPanelKTLButton_GetButtonText", 
		tooltipTitle = TITAN_KTL_TOOLTIP, 
		savedVariables = {
			ShowLabelText = 1,
		}
	};	
	usingT=1;

	SlashCmdList["KILLCOMMAND"] = KillMod_SlashHandler;
	SLASH_KILLCOMMAND1 = "/kills";
	SLASH_KILLCOMMAND1 = "/ktl";

	KTL_XP = UnitXP("player"); -- EMERALD (lowercased "player")
	KTL_MAXXP = UnitXPMax("player");
	this:RegisterEvent("VARIABLES_LOADED");  --Set hook if needed and check chat frame
	this:RegisterEvent("PLAYER_XP_UPDATE");
  this:RegisterEvent("QUEST_FINISHED");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_LOADED,KTL_Version));
	end
end

function TitanPanelKTLButton_OnEvent()
  if(event == "VARIABLES_LOADED") then
	  StatusShow();
  elseif(event == "PLAYER_XP_UPDATE") then
	  KillMod_XPChange();
  elseif(event == "QUEST_FINISHED") then
	  if(KTL_QUEST_STATE==0) then
      KillMod_QuestDone();
    end
  elseif(event == "PLAYER_LEAVE_COMBAT") then
	  if(KTL_QUEST_STATE==0) then
      KillMod_CombatDone();
    end
  else
	  DEFAULT_CHAT_FRAME:AddMessage("Unregistered event: "..event);
  end
	TitanPanelButton_UpdateButton(TITAN_KTL_ID);		
end

function TitanPanelKTLButton_GetButtonText(id)
	local count, labelText, valueText;
	labelText = KTL_LABEL;
     if (KTL_COMBAT == 0) then	
        if (KTL_RK == 0) then
	   --No rested kills
	   if (KTL_NK == 0) then
	    --No Normal Kills, No Rested, Blank Info
	    --valueText = "Blank";
		valueText = "?"; -- EMERALD
	  else
	    --Normal Only
	    valueText = format(TITAN_KTL_BUTTON_TEXT_N, KTL_NK);
	  end
	else
	  --Rested Kills
	  if (KTL_NK == 0) then
	    --No Normal Kills, Rested Only
	    valueText = format(TITAN_KTL_BUTTON_TEXT_R, KTL_RK);
	  else
	    --Normal and Rested Kills
	    valueText = format(TITAN_KTL_BUTTON_TEXT_R_N, KTL_RK, KTL_NK);
	  end
	end;
     elseif (KTL_COMBAT == 1) then
        valueText = format(TITAN_KTL_BUTTON_TEXT_Q, KTL_Q);
     end
	return labelText, TitanUtils_GetHighlightText(valueText);
end


function TitanPanelRightClickMenu_PrepareKTLMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_KTL_ID].menuText);

	local info = {};
	
	info.text = KTL_HELP;
	info.value = "";
	info.func = KillMod_SlashHandler;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	

	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_KTL_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_KTL_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelKTLButton_OnClick(button)
	if ( button == "LeftButton" ) then -- EMERALD
    if(KTL_SMALL == 0) then --Large Lables
			KTL_SMALL = 1; 
      if(KTL_COMBAT == 0) then --Combat labels  
        KTL_LABEL = TITAN_KTL_BUTTON_LABEL;          
      elseif(KTL_COMBAT == 1) then --Quest Labels
        KTL_LABEL = TITAN_KTL_BUTTON_QUEST_LABEL;  
      end		
		elseif(KTL_SMALL == 1) then --Small Lables
			KTL_SMALL = 0;
      if(KTL_COMBAT == 0) then --Combat labels
        KTL_LABEL = TITAN_KTL_BUTTON_SMALL_LABEL;             
      elseif(KTL_COMBAT == 1) then --Quest Labels
        KTL_LABEL = TITAN_KTL_BUTTON_SMALL_QUEST_LABEL;
      end
		end
    TitanPanelButton_UpdateButton(TITAN_KTL_ID);
	end
end

--KTL functions

function KillMod_OnLoad()
	if (usingT==0) then
 
  	SlashCmdList["KILLCOMMAND"] = KillMod_SlashHandler;
	  SLASH_KILLCOMMAND1 = "/kills";
	  SLASH_KILLCOMMAND1 = "/ktl";

	  KTL_XP = UnitXP("player"); -- EMERALD (lowercased "player")
	
	  this:RegisterEvent("VARIABLES_LOADED");  --Set hook if needed and check chat frame
	  this:RegisterEvent("PLAYER_XP_UPDATE");
	  this:RegisterEvent("QUEST_FINISHED");
    this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	
	  if( DEFAULT_CHAT_FRAME ) then
	  	DEFAULT_CHAT_FRAME:AddMessage(format(KTL_LOADED,KTL_Version));
	  end
        end
end

function KillMod_OnEvent()
   if (usingT==0) then  
     if(event == "VARIABLES_LOADED") then
	StatusShow();
     elseif(event == "PLAYER_XP_UPDATE") then
	KillMod_XPChange();
     elseif(event == "QUEST_FINISHED") then
	if(KTL_QUEST_STATE==0) then
           KillMod_QuestDone();
        else
        end
     elseif(event == "PLAYER_LEAVE_COMBAT") then
	if(KTL_QUEST_STATE==0) then
           KillMod_CombatDone();
        else
        end
     else
	DEFAULT_CHAT_FRAME:AddMessage("Unregistered event: "..event);
     end
   end
end

function KillMod_QuestDone()
   KTL_COMBAT=1;
end

function KillMod_CombatDone()
   KTL_COMBAT=0;
end

function KillMod_XPChange()
   
   local cXp;    
   cXp = UnitXP("player"); -- EMERALD (lowercased "player")

   if (KTL_State > 0) then
     local xpDif;
     local xp2level;
     local restedKill;
     local ktl;
     local rested;
     local typestring;

     if (KTL_State == 2) then
         typestring = KTL_AVG;
     elseif (KTL_State == 6) then
	 typestring = KTL_DEB;
     else
	 typestring = KTL_EXACT;
     end;     --That just told the mod which text to display, depending on the mod your in
     
     xpDif = cXp - KTL_XP;  --Easy to understand, new xp minus old xp.
     if (xpDif < 0) then
	xpDif = (KTL_MAXXP - KTL_XP) + cXp; --Should be correct xp change now.
     end
     if (KTL_LITTLE_R > 0) then
        if (KTL_COMBAT == 0) then
          xpDif = xpDif - KTL_LITTLE_R;
          KTL_LITTLE_R = 0;
        end
     end

     xp2level = UnitXPMax("player") - cXp;  --Easy again.
     restedKill = xpDif/2;  --Half the change is always rested, even in a group.  Only case where it isn't, is when 
     ktl = xp2level/xpDif;  --Simple again
     if(KTL_COMBAT == 1) then
       KTL_Q = ktl;
       if (KTL_State == 3) then
	       --Titan Bar only, dont update to channel
       else
		KTL_CHAT_FRAME:AddMessage(format(KTL_QUEST, ktl), 1.0, 1.0, 0.0);
       end;
     else

     rested = GetXPExhaustion();
       
       if (rested == nil) then rested = 0; 
       end
       
       if (rested > 0) then
          
         
   

         if (restedKill*ktl > rested) then 
	    if (rested < xpDif) then
		KTL_LITTLE_R = rested;
	    end
            local normxp = UnitXPMax("player") - (cXp+rested);  --How many of the kills will be Normal
	    local numrkills = rested/xpDif;   
	    KTL_RK = ceil(numrkills);
	    KTL_NK = normxp/restedKill;
	    KTL_NK = ceil(KTL_NK);
	    if (KTL_State == 3) then
	       --Titan Bar only, dont update to channel
	    else
		KTL_CHAT_FRAME:AddMessage(format(KTL_REST_NORM, KTL_RK, KTL_NK, typestring), 1.0, 1.0, 0.0);
	    end;
	    --remainingxp divided by half of the xp you recieved gives you the normal kills
          else
	    KTL_RK=ceil(ktl);
	    KTL_NK=0;
	    if (KTL_State == 3) then
	       --Titan Bar only, dont update to channel
	    else
               KTL_CHAT_FRAME:AddMessage(format(KTL_REST, KTL_RK, typestring), 1.0, 1.0, 0.0);
	    end
          end
     
       else
          KTL_RK=0;
	  KTL_NK=ceil(ktl);
          if (KTL_State == 3) then
	       --Titan Bar only, dont update to channel
	  else
             KTL_CHAT_FRAME:AddMessage(format(KTL_NORM, KTL_NK, typestring), 1.0, 1.0, 0.0);
	  end
       end
     end  
   end 

    KTL_XP = cXp;
    KTL_MAXXP = UnitXPMax("player");
	
end

function StatusShow()
	DEFAULT_CHAT_FRAME:AddMessage(format(KTL_VERSION..".",KTL_Version));
	local frametype;
	if (KTL_Frame == 2) then
	  frametype = KTL_COMBAT_FRAME;
        elseif (KTL_Frame == 1) then
          frametype = KTL_GENERAL_FRAME;
        end
        DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_FRAME,frametype));
	if (KTL_State == 0) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_OFF));
	elseif (KTL_State == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
	elseif (KTL_State == 2) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_AVERAGE));
	elseif (KTL_State == 3) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_TITAN));
	elseif (KTL_State == 6) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_DEBUG));
	end
        if (KTL_QUEST_STATE == 0) then
                DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_ON));
        else
                DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_OFF));
        end
                
end

function KillMod_SlashHandler(msg)
	local index, value;
	if (not msg or msg == "") then --Show Help
		for index, value in KTL_HELP_TEXT do
			DEFAULT_CHAT_FRAME:AddMessage(value);
		end		
	else
		local command=strlower(msg);
		if (command == KTL_STATUS) then
			StatusShow();
		elseif (command == KTL_ON) then
			KTL_State = 1;
			DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
		elseif (command == KTL_OFF) then
			KTL_State = 0;
			DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_OFF));
		elseif (command == KTL_HELP) then  --Show Help, again
			for index, value in KTL_HELP_TEXT do
			    DEFAULT_CHAT_FRAME:AddMessage(value);
			end
		elseif (command == KTL_SLASH_FRAME) then  --Change KTl Frame
			--Dunno how to yet, so just toggling
			if (KTL_Frame == 2) then
				KTL_Frame = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_FRAME,KTL_GENERAL_FRAME));
			else
				KTL_Frame = 2;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_FRAME,KTL_COMBATL_FRAME));
			end
		elseif (command == KTL_DEBUG) then  --toggle debug
			if (KTL_State == 6) then
				KTL_State = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
			else
				KTL_State = 6;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_DEBUG));
			end
		elseif (command == KTL_AVERAGE) then --toggle average
			if (KTL_State == 2) then
				KTL_State = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
			else
				KTL_State = 2;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_AVERAGE));
			end
		elseif (command == KTL_TITAN) then --toggle Titan only mode
			if (KTL_State == 3) then
				KTL_State = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
			else
				KTL_State = 3;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_TITAN));
			end
		elseif (command == KTL_QUEST_O) then --toggle Titan Quest mode
			if (KTL_QUEST_STATE == 1) then
				KTL_QUEST_STATE = 0;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_ON));
			else
				KTL_QUEST_STATE = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_OFF));
			end
		end			
	end
end

