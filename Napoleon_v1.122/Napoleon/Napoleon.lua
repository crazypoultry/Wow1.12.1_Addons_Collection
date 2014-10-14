Napoleon.OnLoad = function()
	-- initialising system
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	-- for fear ward system
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_STOP");

	-- chatframe hook init
	Napoleon.ChatFrameInit();

	NapoleonFrameTitleText:SetText("Napoleon v".. tostring(Napoleon.data["version"]));
	Napoleon.data["loaded"] = true;

	SLASH_NAP1 = "/nap";
	SlashCmdList["NAP"] = function(msg)
		Napoleon.SlashCommand(msg);
	end
end

Napoleon.OnUpdate = function()
	if (Napoleon.data["loaded"] == true) then
		if (GetTime() - Napoleon.data["lastupdate"] >= .5) then
			Napoleon.RefreshRaidArray();
			Napoleon.data["lastupdate"] = GetTime();

			Napoleon.TankScrollBarUpdate();
			Napoleon.HealScrollBarUpdate();
			Napoleon.BandScrollBarUpdate();

			if (Napoleon.data["playershow"]["name"] ~= "") then
				Napoleon.PlayerFrameUpdate();
				NapoleonFramePlayerOptions:Show();
			elseif (Napoleon.data["dutyshow"]["status"] == "edit" or Napoleon.data["dutyshow"]["status"] == "load") then
				Napoleon.DutyFrameUpdate();
				Napoleon.DutyPlayersScrollBarUpdate();
				NapoleonFrameDutyOptions:Show();
			elseif (Napoleon.data["bandshow"]["status"] == "edit" or Napoleon.data["bandshow"]["status"] == "load") then
				Napoleon.BandFrameUpdate();
				Napoleon.BandPlayersScrollBarUpdate();
				NapoleonFrameBandOptions:Show();
			elseif (Napoleon.data["recallshow"]["status"] == "edit" or Napoleon.data["recallshow"]["status"] == "load") then
				Napoleon.RecallFrameUpdate();
				NapoleonFrameRecallOptions:Show();
			end
		end
	end
end

