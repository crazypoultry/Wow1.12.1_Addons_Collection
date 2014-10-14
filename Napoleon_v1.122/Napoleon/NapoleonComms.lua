Napoleon.ChatFrameInit = function()
	if (ChatFrame_OnEvent ~= Napoleon.ChatFrameHook) then
		-- get chatframe events to allow us to hide chat
		Napoleon.data["origchatframehook"] = ChatFrame_OnEvent;
		ChatFrame_OnEvent = Napoleon.ChatFrameHook;
	end
end

Napoleon.ChatFrameHook = function()
	-- process and hide chat
	if (arg1 and arg2) then
		-- incoming whisper
		if (event == "CHAT_MSG_WHISPER") then
			-- player requesting their assignment
 			if (arg1 == "!nap" and Napoleon.ProcessWhisper(arg1,arg2)) then
				Napoleon.ChatLog(event,arg1,arg2);
				return;
			elseif (arg1 == "!fap") then
				Napoleon.ChatLog(event,arg1,arg2);
				DoEmote(Napoleon.data["emotes"][math.random(table.getn(Napoleon.data["emotes"]))],arg2);
				return;
			-- napolean whisper message
			elseif (string.find(arg1,"^nap_[%d.]+") and Napoleon.ProcessChatRequest(arg1,arg2)) then
				Napoleon.ChatLog(event,arg1,arg2);
				return;
			end
		-- outgoing napoleon whisper
		elseif (event == "CHAT_MSG_WHISPER_INFORM") then
			if (string.find(arg1,"^nap_[%d.]+") or string.find(arg1,"^Napoleon: ")) then
				Napoleon.ChatLog(event,arg1,arg2);
				if (NapoleonSaved["broadcast"]["showwhispercheck"] ~= 1 or string.find(arg1,"^nap_[%d.]+")) then
					return;
				end
			end
		-- addon channel event
		elseif (event == "CHAT_MSG_ADDON") then
			if (arg1 == "nap_" and Napoleon.ProcessChatRequest(arg1 .. arg2,arg4)) then
				Napoleon.ChatLog(event,arg1 .. arg2,arg4);
				return;
			end
		end
	end
	
	-- call original function to display the chat
	Napoleon.data["origchatframehook"](event);
end

Napoleon.ChatLog = function(event, message, sender)
	if (Napoleon.data["chatlog"] == nil) then
		Napoleon.data["chatlog"] = {}
	end

	table.insert(Napoleon.data["chatlog"],GetTime() ..": (".. sender ..") event: ".. event .." ".. message);
	if (table.getn(Napoleon.data["chatlog"]) > 200) then
		table.remove(Napoleon.data["chatlog"],1);
	end

--	local debugstring = "";
--	for counter = 1, table.getn(Napoleon.data["chatlog"]) do
--		debugstring = debugstring .."\n".. Napoleon.data["chatlog"][counter]
--	end
--	NapoleonFrameBroadcastOptionsScrollFrameText:SetText(debugstring);
end

