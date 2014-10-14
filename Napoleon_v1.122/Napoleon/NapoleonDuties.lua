Napoleon.DutyCreate = function()
	Napoleon.ClearOptions();
	Napoleon.data["dutyshow"]["status"] = "new";
	Napoleon.DutyFrameUpdate();
	NapoleonFrameDutyOptions:Show();
	NapoleonFrameDutyOptionsCombat:Hide();
	NapoleonFrameDutyOptionsDefense:Hide();
end

Napoleon.DutyDelete = function()
	Napoleon.ClearOptions();

	-- remove entry
	if (Napoleon.data["dutyshow"]["name"] ~= "") then
		table.remove(Napoleon.data["tankarray"],Napoleon.data["tankassoc"][Napoleon.data["dutyshow"]["name"]]);

		-- re-generate the assoc
		Napoleon.data["tankassoc"] = {};
		for counter = 1, table.getn(Napoleon.data["tankarray"]) do
			Napoleon.data["tankassoc"][Napoleon.data["tankarray"][counter]["name"]] = counter;
		end
	end

	Napoleon.data["dutyshow"]["name"] = "";
end

Napoleon.DutyNameCreate = function(entry)
	local counter, name;

	-- combat type
	if (Napoleon.data["dutytype"][entry["type"]["filter"]] == "combat") then
		return entry["target"]["filter"];
	-- defense type
	else
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

		return name;
	end
end

Napoleon.DutySave = function()
	local entry = {};
	local tempentry = {};
	local minfilter, counter;

	entry["name"] = NapoleonFrameDutyOptionsLabel:GetText();
	entry["type"] = {};
	entry["type"]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsDropDownType);
	entry["type"]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDropDownType);
	
	entry["target"] = {};
	entry["target"]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsCombatDropDownTarget);
	entry["target"]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsCombatDropDownTarget);
	
	entry["filter"] = {};
	entry["filter"][1] = {};
	entry["filter"][1]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownRaid);
	entry["filter"][1]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownRaid);
	entry["filter"][2] = {};
	entry["filter"][2]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownGroup);
	entry["filter"][2]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownGroup);
	entry["filter"][3] = {};
	entry["filter"][3]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownOther);
	entry["filter"][3]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownOther);
	entry["filter"][4] = {};
	entry["filter"][4]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownNotRaid);
	entry["filter"][4]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownNotRaid);
	entry["filter"][5] = {};
	entry["filter"][5]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownNotGroup);
	entry["filter"][5]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownNotGroup);
	entry["filter"][6] = {};
	entry["filter"][6]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownNotOther);
	entry["filter"][6]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownNotOther);
	entry["filter"][7] = {};
	entry["filter"][7]["id"] = UIDropDownMenu_GetSelectedID(NapoleonFrameDutyOptionsCombatDropDownTarget);
	entry["filter"][7]["filter"] = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsCombatDropDownTarget);

	if (Napoleon.data["dutytype"][entry["type"]["filter"]] == "defense") then
		minfilter = false;
		for counter = 1, 6 do
			if (entry["filter"][counter]["filter"] ~= nil and entry["filter"][counter]["filter"] ~= "") then
				minfilter = true;
			end
		end
	end

	if (entry["type"]["id"] == nil) then
		Napoleon.ChatFrameOutput("Duty type not selected");
	elseif (Napoleon.data["dutytype"][entry["type"]["filter"]] == "combat" and entry["target"]["id"] == nil) then
		Napoleon.ChatFrameOutput("Duty target not selected");
	elseif (Napoleon.data["dutytype"][entry["type"]["filter"]] == "defense" and minfilter == false) then
		Napoleon.ChatFrameOutput("Minimum one filter required");
	-- started by editing duty
	elseif (Napoleon.data["dutyshow"]["name"] ~= "") then
		tempentry = Napoleon.data["tankarray"][Napoleon.data["tankassoc"][Napoleon.data["dutyshow"]["name"]]];
		tempentry["name"] = entry["name"];
		tempentry["type"] = entry["type"];
		tempentry["target"] = entry["target"];
		tempentry["filter"] = entry["filter"];

		-- if name changed
		if (Napoleon.data["dutyshow"]["name"] ~= entry["name"]) then
			-- if new name already exists
			if (Napoleon.data["tankassoc"][entry["name"]] ~= nil) then
				Napoleon.ChatFrameOutput("name already exists");
			else
				-- remove old entry
				table.remove(Napoleon.data["tankarray"],Napoleon.data["tankassoc"][Napoleon.data["dutyshow"]["name"]]);

				-- add new entry
				table.insert(Napoleon.data["tankarray"],tempentry);

				-- re-generate the assoc
				Napoleon.data["tankassoc"] = {};
				for counter = 1, table.getn(Napoleon.data["tankarray"]) do
					Napoleon.data["tankassoc"][Napoleon.data["tankarray"][counter]["name"]] = counter;
				end

				Napoleon.ClearOptions();
				Napoleon.data["dutyshow"]["name"] = "";
			end
		-- name stayed the same
		else
			Napoleon.data["tankarray"][Napoleon.data["tankassoc"][tempentry["name"]]] = tempentry;
			Napoleon.ClearOptions();
			Napoleon.data["dutyshow"]["name"] = "";
			Napoleon.data["dutyshow"]["status"] = "";
		end
	-- new duty
	else
		-- create a name if not given
		if (not string.find(entry["name"],"%a+")) then
			entry["name"] = Napoleon.DutyNameCreate(entry);
		end

		entry["unitid"] = "DUTY";
		entry["fwstatus"] = 0;
		entry["checked"] = false;
		table.insert(Napoleon.data["tankarray"],entry);
		Napoleon.data["tankassoc"][entry["name"]] = table.getn(Napoleon.data["tankarray"]);

		Napoleon.ClearOptions();
		Napoleon.data["dutyshow"]["name"] = "";
		Napoleon.data["dutyshow"]["status"] = "";
	end
