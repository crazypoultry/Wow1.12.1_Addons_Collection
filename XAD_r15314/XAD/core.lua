--[[---------------------------------------------------------------------------------
  XAD by Thirsterhall
  
  TODO:
	fix button highlighting, push dispaly
	add tooltips and toogle to hide tooltips
----------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
  Create the AddOn object
----------------------------------------------------------------------------------]]
XAD = AceLibrary("AceAddon-2.0"):new(
	"AceEvent-2.0", 
	"AceHook-2.0", 
	"AceConsole-2.0", 
	"AceDB-2.0",    
	"AceDebug-2.0",
	"AceModuleCore-2.0"
)
XAD:SetDebugLevel(2)

--[[---------------------------------------------------------------------------------
  Setup the savedvariable and DB defaults
----------------------------------------------------------------------------------]]
XAD:RegisterDB("XADDB")
XAD:RegisterDefaults('profile', {
    locked = true,
    rows = 2,
    quite = false,
    size = 32,
    textsize = 20,
    buttons = {}
})

--[[---------------------------------------------------------------------------------
  Load up the libraries
----------------------------------------------------------------------------------]]
local L = AceLibrary("AceLocale-2.2"):new("XAD")
local BS = AceLibrary("Babble-Spell-2.2")
local SC = AceLibrary:GetInstance("SpellCache-1.0")
local metro = AceLibrary:GetInstance("Metrognome-2.0")
local PT = PeriodicTableEmbed:GetInstance("1")
local AceOO = AceLibrary("AceOO-2.0")
local compost = AceLibrary("Compost-2.0")

local templates = {}

--L:SetLocale(true)

XAD.Constants = {
	maxbuttons = 12,
}
	
-- Expoxe AceDebug and AceEvent to our modules
XAD:SetModuleMixins("AceEvent-2.0", "AceDebug-2.0", "AceDebug-2.0")

BINDING_HEADER_XAD = "XAD"
BINDING_NAME_XAD_BUTTON1 = L["Button 1"]
BINDING_NAME_XAD_BUTTON2 = L["Button 2"]
BINDING_NAME_XAD_BUTTON3 = L["Button 3"]
BINDING_NAME_XAD_BUTTON4 = L["Button 4"]
BINDING_NAME_XAD_BUTTON5 = L["Button 5"]
BINDING_NAME_XAD_BUTTON6 = L["Button 6"]
BINDING_NAME_XAD_BUTTON7 = L["Button 7"]
BINDING_NAME_XAD_BUTTON8 = L["Button 8"]
BINDING_NAME_XAD_BUTTON9 = L["Button 9"]
BINDING_NAME_XAD_BUTTON10 = L["Button 10"]
BINDING_NAME_XAD_BUTTON11 = L["Button 11"]
BINDING_NAME_XAD_BUTTON12 = L["Button 12"]

--[[---------------------------------------------------------------------------------
  This is the actual addon object
----------------------------------------------------------------------------------]]
function XAD:OnInitialize()
	--setup our slash command options
	local Options = {
		type="group",
		args = {
			lock = {
				name = L["Lock"], 
				type = "toggle",
				desc = L["LockDes"],
				get = function() return self.db.profile.locked end,
				set = function(v) self:toggleMove(v) end,
			},
			size = {
				name = L["Buttonsize"],
				type = 'range',
				desc = L["ButtonsizeDes"],
				get = function() return self.db.profile.size end,
				set = function(v) self.db.profile.size=v self:ChangButtonSize(v) end,
				min = 10,
				max = 50, 
				step = 1,
				isPercent = false,
			},
			textsize = {
				name = L["Textsize"],
				type = 'range',
				desc = L["TextsizeDes"],
				get = function() return self.db.profile.textsize end,
				set = function(v) self.db.profile.textsize=v self:ChangeFontSize(v) end,
				min = 5,
				max = 50, 
				step = 1,
				isPercent = false,
			},
			rows = {
				name = L["Rows"],
				type = 'range',
				desc = L["RowsDes"],
				get = function() return self.db.profile.rows end,
				set = function(v) self.db.profile.rows=v self:PositionButtons() end,
				min = 1,
				max = 12, 
				step = 1,
				isPercent = false,
			},
			quite = {
				name =  L["Quiet"], 
				type = "toggle",
				desc =  L["QuiteDes"],
				get = function() return self.db.profile.quite end,
				set = function(v) self.db.profile.quite = v end,
			},
	}}
	self:RegisterChatCommand({ "/XAD"}, Options)

	-- setup our plugin require interface
	local interface = AceOO.Interface{
		ShowItem = "function",
		UseItem = "function",
		ItemInList = "function",
	}
	
	--disable all modules to start off with and check interface requirments
	for name,module in self:IterateModules() do
		assert(AceOO.inherits(module, interface), "Module "..name.." is not compatible")
		self:ToggleModuleActive(name, false)
	end
	-- create the  buttons
	self.Buttons = self:CreateButtons()