Napoleon.ProcessChatRequest = function(message, sender)
	local key, value, parts, tempvar, version, counter, incoption, inctype, incdata, entries, entriescounter, chatkey, chatlist, sendstring, channelid, channelname;

	-- remove older than 3 second processed commands
	for key, value in pairs(Napoleon.data["chatjob"]) do
		-- if processed more than 3 seconds ago
		if (time() - value > 3) then
			Napoleon.data["chatjob"][key] = nil;
		end
	end

	-- examples
	-- nap_1.05&rec_tal_1125#1213#1222&rec_rea_40#6
	-- nap_1.05&req_pri_all
	-- nap_1.05&req_pri_tal#att#rea
	-- nap_1.05&req_pub_all

	-- convert requests into a chat reply queue
	parts = Napoleon.Split(message,"&");
	tempvar = Napoleon.Split(table.remove(parts,1),"_");
	version = table.remove(tempvar,2);

	chatlist = { ["pri"] = {}, ["pub"] = {}, };

	for counter = 1, table.getn(parts) do
		tempvar = Napoleon.Split(parts[counter],"_");
		incoption = tempvar[1];
		inctype = tempvar[2];
		incdata = tempvar[3];

		-- received data
		if (incoption == "rec") then
			Napoleon.SavePlayer(version,sender,inctype,incdata);
		-- requested data
		elseif (incoption == "req") then
			entries = Napoleon.Split(incdata,"#");

			for entriescounter = 1, table.getn(entries) do
				if (inctype == "pri") then
					chatkey = sender .."-".. inctype .."-".. entries[entriescounter];
				else
					chatkey = inctype .."-".. entries[entriescounter];
				end

				-- not recently processed
				if (Napoleon.data["chatjob"][chatkey] == nil) then
					-- process
					if (entries[entriescounter] == "all") then
						Napoleon.GetTalents();
						Napoleon.GetAttributes();
						Napoleon.GetResistances();
						Napoleon.GetDurability();
						Napoleon.GetInventoryItems();
						Napoleon.GetTrades();

						if (inctype == "pri") then
							chatlist["pri"] = { ["tal"] = 1, ["att"] = 1, ["res"] = 1, ["dur"] = 1, ["rea"] = 1, ["tra"] = 1 };
						elseif (inctype == "pub") then
							chatlist["pub"] = { ["tal"] = 1, ["att"] = 1, ["res"] = 1, ["dur"] = 1, ["rea"] = 1, ["tra"] = 1 };
						end
					elseif (entries[entriescounter] == "tal") then
						Napoleon.GetTalents();

						if (inctype == "pri") then
							chatlist["pri"]["tal"] = 1;
						elseif (inctype == "pub") then
							chatlist["pub"]["tal"] = 1;
						end
					elseif (entries[entriescounter] == "att") then
						Napoleon.GetAttributes();

						if (inctype == "pri") then
							chatlist["pri"]["att"] = 1;
						elseif (inctype == "pub") then
							chatlist["pub"]["att"] = 1;
						end
					elseif (entries[entriescounter] == "res") then
						Napoleon.GetResistances();

						if (inctype == "pri") then
							chatlist["pri"]["res"] = 1;
						elseif (inctype == "pub") then
							chatlist["pub"]["res"] = 1;
						end
					elseif (entries[entriescounter] == "dur") then
						Napoleon.GetDurability();

						if (inctype == "pri") then
							chatlist["pri"]["dur"] = 1;
						elseif (inctype == "pub") then
							chatlist["pub"]["dur"] = 1;
						end
					elseif (entries[entriescounter] == "rea") then
						Napoleon.GetInventoryItems();

						if (inctype == "pri") then
							chatlist["pri"]["rea"] = 1;
						elseif (inctype == "pub") then
							chatlist["pub"]["rea"] = 1;
						end
					elseif (entries[entriescounter] == "tra") then
						Napoleon.GetTrades();

						if (inctype == "pri") then
							chatlist["pri"]["tra"] = 1;
						elseif (inctype == "pub") then
							chatlist["pub"]["tra"] = 1;
						end
					end

					-- place in chatjob assoc
					Napoleon.data["chatjob"][chatkey] = time();
				-- discarded request
				else
				
				end
			end

			-- examples
			-- nap_1.05&rec_tal_1125#1213#1222&rec_rea_40#6

			-- whispers 
			sendstring = "";
			for key, value in pairs(chatlist["pri"]) do
				-- send current string
				if (string.len(sendstring) + string.len(NapoleonSaved["playerdata"][Napoleon.data["playername"]][key]) > 246) then
					SendChatMessage("nap_".. Napoleon.data["version"] .. sendstring,"WHISPER",nil,sender);
					sendstring = "&rec_".. key .."_".. NapoleonSaved["playerdata"][Napoleon.data["playername"]][key];
				elseif (key ~= "" and key ~= nil) then
					sendstring = sendstring .."&rec_".. key .."_".. NapoleonSaved["playerdata"][Napoleon.data["playername"]][key];
				end
			end
			if (sendstring ~= "") then
				SendChatMessage("nap_".. Napoleon.data["version"] .. sendstring,"WHISPER",nil,sender);
			end

			sendstring = "";
			for key, value in pairs(chatlist["pub"]) do
				-- send current string
				if (string.len(sendstring) + string.len(NapoleonSaved["playerdata"][Napoleon.data["playername"]][key]) > 244) then
					SendAddonMessage("nap_",Napoleon.data["version"] .. sendstring,"RAID");
					sendstring = "&rec_".. key .."_".. NapoleonSaved["playerdata"][Napoleon.data["playername"]][key];
				elseif (key ~= "" and key ~= nil) then
					sendstring = sendstring .."&rec_".. key .."_".. NapoleonSaved["playerdata"][Napoleon.data["playername"]][key];
				end
			end
			if (sendstring ~= "") then
				SendAddonMessage("nap_",Napoleon.data["version"] .. sendstring,"RAID");
			end
		end
	end

	-- volunteer player data every 60 seconds
	if (time() - Napoleon.data["playerdatasent"] > 60) then
		Napoleon.data["playerdatasent"] = time();
		Napoleon.ProcessChatRequest("nap_".. Napoleon.data["version"] .."&req_pub_all",Napoleon.data["playername"]);
	end

	return true;
