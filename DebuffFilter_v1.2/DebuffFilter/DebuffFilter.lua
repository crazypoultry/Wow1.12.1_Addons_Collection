local DebuffFilter_DefaultSettings = {
	debuffs = "yes",
	buffs = "no",
	fdebuffs = "no",
	fbuffs = "no",
	scale = 1,
	debuff_orientation = "leftright",
	buff_orientation = "leftright",
	fdebuff_orientation = "leftright",
	fbuff_orientation = "leftright",
	time_orientation = "bottom",
	all_fdebuffs = "no",
	all_fbuffs = "no",
	count = "no",
	tooltips = "yes",
	debuff_list = {
		["Sunder Armor"] = 1,
		["Faerie Fire"] = 1,
		["Curse of Recklessness"] = 1,
		["Thunder Clap"] = 1,
		["Expose Armor"] = 1,
	},
	buff_list = {
		["Battle Shout"] = 1,
		["Adrenaline Rush"] = 1,
		["Blade Flurry"] = 1,
		["Holy Strength"] = 1,
	},
	fdebuff_list = {
		["Sunder Armor"] = 1,
	},
	fbuff_list = {
		["Berserker Rage"] = 1,
	},
}

local DebuffFilter = {};

DebuffFilter.backdrop = nil;
DebuffFilter.debuffs_hostile = nil;
DebuffFilter.fdebuffs_friendly = nil;
DebuffFilter.fbuffs_friendly = nil;
DebuffFilter.hostile_name = "";
DebuffFilter.friendly_name = "";

DebuffFilter.FrameOrientation = {
	leftright = { point="LEFT", relpoint="RIGHT", x=1, y=0, count_y=0, next_orient="topbottom", next_time="left" },
	topbottom = { point="TOP", relpoint="BOTTOM", x=0, y=-1, count_y=8, next_orient="rightleft", next_time="bottom" },
	rightleft = { point="RIGHT", relpoint="LEFT", x=-1, y=0, count_y=0, next_orient="bottomtop", next_time="right" },
	bottomtop = { point="BOTTOM", relpoint="TOP", x=0, y=1, count_y=-8, next_orient="leftright", next_time="bottom" },
}

DebuffFilter.TimeOrientation = {
	bottom = { next_time = "top" },
	top = { next_time = "bottom" },
	left = { next_time = "right" },
	right = { next_time = "left" },
}

DebuffFilter.Frames = {
	debuffs = { frame="DebuffFilter_DebuffFrame", orient_key="debuff_orientation", list="debuff_list", name="debuff", target="hostile", add_cmd="add", del_cmd="del", list_cmd="list", button="DebuffFilter_DebuffButton", start=1, num=0, relnum=1, x=2, y=2 },
	buffs = { frame="DebuffFilter_BuffFrame", orient_key="buff_orientation", list="buff_list", name="buff" , target="", add_cmd="addb", del_cmd="delb", list_cmd="listb", button="DebuffFilter_BuffButton", start=0, num=1, relnum=2, x=4, y=4 },
	fdebuffs = { frame = "DebuffFilter_FDebuffFrame", orient_key = "fdebuff_orientation", list="fdebuff_list", name="friendly debuff", target="friendly", add_cmd="addfd", del_cmd="delfd", list_cmd="listfd", all_cmd="allfd", button="DebuffFilter_FDebuffButton", start=1, num=0, relnum=1, x=2, y=2 },
	fbuffs = { frame = "DebuffFilter_FBuffFrame", orient_key = "fbuff_orientation", list="fbuff_list", name="friendly buff", target="friendly", add_cmd="addfb", del_cmd="delfb", list_cmd="listfb", all_cmd="allfb", button="DebuffFilter_FBuffButton", start=1, num=0, relnum=1, x=4, y=4 },
}

DebuffFilter_Targets = {
	hostile = "target",
	friendly = "targettarget",
}

local function DebuffFilter_Initialize()
	if (not DebuffFilter_Config) then
		DebuffFilter_Config = {};
	end

	if (not DebuffFilter_Config[DebuffFilter_Player]) then
		DebuffFilter_Config[DebuffFilter_Player] = {};
	end

	for i in DebuffFilter_DefaultSettings do
		if (not DebuffFilter_Config[DebuffFilter_Player][i]) then
			DebuffFilter_Config[DebuffFilter_Player][i] = DebuffFilter_DefaultSettings[i];
		end
	end

	for i in DebuffFilter.Frames do
		local frame = DebuffFilter.Frames[i]["frame"];
		local orient_key = DebuffFilter.Frames[i]["orient_key"];

		if (DebuffFilter_Config[DebuffFilter_Player][i] == "no") then
			getglobal(frame):Hide();
		end

		DebuffFilter_FrameOrientation(DebuffFilter_Config[DebuffFilter_Player][orient_key], frame);
	end

	DebuffFilter_TimeOrientation(DebuffFilter_Config[DebuffFilter_Player]["time_orientation"]);

	SlashCmdList["DFILTER"] = DebuffFilter_command;
	SLASH_DFILTER1 = "/dfilter";
