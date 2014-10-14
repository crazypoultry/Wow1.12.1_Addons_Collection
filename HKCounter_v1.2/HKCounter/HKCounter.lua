--[[
				 Honor Kills Counter
		written by Torrid - Black Dragonflight/Dentarg servers
]]

HKC_VERSION = "1.2";

HKC_CFG = {
	VERBOSE = true,
}

HKC_KILLSTODAY = {};
HKC_KILLSLIFETIME = {};
HKC_STANDINGS = {};

HKC_LASTKILL = "";
HKC_PLAYER = nil;
HKC_VARSLOADED = false;
HKC_PENDINGUPDATE = false;
HKC_LASTWIN_TIMESTAMP = 0;

HKCHonorBonusHistory = {};
HKCBGHonorHistory = {};
HKCLastEstimated = 0;
HKCInBattleground = false;
HKCMap = "";
HKCEnterTime = 0;

function HKC_OnLoad()
	SlashCmdList["HKC"] = HKCCmdLine;
	SLASH_HKC1 = "/hkc"; 

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
--	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("INSPECT_HONOR_UPDATE");
--	this:RegisterEvent("UPDATE_WORLD_STATES");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Honor Kill Counter v"..HKC_VERSION.." AddOn loaded.  /hkc for command list");
	end
end

function HKCResetToday(forcereset)
	local hk, dk, contribution, rank;

	-- Yesterday's values
	hk, dk, contribution = GetPVPYesterdayStats();

	-- if yesterday's values differ from when last logged in, wipe kills for today
	if (	HKC_CFG[HKC_PLAYER].YHK ~= hk or
		HKC_CFG[HKC_PLAYER].YDK ~= dk or
		HKC_CFG[HKC_PLAYER].YC ~= contribution or
		forcereset
	) then
		-- new day
		HKC_CFG[HKC_PLAYER].YHK = hk;
		HKC_CFG[HKC_PLAYER].YDK = dk;
		HKC_CFG[HKC_PLAYER].YC = contribution;

		HKC_KILLSTODAY[HKC_PLAYER] = {};

		-- add yesterday's CP to this weeks'
		HKC_CFG[HKC_PLAYER].CPthisweek.CP = HKC_CFG[HKC_PLAYER].CPthisweek.CP + contribution;
		HKC_CFG[HKC_PLAYER].CPthisweek.days = HKC_CFG[HKC_PLAYER].CPthisweek.days + 1;

		-- wipe estinated CP for today
		HKC_CFG[HKC_PLAYER].ESTCP.blizztoday = 0;
		HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday = 0;

		DEFAULT_CHAT_FRAME:AddMessage("HKC daily counter reset", 1, 0, 0);
	end
end

function HKCResetThisWeek(forcereset)
	local hk, dk, contribution, rank;

	-- Last Week's values
	hk, dk, contribution, rank = GetPVPLastWeekStats();
	
	-- if last week's values differ from when last logged in, wipe standings array and kills for this week
	if (	HKC_CFG[HKC_PLAYER].LWHK ~= hk or
		HKC_CFG[HKC_PLAYER].LWDK ~= dk or
		HKC_CFG[HKC_PLAYER].LWC ~= contribution or
		HKC_CFG[HKC_PLAYER].LWrank ~= rank or
		forcereset
	) then
		-- new week
		HKC_CFG[HKC_PLAYER].LWHK = hk;
		HKC_CFG[HKC_PLAYER].LWDK = dk;
		HKC_CFG[HKC_PLAYER].LWC = contribution;
		HKC_CFG[HKC_PLAYER].LWrank = rank;

		HKC_WBLSTANDINGS[HKC_PLAYER] = HKC_STANDINGS[HKC_PLAYER];	-- week before last standings
		HKC_STANDINGS[HKC_PLAYER] = {};

		-- wipe estinated CP for this week
		HKC_CFG[HKC_PLAYER].CPthisweek.CP = 0;
		HKC_CFG[HKC_PLAYER].CPthisweek.days = 0;

		if (rank and rank > 0) then
			local pvpname, pvprank;
			pvpname, pvprank = GetPVPRankInfo(UnitPVPRank("player"));
			HKC_STANDINGS[HKC_PLAYER][rank] = {
					name = UnitName("player"),
					ranktitle = pvpname,
					ranknum = pvprank,
					class = UnitClass("player"),
					HKs = hk,
					contribution = contribution,
					progress = GetPVPRankProgress(),
			};
		end

		DEFAULT_CHAT_FRAME:AddMessage("HKC standings reset", 1, 0, 0);
	end
end

