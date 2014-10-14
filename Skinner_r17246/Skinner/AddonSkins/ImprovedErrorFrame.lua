
function Skinner:ImprovedErrorFrame()

    self:applySkin(_G["ImprovedErrorFrameCloseButton"]) 
    self:applySkin(_G["ImprovedErrorFrameFrame"]) 

    self:removeRegions(_G["ScriptErrorsScrollFrameOne"])
    self:skinScrollBar(_G["ScriptErrorsScrollFrameOne"])

end
