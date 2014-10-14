Napoleon.GetResistances = function()
	local resistarray = {};
	local key, counter, total, base, pos, neg, buff;
	local resistorder = { 6, 2, 3, 4 ,5, 1, 0 };
	local resiststring = "";

	-- physical, holy, fire, nature, frost, shadow, arcane
	for key, counter in resistorder do
		_, total, pos, neg = UnitResistance("player",counter);
		if (neg ~= 0) then
			table.insert(resistarray,total .."R");
		elseif (pos ~= 0) then
			table.insert(resistarray,total .."G");
		else
			table.insert(resistarray,total .."N");
		end
	end

	base, buff = UnitDefense("player");
	table.insert(resistarray,base + buff);

	base, buff = UnitAttackPower("player");
	table.insert(resistarray,base + buff);

	base, buff = UnitRangedAttackPower("player");
	table.insert(resistarray,base + buff);

	total = UnitHealthMax("player");
	table.insert(resistarray,total);

	-- arcane, fire, nature, frost, shadow, holy, armour, defense, AP, RAP, maxhealth
	for counter = 1, table.getn(resistarray) do
		if (resiststring ~= "") then
			resiststring = tostring(resiststring .."#");
		end
		resiststring = resiststring .. resistarray[counter];
	end

	Napoleon.SavePlayer(Napoleon.data["version"],Napoleon.data["playername"],"res",resiststring);
end

Napoleon.GetAttributes = function()
	local attribarray = {};
	local counter, lag, pos, neg;
	local attribstring = "";

	-- strength, agility, stamina, intellect, spirit
	for counter = 1, 5 do
		_, total, pos, neg = UnitStat("player",counter);
		if (neg ~= 0) then
			table.insert(attribarray,total .."R");
		elseif (pos ~= 0) then
			table.insert(attribarray,total .."G");
		else
			table.insert(attribarray,total .."N");
		end
	end

	_, _, lag = GetNetStats();
	table.insert(attribarray,lag);

	for counter = 1, table.getn(attribarray) do
		if (attribstring ~= "") then
			attribstring = attribstring .."#";
		end
		attribstring = attribstring .. attribarray[counter];
	end

	Napoleon.SavePlayer(Napoleon.data["version"],Napoleon.data["playername"],"att",attribstring);
end

Napoleon.GetTrades = function()
	local key, value;
	local tradearray = {};
	local counter, name, header, pos, rank;
	local tradestring = "";

	-- init tradearray
	for key, value in Napoleon.data["trade"] do
		tradearray[value] = "0N";
	end

	for counter = 1, 75 do
		name, header, _, rank, _, pos = GetSkillLineInfo(counter);
		if (name ~= nil and header == nil and Napoleon.data["trade"][name] ~= nil) then
			if (pos ~= 0) then
				tradearray[Napoleon.data["trade"][name]] = rank .."G";
			else
				tradearray[Napoleon.data["trade"][name]] = rank .."N";
			end
		end
	end

	for counter = 1, table.getn(tradearray) do
		if (tradestring ~= "") then
			tradestring = tradestring .."#";
		end
		tradestring = tradestring .. tradearray[counter];
	end

	Napoleon.SavePlayer(Napoleon.data["version"],Napoleon.data["playername"],"tra",tradestring);
end

Napoleon.GetInventoryItems = function()
	local counter;
	local itemcount;
	local bag, slot, link, containername, containercount, inventorystring;
	local reagentstring = "";

	if (table.getn(Napoleon.data["class"][Napoleon.data["playerclass"]]["reagents"]) > 0) then
		for counter = 1, table.getn(Napoleon.data["class"][Napoleon.data["playerclass"]]["reagents"]) do
			itemname = Napoleon.data["class"][Napoleon.data["playerclass"]]["reagents"][counter]["name"];
			itemcount = 0;

			for bag = 0, 4 do
				for slot = 1, MAX_CONTAINER_ITEMS do
					link = GetContainerItemLink(bag,slot);
					if (link) then
						_, _, name = string.find(link,"%[(.+)%]");
						if (name and itemname == name) then
							_, containercount = GetContainerItemInfo(bag,slot);
							itemcount = itemcount + containercount;
						end
					end
				end
			end

			if (reagentstring ~= "") then
				reagentstring = reagentstring .."#";
			end
			reagentstring = reagentstring .. itemcount;
		end
	end

	Napoleon.SavePlayer(Napoleon.data["version"],Napoleon.data["playername"],"rea",reagentstring);
