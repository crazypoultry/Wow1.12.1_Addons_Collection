--------------------------------
--[[======= Constants ========]]
--------------------------------
local BWP_Zones = {};
local BWP_KalimdorZones = {};
local BWP_EasternZones = {};
local BWP_Player = nil;

Kalimdor = "Kalimdor";
EasternKingdoms = "Eastern Kingdoms";

BWP_Highlighttext ="|cffFFFFFF"
BWP_Redtext="|cffFF0000"
BWP_Greentext = "|cff00FF00"
--------------------------------
--[[======= Variables ========]]
--------------------------------
BWP_Data = {};
BWP_CZone = {};
BWP_Dest = nil;
BWP_LastPosition = {nil};
BWP_Data[Kalimdor] = {};
BWP_Data[EasternKingdoms] = {};
ArrowIcon = nil


local BWP_FirstLoad = true;
local gdpx, gdpy, gddx, gddy, gddir, gdclx, gdcly;
--Map Variables below
	local MAX_LOC_SAMPLES = 50;-- Circular arrays to store X,Y,time locations
	local LOC_X_SAMPLES = {};
	local LOC_Y_SAMPLES = {};
	local LOC_T_SAMPLES = {};	
	-- The last index written into
	local lastIdx = 0;
	-- Last coordinates, used to avoid spamming location arrays
	local lastX,lastY = 0,0;
	-- Configuration/thresholds -- Tune these together with coordinate
	-- system for a balance of update speed and jitter reduction
	-- Make sure that MIN_CUMUL_RANGE is at least 2 times as large as	
	-- MIN_SAMPLE_DISTANCE (Preferably between about 3-10 times)
	-- Minimum change in at least one direction to store something	
	local MIN_SAMPLE_DISTANCE = 0.0001;
	-- Maximum age of an old record to look at
	local MAX_CUMUL_TIME = 2.0;
	-- Minimum range for a significant vector
	local MIN_CUMUL_RANGE = 0.0003;
	-- Square of minimum range to avoid an unnecessary sqrt
	local MIN_CUMUL_RANGE_SQ = MIN_CUMUL_RANGE * MIN_CUMUL_RANGE;
	-- Last degree value, just here for debugging sanity
	local lastDeg = nil;

--------------------------------
--[[======= Note Class =====]]
--------------------------------
local BWPnode = {};
local BWPmeta = {};

StartPosition = {nil}
-- Constructor
function BWPnode:new(x, y, text, who) 
	return setmetatable( { xcoord = x, ycoord = y, note = text, author = who}, SNmeta);
end

-- Deconstructor
function BWPnode:delete()
	return setmetatable({}, BWPmeta);
end

--Getters
function BWPnode:getX() return self.xcoord; end
function BWPnode:getY() return self.ycoord; end
function BWPnode:getNote() return self.note; end
function BWPnode:getAuthor() return self.author; end

-- Setters
function BWPnode:setX(x) self.xcoord = x; end
function BWPnode:setY(y) self.ycoord = y; end
function BWPnode:setNote(text) self.note = text; end
function BWPnode:setAuthor(text) self.author = text; end

-- Query redirect
BWPmeta.__index = BWPnode;


--------------------------------
--[[====== Display Class =====]]
--------------------------------
local BWPDisp = {};
local BWPDispm = {};

-- Constructor
function BWPDisp:new(x, y, who, desc, txt1, txt2, mod) 
	

	return setmetatable( { xcoord = x, ycoord = y, author = who, title = desc, inf1 = txt1, inf2 = txt2, type = mod }, BWPDispm);
end



-- Deconstructor
function BWPDisp:delete()
	return setmetatable({}, BWPDispm);
end

-- Getters
function BWPDisp:getX() return self.xcoord; end
function BWPDisp:getY() return self.ycoord; end
function BWPDisp:getTitle() return self.title; end
function BWPDisp:getNote1() return self.inf1; end
function BWPDisp:getNote2() return self.inf2; end
function BWPDisp:getAuthor() return self.author; end
function BWPDisp:getType() return self.type; end

