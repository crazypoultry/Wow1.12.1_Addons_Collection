SELLENCHANT_VERSION = "1.12.3";


-- for MyAddOns ---------------------------
SellEnchantDetails = {
	name = "SellEnchant",
	description = "Lists all your enchants and reagents with prices, more description and transfer chat info",
	version = SELLENCHANT_VERSION,
	releaseDate = "October 21, 2006",
	author = "Kwinic",
	email = "madica@yahoo.com",
	website = "http://ui.worldofwar.net/ui.php?id=1478",
	category = MYADDONS_CATEGORY_PROFESSIONS,
	frame = "SellEnchant_Frame",
	optionsframe = "SellEnchant_Option_OpenFrame"
};
--------------------------------------------

SellEnchantHelp = {};
SellEnchantHelp[1] = "Color Code :\nClear green-> You have all ingredients and rod in your bags.\nBlue-> Some ingredients necessary is in bank.\nRed-> Missing necessary reagents.\nBrown-> Some ingredients necessary is on ReRoll.\nGray-> This enchantor do not know this enchantement.";

--	Variable for debugging... true = display debug info / false = hide debug info +++++++++++++++++++++++++
local SellEnchant_Debug = false;
local SellEnchant_Debug_Flow_Toggle = false;
local SellEnchant_Debug_AuctionHouse_Toggle = false;
local SellEnchant_Debug_AuctionHouse_Flow_Toggle = false;

--	Table safeguarded
SellEnchant_ListEnchant = nil;
SellEnchant_ListComponent = nil;
SellEnchant_Config_Player = {};
SellEnchant_Config = {};
--------------------------

SellEnchant_Config_Player_Default = {
	SellEnchant_MiniMap_ButtonDisable = false;
};

SellEnchant_ConfigDefault = {
	PourcentageBenefice = 1.20;
	EnchantorPlayerSelected = nil;
	EnchantorTable = {};
	CheckSortByDoCraft = true;
	EnchanteSortOn = {"OnThis","Bonus","BonusNb","Price","Name"};
--	EnchanteSortOn = {"OnThis","BonusLongName","BonusNb","Price","Name"};
	EnchanteSortTypeAZ = true;
	EnchanteSortArmor = nil;
	EnchanteSortBonus = nil;
	EnchanteChatPrice = false;
	MovableFrame = false;
	SellEnchantUseAuctioneer = false;
	SellEnchant_MiniMapButtonPosition = 353;
	SellEnchant_Backward_Compatibilty_PlaceHolder = true;
};

--	Variable of svg of Original ToolTips (for treatment of ToolTips)
local lOriginalGameTooltip_OnHide;
local lOriginalGameTooltip_ClearMoney;
--	Another variable for ToolTip treatment
local lESellCheckTooltip;
local lESellCheckTimer = 0;
local lESellTooltip = nil;
--------------------------

--	Local Variables (cannot be called by external programs)
local ESell_EnchanteSort_Modifier;
local ESell_EnchanteSort_Sort;
local ESell_EnchanteSort_SortUnderFunction;
local ESell_EnchanteSort_SortByDoCraft;
local ESell_Enchante_UpdateData;
local ESell_Reagent_UpdateData;
local ESell_AllVariableLoaded=false;
local ESell_IsEnterWord;
local ESell_playerIsEnchanter = false;

-- Global Variables
SellEnchant_CourantPlayer = {};

local SellEnchant_BankIsOpen = false;

--	Color for feasibilities enchants and ingredients availability
TEXTECOLOR = {
	[-2] = {0.40, 0.40, 0.40};	-- Enchant not known (Gray)
	[-1] = {0.80, 0.80, 0.80};	-- Neutral (White)
	[1] = {0.30, 1, 0.30};		-- Available (Green)
	[2] = {0.00, 0.90, 1.00};	-- Available reagents in bank (Blue)
	[3] = {0.70, 0.50, 0.30};	-- Available reagents on alternate (Brown)
	[4] = {1, 0.30, 0.30};		-- Reagents needed (Red)
};

--	Color of the money in the lists and ToolTip
MONEYCOLOR = {
	Gold = {0.80, 0.70, 0.25};
	Silver = {0.90, 0.90, 1};
	Copper = {0.70, 0.45, 0.20};
};


---------------------------------------------------------------------------
-- Functions start here. This comment is just to highlight where that is --
---------------------------------------------------------------------------


function SE_Out(text)
--	DEFAULT_CHAT_FRAME:AddMessage("S: "..tostring(text));
	DEFAULT_CHAT_FRAME:AddMessage(text);
	UIErrorsFrame:AddMessage(text, 1.0, 1.0, 0, 1, 10) ;
end


function SellEnchant_DebugMessage(msg)
	if SellEnchant_Debug then
		DEFAULT_CHAT_FRAME:AddMessage('SE: ' .. msg,0,1,1);
	end
end


function SellEnchant_Flow_DebugMessage(msg)
	if SellEnchant_Debug_Flow_Toggle then
		DEFAULT_CHAT_FRAME:AddMessage('F-- ' .. msg,0,1,0);
	end
end


function SellEnchant_AuctionHouse_DebugMessage(msg)
	if SellEnchant_Debug_AuctionHouse_Toggle then
		DEFAULT_CHAT_FRAME:AddMessage('AH: ' .. msg,1,1,0);
	end
end


function SellEnchant_Debug_AuctionHouse_Flow(msg)
	if SellEnchant_Debug_AuctionHouse_Flow_Toggle then
		DEFAULT_CHAT_FRAME:AddMessage('A-- ' .. msg,0,1,0);
	end
end


function SellEnchant_ErrorMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg, 1,0,0);
	SellEnchant_Msg:AddMessage(msg, 1.0, 0.1, 0.1, 1.0, 7);
end


function DebugMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage('SE: ' .. msg,0,0,0);
end


function ESell_OnLoad()
	SellEnchant_Flow_DebugMessage("ESell_OnLoad - ENTER");
	---------------------------------------------------------------------
	--	Replace two ToolTip functions for additional lines if Reagents --
	---------------------------------------------------------------------
	lOriginalGameTooltip_ClearMoney = GameTooltip_ClearMoney;
	GameTooltip_ClearMoney = ESell_ToolTip_GameTooltip_ClearMoney;

	lOriginalGameTooltip_OnHide = GameTooltip_OnHide;
	GameTooltip_OnHide = ESell_ToolTip_GameTooltip_OnHide;
	--------------------------------------------------
	-- Register events that SellEnchant responds to --
	--------------------------------------------------
	SellEnchant_Register_Events();
	-------------------------------------------------------
	-- Handles the input from the Command Line Interface --
	-------------------------------------------------------
	SellEnchant_DebugMessage("SellEnchant CLI initialize");
	SlashCmdList["SellEnchant"] = ESell_Command;
	SLASH_SellEnchant1 = "/sellenchant";
	SLASH_SellEnchant2 = "/se";
	SellEnchant_Flow_DebugMessage("ESell_OnLoad - EXIT");	
end
	
	
	
function SellEnchant_Register_Events()
	SellEnchant_Flow_DebugMessage("SellEnchant_Register_Events - ENTER");
	------------------
	--	Event Draft --
	------------------
	this:RegisterEvent("UNIT_NAME_UPDATE");
--	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("TRADE_CLOSED");
	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	this:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
	this:RegisterEvent("LOOT_CLOSED");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	SellEnchant_Flow_DebugMessage("SellEnchant_Register_Events - EXIT");
end




function SellEnchant_Unregister_Events()
	SellEnchant_Flow_DebugMessage("SellEnchant_Unregister_Events - ENTER");
	this:UnregisterEvent("UNIT_NAME_UPDATE");
--	this:UnregisterEvent("BAG_UPDATE");
	this:UnregisterEvent("TRADE_CLOSED");
	this:UnregisterEvent("PLAYERBANKSLOTS_CHANGED");
	this:UnregisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
	this:UnregisterEvent("LOOT_CLOSED");
	this:UnregisterEvent("CRAFT_SHOW");
	this:UnregisterEvent("CRAFT_UPDATE");
	this:UnregisterEvent("BANKFRAME_OPENED");
	this:UnregisterEvent("BANKFRAME_CLOSED");
	this:UnregisterEvent("VARIABLES_LOADED");
	this:UnregisterEvent("SKILL_LINES_CHANGED");
	this:UnregisterEvent("ADDON_LOADED");--added for myaddons
	SellEnchant_Flow_DebugMessage("SellEnchant_Unregister_Events - EXIT");
end



function ESell_OnEvent(event, arg1, arg2)
	SellEnchant_Flow_DebugMessage("ESell_OnEvent - ENTER");
	if(event == "VARIABLES_LOADED") then
		SellEnchant_DebugMessage("--Event-- VARIABLES_LOADED");
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(SellEnchantDetails, SellEnchantHelp);
		end
		ESell_AllVariableLoaded = true;
	end
	if (event == "BAG_UPDATE") then
		SellEnchant_DebugMessage("--Event-- BAG_UPDATE");
		if ESell_AllVariableLoaded and ESell_IsEnterWord then
			ESell_Reagent_UpdateNbInBag();
			SellEnchant_Update_Enchant_Button();
		end
	end
	if (event == "TRADE_CLOSED") then
		SellEnchant_DebugMessage("--Event-- TRADE_CLOSED");
		if ESell_AllVariableLoaded and ESell_IsEnterWord then
			ESell_Reagent_UpdateNbInBag();
			SellEnchant_Update_Enchant_Button();
		end
	end
	if (event == "PLAYERBANKSLOTS_CHANGED") then
		SellEnchant_DebugMessage("--Event-- PLAYERBANKSLOTS_CHANGED");
		if ESell_AllVariableLoaded and ESell_IsEnterWord then
			ESell_Reagent_UpdateNbInBag();
			SellEnchant_Update_Enchant_Button();
		end
	end
	if (event == "PLAYERBANKBAG_UPDATE") then
		SellEnchant_DebugMessage("--Event-- PLAYERBANKBAGSLOTS_CHANGED");
		if ESell_AllVariableLoaded and ESell_IsEnterWord then
			ESell_Reagent_UpdateNbInBag();
			SellEnchant_Update_Enchant_Button();
		end
	end
	if (event == "LOOT_CLOSED") then
		SellEnchant_DebugMessage("--Event-- LOOT_CLOSED");
		if ESell_AllVariableLoaded and ESell_IsEnterWord then
			ESell_Reagent_UpdateNbInBag();
			SellEnchant_Update_Enchant_Button();
		end
	end
	if (event == "CRAFT_SHOW") then
		SellEnchant_DebugMessage("--Event-- CRAFT_SHOW - "..GetCraftName());
		if (SELLENCHANT_NAME_OF_ENCHANT_CRAFT ~= GetCraftName()) then
			HideUIPanel(SellEnchant_Frame);
		end
	end
	if (event == "BANKFRAME_OPENED") then
		SellEnchant_DebugMessage("--Event-- BANKFRAME_OPENED");
		this:RegisterEvent("BAG_UPDATE");
		SellEnchant_BankIsOpen = true;
		ESell_Reagent_UpdateNbInBank();
	end
	if (event == "BANKFRAME_CLOSED") then
		SellEnchant_DebugMessage("--Event-- BANKFRAME_CLOSED");
		this:UnregisterEvent("BAG_UPDATE");
		SellEnchant_BankIsOpen = false;
	end
	if (event == "UNIT_NAME_UPDATE") and arg1 == "player" then
		SellEnchant_DebugMessage("--Event-- UNIT_NAME_UPDATE");
		SellEnchant_CourantPlayer = {UnitName("player"), GetCVar("realmName")};
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		SellEnchant_DebugMessage("--Event-- PLAYER_ENTERING_WORLD");
		SellEnchant_Register_Events();
		if (not SellEnchant_Config_Player) then
			SellEnchant_DebugMessage("Default Player Config values loaded");
			SellEnchant_Config_Player = SellEnchant_Config_Player_Default;
		end
		SellEnchant_CourantPlayer = {UnitName("player"), GetCVar("realmName")};
		ESell_MiniMapIcon_Update();
		ESell_IsEnterWord = true;
	end
	if (event == "PLAYER_LEAVING_WORLD") then
		SellEnchant_DebugMessage("--Event-- PLAYER_LEAVING_WORLD");
		SellEnchant_Unregister_Events();
	end
	SellEnchant_Flow_DebugMessage("ESell_OnEvent - EXIT");
