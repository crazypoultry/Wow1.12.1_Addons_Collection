
BFC_AV = {}; -- Initialize the BFC_AV namespace

local BFC_AV_REZ_INTERVAL = 32; -- rez wave every ~30s
local BFC_AV_NODE_CAP_TIME = 60;



local gyclosestdist = 999;
local playerfaction;
local nodetrans;
BFC_AV.timers = {};

local BFC_AV_GRAVEYARDS = {
	{	x = 0.395845,
		y = 0.261748,
		id = "stAVles",
		name = BFC_Strings.AV.stAVles,
	},
	{	x = 0.613111,
		y = 0.253503,
		id = "mine",
		name = BFC_Strings.AV.mine
	},
	{	x = 0.367385,
		y = 0.628251,
		id = "mill",
		name = BFC_Strings.AV.mill
	},
	{	x = 0.514248,
		y = 0.419996,
		id = "blacksmith",
		name = BFC_Strings.AV.blacksmith
	},
	{	x = 0.611782,
		y = 0.575198,
		id = "farm",
		name = BFC_Strings.AV.farm
	},
	{	x = 0.334840,
		y = 0.131217,
		id = "base",
		name = BFC_Strings.AV.trollbane
	},
	{	x = 0.694644,
		y = 0.678682,
		id = "base",
		name = BFC_Strings.AV.defilers
	},
};

local BFC_AV_FACTIONCOLORS = {
	Horde = "|cffff2020",
	Alliance = "|cff6060ff",
	Neutral = "|cff999999",
};

local graveyardfactions = {};

function BFC_AV.Onload()
	-- Create the helper module and register it with the BFC system.
	local modobj = {
		Name = BFC_Strings.AV.modname, -- A unique name, doesn't need to be the zone name
		Author = "Vallerius", -- Give yourself credit. Not used yet, might appear later in a management screen
		Version = "1.0", -- Also unused for now
		Type = "ZONE_HELPER", -- Must be ZONE_HELPER for per-zone helper objects
		SetActive = BFC_AV.SetActive, -- Function to enAVle/disAVle the helper
		IsActiveZone = BFC_AV.IsActiveZone, -- Function to determine if we're in a target zone
		OptionsFrame = "BFC_AV_OptionsFrame", -- Frame to display helper options in
	};
	BFC_Common.RegisterHelperModule(modobj);
	nodetrans = BFC_Util.FlipKeysAndValues(BFC_Strings.AV_Nodes);
	playerfaction = UnitFactionGroup("player");
end

