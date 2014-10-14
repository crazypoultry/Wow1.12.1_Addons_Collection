Napoleon.BandCreate = function()
	Napoleon.ClearOptions();
	Napoleon.data["bandshow"]["status"] = "new";
	Napoleon.BandFrameUpdate();
	NapoleonFrameBandOptions:Show();
end

Napoleon.BandScrollBarUpdate = function()
	local filter, bandcount, bandoffset, bandframe, bandcolor, bandname, bandextras, counterrow, raidkey, class;
	local filterlist = {};

	if (Napoleon.data["loaded"] == false) then
		return;
	end

	filterlist = Napoleon.BandFilterList();
	bandcount = Napoleon.FilterCount(filterlist);

	-- xmlobject, entries, visible rows, row height
	FauxScrollFrame_Update(NapoleonFrameBandScrollBar,bandcount,5,16);

	if (bandcount > 5) then
		NapoleonFrameBandScrollBar:Show();
	else
		NapoleonFrameBandScrollBar:Hide();
	end

	for counterrow = 1, 5 do
		bandoffset = counterrow + FauxScrollFrame_GetOffset(NapoleonFrameBandScrollBar);
		bandframe = "NapoleonFrameBand".. counterrow;
		bandextras = "";

		if (bandoffset <= bandcount) then
			raidkey = Napoleon.FilterFind(filterlist,bandoffset);
			bandname = Napoleon.data["raidarray"][raidkey]["name"];

			class = Napoleon.data["raidarray"][raidkey]["class"];
			getglobal(bandframe.."SubGroup"):SetText("*");

			if (Napoleon.data["raidarray"][raidkey]["checked"] == true) then
				getglobal(bandframe .."Check"):SetChecked(1);
			else
				getglobal(bandframe .."Check"):SetChecked(0);
			end

			getglobal(bandframe.."OAZ"):SetTexture("Interface\\BattlefieldFrame\\UI-Battlefield-Icon");
			getglobal(bandframe.."OAZ"):SetAlpha(1);

			-- hide player checkbox
			getglobal(bandframe.."Details"):SetAlpha(0);
			if (Napoleon.data["bandshow"]["name"] == bandname) then
				getglobal(bandframe.."Details"):SetChecked(1)
				getglobal(bandframe.."DetailsTexture"):SetTexture("Interface\\Buttons\\UI-AttributeButton-Encourage-Down");
			else
				getglobal(bandframe.."Details"):SetChecked(0)
				getglobal(bandframe.."DetailsTexture"):SetTexture("Interface\\Buttons\\UI-AttributeButton-Encourage-Up");
			end

			bandcolor = Napoleon.data["class"][Napoleon.data["raidarray"][raidkey]["class"]]["color"];
			getglobal(bandframe.."Name"):SetTextColor(bandcolor["r"],bandcolor["g"],bandcolor["b"],1);
			getglobal(bandframe.."Name"):SetText(bandname);

			getglobal(bandframe):Show();
		else
			getglobal(bandframe):Hide();
		end
	end
end

Napoleon.BandDelete = function()
	Napoleon.ClearOptions();

	-- remove entry
	if (Napoleon.data["bandshow"]["name"] ~= "") then
		table.remove(Napoleon.data["raidarray"],Napoleon.data["raidassoc"][Napoleon.data["bandshow"]["name"]]);

		-- re-generate the assoc
		Napoleon.data["raidassoc"] = {};
		for counter = 1, table.getn(Napoleon.data["raidarray"]) do
			Napoleon.data["raidassoc"][Napoleon.data["raidarray"][counter]["name"]] = counter;
		end
	end

	Napoleon.data["bandshow"]["name"] = "";
end

Napoleon.BandNameCreate = function(entry)
	local counter, name;

	name = "";
	for counter = 1, table.getn(entry["filter"]) do
		if (entry["filter"][counter]["filter"] ~= "" and entry["filter"][counter]["filter"] ~= nil) then
			if (counter <= 3) then
				if (name ~= "") then
					name = name .. " ".. entry["filter"][counter]["filter"];
				else
					name = entry["filter"][counter]["filter"];
				end
			else
				if (name ~= "") then
					name = name .. " not ".. entry["filter"][counter]["filter"];
				else
					name = "not ".. entry["filter"][counter]["filter"];
				end
			end
		end
	end

	if (Napoleon.data["raidassoc"][name] ~= nil) then
		name = name .."1";
	end

	return name;
