-------------------------------------------------------------------------------------------------------
--
--	SortEnchant Mod - By Guvante
--
--	v2.00
--
--  I really really need to get around to commenting this thing properly :P
--
-------------------------------------------------------------------------------------------------------

local VersionNumber = "v2.00";

--This table stores the temporary data for all enchantments for the program
--It is indexed primarily by sequental ints, which is why the insert and remove functions are sort cutted
--These ints define the order of the items as they appear in the enchanting window, and are accessed as such
--The table is also indexed by the string of each item, in order to store such information as hidden, original, etc.
SortEnchant_Data = { n=0, insert=table.insert, remove=table.remove };

--New version of sorting function, much more streamlined
--Set up data table whenever the total number of items is requested
--Parameter: override - Allows the bypassing of total check, thereby forcing a table rebuild
function SortEnchant_GetNum(override)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origGetNum(); end
	
	--Do not rebuild the table unless we have more items, it has not been built, or we are requesting a rebuild specifically
	if  not override and SortEnchant_Data and (SortEnchant_origGetNum() == SortEnchant_Data.lastMax) then
		return SortEnchant_Data.n;
	end
	local finalData = {n=0, insert=table.insert, remove=table.remove};
	
	--tempData is the four tier data that I use to build the basics of the Data in, it is not stored once we are out of the function
	--Tier 1:
	--  This tier is indexed by string, and refers to a table name, be it armor, or type, or whatever
	--  This tier is set up right after the Misc variable is created at the start of the custom function that is run using the foreach
	--Tier 2:
	--  This tier is index by int, but not sequentially, ie, a table may have include indexes 1,4,7,10,11, without there being a problem
	--  These int's represent values in the Show table, and are left in this form to speed up the algorith, as the int's and string are equivalent anyway
	--Tier 3:
	--  This tier is indexed by sequential ints, and is thereby set up with a value for n and insert, there are multiple values, so a table is built
	--  This table is also indexed by string, in order to allow future checking for the drop down boxes, the string is the full name of the enchantment
	--Tier 4:
	--  Only present in the sequentially indexed items in tier 3, holds the original number from the enchanting window,
	--  As well as the three values grabbed by the parser
	local tempData;

        --Check to see if our cached values are still there, if they are, assume they can be reused (We _should_ be niling this table if it becomes invalid)
	if not override and SortEnchant_Data and SortEnchant_Data.tempData and (SortEnchant_origGetNum() == SortEnchant_Data.lastMax) then
		tempData = SortEnchant_Data.tempData;
	else
	        tempData = {};
	end
	
	for tableName, theTable in pairs(SortEnchant_Search) do
		if type(theTable) == "table" then
			--This creates the table in the main index, avoiding any nil errors in later parts
			if not tempData[tableName] then
				tempData[tableName] = {}; --Indexed by non sequential ints, thus, insert, n, and remove are not needed
			end

			for i=1, SortEnchant_origGetNum() do
				--Grab the name of the 
				local craftName = SortEnchant_origGetInfo(i);

				--These may be in a different order depending on the local, but we simply search from left to right
				--In either case, hopefully this will not cause a problem
				local Armor = gsub(craftName, SortEnchant_SearchString, "%1"); --Holds the armor
				local Power = gsub(craftName, SortEnchant_SearchString, "%2"); --Holds the power, or in some cases, the type
				local Type  = gsub(craftName, SortEnchant_SearchString, "%3"); --Holds the actual type
				
				--The or statement goes from left to right, assigning it to the first non-nil return value
				--Therefor, this checks each of the possible values against the 
				local matchType = theTable[Value] or theTable[Value2] or theTable[Value3] or theTable[""];

				--If the table for this type of item does not exist yet, create a new one
				if not tempData[tableName][matchType] then
					tempData[tableName][matchType] = { n=0, insert=table.insert };
				end

				--This is used to get the real data for the item, as well as its parsed sections
				tempData[tableName][Type]:insert({
								     ["orignal"]=i;
								     [1] = Armor;
								     [2] = Power;
								     [3] = Type;
								 });
				--This puts it in order for when this type is selected in the drop down
				tempData[tableName][Type][craftName] = true;
			end
		elseif type(theTable) == "function" then
			local funcName, theFunc = tableName, theTable; --Because these names makes more sense, func is short for function
			tempData[funcName] = {}; --Clear the table that holds data for this item

			for i=1, SortEnchant_origGetNun() do
				local id = theFunc(i);
				if not tempData[funcName][id] then
					tempData[funcName][id] = { 
									["n"] = 0;
									["insert"] = table.insert; 
								};
				end
				tempData[funcName][id]:insert(i);
				tempData[funcName][id][SortEnchant_origGetInfo(i)] = true;
			end --For loop
		end --if statement
	end --For loop
	
	for tableId, fullTable in pairs(tempData[SortEnchant_Master.Type]) do
		local dispName = SortEnchant_Show[SortEnchant_Master.Type][tableId];
		local tablePopulated = false;
		local tableExpanded = (not SortEnchant_AllCollapsed) and SortEnchant_Data[dispName].isExpanded;
		newData:insert({
					["craftName"] = dispName;
					["craftSubSpellName"] = "";
					["craftType"] = "header";
					["numAvailable"] = 0;
					["isExpanded"] = tableExpanded;
					["trainingPointCost"] = 0;
					["requiredLevel"] = 0;

					--These are the numerical equivalents of the above, for the unpack function
					[1] = dispName;
					[2] = "";
					[3] = "header";
					[4] = 0;
					[5] = tableExpanded;
					[6] = 0;
					[7] = 0;
					["n"] = 7;
				});

		--Allows to look up and store a groups expanded status by name
		newData[dispName] = {
				["isExpanded"] = SortEnchant_Data[dispName].isExpanded;
			};

		--Even is there is no header, we need to loop through and set all of the hidden properties
		for j=1, fullTable.n do
			--Get the data for this item
			local craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = SortEnchant_origGetInfo(fullTable[j].id);

			--Local variable to make my code prettier :P, this lets me use multiple if statements to check the displayability of the current selection
			--These could be done in a single if statement, but it would be ugly
			local contOk = false;

			--Ensure it meets the type values
			if SortEnchant_Master.Grey and craftType == "trivial" then
				contOk = false;
			end

			--Ensure it is part of the drop downs, note that Selected returns strings for the name of the type, while SelectedID returns the index
			if SortEnchant_DropDownSelectedID[SortEnchant_Armor_C] ~= 0 then
				if not tempData[SortEnchant_Armor_C][SortEnchant_DropDownSelected[SortEnchant_Armor_C]][craftName] then
					contOk = false;
				end
			end
			if SortEnchant_DropDownSelectedID[SortEnchant_Type_C] ~= 0 then
				if not tempData[SortEnchant_Armor_C][SortEnchant_DropDownSelected[SortEnchant_Armor_C]][craftName] then
					contOk = false;
				end
			end

			--Only insert it if it has cleared the checks
			if contOk then
				tablePopulated = true;
				--If the table is not expanded, then don't add the items
				if tableExpanded then
					--As it appears in the enchantment window
					newData:insert({
								--Note that I use the [""] syntax in this group to better differentiate between the literals and the variables
								["craftName"] = craftName;
								["craftSubSpellName"] = craftSubSpellName;
								["craftType"] = craftType;
								["numAvailable"] = numAvailable,;
								["isExpanded"] = isExpanded;
								["trainingPointCost"] = trainingPointCost;
								["requiredLevel"] = requiredLevel;
								["original"] = fullTable[j].id; --This is used by my prog, very frequently, so two ways of accessing

								--The unpack function takes [1] through [n], so here we define the same variables again for it
								[1] = craftName;
								[2] = craftSubSpellName;
								[3] = craftType;
								[4] = numAvailible;
								[5] = isExpanded;
								[6] = trainingPointCost;
								[7] = requiredLevel;
								["n"] = 7;
							});

					--Data for my program
					newData[craftName] = {
								["original"] = fullTable[j].id;	--Used for reverse lookup back to index that the game recognizes
								["backward"] = SortEnchant_Data.n;	--Last item on the list has the same number as the total number of items
												--Note that this is used to find my own number for a named item

								["val1"] = fullTable[j].Value1;	--These are used to build the shortened names without having to reparse :P
								["val2"] = fullTable[j].Value2;	--And yes I realize this increases the amount of memory stored, but I am trying to maximize performance
								["val3"] = fullTable[j].Value3
							};
				else
					break; --If the table is not expanded, then we only need to insure that there is at least one item really in it before continuing with the next group
				end
			end
		end

		--If the header has no actual data, remove it
		if not tablePopulated then
			newData:remove();
			newData[dispName] = nil;
		end
	end --For loop
	newData.tempData = tempData;
	SortEnchant_Data = newData;
