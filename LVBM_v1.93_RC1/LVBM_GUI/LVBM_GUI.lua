-- -------------------------------------------------------------------- --
-- Gui for La Vendetta Boss Mods written by LV|Nitram                   --
-- -------------------------------------------------------------------- --
--
-- ChangeLog (releases):
--
--  v0.75: 
-- 	Added Tooltip Support for the Dialog Functions
--
--  v0.80:
--  	Implementation of all Syncronization Options
--	Languagefile for the whole GUI Dialog
--  
--  v0.85:
--  	Added new Tab for BWL
--  	Modified some Functions from Tabbing
--  	Added Dropdown Handling
--
--  v0.90:
--  	Added extra Tabs for Options
--  	Added Pizza Timer (selfmade Timers like "break for x sec" or "pizza in 10 min")
--  	Added Raidwarning Sound Option
--	Removed some Debug Messages
--
--  v0.95:
--  	Added more Options to Setup the RaidWarning Frame
--  	Added Special Effect Warning System to Options
--  	Fixed some Bugs while saving Options Variable
--  	Fixed bug which blocks the scrollframe from scrolling
--  	Fixed Pizza Timer Broadcast Bug
--      Fixed OnValue changed Bug
--
--  v1.00:
--  	Added Molten Core Tab for BossMods
--  	Added Other Tab for BossMods
--  	Added Options to configure Local Warnings
--  	Added Options to configure Raid Warning Frame
--  	Added SideFrame for Options
--  	Added Pos X Slider for Raid and Local Warnings
--  	Added new Function "LVBM_Gui_AddTab" to add new Tabs
--  	Rewrote all Options for the new SideFrame
--  	Rewrote MainFrame Tabs for Dynamic Tabbing
--  	Rewrote the most Translations
--  	Modified some Functions to add dynamic Tabs
--  	Modified Dropdown Menu Handling
--  	Modified Broadcast Button from Pizza Timer (now requires Rank)
--  	Fixed so many simple bugs while rewriting the Options
--  	Removed old Functions and Handlers
--  	Removed old Buggy Code
--
--  v1.01:
--  	Added Option to disable RaidWarning and LocalWarning Frame
--	Added Option to set the Scale of the Bars
--	Moved some Options and Buttons
--	Changed a lot of Descriptions
--	Fixed disable Status Bar and hide all bars directly
--  
--  v1.05:
--  	Added Infoframe (LVBMGui) System for AddOns
--	Added DistanceFrame via InfoFrame
--	Added Slashcommand /distance
--  	Moved InfoFrame to LVBM_GUI_InfoFrame.lua - need wow restart
--  	Added new Slider for StatusBar Width and Scale
--  	Added new Slider for Special Warning Text Size
--
--  v1.10
--  	Added Slashcommand /abstand for de Client as /distance
--  	Build new Frame Positioning System
--  	Modivied default Font Value of the RaidWarningFrame
--  	Added new features for StatusBar Designs
--  	Added new Tab for Auto Reply Message System
--  	Added new Auto Reply Message Options
--  	Updated some XML and Lua Code
--
--  v1.15
--  	Added some new Buttons
--  	Added some new Options :)
--  	Updated some Files for Burning Crusade Support
--  	Updated Font Detection System 
--  	Fixed Bug in ColorSelectors
--
--  v1.20
--  	Added Option to automatical hide Playernames in Raidgroups
--  	Fixed Bug which prevented the scrollframe from scrolling
--
--  v1.25
--  	Added Option ot load AddOns on Demand
--  	Added Combat Log Range Setup
--
-- -------------------------------------------------------------------- --
-- Developer Information
--
--  Howto add new Tabs:
--  	LVBM_Gui_AddTab( instancekey, tabtext );		-- this function is not needed, because we added other Tab
--
--	* After this, you simply can find all the Bossmods loaded with LVBM.AddOns.ExampleBoss.Instance == instancekey
--	* there is a hard limit of 10 Tabs max, i don't think that all of them are able to be shown at a time
--	RETURN: boolean true|false 
--	* if the Cap is reached it returns false, otherwise true
--	* Title Text is LVBMGUI_TAB_(1-10)_TITLE_TEXT		-- will be changed soon
-- -------------------------------------------------------------------- --

LVBMGUI_DEBUG = false;
LVBMGUI_VERSION = "1.25";
LVBMGUI_SIDEFRAME_TABCOUNT = 6;
LVBMGUI_LINES_TO_DISPLAY = 10;
LVBMGUI_FRAME_HEIGHT = 34;

----------------------------
-- DO NOT CHANGE ANYTHING --
----------------------------

-- DE + EN Possible Fonts
-- Fonts\SKURRI.TTF
-- Fonts\MORPHEUS.TTF
-- Fonts\FRIZQT__.TTF
-- Fonts\ARIALN.TTF
--

