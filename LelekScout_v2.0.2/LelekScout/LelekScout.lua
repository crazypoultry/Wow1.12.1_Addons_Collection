local Update = 0; --used between updates
local HordeClass = {['Priest']=0;['Druid']=0;['Shaman']=0;['Mage']=0;['Warlock']=0;['Hunter']=0;['Warrior']=0;['Rogue']=0;};
local AllianceClass = {['Priest']=0;['Druid']=0;['Paladin']=0;['Mage']=0;['Warlock']=0;['Hunter']=0;['Warrior']=0;['Rogue']=0;};

function LelekScout_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage('Lelek Scout Loaded');
	this:RegisterEvent('UPDATE_BATTLEFIELD_SCORE');
	this:RegisterEvent('ADDON_LOADED');
	SlashCmdList['LSSLASH'] = LelekScout_Slash;		--our list of slash commands to register
	SLASH_LSSLASH1 = '/scout';					--what you can type to do the addon
	if (ScoutSave_IsOpen) then  --show the frame if we had it open before
		ShowUIPanel(Lelek_ScoutFrame);
	end
end

function LelekScout_OnEvent(event,msg,person)
	if (not ScoutSave_IsOpen) then ScoutSave_IsOpen = 1; end --default is open
	if (not ScoutSave_Class_IsOpen) then ScoutSave_Class_IsOpen = 0; end --default is closed
	if (event=='UPDATE_BATTLEFIELD_SCORE') then
		LelekBG();
	elseif (event=='ADDON_LOADED') then
		if (ScoutSave_IsOpen == 1) then
			Lelek_ScoutFrame:Show();
		end
		if (ScoutSave_Class_IsOpen == 1) then
			Lelek_ScoutClass_Frame:Show();
		end
	end
end

function LelekScout_Slash(msg)
	--LelekBG();
	if (ScoutSave_IsOpen==1) then
		HideUIPanel(Lelek_ScoutFrame);
		ScoutSave_IsOpen=0; --set it to nothing since its not open
	else
		ShowUIPanel(Lelek_ScoutFrame);
		ScoutSave_IsOpen = 1; --saves if we had it open
	end
end

function GetBattlefieldNumber()
	local mapName = 'none';
	for i=1, MAX_BATTLEFIELD_QUEUES do
		status, mapName, instanceID = GetBattlefieldStatus(i);
		if ( instanceID ~= 0 ) then
			mapName = mapName..' '..instanceID;
			return (mapName);
		end
	end
	return('none');
end

function LelekScout_OnUpdate(arg1)
	Update = Update + arg1;
	if (Update > 1) then
		Update = 0;
		if (GetBattlefieldNumber()=='none') then --we arnt in a battlefield so zero crap out
			getglobal('Scout_Text1_Melee'):SetText('0');
			getglobal('Scout_Text1_Melt'):SetText('0');
			getglobal('Scout_Text1_Healer'):SetText('0');
			getglobal('Scout_Text1_Number'):SetText('0');
			getglobal('Scout_Text2_Melee'):SetText('0');
			getglobal('Scout_Text2_Melt'):SetText('0');
			getglobal('Scout_Text2_Healer'):SetText('0');
			getglobal('Scout_Text2_Number'):SetText('0');
		else
			RequestBattlefieldScoreData(); --we are in so get info
		end
		getglobal('Scout_HeaderBattleground'):SetText(GetBattlefieldNumber());
	end
end

