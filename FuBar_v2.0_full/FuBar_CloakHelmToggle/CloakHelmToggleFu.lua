local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')

CloakHelmToggle = FuBarPlugin:new({
	name          = "FuBar - CloakHelmToggle",
	description   = "Toggles player's Cloak and Helm display.",
	version       = "0.4.0",
	releaseDate   = "05-12-2006",
	aceCompatible = 103,
	fuCompatible  = 102,
	author        = "brotherhobbes",
	email         = "brotherhobbes@gmail.com",
	website       = "http://www.wowinterface.com/",
	category      = "inventory",
	db            = AceDatabase:new("CloakHelmToggleDB"),
	defaults      = {
		longText = true,
	},
	hasIcon       = false,
	defaultPosition = "CENTER",
})

-- Methods
function CloakHelmToggle:IsLongText()
	return self.data.longText
end
	
function CloakHelmToggle:ToggleLongText()
	self.data.longText = not self.data.longText
	self:UpdateText()
	return self.data.longText
end

function CloakHelmToggle:IsCloak()
	return self.data.cloak
end

function CloakHelmToggle:ToggleCloak()
	self.data.cloak = not self.data.cloak
	ShowCloak(self.data.cloak)
	return self.data.cloak
end

function CloakHelmToggle:IsHelm()
	return self.data.helm
end

function CloakHelmToggle:ToggleHelm()
	self.data.helm = not self.data.helm
	ShowHelm(self.data.helm)
	return self.data.helm
end

function CloakHelmToggle:Initialize()
end

function CloakHelmToggle:Enable()
	metro:Register(self.name, self.Update, 1, self)
	metro:Start(self.name)
end

function CloakHelmToggle:Disable()
	metro:Unregister(self.name)
end

function CloakHelmToggle:Report()
end

function CloakHelmToggle:MenuSettings(level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', "Cloak",
			'func', function()
				self:ToggleCloak()
			end,
			'checked', self:IsCloak()
		)
		dewdrop:AddLine(
			'text', "Helm",
			'func', function()
				self:ToggleHelm()
			end,
			'checked', self:IsHelm()
		)
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', "Long label text",
			'func', function()
				self:ToggleLongText()
			end,
			'checked', self:IsLongText()
		)
	end
end

function CloakHelmToggle:UpdateData()
	self.data.cloak = ShowingCloak()
	self.data.helm = ShowingHelm()
end

function CloakHelmToggle:UpdateText()
	local textCloak = self:IsLongText() and "Cloak" or "C"
	local textHelm = self:IsLongText() and "Helm" or "H"
	local colorCloak = self:IsCloak() and FuBarUtils.COLOR_HEX_GREEN or FuBarUtils.COLOR_HEX_RED
	local colorHelm = self:IsHelm() and FuBarUtils.COLOR_HEX_GREEN or FuBarUtils.COLOR_HEX_RED
	self:SetText(FuBarUtils.Colorize(colorCloak, textCloak)..FuBarUtils.Colorize(colorHelm, textHelm))
end

function CloakHelmToggle:UpdateTooltip()
	local C,H = self:IsCloak(),self:IsHelm()
	if not self:IsTooltipDetached() then tablet:AddCategory():AddLine(nil) end
	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 0
	)
	cat:AddLine(
		'text', "Cloak",
		'text2', C and "On" or "Off",
		'text2R', C and 0 or 1,
		'text2G', C and 1 or 0,
		'text2B', 0
	)
	cat:AddLine(
		'text', "Helm",
		'text2', H and "On" or "Off",
		'text2R', H and 0 or 1,
		'text2G', H and 1 or 0,
		'text2B', 0
	)

	tablet:SetHint("Click to toggle.")
end
	
function CloakHelmToggle:OnClick()
	local H,C = self:IsHelm(),self:IsCloak()

	if (H == 1 and C == 1) then
		H,C = 1,0
	elseif (H == 1 and C == nil) then
		H,C = 0,1
	elseif (H == nil and C == 1) then
		H,C = 0,0
	else
		H,C = 1,1
	end

	ShowHelm(H)
	ShowCloak(C)

	self:Update()
end

CloakHelmToggle:RegisterForLoad()