end

Napoleon.GetTalents = function()
	local tabs, talents, tabcounter, talentcounter, tabicon, name, icon, row, column, rank, maxrank;
	local talentstring = "";

	tabs = GetNumTalentTabs();
	for tabcounter = 1, tabs do
		_, tabicon = GetTalentTabInfo(tabcounter);
		talents = GetNumTalents(tabcounter);
		for talentcounter = 1, talents do
			name, icon, row, column, rank, maxrank = GetTalentInfo(tabcounter,talentcounter);
			if (rank > 0) then
				if (talentstring ~= "") then
					talentstring = talentstring .."#";
				end
				talentstring = talentstring .. tabcounter .. row .. column .. rank;
			end

--NapoleonSaved["broadcast"]["text"] = NapoleonSaved["broadcast"]["text"] .. "t: ".. tabcounter .. " r: ".. row .." c: [".. column .."] = { maxrank = ".. maxrank ..", name = \"".. name .."\", icon = \"".. icon .."\" },\n";
		end

--NapoleonSaved["broadcast"]["text"] = NapoleonSaved["broadcast"]["text"] .. "\n";
	end

--NapoleonFrameBroadcastOptionsScrollFrameText:SetText(talentstring);

	Napoleon.SavePlayer(Napoleon.data["version"],Napoleon.data["playername"],"tal",talentstring);
end

Napoleon.GetDurability = function()
	local key, counter, location, smin, smax;
	local currentdur, maxdur, broken = 0, 0, 0;
	local location = { 1, 2, 3, 5, 6, 7, 8, 9, 10, 16, 17, 18 };

	for key, counter in location do
		NapoleonTooltip:SetOwner(NapoleonFrame,"ANCHOR_NONE");
		NapoleonTooltip:ClearLines();
		NapoleonTooltip:SetInventoryItem("player",counter);
		for i = 1, NapoleonTooltip:NumLines() do
			_, _, smin, smax = string.find(getglobal("NapoleonTooltipTextLeft".. i):GetText() or "", "^Durability (%d+) / (%d+)$");
			if (smin and smax) then
				local smin, smax = tonumber(smin), tonumber(smax);
				if (smin == 0) then
					broken = broken + 1;
				end
				currentdur = currentdur + smin;
				maxdur = maxdur + smax;
				break;
			end
		end
	end

	Napoleon.SavePlayer(Napoleon.data["version"],Napoleon.data["playername"],"dur",currentdur .."#".. maxdur .."#".. broken);
end

Napoleon.Split = function(haystack, char)
	local splut = {};

	if (type(haystack) ~= "string") then return nil end
	if (not haystack) then haystack = "" end
	if (not char) then
		table.insert(splut,haystack);
	else
		for n, c in string.gfind(haystack,"([^%".. char .."]*)(%".. char .."?)") do
			table.insert(splut,n);
			if (c == "") then break end
		end
	end

	return splut;
end

Napoleon.ShowTime = function(seconds)
	local hour, min, sec, outstring = 0, 0, 0, "";
	local seconds = floor(seconds + 0.5);

	hour = floor(seconds / 3600);
	min = floor(mod(seconds,3600) / 60);
	sec = mod(seconds,60);
	
	if (hour > 0) then
		outstring = hour .."h";
	end

	if (min > 0) then
		if (string.len(outstring) > 0) then
			outstring = outstring ..", ";
		end
		outstring = outstring .. min .."m";
	end

	if (sec > 0 or string.len(outstring) == 0) then
		if (string.len(outstring) > 0) then
			outstring = outstring ..", ";
		end
		outstring = outstring .. sec .."s";
	end

	return outstring;
end

Napoleon.SavePlayer = function(version, player, type, value)
	local class;

	-- received other player data
	if (player ~= Napoleon.data["playername"]) then
		-- if in raid
		if (Napoleon.data["raidassoc"][player] ~= nil) then
			class = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][player]]["class"];
		end
	else
		class = Napoleon.data["playerclass"];
	end

	-- save the data
	if (class) then
		-- never seen data from player before
		if (NapoleonSaved["playerdata"][player] == nil) then
			NapoleonSaved["playerdata"][player] = {};
		end

		NapoleonSaved["playerdata"][player]["ver"] = version;
		NapoleonSaved["playerdata"][player]["time"] = time();
		NapoleonSaved["playerdata"][player]["class"] = class;
		NapoleonSaved["playerdata"][player][type] = value;
	end
