--[[
	BActionButtonMain
		This is the event handler for Bongos ActonBars and ActionButtons.

	TODO:
		Nothing, I think.  Should be fairly optimized.
--]]

bg_showGrid = nil --is determines if empty buttons are being shown or not.
local eventHandler

--[[ Helper Functions ]]--

--all action buttons
function BActionMain_ForAllButtons(action, arg1)
	local numActionBars = BActionBar.GetNumber()
	for i = 1, numActionBars do
		if getglobal("BActionBar" .. i) then
			for j = BActionBar.GetStart(i), BActionBar.GetEnd(i) do
				local button = getglobal("BActionButton" .. j)
				if button and button:GetParent() then
					action(button, arg1)
				else
					break
				end
			end
		end
	end
end

--all visible action buttons
function BActionMain_ForAllShownButtons(action, arg1)
	local numActionBars = BActionBar.GetNumber()
	for i = 1, numActionBars do
		local bar = getglobal("BActionBar" .. i)
		if bar and bar:IsShown() then
			for j = BActionBar.GetStart(i), BActionBar.GetEnd(i) do
				local button = getglobal("BActionButton" .. j)
				if button then
					action(button, arg1)
				else
					break
				end
			end
		end
	end
end

--[[ Update Functions ]]--

local function UpdateButtonsWithID(id)
	local numActionBars = BActionBar.GetNumber()
	for i = 1, numActionBars do
		local bar = getglobal("BActionBar" .. i)
		if bar and bar:IsShown() then
			for j = BActionBar.GetStart(i), BActionBar.GetEnd(i) do
				local button = getglobal("BActionButton" .. j)
				if button and BActionButton.GetPagedID(button:GetID()) == id then
					BActionButton.Update(button)
				end
			end
		end
	end
end

function BActionMain_UpdatePage()
	for i = 1, BActionBar.GetNumber() do
		if BActionBar.CanPage(i) then
			BActionBar.Update(i)
		end
	end
end

--[[ OnX Functions ]]--

--in theory, I've optimized the if/then/else order of event frequency
local function OnEvent()
	if (arg1 == "player" and (event == "UNIT_MANA" or event == "UNIT_HEALTH" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY")) or event == "PLAYER_COMBO_POINTS" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable)
	elseif event == "ACTIONBAR_UPDATE_COOLDOWN" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateCooldown)
	elseif event == "ACTIONBAR_UPDATE_USABLE" or event == "UPDATE_INVENTORY_ALERTS" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable)
	elseif event == "UNIT_AURASTATE" and (arg1 == "player" or arg1 == "target") then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable)
	elseif event == "ACTIONBAR_UPDATE_STATE" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateState)
	elseif event == "UNIT_INVENTORY_CHANGED" and arg1=="player" then
		BActionMain_ForAllShownButtons(BActionButton.Update)
	elseif event == "PLAYER_TARGET_CHANGED" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable)
	elseif event == "PLAYER_AURAS_CHANGED" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable)
	elseif event == "ACTIONBAR_PAGE_CHANGED" then
		BActionMain_UpdatePage()
	elseif event == "PLAYER_ENTER_COMBAT" then
		IN_ATTACK_MODE = 1
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash)
	elseif event == "PLAYER_LEAVE_COMBAT" then
		IN_ATTACK_MODE = nil
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash)
	elseif event == "START_AUTOREPEAT_SPELL" then
		IN_AUTOREPEAT_MODE = 1
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash)
	elseif event == "STOP_AUTOREPEAT_SPELL" then
		IN_AUTOREPEAT_MODE = nil
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash)
	elseif event == "ACTIONBAR_SLOT_CHANGED" then
		UpdateButtonsWithID(arg1)
	elseif event == "ACTIONBAR_SHOWGRID" then
		bg_showGrid = 1
		BActionMain_ForAllButtons(BActionButton.ShowGrid)
	elseif event == "ACTIONBAR_HIDEGRID" then
		bg_showGrid = nil
		if not BActionSets_ShowGrid() then
			BActionMain_ForAllButtons(BActionButton.HideGrid)
		end
	elseif event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateState)
	elseif event == "UPDATE_BINDINGS" then
		BActionMain_ForAllButtons(BActionButton.UpdateHotkey)
	end
end

--[[ Function Overrides ]]--

--increment page
ActionBar_PageUp = function()
	CURRENT_ACTIONBAR_PAGE = CURRENT_ACTIONBAR_PAGE + 1
	if CURRENT_ACTIONBAR_PAGE > BActionBar.GetNumber() then
		CURRENT_ACTIONBAR_PAGE = 1
	end
	ChangeActionBarPage()
end

--decrement page
ActionBar_PageDown = function()
	CURRENT_ACTIONBAR_PAGE = CURRENT_ACTIONBAR_PAGE - 1
	if CURRENT_ACTIONBAR_PAGE < 1 then
		CURRENT_ACTIONBAR_PAGE = BActionBar.GetNumber()
	end
	ChangeActionBarPage()
end

--[[ Startup ]]--

local function RegisterEvents(frame)
	eventHandler = frame

	frame:SetScript('OnEvent', OnEvent)

	frame:RegisterEvent("PLAYER_TARGET_CHANGED")
	frame:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
	frame:RegisterEvent("PLAYER_AURAS_CHANGED")
	frame:RegisterEvent("ACTIONBAR_SHOWGRID")
	frame:RegisterEvent("ACTIONBAR_HIDEGRID")
	frame:RegisterEvent("UPDATE_BINDINGS")

	frame:RegisterEvent("ACTIONBAR_UPDATE_STATE")
	frame:RegisterEvent("ACTIONBAR_UPDATE_USABLE")
	frame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	frame:RegisterEvent("UPDATE_INVENTORY_ALERTS")
	frame:RegisterEvent("UNIT_AURASTATE")
	frame:RegisterEvent("CRAFT_SHOW")
	frame:RegisterEvent("CRAFT_CLOSE")
	frame:RegisterEvent("TRADE_SKILL_SHOW")
	frame:RegisterEvent("TRADE_SKILL_CLOSE")
	frame:RegisterEvent("UNIT_HEALTH")
	frame:RegisterEvent("UNIT_MANA")
	frame:RegisterEvent("UNIT_RAGE")
	frame:RegisterEvent("UNIT_FOCUS")
	frame:RegisterEvent("UNIT_ENERGY")
	frame:RegisterEvent("PLAYER_ENTER_COMBAT")
	frame:RegisterEvent("PLAYER_LEAVE_COMBAT")
	frame:RegisterEvent("PLAYER_COMBO_POINTS")
	frame:RegisterEvent("START_AUTOREPEAT_SPELL")
	frame:RegisterEvent("STOP_AUTOREPEAT_SPELL")

	frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	frame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
end

BProfile.AddStartup(function()
	for i = 1, BActionBar.GetNumber() do
		BActionBar.Create(i)
	end
	if not eventHandler then
		RegisterEvents(CreateFrame("Frame"))
	end
end)