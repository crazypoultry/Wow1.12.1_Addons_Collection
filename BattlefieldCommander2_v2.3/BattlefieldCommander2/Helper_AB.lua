
BFC_AB = {}; -- Initialize the BFC_AB namespace

local BFC_AB_REZ_INTERVAL = 31; -- rez wave every ~30s
local BFC_AB_NODE_CAP_TIME = 64;



local gyclosestdist = 999;
local playerfaction;
local nodetrans;
BFC_AB.timers = {};

local BFC_AB_GRAVEYARDS = {
	{	x = 0.395845,
		y = 0.261748,
		id = BFC_Strings.AB_Nodes.stables,
		name = BFC_Strings.AB.stables,
	},
	{	x = 0.613111,
		y = 0.253503,
		id = BFC_Strings.AB_Nodes.mine,
		name = BFC_Strings.AB.mine
	},
	{	x = 0.367385,
		y = 0.628251,
		id = BFC_Strings.AB_Nodes.mill,
		name = BFC_Strings.AB.mill
	},
	{	x = 0.514248,
		y = 0.419996,
		id = BFC_Strings.AB_Nodes.blacksmith,
		name = BFC_Strings.AB.blacksmith
	},
	{	x = 0.611782,
		y = 0.575198,
		id = BFC_Strings.AB_Nodes.farm,
		name = BFC_Strings.AB.farm
	},
	{	x = 0.334840,
		y = 0.131217,
		id = "trollbane",
		name = BFC_Strings.AB.trollbane
	},
	{	x = 0.694644,
		y = 0.678682,
		id = "defilers",
		name = BFC_Strings.AB.defilers
	},
};

local BFC_AB_POINTRATES = 
{ 
	[0] = { time = 0, rate = 999999 },
	[1] = { time = 11, rate = 1.1 },
	[2] = { time = 10, rate = 1 },
	[3] = { time = 6, rate = 0.6 },
	[4] = { time = 3, rate = 0.3 },
	[5] = { time = 1, rate = 0.03333 }
};

local BFC_AB_FACTIONCOLORS = {
	Horde = "|cffff2020",
	Alliance = "|cff00aeef",
	Neutral = "|cff999999",
};

local graveyardfactions = {};

function BFC_AB.Onload()
	-- Create the helper module and register it with the BFC system.
	local modobj = {
		Name = BFC_Strings.AB.modname, -- A unique name, doesn't need to be the zone name
		Author = "Vallerius", -- Give yourself credit. Not used yet, might appear later in a management screen
		Version = "1.0", -- Also unused for now
		Type = "ZONE_HELPER", -- Must be ZONE_HELPER for per-zone helper objects
		SetActive = BFC_AB.SetActive, -- Function to enable/disable the helper
		IsActiveZone = BFC_AB.IsActiveZone, -- Function to determine if we're in a target zone
		OptionsFrame = "BFC_AB_OptionsFrame", -- Frame to display helper options in
	};
	BFC_Common.RegisterHelperModule(modobj);
	nodetrans = BFC_Util.FlipKeysAndValues(BFC_Strings.AB_Nodes);
	playerfaction = UnitFactionGroup("player");
end


