
function Skinner:FramesResized_QuestLog()
	if not self.db.profile.QuestLog then return end
	
	self:SecureHook("QuestLog_OnShow", function()
		_G["QuestLogFrame"]:SetHeight(_G["QuestLogFrame"]:GetHeight() - 64)
		end)
		
	self:removeRegions(_G["QuestLogFrame_MidTextures"])

end