Napoleon.OnEvent = function()
	if (event == "VARIABLES_LOADED") then
		Napoleon.data["debugmode"] = true;
		Napoleon.data["fwfindattempt"] = false;
		Napoleon.data["fwspellbook"] = 0;
		Napoleon.data["fwactionbar"] = 0;
		Napoleon.data["fwattempt"] = "";
		Napoleon.data["playername"] = UnitName("player");
		_, Napoleon.data["playerclass"] = UnitClass("player");
		Napoleon.data["playerdatasent"] = 0;

		Napoleon.data["playershow"] = {};
		Napoleon.data["playershow"]["name"] = "";
		Napoleon.data["playershow"]["tab"] = 1;

		Napoleon.data["bandshow"] = {};
		Napoleon.data["bandshow"]["name"] = "";
		Napoleon.data["bandshow"]["status"] = "new";

		Napoleon.data["dutyshow"] = {};
		Napoleon.data["dutyshow"]["name"] = "";
		Napoleon.data["dutyshow"]["status"] = "new";

		Napoleon.data["recallshow"] = {};
		Napoleon.data["recallshow"]["status"] = "new";

		-- first time ever loading
		if (NapoleonSaved == nil) then
			NapoleonSaved = {};
		end
		if (NapoleonSaved["broadcast"] == nil) then
			NapoleonSaved["broadcast"] = {};
			NapoleonSaved["broadcast"]["text"] = "You can whisper me \"!nap\" at anytime to get your assigned tank, duty, or healers";
			NapoleonSaved["broadcast"]["sendtextcheck"] = 1;
			NapoleonSaved["broadcast"]["sendlistcheck"] = 1;
			NapoleonSaved["broadcast"]["showwhispercheck"] = 1;
		end
		if (NapoleonSaved["playerdata"] == nil) then
			NapoleonSaved["playerdata"] = {};
		end
		if (NapoleonSaved["recalldata"] == nil) then
			NapoleonSaved["recalldata"] = {};
		end

		-- restore config values
		if (NapoleonSaved["broadcast"]["channel"] ~= nil) then
			UIDropDownMenu_SetSelectedID(NapoleonFrameBroadcastOptionsChannelDropDown,NapoleonSaved["broadcast"]["channel"]);
		end
		if (NapoleonSaved["broadcast"]["sendtextcheck"] ~= nil) then
			NapoleonFrameBroadcastOptionsSendTextCheck:SetChecked(NapoleonSaved["broadcast"]["sendtextcheck"]);
		end
		if (NapoleonSaved["broadcast"]["sendlistcheck"] ~= nil) then
			NapoleonFrameBroadcastOptionsSendListCheck:SetChecked(NapoleonSaved["broadcast"]["sendlistcheck"]);
		end
		if (NapoleonSaved["broadcast"]["showwhispercheck"] ~= nil) then
			NapoleonFrameBroadcastOptionsShowWhisperCheck:SetChecked(NapoleonSaved["broadcast"]["showwhispercheck"]);
		end
		if (NapoleonSaved["broadcast"]["text"] ~= nil) then
			NapoleonFrameBroadcastOptionsScrollFrameText:SetText(NapoleonSaved["broadcast"]["text"]);
		end

		NapoleonFrame:Hide();
		Napoleon.ClearOptions();

	elseif (event == "PLAYER_ENTERING_WORLD") then
		Napoleon.data["playerfaction"] = UnitFactionGroup("player");

		if (Napoleon.data["playerfaction"] == "Alliance") then
			Napoleon.data["ddraid"] = { "RAID", "HEALERS", "DPS", "MELEE DPS", "RANGED DPS", "PETS", "AOE", "Dispel", "Druid", "Hunter", "Mage", "Paladin", "Priest", "Rogue", "Warlock", "Warrior", "Rem-Magic", "Rem-Curse", "Rem-Disease", "Rem-Poison" }
		else
			Napoleon.data["ddraid"] = { "RAID", "HEALERS", "DPS", "MELEE DPS", "RANGED DPS", "PETS", "AOE", "Dispel", "Druid", "Hunter", "Mage", "Priest", "Rogue", "Shaman", "Warlock", "Warrior", "Rem-Magic", "Rem-Curse", "Rem-Disease", "Rem-Poison" }
		end

		-- volunteer player data every 60 seconds
		if (time() - Napoleon.data["playerdatasent"] > 60) then
			Napoleon.data["playerdatasent"] = time();
			Napoleon.ProcessChatRequest("nap_".. Napoleon.data["version"] .."&req_pub_all",Napoleon.data["playername"]);
		end

		Napoleon.FindFearWard();

	elseif (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
		if (Napoleon.data["fwattempt"] ~= "") then
			Napoleon.ChatFrameOutput("ERROR: "..UnitName(Napoleon.data["fwattempt"]).." failed fear ward");
			Napoleon.data["fwattempt"] = "";
		end

	elseif (event == "SPELLCAST_STOP") then
		if (Napoleon.data["fwattempt"] ~= "") then
			Napoleon.ChatFrameOutput(UnitName(Napoleon.data["fwattempt"]).." got fear ward");
			Napoleon.data["fwattempt"] = "";
		end
	end
end

Napoleon.RGBToHex = function(r, g, b)
	return format("%.2x%.2x%.2x",floor(r * 255),floor(g * 255),floor(b * 255));
end

Napoleon.SlashCommand = function(msg)
	if (msg == "ward") then
		Napoleon.TankFearWard();
	else
		NapoleonFrame:Show();
	end
end

Napoleon.RefreshRaidArray = function()
	local name, rank, subgroup, level, class, filename, zone, online, isdead;
	local oldraidarray, oldtankarray;
	local entry, counter;

	Napoleon.data["raidcount"] = GetNumRaidMembers();
	Napoleon.data["zonetext"] = GetRealZoneText();

	if (Napoleon.data["raidcount"] > 0) then
		oldraidarray = Napoleon.data["raidarray"];
		oldtankarray = Napoleon.data["tankarray"];
		Napoleon.data["raidarray"] = {};
		Napoleon.data["raidassoc"] = {};
		Napoleon.data["tankarray"] = {};
		Napoleon.data["tankassoc"] = {};

		for counter = 1, Napoleon.data["raidcount"] do
			name, rank, subgroup, level, class, filename, zone, online, isdead = GetRaidRosterInfo(counter);
			if (name ~= nil) then
				entry = {};
				entry["unitid"] = "raid".. counter;
				entry["name"] = name;
				entry["subgroup"] = subgroup;
				entry["class"] = filename;
				entry["zone"] = zone;
				entry["online"] = online;
				entry["isdead"] = isdead;
				entry["checked"] = false;
				entry["tankname"] = nil;
				entry["tankslot"] = 0;
				table.insert(Napoleon.data["raidarray"],entry)

				if (UnitExists("raidpet".. counter)) then
					entry = {};
					entry["unitid"] = "raidpet".. counter;
					entry["name"] = UnitName("raidpet".. counter);
					entry["subgroup"] = subgroup;
					entry["class"] = filename .."PET";
					entry["zone"] = zone;
					entry["online"] = online;
					entry["isdead"] = isdead;
					entry["checked"] = false;
					entry["tankname"] = nil;
					entry["tankslot"] = 0;
					table.insert(Napoleon.data["raidarray"],entry);
				end
			end
		end

		-- sort raidarray by healer type then name
--		table.sort(Napoleon.data["raidarray"],Napoleon.RaidArraySort);

		-- generate the assoc
		for counter = 1, table.getn(Napoleon.data["raidarray"]) do
			Napoleon.data["raidassoc"][Napoleon.data["raidarray"][counter]["name"]] = counter;
		end

		-- if previous tank list we copy existing tank settings to new tankarray
		if (table.getn(oldtankarray) > 0) then
			for counter = 1, table.getn(oldtankarray) do
				-- copy duties over
				if (oldtankarray[counter]["unitid"] == "DUTY") then
					table.insert(Napoleon.data["tankarray"],oldtankarray[counter]);
					Napoleon.data["tankassoc"][oldtankarray[counter]["name"]] = table.getn(Napoleon.data["tankarray"]);
				end

				-- npc tank
				if (oldtankarray[counter]["unitid"] == "NPC") then
					entry = oldtankarray[counter];
					table.insert(Napoleon.data["tankarray"],entry);
					Napoleon.data["tankassoc"][entry["name"]] = table.getn(Napoleon.data["tankarray"]);
				-- if exisiting raid member
				elseif (Napoleon.data["raidassoc"][oldtankarray[counter]["name"]] ~= nil) then
					entry = {};
					entry["unitid"] = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][oldtankarray[counter]["name"]]]["unitid"];
					entry["name"] = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][oldtankarray[counter]["name"]]]["name"];
					entry["fwstatus"] = oldtankarray[counter]["fwstatus"];
					entry["checked"] = oldtankarray[counter]["checked"];
					table.insert(Napoleon.data["tankarray"],entry);
					Napoleon.data["tankassoc"][entry["name"]] = table.getn(Napoleon.data["tankarray"]);
				end
			end
		end		

		-- copy healing roster and bands from oldraidarray to raidarray
		if (table.getn(oldraidarray) > 0) then
			for counter = 1, table.getn(oldraidarray) do
				name = oldraidarray[counter]["name"];

				-- copy bands over
				if (oldraidarray[counter]["class"] == "BAND") then
					table.insert(Napoleon.data["raidarray"],oldraidarray[counter]);
					Napoleon.data["raidassoc"][oldraidarray[counter]["name"]] = table.getn(Napoleon.data["raidarray"]);
				end

				-- if member still exists
				if (Napoleon.data["raidassoc"][name] ~= nil) then
					-- if member had tank allocated
					if (oldraidarray[counter]["tankname"] ~= nil) then
						-- if tank is in current tanklist
						if (Napoleon.data["tankassoc"][oldraidarray[counter]["tankname"]] ~= nil) then
							Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankname"] = oldraidarray[counter]["tankname"];
							Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankslot"] = oldraidarray[counter]["tankslot"];
							Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["checked"] = oldraidarray[counter]["checked"];
						else
							Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankname"] = nil;
							Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankslot"] = 0;
							Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["checked"] = false;
						end
					end

					-- copy checked
					if (oldraidarray[counter]["checked"] == true) then
						Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["checked"] = true;
					end
				end
			end
		end
	else
		Napoleon.data["raidarray"] = {};
		Napoleon.data["raidassoc"] = {};
		Napoleon.data["tankarray"] = {};
		Napoleon.data["tankassoc"] = {};
	end
