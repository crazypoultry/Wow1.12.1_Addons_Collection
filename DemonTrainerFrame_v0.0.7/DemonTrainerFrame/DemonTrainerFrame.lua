--DemonTrainerFrame made by Razzer (http://wow.pchjaelp.dk)
--[[
TODO:
- 
]]

CLASS_TRAINER_SKILLS_DISPLAYED = 11;
CLASS_TRAINER_SKILL_HEIGHT = 16;
local grabbedGrimories = {};
local initDone = nil;
function DemonTrainerFrame_ResetDB()
	DemonTrainerFrameDynamicData = nil;
	initDone = nil;
	DemonTrainerFrame_InitDB();
end
 
function DemonTrainerFrame_command(msg)
	msg = strlower(msg);
	if ( msg == "reset") then
		DemonTrainerFrame_ResetDB();
	elseif( msg == "buy" ) then
		if(DemonTrainerFrameDynamicData.buy)then
			DemonTrainerFrameDynamicData.buy = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DEMON_TRAINER_FRAME_BUY_AUTOMATIC);
		else
			DemonTrainerFrameDynamicData.buy = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DEMON_TRAINER_FRAME_BUY_MANUAL);
		end
	elseif( msg == "test" ) then
		
	--	UseContainerItem = function() DEFAULT_CHAT_FRAME:AddMessage("use disabled"); end;
	--	DEFAULT_CHAT_FRAME:AddMessage(UseContainerItem);
	else
		DEFAULT_CHAT_FRAME:AddMessage(DEMON_TRAINER_FRAME_SLASHCOMMANDS);
	end
end

local pre_MerchantFrame_OnEvent;
function DemonTrainerFrame_OnLoad()		
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PET_BAR_UPDATE");
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("UNIT_NAME_UPDATE");

	SlashCmdList["DemonTrainerFrame"] = function(msg)
		DemonTrainerFrame_command(msg);
	end
	SLASH_DemonTrainerFrame1 = "/DemonTrainerFrame";
	SLASH_DemonTrainerFrame2 = "/dtf";

	DemonTrainerFrameNameText:SetText(DEMON_TRAINER_FRAME_TITLE);
	DemonTrainerFrameDetailScrollFrame.scrollBarHideable = 1;
	
	pre_MerchantFrame_OnEvent = MerchantFrame_OnEvent;
	MerchantFrame_OnEvent = DemonTrainerFrame_OnEvent;
	
	UIPanelWindows["DemonTrainerFrame"] = { area = "left", pushable = 6 };
end


local function checkIsDemonTrainer()
	local numTrainerServices = GetMerchantNumItems();
	if(numTrainerServices < 1 ) then
		return;
	end
	local texture;
	local isDemonTrainer = 1;
	local i = 1;
	while (i <= numTrainerServices and isDemonTrainer) do 
		_, texture = GetMerchantItemInfo(i);
		if (texture ~= "Interface\\Icons\\INV_Misc_Book_06")then
			isDemonTrainer = nil;
		end
		i = i+1;
	end
	return isDemonTrainer;
end


local isDemonTrainer;
function DemonTrainerFrame_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		if(myAddOnsFrame) then
			myAddOnsList.DemonTrainerFrame = {name = "DemonTrainerFrame", description = DEMON_TRAINER_FRAME_DESCRIPTION, version = DEMON_TRAINER_FRAME_VERSION, category = MYADDONS_CATEGORY_CLASS, frame = "DemonTrainerFrame"};
		end
	elseif ( event == "MERCHANT_SHOW" ) then
		isDemonTrainer = checkIsDemonTrainer();
		if(isDemonTrainer)then
			ShowUIPanel(DemonTrainerFrame);
			if ( not DemonTrainerFrame:IsVisible() ) then
				CloseMerchant();
				return;
			end
		else
			pre_MerchantFrame_OnEvent();
		end
	elseif ( event == "MERCHANT_UPDATE" ) then
		if not (isDemonTrainer)then
			pre_MerchantFrame_OnEvent();
		end
	elseif ( event == "MERCHANT_CLOSED" ) then
		if not (isDemonTrainer)then
			pre_MerchantFrame_OnEvent();
		else
			HideUIPanel(DemonTrainerFrame);
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (not currentCharacter) then
			local character = UnitName("player");
			if (character ~= nil and character ~= UNKNOWNOBJECT) then
				DemonTrainerFrame_InitDB();
			end
		end
	elseif (event == "UNIT_NAME_UPDATE") then
		if (not currentCharacter) then
			local character = UnitName("player");
			if (character ~= nil and character ~= UNKNOWNOBJECT) then
				DemonTrainerFrame_InitDB();
			end
		end
	elseif (event == "CHAT_MSG_LOOT") then
		if (DemonTrainerFrame:IsVisible()) then
			DemonTrainerFrame_UpdateToGrey(arg1);
		end
	elseif ( event == "PET_BAR_UPDATE" ) then
		DemonTrainerFrame_GrabPetInfo();
	end
