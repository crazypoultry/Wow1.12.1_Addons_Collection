
function oSkin:BlizzardFrames()
	-- self:Debug("BlizzardFrames")

	-- only need to do this once
	if self.initialized.BlizzardFrames then return end
	self.initialized.BlizzardFrames = true

	self:characterFrames()
	self:PetStableFrame()
	self:SpellBookFrame()
	self:DressUpFrame()
	self:FriendsFrame()
	self:TradeFrame()
--	self:QuestLog() -- checked with EQL3 below

	self:Tooltips()
	self:MirrorTimers()
	self:QuestTimers()
	self:CastingBar()
	self:StaticPopups()
	self:ChatFrames()
	self:ChatTabs()
	self:ChatEditBox()
	self:LootFrame()
	self:GroupLoot()
	self:containerFrames()
	self:StackSplit()
	self:ItemText()
	self:WorldMap()
	self:ColorPicker()
	self:HelpFrame()
	self:MainMenuBar()
	self:CoinPickup()

	self:menuFrames()
	self:BankFrame()
	self:MailFrame()
	self:makeModelFramesRotatable()
	
	self:merchantFrames()
	self:GossipFrame()
	self:TaxiFrame()
	self:QuestFrame()
	self:Battlefields()
	self:GuildRegistrar()
	self:Petition()
	self:Tabard()

	self:ViewPort()
	self:TopFrame()
    self:BottomFrame()
    
	--	Skin the ScriptErrors Frame 
    self:applySkin(_G["ScriptErrors"])
	-- skin the Tutorial Frame
	self:applySkin(_G["TutorialFrame"])

end

function oSkin:AddonFrames()
	-- self:Debug("AddonFrames")
	
	-- only need to do this once
	if self.initialized.AddonFrames then return end
	self.initialized.AddonFrames = true

	-- used for Addons that aren't LoadOnDemand
	if IsAddOnLoaded("BugSack") then self:applySkin(_G["BugSackFrame"], nil, nil, nil, 200) end
	if IsAddOnLoaded("OneBag") then self:Skin_OneBag() end
	if IsAddOnLoaded("OneBank") then self:Skin_OneBank() end
	if IsAddOnLoaded("GMail") then self:GMail() end
	if IsAddOnLoaded("CT_MailMod") then self:CT_MailMod() end
	if IsAddOnLoaded("EnhancedStackSplit") then self:EnhancedStackSplit() end
	if IsAddOnLoaded("CT_RaidAssist") then self:CTRA() end
    if IsAddOnLoaded("SuperInspect_UI") then self:SuperInspectFrame() end
	if IsAddOnLoaded("MCP") then self:Skin_MCP() end
	if IsAddOnLoaded("MyBags") then self:applySkin(_G["MyBankFrame"]) self:applySkin(_G["MyInventoryFrame"]) end
	if IsAddOnLoaded("EquipCompare") and self.db.profile.Tooltips then self:skinTooltip(ComparisonTooltip1) self:skinTooltip(ComparisonTooltip2) end
	if IsAddOnLoaded("AxuItemMenus") and self.db.profile.Tooltips then self:skinTooltip(ItemMenuTooltip) end
	if IsAddOnLoaded("EnhancedTradeSkills") then self:Skin_EnhancedTradeSkills() self:Skin_EnhancedTradeCrafts() end
	if IsAddOnLoaded("AutoProfit") then self:AutoProfit() end
	if IsAddOnLoaded("FuBar_GarbageFu") then self:FuBar_GarbageFu() end
	if IsAddOnLoaded("MetaMap") then self:MetaMap() end
	if IsAddOnLoaded("FramesResized_QuestLog") then self:FramesResized_QuestLog() end
	if IsAddOnLoaded("LootLink") then self:LootLink() end
	if IsAddOnLoaded("Possessions") then self:Possessions() end
	if IsAddOnLoaded("EQL3") then self:EQL3Frame() else self:QuestLog() end
	if IsAddOnLoaded("BattleChat") then self:BattleChat() end
	if IsAddOnLoaded("KombatStats") then self:KombatStats()	end
	if IsAddOnLoaded("FruityLoots") and self.db.profile.LootFrame then self:Hook(FruityLoots ,"LootFrame_SetPoint", "FruityLoots_LF_SetPoint") end
	if IsAddOnLoaded("FramesResized_LootFrame") then self:FramesResized_LootFrame() end
	if IsAddOnLoaded("ItemSync") then self:ItemSync() end
	if IsAddOnLoaded("oCD") then self:applySkin(_G["oCDFrame"]) end
	if IsAddOnLoaded("GotWood") then self:applySkin(_G["GotWoodFrame"]) end
	if IsAddOnLoaded("aftt_extreme") then self:Skin_aftte() end
	if IsAddOnLoaded("EasyUnlock") then self:EasyUnlock() end
    if IsAddOnLoaded("!ImprovedErrorFrame") then self:ImprovedErrorFrame() end
    if IsAddOnLoaded("SuperMacro") then self:Skin_SuperMacro() end
    if IsAddOnLoaded("MailTo") then self:Skin_MailTo() end
    if IsAddOnLoaded("HoloFriends") then self:Skin_HoloFriends() end
    if IsAddOnLoaded("PVPCooldown") then self:applySkin(PVPCooldownFrame) end
    if IsAddOnLoaded("BuyPoisons") then self:Skin_BuyPoisons() end		
    if IsAddOnLoaded("Auctioneer") then self:Auctioneer() end
    if IsAddOnLoaded("KLHThreatMeter") then self:KLHThreatMeter() end
    if IsAddOnLoaded("IgorsMassAuction") then self:IgorsMassAuction() self:AuctionFrame() self:makeMFRotatable(_G["AuctionDressUpModel"]) end
	if IsAddOnLoaded("myBindings") then self:myBindings() end
	if IsAddOnLoaded("GCInfo") then self:applySkin(GCInfoFrame) end
	if IsAddOnLoaded("Outfitter") then self:Outfitter() end
	if IsAddOnLoaded("UberQuest") then self:UberQuest() end
	if IsAddOnLoaded("CharactersViewer") then self:CharactersViewer() end
	if IsAddOnLoaded("AdvancedTradeSkillWindow") then self:ATSW() end
	if IsAddOnLoaded("Auto-Bag") then self:AutoBag() end

	-- skin TabletLib frames
	if AceLibrary:HasInstance("Tablet-2.0") then
		self:Hook(AceLibrary("Tablet-2.0"), "Open", function(tablet, parent)
			-- self:Debug("Open Tablet: [%s] ", parent:GetName())
			local ret = self.hooks[tablet].Open(tablet, parent)
			self:Skin_Tablet()
			return ret
			end)
		self:Hook(AceLibrary("Tablet-2.0"), "Detach", function(tablet, parent)
			-- self:Debug("Detach Tablet: [%s]", parent:GetName())
			local ret = self.hooks[tablet].Detach(tablet, parent)
			self:Skin_Tablet()
			return ret
			end)
		self:Skin_Tablet()
	end
	
