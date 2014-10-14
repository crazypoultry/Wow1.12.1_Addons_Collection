
function Skinner:FramesResized_LootFrame()
	if not self.db.profile.LootFrame then return end
	
	for i = 5, NUM_GROUP_LOOT_FRAMES do
		_G["LootButton"..i]:ClearAllPoints()
		_G["LootButton"..i]:SetPoint("TOP", _G["LootButton"..i - 1], "BOTTOM", 0, -4)
   	end

end