end

--Subsitute original data with new data from table
function SortEnchant_GetInfo(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origGetInfo(id); end
	
	if not SortEnchant_Data then SortEnchant_GetNum(); end --Ensures we don't get a nil indexing error
	
	--This function returns all of the integer indexed items in the selected table
	--Note that it is a sub table we are expanding, not SortEnchant_Data itself
	return unpack(SortEnchant_Data[id]);
end


--Ensure that selection is properly maintained when collapsing and expanding things
function SortEnchant_ConfirmSelection()
	if not SortEnchant_TrueSelected then
		if not SortEnchant_Selected or SortEnchant_Selected==0 then return; end --Ensures that we have something selected, if not, then this does not matter, and it would error out anyways :P
		local tempName = SortEnchant_Data[SortEnchant_Selected].craftName;
		local tempTable = SortEnchant_Data[tempName];
		local tempNum = tempTable.original;
		SortEnchant_GetNum(true); --Resets the table, with new selection options
		if SortEnchant_Data[tempName] then
			--Ensure selection is correct
			CraftFrame_SetSelection(SortEnchant_Data[tempName].backward);
		else --It is no longer in the list, so is therefore hidden
			SortEnchant_TrueSelected = {
				craftName = tempName;
				id = tempNum;
				val1 = tempTable.val1;
				val2 = tempTable.val2;
				val3 = tempTable.val3
			}
		end
	else
		SortEnchant_GetNum(true); --Resets the table, with new selection options
		if SortEnchant_Data[SortEnchant_TrueSelected.craftName] then
			--Select it again, now that it is visible
			CraftFrame_SetSelection(SortEnchant_Data[SortEnchant_TrueSelected.craftName].backward);
		end
	end
end

--Expand or Collapse a group, or all groups
function SortEnchant_Expand(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origExpand(id);	end
	
	if not SortEnchant_Data then SortEnchant_GetNum(); end --We know we want new values
	
	SortEnchant_AllCollapsed = nil; --Reset "all collapsed" value, as they are definatly not all collapsed now
	if id == 0 then
		SortEnchant_AllExpanded = true;
	else
		SortEnchant_Data[SortEnchant_Data[id].craftName] = nil;
	end

	SortEnchant_ConfirmSelection();
	CraftFrame_Update(); --Causes window to be refreshed
end

function SortEnchant_Collapse(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origTradeCollapse(id); end
	
	if not SortEnchant_Data then SortEnchant_GetNum(); end
	
	SortEnchant_AllExpanded = nil;
	if id == 0 then
		SortEnchant_AllCollapsed = true;
	else
		SortEnchant_Data[SortEnchant_Data[id].craftName] = true;
	end
	SortEnchant_ConfirmSelection();
	CraftFrame_Update(); --Causes window to be refreshed
end


--Overlay these functions due to having a larger barrier for a range
function SortEnchant_SelectCraft(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origSelectCraft(id); end
	SortEnchant_Selected = id;
	SortEnchant_TrueSelected = nil;
	return id;
end
--Note that this ignores TrueSelected, as all elements that use TrueSelected skip this function
function SortEnchant_GetIndex()
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or (not SortEnchant_Selected) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origGetIndex(); end
	return SortEnchant_Selected;
end


--This catches the on event function to hide the UI elements outside of the Enchanting menu
function SortEnchant_CFOnEvent()
	if ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) or (not SortEnchant_Master or not SortEnchant_Master.Enabled) then
		SortEnchant_ArmorDropDown:Hide(); SortEnchant_TypeDropDown:Hide();
		SortEnchant_EnableButton:Hide(); SortEnchant_TypeButton:Hide(); SortEnchant_GreyButton:Hide();
	else
		SortEnchant_ArmorDropDown:Show(); SortEnchant_TypeDropDown:Show();
		SortEnchant_EnableButton:Show(); SortEnchant_TypeButton:Show(); SortEnchant_GreyButton:Show();
	end
	SortEnchant_origOnEvent();
end


--Offseting functions
function SortEnchant_DoCraft(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origDoCraft(id); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origDoCraft(SortEnchant_TrueSelected);
	end
	return SortEnchant_origDoCraft(SortEnchant_Data[id].original);
end

function SortEnchant_ToolItem(obj, id, reagId)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origToolItem(obj, id, reagId); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origToolItem(obj, SortEnchant_TrueSelected, reagId);
	end
	return SortEnchant_origToolItem(obj, SortEnchant_Data[id].orginal, reagId);
end

function SortEnchant_ToolSpell(obj, id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origToolSpell(obj, id); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origToolSpell(obj, SortEnchant_TrueSelected);
	end
	return SortEnchant_origToolSpell(obj, SortEnchant_Data[id].orginal);
end

function SortEnchant_GetSubString(from, id)
	local i = 0;
	for v in string.gfind(from, "[^%;]+") do
		i = i + 1;
		if i == id then
			return v;
		end
	end
	return nil; --Wasn't found
end

function SortEnchant_NewLinkItem(vals)
	local armor, val1, val2 = vals.val1, vals.val2, vals.val3;
	local value = SortEnchant_Values[val1] or 5;
	local type;
	if val2 == "" then type = val1; else type = val2; end

end

--To preserve uniformity, and make it easy to revert
--Note that this needs to be reworked _from scratch_ once I am done with the new sorting algoritms
function SortEnchant_NewLinkItem(id)
	if not SortEnchant_Master.ShortenNames then
		return (SortEnchant_origGetInfo(id));
	end

	local ret = SortEnchant_origGetInfo(id);
	local armor;
	local retain;
	local offset;
	local dummy1, dummy2; --I don't care where they are in the string
	
	dummy1, dummy2, armor, ret = string.find(ret, SortEnchant_SearchString); --Enchant Armor - Type
	armor = string.sub(armor, 0, string.len(armor) - 1);
	
	--"Default" values
	if string.find(ret, SortEnchant_Minor) then
		val = 1;
		offset = 7;
	elseif string.find(ret, SortEnchant_Lesser) then
		val = 3;
		offset = 8;
	elseif string.find(ret, SortEnchant_Greater) then
		val = 7;
		offset = 9;
	elseif string.find(ret, SortEnchant_Superior) then
		val = 9;
		offset = 10;
	elseif string.find(ret, SortEnchant_Major) then
		val = 20;
		offset = 7;
	elseif string.find(ret, SortEnchant_Advanced) then
		val = 2; --Dummy value for later
		offset = 10;
	else --Normal
		val = 5;
		offset = 0;
	end
	
	--Modify as necessary
	if string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][9], 3)) then
		if armor == SortEnchant_Master.Search[SortEnchant_Armor_C][7] then
			val = val * 10;
		else
			val = (math.floor(val / 2) + 1) * 10;
		end
		ret = SortEnchant_Armor_Show;
		retain = true;
	elseif string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][6]) then
		val = val * 5;
		if val == 45 then
			val = 50;
		end
	elseif string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][7]) then
		if val == 1 then
			val = 5;
		elseif val == 3 then
			val = 20;
		elseif val == 5 then
			val = 20;
		elseif val == 7 then
			val = 50;
		elseif val == 9 then
			val = 65;
		elseif val == 20 then
			val = 100;
		end
	elseif string.find(ret, SortEnchant_Major) then --Don't ask me why the 2H Weapons don't match the pattern, this should be superior
		val = 9;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][14], 1)) or
			string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][14], 2)) or
			string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][14], 4)) then
		if val == 2 then
			val = 5;
		else
			val = 2;
		end
	elseif string.find(ret, SortEnchant_Resist.Fire.Search) then
		val = val + 2; --Lesser = 5, Normal = 7
		ret = SortEnchant_Resist.Fire.Show;
		retain = true;
	elseif string.find(ret, SortEnchant_Resist.Shadow.Search) then
		val = 10; -- Lesser = 10
		ret = SortEnchant_Resist.Shadow.Show;
		retain = true;
	elseif string.find(ret, SortEnchant_Resist.Frost.Search) then
		val = 8; -- Normal = 8
		ret = SortEnchant_Resist.Frost.Show;
		retain = true;
	elseif string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][10]) then
		val = math.floor(val / 2) + 1;
		ret = SortEnchant_Resist_All;
		retain = true;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][9], 4)) then --Don't give these a number, they are odd
		val = 0;
		retain = true;
	elseif string.find(ret, SortEnchant_Minor_Impact) then
		val = 2;
		ret = SortEnchant_Master.Show[SortEnchant_Type_C][11];
		retain = true;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][11], 1)) then
		ret = SortEnchant_Master.Show[SortEnchant_Type_C][11];
		retain = true;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][11], 2)) then
		val = math.floor(val / 2) + 1;
		armor = SortEnchant_1H_Weapon;
		ret = SortEnchant_Master.Show[SortEnchant_Type_C][11];
		retain = true;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][12], 1)) then
		val = val * 2; --Minor = 2, Lesser = 6
	elseif string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][8]) then
		val = math.floor(val / 2) + 1;
		ret = SortEnchant_All_Stats;
		retain = true;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][9], 1)) then
		val = math.floor(val / 2) + 1;
		ret = SortEnchant_Defense_Skill;
		retain = true;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][9], 2)) then
		if val == 5 then
			val = 30;
		elseif val == 7 then
			val = 50;
		else
			val = 70;
		end
		ret = SortEnchant_Armor_Show;
		retain = true;
	elseif string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][1]) or string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][2]) or
			string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][3]) or string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][4]) or
			string.find(ret, SortEnchant_Master.Search[SortEnchant_Type_C][5]) then
		--Do nothing
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][14], 7)) then
		val = val .. "%";
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][14], 6)) then
		val = 0;
		retain = true;
	elseif string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][14], 3)) or
			string.find(ret, SortEnchant_GetSubString(SortEnchant_Master.Search[SortEnchant_Type_C][14], 5)) then
		val = 0;
	else --For now
		val = 0;
		armor = nil;
		retain = true;
	end
	
	if not retain then
		ret = string.sub(ret, offset);
	end
	
	if val ~= 0 then
		if armor then
			return "+" .. val .. " " .. ret .. "(" .. armor .. ")";
		else
			return "+" .. val .. " " .. ret;
		end
	else
		if armor then
			return ret .. "(" .. armor .. ")";
		else
			return ret;
		end
	end