end

function XAD:OnEnable()


	self:PositionButtons()
	self.Buttons:Show()
	-- setup a timer for bagupdated
	metro:Register("XAD_Refresh", self.OnTick, 1, self)
	metro:Register("XAD_EnterDelay", self.EnterDelay, 1, self)

	--register our events and set our hooks
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UPDATE_BINDINGS")
	self:RegisterEvent("ACTIONBAR_SHOWGRID")
	self:RegisterEvent("ACTIONBAR_HIDEGRID")
	self:RegisterEvent("SpecialEvents_BagSlotUpdate")
	self:Hook("PickupContainerItem")
	self:Hook("PickupSpell")
	for i=1, 12 do
		metro:Register("XAD_ButtonTimer"..i, self.OnCDTick, 1, self, i)
	end
	
	--Load the modules
	self:LoadModules()
	self:UPDATE_BINDINGS()
end

function XAD:OnDisable()
	--stop and get rid of the metro timers
	metro:Stop("XAD_Refresh")
	metro:UnregisterMetro("XAD_Refresh")
	metro:UnregisterMetro("XAD_EnterDelay")

	for i=1, 12 do
		metro:UnregisterMetro("XAD_ButtonTimer"..i)
	end
	--disable all modules
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(name, false)
	end
	-- hide the buttons.   Frames can't be deleted
	self.Buttons:Hide()
end


--[[---------------------------------------------------------------------------------
  Template  and module Handlers
----------------------------------------------------------------------------------]]
function XAD:RegisterTemplate(name, template)
	assert(not templates[name], "Template already exists")
	templates[name] = template
end


function XAD:GetTemplate(name)
	assert(templates[name], "Template doesn't exist")
	return templates[name]
end

function XAD:LoadModules()
	for name,module in self:IterateModules() do
		if not self:IsModuleActive(name) and not module.disabled then
			-- if the module is assigned a button then enable it and set the  button up
			for i=1, self.Constants.maxbuttons do
				if self.db.profile.buttons[i] == name then
					self:LevelDebug(1, "Enabling module %s for button %s", module.fullname, i)
					self:ToggleModuleActive(name,true)
					self.Buttons[i].module = name
				end
			end
		end
	end
end

--[[---------------------------------------------------------------------------------
				Events
----------------------------------------------------------------------------------]]

function XAD:PLAYER_ENTERING_WORLD()
	metro:Start("XAD_EnterDelay")
end

function XAD:EnterDelay()
	metro:Stop("XAD_EnterDelay")
	for i=1, self.Constants.maxbuttons do
		if self.Buttons[i].module then
			self:UpdateButton(i)
		else
			self.Buttons[i]:Hide()
		end
	end
end

function XAD:SpecialEvents_BagSlotUpdate(bag, slot, itemlink, stack, oldlink, oldstack)
    self:LevelDebug(2, "XAD:SpecialEvents_BagSlotUpdate(%s, %s, %s, %s, %s, %s)", bag, slot, itemlink, stack, oldlink, oldstack)
	for i=1, self.Constants.maxbuttons do
		if self.Buttons[i].module then
			if self.modules[self.Buttons[i].module]:ItemInList(itemlink) or
			   self.modules[self.Buttons[i].module]:ItemInList(oldlink) then
				self:UpdateButton(i)
			end
		end
	end
