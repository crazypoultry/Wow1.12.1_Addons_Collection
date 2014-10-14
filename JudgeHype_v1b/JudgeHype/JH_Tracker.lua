-- Pour le bon fonctionnement de l'addon, merci de ne pas modifier le code
-- Sharas, le 16 mai 2006 - http://worldofwarcraft.judgehype.com

JHT_UpdatePositionRate = 0.1;

function JHT_Init()
	if (JH_Main.Tracker == 1) then
		JHT_MainFrame:Show();
	else
		JHT_MainFrame:Hide();
	end
	JHT_PnjButton:Disable();
end

function JHT_GetMap(JHT_value,JHT_zvalue)
	JH_Main.TrackZone = "";
	JH_Main.TrackPnj = "";
	JH_Main.TrackLoc = "";
	JHT_zvalue = string.sub(JHT_zvalue, 11, 25);
	if (JHT_value) then
		for i, value in JHD_Database, 1 do
			local JHO_CurrentPnj = JHD_Database[i]["pnj"];
			local JHO_CurrentZone = JHD_Database[i]["zone"];
			if (JHT_value == JHO_CurrentPnj) then
				JHO_CurrentZone = string.sub(JHO_CurrentZone, 0, 15);
				if (JHT_zvalue == JHO_CurrentZone) then
					JH_Main.TrackZone = JHD_Database[i]["zone"];
					JH_Main.TrackPnj = JHD_Database[i]["pnj"];
					JH_Main.TrackLoc = JHD_Database[i]["loc"];
				end
			end
		end
		if (JH_Main.TrackZone ~= "") then
			JHT_MainFrame:Show();
			JHT_MapFrame:Show();
			JHT_JoueurMapFrame:Hide();
			JHT_PnjMapFrame:Show();
			JHT_PnjButton:Enable();
			JHT_PnjButton:LockHighlight();
			JHT_JoueurButton:UnlockHighlight();
			JHT_DisplayPnjMap();
		else
			JHT_CurrentPnjMap:SetTexture();
			JHT_PnjMapPosition:Hide();
			JHT_AffichagePnjText:SetText("Carte non disponible");
		end
	end
end

function JHT_CloseClick()
	JHT_MainFrame:Hide();
	JH_Main.Tracker = 0;
	JHO_TrackerButton1:SetChecked(JH_Main.Tracker);
end

function JHT_JoueurClick()
	if (not JHT_MapFrame:IsVisible()) then
		JHT_MapFrame:Show();
		JHT_PnjMapFrame:Hide();
		JHT_PnjButton:UnlockHighlight();
		JHT_JoueurMapFrame:Show();
		JHT_JoueurButton:LockHighlight();
	else
		if (JHT_JoueurMapFrame:IsVisible()) then
			JHT_MapFrame:Hide();
			JHT_JoueurButton:UnlockHighlight();
		else
			JHT_PnjMapFrame:Hide();
			JHT_PnjButton:UnlockHighlight();
			JHT_JoueurMapFrame:Show();
			JHT_JoueurButton:LockHighlight();
		end
	end
end

function JHT_PnjClick()
	if (not JHT_MapFrame:IsVisible()) then
		JHT_MapFrame:Show();
		JHT_JoueurMapFrame:Hide();
		JHT_JoueurButton:UnlockHighlight();
		JHT_PnjMapFrame:Show();
		JHT_PnjButton:LockHighlight();
	else
		if (JHT_PnjMapFrame:IsVisible()) then
			JHT_MapFrame:Hide();
			JHT_PnjButton:UnlockHighlight();
		else
			JHT_JoueurMapFrame:Hide();
			JHT_JoueurButton:UnlockHighlight();
			JHT_PnjMapFrame:Show();
			JHT_PnjButton:LockHighlight();
		end
	end
end

function JHT_DisplayPnjMap()
	local JHT_MapFound = 0;
	for i, value in JHD_Map, 1 do
		if (JHD_Map[i]["fr"] == JH_Main.TrackZone) then
			JHT_CurrentPnjMap:SetTexture("Interface\\AddOns\\JudgeHype\\Maps\\"..JHD_Map[i]["m"]);
			JHT_AffichagePnjText:SetText(JH_Main.TrackZone);
			local JHT_PnjPX = string.gsub(JH_Main.TrackLoc, "(%d+):(%d+)", "%1");
			local JHT_PnjPY = string.gsub(JH_Main.TrackLoc, "(%d+):(%d+)", "%2");
			local JHT_PnjPX = ((JHT_PnjPX * 3)-6);
			local JHT_PnjPY = -((JHT_PnjPY * 2)-6);
			JHT_PnjMapPosition:SetPoint("TOPLEFT", "JHT_PnjMapFrame", "TOPLEFT", JHT_PnjPX, JHT_PnjPY);
			JHT_PnjMapPosition:Show();
			JHT_MapFound = 1;
		end
	end
	if (JHT_MapFound == 0) then
		JHT_CurrentPnjMap:SetTexture();
		JHT_PnjMapPosition:Hide();
		JHT_AffichagePnjText:SetText("Carte non disponible");
	end
end

