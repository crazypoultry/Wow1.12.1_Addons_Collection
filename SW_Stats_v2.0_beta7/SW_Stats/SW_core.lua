--[[

--]]

SW_DBG_STORE = true;
SW_DBG_Log = {};

-- used when ripping apart core SW and SW Stats for people that dont care
-- about stats view but want to share the data
SW_CORE_SYNC_ONLY = false;

-- flag to always recreate the masterorder and go through the brute force sort
--SW_ALWAYS_MO = true;

-- table to look up localized class names (lookup built automtically)
SW_ClassNames = {
	["DRUID"] = "",
	["HUNTER"] = "",
	["MAGE"] = "",
	["PALADIN"] = "",
	["PRIEST"] = "",
	["ROGUE"] = "",
	["SHAMAN"] = "",
	["WARLOCK"] = "",
	["WARRIOR"] = "",
};

SW_CombatTimeInfo = {
	awaitingStart = false,
	awaitingEnd = false,
};
SW_DPS_Dmg =0;
SW_CombatTime = 0;

--settings Table
SW_Settings = {};

-- its the player name we would look it up a LOT
SW_SELF_STRING= "";

-- the "Event Channel" - we need it a LOT
SW_Event_Channel =nil;

SW_EI_ALLOFF = false;

-- 1.5.3 used for colors of the title bars and buttons in them
SW_Registerd_BF_Titles = {};
SW_Registered_BF_TitleButtons = {};
SW_DummyColor = {1,1,1,1};

SW_SpellIDLookUp = {};
SW_PET = "SW_Pet";


function SW_CreateSpellIDLookup()
	for i,v in ipairs(SW_Spellnames) do
		SW_SpellIDLookUp[v] = i;
	end
end


function SW_Stats_OnLoad()
	SW_MEM = gcinfo();
	SlashCmdList["SW_STATS"] = function(msg)
		SW_SlashCommand(msg);
	end
	SLASH_SW_STATS1 = SW_RootSlashes[1];
	SLASH_SW_STATS2 = SW_RootSlashes[2];
	SW_RegisterEvents();
end

SW_Timed_Calls = {

	deltaPending = 0.5, -- 1.4 beta 5 increased + 0.1
	passedPendig =0,
	pendingActive = false,
	
	deltaResize = 0.5,
	passedResize = 0,
	
	deltaSySend = 1.1, -- + 0.1 in 1.2.4 a few more checks going on
	passedSySend = 0,
	
	deltaSyDo = 5,
	passedSyDo = 0,
	
	deltaSyLI = 100, -- lowerd to 100
	passedSyLI = 0,
	
	retryUnknownObject = false, -- added in 1.5 pet mechanics using SyDo timer
	retryZone = false, -- added for 2.0 data model The Zone name isn't set when "player entering world"
	
	--2.0.beta.3 added a timer for group raid update
	rebuildGR = false;
	deltaGR = 1;
	passedGR = 0;
	
	OnUpdate = function (self, elapsed)
		self.passedResize = self.passedResize + elapsed;
		self.passedSySend = self.passedSySend + elapsed;
		self.passedSyDo = self.passedSyDo + elapsed;
		self.passedSyLI = self.passedSyLI + elapsed;
		SW_MPS:update(elapsed);
		
		if self.rebuildGR then
			self.passedGR = self.passedGR + elapsed;
			if self.passedGR > self.deltaGR then
				self.rebuildGR = false;
				self.passedGR = 0;
				SW_DataCollection.meta:updateGroupRaid();
				SW_DataCollection:checkGroup();
				SW_SyncState:setInSync();
				SW_SyncList_ScrollUpdate();
				if SW_BarSyncFrame:IsVisible() then
					SW_BarSyncFrame:UpdateARPVis();
				end
			end
		end
		if self.pendingActive then
			self.passedPendig = self.passedPendig + elapsed;
			if self.passedPendig > self.deltaPending then
				self.pendingActive = false;
				self.passedPendig = 0;
				SW_AcceptPendingCast();
			end
		end
		if self.passedResize > self.deltaResize then
			if SW_SomethingResizing then
				SW_BarLayoutRegisterdOnResize();
			end
			self.passedResize = 0;
		end
		if self.passedSySend > self.deltaSySend then
		
			-- added 1.5.3 for raid per second info
			SW_RPS:updateInfo();
			SW_SyncSend();
			
			-- 2.0.beta.2 added voting again
			if SW_ResetVote.isRunning then
				SW_ResetVote:updateRunning(self.passedSySend);
			end
			
			if not SW_SomethingResizing then
				SW_UpdateBars();
			end
			self.passedSySend = 0;
			if self.retryZone then
				if GetRealZoneText() ~= "" then
					self.retryZone = false;
					if not UnitIsGhost("player") then
						SW_DataCollection:checkZone( GetRealZoneText() );
					end
				end
			end
		end
		if self.passedSyDo > self.deltaSyDo then
			if self.retryUnknownObject then
				self.retryUnknownObject = false;
				-- 2.0 friends/pets
				SW_DataCollection.meta:updateGroupRaid();
			end
			SW_SyncDo();
			self.passedSyDo = 0;
		end
		if self.passedSyLI > self.deltaSyLI then
			SW_SyncState:setInSync();
			self.passedSyLI = 0;
			-- 2.0.beta.6 check if there is something to delete
			if SW_Settings.SW_TL_AutoDelete then
				SW_DataCollection:autoDelete(SW_TL_AUTO_THRESH);
			end
		end
		if SW_CombatTimeInfo.awaitingEnd then
			SW_CombatTime = SW_CombatTime + elapsed;
		end
	end,
	
	StopPending = function (self)
		self.pendingActive = false;
		self.passedPendig = 0;
	end,
	StartPending = function (self)
		self.pendingActive = true;
	end,
	
};


