-- Copyright (c) 2005 William J. Rogers <wjrogers@gmail.com>
-- This file is released under the terms of the GNU General Public License v2

-- bindings
BINDING_HEADER_GBARS = "GBars"

-- SecondBar
BINDING_NAME_GACTIONBUTTON13 = "SecondBar 1"
BINDING_NAME_GACTIONBUTTON14 = "SecondBar 2"
BINDING_NAME_GACTIONBUTTON15 = "SecondBar 3"
BINDING_NAME_GACTIONBUTTON16 = "SecondBar 4"
BINDING_NAME_GACTIONBUTTON17 = "SecondBar 5"
BINDING_NAME_GACTIONBUTTON18 = "SecondBar 6"
BINDING_NAME_GACTIONBUTTON19 = "SecondBar 7"
BINDING_NAME_GACTIONBUTTON20 = "SecondBar 8"
BINDING_NAME_GACTIONBUTTON21 = "SecondBar 9"
BINDING_NAME_GACTIONBUTTON22 = "SecondBar 10"
BINDING_NAME_GACTIONBUTTON23 = "SecondBar 11"
BINDING_NAME_GACTIONBUTTON24 = "SecondBar 12"

-- Extra1 
BINDING_NAME_GACTIONBUTTON37 = "Extra1 1" 
BINDING_NAME_GACTIONBUTTON38 = "Extra1 2" 
BINDING_NAME_GACTIONBUTTON39 = "Extra1 3" 
BINDING_NAME_GACTIONBUTTON40 = "Extra1 4" 
BINDING_NAME_GACTIONBUTTON41 = "Extra1 5" 
BINDING_NAME_GACTIONBUTTON42 = "Extra1 6" 
BINDING_NAME_GACTIONBUTTON43 = "Extra1 7" 
BINDING_NAME_GACTIONBUTTON44 = "Extra1 8" 
BINDING_NAME_GACTIONBUTTON45 = "Extra1 9" 
BINDING_NAME_GACTIONBUTTON46 = "Extra1 10" 
BINDING_NAME_GACTIONBUTTON47 = "Extra1 11" 
BINDING_NAME_GACTIONBUTTON48 = "Extra1 12"

-- Extra2 
BINDING_NAME_GACTIONBUTTON49 = "Extra2 1" 
BINDING_NAME_GACTIONBUTTON50 = "Extra2 2" 
BINDING_NAME_GACTIONBUTTON51 = "Extra2 3" 
BINDING_NAME_GACTIONBUTTON52 = "Extra2 4" 
BINDING_NAME_GACTIONBUTTON53 = "Extra2 5" 
BINDING_NAME_GACTIONBUTTON54 = "Extra2 6" 
BINDING_NAME_GACTIONBUTTON55 = "Extra2 7" 
BINDING_NAME_GACTIONBUTTON56 = "Extra2 8" 
BINDING_NAME_GACTIONBUTTON57 = "Extra2 9" 
BINDING_NAME_GACTIONBUTTON58 = "Extra2 10" 
BINDING_NAME_GACTIONBUTTON59 = "Extra2 11" 
BINDING_NAME_GACTIONBUTTON60 = "Extra2 12"

-- Extra3 
BINDING_NAME_GACTIONBUTTON61 = "Extra3 1" 
BINDING_NAME_GACTIONBUTTON62 = "Extra3 2" 
BINDING_NAME_GACTIONBUTTON63 = "Extra3 3" 
BINDING_NAME_GACTIONBUTTON64 = "Extra3 4" 
BINDING_NAME_GACTIONBUTTON65 = "Extra3 5" 
BINDING_NAME_GACTIONBUTTON66 = "Extra3 6" 
BINDING_NAME_GACTIONBUTTON67 = "Extra3 7" 
BINDING_NAME_GACTIONBUTTON68 = "Extra3 8" 
BINDING_NAME_GACTIONBUTTON69 = "Extra3 9" 
BINDING_NAME_GACTIONBUTTON70 = "Extra3 10" 
BINDING_NAME_GACTIONBUTTON71 = "Extra3 11" 
BINDING_NAME_GACTIONBUTTON72 = "Extra3 12"

