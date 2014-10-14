--== [ VARIABLES ] ==--
--[ Global variables for RecipeBook ]--
RecipeBookOptions = {};
RECIPEBOOK_DEFAULT_OPTIONS = {
	["Status"] 				= "On"; 
	["Tooltip"] 			= "On"; 
	["ChatFrame"] 			= "Off"; 
	["ShowSelf"] 			= "Off"; 
	["TrackSelf"] 			= "On";
	["SameFaction"] 		= "On"; 
	["SameColor"] 			= "|cff00ff00";
	["OtherFaction"] 		= "Off"; 
	["OtherColor"] 			= "|cff33ccff";
	["Known"] 				= "On"; 
	["KnownColor"] 			= {1,0,0};
	["CanLearn"] 			= "On"; 
	["CanLearnColor"] 		= {0,1,0};
	["WillLearn"] 			= "On"; 
	["WillLearnColor"] 		= {0,.75,.75};
	["Banked"] 				= "Off"; 
	["BankedColor"] 		= {1,0.5,0.1};
	["BlackBanked"] 		= "On";
	["AutoBank"] 			="Off"; 
	["AutoBags"] 			="Off"; 
	["ColorAuctions"] 		="On";
	["AuctionColors"] 		= {
		["AltsCanLearn"] 	= {0.1, 1, 0.1};
		["YouWillLearn"]	= {1, 0.75, 0.1};
		["AltsWillLearn"] 	= {0.1, 0.8, 1.0};
		["NoAltsCanLearn"] 	= {1.0, 0.1, 0.1};
		["AllAltsKnow"] 	= {0.5, 0.1, 0.1};
		["Banked"] 			= {0, 0, 0};
	};
	["TooltipColors"] 		= {
		["SameFaction"] 		= "|cff00ff00";
		["FriendSameFaction"]	= "|cffffff00";
		["OtherFaction"] 		= "|cff33ccff";		
		["FriendOtherFaction"] 	= "|cffff0000";
		["Known"] 			= {1, 0, 0};
		["CanLearn"] 		= {0, 1, 0};
		["WillLearn"] 		= {0, 0.75, 0.75};
		["Banked"] 			= {1, 0.5, 0.1};
	};
	["Receive"] 			="fPgPoP"; 
	["FriendShow"] 			= "On"; 
	["FriendSameFaction"]	="On"; 
	["FriendSameColor"] 	= "|cffffff00";
	["FriendOtherFaction"] 	="Off"; 
	["FriendOtherColor"] 	= "|cffff0000";
	["FriendKnown"] 		="On"; 
	["FriendCanLearn"] 		="On"; 
	["FriendWillLearn"] 	="On";
};
RecipeBookData = {["Version"] = 4};
RecipeBookMasterList = {["Tradeskills"] = {}, ["Links"] = {}, ["Debug"] = {}};
--[ Options data ]--
local Realm, Faction, OtherFaction, Player;
-- Monitoring status of game tooltip/chatframe
local RB_TooltipLines, RB_ChatFrameUpdated = false, false;
--[ Debug ]--
local RB_Debug = false;
local RB_Initialized = false;
local RB_SEAceEnabled = false;
local RB_SENonAceEnabled = false;
local RB_AFPEnabled = false;
local RB_BankFrameOpen = false;

--[ Misc ]--
local RB_TradeskillData = {};
local RecipeBook_NumCurrTradeSkills = 0;
local RB_LastWhat = {nil, nil, false, {}};
local RB_BagContents = {};

--[ Hooked Function Variables ]--
local RecipeBook_Old_GameTooltip_OnHide;
local RecipeBook_Old_ContainerFrameItemButton_OnEnter;
local RecipeBook_Old_AuctionFrameItem_OnEnter;
local RecipeBook_Old_SetItemRef;
local RecipeBook_Old_GameTooltip_SetInventoryItem;
local RecipeBook_Old_GameTooltip_SetMerchantItem;
local RecipeBook_Old_CloseBankFrame;


--== [ ON LOAD ] ==--
function RecipeBook_OnLoad()
	--== Configuration Frame ==--
	UIPanelWindows["RecipeBook_ConfigFrame"] = {area = "center", pushable = 0};
	tinsert(UISpecialFrames, "RecipeBook_ConfigFrame");
	--== Event Registration ==--
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD"); --For loading data
	this:RegisterEvent("PLAYER_LEAVING_WORLD"); --For writing data
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE"); --Auction list updating can otherwise clear tooltips
	this:RegisterEvent("AUCTION_HOUSE_SHOW"); -- For AuctionFilterPlus
	this:RegisterEvent("CHAT_MSG_SKILL"); --Skillups for disenchants make baby enchanters happy.
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_UPDATE");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("CRAFT_CLOSE");
	
	--Slash Command Handlers--
	SlashCmdList["RecipeBook"] = RecipeBook_SlashHandler;
	SLASH_RecipeBook1 = "/recipebook";
	SLASH_RecipeBook2 = "/rbook";
	
	DEFAULT_CHAT_FRAME:AddMessage(RECIPEBOOK_LOADED);
--	if RB_Initialized then RecipeBook_HookFunctions() end;
end

--== [ INITIALIZE ] ==--
-- [ InitializeSetup() : New Player? New Data? This makes sure all the options are in the right place. ] --
local function RecipeBook_InitializeSetup()
	if Faction == nil then 
		RecipeBook_SetGlobals();
		if Faction == nil then 
			RecipeBook_Print("No Faction data available for this character.  Defaulting to Alliance.  PLEASE contact Ayradyss (dr.nykki@gmail.com) and inform her.", 1);
			Faction = FACTION_ALLIANCE;
		end
	end	

	if (RecipeBookData.Version == nil) or (RecipeBookData.Version < 2) then -- If you're older than v2 then you've been playing with a nonfunctional RecipeBook for several patches.
		if RecipeBookData[Realm] ~= nil then RecipeBook_Print("Your RecipeBook is too outdated for conversion.  You're going to have to start over.", 1) end;
		RecipeBookData = {};
		RecipeBookData.Version = 4;
	end
	
	--Setting up data structures.
	if RecipeBookData[Realm] == nil then --This realm
		RecipeBookData[Realm] = {};
	end
	if RecipeBookData[Realm][Faction] == nil then --This faction (now localized!)
		RecipeBookData[Realm][Faction] = {};
	end
	if RecipeBookData[Realm][Faction]["Personal"] == nil then --Your characters
		RecipeBookData[Realm][Faction]["Personal"] = {};
	end
	if RecipeBookData[Realm][Faction]["Personal"][Player] == nil then --This character
		RecipeBookData[Realm][Faction]["Personal"][Player] = {};
	end
	if RecipeBookData[Realm][Faction]["Shared"] == nil then --Any shared data.
		RecipeBookData[Realm][Faction]["Shared"] = {};
	end
	if RecipeBookData[Realm][Faction]["Banked"] == nil then --Any banked items (saved by faction, now noting who banked them.)
		RecipeBookData[Realm][Faction]["Banked"] = {};
	end
	
	if RecipeBookMasterList == nil then --Archiving master data
		RecipeBookMasterList = {["Tradeskills"] = {}, ["Links"] = {}, ["Debug"] = {}};
	end
	if RecipeBookMasterList["Tradeskills"] == nil then --Tradeskill items that can be made, with link and mats.
		RecipeBookMasterList["Tradeskills"] = {};
	end
	if RecipeBookMasterList["Links"] == nil then 
		RecipeBookMasterList["Links"] = {};
	end
	if RecipeBookMasterList["BankData"] == nil then 
		RecipeBookMasterList["BankData"] = {};
	end
	if RecipeBookMasterList["Recipes"] ~= nil then RecipeBookMasterList["Recipes"] = nil end;
	RecipeBookMasterList["Debug"] = {};
		
	if RecipeBookData[Realm][Faction]["Banked"]["Pending"] ~= nil then
		RecipeBookData[Realm][Faction]["Banked"]["Pending"] = nil;
	end
	
	if RecipeBookData[Realm][Faction]["Personal"][Player]["Options"] ~= nil then
		for k,v in pairs(RecipeBookData[Realm][Faction]["Personal"][Player]["Options"]) do RecipeBookOptions[k] = v end;
		RecipeBookData[Realm][Faction]["Personal"][Player]["Options"] = nil;
	end

	if next(RecipeBookData[Realm][Faction]["Banked"]) ~= nil then --Fixing errors in banked data
		for k,v in pairs(RecipeBookData[Realm][Faction]["Banked"]) do
			if next(v) == nil then RecipeBookData[Realm][Faction]["Banked"][k] = nil end;
		end
	end

	if RecipeBookMasterList["Tradeskills"][1] ~= nil then 
	--Convert materials data to save space
		RecipeBookMasterList["Links"] = {};
		local TempMasterList = {};
		for key, skills in pairs(RecipeBookMasterList["Tradeskills"]) do 
			TempMasterList[key] = {};
			for name, what in pairs(skills) do
				id = RecipeBook_StringToID(what["ID"]);
				if id ~= nil then
					RecipeBookMasterList["Links"][id] = what["ID"];
					TempMasterList[key][name] = {["ID"] = id,["Materials"] = {}};
					local length = table.getn(what["Materials"])
					for i = 1, length, 1 do
						id = RecipeBook_StringToID(what["Materials"][i][1]);
						if id ~= nil then 
							RecipeBookMasterList["Links"][id] = what["Materials"][i][1];
							TempMasterList[key][name]["Materials"][id] = what["Materials"][i][2];
						end
					end
				end
			end
		end
		RecipeBookMasterList["Tradeskills"] = TempMasterList;
		--Convert banked data as well.
		if next(RecipeBookData[Realm][Faction]["Banked"]) ~= nil then --Conversion of banked items
			for i, v in ipairs(RecipeBookData[Realm][Faction]["Banked"]) do
				if type(v) == "string" then RecipeBookData[Realm][Faction]["Banked"][i] = {RecipeBookData[Realm][Faction]["Banked"][i], {{"(Unknown)", "Manual"}}} end;
			end
			local TempBankedData = {};
			for i, v in ipairs(RecipeBookData[Realm][Faction]["Banked"]) do
				local name = v[1];
				TempBankedData[name] = {};
				for j = 1, table.getn(RecipeBookData[Realm][Faction]["Banked"][i][2]) do
					TempBankedData[name][RecipeBookData[Realm][Faction]["Banked"][i][2][j][1]] = RecipeBookData[Realm][Faction]["Banked"][i][2][j][2];
				end
				if (next(TempBankedData[name]) == nil) then TempBankedData[name] = nil end;
			end
			RecipeBookData[Realm][Faction]["Banked"] = TempBankedData;
		end
	end
	
	RecipeBookData.Version = 4;
	RecipeBook_ParsePendingRecipes();
	RecipeBook_HookFunctions();
	RB_Initialized = true;
end

local function RecipeBook_SetGlobals()
	Player = UnitName("player");
	Realm = GetRealmName();
	Faction = UnitFactionGroup("player");
	if Faction ~= nil then
		if FACTION_ALLIANCE ~= "Alliance" then --Blizzard's UnitFactionGroup does not return localized data.
			if (Faction == "Alliance" or Faction == FACTION_ALLIANCE) then Faction = FACTION_ALLIANCE;
			else Faction = FACTION_HORDE;
			end
		end
		OtherFaction = (Faction == FACTION_HORDE and FACTION_ALLIANCE or FACTION_HORDE);
	end
end

