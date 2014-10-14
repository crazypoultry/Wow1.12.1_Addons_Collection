idMinimap = {}

function idMinimap:Enable()
    self.frame = CreateFrame('Frame', nil, Minimap)
    self.frame:EnableMouse(false)
    self.frame:SetPoint('TOPLEFT', Minimap, 'TOPLEFT')
    self.frame:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMRIGHT')
    self.frame:EnableMouseWheel(true)

    self.frame.loc = self.frame:CreateFontString(nil, 'OVERLAY')
    self.frame.loc:SetWidth(60)
    self.frame.loc:SetHeight(16)
    self.frame.loc:SetPoint('BOTTOM', self.frame, 'BOTTOM', 0, -7)
    self.frame.loc:SetJustifyH('CENTER')
    self.frame.loc:SetFontObject(GameFontNormal)

    self.frame:SetScript('OnMouseWheel', function() self:Zoom() end)
    self.frame:SetScript('OnUpdate', function() self:updateLocText() end)
    MinimapZoomIn:Hide()
    MinimapZoomOut:Hide()
    GameTimeFrame:Hide()
    MinimapToggleButton:Hide()
    MinimapZoneTextButton:Hide()
    MinimapBorderTop:Hide()
end

function idMinimap:Disable()
    self.frame:SetScript('OnMouseWheel', nil)
    self.frame:SetScript('OnUpdate', nil)
    MinimapZoomIn:Show()
    MinimapZoomOut:Show()
    GameTimeFrame:Show()
    MinimapToggleButton:Show()
    MinimapZoneTextButton:Show()
    MinimapBorderTop:Show()
end

function idMinimap:Zoom()
    if not arg1 then return end
    if arg1 > 0 and Minimap:GetZoom() < 5 then
        Minimap:SetZoom(Minimap:GetZoom() + 1)
    elseif arg1 < 0 and Minimap:GetZoom() > 0 then
        Minimap:SetZoom(Minimap:GetZoom() - 1)
    end
end

function idMinimap:updateLocText()
    x,y=GetPlayerMapPosition('player')
    self.frame.loc:SetText(string.format('%s,%s', floor(x*100) or '', floor(y*100) or ''))
end

idMinimap:Enable()
