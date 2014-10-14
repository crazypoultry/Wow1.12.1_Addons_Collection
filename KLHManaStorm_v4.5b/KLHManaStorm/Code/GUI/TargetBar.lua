
-- module setup
local me = { name = "targetbar"}
local mod = thismod
mod[me.name] = me

me.onload = function()

	me.constructor()
	
	me.resize(160, 30)
	
	me.frame:Hide()
end

me.constructor = function()

	me.xinset = 4
	me.yinset = 4

	-- frame
	me.frame = CreateFrame("Frame", nil, UIParent)

	-- location
	me.frame:SetPoint("CENTER", -20, 20)

	-- backdrop
	local backdropdata = 
	{
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
		tile = false,
		tileSize = 32,
		edgeSize = 16,
		insets = { left = 0, right = 0, top = 0, bottom = 0 },
	}
	me.frame:SetBackdrop(backdropdata)

	me.frame:SetBackdropColor(0.0, 0.0, 0.0, 0.0) 
	me.frame:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0) 
	
	-- textures
	me.texture = { }
	
	-- shadow (border). This goes over the whole bar to give it a 3D feel.
	me.texture.shadow = me.frame:CreateTexture(nil, "BORDER")
	me.texture.shadow:SetTexture(1.0, 1.0, 1.0, 1.0)
	me.texture.shadow:SetGradientAlpha("VERTICAL", 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 0.25)
	
	-- health. Ranges from green to red depending on current health
	me.texture.health = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.health:SetTexture(0.0, 1.0, 0.0, 1.0)
	
	-- heal - blue
	me.texture.heal = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.heal:SetTexture(0.4, 0.4, 1.0, 1.0)
	
	-- overheal - purple
	me.texture.overheal = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.overheal:SetTexture(1.0, 1.0, 1.0, 1.0)
	me.texture.overheal:SetGradientAlpha("VERTICAL", 0.25, 0.0, 0.25, 1.0, 0.6, 0.0, 0.6, 1.0)
	
	-- underheal - shadow
	me.texture.underheal = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.underheal:SetTexture(0.0, 0.0, 0.0, 0.9)
	
	-- strings
	me.string = { }
		
	-- name
	me.string.name = me.frame:CreateFontString()
	me.string.name:SetDrawLayer("BACKGROUND")
	me.string.name:SetFont(mod.gui.fontfile, 15)
	me.string.name:ClearAllPoints()
	me.string.name:SetPoint("BOTTOMRIGHT", me.frame, "TOPRIGHT")
	
	-- hpvoid
	me.string.hpvoid = me.frame:CreateFontString()
	me.string.hpvoid:SetDrawLayer("BACKGROUND")
	me.string.hpvoid:SetFont(mod.gui.fontfile, 15)
	me.string.hpvoid:ClearAllPoints()
	me.string.hpvoid:SetPoint("BOTTOMLEFT", me.frame, "TOPLEFT")
	
end

me.resize = function(width, height)
		
	me.width = width
	me.height = height
	
	me.frame:SetWidth(me.width)
	me.frame:SetHeight(me.height)
	
	-- 6 and 8 represents the insets from the border
	me.clientwidth = width - 2 * me.xinset
	me.clientheight = height - 2 * me.yinset
	
	-- set heights of all the textures
	local x
	for _, x in me.texture do
		x:SetHeight(me.clientheight)
	end
	
	-- set the shadow overlay texture
	me.texture.shadow:SetWidth(me.clientwidth)
	me.texture.shadow:ClearAllPoints()
	me.texture.shadow:SetPoint("CENTER", 0, 0)
	
end

me.redraw = function(targetid, expectedheal)
	
	local maxhp = UnitHealthMax(targetid)
	local hpnow = UnitHealth(targetid)
	local overheal = math.max(0, expectedheal - (maxhp - hpnow))
	local efficiency = (expectedheal - overheal) / expectedheal
	
	me.setbarvalues(hpnow, maxhp, expectedheal)
	
	me.string.name:SetText(UnitName(targetid))
	me.string.hpvoid:SetText(math.floor(0.5 + 100 * efficiency) .. "%")
	if (overheal / expectedheal) > mod.main.save.maximumoverheal then
		me.string.hpvoid:SetTextColor(1.0, 0, 0)
	else
		me.string.hpvoid:SetTextColor(0.0, 1.0, 0)
	end
	
end

--[[
mod.targetbar.setbarvalues(currenthp, totalhp, expectedheal)
Redraws the target bar with the new parameters.

<currenthp>		number; the current hitpoints of the target
<totalhp>		number; the max hitpoints of the target
<expectedheal>	number; expected value of the incoming heal
]]
me.setbarvalues = function(currenthp, totalhp, expectedheal)

	local hpvoid = totalhp - currenthp
	local actualheal = math.min(hpvoid, expectedheal)
	local underheal = hpvoid - actualheal
	local overheal = expectedheal - actualheal
	
	-- now scale to hpbar
	currenthp = currenthp / totalhp
	actualheal = actualheal / totalhp
	underheal = underheal / totalhp
	overheal = overheal / totalhp
	
	me.setcolours(currenthp, actualheal, underheal, overheal)
	
end

--[[
PRE: health + heal + void = 1. underheal * overheal = 0.
]]
me.setcolours = function(health, heal, underheal, overheal)
		
	local left = me.xinset
	
	-- health texture
	me.texture.health:SetWidth(health * me.clientwidth)
	
	-- set colour
	local green, red
	if health > 0.5 then
		green = 1
	else
		green = health * 2
	end
	
	if health < 0.5 then
		red = 1
	else
		red = 2 * (1 - health)
	end
	me.texture.health:SetTexture(red, green, 0, 1.0)
	
	me.texture.health:ClearAllPoints()
	me.texture.health:SetPoint("LEFT", left, 0)
	left = left + health * me.clientwidth
	
	-- heal. If it's 0 then hide it (can't set it to 0 width)
	if heal == 0 then
		me.texture.heal:Hide()
	else
		me.texture.heal:Show()
	end
	
	me.texture.heal:SetWidth(heal * me.clientwidth)
	me.texture.heal:ClearAllPoints()
	me.texture.heal:SetPoint("LEFT", left, 0)
	left = left + heal * me.clientwidth
	
	-- underheal. If it's 0 then hide it (can't set it to 0 width)
	if underheal == 0 then
		me.texture.underheal:Hide()
	else
		me.texture.underheal:Show()
	end
	
	me.texture.underheal:SetWidth(underheal * me.clientwidth)
	me.texture.underheal:ClearAllPoints()
	me.texture.underheal:SetPoint("LEFT", left, 0)
	left = left + underheal * me.clientwidth
	
	-- overheal
	overheal = math.min(overheal, 0.5) -- don't want it displaying too far away
	
	-- subtract the border width
	overheal = math.max(0, overheal - me.xinset / me.clientwidth)
	
	-- hide if there's nothing to show!
	if overheal == 0 then
		me.texture.overheal:Hide()
	else
		me.texture.overheal:Show()
	end
	
	me.texture.overheal:SetWidth(overheal * me.clientwidth)
	me.texture.overheal:ClearAllPoints()
	me.texture.overheal:SetPoint("LEFT", me.width - me.xinset, 0)
	
end