end

function DebuffFilter_OnMouseDown(arg1)
	if (arg1 == "LeftButton" and IsShiftKeyDown()) then
		this:GetParent():StartMoving();
	elseif (arg1 == "RightButton" and IsShiftKeyDown()) then
		local frame, name, orient_key, orientation, time_orientation;
		
		frame = this:GetParent():GetName();

		for i in DebuffFilter.Frames do
			if (DebuffFilter.Frames[i]["frame"] == frame) then
				name = DebuffFilter.Frames[i]["name"];
				orient_key = DebuffFilter.Frames[i]["orient_key"];
				orientation = DebuffFilter_Config[DebuffFilter_Player][orient_key];
				break;
			end
		end

		for i in DebuffFilter.FrameOrientation do
			if (i == orientation) then
				local next_orient = DebuffFilter.FrameOrientation[i]["next_orient"];

				DebuffFilter_Config[DebuffFilter_Player][orient_key] = next_orient;
				DebuffFilter_FrameOrientation(next_orient, frame);
				DebuffFilter_Print(name .. " orientation: " .. DebuffFilter.FrameOrientation[i]["next_orient"]);

				time_orientation = DebuffFilter.FrameOrientation[i]["next_time"];

				break;
			end
		end

		if (frame == "DebuffFilter_BuffFrame") then
			DebuffFilter_Config[DebuffFilter_Player]["time_orientation"] = time_orientation;
			DebuffFilter_TimeOrientation(time_orientation);
		end

	elseif (arg1 == "RightButton" and IsControlKeyDown()) then
		local time_orientation = DebuffFilter_Config[DebuffFilter_Player]["time_orientation"];

		local next_time = DebuffFilter.TimeOrientation[time_orientation]["next_time"];
		DebuffFilter_Config[DebuffFilter_Player]["time_orientation"] = next_time;
		DebuffFilter_TimeOrientation(next_time);
		DebuffFilter_Print("buff time orientation: " .. next_time);
	end
end

function DebuffFilter_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		this:GetParent():StopMovingOrSizing();
	end
end

function DebuffFilter_OnLoad()
	DebuffFilter_Player = (UnitName("player").." - "..GetRealmName());
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("UNIT_AURA");
end

function DebuffFilter_DebuffFrame_Update(unit)
	if (DebuffFilter_Config[DebuffFilter_Player]["debuffs"] == "no") then
		return;
	end

	if (UnitCanAttack("player", unit)) then
		DebuffFilter.debuffs_hostile = 1;
		DebuffFilter.hostile_name = UnitName(unit);
	else
		if (DebuffFilter.debuffs_hostile == 1) then
			DebuffFilter.debuffs_hostile = 0;

			for i = 1, 16, 1 do
				local name = "DebuffFilter_DebuffButton" .. i;
				local button = getglobal(name);

				button:Hide();
				getglobal(name .. "Count"):SetText("");
				button:SetWidth(-2);
				button:SetHeight(-2);
			end

			DebuffFilter_DebuffFrameCount:Hide();
		end

		return;
	end

	local width = 0;
	for i = 1, 16, 1 do
		local name = "DebuffFilter_DebuffButton" .. i;
		local button = getglobal(name);
		local debufftexture, debuffapplications, debufftype = UnitDebuff(unit, i);
		local debufftext = getglobal(name .. "Count");

		if (debufftexture) then
			DebuffFilter_DebuffFrameCount:SetText(i);

			DebuffFilter_Tooltip:ClearLines();
			DebuffFilter_Tooltip:SetUnitDebuff(unit, i);

			if (DebuffFilter_Config[DebuffFilter_Player]["debuff_list"][DebuffFilter_TooltipTextLeft1:GetText()] == 1) then
				getglobal(name .. "Icon"):SetTexture(debufftexture);
				if (debufftype) then
					color = DebuffTypeColor[debufftype];
				else
					color = DebuffTypeColor["none"];
				end

				if (debuffapplications > 1) then
					debufftext:SetText(debuffapplications);
				else
					debufftext:SetText("");
				end

				getglobal(name .. "Border"):SetVertexColor(color.r, color.g, color.b);
				button:SetWidth(30);
				button:SetHeight(30);
				button:Show();

				width = width + 1;

				if (DebuffFilter_Config[DebuffFilter_Player]["count"] == "yes") then
					DebuffFilter_DebuffFrameCount:Show();
				end
			else
				button:Hide();
				debufftext:SetText("");
				button:SetWidth(-2);
				button:SetHeight(-2);
			end
		else
			button:Hide();
			debufftext:SetText("");
			button:SetWidth(-2);
			button:SetHeight(-2);
		end
	end

	if (width == 0) then
		DebuffFilter_DebuffFrameCount:Hide();
	end
