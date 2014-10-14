-- Pour le bon fonctionnement de l'addon, merci de ne pas modifier le code
-- Sharas, le 25 aout 2006 - http://worldofwarcraft.judgehype.com

local JHC_CurrentAction = "";
local JHC_CurrentQuestCompleted = "";
local JHC_CurrentQuestCompletedTimer = 0;
local JHC_CurrentQuestFinished = "";
local JHC_CurrentQuestFinishedObj = "";
local JHC_CurrentQuestFinishedTimer = 0;
local JHC_CurrentXpGain = "";
local JHC_CurrentXpGainTimer = 0;
local JHC_CurrentLockChanged = "";
local JHC_CurrentLockChangedTimer = 0;
local JHC_LastEvent = "";
local JHC_TotQuestLogUpdate = 0;
local JHC_MaxQuestLogUpdate = 3;
local JHC_LastSellValue = 0;
local JHC_DoneInit = 0;

function JHC_Init()
	JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	if (not JH_Main.ServeurList["cser_"..GetCVar("realmName")]) then
		JH_Main.ServeurList["cser_"..GetCVar("realmName")] = GetCVar("realmName");
	end
	if (JHC_DoneInit == 0) then
		JHC_OnTooltipAddMoneySaved = JH_CollectorTooltip:GetScript("OnTooltipAddMoney");
		JH_CollectorTooltip:SetScript("OnTooltipAddMoney", JHC_OnTooltipAddMoney);
	end
	if (JH_Main and JHC_DoneInit==0) then
		if (not JH_Main.Calerte) then
			JH_Main.Calerte=0;
		else
			if (JH_Main.Calerte==1 and JH_Main.Collector==1) then
				JHPurge_CollectorFrame:Show();
			end
		end
	end
	JHC_DoneInit = 1;
end

function JHC_OnLoad()
	if not (GetLocale()=="frFR") then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Collector d\195\169sactiv\195\169 en raison du client utilis\195\169.");
		return;
	end
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	
	JHPurge_MainTitreText:SetText("Addon JudgeHype Version 1b");
	JHPurge_MainIntroText:SetText("Nous vous recommandons de remettre à z\195\169ro les donn\195\169es du |cffffffffCollector|r apr\195\168s un envoi au r\195\169seau JudgeHype.|nSouhaitez-vous purger les donn\195\169es maintenant ?");
end

function JHC_OnEvent(event,arg1,arg2)
	-- JHC_AnalyseEvent();
	if (JH_Main.Collector==0) then
		return;
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		this:RegisterEvent("MERCHANT_SHOW");
		this:RegisterEvent("MERCHANT_UPDATE");
		this:RegisterEvent("TRAINER_SHOW");
		this:RegisterEvent("TRAINER_UPDATE");
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
		this:RegisterEvent("LOOT_OPENED");
		this:RegisterEvent("TRADE_SKILL_SHOW");
		this:RegisterEvent("TRADE_SKILL_UPDATE");
		this:RegisterEvent("QUEST_DETAIL");
		this:RegisterEvent("QUEST_LOG_UPDATE");
		this:RegisterEvent("QUEST_PROGRESS");
		this:RegisterEvent("QUEST_COMPLETE");
		this:RegisterEvent("QUEST_FINISHED");
		this:RegisterEvent("GOSSIP_SHOW");
		this:RegisterEvent("BANKFRAME_OPENED");
		this:RegisterEvent("AUCTION_HOUSE_SHOW");
		this:RegisterEvent("PET_STABLE_SHOW");
		this:RegisterEvent("TAXIMAP_OPENED");
		this:RegisterEvent("ITEM_LOCK_CHANGED");
	end
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("MERCHANT_SHOW");
		this:UnregisterEvent("MERCHANT_UPDATE");
		this:UnregisterEvent("TRAINER_SHOW");
		this:UnregisterEvent("TRAINER_UPDATE");
		this:UnregisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
		this:UnregisterEvent("LOOT_OPENED");
		this:UnregisterEvent("TRADE_SKILL_SHOW");
		this:UnregisterEvent("TRADE_SKILL_UPDATE");
		this:UnregisterEvent("QUEST_DETAIL");
		this:UnregisterEvent("QUEST_LOG_UPDATE");
		this:UnregisterEvent("QUEST_PROGRESS");
		this:UnregisterEvent("QUEST_COMPLETE");
		this:UnregisterEvent("QUEST_FINISHED");
		this:UnregisterEvent("GOSSIP_SHOW");
		this:UnregisterEvent("BANKFRAME_OPENED");
		this:UnregisterEvent("AUCTION_HOUSE_SHOW");
		this:UnregisterEvent("PET_STABLE_SHOW");
		this:UnregisterEvent("TAXIMAP_OPENED");
		this:UnregisterEvent("ITEM_LOCK_CHANGED");
	end
	if (event == "MERCHANT_SHOW" or event == "MERCHANT_UPDATE") then
		JHC_Shop();
		if (event == "MERCHANT_SHOW") then
			JHC_ShopSell();
		end
	end
	if (event == "TRAINER_SHOW") then
		JHC_Trainer();
	end
	if (event == "TRAINER_UPDATE") then
		-- JHC_Trainer();
	end
	if (event == "CHAT_MSG_COMBAT_XP_GAIN") then
		JHC_MemXpGain(arg1);
	end
	if (event == "LOOT_OPENED") then
		JHC_Loot();
	end
	if (event == "TRADE_SKILL_SHOW") then
		if (JH_Main.CollectorMetier == 1) then
			JHC_Tradeskill();
		end
	end
	if (event == "TRADE_SKILL_UPDATE") then
		if (JH_Main.CollectorMetier == 1) then
			-- JHC_Tradeskill();
		end
	end
	if (event == "QUEST_DETAIL") then
		JHC_QuestDetail();
	end
	if (event == "QUEST_LOG_UPDATE") then
		if (JHC_MaxQuestLogUpdate > JHC_TotQuestLogUpdate) then
			JHC_QuestUpdate();
		end
	end
	if (event == "QUEST_PROGRESS") then
		JHC_QuestUpdate();
		JHC_QuestProgress();
	end
	if (event == "QUEST_COMPLETE") then
		JHC_QuestComplete(arg1);
	end
	if (event == "QUEST_FINISHED") then
		JHC_QuestFinished(arg1);
	end
	if (event == "GOSSIP_SHOW" or event == "BANKFRAME_OPENED" or event == "AUCTION_HOUSE_SHOW" or event == "PET_STABLE_SHOW" or event == "TAXIMAP_OPENED") then
		JHC_CheckPnj();
	end
	if (event == "ITEM_LOCK_CHANGED") then
		JHC_LockChanged(arg1);
	end
	if (JHO_CollectorFrame:IsVisible()) then
		JHO_UpdateCollector();
	end
	if (JHC_LastEvent == event) then
		JHC_TotQuestLogUpdate = JHC_TotQuestLogUpdate + 1;
	else
		JHC_TotQuestLogUpdate = 0;
	end
	JHC_LastEvent = event;
end

function JHC_OnTooltipAddMoney()
	JHC_OnTooltipAddMoneySaved();
    if (InRepairMode()) then
		return;
	end
	if (tonumber(arg1) > 0) then
		JHC_LastSellValue = arg1;
	end
end