function HKCLogin()

	HKC_PLAYER = UnitName("player").." "..GetCVar("realmName");

	-- new player?
	if (not HKC_KILLSLIFETIME[HKC_PLAYER]) then
		HKC_CFG[HKC_PLAYER] = { YHK = 0, YDK = 0, YC = 0};
		HKC_KILLSLIFETIME[HKC_PLAYER] = {};
		HKC_KILLSTODAY[HKC_PLAYER] = {};
	end

	if (not HKC_STANDINGS[HKC_PLAYER]) then
		HKC_STANDINGS[HKC_PLAYER] = {};
	end

	-- if user had a version previous to .98b, or clean install
	if (not HKC_WBLSTANDINGS) then
		HKC_WBLSTANDINGS = {};
		HKC_STANDINGS = {};		-- reset standings for new version
	end

	if (not HKC_WBLSTANDINGS[HKC_PLAYER]) then
		HKC_WBLSTANDINGS[HKC_PLAYER] = {};
	end

	if (not HKC_CFG[HKC_PLAYER].LWHK) then
		HKC_CFG[HKC_PLAYER] = { LWHK = 0, LWDK = 0, LWC = 0, LWrank = 0 };
	end

	if (not HKC_CFG[HKC_PLAYER].ESTCP) then
		HKC_CFG[HKC_PLAYER].ESTCP = {
			blizztoday = 0,
			HKCtoday = 0,
		};
	end

	if (not HKC_CFG[HKC_PLAYER].CPthisweek) then
		HKC_CFG[HKC_PLAYER].CPthisweek = {
			CP = 0,
			days = 0,
		};
	end

	-- check for new day, reset if it is
	HKCResetToday();

	-- check for new week
	HKCResetThisWeek();

end

function HKCGetPlayerName()
	local pname;

	pname = UnitName("player");
	if (pname and pname ~= UNKNOWNOBJECT and pname ~= UKNOWNBEING and pname ~= "Unknown Entity") then
		HKCLogin();
	end
end

function HKC_EstimateCP(ecp)
	if (HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL] > 10) then
		return 0
	elseif (HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL] == 1) then
		return ecp
	else
		return ecp - ( (HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL] - 1) / 10 * ecp );
	end
end

function HKC_OnEvent(event)
	if (event == "UPDATE_MOUSEOVER_UNIT") then
		if ( UnitExists("mouseover") and HKC_KILLSTODAY[HKC_PLAYER][UnitName("target")] ) then
			-- GameTooltipTextRight3:SetText("("..HKC_KILLSTODAY[HKC_PLAYER][UnitName("target")].." kills today)");
			-- GameTooltipTextRight3:Show();
			if (GameTooltipTextLeft3:GetText() == "PvP") then
				GameTooltipTextLeft3:SetText("PvP ("..HKC_KILLSTODAY[HKC_PLAYER][UnitName("target")].." kills today)");
			end
		end

	elseif (event == "PLAYER_TARGET_CHANGED" and HKC_CFG.VERBOSE) then
		if (	UnitExists("target")
			and UnitIsPlayer("target")
			and UnitIsEnemy("target", "player")
			and UnitIsPVP("target")
			and not UnitIsTrivial("target")
		) then
			if (HKC_KILLSTODAY[HKC_PLAYER][UnitName("target")]) then
				UIErrorsFrame:AddMessage("killed "..HKC_KILLSTODAY[HKC_PLAYER][UnitName("target")].." times", 1.0, 1.0, 1.0, 1.0, 1);
			else
				UIErrorsFrame:AddMessage("never killed today", 1.0, 1.0, 1.0, 1.0, 1);
			end
		end

	elseif (event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
		local rank, ecp, HKCest;

		_, _, HKC_LASTKILL, rank, ecp = string.find(arg1, "^(.+)%s+dies%, honorable kill Rank: (.+) %(Estimated Honor Points: (%d+)%)$");

		if (not HKC_LASTKILL) then

			_, _, HKC_LASTKILL = string.find(arg1, "^You have been awarded (%d+) honor points%.$");
			if (HKC_LASTKILL) then
				HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday = HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday + tonumber(HKC_LASTKILL);
				HKC_CFG[HKC_PLAYER].ESTCP.blizztoday = HKC_CFG[HKC_PLAYER].ESTCP.blizztoday + tonumber(HKC_LASTKILL);

				table.insert(HKCHonorBonusHistory, date()..": +"..HKC_LASTKILL);
				if (table.getn(HKCHonorBonusHistory) > 30) then
					table.remove(HKCHonorBonusHistory, 1);
				end

				return
			end

			_, _, HKC_LASTKILL = string.find(arg1, "^(.+)%s+dies%, dishonorable kill%.$");
			if (HKC_CFG.VERBOSE and HKC_LASTKILL) then
				DEFAULT_CHAT_FRAME:AddMessage("Warning: Dishonorable Kill ("..HKC_LASTKILL..")", 1, 0, 0);
			elseif (HKC_CFG.VERBOSE) then
				DEFAULT_CHAT_FRAME:AddMessage("HKC Error: unrecognized honor gain msg '"..arg1.."'");
			end

			return
		end

		if (not HKC_KILLSLIFETIME[HKC_PLAYER][HKC_LASTKILL]) then
			HKC_KILLSLIFETIME[HKC_PLAYER][HKC_LASTKILL] = 0;
		end
		if (not HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL]) then
			HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL] = 0;
		end
		HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL] = HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL] + 1;
		HKC_KILLSLIFETIME[HKC_PLAYER][HKC_LASTKILL] = HKC_KILLSLIFETIME[HKC_PLAYER][HKC_LASTKILL] + 1;

		if (ecp) then
			HKCest = HKC_EstimateCP(ecp);

			HKC_CFG[HKC_PLAYER].ESTCP.blizztoday = HKC_CFG[HKC_PLAYER].ESTCP.blizztoday + ecp;
			HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday = HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday + HKCest;
		end

		if (HKC_CFG.VERBOSE) then
