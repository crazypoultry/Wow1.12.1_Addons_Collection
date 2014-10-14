
function Skinner:BlizzardFrames()
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

function Skinner:AddonFrames()
	-- self:Debug("AddonFrames")
	
	-- only need to do this once
	if self.initialized.AddonFrames then return end
	self.initialized.AddonFrames = true

	-- used for Addons that aren't LoadOnDemand
	if self:checkAddOn("BugSack") then self:BugSack() end
	if self:checkAddOn("OneBag") then self:OneBag() end
	if self:checkAddOn("OneBank") then self:OneBank() end
	if self:checkAddOn("GMail") then self:GMail() end
	if self:checkAddOn("CT_MailMod") then self:CT_MailMod() end
	if self:checkAddOn("EnhancedStackSplit") then self:EnhancedStackSplit() end
	if self:checkAddOn("CT_RaidAssist") then self:CT_RaidAssist() end
    if self:checkAddOn("SuperInspect_UI") then self:SuperInspect_UI() end
	if self:checkAddOn("MCP") then self:MCP() end
	if self:checkAddOn("MyBags") then self:MyBags() end
	if self:checkAddOn("EquipCompare") then self:EquipCompare() end
	if self:checkAddOn("AxuItemMenus") then self:AxuItemMenus() end
	if self:checkAddOn("EnhancedTradeSkills") then self:EnhancedTradeSkills() self:EnhancedTradeCrafts() end
	if self:checkAddOn("AutoProfit") then self:AutoProfit() end
	if self:checkAddOn("FuBar_GarbageFu") then self:FuBar_GarbageFu() end
	if self:checkAddOn("MetaMap") then self:MetaMap() end
	if self:checkAddOn("FramesResized_QuestLog") then self:FramesResized_QuestLog() end
	if self:checkAddOn("FramesResized_LootFrame") then self:FramesResized_LootFrame() end
	if self:checkAddOn("LootLink") then self:LootLink() end
	if self:checkAddOn("Possessions") then self:Possessions() end
	if self:checkAddOn("EQL3") then self:EQL3() else self:QuestLog() end
	if self:checkAddOn("BattleChat") then self:BattleChat() end
	if self:checkAddOn("KombatStats") then self:KombatStats()	end
	if self:checkAddOn("FruityLoots") then self:FruityLoots() end
	if self:checkAddOn("ItemSync") then self:ItemSync() end
	if self:checkAddOn("oCD") then self:oCD() end
	if self:checkAddOn("GotWood") then self:GotWood() end
	if self:checkAddOn("aftt_extreme") then self:aftt_extreme() end
	if self:checkAddOn("EasyUnlock") then self:EasyUnlock() end
    if self:checkAddOn("SuperMacro") then self:SuperMacro() end
    if self:checkAddOn("MailTo") then self:MailTo() end
    if self:checkAddOn("HoloFriends") then self:HoloFriends() end
    if self:checkAddOn("PVPCooldown") then self:PVPCooldown() end
    if self:checkAddOn("PVPCooldownReborn") then self:PVPCooldown() end
    if self:checkAddOn("BuyPoisons") then self:BuyPoisons() end		
    if self:checkAddOn("KLHThreatMeter") then self:KLHThreatMeter() end
    if self:checkAddOn("IgorsMassAuction") then self:IgorsMassAuction() self:AuctionFrame() end
	if self:checkAddOn("myBindings") then self:myBindings() end
	if self:checkAddOn("GCInfo") then self:GCInfo() end
	if self:checkAddOn("Outfitter") then self:Outfitter() end
	if self:checkAddOn("UberQuest") then self:UberQuest() end
	if self:checkAddOn("CharactersViewer") then self:CharactersViewer() end
	if self:checkAddOn("AdvancedTradeSkillWindow") then self:AdvancedTradeSkillWindow() end
	if self:checkAddOn("EavesDrop") then self:EavesDrop() end
	if self:checkAddOn("Clique") then self:Clique() end
	if self:checkAddOn("DepositBox") then self:DepositBox() end
	if self:checkAddOn("AuctionFilterPlus") then self:AuctionFilterPlus() end
	if self:checkAddOn("MonkeyQuest") then self:MonkeyQuest()	end
	if self:checkAddOn("MonkeyQuestLog") then self:MonkeyQuestLog()	end

	-- handle Addons with odd names here
    if IsAddOnLoaded("!ImprovedErrorFrame") and type(self["ImprovedErrorFrame"]) == "function" then self:ImprovedErrorFrame() end
	if IsAddOnLoaded("Auto-Bag") and type(self["AutoBag"]) == "function" then self:AutoBag() end

	

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

