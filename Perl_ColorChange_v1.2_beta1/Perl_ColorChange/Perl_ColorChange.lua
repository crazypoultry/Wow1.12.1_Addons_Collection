Perl_ColorChange = {
	VERSION = "1.2";
	
	DEBUG = 0;
	
	COLORS = {
		RED     = "|cffff0000";
		CYAN    = "|cff00ffff";
		GREEN   = "|cff00ff00";
		YELLOW  = "|cffffff00";
		WHITE   = "|cffffffff";
		BLUE = "|cff0000ff";
	};

	TARGET = {
		OFF = 0;
		ON = 1;
	};
	
	TARGETCOLOR = {
		ALL = 0;
		BORDER = 1;
		MIX = 2 ;
	};
	
	DEBUFF = {
		OFF = 0;
		ON = 1;
	};
	
	DEBUFFCOLOR = {
		ALL = 0;
		BORDER = 1;
		MIX = 2 ;
	};

};

Perl_ColorChangeSaved = { };

Perl_ColorChangeDefaults = {
	
	VERSION = Perl_ColorChange.VERSION;
	
	TARGET = Perl_ColorChange.TARGET.ON;
	
	TARGETCOLOR = Perl_ColorChange.TARGETCOLOR.MIX;
	
	DEBUFF = Perl_ColorChange.DEBUFF.ON;
	
	DEBUFFCOLOR = Perl_ColorChange.DEBUFFCOLOR.MIX;
	
	ALPHA = 1 ;
	
};



function perl_colorChange_Command (msg) 

	local text = string.lower(msg);
	local cmd = { };
	for w in string.gfind(text, "%w+") do
		table.insert(cmd, w);
	end
	
	local command = cmd[1];
	local param = cmd[2];
	
	if(command == "target") then
		if param == "on" or param == "off" then
		  Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_CHANGE_TARGET .. Perl_ColorChange.COLORS.RED .. param);
		  if param == "on" then
		  	Perl_ColorChangeSaved.TARGET = Perl_ColorChange.TARGET.ON ;
		  else
		  	Perl_ColorChangeSaved.TARGET = Perl_ColorChange.TARGET.OFF ;
		  end
		else
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.RED .. PERL_CC_COMMAND) ;
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_TARGET) ;
		end
	elseif(command == "targetcolor") then
		if param == "all" or param == "border" or param == "mix" then
		  Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_CHANGE_TARGETCOLOR .. Perl_ColorChange.COLORS.RED .. param);
		  if param == "all" then
		  	Perl_ColorChangeSaved.TARGETCOLOR = Perl_ColorChange.TARGETCOLOR.ALL ;
		  elseif param == "border" then
		  	Perl_ColorChangeSaved.TARGETCOLOR = Perl_ColorChange.TARGETCOLOR.BORDER ;
		  else
		  	Perl_ColorChangeSaved.TARGETCOLOR = Perl_ColorChange.TARGETCOLOR.MIX ;
		  end
		else
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.RED .. PERL_CC_COMMAND) ;
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_TARGETCOLOR) ;
		end
	elseif(command == "debuff") then
		if param == "on" or param == "off" then
		  Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_CHANGE_DEBUFF .. Perl_ColorChange.COLORS.RED .. param);
		  if param == "on" then
		  	Perl_ColorChangeSaved.DEBUFF = Perl_ColorChange.DEBUFF.ON ;
		  else
		  	Perl_ColorChangeSaved.DEBUFF = Perl_ColorChange.DEBUFF.OFF ;
		  end
		else
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.RED .. PERL_CC_COMMAND) ;
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_DEBUFF) ;
		end
	elseif(command == "debuffcolor") then
		if param == "all" or param == "border" or param == "mix" then
		  Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_CHANGE_DEBUFFCOLOR .. Perl_ColorChange.COLORS.RED .. param);
		  if param == "all" then
		  	Perl_ColorChangeSaved.DEBUFFCOLOR = Perl_ColorChange.DEBUFFCOLOR.ALL ;
		  elseif param == "border" then
		  	Perl_ColorChangeSaved.DEBUFFCOLOR = Perl_ColorChange.DEBUFFCOLOR.BORDER ;
		  else
		  	Perl_ColorChangeSaved.DEBUFFCOLOR = Perl_ColorChange.DEBUFFCOLOR.MIX ;
		  end
		else
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.RED .. PERL_CC_COMMAND) ;
		 Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_DEBUFFCOLOR) ;
		end
	elseif(command == "status") then
		Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_NAME);
		Perl_ColorChange_println(PERL_CC_SEPARATOR);
		
		if Perl_ColorChangeSaved.TARGET == Perl_ColorChange.TARGET.ON then
			param = "on" ;
		elseif Perl_ColorChangeSaved.TARGET == Perl_ColorChange.TARGET.OFF then
			param = "off" ;
		else
			param = "error" ;
		end
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_IS_TARGET .. Perl_ColorChange.COLORS.RED .. param);
		
		if Perl_ColorChangeSaved.TARGETCOLOR == Perl_ColorChange.TARGETCOLOR.ALL then
			param = "all" ;
		elseif Perl_ColorChangeSaved.TARGETCOLOR == Perl_ColorChange.TARGETCOLOR.BORDER then
			param = "border" ;
		elseif Perl_ColorChangeSaved.TARGETCOLOR == Perl_ColorChange.TARGETCOLOR.MIX then
			param = "mix" ;
		else
			param = "error" ;
		end
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_IS_TARGETCOLOR .. Perl_ColorChange.COLORS.RED .. param);
		
		if Perl_ColorChangeSaved.DEBUFF == Perl_ColorChange.DEBUFF.ON then
			param = "on" ;
		elseif Perl_ColorChangeSaved.DEBUFF == Perl_ColorChange.DEBUFF.OFF then
			param = "off" ;
		else
			param = "error" ;
		end
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_IS_DEBUFF .. Perl_ColorChange.COLORS.RED .. param);
		
		if Perl_ColorChangeSaved.DEBUFFCOLOR == Perl_ColorChange.DEBUFFCOLOR.ALL then
			param = "all" ;
		elseif Perl_ColorChangeSaved.DEBUFFCOLOR == Perl_ColorChange.DEBUFFCOLOR.BORDER then
			param = "border" ;
		elseif Perl_ColorChangeSaved.DEBUFFCOLOR == Perl_ColorChange.DEBUFFCOLOR.MIX then
			param = "mix" ;
		else
			param = "error" ;
		end
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_IS_DEBUFFCOLOR .. Perl_ColorChange.COLORS.RED .. param);
		Perl_ColorChange_println(PERL_CC_SEPARATOR);  	
	else
		Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_NAME);
		Perl_ColorChange_println(PERL_CC_SEPARATOR);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_TARGET);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_COMMAND_TARGET_DESC);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_TARGETCOLOR);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_COMMAND_TARGETCOLOR_DESC);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_DEBUFF);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_COMMAND_DEBUFF_DESC);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_DEBUFFCOLOR);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_COMMAND_DEBUFFCOLOR_DESC);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. PERL_CC_COMMAND_STATUS);
		Perl_ColorChange_println(Perl_ColorChange.COLORS.GREEN .. PERL_CC_COMMAND_STATUS_DESC);
		Perl_ColorChange_println(PERL_CC_SEPARATOR);
		
		
	end
