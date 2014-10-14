--[[
		General.lua
			scripts for the "General" panel of the Bongos Options Menu
--]]

function BOptionsGeneral_OnShow()
	this.onShow = 1
	
	local name = this:GetName()
	
	getglobal(name .. "Lock"):SetChecked(BongosSets.locked)
	getglobal(name .. "StickyBars"):SetChecked(BongosSets.sticky)
	getglobal(name .. "Reuse"):SetChecked(not BongosSets.dontReuse)
	getglobal(name .. "Alpha"):SetValue(100)
	getglobal(name .. "Scale"):SetValue(100)
	
	this.onShow = nil
end