end

Napoleon.DutyFrameUpdate = function()
	local typefilter;

	-- no loading for now

	-- editing
	if (Napoleon.data["dutyshow"]["status"] == "edit") then
		typefilter = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDropDownType);
		if (Napoleon.data["dutyicons"][typefilter] ~= nil) then
			NapoleonFrameDutyOptionsIcon:SetTexture("Interface\\Icons\\".. Napoleon.data["dutyicons"][typefilter]);
			NapoleonFrameDutyOptionsIcon:Show();

			if (Napoleon.data["dutytype"][typefilter] == "combat") then
				NapoleonFrameDutyOptionsCombat:Show();
				NapoleonFrameDutyOptionsDefense:Hide();
			elseif (Napoleon.data["dutytype"][typefilter] == "defense") then
				NapoleonFrameDutyOptionsCombat:Hide();
				NapoleonFrameDutyOptionsDefense:Show();
			end
		end

	-- creating
	elseif (Napoleon.data["dutyshow"]["status"] == "new") then
		NapoleonFrameDutyOptionsLabel:SetText("");
		NapoleonFrameDutyOptionsIcon:Hide();

		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsDropDownType,Napoleon.DutyDropDownTypeInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsDropDownType);
		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsCombatDropDownTarget,Napoleon.DutyDropDownTargetInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsCombatDropDownTarget);

		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsDefenseDropDownRaid,Napoleon.DutyDropDownRaidInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsDefenseDropDownRaid);
		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsDefenseDropDownGroup,Napoleon.DutyDropDownGroupInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsDefenseDropDownGroup);
		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsDefenseDropDownOther,Napoleon.DutyDropDownGroupInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsDefenseDropDownOther);
		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsDefenseDropDownNotRaid,Napoleon.DutyDropDownNotRaidInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsDefenseDropDownNotRaid);
		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsDefenseDropDownNotGroup,Napoleon.DutyDropDownNotGroupInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsDefenseDropDownNotGroup);
		UIDropDownMenu_Initialize(NapoleonFrameDutyOptionsDefenseDropDownNotOther,Napoleon.DutyDropDownNotOtherInitialize);
		UIDropDownMenu_SetText("",NapoleonFrameDutyOptionsDefenseDropDownNotOther);

		Napoleon.data["dutyshow"]["name"] = "";
		Napoleon.data["dutyshow"]["status"] = "edit";
	end
end

