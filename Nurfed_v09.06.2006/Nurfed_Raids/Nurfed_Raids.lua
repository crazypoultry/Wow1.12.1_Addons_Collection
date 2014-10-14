
NURFED_RAIDS_DEFAULT = {
	frames = {},
	permissions = {},
	updaterate = 0.25,
	showrank = 1,
	showauras = 1,
	auracolumns = 1,
	auralimit = 20,
	aurafilter = 0,
	aurarange = 1,
};

BINDING_HEADER_NURFEDRAIDSHEADER = "Nurfed Raids";
BINDING_NAME_NURFED_RAIDSQUEUE = "Process Aura Queue";

NRF_REMOVELESSERCURSE = "Remove Lesser Curse";
NRF_ABOLISHPOISON = "Abolish Poison";
NRF_REMOVECURSE = "Remove Curse";
NRF_DISPELMAGIC = "Dispel Magic";
NRF_CUREDISEASE = "Cure Disease";
NRF_CUREPOISON = "Cure Poison";
NRF_CLEANSE = "Cleanse";
NRF_DEVOURMAGIC = "Devour Magic";

if ( GetLocale() == "deDE" ) then
	NRF_REMOVELESSERCURSE = "Geringen Fluch aufheben";
	NRF_ABOLISHPOISON = "Vergiftung aufheben";
	NRF_REMOVECURSE = "Fluch aufheben";
	NRF_DISPELMAGIC = "Magiebannung";
	NRF_CUREDISEASE = "Krankheit heilen";
	NRF_CUREPOISON = "Vergiftung heilen";
	NRF_CLEANSE = "Reinigung des Glaubens";
	NRF_DEVOURMAGIC = "Devour Magic";
elseif ( GetLocale() == "frFR" ) then
	NRF_REMOVELESSERCURSE = "D\195\169livrance de la mal\195\169diction mineure";
	NRF_ABOLISHPOISON = "Abolir le poison";
	NRF_REMOVECURSE = "D\195\169livrance de la mal\195\169diction";
	NRF_DISPELMAGIC = "Dissiper la magie";
	NRF_CUREDISEASE = "Gu\195\169rison des maladies";
	NRF_CUREPOISON = "Gu\195\169rison du poison";
	NRF_CLEANSE = "Epuration";
	NRF_DEVOURMAGIC = "Devour Magic";
end

local utility = Nurfed_Utility:New();
local framelib = Nurfed_Frames:New();
local units = Nurfed_Units:New();
local raidframes = {};
local raidunits = {};
local raidauras = {};
local rate = 0.25;

local cures = {
	MAGE = {
		[NRF_REMOVELESSERCURSE] = "Curse",
	},
	DRUID = {
		[NRF_ABOLISHPOISON] = "Poison",
		[NRF_REMOVECURSE] = "Curse",
	},
	PRIEST = {
		[NRF_DISPELMAGIC] = "Magic",
		[NRF_CUREDISEASE] = "Disease",
	},
	SHAMAN = {
		[NRF_CUREPOISON] = "Poison",
		[NRF_CUREDISEASE] = "Disease",
	},
	PALADIN = {
		[NRF_CLEANSE] = { "Poison", "Disease", "Magic" },
	},
	WARLOCK = {
		[NRF_DEVOURMAGIC] = "Magic",
	},
};

function Nurfed_Raids_SetRate()
	rate = utility:GetOption("raids", "updaterate");
end

function Nurfed_Raids_CreateFrame(frame)
	local name = "Nurfed_Raids"..frame;
	frame = framelib:ObjectInit(name, "nrf_raid");
	local pos = utility:GetOption("utility", name);
	if (not pos) then
		frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	else
		frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", pos[1], pos[2]);
	end
	frame:RegisterForDrag("LeftButton");
	return frame;
end

function Nurfed_Raids_GetUnusedAura()
	for _, v in ipairs(raidauras) do
		if (not v.u) then
			v.u = true;
			v.b:SetScript("OnEvent", function() units:OnEvent() end);
			return v.b;
		end
	end

	local total = table.getn(raidauras) + 1;
	local button = framelib:ObjectInit("Nurfed_RaidAura"..total, "nrf_raid_aura");
	table.insert(raidauras, { u = true, b = button });
	return button;
end

