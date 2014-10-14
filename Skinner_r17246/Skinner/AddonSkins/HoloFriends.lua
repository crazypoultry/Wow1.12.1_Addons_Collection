
function Skinner:HoloFriends()

    self:hookDDScript(HoloFriendsDropDownButton)
    self:hookDDScript(HoloIgnoreDropDownButton)
    
    self:removeRegions(_G["HoloFriendsFrameToggleTab1"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloFriendsFrameToggleTab2"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloFriendsFrameToggleTab3"], {1,2,3,4,5,6})
    
    self:removeRegions(_G["HoloIgnoreFrameToggleTab1"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloIgnoreFrameToggleTab2"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloIgnoreFrameToggleTab3"], {1,2,3,4,5,6})
    
    self:moveObject(_G["HoloFriendsFrameToggleTab1"], "-", 5, nil, nil)
    self:moveObject(_G["HoloFriendsFrameToggleTab2"], "-", 5, nil, nil)
    self:moveObject(_G["HoloFriendsFrameToggleTab3"], "-", 5, nil, nil)
    
    self:moveObject(_G["HoloIgnoreFrameToggleTab1"], "-", 5, nil, nil)
    self:moveObject(_G["HoloIgnoreFrameToggleTab2"], "-", 5, nil, nil)
    self:moveObject(_G["HoloIgnoreFrameToggleTab3"], "-", 5, nil, nil)
    
    self:applySkin(_G["HoloFriendsFrameToggleTab1"])
    self:applySkin(_G["HoloFriendsFrameToggleTab2"])
    self:applySkin(_G["HoloFriendsFrameToggleTab3"])
    
    self:applySkin(_G["HoloIgnoreFrameToggleTab1"])
    self:applySkin(_G["HoloIgnoreFrameToggleTab2"])
    self:applySkin(_G["HoloIgnoreFrameToggleTab3"])
    
    self:removeRegions(_G["HoloFriendsScrollFrame"])
    self:moveObject(_G["HoloFriendsScrollFrame"], "+", 35, "+", 10)
    self:skinScrollBar(_G["HoloFriendsScrollFrame"])
    
    self:removeRegions(_G["HoloIgnoreScrollFrame"])
    self:moveObject(_G["HoloIgnoreScrollFrame"], "+", 35, "+", 10)
    self:skinScrollBar(_G["HoloIgnoreScrollFrame"])
    
    self:moveObject(_G["HoloFriendsAddFriendButton"], nil, nil, "-", 70)
    self:moveObject(_G["HoloFriendsSendMessageButton"], "-", 20, nil, nil)
    
    self:moveObject(_G["HoloIgnoreAddIgnoreButton"], nil, nil, "-", 70)
    self:moveObject(_G["HoloIgnoreAddGroupButton"], "-", 20, nil, nil)
    
    self:moveObject(_G["HoloFriendsOnline"], "+", 147, "+", 230)
    
    self:removeRegions(_G["HoloFriendsFrame"], {3,4,5,6})
    self:applySkin(_G["HoloFriendsFrame"], {3,4,5,6})
    
    self:removeRegions(_G["HoloIgnoreFrame"], {3,4,5,6})
    self:applySkin(_G["HoloIgnoreFrame"], {3,4,5,6})

end