end

function XAD:PickupContainerItem(bag,slot)
    self:LevelDebug(2, "XAD:PickupContainerItem( %s, %s", bag , slot)
	self.hooks.PickupContainerItem.orig(bag, slot)
	if bag then self.CursorItem={bag, slot} else self.CursorItem=nil end
end

function XAD:PickupSpell(spellID, bookType)   
    self:LevelDebug(2, "XAD:PickupSpell( %s, %s", spellID , bookType)
	self.hooks.PickupSpell.orig(spellID, bookType)
	if spellID then self.CursorSpell=spellID else self.CursorSpell=nil end
end

function XAD:ACTIONBAR_SHOWGRID()
    self:LevelDebug(2, "XAD:ACTIONBAR_SHOWGRID")
	for i=1, self.Constants.maxbuttons do
		if not self.Buttons[i].module then 
			self:LevelDebug(2, "XAD:Add texture to button %s", i)
			local icon = getglobal("XADButton"..i.."Icon")
			icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark") 
		end
		self.Buttons[i]:Show()
	end
end

function XAD:ACTIONBAR_HIDEGRID()
    self:LevelDebug(2, "XAD:ACTIONBAR_HIDEGRID")
	for i=1, self.Constants.maxbuttons do
		if not self.Buttons[i].module then self.Buttons[i]:Hide() end
	end
end

function XAD:SetTooltip()
	if not self.Buttons[this:GetID()].module then return end
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
	GameTooltip:AddLine(self.modules[self.Buttons[this:GetID()].module].fullname)
	GameTooltip:Show()
end