end


-- function ESell_OnUpdate()
-- end


function ESell_Command(arg1)
	SellEnchant_Flow_DebugMessage("ESell_Command - ENTER");
	if ((arg1 == "help")  or (arg1 == "?"))then
		DEFAULT_CHAT_FRAME:AddMessage("SellEnchant CLI functions");
		DEFAULT_CHAT_FRAME:AddMessage("---------------------------------------");
		DEFAULT_CHAT_FRAME:AddMessage("\"help\" or \"?\"- This message");
		DEFAULT_CHAT_FRAME:AddMessage("\"button\" - Toggles MiniMap button");
		DEFAULT_CHAT_FRAME:AddMessage("\"auctionoff\" - Turns off auction scan prices");
		DEFAULT_CHAT_FRAME:AddMessage("\"CreateDefaultDB\" - Creates an updated database text file");
		DEFAULT_CHAT_FRAME:AddMessage("\"debug\" - Toggles the debug information");
		DEFAULT_CHAT_FRAME:AddMessage("<blank> - Show/Hide enchant sell");
	else 
		if arg1 == "CreateDefaultDB" then
			for j, enchanteTable in ipairs(SellEnchant_ListEnchant) do
				enchanteTable["IdOriginal"] = nil;
				enchanteTable["IsKnow"] = nil;
				enchanteTable["Price"] = nil;
				enchanteTable["PriceNoBenef"] = nil;
				enchanteTable["TypePrice"] = nil;
				enchanteTable["Reagents"]["Etat"] = -2;
				newEnchante = false;
			end
			for i, reagent in ipairs(SellEnchant_ListComponent) do
				reagent["Description"] = nil;
				reagent["ByPlayer"] = nil;
				reagent["IsUse"] = nil;
			end
			ESellSvgEnchante ={};
			ESellSvgEnchante.Componantes = SellEnchant_ListComponent;
			ESellSvgEnchante.Enchantes = SellEnchant_ListEnchant;
		
			DEFAULT_CHAT_FRAME:AddMessage("Database created. Camp (/camp) and exit the program now. Send a copy of the sellenchant.lua file in your saved variables file to given e-mail address. See the readme.txt file");
			return;
		else
			if (arg1 == "button") then
				SellEnchant_MiniMap_ButtonToggle();
			else
				if (arg1 == "debug") then
					SellEnchant_DebugToggle_General();
				else
					if arg1 =="auctionoff" then
						SellEnchant_Config.SellEnchantUseAuctioneer = false;
						ESell_Reagent_getPrice();
					else
						if arg1 == "" then
							ESell_Launch();
						else
							DEFAULT_CHAT_FRAME:AddMessage("Type \"/sellenchant help\" for a list of valid commands");
						end
					end
				end
			end
		end
	end
	SellEnchant_Flow_DebugMessage("ESell_Command - EXIT");
end



function ESell_Launch()
	SellEnchant_Flow_DebugMessage("ESell_Launch - ENTER");
	if SortEnchant_GetNum then
		SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_ERROR_INCOMPATIBLESORTENCHANT.." !!!", 1.0, 0.1, 0.1, 1.0, 7);
		return;
	end
	SellEnchant_DebugMessage("++++++++++++++++++++");
	SellEnchant_DebugMessage("SellEnchant Launched");
	if ESellSvgEnchante then ESellSvgEnchante = nil end
	ESell_InizalizeData();
	Toggle_SellEnchant();
	SellEnchant_Flow_DebugMessage("ESell_Launch - EXIT");
end




function ESell_InizalizeData()
	SellEnchant_Flow_DebugMessage("ESell_InizalizeData - ENTER");
	------------------------------------------------
	-- Best place to load and check all variables --
	------------------------------------------------
	if (not SellEnchant_Config) or (not SellEnchant_Config.NumVer) or (SellEnchant_Config.NumVer < ESell_getNumVerToLongNum()) then
		SellEnchant_DebugMessage("Default Config values loaded");
		local SellEnchant_MiniMapButtonPosition;
		if SellEnchant_Config and SellEnchant_Config.SellEnchant_MiniMapButtonPosition then SellEnchant_MiniMapButtonPosition = SellEnchant_Config.SellEnchant_MiniMapButtonPosition end
		SellEnchant_Config = SellEnchant_ConfigDefault;
		if SellEnchant_MiniMapButtonPosition then SellEnchant_Config.SellEnchant_MiniMapButtonPosition = SellEnchant_MiniMapButtonPosition end
		SellEnchant_Config.NumVer = ESell_getNumVerToLongNum();
		SellEnchant_Flow_DebugMessage("ESell_InizalizeData - EXIT");
	end


	local isEnchanteur = ESell_LaunchFunctionInCraftSpellFrame(
		function () 
			if ((not SellEnchant_Config.EnchantorPlayerSelected) or ESell_Player_IsEq(SellEnchant_Config.EnchantorPlayerSelected, SellEnchant_CourantPlayer)) then
				if not SellEnchant_Config.EnchantorPlayerSelected then
					ESell_Reagent_DeleteAllplayerCount();
					SellEnchant_Config.EnchantorPlayerSelected = SellEnchant_CourantPlayer;
				end
				ESell_Enchante_UpdateData();
				ESell_Reagent_UpdateData();
				ESell_Enchante_UpdateAllPrice();
			end
		end
	);
	if isEnchanteur then
		ESell_Player_EnchantorTableAddIfNew(SellEnchant_CourantPlayer);
	end
	
	SellEnchant_CourantPlayer = {UnitName("player"), GetCVar("realmName")};
	ESell_Reagent_UpdateNbInBag();

	SellEnchant_DebugMessage("Exit function ESell_InizalizeData in SellEnchant.lua");
end




function ESell_Player_EnchantorTableAddIfNew(argEnchantorPlayer)
	if not SellEnchant_Config.EnchantorTable then
		SellEnchant_Config.EnchantorTable = {};
	end
	for i, enchantorPlayer in SellEnchant_Config.EnchantorTable do
		if ESell_Player_IsEq(enchantorPlayer, argEnchantorPlayer) then
			return; 
		end
	end
	SellEnchant_DebugMessage("Add enchantor in the table config");	

	tinsert(SellEnchant_Config.EnchantorTable, argEnchantorPlayer);
	SellEnchant_Option_DropDown_PlayerSelect_Initialize();
end



function ESell_Player_IsEq(playerAgr1, playerAgr2)
	if (not playerAgr1) or (not playerAgr2) then return false end
	if (playerAgr1[1] == playerAgr2[1]) and (playerAgr1[2] == playerAgr2[2]) then
		return true
	end
	return false;
end



function ESell_EnchanteSort(nameColums)
	if not SellEnchant_ListEnchant then return end
if nameColums then
SellEnchant_DebugMessage(nameColums);	
else
SellEnchant_DebugMessage("--nameColums is nil--");
end
	if nameColums then
		ESell_EnchanteSort_Modifier(nameColums);
	end

-- SellEnchant_ListEnchant is a table	
--if SellEnchant_ListEnchant then
--SellEnchant_DebugMessage(SellEnchant_ListEnchant);	
--else
--SellEnchant_DebugMessage("--SellEnchant_ListEnchant is nil--");
--end

-- ESell_EnchanteSort_Sort is a function	
-- if ESell_EnchanteSort_Sort then
-- SellEnchant_DebugMessage(ESell_EnchanteSort_Sort);	
-- else
-- SellEnchant_DebugMessage("--ESell_EnchanteSort_Sort is nil--");
-- end
--	table.sort(SellEnchant_ListEnchant);
	table.sort(SellEnchant_ListEnchant, ESell_EnchanteSort_Sort);
end



function ESell_EnchanteSort_Modifier(nameColums)
	SellEnchant_Flow_DebugMessage("ESell_EnchanteSort_Modifier - ENTER");
	if nameColums == SellEnchant_Config.EnchanteSortOn[1] then
		SellEnchant_Config.EnchanteSortTypeAZ = not SellEnchant_Config.EnchanteSortTypeAZ;
		return;
	end
	for index, value in SellEnchant_Config.EnchanteSortOn do
		if nameColums == value then
			table.remove(SellEnchant_Config.EnchanteSortOn, index);
			if nameColums == "Bonus" then
				table.remove(SellEnchant_Config.EnchanteSortOn, (index));
				table.insert(SellEnchant_Config.EnchanteSortOn, 1, "BonusNb");
			end
			table.insert(SellEnchant_Config.EnchanteSortOn, 1, nameColums);
			break;
		end
	end
	SellEnchant_Flow_DebugMessage("ESell_EnchanteSort_Modifier - EXIT");
end

----------------
-- Order      --
-- 1. OnThis  --
-- 2. Bonus   --
-- 3. BonusNB --
-- 4. Price   --
-- 5. Name    --
----------------
function ESell_EnchanteSort_Sort(e1,e2)
	local sortTemp = SellEnchant_Config.EnchanteSortOn;
	-- test to see if a sort armor value is set or if "OnThis" is the same
	if not SellEnchant_Config.EnchanteSortArmor or (e1["OnThis"] == e2["OnThis"]) then
		if not SellEnchant_Config.EnchanteSortBonus or (e1["BonusLongName"] == e2["BonusLongName"]) then
			-- test to see if first one is known
			if e1["IsKnow"] == e2["IsKnow"] then
				-- check and see if feesible first is checked or if have regeants for both
				if ((not SellEnchant_Config.CheckSortByDoCraft) or (e1["Reagents"].Etat == e2["Reagents"].Etat)) then
					-- Check to see if BONUS type is the same
					if (e1[sortTemp[1]] == e2[sortTemp[1]]) then
						if e1[sortTemp[2]] == e2[sortTemp[2]] then
							if e1[sortTemp[3]] == e2[sortTemp[3]] then
								if e1[sortTemp[4]] == e2[sortTemp[4]] then
									return ESell_EnchanteSort_SortUnderFunction(e1,e2,5);
								else
									return ESell_EnchanteSort_SortUnderFunction(e1,e2,4);
								end
							else
								return ESell_EnchanteSort_SortUnderFunction(e1,e2,3);
							end
						else
							return ESell_EnchanteSort_SortUnderFunction(e1,e2,2);
						end
					else
						return ESell_EnchanteSort_SortUnderFunction(e1,e2,1);
					end
				else
					return ESell_EnchanteSort_SortByDoCraft(e1, e2);
				end
			else
				return ESell_EnchanteSort_SortByKnowEnchante(e1, e2);
			end
		else
			if (e1["BonusLongName"] == SellEnchant_Config.EnchanteSortBonus) then
				return true;		
			end 
		end
	else	
		if (e1["OnThis"] == SellEnchant_Config.EnchanteSortArmor) then
			return true;		
		end 
	end
