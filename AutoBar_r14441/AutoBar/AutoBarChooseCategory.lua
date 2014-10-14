--
--  AutoBarConfigSlot
--
--  Slot Config functions
--
--  Maintained by Azethoth / Toadkiller of Proudmoore.
--  http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

--
-- Config Checkbox Handling
--

AutoBarChooseCategory = {};

local L = AceLibrary("AceLocale-2.1"):GetInstance("AutoBar", true);


function AutoBarChooseCategory.OnScroll()
	GameTooltip:Hide();
	AutoBarChooseCategory:OnShow();
end


function AutoBarChooseCategory:OnShow()
	if (AutoBarChooseCategoryFrame.categoryexplore and not AutoBar_Category_Info[AutoBarChooseCategoryFrame.categoryexplore]) then
		AutoBarChooseCategoryFrame.categoryexplore = nil;
	end
	if (AutoBarChooseCategoryFrame.categoryexplore) then
		AutoBarChooseCategoryFrame_HintText1:Hide();
		local category = AutoBarChooseCategoryFrame.categoryexplore;

		FauxScrollFrame_Update(AutoBarChooseCategoryFrame_Scroll, table.getn(AutoBar_Category_Info[category].items), 7, 36);
		local offset = FauxScrollFrame_GetOffset(AutoBarChooseCategoryFrame_Scroll);
		local index,name,texture;
		for index = 1, 7, 1 do
			local button = getglobal("AutoBarChooseCategoryFrame_Button"..index);
			local hotkey = getglobal("AutoBarChooseCategoryFrame_Button"..index.."HotKey");
			local count  = getglobal("AutoBarChooseCategoryFrame_Button"..index.."Count");
			local icon   = getglobal("AutoBarChooseCategoryFrame_Button"..index.."Icon");
			local text   = getglobal("AutoBarChooseCategoryFrame_Text"..index);
			button.category = nil;
			if (AutoBar_Category_Info[category].items[index+offset]) then
				if (type(AutoBar_Category_Info[category].items[index+offset]) == "number") then
					name,_,_,_,_,_,_,_,texture = GetItemInfo(AutoBar_Category_Info[category].items[index+offset]);
					if (not name) then
						name = AUTOBAR_CONFIG_NOTFOUND..AutoBar_Category_Info[category].items[index+offset]..")";
						texture = "Interface\\Icons\\INV_Misc_Gift_01";
					elseif (not texture) then
						texture = "Interface\\Icons\\INV_Misc_Gift_02";
					end
				else
					texture = "Interface\\Icons\\INV_Misc_Gift_03";
					name = AutoBar_Category_Info[category].items[index+offset];
				end
				icon:SetTexture(texture);
				text:SetText(name);
				count:SetText("");
				button:Show();
				button.itemid = tonumber(AutoBar_Category_Info[category].items[index+offset]);
			else
				button:Hide();
				button.itemid = nil;
				text:SetText("");
			end
		end
	else
		AutoBarChooseCategoryFrame_HintText1:Show();
		local sortedCategories = {};
		for categoryName, rec in pairs(AutoBar_Category_Info) do
			table.insert(sortedCategories, categoryName);
		end
		table.sort (sortedCategories);
		table.insert(sortedCategories, 1, "EMPTY");
		FauxScrollFrame_Update(AutoBarChooseCategoryFrame_Scroll, table.getn(sortedCategories), 7, 36);
		local offset = FauxScrollFrame_GetOffset(AutoBarChooseCategoryFrame_Scroll);
		local index;
		for index = 1, 7, 1 do
			local button = getglobal("AutoBarChooseCategoryFrame_Button"..index);
			local hotkey = getglobal("AutoBarChooseCategoryFrame_Button"..index.."HotKey");
			local count  = getglobal("AutoBarChooseCategoryFrame_Button"..index.."Count");
			local icon   = getglobal("AutoBarChooseCategoryFrame_Button"..index.."Icon");
			local text   = getglobal("AutoBarChooseCategoryFrame_Text"..index);
			button.itemid = nil;
			if (sortedCategories[index+offset] == "EMPTY") then
				icon:SetTexture("");
				count:SetText(L["EMPTY"]);
				text:SetText(L["AUTOBAR_CONFIG_REMOVECAT"]);
				button:Show();
				button.category = sortedCategories[index+offset];
			elseif (sortedCategories[index+offset]) then
				icon:SetTexture(AutoBar_GetTexture(sortedCategories[index+offset]));
				count:SetText("");
				text:SetText(AutoBar_Category_Info[sortedCategories[index+offset]].description);
				button.category = sortedCategories[index+offset];
				button:Show();
			else
				button:Hide();
				button.category = nil;
				text:SetText("");
			end
		end
	end
end


function AutoBarChooseCategory:ButtonOnClick(mousebutton)
	ResetCursor();
	AutoBar.dragging = nil;

	if (IsShiftKeyDown()) then
		if (AutoBarChooseCategoryFrame.categoryexplore) then
			AutoBarChooseCategoryFrame.categoryexplore = nil;
			this:GetParent():Hide();
		else
			local category = this.category;
			if (category == "EMPTY") then category = nil; end
			if (category) then
				AutoBarChooseCategoryFrame.categoryexplore = category;
				AutoBarChooseCategory:OnShow();
			end
		end
	else
		local category = this.category;
		if (category == "EMPTY") then category = nil; end
		if (AutoBarChooseCategoryFrame.editting) then
			AutoBar_Config[AutoBarConfig.editPlayer].buttons[AutoBarConfigSlot.slotsIndex][AutoBarChooseCategoryFrame.editting] = category;
		else
			AutoBar_Config[AutoBarConfig.editPlayer].buttons[AutoBarConfigSlot.slotsIndex] = category;
		end
		AutoBarChooseCategoryFrame.categoryexplore = nil;
		this:GetParent():Hide();
		AutoBarProfile:ButtonsChanged();
	end
	return nil;
end


