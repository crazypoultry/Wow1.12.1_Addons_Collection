--
--  $Id: slashboy @ DreamLand 九藜方舟 & lasthime @ 艾森纳 幻物梵天
--  $ver: v1.7.001 
--  $Date: 2006-09-16 18:00:00
--  &Note: Thanks for crowley@headshot.de , the author of Titan Plugin - Item Bonuses.
--
local MAXID = 54000;
local SCS_Stats_list = {
	{name = SCS_STA,	value = "STA"},
	{name = SCS_AGI,	value = "AGI"},
	{name = SCS_INT,	value = "INT"},
	{name = SCS_HEAL,	value = "HEAL"},
	{name = SCS_DMG,	value = "DMG"},
	{name = SCS_ARCANERES,	value = "ARCANERES"},
	{name = SCS_FIRERES,	value = "FIRERES"},
	{name = SCS_NATURERES,	value = "NATURERES"},
	{name = SCS_FROSTRES,	value = "FROSTRES"},
	{name = SCS_SHADOWRES,	value = "SHADOWRES"},
	{name = SCS_DETARRES,	value = "DETARRES"},
	{name = SCS_ARMOR,	value = "ARMOR"},
	{name = SCS_DEFENSE,	value = "DEFENSE"},
	{name = SCS_CRIT,	value = "CRIT"},
	{name = SCS_DODGE,	value = "DODGE"},
	{name = SCS_TOHIT,	value = "TOHIT"},
	{name = SCS_SPELLCRIT,	value = "SPELLCRIT"},
	{name = SCS_SPELLTOHIT,	value = "SPELLTOHIT"},
	{name = SCS_MANAREG,	value = "MANAREG"},
};

local SCS_Armor_list = {
	{name = SCS_ALL,	value = SCS_ALL},
	{name = SCS_CLOTH,	value = SCS_CLOTH},
	{name = SCS_LEATHER,	value = SCS_LEATHER},
	{name = SCS_MAIL,	value = SCS_MAIL},
	{name = SCS_PLATE,	value = SCS_PLATE},
};

local SCS_Armor_cond = SCS_ALL;
local SCS_Stats_sets = SCS_STA;

local unique_items = {};

StatCompare_BestItems = nil;

--this builds up a cached database of item information.
local function StatCompare_GetAllItems()
	if not SCS_DB then
		SCS_DB = {};
	end
	
	for id = 1, MAXID do
		if not SCS_DB[id] then
			local name, _, quality, _, itemType, itemSubType, _, itemEquipLoc, texture = GetItemInfo(id);
			--[[
			    * 0 = Poor
			    * 1 = Common
			    * 2 = Uncommon
			    * 3 = Rare
			    * 4 = Epic
			    * 5 = Legendary
			    * 6 = Artifact 
			--]]
			if name and quality >= 2 then
				SCS_DB[id] = { 
					["name"] = name, 
					["quality"] = quality,
					["iType"] = itemType,
					["subType"] = itemSubType,
					["loc"] = itemEquipLoc,
					["icon"] = texture,
					["unique"] = 0,
					["itemID"] = id,
					["classes"] = nil,
					["value"] = nil,
				};
			end
		end
	end
end

local function StatCompare_ScanItem(id)
	StatScanner_bonuses = {};

	SCObjectTooltip:Hide()
	SCObjectTooltip:SetOwner(UIParent, "ANCHOR_NONE");

	local link = "item:" .. id .. ":0:0:0";
	SCObjectTooltip:SetHyperlink(link);

	local tmpText, tmpStr, lines;
	lines = SCObjectTooltip:NumLines();
	for i=2, lines, 1 do
		tmpText = getglobal("SCObjectTooltipTextLeft"..i);
		val = nil;
		if (tmpText:GetText()) then
			tmpStr = tmpText:GetText();
			tmpStr = string.gsub( tmpStr, "^%s+", "" );
			if( string.find(tmpStr, SCS_UNIQUE)) then
				SCS_DB[id]["unique"] = 1;
			else
				local _, _, classes = string.find(tmpStr, SCS_CLASSES_PATTERN);
				if(classes) then
					SCS_DB[id]["classes"] = classes;
				else
					StatScanner_ScanLine(tmpStr,1);
				end
			end
		end
	end

	local val = StatCompare_ItemValue(SCS_DB[id], StatScanner_bonuses);
	if(val) then
		SCS_DB[id]["value"] = val;
	end
