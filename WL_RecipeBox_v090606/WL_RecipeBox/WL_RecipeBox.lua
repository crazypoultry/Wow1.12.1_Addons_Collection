--  WL_RecipeBox
--  2005, Hackle
--
--	Deutsche Localization by Skulk
--
-- /rb                      to toggle visibility
-- /rb help                 shows slash commands
-- /rb deleteallyesyesyes   clears out all recipebox info, local recipes/reagents and players
-- /rb realmlist            lists realms you have recipes for
-- /rbrealm <realm name>      example /rbrealm Icecrown   has to be correctly capitalized
-- /rbcheck <recipe name>     example /rbcheck Herb Baked Egg   
--																		/rbcheck herb baked egg
--																		/rbcheck [Herb Baked Egg]
--
-- future plans
-- figure out how to highlight recipe that was clicked on, in the upper half of rb window
-- figure way to list recipes that take a certain ingredient
-- add alternative to show links for recipe reagents

RB_MAX_RECIPES_DISPLAYED = 8;
RB_MAX_RECIPE_REAGENTS = 8;
RB_RECIPE_HEIGHT = 16;
local Addon_Offset = 72;
local RB_Gathering_ATM = false;
local RB_Gathering_NonEnchant = false;
local RB_Gathering_Enchant = false;
local RB_Version = 032806; -- Version March 28, 2006
local RB_PlayerIndex = nil;
local RB_RealmIndex = nil;
local RB_TradeSkillIndex = nil;
local RB_Adding_Recipes_Index = 0;
local RB_Adding_Reagents_Index = 0;
local RB_Building_Recipe = false;
local RB_Recipe_Being_Built;
local RB_RecipesThisCharacter = 0;
local RB_ReagentsAdded, RB_RecipesAdded, RB_skillName, RB_AddingToRealm, RB_AddingToPlayer;

--Registers events, sets slash commands, and a few other random things, that effect entire addon
function WL_RecipeBox_OnLoad()
  -- events TRADE_SKILL_SHOW TRADE_SKILL_CLOSE CRAFT_SHOW CRAFT_CLOSE registered so RB knows when to show buttons to add player recipes
  this:RegisterEvent("TRADE_SKILL_SHOW");
  this:RegisterEvent("TRADE_SKILL_CLOSE");
  this:RegisterEvent("CRAFT_SHOW");
  this:RegisterEvent("CRAFT_CLOSE");
  -- events UNIT_NAME_UPDATE PLAYER_ENTERING_WORLD registered so RB knows when player has entered world so it can start doing stuff
  this:RegisterEvent("UNIT_NAME_UPDATE");
  this:RegisterEvent("PLAYER_ENTERING_WORLD");
  -- events ADDON_LOADED so it knows when Blizzards craft and tradeskill addons loaded, as well as so it can add functionality for some 3rd party addons
  this:RegisterEvent("ADDON_LOADED");
  this:RegisterEvent("VARIABLES_LOADED");
  
  -- this loop hides the scrollbar list on top half of window
  for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
    getglobal("RBList"..i):SetNormalTexture("");
    getglobal("RBList"..i):Hide();
  end
  RB_RecipeDetailsHide(); 
    
  SlashCmdList["RECIPEBOX"] = function(msg)
    RB_Cmd(msg);
  end 
  SlashCmdList["RECIPEBOXREALM"] = function(msg)
    RB_Cmd_Realm(msg);
  end 
  SlashCmdList["RECIPEBOXCHECK"] = function(msg)
    RB_Check(msg);
  end 
  SlashCmdList["RECIPEBOXOFFSET"] = function(msg)
    RB_AddButtonOffset(msg);
  end
  
  --  this command adds it to the table of frams that are moveable
  tinsert(UISpecialFrames,"RBFrame");
end

------------------------------------------
--  functions to handle RB_CharDropDown frame 
--  RB_CharDropDown_OnLoad()
--  RB_CharDropDown_Initialize()  
--  RB_CharDropDown_OnClick()
--  RB_CharDropDown_OnClick2()
--  code for using dropdown menus learned from Merphle's Bankstatement
------------------------------------------

function RB_CharDropDown_OnLoad()
  UIDropDownMenu_SetText(RB_SELECTPLAYER, this);
  --  unless slash command is used to change current realm, it defaults to realm player currently logged on
  RB_RealmIndex = tostring(GetCVar("realmName"));
  UIDropDownMenu_Initialize(this, RB_CharDropDown_Initialize);
end

function RB_CharDropDown_Initialize() 
  if (RecipeBox_ByPlayer) then 
    if (RecipeList) then
      local info = {};
      info.text = RB_KNOWNRECIPES;
      info.func = RB_CharDropDown_OnClick2;
      info.notCheckable = nil;
      info.keepShownOnClick = nil;
      UIDropDownMenu_AddButton(info);
    end
    if (RecipeBox_ByPlayer[RB_RealmIndex]) then 
      for index, item in RecipeBox_ByPlayer[RB_RealmIndex] do
        local info = {};
        local player = index;
        info.text = player;
        info.value = index;
        info.func = RB_CharDropDown_OnClick;
        info.notCheckable = nil;
        info.keepShownOnClick = nil;
        UIDropDownMenu_AddButton(info);
      end
    end   
  end   
end

--Handles Character Dropdown clicks if another value besides known recipes is selected
function RB_CharDropDown_OnClick()
  RB_PlayerIndex = tostring(this.value);
  UIDropDownMenu_SetText(this.value, RB_CharDropDown);
  UIDropDownMenu_SetText(RB_SELECTTRADESKILL, RB_SkillDropDown);
  for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
    getglobal("RBList"..i):Hide();
  end
  RB_RecipeDetailsHide();
end

--Handles Character Dropdown clicks if Known recipes is selected
function RB_CharDropDown_OnClick2()
  RB_PlayerIndex = tostring(this.value);
  UIDropDownMenu_SetText(RB_PlayerIndex, RB_CharDropDown);
  UIDropDownMenu_SetText(RB_SELECTTRADESKILL, RB_SkillDropDown);
  for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
    getglobal("RBList"..i):Hide();
  end
  RB_RecipeDetailsHide();
end

------------------------------------------
--  functions to handle RB_SkillDropDown frame 
--  RB_SkillDropDown_OnLoad()
--  RB_SkillDropDown_Initialize()
--  RB_SkillDropDown_OnClick()
--  RB_SkillDropDown_OnClick2()
------------------------------------------

function RB_SkillDropDown_OnLoad()
  UIDropDownMenu_Initialize(this, RB_SkillDropDown_Initialize);
  UIDropDownMenu_SetText(RB_SELECTTRADESKILL, this);
end

function RB_SkillDropDown_Initialize()
  if(RB_PlayerIndex ~= RB_KNOWNRECIPES) then
    if (RecipeBox_ByPlayer) then 
      if (RecipeBox_ByPlayer[RB_RealmIndex]) then 
        if (RecipeBox_ByPlayer[RB_RealmIndex][RB_PlayerIndex]) then 
          for index, item in RecipeBox_ByPlayer[RB_RealmIndex][RB_PlayerIndex] do
            local info = {};
            local skill = index;
            info.text = skill;
            info.value = index;
            info.func = RB_SkillDropDown_OnClick;
            info.notCheckable = nil;
            info.keepShownOnClick = nil;
            UIDropDownMenu_AddButton(info);
          end
        end
      end
    end
  else
    for index, item in RB_SkillList do
      local info = {};
      local skill = item;
      info.text = skill;
      info.value = item;
      info.func = RB_SkillDropDown_OnClick2;
      info.notCheckable = nil;
      info.keepShownOnClick = nil;
      UIDropDownMenu_AddButton(info);
    end
  end
