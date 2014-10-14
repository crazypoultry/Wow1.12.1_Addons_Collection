--TrainerSkills made by Razzer (http://wow.pchjaelp.dk)
CLASS_TRAINER_SKILLS_DISPLAYED = 11;
CLASS_TRAINER_SKILL_HEIGHT = 16;
TRINER_SKILLS_DEBUG = nil;

local selectedNpc;
local skills;
local skillsData;
local selectedService;
local skillsFilter = {available = 1, unavailable = 1, used = nil};
local index;
local charIndex;
local selectedChar;
local showSkillDetails;
local initHasRun;
local npcNameAndZone;
local trainerName;
local availableSkillsTotalCost = 0;
local unavailableSkillsTotalCost = 0;
local NewBieToolTip;
local initDone = nil;
local updateTitan;

 
function TrainerSkills_command(msg)
	msg = strlower(msg);
	if ( msg == "reset") then
		TrainerSkills_ResetDB();
	elseif ( msg == "completereset") then
		TrainerSkills_ResetDB(nil, 0);
	elseif (msg == "notify") then
		if ( TrainerSkillsVar.tsNotify == 1 ) then
			TrainerSkillsVar.tsNotify = 0;
			DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_NOTIFICATION_OFF);
		else
			TrainerSkillsVar.tsNotify = 1;
			DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_NOTIFICATION_ON);
		end
	elseif (msg == "mmb") then
		TrainerSkillsMinimapButton_Toggle(1);
	elseif (msg == "mmbmov") then
		TrainerSkillsMinimapButton_Moveable_Toggle();
	elseif (strlen(msg) >= 15 and strsub(msg, 1, 15) == "delete selected") then
		TrainerSkills_ResetDB(nil, 3);
	elseif (strlen(msg) >= 18 and strsub(msg, 1, 18) == "delete trainertype") then
		local trainer = strsub(msg, 20);
		TrainerSkills_ResetDB(trainer, 1);
	elseif (strlen(msg) >= 7 and strsub(msg, 1, 7) == "cleanup") then
		TrainerSkills_ResetDB(nil, 4);
	elseif (strlen(msg) >= 6 and strsub(msg, 1, 6) == "delete") then
		local character = strsub(msg, 8);
		TrainerSkills_ResetDB(character);
	elseif (strfind(msg, "help")) then
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE1);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE10);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE2);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE3);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE4);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE5);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE6);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE7);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE8);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_HELP_LINE9);
	else
		TrainerSkills_Show();
	end
end

function TrainerSkills_OnLoad()		
	this:RegisterEvent("TRAINER_SHOW");
	this:RegisterEvent("TRAINER_CLOSED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("SKILL_LINES_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("CHARACTER_POINTS_CHANGED");

	SlashCmdList["TrainerSkills"] = function(msg)
		TrainerSkills_command(msg);
	end
	SLASH_TrainerSkills1 = "/TrainerSkills";
	SLASH_TrainerSkills2 = "/ts";
	
	TrainerSkills_ClrFrame();
	TrainerSkills_SetToTrainerSkills();
	TrainerSkillsNameText:SetText(TRAINERSKILLS_FRAME_TITLE);
	
	UIPanelWindows["TrainerSkills"] = { area = "left", pushable = 6 };
end

local timedTasks = {};
local function timeTask(task, delay)
	for index in timedTasks do 
		if(timedTasks[index].task == task)then
			return;
		end
	end
	tinsert(timedTasks, {task = task, delay = delay, countedTime = 0});
	TrainerSkillsTimer:Show();
end

local timeCounter = 0;
local taskTimeCounter;
function TrainerSkillsTimer_OnUpdate(arg1)
	timeCounter = timeCounter + arg1;
	if(timeCounter >= 1)then
		taskTimeCounter = timeCounter;
		timeCounter = 0;
		if(getn(timedTasks) > 0)then
			for task in timedTasks do
				timedTasks[task].countedTime = timedTasks[task].countedTime + taskTimeCounter;
				if(timedTasks[task].countedTime >= timedTasks[task].delay)then
					local tempTask = timedTasks[task].task;
					tremove(timedTasks, task);
					tempTask();
				end
			end
		else
			TrainerSkillsTimer:Hide();
		end
	end
end

function TrainerSkills_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		if(myAddOnsFrame) then
			myAddOnsList.TrainerSkills = {name = "TrainerSkills", description = TRAINERSKILLS_MYADDONS_DESCRIPTION, version = TRAINERSKILLS_VERSIONNUMBER, category = MYADDONS_CATEGORY_OTHERS, frame = "TrainerSkills"};
		end
	elseif ( event == "UNIT_LEVEL" ) then
		if ( arg1 == "player" and charIndex and initDone ) then
			TrainerSkills_UpdateSkills();
		end
	elseif ( event == "SKILL_LINES_CHANGED" ) then
		if ( not arg1 and charIndex and initDone ) then
			TrainerSkills_UpdateSkills();
		end
	elseif ( event == "TRAINER_SHOW" ) then
		if ( not IsTalentTrainer() ) then
			TrainerSkills_Grab_init();
--			timeTask(TrainerSkills_Grab, 1);
		end
	elseif ( event == "TRAINER_CLOSED" ) then
		if ( not IsTalentTrainer() ) then
			TrainerSkills_Grab();
--			timeTask(TrainerSkills_Grab, 3);
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (not charIndex) then
			local character = UnitName("player");
			if (character ~= nil and character ~= UNKNOWNOBJECT) then
				TrainerSkills_InitDB();
			end
		end
	elseif (event == "UNIT_NAME_UPDATE") then
		if (not charIndex) then
			local character = UnitName("player");
			if (character ~= nil and character ~= UNKNOWNOBJECT) then
				TrainerSkills_InitDB();
			end
		end
	elseif ( event == "CHARACTER_POINTS_CHANGED" ) then
		if ( arg2 > 0 ) then
			local cp1, cp2 = UnitCharacterPoints("player");
			if ( cp2 ) then
				DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_DELETE_DROPPED_TRAINER);
			end
		end
	end
end

function TrainerSkills_GetSelectedNpc()
	return selectedNpc;
end

function TrainerSkills_GetSelectedCharacter()
	return selectedChar;
end

function TrainerSkills_GetCharIndex()
	return charIndex;
end

--DB stuff

function TrainerSkills_InitDB()
	if ( not charIndex ) then
		local character = UnitName("player");
		local realmName = GetCVar("realmName");
		charIndex = character.."|"..realmName;
		selectedChar = charIndex;
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_LOADED);
		end
		
	end
	
	if (not TrainerSkillsTrainerTypes and TrainerSkillsDB ) then
		TrainerSkillsTrainerTypes = {};
		TrainerSkills_ConvertToNewDataStructure();
	elseif (not TrainerSkillsTrainerTypes ) then
		TrainerSkillsTrainerTypes = {};
	end
	
	if ( not TrainerSkillsVar ) then
		TrainerSkillsVar = {};
	end
	
	if ( not TrainerSkillsVar[charIndex] ) then
		TrainerSkillsVar[charIndex] = {};
	end
	
	if ( not TrainerSkillsVar.tsNotify ) then
		TrainerSkillsVar.tsNotify = 1;
	end
	
	if ( not TrainerSkillsVar.mmb ) then
		TrainerSkillsVar.mmb = 1;
	end
	
	if ( TrainerSkillsVar.mmb == 0 ) then
		TrainerSkillsMinimapButton:Hide();
	end
	
	if ( not TrainerSkillsVar.mmbMov ) then
		TrainerSkillsVar.mmbMov = 0;
	end
	
	if ( not TrainerSkillsVar.grabTooltips ) then
		TrainerSkillsVar.grabTooltips = 1;
	end
	
	if ( not TrainerSkillsVar.grabDescription ) then
		TrainerSkillsVar.grabDescription = 1;
	end
	
	if ( not TrainerSkillsVar.grabNpcNamesAndLocations ) then
		TrainerSkillsVar.grabNpcNamesAndLocations = 1;
	end
	
	if ( not TrainerSkillsVar.savePlayerSkills ) then
		TrainerSkillsVar.savePlayerSkills = 1;
	end
	
	if ( not TrainerSkillsVar.skillsFilter ) then
		TrainerSkillsVar.skillsFilter = skillsFilter;
	else
		skillsFilter = TrainerSkillsVar.skillsFilter;
	end

	if( not TrainerSkillsDB ) then
		TrainerSkillsDB = {};
	end

	if( not TrainerSkillsDB[charIndex] ) then
		TrainerSkillsDB[charIndex] = {};
	end	
	
	if (ReagentData) then
		if ( not ReagentData['crafted']['alchemy']) then
			ReagentData_LoadAlchemy();
		end
		if ( not ReagentData['crafted']['blacksmithing']) then
			ReagentData_LoadBlacksmithing();
		end
		if ( not ReagentData['crafted']['cooking']) then
			ReagentData_LoadCooking();
		end
		if ( not ReagentData['crafted']['enchanting']) then
			ReagentData_LoadEnchanting();
		end
		if ( not ReagentData['crafted']['engineering']) then
			ReagentData_LoadEngineering();
		end
		if ( not ReagentData['crafted']['firstaid']) then
			ReagentData_LoadFirstAid();
		end
		if ( not ReagentData['crafted']['leatherworking']) then
			ReagentData_LoadLeatherworking();
		end
		if ( not ReagentData['crafted']['mining']) then
			ReagentData_LoadMining();
		end
		if ( not ReagentData['crafted']['poisons']) then
			ReagentData_LoadPoisons();
		end
		if ( not ReagentData['crafted']['tailoring']) then
			ReagentData_LoadTailoring();
		end
	end
	initDone = 1;
end

--Also called from DemonTrainerFrame
function TrainerSkills_GetNpcNameAndZone()
    TrainerSkillsTT:Hide();
    TrainerSkillsTT:SetOwner(TrainerSkillsTT, "ANCHOR_NONE")
	TrainerSkillsTT:SetUnit("npc");
	index = TrainerSkillsTTTextLeft2:GetText();
--	print(index);
--	print("--");
	local subZoneText = GetSubZoneText();
	local zoneText = GetZoneText();
	local trainerName = UnitName("npc");
	local npcNameAndZone = nil;
	if ( trainerName and subZoneText and zoneText ) then
		npcNameAndZone = trainerName..GRAY_FONT_COLOR_CODE.." "..TRAINERSKILLS_IN.." "..zoneText;
		if ( subZoneText ~= "" ) then
			npcNameAndZone = npcNameAndZone.." - "..subZoneText;
		end
		npcNameAndZone = npcNameAndZone..FONT_COLOR_CODE_CLOSE;
	end
	return trainerName, npcNameAndZone;
