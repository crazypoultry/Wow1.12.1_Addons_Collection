
BFC_WSG = {}; -- Initialize the BFC_WSG namespace

local BFC_WSG_REZ_INTERVAL = 32; -- rez wave every ~30s
local BFC_WSG_CLASS_SCAN_DELAY = 30; -- scan the scoreboard for class/level info every 30s

function BFC_WSG.Onload()
	-- Create the helper module and register it with the BFC system.
	local modobj = {
		Name = BFC_Strings.WSG.modname, -- A unique name, doesn't need to be the zone name
		Author = "Vallerius", -- Give yourself credit. Not used yet, might appear later in a management screen
		Version = "1.0", -- Also unused for now
		Type = "ZONE_HELPER", -- Must be ZONE_HELPER for per-zone helper objects
		SetActive = BFC_WSG.SetActive, -- Function to enable/disable the helper
		IsActiveZone = BFC_WSG.IsActiveZone, -- Function to determine if we're in a target zone
	};
	BFC_Common.RegisterHelperModule(modobj);
end

-- Called by the module dispatcher whenever we enter/leave an active zone
function BFC_WSG.SetActive(state)
	if(state == true) then
		BFC_Common.RegisterEvent("AREA_SPIRIT_HEALER_IN_RANGE", BFC_WSG.OnEvent);
		BFC_Common.RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", BFC_WSG.OnEvent); 
		BFC_Common.RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE", BFC_WSG.OnEvent); 
		BFC_Common.RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", BFC_WSG.OnEvent);
		BFC_Common.RegisterEvent("UPDATE_BATTLEFIELD_SCORE", BFC_WSG.HandleScoreEvent);
		BFC_Common.RegisterEvent("UNIT_HEALTH",  BFC_WSG.HandleRaidHealthEvent);
		
		
		local infoFrame = BFC_InfoFrame:getInstance();
		infoFrame:addFrame(BFC_WSG_Score_Frame, BFC_Strings.WSG.zone, "wsg_score");
		infoFrame:addFrame(BFC_WSG_Flags_Frame, BFC_Strings.WSG.zone, "wsg_flags");
		infoFrame:addFrame(BFC_WSG_Rez_Frame, BFC_Strings.WSG.zone, "wsg_rez");
		
		-- Reset the mod state so that it's fresh every time
		local color = NORMAL_FONT_COLOR;
		BFC_WSG_HordeCarrier:SetText(BFC_Strings.WSG.atbase);
		BFC_WSG_HordeCarrier:SetTextColor(color.r, color.g, color.b);
		
		BFC_WSG_AllianceCarrier:SetText(BFC_Strings.WSG.atbase);
		BFC_WSG_AllianceCarrier:SetTextColor(color.r, color.g, color.b);
		
		BFC_WSG_Score_Text:SetText(BFC_Strings.WSG.score);
		BFC_WSG_Alliance_Score:SetTextColor(BFC_Common.COLOR_ALLIANCE.r, BFC_Common.COLOR_ALLIANCE.g, BFC_Common.COLOR_ALLIANCE.b);
		BFC_WSG_Horde_Score:SetTextColor(BFC_Common.COLOR_HORDE.r, BFC_Common.COLOR_HORDE.g, BFC_Common.COLOR_HORDE.b);
		
		BFC_WSG_RezTime:SetText(string.format(BFC_Strings.WSG.rezwavedefault));
		BFC_WSG.RezTimer = BFC_WSG_REZ_INTERVAL
		BFC_WSG.RezTimerActive = false;
		BFC_WSG.classScanTimer = 0;
		BFC_WSG.AlliancePlayers = {};
		BFC_WSG.HordePlayers = {};
		
		BFC_WSG.allianceTimer = BFC_Timer:new();
		BFC_WSG.allianceTimer:SetFontString(BFC_WSG_AllianceHealth);
		
		BFC_WSG.hordeTimer = BFC_Timer:new();
		BFC_WSG.hordeTimer:SetFontString(BFC_WSG_HordeHealth);
		
		-- The update function will be called every frame, even if the WSG helper frame isn't visible.
		BFC_Common.RegisterUpdateFunction("BFC_WSG", BFC_WSG.OnUpdate);
		
		-- Zone-specific comms menu
		if(BFC_Strings.CommsMenu_WSG == nil) then
			BFC.Log(BFC.LOG_DEBUG, "nil commsmenu");
		end
		BFC_Radio.SetLocalMenuItems(BFC_Strings.CommsMenu_WSG, BFC_Strings.WSG.zone);
		
		-- Receive rez time notifications
		BFC_Comms.RegisterMessage("WSG", "REZ", BFC_WSG.HandleRezMessage);
		BFC_Comms.RegisterMessage("WSG", "ECHEALTH", BFC_WSG.HandleEnemyHealthMessage);
		
		BFC_WSG.allianceCarrying = nil;
		BFC_WSG.hordeCarrying = nil;
		BFC_WSG.allianceCarrier = nil;
		BFC_WSG.hordeCarrier = nil;
		
		-- Request initial score data
		RequestBattlefieldScoreData()
	else
		BFC_Common.UnregisterEvent("AREA_SPIRIT_HEALER_IN_RANGE", BFC_WSG.OnEvent);
		BFC_Common.UnregisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", BFC_WSG.OnEvent); 
		BFC_Common.UnregisterEvent("CHAT_MSG_BG_SYSTEM_HORDE", BFC_WSG.OnEvent); 
		BFC_Common.UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", BFC_WSG.OnEvent);
		BFC_Common.UnregisterEvent("UPDATE_BATTLEFIELD_SCORE", BFC_WSG.HandleScoreEvent);
		BFC_Common.UnregisterEvent("UNIT_HEALTH",  BFC_WSG.HandleRaidHealthEvent);
		
		BFC_Comms.UnregisterMessage("WSG", "REZ");
		BFC_Comms.UnregisterMessage("WSG", "ECHEALTH");
		BFC_Radio.SetLocalMenuItems(nil);
		
		-- No need for the update when we're not active.
		BFC_Common.UnregisterUpdateFunction("BFC_WSG");
		
		local infoFrame = BFC_InfoFrame:getInstance();
		infoFrame:removeObject(BFC_Strings.WSG.zone, "wsg_flags");
		infoFrame:removeObject(BFC_Strings.WSG.zone, "wsg_score");
		infoFrame:removeObject(BFC_Strings.WSG.zone, "wsg_rez");
	end
