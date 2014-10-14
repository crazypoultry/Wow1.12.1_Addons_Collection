local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')

LogFu = FuBarPlugin:new({
	name          = LogFuLocals.NAME,
	description   = LogFuLocals.DESCRIPTION,
	version       = "1.0",
	releaseDate   = "2006-05-13",
	aceCompatible = 103,
	fuCompatible  = 102,
	author        = "Etten",
	email         = "idbrain@gmail.com",
	website       = "http://etten.wowinterface.com/",
	category      = "chat",
	db            = AceDatabase:new("LogFuDB"),
	defaults      = {
		ChatLogging = false,
		CombatLogging = false,
	},
	hasIcon       = LogFuLocals.DEFAULT_ICON,
	
	-- Localization Tags
	loc = LogFuLocals,

	ENDLOGFU = true
})
	
-- Build the menu
function LogFu:MenuSettings(level, value, inTooltip)
	if not inTooltip then
		if level == 1 then
			dewdrop:AddLine(
			'text', self.loc.MENU_COMBATLOG_NAME,
			'value', self.loc.MENU_COMBATLOG_NAME,
			'func', function() self:ToggleCombatLogging(self.loc.MENU_COMBATLOG_NAME) end,
			'checked', self.data.CombatLogging)

			dewdrop:AddLine(
			'text', self.loc.MENU_CHATLOG_NAME,
			'value', self.loc.MENU_CHATLOG_NAME,
			'func', function() self:ToggleChatLogging(self.loc.MENU_CHATLOG_NAME) end,
			'checked', self.data.ChatLogging)				
		end
	end
end

function LogFu:ToggleCombatLogging()
	self.data.CombatLogging = not self.data.CombatLogging
	if self.data.CombatLogging == true then
		DEFAULT_CHAT_FRAME:AddMessage(self.loc.WINDOW_COMBAT_ENABLED,1,0,0)
		LoggingCombat(1)
	else
		DEFAULT_CHAT_FRAME:AddMessage(self.loc.WINDOW_COMBAT_DISABLED,1,0,0)
		LoggingCombat(0)
	end
	self:Update()
	return self.data.CombatLogging
end

function LogFu:ToggleChatLogging()
	self.data.ChatLogging = not self.data.ChatLogging
	if self.data.ChatLogging == true then
		DEFAULT_CHAT_FRAME:AddMessage(self.loc.WINDOW_CHAT_ENABLED,1,0,0)
		LoggingChat(1)
	else
		DEFAULT_CHAT_FRAME:AddMessage(self.loc.WINDOW_CHAT_DISABLED,1,0,0)
		LoggingChat(0)
	end
	self:Update()
	return self.data.ChatLogging
end

function LogFu:UpdateText()
	if self.data.CombatLogging and self.data.ChatLogging then
		self:SetText(self.loc.BAR_TEXT_BOTH)
	elseif self.data.CombatLogging then
		self:SetText(self.loc.BAR_TEXT_COMBAT)
	elseif self.data.ChatLogging then
		self:SetText(self.loc.BAR_TEXT_CHAT)
	else
		self:SetText(self.loc.BAR_TEXT_DISABLED)
	end
end

function LogFu:UpdateTooltip()
	
	-- Display Combat Log Info
	local combatcat = tablet:AddCategory(
		'text', self.loc.TOOLTIP_CAT_COMBAT,
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)

	if self.data.CombatLogging then
		combatcat:AddLine(
			'text', self.loc.TOOLTIP_STATE .. ":",
			'text2', self.loc.TOOLTIP_ENABLED
		)
		combatcat:AddLine(
			'text', self.loc.TOOLTIP_PATH .. ":",
			'text2', self.loc.TOOLTIP_FPATH .. "\\" .. self.loc.TOOLTIP_FNAME_COMBAT
		)
	else
		combatcat:AddLine(
			'text', self.loc.TOOLTIP_STATE .. ":",
			'text2', self.loc.TOOLTIP_DISABLED
		)
		--[[
		combatcat:AddLine(
			'text', self.loc.TOOLTIP_PATH .. ":",
			'text2', self.loc.TOOLTIP_FPATH .. "\\" .. self.loc.TOOLTIP_FNAME_COMBAT
		)
		]]--
	end

	-- Display Chat Log Info
	local chatcat = tablet:AddCategory(
		'text', self.loc.TOOLTIP_CAT_CHAT,
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)

	if self.data.ChatLogging then
		chatcat:AddLine(
			'text', self.loc.TOOLTIP_STATE .. ":",
			'text2', self.loc.TOOLTIP_ENABLED
		)
		chatcat:AddLine(
			'text', self.loc.TOOLTIP_PATH .. ":",
			'text2', self.loc.TOOLTIP_FPATH .. "\\" .. self.loc.TOOLTIP_FNAME_COMBAT
		)
	else
		chatcat:AddLine(
			'text', self.loc.TOOLTIP_STATE .. ":",
			'text2', self.loc.TOOLTIP_DISABLED
		)
		--[[
		chatcat:AddLine(
			'text', self.loc.TOOLTIP_PATH .. ":",
			'text2', self.loc.TOOLTIP_FPATH .. "\\" .. self.loc.TOOLTIP_FNAME_COMBAT
		)
		]]-- 
	end
	
	tablet:SetHint(self.loc.TOOLTIP_LOG_WARNING)
end

function LogFu:OnClick() 
  self:ToggleChatLogging() 
  self:Update()
end

LogFu:RegisterForLoad()