end

function TrainerSkills_Grab_init()
	trainerName, npcNameAndZone = TrainerSkills_GetNpcNameAndZone();
	
	local filter = TrainerSkillsVar.trainerFilter;
	if ( filter ) then
		if ( filter.available ) then
			SetTrainerServiceTypeFilter("available", 1);
		else
			SetTrainerServiceTypeFilter("available", 0);
		end
		if ( filter.unavailable ) then
			SetTrainerServiceTypeFilter("unavailable", 1);
		else
			SetTrainerServiceTypeFilter("unavailable", 0);
		end
		if ( filter.used ) then
			SetTrainerServiceTypeFilter("used", 1);
		else
			SetTrainerServiceTypeFilter("used", 0);
		end
	end
	initHasRun = 1;
end

function TrainerSkills_TrainerNameInTooltip(npcNameAndZone)
	local TrainerNamesToolTip = TrainerSkillsDB[charIndex][index].TrainerNamesToolTip;
	local ret = nil;
	for index in TrainerNamesToolTip do
		if ( TrainerNamesToolTip[index] == npcNameAndZone ) then
			ret = 1;
		end
	end
	return ret;
end

--Also used by DemonTrainerFrame
function TrainerSkills_GetToolTipText(targetType, number)
    TrainerSkillsTT:Hide();
    TrainerSkillsTT:SetOwner(TrainerSkillsTT, "ANCHOR_NONE")
	if(targetType == "merchant")then
		TrainerSkillsTT:SetMerchantItem(number);
	elseif(targetType == "trainer")then
		TrainerSkillsTT:SetTrainerService(number);
	end
	
	local toolTipNumLines = TrainerSkillsTT:NumLines();
	local toolTipLines = {};
	
	local j = 1;
	while (j <= toolTipNumLines) do
		local mytext = getglobal("TrainerSkillsTTTextLeft" .. j);
		toolTipLines[j] = mytext:GetText();
		j = j + 1;
	end
	return toolTipNumLines, toolTipLines
end



function TrainerSkills_Grab()
	
--making this check because the close event is fired twice - we only want to grab the data the first time.
	if ( initHasRun ) then
		local filter = {}; 
		
		filter.available = GetTrainerServiceTypeFilter("available");
		filter.unavailable = GetTrainerServiceTypeFilter("unavailable");
		filter.used = GetTrainerServiceTypeFilter("used");	
		
		if ( TrainerSkillsVar.saveTrainerFilter == 1 ) then
			TrainerSkillsVar.trainerFilter = filter;
		else
			TrainerSkillsVar.saveTrainerFilter = nil;
		end
	
		--Need to set everything visible to get the whole list of skills.
		SetTrainerServiceTypeFilter("available", 1);
		SetTrainerServiceTypeFilter("unavailable", 1);
		SetTrainerServiceTypeFilter("used", 1);


		--Expand all
		ExpandTrainerSkillLine(0);		

		local numTrainerServices = GetNumTrainerServices();
	
		if ( not numTrainerServices or numTrainerServices < 1 ) then
			initHasRun = nil;
			return;
		end
	
		local saveSkills = {};
		local saveSkillsTrainer = {};

		for i=1, numTrainerServices, 1 do			 
			local serviceName, serviceSubText, serviceType, isExpanded;
			local moneyCost, cpCost1, cpCost2;
			
			saveSkills[i] = {};
			saveSkillsTrainer[i] = {};

			serviceName, serviceSubText, serviceType, isExpanded = GetTrainerServiceInfo(i);
			if(not serviceName or not serviceType)then
--				timeTask(TrainerSkills_Grab, 1);
				return;
			end
	
			saveSkillsTrainer[i].serviceName = serviceName;
			saveSkillsTrainer[i].serviceSubText = serviceSubText;
			saveSkills[i].serviceType = serviceType;
			saveSkills[i].isExpanded = isExpanded;

			if (serviceType ~= "header" and TrainerSkillsVar.grabTooltips == 1) then
				saveSkillsTrainer[i].toolTipNumLines, saveSkillsTrainer[i].toolTipLines = TrainerSkills_GetToolTipText("trainer", i);
			end

			moneyCost, cpCost1, cpCost2 = GetTrainerServiceCost(i);
				
			saveSkillsTrainer[i].moneyCost = moneyCost;

			saveSkillsTrainer[i].GetTrainerServiceIcon = GetTrainerServiceIcon(i);
			saveSkillsTrainer[i].GetTrainerServiceLevelReq = GetTrainerServiceLevelReq(i);

			local skill, rank, hasReq = GetTrainerServiceSkillReq(i);
			saveSkillsTrainer[i].SkillReqSkill = skill;
			saveSkillsTrainer[i].SkillReqRank = rank;
			saveSkills[i].SkillReqHasReq = hasReq;
	
			local numRequirements = GetTrainerServiceNumAbilityReq(i);
			saveSkillsTrainer[i].GetTrainerServiceNumAbilityReq = numRequirements;

			local ability;
			if ( numRequirements > 0 ) then
				local ServiceAbilityReq = {};
				local ServiceAbilityReqTrainer = {};
				for k=1, numRequirements, 1 do
					ServiceAbilityReq[k] = {};
					ServiceAbilityReqTrainer[k] = {};
					ability, hasReq = GetTrainerServiceAbilityReq(i, k);
					ServiceAbilityReqTrainer[k].ability = ability;
					ServiceAbilityReq[k].hasReq = hasReq;
				end
				saveSkills[i].GetTrainerServiceAbilityReq = ServiceAbilityReq;
				saveSkillsTrainer[i].GetTrainerServiceAbilityReq = ServiceAbilityReqTrainer;
			end
			
			if ( TrainerSkillsVar.grabDescription == 1 ) then
				saveSkillsTrainer[i].GetTrainerServiceDescription = GetTrainerServiceDescription(i);
			end

			local isLearnSpell;
			local isPetLearnSpell;
			isLearnSpell, isPetLearnSpell = IsTrainerServiceLearnSpell(i);
			saveSkillsTrainer[i].ServiceLearnSpellIsLearnSpell = isLearnSpell;
			saveSkillsTrainer[i].ServiceLearnSpellIsPetLearnSpell = isPetLearnSpell;
			

			if ( serviceType == "used" ) then
				TrainerSkills_UpdateGreys(serviceName, serviceSubText);
			end
		end

		TrainerSkills_InitNewTablesAndSaveData(saveSkills, saveSkillsTrainer, numTrainerServices, npcNameAndZone, trainerName, 1);
		initHasRun = nil;	
		
	end
end

local function cleanTrainerTypesTable()
	local found;
	for trainer in TrainerSkillsTrainerTypes do
		found = nil;
		for char in TrainerSkillsDB do
			if(TrainerSkillsDB[char][trainer]) then
				found = 1;
			end
		end
		if(not found) then
			if(TRINER_SKILLS_DEBUG)then
				DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: Deleting unused trainer from the trainerTypes table: "..trainer);
			end
			TrainerSkillsTrainerTypes[trainer] = nil;
		end
	end
end

function TrainerSkills_InitNewTablesAndSaveData(saveSkills, saveSkillsTrainer, numTrainerServices, npcNameAndZone, trainerName, doCopyOverLevelReq)
	local checkedIndex, doClean = TrainerSkills_GetTrainerTypeWithSameSkills(saveSkillsTrainer, numTrainerServices);
	if(checkedIndex == -1)then 
		return
	end
	
	if ( not checkedIndex) then
		local done = nil;
		local j = 2;
		while (not done) do
			if ( not TrainerSkillsTrainerTypes[index] ) then
--                print(index);
--                print(charIndex);
				TrainerSkillsDB[charIndex][index] = {};
				TrainerSkillsTrainerTypes[index] = {};
				TrainerSkills_SaveGrabbedData(index, saveSkills, saveSkillsTrainer, numTrainerServices);
				done = 1;
			else
				if ( j > 2 ) then
					index = strsub(index, 1, -2)..j;
				else
					index = index.." "..j;
				end
				j = j + 1;
			end
		end
	else
		index = checkedIndex;
		if(doCopyOverLevelReq)then
			saveSkillsTrainer = TrainerSkills_CopyOverLevelReq(index, saveSkills, saveSkillsTrainer);
		end
		
		--Save
		TrainerSkills_SaveGrabbedData(index, saveSkills, saveSkillsTrainer, numTrainerServices);
	end
	if ( TrainerSkillsVar.grabNpcNamesAndLocations == 1 ) then
		TrainerSkills_UpdateNpcToolTips(npcNameAndZone, index, trainerName);
	end
	if ( selectedNpc and selectedChar and charIndex == selectedChar ) then
		TrainerSkills_ClrFrame();
	end
	if(doClean)then
		cleanTrainerTypesTable();
	end
	updateTitan = 1;
	return index;
end

function TrainerSkills_CopyOverLevelReq(index, saveSkills, saveSkillsTrainer)
	if ( not saveSkillsTrainer ) then
		saveSkillsTrainer = saveSkills;
	end
	local oldSkills = TrainerSkillsTrainerTypes[index].skills;
	for sSkill in saveSkills do
		if ( saveSkills[sSkill].serviceType == "used" ) then
			local lvlReq = nil;
			for oSkill in oldSkills do
				if ( oldSkills[oSkill].GetTrainerServiceLevelReq and oldSkills[oSkill].GetTrainerServiceLevelReq > 0 and oldSkills[oSkill].serviceName == saveSkillsTrainer[sSkill].serviceName ) then
					if ( saveSkillsTrainer[sSkill].serviceSubText ) then
						if ( oldSkills[oSkill].serviceSubText and saveSkillsTrainer[sSkill].serviceSubText == oldSkills[oSkill].serviceSubText ) then
							lvlReq = oldSkills[oSkill].GetTrainerServiceLevelReq;
						end
					else
						lvlReq = oldSkills[oSkill].GetTrainerServiceLevelReq;
					end
				end
			end
			if ( lvlReq ) then
				saveSkillsTrainer[sSkill].GetTrainerServiceLevelReq = lvlReq;
			end
		end
	end
	return saveSkillsTrainer;
end

