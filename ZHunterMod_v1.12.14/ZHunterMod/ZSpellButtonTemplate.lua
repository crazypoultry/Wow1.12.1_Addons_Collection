-- MAX_SPELLS = 1024

function ZSpellButton_SetButtons(parent, spells)
	if not (parent and parent.count and parent.name and spells) then return end
	parent.spells = spells
	if not GetSpellName(1, "spell") then
		parent:RegisterEvent("SPELLS_CHANGED")
		return -1
	end
	local spell, finished, temp
	local info = {}
	-- Find All Spell IDs
	for i=1, MAX_SPELLS do
		spell = GetSpellName(i, "spell")
		if not spell or finished then
			break
		end
		finished = 1
		for i2=1, table.getn(spells) do
			if not info[i2] then
				finished = nil
				if spells[i2] == spell then
					temp = i
					while spells[i2] == spell do
						temp = temp + 1
						spell = GetSpellName(temp, "spell")
					end
					info[i2] = (temp-1)
					break
				end
			end
		end
	end
	-- Hide All Children
	for i=1, parent.count do
		getglobal(parent.name..i):Hide()
	end
	local button
	local count = 1
	-- Set Children IDs
	for i, v in info do
		if count > parent.count then break end
		button = getglobal(parent.name..count)
		button.id = v
		ZSpellButton_UpdateButton(button)
		button:Show()
		-- Set The Parent To The First Spell
		if count == 1 then
			parent.id = v
			ZSpellButton_UpdateButton(parent)
			parent:Enable()
		end
		count = count + 1
	end
	return count - 1
end

function ZSpellButton_SetExpandDirection(parent, direction)
	local button = getglobal(parent.name.."1")
	local offset = parent:GetWidth() / 36
	if parent.circle:IsVisible() then
		offset = offset * 5
	else
		offset = offset * 3
	end
	button:ClearAllPoints()
	if direction == "TOP" then
		button:SetPoint("BOTTOM", parent, "TOP", 0, offset)
	elseif direction == "BOTTOM" then
		button:SetPoint("TOP", parent, "BOTTOM", 0, -1 * offset)
	elseif direction == "LEFT" then
		button:SetPoint("RIGHT", parent, "LEFT", -1 * offset, 0)
	elseif direction == "RIGHT" then
		button:SetPoint("LEFT", parent, "RIGHT", offset, 0)
	end
end

function ZSpellButton_ArrangeChildren(parent, rows, count, horizontal, vertical)
	if not (parent and parent.count and parent.name) then return end
	local left, right, top, bottom = "LEFT", "RIGHT", "TOP", "BOTTOM"
	local xoffset = parent:GetWidth() / 36
	xoffset = xoffset * 3
	local yoffset = -1 * xoffset
	if horizontal then
		left, right = "RIGHT", "LEFT"
		xoffset = xoffset * -1
	end
	if vertical then
		top, bottom = "BOTTOM", "TOP"
		yoffset = yoffset * -1
	end
	if count > parent.count then
		count = parent.count
	end
	local cols = ceil(count / rows)
	local temp = 1
	local button
	for i=2, parent.count do
		button = getglobal(parent.name..i)
		if i > count then
			button:Hide()
		else
			if button.id then
				button:Show()
			end
			button:ClearAllPoints()
			if temp >= cols then
				button:SetPoint(top, getglobal(parent.name..(i-temp)), bottom, 0, yoffset)
				temp = 1
			else
				button:SetPoint(left, getglobal(parent.name..(i-1)), right, xoffset, 0)
				temp = temp + 1
			end

		end
	end
end

function ZSpellButton_SetSize(parent, size, setChildren)
	local bgscale = 64 / 36
	local cdscale = 0.75 / 36
	if setChildren then
		local button
		for i=1, parent.count do
			button = getglobal(parent.name..i)
			button:SetHeight(size)
			button:SetWidth(size)
			button.background:SetWidth(size * bgscale)
			button.background:SetHeight(size * bgscale)
			button.cooldown:SetModelScale(size * cdscale)
		end
	else
		local cscale = 100/36
		local cxscale = 20 / 36
		local cyscale = -22 / 36
		parent:SetHeight(size)
		parent:SetWidth(size)
		parent.background:SetWidth(size * bgscale)
		parent.background:SetHeight(size * bgscale)
		parent.cooldown:SetModelScale(size * cdscale)
		parent.circle:SetWidth(size * cscale)
		parent.circle:SetHeight(size * cscale)
		parent.circle:SetPoint("CENTER", size * cxscale, size * cyscale)
	end