function RecipeBook_HookFunctions()
	-- Blizzard function hooks --
	RecipeBook_Old_AuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter; --Auction Frame
	AuctionFrameItem_OnEnter = RecipeBook_AuctionFrameItem_OnEnter;
	
 	if RecipeBook_Old_AuctionFrameBrowse_Update ~= AuctionFrameBrowse_Update then
		RecipeBook_Old_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
		AuctionFrameBrowse_Update = RecipeBook_AuctionFrameBrowse_Update;
 	end
	
	RecipeBook_Old_MerchantFrame_UpdateMerchantInfo = MerchantFrame_UpdateMerchantInfo;
	MerchantFrame_UpdateMerchantInfo = RecipeBook_MerchantFrame_UpdateMerchantInfo;

	RecipeBook_Old_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter; --Good ol' bags
	ContainerFrameItemButton_OnEnter = RecipeBook_ContainerFrameItemButton_OnEnter;
	
	RecipeBook_Old_GameTooltip_OnHide = GameTooltip_OnHide;  --Tidy up data
	GameTooltip_OnHide = RecipeBook_GameTooltip_OnHide;
	
 	RecipeBook_Old_SetItemRef = SetItemRef; --Chat links
 	SetItemRef = RecipeBook_SetItemRef;
 	
	RecipeBook_Old_GameTooltip_SetLootItem = GameTooltip.SetLootItem; --Loot items
	GameTooltip.SetLootItem = RecipeBook_GameTooltip_SetLootItem;

	RecipeBook_Old_GameTooltip_SetInventoryItem = GameTooltip.SetInventoryItem; --Bank slots
	GameTooltip.SetInventoryItem = RecipeBook_GameTooltip_SetInventoryItem;
	
	RecipeBook_Old_GameTooltip_SetMerchantItem = GameTooltip.SetMerchantItem; --Bank slots
	GameTooltip.SetMerchantItem = RecipeBook_GameTooltip_SetMerchantItem;
	
	RecipeBook_Old_ChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = RecipeBook_ChatFrame_OnEvent;
	
	RecipeBook_Old_CloseBankFrame = CloseBankFrame; --For bank scanning
	CloseBankFrame = RecipeBook_CloseBankFrame;

	
	--== Specific hooks for specific mods ==--

	-- MyInventory/MyBags	--
	if(IsAddOnLoaded("MyInventory") or IsAddOnLoaded("MyBags")) then 
		RecipeBook_Old_MIFrameItemButton_OnEnter = MyInventory_FrameItemButton_OnEnter;
		MyInventory_FrameItemButton_OnEnter = RecipeBook_MIFrameItemButton_OnEnter;
		RecipeBook_Old_MIFrameItemButton_OnUpdate = MyInventoryFrameItemButton_OnUpdate;
		MyInventoryFrameItemButton_OnUpdate = RecipeBook_MIFrameItemButton_OnUpdate;
	end
	-- AllInOneInventory --
	if IsAddOnLoaded("AllInOneInventory") then 
		RecipeBook_Old_AIOI_ModifyItemTooltip = AllInOneInventory_ModifyItemTooltip;
		AllInOneInventory_ModifyItemTooltip = RecipeBook_AIOI_ModifyItemTooltip;
	end
	-- BankStatement --
	if IsAddOnLoaded("BankStatement") then --Checking for BankStatement to play nice.
		RecipeBook_Old_BS_ItemButton_OnEnter = BankStatementItemButton_OnEnter;
		BankStatementItemButton_OnEnter = RecipeBook_BS_ItemButton_OnEnter;
		
		RecipeBook_Old_BS_ContainerFrameItemButton_OnEnter = BankStatementContainerFrameItemButton_OnEnter;
		BankStatementContainerFrameItemButton_OnEnter = RecipeBook_BS_ContainerFrameItemButton_OnEnter;
	end
	-- BankItems --
	if IsAddOnLoaded("BankItems") then 
		RecipeBook_Old_BI_Button_OnEnter = BankItems_Button_OnEnter;
		BankItems_Button_OnEnter = RecipeBook_BI_Button_OnEnter;
		
		RecipeBook_Old_BI_BagItem_OnEnter = BankItems_BagItem_OnEnter;
		BankItems_BagItem_OnEnter = RecipeBook_BI_BagItem_OnEnter;
	end
	if IsAddOnLoaded("SortEnchant") then
		if SortEnchant.Hooks ~= nil then RB_SEAceEnabled = true end;
	end
	-- EngInventory --
	if IsAddOnLoaded("EngInventory")then
		RecipeBook_Old_EngInventory_ItemButton_OnEnter = EngInventory_ItemButton_OnEnter;
		EngInventory_ItemButton_OnEnter = RecipeBook_EngInventory_ItemButton_OnEnter;
	end	
	-- EngBank --
	if IsAddOnLoaded("EngBank")then
		RecipeBook_Old_EngBank_ItemButton_OnEnter = EngBank_ItemButton_OnEnter;
		EngBank_ItemButton_OnEnter = RecipeBook_EngBank_ItemButton_OnEnter;
	end	
	-- LinkWrangler --
	if (IsAddOnLoaded("LinkWrangler") ~= nil) then
		LINK_WRANGLER_CALLER["RecipeBook"] = "RecipeBook_DoHookedFunction";
	end
	-- ForgottenChat --
	if (IsAddOnLoaded("ForgottenChat") ~= nil) then
		FC_AddBlacklist("["..RECIPEBOOK_MESSAGE_TRIGGER_WORD.."]");
	end
	
	if (IsAddOnLoaded("RestedBonus") ~= nil) then
		SLASH_RecipeBook3 = "/rbk";
	else
		SLASH_RecipeBook3 = "/rb";
	end
	--== Static Popup Windows for data send ==--
	StaticPopupDialogs["RECIPEBOOK_REQUESTING_SEND"] = {
		text = " ",
		button1 = TEXT(ACCEPT),
		button2 = TEXT(DECLINE),
		OnShow = function()
			this.timeleft = RECIPEBOOK_SEND_TIMEOUT;
		end,
		OnAccept = function()
			RecipeBookMessenger_AcceptSession(RecipeBookMessenger_GetName(), RecipeBookMessenger_GetTradeskill());
		end,
		OnCancel = function ()
			RecipeBookMessenger_CancelSession(RecipeBookMessenger_GetName(), RecipeBookMessenger_GetTradeskill());
		end,
		OnUpdate = function(elapsed)
			local text = getglobal(this:GetName().."Text");
			local timeleft = ceil(this.timeleft);
			if ( timeleft < 60 ) then
				text:SetText(format(RECIPEBOOK_POPUP_RECEIVE, RecipeBookMessenger_GetName(), RecipeBookMessenger_GetTradeskill(), timeleft, GetText("SECONDS", nil, timeleft)));
			else
				text:SetText(format(RECIPEBOOK_POPUP_RECEIVE, RecipeBookMessenger_GetName(), RecipeBookMessenger_GetTradeskill(), ceil(timeleft / 60), GetText("MINUTES", nil, ceil(timeleft / 60))));
			end
			StaticPopup_Resize(this, "RECIPEBOOK_REQUESTING_SEND");
		end,
		timeout = RECIPEBOOK_SEND_TIMEOUT,
		whileDead = 1;
	};
		StaticPopupDialogs["RECIPEBOOK_AWAITING_SEND"] = {
		text = " ",
		button1 = TEXT(CANCEL),
		OnShow = function()
			this.timeleft = RECIPEBOOK_SEND_TIMEOUT;
		end,
		OnAccept = function ()
			RecipeBookMessenger_CancelSession(RecipeBookMessenger_GetName(), RecipeBookMessenger_GetTradeskill());
		end,
		OnUpdate = function(elapsed)
			local text = getglobal(this:GetName().."Text");
			local timeleft = ceil(this.timeleft);
			if ( timeleft < 60 ) then
				text:SetText(format(RECIPEBOOK_POPUP_SEND,  RecipeBookMessenger_GetTradeskill(), RecipeBookMessenger_GetName(), timeleft, GetText("SECONDS", nil, timeleft)));
			else
				text:SetText(format(RECIPEBOOK_POPUP_SEND, RecipeBookMessenger_GetTradeskill(), RecipeBookMessenger_GetName(), ceil(timeleft / 60), GetText("MINUTES", nil, ceil(timeleft / 60))));
			end
			StaticPopup_Resize(this, "RECIPEBOOK_AWAITING_SEND");
		end,
		timeout = RECIPEBOOK_SEND_TIMEOUT,
		whileDead = 1;
	};
end

function RecipeBook_GetGlobals()
	return Realm, Faction, OtherFaction, Player;
end

function RecipeBook_HookAFP()
	if RB_AFPEnabled == true then 
		return;
	end
	if not IsAddOnLoaded("AuctionFilterPlus") then
		this:UnregisterEvent("AUCTION_HOUSE_SHOW");
		return;
	end
	if afp_AuctionFrameBrowse_Update ~= nil then 
		RecipeBook_Debug("Hooking AFP now.");
		RecipeBook_Old_afp_AuctionFrameBrowse_Update = afp_AuctionFrameBrowse_Update;
	 	afp_AuctionFrameBrowse_Update = RecipeBook_AuctionFrameBrowse_Update;
	 	RB_AFPEnabled = true;
		this:UnregisterEvent("AUCTION_HOUSE_SHOW");
	else
		RecipeBook_Debug("AFP Browse Update nil.  AFP NOT hooked.");
	end
end