function JHT_UpdatePosition(arg1)
	JH_Main.TrackerTimer = JH_Main.TrackerTimer + arg1;
	if (JH_Main.TrackerTimer > JHT_UpdatePositionRate) then
		JH_Main.TrackerTimer = 0;
		local _,JHT_CurrentRealZoneName,JHT_px,JHT_py = JH_GetZoneLoc();
		local JHT_NewText = "Position "..JHT_px..":"..JHT_py;
		JHT_CurrentLocation:SetText(JHT_NewText);
		if (JH_Main.TrackerZone ~= JHT_CurrentRealZoneName) then
			JH_Main.TrackerZone = JHT_CurrentRealZoneName;
			JHT_GetCurrentMap();
		end
		
		if (JHT_JoueurMapFrame:IsVisible()) then
			JHT_DisplayPlayer();
		end
		if (JHT_PnjMapFrame:IsVisible()) then
			if (JH_Main.TrackerZone == JH_Main.TrackZone) then
				JHT_PlayerPnjMapPosition:Show();
				JHT_DisplayPlayerOnPnj();
			else
				JHT_PlayerPnjMapPosition:Hide();
			end
		end
	end
end

function JHT_GetCurrentMap()
	local _,JHT_CurrentRealZoneName,JHT_px,JHT_py,JHT_c = JH_GetZoneLoc();
	local JHT_MapFound = 0;
	for i, value in JHD_Map, 1 do
		if (JHD_Map[i]["fr"] == JHT_CurrentRealZoneName or JHD_Map[i]["en"] == JHT_CurrentRealZoneName) then
			JHT_CurrentJoueurMap:SetTexture("Interface\\AddOns\\JudgeHype\\Maps\\"..JHD_Map[i]["m"]);
			JHT_AffichageJoueurText:SetText(JHT_CurrentRealZoneName);
			JHT_MapFound = 1;
		end
	end
	if (JHT_MapFound == 0) then
		if (JHT_px~=0 and JHT_py~=0) then
			local foundcontinent = 0;
			if (JHT_c==1) then foundcontinent=1; JHT_CurrentJoueurMap:SetTexture("Interface\\AddOns\\JudgeHype\\Maps\\kalimdor"); end
			if (JHT_c==2) then foundcontinent=1; JHT_CurrentJoueurMap:SetTexture("Interface\\AddOns\\JudgeHype\\Maps\\royaumesdelest"); end
			if (foundcontinent==0) then JHT_CurrentJoueurMap:SetTexture(); JHT_AffichageJoueurText:SetText("Carte non disponible"); end
			if (foundcontinent==1) then JHT_AffichageJoueurText:SetText(JHT_CurrentRealZoneName); end
		else
			JHT_CurrentJoueurMap:SetTexture();
			JHT_AffichageJoueurText:SetText("Carte non disponible");
		end
	end
end

function JHT_DisplayPlayer()
	local _,_,JHT_px,JHT_py = JH_GetPreciseZoneLoc();
	if (JHT_px == 0 and JHT_py == 0) then
		JHT_PlayerPosition:Hide();
	else
		local JHT_PlayerPX = (JHT_px-6);
		local JHT_PlayerPY = -(JHT_py-6);
		JHT_PlayerPosition:Show();
		JHT_PlayerPosition:SetPoint("TOPLEFT", "JHT_JoueurMapFrame", "TOPLEFT", JHT_PlayerPX, JHT_PlayerPY);
	end
end

function JHT_DisplayPlayerOnPnj()
	local _,_,JHT_px,JHT_py = JH_GetPreciseZoneLoc();
	local JHT_PlayerPX = (JHT_px-6);
	local JHT_PlayerPY = -(JHT_py-6);
	JHT_PlayerPnjMapPosition:SetPoint("TOPLEFT", "JHT_PnjMapFrame", "TOPLEFT", JHT_PlayerPX, JHT_PlayerPY);
end

function JH_GetZoneLoc()
	SetMapToCurrentZone();
	local JH_mapContinent = GetCurrentMapContinent();
	local JH_mapZone = GetCurrentMapZone();
	SetMapZoom(JH_mapContinent,JH_mapZone);
	local JH_CurrentZoneName = GetZoneText();
	local JH_CurrentRealZoneName = GetRealZoneText();
	local JH_px, JH_py = GetPlayerMapPosition("player");
	JH_px = floor(JH_px*100);
	JH_py = floor(JH_py*100);
	return JH_CurrentZoneName,JH_CurrentRealZoneName,JH_px,JH_py,JH_mapContinent;
end

function JH_GetPreciseZoneLoc()
	SetMapToCurrentZone();
	local JH_mapContinent = GetCurrentMapContinent();
	local JH_mapZone = GetCurrentMapZone();
	SetMapZoom(JH_mapContinent,JH_mapZone);
	local JH_CurrentZoneName = GetZoneText();
	local JH_CurrentRealZoneName = GetRealZoneText();
	local JH_px, JH_py = GetPlayerMapPosition("player");
	JH_px = floor(JH_px*300);
	JH_py = floor(JH_py*200);
	return JH_CurrentZoneName,JH_CurrentRealZoneName,JH_px,JH_py;
end
