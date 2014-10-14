
BFC_BG_Common = {}; -- Initialize the BFC_BG_Common namespace

BFC_BG_SCOREBOARD_SCAN_TIME = 10

function BFC_BG_Common.OnLoad()
	-- Create the helper module and register it with the BFC system.
	local modobj = {
		Name = "BG_Common Helper", -- A unique name, doesn't need to be the zone name
		Author = "Vallerius", -- Give yourself credit. Not used yet, might appear later in a management screen
		Version = "1.0", -- Also unused for now
		Type = "ZONE_HELPER", -- Must be ZONE_HELPER for per-zone helper objects
		SetActive = BFC_BG_Common.SetActive, -- Function to enable/disable the zone
		IsActiveZone = BFC_BG_Common.IsActiveZone, -- Function to determine if we're in a target zone
	};
	BFC_Common.RegisterHelperModule(modobj);
end

-- Called by the module dispatcher whenever we enter/leave an active zone
function BFC_BG_Common.SetActive(state)
	if(state == true) then
		BFC_Common.RegisterEvent("UPDATE_BATTLEFIELD_SCORE", BFC_BG_Common.ScanScoreboard);
		
		BFC_BG_Common.AllianceClassCount = {
			WARLOCK = 0,
			WARRIOR = 0,
			HUNTER = 0,
			MAGE = 0,
			PRIEST = 0,
			DRUID = 0,
			PALADIN = 0,
			ROGUE = 0,
		};
		
		BFC_BG_Common.HordeClassCount = {
			WARLOCK = 0,
			WARRIOR = 0,
			HUNTER = 0,
			MAGE = 0,
			PRIEST = 0,
			DRUID = 0,
			SHAMAN = 0,
			ROGUE = 0,
		};
		
		BFC_BG_Common.AlliancePlayers = {};
		BFC_BG_Common.HordePlayers = {};
		
		BFC_BG_Common.HordeServerCount = {};
		BFC_BG_Common.HordeServerCount = {};
		
		--BFC_Radio.SetLocalMenuItems(BFC_Strings.CommsMenu_BG_Common);
		
		BFC_BG_Common_Alliance_Count:SetTextColor(BFC_Common.COLOR_ALLIANCE.r, BFC_Common.COLOR_ALLIANCE.g, BFC_Common.COLOR_ALLIANCE.b);
		BFC_BG_Common_Horde_Count:SetTextColor(BFC_Common.COLOR_HORDE.r, BFC_Common.COLOR_HORDE.g, BFC_Common.COLOR_HORDE.b);
		BFC_BG_Common_Count_Text:SetText(BFC_Strings.BG_Base.players);
		
		BFC_BG_Common_Pug_Text:SetText(BFC_Strings.BG_Base.team);
		
		--BFC.Log(BFC.LOG_DEBUG, "firing up info tester");
		local info = BFC_InfoFrame:getInstance();
		info:addFrame(BFC_BG_Common_Frame, "General", "gen_clock");
		info:addFrame(BFC_BG_Common_Count_Frame, "General", "gen_count");
		info:addFrame(BFC_BG_Common_Pug_Frame, "General", "gen_pug");
		
		BFC_BG_Common_Clock:SetText(string.format(BFC_Strings.BG_Base.elapsed, 0));
		
		--BFC_Common.RegisterUpdateFunction("BFC_BG_Common", BFC_BG_Common.OnUpdate);
		
		BFC_BG_Common.scoreboardTimer = BFC_Timer:new();
		BFC_BG_Common.scoreboardTimer:SetCallback(BFC_BG_Common.ScoreboardTimerCallback);
		BFC_BG_Common.scoreboardTimer:SetTime(BFC_BG_SCOREBOARD_SCAN_TIME);
		BFC_BG_Common.scoreboardTimer:Start();
		--BFC.Log(BFC.LOG_DEBUG, "info tester loaded");
	else
		BFC_Common.UnregisterEvent("UPDATE_BATTLEFIELD_SCORE", BFC_BG_Common.ScanScoreboard);
		
		--BFC_Common.UnregisterUpdateFunction("BFC_BG_Common");
		
		local info = BFC_InfoFrame:getInstance();
		info:removeObject("General", "gen_clock");
		info:removeObject("General", "gen_count");
		info:removeObject("General", "gen_pug");
		
		--BFC_Radio.SetLocalMenuItems(nil);
	end