-- Extra4
BINDING_NAME_GACTIONBUTTON25 = "Extra4 1"
BINDING_NAME_GACTIONBUTTON26 = "Extra4 2"
BINDING_NAME_GACTIONBUTTON27 = "Extra4 3"
BINDING_NAME_GACTIONBUTTON28 = "Extra4 4"
BINDING_NAME_GACTIONBUTTON29 = "Extra4 5"
BINDING_NAME_GACTIONBUTTON30 = "Extra4 6"

-- Extra5 
BINDING_NAME_GACTIONBUTTON31 = "Extra5 1"
BINDING_NAME_GACTIONBUTTON32 = "Extra5 2"
BINDING_NAME_GACTIONBUTTON33 = "Extra5 3"
BINDING_NAME_GACTIONBUTTON34 = "Extra5 4"
BINDING_NAME_GACTIONBUTTON35 = "Extra5 5"
BINDING_NAME_GACTIONBUTTON36 = "Extra5 6"
 
-- local vars
local old_ActionButton_GetPagedID
local old_ActionButton_OnEvent
local old_Doll_OnLoad

-- saved vars
GBars_State = {}

-- save myself some typing
function msg (txt)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(txt)
	end
end

function GMovableHandle_OnLoad()
	this:RegisterForDrag("LeftButton")
	this:RegisterForClicks("RightButtonUp")
	this:GetParent().locked = 1
end

function GMovableHandle_OnClick()
	local bar = this:GetParent()
	bar.rows, bar.cols = bar.cols, bar.rows
	if bar.vertical then
		GBars_LayoutHorizontal(bar)
	else
		GBars_LayoutVertical(bar)
	end
end

function GBarsButton_OnLoad()
	if this:GetID() > 12 then
		this.isGBar = 1
	end
	ActionButton_OnLoad()
end

function GBarsButton_OnEvent()
	if (event == "UPDATE_BINDINGS" and this.isGBar) then
		GActionButton_UpdateBindings()
	else
		ActionButton_OnEvent(event)
	end
end

function GMainBar_OnLoad()
	GBars_InitBar(this, "GActionButton", 1, 12, 8, 4)
end

function GSecondBar_OnLoad()
	GBars_InitBar(this, "GActionButton", 13, 24, 8, 43)
end

function GExtraBar1_OnLoad()
	GBars_InitBar(this, "GActionButton", 37, 48, 8, 83)
end

function GExtraBar2_OnLoad()
	GBars_InitBar(this, "GActionButton", 49, 60, 8, 123)
end

function GExtraBar3_OnLoad()
	GBars_InitBar(this, "GActionButton", 61, 72, 8, 163)
end

function GExtraBar4_OnLoad()
	GBars_InitBar(this, "GActionButton", 25, 30, 8, 203)
end

function GExtraBar5_OnLoad()
	GBars_InitBar(this, "GActionButton", 31, 36, 490, 203)
end

function GBars_InitBar(bar, basename, first, last, dock_x, dock_y)
	bar.basename = basename
	bar.first, bar.last = first, last
	bar.rows, bar.cols = 1, last - first + 1
	bar.Dock = function(this)
		this:ClearAllPoints()
		this:SetPoint("BOTTOMLEFT", "$parent", "BOTTOMLEFT", dock_x, dock_y)
		GBars_LayoutHorizontal(this)
	end
end

