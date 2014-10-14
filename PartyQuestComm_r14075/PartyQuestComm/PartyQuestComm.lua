--[[ $Id: PartyQuestComm.lua 14075 2006-10-16 12:23:19Z hshh $ ]]--

local L = AceLibrary("AceLocale-2.1"):GetInstance("PartyQuestComm", true)
PartyQuestComm = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0", "AceEvent-2.0")
BINDING_HEADER_PARTYQUESTCOMM = L["BINDING_HEADER_PARTYQUESTCOMM"]
BINDING_NAME_PARTYQUESTCOMMGUI = L["BINDING_NAME_PARTYQUESTCOMMGUI"]


function PartyQuestComm:OnInitialize()
	-- addon init
	self.prefix = {
		progress = "PQC_progress", complete = "PQC_complete", fail = "PQC_fail",
		clear = "PQC_clear", request = "PQC_request", send = "PQC_send", done = "PQC_done",
		sync = "PQC_sync", delete = "PQC_delete"
	}
	self.infoprefix = {
		log = "::LOG::",
		all = "::ALL::",
		single = "::PLAYER::",
		singleAll = "ALL",
		questTitle = "::TITLE::",
		questLevel = "::LEVEL::",
		questTag = "::TAG::",
		questComplete = "::COMPLETE::",
		questDescription = "::DESC::",
		questObjectives = "::OBJ::",
		reqTime = "::REQTIME::",
		reqMoney = "::REQMONEY::",
		reqOBJ = "::REQOBJ::",
		rewardMoney = "::REWMONEY::",
		rewardRewards = "::REWREWARDS::",
		rewardChoices = "::REWCHOICES::",
		rewardSpell = "::REWSPELL::"
	}
	self.PartyQuest = {}
	self.QUESTS_DISPLAYED = 22
	self.sendPool = {}
	self.diffPendding = {}
	self.delPendding = {}
	self.player = UnitName("player")
	self.inited = nil
	self.wraplen = 200
	self.guiMethod = "log"
	self.guiPlayer = nil

	self.quest_obj_found = gsub(TEXT(ERR_QUEST_ADD_FOUND_SII), "%%s(.+)%%d(.+)%%d", "(.+)%1%%d+%2%%d+")
	self.quest_complete_fail_format = "[%d] %s (%s)"
	self.quest_complete_fail_format_check = "%[%d+%].+%(.+%)"



	-- register saved variables
	self:RegisterDB("PartyQuestComm_Options")
	-- init default variables
	self:RegisterDefaults('account', {
		DisplayUIErrorFrame = true,
		DisplayChatFrame = true,
		logSaved = 50,
		Log = {},
		PartyQuest = {}
	})
	self:RegisterChatCommand(
		{ "/partyquestcomm", "/pqc" },
		{
			type="group",
			args={
				uierr={
					type="toggle",
					name="uierr",
					desc=L["Display Quest Progess Info in UIErrorsFrame."],
					get=function() return self.db.account.DisplayUIErrorFrame end,
					set=function(t)
						self.db.account.DisplayUIErrorFrame = t
						if (self.db.account.DisplayUIErrorFrame) then
							self:Print(L["UIErrorsFrame Display Enabled."])
						else
							self:Print(L["UIErrorsFrame Display Disabled."])
						end
					end
				},
				chat={
					type="toggle",
					name="chat",
					desc=L["Display Quest Progess Info in ChatFrame."],
					get=function() return self.db.account.DisplayChatFrame end,
					set=function(t)
						self.db.account.DisplayChatFrame = t
						if (self.db.account.DisplayChatFrame) then
							self:Print(L["ChatFrame Display Enabled."])
						else
							self:Print(L["ChatFrame Display Disabled."])
						end
					end
				},
				reset = {
					type = 'execute',
					name = "reset",
					desc = L["Reset ALL settings to default."],
					func = function()
						self:ResetDB("account")
						self:QuestInit()
						self:Print(L["ALL settings have been reset to default."])
					end
				},
				gui = {
					type = 'execute',
					name = "gui",
					desc = L["Show PartyQuest GUI."],
					func = "FrameShowHide"
				}
			}
		}
	)

	-- Schedule to init completed quest, delay 20 seconds
	self:ScheduleEvent(self.QuestInit, 20)
end

function PartyQuestComm:OnEnable()
	self:RegisterEvent("CHAT_MSG_ADDON")
	self:RegisterEvent("UI_INFO_MESSAGE")
	self:RegisterEvent("QUEST_LOG_UPDATE")
end

function PartyQuestComm:UI_INFO_MESSAGE()
	if not arg1 or not self.inited then
		return
	end

	if ( strfind(arg1, self.quest_obj_found) and GetNumPartyMembers() > 0) then
		SendAddonMessage(self.prefix.progress, arg1, "PARTY")
	end
end

function PartyQuestComm:QUEST_LOG_UPDATE()
	if not self.inited then
		return
	end

	for i = 1, 50, 1 do
		local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i)
		if questLogTitleText then
			local text
			if (level and not isHeader and isComplete) then
				if isComplete == 1 then
					if not self.quest[questLogTitleText] then
						self.quest[questLogTitleText] = 1
						text = string.format(self.quest_complete_fail_format, level, questLogTitleText, L["COMPLETED"])
						if (GetNumPartyMembers() > 0) then
							SendAddonMessage(self.prefix.complete, text, "PARTY")
						end
					end
				elseif isComplete == -1 then
					text = string.format(self.quest_complete_fail_format, level, questLogTitleText, L["FAILED"])
					if (GetNumPartyMembers() > 0) then
						SendAddonMessage(self.prefix.fail, text, "PARTY")
					end
				end
				if (text and self.db.account.DisplayChatFrame) then
					self:Print(text)
				end
			end
		else
			break
		end
	end