end

function RB_SkillDropDown_OnClick()
  RB_TradeSkillIndex = tostring(this.value);
  UIDropDownMenu_SetText(this.value, RB_SkillDropDown);
  FauxScrollFrame_SetOffset(RBListScrollFrame, 0);
  for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
    getglobal("RBList"..i):Hide();
  end
  RBListScrollFrameScrollBar:SetMinMaxValues(0, 0); 
  RBListScrollFrameScrollBar:SetValue(0);
  RB_RecipeDetailsHide();
  local skillnow = tostring(RecipeBox_ByPlayer[RB_RealmIndex][RB_PlayerIndex][RB_TradeSkillIndex].currentskill);
  local skillhighest = tostring(RecipeBox_ByPlayer[RB_RealmIndex][RB_PlayerIndex][RB_TradeSkillIndex].maxskill);
  RBSkillRank:SetText(skillnow.."/"..skillhighest);
  getglobal("RBSkillRank"):Show();
  RB_Frame_Update();
end

function RB_SkillDropDown_OnClick2()
  RB_TradeSkillIndex = tostring(this.value);
  UIDropDownMenu_SetText(this.value, RB_SkillDropDown);
  FauxScrollFrame_SetOffset(RBListScrollFrame, 0);
  for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
    getglobal("RBList"..i):Hide();
  end
  RBListScrollFrameScrollBar:SetMinMaxValues(0, 0); 
  RBListScrollFrameScrollBar:SetValue(0);
  RB_RecipeDetailsHide();
  RB_Frame_Update();
end

------------------------------------------
--  functions to handle general RB stuff  
--  RB_Cmd(msg)
--  RB_Check(msg)
--  WL_RecipeBox_OnEvent(event, arg1)
--  RB_CheckVersion()
--  RB_SetLocalRecipeStructure()
--  RB_Cmd_RealmList()
--  RB_TakeApartLink(link)
--  RB_Toggle()
--  RB_GetRGBFromHexColor(hexColor)
--  RB_MakeIntFromHexString(str)
--  RB_ListIcon_OnClick(button)
--  RB_RecipeDetailsHide()
--  RB_Frame_Update()
--  RB_ShowRecipeDetails(recipe)
------------------------------------------

function RB_Cmd(msg)
  if(msg == "") then
    RB_Toggle();
  elseif(msg == RB_DELETEALLYESYESYES) then
    RB_ResetAllData();
    for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
      getglobal("RBList"..i):Hide();
    end
    UIDropDownMenu_SetText(RB_SELECTPLAYER, RB_CharDropDown);
    UIDropDownMenu_SetText(RB_SELECTTRADESKILL, RB_SkillDropDown);
    DEFAULT_CHAT_FRAME:AddMessage(RB_CLEAREDOUT);
  elseif(msg == RB_HELP) then
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..SLASH_RECIPEBOX1.." "..SLASH_RECIPEBOX2.." | "..RB_DELETEALLYESYESYES.." "..RB_HELP.." "..RB_REALMLIST);
  	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..SLASH_RECIPEBOXREALM1);
  	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..SLASH_RECIPEBOXCHECK1);
  	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..SLASH_RECIPEBOXOFFSET1);
  elseif(msg == RB_REALMLIST) then
    RB_Cmd_RealmList();
  --elseif(msg == "enchant") then
  
  elseif(msg == RB_TEST) then
  
  elseif(msg == "setnewlists") then
   WL_RB_SetNewLists();
  
  else
  	RB_Toggle(); 
  end
end

function RB_AddButtonOffset(msg)
	local buttonadjust = tonumber(msg);
	RecipeBox_Offset = 72 + buttonadjust;
	if(RBAddRecipe_Button:IsVisible()) then
		RBAddRecipe_Button:SetPoint("TOP", "TradeSkillFrame", "BOTTOM", 0, RecipeBox_Offset);
	end
	if(RBAddRecipe_Button2:IsVisible()) then
		RBAddRecipe_Button2:SetPoint("TOP", "CraftFrame", "BOTTOM", 0, RecipeBox_Offset);
	end
end

function RB_Check(msg)
  local msgLower;
  if(string.find(msg, "%[")) then
    local beginName = string.find(msg, "%[") + 1;
    local endName = string.find(msg, "%]") - 1;
    msg = string.sub(msg, beginName, endName);
    if(string.find(msg, "%:")) then
      beginName = string.find(msg, "%:") + 2;
      endName = string.len(msg);
      msg = string.sub(msg, beginName, endName);
    end
  end
  msgLower = string.lower(msg);
  local checkMessage = "|cff00ff00"..msg..RB_FOUNDIN;
  for index1 in RecipeBox_ByPlayer do
    if(index1 ~= "version") then 
      for index2 in RecipeBox_ByPlayer[index1] do
        for index3 in RecipeBox_ByPlayer[index1][index2] do
          for index4 in RecipeBox_ByPlayer[index1][index2][index3] do
            if(index4 ~= "maxskill" and index4 ~= "currentskill") then  
              local recipeLower = string.lower(RecipeBox_ByPlayer[index1][index2][index3][index4].name);
              if(recipeLower == msgLower) then
                checkMessage = checkMessage.." "..index2.."/"..index1;
              end
            end
          end
        end
      end
    end 
  end
  if (checkMessage ~= "|cff00ff00"..msg..RB_FOUNDIN) then
    DEFAULT_CHAT_FRAME:AddMessage(checkMessage);
  else
    DEFAULT_CHAT_FRAME:AddMessage(RB_NOCHARACTERS..msg..RB_NOCHARACTERS2);
  end
end

