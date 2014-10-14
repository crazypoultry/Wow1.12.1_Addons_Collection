--===================================================================================================================--
-- cMinimapCoordinates, version 3                                                                         2005-06-01 --
-- Description: Lets you see your coordinates on the minimap                                                         -- 
-- Developer: Christoffer Petterson, aka Corgrath, corgrath@corgrath.com                                             --
--===================================================================================================================--



cMinimapCoordinatesSettings = { showOnMiniMap = true, showOnWorldMap = false };



--===================================================================================================================--
function cMinimapCoordinates_OnLoad()


	SlashCmdList[ "CMINIMAPCOORDINATES" ] = cMinimapCoordinates_OnSlash;
	SLASH_CMINIMAPCOORDINATES1 = "/cmc";

	ChatFrame1:AddMessage( "cMinimapCoordinates loaded. Type /cmc for more information." ); 

end
--===================================================================================================================--



--===================================================================================================================--
function cMinimapCoordinates_OnUpdate()

	-- if its disabled
	if( cMinimapCoordinatesSettings.showOnMiniMap == false )
	then 
		return;
	end

	local px, py = GetPlayerMapPosition( "player" );
	MinimapZoneText:SetText( format("(%d:%d) ",px*100.0,py*100.0) .. 
		GetMinimapZoneText() );

end

function cMinimapCoordinates_OnSlash( arguments )

	if( arguments == "minimap" )
	then

		if( cMinimapCoordinatesSettings.showOnMiniMap == true )
		then
			cMinimapCoordinatesSettings.showOnMiniMap = false;
			ChatFrame1:AddMessage( "cMinimapCoordinates: Minimap coordinates are now disabled." ); 
		else
			cMinimapCoordinatesSettings.showOnMiniMap = true;
			ChatFrame1:AddMessage( "cMinimapCoordinates: Minimap coordinates are now enabled." ); 
		end

	elseif( arguments == "worldmap" )
	then

		if( cMinimapCoordinatesSettings.showOnWorldMap == true )
		then
			cMinimapCoordinatesSettings.showOnWorldMap = false;
			ChatFrame1:AddMessage( "cMinimapCoordinates: Worldmap coordinates are now disabled." ); 
		else
			cMinimapCoordinatesSettings.showOnWorldMap = true;
			ChatFrame1:AddMessage( "cMinimapCoordinates: Worldmap coordinates are now enabled." ); 
		end

	else

		ChatFrame1:AddMessage( "Usage: /cmc minimap - Toggle minimap coordinates." );
		ChatFrame1:AddMessage( "Usage: /cmc worldmap - Toggle worldmap coordinates." );

	end

end
--===================================================================================================================--


                                                                              -- Engineground from MapCoords by ReCover
--===================================================================================================================--

function cMinimapCoordinatesWorldMapFrame_OnUpdate()

	-- if its disabled
	if( cMinimapCoordinatesSettings.showOnWorldMap == false )
	then 
		cMinimapCoordinatesWorldMapText:Hide();
		return; 
	else
		cMinimapCoordinatesWorldMapText:Show();
	end

	-- Tweak coords so they are accurate
	local OFFSET_X = 0.0022;
	local OFFSET_Y = -0.0262;
	
	-- Get the cursor's coordinates
	local x, y = GetCursorPosition();
	local px, py = GetPlayerMapPosition( "player" );

	-- Map calculations
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

	-- Print the information out
	cMinimapCoordinatesWorldMapText:SetText( format("Player: %d.%d",px*100.0
		,py*100.0) .."     ".. format("Cursor: %d.%d",x,y) );

end
--===================================================================================================================--
