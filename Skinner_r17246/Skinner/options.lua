local L = AceLibrary("AceLocale-2.2"):new("Skinner")

local self = Skinner

function Skinner:Defaults()
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
		ViewPort		= {top = 64, bottom=64, YResolution=1050, scaling = 768/1050, shown=false, overlay=false, r = 0, g = 0, b = 0, a = 1},
		TopFrame		= {height = 64, width=1920, shown=false, fheight=50, xyOff = true},
		BottomFrame		= {height = 200, width=1920, shown=false, fheight=50, xyOff = true},
		-- Character Frames
		CharacterFrames = true,
		PetStableFrame	= true,
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
		ChatEditBox		= {shown = true, style = 1},
		LootFrame		= true,
		GroupLoot		= {shown = true, size = 1},
		ContainerFrames	= true,
		StackSplit		= true,
		ItemText		= true,
		Colours			= true,
		WorldMap		= true,
		HelpFrame		= true,
		Inspect			= true,
		MenuFrames		= true,
		BankFrame       = true,
		MailFrame		= true,
		AuctionFrame	= true,
		MainMenuBar     = true,
		CoinPickup		= true,
		GMSurveyUI		= true,
		-- NPC Frames
		MerchantFrames	= true,
		GossipFrame		= true,
		ClassTrainer	= true,
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

function Skinner:GetRGBA(element)
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

