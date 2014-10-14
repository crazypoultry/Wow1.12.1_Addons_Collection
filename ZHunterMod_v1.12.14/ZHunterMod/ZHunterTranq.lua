-- Saved Variables
ZHunterMod_Saved["ZHunterTranq"] = {}
ZHunterMod_Saved["ZHunterTranq"]["autofrenzy"] = 1
ZHunterMod_Saved["ZHunterTranq"]["announce"] = nil
ZHunterMod_Saved["ZHunterTranq"]["channel"] = nil
ZHunterMod_Saved["ZHunterTranq"]["channeltarget"] = nil
ZHunterMod_Saved["ZHunterTranq"]["hit"] = "Tranq Fired!"
ZHunterMod_Saved["ZHunterTranq"]["miss"] = "Tranq *MISSED*"
ZHunterMod_Saved["ZHunterTranq"]["fail"] = "Tranq *FAILED*"

-- Bosses To Track
ZHunterTranq_Bosses = {}
ZHunterTranq_Bosses[ZHUNTER_MAGMADAR]	= 20
ZHunterTranq_Bosses[ZHUNTER_FLAMEGORE]	= 10
ZHunterTranq_Bosses[ZHUNTER_CHROMMAGUS]	= 17
ZHunterTranq_Bosses[ZHUNTER_HUHURAN]	= 17
ZHunterTranq_Bosses[ZHUNTER_GLUTH]	= 10

ZHunterTranq_ChatTypes = {}
ZHunterTranq_ChatTypes["say"] = 1
ZHunterTranq_ChatTypes["yell"] = 1
ZHunterTranq_ChatTypes["emote"] = 1
ZHunterTranq_ChatTypes["party"] = 1
ZHunterTranq_ChatTypes["raid"] = 1
ZHunterTranq_ChatTypes["guild"] = 1
ZHunterTranq_ChatTypes["whisper"] = 1
ZHunterTranq_ChatTypes["channel"] = 1

-- Players To Track
ZHunterTranq_Players = {}
ZHunterTranq_PlayerCount = 0

-- Default Frenzy Timer
ZHunterTranq_FrenzyTimer = 15

function ZHunterTranq_OnEvent()
	-- Setup Addon
	if event == "VARIABLES_LOADED" then
		ZHunterTranq_SetupBars()
		return
	end

	local _, mob, player

	-- Frenzy Emote
	if event == "CHAT_MSG_MONSTER_EMOTE" then
		if string.find(string.lower(arg1), ZHUNTER_FRENZY) then
			ZHunterTranq_StartFrenzy(GetTime(), arg2)
		end
		return

	-- Frenzy Gained
	elseif event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" then
		_, _, mob = string.find(arg1, ZHUNTER_GAINFRENZY)
		if mob then
			ZHunterTranq_StartFrenzy(GetTime(), mob)
		end
		return

	-- You Hit or Miss
	elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		if string.find(arg1, ZHUNTER_TRANQCASTYOU) then
			ZHunterTranq_SendMessage("hit")
			ZHunterTranq_StartPlayer(GetTime(), ZHUNTER_YOU, "hit")
		elseif string.find(arg1, ZHUNTER_TRANQMISSYOU) then
			ZHunterTranq_SendMessage("miss")
			ZHunterTranq_StartPlayer(GetTime(), ZHUNTER_YOU, "miss")
		end
		return

	-- You Fail
	elseif event == "CHAT_MSG_SPELL_SELF_BUFF" then
		if string.find(arg1, ZHUNTER_TRANQFAILYOU) then
			ZHunterTranq_SendMessage("fail")
			ZHunterTranq_StartPlayer(GetTime(), ZHUNTER_YOU, "fail")
		end
		return

	-- Other Player Hits or Misses
	elseif event == "CHAT_MSG_SPELL_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" then
		_, _, player = string.find(arg1, ZHUNTER_TRANQCASTOTHER)
		if player then
			ZHunterTranq_StartPlayer(GetTime(), player, "hit")
		else
			_, _, player = string.find(arg1, ZHUNTER_TRANQMISSOTHER)
			if player then
				ZHunterTranq_StartPlayer(GetTime(), player, "miss")
			end
		end
		return

	-- Other Player Fails
	elseif event == "CHAT_MSG_SPELL_PARTY_BUFF" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" then
		_, _, player = string.find(arg1, ZHUNTER_TRANQFAILOTHER)
		if player then
			ZHunterTranq_StartPlayer(GetTime(), player, "fail")
		end
	end
end