end

Napoleon.ChannelDropDownInitialize = function()
	local counter, id, name;
	local entry = {};

	if (Napoleon.data["loaded"] == false) then
		return;
	end

	entry = { text = "RAID"; checked = nil; func = Napoleon.ChannelDropDownOnClick; };
	UIDropDownMenu_AddButton(entry);

	if (IsInGuild()) then
		entry = { text = "GUILD"; checked = nil; func = Napoleon.ChannelDropDownOnClick; };
		UIDropDownMenu_AddButton(entry);
	end

	for counter = 1, 15 do
		id, name = GetChannelName(counter);
		if (id ~= 0) then
			if (not string.find(name,"General -") and not string.find(name,"Trade -") and not string.find(name,"LookingForGroup -") and not string.find(name,"LocalDefense -")) then
				entry = { text = name; checked = nil; func = Napoleon.ChannelDropDownOnClick; };
				UIDropDownMenu_AddButton(entry);
			end
		end
	end
end

Napoleon.ChannelDropDownOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameBroadcastOptionsChannelDropDown,this:GetID());
end

Napoleon.BroadcastOptions = function()
	if (NapoleonFrameBroadcastOptions:IsVisible()) then
		NapoleonFrameBroadcastOptions:Hide();
	else
		Napoleon.ClearOptions();

		-- copy current data into old vars
		Napoleon.data["oldbroadcast"] = {};
		Napoleon.data["oldbroadcast"]["channel"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBroadcastOptionsChannelDropDown);
		Napoleon.data["oldbroadcast"]["sendtextcheck"] = NapoleonFrameBroadcastOptionsSendTextCheck:GetChecked();
		Napoleon.data["oldbroadcast"]["sendlistcheck"] = NapoleonFrameBroadcastOptionsSendListCheck:GetChecked();
		Napoleon.data["oldbroadcast"]["showwhispercheck"] = NapoleonFrameBroadcastOptionsShowWhisperCheck:GetChecked();
		Napoleon.data["oldbroadcast"]["text"] = NapoleonFrameBroadcastOptionsScrollFrameText:GetText();

		NapoleonFrameBroadcastOptions:Show();
	end
end

