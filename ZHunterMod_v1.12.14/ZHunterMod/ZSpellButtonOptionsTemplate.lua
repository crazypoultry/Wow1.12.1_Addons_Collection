ZSPELLBUTTON_CIRCLESIZE = 50

-- button.spell = the spell's name
-- button.rank = the spell's rank
-- button.id = the spell's id
-- button.mana = the spell's mana cost
-- button.click = function call, passes the button that was clicked
-- button.outOfCombat = set to 1 if your spell cannot be cast in combat (traps), leave nil otherwise
-- button.inCombat = 1 if outOfCombat was set and player is in combat, nil otherwise
-- button.onCooldown = 1 if spell button has a cooldown active, nil otherwise

function ZSpellButton_SetSize(name, size)
	if not size then
		size = 36
	end
	local i = 1
	local button = getglobal(name..i)
	local buttonCooldown = getglobal(name..i.."Cooldown")
	local buttonCircle = getglobal(name..i.."Circle")
	while button do
		button:SetHeight(size)
		button:SetWidth(size)
		buttonCooldown:SetModelScale((size/36)*.75)
		if buttonCircle then
			buttonCircle:SetHeight(size*(ZSPELLBUTTON_CIRCLESIZE/36))
			buttonCircle:SetWidth(size*(ZSPELLBUTTON_CIRCLESIZE/36))
		end
		i = i + 1
		button = getglobal(name..i)
		buttonCooldown = getglobal(name..i.."Cooldown")
		buttonCircle = getglobal(name..i.."Circle")
	end
end

function ZSpellButton_SetPosition(name, count, rows, horizontal, vertical)
	local left, right, bottom, top = "LEFT", "RIGHT", "BOTTOM", "TOP"
	if horizontal then
		left, right = "RIGHT", "LEFT"
	end
	if vertical then
		bottom, top = "TOP", "BOTTOM"
	end

	local cols = ceil(count/rows)
	local temp = 1
	local i = 2
	local button = getglobal(name..i)
	while button do
		if i > count then
			button.hidden = 1
			button:Hide()
		else
			button.hidden = nil
			button:Show()
			button:ClearAllPoints()
			if temp >= cols then
				button:SetPoint(top, getglobal(name..(i-temp)), bottom)
				temp = 0
			else
				button:SetPoint(left, getglobal(name..(i-1)), right)
			end
			temp = temp + 1
		end
		i = i + 1
		button = getglobal(name..i)
	end
end

function ZSpellButton_OnLoad()
	this.id = 1
	this.spell = "Attack"
	this.rank = ""
	this:RegisterEvent("SPELLS_CHANGED")
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	this:RegisterEvent("VARIABLES_LOADED")

	-- Check For Spell Combat
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_REGEN_ENABLED")
	this:RegisterEvent("PLAYER_REGEN_DISABLED")

--	-- Check For Spell Mana Requirement
--	this.mana = 60
--	this:RegisterEvent("UNIT_MANA");
--	this:RegisterEvent("UNIT_ENERGY");
--	this:RegisterEvent("UNIT_RAGE");
end

function ZSpellButton_OnEvent()
	if event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_COOLDOWN" or event == "VARIABLES_LOADED" then
		ZSpellButton_UpdateButton()
	elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" then
		getglobal(this:GetName().."Icon"):SetVertexColor(1, 1, 1)
		this.inCombat = nil
	elseif event == "PLAYER_REGEN_DISABLED" then
		if this.outOfCombat then
			getglobal(this:GetName().."Icon"):SetVertexColor(.4, .4, .4)
			this.inCombat = 1
		end
--	elseif event == "UNIT_MANA" or event == "UNIT_ENERGY" or event == "UNIT_RAGE" then
--		if arg1 == "player" then
--			if not (this.outOfCombat and ZSpellButtonInCombat) then
--				if UnitMana("player") >= this.mana then
--					getglobal(this:GetName().."Icon"):SetVertexColor(1, 1, 1)
--				else
--					getglobal(this:GetName().."Icon"):SetVertexColor(.4, .4, 1)
--				end
--			end
--		end
	end
end

function ZSpellButton_OnClick()
	this:SetChecked(0)
	if not (this.inCombat or (this.onCooldown and getglobal(this:GetName().."Cooldown"):IsVisible())) then
		if type(this.click) == "function" then
			this.click(this)
		end
		this.cast = 1
		this.onCooldown = nil
	end
	local id = tonumber(this.id)
	if id and id > 0 and id <= MAX_SPELLS then
		CastSpell(this.id, "spell")
	end
	if type(this.click) == "function" then
		this.click(this)
	end
	this.cast = nil
end

function ZSpellButton_UpdateButton(button)
	if not button then
		button = this
	end
	local spell, rank = GetSpellName(button.id, "spell")
	if not (spell == button.spell and rank == button.rank) then
		if not ZSpellButton_FindSpell(button) then
			return
		end
	end

	-- Setup Frame Variables
	local name = button:GetName()
	local icon = getglobal(name.."Icon")
	local cooldown = getglobal(name.."Cooldown")
	local texture = GetSpellTexture(button.id, "spell")

	-- Set Icon
	icon:SetTexture(texture)

	-- Set Cooldown
	local start, duration, enable = GetSpellCooldown(button.id, "spell")
	if start ~= 0 then
		button.onCooldown = 1
	end
	CooldownFrame_SetTimer(cooldown, start, duration, enable)
end

function ZSpellButton_FindSpell(button)
	if not button then
		button = this
	end
	if button.hidden then
		return
	end
	if not (button.spell and strlen(button.spell) > 0) then
		return
	end
	local temp, spell, rank = nil
	for i=1, MAX_SPELLS do
		spell, rank = GetSpellName(i, "spell")
		if button.spell == spell then
			temp = i
			if button.rank == rank then
				button.id = i
				return i
			end
		end
	end
	if temp then
		spell, rank = GetSpellName(temp, "spell")
		button.spell = spell
		button.rank = rank
		button.id = temp
		return i
	end
	return 
end

function ZSpellButton_Cooldown()
	local enableTime = (GetTime() - this.start) / this.duration
	if enableTime >= 1.0 then
		this:GetParent().onCooldown = nil
	end
end

function ZSpellButtonFrame_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_REGEN_ENABLED")
	this:RegisterEvent("PLAYER_REGEN_DISABLED")
end

function ZSpellButtonFrame_OnEvent()
	if event == "VARIABLES_LOADED" then
		
	elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" then
		ZSpellButtonInCombat = nil
	elseif event == "PLAYER_REGEN_DISABLED" then
		ZSpellButtonInCombat = 1
	end
end

function ZSpellButtonOptions_Changed()
	if type(this.func) == "function" then
		this.func(this)
	end
end

function ZSpellButton_OnEnter()
	if not this.tip then
		return
	end
	local anchor
	if this:GetCenter() < (UIParent:GetCenter() / 2) then
		anchor = "ANCHOR_TOPLEFT"
	else
		anchor = "ANCHOR_TOPRIGHT"
	end
	GameTooltip:SetOwner(this, anchor)
	GameTooltip:SetSpell(this.id, "spell")
end

function ZSpellButton_OnLeave()
	GameTooltip:Hide()
end