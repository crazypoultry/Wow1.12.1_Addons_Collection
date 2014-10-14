--[[
	 << zBar >>
	 Zero's Action Bar.
	 炽火动作条 - 感受燃烧的快感！
	 Written by 炽火 Zero ℃ from Beijing, China
	 You may not use this work for commercial purposes.
	 CopyRight © 2005-2006 炽火 Zero ℃ (Zero Fire). Some rights reserved.
--]]
ZBAR_VERSION = GetAddOnMetadata("zBar", "Version")
ZBAR_AUTHOR  = GetAddOnMetadata("zBar", "Author")

------------------------------------
--~ constances
ZBARS = {"zBar1","zBar2","zBar3","zBar4",[9]="zBar9"}

-- var for warrior class, will be valued when init
ZBAR_IS_WARRIOR = nil

-- [[ Debug ]] --
local zIsDebug = true
function zDebug(msg, r, g, b) if zIsDebug then DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b) end end

-- [[ Default Options ]] --
function zGetDefaultBar()
	return {num = 12, inset = 0, arrangement = "line", linenum = 2}
end
--[[
	 < UpdateX >
	 global functions, call for update
--]]
-- [[ buttons ]] --
function zBar_UpdateButtons(bar,from,to,showGrid)
	if (not bar or not bar:IsShown()) then return end
	local button
	local value = zBar.Bars[bar:GetID()]
	from = from or value.from or 1
	to = to or value.max or NUM_ACTIONBAR_BUTTONS
	local num = value.num or 1
	if (value.from) then num = num + value.from - 1 end
	for i=from,to do
		button = getglobal(ZBARS[bar:GetID()].."Button"..i)
		if i <= num and not value.minimized then
			button.hide = nil
			if bar:GetID()<=10 then
				if ( ALWAYS_SHOW_MULTIBARS == "1" or ALWAYS_SHOW_MULTIBARS == 1) then
					ActionButton_ShowGrid(button)
				else
					ActionButton_HideGrid(button)
				end
				if (showGrid == 1) then
					ActionButton_ShowGrid(button)
				elseif (showGrid == 0) then
					ActionButton_HideGrid(button)
				end
			else
				button:Show()
			end
		else
			button:Hide()
			button.hide = 1
		end
	end
end
-- [[ arrangement ]] --
function zBar_UpdateArrangement(bar)
	 -- get the button spacing
	 if not zBar.Bars[bar:GetID()].inset then
		  zBar.Bars[bar:GetID()].inset = 6
	 end
	 local value = zBar.Bars[bar:GetID()]
	 -- call function for arrangement changing
	if value.arrangement == "funny1" then
		zBar_SetFunny(bar, value.inset)
	elseif value.arrangement == "funny2" then
		zBar_SetFunny2(bar, value.inset)
	elseif value.arrangement == "line" then
		zBar_SetLineNum(bar, value.inset)
	end
	 -- auto adjust grid size, only if inset < 2
	 if bar:GetID() > 10 then return end
	 for i = 1, zBar.Bars[bar:GetID()].num or 12 do
		local texture = getglobal(ZBARS[bar:GetID()].."Button"..i)
		texture = getglobal(texture:GetName().."NormalTexture" )
		if value.inset >= 4 then
			texture:SetWidth(66)
			texture:SetHeight(66)
		else
			texture:SetWidth(60)
			texture:SetHeight(60)
		end
	 end
end
-- [[ minimize ]] --
function zBar_UpdateMinimize(bar,show,condition)
	if bar and zBar.Bars[bar:GetID()].minimized == show and not condition then
		zBar.Bars[bar:GetID()].minimized = not show or nil
		zBar_UpdateButtons(bar)
	end
end
-- [[ hotkeys ]] --
function zBar_UpdateHotkeys(bar)
	 if bar:GetID() > 10 then return end

	 local hotkey
	 for i = 1, 12 do
		-- get hotkey text object
		if bar:GetID() == 10 then
			hotkey = getglobal("ActionButton"..i.."HotKey")
		else
			hotkey = getglobal(ZBARS[bar:GetID()].."Button"..i.."HotKey")
		end
		-- hide it or update it
		if zBar.Bars[bar:GetID()].hideHotkey then
			hotkey:Hide()
		else
			hotkey:Show()
			if bar.isZBar then
				hotkey:SetText(GetBindingText(GetBindingKey("ACTIONBUTTON"..
					ActionButton_GetPagedID(getglobal(bar:GetName().."Button"..i))), "KEY_", 1))
			end
		end
	 end
