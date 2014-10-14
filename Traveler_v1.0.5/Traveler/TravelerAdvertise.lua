--------------------------------------------------------------------------------
-- 
-- Name: TravelerAdvertise.lua
-- Author: Malex-Cenarius
-- Date: 11/21/2006
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_OnLoad
-- Description: Handler for the onload event of the advertise frame
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_OnLoad()

	TravelerFrame_FrameAdvertise_ButtonBan:Disable();
	TravelerFrame_FrameAdvertise_ButtonSummon:Disable();	
	TravelerFrame_FrameAdvertise_ButtonRemove:Disable();
	
	
	-- Member variable initialization
	--
	this.TimeSinceLastUpdate = 0;			
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_OnShow
-- Description: Handler for the onShow event of the advertise tab
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_OnShow()
	
	Traveler_FrameAdvertise_Refresh();
	
end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_OnUpdate
-- Description: Handler for the onupdate event of the advertise tab
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_OnUpdate(elapsed)

	-- Don't call this stuff every frame, only so often (as defined by the frequency)
	--
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;	
	if(this.TimeSinceLastUpdate > TravelerOnUpdateFrequency) then
	
		this.TimeSinceLastUpdate = 0;
	
		-- Allow the listbox to refresh
		--
		Traveler_FrameAdvertise_Refresh();
	
	end
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_ButtonAdvertise_OnClick
-- Description: Handles the onclick of the listbox button
-- Arguments:
--	button - [in] A reference to the listbox button clicked
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_ButtonAdvertise_OnClick(button)

	if ( not button ) then
		button = this;
	end
	
	-- Update globals
	--
	TravelerCustomerId = button:GetID() + FauxScrollFrame_GetOffset(TravelerFrame_FrameAdvertise_FrameScroll);
	
	-- Refresh the listbox
	--
	Traveler_FrameAdvertise_Refresh();
		
	customer = Traveler_GetValueByIndex(TravelerCustomers, TravelerCustomerId);
	
	-- Don't allow a player to summon themselves
	--
	if(customer.Name == UnitName("player")) then

		TravelerFrame_FrameAdvertise_ButtonSummon:Disable();
		TravelerFrame_FrameAdvertise_ButtonRemove:Enable();
		TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Summon");
	
	else
	
		TravelerFrame_FrameAdvertise_ButtonSummon:Enable();
		TravelerFrame_FrameAdvertise_ButtonRemove:Enable();
		
		if(Traveler_IsUserInPartyOrRaid(customer.Name)) then
		
			if(Traveler_IsWarlock()) then
				TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Summon");
			else
				TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Invite");
				TravelerFrame_FrameAdvertise_ButtonSummon:Disable();
			end
			
		else
			TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Invite");
			TravelerFrame_FrameAdvertise_ButtonBan:Enable();
		end
	end
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_ButtonBan_OnClick
-- Description: Handles the ban button onclick event
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_ButtonBan_OnClick()

	customer = Traveler_GetValueByIndex(TravelerCustomers, TravelerCustomerId);
	if(customer) then

		-- Add the warlock to the ban list
		--
		Traveler_Ban(customer.Name, customer.RaceIndex, customer.Gender);
				
		-- Reset globals
		--
		TravelerCustomerId = 0;
		
		-- Refresh the listbox
		--
		Traveler_FrameAdvertise_Refresh();
	end

	
	
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_ButtonSummon_OnClick
-- Description: The handler for the summon/invite button
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_ButtonSummon_OnClick()
	
	customer = Traveler_GetValueByIndex(TravelerCustomers, TravelerCustomerId);

	if(this:GetText() == "Invite") then
		InviteByName(customer.Name);
	else
		TargetByName(customer.Name);
		CastSpellByName("Ritual Of Summoning");
	end
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_ButtonStart_OnClick
-- Description: Handler for the start button
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_ButtonStart_OnClick()
	
	-- Toggle the enabled state
	--
	TravelerBroadcastEnabled = not TravelerBroadcastEnabled;	
	if(TravelerBroadcastEnabled) then
	
		this:SetText("Stop");
		
		-- Send off a broadcast right away
		--
		Traveler_Broadcast();
		
	else
	
		this:SetText("Start");
		
		-- Send off a kill message
		--
		Traveler_SendKill();
		
	end
	
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_DropDownInstance_Initialize
-- Description: The initializer for the instance dropdown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_DropDownInstance_Initialize()

	-- Disable the instanced dropdown for mages
	--
	if(Traveler_IsWarlock()) then
		local info;
		
		-- Add a null string to the dropdown
		--
		info = {
			text = "";
			func = TravelerFrame_FrameAdvertise_DropDownInstance_OnClick;
		}
		UIDropDownMenu_AddButton(info);
	
	
		-- Add all the instances from the global TravelerInstances table
		--
		for i = 1, getn(TravelerInstances), 1 do
			info = {
				text = TravelerInstances[i];
				func = TravelerFrame_FrameAdvertise_DropDownInstance_OnClick;
			};
			UIDropDownMenu_AddButton(info);
		end
	
	end
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_DropDownInstance_OnClick
-- Description: The handler for the onclick event of the instance dropdown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_DropDownInstance_OnClick()

	-- Set dropdown selection
	--
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameAdvertise_DropDownInstance, this:GetID());	
	
	-- Update globals
	--
	TravelerAdInstanceId = this:GetID();	  

	-- Broadcast an update state message
	--
	Traveler_Broadcast();