end

function DebuffFilter_BuffFrame_Update()
	if (DebuffFilter_Config[DebuffFilter_Player]["buffs"] == "no") then
		return;
	end

	local count = 0;
	local width = 0;

	for i = 0, 15, 1 do
		local name = "DebuffFilter_BuffButton" .. i;
		local button = getglobal(name);
		local buffindex, untilcancelled = GetPlayerBuff(i, "HELPFUL");
		local bufftext = getglobal(name .. "Count");
		local bufftime = getglobal(name .. "Duration");

		if (buffindex >= 0) then
			count = count + 1;
			DebuffFilter_BuffFrameCount:SetText(count);

			DebuffFilter_Tooltip:ClearLines();
			DebuffFilter_Tooltip:SetPlayerBuff(buffindex);

			if (DebuffFilter_Config[DebuffFilter_Player]["buff_list"][DebuffFilter_TooltipTextLeft1:GetText()] == 1) then
				getglobal(name .. "Icon"):SetTexture(GetPlayerBuffTexture(buffindex));

				local buffapplications = GetPlayerBuffApplications(buffindex);
				local bufftimeleft = GetPlayerBuffTimeLeft(buffindex);

				if (buffapplications > 1) then
					bufftext:SetText(buffapplications);
				else
					bufftext:SetText("");
				end

				if (untilcancelled ~= 1) then
					if (11 >= bufftimeleft) then
						bufftime:SetTextColor(1, 0, 0);
					else
						bufftime:SetTextColor(1, 0.82, 0);
					end

					bufftime:SetText(DebuffFilter_GetStrTime(floor(bufftimeleft)));
				else
					bufftime:SetText("");
				end

				button:SetWidth(30);
				button:SetHeight(30);
				button:Show();

				width = width + 1;

				if (DebuffFilter_Config[DebuffFilter_Player]["count"] == "yes") then
					DebuffFilter_BuffFrameCount:Show();
				end
			else
				button:Hide();
				bufftext:SetText("");
				bufftime:SetText("");
				button:SetWidth(-4);
				button:SetHeight(-4);
			end
		else
			button:Hide();
			bufftext:SetText("");
			bufftime:SetText("");
			button:SetWidth(-4);
			button:SetHeight(-4);
		end
	end

	if (width == 0) then
		DebuffFilter_BuffFrameCount:Hide();
	end
end

function DebuffFilter_FDebuffFrame_Update(unit)
	if (DebuffFilter_Config[DebuffFilter_Player]["fdebuffs"] == "no") then
		return;
	end

	if (UnitIsFriend("player", unit)) then
		DebuffFilter.fdebuffs_friendly = 1;
		DebuffFilter.friendly_name = UnitName(unit);
	else
		if (DebuffFilter.fdebuffs_friendly == 1) then
			DebuffFilter.fdebuffs_friendly = 0;

			for i = 1, 16, 1 do
				local name = "DebuffFilter_FDebuffButton" .. i;
				local button = getglobal(name);

				button:Hide();
				getglobal(name .. "Count"):SetText("");
				button:SetWidth(-2);
				button:SetHeight(-2);
			end

			DebuffFilter_FDebuffFrameCount:Hide();
		end

		return;
	end

	local width = 0;
	for i = 1, 16, 1 do
		local name = "DebuffFilter_FDebuffButton" .. i;
		local button = getglobal(name);
		local debufftexture, debuffapplications, debufftype = UnitDebuff(unit, i);
		local debufftext = getglobal(name .. "Count");

		if (debufftexture) then
			DebuffFilter_FDebuffFrameCount:SetText(i);

			DebuffFilter_Tooltip:ClearLines();
			DebuffFilter_Tooltip:SetUnitDebuff(unit, i);

			if (DebuffFilter_Config[DebuffFilter_Player]["fdebuff_list"][DebuffFilter_TooltipTextLeft1:GetText()] == 1) or (DebuffFilter_Config[DebuffFilter_Player]["all_fdebuffs"] == "yes") then
				getglobal(name .. "Icon"):SetTexture(debufftexture);
				if (debufftype) then
					color = DebuffTypeColor[debufftype];
				else
					color = DebuffTypeColor["none"];
				end

				if (debuffapplications > 1) then
					debufftext:SetText(debuffapplications);
				else
					debufftext:SetText("");
				end

				getglobal(name .. "Border"):SetVertexColor(color.r, color.g, color.b);
				button:SetWidth(30);
				button:SetHeight(30);
				button:Show();

				width = width + 1;

				if (DebuffFilter_Config[DebuffFilter_Player]["count"] == "yes") then
					DebuffFilter_FDebuffFrameCount:Show();
				end
			else
				button:Hide();
				debufftext:SetText("");
				button:SetWidth(-2);
				button:SetHeight(-2);
			end
		else
			button:Hide();
			debufftext:SetText("");
			button:SetWidth(-2);
			button:SetHeight(-2);
		end
	end

	if (width == 0) then
		DebuffFilter_FDebuffFrameCount:Hide();
	end
