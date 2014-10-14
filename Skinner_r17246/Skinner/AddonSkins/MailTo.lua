
function Skinner:MailTo()

    self:removeRegions(_G["MailTo_InFrame"], {2, 3, 4, 5})
    self:applySkin(_G["MailTo_InFrame"])

end
