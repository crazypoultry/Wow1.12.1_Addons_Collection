--[[--------------------------------------------------------------------------------
  ItemSyncCore Filter Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]


---------------------------------------------------
-- ISync:Filter_DD_SetSelectedID
---------------------------------------------------
function ISync:Filter_DD_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names[id].name, frame);
end



---------------------------------------------------
-- ISync:Filter_DD_Load
---------------------------------------------------
function ISync:Filter_DD_Load()

	--rarity
	UIDropDownMenu_Initialize(ISync_FilterPurgeRare_DropDown, ISync.Filter_DD_Initialize);
	ISync:Filter_DD_SetSelectedID(ISync_FilterPurgeRare_DropDown, 1, ISYNC_DD_RARITY);
	UIDropDownMenu_JustifyText("LEFT", ISync_FilterPurgeRare_DropDown)	
end




---------------------------------------------------
-- ISync:Filter_DD_Initialize
---------------------------------------------------
function ISync:Filter_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_RARITY), 1 do
		info = { };
		info.text = ISYNC_DD_RARITY[i].name;
		info.func = ISync.Filter_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end

end


---------------------------------------------------
-- ISync:Filter_DD_OnClick
---------------------------------------------------
function ISync:Filter_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_FilterPurgeRare_DropDown, this:GetID());
end



---------------------------------------------------
-- ISync:FilterPurge
---------------------------------------------------
function ISync:FilterPurge()
local storeRarity, sParseLink;

	--grab rarity
	if( ISYNC_DD_RARITY[UIDropDownMenu_GetSelectedID(ISync_FilterPurgeRare_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_RARITY[UIDropDownMenu_GetSelectedID(ISync_FilterPurgeRare_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				storeRarity = nil;
			else
				storeRarity = sortType;
			end
			
			
	end
	
	storeRarity = tonumber(storeRarity);
	
	if(storeRarity and ISyncDB and ISync_RealmNum and ISyncDB[ISync_RealmNum]) then
	
	
		ISyncOpt.ItemCount_Valid = 0; --reset
		
		--do the purge loop
		for index, value in ISyncDB[ISync_RealmNum] do

			if(ISync:GetData(index, "item") ) then
			
				--increase
				ISyncOpt.ItemCount_Valid = ISyncOpt.ItemCount_Valid + 1;
			
				--check link
				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, invType_X, icon_X  = GetItemInfo("item:"..ISync:GetData(index, "item") );

				if(name_X and link_X and quality_X) then
			
					--if it matches then delete it
					if(tonumber(storeRarity) == tonumber(quality_X) ) then

						ISyncDB[ISync_RealmNum][index] = nil; --delete it cause it matches
						
						--decrease
						ISyncOpt.ItemCount_Valid = ISyncOpt.ItemCount_Valid - 1;
					end

				else
					--do it the old fashion way
					if(ISync:GetData(index, "info")) then
					
						sParseLink = nil; --reset
						sParseLink = string.gsub(ISync:GetData(index, "info"), "^(.-):(.-):(.-):(.-):(.-):(.-):(.-):(.-):(.-):(.-)$", "%1");
						
						if(sParseLink and tonumber(sParseLink)) then
						
							--if it matches then delete it
							if(tonumber(storeRarity) == tonumber(sParseLink) ) then

								ISyncDB[ISync_RealmNum][index] = nil; --delete it cause it matches
								
								--decrease
								ISyncOpt.ItemCount_Valid = ISyncOpt.ItemCount_Valid - 1;
						
							end
					
						
						end
						
				
					end
					

				end--if(name_X and link_X and quality_X) then
				
				
			
			end--if(ISync:GetData(index, "item") ) then
			
	
		end--for index, value in ISyncDB[ISync_RealmNum] do
		
		
		--call a refresh
		ISync:Main_Refresh();
		ISync:ItemDisplay_Update();
		
		
		DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_FILTERPURGESUCCESS..".|r");
	
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_FILTERINVALIDSELECTION..".|r");
	
	end
	
	

end



---------------------------------------------------
--ISync:FilterPurgeInvalid
---------------------------------------------------
function ISync:FilterPurgeInvalid()

	--make sure we have stuff to work with duh
	if(not ISyncDB) then return nil; end
	if(not ISync_RealmNum) then return nil; end
	if(not ISyncDB[ISync_RealmNum]) then return nil; end
	
	local index, value;

	ISyncOpt.ItemCount_Valid = 0; --reset
	
	--do the loop
	for index, value in ISyncDB[ISync_RealmNum] do

		if(ISync:GetData(index, "item")) then
		
			ISyncOpt.ItemCount_Valid = ISyncOpt.ItemCount_Valid + 1; --increase
		
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..ISync:GetData(index, "item"));

			if(name_X and link_X) then

				--do nothing
			else
				ISyncDB[ISync_RealmNum][index] = nil; --delete the invalid item
				
				ISyncOpt.ItemCount_Valid = ISyncOpt.ItemCount_Valid - 1; --decrease
			end
		
		else
			--delete it, it has no array so it's invalid
			ISyncDB[ISync_RealmNum][index] = nil;
			
			ISyncOpt.ItemCount_Valid = ISyncOpt.ItemCount_Valid - 1; --decrease
		
		end

	end
	
	
	--call a refresh
	ISync:Main_Refresh();
	ISync:ItemDisplay_Update();

	DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_INVALIDPURGESUCCESS..".|r");

end



---------------------------------------------------
--ISync:Filter_MergeDB
---------------------------------------------------
function ISync:Filter_MergeDB()
	
	local ICountServ = 0;

	for ICountServ=0,ISyncOpt.RealmCount do
	
		--make sure it's not zero because zero is used a universal database number
		if(ICountServ ~= 0) then
		
			--make sure we have a database to work with
			if(ISyncDB and ISyncDB[ICountServ] and ISyncDB[0]) then
			
				for index, value in ISyncDB[ICountServ] do
				
					--now check to see if we have in the universal database, if we don't add it
					--if we do then delete from other server
					if(not ISyncDB[0][index]) then
						
						--add it to universal zero
						ISyncDB[0][index] = value;
						
						if(ISyncOpt) then
						
							ISyncOpt.ItemCount_Valid = ISyncOpt.ItemCount_Valid + 1;
							
						end
	
					end
					
				
				end
				
					--now delete it
					ISyncDB[ICountServ] = nil;
			end
		
		end
	
	end
	
	
	--update the display frame if shown
	if(ISyncOpt and ISyncOpt.ItemDisplay and ISync.ItemDisplay_Update) then
		ISync:ItemDisplay_Update();
	end
		
	
	DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_OPTIONS_SERVER_MERGECOMPLETE.."|r");