function JHC_LockChanged(towork)
	if (towork == "RightButton") then
		JHtextLeft = getglobal("GameTooltipTextLeft1");
		if (JHtextLeft:GetText()) then
			JHtextL = JHtextLeft:GetText();
			local Report;
			local IsInBag = 0;
			for bagNum = 0, 4 do
				local bagname = GetBagName(bagNum);
				local bagNum_Slots = GetContainerNumSlots(bagNum);
				if (bagname) then
					for bagItem = 1, bagNum_Slots do
						local BagitemLink = GetContainerItemLink(bagNum, bagItem);
						if (BagitemLink) then
							for _, _, _, name in string.gfind(BagitemLink, "|c(%x+)|Hitem:((%d+):%d+:%d+:%d+)|h%[(.-)%]|h|r") do
								if (name == JHtextL) then
									IsInBag = 1;
									Report = JHC_ProcessItem(BagitemLink);
								end
							end
						end
					end
				end
			end
			if (IsInBag == 1) then
				JHC_CurrentLockChanged = Report;
				JHC_CurrentLockChangedTimer = GetTime();
			end
		end
	end
	if (towork ~= "RightButton" and towork ~= "LeftButton") then
		for bagNum = 0, 4 do
			local bagname = GetBagName(bagNum);
			local bagNum_Slots = GetContainerNumSlots(bagNum);
			if (bagname) then
				for bagItem = 1, bagNum_Slots do
					local BagitemLink = GetContainerItemLink(bagNum, bagItem);
					if ( BagitemLink ) then
						JHC_ProcessItem(BagitemLink);
					end
				end
			end
		end
	end
end

function JHC_Loot()
	local JHnombreloot = GetNumLootItems();
	local Source = nil;
	local Cible = nil;
	local ct,rz,sz,cx,cy,mx,my = JHC_GetInfoLoc();
	if (UnitIsPlayer("target") or UnitPlayerControlled("target")) then
		return;
	end
	if (IsFishingLoot()) then
		Source = "fishing";
		Cible = "fish_"..rz.."_"..sz;
		if (not JH_Collector.fishing[Cible]) then
			JH_Collector[Source][Cible] = {};
			JH_Collector[Source][Cible]["floc"] = {};
			JH_Collector[Source][Cible].fishcompte = 1;
			JH_Collector[Source][Cible].fishrz = rz;
			JH_Collector[Source][Cible].fishsz = sz;
		else
			local CurrentCount = JH_Collector[Source][Cible].fishcompte +1;
			JH_Collector[Source][Cible].fishcompte = CurrentCount;
		end
		if (not JH_Collector[Source][Cible]["floc"]["floc_"..mx..":"..my]) then
			JH_Collector[Source][Cible]["floc"]["floc_"..mx..":"..my] = "1".."||"..ct.."||"..rz.."||"..sz.."||"..cx..":"..cy.."||"..mx..":"..my;
			JH_Main.cc.locs = JH_Main.cc.locs + 1;
			JH_Main.ccn.locs = rz.." "..mx..":"..my;
		else
			local a,b;
			for a, b in string.gfind(JH_Collector[Source][Cible]["floc"]["floc_"..mx..":"..my], "(%d+)||(.*)") do
				a = tonumber(a)+1;
				local newstring = a.."||"..b;
				JH_Collector[Source][Cible]["floc"]["floc_"..mx..":"..my] = newstring;
			end
		end
	end
	if (UnitIsDead("target") and Source == nil) then
		if (not CheckInteractDistance("target", 1)) then
			return;
		end
		local monstre = JHC_Clean(UnitName("target"));
		Source = "monstres";
		Cible = "mob_"..monstre;
		local family = JHC_Clean(UnitCreatureFamily("target"));
		local type = JHC_Clean(UnitCreatureType("target"));
		local classification = JHC_Clean(UnitClassification("target"));
		if (family == "") then family = "none"; end
		if (type == "") then type = "none"; end
		if (classification == "") then classification = "none"; end
		local iselite = 0;
		if (UnitIsPlusMob("target")) then iselite = 1; end
		if ( not JH_Collector[Source][Cible]) then
			JH_Collector[Source][Cible] = {};
			JH_Collector[Source][Cible].mobnom = monstre;
			JH_Collector[Source][Cible].moblvl = UnitLevel("target").."||"..UnitLevel("target");
			JH_Collector[Source][Cible].mobsort = iselite.."||"..classification;
			JH_Collector[Source][Cible].mobtype = type.."||"..family;
			JH_Collector[Source][Cible].mobcompte = 1;
			JH_Collector[Source][Cible].sous = "0||0";
			JH_Collector[Source][Cible].mobloc = {};
			JH_Collector[Source][Cible].mobloc["mobloc_"..rz.."_"..mx..":"..my] = "1".."||"..ct.."||"..rz.."||"..sz.."||"..cx..":"..cy.."||"..mx..":"..my;
			JH_Main.cc.monstres = JH_Main.cc.monstres + 1;
			JH_Main.ccn.monstres = UnitName("target");
			JH_Main.cc.locs = JH_Main.cc.locs + 1;
			JH_Main.ccn.locs = rz.." "..mx..":"..my;
		else
			local a,b;
			for a, b in string.gfind(JH_Collector[Source][Cible].moblvl, "(%d+)||(%d+)") do
				if (tonumber(b)<UnitLevel("target")) then b = UnitLevel("target"); end
				if (tonumber(a)>UnitLevel("target")) then a = UnitLevel("target"); end
				local newstring = a.."||"..b;
				JH_Collector[Source][Cible].moblvl = newstring;
			end
			if (not JH_Collector[Source][Cible].mobloc["mobloc_"..rz.."_"..mx..":"..my]) then
				JH_Collector[Source][Cible].mobloc["mobloc_"..rz.."_"..mx..":"..my] = "1".."||"..ct.."||"..rz.."||"..sz.."||"..cx..":"..cy.."||"..mx..":"..my;
				JH_Main.cc.locs = JH_Main.cc.locs + 1;
				JH_Main.ccn.locs = rz.." "..mx..":"..my;
			else
				local a,b;
				for a, b in string.gfind(JH_Collector[Source][Cible].mobloc["mobloc_"..rz.."_"..mx..":"..my], "(%d+)||(.*)") do
					a = tonumber(a)+1;
					local newstring = a.."||"..b;
					JH_Collector[Source][Cible].mobloc["mobloc_"..rz.."_"..mx..":"..my] = newstring;
				end
			end
			local CurrentCount = JH_Collector[Source][Cible].mobcompte +1;
			JH_Collector[Source][Cible].mobcompte = CurrentCount;
		end
	end
	if (not UnitIsDead("target") and Source == nil) then
		if ((JHC_CurrentLockChangedTimer+0.5) > GetTime() and JHC_CurrentLockChanged ~= "") then
			Source = "foundin";
			Cible = "foundin_"..JHC_CurrentLockChanged;
			if (not JH_Collector[Source][Cible]) then
				JH_Collector[Source][Cible] = {};
				JH_Collector[Source][Cible].sous = "0||0";
				JH_Collector[Source][Cible].foundincompte = 1;
				JH_Collector[Source][Cible].foundininfo = JHC_CurrentLockChanged;
			else
				local CurrentCount = JH_Collector[Source][Cible].foundincompte +1;
				JH_Collector[Source][Cible].foundincompte = CurrentCount;
			end
		end
	end
	if (Source == nil) then
		return;
	end
	for i=1, JHnombreloot, 1 do
		if ( LootSlotIsCoin(i) ) then
			local totalsous = 0;
			local texture, item, _, _ = GetLootSlotInfo(i);
			local _,_,cuivreloot = string.find(item,"(%d+) Cuivre");
			if (cuivreloot) then totalsous = totalsous+cuivreloot; end
			local _,_,argentloot = string.find(item,"(%d+) Argent");
			if (argentloot) then totalsous = totalsous+(argentloot*100); end
			local _,_,orloot = string.find(item,"(%d+) Or");
			if (orloot) then totalsous = totalsous+(orloot*10000); end
			if (Source and Cible) then
				if (JH_Collector[Source][Cible].sous == "0||0") then
					JH_Collector[Source][Cible].sous = totalsous.."||"..totalsous;
				else
					local a,b;
					for a, b in string.gfind(JH_Collector[Source][Cible].sous, "(%d+)||(%d+)") do
						if (tonumber(b)<totalsous) then b = totalsous; end
						if (tonumber(a)>totalsous) then a = totalsous; end
						local newstring = a.."||"..b;
						JH_Collector[Source][Cible].sous = newstring;
					end
				end
			end
		end
		if ( LootSlotIsItem(i) ) then
			local texture, item, quantity, quality = GetLootSlotInfo(i);
			local link = GetLootSlotLink(i);
			if (link) then
				local Report = JHC_ProcessItem(link);
				if (Source and Cible) then
					if (not JH_Collector[Source][Cible]["droplist"]) then
						JH_Collector[Source][Cible]["droplist"] = {}
					end
					if (not JH_Collector[Source][Cible]["droplist"]["drop_"..Report]) then
						JH_Collector[Source][Cible]["droplist"]["drop_"..Report] = "1||"..quantity.."||"..quantity.."||"..Report;
					else
						local a,b,c,d,e;
						for a, b, c, d, e in string.gfind(JH_Collector[Source][Cible]["droplist"]["drop_"..Report], "(%d+)||(%d+)||(%d+)||(%d+):(%d+)") do
							a = tonumber(a)+1;
							if (quantity < tonumber(b)) then b = quantity; end
							if (quantity > tonumber(c)) then c = quantity; end
							local newstring = a.."||"..b.."||"..c.."||"..d..":"..e;
							JH_Collector[Source][Cible]["droplist"]["drop_"..Report] = newstring;
						end
					end
				end
			end
		end
	end
