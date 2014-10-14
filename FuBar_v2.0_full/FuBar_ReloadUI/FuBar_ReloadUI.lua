local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')

FuBar_ReloadUI = FuBarPlugin:GetInstance("1.2"):new({
	name          = FuBar_ReloadUILocals.NAME,
	description   = FuBar_ReloadUILocals.DESCRIPTION,
	version       = "1.0.5",
	releaseDate   = "05-09-2006",
	aceCompatible = 103,
	author        = "Corgi",
	email         = "corgiwow@gmail.com",
	website       = "http://corgi.wowinterface.com/",
	category      = "interface",
	db            = AceDatabase:new("FuBar_ReloadUIDB"),
	defaults      = DEFAULT_OPTIONS,
	cmd           = AceChatCmd:new(FuBar_ReloadUILocals.COMMANDS, FuBar_ReloadUILocals.CMD_OPTIONS),
	loc 		  = FuBar_ReloadUILocals,
	hasIcon		  = TRUE,
	hasNoText	  = TRUE,
})

function FuBar_ReloadUI:Enable()
	--self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
end
	
function FuBar_ReloadUI:UpdateTooltip()
	tablet:SetHint(self.loc.TOOLTIP_HINT_TEXT)
end
	
function FuBar_ReloadUI:OnClick()
	ReloadUI()
end

FuBar_ReloadUI:RegisterForLoad()