end




---------------------------------------------------
--ISync:ItemIDSearch
--
--Special thanks to Bastian Pflieger the creator of ItemMagic whoms code resides below 
---------------------------------------------------
function ISync:ItemIDSearch()

	local _, _, userLink = string.find(ISync_ItemIDFrameEdit:GetText(), "(%d+:?%d*:?%d*:?%d*)");


	if userLink then

		local isInLocalDatabase = GetItemInfo("item:" .. userLink);

			if isInLocalDatabase then
			
				UIParent.TooltipButton = 1;
				GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
				GameTooltip:SetHyperlink("item:" .. userLink);
				GameTooltip:Hide();
				
			else
				UIParent.TooltipButton = 1;
				GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
				GameTooltip:SetHyperlink("item:" .. userLink);
				GameTooltip:Hide();
			
			end
			
			
			--Grab it again and display appropriate msg
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:" .. userLink);
				
			
			if(name_X and link_X and quality_X) then

				--grab the color using the CheckColor routine
				local useColor = ISync:CheckColor(nil, tonumber(quality_X), 2)

					
				--add it if we don't have it
				if (link_X and quality_X and name_X and not ISyncDB[ISync_RealmNum][name_X] and ISync:CheckFilter(quality_X) == 1) then

					----------------------------------
					--we don't need to check on CheckColor because we have the quality num already
					--the reason it's sent to CheckColor is to update any errors in the color pattern
					----------------------------------

					local sParseLink = ISync:GetItemID(link_X);
					
					if(sParseLink) then
					
						--add it
						ISync:SetData(name_X, "item", sParseLink);
						ISync:SetData(name_X, "quality", quality_X);
						ISync:SetData(name_X, "idchk", 1); --mark as user added it himself to show green button


						--PARSE TOOLTIP FOR SEARCH OPTIONS
						if(ISync.ParseTooltip) then
							UIParent.TooltipButton = 1;
							ISyncTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
							ISyncTooltip:SetHyperlink(link_X);
							ISync:ParseTooltip(name_X, ISync_RealmNum, sParseLink);
							ISyncTooltip:Hide();
						end
						
					
					end
					
					
				--warning
				elseif(link_X and name_X and quality_X) then
				
					if(ISync:GetData(name_X, "item")) then
						
							--get the itemid
							local sParseLink = ISync:GetItemID(link_X);
						
							--if the link doesn't match then update it
							if(sParseLink and ISync:GetData(name_X, "item") ~= sParseLink) then
							
								--update it cause it doesn't match
								ISync:SetData(name_X, "item", sParseLink);
								
								--parse the tooltip
								if(sParseLink) then

									--PARSE TOOLTIP FOR SEARCH OPTIONS
									if(ISync.ParseTooltip) then
										UIParent.TooltipButton = 1;
										ISyncTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
										ISyncTooltip:SetHyperlink(link_X);
										ISync:ParseTooltip(name_X, ISync_RealmNum, sParseLink);
										ISyncTooltip:Hide();
									end


								end
								
						
							end
							
							
							
						
					else
					

						if(quality_X and link_X and name_X) then
						
							--get the itemid
							local sParseLink = ISync:GetItemID(link_X);

							if(sParseLink) then
							
								--add it
								ISync:SetData(name_X, "item", sParseLink);
								ISync:SetData(name_X, "quality", quality_X);


								--PARSE TOOLTIP FOR SEARCH OPTIONS
								if(ISync.ParseTooltip) then
									UIParent.TooltipButton = 1;
									ISyncTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
									ISyncTooltip:SetHyperlink(link_X);
									ISync:ParseTooltip(name_X, ISync_RealmNum, sParseLink);
									ISyncTooltip:Hide();
								end
								
							end--if(sParseLink) then

						end--if(quality_X and link_X and name_X) then
					
					
					end--if(ISync:GetData(name_X, "item")) then
					
					
				end--if (link_X and quality_X and name_X and not ISyncDB[ISync_RealmNum][name_X] and ISync:CheckFilter(quality_X) == 1) then
				
				
				--now show it if we haven't disconnected yet
				DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..name_X.." <<>> |r|c"..useColor.."|H"..link_X.."|h["..name_X.."]|h|r");
			

			
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: No Item");
				
			end--if(name_X and link_X and quality_X) then
			

	end

	ISync_ItemIDFrameEdit:SetText(""); --reset

end

