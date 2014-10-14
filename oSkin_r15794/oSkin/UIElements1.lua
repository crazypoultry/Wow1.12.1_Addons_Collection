
function oSkin:Tooltips()
	if not self.db.profile.Tooltips or self.initialized.Tooltips then return end
	self.initialized.Tooltips = true

	self:skinTooltip(_G["GameTooltip"])
	self:skinTooltip(_G["ItemRefTooltip"])
	
end

function oSkin:MirrorTimers()
	if not self.db.profile.MirrorTimers or self.initialized.MirrorTimers then return end
	self.initialized.MirrorTimers = true
	
	for i = 1, MIRRORTIMER_NUMTIMERS do
		self:keepRegions(_G["MirrorTimer"..i], {2}) -- N.B. region 2 is text
		_G["MirrorTimer"..i]:SetHeight(_G["MirrorTimer"..i]:GetHeight() * 1.1)
		self:moveObject(_G["MirrorTimer"..i.."Text"], nil, nil, "-", 4)
		self:moveObject(_G["MirrorTimer"..i.."StatusBar"], nil, nil, "-", 3)
		self:glazeStatusBar(_G["MirrorTimer"..i.."StatusBar"], 0)
	end
	
end

function oSkin:QuestTimers()
	if not self.db.profile.MirrorTimers or self.initialized.QuestTimers then return end
	self.initialized.QuestTimers = true
	
	self:keepRegions(_G["QuestTimerFrame"], {11}) -- N.B. region 11 is text
	_G["QuestTimerFrame"]:SetWidth(_G["QuestTimerFrame"]:GetWidth() - 40)
	_G["QuestTimerFrame"]:SetHeight(_G["QuestTimerFrame"]:GetHeight() - 20)
	self:moveObject(_G["QuestTimerHeader"], nil, nil, "-", 4)
	self:applySkin(_G["QuestTimerFrame"])
	
end

function oSkin:CastingBar()
	if not self.db.profile.CastingBar or self.initialized.CastingBar then return end
	self.initialized.CastingBar = true
	
	self:Hook("CastingBarFrame_OnUpdate")
	
	self:keepRegions(_G["CastingBarFrame"], {2, 4, 5}) -- N.B. region 2 is text, 4 & 5 are overlays
	_G["CastingBarFrame"]:SetWidth(_G["CastingBarFrame"]:GetWidth() * 0.75)
	_G["CastingBarFrame"]:SetHeight(_G["CastingBarFrame"]:GetHeight() * 1.1)
	_G["CastingBarSpark"]:SetHeight(_G["CastingBarSpark"]:GetHeight() * 1.5)
	_G["CastingBarFlash"]:SetWidth(_G["CastingBarFrame"]:GetWidth())
	_G["CastingBarFlash"]:SetHeight(_G["CastingBarFrame"]:GetHeight())
	_G["CastingBarFlash"]:SetTexture("Interface\\AddOns\\oSkin\\textures\\glaze")
	self:moveObject(_G["CastingBarText"], nil, nil, "-", 3)
	self:moveObject(_G["CastingBarFlash"], nil, nil, "-", 28)
	self:skinCastingBar(_G["CastingBarFrame"])
	self:glazeStatusBar(_G["CastingBarFrame"], 1)
	
end

function oSkin:CastingBarFrame_OnUpdate()

	if ( this.casting ) then
	    local status = GetTime()
	    if ( status > this.maxValue ) then
	    	status = this.maxValue
	    end
	    CastingBarFrameStatusBar:SetValue(status)
	    CastingBarFlash:Hide()
	    local sparkPosition = ((status - this.startTime) / (this.maxValue - this.startTime)) * CastingBarFrameStatusBar:GetWidth()
	    if ( sparkPosition < 0 ) then
	    	sparkPosition = 0
	    end
	    CastingBarSpark:SetPoint("CENTER", "CastingBarFrameStatusBar", "LEFT", sparkPosition, 0)
	elseif ( this.channeling ) then
	    local time = GetTime()
	    if ( time > this.endTime ) then
	    	time = this.endTime
	    end
	    if ( time == this.endTime ) then
	    	this.channeling = nil
	    	this.fadeOut = 1
	    	return
	    end
	    local barValue = this.startTime + (this.endTime - time)
	    CastingBarFrameStatusBar:SetValue( barValue )
	    CastingBarFlash:Hide()
	    local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime)) * CastingBarFrameStatusBar:GetWidth()
	    CastingBarSpark:SetPoint("CENTER", "CastingBarFrameStatusBar", "LEFT", sparkPosition, 0)
	elseif ( GetTime() < this.holdTime ) then
	    return
	elseif ( this.flash ) then
	    local alpha = CastingBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP
	    if ( alpha < 1 ) then
	    	CastingBarFlash:SetAlpha(alpha)
	    else
	    	this.flash = nil
	    end
	elseif ( this.fadeOut ) then
	    local alpha = this:GetAlpha() - CASTING_BAR_ALPHA_STEP
	    if ( alpha > 0 ) then
	    	this:SetAlpha(alpha)
	    else
	    	this.fadeOut = nil
	    	this:Hide()
	    end
	end
	