Napoleon.DutyPlayersScrollBarUpdate = function()
	local filter, dutycount, dutyoffset, dutyframe, dutycolor, dutyname, dutyextras, counterrow, raidkey, class;
	local filterlist = {};

	if (Napoleon.data["loaded"] == false) then
		return;
	end

	filter = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownRaid);
	if (filter ~= nil) then
		table.insert(filterlist,filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownGroup);
	if (filter ~= nil) then
		table.insert(filterlist,filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownOther);
	if (filter ~= nil) then
		table.insert(filterlist,filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownNotRaid);
	if (filter ~= nil) then
		table.insert(filterlist,"!".. filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownNotGroup);
	if (filter ~= nil) then
		table.insert(filterlist,"!".. filter);
	end
	filter = UIDropDownMenu_GetText(NapoleonFrameDutyOptionsDefenseDropDownNotOther);
	if (filter ~= nil) then
		table.insert(filterlist,"!".. filter);
	end
	table.insert(filterlist,"NONBAND");

	dutycount = Napoleon.FilterCount(filterlist);

	-- xmlobject, entries, visible rows, row height
	FauxScrollFrame_Update(NapoleonFrameDutyOptionsDefensePlayerScrollBar,dutycount,6,16);

	if (dutycount > 6) then
		NapoleonFrameDutyOptionsDefensePlayerScrollBar:Show();
	else
		NapoleonFrameDutyOptionsDefensePlayerScrollBar:Hide();
	end

	for counterrow = 1, 6 do
		dutyoffset = counterrow + FauxScrollFrame_GetOffset(NapoleonFrameDutyOptionsDefensePlayerScrollBar);
		dutyframe = "NapoleonFrameDutyOptionsDefensePlayer".. counterrow;
		dutyextras = "";

		if (dutyoffset <= dutycount) then
			raidkey = Napoleon.FilterFind(filterlist,dutyoffset);
			dutyname = Napoleon.data["raidarray"][raidkey]["name"];

			class = Napoleon.data["raidarray"][raidkey]["class"];
			getglobal(dutyframe.."SubGroup"):SetText(Napoleon.data["raidarray"][raidkey]["subgroup"]);

			if (Napoleon.data["raidarray"][raidkey]["online"] ~= 1) then
				getglobal(dutyframe.."OAZ"):SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
				getglobal(dutyframe.."OAZ"):SetAlpha(1);
			elseif (Napoleon.data["raidarray"][raidkey]["isdead"] == 1) then
				getglobal(dutyframe.."OAZ"):SetTexture("Interface\\TargetingFrame\\TargetDead");
				getglobal(dutyframe.."OAZ"):SetAlpha(1);
			elseif (Napoleon.data["raidarray"][raidkey]["zone"] ~= Napoleon.data["zonetext"]) then
				getglobal(dutyframe.."OAZ"):SetTexture("Interface\\WorldMap\\WorldMap-Icon");
				getglobal(dutyframe.."OAZ"):SetAlpha(1);
			else
				getglobal(dutyframe.."OAZ"):SetTexture("Interface\\Buttons\\UI-CheckBox-Check");
				getglobal(dutyframe.."OAZ"):SetAlpha(0.25);
			end

			dutycolor = Napoleon.data["class"][Napoleon.data["raidarray"][raidkey]["class"]]["color"];
			getglobal(dutyframe.."Name"):SetTextColor(dutycolor["r"],dutycolor["g"],dutycolor["b"],1);
			getglobal(dutyframe.."Name"):SetText(dutyname);

			getglobal(dutyframe):Show();
		else
			getglobal(dutyframe):Hide();
		end
	end
end

Napoleon.DutyDropDownTypeInitialize = function()
	local counter, entry;

	for counter = 1, table.getn(Napoleon.data["duty"]) do
		entry = { text = Napoleon.data["duty"][counter]; checked = nil; func = Napoleon.DutyDropDownTypeOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownTypeOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsDropDownType,this:GetID());
	Napoleon.DutyDropDownTargetInitialize();
end







Napoleon.DutyDropDownTargetInitialize = function()
	local counter, entry;

	for counter = 1, table.getn(Napoleon.data["dutytarget"]) do
		entry = { text = Napoleon.data["dutytarget"][counter]; checked = nil; func = Napoleon.DutyDropDownTargetOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownTargetOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsCombatDropDownTarget,this:GetID());
end









Napoleon.DutyDropDownRaidInitialize = function()
	local counter, entry;

	for counter = 1, table.getn(Napoleon.data["ddraid"]) do
		entry = { text = Napoleon.data["ddraid"][counter]; checked = nil; func = Napoleon.DutyDropDownRaidOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownRaidOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownRaid,this:GetID());
end


Napoleon.DutyDropDownGroupInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddgroup"]) do
		entry = { text = Napoleon.data["ddgroup"][counter]; checked = nil; func = Napoleon.DutyDropDownGroupOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownGroupOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownGroup,this:GetID());
end


Napoleon.DutyDropDownOtherInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddother"]) do
		entry = { text = Napoleon.data["ddother"][counter]; checked = nil; func = Napoleon.DutyDropDownOtherOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownOtherOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownOther,this:GetID());
end




Napoleon.DutyDropDownNotRaidInitialize = function()
	local counter, entry;

	for counter = 1, table.getn(Napoleon.data["ddraid"]) do
		entry = { text = Napoleon.data["ddraid"][counter]; checked = nil; func = Napoleon.DutyDropDownNotRaidOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownNotRaidOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownNotRaid,this:GetID());
end


Napoleon.DutyDropDownNotGroupInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddgroup"]) do
		entry = { text = Napoleon.data["ddgroup"][counter]; checked = nil; func = Napoleon.DutyDropDownNotGroupOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownNotGroupOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownNotGroup,this:GetID());
end


Napoleon.DutyDropDownNotOtherInitialize = function()
	local entry, counter;

	for counter = 1, table.getn(Napoleon.data["ddother"]) do
		entry = { text = Napoleon.data["ddother"][counter]; checked = nil; func = Napoleon.DutyDropDownNotOtherOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.DutyDropDownNotOtherOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameDutyOptionsDefenseDropDownNotOther,this:GetID());
end
