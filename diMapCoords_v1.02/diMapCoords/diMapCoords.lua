local diWorldMapFrame
local diMiniMapFrame

function diMapCoordsEvent ()
	if (event == 'ZONE_CHANGED_NEW_AREA') then
		SetMapToCurrentZone()
	elseif (event == 'VARIABLES_LOADED') then
		DEFAULT_CHAT_FRAME:AddMessage('diMapCoords addon loaded.', 0, 255, 0);
	end
end

function diMapCoordsEnable()
	diMiniMapFrame = CreateFrame('Frame', nil, Minimap)

    diMiniMapFrame:EnableMouse(false)
    diMiniMapFrame:SetPoint('TOPLEFT', Minimap, 'TOPLEFT')
    diMiniMapFrame:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMRIGHT')
    diMiniMapFrame:EnableMouseWheel(true)

    diMiniMapFrame.loc = diMiniMapFrame:CreateFontString(nil, 'OVERLAY')
    diMiniMapFrame.loc:SetWidth(60)
    diMiniMapFrame.loc:SetHeight(16)
    diMiniMapFrame.loc:SetPoint('BOTTOM', diMiniMapFrame, 'BOTTOM', 0, -7)
    diMiniMapFrame.loc:SetJustifyH('CENTER')
    diMiniMapFrame.loc:SetFontObject(GameFontNormal)
    diMiniMapFrame:SetScript('OnMouseWheel', diMapCoordsZoom)
    diMiniMapFrame:SetScript('OnUpdate', diMapCoordsUpdateMiniMap)
	diMiniMapFrame:SetScript('OnEvent',diMapCoordsEvent);
	diMiniMapFrame:RegisterEvent('ZONE_CHANGED_NEW_AREA')
	diMiniMapFrame:RegisterEvent('VARIABLES_LOADED')

	diWorldMapFrame = CreateFrame('Frame',nil, WorldMapFrame)
    diWorldMapFrame.loc = diWorldMapFrame:CreateFontString(nil, 'OVERLAY')
    diWorldMapFrame.loc:SetPoint('BOTTOM', WorldMapFrame, 'BOTTOM', 0, 10)
    diWorldMapFrame.loc:SetJustifyH('CENTER')
    diWorldMapFrame.loc:SetFontObject(GameFontNormal)
    diWorldMapFrame:SetScript('OnUpdate', diMapCoordsUpdateWorldMap)

    MinimapZoomIn:Hide()
    MinimapZoomOut:Hide()
    GameTimeFrame:Hide()
    MinimapToggleButton:Hide()
    MinimapZoneTextButton:Hide()
    MinimapBorderTop:Hide()
	
	SetMapToCurrentZone()
end

function diMapCoordsZoom()
    if not arg1 then return end
    if arg1 > 0 and Minimap:GetZoom() < 5 then
        Minimap:SetZoom(Minimap:GetZoom() + 1)
    elseif arg1 < 0 and Minimap:GetZoom() > 0 then
        Minimap:SetZoom(Minimap:GetZoom() - 1)
    end
end

function diMapCoordsUpdateMiniMap()
    x,y=GetPlayerMapPosition('player')
    diMiniMapFrame.loc:SetText(string.format('%s,%s', floor(x*100) or '', floor(y*100) or ''))
end


function diMapCoordsUpdateWorldMap()
	local output = ''
	local OFFSET_X = 0.0022
	local OFFSET_Y = -0.0262


	local x, y = GetCursorPosition()
	-- Tweak coords so they are accurate
	local scale = WorldMapFrame:GetScale()
	x = x / scale
	y = y / scale
	local width = WorldMapButton:GetWidth()
	local height = WorldMapButton:GetHeight()
	local centerX, centerY = WorldMapFrame:GetCenter()
	local adjustedX = (x - (centerX - (width/2))) / width
	local adjustedY = (centerY + (height/2) - y) / height
	x = (adjustedX + OFFSET_X) * 100
	y = (adjustedY + OFFSET_Y) * 100
	-- Write output
	output = DIMAPCOORDS_CURSORCOORDS..format('%d,%d',x,y)

	local px, py = GetPlayerMapPosition('player')
	output = output..DIMAPCOORDS_PLAYERCOORDS..floor(px * 100)..','..floor(py * 100)

	diWorldMapFrame.loc:SetText(output)
end

diMapCoordsEnable()