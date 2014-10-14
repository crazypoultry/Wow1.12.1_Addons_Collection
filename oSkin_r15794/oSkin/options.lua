local self = oSkin

function oSkin:Defaults()
	self:RegisterDefaults("profile", {
		-- Colours
		BackdropBorder	= {r = 0.5, g = 0.5, b = 0.5, a = 1},
		Backdrop		= {r = 0, g = 0, b = 0, a = 0.9},
		HeadText		= {r = 0.8, g = 0.8, b = 0.0},
		BodyText		= {r = 0.7, g = 0.7, b = 0.0},
		-- Other
		TexturedTab     = false,
		Gradient		= true,
		FadeHeight		= {enable = false, value = 500, force = false},
		Delay			= {Init = 0.5, Addons = 0.5, LoDs = 0.5},
		ViewPort		= {top = 64, bottom=64, YResolution=1050, scaling = 768/1050, shown=false, overlay=false},
		TopFrame		= {height = 64, width=1920, shown=false, fheight=50, xyOff = true},
		BottomFrame		= {height = 200, width=1920, shown=false, fheight=50, xyOff = true},
		-- Character Frames
		CharacterFrames = true,
		SpellBookFrame  = true,
		TalentFrame		= true,
		DressUpFrame    = true,
		FriendsFrame	= true,
		TradeSkill		= true,
		CraftFrame		= true,
		TradeFrame		= true,
		QuestLog		= true,
		RaidUI			= true,
		-- UI Frames
		Tooltips		= {shown = true, style = 1},
		MirrorTimers	= true,
		CastingBar		= true,
		StaticPopups	= true,
		ChatTabs		= false,
		ChatFrames		= false,
		ChatEditBox		= true,
		LootFrame		= true,
		GroupLoot		= {shown = true, size = 1},
		ContainerFrames	= true,
		StackSplit		= true,
		ItemText		= true,
		Colours			= true,
		WorldMap		= true,
		MainMenuBar     = true,
		CoinPickup		= true,
		GMSurveyUI		= true,
		Inspect			= true,
		MenuFrames		= true,
		BankFrame       = true,
		MailFrame		= true,
		AuctionFrame	= true,
		-- NPC Frames
		MerchantFrames	= true,
		GossipFrame		= true,
		ClassTrainer	= true,
		PetStableFrame	= true,
		TaxiFrame		= true,
		QuestFrame		= true,
		Battlefields	= true,
		GuildRegistrar	= true,
		Petition		= true,
		Tabard			= true,
	})
	
end

local function CPF_UpdateRGB()
	-- self:Debug("CPF_UpdateRGB")
	
	local r, g, b = ColorPickerFrame:GetColorRGB()
    self.db.profile[dbkey].r = string.format("%0.2f", r)
    self.db.profile[dbkey].g = string.format("%0.2f", g)
    self.db.profile[dbkey].b = string.format("%0.2f", b)

end

local function CPF_UpdateAlpha()
	-- self:Debug("CPF_UpdateAlpha")
	
    local a = OpacitySliderFrame:GetValue()
    self.db.profile[dbkey].a = string.format("%0.2f", a)
    
end

local function CPF_Revert(previousValues)
	-- self:Debug("CPF_Revert: [%s, %s, %s, %s]", previousValues.r, previousValues.g, previousValues.b, previousValues.opacity)
	
    self.db.profile[dbkey].r = previousValues.r
    self.db.profile[dbkey].g = previousValues.g
    self.db.profile[dbkey].b = previousValues.b
    self.db.profile[dbkey].a = previousValues.opacity

end


function oSkin:GetRGBA(element)
	-- self:Debug("GetRGBA: [%s]", element)
	
	dbkey = element
	
	ColorPickerFrame.func = CPF_UpdateRGB
    if self.db.profile[dbkey].a then 
    	ColorPickerFrame.hasOpacity = 1
    	ColorPickerFrame.opacityFunc = CPF_UpdateAlpha
    	ColorPickerFrame.opacity = self.db.profile[dbkey].a
    else
    	ColorPickerFrame.hasOpacity = nil
    end
    ColorPickerFrame:SetColorRGB(self.db.profile[dbkey].r, self.db.profile[dbkey].g, self.db.profile[dbkey].b)
    ColorPickerFrame.previousValues = {r = self.db.profile[dbkey].r, g = self.db.profile[dbkey].g, b = self.db.profile[dbkey].b, opacity = self.db.profile[dbkey].a}
    ColorPickerFrame.cancelFunc = CPF_Revert
    ShowUIPanel(ColorPickerFrame)