-- Called by the module dispatcher whenever we enter/leave an active zone
function BFC_AB.SetActive(state)
	if(state == true) then
		--UIDropDownMenu_Initialize(BFC_AB_OptionsDropDown, BFC_AB.OptionsDropDown_Initialize, "MENU");
		
		BFC_Common.RegisterEvent("AREA_SPIRIT_HEALER_IN_RANGE", BFC_AB.OnEvent);
		BFC_Common.RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", BFC_AB.OnEvent); 
		BFC_Common.RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE", BFC_AB.OnEvent); 
		BFC_Common.RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", BFC_AB.OnEvent);
		BFC_Common.RegisterEvent("UPDATE_BATTLEFIELD_SCORE", BFC_AB.HandleScoreEvent);
		BFC_Common.RegisterEvent("UPDATE_WORLD_STATES", BFC_AB.HandleScoreEvent);
		BFC_Common.RegisterEvent("WORLD_MAP_UPDATE", BFC_AB.HandleNodeUpdateEvent);
		
		-- Reset the mod state so that it's fresh every time
		
		BFC_AB.RezTimer = BFC_AB_REZ_INTERVAL
		BFC_AB.RezTimerActive = false;
		
		graveyardfactions[BFC_Strings.AB_Nodes.blacksmith] = "Neutral";
		graveyardfactions[BFC_Strings.AB_Nodes.farm] = "Neutral";
		graveyardfactions[BFC_Strings.AB_Nodes.mine] = "Neutral";
		graveyardfactions[BFC_Strings.AB_Nodes.mill] = "Neutral";
		graveyardfactions[BFC_Strings.AB_Nodes.stables] = "Neutral";
		graveyardfactions["trollbane"] = "Alliance";
		graveyardfactions["defilers"] = "Horde";
		
		-- The update function will be called every frame, even if the AB helper frame isn't visible.
		BFC_Common.RegisterUpdateFunction("BFC_AB", BFC_AB.OnUpdate);
		
		
		BFC_AB_Alliance_Score:SetTextColor(BFC_Common.COLOR_ALLIANCE.r, BFC_Common.COLOR_ALLIANCE.g, BFC_Common.COLOR_ALLIANCE.b);
		BFC_AB_Horde_Score:SetTextColor(BFC_Common.COLOR_HORDE.r, BFC_Common.COLOR_HORDE.g, BFC_Common.COLOR_HORDE.b);
		BFC_AB_Score_Text:SetText(BFC_Strings.AB.score);
		
		local info = BFC_InfoFrame:getInstance();
		info:addFrame(BFC_AB_Score_Frame, BFC_Strings.AB.zone, "ab_score");
		info:addFrame(BFC_AB_Frame, BFC_Strings.AB.zone, "ab_nodetimers");
		info:addFrame(BFC_AB_TimeToWin_Frame, BFC_Strings.AB.zone, "ab_timetowin");
		info:addFrame(BFC_AB_BasesToWin_Frame, BFC_Strings.AB.zone, "ab_basestowin");
		
		-- Set up the timers
		BFC_AB.timers = {};
		BFC_AB.timers.blacksmith = BFC_Timer:new();
		BFC_AB.timers.blacksmith:SetFontString(BFC_AB_Blacksmith);
		--BFC_AB.timers.blacksmith:SetText(BFC_Strings.AB.blacksmith);
		BFC_AB.timers.blacksmith:SetTimerColorCode(BFC_AB_FACTIONCOLORS.neutral);
		--BFC_AB.timers.blacksmith:SetLabelColorCode(BFC_AB_FACTIONCOLORS.neutral);
		BFC_AB.timers.blacksmith:SetCallback(BFC_AB.NodeTimerCallback);
		--BFC_AB.tSmith:SetTime(BFC_AB_NODE_CAP_TIME);
		--BFC_AB.tSmith:Start();
		
		BFC_AB.timers.farm = BFC_Timer:new();
		BFC_AB.timers.farm:SetFontString(BFC_AB_Farm);
		--BFC_AB.timers.farm:SetText(BFC_Strings.AB.farm);
		BFC_AB.timers.farm:SetTimerColorCode(BFC_AB_FACTIONCOLORS.neutral);
		--BFC_AB.timers.farm:SetLabelColorCode(BFC_AB_FACTIONCOLORS.neutral);
		BFC_AB.timers.farm:SetCallback(BFC_AB.NodeTimerCallback);
		--BFC_AB.tFarm:SetTime(BFC_AB_NODE_CAP_TIME);
		--BFC_AB.tFarm:Start();
		
		BFC_AB.timers.mill = BFC_Timer:new();
		BFC_AB.timers.mill:SetFontString(BFC_AB_Mill);
		--BFC_AB.timers.mill:SetText(BFC_Strings.AB.mill);
		BFC_AB.timers.mill:SetTimerColorCode(BFC_AB_FACTIONCOLORS.neutral);
		--BFC_AB.timers.mill:SetLabelColorCode(BFC_AB_FACTIONCOLORS.neutral);
		BFC_AB.timers.mill:SetCallback(BFC_AB.NodeTimerCallback);
		--BFC_AB.tMill:SetTime(BFC_AB_NODE_CAP_TIME);
		--BFC_AB.tMill:Start();
		
		BFC_AB.timers.mine = BFC_Timer:new();
		BFC_AB.timers.mine:SetFontString(BFC_AB_Mine);
		--BFC_AB.timers.mine:SetText(BFC_Strings.AB.mine);
		BFC_AB.timers.mine:SetTimerColorCode(BFC_AB_FACTIONCOLORS.neutral);
		--BFC_AB.timers.mine:SetLabelColorCode(BFC_AB_FACTIONCOLORS.neutral);
		BFC_AB.timers.mine:SetCallback(BFC_AB.NodeTimerCallback);
		--BFC_AB.tMine:SetTime(BFC_AB_NODE_CAP_TIME);
		--BFC_AB.tMine:Start();
		
		BFC_AB.timers.stables = BFC_Timer:new();
		BFC_AB.timers.stables:SetFontString(BFC_AB_Stables);
		--BFC_AB.timers.stables:SetText(BFC_Strings.AB.stables);
		BFC_AB.timers.stables:SetTimerColorCode(BFC_AB_FACTIONCOLORS.neutral);
		--BFC_AB.timers.stables:SetLabelColorCode(BFC_AB_FACTIONCOLORS.neutral);
		BFC_AB.timers.stables:SetCallback(BFC_AB.NodeTimerCallback);
		--BFC_AB.tStables:SetTime(BFC_AB_NODE_CAP_TIME);
		--BFC_AB.tStables:Start();

		BFC_AB.timers.timeToWin = BFC_Timer:new();
		BFC_AB.timers.timeToWin:SetFontString(BFC_AB_TimeToWin);
		BFC_AB.timers.timeToWin:SetText(BFC_Strings.AB.timetowin);
		BFC_AB.timers.timeToWin:SetTimerColorCode(BFC_AB_FACTIONCOLORS.neutral);
		BFC_AB.timers.timeToWin:SetLabelColorCode(BFC_AB_FACTIONCOLORS.neutral);
		BFC_AB.timers.timeToWin:SetFormat("ms");

		
		-- Zone-specific comms menu
		BFC_Radio.SetLocalMenuItems(BFC_Strings.CommsMenu_AB, BFC_Strings.AB.zone);
		
		-- Receive rez time notifications
		BFC_Comms.RegisterMessage("AB", "REZ", BFC_AB.HandleRezMessage);
		--BFC_AB_Frame:Show();
		
	else
		BFC_Common.UnregisterEvent("AREA_SPIRIT_HEALER_IN_RANGE", BFC_AB.OnEvent);
		BFC_Common.UnregisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE", BFC_AB.OnEvent); 
		BFC_Common.UnregisterEvent("CHAT_MSG_BG_SYSTEM_HORDE", BFC_AB.OnEvent); 
		BFC_Common.UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", BFC_AB.OnEvent);
		BFC_Common.UnregisterEvent("UPDATE_BATTLEFIELD_SCORE", BFC_AB.HandleScoreEvent);
		
		BFC_Comms.UnregisterMessage("AB", "REZ");
		BFC_Radio.SetLocalMenuItems(nil);
		
		-- No need for the update when we're not active.
		BFC_Common.UnregisterUpdateFunction("BFC_AB");
		
		local info = BFC_InfoFrame:getInstance();
		info:removeFrame(BFC_Strings.AB.zone, "ab_nodetimers");
		info:removeFrame(BFC_Strings.AB.zone, "ab_score");
		info:removeFrame(BFC_Strings.AB.zone, "ab_timetowin");
		info:removeFrame(BFC_Strings.AB.zone, "ab_basestowin");
		
		-- Stop and clean up any timers
		for i,v in ipairs(BFC_AB.timers) do
			v:Stop();
			v = nil;
		end
		
		BFC_AB_Frame:Hide();
	end