end

function JHC_Trainer()
	SetTrainerServiceTypeFilter("available",1);
	SetTrainerServiceTypeFilter("unavailable",1);
	SetTrainerServiceTypeFilter("used",1);
	
	local IsFullUpdate = 1;
	local JHC_TrainerName, JHC_TrainerZone = JHcollector_Pnj();
	local CurrentTrainer = "trainer_"..JHC_TrainerName.."_"..JHC_TrainerZone;
	local JHC_Greeting = GetTrainerGreetingText();
	local JHC_IsClassTrainer = nil;
	local PlayedClass = { "chaman","chasseur","d\195\169moniste","druide","guerrier","mage","paladin","pr\195\170tre","voleur" };
	for i, value in PlayedClass do
		if (string.find(JHC_Greeting,PlayedClass[i])) then
			JHC_IsClassTrainer = PlayedClass[i];
		end
	end
	local JHC_IsTSTrainer = nil;
	if (IsTradeskillTrainer()) then
		for i=1, GetNumTrainerServices(), 1 do
			SelectTrainerService(i);
			local CTskill = nil;
			local CTskill,_,_ = GetTrainerServiceSkillReq(i);
			if (CTskill) then
				if (not JHC_IsTSTrainer) then
					JHC_IsTSTrainer = JHC_Clean(CTskill);
				end
			end
		end
	end
	local JHC_IsOtherTrainer = nil;
	if (JHC_IsClassTrainer == nil and JHC_IsTSTrainer == nil) then
		JHC_IsOtherTrainer = "Autre";
	end
	local JHC_CurrentType;
	
	if (JHC_IsClassTrainer == nil and JHC_IsTSTrainer == nil and JHC_IsOtherTrainer == nil) then
		return;
	end
	if (not JH_Collector.trainers[CurrentTrainer]) then
		JH_Collector.trainers[CurrentTrainer] = {};
	end
	local CurrentHeader = "";
	for i=1, GetNumTrainerServices(), 1 do
		SelectTrainerService(i);
		local serviceName, serviceRank, serviceType,_ = GetTrainerServiceInfo(i);
		if (serviceType == "header") then
			CurrentHeader = JHC_Clean(serviceName);
		else
			serviceName = JHC_Clean(serviceName);
			
			if (JHC_IsClassTrainer) then
				local reqabi = "noabireq";
				local numRequirements = GetTrainerServiceNumAbilityReq(i);
				if (numRequirements > 0) then
					for j=1, numRequirements, 1 do
						local ReqAbility,_ = GetTrainerServiceAbilityReq(i, j);
						if (ReqAbility) then
							if (reqabi == "noabireq") then
								reqabi = JHC_Clean(ReqAbility);
							else
								reqabi = reqabi.."_"..JHC_Clean(ReqAbility);
							end
						end
					end
				end
				local reqlvl = GetTrainerServiceLevelReq(i);
				local lerank = JHC_Clean(serviceRank);
				if (lerank == "") then lerank = "norank"; end
				local moneyCost,_,_ = GetTrainerServiceCost(i);
				if (not JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]) then
					JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank] = {};
					JH_Main.cc.trainers = JH_Main.cc.trainers + 1;
					JH_Main.ccn.trainers = serviceName;
				end
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["tnom"] = CurrentHeader.."||"..serviceName.."||"..lerank;
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["treq"] = reqabi.."||noskillreq||nostepreq||lvl:"..reqlvl.."||money:"..moneyCost;
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["tdescription"] = JHC_Clean(GetTrainerServiceDescription(i));
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["ticone"] = GetTrainerServiceIcon(i);
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["twhat"] = JHC_IsClassTrainer.."||"..JHC_TrainerName;
				JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
				JH_CollectorTooltip:SetTrainerService(i);
				local CurrentTtip = JHC_GetTooltip();
				CurrentTtip = string.gsub(CurrentTtip, "|cffff2020", "");
				CurrentTtip = string.gsub(CurrentTtip, "|r", "");
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["ttip"] = CurrentTtip;
				if (CurrentTtip == "") then IsFullUpdate=0; end
			end
			if (JHC_IsTSTrainer) then
				local reqskill,reqstep;
				local skill,rank,_ = GetTrainerServiceSkillReq(i);
				if (skill) then
					reqskill = JHC_Clean(skill)..":"..rank;
				else
					reqskill = "noskillreq";
				end
				local step,_ = GetTrainerServiceStepReq(i);
				if (step) then
					reqstep = JHC_Clean(step);
				else
					reqstep = "nostepreq";
				end
				local reqlvl = GetTrainerServiceLevelReq(i);
				local moneyCost,_,_ = GetTrainerServiceCost(i);
				if (not JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName]) then
					JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName] = {};
					JH_Main.cc.trainers = JH_Main.cc.trainers + 1;
					JH_Main.ccn.trainers = serviceName;
				end
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName]["tnom"] = CurrentHeader.."||"..serviceName.."||norank";
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName]["treq"] = "noabireq||"..reqskill.."||"..reqstep.."||lvl:"..reqlvl.."||money:"..moneyCost;
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName]["tdescription"] = JHC_Clean(GetTrainerServiceDescription(i));
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName]["ticone"] = GetTrainerServiceIcon(i);
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName]["twhat"] = JHC_IsTSTrainer.."||"..JHC_TrainerName;
				JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
				JH_CollectorTooltip:SetTrainerService(i);
				local CurrentTtip = JHC_GetTooltip();
				CurrentTtip = string.gsub(CurrentTtip, "|cffff2020", "");
				CurrentTtip = string.gsub(CurrentTtip, "|r", "");
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName]["ttip"] = CurrentTtip;
				if (CurrentTtip == "") then IsFullUpdate=0; end
			end
			if (JHC_IsOtherTrainer) then
				local reqlvl = GetTrainerServiceLevelReq(i);
				local lerank = JHC_Clean(serviceRank);
				if (lerank == "") then lerank = "norank"; end
				local moneyCost,_,_ = GetTrainerServiceCost(i);
				if (not JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]) then
					JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank] = {};
					JH_Main.cc.trainers = JH_Main.cc.trainers + 1;
					JH_Main.ccn.trainers = serviceName;
				end
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["tnom"] = CurrentHeader.."||"..serviceName.."||"..lerank;
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["treq"] = "noabireq||noskillreq||nostepreq||lvl:"..reqlvl.."||money:"..moneyCost;
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["tdescription"] = JHC_Clean(GetTrainerServiceDescription(i));
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["ticone"] = GetTrainerServiceIcon(i);
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["twhat"] = JHC_IsOtherTrainer.."||"..JHC_TrainerName;
				JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
				JH_CollectorTooltip:SetTrainerService(i);
				local CurrentTtip = JHC_GetTooltip();
				CurrentTtip = string.gsub(CurrentTtip, "|cffff2020", "");
				CurrentTtip = string.gsub(CurrentTtip, "|r", "");
				JH_Collector.trainers[CurrentTrainer]["tlist_"..serviceName.."_"..lerank]["ttip"] = CurrentTtip;
				if (CurrentTtip == "") then IsFullUpdate=0; end
			end
		end
	end
	SetTrainerServiceTypeFilter("available",1);
	SetTrainerServiceTypeFilter("unavailable",1);
	SetTrainerServiceTypeFilter("used",0);
	if (IsFullUpdate==0) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Sauvegarde du PnJ incompl\195\168te, merci de fermer et d'ouvrir la fen\195\170tre de nouveau.");
	end
