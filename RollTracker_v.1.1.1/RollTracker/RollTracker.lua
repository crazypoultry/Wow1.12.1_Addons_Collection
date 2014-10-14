--[[ 				RollTracker v1.1.1 by Morodan of Khadgar
Based on RollTracker by Coth of Gilneas
	Considers any party/raid message that contains any one of:
		* Roll
		* RTS
		* RTU
	and an item link in one sentence to be the herald of a roll event.
	Last update:	1.11.2
	Tested for:		1.11.2
]]--

local RollArray
local RollCount
local AddNewRolls

function RollTracker_OnLoad()
	-- Register events.
	this:RegisterEvent("CHAT_MSG_SYSTEM")
	this:RegisterEvent("CHAT_MSG_PARTY")
	this:RegisterEvent("CHAT_MSG_RAID")
	this:RegisterEvent("CHAT_MSG_RAID_LEADER")
	this:RegisterEvent("CHAT_MSG_RAID_WARNING")

	-- Setup slash commands.
	SlashCmdList["ROLLTRACKER"] = RollTracker_OnSlashCommand
	SLASH_ROLLTRACKER1 = "/rtr"
	SLASH_ROLLTRACKER2 = "/rolltrack"
	
	-- Register for dragging.  Left button moves, right button resizes.
	this:SetMinResize(130,150)
	this:RegisterForDrag("LeftButton", "RightButton")
	
	-- Initialize variables
	RollCount = 0
	RollArray = {}
	AddNewRolls = true
	RollInProgress = false
	RTitemname = ""
	RollTracker_Options = {
	StayHidden = false,
	}
	
	RollTracker_UpdateList()
end

function RollTracker_UpdateList()
	local index
	local rolls
	local rollText
	
	rolls = RollTracker_GetSortedRolls()
	RollTracker_CheckTies(rolls)
	RollTrackerFrameStatusText:SetText(RollTracker_If(table.getn(rolls) == 1, "1 Roll", string.format("%d Rolls",table.getn(rolls))))
	rollText = ""
	for index in rolls do
		rollText = string.format("|c%s%d|r: |c%s%s%s%s|r\n",
				RollTracker_If(rolls[index].Tie, "ffffff00", "ffffffff"),
				rolls[index].Roll, 
				RollTracker_If( (rolls[index].Low ~= 1 or rolls[index].High ~= 100) or (rolls[index].RollNumber > 1), "ffffcccc", "ffffffff"),
				rolls[index].Name, 
				RollTracker_If(rolls[index].Low ~= 1 or rolls[index].High ~= 100, format(" (%d-%d)", rolls[index].Low, rolls[index].High), ""), 
				RollTracker_If(rolls[index].RollNumber > 1, format(" [%d]", rolls[index].RollNumber), "")) .. rollText
	end
	RollTrackerRollText:SetText(rollText)
	RollTrackerFrameRollScrollFrame:UpdateScrollChildRect()
end

function RollTracker_CheckTies(rolls)
	local index
	for index in rolls do
		rolls[index].Tie = false
		if rolls[index - 1] and rolls[index].Roll == rolls[index - 1].Roll then
			rolls[index].Tie = true
			rolls[index - 1].Tie = true
		end
	end	
end

function RollTracker_OnSlashCommand(msg)
	if msg == "clear" then
		RollTracker_ClearRolls()
	elseif msg == "hide" then
		RollTracker_Options.StayHidden = true
		RollTracker_HideRollWindow()
	elseif msg == "help" then
		RollTracker_PrintHelp()
	elseif msg == "" then
		if RollTrackerFrame:IsVisible() then
			RollTracker_HideRollWindow()
		else
			RollTracker_Options.StayHidden = false
			RollTracker_ShowRollWindow()
		end
	else
		RollTracker_PrintHelp()
	end
end

function RollTracker_ShowRollWindow()
	if not RollTracker_Options.StayHidden then
		ShowUIPanel(RollTrackerFrame)
		RollTracker_UpdateList()
	end
end

function RollTracker_HideRollWindow()
	HideUIPanel(RollTrackerFrame)
end

-- Process Start From Chat

function RollTracker_OnEvent(event)
	if event == "CHAT_MSG_SYSTEM" then
		if RollInProgress then 
			RollTracker_OnSystemMessage()
		end
	else
	local msg = arg1
	if not RollInProgress then
		if RollTracker_isroll(msg) then
			RTitemname = string.sub(msg, string.find(msg, "[", 1, true) + 1, string.find(msg, "]", 1, true) - 1)
			RollTracker_Print("Rolling for " .. RTitemname .. ", rolls cleared.")
			local index
			for index in RollArray do
				RollArray[index].Selected = false
			end
			RollTracker_UpdateList()
			RollInProgress = true
			RollTracker_ShowRollWindow()	
		end
	end
	end