end



function Perl_ColorChange_trace(str)
	if not str then
		return ;
	end

	if Perl_ColorChange.DEBUG == 0 then
		return ;
	end

	Perl_ColorChange_println("Perl_ColorChange Debug : " .. Perl_ColorChange.COLORS.RED .. str)
end

function Perl_ColorChange_println(str)
	if not str then
		return ;
	end

	if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(str) ;
	end
end


function Perl_ColorChange_OnLoad()
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_FACTION");
	this:RegisterEvent("VARIABLES_LOADED");

	SLASH_PPC1 = "/perl_cc";
	SLASH_PPC2 = "/perl_colorChange";
	SlashCmdList["PPC"] = perl_colorChange_Command;
	
	Perl_ColorChange_println(Perl_ColorChange.COLORS.YELLOW .. "Perl_ColorChange: Loaded.");
end



function Perl_ColorChange_OnEvent (event)
	
	if event == "VARIABLES_LOADED" then
		
		if (Perl_ColorChangeSaved == nil) or (Perl_ColorChangeSaved.VERSION ~= Perl_ColorChange.VERSION) then
				Perl_ColorChange_println(Perl_ColorChange.COLORS.RED .. "Perl_ColorChange: Loading default settings.");
				Perl_ColorChangeSaved = Perl_ColorChangeDefaults;
				return ;
		end
	end
	
	if event == "PLAYER_TARGET_CHANGED" or event == "UNIT_FACTION" then
		Perl_ColorChange_trace("colorTarget() on event :"..event) ;
    colorTarget () ;
    return ;
  end
  if event == "UNIT_AURA" then
  	local debuffType = getDebuffType (arg1) ;
  	Perl_ColorChange_trace("colorDebufFrame(".. arg1 ..",".. debuffType ..") on event :"..event) ;
  	colorDebufFrame (arg1, debuffType) ;
  	return ;
  end
  	
end

