-- Pour le bon fonctionnement de l'addon, merci de ne pas modifier le code
-- Sharas, le 30 mai 2006 - http://worldofwarcraft.judgehype.com

function JHO_Init()
	JHO_IntroButton1:SetChecked(JH_Main.Minimap);
	JHO_IntroButton2:SetChecked(JH_Main.Accueil);
	if (JH_Main.Calerte==0 or JH_Main.Calerte==1) then JHO_IntroButton3:SetChecked(JH_Main.Calerte); end
	JHO_IntroSlider1:SetValue(JH_Main.Position);
	JHO_CollectorButton1:SetChecked(JH_Main.Collector);
	JHO_CollectorButton2:SetChecked(JH_Main.CollectorMetier);
	JHO_ProfilerButton1:SetChecked(JH_Main.Profiler);
	JHO_TrackerButton1:SetChecked(JH_Main.Tracker);
	JHO_ProfilerInnerFrame2Text:SetText(JHO_PROFILERTEXT..UnitName("player").." sur "..GetCVar("realmName").."|r.");
	JHO_TrackerInnerFrame2Text:SetText("|cffffffffTrouver un PNJ - "..JHD_TRACKERVERSION);
	JHO_UpdateCollector();
end

function JHO_ShowIntro()
	JHO_IntroFrame:Show();
	JHO_CollectorFrame:Hide();
	JHO_ProfilerFrame:Hide();
	JHO_TrackerFrame:Hide();
end

function JHO_ShowCollector()
	JHO_IntroFrame:Hide();
	JHO_CollectorFrame:Show();
	JHO_ProfilerFrame:Hide();
	JHO_TrackerFrame:Hide();
	JHO_UpdateCollector();
end

function JHO_ShowProfiler()
	JHO_IntroFrame:Hide();
	JHO_CollectorFrame:Hide();
	JHO_ProfilerFrame:Show();
	JHO_TrackerFrame:Hide();
end

function JHO_ShowTracker()
	JHO_IntroFrame:Hide();
	JHO_CollectorFrame:Hide();
	JHO_ProfilerFrame:Hide();
	JHO_TrackerFrame:Show();
end

function JHO_Close()
	JHO_MainFrame:Hide();
end

function JHO_IntroButton1_Click()
	if (JHM_MainFrame:IsVisible()) then
		JH_Main.Minimap = 0;
		JHM_MainFrame:Hide();
	else
		JH_Main.Minimap = 1;
		JHM_MainFrame:Show();
	end
end

function JHO_IntroButton2_Click()
	if (JH_Main.Accueil == 1) then
		JH_Main.Accueil = 0;
	else
		JH_Main.Accueil = 1;
	end
end

function JHO_IntroButton3_Click()
	if (JH_Main.Calerte == 1) then
		JH_Main.Calerte = 0;
	else
		JH_Main.Calerte = 1;
	end
end

function JHO_CollectorButton1_Click()
	if (JH_Main.Collector == 1) then
		JH_Main.Collector = 0;
		JH_Main.CollectorMetier = 0;
		JH_Main.Calerte = 0;
		JHO_CollectorButton2:Disable();
		JHO_IntroButton3:Disable();
	else
		if (GetLocale()=="frFR") then
			JH_Main.Collector = 1;
			JHO_CollectorButton2:Enable();
			JHO_IntroButton3:Enable();
			JHC_QuestUpdate();
		end
	end
	JHO_Init();
end

function JHO_CollectorButton2_Click()
	if (JH_Main.CollectorMetier == 1) then
		JH_Main.CollectorMetier = 0;
	else
		JH_Main.CollectorMetier = 1;
	end
end

function JHO_CollectorButton3_Click()
	JH_ResetAddon();
	if (JH_Main.Collector == 1 and GetLocale()=="frFR") then
		JHC_QuestUpdate();
	end
	JHO_UpdateCollector();
end

