--[[ $Id: PlayerMenu.lua 16454 2006-11-09 11:16:15Z hshh $ ]]--
-- ACE2 init
local L = AceLibrary("AceLocale-2.2"):new("PlayerMenu")
PlayerMenu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceHook-2.1", "AceConsole-2.0")
local Version = "2.1"

function PlayerMenu:OnInitialize()
	-- prepare Order_Orig, Button_Orig
	self.Order_Orig = { "WHISPER", "INVITE", "TARGET", "GUILD_PROMOTE", "GUILD_LEAVE", "ADD_FRIEND", "GUILD_INVITE", "IGNORE", "GET_NAME", "WHO", "CANCEL" }
	self.Button_Orig = {}
	for k,v in self.Order_Orig do
		self.Button_Orig[v]=1
	end
	self.Menus=table.getn(self.Order_Orig)

	-- save blizzard orign variables
	self.UnitPopupButtons={}
	self.UnitPopupMenus={}
	for k,v in UnitPopupButtons do
		self.UnitPopupButtons[k]=v
	end
	for k,v in UnitPopupMenus do
		self.UnitPopupMenus[k]=v
	end

	-- register saved variables
	self:RegisterDB("PlayerMenu_Settings")
	-- init default variables
	self:RegisterDefaults("account", {
		toggleEnable = true,
		leftButton = false,
		order = self.Order_Orig,
		button = self.Button_Orig
	})
	-- found old saved variables, reset it.
	if (self.db.account.version ~= Version) then
		self:ResetDB("account")
		self:Print(L["MSG_RESETED"])
		self.db.account.version = Version
	end

	-- register console slash commands
	self:RegisterChatCommand(
		{ "/playermenu", "/pm", "/apm" },
		{
			type = "group",
			args = {
				toggle = {
					type = "toggle",
					name = "toggle",
					desc = L["toggleEnable_desc"],
					get = function() return self.db.account.toggleEnable end,
					set = function(t)
						self.db.account.toggleEnable = t
						if (self.db.account.toggleEnable) then
							self:Print(L["MSG_PM_ON"])
						else
							self:Print(L["MSG_PM_OFF"])
						end
						self:Reload()
					end,
				},
				left = {
					type = "toggle",
					name = "left",
					desc = L["leftButton_desc"],
					get = function() return self.db.account.leftButton end,
					set = function(t)
						self.db.account.leftButton = t
						if (self.db.account.leftButton) then
							self:Print(L["MSG_LEFT_ON"])
						else
							self:Print(L["MSG_LEFT_OFF"])
						end
						self:Reload()
					end,
				},
				order = {
					type = "text",
					name = "order",
					desc = L["order_desc"],
					usage = L["order_usage"],
					get = function()
						local order=""
						for k,v in self.db.account.order do
							if (self.db.account.button[v]==1) then
								order=order..v..":1,"
							else
								order=order..v..":0,"
							end
						end
						order = string.sub(order, 1, -2)
						return order
					end,
					set = function (c)
						c = string.upper(c)
						local newOrder = {}
						local newButton = {}
						local i = 1
						for b,e in string.gfind(c, "([%w_]+):(%d)") do
							e = tonumber(e)
							if (e~=1 and e~=0) then
								e=1
							end
							if (b~=nil and self.Button_Orig[b]~=nil) then
								newOrder[i]=b
								newButton[b]=e
								i=i+1
							end
						end
						if (table.getn(newOrder)==self.Menus) then
							self.db.account.order = newOrder
							self.db.account.button = newButton
							self:Reload()
						end
					end,
					message = L["MSG_MENU_ORDER_CHANGED"]
				},
				reset = {
					type = "execute",
					name = "reset",
					desc = L["reset_desc"],
					func = function()
						self:ResetDB("account")
						self:Reload()
						self:Print(L["MSG_RESETED"])
					end
				}
			}
		}
	)
end