function colorDebufFrame (display, type)
	local r ;
	local v ;
	local b ;
	local rB ;
	local vB ;
	local bB ;
	local a = Perl_ColorChangeSaved.ALPHA ;
	
	if not display then
		return ;
	end

	if type == "none" or not (Perl_ColorChangeSaved.DEBUFF == Perl_ColorChange.DEBUFF.ON) then
	 	r = 0 ;
	 	v = 0 ;
	 	b = 0 ;
	 	rB = 0.5 ;
	 	vB = 0.5 ;
	 	bB = 0.5 ;
	elseif type == "Magic" then
			r = 0.15 ;
			v = 0.15 ;
			b = 0.9 ;
			rB = 0.50 ;
      vB = 0.50;
      bB = 1 ;
	elseif type == "Curse" then
			r = 0.74 ;
			v = 0.15 ;
			b = 0.78 ;
			rB = 0.95 ;
      vB = 0;
      bB = 0.75 ;
	elseif type == "Poison" then
			r = 0 ;
			v = 0.75 ;
			b = 0 ;
			rB = 0 ;
      vB = 0.70;
      bB = 0 ;
	elseif type == "Disease" then
			r = 1 ;
			v = 0 ;
			b = 0 ;
			rB = 1 ;
      vB = 0 ;
      bB = 0 ;
	end
	
	if display == "party1" then
			changeFrameDebuff ("Perl_Party_MemberFrame1", r, v, b, rB, vB, bB, a) ;
  	elseif display == "party2" then
  		changeFrameDebuff ("Perl_Party_MemberFrame2", r, v, b, rB, vB, bB, a) ;
  	elseif display == "party3" then
  		changeFrameDebuff ("Perl_Party_MemberFrame3", r, v, b, rB, vB, bB, a) ;
  	elseif display == "party4" then
  		changeFrameDebuff ("Perl_Party_MemberFrame4", r, v, b, rB, vB, bB, a) ;
  	elseif display == "partypet1" then
  		changeFrameDebuff ("Perl_Party_Pet1", r, v, b, rB, vB, bB, a) ;
  	elseif display == "partypet2" then
  		changeFrameDebuff ("Perl_Party_Pet2", r, v, b, rB, vB, bB, a) ;
  	elseif display == "partypet3" then
  		changeFrameDebuff ("Perl_Party_Pet3", r, v, b, rB, vB, bB, a) ;
  	elseif display == "partypet4" then
  		changeFrameDebuff ("Perl_Party_Pet4", r, v, b, rB, vB, bB, a) ;
  	elseif display == "pet" then
  		changeFrameDebuff ("Perl_Player_Pet", r, v, b, rB, vB, bB, a) ;
  	elseif display == "player" then
			 changeFrameDebuff ("Perl_Player", r, v, b, rB, vB, bB, a) ;
  	else
  		return ;		
		end

end

 function changeFrameDebuff (frame, r, v, b, rB, vB, bB, a)
 	if not frame then
 		return
 	end
 	local portraitFrame = "_PortraitFrame" ;
 	local statsFrame = "_StatsFrame" ;
 	local levelFrame = "_LevelFrame" ;
 	local nameFrame = "_NameFrame" ;
 	
  	if Perl_ColorChangeSaved.DEBUFFCOLOR == Perl_ColorChange.DEBUFFCOLOR.MIX then
		  	changeBackdrop (getglobal(frame..portraitFrame)) ;
			  changeColorBackdropBorder (getglobal(frame..portraitFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..portraitFrame), r, v, b, a);
				
			  changeColorBackdropBorder (getglobal(frame..statsFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..statsFrame), 0, 0, 0, a);
				
				changeColorBackdropBorder (getglobal(frame..levelFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..levelFrame), 0, 0, 0, a);
				
				changeColorBackdropBorder (getglobal(frame..nameFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..nameFrame), 0, 0, 0, a);
				
			elseif Perl_ColorChangeSaved.DEBUFFCOLOR == Perl_ColorChange.DEBUFFCOLOR.ALL then
				changeBackdrop (getglobal(frame..portraitFrame)) ;
			  changeColorBackdropBorder (getglobal(frame..portraitFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..portraitFrame), r, v, b, a);
				
				changeBackdrop (getglobal(frame..statsFrame)) ;
			  changeColorBackdropBorder (getglobal(frame..statsFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..statsFrame), r, v, b, a);
				
				changeBackdrop (getglobal(frame..levelFrame)) ;
			  changeColorBackdropBorder (getglobal(frame..levelFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..levelFrame), r, v, b, a);
				
				changeBackdrop (getglobal(frame..nameFrame)) ;
			  changeColorBackdropBorder (getglobal(frame..nameFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..nameFrame), r, v, b, a);
			  
			elseif Perl_ColorChangeSaved.DEBUFFCOLOR == Perl_ColorChange.DEBUFFCOLOR.BORDER then
			 	changeColorBackdropBorder (getglobal(frame..portraitFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..portraitFrame), 0, 0, 0, a);
				
				changeColorBackdropBorder (getglobal(frame..statsFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..statsFrame), 0, 0, 0, a);
				
				changeColorBackdropBorder (getglobal(frame..levelFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..levelFrame), 0, 0, 0, a);
				
				changeColorBackdropBorder (getglobal(frame..nameFrame), rB, vB, bB, a);
			  changeColorBackdrop (getglobal(frame..nameFrame), 0, 0, 0, a);
	
			end 
			