function Nurfed_RaidsClearAuras()
	for k, v in ipairs(raidauras) do
		v.u = false;
		local button = v.b;
		button:SetScript("OnEvent", nil);
		button:SetParent(UIParent);
		button.unit = nil;
		button:Hide();
	end
end

function Nurfed_Raids_UpdateAuras()
	Nurfed_RaidsClearAuras();
	local show = utility:GetOption("raids", "showauras");
	if (show == 1) then
		Nurfed_RaidsAuras.limit = utility:GetOption("raids", "auralimit");
		Nurfed_RaidsAuras.columns = utility:GetOption("raids", "auracolumns");
		Nurfed_RaidsAuras.init = nil;
		Nurfed_RaidsAuras.units = {};
		Nurfed_RaidsAuras.updatepop = true;
		Nurfed_RaidsAuras:RegisterEvent("PLAYER_ENTER_COMBAT");
		Nurfed_RaidsAuras:RegisterEvent("PLAYER_REGEN_DISABLED");
		Nurfed_RaidsAuras:SetScript("OnUpdate", function() Nurfed_Raids_Auras_OnUpdate(arg1) end);
		Nurfed_RaidsAuras:Show();
	else
		Nurfed_RaidsAuras:UnregisterAllEvents();
		Nurfed_RaidsAuras:SetScript("OnUpdate", nil);
		Nurfed_RaidsAuras:Hide();
	end
end

function Nurfed_Raids_InitAuras()
	local last, begin, restart;
	if (this.columns == 1) then
		this:SetWidth(110);
		getglobal(this:GetName().."bg"):SetWidth(110);
		getglobal(this:GetName().."header"):SetWidth(106);
		getglobal(this:GetName().."headerborder"):SetWidth(106);
	end
	for i = 1, this.limit do
		local unit = Nurfed_Raids_GetUnusedAura();
		unit:SetParent(this);
		unit:ClearAllPoints();
		if (i == 1) then
			unit:SetPoint("TOPLEFT", this, "BOTTOMLEFT", 2, 2);
			begin = unit;
		elseif (this.columns > 1) then
			if (math.mod(i, this.columns) ~= 0) then
				if (restart) then
					unit:SetPoint("TOPLEFT", begin, "BOTTOMLEFT", 0, 0);
					begin = unit;
					restart = nil;
				else
					unit:SetPoint("LEFT", last, "RIGHT", 0, 0);
				end
			else
				restart = true;
				unit:SetPoint("LEFT", last, "RIGHT", 0, 0);
			end
		else
			unit:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, 0);
		end
		last = unit;
	end
	this.init = true;
end

