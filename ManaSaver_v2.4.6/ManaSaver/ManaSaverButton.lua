-- Code modified from Atlas

function ManaSaverButton_OnClick()
	MSaver_SlashOpenOptions();
end

function ManaSaverButton_Init()
	if(ManaSaverSV.MiniMapButtonShown) then
		ManaSaverButtonFrame:Show();
	else
		ManaSaverButtonFrame:Hide();
	end
end

function ManaSaverButton_Toggle()
	if(ManaSaverButtonFrame:IsVisible()) then
		ManaSaverButtonFrame:Hide();
		ManaSaverSV.MiniMapButtonShown = false;
	else
		ManaSaverButtonFrame:Show();
		ManaSaverSV.MiniMapButtonShown = true;
	end
end

function ManaSaverButton_UpdatePosition()
	ManaSaverButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(ManaSaverSV.MiniMapButtonPos)),
		(78 * sin(ManaSaverSV.MiniMapButtonPos)) - 55
	);
end