end

-- Called by the module dispatcher to determine if we're in an active zone
function BFC_BG_Common.IsActiveZone(zone)
	--return true;
	if(zone == BFC_Strings.AB.zone or zone == BFC_Strings.WSG.zone) then -- FIXME: add to strings
		return true;
	else
		return false;
	end
end


function BFC_BG_Common.ScoreboardTimerCallback()
	RequestBattlefieldScoreData();
	BFC_BG_Common.scoreboardTimer:SetTime(BFC_BG_SCOREBOARD_SCAN_TIME);
	BFC_BG_Common.scoreboardTimer:Start();
	
	BFC_BG_Common_Clock:SetText(string.format(BFC_Strings.BG_Base.elapsed, math.floor(GetBattlefieldInstanceRunTime() / 60000)));
end

function BFC_BG_Common.ScanScoreboard()
	local num = GetNumBattlefieldScores();
	local aplayers = 0;
	local hplayers = 0;
	
	BFC_BG_Common.AllianceClassCount = {
		WARLOCK = 0,
		WARRIOR = 0,
		HUNTER = 0,
		MAGE = 0,
		PRIEST = 0,
		DRUID = 0,
		PALADIN = 0,
		ROGUE = 0,
	};
	
	BFC_BG_Common.HordeClassCount = {
		WARLOCK = 0,
		WARRIOR = 0,
		HUNTER = 0,
		MAGE = 0,
		PRIEST = 0,
		DRUID = 0,
		SHAMAN = 0,
		ROGUE = 0,
	};
	
	BFC_BG_Common.AllianceServerCount = { };
	BFC_BG_Common.HordeServerCount = { };
	
	for i=1,num do
		local name, killingBlows, honorKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(i);
		
		-- Strip the attached server name, if applicable
		--local loc = strfind(name, "-");
		--if(loc ~= nil) then
		--	loc = loc - 1;
		--end
		--name = strsub(name, 0, loc);
		local bits = BFC_Util.SplitString("-", name);
		name = bits[1];
		if(not bits[2]) then
			server = GetRealmName();
		else
			server = bits[2];
		end
		
		local classname = BFC_Util.GetRealClassName(class);
		

		if(faction == 1) then
			if not BFC_BG_Common.AlliancePlayers[name] then
				BFC_BG_Common.AlliancePlayers[name] = {};
			end
			BFC_BG_Common.AlliancePlayers[name].class = classname;
			BFC_BG_Common.AlliancePlayers[name].rank = rank;
			BFC_BG_Common.AlliancePlayers[name].server = server;
			BFC_BG_Common.AllianceClassCount[classname] = BFC_BG_Common.AllianceClassCount[classname] + 1;
			if(BFC_BG_Common.AllianceServerCount[server]) then
				BFC_BG_Common.AllianceServerCount[server] = BFC_BG_Common.AllianceServerCount[server] + 1;
			else
				BFC_BG_Common.AllianceServerCount[server] = 1;
			end
			aplayers = aplayers + 1;
		else
			if not BFC_BG_Common.HordePlayers[name] then
				BFC_BG_Common.HordePlayers[name] = {};
			end
			BFC_BG_Common.HordePlayers[name].class = classname;
			BFC_BG_Common.HordePlayers[name].rank = rank;
			BFC_BG_Common.HordePlayers[name].server = server;
			BFC_BG_Common.HordeClassCount[classname] = BFC_BG_Common.HordeClassCount[classname] + 1;
			if(BFC_BG_Common.HordeServerCount[server]) then
				BFC_BG_Common.HordeServerCount[server] = BFC_BG_Common.HordeServerCount[server] + 1;
			else
				BFC_BG_Common.HordeServerCount[server] = 1;
			end
			hplayers = hplayers + 1;
		end
	end
	
	
	-- Set the A/H player counts
	BFC_BG_Common_Alliance_Count:SetText(aplayers);
	BFC_BG_Common_Horde_Count:SetText(hplayers);
	
	
	-- Determine pug-osity
	local maxservercount = 0;
	for c, v in pairs(BFC_BG_Common.AllianceServerCount) do
		if(v > maxservercount) then
			maxservercount = v;
		end
	end
	
	local pugosity;
	if(aplayers == 0) then
		pugosity = "--";
		BFC_BG_Common_Alliance_Pug:SetText(BFC_Util.GetGoodnessColorString(0) .. pugosity .. "%");
	else
		pugosity = ceil(((maxservercount / aplayers)) * 100);
		BFC_BG_Common_Alliance_Pug:SetText(BFC_Util.GetGoodnessColorString(pugosity / 10) .. pugosity .. "%");
	end
	
	maxservercount = 0;
	for c, v in pairs(BFC_BG_Common.HordeServerCount) do
		if(v > maxservercount) then
			maxservercount = v;
		end
	end
	
	if(hplayers == 0) then
		pugosity = "--";
		BFC_BG_Common_Horde_Pug:SetText(BFC_Util.GetGoodnessColorString(0) .. pugosity .. "%");
	else
		pugosity = ceil(((maxservercount / hplayers)) * 100);
		BFC_BG_Common_Horde_Pug:SetText(BFC_Util.GetGoodnessColorString(pugosity / 10) .. pugosity .. "%");
	end
	
	
	-- Update any mouseovers if applicable
	if(GameTooltip:IsVisible()) then
		if(GameTooltip:IsOwned(BFC_BG_Common_Alliance_Count_Frame)) then
			BFC_BG_Common.CountMouseOver("alliance", BFC_BG_Common_Alliance_Count_Frame);
		elseif(GameTooltip:IsOwned(BFC_BG_Common_Horde_Count_Frame)) then
			BFC_BG_Common.CountMouseOver("horde", BFC_BG_Common_Horde_Count_Frame);
		elseif(GameTooltip:IsOwned(BFC_BG_Common_Alliance_Pug_Frame)) then
			BFC_BG_Common.PugMouseOver("alliance", BFC_BG_Common_Alliance_Pug_Frame);
		elseif(GameTooltip:IsOwned(BFC_BG_Common_Horde_Pug_Frame)) then
			BFC_BG_Common.PugMouseOver("horde", BFC_BG_Common_Horde_Pug_Frame);
		end
	end