function LelekBG(spam)
	local numScores = GetNumBattlefieldScores();
	local text=' ';

	local numHorde = 0; local numAlliance = 0;
	local numHealer = 0; local numPaladin = 0; local numMelt = 0; local numMelee = 0;
	local numHealer_Horde = 0; local numShaman = 0; local numMelt_Horde = 0; local numMelee_Horde = 0;

	local HordeNames = {};
	local AllianceNames = {};
	HordeClass = {['Priest']=0;['Druid']=0;['Shaman']=0;['Mage']=0;['Warlock']=0;['Hunter']=0;['Warrior']=0;['Rogue']=0;};
	AllianceClass = {['Priest']=0;['Druid']=0;['Paladin']=0;['Mage']=0;['Warlock']=0;['Hunter']=0;['Warrior']=0;['Rogue']=0;};

	for i=1, numScores do
		name, _, _, _, _, faction, rank, race, class = GetBattlefieldScore(i);	
		if ( faction ) then
			if ( faction == 0 ) then
				numHorde = numHorde + 1;
				if (strfind(name,'-')) then name = strsub(name, 1, (strfind(name,'-'))-1); end --nix out their server.
				if (class=='Priest' or class=='Paladin' or class=='Druid' or class=='Shaman') then 
					numHealer_Horde = numHealer_Horde + 1; 
				end
				if (class=='Mage' or class=='Warlock') then 
					numMelt_Horde = numMelt_Horde + 1; 
				end
				if (class=='Hunter' or class=='Warrior' or class=='Rogue') then 
					numMelee_Horde=numMelee_Horde+1; 
				end
				HordeNames[numHorde] = name; --add the person to the list
				HordeClass[class]=HordeClass[class]+1;
			else
				numAlliance = numAlliance + 1;
				if (strfind(name,'-')) then	--this will nix out their server.
					name = strsub(name, 1, (strfind(name,'-'))-1);
				end
				--if (class=='Paladin') then numPaladin = numPaladin + 1; end
				if (class=='Priest' or class=='Paladin' or class=='Druid' or class=='Shaman') then 
					numHealer = numHealer + 1; 
				end
				if (class=='Mage' or class=='Warlock') then 
					numMelt = numMelt + 1; 
				end
				if (class=='Hunter' or class=='Warrior' or class=='Rogue') then 
					numMelee = numMelee + 1; 
				end
				AllianceNames[numAlliance] = name; --add the person to the list
				AllianceClass[class]=AllianceClass[class]+1;
			end
		end
	end
	getglobal('Scout_Text1_Melee'):SetText(numMelee);
	getglobal('Scout_Text1_Melt'):SetText(numMelt);
	getglobal('Scout_Text1_Healer'):SetText(numHealer);
	getglobal('Scout_Text1_Number'):SetText(numAlliance);
	getglobal('Scout_Text2_Melee'):SetText(numMelee_Horde);
	getglobal('Scout_Text2_Melt'):SetText(numMelt_Horde);
	getglobal('Scout_Text2_Healer'):SetText(numHealer_Horde);
	getglobal('Scout_Text2_Number'):SetText(numHorde);
	--DEFAULT_CHAT_FRAME:AddMessage('Alliance: warriors= '..AllianceClass.Warrior);

	Scout_Alliance_ClassWarrior:SetText(AllianceClass.Warrior);
	Scout_Alliance_ClassRogue:SetText(AllianceClass.Rogue);
	Scout_Alliance_ClassHunter:SetText(AllianceClass.Hunter);
	Scout_Alliance_ClassMage:SetText(AllianceClass.Mage);
	Scout_Alliance_ClassWarlock:SetText(AllianceClass.Warlock);
	Scout_Alliance_ClassPriest:SetText(AllianceClass.Priest);
	Scout_Alliance_ClassDruid:SetText(AllianceClass.Druid);
	Scout_Alliance_ClassPaladin:SetText(AllianceClass.Paladin);

	Scout_Horde_ClassWarrior:SetText(HordeClass.Warrior);
	Scout_Horde_ClassRogue:SetText(HordeClass.Rogue);
	Scout_Horde_ClassHunter:SetText(HordeClass.Hunter);
	Scout_Horde_ClassMage:SetText(HordeClass.Mage);
	Scout_Horde_ClassWarlock:SetText(HordeClass.Warlock);
	Scout_Horde_ClassPriest:SetText(HordeClass.Priest);
	Scout_Horde_ClassDruid:SetText(HordeClass.Druid);
	Scout_Horde_ClassShaman:SetText(HordeClass.Shaman);

	if (spam) then
		SendChatMessage('------------'..GetBattlefieldNumber()..'------------','battleground');
		SendChatMessage('<#Alliance='..numAlliance..'> #Healers='..numHealer..' #Melt='..numMelt..' #Melee='..numMelee,'battleground');
	end
	--DEFAULT_CHAT_FRAME:AddMessage( '<#Horde='..numHorde..'> #Healers='..numHealer_Horde..' #Melt='..numMelt_Horde..' #Melee='..numMelee_Horde );
	--DEFAULT_CHAT_FRAME:AddMessage( '<#Allia='..numAlliance..'> #Healers='..numHealer..' #Melt='..numMelt..' #Melee='..numMelee );	
end

function Scout_SayClasses()
	SendChatMessage('Alliance- Warrior '..AllianceClass.Warrior..'- Rogue '..AllianceClass.Rogue..'- Hunter '..AllianceClass.Hunter..'- Warlock '..AllianceClass.Warlock..'- Druid '..AllianceClass.Druid..'- Mage '..AllianceClass.Mage..'- Priest '..AllianceClass.Priest..'- Paladin '..AllianceClass.Paladin,'battleground');
	SendChatMessage('Horde- Warrior '..HordeClass.Warrior..'- Rogue '..HordeClass.Rogue..'- Hunter '..HordeClass.Hunter..'- Warlock '..HordeClass.Warlock..'- Druid '..HordeClass.Druid..'- Mage '..HordeClass.Mage..'- Priest '..HordeClass.Priest..'- Shaman '..HordeClass.Shaman,'battleground');
end


------------------------------------------
--              UI crap
-------------------------------------------
function Scout_ClassButton_OnClick()
	if (Lelek_ScoutClass_Frame:IsShown()) then
		HideUIPanel(Lelek_ScoutClass_Frame);
		ScoutSave_Class_IsOpen=0;
	else
		ShowUIPanel(Lelek_ScoutClass_Frame); 
		ScoutSave_Class_IsOpen=1;
	end	
end