end

function JHC_QuestDetail()
	if (UnitIsPlayer("npc")) then
		return;
	end
	local JHcp = JHC_Clean(UnitName("player")).."_"..JHC_Clean(GetCVar("realmName"));
	local JHsource = UnitReaction("npc","player");
	local JHC_Target, JHC_Source, JHC_SourceLoc;
	if (JHsource == nil) then
		local Report;
		local IsInBag = 0;
		JHC_Target = UnitName("npc");
		for bagNum = 0, 4 do
			local bagname = GetBagName(bagNum);
			local bagNum_Slots = GetContainerNumSlots(bagNum);
			if (bagname) then
				for bagItem = 1, bagNum_Slots do
					local BagitemLink = GetContainerItemLink(bagNum, bagItem);
					if ( BagitemLink ) then
						for _, _, _, name in string.gfind(BagitemLink, "|c(%x+)|Hitem:((%d+):%d+:%d+:%d+)|h%[(.-)%]|h|r") do
							if (name == JHC_Target) then
								IsInBag = 1;
								Report = JHC_ProcessItem(BagitemLink);
							end
						end
					end
				end
			end
		end
		if (IsInBag == 1) then
			JHC_Source = "objetbag||"..Report.."||nozone";
		else
			local ct,rz,sz,cx,cy,mx,my = JHC_GetInfoLoc();
			JHC_Source = "objetworld||"..JHC_Clean(UnitName("npc")).."||"..rz;
			JHC_SourceLoc = "1||"..ct.."||"..rz.."||"..sz.."||"..cx..":"..cy.."||"..mx..":"..my;
		end
	else
		local _,startzone = JHcollector_Pnj();
		JHC_Source = "pnj||"..JHC_Clean(UnitName("npc")).."||"..startzone;
	end
	
	local QuestTitre = JHC_Clean(JHC_CleanLevel(GetTitleText()));
	local QuestTexte = JHC_Clean(JHC_CleanQuete(GetQuestText()));
	local QuestObj = JHC_Clean(JHC_CleanQuete(GetObjectiveText()));
	local spellTexture, spellName = GetRewardSpell(); 

	local Pos = 0;
	local CompareNom,CompareObjectif;
	local NumEntry = getn(JH_Collector.quetes);
	for i=1, NumEntry, 1 do
		CompareNom = "";
		CompareObjectif = "";
		if (JH_Collector.quetes[i]["newquete_"..JHcp]) then
			CompareNom = JH_Collector.quetes[i]["newquete_"..JHcp]["qtnom"];
		end
		if (JH_Collector.quetes[i]["newquete_"..JHcp]) then
			CompareObjectif = JH_Collector.quetes[i]["newquete_"..JHcp]["qtobjectif"];
		end
		if (QuestTitre == CompareNom and QuestObj == CompareObjectif) then
			Pos = i;
		end
	end
	if (Pos == 0) then
		Pos = NumEntry+1;
		table.insert(JH_Collector.quetes, Pos);
		JH_Collector.quetes[Pos] = {};
		JH_Collector.quetes[Pos]["newquete_"..JHcp] = {};
		JH_Main.cc.quetes = JH_Main.cc.quetes + 1;
		JH_Main.ccn.quetes = JHC_CleanLevel(GetTitleText());
	end
		
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtnom"] = QuestTitre;
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtobjectif"] = QuestObj;
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtdescription"] = QuestTexte;
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtsource"] = JHC_Source;
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtfaction"] = UnitFactionGroup("player");
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtgmoney"] = GetQuestMoneyToGet();
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrmoney"] = UnitLevel("player").."||"..GetRewardMoney();
	JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtplayerlvl"] = UnitLevel("player");

	if (JHC_SourceLoc) then
		JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtsourceloc"] = JHC_SourceLoc;
	end
	if (spellTexture) then
		JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtspell"] = spellTexture.."||"..JHC_Clean(spellName);
	end
	local qtrewards = JHC_GetQRewards();
	if (qtrewards ~= "") then
		JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrewards"] = qtrewards;
	end
	local qtchoices = JHC_GetQChoices();
	if (qtchoices ~= "") then
		JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtchoices"] = qtchoices;
	end
	if ((JHC_CurrentQuestFinishedTimer+1) > GetTime()) then
		if (JHC_CurrentQuestFinished~=nil and JHC_CurrentQuestFinished~="" and JHC_CurrentQuestFinishedObj~=nil and JHC_CurrentQuestFinishedObj~="") then
			JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtfollowing"] = JHC_CurrentQuestFinished.."||"..JHC_CurrentQuestFinishedObj;
		end
	end
end