end



function ESell_EnchanteSort_SortUnderFunction(e1,e2,indexSortTemp)
	local sortTemp = SellEnchant_Config.EnchanteSortOn;	
	if (e1[sortTemp[indexSortTemp]] == nil) or (e1[sortTemp[indexSortTemp]] == "") or (e1[sortTemp[indexSortTemp]] == 0) then
		return false;		
	end 
	if (e2[sortTemp[indexSortTemp]] == nil) or (e2[sortTemp[indexSortTemp]] == "") or (e2[sortTemp[indexSortTemp]] == 0) then
		return true;		
	end 
	if SellEnchant_Config.EnchanteSortTypeAZ then
		if (e1[sortTemp[indexSortTemp]] < e2[sortTemp[indexSortTemp]] )then
			return true;		
		else
			return false;
		end
	else
		if (e1[sortTemp[indexSortTemp]] > e2[sortTemp[indexSortTemp]] )then
			return true;		
		else
			return false;
		end
	end
end



function ESell_EnchanteSort_SortByDoCraft(e1, e2)
	SellEnchant_Flow_DebugMessage("ESell_EnchanteSort_SortByDoCraft - ENTER");
	if (e1["Reagents"].Etat == -1) or (not e1["Reagents"].Etat) then return false end
	if (e2["Reagents"].Etat == -1) or (not e2["Reagents"].Etat) then return true end
	if (e1["Reagents"].Etat < e2["Reagents"].Etat )then
		return true;		
	else
		return false;
	end
	SellEnchant_Flow_DebugMessage("ESell_EnchanteSort_SortByDoCraft - EXIT");
end


function ESell_EnchanteSort_SortByKnowEnchante(e1, e2)
	SellEnchant_Flow_DebugMessage("ESell_EnchanteSort_SortByKnowEnchante - ENTER");
	if not e1["IsKnow"] then return false end
	if not e2["IsKnow"] then return true end
	SellEnchant_Flow_DebugMessage("ESell_EnchanteSort_SortByKnowEnchante - EXIT");
end


function ESell_ResetAllData()
	SellEnchant_DebugMessage("reset Data");	
	SellEnchant_ListEnchant = nil;
	SellEnchant_ListComponent = nil;
	SellEnchant_Config = SellEnchant_ConfigDefault;
	SellEnchant_Config_Player = SellEnchant_Config_Player_Default;
	SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_RESETDB, 0.8, 0.2, 0.2, 1.0, 5);
	SelectIdEnchante(nil);
	SelectIdComponant(nil);
	UpDateListeEnchante();
	UpDateListeComponant();
	ESell_MiniMapIcon_Update();
	SellEnchant_Config = SellEnchant_ConfigDefault;
	SellEnchant_Config_Player = SellEnchant_Config_Player_Default;
	ESell_InizalizeData();
end

---------------------------------------------
-- Management of the enchantments database --
---------------------------------------------

function ESell_Enchante_LoadDefaultData()
	if (not SellEnchant_DefaultList.Enchantes) then
		SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_ERROR_DEFAULTDBNOTLOADED, 1, 0.1, 0.1, 1.0, 5);
		return;
	end
	SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_LOADDEFAULT_ENCHANT_DATA, 1, 1, 1, 1.0, 5);
	SellEnchant_ListEnchant = SellEnchant_DefaultList.Enchantes;
	ESell_Enchante_UpdateAllPrice();
	ESell_InizalizeData();
	SellEnchant_Enchante_Frame_OnUpdate();
	SellEnchant_Componant_Frame_OnUpdate();
end


--~  update : All data; in SellEnchant_ListEnchant; with Crafts list of CraftSpellFrame;
--~  run only if player is Enchantor and CraftSpellFrame open

function ESell_Enchante_UpdateData()
	SellEnchant_DebugMessage("Enter function ESell_Enchante_UpdateData");
	if not SellEnchant_ListEnchant then
		SellEnchant_ListEnchant = {};
	end
	ESell_Enchante_UpDateAllKnowByEnchantorAtFalse();
-- List the enchantments and find their characteristics from the information on enchants
	for i=1, GetNumCrafts(), 1 do
		local name, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(i);
		local enchanteReagents = {};
		local nameOnly, bonusTexte, onThis, bonus, bonusNb, bonusLong;
	-- Seek all Reagents of enchants and constitutes a table tmp(enchanteReagents) this list
		for j=1, GetCraftNumReagents(i), 1 do
			local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo(i, j);
			tinsert(enchanteReagents, {Name = reagentName, Count = reagentCount});
		end
	-- Separe the name of the no-claims bonus in the GetCraftInfo(index) catch
		_,_,nameOnly = string.find(name, SellEnchant_ForTakeNameCaracBonusModel);
		_,_,bonusTexte = string.find(name, SellEnchant_ForTakeQualityBonusModel);
		if not nameOnly then nameOnly = name end
	-- Seek on which equipment one can put enchantement
		for j, Armor in ipairs(SellEnchant_ArmorCarac) do
			if string.find(nameOnly, Armor[1]) then
				onThis = Armor[2];
				break;
			end
		end
	-- management of the characteristics manufacture of object (Rod for example)
		if not onThis then 
			for j, nameObj in SellEnchant_Objet do
				if nameObj[1] == nameOnly then
					onThis = nameObj[3];
					bonus = nameObj[2];
					break;
				end
			end
		end
	-- So Always nothing found in the table no-claims bonus or obj then to put other
		if not onThis then onThis = SellEnchant_ArmorCarac.Other end
	-- Seek Type and Bonus value for each enchantements
		-- Test if description no-claims bonus exists
		if (bonusTexte) then
			-- Seek the Type of the no-claims bonus in the SellEnchant_BonusCarac.Type table
			-- In order to indicate the more readable no-claims bonus and more speaking in the list
			for j, bonusCarac in SellEnchant_BonusCarac do
				-- Seek the Type of no-claims bonus
				-- Also test, if particular case or case normal
				if ((string.find(bonusTexte, bonusCarac[1])) and ((not bonusCarac[4]) or (bonusCarac[4] == onThis))) then
					bonus = bonusCarac[2];
					-- If a table of No-claims bonus exists for the Type found research of the no-claims bonus in the SellEnchant_Quality table referencé in SellEnchant_BonusCarac["Type"][j][2 ]
					if (bonusCarac[3]) then
						local bonustextetmp = bonusTexte;
						-- If bonusTexte = bonuscarac without supplement, then the bonusNb = standard no-claims bonus is value 3 in the SellEnchant_Quality tables
						if (string.len(bonusTexte) == string.len(bonusCarac[1])) then
							bonustextetmp = "None";
						end				
						-- If supplement then research in the SellEnchant_Quality table referencé in SellEnchant_BonusCarac[j][3 ] no-claims bonus
						for k, bonusAdd in bonusCarac[3] do
							-- If no-claims bonus then found ' bonusNb' is updated with the value bonusAdd SellEnchant_Quality table
							if string.find(bonustextetmp, bonusAdd[1]) then
								bonusNb = bonusAdd[2];
								break;
							end
						end
					end
					break;
				end
			end
			-- If no table of the type of no-claims bonus corresponds to directly put the description just as it is in ' bonus'
			if not bonus then
				bonus = bonusTexte;
			end
		end
		-- if onThis has not been determined, it may be an Oil
		if not bonus  then 
			for j, nameObj in SellEnchant_Objet do
				if nameObj[1] == nameOnly then
					bonus = nameObj[2];
					break;
				end
			end
		end
		-- find a class for BonusLong
		bonusLong= "Misc";
		for i = 1, SellEnchant_Data_NumberBonusTypes do
			if bonus == (SellEnchant_Data_BonusLongAssign[i][1]) then
				bonusLong = (SellEnchant_Data_BonusLongAssign[i][2]);
			end
		end
		
		local newEnchante = true;
		-- Update the table of the enchantements
		for j, enchanteTable in ipairs(SellEnchant_ListEnchant) do
			if (name == enchanteTable["LongName"]) and (GetCraftDescription(i) == enchanteTable["Description"]) then
--~ 				SellEnchant_DebugMessage("update enchante");
				enchanteTable["IdOriginal"] = i;
				enchanteTable["LongName"] = name;
				enchanteTable["Name"] = nameOnly;
				enchanteTable["Description"] = GetCraftDescription(i);
				enchanteTable["Icon"] = GetCraftIcon(i);
				enchanteTable["OnThis"] = onThis;
				enchanteTable["Bonus"] = bonus;
				enchanteTable["BonusLongName"] = bonusLong;
				enchanteTable["BonusNb"] = bonusNb;
				enchanteTable["Reagents"] = enchanteReagents;
				enchanteTable["Required"] = GetCraftSpellFocus(i);
				enchanteTable["Link"] = GetCraftItemLink(i);
				enchanteTable["IsKnow"] = true;
				newEnchante = false;
				break;
			end
		end
		if newEnchante then
			SellEnchant_DebugMessage("new enchante");
			tinsert( SellEnchant_ListEnchant, {
				["IdOriginal"] = i ,
				["LongName"] = name,
				["Name"] = nameOnly,
				["Description"] = GetCraftDescription(i),
				["Icon"] = GetCraftIcon(i),
				["OnThis"] = onThis,
				["BonusLongName"] = bonusLong;
				["Bonus"] = bonus,
				["BonusNb"] = bonusNb,
				["Reagents"] = enchanteReagents,
				["Required"] = GetCraftSpellFocus(i),
				["Link"] = GetCraftItemLink(i),
				["IsKnow"] = true,
			});
		end
	end
	ESell_EnchanteSort();
	SellEnchant_ListEnchant.VersionBd = ESell_getNumVerToLongNum();
	SellEnchant_DebugMessage("Testing this French message");
 	SellEnchant_DebugMessage("Fin de l'update data enchante; data ver : "..SellEnchant_ListEnchant.VersionBd);
end


function ESell_Enchante_UpDateAllKnowByEnchantorAtFalse()
	SellEnchant_DebugMessage("Tous enchantement sur non connu");	

	if not SellEnchant_ListEnchant then return end
	for i, enchanteTable in ipairs(SellEnchant_ListEnchant) do
		enchanteTable["IsKnow"] = false;
	end
end

function ESell_Enchante_getUserTablePrice()
	local tableReturn = {};
	if SellEnchant_ListEnchant then
		for i, enchanteTable in ipairs(SellEnchant_ListEnchant) do
			if 	enchanteTable["TypePrice"] == 2 then
				tinsert(tableReturn, {
					["Name"] = enchanteTable["Name"];
					["Description"] = enchanteTable["Description"];
					["Price"] = enchanteTable["Price"];
				});
			end
		end
	end
	return tableReturn;
end

--~  return : numEnchante; in SellEnchant_ListEnchant
function ESell_Enchante_getNb()
	if SellEnchant_ListEnchant then
		return getn(SellEnchant_ListEnchant);
	end
	return 0;
end

