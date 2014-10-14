--------------------------------------------------------
--	Nurfed Dynamic Frame Creation
--------------------------------------------------------

if (not Nurfed_Frames) then
	Nurfed_Frames = {};
	Nurfed_Frames.pools = {};
	Nurfed_Frames.templates = {};

	Nurfed_Frames.init = {
		size = function(object, value) object:SetWidth(value[1]) object:SetHeight(value[2]) end,
		events = function(object, value) for k, v in ipairs(value) do object:RegisterEvent(v) end end,
		children = function(object, value) for k, v in pairs(value) do if not object:GetName() then return end Nurfed_Frames:CreateObject(object:GetName()..k, v, object, k) end end,
		vars = function(object, value) for k, v in pairs(value) do object[k] = v end end,
		Hide = function(object, value) object:Hide() end,

		-- Run after creation
		Anchor = function(object, value) table.insert(Nurfed_Frames.complete.Anchors, { object, value }) end,
		BackdropColor = function(object, value) table.insert(Nurfed_Frames.complete.BackdropColor, { object, value }) end,
		BackdropBorderColor = function(object, value) table.insert(Nurfed_Frames.complete.BackdropBorderColor, { object, value }) end,
	};

	Nurfed_Frames.complete = {
		Anchors = {},
		BackdropColor = {},
		BackdropBorderColor = {},
	};
end

function Nurfed_Frames:New()
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Nurfed_Frames:SetProperty(object, value, prop)
	local method;
	if (object["Set"..prop]) then
		method = object["Set"..prop];
		if (type(value) == "table" and prop ~= "Backdrop") then
			method(object, unpack(value));
		else
			method(object, value);
		end
	elseif (object["Enable"..prop]) then
		method = object["Enable"..prop];
		method(object, value);
	end
end

function Nurfed_Frames:CreateTemplate(name, layout)
	local objtype = rawget(layout, "type");
	if (objtype == "Font") then
		self:ObjectInit(name, layout);
	else
		self.templates[name] = layout;
	end
end

function Nurfed_Frames:ObjectInit(name, layout, parent)
	if (name and layout) then
		if (not parent) then
			parent = UIParent;
		end
		local object = self:CreateObject(name, layout, parent);
		self:CompleteObject();
		return object;
	end
	layout = nil;
end

function Nurfed_Frames:CreateObject(name, layout, parent, apply)
	local object, inherit;
	if (type(parent) == "string") then
		parent = getglobal(parent);
	end

	if (type(layout) == "string") then
		layout = self.templates[layout];
	end

	if (layout.template) then
		local template = self.templates[layout.template];
		for k, v in pairs(template) do
			if (not layout[k]) then
				layout[k] = v;
			elseif (type(layout[k]) == "table" and type(v) == "table") then
				for x, y in pairs(v) do
					layout[k][x] = y;
				end
			end
		end
		layout.template = nil;
	end

	if (layout.uitemp) then
		inherit = layout.uitemp;
	end

	local objtype = rawget(layout, "type");
	if (objtype == "Texture") then
		object = parent:CreateTexture(name, layout.layer, inherit);
	elseif (objtype == "FontString") then
		object = parent:CreateFontString(name, layout.layer, inherit);
	elseif (objtype == "Font") then
		object = CreateFont(name);
	elseif (objtype) then
		object = CreateFrame(objtype, name, parent, inherit);
	end

	for k, v in pairs(layout) do
		if (type(v) == "table" and v.template) then
			v = self.templates[v.template];
		elseif (type(v) == "string" and self.templates[v]) then
			v = self.templates[v];
		end
		if ((type(v) == "function") and string.find(k, "^On")) then
			object:SetScript(k, v);
		elseif (self.init[k]) then
			self.init[k](object, v);
		else
			self:SetProperty(object, v, k);
		end
	end

	if (apply and string.find(apply, "Texture", 1, true)) then
		local method = parent["Set"..apply];
		if (method) then
			method(parent, object);
		end
	end

	return object;
end

function Nurfed_Frames:CompleteObject()
	for _, v in ipairs(self.complete.Anchors) do
		v[1]:ClearAllPoints();
		if (type(v[2]) ~= "table") then
			v[1]:SetAllPoints(v[1]:GetParent());
		else
			if (type(v[2][2]) == "number") then
				v[1]:SetPoint(v[2][1], v[2][2], v[2][3]);
			else
				local parent = string.gsub(v[2][2], "$parent", v[1]:GetParent():GetName());
				if (v[2][5]) then
					v[1]:SetPoint(v[2][1], parent, v[2][3], v[2][4], v[2][5]);
				elseif (v[2][3]) then
					v[1]:SetPoint(v[2][1], parent, v[2][3]);
				else
					v[1]:SetPoint(v[2][1], parent);
				end
			end
		end
	end
	self.complete.Anchors = {};

	for _, v in ipairs(self.complete.BackdropColor) do
		v[1]:SetBackdropColor(unpack(v[2]));
	end
	self.complete.BackdropColor = {};

	for _, v in ipairs(self.complete.BackdropBorderColor) do
		v[1]:SetBackdropBorderColor(unpack(v[2]));
	end
	self.complete.BackdropColor = {};
end