function Skinner:Options()
	Skinner.options = {
		type = "group",
		args = {
			cp = {
				name = L["Default Colours"],
				desc = L["Change the default colour settings"],
				type = "group",
				args = {
					border = {
						name = L["Border Colors"],
						desc = L["Set Backdrop Border Colors"],
						type = "execute",
						func = function() self:GetRGBA("BackdropBorder") end,
					},
					backdrop = {
						name = L["Backdrop Colors"],
						desc = L["Set Backdrop Colors"],
						type = "execute",
						func = function() self:GetRGBA("Backdrop") end,
					},
					headtext = {
						name = L["Text Heading Colors"],
						desc = L["Set Text Heading Colors"],
						type = "execute",
						func = function() self:GetRGBA("HeadText") end,
					},
					bodytext = {
						name = L["Text Body Colors"],
						desc = L["Set Text Body Colors"],
						type = "execute",
						func = function() self:GetRGBA("BodyText") end,
					},
				},
			},
			texturedtab = {
				name = L["Textured Tab"],
				desc = L["Toggle the Texture of the Tabs"],
				type = "toggle",
				get = function()
					return self.db.profile.TexturedTab
				end,
				set = function(v)
					self.db.profile.TexturedTab = v
				end,
			},
			gradient = {
				name = L["Gradient Effect"],
				desc = L["Toggle the Gradient Effect"],
				type = "toggle",
				get = function()
					return self.db.profile.Gradient
				end,
				set = function(v)
					self.db.profile.Gradient = v
				end,
			},
			fadeheight = {
				name = L["Fade Height"],
				desc = L["Change the Fade Height settings"],
				type = "group",
				args = {
					enable = {
						name = L["Global Fade Height"],
						desc = L["Toggle the Global Fade Height on/off"],
						type = "toggle",
						get = function()
							return self.db.profile.FadeHeight.enable
						end,
						set = function (v)
							self.db.profile.FadeHeight.enable = v
						end,
					},
					value = {
						name = L["Fade Height value"],
						desc = L["Change the Height of the Fade Effect"],
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
						name = L["Force the Global Fade Height"],
						desc = L["Force ALL Frame Fade Height's to be Global"],
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
				name = L["Skinning Delays"],
				desc = L["Change the Skinning Delays settings"],
				type = "group",
				args = {
					init = {
						name = L["Initial Delay"],
						desc = L["Set the Delay before Skinning Blizzard Frames"],
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
						name = L["Addons Delay"],
						desc = L["Set the Delay before Skinning Addons Frames"],
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
						name = L["LoD Addons Delay"],
						desc = L["Set the Delay before Skinning Load on Demand Frames"],
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
				name = L["View Port"],
				desc = L["Change the ViewPort settings"],
				type = "group",
				args = {
					top = {
						name = L["VP Top"],
						desc = L["Change Height of the Top Band"],
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
						name = L["VP Bottom"],
						desc = L["Change Height of the Bottom Band"],
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
						name = L["VP YResolution"],
						desc = L["Change Y Resolution"],
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
						name = L["ViewPort Show"],
						desc = L["Toggle the ViewPort on/off"],
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
						name = L["ViewPort Overlay"],
						desc = L["Toggle the ViewPort Overlay"],
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
					colour = {
						name = L["ViewPort Colors"],
						desc = L["Set ViewPort Colors"],
						type = "execute",
						func = function() self:GetRGBA("ViewPort") end,
					},
				},
			},
			topframe = {
				name = L["Top Frame"],
				desc = L["Change the TopFrame settings"],
				type = "group",
				args = {
					xyOff = {
						name = L["TF Move Origin offscreen"],
						desc = L["Hide Border on Left and Top"],
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
						name = L["TF Height"],
						desc = L["Change Height of the TopFrame"],
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
						name = L["TF Width"],
						desc = L["Change Width of the TopFrame"],
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
						name = L["TF Fade Height"],
						desc = L["Change the Height of the Fade Effect"],
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
						name = L["TopFrame Show"],
						desc = L["Toggle the TopFrame on/off"],
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
				name = L["Bottom Frame"],
				desc = L["Change the BottomFrame settings"],
				type = "group",
				args = {
					xyOff = {
						name = L["BF Move Origin offscreen"],
						desc = L["Hide Border on Left and Bottom"],
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
						name = L["BF Height"],
						desc = L["Change Height of the BottomFrame"],
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
						name = L["BF Width"],
						desc = L["Change Width of the BottomFrame"],
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
						name = L["BF Fade Height"],
						desc = L["Change the Height of the Fade Effect"],
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
						name = L["BottomFrame Show"],
						desc = L["Toggle the BottomFrame on/off"],
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
				name = L["Character Frames"],
				desc = L["Change the Character Frames settings"],
				type = "group",
				args = {
					none = {
						name = L["Disable all Character Frames"],
						desc = L["Disable all the Character Frames from being skinned"],
						type = "execute",
						func = function() for k, frameName in pairs({ "CharacterFrames", "SpellBookFrame", "TalentFrame", "DressUpFrame", "FriendsFrame", "TradeSkill", "CraftFrame", "TradeFrame", "QuestLog", "RaidUI" })	do
							self.db.profile[frameName] = false
							end
						end,
					},
					character = {
						name = L["Character Frames"],
						desc = L["Toggle the skin of the Character Frames"],
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
						name = L["SpellBook Frame"],
						desc = L["Toggle the skin of the SpellBook Frame"],
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
						name = L["Talent Frame"],
						desc = L["Toggle the skin of the Talent Frame"],
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
						name = L["DressUP Frame"],
						desc = L["Toggle the skin of the DressUp Frame"],
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
						name = L["Social Frame"],
						desc = L["Toggle the skin of the Social Frame"],
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
						name = L["Trade Skill Frame"],
						desc = L["Toggle the skin of the Trade Skill Frame"],
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
						name = L["Craft Frame"],
						desc = L["Toggle the skin of the Craft Frame"],
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
						name = L["Trade Frame"],
						desc = L["Toggle the skin of the Trade Frame"],
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
						name = L["Quest Log Frame"],
						desc = L["Toggle the skin of the Quest Log Frame"],
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
						name = L["RaidUI Frame"],
						desc = L["Toggle the skin of the RaidUI Frame"],
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
				name = L["UI Frames"],
				desc = L["Change the UI Elements settings"],
				type = "group",
				args = {
					none = {
						name = L["Disable all UI Frames"],
						desc = L["Disable all the UI Frames from being skinned"],
						type = "execute",
						func = function() for k, keyName in pairs({ "MirrorTimers", "CastingBar", "StaticPopups", "ChatTabs", "ChatFrames", "LootFrame", "ContainerFrames", "StackSplit", "ItemText", "Colours", "WorldMap", "HelpFrame", "Inspect", "MenuFrames", "BankFrame", "MailFrame", "AuctionFrame", "MainMenuBar", "CoinPickup", "GMSurveyUI" })	do
							self.db.profile[keyName] = false
							end
							for k, keyName in pairs({ "Tooltips", "ChatEditBox", "GroupLoot" })	do
								self.db.profile[keyName].shown = false
								end
						end,
					},
					tooltip = {
						name = L["Tooltips"],
						desc = L["Change the Tooltip settings"],
						type = "group",
						args = {
							show = {
								name = L["Tooltip Show"],
								desc = L["Toggle the skinning of Tooltips on/off"],
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
								name = L["Tooltips Style"],
								desc = L["Set the Tooltips style (Rounded, Flat)"],
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
						name = L["Timer Frames"],
						desc = L["Toggle the skin of the Timer Frames"],
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
						name = L["Casting Bar Frame"],
						desc = L["Toggle the skin of the Casting Bar Frame"],
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
						name = L["Static Popups"],
						desc = L["Toggle the skin of Static Popups"],
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
						name = L["Chat Tabs"],
						type = "toggle",
						desc = L["Toggle the skin of the Chat Tabs"],
						get = function()
							return self.db.profile.ChatTabs
						end,
						set = function(v)
							self.db.profile.ChatTabs = v
							self:ChatTabs()
						end,
					},
					chatframes = {
						name = L["Chat Frames"],
						desc = L["Toggle the skin of the Chat Frames"],
						type = "toggle",
						get = function()
							return self.db.profile.ChatFrames
						end,
						set = function(v)
							self.db.profile.ChatFrames = v
							self:ChatFrames()
						end,
					},
					chateb = {
						name = L["Chat Edit Box"],
						desc = L["Change the Chat Edit Box settings"],
						type = "group",
						args = {
							show = {
								name = L["Chat Edit Box Show"],
								desc = L["Toggle the Chat Edit Box frame on/off"],
								type = "toggle",
								get = function()
									return self.db.profile.ChatEditBox.shown
								end,
								set = function (v)
									self.db.profile.ChatEditBox.shown = v
									self:ChatEditBox()
								end,
							},
							style = {
								name = L["Chat Edit Box Style"],
								desc = L["Set the Chat Edit Box style (Frame, EditBox)"],
								type = "range",
								step = 1,
								min = 1,
								max = 2,
								get = function()
									return self.db.profile.ChatEditBox.style
								end,
								set = function (v)
									self.db.profile.ChatEditBox.style = v
									self:ChatEditBox()
								end,
							},
						},
					},
					loot = {
						name = L["Loot Frame"],
						desc = L["Toggle the skin of the Loot Frame"],
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
						name = L["Group Loot Frame"],
						desc = L["Change the GroupLoot settings"],
						type = "group",
						args = {
							show = {
								name = L["GroupLoot Show"],
								desc = L["Toggle the GroupLoot frame on/off"],
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
								name = L["GroupLoot Size"],
								desc = L["Set the GroupLoot size (Normal, Small, Micro)"],
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
						name = L["Container Frames"],
						desc = L["Toggle the skin of the Container Frames"],
						type = "toggle",
						get = function()
							return self.db.profile.ContainerFrames
						end,
						set = function(v)
							self.db.profile.ContainerFrames = v
							self:containerFrames()
						end,
					},
					stack = {
						name = L["Stack Split Frame"],
						desc = L["Toggle the skin of the Stack Split Frame"],
						type = "toggle",
						get = function()
							return self.db.profile.StackSplit
						end,
						set = function(v)
							self.db.profile.StackSplit = v
							self:StackSplit()
						end,
					},
					itemtext = {
						name = L["Item Text Frame"],
						desc = L["Toggle the skin of the Item Text Frame"],
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
						name = L["Color Picker Frame"],
						desc = L["Toggle the skin of the Color Picker Frame"],
						type = "toggle",
						get = function()
							return self.db.profile.Colours
						end,
						set = function(v)
							self.db.profile.Colours = v
							self:ColorPicker()
						end,
					},
					map = {
						name = L["World Map Frame"],
						desc = L["Toggle the skin of the World Map Frame"],
						type = "toggle",
						get = function()
							return self.db.profile.WorldMap
						end,
						set = function(v)
							self.db.profile.WorldMap = v
							self:WorldMap()
						end,
					},
					help = {
						name = L["Help Frame"],
						desc = L["Toggle the skin of the Help Frame"],
						type = "toggle",
						get = function()
							return self.db.profile.HelpFrame
						end,
						set = function(v)
							self.db.profile.HelpFrame = v
							self:HelpFrame()
						end,
					},
					inspect = {
						name = L["Inspect Frame"],
						desc = L["Toggle the skin of the Inspect Frame"],
						type = "toggle",
						get = function()
							return self.db.profile.Inspect
						end,
						set = function(v)
							self.db.profile.Inspect = v
							self:InspectFrame()
							end,
					},
					menu = {
						name = L["Menu Frames"],
						desc = L["Toggle the skin of the Menu Frames"],
						type = "toggle",
						get = function()
							return self.db.profile.MenuFrames
						end,
						set = function(v)
							self.db.profile.MenuFrames = v
							self:menuFrames()
						end,
					},
					bank = {
						name = L["Bank Frame"],
						desc = L["Toggle the skin of the Bank Frame"],
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
						name = L["Mail Frame"],
						desc = L["Toggle the skin of the Mail Frame"],
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
						name = L["Auction Frame"],
						desc = L["Toggle the skin of the Auction Frame"],
						type = "toggle",
						get = function()
							return self.db.profile.AuctionFrame
						end,
						set = function(v)
							self.db.profile.AuctionFrame = v
							self:AuctionFrame()
						end,
					},
					mainbar = {
						name = L["Main Menu Bar"],
						desc = L["Toggle the skin of the Main Menu Bar"],
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
						name = L["Coin Pickup Frame"],
						desc = L["Toggle the skin of the Coin Pickup Frame"],
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
						name = L["GM Survey UI Frame"],
						desc = L["Toggle the skin of the GM Survey UI Frame"],
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
				name = L["NPC Frames"],
				desc = L["Change the NPC Frames settings"],
				type = "group",
				args = {
					none = {
						name = L["Disable all NPC Frames"],
						desc = L["Disable all the NPC Frames from being skinned"],
						type = "execute",
						func = function() for k, frameName in pairs({ "MerchantFrames", "GossipFrame", "ClassTrainer", "PetStableFrame", "TaxiFrame", "QuestFrame", "Battlefields", "GuildRegistrar", "Petition", "Tabard" }) do
							self.db.profile[frameName] = false
							end
						end,
					},
					merchant = {
						name = L["Merchant Frames"],
						desc = L["Toggle the skin of the Merchant Frames"],
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
						name = L["Gossip Frame"],
						desc = L["Toggle the skin of the Gossip Frame"],
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
						name = L["Class Trainer Frame"],
						desc = L["Toggle the skin of the Class Trainer Frame"],
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
						name = L["Stable Frame"],
						desc = L["Toggle the skin of the Stable Frame"],
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
						name = L["Taxi Frame"],
						desc = L["Toggle the skin of the Taxi Frame"],
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
						name = L["Quest Frame"],
						desc = L["Toggle the skin of the Quest Frame"],
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
						name = L["Battlefields Frame"],
						desc = L["Toggle the skin of the Battlefields Frame"],
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
						name = L["Guild Registrar Frame"],
						desc = L["Toggle the skin of the Guild Registrar Frame"],
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
						name = L["Petition Frame"],
						desc = L["Toggle the skin of the Petition Frame"],
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
						name = L["Tabard Frame"],
						desc = L["Toggle the skin of the Tabard Frame"],
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