--   get : idEnchante; and return : Name, onThis, Bonus, BonusNb (BonusValue), Link, BonusLongName; in SellEnchant_ListEnchant
--                                    1     2       3      4                     5         6	
function ESell_Enchante_getInfoBonus(idEnchante)
	if idEnchante and SellEnchant_ListEnchant[idEnchante] then
		return SellEnchant_ListEnchant[idEnchante]["Name"], SellEnchant_ListEnchant[idEnchante]["OnThis"], SellEnchant_ListEnchant[idEnchante]["Bonus"], SellEnchant_ListEnchant[idEnchante]["BonusNb"], SellEnchant_ListEnchant[idEnchante]["Link"],SellEnchant_ListEnchant[idEnchante]["BonusLongName"];
	end
	return nil;
end

--~  get : idEnchante; and return : longName, icon, description, required, itemLink; in SellEnchant_ListEnchant
function ESell_Enchante_getInfoDetail(idEnchante)
	if idEnchante and SellEnchant_ListEnchant[idEnchante] then
		return SellEnchant_ListEnchant[idEnchante]["LongName"], SellEnchant_ListEnchant[idEnchante]["Icon"], SellEnchant_ListEnchant[idEnchante]["Description"], SellEnchant_ListEnchant[idEnchante]["Required"], SellEnchant_ListEnchant[idEnchante]["Link"];
	end
	return nil;
end

--~  get : nameEnchante; and return : idEnchante; in SellEnchant_ListEnchant
function ESell_Enchante_getId(nameEnchante)
	if nameEnchante then
		for idEnchante in SellEnchant_ListEnchant do
			if SellEnchant_ListEnchant[idEnchante]["LongName"] == nameEnchante then
				return idEnchante;
			end
		end
	end
	return nil;
end

--~  get : idEnchante; and return : idOriginalEnchante; in SellEnchant_ListEnchant
--~  idOriginal used in the treatment of enchant in the fenetre CraftSpell
function ESell_Enchante_getIdOriginal(idEnchante)
	if idEnchante and SellEnchant_ListEnchant[idEnchante] then
		return SellEnchant_ListEnchant[idEnchante]["IdOriginal"];
	end
	return nil;
end

--~  get : idEnchante; and return : numOfReagentNeeded; in SellEnchant_ListEnchant
function ESell_Enchante_getNumReagent(idEnchante)
	if (not SellEnchant_ListEnchant) or (not SellEnchant_ListEnchant[idEnchante]) or (not SellEnchant_ListEnchant[idEnchante]["Reagents"]) then
		return nil;
	end
	return getn(SellEnchant_ListEnchant[idEnchante]["Reagents"]);
end

--~  get : idEnchante, idReagent; and return : coutReagentNeeded, nameReagent; in SellEnchant_ListEnchant
function ESell_Enchante_getInfoReagent(idEnchante, idReagent)
	if (not SellEnchant_ListEnchant[idEnchante]) or (not SellEnchant_ListEnchant[idEnchante]["Reagents"][idReagent]) then
		return nil;
	end
	return SellEnchant_ListEnchant[idEnchante]["Reagents"][idReagent].Count, SellEnchant_ListEnchant[idEnchante]["Reagents"][idReagent].Name;
end

--~  update : Price, TypePrice, PriceNoBenef for all enchantes; in SellEnchant_ListEnchant; with priceReagent in SellEnchant_ListComponent
function ESell_Enchante_UpdateAllPrice()
	SellEnchant_DebugMessage("Calcualation of prices for the enchantment.");
	for idEnchante=1, ESell_Enchante_getNb(), 1 do
		ESell_Enchante_UpdatePrice(idEnchante)
	end
	SellEnchant_DebugMessage("Finished calculating the price.");
end

--~  update : Price, TypePrice, PriceNoBenef; in SellEnchant_ListEnchant; with priceReagent in SellEnchant_ListComponent
function ESell_Enchante_UpdatePrice(idEnchante)
	if not idEnchante then return end

	local price = 0;
	local isGoodPrice = 1;
	for numComponant=1, ESell_Enchante_getNumReagent(idEnchante),1 do
		local count, name = ESell_Enchante_getInfoReagent(idEnchante, numComponant);
		local idReagent = ESell_Reagent_getId(name);
		local priceUnite = ESell_Reagent_getPrice(idReagent);
		if not priceUnite or priceUnite == 0 then isGoodPrice = -1;  priceUnite = 0 end
		price = price + (priceUnite*count);
	end

	SellEnchant_ListEnchant[idEnchante]["PriceNoBenef"] = price;
	
	if SellEnchant_ListEnchant[idEnchante]["TypePrice"] ~= 2 then
		price = floor(price * SellEnchant_Config.PourcentageBenefice);

		if not SellEnchant_Config.EnchantePriceTypeCalculate then SellEnchant_Config.EnchantePriceTypeCalculate = 1 end
		local priceType = SellEnchant_Config.EnchantePriceTypeCalculate;
		local pricerounded = 0;
		local goldprice = ESell_Money_getMoney("Gold", price);
		local silverprice = ESell_Money_getMoney("Silver", price);
		local copperprice = ESell_Money_getMoney("Copper", price);
		if priceType == 1 then pricerounded = price end
		if priceType == 2 then
			if silverprice ~= 0 then
				pricerounded = floor(goldprice*10000 + silverprice*100);
				if copperprice ~= 0 then pricerounded = pricerounded+100 end
			else
				pricerounded = price;
			end
		end
		if priceType == 3 then
			if goldprice ~= 0 then
				pricerounded = floor(goldprice*10000);
				if silverprice ~= 0 then pricerounded = pricerounded+10000 end
			else
				if silverprice ~= 0 then
					pricerounded = floor(silverprice*100);
					if copperprice ~= 0 then pricerounded = pricerounded+100 end
				else
					pricerounded = price;
				end
			end
		end
		
		SellEnchant_ListEnchant[idEnchante]["Price"] = pricerounded;
		SellEnchant_ListEnchant[idEnchante]["TypePrice"] = isGoodPrice;
	end
end

--~  get : idEnchante; and return : price, typePrice, priceNoBenef; in SellEnchant_ListEnchant
function ESell_Enchante_getPrice(idEnchante)
	local price = SellEnchant_ListEnchant[idEnchante]["Price"];
	local priceNoBenef = SellEnchant_ListEnchant[idEnchante]["PriceNoBenef"];
	local isGoodPrice = SellEnchant_ListEnchant[idEnchante]["TypePrice"];
	return price, isGoodPrice, priceNoBenef;
end


--------------------------------------------------------------------------------------
-- Management of the inventory position                                             --
--  1: Sufficient quantity in bags                                                  --
--  2: Sufficient quantity in bags and bank (player principal)                      --
--  3: Sufficient quantity in bags, bank (Enchanter) and alternate,                 --
--  4: Not sufficient quantity                                                      --
-- update : InvotoryPositionOfNumAllReagentAndRequired; in SellEnchant_ListEnchant; --
-- with numInBag, numInBank; for all player in SellEnchant_ListComponent            --
--------------------------------------------------------------------------------------
function ESell_Enchante_UpdateEtat()
	SellEnchant_Flow_DebugMessage("ESell_Enchante_UpdateEtat - ENTER");
	for idEnchante=1, ESell_Enchante_getNb(), 1 do
		local etatForThisEnchante = ESell_Enchante_getRequiredEtat(idEnchante);
		if SellEnchant_ListEnchant[idEnchante]["IsKnow"] then
			for idReagent=1, getn(SellEnchant_ListEnchant[idEnchante]["Reagents"]), 1 do
				local etat = ESell_Enchante_getReagentEtat(idEnchante, idReagent);
				if (etat > etatForThisEnchante) then
					etatForThisEnchante = etat;
				end
			end
		else
			etatForThisEnchante = -2;
		end
		SellEnchant_ListEnchant[idEnchante]["Reagents"].Etat = etatForThisEnchante;
	end
		SellEnchant_Flow_DebugMessage("ESell_Enchante_UpdateEtat - EXIT");
end

--~  get : idEnchante; and return : InvotoryPosition; in SellEnchant_ListEnchant;
function ESell_Enchante_getEtat(idEnchante)
	if (not idEnchante) or ((idEnchante > ESell_Enchante_getNb()) or (idEnchante < 0)) then
		return nil;
	end
	return SellEnchant_ListEnchant[idEnchante]["Reagents"].Etat;
end


--~  get : idEnchante, idReagent; and return : InvotoryPositionNumReagent; in SellEnchant_ListEnchant;
--~  	with numInBag, numInBank; for all player in SellEnchant_ListComponent
function ESell_Enchante_getReagentEtat(idEnchante, idReagent)
	if not idEnchante or not idReagent then return end
	local etat = 1;
	local count, name = ESell_Enchante_getInfoReagent(idEnchante, idReagent);
	local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCount(ESell_Reagent_getId(name), SellEnchant_Config.EnchantorPlayerSelected);
	if not nbInBag then return 4 end
	if (nbInBag < count) then
		etat = 2;
		if ((nbInBag + nbInBank) < count) then
			etat = 3;
			if ((nbInBag + nbInBank + nbInReroll) < count) then
				etat = 4;
			end
		end
	end
	return etat;
end

--~  get : idEnchante; and return : InvotoryPositionRequired; in SellEnchant_ListEnchant;
--~  	with numInBag, numInBank; for playerEnchanting in SellEnchant_ListComponent["Required"]
function ESell_Enchante_getRequiredEtat(idEnchante)
	if not SellEnchant_ListComponent then return end
	local etat = 1;
	local nameRequired = SellEnchant_ListEnchant[idEnchante]["Required"];
	if nameRequired then
		for required = 1, getn(SellEnchant_ListComponent["Required"]) do
			if nameRequired == SellEnchant_ListComponent["Required"][required]["Name"] then
				if not SellEnchant_ListComponent["Required"][required]["NbInBag"] or SellEnchant_ListComponent["Required"][required]["NbInBag"] == 0 then
					etat = 2;
					if not SellEnchant_ListComponent["Required"][required]["NbInBank"] or SellEnchant_ListComponent["Required"][required]["NbInBank"] == 0 then
						etat = 4;
					end
				end
			end
		end
	end
	return etat;
end

--~  get : idEnchante; and return : CountMakedWithBag, CountMakedWhitBagAndBank, CountMakedWithBagBankAndReRoll; in SellEnchant_ListEnchant;
function ESell_Enchante_getCountMaked(idEnchante)
	local numReagent = ESell_Enchante_getNumReagent(idEnchante);
	local makeBagCount = nil;
	local makeBankCount = nil;
	local makeReRCount = nil;
	for i=1, numReagent, 1 do
		local mBgC, mBkC, mRC;
		local coutReagentNeeded, nameReagent = ESell_Enchante_getInfoReagent(idEnchante, i);
		local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCount(ESell_Reagent_getId(nameReagent), SellEnchant_Config.EnchantorPlayerSelected);
