--------------------------------------------------------------------------------
-- 
-- Name: TravelerDestination.lua
-- Author: Malex-Cenarius
-- Date: 11/21/2006
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_OnLoad
-- Description: Called during the onload event of the destination frame
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_OnLoad()
		
	-- Member variable initialization
	--
	this.TimeSinceLastUpdate = 0;	

	TravelerFrame_FrameDestination_ButtonReset:Disable();
	
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_OnShow
-- Description: Called when the destination tab is shown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_OnShow()
	
	Traveler_Destination_Refresh();
	
end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_OnUpdate
-- Description: Called every frame when the destination tab is showing
-- Arguments:
--	elapsed - [in] The amount of time in seconds since the last OnUpdate was called
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_OnUpdate(elapsed)

	-- Don't call this stuff every frame, only so often (as defined by the frequency)
	--
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;	
	if(this.TimeSinceLastUpdate >= TravelerOnUpdateFrequency) then
	
		this.TimeSinceLastUpdate = 0;
	
		-- Allow the listbox to refresh
		--
		Traveler_Destination_Refresh();
	
	end
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_ButtonRequestSummon_OnClick
-- Description: Called when the request summon button is clicked
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_ButtonRequestSummon_OnClick()

	local suppliersFiltered = Traveler_Destination_Filter(TravelerSuppliers);
	warlock = Traveler_GetValueByIndex(suppliersFiltered, TravelerDestinationId);

	if(warlock) then
	
		if(warlock.RequestSent) then
		
			warlock.RequestSent = false;
			Traveler_UnRequestSummon();
		
		else	
		
			warlock.RequestSent = true;	
			warlock.RequestSentTime = time();	
			Traveler_RequestSummon();
		
		end
		
		Traveler_Destination_Refresh();
	
	end