end

-- Called by the module dispatcher to determine if we're in an active zone
function BFC_WSG.IsActiveZone(zone)
	if(zone == BFC_Strings.WSG.zone) then
		return true;
	else
		return false;
	end
end

-- Called by the common OnUpdate handler (registered/unregistered in SetActive)
function BFC_WSG.OnUpdate(elapsed)
	if(BFC_WSG.RezTimerActive) then
		BFC_WSG.LastTime = BFC_WSG.CurTime;
		BFC_WSG.CurTime = GetTime();
		
		
		BFC_WSG.RezTimer = BFC_WSG.RezTimer - (BFC_WSG.CurTime - BFC_WSG.LastTime);
		if(BFC_WSG.RezTimer < 0) then
			BFC_WSG.RezTimer = BFC_WSG.RezTimer + BFC_WSG_REZ_INTERVAL;
		end
		
		BFC_WSG_RezTime:SetText(string.format(BFC_Strings.WSG.rezwave, math.ceil(BFC_WSG.RezTimer)));
	end
	
	-- Request new scoreboard info periodically for class/level details
	if ( BFC_WSG.classScanTimer < 0 ) then
		BFC_WSG.classScanTimer = BFC_WSG_CLASS_SCAN_DELAY;
		RequestBattlefieldScoreData();
	else
		BFC_WSG.classScanTimer = BFC_WSG.classScanTimer - elapsed;
	end
end


function BFC_WSG.HandleRezMessage(player, timeleft)
	BFC.Log(BFC.LOG_DEBUG, "Syncing rez timer to " .. timeleft[1]);
	BFC_WSG.SyncTimer(timeleft[1]);
end


-- Set the rez timer to a new value
function BFC_WSG.SyncTimer(secondsLeft)
	BFC_WSG.CurTime = GetTime();
	BFC_WSG.RezTimer = secondsLeft;
	BFC_WSG.RezTimerActive = true;
end


