-- Baden's ManaSaver Mod
-- Baden - Dragonmarch - Silvermoon Server
-- Arax - Dragonmarch - Silvermoon Server

-- Options Frame LUA Code
-- Variable to be run the first time the macro options frame is opened
local boolFirstMacroLoad = false;

-- Function that is run when the saved variables are loaded
function ManaSaver_OptionsLoaded()
	-- initialize our SavedVariable
	if ( not ManaSaverSV ) then 
	 	ManaSaverSV = {}; 
	end
	if ( not ManaSaverSV.QuietMode ) then 
	 	ManaSaverSV["QuietMode"] = "Default"; 
	end
	if ( not ManaSaverSV.PlusHeal ) then 
	 	ManaSaverSV["PlusHeal"] = 0; 
	end
	if ( not ManaSaverSV.PlusSpirit ) then 
	 	ManaSaverSV["PlusSpirit"] = 0; 
	end
	if ( not ManaSaverSV.MiniMapButtonPos ) then 
	 	ManaSaverSV["MiniMapButtonPos"] = 50; 
	end	
	if ((not(ManaSaverSV.IncTalents == false)) and (not ManaSaverSV.IncTalents)) then 
	 	ManaSaverSV["IncTalents"] = true; 
	end
	if ((not(ManaSaverSV.IncHealItems == false)) and (not ManaSaverSV.IncHealItems)) then 
	 	ManaSaverSV["IncHealItems"] = true; 
	end
	if ((not(ManaSaverSV.CustomError == false)) and (not ManaSaverSV.CustomError)) then  
	 	ManaSaverSV["CustomError"] = true; 
	end
	if ((not(ManaSaverSV.MiniMapButtonShown == false)) and (not ManaSaverSV.MiniMapButtonShown)) then  
	 	ManaSaverSV["MiniMapButtonShown"] = true; 
	end

	-- record that we have been loaded
	ManaSaver_VariablesLoaded = true;

	-- set the loaded variables on the options frame
	MSaver_OptionsQuietOnClick(ManaSaverSV.QuietMode);
	MSaverOptions_IncludeTalents:SetChecked(ManaSaverSV.IncTalents);
	MSaverOptions_IncludeHealItems:SetChecked(ManaSaverSV.IncHealItems);
	MSaverOptions_CustomSpellErrors:SetChecked(ManaSaverSV.CustomError);
	MSaverOptions_ShowMiniMap:SetChecked(ManaSaverSV.MiniMapButtonShown);
	ManaSaverButton_Init();
	ManaSaverButton_UpdatePosition();
	MSaverOptions_SliderButtonPos:SetValue(ManaSaverSV.MiniMapButtonPos);
	
	-- Set the text to the localization file
	MSaverOptions_TitleText:SetText(MANASAVE_OPTIONS_TITLE);
	MSaverOptions_TitleText2:SetText(MANASAVE_OPTIONS_TITLE);
	MSaverOptions_VersionNumber:SetText(string.gsub(MANASAVE_CHAT_VERSION, "NUMVER", MANASAVE_VERSION));
	MSaverOptions_VersionNumber2:SetText(string.gsub(MANASAVE_CHAT_VERSION, "NUMVER", MANASAVE_VERSION));
	MSaverOptions_SelectChatModeText:SetText(MANASAVE_OPTIONS_CHAT_TITLE);
	MSaverOptions_IncludeDataText:SetText(MANASAVE_OPTIONS_INCLUDE_TITLE);
	MSaverOptions_AdditionalOptions:SetText(MANASAVE_OPTIONS_ADOPTIONS_TITLE);
	MSaverOptions_MacroText:SetText(MANASAVE_OPTIONS_MACRO_TITLE);
	MSaverOptions_MacroHead:SetText(MANASAVE_OPTIONS_MACRO_HEADER);
	
	-- ensures the frame is hidden to start
	ManaSaverOptionsFrame:Hide();
	ManaSaverOptionsFrame2:Hide();

end