--[[
	
--]]
SW_C_RPS ={
	filters = {["SF"] = "SW_Filter_EverGroup", ["PF"] = "SW_PF_VPR"},
	regFuncs = {},
	regFuncsStart = {},
	new = function (self, o)
		local doResetInit = true;
		if o then
			doResetInit = false;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		o.baseTimer = SW_C_Timer:new(o.baseTimer);
		o.startTimer = SW_C_Timer:new(o.startTimer);
		
		if doResetInit then
			o:resetDPS();
		end
		return o;
	end,
	resetDPS = function(self)
		self.isRunning = false;
		self.allowLastFightUpdate = false;
		self.currentSecs = 0;
		self.totalSecs = 0;
		self.lastFightSecs = 0;
		self.startDmg = 0;
		self.maxDPS = 0;
		self.lastFightDmg = 0;
		self.uglyTruthStarted = false;
		--self.resetPoint = self:getDmg();
		SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Heal"]);
	end,
	
	validEvent = function (self)
		self.lastEvent = self.baseTimer:now();
		
		-- even with the ugly truth time be so nice to wait for first dmg
		if not self.uglyTruthStarted then
			self.uglyTruthStarted = true;
			self.baseTimer:setToNow();
		end
		if not self.isRunning then
			self.startTimer:setToNow();
			self.allowLastFightUpdate = false;
			--self.startDmg = self:getDmg();
			self.isRunning = true;
			SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Damage"]);
			for i,f in ipairs(self.regFuncsStart) do
				f();
			end
		end
	end,
	updateInfo = function (self)
		if not self.isRunning then return; end
		local deltaT = self.startTimer:now() - self.lastEvent;
		if  deltaT > 6 then -- a buffer to keep you "in fight" 1.5.3.beta.1 changed from 5 to 6 (late sync msgs)
			self.isRunning = false;
			self.currentSecs = 0;
			deltaT = self.lastEvent - self.startTimer;
			if deltaT < 1 then deltaT = 1; end -- 1 sec minimum fight time
			self.totalSecs = self.totalSecs + deltaT;
			self.lastFightSecs = deltaT;
			self.allowLastFightUpdate = true;
			SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Heal"]);
			for i,f in ipairs(self.regFuncs) do
				f(deltaT);
			end
		else
			self.currentSecs = self.startTimer:elapsed();
			SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Damage"]);
		end 
	end,
	registerFightEnd = function(self, func)
		assert ( type(func) == "function", "registerFightEnd func is not a function" );
		table.insert(self.regFuncs, func);
	end,
	registerFightStart = function(self, func)
		assert ( type(func) == "function", "registerFightStart func is not a function" );
		table.insert(self.regFuncsStart, func);
	end,
	dump = function (self)
		SW_DumpTable(self);
	end,	
}

