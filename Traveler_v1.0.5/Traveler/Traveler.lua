--------------------------------------------------------------------------------
-- 
-- Name: Traveler.lua
-- Author: Malex-Cenarius
-- Date: 11/12/2006
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--
-- Method: Traveler_OnLoad
-- Description: Called during the onload of the addon
--
--------------------------------------------------------------------------------
function Traveler_OnLoad()
	
	-- Register the slash handler
	--
	SLASH_TRAVELER1 = "/traveler";
	SlashCmdList["TRAVELER"] = function(msg)
		Traveler_SlashCommandHandler(msg);
	end
	
	-- Event Registration
	--
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("ZONE_CHANGED");
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    this:RegisterEvent("ZONE_CHANGED_INDOORS");
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
    
	-- Allows Traveler to be closed with the Escape key
	--
	tinsert(UISpecialFrames, "TravelerFrame");    
	
	
	-- Tab Handling code
	--
	PanelTemplates_SetNumTabs(TravelerFrame, 3);
	PanelTemplates_SetTab(TravelerFrame, 1);
	
	
	-- Member variable initialization
	--
	this.TimeSinceLastBroadcast = 0;
	this.TimeSinceLastExpirationCheck = 0;	
	
	-- Intercept incoming whispers
	--
	TravelerChatFrameOnEventOriginal = ChatFrame_OnEvent
	ChatFrame_OnEvent = Traveler_ChatFrame_OnEvent
	
	
end