end

local function getNumbersFromString(chkString)
	local numStart, numEnd = strfind(chkString, "%d+");
	local number;
	if(numStart)then
		number = tonumber(strsub(chkString,numStart, numEnd));
	end
	return number;
end

local timedTasks = {};
local function timeTask(task, delay)
	for index in timedTasks do 
		if(timedTasks[index].task == task)then
			return;
		end
	end
	tinsert(timedTasks, {task = task, delay = delay, countedTime = 0});
	DemonTrainerFrameTimer:Show();
end

local timeCounter = 0;
local taskTimeCounter;
function DemonTrainerFrame_OnUpdate(arg1)
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
			DemonTrainerFrameTimer:Hide();
		end
	end
end

function DemonTrainerFrame_UpdateToGrey(arg1)
	for grim in grabbedGrimories do 
		if(strfind(arg1, grabbedGrimories[grim].grimoireName) and (grabbedGrimories[grim].spellRank and strfind(arg1, grabbedGrimories[grim].spellRank) or not grabbedGrimories[grim].spellRank)) then
			grabbedGrimories[grim].serviceType = "used";
			if(TrainerSkills and DemonTrainerFrameDynamicData.TrainerSkillsIndex and TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex] and TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex][grim] and TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex][grim].serviceType) then
				TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex][grim].serviceType = "used";
			end
			DemonTrainerFrame_SetSelection(grim);
			DemonTrainerFrame_Update();
			return;
		end
	end
	
end

function DemonTrainerFrame_GrabPetInfo()
	local petType = UnitCreatureFamily("pet");
	if(((not petType or petType == UNKNOWNOBJECT) and UnitExists("pet")))then
		timeTask(DemonTrainerFrame_GrabPetInfo, 1);
		return;
	elseif(not petType)then
		return;
	end
	petType = strlower(petType);
	if(not DemonTrainerFramePetInfo[petType])then
		DemonTrainerFramePetInfo[petType] = {};
	end
	local i = 1;
	while i do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_PET);
		if (not spellName) then
			if(i == 1)then
				timeTask(DemonTrainerFrame_GrabPetInfo, 1);
			end
			i = nil;
		else
			DemonTrainerFramePetInfo[petType][spellName] = {};
			DemonTrainerFramePetInfo[petType][spellName].spellRank = getNumbersFromString(spellRank);
			i = i+1;
		end
	end
	
	
	if(TrainerSkills and DemonTrainerFrameDynamicData.TrainerSkillsIndex and TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex]) then
		for service in TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex] do 
			if(TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex][service].serviceName == spellName and TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex][service].serviceType == "maybeUsed")then
				TrainerSkillsDB[TrainerSkills_GetCharIndex()][DemonTrainerFrameDynamicData.TrainerSkillsIndex][service].serviceType = "used";
			end
		end
	end
end


local currentCharacter;