end

function oSkin:StaticPopups()
	if not self.db.profile.StaticPopups or self.initialized.StaticPopups then return end
	self.initialized.StaticPopups = true
	
	self:Hook("StaticPopup_Show")
	
	for i = 1, STATICPOPUP_NUMDIALOGS do
		self:applySkin(_G["StaticPopup"..i])
		-- skin WideEditBox
		local editBox = _G["StaticPopup"..i.."WideEditBox"]
		self:removeRegions(editBox, {6, 7}) -- N.B. other regions are scripts
		editBox:SetHeight(editBox:GetHeight() / 2)
		local left,right,top,bottom = editBox:GetTextInsets()
		editBox:SetTextInsets(left + 4, right, top, bottom)
		self:applySkin(editBox)
		-- skin EditBox
		local editBox = _G["StaticPopup"..i.."EditBox"]
		self:removeRegions(editBox, {6, 7}) -- N.B. other regions are scripts
		local left,right,top,bottom = editBox:GetTextInsets()
		editBox:SetTextInsets(left + 4, right, top, bottom)
		self:applySkin(editBox)
	end
	
end

function oSkin:StaticPopup_Show(which, text_arg1, text_arg2, data)
	if not self.initialized.StaticPopups then
		return self.hooks.StaticPopup_Show(which, text_arg1, text_arg2, data)
	end

	local info = StaticPopupDialogs[which]
	local dialog, width = nil, 320
	dialog = StaticPopup_FindVisible(which, data)

	if ( not dialog ) then
		-- Find a free dialog
		local index = 1
		if ( StaticPopupDialogs[which].preferredIndex ) then
			index = StaticPopupDialogs[which].preferredIndex
		end
		for i = index, STATICPOPUP_NUMDIALOGS do
			local frame = getglobal("StaticPopup"..i)
			if ( not frame:IsShown() ) then
				dialog = frame
				break
			end
		end
		
		if ( not dialog and StaticPopupDialogs[which].preferredIndex ) then
			for i = 1, StaticPopupDialogs[which].preferredIndex do
				local frame = getglobal("StaticPopup"..i)
				if ( not frame:IsShown() ) then
					dialog = frame
					break
				end
			end
		end
	end
	
	if ( (which == "SET_GUILDMOTD") 
	or (which == "SET_GUILDPLAYERNOTE") 
	or (which == "SET_GUILDPLAYERNOTE") 
	or (which == "SET_GUILDOFFICERNOTE" )) then
		width = 420
	elseif ( which == "HELP_TICKET" ) then
		width = 350
	elseif ( info.showAlert ) then
		width = 420
	end
	
	dialog.tfade:SetWidth(width-8)
	
	return self.hooks.StaticPopup_Show(which, text_arg1, text_arg2, data)

end

function oSkin:ChatTabs()
	if not self.db.profile.ChatTabs or self.initialized.ChatTabs then return end
	self.initialized.ChatTabs = true

    if self.db.profile.TexturedTab then 
    	self:Hook("FCF_SetTabPosition", function(chatFrame, x)
--  		self:Debug("FCF_SetTabPosition: [%s, %s]", chatFrame:GetName(), x)
    		self.hooks.FCF_SetTabPosition(chatFrame, x)
    		self:moveObject(_G[chatFrame:GetName().."Tab"], nil, nil, "-", 4)
    		end)
    
    	for i = 1, NUM_CHAT_WINDOWS do
    		local tabName = _G["ChatFrame"..i.."Tab"]
    		self:keepRegions(tabName, {4, 5}) --N.B. region 4 is text, 5 is highlight
    		self:moveObject(tabName, nil, nil, "-", 4)
    		self:moveObject(_G[tabName:GetName().."Flash"], nil, nil, "+", 4)
    		local textObj
    		-- move text and highlight area and resize highlight
    		for i, v in { tabName:GetRegions() } do
    			if i == 4 then
    				self:moveObject(v, "+", 5, "+", 4)
    				textObj = v
    			elseif i == 5 then
    				self:moveObject(v, "+", 5, "+", 5)
    				v:SetWidth(textObj:GetWidth()  + 30)
    			end
    		end	
    		self:applySkin(tabName, nil, 0)
    		self:setActiveTab(tabName:GetName())
    	end
    else
    	for i=1, NUM_CHAT_WINDOWS do
    		self:removeRegions(_G["ChatFrame"..i.."Tab"], {1, 2, 3})
    		self:createTab(_G["ChatFrame"..i.."Tab"])
    	end
	end
	