end

function DebuffFilter_FBuffFrame_Update(unit)
	if (DebuffFilter_Config[DebuffFilter_Player]["fbuffs"] == "no") then
		return;
	end

	if (UnitIsFriend("player", unit)) then
		DebuffFilter.fbuffs_friendly = 1;
		DebuffFilter.friendly_name = UnitName(unit);
	else
		if (DebuffFilter.fbuffs_friendly == 1) then
			DebuffFilter.fbuffs_friendly = 0;

			for i = 1, 16, 1 do
				local name = "DebuffFilter_FBuffButton" .. i;
				local button = getglobal(name);

				button:Hide();
				getglobal(name .. "Count"):SetText("");
				button:SetWidth(-4);
				button:SetHeight(-4);
			end

			DebuffFilter_FBuffFrameCount:Hide();
		end

		return;
	end

	local width = 0;
	for i = 1, 16, 1 do
		local name = "DebuffFilter_FBuffButton" .. i;
		local button = getglobal(name);
		local bufftexture, buffapplications = UnitBuff(unit, i);
		local bufftext = getglobal(name .. "Count");

		if (bufftexture) then
			DebuffFilter_FBuffFrameCount:SetText(i);

			DebuffFilter_Tooltip:ClearLines();
			DebuffFilter_Tooltip:SetUnitBuff(unit, i);

			if (DebuffFilter_Config[DebuffFilter_Player]["fbuff_list"][DebuffFilter_TooltipTextLeft1:GetText()] == 1) or (DebuffFilter_Config[DebuffFilter_Player]["all_fbuffs"] == "yes") then
				getglobal(name .. "Icon"):SetTexture(bufftexture);

				if (buffapplications > 1) then
					bufftext:SetText(buffapplications);
				else
					bufftext:SetText("");
				end

				button:SetWidth(30);
				button:SetHeight(30);
				button:Show();

				width = width + 1;

				if (DebuffFilter_Config[DebuffFilter_Player]["count"] == "yes") then
					DebuffFilter_FBuffFrameCount:Show();
				end
			else
				button:Hide();
				bufftext:SetText("");
				button:SetWidth(-4);
				button:SetHeight(-4);
			end
		else
			button:Hide();
			bufftext:SetText("");
			button:SetWidth(-4);
			button:SetHeight(-4);
		end
	end

	if (width == 0) then
		DebuffFilter_FBuffFrameCount:Hide();
	end
end

function DebuffFilter_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		this:UnregisterEvent("VARIABLES_LOADED");
		DebuffFilter_Initialize();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");
		DebuffFilterFrame:SetScale(DebuffFilter_Config[DebuffFilter_Player]["scale"] * UIParent:GetScale());
	elseif (event == "PLAYER_TARGET_CHANGED") then
		if (UnitCanAttack("player", "target")) then
			DebuffFilter_Targets["hostile"] = "target";
			DebuffFilter_Targets["friendly"] = "targettarget";
		else
			DebuffFilter_Targets["friendly"] = "target";
			DebuffFilter_Targets["hostile"] = "targettarget";
		end

		DebuffFilter_DebuffFrame_Update(DebuffFilter_Targets["hostile"]);
		DebuffFilter_FDebuffFrame_Update(DebuffFilter_Targets["friendly"]);
		DebuffFilter_FBuffFrame_Update(DebuffFilter_Targets["friendly"]);
	elseif (event == "UNIT_AURA" and arg1 == "target") then
		DebuffFilter_DebuffFrame_Update(DebuffFilter_Targets["hostile"]);
		DebuffFilter_FDebuffFrame_Update(DebuffFilter_Targets["friendly"]);
		DebuffFilter_FBuffFrame_Update(DebuffFilter_Targets["friendly"]);
	elseif (event == "PLAYER_AURAS_CHANGED") then
		DebuffFilter_BuffFrame_Update();

		if (UnitName("player") == UnitName(DebuffFilter_Targets["friendly"])) then
			DebuffFilter_FDebuffFrame_Update(DebuffFilter_Targets["friendly"]);
			DebuffFilter_FBuffFrame_Update(DebuffFilter_Targets["friendly"]);
		end
	elseif (event == "PLAYER_REGEN_DISABLED") then
		DebuffFilter_DebuffFrame_Update(DebuffFilter_Targets["hostile"]);
		DebuffFilter_FDebuffFrame_Update(DebuffFilter_Targets["friendly"]);
		DebuffFilter_FBuffFrame_Update(DebuffFilter_Targets["friendly"]);
	end