--== [ EVENT HANDLERS ] ==--
-- [ OnEvent(event) : So what happens when an event fires? ] --
function RecipeBook_OnEvent(event)
--	RecipeBook_Debug(event);
	if (event == "PLAYER_ENTERING_WORLD") then
		if RB_Initialized then return end;
		RecipeBook_SetGlobals();
		RecipeBook_InitializeSetup();
		RecipeBook_BagsOnOff("On"); --For saving items in bags
		RecipeBook_TrackingOnOff("On");
	elseif (event =="PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("BAG_UPDATE");
		RecipeBookData[Realm][Faction]["Pending"] = RB_BagContents;
	elseif(event == "BAG_UPDATE") then
		RecipeBook_DoAutoBagScan();
	elseif(event == "CRAFT_SHOW" or event=="TRADE_SKILL_SHOW") then
		local specString = RecipeBook_SpecialtyScan();
		if specString ~= "None" then RecipeBook_Print(RECIPEBOOK_ADDED_SPECIALS..specString, 0) end
		RecipeBook_ShowSkillInfo(event);
	elseif(event == "CRAFT_UPDATE" or event == "TRADE_SKILL_UPDATE") then
		RecipeBook_UpdateSkillInfo(event);
	elseif(event == "CRAFT_CLOSE" or event == "TRADE_SKILL_CLOSE") then
		RecipeBook_NumCurrTradeSkills = 0;	
	elseif(event=="AUCTION_ITEM_LIST_UPDATE") then
		RecipeBook_DoHookedFunction();
	elseif(event=="CHAT_MSG_SKILL") then
		RecipeBook_ParseSkillupMessage(arg1);
	elseif(event == "CHAT_MSG_SYSTEM") then
		RecipeBook_ParseSystemMessage(arg1);
	elseif(event == "BANKFRAME_OPENED") then
		RB_BankFrameOpen = true;
		RecipeBook_DoAutoBank();
	elseif event == "PLAYER_REGEN_DISABLED" then
		RecipeBook_BagsOnOff("Off");
	elseif event == "PLAYER_REGEN_ENABLED" then
		RecipeBook_BagsOnOff("On");
	elseif(event == "ADDON_LOADED") then
		if string.lower(arg1) == "recipebook" then 
			RecipeBook_SetGlobals();
			if Faction ~= nil then 
				RecipeBook_InitializeSetup();
			end
		elseif string.lower(arg1) == "sortenchant" then
			if SortEnchant.Hooks ~= nil then RB_SEAceEnabled = true end;
		elseif arg1 == "Blizzard_AuctionUI" then 
			RecipeBook_Old_AuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter; --Auction Frame
			AuctionFrameItem_OnEnter = RecipeBook_AuctionFrameItem_OnEnter;
			if not IsAddOnLoaded("AuctionFilterPlus") then
				RecipeBook_Old_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
				AuctionFrameBrowse_Update = RecipeBook_AuctionFrameBrowse_Update;
			else
				RecipeBook_HookAFP()
 			end
		end
 	elseif event == "AUCTION_HOUSE_SHOW" then 
 		RecipeBook_Debug(event);
		RecipeBook_HookAFP()
	end
	
end

--[ SlashHandler: for all those nifty /rb commands ]--
function RecipeBook_SlashHandler(msg)
	--/rb : Display status.
	if (not msg or msg == "") then 
		RecipeBook_PrintStatus("all");
		return;
	end
	--/rb config|options : Toggles the config window
	if (msg == "config") or (msg == "options") then
		RecipeBookOptions_ShowOptionsFrame();
	--/rb on : Turn RecipeBook on
	elseif(msg == "on") then 
		RecipeBookOptions_SetOption("Status", "On");
		RecipeBook_PrintStatus("Status");
	--/rb off : Turn RecipeBook off
	elseif(msg == "off") then 
		RecipeBookOptions_SetOption("Status", "Off");
		RecipeBook_PrintStatus("Status");
	--/rb help : Display usage
	elseif (msg == "help") then 
		RecipeBook_Print(RECIPEBOOK_USAGE, -1);
	--/rb status : Display RecipeBook on/off status
	elseif(msg == "status") then  RecipeBook_PrintStatus("Status")
	--/rb version : Display RecipeBook version number
	elseif(msg == "version") then RecipeBook_Print(RECIPEBOOK_VERSION, 0);
	else
		local msglist = {};
		local toggle;
		msglist = RecipeBook_Split(string.lower(msg));
		--/rb skill [alt] [tradeskill] Print alt list for a particular tradeskill
		if (msglist[1] == "skill") then 
			if(msglist[2] and msglist[3]) then 
				msglist[3] = table.concat(msglist, " ", 3);
				RecipeBook_SkillDisplay(msglist[2], msglist[3]);
			elseif not msglist[2] then 
				return RecipeBook_Print(RECIPEBOOK_NOALTGIVEN, 1);
			elseif not msglist[3] then 
				return RecipeBook_Print(RECIPEBOOK_NOTRADESKILLGIVEN, 1);
			end
		--/rb search [search string] : Search RecipeBook data for matches on a particular string.
		elseif (msglist[1] == "search") then 
			if not msglist[2] then 
				RecipeBook_SearchFrame:Show();
				RecipeBookSearch_CBX_SearchItems:SetChecked(1);
				RecipeBookSearch_CBX_SearchMats:SetChecked(0);
			else
				msg = table.concat(msglist, " ", 2);
				RecipeBook_SearchFrame:Show();
				RecipeBookSearch_CBX_SearchItems:SetChecked(1);
				RecipeBookSearch_CBX_SearchMats:SetChecked(0);
				RecipeBook_SearchFor:SetText(msg);
				RecipeBookSearch_DoSearch();
			end
		--/rb searchmats [search string] : Search RecipeBook data for items using materials that match a particular string.
		elseif (msglist[1] == "searchmats") then 
			if not msglist[2] then 
				RecipeBook_SearchFrame:Show();
				RecipeBookSearch_CBX_SearchItems:SetChecked(0);
				RecipeBookSearch_CBX_SearchMats:SetChecked(1);
			else
				msg = table.concat(msglist, " ", 2);
				msg = table.concat(msglist, " ", 2);
				RecipeBook_SearchFrame:Show();
				RecipeBookSearch_CBX_SearchItems:SetChecked(0);
				RecipeBookSearch_CBX_SearchMats:SetChecked(1);
				RecipeBook_SearchFor:SetText(msg);
				RecipeBookSearch_DoSearch();
			end
		--/rb faction [same|opposite|both] : Change factional display
		elseif (msglist[1] == "faction") then
			if msglist[2] then
				if(msglist[2] == "same") then 
					RecipeBookOptions_SetOption("SameFaction", "On");
					RecipeBookOptions_SetOption("OtherFaction", "Off");
				elseif(msglist[2] == "opposite") then 
					RecipeBookOptions_SetOption("SameFaction", "Off");
					RecipeBookOptions_SetOption("OtherFaction", "On");
				elseif(msglist[2] == "both") then 
					RecipeBookOptions_SetOption("SameFaction", "On");
					RecipeBookOptions_SetOption("OtherFaction", "On");
				else 
					RecipeBook_Print(RECIPEBOOK_INVALID_DISPLAY, 1);
				end
			end
			RecipeBook_PrintStatus("AltFaction");
		--/rb debug : Debug toggle
		elseif(msglist[1] == "debug") then
			if (RB_Debug) then 
				RB_Debug = false;
			else 
				RB_Debug = true;
			end
			RecipeBook_Print("Debug: "..(RB_Debug and "ON" or "OFF"), 0);
		--/rb chatframe [on|off] : Toggle chatframe output
		elseif(msglist[1] == "chatframe") then 
			if msglist[2] then RecipeBook_ToggleOption("ChatFrame", msglist[2]);
			else RecipeBook_PrintStatus("Output");
			end
		--/rb tooltip [on|off] : Toggle tooltip output
		elseif(msglist[1] == "tooltip") then 
			if msglist[2] then RecipeBook_ToggleOption("Tooltip", msglist[2]);
			else RecipeBook_PrintStatus("Output");
			end
		--/rb self [on|off] : Show/hide the current character
		elseif(msglist[1] == "self") then 
			if msglist[2] then RecipeBook_ToggleOption("ShowSelf", msglist[2]);
			else RecipeBook_PrintStatus("ShowSelf");
			end
		--/rb known [on|off] : Show/hide already known
		elseif(msglist[1] == "known") then
			if msglist[2] then RecipeBook_ToggleOption("Known", msglist[2])
			else RecipeBook_PrintStatus("Known");
			end
		--/rb learn [on|off] : Show/hide can be learned by
		elseif(msglist[1] == "learn") then
			if msglist[2] then RecipeBook_ToggleOption("CanLearn", msglist[2])
			else RecipeBook_PrintStatus("CanLearn");
			end
		--/rb future [on|off] : Show/hide will be learnable by
		elseif msglist[1] == "future" then
			if msglist[2] then RecipeBook_ToggleOption("WillLearn", msglist[2])
			else RecipeBook_PrintStatus("WillLearn");
			end
		--/rb banked : Show/hide banked status
		elseif msglist[1] == "banked" then
			if msglist[2] then RecipeBook_ToggleOption("Banked", msglist[2])
			else RecipeBook_PrintStatus("Banked");
			end
		--/rb autobank [on|off] : Toggle automatic scanning of bank for recipes
		elseif msglist[1] == "autobank" then
			if msglist[2] then RecipeBook_ToggleOption("AutoBank", msglist[2])
			else RecipeBook_PrintStatus("AutoBank");
			end
		--/rb autobag [on|off] : Toggle automatic scanning of bags for recipes (occurs at logout)
		elseif msglist[1] == "autobag" then
			if msglist[2] then 
				RecipeBook_ToggleOption("AutoBags", msglist[2]);
				RecipeBook_BagsOnOff(msglist[2]);		
			else RecipeBook_PrintStatus("AutoBags");
			end
		--/rb specials : Scans for tradeskill specializations.
		elseif msglist[1] == "specials" then
			RecipeBook_Print(RECIPEBOOK_ADDED_SPECIALS..(RecipeBook_SpecialtyScan()), 0);
		--/rb banklist : Lists all the items in the bank.
		elseif msglist[1] == "banklist" then
			if msglist[2] then
				local who = string.gsub(msglist[2], "(%l)([%w_']*)", function(a,b)return string.upper(a)..string.lower(b)end);
				RecipeBook_Print(string.format(RECIPEBOOK_CHATFRAME_BANKLISTPERSONALHEADER, who), 0)
				RecipeBook_Print("-------------------------------------", 0)
				local match = false;
				for k,v in pairs(RecipeBookData[Realm][Faction]["Banked"]) do 
					if v[who] ~= nil then
						RecipeBook_Print(k.." ("..v[who]..")");
						match = true;
					end
				end
				if not match then RecipeBook_Print(RECIPEBOOK_CHATFRAME_BANKLISTBLANK..who.."...") end;
			else --No character given.
				RecipeBook_Print(RECIPEBOOK_CHATFRAME_BANKLISTHEADER, 0)
				RecipeBook_Print("-------------------------------------", 0)
				local bywhom = {};
				for k,v in pairs(RecipeBookData[Realm][Faction]["Banked"]) do
					for c,d in pairs(v) do
						table.insert(bywhom, c..(d == "Manual" and "  (manual)" or "")); 
						RecipeBook_Print(k.." by "..table.concat(bywhom, ", "),0); 
						bywhom = {};
					end
				end
			end
		--/rb bank <link> : Adds an item to the banked items list for that character.
		elseif msglist[1] == "bank" then
			if msglist[2] then RecipeBook_DoManualBank(msg)
			else return RecipeBook_Print(RECIPEBOOK_BANK_FAIL, 1); --no success.
			end
		--/rb unbank <link> [all]: Removes an item from the banked items list for that character/all characters.
		elseif msglist[1] =="unbank" then
			if msglist[2] then RecipeBook_DoUnbank(msg);
			else return RecipeBook_Print(RECIPEBOOK_UNBANK_FAIL, 1); --no success.
			end
		--/rb reset <tradeskill> : Removes tradeskill data for the current character.
		elseif msglist[1] == "reset" then
			if msglist[2] then RecipeBook_ResetData(msglist[2])
			else RecipeBook_Print(RECIPEBOOK_INVALID_RESET, 1);
			end
		--/rb clear <character> : Removes all RecipeBook data for a particular character (not the current one).
		elseif msglist[1] == "clear" then
			if msglist[2] then
				who = string.gsub(msglist[2], "%l", string.upper, 1)
				if who == Player then return RecipeBook_Print(RECIPEBOOK_ERROR_RESETSELF, 1) end;
				if(RecipeBookData[Realm][Faction]["Personal"][who]) then --alt exists, same faction
					RecipeBookData[Realm][Faction]["Personal"][who] = nil;
					RecipeBook_Print(RECIPEBOOK_RESET_ALL..who, 0)
				elseif(RecipeBookData[Realm][Faction]["Shared"]) ~= nil then --shared data exists
					if RecipeBookData[Realm][Faction]["Shared"][who] ~= nil then --friend exists, same faction
						RecipeBookData[Realm][Faction]["Shared"][who] = nil;
						RecipeBook_Print(RECIPEBOOK_RESET_ALL..who, 0)
					end
				elseif(RecipeBookData[Realm][(Faction== "Alliance" and "Horde" or "Alliance")] ~= nil) then --opposite faction exists
					if(RecipeBookData[Realm][(Faction== "Alliance" and "Horde" or "Alliance")]["Personal"] ~= nil) then --personal data exists
						if RecipeBookData[Realm][(Faction== "Alliance" and "Horde" or "Alliance")]["Personal"][who] ~= nil then --alt exists, opposite faction
							RecipeBookData[Realm][(Faction== "Alliance" and "Horde" or "Alliance")]["Personal"][who] = nil;
							RecipeBook_Print(RECIPEBOOK_RESET_ALL..who, 0)
						end
					elseif (RecipeBookData[Realm][(Faction== "Alliance" and "Horde" or "Alliance")]["Shared"] ~= nil) then --shared data exists
						if RecipeBookData[Realm][(Faction== "Alliance" and "Horde" or "Alliance")]["Shared"][who] ~= nil then --friend exists, opposite faction
							RecipeBookData[Realm][(Faction== "Alliance" and "Horde" or "Alliance")]["Shared"][who] = nil;
							RecipeBook_Print(RECIPEBOOK_RESET_ALL..who, 0)
						else --no such data exists
							RecipeBook_Print(RECIPEBOOK_NOALTMATCH..who, -1);
						end
					else
						RecipeBook_Print(RECIPEBOOK_NOALTMATCH..who, -1);
					end
				else
					RecipeBook_Print(RECIPEBOOK_NOALTMATCH..who, -1);
				end
			end
		--/rb send <player> <tradeskill>
		elseif(msglist[1] == "send") then
			if(msglist[2] and msglist[3]) then 
				RecipeBookMessenger_InitiateSession(string.gsub(msglist[2], "^%l", string.upper), string.gsub(table.concat(msglist, " ", 3), "(%l)([%w_']*)", function(a,b)return string.upper(a)..string.lower(b)end), Player)
			elseif (msglist[2] and msglist[2] == "kill") then RecipeBookMessenger_KillSession();
	 		else RecipeBook_Print(RECIPEBOOK_SEND_USAGE, 1)
			end
		--/rb receive <friend|guild|others> <accept|decline|prompt>
		elseif(msglist[1] == "receive") then
			if msglist[2] and msglist[3] then
				local op, set;
				if (string.find("friend guild others", msglist[2]) and string.find("accept decline prompt", msglist[3]))then 
					op = string.sub(msglist[2], 1, 1);
					set = string.upper(string.sub(msglist[3], 1, 1));
				else 
					RecipeBook_Print(RECIPEBOOK_RECEIVE_USAGE, 1);
					return;
				end
				if ((not IsInGuild()) and op == "g") then return RecipeBook_Print(RECIPEBOOK_NOTINGUILD, 1) end;
				local option = RecipeBookOptions_GetOption("Receive")
				local regex = "("..op.."[ADP])";
				option = string.gsub(option, regex, op..set);
				RecipeBookOptions_SetOption("Receive", option);
				RecipeBook_PrintStatus("Receive");
			elseif msglist[2] then
				RecipeBook_Print(RECIPEBOOK_RECEIVE_USAGE, 1);
			else
				RecipeBook_PrintStatus("Receive");	
			end
		--/rb friend <on|off> | faction<same|opposite|both> | known <on|off> | learn <on|off> | future <on|off> 
		elseif(msglist[1] == "friend") then
			--/rb friend on|off
			if ((msglist[2] == "on") or (msglist[2] == "off")) then 
				RecipeBookOptions_SetOption("FriendShow", string.gsub(msglist[2], "^%l", string.upper));
				RecipeBook_PrintStatus("FriendShow");
			--/rb friend faction
			elseif msglist[2] == "faction" then 
				if msglist[3] then
					if(msglist[3] == "same") then 
						RecipeBookOptions_SetOption("FriendSameFaction", "On");
						RecipeBookOptions_SetOption("FriendOtherFaction", "Off");
					elseif(msglist[3] == "opposite") then 
						RecipeBookOptions_SetOption("FriendSameFaction", "Off");
						RecipeBookOptions_SetOption("FriendOtherFaction", "On");
					elseif(msglist[3] == "both") then 
						RecipeBookOptions_SetOption("FriendSameFaction", "On");
						RecipeBookOptions_SetOption("FriendOtherFaction", "On");
					else 
						RecipeBook_Print(RECIPEBOOK_INVALID_DISPLAY, 1);
					end
				end
				RecipeBook_PrintStatus("FriendAltFaction");
			--/rb friend known
			elseif msglist[2] == "known" then
				if msglist[3] then RecipeBook_ToggleOption("FriendKnown", msglist[3])
				else RecipeBook_PrintStatus("FriendKnown");
				end
			--/rb friend learn
			elseif msglist[2] == "learn" then
				if msglist[3] then RecipeBook_ToggleOption("FriendCanLearn", msglist[3]);
				else RecipeBook_PrintStatus("FriendCanLearn");
				end
			--/rb friend future 
			elseif msglist[2] == "future" then
				if msglist[3] then RecipeBook_ToggleOption("FriendWillLearn", msglist[3]);
				else RecipeBook_PrintStatus("FriendWillLearn");
				end
			end
		--/rb auction : sets auction colors
		elseif msglist[1] == "auction" or msglist[1] == "auctions" then	
			if msglist[2] == nil then
				RecipeBook_Print(RECIPEBOOK_ERROR_INVALIDCOLOR, -1);
			elseif msglist[2] ~= nil then
				_,_,a,b,c = string.find(string.gsub(msg,"[^%d,%.]", ""), "([%d%.]+),([%d%.]+),([%d%.]+)");
				RecipeBook_Debug(a);
				a = tonumber(a);
				b = tonumber(b);
				c = tonumber(c);
-- 				for n = 3, 5, 1 do 
-- 					msglist[n] = tonum(string.gsub(msglist[n], ",", ""));
-- 				end
				if msglist[2] == "altslearn" then
					RecipeBookOptions_SetOption({"AuctionColors","AltCanLearn"}, {a,b,c});
				elseif msglist[2] == "altsfuture" then
					RecipeBookOptions_SetOption({"AuctionColors","AltWillLearn"}, {a,b,c});
				elseif msglist[2] == "youfuture" then
					RecipeBookOptions_SetOption({"AuctionColors","YouWillLearn"}, {a,b,c});
				elseif msglist[2] == "noalts" then
					RecipeBookOptions_SetOption({"AuctionColors","NoAltsCanLearn"}, {a,b,c});
				elseif msglist[2] == "allknown" then
					RecipeBookOptions_SetOption({"AuctionColors","AllAltsKnow"}, {a,b,c});
				else
					RecipeBook_Print(RECIPEBOOK_ERROR_INVALIDCOLOR, 1);
				end
			else
				RecipeBook_Print(RECIPEBOOK_ERROR_INVALIDCOLOR, 1);
			end
			RecipeBook_PrintStatus("AuctionColors");
		--No valid argument given.
		else 
			RecipeBook_Print(RECIPEBOOK_USAGE, -1);
		end
	end
end

function RecipeBook_ToggleOption(option, value)
	if value == "on" then RecipeBookOptions_SetOption(option, "On");
	elseif value == "off" then RecipeBookOptions_SetOption(option, "Off");
	else RecipeBook_Print(RECIPEBOOK_INVALID_ONOFF, 1);
	end
	RecipeBook_PrintStatus(option);
end

--== [ HOOKED FUNCTIONS ] ==--
--[ Vanilla tooltip Updating functions ]--
function RecipeBook_ContainerFrameItemButton_OnEnter(button)
	if ( not button ) then button = this end;
 	RecipeBook_Old_ContainerFrameItemButton_OnEnter(button);
	RecipeBook_DoHookedFunction("GameTooltip", GetContainerItemLink(button:GetParent():GetID(),button:GetID()));
end
function RecipeBook_AuctionFrameItem_OnEnter(type, index)
	RecipeBook_Old_AuctionFrameItem_OnEnter(type, index);
	RecipeBook_DoHookedFunction("GameTooltip", GetAuctionItemLink(type, index));
end

--[ AuctionFrameBrowse_Update : Colors Auction items. ]--
function RecipeBook_AuctionFrameBrowse_Update()
	if RB_AFPEnabled then 
		RecipeBook_Old_afp_AuctionFrameBrowse_Update() 
		RecipeBook_Debug("RB afp update");
	else
		RecipeBook_Old_AuctionFrameBrowse_Update();
	end
	
	if IsAddOnLoaded("Auctioneer") and Auctioneer.Scanning and Auctioneer.Scanning.IsScanningRequested == true then 
		return; -- Auctioneer is Scanning!
	end
	
	if not RecipeBookOptions_GetOption("ColorAuctions") then return end;
	
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame);
	local itemname, isrecipe, tradeskill, altsknow, altslearn, altshaveskill, isbanked, skillevel, specialty, recipename, canUse;
	local i;
	local index, name;

	for i=1, NUM_BROWSE_TO_DISPLAY, 1 do
--		name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  GetAuctionItemInfo("list", offset + i);
--		if RB_AFPEnabled and (afp_BrowseList ~= nil) and (afp_BrowseList[i] ~= nil) then offset = afp_BrowseList[i] end;
		if RB_AFPEnabled and next(afp_BrowseList) ~= nil and (afp_BrowseList[i] ~= nil) then offset = afp_BrowseList[i] end;
		itemname, isrecipe, tradeskill = RecipeBook_ParseItemLink(GetAuctionItemLink("list", offset + i));
		-- Item exists.  Item is a recipe.  Item belongs to a tradeskill (not book!)
		if (itemname ~= nil) and (isrecipe == RECIPEBOOK_RECIPEWORD) and string.find(RECIPEBOOK_RECIPENAMES, tradeskill) then
			_, _, _, _, canUse =  GetAuctionItemInfo("list", offset + i);
			RecipeBookTooltip:SetAuctionItem("list", offset + i);
			skillevel, specialty = RecipeBook_GetRecipeData("RecipeBookTooltip");
			_,_,recipename = string.find(itemname, "%w+%: (.+)");
 			RecipeBook_Debug(recipename);
			if(skillevel ~= nil) then 
				altsknow, altslearn, altshaveskill, isbanked = RecipeBook_MatchRecipeData(recipename,itemname, tradeskill, skillevel, specialty, true);
				iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
				iconTexture:SetVertexColor(RecipeBook_ColorIcon(iconTexture, altsknow, altslearn, altshaveskill, isbanked, canUse));
			end
		end;
	end