Napoleon.BroadcastCancel = function()
	-- copy old data into frame
	UIDropDownMenu_SetSelectedID(NapoleonFrameBroadcastOptionsChannelDropDown, Napoleon.data["oldbroadcast"]["channel"]);
	NapoleonFrameBroadcastOptionsSendTextCheck:SetChecked(Napoleon.data["oldbroadcast"]["sendtextcheck"]);
	NapoleonFrameBroadcastOptionsSendListCheck:SetChecked(Napoleon.data["oldbroadcast"]["sendlistcheck"]);
	NapoleonFrameBroadcastOptionsShowWhisperCheck:SetChecked(Napoleon.data["oldbroadcast"]["showwhispercheck"]);
	NapoleonFrameBroadcastOptionsScrollFrameText:SetText(Napoleon.data["oldbroadcast"]["text"]);

	NapoleonSaved["broadcast"] = {};
	NapoleonSaved["broadcast"]["channel"] = UIDropDownMenu_GetSelectedID(NapoleonFrameBroadcastOptionsChannelDropDown);
	NapoleonSaved["broadcast"]["sendtextcheck"] = NapoleonFrameBroadcastOptionsSendTextCheck:GetChecked();
	NapoleonSaved["broadcast"]["sendlistcheck"] = NapoleonFrameBroadcastOptionsSendListCheck:GetChecked();
	NapoleonSaved["broadcast"]["showwhispercheck"] = NapoleonFrameBroadcastOptionsShowWhisperCheck:GetChecked();
	NapoleonSaved["broadcast"]["text"] = NapoleonFrameBroadcastOptionsScrollFrameText:GetText();

	Napoleon.ClearOptions();
end