--------------------------------------------------------------------------------
--
-- Method: Traveler_ChatFrame_OnEvent
-- Description: This function intercepts incoming chat messages, passing them
--	through if they aren't from the traveler system
-- Arguments:
--	event - [in] The text name of the event
--	arg1 - [in] The message text
--	arg2 - [in] The author of the message
--
--------------------------------------------------------------------------------
function Traveler_ChatFrame_OnEvent(event)
	
    if ( arg1 and arg2 ) then
    
		if(event == "CHAT_MSG_WHISPER") then					
			if ( string.sub(arg1, 1, 3) == "TP:") then				
				return;
			end
		end		
		if(event == "CHAT_MSG_WHISPER_INFORM") then
			if ( string.sub(arg1, 1, 3)  == "TP:") then				
				return;
			end
		end
		
    end    

    -- call original function to display the whisper
    TravelerChatFrameOnEventOriginal(event, arg1, arg2);
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_OnShow
-- Description: Called when the addon is shown
--
--------------------------------------------------------------------------------
function Traveler_OnShow()

	Traveler_Tab_OnClick(1);	
	

	
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_OnUpdate
-- Description: Called every frame while the addon is being shown
-- Arguments:
--	elapsed - [in] The amount of time in seconds since the last call to OnUpdate
--
--------------------------------------------------------------------------------
function Traveler_OnUpdate(elapsed)
	
	local now = time();
	
	this.TimeSinceLastBroadcast = this.TimeSinceLastBroadcast + elapsed;
	if(this.TimeSinceLastBroadcast >= TravelerBroadcastFrequency) then
	
		this.TimeSinceLastBroadcast = 0;		
	
		if(now - TravelerLastBroadcastTime >= TravelerBroadcastFrequency) then		
			Traveler_Broadcast();
		end
	
	end

	
	this.TimeSinceLastExpirationCheck = this.TimeSinceLastExpirationCheck + elapsed;
	if(this.TimeSinceLastExpirationCheck >= TravelerExpirationCheckFrequency) then
	
		this.TimeSinceLastExpirationCheck = 0;
	
		Traveler_ExpireSuppliers();
		Traveler_ExpireCustomers();
		
		-- Join the traveler channel
		--
		Traveler_CheckChannelMembership();
	end
	
	if(now - TravelerChannelLastSampleTime >= 1.0) then
		
		TravelerChannelLastSampleTime = now;
		Traveler_ThrottleSendRate();
		
	end
	
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_CheckChannelMembership
-- Description: Should join the TravelerChannel if there is an available channel
--
--------------------------------------------------------------------------------
function Traveler_CheckChannelMembership()
			
	local disableErrorText = false;
	local alreadyJoined = false;
	
	local id = GetChannelName(TravelerChannel);
	if(id ~= 0) then
		alreadyJoined = true;
	end	
	
	local count = 0;
	for i = 1, 10 do
	
		if(DEFAULT_CHAT_FRAME.channelList[i]) then
			count = count + 1;
		end
	
	end
	
	
	-- If we aren't already a member of the traveler channel...
	--
	if(alreadyJoined == false) then
	
		local count = 0;
		for i = 1, 10 do
		
			if(DEFAULT_CHAT_FRAME.channelList[i]) then
				count = count + 1;
			end
		
		end
		
		if(count < 10) then		
			
			JoinChannelByName(TravelerChannel, "", DEFAULT_CHAT_FRAME:GetID());	
			
			
			disableErrorText = true;
			
		else
			
			-- Set the error text and show it
			--
			TextError:SetText("Unable to join TravelerChannel.");
			TextError:Show();			
			
		end
		
	else
	
		disableErrorText = true;
		
	end
	
	-- Disable the output to the default chat frame from the traveler channel
	--
	--ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, strupper(TravelerChannel));
	--ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, strlower(TravelerChannel));
	ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, TravelerChannel);
	
	if(disableErrorText) then
		
		TextError:SetText("");
		TextError:Hide();
	
	end
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_ExpireSuppliers
-- Description: Traverses the suppliers table and purges those advertisments
--	that have exceeded the expiration time.  It also resets the RequestSent flag
--	for any suppliers that are part of your group.
--
--------------------------------------------------------------------------------
function Traveler_ExpireSuppliers()

	now = time();

	for key, value in pairs(TravelerSuppliers) do
	
		if(type(value) == "table") then											
			if(now - value.LastPing >= TravelerDestinationExpiration) then			
				TravelerSuppliers[key] = nil;
				TravelerSuppliers.Size = TravelerSuppliers.Size - 1;
				
			-- Reset the RequestSent flag if you are in the suppliers party
			--				
			elseif(Traveler_IsUserInPartyOrRaid(value.Name)) then
			
				value.RequestSent = false;
			
			elseif(value.RequestSent and (time() - value.RequestSentTime >= TravelerCustomerExpiration)) then
			
				value.RequestSent = false;
				
			end
			
		end	
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_ExpireCustomers
-- Description: Traverses the customers table and purges those customers
--	that have exceeded the expiration time.
--
--------------------------------------------------------------------------------
function Traveler_ExpireCustomers()

	now = time();

	for key, value in pairs(TravelerCustomers) do
	
		if(type(value) == "table") then											
			if(now - value.LastPing >= TravelerCustomerExpiration) then			
				TravelerCustomers[key] = nil;
				TravelerCustomers.Size = TravelerCustomers.Size - 1;
			end
			
		end	
	end

end