-- Your standard event handler
function BFC_WSG.OnEvent(event, ...)
	if(event == "AREA_SPIRIT_HEALER_IN_RANGE" and UnitIsGhost("player")) then
		local timeToRez = GetAreaSpiritHealerTime();
		BFC_WSG.SyncTimer(timeToRez);
		BFC_Comms.SendMessage("WSG", "REZ", timeToRez);
	elseif(event == "UPDATE_BATTLEFIELD_SCORE") then
		BFC_WSG.UpdateClassInfo();
	elseif(event == "CHAT_MSG_BG_SYSTEM_ALLIANCE") then
		BFC_WSG.ParseFlagEvent(BFC_Strings.Factions.alliance, arg[1]);
	elseif(event == "CHAT_MSG_BG_SYSTEM_HORDE") then
		BFC_WSG.ParseFlagEvent(BFC_Strings.Factions.horde, arg[1]);
	elseif(event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		BFC_WSG.ParseFlagEvent("neutral", arg[1]);
	end
end


-- Handle score change
function BFC_WSG.HandleScoreEvent()
	local _, ascore = GetWorldStateUIInfo(1);
	local _, hscore = GetWorldStateUIInfo(2);
	if(ascore and hscore) then
		BFC_WSG_Alliance_Score:SetText(ascore);
		BFC_WSG_Horde_Score:SetText(hscore);
	end
end


-- Figure out what happened to the flag
function BFC_WSG.ParseFlagEvent(faction, text)
	local player = "";
	local color = NORMAL_FONT_COLOR;

	local i, _, player = string.find(text, BFC_Strings.WSG.event_picked);
	if(i) then
		-- Set the class color for the picking player
		if(faction == BFC_Strings.Factions["alliance"]) then
			-- factions are backwards for pickups
			faction = BFC_Strings.Factions["horde"];
			BFC_WSG.allianceCarrying = true;
			BFC_WSG.allianceCarrier = player;
			if(BFC_BG_Common.AlliancePlayers[player]) then
				color = RAID_CLASS_COLORS[BFC_BG_Common.AlliancePlayers[player].class];
			end
		elseif(faction == BFC_Strings.Factions["horde"]) then
			faction = BFC_Strings.Factions["alliance"];
			BFC_WSG.hordeCarrying = true;
			BFC_WSG.hordeCarrier = player;
			if(BFC_BG_Common.HordePlayers[player]) then
				color = RAID_CLASS_COLORS[BFC_BG_Common.HordePlayers[player].class];
			end
		end
	end
	
	local i, _ = string.find(text, BFC_Strings.WSG.event_dropped);
	if(i) then
		player = BFC_Strings.WSG["dropped"]
		BFC_WSG.allianceCarrying = false;
		BFC_WSG.hordeCarrying = false;
	end
	
	local i, _ = string.find(text, BFC_Strings.WSG.event_returned);
	if(i) then
		player = BFC_Strings.WSG["atbase"]
	end
	
	local i, _ = string.find(text, BFC_Strings.WSG.event_placed);
	if(i) then
		player = BFC_Strings.WSG["atbase"]
		BFC_WSG.allianceTimer:Stop();
		BFC_WSG.allianceTimer:SetTime(-1);
		BFC_WSG.hordeTimer:Stop();
		BFC_WSG.hordeTimer:SetTime(-1);
	end
	
	local i, _ = string.find(text, BFC_Strings.WSG.event_captured);
	if(i) then
		player = BFC_Strings.WSG["captured"]
		faction = "neutral";
		BFC_WSG.allianceCarrying = false;
		BFC_WSG.hordeCarrying = false;
		BFC_WSG.allianceTimer:SetTime(20);
		BFC_WSG.allianceTimer:Start();
		BFC_WSG.hordeTimer:SetTime(20);
		BFC_WSG.hordeTimer:Start();
	end
	
	if(player == "") then return end
	
	if(faction == BFC_Strings.Factions["alliance"]) then
		BFC_WSG_AllianceCarrier:SetText(player);
		BFC_WSG_AllianceCarrier:SetTextColor(color.r, color.g, color.b);
	elseif (faction == BFC_Strings.Factions["horde"]) then
		BFC_WSG_HordeCarrier:SetText(player);
		BFC_WSG_HordeCarrier:SetTextColor(color.r, color.g, color.b);
	elseif (faction == "neutral") then
		BFC_WSG_HordeCarrier:SetText(player);
		BFC_WSG_HordeCarrier:SetTextColor(color.r, color.g, color.b);
		BFC_WSG_AllianceCarrier:SetText(player);
		BFC_WSG_AllianceCarrier:SetTextColor(color.r, color.g, color.b);
	end
end


function BFC_WSG.HandleRaidHealthEvent(foo, unit)
	local faction = UnitFactionGroup("player");
	if(UnitFactionGroup(unit) == faction) then
		if(faction == "Alliance" and UnitName(unit) == BFC_WSG.allianceCarrier) then
			if(BFC_WSG.allianceCarrying == true) then
				BFC_WSG_HordeHealth:SetText(ceil((UnitHealth(unit) / UnitHealthMax(unit)) * 100) .. "%");
			end
		elseif(faction == "Horde" and UnitName(unit) == BFC_WSG.hordeCarrier) then
			if(BFC_WSG.hordeCarrying == true) then
				BFC_WSG_AllianceHealth:SetText(ceil((UnitHealth(unit) / UnitHealthMax(unit)) * 100) .. "%");
			end
		end
	else
		if(faction == "Alliance" and UnitName(unit) == BFC_WSG.hordeCarrier) then
			BFC_Comms.SendMessage("WSG", "ECHEALTH", ceil((UnitHealth(unit) / UnitHealthMax(unit)) * 100));
		elseif(faction == "Horde" and UnitName(unit) == BFC_WSG.allianceCarrier) then
			BFC_Comms.SendMessage("WSG", "ECHEALTH", ceil((UnitHealth(unit) / UnitHealthMax(unit)) * 100));
		end
	end
end


function BFC_WSG.HandleEnemyHealthMessage(player, health)
	if(UnitFactionGroup("player") == "Alliance") then
		if(BFC_WSG.hordeCarrying == true) then
			BFC_WSG_AllianceHealth:SetText(health[1] .. "%");
		end
	else
		if(BFC_WSG.allianceCarrying == true) then
			BFC_WSG_HordeHealth:SetText(health[1] .. "%");
		end
	end
end


function BFC_WSG.TargetCarrier(carrier)
	if(carrier and carrier ~= "" and carrier ~= BFC_Strings.WSG["atbase"] and carrier ~= BFC_Strings.WSG["dropped"]) then
		TargetByName(carrier);
	end
end