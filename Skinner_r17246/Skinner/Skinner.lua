
-- if the Debug library is available then use it
if AceLibrary:HasInstance("AceDebug-2.0") then
	Skinner = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.1", "AceDebug-2.0")
else
	Skinner = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.1")
	function Skinner:Debug() end
end

local L = AceLibrary("AceLocale-2.2"):new("Skinner")
-- specify where debug messages go
Skinner.debugFrame = ChatFrame5

function Skinner:OnInitialize()

	self:RegisterDB("SkinnerDB")

	-- convert MetroDelay settings to Delay settings
	if self.db.profile.MetroDelay then
		if not self.db.profile.Delay then
			self.db.profile["Delay"] = self.db.profile.MetroDelay
		end
		self.db.profile.MetroDelay = nil
	end

	self:Defaults()
	self:Options()

	self.initialized = {}

	-- Heading and Body Text colours
	HTr, HTg, HTb = self.db.profile.HeadText.r, self.db.profile.HeadText.g, self.db.profile.HeadText.b
	BTr, BTg, BTb = self.db.profile.BodyText.r, self.db.profile.BodyText.g, self.db.profile.BodyText.b

	-- setup shorthand to the global environment
	_G = getfenv(0)
	-- Frame multipliers
	FxMult, FyMult = 0.9, 0.84
	-- Frame Tab multipliers
	FTxMult, FTyMult = 0.5, 0.75
	-- Container Frame fade height
	CFfh = 100
	-- EditBox regions to keep
	ebRegions = {1, 2, 3, 4, 5}

	self:RegisterChatCommand({"/Skinner", "/skin"}, self.options)
	self.OnMenuRequest = self.options

	-- Gradient settings
	gradientOn = {"VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1}
	gradientOff = {"VERTICAL", 0, 0, 0, 1, 0, 0, 0, 1}
	gradientTab = {"VERTICAL", 1, 1, 1, 1, 1, 1, 1, 1}
	gradientCBar = {"VERTICAL", .25, .25, .55, 1, 0, 0, 0, 1}

end

function Skinner:OnEnable()

	self:RegisterEvent("AceEvent_FullyInitialized")

	-- when addon taken out of standby
	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() then
		self:AceEvent_FullyInitialized()
	end

end

local backdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4},
}

function Skinner:applySkin(frame, header, bba, ba, fh, bd)

	if not frame then return end

	local self = Skinner
	frame:SetBackdrop(bd or backdrop)
	frame:SetBackdropBorderColor(self.db.profile.BackdropBorder.r or .5, self.db.profile.BackdropBorder.g or .5, self.db.profile.BackdropBorder.b or .5, bba or self.db.profile.BackdropBorder.a or 1)
	frame:SetBackdropColor(self.db.profile.Backdrop.r or 0, self.db.profile.Backdrop.g or 0, self.db.profile.Backdrop.b or 0, ba or self.db.profile.Backdrop.a or .9)

	if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
	frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

	if self.db.profile.FadeHeight.enable and (self.db.profile.FadeHeight.force or not fh) then
	-- set the Fade Height if not already passed to this function or 'forced'
	-- making sure that it isn't greater than the frame height
		fh = self.db.profile.FadeHeight.value <= math.ceil(frame:GetHeight()) and self.db.profile.FadeHeight.value or math.ceil(frame:GetHeight())
	end
	-- self:Debug("aS - Frame, Fade Height: [%s, %s]", frame:GetName(), fh)

	frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
	if fh then frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -fh)
	else frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4) end

	frame.tfade:SetBlendMode("ADD")
	frame.tfade:SetGradientAlpha(unpack(self.db.profile.Gradient and gradientOn or gradientOff))

	if header and _G[frame:GetName().."Header"] then
		_G[frame:GetName().."Header"]:Hide()
		_G[frame:GetName().."Header"]:SetPoint("TOP", frame, "TOP", 0, 7)
	end

end

function Skinner:glazeStatusBar(frame, fi)

	if not frame then return end

	if frame:GetFrameType() ~= "StatusBar" then return end
	frame:SetStatusBarTexture("Interface\\AddOns\\Skinner\\textures\\glaze")

	if fi then
		if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
		frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
		frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", fi, -fi)
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -fi, fi)
		frame.tfade:SetBlendMode("ADD")
		frame.tfade:SetGradientAlpha(unpack(gradientOn))
	end

end