function SW_Stats_OnEvent()
	if (event == "VARIABLES_LOADED") then
		
		SW_CheckFixLogStrings();
		
		--2.0 doesn't need this anymore and having it set 
		-- isn't good
		SW_Settings.SYNCLastChan = nil;
		
		--2.0 beta.6 
		--2.0 beta.7 (doh this added NONE)
		-- there was a bug in beta.2 that nilled the entries, this brings them back
		for i, cE in ipairs(SW_ClassFilters) do
			if cE ~= "NONE" and not SW_ClassNames[cE] then
				SW_ClassNames[cE] = "";
				SW_ClassNames.done = false;
			end
		end
		SW_ClassNames["NONE"] = nil;
		
		-- 2.0 beta.6
		if SW_Settings.HideMiniMap then
			SW_IconFrame:Hide();
		else
			SW_IconFrame:Show();
		end
		-- 2.0 beta.6 default auto delete mode is set to true
		if SW_Settings.SW_TL_AutoDelete == nil then
			SW_Settings.SW_TL_AutoDelete = true;
		end
		
		-- does the same as old SW_CreateRegexFromGlobals(); for 2.0
		SW_C_MessageList:initMasterTable();
		-- release this monster function we just need it once
		SW_C_MessageList.initMasterTable = nil;
		
		-- 1.5.1 decurseing, could be used for more
		SW_CreateSpellIDLookup();
		-- 1.5 added pausing, default to running for old versions and new installs
		if SW_Settings["IsRunning"] == nil then
			SW_Settings["IsRunning"] = true;
		end
		if SW_Settings["IsRunning"] then
			SW_UnpauseEvents();
		end
		
		SW_SELF_STRING = UnitName("player");
		
		-- sets the checkboxes to saved values
		SW_SetChkStates(); 
		SW_Event_Channel = getglobal("SW_FrameConsole_Text2_MsgFrame");
		SW_EI_ALLOFF = not (SW_Settings["EI_ShowRegEx"] or  SW_Settings["EI_ShowMatch"]
							or SW_Settings["EI_ShowEvent"] or SW_Settings["EI_ShowOrigStr"]);
							
		
		if SW_Settings["QuickOptCount"] == nil then
			SW_Settings["QuickOptCount"] = 5;
		end
		SW_UpdateOptVis();
		
		-- wow what a headache, an addon called sweep overwrites this with a number oO
		-- causing all sorts of problems
		-- it's not great just to skip it but we can get along without seeding the generator
		if type(math.randomseed) == "function" then
			math.randomseed( time() );
		else
			SW_printStr("math.randomseed is not a funtion... it should be");
		end
		-- localize gui
		for k,v in pairs(SW_GUI) do
			--if its not a table the key is a direct map to the string
			if type(v) ~= "table" then
				getglobal(k):SetText(v);
			else
				--[[v["f"] is the function 
					k is the identifier for the function
					v["s"] is the string
				]]--
				v["f"](k,v["s"]);	 
			end
			
		end
		-- done localizing gui.. drop table
		SW_GUI = nil;
		-- do layout of items
		SW_DoLayout();
		--SW_SyncInit();
		if SW_Settings["ReportAmount"] == nil then
			SW_Settings["ReportAmount"] = 5;
		end
		if SW_Settings["Colors"] == nil then
			SW_Settings["Colors"] = {};
		end
		for k,v in pairs(SW_Default_Colors) do
			if SW_Settings["Colors"][k] == nil then
				SW_Settings["Colors"][k] = v;
			end
		end
		-- 2.0 why not use the colors blizzard provides for classes...
		for k,v in pairs(RAID_CLASS_COLORS ) do
			SW_Settings["Colors"][k][1] = v.r;
			SW_Settings["Colors"][k][2] = v.g;
			SW_Settings["Colors"][k][3] = v.b;
		end
	
		
		if ButtonHole then
			ButtonHole.application.RegisterMod({id="SW_STATS_BH_HOOK", 
                                        name="SW Stats", 
                                        tooltip="SW Stats", 
                                        buttonFrame="SW_IconFrame", 
                                        updateFunction="SW_UpdateIconPos"});
        else
			SW_UpdateIconPos();
		end
		
		--1.5.3 default color mechaniks changed
		if SW_Settings["Colors"]["TitleBars"] == nil then
			SW_Settings["Colors"]["TitleBars"] = {1,0,0,1};
		end
		SW_UpdateTitleColor(SW_Settings["Colors"]["TitleBars"]);
		if SW_Settings["Colors"]["TitleBarsFont"] == nil then
			SW_Settings["Colors"]["TitleBarsFont"] = {1,1,1,1};
		end
		SW_UpdateTitleTextColor(SW_Settings["Colors"]["TitleBarsFont"]);
		if SW_Settings["Colors"]["Backdrops"] == nil then
			SW_Settings["Colors"]["Backdrops"] = {SW_COLOR_ACT["r"],SW_COLOR_ACT["g"],SW_COLOR_ACT["b"],1};
		end
		SW_UpdateFrameBackdrops(SW_Settings["Colors"]["Backdrops"]);
		if SW_Settings["Colors"]["MainWinBack"] == nil then
			SW_Settings["Colors"]["MainWinBack"] = {0,0,0,0.6};
		end
		SW_UpdateMainWinBack(SW_Settings["Colors"]["MainWinBack"])
		
		--1.5.3 retaining vis of the main window
		if SW_Settings["SHOWMAIN"] then
			SW_BarFrame1:Show();
		end
		-- 1.5.3.beta.1 locking frames
		SW_LockFrames(SW_Settings["BFLocked"]);
		
		-- 1.5.3 Raid dps info
		SW_RPS = SW_C_RPS:new(SW_RPS);
		SW_RPS:registerFightEnd(SW_OnFightEnd);
		
		--2.0 settings
		if SW_Settings["TL_SafeMode"] == nil then
			SW_Settings["TL_SafeMode"] = true;
		end
		-- 2.0 DataModel 
		local version, build, date = GetBuildInfo();
		local bstr = version..build..date;
		if bstr ~= SW_Settings.lastWOWBuild then
			SW_printStr("WoW Version Changed - Reverting back to defaults.");
			SW_DBG_Log = {};
			-- shouldn't really be needed but you never know whats changed
			--decided not to reset this if this is ever a problem uncomment the next line
			--SW_SpellsNSchools = nil;
			-- better to rebuild this one
			SW_Parser = nil;
			
			SW_Settings.lastWOWBuild = bstr;
		end
		
		SW_Schools:init();
		SW_SpellsNSchools  = SW_C_SpellsNSchools:new(SW_SpellsNSchools);
		SW_StrTable = SW_C_StringTable:new(SW_StrTable);
		
		SW_DataCollection = SW_C_DataCollection:new(SW_DataCollection);
		SW_DataCollection:registerMarkersChanged(SW_TL_MarkersChanged);
		
		if not SW_Parser or SW_Settings.LAST_V_RUN ~= SW_VERSION then
			SW_DBG_Log = {};
			SW_Parser = SW_DefaultParser;
		end
		SW_Parser = SW_C_Parser:new(SW_Parser);
		SW_IS_BOOT = false;
		
		--SW_ToggleConsole();
		-- a sliding window to count sync messages per second incoming
		SW_MPS = SW_C_SlidingWindow:new(nil,5);
		SW_MPS.inactive = true;
		SW_MPS:register(SW_UpdateMPSString);
		
		SW_Settings.LAST_V_RUN = SW_VERSION;
		if (gcinfo()) - SW_MEM > SW_MEM_WARNING_THRESH then
			StaticPopup_Show("SW_Mem_Warning");
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		local unitName = UnitName("target");
		if not unitName then return; end
		local localizedClass, englishClass = UnitClass("target");
		
		if not (localizedClass and englishClass) then return; end
		
		if not SW_ClassNames.done then
			SW_ClassNames[englishClass] = localizedClass;
			SW_ClassNames.done = true
			for k,v in pairs(SW_ClassNames) do
				if type(v) == "string" and v == "" then
					SW_ClassNames.done = false;
					break;
				end
			end
		end
		
		-- 2.0 meta info
		SW_DataCollection.meta:updateMeta("target");
		
		--[[
		if UnitIsEnemy("player", "target") then
			SW_printStr("ENEMY");
		else
			SW_printStr("Friend");
		end
		--]]
	elseif (event == "SPELLS_CHANGED") then
		-- update if we learn new spells
		if arg1 == nil then
			SW_UpdateCastByNameLookup();
		end
	elseif (event == "SPELLCAST_CHANNEL_START") then
		SW_AcceptSelectedCast();
	elseif (event == "SPELLCAST_STOP") then	
		if SW_SelectedSpell.spellName then
			if SW_SelectedSpell.isInstant then
				SW_AcceptSelectedCast();
			else
				SW_PendingCast:setToSelected();
				SW_SelectedSpell.spellName = nil;
				SW_Timed_Calls:StartPending();
			end
		end
	elseif event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
		SW_Timed_Calls:StopPending();
		SW_SelectedSpell.spellName = nil;
		SW_PendingCast.spellName = nil;
	-- "CHAT_MSG_ADDON" is sent, with arg1-arg3 being the parameters to SendAddonMessage(), and arg4 being the name of the player that sent it.
	--SendAddonMessage("prefix", "text", "PARTY|RAID|GUILD|BATTLEGROUND")
	elseif (event == "CHAT_MSG_ADDON") then
		if arg1 == SW_CHAN_MAIN or arg1 == SW_CHAN_HS then
			SW_MPS:inc(1);
			SW_DoIncSync(arg1,arg2,arg4);
		--elseif arg1 == SW_CHAN_HS then 
		-- a second channel for handshaking and meta info
		--this is only used when joining/leaving group/raid  and for LI messages
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		
		--bar layout needs to go here, only then the "saved (layout-cache.txt)" layout is loaded already
		SW_BarLayoutRegisterd();
		SW_UpdateCastByNameLookup();
		
		-- 2.0 friends/pets
		SW_DataCollection.meta:updateGroupRaid();
		
		-- 2.0 auto markers on zoning
		-- at the time of this event GetRealZoneText() won't return the zone
		-- 2.0.beta.1 this also will trigger creating zone data segments
		-- 2.0.beta.2 only allow creation of new segments if activated and not in sync 
		if SW_Settings.SW_TL_AutoZone and (not SW_SYNC_TO_USE or not SW_SYNC_DO) then
			SW_Timed_Calls.retryZone = true;
		end
		SW_DataCollection:checkGroup();
	elseif (event == "UNIT_PET") then
		SW_DataCollection.meta:updateMeta(arg1);
	
	--[[ beta.4 with this on a timer now we can all pack them into one handle
	elseif (event == "PARTY_MEMBERS_CHANGED") or (event == "PARTY_LEADER_CHANGED") then
		if UnitInRaid("player") then
			return;
		end
		-- 2.0 friends/pets
		
		--SW_DataCollection.meta:updateGroupRaid();
		-- putting this on a timer we just rebuild the group/raid once
		SW_Timed_Calls.rebuildGR = true;
		SW_Timed_Calls.passedGR = 0;
		--SW_DataCollection:checkGroup();
	elseif (event == "RAID_ROSTER_UPDATE") then
		-- 2.0 friends/pets
		--SW_DataCollection.meta:updateGroupRaid();
		-- putting this on a timer we just rebuild the group/raid once
		SW_Timed_Calls.rebuildGR = true;
		SW_Timed_Calls.passedGR = 0;
		--[[
		if SW_BarSyncFrame:IsVisible() then
			SW_BarSyncFrame:UpdateARPVis();
		end
		--]]
		--SW_DataCollection:checkGroup();
	--]]
	elseif (event == "PARTY_MEMBERS_CHANGED") or 
			(event == "PARTY_LEADER_CHANGED") or 
			(event == "RAID_ROSTER_UPDATE") then
		
		SW_Timed_Calls.passedGR = 0;
		SW_Timed_Calls.rebuildGR = true;
		
	elseif (event == "PLAYER_REGEN_DISABLED") then
		SW_CombatTimeInfo.awaitingStart = true;
	elseif (event == "PLAYER_REGEN_ENABLED") then
		SW_CombatTimeInfo.awaitingStart = false;
		SW_CombatTimeInfo.awaitingEnd = false;
	else
		--SW_Parser:DEVhandleEvent(event, arg1);
		SW_Parser:handleEvent(event, arg1);
	end
end