function WL_RecipeBox_OnEvent(event, arg1)
  if(event == "TRADE_SKILL_SHOW") then
    lTradeSkillFrame_OnHide_Orig = getglobal("TradeSkillFrame"):GetScript("OnHide");
		lTradeSkillCancelButton_OnClick_Orig = getglobal("TradeSkillCancelButton"):GetScript("OnClick");
		lTradeSkillFrameCloseButton_OnClick_Orig = getglobal("TradeSkillFrameCloseButton"):GetScript("OnClick");
    if(IsAddOnLoaded("FilterTradeSkill") == 1) then
    	RBAddRecipe_Button:SetPoint("TOP", "FilterTradeSkill", "BOTTOM", 0, 72);
    	ShowUIPanel(RBAddRecipe_Button);
    else--if(TradeSkillFrame:IsVisible()
    	if(RecipeBox_Offset) then
    		RBAddRecipe_Button:SetPoint("TOP", "TradeSkillFrame", "BOTTOM", 0, RecipeBox_Offset);
    	else
    		RBAddRecipe_Button:SetPoint("TOP", "TradeSkillFrame", "BOTTOM", 0, Addon_Offset);
    	end
    	ShowUIPanel(RBAddRecipe_Button);
  	end
  elseif(event == "TRADE_SKILL_CLOSE") then
    HideUIPanel(RBAddRecipe_Button);
    RB_CheckWindows();
    RB_ResetTradeSkillFunctions();
  	getglobal("RBAddRecipe_Button"):SetScript("OnUpdate", RB_EmptyFunction);
		getglobal("RBAddRecipe_Button2"):SetScript("OnUpdate", RB_EmptyFunction);
  	if(RB_Adding_Recipes_Index ~= 0) then
  		RB_Adding_Recipes_Index = 0;
			getglobal("RBAddRecipe_ButtonText"):SetText(RB_ADDTORB);
  		if(RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName])then
  			RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName] = {};
  			DEFAULT_CHAT_FRAME:AddMessage(RB_INTERUPT..RB_AddingToPlayer.."'s "..RB_skillName..RB_INTERUPT2);
  		end
  		if(RecipeBox_LocalRecipes[RB_skillName])then
  			RecipeBox_LocalRecipes[RB_skillName] = {};
  			DEFAULT_CHAT_FRAME:AddMessage(RB_INTERUPT..RB_skillName.." "..RB_INTERUPT3);
  		end
  	end
  elseif(event == "CRAFT_SHOW") then
  	if(GetCraftName() == RB_ENCHANTING) then
  		lCraftFrame_OnHide_Orig = getglobal("CraftFrame"):GetScript("OnHide");
			lCraftCancelButton_OnClick_Orig = getglobal("CraftCancelButton"):GetScript("OnClick");
			lCraftFrameCloseButton_OnClick_Orig = getglobal("CraftFrameCloseButton"):GetScript("OnClick");
  		if(RecipeBox_Offset) then
  			RBAddRecipe_Button2:SetPoint("TOP", "CraftFrame", "BOTTOM", 0, RecipeBox_Offset);
    	else
  			RBAddRecipe_Button2:SetPoint("TOP", "CraftFrame", "BOTTOM", 0, Addon_Offset);
  		end
  		ShowUIPanel(RBAddRecipe_Button2);
  	end
  elseif(event == "CRAFT_CLOSE" and not CraftFrame:IsVisible()) then
    HideUIPanel(RBAddRecipe_Button2);
    RB_CheckWindows();
    RB_ResetCraftFunctions();
  	getglobal("RBAddRecipe_Button"):SetScript("OnUpdate", RB_EmptyFunction);
		getglobal("RBAddRecipe_Button2"):SetScript("OnUpdate", RB_EmptyFunction);
  	if(RB_Adding_Recipes_Index ~= 0)then
			RB_Adding_Recipes_Index = 0;
			getglobal("RBAddRecipe_Button2Text"):SetText(RB_ADDTORB);
			if(RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName])then
				RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName] = {};
				DEFAULT_CHAT_FRAME:AddMessage(RB_INTERUPT..RB_AddingToPlayer.."'s "..RB_skillName..RB_INTERUPT2);
				DEFAULT_CHAT_FRAME:AddMessage("hit 366");
				--RB_ResetCraftFunctions();
			end
			if(RecipeBox_LocalRecipes[RB_skillName])then
				RecipeBox_LocalRecipes[RB_skillName] = {};
				DEFAULT_CHAT_FRAME:AddMessage(RB_INTERUPT..RB_skillName.." "..RB_INTERUPT3);
  			--RB_ResetCraftFunctions();
  		end
  	end
  elseif(event == "ADDON_LOADED") then
		if(IsAddOnLoaded("Blizzard_TradeSkillUI") == 1) then
			lTradeSkillFrame_OnHide_Orig = getglobal("TradeSkillFrame"):GetScript("OnHide");
			lTradeSkillCancelButton_OnClick_Orig = getglobal("TradeSkillCancelButton"):GetScript("OnClick");
			lTradeSkillFrameCloseButton_OnClick_Orig = getglobal("TradeSkillFrameCloseButton"):GetScript("OnClick");
		elseif(IsAddOnLoaded("Blizzard_CraftUI") == 1) then
			lCraftFrame_OnHide_Orig = getglobal("CraftFrame"):GetScript("OnHide");
			lCraftCancelButton_OnClick_Orig = getglobal("CraftCancelButton"):GetScript("OnClick");
			lCraftFrameCloseButton_OnClick_Orig = getglobal("CraftFrameCloseButton"):GetScript("OnClick");
		end
  elseif(event=="UNIT_NAME_UPDATE" or event=="PLAYER_ENTERING_WORLD") then
  -- the code for using UNIT_NAME_UPDATE and PLAYER_ENTERING_WORLD to verify player is entered taken almost verbatim from Jooky's StartUp addon
    RB_PlayerIndex = UnitName("player");
    if (RB_PlayerIndex == nil or RB_PlayerIndex == UNKNOWNOBJECT or RB_PlayerIndex == UNKNOWNBEING) then
      return;
    else
      RB_CheckVersion();
    end
  elseif(event=="VARIABLES_LOADED") then
		RB_SetLocalRecipeStructure();
	end
end

function RBListButton_OnClick(button)
  if (button == "LeftButton" and not this.header) then
    --not sure how to correctly reference the button that was clicked example was "TradeSkillSkill"..i to make clicked button highlighted
    --RBHighlightFrame:SetPoint("TOPLEFT", this, "TOPLEFT", 0, 0);
    --RBHighlightFrame:Show();
    RBRecipeIndex = this:GetText();
    RB_ShowRecipeDetails(RBRecipeIndex);
  end
end

function RB_CheckVersion()
  if(RecipeBox_ByPlayer) then
    if(RecipeBox_ByPlayer.version) then
      if(RecipeBox_ByPlayer.version == RB_Version) then
        return;
      else  
        DEFAULT_CHAT_FRAME:AddMessage(RB_OUTOFDATE); 
        RB_ResetAllData();
      end
    else
      DEFAULT_CHAT_FRAME:AddMessage(RB_NOVERSION); 
      RB_ResetAllData();
    end
  else
    DEFAULT_CHAT_FRAME:AddMessage(RB_FIRSTLOAD); 
    RB_ResetAllData();
  end
end

function RB_CheckWindows()
	if(IsAddOnLoaded("Blizzard_CraftUI")) then
		if(not CraftFrame:IsVisible()) then
			if(RB_Gathering_Enchant == true) then
				RB_ResetCraftFunctions();
				RB_Gathering_Enchant = false;
				RB_Gathering_ATM = false;
			end
		end		
	end
	if(IsAddOnLoaded("Blizzard_TradeSkillUI")) then
		if(not TradeSkillFrame:IsVisible()) then
			if(RB_Gathering_NonEnchant == true) then	
				RB_ResetTradeSkillFunctions();
				RB_Gathering_NonEnchant = false;
				RB_Gathering_ATM = false;
			end
		end
	end
end

function RB_ResetAllData()
	RecipeBox_ByPlayer = {};
  RecipeBox_ByPlayer.version = RB_Version;
  RecipeBox_LocalRecipes = {};
  RecipeBox_LocalReagents = {};
  RecipeBox_LocalTextures = {};
  RB_SetLocalRecipeStructure();
  RecipeBox_Offset = 72;
end