function Nurfed_Raids_Auras_OnEvent()
	if (event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED") then
		this.list = "debuff";
	end
end

function Nurfed_Raids_AurasPopulate()
	if (not this.init) then
		Nurfed_Raids_InitAuras();
	end
	this.units = {};
	for i = 1, GetNumRaidMembers() do
		local _, rank, subgroup, _, _, fileName, _, online, _ = GetRaidRosterInfo(i);
		if (online) then
			table.insert(this.units, { u = "raid"..i, c = fileName, g = subgroup, r = rank });
		end
	end
	this.updatepop = nil;
end

function Nurfed_Raids_Auras_DoSort()
	local temp = setmetatable({}, {__mode = "k"});
	local total = 0;
	local acount = 0;
	local aura, app, debufftype, border, button, color, r;
	local filter = utility:GetOption("raids", "aurafilter");
	local range = utility:GetOption("raids", "aurarange");
	for _, v in ipairs(this.units) do
		if (range == 1) then
			r = CheckInteractDistance(v.u, 4);
		else
			r = 1;
		end
		if (r) then
			aura = UnitDebuff(v.u, 1, filter);
			if (aura) then
				table.insert(temp, { u = v.u, c = v.c });
			end
		end
	end
	local i = 1;
	local total = table.getn(temp);
	if (total > this.limit) then
		total = this.limit;
	end
	local bg = getglobal(this:GetName().."bg");
	local height = math.ceil(total / this.columns);
	if (total == 0) then
		bg:Hide();
	else
		bg:Show();
		bg:SetHeight(14 * height + 6);
	end
	if (this.columns > 1) then
		if (total == 0) then
			this:SetWidth(110);
		elseif (total < this.columns) then
			this:SetWidth(106 * total + 4);
		else
			this:SetWidth(106 * this.columns + 4);
		end
		bg:SetWidth(this:GetWidth());
		getglobal(this:GetName().."header"):SetWidth(this:GetWidth() - 4);
		getglobal(this:GetName().."headerborder"):SetWidth(this:GetWidth() - 4);
	end
	local children = { this:GetChildren() };
	for _, child in ipairs(children) do
		local objtype = child:GetObjectType();
		if (objtype == "Button" and temp) then
			if (i <= total) then
				local info = temp[i];
				if (info and child.unit ~= info.u) then
					local name = UnitName(info.u);
					if (name) then
						child.unit = info.u;
						child:SetText(name);
						local color = RAID_CLASS_COLORS[info.c];
						if (color) then
							child:SetTextColor(color.r, color.g, color.b);
						end
						if (not child.init) then
							units:Imbue(child);
							local f = child:GetFontString();
							f:SetWidth(child:GetWidth());
							f:SetJustifyH("RIGHT");
							child.init = true;
						end
						units:UpdateAuras(child);
						child:Show();
					end
				end
			else
				child.unit = nil;
				child:Hide();
			end
			i = i + 1;
		end
	end
	temp = nil;
end

function Nurfed_Raids_Auras_OnUpdate(e)
	this.update = this.update + e;
	if (this.update > 0.25) then
		if (this.updatepop) then
			Nurfed_Raids_AurasPopulate();
		end
		Nurfed_Raids_Auras_DoSort();
		local title = getglobal(this:GetName().."headertitle");
		if (title) then
			title:SetText("Auras");
		end
		this.update = 0;
	end
end

function Nurfed_Raids_UpdateFrames()
	for _, v in ipairs(raidframes) do
		v:Hide();
		v:SetScript("OnUpdate", nil);
	end
	raidframes = {};
	Nurfed_Raids_ClearUnits();
	local frames = utility:GetOption("raids", "frames");
	for k, opt in pairs(frames) do
		local frame = getglobal("Nurfed_Raids"..k);
		if (not frame) then
			frame = Nurfed_Raids_CreateFrame(k);
		end
		getglobal("Nurfed_Raids"..k.."bg"):Hide();
		frame:SetWidth(110);
		frame:SetScale(opt[1]);
		frame.columns = opt[2];
		frame.xgap = opt[3];
		frame.ygap = opt[4];
		frame.MAGE = opt[5];
		frame.ROGUE = opt[6];
		frame.DRUID = opt[7];
		frame.SHAMAN = opt[8];
		frame.HUNTER = opt[9];
		frame.PRIEST = opt[10];
		frame.PALADIN = opt[11];
		frame.WARRIOR = opt[12];
		frame.WARLOCK = opt[13];
		frame.group1 = opt[14];
		frame.group2 = opt[15];
		frame.group3 = opt[16];
		frame.group4 = opt[17];
		frame.group5 = opt[18];
		frame.group6 = opt[19];
		frame.group7 = opt[20];
		frame.group8 = opt[21];
		frame.range = opt[22];
		frame.sort = opt[23];
		frame.limit = opt[24];
		frame.bars = opt[25];
		frame.title = k;
		frame.update = 0;
		frame.units = {};
		frame.init = nil;
		if (opt[26] ~= 1) then
			table.insert(raidframes, frame);
			if (GetNumRaidMembers() > 0) then
				frame.updatepop = true;
				frame:SetScript("OnUpdate", function() Nurfed_RaidFrame_OnUpdate(arg1) end);
				frame:Show();
			else
				frame:SetScript("OnUpdate", nil);
				frame:Hide();
			end
		else
			frame:SetScript("OnUpdate", nil);
			frame:Hide();
		end
	end
end

function Nurfed_Raids_GetUnused()
	for _, v in ipairs(raidunits) do
		if (not v.u) then
			v.u = true;
			v.b:SetScript("OnEvent", function() units:OnEvent() end);
			return v.b;
		end
	end

	local total = table.getn(raidunits) + 1;
	local button = framelib:ObjectInit("Nurfed_RaidUnit"..total, "nrf_raid_unit");
	table.insert(raidunits, { u = true, b = button });
	return button;
end

function Nurfed_Raids_ClearUnits()
	for k, v in ipairs(raidunits) do
		v.u = false;
		local button = v.b;
		button:SetScript("OnEvent", nil);
		button:SetParent(UIParent);
		button.unit = nil;
		button:Hide();
	end
end

function Nurfed_Raids_InitFrame()
	local last, begin, restart;
	if (this.columns == 1) then
		this:SetWidth(110);
		getglobal(this:GetName().."bg"):SetWidth(110);
		getglobal(this:GetName().."header"):SetWidth(106);
		getglobal(this:GetName().."headerborder"):SetWidth(106);
	end
	for i = 1, this.limit do
		local unit = Nurfed_Raids_GetUnused();
		local hp = getglobal(unit:GetName().."hp");
		local mp = getglobal(unit:GetName().."mp");
		local height = unit:GetHeight();
		if (this.bars == 1) then
			unit.nohp = nil;
			unit.nomp = true;
			hp:SetHeight(height);
		elseif (this.bars == 2) then
			unit.nohp = true;
			unit.nomp = nil;
			mp:SetHeight(height);
		else
			unit.nohp = nil;
			unit.nomp = nil;
			mp:SetHeight(height/2);
			hp:SetHeight(height/2);
		end
		unit:SetParent(this);
		unit:ClearAllPoints();
		if (i == 1) then
			unit:SetPoint("TOPLEFT", this, "BOTTOMLEFT", 2, 2);
			begin = unit;
		elseif (this.columns > 1) then
			if (math.mod(i, this.columns) ~= 0) then
				if (restart) then
					unit:SetPoint("TOPLEFT", begin, "BOTTOMLEFT", 0, -this.ygap);
					begin = unit;
					restart = nil;
				else
					unit:SetPoint("LEFT", last, "RIGHT", this.xgap, 0);
				end
			else
				restart = true;
				unit:SetPoint("LEFT", last, "RIGHT", this.xgap, 0);
			end
		else
			unit:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -this.ygap);
		end
		last = unit;
	end
	this.init = true;