end

function SortEnchant_LinkItem(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origLinkItem(id); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		local link = SortEnchant_origLinkItem(SortEnchant_TrueSelected.id);
		return link or SortEnchant_NewLinkItem(SortEnchant_TrueSelected); --1 Means use TrueSelected
	end
	
	--This function does not return anything if it does not have a link, requiring a temporary variable to figure it out
	local link = SortEnchant_origLinkItem(SortEnchant_Data[id].original);
	return link or SortEnchant_NewLinkItem(SortEnchant_Data[SortEnchant_Data[id].craftName]);
end

function SortEnchant_LinkReag(id, reagId)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origLinkReag(id, reagId); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origLinkReag(SortEnchant_TrueSelected, reagId);
	end
	
	return SortEnchant_origLinkReag(SortEnchant_Data[id].original, reagId);
end

function SortEnchant_Icon(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origIcon(id); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origIcon(SortEnchant_TrueSelected);
	end
	return SortEnchant_origIcon(SortEnchant_Data[id].orginal);
end

function SortEnchant_Desc(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origDesc(id); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origDesc(SortEnchant_TrueSelected);
	end
	return SortEnchant_origDesc(SortEnchant_Data[id].orginal);
end

function SortEnchant_NumReag(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origNumReag(id); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origNumReag(SortEnchant_TrueSelected);
	end
	return SortEnchant_origNumReag(SortEnchant_Data[id].orginal);
end

function SortEnchant_ReagInfo(id, reagId)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origReagInfo(id, reagId); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origReagInfo(SortEnchant_TrueSelected, reagId);
	end
	return SortEnchant_origReagInfo(SortEnchant_Data[id].orginal, reagId);
end

function SortEnchant_SpellFocus(id)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origSpellFocus(id); end
	
	if not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	
	if SortEnchant_TrueSelected then
		return SortEnchant_origSpellFocus(SortEnchant_TrueSelected);
	end
	return SortEnchant_origSpellFocus(SortEnchant_Data[id].orginal);
end

--Blizzard code is calling the wrong function
function SortEnchant_AllButton()
	if (this:GetName() ~= "CraftCollapseAllButton") or (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origAllButton(); end
	return CraftCollapseAllButton_OnClick();
end



--UI Controls
function SortEnchant_TypeDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, SortEnchant_TypeDropDown_Initialize);
	UIDropDownMenu_SetWidth(120);
	UIDropDownMenu_SetSelectedID(SortEnchant_TypeDropDown, 1);
end

function SortEnchant_TypeDropDown_OnShow()
	UIDropDownMenu_Initialize(this, SortEnchant_TypeDropDown_Initialize);
	if SortEnchant_DropDownSelectedID[SortEnchant_Type_C] > 0 then
		UIDropDownMenu_SetSelectedID(SortEnchant_TypeDropDown, SortEnchant_DropDownSelectedID[SortEnchant_Type_C]);
	else
		UIDropDownMenu_SetSelectedID(SortEnchant_TypeDropDown, 1);
	end
end

function SortEnchant_TypeDropDown_Initialize()
	if SortEnchant_Master and not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	local info = {};
	info.text = SortEnchant_DropDown_Type;
	info.func = SortEnchant_TypeDropDownButton_OnClick;
	info.checked = not SortEnchant_DropDownSelected;
	UIDropDownMenu_AddButton(info);
	
	local checked;
	for i=1, SortEnchant_DefaultShow[SortEnchant_Type_C].n, 1 do
		if SortEnchant_DropDownSelected then
			checked = (SortEnchant_DropDownSelected[SortEnchant_Type_C] == SortEnchant_DefaultShow[SortEnchant_Type_C][i]);
		else
			checked = nil;
		end
		if ( checked ) then
			UIDropDownMenu_SetText(SortEnchant_DefaultShow[SortEnchant_Type_C][i], SortEnchant_TypeDropDown);
		end
		info = {};
		info.text = SortEnchant_DefaultShow[SortEnchant_Type_C][i];
		info.func = SortEnchant_TypeDropDownButton_OnClick;
		info.checked = checked;
		if info.text ~= nil then
			UIDropDownMenu_AddButton(info);
		end
	end
end

function SortEnchant_ArmorDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, SortEnchant_ArmorDropDown_Initialize);
	UIDropDownMenu_SetWidth(120);
	UIDropDownMenu_SetSelectedID(SortEnchant_ArmorDropDown, 1);
end

function SortEnchant_ArmorDropDown_OnShow()
	UIDropDownMenu_Initialize(this, SortEnchant_ArmorDropDown_Initialize);
	if SortEnchant_DropDownSelectedID[SortEnchant_Armor_C] > 0 then
		UIDropDownMenu_SetSelectedID(SortEnchant_ArmorDropDown, SortEnchant_DropDownSelectedID[SortEnchant_Armor_C]);
	else
		UIDropDownMenu_SetSelectedID(SortEnchant_ArmorDropDown, 1);
	end
end

function SortEnchant_ArmorDropDown_Initialize()
	if SortEnchant_Master and not SortEnchant_Data then
		SortEnchant_GetNum();
	end
	SortEnchant_FilterFrame_LoadArmors();
end

function SortEnchant_FilterFrame_LoadArmors()
	local info = {}
	info.text = SortEnchant_DropDown_Armor;
	info.func = SortEnchant_ArmorDropDownButton_OnClick;
	info.checked = not SortEnchant_DropDownSelected;
	UIDropDownMenu_AddButton(info);
	
	local checked;
	for i=1, SortEnchant_DefaultShow[SortEnchant_Armor_C].n, 1 do
		if SortEnchant_DropDownSelected then
			checked = (SortEnchant_DropDownSelected[SortEnchant_Armor_C] == SortEnchant_DefaultShow[SortEnchant_Armor_C][i]);
		else
			checked = nil;
		end
		if ( checked ) then
			UIDropDownMenu_SetText(SortEnchant_DefaultShow[SortEnchant_Armor_C][i], SortEnchant_ArmorDropDown);
		end
		info = {};
		info.text = SortEnchant_DefaultShow[SortEnchant_Armor_C][i];
		info.func = SortEnchant_ArmorDropDownButton_OnClick;
		info.checked = checked;
		if info.text ~= nil then
			UIDropDownMenu_AddButton(info);
		end
	end
end

function SortEnchant_TypeDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(SortEnchant_TypeDropDown, this:GetID());
	SortEnchant_DropDownSelected[SortEnchant_Type_C] = this:GetText();
	SortEnchant_DropDownSelectedID[SortEnchant_Type_C] = this:GetID();
	--Reset the selection
	if SortEnchant_GetNum() > 1 then
		CraftFrame_SetSelection(2);
	end
	if CraftFrame:IsVisible() then CraftFrame_Update(); end
end

function SortEnchant_ArmorDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(SortEnchant_ArmorDropDown, this:GetID())
	SortEnchant_DropDownSelected[SortEnchant_Armor_C] = this:GetText();
	SortEnchant_DropDownSelectedID[SortEnchant_Armor_C] = this:GetID();
	--Reset the selection
	if SortEnchant_GetNum() > 1 then
		CraftFrame_SetSelection(2);
	end
	if CraftFrame:IsVisible() then CraftFrame_Update(); end
end


--Slash command handler
function SortEnchant_Slash(msg, HideEcho)
	local origMsg = msg; --Store Original for case insensitive things
	msg = string.lower(msg);

	local typeChanged = false;
	if msg == SortEnchant_Toggle then
		SortEnchant_Master.Enabled = not SortEnchant_Master.Enabled;
		if SortEnchant_Master.Enabled then
			if DEFAULT_CHAT_FRAME and not HideEcho then
				DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_OnMsg .. SortEnchant_Master.Type);
			end
			if Cosmos_UpdateValue then
				Cosmos_UpdateValue("COS_SORTENCHANT_ENABLE", CSM_CHECKONOFF, 1);
			end
			SortEnchant_EnableButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_EssenceMagicLarge");
			SortEnchant_EnableButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_EssenceEternalLarge");
			GameTooltip:SetOwner(SortEnchant_EnableButton, "ANCHOR_TOPLEFT");
			GameTooltip:SetText(SortEnchant_EnableOptions[SortEnchant_Master.Enabled]);
			GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_EnableLine .. "|n");
			SortEnchant_TypeButton:Show();
			SortEnchant_GreyButton:Show();
			SortEnchant_ArmorDropDown:Show();
			SortEnchant_TypeDropDown:Show();
		else
			if DEFAULT_CHAT_FRAME and not HideEcho then
				DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_OffMsg);
			end
			if Cosmos_UpdateValue then
				Cosmos_UpdateValue("COS_SORTENCHANT_ENABLE", CSM_CHECKONOFF, 0);
			end
			SortEnchant_EnableButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_EssenceMysticalSmall");
			SortEnchant_EnableButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_EssenceAstralSmall");
			GameTooltip:SetOwner(SortEnchant_EnableButton, "ANCHOR_TOPLEFT");
			GameTooltip:SetText(SortEnchant_EnableOptions[SortEnchant_Master.Enabled]);
			GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_EnableLine .. "|n");
			SortEnchant_TypeButton:Hide();
			SortEnchant_GreyButton:Hide();
			SortEnchant_ArmorDropDown:Hide();
			SortEnchant_TypeDropDown:Hide();
		end
		typeChanged = true;
	elseif msg == SortEnchant_On then
		SortEnchant_Master.Enabled = true;
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_OnMsg .. SortEnchant_Master.Type);
		end
		if Cosmos_UpdateValue then
			Cosmos_UpdateValue("COS_SORTENCHANT_ENABLE", CSM_CHECKONOFF, 1);
		end
		SortEnchant_EnableButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_EssenceMagicLarge");
		SortEnchant_EnableButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_EssenceEternalLarge");
		GameTooltip:SetOwner(SortEnchant_EnableButton, "ANCHOR_TOPLEFT");
		GameTooltip:SetText(SortEnchant_EnableOptions[SortEnchant_Master.Enabled]);
		GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_EnableLine .. "|n");
		SortEnchant_TypeButton:Show();
		SortEnchant_GreyButton:Show();
		SortEnchant_ArmorDropDown:Show();
		SortEnchant_TypeDropDown:Show();

		typeChanged = true;
	elseif msg == SortEnchant_Off then
		SortEnchant_Master.Enabled = false;
		if CraftFrame:IsVisible() then CraftFrame_Update(); end
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_OffMsg);
		end
		if Cosmos_UpdateValue then
			Cosmos_UpdateValue("COS_SORTENCHANT_ENABLE", CSM_CHECKONOFF, 0);
		end
		SortEnchant_EnableButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_EssenceMysticalSmall");
		SortEnchant_EnableButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_EssenceAstralSmall");
		GameTooltip:SetOwner(SortEnchant_EnableButton, "ANCHOR_TOPLEFT");
		GameTooltip:SetText(SortEnchant_EnableOptions[SortEnchant_Master.Enabled]);
		GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_EnableLine .. "|n");
		SortEnchant_TypeButton:Hide();
		SortEnchant_GreyButton:Hide();
		SortEnchant_ArmorDropDown:Hide();
		SortEnchant_TypeDropDown:Hide();

		typeChanged = true;
	elseif msg == SortEnchant_Grey or msg == SortEnchant_Gray then
		SortEnchant_Master.Grey = not SortEnchant_Master.Grey;
		if SortEnchant_Master.Grey then
			if DEFAULT_CHAT_FRAME and not HideEcho then
				DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_GreyOnMsg);
			end
			--Reset the selection
			if SortEnchant_GetNum() > 1 then
				CraftFrame_SetSelection(2);
			end
			if Cosmos_UpdateValue then
				Cosmos_UpdateValue("COS_SORTENCHANT_GREY", CSM_CHECKONOFF, 1);
			end
			SortEnchant_GreyButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge");
			SortEnchant_GreyButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_ShardGlowingLarge");
			GameTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
			GameTooltip:SetText(SortEnchant_GreyOptions[SortEnchant_Master.Grey]);
			GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_GreyLine .. "|n");
		else
			if DEFAULT_CHAT_FRAME and not HideEcho then
				DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_GreyOffMsg);
			end
			--Reset the selection
			if SortEnchant_GetNum() > 1 then
				CraftFrame_SetSelection(2);
			end
			if Cosmos_UpdateValue then
				Cosmos_UpdateValue("COS_SORTENCHANT_GREY", CSM_CHECKONOFF, 0);
			end
			SortEnchant_GreyButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_ShardRadientLarge");
			SortEnchant_GreyButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_ShardBrilliantLarge");
			GameTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
			GameTooltip:SetText(SortEnchant_GreyOptions[SortEnchant_Master.Grey]);
			GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_GreyLine .. "|n");
		end
		typeChanged = true;
	elseif msg == SortEnchant_Armor then
		SortEnchant_Master.Type = SortEnchant_Armor_C;
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_TypeMsg .. SortEnchant_Armor_C);
		end
		SortEnchant_TypeButton:SetNormalTexture("Interface\\Icons\\INV_Chest_Chain_17");
		SortEnchant_TypeButton:SetPushedTexture("Interface\\Icons\\INV_Chest_Chain_16");
		GameTooltip:SetOwner(SortEnchant_TypeButton, "ANCHOR_TOPLEFT");
		GameTooltip:SetText(SortEnchant_PreType .. SortEnchant_Master.Type .. SortEnchant_PostType);
		GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_TypeLine .. "|n");
		
		typeChanged = true;
	elseif msg == SortEnchant_Type then
		SortEnchant_Master.Type = SortEnchant_Type_C;
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_TypeMsg .. SortEnchant_Type_C);
		end
		SortEnchant_TypeButton:SetNormalTexture("Interface\\Icons\\Spell_Nature_HealingWaveLesser");
		SortEnchant_TypeButton:SetPushedTexture("Interface\\Icons\\Spell_Nature_HealingWaveGreater");
		GameTooltip:SetOwner(SortEnchant_TypeButton, "ANCHOR_TOPLEFT");
		GameTooltip:SetText(SortEnchant_PreType .. SortEnchant_Master.Type .. SortEnchant_PostType);
		GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_TypeLine .. "|n");
		
		typeChanged = true;
	elseif msg == SortEnchant_Available then
		SortEnchant_Master.Type = SortEnchant_Available_C;
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_TypeMsg .. SortEnchant_Available_C);
		end
		SortEnchant_TypeButton:SetNormalTexture("Interface\\Icons\\INV_Letter_09");
		SortEnchant_TypeButton:SetPushedTexture("Interface\\Icons\\INV_Letter_11");
		GameTooltip:SetOwner(SortEnchant_TypeButton, "ANCHOR_TOPLEFT");
		GameTooltip:SetText(SortEnchant_PreType .. SortEnchant_Master.Type .. SortEnchant_PostType);
		GameTooltip:AppendText("\n|c00FFFFFF" .. SortEnchant_TypeLine .. "|n");
		
		typeChanged = true;
	elseif msg == SortEnchant_Reset then
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_ResetConfirmDialog);
		end
	elseif msg == SortEnchant_ResetConfirm then
		SortEnchant_Master = nil;
		SortEnchant_OnEvent("VARIABLES_LOADED");
		if CraftFrame:IsVisible() then CraftFrame_Update(); end
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_ResetMsg);
		end
	elseif msg == SortEnchant_Shorten then
		SortEnchant_Master.ShortenNames = not SortEnchant_Master.ShortenNames;
		if SortEnchant_Master.ShortenNames then
			if DEFAULT_CHAT_FRAME and not HideEcho then
				DEFAULT_CHAT_FRAME:AddMessage("Shortened naming enabled");
			end
			if Cosmos_UpdateValue then
				Cosmos_UpdateValue("COS_SORTENCHANT_SHORTEN", CSM_CHECKONOFF, 1);
			end
		else
			if DEFAULT_CHAT_FRAME and not HideEcho then
				DEFAULT_CHAT_FRAME:AddMessage("Shortened naming disabled");
			end
			if Cosmos_UpdateValue then
				Cosmos_UpdateValue("COS_SORTENCHANT_SHORTEN", CSM_CHECKONOFF, 0);
			end
		end
	elseif string.find(msg, "^" .. SortEnchant_NewType) then
		SortEnchant_Master.Search[string.sub(origMsg, 9)] = { n = 0 };
		SortEnchant_Master.Show[string.sub(origMsg, 9)] = { n = 0 };
	elseif string.find(msg, "^modify") then
		local dummy1, dummy2, type, search, show
		if string.find(string.sub(origMsg, 8), "([^ ]*) %'([^%']*)%' %'([^%']*)%'") then
			dummy1, dummy2, type, search, show = string.find(string.sub(origMsg, 8), "([^ ]*) %'([^%']*)%' %'([^%']*)%'");
		elseif string.find(string.sub(origMsg, 8), "([^ ]*) %'([^%']*)%'") then
			dummy1, dummy2, type, show = string.find(string.sub(origMsg, 8), "([^ ]*) %'([^%']*)%'");
		else
			if DEFAULT_CHAT_FRAME and not HideEcho then
				DEFAULT_CHAT_FRAME:AddMessage("Please enter it in the form /SortEnchant <Cat> '<Search>' '<Show>'");
				return;
			end
		end
		local nextId = SortEnchant_Master.Show[type].n + 1;
		if search then
			SortEnchant_Master.Search[type][nextId] = search;
		end
		SortEnchant_Master.Show[type][nextId] = show;
		SortEnchant_Master.Show[type].n = nextId;
	elseif string.find(msg, "^" .. SortEnchant_Type) then
		SortEnchant_Master.Type = string.sub(origMsg, 6);
		if DEFAULT_CHAT_FRAME and not HideEcho then
			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_TypeMsg .. SortEnchant_Master.Type);
		end
	elseif msg == SortEnchant_HelpAdvanced then
		if DEFAULT_CHAT_FRAME and not HideEcho then
			SortEnchant_DisplayAdvancedHelp();
		end
	else
		if DEFAULT_CHAT_FRAME and not HideEcho then
			SortEnchant_DisplayHelp();
		end
	end

	if typeChanged then
		if SortEnchant_TrueSelected then
			SortEnchant_GetNum(); --Regenerates list
			if not SortEnchant_Data["hidden" .. SortEnchant_origGetInfo(SortEnchant_TrueSelected)] then
				SortEnchant_SelectCraft(SortEnchant_Data["backward" .. SortEnchant_TrueSelected]);
			end
		else
			local tempNum = SortEnchant_Data["original" .. SortEnchant_GetIndex()];
			if type(tempNum) == "number" then --Avoid problems when nothing is selected
				local tempName = (SortEnchant_origGetInfo(tempNum));
				SortEnchant_GetNum(); --Regenerates list
				if tempName ~= SortEnchant_Data["craftName" .. SortEnchant_GetIndex()] then
					SortEnchant_SelectCraft(SortEnchant_Data["backward" .. tempNum]);
				end
			end
		end
		CraftFrame_Update(); --Causes window to be refreshed
	end