end

-- Called by the module dispatcher to determine if we're in an active zone
function BFC_AB.IsActiveZone(zone)
	if(zone == BFC_Strings.AB.zone) then
		return true;
	else
		return false;
	end
end


-- Called by the common OnUpdate handler (registered/unregistered in SetActive)
function BFC_AB.OnUpdate(elapsed)
	-- FIXME: throttle this
	local gy = BFC_AB.LocateNearestGraveyard();
	if(gy ~= nil) then
		BFC_AB_RezLoc:SetText(string.format(BFC_Strings.AB.rezloc, gy.name));
	end
end


-- Called whenever one of the node timers counts to zero
function BFC_AB.NodeTimerCallback(timer)
	timer:SetTime(BFC_AB_REZ_INTERVAL);
	timer:Start();
end


-- Locate the nearest captured graveyard, that is where the player will rez at
function BFC_AB.LocateNearestGraveyard()
	local px,py = GetPlayerMapPosition("player");
	local distsq, a, b;
	local closest = nil;
	local closestDist = 9999; -- this is plenty, dists should be < 1 anyway
	
	for i,v in ipairs(BFC_AB_GRAVEYARDS) do
		a = math.abs(px - v.x);
		b = math.abs(py - v.y);
		distsq = a*a + b*b;
		if(distsq < closestDist and graveyardfactions[v.id] and graveyardfactions[v.id] == playerfaction) then
			closestDist = distsq;
			closest = v;
			--BFC.Log(BFC.LOG_ERROR, "ID is " .. v.id);
			--if(graveyardfactions[v.id]) then
			--	BFC.Log(BFC.LOG_ERROR, "Faction is " .. graveyardfactions[v.id]);
			--	BFC.Log(BFC.LOG_ERROR, "PF is " .. playerfaction);
			--end
		end
	end
	
	return closest;