--			DEFAULT_CHAT_FRAME:AddMessage(HKC_LASTKILL.." kills today: "..HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL].."  Total: "..HKC_KILLSLIFETIME[HKC_PLAYER][HKC_LASTKILL].."  Rank: "..rank);
			DEFAULT_CHAT_FRAME:AddMessage(HKC_LASTKILL.." kills today: "..HKC_KILLSTODAY[HKC_PLAYER][HKC_LASTKILL].."  Rank: "..rank.."  Est. Honor: "..math.floor(HKCest));
		end

--[[
	elseif (event == "UPDATE_WORLD_STATES") then
		if ( GetBattlefieldWinner() ) then

			local battlefieldWinner = GetBattlefieldWinner();
			local i;
			local numScores = GetNumBattlefieldScores();
			local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class;

			if (numScores > 0) then
				for i = 1, numScores do
					name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(i);
					if (name == UnitName("player")) then
						break;
					end
				end
			end

			-- if your team won, and last UPDATE_WORLD_STATES was more than 5 mins ago (it goes off twice)
			if (battlefieldWinner == faction and HKC_LASTWIN_TIMESTAMP < (GetTime() - 300)) then
				-- you won
				DEFAULT_CHAT_FRAME:AddMessage(honorGained.." bonus honor added to HKC estimate", 1, 1, 0);
				HKC_LASTWIN_TIMESTAMP = GetTime();
				HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday = HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday + honorGained;
			end

		end
]]

	elseif (event == "INSPECT_HONOR_UPDATE") then

		-- do not record players if inside a battleground
		local i, id;
		for i=1, MAX_BATTLEFIELD_QUEUES do
			_, _, id = GetBattlefieldStatus(i);
			if (id ~= 0) then
				return
			end
		end

		local sessionHK, sessionDK, yesterdayHK, yesterdayHonor, thisweekHK, thisweekHonor, lastweekHK, lastweekHonor, lastweekStanding, lifetimeHK, lifetimeDK, lifetimeRank = GetInspectHonorData();

		local pvpname, pvprank;
		pvpname, pvprank = GetPVPRankInfo(UnitPVPRank("target"));

		if (lastweekStanding and lastweekStanding > 0 and not HKC_STANDINGS[HKC_PLAYER][lastweekStanding]) then
			HKC_STANDINGS[HKC_PLAYER][lastweekStanding] = {
				name = UnitName("target"),
				ranktitle = pvpname,
				ranknum = pvprank,
				class = UnitClass("target"),
				HKs = lastweekHK,
				contribution = lastweekHonor,
				progress = GetInspectPVPRankProgress(),
			};
			DEFAULT_CHAT_FRAME:AddMessage(HKC_STANDINGS[HKC_PLAYER][lastweekStanding].name.." added to HKC standings");
		end

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (HKC_VARSLOADED) then
			HKCGetPlayerName();
		else
			HKC_PENDINGUPDATE = true;
		end

		-- is player entering or leaving a BG?
		local i, id, map, elapsed, gained;
		for i=1, MAX_BATTLEFIELD_QUEUES do

			_, map, id = GetBattlefieldStatus(i);
			if (id ~= 0) then

				-- Player entering a BG

				HKCInBattleground = true;
				HKCMap = map;
				HKCLastEstimated = HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday;
				HKCEnterTime = time();

				table.insert(HKCHonorBonusHistory, date()..": Entered "..map);
				if (table.getn(HKCHonorBonusHistory) > 30) then
					table.remove(HKCHonorBonusHistory, 1);
				end

				return
			end
		end

		if (HKCInBattleground) then

			-- Player just left a BG

			gained = math.floor(HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday - HKCLastEstimated);
			elapsed = math.floor( (time() - HKCEnterTime) / 60 );

			if (gained < 0) then
				gained = "?";
			end

			if (HKC_CFG.VERBOSE) then
				DEFAULT_CHAT_FRAME:AddMessage(HKCMap.." ended.  Time Elapsed: "..elapsed.." minutes   Honor gained: "..gained);
			end

			if (HKCMap == "Eastern Kingdoms") then
				return
			end

			-- Honor bonus history
			table.insert(HKCHonorBonusHistory, date()..": Left "..HKCMap.." -- Time: "..elapsed.."m -- Honor Gained: "..gained);
			if (table.getn(HKCHonorBonusHistory) > 30) then
				table.remove(HKCHonorBonusHistory, 1);
			end

			-- BG Honor History
			if (elapsed > 2 and gained ~= "?") then
				if (not HKCBGHonorHistory[HKCMap]) then
					HKCBGHonorHistory[HKCMap] = {};
				end

				table.insert(HKCBGHonorHistory[HKCMap], { honor = gained, time = elapsed } );
				if (table.getn(HKCBGHonorHistory[HKCMap]) > 10) then
					table.remove(HKCBGHonorHistory[HKCMap], 1);
				end
			end

			HKCInBattleground = false;
		end