--	my not working solution
--		local nbInBag, nbInBank, nbInReroll;
--		nbInBag = 0;
--		nbInBank = 0;
--		nbInReroll = 0;
--		nbInReroll = ESell_Reagent_getCount(ESell_Reagent_getId(nameReagent), SellEnchant_Config.EnchantorPlayerSelected);
--	my working solution
		if (nbInBag == nil) or (nbInBag == "") then
			nbInBag = 0;
		end
		if (nbInBank == nil) or (nbInBank == "") then
			nbInBank = 0;
		end
		if (nbInReroll == nil) or (nbInReroll == "") then
			nbInReroll = 0;
		end
		
		if (nbInBag + nbInBank + nbInReroll) >= coutReagentNeeded then
			mRC = floor((nbInBag + nbInBank + nbInReroll)/coutReagentNeeded);
		else
			makeBagCount = 0;
			makeBankCount = 0;
			makeReRCount = 0;
			break;
		end
		if (nbInBag + nbInBank) >= coutReagentNeeded then
			mBkC = floor((nbInBag + nbInBank)/coutReagentNeeded);
		else
			makeBankCount = 0;
		end
		if nbInBag >= coutReagentNeeded then
			mBgC = floor(nbInBag/coutReagentNeeded);
		else
			makeBagCount = 0;
		end
		if (not makeBagCount) or (makeBagCount > 1) then
			if makeBagCount then
				if makeBagCount > mBgC then
					makeBagCount = mBgC;
				end
			else
				makeBagCount = mBgC;
			end
		end
		if (not makeBankCount) or (makeBankCount > 1) then
			if makeBankCount then
				if makeBankCount > mBkC then
					makeBankCount = mBkC;
				end
			else
				makeBankCount = mBkC;
			end
		end
		if (not makeReRCount) or (makeReRCount > 1) then
			if makeReRCount then
				if makeReRCount > mRC then
					makeReRCount = mRC;
				end
			else
				makeReRCount = mRC;
			end
		end
	end
	return makeBagCount, makeBankCount, makeReRCount;
end
------------------------------------------------------------------------------------------------------

---------------------------------------------------
-- Management of Reagents Database ----------------

function ESell_Reagent_LoadDefaultData()
	if (not SellEnchant_DefaultList.Componantes) then
		SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_ERROR_DEFAULTDBNOTLOADED, 1, 0.1, 0.1, 1.0, 5);
		return;
	end
	SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_LOADDEFAULT_REAGENT_DATA, 1, 1, 1, 1.0, 5);
	SellEnchant_ListComponent = SellEnchant_DefaultList.Componantes;
	SellEnchant_ListComponent["Required"] = {};
	for i, reagent in ipairs(SellEnchant_ListComponent) do
		reagent["Description"] = ESell_Reagent_getDescriptionDefault(reagent["Name"]);
	end
	ESell_Reagent_UpdateNbInBag();
	ESell_Enchante_UpdateAllPrice();
	ESell_InizalizeData();
	
	SellEnchant_Enchante_Frame_OnUpdate();
	SellEnchant_Componant_Frame_OnUpdate();
end

function ESell_Reagent_DeleteAllplayerCount()
	SellEnchant_Flow_DebugMessage("Delete quantity per player");	
	if SellEnchant_ListComponent then
		for i, reagentTable in ipairs(SellEnchant_ListComponent) do
			reagentTable["ByPlayer"] = nil;
		end
	else
		SellEnchant_DebugMessage("Skipping deletion");
	end
end



--~  update : All data; in SellEnchant_ListComponent; with Crafts list of CraftSpellFrame;
--~  run only if player is Enchantor and CraftSpellFrame open
function ESell_Reagent_UpdateData()
	local index = 0;
	local numComponante = 0;

	-- Test if data exist if not chage the data by default
	if (ESell_Reagent_getNb() ~= 0) then
		SellEnchant_DebugMessage("Base de composant en memoire");
	else 
		SellEnchant_ListComponent = {};
	end

	numComponante = ESell_Reagent_getNb();
	
	ESell_Reagent_UpDateAllUseByEnchantorAtFalse();


	-- Seek the Components according to the list of the crafts available
	-- Update and additions of the missing Components
	for i=1, GetNumCrafts(), 1 do

		local name, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(i);

		local required = GetCraftSpellFocus(i);
		local testRequiredIsAdd = true;
		if not SellEnchant_ListComponent["Required"] then
			SellEnchant_ListComponent["Required"] = {};
		end
		if required then
			nbRequire = getn(SellEnchant_ListComponent["Required"])
			for idRequire=1, nbRequire,1 do
				if SellEnchant_ListComponent["Required"][idRequire]["Name"] == required then
					testRequiredIsAdd = false;
				end
			end
			if testRequiredIsAdd then
				nbRequire = nbRequire + 1
				SellEnchant_ListComponent["Required"][nbRequire]={};
				SellEnchant_ListComponent["Required"][nbRequire]["Name"] =required;
				SellEnchant_ListComponent["Required"][nbRequire]["NbInBag"] = 0;
				SellEnchant_ListComponent["Required"][nbRequire]["NbInBank"] = 0;
			end
		end
--		SellEnchant_DebugMessage(skillName.." "..skillType.." "..numAvailable.." "..isExpanded);
--		SellEnchant_DebugMessage(name.." . "..craftSubSpellName.." . "..craftType.." . "..numAvailable.." . "..isExpanded);

		enchanteReagents = {Nb=GetCraftNumReagents(i)};
		if enchanteReagents.Nb then
			if enchanteReagents.Nb ~= 0 then
				for j=1, enchanteReagents.Nb, 1 do
					local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(i, j);
					local reagentlink = GetCraftReagentItemLink(i,j);
					local testAjout = true;
					for k=1, numComponante,1 do
						if SellEnchant_ListComponent[k]["Name"] == reagentName then
							if (not SellEnchant_ListComponent[k]["Description"]) then
								SellEnchant_ListComponent[k]["Description"] = ESell_Reagent_getDescriptionDefault(SellEnchant_ListComponent[k]["Name"]);
							end
							SellEnchant_ListComponent[k]["IsUse"] = true;
							testAjout = false;
						end
					end
					if testAjout then
						SellEnchant_DebugMessage("Added an element in the regeant database");
						numComponante = numComponante +1;
						SellEnchant_ListComponent[numComponante] ={};
						SellEnchant_ListComponent[numComponante]["ByPlayer"] ={};
						SellEnchant_ListComponent[numComponante]["Texture"] = reagentTexture;
						SellEnchant_ListComponent[numComponante]["Link"] = reagentlink;
						SellEnchant_ListComponent[numComponante]["PriceUnite"] = 0;
						SellEnchant_ListComponent[numComponante]["Name"] = reagentName;
						SellEnchant_ListComponent[numComponante]["Description"] = ESell_Reagent_getDescriptionDefault(reagentName);
						SellEnchant_ListComponent[numComponante]["IsUse"] = true;							
					end
					
				end
			end
		end
			
	end
	SellEnchant_DebugMessage("Finished populating reagent data");
	SellEnchant_ListComponent.VersionBd = SELLENCHANT_VERSION;
	ESell_Reagent_UpdateNbInBag();
end

function ESell_Reagent_UpDateAllUseByEnchantorAtFalse()
	SellEnchant_DebugMessage("Udate all reagente on not uses");	
	if not SellEnchant_ListComponent then return end
	for i, ReagentTable in ipairs(SellEnchant_ListComponent) do
		ReagentTable["IsUse"] = false;
	end
end


--~  update : countInBag; in SellEnchant_ListComponent;
function ESell_Reagent_UpdateNbInBag()
	SellEnchant_Flow_DebugMessage("ESell_Reagent_UpdateNbInBag - ENTER");
	for Componant=1, ESell_Reagent_getNb(), 1 do
		if ESell_Reagent_InizializeNewPlayer(Componant, SellEnchant_CourantPlayer) then
			SellEnchant_ListComponent[Componant]["ByPlayer"][SellEnchant_CourantPlayer[1]]["NbInBag"] = 0;
		end
	end
	if SellEnchant_Config and ESell_Player_IsEq(SellEnchant_CourantPlayer, SellEnchant_Config.EnchantorPlayerSelected) and
		SellEnchant_ListComponent["Required"] then
		for required=1, getn(SellEnchant_ListComponent["Required"]), 1 do
			SellEnchant_ListComponent["Required"][required]["NbInBag"] = 0;
		end
	end
	for container=0, 4, 1 do
		for slot=1, GetContainerNumSlots(container), 1 do
			local itemName = ESell_NameFromLink(GetContainerItemLink(container,slot)) ;
			for Componant=1, ESell_Reagent_getNb(), 1 do
				if (itemName == SellEnchant_ListComponent[Componant]["Name"]) and (SellEnchant_ListComponent[Componant]["Name"]) then
					local texture, itemCount = GetContainerItemInfo(container,slot);
					if ESell_Reagent_InizializeNewPlayer(Componant, SellEnchant_CourantPlayer) then
						SellEnchant_ListComponent[Componant]["ByPlayer"][SellEnchant_CourantPlayer[1]]["NbInBag"] = itemCount + SellEnchant_ListComponent[Componant]["ByPlayer"][SellEnchant_CourantPlayer[1]]["NbInBag"];
					end
				end
			end
			if SellEnchant_Config and ESell_Player_IsEq(SellEnchant_CourantPlayer, SellEnchant_Config.EnchantorPlayerSelected) and
				SellEnchant_ListComponent["Required"] then
				for required=1, getn(SellEnchant_ListComponent["Required"]), 1 do
					if (itemName == SellEnchant_ListComponent["Required"][required]["Name"]) then
						local texture, itemCount = GetContainerItemInfo(container,slot);
						SellEnchant_ListComponent["Required"][required]["NbInBag"] = itemCount + SellEnchant_ListComponent["Required"][required]["NbInBag"];
					end
				end
			end
		end
	end	
	ESell_Reagent_UpdateNbInBank();
	SellEnchant_Flow_DebugMessage("ESell_Reagent_UpdateNbInBag - EXIT");
end

--~  update : countInBank; in SellEnchant_ListComponent;
function ESell_Reagent_UpdateNbInBank()
	if SellEnchant_BankIsOpen then
		SellEnchant_DebugMessage("Modif base composant bank");
		for Componant=1, ESell_Reagent_getNb(), 1 do
			if ESell_Reagent_InizializeNewPlayer(Componant, SellEnchant_CourantPlayer) then
				SellEnchant_ListComponent[Componant]["ByPlayer"][SellEnchant_CourantPlayer[1]]["NbInBank"]=0;
			end
		end
		if SellEnchant_Config and ESell_Player_IsEq(SellEnchant_CourantPlayer, SellEnchant_Config.EnchantorPlayerSelected) and 
			SellEnchant_ListComponent["Required"] then
			for required=1, getn(SellEnchant_ListComponent["Required"]), 1 do
				SellEnchant_ListComponent["Required"][required]["NbInBank"] = 0;
			end
		end
		for container=-1, (GetNumBankSlots()+4), 1 do
			if (container == 0) then container = 5 end
			for slot=1, GetContainerNumSlots(container), 1 do
				local itemName = ESell_NameFromLink(GetContainerItemLink(container,slot)) ;
				for Componant=1, ESell_Reagent_getNb(), 1 do
					if itemName == SellEnchant_ListComponent[Componant]["Name"] and (SellEnchant_ListComponent[Componant]["Name"]) then
						local texture, itemCount, locked, quality, readable = GetContainerItemInfo(container,slot);
						if ESell_Reagent_InizializeNewPlayer(Componant, SellEnchant_CourantPlayer) then
							SellEnchant_ListComponent[Componant]["ByPlayer"][SellEnchant_CourantPlayer[1]]["NbInBank"]=(itemCount + SellEnchant_ListComponent[Componant]["ByPlayer"][SellEnchant_CourantPlayer[1]]["NbInBank"]);
						end
					end
				end
				if ESell_Player_IsEq(SellEnchant_CourantPlayer, SellEnchant_Config.EnchantorPlayerSelected) and
					SellEnchant_ListComponent["Required"] then
					for required=1, getn(SellEnchant_ListComponent["Required"]), 1 do
						if (itemName == SellEnchant_ListComponent["Required"][required]["Name"]) then
							local texture, itemCount = GetContainerItemInfo(container,slot);
							SellEnchant_ListComponent["Required"][required]["NbInBank"] = itemCount + SellEnchant_ListComponent["Required"][required]["NbInBank"];
						end
					end
				end
			end
		end
	end
	ESell_Enchante_UpdateEtat();
	
	SellEnchant_Componant_Frame_OnUpdate();
	SellEnchant_Enchante_Frame_OnUpdate();