Napoleon.Broadcast = function()
	local tankcounter, filtercounter, filterlist, bandfound, bandcount, bandcounter, tempentry, raidcounter, healfound;
	local broadcastpass, line, linelist, linecounter, customtext;
	local channelid, channelname;

	-- channel selected
	if (UIDropDownMenu_GetText(NapoleonFrameBroadcastOptionsChannelDropDown) ~= nil) then
		-- if sending list
		if (NapoleonFrameBroadcastOptionsSendListCheck:GetChecked() ~= nil) then
			-- have at least one tank and at least one allocated healer
			if (table.getn(Napoleon.data["tankarray"]) > 0) then
				broadcastpass = true;

				-- check to see if every tank has at least one healer
				for tankcounter = 1, table.getn(Napoleon.data["tankarray"]) do
					healfound = 0;
					for raidcounter = 1, table.getn(Napoleon.data["raidarray"]) do
						if (Napoleon.data["raidarray"][raidcounter]["tankname"] == Napoleon.data["tankarray"][tankcounter]["name"]) then
							healfound = healfound + 1;
						end
					end

					if (healfound == 0) then
						broadcastpass = false;
					end
				end

				if (broadcastpass == true) then
					linelist = {};
					bandfound = 0;

					for tankcounter = 1, table.getn(Napoleon.data["tankarray"]) do
						line = "";

						if (Napoleon.data["tankarray"][tankcounter]["unitid"] == "DUTY") then
							tempentry = Napoleon.data["tankarray"][tankcounter];
							-- combat duty just has a target
							if (Napoleon.data["dutytype"][tempentry["type"]["filter"]] == "combat") then
								line = tempentry["type"]["filter"] .." ".. tempentry["target"]["filter"] .." Duty: ";
							-- defense duty raid dropdowns
							else
								line = "*".. tempentry["type"]["filter"];
								for filtercounter = 1, table.getn(tempentry["filter"]) do
									if (tempentry["filter"][filtercounter]["filter"] ~= "" and tempentry["filter"][filtercounter]["filter"] ~= nil) then
										if (filtercounter <= 3) then
											line = line .. " ".. tempentry["filter"][filtercounter]["filter"];
										else
											line = line .. " not ".. tempentry["filter"][filtercounter]["filter"];
										end
									end
								end

								line = line .. " Duty: ";
							end
						else
							line = Napoleon.data["tankarray"][tankcounter]["name"] ..": ";
						end

						healfound = 0;
						filterlist = {};

						for raidcounter = 1, table.getn(Napoleon.data["raidarray"]) do
							if (Napoleon.data["raidarray"][raidcounter]["tankname"] == Napoleon.data["tankarray"][tankcounter]["name"]) then
								if (Napoleon.data["raidarray"][raidcounter]["class"] == "BAND") then
									-- create the filterlist
									tempentry = Napoleon.data["raidarray"][raidcounter];
									filterlist = {};
									for filtercounter = 1, table.getn(tempentry["filter"]) do
										if (tempentry["filter"][filtercounter]["filter"] ~= "" and tempentry["filter"][filtercounter]["filter"] ~= nil) then
											if (filtercounter > 3) then
												table.insert(filterlist,"!".. tempentry["filter"][filtercounter]["filter"]);
											else
												table.insert(filterlist,tempentry["filter"][filtercounter]["filter"]);
											end
										end
									end
									table.insert(filterlist,"NONBAND");

									bandcount = Napoleon.FilterCount(filterlist);
									-- more than 4 band mebers we just print shorthand
									if (bandcount > 4) then
										if (healfound > 0) then
											line = line ..", *".. Napoleon.data["raidarray"][raidcounter]["name"];
										else
											line = line .."*".. Napoleon.data["raidarray"][raidcounter]["name"];
										end
										healfound = healfound + 1;
										bandfound = bandfound + 1;
									-- print every member in band
									else
										for filtercounter = 1, bandcount do
											raidkey = Napoleon.FilterFind(filterlist,filtercounter);

											if (healfound > 0) then
												line = line ..", ".. Napoleon.data["raidarray"][raidkey]["name"];
											else
												line = line .. Napoleon.data["raidarray"][raidkey]["name"];
											end
											healfound = healfound + 1;
										end
									end
								else
									if (healfound > 0) then
										line = line ..", ".. Napoleon.data["raidarray"][raidcounter]["name"];
									else
										line = line .. Napoleon.data["raidarray"][raidcounter]["name"];
									end
									healfound = healfound + 1;
								end
							end
						end

						table.insert(linelist,line ..".");
					end

					if (bandfound > 0) then
						table.insert(linelist,"* means a large custom band, whisper me \"!nap\" to receive a breakdown of your duties.");
					end

					channelname = UIDropDownMenu_GetText(NapoleonFrameBroadcastOptionsChannelDropDown);
					if (channelname == "RAID" or channelname == "GUILD") then
						SendChatMessage("--- Napoleon ---",channelname);
						for linecounter = 1, table.getn(linelist) do
							SendChatMessage(linelist[linecounter],channelname);
						end
					else
						channelid, channelname = GetChannelName(channelname);
						SendChatMessage("--- Napoleon ---","CHANNEL",nil,channelid);
						for linecounter = 1, table.getn(linelist) do
							SendChatMessage(linelist[linecounter],"CHANNEL",nil,channelid);
						end
					end
				else
					Napoleon.ChatFrameOutput("At least one tank and one healer assigned required");
				end
			else
				Napoleon.ChatFrameOutput("Every tank or duty requires at least one healer");
			end
		end

		-- if sending text
		if (NapoleonFrameBroadcastOptionsSendTextCheck:GetChecked() ~= nil and NapoleonFrameBroadcastOptionsScrollFrameText:GetNumLetters() > 0) then
			channelname = UIDropDownMenu_GetText(NapoleonFrameBroadcastOptionsChannelDropDown);
			if (channelname == "RAID" or channelname == "GUILD") then
				for line in string.gfind(NapoleonFrameBroadcastOptionsScrollFrameText:GetText(),'[^\n]+') do
					SendChatMessage(line,channelname);
				end
			else
				channelid, channelname = GetChannelName(channelname);
				for line in string.gfind(NapoleonFrameBroadcastOptionsScrollFrameText:GetText(),'[^\n]+') do
					SendChatMessage(line,"CHANNEL",nil,channelid);
				end
			end
		end
	else
		Napoleon.ChatFrameOutput("Please select a channel");
	end