end

 Napoleon.RaidArraySort = function(...)
	if (arg1 ~= nil and arg2 ~= nil) then
		-- returns true when first is less than second
		if (arg2["class"] == arg1["class"]) then
			return arg1["name"] < arg2["name"];
		elseif (arg2["class"] == "PRIEST") then
			return false;
		elseif (arg2["class"] == "DRUID" and arg1["class"] ~= "PRIEST") then
			return false;
		elseif (arg2["class"] == "PALADIN" and arg1["class"] ~= "PRIEST" and arg1["class"] ~= "DRUID") then
			return false;
		elseif (arg2["class"] == "SHAMAN" and arg1["class"] ~= "PRIEST" and arg1["class"] ~= "DRUID") then
			return false;
		end
	end

	return true;
end

Napoleon.FindFearWard = function()
	local colors;
	local counter = 1;
	local spellname = "";

	if (Napoleon.data["fwfindattempt"] == false) then
		-- find fearward in spell book
		while (true) do
			spellname = GetSpellName(counter,BOOKTYPE_SPELL);
			if (not spellname) then
				do break end;
			end
			if (spellname == "Fear Ward") then
				Napoleon.data["fwspellbook"] = counter;
			end

			counter = counter + 1;
		end

		-- find fear ward it on actionslot
		if (Napoleon.data["fwspellbook"] > 0) then
			for counter = 1, 128 do
				-- not empty slot
				if (HasAction(counter)) then
					-- not a macro
					if (GetActionText(counter) == nil) then
						NapoleonTooltip:SetOwner(NapoleonFrame,"ANCHOR_NONE");
						NapoleonTooltip:ClearLines();
						NapoleonTooltip:SetAction(counter);
						local slotName = NapoleonTooltipTextLeft1:GetText();
						if (slotName == "Fear Ward") then
							NapoleonTooltip:Hide();
							Napoleon.data["fwactionbar"] = counter;
						end
						NapoleonTooltip:Hide();
					end
				end
			end
		end

		colors = Napoleon.data["class"]["PALADIN"]["color"];
		if (Napoleon.data["fwspellbook"] == 0 or Napoleon.data["fwactionbar"] == 0) then
			Napoleon.ChatFrameOutput("|c00".. Napoleon.RGBToHex(colors["r"],colors["g"],colors["b"]) .."Napoleon loaded (FW-).  Use: \"/nap\"");
		else
			Napoleon.ChatFrameOutput("|c00".. Napoleon.RGBToHex(colors["r"],colors["g"],colors["b"]) .."Napoleon loaded (FW+).  Use: \"/nap\"");
		end

		Napoleon.data["fwfindattempt"] = true;
	end
end

Napoleon.FearWardChecked = function(obj)
	local tankkey, counter;

	tankkey = obj:GetParent():GetID();
	tankkey = tankkey + FauxScrollFrame_GetOffset(NapoleonFrameTankScrollBar);

	if (Napoleon.data["tankarray"][tankkey]["fwstatus"] < 2) then
		Napoleon.data["tankarray"][tankkey]["fwstatus"] = Napoleon.data["tankarray"][tankkey]["fwstatus"] + 1;
	else
		Napoleon.data["tankarray"][tankkey]["fwstatus"] = 0;
	end
end

Napoleon.TankFearWard = function()
	local counter;
	local buffcounter = 1;
	local bufffound = false;
	local targetstring = "";

	if (table.getn(Napoleon.data["tankarray"]) > 0) then
		local start, duration, enable = GetActionCooldown(Napoleon.data["fwactionbar"]);
		if (enable == 1 and start + duration < GetTime()) then
			for counter = 1, table.getn(Napoleon.data["tankarray"]) do
				-- fwstatus set
				if (Napoleon.data["tankarray"][counter]["fwstatus"] > 0) then
					targetstring = Napoleon.data["tankarray"][counter]["unitid"];

					-- check to see if already warded
					buffcounter = 1;
					bufffound = false;
					while (UnitBuff(targetstring,buffcounter)) do 
						if (string.find(UnitBuff(targetstring,buffcounter),"Excorcism")) then 
							bufffound = true;
							break;
						end
						buffcounter = buffcounter + 1;
					end

					if (bufffound == false) then
						if (not UnitIsDeadOrGhost(targetstring)) then
							if (UnitIsVisible(targetstring)) then
								TargetUnit(targetstring);
								if (IsActionInRange(Napoleon.data["fwactionbar"])) then
									if (not UnitIsCharmed(targetstring)) then
										Napoleon.data["fwattempt"] = targetstring;
										CastSpell(Napoleon.data["fwspellbook"],"spell");
									else
										Napoleon.ChatFrameOutput(UnitName(targetstring).." is charmed");
									end
								else
									Napoleon.ChatFrameOutput(UnitName(targetstring)..": not in range");
								end

								-- return to previous target
								TargetUnit("playertarget");
							else
								Napoleon.ChatFrameOutput(UnitName(targetstring).." not nearby");
							end

							-- stop looping if attempted cast
							if (Napoleon.data["fwattempt"] ~= "") then
								do break end;
							end
						-- break if forceifalive
						elseif (Napoleon.data["tankarray"][counter]["fwstatus"] == 2) then
							Napoleon.ChatFrameOutput("NOTICE: "..UnitName(targetstring).." has force set");
							do break end;
						else
							Napoleon.ChatFrameOutput(UnitName(targetstring).." is dead or ghost, oops");
						end
					else
						Napoleon.ChatFrameOutput(UnitName(targetstring).." already warded");
					end
				end
			end
		else
			Napoleon.ChatFrameOutput("ERROR: "..math.ceil(30 - (GetTime() - start)).." secs cooldown left on fear ward");
		end
	end
end

Napoleon.TankAdd = function()
	local name, entry, class;

	if (UnitExists("target")) then
		name = UnitName("target");
		-- if not already in tankarray
		if (Napoleon.data["tankassoc"][name] == nil) then
			-- unit is friendly
			if (UnitIsFriend("player","target")) then
				entry = {};

				-- unit is in raid
				if (Napoleon.data["raidassoc"][name] ~= nil) then
					entry["unitid"] = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["unitid"];
					entry["name"] = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["name"];

					-- if healer beomes tank, set to heal himself
					class = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["class"];
					if (class == "PRIEST" or class == "DRUID" or class == "PALADIN" or class == "SHAMAN") then
						Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["tankname"] = name;
					end
				else
					entry["unitid"] = "NPC";
					entry["name"] = name;
				end

				entry["fwstatus"] = 0;
				entry["checked"] = false;

				table.insert(Napoleon.data["tankarray"],entry);
				Napoleon.data["tankassoc"][entry["name"]] = table.getn(Napoleon.data["tankarray"]);
			else
				Napoleon.ChatFrameOutput("Unit not friendly");
			end
		else
			Napoleon.ChatFrameOutput("Unit already in tank list");
		end
	else
		Napoleon.ChatFrameOutput("Unit does not exist");
	end