function RB_SetLocalRecipeStructure()
	if(RecipeBox_LocalRecipes) then  
    for index1 = 1, getn(RB_SkillList), 1 do
			if(not RecipeBox_LocalRecipes[RB_SkillList[index1]]) then
				RecipeBox_LocalRecipes[RB_SkillList[index1]] = {};
			end	
		end
	else
		RecipeBox_LocalRecipes = {};
		for index1 = 1, getn(RB_SkillList), 1 do
			RecipeBox_LocalRecipes[RB_SkillList[index1]] = {};
		end
	end    
end

function RB_Cmd_RealmList()
  if(RecipeBox_ByPlayer) then
    local realms = "Available realms: ";
    for index in RecipeBox_ByPlayer do
      if(index ~= "version") then  
      realms = realms..tostring(index)..", ";
      end 
    end
    DEFAULT_CHAT_FRAME:AddMessage(realms);
  end
end 
  
function RB_Cmd_Realm(msg)
  if(RecipeBoxByPlayer) then
    if(RecipeBox_ByPlayer[msg]) then
      RB_RealmIndex = msg;
      DEFAULT_CHAT_FRAME:AddMessage("Changed to "..msg.." realm");
      RB_CharDropDown_Initialize(); 
    else
      DEFAULT_CHAT_FRAME:AddMessage(msg.." not found"); 
    end
  end
end

function RB_TakeApartLink(link)
--Taken from Telo LootLink, dont even ask me how the text matching works, LUA manual didnt make any sense to me.
--returns name, item, color
  local color, item, name, linkcolor, linkitem, linkname;
  if(link) then
    if(string.find(link, "item")) then
    	for color, item, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
    	  if( color and item and name ) then
    	    linkname = name;
    	    linkitem = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:%2:%3:%4");
    	    linkcolor = color;
    	  end
    	end
 		elseif(string.find(link, "enchant")) then
 			for color, item, name in string.gfind(link, "|c(%x+)|Henchant:(%d+)|h%[(.-)%]|h|r") do
			  if( color and item and name ) then
			    linkname = name;
			    linkitem = string.gsub(item, "^(%d+)$", "%1");
			    linkcolor = color;
			  end
    	end
 		end
  end
  if(linkcolor and linkitem and linkname) then
    return linkname, linkitem, linkcolor;
  end
end

function RB_Toggle()
  if(RBFrame:IsVisible()) then
    HideUIPanel(RBFrame);
  else
    ShowUIPanel(RBFrame);
  end
end

function RB_GetRGBFromHexColor(hexColor)
--Taken from Telo's LootLink
  local red = RB_MakeIntFromHexString(strsub(hexColor, 3, 4)) / 255;
  local green = RB_MakeIntFromHexString(strsub(hexColor, 5, 6)) / 255;
  local blue = RB_MakeIntFromHexString(strsub(hexColor, 7, 8)) / 255;
  return red, green, blue;
end

function RB_MakeIntFromHexString(str)
--Taken from Telo's LootLink
  local remain = str;
  local amount = 0;
  while( remain ~= "" ) do
    amount = amount * 16;
    local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
    if( byteVal >= string.byte("0") and byteVal <= string.byte("9") ) then
      amount = amount + (byteVal - string.byte("0"));
    elseif( byteVal >= string.byte("A") and byteVal <= string.byte("F") ) then
      amount = amount + 10 + (byteVal - string.byte("A"));
    end
    remain = strsub(remain, 2);
  end
  return amount;
end

