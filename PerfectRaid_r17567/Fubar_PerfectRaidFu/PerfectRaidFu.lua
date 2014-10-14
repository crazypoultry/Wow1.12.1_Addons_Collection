local tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.0"):new("PerfectRaidFu")

PerfectRaidFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0")

local function update_status()  
    for unit in pairs(PerfectRaid.visible) do
        PerfectRaid:UpdateStatus(unit)
    end
end

PerfectRaidFu.OnMenuRequest = PerfectRaid.options
PerfectRaidFu:RegisterChatCommand( { "/PerfectRaidFu" }, PerfectRaid.options )
PerfectRaidFu.hasIcon = false

PerfectRaidFu:RegisterDB("Fubar_PerfectRaidDB")
PerfectRaidFu:RegisterDefaults('profile', {
	enabled =0,
	hideIcon = true,		
})

function PerfectRaidFu:IsHideIcon()
	return self.db.profile.hideIcon;
end
	
function PerfectRaidFu:ToggleHideIcon()
	self.db.profile.hideIcon = not self.db.profile.hideIcon;
	if (PerfectRaid_IconFrame) then
		if self.db.profile.hideIcon == true then
			--PR_IconFrame:Hide();
		else
			--PR_IconFrame:Show();
		end
	end	
end

function PerfectRaidFu:OnInitialize()
end

function PerfectRaidFu:OnEnable()
	if (SW_IconFrame) then
		if self.db.profile.hideIcon == true then
			--PR_IconFrame:Hide();
		else
			--PR_IconFrame:Show();
		end
	end		
end

function PerfectRaidFu:OnDisable()
	PR_IconFrame:Show();
end

function PerfectRaidFu:OnTextUpdate()
	self:SetText("PerfectRaidFu")
end

function PerfectRaidFu:OnClick()
	local l = PerfectRaid:ToggleLocked(nil)
	if l then
		PerfectRaid:ToggleLocked(false)
	else
		PerfectRaid:ToggleLocked(true)
	end
end

function PerfectRaidFu:OnTooltipUpdate()

	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)

	local l = PerfectRaid:ToggleLocked(nil)
	
	cat:AddLine(
		'text', L["HINT"],
		'text2', L["HINT_DESC"]
	)	
	
	if l then
		cat:AddLine(
			'text', L["LOCKED"],
			'text2', ""
		)
	else
		cat:AddLine(
			'text', L["UNLOCKED"],
			'text2', ""
		)
	end			
end