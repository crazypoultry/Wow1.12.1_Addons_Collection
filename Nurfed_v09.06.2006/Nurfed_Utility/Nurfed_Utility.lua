
-- Globals
NRF_LOCKED = 1;
NRF_IMG = "Interface\\AddOns\\Nurfed_Utility\\Images\\";
NRF_FONT = "Interface\\AddOns\\Nurfed_Utility\\Fonts\\";

local framelib = Nurfed_Frames:New();

if (not Nurfed_Utility) then
	Nurfed_Utility = {};
	Nurfed_Utility.hooks = {};

	local tbl = {
		type = "GameTooltip",
		uitemp = "GameTooltipTemplate",
		FrameStrata = "TOOLTIP",
		Hide = true,
	};
	framelib:ObjectInit("Nurfed_UnitsTooltip", tbl);
	Nurfed_UnitsTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	tbl = nil;
end

function Nurfed_Utility:New()
	local object = {};
	setmetatable(object, self);
	self.__index = self;
	return object;
end

-- Table Functions
function Nurfed_Utility:TableCopy(t)
	local new = {};
	local i, v = next(t, nil);
	while i do
		if type(v) == "table" then
			v = self:TableCopy(v);
		end
		new[i] = v;
		i, v = next(t, i);
	end
	return new;
end

function Nurfed_Utility:GetTableIndex(t, text)
	for i = 1, table.getn(t) do
		if (t[i].text == text) then
			return i;
		end
	end
	return nil;
end

-- Formatting Functions
function Nurfed_Utility:FormatGS(globalString, anchor)
	globalString = string.gsub(globalString,"([%^%(%)%.%[%]%*%+%-%?])","%%%1");
	globalString = string.gsub(globalString,"%%s","(.+)");
	globalString = string.gsub(globalString,"%%d","(%-?%%d+)");
	if (anchor) then
		return "^"..globalString;
	end
	return globalString;
end

function Nurfed_Utility:FormatBinding(text)
	text = string.gsub(text, "CTRL%-", "C-");
	text = string.gsub(text, "ALT%-", "A-");
	text = string.gsub(text, "SHIFT%-", "S-");
	text = string.gsub(text, "Num Pad", "NP");
	text = string.gsub(text, "Backspace", "Bksp");
	text = string.gsub(text, "Spacebar", "Space");
	text = string.gsub(text, "Page", "Pg");
	text = string.gsub(text, "Down", "Dn");
	text = string.gsub(text, "Arrow", "");
	text = string.gsub(text, "Insert", "Ins");
	text = string.gsub(text, "Delete", "Del");
	return text;
end

function Nurfed_Utility:UpperCase(text)
	local function up(first, rest)
		return string.upper(first)..string.lower(rest);
	end
	text = string.gsub(string.lower(text), "(%l)([%w_']*)", up);
	return text;
end

-- Options Functions
function Nurfed_Utility:GetOption(addon, option)
	if (not addon) then
		return;
	end
	addon = string.upper("NURFED_"..addon);
	if (not getglobal(addon.."_SAVED")) then
		return;
	end
	local tbl = getglobal(addon.."_SAVED");
	if (not tbl[option]) then
		local value = getglobal(addon.."_DEFAULT")[option];
		if (value) then
			tbl[option] = value;
		else
			return nil;
		end
	end
	return tbl[option];
end

function Nurfed_Utility:SetOption(addon, option, value, id, name, idupdate)
	addon = string.upper("NURFED_"..addon);
	local tbl = getglobal(addon.."_SAVED");
	if (id and name) then
		tbl[option][name][id] = value;
	elseif (id) then
		if (type(id) == "number" and not idupdate) then
			if (not value) then
				table.remove(tbl[option], id);
			else
				table.insert(tbl[option], value);
			end
		else
			tbl[option][id] = value;
		end
	else
		tbl[option] = value;
	end
end

function Nurfed_Utility:SetPos(frame)
	local x, y = frame:GetCenter();
	self:SetOption("utility", frame:GetName(), { x, y });
end

function Nurfed_Utility:SetMultiOption(addon, option, name, value)
	addon = string.upper("NURFED_"..addon);
	local tbl = getglobal(addon.."_SAVED")[option];
	tbl[name] = value;
end

function Nurfed_Utility:Print(msg, out, r, g, b, a)
	if (not msg) then	return;		end
	if (not out) then	out = 1;	end
	if (not r) then		r = 1.0;	end
	if (not g) then		g = 1.0;	end
	if (not b) then		b = 1.0;	end
	if (not a) then		a = 1.0;	end

	if (type(out) ~= "number") then
		UIErrorsFrame:AddMessage(msg, r, g, b, a, UIERRORS_HOLD_TIME);
	else
		local frame = getglobal("ChatFrame"..out);
		if (frame) then
			frame:AddMessage(msg, r, g, b);
		else
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
		end
	end
end

-- Respect to GypsyMod for the Hook Code
function Nurfed_Utility:Hook (mode, original, new)
	if (not self.hooks[original]) then
		self.hooks[original] = getglobal(original);
		if (mode == "before") then
			setglobal(original, function (...)
				new(unpack(arg));
				self.hooks[original](unpack(arg));
			end);
		elseif (mode == "after") then
			setglobal(original, function (...)
				self.hooks[original](unpack(arg));
				new(unpack(arg));
			end);
		elseif (mode == "replace") then
			setglobal(original, function (...)
				new(unpack(arg));
			end);
		end
	end
end

function Nurfed_Utility:UnHook (original)
	if (self.hooks[original]) then
		setglobal(original, self.hooks[original]);
		self.hooks[original] = nil;
	end
end

function Nurfed_Utility:GetAuraName(unit, aura, type)
	Nurfed_UnitsTooltipTextLeft1:SetText(nil);
	if (unit == "player") then
		local buffIndex, untilCancelled = GetPlayerBuff(aura, "HELPFUL|HARMFUL|PASSIVE");
		Nurfed_UnitsTooltip:SetPlayerBuff(buffIndex);
	else
		if (type == "debuff") then
			Nurfed_UnitsTooltip:SetUnitDebuff(unit, aura);
		else
			Nurfed_UnitsTooltip:SetUnitBuff(unit, aura);
		end
	end
	return Nurfed_UnitsTooltipTextLeft1:GetText();
end

function Nurfed_Utility:linkdecode(link)
	local id;
	local name;
	_, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
	if (id and name) then
		id = id * 1;
		return name, id;
	end
end

function Nurfed_Utility:getslot(item)
	local bag, size, itemLink, itemName, itemID;
	for bag = 0, 4, 1 do
		if (bag == 0) then
			size = 16;
		else
			size = GetContainerNumSlots(bag);
		end
		if (size and size > 0) then
			for slot = 1, size, 1 do
				itemLink = GetContainerItemLink(bag,slot);
				if (itemLink) then
					itemName, itemID = self:linkdecode(itemLink);
					if (itemName == item or itemID == item) then
						return bag, slot;
					end
				end
			end
		end
	end
	return nil;
end