end

function Nurfed_Raids_Populate()
	if (not this.init) then
		Nurfed_Raids_InitFrame();
	end
	this.units = {};
	for i = 1, GetNumRaidMembers() do
		local _, rank, subgroup, _, _, fileName, _, online, _ = GetRaidRosterInfo(i);
		if (online) then
			if (this["group"..subgroup] == 1 and this[fileName] == 1) then
				table.insert(this.units, { u = "raid"..i, c = fileName, g = subgroup, r = rank });
			end
		end
	end
	this.updatepop = nil;
end

function Nurfed_RaidFrame_DoSort()
	local temp = setmetatable({}, {__mode = "k"});
	local function getrange(unit)
		if (this.range == 1) then
			return CheckInteractDistance(unit, 3);
		elseif (this.range == 2) then
			return CheckInteractDistance(unit, 4);
		elseif (this.range == 3) then
			return UnitIsVisible(unit);
		elseif (this.range == 4) then
			return 1;
		end
	end
	for _, v in ipairs(this.units) do
		local r, s;
		if (this.sort == 1) then
			r = getrange(v.u);
			if (UnitIsDeadOrGhost(v.u)) then
				s = 2;
			else
				s = UnitHealth(v.u) / UnitHealthMax(v.u);
			end
			if (r and s) then
				table.insert(temp, { u = v.u, s = s, c = v.c, r = v.r });
			end
		elseif (this.sort == 2) then
			r = getrange(v.u);
			if (UnitIsDeadOrGhost(v.u)) then
				s = 2;
			else
				s = UnitMana(v.u) / UnitManaMax(v.u);
			end
			if (r and s) then
				table.insert(temp, { u = v.u, s = s, c = v.c, r = v.r });
			end
		elseif (this.sort == 3) then
			r = getrange(v.u);
			s = UnitName(v.u);
			if (r and s) then
				table.insert(temp, { u = v.u, s = s, c = v.c, r = v.r });
			end
		elseif (this.sort == 4) then
			local r = getrange(v.u);
			s = UnitClass(v.u);
			if (r and s) then
				table.insert(temp, { u = v.u, s = s, c = v.c, r = v.r });
			end
		elseif (this.sort == 5) then
			local r = getrange(v.u);
			if (r) then
				table.insert(temp, { u = v.u, s = v.g, c = v.c, r = v.r });
			end
		end
	end
	table.sort(temp, function(x, y) return x.s < y.s end);
	local i = 1;
	local total = table.getn(temp);
	if (total > this.limit) then
		total = this.limit;
	end
	local bg = getglobal(this:GetName().."bg");
	local height = math.ceil(total / this.columns);
	local gap = (height - 1) * this.ygap;
	if (total == 0) then
		bg:Hide();
	else
		bg:Show();
		bg:SetHeight(14 * height + gap + 6);
	end
	if (this.columns > 1) then
		if (total < this.columns) then
			gap = (total - 1) * this.xgap;
			this:SetWidth(106 * total + gap + 4);
		else
			gap = (this.columns - 1) * this.xgap;
			this:SetWidth(106 * this.columns + gap + 4);
		end
		bg:SetWidth(this:GetWidth());
		getglobal(this:GetName().."header"):SetWidth(this:GetWidth() - 4);
		getglobal(this:GetName().."headerborder"):SetWidth(this:GetWidth() - 4);
	end
	local children = { this:GetChildren() };
	for _, child in ipairs(children) do
		local objtype = child:GetObjectType();
		if (objtype == "Button" and temp) then
			if (i <= total) then
				local info = temp[i];
				if (info and (child.unit ~= info.u or child.rank ~= info.r)) then
					local name = UnitName(info.u);
					if (name) then
						child.unit = info.u;
						child.name = name;
						child.rank = info.r;
						child.id = string.gsub(info.u, "raid", "");
						local showrank = utility:GetOption("raids", "showrank");
						if (showrank == 1) then
							if (info.r == 1) then
								name = "|cffffff00"..RAID_ASSISTANT_TOKEN.."|r "..name;
							elseif (info.r == 2) then
								name = "|cffffff00"..RAID_LEADER_TOKEN.."|r "..name;
							end
						end
						local color = RAID_CLASS_COLORS[info.c];
						child:SetText(name);
						if (color) then
							child:SetTextColor(color.r, color.g, color.b);
						end
						if (not child.init) then
							units:Imbue(child);
							local f = child:GetFontString();
							f:SetWidth(child:GetWidth());
							f:SetJustifyH("LEFT");
							child.init = true;
						end
						units:UpdateInfo("hp", child);
						units:UpdateInfo("mp", child);
						child:Show();
					end
				end
			else
				child.unit = nil;
				child.name = nil;
				child.id = nil;
				child:Hide();
			end
			i = i + 1;
		end
	end
	temp = nil;
	return total;