end

-- Inizialization of a new player for the components quantities ------------------------------
-- function ESell_Reagent_InizializeNewPlayer(Reagent, player)
--	SellEnchant_Flow_DebugMessage("ESell_Reagent_InizializeNewPlayer - ENTER");
--	if Reagent or player or SellEnchant_ListComponent or SellEnchant_ListComponent[Reagent] then
--		if not((SellEnchant_Config.EnchantorPlayerSelected) and (player[2] ~= SellEnchant_Config.EnchantorPlayerSelected[2])) then
--			local namePlayer = player[1];
--			if (not SellEnchant_ListComponent[Reagent]["ByPlayer"]) then
--				SellEnchant_ListComponent[Reagent]["ByPlayer"] = {};
--				SellEnchant_DebugMessage("inisialize ByPlayer for on reagant");	
--			end
--			if (not SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer]) then
--				SellEnchant_DebugMessage("inisialize new playerCount "..namePlayer.." for on reagant");	
--				SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer] = {};
--				SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer]["NbInBag"] = 0;
--				SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer]["NbInBank"] = 0;
--			end
--			SellEnchant_Flow_DebugMessage("ESell_Reagent_InizializeNewPlayer - EXIT (true)");
--			return true;
--		else
--			SellEnchant_Flow_DebugMessage("ESell_Reagent_InizializeNewPlayer - EXIT (nil)");
--			return nil;
--		end
--	end
--	SellEnchant_Flow_DebugMessage("ESell_Reagent_InizializeNewPlayer - EXIT");
	
----------------------
-- Old, Ugly, Logic --
----------------------
-- Inizialization of a new player for the components quantities ------------------------------
function ESell_Reagent_InizializeNewPlayer(Reagent, player)
	if not Reagent or not player or not SellEnchant_ListComponent or not SellEnchant_ListComponent[Reagent] then
		return;
	end
	if (SellEnchant_Config.EnchantorPlayerSelected) and (player[2] ~= SellEnchant_Config.EnchantorPlayerSelected[2]) then
		return nil;
	end
	local namePlayer = player[1];
	if (not SellEnchant_ListComponent[Reagent]["ByPlayer"]) then
		SellEnchant_ListComponent[Reagent]["ByPlayer"] = {};
		SellEnchant_DebugMessage("inisialize ByPlayer for on reagant");	
	end
	if (not SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer]) then
		SellEnchant_DebugMessage("inisialize new playerCount "..namePlayer.." for on reagant");	
 		SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer] = {};
		SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer]["NbInBag"] = 0;
		SellEnchant_ListComponent[Reagent]["ByPlayer"][namePlayer]["NbInBank"] = 0;
	end
	return true;
end
-----------------------------------------------------------------------------------------------

--~  return : numreagent; in SellEnchant_ListComponent;
function ESell_Reagent_getNb()
	if SellEnchant_ListComponent then
		return getn(SellEnchant_ListComponent);
	end
	return 0;
end

--~  get : nameReagent; and return : DescritionDefaultReagent; in DescritionDefaultReagents table in localization file;
function ESell_Reagent_getDescriptionDefault(nameReagent)
	description = "";
	for i=1, getn(DescritionDefaultReagents), 1 do
		if (nameReagent == DescritionDefaultReagents[i].Name) then
			description = DescritionDefaultReagents[i].Description;
		end
	end
	return description;
end

-- Prise d'info sur les ingredients -----------------------------------------------------------------
function ESell_Reagent_getId(reagentName)
	for idComponant=1, ESell_Reagent_getNb(), 1 do
		local name = SellEnchant_ListComponent[idComponant].Name;
		if (name == reagentName) then
			return idComponant;
		end
	end
	return nil;
end

function ESell_Reagent_getInfo(reagentId)
	if not reagentId then return end
	if reagentId <= getn(SellEnchant_ListComponent) then
		return SellEnchant_ListComponent[reagentId].Name, SellEnchant_ListComponent[reagentId].Texture, SellEnchant_ListComponent[reagentId].Description, SellEnchant_ListComponent[reagentId].Link;
	end
	return nil;
end

---------------------------------------------------------
-- Code used with permission from Shamino's fantastic  --
-- version: EnchantingSeller. Why reinvent the wheel?  --
---------------------------------------------------------
function ESell_Reagent_getPrice_default(idReagent)
	if not idReagent then return end
	if idReagent <= getn(SellEnchant_ListComponent) then
		return SellEnchant_ListComponent[idReagent].PriceUnite;
	end
	return nil;
end

function isNullOrFalse(value)
	if (value) then 
		return true;
	else 
		return false;
	end
end

function isNullOrValue(value)
	if (value) then 
		return value;
	else 
		return "nil";
	end
end

function getTrueOrFalse(value)
	if (value) then 
		return "true";
	else 
		return "false";
	end
end


----------------------------------------------------------------
-- Determine where to get pricing data, then populate prices. --
----------------------------------------------------------------
function ES_getAuctioneerPrice(idReagent)
	if idReagent <= getn(SellEnchant_ListComponent) then
		if not SellEnchant_ListComponent[idReagent].Link then
		   return SellEnchant_ListComponent[idReagent].PriceUnite;
		else
		   --updated for versions greater than auctioneerpack-3.2.0.0671+
		   local itemID, randomProp, enchant, uniqID, name;
		   if (Auctioneer_BreakLink) then
			SellEnchant_AuctionHouse_DebugMessage("using Auctioneer_BreakLink");
			itemID, randomProp, enchant, uniqID, name = Auctioneer_BreakLink(SellEnchant_ListComponent[idReagent].Link);

		   ---Auctioneer_BreakLink no longer exists..instead call EnhTooltip.BreakLink
		   elseif (EnhTooltip.BreakLink) then 
			SellEnchant_AuctionHouse_DebugMessage("using EnhTooltip.BreakLink");
			itemID, randomProp, enchant, uniqID, name = EnhTooltip.BreakLink(SellEnchant_ListComponent[idReagent].Link);

		   else 
			ErrorMessage("auctioneer BreakLink function not found. Using default prices.");
			return SellEnchant_ListComponent[idReagent].PriceUnite;
		   end

		   local itemKey = itemID..":"..randomProp..":"..enchant;	
		   local medianPrice, medianCount;

		   SellEnchant_AuctionHouse_DebugMessage("itemKey is "..itemKey);

		   --for auctioneer auctioneerpack-3.2.0.0671+
		   if (Auctioneer and Auctioneer.Statistic and Auctioneer.Statistic.GetUsableMedian) then
			SellEnchant_AuctionHouse_DebugMessage("using auctioneerpack-3.2.0.0671+ method getUsableMedian(itemKey)");
			medianPrice, medianCount = Auctioneer.Statistic.GetUsableMedian(itemKey);

		   --for auctioneer beta 3.1 -> auctioneerpack-3.2.0.0620, this actually works in 3.0.11 as well, since 'name' arg seems to be optional anyway
		   elseif (Auctioneer_GetItemHistoricalMedianBuyout(itemKey)) then
			SellEnchant_AuctionHouse_DebugMessage("using auctioneer 3.1 method");
			medianPrice, medianCount = Auctioneer_GetItemHistoricalMedianBuyout(itemKey);

		   --for auctioneer 3.0.11, incase the above does not work.
		   elseif (Auctioneer_GetItemHistoricalMedianBuyout(itemKey, name)) then
			SellEnchant_AuctionHouse_DebugMessage("using auctioneer 3.0 method");
			medianPrice, medianCount = Auctioneer_GetItemHistoricalMedianBuyout(itemKey, name);

		   else 
			ErrorMessage("auctioneer get median function not found. Using default prices.");
			return SellEnchant_ListComponent[idReagent].PriceUnite;
		   end

		   SellEnchant_AuctionHouse_DebugMessage("auctioneer medianPrice is "..isNullOrValue(medianPrice));

		   if (not medianCount or not medianPrice) then
			return SellEnchant_ListComponent[idReagent].PriceUnite;
		   end

		   if (medianCount < 5 or medianPrice == 0) then
			SellEnchant_AuctionHouse_DebugMessage("using EnchantingSeller PriceUnite");
			return SellEnchant_ListComponent[idReagent].PriceUnite;
		   else
			return medianPrice;
		   end
		end
	end
	SellEnchant_Debug_AuctionHouse_Flow("ES_getAuctioneerPrice - EXIT");
end

function ES_getKCItemPrice(idReagent)
	SellEnchant_Debug_AuctionHouse_Flow("ES_getKCItemPrice - ENTER");
	if idReagent <= getn(SellEnchant_ListComponent) then
		if not SellEnchant_ListComponent[idReagent].Link then
			return SellEnchant_ListComponent[idReagent].PriceUnite;
		else
			local code = ESell_CodeFromLink(SellEnchant_ListComponent[idReagent].Link)
			SellEnchant_AuctionHouse_DebugMessage("item code is "..isNullOrValue(code));

			--kc_items auctiondb format
			--seen, avgstack, min,   sBidcount, bid, sBuycount, buy
			--4:    5:        10683: 0:       0:   4:       11208

			local seen, avgstack, min, sBidcount, bid, sBuycount, buy;
			if (KC_Auction:GetItemData(code)) then
				seen, avgstack, min, sBidcount, bid, sBuycount, buy = KC_Auction:GetItemData(code);

			elseif (KC_ItemsAuction:getItemData(code)) then
				seen, avgstack, min, sBidcount, bid, sBuycount, buy = KC_ItemsAuction:getItemData(code);
			end
			
			SellEnchant_AuctionHouse_DebugMessage("kc min is "..isNullOrValue(min));

			if (min and min ~= 0) then
				return min;
			else 
				return SellEnchant_ListComponent[idReagent].PriceUnite;
			end
		end
	end
	SellEnchant_Debug_AuctionHouse_Flow("ES_getKCItemPrice - EXIT");
end

function ES_getAuctionMatrixPrice(idReagent)
	SellEnchant_Debug_AuctionHouse_Flow("ES_getAuctionMatrixPrice - ENTER");
	if idReagent <= getn(SellEnchant_ListComponent) then
		if not SellEnchant_ListComponent[idReagent].Link then
		   return SellEnchant_ListComponent[idReagent].PriceUnite;
		else
		   local name = ESell_NameFromLink(SellEnchant_ListComponent[idReagent].Link);
		   local medianPrice = AM_GetMedian(name);
		   SellEnchant_AuctionHouse_DebugMessage("auction matrix medianPrice is "..isNullOrValue(medianPrice));
		   if (medianPrice) then
			return medianPrice;
		   else 
			return SellEnchant_ListComponent[idReagent].PriceUnite;
		   end
		end
	end
	SellEnchant_Debug_AuctionHouse_Flow("ES_getAuctionMatrixPrice - EXIT");
end