function PlayerMenu:OnEnable()
	if (not self.db.account.toggleEnable) then
		return
	end

	self:Hook("UnitPopup_OnClick")
	self:Hook("UnitPopup_HideButtons")
	if (self.db.account.leftButton) then
		self:Hook("SetItemRef")
	end

	UnitPopupButtons["ADD_FRIEND"] = { text = TEXT(ADD_FRIEND), dist = 0 }
	UnitPopupButtons["GUILD_INVITE"] = { text = TEXT(L["TEXT_GUILD_INVITE"]), dist = 0 }
	UnitPopupButtons["IGNORE"] = { text = TEXT(IGNORE), dist = 0 }
	UnitPopupButtons["GET_NAME"] = { text = TEXT(L["TEXT_GET_NAME"]), dist = 0 }
	UnitPopupButtons["WHO"] = { text = TEXT(WHO), dist = 0 }

	UnitPopupMenus["FRIEND"] = {}
	for k,v in self.db.account.order do
		if (self.db.account.button[v]==1) then
			UnitPopupMenus["FRIEND"][k]=v
		end
	end

	tinsert(UnitPopupMenus["PLAYER"], getn(UnitPopupMenus["PLAYER"])-1, "WHO")
	tinsert(UnitPopupMenus["PARTY"], getn(UnitPopupMenus["PARTY"])-1, "WHO")
end

function PlayerMenu:OnDisable()
	for k,v in self.UnitPopupButtons do
		UnitPopupButtons[k]=v
	end
	for k,v in self.UnitPopupMenus do
		UnitPopupMenus[k]=v
	end

	self:UnhookAll()
end

function PlayerMenu:UnitPopup_HideButtons()
	self.hooks.UnitPopup_HideButtons()
	local dropdownMenu = getglobal(UIDROPDOWNMENU_INIT_MENU)
	for index, value in UnitPopupMenus[dropdownMenu.which] do
		if ( value == "GUILD_INVITE" ) then
			if ( not CanGuildInvite() or dropdownMenu.name == UnitName("player") ) then
				UnitPopupShown[index] = 0
			else
				UnitPopupShown[index] = 1
			end
		elseif ( value == "ADD_FRIEND" or value == "IGNORE" or value == "WHO" or value == "GET_NAME") then
			if (dropdownMenu.name == UnitName("player")) then
				UnitPopupShown[index] = 0
			else
				UnitPopupShown[index] = 1
			end
		end
	end
end

function PlayerMenu:UnitPopup_OnClick()
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU)
	local button = this.value
	local name = dropdownFrame.name

	if (button == "ADD_FRIEND") then
		AddFriend(name)
	elseif (button == "GUILD_INVITE") then
		GuildInviteByName(name)
	elseif (button == "IGNORE") then
		AddIgnore(name)
	elseif (button == "GET_NAME") then
		ChatFrameEditBox:Show()
		local realm
		if dropdownFrame.unit then
			_,realm = UnitName(dropdownFrame.unit)
		end
		if realm then
			ChatFrameEditBox:Insert(name .. " - " .. realm)
		else
			ChatFrameEditBox:Insert(name)
		end
	elseif (button == "WHO") then
		SendWho(name)
	else
		return self.hooks.UnitPopup_OnClick()
	end
	PlaySound("UChatScrollButton")
end

function PlayerMenu:SetItemRef(link, text, button)
	if ( strsub(link, 1, 6) == "player" ) then
		local name = strsub(link, 8)
		if ( name and (strlen(name) > 0) ) then
			name = gsub(name, "([^%s]*)%s+([^%s]*)%s+([^%s]*)", "%3")
			name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2")
			if ( IsShiftKeyDown() ) then
				local staticPopup
				staticPopup = StaticPopup_Visible("ADD_IGNORE")
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name)
					return
				end
				staticPopup = StaticPopup_Visible("ADD_FRIEND")
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name)
					return
				end
				staticPopup = StaticPopup_Visible("ADD_GUILDMEMBER")
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name)
					return
				end
				staticPopup = StaticPopup_Visible("ADD_RAIDMEMBER")
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name)
					return
				end
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:Insert(name)
				else
					SendWho("n-"..name)
				end

			else
				FriendsFrame_ShowDropdown(name, 1)
			end
		end
		return
	end

	return self.hooks.SetItemRef(link, text, button)
end

function PlayerMenu:Reload()
	self:OnDisable()
	self:OnEnable()
end