end

--[ ColorIcon : Sets the color of an icon according to who knows the recipe ]--
function RecipeBook_ColorIcon(icon, altsknow, altslearn, altshaveskill, isbanked, canUse)
	local r,g,b;
	if altslearn ~= "" then
		if not string.find(altslearn, Player) then 
			r, g, b = unpack(RecipeBookOptions_GetOption("AuctionColors", "AltsCanLearn"))
		else 
			r,g,b = 1,1,1;-- The current player can currently learn this recipe.  Maintain course.
		end
	elseif altshaveskill ~= "" then 
		if string.find(altshaveskill, Player) and not string.find(altshaveskill, ",") then
			r, g, b = unpack(RecipeBookOptions_GetOption("AuctionColors", "YouWillLearn"))
		else
			r, g, b = unpack(RecipeBookOptions_GetOption("AuctionColors", "AltsWillLearn"))
		end
	elseif altsknow ~= "" then
		r, g, b = unpack(RecipeBookOptions_GetOption("AuctionColors", "AllAltsKnow"))
	else
		RecipeBook_Debug("No tracked alts have skill");
		r, g, b = unpack(RecipeBookOptions_GetOption("AuctionColors", "NoAltsCanLearn"))
	end
-- 	if (canUse) and (not RecipeBookOptions_GetOption("ShowSelf")) then
-- 		r, g, b = icon:GetVertexColor();
-- 		RecipeBook_Debug("Defaulting to use color");
-- 	end
	if RecipeBookOptions_GetOption("BlackBanked") and isbanked ~= "" then 
		r, g, b = unpack(RecipeBookOptions_GetOption("AuctionColors", "Banked"))
	end
	return r,g,b;
end

--[ MerchantFrame_UpdateMerchantInfo : For pretty merchanting ]--
function RecipeBook_MerchantFrame_UpdateMerchantInfo()
	RecipeBook_Debug("Entering Merchant Update");
	RecipeBook_Old_MerchantFrame_UpdateMerchantInfo();
	if not RecipeBookOptions_GetOption("ColorAuctions") then return end;
	local total = GetMerchantNumItems();
	local itemname, isrecipe, tradeskill, altsknow, altslearn, altshaveskill, isbanked, skillevel, specialty, recipename;
	local name, item, i;
	for i=1, MERCHANT_ITEMS_PER_PAGE, 1 do
		local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i);
		RecipeBook_Debug("Index: "..index);
		RecipeBook_Debug("i: "..i);
		if (index <= total) then
			itemname, isrecipe, tradeskill = RecipeBook_ParseItemLink(GetMerchantItemLink(index));
		if (itemname ~= nil) and (isrecipe == RECIPEBOOK_RECIPEWORD) and string.find(RECIPEBOOK_RECIPENAMES, tradeskill) then
				_, _, _, _, _, isUsable = GetMerchantItemInfo(index);
				_,_,recipename = string.find(itemname, "%w+%: (.+)");
				RecipeBook_Debug(recipename);
				RecipeBookTooltip:SetMerchantItem(index);
				skillevel, specialty = RecipeBook_GetRecipeData("RecipeBookTooltip");
				if(skillevel ~= nil) then 
					local itemButton = getglobal("MerchantItem"..i.."ItemButton");
					altsknow, altslearn, altshaveskill, isbanked = RecipeBook_MatchRecipeData(recipename,itemname, tradeskill, skillevel, specialty, true);
					r,g,b = RecipeBook_ColorIcon(itemButton:GetNormalTexture(), altsknow, altslearn, altshaveskill, isbanked, isUsable)
					SetItemButtonTextureVertexColor(itemButton, r,g,b);
					SetItemButtonNormalTextureVertexColor(itemButton, r,g,b);
				end
			end
		end
	end
end

--[ SetItemRef : For Chat links ]--
function RecipeBook_SetItemRef(link, name, button)
	RecipeBook_Old_SetItemRef(link, name, button);
	RB_TooltipLines = false;
	RecipeBook_DoHookedFunction("ItemRefTooltip", link);
end
--[ GameTooltip:SetInventoryItem() ]--
function RecipeBook_GameTooltip_SetInventoryItem(this, unit, slot) --Specifically a bank hack.
	local hasItem, hasCooldown, repairCost = RecipeBook_Old_GameTooltip_SetInventoryItem(this, unit, slot);
	RecipeBook_DoHookedFunction("GameTooltip", GetInventoryItemLink(unit,slot)); 
	return hasItem, hasCooldown, repairCost;
end
--[ GameTooltip:SetLootItem() ]---
function RecipeBook_GameTooltip_SetLootItem(this, slot)
	RecipeBook_Old_GameTooltip_SetLootItem(this, slot)
	RecipeBook_DoHookedFunction("GameTooltip", GetLootSlotLink(slot));
end
--[ GameTooltip:SetMerchantItem() ]--
function RecipeBook_GameTooltip_SetMerchantItem(unit, slot) --Vendors
	RecipeBook_Old_GameTooltip_SetMerchantItem(unit, slot);
	RecipeBook_DoHookedFunction("GameTooltip", GetMerchantItemLink(slot)); 
end
--[ GameTooltip:OnHide() ]--
function RecipeBook_GameTooltip_OnHide()
	RB_TooltipLines = false;
	RB_ChatFrameUpdated = false;
	RecipeBook_Old_GameTooltip_OnHide();
end
--[ Bank : CloseBankFrame(); ]--
function RecipeBook_CloseBankFrame()
	if RB_BankFrameOpen then 
		RecipeBook_DoAutoBank();
	end
	RecipeBook_Old_CloseBankFrame();
	RB_BankFrameOpen = false;
end

--==[ My Inventory ]==--
--[ MyInventory FrameItemButton OnEnter Hook ]--
function RecipeBook_MIFrameItemButton_OnEnter() --MyInventory doesn't call the original OnEnter function
	RecipeBook_Old_MIFrameItemButton_OnEnter();
	if (not RB_TooltipLines) then 
		RecipeBook_DoHookedFunction("GameTooltip", GetContainerItemLink(this:GetParent():GetID(),this:GetID()));
	end
end
--[ MyInventory FrameItemButton OnUpdate Hook ]--
function RecipeBook_MIFrameItemButton_OnUpdate(elapsed) --MyInventory doesn't call the original OnUpdate function
	RecipeBook_Old_MIFrameItemButton_OnUpdate(elapsed);
	RecipeBook_DoHookedFunction("GameTooltip", GetContainerItemLink(this:GetParent():GetID(),this:GetID()));
end
--==[ All-In-One-Inventory ]==--
--[ AIOI Modify Tooltip Hook ]--
function RecipeBook_AIOI_ModifyItemTooltip(bag, slot, tooltipName)
	RecipeBook_Old_AIOI_ModifyItemTooltip(bag, slot, tooltipName);
	RecipeBook_DoHookedFunction("GameTooltip", GetContainerItemLink(bag,slot));
end
--==[ BankStatement ]==--
--[ BS ItemButton OnEnter Hook ]-- 
function RecipeBook_BS_ItemButton_OnEnter()
	RecipeBook_Old_BS_ItemButton_OnEnter();
	local player = BankStatementGetBSIIndex();
	if (this.isBag) then
		if (BankStatementItems[player]["bag"..this:GetID()]) then
			RecipeBook_DoHookedFunction("GameTooltip", BankStatementItems[player]["bag"..this:GetID()].link);
		end
	else
		if (BankStatementItems[player]["bank"] and BankStatementItems[player]["bank"][this:GetID()]) then
			RecipeBook_DoHookedFunction("GameTooltip", BankStatementItems[player]["bank"][this:GetID()].link);
		end
	end
end
--[ BS Container ItemButton OnEnter Hook ]--
function RecipeBook_BS_ContainerFrameItemButton_OnEnter()
	RecipeBook_Old_BS_ContainerFrameItemButton_OnEnter();
	local player = BankStatementGetBSIIndex();
	local bag = BankStatementItems[player]["bag"..this:GetParent():GetID()];
	if (bag ~= nil) and (bag[this:GetID()] and bag[this:GetID()].link) then
		RecipeBook_DoHookedFunction("GameTooltip", BankStatementItems[player]["bag"..this:GetParent():GetID()][this:GetID()].link);
	end
end
--==[ BankItems ]==--
--[BI Button OnEnter Hook ]--
function RecipeBook_BI_Button_OnEnter()
	RecipeBook_Old_BI_Button_OnEnter();
	RecipeBook_DoHookedFunction();
end
--[ BI BagItem OnEnter Hook ]--
function RecipeBook_BI_BagItem_OnEnter()
	RecipeBook_Old_BI_BagItem_OnEnter();
	RecipeBook_DoHookedFunction();
end

--[ EngInventory ]--
function RecipeBook_EngInventory_ItemButton_OnEnter()
	RecipeBook_Old_EngInventory_ItemButton_OnEnter();
	RecipeBook_DoHookedFunction();
end
--[ EngBank ]--
function RecipeBook_EngBank_ItemButton_OnEnter()
	RecipeBook_Old_EngBank_ItemButton_OnEnter();
	RecipeBook_DoHookedFunction();
end

--== [ DO THE HOOKED FUNCTION ] ==--
-- DoHookedFunction(tooltip, link): tooltip defaults to GameTooltip if not passed (or nil); link should be is EITHER the complete hyperlink for the item (|Hitem:6948:0:0:0|h[Hearthstone]|H) or the item link itself (item:6948:0:0:0).
function RecipeBook_DoHookedFunction(tooltip, link)
	local itemname,recipename,isrecipe,tradeskill;

	if not RecipeBookOptions_GetOption("Status") then return end;
	if not tooltip then 
		tooltip = "GameTooltip";
	end
	
	if (not link) then --If you're hooking into RecipeBook and still using the old functions, this should preserve functionality at the expense of efficiency.
		if not getglobal(tooltip):IsVisible() then return end;
		RecipeBook_Debug("Using RecipeBook's OLD hooking functions.");
		itemname,recipename, isrecipe,tradeskill = RecipeBook_ParseTooltipText(tooltip);
		if (not itemname or not tradeskill) then return end;
	else
		itemname,isrecipe,tradeskill = RecipeBook_ParseItemLink(link);
	end

	if isrecipe ~= RECIPEBOOK_RECIPEWORD then return;
	elseif not string.find(RECIPEBOOK_RECIPENAMES, tradeskill) then return; --"Book" being a notable example.
	end;
	
	if (RB_LastWhat[1] == itemname) and (not RB_LastWhat[3]) then 
		return; --Same name as last time, no need to mod tooltip.
	elseif (RB_LastWhat[1] ~= itemname) then --Different item, clear the modded data.
		RB_LastWhat = {RB_LastWhat[1], RB_LastWhat[2], false, {}};
	end
	
	if tooltip == "GameTooltip" then 
		if not GameTooltip:IsVisible() then
			RB_LastWhat = {"RecipeBook: Blank Tooltip", nil, false, {}}
			return;
		end
	end
	
	if itemname ~= nil then 
		local altsknow, altslearn, altshaveskill, isbanked, skillevel, specialty;
		_,_,recipename = string.find(itemname, "%w+%: (.+)");
		if {RB_LastWhat[1] == recipename} and RB_LastWhat[3] and RB_LastWhat[4] and {next(RB_LastWhat[4]) ~= nil} then
			altsknow = RB_LastWhat[4][1];
			altslearn = RB_LastWhat[4][2];
			altshaveskill = RB_LastWhat[4][3];
			isbanked = RB_LastWhat[4][4];
		else
			RB_LastWhat[3] = false;
			RB_LastWhat[4] = {};
			skillevel, specialty = RecipeBook_GetRecipeData(tooltip);  --Let's start at the very beginning.
			if(skillevel ~= nil) then 
				altsknow, altslearn, altshaveskill, isbanked = RecipeBook_MatchRecipeData(recipename,itemname, tradeskill, skillevel, specialty);
			else 
				RB_LastWhat = {recipename, false, {}};
				return;
			end
		end
		
		if recipename ~= nil then
			if RecipeBookOptions_GetOption("ChatFrame") and (RB_LastWhat[1] ~= recipename) then
				RB_LastWhat = {recipename, tradeskill, false, {altsknow, altslearn, altshaveskill, isbanked}};
				RecipeBook_OutputRecipeChatFrame(itemname, altsknow, altslearn, altshaveskill, isbanked);
			end
			if RecipeBookOptions_GetOption("Tooltip") then
				RB_LastWhat = {recipename, tradeskill, false, {altsknow, altslearn, altshaveskill, isbanked}};
				if not RB_TooltipLines then
					RecipeBook_OutputRecipeTooltip(tooltip, altsknow, altslearn, altshaveskill, isbanked); --This will note if the tooltip was modified.
				elseif (type(tooltip) == "string") then 
					if (getglobal(tooltip):NumLines() < RB_TooltipLines) then 
						RecipeBook_OutputRecipeTooltip(tooltip, altsknow, altslearn, altshaveskill, isbanked); --This will note if the tooltip was modified.
					end
				elseif (tooltip ~= nil and tooltip:NumLines() < RB_TooltipLines) then
					RecipeBook_OutputRecipeTooltip(tooltip, altsknow, altslearn, altshaveskill, isbanked); --This will note if the tooltip was modified.
				end
			end
		else
			RB_LastWhat = {recipename, nil, false, {}}; 
		end
	end
end

function RecipeBook_ParseTooltipText(tooltip)
	local itemname,recipename,isrecipe,tradeskill;
	local text = getglobal(tooltip.."TextLeft1"):GetText();
	if text == nil then return false end; --No top line text?
			
	if (RB_LastWhat[1] == text) and (not RB_LastWhat[3]) then 
		return false; --Same name as last time, no need to mod tooltip.
	elseif (RB_LastWhat[1] ~= text) then --Different item, clear the modded data.
		RB_LastWhat = {RB_LastWhat[1], RB_LastWhat[2], false, {}}
	end
	
	_,_,isrecipe,recipename = string.find(text, "(%w+)%: (.+)");
	itemname = text;
	
	if isrecipe and string.find(RECIPEBOOK_RECIPEPREFIXES, isrecipe) then -- It's a recipe!
		isrecipe = RECIPEBOOK_RECIPEWORD;
		-- Take tooltip line 2, look for "Requires X (#)" and return X and # if found.  Otherwise this will return "text" in toto, meaning it's a malformed tradeskill requirement.
		text = getglobal(tooltip.."TextLeft2"):GetText();
		if(text ~= nil) then 
			string.gsub(text, RECIPEBOOK_REGEX_REQUIRES, function(a,b) tradeskill = a; end); 
		else 
			isrecipe = "False";
		end
		if (tradeskill == text  or tradeskill == nil) then 
			isrecipe = "False";
		end --No tradeskill requirement, no go.
	else
		isrecipe = "False";
	end
	return itemname,recipename,isrecipe,tradeskill;
