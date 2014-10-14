-- Buttonhole Advanced: Swallows Minimap Buttons
-- Copyright (C) 2006  Aaron Griffith

-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

ButtonholeAd_Version = "0.2"; -- Buttonhole Advanced Version. Change at Release

ButtonholeAd_Branch = ""; -- Buttonhole Advanced Branch. Change this all you AddOn ripoff posers! <3

ButtonholeAd_Author = "|cffff0000Swatch|r of Stormrage"; -- Change this too ^^

-- This next block is the text for the help window.
ButtonholeAd_text1 = [[Welcome to Buttonhole Advanced ]] .. ButtonholeAd_Version .. ButtonholeAd_Branch .. [[
(by ]] .. ButtonholeAd_Author .. [[)

When the original Buttonhole was killed, we groped around in the darkness for what seemed like eternity. I, however, do not like to grope. So there. Here we are with Buttonhole Advanced.

Completely rewritten and with more features to use, it's the ultimate Buttonhole.]];

ButtonholeAd_check1 = "Classic Mode:  |cffff8888(SemiWorking)|r";

ButtonholeAd_text2 = [[In classic mode, Buttonhole Advanced behaves just like it's predicessor. It hides all the buttons in one, allowing you to scroll through them with the scrollwheel.]];

ButtonholeAd_check2 = "Menu Mode:     |cffff0000(Not Working)|r";

ButtonholeAd_text3 = [[In menu mode, all of the buttons hidden in the buttonhole are accessable through a menu, shown when you left click the button.]];

ButtonholeAd_check3 = "Expander Mode:";

ButtonholeAd_text4 = [[In expander mode, all of the buttons only become visible when you toggle the button-hole.]];

ButtonholeAd_check4 = "Off Mode:";

ButtonholeAd_text5 = [[This is obvious. This mode disables buttonholing.]];

ButtonholeAd_text6 = [[This window lets you configure which addons will be buttonholed, and which will not. This is useful for keeping out that one superhawt addon that you use ritualistically.

Please Note: Some addons that are not in the Buttonhole Predefined Mods list appear with their button frame name. Although this is mangled, you can usually still tell what addon is what.]];

PredefinedMods = {};

function PredefinedMods:load()

  PredefinedMods.Accountant =     { id="ACCOUNTANT", 
                                    name="Accountant", 
                                    buttonFrame="AccountantButtonFrame", 
                                    updateFunction="AccountantButton_UpdatePosition"};
  PredefinedMods.Atlas =          { id="ATLAS", 
                                    name="Atlas", 
                                    buttonFrame="AtlasButtonFrame", 
                                    updateFunction="AtlasButton_UpdatePosition"};
  PredefinedMods.Opium =          { id="OPIUM", 
                                    name="Opium", 
                                    buttonFrame="OpiumButtonFrame", 
                                    updateFunction="Opium_UpdatePosition"};
  PredefinedMods.MonkeyBuddy =    { id="MONKEYBUDDY", 
                                    name="MonkeyBuddy", 
                                    buttonFrame="MonkeyBuddyIconButton", 
                                    updateFunction=""};
  PredefinedMods.Parchment =      { id="PARCHMENT", 
                                    name="Parchment", 
                                    buttonFrame="ParchmentButtonFrame", 
                                    updateFunction="ParchmentButton_UpdatePosition"};
  PredefinedMods.TrinketMenu =    { id="TRINKETMENU", 
                                    name="TrinketMenu", 
                                    buttonFrame="TrinketMenu_IconFrame", 
                                    updateFunction=""};
  PredefinedMods.Wardrobe =       { id="WARDROBE", 
                                    name="Wardrobe", 
                                    buttonFrame="Wardrobe_IconFrame", 
                                    updateFunction=""};
                               
  PredefinedMods.CT_RA =          { id="CTRA",
                                    name="CT_RaidAssist",
                                    buttonFrame="CT_RASets_Button",
                                    updateFunction="CT_RAMenu_UpdateMenu"};

  PredefinedMods.CT_Mod =         { id="CTMOD",
                                    name="CT_Mod",
                                    buttonFrame="CT_OptionButton",
                                    updateFunction=""};

  PredefinedMods.FlagRSPFL =      { id="FLAGRSPFL",
                                    name="FlagRSPFriendlist",
                                    buttonFrame="FRIENDLISTMinimapButton",
                                    updateFunction=""};

  PredefinedMods.DepositBox =     { id="DEPOSITBOX",
                                    name="DepositBox",
                                    buttonFrame="DepositBoxUI_Main_MiniMapButtonFrame",
                                    updateFunction=""};

  PredefinedMods.PaladinA =       { id="PALADINASSISTANT",
                                    name="PaladinAssistant",
                                    buttonFrame="PaladinButton",
                                    updateFunction=""};

  PredefinedMods.MinigamesPack =  { id="MINIGAMESPACK",
                                    name="MinigamesPack",
                                    buttonFrame="MinigamesPackMinimapButton",
                                    updateFunction=""};

  PredefinedMods.CallToArms =     { id="CALLTOARMS",
                                    name="CallToArms",
                                    buttonFrame="CTA_MinimapIcon",
                                    updateFunction=""};
                                    
  PredefinedMods.MyMusic =        { id="MYMUSIC",
                                    name="MyMusic",
                                    buttonFrame="myMusic_Button",
                                    updateFunction="myMusic_MiniMapButton_UpdatePosition"};

  PredefinedMods.Gypsy =          { id="GYPSY",
                                    name="GypsyMod",
                                    buttonFrame="Gypsy_Button",
                                    updateFunction=""};
                                    
  PredefinedMods.EnchantingSell = { id="EnchantingSell",
                                    name="EnchantingSell",
                                    buttonFrame="EnchantingSellMinimapButton",
                                    updateFunction=""};
                  
  PredefinedMods.QuestAssist =    { id="QuestAssist",
                                    name="QuestAssist",
                                    buttonFrame="QuestAssistMiniMapButton",
                                    updateFunction="QuestAssistButton_UpdatePosition"};
                  
  PredefinedMods.TrainerSkills =  { id="TrainerSkills",
                                    name="TrainerSkills",
                                    buttonFrame="TrainerSkillsMinimapButton",
                                    updateFunction=""};

  PredefinedMods.QuickCalc =      { id="QuickCalc",
                                    name="QuickCalc",
                                    buttonFrame="QuickCalc_Button",
                                    updateFunction=""}; 

  PredefinedMods.Gatherer =       { id="Gatherer",
                                    name="Gatherer",
                                    buttonFrame="GathererUI_IconFrame",
                                    updateFunction=""}; 

  PredefinedMods.IEF =            { id="IEF",
                                    name="Improved Error Frame",
                                    buttonFrame="IEFMinimapButton",
                                    updateFunction=""};

  PredefinedMods.Cosmos =         { id="COSMOS",
                                    name="Cosmos",
                                    buttonFrame="CosmosMinimapButton",
                                    updateFunction=""};

  PredefinedMods.UUI =            { id="UUI",
                                    name="UUI",
                                    buttonFrame="UltimateUIMinimapButton",
                                    updateFunction=""};

end;

function ButtonholeAd_setupHelp()
	local pixels_between_blocks = 40;
	local pixels_at_end = 50;
	local cbo = 20;
	local x = 20;
	local y = -20;
	local height;
	
	ButtonholeAdFrameText1:SetPoint("TOPLEFT", x, y);
	ButtonholeAdFrameText1:SetText(ButtonholeAd_text1);
	y = y - ButtonholeAdFrameText1:GetHeight() - pixels_between_blocks;
	
	ButtonholeAdFrameCheckButtonClassic:SetPoint("CENTER", "ButtonholeAdFrame", "TOPLEFT", x+cbo, y+(pixels_between_blocks/2));
	ButtonholeAdFrameCheck1:SetPoint("LEFT", "ButtonholeAdFrame", "TOPLEFT", x+cbo+cbo, y+(pixels_between_blocks/2)-2);
	ButtonholeAdFrameCheck1:SetText(ButtonholeAd_check1);
	
	ButtonholeAdFrameText2:SetPoint("TOPLEFT", x, y);
	ButtonholeAdFrameText2:SetText(ButtonholeAd_text2);
	y = y - ButtonholeAdFrameText2:GetHeight() - pixels_between_blocks;
	
	ButtonholeAdFrameCheckButtonMenu:SetPoint("CENTER", "ButtonholeAdFrame", "TOPLEFT", x+cbo, y+(pixels_between_blocks/2));
	ButtonholeAdFrameCheck2:SetPoint("LEFT", "ButtonholeAdFrame", "TOPLEFT", x+cbo+cbo, y+(pixels_between_blocks/2)-2);
	ButtonholeAdFrameCheck2:SetText(ButtonholeAd_check2);
	
	ButtonholeAdFrameText3:SetPoint("TOPLEFT", x, y);
	ButtonholeAdFrameText3:SetText(ButtonholeAd_text3);
	y = y - ButtonholeAdFrameText3:GetHeight() - pixels_between_blocks;
	
	ButtonholeAdFrameCheckButtonExpander:SetPoint("CENTER", "ButtonholeAdFrame", "TOPLEFT", x+cbo, y+(pixels_between_blocks/2));
	ButtonholeAdFrameCheck3:SetPoint("LEFT", "ButtonholeAdFrame", "TOPLEFT", x+cbo+cbo, y+(pixels_between_blocks/2)-2);
	ButtonholeAdFrameCheck3:SetText(ButtonholeAd_check3);
	
	ButtonholeAdFrameText4:SetPoint("TOPLEFT", x, y);
	ButtonholeAdFrameText4:SetText(ButtonholeAd_text4);
	y = y - ButtonholeAdFrameText4:GetHeight() - pixels_between_blocks;
	
	ButtonholeAdFrameCheckButtonOff:SetPoint("CENTER", "ButtonholeAdFrame", "TOPLEFT", x+cbo, y+(pixels_between_blocks/2));
	ButtonholeAdFrameCheck4:SetPoint("LEFT", "ButtonholeAdFrame", "TOPLEFT", x+cbo+cbo, y+(pixels_between_blocks/2)-2);
	ButtonholeAdFrameCheck4:SetText(ButtonholeAd_check4);
	
	ButtonholeAdFrameText5:SetPoint("TOPLEFT", x, y);
	ButtonholeAdFrameText5:SetText(ButtonholeAd_text5);
	y = y - ButtonholeAdFrameText5:GetHeight() - pixels_between_blocks;
	
	height = -y;
	height = height + pixels_at_end;
	ButtonholeAdFrame:SetHeight(height);
end

ButtonholeAdDetails = {
name = "Buttonhole Advanced",
version = ButtonholeAd_Version,
releaseDate = "June 25, 2006",
author = ButtonholeAd_Author,
email = "aargri@gmail.com",
website = "http://tinyurl.com/rkqqe",
category = MYADDONS_CATEGORY_OTHERS,
optionsframe = "ButtonholeAdFrame" };

ButtonholeAd_Debug = 0;
ButtonholeAd_Method = 2;
ButtonholeAd_Pos = 97;

ButtonholeAd_SwallowButtons = {};
ButtonholeAd_LeaveOutButtons = {};

function ButtonholeAd_isButtonHoled(frame)
	for _, name in ipairs(ButtonholeAd_LeaveOutButtons) do
		if (frame:GetName() == name) then
			return false;
		end
	end
	return true;
end

function BHA_Debug(msg)
	if (ButtonholeAd_Debug == 1) then
		DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Debug : " .. msg, 0.2, 0.8, 0.8);
	end
end

-- This is the /bh command
function ButtonholeAd_Command(cmd)
  if (cmd == "debug") then -- Handle a debug call real quick-like
    if (ButtonholeAd_Debug == 1) then
      ButtonholeAd_Debug=0;
      DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Debug Off", 0.2, 0.8, 0.8);
    else
      ButtonholeAd_Debug=1;
      DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Debug On", 0.2, 0.8, 0.8);
    end
    return nil;
  end
  if (cmd == "") then -- If there is no string, open help
  	BHA_Debug("Showing config frame");
    ButtonholeAdFrame:Show();
    return nil;
  end
end

function ButtonholeAd_UpdateMethodUI()
	ButtonholeAdFrameCheckButtonClassic:SetChecked(0);
	ButtonholeAdFrameCheckButtonMenu:SetChecked(0);
	ButtonholeAdFrameCheckButtonExpander:SetChecked(0);
	ButtonholeAdFrameCheckButtonOff:SetChecked(0);
	if (ButtonholeAd_Method == 0) then
		BHA_Debug("Method set to Classic");
		ButtonholeAdFrameCheckButtonClassic:SetChecked(1);
		ButtonholeAd_Off_Init();
		ButtonholeAd_Classic_Init();
		return nil;
	end
	if (ButtonholeAd_Method == 1) then
		BHA_Debug("Method set to Menu");
		ButtonholeAdFrameCheckButtonMenu:SetChecked(1);
		ButtonholeAd_Off_Init();
		ButtonholeAd_Menu_Init();
		return nil;
	end
	if (ButtonholeAd_Method == 2) then
		BHA_Debug("Method set to Expander");
		ButtonholeAdFrameCheckButtonExpander:SetChecked(1);
		ButtonholeAd_Off_Init();
		ButtonholeAd_Expander_Init();
		return nil;
	end
	if (ButtonholeAd_Method == 3) then
		BHA_Debug("Method set to Off");
		ButtonholeAdFrameCheckButtonOff:SetChecked(1);
		ButtonholeAd_Off_Init();
		return nil;
	end
end

function ButtonholeAd_UpdatePosUI()
	ButtonholeAdFramePosSlider:SetValue(ButtonholeAd_Pos);
	
	x = cos(ButtonholeAd_Pos);
	y = sin(ButtonholeAd_Pos);
	x = -x;
	y = -y;
	x = x * 81;
	y = y * 81;
	x = x + 53;
	y = y - 54;
	
	ButtonholeAd_Minimap:SetPoint("TOPLEFT", x, y);
	
	-- BHA_Debug("Setting button position to " .. ButtonholeAd_Pos);
end

function ButtonholeAd_Minimap_OnClick(arg1)
	if (arg1 == "RightButton") then
		if (ButtonholeAdFrame:IsShown()) then
			BHA_Debug("Hiding config frame");
    		ButtonholeAdFrame:Hide();
    		return nil;
    	end
		BHA_Debug("Showing config frame");
    	ButtonholeAdFrame:Show();
    	return nil;
    end
    ButtonholeAd_Menu_Click();
    ButtonholeAd_Expander_Click();
end

-- Does this on load (duh)
function ButtonholeAd_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED"); -- Registers for Loaded Variables (standard)
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("ADDON_LOADED");
	SLASH_BUTTONHOLEAD1 = "/buttonhole"; -- Long Command
	SLASH_BUTTONHOLEAD2 = "/bh"; -- Short Command
	SLASH_BUTTONHOLEAD3 = "/buttonholead"; -- Semi-Long Command
	SLASH_BUTTONHOLEAD4 = "/buttonholeadvanced"; -- Really Long Command
	SLASH_BUTTONHOLEAD5 = "/bha"; -- Semi-Short Command
	SlashCmdList["BUTTONHOLEAD"] = ButtonholeAd_Command;
	ButtonholeAd_setupHelp(); -- Sets the Help Text
end


---------------------------------------------------------------------------

function ButtonholeAd_WheelWrapper()
	ButtonholeAd_Classic_Wheel(arg1);
end

function ButtonholeAd_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		-- ButtonholeAd_UpdateMethodUI();
		-- ButtonholeAd_UpdatePosUI();
		DEFAULT_CHAT_FRAME:AddMessage("Buttonhole Advanced : Ready for Work!", 0.2, 0.8, 0.8); -- Something need doing?
	end
	if (event == "ADDON_LOADED") and (myAddOnsFrame_Register) then
		myAddOnsFrame_Register(ButtonholeAdDetails);
	end
	if (event == "PLAYER_LOGIN") then
		local kids = { Minimap:GetChildren() };
		for _,child in ipairs(kids) do
			if (child:GetName() == nil) then
				-- skip, unamed freaks!
			else
				PredefinedMods:load();
				local name = child:GetName();
				local first = string.find(strlower(name), "minimap");
				local second = string.find(strlower(name), "gathernote");
				if (second == 1) then
					-- Gatherer Wierdness
				elseif (first == 1) then
					-- skip, original frames
				else
					if not (name == "ButtonholeAd_Minimap") then -- Skip ourselves...
						local tmp = {
							ModName = name,
							ModFrame = child,
							ModOriginalX = child:GetLeft(),
							ModOriginalY = child:GetBottom(),
							ModOriginalS = child:GetScale(),
							ModOriginalSetPoint = child.SetPoint,
							ModUpdateFunc = nil,                 
							ModPredefined = false                 };
						for _,item in pairs(PredefinedMods) do
							if (item == PredefinedMods.load) then 
								-- nothing
							else
								if (tmp.ModName == item.buttonFrame) then
									BHA_Debug("Predefined: " .. item.name);
									tmp.ModName = item.name;
									tmp.ModUpdateFunc = item.updateFunction;
									tmp.ModPredefined = true;
								end
							end
						end
						if (name == "CT_OptionBarFrame") then tmp.ModOriginalX = nil; end
						if (name == "GathererUI_IconFrame") then
							if (Chronos) then
								Chronos.schedule(8, child.Hide, child); -- Hides teh
							end                                         -- Annoying Icon!
						end
						child:EnableMouseWheel(1);
						child:SetScript("OnMouseWheel", ButtonholeAd_WheelWrapper);
						tinsert(ButtonholeAd_SwallowButtons, tmp);
						-- DEFAULT_CHAT_FRAME:AddMessage("The new is " .. name);
					end
				end
			end
		end 
		ButtonholeAd_ModConfig_Load();
		ButtonholeAd_UpdateMethodUI();
		ButtonholeAd_UpdatePosUI();
	end
end


--------------------------------------------------------------------------


ButtonholeAd_Classic_Num = 0;

function ButtonholeAd_Classic_Init()
	if not (ButtonholeAd_Method == 0) then
		return nil;
	end
	ButtonholeAd_Classic_Num = 0;
	local actualButtons = {};
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		if (ButtonholeAd_isButtonHoled(v.ModFrame)) then
			tinsert(actualButtons, v);
		end
	end
	for i,v in ipairs(actualButtons) do
		if (v.ModOriginalX == nil) or (v.ModOriginalY == nil) then
			v.ModFrame:Hide();
			if (i == ButtonholeAd_Classic_Num) then v.ModFrame:Show(); end
		else
			BHA_Debug("Classic : Jiggering frame " .. v.ModName);
			
			v.ModFrame.SetPoint = function() end;
			
			v.ModFrame:ClearAllPoints();
			
			-- BHA_Debug("Off : X: " .. v.ModOriginalX .. " Y: " .. v.ModOriginalY);
			v.ModFrame:SetParent(ButtonholeAd_Minimap);
			v.ModOriginalSetPoint(v.ModFrame, "TOPLEFT", 0, 0);
			v.ModFrame:SetParent(Minimap);
			v.ModFrame:Hide();
			if (i == ButtonholeAd_Classic_Num) then v.ModFrame:Show(); ButtonholeAd_Minimap:Hide(); end
		end
	end
end

function ButtonholeAd_Classic_Wheel(arg1)
	if not (ButtonholeAd_Method == 0) then
		return nil;
	end
	local actualButtons = {};
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		if (ButtonholeAd_isButtonHoled(v.ModFrame)) then
			tinsert(actualButtons, v);
		end
	end
	ButtonholeAd_Classic_Num = ButtonholeAd_Classic_Num + arg1;
	if (ButtonholeAd_Classic_Num == -1) then ButtonholeAd_Classic_Num = table.getn(actualButtons); end
	if (ButtonholeAd_Classic_Num == table.getn(actualButtons)+1) then ButtonholeAd_Classic_Num = 0; end
	if (ButtonholeAd_Classic_Num == 0) then
		BHA_Debug("Classic : Setting frame to Buttonhole");
	else
		BHA_Debug("Classic : Setting frame to " .. actualButtons[ButtonholeAd_Classic_Num].ModFrame:GetName() );
	end
	
	for i,v in ipairs(actualButtons) do
		v.ModFrame:Hide();
		if (i == ButtonholeAd_Classic_Num) then v.ModFrame:Show(); end
	end
	
	if (ButtonholeAd_Classic_Num == 0) then
		ButtonholeAd_Minimap:Show();
	else
		local tmp = actualButtons[ButtonholeAd_Classic_Num];
		if (tmp.ModOriginalX == nil) or (tmp.ModOriginalY == nil) then
			ButtonholeAd_Minimap:Show();
		else
			ButtonholeAd_Minimap:Hide();
		end
	end
end


--------------------------------------------------------------------------


function ButtonholeAd_Menu_Init()
	if not (ButtonholeAd_Method == 1) then
		return nil;
	end
end

function ButtonholeAd_Menu_Click()
	if not (ButtonholeAd_Method == 1) then
		return nil;
	end
	BHA_Debug("Menu : Clicked");
end


--------------------------------------------------------------------------


ButtonholeAd_Expander_State = 0;

function ButtonholeAd_Expander_Init()
	if not (ButtonholeAd_Method == 2) then
		return nil;
	end
	ButtonholeAd_Expander_State = 0;
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		if not (ButtonholeAd_isButtonHoled(v.ModFrame)) then
			-- do nothing
		else
			BHA_Debug("Expander : Hiding frame " .. v.ModName);
			v.ModFrame:Hide();
		end
	end
end

function ButtonholeAd_Expander_Click()
	if not (ButtonholeAd_Method == 2) then
		return nil;
	end
	
	if (ButtonholeAd_Expander_State == 0) then
		for i,v in ipairs(ButtonholeAd_SwallowButtons) do
			if not (ButtonholeAd_isButtonHoled(v.ModFrame)) then
				-- do nothing
			else
				BHA_Debug("Expander : Showing frame " .. v.ModName);
				v.ModFrame:Show();
			end
		end
		ButtonholeAd_Expander_State = 1;
	else
		for i,v in ipairs(ButtonholeAd_SwallowButtons) do
			if not (ButtonholeAd_isButtonHoled(v.ModFrame)) then
				-- do nothing
			else
				BHA_Debug("Expander : Hiding frame " .. v.ModName);
				v.ModFrame:Hide();
			end
		end
		ButtonholeAd_Expander_State = 0;
	end
	
	BHA_Debug("Expander : Toggled");
end


--------------------------------------------------------------------------


function ButtonholeAd_Off_Init()
	-- if not (ButtonholeAd_Method == 3) then
	--	return nil;
	-- end
	ButtonholeAd_Minimap:Show();
	for i,v in ipairs(ButtonholeAd_SwallowButtons) do
		BHA_Debug("Off : Reshowing frame " .. v.ModName);
		
		v.ModFrame.SetPoint = v.ModOriginalSetPoint;
		
		if (v.ModOriginalX == nil) or (v.ModOriginalY == nil) then
			v.ModFrame:Show();
		else
			BHA_Debug("Off : X: " .. v.ModOriginalX .. " Y: " .. v.ModOriginalY .. " S: " .. v.ModOriginalS);
			v.ModFrame:ClearAllPoints();
			v.ModFrame:SetParent(UIParent);
			v.ModFrame:SetPoint("BOTTOMLEFT", "UIParent", v.ModOriginalX, v.ModOriginalY);
			v.ModFrame:SetParent(Minimap);
			v.ModFrame:Show();
		end
	end
end


---------------------------------------------------------------------------

function ButtonholeAd_ModConfig_Check()
	local name = this:GetText();
	local holed = ButtonholeAd_isButtonHoled(getglobal(name))
	if (holed == true) then
		BHA_Debug("Unholing ".. name);
		tinsert(ButtonholeAd_LeaveOutButtons, name);
		ButtonholeAd_UpdateMethodUI();
	else
		BHA_Debug("Holing ".. name);
		for index,txt in ipairs(ButtonholeAd_LeaveOutButtons) do
			if (txt == name) then
				tremove(ButtonholeAd_LeaveOutButtons, index);
				ButtonholeAd_UpdateMethodUI();
				return;
			end
		end
	end
end

function ButtonholeAd_ModConfig_Load()
	local x = 20;
	local y = -20;
	local space_after_block = 10;
	local space_after_end = 50;
	local height = 0;
	local width = 350;
	local tmpf1;
	local tmpf;
	
	tmpf1 = ButtonholeAdFrameMods:CreateFontString("TemporaryBHAFrame", "OVERLAY", "GameFontNormal");
	tmpf1:SetText(ButtonholeAd_text6);
	tmpf1:SetPoint("TOPLEFT", x, y);
	tmpf1:SetJustifyH("LEFT");
	tmpf1:SetWidth(width-(2*x));
	y = y - tmpf1:GetHeight() - space_after_block - 20;
	
	-- Beyond Here be Dragons
	
	for _,tmp in ipairs(ButtonholeAd_SwallowButtons) do
		tmpf = ButtonholeAdFrameMods:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
		tmpf:SetText(tmp.ModName);
		tmpf:SetPoint("TOPLEFT", x+30, y);
		tmpf:SetJustifyH("LEFT");
		tmpf:SetWidth(width-(2*(x+30)));
		
		tmpc = CreateFrame("CheckButton", nil, ButtonholeAdFrameMods, "OptionsCheckButtonTemplate");
		tmpc:SetPoint("CENTER", "ButtonholeAdFrameMods", "TOPLEFT", x+12, y-(tmpf:GetHeight()/2)-2);
		tmpc:SetText(tmp.ModFrame:GetName());
		tmpc:SetScript("OnClick", ButtonholeAd_ModConfig_Check);
		tmpc:SetChecked(true);
		for _,leave in ipairs(ButtonholeAd_LeaveOutButtons) do
			if (leave == tmp.ModFrame:GetName()) then
				tmpc:SetChecked(false);
			end
		end
		y = y - tmpf:GetHeight() - space_after_block;
	end
	height = (-y)+space_after_end;
	ButtonholeAdFrameMods:SetHeight(height);
	ButtonholeAdFrameMods:SetWidth(width);
end

function ButtonholeAd_ModConfig_Show()

end

function ButtonholeAd_ModConfig_Hide()

end