end

function Nurfed_RaidFrame_OnUpdate(e)
	this.update = this.update + e;
	if (this.update > rate) then
		if (this.updatepop) then
			Nurfed_Raids_Populate();
		end
		local count = Nurfed_RaidFrame_DoSort();
		local title = getglobal(this:GetName().."headertitle");
		if (title) then
			title:SetText(this.title.." ["..count.."]");
		end
		this.update = 0;
	end
end

function Nurfed_Raids_OnUpdate()
	if (this.update and this.update <= GetTime()) then
		for _, frame in ipairs(raidframes) do
			frame.updatepop = true;
			if (not frame:IsShown() and GetNumRaidMembers() > 0) then
				frame:Show();
				frame:SetScript("OnUpdate", function() Nurfed_RaidFrame_OnUpdate(arg1) end);
			end
		end
		Nurfed_RaidsAuras.updatepop = true;
		this:SetScript("OnUpdate", nil);
		this.update = nil;
	end
end

function Nurfed_Raids_UpdateSpells()
	local class, eclass = UnitClass("player");
	if (cures[eclass]) then
		local i = 1;
		local book = "spell";
		if (eclass == "WARLOCK") then
			book = "pet";
		end
		local spellName, spellRank = GetSpellName(i, book);
		while spellName do
			if (cures[eclass][spellName]) then
				local dtype = cures[eclass][spellName];
				if (type(dtype) == "string") then
					units.cure[dtype][eclass] = i;
				else
					for _, v in ipairs(dtype) do
						units.cure[v][eclass] = i;
					end
				end
			end
			i = i + 1;
			spellName, spellRank = GetSpellName(i, book);
		end
	end
end

