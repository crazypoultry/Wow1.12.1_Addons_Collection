function TitanAggro_Icons_OnLoad()
	-- Register for events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
end


TitanAggro_Icons_OnEvent = { };
TitanAggro_Icons_OnEvent["PLAYER_ENTERING_WORLD"] = function ()
	TitanAggro_Icons_UpdateIcon("PlayerFrame", "player", false);
end

TitanAggro_Icons_OnEvent["PARTY_MEMBERS_CHANGED"] = function ()
	for i = 1, 4 do
		TitanAggro_Icons_UpdateIcon("PartyMemberFrame"..i, "party"..i, false);
	end
end



function TitanAggro_Icons_ResetIcon()
	TitanAggro_Icons_UpdateIcon("PlayerFrame", "player", false);
	TitanAggro_Icons_UpdateIcon("PetFrame", "pet", false);

	for i = 1, 4 do
		TitanAggro_Icons_UpdateIcon("PartyMemberFrame"..i, "party"..i, false);
	end
end

function TitanAggro_Icons_GetFrameNameByUnit(unit)
	if(unit == "player") then
		return "PlayerFrame";
	elseif(unit == "pet") then
		return "PetFrame";
	elseif(unit == "party1") then
		return "PartyMemberFrame1";
	elseif(unit == "party2") then
		return "PartyMemberFrame2";
	elseif(unit == "party3") then
		return "PartyMemberFrame3";
	elseif(unit == "party4") then
		return "PartyMemberFrame4";
	end
end

function TitanAggro_Icons_ShowIconByUnit(unit)
	TitanAggro_Icons_UpdateIcon(TitanAggro_Icons_GetFrameNameByUnit(unit), unit, true);
end

function TitanAggro_Icons_UpdateIcon(frame, unit, aggro)
	if (not frame) or (not unit) then
		return;
	end

	local icon = getglobal(frame.."TitanAggroIcon");
	local texture = getglobal(frame.."TitanAggroIconButton");
	local iconGlow = getglobal(frame.."TitanAggroIconGlow");
	local iconGlowTexture = getglobal(frame.."TitanAggroIconGlowTexture");

	if (not icon) then TitanAggro_Debug("no icon"); end
	if (not texture) then TitanAggro_Debug("no texture"); end
	if (not iconGlow) then TitanAggro_Debug("no glow"); end

	if (not icon) or (not texture) or (not iconGlow) then
		return;
	end

	if (aggro == false) then
		if (icon:IsVisible()) then
			icon:Hide();
			iconGlow:Hide();
			iconGlowTexture:SetVertexColor(1.0,0.13,0.13);
		end
		return;
	else
		if (not icon:IsVisible()) then
			icon:Show();
			iconGlow:Show();
			local name = UnitName(unit);
			if (name) then
				local _, uclass = UnitClass(unit);
				if (uclass == "Warrior" or (TitanAggroGetVar("TankMode") > 0 and UnitName(unit) == UnitName("player"))) then
					iconGlowTexture:SetVertexColor(0.13,1.0,0.13);
				else
					iconGlowTexture:SetVertexColor(1,0.82,0);
				end
			end

		end
	end
	--texture:SetTexture("Interface\\AddOns\\TitanAggroAlert\\Icons\\AGGRO");
end

function TitanAggro_Icons_OnUpdate(elapsed)
	if (not this.statusCounter or not this.statusSign) then
		this.statusCounter = 0;
		this.statusSign = 1;
	end

	if (this:IsVisible()) then
		local alpha = 255;
		local counter = this.statusCounter + elapsed;
		local sign    = this.statusSign;

		if (counter > 0.5) then
			sign = -sign;
			this.statusSign = sign;
		end
		counter = mod(counter, 0.5);
		this.statusCounter = counter;

		if (sign == 1) then
			alpha = (55  + (counter * 400)) / 255;
		else
			alpha = (255 - (counter * 400)) / 255;
		end
		this:SetAlpha(alpha);
	end
end


function TitanAggro_Icons_OnEnter()
	if (TitanAggroGetVar("AggroDetect") == 0) then
		return;
	end
	local id = this:GetParent():GetID();
	if (id==0) then
		unit = "player";
	elseif (id == 5) then
		unit = "pet";
	else
		unit = "party"..id;
	end

	local tooltip = getglobal("TitanAggroTooltip");
	tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	tooltip:SetText(TitanAggro_GetAggroTooltip(unit));
	tooltip:Show();
end

function TitanAggro_Icons_OnLeave()
	local tooltip = getglobal("TitanAggroTooltip");
	if(tooltip:IsVisible()) then
		tooltip:Hide();
	end
end

function TitanAggro_Icons_OnClick()
	local unit;
	local id = this:GetParent():GetID();
	if (id==0) then
		unit = "player";
	else
		unit = "party"..id;
	end
	TitanAggro_SelectTargeterOnUnit(unit);
end