end

Napoleon.TankRemove = function(obj)
	local key, tankname;

	key = obj:GetParent():GetID();
	key = key + FauxScrollFrame_GetOffset(NapoleonFrameTankScrollBar);

	tankname = Napoleon.data["tankarray"][key]["name"];
	table.remove(Napoleon.data["tankarray"],key);
	Napoleon.data["tankassoc"][tankname] = nil;
end

Napoleon.TankHealerCount = function(tankname)
	local healcount, counter;

	-- find how many healers already allocated to tank
	healcount = 0;
	for counter = 1, table.getn(Napoleon.data["raidarray"]) do
		if (Napoleon.data["raidarray"][counter]["tankname"] == tankname) then
			healcount = healcount + 1;
		end
	end

	return healcount;
end

Napoleon.TankChecked = function(obj)
	local tankkey, counter;

	tankkey = obj:GetParent():GetID();
	tankkey = tankkey + FauxScrollFrame_GetOffset(NapoleonFrameTankScrollBar);

	-- remove checked from all tanks
	for counter = 1, table.getn(Napoleon.data["tankarray"]) do
		Napoleon.data["tankarray"][counter]["checked"] = false;
	end

	Napoleon.data["tankarray"][tankkey]["checked"] = true;
end

Napoleon.FilterCheck = function(playerdetails, filterlist)
	local passed, filter, reverse, importtable, grouptype, groupstart, groupend, tempcounter, found;

	passed = true;
	counter = 1;

	while (passed == true and counter <= table.getn(filterlist)) do
		reverse = false;

		-- a not filter
		if (string.find(filterlist[counter],"^!")) then
			filterlist[counter] = string.sub(filterlist[counter],2);
			reverse = true;
		end

		-- group(s)
		if (string.find(filterlist[counter],"^Group%a?%s")) then
			_, _, grouptype = string.find(filterlist[counter],"^Group%a?%s(.*)$");
			if (grouptype == "EVEN") then
				if (math.mod(playerdetails["subgroup"],2) ~= 0) then
					passed = false;
				end
			elseif (grouptype == "ODD") then
				if (math.mod(playerdetails["subgroup"],2) ~= 1) then
					passed = false;
				end
			else
				if (string.find(grouptype,"%d%-%d")) then
					_, _, groupstart, groupend = string.find(grouptype,"(%d)%-(%d)");
					if (playerdetails["subgroup"] < tonumber(groupstart) or playerdetails["subgroup"] > tonumber(groupend)) then
						passed = false;
					end
				elseif (tonumber(grouptype) ~= playerdetails["subgroup"]) then
					passed = false;
				end
			end
		elseif (string.find(filterlist[counter],"^RA")) then
			found = false;

			if (oRA_MainTank ~= nil and oRA_MainTank.MainTankTable ~= nil) then
				importtable = oRA_MainTank.MainTankTable;
			elseif (oRA ~= nil and oRA.maintanktable ~= nil) then
				importtable = oRA.maintanktable;
			elseif	(CT_RA_MainTanks ~= nil) then
				importtable = CT_RA_MainTanks;
			else
				Napoleon.ChatFrameOutput("CTRA / oRA(2) not installed");
			end

			if (importtable ~= nil) then
				if (table.getn(importtable) > 0) then
					-- range or single
					if (string.find(filterlist[counter],"^RA%sMT")) then
						_, _, grouptype = string.find(filterlist[counter],"^RA%sMT(.*)$");
						-- range
						if (string.find(grouptype,"%d%-%d")) then
							_, _, groupstart, groupend = string.find(grouptype,"(%d)%-(%d)");
							for tempcounter = tonumber(groupstart), tonumber(groupend) do
								if (importtable[tempcounter] == playerdetails["name"]) then
									found = true;
								end
							end
						-- single
						elseif (string.find(grouptype,"%d")) then
							_, _, groupstart = string.find(grouptype,"(%d)");
							if (importtable[tonumber(groupstart)] == playerdetails["name"]) then
								found = true;
							end
						end
					-- whole ra
					elseif (filterlist[counter] == "RA") then
						for tempcounter in importtable do
							if (importtable[tempcounter] == playerdetails["name"]) then
								found = true;
							end
						end
					end
				end
			end

			if (found ~= true) then
				passed = false;
			end

		elseif (filterlist[counter] == "BAND" and playerdetails["class"] ~= "BAND") then
			passed = false;
		elseif (filterlist[counter] == "NONBAND" and playerdetails["class"] == "BAND") then
			passed = false;
		elseif (filterlist[counter] == "PETS" and string.sub(playerdetails["class"],-3) ~= "PET") then
			passed = false;
		elseif (filterlist[counter] == "HEALERS" and (playerdetails["class"] ~= "PRIEST" and playerdetails["class"] ~= "DRUID" and playerdetails["class"] ~= "PALADIN" and playerdetails["class"] ~= "SHAMAN")) then
			passed = false;
		elseif (filterlist[counter] == "DPS" and (playerdetails["class"] ~= "ROGUE" and playerdetails["class"] ~= "MAGE" and playerdetails["class"] ~= "WARLOCK" and playerdetails["class"] ~= "HUNTER")) then
			passed = false;
		elseif (filterlist[counter] == "MELEE DPS" and (playerdetails["class"] ~= "ROGUE" and playerdetails["class"] ~= "WARRIOR")) then
			passed = false;
		elseif (filterlist[counter] == "RANGED DPS" and (playerdetails["class"] ~= "MAGE" and playerdetails["class"] ~= "WARLOCK" and playerdetails["class"] ~= "HUNTER")) then
			passed = false;
		elseif (filterlist[counter] == "AOE" and (playerdetails["class"] ~= "MAGE" and playerdetails["class"] ~= "WARLOCK" and playerdetails["class"] ~= "HUNTER" and playerdetails["class"] ~= "DRUID" and playerdetails["class"] ~= "PRIEST")) then
			passed = false;
		elseif (filterlist[counter] == "Dispel" and (playerdetails["class"] ~= "PRIEST" and playerdetails["class"] ~= "WARLOCKPET")) then
			passed = false;
		elseif (filterlist[counter] == "Plate Wearer" and (playerdetails["class"] ~= "WARRIOR" and playerdetails["class"] ~= "PALADIN")) then
			passed = false;
		elseif (filterlist[counter] == "Mail Wearer" and (playerdetails["class"] ~= "HUNTER" and playerdetails["class"] ~= "SHAMAN")) then
			passed = false;
		elseif (filterlist[counter] == "Leather Wearer" and (playerdetails["class"] ~= "DRUID" and playerdetails["class"] ~= "ROGUE")) then
			passed = false;
		elseif (filterlist[counter] == "Cloth Wearer" and (playerdetails["class"] ~= "PRIEST" and playerdetails["class"] ~= "WARLOCK" and playerdetails["class"] ~= "MAGE")) then
			passed = false;
		elseif (filterlist[counter] == "Rem-Magic" and (playerdetails["class"] ~= "PRIEST" and playerdetails["class"] ~= "PALADIN")) then
			passed = false;
		elseif (filterlist[counter] == "Rem-Curse" and (playerdetails["class"] ~= "MAGE" and playerdetails["class"] ~= "DRUID")) then
			passed = false;
		elseif (filterlist[counter] == "Rem-Disease" and (playerdetails["class"] ~= "PRIEST" and playerdetails["class"] ~= "PALADIN")) then
			passed = false;
		elseif (filterlist[counter] == "Rem-Poison" and (playerdetails["class"] ~= "DRUID" and playerdetails["class"] ~= "PALADIN")) then
			passed = false;
		elseif (filterlist[counter] == "Assigned" and playerdetails["tankname"] == nil) then
			passed = false;
		elseif (filterlist[counter] == "Unassigned" and playerdetails["tankname"] ~= nil) then
			passed = false;
		elseif (filterlist[counter] == "Online" and playerdetails["online"] ~= 1) then
			passed = false;
		-- class check last
		elseif (Napoleon.data["class"][string.upper(filterlist[counter])] ~= nil and string.upper(filterlist[counter]) ~= string.upper(playerdetails["class"])) then
			passed = false;
		end

		if (reverse == true) then
			filterlist[counter] = "!".. filterlist[counter];
			passed = not passed;
		end

		counter = counter + 1;
	end

	return passed;