end
function oSkin:ChatFrames()
	if not self.db.profile.ChatFrames or self.initialized.ChatFrames then return end
	self.initialized.ChatFrames = true

	self:SecureHook("FCF_StopResize", function()
		-- self:Debug("FCF_StopResize: [%s, %s]", this:GetName(), this:GetParent():GetName())
		local frame = _G["oSkin"..this:GetParent():GetName()]
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -math.ceil(frame:GetHeight()))
		end)
		
	for i=1, NUM_CHAT_WINDOWS do
		self:createCF(_G["ChatFrame"..i])
	end
	
end

function oSkin:createTab(parent)
--	self:Debug("createTab: [%s]", parent)

	oct = CreateFrame("frame", nil, parent)
	oct:SetFrameStrata("BACKGROUND")
	oct:SetFrameLevel(0)
	oct:ClearAllPoints()
	oct:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -8)
	oct:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -8)
	oct:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, -5)
	oct:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, -5)
	self:applySkin(oct)
	
end

function oSkin:createCF(parent)
--	self:Debug("createCF: [%s]", parent)

	ocf = CreateFrame("frame", "oSkin"..parent:GetName(), parent)
	ocf:SetFrameStrata("BACKGROUND")
	ocf:SetFrameLevel(0)
	ocf:ClearAllPoints()
	ocf:SetPoint("TOPLEFT", parent, "TOPLEFT", -4, 4)
	ocf:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 4, 4)
	ocf:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", -4, -8)
	ocf:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 4, -8)
	self:applySkin(ocf)

end

function oSkin:ChatEditBox()
	if not self.db.profile.ChatEditBox or self.initialized.ChatEditBox then return end 
	self.initialized.ChatEditBox = true

	self:removeRegions(_G["ChatFrameEditBox"], {6, 7, 8})
	self:applySkin(_G["ChatFrameEditBox"])

end

function oSkin:LootFrame()
	if not self.db.profile.LootFrame or self.initialized.LootFrame then return end
	self.initialized.LootFrame = true

	self:removeRegions(_G["LootFrame"], {1, 2})
	
	_G["LootFrame"]:SetWidth(_G["LootFrame"]:GetWidth() * 0.66)
	_G["LootFrame"]:SetHeight(_G["LootFrame"]:GetHeight() * FyMult)

	for i, v in { _G["LootFrame"]:GetRegions() } do
		-- region 3 is the title
		if i == 3 then
			self:moveObject(v, "+", 15, "-", 10)
		end
	end

	self:moveObject(_G["LootCloseButton"], "+", 65, "+", 10)

	for i = 1, NUM_GROUP_LOOT_FRAMES do
		if i == 1 then
			self:moveObject(_G["LootButton"..i], "-", 13, "+", 40)
		else
			self:moveObject(_G["LootButton"..i], nil, nil, nil, nil)
		end
    end
    self:moveObject(_G["LootFramePrev"], "-", 15, nil, nil)	
    self:moveObject(_G["LootFrameNext"], "-", 0, nil, nil)	
	self:moveObject(_G["LootFrameUpButton"], "-", 15, nil, nil)
	self:moveObject(_G["LootFrameDownButton"], "-", 0, nil, nil)

	self:applySkin(_G["LootFrame"], 1)
	
end