function RB_ListIcon_OnClick(button)
  if (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
    if(button == "LeftButton" and this.link ~= nil) then
      ChatFrameEditBox:Insert(this.link);
    elseif(button == "RightButton" and this.recipeforchat ~= nil) then
      ChatFrameEditBox:Insert(this.recipeforchat);
    end
  end
end

function RB_RecipeDetailsHide()
  for i=1, RB_MAX_RECIPE_REAGENTS, 1 do
    getglobal("RBReagent"..i):Hide();
  end
  
  getglobal("RBReagentLabel"):Hide();
  getglobal("RBToolsLabel"):Hide();
  getglobal("RBRecipeLabel"):Hide();
  getglobal("RBDetailHeaderLeft"):Hide();
  getglobal("RBListIcon"):Hide();
  getglobal("RBRecipeDescription"):Hide();
  getglobal("RBSkillRank"):Hide();
end

function RB_Frame_Update()
  if(RB_RealmIndex and RB_PlayerIndex and RB_TradeSkillIndex and RB_PlayerIndex ~= RB_KNOWNRECIPES) then
    local recipeCount = 0;
    for index in RecipeBox_ByPlayer[RB_RealmIndex][RB_PlayerIndex][RB_TradeSkillIndex] do
      recipeCount = recipeCount + 1;
    end
    --subract 2 from recipeCount to account for skillCurrentSkill and skillMaxSkill which are not recipes but are inside that table
    recipeCount = recipeCount - 2;
    local recipeOffset = FauxScrollFrame_GetOffset(RBListScrollFrame);
    FauxScrollFrame_Update(RBListScrollFrame, recipeCount, RB_MAX_RECIPES_DISPLAYED, RB_RECIPE_HEIGHT);
    for listCount = 1, RB_MAX_RECIPES_DISPLAYED, 1 do
      local recipeIndex = listCount + recipeOffset;
      if(recipeIndex <= recipeCount) then
        local recipeButton = getglobal("RBList"..listCount);
        local item, color, header;
        --DEFAULT_CHAT_FRAME:AddMessage(recipeIndex);
        local recipe = RecipeBox_ByPlayer[RB_RealmIndex][RB_PlayerIndex][RB_TradeSkillIndex][tostring(recipeIndex)].name;
        --DEFAULT_CHAT_FRAME:AddMessage(recipe);
        if(RecipeBox_ByPlayer[RB_RealmIndex][RB_PlayerIndex][RB_TradeSkillIndex][tostring(recipeIndex)].header) then
          header = true;
          recipeButton.header = true;
        else
          header = false;
          _, item, color = RB_TakeApartLink(RB_GetRecipeInfo(recipe).link);
          recipeButton.header = false;
        end
        local buttonColor = { };
        name = recipe;
        recipeButton:SetText(recipe);
        if(color and header == false) then
          if(color ~= "ffffffff") then
          buttonColor.r, buttonColor.g, buttonColor.b = RB_GetRGBFromHexColor(color);
            recipeButton:SetTextColor(buttonColor.r, buttonColor.g, buttonColor.b);
          else
            recipeButton:SetTextColor(1.0, 1.0, 1.0);
          end
        elseif(header == true) then
          recipeButton:SetTextColor(1.0, 0.82, 0);
        end
        recipeButton:Show();
      end 
    end
  elseif(RB_PlayerIndex == RB_KNOWNRECIPES) then
    local recipeCount = 1;
    local recipeTable = {}; 
    for index in RecipeBox_LocalRecipes[RB_TradeSkillIndex] do
      recipeTable[recipeCount] = index;
      recipeCount = recipeCount + 1;
    end
    for index in RecipeList[RB_TradeSkillIndex] do
      recipeTable[recipeCount] = index;
      recipeCount = recipeCount + 1;
    end
    recipeCount = recipeCount - 1;
    table.sort(recipeTable);
    local recipeOffset = FauxScrollFrame_GetOffset(RBListScrollFrame);
    FauxScrollFrame_Update(RBListScrollFrame, recipeCount, RB_MAX_RECIPES_DISPLAYED, RB_RECIPE_HEIGHT);
    for listCount = 1, RB_MAX_RECIPES_DISPLAYED, 1 do
      local recipeIndex = listCount + recipeOffset;
      if(recipeIndex <= recipeCount) then
        local recipeButton = getglobal("RBList"..listCount);
        recipeButton.header = false;
        local recipe = recipeTable[recipeIndex];
        local item, color;
        local buttonColor = { };
        local link = RB_GetRecipeInfo(recipe).link;
        _, item, color = RB_TakeApartLink(link);
        recipeButton:SetText(recipe);
        if(color ) then
          if(color ~= "ffffffff") then
            buttonColor.r, buttonColor.g, buttonColor.b = RB_GetRGBFromHexColor(color);
            recipeButton:SetTextColor(buttonColor.r, buttonColor.g, buttonColor.b);
          else
            recipeButton:SetTextColor(1.0, 1.0, 1.0);
          end
        end
        recipeButton:Show();
      end 
    end 
  recipeTable = {};
  end
end

function RB_ShowRecipeDetails(recipe)
  RB_RecipeDetailsHide();
  RBListIcon.hyperlink = nil;
  RBListIcon.link = nil;
  local recipeforchat = nil;
  local recipeInfo = RB_GetRecipeInfo(recipe);
  local recipeTexture = nil;
  if(recipeInfo.link) then
    local _, recipeItem = RB_TakeApartLink(recipeInfo.link);
    if(RB_TradeSkillIndex == RB_ENCHANTING) then
    	RBListIcon.hyperlink = "enchant:"..recipeItem;
    else
    	RBListIcon.hyperlink = "item:"..recipeItem;
    end
    recipeTexture = RB_GetTexture(recipe);   
    RBListIcon.link = recipeInfo.link;
    if(recipeInfo.minNumMakes and recipeInfo.minNumMakes ~= 1) then
      if(recipeInfo.maxNumMakes) then
        recipeforchat = "("..recipeInfo.minNumMakes.."-"..recipeInfo.maxNumMakes..")".."x"..recipeInfo.link..": ";
      else
        recipeforchat = recipeInfo.minNumMakes.."x"..recipeInfo.link..": ";
      end
    else
      recipeforchat = recipeInfo.link..": ";
    end
  end
  if(recipeInfo ~= nil) then
    RBRecipeLabel:SetText(recipe);
    getglobal("RBRecipeLabel"):Show();
  end
  if(recipeInfo.tools and recipeInfo.tools ~= "") then
    RBToolsLabel:SetText(REQUIRES_LABEL.." "..recipeInfo.tools);
    getglobal("RBToolsLabel"):Show();
  else
  end
  if(recipeTexture ~= nil) then
    RBListIcon:SetNormalTexture(recipeTexture);
    getglobal("RBListIcon"):Show();
    getglobal("RBDetailHeaderLeft"):Show();
   	if (recipeInfo.minNumMakes) then
      if(recipeInfo.maxNumMakes) then
        RBListIconCount:SetText(recipeInfo.minNumMakes.."-"..recipeInfo.maxNumMakes);  
      else
        RBListIconCount:SetText(recipeInfo.minNumMakes);
      end
    else
      RBListIconCount:SetText("");
    end
  end
  local reagentOffset = 1;
  if(recipeInfo["reagents"]) then
    getglobal("RBReagentLabel"):Show();
    local numReagents = 0;
    for coutingreagents in recipeInfo["reagents"] do
      numReagents = numReagents + 1;
    end
    for currentReagent in recipeInfo["reagents"] do
      local nameonButton = getglobal("RBReagent"..reagentOffset.."Name"); 
      local countonButton = getglobal("RBReagent"..reagentOffset.."Count");
      local reagentButton = getglobal("RBReagent"..reagentOffset);
      local reagentName = tostring(currentReagent);
      local reagentLink = RB_GetReagentInfo(reagentName);
      local reagentTexture = RB_GetTexture(reagentName);
      local _, reagentitem = RB_TakeApartLink(reagentLink);
      reagentButton.link = reagentLink;
      reagentButton.hyperlink = "item:"..reagentitem;
      SetItemButtonTexture(reagentButton, reagentTexture);
			reagentButton:Show();
      nameonButton:SetText(reagentName);
      countonButton:SetText(tostring(recipeInfo["reagents"][currentReagent].count));
      if(recipeforchat ~= nil) then
        if(reagentLink) then
          recipeforchat = recipeforchat.." "..recipeInfo["reagents"][currentReagent].count.."x "..reagentName;
        elseif(recipeInfo.description and reagentLink) then
          recipeforchat = recipeforchat.." "..recipeInfo["reagents"][currentReagent].count.."x "..reagentName;
        end
        if(reagentOffset < numReagents) then
          recipeforchat = recipeforchat..", ";
        end
      end 
      reagentOffset = reagentOffset + 1;
    end
  RBListIcon.recipeforchat = recipeforchat;
  end
end

------------------------------------------
--  functions to handle recipes 
--  RB_Add_Non_Enchant_OnUpdate(elapsed)
--	RB_Add_Enchant_OnUpdate(elapsed)
--  RB_AddPlayerRecipes(msg)
--  RB_AddRecipeToLocal(RB_skillName, recipeText, recipeTable)
--  RB_AddReagentToLocal(reagentText, reagentTable)
--  RB_CheckRecipe(RB_skillName, recipe)
--  RB_CheckReagent(reagent)
--  RB_GetRecipeInfo(recipe)
--  RB_GetReagentInfo(reagentName)
------------------------------------------
function RB_NewEntryOnPlayerList(texti, recipeName)
	RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName][texti] = {};
	RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName][texti].name = recipeName;
end

