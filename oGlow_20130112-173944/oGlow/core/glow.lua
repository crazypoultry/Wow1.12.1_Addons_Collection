local type = type

local colorTable = setmetatable({
	[100] = {r = .9, g = 0, b = 0},
	[99] = {r = 1, g = 1, b = 0},
}, {__call = function(self, val)
	local c = self[val]
	if(c) then return c.r, c.g, c.b
	elseif(type(val) == "number") then return GetItemQualityColor(val) end
end})

local createBorder = function(self, point)
	local bc = self:CreateTexture(nil, "OVERLAY")
	bc:SetTexture"Interface\\Buttons\\UI-ActionButton-Border"
	bc:SetBlendMode"ADD"
	bc:SetAlpha(.8)

	bc:SetWidth(70)
	bc:SetHeight(70)

	bc:SetPoint("CENTER", point or self)
	self.bc = bc
end

local border, r, g, b
oGlow = setmetatable({
	RegisterColor = function(self, key, r, g, b)
		colorTable[key] = {r = r, g = g, b = b}
	end,
}, {
	__call = function(self, frame, quality, point)
		if(type(quality) == "number" and quality > 1 or type(quality) == "string") then
			if(not frame.bc) then createBorder(frame, point) end

			border = frame.bc
			if(border) then
				r, g, b = colorTable(quality)
				border:SetVertexColor(r, g, b)
				border:Show()
			end
		elseif(frame.bc) then
			frame.bc:Hide()
		end
	end,
})

function getQuality(link)
	local q
	local _, _, qColor = string.find(link, "|cff(%x*)|")
	if (qColor == "9d9d9d") then
		q = 0
	end
	if (qColor == "ffffff") then
		q = 1
	end
	if (qColor == "1eff00") then
		q = 2
	end
	if (qColor == "0070dd") then
		q = 3
	end
	if (qColor == "a335ee") then
		q = 4
	end
	if (qColor == "ff8000") then
		q = 5
	end
	if q then return q end
end

function Print( text )
	if (not text) then
		return;	
	end
		ChatFrame1:AddMessage(GREEN_FONT_COLOR_CODE..""..text.."");
end