end

Napoleon.BandSave = function()
	local entry = {};
	local tempentry = {};
	local minfilter, counter;

	entry["name"] = NapoleonFrameBandOptionsLabel:GetText();
	entry["filter"] = {};
	entry["filter"][1] = {};
	entry["filter"][1]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBandOptionsDropDownRaid);
	entry["filter"][1]["filter"] = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownRaid);
	entry["filter"][2] = {};
	entry["filter"][2]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBandOptionsDropDownGroup);
	entry["filter"][2]["filter"] = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownGroup);
	entry["filter"][3] = {};
	entry["filter"][3]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBandOptionsDropDownOther);
	entry["filter"][3]["filter"] = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownOther);
	entry["filter"][4] = {};
	entry["filter"][4]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBandOptionsDropDownNotRaid);
	entry["filter"][4]["filter"] = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownNotRaid);
	entry["filter"][5] = {};
	entry["filter"][5]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBandOptionsDropDownNotGroup);
	entry["filter"][5]["filter"] = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownNotGroup);
	entry["filter"][6] = {};
	entry["filter"][6]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBandOptionsDropDownNotOther);
	entry["filter"][6]["filter"] = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownNotOther);

	minfilter = false;
	for counter = 1, 6 do
		if (entry["filter"][counter]["filter"] ~= nil and entry["filter"][counter]["filter"] ~= "") then
			minfilter = true;
		end
	end

	if (minfilter == false) then
		Napoleon.ChatFrameOutput("Minimum one filter required");
	-- started by editing band
	elseif (Napoleon.data["bandshow"]["name"] ~= "") then
		tempentry = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][Napoleon.data["bandshow"]["name"]]];
		tempentry["name"] = entry["name"];
		tempentry["filter"] = entry["filter"];

		-- if name changed
		if (Napoleon.data["bandshow"]["name"] ~= entry["name"]) then
			-- if new name already exists
			if (Napoleon.data["raidassoc"][entry["name"]] ~= nil) then
				Napoleon.ChatFrameOutput("name already exists");
			else
				-- remove old entry
				table.remove(Napoleon.data["raidarray"],Napoleon.data["raidassoc"][Napoleon.data["bandshow"]["name"]]);

				-- add new entry
				table.insert(Napoleon.data["raidarray"],tempentry);

				-- re-generate the assoc
				Napoleon.data["raidassoc"] = {};
				for counter = 1, table.getn(Napoleon.data["raidarray"]) do
					Napoleon.data["raidassoc"][Napoleon.data["raidarray"][counter]["name"]] = counter;
				end

				Napoleon.ClearOptions();
				Napoleon.data["bandshow"]["name"] = "";
				Napoleon.data["bandshow"]["status"] = "";

			end
		-- name stayed the same
		else
			Napoleon.data["raidarray"][Napoleon.data["raidassoc"][tempentry["name"]]] = tempentry;
			Napoleon.ClearOptions();
			Napoleon.data["bandshow"]["name"] = "";
			Napoleon.data["bandshow"]["status"] = "";
		end
	-- new band
	else
		-- create a name if not given
		if (not string.find(entry["name"],"%a+")) then
			entry["name"] = Napoleon.BandNameCreate(entry);
		end

		entry["class"] = "BAND";
		entry["subgroup"] = 0;
		entry["online"] = 1;
		entry["isdead"] = 0;
		entry["checked"] = false;
		entry["tankname"] = nil;
		entry["tankslot"] = 0;
		table.insert(Napoleon.data["raidarray"],entry);

		-- re-generate the assoc
		Napoleon.data["raidassoc"] = {};
		for counter = 1, table.getn(Napoleon.data["raidarray"]) do
			Napoleon.data["raidassoc"][Napoleon.data["raidarray"][counter]["name"]] = counter;
		end

		Napoleon.ClearOptions();
		Napoleon.data["bandshow"]["name"] = "";
		Napoleon.data["bandshow"]["status"] = "";
	end