end

function PartyQuestComm:CHAT_MSG_ADDON()
	local prefix, msg, dist, sender = arg1, arg2, arg3, arg4

	if (sender == self.player or not self:IsInParty(sender)) then return end
	if (dist ~= "PARTY" or not msg) then return end

	-- progress/complete/faile commands
	if (
		(prefix == self.prefix.progress and strfind(msg, self.quest_obj_found)) or
		((prefix == self.prefix.complete or prefix == self.prefix.fail) and strfind(msg, self.quest_complete_fail_format_check))
	) then
		-- logging msg
		tinsert(self.db.account.Log, {time=time(), sender=sender, msg=msg})
		-- too many log, delete old msg
		if getn(self.db.account.Log) > self.db.account.logSaved then
			local remove = getn(self.db.account.Log) - self.db.account.logSaved
			for i = 1, remove, 1 do
				tremove(self.db.account.Log, 1)
			end
		end

		msg = "["..sender.."] "..msg
		if self.db.account.DisplayUIErrorFrame then
			UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME)
		end
		if self.db.account.DisplayChatFrame then
			self:Print(msg)
		end
		self:FrameNeedUpdate() --update gui items

	-- clear commands
	elseif prefix == self.prefix.clear then
		self.db.account.PartyQuest[sender] = {}
		self.PartyQuest[sender] = {}
		-- do logs clean
		self:PartyQuestClean()

		self:FrameNeedUpdate() --update gui items

	-- receive request command
	elseif prefix == self.prefix.request then
		if msg == self.infoprefix.all then
			self:SyncSendPrepare(true)
		else
			local pos,_,quest = strfind(msg, self.infoprefix.single .. self.player .. ";;(.+)")
			if pos and quest then
				if quest == self.infoprefix.singleAll then
					self:SyncSendPrepare(true)
				else
					self:SyncSendPrepare(nil, quest)
				end
			end
		end

	-- receive done command
	elseif prefix == self.prefix.done then
		local pos,_,questId,msgcount = strfind(msg, "(%d+)_(%d+)")

		if not pos then
			return -- not match done rule
		end

		questId = tonumber(questId)
		msgcount = tonumber(msgcount)

		-- check if quest is exist, or receive completed
		if (questId==0 or not self.PartyQuest[sender][questId] or msgcount==0 or getn(self.PartyQuest[sender][questId])~=msgcount) then
			return
		end

		local phased = self:MsgPhase(self.PartyQuest[sender][questId])
		self.PartyQuest[sender][questId] = nil

		if phased then
			if type(self.db.account.PartyQuest[sender])~="table" then
				self.db.account.PartyQuest[sender] = {}
				tinsert(self.db.account.PartyQuest[sender], phased)
				self:FrameNeedUpdate() --update gui items
				return
			end

			for k,v in self.db.account.PartyQuest[sender] do
				if v.questTitle == phased.questTitle then
					self.db.account.PartyQuest[sender][k] = phased
					self:FrameNeedUpdate() --update gui items
					return
				end
			end
			tinsert(self.db.account.PartyQuest[sender], phased)
			self:FrameNeedUpdate() --update gui items
		end

	-- receive send commands
	elseif strfind(prefix, self.prefix.send) then
		local _,_, questId, msgId = strfind(prefix, self.prefix.send.."_(%d+)_(%d+)")
		questId = tonumber(questId)
		msgId = tonumber(msgId)
		if not questId or not msgId or questId==0 or msgId==0 then
			return
		end

		if type(self.PartyQuest[sender])~="table" then
			self.PartyQuest[sender] = {}
		end
		if type(self.PartyQuest[sender][questId])~="table" then
			self.PartyQuest[sender][questId] = {}
		end

		self.PartyQuest[sender][questId][msgId] = msg

	-- receive sync commands
	elseif strfind(prefix, self.prefix.sync.."_"..self.player) then
		local _,_,num = strfind(prefix, self.prefix.sync.."_"..self.player.."_(%d+)")
		num = tonumber(num)
		if num == 0 then
			self:SyncRespondDiff(sender)
		else
			if type(self.diffPendding[sender])~="table" then
				self.diffPendding[sender] = {}
			end
			self.diffPendding[sender][num]=msg
		end

	-- receive delete command
	elseif strfind(prefix, self.prefix.delete) then
		local _,_,num = strfind(prefix, self.prefix.delete.."_(%d+)")
		num = tonumber(num)
		if num == 0 then
			local needDelete = self:Msg2Table(self:MsgConcat(self.delPendding[sender]))
			self.delPendding[sender] = nil

			for _,v in needDelete do
				self:SyncDelete(sender, v)
			end
		else
			if type(self.delPendding[sender])~="table" then
				self.delPendding[sender] = {}
			end
			self.delPendding[sender][num]=msg
		end
	end
end

function PartyQuestComm:QuestInit()
	PartyQuestComm.quest = {}
	PartyQuestComm.inited = nil
	for i=1, 50, 1 do
		local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i)
		if questLogTitleText then
			if (level and not isHeader and isComplete and isComplete == 1) then
				PartyQuestComm.quest[questLogTitleText] = 1
			end
		else
			break
		end
	end
	PartyQuestComm.inited = true
end

