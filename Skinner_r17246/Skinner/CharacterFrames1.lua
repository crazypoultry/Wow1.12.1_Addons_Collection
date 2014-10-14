
-- CharacterFrame / ReputationFrame / SkillFrame
function Skinner:characterFrames()
	if not self.db.profile.CharacterFrames or self.initialized.CharacterFrames then return end
	self.initialized.CharacterFrames = true

	-- hook this to adjust the widths of the Tabs
	self:Hook("CharacterFrame_ShowSubFrame")
	-- hook this to move tabs when Pet is called
	self:Hook("PetTab_Update", "CF_PetTab_Update")
		
	-- handle each frame
	self:CharacterFrame()
	self:PaperDollFrame()
	self:PetPaperDollFrame()
	self:ReputationFrame()
	self:SkillFrame()
	self:HonorFrame()

end

function Skinner:CharacterFrame()

	self:removeRegions(_G["CharacterFrame"])	

	_G["CharacterFrame"]:SetWidth(_G["CharacterFrame"]:GetWidth() * FxMult)
	_G["CharacterFrame"]:SetHeight(_G["CharacterFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["CharacterNameText"], nil, nil, "-", 30)
	self:moveObject(_G["CharacterFrameCloseButton"], "+", 28, "+", 8)
	
--	CharacterFrameTab1-5
	for i = 1, table.getn(CHARACTERFRAME_SUBFRAMES) do

    	local tabName = _G["CharacterFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		if i == 1 then
			self:moveObject(tabName, "-", 6, "-", 71)
		else
			-- handle no pet out or not a pet class
			self:moveObject(tabName, "+", ((i == 3 and not HasPetUI()) and 0 or 11), nil, nil)
		end
        if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0, 1)
		else self:applySkin(tabName) end
	
	end

	self:applySkin(_G["CharacterFrame"])	

end

function Skinner:PaperDollFrame()

	self:keepRegions(_G["PaperDollFrame"], {5, 6, 7}) -- N.B. regions 5-7 are text
	
	_G["CharacterModelFrameRotateLeftButton"]:Hide()
	_G["CharacterModelFrameRotateRightButton"]:Hide()
	self:makeMFRotatable(_G["CharacterModelFrame"])
	
	local xOfs, yOfs = 9, 20
	self:moveObject(_G["CharacterModelFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterHeadSlot"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterHandsSlot"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterResistanceFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterAttributesFrame"], "-", xOfs, "+", yOfs)

	self:moveObject(_G["CharacterMainHandSlot"], "-", 20, "-", 60)

	self:removeRegions(_G["CharacterAmmoSlot"], {1})
	
	self:applySkin(_G["PaperDollFrame"])

end

function Skinner:PetPaperDollFrame()

	self:removeRegions(_G["PetPaperDollFrame"], {1, 2, 3, 4}) -- N.B. regions 5-9 are text
	
	_G["PetModelFrameRotateLeftButton"]:Hide()
	_G["PetModelFrameRotateRightButton"]:Hide()
	self:makeMFRotatable(_G["PetModelFrame"])
	
	self:moveObject(_G["PetNameText"], nil, nil, "-", 30)

	local xOfs, yOfs = 10, 25
	self:moveObject(_G["PetModelFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["PetAttributesFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["PetResistanceFrame"], "-", xOfs, "+", yOfs)
	
	-- move outside the Model Frame otherwise the tooltip doesn't work
	self:moveObject(_G["PetPaperDollPetInfo"], nil, nil, "+", 90)
	
	self:keepRegions(_G["PetPaperDollFrameExpBar"], {3, 4}) -- N.B. region 3 is text
	self:moveObject(_G["PetPaperDollFrameExpBar"], "-", 10, "-", 72)
	self:glazeStatusBar(_G["PetPaperDollFrameExpBar"], 0)

	self:moveObject(_G["PetTrainingPointText"], nil, nil, "-", 72)
	self:moveObject(_G["PetPaperDollCloseButton"], "-", 5, "+", 9)
	
	self:applySkin(_G["PetPaperDollFrame"])

end

function Skinner:ReputationFrame()

	self:keepRegions(_G["ReputationFrame"], {5, 6}) -- N.B. regions 5 & 6 are text
	
	local xOfs, yOfs = 5, 20
	self:moveObject(_G["ReputationFrameFactionLabel"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["ReputationFrameStandingLabel"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["ReputationBar1"], "-", xOfs, "+", yOfs)

	for i = 1 , NUM_FACTIONS_DISPLAYED do
		self:removeRegions(_G["ReputationBar"..i], {1, 2}) -- N.B. regions 3 & 4 are text
		self:glazeStatusBar(_G["ReputationBar"..i], 0)
	end

	self:removeRegions(_G["ReputationListScrollFrame"])
	self:moveObject(_G["ReputationListScrollFrame"], "+", 35, "+", 20)
	self:skinScrollBar(_G["ReputationListScrollFrame"])

	self:keepRegions(_G["ReputationDetailFrame"], {10, 11}) -- N.B. regions 10 & 11 are text
	self:moveObject(_G["ReputationDetailFrame"], "+", 30, nil, nil)
	self:applySkin(_G["ReputationDetailFrame"])
	
	self:applySkin(_G["ReputationFrame"])

end

function Skinner:SkillFrame()

	self:removeRegions(_G["SkillFrame"])
	
	local xOfs, yOfs = 5, 20
	self:removeRegions(_G["SkillFrameExpandButtonFrame"])
	self:moveObject(_G["SkillFrameExpandButtonFrame"], "-", 57, "+", yOfs)
	self:moveObject(_G["SkillTypeLabel1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["SkillRankFrame1"], "-", xOfs, "+", yOfs)
	
	self:removeRegions(_G["SkillListScrollFrame"])
	self:moveObject(_G["SkillListScrollFrame"], "+", 35, "+", 20)
	self:skinScrollBar(_G["SkillListScrollFrame"])

	for i = 1, SKILLS_TO_DISPLAY do
		self:removeRegions(_G["SkillRankFrame"..i.."Border"], {1}) -- N.B. region 2 is highlight
		self:glazeStatusBar(_G["SkillRankFrame"..i], 0)
	end
	
	self:removeRegions(_G["SkillDetailScrollFrame"])
	self:applySkin(_G["SkillDetailScrollFrame"])
	self:skinScrollBar(_G["SkillDetailScrollFrame"])
	
	self:removeRegions(_G["SkillDetailStatusBar"], {1, 4, 5}) -- N.B. regions 2 & 3 are text
	self:glazeStatusBar(_G["SkillDetailStatusBar"], 0)
	
	self:moveObject(_G["SkillFrameCancelButton"], "-", 5, "+", 9)
	
	self:applySkin(_G["SkillFrame"])

end

function Skinner:HonorFrame()

	self:removeRegions(_G["HonorFrame"], {1, 2, 3, 4, 7, 8, 9, 10}) -- N.B. other regions are text
	local xOfs, yOfs = 5, 20
	self:moveObject(_G["HonorFrameCurrentPVPTitle"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["HonorFrameProgressBar"], "-", xOfs, "+", yOfs)
	self:glazeStatusBar(_G["HonorFrameProgressBar"], 0)
	self:moveObject(_G["HonorFrameCurrentSessionTitle"], "-", xOfs, "+", yOfs)

	self:applySkin(_G["HonorFrame"])

end

function Skinner:CharacterFrame_ShowSubFrame(frameName)
--  self:Debug("CF_SSF: [%s]", frameName)
	-- Character subframe names
	local cfSubframes = { "PaperDollFrame", "PetPaperDollFrame", "ReputationFrame", "SkillFrame", "HonorFrame" }
    self.hooks.CharacterFrame_ShowSubFrame(frameName)
    if self.db.profile.TexturedTab then
		-- change the texture for the Active and Inactive tabs
		for i, v in pairs(cfSubframes) do
    		if v == frameName then
    			self:setActiveTab("CharacterFrameTab"..i)
    		else
    			self:setInactiveTab("CharacterFrameTab"..i)
    		end
    	end
    end
	-- get frame and tab widths
    local frameWidth, tabWidths = self:CF_GetWidths()
	-- resize tabs if required
	if tabWidths > frameWidth and self.initialized.CF_SSF
	then self.initialized.CF_SSF = nil end

	if self.initialized.CF_SSF then return end

	self.initialized.CF_SSF = true
    self:CF_ResizeTabs(frameWidth / tabWidths)

end

function Skinner:CF_PetTab_Update()
--  self:Debug("CF_PetTab_Update")
    		
    self.hooks.PetTab_Update()
    -- check to see if the Pet Tab has been shown
	local point,relativeTo,relativePoint,xOfs,yOfs = _G["CharacterFrameTab3"]:GetPoint()
	if math.floor(xOfs) == -17 then
		self:moveObject(_G["CharacterFrameTab3"], "+", 11, nil, nil)
    	-- get frame and tab widths
        local frameWidth, tabWidths = self:CF_GetWidths() 
    	-- resize tabs if required
        if tabWidths > frameWidth then self:CF_ResizeTabs(frameWidth / tabWidths) end
    else
        self:CF_ResizeTabs(1)    
	end


end

function Skinner:CF_GetWidths()

    local fWidth = _G["CharacterFrame"]:GetWidth()
    local tWidths = 0

    for i = 1, table.getn(CHARACTERFRAME_SUBFRAMES) do
        tWidths = tWidths + _G["CharacterFrameTab"..i]:GetWidth()
    end
    
    -- if Pet not out then don't include its tab width
    if not HasPetUI() then
        tWidths = tWidths - _G["CharacterFrameTab2"]:GetWidth()
    end

--  self:Debug("CF_GW: [%s, %s]", math.floor(fWidth), math.floor(tWidths))

    return math.floor(fWidth), math.floor(tWidths)
    
end

function Skinner:CF_ResizeTabs(CFTxMult)
--  self:Debug("CF_ResizeTabs: [%s]", CFTxMult)
    
	for i = 1, table.getn(CHARACTERFRAME_SUBFRAMES) do
    	local tabName = _G["CharacterFrameTab"..i]
    	if CFTxMult == 1 then
            PanelTemplates_TabResize(0, tabName)
    	else
            tabName:SetWidth(tabName:GetWidth() * CFTxMult)
            local hlTexture = _G[tabName:GetName().."HighlightTexture"]
        	if ( hlTexture ) then
                hlTexture:SetWidth(tabName:GetWidth())
            end
        end
	end

end

function Skinner:PetStableFrame()
	if not self.db.profile.PetStableFrame or self.initialized.PetStableFrame then return end
	self.initialized.PetStableFrame = true

	self:removeRegions(_G["PetStableFrame"], {1, 2, 3, 4, 5})  -- N.B. regions 6-10 are text

	_G["PetStableFrame"]:SetWidth(_G["PetStableFrame"]:GetWidth() * FxMult)
	_G["PetStableFrame"]:SetHeight(_G["PetStableFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["PetStableFrameCloseButton"], "+", 28, "+", 8)
	
	_G["PetStableModelRotateLeftButton"]:Hide()
	_G["PetStableModelRotateRightButton"]:Hide()
	self:makeMFRotatable(_G["PetStableModel"])

	self:moveObject(_G["PetStableTitleLabel"], nil, nil, "+", 6)
	local xOfs, yOfs = 0, 60
	self:moveObject(_G["PetStableCurrentPet"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStableSlotText"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStableCostLabel"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStablePurchaseButton"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStableMoneyFrame"], "-", xOfs, "-", yOfs)

	-- move outside the Model Frame otherwise the tooltip doesn't work
	self:moveObject(_G["PetStablePetInfo"], nil, nil, "+", 90)

	self:applySkin(_G["PetStableFrame"])

end

local spellbooktypes = { BOOKTYPE_SPELL, BOOKTYPE_PET, nil}

function Skinner:SpellBookFrame()
	if not self.db.profile.SpellBookFrame or self.initialized.SpellBookFrame then return end
	self.initialized.SpellBookFrame = true

    if self.db.profile.TexturedTab then
    	-- hook to handle tabs
    	self:Hook("ToggleSpellBook", function(bookType)
--          self:Debug("ToggleSpellBook: [%s, %s]", bookType, SpellBookFrame.bookType)
    		local sbfbt = SpellBookFrame.bookType
    		self.hooks.ToggleSpellBook(bookType)
    		if sbfbt == bookType then return end
        	for i, v in pairs(spellbooktypes) do
--        		self:Debug("sbt : [%s]", v)
        		if v == bookType then 
        			self:setActiveTab("SpellBookFrameTabButton"..i) 
        		else 
        			self:setInactiveTab("SpellBookFrameTabButton"..i) 
        		end
    		end
    		end)
    end
		
	self:keepRegions(_G["SpellBookFrame"], {6, 7}) -- N.B. regions 6 & 7 are text
	
	_G["SpellBookFrame"]:SetWidth(_G["SpellBookFrame"]:GetWidth() * 0.9)
	_G["SpellBookFrame"]:SetHeight(_G["SpellBookFrame"]:GetHeight() * 0.84)

	self:moveObject(_G["SpellBookCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["SpellBookTitleText"], nil, nil, "-", 25)

	self:moveObject(_G["SpellBookPageText"], nil, nil, "-", 70)
	self:moveObject(_G["SpellBookPrevPageButton"], "-", 20, "-", 70)
	self:moveObject(_G["SpellBookNextPageButton"], nil, nil, "-", 70)
	
	for i = 1, SPELLS_PER_PAGE do
        self:removeRegions(_G["SpellButton"..i], {1})
        if i == 1 then self:moveObject(_G["SpellButton"..i], "-" , 10, "+", 20) end
        _G["SpellButton"..i.."SpellName"]:SetTextColor(HTr, HTg, HTb)        
        _G["SpellButton"..i.."SubSpellName"]:SetTextColor(BTr, BTg, BTb)        
    end
    
	for i = 1, MAX_SKILLLINE_TABS do
		local tabName = _G["SpellBookSkillLineTab"..i]
        self:removeRegions(tabName, {1}) -- N.B. other regions are icon and highlight
--      self:Debug("SBSLT: [%s, %s]", tabName:GetWidth(), tabName:GetHeight())
		tabName:SetWidth(tabName:GetWidth() * 1.25)
		tabName:SetHeight(tabName:GetHeight() * 1.25)
		if i == 1 then self:moveObject(tabName, "+", 28, nil, nil) end
        self:applySkin(tabName)
    end
    
    for i = 1, 3 do
    	local tabName = _G["SpellBookFrameTabButton"..i]
		self:keepRegions(tabName, {1, 3}) -- N.B. region 1 is the Text, 3 is the highlight
		tabName:SetWidth(tabName:GetWidth() * FTyMult)
		tabName:SetHeight(tabName:GetHeight() * FTxMult)
		local left, right, top, bottom = tabName:GetHitRectInsets()
--		self:Debug("SBFTB: [%s, %s, %s, %s, %s]", i, left, right, top, bottom)
		tabName:SetHitRectInsets(left * FTyMult, right * FTyMult, top * FTxMult, bottom * FTxMult)
        if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0)
		else self:applySkin(tabName) end
		if i == 1 then
			self:moveObject(tabName, "-", 18, "-", 70)
			if self.db.profile.TexturedTab then self:setActiveTab(tabName:GetName()) end
		else
			self:moveObject(tabName, "+", 15, nil, nil)
			if self.db.profile.TexturedTab then self:setInactiveTab(tabName:GetName()) end
		end

	end   

	self:applySkin( _G["SpellBookFrame"])
	
end

function Skinner:TalentFrame()
	if not self.db.profile.TalentFrame or self.initialized.TalentFrame then return end
	self.initialized.TalentFrame = true

	self:Hook("TalentFrame_Update", function()
--		self:Debug("TalentFrame_Update")
		self.hooks.TalentFrame_Update()
		for i = 1, MAX_TALENT_TABS do
			local tabName = _G["TalentFrameTab"..i]
			tabName:SetWidth(tabName:GetWidth() * FTyMult)
            if self.db.profile.TexturedTab then
    			if i == _G["TalentFrame"].selectedTab then
    				self:setActiveTab(tabName:GetName())
    			else
    				self:setInactiveTab(tabName:GetName())
    			end
            end
		end
		end)
		
	self:removeRegions(_G["TalentFrame"], {1, 2, 3, 4, 5, 11, 12, 13}) -- N.B. 6, 7, 8 & 9 are the background picture, 10, 14, 15 & 16 are text regions
	
	_G["TalentFrame"]:SetWidth(_G["TalentFrame"]:GetWidth() * FxMult)
	_G["TalentFrame"]:SetHeight(_G["TalentFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["TalentFrameTitleText"], nil, nil, "+", 6)
	self:moveObject(_G["TalentFrameCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["TalentFrameSpentPoints"], "-", 35, "+", 15)
	self:moveObject(_G["TalentFrameTalentPointsText"], "-", 10, "-", 70)
	self:moveObject(_G["TalentFrameBackgroundTopLeft"], "-", 10, "+", 15)
	
	self:removeRegions(_G["TalentFrameScrollFrame"])
	self:moveObject(_G["TalentFrameScrollFrame"], "+", 35, "+", 15)
	self:skinScrollBar(_G["TalentFrameScrollFrame"])

	self:moveObject(_G["TalentFrameCancelButton"], "-", 10, "+", 8)
	
    for i=1,MAX_TALENT_TABS do
		local tabName = _G["TalentFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		tabName:SetWidth(tabName:GetWidth() * FTyMult)
        if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0)
        else self:applySkin(_G["TalentFrameTab"..i]) end
		if i == 1 then
			self:moveObject(tabName, "-", 8, "-", 71)
			if self.db.profile.TexturedTab then self:setActiveTab(tabName:GetName()) end 
		else
			self:moveObject(tabName, "+", 10, nil, nil)
			if self.db.profile.TexturedTab then self:setInactiveTab(tabName:GetName()) end 
		end
		 
	end   

	self:applySkin(_G["TalentFrame"])

end

function Skinner:DressUpFrame()
	if not self.db.profile.DressUpFrame or self.initialized.DressUpFrame then return end
	self.initialized.DressUpFrame = true

	self:removeRegions(_G["DressUpFrame"], {1, 2, 3, 4, 5}) -- N.B. regions 6 & 7 are text, 8- 11 are the background picture
	_G["DressUpFrame"]:SetWidth(_G["DressUpFrame"]:GetWidth() * FxMult)
	_G["DressUpFrame"]:SetHeight(_G["DressUpFrame"]:GetHeight() * FyMult)

	_G["DressUpModelRotateLeftButton"]:Hide()
	_G["DressUpModelRotateRightButton"]:Hide()
	self:makeMFRotatable(_G["DressUpModel"])
	
	self:moveObject(_G["DressUpFrameTitleText"], nil, nil, "+", 6)
	self:moveObject(_G["DressUpFrameDescriptionText"], nil, nil, "+", 6)
	self:moveObject(_G["DressUpFrameCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["DressUpBackgroundTopLeft"], "-", 8, "+", 15)
	self:moveObject(_G["DressUpModel"], nil, nil, "-", 60)
	self:moveObject(_G["DressUpFrameCancelButton"], "-", 6, "+", 10)
	
	self:applySkin(_G["DressUpFrame"])

end