function GBars_OnLoad()
	-- hide the default xp bar
	-- this also kills the whole MainMenuBarArtFrame, which they made a child
	-- of the MainMenuExpBar for some unfathomable reason, including the
	-- minibar, lagbar, and bag bar
	if (MainMenuExpBar) then
		MainMenuExpBar_Update = function() end
		MainMenuExpBar:UnregisterEvent("PLAYER_XP_UPDATE")
	end
	if (MainMenuBar) then
		MainMenuBar:Hide()
	end

	-- also lose the exhaustion tick, for some reason it's separate
	if (ExhaustionTick) then
		ExhaustionTick:UnregisterEvent("PLAYER_XP_UPDATE");
		ExhaustionTick:UnregisterEvent("UPDATE_EXHAUSTION");
		ExhaustionTick:UnregisterEvent("PLAYER_LEVEL_UP");
		ExhaustionTick:UnregisterEvent("PLAYER_UPDATE_RESTING");
		ExhaustionTick:UnregisterEvent("PLAYER_ENTERING_WORLD");
		ExhaustionTick_Update = function() end
		ExhaustionTick:Hide()
	end

	-- hook the ActionButton_GetPagedID function to override paging on our extra buttons
	old_ActionButton_GetPagedID = ActionButton_GetPagedID
	ActionButton_GetPagedID = GBars_GetPagedID

	-- hook the action button event handler because it sucks
	old_ActionButton_OnEvent = ActionButton_OnEvent
	ActionButton_OnEvent = function(event)
		if (event == "UPDATE_BONUS_ACTIONBAR") then
			ActionButton_Update()
		else
			old_ActionButton_OnEvent(event)
		end
	end

	-- Replace the standard button keybinding handler
	ActionButtonDown = GActionButtonDown
	ActionButtonUp = GActionButtonUp

	-- register for events
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- set our default dock method
	this.Dock = function(this)
		this:ClearAllPoints()
		this:SetPoint("BOTTOM", "$parent")
	end

	-- list of bars that are handled by this mod
	this.bars = {}
	this.bars["mainbar"] = "GMainBar"
	this.bars["secondbar"] = "GSecondBar"
	this.bars["bags"] = "GBagBar"
	this.bars["extra1"] = "GExtraBar1"
	this.bars["extra2"] = "GExtraBar2"
	this.bars["extra3"] = "GExtraBar3"
	this.bars["extra4"] = "GExtraBar4"
	this.bars["extra5"] = "GExtraBar5"
	this.bars["pet"] = "GPetActionBar"
	this.bars["shape"] = "GShapeshiftBar"
	this.bars["options"] = "GMicroButtons"
	this.bars["xp"] = "GXPBar"

	-- show a welcome message
	msg("GBars Loaded")

	-- register the chat command
	SlashCmdList["GBARS"] = GBars_Command
	SLASH_GBARS1 = "/gbars"
	SLASH_GBARS2 = "/gb"
	
end

-- handle events
function GBars_OnEvent()
	if (event == "VARIABLES_LOADED") then
		GBars_LoadState()
	elseif (event == "UNIT_NAME_UPDATE") then
		local player_name = UnitName("player")
		if (player_name and player_name ~= UNKNOWNOBJECT) then
			this:UnregisterEvent("UNIT_NAME_UPDATE")
			GBars_LoadState()
		end
	end
end

-- load the addon config from the saved variable
function GBars_LoadState()
	-- get the player's name - watch out for UNKNOWNOBJECT!
	local player_name = UnitName("player")
	if (not player_name or player_name == UNKNOWNOBJECT) then
		this:RegisterEvent("UNIT_NAME_UPDATE")
		return
	end
	g_player_name = player_name .. " of " .. GetCVar("RealmName")

	-- init the state from the saved variable
	local state = GBars_State[g_player_name]
	if (not state) then state = {} end

	-- perform AutoBar init stuff if it's enabled
	if (GBars_State["auto_disable"] ~= 1) then
		GAutoBar_Init()
	else
		GBars_Hide(GAutoBar)
	end

	-- restore bar settings
	for key, bar_name in pairs(this.bars) do
		local bar = getglobal(bar_name)
		if (type(state[bar_name]) == "table") then
			-- orientation
			if (state[bar_name]["vertical"] == 1) then
				GBars_LayoutVertical(bar)
				getglobal(bar:GetName().."Handle"):SetChecked(1) -- set red drag button
			else
				GBars_LayoutHorizontal(bar)
			end

			-- hide/show
			if (state[bar_name]["hidden"] == 1) then
				GBars_Hide(bar)
			end
			-- scale
			scale = (state[bar_name]["scale"])
			if scale then
				GBars_Scale(bar_name, scale)
			end
		end
	end

	-- make sure the pet and shape bars get positioned properly (scaling workaround)
	if (not GShapeshiftBar:IsUserPlaced()) then GShapeshiftBar:Dock() end
	if (not GPetActionBar:IsUserPlaced()) then GPetActionBar:Dock() end

	-- init the xp bar
	GBars_XPUpdate()