function TrainerSkills_SaveGrabbedData(trainerType, saveSkills, saveSkillsTrainer, numTrainerServices)
	if ( not TrainerSkillsDB[charIndex][trainerType] ) then
		TrainerSkillsDB[charIndex][trainerType] = {};
	end
	TrainerSkillsDB[charIndex][trainerType].skills = saveSkills;
	TrainerSkillsTrainerTypes[trainerType].skills = saveSkillsTrainer;
	TrainerSkillsTrainerTypes[trainerType].IsTradeskillTrainer = IsTradeskillTrainer();
	TrainerSkillsTrainerTypes[trainerType].GetNumTrainerServices = numTrainerServices;
end



function TrainerSkills_GetTrainerTypeWithSameSkills(saveSkills, numTrainerServices)
	local doClean = nil;
	local isWeapmaster = nil;
	if(numTrainerServices < 20)then --check for weapmaster. They have no skill descriptions
		isWeapmaster = 1;
		for skill in saveSkills do 
			if(saveSkills[skill].GetTrainerServiceDescription) then
				isWeapmaster = nil;
			end
		end
	end
	
	local ignore = nil;
	for trainerType in TrainerSkillsTrainerTypes do
	
		local oldSkills = TrainerSkillsTrainerTypes[trainerType].skills;
		local oSize = getn(oldSkills);
		if ( saveSkills[1].serviceName == oldSkills[1].serviceName ) then
			if(TRINER_SKILLS_DEBUG)then
				DEFAULT_CHAT_FRAME:AddMessage("Same hader found");
			end
			local found = nil;
			for oSkill in oldSkills do
				if ( saveSkills[numTrainerServices].serviceName == oldSkills[oSkill].serviceName ) then
					found = 1;
				end
			end
			if ( found ) then
				if(TRINER_SKILLS_DEBUG)then
					DEFAULT_CHAT_FRAME:AddMessage("Last skill found");
				end
				for sSkill in saveSkills do
					if ( oldSkills[oSize].serviceName == saveSkills[sSkill].serviceName ) then
						return trainerType;
					end
				end
			end
					
		
			if(not IsTradeskillTrainer() and not isWeapmaster and TrainerSkillsDB[charIndex][trainerType])then --Classtrainer or petTrainer or riding instructor
				local knownSkills = 0;
			
				for sSkill in saveSkills do 
					for oSkill in oldSkills do 
						if(saveSkills[sSkill].serviceName == oldSkills[oSkill].serviceName and saveSkills[sSkill].serviceSubText == oldSkills[oSkill].serviceSubText)then
							knownSkills = knownSkills + 1;
						end
					end
				end
				
				if(TRINER_SKILLS_DEBUG)then
					DEFAULT_CHAT_FRAME:AddMessage("knownSkills: "..knownSkills.." numTrainerServices: "..numTrainerServices.." oSize: "..oSize);
				end
						
				if(knownSkills == numTrainerServices)then
					--hvis alle saveSkills findes i oldSkills så return -1 der bliver alligevel kørt update greys
					if(TRINER_SKILLS_DEBUG)then
						DEFAULT_CHAT_FRAME:AddMessage("Ignoring"..trainerType);
					end
					ignore = 1;
				elseif(knownSkills == oSize)then
					--hvis alle oldSkills findes i saveSkills så fjern link til den træner (fordi vi besøger en af samme type med flere skills)
					if(TRINER_SKILLS_DEBUG)then
						DEFAULT_CHAT_FRAME:AddMessage("Removing link to old trainer"..trainerType);
					end
					TrainerSkillsDB[charIndex][trainerType] = nil;
					doClean = 1;
				end
			end
		end
	end
	if(ignore)then
		return -1;
	end
	if(doClean)then
		return nil, 1;
	end
end

--Should revisit this function. The TrainerNamesToolTip should have the trainerNames as index
function TrainerSkills_UpdateNpcToolTips(npcNameAndZone, index, trainerName)
	if ( npcNameAndZone ) then
		local TrainerNamesToolTip = TrainerSkillsDB[charIndex][index].TrainerNamesToolTip;
		if ( TrainerNamesToolTip ) then
			local isInToolTipNumber = nil;
			for index in TrainerNamesToolTip do
				if (strfind(TrainerNamesToolTip[index], trainerName, 1, true)) then
					isInToolTipNumber = index;
				end
			end
			--Overwrite the old tooltip for that name (in case he moved to another location), else insert as a new entry
			if ( isInToolTipNumber ) then
				TrainerNamesToolTip[isInToolTipNumber] = npcNameAndZone;
			else
				table.insert( TrainerNamesToolTip, npcNameAndZone );
			end
		else
			TrainerNamesToolTip = {};
			table.insert( TrainerNamesToolTip, npcNameAndZone );
		end
		TrainerSkillsDB[charIndex][index].TrainerNamesToolTip = TrainerNamesToolTip;
	end
end

--Updating skills to "used" in case more trainers have the same skills (and it is learned)
function TrainerSkills_UpdateGreys(serviceName, serviceSubText)
	for index in TrainerSkillsDB[charIndex] do
		local checkSkills = TrainerSkillsTrainerTypes[index].skills;
		local checkMySkills = TrainerSkillsDB[charIndex][index].skills;
		local numTrainerServices = TrainerSkillsTrainerTypes[index].GetNumTrainerServices;
		
		if ( not numTrainerServices or not checkSkills or getn(checkSkills) ~= numTrainerServices ) then
			--DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: Some saved data is corupt - please visit a "..index.." to correct the problem");
		else
			for skill in checkSkills do
				if ( checkSkills[skill].serviceName and	checkSkills[skill].serviceName == serviceName and
				checkSkills[skill].serviceSubText and checkSkills[skill].serviceSubText == serviceSubText and
				checkMySkills[skill].serviceType and checkMySkills[skill].serviceType ~= "used" and 
				checkMySkills[skill].serviceType ~= "header") then
--					TrainerSkillsDB[charIndex][index].skills.serviceType = "used";
					checkMySkills[skill].serviceType = "used";
				end
			end
		end	
	end
end

function TrainerSkills_MoneyFormat(money)
		local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
		local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
		local copper = mod(money, COPPER_PER_SILVER);
		return gold, silver, copper;
end

function TrainerSkills_UpdateSkills()
	local numSkills = GetNumSkillLines();
	local skillHeader = nil;
	local myCraftSkills = {};
	local mySavedCraftSkills;
	if ( TrainerSkillsVar.savePlayerSkills == 1 ) then
		mySavedCraftSkills = {};
		mySavedCraftSkills.numSkills = numSkills;
		mySavedCraftSkills.charLevel = UnitLevel("player");	
	end
	
	for i = 1, numSkills, 1 do
		local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);

		if ( not header and skillName ) then
			myCraftSkills[skillName] = skillRank;
		end

		if ( header ) then
			skillHeader = skillName;
		end
		
		if ( TrainerSkillsVar.savePlayerSkills == 1 and (skillHeader == TRADE_SKILLS or skillHeader == SECONDARY_SKILLS ) ) then
			mySavedCraftSkills[i] = {};
			mySavedCraftSkills[i].skillRank = skillRank;
			mySavedCraftSkills[i].skillName = skillName;
		end
	end
	
	if ( TrainerSkillsVar.savePlayerSkills == 1 ) then
		TrainerSkillsVar[charIndex].mySavedCraftSkills = mySavedCraftSkills;
	end
	
	for trainer in TrainerSkillsDB[charIndex] do
		if (TRINER_SKILLS_DEBUG) then
			DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: UpdateSkills - Trainer:"..trainer);
		end
		local printAvailableSkillsTotalCost = nil;
		if(not TrainerSkillsTrainerTypes[trainer])then
			for trainer in TrainerSkillsDB[charIndex] do
				if(not TrainerSkillsTrainerTypes[trainer])then
					if (TRINER_SKILLS_DEBUG) then
						DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: Deleting trainer because he is missing in the trainer types table: "..trainer);
					end
					TrainerSkillsDB[charIndex][trainer] = nil;
				end
			end
			return;
		end
		local trainerSkills = TrainerSkillsTrainerTypes[trainer].skills;
		local mySkills = TrainerSkillsDB[charIndex][trainer].skills;
		availableSkillsTotalCost = 0;
		for index in mySkills do
			local upgrade = 1;
		
			if (TRINER_SKILLS_DEBUG and not trainerSkills[index]) then
				
				DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: UpdateSkills - Trainer:"..trainer.." missing at TrainerSkillsTrainerTypes[trainer][skills][\""..index.."\"]");
			end
			
			if (not trainerSkills[index] and index == "serviceType") then
				mySkills[index] = nil;
				return;
			end
		
			-- Level Requirements
			local reqLevel = trainerSkills[index].GetTrainerServiceLevelReq;
			local isPetLearnSpell = trainerSkills[index].ServiceLearnSpellIsPetLearnSpell;
			if ( reqLevel > 1 ) then
				if ( isPetLearnSpell ) then
					if ( UnitLevel("pet") < reqLevel ) then
						upgrade = nil;
					end
				else
					if ( UnitLevel("player") < reqLevel ) then
						upgrade = nil;
					end
				end
			end
	
			-- Skill Requirements
			local skill, rank, hasReq;
			skill = trainerSkills[index].SkillReqSkill;
			rank = trainerSkills[index].SkillReqRank;
