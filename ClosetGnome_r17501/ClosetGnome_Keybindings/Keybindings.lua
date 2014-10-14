local L = AceLibrary("AceLocale-2.2"):new("ClosetGnomeKeybindings")

L:RegisterTranslations("enUS", function() return {
	["ClosetGnome Keybindings"] = true,
	["Assign keybindings to ClosetGnome sets."] = true,
	["Set %d"] = true,
	["Assign the given set name with the binding for set %d."] = true,
	["<setName>"] = true,
} end)

L:RegisterTranslations("zhCN", function() return {
	["ClosetGnome Keybindings"] = "ClosetGnome按键绑定",
	["Assign keybindings to ClosetGnome sets."] = "为套装设置按键绑定",
	["Set %d"] = "设置 %d",
	["Assign the given set name with the binding for set %d."] = "把按键绑定的设置分配给套装 %d. 在栏内输入ClosetGnome套装的名字.",
	["<setName>"] = "<设置名>",
} end)

local _G = getfenv(0)

BINDING_HEADER_CLOSETGNOME = L["ClosetGnome Keybindings"]
for i = 1, 10 do
	_G["BINDING_NAME_CGKBSET"..i] = string.format(L["Set %d"], i)
end

ClosetGnomeKB = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0")

function ClosetGnomeKB:OnInitialize()
	self:RegisterDB("ClosetGnomeKBDB", "ClosetGnomePerCharKBDB")

	local options = {
		type = "group",
		name = L["ClosetGnome Keybindings"],
		desc = L["Assign keybindings to ClosetGnome sets."],
		args = {},
	}
	for i = 1, 10 do
		local num = i
		options.args["set"..num] = {
			type = "text",
			name = string.format(L["Set %d"], num),
			desc = string.format(L["Assign the given set name with the binding for set %d."], num),
			usage = L["<setName>"],
			validate = function(name)
				return name == "" or not name or ClosetGnome:HasSet(name)
			end,
			get = function() return ClosetGnomeKB.db.char["set"..num] end,
			set = function(name) ClosetGnomeKB.db.char["set"..num] = name end,
		}
	end
	self:RegisterChatCommand({ "/cgkb" }, options, "CLOSETGNOMEKEYBINDINGS")
end

function ClosetGnomeKB:BindingClicked(dbKey)
	local set = ClosetGnomeKB.db.char[dbKey]
	if set and set ~= "" then
		ClosetGnome:WearSet(set)
	end
end

