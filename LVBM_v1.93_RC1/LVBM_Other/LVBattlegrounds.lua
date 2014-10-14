--
-- Alterac und Arathi Battleground Mods
--
-- based on v1.0 from LeoLeal,  thanks
-- by Nitram to v1.2 with auto turn-In for alterac valley
-- by Nitram to v1.4 with Arathi Basin Time to End Bar, bugfixes etc.
-- by Nitram to v1.5 with WSG Flag Info Frame and a lot of Bugfixes.
-- by Nitram to v1.6 with only Local Bars, Option to change "bar" text, Colored Bars
-- by Nitram to v1.7 - changed localizations
--

LVBM.AddOns.Battlegrounds = { 
	["Name"] = LVBM_BGMOD_LANG.NAME, 
	["Abbreviation1"] = "bg", 
	["Version"] = "1.7", 
	["Author"] = "Nitram + LeoLeal", 
	["Description"] = LVBM_BGMOD_LANG.INFO,
	["Instance"] = LVBM_OTHER, 
	["GUITab"] = LVBMGUI_TAB_OTHER, 
	["Sort"] = 0, 
	["Options"] = {
		["Enabled"] = true, 
		["Announce"] = false, 
		["AVAutoTurnIn"] = true, 
		["ShowWsgFrame"] = true,
		["StringAlliance"] = LVBM_BGMOD_LANG.AB_STRINGALLIANCE.." ",	-- If you want to change the Bar text use (or something like this):
		["StringHorde"] = LVBM_BGMOD_LANG.AB_STRINGHORDE.." ",		-- /script LVBM.AddOns.Battlegrounds.Options.StringHorde = "[Horde]";
	}, 
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Battlegrounds.Options.AVAutoTurnIn", 
			["text"] = LVBM_BGMOD_LANG.AV_TURNININFO, 
			["func"] = function() LVBM.AddOns.Battlegrounds.Options.AVAutoTurnIn = not LVBM.AddOns.Battlegrounds.Options.AVAutoTurnIn; end, 
		}, 
		[2] = {
			["variable"] = "LVBM.AddOns.Battlegrounds.Options.ShowWsgFrame", 
			["text"] = LVBM_BGMOD_LANG.WSG_INFOFRAME_INFO, 
			["func"] = function() LVBM.AddOns.Battlegrounds.Options.ShowWsgFrame = not LVBM.AddOns.Battlegrounds.Options.ShowWsgFrame; end, 
		}, 
	}, 
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_BG_SYSTEM_NEUTRAL"] = true,
		["CHAT_MSG_BG_SYSTEM_ALLIANCE"] = true, 
		["CHAT_MSG_BG_SYSTEM_HORDE"] = true, 
		["PLAYER_ENTERING_WORLD"] = true,
		["ZONE_CHANGED_NEW_AREA"] = true,
		["GOSSIP_SHOW"] = true, 			-- Turn In
		["QUEST_PROGRESS"] = true, 			-- Turn In
		["QUEST_COMPLETE"] = true, 			-- Turn In
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,	-- WSG Boots Timer
		["UPDATE_BATTLEFIELD_SCORE"] = true, 
	}, 	
	["GetItemName"] = function(bag,  slot)
		local itemlink;
		if (bag == -1) then	itemlink = GetInventoryItemLink("player",  slot);
		else			itemlink = GetContainerItemLink(bag,  slot);
		end
		if (itemlink) then
			local _,  _,  name = string.find(itemlink,  "^.*%[(.*)%].*$");
			return name;
		else	return "";
		end
	end, 
	["GetItemCount"] = function(ItemName)
		local anzl,  bagNr,  bagSlot = 0;
		for bagNr = 0,  10,  1 do
			for bagSlot = 1,  GetContainerNumSlots(bagNr),  1 do
				if( LVBM.AddOns.Battlegrounds.GetItemName(bagNr,  bagSlot) == ItemName) then
					local _,  itemCount = GetContainerItemInfo(bagNr,  bagSlot);
					anzl = anzl + itemCount;
				end
			end
		end
		return anzl;
	end, 
	["ABGetScore"] = function()		-- LVBM.AddOns.Battlegrounds.ABGetScore
		if( GetZoneText() == LVBM_BGMOD_LANG.AB_ZONE ) then
			_, mAllyInfo = GetWorldStateUIInfo(1);
			_, mHordeInfo = GetWorldStateUIInfo(2);
			if( not mAllyInfo or not mHordeInfo ) then return false; end

			_, _, AllyBases, AllyScore = string.find(mAllyInfo, LVBM_BGMOD_LANG.AB_SCOREEXP);
			_, _, HordeBases, HordeScore = string.find(mHordeInfo, LVBM_BGMOD_LANG.AB_SCOREEXP);
			if( not AllyBases or not AllyScore or not HordeBases or not HordeScore) then return false; end

			AllyBases	= tonumber( AllyBases );
			AllyScore	= tonumber( AllyScore );
			HordeBases	= tonumber( HordeBases );
			HordeScore	= tonumber( HordeScore );

			return true, AllyBases, AllyScore, HordeBases, HordeScore;
		else return false;
		end
	end,
	["ABLastTick"] = {
		["LastAllyCount"] = 0,
		["LastHordeCount"] = 0,
		["Alliance"] = {
			["Score"] = 0,
			["Time"] = 0,
			["Bases"] = 0,
		},
		["Horde"] = {
			["Score"] = 0,
			["Time"] = 0,
			["Bases"] = 0,
		},
	},
	["ABResPerSec"] = function(bases)
		bases = tonumber(bases);
		local value = 0.0;		-- Used values from BGAssist because my times where wrong
		if(bases == 1) then	value = 25.0 / 30.0;		-- 25 res per 30 sec
		elseif(bases == 2) then	value = (300.0 / 9.0) / 30.0; 	-- 33.3(repeating) per 30 sec
		elseif(bases == 3) then	value = 50.0  / 30.0;		-- 50 res per 30 sec
		elseif(bases == 4) then	value = 100.0 / 30.0;		-- 100 res per 30 sec
		elseif(bases == 5) then	value = 900.0 / 30.0;		-- 900 res per 30 sec
		end
		return value;
	end,
	["WSGInfoFrame"] = function(showframe)
		if( LVBMWsgInfoFrame ) then
			if( LVBMWsgInfoFrame:GetObject():IsShown() and not showframe ) then	LVBMWsgInfoFrame:Hide();
			elseif( showframe ) then 						LVBMWsgInfoFrame:Show(); end
		elseif( showframe ) then
			LVBM.AddOns.Battlegrounds.WSGInfoFrameCreate();
		end		
	end,
	["WSGInfoFrameCreate"] = function()
		LVBMWsgInfoFrame = LVBMGui:CreateInfoFrame(LVBM_BGMOD_LANG.WSG_INFOFRAME_TITLE, LVBM_BGMOD_LANG.WSG_INFOFRAME_TEXT);
		if( not LVBMWsgInfoFrame ) then 
			LVBM.AddMsg("Can't get Frame from CreateInfoFrame()");
			return false; 
		end

		LVBMWsgInfoFrameAllianceFlag 	= LVBMWsgInfoFrame:CreateStatusBar(0, 1, 1, LVBM_BGMOD_LANG.WSG_ALLYFLAG..LVBM_BGMOD_LANG.WSG_FLAG_BASE);
		LVBMWsgInfoFrameAllianceFlag:GetObject():SetStatusBarColor(0,0,1);
		LVBMWsgInfoFrameAllianceFlag:GetObject():EnableMouse(true);
		LVBMWsgInfoFrameAllianceFlag:GetObject():SetScript("OnMouseUp", function() 
								TargetByName(LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[1], true); 
							end);

		LVBMWsgInfoFrameHordeFlag 	= LVBMWsgInfoFrame:CreateStatusBar(0, 1, 1, LVBM_BGMOD_LANG.WSG_HORDEFLAG..LVBM_BGMOD_LANG.WSG_FLAG_BASE);
		LVBMWsgInfoFrameHordeFlag:GetObject():SetStatusBarColor(1,0,0);
		LVBMWsgInfoFrameHordeFlag:GetObject():EnableMouse(true);
		LVBMWsgInfoFrameHordeFlag:GetObject():SetScript("OnMouseUp", function() 
								TargetByName(LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[2], true); 
							end);
	end,
	["WSGInfoFrameTarget"] = { [1] = "", [2] = "" },
	["OnUpdate"] = function()
		if( GetZoneText() == LVBM_BGMOD_LANG.AB_ZONE ) then
			local mOk, AllyBases, AllyScore, HordeBases, HordeScore = LVBM.AddOns.Battlegrounds.ABGetScore();
	
			if( mOk and LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Score ~= AllyScore ) then		-- Update Time on Score Change
				LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Score = AllyScore;
				LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Bases = AllyBases;
				LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Time = time();
			end
			if( mOk and LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Score ~= HordeScore ) then
				LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Score = HordeScore;
				LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Bases = HordeBases;
				LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Time = time();
			end
		end
	end,
	["OnEvent"] = function(event,  arg1)

		if(event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" and string.find(arg1, LVBM_BGMOD_LANG.WSG_BOOTS_EXPR) )then
			LVBM.StartStatusBarTimer(10, "Speed Boots");
			-- Respawn Timer seems to be around 165-175 Seconds (dynamic)
			return;	-- no other code needs this event
		end

		-- ------------------------ --
		-- WSG InfoFrame - FlagCaps --
		-- ------------------------ --
		if( event == "ZONE_CHANGED_NEW_AREA" and GetZoneText() == LVBM_BGMOD_LANG.WSG_ZONE ) and LVBM.AddOns.Battlegrounds.Options.ShowWsgFrame then
			LVBM.AddOns.Battlegrounds.WSGInfoFrame(true);

		elseif( event == "ZONE_CHANGED_NEW_AREA" and GetZoneText() ~= LVBM_BGMOD_LANG.WSG_ZONE and LVBMWsgInfoFrame ) then
			LVBM.AddOns.Battlegrounds.WSGInfoFrame(false);
		end

		if (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE") and LVBM.AddOns.Battlegrounds.Options.ShowWsgFrame then
			if( LVBMWsgInfoFrame ) then
				if( string.find(arg1, LVBM_BGMOD_LANG.WSG_FLAG_PICKUP) ) then
					local _, _, sArg1, sArg2 =  string.find(arg1, LVBM_BGMOD_LANG.WSG_FLAG_PICKUP);
					local mSide, mNick;
					-- I don't know how to set Expression Capture Index for string.find :(
					if( GetLocale() == "deDE" ) then 	mSide = sArg2; mNick = sArg1;
					else					mSide = sArg1; mNick = sArg2;
					end
					if( mSide == LVBM_BGMOD_LANG.ALLIANCE ) then
						LVBMWsgInfoFrameAllianceFlag:SetTitle(LVBM_BGMOD_LANG.WSG_ALLYFLAG..mNick);
						LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[1] = mNick;

					elseif( mSide == LVBM_BGMOD_LANG.HORDE ) then
						LVBMWsgInfoFrameHordeFlag:SetTitle(LVBM_BGMOD_LANG.WSG_HORDEFLAG..mNick);
						LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[2] = mNick;
					end
	
				elseif( string.find(arg1, LVBM_BGMOD_LANG.WSG_FLAG_RETURN) ) then
					local _, _, mSide, mNick =  string.find(arg1, LVBM_BGMOD_LANG.WSG_FLAG_RETURN);
					if( mSide == LVBM_BGMOD_LANG.ALLIANCE ) then
						LVBMWsgInfoFrameAllianceFlag:SetTitle(LVBM_BGMOD_LANG.WSG_ALLYFLAG..LVBM_BGMOD_LANG.WSG_FLAG_BASE);
						LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[1] = "";

					elseif( mSide == LVBM_BGMOD_LANG.HORDE ) then
						LVBMWsgInfoFrameHordeFlag:SetTitle(LVBM_BGMOD_LANG.WSG_HORDEFLAG..LVBM_BGMOD_LANG.WSG_FLAG_BASE);
						LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[2] = "";
					end

				elseif( string.find(arg1, LVBM_BGMOD_LANG.WSG_HASCAPTURED) ) then	-- get point
					LVBMWsgInfoFrameAllianceFlag:SetTitle(LVBM_BGMOD_LANG.WSG_ALLYFLAG..LVBM_BGMOD_LANG.WSG_FLAG_BASE);
					LVBMWsgInfoFrameHordeFlag:SetTitle(LVBM_BGMOD_LANG.WSG_HORDEFLAG..LVBM_BGMOD_LANG.WSG_FLAG_BASE);
					LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[1] = "";
					LVBM.AddOns.Battlegrounds.WSGInfoFrameTarget[2] = "";
				end
			end
		end

		----------------
		-- AB WinTime --
		----------------
		if( GetZoneText() == LVBM_BGMOD_LANG.AB_ZONE ) then

		  	if( LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Score < 2000 
			and LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Score < 2000
			and (LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Score + LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Score) > 0
			and (LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Bases + LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Bases) > 0 ) then

				if( LVBM.AddOns.Battlegrounds.ABLastTick.LastAllyCount ~= LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Bases 
				 or LVBM.AddOns.Battlegrounds.ABLastTick.LastHordeCount ~= LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Bases ) then
					LVBM.Schedule(2, "LVBM.AddOns.Battlegrounds.OnEvent", "GetNewABTimes");		-- Try this because the GetScore 
															-- issnt Sync and this suxx hard !!!
				end
			end
		else 
			-- AB TimeLeft
			LVBM.EndStatusBarTimer("AB_WINALLY", true);
			LVBM.EndStatusBarTimer("AB_WINHORDE", true);
		end
		if( event == "GetNewABTimes" ) then

				AllyTime = ((2000 - LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Score) 
				            / LVBM.AddOns.Battlegrounds.ABResPerSec(LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Bases))
					    - (time()-LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Time);

				HordeTime = ((2000 - LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Score) 
				             / LVBM.AddOns.Battlegrounds.ABResPerSec(LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Bases))
					     - (time()-LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Time);

				if( AllyTime > 5000 ) then 	AllyTime = 5000; end
				if( HordeTime > 5000 ) then 	HordeTime = 5000; end
			
				LVBM.AddOns.Battlegrounds.ABLastTick.LastAllyCount = LVBM.AddOns.Battlegrounds.ABLastTick["Alliance"].Bases; 
				LVBM.AddOns.Battlegrounds.ABLastTick.LastHordeCount = LVBM.AddOns.Battlegrounds.ABLastTick["Horde"].Bases;

				if( AllyTime == HordeTime ) then
					LVBM.EndStatusBarTimer("AB_WINALLY", true);
					LVBM.EndStatusBarTimer("AB_WINHORDE", true);

				elseif( AllyTime > HordeTime ) then		-- Horde wins!
					if( LVBM.GetStatusBarTimerTimeLeft("AB_WINALLY") ) then
						LVBM.UpdateStatusBarTimer("AB_WINALLY", 0, HordeTime, "AB_WINHORDE", true);

					elseif( LVBM.GetStatusBarTimerTimeLeft("AB_WINHORDE") ) then
						LVBM.UpdateStatusBarTimer("AB_WINHORDE", 0, HordeTime, nil, true);
					else
						LVBM.StartStatusBarTimer(HordeTime, "AB_WINHORDE", nil, true);
					end

				elseif( HordeTime > AllyTime ) then		-- Alliance wins!
					if( LVBM.GetStatusBarTimerTimeLeft("AB_WINHORDE") ) then
						LVBM.UpdateStatusBarTimer("AB_WINHORDE", 0, AllyTime, "AB_WINALLY", true);

					elseif( LVBM.GetStatusBarTimerTimeLeft("AB_WINALLY") ) then
						LVBM.UpdateStatusBarTimer("AB_WINALLY", 0, AllyTime, nil, true);
					else
						LVBM.StartStatusBarTimer(AllyTime, "AB_WINALLY", nil, true);
					end
				end
		end
		
		-------------------
		-- AV AutoTurnIn --
		-------------------
		if ((event == "GOSSIP_SHOW" or event=="QUEST_PROGRESS") and GetZoneText() == LVBM_BGMOD_LANG.AV_ZONE) then
			local target = UnitName("target");

			if( target == LVBM_BGMOD_LANG.AV_NPC.SMITHREGZAR or target == LVBM_BGMOD_LANG.AV_NPC.MURGOTDEEPFORGE ) then
				-- Open Quest to Smith or Murgot
				if (LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.ARMORSCRAPS) >= 20) then
					SelectGossipAvailableQuest(1);
				end

			elseif( target == LVBM_BGMOD_LANG.AV_NPC.PRIMALISTTHURLOGA) then
				local anzl = LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.SOLDIERSBLOOD);
				if (anzl >= 5) then		SelectGossipAvailableQuest(2);
				elseif (anzl > 0) then		SelectGossipAvailableQuest(1);
				end

			elseif( target == LVBM_BGMOD_LANG.AV_NPC.ARCHDRUIDRENFERAL) then
				local anzl = LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.STORMCRYSTAL);
				if (anzl >= 5) then		SelectGossipAvailableQuest(2);
				elseif (anzl > 0) then		SelectGossipAvailableQuest(1);
				end

			elseif( target == LVBM_BGMOD_LANG.AV_NPC.STORMPIKERAMRIDERCOMMANDER) then	-- Ram Riders
				if (LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.FROSTWOLFHIDE) > 0) then
					SelectGossipAvailableQuest(1);
				end

			elseif( target == LVBM_BGMOD_LANG.AV_NPC.FROSTWOLFWOLFRIDERCOMMANDER) then	-- Wolf Riders
				if (LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.ALTERACRAMHIDE) > 0) then
					SelectGossipAvailableQuest(1);
				end
			end

		end
		if (event=="QUEST_PROGRESS" and GetZoneText() == LVBM_BGMOD_LANG.AV_ZONE) then
			local target = UnitName("target");

			if (target == LVBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERJEZTOR 
			   and LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.LIEUTENANTSFLESH) == 0) then		return;

			elseif (target == LVBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERGUSE
			   and LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.SOLDIERSFLESH) == 0) then		return;

			elseif (target == LVBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERMULVERICK
			   and LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.COMMANDERSFLESH) == 0) then		return;

			elseif (target == LVBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERVIPORE
			   and LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.LIEUTENANTSMEDAL) == 0) then		return;

			elseif (target == LVBM_BGMOD_LANG.AV_NPC.WINDCOMMANDERSLIDORE
			   and LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.SOLDIERSMEDAL) == 0) then		return;

			elseif (target == LVBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERICHMAN
			   and LVBM.AddOns.Battlegrounds.GetItemCount(LVBM_BGMOD_LANG.AV_ITEM.COMMANDERSMEDAL) == 0) then		return;

		   	end
			CompleteQuest();

		end
		if (event=="QUEST_COMPLETE" and GetZoneText() == LVBM_BGMOD_LANG.AV_ZONE) then
			local target = UnitName("target");
			for index,  value in LVBM_BGMOD_LANG.AV_NPC do
				if (target == value) then
					GetQuestReward(0);
					LVBM.AddMsg(LVBM_BGMOD_LANG.THANKS);
				end
			end
		end


		-- ----------------- --
		-- Code from LeoLeal --
		-- modded by Nitram  --
		-- ----------------- --
		if (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE") then
			for index, value in ipairs(LVBM_BGMOD_LANG.AB_TARGETS) do
				if string.find(arg1, value) then
					if string.find(arg1, LVBM_BGMOD_LANG["AB_HASASSAULTED"]) or string.find(arg1, LVBM_BGMOD_LANG["AB_CLAIMSTHE"]) then
						--Initiate a timer w/ value as text string for 60 seconds
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
						LVBM.StartColoredStatusBarTimer(64,  LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), 0,0,1,1, true);

					elseif string.find(arg1, LVBM_BGMOD_LANG["AB_HASDEFENDEDTHE"]) or string.find(arg1, LVBM_BGMOD_LANG["AB_HASTAKENTHE"]) then
						--clear a timer for value
						if string.find(arg1, LVBM_BGMOD_LANG["AB_HASTAKENTHE"]) then
							LVBM.Announce(string.format(LVBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, LVBM.Capitalize(LVBM_BGMOD_LANG.AB_TARGETS[index])));
							oldFlashColor=LVBM.Options.FlashColor;
							LVBM.Options.FlashColor = "blue";
							LVBM.AddSpecialWarning("", false, true);
							LVBM.Options.FlashColor = oldFlashColor;
						end
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
					end
				end
			end
			
			-- WSG Capture Flag
			if (string.find(arg1, LVBM_BGMOD_LANG["WSG_HASCAPTURED"])) then
				oldFlashColor=LVBM.Options.FlashColor;
				LVBM.Options.FlashColor = "blue";
				LVBM.AddSpecialWarning("", false, true);
				LVBM.Options.FlashColor = oldFlashColor;
				LVBM.StartStatusBarTimer(23, "Flag respawn", true);
			end
			
			--Initial capture of Snowfall for horde
			if string.find(string.lower(arg1), string.lower(LVBM_BGMOD_EN_TARGET_AV[8])) then
				LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM_BGMOD_EN_TARGET_AV[8], true);
				LVBM.StartColoredStatusBarTimer(303,  LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM_BGMOD_EN_TARGET_AV[8], 0,0,1,1, true);
			end
		elseif (event == "CHAT_MSG_BG_SYSTEM_HORDE") then
			for index, value in ipairs(LVBM_BGMOD_LANG.AB_TARGETS) do
				if string.find(arg1, value) then
					if string.find(arg1, LVBM_BGMOD_LANG["AB_HASASSAULTED"]) or string.find(arg1, LVBM_BGMOD_LANG["AB_CLAIMSTHE"]) then
						--Initiate a timer w/ value as text string for 60 seconds
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
						LVBM.StartColoredStatusBarTimer(64, LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), 1,0,0,1, true);
					elseif string.find(arg1, LVBM_BGMOD_LANG["AB_HASDEFENDEDTHE"]) or string.find(arg1, LVBM_BGMOD_LANG["AB_HASTAKENTHE"]) then
						--clear a timer for value
						if string.find(arg1, LVBM_BGMOD_LANG["AB_HASTAKENTHE"]) then
							LVBM.Announce(string.format(LVBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, LVBM.Capitalize(LVBM_BGMOD_LANG.AB_TARGETS[index])));
							oldFlashColor=LVBM.Options.FlashColor;
							LVBM.Options.FlashColor = "red";
							LVBM.AddSpecialWarning("", false, true);
							LVBM.Options.FlashColor = oldFlashColor;
						end
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
					end
				end
			end			
			-- WSG Capture
			if (string.find(arg1,LVBM_BGMOD_LANG["WSG_HASCAPTURED"])) then
				oldFlashColor=LVBM.Options.FlashColor;
				LVBM.Options.FlashColor = "red";
				LVBM.AddSpecialWarning("", false, true);
				LVBM.Options.FlashColor = oldFlashColor;
				LVBM.StartStatusBarTimer(23, "Flag respawn", true);
			end
		
			--Initial capture of Snowfall for horde
			if string.find(string.lower(arg1), string.lower(LVBM_BGMOD_EN_TARGET_AV[8])) then
				LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM_BGMOD_EN_TARGET_AV[8], true);
				LVBM.StartColoredStatusBarTimer(303, LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM_BGMOD_EN_TARGET_AV[8], 1,0,0,1, true);
			end
			
		-- Alterac Valley Specific Yells
		elseif (event == "CHAT_MSG_MONSTER_YELL") then
			for index,  value in ipairs(LVBM_BGMOD_LANG["AV_TARGETS"]) do
				if string.find(string.lower(arg1), string.lower(value)) then

					if string.find(arg1, LVBM_BGMOD_LANG["AV_UNDERATTACK"]) then
						--Initiate a timer w/ value as text string for 300 seconds
						if string.find(arg1, LVBM_BGMOD_LANG["HORDE"]) then 
							LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM_BGMOD_EN_TARGET_AV[index], true);
							LVBM.StartColoredStatusBarTimer(303,  LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM_BGMOD_EN_TARGET_AV[index], 1,0,0,1, true);
						end
						if string.find(arg1, LVBM_BGMOD_LANG["ALLIANCE"]) then
							LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM_BGMOD_EN_TARGET_AV[index], true);
							LVBM.StartColoredStatusBarTimer(303,  LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM_BGMOD_EN_TARGET_AV[index], 0,0,1,1, true);
						end
					elseif string.find(arg1, LVBM_BGMOD_LANG["AV_WASDESTROYED"]) or string.find(arg1, LVBM_BGMOD_LANG["AV_WASTAKENBY"]) then
						--clear a timer for value
						if string.find(arg1, LVBM_BGMOD_LANG["ALLIANCE"]) then
							LVBM.Announce(string.format(LVBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, value));
							oldFlashColor=LVBM.Options.FlashColor;
							LVBM.Options.FlashColor = "blue";
							LVBM.AddSpecialWarning("", false, true);
							LVBM.Options.FlashColor = oldFlashColor;
						end
						if string.find(arg1, LVBM_BGMOD_LANG["HORDE"]) then
							LVBM.Announce(string.format(LVBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, value));
							oldFlashColor=LVBM.Options.FlashColor;
							LVBM.Options.FlashColor = "red";
							LVBM.AddSpecialWarning("", false, true);
							LVBM.Options.FlashColor = oldFlashColor;
						end
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM_BGMOD_EN_TARGET_AV[index], true);
						LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM_BGMOD_EN_TARGET_AV[index], true);
					end
				end
			end

			--Ivus and Ice Lord
			if string.find(arg1,LVBM_BGMOD_LANG["AV_IVUS"]) then 
				LVBM.StartStatusBarTimer(603,  "Ivus spawn", true);
			elseif string.find(string.lower(arg1),string.lower(LVBM_BGMOD_LANG["AV_ICEY"])) then
				LVBM.StartStatusBarTimer(603,  "Ice spawn", true);
			end

		-- Begining Match Timers and End Matches
		elseif (event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
			if (arg1 == LVBM_BGMOD_LANG["WSG_START60SEC"]
			 or arg1 == LVBM_BGMOD_LANG["AB_START60SEC"]
			 or arg1 == LVBM_BGMOD_LANG["AV_START60SEC"] ) then
					LVBM.EndStatusBarTimer("Begins", true);
					LVBM.StartStatusBarTimer(62, "Begins", true);

			elseif (arg1 == LVBM_BGMOD_LANG["WSG_START30SEC"]
			     or arg1 == LVBM_BGMOD_LANG["AB_START30SEC"]
			     or arg1 == LVBM_BGMOD_LANG["AV_START30SEC"] ) then
					LVBM.EndStatusBarTimer("Begins", true);
					LVBM.StartStatusBarTimer(32, "Begins", true);
			end

			-- Resets Timers when BGMatch Ends (Note that this is different than Leaving BG)
			if string.find(arg1, LVBM_BGMOD_LANG["WINS"]) then
				LVBM.EndStatusBarTimer("Flag respawn", true);
				for index, value in ipairs(LVBM_BGMOD_LANG.AB_TARGETS) do
					LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true, true);
					LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true, true);
				end
				for index, value in ipairs(LVBM_BGMOD_EN_TARGET_AV) do
					LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM_BGMOD_EN_TARGET_AV[index], true);
					LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM_BGMOD_EN_TARGET_AV[index], true);
				end
			end

		-- Reset Timers when leaving BG
		elseif (event == "PLAYER_ENTERING_WORLD") then
			LVBM.EndStatusBarTimer("Begins");
			LVBM.EndStatusBarTimer("Flag respawn");
			for index, value in ipairs(LVBM_BGMOD_LANG.AB_TARGETS) do
				LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
				LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM.Capitalize(LVBM_BGMOD_EN_TARGET_AB[index]), true);
			end
			for index, value in ipairs(LVBM_BGMOD_EN_TARGET_AV) do
				LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringHorde..LVBM_BGMOD_EN_TARGET_AV[index], true);
				LVBM.EndStatusBarTimer(LVBM.AddOns.Battlegrounds.Options.StringAlliance..LVBM_BGMOD_EN_TARGET_AV[index], true);
			end
		end
	end, 	
	

};


