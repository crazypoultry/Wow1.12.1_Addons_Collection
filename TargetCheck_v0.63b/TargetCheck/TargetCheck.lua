--[[
--
--	TargetCheck
--	by Dust of Turalyon
--
--]]

TC_Version = GetAddOnMetadata("TargetCheck", "Version");

TC_Settings_Defaults = {
	--["Hide"]	= false;
	["Scale"]	= 0.75;
	["Alpha"]	= 0.75;

	["Frames"]	= {};

	["MouseFrame"]	= {
		["Anchor"]	= "CURSOR";
		["Target"]	= "mouseover";
		["TargetOfTarget"]	= true;
		["Limit"]	= 6;
		["Header"]	= true;
		["SortOrder"]	= {
			"Targets";
			"Mage";
			"Warlock";
			"Rogue";
			"Warrior";
			"Hunter";
			"Priest";
			"Druid";
			"Paladin";
			"Shaman"
			};
	
		["Mage"]	= true;
		["Warlock"]	= true;
		["Priest"]	= true;
		["Warrior"]	= true;
		["Rogue"]	= true;
		["Hunter"]	= true;
		["Druid"]	= true;
		["Paladin"]	= true;
		["Shaman"]	= true;
		["Targets"]	= false;
		};
	["Mouse"]	= false;

	["Version"]	= TC_Version;
}

TC_OnLoad = function ()
	--Slash command
	SlashCmdList["TARGETCHECK"] = TC_SlashHandler;
	SLASH_TARGETCHECK1 = "/targetcheck";

	--Events
	TargetCheck_MainFrame:RegisterEvent("VARIABLES_LOADED");
	TargetCheck_MainFrame:RegisterEvent("RAID_ROSTER_UPDATE");
	TargetCheck_MainFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
end;

TC_OnEvent = function ()
	if (event == "PLAYER_TARGET_CHANGED") or (event == "UPDATE_MOUSEOVER_UNIT") then
		TC_Check();
		TC_LastCheck = 0;
	elseif (event == "RAID_ROSTER_UPDATE") or (event == "PARTY_MEMBERS_CHANGED") then
		TC_UnitList = nil; -- invalidate unit list
	elseif (event == "VARIABLES_LOADED") then
		if (TC_Settings == nil) or (TC_Settings["Version"] ~= TC_Version) then
			TC_MSG("TC: TargetCheck settings reset");
			TC_Settings = TC_Settings_Defaults;
			TC_CreateFrame();
		end;
		--Events
		TargetCheck_MainFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
		if (TC_Settings["Mouse"]) then
			TargetCheck_MainFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		end;
		
		TC_RestoreFrames();
	end;
end;

TC_LastCheck = 0;-- GetTime();
TC_OnUpdateCheck = function (delta)
	-- Ugly polling
	TC_LastCheck = TC_LastCheck + delta;
	if TC_LastCheck > 0.75 then
		TC_Check();
		TC_LastCheck = 0;
	end;
end;

TC_OnUpdate = TC_OnUpdateCheck;

TC_GetUnitList = function ()
	local ul = {};
	local i;
	if GetNumRaidMembers() > 0 then
		for i = 1, GetNumRaidMembers() do
			local unitname = "raid"..tostring(i);
			table.insert(ul, unitname);
		end;
	else
		for i = 1, GetNumPartyMembers() do
			local unitname = "party"..tostring(i);
			table.insert(ul, unitname);
		end;
	end;
	return ul;
end;

TC_UnitList = nil; -- {}
TC_FrameList = {};

TC_CreateFrame = function ()
	local f = {
			["Anchor"]	= "TOPLEFT";
			["Target"]	= "target";
			["Limit"]	= 6;
			["Header"]	= true;
			["SortOrder"]	= {
				"Targets";
				"Mage";
				"Warlock";
				"Rogue";
				"Warrior";
				"Hunter";
				"Priest";
				"Druid";
				"Paladin";
				"Shaman"
			};
			

			["Mage"]	= true;
			["Warlock"]	= true;
			["Priest"]	= true;
			["Warrior"]	= true;
			["Rogue"]	= true;
			["Hunter"]	= true;
			["Druid"]	= true;
			["Paladin"]	= true;
			["Shaman"]	= true;
			["Targets"]	= false;
		};
	table.insert(TC_Settings["Frames"], f);
	return f;