end

function StatCompare_CheckItem(item, class, index, localizedclass)
	local found = false;
	local loc = nil;

	if(StatCompare_classDB and StatCompare_classDB[index] and StatCompare_classDB[index][class]) then
		loc = StatCompare_classDB[index][class]["loc"];		
	else
		return nil;
	end

	if(StatCompare_clssItem[item.name] and StatCompare_clssItem[item.name].class) then
		if(class ~= StatCompare_clssItem[item.name].class) then
			return nil;
		end
	end

	if(loc) then
		if(type(loc) == "string") then
			if(item.loc ~= loc) then
				return nil;
			end
		else
			for i,l in loc do
				if(item.loc == l) then
					found = true;
				end
			end
			if(found == false) then
				return nil;
			end
		end
	end

	local subType = StatCompare_classDB[index][class]["required"];
	if((SCS_Armor_cond ~= SCS_ALL) and (index ~= 2) and (index < 13) and (index ~= 4)) then
		subType = SCS_Armor_cond;
	end

	found = false;
	if(subType) then
		if(type(subType) == "string") then
			if(item.subType ~= subType) then
				return nil;
			end
		else
			for i,l in subType do
				if(item.subType == l) then
					found = true;
				end
			end
			if(found == false) then
				return nil;
			end
		end
	end
	return true;
end

local function StatCompare_GetItem(class, index, localizedclass)
	local id, item, oldid;
	local found;
	if not SCS_DB then
		StatCompare_GetAllItems()
	end

	for id, item in pairs(SCS_DB) do
		if( StatCompare_CheckItem(item, class, index, localizedclass) ) then
			found = true;
			StatCompare_ScanItem(id)

			if(item.classes) then
				if( string.find(item.classes, localizedclass) == nil ) then
					found = false;
				end
			end
			if(found == true) then
				for i,e in STATCOMPARE_EFFECTS do
					if(not unique_items[e.effect]) then
						unique_items[e.effect] = {};
					end
					if(StatScanner_bonuses[e.effect]) then
						if(unique_items[e.effect] and unique_items[e.effect][id]) then
						else
							if(StatCompare_BestItems[index] and StatCompare_BestItems[index][e.effect]) then
								if(tonumber(StatCompare_BestItems[index][e.effect]["value"]) < tonumber(StatScanner_bonuses[e.effect])) then
									StatCompare_BestItems[index][e.effect]["value"] = StatScanner_bonuses[e.effect];
									oldid = StatCompare_BestItems[index][e.effect]["id"];
									StatCompare_BestItems[index][e.effect]["id"] = id; 
									if(unique_items[e.effect][oldid] and unique_items[e.effect][oldid] == 1) then
										unique_items[e.effect][oldid] = nil;
									end
									if(item.unique == 1) then
										unique_items[e.effect][id] = 1;
									elseif(StatCompare_clssItem[item.name] and StatCompare_clssItem[item.name].unique) then
										unique_items[e.effect][id] = 1;
									end
								elseif(tonumber(StatCompare_BestItems[index][e.effect]["value"]) == tonumber(StatScanner_bonuses[e.effect])) then
									local oldid = StatCompare_BestItems[index][e.effect]["id"];
									if(SCS_DB[oldid].value) then
										if(item.value and item.value > SCS_DB[oldid].value) then
											StatCompare_BestItems[index][e.effect]["value"] = StatScanner_bonuses[e.effect];
											StatCompare_BestItems[index][e.effect]["id"] = id; 
											if(item.unique == 1) then
												unique_items[e.effect][id] = 1;
											elseif(StatCompare_clssItem[item.name] and StatCompare_clssItem[item.name].unique) then
												unique_items[e.effect][id] = 1;
											end										
										end
									elseif(item.value) then
										StatCompare_BestItems[index][e.effect]["value"] = StatScanner_bonuses[e.effect];
										StatCompare_BestItems[index][e.effect]["id"] = id; 
										if(item.unique == 1) then
											unique_items[e.effect][id] = 1;
										elseif(StatCompare_clssItem[item.name] and StatCompare_clssItem[item.name].unique) then
											unique_items[e.effect][id] = 1;
										end										
									end
								end
							else
								if(not StatCompare_BestItems[index]) then
									StatCompare_BestItems[index] = {};
								end
								StatCompare_BestItems[index][e.effect] = {};
								StatCompare_BestItems[index][e.effect]["value"] = StatScanner_bonuses[e.effect];
								StatCompare_BestItems[index][e.effect]["id"] = id;
								if(item.unique == 1) then
									unique_items[e.effect][id] = 1;
								elseif(StatCompare_clssItem[item.name] and StatCompare_clssItem[item.name].unique) then
									unique_items[e.effect][id] = 1;
								end
							end
						end
					end
				end
			end			
		end
	end
