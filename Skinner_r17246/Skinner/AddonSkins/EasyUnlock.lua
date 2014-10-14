
function Skinner:EasyUnlock()

	self:Hook("EasyUnlock_DoFrameCheck", function()
        local been_here_before = EasyUnlock:IsShown()
		self.hooks.EasyUnlock_DoFrameCheck()
		if not been_here_before and _G["TradeFrameTradeButton"]:GetWidth() == 56 then
			self:moveObject(_G["TradeFrameTradeButton"], "+", 20, "-", 40) 
		end
		end)
		
end