-- Function that runs everytime the macro options tab is selected
function MSaver_OptionsFrame2OnShow()
	-- Check to see if the variables have been loaded already
	if (boolFirstMacroLoad == false) then
		-- Run the GetSpells Function
		MSaver_GetSpells();
		-- Macro creation controls on load
		MSaverOptions_Macro1Name:ClearFocus();
		MSaverOptions_Macro1Name:SetText("");
		MSaverOptions_Macro1RankText:SetText(0);
		MSaverOptions_Macro1OHText:SetText(0);
		MSaverOptions_Macro1RankPlus:Disable();
		MSaverOptions_Macro1RankMinus:Disable();
		MSaverOptions_Macro1OHPlus:Disable();
		MSaverOptions_Macro1OHMinus:Disable();
		MSaverOptions_Macro1Add:Disable();
		MSaverOptions_Macro2Name:SetText("");
		MSaverOptions_Macro2RankText:SetText(0);
		MSaverOptions_Macro2OHText:SetText(0);
		MSaverOptions_Macro2RankPlus:Disable();
		MSaverOptions_Macro2RankMinus:Disable();
		MSaverOptions_Macro2OHPlus:Disable();
		MSaverOptions_Macro2OHMinus:Disable();
		MSaverOptions_Macro2Add:Disable();
		MSaverOptions_Macro3Name:SetText("");
		MSaverOptions_Macro3RankText:SetText(0);
		MSaverOptions_Macro3OHText:SetText(0);
		MSaverOptions_Macro3RankPlus:Disable();
		MSaverOptions_Macro3RankMinus:Disable();
		MSaverOptions_Macro3OHPlus:Disable();
		MSaverOptions_Macro3OHMinus:Disable();
		MSaverOptions_Macro3Add:Disable();
		MSaverOptions_Macro4Name:SetText("");
		MSaverOptions_Macro4RankText:SetText(0);
		MSaverOptions_Macro4OHText:SetText(0);
		MSaverOptions_Macro4RankPlus:Disable();
		MSaverOptions_Macro4RankMinus:Disable();
		MSaverOptions_Macro4OHPlus:Disable();
		MSaverOptions_Macro4OHMinus:Disable();
		MSaverOptions_Macro4Add:Disable();
		MSaverOptions_Macro5Name:SetText("");
		MSaverOptions_Macro5RankText:SetText(0);
		MSaverOptions_Macro5OHText:SetText(0);
		MSaverOptions_Macro5RankPlus:Disable();
		MSaverOptions_Macro5RankMinus:Disable();
		MSaverOptions_Macro5OHPlus:Disable();
		MSaverOptions_Macro5OHMinus:Disable();
		MSaverOptions_Macro5Add:Disable();
		MSaverOptions_Macro6Name:SetText("");
		MSaverOptions_Macro6RankText:SetText(0);
		MSaverOptions_Macro6OHText:SetText(0);
		MSaverOptions_Macro6RankPlus:Disable();
		MSaverOptions_Macro6RankMinus:Disable();
		MSaverOptions_Macro6OHPlus:Disable();
		MSaverOptions_Macro6OHMinus:Disable();
		MSaverOptions_Macro6Add:Disable();
		-- loop through and populate
		local i = 0;
		local numAllHealRanks = 0;
		for a,b in pairs(ManaSave_PlayerSpells) do
			i = i + 1;
			local numMax = 0;
			for c,d in pairs(ManaSave_PlayerSpells[a]) do
				if c > numMax then numMax = c; end
				-- Check to see if all heal applicable
				if ((a == MANASAVE_SPELL_LESSHEAL) or (a == MANASAVE_SPELL_HEAL) or (a == MANASAVE_SPELL_GRTHEAL)) then
					numAllHealRanks = numAllHealRanks + 1;
				end
			end
			MSaver_MacroControlsPopulate (i,a,numMax);
		end
	
		-- Populates All Heal, if applicable
		if (numAllHealRanks > 0) then
			MSaver_MacroControlsPopulate ((i+1),MANASAVE_SPELL_ALLHEAL,numAllHealRanks);
		end
			
		-- Save the fact that we have loaded the form
		boolFirstMacroLoad = true;
	end
