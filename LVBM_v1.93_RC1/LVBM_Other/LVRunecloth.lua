--
-- Auto Return of Reputation v0.2
--

LVBM.AddOns.Runecloth = { 
	["Name"] = LVBM_RUNECLOTH_NAME, 
	["Abbreviation1"] = "runecloth", 
	["Version"] = "0.2", 
	["Author"] = "Nitram",
	["Description"] = LVBM_RUNECLOTH_DESCRIPTION,
	["Instance"] = LVBM_OTHER,
	["GUITab"] = LVBMGUI_TAB_OTHER,
	["Sort"] = 0,
	["Options"] = {
		["Enabled"] = false, 
		["Announce"] = false, 
	}, 
	["Events"] = {
		["GOSSIP_SHOW"] = true, 	-- Turn In
		["QUEST_PROGRESS"] = true, 	-- Turn In
		["QUEST_COMPLETE"] = true, 	-- Turn In
	}, 	
	["GetItemName"] = function(bag,  slot)
		local itemlink;
		if (bag == -1) then	itemlink = GetInventoryItemLink("player",  slot);
		else			itemlink = GetContainerItemLink(bag,  slot);
		end
		if (itemlink) then
			local _,  _,  name = string.find(itemlink,  "^.*%[(.*)%].*$");
			return name;
		else	return "";
		end
	end, 
	["GetItemCount"] = function(ItemName)
		local anzl,  bagNr,  bagSlot = 0;
		for bagNr = 0,  10,  1 do
			for bagSlot = 1,  GetContainerNumSlots(bagNr),  1 do
				if( LVBM.AddOns.Runecloth.GetItemName(bagNr,  bagSlot) == ItemName) then
					local _,  itemCount = GetContainerItemInfo(bagNr,  bagSlot);
					anzl = anzl + itemCount;
				end
			end
		end
		return anzl;
	end, 
	["OnEvent"] = function(event,  arg1)
		local target = UnitName("target");
		if (event == "GOSSIP_SHOW") then
			if (target == LVBM_RAEDONDUSKSTRIKER		-- Darnassus Cloth Quartermaster
			 or target == LVBM_CLAVICUSKNAVINGHAM		-- Stormwind Cloth Quartermaster
			 or target == LVBM_BUBULOACERBUS		-- Gnomeregan Cloth Quartermaster
			 or target == LVBM_MISTINASTEELSHIELD) then	-- Ironforge Cloth Quartermaster

				if (LVBM.AddOns.Runecloth.GetItemCount(LVBM_RUNECLOTH_NAME) >= 20) then SelectGossipAvailableQuest(1);	end
			end
		end
		if (event=="QUEST_PROGRESS") then
			if (target == LVBM_RAEDONDUSKSTRIKER 
			  or target == LVBM_CLAVICUSKNAVINGHAM
			  or target == LVBM_BUBULOACERBUS
			  or target == LVBM_MISTINASTEELSHIELD) then

			 	 if( LVBM.AddOns.Runecloth.GetItemCount(LVBM_RUNECLOTH_NAME) == 0) then return; end

				CompleteQuest();
			end
		end
		if (event=="QUEST_COMPLETE") then
			if (target == LVBM_RAEDONDUSKSTRIKER
			 or target == LVBM_CLAVICUSKNAVINGHAM
			 or target == LVBM_BUBULOACERBUS
			 or target == LVBM_MISTINASTEELSHIELD) then

				GetQuestReward(0);
				LVBM.AddMsg(LVBM_RUNECLOTH_THANKS);
			end
		end
	end,
};