end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_ButtonDestination_OnClick
-- Description: Called when one of the list items is clicked
-- Arguments:
--	button - [in] A reference to the list item button that was clicked
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_ButtonDestination_OnClick(button)

	if ( not button ) then
		button = this;
	end
	
	TravelerDestinationId = button:GetID() + FauxScrollFrame_GetOffset(TravelerFrame_FrameDestination_FrameScroll);
	Traveler_Destination_Refresh();
	
	local suppliersFiltered = Traveler_Destination_Filter(TravelerSuppliers);
	warlock = Traveler_GetValueByIndex(suppliersFiltered, TravelerDestinationId);

	-- Don't allow the player to send a request to himself
	--
	if(warlock.Name == UnitName("player")) then
	
		TravelerFrame_FrameDestination_ButtonRequestSummon:Disable();
		TravelerFrame_FrameDestination_ButtonBan:Disable();
	
	else
	
		TravelerFrame_FrameDestination_ButtonRequestSummon:Enable();
		TravelerFrame_FrameDestination_ButtonBan:Enable();
	
	end
	
		
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_ButtonBan_OnClick
-- Description: The handler for clicking the ban button
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_ButtonBan_OnClick()

	local suppliersFiltered = Traveler_Destination_Filter(TravelerSuppliers);
	warlock = Traveler_GetValueByIndex(suppliersFiltered, TravelerDestinationId);
	if(warlock) then
		
		Traveler_Ban(warlock.Name, warlock.RaceIndex, warlock.Gender);
				
		-- Reset the selected index
		--
		TravelerDestinationId = 0;
		
		-- Refresh the search list
		--
		Traveler_Destination_Refresh();
	end

	
	
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_Destination_Filter
-- Description: Filters a table of suppliers from the instance/continent/zone
--	dropdowns
-- Arguments:
--	suppliers - [in] A reference to the unfiltered table
-- Returns: A filtered table of suppliers
--
--------------------------------------------------------------------------------
function Traveler_Destination_Filter(suppliers)

	local suppliersFiltered = { Size = 0 };
	
	local instanceFilter = nil;
	if(TravelerInstanceId ~= 0) then
		instanceFilter = UIDropDownMenu_GetText(TravelerFrame_FrameDestination_DropDownInstance);
	end

	local continentFilter = nil;
	if(TravelerContinentId ~= 0) then
		continentFilter = UIDropDownMenu_GetSelectedID(TravelerFrame_FrameDestination_DropDownContinent);
	end

	local zoneFilter = nil;
	if(TravelerZoneId ~= 0) then
		zoneFilter = UIDropDownMenu_GetText(TravelerFrame_FrameDestination_DropDownZone);
	end
	
	local myZone = Traveler_GetZone();
	local mySubZone = Traveler_GetSubZone();
	local myFaction = UnitFactionGroup("player");

	for key,value in pairs(suppliers) do
		if(type(value) == "table") then					
		
			local addValue = true;
			
			-- Handle warlocks
			--
			if(value.Class == "W") then
				
				-- Determine if the value should be copied into the filtered list
				--							
				if(instanceFilter) then						
					if(value.Zone ~= instanceFilter) then	
						addValue = false;
					end
				elseif(continentFilter) then
					
					if(tonumber(value.ContinentIndex) ~= continentFilter) then
						addValue = false;
					end				
					
					if(zoneFilter) then
						if(zoneFilter ~= value.Zone) then											
							addValue = false;
						end					
					end				
					
				end							
			-- Handle mages
			--
			else
			
				addValue = false;
			
				if(zoneFilter) then
				
					local destFilterPassed = false;
				
					-- Make sure the customer is trying to go to a capital city
					--
					if(myFaction == "Alliance") then
					
						if(zoneFilter == "Ironforge" or zoneFilter == "Darnassus" or zoneFilter == "Stormwind City") then						
							destFilterPassed = true;
						end
					
					else
				
						if(zoneFilter == "Orgrimmar" or zoneFilter == "Undercity" or zoneFilter == "Thunder Bluff") then
							destFilterPassed = true;
						end
					 
					end
					
					-- Check to see if the mage is in the customers current zone
					--
					if(destFilterPassed) then
					
						if(myZone == value.Zone) then
						
							addValue = true;
						
						end
					end
				
				end
			
				
			end
				
			if(addValue) then
				suppliersFiltered[key] = {};
				suppliersFiltered[key] = value;
				suppliersFiltered.Size = suppliersFiltered.Size + 1;			
			end
			
		end		
	end
	
	return suppliersFiltered;

end