--	elseif (event == "UNIT_NAME_UPDATE" and arg1 == "player" and not HKC_PLAYER) then
--		HKCGetPlayerName();

	elseif (event == "VARIABLES_LOADED") then
		HKC_VARSLOADED = true;
		if (HKC_PENDINGUPDATE) then
			HKCGetPlayerName();
		end
	end
end

function HKCTop5(type)
	local name, kills, count, lastkills, rank, victim;
	local top5 = {};
	local targetarr;
	local output = "";

	if (type == "today") then
		targetarr = HKC_KILLSTODAY[HKC_PLAYER];
	elseif (type == "lifetime") then
		targetarr = HKC_KILLSLIFETIME[HKC_PLAYER];
	else
		return
	end

	for name, kills in pairs(targetarr) do
		table.insert(top5, {name = name, kills = kills});
	end

	table.sort(top5, 
		function(a, b)
			return a.kills > b.kills;
		end
	);

	count = 0;
	lastkills = 0;

	-- iterate every person killed
	for rank, victim in top5 do

		count = count + 1;

		-- lastkills is needed in case of a tie
		if (lastkills ~= victim.kills) then
			-- no tie

			if (lastkills > 0) then
				-- output player(s) and kill num
				DEFAULT_CHAT_FRAME:AddMessage(output.." ("..lastkills..")");
				output = "";
			end
			lastkills = victim.kills;

			-- reached 5+ players
			-- this doesn't get seen in the case of a tie
			if (count > 5) then
				break;
			end
		else
			-- tie
			output = output..", "
		end

		output = output..victim.name;
	end

end

function HKCZeroed()
	local name, kills;

	DEFAULT_CHAT_FRAME:AddMessage("These people no longer give you honor for today", 1, 1, 0);

	for name, kills in pairs(HKC_KILLSTODAY[HKC_PLAYER]) do
		if (kills > 10) then
			DEFAULT_CHAT_FRAME:AddMessage(name.." ("..kills..")");
		end
	end
end

function HKCInfo()
	local kills, z, hk, contribution;

	-- people killed today
	z = 0;
	for _ in pairs(HKC_KILLSTODAY[HKC_PLAYER]) do
		z = z + 1;
	end
	DEFAULT_CHAT_FRAME:AddMessage("You killed |c0000ffff"..z.."|r people today.", 1, 1, 0);

	-- people killed lifetime
	z = 0;
	for _ in pairs(HKC_KILLSLIFETIME[HKC_PLAYER]) do
		z = z + 1;
	end
	DEFAULT_CHAT_FRAME:AddMessage("You killed |c0000ffff"..z.."|r people since HKC was installed.", 1, 1, 0);

	z = 0;
	for _ in HKC_STANDINGS[HKC_PLAYER] do
		z = z + 1;
	end
	DEFAULT_CHAT_FRAME:AddMessage("You have inspected the honor of |c0000ffff"..z.."|r players this week.", 1, 1, 0);

	z = 0;
	for _ in HKC_WBLSTANDINGS[HKC_PLAYER] do
		z = z + 1;
	end
	DEFAULT_CHAT_FRAME:AddMessage("You inspected the honor of |c0000ffff"..z.."|r players last week.", 1, 1, 0);

	-- Avg contribution
	-- Yesterday's values
--	hk, _, contribution = GetPVPYesterdayStats();
--	if (hk > 0) then
--		DEFAULT_CHAT_FRAME:AddMessage("Yesterday's avg contribution per kill: "..string.format("%.1f", (contribution / hk)).." ", 1, 1, 0);
--	end
	-- Last Week's values
