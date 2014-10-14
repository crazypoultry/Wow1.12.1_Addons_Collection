
	local DEBUG  = false;
	local VERSION = "v0.7";

	----
	-- Config
	----
	OpenClam_Config = {}
	OpenClam_Config["enabled"] = true;
	
	----
	-- Clam IDs
	----
	OPENCLAM_CLAMS  = {
		5523,  -- Small Barnacled Clam
		5524,  -- Thick-shelled Clam
		7973,  -- Big-mouth Clam
		15874  -- Soft-shelled Clam
	}

	----------------------------------------------------------------------------------------------------------------------

	----
	-- Msg
	----
	local function OpenClam_Msg(msg)
		DEFAULT_CHAT_FRAME:AddMessage("["..OPENCLAM_TITLE.."] "..msg);
	end
	
	----
	-- Debug
	----
	local function OpenClam_Debug(msg)
		if (DEBUG) then
			DEFAULT_CHAT_FRAME:AddMessage("["..OPENCLAM_TITLE.."] "..msg);
		end
	end

	----
	-- Toggle
	-- hide/show clam frame
	----
	local function OpenClam_Toggle()
		if (OpenClam_Frame:IsVisible()) then
			OpenClam_Frame:Hide();
		else
			OpenClam_Frame:Show();
		end
	end
	
	----
	-- Update
	----
	local function OpenClam_Update()
		if (OpenClam_Config["enabled"]) then
			OpenClam_Frame:RegisterEvent("LOOT_CLOSED");
			OpenClam_Frame:RegisterEvent("MAIL_CLOSED");
			OpenClam_Frame:RegisterEvent("TRADE_CLOSED");
			OpenClam_Frame:RegisterEvent("BANKFRAME_CLOSED");
			OpenClam_Frame:RegisterEvent("BAG_UPDATE");
		else
			OpenClam_Frame:UnregisterEvent("LOOT_CLOSED");
			OpenClam_Frame:UnregisterEvent("MAIL_CLOSED");
			OpenClam_Frame:UnregisterEvent("TRADE_CLOSED");
			OpenClam_Frame:UnregisterEvent("BANKFRAME_CLOSED");
			OpenClam_Frame:UnregisterEvent("BAG_UPDATE");
		end
	end
	
	----
	-- ForbiddenFrame
	----
	local function OpenClam_ForbiddenFrame()
		local auctionframe = false;
		if (AuctionFrame and AuctionFrame:IsVisible()) then
			auctionframe = true;
		end
		if (LootFrame:IsVisible() or
		    TradeFrame:IsVisible() or
		    BankFrame:IsVisible() or
		    MailFrame:IsVisible() or
		    auctionframe or
		    MerchantFrame:IsVisible()) then
			return true;
		else
			return false;
		end
	end
	
	----
	-- ExtractLinkID
	----
	local function OpenClam_ExtractLinkID(link)
		_, _, id = string.find(link, "Hitem:(.+):%d+:%d+:%d+%\124");
		return tonumber(id);
	end

	----
	-- Cmd
	----
	local function OpenClam_Cmd(cmd)
		cmd = string.lower(cmd);
		if (cmd == "enable") then
			OpenClam_Msg(OPENCLAM_ENABLED);
			OpenClam_Config["enabled"] = true;
			OpenClam_Update();
		elseif (cmd == "disable") then
			OpenClam_Msg(OPENCLAM_DISABLED);
			OpenClam_Config["enabled"] = false;
			OpenClam_Update();
		elseif (cmd == "status") then
			if (OpenClam_Config["enabled"]) then
				OpenClam_Msg(OPENCLAM_ENABLED);
			else
				OpenClam_Msg(OPENCLAM_DISABLED);
			end
		elseif (cmd == "count") then
			OpenClam_Msg(OPENCLAM_COUNT..": "..CountClams());
		elseif (cmd == "macro") then
		
		elseif (cmd == "open") then
			if (not OpenClam_ForbiddenFrame()) then
				OpenClam();
			end
		elseif (cmd == "version") then
			OpenClam_Msg(VERSION);
		elseif (cmd == "debug") then
			if (DEBUG) then
				OpenClam_Msg(OPENCLAM_DEBUG_OFF);
				DEBUG = false;
			else
				OpenClam_Msg(OPENCLAM_DEBUG_ON);
				DEBUG = true;
			end
		end
	end
	
	----------------------------------------------------------------------------------------------------------------------

	----
	-- OnLoad
	----
	function OpenClam_OnLoad()
		this:RegisterEvent("VARIABLES_LOADED");
		SLASH_CLAM1 = "/clam";
		SlashCmdList["CLAM"] = OpenClam_Cmd;
	end

	----
	-- OnEvent
	----
	function OpenClam_OnEvent(event, arg1)
		if (event == "VARIABLES_LOADED") then
			OpenClam_Update();
		end
		if (event == "LOOT_CLOSED") then
			if (not OpenClam_ForbiddenFrame()) then
				OpenClam();
			end
		end
		if (event == "MAIL_CLOSED") then
			if (not OpenClam_ForbiddenFrame()) then
				OpenClam();
			end
		end
		if (event == "TRADE_CLOSED") then
			if (not OpenClam_ForbiddenFrame()) then
				OpenClam();
			end
		end
		if (event == "BANKFRAME_CLOSED") then
			if (not OpenClam_ForbiddenFrame()) then
				OpenClam();
			end
		end
		if (event == "BAG_UPDATE") then
			if (not OpenClam_ForbiddenFrame()) then
				OpenClam();
			end
		end
	end
	
	----------------------------------------------------------------------------------------------------------------------

	----
	-- IsClam
	-- search clam string
	----
	function IsClam(link)
		local index;
		for index = 1, table.getn(OPENCLAM_CLAMS) do
			if (OpenClam_ExtractLinkID(link) == OPENCLAM_CLAMS[index]) then
				return true;
			end
		end
		return false;
	end

	----
	-- CanOpenClam
	-- scan bag item tooltip
	----
	function CanOpenClam(bag, slot)
		OpenClam_Tooltip:SetBagItem(bag, slot);
		local text2 = OpenClam_TooltipTextLeft2:GetText();
		if (text2 and text2 == ITEM_OPENABLE) then
			return true;
		else
			return false;
		end
	end

	----
	-- OpenClam
	-- open clam from inventory
	----
	function OpenClam()
		local bag, slot;
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local link = GetContainerItemLink(bag, slot);
				if (link and IsClam(link) and CanOpenClam(bag, slot)) then
					UseContainerItem(bag, slot);
					return true;
				end
			end
		end
		return false;
	end

	----
	-- CountClams
	-- count clams in inventory
	----
	function CountClams()
		local bag, slot;
		local count = 0;
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local link = GetContainerItemLink(bag, slot);
				if (link and CanOpenClam(bag, slot)) then
					count = count + 1;
				end
			end
		end
		return count;
	end