end

Napoleon.TalentTabSet = function(tab)
	local name, class, classname;
	local talentarray = {};
	local playertalents = {};
	local counter, talenttab, talentrow, talentcol, rank, talentframe, talentcolor;
	
	name = Napoleon.data["playershow"]["name"];

	if (NapoleonSaved["playerdata"][name] ~= nil and NapoleonSaved["playerdata"][name]["class"] ~= nil) then
		class = NapoleonSaved["playerdata"][name]["class"];
		classname = Napoleon.data["class"][class]["classname"];

--		Napoleon.ChatFrameOutput("talent tab: ".. tab);

		getglobal("NapoleonFramePlayerOptionsTalentTopLeft"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["name"] .."-TopLeft");
		getglobal("NapoleonFramePlayerOptionsTalentTopRight"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["name"] .."-TopRight");
		getglobal("NapoleonFramePlayerOptionsTalentBotLeft"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["name"] .."-BottomLeft");
		getglobal("NapoleonFramePlayerOptionsTalentBotRight"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["name"] .."-BottomRight");

		-- init talent array
		for talenttab = 1, table.getn(Napoleon.data["class"][class]["talenttab"]) do
			playertalents[talenttab] = {};
			playertalents[talenttab]["row"] = {};
			for talentrow = 1, table.getn(Napoleon.data["class"][class]["talenttab"][tab]["row"]) do
				playertalents[talenttab]["row"][talentrow] = {};
				playertalents[talenttab]["row"][talentrow]["col"] = {};
				for talentcol = 1, 4 do
					playertalents[talenttab]["row"][talentrow]["col"][talentcol] = 0;
				end
			end
		end

		-- insert talents in talent array
		talentarray = Napoleon.Split(NapoleonSaved["playerdata"][name]["tal"],"#");
		if (table.getn(talentarray) > 0) then
			for counter = 1, table.getn(talentarray) do
				_, _, talenttab, talentrow, talentcol, rank = string.find(talentarray[counter],"(%d)(%d)(%d)(%d)");
				talenttab = tonumber(talenttab);
				talentrow = tonumber(talentrow);
				talentcol = tonumber(talentcol);
				rank = tonumber(rank);

				playertalents[talenttab]["row"][talentrow]["col"][talentcol] = rank;
			end
		end

		for talentrow = 1, table.getn(Napoleon.data["class"][class]["talenttab"][tab]["row"]) do
			for talentcol = 1, 4 do
				talentframe = "NapoleonFramePlayerOptionsTalentRow".. talentrow .."Col".. talentcol;
				talentdata = Napoleon.data["class"][class]["talenttab"][tab]["row"][talentrow]["col"][talentcol];

				getglobal(talentframe .."Icon"):Hide();
				getglobal(talentframe .."Text"):SetText("");

				if (talentdata ~= nil) then
					getglobal(talentframe .."Icon"):SetTexture(talentdata["icon"]);
					getglobal(talentframe .."Icon"):Show();
					getglobal(talentframe .."Text"):SetText("");

					if (playertalents[tab]["row"][talentrow]["col"][talentcol] == 0) then
						getglobal(talentframe .."Icon"):SetAlpha(0.33);
						getglobal(talentframe .."Text"):SetAlpha(0);
					elseif (playertalents[tab]["row"][talentrow]["col"][talentcol] < talentdata["maxrank"]) then
						talentcolor = Napoleon.data["class"]["HUNTER"]["color"];
						getglobal(talentframe .."Icon"):SetAlpha(0.66);
						getglobal(talentframe .."Text"):SetText(playertalents[talenttab]["row"][talentrow]["col"][talentcol] .."/".. talentdata["maxrank"]);
						getglobal(talentframe .."Text"):SetTextColor(talentcolor["r"],talentcolor["g"],talentcolor["b"]);
						getglobal(talentframe .."Text"):SetAlpha(1);
					else
						getglobal(talentframe .."Icon"):SetAlpha(1);
					end
				end
			end
		end
	end
end

Napoleon.TalentTabChecked = function(obj)
	local tabkey = obj:GetParent():GetID();
	Napoleon.data["playershow"]["tab"] = tabkey;
	Napoleon.TalentTabSet(tabkey);
end