function ZHunterTranq_RegisterEvents()
	-- Tranquilizing Hit or Miss
	ZHunterTranq0:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	ZHunterTranq0:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE")
	ZHunterTranq0:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")

	-- Tranquilizing Failed
	ZHunterTranq0:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	ZHunterTranq0:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF")
	ZHunterTranq0:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF")

	-- Monster Frenzy
	ZHunterTranq0:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	ZHunterTranq0:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
end

function ZHunterTranq_SendMessage(action)
	if ZHunterMod_Saved["ZHunterTranq"]["announce"] and ZHunterMod_Saved["ZHunterTranq"]["channel"] and ZHunterMod_Saved["ZHunterTranq"][action] then
		SendChatMessage(ZHunterMod_Saved["ZHunterTranq"][action], ZHunterMod_Saved["ZHunterTranq"]["channel"], nil, ZHunterMod_Saved["ZHunterTranq"]["channeltarget"])
	end
end

function ZHunterTranq_IsValidPlayer()
	local player = UnitName("target")
	if not player then
		return "You Have No Target Selected"
	elseif ZHunterTranq_PlayerCount == 10 then
		return "Cannot Track Any More Players"
	elseif ZHunterTranq_Players[player] then
		return "Already Tracking This Player"
	elseif not UnitIsPlayer("target") then
		return "Target Is Not A Player"
	elseif UnitClass("target") ~= ZHUNTER_HUNTER then
		return "Target Is Not A Hunter"
	end
end

function ZHunterTranq_Reset()
	ZHunterTranq_Players = {}
	ZHunterTranq_PlayerCount = 0
	for i=0, 10 do
		getglobal("ZHunterTranq"..i):Hide()
	end
	ZHunterTranq0:UnregisterAllEvents()
end

function ZHunterTranq_SetTimer(timer)
	if timer and tonumber(timer) then
		ZHunterTranq_FrenzyTimer = tonumber(timer)
		ZHunterTranq0TextLeft:SetText("Frenzy ("..timer.."s)")
	end
end

function ZHunterTranq_HideIcons()
	local icon
	for i=1, 10 do
		icon = getglobal("ZHunterTranq"..i.."Icon")
		icon:Hide()
	end
end

function ZHunterTranq_StartPlayer(timer, player, action)
	local id = ZHunterTranq_Players[player]
	if not id then
		return
	end
	local info = {r=1.0, g=1.0, b=0.0}
	if action == "hit" then
		info = {r=1.0, g=1.0, b=0.0}
	elseif action == "miss" then
		info = {r=1.0, g=0.0, b=0.0}
	elseif action == "fail" then
		info = {r=1.0, g=0.0, b=0.0}
	end
	local bar = getglobal("ZHunterTranq"..id)
	bar:SetStatusBarColor(info.r, info.g, info.b)
	bar:SetMinMaxValues(timer, timer + 20)
	bar:SetValue(timer)
	bar.disabled = nil
	getglobal(bar:GetName().."Spark"):Show()
	ZHunterTranq_HideIcons()
	bar:Show()
	local nextbar = getglobal("ZHunterTranq"..(id+1))
	if not (nextbar and nextbar:IsVisible()) then
		nextbar = getglobal("ZHunterTranq1")
	end
	getglobal(nextbar:GetName().."Icon"):Show()
end

function ZHunterTranq_StartFrenzy(timer, mob)
	if ZHunterMod_Saved["ZHunterTranq"]["autofrenzy"] and mob then
		local timer = ZHunterTranq_Bosses[mob]
		if timer then
			ZHunterTranq_SetTimer(timer)
		end
	end
	local bar = ZHunterTranq0
	local frenzy = ZHunterTranq_FrenzyTimer
	bar:SetMinMaxValues(timer, timer + frenzy)
	bar:SetValue(timer)
	bar.disabled = nil
	getglobal(bar:GetName().."Spark"):Show()
end

function ZHunterTranq_AddPlayer(name, isSelf)
	ZHunterTranq_PlayerCount = ZHunterTranq_PlayerCount + 1
	if isSelf then
		ZHunterTranq_Players[name] = ZHunterTranq_PlayerCount
		name = ZHUNTER_YOU
	end
	ZHunterTranq_Players[name] = ZHunterTranq_PlayerCount
	local bar = getglobal("ZHunterTranq"..ZHunterTranq_PlayerCount)
	local bartext = getglobal(bar:GetName().."TextLeft")
	bartext:SetText(name)
	ZHunterTranq_StartPlayer(GetTime(), name, "hit")