end


--------------------------------------------------------------------------------
--
-- Method: Traveler_FrameAdvertise_Refresh
-- Description: Refreshes the listbox
--
--------------------------------------------------------------------------------
function Traveler_FrameAdvertise_Refresh()
	
	
	local button, buttonName, iconTexture;
	local offset = FauxScrollFrame_GetOffset(TravelerFrame_FrameAdvertise_FrameScroll);
	local index;

	
	-- Disable all buttons if there are no customers
	--
	if(TravelerCustomers.Size == 0) then
		TravelerFrame_FrameAdvertise_ButtonSummon:Disable();
		TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Summon");
		TravelerFrame_FrameAdvertise_ButtonBan:Disable();	
		TravelerFrame_FrameAdvertise_ButtonRemove:Disable();
		TravelerCustomerId = 0;
	end
	
	-- Enable buttons if a customer is selected
	--
	if(TravelerCustomerId) then
	
		customer = Traveler_GetValueByIndex(TravelerCustomers, TravelerCustomerId);
		
		if(customer) then

			if(Traveler_IsUserInPartyOrRaid(customer.Name)) then
				if(Traveler_IsWarlock()) then
					TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Summon");
				else
					TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Invite");
					TravelerFrame_FrameAdvertise_ButtonSummon:Disable();
				end
			else
				TravelerFrame_FrameAdvertise_ButtonSummon:SetText("Invite");
			end
		
		end
	
	end
	
	
	-- Update sort arrows
	--SortButton_UpdateArrow(BidQualitySort, "bidder", "quality");
	--SortButton_UpdateArrow(BidLevelSort, "bidder", "level");
	--SortButton_UpdateArrow(BidDurationSort, "bidder", "duration");
	--SortButton_UpdateArrow(BidBuyoutSort, "bidder", "buyout");
	--SortButton_UpdateArrow(BidStatusSort, "bidder", "status");
	--SortButton_UpdateArrow(BidBidSort, "bidder", "bid");

	for i=1, 8 do
		
		index = offset + i;
		button = getglobal("TravelerFrame_FrameAdvertise_ButtonAdvertise"..i);
		-- Show or hide auction buttons
		if ( index > TravelerCustomers.Size ) then
			button:Hide();
		else
		
			button:Show();
			buttonName = "TravelerFrame_FrameAdvertise_ButtonAdvertise"..i;
			
			local customer = Traveler_GetValueByIndex(TravelerCustomers, index);
						
			-- Resize button if there isn't a scrollbar
			buttonHighlight = getglobal("TravelerFrame_FrameAdvertise_ButtonAdvertise"..i.."Highlight");
			
			if ( TravelerCustomers.Size < 8 ) then
				button:SetWidth(793);
				buttonHighlight:SetWidth(758);
				--BidBidSort:SetWidth(169);
			elseif ( TravelerCustomers.Size == 8) then
				button:SetWidth(793);
				buttonHighlight:SetWidth(758);
				--BidBidSort:SetWidth(169);
			else
				button:SetWidth(769);
				buttonHighlight:SetWidth(735);
				--BidBidSort:SetWidth(145);
			end
			
			-- Set text fields
			--
			getglobal(buttonName.."_TextName"):SetText(customer.Name);
			getglobal(buttonName.."_TextZone"):SetText(customer.Zone);
			getglobal(buttonName.."_TextCoords"):SetText(customer.Coords);					
			
			local timeDelta = time() - customer.LastPing;
			local minutes = max(1, floor(timeDelta / 60));						
			getglobal(buttonName.."_TextLastPing"):SetText(minutes .. " min");
			
			-- Set Warlock picture
			--
			iconTexture = getglobal(buttonName.."ItemIconTexture");			
			iconTexture:SetTexCoord(Traveler_GetTexCoordsForRaceGender(customer.RaceIndex, customer.Gender));
			
			-- Set highlight
			if ( TravelerCustomerId and index == TravelerCustomerId) then
				button:LockHighlight();				
			else
				button:UnlockHighlight();
			end
		end
	end

	-- Update scrollFrame
	FauxScrollFrame_Update(TravelerFrame_FrameAdvertise_FrameScroll, TravelerCustomers.Size, 8, 37);	
	
	
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_MoneyInput_OnValueChanged
-- Description: The valuechanged handler for the moneyInput control
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_MoneyInput_OnValueChanged()

	-- Update globals
	--
    TravelerOptions.CostInCopper = MoneyInputFrame_GetCopper(TravelerFrame_FrameAdvertise_PriceInput);
	
	-- Broadcast an update state message
	--
	Traveler_Broadcast();
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameAdvertise_ButtonRemove_OnClick
-- Description: The handler for the "remove" button
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameAdvertise_ButtonRemove_OnClick()
	
	if(TravelerCustomerId ~= 0) then

		customer = Traveler_GetValueByIndex(TravelerCustomers, TravelerCustomerId);
		
		if(customer) then
		
			-- Remove the customer from the list
			--
			TravelerCustomers[customer.Name] = nil;
			TravelerCustomers.Size = TravelerCustomers.Size - 1;
			
			-- Update globals
			--
			TravelerCustomerId = 0;
			
			-- Refresh the listbox
			--
			Traveler_FrameAdvertise_Refresh();
		end
	end
	
end