end


function getDebuffType (t)
	local type ;
	for i=1, MAX_PARTY_TOOLTIP_DEBUFFS do
	      _, _, tempType = UnitDebuff(t, i) ;
	      if tempType then
	        type = tempType ;
	      end 
	end
	if not type then
		type = "none" ;
	end
	
	return type ;
end

function colorTarget ()
	
	local r = 0;
	local v = 0;
	local b = 0;
	local a = Perl_ColorChangeSaved.ALPHA ;
	local rB=0.5 ;
	local vB=0.5 ;
	local bB=0.5 ;
	local p = "player" ;
	local t = "target" ;
	local status = UnitReaction(p,t) ;
	

	if (Perl_ColorChangeSaved.TARGET == Perl_ColorChange.TARGET.ON) and UnitExists(t) and status then
		if status <= 3 then
		  r=1;
		  v=0;
		  b=0;
		  rB=1;
		  vB=0;
		  bB=0;
		end
		if status == 4 then
		  r=1;
		  v=1;
		  b=0;
		  rB=1 ;
			vB=1 ;
			bB=0 ;
		end
		if status >= 5 then
		  r=0;
		  v=0.75;
		  b=0;
		  rB=0 ;
			vB=0.75 ;
			bB=0 ;
		end
	end
	  if Perl_ColorChangeSaved.TARGETCOLOR == Perl_ColorChange.TARGETCOLOR.MIX then
	  	
	  	changeBackdrop (Perl_Target_PortraitFrame) ;
		  changeColorBackdropBorder (Perl_Target_PortraitFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_PortraitFrame, r, v, b, a);
			

		  changeColorBackdropBorder (Perl_Target_StatsFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_StatsFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_ClassNameFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_ClassNameFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_LevelFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_LevelFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_NameFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_NameFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_RareEliteFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_RareEliteFrame, 0, 0, 0, a);
			
		elseif Perl_ColorChangeSaved.TARGETCOLOR == Perl_ColorChange.TARGETCOLOR.ALL then
		
			changeBackdrop (Perl_Target_PortraitFrame) ;
		  changeColorBackdropBorder (Perl_Target_PortraitFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_PortraitFrame, r, v, b, a);
			
			changeBackdrop (Perl_Target_StatsFrame) ;
		  changeColorBackdropBorder (Perl_Target_StatsFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_StatsFrame, r, v, b, a);
			
			changeBackdrop (Perl_Target_ClassNameFrame) ;
		  changeColorBackdropBorder (Perl_Target_ClassNameFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_ClassNameFrame, r, v, b, a);
			
			changeBackdrop (Perl_Target_LevelFrame) ;
		  changeColorBackdropBorder (Perl_Target_LevelFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_LevelFrame, r, v, b, a);
			
			changeBackdrop (Perl_Target_NameFrame) ;
		  changeColorBackdropBorder (Perl_Target_NameFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_NameFrame, r, v, b, a);
			
			changeBackdrop (Perl_Target_RareEliteFrame) ;
		  changeColorBackdropBorder (Perl_Target_RareEliteFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_RareEliteFrame, r, v, b, a);
		  
		elseif Perl_ColorChangeSaved.TARGETCOLOR == Perl_ColorChange.TARGETCOLOR.BORDER then
		
		 	changeColorBackdropBorder (Perl_Target_PortraitFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_PortraitFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_StatsFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_StatsFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_ClassNameFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_ClassNameFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_LevelFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_LevelFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_NameFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_NameFrame, 0, 0, 0, a);
			
			changeColorBackdropBorder (Perl_Target_RareEliteFrame, rB, vB, bB, a);
		  changeColorBackdrop (Perl_Target_RareEliteFrame, 0, 0, 0, a);
		end
end



function changeBackdrop (frame)
	if frame then
		frame:SetBackdrop(
				{
					bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	        edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	        tile = true, tileSize = 32, edgeSize = 20, 
	        insets = { 
	        	left = 5, 
	        	right = 5, 
	        	top = 5, 
	        	bottom = 5 
	        }
	       }
	       );
	end
end

function changeColorBackdropBorder (frame, r, v ,b ,a)
	if frame then
		frame:SetBackdropBorderColor(r, v, b, a);
	end
end

function changeColorBackdrop (frame, r, v ,b ,a)
	if frame then
		frame:SetBackdropColor(r, v, b, a);
	end
end