-- Query redirect
BWPDispm.__index = SNDisp;

--------------------------------
--[[===== Core Functions =====]]
--------------------------------
-- tinsert(table, index, value) - adds value at the index in Table, or at the end if index = nil
-- tremove(table, index) - removes value at Index in Table

function BetterWaypoints_FormatCoords(x, y)
	local rx, ry, fx, fy, nx, ny;
	nx = string.format("%i", x*10000); ny = string.format("%i", y*10000);
	fx = string.format("%i", x*1000); fy = string.format("%i", y*1000);
	rx = string.format("%i", x*100); ry = string.format("%i", y*100);

	fx = tonumber(strsub(fx, strlen(fx),strlen(fx))); fy = tonumber(strsub(fy, strlen(fy), strlen(fy)));

	if (tonumber(strsub(nx, strlen(nx), strlen(nx))) >= 5) then fx = fx + 1; end
	if (tonumber(strsub(ny, strlen(ny), strlen(ny))) >= 5) then fy = fy + 1; end

	return tonumber(rx.."."..fx), tonumber(ry.."."..fy);
end

function BetterWaypoints_Delete(num)
	SetMapToCurrentZone();
	local zone = GetRealZoneText();
	local cont = nil;

	if (BWP_Zones[zone] == 1) then cont = "Kalimdor";
	elseif (BWP_Zones[zone] == 2) then cont = "Eastern Kingdoms";end

	if (not BWP_Data[cont][zone]) then DEFAULT_CHAT_FRAME:AddMessage("No Waypoint data for this zone");
	elseif (not BWP_Data[cont][zone][num]) then DEFAULT_CHAT_FRAME:AddMessage("No Waypoint at this index in zone");
	else tremove(BWP_Data[cont][zone], num); DEFAULT_CHAT_FRAME:AddMessage("Better Waypoint #"..num.." deleted."); end
end

function BetterWaypoints_NewNote(text)
	SetMapToCurrentZone();
	local x, y = BetterWaypoints_FormatCoords(GetPlayerMapPosition("player"));
	if (x == 0 and y == 0) then DEFAULT_CHAT_FRAME:AddMessage("No coordinates available in region"); return; end
	local BWP_Temp = BWPnode:new(x, y, text, BWP_Player);

	local zone = GetRealZoneText();
	local cont = nil;

	if (BWP_Zones[zone] == 1) then cont = "Kalimdor";
	elseif (BWP_Zones[zone] == 2) then cont = "Eastern Kingdoms";
	else end

	local getking = BWP_Data[cont];
	if (BWP_Data[cont] and BWP_Data[cont][zone]) then
		tinsert(BWP_Data[cont][zone], BWP_Temp);
	else BWP_Data[cont][zone] = { BWP_Temp };
	end

	DEFAULT_CHAT_FRAME:AddMessage("Noted");
end
function BetterWaypoints_LoadZones()
	local BWP_KalimdorZones = { GetMapZones(1) };
	local BWP_EasternZones = { GetMapZones(2) };

	for key in BWP_KalimdorZones do BWP_Zones[SN_KalimdorZones[key]] = 1; end
	for key in BWP_EasternZones do BWP_Zones[SN_EasternZones[key]] = 2; end	
end
--[[
function BetterWaypoints_GetDist()
	gdpx, gdpy = GetPlayerMapPosition("player");
	if (x == 0 and y == 0) then BWP_Dest = nil; return ""; end
	if (BWP_Dest.zone ~= GetRealZoneText()) then BWP_Dest = nil; return ""; end

	gddx, gddy = BWP_Dest.x, BWP_Dest.y;
	local zone = GetRealZoneText();
	if(MapLibrary) and ((not BWP_Hide) or (not BWP_Hide.Yards))and (MapLibraryData.translation[zone]) then
		
		
			gdpx_f, gdpy_f = MapLibrary.TranslateZoneToWorld(gdpx, gdpy, zone);
			gddx_f, gddy_f = MapLibrary.TranslateZoneToWorld(gddx, gddy, zone);
			thisdistance = MapLibrary.YardDistance(gddx_f, gddy_f, gdpx_f, gdpy_f);
		
	else thisdistance = (math.sqrt((gdpx - gddx)^2 + (gdpy - gddy)^2))*100
	end
	return thisdistance
end]]--
--Returns Distance(in whatever units it recieves)
function getdist(loc1 , loc2)
	if(not loc1) or (not loc2) then return nil 
	else return math.sqrt((loc1.x - loc2.x)^2 + (loc1.y - loc2.y)^2)
	end
