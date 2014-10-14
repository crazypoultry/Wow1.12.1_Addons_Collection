local Tablet = AceLibrary("Tablet-2.0")

MicroMenuFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceConsole-2.0")

MicroMenuFu.version = "2.0." .. string.sub("$Revision: 9804 $", 12, -3)
MicroMenuFu.date = string.sub("$Date: 2006-09-02 02:34:57 -0400 (Sat, 02 Sep 2006) $", 8, 17)
MicroMenuFu.hasNoText = true
MicroMenuFu.hideWithoutStandby = true
MicroMenuFu.hasIcon = false
MicroMenuFu.frame = MicroMenuFu:CreateBasicPluginFrame("FuBar_MicroMenuFuFrame")

MicroMenuFu:RegisterDB("MicroMenuFuDB")
MicroMenuFu:RegisterDefaults("profile", {
	buttonSize = 3,
	buttonSpacing = 1,
	visible = {
		["Char"] = true,
		["Spells"] = true,
		["Main"] = true,
		["Talents"] = true,
		["Quest"] = true,
		["Socials"] = true,
		["World"] = true,
		["Help"] = true,
	},
})

local L = AceLibrary("AceLocale-2.0"):new("FuBar_MicroMenuFu")
local _G = getfenv(0)

local buttons = {
	{
		id = "Char",
		icon = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
		exec = function() ToggleCharacter("PaperDollFrame") end,
		key  = "TOGGLECHARACTER0",
		name = CHARACTER_BUTTON,
		tip  = NEWBIE_TOOLTIP_CHARACTER,
	},
	{
		id = "Spells",
		icon = "Interface\\Buttons\\UI-MicroButton-Spellbook-Up",
		exec = function() ToggleSpellBook(BOOKTYPE_SPELL) end,
		key  = "TOGGLESPELLBOOK",
		name = SPELLBOOK_ABILITIES_BUTTON,
		tip  = NEWBIE_TOOLTIP_SPELLBOOK,
		texcoord = {0.1, 0.9, 0.5, 0.9},
	},
	{
		id = "Main",
		icon = "Interface\\Buttons\\UI-MicroButton-MainMenu-Up",
		exec = function() ToggleGameMenu(1) end,
		key  = "TOGGLEGAMEMENU",
		name = MAINMENU_BUTTON,
		tip  = NEWBIE_TOOLTIP_MAINMENU,
		texcoord = {0.1, 0.9, 0.5, 0.9},
	},
	{
		id = "Talents",
		icon = "Interface\\Buttons\\UI-MicroButton-Talents-Up",
		exec = function() ToggleTalentFrame() end,
		key  = "TOGGLETALENTS",
		name = TALENTS_BUTTON,
		tip  = NEWBIE_TOOLTIP_TALENTS,
		texcoord = {0.1, 0.9, 0.5, 0.9},
	},
	{
		id = "Quest",
		icon = "Interface\\Buttons\\UI-MicroButton-Quest-Up",
		exec = function() ToggleQuestLog() end,
		key  = "TOGGLEQUESTLOG",
		name = QUESTLOG_BUTTON,
		tip  = NEWBIE_TOOLTIP_QUESTLOG,
		texcoord = {0.1, 0.9, 0.5, 0.9},
	},
	{
		id = "Socials",
		icon = "Interface\\Buttons\\UI-MicroButton-Socials-Up",
		exec = function() ToggleFriendsFrame() end,
		key  = "TOGGLESOCIAL",
		name = SOCIAL_BUTTON,
		tip  = NEWBIE_TOOLTIP_SOCIAL,
		texcoord = {0.1, 0.9, 0.5, 0.9},
	},
	{
		id = "World",
		icon = "Interface\\Buttons\\UI-MicroButton-World-Up",
		exec = function() ToggleWorldMap() end,
		key  = "TOGGLEWORLDMAP",
		name = WORLDMAP_BUTTON,
		tip  = NEWBIE_TOOLTIP_WORLDMAP,
		texcoord = {0.1, 0.9, 0.5, 0.9},
	},
	{
		id = "Help",
		icon = "Interface\\Buttons\\UI-MicroButton-Help-Up",
		exec = function() ToggleHelpFrame() end,
		key  = "TOGGLEHELPMENU",
		name = HELP_BUTTON,
		tip  = NEWBIE_TOOLTIP_HELP,
		texcoord = {0.1, 0.9, 0.5, 0.9},
	},
}

local options = {
	handler = MicroMenuFu,
	type = 'group',
	args = {
		spacing = {
			type = 'range',
			name = L["Button Spacing"],
			desc = L["Set Button Spacing"],
			min  = 0,
			max  = 10,
			step = 0.5,
			set  = function(size) MicroMenuFu:SetButtonSpacing(size) end,
			get  = function() return MicroMenuFu:GetButtonSpacing() end,
		},
		visibility = {
			type = 'group',
			name = L["Button Visibility"],
			desc = L["Toggle Button Visibility"],
			args = {
			}
		},
	},
}