end
-- [[ alpha ]] --
function zBar_SetAlpha(alpha,bar)
	if not bar then return end
	if (zBar and zBar.Bars[bar:GetID()].autoAlpha) then
		bar:SetAlpha(alpha)
		getglobal(ZBARS[bar:GetID()].."Tab"):SetAlpha(0.3)
	end
end
--[[
	 < Initialization >
	 This is the Only Function to init all bars
--]]
local function zBar_Init()
	for key in ZBARS do
		if not zBar.Bars[key] then
			zBar.Bars[key] = zGetDefaultBar()
			zBar.Bars[key].hide = true
		end
	end
	-- the great loop
	for key,value in zBar.Bars do
		-- locals
		local bar,tab,button
		if ZBARS[key] then
			bar = getglobal(ZBARS[key])
			tab = getglobal(ZBARS[key].."Tab")
		end

		if ( not bar or not tab ) then
			if bar and key == 15 then
				if (value.hide) then bar:Hide() end
			else
				-- continue if this bar no longer exist
				zBar.Bars[key] = nil
			end
		else
			-- read options
			if (value.scale) then bar:SetScale(value.scale) end
			if (value.autoPop) then zBar.Bars[key].minimized = true end
			if (value.autoAlpha) then zBar_SetAlpha(0.3, bar) end
			if (value.hideTab) then tab:Hide() end
			if (value.name) then tab:SetText(ZBAR_NAMES[key]) end
			if (value.hide) then
				bar:Hide()
			else
				bar:Show()
			end

			-- update appearance
			zBar_UpdateButtons(bar)
			zBar_UpdateArrangement(bar)
			zBar_UpdateHotkeys(bar)

			-- particular settings for action buttons
			if key <= 10 then
--~		if not IsSon(bar) then
				for i=1,12 do
					button = getglobal(ZBARS[key].."Button"..i)
					-- set button scripts
					button:SetScript("OnEnter",zActionButton_OnEnter)
					button:SetScript("OnLeave",zActionButton_OnLeave)
					button:SetScript("OnEvent",zActionButton_OnEvent)
					button:SetScript("OnShow",ActionButton_Update)
				end
--~     	end
			end
		end
	end
end
--[[
	 Frame Entrance
	 zBarFrame contains all bars, this is the main entrance of this addon
--]]
function zBarFrame_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		if not zBar or zBar.version ~= ZBAR_VERSION then
			zBar = {version = ZBAR_VERSION}
		end
		zBar.Bars = zBar.Bars or {zGetDefaultBar()}
		
		local class
		_, class = UnitClass("player")
		if class == "WARRIOR" then
			ZBAR_IS_WARRIOR = true
		end

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		zActionButton()
--~ 		if (zBar and zBar_SplitCreate) then
--~ 			for key,value in zBar.Bars do
--~ 				zBar_SplitCreate(key,value.from)
--~ 			end
--~ 		end
		zBar_Init()
		DEFAULT_CHAT_FRAME:AddMessage(
			"zBar written by "..ZBAR_AUTHOR.." Version: "..ZBAR_VERSION.." Loaded, type /zbar",0.0,1.0,0.0)
		this:UnregisterAllEvents()
	end
end
--[[
	 Bar Entrance
--]]
function zBar_OnLoad()
	this:RegisterEvent("PLAYER_REGEN_ENABLED")
	this:RegisterEvent("PLAYER_REGEN_DISABLED")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")