function RB_Add_Non_Enchant_OnUpdate(elapsed)
	if(RB_Gathering_Enchant == true) then
		return
	elseif(RB_Gathering_ATM == true and RB_Gathering_NonEnchant == true) then
		if(RB_Adding_Recipes_Index <= GetNumTradeSkills()) then	
			if(RB_Building_Recipe == false) then
				local recipeName, skillType = GetTradeSkillInfo(RB_Adding_Recipes_Index);
				local texti = tostring(RB_Adding_Recipes_Index);
				if(recipeName) then
					RB_NewEntryOnPlayerList(texti, recipeName);
					if (skillType == "header") then
						RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName][texti].header = true;
						RB_Adding_Recipes_Index = RB_Adding_Recipes_Index + 1;
						return;
					else
						RB_RecipesThisCharacter = RB_RecipesThisCharacter + 1;
						if(RB_CheckRecipe(RB_skillName, recipeName) == false) then
							local minNumMakes, maxNumMakes = GetTradeSkillNumMade(RB_Adding_Recipes_Index);
							local recipeLink = GetTradeSkillItemLink(RB_Adding_Recipes_Index);
							local recipeTexture = GetTradeSkillIcon(RB_Adding_Recipes_Index);
							local recipeTools = BuildColoredListString(GetTradeSkillTools(RB_Adding_Recipes_Index));
							if(minNumMakes and recipeLink and recipeTexture) then
								RB_Recipe_Being_Built = {};
								RB_Recipe_Being_Built["reagents"] = {};
								RB_Building_Recipe = true;
								RB_Adding_Reagents_Index = 1;
								RB_Recipe_Being_Built.tools = recipeTools;
								RB_Recipe_Being_Built.link = recipeLink;
								RB_CheckTexture(recipeName, recipeTexture);
								if(minNumMakes) then
									RB_Recipe_Being_Built.minNumMakes = minNumMakes;
									if(maxNumMakes) then
										if(minNumMakes < maxNumMakes) then
											RB_Recipe_Being_Built.maxNumMakes = maxNumMakes;
										end
									end
								end
							end
						else
							RB_Adding_Recipes_Index = RB_Adding_Recipes_Index + 1;
						end
					end
				end
			else
				local reagentName, reagentTexture, reagentCount = GetTradeSkillReagentInfo(RB_Adding_Recipes_Index, RB_Adding_Reagents_Index);
				local reagentLink = GetTradeSkillReagentItemLink(RB_Adding_Recipes_Index, RB_Adding_Reagents_Index);
				if(reagentName and reagentTexture and reagentCount and reagentLink) then
					if(RB_Adding_Reagents_Index < GetTradeSkillNumReagents(RB_Adding_Recipes_Index) and RB_Building_Recipe == true) then
						RB_CheckReagent(reagentName, reagentLink);
						RB_CheckTexture(reagentName, reagentTexture);
						RB_Recipe_Being_Built["reagents"][reagentName] = {};
						RB_Recipe_Being_Built["reagents"][reagentName].count = reagentCount;
						RB_Adding_Reagents_Index = RB_Adding_Reagents_Index + 1;
					else
						RB_CheckReagent(reagentName, reagentLink);
						RB_CheckTexture(reagentName, reagentTexture);
						RB_Recipe_Being_Built["reagents"][reagentName] = {};
						RB_Recipe_Being_Built["reagents"][reagentName].count = reagentCount;
						RB_AddRecipeToLocal(RB_skillName, GetTradeSkillInfo(RB_Adding_Recipes_Index), RB_Recipe_Being_Built);  
						RB_Building_Recipe = false;
						RB_Adding_Recipes_Index = RB_Adding_Recipes_Index + 1;
						RB_Adding_Reagents_Index = RB_Adding_Reagents_Index + 1;
					end
				end
			end	
		else
			RB_Gathering_NonEnchant = false;
			RB_Gathering_ATM = false;
		end
	elseif(RB_Adding_Recipes_Index > GetNumTradeSkills() and RB_Gathering_Enchant == false) then	
		if(RB_Adding_Recipes_Index ~= (GetNumTradeSkills()+1) or GetTradeSkillLine() ~= RB_skillName) then
		 	RB_Adding_Recipes_Index = 0;
			RB_Gathering_NonEnchant = false;
			RB_Gathering_ATM = false;
			RB_Gathering_Enchant = false;
			getglobal("RBAddRecipe_ButtonText"):SetText(RB_ADDTORB);
		 	RB_ResetTradeSkillFunctions();
		 	getglobal("RBAddRecipe_Button"):SetScript("OnUpdate", RB_EmptyFunction);
			getglobal("RBAddRecipe_Button2"):SetScript("OnUpdate", RB_EmptyFunction);
		 	if(RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName])then
		 		RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName] = {};
		 		DEFAULT_CHAT_FRAME:AddMessage(RB_INTERUPT..RB_AddingToPlayer.."'s".." "..RB_skillName..RB_INTERUPT2);
		 		DEFAULT_CHAT_FRAME:AddMessage("gathering enchant = "..RB_Gathering_Enchant);
		 	end
		 	if(RecipeBox_LocalRecipes[RB_skillName])then
		 		RecipeBox_LocalRecipes[RB_skillName] = {};
		 		DEFAULT_CHAT_FRAME:AddMessage("hit 853");
		 	end
  		return;
  	end
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..RB_RecipesThisCharacter..RB_RECIPESIN..RB_AddingToPlayer.."'s "..RB_skillName);
		if (RB_RecipesAdded ~= 0 or RB_ReagentsAdded ~= 0) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..RB_RecipesAdded..RB_RECIPESAND..RB_ReagentsAdded..RB_RECIPESADDED);
		end
		for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
			getglobal("RBList"..i):Hide();
		end 
		UIDropDownMenu_SetText(RB_SELECTTRADESKILL, RB_SkillDropDown);
		UIDropDownMenu_SetText(RB_SELECTPLAYER, RB_CharDropDown);
		RB_RecipeDetailsHide();
		RB_ResetTradeSkillFunctions();
		getglobal("RBAddRecipe_Button"):SetScript("OnUpdate", RB_EmptyFunction);
		getglobal("RBAddRecipe_Button2"):SetScript("OnUpdate", RB_EmptyFunction);
		RB_Adding_Recipes_Index = 0;
		getglobal("RBAddRecipe_ButtonText"):SetText(RB_ADDTORB);
		DEFAULT_CHAT_FRAME:AddMessage(RB_SAFE ..RB_skillName..RB_WINDOW);
	end
end