end

Napoleon.ProcessWhisper = function(message, name)
	local counter, list, reply, tempentry, filterlist, filtercounter, bandcount, banddesc, raidkey, chatcount;

	-- sender is in raid
	if (Napoleon.data["raidassoc"][name] ~= nil) then
		list = {};
		reply = "";
		chatcount = 0;

		-- tank sent request
		if (Napoleon.data["tankassoc"][name] ~= nil) then
			for counter = 1, table.getn(Napoleon.data["raidarray"]) do
				if (Napoleon.data["raidarray"][counter]["tankname"] == name) then
					if (Napoleon.data["raidarray"][counter]["class"] == "BAND") then
						tempentry = Napoleon.data["raidarray"][counter];
						filterlist = {};
						for filtercounter = 1, table.getn(tempentry["filter"]) do
							if (tempentry["filter"][filtercounter]["filter"] ~= "" and tempentry["filter"][filtercounter]["filter"] ~= nil) then
								if (filtercounter > 3) then
									table.insert(filterlist,"!".. tempentry["filter"][filtercounter]["filter"]);
								else
									table.insert(filterlist,tempentry["filter"][filtercounter]["filter"]);
								end
							end
						end
						table.insert(filterlist,"NONBAND");

						bandcount = Napoleon.FilterCount(filterlist);

						-- more than 6 band members we just print shorthand
						if (bandcount > 6) then
							banddesc = "";
							for filtercounter = 1, table.getn(tempentry["filter"]) do
								if (tempentry["filter"][filtercounter]["filter"] ~= "" and tempentry["filter"][filtercounter]["filter"] ~= nil) then
									if (filtercounter > 3) then
										banddesc = banddesc .. " not ".. tempentry["filter"][filtercounter]["filter"];
									else
										banddesc = banddesc .. " ".. tempentry["filter"][filtercounter]["filter"];
									end
								end
							end

							table.insert(list,"*".. banddesc);
						-- print every member in band
						else
							for filtercounter = 1, bandcount do
								raidkey = Napoleon.FilterFind(filterlist,filtercounter);
								table.insert(list,Napoleon.data["raidarray"][raidkey]["name"]);
							end
						end
					else
						table.insert(list,Napoleon.data["raidarray"][counter]["name"]);
					end
				end
			end

			-- got at least one match
			if (table.getn(list) > 0) then
				reply = "Your assigned protectors are: ";
				for counter = 1, table.getn(list) do
					if (counter > 1) then
						reply = reply ..", ".. list[counter];
					else
						reply = reply .. list[counter];
					end
				end
			else
				reply = "You currently have no assigned protectors";
			end

			reply = reply ..".";

			if (strlen(reply) > 0) then
				SendChatMessage("Napoleon: ".. reply,"WHISPER",nil,name);
				chatcount = chatcount + 1;
			end
		end

		reply = "";
		-- assigned raid member sent request and not assigned to a duty
		if (Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankname"] ~= nil and Napoleon.data["tankarray"][Napoleon.data["tankassoc"][Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankname"]]]["unitid"] ~= "DUTY") then
			reply = "Your assigned tank is: ".. Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankname"] ..".";
			SendChatMessage("Napoleon: ".. reply,"WHISPER",nil,name);
			chatcount = chatcount + 1;
		end

		list = {};
		reply = "";
		-- assigned duty
		for tankcounter = 1, table.getn(Napoleon.data["tankarray"]) do
			if (Napoleon.data["tankarray"][tankcounter]["unitid"] == "DUTY") then
				tempentry = Napoleon.data["tankarray"][tankcounter];
				-- combat duty just has a target
				if (Napoleon.data["dutytype"][tempentry["type"]["filter"]] == "combat") then
					dutydesc = tempentry["type"]["filter"] .." on ".. tempentry["target"]["filter"];
				-- defense duty raid dropdowns
				else
					filterlist = {};
					dutydesc = "";
					for filtercounter = 1, table.getn(tempentry["filter"]) do
						if (tempentry["filter"][filtercounter]["filter"] ~= "" and tempentry["filter"][filtercounter]["filter"] ~= nil) then
							if (filtercounter <= 3) then
								table.insert(filterlist,tempentry["filter"][filtercounter]["filter"]);
								dutydesc = dutydesc .." ".. tempentry["filter"][filtercounter]["filter"];
							else
								table.insert(filterlist,"!".. tempentry["filter"][filtercounter]["filter"]);
								dutydesc = dutydesc .." not ".. tempentry["filter"][filtercounter]["filter"];
							end
						end
					end
					table.insert(filterlist,"NONBAND");
					dutycount = Napoleon.FilterCount(filterlist);

					if (dutycount > 8) then
						dutydesc = "Duty: ".. tempentry["type"]["filter"] .." on ".. dutydesc;
					-- print every member in band
					else
						dutydesc = "Duty: ".. tempentry["type"]["filter"] .." on ";
						for filtercounter = 1, dutycount do
							raidkey = Napoleon.FilterFind(filterlist,filtercounter);

							if (filtercounter > 1) then
								dutydesc = dutydesc ..", ".. Napoleon.data["raidarray"][raidkey]["name"];
							else
								dutydesc = dutydesc .. Napoleon.data["raidarray"][raidkey]["name"];
							end
						end
					end
				end

				dutyfound = false;
				for raidcounter = 1, table.getn(Napoleon.data["raidarray"]) do
					if (Napoleon.data["raidarray"][raidcounter]["tankname"] == Napoleon.data["tankarray"][tankcounter]["name"]) then
						if (Napoleon.data["raidarray"][raidcounter]["class"] == "BAND") then
							-- create the filterlist
							tempentry = Napoleon.data["raidarray"][raidcounter];
							filterlist = {};
							for filtercounter = 1, table.getn(tempentry["filter"]) do
								if (tempentry["filter"][filtercounter]["filter"] ~= "" and tempentry["filter"][filtercounter]["filter"] ~= nil) then
									if (filtercounter > 3) then
										table.insert(filterlist,"!".. tempentry["filter"][filtercounter]["filter"]);
									else
										table.insert(filterlist,tempentry["filter"][filtercounter]["filter"]);
									end
								end
							end
							table.insert(filterlist,"NONBAND");

							bandcount = Napoleon.FilterCount(filterlist);
							for filtercounter = 1, bandcount do
								raidkey = Napoleon.FilterFind(filterlist,filtercounter);
								if (Napoleon.data["raidarray"][raidkey]["name"] == name) then
									dutyfound = true;
								end
							end
						else
							if (Napoleon.data["raidarray"][raidcounter]["name"] == name) then
								dutyfound = true;
							end
						end
					end
				end

				if (dutyfound == true) then
					SendChatMessage("Napoleon: You are on ".. dutydesc .." duty.","WHISPER",nil,name);
					chatcount = chatcount + 1;
				end
			end
		end

		if (chatcount == 0) then
			SendChatMessage("Napoleon: You are on not assigned on any tank or duty.","WHISPER",nil,name);
		end
	end

	return true;
end

Napoleon.SaveConfig = function(location)
	if (location == "broadcast") then
		NapoleonSaved["broadcast"] = {};
		NapoleonSaved["broadcast"]["sendtextcheck"] = NapoleonFrameBroadcastOptionsSendTextCheck:GetChecked();
		NapoleonSaved["broadcast"]["sendlistcheck"] = NapoleonFrameBroadcastOptionsSendListCheck:GetChecked();
		NapoleonSaved["broadcast"]["showwhispercheck"] = NapoleonFrameBroadcastOptionsShowWhisperCheck:GetChecked();
		NapoleonSaved["broadcast"]["text"] = NapoleonFrameBroadcastOptionsScrollFrameText:GetText();
	end
end