--[[---------------------------------------------------------------------------------
			Create the UI elements
----------------------------------------------------------------------------------]]
function XAD:CreateButtons()
	-- create a main parent frame for the buttons
	local buttons = CreateFrame('Frame', nil, UIParent )
	-- create a moveable frame for the buttons
	local moveframe = CreateFrame('Frame', nil, buttons)
	
	-- enable the mouse and make the frame movable
	buttons:SetMovable(true)
	
	moveframe:SetMovable(true)
	moveframe:EnableMouse(true)
	moveframe:SetBackdrop({
		bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background',
		edgeFile = '',
		edgeSize = 0,
		tile = true,
		tileSize = 16,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	moveframe:SetBackdropColor(1.0, 0, 0, 0.6)
	moveframe:SetFrameLevel(buttons:GetFrameLevel() + 2)
	-- setup functions for moving positioning the buttons
	moveframe:SetScript("OnMouseDown",function()
		if arg1 == "LeftButton" and not XAD.db.profile.locked then
			this:GetParent():StartMoving()
		end
	end)
	moveframe:SetScript("OnMouseUp",function()
		if arg1 == "LeftButton" and not XAD.db.profile.locked then
			this:GetParent():StopMovingOrSizing()
			if not XAD.db.profile.position then XAD.db.profile.position = {} end
			XAD.db.profile.position.x = this:GetParent():GetLeft() * this:GetParent():GetEffectiveScale()
			XAD.db.profile.position.y = this:GetParent():GetBottom() * this:GetParent():GetEffectiveScale()
		end
	end)
	-- if the fame is locked then hide the move frame
	if(self.db.profile.locked) then
		moveframe:Hide()
		moveframe:EnableMouse(false)
	end
	buttons.Move = moveframe

	--create the buttons
	for i=1, self.Constants.maxbuttons do
		buttons[i] = self:CreateButton(i,'XADButton'..i, buttons)
	end
	
	return buttons
end

function XAD:CreateButton (id, name, parent)
	local button = CreateFrame("Button", name, parent)
	button:SetID(id)
	--button:SetAlpha(parent:GetAlpha())
	button:SetHeight(self.db.profile.size)
	button:SetWidth(self.db.profile.size)
--	getglobal(name.."NormalTexture"):SetAllPoints(button)

	--icon texture
	local iconTexture = button:CreateTexture(name .. "Icon", "BACKGROUND")
	iconTexture:SetTexCoord(0.06, 0.94, 0.06, 0.94)
	iconTexture:SetAllPoints(button)
	
	--normal, pushed, highlight textures
--[[
	local normalTexture = button:CreateTexture(name .. "NormalTexture")
	normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
	--normalTexture:SetHeight(self.db.profile.size)
	--normalTexture:SetWidth(self.db.profile.size)
	normalTexture:SetAllPoints(button)
	--normalTexture:SetPoint("CENTER", button, "CENTER",0,-1)
	--]]
	local pushedTexture = button:CreateTexture(name .. "PushedTexture")
	pushedTexture:SetTexture("Interface\\Buttons\\UI-Quickslot-Depress")
	pushedTexture:SetBlendMode("ADD")
	--pushedTexture:SetHeight(self.db.profile.size)
	--pushedTexture:SetWidth(self.db.profile.size)
	pushedTexture:SetAllPoints(button)
	--pushedTexture:SetPoint("CENTER", button, "CENTER")
	
	local highlightTexture = button:CreateTexture(name .. "HighlightTexture")
	highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
	highlightTexture:SetBlendMode("ADD")
	--highlightTexture:SetHeight(self.db.profile.size)
	--highlightTexture:SetWidth(self.db.profile.size)
	highlightTexture:SetAllPoints(button)
	--highlightTexture:SetPoint("CENTER", button, "CENTER")

	button:SetNormalTexture(normalTexture)
	button:SetPushedTexture(pushedTexture)
	button:SetHighlightTexture(highlightTexture)


	--hotkey
	local hotkey = button:CreateFontString(name .. "HotKey", "ARTWORK")
	hotkey:SetFontObject(NumberFontNormalSmallGray)
	hotkey:SetFont("NumberFontNormalSmallGray", floor(self.db.profile.textsize/2))
	--hotkey:SetPoint("TOPRIGHT", button, "TOPRIGHT", 2, -2)
	hotkey:SetJustifyH("RIGHT")
	hotkey:SetJustifyV("TOP")
	hotkey:SetAllPoints(button)
--	hotkey:SetWidth(self.db.profile.size)
--	hotkey:SetHeight(floor(self.db.profile.textsize/2))
	hotkey:Hide();
	
	--count
	local count = button:CreateFontString(name .. "Count", "ARTWORK")
	count:SetFontObject(NumberFontNormalSmallGray)
	count:SetFont("NumberFontNormalSmallGray", floor(self.db.profile.textsize/2))
	count:SetJustifyH("RIGHT")
	count:SetJustifyV("BOTTOM")
	count:SetAllPoints(button)
--	count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, 2)
--	count:SetJustifyH("RIGHT")
--	count:SetWidth(self.db.profile.size)
--	count:SetHeight(floor(self.db.profile.textsize/2))
	count:Hide();
	
	--cooldown model
	local cooldown = CreateFrame("Model", name .. "Cooldown", button, "CooldownFrameTemplate")
	cooldown:SetAllPoints(button)

	--cooldown text
	local counttext = button:CreateFontString(name .. "CoolDownText", "OVERLAY")
	counttext:SetFontObject(NumberFontNormal)
	counttext:SetPoint("CENTER", button, "CENTER")
	counttext:SetJustifyH("CENTER")
	counttext:SetWidth(self.db.profile.size)
	counttext:SetHeight(self.db.profile.textsize)
	counttext:Hide()
	
	--setup the button scripts and mouse buttons
	button:EnableMouse(true)
	button:SetScript('OnEnter', function() XAD:SetTooltip() end)
	button:SetScript('OnLeave', function()  this.updateTooltip = nil GameTooltip:Hide() end)
	button:RegisterForClicks('LeftButtonUp','RightButtonUp','MiddleButtonUp','Button4Up','Button5Up')
	button:RegisterForDrag("LeftButton", "RightButton");

	button:SetScript('OnClick', function() XAD:OnClick(arg1) end )
	button:SetScript('OnDragStart', function()
			-- if the shift key is pressed then clear the action from the button
			if ( IsShiftKeyDown() ) then 
				XAD.db.profile.buttons[this:GetID()] = nil
				XAD.Buttons[this:GetID()].module = nil 
				getglobal(this:GetName().."PushedTexture"):Hide()
				this:Hide()				
			end 
		end)
	button:SetScript('OnReceiveDrag', function()
			--if the cursor has an item or psell and we have tracked its info then update the button use the item on the cursor
			XAD:UpdateButtonWithCursor(this:GetID())
		end)
	-- return the button
	return button
end

function XAD:ChangButtonSize(size)
	for i=1, self.Constants.maxbuttons do
		self.Buttons[i]:SetHeight(size)
		self.Buttons[i]:SetWidth(size)
		getglobal("XADButton"..i.."HotKey"):SetWidth(size)
		getglobal("XADButton"..i.."Count"):SetWidth(size)
		getglobal("XADButton"..i.."Cooldown"):SetWidth(size)
	end
	self:PositionButtons()
end

function XAD:ChangeFontSize(size)
	for i=1, self.Constants.maxbuttons do
		local fontName, _, _ = getglobal("XADButton"..i.."HotKey"):GetFont()
		getglobal("XADButton"..i.."HotKey"):SetFont(fontName, floor(size/2))
		getglobal("XADButton"..i.."Count"):SetFont(fontName, floor(size/2))
		fontName, _, _ = getglobal("XADButton"..i.."CoolDownText"):GetFont()
		getglobal("XADButton"..i.."CoolDownText"):SetFont(fontName, size)
	end
end

function XAD:UPDATE_BINDINGS()
	for i=1, self.Constants.maxbuttons do
		local key = string.upper(GetBindingText(GetBindingKey('XADButton'..i), "XAD_"));
		--hotkeys are shortened to one letter for Alt, Ctrl, Shift, and Num Pad
		if(key) then
			key = string.gsub (key, " ", "");
			key = string.gsub (key, "ALT%-", "A");
			key = string.gsub (key, "CTRL%-", "C");
			key = string.gsub (key, "SHIFT%-", "S");
			key = string.gsub (key, "NUMPAD", "N");
			key = string.gsub (key, "BACKSPACE", "BSpc");

			--extra hotkeys
			key = string.gsub (key, "HOME", "Hm");
			key = string.gsub (key, "END", "End");
			key = string.gsub (key, "INSERT", "Ins");
			key = string.gsub (key, "DELETE", "Del");
			key = string.gsub (key, "MIDDLEMOUSE", "M3");
			key = string.gsub (key, "MOUSEBUTTON4", "M4");
			key = string.gsub (key, "MOUSEBUTTON5", "M5");
			key = string.gsub (key, "MOUSEWHEELDOWN", "MwDn");
			key = string.gsub (key, "MOUSEWHEELUP", "MwUp");
			key = string.gsub (key, "PAGEDOWN", "PgDn");
			key = string.gsub (key, "PAGEUP", "PgUp"); 
		end
			
	 	getglobal('XADButton'..i.."HotKey"):SetText(key);
	end
end

function XAD:PositionButtons()
	if self.db.profile.position then
		self.Buttons:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 
		self.db.profile.position.x/self.Buttons:GetEffectiveScale(), 
		self.db.profile.position.y/self.Buttons:GetEffectiveScale())
	else
		self.Buttons:SetPoint('CENTER', UIParent, 'CENTER')
	end
	local buttonsPerRow = self.Constants.maxbuttons/self.db.profile.rows
	--adjust the frame to accomodate all the buttons
	self.Buttons:SetWidth(self.db.profile.size*buttonsPerRow)
	self.Buttons:SetHeight(self.db.profile.size*self.db.profile.rows)
	self.Buttons.Move:SetAllPoints(self.Buttons)
	for i=1, self.Constants.maxbuttons do
		if i==1 then 
			self.Buttons[i]:SetPoint('TOPLEFT',self.Buttons,'TOPLEFT')
		--start a new row attaching the first button in the row to the first button of the previous row
		elseif math.mod(i-1,buttonsPerRow)==0 then 
			self.Buttons[i]:SetPoint('TOPLEFT',self.Buttons[i-buttonsPerRow],'BOTTOMLEFT')
		--attach each button to the right of the previous
		else 
			self.Buttons[i]:SetPoint('TOPLEFT', self.Buttons[i-1], 'TOPRIGHT')
		end
	end