function PartyQuestComm:IsInParty(name)
	for i=1, MAX_PARTY_MEMBERS, 1 do
		if (UnitName("party"..i) == name) then
			return true
		end
	end
	return
end



--[[
	Sync function block
]]--

function PartyQuestComm:Wrap(text)
	if not text or text == "" then
		return {}
	end

	local wrap = {}
	local len, loop

	len = strlen(text)

	while true do
		if len > self.wraplen then
			tinsert(wrap, strsub(text, 1, self.wraplen))
			text = strsub(text, self.wraplen+1)
			len = strlen(text)
		else
			tinsert(wrap, text)
			break
		end
	end
	return wrap
end

function PartyQuestComm:MsgConcat(msgTable)
	local msg = ""
	for _,v in ipairs(msgTable) do
		msg = msg..v
	end
	msg = gsub(msg, "<br>", "\n")
	return msg
end

function PartyQuestComm:MsgPhase(msg)
	msg = self:MsgConcat(msg)
	local pos1, _, questTitle, questLevel, questTag, questComplete, questDescription, questObjectives, reqTime, reqMoney, reqOBJ, rewardMoney, rewardSpell, rewardRewards, rewardChoices =
		strfind(msg,
		self.infoprefix.questTitle .."(.+);;"..
		self.infoprefix.questLevel .."(%d+);;"..
		self.infoprefix.questTag .."(.*);;"..
		self.infoprefix.questComplete .."([%d-]+);;"..

		self.infoprefix.questDescription .."(.+);;"..
		self.infoprefix.questObjectives .."(.+);;"..

		self.infoprefix.reqTime .."([%d-]*);;"..
		self.infoprefix.reqMoney .."(%d*);;"..
		self.infoprefix.reqOBJ .."(.*);;"..

		self.infoprefix.rewardMoney .."(%d*);;"..
		self.infoprefix.rewardSpell .."(.*);;"..

		self.infoprefix.rewardRewards .."(.*);;"..
		self.infoprefix.rewardChoices .."(.*);;"
		)

	if not pos1 then
		return
	end

	return {
		questTitle = questTitle,
		questLevel = questLevel,
		questTag = questTag,
		questComplete = questComplete,

		questDescription = questDescription,
		questObjectives = questObjectives,

		reqTime = reqTime,
		reqMoney = reqMoney,
		reqOBJ = self:Msg2Table(reqOBJ),

		rewardMoney = rewardMoney,
		rewardSpell = rewardSpell,

		rewardRewards = self:Msg2Table(rewardRewards),
		rewardChoices = self:Msg2Table(rewardChoices)
	}
end

function PartyQuestComm:Msg2Table(msg)
	if not msg or msg == "" then
		return {}
	end
	if not strfind(msg, ",,") then
		return {msg}
	end

	local proc = {}
	while true do
		local a,b = strfind(msg, ",,")
		if not a or a == 1 then
			break
		end
		tinsert(proc, strsub(msg, 1, a-1))
		msg = strsub(msg, b+1)
	end
	return proc
end

function PartyQuestComm:SyncSendPrepare(sendAll, questTitle)
	-- do nothing if no party member
	if (GetNumPartyMembers() == 0 or not self.inited) then
		return
	end

	-- don't accept more than 20 queue
	-- don't accept sendall if still queue exists
	local queueNum = getn(self.sendPool)
	if queueNum>20 or (queueNum>0 and sendAll) then
		return self:ScheduleRepeatingEvent(self.prefix.send, self.SyncSendReal, 2)
	end

	for i=1, 50, 1 do
		local questLogTitleText, level, questTag, isHeader, _, isComplete = GetQuestLogTitle(i)
		if questLogTitleText then
			if not isHeader and (sendAll or (not sendAll and questTitle and questTitle == questLogTitleText)) then

				SelectQuestLogEntry(i)

				-- title, level, tag, complete
				if not isComplete then
					isComplete = 0
				end
				if not questTag then
					questTag = ""
				end

				-- description
				local questDescription, questObjectives = GetQuestLogQuestText()

				-- reuqire
				local TimeLeft = GetQuestLogTimeLeft()
				if not TimeLeft then
					TimeLeft = -1
				end
				local questRequireMoney = GetQuestLogRequiredMoney()
				local numObjectives = GetNumQuestLeaderBoards()
				local objInfo=""
				for i=1, numObjectives, 1 do
					objectiveDesc = GetQuestLogLeaderBoard(i)
					objInfo = objInfo..objectiveDesc..",,"
				end

				-- rewards
				local rewardMoney = GetQuestLogRewardMoney()
				local spellName = ""
				if GetQuestLogRewardSpell() then
					_, spellName = GetQuestLogRewardSpell()
				end

				-- push all msg too spool
				local sendPool = self:Wrap(gsub(
					self.infoprefix.questTitle..questLogTitleText..";;"..
					self.infoprefix.questLevel..level..";;"..
					self.infoprefix.questTag..questTag..";;"..
					self.infoprefix.questComplete..isComplete..";;"..

					self.infoprefix.questDescription..questDescription..";;"..
					self.infoprefix.questObjectives..questObjectives..";;"..

					self.infoprefix.reqTime..TimeLeft..";;"..
					self.infoprefix.reqMoney..questRequireMoney..";;"..
					self.infoprefix.reqOBJ..objInfo..";;"..

					self.infoprefix.rewardMoney..rewardMoney..";;"..
					self.infoprefix.rewardSpell..spellName..";;"
					,"\n","<br>"))

				-- rewards
				local numRewards = GetNumQuestLogRewards()
				local reward = self.infoprefix.rewardRewards
				local j = 1
				for i=1, numRewards, 1 do
					local _, _, numItems = GetQuestLogRewardInfo(i)
					local link = GetQuestLogItemLink("reward", i)
					if link then
						reward = reward .. link .. " x" .. numItems .. ",,"

						j = j + 1
						if j >= 2 then
							tinsert(sendPool, reward)
							reward = ""
							j = 0
						end
					end
				end
				if reward ~= "" then
					tinsert(sendPool, reward)
				end
				-- add section done padding
				local padding = getn(sendPool)
				sendPool[padding] = sendPool[padding] .. ";;"

				-- choices rewards
				local numRewards = GetNumQuestLogChoices()
				local reward = self.infoprefix.rewardChoices
				local j = 1
				for i=1, numRewards, 1 do
					local _, _, numItems = GetQuestLogChoiceInfo(i)
					local link = GetQuestLogItemLink("choice", i)
					if link then
						reward = reward .. link .. " x" .. numItems .. ",,"

						j = j + 1
						if j >= 2 then
							tinsert(sendPool, reward)
							reward = ""
							j = 0
						end
					end
				end
				if reward ~= "" then
					tinsert(sendPool, reward)
				end
				-- add section done padding
				local padding = getn(sendPool)
				sendPool[padding] = sendPool[padding] .. ";;"

				-- push sendPool to queue
				tinsert(self.sendPool, {id=i, info=sendPool, last=getn(sendPool)})
			end
		else
			break
		end
	end

	-- start msg send
	-- send clear signal
	if sendAll then
		SendAddonMessage(self.prefix.clear, "clear", "PARTY")
	end
	-- start send queue
	self:ScheduleRepeatingEvent(self.prefix.send, self.SyncSendReal, 2)
