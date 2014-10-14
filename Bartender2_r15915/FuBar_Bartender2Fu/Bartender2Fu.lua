Bartender2Fu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local Tablet = AceLibrary("Tablet-2.0")

Bartender2Fu.name = "Bartender2"
Bartender2Fu.version = "2.0." .. string.sub("$Revision: 12987 $", 12, -3)
Bartender2Fu.date = string.sub("$Date: 2006-10-04 14:40:00 -0400 (Wed, 04 Oct 2006) $", 8, 17)
Bartender2Fu.hasIcon = "Interface\\Icons\\INV_Drink_05"
Bartender2Fu.defaultMinimapPosition = 285
Bartender2Fu.cannotDetachTooltip = true
Bartender2Fu.hasNoColor = true
Bartender2Fu.clickableTooltip = false

function Bartender2Fu:OnInitialize()
	self:RegisterDB("Bartender2FuDB")
	Bartender.options.args.fubar = {
			type = "group",
			name = "FuBarPlugin Config",
			desc = "Configure the FuBar Plugin",
			args = {},
		}
		
	AceLibrary("AceConsole-2.0"):InjectAceOptionsTable(self, Bartender.options.args.fubar)
	self.OnMenuRequest = Bartender.options
end

function Bartender2Fu:OnClick()
	self:LockButtons()
	PlaySoundFile("Sound\\Creature\\Murloc\\mMurlocAggroOld.wav");
end

function Bartender2Fu:LockButtons()
        if LOCK_ACTIONBAR == "1" then
                LOCK_ACTIONBAR = "0"
                Bartender:Print("ActionBar lock |cffffffcf[|r|cffff0000Off|cffffffcf]|r")
        else
                LOCK_ACTIONBAR = "1"
                Bartender:Print("ActionBar lock |cffffffcf[|r|cff00ff00On|cffffffcf]|r")
        end
end

function Bartender2Fu:OnTooltipUpdate()
	local cat = Tablet:AddCategory('columns', 2)
	if LOCK_ACTIONBAR == "1" then
		cat:AddLine(	'text', "Buttons:",
								 	'text2', "Locked",
								 	'text2R', 0,
								 	'text2G', 1,
									'text2B', 0)
	else
		cat:AddLine(	'text', "Status:",
								 	'text2', "Unlocked",
								 	'text2R', 1,
								 	'text2G', 0,
									'text2B', 0)
	end
	Tablet:SetHint("Left-click to Lock/Unlock.\nRight-click to configure.")
end
