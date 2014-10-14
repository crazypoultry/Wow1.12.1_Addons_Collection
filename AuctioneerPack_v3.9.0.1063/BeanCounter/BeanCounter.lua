--[[
	BeanCounter Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: BeanCounter.lua 1008 2006-09-27 06:03:30Z vindicator $

	BeanCounter - trackes AH purchases and sales

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

-------------------------------------------------------------------------------
-- Function Imports
-------------------------------------------------------------------------------
local debugPrint = EnhTooltip.DebugPrint;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local preContainerFrameItemButtonOnClickHook;
local relevel;
local chatPrint;
local nilSafe;
local commandHandler;

-------------------------------------------------------------------------------
-- Version
-------------------------------------------------------------------------------
BeanCounter = {};
BeanCounter.Version="3.9.0.1056";
if (BeanCounter.Version == "<".."%version%>") then
	BeanCounter.Version = "3.9.DEV";
end

-------------------------------------------------------------------------------
-- OnLoad handler for BeanCounterFrame.
-------------------------------------------------------------------------------
function BeanCounter_OnLoad()
	debugPrint("BeanCounter_OnLoad() called");

	-- Unhook some boot triggers if necessary.
	-- These might not exist on initial loading or if an addon depends on BeanCounter
	if (BeanCounter_CheckLoad) then
		Stubby.UnregisterFunctionHook("AuctionFrame_LoadUI", BeanCounter_CheckLoad);
		Stubby.UnregisterFunctionHook("CheckInbox", BeanCounter_CheckLoad);
	end
	if (BeanCounter_ShowNotLoaded) then
		Stubby.UnregisterFunctionHook("AuctionFrame_Show", BeanCounter_ShowNotLoaded);
	end

	-- Register our temporary command hook with stubby
	Stubby.RegisterBootCode("BeanCounter", "CommandHandler", [[
		local function cmdHandler(msg)
			local i,j, cmd, param = string.find(string.lower(msg), "^([^ ]+) (.+)$")
			if (not cmd) then cmd = string.lower(msg) end
			if (not cmd) then cmd = "" end
			if (not param) then param = "" end
			if (cmd == "load") then
				if (param == "") then
					Stubby.Print("Manually loading BeanCounter...")
					LoadAddOn("BeanCounter")
				elseif (param == "auctionhouse") then
					Stubby.Print("Setting BeanCounter to load when this character visits the auction house or mailbox")
					Stubby.SetConfig("BeanCounter", "LoadType", param)
				elseif (param == "always") then
					Stubby.Print("Setting BeanCounter to always load for this character")
					Stubby.SetConfig("BeanCounter", "LoadType", param)
					LoadAddOn("BeanCounter")
				elseif (param == "never") then
					Stubby.Print("Setting BeanCounter to never load automatically for this character (you may still load manually)")
					Stubby.SetConfig("BeanCounter", "LoadType", param)
				else
					Stubby.Print("Your command was not understood")
				end
			else
				Stubby.Print("BeanCounter is currently not loaded.")
				Stubby.Print("  You may load it now by typing |cffffffff/BeanCounter load|r")
				Stubby.Print("  You may also set your loading preferences for this character by using the following commands:")
				Stubby.Print("  |cffffffff/BeanCounter load auctionhouse|r - BeanCounter will load when you visit the auction house or mailbox")
				Stubby.Print("  |cffffffff/BeanCounter load always|r - BeanCounter will always load for this character")
				Stubby.Print("  |cffffffff/BeanCounter load never|r - BeanCounter will never load automatically for this character (you may still load it manually)")
			end
		end
		SLASH_BEANCOUNTER1 = "/beancounter"
		SLASH_BEANCOUNTER2 = "/bean"
		SLASH_BEANCOUNTER3 = "/bc"
		SlashCmdList["BEANCOUNTER"] = cmdHandler
	]]);
	Stubby.RegisterBootCode("BeanCounter", "Triggers", [[
		function BeanCounter_CheckLoad()
			local loadType = Stubby.GetConfig("BeanCounter", "LoadType")
			if (loadType == "auctionhouse" or not loadType) then
				LoadAddOn("BeanCounter")
			end
		end
		function BeanCounter_ShowNotLoaded()
		end
		local function onLoaded()
			Stubby.UnregisterAddOnHook("Blizzard_AuctionUI", "BeanCounter")
			if (not IsAddOnLoaded("BeanCounter")) then
				Stubby.RegisterFunctionHook("AuctionFrame_Show", 100, BeanCounter_ShowNotLoaded)
			end
		end
		Stubby.RegisterFunctionHook("AuctionFrame_LoadUI", 100, BeanCounter_CheckLoad)
		Stubby.RegisterFunctionHook("CheckInbox", 100, BeanCounter_CheckLoad);
		Stubby.RegisterAddOnHook("Blizzard_AuctionUI", "BeanCounter", onLoaded)
		local loadType = Stubby.GetConfig("BeanCounter", "LoadType")
		if (loadType == "always") then
			LoadAddOn("BeanCounter")
		else
			Stubby.Print("BeanCounter is not loaded. Type /beancounter for more info.");
		end
	]]);
	
	-- Register for notification of us being loaded.
	this:RegisterEvent("ADDON_LOADED");
end

-------------------------------------------------------------------------------
-- Called when the BeanCounter AddOn has completed loading.
-------------------------------------------------------------------------------
function BeanCounter_AddOnLoaded()
	debugPrint("BeanCounter_AddOnLoaded() called");

	-- Blizzard's auction UI may or may not have been loaded yet.
	if (IsAddOnLoaded("Blizzard_AuctionUI")) then
		BeanCounter_AuctionHouseLoaded();
	end

	-- Initialize our various modules.
	MailMonitor_OnLoad();
	BidMonitor_OnLoad();
	PostMonitor_OnLoad();
	
	-- Load the realm's database.
	BeanCounter.Database.Load(GetRealmName());

	-- Hello world!
	chatPrint(string.format("BeanCounter v%s loaded", BeanCounter.Version));
	
	SLASH_BEANCOUNTER1 = "/beancounter"
	SLASH_BEANCOUNTER2 = "/bean"
	SLASH_BEANCOUNTER3 = "/bc"
	SlashCmdList["BEANCOUNTER"] = commandHandler
end

function commandHandler(msg)
	local i,j, cmd, param = string.find(string.lower(msg), "^([^ ]+) (.+)$")
	if (not cmd) then cmd = string.lower(msg) end
	if (not cmd) then cmd = "" end
	if (not param) then param = "" end

	if (cmd == "load") then
		if (param == "auctionhouse") then
			chatPrint("Setting BeanCounter to load when this character visits the auction house or mailbox")
			Stubby.SetConfig("BeanCounter", "LoadType", param)
		elseif (param == "always") then
			chatPrint("Setting BeanCounter to always load for this character")
			Stubby.SetConfig("BeanCounter", "LoadType", param)
		elseif (param == "never") then
			chatPrint("Setting BeanCounter to never load automatically for this character (you may still load manually)")
			Stubby.SetConfig("BeanCounter", "LoadType", param)
		else
			chatPrint("Your command was not understood")
		end
	else
		chatPrint(string.format("BeanCounter v%s loaded", BeanCounter.Version));
		chatPrint("  You may set your loading preferences for this character by using the following commands:")
		chatPrint("  |cffffffff/BeanCounter load auctionhouse|r - BeanCounter will load when you visit the auction house or mailbox")
		chatPrint("  |cffffffff/BeanCounter load always|r - BeanCounter will always load for this character")
		chatPrint("  |cffffffff/BeanCounter load never|r - BeanCounter will never load automatically for this character (you may still load it manually)")
	end
end

-------------------------------------------------------------------------------
-- Called when the Blizzard_AuctionUI has completed loading.
-------------------------------------------------------------------------------
function BeanCounter_AuctionHouseLoaded()
	debugPrint("BeanCounter_AuctionHouseLoaded() called");

	-- Find the index of the first unused AuctionHouse tab
	local tabIndex = 1;
	while (getglobal("AuctionFrameTab"..tabIndex) ~= nil) do
		tabIndex = tabIndex + 1;
	end

	-- Add the Transactions tab
	AuctionFrameTransactions:SetParent("AuctionFrame")
	AuctionFrameTransactions:SetPoint("TOPLEFT", "AuctionFrame", "TOPLEFT", 0, 0)
	relevel(AuctionFrameTransactions);
	setglobal("AuctionFrameTab"..tabIndex, AuctionFrameTabTransactions);
	AuctionFrameTabTransactions:SetParent("AuctionFrame")

	AuctionFrameTabTransactions:SetPoint("TOPLEFT", getglobal("AuctionFrameTab"..(tabIndex - 1)):GetName(), "TOPRIGHT", -8, 0)
	AuctionFrameTabTransactions:SetID(tabIndex);
	AuctionFrameTabTransactions:Show();

	-- Tell the AuctionFrame that we've added tabs
	PanelTemplates_SetNumTabs(AuctionFrame, tabIndex)

	-- Hook the tab click method so we know when to show our tab.
	Stubby.RegisterFunctionHook("AuctionFrameTab_OnClick", 200, BeanCounter_AuctionFrameTab_OnClickHook)
	Stubby.RegisterFunctionHook("ContainerFrameItemButton_OnClick", -200, preContainerFrameItemButtonOnClickHook);
	Stubby.RegisterFunctionHook("SetSelectedAuctionItem", -200, preSetSelectedAuctionItemHook);
end

-------------------------------------------------------------------------------
-- OnEvent handler for BeanCounterFrame.
-------------------------------------------------------------------------------
function BeanCounter_OnEvent(event, arg1)
	if (event == "ADDON_LOADED") then
		if (string.lower(arg1) == "beancounter") then
			BeanCounter_AddOnLoaded();
		elseif (string.lower(arg1) == "blizzard_auctionui") then
			BeanCounter_AuctionHouseLoaded();
		end
	end
end

-------------------------------------------------------------------------------
-- OnUpdate handler for BeanCounterFrame.
-------------------------------------------------------------------------------
function BeanCounter_OnUpdate()
	MailMonitor_OnUpdate();
end

-------------------------------------------------------------------------------
-- Hooks Blizzard's AuctionFrameTab_OnClick() method.
-------------------------------------------------------------------------------
function BeanCounter_AuctionFrameTab_OnClickHook(_, _, index)
	if (not index) then
		index = this:GetID();
	end

	-- Hide our tabs
	AuctionFrameTransactions:Hide();
	
	-- Show an Auctioneer tab if its the one clicked
	local tab = getglobal("AuctionFrameTab"..index);
	if (tab) then
		if (tab:GetName() == "AuctionFrameTabTransactions") then
			AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopLeft");
			AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
			AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
			AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft");
			AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Bot");
			AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotRight");
			AuctionFrameTransactions:Show();
		end
	end
end

-------------------------------------------------------------------------------
-- Called before Blizzard's ContainerFrameItemButton_OnClick()
-------------------------------------------------------------------------------
function preContainerFrameItemButtonOnClickHook(hookParams, returnValue, button, ignoreShift)
	local bag = this:GetParent():GetID()
	local slot = this:GetID()

	-- If the transactions tab is visible, alt-left click runs a transaction
	-- search.
	if (not CursorHasItem() and AuctionFrameTransactions and AuctionFrameTransactions:IsVisible() and IsAltKeyDown()) then
		local _, count = GetContainerItemInfo(bag, slot);
		if (count) then
			local link = GetContainerItemLink(bag, slot)
			local _, _, _, _, name = EnhTooltip.BreakLink(link);
			AuctionFrameTransactions:SearchTransactions(name, true, nil);			
			return "abort";
		end
	end
end

-------------------------------------------------------------------------------
-- Called before Blizzard's SetSelectedAuctionItem()
-------------------------------------------------------------------------------
function preSetSelectedAuctionItemHook(hookParams, returnValue, list, index)
	-- Do a transaction search.
	local name = GetAuctionItemInfo(list, index);
	if (name) then
		AuctionFrameTransactions:SearchTransactions(name, true, nil);			
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function relevel(frame)
	local myLevel = frame:GetFrameLevel() + 1
	local children = { frame:GetChildren() }
	for _,child in pairs(children) do
		child:SetFrameLevel(myLevel)
		relevel(child)
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function nilSafe(string)
	if (string) then
		return string;
	end
	return "<nil>";
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function chatPrint(...)
	if (DEFAULT_CHAT_FRAME) then 
		local msg = ""
		for i=1, table.getn(arg) do
			if i==1 then msg = arg[i]
			else msg = msg.." "..arg[i]
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.35, 0.15)
	end
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
BeanCounter.DebugPrint = debugPrint;
BeanCounter.ChatPrint = chatPrint;
BeanCounter.NilSafe = nilSafe;
