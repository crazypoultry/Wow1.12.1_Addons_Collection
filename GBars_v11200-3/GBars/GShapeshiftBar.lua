-- Copyright (c) 2005 William J. Rogers <wjrogers@gmail.com>
-- This file is released under the terms of the GNU General Public License v2

function GShapeshiftBar_OnLoad()
	-- remove events from old frame
	ShapeshiftBarFrame:UnregisterEvent("UPDATE_SHAPESHIFT_FORMS");
	ShapeshiftBarFrame:UnregisterEvent("ACTIONBAR_UPDATE_USABLE");
	ShapeshiftBarFrame:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
	ShapeshiftBarFrame:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
	ShapeshiftBarFrame:UnregisterEvent("SPELL_UPDATE_USABLE");
	ShapeshiftBarFrame:UnregisterEvent("PLAYER_AURAS_CHANGED");
	ShapeshiftBarFrame:UnregisterEvent("ACTIONBAR_PAGE_CHANGED");
	ShapeshiftBarFrame:UnregisterEvent("UNIT_HEALTH");
	ShapeshiftBarFrame:UnregisterEvent("UNIT_HEALTH");
	ShapeshiftBarFrame:UnregisterEvent("UNIT_RAGE");
	ShapeshiftBarFrame:UnregisterEvent("UNIT_FOCUS");
	ShapeshiftBarFrame:UnregisterEvent("UNIT_ENERGY");
	ShapeshiftBar_Update = function() end

	-- set up the tricky dock code, compensate for scaling (bug?)
	this.basename = "GShapeshiftButton"
	this.first, this.last = 1, 10
	this.Dock = function(this)
		-- this:SetScale(1)
		factor = UIParent:GetScale() / this:GetScale()
		this:ClearAllPoints()
		this:SetPoint("BOTTOMLEFT", "$parent", "BOTTOMLEFT", 490 * factor, 8 * factor)
		GBars_LayoutHorizontal(this)
	end

	-- register events to this frame
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	this:RegisterEvent("SPELL_UPDATE_USABLE")
	this:RegisterEvent("PLAYER_AURAS_CHANGED")
	this:RegisterEvent("UNIT_HEALTH")
	this:RegisterEvent("UNIT_RAGE")
	this:RegisterEvent("UNIT_FOCUS")
	this:RegisterEvent("UNIT_ENERGY")
	GShapeshiftBar_Update()
end

function GShapeshiftBar_Update()
	local numForms = GetNumShapeshiftForms()
	local name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable

	-- hide if we're not a shapeshifter
	if (numForms > 0 and not GShapeshiftBar.hidden) then
		GShapeshiftBar:Show()
	else
		GShapeshiftBar:Hide()
		return
	end

	-- for some reason this won't stick
	-- GShapeshiftBar:SetScale(1)

	-- we don't want to waste cpu on processing unnecessary events
	if ((event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS") and arg1 ~= "player") then return; end

	-- update each shapeshift button's usability
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		button = getglobal("GShapeshiftButton"..i);
		icon = getglobal("GShapeshiftButton"..i.."Icon");
		if ( i <= numForms ) then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i);
			icon:SetTexture(texture);
			
			--Cooldown stuffs
			cooldown = getglobal("GShapeshiftButton"..i.."Cooldown");
			if ( texture ) then
				cooldown:Show();
			else
				cooldown:Hide();
			end
			start, duration, enable = GetShapeshiftFormCooldown(i);
			CooldownFrame_SetTimer(cooldown, start, duration, enable);
			
			if ( isActive ) then
				GShapeshiftBar.lastSelected = button:GetID();
				button:SetChecked(1);
			else
				button:SetChecked(0);
			end

			if ( isCastable ) then
				icon:SetVertexColor(1.0, 1.0, 1.0);
			else
				icon:SetVertexColor(0.4, 0.4, 0.4);
			end

			button:Show();
		else
			button:Hide();
		end
	end
end