function Nurfed_Raids_OnEvent()
	if (event == "RAID_ROSTER_UPDATE") then
		if (GetNumRaidMembers() > 0) then
			this.update = GetTime() + 0.25;
			this:SetScript("OnUpdate", Nurfed_Raids_OnUpdate);
		else
			for _, frame in ipairs(raidframes) do
				frame:SetScript("OnUpdate", nil);
				frame:Hide();
			end
		end
	elseif (IsRaidLeader()) then
		local opt;
		if (arg2 == UnitName("player")) then
			opt = { 1, 1, 1, 1 };
		else
			local perms = utility:GetOption("raids", "permissions");
			opt = perms[arg2];
		end
		if (opt) then
			if (string.find(arg1, "^!swap") and opt[3] == 1) then
				local msg = string.gsub(arg1, "!swap ", "");
				msg = utility:UpperCase(msg);
				local names = {};
				for w in string.gfind(msg, "%w+") do
					table.insert(names, w);
				end
				if (table.getn(names) > 1) then
					local i = 1;
					local idx1, idx2;
					for k, v in ipairs(names) do
						if (math.mod(k, 2) ~= 0) then
							idx1 = units:GetUnit(v);
						else
							if (idx1) then
								local id, found = gsub(v, "([1-8])", "%1");
								if (found == 1) then
									SetRaidSubgroup(idx1.id, id);
								else
									idx2 = units:GetUnit(v);
									if (idx2) then
										SwapRaidSubgroup(idx1.id, idx2.id);
									end
								end
							end
							idx1 = nil;
							idx2 = nil;
						end
					end
				end
			elseif (string.find(arg1, "^!admin") and opt[2] == 1) then
				PromoteToAssistant(arg2);
			elseif (string.find(arg1, "^!lead") and opt[1] == 1) then
				PromoteByName(arg2);
			elseif (string.find(arg1, "^!ready") and opt[4] == 1) then
				DoReadyCheck();
			end
		end
	end
end

function Nurfed_Raids_OnDragStart()
	if (NRF_LOCKED ~= 1) then
		CloseDropDownMenus();
		this:StartMoving();
	end
end

function Nurfed_Raids_OnDragStop()
	this:StopMovingOrSizing();
	utility:SetPos(this);
end

function Nurfed_Raids_AuraOnClick(frame)
	if (frame) then
		this = frame;
	end
	if (this.cure) then
		local _, eclass = UnitClass("player");
		local book = "spell";
		if (eclass == "WARLOCK") then
			book = "pet";
		end
		local start, duration = GetSpellCooldown(this.cure, book);
		if (start > 0) then
			return true;
		else
			local change;
			SpellStopCasting();
			if (UnitName("target") ~= UnitName(this.unit)) then
				TargetUnit(this.unit);
				change = true;
			end

			CastSpell(this.cure, book);
			if (change) then
				TargetLastTarget();
			end
			return true;
		end
	end
end

function Nurfed_Raids_ProcessAuras()
	local children = { Nurfed_RaidsAuras:GetChildren() };
	for _, child in ipairs(children) do
		local objtype = child:GetObjectType();
		if (objtype == "Button" and child:IsShown() and child.cure) then
			local r = CheckInteractDistance(child.unit, 4);
			if (r) then
				local cured = Nurfed_Raids_AuraOnClick(child);
				if (cured) then
					return;
				end
			end
		end
	end
end

