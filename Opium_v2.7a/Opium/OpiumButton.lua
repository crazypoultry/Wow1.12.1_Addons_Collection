OPIUM_BUTTON_TOOLTIP = "Toggle Opium";

function OpiumButton_OnClick()
	ToggleOpium();
end


function OpiumButton_Toggle()
	if(OpiumData.config.mmbutton) then
		OpiumButtonFrame:Hide();
		OpiumData.config.mmbutton = false;
	else
		OpiumButtonFrame:Show();
        	OpiumData.config.mmbutton = true;
	end
end

function OpiumButton_UpdatePosition()
	OpiumButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		55 - (75 * cos(OpiumData.config.mmbuttonposition)),
		(75 * sin(OpiumData.config.mmbuttonposition)) - 55
	);
end