end

function MSaver_OptionsFrame2Reset()
	boolFirstMacroLoad = false;
	MSaver_OptionsFrame2OnShow();
end
-- Function populates the Macroboxes
function MSaver_MacroControlsPopulate (i,a,numMax)
	if (i == 1) then
		MSaverOptions_Macro1Name:SetText(a);
		MSaverOptions_Macro1RankText:SetText(numMax);
		MSaverOptions_Macro1RankPlus:Enable();
		MSaverOptions_Macro1RankMinus:Enable();
		MSaverOptions_Macro1OHPlus:Enable();
		MSaverOptions_Macro1OHMinus:Enable();
		MSaverOptions_Macro1Add:Enable();
	elseif (i == 2) then
		MSaverOptions_Macro2Name:SetText(a);
		MSaverOptions_Macro2RankText:SetText(numMax);
		MSaverOptions_Macro2RankPlus:Enable();
		MSaverOptions_Macro2RankMinus:Enable();
		MSaverOptions_Macro2OHPlus:Enable();
		MSaverOptions_Macro2OHMinus:Enable();
		MSaverOptions_Macro2Add:Enable();
	elseif (i == 3) then
		MSaverOptions_Macro3Name:SetText(a);
		MSaverOptions_Macro3RankText:SetText(numMax);
		MSaverOptions_Macro3RankPlus:Enable();
		MSaverOptions_Macro3RankMinus:Enable();
		MSaverOptions_Macro3OHPlus:Enable();
		MSaverOptions_Macro3OHMinus:Enable();
		MSaverOptions_Macro3Add:Enable();
	elseif (i == 4) then
		MSaverOptions_Macro4Name:SetText(a);
		MSaverOptions_Macro4RankText:SetText(numMax);
		MSaverOptions_Macro4RankPlus:Enable();
		MSaverOptions_Macro4RankMinus:Enable();
		MSaverOptions_Macro4OHPlus:Enable();
		MSaverOptions_Macro4OHMinus:Enable();
		MSaverOptions_Macro4Add:Enable();
	elseif (i == 5) then
		MSaverOptions_Macro5Name:SetText(a);
		MSaverOptions_Macro5RankText:SetText(numMax);
		MSaverOptions_Macro5RankPlus:Enable();
		MSaverOptions_Macro5RankMinus:Enable();
		MSaverOptions_Macro5OHPlus:Enable();
		MSaverOptions_Macro5OHMinus:Enable();
		MSaverOptions_Macro5Add:Enable();
	else
		MSaverOptions_Macro6Name:SetText(a);
		MSaverOptions_Macro6RankText:SetText(numMax);
		MSaverOptions_Macro6RankPlus:Enable();
		MSaverOptions_Macro6RankMinus:Enable();
		MSaverOptions_Macro6OHPlus:Enable();
		MSaverOptions_Macro6OHMinus:Enable();
		MSaverOptions_Macro6Add:Enable();
	end
end


-- Function that runs when one of the the Quiet Boxes have been clicked
function MSaver_OptionsQuietOnClick(strMSaverq)
	-- make sure that saved variable has been loaded before allowing this function to be called
	if ( not ManaSaver_VariablesLoaded ) then -- config not loaded
		ManaSaverOptions:Hide(); -- ensure the options pages is hidden
		return;
	end

	-- Sets the other checkboxes
	if (strMSaverq == "Default") then
		MSaverOptions_QuietDefault:SetChecked(true);
		MSaverOptions_QuietSelf:SetChecked(false);
		MSaverOptions_QuietOff:SetChecked(false);
		MSaverOptions_QuietOn:SetChecked(false);
	elseif (strMSaverq == "Self") then
		MSaverOptions_QuietDefault:SetChecked(false);
		MSaverOptions_QuietSelf:SetChecked(true);
		MSaverOptions_QuietOff:SetChecked(false);
		MSaverOptions_QuietOn:SetChecked(false);
	elseif (strMSaverq == "Off") then
		MSaverOptions_QuietDefault:SetChecked(false);
		MSaverOptions_QuietSelf:SetChecked(false);
		MSaverOptions_QuietOff:SetChecked(true);
		MSaverOptions_QuietOn:SetChecked(false);
	elseif (strMSaverq == "On") then
		MSaverOptions_QuietDefault:SetChecked(false);
		MSaverOptions_QuietSelf:SetChecked(false);
		MSaverOptions_QuietOff:SetChecked(false);
		MSaverOptions_QuietOn:SetChecked(true);
	else  -- Code failure, abort
		ManaSaverOptionsFrame:Hide();
	end

	-- Sets the new msaverq mode
	ManaSaverSV.QuietMode = strMSaverq;