end

function oSkin:LoDFrames(arg1)
	-- self:Debug("LoDFrames; [%s]", arg1)
	
	-- used for LoadOnDemand Addons
	if arg1 == "Blizzard_RaidUI" then self:RaidUI() end
	if arg1 == "Blizzard_MacroUI" then self:MacroFrame() end
	if arg1 == "Blizzard_BindingUI" then self:KeyBindingFrame() end
	if arg1 == "Blizzard_InspectUI" then self:InspectFrame() self:makeMFRotatable(_G["InspectModelFrame"]) end
	if arg1 == "Blizzard_AuctionUI" then self:AuctionFrame() self:makeMFRotatable(_G["AuctionDressUpModel"]) end
	if arg1 == "Blizzard_TrainerUI" then self:ClassTrainer() end
	if arg1 == "Blizzard_TradeSkillUI" then self:TradeSkill() end
	if arg1 == "Blizzard_CraftUI" then self:CraftFrame() end
	if arg1 == "Blizzard_TalentUI" then self:TalentFrame() end
	if arg1 == "Blizzard_GMSurveyUI" then self:GMSurveyUI() end
 	if arg1 == "Bagnon" and self.db.profile.ContainerFrames then self:applySkin(Bagnon) end
	if arg1 == "Banknon" and self.db.profile.ContainerFrames then self:applySkin(Banknon) end
	if arg1 == "SuperInspect_UI" then self:SuperInspectFrame() end
	if arg1 == "FramesResized_TradeSkillUI" then self:FramesResized_TradeSkillUI() end
	if arg1 == "FramesResized_CraftUI" then self:FramesResized_CraftUI() end
    if arg1 == "FramesResized_TrainerUI" then self:FramesResized_TrainerUI() end
	if arg1 == "GFW_AutoCraft" then self:GFW_AutoCraft() end
    if arg1 == "Auctioneer" then self:Auctioneer() end

end

function oSkin:AceEvent_FullyInitialized()

	self:RegisterEvent("ADDON_LOADED")
	
	self:ScheduleEvent(self.BlizzardFrames, self.db.profile.Delay.Init, self)
	self:ScheduleEvent(self.AddonFrames, self.db.profile.Delay.Init + self.db.profile.Delay.Addons + 0.1, self)

end

function oSkin:ADDON_LOADED(arg1)
	-- self:Debug("ADDON_LOADED: [%s]", arg1)
    
	self:ScheduleEvent(self.LoDFrames, self.db.profile.Delay.LoDs, self, arg1)
  
end

local tabletsSkinned = {}