end;

TC_DeleteFrame = function (frame)
	local i = 1;
	while TC_FrameList[i] ~= nil and TC_FrameList[i] ~= frame do
		i = i + 1;
	end;
	table.remove(TC_Settings["Frames"], i);
	table.remove(TC_FrameList, i);
	frame["Pointer"]:Hide();
	setglobal(frame["Name"], nil);
	setglobal(frame["Name"].."_Menu", nil);
	for i = 0, 40 do
		local text = getglobal(frame["Name"].."_Text"..i);
		text:Hide();
		setglobal(frame["Name"].."_Text"..i, nil);
	end;
end;

TC_RestoreFrames = function ()
	for i, f in ipairs(TC_Settings["Frames"]) do
		TC_RestoreFrame(f, i);	
	end
	TC_MouseFrame = { -- pseudo frame
		["Settings"]	= TC_Settings["MouseFrame"];
		["Name"]	= "Mouse Frame";
		["Pointer"] = TargetCheck_Tooltip;
		["Lines"]	= 0;
		
		["writeLine"]	= TC_WriteLineTooltip;
		["clearLines"]	= TC_ClearLinesTooltip;
		["finishWrites"]= TC_FinishWritesTooltip;
	};
	TargetCheck_Tooltip:SetScale(TC_Settings["Scale"]);
end;

TC_RestoreFrame = function (f, i)
	local name = "TC_OutputFrame"..i;
	local pointer = CreateFrame("Frame", name, UIParent, "TargetCheck_OutputFrameTemplate");
	local frame = {
		["Settings"] = f;
		
		["Name"]	= name;
		["Pointer"]	= pointer;
		["Lines"]	= 0;
		
		["writeLine"]	= TC_WriteLine;
		["clearLines"]	= TC_ClearLines;
		["finishWrites"]= TC_FinishWrites;
	};
	table.insert(TC_FrameList, frame)

	pointer:SetScale(TC_Settings["Scale"]);
	pointer:SetAlpha(TC_Settings["Alpha"]);
	TC_SetAnchor(frame, f["Anchor"]);
	pointer["TC_Frame"] = frame;
	
	return frame;
end;

TC_Check = function ()
	if not TC_UnitList then -- Only rebuild before a check
		TC_UnitList = TC_GetUnitList(); -- Might have optimisation potential
	end;
	for _, f in ipairs(TC_FrameList) do
		local res, count = TC_CheckTarget(f);
		TC_WriteToFrame(f, res, count);
	end;
	if (TC_Settings["Mouse"]) then
		local res, count = TC_CheckTarget(TC_MouseFrame);
		TC_WriteToFrame(TC_MouseFrame, res, count);
	end;
end;

TC_ResultList = {};
TC_CheckTarget = function (frame)
	local target = frame["Settings"]["Target"];
	if not UnitExists(target) then
		return nil;
	else
		local counter = 0;
		for _, class in ipairs(frame["Settings"]["SortOrder"]) do
			TC_ResultList[class] = {};
		end;
		
		-- Find the Players who target the same target you do
		for _, unit in ipairs(TC_UnitList) do
			if frame["Settings"][UnitClass(unit)] and UnitIsUnit(target, unit.."target") and not UnitIsUnit("player", unit) then
				table.insert(TC_ResultList[UnitClass(unit)], unit);
				counter = counter + 1;
			end;
		end;
	
		return TC_ResultList, counter;
	end;
end;

TC_WriteToFrame = function (frame, resultList, counter)
	if resultList == nil --[[ or table.getn(resultList) == 0]] then
		frame["Pointer"]:Hide();

		return;
	else
		frame:clearLines();

		-- Setup Target of Target function
		if (frame["Settings"]["Header"]) then
			frame:writeLine((UnitName(frame["Settings"]["Target"])),
				1,1,1, nil, frame["Settings"]["Target"]);
			if (frame["Settings"]["TargetOfTarget"]) and
				UnitExists(frame["Settings"]["Target"].."target") then
				frame:writeLine("-> "..UnitName(frame["Settings"]["Target"].."target"),
					0.75,0.75,0.75, nil, frame["Settings"]["Target"].."target");
			end
		end;

		TC_Write(frame, resultList, counter);
		frame:finishWrites();
		return;
	end;