end

function oSkin:Options()
	oSkin.options = {
		type = "group",
		args = {
			cp = {
				name = "Default Colours",
				desc = "Change the default colour settings",
				type = "group",
				args = {
					border = {
						name = "Border Colors",
						desc = "Set Backdrop Border Colors",
						type = "execute",
						func = function(v) self:GetRGBA("BackdropBorder") end,
					},
					backdrop = {
						name = "Backdrop Colors",
						desc = "Set Backdrop Colors",
						type = "execute",
						func = function(v) self:GetRGBA("Backdrop") end,
					},
					headtext = {
						name = "Text Heading Colors",
						desc = "Set Text Heading Colors",
						type = "execute",
						func = function(v) self:GetRGBA("HeadText") end,
					},
					bodytext = {
						name = "Text Body Colors",
						desc = "Set Text Body Colors",
						type = "execute",
						func = function(v) self:GetRGBA("BodyText") end,
					},
				},
			},
			texturedtab = {
				name = "Textured Tab",
				desc = "Toggle the Texture of the Tabs",
				type = "toggle",
				get = function()
					return self.db.profile.TexturedTab
				end,
				set = function(v)
					self.db.profile.TexturedTab = v
				end,
			},
			gradient = {
				name = "Gradient Effect",
				desc = "Toggle the Gradient Effect",
				type = "toggle",
				get = function()
					return self.db.profile.Gradient
				end,
				set = function(v)
					self.db.profile.Gradient = v
				end,
			},
			fadeheight = {
				name = "Fade Height",
				desc = "Change the Fade Height settings",
				type = "group",
				args = {
					enable = {
						name = "Global Fade Height",
						desc = "Toggle the Global Fade Height on/off",
						type = "toggle",
						get = function()
							return self.db.profile.FadeHeight.enable
						end,
						set = function (v)
							self.db.profile.FadeHeight.enable = v
						end,
					},
					value = {
						name = "Fade Height value",
						desc = "Change the Height of the Fade Effect",
						type = "range",
						step = 1,
						min = 0,
						max = 1000,
						get = function()
							return self.db.profile.FadeHeight.value
						end,
						set = function (v)
							self.db.profile.FadeHeight.value = v
						end,
					},
					force = {
						name = "Force the Global Fade Height",
						desc = "Force ALL Frame Fade Height's to be Global",
						type = "toggle",
						get = function()
							return self.db.profile.FadeHeight.force
						end,
						set = function (v)
							self.db.profile.FadeHeight.force = v
						end,
					},
				},
			},
			delay = {
				name = "Skinning Delays",
				desc = "Change the Skinning Delays settings",
				type = "group",
				args = {
					init = {
						name = "Initial Delay",
						desc = "Set the Delay before Skinning Blizzard Frames",
						type = "range",
						step = 0.5,
						min = 0,
						max = 10,
						get = function()
							return self.db.profile.Delay.Init
						end,
						set = function (v)
							self.db.profile.Delay.Init = v
						end,
					},
					addons = {
						name = "Addons Delay",
						desc = "Set the Delay before Skinning Addons Frames",
						type = "range",
						step = 0.5,
						min = 0,
						max = 10,
						get = function()
							return self.db.profile.Delay.Addons
						end,
						set = function (v)
							self.db.profile.Delay.Addons = v
						end,
					},
					lods = {
						name = "LoD Addons Delay",
						desc = "Set the Delay before Skinning Load on Demand Frames",
						type = "range",
						step = 0.5,
						min = 0,
						max = 10,
						get = function()
							return self.db.profile.Delay.LoDs
						end,
						set = function (v)
							self.db.profile.Delay.LoDs = v
						end,
					},
				},
			},
			viewport = {
				name = "View Port",
				desc = "Change the ViewPort settings",
				type = "group",
				args = {
					top = {
						name = "VP Top",
						desc = "Change Height of the Top Band",
						type = "range",
						step = 1,
						min = 0,
						max = 256,
						get = function ()
							return self.db.profile.ViewPort.top
						end,
						set = function (v)
							self.db.profile.ViewPort.top = v
							self:ViewPort_top()
						end,
					},
					bottom = {
						name = "VP Bottom",
						desc = "Change Height of the Bottom Band",
						type = "range",
						step = 1,
						min = 0,
						max = 256,
						get = function ()
							return self.db.profile.ViewPort.bottom
						end,
						set = function (v)
							self.db.profile.ViewPort.bottom = v
							self:ViewPort_bottom()
						end,
					},
					yres = {
						name = "VP YResolution",
						desc = "Change Y Resolution",
						type = "range",
						step = 2,
						min = 0,
						max = 1600,
						get = function ()
							return self.db.profile.ViewPort.YResolution
						end,
						set = function (v)
							self.db.profile.ViewPort.YResolution = v
							self.db.profile.ViewPort.scaling = 768 / self.db.profile.ViewPort.YResolution
				            self.initialized.ViewPort = nil
				            self:ViewPort()
						end,
					},
					show = {
						name = "ViewPort Show",
						desc = "Toggle the ViewPort on/off",
						type = "toggle",
						get = function()
							return self.db.profile.ViewPort.shown
						end,
						set = function (v)
							self.db.profile.ViewPort.shown = v
							if self.initialized.ViewPort then
                                self:ViewPort_reset()
							else
								self:ViewPort()						
							end
						end,
					},
					overlay = {
						name = "ViewPort Overlay",
						desc = "Toggle the ViewPort Overlay",
						type = "toggle",
						get = function()
							return self.db.profile.ViewPort.overlay
						end,
						set = function (v)
							self.db.profile.ViewPort.overlay = v
			            	self.initialized.ViewPort = nil
							self:ViewPort()
						end,
					},
				},
			},
			topframe = {
				name = "Top Frame",
				desc = "Change the TopFrame settings",
				type = "group",
				args = {
					xyOff = {
						name = "TF Move Origin offscreen",
						desc = "Hide Border on Left and Top",
						type = "toggle",
						get = function ()
							return self.db.profile.TopFrame.xyOff
						end,
						set = function (v)
							self.db.profile.TopFrame.xyOff = v
							if self.initialized.TopFrame then
								if self.db.profile.TopFrame.xyOff then 
									self.topframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -6, 6)
								else
									self.topframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -3, 3)
								end
							end
						end,
					},
					height = {
						name = "TF Height",
						desc = "Change Height of the TopFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.TopFrame.height
						end,
						set = function (v)
							self.db.profile.TopFrame.height = v
							if self.initialized.TopFrame then
								self.topframe:SetHeight(v)
							end
						end,
					},
					width = {
						name = "TF Width",
						desc = "Change Width of the TopFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 2000,
						get = function ()
							return self.db.profile.TopFrame.width
						end,
						set = function (v)
							self.db.profile.TopFrame.width = v
							if self.initialized.TopFrame then
								self.topframe:SetWidth(v)
							end
						end,
					},
					fadeheight = {
						name = "TF Fade Height",
						desc = "Change the Height of the Fade Effect",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.TopFrame.fheight
						end,
						set = function (v)
							self.db.profile.TopFrame.fheight = v
							if self.initialized.TopFrame then
								self.topframe.tfade:SetPoint("BOTTOMRIGHT", self.topframe, "TOPRIGHT", -4, -v)
							end
						end,
					},
					show = {
						name = "TopFrame Show",
						desc = "Toggle the TopFrame on/off",
						type = "toggle",
						get = function()
							return self.db.profile.TopFrame.shown
						end,
						set = function (v)
							self.db.profile.TopFrame.shown = v
							if self.initialized.TopFrame then
								if self.topframe:IsVisible() then 
									self.topframe:Hide()
								else
									self.topframe:Show()
								end
							else
								self:TopFrame()
							end
						end,
					},
				},
			},
			bottomframe = {
				name = "Bottom Frame",
				desc = "Change the BottomFrame settings",
				type = "group",
				args = {
					xyOff = {
						name = "BF Move Origin offscreen",
						desc = "Hide Border on Left and Bottom",
						type = "toggle",
						get = function ()
							return self.db.profile.BottomFrame.xyOff
						end,
						set = function (v)
							self.db.profile.BottomFrame.xyOff = v
							if self.initialized.BottomFrame then
								if self.db.profile.BottomFrame.xyOff then 
									self.bottomframe:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -6, -6)
								else
									self.bottomframe:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -3, -3)
								end
							end
						end,
					},
					height = {
						name = "BF Height",
						desc = "Change Height of the BottomFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.BottomFrame.height
						end,
						set = function (v)
							self.db.profile.BottomFrame.height = v
							if self.initialized.BottomFrame then
								self.bottomframe:SetHeight(v)
							end
						end,
					},
					width = {
						name = "BF Width",
						desc = "Change Width of the BottomFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 2000,
						get = function ()
							return self.db.profile.BottomFrame.width
						end,
						set = function (v)
							self.db.profile.BottomFrame.width = v
							if self.initialized.BottomFrame then
								self.bottomframe:SetWidth(v)
							end
						end,
					},
					fadeheight = {
						name = "BF Fade Height",
						desc = "Change the Height of the Fade Effect",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.BottomFrame.fheight
						end,
						set = function (v)
							self.db.profile.BottomFrame.fheight = v
							if self.initialized.BottomFrame then
								self.bottomframe.tfade:SetPoint("BOTTOMRIGHT", self.bottomframe, "TOPRIGHT", -4, -v)
							end
						end,
					},
					show = {
						name = "BottomFrame Show",
						desc = "Toggle the BottomFrame on/off",
						type = "toggle",
						get = function()
							return self.db.profile.BottomFrame.shown
						end,
						set = function (v)
							self.db.profile.BottomFrame.shown = v
							if self.initialized.BottomFrame then
								if self.bottomframe:IsVisible() then 
									self.bottomframe:Hide()
								else
									self.bottomframe:Show()
								end
							else
								self:BottomFrame()
							end
						end,
					},
				},
			},
			
			char = {
				name = "Character Frames",
				desc = "Change the Character Frames settings",
				type = "group",
				args = {
					character = {
						name = "Character Frames",
						desc = "Toggle the skin of the Character Frames",
						type = "toggle",
						get = function()
							return self.db.profile.CharacterFrames
						end,
						set = function(v)
							self.db.profile.CharacterFrames = v
							self:characterFrames()
						end,
					},
					spellbook = {
						name = "SpellBook Frame",
						desc = "Toggle the skin of the SpellBook Frame",
						type = "toggle",
						get = function()
							return self.db.profile.SpellBookFrame
						end,
						set = function(v)
							self.db.profile.SpellBookFrame = v
							self:SpellBookFrame()
						end,
					},
					talent = {
						name = "Talent Frame",
						desc = "Toggle the skin of the Talent Frame",
						type = "toggle",
						get = function()
							return self.db.profile.TalentFrame
						end,
						set = function(v)
							self.db.profile.TalentFrame = v
							self:TalentFrame()
						end,
					},
					dressup = {
						name = "DressUP Frame",
						desc = "Toggle the skin of the DressUp Frame",
						type = "toggle",
						get = function()
							return self.db.profile.DressUpFrame
						end,
						set = function(v)
							self.db.profile.DressUpFrame = v
							self:DressUpFrame()
						end,
					},
					friends = {
						name = "Social Frame",
						desc = "Toggle the skin of the Social Frame",
						type = "toggle",
						get = function()
							return self.db.profile.FriendsFrame
						end,
						set = function(v)
							self.db.profile.FriendsFrame = v
							self:FriendsFrame()
							end,
					},
					tradeskill = {
						name = "Trade Skill Frame",
						desc = "Toggle the skin of the Trade Skill Frame",
						type = "toggle",
						get = function()
							return self.db.profile.TradeSkill
						end,
						set = function(v)
							self.db.profile.TradeSkill = v
							self:TradeSkill()
						end,
					},
					craft = {
						name = "Craft Frame",
						desc = "Toggle the skin of the Craft Frame",
						type = "toggle",
						get = function()
							return self.db.profile.CraftFrame
						end,
						set = function(v)
							self.db.profile.CraftFrame = v
							self:CraftFrame()
						end,
					},
					trade = {
						name = "Trade Frame",
						desc = "Toggle the skin of the Trade Frame",
						type = "toggle",
						get = function()
							return self.db.profile.TradeFrame
						end,
						set = function(v)
							self.db.profile.TradeFrame = v
							self:TradeFrame()
						end,
					},
					questlog = {
						name = "Quest Log Frame",
						desc = "Toggle the skin of the Quest Log Frame",
						type = "toggle",
						get = function()
							return self.db.profile.QuestLog
						end,
						set = function(v)
							self.db.profile.QuestLog = v
							self:QuestLog()
						end,
					},
					raidui = {
						name = "RaidUI Frame",
						desc = "Toggle the skin of the RaidUI Frame",
						type = "toggle",
						get = function()
							return self.db.profile.RaidUI
						end,
						set = function(v)
							self.db.profile.RaidUI = v
							self:RaidUI()
						end,
					},
				},
			},
			ui = {
				name = "UI Frames",
				desc = "Change the UI Elements settings",
				type = "group",
				args = {
					tooltip = {
						name = "Tooltips",
						desc = "Change the Tooltip settings",
						type = "group",
						args = {
							show = {
								name = "Tooltip Show",
								desc = "Toggle the skinning of Tooltips on/off",
								type = "toggle",
								get = function()
									return self.db.profile.Tooltips.shown
								end,
								set = function (v)
									self.db.profile.Tooltips.shown = v
									self:Tooltips()						
								end,
							},
							style = {
								name = "Tooltips Style",
								desc = "Set the Tooltips style (Rounded, Flat)",
								type = "range",
								step = 1,
								min = 1,
								max = 2,
								get = function()
									return self.db.profile.Tooltips.style
								end,
								set = function (v)
									self.db.profile.Tooltips.style = v
									self:Tooltips()						
								end,
							},
						},
					},
					timers = {
						name = "Timer Frames",
						desc = "Toggle the skin of the Timer Frames",
						type = "toggle",
						get = function()
							return self.db.profile.MirrorTimers
						end,
						set = function(v)
							self.db.profile.MirrorTimers = v
							self:MirrorTimers()
						end,
					},
					castbar = {
						name = "Casting Bar Frame",
						desc = "Toggle the skin of the Casting Bar Frame",
						type = "toggle",
						get = function()
							return self.db.profile.CastingBar
						end,
						set = function(v)
							self.db.profile.CastingBar = v
							self:CastingBar()
						end,
					},
					popups = {
						name = "Static Popups",
						desc = "Toggle the skin of Static Popups",
						type = "toggle",
						get = function()
							return self.db.profile.StaticPopups
						end,
						set = function(v)
							self.db.profile.StaticPopups = v
							self:StaticPopups()
						end,
					},
					chattabs = {
						name = "Chat Tabs",
						type = "toggle",
						desc = "Toggle the skin of the Chat Tabs",
						get = function()
							return self.db.profile.ChatTabs
						end,
						set = function(v)
							self.db.profile.ChatTabs = v
							self:ChatTabs()
						end,
					},
					chatframes = {
						name = "Chat Frames",
						desc = "Toggle the skin of the Chat Frames",
						type = "toggle",
						get = function()
							return self.db.profile.ChatFrames
						end,
						set = function(v)
							self.db.profile.ChatFrames = v
							self:ChatFrames()
						end,
					},
					editbox = {
						name = "Chat Edit Box",
						desc = "Toggle the skin of the Chat Edit Box",
						type = "toggle",
						get = function()
							return self.db.profile.ChatEditBox
						end,
						set = function(v)
							self.db.profile.ChatEditBox = v
							self:ChatEditBox()
						end,
					},
					loot = {
						name = "Loot Frame",
						desc = "Toggle the skin of the Loot Frame",
						type = "toggle",
						get = function()
							return self.db.profile.LootFrame
						end,
						set = function(v)
							self.db.profile.LootFrame = v
							self:LootFrame()
						end,
					},
					grouploot = {
						name = "Group Loot Frame",
						desc = "Change the GroupLoot settings",
						type = "group",
						args = {
							show = {
								name = "GroupLoot Show",
								desc = "Toggle the GroupLoot frame on/off",
								type = "toggle",
								get = function()
									return self.db.profile.GroupLoot.shown
								end,
								set = function (v)
									self.db.profile.GroupLoot.shown = v
									self:GroupLoot()						
								end,
							},
							size = {
								name = "GroupLoot Size",
								desc = "Set the GroupLoot size (Normal, Small, Micro)",
								type = "range",
								step = 1,
								min = 1,
								max = 3,
								get = function()
									return self.db.profile.GroupLoot.size
								end,
								set = function (v)
									self.db.profile.GroupLoot.size = v
									self:GroupLoot()
								end,
							},
						},
					},
					container = {
						name = "Container Frames",
						desc = "Toggle the skin of the Container Frames",
						type = "toggle",
						get = function()
							return self.db.profile.ContainerFrames
						end,
						set = function(v)
							self.db.profile.ContainerFrames = v
							self:containerFrames()
							if IsAddOnLoaded("OneBank") then self:Skin_OneBank() end
							if IsAddOnLoaded("OneBag") then self:Skin_OneBag() end
						end,
					},
					stack = {
						name = "Stack Split Frame",
						desc = "Toggle the skin of the Stack Split Frame",
						type = "toggle",
						get = function()
							return self.db.profile.StackSplit
						end,
						set = function(v)
							self.db.profile.StackSplit = v
							self:StackSplit()
							if IsAddOnLoaded("EnhancedStackSplit") then self:EnhancedStackSplit() end
						end,
					},
					itemtext = {
						name = "Item Text Frame",
						desc = "Toggle the skin of the Item Text Frame",
						type = "toggle",
						get = function()
							return self.db.profile.ItemText
						end,
						set = function(v)
							self.db.profile.ItemText = v
							self:ItemText()
						end,
					},
					colours = {
						name = "Color Picker Frame",
						desc = "Toggle the skin of the Color Picker Frame",
						type = "toggle",
						get = function()
							return self.db.profile.Colours
						end,
						set = function(v)
							self.db.profile.Colours = v
							self:ColorPicker()
							if IsAddOnLoaded("EnhancedColourPicker") then self:EnhancedColourPicker() end
						end,
					},
					map = {
						name = "World Map Frame",
						desc = "Toggle the skin of the World Map Frame",
						type = "toggle",
						get = function()
							return self.db.profile.WorldMap
						end,
						set = function(v)
							self.db.profile.WorldMap = v
							self:WorldMap()
							if IsAddOnLoaded("MetaMap") then self:MetaMap() end
						end,
					},
					inspect = {
						name = "Inspect Frame",
						desc = "Toggle the skin of the Inspect Frame",
						type = "toggle",
						get = function()
							return self.db.profile.Inspect
						end,
						set = function(v)
							self.db.profile.Inspect = v
							self:InspectFrame()
							if IsAddOnLoaded("SuperInspect_UI") then self:SuperInspectFrame() end
							end,
					},
					menu = {
						name = "Menu Frames",
						desc = "Toggle the skin of the Menu Frames",
						type = "toggle",
						get = function()
							return self.db.profile.MenuFrames
						end,
						set = function(v)
							self.db.profile.MenuFrames = v
							self:menuFrames()
							self:myBindings()
						end,
					},
					bank = {
						name = "Bank Frame",
						desc = "Toggle the skin of the Bank Frame",
						type = "toggle",
						get = function()
							return self.db.profile.BankFrame
						end,
						set = function(v)
							self.db.profile.BankFrame = v
							self:BankFrame()
						end,
					},
					mail = {
						name = "Mail Frame",
						desc = "Toggle the skin of the Mail Frame",
						type = "toggle",
						get = function()
							return self.db.profile.MailFrame
						end,
						set = function(v)
							self.db.profile.MailFrame = v
							self:MailFrame()
						end,
					},
					auction = {
						name = "Auction Frame",
						desc = "Toggle the skin of the Auction Frame",
						type = "toggle",
						get = function()
							return self.db.profile.AuctionFrame
						end,
						set = function(v)
							self.db.profile.AuctionFrame = v
							self:AuctionFrame()
							self:makeMFRotatable(_G["AuctionDressUpModel"])
		                    if IsAddOnLoaded("Auctioneer") then self:Auctioneer() end
		                    if IsAddOnLoaded("IgorsMassAuction") then self:IgorsMassAuction() end
						end,
					},
					mainbar = {
						name = "Main Menu Bar",
						desc = "Toggle the skin of the Main Menu Bar",
						type = "toggle",
						get = function()
							return self.db.profile.MainMenuBar
						end,
						set = function(v)
							self.db.profile.MainMenuBar = v
							self:MainMenuBar()
						end,
					},
					coins = {
						name = "Coin Pickup Frame",
						desc = "Toggle the skin of the Coin Pickup Frame",
						type = "toggle",
						get = function()
							return self.db.profile.CoinPickup
						end,
						set = function(v)
							self.db.profile.CoinPickup = v
							self:CoinPickup()
						end,
					},
					gmsurveyui = {
						name = "GM Survey UI Frame",
						desc = "Toggle the skin of the GM Survey UI Frame",
						type = "toggle",
						get = function()
							return self.db.profile.GMSurveyUI
						end,
						set = function(v)
							self.db.profile.GMSurveyUI = v
							self:GMSurveyUI()
						end,
					},
				},
			},
			npc = {
				name = "NPC Frames",
				desc = "Change the NPC Frames settings",
				type = "group",
				args = {
					merchant = {
						name = "Merchant Frames",
						desc = "Toggle the skin of the Merchant Frames",
						type = "toggle",
						get = function()
							return self.db.profile.MerchantFrames
						end,
						set = function(v)
							self.db.profile.MerchantFrames = v
							self:merchantFrames()
						end,
					},
					gossip = {
						name = "Gossip Frame",
						desc = "Toggle the skin of the Gossip Frame",
						type = "toggle",
						get = function()
							return self.db.profile.GossipFrame
						end,
						set = function(v)
							self.db.profile.GossipFrame = v
							self:GossipFrame()
						end,
					},
					trainer = {
						name = "Class Trainer Frame",
						desc = "Toggle the skin of the Class Trainer Frame",
						type = "toggle",
						get = function()
							return self.db.profile.ClassTrainer
						end,
						set = function(v)
							self.db.profile.ClassTrainer = v
							self:ClassTrainer()
						end,
					},
					stable = {
						name = "Stable Frame",
						desc = "Toggle the skin of the Stable Frame",
						type = "toggle",
						get = function()
							return self.db.profile.PetStableFrame
						end,
						set = function(v)
							self.db.profile.PetStableFrame = v
							self:PetStableFrame()
						end,
					},
					taxi = {
						name = "Taxi Frame",
						desc = "Toggle the skin of the Taxi Frame",
						type = "toggle",
						get = function()
							return self.db.profile.TaxiFrame
						end,
						set = function(v)
							self.db.profile.TaxiFrame = v
							self:TaxiFrame()
						end,
					},
					quest = {
						name = "Quest Frame",
						desc = "Toggle the skin of the Quest Frame",
						type = "toggle",
						get = function()
							return self.db.profile.QuestFrame
						end,
						set = function(v)
							self.db.profile.QuestFrame = v
							self:QuestFrame()
						end,
					},
					battles = {
						name = "Battlefields Frame",
						desc = "Toggle the skin of the Battlefields Frame",
						type = "toggle",
						get = function()
							return self.db.profile.Battlefields
						end,
						set = function(v)
							self.db.profile.Battlefields = v
							self:Battlefields()
						end,
					},
					guildregistrar = {
						name = "Guild Registrar Frame",
						desc = "Toggle the skin of the Guild Registrar Frame",
						type = "toggle",
						get = function()
							return self.db.profile.GuildRegistrar
						end,
						set = function(v)
							self.db.profile.GuildRegistrar = v
							self:GuildRegistrar()
						end,
					},
					petition = {
						name = "Petition Frame",
						desc = "Toggle the skin of the Petition Frame",
						type = "toggle",
						get = function()
							return self.db.profile.Petition
						end,
						set = function(v)
							self.db.profile.Petition = v
							self:Petition()
						end,
					},
					tabard = {
						name = "Tabard Frame",
						desc = "Toggle the skin of the Tabard Frame",
						type = "toggle",
						get = function()
							return self.db.profile.Tabard
						end,
						set = function(v)
							self.db.profile.Tabard = v
							self:Tabard()
						end,
					},
				},
			},
		},	
	}
end
