--[[

pa_mouse.lua
Mouse Support for Panza

UI Files that use this data:
PanzaPMM.xml
PanzaPMM.lua

Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

--------------------------
-- Save original functions
--------------------------
function PA:InitClickMode()
	
	-- CTRA frame support
	if ( type(CT_RA_AssistMTTT) == "function") then 
		PANZA_CTRA_CustomOnClickFunction = 	CT_RA_CustomOnClickFunction;
		PA.PMMSupport["CTRA"]=true;
	else
		PA.PMMSupport["CTRA"]=false;
	end	
	
	-- Blizzard Player frame support
	if (type(PlayerFrame_OnClick) == "function") then 
			PlayerFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PANZA_PlayerFrame_OnClick = PlayerFrame_OnClick;
			PA.PMMSupport["Bliz_Player"]=true;
	else
		PA.PMMSupport["Bliz_Player"]=false;	
	end	
		
	-- Blizz party frame support
	if ( type(PartyMemberFrame_OnClick) == "function" ) then 
			PartyMemberFrame1:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PartyMemberFrame2:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PartyMemberFrame3:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PartyMemberFrame4:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");	
			PANZA_PartyMemberFrame_OnClick=PartyMemberFrame_OnClick;
			PA.PMMSupport["Bliz_Party"]=true;
	else
		PA.PMMSupport["Bliz_Party"]=false;
	end
		
	-- Blizz pet frame support
	if ( type(PartyMemberPetFrame_OnClick) == "function" ) then 
			PartyMemberFrame1PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PartyMemberFrame2PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PartyMemberFrame3PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PartyMemberFrame4PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
			PANZA_PartyMemberPetFrame_OnClick=PartyMemberPetFrame_OnClick; 
			PA.PMMSupport["Bliz_Pet"]=true;
	else
		PA.PMMSupport["Bliz_Pet"]=false;
	end
				
	-- Bliz target frame support
	if ( type(TargetFrame_OnClick) == "function" ) then
		TargetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up");
		PANZA_TargetFrame_OnClick=TargetFrame_OnClick;
		PA.PMMSupport["Bliz_Target"]=true;
	else
		PA.PMMSupport["Bliz_Target"]=false;
	end
		
	-- Discord Unit Frame Support
	if ( type(DUF_UnitFrame_OnClick) == "function" ) then 
		PANZA_DUF_UnitFrame_OnClick=DUF_UnitFrame_OnClick; 
		PA.PMMSupport["DUF"]=true;
	else
		PA.PMMSupport["DUF"]=false;
	end	
	if ( type(DUF_Element_OnClick) == "function" ) then 
		PANZA_DUF_Element_OnClick=DUF_Element_OnClick; 
		PA.PMMSupport["DUF"]=true;
	end		

	-- Perl Frames
	if ( type(Perl_Target_Set_Transparency) == "function" or (type(XPerl_Globals_OnEvent) == "function")) then 
		if (type(Perl_Custom_ClickFunction) =="function") then
			PANZA_Perl_CustomOnClickFunction = 	Perl_Custom_ClickFunction;
		end	
		PA.PMMSupport["PERL"]=true;
	else
		PA.PMMSupport["PERL"]=false;
	end	

	-- AG Unit Frames
	if (aUF~=nil and type(aUF.classes.aUFunit.prototype.OnClick) == "function") then 
		aUF.classes.aUFunit.prototype.OnClickOld = aUF.classes.aUFunit.prototype.OnClick;
		PA.PMMSupport["AG"]=true;
	else
		PA.PMMSupport["AG"]=false;
	end	
	
	-- oRA Frames Support
	if (oRA_MainTankFrames or oRADB) then
		if (type(oRA_MainTankFramesCustomClick) == "function") then
			PANZA_oRA_MainTankFramesCustomClick = oRA_MainTankFramesCustomClick;
		end
		PA.PMMSupport["ORA"]=true;
	else
		PA.PMMSupport["ORA"]=false;
	end	
		
	-- Satrina Frames
	if ( type(SatrinaPlayerFrame_OnClick) == "function") then
		getglobal("SatrinaPlayerFrame"):RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		getglobal("SatrinaPetFrame"):RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		getglobal("SatrinaPartyMember1Button"):RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		getglobal("SatrinaPartyMember2Button"):RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		getglobal("SatrinaPartyMember3Button"):RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		getglobal("SatrinaPartyMember4Button"):RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		getglobal("SatrinaTargetFrame"):RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		PANZA_SatrinaPlayerFrame_OnClick = SatrinaPlayerFrame_OnClick;
		PANZA_SatrinaPetFrame_OnClick = SatrinaPetFrame_OnClick;
		PANZA_SatrinaPartyMemberFrame_OnClick = SatrinaPartyMemberFrame_OnClick;
		PANZA_SatrinaTargetFrame_OnClick = SatrinaTargetFrame_OnClick;
		PA.PMMSupport["SATRINA"]=true;
	else
		PA.PMMSupport["SATRINA"]=false;
	end

	-- Sage Frames
	if ( type(	SFrame_OnClick) == "function" ) then
		PANZA_SFrame_OnClick = SFrame_OnClick;
		PA.PMMSupport["SAGE"]=true;
	else
		PA.PMMSupport["SAGE"]=false;
	end
		
	-- PerfectRaid
	if (PerfectRaid) then 
		PANZA_PerfectRaidCustomClick=PerfectRaidCustomClick;
		PA.PMMSupport["PERFECT"]=true;
	else
		PA.PMMSupport["PERFECT"]=false;
	end
	
	-- Easy Raid
	if (ER_UnitFrameDropDown) then
		if (type(ER_RaidPulloutButton_OnClick) == "function") and (type(ER_MainTankButton_OnClick) == "function") then
	         PANZA_ER_RaidPulloutButton_OnClick = ER_RaidPulloutButton_OnClick;
	         PANZA_ER_MainTankButton_OnClick = ER_MainTankButton_OnClick;
		end
		PA.PMMSupport["ER"]=true;
	else
		PA.PMMSupport["ER"]=false;
	end
	
	-- Squishy Emergency Monitor
	if (Squishy) then 
		PANZA_SquishyCustomClick=SquishyCustomClick;
		PA.PMMSupport["SQUISHY"]=true;
	else
		PA.PMMSupport["SQUISHY"]=false;
	end
	
	PA.MouseInitialized=true;
end

------------------------------------------------------------
-- Called when using the global enable/disable switch in PMM
------------------------------------------------------------
function PA:PMM_ToggleFrames(enable)
	for key, value in pairs(PA.PMMSupport) do
		--PA:ShowText(key);
		getglobal("cbxPanzaPMM_"..key):SetChecked(enable);
		if (enable==false) then
			getglobal("cbxPanzaPMM_"..key):Disable();
		else
			getglobal("cbxPanzaPMM_"..key):Enable();
		end	
		PASettings.PMM[key]=enable;
	end
	PA:setClickMode(enable)
end	

-------------------------------		
-- Override supported functions
-------------------------------
function PA:setClickMode(enable)
	
	if (PA.MouseInitialized==false) then 
		return;
	end	
	
	if (enable==true) then
	
		if (PASettings.PMM.CTRA==true) then
			CT_RA_CustomOnClickFunction=function(button,unit) 
				return PA:CTRA_OnClick(button,unit) 
				end		
		end
		
		if (PASettings.PMM.ORA==true) then
			oRA_MainTankFramesCustomClick=function(button,unit) 
				return PA:oRA_OnClick(button,unit) 
				end		
		end
		
		if (PASettings.PMM.PERL==true) then
			Perl_Custom_ClickFunction=function(button,unit)
				return PA:PERL_OnClick(button,unit)
				end
		end
		
		if (PASettings.PMM.AG==true and aUF~=nil) then
			aUF.classes.aUFunit.prototype.OnClick=function(button,unit)
				return PA:AG_OnClick(button,unit)
				end
		end
		
		if (PASettings.PMM.PERFECT==true) then
			PerfectRaidCustomClick=function(button,unit)
				return PA:PERFECT_OnClick(button,unit)
				end
		end
		
		if (PASettings.PMM.SQUISHY==true) then
			SquishyCustomClick=function(button,unit)
				return PA:SQUISHY_OnClick(button,unit)
				end
		end
		
		if (PASettings.PMM.ER==true) then
			ER_RaidPulloutButton_OnClick=function()
				return PA:ER_RaidOnClick()
				end
			ER_MainTankButton_OnClick=function()
				return PA:ER_MTOnClick()
				end
		end
		
		if (PASettings.PMM.SATRINA==true) then
			SatrinaPlayerFrame_OnClick=function(button)
				return PA:SatrinaPlayerFrame_OnClick(button)
				end
			SatrinaPetFrame_OnClick=function(button)
				return PA:SatrinaPetFrame_Onclick(button)
				end
			SatrinaPartyMemberFrame_OnClick=function(button)
				return PA:SatrinaPartyMemberFrame_OnClick(button)
				end
			SatrinaTargetFrame_OnClick=function(button)
				return PA:SatrinaTargetFrame_OnClick(button)
				end
		end
				
		if (PASettings.PMM.SAGE==true) then
			SFrame_OnClick=function()
				return PA:SFrame_OnClick()
				end
		end
		
		if (PASettings.PMM.Bliz_Player==true) then
			PlayerFrame_OnClick=function(button)
				return PA:PlayerFrame_OnClick(button)
				end
		end			
					
		if (PASettings.PMM.Bliz_Party==true) then			
			PartyMemberFrame_OnClick=function(partyFrame)							
				return PA:PartyMemberFrame_OnClick(partyFrame)
				end
		end
		
		if (PASettings.PMM.Bliz_Pet==true) then
			PartyMemberPetFrame_OnClick=function()
				return PA:PartyMemberPetFrame_OnClick()
				end
		end
		
		if (PASettings.PMM.Bliz_Target==true) then
			TargetFrame_OnClick=function()
				return PA:TargetFrame_OnClick()
				end
		end
		
		if (PASettings.PMM.DUF==true) then
			DUF_UnitFrame_OnClick=function(button)
				return PA:DUF_UnitFrame_OnClick(button)
				end
						
			DUF_Element_OnClick=function(button)
				return PA:DUF_Element_OnClick(button)
				end
		end			
		
	else
	
		-- reset to original function
		if (PASettings.PMM.CTRA==false) then
			if (type(PANZA_CTRA_CustomOnClickFunction)=="function") then
				CT_RA_CustomOnClickFunction=PANZA_CTRA_CustomOnClickFunction;
			end	
		end
		
		if (PASettings.PMM.ORA==false) then
			if (type(PANZA_oRA_CustomOnClickFunction)=="function") then
				oRA_MainTankFramesCustomClick=PANZA_oRA_MainTankFramesCustomClick;
			end	
		end
		
		if (PASettings.PMM.PERL==false) then
			if (type(PANZA_PERL_CustomOnClickFunction)=="function") then
				Perl_Custom_Click_Function=PANZA_PERL_CustomOnClickFunction;
			end	
		end
		
		if (PASettings.PMM.AG==false) then
			if (aUF~=nil and type(PANZA_AG_CustomOnClickFunction)=="function") then
				aUF.classes.aUFunit.prototype.OnClick=aUF.classes.aUFunit.prototype.OnClickOld
			end	
		end
		
		if (PASettings.PMM.PERFECT==false) then
			if (type(PANZA_PerfectRaidCustomClick)=="function") then
				PerfectRaidCustomClick=PANZA_PerfectRaidCustomClick;
			end	
		end

		if (PASettings.PMM.SQUISHY==false) then
			if (type(PANZA_SquishyCustomClick)=="function") then
				SquishyCustomClick=PANZA_SquishyCustomClick;
			end	
		end

		if (PASettings.PMM.ER==false) then
			if (type(PANZA_ER_RaidPulloutButton_OnClick)=="function") then
				ER_RaidPulloutButton_OnClick=PANZA_ER_RaidPulloutButton_OnClick;
			end
			if (type(PANZA_ER_MainTankButton_OnClick)=="function") then
				ER_MainTankButton_OnClick=PANZA_ER_MainTankButton_OnClick;
			end			
		end
		
		if (PASettings.PMM.SATRINA==false) then
			if (type(PANZA_SatrinaPlayerFrame_OnClick)=="function") then
				SatrinaPlayerFrame_OnClick=PANZA_SatrinaPlayerFrame_OnClick;
			end	
			if (type(PANZA_SatrinaPetFrame_OnClick)=="function") then
				SatrinaPetFrame_OnClick=PANZA_SatrinaPetFrame_OnClick;
			end	
			if (type(PANZA_SatrinaPartyMemberFrame_OnClick)=="function") then
				SatrinaPartyMemberFrame_OnClick=PANZA_SatrinaPartyMemberFrame_OnClick;
			end	
			if (type(PANZA_SatrinaTargetFrame_OnClick)=="function") then
				SatrinaTargetFrame_OnClick=PANZA_SatrinaTargetFrame_OnClick;
			end		
		end
		
		if (PASettings.PMM.SAGE==false) then
			if (type(PANZA_SFrame_OnClick)=="function") then
				SFrame_OnClick=PANZA_SFrame_OnClick;
			end
		end
		
		if (PASettings.PMM.Bliz_Player==false) then
			if (type(PANZA_PlayerFrame_OnClick)=="function") then
				PlayerFrame_OnClick=PANZA_PlayerFrame_OnClick;
			end	
		end	
		
		if (PASettings.PMM.Bliz_Party==false) then
			if (type(PANZA_PartyMemberFrame_OnClick)=="function") then
				PartyMemberFrame_OnClick=PANZA_PartyMemberFrame_OnClick;
			end	
		end
		
		if (PASettings.PMM.Bliz_Pet==false) then
			if (type(PANZA_PartyMemberPetFrame_OnClick)=="function") then
				PartyMemberPetFrame_OnClick=PANZA_PartyMemberPetFrame_OnClick;
			end	
		end	
		
		if (PASettings.PMM.Bliz_Target==false) then
			if (type(PANZA_TargetFrame_OnClick)=="function") then
				TargetFrame_OnClick=PANZA_TargetFrame_OnClick;
			end			
		end	
		
		if (PASettings.PMM.DUF==false) then
			if (type(PANZA_DUF_UnitFrame_OnClick)=="function") then
				DUF_UnitFrame_OnClick=PANZA_DUF_UnitFrame_OnClick;
			end	
			if (type(PANZA_DUF_Element_OnClick)=="function") then
				DUF_Element_OnClick=PANZA_DUF_Element_OnClick;
			end	
		end	
	end
end

-- Discord Unit Frames
function PA:DUF_Element_OnClick(button)
	
	local unit = this.unit;
	if (not unit) then unit = this:GetParent().unit;
	end

	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,unit);
	elseif ( type(PANZA_DUF_UnitFrame_OnClick)=="function") then return PANZA_DUF_Element_OnClick(button); end
	
end

-- Discord Unit Frames
function PA:DUF_UnitFrame_OnClick(button)
	
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,this.unit);
	elseif ( type(PANZA_DUF_UnitFrame_OnClick)=="function") then return PANZA_DUF_UnitFrame_OnClick(button); end
	