function Skinner:skinTooltip(frame)
	if not self.db.profile.Tooltips.shown then return end

	if not frame then return end

	if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
	frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

	frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT",1,-1)
	frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",-1,1)

	frame.tfade:SetBlendMode("ADD")
	frame.tfade:SetGradientAlpha(unpack(self.db.profile.Gradient and gradientOn or gradientOff))

	if self.db.profile.Tooltips.style == 1 then
		frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -6)
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -6, -27)
	else
		frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4)
	end

end

function Skinner:removeRegions(frame, regions)

	if not frame then return end

	-- self:Debug("removeRegions: [%s]", frame:GetName() or "???")

	for k, v in pairs({ frame:GetRegions() }) do
		-- if we have a list, hide the regions in that list
		-- otherwise, hide all regions of the frame
		if regions then
			for _, r in pairs(regions) do
				if k == r then v:SetAlpha(0) break end
			end
		else
			-- self:Debug("remove region: [%s]", k)
			v:SetAlpha(0)
		end
	end

end

function Skinner:keepRegions(frame, regions)

	if not frame then return end

	-- self:Debug("keepRegions: [%s]", frame:GetName() or "???")

	for k, v in pairs({ frame:GetRegions() }) do
		-- if we have a list, hide the regions not in that list
		local keep = nil
		if regions then
			for _, r in pairs(regions) do
				if k == r then keep = true break end
			end
		end
		if not keep then
			-- self:Debug("remove region: [%s]", k)
			v:SetAlpha(0)
		end
	end

end

function Skinner:hookDDScript(ddName)

	if not ddName then return end
--	self:Debug("hookDDScript: [%s]", ddName:GetName())

	if self:IsHooked(ddName, "OnClick") then return end

	self:HookScript(ddName, "OnClick", function()
		-- self:Debug(ddName:GetName().."_OnClick")
		self.hooks[ddName].OnClick()
		self:skinDropDownLists()
		end)

end

function Skinner:skinDropDownLists()
--	self:Debug("skinDropDownLists")

	for i = 1, UIDROPDOWNMENU_MAXLEVELS do
		self:removeRegions(_G["DropDownList"..i])
		_G["DropDownList"..i.."Backdrop"]:Hide()
		_G["DropDownList"..i.."MenuBackdrop"]:Hide()
		self:applySkin(_G["DropDownList"..i])
	end

end

function Skinner:skinScrollBar(scrollFrame)

	if not scrollFrame then return end
--	self:Debug("skinScrollBar: [%s]", scrollFrame:GetName())

	local scrollBar = _G[scrollFrame:GetName().."ScrollBar"]
	scrollBar:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
		edgeFile = "Interface\\AddOns\\Skinner\\textures\\krsnik", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	scrollBar:SetBackdropBorderColor(.2, .2, .2, 1)
	scrollBar:SetBackdropColor(.1, .1, .1, 1)

end

function Skinner:moveObject(objName, xAdj, xDiff, yAdj, yDiff, relTo)

	if not objName then return end
	-- self:Debug("moveObject: [%s, %s%s, %s%s, %s]", objName:GetName(), xAdj, xDiff, yAdj, yDiff, relTo)

	local point, relativeTo, relativePoint, xOfs, yOfs = objName:GetPoint()

-- Workaround for yOfs crash when using bar addons
	if not yOfs then
		return
	end

	-- self:Debug("GetPoint: [%s, %s, %s, %s, %s]", point, relativeTo:GetName(), relativePoint, xOfs, yOfs)
	-- apply the adjustment
	if xAdj == nil then xOffset = xOfs else xOffset = (xAdj == "+" and xOfs + xDiff or xOfs - xDiff) end
	if yAdj == nil then yOffset = yOfs else yOffset = (yAdj == "+" and yOfs + yDiff or yOfs - yDiff) end

	if relTo == nil then relTo = relativeTo:GetName() end

	objName:ClearAllPoints()
	objName:SetPoint(point, relTo, relativePoint, xOffset, yOffset)

end

function Skinner:setActiveTab(tabName)
--	self:Debug("setActiveTab : [%s]", tabName)

	_G[tabName].tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	_G[tabName].tfade:SetGradientAlpha(unpack(self.db.profile.Gradient and gradientOn or gradientOff))

end

function Skinner:setInactiveTab(tabName)
--	self:Debug("setInactiveTab : [%s]", tabName)

	_G[tabName].tfade:SetTexture("Interface\\AddOns\\Skinner\\textures\\inactive")
	_G[tabName].tfade:SetGradientAlpha(unpack(self.db.profile.Gradient and gradientOn or gradientTab))

end

function Skinner:skinCastingBar(frame)

	if not frame then return end

	if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
	frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

	frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", -1, 1)
	frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 1, -1)

	frame.tfade:SetBlendMode("BLEND")
	frame.tfade:SetGradientAlpha(unpack(gradientCBar))