end

Napoleon.FilterCount = function(filterlist)
	local counter;
	local foundcounter = 0;

	for counter = 1, table.getn(Napoleon.data["raidarray"]) do
		if (Napoleon.FilterCheck(Napoleon.data["raidarray"][counter],filterlist)) then
			foundcounter = foundcounter + 1;
		end
	end

	return foundcounter;
end

Napoleon.FilterFind = function(filterlist, count)
	local counter = 1;
	local foundcounter = 0;

	while (foundcounter < counter and counter <= table.getn(Napoleon.data["raidarray"])) do
		if (Napoleon.FilterCheck(Napoleon.data["raidarray"][counter],filterlist)) then
			foundcounter = foundcounter + 1;

			if (foundcounter == count) then
				return counter;
			end
		end
		counter = counter + 1;
	end

	return 0;
end

Napoleon.HealerFilterList = function()
	local filter;
	local filterlist = {};

	filter = UIDropDownMenu_GetText(NapoleonFrameFilterDropDown);
	if (filter ~= nil) then
		table.insert(filterlist,filter);
	end
	table.insert(filterlist,"NONBAND");
	table.insert(filterlist,"Unassigned");

	return filterlist;
end

Napoleon.BandFilterList = function()
	local filterlist = {};
	table.insert(filterlist,"BAND");
	table.insert(filterlist,"Unassigned");

	return filterlist;
end

Napoleon.HealerChecked = function(source, obj)
	local healkey, raidkey, tankkey;
	local filterlist = {};

	-- if free
	if (source == "heal") then
		if (string.find(obj:GetParent():GetName(),"^NapoleonFrameBand%d")) then
			_, _, healkey = string.find(obj:GetParent():GetName(),"^NapoleonFrameBand(%d)");
			filterlist = Napoleon.BandFilterList();
			healkey = healkey + FauxScrollFrame_GetOffset(NapoleonFrameBandScrollBar);
			raidkey = Napoleon.FilterFind(filterlist,healkey);
		else
			healkey = obj:GetParent():GetID();
			filterlist = Napoleon.HealerFilterList();
			healkey = healkey + FauxScrollFrame_GetOffset(NapoleonFrameHealScrollBar);
			raidkey = Napoleon.FilterFind(filterlist,healkey);
		end
	-- if on tank
	elseif (source == "tank") then
		healkey = obj:GetParent():GetID();
		tankkey = obj:GetParent():GetParent():GetID();
		tankkey = tankkey + FauxScrollFrame_GetOffset(NapoleonFrameTankScrollBar);

		local tankname = Napoleon.data["tankarray"][tankkey]["name"];

		filterlist = { "Assigned" };
		local healcount = Napoleon.FilterCount(filterlist);
		local healfound = false;
		local counter = 1;
		while (healfound == false and counter <= healcount) do
			raidkey = Napoleon.FilterFind(filterlist,counter);
			if (Napoleon.data["raidarray"][raidkey]["tankname"] == tankname and Napoleon.data["raidarray"][raidkey]["tankslot"] == healkey) then
				healfound = true;
			else
				counter = counter + 1;
			end
		end
	end	

	if (Napoleon.data["raidarray"][raidkey]["checked"] == true) then
		Napoleon.data["raidarray"][raidkey]["checked"] = false;
	else
		Napoleon.data["raidarray"][raidkey]["checked"] = true;
	end
end