function JHC_QuestUpdate()
	local CurrentHeader, Report;
	local JHcp = JHC_Clean(UnitName("player")).."_"..JHC_Clean(GetCVar("realmName"));
	local JHC_queteEnCours = GetNumQuestLogEntries();
	for i=1, JHC_queteEnCours, 1 do
		local questLogTitleText, level, questTag, isHeader, isCollapsed, _ = GetQuestLogTitle(i);
		if (isHeader) then
			CurrentHeader = JHC_Clean(questLogTitleText);
		else
			SelectQuestLogEntry(i);
			if (questTag==nil) then questTag="Normal"; end
			local questDescription, questObjectives = GetQuestLogQuestText();
			local QuestTitre = JHC_Clean(JHC_CleanLevel(questLogTitleText));
			local QuestTexte = JHC_Clean(JHC_CleanQuete(questDescription));
			local QuestObj = JHC_Clean(JHC_CleanQuete(questObjectives));
			local spellTexture, spellName = GetQuestLogRewardSpell(); 
			local Pos = 0;
			local CompareNom,CompareObjectif;
			local NumEntry = getn(JH_Collector.quetes);
			for a=1, NumEntry, 1 do
				CompareNom = "";
				CompareObjectif = "";
				if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
					CompareNom = JH_Collector.quetes[a]["newquete_"..JHcp]["qtnom"];
				end
				if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
					CompareObjectif = JH_Collector.quetes[a]["newquete_"..JHcp]["qtobjectif"];
				end
				if (QuestTitre == CompareNom and QuestObj == CompareObjectif) then
					Pos = a;
				end
			end
			if (Pos == 0) then
				Pos = NumEntry+1;
				table.insert(JH_Collector.quetes, Pos);
				JH_Collector.quetes[Pos] = {};
				JH_Collector.quetes[Pos]["newquete_"..JHcp] = {};
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtnom"] = QuestTitre;
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtobjectif"] = QuestObj;
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtdescription"] = QuestTexte;
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtfaction"] = UnitFactionGroup("player");
				if (spellTexture) then
					JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtspell"] = spellTexture.."||"..JHC_Clean(spellName);
				end
				JH_Main.cc.quetes = JH_Main.cc.quetes + 1;
				JH_Main.ccn.quetes = JHC_CleanLevel(questLogTitleText);
			end
			if (not JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtplayerlvl"]) then
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtplayerlvl"] = UnitLevel("player");
			end
			JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtgmoney"] = GetQuestLogRequiredMoney();
			JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtlevel"] = level;
			JH_Collector.quetes[Pos]["newquete_"..JHcp]["qttag"] = questTag;
			JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtheader"] = CurrentHeader;
			JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrmoney"] = UnitLevel("player").."||"..GetQuestLogRewardMoney();
			
			local qtrewards = "";
			for a=1, GetNumQuestLogRewards(), 1 do
				local name, _, numItems, _, _ = GetQuestLogRewardInfo(a);
				local link = GetQuestLogItemLink("reward", a);
				if (link) then
					Report = JHC_ProcessItem(link);
					if (qtrewards == "") then
						qtrewards = numItems.."_"..Report;
					else
						qtrewards = qtrewards.."||"..numItems.."_"..Report;
					end
				end
			end
			if (qtrewards ~= "") then
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrewards"] = qtrewards;
			end
			local qtchoices = "";
			for a=1, GetNumQuestLogChoices(), 1 do
				local name, _, numItems, _, _ = GetQuestLogChoiceInfo(a);
				local link = GetQuestLogItemLink("choice", a);
				if (link) then
					Report = JHC_ProcessItem(link);
					if (qtchoices == "") then
						qtchoices = numItems.."_"..Report;
					else
						qtchoices = qtchoices.."||"..numItems.."_"..Report;
					end
				end
			end
			if (qtchoices ~= "") then
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtchoices"] = qtchoices;
			end
			for b=1, GetNumQuestLeaderBoards(), 1 do
				local desc, type, done = GetQuestLogLeaderBoard(b, i);
				if (type == "event" and done ~= nil) then
				else
					local validating = string.sub(desc, 0, 2);
					if (validating ~= "  ") then
						if (not JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtlb"]) then
							JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtlb"] = {};
						end
						JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtlb"]["qtlb_"..b] = desc.."||"..type;
					end
				end
			end
		end
	end
end

function JHC_QuestProgress()
	if (IsQuestCompletable()) then
		local Report;
		local JHcp = JHC_Clean(UnitName("player")).."_"..JHC_Clean(GetCVar("realmName"));
		local JHC_TitreText = JHC_Clean(JHC_CleanLevel(GetTitleText()));
		local JHC_ProgressText = JHC_Clean(JHC_CleanQuete(GetProgressText()));
		local Pos = 0;
		local CompareNom,CompareFinished;
		local NumEntry = getn(JH_Collector.quetes);
		
		for a=1, NumEntry, 1 do
			CompareNom = "";
			CompareFinished = "";
			if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
				CompareNom = JH_Collector.quetes[a]["newquete_"..JHcp]["qtnom"];
			end
			if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
				if (JH_Collector.quetes[a]["newquete_"..JHcp]["qtfinished"]) then
					CompareFinished = JH_Collector.quetes[a]["newquete_"..JHcp]["qtfinished"];
				end
			end
			if (JHC_TitreText == CompareNom and CompareFinished ~= "fini") then
				Pos = a;
			end
		end
		
		if (Pos == 0) then
			local HasBeenSeen = 0;
			for a=1, NumEntry, 1 do
				CompareNom = "";
				if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
					CompareNom = JH_Collector.quetes[a]["newquete_"..JHcp]["qtnom"];
				end
				if (JHC_TitreText == CompareNom) then
					HasBeenSeen = 1;
				end
			end
			if (HasBeenSeen == 0) then
				return;
			end
		end
		
		if (Pos ~= 0) then
			local JHsource = UnitReaction("npc","player");
			local JHC_EndSource, JHC_EndSourceLoc;
			if (JHsource == nil) then
				local ct,rz,sz,cx,cy,mx,my = JHC_GetInfoLoc();
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtendsource"] = "objetworld||"..JHC_Clean(UnitName("npc")).."||"..rz;
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtendsourceloc"] = "1||"..ct.."||"..rz.."||"..sz.."||"..cx..":"..cy.."||"..mx..":"..my;
			else
				local _,endzone = JHcollector_Pnj();
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtendsource"] = "pnj||"..JHC_Clean(UnitName("npc")).."||"..endzone;
			end
		
			local qtiprogress = "";
			for i=1, GetNumQuestItems(), 1 do
				local name, _, numItems, _, _ = GetQuestItemInfo("required", i);
				local link = GetQuestItemLink("required", i);
				if (link) then
					Report = JHC_ProcessItem(link);
					if (qtiprogress == "") then
						qtiprogress = numItems.."_"..Report;
					else
						qtiprogress = qtiprogress.."||"..numItems.."_"..Report;
					end
				end
			end
			if (qtiprogress ~= "") then
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtiprogress"] = qtiprogress;
			end
		end
	end
end

function JHC_QuestComplete(arg1)
	if (arg1==nil) then
		local Report;
		local JHcp = JHC_Clean(UnitName("player")).."_"..JHC_Clean(GetCVar("realmName"));
		local QuestTitre = JHC_Clean(JHC_CleanLevel(GetTitleText()));
		JHC_CurrentQuestComplete = QuestTitre;
		JHC_CurrentQuestCompleteTimer = GetTime();
		local Pos = 0;
		local CompareNom,CompareFinished;
		local NumEntry = getn(JH_Collector.quetes);
		for a=1, NumEntry, 1 do
			CompareNom = "";
			CompareFinished = "";
			if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
				CompareNom = JH_Collector.quetes[a]["newquete_"..JHcp]["qtnom"];
			end
			if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
				if (JH_Collector.quetes[a]["newquete_"..JHcp]["qtfinished"]) then
					CompareFinished = JH_Collector.quetes[a]["newquete_"..JHcp]["qtfinished"];
				end
			end
			if (QuestTitre == CompareNom and CompareFinished ~= "fini") then
				Pos = a;
			end
		end
		if (Pos~=0) then
			if (not JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtendsource"]) then
				local JHsource = UnitReaction("npc","player");
				local JHC_EndSource, JHC_EndSourceLoc;
				if (JHsource == nil) then
					local ct,rz,sz,cx,cy,mx,my = JHC_GetInfoLoc();
					JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtendsource"] = "objetworld||"..JHC_Clean(UnitName("npc")).."||"..rz;
					JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtendsourceloc"] = "1||"..ct.."||"..rz.."||"..sz.."||"..cx..":"..cy.."||"..mx..":"..my;
				else
					local _,endzone = JHcollector_Pnj();
					JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtendsource"] = "pnj||"..JHC_Clean(UnitName("npc")).."||"..endzone;
				end
			end
			if (not JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrmoney"]) then
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrmoney"] = UnitLevel("player").."||"..GetRewardMoney();
			end
			if (not JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrewards"]) then
				local qtrewards = JHC_GetQRewards();
				if (qtrewards ~= "") then
					JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtrewards"] = qtrewards;
				end
			end
			if (not JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtchoices"]) then
				local qtchoices = JHC_GetQChoices();
				if (qtchoices ~= "") then
					JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtchoices"] = qtchoices;
				end
			end
		end
	end
end

function JHC_QuestFinished()
	if (JHC_CurrentQuestComplete and arg1==nil) then
		local JHcp = JHC_Clean(UnitName("player")).."_"..JHC_Clean(GetCVar("realmName"));
		local Pos = 0;
		local CompareNom,CompareFinished;
		local NumEntry = getn(JH_Collector.quetes);
		for a=1, NumEntry, 1 do
			CompareNom = "";
			CompareFinished = "";
			if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
				CompareNom = JH_Collector.quetes[a]["newquete_"..JHcp]["qtnom"];
			end
			if (JH_Collector.quetes[a]["newquete_"..JHcp]) then
				if (JH_Collector.quetes[a]["newquete_"..JHcp]["qtfinished"]) then
					CompareFinished = JH_Collector.quetes[a]["newquete_"..JHcp]["qtfinished"];
				end
			end
			if (JHC_CurrentQuestComplete == CompareNom and CompareFinished ~= "fini") then
				Pos = a;
			end
		end
		if (Pos~=0) then
			JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtfinished"] = "fini";
			if ((JHC_CurrentXpGainTimer+1) > GetTime() and JHC_CurrentXpGain ~= "") then
				JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtxpgain"] = UnitLevel("player").."||"..JHC_CurrentXpGain;
			end
			JHC_CurrentQuestFinished = JHC_CurrentQuestComplete;
			JHC_CurrentQuestFinishedObj = JH_Collector.quetes[Pos]["newquete_"..JHcp]["qtobjectif"];
			JHC_CurrentQuestFinishedTimer = GetTime();
		end
	end
end

function JHC_MemXpGain(towork)
	if (string.find(towork, "Vous gagnez (%d+) points d'exp\195\169rience.")) then
		local _,_,valeur = string.find(towork, "Vous gagnez (%d+) points d'exp\195\169rience.");
		JHC_CurrentXpGain = valeur;
		JHC_CurrentXpGainTimer = GetTime();
	end
end

function JHC_GetQRewards()
	local qtrewards = "";
	for i=1, GetNumQuestRewards(), 1 do
		local name,_,numItems,_,_ = GetQuestItemInfo("reward", i);
		local link = GetQuestItemLink("reward", i);
		if (link) then
			Report = JHC_ProcessItem(link);
			if (qtrewards == "") then
				qtrewards = numItems.."_"..Report;
			else
				qtrewards = qtrewards.."||"..numItems.."_"..Report;
			end
		end
	end
	return qtrewards;
end

function JHC_GetQChoices()
	local qtchoices = "";
	for i=1, GetNumQuestChoices(), 1 do
		local name, _, numItems, _, _ = GetQuestItemInfo("choice", i);
		local link = GetQuestItemLink("choice", i);
		if (link) then
			local Report = JHC_ProcessItem(link);
			if (qtchoices == "") then
				qtchoices = numItems.."_"..Report;
			else
				qtchoices = qtchoices.."||"..numItems.."_"..Report;
			end
		end
	end
	return qtchoices;
end

function JHC_GetQRequired()
	local qtrequired = "";
	for i=1, GetNumQuestItems(), 1 do
		local name, _, numItems, _, _ = GetQuestItemInfo("required", i);
		local link = GetQuestItemLink("required", i);
		if (link) then
			local Report = JHC_ProcessItem(link);
			if (qtrequired == "") then
				qtrequired = numItems.."_"..Report;
			else
				qtrequired = qtrequired.."||"..numItems.."_"..Report;
			end
		end
	end
	return qtrequired;
end

function JHC_Tradeskill()
	local numSkills = GetNumTradeSkills();
	local tradeskillName,_,_ = GetTradeSkillLine();
	local tradeskillName = JHC_Clean(tradeskillName);
	if (not JH_Collector.ts[tradeskillName]) then
		JH_Collector.ts[tradeskillName] = {};
	end
	local CurrentHeader = "";
	for i=1, numSkills, 1 do
		local skillName, skillType,_,_ = GetTradeSkillInfo(i);
		local skillName = JHC_Clean(skillName);
		local skillType = JHC_Clean(skillType);
		if (skillType == "header") then
			CurrentHeader = skillName;
		else
			local link = GetTradeSkillItemLink(i);
			if (link) then
				local Report = JHC_ProcessItem(link);
				local minMade, maxMade = GetTradeSkillNumMade(i);
				local tools = BuildColoredListString(GetTradeSkillTools(i));
				if (tools) then
					tools = string.gsub(tools, "|cffff2020", "");
					tools = string.gsub(tools, "|r", "");
				else
					tools = "";
				end
				if (not JH_Collector.ts[tradeskillName]["tsitem_"..Report]) then
					JH_Collector.ts[tradeskillName]["tsitem_"..Report] = {};
					JH_Main.cc.ts = JH_Main.cc.ts + 1;
					JH_Main.ccn.ts = skillName;
				end
				JH_Collector.ts[tradeskillName]["tsitem_"..Report].tstools = tools;
				JH_Collector.ts[tradeskillName]["tsitem_"..Report].tsinfos = tradeskillName.."||"..CurrentHeader.."||"..skillName.."||"..Report;
				JH_Collector.ts[tradeskillName]["tsitem_"..Report].tsquantite = minMade.."||"..maxMade;
				local numReagents = GetTradeSkillNumReagents(i);
				for j=1, numReagents, 1 do
					local _,_,reagentCount,_ = GetTradeSkillReagentInfo(i, j);
					local Reagentlink = GetTradeSkillReagentItemLink(i, j);
					if (Reagentlink) then
						local ReagentReport = JHC_ProcessItem(Reagentlink);
						if (not JH_Collector.ts[tradeskillName]["tsitem_"..Report].tscompo) then
							JH_Collector.ts[tradeskillName]["tsitem_"..Report].tscompo = {};
						end
						JH_Collector.ts[tradeskillName]["tsitem_"..Report].tscompo["tscompo_"..ReagentReport] = ReagentReport.."||"..reagentCount;
					end
				end
			end
		end
	end
end

function JHC_Shop()
	local JHC_ShopName,_ = JHcollector_Pnj();
	local Plot = "vendeur_"..JHC_ShopName;
	for i=1, GetMerchantNumItems(), 1 do
		local _, _, price, quantity, numAvailable, _ = GetMerchantItemInfo(i);
		local link = GetMerchantItemLink(i);
		if (link) then
			local Report = JHC_ProcessItem(link);
			if (not JH_Collector.vendu[Plot]) then
				JH_Collector.vendu[Plot] = {};
			end
			if (not JH_Collector.vendu[Plot]["vend_"..Report]) then
				JH_Collector.vendu[Plot]["vend_"..Report] = price.."||"..quantity.."||"..numAvailable;
			end
		end
	end
end

function JHC_ShopSell()
	local IsInBag = 0;
	for bagNum = 0, 4 do
		local bagname = GetBagName(bagNum);
		local bagNum_Slots = GetContainerNumSlots(bagNum);
		if (bagname) then
			for bagItem = 1, bagNum_Slots do
				local _,itemCount,_,_,_ = GetContainerItemInfo(bagNum, bagItem);
				local BagitemLink = GetContainerItemLink(bagNum, bagItem);
				if (BagitemLink) then
					local Report = JHC_ProcessItem(BagitemLink);
               		JHC_LastSellValue = 0;
                	JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
					JH_CollectorTooltip:SetBagItem(bagNum, bagItem);
					if (JHC_LastSellValue ~= 0) then
						JHC_LastSellValue = JHC_LastSellValue/itemCount;
						if (not JH_Collector.selling["selling_"..Report]) then
							JH_Collector.selling["selling_"..Report] = JHC_LastSellValue.."||"..JHC_LastSellValue;
							JH_Main.cc.vendu = JH_Main.cc.vendu + 1;
							JH_Main.ccn.vendu = BagitemLink;
						else
							local a,b;
							for a, b in string.gfind(JH_Collector.selling["selling_"..Report], "(%d+)||(%d+)") do
								if (tonumber(b)<JHC_LastSellValue) then b = JHC_LastSellValue; end
								if (tonumber(a)>JHC_LastSellValue) then a = JHC_LastSellValue; end
								local newstring = a.."||"..b;
								JH_Collector.selling["selling_"..Report] = newstring;
							end
						end
					end
					for idx=1,JH_CollectorTooltip:NumLines() do
						getglobal("JH_CollectorTooltipTextLeft"..idx):SetText("");
						getglobal("JH_CollectorTooltipTextRight"..idx):SetText("");
					end
					-- JH_CollectorTooltip:ClearLines();
				end
			end
		end
	end
end

function JHC_CheckPnj()
	JHcollector_Pnj();
end

function JHcollector_Pnj()
	local JHC_pnj = JHC_Clean(UnitName("npc"));
	local ct,rz,sz,cx,cy,mx,my = JHC_GetInfoLoc();
	local Plot = "pnj_"..JHC_pnj.."_"..rz;
	local CanRepair = 0;
	if (CanMerchantRepair("target")) then CanRepair = 1; end
	if (not JH_Collector.pnjs[Plot]) then
		JH_Collector.pnjs[Plot] = {};
		JH_Collector.pnjs[Plot].pnjnom = JHC_pnj;
		JH_Collector.pnjs[Plot].pnjlvl = UnitLevel("npc");
		JH_Collector.pnjs[Plot].pnjtype = UnitCreatureType("npc");
		JH_Collector.pnjs[Plot].pnjrepair = CanRepair;
		JH_Collector.pnjs[Plot].pnjrace = UnitRace("npc");
		JH_Collector.pnjs[Plot].pnjfaction = UnitFactionGroup("player");
		JHC_CleanJHTooltip();
		JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		JH_CollectorTooltip:SetUnit("npc");
		JH_Collector.pnjs[Plot].pnjttip = JHC_GetTooltip();
		JH_Main.cc.pnjs = JH_Main.cc.pnjs+1;
		JH_Main.ccn.pnjs = UnitName("npc");
	end
	if (JH_Collector.pnjs[Plot].pnjttip=="") then
		JHC_CleanJHTooltip();
		JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		JH_CollectorTooltip:SetUnit("npc");
		JH_Collector.pnjs[Plot].pnjttip = JHC_GetTooltip();
	end
	local JHC_GossipText = JHC_Clean(GetGossipText());
	if (UnitReaction("npc","player")==nil and JHC_GossipText~="") then
		JH_Collector.pnjs[Plot].pnjinerte = JHC_GossipText;
	end
	if (not JH_Collector.pnjs[Plot].pnjloc) then
		JH_Collector.pnjs[Plot].pnjloc = {}
	end
	if (not JH_Collector.pnjs[Plot].pnjloc["pnjloc_"..rz.."_"..mx..":"..my]) then
		JH_Collector.pnjs[Plot].pnjloc["pnjloc_"..rz.."_"..mx..":"..my] = "1".."||"..ct.."||"..rz.."||"..sz.."||"..cx..":"..cy.."||"..mx..":"..my;
		JH_Main.cc.locs = JH_Main.cc.locs+1;
		JH_Main.ccn.locs = rz.." "..mx..":"..my;
	else
		local a,b;
		for a, b in string.gfind(JH_Collector.pnjs[Plot].pnjloc["pnjloc_"..rz.."_"..mx..":"..my], "(%d+)||(.*)") do
			a = tonumber(a)+1;
			local newstring = a.."||"..b;
			JH_Collector.pnjs[Plot].pnjloc["pnjloc_"..rz.."_"..mx..":"..my] = newstring;
		end
	end
	return JHC_pnj,rz;
end

------------------------------------------------------------------------------------------------------
-- Fonctions globales
------------------------------------------------------------------------------------------------------

function JHC_Clean(toclean)
	if ( toclean == nil ) then
		toclean = "";
		return toclean;
	else
		return string.gsub(string.gsub(string.gsub(toclean, "\n", "|n|"), "\r", "|r|"),"\"","dbquote");
	end
end

function JHC_CleanItem(toclean)
	if ( toclean == nil ) then
		toclean = "";
		return toclean;
	else
		return string.gsub(string.gsub(string.gsub(toclean, "\n", ""), "\r", ""),"\"","dbquote");
	end
end

function JHC_CleanLevel(toclean)
	local NewTitre;
	local _, _, niveau, titre = string.find(toclean, "%[(.*)%] (.*)");
	if (titre) then
		NewTitre = titre;
	else
		NewTitre = toclean;
	end
	return NewTitre;
end

function JHC_CleanQuete(toclean)
	if ( toclean == nil ) then
		toclean = "";
		return toclean;
	else
		local JHplayer = UnitName("player");
		if ( JHplayer == nil ) then
			return toclean;
		else
			toclean = string.gsub(toclean, "Entit\195\169 inconnue", "[personnage]");
			return string.gsub(toclean, UnitName("player"), "[personnage]");
		end
	end
end

function JHC_ProcessItem(link)
	local color, item, id, objet, ToWork1, ToWork2;
	for color, item, id, objet in string.gfind(link, "|c(%x+)|Hitem:((%d+):%d+:%d+:%d+)|h%[(.-)%]|h|r") do
		ToWork1 = string.gsub(item,"(%d+):(%d+):(%d+):(%d+)","%1:0:%3:0");
		ToWorkReport1 = string.gsub(item,"(%d+):(%d+):(%d+):(%d+)","%1:%3");
		ToWork2 = string.gsub(item,"(%d+):(%d+):(%d+):(%d+)","%1:0:0:0");
		ToWorkReport2 = string.gsub(item,"(%d+):(%d+):(%d+):(%d+)","%1:0");
		ToReport = string.gsub(item,"(%d+):(%d+):(%d+):(%d+)","%1:%3");
		local itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(id);
		if (itemName) then
			if (not JH_Collector.objets["obj_"..ToWorkReport1]) then	
				JH_Collector.objets["obj_"..ToWorkReport1] = {};
				JH_Collector.objets["obj_"..ToWorkReport1].objnom = JHC_Clean(objet);
				JH_Collector.objets["obj_"..ToWorkReport1].objid = ToWorkReport1;
				JH_Collector.objets["obj_"..ToWorkReport1].objdisplay = itemRarity.."||"..color.."||"..itemTexture;
				JH_Collector.objets["obj_"..ToWorkReport1].objminlevel = itemMinLevel;
				JH_Collector.objets["obj_"..ToWorkReport1].objtype = JHC_Clean(itemType).."||"..JHC_Clean(itemSubType);
				JH_Collector.objets["obj_"..ToWorkReport1].objstack = itemStackCount;
				JH_Collector.objets["obj_"..ToWorkReport1].objequiploc = itemEquipLoc;
				JHC_CleanJHTooltip();
				JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
				JH_CollectorTooltip:SetHyperlink("item:"..ToWork1);
				JH_Collector.objets["obj_"..ToWorkReport1].objtooltip = JHC_GetTooltip();
				JH_Main.cc.objets = JH_Main.cc.objets + 1;
				JH_Main.ccn.objets = link;
			end
			if (JH_Collector.objets["obj_"..ToWorkReport1].objtooltip=="") then
				JHC_CleanJHTooltip();
				JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
				JH_CollectorTooltip:SetHyperlink("item:"..ToWork1);
				JH_Collector.objets["obj_"..ToWorkReport1].objtooltip = JHC_GetTooltip();
			end
			
			if (ToWork1 ~= ToWork2) then
				if (not JH_Collector.objets["obj_"..ToWorkReport2]) then
					JH_Collector.objets["obj_"..ToWorkReport2] = {};
					JH_Collector.objets["obj_"..ToWorkReport2].objnom = JHC_Clean(itemName);
					JH_Collector.objets["obj_"..ToWorkReport2].objid = ToWorkReport2;
					JH_Collector.objets["obj_"..ToWorkReport2].objdisplay = itemRarity.."||"..color.."||"..itemTexture;
					JH_Collector.objets["obj_"..ToWorkReport2].objminlevel = itemMinLevel;
					JH_Collector.objets["obj_"..ToWorkReport2].objtype = JHC_Clean(itemType).."||"..JHC_Clean(itemSubType);
					JH_Collector.objets["obj_"..ToWorkReport2].objstack = itemStackCount;
					JH_Collector.objets["obj_"..ToWorkReport2].objequiploc = itemEquipLoc;
					JHC_CleanJHTooltip();
					JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
					JH_CollectorTooltip:SetHyperlink("item:"..ToWork2);
					JH_Collector.objets["obj_"..ToWorkReport2].objtooltip = JHC_GetTooltip();
					JH_Main.cc.objets = JH_Main.cc.objets + 1;
					JH_Main.ccn.objets = link;
				end
				if (JH_Collector.objets["obj_"..ToWorkReport2].objtooltip=="") then
					JH_CollectorTooltip:SetOwner(UIParent, "ANCHOR_NONE");
					JH_CollectorTooltip:SetHyperlink("item:"..ToWork2);
					JH_Collector.objets["obj_"..ToWorkReport2].objtooltip = JHC_GetTooltip();
				end
			end
		end
	end
	return ToReport;
end

function JHC_GetTooltip()
	local JHttdone = {};
	for idx=1,JH_CollectorTooltip:NumLines() do
		local JHtextLeft = nil;
		local JHtextRight = nil;
		local JHtoadd = nil;
		JHtextLeft = getglobal("JH_CollectorTooltipTextLeft"..idx);
		JHtextRight = getglobal("JH_CollectorTooltipTextRight"..idx);
		if (JHtextLeft:GetText()) then
			local JHtextL = JHtextLeft:GetText();
			JHtextL = JHC_CleanItem(JHtextL);
			JHtoadd = JHtextL;
		end
		if (JHtextRight:GetText()) then
			local JHtextR = JHtextRight:GetText();
			JHtextR = JHC_CleanItem(JHtextR);
			JHtoadd = JHtoadd.."---"..JHtextR;
		end
		if ( JHtoadd ) then
			table.insert(JHttdone,JHtoadd);
		end
	end
	for idx=1,JH_CollectorTooltip:NumLines() do
		getglobal("JH_CollectorTooltipTextLeft"..idx):SetText("");
		getglobal("JH_CollectorTooltipTextRight"..idx):SetText("");
	end
	-- JH_CollectorTooltip:ClearLines();
	return table.concat(JHttdone,"|n|");
end

function JHC_GetInfoLoc()
	SetMapToCurrentZone();
	local JH_mapContinent = GetCurrentMapContinent();
	local JH_CurrentRealZoneName,JH_SubZone,JH_Cpx,JH_Cpy,JH_Mpx,JH_Mpy;
	if (JH_mapContinent == -1) then
		JH_CurrentRealZoneName = JHC_Clean(GetRealZoneText());
		JH_SubZone = JHC_Clean(GetSubZoneText());
		if (JH_SubZone=="" or JH_SubZone==nil) then JH_SubZone=JH_CurrentRealZoneName; end
		JH_Cpx = 0;
		JH_Cpy = 0;
		JH_Mpx = 0;
		JH_Mpy = 0;
	else
		local JH_mapZone = GetCurrentMapZone();
		SetMapZoom(JH_mapContinent);
		JH_Cpx, JH_Cpy = GetPlayerMapPosition("player");
		SetMapZoom(JH_mapContinent,JH_mapZone);
		JH_CurrentRealZoneName = JHC_Clean(GetRealZoneText());
		JH_Mpx, JH_Mpy = GetPlayerMapPosition("player");
		JH_SubZone = JHC_Clean(GetSubZoneText());
		if (JH_SubZone=="" or JH_SubZone==nil) then JH_SubZone=JH_CurrentRealZoneName; end
		JH_Cpx = floor(JH_Cpx*100);
		JH_Cpy = floor(JH_Cpy*100);
		JH_Mpx = floor(JH_Mpx*100);
		JH_Mpy = floor(JH_Mpy*100);
	end
	return JH_mapContinent,JH_CurrentRealZoneName,JH_SubZone,JH_Cpx,JH_Cpy,JH_Mpx,JH_Mpy;
end

function JHC_AnalyseEvent()
	DEFAULT_CHAT_FRAME:AddMessage(event);
	if (arg1 and arg1~="") then DEFAULT_CHAT_FRAME:AddMessage("arg1 : "..arg1); end
	if (arg2 and arg2~="") then DEFAULT_CHAT_FRAME:AddMessage("arg2 : "..arg2); end
end

function JHC_CleanJHTooltip()
	for idx=1,JH_CollectorTooltip:NumLines() do
		getglobal("JH_CollectorTooltipTextLeft"..idx):SetText("");
		getglobal("JH_CollectorTooltipTextRight"..idx):SetText("");
	end
	-- JH_CollectorTooltip:ClearLines();
end