end


function BFC_AB.HandleRezMessage(player, timeleft)
	BFC.Log(BFC.LOG_DEBUG, "Syncing rez timer to " .. timeleft[1]);
	BFC_AB.SyncTimer(timeleft[1]);
end


-- Set the rez timer to a new value
function BFC_AB.SyncTimer(secondsLeft)
	BFC_AB.CurTime = GetTime();
	BFC_AB.RezTimer = secondsLeft;
	BFC_AB.RezTimerActive = true;
end


-- Your standard event handler
function BFC_AB.OnEvent(event, ...)
	if(event == "AREA_SPIRIT_HEALER_IN_RANGE" and UnitIsGhost("player")) then
		local timeToRez = GetAreaSpiritHealerTime();
		BFC_AB.SyncTimer(timeToRez);
		BFC_Comms.SendMessage("AB", "REZ", timeToRez);
	elseif(event == "CHAT_MSG_BG_SYSTEM_ALLIANCE") then
		BFC_AB.ParseNodeEvent(arg[1], "Alliance");
	elseif(event == "CHAT_MSG_BG_SYSTEM_HORDE") then
		BFC_AB.ParseNodeEvent(arg[1], "Horde");
	end
end


-- Handle score change
function BFC_AB.HandleScoreEvent()
	local _, ascore = GetWorldStateUIInfo(1);
	local _, hscore = GetWorldStateUIInfo(2);
	local abases, hbases;
	
	if(ascore and hscore) then
		_, _, abases, ascore = string.find(ascore, BFC_Strings.AB.scorepattern);
		_, _, hbases, hscore = string.find(hscore, BFC_Strings.AB.scorepattern);
	end
	
	if(abases and ascore and hbases and hscore) then
		BFC_AB.CalculateWinConditions(tonumber(ascore), tonumber(abases), tonumber(hscore), tonumber(hbases));
		
		BFC_AB_Alliance_Score:SetText(ascore);
		BFC_AB_Horde_Score:SetText(hscore);
	end
	
end


