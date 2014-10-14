-- Pour le bon fonctionnement de l'addon, merci de ne pas modifier le code
-- Sharas, le 16 mai 2006 - http://worldofwarcraft.judgehype.com

function JHM_Init()
	if (JH_Main.Minimap == 1) then
		JHM_MainFrame:Show();
	else
		JHM_MainFrame:Hide();
	end
end

function JHM_OnClick()
	if(JHO_MainFrame:IsVisible()) then
		JHO_MainFrame:Hide();
	else
		JHO_MainFrame:Show();
		JHO_IntroFrame:Show();
		JHO_CollectorFrame:Hide();
		JHO_ProfilerFrame:Hide();
		JHO_TrackerFrame:Hide();
	end
end

function JHM_UpdatePosition()
	JHM_MainFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(JH_Main.Position)),
		(78 * sin(JH_Main.Position)) - 55
	);
end