end
--formats to yards or meters or clicks
function formatdist(loc1,loc2)
	local zone = GetRealZoneText();
	local thisDistance = getdist(loc1 , loc2)
	local flag = BWP_getflag(thisDistance) -- gets the color flag based on distance in Units
	local theseUnits = " Clicks"
	thisDistance = tonumber(string.format("%.2f" , thisDistance*100)) --2 decimal places when using clicks
	if(MapLibrary) and  (MapLibraryData.translation[zone]) then
		--If the User Has MapLibrary Installed get the distance in yards
		local gdpx_f, gdpy_f = MapLibrary.TranslateZoneToWorld(loc1.x, loc1.y, zone);
		local gddx_f, gddy_f = MapLibrary.TranslateZoneToWorld(loc2.x, loc2.y, zone);
		thisDistance = MapLibrary.YardDistance(gddx_f, gddy_f, gdpx_f, gdpy_f);
		--now check if the user wants to see Yards
		
		if(BWP_Hide.Yards) then
			
			thisDistance = thisDistance * 0.9144	
			theseUnits = " Mtrs"
		else
			theseUnits = " Yds"
		end
		thisDistance = tonumber(string.format("%.0f" , thisDistance)) -- we dont really need decimal places with this small of units
	end
	
	return thisDistance, theseUnits, flag
end
function BWP_getflag(distanceinUNITS)-- Really returns a color equivilent of a distance range
	local tcd =  BWP_Hide.ClearDistance
	if(BWP_Hide.ClearDistance < 0.0040) then tcd =  0.0040 end
	if (distanceinUNITS < BWP_Hide.ClearDistance) then 	return "A"
	elseif (distanceinUNITS < tcd * 2.452) then return "Green" --for Green Text
	elseif (distanceinUNITS < tcd * 242.5) then return "Y" --For Yellow text
	else return "Red" -- for red text
	end