Napoleon.Switch = function()
	local counter, checkcount, tankfound, tankname, healcount;

	-- remove healers from tanks
	for counter = 1, table.getn(Napoleon.data["raidarray"]) do
		if (Napoleon.data["raidarray"][counter]["tankname"] ~= nil) then
			if (Napoleon.data["raidarray"][counter]["checked"] == true) then
				Napoleon.data["raidarray"][counter]["tankname"] = nil;
				Napoleon.data["raidarray"][counter]["tankslot"] = 0;
				Napoleon.data["raidarray"][counter]["checked"] = false;
			end
		end
	end

	-- count healers checked
	checkcount = 0;
	for counter = 1, table.getn(Napoleon.data["raidarray"]) do
		if (Napoleon.data["raidarray"][counter]["checked"] == true) then
			checkcount = checkcount + 1;
		end
	end

	if (checkcount > 0) then
		-- find tank selected
		counter = 1;
		tankfound = false;
		while (tankfound == false and counter <= table.getn(Napoleon.data["tankarray"])) do
			if (Napoleon.data["tankarray"][counter]["checked"] == true) then
				tankfound = true;
				tankname = Napoleon.data["tankarray"][counter]["name"];
			else
				counter = counter + 1;
			end
		end

		-- add healers to selected tank
		if (tankfound == true) then
			healcount = Napoleon.TankHealerCount(tankname);

			-- add up to 6 healers
			for counter = 1, table.getn(Napoleon.data["raidarray"]) do
				if (Napoleon.data["raidarray"][counter]["checked"] == true) then
					if (healcount < 6) then
						healcount = healcount + 1;
						Napoleon.data["raidarray"][counter]["tankname"] = tankname;
						Napoleon.data["raidarray"][counter]["tankslot"] = healcount;
						Napoleon.data["raidarray"][counter]["checked"] = false;
					else
						Napoleon.ChatFrameOutput(Napoleon.data["raidarray"][counter]["name"] .." failed add, tank full");
					end
				end
			end
		else
			Napoleon.ChatFrameOutput("No tank selected");
		end
	end
end

Napoleon.TankImport = function()
	local importtable, key, name, entry;

	if (oRA_MainTank ~= nil and oRA_MainTank.MainTankTable ~= nil) then
		importtable = oRA_MainTank.MainTankTable;
	elseif	(CT_RA_MainTanks ~= nil) then
		importtable = CT_RA_MainTanks;
	else
		Napoleon.ChatFrameOutput("CTRA / oRA not installed");
	end

	Napoleon.data["tankarray"] = {};
	Napoleon.data["tankassoc"] = {};
	if (table.getn(importtable) > 0) then
		for key, name in importtable do
			if (Napoleon.data["raidassoc"][name] ~= nil) then
				entry = {};
				entry["unitid"] = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][name]]["unitid"];
				entry["name"] = name;
				entry["fwstatus"] = 0;
				entry["checked"] = false;

				table.insert(Napoleon.data["tankarray"],entry);
				Napoleon.data["tankassoc"][entry["name"]] = table.getn(Napoleon.data["tankarray"]);
			end
		end
	end
end

Napoleon.Reset = function()
	local oldraidarray, counter;
	oldraidarray = Napoleon.data["raidarray"];

	Napoleon.data["raidarray"] = {};
	Napoleon.data["raidassoc"] = {};
	Napoleon.data["tankarray"] = {};
	Napoleon.data["tankassoc"] = {};

	-- keep bands
	for counter = 1, table.getn(oldraidarray) do
		-- copy bands over
		if (oldraidarray[counter]["class"] == "BAND") then
			table.insert(Napoleon.data["raidarray"],oldraidarray[counter]);
			Napoleon.data["raidassoc"][oldraidarray[counter]["name"]] = table.getn(Napoleon.data["raidarray"]);
		end
	end
end

Napoleon.ChatFrameOutput = function(message)
	if (Napoleon.data["debugmode"] == true) then
		local colors = Napoleon.data["class"]["PRIEST"]["color"];
		DEFAULT_CHAT_FRAME:AddMessage("|c00".. Napoleon.RGBToHex(colors["r"],colors["g"],colors["b"]) .. message);
	end
end

Napoleon.GetTankBuff = function(tankkey, buffname)
	local tankname;
	local counter = 1;
	local found = false;

	if (Napoleon.data["tankarray"][tankkey]["unitid"] == "NPC") then
		tankname = Napoleon.data["tankarray"][tankkey]["name"];
		TargetByName(tankname);

		if (UnitName("target") == tankname) then
			while (UnitBuff("target",counter)) do 
				if (string.find(UnitBuff("target",counter),buffname)) then 
					found = true;
					break;
				end
				counter = counter + 1;
			end
		end
		TargetLastTarget();
	else
		while (UnitBuff(Napoleon.data["tankarray"][tankkey]["unitid"],counter)) do 
			if (string.find(UnitBuff(Napoleon.data["tankarray"][tankkey]["unitid"],counter),buffname)) then 
				found = true;
				break;
			end
			counter = counter + 1;
		end
	end

	return found;
end