for _, data in ipairs(buttons) do
	local name = data.id
	local key_name = string.gsub(name, "%s+", "-")
	local button_name = name

	local subtbl = {}
	options.args.visibility.args[key_name] = subtbl
	subtbl.type = "toggle"
	subtbl.name = data.name
	subtbl.desc = string.format(L["Toggle visibility of %s"], data.name)
	subtbl.get = function() return MicroMenuFu:IsShowingButton(button_name) end
	subtbl.set = function() MicroMenuFu:ToggleShowingButton(button_name) end
end

MicroMenuFu.OnMenuRequest = options
MicroMenuFu:RegisterChatCommand({ "/micromenufu" }, options)

function MicroMenuFu:OnEnable()
	self.fontSize = FuBar:GetFontSize()
	self:BuildButtons()
end

function MicroMenuFu:IsShowingButton(button)
	return self.db.profile.visible[button]
end

function MicroMenuFu:ToggleShowingButton(button)
	self.db.profile.visible[button] = not self.db.profile.visible[button]
	self:CheckWidth(true)
	return self.db.profile.visible[button]
end

function MicroMenuFu:OnTooltipUpdate()
	if self.current_mouseover then
		local data
		for _,v in ipairs(buttons) do
			if v.id == self.current_mouseover then
				data = v
				break
			end
		end
		if not data then
			return
		end
		local key = GetBindingKey(data.key)
		if key then
			key = " (" .. key .. ")"
		else
			key = ""
		end
		Tablet:SetTitle(format("|cffffffff%s|r%s", data.name, key))
		Tablet:AddCategory():AddLine(
			'text', data.tip,
			'wrap', true
		)
	end
end

function MicroMenuFu:GetButtonSpacing()
	return self.db.profile.buttonSpacing
end

function MicroMenuFu:SetButtonSpacing(spacing)
	if spacing then
		self.db.profile.buttonSpacing = spacing
		self:SetFontSize(self.fontSize)
	end
end

function MicroMenuFu:BuildButtons()
	local last
	local frameWidth = 0
	for _, data in ipairs(buttons) do
		local name = data.id
		if self:IsShowingButton(name) then
			local button_name = name
			local frame_name = "MicroMenuFuFrame" .. name
			local button = _G[frame_name] or self:CreatePluginChildFrame("Button", frame_name, self.frame)
			button:Show()
			button:EnableMouse(true)
			if last then
				button:SetPoint("LEFT", last, "RIGHT", self:GetButtonSpacing(), 0)
			else
				button:SetPoint("LEFT", self.frame, "LEFT", self:GetButtonSpacing(), 0)
			end

			local texture = _G[frame_name .. "Texture"] or button:CreateTexture(frame_name .. "Texture")
			texture:SetTexture(data.icon)
			if data.texcoord then
				texture:SetTexCoord(unpack(data.texcoord))
			end

			texture:SetAllPoints(button)

			local OnEnter = button:GetScript("OnEnter")
			button:SetScript("OnEnter", function()
				self.current_mouseover = button_name
				OnEnter()
			end)

			local OnLeave = button:GetScript("OnLeave")
			button:SetScript("OnLeave", function()
				self.current_mouseover = nil
				OnLeave()
			end)

			button:SetScript("OnClick", data.exec)

			button:SetWidth(FuBar:GetFontSize())
			button:SetHeight(FuBar:GetFontSize())
			frameWidth = frameWidth + button:GetWidth() + self:GetButtonSpacing()

			last = button
		else
			local button = _G["MicroMenuFuFrame" .. name]
			if button then
				button:Hide()
			end
		end
	end

	if frameWidth > 0 then
		self:SetFontSize(self.fontSize)
	else
		self:ToggleShowingButton("Char")
		self:BuildButtons()
	end
end

function MicroMenuFu:CheckWidth(force)
	if force then
		self:SetFontSize(self.fontSize)
		if self.panel and self.panel:GetPluginSide(self) == "CENTER" then
			self.panel:UpdateCenteredPosition()
		end
	end
end

function MicroMenuFu:SetFontSize(fsize)
	if fsize then
		local frameWidth = 0
		local last
		local newIconSize = FuBar:GetFontSize()
		for _, v in ipairs(buttons) do
			local name = v.id
			local button = _G["MicroMenuFuFrame" .. name]
			if button then
				if self:IsShowingButton(name) then
					button:SetWidth(newIconSize)
					button:SetHeight(newIconSize)
					button:Show()

					if last then
						button:SetPoint("LEFT", last, "RIGHT", self:GetButtonSpacing(), 0)
					else
						button:SetPoint("LEFT", self.frame, "LEFT", self:GetButtonSpacing(), 0)
					end

					frameWidth = frameWidth + button:GetWidth() + self:GetButtonSpacing()
					last = button
				else
					button:Hide()
				end
			end
		end

		self.fontSize = fsize
		self.frame:SetWidth(frameWidth)
	end
end