end

function XAD:toggleMove(a1)
    self:LevelDebug(2, "XAD:toggleMove(%s)",a1)
	self.db.profile.locked = a1
	if a1 then
		self.Buttons.Move:EnableMouse(false)
		self.Buttons.Move:Hide()
	else
		self.Buttons.Move:EnableMouse(true)
		self.Buttons.Move:Show()
	end
end

--[[---------------------------------------------------------------------------------
			Core addon code
----------------------------------------------------------------------------------]]

function XAD:OnTick()
	-- local var to track if we need to keep the timer ticking
	local keepticking
	-- check each button for a timer
	for i=1, self.Constants.maxbuttons do
		if self.Buttons[i].RefreshDelay then
			-- check each timer set for the button
			for k,v in pairs(self.Buttons[i].RefreshDelay) do
				-- the timer has elapsed to lets remove it and update the button
				if v - GetTime() < 1 then
					table.remove(self.Buttons[i].RefreshDelay, k)
					self:UpdateButton(i)
				else
					-- keep on ticking
					keepticking = true
				end
			end
			-- if we have no timers left for the button then reclaim the table and clean up
			if table.getn(self.Buttons[i].RefreshDelay) == 0 then 
				compost:Reclaim(self.Buttons[i].RefreshDelay) 
				self.Buttons[i].RefreshDelay = nil
			end
		end
	end
	-- if there are no more delayed refreshes then stop the timer.
	if not keepticking then 
		metro:Stop("XAD_Refresh") 
	end