end

function DebuffFilter_DebuffButton_OnUpdate(elapsed)
	this.update = this.update + elapsed;
	if (this.update >= 1) then
		this.update = this.update - 1;
		if (DebuffFilter.hostile_name ~= UnitName(DebuffFilter_Targets["hostile"])) then
			DebuffFilter_DebuffFrame_Update(DebuffFilter_Targets["hostile"]);
		else
			local debufftexture, debuffapplications, _ = UnitDebuff(DebuffFilter_Targets["hostile"], this:GetID());
			local debufftext = getglobal(this:GetName() .. "Count");

			if (debufftexture) then
				if (debuffapplications > 1) then
					debufftext:SetText(debuffapplications);
				else
					debufftext:SetText("");
				end
			else
				DebuffFilter_DebuffFrame_Update(DebuffFilter_Targets["hostile"]);
			end
		end
	end
end

function DebuffFilter_BuffButton_OnUpdate(elapsed)
	this.update = this.update + elapsed;
	if (this.update >= 1) then
		this.update = this.update - 1;
		local buffindex, untilcancelled = GetPlayerBuff(this:GetID(), "HELPFUL");
		local buffapplications = GetPlayerBuffApplications(buffindex);
		local bufftimeleft = GetPlayerBuffTimeLeft(buffindex);
		local bufftext = getglobal(this:GetName() .. "Count");
		local bufftime = getglobal(this:GetName() .. "Duration");

		if (buffapplications > 1) then
			bufftext:SetText(buffapplications);
		else
			bufftext:SetText("");
		end

		if (untilcancelled == 1) then
			bufftime:SetText("");
			return;
		end

		if (11 >= bufftimeleft) then
			bufftime:SetTextColor(1, 0, 0);
		else
			bufftime:SetTextColor(1, 0.82, 0);
		end

		bufftime:SetText(DebuffFilter_GetStrTime(floor(bufftimeleft)));
	end
end

function DebuffFilter_FDebuffButton_OnUpdate(elapsed)
	this.update = this.update + elapsed;
	if (this.update >= 1) then
		this.update = this.update - 1;
		if (DebuffFilter.friendly_name ~= UnitName(DebuffFilter_Targets["friendly"])) then
			DebuffFilter_FDebuffFrame_Update(DebuffFilter_Targets["friendly"]);
		else
			local debufftexture, debuffapplications, _ = UnitDebuff(DebuffFilter_Targets["friendly"], this:GetID());
			local debufftext = getglobal(this:GetName() .. "Count");

			if (debufftexture) then
				if (debuffapplications > 1) then
					debufftext:SetText(debuffapplications);
				else
					debufftext:SetText("");
				end
			else
				DebuffFilter_FDebuffFrame_Update(DebuffFilter_Targets["friendly"]);
			end
		end
	end
end

function DebuffFilter_FBuffButton_OnUpdate(elapsed)
	this.update = this.update + elapsed;
	if (this.update >= 1) then
		this.update = this.update - 1;
		if (DebuffFilter.friendly_name ~= UnitName(DebuffFilter_Targets["friendly"])) then
			DebuffFilter_FBuffFrame_Update(DebuffFilter_Targets["friendly"]);
		else
			local bufftexture, buffapplications = UnitBuff(DebuffFilter_Targets["friendly"], this:GetID());
			local bufftext = getglobal(this:GetName() .. "Count");

			if (bufftexture) then
				if (buffapplications > 1) then
					bufftext:SetText(buffapplications);
				else
					bufftext:SetText("");
				end
			else
				DebuffFilter_FBuffFrame_Update(DebuffFilter_Targets["friendly"]);
			end
		end
	end
end

