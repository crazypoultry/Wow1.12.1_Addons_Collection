-- Register embedded libs
local dewdrop = DewdropLib:GetInstance("1.0")
local compost = CompostLib:GetInstance("compost-1")


NanoStatsFu = FuBarPlugin:GetInstance("1.2"):new({
    name            = "NanoStatsFu",
    description     = NanoStatsLocals.DESCRIPTION,
    version         = "1.0",
    releaseDate     = "2006-06-05",
    aceCompatible   = "103",
    author          = "Neronix",
    email           = "neronix@gmail.com",
    category        = "combat",
    cmd             = AceChatCmd:new({"/nanostatsfu", "/nsfu", "/nstatsfu"}, {}),
})

function NanoStatsFu:Initialize()	
	-- No Config table --> first time user --> Create defaults table
    if ( not NanoStatsFuConfig ) then
        NanoStatsFuConfig = {
            DamageInPanel = TRUE,
            HealingInPanel = TRUE,
			TextSeparator = " - ",
			-- Other defualts are FALSE, which is equal to nil, which means we don't need to define them
        }
    end
	
	-- Compatibility code for earlier pre-1.0 SVN versions.
	-- Will be removed for NSFu 1.1
	if (not NanoStatsFuConfig.TextSeparator) then
		NanoStatsFuConfig.TextSeparator = " - "
	end
	
	-- Create the refresher for Fu mode
	function NanoStats:Refresh()
		NanoStatsFu:Update()
	end

end

--[[
function NanoStatsFu:UpdateTooltip()
	-- Ninja the code from NS
	NanoStats:TabletContents()
end
--]]

NanoStatsFu.UpdateTooltip = NanoStats.TabletContents

function NanoStatsFu:UpdateText()
	--[[
	The text format:
	10s - 123.4/1234 - 120000 - 12.3/1230 - 52000
	Duration - DPS/BattleD - SessD - HPS/BattleH - SessionH
	Can optionally be with just spaces in between (See line 6 of MenuSettings)
	Based partially on FuBar DPS' code
	--]]
	
	local text = "" -- "Concactenate nil value" errors begone!

	-- Duration
	if (NanoStatsConfig.Duration and NanoStatsFuConfig.DurationInPanel) then
		-- 10s
		text = text..NanoStatsFuConfig.TextSeparator.."|cffffffff"..NanoStats.DurationOfThisBattle.."s|r"
	end

	-- Damage
	if (NanoStatsConfig.Damage and NanoStatsFuConfig.DamageInPanel) then
		-- 123.4/1234
		text = text..NanoStatsFuConfig.TextSeparator.."|cffff0000"..NanoStats.CurrentDPS.."/"..NanoStats.TotalDamageThisBattle.."|r"
	end

	-- Session Damage
	if (NanoStatsConfig.SessionDamage and NanoStatsFuConfig.SessionDamageInPanel) then
		-- 120000
		text = text..NanoStatsFuConfig.TextSeparator.."|cffff0000"..NanoStats.TotalDamageThisSession.."|r"
	end

	-- Healing
	if (NanoStatsConfig.Healing and NanoStatsFuConfig.HealingInPanel) then
		-- 12.3/1230
		text = text..NanoStatsFuConfig.TextSeparator.."|cff00ff00"..NanoStats.CurrentHPS.."/"..NanoStats.TotalHealingThisBattle.."|r"
	end

	-- Session Healing
	if (NanoStatsConfig.SessionHealing and NanoStatsFuConfig.SessionHealingInPanel) then
		-- 12.3/1230
		text = text..NanoStatsFuConfig.TextSeparator.."|cff00ff00"..NanoStats.TotalHealingThisSession.."|r"
	end

	-- Remove leading separator text (Works with both separators
	text = string.gsub(text, "[ %-]+", "", 1)
	
	NanoStatsFu:SetText(text)
	
	-- End result:
	-- 10s - 123.4/1234 - 120000 - 12.3/1230 - 52000
	-- Or, if set to shorter display mode:
	-- 10s 123.4/1234 120000 12.3/1230 52000

end

function NanoStatsFu:MenuSettings(level, value)
	-- Get dropdown stuff from NS
	NanoStats:DropDownMenu()
	
	-- Now to add other stuff..
	
	-- Line 1: Show Duration in Panel
	dewdrop:AddLine(
		'text', NanoStatsLocals.FuCONFIG_DURATIONINPANEL,
		'checked', (NanoStatsFuConfig.DurationInPanel),
		'disabled', (not NanoStatsConfig.Duration),
		'arg1', NanoStatsFu,
		'arg2', "DurationInPanel",
		'func', "ToggleOpt"
	)
	-- Line 2: Show Damage in Panel
	dewdrop:AddLine(
		'text', NanoStatsLocals.FuCONFIG_DAMAGEINPANEL,
		'checked', (NanoStatsFuConfig.DamageInPanel),
		'disabled', (not NanoStatsConfig.Damage),
		'arg1', NanoStatsFu,
		'arg2', "DamageInPanel",
		'func', "ToggleOpt"
	)
	-- Line 3: Show Session Damage in Panel
	dewdrop:AddLine(
		'text', NanoStatsLocals.FuCONFIG_SESSIONDAMAGEINPANEL,
		'checked', (NanoStatsFuConfig.SessionDamageInPanel),
		'disabled', (not NanoStatsConfig.SessionDamage),
		'arg1', NanoStatsFu,
		'arg2', "SessionDamageInPanel",
		'func', "ToggleOpt"
	)
	-- Line 4: Show Healing in Panel
	dewdrop:AddLine(
		'text', NanoStatsLocals.FuCONFIG_HEALINGINPANEL,
		'checked', (NanoStatsFuConfig.HealingInPanel),
		'disabled', (not NanoStatsConfig.Healing),
		'arg1', NanoStatsFu,
		'arg2', "HealingInPanel",
		'func', "ToggleOpt"
	)
	-- Line 5: Show Session Healing in Panel
	dewdrop:AddLine(
		'text', NanoStatsLocals.FuCONFIG_SESSIONHEALINGINPANEL,
		'checked', (NanoStatsFuConfig.SessionHealingInPanel),
		'disabled', (not NanoStatsConfig.SessionHealing),
		'arg1', NanoStatsFu,
		'arg2', "SessionHealingInPanel",
		'func', "ToggleOpt"
	)
	-- Line 6: Shorter display format
	dewdrop:AddLine(
		'text', NanoStatsLocals.FuCONFIG_SHORTERDISPLAYFORMAT,
		'checked', (NanoStatsFuConfig.TextSeparator == " "),
		'func', function()
			if (NanoStatsFuConfig.TextSeparator == " - ") then
				NanoStatsFuConfig.TextSeparator = " "
			else
				NanoStatsFuConfig.TextSeparator = " - "
			end
			NanoStatsFu:Update()
		end
	)
end

-- This is solely used for most NSFu-specific options, which explains
-- the brevity compared to the NS core counterpart of this method
function NanoStatsFu:ToggleOpt(VarName) -- VarName is a string
	NanoStatsFuConfig[VarName] = Ace.toggle(NanoStatsFuConfig[VarName])
	NanoStatsFu:Update()
end   

-- Let's load this mofo!
NanoStatsFu:RegisterForLoad()