function JHO_UpdateCollector()
	if (not JH_Main.cc) then JH_Main.cc = {} end
	if (not JH_Main.ccn) then JH_Main.ccn = {} end
	if (not JH_Main.cc.pnjs) then JH_Main.cc.pnjs = 0; end
	if (not JH_Main.ccn.pnjs) then JH_Main.ccn.pnjs = ""; end
	if (not JH_Main.cc.monstres) then JH_Main.cc.monstres = 0; end
	if (not JH_Main.ccn.monstres) then JH_Main.ccn.monstres = ""; end
	if (not JH_Main.cc.objets) then	JH_Main.cc.objets = 0; end
	if (not JH_Main.ccn.objets) then	JH_Main.ccn.objets = ""; end
	if (not JH_Main.cc.quetes) then JH_Main.cc.quetes = 0; end
	if (not JH_Main.ccn.quetes) then JH_Main.ccn.quetes = ""; end
	if (not JH_Main.cc.containers) then	JH_Main.cc.containers = 0; end
	if (not JH_Main.ccn.containers) then	JH_Main.ccn.containers = ""; end
	if (not JH_Main.cc.vendu) then JH_Main.cc.vendu = 0; end
	if (not JH_Main.ccn.vendu) then JH_Main.ccn.vendu = ""; end
	if (not JH_Main.cc.ts) then JH_Main.cc.ts = 0; end
	if (not JH_Main.ccn.ts) then JH_Main.ccn.ts = ""; end
	if (not JH_Main.cc.trainers) then JH_Main.cc.trainers = 0; end
	if (not JH_Main.ccn.trainers) then JH_Main.ccn.trainers = ""; end
	if (not JH_Main.cc.locs) then JH_Main.cc.locs = 0; end
	if (not JH_Main.ccn.locs) then JH_Main.ccn.locs = ""; end
	local temp1 = ""; local temp2 = ""; local temp3 = ""; local temp4 = ""; local temp5 = "";
	local temp6 = ""; local temp7 = ""; local temp8 = ""; local temp9 = "";
	if (JH_Main.ccn.objets ~= "") then temp1 = " - R\195\169cent : "..JH_Main.ccn.objets; end
	if (JH_Main.ccn.pnjs ~= "") then temp2 = " - R\195\169cent : |cffffffff["..JH_Main.ccn.pnjs.."]|r"; end
	if (JH_Main.ccn.monstres ~= "") then temp3 = " - R\195\169cent : |cffffffff["..JH_Main.ccn.monstres.."]|r"; end
	if (JH_Main.ccn.quetes ~= "") then temp4 = " - R\195\169cent : |cffffffff["..JH_Main.ccn.quetes.."]|r"; end
	if (JH_Main.ccn.containers ~= "") then temp5 = " - R\195\169cent : |cffffffff["..JH_Main.ccn.containers.."]|r"; end
	if (JH_Main.ccn.vendu ~= "") then temp6 = " - R\195\169cent : "..JH_Main.ccn.vendu; end
	if (JH_Main.ccn.locs ~= "") then temp7 = " - R\195\169cent : |cffffffff["..JH_Main.ccn.locs.."]|r"; end
	if (JH_Main.ccn.trainers ~= "") then temp8 = " - R\195\169cent : |cffffffff["..JH_Main.ccn.trainers.."]|r"; end
	if (JH_Main.ccn.ts ~= "") then temp9 = " - R\195\169cent : |cffffffff["..JH_Main.ccn.ts.."]|r"; end
	JHO_CollectorInnerFrame2Text:SetText(JHO_PURGETEXT..JH_Main.DerPurge);
	JHO_CollectorText1:SetText("Objets : |cffffffff"..JH_Main.cc.objets.."|r"..temp1);
	JHO_CollectorText2:SetText("PNJs : |cffffffff"..JH_Main.cc.pnjs.."|r"..temp2);
	JHO_CollectorText3:SetText("Monstres : |cffffffff"..JH_Main.cc.monstres.."|r"..temp3);
	JHO_CollectorText4:SetText("Qu\195\170tes : |cffffffff"..JH_Main.cc.quetes.."|r"..temp4);
	JHO_CollectorText5:SetText("Conteneurs : |cffffffff"..JH_Main.cc.containers.."|r"..temp5);
	JHO_CollectorText6:SetText("Prix de vente : |cffffffff"..JH_Main.cc.vendu.."|r"..temp6);
	JHO_CollectorText7:SetText("Coordonn\195\169es : |cffffffff"..JH_Main.cc.locs.."|r"..temp7);
	JHO_CollectorText8:SetText("Comp\195\169tences : |cffffffff"..JH_Main.cc.trainers.."|r"..temp8);
	JHO_CollectorText9:SetText("Professions : |cffffffff"..JH_Main.cc.ts.."|r"..temp9);
