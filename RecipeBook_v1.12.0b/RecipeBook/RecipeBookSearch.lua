--== RecipeBookSearch.lua ==--
-- Contains functions necessary for the RecipeBook Search Frame
RB_SearchResults = {};

function RecipeBookSearch_OnLoad()
end

function RecipeBookSearch_OnEvent()
end

function RecipeBookSearch_DoSearch()
	for n = 1, table.getn(RB_SearchResults),1 do
		table.remove(RB_SearchResults);
	end
	RecipeBook_SearchResults_ScrollFrame:Hide();
	if RecipeBookSearch_CBX_SearchItems:GetChecked() then RecipeBookSearch_MatchItems(RecipeBook_SearchFor:GetText()) end;
	if RecipeBookSearch_CBX_SearchMats:GetChecked() then RecipeBookSearch_MatchMaterials(RecipeBook_SearchFor:GetText()) end;
	table.sort(RB_SearchResults, function(a,b) return a[1]<b[1] end);
	if table.getn(RB_SearchResults) < 1 then table.insert(RB_SearchResults, {RECIPEBOOK_RED..RECIPEBOOK_ERR_NOSEARCHRESULT..RECIPEBOOK_END, ""}) end;
--	FauxScrollFrame_SetOffset(RecipeBook_SearchResults_ScrollFrame, 0);
	RecipeBook_SearchFor:HighlightText(0);
 	RecipeBook_SearchResults_ScrollFrame:Show();
end

function RecipeBookSearch_Button_OnClick(button)
	local text = getglobal("RecipeBook_SearchFrameEntry"..this:GetID().."_TextItem"):GetText();
	local index = FauxScrollFrame_GetOffset(RecipeBook_SearchResults_ScrollFrame) + this:GetID();
	if ( button == "LeftButton" ) then
		local link, id, skill = unpack(RB_SearchResults[index][3]);
		if link == nil then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(text);
			end
			return;
		end
		if IsShiftKeyDown() then 
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(link);
			end
		elseif IsAltKeyDown() then
			local data = {};
			table.foreach(RecipeBookMasterList["Tradeskills"][skill][text]["Materials"], function(a,b) table.insert(data, RecipeBookMasterList["Links"][a].." x"..b) end);
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(table.concat(data, ", "));
			else
				RecipeBook_Print(RECIPEBOOK_TXT_SUPPLIES..link..": "..table.concat(data, ", "), -1, nil, 0.25,0.5,1);
			end
		else
			SetItemRef(id,link);
		end
	else
		RecipeBookSearchTooltip:ClearLines();
		RecipeBookSearchTooltip:SetOwner(this, "ANCHOR_CURSOR");
		RecipeBookSearchTooltip:AddLine(text, 1, 1, 0);
		for n = 1, table.getn(RB_SearchResults[index][4]), 1 do
			RecipeBookSearchTooltip:AddLine(RB_SearchResults[index][4][n]);
		end
		RecipeBookSearchTooltip:Show();
	end
end

function RecipeBookSearch_ResultsScrollBar_Update()
	local length = table.getn(RB_SearchResults);
	local line, index, button, text, item, flavor; 
	local offset = FauxScrollFrame_GetOffset(RecipeBook_SearchResults_ScrollFrame);
	for line = 1,10,1 do 
		index = offset + line;
		item, flavor = nil, nil;
		if RB_SearchResults[index] ~= nil then
			item = RB_SearchResults[index][1];
			flavor = RB_SearchResults[index][2];
		end
		textItem = getglobal("RecipeBook_SearchFrameEntry"..line.."_TextItem");
		textItem:SetText(item);
		textFlavor = getglobal("RecipeBook_SearchFrameEntry"..line.."_TextFlavor");
		textFlavor:SetText(flavor);
		button = getglobal("RecipeBook_SearchFrameEntry"..line);
		button:SetID(line);
		if index > length then 
			button:Hide();
		else
			button:Show();
		end
	end
	FauxScrollFrame_Update(RecipeBook_SearchResults_ScrollFrame,length+1,10,40);
end

function RecipeBookSearch_MatchItems(match)
	local matchT = RecipeBook_Split(match);

	local function addName(num, who)
		who = string.gsub(who, ",", "");
		table.insert(knownlines, who);
	end
	
	for tradeskill, item in pairs(RecipeBookMasterList["Tradeskills"]) do 

		for recipe, data in pairs(item) do 

			local found = false;
			local lrecipe = string.lower(recipe);
			if RecipeBookSearch_CBX_SearchExact:GetChecked() then
				if string.find(lrecipe, string.lower(match)) then
					found = true;
				end
			else
				for n, word in pairs(matchT) do
					if string.find(lrecipe, string.lower(word)) then
						found = true;
					else
						found = false;
						break;
					end
				end
			end

			if found then 
				-- {item name, flavor text, {Left-click tooltip lines}, {Right-click tooltip lines}}
				local altsknow, altshaveskill, _, _ = RecipeBook_MatchRecipeData(recipe,recipe, tradeskill, 0);
				if altsknow == "" then altsknow = {} 
				else
					altsknow = RecipeBook_Split(altsknow);
				end;
				if altshaveskill == "" then 
					altshaveskill = {};
				else
					altshaveskill = RecipeBook_Split(altshaveskill);
				end;
				local text = string.format(RECIPEBOOK_SEARCHTEXT_ITEMSTEMPLATE, table.getn(altsknow), table.getn(altshaveskill), tradeskill);
				if table.getn(altsknow) >0 then
					knownlines = {"Known by:"};
					for num, who in ipairs(altsknow) do 
						addName(num, who);
					end
					if table.getn(altshaveskill) >0 then 
						table.insert(knownlines, " ");
						table.insert(knownlines, "Have "..tradeskill..":");
						for num, who in ipairs(altshaveskill) do 
							addName(num, who);
						end
					else
					end
				else
					knownlines = {"Known by no-one"};
				end
				local id = data["ID"];
				table.insert(RB_SearchResults, {recipe, text, {RecipeBookMasterList["Links"][id], id, tradeskill}, knownlines});
			else
			end
			
		end
		
	end