end

function ZSpellButton_UpdateButton(button)
	if not button then
		button = this
	end
	if not (button.id and button.icontexture) then return end
	local texture = button.icon or GetSpellTexture(button.id, "spell")
	button.icontexture:SetTexture(texture)
	button.icontexture:Show()
end

function ZSpellButton_UpdateCooldown(button)
	if not button then
		button = this
	end
	if not button.id then return end
	local start, duration, enable = GetSpellCooldown(button.id, "spell")
	CooldownFrame_SetTimer(button.cooldown, start, duration, enable)
	if not button.customcolor then
		local r, g, b = 1.0, 1.0, 1.0
		if enable ~= 1 then
			r, g, b = 0.4, 0.4, 0.4
		end
		button.icontexture:SetVertexColor(r, g, b)
	end
end

function ZSpellButton_CreateChildren(parent, name, count)
	if not (parent and name and count) then return end
	parent.children = CreateFrame("Frame", parent:GetName().."Children", UIParent)
	parent.count = count
	parent.name = name
	local button
	for i=1, count do
		button = CreateFrame("CheckButton", parent.name..i, parent.children, "ZSpellButtonChildTemplate")
		button.parent = parent
	end
end

function ZSpellButton_OnLoad()
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	local name = this:GetName()
	this.icontexture = getglobal(name.."IconTexture")
	this.cooldown = getglobal(name.."Cooldown")
	this.background = getglobal(name.."Background")
end

function ZSpellButton_OnEvent() 
	if event == "SPELL_UPDATE_COOLDOWN" then
		ZSpellButton_UpdateCooldown()
	end
end

function ZSpellButton_OnEnter()
	if this.parent.tooltip then
		GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT")
		GameTooltip:SetSpell(this.id, "spell")
	end
end

function ZSpellButton_OnClick()
	this:SetChecked(0)
	if type(this.parent.beforeclick) == "function" then
		if this.parent.beforeclick(this) then
			return
		end
	end
	CastSpell(this.id, "spell")
	if type(this.parent.afterclick) == "function" then
		if this.parent.afterclick(this) then
			return
		end
	end
	if this.parent.hideonclick then
		this.parent.children:Hide()
	end
end

function ZSpellButtonParent_OnLoad()
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	this:RegisterEvent("LEARNED_SPELL_IN_TAB")
	this:RegisterForDrag("LeftButton")
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	local name = this:GetName()
	this.icontexture = getglobal(name.."IconTexture")
	this.cooldown = getglobal(name.."Cooldown")
	this.background = getglobal(name.."Background")
	this.circle = getglobal(name.."Circle")
	this:Disable()
end

function ZSpellButtonParent_OnEvent()
	if event == "SPELL_UPDATE_COOLDOWN" then
		ZSpellButton_UpdateCooldown()
	elseif event == "LEARNED_SPELL_IN_TAB" then
		if this.name and this.count and this.spells then
			ZSpellButton_SetButtons(this, this.spells)
		end
	elseif event == "SPELLS_CHANGED" then
		this.found = ZSpellButton_SetButtons(this, this.spells)
		if this.found == 0 then
			this:Hide()
		end
		if this.found > -1 then
			this:UnregisterEvent("SPELLS_CHANGED")
		end
	end
end

function ZSpellButtonParent_OnEnter(frame)
	if not frame then
		frame = this
	end
	if frame.tooltip and frame.id then
		GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
		local msg, rank = GetSpellName(frame.id, "spell")
		if string.len(rank) > 0 then
			msg = msg.." ("..rank..")"
		end
		GameTooltip:SetText(msg, 1, 1, 1)
		GameTooltip:AddLine("Alt+Drag To Move This Button")
		if frame.options then
			GameTooltip:AddLine("Control+Alt+Shift+Click For Options")
		end
		GameTooltip:Show()
	end
end

function ZSpellButtonParent_OnClick()
	this:SetChecked(0)
	if IsControlKeyDown() and IsAltKeyDown() and IsShiftKeyDown() and this.options then
		if this.options:IsVisible() then
			this.options:Hide()
		else
			this.options:Show()
		end
	elseif arg1 == "RightButton" then
		if this.children:IsVisible() then
			this.children:Hide()
		else
			this.children:Show()
		end
	else
		if type(this.beforeclick) == "function" then
			if this.beforeclick(this) then
				return
			end
		end
		CastSpell(this.id, "spell")
		if type(this.afterclick) == "function" then
			if this.afterclick(this) then
				return
			end
		end
		if this.hideonclick then
			this.children:Hide()
		end
	end
end