local templates = {
	nrf_raid = {
		type = "Frame",
		FrameStrata = "LOW",
		ClampedToScreen = true,
		size = { 110, 17 },
		Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 3, right = 3, top = 3, bottom = 3 }, },
		BackdropColor = { 0, 0, 0, 0.75 },
		Movable = true,
		Mouse = true,
		children = {
			header = {
				type = "Frame",
				size = { 106, 12 },
				Anchor = { "TOP", "$parent", "TOP", 0, -2 },
				children = {
					bg = {
						type = "Texture",
						layer = "BACKGROUND",
						Anchor = "all",
						Texture = NRF_IMG.."statusbar8",
						Gradient = { "HORIZONTAL", 0, 0.75, 1, 0, 0, 0.2 },
					},
					title = {
						type = "FontString",
						layer = "ARTWORK",
						Anchor = "all",
						Font = { NRF_FONT.."framd.ttf", 10, "OUTLINE" },
						JustifyH = "CENTER",
						TextColor = { 1, 1, 1 },
					},
					border = {
						type = "Texture",
						size = { 106, 3 },
						layer = "OVERLAY",
						Anchor = { "TOP", "$parent", "BOTTOM", 0, 1 },
						Texture = "Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar",
						TexCoord = { 0.2, 1, 0, 0.25 },
					},
				},
			},
			bg = {
				type = "Frame",
				FrameStrata = "BACKGROUND",
				size = { 110, 17 },
				Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, 5 },
				Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 3, right = 3, top = 3, bottom = 3 }, },
				BackdropColor = { 0, 0, 0, 0.75 },
			},
		},
		OnDragStart = function() Nurfed_Raids_OnDragStart() end,
		OnDragStop = function() Nurfed_Raids_OnDragStop() end,
		Hide = true,
	},

	nrf_raid_unit = {
		type = "Button",
		size = { 106, 14 },
		Font = { NRF_FONT.."framd.ttf", 10, "OUTLINE" },
		children = {
			hpperc = {
				type = "FontString",
				layer = "OVERLAY",
				Font = { NRF_FONT.."framd.ttf", 9, "OUTLINE" },
				JustifyH = "RIGHT",
				Anchor = "all",
				TextColor = { 1, 0.25, 0 },
				vars = { format = "$perc" },
			},
			hp = {
				type = "StatusBar",
				size = { 105, 14 },
				FrameStrata = "LOW",
				Orientation = "HORIZONTAL",
				StatusBarTexture = NRF_IMG.."statusbar6",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
				StatusBarColor = { 0, 1, 0 },
			},
			mp = {
				type = "StatusBar",
				size = { 105, 14 },
				FrameStrata = "LOW",
				Orientation = "HORIZONTAL",
				StatusBarTexture = NRF_IMG.."statusbar6",
				Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 0, 0 },
				StatusBarColor = { 0, 1, 1 },
			},
			HighlightTexture = {
				type = "Texture",
				layer = "BACKGROUND",
				Texture = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
				BlendMode = "ADD",
				Anchor = "all",
			},
		},
		Hide = true,
	},

	nrf_raid_aura = {
		type = "Button",
		size = { 106, 14 },
		Font = { NRF_FONT.."framd.ttf", 10, "OUTLINE" },
		children = {
			debuff1 = {
				type = "Button",
				FrameLevel = 3,
				size = { 14, 14 },
				uitemp = "TargetDebuffButtonTemplate",
				Anchor = { "LEFT", "$parent", "LEFT", 0, 0 },
				OnClick = function() Nurfed_Raids_AuraOnClick(this:GetParent()) end,
			},
			debuff2 = {
				type = "Button",
				FrameLevel = 3,
				size = { 14, 14 },
				uitemp = "TargetDebuffButtonTemplate",
				Anchor = { "LEFT", "$parentdebuff1", "RIGHT", 0, 0 },
				OnClick = function() Nurfed_Raids_AuraOnClick(this:GetParent()) end,
			},
			debuff3 = {
				type = "Button",
				FrameLevel = 3,
				size = { 14, 14 },
				uitemp = "TargetDebuffButtonTemplate",
				Anchor = { "LEFT", "$parentdebuff2", "RIGHT", 0, 0 },
				OnClick = function() Nurfed_Raids_AuraOnClick(this:GetParent()) end,
			},
			debuff4 = {
				type = "Button",
				FrameLevel = 3,
				size = { 14, 14 },
				uitemp = "TargetDebuffButtonTemplate",
				Anchor = { "LEFT", "$parentdebuff3", "RIGHT", 0, 0 },
				OnClick = function() Nurfed_Raids_AuraOnClick(this:GetParent()) end,
			},
			HighlightTexture = {
				type = "Texture",
				layer = "BACKGROUND",
				Texture = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
				BlendMode = "ADD",
				Anchor = "all",
			},
		},
		OnClick = function() Nurfed_Raids_AuraOnClick() end,
		Hide = true,
	},
};

function Nurfed_Raids_Init()
	for k, v in pairs(templates) do
		framelib:CreateTemplate(k, v);
	end
	local tbl = {
		type = "Frame",
		events = {
			"RAID_ROSTER_UPDATE",
			"CHAT_MSG_RAID",
			"CHAT_MSG_PARTY",
			"CHAT_MSG_WHISPER",
			"CHAT_MSG_OFFICER",
			"CHAT_MSG_RAID_LEADER",
		},
		OnEvent = function() Nurfed_Raids_OnEvent() end,
	};

	framelib:ObjectInit("Nurfed_RaidsFrame", tbl);
	tbl = nil;
	local frame = Nurfed_Raids_CreateFrame("Auras");
	frame.update = 0;
	frame.list = "debuff";
	Nurfed_Raids_SetRate();
	Nurfed_Raids_UpdateAuras();
	Nurfed_Raids_UpdateFrames();
	Nurfed_Raids_UpdateSpells();
end