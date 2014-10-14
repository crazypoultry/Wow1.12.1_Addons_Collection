--[[

MapZoom.lua
MiniMap Zoom
Revision 1.02

]]

BINDING_HEADER_MAPZOOM	= 'MapZoom';
ZOOMMAPPING_TIMER 		= 5;
ZOOMMAPPING_FADE_TIMER 	= 0.5;
CURSOR_OFFSET_X 		= -7;
CURSOR_OFFSET_Y 		= -9;

------------------------------------------
-- 2.0 Information for myAddons 2 support
------------------------------------------
MAPZOOM_TITLE		= "MapZoom";
MAPZOOM_VERSION		= "1.03"
MAPZOOM_RELEASEDATE	= "June 20, 2006";
MAPZOOM_AUTHOR		= "PADevs";
MAPZOOM_EMAIL		= "wow-pa-devs@lists.sourceforge.net"
MAPZOOM_WEBSITE		= "http://ui.worldofwar.net/ui.php?id=91";

MAPZOOM_HELP_TOGGLE	= "  Manually toggle without using the hotkey";

MapZoomDetails	= {	
			name		= MAPZOOM_TITLE,
			version		= MAPZOOM_VERSION,
			releaseDate	= MAPZOOM_RELEASEDATE,
			author		= MAPZOOM_AUTHOR,
			email		= MAPZOOM_EMAIL,
			website		= MAPZOOM_WEBSITE,
			category	= MYADDONS_CATEGORY_MAP,
		};

MapZoomHelp	= {};
MapZoomHelp[1]	= "MapZoom Help\n\nMapZoom can use key bindings to operate, or accepts a command line toggle for static operation. To use either method, open the Key Bindings from the main menu (using the ESC key), then select key Bindings. Assign a key to the MapZoom functions you want to use, and then use either of these keys to Zoom the MiniMap. Release the hotkey to restore the MiniMap size, or toggle again.";


function MapZoom_OnLoad()

	MapZoomPing.fadeOut = nil;
	this:SetSequence(0);
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("MINIMAP_PING");
	this:RegisterEvent("MINIMAP_UPDATE_ZOOM");
	MapZoomCluster:Hide();	
	SlashCmdList["MAPZOOM"] = MapZoom_SlashHandler;
	SLASH_MAPZOOM1 = "/mapzoom";
	SLASH_MAPZOOM2 = "/mz";

end

-----------------------------
-- General Chat local Message
-----------------------------
function MapZoomMessage(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 0.5);
	end
end

function ToggleMapZoom(show)
	if(MapZoomCluster:IsVisible() or show == 0) then
		PlaySound("igMiniMapClose");
		MapZoomCluster:Hide();
		Minimap:Show();
		
		if(Minimap:GetZoom() == 0) then
			Minimap:SetZoom(Minimap:GetZoom()+1);	
			Minimap:SetZoom(Minimap:GetZoom()-1);
		else
			Minimap:SetZoom(Minimap:GetZoom()-1);	
			Minimap:SetZoom(Minimap:GetZoom()+1);
		end
		
	else
		PlaySound("igMiniMapOpen");
		Minimap:Hide();
		MapZoomCluster:Show();
	
		if(MapZoom:GetZoom() == 0) then
			MapZoom:SetZoom(MapZoom:GetZoom()+1);	
			MapZoom:SetZoom(MapZoom:GetZoom()-1);
		else
			MapZoom:SetZoom(MapZoom:GetZoom()-1);	
			MapZoom:SetZoom(MapZoom:GetZoom()+1);
		end						
	end
end

function MapZoom_Update()
end


