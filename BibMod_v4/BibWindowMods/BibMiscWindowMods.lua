
function ShapeshiftBar_Update()
	local numForms = GetNumShapeshiftForms();
	local fileName, name, isActive, isCastable;
	local button, icon, cooldown;
	local start, duration, enable;

	if ( numForms > 0 ) then
		ShapeshiftBarFrame:Show();
	else
		ShapeshiftBarFrame:Hide();
	end
	
	for i=1, NUM_SHAPESHIFT_SLOTS do
		button = getglobal("ShapeshiftButton"..i);
		icon = getglobal("ShapeshiftButton"..i.."Icon");
		if ( i <= numForms ) then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i);
			icon:SetTexture(texture);
			
			--Cooldown stuffs
			cooldown = getglobal("ShapeshiftButton"..i.."Cooldown");
			if ( texture ) then
				cooldown:Show();
			else
				cooldown:Hide();
			end
			start, duration, enable = GetShapeshiftFormCooldown(i);
			CooldownFrame_SetTimer(cooldown, start, duration, enable);
			
			if ( isActive ) then
				ShapeshiftBarFrame.lastSelected = button:GetID();
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

function ShowPetActionBar()
	if ( PetHasActionBar() and PetActionBarFrame.showgrid == 0 and (PetActionBarFrame.mode ~= "show") and not PetActionBarFrame.locked and not PetActionBarFrame.ctrlPressed ) then
		PetActionBarFrame:Show();
		if ( PetActionBarFrame.completed ) then
			PetActionBarFrame.slideTimer = 0;
		end
		PetActionBarFrame.timeToSlide = PETACTIONBAR_SLIDETIME;
		PetActionBarFrame.yTarget = PETACTIONBAR_YPOS;
		PetActionBarFrame.mode = "show";
	end
end

function HidePetActionBar()
	if ( PetActionBarFrame.showgrid == 0 and PetActionBarFrame:IsVisible() and not PetActionBarFrame.locked and not PetActionBarFrame.ctrlPressed ) then
		if ( PetActionBarFrame.completed ) then
			PetActionBarFrame.slideTimer = 0;
		end
		PetActionBarFrame.timeToSlide = PETACTIONBAR_SLIDETIME;
		PetActionBarFrame.yTarget = PETACTIONBAR_YPOS;
		PetActionBarFrame.mode = "hide";
	end
end