end

function XAD:OnCDTick(id)
	self:LevelDebug(2, "XAD:OnCDTick(%s)",id)
	local icon = getglobal("XADButton"..id.."Icon");
	local cooldown = getglobal("XADButton"..id.."CoolDownText")
	local timeleft = self.Buttons[id].Time - GetTime()
	if timeleft < 1 then
		icon:SetVertexColor(1.0, 1.0, 1.0)
		metro:Stop("XAD_ButtonTimer"..id)
--		metro:Unregister(self.Buttons[id].Timer)
		self.Buttons[id].Time = nil
--		self.Buttons[id].Timer = nil
		cooldown:SetText("")
		cooldown:Hide()
	elseif(timeleft > 60)then
		cooldown:SetText((floor(timeleft / 60)) +1)
		cooldown:Show()
	else
		cooldown:SetText(floor(timeleft))
		cooldown:Show()
	end
end

function XAD:StartCooldown(id, bag, slot)
	if GetContainerItemCooldown(bag,slot)>0 then
		self:LevelDebug(2,"item on button %s has a cooldown", id)
		if not self.Buttons[id].Timer then 
			self:LevelDebug(2,"item on button %s has a cooldown", id)
			local _, _, running metro:Status("XAD_ButtonTimer"..id)
			if not running then metro:Start("XAD_ButtonTimer"..id) end
			local st, d = GetContainerItemCooldown(bag,slot)
			self.Buttons[id].Time = st + d
		end
	end
end

function XAD:UpdateButtonWithCursor(id)
	local bag, slot, spell
	if CursorHasSpell() then
		spell = self.CursorSpell
	elseif CursorHasItem() then
		bag, slot = self.CursorItem[1], self.CursorItem[2]
	end
	if not bag and not slot and not spell then return end
	for name,module in self:IterateModules() do
		self:LevelDebug(2, "XAD:UpdateButtonWithCursor(%s) Module %s with item at bag %s, slot %s, spell", id, name, bag, slot, spell )
		local itemlink 
		if bag then itemlink = GetContainerItemLink(bag,slot) end
		if self.modules[name].ItemInList(self.modules[name], itemlink, spell) then 
			self:LevelDebug(2, "XAD:UpdateButtonWithCursor(%s) item in list %s", id, name)
			-- activate the module if needed
			if not self:IsModuleActive(name) and not module.disabled then
				self:ToggleModuleActive(name,true)
			end
			-- if the module isn't disabled then place it on the button
			if not module.disabled then
				-- save it to the DB
				self.db.profile.buttons[id] = name
				--assigne it to the button
				self.Buttons[id].module = name
				-- Update the button
				self:UpdateButton(id) 
			end
			-- we are done no need to look any further
			break 
		end
	end
	-- remove the item from the cursor
	ClearCursor()
	--clear our tracking of what the cursor has
	self.CursorItem = nil
	self.CursorSpell = nil