end


--== [ HANDLING TRADESKILL UPDATES ] ==--
--[ UpdateSkillInfo : Semi-intelligently decides whether to rescan the tradeskill list or not. ]--
function RecipeBook_UpdateSkillInfo(skilltype)
	if not RecipeBookOptions_GetOption("TrackSelf") then return end;
	if RecipeBook_NumCurrTradeSkills <1 then return end;
	if skilltype == "CRAFT_UPDATE" then
		if RB_SEAceEnabled then 
			total = SortEnchant.Hooks.GetNumCrafts.orig();
		else
			total = GetNumCrafts();
		end
		total = GetNumCrafts();
	else
		total = GetNumTradeSkills();
	end
	if total > RecipeBook_NumCurrTradeSkills then 
		RecipeBook_ShowSkillInfo(string.gsub(skilltype, "UPDATE", "SHOW")) 
	end;
end

--[ ShowSkillInfo : When the Tradeskill/Craft window opens, this updates the known recipes list for that player. ]--
function RecipeBook_ShowSkillInfo(skilltype)
	if (not Realm) or (not Faction) or (not Player) then return end;  --not yet initialized completely.
	if not RecipeBookOptions_GetOption("TrackSelf") then return end;
	local skill,skillrank,total;
	if skilltype == "CRAFT_SHOW" then
		if RB_SEAceEnabled and SortEnchant.Hooks.GetNumCrafts ~= nil then 
			total = SortEnchant.Hooks.GetNumCrafts.orig();
		else
			total = GetNumCrafts();
		end
		skill, skillrank, _ = GetCraftDisplaySkillLine();
	else
		total = GetNumTradeSkills();
		skill, skillrank, _ = GetTradeSkillLine();
	end
	
	if skill == nil then 
		return false;
	end --Apparently hunter skills trigger the Tradeskill/Craft window too.
	if (RecipeBookData[Realm][Faction]["Personal"][Player][skill] ~= nil) and ((RecipeBookData[Realm][Faction]["Personal"][Player][skill][1] ~= nil) or (RecipeBookData[Realm][Faction]["Personal"][Player][skill]["Converted"] ~= nil)) then 
		local spec, subspec;
		spec = RecipeBookData[Realm][Faction]["Personal"][Player][skill].Specialty;
		subspec = RecipeBookData[Realm][Faction]["Personal"][Player][skill].SubSpecialty;
		RecipeBookData[Realm][Faction]["Personal"][Player][skill] = {};
		RecipeBookData[Realm][Faction]["Personal"][Player][skill].Specialty = spec;
		RecipeBookData[Realm][Faction]["Personal"][Player][skill].SubSpecialty = subspec;
	elseif(RecipeBookData[Realm][Faction]["Personal"][Player][skill] == nil) then
		RecipeBookData[Realm][Faction]["Personal"][Player][skill] = {};
	end
		
	RecipeBookData[Realm][Faction]["Personal"][Player][skill].Rank = tonumber(skillrank);
	RecipeBook_Debug("Rank: "..skillrank);

	local name,skillname,crafttype,itemid;
	for index = 1, total, 1 do
		if(skilltype == "CRAFT_SHOW") then 
			if RB_SEAceEnabled and SortEnchant.Hooks.GetCraftInfo ~= nil then 
				skillname, _, crafttype, _ = SortEnchant.Hooks.GetCraftInfo.orig(index);
				RecipeBook_Debug("Skillname: "..skillname);
			else
				skillname, _, crafttype, _ = GetCraftInfo(index);
			end
		else 
			skillname, crafttype, _, _ = GetTradeSkillInfo(index);
		end
		
		if (crafttype ~= "header") then
			if index ~= nil then 
				if RB_SEAceEnabled and skilltype == "CRAFT_SHOW" and SortEnchant.Hooks.GetCraftItemLink ~= nil then
					link = SortEnchant.Hooks.GetCraftItemLink.orig(index);
					RecipeBook_Debug("Link: "..link);
				else
					link = (skilltype == "CRAFT_SHOW") and GetCraftItemLink(index) or GetTradeSkillItemLink(index); --"|cffffffff|Hitem:5116:0:0:0|h[Long Tail Feather]|h|r",
				end
				if link ~= nil then 
					if skill == RECIPEBOOK_ALCHEMY then
						if string.find(skillname, ":") then 
							name = string.gsub(skillname, ":", "");
						else 
						_,_,name = string.find(link,".*|h%[([%w%s%päëïöüß]*)%]|h.*");
						end;
					else
						_,_,name = string.find(link,".*|h%[([%w%s%päëïöüß]*)%]|h.*");
					end

					if ( GetLocale() == "deDE" ) then
						if name == nil then name = skillname end;
						if skill == RECIPEBOOK_ENCHANTING then 
							name = string.gsub(name,RECIPEBOOK_ENCHANTING_FILLER,"");
						end
					end
					
					if name ~= nil then 
						if skill == RECIPEBOOK_ENGINEERING and string.find(name, "Ez") then -- Darn EZ-Thro/Ez-Thro...
							if RecipeBookData[Realm][Faction]["Personal"][Player][skill][name] ~= nil then
								RecipeBookData[Realm][Faction]["Personal"][Player][skill][name] = nil; -- Remove the old one...
							end
							if RecipeBookMasterList["Tradeskills"][skill][name] ~= nil then
								RecipeBookMasterList["Tradeskills"][skill][name] = nil; -- And its link...
							end
							name = skillname;
						end
						
						if RECIPEBOOK_EXCEPTIONS[name] ~= nil then 
							if RecipeBookData[Realm][Faction]["Personal"][Player][skill][name] ~= nil then
								RecipeBookData[Realm][Faction]["Personal"][Player][skill][name] = nil; -- Remove the old one...
							end 
							if RecipeBookMasterList["Tradeskills"][skill][name] ~= nil then
								RecipeBookMasterList["Tradeskills"][skill][name] = nil; -- And its link...
							end
							name = RECIPEBOOK_EXCEPTIONS[name];
						end;
					end
					
					if(name ~= nil) then
						RecipeBook_Debug("("..index..") Name: "..name);
						RecipeBook_MaybeAddTradeSkillItem(skill,skilltype,name,link,index);
						RecipeBookData[Realm][Faction]["Personal"][Player][skill][name] = crafttype;
						RecipeBook_Debug("Inserted "..crafttype.." for "..name);
					else
						if RecipeBookMasterList["Debug"] == nil then RecipeBookMasterList["Debug"] = {} end;
						table.insert(RecipeBookMasterList["Debug"], "Broken Name extraction: "..link);
					end
				end
			end
		end
	end
	RecipeBook_NumCurrTradeSkills = total;
	RecipeBook_Debug("Indexed and stored "..total.." items for tradeskill "..skill..".");
end

--[ MaybeAddTradeSkillItem(skill,name,itemid,index) : Make sure the item is in the database - if not, then add it in. ]--
function RecipeBook_MaybeAddTradeSkillItem(skill,skilltype,name,itemid,index)
	if skill == nil or name == nil then return end;
	if RecipeBookMasterList["Tradeskills"][skill] == nil then 
		RecipeBookMasterList["Tradeskills"][skill] = {};
	end
	if RecipeBookMasterList["Links"] == nil then
		RecipeBookMasterList["Links"] = {};
	end
-- 	if RecipeBookMasterList["Tradeskills"][skill][name] ~= nil then -- Eventually check for changes and fix if needed.
-- 		if RecipeBookMasterList["Tradeskills"][skill][name]["Materials"] ~= {} then return end;
-- 	end;
	local i,num,link, id;
	RecipeBookMasterList["Tradeskills"][skill][name] = {};
	_,_,id = string.find(itemid, ".*|H([%wäëïöüß]*:[%d%p]*)|h.*");
	if id == nil then return nil end;
	RecipeBookMasterList["Links"][id] = itemid;
	RecipeBookMasterList["Tradeskills"][skill][name]["ID"] = id;
	RecipeBookMasterList["Tradeskills"][skill][name]["Materials"] = {};
	if skilltype == "CRAFT_SHOW" then
		local length = 0;
		if RB_SEAceEnabled then length = SortEnchant.Hooks.GetCraftNumReagents.orig(index);
		else length = GetCraftNumReagents(index);
		end
		for i=1,length,1 do 
			if RB_SEAceEnabled then
				_,_,num,_ = SortEnchant.Hooks.GetCraftReagentInfo.orig(index,i); 
				link = SortEnchant.Hooks.GetCraftReagentItemLink.orig(index,i);
			else
				_,_,num,_ = GetCraftReagentInfo(index,i); 
				link = GetCraftReagentItemLink(index,i);
			end
			if link ~= nil then 
				_,_,id = string.find(link, ".*|H([%wäëïöüß]*:[%d%p]*)|h.*");
				RecipeBookMasterList["Links"][id] = link;
				RecipeBookMasterList["Tradeskills"][skill][name]["Materials"][id] = num;
			end;
		end
	else
		for i=1,GetTradeSkillNumReagents(index),1 do 
			_,_,num,_ = GetTradeSkillReagentInfo(index,i); 
			link = GetTradeSkillReagentItemLink(index,i);
			if link ~= nil then 
				_,_,id = string.find(link, ".*|H([%wäëïöüß]*:[%d%p]*)|h.*");
				RecipeBookMasterList["Links"][id] = link;
				RecipeBookMasterList["Tradeskills"][skill][name]["Materials"][id] = num;
			end;
		end
	end
end

--[ ParseSkillupMessage : When you get a skillup, update the tradeskill rank only. ]--
function RecipeBook_ParseSkillupMessage(text)
	local skill, rank;
	gsub(text, RECIPEBOOK_CHAT_SKILLUP, function(a,b) skill = a; rank = b; end);
	if(RecipeBookData[Realm][Faction]["Personal"][Player][skill] ~= nil) then 
		rank = tonumber(rank);
		(RecipeBookData[Realm][Faction]["Personal"][Player][skill]).Rank = rank;
		-- Achieve a rank where recipes are banked?
		if(RecipeBookOptions_GetOption("Banked")) then
			if RecipeBookMasterList["BankData"][skill] ~= nil and RecipeBookMasterList["BankData"][skill][rank] ~= nil then
				for k, item in pairs(RecipeBookMasterList["BankData"][skill][rank]) do 
					if RecipeBookData[Realm][Faction]["Banked"][item] ~= nil then
						local isbanked = {};
						for k,v in pairs(RecipeBookData[Realm][Faction]["Banked"][item]) do
							table.insert(isbanked, k..(v == "Manual" and "  (manual)" or (" ("..string.lower(v)..")")));
						end
						if next(isbanked) ~= nil then
							RecipeBook_Print(format(RECIPEBOOK_INFO_CANLEARNONSKILLUP, item, table.concat(isbanked, ", ")), 0)
						end
					end
				end
			end
		end
	end
end

--[ ParseSystemMessage : Parses out learned recipe/spell names. Currently just eating CPU cycles while I figure out what to do with those names. ]--
function RecipeBook_ParseSystemMessage(text)
	who = string.gsub(text, RECIPEBOOK_REGEX_NOTONLINE, "%1");
	if who ~= text then --cancel.
		if string.find("Send Queue", RecipeBookMessenger_GetSessionType()) then StaticPopup_Hide("RECIPEBOOK_AWAITING_SEND"); 
		else StaticPopup_Hide("RECIPEBOOK_REQUESTING_SEND");
		end
	else
		what = string.gsub(text, RECIPEBOOK_REGEX_UNLEARNSKILL, "%1");
		if what ~= text then
			RecipeBook_ResetData(string.lower(what));
		elseif RB_Debug then
			local recipe, regex;
			if(string.find(text, RECIPEBOOK_CHAT_LEARN_RECIPE)) then
				regex = RECIPEBOOK_CHAT_LEARN_RECIPE.."([%w%s]*)%.";
			elseif(string.find(text, RECIPEBOOK_CHAT_LEARN_SPELL)) then
				regex = RECIPEBOOK_CHAT_LEARN_SPELL.."(%w)*%.";
			else
				return nil;
			end
			if(regex) then 
				gsub(text, regex, function(a) recipe = a end);
				return recipe;
			else
				return nil;
			end
		end
	end
end
--[ SpecialtyScan : /rb specials will scan your skills for tradeskill specializations. ]--
function RecipeBook_SpecialtyScan()
	local SpecString = "None";
	local SpecList = {};
	local newSpec = false;
	
	local name, texture, offset, numSpells = GetSpellTabInfo(1);
	for i = 1, numSpells, 1 do 
		local spellName, temp = GetSpellName(i, BOOKTYPE_SPELL);
		if(spellName) then
			local spellfind = "|"..spellName.." |";
			if string.find(RECIPEBOOK_BLACKSMITHING_SPECIALS, spellfind, 1, true) then 
				if(RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING] == nil) then 
					RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING] = {};
				end
				if(string.find(spellName, RECIPEBOOK_MASTER)) then 
					if RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING].Specialty ~= RECIPEBOOK_WEAPONSMITH then 
						RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING].Specialty = RECIPEBOOK_WEAPONSMITH;
						if RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING].SubSpecialty ~= spellName then 
							RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING].SubSpecialty = spellName;
						end
						table.insert(SpecList, RECIPEBOOK_WEAPONSMITH.." ("..spellName..")");
					end
				elseif RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING].Specialty ~= spellName then
					RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_BLACKSMITHING].Specialty = spellName;
					table.insert(SpecList, spellName);
				end
			end
			if string.find(RECIPEBOOK_ENGINEERING_SPECIALS, spellfind, 1, true) then 
				if(RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_ENGINEERING] == nil) then 
					RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_ENGINEERING] = {};
				end
				if RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_ENGINEERING].Specialty ~= spellName then 
					RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_ENGINEERING].Specialty = spellName;
					table.insert(SpecList, spellName);
				end
			end
			if string.find(RECIPEBOOK_LEATHERWORKING_SPECIALS, spellfind, 1, true) then 
				if(RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_LEATHERWORKING] == nil) then 
					RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_LEATHERWORKING] = {};
				end
				if RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_LEATHERWORKING].Specialty ~= spellName then
					RecipeBookData[Realm][Faction]["Personal"][Player][RECIPEBOOK_LEATHERWORKING].Specialty = spellName;
					table.insert(SpecList, spellName);
				end
			end
		end
	end
	if table.getn(SpecList) > 0 then SpecString = table.concat(SpecList, ", ") end;
	return SpecString;
end