end

function RollTracker_isroll(msg)
	local validkey = {"^roll ", "^rtu ", "^rts ", " roll$", " rtu$", " rts$", " roll ", " rtu ", " rts "}
	if string.find(msg, "|Hitem:", 1, true) then
		for k, v in validkey do
			if string.find(string.lower(msg), v) then
			return true
			end
		end
	end
end

function RollTracker_AnnounceWinner()
	local roll = RollTracker_GetSortedRolls()
	local entry = table.getn(roll)
	if entry > 0 then
	local winner = roll[entry].Name
	local winroll = roll[entry].Roll
	if RTitemname ~= "" then
	RTitemname = " " .. RTitemname
	end
	local winmsg = winner .. " wins" .. RTitemname .. " with a roll of " .. winroll .. "!"
		if GetNumRaidMembers() > 0 then
		SendChatMessage(winmsg, "RAID")
		elseif GetNumPartyMembers() > 0 then
		SendChatMessage(winmsg, "PARTY")
		else
		RollTracker_Print(winmsg)
		end
	RollInProgress = false
	RTitemname = ""
	end
end

function RollTracker_OnSystemMessage()
	local name, roll, low, high
	for name, roll, low, high in string.gfind(arg1, "([^%s]+) rolls (%d+) %((%d+)%-(%d+)%)$") do
		RollTracker_OnRoll(name, tonumber(roll), tonumber(low), tonumber(high))
	end
	
end

function RollTracker_OnRoll(name, roll, low, high)
	RollCount = RollCount + 1
	RollArray[RollCount] = {Name = name, Roll = roll, Low = low, High = high, Selected = true, RollNumber = 0, Tie=false}
	RollTracker_ShowRollWindow()
end

function RollTracker_GetSelected(array)
	local result = {}
	local index
	for index in array do
		if array[index].Selected then
			table.insert(result, array[index])
		end
	end
	return result
end

function RollTracker_GetSortedRolls()
	local names = {}
	local selected = RollTracker_GetSelected(RollArray)
	local index
	for index in selected do
		if names[selected[index].Name] then
			names[selected[index].Name] = names[selected[index].Name] + 1
			selected[index].RollNumber = names[selected[index].Name]
		else
			names[selected[index].Name] = 1
			selected[index].RollNumber = 1
		end
		if selected[index].Low ~= 1 or selected[index].High ~= 100 or selected[index].RollNumber > 1 then
			table.remove(selected, index)
			RollCount = RollCount - 1
		end
	end
	table.sort(selected, RollTracker_CompareRolls)
	return selected
end

function RollTracker_If(expr, a, b)
	if expr then 
		return a
	else
		return b
	end
end

function RollTracker_ClearRolls()
	RollArray = {}
	RollTracker_Print("All rolls have been cleared.")
	RollTracker_UpdateList()
end

function RollTracker_Print(msg)
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end

function RollTracker_PrintHelp()
	RollTracker_Print("RollTracker by Morodan of Khadgar. Based on RollTracker by Coth of Gilneas.") 
	RollTracker_Print("/rtr                Show the RollTracker window, or hide it if already visible." ) 
	RollTracker_Print("/rtr hide           Hide (and keep hidden) the RollTracker window. Surpresses roll detection." ) 
	RollTracker_Print("/rtr clear          Clear all stored rolls." )
	RollTracker_Print("/rtr help           Displays this help message." )
end

function RollTracker_CompareRolls(a, b)
	return a.Roll < b.Roll
end

function RollTracker_OnDragStart()
	if arg1 == "RightButton" then
		this:StartSizing("BOTTOMRIGHT")
	else
		this:StartMoving()
	end

end

function RollTracker_OnDragStop()
	this:StopMovingOrSizing()
end

function RollTracker_OnStartButtonClick()
	RollInProgress = true
	RTitemname = ""
	local index
	for index in RollArray do
		RollArray[index].Selected = false
	end
	RollTracker_Print("Roll tracking started. All rolls have been cleared.")
	RollTracker_UpdateList()
end

function RollTracker_OnStopButtonClick()
	RollInProgress = false
	RollTracker_Print("Roll tracking stopped.")
end

function RollTracker_OnAnnounceButtonClick()
	RollTracker_AnnounceWinner()
end

function RollTracker_OnCloseButtonClick()
	RollTracker_ClearRolls()
	RollInProgress = false
	RollTracker_HideRollWindow()
end