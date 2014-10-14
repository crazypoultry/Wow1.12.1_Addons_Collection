--[[
	Redid this for 2.0 rv voting
	removed all of the unneeded voting stuff
--]]

SW_VTB = 60; -- spam buffer
SW_VRUN_TIME = 30;
SW_VAFK_TIMER = 20; -- if somebody doesn't answer in this timeframe it's a yes

SW_VO_START_STR= "VO"..SW_SYNC_SEP.."ST"..SW_SYNC_SEP.."%s";
SW_VO_ANSWER_STR= "VO"..SW_SYNC_SEP.."AW"..SW_SYNC_SEP.."%d";

SW_ResetVote = 
{
	
	isRunning = false,
	voteStarted = 0,
	points = {},
	totalPoints = 0,
	pointsPro = 0,
	pointsCon = 0,
	pendingName = "",
	hasVoted = false;
	send = function (self, newName)
		if  self.isRunning or (GetTime() - self.voteStarted) < SW_VTB then
			DEFAULT_CHAT_FRAME:AddMessage(SW_STR_VOTE_WARN);
			return;
		end
		
		self.isRunning = true;
		self.voteStarted = GetTime();
		SW_SyncSendHS(string.format(SW_VO_START_STR, newName));
		
	end,
	reset = function (self)
		local meta;
		local sID;
		for k,v in pairs(self.points) do
			self.points[k] = 0;
		end
		self.totalPoints =0;
		self.pointsPro =0;
		self.pointsCon =0;
		self.pendingName = "";
		self.hasVoted = false;
		
		-- 2.0 friends/pets
		SW_DataCollection.meta:updateGroupRaid();
		SW_SyncState:setInSync();
		
		for k,v in pairs (SW_SyncState.peerLookup) do
			local sID = SW_StrTable:hasID(k);
			if sID then
				meta = SW_DataCollection.meta[sID];
				if meta then
					if meta.rank == 1 then
						self.points[k] =10;
					elseif meta.rank == 2 then
						self.points[k] =100;
					else
						self.points[k] = 1;
					end
				else
					self.points[k] = 1;
					SW_printStr("SW_ResetVote:reset() no meta");
				end
				self.totalPoints = self.totalPoints + self.points[k];
			end
		end	
	end,
	
	issueVote = function (self, isPro)
		if isPro then
			SW_SyncSendHS(string.format(SW_VO_ANSWER_STR, 1));
		else 
			SW_SyncSendHS(string.format(SW_VO_ANSWER_STR, 0));
		end
		self.hasVoted = true;
	end,
	updateRunning = function (self, elapsed)
		local delta = GetTime() - self.voteStarted;
		if delta > SW_VRUN_TIME then
			self.isRunning = false;
			self.voteStarted = 0;
			--StaticPopup_Hide("SW_ResetSyncVote");
		elseif delta > SW_VAFK_TIMER and not self.hasVoted then
			self:issueVote(true);
			StaticPopup_Hide("SW_ResetSyncVote");
		end
	end,	
	
	addAnswer = function (self, isPro, from)
		if isPro then
			self.pointsPro = self.pointsPro + (self.points[from] or 0)
		else
			self.pointsCon = self.pointsCon + (self.points[from] or 0)
		end
		if self.pointsPro > self.totalPoints/2 then
			self.isRunning = false;
			self.voteStarted = 0;
			--reset data
			SW_SyncReset(SW_SYNC_SESSION + 1, self.pendingName);
			DEFAULT_CHAT_FRAME:AddMessage(SW_STR_RV_PASSED);
			StaticPopup_Hide("SW_ResetSyncVote");
		elseif self.pointsCon > self.totalPoints/2 then
			self.isRunning = false;
			self.voteStarted = 0;
			DEFAULT_CHAT_FRAME:AddMessage(SW_STR_RV_FAILED);
			StaticPopup_Hide("SW_ResetSyncVote");
		end
	end,
};


function SW_SyncHandleVoting(data, from)
	--[[
	SW_printStr("SW_SyncHandleVoting data");
	SW_DumpTable(data);
	--]]
	if data[2] == "ST" then
		SW_ResetVote:reset();
		SW_ResetVote.pendingName = data[3];
		if SW_Settings["SY_AutoVote"] == 1 then
			SW_ResetVote:issueVote(true);
		elseif SW_Settings["SY_AutoVote"] == 0 then
			SW_ResetVote:issueVote(false);
		else
			StaticPopupDialogs.SW_ResetSyncVote.text = string.format(SW_STR_RV, from);
			StaticPopup_Show("SW_ResetSyncVote");
		end
	elseif data[2] == "AW" then
		if tonumber(data[3]) == 1 then
			SW_ResetVote:addAnswer(true, from);
		else
			SW_ResetVote:addAnswer(false, from);
		end
	end
end