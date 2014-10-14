function mrp_ToggleButton_OnClick()
	if (mrpUniversalFrame:IsShown()) then
		mrpUniversalFrame:Hide();
		mrpUniversalFrameState = 0;
	else
		mrpUniversalFrame:Show();
		mrpUniversalFrameState = 1;
	end
end

function mrpHideAllFrames()
	if (mrpCharacterFrame:IsShown()) then
		mrpCharacterFrame:Hide();
	end
	if (mrpOptionsFrame:IsShown()) then
		mrpOptionsFrame:Hide();
	end
	if (mrpColourFrame:IsShown()) then
		mrpColourFrame:Hide();
	end
	if (mrpTooltipFrame:IsShown()) then
		mrpTooltipFrame:Hide();
	end
end

function mrpHidePageFrames()
	if (mrpOptionsPage1:IsShown()) then
		mrpOptionsPage1:Hide();
	end
	if (mrpOptionsPage2:IsShown()) then
		mrpOptionsPage2:Hide();
	end
	if (mrpOptionsPage3:IsShown()) then
		mrpOptionsPage3:Hide();
	end
end


function mrpCheckOptionPageButtons()
	if (mrpOptionsPage1:IsShown()) then
		mrpOptionsPage1Button:Enable();		
		mrpOptionsPage1Button:SetChecked(nil);
	end	
	if (mrpOptionsPage2:IsShown()) then
		mrpOptionsPage2Button:Enable();		
		mrpOptionsPage2Button:SetChecked(nil);
	end	
	if (mrpOptionsPage3:IsShown()) then
		mrpOptionsPage3Button:Enable();		
		mrpOptionsPage3Button:SetChecked(nil);
	end	
end


function mrpCheckButtons()
	if (mrpColourFrame:IsShown()) then
		mrpColourButton:Enable();		
		mrpColourButton:SetChecked(nil);
	end	
	if (mrpOptionsFrame:IsShown()) then
		mrpOptionsButton:Enable();		
		mrpOptionsButton:SetChecked(nil);
	end	
	if (mrpCharacterFrame:IsShown()) then
		mrpCharacterButton:Enable();		
		mrpCharacterButton:SetChecked(nil);
	end
	if (mrpTooltipFrame:IsShown()) then
		mrpTooltipButton:Enable();		
		mrpTooltipButton:SetChecked(nil);
	end
end