--== [ CHECK THE TOOLTIP DATA ] ==--
function RecipeBook_ParseItemLink(link)
	if not link then return end;
	local itemid;
	if string.find(link, "|H") then
		_,_,itemid = string.find(link,".*|H(item:%d+:%d+:%d+:%d+)|h.*");
	else
		itemid = link;
	end;
	recipename,_,_,_,isrecipe,tradeskill = GetItemInfo(itemid);	
	return recipename,isrecipe,tradeskill,itemid;
end

function RecipeBook_GetRecipeData(tooltip)
	local skillevel, specialty, text;
	if type(tooltip) == "table" then
		tooltip = tooltip:GetName();
	end
	local i = 2; --for tooltip iterations.
	-- Take tooltip line 2, look for "Requires X (#)" and return X and # if found.  Otherwise this will return "text" in toto, meaning it's a malformed tradeskill requirement.
	text = getglobal(tooltip.."TextLeft"..i):GetText();
	length = getglobal(tooltip):NumLines();
	while (text == nil or text == ITEM_SOULBOUND or text == ITEM_BIND_ON_EQUIP or text == ITEM_BIND_ON_PICKUP)  and (i < length) do 
		i = i + 1; --try the next line.			
		text = getglobal(tooltip.."TextLeft"..i):GetText() 
	end;
	if text ~= nil then
		_,_,_,skillevel = string.find(text, RECIPEBOOK_REGEX_REQUIRES);
	else
		return nil;
	end

	-- Take tooltip line 3 (or 4), look for "Requires XY", where X is not "Level" and Y doesn't have to exist (i.e. "Requires Armorsmithing" only has X), and return XY.
	text = getglobal(tooltip.."TextLeft"..i+1):GetText();
	if(text ~= nil) then 
		specialty = string.gsub(text, RECIPEBOOK_REGEX_SPECIALTY, function(b,c) if not (b == LEVEL) then return b..c else return false end end)
		if specialty == text then specialty = false end;
	else 
		specialty = false;
	end
	if text == specialty then 
		specialty =  false;
	end --No specialty requirement, that's cool.
	-- Put it all together, and what do you got?
	if skillevel == nil then return nil end; 
	return tonumber(skillevel), specialty, usable;
end


--== [ CHECK THE ALT DATA ] ==--
-- [ MatchRecipeData(recipename, tradeskill, rank, specialty) : Given tradeskill info, calls FindInFaction on each appropriate faction, then colour-codes appropriately. ] --
function RecipeBook_MatchRecipeData(recipename, itemname, tradeskill, rank, specialty, coloring)
	local knows, canlearn, hastradeskill, isbanked;
	if coloring ~= true then coloring = false end;

	knows = {};
	canlearn = {};
	hastradeskill = {};
	isbanked = {};
		
	if ((RecipeBookOptions_GetOption("SameFaction")) and (RecipeBookData[Realm][Faction] ~= nil)) then 
		knows, canlearn, hastradeskill = RecipeBook_FindInFaction(Faction, "Personal", recipename, tradeskill, rank, specialty, knows, canlearn, hastradeskill, coloring);
	end
	if ((RecipeBookOptions_GetOption("OtherFaction")) and (RecipeBookData[Realm][OtherFaction] ~= nil)) then 
		knows, canlearn, hastradeskill = RecipeBook_FindInFaction(OtherFaction, "Personal", recipename, tradeskill, rank, specialty, knows, canlearn, hastradeskill, coloring);
	end
	if(RecipeBookOptions_GetOption("FriendShow")) then
		if ((RecipeBookOptions_GetOption("FriendSameFaction")) and (RecipeBookData[Realm][Faction] ~= nil)) then 
			knows, canlearn, hastradeskill = RecipeBook_FindInFaction(Faction, "Shared", recipename, tradeskill, rank, specialty, knows, canlearn, hastradeskill, coloring);
		end
		if ((RecipeBookOptions_GetOption("FriendOtherFaction")) and (RecipeBookData[Realm][OtherFaction] ~= nil)) then 
			knows, canlearn, hastradeskill = RecipeBook_FindInFaction(OtherFaction, "Shared", recipename, tradeskill, rank, specialty, knows, canlearn, hastradeskill, coloring);
		end
	end
	if(RecipeBookOptions_GetOption("Banked")) then
		if RecipeBookData[Realm][Faction]["Banked"][itemname] ~= nil then
			for k,v in pairs(RecipeBookData[Realm][Faction]["Banked"][itemname]) do
				table.insert(isbanked, k..(v == "Manual" and "  (manual)" or ""));
			end
		end
	end
	return table.concat(knows, ", "), table.concat(canlearn, ", "), table.concat(hastradeskill, ", "), table.concat(isbanked, ", ");
end

-- [ FindInFaction(pass faction, recipename, tradeskill, rank, specialty) : Returns three lists of who knows, can learn, and has tradeskill for the passed faction. ] --
function RecipeBook_FindInFaction(lfaction, personal, recipename, tradeskill, rank, specialty, knows, canlearn, hastradeskill, coloring)
	local color;
	local doknown, docanlearn, dowilllearn;
	-- Personal data
	if(personal == "Personal") then 
		color = (lfaction == Faction) and RecipeBookOptions_GetOption("SameColor") or RecipeBookOptions_GetOption("OtherColor");
		doknown = RecipeBookOptions_GetOption("Known");
		docanlearn = RecipeBookOptions_GetOption("CanLearn");
		dowilllearn = RecipeBookOptions_GetOption("WillLearn");
	-- Shared data
	else
		color = (lfaction == Faction) and RecipeBookOptions_GetOption("FriendSameColor") or RecipeBookOptions_GetOption("FriendOtherColor");
		doknown = RecipeBookOptions_GetOption("FriendKnown");
		docanlearn = RecipeBookOptions_GetOption("FriendCanLearn");
		dowilllearn = RecipeBookOptions_GetOption("FriendWillLearn");
	end
	
	if(RecipeBookData[Realm] and RecipeBookData[Realm][lfaction] and RecipeBookData[Realm][lfaction][personal]) then 
		if rank == nil then 
			RecipeBook_Print("RecipeBook did not parse "..recipename.." correctly.  Please inform Ayradyss (dr.nykki@gmail.com).", 1);
			rank = 1;
		end
		-- iterate through all recipes in [faction] [personal|shared] and match them to 
		
		for who, skilltable in pairs(RecipeBookData[Realm][lfaction][personal]) do
			local valid = false;
			local prank, pspec, psubspec, pmatch;
			
			if who ~= Player or RecipeBookOptions_GetOption("ShowSelf") or coloring then
				valid = true; -- Valid target to match on.
			end
			
			if valid then			
				-- German locale
				if ( GetLocale() == "deDE" ) and tradeskill == RECIPEBOOK_ENCHANTING then
					recipename = string.gsub(recipename," Wille$"," Willen");
					recipename = string.gsub(recipename,RECIPEBOOK_ENCHANTING_FILLER,"");
				end
				-- If tradeskill exists AND recipe is listed then it's a match.
				if skilltable[tradeskill] ~= nil then
					if skilltable[tradeskill][recipename] ~= nil then 
						pmatch = true;
					else
						pmatch = false;
					end;
					prank = tonumber(skilltable[tradeskill].Rank);
					if prank == nil then 
						RecipeBook_Print("RecipeBook is missing a traadeskill rank for "..who.." in "..tradeskill..".  Please reload the data or have it sent again.", 1);
						prank = 1;
					end
					pspec = skilltable[tradeskill].Specialty;
					psubspec = skilltable[tradeskill].SubSpecialty;
				else 
					valid = false;
				end
			end
	
			-- If a tradeskill match is found:
			if valid then 
				local cwho = color..who;
				-- If it's known, insert into the known list.
				if pmatch then
					if doknown then table.insert(knows, cwho..RECIPEBOOK_END) end;
				-- If a specialty is required for this recipe, check to make sure specialty is known.  If it's not, then it's not learnable.
				elseif specialty then 
					if (pspec and pspec == specialty) or (psubspec and psubspec == specialty) then 
						if ((prank >= rank) and docanlearn) then table.insert(canlearn, cwho..RECIPEBOOK_END); 
						elseif dowilllearn then table.insert(hastradeskill, cwho..color.." ("..prank..")"..RECIPEBOOK_END);
						end
					end
				-- No specialty required; matches already listed, just checking to see if it's learnable now.
				else
					if (prank >= rank) then 
						if docanlearn then table.insert(canlearn, cwho..RECIPEBOOK_END) end;
					elseif dowilllearn then 
						table.insert(hastradeskill, cwho..color.." ("..prank..")"..RECIPEBOOK_END);
					end
				end
			end
		end
	end
	return knows, canlearn, hastradeskill;
end

--== [ TRADESKILL LISTING ] ==--
--[ SkillDisplay(who, what) : Sets up all the various skill display options ]--
function RecipeBook_SkillDisplay(who, what)
	who = string.gsub(string.lower(who), "%l", string.upper, 1);
	what = string.gsub(string.lower(what), "(%l)([%w%p]*)", function(a,b)return string.upper(a)..string.lower(b)end);
	if who == "All" then --/rb skill all <tradeskill>: Shows all alts of yours (not shared) who know a tradeskill, and their current skill.
		if what == "All" then
			for k,v in pairs(RecipeBookData[Realm][Faction]["Personal"]) do 
				RecipeBook_SkillDisplay(k, "All"); 
			end
			if(RecipeBookData[Realm][(Faction=="Alliance" and "Horde" or "Alliance")] ~= nil) then
				for k,v in pairs(RecipeBookData[Realm][(Faction=="Alliance" and "Horde" or "Alliance")]["Personal"]) do
					RecipeBook_SkillDisplay(k, "All");
				end
			end
		else
			local matchedalts = {" ","*** Tradeskiller data for "..what.." ***",  "Your faction:", "--------------------"};
			local function matchtradeskill(alt,skillist)
				if skillist[what] ~= nil then
					local ttext = alt.." ("..(skillist[what]).Rank..")";
					if((skillist[what]).Specialty) then 
						ttext = ttext..", "..(skillist[what]).Specialty;
						if (skillist[what]).SubSpecialty then ttext = ttext.." ["..(skillist[what]).SubSpecialty.."]" end;
					end
					table.insert(matchedalts, ttext);
				end
			end
	
			local tlength = table.getn(matchedalts);
			for k, v in pairs(RecipeBookData[Realm][Faction]["Personal"]) do matchtradeskill(k, v) end;
			if table.getn(matchedalts) == tlength then table.insert(matchedalts, "No tradeskiller matches") end;
			if(RecipeBookData[Realm][(Faction=="Alliance" and "Horde" or "Alliance")] ~= nil) then
				table.insert(matchedalts, " ");
				table.insert(matchedalts, "Opposite faction:");
				table.insert(matchedalts, "--------------------");
				tlength = table.getn(matchedalts);
				for k, v in pairs(RecipeBookData[Realm][(Faction=="Alliance" and "Horde" or "Alliance")]["Personal"]) do matchtradeskill(k, v) end;
				if table.getn(matchedalts) == tlength then table.insert(matchedalts, "No tradeskiller matches") end;
			end
			
			RecipeBook_Print(matchedalts, -1, RecipeBook_GetChatFrame());
			RecipeBook_Print("Tradeskiller information for "..what.." output to RecipeBook chat tab.", 0)
		end
		
	elseif what == "All" then --/rb skill <character> all : Shows all tradeskills and ranks for any given character (shared or personal).
		local matchedalts = {" "};
		local function matchtradeskill(skillist, skilltable)
			if (skillist ~= nil) then
				local ttext = skillist.." ("..skilltable.Rank..")";
				if(skilltable.Specialty) then 
					ttext = ttext..", "..skilltable.Specialty;
					if skilltable.SubSpecialty then ttext = ttext.." ["..skilltable.SubSpecialty.."]" end;
				end
			table.insert(matchedalts, ttext);
			end
		end
		
		if(RecipeBookData[Realm][Faction]["Personal"][who] ~= nil) then
			table.insert(matchedalts, "*** Tradeskill data for "..who.." ("..Faction..") ***");
			table.foreach(RecipeBookData[Realm][Faction]["Personal"][who], matchtradeskill);
		elseif(RecipeBookData[Realm][Faction]["Shared"][who] ~= nil) then
			table.insert(matchedalts, "*** Tradeskill data for friend "..who.." ("..Faction..") ***");
			table.foreach(RecipeBookData[Realm][Faction]["Shared"][who], matchtradeskill);
		elseif(RecipeBookData[Realm][OtherFaction] ~= nil) then
			if(RecipeBookData[Realm][OtherFaction]["Personal"][who] ~= nil) then
				table.insert(matchedalts, "*** Tradeskill data for "..who.." ("..(Faction=="Alliance" and "Horde" or "Alliance")..") ***");
				table.foreach(RecipeBookData[Realm][OtherFaction]["Personal"][who], matchtradeskill);
			elseif(RecipeBookData[Realm][OtherFaction]["Shared"][who] ~= nil) then
				table.insert(matchedalts, "*** Tradeskill data for friend "..who.." ("..OtherFaction..") ***");
				table.foreach(RecipeBookData[Realm][OtherFaction]["Shared"][who], matchtradeskill);
			end
		end
		if table.getn(matchedalts) < 2 then return RecipeBook_Print("Cannot match alt name or no tradeskills for that alt.", 1) end;
		
		RecipeBook_Print(matchedalts, -1, RecipeBook_GetChatFrame());
		RecipeBook_Print("Tradeskill information for "..who.." output to RecipeBook chat tab.", 0)
	else--/rb skill <alt> <tradeskill>
		local alt, tradeskill, recipelist = RecipeBook_GetAltData(who, what);
		if alt then
			RB_TradeskillData = {};
			if(RB_SkillFrame:IsVisible()) then
				RB_SkillFrame:Hide();
			end
			RB_SkillFrame:Show();
			local specialty = "No specialty";
			if(recipelist.Specialty) then 
				specialty = recipelist.Specialty;
				if recipelist.SubSpecialty ~= nil then specialty = specialty.." ["..recipelist.SubSpecialty.."]" end;
			end
			local rank = recipelist["Rank"] and recipelist["Rank"] or 0;
			RB_SkillFrameTitleText:SetText(alt);
			RB_SkillFrameTradeskillText:SetText(tradeskill.." ("..rank..")");
			RB_SkillFrameSpecialsText:SetText("Specialty: "..specialty);
			for name, difficulty in pairs(recipelist) do
				if not string.find("Rank Specialty SubSpecialty Converted", name) then
					table.insert(RB_TradeskillData, {name, difficulty});
				end;
			end
			table.sort(RB_TradeskillData, function(a,b) return a[1]<b[1] end);
			RecipeBook_SkillScrollBar_Update();
		end
	end
end