function oSkin:GroupLoot()
	if not self.db.profile.GroupLoot.shown or self.initialized.GroupLoot then return end
	self.initialized.GroupLoot = true

	self:hookDDScript(GroupLootDropDownButton)	
	self:Hook("GroupLootFrame_OnShow", function()
		local texture, name, count, quality, bindOnPickUp = GetLootRollItemInfo(this.rollID)
		_G["GroupLootFrame"..this:GetID().."IconFrameIcon"]:SetTexture(texture)
		_G["GroupLootFrame"..this:GetID().."Name"]:SetText(name)
		local color = ITEM_QUALITY_COLORS[quality]
		_G["GroupLootFrame"..this:GetID().."Name"]:SetVertexColor(color.r, color.g, color.b)
		_G["GroupLootFrame"..this:GetID().."Timer"]:SetStatusBarColor(color.r, color.g, color.b)
		end)

	self:keepRegions(_G["GroupLootDropDown"], {4}) -- N.B. region 4 is text
	local f = GameFontNormalSmall:GetFont()

	for i = 1, NUM_GROUP_LOOT_FRAMES do
	
		local glf = "GroupLootFrame"..i
		self:removeRegions(_G[glf], {4, 5}) -- N.B. regions 1-3 are text
	
		if self.db.profile.GroupLoot.size == 1 then 
		
			_G[glf]:SetWidth(_G[glf]:GetWidth() * 0.95)
			_G[glf]:SetHeight(_G[glf]:GetHeight() * FyMult)
	
			self:moveObject(_G[glf.."SlotTexture"], "-", 3, "+", 5)
			self:moveObject(_G[glf.."RollButton"], "+", 6, "+", 6)

		elseif self.db.profile.GroupLoot.size == 2 then
	
			_G[glf]:SetWidth(_G[glf]:GetWidth() * 0.78)
			_G[glf]:SetHeight(_G[glf]:GetHeight() * 0.65)
	
			local xMult, yMult = 0.75, 0.75
			_G[glf.."SlotTexture"]:SetWidth(_G[glf.."SlotTexture"]:GetWidth() * xMult)
			_G[glf.."SlotTexture"]:SetHeight(_G[glf.."SlotTexture"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."SlotTexture"], "-", 2, "+", 4)
			_G[glf.."NameFrame"]:SetWidth(_G[glf.."NameFrame"]:GetWidth() - 15)
			_G[glf.."NameFrame"]:SetHeight(_G[glf.."NameFrame"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."NameFrame"], "+", 2, "+", 2)
			_G[glf.."Name"]:SetFont(f, 7)
			self:moveObject(_G[glf.."Name"], "+", 3, "-", 4)
			_G[glf.."PassButton"]:SetWidth(_G[glf.."PassButton"]:GetWidth() * xMult)
			_G[glf.."PassButton"]:SetHeight(_G[glf.."PassButton"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."PassButton"], nil, nil, "+", 3)
			_G[glf.."RollButton"]:SetWidth(_G[glf.."RollButton"]:GetWidth() * xMult)
			_G[glf.."RollButton"]:SetHeight(_G[glf.."RollButton"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."RollButton"], "+", 13, "+", 7)
			_G[glf.."GreedButton"]:SetWidth(_G[glf.."GreedButton"]:GetWidth() * xMult)
			_G[glf.."GreedButton"]:SetHeight(_G[glf.."GreedButton"]:GetHeight() * yMult)
			_G[glf.."IconFrame"]:SetWidth(_G[glf.."IconFrame"]:GetWidth() * xMult)
			_G[glf.."IconFrame"]:SetHeight(_G[glf.."IconFrame"]:GetHeight() * yMult)
			_G[glf.."IconFrameIcon"]:SetWidth(_G[glf.."IconFrameIcon"]:GetWidth() * 0.8)
			_G[glf.."IconFrameIcon"]:SetHeight(_G[glf.."IconFrameIcon"]:GetHeight() * 0.8)
			_G[glf.."IconFrameIcon"]:SetAlpha(1)
			self:moveObject(_G[glf.."IconFrameIcon"], "-", 5, "+", 5)
			_G[glf.."Timer"]:SetWidth(_G[glf.."Timer"]:GetWidth() * xMult)
			_G[glf.."Timer"]:SetHeight(_G[glf.."Timer"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."Timer"], "-", 2, "-", 3)	
		
		elseif self.db.profile.GroupLoot.size == 3 then
	
			_G[glf]:SetWidth(_G[glf]:GetWidth() * 0.35)
			_G[glf]:SetHeight(_G[glf]:GetHeight() * 0.65)
	
			local xMult, yMult = 0.75, 0.75
			_G[glf.."SlotTexture"]:SetWidth(_G[glf.."SlotTexture"]:GetWidth() * xMult)
			_G[glf.."SlotTexture"]:SetHeight(_G[glf.."SlotTexture"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."SlotTexture"], "-", 5, "+", 5)
			_G[glf.."NameFrame"]:Hide()
			_G[glf.."Name"]:Hide()
			_G[glf.."PassButton"]:SetWidth(_G[glf.."PassButton"]:GetWidth() * xMult)
			_G[glf.."PassButton"]:SetHeight(_G[glf.."PassButton"]:GetHeight() * yMult)
			_G[glf.."RollButton"]:SetWidth(_G[glf.."RollButton"]:GetWidth() * xMult)
			_G[glf.."RollButton"]:SetHeight(_G[glf.."RollButton"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."RollButton"], "+", 15, "+", 10)
			_G[glf.."GreedButton"]:SetWidth(_G[glf.."GreedButton"]:GetWidth() * xMult)
			_G[glf.."GreedButton"]:SetHeight(_G[glf.."GreedButton"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."GreedButton"], nil, nil, "+", 3)
			_G[glf.."IconFrame"]:SetWidth(_G[glf.."IconFrame"]:GetWidth() * xMult)
			_G[glf.."IconFrame"]:SetHeight(_G[glf.."IconFrame"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."IconFrame"], "-", 5, "+", 5)
			_G[glf.."IconFrameIcon"]:SetWidth(_G[glf.."IconFrameIcon"]:GetWidth() * xMult + 2)
			_G[glf.."IconFrameIcon"]:SetHeight(_G[glf.."IconFrameIcon"]:GetHeight() * yMult + 2)
			_G[glf.."IconFrameIcon"]:SetAlpha(1)
			_G[glf.."Timer"]:SetWidth(_G[glf.."Timer"]:GetWidth() * 0.35)
			_G[glf.."Timer"]:SetHeight(_G[glf.."Timer"]:GetHeight() * yMult)
			self:moveObject(_G[glf.."Timer"], "-", 2, "-", 4)	
		
		end

		self:removeRegions(_G[glf.."Timer"], {1})
		self:glazeStatusBar(_G[glf.."Timer"])
	
		self:applySkin(_G[glf])
	end
	