end

function PartyQuestComm:SyncSendReal()
	-- stop schedule if no queue
	if getn(PartyQuestComm.sendPool) == 0 then
		PartyQuestComm:CancelScheduledEvent(PartyQuestComm.prefix.send)
		return
	end

	local send = PartyQuestComm.sendPool[1]
	if type(send)=="table" and send.id and send.info and send.last then
		for k,v in send.info do
			SendAddonMessage(PartyQuestComm.prefix.send.."_".. send.id .."_"..k , v, "PARTY")
		end
		SendAddonMessage(PartyQuestComm.prefix.done, send.id.."_"..send.last, "PARTY")
	end
	-- remove already processed queue
	tremove(PartyQuestComm.sendPool, 1)
end

function PartyQuestComm:SyncRequest(player, quest)
	if not player or player == "" or player == self.infoprefix.singleAll then
		SendAddonMessage(self.prefix.request, self.infoprefix.all, "PARTY")
		return
	end
	if self:IsInParty(player) then
		if not quest or quest == "" then
			quest = self.infoprefix.singleAll
		end
		SendAddonMessage(self.prefix.request, self.infoprefix.single..player..";;"..quest, "PARTY")
	end
end

function PartyQuestComm:PartyQuestClean()
	for k,_ in self.db.account.PartyQuest do
		if not self:IsInParty(k) then
			self.db.account.PartyQuest[k]=nil
		end
	end
end

function PartyQuestComm:SyncSendDiff(player)
	if not self:IsInParty(player) then return end
	local db = self.db.account.PartyQuest[player]
	if not db or type(db)~="table" or getn(db)==0 then
		self:SyncRequest(player)
		return
	end

	local send = ""
	for _,v in db do
		send = send .. v.questTitle .. ",,"
	end
	send = self:Wrap(send)

	for k,v in send do
		SendAddonMessage(self.prefix.sync.."_"..player.."_"..k, v, "PARTY")
	end
	SendAddonMessage(self.prefix.sync.."_"..player.."_0", "00", "PARTY")
end

function PartyQuestComm:SyncRespondDiff(sender)
	if not sender or not self:IsInParty(sender) or type(self.diffPendding[sender])~="table" then return end
	local diff = self:Msg2Table(self:MsgConcat(self.diffPendding[sender]))
	-- remove from pendding queue
	self.diffPendding[sender] = nil

	local needDelete = {}
	local needAdd = {}

	if getn(diff)==0 then
		self:SyncSendPrepare()
		return
	else
		for _,v in diff do
			local isDelete = true
			for i=1,50,1 do
				local questLogTitleText, _, _, isHeader = GetQuestLogTitle(i)
				if questLogTitleText then
					if not isHeader then
						if v == questLogTitleText then
							isDelete = nil
						end
					end
				else
					break
				end
			end
			if isDelete then
				tinsert(needDelete, v)
			end
		end
		for i=1,50,1 do
			local questLogTitleText, _, _, isHeader = GetQuestLogTitle(i)
			if questLogTitleText then
				if not isHeader then
					local isAdd = true
					for _,v in diff do
						if v == questLogTitleText then
							isAdd = nil
						end
					end
					if isAdd then
						tinsert(needAdd, questLogTitleText)
					end
				end
			else
				break
			end
		end
	end

	-- send delete commands
	if getn(needDelete)>0 then
		local send = ""
		for _,v in needDelete do
			send = send .. v .. ",,"
		end
		send = self:Wrap(send)
		for k,v in send do
			SendAddonMessage(self.prefix.delete.."_"..k, v, "PARTY")
		end
		SendAddonMessage(self.prefix.delete.."_0", "00", "PARTY")
	end

	-- send add quest
	if getn(needAdd)>0 then
		for _,v in needAdd do
			self:SyncSendPrepare(nil, v)
		end
	end