------------------
-- Event Processor
------------------
function MapZoom_OnEvent()

	if ( event == "VARIABLES_LOADED" ) then
		-----------------------------
		-- Support for myAddOns 2
		-------=---------------------
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(MapZoomDetails,MapZoomHelp);
		end

		MapZoomMessage("MapZoom v"..MAPZOOM_VERSION.." Use /mapzoom or /mz.");

	elseif ( event == "MINIMAP_PING" ) then
		MapZoom_SetPing(arg2, arg3, 1);
		MapZoom.timer = MINIMAPPING_TIMER;

	elseif ( event == "MINIMAP_UPDATE_ZOOM" ) then
		MapZoomZoomIn:Enable();
		MapZoomZoomOut:Enable();
		local zoom = MapZoom:GetZoom();
		if ( zoom == (MapZoom:GetZoomLevels() - 1) ) then
			MapZoomZoomIn:Disable();
		elseif ( zoom == 0 ) then
			MapZoomZoomOut:Disable();
		end
	end
end

-------------------------
-- Handle CLI for MapZoom
-------------------------
function MapZoom_SlashHandler(msg)
	if (msg == "") then
		MapZoomMessage("MapZoom v"..MAPZOOM_VERSION);
		MapZoomMessage("use /mapzoom or /mz for commands.");
		MapZoomMessage("/mz toggle		"..MAPZOOM_HELP_TOGGLE);

	elseif (msg == "toggle") then
		if(MapZoomCluster:IsVisible()) then
			ToggleMapZoom(0);
		else
			ToggleMapZoom(1);	
		end
	else
		MapZoomMessage("Unknown MapZoom Command: "..msg);
	end	
end

-------------------------
-- Timer Update Processor
-------------------------
function MapZoom_OnUpdate(elapsed)

	if ( MapZoom.timer > 0 ) then
		MapZoom.timer = MapZoom.timer - elapsed;
		if ( MapZoom.timer <= 0 ) then
			MapZoomPing_FadeOut();
		else
			MapZoom_SetPing(MapZoom:GetPingPosition());
		end
	elseif ( MapZoomPing.fadeOut ) then
		MapZoomPing.fadeOutTimer = MapZoomPing.fadeOutTimer - elapsed;
		if ( MapZoomPing.fadeOutTimer > 0 ) then
			MapZoomPing:SetAlpha(255 * (MapZoomPing.fadeOutTimer/ZOOMMAPPING_FADE_TIMER))
		else
			MapZoomPing.fadeOut = nil;
			MapZoomPing:Hide();
		end
	end
 end

function MapZoom_SetPing(x, y, playSound)
	x = x * MapZoom:GetWidth();
	y = y * MapZoom:GetHeight();
	
	if ( sqrt(x * x + y * y) < (MapZoom:GetWidth() / 2) ) then
		MapZoomPing:SetPoint("CENTER", "MapZoom", "CENTER", x, y);
		MapZoomPing:SetAlpha(255);
		MapZoomPing:Show();
		if ( playSound ) then
			PlaySound("MapPing");
		end
	else
		MapZoomPing:Hide();
	end
	
end

function MapZoomPing_FadeOut()
	MapZoomPing.fadeOut = 1;
	MapZoomPing.fadeOutTimer = ZOOMMAPPING_FADE_TIMER;
end

function MapZoom_ZoomInClick()
	MapZoomZoomOut:Enable();
	PlaySound("igMiniMapZoomIn");
	MapZoom:SetZoom(MapZoom:GetZoom() + 1);
	if(MapZoom:GetZoom() == (MapZoom:GetZoomLevels() - 1)) then
		MapZoomZoomIn:Disable();
	end
end

function MapZoom_ZoomOutClick()
	MapZoomZoomIn:Enable();
	PlaySound("igMiniMapZoomOut");
	MapZoom:SetZoom(MapZoom:GetZoom() - 1);
	if(MapZoom:GetZoom() == 0) then
		MapZoomZoomOut:Disable();
	end
end

function MapZoom_OnClick()
	local x, y = GetCursorPosition();
	x = x / this:GetScale();
	y = y / this:GetScale();

	local cx, cy = this:GetCenter();
	x = x + CURSOR_OFFSET_X - cx;
	y = y + CURSOR_OFFSET_Y - cy;
	if ( sqrt(x * x + y * y) < (this:GetWidth() / 2) ) then
		MapZoom:PingLocation(x, y);
	end
end

function MapZoom_ZoomIn()
	MapZoomZoomIn:Click();
end

function MapZoom_ZoomOut()
	MapZoomZoomOut:Click();
end