function ES_getWowEconPrice(idReagent)
	SellEnchant_Debug_AuctionHouse_Flow("ES_getWowEconPrice - ENTER");
	if idReagent <= getn(SellEnchant_ListComponent) then
		if not SellEnchant_ListComponent[idReagent].Link then
		   return SellEnchant_ListComponent[idReagent].PriceUnite;
		else
		   --integer:auction_price in copper, integer:auction_volume, bool:server-specific data
		   local auction_price, auction_volume = WOWEcon_GetAuctionPrice_ByLink(SellEnchant_ListComponent[idReagent].Link);
		   SellEnchant_AuctionHouse_DebugMessage("WoWEcon price is "..isNullOrValue(auction_price));
		   if (auction_price) then
			return auction_price;
		   else 
			return SellEnchant_ListComponent[idReagent].PriceUnite;
		   end
		end
	end
	SellEnchant_Debug_AuctionHouse_Flow("ES_getWowEconPrice - EXIT");
end


--START: updated method from auctioneer patch.
function ESell_Reagent_getPrice(idReagent)
	SellEnchant_Debug_AuctionHouse_Flow("ESell_Reagent_getPrice - ENTER");
	if not idReagent then return end

	auctioneerLoaded = IsAddOnLoaded("Auctioneer");
	auctionMatrixLoaded = IsAddOnLoaded("AuctionMatrix");
	kcItemsLoaded = IsAddOnLoaded("KC_Items");
	wowEconLoaded = IsAddOnLoaded("WOWEcon_PriceMod");
	useAuctionAddon = SellEnchant_Config.SellEnchantUseAuctioneer;

	SellEnchant_AuctionHouse_DebugMessage("auctioneerLoaded? ".. getTrueOrFalse(auctioneerLoaded));
	SellEnchant_AuctionHouse_DebugMessage("auctionMatrixLoaded? ".. getTrueOrFalse(auctionMatrixLoaded));
	SellEnchant_AuctionHouse_DebugMessage("kcItemsLoaded? ".. getTrueOrFalse(kcItemsLoaded));
	SellEnchant_AuctionHouse_DebugMessage("wowEconLoaded? ".. getTrueOrFalse(wowEconLoaded));
	SellEnchant_AuctionHouse_DebugMessage("useAuctionAddon? ".. getTrueOrFalse(useAuctionAddon));

	if (not useAuctionAddon) then
		SellEnchant_AuctionHouse_DebugMessage("not using useAuctionAddon");
		return ESell_Reagent_getPrice_default(idReagent);
	else
		if (auctioneerLoaded) then
			SellEnchant_AuctionHouse_DebugMessage("using Auctioneer");
			return ES_getAuctioneerPrice(idReagent);

		elseif (auctionMatrixLoaded) then
			SellEnchant_AuctionHouse_DebugMessage("using Auction Matrix");
			return ES_getAuctionMatrixPrice(idReagent);

			elseif (kcItemsLoaded) then
			SellEnchant_AuctionHouse_DebugMessage("using KC_Items");
			return ES_getKCItemPrice(idReagent);			

		elseif (wowEconLoaded) then
			SellEnchant_AuctionHouse_DebugMessage("using WoWEcon");
			return ES_getWowEconPrice(idReagent);

		--incase auctionaddon flag is true, but no auction addons are enabled/loaded.
		else 
			return ESell_Reagent_getPrice_default(idReagent);
		end

	end
	return nil;
end
--END: updated method from auctioneer patch.

-----------------------------------------------------------------------------------
-- If you feel like using my code, go ahead. It'll make the world a better place --
-----------------------------------------------------------------------------------


function ESell_Reagent_getUsed(idReagent)
	if SellEnchant_ListComponent[idReagent] then
		return SellEnchant_ListComponent[idReagent].IsUse;
	end
	return nil;
end

function ESell_Reagent_getCount(idReagent, player)
	if not idReagent then return end
	if (not player) then player = SellEnchant_CourantPlayer; end
	local tableNbArg = SellEnchant_ListComponent[idReagent]["ByPlayer"];
	local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCountWhithTable(tableNbArg, player[1]);
	return nbInBag, nbInBank, nbInReroll;
end

function ESell_Reagent_getCountWhithTable(tableNbArg, namePlayer)
	if (not namePlayer) then namePlayer = SellEnchant_CourantPlayer[1]; end
	
	local nbInBank = 0;
	local nbInReroll =0;
	local nbInBag =0;	
	if (tableNbArg) then
		table.foreach(tableNbArg,
			function (name, bagTable) 
				if (name == namePlayer) then
					nbInBag = bagTable["NbInBag"];
					nbInBank = bagTable["NbInBank"];
				else
					nbInReroll = (bagTable["NbInBank"] + bagTable["NbInBag"] + nbInReroll);
				end
			end
		);
	end
--	Doesn't work here... bad function call I suppose
--	if (nbInBag == nil) or (nbInBag == "") then
--		nbInBag = 0;
--	end
--	if (nbInBank == nil) or (nbInBank == "") then
--		nbInBank = 0;
--	end
--	if (nbInReroll == nil) or (nbInReroll == "") then
--		nbInReroll = 0;
--	end
	return nbInBag, nbInBank, nbInReroll;
end

function ESell_Reagent_getPlayerListSave(idReagent)
	if not idReagent then return end
	if not SellEnchant_ListComponent[idReagent]["ByPlayer"] then return {} end
	
	local tableNbArg = SellEnchant_ListComponent[idReagent]["ByPlayer"];
	local playerList ={};
	table.foreach(tableNbArg,
		function (name, bagTable)
			table.insert(playerList, name);
		end
	);
	return playerList;
end
------------------------------------------------------------------------------------------------------
-- Modification of the component prices in the data base --------------------------------------------------------
function ESell_Reagent_setPrice(typeMoney, price, idReagent)
	SellEnchant_ListComponent[idReagent]["PriceUnite"] = ESell_Money_PriceModifier(typeMoney, price, ESell_Reagent_getPrice(idReagent));
	ESell_Enchante_UpdateAllPrice();
end
------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Complementary function for the prices ---------------------------------------------------------------------------------------------------------------------------------------------
function ESell_Money_getMoney(typeMoney, price)
	if not price then return nil; end
	if typeMoney == "Gold" then
		return (floor(price/10000));
	end if typeMoney == "Silver" then
		return (floor(price/100) - (floor(price/10000)*100));		
	end if typeMoney == "Copper" then
		return mod(price, 100);				
	end
end

function ESell_Money_PriceModifier(typeMoney, money, oldPrice)
	local multi;
	if typeMoney == "Gold" then
		multi = 10000;
	end if typeMoney == "Silver" then
		multi = 100;
	end if typeMoney == "Copper" then
		multi = 1;
	end
		return (oldPrice - (ESell_Money_getMoney(typeMoney, oldPrice)*multi) + (money*multi));
end


function ESell_Money_getStringFormatWithGSC(value)
	local goldValue = ESell_Money_getMoney("Gold", value);
	local silverValue = ESell_Money_getMoney("Silver", value);
	local copperValue = ESell_Money_getMoney("Copper", value);
	local _, textSilverValue, textCopperValue = ESell_Money_getStringFormat(value);
	local textPriceReturn = "";

	if not goldValue then return "" end
	
	if goldValue > 0 then
		textPriceReturn = (goldValue..SELLENCHANT_LABEL_GOLD);
	end
	if silverValue > 0 then
		if goldValue > 0 and copperValue > 0 then textPriceReturn = (textPriceReturn.." "..textSilverValue..SELLENCHANT_LABEL_SILVER) end
		if goldValue > 0 and copperValue == 0 then textPriceReturn = (textPriceReturn..textSilverValue..SELLENCHANT_LABEL_SILVER) end
		if goldValue == 0 then textPriceReturn = (silverValue..SELLENCHANT_LABEL_SILVER) end
	else
		if goldValue > 0 and copperValue > 0 then textPriceReturn = (textPriceReturn.." "..textSilverValue..SELLENCHANT_LABEL_SILVER) end
	end
	if copperValue > 0 then
		if goldValue > 0 then textPriceReturn = (textPriceReturn.." "..textCopperValue..SELLENCHANT_LABEL_COPPER) end
		if goldValue == 0 and silverValue > 0  then	textPriceReturn = (textPriceReturn..textCopperValue) end
		if goldValue == 0 and silverValue == 0  then	textPriceReturn = (copperValue..SELLENCHANT_LABEL_COPPER) end
	end
	return textPriceReturn;
end

function ESell_Money_getStringFormatWithColor(value)
	local ColorMoney = {Gold = "|cffcfb53b", Silver = "|c99e6e8fa", Copper = "|cffb87333"}
	local Gold, Silver, Copper = ESell_Money_getStringFormat(value);
	
	if value then
		return (ColorMoney.Gold..Gold.." "..ColorMoney.Silver..Silver.." "..ColorMoney.Copper..Copper);
	end
	return "";
end

-- Return fields been worth under format gold:0 silver:00 copper:00 in logical continuation
-- all what is larger money highest and put has white
function ESell_Money_getStringFormat(value)
	--local ColorMoney = {Gold = {"|cffcfb53b", "207, 181,59", (0.81, 0.71, 0.23)}, Silver = {"|c99e6e8fa", "230, 232, 250", (0.90, 0.91, 0.98)}, Copper = {"|cffb87333", "184, 115, 51", (0.72, 0.45, 0.2)}}
	--local prefixTextColorMoney = {Gold = "|cffcfb53b", Silver = "|c99e6e8fa", Copper = "|cffb87333"}
	if not value then return nil; end

	local goldValue = ESell_Money_getMoney("Gold", value);
	local silverValue = ESell_Money_getMoney("Silver", value);
	local copperValue = ESell_Money_getMoney("Copper", value);
	
	local Gold, Silver, Copper;

	if goldValue == 0 then
		Gold = "";
	else
		Gold = (""..goldValue);
	end

	if silverValue == 0 then
		if (goldValue ~= 0) then
			Silver = "00";
		else
			Silver = "";
		end
	else
		if floor(silverValue/10) == 0 then
			Silver = ("0"..silverValue);
		else
			Silver = (""..silverValue);
		end
	end

	if copperValue == 0 then
		Copper="00";
	else
		if floor(copperValue/10) == 0 then
			Copper = ("0"..copperValue);
		else
			Copper = (""..copperValue);
		end
	end
	return Gold, Silver, Copper;
end

-- Function in relation to the frame SellEnchant_Price_Template
-- of posting of price per color gold, silver and copper
function ESell_Money_SetPrice(priveValue, nameButton)
	if not nameButton then nameButton = this:getName() end
	local goldValue, silverValue, copperValue = ESell_Money_getStringFormat(priveValue);
	
	getglobal(nameButton.."Gold"):SetText(goldValue);
	getglobal(nameButton.."Silver"):SetText(silverValue);
	getglobal(nameButton.."Copper"):SetText(copperValue);
end


-- Function for the ChangeEnchantePrice Window ----------------------------
function ESell_ChangeEnchantePrice_LaunchFrame(idEnchantement)
	if not idEnchantement then
		return;
	end

	local price, goodPrice, priceNoBenef = ESell_Enchante_getPrice(idEnchantement);

	local goldValue = ESell_Money_getMoney("Gold", price);
	local silverValue = ESell_Money_getMoney("Silver", price);
	local copperValue = ESell_Money_getMoney("Copper", price);

	SellEnchant_ChangeEnchantePriceFrame_PriceWithPourcent_Price:SetText(ESell_Money_getStringFormatWithColor(floor(priceNoBenef*SellEnchant_Config.PourcentageBenefice)));
	
	if goodPrice < 2 then
		SellEnchant_ChangeEnchantePriceFrame_CheckButton:SetChecked(true);
	end

	SellEnchant_ChangeEnchantePriceFrame.CalcuPrice = floor(priceNoBenef*SellEnchant_Config.PourcentageBenefice);
	SellEnchant_ChangeEnchantePriceFrame.IdEnchante = idEnchantement;
	SellEnchant_ChangeEnchantePriceFrame_GoldEditBox:SetNumber(goldValue);
	SellEnchant_ChangeEnchantePriceFrame_SilverEditBox:SetNumber(silverValue);
	SellEnchant_ChangeEnchantePriceFrame_CopperEditBox:SetNumber(copperValue);

	SellEnchant_ChangeEnchantePriceFrame:Show();
