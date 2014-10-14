IceHUD = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDebug-2.0")

IceHUD.dewdrop = AceLibrary("Dewdrop-2.0")

IceHUD.Location = "Interface\\AddOns\\IceHUD"
IceHUD.options =
{
	type = 'group',
	args = 
	{
		headerGeneral = {
			type = 'header',
			name = "General Settings",
			order = 10
		},
		
		positioningSettings = {
			type = 'group',
			name = 'Positioning Settings',
			desc = 'Settings related to positioning and alpha',
			order = 11,
			args = {
				vpos = {
					type = 'range',
					name = 'Vertical position',
					desc = 'Vertical position',
					get = function()
						return IceHUD.IceCore:GetVerticalPos()
					end,
					set = function(v)
						IceHUD.IceCore:SetVerticalPos(v)
					end,
					min = -300,
					max = 300,
					step = 10,
					order = 11
				},
				
				gap = {
					type = 'range',
					name = 'Gap',
					desc = 'Distance between the left and right bars',
					get = function()
						return IceHUD.IceCore:GetGap()
					end,
					set = function(v)
						IceHUD.IceCore:SetGap(v)
					end,
					min = 50,
					max = 300,
					step = 5,
					order = 12,
				},
				
				scale = {
					type = 'range',
					name = 'Scale',
					desc = 'HUD scale',
					get = function()
						return IceHUD.IceCore:GetScale()
					end,
					set = function(v)
						IceHUD.IceCore:SetScale(v)
					end,
					min = 0.5,
					max = 1.5,
					step = 0.05,
					isPercent = true,
					order = 13,
				},
			}
		},
		
		
		alphaSettings = {
			type = 'group',
			name = 'Transparency Settings',
			desc = 'Settings for bar transparencies',
			order = 12,
			args = {
				headerAlpha = {
					type = 'header',
					name = "Bar Alpha",
					order = 10
				},
			
				alphaic = {
					type = 'range',
					name = 'Alpha IC',
					desc = 'Bar alpha In Combat',
					get = function()
						return IceHUD.IceCore:GetAlpha("IC")
					end,
					set = function(v)
						IceHUD.IceCore:SetAlpha("IC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 11,
				},
				
				alphaooc = {
					type = 'range',
					name = 'Alpha OOC',
					desc = 'Bar alpha Out Of Combat without target',
					get = function()
						return IceHUD.IceCore:GetAlpha("OOC")
					end,
					set = function(v)
						IceHUD.IceCore:SetAlpha("OOC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 12,
				},
				
				alphaTarget = {
					type = 'range',
					name = 'Alpha OOC and Target or not Full',
					desc = 'Bar alpha Out Of Combat with target accuired or bar not full',
					get = function()
						return IceHUD.IceCore:GetAlpha("Target")
					end,
					set = function(v)
						IceHUD.IceCore:SetAlpha("Target", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 13,
				},
				
				
				
				headerAlphaBackgroundBlank = { type = 'header', name = " ", order = 20 },
				headerAlphaBackground = {
					type = 'header',
					name = "Background Alpha",
					order = 20
				},
				
				alphaicbg = {
					type = 'range',
					name = 'BG Alpha IC',
					desc = 'Background alpha for bars IC',
					get = function()
						return IceHUD.IceCore:GetAlphaBG("IC")
					end,
					set = function(v)
						IceHUD.IceCore:SetAlphaBG("IC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 21,
				},
				
				alphaoocbg = {
					type = 'range',
					name = 'BG Alpha OOC',
					desc = 'Background alpha for bars OOC without target',
					get = function()
						return IceHUD.IceCore:GetAlphaBG("OOC")
					end,
					set = function(v)
						IceHUD.IceCore:SetAlphaBG("OOC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 22,
				},
				
				alphaTargetbg = {
					type = 'range',
					name = 'BG Alpha OOC and Target or not Full',
					desc = 'Background alpha for bars OOC and target accuired or bar not full',
					get = function()
						return IceHUD.IceCore:GetAlphaBG("Target")
					end,
					set = function(v)
						IceHUD.IceCore:SetAlphaBG("Target", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 23,
				},
				
				
				headerBarAdvancedBlank = { type = 'header', name = " ", order = 30 },
				headerBarAdvanced = {
					type = 'header',
					name = "Other",
					order = 30
				},
				
				backgroundToggle = {
					type = "toggle",
					name = "Contextual Background",
					desc = "Toggles contextual background coloring",
					get = function()
						return IceHUD.IceCore:GetBackgroundToggle()
					end,
					set = function(value)
						IceHUD.IceCore:SetBackgroundToggle(value)
					end,
					order = 31
				},
				
				backgroundColor = {
					type = 'color',
					name = 'Background Color',
					desc = 'Background Color',
					get = function()
						return IceHUD.IceCore:GetBackgroundColor()
					end,
					set = function(r, g, b)
						IceHUD.IceCore:SetBackgroundColor(r, g, b)
					end,
					order = 32,
				},
			}
		},
		
		
		textSettings = {
			type = 'text',
			name =  'Font',
			desc = 'IceHUD Font',
			order = 19,
			get = function()
				return IceHUD.IceCore:GetFontFamily()
			end,
			set = function(value)
				IceHUD.IceCore:SetFontFamily(value)
				IceHUD.IceCore:Redraw()
			end,
			validate = { "IceHUD", "Default" },	
		},
				
		barSettings = {
			type = 'group',
			name = 'Bar Settings',
			desc = 'Settings related to bars',
			order = 20,
			args = {
				barPresets = {
					type = 'text',
					name = 'Presets',
					desc = 'Predefined settings for different bars',
					get = function()
						return IceHUD.IceCore:GetBarPreset()
					end,
					set = function(value)
						IceHUD.IceCore:SetBarPreset(value)
					end,
					validate = { "Bar", "HiBar", "RoundBar" },
					order = 9
				},
			
			
				headerBarAdvancedBlank = { type = 'header', name = " ", order = 10 },
				headerBarAdvanced = {
					type = 'header',
					name = "Advanced Bar Settings",
					order = 10
				},
			
				barTexture = {
					type = 'text',
					name = 'Bar Texture',
					desc = 'IceHUD Bar Texture',
					get = function()
						return IceHUD.IceCore:GetBarTexture()
					end,
					set = function(value)
						IceHUD.IceCore:SetBarTexture(value)
					end,
					validate = { "Bar", "HiBar", "RoundBar" },		
					order = 11
				},
				
				barWidth = {
					type = 'range',
					name = 'Bar Width',
					desc = 'Bar texture width (not the actual bar!)',
					get = function()
						return IceHUD.IceCore:GetBarWidth()
					end,
					set = function(v)
						IceHUD.IceCore:SetBarWidth(v)
					end,
					min = 20,
					max = 200,
					step = 1,
					order = 12
				},
				
				barHeight = {
					type = 'range',
					name = 'Bar Height',
					desc = 'Bar texture height (not the actual bar!)',
					get = function()
						return IceHUD.IceCore:GetBarHeight()
					end,
					set = function(v)
						IceHUD.IceCore:SetBarHeight(v)
					end,
					min = 100,
					max = 300,
					step = 1,
					order = 13
				},
				
				barProportion = {
					type = 'range',
					name = 'Bar Proportion',
					desc = 'Determines the bar width compared to the whole texture width',
					get = function()
						return IceHUD.IceCore:GetBarProportion()
					end,
					set = function(v)
						IceHUD.IceCore:SetBarProportion(v)
					end,
					min = 0.01,
					max = 0.5,
					step = 0.01,
					isPercent = true,
					order = 14
				},
				
				barSpace = {
					type = 'range',
					name = 'Bar Space',
					desc = 'Space between bars on the same side',
					get = function()
						return IceHUD.IceCore:GetBarSpace()
					end,
					set = function(v)
						IceHUD.IceCore:SetBarSpace(v)
					end,
					min = -10,
					max = 30,
					step = 1,
					order = 15
				},
			}
		},
		
		
		
		headerModulesBlank = { type = 'header', name = ' ', order = 40 },
		headerModules = {
			type = 'header',
			name = 'Module Settings',
			order = 40
		},
		
		modules = {
			type='group',
			desc = 'Module configuration options',
			name = 'Modules',
			args = {},
			order = 41
		},
		
		colors = {
			type='group',
			desc = 'Module color configuration options',
			name = 'Colors',
			args = {},
			order = 42
		},
		
		headerOtherBlank = { type = 'header', name = ' ', order = 90 },
		headerOther = {
			type = 'header',
			name = 'Other',
			order = 90
		},
		
		enabled = {
			type = "toggle",
			name = "|cff11aa11Enabled|r",
			desc = "Enable/disable IceHUD",
			get = function()
				return IceHUD.IceCore:IsEnabled()
			end,
			set = function(value)
				if (value) then
					IceHUD.IceCore:Enable()
				else
					IceHUD.IceCore:Disable()
				end
			end,
			order = 91
		},
		
		reset = {
			type = 'execute',
			name = '|cffff0000Reset|r',
			desc = "Resets all IceHUD options - WARNING: Reloads UI",
			func = function()
				StaticPopup_Show("ICEHUD_RESET")
			end,
			order = 92
		},
		
		debug = {
			type = "toggle",
			name = "Debugging",
			desc = "Enable/disable debug messages",
			get = function()
				return IceHUD.IceCore:GetDebug()
			end,
			set = function(value)
				IceHUD.IceCore:SetDebug(value)
			end,
			order = 93
		},
		
		about = {
			type = 'execute',
			name = 'About',
			desc = "Prints info about IceHUD",
			func = function()
				IceHUD:PrintAddonInfo()
			end,
			order = 94
		},
		
		endSpace = {
			type = 'header',
			name = ' ',
			order = 1000
		},

	}
}

IceHUD.slashMenu =
{
	type = 'execute',
	func = function()
		if not (IceHUD.dewdrop:IsRegistered(IceHUD.IceCore.IceHUDFrame)) then
			IceHUD.dewdrop:Register(IceHUD.IceCore.IceHUDFrame,
				'children', IceHUD.options,
				'point', "BOTTOMLEFT",
				'relativePoint', "TOPLEFT",
				'dontHook', true
			)
		end
		IceHUD.dewdrop:Open(IceHUD.IceCore.IceHUDFrame)
	end
}

StaticPopupDialogs["ICEHUD_RESET"] = 
{
	text = "Are you sure you want to reset IceHUD settings?",
	button1 = "Okay",
	button2 = "Cancel",
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	OnAccept = function()
		print("hellooo")
		IceHUD.IceCore:ResetSettings()
	end
}



function IceHUD:OnInitialize()
	self:SetDebugging(false)
	self:Debug("IceHUD:OnInitialize()")
	
	self.IceCore = IceCore:new()
	

end


function IceHUD:OnEnable()
	self:Debug("IceHUD:OnEnable()")
	

	
	self.IceCore:Enable()
	self:SetDebugging(self.IceCore:GetDebug())
	self.debugFrame = ChatFrame2
	
		self.options.args.modules.args = self.IceCore:GetModuleOptions()
	self.options.args.colors.args = self.IceCore:GetColorOptions()
	
	self:RegisterChatCommand({ "/icehud" }, IceHUD.slashMenu)
end