Napoleon.TankScrollBarUpdate = function()
	local tankcount, tankoffset, tankframe, tankname, tankclass, tankcolor;
	local fwcolor, fwtext, raidkey;
	local healclass, healcolor, counterrow, counterheal;

	if (Napoleon.data["loaded"] == false) then
		return;
	end

	tankcount = table.getn(Napoleon.data["tankarray"]);

	-- xmlobject, entries, visible rows, row height
	FauxScrollFrame_Update(NapoleonFrameTankScrollBar,tankcount,5,32);

	if (tankcount > 5) then
		NapoleonFrameTankScrollBar:Show();
	else
		NapoleonFrameTankScrollBar:Hide();
	end

	for counterrow = 1, 5 do
		tankoffset = counterrow + FauxScrollFrame_GetOffset(NapoleonFrameTankScrollBar);
		tankframe = "NapoleonFrameTank"..counterrow;

		if (tankoffset <= tankcount) then
			tankkey = tankoffset;
			tankname = Napoleon.data["tankarray"][tankkey]["name"];

			-- portrait
			if (Napoleon.data["tankarray"][tankkey]["checked"] == true) then
				getglobal(tankframe.."Portrait"):SetAlpha(1);
			else
				getglobal(tankframe.."Portrait"):SetAlpha(0.25);
			end
			if (Napoleon.data["tankarray"][tankkey]["unitid"] == "NPC") then
				tankclass = "NPC";
				getglobal(tankframe.."Portrait"):SetTexture("Interface\\CharacterFrame\\TemporaryPortrait-Monster");
				getglobal(tankframe.."SubGroup"):SetText("-");
			elseif (Napoleon.data["tankarray"][tankkey]["unitid"] == "DUTY") then
				tankclass = "DUTY";
				getglobal(tankframe.."Portrait"):SetTexture("Interface\\Icons\\".. Napoleon.data["dutyicons"][Napoleon.data["tankarray"][tankkey]["type"]["filter"]]);
				getglobal(tankframe.."SubGroup"):SetText("");
			else
				tankclass = Napoleon.data["raidarray"][Napoleon.data["raidassoc"][tankname]]["class"];
				SetPortraitTexture(getglobal(tankframe.."Portrait"),Napoleon.data["tankarray"][tankkey]["unitid"]);
				getglobal(tankframe.."SubGroup"):SetText(Napoleon.data["raidarray"][Napoleon.data["raidassoc"][tankname]]["subgroup"]);
			end
			tankcolor = Napoleon.data["class"][tankclass]["color"];
			getglobal(tankframe.."Name"):SetTextColor(tankcolor["r"],tankcolor["g"],tankcolor["b"],1);
			getglobal(tankframe.."Name"):SetText(tankname);
			getglobal(tankframe.."CheckedButton"):SetAlpha(0);

			getglobal(tankframe.."SubGroup"):SetTextColor(tankcolor["r"],tankcolor["g"],tankcolor["b"],1);

			-- fear ward
			if (Napoleon.data["tankarray"][tankkey]["unitid"] == "DUTY" or Napoleon.data["fwspellbook"] == 0 or Napoleon.data["fwactionbar"] == 0) then
				getglobal(tankframe.."FearWard"):SetAlpha(0);
				getglobal(tankframe.."FearWardStatus"):SetAlpha(0);
			else
				if (Napoleon.GetTankBuff(tankkey,"Excorcism") == true) then
					getglobal(tankframe.."FearWard"):SetAlpha(1);
				else
					getglobal(tankframe.."FearWard"):SetAlpha(0.25);
				end
				getglobal(tankframe.."FearWard"):SetTexture("Interface\\Icons\\Spell_Holy_Excorcism");
				if (Napoleon.data["tankarray"][tankkey]["fwstatus"] == 2) then
					fwcolor = Napoleon.data["class"]["MAGE"]["color"];
					fwtext = "Force";
				elseif (Napoleon.data["tankarray"][tankkey]["fwstatus"] == 1) then
					fwcolor = Napoleon.data["class"]["HUNTER"]["color"];
					fwtext = "On";
				else
					fwcolor = Napoleon.data["class"]["PALADIN"]["color"];
					fwtext = "Off";
				end
				getglobal(tankframe.."FearWardStatus"):SetTextColor(fwcolor["r"],fwcolor["g"],fwcolor["b"],1);
				getglobal(tankframe.."FearWardStatus"):SetText(fwtext);
				getglobal(tankframe.."FearWardStatus"):SetAlpha(1);
			end
			getglobal(tankframe.."FearWardButton"):SetAlpha(0);

			counterheal = 1;
			local filterlist = { "Assigned" };
			for healcount = 1, Napoleon.FilterCount(filterlist) do
				raidkey = Napoleon.FilterFind(filterlist,healcount);

				-- found a healer match
				if (Napoleon.data["raidarray"][raidkey]["tankname"] == tankname) then
					healclass = Napoleon.data["raidarray"][raidkey]["class"];
					healcolor = Napoleon.data["class"][healclass]["color"];
					getglobal(tankframe.."Heal"..counterheal.."Name"):SetTextColor(healcolor["r"],healcolor["g"],healcolor["b"],1);
					getglobal(tankframe.."Heal"..counterheal.."Name"):SetText(Napoleon.data["raidarray"][raidkey]["name"]);

					-- show the checkbox
					if (Napoleon.data["raidarray"][raidkey]["checked"] == true) then
						getglobal(tankframe.."Heal".. counterheal .."Check"):SetChecked(1);
					else
						getglobal(tankframe.."Heal".. counterheal .."Check"):SetChecked(0);
					end
					getglobal(tankframe.."Heal".. counterheal .."Check"):Show();

					getglobal(tankframe.."Heal"..counterheal.."SubGroup"):SetText(Napoleon.data["raidarray"][raidkey]["subgroup"]);
					getglobal(tankframe.."Heal"..counterheal.."SubGroup"):Show();
					if (Napoleon.data["raidarray"][raidkey]["class"] == "BAND") then
						getglobal(tankframe.."Heal"..counterheal.."SubGroup"):SetText("*");
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetTexture("Interface\\BattlefieldFrame\\UI-Battlefield-Icon");
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetAlpha(1);
					elseif (Napoleon.data["raidarray"][raidkey]["online"] ~= 1) then
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetAlpha(1);
					elseif (Napoleon.data["raidarray"][raidkey]["isdead"] == 1) then
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetTexture("Interface\\TargetingFrame\\TargetDead");
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetAlpha(1);
					elseif (Napoleon.data["raidarray"][raidkey]["zone"] ~= Napoleon.data["zonetext"]) then
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetTexture("Interface\\WorldMap\\WorldMap-Icon");
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetAlpha(1);
					else
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetTexture("Interface\\Buttons\\UI-CheckBox-Check");
						getglobal(tankframe.."Heal"..counterheal.."OAZ"):SetAlpha(0.25);
					end
					getglobal(tankframe.."Heal"..counterheal.."OAZ"):Show();

					Napoleon.data["raidarray"][raidkey]["tankslot"] = counterheal;
					counterheal = counterheal + 1;
				end
			end

			-- some spaces left then set them to none
			if (counterheal < 6) then
				healcolor = Napoleon.data["class"]["NPC"]["color"];
				for counterheal = counterheal, 6 do
					getglobal(tankframe.."Heal"..counterheal.."Name"):SetTextColor(healcolor["r"],healcolor["g"],healcolor["b"],1);
					getglobal(tankframe.."Heal"..counterheal.."Name"):SetText("None");

					-- hide pieces
					getglobal(tankframe.."Heal"..counterheal.."Check"):Hide();
					getglobal(tankframe.."Heal"..counterheal.."SubGroup"):Hide();
					getglobal(tankframe.."Heal"..counterheal.."OAZ"):Hide();
				end
			end

			getglobal(tankframe):Show();
		else
			getglobal(tankframe):Hide();
		end
	end
end

Napoleon.FilterDropDownInitialize = function()
	local counter;
	local entry = {};

	if (Napoleon.data["loaded"] == false) then
		return;
	end

	for counter = 1, table.getn(Napoleon.data["ddraid"]) do
		entry = { text = Napoleon.data["ddraid"][counter]; checked = nil; func = Napoleon.FilterDropDownOnClick };
		UIDropDownMenu_AddButton(entry);
	end
end

Napoleon.FilterDropDownOnClick = function()
	UIDropDownMenu_SetSelectedID(NapoleonFrameFilterDropDown,this:GetID());
end