end

function JHO_ProfilerButton1_Click()
	if (JH_Main.Profiler == 1) then
		JH_Main.Profiler = 0;
		JHP_MainFrame:Hide();
	else
		JH_Main.Profiler = 1;
		JHP_MainFrame:Show();
	end
end

function JHO_ProfilerBrowseUp()
	JH_Main.ProfilerPage = (JH_Main.ProfilerPage + 1);
	JHO_ProfilerList();
end

function JHO_ProfilerBrowseDown()
	JH_Main.ProfilerPage = (JH_Main.ProfilerPage - 1);
	JHO_ProfilerList();
end

function JHO_ProfilerList()
	local JHO_CurrentPage = JH_Main.ProfilerPage;
	
	JHO_ProfilerResult1:SetText("");
	JHO_ProfilerResult2:SetText("");
	JHO_ProfilerResult3:SetText("");
	JHO_ProfilerResult4:SetText("");
	JHO_ProfilerResult5:SetText("");
	JHO_ProfilerResult6:SetText("");
	JHO_ProfilerResult7:SetText("");
	JHO_ProfilerResult8:SetText("");
	JHO_DeleteProfilButton1:Hide();
	JHO_DeleteProfilButton2:Hide();
	JHO_DeleteProfilButton3:Hide();
	JHO_DeleteProfilButton4:Hide();
	JHO_DeleteProfilButton5:Hide();
	JHO_DeleteProfilButton6:Hide();
	JHO_DeleteProfilButton7:Hide();
	JHO_DeleteProfilButton8:Hide();
	JHO_ProfilerPrevButton:Hide();
	JHO_ProfilerNextButton:Hide();
	
	local NumEntry = getn(JH_Profiler);
	
	if (NumEntry > 8) then
		JHO_ProfilerPrevButton:Show();
		JHO_ProfilerNextButton:Show();
	else
		JHO_ProfilerPrevButton:Hide();
		JHO_ProfilerNextButton:Hide();
	end
		
	if (JHO_CurrentPage == 1) then
		JHO_ProfilerPrevButton:Disable();
	else
		JHO_ProfilerPrevButton:Enable();
	end

	if (NumEntry > (JHO_CurrentPage*8)) then
		JHO_ProfilerNextButton:Enable();
	else
		JHO_ProfilerNextButton:Disable();
	end
		
	local JHO_TotalPage = (1+(floor(NumEntry/8)));
	JHO_ProfilerNextButtonText:SetText("Page "..JHO_CurrentPage.." sur "..JHO_TotalPage);

	local JHO_ResultPosition = 1;

	local JHO_FromPage = (JHO_CurrentPage*8)-7;
	local JHO_CurrentMaxAllow = JHO_FromPage+8;

	local JHO_ListProfil = 0;
	for i=1, NumEntry, 1 do
		JHO_ListProfil = JHO_ListProfil + 1;
		local currentdisplay = JH_Profiler[i]["newprofil"]["common"]["showing"];
		
		if (JHO_ListProfil < JHO_FromPage or JHO_ListProfil > JHO_CurrentMaxAllow) then
			-- empty
		else
			if (JHO_ResultPosition == 1) then
				JHO_ProfilerResult1:SetText(currentdisplay);
				JHO_DeleteProfilButton1:Show();
				JHO_ProfilerDelValue1 = currentdisplay;
			end
			if (JHO_ResultPosition == 2) then
				JHO_ProfilerResult2:SetText(currentdisplay);
				JHO_DeleteProfilButton2:Show();
				JHO_ProfilerDelValue2 = currentdisplay;
			end
			if (JHO_ResultPosition == 3) then
				JHO_ProfilerResult3:SetText(currentdisplay);
				JHO_DeleteProfilButton3:Show();
				JHO_ProfilerDelValue3 = currentdisplay;
			end
			if (JHO_ResultPosition == 4) then
				JHO_ProfilerResult4:SetText(currentdisplay);
				JHO_DeleteProfilButton4:Show();
				JHO_ProfilerDelValue4 = currentdisplay;
			end
			if (JHO_ResultPosition == 5) then
				JHO_ProfilerResult5:SetText(currentdisplay);
				JHO_DeleteProfilButton5:Show();
				JHO_ProfilerDelValue5 = currentdisplay;
			end
			if (JHO_ResultPosition == 6) then
				JHO_ProfilerResult6:SetText(currentdisplay);
				JHO_DeleteProfilButton6:Show();
				JHO_ProfilerDelValue6 = currentdisplay;
			end
			if (JHO_ResultPosition == 7) then
				JHO_ProfilerResult7:SetText(currentdisplay);
				JHO_DeleteProfilButton7:Show();
				JHO_ProfilerDelValue7 = currentdisplay;
			end
			if (JHO_ResultPosition == 8) then
				JHO_ProfilerResult8:SetText(currentdisplay);
				JHO_DeleteProfilButton8:Show();
				JHO_ProfilerDelValue8 = currentdisplay;
			end
			JHO_ResultPosition = JHO_ResultPosition + 1;
		end
	end
	if (JHO_ResultPosition == 1 and JHO_TotalProfil ~= 0 and NumEntry ~= 0) then
		JH_Main.ProfilerPage = (JH_Main.ProfilerPage - 1);
		JHO_ProfilerList();
	end