--[ GetAltData(who, what) : Finds the appropriate tradeskill table for a given alt and tradeskill. ]--
function RecipeBook_GetAltData(who, what)
	local function FindAltTradeskill(skilltable)
		if (skilltable ~= nil) then
			return skilltable;
		else
			RecipeBook_Print(RECIPEBOOK_NOTRADESKILLMATCH..'"'..what..'".', 1);
			return false;
		end
	end
	
	local skilltable = {};
	if RecipeBookData[Realm][Faction]["Personal"][who] then
		skilltable = FindAltTradeskill(RecipeBookData[Realm][Faction]["Personal"][who][what]);
		if skilltable then return (who.." ("..Faction..")"), what, skilltable;
		else return false;
		end
	elseif (RecipeBookData[Realm][OtherFaction]) and (RecipeBookData[Realm][OtherFaction]["Personal"]) and (RecipeBookData[Realm][OtherFaction]["Personal"][who]) then
		skilltable = FindAltTradeskill(RecipeBookData[Realm][OtherFaction]["Personal"][who][what]);
		if skilltable then return (who.." ("..OtherFaction..")"), what, skilltable;
		else return false;
		end
	elseif RecipeBookData[Realm][Faction]["Shared"][who] then
		skilltable = FindAltTradeskill(RecipeBookData[Realm][Faction]["Shared"][who][what]);
		if skilltable then return (who.." (Friend, "..Faction..")"), what, skilltable;
		else return false;
		end
	elseif (RecipeBookData[Realm][OtherFaction]) and (RecipeBookData[Realm][OtherFaction]["Shared"]) and (RecipeBookData[Realm][OtherFaction]["Shared"][who]) then
		skilltable = FindAltTradeskill(RecipeBookData[Realm][OtherFaction]["Shared"][who][what]);
		if skilltable then return (who.." (Friend, "..OtherFaction..")"), what, skilltable;
		else return false;
		end
	else
		RecipeBook_Print(RECIPEBOOK_NOALTMATCH..'"'..who..'".', 1);
		return false;
	end
end
		
--== [ RESET A CHARACTER'S TRADESKILL DATA ] ==--
function RecipeBook_ResetData(tradeskill)
	tradeskill = string.gsub(tradeskill, "%l", string.upper, 1);
 	if tradeskill  == "All" then
		RecipeBookData[Realm][Faction]["Personal"][Player] = {};
		RecipeBook_Print(RECIPEBOOK_RESET_ALL..Player, 0);
	elseif tradeskill == "Masterlist" then
		RecipeBookMasterList = {["Tradeskills"] = {}, ["Links"] = {}, ["Debug"] = {}};
		RecipeBook_Print(RECIPEBOOK_RESET_MASTERLIST, 0);
	else
		if RecipeBookData[Realm][Faction]["Personal"][Player][tradeskill] ~= nil then
			RecipeBookData[Realm][Faction]["Personal"][Player][tradeskill] = nil;
			RecipeBook_Print(RECIPEBOOK_RESET_SUCCEED..tradeskill, 0);
		else
			RecipeBook_Print(RECIPEBOOK_RESET_FAIL..tradeskill, 1);
		end
	end
end


--== [ HANDLING BANKED ITEMS ]==--
-- DoManualBank(msg) : Largely obsolete; adds an item manually to your bank (via /rb bank [Item Link])
function RecipeBook_DoManualBank(msg)
	local regex = ".*%[(.*)%].*";
	local item;
	item = string.gsub(msg, regex, "%1") 
	if(item == msg) then return RecipeBook_Print(RECIPEBOOK_BANK_FAIL, 1) end;
	RecipeBook_AddToBank(item,"Manual", Player, "No tradeskill", 0);
end

-- DoAutoBank() : Automatically scans bank on opening and closing; updates all recipes it finds.
function RecipeBook_DoAutoBank()
	if not RecipeBookOptions_GetOption("AutoBank") then return end;
	local i,j,link, skill;
	local inbank = {};
	local added = {};
	local removed = {};
	local rtemp = {};
	local movefrom = {};

	local function dobanking(link)
		if link then 
			local recipename,isrecipe, tradeskill, itemid = RecipeBook_ParseItemLink(link);
			if isrecipe == RECIPEBOOK_RECIPEWORD then
				if itemid then
					RecipeBookTooltip:SetHyperlink(itemid);
					skill = RecipeBook_GetRecipeData("RecipeBookTooltip");
				end
				table.insert(inbank, recipename);
				if RecipeBook_AddToBank(recipename,"Bank", Player, tradeskill, skill) then table.insert(added, recipename) end;
			end
		end
	end
	
	for i=1,24 do 
		dobanking(GetContainerItemLink(BANK_CONTAINER, i));
	end
	for bag = 5, 10 do
		for i= 1, GetContainerNumSlots(bag) do
			dobanking(GetContainerItemLink(bag,i));
		end
	end
	if(RecipeBookOptions_GetOption("AutoBags")) then
		RecipeBook_DoAutoBagScan(); --If bag tracking is on, get list of items in bags.
		local inbags = RecipeBook_ParsePendingRecipes();
		removed = RecipeBook_CleanOldBanked(inbank, "Bank");
		for i=1,table.getn(removed) do
			if RecipeBook_FindInList(removed[i], inbags) then 
			else 
				table.insert(rtemp, removed[i]); --Item truly has disappeared.
			end
			removed = rtemp;
		end
	else
		removed = RecipeBook_CleanOldBanked(inbank, "Bank");
	end
	if RecipeBookOptions_GetOption("Banked") then
		if table.getn(added) > 0 then 
			RecipeBook_Print(RECIPEBOOK_AUTOBANK..RECIPEBOOK_GREEN..table.concat(added, RECIPEBOOK_END.."; "..RECIPEBOOK_GREEN), 0);
		end;
		if table.getn(removed) > 0 then 
			RecipeBook_Print(RECIPEBOOK_AUTOUNBANK..RECIPEBOOK_RED..table.concat(removed, RECIPEBOOK_END.."; "..RECIPEBOOK_RED), 0);
		end;
	end
end

-- DoAutoBagScan() : Autoscans bags, on any bag update.
function RecipeBook_DoAutoBagScan()
	if not RecipeBookOptions_GetOption("AutoBags") then return end;
	local bag,item,j;
	RB_BagContents[Player] = {};
	for bag = 0,4 do
		for j= 1, GetContainerNumSlots(bag) do
			item = GetContainerItemLink(bag,j);
			if item then 
				RB_BagContents[Player][item] = bag;
			end
		end
	end
end

--ParsePendingRecipes() : Iterates through bagged recipes and actually processes them; attempting to make scans quick, given how often they happen.
function RecipeBook_ParsePendingRecipes()
	local inbank,added,bag,item,who, skill;
	if next(RB_BagContents) ~= nil then 
		local double = false;
		if RecipeBookData[Realm][Faction]["Pending"] == nil then RecipeBookData[Realm][Faction]["Pending"] = RB_BagContents;
		else 
			table.foreach(RB_BagContents, function(a,b) RecipeBookData[Realm][Faction]["Pending"][a] = b; end); 
		end
		RB_BagContents = {};
	end
	
	if RecipeBookData[Realm][Faction]["Pending"] ~= nil then
		local function convertbag(who, what)
			local function checkrecipe(name,bag)
				local recipename,isrecipe, tradeskill, itemid = RecipeBook_ParseItemLink(name);
				if isrecipe == RECIPEBOOK_RECIPEWORD then
					if itemid then
						RecipeBookTooltip:SetHyperlink(itemid);
						skill = RecipeBook_GetRecipeData("RecipeBookTooltip");
					end
					table.insert(inbank, recipename);
					if RecipeBook_AddToBank(recipename,"Bag",who, tradeskill, skill) then table.insert(added, recipename) end;
				end
			end
			table.foreach(what, checkrecipe);
			RecipeBook_CleanOldBanked(inbank, "Bag", who);
			if table.getn(added) > 0 and RecipeBookOptions_GetOption("Banked") then 
				text = string.format(RECIPEBOOK_AUTOBAG, who.."'s")..RECIPEBOOK_CYAN..table.concat(added, RECIPEBOOK_END.."; "..RECIPEBOOK_CYAN);
				RecipeBook_Print(text, 0);
			end
		end
		inbank = {};
		added = {};
		table.foreach(RecipeBookData[Realm][Faction]["Pending"], convertbag);
		RecipeBookData[Realm][Faction]["Pending"] = {};
		return inbank;
	else 
		return {};
	end
end

--AddToBank(item, loc) : Adds an item to the bank - item: item name; loc: one of "Manual", "Bank", or "Bag". 
function RecipeBook_AddToBank(item,loc,who,tradeskill, skill)
	if not who then who = Player end;
	if skill == nil then skill = 0 end;
	local i,value;
	if(item and string.len(item) > 5) then
		if skill > 0 then 
			if RecipeBookMasterList["BankData"][tradeskill] == nil then RecipeBookMasterList["BankData"][tradeskill] = {} end;
			if RecipeBookMasterList["BankData"][tradeskill][skill] == nil then 
				RecipeBook_Debug("Adding "..item.." as first for "..tradeskill.." ("..skill..")");
				RecipeBookMasterList["BankData"][tradeskill][skill] = {item};
			else
				local found = false;
				for i, value in ipairs(RecipeBookMasterList["BankData"][tradeskill][skill]) do 
					if value == item then 
						found = true;
						break;
					end
				end
				if not found then 
					RecipeBook_Debug("Adding "..item.." as additional for "..tradeskill.." ("..skill..")");
					table.insert(RecipeBookMasterList["BankData"][tradeskill][skill], item) 
				end;
			end
		end

		if RecipeBookData[Realm][Faction]["Banked"][item] ~= nil then -- Item in bank
			if RecipeBookData[Realm][Faction]["Banked"][item][who] ~= nil then -- Player has banked item
				if loc=="Manual" then return RecipeBook_Print(RECIPEBOOK_BANK_ALREADYBANKED, 1); --Manual add error; item already autobanked.
				elseif loc == RecipeBookData[Realm][Faction]["Banked"][item][who] then 
					return false; --Same location.
				else 
					RecipeBookData[Realm][Faction]["Banked"][item][who] = loc; --Update location.  
					return item; --Item not being added, just moved.
				end;
			else --Another player has banked
				RecipeBookData[Realm][Faction]["Banked"][item][who] = loc;
				if loc=="Manual" then return RecipeBook_Print(format(RECIPEBOOK_BANK_SUCCEED, item), 0);
				else return item;
				end;
			end
		else --Item not in bank
			RecipeBookData[Realm][Faction]["Banked"][item] = {};
			RecipeBookData[Realm][Faction]["Banked"][item][who] = loc;
			if loc=="Manual" then return RecipeBook_Print(format(RECIPEBOOK_BANK_SUCCEED, "new item "..item), 0)
			else return item;
			end;
		end
	end
end

-- CleanOldBanked(inbank, loc) : Given a list of current bank contents (inbank) and the location of that list ("Manual", "Bank", "Bag"), clears out any banked items that are no longer contained therein.
function RecipeBook_CleanOldBanked(inbank,loc,who)
	if not who then who = Player end;
	local i,j;
	local removed = {};
	local kept = {};
	local processed = false;
	
	local function bankiterate(item,name)
		if name[who] == loc then 
			if RecipeBook_FindInList(item, inbank) then --Item found in that location's banked list.  Keep it.
				kept[item] = name; --Item banked by this player.
			else
				table.insert(removed,item) --Mark as removed
				name[who] = nil;
				if (next(name) ~= nil) then kept[item] = name end; --More than one person has this item banked.  Keep the others.
			end
		else
			kept[item] = name; --Item not banked by this player.
		end
		
	end
	table.foreach(RecipeBookData[Realm][Faction]["Banked"], bankiterate)
	RecipeBookData[Realm][Faction]["Banked"] = kept;

	return removed;
end

function RecipeBook_DoUnbank(msg)
	local regex = ".*%[(.*)%].*";
	local item = string.gsub(msg, regex, "%1") 
	local removed = false;
	if(item == msg) then return RecipeBook_Print(RECIPEBOOK_UNBANK_FAIL, 1);
	elseif(item and string.len(item) > 5) then
		if string.sub(msg, -3) == "all" then --Remove all mention of the item.
			if RecipeBookData[Realm][Faction]["Banked"][item] ~= nil then
				RecipeBookData[Realm][Faction]["Banked"][item] = nil; 
				RecipeBook_Print(format(RECIPEBOOK_UNBANK_ALLSUCCEED, item), 0);
			else
				return RecipeBook_Print(RECIPEBOOK_UNBANK_FAIL, 1);
			end
		else
			if RecipeBookData[Realm][Faction]["Banked"][item] ~= nil then
				if RecipeBookData[Realm][Faction]["Banked"][item][Player] ~= nil then
					RecipeBookData[Realm][Faction]["Banked"][item][Player] = nil;
					if next(RecipeBookData[Realm][Faction]["Banked"][item]) == nil then RecipeBook_DoUnbank(msg.." all") end; --Clear it out completely.
				else
					return RecipeBook_Print(RECIPEBOOK_UNBANK_FAIL, 1);
				end
			else
				return RecipeBook_Print(RECIPEBOOK_UNBANK_FAIL, 1);
			end
		end
		return;
	end
end


--== [ OUTPUT TO TOOLTIP OR CHAT FRAME ] ==--
function RecipeBook_OutputRecipeTooltip(tooltip, knows, canlearn, havetradeskill, isbanked)
	local modded = false;
	if tooltip == "ItemRefTooltip" then 
		tooltip = ItemRefTooltip;
	elseif type(tooltip) == "string" then 
		tooltip = getglobal(tooltip);
	else
	end
	if(knows ~= "") then
		if not modded then 
			tooltip:AddLine(" ",0,0,0);
		end
		tooltip:AddLine(RECIPEBOOK_KNOWNBY..knows, unpack(RecipeBookOptions_GetOption("KnownColor")));
		RB_LastWhat[2] = true;
		modded = true;
	end
	if(canlearn ~= "") then
		if not modded then 
			tooltip:AddLine(" ",0,0,0);
		end
		tooltip:AddLine(RECIPEBOOK_CANLEARN..canlearn, unpack(RecipeBookOptions_GetOption("CanLearnColor")));
		RB_LastWhat[2] = true;
		modded = true;
	end
	if(havetradeskill ~= "") then
		if not modded then 
			tooltip:AddLine(" ",0,0,0);
		end
		tooltip:AddLine(RECIPEBOOK_WILLLEARN..havetradeskill, unpack(RecipeBookOptions_GetOption("WillLearnColor")));
		RB_LastWhat[2] = true;
		modded = true;
	end
	if(isbanked ~= "") then
		if not modded then
			tooltip:AddLine(" ",0,0,0);
		end
		tooltip:AddLine(RECIPEBOOK_ISBANKED..isbanked, unpack(RecipeBookOptions_GetOption("BankedColor")));
		RB_LastWhat[2] = true;
		modded = true;
	end 
	tooltip:Show();
	RB_TooltipLines = tooltip:NumLines();
end

function RecipeBook_OutputRecipeChatFrame(recipename, knows, canlearn, havetradeskill, isbanked)
	if RB_ChatFrameUpdated then return end;
	local chatframe = RecipeBook_GetChatFrame();
	if RecipeBookOptions_GetOption("Known") then 
		if (knows ~= "") then
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_KNOWNBY .. knows, -1, chatframe, 0, 1,0);
			RB_LastWhat[2] = true;
		else
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_NONEKNOWN, -1, chatframe, 1,0,0);
		end
	end
	if RecipeBookOptions_GetOption("CanLearn") then 
		if(canlearn ~= "") then
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_CANLEARN .. canlearn, -1, chatframe, 0, 1,0);
			RB_LastWhat[2] = true;
		else
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_NONELEARN, -1, chatframe, 1,0,0);
		end
	end
	if RecipeBookOptions_GetOption("WillLearn") then
		if(havetradeskill ~= "") then
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_WILLLEARN ..havetradeskill, -1, chatframe, 0, 1,0);
			RB_LastWhat[2] = true;
		else
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_NONEWILLLEARN, -1, chatframe, 1,0,0);
		end
	end
	if RecipeBookOptions_GetOption("Banked") then
		if(isbanked ~= "") then
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_BANKED..isbanked, -1, chatframe, 0, 1,0);
			RB_LastWhat[2] = true;
		else
			RecipeBook_Print(recipename .. RECIPEBOOK_CHATFRAME_NOTBANKED, -1, chatframe, 1,0,0);
		end
	end
	RB_ChatFrameUpdated = true;