end;

TC_WriteReduced = function (frame, resultList, size)
	local classesWithPlayers = 0;
	local classesToList = 0;
	for _, class in ipairs(frame["Settings"]["SortOrder"]) do
		if table.getn(resultList[class]) > 0 then
			classesWithPlayers = classesWithPlayers + 1;
		end;
	end;
	local linesLeft = frame["Settings"]["Limit"]-frame["Lines"] - classesWithPlayers;
	for _, class in ipairs(frame["Settings"]["SortOrder"]) do
		local classSize = table.getn(resultList[class]);
		if linesLeft - classSize + 1 >= 0 then
			if classSize > 0 then
				classesToList = classesToList + 1;
				linesLeft = linesLeft - classSize + 1;
			end;
		else
			break;
		end;
	end;
	for _, class in ipairs(frame["Settings"]["SortOrder"]) do
		linesLeft = frame["Settings"]["Limit"]-frame["Lines"];
		if classesToList > 0 then
			local classSize = 0;
			classSize = TC_WriteClassList(frame, resultList[class], class, linesLeft);
			size = size - classSize;
			if (classSize > 0) then
				classesWithPlayers = classesWithPlayers - 1;
				classesToList = classesToList - 1;
			end;
		elseif (classesWithPlayers > 1) and (linesLeft == 1) then
			TC_WriteMore(frame, size);
			return;
		else
			local classSize = TC_WriteClassSummary(frame, resultList[class], class);
			size = size - classSize;
			if (classSize > 0) then
				classesWithPlayers = classesWithPlayers - 1;
			end;
		end
	end;
end;

TC_WriteFull = function (frame, resultList, size)
	local lines = 0;
	for _, class in ipairs(frame["Settings"]["SortOrder"]) do
		local linesLeft = frame["Settings"]["Limit"]-frame["Lines"];
		local classSize = table.getn(resultList[class]);
		if (linesLeft < classSize) or ((linesLeft == classSize) and (size - classSize - lines > 1)) then
			lines = lines + TC_WriteClassList(frame, resultList[class], class, linesLeft-1);
			TC_WriteMore(frame, size-lines);
			frame:finishWrites();
			return;
		else
			lines = lines + TC_WriteClassList(frame, resultList[class], class, linesLeft);
		end;
	end;
	frame:finishWrites();
end;

TC_Write = TC_WriteReduced;

TC_WriteClassList = function (frame, unitList, class, limit)
	local color = RAID_CLASS_COLORS[string.upper(class)];
	if color == nil then color = { ["r"] = 0.5; ["g"] = 0.5; ["b"] = 0.5; }; end;
	local count = limit;
	for _, unit in ipairs(unitList) do
		if (count > 0) then
			frame:writeLine((UnitName(unit)), color.r,color.g,color.b, nil, unit);
			count = count - 1;
		else
			return limit;
		end;
	end;
	return limit-count;
end;

TC_WriteClassSummary = function (frame, unitList, class)
	color = RAID_CLASS_COLORS[string.upper(class)];
	if color == nil then color = { ["r"] = 0.5; ["g"] = 0.5; ["b"] = 0.5; }; end;
	local size = table.getn(unitList);
	if (size == 1) then
		TC_WriteClassList(frame, unitList, class, 1);
	elseif (size > 1) then
		frame:writeLine("> "..table.getn(unitList).." "..class.."s", color.r,color.g,color.b);
	end;
	return size;
end;

TC_WriteMore = function (frame, num)
	if (num > 0) then
		frame:writeLine("> "..num.." more...", 0.8,0.8,0.8);
	end;
end;