end

-- save some data to the saved state
function GBars_SaveState(data)
	if (not g_player_name) then return end
	if (not GBars_State[g_player_name]) then
		GBars_State[g_player_name] = {}
	end
	RecursiveMerge(GBars_State[g_player_name], data)
end

-- merge some values into a table
function RecursiveMerge(target, source)
	for key, val in pairs(source) do
		if (target[key] and type(target[key]) == "table" and type(val) == "table") then
			RecursiveMerge(target[key], val)
		else
			target[key] = val
		end
	end
end

-- handle slash commands
function GBars_Command(cmd)
	bits = {}
	for w in string.gfind(cmd, "%w+") do
		table.insert(bits, w)
	end
	-- this is a little more complicated than I would like right now, but eh
	if (cmd == "reset" or cmd == "dock") then
		GBars_Dock(GBars)
		for key, barname in pairs(GBars.bars) do GBars_Lock(getglobal(barname)) end
		for key, barname in pairs(GBars.bars) do getglobal(barname):Dock() end
		for key, barname in pairs(GBars.bars) do GBars_Show(getglobal(barname)) end
	elseif (cmd == "lock") then
		GBars_Lock(GBars)
		for key, barname in pairs(GBars.bars) do GBars_Lock(getglobal(barname)) end
	elseif (cmd == "unlock") then
		GBars_Unlock(GBars)
		for key, barname in pairs(GBars.bars) do GBars_Unlock(getglobal(barname)) end
	elseif (cmd == "help") then
		msg("|cffffff00GBars Help")
		msg("/gbars lock - lock all bars in place")
		msg("/gbars unlock - unlock all bars for dragging")
		msg("/gbars reset - dock all bars in their default locations")
		msg(" ")
		msg("/gbars auto [ enable | disable ] - toggle GAutoBar (account-wide)")
		msg(" ")
		msg("/gbars <barname> lock - lock one bar in place")
		msg("/gbars <barname> unlock - unlock one bar for dragging")
		msg("/gbars <barname> reset - dock one bar in default position")
		msg("/gbars <barname> hide - hide a bar from view")
		msg("/gbars <barname> show - unhide a bar")
		msg("(where <barname> is one of mainbar, secondbar, extra1-5, shape, pet, bags, options, xp, auto)")
		msg(" ")
		msg("Right-click the green drag handle when a bar is unlocked to flip it vertical.")
	elseif (bits[1] == "auto" and bits[2] == "disable") then
		GBars_State["auto_disable"] = 1
		GAutoBar_Disable()
		GBars_Hide(GAutoBar)
	elseif (bits[1] == "auto" and bits[2] == "enable") then
		GBars_State["auto_disable"] = 0
		GAutoBar_Init()
		GBars_Show(GAutoBar)
	elseif (GBars.bars[bits[1]]) then
		bar = getglobal(GBars.bars[bits[1]])
		if (bits[2] == "lock") then
			GBars_Lock(bar)
		elseif (bits[2] == "unlock") then
			GBars_Unlock(bar)
		elseif (bits[2] == "reset" or bits[2] == "dock") then
			GBars_Lock(bar)
			GBars_Dock(bar)
		elseif (bits[2] == "hide") then
			GBars_Hide(bar)
		elseif (bits[2] == "show") then
			GBars_Show(bar)
		elseif (bits[2] == "scale") then
			if (bits[4]) then
				value = bits[3].."."..bits[4]
			else
				value = bits[3]
			end
			GBars_Scale(GBars.bars[bits[1]],value)
		else
			msg(RED_FONT_COLOR_CODE.."GBars did not understand '"..cmd.."'")
			msg(RED_FONT_COLOR_CODE.."Type "..HIGHLIGHT_FONT_COLOR_CODE.."/gbars help "..RED_FONT_COLOR_CODE.."for help.")
		end
	elseif
		(bits[1] == "menu") then GBConfig:Show()
	else
		GBConfig:Show()
	end
end