end


function RecipeBookSearch_MatchMaterials(match)
	local matchlist = {};
	local itemlist = {};
	local skill;
	local Realm, Faction, OtherFaction = RecipeBook_GetGlobals();
	
	for id, item in pairs(RecipeBookMasterList["Links"]) do 
		local lrecipe = string.lower(item);
		if RecipeBookSearch_CBX_SearchExact:GetChecked() then
			if string.find(lrecipe, string.lower(match)) then
				table.insert(matchlist, id)
			end
		else
			local matchT = RecipeBook_Split(match);
			local found = false;
			for n, word in pairs(matchT) do
				if string.find(lrecipe, string.lower(word)) then
					found = true;
				else
					found = false;
					break;
				end
			end
			if found then
				table.insert(matchlist, id)
			end
		end
	end

	for skill, item in pairs(RecipeBookMasterList["Tradeskills"]) do
		for what, contents in pairs(item) do
			for i, link in pairs(matchlist) do
				if contents["Materials"][link] ~= nil then 
					-- If the item has materials that match the search item; it's valid.  Insert the appropriate data into itemlist.
					table.insert(itemlist, {RecipeBookMasterList["Links"][contents["ID"]],contents["ID"], RecipeBookMasterList["Links"][link], skill});
				end
			end
		end	
	end
	
	for id, link in ipairs(itemlist) do
		_,_, text = string.find(link[1], "%[(.*)%]");
		_,_, text2 = string.find(link[3], "%[(.*)%]");
		local found = false;
		
		for i, flavor in ipairs(RB_SearchResults) do	
			if flavor[1] == text then 
				if string.find(flavor[2], RECIPEBOOK_SEARCHTEXT_MATSPREFIX) then
					if string.sub(flavor[2], -3) ~= "..." then
						--Already set up as long as it can get.
					elseif string.len(flavor[2]..", "..text2) < 60 then 
						RB_SearchResults[n][2] = flavor[2]..", "..text2;
					else
						RB_SearchResults[n][2] = flavor[2].."...";
					end
				else
					-- Do not add another instance of this item.
				end
				found = true;
			end
		end
		
		if not found then
			local altsknow = RecipeBook_MatchRecipeData(text, text, link[4], 0);
			if altsknow == "" then altsknow = {} 
			else
				altsknow = RecipeBook_Split(altsknow);
			end;
			for n = 1, table.getn(altsknow), 1 do
				altsknow[n] = string.gsub(altsknow[n], ",", "");
				_,_,name = string.find(altsknow[n], "|c%x%x%x%x%x%x%x%x(%.*)|r");
				if RecipeBookData[Realm][Faction] ~= nil then 
					if RecipeBookData[Realm][Faction]["Personal"] ~= nil and RecipeBookData[Realm][Faction]["Personal"][name] ~= nil then 
						altsknow[n] = altsknow[n].." ("..RecipeBookData[Realm][Faction]["Personal"][name][link[4]][text]..")";
					elseif RecipeBookData[Realm][Faction]["Shared"] ~= nil and RecipeBookData[Realm][Faction]["Shared"] ~= nil and RecipeBookData[Realm][Faction]["Shared"][name] ~= nil then
						altsknow[n] = altsknow[n].." ("..RecipeBookData[Realm][Faction]["Shared"][name][link[4]][text]..")";
					end
				end
				if RecipeBookData[Realm][OtherFaction] ~= nil then
					if RecipeBookData[Realm][OtherFaction]["Personal"] ~= nil and RecipeBookData[Realm][OtherFaction]["Personal"][name] ~= nil then
						altsknow[n] = altsknow[n].." ("..RecipeBookData[Realm][OtherFaction]["Personal"][name][link[4]][text]..")";
					elseif RecipeBookData[Realm][OtherFaction]["Shared"] ~= nil and RecipeBookData[Realm][OtherFaction]["Shared"][name] ~= nil then
						altsknow[n] = altsknow[n].." ("..RecipeBookData[Realm][OtherFaction]["Shared"][name][link[4]][text]..")";
					end
				end
			end
			if table.getn(altsknow) > 0 then
				knownlines = {"Can be made by:"};
				for i, who in ipairs(altsknow) do 
					table.insert(knownlines, who);
				end
			else
				knownlines = {"Known by no-one"};
			end

 			-- {item name, flavor text, {Left-click tooltip lines}, {Right-click tooltip lines}}
			table.insert(RB_SearchResults, {text, RECIPEBOOK_SEARCHTEXT_MATSPREFIX..text2, {link[1], link[2], link[4]}, knownlines});
		end
	end
end