end

function StatCompare_GetBestItem()
	local localizedclass, class = UnitClass("player");
	StatCompare_BestItems = {};
	unique_items = {};

	for i = 1, 19 do
		if(StatCompare_classDB[i] and StatCompare_classDB[i][class] and StatCompare_classDB[i][class]["loc"]) then
			StatCompare_GetItem(class, i, localizedclass);
		end
	end
	unique_items = {};

	-- handler enchant info
	for i = 1, 19 do
		for j, e in STATCOMPARE_EFFECTS do
			if(StatCompare_BestItems[i] and StatCompare_BestItems[i][e.effect] and StatCompare_enchantDB[i] and StatCompare_enchantDB[i][e.effect]) then
				if(StatCompare_enchantDB[i][e.effect][class]) then
					StatCompare_BestItems[i][e.effect]["enchantid"] = StatCompare_enchantDB[i][e.effect][class];
				elseif(StatCompare_enchantDB[i][e.effect]["default"]) then
					StatCompare_BestItems[i][e.effect]["enchantid"] = StatCompare_enchantDB[i][e.effect]["default"];
				end
			end
		end
	end

	-- handler two-hand weapon
	for i, e in STATCOMPARE_EFFECTS do
		if(StatCompare_BestItems and StatCompare_BestItems[17] and StatCompare_BestItems[17][e.effect]) then
			local id = StatCompare_BestItems[17][e.effect]["id"];
			if(SCS_DB[id].loc == "INVTYPE_2HWEAPON" and StatCompare_BestItems[18] and StatCompare_BestItems[18][e.effect]) then
				StatCompare_BestItems[18][e.effect] = nil;
			end
		end
	end
--[[
	for i = 1, 19 do
		if(StatCompare_BestItems[i] and StatCompare_BestItems[i]["HEAL"]) then
			local id = StatCompare_BestItems[i]["HEAL"]["id"];
			local _,_,_,hex = GetItemQualityColor(SCS_DB[id].quality);
			local link = hex .. "|H".. "item:" .. id .. ":0:0:0" .. "|h[" .. SCS_DB[id].name .. "]|h|r";
			DEFAULT_CHAT_FRAME:AddMessage("Best HEAL "..link);
		end
	end
--]]
end

local function StatCompare_GetBestItemCache(sets)
	if(StatCompare_BestItems) then
		return;
	end
	local localizedclass, class = UnitClass("player");
	StatCompare_BestItems = {};
	unique_items = {};

	for i = 1, 19 do
		if(StatCompare_classDB[i] and StatCompare_classDB[i][class] and StatCompare_classDB[i][class]["loc"]) then
			StatCompare_GetItem(class, i, localizedclass);
		end
	end
	unique_items = {};

	-- handler enchant info
	for i = 1, 19 do
		for j, e in STATCOMPARE_EFFECTS do
			if(StatCompare_BestItems[i] and StatCompare_BestItems[i][e.effect] and StatCompare_enchantDB[i] and StatCompare_enchantDB[i][e.effect]) then
				if(StatCompare_enchantDB[i][e.effect][class]) then
					StatCompare_BestItems[i][e.effect]["enchantid"] = StatCompare_enchantDB[i][e.effect][class];
				elseif(StatCompare_enchantDB[i][e.effect]["default"]) then
					StatCompare_BestItems[i][e.effect]["enchantid"] = StatCompare_enchantDB[i][e.effect]["default"];
				end
			end
		end
	end

	-- handler two-hand weapon
	for i, e in STATCOMPARE_EFFECTS do
		if(StatCompare_BestItems and StatCompare_BestItems[17] and StatCompare_BestItems[17][e.effect]) then
			local id = StatCompare_BestItems[17][e.effect]["id"];
			if(SCS_DB[id].loc == "INVTYPE_2HWEAPON" and StatCompare_BestItems[18] and StatCompare_BestItems[18][e.effect]) then
				StatCompare_BestItems[18][e.effect] = nil;
			end
		end
	end