TC_WriteLine = function (frame, text, cr, cg, cb, idx, unit)
	if (not idx) then
		if frame["Lines"] <= 40 then
			idx = frame["Lines"];
		else
			idx = 40;
		end;
	end;
	local textLine = getglobal(frame["Name"].."_Text"..idx);
	local texLine = getglobal(frame["Name"].."_Texture"..idx);	
	textLine:SetText(text);
	textLine:SetTextColor(cr, cg, cb);
	textLine:Show();

	if unit and frame["Settings"]["Mana"] then
		local width = (frame["Pointer"]:GetWidth()-16)*UnitMana(unit)/UnitManaMax(unit);
		texLine:ClearAllPoints();
		texLine:SetPoint("TOPLEFT", frame["Pointer"], "TOPLEFT", 8, (idx*-14)-8);
		texLine:SetPoint("BOTTOMRIGHT", frame["Pointer"], "TOPLEFT", 8+width, (idx*-14)-22);
		texLine:Show();
	end;

	frame["Lines"] = frame["Lines"] + 1;
end;

TC_WriteLineTooltip = function(frame, text, cr, cg, cb, idx)
	frame["Pointer"]:AddLine(text, cr, cg, cb, 0.5);
	frame["Lines"] = frame["Lines"] + 1;
end;

TC_FinishWrites = function (frame)
	if not TC_Resizing then
		frame["Pointer"]:SetHeight(frame["Lines"]*14+16);
	end;
	if not TC_Transforming and frame["Lines"] == 0 then
		frame["Pointer"]:Hide();
	else
		frame["Pointer"]:Show();
	end;
end;

TC_FinishWritesTooltip = function (frame)
	frame["Pointer"]:Show();
end;

TC_ClearLines = function (frame)
	frame["Lines"] = 0;
	for i = 0, 40 do
		local text = getglobal(frame["Name"].."_Text"..i);
		local tex = getglobal(frame["Name"].."_Texture"..i);
		text:Hide();
		tex:Hide();
	end;
end;

TC_ClearLinesTooltip = function (frame)
	frame["Lines"] = 0;
	if not (frame["Pointer"]:IsOwned(UIParent)) then
		frame["Pointer"]:SetOwner(UIParent, "ANCHOR_CURSOR");
		frame["Pointer"]:SetAlpha(TC_Settings["Alpha"]*0.5);
		frame["Pointer"]:SetBackdropColor(0,0,0,TC_Settings["Alpha"]*0.5);
		frame["Pointer"]:SetBackdropBorderColor(1,1,1 ,TC_Settings["Alpha"]*0.5);
	end;
	frame["Pointer"]:ClearLines();
end;

TC_TogglePref = function (array, setting, state)
	if state == "off" or state == "false" then
		array[setting] = false;
		TC_MSG("TC: "..setting.." Disabled");
	elseif state == "on" or state == "true" then
		array[setting] = true;
		TC_MSG("TC: "..setting.." Enabled");
	else
		array[setting] = not array[setting];
		if array[setting] then
			TC_MSG("TC: "..setting.." Enabled");
		else
			TC_MSG("TC: "..setting.." Disabled");
		end;
	end;
end;

TC_SetPrefNum = function (array, setting, value)
	local valueNum = tonumber(value);
	if valueNum == nil then
		TC_MSG("BT: "..setting.." Input Error, "..value.." is not a number");
	else 
		array[setting] = valueNum;
		TC_MSG("BT: "..setting.." set to "..valueNum);
	end;
end;

TC_SetAnchor = function (frame, anchor)
	local xp, yp;
	frame["Settings"]["Anchor"] = anchor;
	if string.find(anchor, "TOP") then
		yp = frame["Pointer"]:GetTop();
	else
		yp = frame["Pointer"]:GetBottom();
	end;
	if string.find(anchor, "LEFT") then
		xp = frame["Pointer"]:GetLeft();
	else
		xp = frame["Pointer"]:GetRight();
	end;
	frame["Pointer"]:ClearAllPoints();
	frame["Pointer"]:SetPoint(anchor, UIParent, "BOTTOMLEFT", xp, yp);
end;

TC_SetFrameTarget = function (frame, target)
	frame["Settings"]["Target"] = target;
end;

TC_SetFrameTargetCustom = function (frame)
	TargetCheck_TextQuery.func = TC_SetFrameTarget;
	TargetCheck_TextQuery.arg1 = frame;
	TargetCheck_TextQuery:Show();
