-- **************************
-- Coded By ReCover
-- ***
-- Changelog:
-- 0.32
-- - TOC UPdate (by Urmelus) for 1.12
-- - Add German  tootip in Addon overview
-- 0.31:
-- - TOC Update (by urmelus) for 1.11
-- 0.3:
-- - Slash commands (/mapcoords or /mc)
-- - Saving settings variable (MapCoords)
-- - Coords below your portraite and your party members portraite (Not able to get it if member is in another zone, workaround anyone?)
-- - Able to toggle all labels (using slash commands)
-- - Added function round to round the numbers instead of stripping them from their decimals
-- - Updated toc to patch 1.3.1
-- 0.2:
-- - Kickass fix made by Astus so cursor coords is accurate out-of-the-box =)
-- 0.1:
-- - Made the AddOn
-- **************************

local OFFSET_X = 0.0022;
local OFFSET_Y = -0.0262;

-- Master echo colors
local R_ON = 0;
local G_ON = 1;
local B_ON = 0;
local R_OFF = 1;
local G_OFF = 0;
local B_OFF = 0;
local R_ABOUT = 1;
local G_ABOUT = 1;
local B_ABOUT = 0;

function round(float)
  return floor(float+0.5);
end

function MapCoords_OnLoad()
        SlashCmdList["MAPCOORDS"] = MapCoords_SlashCommand;
	SLASH_MAPCOORDS1 = "/mapcoords";
	SLASH_MAPCOORDS2 = "/mc";

	if (not MapCoords) then  --First start settings and first start notification
		MapCoords = {};
		MapCoords["worldmap cursor"]=true;
		MapCoords["worldmap player"]=true;
		MapCoords["player"]=true;
		MapCoords["party1"]=true;
		MapCoords["party2"]=true;
		MapCoords["party3"]=true;
		MapCoords["party4"]=true;
	end
end

function MapCoords_Echo(msg,r,g,b)
	if (not r) then r = 1; end
	if (not g) then g = 1; end
	if (not b) then b = 1; end
	
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