end
-- bar event handler, for [ auto pop mode / auto hide mode ]
local inCombat,targetEnemy
function zBar_OnEvent()
	local var = zBar.Bars[this:GetID()]
	if not var or (not var.autoPop and not var.autoHide) then return end
	local show = var.autoPop
	if event == "PLAYER_TARGET_CHANGED" then
		if UnitExists("target") and show
		  and not UnitIsFriend("player","target")
		  and not UnitIsDead("target") then
			zBar_UpdateMinimize(this,show,inCombat)
			targetEnemy = true
		else
			zBar_UpdateMinimize(this,not show or nil,inCombat)
			targetEnemy = nil
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		inCombat = true
		zBar_UpdateMinimize(this,show,targetEnemy)
	elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_LEAVING_WORLD" then
		inCombat = nil
		zBar_UpdateMinimize(this,not show or nil,targetEnemy)
	end
end
--[[
	 Tab Entrance
--]]
function zBarTab_OnLoad()
	this:RegisterForDrag("LeftButton")
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp")
end
function zBarTab_OnClick()
	local bar = this:GetParent()
	if arg1 == "LeftButton" then
		if ( zBar.Bars[bar:GetID()].minimized ) then
			zBar_UpdateMinimize(bar,true)
		else
			zBar_UpdateMinimize(bar)
		end
	end
	if not zBarOption then return end
	if zBarOption:IsVisible() then
		zBarOption:Hide()
	end
	 if arg1 == "RightButton" then
		zBarOption:OpenForBar(bar)
	end
end
function zBarTab_OnDragStart()
	if this:GetName() == "zPetBarTab" and MouseIsOver(PetActionButton1) then
		PetActionButton1:Hide()
		PetActionButton1:Show()
	end
	
	local x, y = GetCursorPosition()
	x = x / this:GetParent():GetScale() / UIParent:GetScale()
	y = y / this:GetParent():GetScale() / UIParent:GetScale()
	this:GetParent():ClearAllPoints()
	this:GetParent():SetPoint("TOP", UIParent, "BOTTOMLEFT", x, y-6)
	this:GetParent():StartMoving()
end
function zBarTab_OnDragStop()
	this:GetParent():StopMovingOrSizing()
end
--[[
	< Arrangements >
	 All functions in this part is for arrangement changing,
	 funny arrangement function is too big, so put it at the EOF
--]]
local function SetButtonPoint(bar,index,point,referIndex,relativePoint,offx,offy)
	local value = zBar.Bars[bar:GetID()]
	if(value.from) then
		index = index + value.from - 1
		referIndex = referIndex + value.from - 1
	end

	local button = getglobal(ZBARS[bar:GetID()].."Button"..index)
	button:ClearAllPoints()
	button:SetPoint(point,ZBARS[bar:GetID()].."Button"..referIndex,relativePoint,offx,offy)
end
--~ line arrangement
function zBar_SetLineNum(bar, inset)
	bar = bar or zGetCurrentBar()
	if ( not bar ) then
		return
	end

	local value = zBar.Bars[bar:GetID()]

	if not value.linenum then
		zBar.Bars[bar:GetID()].linenum = 1
	end

	-- loop to settle every button
	local cur_id
	-- row
	for i = 1, ceil(value.num/value.linenum) do
		-- column
		for j = 1, value.linenum do
			-- get current button id first
			cur_id = (i-1)*value.linenum + j
			-- break when loop out of index
			if cur_id > value.num then break end

			-- skip the first button
			if cur_id > 1 then
				-- place them one by one
				if j == 1 then
					-- first button in each line should be placed to left edge
					SetButtonPoint( bar, cur_id, "TOP", cur_id - value.linenum, "BOTTOM", 0, -inset)
				else
					-- siblings goes my right side
					SetButtonPoint( bar, cur_id, "LEFT", cur_id - 1, "RIGHT", inset, 0)
				end
			end
		end
	end