end
function BetterWaypoints_GetDir()
	
	if(not updCount)then
	 updCount = 0
	end
	updCount = updCount + 1;
	if (updCount < 2) then
		return;
	end
	updCount = 0;
	-- Find out where we are now
	local x,y = GetPlayerMapPosition("player");

	local t = GetTime();
   -- Store data if we've moved at least min sample distance
    local dx,dy = 0.00001,0.0001
	if ((x ~= 0) or (y ~= 0)) then
		dx,dy = lastX - x, lastY - y 
	end
	if ((math.abs(dx) >= MIN_SAMPLE_DISTANCE)
		or (math.abs(dy) >= MIN_SAMPLE_DISTANCE)) then
		
		lastIdx = lastIdx + 1;
		if (lastIdx > MAX_LOC_SAMPLES) then
            lastIdx = 1;
		end
		LOC_X_SAMPLES[lastIdx] = x;

        LOC_Y_SAMPLES[lastIdx] = y;

        LOC_T_SAMPLES[lastIdx] = t;

        lastX,lastY = x,y;
		
	
	
	end
	if (lastIdx == 0) then
      return;
   end
   
   local idx = lastIdx;
   local cx,cy,ct = LOC_X_SAMPLES[idx], LOC_Y_SAMPLES[idx];
   local ct = LOC_T_SAMPLES[idx]; 
   local cutoff = t - MAX_CUMUL_TIME;
   local tx,ty,tt;
   local found = nil;
   -- Scan back through the sample list for a long enough vector
   while (true) do
      idx = idx - 1;
      if (idx == 0) then
         idx = MAX_LOC_SAMPLES;
      end
      tx, ty, tt = LOC_X_SAMPLES[idx], LOC_Y_SAMPLES[idx], LOC_T_SAMPLES[idx];      
      -- If we ran out of samples without finding a long enough
      -- vector then stop
      if (not tt) or (tt >= ct) or (tt < cutoff)  then
		break
      end
      dx = cx - tx;
      dy = cy - ty;

      -- If this vector is finally long enough, set found flag and break
      -- dx,dy, tx,ty,tt, and idx will all be useful
		
      if ((dx*dx + dy*dy) >= MIN_CUMUL_RANGE_SQ) then
         found = true;
         break;
      end
   end
   -- Not enough data
   if (not found) then
      if (lastDeg) then
         lastDeg = nil;
      end
      return
   end
   -- If we get here we have a vector, let's convert it to degrees
	local deg = math.deg(math.atan2(dx,-dy)); 
	local loc1  , loc2 = {}, {}
	loc1.x, loc1.y = BWP_Dest.x, BWP_Dest.y
	loc2.x, loc2.y = GetPlayerMapPosition("player")
	gdclx = (loc1.x - loc2.x  );
	gdcly = (loc1.y - loc2.y );
	_,_,Arrivedyet = formatdist(loc1,loc2)
	 if (Arrivedyet == "A")and(not BWPFOLLOWPLAYER) then
		return "Arrived!"
	end
	local goaldeg = math.deg(math.atan2(gdclx,-gdcly))
	
	return (goaldeg - deg)
end




function monitor_Minimap()
	if (MetaMapNotes_MiniNote_Data) and (MetaMapNotes_MiniNote_Data.xPos ~= nil) and (MetaMapNotes_MiniNote_Data.zonetext == GetRealZoneText()) then
		BWP_Dest = {
			name = MetaMapNotes_MiniNote_Data.name,
			x = MetaMapNotes_MiniNote_Data.xPos ,
			y = MetaMapNotes_MiniNote_Data.yPos ,			
			zone = GetRealZoneText()}
	elseif(MiniNotePOI and MiniNotePOI:IsVisible())then
		if((MapNotes_ZoneShift)and (MapNotes_ZoneShift[GetCurrentMapContinent()]) and (MapNotes_ZoneShift[GetCurrentMapContinent()][GetCurrentMapZone()]))and (MapNotes_MiniNote_Data) then
			local zone = MapNotes_ZoneShift[GetCurrentMapContinent()][GetCurrentMapZone()]
			if(MapNotes_MiniNote_Data.zone == zone)then
				BWP_Dest = {
					name = MapNotes_MiniNote_Data.name,
					x = MapNotes_MiniNote_Data.xPos ,
					y = MapNotes_MiniNote_Data.yPos ,			
					zone = GetRealZoneText()}
			else
				BWP_Dest = nil
			end
		end
	end
 end
		