end

function JHO_Deleteprofil(todel)
	local NumEntry = getn(JH_Profiler);
	for i=1, NumEntry, 1 do
		local currentdisplay = JH_Profiler[i]["newprofil"]["common"]["showing"];
		if (todel == currentdisplay) then
			todel = i;
		end
	end
	table.remove(JH_Profiler, todel);
	JHO_ProfilerList();
end

function JHO_TrackerButton1_Click()
	if (JH_Main.Tracker == 1) then
		JH_Main.Tracker = 0;
		JHT_MainFrame:Hide();
	else
		JH_Main.Tracker = 1;
		JHT_MainFrame:Show();
	end
end

function JH0_TrackerButton3_Click()
	JHO_TrackerInput:SetText("");
	JH0_TrackerResult1:SetText("");
	JH0_TrackerResult1bis:SetText("");
	JH0_TrackerResult2:SetText("");
	JH0_TrackerResult2bis:SetText("");
	JH0_TrackerResult3:SetText("");
	JH0_TrackerResult3bis:SetText("");
	JH0_TrackerResult4:SetText("");
	JH0_TrackerResult4bis:SetText("");
	JH0_TrackerResult5:SetText("");
	JH0_TrackerResult5bis:SetText("");
	JH0_TrackerResult6:SetText("");
	JH0_TrackerResult6bis:SetText("");
	JH0_TrackerResult7:SetText("");
	JH0_TrackerResult7bis:SetText("");
	JH0_TrackerResult8:SetText("");
	JH0_TrackerResult8bis:SetText("");
	JH0_TrackerResult9:SetText("");
	JH0_TrackerResult9bis:SetText("");
	JH0_TrackerResult10:SetText("");
	JH0_TrackerResult10bis:SetText("");
	JHO_TrackerPrevButton:Hide();
	JHO_TrackerNextButton:Hide();
	JH_Main.TrackerPage = 1;
	JH_Main.TrackZone = "";
	JH_Main.TrackPnj = "";
	JH_Main.TrackLoc = "";
	
	if (JHT_PnjMapFrame:IsVisible()) then
		JHT_MapFrame:Hide();
		JHT_PnjButton:UnlockHighlight();
		JHT_PnjButton:Disable();
	else
		JHT_PnjButton:UnlockHighlight();
		JHT_PnjButton:Disable();
	end