end

function PartyQuestComm:SyncDelete(sender, questTitle)
	if type(self.db.account.PartyQuest[sender])=="table" and getn(self.db.account.PartyQuest[sender])>0 then
		for k,v in self.db.account.PartyQuest[sender] do
			if v.questTitle == questTitle then
				tremove(self.db.account.PartyQuest[sender], k)
				self:FrameNeedUpdate()
				return
			end
		end
	end
end





--[[
	frame functions
]]--
function PartyQuestComm:FrameShowHide()
	if PartyQuestCommFrame:IsVisible() then
		PartyQuestCommFrame:Hide()
	else
		PartyQuestCommFrame:Show()
		self:FrameUpdate()
	end
end

function PartyQuestComm:TitleButton_OnClick()
	PartyQuestCommFrame.selectedButtonID = this:GetID() + FauxScrollFrame_GetOffset(PartyQuestCommFrame_ScrollFrame)
	PartyQuestComm:FrameUpdate()
	PartyQuestComm:FrameDetailUpdate()

	if PartyQuestComm.guiMethod == "party" then
		if arg1 == "RightButton" then
			if PartyQuestComm.guiPlayer and PartyQuestComm:IsInParty(PartyQuestComm.guiPlayer) and PartyQuestCommFrame.selectedTitle then
				PartyQuestComm:SyncRequest(PartyQuestComm.guiPlayer, PartyQuestCommFrame.selectedTitle)
			end
		elseif ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and this:GetText()) then
			ChatFrameEditBox:Insert(this:GetText())
		end
	end
end

function PartyQuestComm:TitleButton_OnEnter()
	if PartyQuestComm.guiMethod == "party" then
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
		GameTooltip:SetText(this:GetText())
		GameTooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..L["Right Click to update this quest detail."]..FONT_COLOR_CODE_CLOSE)
		GameTooltip:Show()
	end
end

function PartyQuestComm:Button_OnEnter()
	GameTooltip_SetDefaultAnchor(GameTooltip, this)
	local onenter_text = this:GetName().."_OnEnter"
	GameTooltip:SetText(L[onenter_text])
	GameTooltip:Show()
end

function PartyQuestComm:FrameUpdate()
	if not self.guiMethod or self.guiMethod == "" then
		self.guiMethod = "log" --setting default method
	end

	local db, max
	if self.guiMethod == "log" then
		db = self.db.account.Log
		max = self.db.account.logSaved
		self.guiPlayer = nil
	else
		db = {}
		max = MAX_QUESTLOG_QUESTS

		if self.guiPlayer and self.guiPlayer ~= "" then
			for k,_ in self.db.account.PartyQuest do
				if k == self.guiPlayer then
					db = self.db.account.PartyQuest[k]
					break
				end
			end
			if not db then
				db = {}
			end
		end
	end

	-- update quest count
	local total = getn(db)
	PartyQuestCommFrame_QuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, total, max))
	PartyQuestCommFrame_CountMiddle:SetWidth(PartyQuestCommFrame_QuestCount:GetWidth())

	-- ScrollFrame update
	FauxScrollFrame_Update(PartyQuestCommFrame_ScrollFrame, total, self.QUESTS_DISPLAYED, 16, nil, nil, nil, PartyQuestCommFrame_HighlightFrame, 293, 316 )

	-- Update the quest listing
	PartyQuestCommFrame_HighlightFrame:Hide()
	if not PartyQuestCommFrame.selectedButtonID or PartyQuestCommFrame.selectedButtonID > total then
		PartyQuestCommFrame.selectedButtonID = 0
	end

	local questIndex, questLogTitle, title, questTag, questComplete
	for i=1, self.QUESTS_DISPLAYED, 1 do
		questIndex = i + FauxScrollFrame_GetOffset(PartyQuestCommFrame_ScrollFrame)
		questLogTitle = getglobal("PartyQuestCommFrame_Title"..i)
		if questIndex <= total then

			if self.guiMethod == "log" then
				if type(db[questIndex]) == "table" then
					title = db[questIndex].sender .. ": " .. db[questIndex].msg
				else
					title = ""
				end

			else
				if type(db[questIndex]) == "table" then
					if tonumber(db[questIndex].questComplete) == 1 then
						questComplete = " ("..L["COMPLETED"]..")"
					elseif tonumber(db[questIndex].questComplete) == -1 then
						questComplete = " ("..L["FAILED"]..")"
					else
						questComplete = ""
					end
					if db[questIndex].questTag ~= "" then
						questTag = " ("..db[questIndex].questTag..")"
					else
						questTag = ""
					end

					title = "["..db[questIndex].questLevel.."] " .. db[questIndex].questTitle .. questTag .. questComplete
				else
					title = ""
				end
			end
			questLogTitle:SetText(title)

			local color = QuestDifficultyColor["difficult"]
			if db[questIndex].questComplete then
				if tonumber(db[questIndex].questComplete) == 1 then
					color = QuestDifficultyColor["standard"]
				elseif tonumber(db[questIndex].questComplete) == -1 then
					color = QuestDifficultyColor["verydifficult"]
				end
			end
			questLogTitle:SetTextColor(color.r, color.g, color.b)
			questLogTitle:Show()

			if PartyQuestCommFrame.selectedButtonID == questIndex then
				PartyQuestCommFrame_HighlightFrame:SetPoint("TOPLEFT", "PartyQuestCommFrame_Title"..i, "TOPLEFT", 0, 0)
				PartyQuestCommFrame_HighlightFrame_SkillHighlight:SetVertexColor(color.r, color.g, color.b)
				PartyQuestCommFrame_HighlightFrame:Show()
				questLogTitle:LockHighlight()
				PartyQuestCommFrame.selectedTitle = db[questIndex].questTitle
			else
				questLogTitle:UnlockHighlight()
			end
		else
			questLogTitle:Hide()
		end
	end