function RB_Add_Enchant_OnUpdate(elapsed)
	if(RB_Gathering_NonEnchant == true) then
		return;
	elseif(RB_Gathering_ATM == true and RB_Gathering_Enchant == true) then
		if(RB_Adding_Recipes_Index <= GetNumCrafts()) then	
			if(RB_Building_Recipe == false) then
				local recipeName, _, skillType = GetCraftInfo(RB_Adding_Recipes_Index);
				local texti = tostring(RB_Adding_Recipes_Index);
				if(recipeName) then
					RB_NewEntryOnPlayerList(texti, recipeName);
					if (skillType == "header") then
						RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName][texti].header = true;
						RB_Adding_Recipes_Index = RB_Adding_Recipes_Index + 1;
						return;
					else
						RB_RecipesThisCharacter = RB_RecipesThisCharacter + 1;
						if(RB_CheckRecipe(RB_skillName, recipeName) == false) then
							local recipeLink = GetCraftItemLink(RB_Adding_Recipes_Index);
							local recipeTexture = GetCraftIcon(RB_Adding_Recipes_Index);
							local recipeTools = BuildColoredListString(GetCraftSpellFocus(RB_Adding_Recipes_Index));
							local recipeDescription = GetCraftDescription(RB_Adding_Recipes_Index);
							if(recipeLink and recipeTexture) then
								RB_Recipe_Being_Built = {};
								RB_Recipe_Being_Built["reagents"] = {};
								RB_Building_Recipe = true;
								RB_Adding_Reagents_Index = 1;
								RB_Recipe_Being_Built.tools = recipeTools;
								RB_Recipe_Being_Built.link = recipeLink;
								RB_CheckTexture(recipeName, recipeTexture);
								if(recipeDescription) then
							  	RB_Recipe_Being_Built.description = recipeDescription;
  							end
							end
						else
							RB_Adding_Recipes_Index = RB_Adding_Recipes_Index + 1;
						end
					end
				end
			else
				local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo(RB_Adding_Recipes_Index, RB_Adding_Reagents_Index);
				local reagentLink = GetCraftReagentItemLink(RB_Adding_Recipes_Index, RB_Adding_Reagents_Index);
				if(reagentName and reagentTexture and reagentCount and reagentLink) then
					if(RB_Adding_Reagents_Index < GetCraftNumReagents(RB_Adding_Recipes_Index)) then
						RB_CheckReagent(reagentName, reagentLink);
						RB_CheckTexture(reagentName, reagentTexture);
						RB_Recipe_Being_Built["reagents"][reagentName] = {};
						RB_Recipe_Being_Built["reagents"][reagentName].count = reagentCount;
						RB_Adding_Reagents_Index = RB_Adding_Reagents_Index + 1;
					else
						RB_CheckReagent(reagentName, reagentLink);
						RB_CheckTexture(reagentName, reagentTexture);
						RB_Recipe_Being_Built["reagents"][reagentName] = {};
						RB_Recipe_Being_Built["reagents"][reagentName].count = reagentCount;
						RB_AddRecipeToLocal(RB_skillName, GetCraftInfo(RB_Adding_Recipes_Index), RB_Recipe_Being_Built);  
						RB_Building_Recipe = false;
						RB_Adding_Recipes_Index = RB_Adding_Recipes_Index + 1;
						RB_Adding_Reagents_Index = RB_Adding_Reagents_Index + 1;
					end
				end
			end	
		else
			RB_Gathering_Enchant = false;
			RB_Gathering_ATM = false;
		end	
	elseif(RB_Adding_Recipes_Index > GetNumCrafts() and RB_Gathering_NonEnchant == false) then	
		if(RB_Adding_Recipes_Index ~= (GetNumCrafts()+1) or GetCraftName() ~= RB_skillName) then
			RB_Adding_Recipes_Index = 0;
			RB_Gathering_NonEnchant = false;
			RB_Gathering_ATM = false;
			RB_Gathering_Enchant = false;
			getglobal("RBAddRecipe_Button2Text"):SetText(RB_ADDTORB);
			RB_ResetCraftFunctions();
			getglobal("RBAddRecipe_Button"):SetScript("OnUpdate", RB_EmptyFunction);
			getglobal("RBAddRecipe_Button2"):SetScript("OnUpdate", RB_EmptyFunction);
			if(RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName])then
				RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName] = {};
				DEFAULT_CHAT_FRAME:AddMessage(RB_INTERUPT..RB_AddingToPlayer.."'s".." "..RB_skillName..RB_INTERUPT2);
				DEFAULT_CHAT_FRAME:AddMessage("hit 953");
			end
			if(RecipeBox_LocalRecipes[RB_skillName])then
				RecipeBox_LocalRecipes[RB_skillName] = {};
				DEFAULT_CHAT_FRAME:AddMessage(RB_INTERUPT..RB_skillName..RB_INTERUPT3);
			end
			return;
  	end
		RB_ResetCraftFunctions();
		getglobal("RBAddRecipe_Button"):SetScript("OnUpdate", RB_EmptyFunction);
		getglobal("RBAddRecipe_Button2"):SetScript("OnUpdate", RB_EmptyFunction);
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..RB_RecipesThisCharacter..RB_RECIPESIN..RB_AddingToPlayer.."'s "..RB_skillName);
		if (RB_RecipesAdded ~= 0 or RB_ReagentsAdded ~= 0) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00"..RB_RecipesAdded..RB_RECIPESAND..RB_ReagentsAdded..RB_RECIPESADDED);
		end
		for i=1, RB_MAX_RECIPES_DISPLAYED, 1 do
			getglobal("RBList"..i):Hide();
		end 
		UIDropDownMenu_SetText(RB_SELECTTRADESKILL, RB_SkillDropDown);
		UIDropDownMenu_SetText(RB_SELECTPLAYER, RB_CharDropDown);
		RB_RecipeDetailsHide();
		RB_Adding_Recipes_Index = 0;
		getglobal("RBAddRecipe_Button2Text"):SetText(RB_ADDTORB);
		DEFAULT_CHAT_FRAME:AddMessage(RB_SAFE ..RB_skillName..RB_WINDOW);
		RB_ResetCraftFunctions();
	end
end

function RB_AddPlayerRecipes(msg)
--msg should be 1 for all non enchanting skills, 2 for enchanting
  if(RB_Gathering_ATM == true) then
  	DEFAULT_CHAT_FRAME:AddMessage(RB_SLOWDOWN);
  	return;
  end
  if(not RecipeBox_ByPlayer) then
    RB_ResetAllData();
    DEFAULT_CHAT_FRAME:AddMessage(RB_INITIALIZED);  
  end
  if(RecipeBox_ByPlayer.version ~= RB_Version) then
    RB_ResetAllData();
    RecipeBox_ByPlayer.version = RB_Version;
    DEFAULT_CHAT_FRAME:AddMessage(RB_OUTOFDATE);  
  end 
  RB_ReagentsAdded = 0; 
  RB_RecipesAdded = 0;
  RB_RecipesThisCharacter = 0
  RB_AddingToRealm = GetCVar("realmName");
  RB_AddingToPlayer = UnitName("player");
  if(not RecipeBox_ByPlayer[RB_AddingToRealm]) then
    RecipeBox_ByPlayer[RB_AddingToRealm] = {};
  end
  if(not RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer]) then
    RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer] = {};
  end
  if(msg == 1 and RB_Gathering_ATM == false) then
    if(TradeSkillFrame:IsVisible()) then
      RB_HijackTradeSkillFunctions();
      getglobal("RBAddRecipe_ButtonText"):SetText(RB_GATHERING);
      RB_skillName = GetTradeSkillLine();
      local _, skillCurrentSkill, skillMaxSkill = GetTradeSkillLine();
      RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName] = {};
      RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName].currentskill = skillCurrentSkill;
      RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName].maxskill = skillMaxSkill;
      RB_Adding_Recipes_Index = 1;
      RB_Gathering_NonEnchant = true;
      RB_Gathering_ATM = true;
			DEFAULT_CHAT_FRAME:AddMessage(RB_DONOTCLOSETRADE);
			getglobal("RBAddRecipe_Button"):SetScript("OnUpdate", RB_Add_Non_Enchant_OnUpdate);
		else
      DEFAULT_CHAT_FRAME:AddMessage(RB_SAFETOCLOSETRADE);
    end 
  elseif(msg == 2 and RB_Gathering_ATM == false) then
    if(CraftFrame:IsVisible() and GetCraftName() == RB_ENCHANTING) then
     	RB_HijackCraftFunctions();
     	getglobal("RBAddRecipe_Button2Text"):SetText(RB_GATHERING);
     	RB_skillName = GetCraftName();
      local _, skillCurrentSkill, skillMaxSkill = GetCraftDisplaySkillLine();
      RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName] = {};
			RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName].currentskill = skillCurrentSkill;
      RecipeBox_ByPlayer[RB_AddingToRealm][RB_AddingToPlayer][RB_skillName].maxskill = skillMaxSkill;
      RB_Adding_Recipes_Index = 1;
      RB_Gathering_Enchant = true;
      RB_Gathering_ATM = true;
    	DEFAULT_CHAT_FRAME:AddMessage(RB_DONOTCLOSECRAFT);
    	getglobal("RBAddRecipe_Button2"):SetScript("OnUpdate", RB_Add_Enchant_OnUpdate);
    else
      DEFAULT_CHAT_FRAME:AddMessage(RB_SAFETOCLOSECRAFT);
    end 
  end
  
end

function RB_EmptyFunction()
end