end

local function SCS_GetTooltipText(bonuses)
	local retstr,cat,val,lval = "","","","","";
	local i;
	local baseval = {};

	--DEFAULT_CHAT_FRAME:AddMessage("Entering GetTooltipText");
	for i,e in STATCOMPARE_EFFECTS do
		if(e.opt and StatCompare_GetSetting(e.opt) and StatCompare_GetSetting(e.opt) ~= 1) then
		elseif(bonuses[e.effect]) then
			if(e.format) then
		   		val = format(e.format,bonuses[e.effect]);
			else
				val = bonuses[e.effect];
			end;
			if(e.cat ~= cat) then
				cat = e.cat;
				if(retstr ~= "") then
					retstr = retstr .. "\n"
				end
				retstr = retstr .. "\n" ..GREEN_FONT_COLOR_CODE.. getglobal('STATCOMPARE_CAT_'..cat)..":"..FONT_COLOR_CODE_CLOSE;
				
			end
			
			if(CharStats_fullvals and CharStats_fullvals[e.effect]) then
				if(e.effect == "SPELLHIT" or e.effect == "TOHIT") then
				elseif(e.show and e.show == 0) then
				elseif(CharStats_fullvals[e.effect] == 0) then
				else
					if(e.lformat) then
						lval = format(e.lformat, CharStats_fullvals[e.effect]);
					else
						lval = CharStats_fullvals[e.effect];
					end
					val = val.." / "..lval;
				end
			end

			retstr = retstr.. "\n".. StatComparePaintText(e.short,e.name)..":\t";
			retstr = retstr.. NORMAL_FONT_COLOR_CODE..val..FONT_COLOR_CODE_CLOSE;

			-- special hack for DRUID AP
			if(e.effect == "ATTACKPOWER" and CharStats_fullvals and CharStats_fullvals["BEARAP"]) then
				retstr = retstr .. "\n" ..STATCOMPARE_DRUID_BEAR..":\t"..NORMAL_FONT_COLOR_CODE..CharStats_fullvals["BEARAP"]..FONT_COLOR_CODE_CLOSE;
				retstr = retstr .. "\n" ..STATCOMPARE_DRUID_CAT..":\t"..NORMAL_FONT_COLOR_CODE..CharStats_fullvals["CATAP"]..FONT_COLOR_CODE_CLOSE;
			end
		elseif(CharStats_fullvals and CharStats_fullvals[e.effect]) then
			if(e.effect == "SPELLHIT" or e.effect == "TOHIT") then
			elseif(CharStats_fullvals[e.effect] == 0) then
			elseif(not e.show) then
			elseif(e.show == 0) then
			else
				if(e.lformat) then
					val = format(e.lformat, CharStats_fullvals[e.effect]);
				else
					val = CharStats_fullvals[e.effect];
				end
				if(e.cat ~= cat) then
					cat = e.cat;
					if(retstr ~= "") then
						retstr = retstr .. "\n"
					end
					retstr = retstr .. "\n" ..GREEN_FONT_COLOR_CODE.. getglobal('STATCOMPARE_CAT_'..cat)..":"..FONT_COLOR_CODE_CLOSE;
					
				end
				
				retstr = retstr.. "\n".. StatComparePaintText(e.short,e.name)..":\t";
				retstr = retstr.. NORMAL_FONT_COLOR_CODE..val..FONT_COLOR_CODE_CLOSE;

				-- special hack for DRUID AP
				if(e.effect == "ATTACKPOWER" and CharStats_fullvals["BEARAP"]) then
					retstr = retstr .. "\n" ..STATCOMPARE_DRUID_BEAR..":\t"..NORMAL_FONT_COLOR_CODE..CharStats_fullvals["BEARAP"]..FONT_COLOR_CODE_CLOSE;
					retstr = retstr .. "\n" ..STATCOMPARE_DRUID_CAT..":\t"..NORMAL_FONT_COLOR_CODE..CharStats_fullvals["CATAP"]..FONT_COLOR_CODE_CLOSE;
				end
			end
		end
	end

	local setstr=""