function DemonTrainerFrame_InitDB()
	if ( not initDone and DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(DEMON_TRAINER_FRAME_LOADED);
	end
	
	if(not DemonTrainerFramePetInfo)then
		DemonTrainerFramePetInfo = {};
	end
	
	if(not DemonTrainerFrameDynamicData)then
		DemonTrainerFrameDynamicData = {};
	end
	
	if(DemonTrainerFrameDynamicData.grimoire) then
		DemonTrainerFrameDynamicData.grimoire = nil;
	end
	
	if(not DemonTrainerFrameDynamicData.filter)then
		DemonTrainerFrameDynamicData.filter = { available = 1, unavailable = 1, used = 0 };
	end

	initDone = 1;
end
local pre_UseContainerItem = nil;
function DemonTrainerFrame_Hide()
	HideUIPanel(DemonTrainerFrame);
	CloseMerchant();
	if(pre_UseContainerItem)then
		UseContainerItem = pre_UseContainerItem;
	end
	pre_UseContainerItem = nil;
	
	
end

local function DemonTrainerFrame_GetTransformedGrimoireInfo (i)
	local grimoireName, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i);
	if ( not grimoireName ) then
		return;
	end
	
	local link = GetMerchantItemLink(i);
			
	--serviceType
	if(isUsable)then
		serviceType = "available";
	else
		serviceType = "unavailable";
	end
	
	--[[
	DemonTrainerFrameTT:SetMerchantItem(i); 
	local toolTipNumLines = DemonTrainerFrameTT:NumLines();
	DEFAULT_CHAT_FRAME:AddMessage(getglobal("DemonTrainerFrameTTTextLeft"..1):GetText());
	if(toolTipNumLines) then
		local description = getglobal("DemonTrainerFrameTTTextLeft"..7):GetText();
	end
	]]--
	
	GameTooltip:SetMerchantItem(i); 
	local toolTipNumLines = GameTooltip:NumLines();
	local description = getglobal("GameTooltipTextLeft"..toolTipNumLines):GetText();
	--DEFAULT_CHAT_FRAME:AddMessage(description.." test");
	local petType = nil;
	local petKnown = nil;
	for index in DemonTrainerFramePetInfo do
		if(strfind(strlower(description), index, 1,true))then
			petType = index;
			petKnown = 1;
		end
	end
	
	if(not petKnown)then
		local stringStart = format(SPELLTEACHOTHEROTHER, ITEM_SPELL_TRIGGER_ONUSE, "1","");
		local subStart = strfind(stringStart, "1")
		local subEnd = strfind(description, "%s", subStart);
		petType = strsub(description, subStart,subEnd-1 );
	end
		
	local _, stringStart = strfind(strlower(description), strlower(petType));
	grimoireName = strsub(description, stringStart+2);
	grimoireName = gsub(grimoireName, "[%.%'%´%`%\"]", "");
	
	--Subtext
	local subStart = strfind(grimoireName,"(",1,true);
	local subEnd = strfind(grimoireName,")",1,true); 
	local spellRank = nil;
	local spellRankNumber = nil;
	if(subStart and subEnd)then
		spellRank = strsub(grimoireName,subStart+1,subEnd-1); 
		grimoireName = strsub(grimoireName,0 ,subStart-2);
		--DEFAULT_CHAT_FRAME:AddMessage(spellRank);
		spellRankNumber = getNumbersFromString(spellRank);
	end

	if(petKnown and DemonTrainerFramePetInfo[petType] and DemonTrainerFramePetInfo[petType][grimoireName] and (not spellRank or DemonTrainerFramePetInfo[petType][grimoireName].spellRank >= spellRankNumber))then
		serviceType = "used";
	elseif(not petKnown and serviceType == "available")then 
		serviceType = "maybeUsed";
	end
--DEFAULT_CHAT_FRAME:AddMessage(getglobal("GameTooltipTextLeft".."5"):GetText());
	local levelReqNum = getNumbersFromString(getglobal("GameTooltipTextLeft".."5"):GetText());
	DemonTrainerFrameTT:Hide();
	
	petType = strupper(strsub(petType,1,1))..strsub(petType,2);
	
	return grimoireName, spellRank, levelReqNum, texture, price, serviceType, petType, description, link; 
end


local numTrainerServices;
function DemonTrainerFrame_OnShow()
	numTrainerServices = GetMerchantNumItems(); 
	
	if(not numTrainerServices or numTrainerServices <= 0 ) then
		return;
	end
	
	local header = nil;
	local numHeaders = 0;
	local i = 1;
	local j = 1;
	local tmpGrabbedGrimories = {};
	grabbedGrimories = {};
	while( i <= numTrainerServices) do 
		local grimoireName, spellRank, levelReqNum, texture, price, serviceType, petType, description, link = DemonTrainerFrame_GetTransformedGrimoireInfo (i-numHeaders);
		if(not grimoireName or not levelReqNum or not texture or not price or not serviceType or not petType or not description) then
			grabbedGrimories = {};
			timeTask(DemonTrainerFrame_OnShow, 1);