-- taken from ctmod
function DebuffFilter_GetStrTime(time)
	local min, sec;
	if ( time >= 60 ) then
		min = floor(time/60);
		sec = time - min*60;
	else
		sec = time;
		min = 0;
	end
	if ( sec <= 9 ) then sec = "0" .. sec; end
	if ( min <= 9 ) then min = "0" .. min; end
	return min .. ":" .. sec;
end

function DebuffFilter_FrameOrientation(orientation, frame)
	local name, start, num, relnum, xtemp, ytemp, countframe, point, relpoint, x, y;

	for i in DebuffFilter.Frames do
		if (DebuffFilter.Frames[i]["frame"] == frame) then
			name = DebuffFilter.Frames[i]["button"];
			start = getglobal(name .. DebuffFilter.Frames[i]["start"]);
			num = DebuffFilter.Frames[i]["num"];
			relnum = DebuffFilter.Frames[i]["relnum"];
			xtemp = DebuffFilter.Frames[i]["x"];
			ytemp = DebuffFilter.Frames[i]["y"];

			break;
		end
	end

	countframe = getglobal(frame .. "Count");

	start:ClearAllPoints();
	countframe:ClearAllPoints();

	for i in DebuffFilter.FrameOrientation do
		if (i == orientation) then
			point, relpoint = DebuffFilter.FrameOrientation[i]["point"], DebuffFilter.FrameOrientation[i]["relpoint"];
			x, y = xtemp * DebuffFilter.FrameOrientation[i]["x"], ytemp * DebuffFilter.FrameOrientation[i]["y"];
			start:SetPoint(DebuffFilter.FrameOrientation[i]["point"], frame, DebuffFilter.FrameOrientation[i]["point"], 0, 0);
			countframe:SetPoint(relpoint, frame, point, 0, DebuffFilter.FrameOrientation[i]["count_y"]);

			break;
		end
	end

	for i = 2, 16, 1 do
		local button, relbutton;

		button = getglobal(name .. i-num);
		relbutton = name .. (i-relnum);
		
		button:ClearAllPoints();
		button:SetPoint(point, relbutton, relpoint, x, y);
	end
end

function DebuffFilter_TimeOrientation(orientation)
	for i = 0, 15, 1 do
		local name = "DebuffFilter_BuffButton" .. i;
		local bufftime = getglobal(name .. "Duration");

		bufftime:ClearAllPoints();

		if (orientation == "bottom") then
			bufftime:SetPoint("TOP", name, "BOTTOM", 0, 0);
		elseif (orientation == "top") then
			bufftime:SetPoint("BOTTOM", name, "TOP", 0, 2);
		elseif (orientation == "left") then
			bufftime:SetPoint("RIGHT", name, "LEFT", -4, 0);
		elseif (orientation == "right") then
			bufftime:SetPoint("LEFT", name, "RIGHT", 4, 0);
		end
	end
end

function DebuffFilter_Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Debuff Filter|r: " .. msg);
end

