
function TitanAggro_SelectTargeterOnUnit(unit)
	local mobName;
	local lastTarget = UnitName("target");
	local targetOk = nil;
	for j=1, 15 do
		TargetNearestEnemy();
		if (UnitIsUnit(unit, "targettarget")) then
			j = 21; --found
			targetOk = 1;
		end
	end
	if (not targetOk) then
		if (lastTarget) then
			TargetByName(lastTarget);
		else
			ClearTarget();
		end
	end
end

function TitanAggro_CheckUpdatedAggroList()
	if(GetTime() - AggroVars.LastUpdateAggroList > AggroVars.ScanFreq) then
		local init_time = GetTime();
		TitanAggro_UpdateAggroList();
		AggroVars.LastUpdateAggroList = GetTime();
		AggroVars.ScanFreq = (AggroVars.LastUpdateAggroList - init_time) * 10;

		if (AggroVars.ScanFreq < 1) then
			AggroVars.ScanFreq = 1;
		elseif (AggroVars.ScanFreq > 10) then
			AggroVars.ScanFreq = 10;
			TitanAggro_Debug("CheckUpdatedAggroList(): Exec very slow next scan in 10s");
		end
	end
end

function TitanAggro_UpdateAggroList()
	local mob;
	AggroVars.ToTTable = {};
	AggroVars.MobToTTable = {};
	local init_time = GetTime();

	if (TitanAggroGetVar("AggroDetect") > 0) then
		local unit, player;
		local max = 0;
		local groupstr = "party";
		if (TitanAggroGetVar("AggroDetect") == 2) then max = 4; end
		if (TitanAggroGetVar("AggroDetect") == 3) then
			if (UnitInRaid("player")) then
				max = 40;
				groupstr = "raid";
			else
				max = 4;
				groupstr = "party";
			end
		end
		local petstr = groupstr.."pet";
		for i=0, max do
			for j=1, 2 do
				if (TitanAggroGetVar("AggroDetectPets") ~= 1) then
					j = 10;
				end
				if (j==2) then
					if (i==0) then unit = "pet"; else unit = petstr..i; end
				else
					if (i==0) then unit = "player"; else unit = groupstr..i; end
				end
				player = UnitName(unit);
				if (player) then
					mob = UnitName(unit.."target");
					if (mob and not UnitIsFriend("player", unit.."target")) then
						--DEFAULT_CHAT_FRAME:AddMessage(unit.." -> "..mob);
						mob = "["..UnitLevel(unit.."target").."]"..mob;
						ttname, ttserver = UnitName("targettarget");
						ttuname, ttuserver = UnitName(unit.."targettarget");
						tinsert(AggroVars.ToTTable, ttname);
						tinsert(AggroVars.MobToTTable, mob);
					end
				end
			end
		end
	end
	TitanAggro_Debug("UpdateAggroList(): "..string.format("%.4f",GetTime()-init_time).." seconds.")

	if (TitanAggroGetVar("AggroDetect") > 0) then
		TitanAggro_UpdateAggroIcon();
	end
--	if(TitanAggroGetVar(TITAN_AGGROALERT_ID, SHOW_PARTY_AGGRO_TOOLTIP_CODE)) then
--		TitanPanelAggroAlert_updatePartyAggroTooltip();
--	end
end


function TitanAggro_UpdateAggroIcon()
	init_time = GetTime();
	TitanAggro_Icons_ResetIcon();
	local tableSize = getn(AggroVars.ToTTable);
	local unit, player;
	for i=0, 4 do
		for j=1, 2 do
			if (j==2) then
				if (i==0) then unit = "pet"; else unit = "party"..i; end
			else
				if (i==0) then unit = "player";	else unit = "party"..i; end
			end

			player = UnitName(unit);
			if (player) then
				for j=1, tableSize do
					if (AggroVars.ToTTable[j] == player) then
						TitanAggro_Debug("Someone got aggro: "..player);
						TitanAggro_Icons_ShowIconByUnit(unit);
						j = tableSize+1;
					end
				end
			end
		end
	end
end

function TitanAggro_GetAggroTooltip(unit)
	init_time = GetTime();
	local tableSize = getn(AggroVars.ToTTable);
	local text = "";
	local player = UnitName(unit);

	if(player) then
		text = text..AggroVars.TargetedBy_Text..TitanAggro_GetColoredText(player, GREEN_FONT_COLOR);
		for j=1, tableSize do
			if(AggroVars.ToTTable[j] == player) then
				text = text..AggroVars.TargetedBy_Extra..TitanAggro_GetColoredText(AggroVars.MobToTTable[j], NORMAL_FONT_COLOR);
				TitanAggro_Icons_ShowIconByUnit(unit);
			end
		end
	end
	return text;
end