--	hk, _, contribution = GetPVPLastWeekStats();
--	if (hk > 0) then
--		DEFAULT_CHAT_FRAME:AddMessage("Last week's avg contribution per kill: "..string.format("%.1f", (contribution / hk)).." ", 1, 1, 0);
--	end

	-- number of people who no longer give contribution for today
	z = 0;
	for _, kills in pairs(HKC_KILLSTODAY[HKC_PLAYER]) do
		if (kills > 10) then
			z = z + 1;
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("There are |c0000ffff"..z.."|r players who will no longer give you honor for today.", 1, 1, 0);

	-- BG avgs
	local bg, honorArr, avgHonor, avgTime, bgSession, dataPoints;

	for bg, honorArr in HKCBGHonorHistory do
		avgHonor = 0;
		avgTime = 0;

		dataPoints = table.getn(honorArr);

		for _, bgSession in honorArr do
			avgHonor = avgHonor + bgSession.honor;
			avgTime = avgTime + bgSession.time;
		end

		avgHonor = math.floor(avgHonor / dataPoints);
		avgTime = math.floor(avgTime / dataPoints);

		DEFAULT_CHAT_FRAME:AddMessage("|c00ffffff"..bg.."|r Avg Honor: |c0000ffff"..avgHonor.."|r  Avg Time: |c0000ffff"..avgTime.."|r (last "..dataPoints..")", 1, 1, 0);
	end


	if (HKC_CFG[HKC_PLAYER].ESTCP) then
		DEFAULT_CHAT_FRAME:AddMessage("Today's honor before diminishing returns: |c0000ffff"..HKC_CFG[HKC_PLAYER].ESTCP.blizztoday.."|r", 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("HKC's Estimated honor for today: |c0000ffff"..math.floor(HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday).."|r", 1, 1, 0);

--		DEFAULT_CHAT_FRAME:AddMessage("Known CP for this week, minus today: "..HKC_CFG[HKC_PLAYER].CPthisweek.CP.." ("..HKC_CFG[HKC_PLAYER].CPthisweek.days.." days seen)", 1, 1, 0);
	end

	-- if in a BG, show honor gained so far
	if (HKCInBattleground) then
		local gained = math.floor(HKC_CFG[HKC_PLAYER].ESTCP.HKCtoday - HKCLastEstimated);
		DEFAULT_CHAT_FRAME:AddMessage("Honor gained in your current BG thus far: |c0000ffff"..gained.."|r", 1, 1, 0);
	end

end

function HKCLookup(target)
	local char;

	-- force to lowercase then upper the 1st letter
	target = string.lower(target);
	char = string.sub(target, 1, 1);
	target = string.sub(target, 2);
	target = string.upper(char)..target;
	
	if (not HKC_KILLSLIFETIME[HKC_PLAYER][target]) then
		DEFAULT_CHAT_FRAME:AddMessage("You have never killed "..target..".", 1, 1, 0);
		return
	end

	if (HKC_KILLSTODAY[HKC_PLAYER][target]) then
		DEFAULT_CHAT_FRAME:AddMessage("You killed "..target.." "..HKC_KILLSTODAY[HKC_PLAYER][target].." times today.", 1, 1, 0);
	else
		DEFAULT_CHAT_FRAME:AddMessage("You have not killed "..target.." today.", 1, 1, 0);
	end

	DEFAULT_CHAT_FRAME:AddMessage("You killed "..target.." "..HKC_KILLSLIFETIME[HKC_PLAYER][target].." times since HKC was installed.", 1, 1, 0);
end

function HKCStandings(range)
	local standing, player, smin, smax, wblstanding, wbltext, wblplayer, change;
	local defaultMax = 2000;
	local sortArr = {};
	local str = "";

	for standing in HKC_STANDINGS[HKC_PLAYER] do
		table.insert(sortArr, standing );
	end

	table.sort(sortArr);

	if (sortArr[10]) then
		defaultMax = sortArr[10];
	end

	if (not range) then
		smin = 1;
		smax = defaultMax;
		str = " (top 10 inspected)";
	else
		_, _, smin, smax = string.find(range, "(%d+)%s*%-%s*(%d+)");
		if (not smin) then
			-- single standing?
			_, _, smin = string.find(range, "^(%d+)$");
			if (smin) then
				smax = smin;
			end
		end
		smin = tonumber(smin);
		smax = tonumber(smax);
		if (not smin or not smax or smax < smin) then
			smin = 1;
			smax = defaultMax;
			str = " (top 10 inspected)";
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage("Currently known "..smin.."-"..smax..str.." standings for last week:", 1, 1, 0);

	for standing = smin, smax do
		if (HKC_STANDINGS[HKC_PLAYER][standing]) then
			player = HKC_STANDINGS[HKC_PLAYER][standing];

			wbltext = "";
			-- iterate through week before last standings
			for wblstanding, wblplayer in HKC_WBLSTANDINGS[HKC_PLAYER] do

				-- if player found in week before last standings array
				if (wblplayer.name == player.name) then
					
					-- get exact change in rank for player
					change = (player.ranknum + player.progress) - (wblplayer.ranknum + wblplayer.progress);
					change = string.format("%.2f", (change));

					wbltext = "; Last Week Rank: "..string.format("%i", (wblplayer.progress * 100)).."% into "..wblplayer.ranktitle.." (rank advancement: "..change..")";
				end
			end

--			DEFAULT_CHAT_FRAME:AddMessage(standing..") "..player.name.." ("..player.class..") - HKs: "..player.HKs.." - CP: "..player.contribution.." - Avg. CP/kill: "..string.format("%i", (player.contribution / player.HKs)));
			DEFAULT_CHAT_FRAME:AddMessage("|c0000ffff"..standing.."|r) "..player.ranktitle.." ("..string.format("%i", (player.progress * 100)).."%) |c00ffff00"..player.name.."|r ("..player.class..") - HKs: "..player.HKs.." - Honor: "..player.contribution..wbltext);
		end
	end

end

function HKCRank(range)
	local standing, player, smin, smax, wblstanding, wbltext, wblplayer, change;

	if (not range) then
		_, smin = GetPVPRankInfo(UnitPVPRank("player"));
		smax = smin;
	elseif (tonumber(range) ~= nil and tonumber(range) >= 1 and tonumber(range) <= 14) then
		smin = tonumber(range);
		smax = tonumber(range);
	else
		_, _, smin, smax = string.find(range, "(%d+)%s*%-%s*(%d+)");
		smin = tonumber(smin);
		smax = tonumber(smax);
		if (not smin or not smax or smax < smin) then
			_, smin = GetPVPRankInfo(UnitPVPRank("player"));
			smax = smin;
		end
	end

	if (smin == smax) then
		DEFAULT_CHAT_FRAME:AddMessage("Showing inspected players for rank "..smin..":", 1, 1, 0);
	else
		DEFAULT_CHAT_FRAME:AddMessage("Showing inspected players for ranks "..smin.."-"..smax..":", 1, 1, 0);
	end

	local rankarr = {};
	
	for standing, player in HKC_STANDINGS[HKC_PLAYER] do
		table.insert(rankarr, player);
	end

	table.sort(rankarr, 
		function(a, b)
			if (a.ranknum == b.ranknum) then
				return a.progress > b.progress;
			else
				return a.ranknum > b.ranknum;
			end
		end
	);

	for standing, player in rankarr do
		if (player.ranknum >= smin and player.ranknum <= smax) then

			wbltext = "";
			-- iterate through week before last standings
			for wblstanding, wblplayer in HKC_WBLSTANDINGS[HKC_PLAYER] do

				-- if player found in week before last standings array
				if (wblplayer.name == player.name) then
					
					-- get exact change in rank for player
					change = (player.ranknum + player.progress) - (wblplayer.ranknum + wblplayer.progress);
					change = string.format("%.2f", (change));

					wbltext = "; Last Week Rank: "..string.format("%i", (wblplayer.progress * 100)).."% into "..wblplayer.ranktitle.." (rank advancement: "..change..")";
				end
			end

			DEFAULT_CHAT_FRAME:AddMessage("|c0000ffff"..player.ranktitle.."|r ("..string.format("%i", (player.progress * 100)).."%) |c00ffff00"..player.name.."|r ("..player.class..") - HKs: "..player.HKs.." - Honor: "..player.contribution..wbltext);
		end
	end

end

function HKCGraph(rank)
	local player, wblplayer, change, i;
	local points = 0;

	if (not rank) then
		_, rank = GetPVPRankInfo(UnitPVPRank("player"));
	elseif (tonumber(rank) ~= nil and tonumber(rank) >= 1 and tonumber(rank) <= 14) then
		rank = tonumber(rank);
	else
		_, rank = GetPVPRankInfo(UnitPVPRank("player"));
	end

	local datapoint = {};

	-- iterate last weeks' standings
	i = 0;
	for _, wblplayer in HKC_WBLSTANDINGS[HKC_PLAYER] do

		-- if player was the rank specified
		if (wblplayer.ranknum == rank) then

			-- iterate through current standings
			for _, player in HKC_STANDINGS[HKC_PLAYER] do

				-- if player found in both arrays
				if (wblplayer.name == player.name) then
					
					-- get exact change in rank for player
					change = (player.ranknum + player.progress) - (wblplayer.ranknum + wblplayer.progress);

					table.insert(datapoint, {
						name = player.name,
						honor = player.contribution,
						change = change,
						wblprogress = math.floor(wblplayer.progress * 100),
					});
					points = points + 1;
				end
			end

		end

		i = i + 1;
	end

	if (i < 1) then
		DEFAULT_CHAT_FRAME:AddMessage("This feature requires you to have inspected the honor of the same players this week and last week", 1, 0, 0);
		return
	end

	table.sort(datapoint, 
		function(a, b)
			return a.honor > b.honor;
		end
	);

	local minHonor = 9999999;
	local maxHonor = 0;
	local minChange = 10;
	local maxChange = -1;

	DEFAULT_CHAT_FRAME:AddMessage("Graph data for rank "..rank..":", 1, 1, 0);

	for _, player in datapoint do
		if (player.honor > maxHonor) then
			maxHonor = player.honor;
		end
		if (player.honor < minHonor) then
			minHonor = player.honor;
		end
		if (player.change > maxChange) then
			maxChange = player.change;
		end
		if (player.change < minChange) then
			minChange = player.change;
		end

		change = string.format("%.2f", (player.change));
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffff"..player.honor.."|r honor at "..player.wblprogress.."% into the rank resulted in a rank change of |c0000ffff"..change.."|r");
	end

	for i = 1, 40 do
		getglobal("HKCDataPlot"..i):Hide();
	end

	-- hide what possibly might not be shown
	HKCGraphLinenp5:Hide();
	HKCGraphLineZero:Hide();
	HKCGraphLine1p5:Hide();
	HKCGraphLine1:Hide();
	HKCGraphLine2:Hide();

	HKCGraphFrameYZero:Hide();
	HKCGraphFrameY2:Hide();
	HKCGraphFrameY1p5:Hide();
	HKCGraphFrameYnp5:Hide();

	if (points > 1) then
		local minY, maxY, minX, maxX;
		local x, y, xUnit, yUnit, width;

		HKCGraphFrame:Show();

		-- display 0, .5, 1 labels
		local yLabels = {
			{ val = 0, global = "Zero"},
			{ val = .5, global = "p5"},
			{ val = 1, global = "1"}
		};

		-- determine min and max Y scale
		-- and labels
		if (minChange < 0) then
			minY = -.5;
			table.insert(yLabels, { val = -.5, global = "np5"});
		else
			minY = 0;
		end

		maxY = 1;
		if (maxChange > 1) then
			maxY = 1.5;
			table.insert(yLabels, { val = 1.5, global = "1p5"});
		end
		if (maxChange > 1.5) then
			maxY = 2;
			table.insert(yLabels, { val = 2, global = "2" });
		end

		-- x axis (honor) minimum
		minX = 0;

		-- determine x axis maximum
		maxX = 10 ^ (string.len(tostring(maxHonor)) - 1);
		maxX = math.ceil(maxHonor / maxX) * maxX;

		-- X (honor) scale labels
		HKCGraphFrameXLeft:SetText(minX);
		HKCGraphFrameXMid:SetText(((maxX - minX) / 2) + minX);
		HKCGraphFrameXRight:SetText(maxX);

		xUnit = (maxX - minX) / 500;	-- 1 pixel = this many X.  graph = 500x500
		yUnit = (maxY - minY) / 500;	-- 1 pixel = this many Y

		-- draw honor grid lines
		DrawRouteLine(HKCGraphLineX1, "HKCGraphFrame", 250, 6, 250, 494, 8);
		DrawRouteLine(HKCGraphLineX2, "HKCGraphFrame", 125, 6, 125, 494, 8);
		DrawRouteLine(HKCGraphLineX3, "HKCGraphFrame", 375, 6, 375, 494, 8);
		HKCGraphLineX1:SetVertexColor(0, 1, 1);
		HKCGraphLineX2:SetVertexColor(0, 1, 1);
		HKCGraphLineX3:SetVertexColor(0, 1, 1);

		-- draw rank lines and position labels
		for _, i in yLabels do
			if (maxY >= i.val and minY <= i.val) then
				-- set label
				y = math.floor((i.val + math.abs(minY)) / yUnit);
				getglobal("HKCGraphFrameY"..i.global):SetPoint("LEFT", "HKCGraphFrame", "BOTTOMLEFT", 5, (y + 2));
				getglobal("HKCGraphFrameY"..i.global):SetTextColor(1, 1, 1);
				getglobal("HKCGraphFrameY"..i.global):Show();
			end
			if (maxY > i.val and minY < i.val) then
				-- draw line
				if (i.val == 0) then
					width = 10;
					HKCGraphLineZero:SetVertexColor(1, 0, 0);
				else
					getglobal("HKCGraphLine"..i.global):SetVertexColor(0, 1, 1);
					width = 8;
				end
				DrawRouteLine(getglobal("HKCGraphLine"..i.global), "HKCGraphFrame", 6, y, 494, y, width);
				getglobal("HKCGraphLine"..i.global):Show();
			end
		end

		-- plot data points
		i = 0;
		for _, player in datapoint do
			i = i + 1;

			-- 40 points max
			if (i > 40) then
				break;
			end

			x = math.floor((player.honor - minX) / xUnit);
			y = math.floor((player.change - minY) / yUnit);

			getglobal("HKCDataPlot"..i):SetPoint("CENTER", "HKCGraphFrame", "BOTTOMLEFT", x, y);
			getglobal("HKCDataPlot"..i):Show();
		end

		HKCGraphFrameTitle:SetText("Rank "..rank.." Progression");

	else
		HKCGraphFrame:Hide();
		DEFAULT_CHAT_FRAME:AddMessage("Insufficient data to display graph", 1, 0, 0);
	end

end

function HKCShare(name)
	local HKCname = name.." "..GetCVar("realmName");

	-- does name exist on this server
	if (HKC_STANDINGS[HKCname]) then

		-- check for an identical standing to ensure this is the same week
		local standing, hisStanding;
		local myData = {};
		local hisData = {};
		local match = false;

		for standing, myData in HKC_STANDINGS[HKC_PLAYER] do
			if (HKC_STANDINGS[HKCname][standing]) then
				if (	HKC_STANDINGS[HKCname][standing].name == myData.name and
					HKC_STANDINGS[HKCname][standing].HKs == myData.HKs and
					HKC_STANDINGS[HKCname][standing].contribution == myData.contribution and
					HKC_STANDINGS[HKCname][standing].ranknum == myData.ranknum
				) then
					match = true;
				else
					match = false;
				end

				break;
			end
		end

		-- share data with name
		if (match) then
			local i = 0;

			for standing, myData in HKC_STANDINGS[HKC_PLAYER] do
				if (not HKC_STANDINGS[HKCname][standing]) then
					HKC_STANDINGS[HKCname][standing] = myData;

					DEFAULT_CHAT_FRAME:AddMessage(myData.name.." copied", 1, 1, 0);

					i = i + 1;
				end
			end

			DEFAULT_CHAT_FRAME:AddMessage(i.." records copied to "..name, 1, 1, 0);

		else
			DEFAULT_CHAT_FRAME:AddMessage("No standing match found.  Both characters must have at least one player match to ensure accurate data", 1, 0, 0);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(name.." does not exist", 1, 0, 0);
	end
end

function HKCCmdLine(param)
	local arg1;
	local arg2;
	_, _, arg1, arg2 = string.find(param, "(%a+)%s+(.+)");
	if (not arg1) then
		arg1 = param;
	end

	if (arg1 == "verbose") then
		if (HKC_CFG.VERBOSE) then
			DEFAULT_CHAT_FRAME:AddMessage("Honor Kills Counter verbose mode off.", 1, 1, 0);
			HKC_CFG.VERBOSE = false;
		else
			DEFAULT_CHAT_FRAME:AddMessage("Honor Kills Counter verbose mode on.", 1, 1, 0);
			HKC_CFG.VERBOSE = true;
		end

	elseif (arg1 == "top5") then
		DEFAULT_CHAT_FRAME:AddMessage("Today's Most Killed Top 5", 1, 1, 0);
		HKCTop5("today");
		DEFAULT_CHAT_FRAME:AddMessage("Total Most Killed Top 5", 1, 1, 0);
		HKCTop5("lifetime");

	elseif (arg1 == "info") then
		HKCInfo();

	elseif (arg1 == "lookup") then
		if (not arg2 and UnitExists("target")) then
			arg2 = UnitName("target");
		end
		if (arg2) then
			HKCLookup(arg2);
		end

	elseif (arg1 == "zeroed") then
		HKCZeroed();

	elseif (arg1 == "standings") then
		HKCStandings(arg2);

	elseif (arg1 == "rank") then
		HKCRank(arg2);

	elseif (arg1 == "graph") then
		HKCGraph(arg2);

	elseif (arg1 == "share" and arg2) then
		HKCShare(arg2);

	elseif (arg1 == "history") then
		local v;

		for _, v in HKCHonorBonusHistory do
			DEFAULT_CHAT_FRAME:AddMessage(v);
		end

	elseif (arg1 == "forcereset") then
		if (arg2 == "today") then
			HKCResetToday(true);
		elseif (arg2 == "thisweek") then
			HKCResetThisWeek(true);
		else
			DEFAULT_CHAT_FRAME:AddMessage("command syntax: /hkc forcereset today", 1, 1, 0);
			DEFAULT_CHAT_FRAME:AddMessage("/hkc forcereset thisweek", 1, 1, 0);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Honor Kills Counter v"..HKC_VERSION.." Commands:", 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffverbose|r -- Toggle chat messages and target kill notifications on/off");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000fffftop5|r -- Show the top 5 most killed");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffstandings [#-#]|r -- Show the currently known standings for last week.  Inspect people to add to the database");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffrank [#-#]|r -- Show the currently known players of the specified rank(s).  Inspect people to add to the database");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffgraph [#]|r -- Display a graph of rank advancement from honor earned for the specified rank.  Inspect people to add data");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffshare <name>|r -- Share inspect data with one of your other characters");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffinfo|r -- Show various statistics");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffhistory|r -- Show a recent timestamped history of bonus honor gain");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffzeroed|r -- List everyone who no longer give honor for the day");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000fffflookup <target>|r -- Show the number of kills for <target>.  If target is not specified, your current target will be used");
		DEFAULT_CHAT_FRAME:AddMessage("|c0000ffffforcereset [today|thisweek]|r -- Force HKC to reset the daily counter, or this week's standings.  Only use this if HKC did not automatically");
	end
end