end

-- Bliz Party
function PA:PartyMemberFrame_OnClick(partyFrame)
	if ( not partyFrame ) then
		partyFrame = this;
	end
	local unit = "party"..partyFrame:GetID();
	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then PA:MouseClick(KeyDownType..arg1, unit)
	elseif ( type(PANZA_PartyMemberFrame_OnClick)=="function") then  return PANZA_PartyMemberFrame_OnClick(partyFrame); end
end

-- Bliz Pet
function PA:PartyMemberPetFrame_OnClick()
	
	local unit = "partypet"..this:GetParent():GetID();
	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then
		PA:MouseClick(KeyDownType..arg1,unit)
	elseif ( type(PANZA_PartyMemberPetFrame_OnClick)=="function") then 
		return PANZA_PartyMemberPetFrame_OnClick()
	end
	
end

-- Bliz Player
function PA:PlayerFrame_OnClick(button)
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then
		PA:MouseClick(KeyDownType..button, "player")
	elseif ( type(PANZA_PlayerFrame_OnClick)=="function") then 
		return PANZA_PlayerFrame_OnClick(button)
	end
end

-- Bliz Target
function PA:TargetFrame_OnClick()
	if ( not targetFrame ) then
		targetFrame = this;
	end
	local unit = "target";
	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then PA:MouseClick(KeyDownType..arg1, unit)
	elseif ( type(PANZA_TargetFrame_OnClick)=="function") then  return PANZA_TargetFrame_OnClick(); end