-- Scaling
function GBars_Scale(barname, value)

	if (barname == "GMainBar") then
		GMainBar:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GSecondBar") then
		GSecondBar:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GExtraBar1") then
		GExtraBar1:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GExtraBar2") then
		GExtraBar2:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GExtraBar3") then
		GExtraBar3:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GExtraBar4") then
		GExtraBar4:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GExtraBar5") then
		GExtraBar5:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GShapeshiftBar") then
		GShapeshiftBar:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GPetActionBar") then
		GPetActionBar:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GBagBar") then
		GBagBar:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GMicroButtons") then
		GMicroButtons:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GXPBar") then
		GXPBar:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
		
	elseif (barname == "GAutoBar") then
		GAutoBar:SetScale(value)
		GBars_SaveState({ [barname] = { scale = value } })
	end
end

-- lock a window so it is unmovable
function GBars_Lock(frame)
	if (not frame) then frame = this; end
	if (frame.locked) then return end
	GBars_HideHandle(frame)
	GBars_HideGrid(frame)
	frame.locked = 1
end

-- unlock a window so it is movable
function GBars_Unlock(frame)
	if (not frame) then frame = this; end
	if (not frame.locked) then return end
	GBars_ShowHandle(frame)
	GBars_ShowGrid(frame)
	frame.locked = nil
end

-- dock (and lock) a frame at its current dock point
function GBars_Dock(frame)
	if (not frame) then frame = this; end
	GBars_Lock(frame)
	frame:Dock()
end

-- if the passed-in frame has a handle, show it
function GBars_ShowHandle(frame)
	handle = getglobal(frame:GetName().."Handle")
	if (handle) then
		handle:SetScale(0.6)
		handle:Show()
	end
end

-- if the passed-in frame has a handle, hide it
function GBars_HideHandle(frame)
	handle = getglobal(frame:GetName().."Handle")
	if (handle) then
		handle:Hide()
	end
end

-- start dragging if not locked
function GBars_DragStart(frame)
	if (not frame) then frame = this; end
	if (not frame.locked) then
		frame.isMoving = 1
		frame:StartMoving()
	end
end

-- end dragging
function GBars_DragStop(frame)
	if (not frame) then frame = this; end
	frame:StopMovingOrSizing()
	frame.isMoving = nil
end

-- display empty buttons on a frame
function GBars_ShowGrid(bar)
	if (bar:GetName() == "GPetActionBar") then
		GPetActionBar_ShowGrid()
	elseif (bar:GetName() == "GShapeshiftBar") then
		return
	elseif (bar:GetName() == "GAutoBar") then
		for i = bar.first, bar.last do
			getglobal(bar.basename..i):Show()
		end
	elseif (not bar.basename) then
		return
	else
		for i = bar.first, bar.last do
			curr = getglobal(bar.basename..i)
			ActionButton_ShowGrid(curr)
		end
	end
end

-- hide empty buttons on a frame
function GBars_HideGrid(bar)
	if (bar:GetName() == "GPetActionBar") then
		GPetActionBar_HideGrid()
	elseif (bar:GetName() == "GShapeshiftBar") then
		return
	elseif (bar:GetName() == "GAutoBar") then
		for i = bar.first, bar.last do
			curr = getglobal(bar.basename..i)
			if (not curr.bag) then curr:Hide() end
		end
	elseif (not bar.basename) then
		return
	else
		for i = bar.first, bar.last do
			curr = getglobal(bar.basename..i)
			ActionButton_HideGrid(curr)
		end
	end
end

-- arrange a series of buttons as a horizontal bar
function GBars_LayoutHorizontal(bar)
	if (not bar.basename) then return end
	for i = bar.first + 1, bar.last do
		curr = getglobal(bar.basename..i)
		last = getglobal(bar.basename..(i - 1))
		curr:ClearAllPoints()
		curr:SetPoint("LEFT", last:GetName(), "RIGHT", 3, 0)
	end
	bar.vertical = nil
	GBars_SaveState({ [bar:GetName()] = { vertical = 0 } })
end

-- arrange a series of buttons as a vertical bar
function GBars_LayoutVertical(bar)
	if (not bar.basename) then
		getglobal(bar:GetName().."Handle"):SetChecked(nil)
		return
	end
	for i = bar.first + 1, bar.last do
		curr = getglobal(bar.basename..i)
		last = getglobal(bar.basename..(i - 1))
		curr:ClearAllPoints()
		curr:SetPoint("TOP", last:GetName(), "BOTTOM", 0, -3)
	end
	bar.vertical = 1
	GBars_SaveState({ [bar:GetName()] = { vertical = 1 } })