end

Napoleon.BandFrameUpdate = function()
	local entry = {};

	-- loading
	if (Napoleon.data["bandshow"]["status"] == "load") then
		entry = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][Napoleon.data["bandshow"]["name"]]];

		NapoleonFrameBandOptionsLabel:SetText(Napoleon.data["bandshow"]["name"]);
		UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownRaid,entry["filter"][1]["id"]);
		UIDropDownMenu_SetText(entry["filter"][1]["filter"],NapoleonFrameBandOptionsDropDownRaid);

		UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownGroup,entry["filter"][2]["id"]);
		UIDropDownMenu_SetText(entry["filter"][2]["filter"],NapoleonFrameBandOptionsDropDownGroup);

		UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownOther,entry["filter"][3]["id"]);
		UIDropDownMenu_SetText(entry["filter"][3]["filter"],NapoleonFrameBandOptionsDropDownOther);

		UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownNotRaid,entry["filter"][4]["id"]);
		UIDropDownMenu_SetText(entry["filter"][4]["filter"],NapoleonFrameBandOptionsDropDownNotRaid);

		UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownNotGroup,entry["filter"][5]["id"]);
		UIDropDownMenu_SetText(entry["filter"][5]["filter"],NapoleonFrameBandOptionsDropDownNotGroup);

		UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownNotOther,entry["filter"][6]["id"]);
		UIDropDownMenu_SetText(entry["filter"][6]["filter"],NapoleonFrameBandOptionsDropDownNotOther);

		Napoleon.data["bandshow"]["status"] = "edit";
	end

	-- editing
	if (Napoleon.data["bandshow"]["status"] == "edit") then
		


	-- creating
	elseif (Napoleon.data["bandshow"]["status"] == "new") then
		NapoleonFrameBandOptionsLabel:SetText("");

		UIDropDownMenu_Initialize(NapoleonFrameBandOptionsDropDownRaid,Napoleon.BandDropDownRaidInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameBandOptionsDropDownRaid);
		UIDropDownMenu_Initialize(NapoleonFrameBandOptionsDropDownGroup,Napoleon.BandDropDownGroupInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameBandOptionsDropDownGroup);
		UIDropDownMenu_Initialize(NapoleonFrameBandOptionsDropDownOther,Napoleon.BandDropDownOtherInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameBandOptionsDropDownOther);
		UIDropDownMenu_Initialize(NapoleonFrameBandOptionsDropDownNotRaid,Napoleon.BandDropDownNotRaidInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameBandOptionsDropDownNotRaid);
		UIDropDownMenu_Initialize(NapoleonFrameBandOptionsDropDownNotGroup,Napoleon.BandDropDownNotGroupInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameBandOptionsDropDownNotGroup);
		UIDropDownMenu_Initialize(NapoleonFrameBandOptionsDropDownNotOther,Napoleon.BandDropDownNotOtherInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameBandOptionsDropDownNotOther);

		Napoleon.data["bandshow"]["name"] = "";
		Napoleon.data["bandshow"]["status"] = "edit";
	end
end

