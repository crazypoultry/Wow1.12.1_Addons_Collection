-- AfkAlert - Displays a huge <AFK> over your character while you are afk. 
-- Also plays a warning sound when you go afk.
AfkAlert = {

	-- register for events
	OnLoad = function()
		this.markedAfk = string.gsub(MARKED_AFK_MESSAGE, "%%s", "%%a+")
		if GetLocale() == "deDE" then
			this.markedAfk = "Ihr seid jetzt AFK: %a+"
		end
		this:RegisterEvent("CHAT_MSG_SYSTEM")
		this:RegisterEvent("PLAYER_ENTERING_WORLD")
		--UIErrorsFrame:AddMessage("AfkAlert loaded", 1, 1, 0, 1, 5)
	end,
	
	-- key bindings have changed, update the multi bar buttons
	OnEvent = function()
		-- debug, make sure we pick up the message
		--UIErrorsFrame:AddMessage(arg1, 1, 1, 0, 1, 5)
		-- optimistically assuming we got the correct event...
		-- confusingly but more efficiently check cleared first
		if event == "PLAYER_ENTERING_WORLD" or arg1 == CLEARED_AFK then
			-- got the cleared message, hide the big yellow afk message
			AfkAlertText:Hide()
		elseif string.find(arg1, this.markedAfk) then
			this.countdown = 0
			-- for a really big visual indication, update zone text frame
			AfkAlertText:SetTextColor(1, 1, 0)
			AfkAlertText:SetText(CHAT_FLAG_AFK)
			AfkAlertText:Show()
			-- why not, play a sound too
			PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
		end
	end,
}