end


-- CTRA
function PA:CTRA_OnClick(button,unit)

	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then
		PA:MouseClick(KeyDownType..button,unit);
		return true;
	elseif (type(PANZA_CTRA_CustomOnClickFunction)=="function") then 
		return PANZA_CTRA_CustomOnClickFunction(button,unit);
	else 
		return false;
	end
end

-- Perl Frames
function PA:PERL_OnClick(button,unit)

	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then
		PA:MouseClick(KeyDownType..button,unit);
		return true;
	elseif (type(PANZA_PERL_CustomOnClickFunction)=="function") then 
		return PANZA_PERL_CustomOnClickFunction(button,unit);
	else 
		return false;
	end
end

-- oRA/oRA2 Frames
function PA:oRA_OnClick(button,unit)

	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then
		PA:MouseClick(KeyDownType..button,unit);
		return true;
	elseif (type(PANZA_oRA_MainTankFramesCustomClick)=="function") then 
		return PANZA_oRA_MainTankFramesCustomClick(button,unit);
	else 
		return false;
	end
end

-- AG Frames
function PA:AG_OnClick(window, button)
	unit = this.unit;
	
	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then
		PA:MouseClick(KeyDownType..button,unit);
		return true;
	elseif (type(aUF.classes.aUFunit.prototype.OnClickOld)=="function") then 
		aUF.units[string.gsub(this:GetName(),"aUF","")]:OnClickOld(button)
	else 
		return false;
	end