end

function ZHunterTranq_SetupBars()
	ZHunterTranq0TextLeft:SetText("Frenzy (15s)")
	ZHunterTranq0.color = {r=1.0, g=0.5, b=0.0}
	ZHunterTranq0:SetStatusBarColor(1.0, 0.5, 0.0)
	for i=1, 10 do
		getglobal("ZHunterTranq"..i):SetPoint("TOP", getglobal("ZHunterTranq"..(i-1)), "BOTTOM", 0, -3)
	end
end

function ZHunterTranqTemplate_OnUpdate()
	if this.disabled then
		return
	end
	local min, max = this:GetMinMaxValues()
	local value = GetTime()
	if value < max then
		local name = this:GetName()
		local offset = (value - min) / (max - min) * this:GetWidth()
		this:SetValue(value)
		getglobal(name.."Spark"):SetPoint("CENTER", this, "LEFT", offset, 0)
		getglobal(name.."TextRight"):SetText(format("%0.1f", (max - value)))
	else
		local name = this:GetName()
		local info
		if this.color then
			info = this.color
		else
			info = {r=0.0, g=1.0, b=0.0}
		end
		this:SetStatusBarColor(info.r, info.g, info.b)
		this:SetValue(max)
		this.disabled = 1
		getglobal(name.."Spark"):Hide()
		getglobal(name.."TextRight"):SetText("0.0")
	end
end

SLASH_ZHunterTranq1 = "/ztranq"
SlashCmdList["ZHunterTranq"] = function(msg)
	msg = string.lower(msg or "")
	if msg == "clear" or msg == "stop" or msg == "reset" then
		ZHunterTranq_Reset()
		return
	elseif msg == "autofrenzy" then
		if ZHunterMod_Saved["ZHunterTranq"]["autofrenzy"] then
			ZHunterMod_Saved["ZHunterTranq"]["autofrenzy"] = nil
			DEFAULT_CHAT_FRAME:AddMessage("No longer setting the frenzy timer automatically.", 0, 1, 1)
		else
			ZHunterMod_Saved["ZHunterTranq"]["autofrenzy"] = 1
			DEFAULT_CHAT_FRAME:AddMessage("Automatically setting the frenzy timer during encounters.", 0, 1, 1)
		end
		return
	elseif tonumber(msg) then
		ZHunterTranq_SetTimer(tonumber(msg))
		return
	elseif string.len(msg) == 0 then
		local error = ZHunterTranq_IsValidPlayer()
		if error then
			UIErrorsFrame:AddMessage(error,0,1,1,1,5)
			return
		end
		if ZHunterTranq_PlayerCount == 0 then
			ZHunterTranq_RegisterEvents()
			ZHunterTranq_StartFrenzy(GetTime(), "")
			ZHunterTranq0:Show()
			ZHunterTranq1Icon:Show()
		end
		local name = UnitName("target")
		local isSelf = UnitIsUnit("player", "target")
		ZHunterTranq_AddPlayer(name, isSelf)
		return
	else
		local channel, channeltarget, check
		for word in string.gfind(msg or "", "([^%s]+)") do
			if word == "announce" then
				check = 1
			elseif ZHunterTranq_ChatTypes[word] then
				channel = word
			else
				channeltarget = word
			end
		end
		if check then
			if channel then
				ZHunterMod_Saved["ZHunterTranq"]["channel"] = channel
				ZHunterMod_Saved["ZHunterTranq"]["channeltarget"] = channeltarget
				msg = "Sending Tranq Announcements To: "..string.upper(channel)
				if channeltarget then
					msg = msg.." ("..channeltarget..")"
				end
				DEFAULT_CHAT_FRAME:AddMessage(msg, 0, 1, 1)
				return
			elseif channeltarget == "on" then
				ZHunterMod_Saved["ZHunterTranq"]["announce"] = 1
				DEFAULT_CHAT_FRAME:AddMessage("Now announcing Tranq Shot results.", 0, 1, 1)
				return
			elseif channeltarget == "off" then
				ZHunterMod_Saved["ZHunterTranq"]["announce"] = nil
				DEFAULT_CHAT_FRAME:AddMessage("No longer announcing Tranq Shot results.", 0, 1, 1)
				return
			end
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("Possible Commands: \"<number>\", \"clear\", \"autofrenzy\", \"announce on\", \"announce off\", \"announce <chattype> <chattarget>\", or simply leave the message blank to add the currently selected hunter to the Tranq List.", 0, 1, 1)
end