function MapCoords_SlashCommand(msg)
	msg = string.lower(msg);
	-- WorldMap
	if (msg == "worldmap" or msg =="w") then
		if (MapCoords["worldmap cursor"] == true and MapCoords["worldmap player"] == true) then
			MapCoords["worldmap cursor"]=false;
			MapCoords["worldmap player"]=false;
			MapCoords_Echo("MapCoords > Now hiding all coords on worldmap");
		else
			MapCoords["worldmap cursor"]=true;
			MapCoords["worldmap player"]=true;
			MapCoords_Echo("MapCoords > Now showing all coords on worldmap");
		end
	elseif (msg == "worldmap cursor" or msg == "w c" or msg == "wc") then
		if (MapCoords["worldmap cursor"] == true) then
			MapCoords["worldmap cursor"]=false;
			MapCoords_Echo("MapCoords > Now hiding cursor coords on worldmap");
		else
			MapCoords["worldmap cursor"]=true;
			MapCoords_Echo("MapCoords > Now showing cursor coords on worldmap");
		end
	elseif (msg == "worldmap player" or msg == "w p" or msg == "wp") then
		if (MapCoords["worldmap player"] == true) then
			MapCoords["worldmap player"]=false;
			MapCoords_Echo("MapCoords > Now hiding player coords on worldmap");
		else
			MapCoords["worldmap player"]=true;
			MapCoords_Echo("MapCoords > Now showing player coords on worldmap");
		end
	-- Portrait
	elseif (msg == "portrait" or msg == "p") then
		if (MapCoords["portrait player"] == true and MapCoords["portrait party1"] == true and MapCoords["portrait party2"] == true and MapCoords["portrait party3"] == true and MapCoords["portrait party4"] == true) then
			MapCoords["portrait player"]=false;
			MapCoords["portrait party1"]=false;
			MapCoords["portrait party2"]=false;
			MapCoords["portrait party3"]=false;
			MapCoords["portrait party4"]=false;
			MapCoords_Echo("MapCoords > Now hiding all portrait coords");
		else
			MapCoords["portrait player"]=true;
			MapCoords["portrait party1"]=true;
			MapCoords["portrait party2"]=true;
			MapCoords["portrait party3"]=true;
			MapCoords["portrait party4"]=true;
			MapCoords_Echo("MapCoords > Now showing all portrait coords");
		end
	elseif (msg == "player") then
		if (MapCoords["portrait player"] == true) then
			MapCoords["portrait player"]=false;
			MapCoords_Echo("MapCoords > Now hiding player portrait coords");
		else
			MapCoords["portrait player"]=true;
			MapCoords_Echo("MapCoords > Now showing player portrait coords");
		end
	elseif (msg == "party") then
		if (MapCoords["portrait party1"] == true and MapCoords["portrait party2"] == true and MapCoords["portrait party3"] == true and MapCoords["portrait party4"] == true) then
			MapCoords["portrait party1"]=false;
			MapCoords["portrait party2"]=false;
			MapCoords["portrait party3"]=false;
			MapCoords["portrait party4"]=false;
			MapCoords_Echo("MapCoords > Now hiding all party members portrait coords");
		else
			MapCoords["portrait party1"]=true;
			MapCoords["portrait party2"]=true;
			MapCoords["portrait party3"]=true;
			MapCoords["portrait party4"]=true;
			MapCoords_Echo("MapCoords > Now showing all party members portrait coords");
		end
	elseif (msg == "party 1" or msg == "party1" or msg == "p 1" or msg == "p1") then
		if (MapCoords["portrait party1"] == true) then
			MapCoords["portrait party1"]=false;
			MapCoords_Echo("MapCoords > Now hiding your first party member portrait coords");
		else
			MapCoords["portrait party1"]=true;
			MapCoords_Echo("MapCoords > Now showing your first party member portrait coords");
		end
	elseif (msg == "party 2" or msg == "party2" or msg == "p 2" or msg == "p2") then
		if (MapCoords["portrait party2"] == true) then
			MapCoords["portrait party2"]=false;
			MapCoords_Echo("MapCoords > Now hiding your second party member portrait coords");
		else
			MapCoords["portrait party2"]=true;
			MapCoords["portrait"]=true;
			MapCoords_Echo("MapCoords > Now showing your second party member portrait coords");
		end
	elseif (msg == "party 3" or msg == "party3" or msg == "p 3" or msg == "p3") then
		if (MapCoords["portrait party3"] == true) then
			MapCoords["portrait party3"]=false;
			MapCoords_Echo("MapCoords > Now hiding your third party member portrait coords");
		else
			MapCoords["portrait party3"]=true;
			MapCoords["portrait"]=true;
			MapCoords_Echo("MapCoords > Now showing your third party member portrait coords");
		end
	elseif (msg == "party 4" or msg == "party4" or msg == "p 4" or msg == "p4") then
		if (MapCoords["portrait party4"] == true) then
			MapCoords["portrait party4"]=false;
			MapCoords_Echo("MapCoords > Now hiding your fourth party member portrait coords");
		else
			MapCoords["portrait party4"]=true;
			MapCoords["portrait"]=true;
			MapCoords_Echo("MapCoords > Now showing your fourth party member portrait coords");
		end
	elseif (msg == "about" or msg == "a") then
		MapCoords_Echo("MapCoords 0.32",R_ABOUT,G_ABOUT,B_ABOUT);
		MapCoords_Echo("Coded by ReCover- TOC update by Urmelus",R_ABOUT,G_ABOUT,B_ABOUT);
		MapCoords_Echo("recover89@gmail.com",R_ABOUT,G_ABOUT,B_ABOUT);
	else
	    MapCoords_Echo("MapCoords 0.32");
	    MapCoords_Echo("Slash Commands:");
	    MapCoords_Echo("/mapcoords or /mc");
	    MapCoords_Echo("-- Worldmap Coords --");
	    if (MapCoords["worldmap cursor"] == true and MapCoords["worldmap player"] == true) then MapCoords_Echo("/mc [worldmap|w] -ON- Toggles display of coords on the worldmap",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [worldmap|w] -OFF- Toggles display of coords on the worldmap",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["worldmap cursor"] == true) then MapCoords_Echo("/mc [worldmap cursor|wc|w c] -ON- Toggles display of cursor coords on the worldmap",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [worldmap cursor|wc|w c] -OFF- Toggles display of cursor coords on the worldmap",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["worldmap player"] == true) then MapCoords_Echo("/mc [worldmap player|wp|w p] -ON- Toggles display of player coords on the worldmap",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [worldmap player|wp|w p] -OFF- Toggles display of player coords on the worldmap",R_OFF,G_OFF,B_OFF); end
	    MapCoords_Echo("-- Portrait Coords --");
	    if (MapCoords["portrait player"] == true and MapCoords["portrait party1"] == true and MapCoords["portrait party2"] == true and MapCoords["portrait party3"] == true and MapCoords["portrait party4"] == true) then MapCoords_Echo("/mc [portrait|p] -ON- Toggles display of all portrait coords",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [portrait|p] -OFF- Toggles display of all portrait coords",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["portrait player"] == true) then MapCoords_Echo("/mc [player] -ON- Toggles display of your portrait coords",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [player] -OFF- Toggles display of your portrait coords",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["portrait party1"] == true and MapCoords["portrait party2"] == true and MapCoords["portrait party3"] == true and MapCoords["portrait party4"] == true) then MapCoords_Echo("/mc [party] -ON- Toggles display of your all your party members portrait coords",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [party] -OFF- Toggles display of your all your party members portrait coords",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["portrait party1"] == true) then MapCoords_Echo("/mc [party1|party 1|p 1|p1] -ON- Toggles display of your first party member portrait coords",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [party1|party 1|p 1|p1] -OFF- Toggles display of your first party member portrait coords",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["portrait party2"] == true) then MapCoords_Echo("/mc [party2|party 2|p 2|p2] -ON- Toggles display of your second party member portrait coords",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [party2|party 2|p 2|p2] -OFF- Toggles display of your second party member portrait coords",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["portrait party3"] == true) then MapCoords_Echo("/mc [party3|party 3|p 3|p3] -ON- Toggles display of your third party member portrait coords",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [party3|party 3|p 3|p3] -OFF- Toggles display of your third party member portrait coords",R_OFF,G_OFF,B_OFF); end
	    if (MapCoords["portrait party4"] == true) then MapCoords_Echo("/mc [party4|party 4|p 4|p4] -ON- Toggles display of your fourth party member portrait coords",R_ON,G_ON,B_ON);
	    else MapCoords_Echo("/mc [party4|party 4|p 4|p4] -OFF- Toggles display of your fourth party member portrait coords",R_OFF,G_OFF,B_OFF); end
	    MapCoords_Echo("/mc [about|a] -- Shows some about info",R_ABOUT,G_ABOUT,B_ABOUT);
	end
end

function MapCoordsPlayer_OnUpdate()
	if (MapCoords["portrait player"] == true) then
		local posX, posY = GetPlayerMapPosition("player");
		if ( posX == 0 and posY == 0 ) then
			MapCoordsPlayerPortraitCoords:SetText("n/a");
		else
			MapCoordsPlayerPortraitCoords:SetText(round(posX * 100)..","..round(posY * 100));
		end
	else
		MapCoordsPlayerPortraitCoords:SetText("");
	end
	if (MapCoords["portrait party1"] == true and GetNumPartyMembers() >= 1) then
		local posX, posY = GetPlayerMapPosition("party1");
		if ( posX == 0 and posY == 0 ) then
			MapCoordsParty1PortraitCoords:SetText("n/a");
		else
			MapCoordsParty1PortraitCoords:SetText(round(posX * 100)..","..round(posY * 100));
		end
	else
		MapCoordsParty1PortraitCoords:SetText("");
	end
	if (MapCoords["portrait party2"] == true and GetNumPartyMembers() >= 2) then
		local posX, posY = GetPlayerMapPosition("party2");
		if ( posX == 0 and posY == 0 ) then
			MapCoordsParty2PortraitCoords:SetText("n/a");
		else
			MapCoordsParty2PortraitCoords:SetText(round(posX * 100)..","..round(posY * 100));
		end
	else
		MapCoordsParty2PortraitCoords:SetText("");
	end
	if (MapCoords["portrait party3"] == true and GetNumPartyMembers() >= 3) then
		local posX, posY = GetPlayerMapPosition("party3");
		if ( posX == 0 and posY == 0 ) then
			MapCoordsParty3PortraitCoords:SetText("n/a");
		else
			MapCoordsParty3PortraitCoords:SetText(round(posX * 100)..","..round(posY * 100));
		end
	else
		MapCoordsParty3PortraitCoords:SetText("");
	end
	if (MapCoords["portrait party4"] == true and GetNumPartyMembers() >= 4) then
		local posX, posY = GetPlayerMapPosition("party4");
		if ( posX == 0 and posY == 0 ) then
			MapCoordsParty4PortraitCoords:SetText("n/a");
		else
			MapCoordsParty4PortraitCoords:SetText(round(posX * 100)..","..round(posY * 100));
		end
	else
		MapCoordsParty4PortraitCoords:SetText("");
	end
end

function MapCoordsWorldMap_OnUpdate()
	local output = "";
	if (MapCoords["worldmap cursor"] == true) then
		local x, y = GetCursorPosition();
		-- Tweak coords so they are accurate
		local scale = WorldMapFrame:GetScale();
		x = x / scale;
		y = y / scale;
		local width = WorldMapButton:GetWidth();
		local height = WorldMapButton:GetHeight();
		local centerX, centerY = WorldMapFrame:GetCenter();
		local adjustedX = (x - (centerX - (width/2))) / width;
		local adjustedY = (centerY + (height/2) - y) / height;
		x = (adjustedX + OFFSET_X) * 100;
		y = (adjustedY + OFFSET_Y) * 100;
		-- Write output
		output = "Cursor Coords: "..format("%d,%d",x,y);
	end
	if (MapCoords["worldmap cursor"] == true and MapCoords["worldmap player"]) then output = output.." -- "; end
	if (MapCoords["worldmap player"] == true) then
		local px, py = GetPlayerMapPosition("player");
		output = output.."Player Coords: "..round(px * 100)..","..round(py * 100);
	end
	MapCoordsWorldMap:SetText(output);
end