end

function XAD:UpdateButton(id)
	self:LevelDebug(2, "XAD:UpdateButton(%s)",id)
	local module = self.Buttons[id].module
	local icon = getglobal("XADButton"..id.."Icon")
	local count = getglobal("XADButton"..id.."Count")
	if not module then self.Buttons[id]:Hide() return end
	local bag, slot, spells, showcount = self.modules[module].ShowItem(self.modules[module])
	--if not bag then self.Buttons[id]:Hide() return end
	--local itemlink = GetContainerItemLink(bag,slot)

	local bag, slot, spells, showcount = self.modules[module]:ShowItem()
	self:LevelDebug(2, "XAD:UpdateButton bag %s slot %s  spell %s",bag, slot, spells)
	if bag and slot then
		icon:SetTexture(GetContainerItemInfo(bag,slot))
		if GetContainerItemCooldown(bag,slot)>0 then
			self:StartCooldown(id, bag, slot)
			--icon:SetVertexColor(0.4, 0.4, 0.4)
		else
			--icon:SetVertexColor(1.0, 1.0, 1.0)
		end
		if showcount then
			count:SetText(self:CountItem(bag,slot))
			count:Show()
		end
		self.Buttons[id]:Show()
		return
	elseif spells then
		-- all we need is the texture to display on the button
		local _, _, t  = self:GetSpellData(spells)
		if t then 
			icon:SetTexture(t)
			count:Hide()
			self.Buttons[id]:Show()
			return
		end
	end
	self.Buttons[id]:Hide()
end

function XAD:CountItem(b, s)
	local count = 0
	local itemlink = GetContainerItemLink(b, s)
	local _,_,sitemID = string.find(itemlink or "", "item:(%d+):%d+:%d+:%d+")
	sitemID = tonumber(sitemID)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local itemlink = GetContainerItemLink(bag, slot)
			local _,_,itemID = string.find(itemlink or "", "item:(%d+):%d+:%d+:%d+")
			itemID = tonumber(itemID)
			if sitemID == itemID then
				local _, stack = GetContainerItemInfo(bag, slot)
				count = count + stack
			end
		end
	end
	return count
end

function XAD:OnClick(button, id)
	self:LevelDebug(2, "XAD:OnClick(%s)",button)
	if not self.db.profile.locked then return end
	if not id then id = this:GetID() end
	-- if we have an item or spell on the cursor then update the button instead of using it
	if CursorHasSpell() or CursorHasItem() then self:UpdateButtonWithCursor(id) return end
	
	local module = self.Buttons[id].module
	if not module then return end
	local bag, slot, spells, trade, leftclick, rightclick, refreshdelay = self.modules[module].UseItem(self.modules[module])
	if refreshdelay then
		if not self.Buttons[id].RefreshDelay then self.Buttons[id].RefreshDelay = compost:GetTable() end
		table.insert(self.Buttons[id].RefreshDelay, GetTime() + refreshdelay)
		--self.Buttons[id].RefreshDelay = GetTime() + refreshdelay
		local _, _, running = metro:Status("XAD_Refresh")
		if not running then metro:Start("XAD_Refresh") end
	end
	self:LevelDebug(2, "module UseItem %s, %s, %s, %s, %s, %s", bag, slot, spells, trade, leftclick, rightclick)
	if button == "LeftButton" then
		if leftclick then 
			self.modules[module][leftclick](self.modules[module], bag, slot) 
		elseif bag and slot and GetContainerItemCooldown(bag,slot) == 0 then 
			self:UseItem(bag, slot)  
		end
	elseif button == "RightButton" then
		if rightclick then 
			self.modules[module][rightclick](self.modules[module], bag, slot) 
		elseif bag and trade and UnitIsPlayer("target") and UnitIsFriend("player","target") then
			self:LevelDebug(2, "XAD:starting trade")
			self:Trade(bag, slot)
		elseif spells then
			self:LevelDebug(2, "XAD:start casting SPELLCAST_CHANNEL_START")
			self:CastSpell(spells)
		end
	end
	self:UpdateButton(id)
	getglobal("XADButton"..id.."PushedTexture"):Hide()