end

function oSkin:containerFrames()
	if not self.db.profile.ContainerFrames or self.initialized.ContainerFrames then return end
	self.initialized.ContainerFrames = true

	self:SecureHook("ContainerFrame_GenerateFrame")	

	for i = 1, NUM_CONTAINER_FRAMES do
		self:keepRegions(_G["ContainerFrame"..i], {6}) -- N.B. region 6 is text
		self:moveObject(_G["ContainerFrame"..i.."Name"], "-", 5, nil, nil)	
		self:applySkin(_G["ContainerFrame"..i], nil, nil, nil, CFfh)
	end

end

function oSkin:ContainerFrame_GenerateFrame(frameObj, size, id)

	frame = frameObj:GetName()
	
	if ( id > NUM_BAG_FRAMES ) then
		_G[frame.."Name"]:SetTextColor(.3, .3, 1)
	elseif ( id == KEYRING_CONTAINER ) then
		_G[frame.."Name"]:SetTextColor(1, .7, 0)
	else
		_G[frame.."Name"]:SetTextColor(1, 1, 1)
	end

	self:shrinkBag(frameObj, true)	

end

function oSkin:StackSplit()
	if not self.db.profile.StackSplit or self.initialized.StackSplit then return end
	self.initialized.StackSplit = true
	
	self:removeRegions(_G["StackSplitFrame"], {1}) -- N.B. region 2 is text
	_G["StackSplitFrame"]:SetWidth(_G["StackSplitFrame"]:GetWidth() - 12)
	_G["StackSplitFrame"]:SetHeight(_G["StackSplitFrame"]:GetHeight() - 28)
	self:moveObject(_G["StackSplitText"], nil, nil, "-", 5)	
	self:moveObject(_G["StackSplitLeftButton"], "+", 5, "-", 5)	
	self:moveObject(_G["StackSplitRightButton"], "-", 5, "-", 5)	
	self:moveObject(_G["StackSplitOkayButton"], nil, nil, "-", 13)	
	self:moveObject(_G["StackSplitCancelButton"], nil, nil, "-", 13)	

	self:applySkin(_G["StackSplitFrame"])

end