function oSkin:Skin_Tablet()
	if not self.db.profile.Tooltips then return end
	
	if _G["Tablet20Frame"] then
		-- self:Debug("Tablet20Frame")
		local frame = _G["Tablet20Frame"]
		if not tabletsSkinned["Tablet20Frame"] then
			tabletsSkinned["Tablet20Frame"] = true
			local r,g,b,a = frame:GetBackdropColor()
			self:applySkin(frame)
			local old_SetBackdropColor = frame.SetBackdropColor
			function frame:SetBackdropColor(r,g,b,a)
				old_SetBackdropColor(self,r,g,b,a)
				self.tfade:SetGradientAlpha(unpack(oSkin.db.profile.Gradient and gradientOn or gradientOff)) 
			end
			frame:SetBackdropColor(r,g,b,a)
			frame:SetBackdropBorderColor(1,1,1,a)
		end
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -math.ceil(frame:GetHeight()))
	end
	local i = 1
	while _G["Tablet20DetachedFrame" .. i] do
		-- self:Debug("Tablet20DetachedFrame"..i)
		local frame = _G["Tablet20DetachedFrame"..i]
		if not tabletsSkinned["Tablet20DetachedFrame" .. i] then
			tabletsSkinned["Tablet20DetachedFrame" .. i] = true
			local r,g,b,a = frame:GetBackdropColor()
			self:applySkin(frame)
			local old_SetBackdropColor = frame.SetBackdropColor
			function frame:SetBackdropColor(r,g,b,a)
				old_SetBackdropColor(self,r,g,b,a)
				self.tfade:SetGradientAlpha(unpack(oSkin.db.profile.Gradient and gradientOn or gradientOff)) 
			end
			frame:SetBackdropColor(r,g,b,a)
			frame:SetBackdropBorderColor(1,1,1,a)
		end
		i = i + 1
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -math.ceil(frame:GetHeight()))
	end
end

function oSkin:ViewPort()
	if not self.db.profile.ViewPort.shown or self.initialized.ViewPort then return end
	self.initialized.ViewPort = true

	WorldFrame:SetPoint("TOPLEFT", 0, -(self.db.profile.ViewPort.top * self.db.profile.ViewPort.scaling))
	WorldFrame:SetPoint("BOTTOMRIGHT", -0, (self.db.profile.ViewPort.bottom * self.db.profile.ViewPort.scaling))
	
	if self.db.profile.ViewPort.overlay then
		ViewportOverlay = WorldFrame:CreateTexture(nil, "BACKGROUND")
		ViewportOverlay:SetTexture(0, 0, 0, 1)
		ViewportOverlay:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -1, 1)
		ViewportOverlay:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 1, -1)
	end
	
end

function oSkin:ViewPort_top()
	if not self.db.profile.ViewPort.shown then return end

	WorldFrame:SetPoint("TOPLEFT", 0, -(self.db.profile.ViewPort.top * self.db.profile.ViewPort.scaling))
	
end

function oSkin:ViewPort_bottom()
	if not self.db.profile.ViewPort.shown then return end

	WorldFrame:SetPoint("BOTTOMRIGHT", -0, (self.db.profile.ViewPort.bottom * self.db.profile.ViewPort.scaling))
	
end

function oSkin:ViewPort_reset()

	self.initialized.ViewPort = nil
    WorldFrame:SetPoint("TOPLEFT", 0, -0)
	WorldFrame:SetPoint("BOTTOMRIGHT", -0, 0)
	
end

function oSkin:TopFrame()
	if not self.db.profile.TopFrame.shown or self.initialized.TopFrame then return end
	self.initialized.TopFrame = true

	local frame = CreateFrame("Frame", "TopFrame", UIParent)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetFrameLevel(0)
	frame:EnableMouse(false)
	frame:SetMovable(false)
	frame:SetWidth(self.db.profile.TopFrame.width or 1920)
	frame:SetHeight(self.db.profile.TopFrame.height or 100)
	frame:ClearAllPoints()
	if self.db.profile.TopFrame.xyOff then 
		frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -6, 6)
	else
		frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -3, 3)
	end
	self.topframe = frame
	
	oSkin:applySkin(frame, 1, nil, nil, self.db.profile.TopFrame.fheight)
	
end

function oSkin:BottomFrame()
	if not self.db.profile.BottomFrame.shown or self.initialized.BottomFrame then return end
	  self.initialized.BottomFrame = true

	local frame = CreateFrame("Frame", "BottomFrame", UIParent)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetFrameLevel(0)
	frame:EnableMouse(false)
	frame:SetMovable(false)
	frame:SetWidth(self.db.profile.BottomFrame.width or 1920)
	frame:SetHeight(self.db.profile.BottomFrame.height or 200)
	frame:ClearAllPoints()
	if self.db.profile.BottomFrame.xyOff then 
		frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -6, -6)
	else
		frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -3, -3)
	end
	
	self.bottomframe = frame
	
	oSkin:applySkin(frame, 1, nil, nil, self.db.profile.BottomFrame.fheight)

end