Napoleon.BandPlayersScrollBarUpdate = function()
	local filter, bandcount, bandoffset, bandframe, bandcolor, bandname, bandextras, counterrow, raidkey, class;
	local filterlist = {};

	if (Napoleon.data["loaded"] == false) then
		return;
	end

	filter = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownRaid);
	if (filter ~= nil) then
		table.insert(filterlist,filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownGroup);
	if (filter ~= nil) then
		table.insert(filterlist,filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownOther);
	if (filter ~= nil) then
		table.insert(filterlist,filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownNotRaid);
	if (filter ~= nil) then
		table.insert(filterlist,"!".. filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownNotGroup);
	if (filter ~= nil) then
		table.insert(filterlist,"!".. filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameBandOptionsDropDownNotOther);
	if (filter ~= nil) then
		table.insert(filterlist,"!".. filter);
	end
	table.insert(filterlist,"NONBAND");

	bandcount = Napoleon.FilterCount(filterlist);

	-- xmlobject, entries, visible rows, row height
	FauxScrollFrame_Update(NapoleonFrameBandOptionsPlayerScrollBar,bandcount,6,16);

	if (bandcount > 6) then
		NapoleonFrameBandOptionsPlayerScrollBar:Show();
	else
		NapoleonFrameBandOptionsPlayerScrollBar:Hide();
	end

	for counterrow = 1, 6 do
		bandoffset = counterrow + FauxScrollFrame_GetOffset(NapoleonFrameBandOptionsPlayerScrollBar);
		bandframe = "NapoleonFrameBandOptionsPlayer".. counterrow;
		bandextras = "";

		if (bandoffset <= bandcount) then
			raidkey = Napoleon.FilterFind(filterlist,bandoffset);
			bandname = Napoleon.data["raidarray"][raidkey]["name"];

			class = Napoleon.data["raidarray"][raidkey]["class"];
			getglobal(bandframe.."SubGroup"):SetText(Napoleon.data["raidarray"][raidkey]["subgroup"]);

			if (Napoleon.data["raidarray"][raidkey]["online"] ~= 1) then
				getglobal(bandframe.."OAZ"):SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
				getglobal(bandframe.."OAZ"):SetAlpha(1);
			elseif (Napoleon.data["raidarray"][raidkey]["isdead"] == 1) then
				getglobal(bandframe.."OAZ"):SetTexture("Interface\\TargetingFrame\\TargetDead");
				getglobal(bandframe.."OAZ"):SetAlpha(1);
			elseif (Napoleon.data["raidarray"][raidkey]["zone"] ~= Napoleon.data["zonetext"]) then
				getglobal(bandframe.."OAZ"):SetTexture("Interface\\WorldMap\\WorldMap-Icon");
				getglobal(bandframe.."OAZ"):SetAlpha(1);
			else
				getglobal(bandframe.."OAZ"):SetTexture("Interface\\Buttons\\UI-CheckBox-Check");
				getglobal(bandframe.."OAZ"):SetAlpha(0.25);
			end

			bandcolor = Napoleon.data["class"][Napoleon.data["raidarray"][raidkey]["class"]]["color"];
			getglobal(bandframe.."Name"):SetTextColor(bandcolor["r"],bandcolor["g"],bandcolor["b"],1);
			getglobal(bandframe.."Name"):SetText(bandname);

			getglobal(bandframe):Show();
		else
			getglobal(bandframe):Hide();
		end
	end
end

Napoleon.BandDropDownRaidInitialize = function()
	local counter, entry;

	for counter = 1, table.getn(Napoleon.data["ddraid"]) do
		entry = { text = Napoleon.data["ddraid"][counter]; checked = nil; func = Napoleon.BandDropDownRaidOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.BandDropDownRaidOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownRaid,this:GetID());
end

Napoleon.BandDropDownGroupInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddgroup"]) do
		entry = { text = Napoleon.data["ddgroup"][counter]; checked = nil; func = Napoleon.BandDropDownGroupOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.BandDropDownGroupOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownGroup,this:GetID());
end

Napoleon.BandDropDownOtherInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddother"]) do
		entry = { text = Napoleon.data["ddother"][counter]; checked = nil; func = Napoleon.BandDropDownOtherOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.BandDropDownOtherOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownOther,this:GetID());
end











Napoleon.BandDropDownNotRaidInitialize = function()
	local counter, entry;

	for counter = 1, table.getn(Napoleon.data["ddraid"]) do
		entry = { text = Napoleon.data["ddraid"][counter]; checked = nil; func = Napoleon.BandDropDownNotRaidOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.BandDropDownNotRaidOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownNotRaid,this:GetID());
end

Napoleon.BandDropDownNotGroupInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddgroup"]) do
		entry = { text = Napoleon.data["ddgroup"][counter]; checked = nil; func = Napoleon.BandDropDownNotGroupOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.BandDropDownNotGroupOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownNotGroup,this:GetID());
end

Napoleon.BandDropDownNotOtherInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddother"]) do
		entry = { text = Napoleon.data["ddother"][counter]; checked = nil; func = Napoleon.BandDropDownNotOtherOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.BandDropDownNotOtherOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameBandOptionsDropDownNotOther,this:GetID());
end