end

function JHO_TrackerSearchUp()
	JH_Main.TrackerPage = (JH_Main.TrackerPage + 1);
	JHO_TrackerSearch();
end

function JHO_TrackerSearchDown()
	JH_Main.TrackerPage = (JH_Main.TrackerPage - 1);
	JHO_TrackerSearch();
end

function JHO_TrackerSearch()
	local JHO_CurrentPage = JH_Main.TrackerPage;
	
	JH0_TrackerResult1:SetText("");
	JH0_TrackerResult1bis:SetText("");
	JH0_TrackerResult2:SetText("");
	JH0_TrackerResult2bis:SetText("");
	JH0_TrackerResult3:SetText("");
	JH0_TrackerResult3bis:SetText("");
	JH0_TrackerResult4:SetText("");
	JH0_TrackerResult4bis:SetText("");
	JH0_TrackerResult5:SetText("");
	JH0_TrackerResult5bis:SetText("");
	JH0_TrackerResult6:SetText("");
	JH0_TrackerResult6bis:SetText("");
	JH0_TrackerResult7:SetText("");
	JH0_TrackerResult7bis:SetText("");
	JH0_TrackerResult8:SetText("");
	JH0_TrackerResult8bis:SetText("");
	JH0_TrackerResult9:SetText("");
	JH0_TrackerResult9bis:SetText("");
	JH0_TrackerResult10:SetText("");
	JH0_TrackerResult10bis:SetText("");
	JHO_TrackerPrevButton:Hide();
	JHO_TrackerNextButton:Hide();
	
	local JHO_ToSearch = JHO_TrackerInput:GetText();
		
	if (JHO_ToSearch ~= "") then
		local JHO_TotalFound = 0;
		for i, value in JHD_Database, 1 do
			local JHO_CurrentPnj = JHD_Database[i]["pnj"];
			if (string.find(string.lower(JHO_CurrentPnj), string.lower(JHO_ToSearch))) then
				JHO_TotalFound = JHO_TotalFound + 1;
			end
		end
		
		if (JHO_TotalFound ==0 ) then
			JH0_TrackerResult1:SetText("Aucun resultat pour |cffffffff"..JHO_ToSearch);
			return;
		end
		
		if (JHO_TotalFound > 10) then
			JHO_TrackerPrevButton:Show();
			JHO_TrackerNextButton:Show();
		else
			JHO_TrackerPrevButton:Hide();
			JHO_TrackerNextButton:Hide();
		end
		
		if (JHO_CurrentPage == 1) then
			JHO_TrackerPrevButton:Disable();
		else
			JHO_TrackerPrevButton:Enable();
		end

		if (JHO_TotalFound > (JHO_CurrentPage*10)) then
			JHO_TrackerNextButton:Enable();
		else
			JHO_TrackerNextButton:Disable();
		end
		
		local JHO_TotalPage = (1+(floor(JHO_TotalFound/10)));
		JHO_TrackerNextButtonText:SetText("Page "..JHO_CurrentPage.." sur "..JHO_TotalPage);
		
		local JHO_CurrentFind = 0;
		local JHO_ResultPosition = 1;

		local JHO_FromPage = (JHO_CurrentPage*10)-9;
		local JHO_CurrentMaxAllow = JHO_FromPage+10;
		
		for i, value in JHD_Database, 1 do
			local JHO_CurrentPnj = JHD_Database[i]["pnj"];
			if (string.find(string.lower(JHO_CurrentPnj), string.lower(JHO_ToSearch))) then
			
				JHO_CurrentFind = JHO_CurrentFind + 1;
				
				if (JHO_CurrentFind < JHO_FromPage or JHO_CurrentFind > JHO_CurrentMaxAllow) then
					-- empty
				else
					local JHO_CurrentPnjZone = JHD_Database[i]["zone"];
					local JHO_CurrentPnjLoc = JHD_Database[i]["loc"];
					local JHO_CurrentDBline = "";
					JHO_CurrentDBline = i;
					if (JHO_ResultPosition == 1) then
						JH0_TrackerResult1:SetText(JHO_CurrentPnj);
						JH0_TrackerResult1bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 2) then
						JH0_TrackerResult2:SetText(JHO_CurrentPnj);
						JH0_TrackerResult2bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 3) then
						JH0_TrackerResult3:SetText(JHO_CurrentPnj);
						JH0_TrackerResult3bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 4) then
						JH0_TrackerResult4:SetText(JHO_CurrentPnj);
						JH0_TrackerResult4bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 5) then
						JH0_TrackerResult5:SetText(JHO_CurrentPnj);
						JH0_TrackerResult5bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 6) then
						JH0_TrackerResult6:SetText(JHO_CurrentPnj);
						JH0_TrackerResult6bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 7) then
						JH0_TrackerResult7:SetText(JHO_CurrentPnj);
						JH0_TrackerResult7bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 8) then
						JH0_TrackerResult8:SetText(JHO_CurrentPnj);
						JH0_TrackerResult8bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 9) then
						JH0_TrackerResult9:SetText(JHO_CurrentPnj);
						JH0_TrackerResult9bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					if (JHO_ResultPosition == 10) then
						JH0_TrackerResult10:SetText(JHO_CurrentPnj);
						JH0_TrackerResult10bis:SetText("|cffffffff"..JHO_CurrentPnjZone);
					end
					JHO_ResultPosition = JHO_ResultPosition + 1;
				end
			end
		end
	end