--------------------------------------------------------------------------------
--
-- Method: Traveler_OnEvent
-- Description: The event handles for the addon
--
--------------------------------------------------------------------------------
function Traveler_OnEvent()

	if(event == "CHAT_MSG_CHANNEL") then		
		if(arg9 == TravelerChannel) then	

			-- Increase the message count on the channel
			--
			TravelerChannelMessagesThisSecond = 0;
					
			Traveler_ParseMessage(arg2, arg1);		
		end
	elseif(event == "CHAT_MSG_WHISPER") then
		
		if(Traveler_ParseMessage(arg2, arg1) == false) then
		
			-- Handle incoming whispers containing the portal keywords
			--
			local i = 1;
			while TravelerRandomPortKeywords[i] do
			
				if(strfind(string.lower(arg1), TravelerRandomPortKeywords[i])) then
				
					Traveler_OnRandomPortalRequest(arg2, arg1);					
					break;
				
				end
				
				i = i + 1;
			
			end
		end
	elseif(event == "ZONE_CHANGED_NEW_AREA") then
		SetMapToCurrentZone();
	elseif(event == "ADDON_LOADED") then
				
		if(arg1 == "Traveler") then
				
			SetMapToCurrentZone();
			
			-- Load saved variables
			--
			if(TravelerOptions == nil) then
				TravelerOptions = {};
			end
			
			if(TravelerOptions.CostInCopper == nil) then
				TravelerOptions.CostInCopper = 5000;
			end
			
            TravelerFrame_FrameAdvertise_PriceInputGold:SetMaxLetters(6);			
            MoneyInputFrame_SetCopper(TravelerFrame_FrameAdvertise_PriceInput, TravelerOptions.CostInCopper);	                        				
		elseif(arg1 == "WIM") then
					
			-- Add the protocol identifier to the filter list
			--
			WIM_Filters["TP:"] = "Ignore";
				
		end
	elseif(event == "PLAYER_ENTERING_WORLD") then
	
		-- Update globals
		--
		Traveler_CheckSpells();
		
		if((Traveler_IsWarlock() == false and Traveler_IsMage() == false) or TravelerHasSummon == false) then
			TravelerFrameTab2:Hide();
		end
			
	elseif(event == "ZONE_CHANGED") then
		SetMapToCurrentZone();
	elseif(event == "ZONE_CHANGED_INDOORS") then
		SetMapToCurrentZone();
	end	

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_SlashCommandHandler
-- Description: Handles the slash commands for the addon
-- Arguments:
--	msg - [in] The text arguments to the command
--
--------------------------------------------------------------------------------
function Traveler_SlashCommandHandler(msg)	
	Traveler_Toggle();
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_Toggle
-- Description: Toggles display of the traveler main frame
--
--------------------------------------------------------------------------------
function Traveler_Toggle()
	local frame = getglobal("TravelerFrame");
	
	if(frame) then
		if(frame:IsVisible()) then
			frame:Hide();
		else
			frame:Show();
		end
	end
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_Tab_OnClick
-- Description: Handles for the tab buttons
-- Arguments: 
--	index - [in] The 1-based index of the tab that was clicked
--
--------------------------------------------------------------------------------
function Traveler_Tab_OnClick(index)

	if(not index) then
		index = this:GetID();
	end
	
	PanelTemplates_SetTab(TravelerFrame, index);

	TravelerFrame_FrameDestination:Hide();
	TravelerFrame_FrameAdvertise:Hide();
	TravelerFrame_FrameBan:Hide();
	
	if ( index == 1 ) then
		TravelerFrameTopLeft:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-TopLeft");
		TravelerFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
		TravelerFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
		TravelerFrameBotLeft:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-BotLeft");
		TravelerFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Bot");
		TravelerFrameBotRight:SetTexture("Interface\\Addons\\Traveler\\Images\\UI-TravelerFrame-BotRight-TwoButton");
	
		TravelerFrame_FrameDestination:Show();
	elseif ( index == 2 ) then
		TravelerFrameTopLeft:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-TopLeft");
		TravelerFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
		TravelerFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
		TravelerFrameBotLeft:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-BotLeft");
		TravelerFrameBot:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-Bot-FourButton");
		TravelerFrameBotRight:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-BotRight-FourButton");
		
		TravelerFrame_FrameAdvertise:Show();
		
	elseif ( index == 3 ) then
		
		TravelerFrameTopLeft:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-TopLeft");
		TravelerFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
		TravelerFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
		TravelerFrameBotLeft:SetTexture("Interface\\AddOns\\Traveler\\Images\\UI-TravelerFrame-BotLeft");
		TravelerFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Bot");
		TravelerFrameBotRight:SetTexture("Interface\\Addons\\Traveler\\Images\\UI-TravelerFrame-BotRight-OneButton");
		
		TravelerFrame_FrameBan:Show();
	end
end




