end

function PartyQuestComm:FrameDetailUpdate()
	if not PartyQuestCommFrame.selectedButtonID or PartyQuestCommFrame.selectedButtonID == 0 or not self.guiMethod or self.guiMethod=="" then
		PartyQuestCommFrame_DetailFrame:Hide()
		return
	end
	local QuestId = PartyQuestCommFrame.selectedButtonID

	local db, questTitle, questObjectives, reqOBJ, questComplete
	if self.guiMethod == "log" then
		db = self.db.account.Log
		if not db[QuestId] then
			PartyQuestCommFrame_DetailFrame:Hide()
			return
		end
		questTitle = db[QuestId].msg
		questObjectives = format(L["log_detail"], db[QuestId].sender, date("%Y-%m-%d %H:%M:%S",db[QuestId].time), db[QuestId].msg)

		PartyQuestCommFrame_DetailFrame_Title:SetText(questTitle)
		PartyQuestCommFrame_DetailFrame_ScrollChild_QuestTitle:SetText(questTitle)
		PartyQuestCommFrame_DetailFrame_ScrollChild_ObjectivesText:SetText(questObjectives)

		PartyQuestCommFrame_DetailFrame_ScrollChild_Objective:Hide()
		PartyQuestCommFrame_DetailFrame_ScrollChild_DescriptionTitle:Hide()
		PartyQuestCommFrame_DetailFrame_ScrollChild_QuestDescription:Hide()
		PartyQuestCommFrame_DetailFrame_ScrollChild_RewardTitleText:Hide()
		PartyQuestCommFrame_DetailFrame_ScrollChild_ItemChooseText:Hide()
	else
		if self.guiPlayer and self.guiPlayer ~= "" then
			for k,_ in self.db.account.PartyQuest do
				if k == self.guiPlayer then
					db = self.db.account.PartyQuest[k]
					break
				end
			end
			if not db then
				PartyQuestCommFrame_DetailFrame:Hide()
				return
			end

			if db[QuestId].questTag ~= "" then
				questTag = " ("..db[QuestId].questTag..")"
			else
				questTag = ""
			end
			questTitle = "["..db[QuestId].questLevel.."] " .. db[QuestId].questTitle .. questTag

			questObjectives = db[QuestId].questObjectives
			reqOBJ = ""
			for _,v in db[QuestId].reqOBJ do
				reqOBJ = reqOBJ .. v .. "\n"
			end
			if tonumber(db[QuestId].reqMoney) > 0 then
				reqOBJ = reqOBJ .. L["Money Requirement: "] .. self:MoneyDisplay(db[QuestId].reqMoney) .. "\n"
			end
			if tonumber(db[QuestId].reqTime) > -1 then
				reqOBJ = reqOBJ .. L["Time Left: "] .. db[QuestId].reqTime .. "\n"
			end

			PartyQuestCommFrame_DetailFrame_Title:SetText(questTitle)
			PartyQuestCommFrame_DetailFrame_ScrollChild_QuestTitle:SetText(questTitle)
			PartyQuestCommFrame_DetailFrame_ScrollChild_ObjectivesText:SetText(questObjectives)
			if reqOBJ ~= "" then
				PartyQuestCommFrame_DetailFrame_ScrollChild_Objective:SetText(reqOBJ)
				PartyQuestCommFrame_DetailFrame_ScrollChild_Objective:Show()
			else
				PartyQuestCommFrame_DetailFrame_ScrollChild_Objective:Hide()
			end
			PartyQuestCommFrame_DetailFrame_ScrollChild_DescriptionTitle:Show()
			PartyQuestCommFrame_DetailFrame_ScrollChild_QuestDescription:SetText(db[QuestId].questDescription)
			PartyQuestCommFrame_DetailFrame_ScrollChild_QuestDescription:Show()

			-- rewards, choices, money, spell item update
			self:FrameItems_Update(db[QuestId].rewardRewards, db[QuestId].rewardChoices, db[QuestId].rewardMoney, db[QuestId].rewardSpell)
		else
			PartyQuestCommFrame_DetailFrame:Hide()
			return
		end
	end


	PartyQuestCommFrame_DetailFrame_ScrollScrollBar:SetValue(0)
	PartyQuestCommFrame_DetailFrame_Scroll:UpdateScrollChildRect()
	PartyQuestCommFrame_DetailFrame_Scroll:Show()
	PartyQuestCommFrame_DetailFrame:Show()
end

function PartyQuestComm:MoneyDisplay(money)
	money = tonumber(money)
	local gold,silver,coin
	if money>10000 then
		gold = floor(money/10000)
		silver = floor(money-(gold*10000)/100)
		coin = money-gold*10000-silver*100
		return gold.."g"..silver.."s"..coin.."c"
	elseif money>100 then
		silver = floor(money-(gold*10000)/100)
		coin = money-gold*10000-silver*100
		return silver.."s"..coin.."c"
	else
		coin = money
		return coin.."c"
	end
end

