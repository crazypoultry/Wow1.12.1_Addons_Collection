local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')

local Aspect_Abilities = {
	[FuBar_AspectLocals.ASPECT_TEXT_HAWK] = 0,
	[FuBar_AspectLocals.ASPECT_TEXT_CHEETAH] = 0,
	[FuBar_AspectLocals.ASPECT_TEXT_MONKEY] = 0,
	[FuBar_AspectLocals.ASPECT_TEXT_PACK] = 0,
	[FuBar_AspectLocals.ASPECT_TEXT_BEAST] = 0,
	[FuBar_AspectLocals.ASPECT_TEXT_WILD] = 0,
}

FuBar_Aspect = FuBarPlugin:GetInstance("1.2"):new({
	name          = FuBar_AspectLocals.NAME,
	description   = FuBar_AspectLocals.DESCRIPTION,
	version       = "1.0.7",
	releaseDate   = "05-09-2006",
	aceCompatible = 103,
	author        = "Corgi",
	email         = "corgiwow@gmail.com",
	website       = "http://corgi.wowinterface.com/",
	category      = "interface",
	db            = AceDatabase:new("FuBar_AspectDB"),
	defaults      = DEFAULT_OPTIONS,
	cmd           = AceChatCmd:new(FuBar_AspectLocals.COMMANDS, FuBar_AspectLocals.CMD_OPTIONS),
	loc 		  = FuBar_AspectLocals,
	hasIcon		  = "Interface\\Icons\\Ability_Physical_Taunt",
	hasText		  = TRUE,
	canHideText	  = TRUE,
})
	
function FuBar_Aspect:UpdateTooltip()
	tablet:SetHint(self.loc.ASPECT_TOOLTIP_HINT_TEXT)
end
		
function FuBar_Aspect:MenuSettings(level, value)

	if ( level == 1 ) then
			
		-- Reset the available abilities.
		for spellName, id in ipairs(Aspect_Abilities) do
			if (id > 0) then
				self.Aspect_Abilities[spellName] = 0
			end
		end
			
		-- Calculate the total number of spells known by scanning the spellbook.
		local numTotalSpells = 0
		for i=1, MAX_SKILLLINE_TABS do
			local name, texture, offset, numSpells = GetSpellTabInfo(i)
			if (name) then
				numTotalSpells = numTotalSpells + numSpells
			end
		end
			
		-- Find available aspects.
		local aspectFound = 0
			
		for i=1, numTotalSpells do
			local spellName, subSpellName = GetSpellName(i, SpellBookFrame.bookType);
			if (spellName) then
				if (Aspect_Abilities[spellName]) then
					Aspect_Abilities[spellName] = i
					aspectFound = 1
				end
			end
		end
			
		-- Display found aspects
		if (aspectFound == 1) then
			for spellName,id in Aspect_Abilities do
				if (id > 0) then
					dewdrop:AddLine(
						'text', spellName,
						'arg1', id,
						'value', id,
						'func', function(val)
							CastSpell(val,0)
						end
					)
				end
			end
		else
			dewdrop:AddLine(
				'text', self.loc.ASPECT_NO_ASPECTS_FOUND
			)
		end
	end
end

FuBar_Aspect:RegisterForLoad()