--			hasReq = mySkills[index].SkillReqHasReq;
			
			if ( skill ) then
				if( myCraftSkills[skill] ) then
					if ( myCraftSkills[skill] >= rank ) then
						mySkills[index].SkillReqHasReq = 1;
					else
						upgrade = nil;
					end
				else
					upgrade = nil;
				end
			end
		
			-- Ability Requirements
			local numRequirements = trainerSkills[index].GetTrainerServiceNumAbilityReq;
			if ( numRequirements and numRequirements > 0 ) then
				local ServiceAbilityReq = mySkills[index].GetTrainerServiceAbilityReq;
				for i=1, numRequirements, 1 do	
					if (ServiceAbilityReq and ServiceAbilityReq[i]) then	
						hasReq = ServiceAbilityReq[i].hasReq;
						if ( not hasReq ) then
							upgrade = nil;
						end
					else
						upgrade = nil;
					end
				end
			end
	
			if ( upgrade ) then
				if ( mySkills[index].serviceType == "unavailable" ) then
					availableSkillsTotalCost = availableSkillsTotalCost + trainerSkills[index].moneyCost;
					mySkills[index].serviceType = "available";
					if ( TrainerSkillsVar.tsNotify == 1 ) then
						DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills - "..TRAINERSKILLS_CHAT_NEW_LEARNABLE_SKILL.." "..GREEN_FONT_COLOR_CODE..trainerSkills[index].serviceName..FONT_COLOR_CODE_CLOSE.." "..TRAINERSKILLS_CHAT_NEW_LERANABLE_SKILL_FROM.." "..trainer);
						printAvailableSkillsTotalCost = 1;
					end
				end
			end
		end
		if(printAvailableSkillsTotalCost) then
			local gold, silver, copper = TrainerSkills_MoneyFormat(availableSkillsTotalCost);
			if(GetMoney() >= availableSkillsTotalCost) then
				DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST.." "..GREEN_FONT_COLOR_CODE..gold.."g "..silver.."s "..copper.."c"..FONT_COLOR_CODE_CLOSE.." ("..TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST_EXPLANATION..")");
			else
				DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST.." "..RED_FONT_COLOR_CODE..gold.."g "..silver.."s "..copper.."c"..FONT_COLOR_CODE_CLOSE.." ("..TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST_EXPLANATION..")");
			end
			updateTitan = 1;
		end
	end	
	if ( selectedNpc and selectedChar and charIndex == selectedChar ) then
		TrainerSkills_Update();
	end
end

function TrainerSkills_ResetDB(input, type)
	if ( type == 0 ) then
		TrainerSkillsDB = nil; 
		TrainerSkillsVar = nil;
		TrainerSkillsTrainerTypes = nil;
		charIndex = nil;
		selectedNpc = nil;
		skills = nil;
		selectedService = nil;
		skillsFilter = {available = 1, unavailable = 1, used = nil};
		index = nil;
		charIndex = nil;
		selectedChar = nil;
		showSkillDetails = nil;
		initHasRun = nil;
		npcNameAndZone = nil;
		trainerName = nil;
		availableSkillsTotalCost = 0;
		unavailableSkillsTotalCost = 0;
		NewBieToolTip = nil;
		DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: "..TRAINERSKILLS_CHAT_COMPLEATERESET);
		TrainerSkills_InitDB();
	elseif (input and not type) then --Delete the input character
		local done = nil;
		for index in TrainerSkillsDB do
			local characterInDb = string.gsub(strlower(index), "|", " "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." ");
			if (characterInDb == input) then
				TrainerSkillsDB[index] = nil;
				if ( TrainerSkillsVar[index] ) then
					TrainerSkillsVar[index] = nil;
				end
				cleanTrainerTypesTable();
				DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: "..TRAINERSKILLS_CHAT_CHAR_DELETED.." '"..input.."'");
				selectedChar = charIndex;
				UIDropDownMenu_SetText(TRAINERSKILLS_CHARACTER_DROPDOWN, TrainerSkillsCharDropDown);
				done = 1;
			end
		end
		if(selectedChar == charIndex)then
			TrainerSkills_InitDB();
		else
			selectedChar = charIndex;
		end
		if ( not done ) then
			DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: '"..input.."' "..TRAINERSKILLS_CHAT_CHAR_NOT_FOUND);
		end
	elseif (input and type == 6) then --Delete the input character
		if(TrainerSkillsDB[input]) then
			TrainerSkillsDB[input] = nil;
		end
		if ( TrainerSkillsVar[input] ) then
			TrainerSkillsVar[input] = nil;
		end
		cleanTrainerTypesTable();
		DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: "..TRAINERSKILLS_CHAT_CHAR_DELETED.." '"..input.."'");
		if(selectedChar == charIndex)then
			TrainerSkills_InitDB();
		else
			selectedChar = charIndex;
		end
		UIDropDownMenu_SetText(TRAINERSKILLS_CHARACTER_DROPDOWN, TrainerSkillsCharDropDown);
	elseif (input and type == 1) then --Delete trainer for the current character
		local done = nil;
		for index in TrainerSkillsDB[charIndex] do
			local trainerInDb = strlower(index);
			if (trainerInDb == input) then
				TrainerSkillsDB[charIndex][index] = nil;
				DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: '"..input.."' "..TRAINERSKILLS_CAHT_TRAINER_DELETED);
				done = 1;
			end
		end
		if ( not done ) then
			DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: '"..input.."' "..TRAINERSKILLS_CHAT_TRAINER_NOT_FOUND);
		end
	elseif (input and type == 2 ) then
		TrainerSkillsDB[selectedChar][input] = nil;
	elseif (type == 3 ) then --Delete selected trainertype
		TrainerSkillsDB[selectedChar][selectedNpc] = nil;
		cleanTrainerTypesTable();
		UIDropDownMenu_SetSelectedID(TrainerSkillsNpcDropDown, nil);
	elseif (type == 4 ) then --CleanUp redundant data
		local countDeletet = 0;
		DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: "..countDeletet.." "..TRAINERSKILLS_CHAT_CLEANUP);
	elseif (type == 5) then --cleanup unselected data
		local countDeletet = 0;
		for index in TrainerSkillsDB do
			for npc in TrainerSkillsDB[index] do
				if ( TrainerSkillsVar.grabNpcNamesAndLocations == 0 and TrainerSkillsDB[index][npc].TrainerNamesToolTip ) then
					TrainerSkillsDB[index][npc].TrainerNamesToolTip = nil;
					countDeletet = countDeletet + 1;
				end
				local cSkills = TrainerSkillsDB[index][npc].skills;
				local cSkillsTrainer = TrainerSkillsTrainerTypes[npc].skills;
				if ( cSkills ) then
					for cSkill in cSkills do
						if ( TrainerSkillsVar.grabTooltips == 0 and cSkillsTrainer[cSkill].toolTipNumLines ) then
							cSkillsTrainer[cSkill].toolTipNumLines = nil;
				 			cSkillsTrainer[cSkill].toolTipLines = nil;
				 			countDeletet = countDeletet + 1;
						end
						if ( TrainerSkillsVar.grabDescription == 0 and cSkillsTrainer[cSkill].GetTrainerServiceDescription ) then
							cSkillsTrainer[cSkill].GetTrainerServiceDescription = nil;
							countDeletet = countDeletet + 1;
						end
					end
				end
			end
		end
		for char in TrainerSkillsVar do
			if ( strfind(char, "|") and TrainerSkillsVar.savePlayerSkills == 0 and TrainerSkillsVar[char].mySavedCraftSkills ) then
				TrainerSkillsVar[char].mySavedCraftSkills = nil;
				countDeletet = countDeletet + 1;
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: "..countDeletet.." "..TRAINERSKILLS_CHAT_CLEANUP);
	else
		for index in TrainerSkillsDB[charIndex] do
			TrainerSkillsDB[charIndex][index] = nil;
		end
		DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: "..TRAINERSKILLS_CHAT_CHAR_CLEARED);
	end
	TrainerSkills_ClrFrame();
end

function TrainerSkills_ClrNewTable()
	TrainerSkillsTrainerTypes = nil;
	TrainerSkillsTrainerTypes = {};
end

function TrainerSkills_ConvertToNewDataStructure()
	TrainerSkillsVar.keepGreys = nil;
	TrainerSkillsVar.saveTrainerFilter = 1;
	for char in TrainerSkillsDB do
		local tempTrainerSkillsDB = {};
		for npc in TrainerSkillsDB[char] do
			if(not TrainerSkillsDB[char][npc].GetNumTrainerServices )then
				return;
			end
			if ( TrainerSkillsDB[char][npc].GetNumTrainerServices > 1 ) then
				local trainer = npc;
				local cSkills = TrainerSkillsDB[char][npc].skills;
				local sameTrainer = TrainerSkills_GetTrainerTypeWithSameSkills(cSkills);
				if (sameTrainer) then
					TrainerSkillsTrainerTypes[sameTrainer].skills = TrainerSkills_CopyOverLevelReq(sameTrainer, cSkills, nil);
					trainer = sameTrainer;
				else
					local done = nil;
					local n = 2;
					while (not done) do
						if ( not TrainerSkillsTrainerTypes[trainer] ) then
							TrainerSkillsTrainerTypes[trainer] = {};
							done = 1;
						else
							local rtimes;
							trainer, rtimes = gsub(trainer,"[0-9]","");
							if ( rtimes == 0 ) then
								trainer = trainer.." "..n;
							else
								trainer = trainer..n;
							end
							n = n + 1;
						end
					end
				end
				
				if (TRINER_SKILLS_DEBUG) then
					DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: Trainer:"..trainer.."char:"..char);
				end
				
				if ( cSkills ) then
					TrainerSkillsTrainerTypes[trainer].skills = {};
					for cSkill in cSkills do
						TrainerSkillsTrainerTypes[trainer].skills[cSkill] = {};
						if (cSkills[cSkill].moneyCost) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].moneyCost = cSkills[cSkill].moneyCost;
							cSkills[cSkill].moneyCost = nil;
						end
						if (cSkills[cSkill].toolTipNumLines) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].toolTipNumLines = cSkills[cSkill].toolTipNumLines;
							cSkills[cSkill].toolTipNumLines = nil;
						end
						if (cSkills[cSkill].toolTipLines) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].toolTipLines = cSkills[cSkill].toolTipLines;
							cSkills[cSkill].toolTipLines = nil;
						end
						if (cSkills[cSkill].GetTrainerServiceDescription) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].GetTrainerServiceDescription = cSkills[cSkill].GetTrainerServiceDescription;
							cSkills[cSkill].GetTrainerServiceDescription = nil;
						end
						if (cSkills[cSkill].GetTrainerServiceNumAbilityReq) then
							if ( cSkills[cSkill].GetTrainerServiceNumAbilityReq > 0 ) then
								local abilities = cSkills[cSkill].GetTrainerServiceAbilityReq;
								local abilitiesTrainer = {};
								for i=1,cSkills[cSkill].GetTrainerServiceNumAbilityReq,1 do
									abilitiesTrainer[i] = {};
									abilitiesTrainer[i].ability = abilities[i].ability;
									abilities[i].ability = nil;
								end
								cSkills[cSkill].GetTrainerServiceAbilityReq = abilities;
								TrainerSkillsTrainerTypes[trainer].skills[cSkill].GetTrainerServiceAbilityReq = abilitiesTrainer;
								TrainerSkillsTrainerTypes[trainer].skills[cSkill].GetTrainerServiceNumAbilityReq = cSkills[cSkill].GetTrainerServiceNumAbilityReq;
							end
							cSkills[cSkill].GetTrainerServiceNumAbilityReq = nil;
						end
						if (cSkills[cSkill].ServiceLearnSpellIsLearnSpell) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].ServiceLearnSpellIsLearnSpell = cSkills[cSkill].ServiceLearnSpellIsLearnSpell;
							cSkills[cSkill].ServiceLearnSpellIsLearnSpell = nil;
						end
						if (cSkills[cSkill].serviceName) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].serviceName = cSkills[cSkill].serviceName;
							cSkills[cSkill].serviceName = nil;
						end
						if (cSkills[cSkill].serviceSubText) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].serviceSubText = cSkills[cSkill].serviceSubText;
							cSkills[cSkill].serviceSubText = nil;
						end
						if (cSkills[cSkill].GetTrainerServiceLevelReq) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].GetTrainerServiceLevelReq = cSkills[cSkill].GetTrainerServiceLevelReq;
							cSkills[cSkill].GetTrainerServiceLevelReq = nil;
						end
						if (cSkills[cSkill].SkillReqRank) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].SkillReqRank = cSkills[cSkill].SkillReqRank;
							cSkills[cSkill].SkillReqRank = nil;
						end
						if (cSkills[cSkill].GetTrainerServiceIcon) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].GetTrainerServiceIcon = cSkills[cSkill].GetTrainerServiceIcon;
							cSkills[cSkill].GetTrainerServiceIcon = nil;
						end
						if (cSkills[cSkill].SkillReqSkill) then
							TrainerSkillsTrainerTypes[trainer].skills[cSkill].SkillReqSkill = cSkills[cSkill].SkillReqSkill;
							cSkills[cSkill].SkillReqSkill = nil;
						end
						cSkills[cSkill].ServiceStepReqMet = nil;
						cSkills[cSkill].ServiceStepReqStep = nil;
					end
				end
				
				tempTrainerSkillsDB[trainer] = {};
				tempTrainerSkillsDB[trainer].skills = cSkills;
				tempTrainerSkillsDB[trainer].TrainerNamesToolTip = TrainerSkillsDB[char][npc].TrainerNamesToolTip;
				
				TrainerSkillsTrainerTypes[trainer].GetNumTrainerServices = TrainerSkillsDB[char][npc].GetNumTrainerServices;
				TrainerSkillsTrainerTypes[trainer].IsTradeskillTrainer = TrainerSkillsDB[char][npc].IsTradeskillTrainer;
				TrainerSkillsDB[char][npc].GetNumTrainerServices = nil;
				TrainerSkillsDB[char][npc].TrainerNamesToolTip = nil;	
				TrainerSkillsDB[char][npc].IsTradeskillTrainer = nil;	
			end
		end
		if ( tempTrainerSkillsDB ) then
			TrainerSkillsDB[char] = {};
			for tempTrainer in tempTrainerSkillsDB do
				TrainerSkillsDB[char][tempTrainer] = {};
				TrainerSkillsDB[char][tempTrainer].skills = tempTrainerSkillsDB[tempTrainer].skills;
				TrainerSkillsDB[char][tempTrainer].TrainerNamesToolTip = tempTrainerSkillsDB[tempTrainer].TrainerNamesToolTip;
			end
		end
	end