end
--[[
	 those following two function is for funny arrangement
	 ~~ ++ The Great Big Fat Ugly Chunks ++ ~~
--]]
function zBar_SetFunny(bar, inset)
	bar = bar or zGetCurrentBar()
	if ( not bar ) then
		return
	end

	local haf = inset/2
	local num = zBar.Bars[bar:GetID()].num
	if ( num == 1 ) then
		return
	elseif ( num == 2 ) then
		SetButtonPoint( bar, 2, "TOPLEFT", 1, "BOTTOMRIGHT", inset, -inset)
	elseif ( num == 3 ) then
		SetButtonPoint( bar, 2, "TOPRIGHT", 1, "BOTTOM", -haf, -inset)
		SetButtonPoint( bar, 3, "TOPLEFT", 1, "BOTTOM", haf, -inset)
	elseif ( num == 4 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
	elseif ( num == 5 ) then
		SetButtonPoint( bar, 3, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 2, "RIGHT", 3, "LEFT", -inset, 0)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "TOP", 3, "BOTTOM", 0, -inset)
	elseif ( num == 6 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 5, "LEFT", 4, "RIGHT", inset, 0)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
	elseif ( num == 7 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "TOPRIGHT", 1, "BOTTOM", -haf, -inset)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "LEFT", 4, "RIGHT", inset, 0)
		SetButtonPoint( bar, 6, "TOPLEFT", 3, "BOTTOM", haf, -inset)
		SetButtonPoint( bar, 7, "LEFT", 6, "RIGHT", inset, 0)
	elseif ( num == 8 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "LEFT", 6, "RIGHT", inset, 0)
		SetButtonPoint( bar, 8, "LEFT", 7, "RIGHT", inset, 0)
	elseif ( num == 9 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 5, "LEFT", 4, "RIGHT", inset, 0)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "TOP", 4, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 8, "LEFT", 7, "RIGHT", inset, 0)
		SetButtonPoint( bar, 9, "LEFT", 8, "RIGHT", inset, 0)
	elseif ( num == 10 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "TOPRIGHT", 1, "BOTTOM", -haf, -inset)
		SetButtonPoint( bar, 5, "LEFT", 4, "RIGHT", inset, 0)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "LEFT", 6, "RIGHT", inset, 0)
		SetButtonPoint( bar, 8, "TOPLEFT", 4, "BOTTOM", haf, -inset)
		SetButtonPoint( bar, 9, "LEFT", 8, "RIGHT", inset, 0)
		SetButtonPoint( bar, 10, "LEFT", 9, "RIGHT", inset, 0)
	elseif ( num == 11 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "TOPLEFT", 1, "BOTTOM", haf, -inset)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "LEFT", 6, "RIGHT", inset, 0)
		SetButtonPoint( bar, 8, "TOPRIGHT", 5, "BOTTOM", -haf, -inset)
		SetButtonPoint( bar, 9, "LEFT", 8, "RIGHT", inset, 0)
		SetButtonPoint( bar, 10, "LEFT", 9, "RIGHT", inset, 0)
		SetButtonPoint( bar, 11, "LEFT", 10, "RIGHT", inset, 0)
	elseif ( num == 12 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 5, "LEFT", 4, "RIGHT", inset, 0)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "TOP", 4, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 8, "LEFT", 7, "RIGHT", inset, 0)
		SetButtonPoint( bar, 9, "LEFT", 8, "RIGHT", inset, 0)
		SetButtonPoint( bar, 10, "TOP", 7, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 11, "LEFT", 10, "RIGHT", inset, 0)
		SetButtonPoint( bar, 12, "LEFT", 11, "RIGHT", inset, 0)
	end