function oSkin:ItemText()
	if not self.db.profile.ItemText or self.initialized.ItemText then return end
	self.initialized.ItemText = true
	
	self:Hook("ItemTextFrame_OnEvent", function(event)
--		self:Debug("ItemTextFrame_OnEvent: [%s]", event)
		self.hooks.ItemTextFrame_OnEvent(event)
		if event == "ITEM_TEXT_BEGIN" then
			_G["ItemTextPageText"]:SetTextColor(BTr, BTg, BTb)
		end
		end)
	
	self:removeRegions(_G["ItemTextFrame"], {1, 2, 3, 4, 5, 6, 7, 8, 9}) -- N.B. region 10 & 11 are text
	_G["ItemTextFrame"]:SetWidth(_G["ItemTextFrame"]:GetWidth() - 30)
	_G["ItemTextFrame"]:SetHeight(_G["ItemTextFrame"]:GetHeight() - 60)
	self:moveObject(_G["ItemTextTitleText"], nil, nil, "-", 24)

	self:removeRegions(_G["ItemTextScrollFrame"])
	self:moveObject(_G["ItemTextScrollFrame"], "+", 30, "+", 20)
	self:skinScrollBar(_G["ItemTextScrollFrame"])
	self:moveObject(_G["ItemTextStatusBar"], nil, nil, "-", 115)
	self:glazeStatusBar(_G["ItemTextStatusBar"], 0)
	self:moveObject(_G["ItemTextPrevPageButton"], "-", 45, "+", 10)
	self:moveObject(_G["ItemTextNextPageButton"], "+", 10, "+", 10)
	self:moveObject(_G["ItemTextCloseButton"], "+", 28, "+", 8)
	
	self:applySkin(_G["ItemTextFrame"])
	
end

function oSkin:WorldMap()
	if not self.db.profile.WorldMap or self.initialized.WorldMap then return end
	self.initialized.WorldMap = true

	self:hookDDScript(WorldMapContinentDropDownButton)	
	self:hookDDScript(WorldMapZoneDropDownButton)	

	self:keepRegions(_G["WorldMapFrame"], {14}) -- N.B. region 14 is text
	self:keepRegions(_G["WorldMapContinentDropDown"], {4}) -- N.B. region 4 is text
	self:keepRegions(_G["WorldMapZoneDropDown"], {4}) -- N.B. region 4 is text
	
	
	if not IsAddOnLoaded("MetaMap") then
		self:moveObject(_G["WorldMapFrameCloseButton"], "+", 98, "-", 4)
		self:applySkin(_G["WorldMapFrame"])
	end
	
end

function oSkin:ColorPicker()
	if not self.db.profile.Colours or self.initialized.Colours then return end
	self.initialized.Colours = true

	self:applySkin(_G["ColorPickerFrame"], 1)
	self:applySkin(_G["OpacityFrame"])

end

function oSkin:HelpFrame()

	self:keepRegions(_G["HelpFrame"], {8}) -- N.B. region 8 is text
	_G["HelpFrame"]:SetWidth(_G["HelpFrame"]:GetWidth() - 20)
	_G["HelpFrame"]:SetHeight(_G["HelpFrame"]:GetHeight() * 0.85)
	self:moveObject(_G["HelpFrameCloseButton"], "+", 42, "+", 2)
	self:moveObject(_G["HelpFrameHomeCancel"], "+", 42, "-", 12)
	self:applySkin(_G["HelpFrame"], 1)
	
	for i, v in { _G["HelpFrameGM"]:GetRegions() } do
		if i == 1  then	self:moveObject(v, "+", 0, "+", 35)
		end
	end

	self:moveObject(_G["HelpFrameButton1"], "+", 0, "+", 45)
	self:removeRegions(_G["HelpFrameGMScrollFrame"])
	self:skinScrollBar(_G["HelpFrameGMScrollFrame"])
	self:moveObject(_G["HelpFrameGMCancel"], "+", 42, "-", 12)
	self:moveObject(_G["HelpFrameGeneralCancel"], "+", 42, "-", 12)
	self:moveObject(_G["HelpFrameHarassmentText"], "+", 0, "+", 20)
	self:moveObject(_G["HelpFrameVerbalHarassment"], "+", 0, "+", 20)
	self:moveObject(_G["HelpFrameVerbalHarassmentButton"], "+", 0, "+", 10)
	_G["HelpFrameHarassmentDivider2"]:Hide()
	self:moveObject(_G["HelpFramePhysicalHarassment"], "+", 0, "+", 20)
	self:moveObject(_G["HelpFramePhysicalHarassmentButton"], "+", 0, "+", 20)
	_G["HelpFrameHarassmentDivider"]:Hide()
	self:moveObject(_G["HelpFrameHarassmentCancel"], "+", 42, "-", 12)
	self:moveObject(_G["HelpFrameStuckCancel"], "+", 42, "-", 12)
	
--	HelpFrameOpenTicket
--	HelpFrameOpenTicketScrollFrame
--	HelpFrameOpenTicketCancel

end