function DebuffFilter_command(arg1)
	local i, j, cmd, param = string.find(arg1, "^([^ ]+) (.+)$");
	if (not cmd) then
		cmd = arg1;
	end

	cmd = string.lower(cmd);

	if (cmd == "debuffs") or (cmd == "buffs") or (cmd == "fdebuffs") or (cmd == "fbuffs") then
		if (DebuffFilter_Config[DebuffFilter_Player][cmd] == "yes") then
			DebuffFilter_Config[DebuffFilter_Player][cmd] = "no";
			getglobal(DebuffFilter.Frames[cmd]["frame"]):Hide();
			DebuffFilter_Print(DebuffFilter.Frames[cmd]["name"] .. " filtering disabled.");
		else
			DebuffFilter_Config[DebuffFilter_Player][cmd] = "yes";
			getglobal(DebuffFilter.Frames[cmd]["frame"] .. "_Update")(DebuffFilter_Targets[DebuffFilter.Frames[cmd]["target"]]);
			DebuffFilter_DebuffFrame_Update(DebuffFilter_Targets["hostile"]);
			getglobal(DebuffFilter.Frames[cmd]["frame"]):Show();
			DebuffFilter_Print(DebuffFilter.Frames[cmd]["name"] .. " filtering enabled.");
		end
	elseif (cmd == "scale") then
		if tonumber(param) and (tonumber(param) >= 0.5) and (tonumber(param) <=3.0) then
			DebuffFilter_Config[DebuffFilter_Player]["scale"] = tonumber(param);
			DebuffFilterFrame:SetScale(DebuffFilter_Config[DebuffFilter_Player]["scale"] * UIParent:GetScale());
			DebuffFilter_DebuffFrame:ClearAllPoints();
			DebuffFilter_DebuffFrame:SetPoint("CENTER", "UIParent", "CENTER", -40, 0);
			DebuffFilter_BuffFrame:ClearAllPoints();
			DebuffFilter_BuffFrame:SetPoint("LEFT", "DebuffFilter_DebuffFrame", "RIGHT", 40, 0);
			DebuffFilter_FDebuffFrame:ClearAllPoints();
			DebuffFilter_FDebuffFrame:SetPoint("TOP", "DebuffFilter_DebuffFrame", "BOTTOM", 0, -30);
			DebuffFilter_FBuffFrame:ClearAllPoints();
			DebuffFilter_FBuffFrame:SetPoint("TOP", "DebuffFilter_BuffFrame", "BOTTOM", 0, -30);
			DebuffFilter_Print("scale set to " .. DebuffFilter_Config[DebuffFilter_Player]["scale"] .. ".");
		else
			DebuffFilter_Print("please choose a number between 0.5 and 3.  Current scale: " .. DebuffFilter_Config[DebuffFilter_Player]["scale"] .. ".");
		end
	elseif (cmd == "backdrop") then
		if (DebuffFilter.backdrop == 1) then
			DebuffFilter.backdrop = 0;
			for i in DebuffFilter.Frames do
				getglobal(DebuffFilter.Frames[i]["frame"] .. "Backdrop"):Hide();
			end
			DebuffFilter_Print("now hiding backdrop.");
		else
			DebuffFilter.backdrop = 1;
			for i in DebuffFilter.Frames do
				getglobal(DebuffFilter.Frames[i]["frame"] .. "Backdrop"):Show();
			end
			DebuffFilter_Print("now showing backdrop.");
		end
	elseif (cmd == "allfd") or (cmd == "allfb") then
		for i in DebuffFilter.Frames do
			if (DebuffFilter.Frames[i]["all_cmd"] == cmd) then
				local all_key = "all_" .. i;

				if (DebuffFilter_Config[DebuffFilter_Player][all_key] == "yes") then
					DebuffFilter_Config[DebuffFilter_Player][all_key] = "no";
					getglobal(DebuffFilter.Frames[i]["frame"] .. "_Update")(DebuffFilter_Targets[DebuffFilter.Frames[i]["target"]]);
					DebuffFilter_Print("display all " .. DebuffFilter.Frames[i]["name"] .. "s disabled.");
				else
					DebuffFilter_Config[DebuffFilter_Player][all_key] = "yes";
					getglobal(DebuffFilter.Frames[i]["frame"] .. "_Update")(DebuffFilter_Targets[DebuffFilter.Frames[i]["target"]]);
					DebuffFilter_Print("display all " .. DebuffFilter.Frames[i]["name"] .. "s enabled.");
				end

				break;
			end
		end
	elseif (cmd == "count") then
		if (DebuffFilter_Config[DebuffFilter_Player]["count"] == "yes") then
			DebuffFilter_Config[DebuffFilter_Player]["count"] = "no";
			for i in DebuffFilter.Frames do
				getglobal(DebuffFilter.Frames[i]["frame"] .. "Count"):Hide();
			end
			DebuffFilter_Print("no longer showing debuff/buff count.");
		else
			DebuffFilter_Config[DebuffFilter_Player]["count"] = "yes";
			DebuffFilter_Print("now showing debuff/buff count.");
		end
	elseif (cmd == "tooltips") then
		if (DebuffFilter_Config[DebuffFilter_Player]["tooltips"] == "yes") then
			DebuffFilter_Config[DebuffFilter_Player]["tooltips"] = "no";
			DebuffFilter_Print("tooltips disabled.");
		else
			DebuffFilter_Config[DebuffFilter_Player]["tooltips"] = "yes";
			DebuffFilter_Print("tooltips enabled.");
		end
	elseif ((cmd == "add") or (cmd == "addb") or (cmd == "addfd") or (cmd == "addfb")) and param then
		for i in DebuffFilter.Frames do
			if (DebuffFilter.Frames[i]["add_cmd"] == cmd) then
				DebuffFilter_Config[DebuffFilter_Player][DebuffFilter.Frames[i]["list"]][param] = 1;
				getglobal(DebuffFilter.Frames[i]["frame"] .. "_Update")(DebuffFilter_Targets[DebuffFilter.Frames[i]["target"]]);
				DebuffFilter_Print("Now monitoring for " .. DebuffFilter.Frames[i]["name"] .. ": \"|cff00ccff" .. param .. "|r\"");

				break;
			end
		end
	elseif ((cmd == "del") or (cmd == "delb") or (cmd == "delfd") or (cmd == "delfb")) and param then
		for i in DebuffFilter.Frames do
			if (DebuffFilter.Frames[i]["del_cmd"] == cmd) then
				if (DebuffFilter_Config[DebuffFilter_Player][DebuffFilter.Frames[i]["list"]][param]) then
					DebuffFilter_Config[DebuffFilter_Player][DebuffFilter.Frames[i]["list"]][param] = nil;
					getglobal(DebuffFilter.Frames[i]["frame"] .. "_Update")(DebuffFilter_Targets[DebuffFilter.Frames[i]["target"]]);
					DebuffFilter_Print("No longer monitoring for " .. DebuffFilter.Frames[i]["name"] .. ": \"|cff00ccff" .. param .. "|r\"");
				else
					DebuffFilter_Print("unable to find " .. DebuffFilter.Frames[i]["name"] .. ": \"|cff00ccff" .. param .. "|r\"");
				end

				break;
			end
		end
	elseif (cmd == "list") or (cmd == "listb") or (cmd == "listfd") or (cmd == "listfb") then
		for i in DebuffFilter.Frames do
			if (DebuffFilter.Frames[i]["list_cmd"] == cmd) then
				DebuffFilter_Print("currently monitored " .. DebuffFilter.Frames[i]["name"] .. "s:");
				for ii in DebuffFilter_Config[DebuffFilter_Player][DebuffFilter.Frames[i]["list"]] do
					DEFAULT_CHAT_FRAME:AddMessage("\"|cff00ccff" .. ii .. "|r\"");
				end

				break;
			end
		end
	elseif (cmd == "status") then
		DebuffFilter_Print("current settings:");
		DebuffFilter_Print("current scale: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["scale"] .. "|r");
		DebuffFilter_Print("current hostile target debuff orientation: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["debuff_orientation"] .. "|r");
		DebuffFilter_Print("current player buff orientation: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["buff_orientation"] .. "|r");
		DebuffFilter_Print("current friendly target debuff orientation: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["fdebuff_orientation"] .. "|r");
		DebuffFilter_Print("current friendly target buff orientation: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["fbuff_orientation"] .. "|r");
		DebuffFilter_Print("current time orientation: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["time_orientation"] .. "|r");
		DebuffFilter_Print("show all friendly target debuffs: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["all_fdebuffs"] .. "|r");
		DebuffFilter_Print("show all friendly target buffs: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["all_fbuffs"] .. "|r");
		DebuffFilter_Print("show debuff/buff count: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["count"] .. "|r");
		DebuffFilter_Print("show tooltips: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["tooltips"] .. "|r");
		DebuffFilter_Print("hostile target debuff filtering: " .. DebuffFilter_Config[DebuffFilter_Player]["debuffs"] .. "|r");
		DebuffFilter_Print("player buff filtering: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["buffs"] .. "|r");
		DebuffFilter_Print("friendly target debuff filtering: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["fdebuffs"] .. "|r");
		DebuffFilter_Print("friendly target buff filtering: |cff00ccff" .. DebuffFilter_Config[DebuffFilter_Player]["fbuffs"] .. "|r");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Debuff Filter commands:");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffdebuffs|r || |cff00ccffbuffs|r || |cff00ccfffdebuffs|r || |cff00ccfffbuffs|r: toggle debuff or buff filtering on and off.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffscale [0.5-3.0]|r: scale the size of the debuff and buff icons.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffbackdrop|r: toggle a backdrop to assist in moving the debuff/buff frames.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffallfd|r || |cff00ccffallfb|r: display all friendly target debuffs or buffs.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffcount|r: toggle a total debuff/buff count display.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccfftooltips|r: toggle tooltips on and off.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffstatus|r: display current settings.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter <|cff00ccffadd|r || |cff00ccffaddb|r || |cff00ccffaddfd|r || |cff00ccffaddfb|r> |cff00ccff[|cff00ff00debuff|cff00ccff|||cff00ff00buff|cff00ccff]|r: add a debuff or buff to monitor.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter <|cff00ccffdel|r || |cff00ccffdelb|r || |cff00ccffdelfd|r || |cff00ccffdelfb|r> |cff00ccff[|cff00ff00debuff|cff00ccff|||cff00ff00buff|cff00ccff]|r: remove a monitored debuff or buff.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccfflist|r || |cff00ccfflistb|r || |cff00ccfflistfd|r || |cff00ccfflistfb|r: view the currently monitored debuff or buff list.");
		DEFAULT_CHAT_FRAME:AddMessage("To move the frames, shift+left click and drag a backdrop or a monitored debuff/buff.");
		DEFAULT_CHAT_FRAME:AddMessage("To change the frame or time orientation, shift+right click or ctrl+right click, respectively.");
	end
end