end;

TC_SlashHandler = function (msg)
 	local Cmd, SubCmd = TC_GetCmd(msg);
 	Cmd = string.lower(Cmd);
	if (Cmd == "scale") then
		TC_SetPrefNum(TC_Settings, "Scale", SubCmd);
		for _, f in ipairs(TC_FrameList) do
			f["Pointer"]:SetScale(TC_Settings["Scale"]);
		end
	elseif (Cmd == "alpha") then
		TC_SetPrefNum(TC_Settings, "Alpha", SubCmd);
		for _, f in ipairs(TC_FrameList) do
			f["Pointer"]:SetAlpha(TC_Settings["Alpha"]);
		end
	elseif (Cmd == "limit") then
		for _, f in ipairs(TC_FrameList) do TC_SetPrefNum(f["Settings"], "Limit", SubCmd); end;
	elseif (Cmd == "filter") then
		local class, state = TC_GetCmd(SubCmd);
		class = string.lower(class);
		if (class == "mage") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Mage", state); end;
		elseif (class == "warlock") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Warlock", state); end;
		elseif (class == "priest") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Priest", state); end;
		elseif (class == "warrior") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Warrior", state); end;
		elseif (class == "rogue") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Rogue", state); end;
		elseif (class == "hunter") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Hunter", state); end;
		elseif (class == "druid") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Druid", state); end;
		elseif (class == "paladin") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Paladin", state); end;
		elseif (class == "shaman") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Shaman", state); end;
		elseif (class == "targets") then
			for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Targets", state); end;
		else
			TC_MSG("TC: Class "..class.." can not be filtered out");
		end;
	elseif (Cmd == "header") then
		for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Header", SubCmd); end;
	elseif (Cmd == "mana") then
		for _, f in ipairs(TC_FrameList) do TC_TogglePref(f["Settings"], "Mana", SubCmd); end;
	elseif (Cmd == "anchor") then
		if (SubCmd == "topleft") or (SubCmd == "topright") or
			(SubCmd == "bottomleft") or (SubCmd == "bottomright") then
			for _, f in ipairs(TC_FrameList) do
				TC_SetAnchor(f, string.upper(SubCmd));
			end;
			TC_MSG("TC: Anchor set to "..SubCmd);
		else
			TC_MSG("TC: Anchor could not be set to "..SubCmd);
		end;
	elseif (Cmd == "mouse") then
		TC_TogglePref(TC_Settings, "Mouse", SubCmd);
		if (TC_Settings["Mouse"]) then
			TargetCheck_MainFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		else
			TargetCheck_MainFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
			TC_MouseFrame["Pointer"]:Hide();
		end;
	elseif (Cmd == "mouseheader") then
		TC_TogglePref(TC_Settings["MouseFrame"], "Header", SubCmd);
	elseif (Cmd == "mouselimit") then
		TC_SetPrefNum(TC_Settings["MouseFrame"], "Limit", SubCmd);
	elseif (Cmd == "mousefilter") then
		local class, state = TC_GetCmd(SubCmd);
		class = string.lower(class);
		if (class == "mage") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Mage", state);
		elseif (class == "warlock") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Warlock", state); 
		elseif (class == "priest") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Priest", state);
		elseif (class == "warrior") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Warrior", state);
		elseif (class == "rogue") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Rogue", state);
		elseif (class == "hunter") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Hunter", state); 
		elseif (class == "druid") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Druid", state);
		elseif (class == "paladin") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Paladin", state);
		elseif (class == "shaman") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Shaman", state);
		elseif (class == "targets") then
			TC_TogglePref(TC_Settings["MouseFrame"], "Targets", state);
		else
			TC_MSG("TC: Class "..class.." can not be filtered out");
		end;
	elseif (Cmd == "create") then
		local f = TC_CreateFrame();
		TC_RestoreFrame(f, table.getn(TC_FrameList)+1);
 	else
 		TC_MSG("|cffccccccTargetCheck v"..TC_Version);
 		TC_MSG("Shift Click to Move, Alt Click to resize");
 		TC_MSG("Right Click to set individual settings");
		TC_MSG("/targetcheck scale <num>");
		TC_MSG("/targetcheck alpha <num>");
		TC_MSG("/targetcheck filter <class> [on|off]");
		TC_MSG("/targetcheck header [on|off]");
		TC_MSG("/targetcheck mana [on|off]");
		TC_MSG("/targetcheck anchor [topleft|bottomleft]");
		TC_MSG("/targetcheck limit <num>");
		TC_MSG("/targetcheck mouse [on|off]");
		TC_MSG("/targetcheck mouseFilter <class> [on|off]");
		TC_MSG("/targetcheck mouseHeader [on|off]");
		TC_MSG("/targetcheck mouseLimit <num>");
		TC_MSG("/targetcheck create");
 	end;
