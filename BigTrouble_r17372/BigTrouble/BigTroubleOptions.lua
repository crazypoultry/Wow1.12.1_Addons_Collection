local L = AceLibrary("AceLocale-2.2"):new("BigTrouble")

BigTrouble.options = {
	type = "group",
	args = {
        lock = {
            name = L["Lock"],
            type = "toggle",
            desc = L["Lock/Unlock BigTrouble."],
            get = "ToggleLocked",
            set = "ToggleLocked",
            map = {[false] = L["Unlocked"], [true] = L["Locked"]},
            guiNameIsMap = true,
        },
        autoshot = {
            name = L["Toggle Auto Shot"],
            type = "toggle",
            desc = L["Toggle Auto Shot bar."],
            get = "ToggleAutoShot",
            set = "ToggleAutoShot",
            map = {[false] = L["Off"], [true] = L["On"]},
        },
        aimedshot = {
            name = L["Toggle Aimed Shot"],
            type = "toggle",
            desc = L["Toggle Aimed Shot bar."],
            get = "ToggleAimedShot",
            set = "ToggleAimedShot",
            map = {[false] = L["Off"], [true] = L["On"]},
        },
		bar = {
			name = L["Bar"], 
			type = 'group', 
			order = 2,
			desc = L["Set bar."], 
			args = {
                texture = {
                    name = L["Texture"], type = 'text',
                    desc = L["Toggle the texture."],
					get = "OptionTexture",
					set = "OptionTexture",
                    validate = {"Default","Perl","Smooth","Glaze","BantoBar","Gloss"}
                },
				border = {
					name = L["Border"],
					type = 'toggle',
					desc = L["Toggle borders BigTrouble"],
		            get = "ToggleBorder",
		            set = "ToggleBorder",
		            map = {[false] = L["Off"], [true] = L["On"]},
		            guiNameIsMap = true,
				},
				width = {
					name = L["Width"], 
					type = 'range', 
					min = 10, 
					max = 500, 
					step = 1,
					desc = L["Set the width of BigTrouble."],
					get = "OptionWidth",
					set = "OptionWidth"
				},
				adelay = {
					name = L["Aimedshot delay"], 
					type = 'range', 
					min = 0, 
					max = 1, 
					step = 0.01,
					desc = L["Set the delay of aimed shot."],
					get = "OptionAimedDelay",
					set = "OptionAimedDelay"
				},
				height = {
					name = L["Height"], 
					type = 'range', 
					min = 5, 
					max = 50, 
					step = 1,
					desc = L["Set the height of BigTrouble."],
					get = "OptionHeight",
					set = "OptionHeight"
				},
				font = {
					name = L["Font"],
					type = 'group',
					desc = L["Set the font size of BigTrouble."],
					args = {
						spell = {
							name = L["Spell"], 
							type = 'range', 
							min = 6, 
							max = 32,
							step = 1,
							desc = L["Set the font size of the spellname."],
							get = "OptionFontSpell",
							set = "OptionFontSpell"
						},
						time = {
							name = L["Time"], 
							type = 'range', 
							min = 6, 
							max = 32, 
							step = 1,
							desc = L["Set the font size of the spell time."],
							get = "OptionFontTime",
							set = "OptionFontTime"
						},
						delay = {
							name = L["Delay"], 
							type = 'range', 
							min = 6, 
							max = 32, 
							step = 1,
							desc = L["Set the font size on the delay time."],
							get = "OptionFontDelay",
							set = "OptionFontDelay"
						}
					}
				}
			}
		}
	}
}

function BigTrouble:ToggleBorder( value )

	if type(value) == "nil" then return self.opt.Bar.border end
	self.opt.Bar.border = value
    self:Layout()

end

function BigTrouble:ToggleAutoShot( value )

	if type(value) == "nil" then return self.opt.autoShotBar end
	self.opt.autoShotBar = value

end

function BigTrouble:ToggleAimedShot( value )

	if type(value) == "nil" then return self.opt.aimedShotBar end
	self.opt.aimedShotBar = value

end

function BigTrouble:ToggleLocked( value )

    if type(value) == "nil" then return self.locked end
    self.locked = value

	if( value ) then
		self.master:Hide()
		self.master:SetScript( "OnUpdate", self.OnUpdate )
	else
        autoShot = false
		aimedShot = false
		
		self.master:SetScript( "OnUpdate", nil )
		self.master:Show()
		self.master.Bar:SetStatusBarColor(.3, .3, .3)
		self.master.Time:SetText("1.3")
		self.master.Delay:SetText("+0.8")
		self.master.Spell:SetText(L["Son of a bitch must pay!"])
	end
	
end

function BigTrouble:OptionTexture( value )

    if type(value) == "nil" then return self.opt.Bar.texture end
    self.opt.Bar.texture = value
	self:Layout()
	
end

function BigTrouble:OptionWidth( value )

    if type(value) == "nil" then return self.opt.Bar.width end
    self.opt.Bar.width = value
	self:Layout()
	
end

function BigTrouble:OptionAimedDelay( value )

    if type(value) == "nil" then return self.opt.aimedDelay end
    self.opt.aimedDelay = value
	
end

function BigTrouble:OptionHeight( value )

    if type(value) == "nil" then return self.opt.Bar.height end
    self.opt.Bar.height = value
	self:Layout()
	
end

function BigTrouble:OptionFontSpell( value )

    if type(value) == "nil" then return self.opt.Bar.spellSize end
	self.opt.Bar.spellSize = value
	self:Layout()
	
end

function BigTrouble:OptionFontTime( value )

    if type(value) == "nil" then return self.opt.Bar.timeSize end
	self.opt.Bar.timeSize = value
	self:Layout()
	
end

function BigTrouble:OptionFontDelay( value )

    if type(value) == "nil" then return self.opt.Bar.delaySize end
	self.opt.Bar.delaySize = value
	self:Layout()
	
end