end
function zBar_SetFunny2(bar, inset)
	bar = bar or zGetCurrentBar()
	if ( not bar ) then
		return
	end

	local haf = inset/2
	local num = zBar.Bars[bar:GetID()].num
	if ( num == 1 ) then
		return
	elseif ( num == 2 ) then
		SetButtonPoint( bar, 2, "TOPRIGHT", 1, "BOTTOMLEFT", -inset, -inset)
	elseif ( num == 3 ) then
		SetButtonPoint( bar, 2, "TOPRIGHT", 1, "BOTTOM", -haf, -inset)
		SetButtonPoint( bar, 3, "TOPLEFT", 1, "BOTTOM", haf, -inset)
	elseif ( num == 4 ) then
		SetButtonPoint( bar, 2, "TOPRIGHT", 1, "LEFT", -inset, -haf)
		SetButtonPoint( bar, 3, "TOPLEFT", 1, "RIGHT", inset, -haf)
		SetButtonPoint( bar, 4, "TOP", 1, "BOTTOM", 0, -inset)
	elseif ( num == 5 ) then
		SetButtonPoint( bar, 3, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 2, "TOPLEFT", 1, "BOTTOM", haf, -inset)
		SetButtonPoint( bar, 4, "TOPRIGHT", 2, "BOTTOM", -haf, -inset)
		SetButtonPoint( bar, 5, "TOPLEFT", 2, "BOTTOM", haf, -inset)
	elseif ( num == 6 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "TOP", 3, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
	elseif ( num == 7 ) then
		SetButtonPoint( bar, 2, "TOPRIGHT", 1, "LEFT", -inset, -haf)
		SetButtonPoint( bar, 3, "TOPLEFT", 1, "RIGHT", inset, -haf)
		SetButtonPoint( bar, 4, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 5, "TOPRIGHT", 4, "LEFT", -inset, -haf)
		SetButtonPoint( bar, 6, "TOPLEFT", 4, "RIGHT", inset, -haf)
		SetButtonPoint( bar, 7, "TOP", 4, "BOTTOM", 0, -inset)
	elseif ( num == 8 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "TOP", 3, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "TOP", 5, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 8, "LEFT", 7, "RIGHT", inset, 0)
	elseif ( num == 9 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 5, "LEFT", 4, "RIGHT", inset, 0)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "TOP", 4, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 8, "LEFT", 7, "RIGHT", inset, 0)
		SetButtonPoint( bar, 9, "LEFT", 8, "RIGHT", inset, 0)
	elseif ( num == 10 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "TOP", 3, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "TOP", 5, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 8, "LEFT", 7, "RIGHT", inset, 0)
		SetButtonPoint( bar, 9, "TOP", 7, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 10, "LEFT", 9, "RIGHT", inset, 0)
	elseif ( num == 11 ) then
		SetButtonPoint( bar, 2, "BOTTOMRIGHT", 1, "LEFT", -inset, haf)
		SetButtonPoint( bar, 3, "BOTTOMRIGHT", 2, "LEFT", -inset, haf)
		SetButtonPoint( bar, 4, "BOTTOMRIGHT", 3, "TOP", -haf, inset)
		SetButtonPoint( bar, 5, "BOTTOMRIGHT", 4, "TOP", -haf, inset)
		SetButtonPoint( bar, 6, "BOTTOMLEFT", 5, "TOP", haf, inset)
		SetButtonPoint( bar, 7, "BOTTOMLEFT", 1, "RIGHT", inset, haf)
		SetButtonPoint( bar, 8, "BOTTOMLEFT", 7, "RIGHT", inset, haf)
		SetButtonPoint( bar, 9, "BOTTOMLEFT", 8, "TOP", haf, inset)
		SetButtonPoint( bar, 10, "BOTTOMLEFT", 9, "TOP", haf, inset)
		SetButtonPoint( bar, 11, "BOTTOMRIGHT", 10, "TOP", -haf, inset)
	elseif ( num == 12 ) then
		SetButtonPoint( bar, 2, "LEFT", 1, "RIGHT", inset, 0)
		SetButtonPoint( bar, 3, "LEFT", 2, "RIGHT", inset, 0)
		SetButtonPoint( bar, 4, "LEFT", 3, "RIGHT", inset, 0)
		SetButtonPoint( bar, 5, "LEFT", 4, "RIGHT", inset, 0)
		SetButtonPoint( bar, 6, "LEFT", 5, "RIGHT", inset, 0)
		SetButtonPoint( bar, 7, "TOP", 1, "BOTTOM", 0, -inset)
		SetButtonPoint( bar, 8, "LEFT", 7, "RIGHT", inset, 0)
		SetButtonPoint( bar, 9, "LEFT", 8, "RIGHT", inset, 0)
		SetButtonPoint( bar, 10, "LEFT", 9, "RIGHT", inset, 0)
		SetButtonPoint( bar, 11, "LEFT", 10, "RIGHT", inset, 0)
		SetButtonPoint( bar, 12, "LEFT", 11, "RIGHT", inset, 0)
	end
end