--			DEFAULT_CHAT_FRAME:AddMessage(DEMON_TRAINER_FRAME_INCOMPLEATE_DATA);
			return;
		end
		
		if(petType and header ~= petType)then
			if(getn(tmpGrabbedGrimories) > 0)then
				sort(tmpGrabbedGrimories,function(a, b) return a.levelReqNum < b.levelReqNum; end );
				for grimoire in tmpGrabbedGrimories do
					tinsert(grabbedGrimories, tmpGrabbedGrimories[grimoire]);
				end
			end
			tmpGrabbedGrimories = {};
			j = 1;
			tmpGrabbedGrimories[j] = {};
			header = petType;
			grimoireName = header
			serviceType = "header";
			tmpGrabbedGrimories[j].grimoireName = grimoireName;
			tmpGrabbedGrimories[j].serviceType = "header";
			tmpGrabbedGrimories[j].levelReqNum = 0;
			numHeaders = numHeaders+1;
			numTrainerServices = numTrainerServices+1;
		else
			tmpGrabbedGrimories[j] = {};
			tmpGrabbedGrimories[j].grimoireName = grimoireName;
			tmpGrabbedGrimories[j].spellRank = spellRank;
			tmpGrabbedGrimories[j].levelReqNum = levelReqNum;
			tmpGrabbedGrimories[j].texture = texture;
			tmpGrabbedGrimories[j].price = price;
			tmpGrabbedGrimories[j].serviceType = serviceType;
			tmpGrabbedGrimories[j].petType = petType;
			tmpGrabbedGrimories[j].description = description;
			tmpGrabbedGrimories[j].link = link;
			tmpGrabbedGrimories[j].id = i-numHeaders;
		end
		tmpGrabbedGrimories[j].isExpanded = 1;
		
		i=i+1;
		j=j+1;
	end
	
	
	if(getn(tmpGrabbedGrimories) > 0)then
		sort(tmpGrabbedGrimories,function(a, b) return a.levelReqNum < b.levelReqNum; end );
		for grimoire in tmpGrabbedGrimories do
			tinsert(grabbedGrimories, tmpGrabbedGrimories[grimoire]);
		end
	end
	
	--Scan inventory for grimories
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				for grim in grabbedGrimories do 
					if (GetContainerItemLink(bag,slot) == grabbedGrimories[grim].link) then
						grabbedGrimories[grim].serviceType = "used";
					end
				end
			end
		end
	end
	
	--TrainerSkills stuff (optionelDep)
	if(TrainerSkills)then
		local saveSkills = {};
		local saveSkillsTrainer = {};
		for grim in grabbedGrimories do 
			saveSkills[grim] = {};
			saveSkillsTrainer[grim] = {};
			if(TrainerSkillsVar.grabTooltips == 1 and grabbedGrimories[grim].id) then
				saveSkillsTrainer[grim].toolTipNumLines, saveSkillsTrainer[grim].toolTipLines = TrainerSkills_GetToolTipText("merchant", grabbedGrimories[grim].id);
			end
			saveSkillsTrainer[grim].serviceName = grabbedGrimories[grim].grimoireName; 
			saveSkillsTrainer[grim].serviceSubText = grabbedGrimories[grim].spellRank;
			saveSkillsTrainer[grim].moneyCost = grabbedGrimories[grim].price;
			saveSkillsTrainer[grim].GetTrainerServiceIcon = grabbedGrimories[grim].texture; 
			saveSkillsTrainer[grim].GetTrainerServiceLevelReq = grabbedGrimories[grim].levelReqNum;
			if ( TrainerSkillsVar.grabDescription == 1 ) then
				saveSkillsTrainer[grim].GetTrainerServiceDescription = grabbedGrimories[grim].description;
			end
			saveSkills[grim].serviceType = grabbedGrimories[grim].serviceType;
			saveSkills[grim].isExpanded = 1; 
		end
		
		
		local trainerName, npcNameAndZone = TrainerSkills_GetNpcNameAndZone();
		DemonTrainerFrameDynamicData.TrainerSkillsIndex = TrainerSkills_InitNewTablesAndSaveData(saveSkills, saveSkillsTrainer, numTrainerServices, npcNameAndZone, trainerName, nil);
	end

	--Reset scrollbar
	DemonTrainerFrameListScrollFrameScrollBar:SetMinMaxValues(0, 0); 
	DemonTrainerFrameListScrollFrameScrollBar:SetValue(0);
	
	DemonTrainerFrame_SelectFirstLearnableSkill();
	DemonTrainerFrame_Update();

	if(not pre_UseContainerItem)then
		pre_UseContainerItem = UseContainerItem;
	end
	UseContainerItem = function() DEFAULT_CHAT_FRAME:AddMessage(DEMON_TRAINER_FRAME_USE_DISABLED); end;
	DemonTrainerFrameBuyButton:Enable();
end 

local function allowedByFilter(skillIndex)
	return (grabbedGrimories[skillIndex] and (not DemonTrainerFrameDynamicData.filter[grabbedGrimories[skillIndex].serviceType] or DemonTrainerFrameDynamicData.filter[grabbedGrimories[skillIndex].serviceType] == 1));
end
--Checks weather or not to show the header (if it is a header)
local function doShowHeader(tempSkillIndex)
	local ret = 1;
	local skip = 1;
	local numTrainerServices = getn(grabbedGrimories);
	if ( grabbedGrimories[tempSkillIndex].serviceType == "header") then
		tempSkillIndex = tempSkillIndex + 1;
		while ( tempSkillIndex <= numTrainerServices and skip ) do
			skip = nil;
			if ( not allowedByFilter(tempSkillIndex) ) then
				skip = 1;
				tempSkillIndex = tempSkillIndex + 1;
			end
		end
		if ( tempSkillIndex > numTrainerServices or grabbedGrimories[tempSkillIndex].serviceType == "header" ) then
			ret = nil;
		end
	end
	return ret;