Napoleon.PlayerFrameClear = function()
	local counter;

	getglobal("NapoleonFramePlayerOptionsPortrait"):SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
	getglobal("NapoleonFramePlayerOptionsPortrait"):SetTexCoord(0,1,0,1);
	getglobal("NapoleonFramePlayerOptionsName"):SetText("N/A");
	getglobal("NapoleonFramePlayerOptionsTime"):SetText("N/A");

	getglobal("NapoleonFramePlayerOptionsVersion"):Hide();
	getglobal("NapoleonFramePlayerOptionsTime"):Hide();
	getglobal("NapoleonFramePlayerOptionsTimeLabel"):Hide();
	getglobal("NapoleonFramePlayerOptionsTalent"):Hide();
	getglobal("NapoleonFramePlayerOptionsTalentTab1"):Hide();
	getglobal("NapoleonFramePlayerOptionsTalentTab2"):Hide();
	getglobal("NapoleonFramePlayerOptionsTalentTab3"):Hide();

	for counter = 1, 5 do
		getglobal("NapoleonFramePlayerOptionsResist".. counter .."Icon"):Hide();
		getglobal("NapoleonFramePlayerOptionsResist".. counter .."Text"):Hide();
		getglobal("NapoleonFramePlayerOptionsAbility".. counter .."Icon"):Hide();
		getglobal("NapoleonFramePlayerOptionsAbility".. counter .."Text"):Hide();
		getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Name"):Hide();
		getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Value"):Hide();
		getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Icon"):Hide();
		getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Text"):Hide();
		getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Text"):Hide();
		getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Icon"):Hide();
	end

	getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Name"):Hide();
	getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Value"):Hide();

	getglobal("NapoleonFramePlayerOptionsPingText"):Hide();
	getglobal("NapoleonFramePlayerOptionsPingIcon"):Hide();
end