--------------------------------------------------------------------------------
--
-- Method: Traveler_Destination_Refresh
-- Description: Refreshes the destination frame's supplier listbox
--
--------------------------------------------------------------------------------
function Traveler_Destination_Refresh()
	
	
	local button, buttonName, iconTexture;
	local offset = FauxScrollFrame_GetOffset(TravelerFrame_FrameDestination_FrameScroll);
	local index;

	-- Filter the warlocks list according the dropdown parameters
	--	
	local suppliersFiltered = Traveler_Destination_Filter(TravelerSuppliers);
	
	
	if(suppliersFiltered.Size == 0) then
		TravelerFrame_FrameDestination_ButtonRequestSummon:Disable();
		TravelerFrame_FrameDestination_ButtonBan:Disable();	
		TravelerDestinationId = 0;
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
		button = getglobal("TravelerFrame_FrameDestination_ButtonDestination"..i);
		
		if ( index > suppliersFiltered.Size ) then
			button:Hide();
		else
		
			button:Show();
			buttonName = "TravelerFrame_FrameDestination_ButtonDestination"..i;
			
			local supplier = Traveler_GetValueByIndex(suppliersFiltered, index);
			
			
			-- Resize button if there isn't a scrollbar
			buttonHighlight = getglobal("TravelerFrame_FrameDestination_ButtonDestination"..i.."Highlight");
			
			if ( suppliersFiltered.Size < 8 ) then
				button:SetWidth(793);
				buttonHighlight:SetWidth(758);
				--BidBidSort:SetWidth(169);
			elseif ( suppliersFiltered.Size == 8) then
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
			getglobal(buttonName.."_TextName"):SetText(supplier.Name);
			getglobal(buttonName.."_TextSubZone"):SetText(supplier.SubZone);
			getglobal(buttonName.."_TextCoords"):SetText(supplier.Coords);
			getglobal(buttonName.."_TextNotes"):SetText(supplier.Notes);					
			
			if(supplier.RequestSent) then
				getglobal(buttonName.."_TextSubZone"):SetTextColor(0, 1, 0);
				getglobal(buttonName.."_TextCoords"):SetTextColor(0,1,0);
				getglobal(buttonName.."_TextNotes"):SetTextColor(0,1,0);
				getglobal(buttonName.."_TextLastPing"):SetTextColor(0,1,0);				

				if(i == TravelerDestinationId) then
					TravelerFrame_FrameDestination_ButtonRequestSummon:SetText("Cancel");
				end
				
			else
				getglobal(buttonName.."_TextSubZone"):SetTextColor(1, 1, 1);
				getglobal(buttonName.."_TextCoords"):SetTextColor(1,1,1);
				getglobal(buttonName.."_TextNotes"):SetTextColor(1,1,1);
				getglobal(buttonName.."_TextLastPing"):SetTextColor(1,1,1);				
		
				if(i == TravelerDestinationId) then
					TravelerFrame_FrameDestination_ButtonRequestSummon:SetText("Request");
				end
				
			end
			
			local timeDelta = time() - supplier.LastPing;
			local minutes = max(1, floor(timeDelta / 60));						
			getglobal(buttonName.."_TextLastPing"):SetText(minutes .. " min");
			
			-- Set supplier picture
			--
			iconTexture = getglobal(buttonName.."ItemIconTexture");						
			iconTexture:SetTexCoord(Traveler_GetTexCoordsForRaceGender(supplier.RaceIndex, supplier.Gender));
			
			-- Set summon price
			--			
			MoneyFrame_Update(buttonName.."_MoneyFrame", supplier.CostInCopper);

			-- Set highlight
			if ( TravelerDestinationId and index == TravelerDestinationId) then
				button:LockHighlight();				
			else
				button:UnlockHighlight();
			end
		end
	end

	-- Update scrollFrame
	FauxScrollFrame_Update(TravelerFrame_FrameDestination_FrameScroll, suppliersFiltered.Size, 8, 37);	
	
	
end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_DropDownInstance_Initialize
-- Description: The initializer for the instance dropdown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_DropDownInstance_Initialize()

	local info;
	for i = 1, getn(TravelerInstances), 1 do
		info = {
			text = TravelerInstances[i];
			func = TravelerFrame_FrameDestination_DropDownInstance_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_DropDownInstance_OnClick
-- Description: Called when the instance dropdown gets a click event
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_DropDownInstance_OnClick()

	-- Set the dropdown's selection
	--
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownInstance, this:GetID());
	
	-- Update globals
	--
	TravelerInstanceId = this:GetID();
	TravelerContinentId = 0;
	TravelerZoneId = 0;
	
	-- Reset the continent dropdown
	--	    
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownContinent, TravelerContinentId);
	TravelerFrame_FrameDestination_DropDownContinentText:SetText("");
	
	-- Reset the zone dropdown
	--	
	SetMapZoom(this:GetID());
	UIDropDownMenu_Initialize(TravelerFrame_FrameDestination_DropDownZone, TravelerFrame_FrameDestination_DropDownZone_Initialize);
	SetMapToCurrentZone();
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownZone, TravelerZoneId);	
	TravelerFrame_FrameDestination_DropDownZoneText:SetText("");
	
	-- Enable the reset button
	--
	TravelerFrame_FrameDestination_ButtonReset:Enable();
	
	-- Refresh the listbox
	--
	Traveler_Destination_Refresh();