end

----------------------------------------------------
--UI functions
----------------------------------------------------
function TrainerSkillsMinimapButton_Toggle(print)
	if ( TrainerSkillsVar.mmb == 1 ) then
		TrainerSkillsVar.mmb = 0;
		TrainerSkillsMinimapButton:Hide();
		if ( print ) then
			DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_MINIMAP_BUTTON_OFF);
		end
	else
		TrainerSkillsVar.mmb = 1;
		TrainerSkillsMinimapButton:Show();
		if ( print ) then
			DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_MINIMAP_BUTTON_ON);
		end
	end
end

function TrainerSkillsConfig_Toggle()
	if (TrainerSkillsConfig:IsVisible()) then
		TrainerSkillsConfig:Hide();
	else
		TrainerSkillsConfig:Show();
	end
end

function TrainerSkillsMinimapButton_Moveable_Toggle()
	if ( TrainerSkillsVar.mmbMov == 1 ) then
		TrainerSkillsVar.mmbMov = 0;
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_OFF);
	else
		TrainerSkillsVar.mmbMov = 1;
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_ON);
	end
end

function TrainerSkillsMinimapButton_OnEnter ()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	GameTooltip:SetText(TRAINERSKILLS_MINIMAP_BUTTON, 1.0, 1.0, 1.0);
end

function TrainerSkills_Show()
	SetPortraitTexture(TrainerSkillsPortrait, "player");
	if ( selectedNpc) then
		TrainerSkills_Update();
	end
	ShowUIPanel(TrainerSkills);
end

function TrainerSkills_Hide()
	HideUIPanel(TrainerSkills);
end

function TrainerSkills_Toggle()
	if (TrainerSkills:IsVisible()) then
		TrainerSkills_Hide();
	else
		TrainerSkills_Show();
	end
end

function TrainerSkills_DisableFilterButtons(value)
	if ( value ) then
		--Do action for the 3 buttons in the filter dropdown - starting by 2 because we are skipping the "Show only" entry
		for i = 2, 4, 1 do
			UIDropDownMenu_DisableButton(1, i);
		end
	else
		for i = 2, 4, 1 do
			UIDropDownMenu_EnableButton(1, i);
		end
	end
end

function TrainerSkillsMinimapButton_MouseDown()
	if ( TrainerSkillsVar.mmbMov == 1 ) then
		TrainerSkillsMinimapButton:StartMoving();
	end
end
function TrainerSkillsMinimapButton_MouseUp()
	if ( TrainerSkillsVar.mmbMov == 1 ) then
		TrainerSkillsMinimapButton:StopMovingOrSizing();
	end
end

function TrainerSkills_ClrFrame()
	for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED, 1 do
		local skillButton = getglobal("TrainerSkillsSkill"..i);
		skillButton:Hide();
	end
	TrainerSkills_HideSkillDetails();
	TrainerSkills_DisableFilterButtons(1);
	UIDropDownMenu_SetText(TRAINERSKILLS_TRAINER_DROPDOWN, TrainerSkillsNpcDropDown);
	TrainerSkillsCollapseAllButton:Disable();
	TrainerSkillsSkillHighlightFrame:Hide();
	TrainerSkillsListScrollFrame:Hide();
	TrainerSkillsDeleteTrainerButton:Hide();
	selectedNpc = nil;
	selectedService = nil;
end

function TrainerSkillsNpcDropDown_Initialize()
	UIDropDownMenu_SetWidth(220, TrainerSkillsNpcDropDown);
	UIDropDownMenu_SetText(TRAINERSKILLS_TRAINER_DROPDOWN, TrainerSkillsNpcDropDown);
	local index = {};
	local info = {};
	info.text = NORMAL_FONT_COLOR_CODE..TRAINERSKILLS_CHOOSE_TRAINER..FONT_COLOR_CODE_CLOSE;
	info.checked = 1;
	UIDropDownMenu_AddButton(info);
	UIDropDownMenu_DisableButton(1, 1);

	for index in TrainerSkillsDB[selectedChar] do
		if(not TrainerSkillsTrainerTypes[index]) then
			TrainerSkillsDB[selectedChar][index] = nil;
			if(TRINER_SKILLS_DEBUG)then
				DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: Deleted "..index.." from "..selectedChar.." because of missing data in the trainerTypes table");
			end
		else
			info = {};
			if (TrainerSkillsTrainerTypes[index].IsTradeskillTrainer) then
				info.text = GRAY_FONT_COLOR_CODE..index..FONT_COLOR_CODE_CLOSE;
			else
				info.text = index;
			end
			if (TrainerSkillsDB[selectedChar][index].TrainerNamesToolTip) then
				TrainerNamesToolTip = TrainerSkillsDB[selectedChar][index].TrainerNamesToolTip;
				local toolTipString = "";
				for index in TrainerNamesToolTip do
					toolTipString = toolTipString..TrainerNamesToolTip[index].."\n";
				end
				info.tooltipTitle = TRAINERSKILLS_TRAINER_NAMES;
				info.tooltipText = toolTipString;
			end
			info.value = index;
			info.checked = nil;
			info.func = TrainerSkillsNpcDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
end

function TrainerSkillsNpcDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(TrainerSkillsNpcDropDown, this:GetID());
	selectedNpc = this.value;
	skills = TrainerSkillsDB[selectedChar][selectedNpc].skills;
	skillsData = TrainerSkillsTrainerTypes[selectedNpc].skills;
	selectedService = nil;
	TrainerSkills_HideSkillDetails();
	FauxScrollFrame_SetOffset(TrainerSkillsListScrollFrame, 0);
	TrainerSkillsListScrollFrameScrollBar:SetValue(0);
	TrainerSkills_Update();
	TrainerSkills_DisableFilterButtons(nil);
	if ( not TrainerSkillsDeleteTrainerButton:IsVisible() ) then
		TrainerSkillsDeleteTrainerButton:Show();
	end
end

function TrainerSkillsCharDropDown_Initialize()

	UIDropDownMenu_SetWidth(141, TrainerSkillsCharDropDown);
	UIDropDownMenu_SetText(TRAINERSKILLS_CHARACTER_DROPDOWN, TrainerSkillsCharDropDown);
	local index = {};
	local info = {};
	
	info.text = NORMAL_FONT_COLOR_CODE..TRAINERSKILLS_CHARACTER_DROPDOWN_FIRST_ENTRY..FONT_COLOR_CODE_CLOSE;
	info.checked = 1;
	info.value = nil;
	UIDropDownMenu_AddButton(info);
	UIDropDownMenu_DisableButton(1, 1);
	
	for index in TrainerSkillsDB do
		info = {};
		if ( index == charIndex ) then
			info.text = string.gsub(index, "|", " "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." ");
		else
			info.text = GRAY_FONT_COLOR_CODE..string.gsub(index, "|", " "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." ")..FONT_COLOR_CODE_CLOSE;
		end

		if (TrainerSkillsVar[index] and TrainerSkillsVar[index].mySavedCraftSkills) then
			local mySavedCraftSkills = TrainerSkillsVar[index].mySavedCraftSkills;
			local toolTipString = "";
			local numSkill = mySavedCraftSkills.numSkills;
			
			if (mySavedCraftSkills.charLevel) then
				toolTipString = "|cff00FF00"..TRAINERSKILLS_CHARACTER_LEVEL.."|r |cffFFFFFF"..mySavedCraftSkills.charLevel.."|r\n";
			end
			
			for i = 1, numSkill, 1 do
				if ( mySavedCraftSkills[i] ) then
					if (mySavedCraftSkills[i].skillRank > 0) then
						toolTipString = toolTipString.."|cff00FF00"..mySavedCraftSkills[i].skillName..":|r |cffFFFFFF"..mySavedCraftSkills[i].skillRank.."|r\n";
					else
						toolTipString = toolTipString..mySavedCraftSkills[i].skillName.."\n";
					end
				end
			end
			info.tooltipTitle = TRAINERSKILLS_CHARACTER_INFO;
			info.tooltipText = toolTipString;
		end
		info.value = index;
		info.checked = nil;
		info.func = TrainerSkillsCharDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end

	--If nothing is selectet the current character is chosen
	if ( not UIDropDownMenu_GetSelectedID(TrainerSkillsCharDropDown) and TrainerSkillsDB[charIndex] ) then
		UIDropDownMenu_SetSelectedValue(TrainerSkillsCharDropDown, charIndex);
	end
