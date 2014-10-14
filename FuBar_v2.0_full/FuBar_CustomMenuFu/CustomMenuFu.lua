local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.2"):new("CustomMenuFu")

CustomMenuFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceConsole-2.0")
CustomMenuFu.hasIcon = "Interface\\Icons\\INV_Scroll_08"
CustomMenuFu.hasNoText = true
CustomMenuFu.hasNoColor = true
CustomMenuFu.overrideMenu = true
CustomMenuFu.clickableTooltip = true
CustomMenuFu:RegisterDB("CustomMenuFuDB", "CustomMenuFuCharDB")
CustomMenuFu:RegisterDefaults("char", {
	entries = {}
})
local options = {
	type = "group",
	args = {
		add = {
			type = "text",
			name = "Add",
			desc = "Add a new menu item.",
			usage = "<name> ### <script>",
			get = false,
			set = function(v) CustomMenuFu:AddItem(v) end,
			validate = function(v) return string.find(v, "(.*)%s+###%s+(.*)") end,
		},
		remove = {
			type = "text",
			name = "Remove",
			desc = "Remove a menu item.",
			usage = "<name>",
			get = false,
			set = function(v) CustomMenuFu:RemoveItem(v) end,
		},
	},
}
CustomMenuFu:RegisterChatCommand({"/cmf"}, options)

function CustomMenuFu:AddItem(v)
	local _, _, name, script = string.find(v, "(.*)%s+###%s+(.*)")
	if not name or not script then return end
	if self.db.char.entries[name] then
		self:Print("Updating "..name..".")
		self.db.char.entries[name] = script
	else
		self:Print("Adding "..name..".")
		self.db.char.entries[name] = script
	end
	self:UpdateDisplay()
end

function CustomMenuFu:RemoveItem(v)
	if not self.db.char.entries[v] then return end
	self.db.char.entries[v] = nil
	self:UpdateDisplay()
end

function CustomMenuFu:OnMenuRequest(level)
	for k, v in pairs(self.db.char.entries) do
		local name = k
		local script = v
		if name and script then
			if script == "---" then
				dewdrop:AddLine()
			else
				dewdrop:AddLine("text", name, "func", function() RunScript(script) end)
			end
		end
	end
end

function CustomMenuFu:OnTooltipUpdate()
	local cat = tablet:AddCategory()
	for k, v in pairs(self.db.char.entries) do
		local name = k
		local script = v
		if name and script then
			if script == "---" then
				cat:AddLine()
			else
				cat:AddLine(
					"text", name,
					"func", function() RunScript(script) end
				)
			end
		end
	end
end

