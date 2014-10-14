--------------------------------------------------------------------------------
-- 
-- Name: TravelerBan.lua
-- Author: Malex-Cenarius
-- Date: 11/21/2006
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameBan_OnLoad
-- Description: Called during the load of the ban tab
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameBan_OnLoad()

	TravelerFrame_FrameBan_ButtonUnBan:Disable();
		
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameBan_OnShow
-- Description: Called when the ban tab is shown
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameBan_OnShow()

	Traveler_FrameBan_Refresh();
	
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameBan_ButtonBan_OnClick
-- Description: Called when one of the list items in the ban tab is clicked
-- Arguments:
--	button - [in] A reference to the button clicked
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameBan_ButtonBan_OnClick(button)
	
	if ( not button ) then
		button = this;
	end
	
	TravelerBanId = button:GetID() + FauxScrollFrame_GetOffset(TravelerFrame_FrameBan_FrameScroll);
	Traveler_FrameBan_Refresh();
		
	TravelerFrame_FrameBan_ButtonUnBan:Enable();
end

--------------------------------------------------------------------------------
--
-- Method: TravelerFrame_FrameBan_ButtonUnBan_OnClick
-- Description: Called when the UnBan button is clicked
--
--------------------------------------------------------------------------------
function TravelerFrame_FrameBan_ButtonUnBan_OnClick()

	user = Traveler_GetValueByIndex(TravelerBanList, TravelerBanId);
	if(user) then

		Traveler_UnBan(user.Name);
		
		-- Reset the ban id
		--
		TravelerBanId = 0;
			
		-- Refresh the ban list
		--
		Traveler_FrameBan_Refresh();
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_UnBan
-- Description: Removes the supplied user from the ban list
-- Arguments:
--	name - [in] The name of the player to unban
--
--------------------------------------------------------------------------------
function Traveler_UnBan(name) 

	-- Remove the user from the ban list
	--
	if(TravelerBanList[name] ~= nil) then
		TravelerBanList[user.Name] = nil;
		TravelerBanList.Size = TravelerBanList.Size - 1;		
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_Ban
-- Description: Adds the supplied user to the ban list
-- Arguments:
--	name - [in] The name of the player to ban
--	raceIndex - [in] The raceIndex of the user to ban
--	gender - [in] The character specifying the gender of the user to ban
--
--------------------------------------------------------------------------------
function Traveler_Ban(name, raceIndex, gender)

	-- Add the player to the ban list
	--
	if(TravelerBanList[name] == nil) then
		TravelerBanList[name] = {};			
		TravelerBanList.Size = TravelerBanList.Size + 1;
	end
	
	TravelerBanList[name].Name = name;
	TravelerBanList[name].RaceIndex = raceIndex;
	TravelerBanList[name].Gender = gender;
			
	-- Remove the player from the customer list
	--
	if(TravelerCustomers[name] ~= nil) then
		TravelerCustomers[name] = nil;
		TravelerCustomers.Size = TravelerCustomers.Size - 1;
	end
	
	-- Remove the warlock from the destination list
	--
	if(TravelerSuppliers[name] ~= nil) then
		TravelerSuppliers[name] = nil;
		TravelerSuppliers.Size = TravelerSuppliers.Size - 1;
	end
	


end


--------------------------------------------------------------------------------
--
-- Method: Traveler_FrameBan_Refresh
-- Description: Refreshes the ban listbox.  It is called when users are removed
--	from the ban list and when they are added.
--
--------------------------------------------------------------------------------
function Traveler_FrameBan_Refresh()
	
	
	local button, buttonName, iconTexture;
	local offset = FauxScrollFrame_GetOffset(TravelerFrame_FrameBan_FrameScroll);
	local index;

	
	if(TravelerBanList.Size == 0) then		
		TravelerFrame_FrameBan_ButtonUnBan:Disable();	
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
		button = getglobal("TravelerFrame_FrameBan_ButtonBan"..i);
		-- Show or hide auction buttons
		if ( index > TravelerBanList.Size ) then
			button:Hide();
		else
		
			button:Show();
			buttonName = "TravelerFrame_FrameBan_ButtonBan"..i;
			
			local user = Traveler_GetValueByIndex(TravelerBanList, index);
						
			-- Resize button if there isn't a scrollbar
			buttonHighlight = getglobal("TravelerFrame_FrameBan_ButtonBan"..i.."Highlight");
			
			if ( TravelerBanList.Size < 8 ) then
				button:SetWidth(793);
				buttonHighlight:SetWidth(758);
				--BidBidSort:SetWidth(169);
			elseif ( TravelerBanList.Size == 8) then
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
			getglobal(buttonName.."_TextName"):SetText(user.Name);
			
			-- Set user picture
			--		
			iconTexture = getglobal(buttonName.."ItemIconTexture");										
			iconTexture:SetTexCoord(Traveler_GetTexCoordsForRaceGender(user.RaceIndex, user.Gender));
			
			-- Set highlight
			if ( TravelerBanId and index == TravelerBanId) then
				button:LockHighlight();				
			else
				button:UnlockHighlight();
			end
		end
	end

	-- Update scrollFrame
	FauxScrollFrame_Update(TravelerFrame_FrameBan_FrameScroll, TravelerBanList.Size, 8, 37);	
	
	
end