function GetLocalPoints()
	local Waypoints = {} 
	local countit = 0
	local zone = GetRealZoneText();
	local cont = nil;
	local cData;

	if (BWP_Zones and BWP_Zones[zone] == 1) then cont = "Kalimdor";
	elseif (BWP_Zones and BWP_Zones[zone] == 2) then cont = "Eastern Kingdoms"; end
	if (BWP_Data[cont] and BWP_Data[cont][zone]) then	
		text = "\n"
		local temp = BWP_Data[cont][zone];
		local node = nil;
		for key in temp do
			node = setmetatable(temp[key], BWPmeta);
			cData = BWPDisp:new(node:getX(), node:getY(), node:getAuthor(), "", node:getNote(), "", "BWP");
			tinsert(Waypoints, cData);
			countit = countit + 1
		end
	end
	if (CT_UserMap_Notes and CT_UserMap_Notes[zone]) then
		for key in CT_UserMap_Notes[zone] do
			if (Abnormal_CT_Check:GetChecked()) or ( (CT_UserMap_Notes[zone][key]["set"] ~= 7) and (CT_UserMap_Notes[zone][key]["set"] ~= 8)) then 
				local adjx, adjy = BetterWaypoints_FormatCoords(CT_UserMap_Notes[zone][key]["x"], CT_UserMap_Notes[zone][key]["y"]);
				cData = BWPDisp:new(adjx, adjy, "", CT_UserMap_Notes[zone][key]["name"], CT_UserMap_Notes[zone][key]["descript"], "", "CT");
				tinsert(Waypoints, cData); 
			end
			countit = countit + 1
		end
	end
	if (MapNotes_Data) then
		local BWP_mnCont, BWP_mnZone = MapNotes_GetZone();
		if (MapNotes_Data[BWP_mnCont] and MapNotes_Data[BWP_mnCont][BWP_mnZone]) then
			for key in MapNotes_Data[BWP_mnCont][BWP_mnZone] do
				
				local adjx, adjy = MapNotes_Data[BWP_mnCont][BWP_mnZone][key].xPos, MapNotes_Data[BWP_mnCont][BWP_mnZone][key].yPos;
				cData = BWPDisp:new(adjx, adjy, MapNotes_Data[BWP_mnCont][BWP_mnZone][key].creator, MapNotes_Data[BWP_mnCont][BWP_mnZone][key].name, MapNotes_Data[BWP_mnCont][BWP_mnZone][key].inf1, MapNotes_Data[BWP_mnCont][BWP_mnZone][key].inf2, "MN");
				tinsert(Waypoints, cData);
				
				countit = countit + 1
			end
		end
	end
	if (MetaMapNotes_Data) then
		local BWP_mnCont, BWP_mnZone = MetaMapNotes_GetZone();
		if (MetaMapNotes_Data[BWP_mnCont] and MetaMapNotes_Data[BWP_mnCont][BWP_mnZone]) then
			for key in MetaMapNotes_Data[BWP_mnCont][BWP_mnZone] do
				
				local adjx, adjy = MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].xPos * 100, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].yPos* 100;
				cData = BWPDisp:new(adjx, adjy, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].creator, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].name, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].inf1, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].inf2, "MN");
				tinsert(Waypoints, cData);
				
				countit = countit + 1
			end
		end
	end
	
	
	return Waypoints , countit
end







function BetterWaypoints_Generate()
	BWP_CZone = {};
	BWP_CZone , localpoints = GetLocalPoints()
	
end

function BWPsortbyName(a,b) return string.lower(a.title) < string.lower(b.title) end
function BWPSortByQuestGiverName(a,b) return string.lower(a.QuestGiver) < string.lower(b.QuestGiver) end
function BetterWaypoints_GrabDestInfo(thisitem)
	if (thisitem) then
		return thisitem.title, thisitem.xcoord, thisitem.ycoord;
	else return nil, nil, nil; end
end


function BetterWaypoints_GetData()
	local x, y = BetterWaypoints_FormatCoords(GetPlayerMapPosition("player"));
	if (x == 0 and y == 0) then return "No coordinates available in region"; end

	BetterWaypoints_Generate();

	local header1 = "...by SpeedNote"
	local header2 = "...by MapNotes"
	local header3 = "...by CT_MapMod"

	local flip = "BWP";
	local wspace;
	local val;

	local text = header1.."\n";
	local name = "";
	local txt2 = "";
	local auth = "";
	local coords = "";
	local txt1 = "";
	local type = "";

	for key in BWP_CZone do
		val = setmetatable(BWP_CZone[key], BWPDispm);

		if (key >= 10) then wspace = "      "; else wspace = "     "; end

		name = val:getTitle();
		auth = val:getAuthor();
		txt2 = val:getNote2();
		coords = BWPHilightText("( "..val:getX().." , "..val:getY().." )");
		txt1 = "\""..val:getNote1().."\"";
		type = val:getType();

		if (type ~= flip) then
			if (strfind(type, "CT")) then 
				if (text == header1.."\n") then text = header3.."\n";
				else text = text.."\n"..header3.."\n"; end
			elseif (strfind(type, "MN")) then
				if (text == header1.."\n") then text = header2.."\n";
				elseif (text == header3.."\n") then text = header2.."\n";
				else text = text.."\n"..header2.."\n"; end
			else return text.."\nRecognition Error"; end
			flip = type;
		end

		text = text..key..".  ";
		if (name ~= "") then text = text..name.."\n"..wspace..coords;
		else text = text..coords; end
		if (auth ~= "") then text = text.." - Author: "..auth; end
		text = text.."\n";
		if (txt2 ~= "") then
			text = text..wspace.."Info 1: ";
			text = text..txt1.."\n";
			text = text..wspace.."Info 2: "
			text = text.."\""..txt2.."\"".."\n";
		else text = text..wspace..txt1.."\n"; end
	end
	text = strsub(text, 1, string.len(text)-1);

	if (text == "" or text == header1) then text = "No Notes"; end
	return text;