LVBM.Options["Gui"] = {		-- Setup the Default Values for this Table
	["Version"]			= LVBMGUI_VERSION,
	["RaidWarnSound"] 		= 1,

	["PizzaTimerText"] 		= "Pizza",
	["PizzaTimerMin"] 		= 15,
	["PizzaTimerSec"] 		= 0,
	["PizzaTimerBroadcast"]		= true,
	
	["RaidWarning_Enable"]		= true,
	["RaidWarning_R"] 		= 1.000000,
	["RaidWarning_G"] 		= 0.858823,
	["RaidWarning_B"] 		= 0.717647,
	["RaidWarning_Delay"]	 	= 1,
	["RaidWarning_Font"] 		= STANDARD_TEXT_FONT, 			-- "Fonts\\FRIZQT__.TTF",-- FZXHJW.ttf 
	["RaidWarning_Height"] 		= 18,
	["RaidWarning_PosX"] 		= 0,
	["RaidWarning_PosY"] 		= -235,

	["SelfWarning_Enable"]		= true,
	["SelfWarning_R"] 		= 1.000000,
	["SelfWarning_G"] 		= 0.858823,
	["SelfWarning_B"] 		= 0.717647,
	["SelfWarning_Delay"] 		= 5,
	["SelfWarning_Font"] 		= STANDARD_TEXT_FONT,
	["SelfWarning_Height"] 		= 16,
	["SelfWarning_PosX"] 		= 0,
	["SelfWarning_PosY"] 		= 235,

	["HidePlayerNamesInRaid"]	= false,
	["CombatLogValue"] 		= 1,
}

LVGUI = { ["MainFrameTabs"] = { } }; 		-- Table for Adding Tabs via LVBM.Gui.AddTab( instancekey, text )
LVBMGUI_MAINFRAME_TABCOUNT = 0;

LVBMSETUPFRAME_SUBFRAMES = { "LVBMBossModListFrame" };
LVBMOPTIONSFRAME_SUBFRAMES = { 
	"LVBMOptionsFramePage1", 
	"LVBMOptionsFramePage2", 
	"LVBMOptionsFramePage3", 
	"LVBMOptionsFramePage4", 
	"LVBMOptionsFramePage5",
	"LVBMOptionsFramePage6",
};
UIPanelWindows["LVBMBossModFrame"] = { area = "left",	pushable = 2,	whileDead = 1 };
table.insert(UIChildWindows, "LVBMOptionsFrame");

local datasetInstance = {};

function LVBMBossModFrame_ShowSubFrame(frameName)
	for index, value in pairs(LVBMSETUPFRAME_SUBFRAMES) do
		if ( value == frameName ) then
			getglobal(value):Show()
		else
			getglobal(value):Hide();
		end	
	end 
end

function LVBMBossModFrame_ShowDropdown(mNameId, button)
	HideDropDownMenu(1);

	LVBossModDropDownFrame.initialize = LVBMBossModFrameDropDown_Initialize;
	LVBossModDropDownFrame.displayMode = "MENU";
	LVBossModDropDownFrame.Name = datasetInstance[mNameId].Key or false;
	LVBossModDropDownFrame.button = button;

	ToggleDropDownMenu(1, nil, LVBossModDropDownFrame, "cursor");
end

