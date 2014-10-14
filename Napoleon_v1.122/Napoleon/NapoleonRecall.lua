	Napoleon.Recall = function()
	Napoleon.ClearOptions();
	Napoleon.data["recallshow"]["status"] = "new";
	Napoleon.RecallFrameUpdate();
	NapoleonFrameRecallOptions:Show();
end

Napoleon.RecallFrameUpdate = function()
	-- creating
	if (Napoleon.data["recallshow"]["status"] == "new") then
		Napoleon.data["recallshow"]["status"] = "edit";
	end
end

Napoleon.RecallDelete = function()
	local dungeon, encounter, counter;

	dungeon = UIDropDownMenu_GetText(NapoleonFrameRecallOptionsDropDownDungeon);
	encounter = UIDropDownMenu_GetText(NapoleonFrameRecallOptionsDropDownEncounter);

	if (dungeon ~= nil) then
		if (encounter ~= nil) then
			if (NapoleonSaved["recalldata"][dungeon] ~= nil and NapoleonSaved["recalldata"][dungeon][encounter] ~= nil) then
				NapoleonSaved["recalldata"][dungeon][encounter] = nil;
				UIDropDownMenu_Initialize(NapoleonFrameRecallOptionsDropDownEncounter,Napoleon.RecallDropDownEncounterInitialize);

				Napoleon.ChatFrameOutput(dungeon .." ".. encounter .." deleted");
			end
		else
			Napoleon.ChatFrameOutput("Dungeon and Encounter required");
		end

		-- remove empty dungeons
		counter = 0;
		for key in NapoleonSaved["recalldata"][dungeon] do
			counter = counter + 1;
		end
		if (counter == 0) then
			NapoleonSaved["recalldata"][dungeon] = nil;
			UIDropDownMenu_SetText(nil,NapoleonFrameRecallOptionsDropDownDungeon);
			UIDropDownMenu_SetText(nil,NapoleonFrameRecallOptionsDropDownEncounter);
			UIDropDownMenu_Initialize(NapoleonFrameRecallOptionsDropDownDungeon,Napoleon.RecallDropDownDungeonInitialize);
			UIDropDownMenu_Initialize(NapoleonFrameRecallOptionsDropDownEncounter,Napoleon.RecallDropDownEncounterInitialize);

			Napoleon.ChatFrameOutput(dungeon .." deleted");
		end

		NapoleonFrameRecallOptionsDungeonLabel:SetText("");
		NapoleonFrameRecallOptionsEncounterLabel:SetText("");
	end
end

Napoleon.RecallSave = function()
	local dungeon, encounter, broadcast = "";
	local dutylist, bandlist = {};
	local dutycounter, bandcounter;

	dungeon = NapoleonFrameRecallOptionsDungeonLabel:GetText();
	encounter = NapoleonFrameRecallOptionsEncounterLabel:GetText();
	broadcast = NapoleonFrameBroadcastOptionsScrollFrameText:GetText();

	dutylist = {};
	bandlist = {};

	if (dungeon ~= "" and encounter ~= "") then
		for dutycounter = 1, table.getn(Napoleon.data["tankarray"]) do
			if (Napoleon.data["tankarray"][dutycounter]["unitid"] == "DUTY") then
				table.insert(dutylist,Napoleon.data["tankarray"][dutycounter]);
			end
		end

		for bandcounter = 1, table.getn(Napoleon.data["raidarray"]) do
			if (Napoleon.data["raidarray"][bandcounter]["class"] == "BAND") then
				table.insert(bandlist,Napoleon.data["raidarray"][bandcounter]);
			end
		end

		if (table.getn(dutylist) == 0 and table.getn(bandlist) == 0) then
			Napoleon.ChatFrameOutput("Minimum 1 duty or band required");
		else
			if (NapoleonSaved["recalldata"][dungeon] == nil) then
				NapoleonSaved["recalldata"][dungeon] = {};
			end
			if (NapoleonSaved["recalldata"][dungeon][encounter] == nil) then
				NapoleonSaved["recalldata"][dungeon][encounter] = {};
			end

			NapoleonSaved["recalldata"][dungeon][encounter]["dutyarray"] = dutylist;
			NapoleonSaved["recalldata"][dungeon][encounter]["bandarray"] = bandlist;
			NapoleonSaved["recalldata"][dungeon][encounter]["broadcast"] = broadcast;

			Napoleon.ChatFrameOutput(dungeon .." ".. encounter .." saved");
		end
	else
		Napoleon.ChatFrameOutput("Dungeon and Encounter required");
	end
end

Napoleon.RecallLoad = function()
	local dungeon, encounter, broadcast = "";
	local dutylist, bandlist = {};
	local dutycounter, bandcounter;

	dungeon = UIDropDownMenu_GetText(NapoleonFrameRecallOptionsDropDownDungeon);
	encounter = UIDropDownMenu_GetText(NapoleonFrameRecallOptionsDropDownEncounter);

	if (dungeon ~= nil and encounter ~= nil) then
		NapoleonFrameRecallOptionsDungeonLabel:SetText(dungeon);
		NapoleonFrameRecallOptionsEncounterLabel:SetText(encounter);

		Napoleon.data["raidarray"] = NapoleonSaved["recalldata"][dungeon][encounter]["bandarray"];
		Napoleon.data["tankarray"] = NapoleonSaved["recalldata"][dungeon][encounter]["dutyarray"];
		NapoleonFrameBroadcastOptionsScrollFrameText:SetText(NapoleonSaved["recalldata"][dungeon][encounter]["broadcast"]);

		Napoleon.ChatFrameOutput(dungeon .." ".. encounter .." loaded");
	else
		Napoleon.ChatFrameOutput("Dungeon and Encounter required");
	end
end


Napoleon.RecallDropDownDungeonInitialize = function()
	local key, data, entry;

	if (Napoleon.data["loaded"] == true and NapoleonSaved["recalldata"] ~= nil) then
		for key, data in NapoleonSaved["recalldata"] do
			entry = { text = key; checked = nil; func = Napoleon.RecallDropDownDungeonOnClick };
			UIDropDownMenu_AddButton(entry);
		end
	end
end

Napoleon.RecallDropDownDungeonOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameRecallOptionsDropDownDungeon,this:GetID());
end


Napoleon.RecallDropDownEncounterInitialize = function()
	local dungeon, key, data, entry;

	dungeon = UIDropDownMenu_GetText(NapoleonFrameRecallOptionsDropDownDungeon);

	if (Napoleon.data["loaded"] == true and NapoleonSaved["recalldata"][dungeon] ~= nil) then
		for key, data in NapoleonSaved["recalldata"][dungeon] do
			entry = { text = key; checked = nil; func = Napoleon.RecallDropDownEncounterOnClick };
			UIDropDownMenu_AddButton(entry);
		end
	end
end

Napoleon.RecallDropDownEncounterOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameRecallOptionsDropDownEncounter,this:GetID());
end