function PartyQuestComm:FrameNeedUpdate()
	if PartyQuestCommFrame:IsVisible() then
		self:FrameUpdate()
	end
	if PartyQuestCommFrame_DetailFrame:IsVisible() then
		self:FrameDetailUpdate()
	end
end

function PartyQuestComm:DropDown_DisplaySelection_Load()
	UIDropDownMenu_Initialize(this, PartyQuestComm.DropDown_DisplaySelection_List)
	if PartyQuestComm.guiPlayer then
		UIDropDownMenu_SetText(PartyQuestComm.guiPlayer)
	else
		UIDropDownMenu_SetText(L["display_log"])
	end
end

function PartyQuestComm:DropDown_DisplaySelection_List()
	local info = {}
	info.text = L["display_log"]
	info.value = PartyQuestComm.infoprefix.log
	info.notCheckable = 1
	info.func = PartyQuestComm.DropDown_DisplaySelection_Select
	UIDropDownMenu_AddButton(info)

	for i=1, MAX_PARTY_MEMBERS, 1 do
		local name = UnitName("party"..i)
		if name then
			local info = {}
			info.text = name
			info.value = name
			info.notCheckable = 1
			info.func = PartyQuestComm.DropDown_DisplaySelection_Select
			UIDropDownMenu_AddButton(info)
		end
	end
end

function PartyQuestComm:DropDown_DisplaySelection_Select()
	local value = this.value
	if (value) then
		if value == PartyQuestComm.infoprefix.log then
			PartyQuestComm.guiMethod="log"
			PartyQuestComm.guiPlayer=nil
			UIDropDownMenu_SetText(L["display_log"], PartyQuestCommFrame_DisplaySelection)
		elseif (PartyQuestComm:IsInParty(value)) then
			PartyQuestComm.guiMethod="party"
			PartyQuestComm.guiPlayer=value
			UIDropDownMenu_SetText(value, PartyQuestCommFrame_DisplaySelection)
		end
		CloseDropDownMenus()
		PartyQuestComm:FrameUpdate()
	end
end

function PartyQuestComm:DropDown_ActionSelection_Load()
	UIDropDownMenu_Initialize(this, PartyQuestComm.DropDown_ActionSelection_List)
	UIDropDownMenu_SetText(L["choose_action"])
end

function PartyQuestComm:DropDown_ActionSelection_List()
	local info
	info = {text = L["clean_log"], value = "clean_log", notCheckable = 1, func = PartyQuestComm.DropDown_ActionSelection_Select}
	UIDropDownMenu_AddButton(info)

	info = {text = L["update_all"], value = "update_all", notCheckable = 1, func = PartyQuestComm.DropDown_ActionSelection_Select}
	UIDropDownMenu_AddButton(info)

	info = {text = L["update_single_all"], value = "update_single_all", notCheckable = 1, func = PartyQuestComm.DropDown_ActionSelection_Select}
	UIDropDownMenu_AddButton(info)

	info = {text = L["update_single"], value = "update_single", notCheckable = 1, func = PartyQuestComm.DropDown_ActionSelection_Select}
	UIDropDownMenu_AddButton(info)

	info = {text = L["sync_single"], value = "sync_single", notCheckable = 1, func = PartyQuestComm.DropDown_ActionSelection_Select}
	UIDropDownMenu_AddButton(info)

end

function PartyQuestComm:DropDown_ActionSelection_Select()
	local value = this.value
	if not value then return end

	if value == "clean_log" then
		PartyQuestComm.db.account.Log = {}
	elseif value == "update_all" then
		PartyQuestComm:SyncRequest()
	elseif value == "update_single_all" then
		if PartyQuestComm.guiPlayer and PartyQuestComm:IsInParty(PartyQuestComm.guiPlayer) then
			PartyQuestComm:SyncRequest(PartyQuestComm.guiPlayer)
		end
	elseif value == "update_single" then
		if PartyQuestComm.guiPlayer and PartyQuestComm:IsInParty(PartyQuestComm.guiPlayer) and PartyQuestCommFrame.selectedTitle then
			PartyQuestComm:SyncRequest(PartyQuestComm.guiPlayer, PartyQuestCommFrame.selectedTitle)
		end
	elseif value == "sync_single" then
		if PartyQuestComm.guiPlayer and PartyQuestComm:IsInParty(PartyQuestComm.guiPlayer) then
			PartyQuestComm:SyncSendDiff(PartyQuestComm.guiPlayer)
		end
	end
	PartyQuestComm:FrameUpdate()
end