end

-- Satrina Player Frame
function PA:SatrinaPlayerFrame_OnClick(button)
	
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,"player");
	elseif ( type(PANZA_SatrinaPlayerFrame_OnClick)=="function") then return PANZA_SatrinaPlayerFrame_OnClick(button); end
	
end

-- Satrina Pet Frame
function PA:SatrinaPetFrame_OnClick(button)
	
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,this.unit);
	elseif ( type(PANZA_SatrinaPetFrame_OnClick)=="function") then return PANZA_SatrinaPetFrame_OnClick(button); end	
end

-- Satrina Party Frame
function PA:SatrinaPartyMemberFrame_OnClick(button)
	
	local id = this:GetParent():GetID();
	local unit = "party"..id;
	
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,unit);
	elseif ( type(PANZA_SatrinaPartyMemberFrame_OnClick)=="function") then return PANZA_SatrinaPartyMemberFrame_OnClick(button); end	
end

-- Satrina Target Frame
function PA:SatrinaTargetFrame_OnClick(button)
	local unit="target";
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button, unit);
	elseif ( type(PANZA_SatrinaTargetFrame_OnClick)=="function") then return PANZA_SatrinaTargetFrame_OnClick(button); end	
end

-- Sage Frames
function PA:SFrame_OnClick()
	local unit = SFrame_FrameToID(this);
	local KeyDownType=PA:GetKeyDownType();
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..arg1,unit);
	elseif ( type(PANZA_SFrame_OnClick)=="function") then return PANZA_SFrame_OnClick(); end