end

-- Function that runs when any other box is checked
function MSaver_OptionsOtherOnClick(strName,boolValue)
	-- make sure that saved variable has been loaded before allowing this function to be called
	if ( not ManaSaver_VariablesLoaded ) then -- config not loaded
		ManaSaverOptions:Hide(); -- ensure the options pages is hidden
		return;
	end
	
	-- read setting out of checkbox (or slider) and put into profile
    -- use this:GetName() to know which checkbox was hit.
	if ( strName == "MSaverOptions_IncludeTalents" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(boolValue);
		ManaSaverSV.IncTalents = boolValue; -- set profile
	elseif ( strName == "MSaverOptions_IncludeHealItems" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(boolValue);
		ManaSaverSV.IncHealItems = boolValue;
	elseif ( strName == "MSaverOptions_CustomSpellErrors" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(boolValue);
		ManaSaverSV.CustomError = boolValue;
	elseif ( strName == "MSaverOptions_ShowMiniMap" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(boolValue);
		ManaSaverButton_Toggle();
	end
end

function MSaver_OptionsPlusMinus(cntrl, numVal)
	local numTemp
	
	if (cntrl == "1Rank") then
		numTemp = MSaverOptions_Macro1RankText:GetNumber();
		MSaverOptions_Macro1RankText:SetText(numTemp + numVal);
	elseif (cntrl == "1OH") then
		numTemp = MSaverOptions_Macro1OHText:GetNumber();
		MSaverOptions_Macro1OHText:SetText(numTemp + numVal);
	elseif (cntrl == "2Rank") then
		numTemp = MSaverOptions_Macro2RankText:GetNumber();
		MSaverOptions_Macro2RankText:SetText(numTemp + numVal);
	elseif (cntrl == "2OH") then
		numTemp = MSaverOptions_Macro2OHText:GetNumber();
		MSaverOptions_Macro2OHText:SetText(numTemp + numVal);
	elseif (cntrl == "3Rank") then
		numTemp = MSaverOptions_Macro3RankText:GetNumber();
		MSaverOptions_Macro3RankText:SetText(numTemp + numVal);
	elseif (cntrl == "3OH") then
		numTemp = MSaverOptions_Macro3OHText:GetNumber();
		MSaverOptions_Macro3OHText:SetText(numTemp + numVal);
	elseif (cntrl == "4Rank") then
		numTemp = MSaverOptions_Macro4RankText:GetNumber();
		MSaverOptions_Macro4RankText:SetText(numTemp + numVal);
	elseif (cntrl == "4OH") then
		numTemp = MSaverOptions_Macro4OHText:GetNumber();
		MSaverOptions_Macro4OHText:SetText(numTemp + numVal);
	elseif (cntrl == "5Rank") then
		numTemp = MSaverOptions_Macro5RankText:GetNumber();
		MSaverOptions_Macro5RankText:SetText(numTemp + numVal);
	elseif (cntrl == "5OH") then
		numTemp = MSaverOptions_Macro5OHText:GetNumber();
		MSaverOptions_Macro5OHText:SetText(numTemp + numVal);
	elseif (cntrl == "6Rank") then
		numTemp = MSaverOptions_Macro6RankText:GetNumber();
		MSaverOptions_Macro6RankText:SetText(numTemp + numVal);
	else
		numTemp = MSaverOptions_Macro6OHText:GetNumber();
		MSaverOptions_Macro6OHText:SetText(numTemp + numVal);
	end
end

-- **************************************************
-- *********** Macro Functions **********************
-- **************************************************

-- Function used to create or modify mod-created macros
function MSaver_OptionsCreateMacro(cntrl)
	-- Set values by gathering data from form
	local strName,numRank,numOH
	if (cntrl == 1) then
		strName = MSaverOptions_Macro1Name:GetText();
		numRank = MSaverOptions_Macro1RankText:GetNumber();
		numOH = MSaverOptions_Macro1OHText:GetNumber();
	elseif (cntrl == 2) then
		strName = MSaverOptions_Macro2Name:GetText();
		numRank = MSaverOptions_Macro2RankText:GetNumber();
		numOH = MSaverOptions_Macro2OHText:GetNumber();
	elseif (cntrl == 3) then
		strName = MSaverOptions_Macro3Name:GetText();
		numRank = MSaverOptions_Macro3RankText:GetNumber();
		numOH = MSaverOptions_Macro3OHText:GetNumber();
	elseif (cntrl == 4) then
		strName = MSaverOptions_Macro4Name:GetText();
		numRank = MSaverOptions_Macro4RankText:GetNumber();
		numOH = MSaverOptions_Macro4OHText:GetNumber();
	elseif (cntrl == 5) then
		strName = MSaverOptions_Macro5Name:GetText();
		numRank = MSaverOptions_Macro5RankText:GetNumber();
		numOH = MSaverOptions_Macro5OHText:GetNumber();
	else
		strName = MSaverOptions_Macro6Name:GetText();
		numRank = MSaverOptions_Macro6RankText:GetNumber();
		numOH = MSaverOptions_Macro6OHText:GetNumber();
	end
	-- Macro's name - which is "MSMacro_XXX" where XXX is spell name
	local strMName = "MSM_"..strName;
	-- If strMName is longer than 15 characters, truncate
	if (string.len(strMName) > 15) then
		strMName = string.sub(strMName,1,15);
	end
	-- Macro's index if it has one
	local numMIndex = GetMacroIndexByName(strMName)
	-- Macro icon, set statically, as the user can change it later
	-- We will use the existing icon, if there is one already
	local numMIcon = 12;
	-- Macro's body
	local strMBody = "/script MSaver('"..strName.."',"..numRank..","..numOH..");";

	-- First need to see if MSaver has already created a macro for the spell
	-- If so, the we modify that macro, so the mod does not fill up the player's macro list
	
	--DEFAULT_CHAT_FRAME:AddMessage("MName-"..strMName..", MIndex-"..numMIndex..", MIcon-"..numMIcon..", MBody-"..strMBody);
	if (numMIndex ~= 0) then
		-- Get existing texture
		local name, numMIcon, macrobody, numlocal = GetMacroInfo(numMIndex);
		EditMacro(numMIndex,strMName,numMIcon,strMBody,1);
		DEFAULT_CHAT_FRAME:AddMessage("ManaSaver "..strName..MANASAVE_OPTIONS_MACRO_UPDATED);
	-- Else, create a new macro
	else
		CreateMacro(strMName,numMIcon,strMBody,1,1);
		DEFAULT_CHAT_FRAME:AddMessage("ManaSaver "..strName..MANASAVE_OPTIONS_MACRO_CREATED);
	end
end

function MSaver_OptionsTabs(numTab)
	if (numTab == 1) then
		ManaSaverOptionsFrame:Show();
		ManaSaverOptionsFrame:EnableMouse(true);
		ManaSaverOptionsFrame2:Hide();
		ManaSaverOptionsFrame2:EnableMouse(false);
	else
		ManaSaverOptionsFrame:Hide();
		ManaSaverOptionsFrame:EnableMouse(false);
		ManaSaverOptionsFrame2:Show();
		ManaSaverOptionsFrame2:EnableMouse(true);
	end
end