end


function BFC_BG_Common.CountMouseOver(faction, frame)
	--local x, y
	--if(faction == "alliance") then
	--	x, y = BFC_BG_Common_Alliance_Count_Frame:GetCenter();
	--else
	--	x, y = BFC_BG_Common_Horde_Count_Frame:GetCenter();
	--end
	if(frame) then
		GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	end
	--else
	--	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	--end

	if(faction == "alliance") then
		tooltipText = BFC_Strings.Factions.alliance .. "\n";
		for c, v in pairs(BFC_BG_Common.AllianceClassCount) do
			if(v > 0) then
				tooltipText = tooltipText .. BFC_Util.GetClassColorString(c) .. BFC_Strings.Classes[c] .. ": " .. v .. "\n";
			end
		end
	else	
		tooltipText = BFC_Strings.Factions.horde .. "\n";
		for c, v in pairs(BFC_BG_Common.HordeClassCount) do
			if(v > 0) then
				tooltipText = tooltipText .. BFC_Util.GetClassColorString(c) .. BFC_Strings.Classes[c] .. ": " .. v .. "\n";
			end
		end
	end
	
	GameTooltip:SetText(tooltipText);
	GameTooltip:Show();
end


function BFC_BG_Common.PugMouseOver(faction, frame)
	
	if(frame) then
		GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	end

	if(faction == "alliance") then
		tooltipText = BFC_Strings.BG_Base.apugheader .. "\n";
		for c, v in pairs(BFC_BG_Common.AllianceServerCount) do
			if(v > 0) then
				tooltipText = tooltipText .. c .. ": " .. v .. "\n";
			end
		end
	else	
		tooltipText = BFC_Strings.BG_Base.hpugheader .. "\n";
		for c, v in pairs(BFC_BG_Common.HordeServerCount) do
			if(v > 0) then
				tooltipText = tooltipText .. c .. ": " .. v .. "\n";
			end
		end
	end
	
	GameTooltip:SetText(tooltipText);
	GameTooltip:Show();
end