--Feed a Selected Food to pet
function SmartPet_Feed()

	if (SmartPet_FindFood()) then 
		CastSpellByName(SMARTPET_SPELLS_FEEDPET);
		if (SpellIsTargeting()) then
			PickupContainerItem(SmartPet_Config.Food.bag, SmartPet_Config.Food.slot);
		end
	else
		msg = string.gsub(SMARTPET_FOOD_NOFOOD, '%%f', SmartPet_Config.Food.name);
		msg = string.gsub(msg, '%%n', UnitName("pet"));
		UIErrorsFrame:AddMessage(msg, 1, 0, 0, 1.0, UIERRORS_HOLD_TIME);
		return;
	end

end

function SmartPet_ToggleAutoFeed()
	if (SmartPet_Config.AutoFeed) then
		SmartPet_Config.AutoFeed = false;
		SmartPet_AddInfoMessage(SMARTPET_COMMANDS_AUTOFEED_DISABLED);
	else
		SmartPet_Config.AutoFeed = true;
		SmartPet_AddInfoMessage(SMARTPET_COMMANDS_AUTOFEED_ENABLED);
	end
end

function SmartPet_GetFoodItemInfo()
	return SmartPet_GetContainerItemInfo(SmartPet_Config.Food.bag, SmartPet_Config.Food.slot);
end

function SmartPet_GetCursorItemInfo()
	return SmartPet_GetContainerItemInfo(SmartPet_Vars.CursorItem.bag, SmartPet_Vars.CursorItem.slot);
end

function SmartPet_GetContainerItemInfo(bag, slot)
	if (slot == 0) then return end;
	local link = GetContainerItemLink(bag, slot);
	if (not link) then return end;
	local _, _, itemID = string.find(link, "(item:.-)|");
	local name, _, _, _, type, _, _, _, texture = GetItemInfo(itemID);
	return name, itemID, type, texture;
end

function SmartPet_ClearSelectedFood()
	SmartPet_Config.Food = { bag = 0, slot = 0, name = "", texture = ""};
end

function SmartPet_ClearCursorItem()
	SmartPet_Vars.CursorItem = { bag = 0, slot = 0 };
end

function SmartPet_SetCursorItemAsFood()
	local name, itemID, type, texture = SmartPet_GetCursorItemInfo();

	if (name ~= nil and type == SMARTPET_FOOD_TYPESTRING and SmartPet_IsFood(itemID)) then
		SmartPet_Config.Food = { slot = SmartPet_Vars.CursorItem.slot,
					 bag = SmartPet_Vars.CursorItem.bag,
					 name = name,
					 texture = texture };
		SmartPet_ClearCursorItem();
		return true;
	end
	return false;
end

function SmartPet_IsFood(itemID)
	SmartPetFeedTip:ClearLines();
	SmartPetFeedTip:SetHyperlink(itemID);
	local i = 1;
	local description;
	while i do
		description = getglobal("SmartPetFeedTipTextLeft"..i);
		if (not description) then break end;
		local line = description:GetText();
		if (not line) then break else
			if (string.find(line, SMARTPET_FOOD_SEARCHSTRING)) then
				SmartPet_AddDebugMessage("Selected item is a Food", "food");
				return true;
			end
		end
		i=i+1;	
	end
	SmartPet_AddDebugMessage("Selected item is NOT a Food", "food");
	return false;
end

function SmartPet_FindFood()
	local name = SmartPet_GetFoodItemInfo();

	-- Check if saved food slot in the bag is still the same item, otherwise, iterate over the other bag slots to find items with the same name.
	if (name == SmartPet_Config.Food.name) then
		return true;
	else
 		for bag = 0, 4 do
 			for slot = 1, GetContainerNumSlots(bag) do
 				if (SmartPet_Config.Food.name == SmartPet_GetContainerItemInfo(bag, slot)) then
					SmartPet_Config.Food.bag = bag;
					SmartPet_Config.Food.slot = slot;
 					return true;
 				end
 			end
 		end
	end
	return false;
end