end



--== [ UTILITY FUNCTIONS ] ==--
--[ Split : Splits a string into a table of words. ]--
function RecipeBook_Split(tocut)
	local words = {};
	function towords(word) table.insert(words, word) end
	if not string.find(string.gsub(tocut, "%S+", towords), "%S") then 
		return words;
	end
end

--[ StringToID(link): takes a hyperlink and returns an item ID
function RecipeBook_StringToID(link)
	if link == nil then return nil end
	local _,_,id = string.find(link, ".*|H(%w*:[%d%p]*)|h.*");
	return id;
end

--[ Print(message, prefix (0 = <RecipeBook>, 1 = <RecipeBook Error:>, -1 = No Prefix), frame, colors) : Prints a RecipeBook status message. ]--
function RecipeBook_Print(message, prefix, frame, r,g,b)
	if message == nil then return end;
	if frame == nil then frame = DEFAULT_CHAT_FRAME end;
	if r == nil then r = 1; g = 1; b = 1;
	elseif g == nil then g = 1; b = 1;
	elseif b == nil then b = 1;
	end

	if(prefix == 0) then prefix = RECIPEBOOK_PREFIX;
	elseif(prefix == 1) then prefix = RECIPEBOOK_ERROR_PREFIX;
	else prefix = "";
	end
	if type(message) == "table" then
		table.foreach(message, function(t, u) frame:AddMessage(prefix..u, r, g, b) end )
	else
		frame:AddMessage(prefix..message, r, g, b);
	end
end

--[ Debug(message) : Prints a debug message if Debug is on. ]--
function RecipeBook_Debug(message)
	if(RB_Debug) then
		if message then	DEFAULT_CHAT_FRAME:AddMessage("<RecipeBook Debug:> "..message) end;
	end
end

--[ PrintStatus : Prints out the status of whatever options are passed to it. ]--
function RecipeBook_PrintStatus(option)
	toggleoptions = "Status FriendShow AutoBank AutoBags";
	showhideoptions = "Banked ShowSelf Known CanLearn WillLearn FriendKnown FriendCanLearn FriendShow FriendWillLearn";
	printorder = {"Status","Output","Receive","ShowSelf","FriendShow", "Banked", "AutoBank", "AutoBags", "AltFaction", "FriendAltFaction", "Known", "FriendKnown", "CanLearn", "FriendCanLearn", "WillLearn", "FriendWillLearn"};
	if(option == "all") then --Print all options
		RecipeBook_Print(RECIPEBOOOK_VERSION, 1);
		table.foreach(printorder, function(a,b) RecipeBook_PrintStatus(b) end);
	elseif(option == "Output") then --Print output status
		RecipeBook_Print(RECIPEBOOK_OUTPUT_TOOLTIP..(RecipeBookOptions_GetOption("Tooltip") and RECIPEBOOK_ON or RECIPEBOOK_OFF), -1)
		RecipeBook_Print(RECIPEBOOK_OUTPUT_CHATFRAME..(RecipeBookOptions_GetOption("ChatFrame") and RECIPEBOOK_ON or RECIPEBOOK_OFF), -1)
	elseif(option == "Receive") then
		local o = RecipeBookOptions_GetOption(option);
		if (o == "fAgAoA") then RecipeBook_Print(RECIPEBOOK_ACCEPT_ALL);
		elseif(o == "fDgDoD") then RecipeBook_Print(RECIPEBOOK_DECLINE_ALL);
		elseif(o == "fPgPoP") then RecipeBook_Print(RECIPEBOOK_PROMPT_ALL);
		else
			local function FillOption(set)
				if set == "A" then return RECIPEBOOK_AUTOACCEPT;
				elseif set == "D" then return RECIPEBOOK_AUTODECLINE;
				else return RECIPEBOOK_PROMPT;
				end
			end
			RecipeBook_Print(RECIPEBOOK_RFRIENDS..FillOption(string.sub(o, 2, 2))..(IsInGuild() and (RECIPEBOOK_RGUILD..FillOption(string.sub(o, 4, 4))) or "")..RECIPEBOOK_ROTHERS..FillOption(string.sub(o, 6, 6)), -1);
		end
	elseif((option == "AltFaction") or (option == "FriendAltFaction")) then --Print factional display status
		if ((not RecipeBookOptions_GetOption("FriendShow")) and option == "FriendAltFaction") then return end;
		local af = (option == "AltFaction" and "" or "Friend");
		if RecipeBookOptions_GetOption(af.."SameFaction") then 
			if RecipeBookOptions_GetOption(af.."OtherFaction") then
				RecipeBook_Print((af == "Friend" and RECIPEBOOK_FRIEND_PREFIX or "")..RECIPEBOOK_DISPLAY_BOTHFACTIONS, -1);
			else
				RecipeBook_Print((af == "Friend" and RECIPEBOOK_FRIEND_PREFIX or "")..string.format(RECIPEBOOK_DISPLAY_FACTION, Faction), -1);
			end
		elseif RecipeBookOptions_GetOption(af.."OtherFaction") then
				RecipeBook_Print((af == "Friend" and RECIPEBOOK_FRIEND_PREFIX or "")..string.format(RECIPEBOOK_DISPLAY_FACTION, OtherFaction), -1);
		else
			RecipeBook_Print((af == "Friend" and RECIPEBOOK_FRIEND_PREFIX or "")..RECIPEBOOK_DISPLAY_NOFACTIONS, -1);
		end
	elseif option == "AuctionColors" then
		RecipeBook_Print(RECIPEBOOK_AUCCOLOR_ALTSCANLEARN, -1, DEFAULT_CHAT_FRAME, unpack(RecipeBookOptions_GetOption("AuctionColors", "AltsCanLearn")));
		RecipeBook_Print(RECIPEBOOK_AUCCOLOR_ALTSWILLLEARN, -1, DEFAULT_CHAT_FRAME, unpack(RecipeBookOptions_GetOption("AuctionColors", "AltsWillLearn")));
		RecipeBook_Print(RECIPEBOOK_AUCCOLOR_YOUWILLLEARN, -1, DEFAULT_CHAT_FRAME, unpack(RecipeBookOptions_GetOption("AuctionColors", "YouWillLearn")));
		RecipeBook_Print(RECIPEBOOK_AUCCOLOR_NOALTSCANLEARN, -1, DEFAULT_CHAT_FRAME, unpack(RecipeBookOptions_GetOption("AuctionColors", "NoAltsCanLearn")));
		RecipeBook_Print(RECIPEBOOK_AUCCOLOR_ALLALTSKNOW, -1, DEFAULT_CHAT_FRAME, unpack(RecipeBookOptions_GetOption("AuctionColors", "AllAltsKnow")));
	elseif string.find(toggleoptions, option) then
		RecipeBook_Print(string.format(getglobal("RECIPEBOOK_"..string.upper(option).."_ONOFF"), (RecipeBookOptions_GetOption(option) and RECIPEBOOK_ON or RECIPEBOOK_OFF)), -1)
	elseif string.find(showhideoptions, option) then
		if(string.sub(option, 1, 6) == "Friend") then
			if RecipeBookOptions_GetOption("FriendShow") then 
				RecipeBook_Print(RECIPEBOOK_FRIEND_PREFIX..string.format(getglobal("RECIPEBOOK_"..string.upper(string.sub(option, 7)).."_SHOWHIDE"), (RecipeBookOptions_GetOption(option) and RECIPEBOOK_SHOW or RECIPEBOOK_HIDE)), -1)
			end
		else
			RecipeBook_Print(string.format(getglobal("RECIPEBOOK_"..string.upper(option).."_SHOWHIDE"), (RecipeBookOptions_GetOption(option) and RECIPEBOOK_SHOW or RECIPEBOOK_HIDE)), -1)
		end
	end
end

--[ GetChatFrame (courtesy Averice's WIM, used by permission): Finds out which Chat Frame the RecipeBook info is in ]--
function RecipeBook_GetChatFrame()
	local frame = nil;
	local frametab, tempframe;
	for i = 1, NUM_CHAT_WINDOWS do
		tempframe = getglobal("ChatFrame" .. i .. "Tab");
		if (tempframe:GetText() == "Recipe Book") then
			frame = getglobal("ChatFrame" .. i);
			frametab = tempframe;
			break;
		end
	end
	if (frame) then
		if(not frametab:IsVisible()) then 
			frametab:Show(); 
		end
		return frame;
	else
		FCF_OpenNewWindow("Recipe Book");
		frame = RecipeBook_GetChatFrame(); 
		FCF_SetLocked(frame, true, false);
		ChatFrame_RemoveAllMessageGroups(frame);
		return frame;
	end
end

-------------------==[ SKILL FRAME DISPLAY ]==----------------------
function RecipeBook_SkillScrollBar_Update()
	local length = table.getn(RB_TradeskillData);
	local line, index, button, text; 
	local offset = FauxScrollFrame_GetOffset(RecipeBook_Skill_ScrollFrame);
	
	FauxScrollFrame_Update(RecipeBook_Skill_ScrollFrame,length+1,14,20);
	for line = 1,14,1 do 
		index = offset + line;
		text = getglobal("RecipeBook_SkillFrameEntry"..line.."_Text");
		if index <= length then 
			text:SetText(RB_TradeskillData[index][1]);
			local difficulty = RB_TradeskillData[index][2];
-- 			if difficulty == "" or difficulty == "shared" then difficulty = "header" end;
			if difficulty ~= nil then 
				text:SetTextColor(RECIPEBOOK_COLOR[difficulty]["r"], RECIPEBOOK_COLOR[difficulty]["g"], RECIPEBOOK_COLOR[difficulty]["b"]) 
			end;
		end
		button = getglobal("RecipeBook_SkillFrameEntry"..line);
		button:SetID(line);
		if index > length then 
			button:Hide();
		else
			button:Show();
		end
	end
end
 
function RecipeBook_CountdownUpdate(elapsed)
	if this.timeSinceLastUpdate == nil then this.timeSinceLastUpdate = 0 end;
	this.timeSinceLastUpdate = this.timeSinceLastUpdate + elapsed; 	
	if (this.timeSinceLastUpdate > RECIPEBOOK_SEND_PAUSE) then    
		this.timeSinceLastUpdate = 0;
		this:Hide();
	end
end

function RecipeBook_SkillButton_OnClick(button)
	local text = getglobal("RecipeBook_SkillFrameEntry"..this:GetID().."_Text"):GetText();
	local _,_,skill = string.find(RB_SkillFrameTradeskillText:GetText(), "(.*) %(");
	local link;
	if RecipeBookMasterList["Tradeskills"][skill] ~=  nil and RecipeBookMasterList["Tradeskills"][skill][text] ~= nil then
		link = RecipeBookMasterList["Links"][RecipeBookMasterList["Tradeskills"][skill][text]["ID"]];
	end
	if link == nil then
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(text);
		end
		return;
	end
	if IsShiftKeyDown() then 
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(link);
		end
	elseif IsAltKeyDown() then
		local data = {};
		table.foreach(RecipeBookMasterList["Tradeskills"][skill][text]["Materials"], function(a,b) table.insert(data, RecipeBookMasterList["Links"][a].." x"..b) end);
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(table.concat(data, ", "));
		else
			RecipeBook_Print(RECIPEBOOK_TXT_SUPPLIES..link..": "..table.concat(data, ", "), -1, nil, 0.25,0.5,1);
		end
	else
		SetItemRef(RecipeBookMasterList["Tradeskills"][skill][text]["ID"],link);
	end
end

function RecipeBook_FindInList(item,list,index)
	local i;
	if table.getn(list) < 1 then return nil end;
	if index then
		for i=1,table.getn(list) do
			if list[i][index] == item then return i end;
		end
	else
		for i=1,table.getn(list) do
			if list[i] == item then return i end;
		end
	end
	return nil;
end

function RecipeBook_BagsOnOff(onoff)
	if onoff == "On" then
		if RecipeBookOptions_GetOption("AutoBags") then 
			this:RegisterEvent("BAG_UPDATE");
		end
	elseif onoff == "Off" then
		this:UnregisterEvent("BAG_UPDATE");
	end
end

function RecipeBook_TrackingOnOff(onoff)
	if onoff == "On" then
		this:RegisterEvent("TRADE_SKILL_SHOW");
		this:RegisterEvent("TRADE_SKILL_UPDATE");
		this:RegisterEvent("TRADE_SKILL_CLOSE");
		this:RegisterEvent("CRAFT_SHOW");
		this:RegisterEvent("CRAFT_UPDATE");
		this:RegisterEvent("CRAFT_CLOSE");
	elseif onoff == "Off" then
		this:UnregisterEvent("TRADE_SKILL_SHOW");
		this:UnregisterEvent("TRADE_SKILL_UPDATE");
		this:UnregisterEvent("TRADE_SKILL_CLOSE");
		this:UnregisterEvent("CRAFT_SHOW");
		this:UnregisterEvent("CRAFT_UPDATE");
		this:UnregisterEvent("CRAFT_CLOSE");
	end
end