--	local settitle="\n\n"..GREEN_FONT_COLOR_CODE..STATCOMPARE_SET_PREFIX..FONT_COLOR_CODE_CLOSE.."\n"
--	for i,v in StatScanner_setcount do
--		setstr=setstr..'|cff'..v.color..i..v.count.."/"..v.total.."）"..FONT_COLOR_CODE_CLOSE.."\n";
--	end
	if (setstr~="") then setstr=settitle..setstr; end

	return retstr..setstr;
end

function StatCompare_ShowSets(sets, cache)
	if(not sets) then
		return;
	end
	if(cache) then
		StatCompare_GetBestItemCache(sets);
	else
		StatCompare_GetBestItem(sets);
	end
	StatCompare_DressSets(sets);
	StatScanner_ScanAllInspect("player", sets);
	if(StatCompare_CharStats_Scan) then
		StatCompare_CharStats_Scan(StatScanner_bonuses, "player");
	end
	local tiptext = SCS_GetTooltipText(StatScanner_bonuses);
	SCS_ShowFrame(StatCompareSetsTooltipFrame,StatCompareSetsFrame,UnitName("player"),tiptext,0,0);
end

function SCS_ShowFrame(frame,target,tiptitle,tiptext,anchorx,anchory)
	local text = getglobal(frame:GetName().."Text");
	local title = getglobal(frame:GetName().."Title");
	title:SetText(tiptitle);
	text:SetText(tiptext);
	height = text:GetHeight();
	width = text:GetWidth();
	if(width < title:GetWidth()) then
		width = title:GetWidth();
	end
	frame:SetHeight(height+30);
	frame:SetWidth(width+30);
	frame:SetPoint("TOPLEFT", target:GetName(), "TOPRIGHT", anchorx, anchory);
	if(tiptext=="") then
		frame:Hide();
	else
		frame:Show();
	end
end

function StatCompareSetsFrameStatsTypeDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(StatCompareSetsFrameStatsTypeDropDown, this:GetID());
	SCS_Stats_sets = SCS_Stats_list[this:GetID()].value;
	StatCompare_ShowSets(SCS_Stats_sets, 1);
end

local function StatCompareSetsFrameStatsTypeDropDown_Initialize()
	local info;

	for i = 1, getn(SCS_Stats_list), 1 do
		info = { };
		info.text = SCS_Stats_list[i].name;
		info.value = SCS_Stats_list[i].value;
		info.func = StatCompareSetsFrameStatsTypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function StatCompareSetsFrameStatsTypeDropDown_OnLoad()
	UIDropDownMenu_Initialize(StatCompareSetsFrameStatsTypeDropDown, StatCompareSetsFrameStatsTypeDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(StatCompareSetsFrameStatsTypeDropDown,1);
	UIDropDownMenu_SetWidth(140, StatCompareSetsFrameStatsTypeDropDown);
end

function StatCompareSetsFrameArmorTypeDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(StatCompareSetsFrameArmorTypeDropDown, this:GetID());
	if(SCS_Armor_cond ~= SCS_Armor_list[this:GetID()].value) then
		SCS_Armor_cond = SCS_Armor_list[this:GetID()].value;
		StatCompare_ShowSets(SCS_Stats_sets);
	else
		StatCompare_ShowSets(SCS_Stats_sets, 1);
	end
end

local function StatCompareSetsFrameArmorTypeDropDown_Initialize()
	local info;

	for i = 1, getn(SCS_Armor_list), 1 do
		info = { };
		info.text = SCS_Armor_list[i].name;
		info.value = SCS_Armor_list[i].value;
		info.func = StatCompareSetsFrameArmorTypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function StatCompareSetsFrameArmorTypeDropDown_OnLoad()
	UIDropDownMenu_Initialize(StatCompareSetsFrameArmorTypeDropDown, StatCompareSetsFrameArmorTypeDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(StatCompareSetsFrameArmorTypeDropDown,1);
	UIDropDownMenu_SetWidth(60, StatCompareSetsFrameArmorTypeDropDown);
end