end

function TrainerSkillsCharDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(TrainerSkillsCharDropDown, this:GetID());
	selectedChar = this.value;
	UIDropDownMenu_SetSelectedID(TrainerSkillsNpcDropDown, nil);
	TrainerSkills_ClrFrame();
end

function TrainerSkills_AllowedByFilter(skillIndex)
	serviceType = skills[skillIndex].serviceType;
	local ret;
	if ( serviceType == "used" and not skillsFilter.used ) then
		ret = nil;
	elseif ( serviceType == "available" and  not skillsFilter.available ) then
		ret = nil;
	elseif ( serviceType == "unavailable" and not skillsFilter.unavailable ) then
		ret = nil;
	else
		ret = 1;
	end
	return ret;
end

function TrainerSkills_CountSkillsToShow(numTrainerServices)
	local count = 0;
	for i = 1, numTrainerServices, 1 do
		if (TrainerSkills_AllowedByFilter(i) and TrainerSkills_ShowHeader(i, numTrainerServices) and ( skills[i].isExpanded or skills[i].serviceType == "header" )) then
			count = count + 1;
		end
	end
	return count;
end

function TrainerSkills_FirstSkillToShow(offset, numTrainerServices)
	local count = 0;
	local i = 1;
	while (i <= numTrainerServices and count <= offset) do
		if (TrainerSkills_AllowedByFilter(i) and TrainerSkills_ShowHeader(i, numTrainerServices) and ( skills[i].isExpanded or skills[i].serviceType == "header" )) then
			count = count + 1;
		end
		i = i + 1;
	end
	return i - 1;
end

--Checks weather or not to show the header (if it is a header)
function TrainerSkills_ShowHeader(tempSkillIndex, numTrainerServices)
	local ret = 1;
	local skip = 1;
	if ( skills[tempSkillIndex].serviceType == "header") then
		tempSkillIndex = tempSkillIndex + 1;
		while ( tempSkillIndex <= numTrainerServices and skip ) do
			skip = nil;
			if ( not TrainerSkills_AllowedByFilter(tempSkillIndex) ) then
				skip = 1;
				tempSkillIndex = tempSkillIndex + 1;
			end
		end
		if ( tempSkillIndex > numTrainerServices or skills[tempSkillIndex].serviceType == "header" ) then
			ret = nil;
		end
	end
	return ret;
end