end

function XAD:UseItem(b, s)
	if not self.db.profile.quite then
		local link = GetContainerItemLink(b,s)
		if not link then return end
		DEFAULT_CHAT_FRAME:AddMessage(L["UseItem"]..link, 1.0, 1.0, 0.5)
	end
	UseContainerItem(b, s) 
end

function XAD:Trade(bag, slot)
	if (UnitIsPlayer("target") and (UnitIsFriend("player","target"))) then
		if (not UnitCanCooperate("player", "target")) then
			-- add message "can't cooperate"
			DEFAULT_CHAT_FRAME:AddMessage(UnitName("target")..L["TradeCantCoop"], 1.0, 1.0, 0.5)
		elseif (not CheckInteractDistance("target",2)) then
			-- add message "unit too far away"
			DEFAULT_CHAT_FRAME:AddMessage(UnitName("target")..L["TradeTooFar"], 1.0, 1.0, 0.5)
		else
			-- pickup the item and drop it on the target
			PickupContainerItem(bag,slot)
			if ( CursorHasItem() ) then
				DropItemOnUnit("target")
			end
		end
	end
end


--valid params are 
--	s=spellid (number)
--	s=spell name (string)
--	s=list of spells (table of strings)
function XAD:CastSpell(s)
	local spellid
	--check for a spell id
	if type(s)=='number' then 
		spellid = s
	else
		-- ok look up the spell info GetSpellDate accepts a string or table of strings
		spellid, _, _  = self:GetSpellData(s) 
	end
	self:LevelDebug(2, "Found spell %s", spellid)

	--if we didn't find a spell id there is nothing else we can do
	if not spellid then 
		return 
	end
	-- cast the spell
	CastSpell(spellid, "spell")
	--self cast if spell is left on targeting cursor
	if ( SpellIsTargeting() ) then
		SpellTargetUnit("player")
	end
end

--valid input is a spell name or a table of sting holding spell names
--note the highest rank of the first spell found in the table will be returned
function XAD:GetSpellData(s)
	local spellid, spellname
	if type(s)=='table' then
		-- if we have a table of spells then loop through till we find a spell the user doesn't have
		-- and use the last one we successfuly found
		for _, sp in s do
			if sp ~= "" then
				self:LevelDebug(2, "Getting spell data for %s", sp)
				local sName, _, sId, _, _, _, sIdStop = SC:GetSpellData(BS[sp])
				self:LevelDebug(2, "Spell data %s %s %s", sName, sId, sIdStop)
				if sId then-- we didn't find a spell so we are done
					--if sIdStop then spellid = sIdStop else spellid = sId end -- use the spellid or it's end point ie highest rank
					spellid = sIdStop or sId -- use the spellid or it's end point ie highest rank
					spellname = sName
					break
				end
			end
		end
		if not spellname then return end
	elseif type(s)=='string' then
		local sName, _, sId, _, _, _, sIdStop = SC:GetSpellData(BS[s])
		if not sId then return end -- we didn't find a spell so we are done
		--if sIdStop then spellid = sIdStop else spellid = sId end -- use the spellid or it's end point ie highest rank
		spellid = sIdStop or sId -- use the spellid or it's end point ie highest rank
		spellName = sName
	end
	return spellid, spellname, BS:GetSpellIcon(spellname)
end