function RB_HijackTradeSkillFunctions()
	getglobal("TradeSkillFrame"):SetScript("OnHide", RB_EmptyFunction);
  getglobal("TradeSkillCancelButton"):SetScript("OnClick", RB_EmptyFunction);
  getglobal("TradeSkillFrameCloseButton"):SetScript("OnClick", RB_EmptyFunction);	
end

function RB_HijackCraftFunctions()
	--DEFAULT_CHAT_FRAME:AddMessage("Hijacking Craft Functions");
	getglobal("CraftFrame"):SetScript("OnHide", RB_EmptyFunction);
	getglobal("CraftCancelButton"):SetScript("OnClick", RB_EmptyFunction);
  getglobal("CraftFrameCloseButton"):SetScript("OnClick", RB_EmptyFunction);	
end

function RB_ResetTradeSkillFunctions()
	getglobal("TradeSkillFrame"):SetScript("OnHide", lTradeSkillFrame_OnHide_Orig);
 	getglobal("TradeSkillCancelButton"):SetScript("OnClick", lTradeSkillCancelButton_OnClick_Orig);
 	getglobal("TradeSkillFrameCloseButton"):SetScript("OnClick", lTradeSkillFrameCloseButton_OnClick_Orig);
end

function RB_ResetCraftFunctions()
	--DEFAULT_CHAT_FRAME:AddMessage("Resetting Craft Functions");
	getglobal("CraftFrame"):SetScript("OnHide", lCraftFrame_OnHide_Orig);
	getglobal("CraftCancelButton"):SetScript("OnClick", lCraftCancelButton_OnClick_Orig);
  getglobal("CraftFrameCloseButton"):SetScript("OnClick", lCraftFrameCloseButton_OnClick_Orig);
end

function RB_CheckTexture(item, texture)
	if(not RecipeBox_LocalTextures) then
   	RecipeBox_LocalTextures = {};
  end
  if((not TextureList[item]) and not(RecipeBox_LocalTextures[item])) then
    RecipeBox_LocalTextures[item] = texture;
  end
end

--function RB_GetTexture(Name)
--	local Texture = nil;
--	Name = tostring(Name);
--	if(RecipeBox_LocalTextures) then
--		DEFAULT_CHAT_FRAME:AddMessage("Found RecipeBox_LocalTextures");
--		if(RecipeBox_LocalTextures[Name]) then
--			DEFAULT_CHAT_FRAME:AddMessage("Found Texture in local");
--			Texture = RecipeBox_LocalTextures[Name];
--		end
--	elseif(TextureList) then
--		DEFAULT_CHAT_FRAME:AddMessage("Found TextureList");
--	elseif(TextureList[Name]) then
--		DEFAULT_CHAT_FRAME:AddMessage("Found Texture in TextureList");
--		Texture = TextureList[Name];
--	end
--	if(Texture) then
--		DEFAULT_CHAT_FRAME:AddMessage("Returning texture for "..Name.." "..Texture);
--		return Texture;
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Texture for "..Name.." not found");
--	end
--end

function RB_AddRecipeToLocal(RB_skillName, recipeText, recipeTable)
  RecipeBox_LocalRecipes[RB_skillName][recipeText] = {};
  RecipeBox_LocalRecipes[RB_skillName][recipeText] = recipeTable;
  RB_RecipesAdded = RB_RecipesAdded + 1;
end

--RB_CheckRecipe(RB_skillName, recipe) returns true or false
--RB_skillName == text name of skill, "Enchanting", "Tailoring" etc
--recipe == text name of recipe, "Heavy Armor Patch" etc
function RB_CheckRecipe(RB_skillName, recipe)
  if(RecipeBox_LocalRecipes[RB_skillName][recipe] or RecipeList[RB_skillName][recipe]) then
    return true;
  else
    return false;
  end
end

--RB_GetRecipeInfo(recipe) returns table containing recipe's link, number it makes, and number and name of each required reagent
function RB_GetRecipeInfo(recipe)
  local getRecipe;
  if(RecipeList[RB_TradeSkillIndex][recipe]) then
    getRecipe = RecipeList[RB_TradeSkillIndex][recipe];
  elseif(RecipeBox_LocalRecipes[RB_TradeSkillIndex][recipe]) then
    getRecipe = RecipeBox_LocalRecipes[RB_TradeSkillIndex][recipe];
  end
  if(getRecipe) then
   	return getRecipe;
  else
   	return nil;
  end
end

function RB_CheckReagent(reagentName, reagentLink)
  if((not RecipeBox_LocalReagents[reagentName]) and (not ReagentList[reagentName])) then
    RecipeBox_LocalReagents[reagentName] = reagentLink;
  	RB_ReagentsAdded = RB_ReagentsAdded + 1;
  end
end

function RB_GetReagentInfo(reagentName)
  local getReagentLink;
  reagentName = tostring(reagentName);
  if(ReagentList[reagentName]) then
    getReagentLink = ReagentList[reagentName];
  elseif(RecipeBox_LocalReagents[reagentName]) then
    getReagentLink = RecipeBox_LocalReagents[reagentName];
  end
  
  if(getReagentLink) then
    return getReagentLink;
  else
    return nil;
  end
end

function RB_GetTexture(itemName)
	local getTexture;
	if(TextureList[itemName]) then
    getTexture = TextureList[itemName];
  elseif(RecipeBox_LocalTextures[itemName]) then
    getTexture = RecipeBox_LocalTextures[itemName];
  end
  if(getTexture) then
    return getTexture;
  else
    return nil;
  end
end

function WL_RB_SetNewLists()
	if(not RecipeBox_Temp) then
		RecipeBox_Temp={};
	end
	--if(not RecipeBox_Temp["tempreagent"]) then
		RecipeBox_Temp["tempreagent"] = {};
	--end
	for i, ii in ReagentList do
		--DEFAULT_CHAT_FRAME:AddMessage(reagent);
--		for index, item in WL_GBS["bank"] do
--				if(not WL_GBS_TempTable[item]) then
--					table.insert(WL_GBS_TempTable, index);
--				end
--		end
		
		if(not RecipeBox_Temp["tempreagent"][ii]) then
			local _, item = WL_RB_TakeApartLink(ReagentList[reagent])
			table.insert(RecipeBox_Temp["tempreagent"], i);
		end
	end
	
end


function WL_RB_TakeApartLink(link, option)
--Originally Taken from Telo's LootLink
--returns name, item, color
--options "NoEnchants"
  local color, item, name, linkcolor, linkitem, linkname;
  if(link) then
    if(string.find(link, "item")) then
    	for color, item, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
    	  if( color and item and name ) then
    	    linkname = name;
    	    linkcolor = color;
    	    if(option == "NoEnchant") then
    	    	linkitem = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:%4");
    	    else
    	    	linkitem = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:%2:%3:%4");
    	    end
    	  end
    	end
 		elseif(string.find(link, "enchant")) then
 			for color, item, name in string.gfind(link, "|c(%x+)|Henchant:(%d+)|h%[(.-)%]|h|r") do
			  if( color and item and name ) then
			    linkname = name;
			    linkitem = string.gsub(item, "^(%d+)$", "%1");
			    linkcolor = color;
			  end
    	end
 		end
  end
  if(linkcolor and linkitem and linkname) then
    return linkname, linkitem, linkcolor;
  end
end