function PartyQuestComm:FrameItems_Update(rewards,choices,money,spell)
	local questState = "PartyQuestCommFrame_DetailFrame_ScrollChild_"
	local numQuestRewards = getn(rewards)
	local numQuestChoices = getn(choices)
	local numQuestSpellRewards = 0
	local spacerFrame = getglobal(questState.."SpacerFrame")
	money = tonumber(money)
	if spell~="" then
		numQuestSpellRewards = 1
	end

	local totalRewards = numQuestRewards + numQuestChoices + numQuestSpellRewards
	local questItemName = questState.."Item"
	local material = QuestFrame_GetMaterial()
	local  questItemReceiveText = getglobal(questState.."ItemReceiveText")
	if ( totalRewards == 0 and money == 0 ) then
		getglobal(questState.."RewardTitleText"):Hide()
	else
		getglobal(questState.."RewardTitleText"):Show()
		QuestFrame_SetTitleTextColor(getglobal(questState.."RewardTitleText"), material)
		QuestFrame_SetAsLastShown(getglobal(questState.."RewardTitleText"), spacerFrame)
	end
	if ( money == 0 ) then
		getglobal(questState.."MoneyFrame"):Hide()
	else
		getglobal(questState.."MoneyFrame"):Show()
		QuestFrame_SetAsLastShown(getglobal(questState.."MoneyFrame"), spacerFrame)
		MoneyFrame_Update(questState.."MoneyFrame", money)
	end

	-- Hide unused rewards
	for i=totalRewards + 1, MAX_NUM_ITEMS, 1 do
		getglobal(questItemName..i):Hide()
	end

	local questItem, name, texture, isTradeskillSpell, quality, isUsable, numItems = 1
	local rewardsCount = 0

	-- Setup choosable rewards
	if ( numQuestChoices > 0 ) then
		local itemChooseText = getglobal(questState.."ItemChooseText")
		itemChooseText:Show()
		QuestFrame_SetTextColor(itemChooseText, material)
		QuestFrame_SetAsLastShown(itemChooseText, spacerFrame)

		local index
		local baseIndex = rewardsCount
		for i=1, numQuestChoices, 1 do
			index = i + baseIndex
			questItem = getglobal(questItemName..index)
			questItem.type = "choice"

			local _,_,itemString,numItems = strfind(choices[i], "(item:%d+:%d+:%d+:%d+).+ x(%d+)")
			numItems = tonumber(numItems)
			local name, _, quality, _, _, _, _, _, texture = GetItemInfo(itemString)

			questItem:SetID(i)
			questItem:Show()
			-- For the tooltip
			-- pass to GameToolTip
			questItem.link = itemString
			questItem.count = numItems
			questItem.fulllink = choices[i]

			QuestFrame_SetAsLastShown(questItem, spacerFrame)
			getglobal(questItemName..index.."Name"):SetText(name)
			SetItemButtonCount(questItem, numItems)
			SetItemButtonTexture(questItem, texture)
			SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
			SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(index - 2), "BOTTOMLEFT", 0, -2)
				else
					questItem:SetPoint("TOPLEFT", questItemName..(index - 1), "TOPRIGHT", 1, 0)
				end
			else
				questItem:SetPoint("TOPLEFT", itemChooseText, "BOTTOMLEFT", -3, -5)
			end
			rewardsCount = rewardsCount + 1
		end
	else
		getglobal(questState.."ItemChooseText"):Hide()
	end

	-- Setup spell rewards
	if ( numQuestSpellRewards > 0 ) then
		local learnSpellText = getglobal(questState.."SpellLearnText")
		learnSpellText:Show()
		QuestFrame_SetTextColor(learnSpellText, material)
		QuestFrame_SetAsLastShown(learnSpellText, spacerFrame)

		--Anchor learnSpellText if there were choosable rewards
		if ( rewardsCount > 0 ) then
			learnSpellText:SetPoint("TOPLEFT", questItemName..rewardsCount, "BOTTOMLEFT", 3, -5)
		else
			learnSpellText:SetPoint("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 0, -5)
		end

		learnSpellText:SetText(REWARD_SPELL..spell)
	else
		getglobal(questState.."SpellLearnText"):Hide()
	end

	-- Setup mandatory rewards
	if ( numQuestRewards > 0 or money > 0) then
		QuestFrame_SetTextColor(questItemReceiveText, material)
		-- Anchor the reward text differently if there are choosable rewards
		if ( numQuestSpellRewards > 0  ) then
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS))
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..rewardsCount, "BOTTOMLEFT", 3, -5)
		elseif ( numQuestChoices > 0  ) then
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS))
			local index = numQuestChoices
			if ( mod(index, 2) == 0 ) then
				index = index - 1
			end
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..index, "BOTTOMLEFT", 3, -5)
		else
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS_ONLY))
			questItemReceiveText:SetPoint("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 3, -5)
		end
		questItemReceiveText:Show()
		QuestFrame_SetAsLastShown(questItemReceiveText, spacerFrame)
		-- Setup mandatory rewards
		local index
		local baseIndex = rewardsCount
		for i=1, numQuestRewards, 1 do
			index = i + baseIndex
			questItem = getglobal(questItemName..index)
			questItem.type = "reward"

			local _,_,itemString,numItems = strfind(rewards[i], "(item:%d+:%d+:%d+:%d+).+ x(%d+)")
			numItems = tonumber(numItems)
			local name, _, quality, _, _, _, _, _, texture = GetItemInfo(itemString)

			questItem:SetID(i)
			questItem:Show()
			-- For the tooltip
			-- pass to GameToolTip
			questItem.link = itemString
			questItem.count = numItems
			questItem.fulllink = rewards[i]

			QuestFrame_SetAsLastShown(questItem, spacerFrame)
			getglobal(questItemName..index.."Name"):SetText(name)
			SetItemButtonCount(questItem, numItems)
			SetItemButtonTexture(questItem, texture)
			SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
			SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);

			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(index - 2), "BOTTOMLEFT", 0, -2)
				else
					questItem:SetPoint("TOPLEFT", questItemName..(index - 1), "TOPRIGHT", 1, 0)
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemReceiveText", "BOTTOMLEFT", -3, -5)
			end
			rewardsCount = rewardsCount + 1
		end
	else
		questItemReceiveText:Hide()
	end
end

function PartyQuestComm:QuestItemOnClick()
	if ( IsControlKeyDown() ) then
		DressUpItemLink(this.fulllink);
	elseif ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(this.fulllink);
		end
	end
end