function TrainerSkills_Update()
	local numTrainerServices = TrainerSkillsTrainerTypes[selectedNpc].GetNumTrainerServices;
	
	if ( not numTrainerServices or not skills or getn(skills) ~= numTrainerServices ) then
		TrainerSkills_ResetDB(selectedNpc, 2);
		DEFAULT_CHAT_FRAME:AddMessage(TRAINERSKILLS_CHAT_CORUPT_DATA);
		return;
	end
	
	local skillOffset = FauxScrollFrame_GetOffset(TrainerSkillsListScrollFrame);
	
	-- If no spells then clear everything out
	if ( numTrainerServices == 0 ) then
		TrainerSkillsCollapseAllButton:Disable();
		TrainerSkills_HideSkillDetails();
		for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED, 1 do
			local skillButton = getglobal("TrainerSkillsSkill"..i);
			skillButton:Hide();
		end
		return;
	else
		TrainerSkillsCollapseAllButton:Enable();
	end

	-- If selectedService is nil hide everything
	if ( not selectedService ) then
		TrainerSkills_HideSkillDetails();
	end

	-- Change the setup depending on if its a class trainer or tradeskill trainer
	if ( TrainerSkillsTrainerTypes[selectedNpc].IsTradeskillTrainer ) then
		TrainerSkills_SetToTradeSkillTrainer();
	else
		TrainerSkills_SetToTrainerSkills();
	end

	-- ScrollFrame update
	FauxScrollFrame_Update(TrainerSkillsListScrollFrame, TrainerSkills_CountSkillsToShow(numTrainerServices), CLASS_TRAINER_SKILLS_DISPLAYED, CLASS_TRAINER_SKILL_HEIGHT, nil, nil, nil, TrainerSkillsSkillHighlightFrame, 293, 316 )
	TrainerSkillsMoneyFrame:Show();
	TrainerSkillsSkillHighlightFrame:Hide();
	
	-- Fill in the skill buttons
	local buttonIndex = 1;
	local buttonID = 1;

	local i = TrainerSkills_FirstSkillToShow(skillOffset, numTrainerServices) - skillOffset;

	while (buttonIndex <= CLASS_TRAINER_SKILLS_DISPLAYED) do
		
		local tempSkillIndex = i + skillOffset;

		local skip = 1;
		while ( tempSkillIndex <= numTrainerServices and skip ) do
			skip = nil;
			if ( TrainerSkills_AllowedByFilter(tempSkillIndex) and TrainerSkills_ShowHeader(tempSkillIndex, numTrainerServices)) then
				if ( skills[tempSkillIndex].serviceType ~= "header" and not skills[tempSkillIndex].isExpanded ) then
					skip = 1;
					tempSkillIndex = tempSkillIndex + 1;
				end
			else
				skip = 1;
				tempSkillIndex = tempSkillIndex + 1;
			end
		end
		
		i = tempSkillIndex - skillOffset;
		
		local skillIndex = i + skillOffset;
		
		if ( not skip ) then	
			
			local skillButton = getglobal("TrainerSkillsSkill"..buttonIndex);
			local serviceName, serviceSubText, serviceType, isExpanded;
			local moneyCost;
			
			serviceName = skillsData[skillIndex].serviceName;
			serviceSubText = skillsData[skillIndex].serviceSubText;
			serviceType = skills[skillIndex].serviceType;
			isExpanded = skills[skillIndex].isExpanded;
			
			if ( not serviceName ) then
				serviceName = TEXT(UNKNOWN);
			end
			-- Set button widths if scrollbar is shown or hidden
			if ( TrainerSkillsListScrollFrame:IsVisible() ) then
				skillButton:SetWidth(293);
			else
				skillButton:SetWidth(323);
			end
			local skillSubText = getglobal("TrainerSkillsSkill"..buttonIndex.."SubText");
			-- Type stuff
			if ( serviceType == "header" ) then
				skillButton:SetText(serviceName);
				skillButton:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				skillSubText:Hide();
				if ( isExpanded ) then
					skillButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
				else
					skillButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				end
				getglobal("TrainerSkillsSkill"..buttonIndex.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
			else
				skillButton:SetNormalTexture("");
				getglobal("TrainerSkillsSkill"..buttonIndex.."Highlight"):SetTexture("");
				skillButton:SetText("  "..serviceName);

				if ( serviceSubText and serviceSubText ~= "" ) then
					skillSubText:SetText(format(TEXT(PARENS_TEMPLATE), serviceSubText));
					skillSubText:SetPoint("LEFT", "TrainerSkillsSkill"..buttonIndex.."Text", "RIGHT", 10, 0);
					skillSubText:Show();
				else
					skillSubText:Hide();
				end
				
				-- Cost Stuff
				moneyCost = skillsData[skillIndex].moneyCost;
				
				if ( serviceType == "available" ) then
					skillButton:SetTextColor(0, 1.0, 0);
					TrainerSkills_SetSubTextColor(skillButton, 0, 0.6, 0);
					skillButton.r = 0;
				elseif ( serviceType == "used" ) then
					skillButton:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
					TrainerSkills_SetSubTextColor(skillButton, 0.5, 0.5, 0.5);
				elseif ( serviceType == "maybeUsed" ) then
					skillButton:SetTextColor(1, 1, 0);
					TrainerSkills_SetSubTextColor(skillButton, 1, 1, 0.1);
				else
					skillButton:SetTextColor(0.9, 0, 0);
					TrainerSkills_SetSubTextColor(skillButton, 0.6, 0, 0);
				end
			end
			skillButton:SetID(skillIndex);
			skillButton:Show();

			-- Place the highlight and lock the highlight state
			if ( selectedService and selectedService == skillIndex ) then
				TrainerSkillsSkillHighlightFrame:SetPoint("TOPLEFT", "TrainerSkillsSkill"..buttonIndex, "TOPLEFT", 0, 0);
				TrainerSkillsSkillHighlightFrame:Show();
				skillButton:LockHighlight();
				TrainerSkills_SetSubTextColor(skillButton, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				if ( moneyCost and moneyCost > 0 ) then
					TrainerSkillsCostLabel:Show();
				end
			else
				skillButton:UnlockHighlight();
			end
			buttonIndex = buttonIndex + 1;
			buttonID = buttonID + 1;
		elseif ( skillIndex > numTrainerServices ) then
			
			local skillButton = getglobal("TrainerSkillsSkill"..buttonIndex);
			skillButton:Hide();
			buttonIndex = buttonIndex + 1;
		end
		i = i + 1;
	end
	
	availableSkillsTotalCost = 0;
	unavailableSkillsTotalCost = 0;
		
	-- Set the expand/collapse all button texture
	local numHeaders = 0;
	local notExpanded = 0;
	local showDetails = nil;
	-- Somewhat redundant loop, but cleaner than the alternatives
	for i=1, numTrainerServices, 1 do
		local serviceName, serviceSubText, serviceType, isExpanded;
		serviceName = skillsData[i].serviceName;
		serviceSubText = skillsData[i].serviceSubText;
		serviceType = skills[i].serviceType;
		isExpanded = skills[i].isExpanded;
		
		if ( serviceName ) then
			if(serviceType == "header") then
				numHeaders = numHeaders + 1;
				if ( not isExpanded ) then
					notExpanded = notExpanded + 1;
				end
			elseif ( serviceType == "available" ) then
				availableSkillsTotalCost = availableSkillsTotalCost + skillsData[i].moneyCost;
			elseif ( serviceType == "unavailable" ) then
				unavailableSkillsTotalCost = unavailableSkillsTotalCost + skillsData[i].moneyCost;
			end
		end
		-- Show details if selected skill is visible
		if ( selectedService == i ) then
			showDetails = 1;
		end
	end
	-- Show skill details if the skill is visible
	if ( showDetails ) then
		TrainerSkills_ShowSkillDetails();
	else	
		TrainerSkills_HideSkillDetails();
	end
	-- If all headers are not expanded then show collapse button, otherwise show the expand button
	if ( notExpanded ~= numHeaders ) then
		TrainerSkillsCollapseAllButton.collapsed = nil;
		TrainerSkillsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	else
		TrainerSkillsCollapseAllButton.collapsed = 1;
		TrainerSkillsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	end
	
end



function TrainerSkills_SetSelection(id)
	-- General Info
	if ( not id ) then
		TrainerSkills_HideSkillDetails();
		return;
	end
	
	local serviceName, serviceSubText, serviceType, isExpanded;
	serviceName = skillsData[id].serviceName;
	serviceSubText = skillsData[id].serviceSubText;
	serviceType = skills[id].serviceType;
	isExpanded = skills[id].isExpanded;
	
	TrainerSkillsSkillHighlightFrame:Show();
	
	if ( serviceType == "available" ) then
		TrainerSkillsSkillHighlight:SetVertexColor(0, 1.0, 0);
	elseif ( serviceType == "used" ) then
		TrainerSkillsSkillHighlight:SetVertexColor(0.5, 0.5, 0.5);
	elseif ( serviceType == "unavailable" ) then
		TrainerSkillsSkillHighlight:SetVertexColor(0.9, 0, 0);
	elseif (serviceType == "maybeUsed" ) then
		TrainerSkillsSkillHighlight:SetVertexColor(1, 1, 0);
	else
		-- Is header, so collapse or expand header
		TrainerSkillsSkillHighlightFrame:Hide();
		if ( isExpanded ) then
			skills[id].isExpanded = nil;
			TrainerSkills_MarkCollapsed(id + 1, nil);
		else
			skills[id].isExpanded = 1;
			TrainerSkills_MarkCollapsed(id + 1, 1);
		end
		TrainerSkills_Update()
		return;
	end

	if ( showSkillDetails ) then
		TrainerSkills_ShowSkillDetails();
	else
		TrainerSkills_HideSkillDetails();
		return;
	end

	if ( not serviceName ) then
		serviceName = TEXT(UNKNOWN);
	end
	TrainerSkillsSkillName:SetText(serviceName);
	if ( not serviceSubText ) then
		serviceSubText = "";
	end
	TrainerSkillsSubSkillName:SetText(format(TEXT(PARENS_TEMPLATE), serviceSubText));
	selectedService = id;
	if ( skillsData[id].GetTrainerServiceIcon ) then
		TrainerSkillsSkillIcon:SetNormalTexture(skillsData[id].GetTrainerServiceIcon);
	else
		TrainerSkillsSkillIcon:SetNormalTexture(nil);
	end
	-- Build up the requirements string
	local requirements = "";
	-- Level Requirements
	local reqLevel = skillsData[id].GetTrainerServiceLevelReq;
	local isLearnSpell = skillsData[id].ServiceLearnSpellIsLearnSpell;
	local isPetLearnSpell = skillsData[id].ServiceLearnSpellIsPetLearnSpell;
	local separator = "";
	if ( reqLevel > 1 ) then
		separator = ", ";
		if ( isPetLearnSpell ) then
			if ( UnitLevel("pet") >= reqLevel ) then
				requirements = requirements..format(TEXT(TRAINER_PET_LEVEL), reqLevel);
			else
				requirements = requirements..format(TEXT(TRAINER_PET_LEVEL_RED), reqLevel);
			end
		else
			if ( UnitLevel("player") >= reqLevel ) then
				requirements = requirements..format(TEXT(TRAINER_REQ_LEVEL), reqLevel);
			else
				requirements = requirements..format(TEXT(TRAINER_REQ_LEVEL_RED), reqLevel);
			end
		end
	end
	-- Skill Requirements
	local skill, rank, hasReq;
	skill = skillsData[id].SkillReqSkill;
	rank = skillsData[id].SkillReqRank;
	hasReq = skills[id].SkillReqHasReq;
	if ( skill ) then
		if ( hasReq ) then
			requirements = requirements..separator..format(TEXT(TRAINER_REQ_SKILL_RANK), skill, rank );
		else
			requirements = requirements..separator..format(TEXT(TRAINER_REQ_SKILL_RANK_RED), skill, rank );
		end
		separator = ", ";
	end
	-- Ability Requirements
	local numRequirements = skillsData[id].GetTrainerServiceNumAbilityReq;
	local ability, abilityType;
	if ( numRequirements and numRequirements > 0 ) then
		local ServiceAbilityReq = skills[id].GetTrainerServiceAbilityReq;
		local ServiceAbilityReqTrainer = skillsData[id].GetTrainerServiceAbilityReq;
		for i=1, numRequirements, 1 do		
		
			ability = ServiceAbilityReqTrainer[i].ability;
			if (ServiceAbilityReq) then
				hasReq = ServiceAbilityReq[i].hasReq;
			else
				hasReq = nil;
			end
			abilityType = skills[id].serviceType;
			if ( hasReq or (abilityType == "used") ) then
				requirements = requirements..separator..format(TEXT(TRAINER_REQ_ABILITY), ability );
			else
				requirements = requirements..separator..format(TEXT(TRAINER_REQ_ABILITY_RED), ability );
			end
			separator = ", ";
		end
	end
	-- Step Requirements. This is some really wird stuff - maybe leftovers from very old code. The data saved in ReqStep is totally useless.
--	local step, met;
--	step = skills[id].ServiceStepReqStep;
--	met = skills[id].ServiceStepReqMet;
--	if ( step ) then
--		if ( met ) then
--			requirements = requirements..separator..format(TEXT(TRAINER_REQ_ABILITY), step );
--		else 
--			requirements = requirements..separator..format(TEXT(TRAINER_REQ_ABILITY_RED), step );
--		end
--	end
	if ( requirements ~= "" ) then
		TrainerSkillsSkillRequirements:SetText(REQUIRES_LABEL.." "..requirements);
	else
		TrainerSkillsSkillRequirements:SetText("");
	end

	-- Money Frame and cost
	local moneyCost = skillsData[id].moneyCost;
	if ( moneyCost == 0 ) then
		TrainerSkillsDetailMoneyFrame:Hide();
		TrainerSkillsCostLabel:Hide();
		TrainerSkillsSkillDescription:SetPoint("TOPLEFT", "TrainerSkillsCostLabel", "TOPLEFT", 0, 0);
	else
		TrainerSkillsDetailMoneyFrame:Show();
		TrainerSkillsCostLabel:Show();
		TrainerSkillsSkillDescription:SetPoint("TOPLEFT", "TrainerSkillsCostLabel", "BOTTOMLEFT", 0, -10);
		if ( GetMoney() >= moneyCost ) then
			SetMoneyFrameColor("TrainerSkillsDetailMoneyFrame", 1.0, 1.0, 1.0);
		else
			SetMoneyFrameColor("TrainerSkillsDetailMoneyFrame", 1.0, 0.1, 0.1);
--			unavailable = 1;
		end
	end
	
	MoneyFrame_Update("TrainerSkillsDetailMoneyFrame", moneyCost);

--	if ( skills[id].GetTrainerServiceDescription ) then
--		TrainerSkillsSkillDescription:SetText( skills[id].GetTrainerServiceDescription );
--	else
--		TrainerSkillsSkillDescription:SetText("");
--	end
	-- Determine what type of spell to display
	if ( isLearnSpell ) then
		if ( isPetLearnSpell ) then
			TrainerSkillsSkillName:SetText(TrainerSkillsSkillName:GetText() ..TEXT(TRAINER_PET_SPELL_LABEL));
		end
	end
	
--Reagentdata
	local skillReagents = '';
	if (ReagentData) then	
		for skillLine in ReagentData['crafted'] do
			for skillType in ReagentData['crafted'][skillLine] do
				if(skillType == serviceName) then
					for key, value in ReagentData['crafted'][skillLine][skillType]['reagents'] do
						skillReagents = skillReagents..key..'('..value..') ';
					end
					break;
				end
			end
		end
	
		if(skillReagents ~= '') then
			skillReagents = '|cffFFD100'..SPELL_REAGENTS..FONT_COLOR_CODE_CLOSE..skillReagents.."\n";
		end
	end
--End regentData
	local skillDescr = skillsData[id].GetTrainerServiceDescription;
	if(skillDescr == nil) then
		skillDescr = '';
	end

	if (serviceType == "maybeUsed" and DemonTrainerFrame) then
		skillDescr = skillDescr.."\n\n"..DEMON_TRAINER_FRAME_YELLOW_FONT_COLOR_CODE..DEMON_TRAINER_FRAME_MAYBE_USED_DESCRIPTION..DEMON_TRAINER_FRAME_FONT_COLOR_CODE_CLOSE;
	end

	TrainerSkillsSkillDescription:SetText(skillReagents..skillDescr);
	
	TrainerSkillsDetailScrollFrame:UpdateScrollChildRect();
end

function TrainerSkillsSkillButton_OnClick(button)
	if ( button == "LeftButton" ) then
		showSkillDetails = 1;
		TrainerSkills_SetSelection(this:GetID());
		TrainerSkills_Update();
	end
end

function TrainerSkills_SetSubTextColor(button, r, g, b)
	button.r = r;
	button.g = g;
	button.b = b;
	getglobal(button:GetName().."SubText"):SetTextColor(r, g, b);
end

function TrainerSkillsCostToolTip_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(TRAINERSKILLS_TT_COST_STUFF, 1, 1, 1);
	local gold, silver, copper = TrainerSkills_MoneyFormat(availableSkillsTotalCost);
	if(GetMoney() >= availableSkillsTotalCost) then
		GameTooltip:AddLine(TRAINERSKILLS_TT_TOTAL_TRAIN_COST.." "..GREEN_FONT_COLOR_CODE..gold.."g "..silver.."s "..copper.."c"..FONT_COLOR_CODE_CLOSE, 1, 1, 1);
	else
		GameTooltip:AddLine(TRAINERSKILLS_TT_TOTAL_TRAIN_COST.." "..RED_FONT_COLOR_CODE..gold.."g "..silver.."s "..copper.."c"..FONT_COLOR_CODE_CLOSE, 1, 1, 1);
	end
	gold, silver, copper = TrainerSkills_MoneyFormat(unavailableSkillsTotalCost);
	GameTooltip:AddLine(TRAINERSKILLS_TT_UNAVAILABLE_TOTAL_COST.." "..gold.."g "..silver.."s "..copper.."c", 1, 1, 1);
	GameTooltip:AddLine(TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST_EXPLANATION);
	GameTooltip:Show();
end

function TrainerSkillsCostToolTip_OnLeave()
	GameTooltip:Hide();
end

function TrainerSkillsToolTip_OnEnter()
	if (skillsData[selectedService].GetTrainerServiceIcon) then
		local toolTipNumLines = skillsData[selectedService].toolTipNumLines;
		local toolTipLines = skillsData[selectedService].toolTipLines;
		
		if ( toolTipNumLines ) then		
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			local i = 1;
			while (i <= toolTipNumLines) do
				if ( i == 1 ) then
					GameTooltip:SetText(toolTipLines[i], 1, 1, 1);
				elseif ( i == toolTipNumLines ) then
					GameTooltip:AddLine(toolTipLines[i], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
				else
					GameTooltip:AddLine(toolTipLines[i], 1, 1, 1, 1);
				end
				i = i + 1;
			end
			GameTooltip:Show();
		end
	end
end

function TrainerSkillsToolTip_OnLeave()
	GameTooltip:Hide();
end

function TrainerSkillsSkillButton_OnEnter()
	getglobal(this:GetName().."SubText"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
end

function TrainerSkillsSkillButton_OnLeave()
	getglobal(this:GetName().."SubText"):SetTextColor(this.r, this.g, this.b);
end

function TrainerSkills_MarkCollapsed(skillIndex, value)
	while ( (skillIndex <= TrainerSkillsTrainerTypes[selectedNpc].GetNumTrainerServices) and (skills[skillIndex].serviceType ~= "header") ) do
		skills[skillIndex].isExpanded = value;
		skillIndex = skillIndex + 1;
	end
end

function TrainerSkills_MarkCollapsedAll(value)
	local skillIndex = 1;
	while ( (skillIndex <= TrainerSkillsTrainerTypes[selectedNpc].GetNumTrainerServices) ) do
		skills[skillIndex].isExpanded = value;
		skillIndex = skillIndex + 1;
	end
end

function TrainerSkillsCollapseAllButton_OnClick()
	if (this.collapsed) then
		this.collapsed = nil;
		TrainerSkills_MarkCollapsedAll(1);
		TrainerSkills_Update();
	else
		this.collapsed = 1;
		TrainerSkillsListScrollFrameScrollBar:SetValue(0);
		TrainerSkills_MarkCollapsedAll(nil);
		TrainerSkills_Update();
	end
end

function TrainerSkills_HideSkillDetails()
	TrainerSkillsSkillName:Hide();
	TrainerSkillsSkillIcon:Hide();
	TrainerSkillsSkillRequirements:Hide();
	TrainerSkillsSkillDescription:Hide();
	TrainerSkillsDetailMoneyFrame:Hide();
	TrainerSkillsCostLabel:Hide();
end

function TrainerSkills_ShowSkillDetails()
	TrainerSkillsSkillName:Show();
	TrainerSkillsSkillIcon:Show();
	TrainerSkillsSkillRequirements:Show();
	TrainerSkillsSkillDescription:Show();
	TrainerSkillsDetailMoneyFrame:Show();
end

function TrainerSkills_SetToTradeSkillTrainer()
	CLASS_TRAINER_SKILLS_DISPLAYED = 10;
	TrainerSkillsSkill11:Hide();
	TrainerSkillsListScrollFrame:SetHeight(168);
	TrainerSkillsDetailScrollFrame:SetHeight(135);
	local cp1, cp2 = UnitCharacterPoints("player");
	TrainerSkillsHorizontalBarLeft:SetPoint("TOPLEFT", "TrainerSkills", "TOPLEFT", 15, -259);
end

function TrainerSkills_SetToTrainerSkills()
	CLASS_TRAINER_SKILLS_DISPLAYED = 11;
	TrainerSkillsListScrollFrame:SetHeight(184);
	TrainerSkillsDetailScrollFrame:SetHeight(119);
	TrainerSkillsHorizontalBarLeft:SetPoint("TOPLEFT", "TrainerSkills", "TOPLEFT", 15, -275);
end

-- Dropdown functions
function TrainerSkillsFilterDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, TrainerSkillsFilterDropDown_Initialize);
	UIDropDownMenu_SetText(FILTER, TrainerSkillsFilterDropDown);
	UIDropDownMenu_SetWidth(60, TrainerSkillsFilterDropDown);
end

function TrainerSkillsFilterDropDown_Initialize()
	-- Available button
	local info = {};
	info.text = NORMAL_FONT_COLOR_CODE..TRAINERSKILLS_FILTER_DROPDOWN..FONT_COLOR_CODE_CLOSE;
	info.checked = 1;
	UIDropDownMenu_AddButton(info);
	UIDropDownMenu_DisableButton(1, 1);
	local checked = nil;
	if ( skillsFilter.available ) then
		checked = 1;
	end
	info.text = GREEN_FONT_COLOR_CODE..AVAILABLE..FONT_COLOR_CODE_CLOSE;
	info.value = "available";
	info.func = TrainerSkillsFilterDropDown_OnClick;
	info.checked = checked;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);

	-- Unavailable button
	info = {};
	checked = nil;
	if ( skillsFilter.unavailable ) then
		checked = 1;
	end
	info.text = RED_FONT_COLOR_CODE..UNAVAILABLE..FONT_COLOR_CODE_CLOSE;
	info.value = "unavailable";
	info.func = TrainerSkillsFilterDropDown_OnClick;
	info.checked = checked;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);

	-- Unavailable button
	info = {};
	checked = nil;
	if ( skillsFilter.used ) then
		checked = 1;
	end
	info.text = GRAY_FONT_COLOR_CODE..USED..FONT_COLOR_CODE_CLOSE;
	info.value = "used";
	info.func = TrainerSkillsFilterDropDown_OnClick;
	info.checked = checked;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	if ( not selectedNpc ) then
		TrainerSkills_DisableFilterButtons(1);
	end
	
end

function TrainerSkills_Filter(type, value)
	if ( value == 0 ) then
		value = nil;
	elseif ( value == 1 ) then
		--input ok
	else
		return;
	end
	
	if ( type == "available" ) then
		skillsFilter.available = value;
	elseif ( type == "unavailable" ) then
		skillsFilter.unavailable = value;
	elseif ( type == "used" ) then
		skillsFilter.used = value;
	end	
end

function TrainerSkillsFilterDropDown_OnClick()
	if ( UIDropDownMenuButton_GetChecked() ) then
		TrainerSkills_Filter(this.value, 0);
	else
		TrainerSkills_Filter(this.value, 1);
	end
	TrainerSkillsListScrollFrameScrollBar:SetValue(0);
	TrainerSkills_Update();
end

----------------------------------------------------
--TitanPanel functions
----------------------------------------------------
TRAINERSKILLS_TITAN_ID = "TrainerSkills";

local titanToolTip = "";

function TitanPanelTrainerSkillsButton_OnLoad()
  this.registry = {
    id = TRAINERSKILLS_TITAN_ID,
    menuText = TRAINERSKILLS_TITAN_MENU,
    buttonTextFunction = nil,
    tooltipTitle = TRAINERSKILLS_TITAN_ID,
    tooltipTextFunction = "TitanPanelTrainerSkillsButton_GetTooltipText",
    frequency = 0,
	icon = "Interface\\Icons\\INV_Misc_Book_08"
  };
end

function TitanPanelTrainerSkillsButton_GetTooltipText()
	if (not updateTitan or updateTitan == 1) then
		TrainerSkills_Create_TitanToolTip();
		updateTitan = 2;
	end
	return titanToolTip;
end

function TrainerSkills_Create_TitanToolTip() 
	titanToolTip = "";
	for trainer in TrainerSkillsDB[charIndex] do
		if(not TrainerSkillsTrainerTypes[trainer]) then
			TrainerSkillsDB[charIndex][trainer] = nil;
			if(TRINER_SKILLS_DEBUG)then
				DEFAULT_CHAT_FRAME:AddMessage("TrainerSkills: Deleted "..trainer.." from "..charIndex.." because of missing data in the trainerTypes table");
			end
		else
			local first = 1;
			local mySkills = TrainerSkillsDB[charIndex][trainer].skills;
			local mySkillsTrainer = TrainerSkillsTrainerTypes[trainer].skills;
			for index in mySkills do
				if ( mySkills[index].serviceType == "available" ) then
					if (first) then
						titanToolTip = titanToolTip.."\n|cffFFFFFF"..trainer..":|r";
						first = nil;
					end
					titanToolTip = titanToolTip.."\n"..mySkillsTrainer[index].serviceName; 
				end
			end
		end
	end
	
	if (titanToolTip ~= "") then
		titanToolTip = "\n"..TitanUtils_GetGreenText(TRAINERSKILLS_CHAT_NEW_LEARNABLE_SKILL)..titanToolTip;
	end

	titanToolTip = TitanUtils_GetGreenText(TRAINERSKILLS_MINIMAP_BUTTON).."\n"..titanToolTip;
end

function TitanPanelRightClickMenu_PrepareTrainerSkillsMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TRAINERSKILLS_TITAN_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TRAINERSKILLS_OPEN_CONFIG, nil, "TrainerSkillsConfig_Toggle");
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TRAINERSKILLS_TITAN_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelTrainerSkillsButton_OnClick(arg1)
  if arg1 == "LeftButton" then
    TrainerSkills_Toggle();
  end
end

function TrainerSkills_SetUpdateTitan(update)
	updateTitan = update;
end