end;

TC_MSG = function (msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end;

TC_Menu_Initialize = function (level)
	if level == 1 then
		UIDropDownMenu_AddButton({
			["text"] = "TargetCheck v"..TC_Version;
			["isTitle"] = 1;
			["notCheckable"] = 1;
			["owner"] = TargetCheck_OutputFrame;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Filter";
			["value"] = "Filter";
			["notCheckable"] = 1;
			["hasArrow"] = 1;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Target";
			["value"] = "Target";
			["notCheckable"] = 1;
			["hasArrow"] = 1;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Anchor";
			["value"] = "Anchor";
			["notCheckable"] = 1;
			["hasArrow"] = 1;
			});
		UIDropDownMenu_AddButton({
			["text"] = "Show Header";
			["checked"] = TC_CurrentFrameWithMenu["Settings"]["Header"];
			["func"] = TC_TogglePref;
			["arg1"] = TC_CurrentFrameWithMenu["Settings"];
			["arg2"] = "Header";
			});
		UIDropDownMenu_AddButton({
			["text"] = "Show Mana";
			["checked"] = TC_CurrentFrameWithMenu["Settings"]["Mana"];
			["func"] = TC_TogglePref;
			["arg1"] = TC_CurrentFrameWithMenu["Settings"];
			["arg2"] = "Mana";
			});
		UIDropDownMenu_AddButton({
			["text"] = "Delete";
			["notCheckable"] = 1;
			["func"] = TC_DeleteFrame;
			["arg1"] = TC_CurrentFrameWithMenu;
			});
	elseif level == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "Filter" then
			for _, class in ipairs(TC_CurrentFrameWithMenu["Settings"]["SortOrder"]) do
				local toggle, checked;
				if TC_CurrentFrameWithMenu["Settings"][class] then
					checked = true;
				else
					checked = false;
				end;
				UIDropDownMenu_AddButton({
					["text"] = class;
					["checked"] = checked;
					["func"] = TC_TogglePref;
					["arg1"] = TC_CurrentFrameWithMenu["Settings"];
					["arg2"] = class;
					["keepShownOnClick"] = 1;
				}, 2);
			end;
		elseif UIDROPDOWNMENU_MENU_VALUE == "Target" then
			UIDropDownMenu_AddButton({
				["text"] = "player".." ("..(UnitName("player"))..")";
				["notCheckable"] = 1;
				["func"] = TC_SetFrameTarget;
				["arg1"] = TC_CurrentFrameWithMenu;
				["arg2"] = "player";
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "target";
				["notCheckable"] = 1;
				["func"] = TC_SetFrameTarget;
				["arg1"] = TC_CurrentFrameWithMenu;
				["arg2"] = "target";
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "Custom...";
				["notCheckable"] = 1;
				["func"] = TC_SetFrameTargetCustom;
				["arg1"] = TC_CurrentFrameWithMenu;
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "Party";
				["value"] = "Party";
				["notCheckable"] = 1;
				["hasArrow"] = 1;
				}, 2);
			for i = 1,8 do
				UIDropDownMenu_AddButton({
					["text"] = "Raid Party "..i;
					["value"] = i;
					["notCheckable"] = 1;
					["hasArrow"] = 1;
					}, 2);
			end;
		elseif UIDROPDOWNMENU_MENU_VALUE == "Anchor" then
			UIDropDownMenu_AddButton({
				["text"] = "Top Left";
				["notCheckable"] = 1;
				["func"] = TC_SetAnchor;
				["arg1"] = TC_CurrentFrameWithMenu;
				["arg2"] = "TOPLEFT";
				}, 2);
			UIDropDownMenu_AddButton({
				["text"] = "Bottom Right";
				["notCheckable"] = 1;
				["func"] = TC_SetAnchor;
				["arg1"] = TC_CurrentFrameWithMenu;
				["arg2"] = "BOTTOMRIGHT";
				}, 2);
		end;
	elseif level == 3 then
		if UIDROPDOWNMENU_MENU_VALUE == "Party" then
			local u,s;
			for i = 1,4 do
				u = "party"..i;
				if UnitExists(u) then
					s = u.." ("..(UnitName(u))..")";
				else
					s = u;
				end;
				UIDropDownMenu_AddButton({
					["text"] = s;
					["notCheckable"] = 1;
					["func"] = TC_SetFrameTarget;
					["arg1"] = TC_CurrentFrameWithMenu;
					["arg2"] = u;
					}, 3);
			end;
		else
			local j = (UIDROPDOWNMENU_MENU_VALUE-1)*5+1;
			local u, s;
			for i = j,j+4 do
				u = "raid"..i;
				if UnitExists(u) then
					s = u.." ("..(UnitName(u))..")";
				else
					s = u;
				end;
				UIDropDownMenu_AddButton({
					["text"] = s;
					["notCheckable"] = 1;
					["func"] = TC_SetFrameTarget;
					["arg1"] = TC_CurrentFrameWithMenu;
					["arg2"] = u;
					}, 3);
			end;
		end;
	end
end;

TC_Menu_Load = function (menu)
	UIDropDownMenu_Initialize(menu, TC_Menu_Initialize, "MENU");
end;

TC_Transforming = false;
TC_Moving = false;
TC_Resizing = false;
TC_FrameMouseDown = function ()
	if (arg1 == "LeftButton") then
		if (IsShiftKeyDown()) then
			this:StartMoving();
			TC_Transforming = true;
			TC_Moving = true;
		elseif (IsAltKeyDown()) then
			local w = this:GetWidth();
			local h = this:GetHeight();
			local x, y = this:GetCenter();
			local mx, my = GetCursorPosition();
			local scaleL, scaleW;
			scaleL = this:GetScale();
			scaleW = UIParent:GetScale();
			mx = mx/scaleW;
			my = my/scaleW;
			x = x*scaleL;
			y = y*scaleL
			x = mx - x;
			y = my - y;
			x = x/w*h;
			if (abs(x) > abs(y)) then
				if (x > 0) then
					this:StartSizing("RIGHT");
				else
					this:StartSizing("LEFT");
				end;
			else
				if (y > 0) then
					this:StartSizing("TOP");
				else
					this:StartSizing("BOTTOM");
				end;
			end;
			TC_Transforming = true;
			TC_Resizing = true;
		end;
	elseif (arg1 == "RightButton") then
		local menu = getglobal(this["TC_Frame"]["Name"].."_Menu");
		TC_CurrentFrameWithMenu = this["TC_Frame"];
		ToggleDropDownMenu(1, nil, menu, this["TC_Frame"]["Name"], 0, 0);
	end;
end;

TC_FrameResized = function ()
	local height = this:GetHeight();
	if TC_Resizing then
		TC_SetPrefNum(this["TC_Frame"]["Settings"], "Limit", math.ceil((height-16)/14));
	end;
	TC_Transforming = false;
	TC_Moving = false;
	TC_Resizing = false;
end;

-- Some CMD parsing code, written by Tigerheart on http://www.wowwiki.com/HOWTO:_Extract_Info_from_a_Slash_Command
TC_GetCmd = function (msg)
	if msg then
		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
		if a then
			return c, strsub(msg, b+2);
		else	
			return "";
		end
	end
end;

TC_GetArgument = function (msg)
	if msg then
		local a,b=strfind(msg, "=");
		if a then
			return strsub(msg,1,a-1), strsub(msg, b+1);
		else
			return "";
		end
	end
end;