function Skinner:LoDFrames(arg1)
	-- self:Debug("LoDFrames: [%s]", arg1)

	if arg1 == prev_arg1 then return end
	prev_arg1 = arg1
	
	-- used for LoadOnDemand Addons
	if arg1 == "Blizzard_RaidUI" then self:RaidUI() end
	if arg1 == "Blizzard_MacroUI" then self:MacroFrame() end
	if arg1 == "Blizzard_BindingUI" then self:KeyBindingFrame() end
	if arg1 == "Blizzard_InspectUI" then self:InspectFrame() end
	if arg1 == "Blizzard_AuctionUI" then self:AuctionFrame() end
	if arg1 == "Blizzard_AuctionUI" and self:checkAddOn("Auctioneer") then self:Auctioneer() end
	if arg1 == "Blizzard_TrainerUI" then self:ClassTrainer() end
	if arg1 == "Blizzard_TradeSkillUI" then self:TradeSkill() end
	if arg1 == "Blizzard_CraftUI" then self:CraftFrame() end
	if arg1 == "Blizzard_TalentUI" then self:TalentFrame() end
	if arg1 == "Blizzard_GMSurveyUI" then self:GMSurveyUI() end
	
	-- ignore the addon if required to by the user
	if not self:checkAddOn(arg1) then return end
	
 	if arg1 == "Bagnon"  then self:Bagnon() end
	if arg1 == "Banknon" then self:Banknon() end
	if arg1 == "SuperInspect_UI" then self:SuperInspectFrame() end
	if arg1 == "FramesResized_TradeSkillUI" then self:FramesResized_TradeSkillUI() end
	if arg1 == "FramesResized_CraftUI" then self:FramesResized_CraftUI() end
    if arg1 == "FramesResized_TrainerUI" then self:FramesResized_TrainerUI() end
	if arg1 == "GFW_AutoCraft" then self:GFW_AutoCraft() end
	if arg1 == "SpecialTalentUI" then self:SpecialTalentUI() end
	if arg1 == "FilterTradeSkill" then self:FilterTradeSkill() end
	

end

function Skinner:AceEvent_FullyInitialized()

	self:RegisterEvent("ADDON_LOADED")
	
	self:ScheduleEvent(self.BlizzardFrames, self.db.profile.Delay.Init, self)
	self:ScheduleEvent(self.AddonFrames, self.db.profile.Delay.Init + self.db.profile.Delay.Addons + 0.1, self)

end

function Skinner:ADDON_LOADED(arg1)
	-- self:Debug("ADDON_LOADED: [%s]", arg1)
 
	self:ScheduleEvent(self.LoDFrames, self.db.profile.Delay.LoDs, self, arg1)
  
end

local tabletsSkinned = {}

function Skinner:Skin_Tablet()
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
				self.tfade:SetGradientAlpha(unpack(Skinner.db.profile.Gradient and gradientOn or gradientOff)) 
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
				self.tfade:SetGradientAlpha(unpack(Skinner.db.profile.Gradient and gradientOn or gradientOff)) 
			end
			frame:SetBackdropColor(r,g,b,a)
			frame:SetBackdropBorderColor(1,1,1,a)
		end
		i = i + 1
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -math.ceil(frame:GetHeight()))
	end
end

function Skinner:ViewPort()
	if not self.db.profile.ViewPort.shown or self.initialized.ViewPort then return end
	self.initialized.ViewPort = true

	WorldFrame:SetPoint("TOPLEFT", 0, -(self.db.profile.ViewPort.top * self.db.profile.ViewPort.scaling))
	WorldFrame:SetPoint("BOTTOMRIGHT", -0, (self.db.profile.ViewPort.bottom * self.db.profile.ViewPort.scaling))
	
	if self.db.profile.ViewPort.overlay then
		ViewportOverlay = WorldFrame:CreateTexture(nil, "BACKGROUND")
		ViewportOverlay:SetTexture(self.db.profile.ViewPort.r or 0, self.db.profile.ViewPort.g or 0, self.db.profile.ViewPort.b or 0, ba or self.db.profile.ViewPort.a or 1)
		ViewportOverlay:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -1, 1)
		ViewportOverlay:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 1, -1)
	end
	
end

function Skinner:ViewPort_top()
	if not self.db.profile.ViewPort.shown then return end

	WorldFrame:SetPoint("TOPLEFT", 0, -(self.db.profile.ViewPort.top * self.db.profile.ViewPort.scaling))
	
end

function Skinner:ViewPort_bottom()
	if not self.db.profile.ViewPort.shown then return end

	WorldFrame:SetPoint("BOTTOMRIGHT", -0, (self.db.profile.ViewPort.bottom * self.db.profile.ViewPort.scaling))
	
end

function Skinner:ViewPort_reset()

	self.initialized.ViewPort = nil
    WorldFrame:SetPoint("TOPLEFT", 0, -0)
	WorldFrame:SetPoint("BOTTOMRIGHT", -0, 0)
	
end

function Skinner:TopFrame()
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
	
	self:applySkin(frame, 1, nil, nil, self.db.profile.TopFrame.fheight)
	
end

function Skinner:BottomFrame()
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
	
	self:applySkin(frame, 1, nil, nil, self.db.profile.BottomFrame.fheight)

end