Napoleon.PlayerFrameUpdate = function()
	local name, tab, counter, key, value, trade, color, class, classname, classcolor, attribname;
	local sendstring, channelid, channelname;
	local resistarray = {};
	local attribarray = {};
	local attribnamearray = {};
	local durabilityarray = {};
	local reagentarray = {};
	local tradearray = {};

	name = Napoleon.data["playershow"]["name"];
	tab = Napoleon.data["playershow"]["tab"];

	local resistcoords = {
		[1] = { 0, 1, 0.2265625, 0.33984375 },
		[2] = { 0, 1, 0, 0.11328125 },
		[3] = { 0, 1, 0.11328125, 0.2265625 },
		[4] = { 0, 1, 0.33984375, 0.453125 },
		[5] = { 0, 1, 0.453125, 0.56640625 },
	}

	getglobal("NapoleonFramePlayerOptionsName"):SetText(name);

	if (NapoleonSaved["playerdata"][name] ~= nil and NapoleonSaved["playerdata"][name]["class"] ~= nil) then
		if (time() - NapoleonSaved["playerdata"][name]["time"] >= 15) then
			if (CT_RA_Channel) then
				-- not looking at yourself
				if (name ~= Napoleon.data["playername"]) then
					sendstring = "nap_".. Napoleon.data["version"] .."&req_pri_all";
					channelid, channelname = GetChannelName(CT_RA_Channel);
					SendChatMessage(sendstring,"CHANNEL",nil,channelid);
				-- volunteer information
				else
					Napoleon.data["playerdatasent"] = time();
					Napoleon.ProcessChatRequest("nap_".. Napoleon.data["version"] .."&req_pub_all",Napoleon.data["playername"]);
				end
			end
		end

		class = NapoleonSaved["playerdata"][name]["class"];
		classname = Napoleon.data["class"][class]["classname"];
		classcolor = Napoleon.data["class"][class]["color"];

		getglobal("NapoleonFramePlayerOptionsPortrait"):SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
		getglobal("NapoleonFramePlayerOptionsPortrait"):SetTexCoord(Napoleon.data["class"][class]["classcoords"][1],Napoleon.data["class"][class]["classcoords"][2],Napoleon.data["class"][class]["classcoords"][3],Napoleon.data["class"][class]["classcoords"][4]);

		getglobal("NapoleonFramePlayerOptionsName"):SetTextColor(classcolor["r"],classcolor["g"],classcolor["b"]);

		getglobal("NapoleonFramePlayerOptionsVersion"):SetText("v".. NapoleonSaved["playerdata"][name]["ver"]);
		getglobal("NapoleonFramePlayerOptionsVersion"):Show();

		getglobal("NapoleonFramePlayerOptionsTime"):SetTextColor(classcolor["r"],classcolor["g"],classcolor["b"]);
		getglobal("NapoleonFramePlayerOptionsTime"):SetText(Napoleon.ShowTime(time() - NapoleonSaved["playerdata"][name]["time"]));
		getglobal("NapoleonFramePlayerOptionsTimeLabel"):Show();
		getglobal("NapoleonFramePlayerOptionsTime"):Show();

		if (NapoleonSaved["playerdata"][name]["tal"] ~= nil) then
			getglobal("NapoleonFramePlayerOptionsTalentTopLeft"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["background"] .."-TopLeft");
			getglobal("NapoleonFramePlayerOptionsTalentTopRight"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["background"] .."-TopRight");
			getglobal("NapoleonFramePlayerOptionsTalentBotLeft"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["background"] .."-BottomLeft");
			getglobal("NapoleonFramePlayerOptionsTalentBotRight"):SetTexture("Interface\\TalentFrame\\".. classname .. Napoleon.data["class"][class]["talenttab"][tab]["background"] .."-BottomRight");
			getglobal("NapoleonFramePlayerOptionsTalent"):Show();
			getglobal("NapoleonFramePlayerOptionsTalentTab1"):Show();
			getglobal("NapoleonFramePlayerOptionsTalentTab2"):Show();
			getglobal("NapoleonFramePlayerOptionsTalentTab3"):Show();

			Napoleon.TalentTabSet(Napoleon.data["playershow"]["tab"]);
		end

		-- resistances, defense, dps
		-- arcane, fire, nature, frost, shadow, holy, armour, defense, AP, RAP, maxhealth
		if (NapoleonSaved["playerdata"][name]["res"] ~= nil) then
			resistarray = Napoleon.Split(NapoleonSaved["playerdata"][name]["res"],"#");

			-- arcane, fire, nature, frost, shadow
			for counter = 1, 5 do
				_, _, value, color = string.find(resistarray[counter],"(%d+)(%w)");
				if (color == "R") then
					getglobal("NapoleonFramePlayerOptionsResist".. counter .."Text"):SetTextColor(1,0,0);
				elseif (color == "G") then
					getglobal("NapoleonFramePlayerOptionsResist".. counter .."Text"):SetTextColor(0,1,0);
				else
					getglobal("NapoleonFramePlayerOptionsResist".. counter .."Text"):SetTextColor(1,1,1);
				end
				getglobal("NapoleonFramePlayerOptionsResist".. counter .."Icon"):SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ResistanceIcons");
				getglobal("NapoleonFramePlayerOptionsResist".. counter .."Icon"):SetTexCoord(resistcoords[counter][1],resistcoords[counter][2],resistcoords[counter][3],resistcoords[counter][4]);

				getglobal("NapoleonFramePlayerOptionsResist".. counter .."Text"):SetText(value);

				getglobal("NapoleonFramePlayerOptionsResist".. counter .."Icon"):Show();
				getglobal("NapoleonFramePlayerOptionsResist".. counter .."Text"):Show();
			end

			-- skip 6 holy

			-- armour, defense, AP, RAP, maxhealth
			_, _, value, color = string.find(resistarray[7],"(%d+)(%w)");
			getglobal("NapoleonFramePlayerOptionsAbility".. 1 .."Icon"):SetTexture("Interface\\Icons\\INV_Chest_Plate09");
			getglobal("NapoleonFramePlayerOptionsAbility".. 1 .."Text"):SetText(value);
			getglobal("NapoleonFramePlayerOptionsAbility".. 2 .."Icon"):SetTexture("Interface\\Icons\\Ability_Warrior_ShieldWall");
			getglobal("NapoleonFramePlayerOptionsAbility".. 2 .."Text"):SetText(resistarray[8]);
			getglobal("NapoleonFramePlayerOptionsAbility".. 3 .."Icon"):SetTexture("Interface\\Icons\\Ability_MeleeDamage");
			getglobal("NapoleonFramePlayerOptionsAbility".. 3 .."Text"):SetText(resistarray[9]);
			getglobal("NapoleonFramePlayerOptionsAbility".. 4 .."Icon"):SetTexture("Interface\\Icons\\Ability_Hunter_RunningShot");
			getglobal("NapoleonFramePlayerOptionsAbility".. 4 .."Text"):SetText(resistarray[10]);
			getglobal("NapoleonFramePlayerOptionsAbility".. 5 .."Icon"):SetTexture("Interface\\Icons\\INV_ValentinesCandy");
			getglobal("NapoleonFramePlayerOptionsAbility".. 5 .."Text"):SetText(resistarray[11]);

			for counter = 1, 5 do
				getglobal("NapoleonFramePlayerOptionsAbility".. counter .."Icon"):Show();
				getglobal("NapoleonFramePlayerOptionsAbility".. counter .."Text"):Show();
			end
		end

		-- attributes and ping
		if (NapoleonSaved["playerdata"][name]["att"] ~= nil) then
			attribarray = Napoleon.Split(NapoleonSaved["playerdata"][name]["att"],"#");
			attribnamearray = { "Strength:", "Agility:", "Stamina:", "Intellect:", "Spirit:" }

			for counter, attribname in (attribnamearray) do
				_, _, value, color = string.find(attribarray[counter],"(%d+)(%w)");
				if (color == "R") then
					getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Value"):SetTextColor(1,0,0);
				elseif (color == "G") then
					getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Value"):SetTextColor(0,1,0);
				else
					getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Value"):SetTextColor(1,1,1);
				end
				getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Name"):SetText(attribname);
				getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Value"):SetText(value);

				getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Name"):Show();
				getglobal("NapoleonFramePlayerOptionsAttrib".. counter .."Value"):Show();
			end

			getglobal("NapoleonFramePlayerOptionsPingIcon"):SetTexture("Interface\\Icons\\Ability_Hunter_Pathfinding");
			if (tonumber(attribarray[6]) < 300) then
				getglobal("NapoleonFramePlayerOptionsPingText"):SetTextColor(0,1,0);
			elseif (tonumber(attribarray[6]) < 600) then
				getglobal("NapoleonFramePlayerOptionsPingText"):SetTextColor(1,1,0);
			else
				getglobal("NapoleonFramePlayerOptionsPingText"):SetTextColor(1,0,0);
			end
			getglobal("NapoleonFramePlayerOptionsPingText"):SetText(attribarray[6]);
			getglobal("NapoleonFramePlayerOptionsPingIcon"):Show();
			getglobal("NapoleonFramePlayerOptionsPingText"):Show();
		end

		-- durability
		if (NapoleonSaved["playerdata"][name]["dur"] ~= nil) then
			durabilityarray = Napoleon.Split(NapoleonSaved["playerdata"][name]["dur"],"#");
			value = floor((durabilityarray[1] / durabilityarray[2] * 100) + 0.5);
			if (value < 15) then
				getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Value"):SetTextColor(1,0,0);
			elseif (value < 30) then
				getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Value"):SetTextColor(1,1,0);
			else
				getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Value"):SetTextColor(1,1,1);
			end

			getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Name"):SetText("Durability");
			getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Value"):SetText(value .."%");

			getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Name"):Show();
			getglobal("NapoleonFramePlayerOptionsAttrib".. 6 .."Value"):Show();
		end

		-- reagents
		if (NapoleonSaved["playerdata"][name]["rea"] ~= nil) then
			reagentarray = Napoleon.Split(NapoleonSaved["playerdata"][name]["rea"],"#");

			for counter = 1, table.getn(reagentarray) do
				getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Icon"):SetTexture(Napoleon.data["class"][class]["reagents"][counter]["icon"]);
				getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Icon"):SetAlpha(1);
				getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Text"):SetText(reagentarray[counter]);
				getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Text"):SetAlpha(1);

				getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Icon"):Show();
				getglobal("NapoleonFramePlayerOptionsReagent".. counter .."Text"):Show();
			end
		end

		-- trade skills
		if (NapoleonSaved["playerdata"][name]["tra"] ~= nil) then
			tradearray = Napoleon.Split(NapoleonSaved["playerdata"][name]["tra"],"#");
			counter = 0;

			for trade, key in pairs(Napoleon.data["trade"]) do
				_, _, value, color = string.find(tradearray[key],"(%d+)(%w)");

				if (tonumber(value) > 0) then
					counter = counter + 1;
					if (color == "R") then
						getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Text"):SetTextColor(1,0,0);
					elseif (color == "G") then
						getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Text"):SetTextColor(0,1,0);
					else
						getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Text"):SetTextColor(1,1,1);
					end
					getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Text"):SetText(value);
					getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Icon"):SetTexture("Interface\\Icons\\".. Napoleon.data["tradeicons"][key]);

					getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Text"):Show();
					getglobal("NapoleonFramePlayerOptionsTrade".. counter .."Icon"):Show();
				end
			end
		end
	end
end