-- Called by the module dispatcher whenever we enter/leave an active zone
function BFC_AV.SetActive(state)
	if(state == true) then
		BFC_AV_Frame:RegisterEvent("AREA_SPIRIT_HEALER_IN_RANGE");
		BFC_AV_Frame:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE"); 
		BFC_AV_Frame:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE"); 
		BFC_AV_Frame:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
		
		-- Reset the mod state so that it's fresh every time
		
		BFC_AV.RezTimer = BFC_AV_REZ_INTERVAL
		BFC_AV.RezTimerActive = false;
		
		graveyardfactions[BFC_Strings.AV.blacksmith] = "Neutral";
		graveyardfactions[BFC_Strings.AV.farm] = "Neutral";
		graveyardfactions[BFC_Strings.AV.mine] = "Neutral";
		graveyardfactions[BFC_Strings.AV.mill] = "Neutral";
		graveyardfactions[BFC_Strings.AV.blacksmith] = "Neutral";
		graveyardfactions[BFC_Strings.AV.trollbane] = "Alliance";
		graveyardfactions[BFC_Strings.AV.defilers] = "Horde";
		
		-- The update function will be called every frame, even if the AV helper frame isn't visible.
		BFC_Common.RegisterUpdateFunction("BFC_AV", BFC_AV.OnUpdate);
		
		-- Set up the timers
		BFC_AV.timers = {};
		BFC_AV.timers.blacksmith = BFC_Timer:new();
		BFC_AV.timers.blacksmith:SetFontString(BFC_AV_Blacksmith);
		BFC_AV.timers.blacksmith:SetText(BFC_Strings.AV.blacksmith);
		BFC_AV.timers.blacksmith:SetTimerColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.blacksmith:SetLabelColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.blacksmith:SetCallback(BFC_AV.NodeTimerCallback);
		--BFC_AV.tSmith:SetTime(BFC_AV_NODE_CAP_TIME);
		--BFC_AV.tSmith:Start();
		
		BFC_AV.timers.farm = BFC_Timer:new();
		BFC_AV.timers.farm:SetFontString(BFC_AV_Farm);
		BFC_AV.timers.farm:SetText(BFC_Strings.AV.farm);
		BFC_AV.timers.farm:SetTimerColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.farm:SetLabelColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.farm:SetCallback(BFC_AV.NodeTimerCallback);
		--BFC_AV.tFarm:SetTime(BFC_AV_NODE_CAP_TIME);
		--BFC_AV.tFarm:Start();
		
		BFC_AV.timers.mill = BFC_Timer:new();
		BFC_AV.timers.mill:SetFontString(BFC_AV_Mill);
		BFC_AV.timers.mill:SetText(BFC_Strings.AV.mill);
		BFC_AV.timers.mill:SetTimerColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.mill:SetLabelColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.mill:SetCallback(BFC_AV.NodeTimerCallback);
		--BFC_AV.tMill:SetTime(BFC_AV_NODE_CAP_TIME);
		--BFC_AV.tMill:Start();
		
		BFC_AV.timers.mine = BFC_Timer:new();
		BFC_AV.timers.mine:SetFontString(BFC_AV_Mine);
		BFC_AV.timers.mine:SetText(BFC_Strings.AV.mine);
		BFC_AV.timers.mine:SetTimerColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.mine:SetLabelColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.mine:SetCallback(BFC_AV.NodeTimerCallback);
		--BFC_AV.tMine:SetTime(BFC_AV_NODE_CAP_TIME);
		--BFC_AV.tMine:Start();
		
		BFC_AV.timers.stAVles = BFC_Timer:new();
		BFC_AV.timers.stAVles:SetFontString(BFC_AV_StAVles);
		BFC_AV.timers.stAVles:SetText(BFC_Strings.AV.stAVles);
		BFC_AV.timers.stAVles:SetTimerColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.stAVles:SetLabelColorCode(BFC_AV_FACTIONCOLORS.neutral);
		BFC_AV.timers.stAVles:SetCallback(BFC_AV.NodeTimerCallback);
		--BFC_AV.tStAVles:SetTime(BFC_AV_NODE_CAP_TIME);
		--BFC_AV.tStAVles:Start();
		
		
		-- Zone-specific comms menu
		BFC_Radio.SetLocalMenuItems(BFC_Strings.CommsMenu_AV);
		
		-- Receive rez time notifications
		BFC_Comms.RegisterMessage("AV", "REZ", BFC_AV.HandleRezMessage);
		BFC_AV_Frame:Show();
	else
		BFC_AV_Frame:UnregisterEvent("AREA_SPIRIT_HEALER_IN_RANGE");
		BFC_AV_Frame:UnregisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE"); 
		BFC_AV_Frame:UnregisterEvent("CHAT_MSG_BG_SYSTEM_HORDE"); 
		BFC_AV_Frame:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
		
		BFC_Comms.UnregisterMessage("AV", "REZ");
		BFC_Radio.SetLocalMenuItems(nil);
		
		-- No need for the update when we're not active.
		BFC_Common.UnregisterUpdateFunction("BFC_AV");
		BFC_AV_Frame:Hide();
	end
end

-- Called by the module dispatcher to determine if we're in an active zone
function BFC_AV.IsActiveZone(zone)
	if(zone == BFC_Strings.AV.zone) then
		return true;
	else
		return false;
	end
end


-- Called by the common OnUpdate handler (registered/unregistered in SetActive)
function BFC_AV.OnUpdate(elapsed)
	-- FIXME: throttle this
	local gy = BFC_AV.LocateNearestGraveyard();
	if(gy ~= nil) then
		BFC_AV_RezLoc:SetText(string.format(BFC_Strings.AV.rezloc, gy.name));
	end