-- Figure out what happened to the node
function BFC_AB.ParseNodeEvent(text, faction)
	local i, _, node = string.find(text, BFC_Strings.AB.event_assaulted);
	local timer;
	if(i) then
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		graveyardfactions[node] = "Neutral";
		timer = BFC_AB.timers[nodetrans[node]];
		timer:SetTime(BFC_AB_NODE_CAP_TIME);
		timer:SetCallback(nil);
		timer:SetTimerColorCode(BFC_AB_FACTIONCOLORS[faction]);
		--timer:SetLabelColorCode(BFC_AB_FACTIONCOLORS.neutral);
		timer:Start();
	end
	
	local i, _, node = string.find(text, BFC_Strings.AB.event_taken);
	if(i) then
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		graveyardfactions[node] = faction;
		timer = BFC_AB.timers[nodetrans[node]];
		--timer:SetCallback(BFC_AB.NodeTimerCallback);
		timer:SetTimerColorCode(BFC_AB_FACTIONCOLORS[faction]);
		--timer:SetLabelColorCode(BFC_AB_FACTIONCOLORS[faction]);
		timer:Stop();
		timer:SetTime(-1);
		--timer:Start();
	end
	
	local i, _, node = string.find(text, BFC_Strings.AB.event_claims);
	if(i) then
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		graveyardfactions[node] = "Neutral";
		--BFC.Log(BFC.LOG_ERROR, "Node is " .. node);
		timer = BFC_AB.timers[nodetrans[node]];
		timer:SetTime(BFC_AB_NODE_CAP_TIME);
		timer:SetCallback(nil);
		timer:SetTimerColorCode(BFC_AB_FACTIONCOLORS[faction]);
		timer:Start();
	end
		
end


function BFC_AB.HandleNodeUpdateEvent()
	local landmarks = GetNumMapLandmarks();
	local x1, y1, x2, y2;
	local name, description, textureIndex, x, y;
	local tex;
	
	for i = 1, landmarks do
		name, description, textureIndex, x, y = GetMapLandmarkInfo(i);
		tex = nil;
		if(name == BFC_Strings.AB.farm) then
			tex = BFC_AB_Farm_Texture;
		elseif(name == BFC_Strings.AB.blacksmith) then
			tex = BFC_AB_Blacksmith_Texture;
		elseif(name == BFC_Strings.AB.mill) then
			tex = BFC_AB_Mill_Texture;
		elseif(name == BFC_Strings.AB.stables) then
			tex = BFC_AB_Stables_Texture;
		elseif(name == BFC_Strings.AB.mine) then
			tex = BFC_AB_Mine_Texture;
		end
		if(tex) then
			x1, x2, y1, y2 = WorldMap_GetPOITextureCoords(textureIndex);
			tex:SetTexture("Interface\\Minimap\\POIIcons");
			tex:SetTexCoord(x1, x2, y1, y2);
		end
	end
end


function BFC_AB.TargetCarrier(carrier)
	if(carrier and carrier ~= "" and carrier ~= BFC_Strings.AB["atbase"] and carrier ~= BFC_Strings.AB["dropped"]) then
		TargetByName(carrier);
	end
end