Napoleon.HealScrollBarUpdate = function()
	local healcount, healoffset, healframe, healcolor, healname, healextras, counterrow, raidkey, class;
	local filter;
	local filterlist = {};

	if (Napoleon.data["loaded"] == false) then
		return;
	end

	filterlist = Napoleon.HealerFilterList();
	healcount = Napoleon.FilterCount(filterlist);

	-- xmlobject, entries, visible rows, row height
	FauxScrollFrame_Update(NapoleonFrameHealScrollBar,healcount,10,16);

	if (healcount > 10) then
		NapoleonFrameHealScrollBar:Show();
	else
		NapoleonFrameHealScrollBar:Hide();
	end

	for counterrow = 1, 10 do
		healoffset = counterrow + FauxScrollFrame_GetOffset(NapoleonFrameHealScrollBar);
		healframe = "NapoleonFrameHeal".. counterrow;
		healextras = "";

		if (healoffset <= healcount) then
			raidkey = Napoleon.FilterFind(filterlist,healoffset);
			healname = Napoleon.data["raidarray"][raidkey]["name"];

			class = Napoleon.data["raidarray"][raidkey]["class"];
			getglobal(healframe .."Check"):Show();

			if (Napoleon.data["raidarray"][raidkey]["checked"] == true) then
				getglobal(healframe .."Check"):SetChecked(1);
			else
				getglobal(healframe .."Check"):SetChecked(0);
			end

			getglobal(healframe.."SubGroup"):SetText(Napoleon.data["raidarray"][raidkey]["subgroup"]);

			if (Napoleon.data["raidarray"][raidkey]["class"] == "BAND") then
				getglobal(healframe.."OAZ"):SetTexture("Interface\\BattlefieldFrame\\UI-Battlefield-Icon");
				getglobal(healframe.."OAZ"):SetAlpha(1);
			elseif (Napoleon.data["raidarray"][raidkey]["online"] ~= 1) then
				getglobal(healframe.."OAZ"):SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
				getglobal(healframe.."OAZ"):SetAlpha(1);
			elseif (Napoleon.data["raidarray"][raidkey]["isdead"] == 1) then
				getglobal(healframe.."OAZ"):SetTexture("Interface\\TargetingFrame\\TargetDead");
				getglobal(healframe.."OAZ"):SetAlpha(1);
			elseif (Napoleon.data["raidarray"][raidkey]["zone"] ~= Napoleon.data["zonetext"]) then
				getglobal(healframe.."OAZ"):SetTexture("Interface\\WorldMap\\WorldMap-Icon");
				getglobal(healframe.."OAZ"):SetAlpha(1);
			else
				getglobal(healframe.."OAZ"):SetTexture("Interface\\Buttons\\UI-CheckBox-Check");
				getglobal(healframe.."OAZ"):SetAlpha(0.25);
			end

			-- hide player checkbox
			getglobal(healframe.."Details"):SetAlpha(0);
			if (Napoleon.data["playershow"]["name"] == healname) then
				getglobal(healframe.."Details"):SetChecked(1)
				if (NapoleonSaved["playerdata"][healname] ~= nil) then
					getglobal(healframe.."DetailsTexture"):SetTexture("Interface\\Buttons\\UI-AttributeButton-Encourage-Down");
				else
					getglobal(healframe.."DetailsTexture"):SetTexture("Interface\\Buttons\\UI-PlusButton-Down");
				end
			else
				getglobal(healframe.."Details"):SetChecked(0)
				if (NapoleonSaved["playerdata"][healname] ~= nil) then
					getglobal(healframe.."DetailsTexture"):SetTexture("Interface\\Buttons\\UI-AttributeButton-Encourage-Up");
				else
					getglobal(healframe.."DetailsTexture"):SetTexture("Interface\\Buttons\\UI-PlusButton-Up");
				end
			end

			healcolor = Napoleon.data["class"][Napoleon.data["raidarray"][raidkey]["class"]]["color"];
			getglobal(healframe.."Name"):SetTextColor(healcolor["r"],healcolor["g"],healcolor["b"],1);
			getglobal(healframe.."Name"):SetText(healname);

			getglobal(healframe):Show();
		else
			getglobal(healframe):Hide();
		end
	end
end

Napoleon.ClearOptions = function()
	Napoleon.data["playershow"]["name"] = "";
	Napoleon.data["dutyshow"]["status"] = "";
	Napoleon.data["bandshow"]["status"] = "";
	Napoleon.data["recallshow"]["status"] = "";

	Napoleon.PlayerFrameClear();
	NapoleonFramePlayerOptions:Hide();
	NapoleonFrameBroadcastOptions:Hide();
	NapoleonFrameBandOptions:Hide();
	NapoleonFrameDutyOptions:Hide();
	NapoleonFrameRecallOptions:Hide();
end

Napoleon.DetailsChecked = function(obj)
	local healkey;
	local filterlist = {};

	Napoleon.ClearOptions();

	-- clicked on a band
	if (string.find(obj:GetParent():GetName(),"^NapoleonFrameBand%d")) then
		_, _, healkey = string.find(obj:GetParent():GetName(),"^NapoleonFrameBand(%d)");
		healframe = "NapoleonFrameBand".. healkey;
		if (getglobal(healframe .."Details"):GetChecked()) then
			filterlist = Napoleon.BandFilterList();
			healkey = healkey + FauxScrollFrame_GetOffset(NapoleonFrameBandScrollBar);
			raidkey = Napoleon.FilterFind(filterlist,healkey);

			Napoleon.data["bandshow"]["name"] = Napoleon.data["raidarray"][raidkey]["name"];
			Napoleon.data["bandshow"]["status"] = "load";
		else
			Napoleon.data["bandshow"]["name"] = "";
			Napoleon.data["bandshow"]["status"] = "new";
		end
	-- clicked on a heal
	else
		healkey = obj:GetParent():GetID();
		healframe = "NapoleonFrameHeal".. healkey;
		if (getglobal(healframe .."Details"):GetChecked()) then
			filterlist = Napoleon.HealerFilterList();
			healkey = healkey + FauxScrollFrame_GetOffset(NapoleonFrameHealScrollBar);
			raidkey = Napoleon.FilterFind(filterlist,healkey);

			Napoleon.data["playershow"]["name"] = Napoleon.data["raidarray"][raidkey]["name"];
			Napoleon.data["playershow"]["tab"] = 1;
		else
			Napoleon.data["playershow"]["name"] = "";
		end
	end
end