end

-- PerfectRaid Frames
function PA:PERFECT_OnClick(button, unit)
	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,unit);
	elseif ( type(PANZA_PerfectRaidCustomClick)=="function") then return PANZA_PerfectRaidCustomClick(button,unit);end
end

-- Easy Raid Frames
function PA:ER_RaidOnClick()
	local button=arg1;
	local unit=this.unit;
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,unit);
	elseif ( type (PANZA_ER_RaidPulloutButton_OnClick)=="function") then return PANZA_ER_RaidPulloutButton_OnClick();end
end

-- Easy Raid MT Frames
function PA:ER_MTOnClick()
	local button=arg1;
	local unit=this.unit;
	local KeyDownType=PA:GetKeyDownType()
	
	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,unit);
	elseif ( type (PANZA_ER_MainTankButton_OnClick)=="function") then return PANZA_ER_MainTank_OnClick();end
end

-- Squishy Emergency Monitor
function PA:SQUISHY_OnClick(button, unit)
	local KeyDownType=PA:GetKeyDownType()

	if KeyDownType~="" then PA:MouseClick(KeyDownType..button,unit);
	elseif ( type(PANZA_SquishyCustomClick)=="function") then return PANZA_SquishyCustomClick(button,unit);end
end

------------------------------------
-- Utility to get special key status
------------------------------------
function PA:GetKeyDownType()
	
	if IsControlKeyDown() then
		return "ctrl"
	elseif IsAltKeyDown() then
		return "alt"
	elseif IsShiftKeyDown() then
		return "shift"
	else
		return "";
	end