end

JHO_ACCUEILTEXT = "Merci de votre int\195\169r\195\170t pour l'addon JudgeHype.  Nous vous conseillons de visiter r\195\169guli\195\168rement notre site web pour \195\170tre mis au courant des derni\195\168res mises à jour.\n\nSite internet : |cffffffffhttp://worldofwarcraft.judgehype.com|r|r";
JHO_ACCUEILTEXT = JHO_ACCUEILTEXT.."\n\n\n|cffffffffCollector:|r Permet de collecter les \195\169l\195\169ments que vous rencontrez dans le jeu.|r|r";
JHO_ACCUEILTEXT = JHO_ACCUEILTEXT.."\n\n|cffffffffProfiler:|r Permet de g\195\169rer les profils de vos personnages.|r|r";
JHO_ACCUEILTEXT = JHO_ACCUEILTEXT.."\n\n|cffffffffTracker:|r Permet de rechercher un PNJ sur base du Collector.";

JHO_PURGETEXT = "Il est important de vider les donn\195\169es du Collector apr\195\168s un envoi au r\195\169seau JudgeHype.  Derni\195\168re purge effectu\195\169e le |cffffffff";

JHO_PROFILERTEXT = "Vous pouvez sauvegarder jusqu'\195\160 5 profils par personnage.  Enlevez tous les buffs et cliquez sur le num\195\169ro souhait\195\169 pour sauvegarder le profil du personnage |cffffffff";

JHO_TRACKERTEXT = "Le tracker cherche un PNJ dans le monde et affiche le r\195\169sultat sur une carte.  Les donn\195\169es sont r\195\169guli\195\168rement mises \195\160 jour sur base du Collector, nous vous conseillons de mettre \195\160 jour la liste des PNJ r\195\169guli\195\168rement en visitant notre site.";