end

function Figure_It_all_Out(d)
	
	if(d) then
	
	dnum = tonumber(d)
	if(dnum)then
	if(dnum > 180 )then
	   dnum = dnum - 360
	elseif(dnum < -180) then
		dnum = dnum + 360
	end end
	if(d == "Arrived!") then
		countdown = 75
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\Arrived"
		
	elseif(dnum)and ((dnum >=-5) and ( dnum <= 5))or(dnum < -355) then 
	    ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\forward"
	elseif(dnum)and (dnum < -5) and (dnum >= -15) then
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FLeft+2"
	elseif(dnum)and (dnum < -15) and (dnum >= -35) then
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FLeft+1"
	elseif(dnum)and (dnum < -35) and (dnum >= -55) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FLeft"
	elseif(dnum)and (dnum < -55) and (dnum >= -65) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FLeft-1"
	elseif(dnum)and (dnum < -65) and (dnum >= -80) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FLeft-2"
	elseif(dnum)and (dnum < -80) and (dnum >= -100) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\left"
	elseif(dnum)and (dnum < -100) and (dnum >= -115) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BLeft-2"
	elseif(dnum)and (dnum < -115) and (dnum >= -135) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BLeft-1"
	elseif(dnum)and (dnum < -135) and (dnum >= -155) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BLeft"
	elseif(dnum)and (dnum < -155) and (dnum >= -165) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BLeft+1"
	elseif(dnum)and (dnum < -165) and (dnum >= -175) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BLeft+2"
	elseif(dnum)and ((dnum < -175) and (dnum >= -190)) or((dnum > 175) and (dnum <= 190)) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\Backward"
	elseif(dnum)and (dnum > 165) and (dnum <= 175) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BRight+2"
	elseif(dnum)and (dnum > 155) and (dnum <= 165) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BRight+1"
	elseif(dnum)and (dnum > 135) and (dnum <= 155) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BRight"
	elseif(dnum)and (dnum > 115) and (dnum <= 135) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BRight-1"
	elseif(dnum)and (dnum > 100) and (dnum <= 115) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\BRight-2"
	elseif(dnum)and (dnum > 80) and (dnum <= 100) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\right"
	elseif(dnum)and (dnum > 65) and (dnum <= 80) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FRight-2"
	elseif(dnum)and (dnum > 55) and (dnum <= 65) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FRight-1"
	elseif(dnum)and (dnum > 35) and (dnum <= 55) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FRight"
	elseif(dnum)and (dnum > 15) and (dnum <= 35) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FRight+1"
	elseif(dnum)and (dnum > 5) and (dnum <= 15) then	
		ArrowIcon = "Interface\\AddOns\\BetterWaypoints\\Artwork\\Arrows\\FRight+2"
	else
	    DEFAULT_CHAT_FRAME:AddMessage(dnum)
	end
	end
	if(BWP_Dest) then
	BetterWaypointsArrow:SetTexture(ArrowIcon)
	end

end