end


-----------------------------------------------------------------
-- Process the mouse click and pass to Panza Functions on a Match
-----------------------------------------------------------------
function PA:MouseClick(button,unit)
	local option, action = nil, nil;
	
	optionID=PASettings['clickmods'][button];
	action=PA.clickmodeList[PA.PlayerClass][optionID];
	
	if (button and unit and action and optionID) then
		-- do pa macro (action)
		if (PA:CheckMessageLevel("UI",3)) then
			PA:Message4("(PMM) Key = "..button..". Assignment = "..optionID..", "..action.." for "..unit);
		end
	
		if (action=="Heal") then
			PA:BestHeal(unit);
		elseif (action=="Buff") then
			PA:AsBless(unit, false);
		elseif (action=="Cure") then
			PA:AsCure(unit);
		elseif (action=="Rez") then
			if (PA:SpellInSpellBook("rez")) then
				PA:CastSpell(PA:CombineSpell(PA.SpellBook.rez.Name, PA.SpellBook.rez.MaxRank), unit);
			end	
		elseif (action=="PowerWord:Shield") then
			PA:PriestPWS(unit);
		elseif (action=="Lay on Hands") then
			if (PA:SpellInSpellBook("loh")) then
				PA:CastSpell(PA:CombineSpell(PA.SpellBook.loh.Name, PA.SpellBook.loh.MaxRank), unit);
			end	
		elseif (action=="Protection") then
			if (PA:SpellInSpellBook("bop")) then
				PA:CastSpell(PA:CombineSpell(PA.SpellBook.bop.Name, PA.SpellBook.bop.MaxRank), unit);
			end	
		end	
	else
		if (optionID==nil) then
			if (PA:CheckMessageLevel("UI",5)) then
				PA:Message4("(PMM) Mouse Click Option not found. optionID=nil");
			end
		elseif (action==nil) then
			if (PA:CheckMessageLevel("UI",5)) then
				PA:Message4("(PMM) Action could not be determined. action=nil");
			end
		end
	end	
end