end

function SortEnchant_CraftButton(button)
	if (not SortEnchant_Master or not SortEnchant_Master.Enabled) or ((GetCraftDisplaySkillLine()) ~= SortEnchant_EncTitle) then return SortEnchant_origCraftButton(button); end
	if(IsShiftKeyDown()) then
		
	end
end

--Main settings handler
SortEnchant_HandleButtons = {
	Enable = function()
		SortEnchant_Slash(SortEnchant_Toggle, true);
		GameTooltip:Hide();
	end;
	
	Grey = function()
		SortEnchant_Slash(SortEnchant_Grey, true);
		GameTooltip:Hide();
	end;
	
	Type = function()
		if SortEnchant_Master.Type == SortEnchant_Armor_C then
			SortEnchant_Slash(SortEnchant_Type, true);
		elseif SortEnchant_Master.Type == SortEnchant_Type_C then
			SortEnchant_Slash(SortEnchant_Available, true);
		else
			SortEnchant_Slash(SortEnchant_Armor, true);
		end
		GameTooltip:Hide();
	end;
}


--Cosmos setting handler
SortEnchant_HandleCosmos = {
	Enable = function(toggle)
		if toggle == 0 then
			SortEnchant_Master.Enabled = false;
		else
			SortEnchant_Master.Enabled = true;
		end
	end;

	Grey = function(toggle)
		if toggle == 0 then
			SortEnchant_Master.Grey = false;
		else
			SortEnchant_Master.Grey = true;
		end
	end;
	
	Shorten = function(toggle)
		if toggle == 0 then
			SortEnchant_Master.ShortenNames = false;
		else
			SortEnchant_Master.ShortenNames = true;
		end
	end;

	Type = {
		Armor = function()
			SortEnchant_Master.Type = SortEnchant_Armor_C;
		end;
		
		Type = function()
			SortEnchant_Master.Type = SortEnchant_Type_C;
		end;
		
		Availible = function()
			SortEnchant_Master.Type = SortEnchant_Available_C;
		end;
	};
};