end


-- Called whenever one of the node timers counts to zero
function BFC_AV.NodeTimerCallback(timer)
	timer:SetTime(BFC_AV_REZ_INTERVAL);
	timer:Start();
end


-- Locate the nearest captured graveyard, that is where the player will rez at
function BFC_AV.LocateNearestGraveyard()
	local px,py = GetPlayerMapPosition("player");
	local distsq, a, b;
	local closest = nil;
	local closestDist = 9999; -- this is plenty, dists should be < 1 anyway
	
	for i,v in ipairs(BFC_AV_GRAVEYARDS) do
		a = math.abs(px - v.x);
		b = math.abs(py - v.y);
		distsq = a*a + b*b;
		if(distsq < closestDist and graveyardfactions[v.id] and graveyardfactions[v.id] == playerfaction) then
			closestDist = distsq;
			closest = v;
			--BFC.Log(BFC.LOG_DEBUG, string.format("New closest: dist to %s is %s", v.name, distsq));
		end
	end
	
	return closest;
end


function BFC_AV.HandleRezMessage(player, timeleft)
	BFC.Log(BFC.LOG_DEBUG, "Syncing rez timer to " .. timeleft[1]);
	BFC_AV.SyncTimer(timeleft[1]);
end


-- Set the rez timer to a new value
function BFC_AV.SyncTimer(secondsLeft)
	BFC_AV.CurTime = GetTime();
	BFC_AV.RezTimer = secondsLeft;
	BFC_AV.RezTimerActive = true;
end


-- Your standard event handler
function BFC_AV.OnEvent()
	if(event == "AREA_SPIRIT_HEALER_IN_RANGE" and UnitIsGhost("player")) then
		local timeToRez = GetAreaSpiritHealerTime();
		BFC_AV.SyncTimer(timeToRez);
		BFC_Comms.SendMessage("AV", "REZ", timeToRez);
	elseif(event == "UPDATE_BATTLEFIELD_SCORE") then
		BFC_AV.UpdateClassInfo();
	elseif(event == "CHAT_MSG_BG_SYSTEM_ALLIANCE") then
		BFC_AV.ParseNodeEvent(arg1, "Alliance");
	elseif(event == "CHAT_MSG_BG_SYSTEM_HORDE") then
		BFC_AV.ParseNodeEvent(arg1, "Horde");
	end
end


-- Figure out what happened to the node
function BFC_AV.ParseNodeEvent(text, faction)
	local i, _, node = string.find(text, BFC_Strings.AV.event_assaulted);
	local timer;
	if(i) then
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		graveyardfactions[node] = "Neutral";
		timer = BFC_AV.timers[nodetrans[node]];
		timer:SetTime(60);
		timer:SetCallback(nil);
		timer:SetTimerColorCode(BFC_AV_FACTIONCOLORS[faction]);
		timer:SetLabelColorCode(BFC_AV_FACTIONCOLORS.neutral);
		timer:Start();
	end
	
	local i, _, node = string.find(text, BFC_Strings.AV.event_taken);
	if(i) then
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		graveyardfactions[node] = faction;
		timer = BFC_AV.timers[nodetrans[node]];
		timer:SetTime(30);
		timer:SetCallback(BFC_AV.NodeTimerCallback);
		timer:SetTimerColorCode(BFC_AV_FACTIONCOLORS[faction]);
		timer:SetLabelColorCode(BFC_AV_FACTIONCOLORS[faction]);
		timer:Start();
	end
	
	local i, _, node = string.find(text, BFC_Strings.AV.event_claims);
	if(i) then
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		graveyardfactions[node] = "Neutral";
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		timer = BFC_AV.timers[nodetrans[node]];
		timer:SetTime(60);
		timer:SetCallback(nil);
		timer:SetTimerColorCode(BFC_AV_FACTIONCOLORS[faction]);
		timer:Start();
	end
		
end

function BFC_AV.TargetCarrier(carrier)
	if(carrier and carrier ~= "" and carrier ~= BFC_Strings.AV["atbase"] and carrier ~= BFC_Strings.AV["dropped"]) then
		TargetByName(carrier);
	end
end