end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_DropDownContinent_Initialize
-- Description: The initializer for the continent dropdown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_DropDownContinent_Initialize()
	TravelerFrame_LoadContinents(GetMapContinents());
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_LoadContinents
-- Description: Loads the continent names into the continent dropdown
-- Arguments: A list of continent names
--
--------------------------------------------------------------------------------
function TravelerFrame_LoadContinents(...)

	local info;
	for i=1, arg.n, 1 do
		info = {};
		info.text = arg[i];
		info.func = TravelerFrame_FrameDestination_DropDownContinent_OnClick;
		UIDropDownMenu_AddButton(info);
	end
	
end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_DropDownContinent_OnClick
-- Description: Called when the continent dropdown receives an onclick event
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_DropDownContinent_OnClick()

	-- Set the dropdown's selection
	--
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownContinent, this:GetID());
	
	-- Update globals
	--
	TravelerContinentId = this:GetID();
	TravelerInstanceId = 0;
	TravelerZoneId = 0;	
	
	-- Reset the instance dropdown
	--
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownInstance, TravelerInstanceId);
	TravelerFrame_FrameDestination_DropDownInstanceText:SetText("");
	
	-- Reset the zone dropdown
	--
	SetMapZoom(this:GetID());
	UIDropDownMenu_Initialize(TravelerFrame_FrameDestination_DropDownZone, TravelerFrame_FrameDestination_DropDownZone_Initialize);
	SetMapToCurrentZone();
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownZone, TravelerZoneId);	
	TravelerFrame_FrameDestination_DropDownZoneText:SetText("");
	
	-- Enable the reset button
	--
	TravelerFrame_FrameDestination_ButtonReset:Enable();
	
	-- Refresh the listbox
	--
	Traveler_Destination_Refresh();
end


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_DropDownZone_Initialize
-- Description: The initializer for the zone dropdown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_DropDownZone_Initialize()

	TravelerFrame_LoadZones(GetMapZones(TravelerContinentId));
	
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_LoadZones
-- Description: Adds zones to the zone dropdown
-- Arguments: A list of zones
--
--------------------------------------------------------------------------------
function TravelerFrame_LoadZones(...)

	if(TravelerContinentId ~= 0) then
		local info;
		for i=1, arg.n, 1 do
			info = {};
			info.text = arg[i];
			info.func = TravelerFrame_FrameDestination_DropDownZone_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
	
end



--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_DropDownZone_OnClick
-- Description: The handler for the onclick event of the zone dropdown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_DropDownZone_OnClick()

	-- Set the dropdown selection
	--
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownZone, this:GetID());
	
	-- Update globals
	--
	TravelerZoneId = this:GetID();
	
	-- Enable the reset button
	--
	TravelerFrame_FrameDestination_ButtonReset:Enable();
	
	-- Refresh the listbox
	--
	Traveler_Destination_Refresh();
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameDestination_ButtonReset_OnClick
-- Description: The handler for the reset button
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameDestination_ButtonReset_OnClick()

	-- Reset globals
	--
	TravelerInstanceId = 0;
	TravelerContinentId = 0;
	TravelerZoneId = 0;
	
	-- Reset the instance dropdown
	--
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownInstance, TravelerInstanceId);
	TravelerFrame_FrameDestination_DropDownInstanceText:SetText("");
	
	-- Reset the continent dropdown
	--
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownContinent, TravelerContinentId);
	TravelerFrame_FrameDestination_DropDownContinentText:SetText("");
	
	-- Reset the zone dropdown
	--
	SetMapZoom(this:GetID());
	UIDropDownMenu_Initialize(TravelerFrame_FrameDestination_DropDownZone, TravelerFrame_FrameDestination_DropDownZone_Initialize);
	SetMapToCurrentZone();
	UIDropDownMenu_SetSelectedID(TravelerFrame_FrameDestination_DropDownZone, TravelerZoneId);	
	TravelerFrame_FrameDestination_DropDownZoneText:SetText("");
	
	-- Disable the reset button
	--
	TravelerFrame_FrameDestination_ButtonReset:Disable();
	
	-- Refresh the listbox
	--
	Traveler_Destination_Refresh();
	
end