function SortEnchant_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		--Data is old, get rid of it, reset selections in those tabs as well
		if SortEnchant_Master then
			SortEnchant_Master.Search = SortEnchant_DefaultSearch;
			SortEnchant_Master.Show = SortEnchant_DefaultShow;
			SortEnchant_Master.Data = nil; --Gets rid of old data that was stored in the master table
			
			if not SortEnchant_Master.Enabled then
				SortEnchant_ArmorDropDown:Hide();
				SortEnchant_TypeDropDown:Hide();
			end
		else
		--------------------------------------------------------------------------------------------
		--   Begin Definition of SortEnchant
		--------------------------------------------------------------------------------------------
			--Generic table to hold most things
			SortEnchant_Master = {
				--Initialize tables to avoid hiccups, skip data, going to manually ensure it is good
				Collapsed = { };
				Groups = { };
				
				--Settings
				Type = SortEnchant_Armor_C;
				Enabled = true;
				Grey = true;
				ShortenNames = false;
				
				--What to show for each group
				Show = SortEnchant_DefaultShow;
				
				--What to search the name with, for each group
				Search = SortEnchant_DefaultSearch;
			}
		--------------------------------------------------------------------------------------------
		--   End Definition of SortEnchant
		--------------------------------------------------------------------------------------------
		end
		
		--Set up buttons in window
		if SortEnchant_Master.Enabled then			
			SortEnchant_EnableButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_EssenceMagicLarge");
			SortEnchant_EnableButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_EssenceEternalLarge");
		else
			SortEnchant_EnableButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_EssenceMysticalSmall");
			SortEnchant_EnableButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_EssenceAstralSmall");
		end

		if SortEnchant_Master.Grey then
			SortEnchant_GreyButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge");
			SortEnchant_GreyButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_ShardGlowingLarge");
		else
			SortEnchant_GreyButton:SetNormalTexture("Interface\\Icons\\INV_Enchant_ShardRadientLarge");
			SortEnchant_GreyButton:SetPushedTexture("Interface\\Icons\\INV_Enchant_ShardBrilliantLarge");
		end

		if SortEnchant_Master.Type == SortEnchant_Armor_C then
			SortEnchant_TypeButton:SetNormalTexture("Interface\\Icons\\INV_Chest_Chain_17");
			SortEnchant_TypeButton:SetPushedTexture("Interface\\Icons\\INV_Chest_Chain_16");
		elseif SortEnchant_Master.Type == SortEnchant_Type_C then
			SortEnchant_TypeButton:SetNormalTexture("Interface\\Icons\\Spell_Nature_HealingWaveLesser");
			SortEnchant_TypeButton:SetPushedTexture("Interface\\Icons\\Spell_Nature_HealingWaveGreater");
		else
			SortEnchant_TypeButton:SetNormalTexture("Interface\\Icons\\INV_Letter_09");
			SortEnchant_TypeButton:SetPushedTexture("Interface\\Icons\\INV_Letter_11");
		end

		--Set up config screen
		if Cosmos_RegisterConfiguration then
			Cosmos_RegisterConfiguration(
				"COS_SORTENCHANT",
				"SECTION",
				SortEnchant_Cosmos_Section,
				SortEnchant_Cosmos_Section_Desc
				);
			Cosmos_RegisterConfiguration(
				"COS_SORTENCHANT_SEPERATOR",
				"SEPARATOR",
				SortEnchant_Cosmos_Main,
				SortEnchant_Cosmos_Main_Desc
				);
			if SortEnchant_Master.Enabled then
				Cosmos_RegisterConfiguration(
					"COS_SORTENCHANT_ENABLE",
					"CHECKBOX",
					SortEnchant_Cosmos_Enable,
					SortEnchant_Cosmos_Enable_Desc,
					SortEnchant_HandleCosmos.Enable,
					1
					);
			else
				Cosmos_RegisterConfiguration(
					"COS_SORTENCHANT_ENABLE",
					"CHECKBOX",
					SortEnchant_Cosmos_Enable,
					SortEnchant_Cosmos_Enable_Desc,
					SortEnchant_HandleCosmos.Enable,
					0
					);
			end
			
			if SortEnchant_Master.Grey then
				Cosmos_RegisterConfiguration(
					"COS_SORTENCHANT_GREY",
					"CHECKBOX",
					SortEnchant_Cosmos_Grey,
					SortEnchant_Cosmos_Grey_Desc,
					SortEnchant_HandleCosmos.Grey,
					1
					);
			else
				Cosmos_RegisterConfiguration(
					"COS_SORTENCHANT_GREY",
					"CHECKBOX",
					SortEnchant_Cosmos_Grey,
					SortEnchant_Cosmos_Grey_Desc,
					SortEnchant_HandleCosmos.Grey,
					0
					);
			end
			
			if SortEnchant_Master.ShortenNames then
				Cosmos_RegisterConfiguration(
					"COS_SORTENCHANT_SHORTEN",
					"CHECKBOX",
					SortEnchant_Cosmos_Shorten,
					SortEnchant_Cosmos_Shorten_Desc,
					SortEnchant_HandleCosmos.Shorten,
					1
					);
			else
				Cosmos_RegisterConfiguration(
					"COS_SORTENCHANT_SHORTEN",
					"CHECKBOX",
					SortEnchant_Cosmos_Shorten,
					SortEnchant_Cosmos_Shorten_Desc,
					SortEnchant_HandleCosmos.Shorten,
					0
					);
			end
			
			Cosmos_RegisterConfiguration(
				"COS_SORTENCHANT_TYPE_SEPERATOR",
				"SEPARATOR",
				SortEnchant_Cosmos_Sort,
				SortEnchant_Cosmos_Sort_Desc
				);
			Cosmos_RegisterConfiguration(
				"COS_SORTENCHANT_TYPE_ARMOR",
				"BUTTON",
				SortEnchant_Armor_C,
				SortEnchant_Cosmos_Type_Armor_Desc,
				SortEnchant_HandleCosmos.Type.Armor,
				0, 0, 0, 0, --Skip these values, useless in a button
				SortEnchant_Cosmos_Type_Name
				);
			Cosmos_RegisterConfiguration(
				"COS_SORTENCHANT_TYPE_TYPE",
				"BUTTON",
				SortEnchant_Type_C,
				SortEnchant_Cosmos_Type_Type_Desc,
				SortEnchant_HandleCosmos.Type.Type,
				0, 0, 0, 0, --Skip these values, useless in a button
				SortEnchant_Cosmos_Type_Name
				);
			Cosmos_RegisterConfiguration(
				"COS_SORTENCHANT_TYPE_AVAILIBLE",
				"BUTTON",
				SortEnchant_Available_C,
				SortEnchant_Cosmos_Type_Available_Desc,
				SortEnchant_HandleCosmos.Type.Availible,
				0, 0, 0, 0, --Skip these values, useless in a button
				SortEnchant_Cosmos_Type_Name
				);
		end
	end
