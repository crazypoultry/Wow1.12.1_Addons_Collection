--[[
	Bongos\utility.lua
		Utility functions for Bongos
--]]

--takes a Bongos BarID, and performs the specified action on that bar
--this adds two special IDs, "all" for all bars and number-number for a range of IDs
function Bongos_ForBar(barID, action, ...)
	assert(barID and barID ~= "", "Invalid barID")

	if barID == "all" then
		BBar.ForAll(action, unpack(arg))
	else
		local _, _, startID, endID = string.find(barID, "(%d+)-(%d+)")
		startID = tonumber(startID)
		endID = tonumber(endID)
		if startID and endID then
			for id = startID, endID do
				local bar = BBar.IDToBar(id)
				if bar then
					action(bar, unpack(arg))
				end
			end
		else
			local bar = BBar.IDToBar(barID)
			if bar then
				action(bar, unpack(arg))
			end
		end
	end
end

--same thing as the previous function, except we pass the bar's ID as an arg instead of the bar itself
function Bongos_ForBarID(barID, action, arg1, arg2)
	assert(barID and barID ~= "", "Invalid barID")

	if barID == "all" then
		BBar.ForAllIDs(action, arg1, arg2)
	else
		local _, _, startID, endID = string.find(barID, "(%d+)-(%d+)")
		if startID and endID then
			for id = tonumber(startID), tonumber(endID) do
				action(id, arg1, arg2)
			end
		else
			if tonumber(barID) then
				barID = tonumber(barID)
			end
			action(barID, arg1, arg2)
		end
	end
end

--[[ Configuration Functions ]]--

function Bongos_SetLock(enable)
	if enable then
		BongosSets.locked = 1
		BBar.ForAll(BBar.Lock)
	else
		BongosSets.locked = nil
		BBar.ForAll(BBar.Unlock)
	end
end

--enable disable "sticky" bars
function Bongos_SetStickyBars(enable)
	if enable then
		BongosSets.sticky = 1
	else
		BongosSets.sticky = nil
	end
	BBar.ForAll(BBar.Reanchor)
end

--enable/disable reusing blizzard created buttons and stuff
--enabling saves memory, but may cause addon conflicts
function Bongos_Reuse(enable)
	if enable then
		BongosSets.dontReuse = nil
		BMsg(BONGOS_REUSE_ENABLED)
	else
		BongosSets.dontReuse = 1
		BMsg(BONGOS_REUSE_DISABLED)
	end
	ReloadUI()
end

--Adds a new panel to the options menu when its loaded
function Bongos_AddOptionsPanel(title, frameName, OnShowAction)
	BEvent:AddAction("ADDON_LOADED", function(thisAction)
		if arg1 == "Bongos_Options" then
			BEvent:RemoveAction(event, thisAction)
			BOptions_CreatePanel(title, frameName, OnShowAction)
		end
	end)
end

--Print a chat message
function BMsg(msg)
	ChatFrame1:AddMessage(msg or 'nil', 0,1,0.4)
end