end

function ESell_ChangeEnchantePrice_Reset(isNoMsg)
	if SellEnchant_ChangeEnchantePriceFrame:IsShown() then
		SellEnchant_ChangeEnchantePriceFrame.CalcuPrice = nil;
		SellEnchant_ChangeEnchantePriceFrame.IdEnchante = nil;
		SellEnchant_ChangeEnchantePriceFrame:Hide();
		if not isNoMsg then
			SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_ERROR_PRICELOADCANCEL.." !!!", 1.0, 0.1, 0.1, 1.0, 5);
		end
	end
end

function ESell_ChangeEnchantePrice_SetNewPrice()
	local idEnchante = SellEnchant_ChangeEnchantePriceFrame.IdEnchante;
	local price, goodPrice, priceNoBenef = ESell_Enchante_getPrice(idEnchante);

	if goodPrice < 2 and SellEnchant_ChangeEnchantePriceFrame_CheckButton:GetChecked() then
		ESell_ChangeEnchantePrice_Reset(true);
		return;
	end

	if SellEnchant_ChangeEnchantePriceFrame_CheckButton:GetChecked() then
		SellEnchant_ListEnchant[idEnchante]["TypePrice"] = 1;
		ESell_Enchante_UpdatePrice(idEnchante);
	else
		local newPrice = 0;
		newPrice = ESell_Money_PriceModifier("Gold", SellEnchant_ChangeEnchantePriceFrame_GoldEditBox:GetNumber(), newPrice)
		newPrice = ESell_Money_PriceModifier("Silver", SellEnchant_ChangeEnchantePriceFrame_SilverEditBox:GetNumber(), newPrice)
		newPrice = ESell_Money_PriceModifier("Copper", SellEnchant_ChangeEnchantePriceFrame_CopperEditBox:GetNumber(), newPrice)
		SellEnchant_ListEnchant[idEnchante]["Price"] = newPrice;
		SellEnchant_ListEnchant[idEnchante]["TypePrice"] = 2;
	end
	ESell_ChangeEnchantePrice_Reset(true);
	SellEnchant_Enchante_Frame_OnUpdate();	
end

function ESell_ChangeEnchantePrice_SetStatuEditBox(isEnable)
	local frameMoneyChangeDisable =	function (moneyStr)
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableKeyboard(false);
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableMouse(false);
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):SetTextColor(0.6,0.6,0.6);
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):ClearFocus();
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_up"):Disable();
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_down"):Disable();
		end
	local frameMoneyChangeEnable =	function (moneyStr)
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableKeyboard(true);
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableMouse(true);
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):SetTextColor(1,1,1);
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_up"):Enable();
			getglobal("SellEnchant_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_down"):Enable();
		end

	if isEnable then
		local price = SellEnchant_ChangeEnchantePriceFrame.CalcuPrice;
		local goldValue = ESell_Money_getMoney("Gold", price);
		local silverValue = ESell_Money_getMoney("Silver", price);
		local copperValue = ESell_Money_getMoney("Copper", price);
		SellEnchant_ChangeEnchantePriceFrame_GoldEditBox:SetNumber(goldValue);
		SellEnchant_ChangeEnchantePriceFrame_SilverEditBox:SetNumber(silverValue);
		SellEnchant_ChangeEnchantePriceFrame_CopperEditBox:SetNumber(copperValue);

		frameMoneyChangeDisable("Gold");		
		frameMoneyChangeDisable("Silver");		
		frameMoneyChangeDisable("Copper");		
	else
		frameMoneyChangeEnable("Gold");		
		frameMoneyChangeEnable("Silver");		
		frameMoneyChangeEnable("Copper");		
	end
	
end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Function Divers -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- take in argument a function which will be launched after having opened 
-- the fenetre kraft enchantment and return true,
-- if not enchanter then does not launch the function and return false
function ESell_LaunchFunctionInCraftSpellFrame(arg1Function)
	local isEnchanteur = false;
	local craftSpellFocus = false;
	local i=1;
	while true do
		local spellName, spellRank = GetSpellName(i, "spell" ) 
		if (not spellName) then
			break;
		end
		if (spellName == SELLENCHANT_NAME_OF_ENCHANT_CRAFT) then
			if (not GetCraftSpellFocus(i)) then
				CastSpell(i, "spell");
			else
				craftSpellFocus = true;
			end
			arg1Function();
			isEnchanteur = true;
			break;
		end
		i = i + 1;
	end
	if not craftSpellFocus then CloseCraft() end
	return isEnchanteur;
end

function ESell_getNumVerToLongNum()
	local _,_,numVersion = string.find(SELLENCHANT_VERSION, "^(%d+)%.-%d-");
	local _,_,numSubVersion = string.find(SELLENCHANT_VERSION, "^%d+%.(%d+)");
	if numVersion then numVersion = tonumber(numVersion, 10); end
	if numVersion and numSubVersion then numVersion = numVersion + (tonumber(numSubVersion, 10) / (10^strlen(numSubVersion))); end

	return numVersion;
end

--------------------------------------
-- Called by ESell_Reagent_getPrice --
--------------------------------------
function ESell_CodeFromLink(link)
	if (not link) then return nil; end
	local _, _, code = strfind(link, "(%d+:%d+:%d+:%d+)");
	local code = code and string.gsub(code, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:0");
	return code;
end

function ESell_NameFromLink(link)
	local name;
	if( not link ) then
		return nil;
	end
	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end
	return nil;
end

function ESell_HitemFromLink(link)
	SellEnchant_DebugMessage("Enter ESell_HitemFromLink");
	local hitem;
	if( not link ) then
		SellEnchant_DebugMessage("ESell_HitemFromLink link sent not value");	
		return nil;
	end
	SellEnchant_DebugMessage("Link is "..link);
	SellEnchant_DebugMessage("After ESell_HitemFromLink first end");
	for hitem in string.gfind(link, "|c%x+|H(item:%d+:%d+:%d+:%d+)|h%[.-%]|h|r") do
			SellEnchant_DebugMessage("item link is "..link..", hitem is "..hitem);
		return hitem;
	end
	    for hitem in string.gfind(link, "|c%x+|H(enchant:%d+)|h%[.-%]|h|r") do
		SellEnchant_DebugMessage("enchant link is "..link..", hitem is "..hitem);
		SellEnchant_DebugMessage("Inside ESell_HitemFromLink do");
		return hitem;
	end
	SellEnchant_DebugMessage("After ESell_HitemFromLink second end");
	return nil;
end

function ESell_Chat_InEntryAddText(addText)
	local text = chatEntry:GetText();	-- Here's how you get the original text
	local newText = ("; "..addText);	-- here's where you can modify the text to your liking
	chatEntry:SetText( newText );		-- send the new text back to the UI
	
end

function ESell_ConfirmDialogYesOrNo(msg, functionArg1, functionArg2)
	if SellEnchant_ConfirmFrame:IsShown() then
		SellEnchant_Msg:AddMessage(SELLENCHANT_MSG_ERROR_NEWASKIMPOSSIBLE.." !!!", 1.0, 0.1, 0.1, 1.0, 7);
		return;
	end
	SellEnchant_ConfirmFrame_Msg:SetText(msg);
	SellEnchant_ConfirmFrame.FunctionArg1 = functionArg1;
	SellEnchant_ConfirmFrame.FunctionArg2 = functionArg2;
	SellEnchant_ConfirmFrame:Show();
end

------------------------------------------
-- Toggle General Debug Code on and off --
------------------------------------------
function SellEnchant_DebugToggle_General()
	SellEnchant_Flow_DebugMessage("SellEnchant_DebugToggle_General - ENTER");
	if (SellEnchant_Debug) then
		SellEnchant_DebugMessage("General Debug information turned OFF");
		SellEnchant_Debug = false;
	else
		SellEnchant_Debug = true;
		SellEnchant_DebugMessage("General Debug information turned ON");
	end
	SellEnchant_Flow_DebugMessage("SellEnchant_DebugToggle_General - EXIT");
end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fonction Gestion ToolTip -------------------------------------------------------------------------------------------------------------------------------------------------------------

local infoTooltipIsAdd;


function ESell_ToolTip_OnUpdate(elapsed)
-- Wait a little bit to see if there is more information coming for tooltips
	lESellCheckTimer = lESellCheckTimer + elapsed;
	if( lESellCheckTimer >= 0.2 ) then
		if( lESellCheckTooltip ) then
			lESellCheckTooltip = ESell_ToolTip_CheckTooltipInfo(lESellTooltip);
		end
		lESellCheckTimer = 0;
	end

end


function ESell_ToolTip_GameTooltip_ClearMoney()
	lOriginalGameTooltip_ClearMoney();
	lESellCheckTooltip = ESell_ToolTip_CheckTooltipInfo(GameTooltip);
end

function ESell_ToolTip_GameTooltip_OnHide()
	lOriginalGameTooltip_OnHide();
	GameTooltip.ESellDone = nil;
	infoTooltipIsAdd = nil;

	if ( lESellTooltip ) then
		lESellTooltip.ESellDone = nil;
		lESellTooltip = nil;
	end
end

function ESell_ToolTip_CheckTooltipInfo(frame)
	-- Si information déjà indiqué, ne pas le refaire
	if ( not frame or frame.ESellDone or infoTooltipIsAdd) then
		return nil;
	end

	lESellTooltip = frame;

	if ( frame:IsVisible() ) then
		local field = getglobal(frame:GetName().."TextLeft1");
		if( field and field:IsVisible()) then
			local name = field:GetText();
			if ( name ) then
				ESell_ToolTip_AddTooltipInfo(frame, name);
            	return nil;
			end
		end
	end
	return true;
end

function ESell_ToolTip_AddTooltipInfo(frame, name)
	local idReagent = ESell_Reagent_getId(name);
	if idReagent then
		SellEnchant_DebugMessage("Add info ToolTip");
		local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCount(idReagent);
		local priceUnite = ESell_Reagent_getPrice(idReagent);
		frame.ESellDone = true;
		infoTooltipIsAdd = true;
		frame:AddLine(SELLENCHANT_TOOLTIPADD_TITLE.." :", 0,1,1);
		frame:AddLine(SELLENCHANT_TOOLTIPADD_ONCHARACTER.." : "..nbInBag, 1,0.3,1);
		frame:AddLine(SELLENCHANT_TOOLTIPADD_INBANK.." : "..nbInBank, 1,0.3,1);
		frame:AddLine(SELLENCHANT_TOOLTIPADD_ALTERNATE.." : "..nbInReroll, 1,0.3,1);
		frame:AddLine(SELLENCHANT_TOOLTIPADD_PRICEUNIT.." : "..ESell_Money_getStringFormatWithColor(priceUnite), 1,0.3,1);
	end
	frame:Show();
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