end

function SortEnchant_OnLoad()	
	--Events
		this:RegisterEvent("VARIABLES_LOADED");
	
	--Hook into functions
		--Number of crafts
		SortEnchant_origGetNum = GetNumCrafts;
		GetNumCrafts = SortEnchant_GetNum;

		--Info on craft index
		SortEnchant_origGetInfo = GetCraftInfo;
		GetCraftInfo = SortEnchant_GetInfo;
		
		--Expand/Collapse header index
		SortEnchant_origExpand = ExpandCraftSkillLine;
		ExpandCraftSkillLine = SortEnchant_Expand;
		SortEnchant_origCollapse = CollapseCraftSkillLine;
		CollapseCraftSkillLine = SortEnchant_Collapse;
		
		--Collapse/Expand all
		SortEnchant_origAllButton = TradeSkillCollapseAllButton_OnClick;
		TradeSkillCollapseAllButton_OnClick = SortEnchant_AllButton;
		
		--Indexing
		SortEnchant_origSelectCraft = SelectCraft;
		SelectCraft = SortEnchant_SelectCraft;
		SortEnchant_origGetIndex = GetCraftSelectionIndex;
		GetCraftSelectionIndex = SortEnchant_GetIndex;
		
		--Crafting
		SortEnchant_origDoCraft = DoCraft;
		DoCraft = SortEnchant_DoCraft;
		
		--Tooltips
		SortEnchant_origToolItem = GameTooltip.SetCraftItem;
		GameTooltip.SetCraftItem = SortEnchant_ToolItem;
		SortEnchant_origToolSpell = GameTooltip.SetCraftSpell;
		GameTooltip.SetCraftSpell = SortEnchant_ToolSpell;
	
		--Links
		SortEnchant_origLinkItem = GetCraftItemLink;
		GetCraftItemLink = SortEnchant_LinkItem;
		SortEnchant_origLinkReag = GetCraftReagentItemLink;
		GetCraftReagentItemLink = SortEnchant_LinkReag;

		--Linking name
		SortEnchant_origCraftButton = CraftButton_OnClick;
		CraftButton_OnClick = SortEnchant_CraftButton;
		
		--During SetSelection
		SortEnchant_origIcon = GetCraftIcon;
		GetCraftIcon = SortEnchant_Icon;
		SortEnchant_origDesc = GetCraftDescription;
		GetCraftDescription = SortEnchant_Desc;
		SortEnchant_origNumReag = GetCraftNumReagents;
		GetCraftNumReagents = SortEnchant_NumReag;
		SortEnchant_origReagInfo = GetCraftReagentInfo;
		GetCraftReagentInfo = SortEnchant_ReagInfo;
		SortEnchant_origSpellFocus = GetCraftSpellFocus;
		GetCraftSpellFocus = SortEnchant_SpellFocus;
		
		--Because of UI elements
		SortEnchant_origOnEvent = CraftFrame_OnEvent;
		CraftFrame_OnEvent = SortEnchant_CFOnEvent;

		--Can be initialized here		
		SortEnchant_DropDownSelected = {
			[SortEnchant_Type_C] = SortEnchant_DropDown_Type;
			[SortEnchant_Armor_C] = SortEnchant_DropDown_Armor
		};
		SortEnchant_DropDownSelectedID = {[SortEnchant_Type_C] = 1; [SortEnchant_Armor_C] = 1};
  		
  	--Slash commands, use cosmos if it is availible
	if Cosmos_RegisterChatCommand then
		local commands = {"/sortenchant", "/se"};
		local desc = "Sort Enchant command line options, type /SortEnchant help for details";
		local id = "SORTENCHANT";
		local func = SortEnchant_Slash;
		Cosmos_RegisterChatCommand(id, commands, func, desc);
	else
		SLASH_SORTENCHANT1 = "/sortenchant";
		SLASH_SORTENCHANT2 = "/se";
		SlashCmdList["SORTENCHANT"] = SortEnchant_Slash;
	end	
	
	--Done show message
		if ( DEFAULT_CHAT_FRAME ) then
    			DEFAULT_CHAT_FRAME:AddMessage(SortEnchant_LoadMsgPre .. VersionNumber .. SortEnchant_LoadMsgPost);
  		end
end