end

function Skinner:shrinkBag(frame, bpMF)

	if not frame then return end

	frameName = frame:GetName()

	local bgTop = _G[frameName.."BackgroundTop"]
	if math.floor(bgTop:GetHeight()) == 256 then -- this is the backpack
		if bpMF then -- is this a backpack Money Frame
			local point, relativeTo, relativePoint, xOfs, yOfs = _G[frameName.."MoneyFrame"]:GetPoint()
			if math.floor(yOfs) == -216 then -- is it still in its original position
				self:moveObject(_G[frameName.."MoneyFrame"], nil, nil, "+", 18)
			end
			frame:SetHeight(frame:GetHeight() - 20)
		else
			self:moveObject(_G[frameName.."Item1"], nil, nil, "-", 20)
			frame:SetHeight(frame:GetHeight() - 40)
		end
	end
	if math.ceil(bgTop:GetHeight()) == 94 then frame:SetHeight(frame:GetHeight() - 20) end
	if math.ceil(bgTop:GetHeight()) == 86 then frame:SetHeight(frame:GetHeight() - 20) end
	if math.ceil(bgTop:GetHeight()) == 72 then frame:SetHeight(frame:GetHeight() + 2) end -- 6, 10 or 14 slot bag

	frame:SetWidth(frame:GetWidth() - 10)
	self:moveObject(_G[frameName.."Item1"], "+", 3, nil, nil)

	-- use default fade height
	local fh = CFfh

	if self.db.profile.FadeHeight.enable and self.db.profile.FadeHeight.force then
	-- set the Fade Height
	-- making sure that it isn't greater than the frame height
		fh = self.db.profile.FadeHeight.value <= math.ceil(frame:GetHeight()) and self.db.profile.FadeHeight.value or math.ceil(frame:GetHeight())
	end
	-- self:Debug("sB - Frame, Fade Height: [%s, %s]", frame:GetName(), fh)

	if fh then frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -fh) end

end

function Skinner:isVersion(addonName, verNoReqd, actualVerNo)
	-- self:Debug("isVersion: [%s, %s, %s]", addonName, verNoReqd, actualVerNo)

	local hasMatched = false

	if type(verNoReqd) == "table" then
		for k, v in pairs(verNoReqd) do
			 if v == actualVerNo then
				hasMatched = true
				break
			end
		end
	else
		if verNoReqd == actualVerNo then hasMatched = true end
	end

	if not hasMatched then self:CustomPrint(1, 0.25, 0.25, nil, nil, " ", "This version of", addonName, "is unsupported") end

	return hasMatched

end

function Skinner:skinEditBox(frame, regions, noSkin, noHeight)

	local kRegions = { unpack(ebRegions) }
	if regions then
		for k, v in pairs(regions) do
			table.insert(kRegions, v)
		end
	end

	self:keepRegions(frame, kRegions)
	local l, r, t, b = frame:GetTextInsets()
	frame:SetTextInsets(l + 5, r + 5, t, b)
	if not (noHeight or frame:IsMultiLine()) then frame:SetHeight(26) end
	frame:SetWidth(frame:GetWidth() + 5)

	if not noSkin then
		frame:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
			edgeFile = "Interface\\AddOns\\Skinner\\textures\\krsnik", edgeSize = 16,
			insets = {left = 4, right = 4, top = 4, bottom = 4},
		})
		frame:SetBackdropBorderColor(.2, .2, .2, 1)
		frame:SetBackdropColor(.1, .1, .1, 1)
	end

end

function Skinner:getRegion(frame, regNo)

	for k, v in pairs({ frame:GetRegions() }) do
		if k == regNo then return v end
	end

	return nil

end

function Skinner:skinMoneyFrame(frame, moveGold)

	for k, v in pairs({ "Gold", "Silver", "Copper" }) do
		local fName = _G[frame:GetName()..v]
		fName:SetWidth(fName:GetWidth() - 4)
		fName:SetHeight(fName:GetHeight() + 4)
		self:skinEditBox(fName, {9}, nil, true) -- N.B. region 9 is the icon
		if k ~= 1 or moveGold then
			self:moveObject(self:getRegion(fName, 9), "+", 10, nil, nil)
		end
		if k ~= 1 then
			fName:SetWidth(fName:GetWidth() + 5)
		end
	end

end

function Skinner:checkAddOn(addonName)
	-- self:Debug("checkAddOn:[%s, %s, %s]", addonName, IsAddOnLoaded(addonName), type(self[addonName]))

	return IsAddOnLoaded(addonName) and type(self[addonName]) == "function"

end
