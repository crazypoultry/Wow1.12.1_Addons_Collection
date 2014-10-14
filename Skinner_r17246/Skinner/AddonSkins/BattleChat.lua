
function Skinner:BattleChat() 

	self:applySkin(_G["BattleChat"].frame)
	_G["BattleChat"].frame:SetBackdropColor(0, 0, 0, BattleChat.db.profile.alpha * 0.01)
	_G["BattleChat"].frame:SetBackdropBorderColor(0, 0, 0, BattleChat.db.profile.alpha * 0.01 * 4/3)

end