function BFC_AB.CalculateWinConditions(ascore, abases, hscore, hbases)

	if(BFC_AB.lastascore and BFC_AB.lasthscore and BFC_AB.lastascore == ascore and BFC_AB.lasthscore == hscore) then return end
	BFC_AB.lastascore = ascore;
	BFC_AB.lasthscore = hscore;
	local timeleft;
	local needed;
	local estTime;
	local estAScore;
	local estHScore;

	-- check for data and victory
	if (not ascore) or (not hscore) or (ascore == "2000") or (hscore == "2000") then
		timeleft = 0;
		return 0,0,0,"";
	end
	
	-- calculate bases needed
	if (((2000 - ascore) * BFC_AB_POINTRATES[1].rate) < ((2000 - hscore) * BFC_AB_POINTRATES[4].rate)) then
		needed = 1;
	elseif (((2000 - ascore) * BFC_AB_POINTRATES[2].rate) < ((2000 - hscore) * BFC_AB_POINTRATES[3].rate)) then
		needed = 2;
	elseif (((2000 - ascore) * BFC_AB_POINTRATES[3].rate) < ((2000 - hscore) * BFC_AB_POINTRATES[2].rate)) then
		needed = 3;
	elseif (((2000 - ascore) * BFC_AB_POINTRATES[4].rate) < ((2000 - hscore) * BFC_AB_POINTRATES[1].rate)) then
		needed = 4;
	else
		needed = 5;
	end
	
	if(UnitFactionGroup("player") == 2) then
		needed = 6 - needed;
	end

	arate = (2000 - ascore) * BFC_AB_POINTRATES[abases].rate;
	hrate = (2000 - hscore) * BFC_AB_POINTRATES[hbases].rate;
	estTime = math.min(arate, hrate);
	estAScore = 2000;
	estHScore = 2000;
	
	
	-- Calculate alliance score
	if (abases == 0) then
		estAScore = ascore;
	elseif (hrate < arate) then
		estAScore = ascore + floor((hrate / BFC_AB_POINTRATES[abases].time)) * 10;
	end
	-- Calculate horde score
	if (hbases == 0) then
		estHScore = hscore;
	elseif (arate < hrate) then
		    estHScore = hscore + floor((arate / BFC_AB_POINTRATES[hbases].time)) * 10;
	end
	-- Check if we're just starting the game
	if (arate == 1999998000) and (hrate == 1999998000) then
       	estAScore = 2000;
       	estHScore = 2000;
   	end;

	--calculate estimated time
	if (estTime == 1999998000) then
		--return estAScore, estHScore, 5,0;
		--needed = 5;
		BFC_AB_TimeToWin:SetText(BFC_Strings.AB.alliancetimetowin .. ": --");
	else
		--ABH_TimeLeft = estTime;
		--ABH_LastTimerUpdate = time();
		--return estAScore, estHScore, needed, math.floor(estimatedTime);
		if(estAScore > estHScore) then
			BFC_AB.timers.timeToWin:SetText(BFC_Strings.AB.alliancetimetowin);
		else
			BFC_AB.timers.timeToWin:SetText(BFC_Strings.AB.hordetimetowin);
		end
		BFC_AB.timers.timeToWin:SetTime(estTime);
		BFC_AB.timers.timeToWin:Start();
	end

	BFC_AB_BasesToWin:SetText(BFC_Strings.AB.basestowin .. ": " .. needed);
end




-- Called when the frame is right-clicked
function BFC_AB.ShowSettingsFrame()
	ToggleDropDownMenu(1, nil, BFC_AB_OptionsDropDown, this:GetName(), 0, 0);
end



function BFC_AB.OptionsDropDown_Initialize()
	local checked;
	local info = {};
	
	info.text = BFC_Strings.AB.zone;
	info.justifyH = "CENTER";
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Show battlefield score
	if ( BFC_Options.get("ab_showScore") ) then
		checked = 1;
	end
	info.text = BFC_Strings.AB_Options.showscore;
	info.func = BFC_AB.ToggleScore;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Hide the default scoreboard
	if ( BFC_Options.get("ab_hideScoreBoard") ) then
		checked = 1;
	end
	info.text = BFC_Strings.AB_Options.hidescoreboard;
	info.func = BFC_AB.ToggleScoreBoard;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- AB window lock
	checked = nil;
	if ( BFC_Options.get("ab_locked") ) then
		checked = 1;
	end
	info.text = BFC_Strings.AB_Options.lockwindow;
	info.func = BFC_AB.ToggleLock;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Show timers
	checked = nil;
	if ( BFC_Options.get("ab_timers") ) then
		checked = 1;
	end
	info = {};
	info.text = BFC_Strings.AB_Options.showtimers;
	info.func = BFC_AB.ToggleTimers;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Hide
	--checked = nil;
	--info = {};
	--info.text = BFC_Strings.AB_Options.hidewindow;
	--info.notCheckable = 1;
	--info.func = BFC_AB.HideInfoWindow;
	--UIDropDownMenu_AddButton(info);
end


function BFC_AB.ToggleScore()

end


function BFC_AB.ToggleScoreBoard()

end


function BFC_AB.ToggleLock()

end

function BFC_AB.ToggleTimers()

end