end

-- hide a bar from view
function GBars_Hide(bar)
	bar:Hide()
	bar.hidden = 1
	GBars_SaveState({ [bar:GetName()] = { hidden = 1 } })
end

-- display a bar
function GBars_Show(bar)
	bar:Show()
	bar.hidden = nil
	GBars_SaveState({ [bar:GetName()] = { hidden = 0 } })
end

function GBars_GetPagedID(button)
	local offset = GetBonusBarOffset()

	if (button.isGBar) then
		return button:GetID()
	elseif (button:GetParent():GetName() == "MultiBarLeft") then
		return button:GetID() + (LEFT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS
	elseif (button:GetParent():GetName() == "MultiBarRight") then
		return button:GetID() + (RIGHT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS
	elseif (offset > 0 and CURRENT_ACTIONBAR_PAGE == 1) then
		return button:GetID() + (NUM_ACTIONBAR_PAGES + offset - 1) * NUM_ACTIONBAR_BUTTONS
	else
		return button:GetID() + (CURRENT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS
		-- return old_ActionButton_GetPagedID(button)
	end
end

function GActionButtonDown(id)
	local button = getglobal("GActionButton"..id)
	if (button:GetButtonState() == "NORMAL") then
		button:SetButtonState("PUSHED")
	end
end

function GActionButtonUp(id, onSelf)
	local button = getglobal("GActionButton"..id)
	if (button:GetButtonState() == "PUSHED") then
		button:SetButtonState("NORMAL")
		-- apparently this is to save the macro being edited before performing another action
		if (MacroFrame_SaveMacro) then
			MacroFrame_SaveMacro()
		end
		UseAction(ActionButton_GetPagedID(button), 0, onSelf)
		if (IsCurrentAction(ActionButton_GetPagedID(button))) then
			button:SetChecked(1)
		else
			button:SetChecked(0)
		end
	end
end

function GActionButton_UpdateBindings(name)
	if (not name) then
		name = this:GetName()
	end
	local hotkey = getglobal(this:GetName().."HotKey")
	local text = GetBindingText(GetBindingKey(name), "KEY_")

	-- list of substitutions happily lifted from Telo's BottomBar, with a few new additions
	text = string.gsub(text, "CTRL%-", "C-")
	text = string.gsub(text, "ALT%-", "A-")
	text = string.gsub(text, "SHIFT%-", "S-")
	text = string.gsub(text, "Num Pad", "NP")
	text = string.gsub(text, "Backspace", "Bksp")
	text = string.gsub(text, "Spacebar", "Space")
	text = string.gsub(text, "Page", "Pg")
	text = string.gsub(text, "Down", "Dn")
	text = string.gsub(text, "Arrow", "")
	text = string.gsub(text, "Insert", "Ins")
	text = string.gsub(text, "Delete", "Del")
	text = string.gsub(text, "Mouse Button", "MB")
	
	hotkey:SetText(text)
end

function GBagBar_OnLoad()
	local buttons = { CharacterBag3Slot, CharacterBag2Slot, CharacterBag1Slot, CharacterBag0Slot, MainMenuBarBackpackButton }

	-- change the parent of each default bag button to GBagBar and arrange them
	local last = nil
	local keyring = 1

	if keyring == 1 then
		KeyRingButton:SetParent(GBagBar)
		KeyRingButton:ClearAllPoints()
		KeyRingButton:SetPoint("TOPLEFT", GBagBar, "TOPLEFT", 0, 0)
		KeyRingButton:Show()

		last = KeyRingButton

	end 

	for i, button in ipairs(buttons) do
		button:SetParent(GBagBar)
		button:ClearAllPoints()
		if last then
			button:SetPoint("LEFT", last, "RIGHT", 2, 0)
		else
			button:SetPoint("TOPLEFT", GBagBar, "TOPLEFT", 0, 0)
		end
		button:Show()

		last = button
	end
	
	-- set our default dock method
	this.Dock = function(this)
		this:ClearAllPoints()
		this:SetPoint("BOTTOMRIGHT", "$parent")
	end
end


-- update the size of the xp bar texture
function GBars_XPUpdate()
	GXPBarFill:SetHeight(GXPBarBack:GetHeight() * UnitXP("player") / UnitXPMax("player"))
	if (GetXPExhaustion()) then
		GXPBarFill:SetVertexColor(0.0, 1.0, 0.0)
	else
		GXPBarFill:SetVertexColor(0.4, 0.7, 1.0)
	end
end

function GXPBar_OnLoad()
	this:RegisterEvent("PLAYER_XP_UPDATE")
	this:RegisterEvent("PLAYER_UPDATE_RESTING")
	this:RegisterEvent("UPDATE_EXHAUSTION")
	this.Dock = function(this)
		this:ClearAllPoints()
		this:SetPoint("BOTTOMLEFT", "$parent", "BOTTOMLEFT", 477, 3)
	end
end

function GXPBar_OnEnter()
	GXPBar_ShowTooltip()
end

function GXPBar_OnLeave()
	GameTooltip:Hide()
end

-- update xp bar
function GXPBar_OnEvent()
	GBars_XPUpdate()
end

-- show the xp tooltip
function GXPBar_ShowTooltip()
	-- anchor and set XP % text
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
	GameTooltip:SetText("XP "..format("%3.1f", 100 * UnitXP("player") / UnitXPMax("player")).."%")
	
	local rate_in, rate_out, latency = GetNetStats()
	--GameTooltip:AddLine("Ping: "..latency, 0.6, 0.6, 1.0)
	
	GameTooltip:AddDoubleLine("Current: "..UnitXP("player").." / "..UnitXPMax("player"), "Ping: "..latency, 1.0, 1.0, 1.0, 0.6, 0.6, 1.0)
	GameTooltip:AddDoubleLine("Remainder: "..UnitXPMax("player") - UnitXP("player").." XP", format("%3.2f", 20 - (100 * UnitXP("player") / UnitXPMax("player"))/5).." Bars", 1.0, 1.0, 1.0, 0.6, 0.6, 1.0)
	
	-- add rest state line if rested
	if (GetXPExhaustion()) then
	-- Add a blank line to seperate
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine("Rested for "..GetXPExhaustion().." XP", format("%3.2f", 100 * GetXPExhaustion() / UnitXPMax("player")).." %",0.0, 1.0, 0.0, 0.0, 1.0, 0.0)
	end
	
	-- Rep Info if selected
	if (GetWatchedFactionInfo()) then

		local factionName, standing, min, max, value = GetWatchedFactionInfo()
		
		-- Add a blank line to seperate
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(factionName)
		GameTooltip:AddDoubleLine(FindRep(standing), (value-min).."/"..(max-min).." ("..format("%3.1f", 100 * (value-min)/(max-min)).." %)")
	
	end

	-- show it!
	GameTooltip:Show()
end

function FindRep(standing)
	local replvl
		--Find the Current rep lvl
		if ( standing == 0 ) then
			replvl = "UNKNOWN"; -- unknown
		elseif ( standing == 1 ) then
			replvl = "Hated"; -- hated
		elseif ( standing == 2) then
			replvl = "Hostile"; -- hostile
		elseif ( standing == 3) then
			replvl = "Unfriendly"; -- unfriendly
		elseif ( standing == 4) then
			replvl = "Neutral"; -- neutral
		elseif ( standing == 5) then
			replvl = "Friendly"; -- friendly
		elseif ( standing == 6) then
			replvl = "Honored"; -- honored
		elseif ( standing == 7) then
			replvl = "Revered"; -- revered
		elseif ( standing == 8) then
			replvl = "Exalted"; -- exalted
		end
	return replvl
end


-- Config Menu Stuff
function GBars_IsLocked(barname)
	
	local status = nil
	if (barname.locked) then
		status = 1
	else
		status = 0
	end
	
	return status
end

function GBars_IsVisible(barname)

	local status = nil
	if (barname.hidden == 1) then
		status = 0
	else
		status = 1
	end

	return status
end