end

local function doShowSkill(skillIndex)
	return (grabbedGrimories[skillIndex] and ( allowedByFilter(skillIndex) and ((grabbedGrimories[skillIndex].serviceType == "header" and doShowHeader(skillIndex)) or (grabbedGrimories[skillIndex].serviceType ~= "header" and grabbedGrimories[skillIndex].isExpanded))));
end

local function getNumTrainerServicesToShow(numTrainerServices)
	local numTrainerServicesToShow = numTrainerServices;
	for i=1, numTrainerServices, 1 do 
		if (not doShowSkill(i))then
			numTrainerServicesToShow = numTrainerServicesToShow-1;
		end
	end
	return numTrainerServicesToShow;
end

local function initialSkip(offset, numTrainerServices)
	local count = 0;
	local i = 0;
	local skip = 0;
	while (i <= numTrainerServices and count <= offset) do
		i = i + 1;
		if (doShowSkill(i)) then
			count = count + 1;
		else
			skip = skip+1;
		end
	end
	return skip;
end



function DemonTrainerFrame_Update()
	SetPortraitTexture(DemonTrainerFramePortrait, "npc");
	
	local skillOffset = FauxScrollFrame_GetOffset(DemonTrainerFrameListScrollFrame);
	
--	DemonTrainerFrameCollapseAllButton:Disable();

	-- If selectedService is nil hide everything
	if ( not DemonTrainerFrame.selectedService ) then
		DemonTrainerFrame_HideSkillDetails();
	else
		DemonTrainerFrame_ShowSkillDetails();
	end

	
	DemonTrainerFrame_SetToDemonTrainerFrame();

	-- ScrollFrame update
	FauxScrollFrame_Update(DemonTrainerFrameListScrollFrame, getNumTrainerServicesToShow(numTrainerServices), CLASS_TRAINER_SKILLS_DISPLAYED, CLASS_TRAINER_SKILL_HEIGHT, nil, nil, nil, DemonTrainerFrameSkillHighlightFrame, 293, 316 )
	
	--DemonTrainerFrameUsedButton:Show();
	DemonTrainerFrameMoneyFrame:Show();
	DemonTrainerFrameSkillHighlightFrame:Hide();
	-- Fill in the skill buttons
	local skip = initialSkip(skillOffset, numTrainerServices);
	local skillIndex;
	for i=1, CLASS_TRAINER_SKILLS_DISPLAYED, 1 do
		skillIndex = i + skillOffset + skip;
		--skillIndex = skillIndex + i;
		
		while (skillIndex <= numTrainerServices and not doShowSkill(skillIndex) ) do 
			skip = skip+1;
			skillIndex = skillIndex + 1;
		end
		
		
		local skillButton = getglobal("DemonTrainerFrameSkill"..i);
		if ( grabbedGrimories[skillIndex] and grabbedGrimories[skillIndex].grimoireName ) then	

			-- Set button widths if scrollbar is shown or hidden
			if ( DemonTrainerFrameListScrollFrame:IsVisible() ) then
				skillButton:SetWidth(293);
			else
				skillButton:SetWidth(323);
			end
			
			-- Type stuff  
			local skillSubText = getglobal("DemonTrainerFrameSkill"..i.."SubText");
			if ( grabbedGrimories[skillIndex].serviceType == "header" ) then
				skillButton:SetText(grabbedGrimories[skillIndex].grimoireName);
				skillButton:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				skillSubText:Hide();
				if ( grabbedGrimories[skillIndex].isExpanded ) then
					skillButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
				else
					skillButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				end
				getglobal("DemonTrainerFrameSkill"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
				skillButton:SetID(skillIndex);
			else
				skillButton:SetNormalTexture("");
				getglobal("DemonTrainerFrameSkill"..i.."Highlight"):SetTexture("");
				skillButton:SetText(grabbedGrimories[skillIndex].grimoireName);
				if ( grabbedGrimories[skillIndex].spellRank and grabbedGrimories[skillIndex].spellRank ~= "" ) then
					skillSubText:SetText(format(TEXT(PARENS_TEMPLATE), grabbedGrimories[skillIndex].spellRank));
					skillSubText:SetPoint("LEFT", "DemonTrainerFrameSkill"..i.."Text", "RIGHT", 10, 0);
					skillSubText:Show();
				else
					skillSubText:Hide();
				end
				
				if ( grabbedGrimories[skillIndex].serviceType == "available" ) then
					skillButton:SetTextColor(0, 1.0, 0);
					DemonTrainerFrame_SetSubTextColor(skillButton, 0, 0.6, 0);
					skillButton.r = 0;
				elseif ( grabbedGrimories[skillIndex].serviceType == "used" ) then
					skillButton:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
					DemonTrainerFrame_SetSubTextColor(skillButton, 0.5, 0.5, 0.5);
				elseif ( grabbedGrimories[skillIndex].serviceType == "maybeUsed" ) then
					skillButton:SetTextColor(1, 1, 0);
					DemonTrainerFrame_SetSubTextColor(skillButton, 1, 1, 0.1);
				else --Unavailable
					skillButton:SetTextColor(0.9, 0, 0);
					DemonTrainerFrame_SetSubTextColor(skillButton, 0.6, 0, 0);
				end
				skillButton:SetID(skillIndex);
			end
			
			skillButton:Show();
			-- Place the highlight and lock the highlight state
			if ( DemonTrainerFrame.selectedService == skillIndex ) then
				DemonTrainerFrameSkillHighlightFrame:SetPoint("TOPLEFT", "DemonTrainerFrameSkill"..i, "TOPLEFT", 0, 0);
				DemonTrainerFrameSkillHighlightFrame:Show();
				skillButton:LockHighlight();
				DemonTrainerFrame_SetSubTextColor(skillButton, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				if ( grabbedGrimories[skillIndex].price and grabbedGrimories[skillIndex].price > 0 ) then
					DemonTrainerFrameCostLabel:Show();
				end
			else
				skillButton:UnlockHighlight();
			end
		else
			skillButton:Hide();
		end
	end
	
	local numHeaders = 0;
	local numUnexpandedHeader = 0;
	for index in grabbedGrimories do 
		if (grabbedGrimories[index].serviceType == "header") then
			numHeaders = numHeaders+1;
			if( not grabbedGrimories[index].isExpanded ) then
				numUnexpandedHeader = numUnexpandedHeader+1;
			end
		end
	end
	
	
	if(numUnexpandedHeader == numHeaders)then
		DemonTrainerFrameCollapseAllButton.collapsed = 1;
		DemonTrainerFrameCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		DemonTrainerFrameCollapseAllButton.collapsed = nil;
		DemonTrainerFrameCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	end
end



function DemonTrainerFrame_SelectFirstLearnableSkill()
	if ( GetMerchantNumItems() > 0 ) then 
		DemonTrainerFrame.showSkillDetails = 1;
		DemonTrainerFrame_SetSelection(2);
		FauxScrollFrame_SetOffset(DemonTrainerFrameListScrollFrame, 0)		
	else
		DemonTrainerFrame.showSkillDetails = nil;
		DemonTrainerFrame_SetSelection();
	end
	DemonTrainerFrameListScrollFrameScrollBar:SetValue(0);
end

local function markCollapsed(skillIndex, value)
	while ( (skillIndex <= getn(grabbedGrimories) ) and (grabbedGrimories[skillIndex].serviceType ~= "header") ) do
		grabbedGrimories[skillIndex].isExpanded = value;
		skillIndex = skillIndex + 1;
	end
end

local function markCollapsedAll(value)
	for skillIndex in grabbedGrimories do 
		grabbedGrimories[skillIndex].isExpanded = value;
	end
end

function DemonTrainerFrame_SetSelection(id)
	-- General Info
	if ( not id ) then
		DemonTrainerFrame_HideSkillDetails();
		return;
	end
	
--[[
	local numHeaders = 0;
	local numUnexpandedHeader = 0;
	if(not grabbedGrimories[id].serviceType == "header") then
		local i = 1;
		while (i <= id) do 
			if (grabbedGrimories[i].serviceType == "header") then
				numHeaders = numHeaders+1;
			end
			i = i+1;
		end
		id = id-numHeaders;
	end
]]
	
	DemonTrainerFrameSkillHighlightFrame:Show();
	if ( grabbedGrimories[id].serviceType == "available" ) then
		DemonTrainerFrameSkillHighlight:SetVertexColor(0, 1.0, 0);
	elseif ( grabbedGrimories[id].serviceType == "used" ) then
		DemonTrainerFrameSkillHighlight:SetVertexColor(0.5, 0.5, 0.5);
	elseif ( grabbedGrimories[id].serviceType == "unavailable" ) then
		DemonTrainerFrameSkillHighlight:SetVertexColor(0.9, 0, 0);
	elseif (grabbedGrimories[id].serviceType == "maybeUsed" ) then
		DemonTrainerFrameSkillHighlight:SetVertexColor(1, 1, 0);
	else --Header
		DemonTrainerFrameSkillHighlightFrame:Hide();
		if(grabbedGrimories[id].isExpanded)then
			grabbedGrimories[id].isExpanded = nil;
			markCollapsed(id+1, nil);
		else
			grabbedGrimories[id].isExpanded = 1;
			markCollapsed(id+1, 1);
		end
		DemonTrainerFrame_Update();
		return; 
	end

	if ( DemonTrainerFrame.showSkillDetails ) then
		DemonTrainerFrame_ShowSkillDetails();
	else
		DemonTrainerFrame_HideSkillDetails();
		return;
	end

	if(grabbedGrimories[id].grimoireName)then
		DemonTrainerFrameSkillName:SetText(grabbedGrimories[id].grimoireName);
	end	
	
	if ( not grabbedGrimories[id].spellRank ) then
		grabbedGrimories[id].spellRank = ""; 
	end
	DemonTrainerFrameSubSkillName:SetText(format(TEXT(PARENS_TEMPLATE), grabbedGrimories[id].spellRank));
	DemonTrainerFrame.selectedService = id; 
	DemonTrainerFrameSkillIcon:SetNormalTexture(grabbedGrimories[id].texture);
	-- Build up the requirements string
	local requirements = "";
	-- Level Requirements
	local separator = "";
	if ( grabbedGrimories[id].levelReqNum and grabbedGrimories[id].levelReqNum > 1 ) then
		separator = ", ";
		if ( UnitLevel("player") >= grabbedGrimories[id].levelReqNum ) then
			requirements = requirements..format(TEXT(TRAINER_REQ_LEVEL), grabbedGrimories[id].levelReqNum);
		else
			requirements = requirements..format(TEXT(TRAINER_REQ_LEVEL_RED), grabbedGrimories[id].levelReqNum);
		end
	end
	
	if ( requirements ~= "" ) then
		DemonTrainerFrameSkillRequirements:SetText(REQUIRES_LABEL.." "..requirements);
	else
		DemonTrainerFrameSkillRequirements:SetText("");
	end

	-- Money Frame and cost
	local unavailable = nil;
	if ( grabbedGrimories[id].price and grabbedGrimories[id].price == 0 ) then
		DemonTrainerFrameDetailMoneyFrame:Hide();
		DemonTrainerFrameCostLabel:Hide();
		DemonTrainerFrameSkillDescription:SetPoint("TOPLEFT", "DemonTrainerFrameCostLabel", "TOPLEFT", 0, 0);
	elseif(grabbedGrimories[id].price)then
		DemonTrainerFrameDetailMoneyFrame:Show();
		DemonTrainerFrameCostLabel:Show();
		DemonTrainerFrameSkillDescription:SetPoint("TOPLEFT", "DemonTrainerFrameCostLabel", "BOTTOMLEFT", 0, -10);
		if ( GetMoney() >= grabbedGrimories[id].price ) then
			SetMoneyFrameColor("DemonTrainerFrameDetailMoneyFrame", 1.0, 1.0, 1.0);
		else
			SetMoneyFrameColor("DemonTrainerFrameDetailMoneyFrame", 1.0, 0.1, 0.1);
			unavailable = 1;
		end
	end
	
	if(grabbedGrimories[id].price)then
		MoneyFrame_Update("DemonTrainerFrameDetailMoneyFrame", grabbedGrimories[id].price);
	end
	
	if ( ((grabbedGrimories[id].serviceType == "available" or grabbedGrimories[id].serviceType == "maybeUsed") and not unavailable) or DemonTrainerFrameDynamicData.buy ) then
		DemonTrainerFrameBuyButton:Enable();
	else
		DemonTrainerFrameBuyButton:Disable();
	end
	
	if(grabbedGrimories[id].description)then
		if (grabbedGrimories[id].serviceType == "maybeUsed" ) then
			DemonTrainerFrameSkillDescription:SetText(grabbedGrimories[id].description.."\n\n"..DEMON_TRAINER_FRAME_YELLOW_FONT_COLOR_CODE..DEMON_TRAINER_FRAME_MAYBE_USED_DESCRIPTION..DEMON_TRAINER_FRAME_FONT_COLOR_CODE_CLOSE);
		else
			DemonTrainerFrameSkillDescription:SetText(grabbedGrimories[id].description);
		end
	end
	
	DemonTrainerFrameSkillName:SetText(DemonTrainerFrameSkillName:GetText().." "..TEXT(TRAINER_PET_SPELL_LABEL));

	DemonTrainerFrameDetailScrollFrame:UpdateScrollChildRect();
end

function DemonTrainerFrameSkillButton_OnClick(button)
	if ( button == "LeftButton" ) then
		--DemonTrainerFrame.selectedService = this:GetID();
		DemonTrainerFrame.showSkillDetails = 1;
		DemonTrainerFrame_SetSelection(this:GetID());
		DemonTrainerFrame_Update();
	end
end

function DemonTrainerFrame_getSelectedService()
--	local numHeaders = 0;
--	local i = 1;
--	while (i <= DemonTrainerFrame.selectedService) do 
--		if (grabbedGrimories[i].serviceType == "header") then
--			numHeaders = numHeaders+1;
--		end
--		i = i+1;
--	end
--	return DemonTrainerFrame.selectedService-numHeaders;
	return grabbedGrimories[DemonTrainerFrame.selectedService].id;
end

function DemonTrainerFrameBuyButton_OnClick()
	BuyMerchantItem(DemonTrainerFrame_getSelectedService());
--	grabbedGrimories[DemonTrainerFrame.selectedService].serviceType = "used";
--	DemonTrainerFrame_SelectFirstLearnableSkill();
--	DemonTrainerFrame_Update();
end

function DemonTrainerFrame_SetSubTextColor(button, r, g, b)
	button.r = r;
	button.g = g;
	button.b = b;
	getglobal(button:GetName().."SubText"):SetTextColor(r, g, b);
end

function DemonTrainerFrameCollapseAllButton_OnClick()
	if (this.collapsed) then
		this.collapsed = nil;
		markCollapsedAll(1);
		DemonTrainerFrame_Update();
	else
		this.collapsed = 1;
		DemonTrainerFrameListScrollFrameScrollBar:SetValue(0);
		markCollapsedAll(nil);
		DemonTrainerFrame_Update();
	end
end

function DemonTrainerFrame_HideSkillDetails()
	DemonTrainerFrameSkillName:Hide();
	DemonTrainerFrameSkillIcon:Hide();
	DemonTrainerFrameSkillRequirements:Hide();
	DemonTrainerFrameSkillDescription:Hide();
	DemonTrainerFrameDetailMoneyFrame:Hide();
	DemonTrainerFrameCostLabel:Hide();
end

function DemonTrainerFrame_ShowSkillDetails()
	DemonTrainerFrameSkillName:Show();
	DemonTrainerFrameSkillIcon:Show();
	DemonTrainerFrameSkillRequirements:Show();
	DemonTrainerFrameSkillDescription:Show();
	DemonTrainerFrameDetailMoneyFrame:Show();
	--DemonTrainerFrameCostLabel:Show();
end

function DemonTrainerFrame_SetToDemonTrainerFrame()
	CLASS_TRAINER_SKILLS_DISPLAYED = 11;
	DemonTrainerFrameListScrollFrame:SetHeight(184);
	DemonTrainerFrameDetailScrollFrame:SetHeight(119);
	DemonTrainerFrameHorizontalBarLeft:SetPoint("TOPLEFT", "DemonTrainerFrame", "TOPLEFT", 15, -275);
end

-- Dropdown functions
function DemonTrainerFrameFilterDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, DemonTrainerFrameFilterDropDown_Initialize);
	UIDropDownMenu_SetText(FILTER, this);
	UIDropDownMenu_SetWidth(130, DemonTrainerFrameFilterDropDown);
end

function DemonTrainerFrameFilterDropDown_Initialize()
	-- Available button
	local info = {};
	local checked = nil;
	if ( DemonTrainerFrameDynamicData and DemonTrainerFrameDynamicData.filter.available == 1 ) then
		checked = 1;
	end
	info.text = GREEN_FONT_COLOR_CODE..AVAILABLE..FONT_COLOR_CODE_CLOSE;
	info.value = "available";
	info.func = DemonTrainerFrameFilterDropDown_OnClick;
	info.checked = checked;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);

	-- Unavailable button
	info = {};
	checked = nil;
	if ( DemonTrainerFrameDynamicData and  DemonTrainerFrameDynamicData.filter.unavailable == 1 ) then
		checked = 1;
	end
	info.text = RED_FONT_COLOR_CODE..UNAVAILABLE..FONT_COLOR_CODE_CLOSE;
	info.value = "unavailable";
	info.func = DemonTrainerFrameFilterDropDown_OnClick;
	info.checked = checked;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);

	-- Unavailable button
	info = {};
	checked = nil;
	if ( DemonTrainerFrameDynamicData and  DemonTrainerFrameDynamicData.filter.used == 1 ) then
		checked = 1;
	end
	info.text = GRAY_FONT_COLOR_CODE..USED..FONT_COLOR_CODE_CLOSE;
	info.value = "used";
	info.func = DemonTrainerFrameFilterDropDown_OnClick;
	info.checked = checked;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
end

function DemonTrainerFrameFilterDropDown_OnClick()
	if ( UIDropDownMenuButton_GetChecked() ) then
		DemonTrainerFrameDynamicData.filter[this.value] = 0;
	else
		DemonTrainerFrameDynamicData.filter[this.value] = 1;
	end
	DemonTrainerFrameListScrollFrameScrollBar:SetValue(0);
	DemonTrainerFrame_Update();
end