function LVBMBossModFrameDropDown_Initialize()
--[[  
List of button attributes
======================================================
info.text = [STRING]  			-- The text of the button
info.value = [ANYTHING]  		-- The value that UIDROPDOWNMENU_MENU_VALUE is set to when the button is clicked
info.func = [function()]  		-- The function that is called when you click the button
info.variable = [STRING (name of a bool var)]	-- a string which contains the name of a boolean variable, used to check the button or not
info.disabled = [nil, 1] 		-- Disable the button and show an invisible button that still traps the mouseover event so menu doesn't time out
info.hasArrow = [nil, 1]  		-- Show the expand arrow for multilevel menus
info.hasColorSwatch = [nil, 1]  	-- Show color swatch or not, for color selection
info.r = [1 - 255] 			-- Red color value of the color swatch
info.g = [1 - 255]  			-- Green color value of the color swatch
info.b = [1 - 255]  			-- Blue color value of the color swatch
info.textR = [1 - 255]  		-- Red color value of the button text
info.textG = [1 - 255]  		-- Green color value of the button text
info.textB = [1 - 255]  		-- Blue color value of the button text
info.swatchFunc = [function()]  	-- Function called by the color picker on color change
info.hasOpacity = [nil, 1]  		-- Show the opacity slider on the colorpicker frame
info.opacity = [0.0 - 1.0]  		-- Percentatge of the opacity, 1.0 is fully shown, 0 is transparent
info.opacityFunc = [function()] 	-- Function called by the opacity slider when you change its value
info.cancelFunc = [function(prevVal)] 	-- Function called by the colorpicker when you click the cancel button (it takes the previous values as its argument)
info.notClickable = [nil, 1]  		-- Disable the button and color the font white
info.notCheckable = [nil, 1]  		-- Shrink the size of the buttons and don't display a check box
info.owner = [Frame]  			-- Dropdown frame that "owns" the current dropdownlist
info.keepShownOnClick = [nil, 1]  	-- Don't hide the dropdownlist after a button is clicked
info.tooltipTitle = [nil, STRING] 	-- Title of the tooltip shown on mouseover
info.tooltipText = [nil, STRING] 	-- Text of the tooltip shown on mouseover
info.justifyH = [nil, "CENTER"] 	-- Justify button text
info.arg1 = [ANYTHING] 			-- This is the first argument used by info.func
info.arg2 = [ANYTHING] 			-- This is the second argument used by info.func
info.textHeight = [NUMBER] 		-- font height for button text
]]	

	if( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then
		local info = {};

		UIDropDownMenu_AddButton{						-- Title
			text = LVBM.AddOns[LVBossModDropDownFrame.Name].Name.." "..LVBMGUI_DROPDOWNMENU_TITLE,
			notCheckable = 1,
			isTitle = 1,
		}
--		UIDropDownMenu_AddButton{ notCheckable = 1 }				-- Space --> sucks =[

		if( LVBossModDropDownFrame.button == "RightButton" ) then		-- Only show if right clicked
			info["text"] = LVBMGUI_ENABLE_ADDON;	-- Enable/Disable AddOn
			if( LVBM.AddOns[LVBossModDropDownFrame.Name].Options.Enabled ) then info["checked"] = 1; else info["checked"] = nil; end
			info["func"] = function() 
					if( LVBM.AddOns[LVBossModDropDownFrame.Name].Options.Enabled ) then 
						SlashCmdList[LVBossModDropDownFrame.Name]("off");
					else 
						SlashCmdList[LVBossModDropDownFrame.Name]("on");
					end 
					LVBMBossModList_Update();
						end;
			info["keepShownOnClick"] = 1;
			UIDropDownMenu_AddButton(info);
	
			info["text"] = LVBMGUI_ENABLE_ANNOUNCE;	-- Enable/Disable Announce
			if( LVBM.AddOns[LVBossModDropDownFrame.Name].Options.Announce ) then info["checked"] = 1; else info["checked"] = nil; end
			info["func"] = function() 
					if( LVBM.AddOns[LVBossModDropDownFrame.Name].Options.Announce ) then 
						SlashCmdList[LVBossModDropDownFrame.Name]("announce off"); 
					else 
						SlashCmdList[LVBossModDropDownFrame.Name]("announce on");
					end 
					LVBMBossModList_Update();
				       end;
			info["keepShownOnClick"] = 1;
			UIDropDownMenu_AddButton(info);
		end
			
		local infoTable = LVBM.AddOns[LVBossModDropDownFrame.Name].DropdownMenu;
		
		if( infoTable ~= nil ) then
			
			for key, info in pairs(infoTable) do
				if( info.variable ~= nil ) then 
					if( table.getglobal(info.variable) ) then		info.checked = 1; 
					else							info.checked = nil; 
					end 
				end
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton( info );
			end
		end
		
	end

end

-- Dropdown for Raidwarning Setup
function LVBMOptionsFrame_RaidWarningDropDown_CreateMenu()
	local info = {};
	info.func = function() 
			UIDropDownMenu_SetSelectedID(LVBMOptionsFramePage3RaidWarningDropDown, this:GetID()); 
			LVBM.Options.Gui.RaidWarnSound = this:GetID();
			LVBMBossModFrame_RaidWarningPlaySound(this:GetID());
		    end;
	info.text = LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_1;
	UIDropDownMenu_AddButton(info);

	info.text = LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_2;
	UIDropDownMenu_AddButton(info);

	info.text = LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_3;
	UIDropDownMenu_AddButton(info);
end

function LVBMBossModFrame_RaidWarningPlaySound(soundnr)
	if( soundnr == 1 ) then		PlaySound("RaidWarning");					-- RaidWarning (default Sound)
	elseif( soundnr == 2 ) then	PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");		-- BellTollNightElf (CT_Raid Sound)
	else				LVBM.AddMsg(LVBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED);
	end
end
-- End Dropdown Raidwarning Setup

function LVBMBossModFrame_OnEvent(event)
	if( event == "PLAYER_LOGIN" ) then

		SLASH_LVDISTANCE1 = "/distance";	-- EN
		SLASH_LVDISTANCE2 = "/abstand";		-- DE
		SlashCmdList["LVDISTANCE"] = LVBM_Gui_DistanceFrame;

		LVBM_Gui_AddTab(LVBMGUI_TAB_NAXX, LVBMGUI_TAB_NAXX_TEXT);
		LVBM_Gui_AddTab(LVBMGUI_TAB_AQ40, LVBMGUI_TAB_AQ40_TEXT);
		LVBM_Gui_AddTab(LVBMGUI_TAB_BWL, LVBMGUI_TAB_BWL_TEXT);
		LVBM_Gui_AddTab(LVBMGUI_TAB_MC, LVBMGUI_TAB_MC_TEXT);
		LVBM_Gui_AddTab(LVBMGUI_TAB_20PL, LVBMGUI_TAB_20PL_TEXT);
		LVBM_Gui_AddTab(LVBMGUI_TAB_OTHER, LVBMGUI_TAB_OTHER_TEXT);

		if( LVBM.Options.Gui["RaidWarning_PosY"] > 0 ) then
			LVBM.Options.Gui["RaidWarning_PosY"] = LVBM.Options.Gui["RaidWarning_PosY"] * (-1);
		end
		RaidWarningFrame:ClearAllPoints();
		RaidWarningFrame:SetPoint("CENTER", "UIParent", "TOP", LVBM.Options.Gui["RaidWarning_PosX"], LVBM.Options.Gui["RaidWarning_PosY"]);
		RaidWarningFrame:SetFont(LVBM.Options.Gui["RaidWarning_Font"], LVBM.Options.Gui["RaidWarning_Height"], "");

		LVBMWarningFrame:ClearAllPoints();
		LVBMWarningFrame:SetPoint("CENTER", "UIParent", "BOTTOM", LVBM.Options.Gui["SelfWarning_PosX"], LVBM.Options.Gui["SelfWarning_PosY"]);
		LVBMWarningFrame:SetFont(LVBM.Options.Gui["SelfWarning_Font"], LVBM.Options.Gui["SelfWarning_Height"], "");

		if( LVBM.Options.Gui["RaidWarning_Enable"] == false ) then	RaidWarningFrame:Hide();	end
		if( LVBM.Options.Gui["SelfWarning_Enable"] == false ) then	LVBMWarningFrame:Hide();	end

		if (LVBM.Options.Gui["HidePlayerNamesInRaid"] and GetNumRaidMembers() > 0) then
			if (tonumber(GetCVar("UnitNamePlayer")) == 1) then
				LVBM.Options.Gui["HidePlayerNames"] = true;
				SetCVar("UnitNamePlayer", 0);
			end
		end

		LVBMMinimapButton_Move();
	
		if not LVBM.Options.MinimapButton.Enabled then
			LVBMMinimapButton:Hide();
		else
			LVBMMinimapButton:Show();
		end



	elseif( event == "RAID_ROSTER_UPDATE" ) then
		
		if (LVBM.Options.Gui["HidePlayerNamesInRaid"] and GetNumRaidMembers() > 0) then
			if (tonumber(GetCVar("UnitNamePlayer")) == 1) then
				LVBM.Options.Gui["HidePlayerNames"] = true;
				SetCVar("UnitNamePlayer", 0);
			end

		elseif (LVBM.Options.Gui["HidePlayerNamesInRaid"] and GetNumRaidMembers() == 0) then
			if (LVBM.Options.Gui["HidePlayerNames"]) then
				SetCVar("UnitNamePlayer", 1);
				LVBM.Options.Gui["HidePlayerNames"] = false;
			end
		end

	elseif( event == "PLAYER_LOGOUT" ) then
		if (LVBM.Options.Gui["HidePlayerNames"]) then
			SetCVar("UnitNamePlayer", 1);
		end
	end
end
	 
function LVBMGUI_SetTabPosition_Update(div, lax, lay, lbx, lby, tabcount)	
	-- div = pixel difference (the ugly part) 
	-- lax = x offset from first 
	-- lay = y offset from first
	-- lbx = x offset from second to n
	-- lby = y offset from second to n
	if( this.OldSelectedTab ~= this.selectedTab ) then
		local ltab = this.selectedTab;
		if( ltab == 1 ) then
			getglobal(this:GetName().."Tab1"):SetPoint("LEFT", this:GetName(), "BOTTOMLEFT", lax, lay-div);
		else
			getglobal(this:GetName().."Tab1"):SetPoint("LEFT", this:GetName(), "BOTTOMLEFT", lax, lay);
		end
		for i=2, tabcount, 1 do
			getglobal(this:GetName().."Tab"..i):SetPoint("LEFT", this:GetName().."Tab"..(i-1), "RIGHT", lbx, 0);
		end
		if( ltab == 1 ) then
			getglobal(this:GetName().."Tab2"):SetPoint("LEFT", this:GetName().."Tab1", "RIGHT", lbx, div);
		else
			getglobal(this:GetName().."Tab"..ltab):SetPoint("LEFT", this:GetName().."Tab"..(ltab-1), "RIGHT", lbx, lby-div);
			if( getglobal(this:GetName().."Tab"..(ltab+1)) ~= nil ) then
				getglobal(this:GetName().."Tab"..(ltab+1)):SetPoint("LEFT", this:GetName().."Tab"..ltab, "RIGHT", lbx, lby+div);
			end
		end
		this.OldSelectedTab = this.selectedTab;
	end
end

function LVBMBossModFrame_Update()
	LVBMBossModFrameTitleText:SetText(getglobal("LVBMGUI_TAB_"..LVBMBossModFrame.selectedTab.."_TITLE_TEXT") );
	if type(LVBMBossModFrame.lastSelectedBossMod[LVBMBossModFrame.selectedTab]) == "number" then
		LVBMBossModFrame.selectedBossMod = LVBMBossModFrame.lastSelectedBossMod[LVBMBossModFrame.selectedTab];
	end
	LVBMBossModFrame_ShowSubFrame("LVBMBossModListFrame");
	LVBMBossModList_Update();
end

function LVBMBossModFrame_OnShow()
	LVBMBossModFrame.showLVBMBossModList = 1;
	LVBMBossModFrame_Update();
	UpdateMicroButtons();
	PlaySound("igMainMenuOpen");
end

function LVBMBossModFrame_OnHide()
	UpdateMicroButtons();
	PlaySound("igMainMenuClose");
	for index, value in pairs(LVBMSETUPFRAME_SUBFRAMES) do
		getglobal(value):Hide();
	end
end

function LVBMBossModList_Update()
	local numLVBMBossMod = 0;
	datasetInstance = {};

	for key, value in pairs(LVBM.SortedAddOns) do
		if( LVBM.AddOns[value].GUITab == LVGUI.MainFrameTabs[LVBMBossModFrame.selectedTab].Tab) then
			numLVBMBossMod = numLVBMBossMod + 1;
			datasetInstance[numLVBMBossMod] = {};
			datasetInstance[numLVBMBossMod]["Key"] = value; 
			datasetInstance[numLVBMBossMod]["Name"] = LVBM.AddOns[value].Name;
			datasetInstance[numLVBMBossMod]["Description"] = LVBM.AddOns[value].Description;			
			datasetInstance[numLVBMBossMod]["Author"] = string.gsub(LVBM.AddOns[value].Author, "La Vendetta|", "");

		end
	end

	local nameLocationText;
	local infoText;
	local bossButton;
	
	local bossOffset = FauxScrollFrame_GetOffset(LVBMBossModFrameLVBMBossModScrollFrame);
	local bossIndex;
	for i=1, LVBMGUI_LINES_TO_DISPLAY, 1 do
		bossIndex = bossOffset + i;

		infoBossMod = getglobal("LVBMBossModButton"..i.."ButtonTextBossMod");
		infoAuthor = getglobal("LVBMBossModButton"..i.."ButtonTextAuthor");
		infoDescription = getglobal("LVBMBossModButton"..i.."ButtonTextDescription");

		if( datasetInstance[bossIndex] ~= nil ) then
			if( LVBM.AddOns[datasetInstance[bossIndex].Key].Options.Enabled ) then
				infoBossMod:SetText(datasetInstance[bossIndex]["Name"]);					-- Main Text
			else
				infoBossMod:SetText("|cff999999"..datasetInstance[bossIndex]["Name"].."|r");
			end 
			
			if LVBMBossModFrameLVBMBossModScrollFrame:IsShown() then
				infoDescription:SetText( LVBM.CutText(datasetInstance[bossIndex]["Description"], 50) );			-- Sub Text
			else
				infoDescription:SetText( LVBM.CutText(datasetInstance[bossIndex]["Description"], 54) );			-- Sub Text
			end

			infoAuthor:SetText(datasetInstance[bossIndex]["Author"]);
			setglobal("LVBMBossModButton"..i.."TTText", datasetInstance[bossIndex]["Name"]);
			setglobal("LVBMBossModButton"..i.."TTDesc", datasetInstance[bossIndex]["Description"]);
		end

		bossButton = getglobal("LVBMBossModButton"..i);
		bossButton:SetID(bossIndex);
		
		-- Update the highlight
		if ( bossIndex == LVBMBossModFrame.selectedBossMod ) then
			bossButton:LockHighlight();
		else
			bossButton:UnlockHighlight();
		end
		
		if ( bossIndex > numLVBMBossMod ) then
			bossButton:Hide();
		else
			bossButton:Show();
		end

		if ( numLVBMBossMod == 0 ) then
			LVBMBossModListFrameLoadAddOnInfo:Show();
			LVBMBossModListFrameLoadAddOns:Show();
		else
			LVBMBossModListFrameLoadAddOnInfo:Hide();
			LVBMBossModListFrameLoadAddOns:Hide();
		end

	end

	-- Update the Buttons on the Bottom Frame for Options
	if( LVBMBossModFrame.selectedBossMod > 0 ) then
		local shortkey = datasetInstance[LVBMBossModFrame.selectedBossMod].Key;
		local shortvar = LVBM.AddOns[shortkey];
	
		if( LVBM.AddOns[shortkey].Options.Enabled ) then 					-- Button 1 -> on/off
			LVBMBossModListFrameButton1:SetText( LVBMGUI_DISABLE_ADDON );
			LVBMBossModListFrameButton1:SetScript("OnClick", function() SlashCmdList[shortkey]("off"); LVBMBossModList_Update(); end);
		else
			LVBMBossModListFrameButton1:SetText( LVBMGUI_ENABLE_ADDON );
			LVBMBossModListFrameButton1:SetScript("OnClick", function() SlashCmdList[shortkey]("on"); LVBMBossModList_Update(); end );
		end
		LVBMBossModListFrameButton1:Enable();

		LVBMBossModListFrameButton2:SetText( LVBMGUI_STOP_ADDON );				-- Button 2 -> stop
		LVBMBossModListFrameButton2:SetScript("OnClick", function() SlashCmdList[shortkey]("stop"); LVBMBossModList_Update(); end );
		LVBMBossModListFrameButton2:Enable();

		if( LVBM.AddOns[shortkey].Options.Announce ) then					-- Button 3 -> Announce on/off
			LVBMBossModListFrameButton3:SetText( LVBMGUI_DISABLE_ANNOUNCE );
			LVBMBossModListFrameButton3:SetScript("OnClick", function() SlashCmdList[shortkey]("announce off"); LVBMBossModList_Update(); end);
		else
			LVBMBossModListFrameButton3:SetText( LVBMGUI_ENABLE_ANNOUNCE );
			LVBMBossModListFrameButton3:SetScript("OnClick", function() SlashCmdList[shortkey]("announce on"); LVBMBossModList_Update(); end );
		end
		LVBMBossModListFrameButton3:Enable();

		if( LVBM.AddOns[shortkey].DropdownMenu ~= nil ) then
			LVBMBossModListFrameButton4:SetText( LVBMGUI_SHOW_DROPDOWNMENU );		-- Button 4 -> Show Dropdown
			LVBMBossModListFrameButton4:SetScript("OnClick", function() LVBMBossModFrame_ShowDropdown( LVBMBossModFrame.selectedBossMod ); end );
			LVBMBossModListFrameButton4:Enable();
		else 
			LVBMBossModListFrameButton4:SetText( LVBMGUI_SHOW_DROPDOWNMENU );
			LVBMBossModListFrameButton4:Disable();
		end
	else
		-- Set Text and Grey out Buttons
		LVBMBossModListFrameButton1:SetText( LVBMGUI_ENABLE_ADDON );
		LVBMBossModListFrameButton1:Disable();

		LVBMBossModListFrameButton2:SetText( LVBMGUI_STOP_ADDON );
		LVBMBossModListFrameButton2:Disable();

		LVBMBossModListFrameButton3:SetText( LVBMGUI_ENABLE_ANNOUNCE );
		LVBMBossModListFrameButton3:Disable();

		LVBMBossModListFrameButton4:SetText( LVBMGUI_SHOW_DROPDOWNMENU );
		LVBMBossModListFrameButton4:Disable();
	end
	
	-- ScrollFrame stuff
	FauxScrollFrame_Update(LVBMBossModFrameLVBMBossModScrollFrame, numLVBMBossMod, LVBMGUI_LINES_TO_DISPLAY, 34 );
end

function LVBMBossModButton_OnClick(button)			-- Called on Mouseclick on a Listitem
	LVBMBossModFrame.lastSelectedBossMod[LVBMBossModFrame.selectedTab] = this:GetID();
	if ( button == "LeftButton" ) then
		LVBMBossModFrame.selectedBossMod = this:GetID();
		LVBMBossModList_Update();
	else
		LVBMBossModFrame.selectedBossMod = this:GetID();
		LVBMBossModList_Update();
		LVBMBossModFrame_ShowDropdown( this:GetID(), button);
	end
end


function LVBM_GUI_LoadAddOn()
	if (LVBMBossModFrame.selectedTab == 1) then
		LoadAddOn("LVBM_NAXX");
		LVBosses_Load_Naxx();

	elseif (LVBMBossModFrame.selectedTab == 2) then
		LoadAddOn("LVBM_AQ40");
		LVBosses_Load_AQ40();

	elseif (LVBMBossModFrame.selectedTab == 3) then
		LoadAddOn("LVBM_BWL");
		LVBosses_Load_BWL();

	elseif (LVBMBossModFrame.selectedTab == 4) then
		LoadAddOn("LVBM_MC");
		LVBosses_Load_MC();

	elseif (LVBMBossModFrame.selectedTab == 5) then
		LoadAddOn("LVBM_AQ20");
		LVBosses_Load_AQ20();
		LoadAddOn("LVBM_ZG");
		LVBosses_Load_ZG();
	end
	LVBM.LoadAddOns();
	HideUIPanel(LVBMBossModFrame);
	ShowUIPanel(LVBMBossModFrame);
end


----------------------------------------------------------------------------
-- Options Side Frame - Need more freespace? no problem, sideframe 4tw :) --
----------------------------------------------------------------------------
function LVBMOptionsFrame_OnShow()
	LVBMBossModFrameOptionsButton:SetText(LVBMGUI_HIDE_OPTIONS);
	LVBMOptionsFrame_Update();
	UpdateMicroButtons();
	PlaySound("igMainMenuOpen");
end

function LVBMOptionsFrame_OnHide()
	LVBMBossModFrameOptionsButton:SetText(LVBMGUI_SHOW_OPTIONS);
	UpdateMicroButtons();
	PlaySound("igMainMenuClose");
	for index, value in pairs(LVBMOPTIONSFRAME_SUBFRAMES) do
		getglobal(value):Hide();
	end
end

function LVBMOptionsFrame_Update()
	LVBMOptionsFrame.selectedTab = tonumber(LVBMOptionsFrame.selectedTab);
	if( LVBMOptionsFrame.selectedTab == nil ) then LVBMOptionsFrame.selectedTab = 1; end

	LVBMOptionsFrame_ShowSubFrame("LVBMOptionsFramePage"..LVBMOptionsFrame.selectedTab);
end

function LVBMOptionsFrame_ShowSubFrame(frameName)
	for index, value in pairs(LVBMOPTIONSFRAME_SUBFRAMES) do
		if ( value == frameName ) then
			getglobal(value):Show()
		else
			getglobal(value):Hide();
		end	
	end 
end
-- End Side Frame Functions


-- Function to Change Minimap Position using the LVBM.Options.MinimapButton Variable
function LVBMMinimapButton_Move()
	LVBMMinimapButton:SetPoint("CENTER", "Minimap", "CENTER", (LVBM.Options.MinimapButton.Radius * cos(LVBM.Options.MinimapButton.Position)), 
							(LVBM.Options.MinimapButton.Radius * sin(LVBM.Options.MinimapButton.Position)));
end


-- Function to Update changes at the Statusbars
function LVBMGuiUpdateStatusbars()
	if( getglobal("LVBM_StatusBarTimer1") == nil ) then return false; end		-- return if there are no bars
	for i = 1, LVBM.StatusBarCount do
		if not getglobal("LVBM_StatusBarTimer"..i).specialColor then
			getglobal("LVBM_StatusBarTimer"..i.."Bar"):SetStatusBarColor(	LVBM.Options.StatusBarColor.r, 
										LVBM.Options.StatusBarColor.g, 
										LVBM.Options.StatusBarColor.b, 
										LVBM.Options.StatusBarColor.a	);
		end
	end
	LVBM_StatusBarTimerDragBar:SetStatusBarColor(	LVBM.Options.StatusBarColor.r, 
							LVBM.Options.StatusBarColor.g, 
							LVBM.Options.StatusBarColor.b, 
							LVBM.Options.StatusBarColor.a	);	
end


-- Function to reset MiniMap Button
function LVBMMinimapButton_SetDefaultValues()
	LVBM.Options["MinimapButton"] = {};
	LVBM.Options.MinimapButton["Position"]	= 225;
	LVBM.Options.MinimapButton["Radius"]	= 78.1;
	LVBM.Options.MinimapButton["Enabled"]	= true;
	LVBMMinimapButton_Move();
end

-- Function to get getglobal for Table Values
function table.getglobal(var)
	return(loadstring("return "..tostring(var))());
end

-- RaidWarningFrame Improvements
function RaidWarningFrame_OnEvent(event, message)				-- Overrides the Original one
	if ( event == "CHAT_MSG_RAID_WARNING" ) then
		this:AddMessage(message, 
				LVBM.Options.Gui["RaidWarning_R"], 
				LVBM.Options.Gui["RaidWarning_G"],
				LVBM.Options.Gui["RaidWarning_B"],
				LVBM.Options.Gui["RaidWarning_Delay"]);
		PlaySound("RaidWarning");
	end
end
function RaidWarningFrames_AddLocalMessages(message)
	RaidWarningFrame:AddMessage(message, 
				LVBM.Options.Gui["RaidWarning_R"], 
				LVBM.Options.Gui["RaidWarning_G"],
				LVBM.Options.Gui["RaidWarning_B"],
				LVBM.Options.Gui["RaidWarning_Delay"]	);

	LVBMWarningFrame:AddMessage(message,
				LVBM.Options.Gui["SelfWarning_R"], 
				LVBM.Options.Gui["SelfWarning_G"],
				LVBM.Options.Gui["SelfWarning_B"],
				LVBM.Options.Gui["SelfWarning_Delay"]	);
			
	PlaySound("RaidWarning");
end


-- Add Tabbing
function LVBM_Gui_AddTab(tab, title)
	if( table.getn( LVGUI.MainFrameTabs ) < 10 ) then
		for index, value in pairs(LVGUI.MainFrameTabs) do
			if( value.Tab == tab ) then
				return true;
			end
		end
		LVBMGUI_MAINFRAME_TABCOUNT = LVBMGUI_MAINFRAME_TABCOUNT + 1;
		table.insert( LVGUI.MainFrameTabs, { ["Tab"] = tab, ["Title"] = title } );
		return true;
	else
		return false;
	end
end

-- Change Combatlog Distance
function LVBM.SetCombatLogDistance(xOpt)
	local rv = { };

	if (xOpt == 4) then		rv = {"60", "1", "1", "1", "1", "1", "1", "1"};				LVBM.AddMsg(LVBM_GUI_COMBATLOG_MIN_RANGE);
	elseif (xOpt == 3) then		rv = {"150", "150", "150", "150", "150", "150", "150", "150"};		LVBM.AddMsg(LVBM_GUI_COMBATLOG_MAX_RANGE);
	elseif (xOpt == 2) then		rv = {"150", "150", "50", "50", "50", "50", "50", "50"};		LVBM.AddMsg(LVBM_GUI_COMBATLOG_LONG_RANGE);
	else				rv = {"60", "30", "50", "50", "50", "50", "50", "50"};			LVBM.AddMsg(LVBM_GUI_COMBATLOG_DEFAULT_RANGE);
	end

	SetCVar("CombatDeathLogRange" , rv[1]);
	SetCVar("CombatLogRangeCreature" , rv[2]);
	SetCVar("CombatLogRangeFriendlyPlayers" , rv[3]);
	SetCVar("CombatLogRangeFriendlyPlayersPets" , rv[4]);
	SetCVar("CombatLogRangeHostilePlayers" , rv[5]);
	SetCVar("CombatLogRangeHostilePlayersPets" , rv[6]);
	SetCVar("CombatLogRangeParty" , rv[7]);
	SetCVar("CombatLogRangePartyPet" , rv[8]);

--	LVBM.AddMsg("CombatDeathLogRange: "..GetCVar("CombatDeathLogRange"), "CVar");
--	LVBM.AddMsg("CombatLogRangeCreature: "..GetCVar("CombatLogRangeCreature"), "CVar");
--	LVBM.AddMsg("CombatLogRangeFriendlyPlayers: "..GetCVar("CombatLogRangeFriendlyPlayers"), "CVar");
--	LVBM.AddMsg("CombatLogRangeFriendlyPlayersPets: "..GetCVar("CombatLogRangeFriendlyPlayersPets"), "CVar");
--	LVBM.AddMsg("CombatLogRangeHostilePlayers: "..GetCVar("CombatLogRangeHostilePlayers"), "CVar");
--	LVBM.AddMsg("CombatLogRangeHostilePlayersPets: "..GetCVar("CombatLogRangeHostilePlayersPets"), "CVar");
--	LVBM.AddMsg("CombatLogRangeParty: "..GetCVar("CombatLogRangeParty"), "CVar");
--	LVBM.AddMsg("CombatLogRangePartyPet: "..GetCVar("CombatLogRangePartyPet"), "CVar");
end

-- Need Function to Get count n of "x" in a String
function string.getnum( mstring, msearch )
	local mcount = 0;
	for mtemp in string.gfind(mstring, msearch) do
		mcount = mcount + 1;
	end
	return mcount;
end


LVBM_Gui_ExampleBar_Functions = {
	["OnUpdate"] = function()
		if LVBM.Options.FillUpStatusBars then
			getglobal(this:GetName().."Bar"):SetValue(777);
		else
			getglobal(this:GetName().."Bar"):SetValue(1000 - 777);
		end
		getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", getglobal(this:GetName().."Bar"), "LEFT", ((getglobal(this:GetName().."Bar"):GetValue() / 1000) * getglobal(this:GetName().."Bar"):GetWidth()), LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].sparkOffset);
	end,
	["OnShow"] = function()
		getglobal(this:GetName().."Bar"):SetMinMaxValues(1, 1000);
		getglobal(this:GetName().."Bar"):SetValue(777);		
		getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", this, "LEFT", ((getglobal(this:GetName().."Bar"):GetValue() / 100) * getglobal(this:GetName().."Bar"):GetWidth()), 0);
		getglobal(this:GetName().."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r, LVBM.Options.StatusBarColor.g, LVBM.Options.StatusBarColor.b, LVBM.Options.StatusBarColor.a);
	end,
	["OnMouseUp"] = function()
	end,
	["OnEnter"] = function()
	end,
	["OnLeave"] = function()
	end,
};

function LVBM_Gui_ChangeExampleBarDesign(newDesign, globalDesignChanged)
	local oldDesign = LVBM.Options.StatusBarDesign;
	if globalDesignChanged then
		LVBMStatusBars_ChangeDesign(newDesign);
		LVBM.StartStatusBarTimer(5, LVBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR, true);
	end
	if LVBMOptionsFramePage2StatusBarTimerExample then
		LVBMOptionsFramePage2StatusBarTimerExample:Hide();
	end
	setglobal("LVBMOptionsFramePage2StatusBarTimerExample", nil);
	for index, value in pairs(LVBMStatusBars_Designs[oldDesign].subFrameNames) do
		setglobal("LVBMOptionsFramePage2StatusBarTimerExample"..value, nil);
	end
	local newBar = CreateFrame("Frame", "LVBMOptionsFramePage2StatusBarTimerExample", LVBMOptionsFramePage2, LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].template);
	newBar:SetScale(1);
	newBar:SetWidth(195);
	getglobal(newBar:GetName().."Bar"):SetWidth(195 - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].widthModifier);
	getglobal(newBar:GetName().."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r, LVBM.Options.StatusBarColor.g, LVBM.Options.StatusBarColor.b, LVBM.Options.StatusBarColor.a);
	getglobal(newBar:GetName().."BarText"):SetWidth(195 - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].textWidthModifier);
	newBar:SetPoint("TOPLEFT", 46, -55);
	for index, value in pairs(LVBM_Gui_ExampleBar_Functions) do
		newBar:SetScript(index, value);
	end
	if type(LVBMStatusBars_Designs[newDesign].initialize) == "function" then
		LVBMStatusBars_Designs[newDesign].initialize(newBar);
	end
	newBar:Show();
end
