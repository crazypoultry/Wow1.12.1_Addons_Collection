
---------------
-- CONSTANTS --
---------------

-- NOTE: "DMI"s are the legacy name for quantities that DM tracks.
-- However, the term "quantity" refers to a quantity that is displayed.
-- There are more Quantities than there are DMIs.
-- Better names for these two things would be "Real" vs. "Virtual" or "Display" quantities.

DMI_DAMAGE = 1;
DMI_HEALING = 2;
DMI_DAMAGED = 3;
DMI_HEALED = 4;
	DMI_REPORT_MAX = 4;
DMI_CURING = 5;
--DMI_THREAT = 6;
DMI_MAX = 5;

-- Just legacy crap.
DMI_1 = DMI_DAMAGE;
DMI_2 = DMI_HEALING;
DMI_3 = DMI_DAMAGED;
DMI_4 = DMI_HEALED;

-- Hit types.
DM_HIT = 1;
DM_CRIT = 2;
DM_DOT = 3;

DM_TABLE_A	= 1;
DM_TABLE_B	= 2;
DMT_FIGHT	= 3;
DMT_MAX		= 3

-- Defined Quantities.
-- These numbers index into the DM_QUANTDEFS table.
DamageMeters_Quantity_DAMAGE = 1;
DamageMeters_Quantity_HEALING = 2;
DamageMeters_Quantity_DAMAGED = 3;
DamageMeters_Quantity_HEALINGRECEIVED = 4;
DamageMeters_Quantity_CURING = 5;
DamageMeters_Quantity_DPS = 6;
DamageMeters_Quantity_HPS = 7;
DamageMeters_Quantity_DTPS = 8;
DamageMeters_Quantity_HTPS = 9;
DamageMeters_Quantity_CURINGFIGHT = 10;
DamageMeters_Quantity_TIME = 11;
DamageMeters_Quantity_NETDAMAGE = 12;
DamageMeters_Quantity_NETHEALING = 13;
DamageMeters_Quantity_DAMAGEPLUSHEALING = 14;
--DamageMeters_Quantity_DANDERATING = 15;
--DamageMeters_Quantity_THREAT = 16;

-- While this is assigned here, this number is actually CALCULATED when 
-- DamageMeters is loaded.  (It is set to the length of DM_QUANTDEFS).  This was intended to 
-- allow other mods to add quantities, but who knows if its really possible.
DamageMeters_Quantity_MAX = 14;

-- These aren't actualy quantities, but rather just flags to DoReport.
DamageMeters_ReportQuantity_Total = -1;
DamageMeters_ReportQuantity_Leaders = -2;
DamageMeters_ReportQuantity_Events = -3;

-------------------------------------------------------------------------------
-- Virtual Quantity Definitions --

--[[
	name			- The localized string name of this quantity.
	psName			- [Optional] The string name of the quantity when it is per-second.
	defaultColor	- The default color of the frame when the quantity is visible.
	dmi				- [Optional] The DMI that this quantity is based on.
	bUsesFightTable - True if this quantity uses the Fight table instead of the Active one.
	toggleQuant		- The quantity to switch to when we are toggled.  (Note that toggling really means between fight/regular).
	filterDefault	- Default quantity filter setting.
	pfnGetValue		- function(playerStruct).  A quantityDef can specify a function that the system is to call
						to get a given player's value for this quantity.
]]--

DM_QUANTDEFS = {};

DM_QUANTDEFS[DamageMeters_Quantity_DAMAGE] = {
	name = DM_QUANTSTRING_DAMAGEDONE,
	psName = nil,
	defaultColor = {1.0, 0.0, 0.0, 0.8},
	dmi = DMI_DAMAGE,
	bUsesFightTable = false,
	toggleQuant = DamageMeters_Quantity_DPS,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_HEALING] = {
	name = DM_QUANTSTRING_HEALINGDONE,
	psName = nil,
	defaultColor = {0.0, 1.0, 0.0, 0.8},
	dmi = DMI_HEALING,
	bUsesFightTable = false,
	toggleQuant = DamageMeters_Quantity_HPS,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_DAMAGED] = {
	name = DM_QUANTSTRING_DAMAGETAKEN,
	psName = nil,
	defaultColor = {1.0, 0.5, 0.0, 0.8},
	dmi = DMI_DAMAGED,
	bUsesFightTable = false,
	toggleQuant = DamageMeters_Quantity_DTPS,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_HEALINGRECEIVED] = {
	name = DM_QUANTSTRING_HEALINGTAKEN,
	psName = nil,
	defaultColor = {0.0, 0.7, 0.3, 0.8},
	dmi = DMI_HEALED,
	bUsesFightTable = false,
	toggleQuant = DamageMeters_Quantity_HTPS,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_CURING] = {
	name = DM_QUANTSTRING_CURING,
	psName = nil,
	defaultColor = {0.6, 0.7, 0.8, 0.8},
	dmi = DMI_CURING,
	bUsesFightTable = false,
	toggleQuant = DamageMeters_Quantity_CURINGFIGHT,
	filterDefault = true,
};

DM_QUANTDEFS[DamageMeters_Quantity_DPS] = {
	name = DM_QUANTSTRING_DAMAGEDONE_FIGHT,
	psName = DM_QUANTSTRING_DAMAGEDONE_PS,
	defaultColor = {0.4, 0.0, 0.8, 0.8},
	dmi = DMI_DAMAGE,
	bUsesFightTable = true,
	toggleQuant = DamageMeters_Quantity_DAMAGE,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_HPS] = {
	name = DM_QUANTSTRING_HEALINGDONE_FIGHT,
	psName = DM_QUANTSTRING_HEALINGDONE_PS,
	defaultColor = {0.2, 0.9, 0.5, 0.8},
	dmi = DMI_HEALING,
	bUsesFightTable = true,
	toggleQuant = DamageMeters_Quantity_HEALING,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_DTPS] = {
	name = DM_QUANTSTRING_DAMAGETAKEN_FIGHT,
	psName = DM_QUANTSTRING_DAMAGETAKEN_PS,
	defaultColor = {1.0, 0.7, 0.2, 0.8},
	dmi = DMI_DAMAGED,
	bUsesFightTable = true,
	toggleQuant = DamageMeters_Quantity_DAMAGED,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_HTPS] = {
	name = DM_QUANTSTRING_HEALINGTAKEN_FIGHT,
	psName = DM_QUANTSTRING_HEALINGTAKEN_PS,
	defaultColor = {0.0, 0.8, 0.8, 0.8},
	dmi = DMI_HEALED,
	bUsesFightTable = true,
	toggleQuant = DamageMeters_Quantity_HEALINGRECEIVED,
	filterDefault = true,
};
DM_QUANTDEFS[DamageMeters_Quantity_CURINGFIGHT] = {
	name = DM_QUANTSTRING_CURING_FIGHT,
	psName = DM_QUANTSTRING_CURING_PS,
	defaultColor = {0.4, 0.5, 0.6, 0.8},
	dmi = DMI_CURING,
	bUsesFightTable = true,
	toggleQuant = DamageMeters_Quantity_CURING,
	filterDefault = true,
};

DM_QUANTDEFS[DamageMeters_Quantity_TIME] = {
	name = DM_QUANTSTRING_IDLETIME,
	psName = nil,
	defaultColor = {0.0, 0.0, 1.0, 0.8},
	dmi = nil,
	bUsesFightTable = false,
	filterDefault = true,
	pfnGetValue = function(playerStruct) return GetTime() - playerStruct.lastTime; end,
	formatString = "%.1f",
};

DM_QUANTDEFS[DamageMeters_Quantity_NETDAMAGE] = {
	name = DM_QUANTSTRING_NETDAMAGE,
	psName = nil,
	defaultColor = {0.5, 0.0, 0.0, 0.8},
	dmi = nil,
	bUsesFightTable = false,
	filterDefault = false,
	pfnGetValue = function(playerStruct) return playerStruct.q[DMI_DAMAGE] - playerStruct.q[DMI_DAMAGED]; end,
};
DM_QUANTDEFS[DamageMeters_Quantity_NETHEALING] = {
	name = DM_QUANTSTRING_NETHEALING,
	psName = nil,
	defaultColor = {0.0, 0.5, 0.0, 0.8},
	dmi = nil,
	bUsesFightTable = false,
	filterDefault = false,
	pfnGetValue = function(playerStruct) return playerStruct.q[DMI_HEALING] - playerStruct.q[DMI_HEALED]; end,
};
DM_QUANTDEFS[DamageMeters_Quantity_DAMAGEPLUSHEALING] = {
	name = DM_QUANTSTRING_DAMAGEPLUSHEALING,
	psName = nil,
	defaultColor = {0.5, 0.5, 0.5, 0.8},
	dmi = nil,
	bUsesFightTable = false,
	filterDefault = false,
	pfnGetValue = function(playerStruct) return playerStruct.q[DMI_DAMAGE] + playerStruct.q[DMI_HEALING]; end,
};
--[[
DM_QUANTDEFS[DamageMeters_Quantity_DANDERATING] = {
	name = DM_QUANTSTRING_DANDERATING,
	psName = nil,
	defaultColor = {1.0, 0.6, 0.6, 0.8},
	dmi = nil,
	bUsesFightTable = false,
	filterDefault = false,
	pfnGetValue = 
		function(playerStruct) 
			local dmgIndex = (	DamageMeters_totalsTable[DMT_ACTIVE] ~= nil and 
								DamageMeters_totalsTable[DMT_ACTIVE][DMI_DAMAGE] ~= nil and 
								DamageMeters_totalsTable[DMT_ACTIVE][DMI_DAMAGE] > 0) 
									and 
										floor(playerStruct.q[DMI_DAMAGE] * 500.0 / DamageMeters_totalsTable[DMT_ACTIVE][DMI_DAMAGE]) 
									or 
										0;
			local healIndex = (	DamageMeters_totalsTable[DMT_ACTIVE] ~= nil and 
								DamageMeters_totalsTable[DMT_ACTIVE][DMI_HEALING] ~= nil and
								DamageMeters_totalsTable[DMT_ACTIVE][DMI_HEALING] > 0) 
									and 
										floor(playerStruct.q[DMI_HEALING] * 500.0 / DamageMeters_totalsTable[DMT_ACTIVE][DMI_HEALING]) 
									or 
										0;
			return dmgIndex + healIndex;		
		end,
};
]]--
--[[
DM_QUANTDEFS[DamageMeters_Quantity_THREAT] = {
	name = DM_QUANTSTRING_THREAT,
	psName = nil,
	defaultColor = {0.8, 0.7, 0.6, 0.8},
	dmi = DMI_THREAT,
	bUsesFightTable = false,
	filterDefault = false,
};
]]--

-------------
-- GLOBALS -- 
-------------
DamageMeters_rankTable = {};
DamageMeters_totalsTable = {};

-------------------------------------------------
-- FUNCTIONS --
-------------------------------------------------

function DamageMeters_IsQuantityFight(quantity)
	return (quantity >= DamageMeters_Quantity_DPS and quantity <= DamageMeters_Quantity_HTPS);
end

function DamageMeters_IsQuantityPS(quantity, forcePSFlag)
	return (DamageMeters_flags[DMFLAG_showFightAsPS] or forcePSFlag) and (DM_QUANTDEFS[quantity].bUsesFightTable);
end

function DamageMeters_GetQuantityDMI(quantity)
	if (nil == quantity) then
		DMPrintD("DamageMeters_GetQuantityDMI: quantity = nil");
	end

	return DM_QUANTDEFS[quantity].dmi;
end

-- This function is about as fast as I know how to make it.  It doesn't protect
-- against invalid inputs at all.
function DamageMeters_GetQuantityValue(quantity, tableIndex, playerIndex)
	local playerStruct = DamageMeters_tables[tableIndex][playerIndex];

	if (DamageMeters_Quantity_TIME == DamageMeters_quantity) then
		return GetTime() - playerStruct.lastTime;
	else
		local quantDef = DM_QUANTDEFS[quantity];

		local value = 0;
		if (nil ~= playerStruct) then
			if (nil ~= quantDef.pfnGetValue) then
				value = quantDef.pfnGetValue(playerStruct);
			else
				value = playerStruct.q[quantDef.dmi];
			end

			if (DamageMeters_IsQuantityPS(quantity)) then
				value = DamageMeters_GetCombatValuePS(value);
			end
		end

		return value;
	end
end

-- This is a slow function.  Not used much, I think.
function DamageMeters_GetQuantityValueString(quantity, playerName)

	local quantDef = DM_QUANTDEFS[quantity];
	local tableIndex;
	if (quantDef.bUsesFightTable) then
		tableIndex = DMT_FIGHT;
	else
		tableIndex = DMT_ACTIVE;
	end

	local playerIndex = DamageMeters_GetPlayerIndex(playerName, tableIndex);
	if (playerIndex ~= nil) then
		local value = DamageMeters_GetQuantityValue(quantity, tableIndex, playerIndex);
		
		local formatString;
		if (quantDef.formatString) then
			formatString = quantDef.formatString;
		else
			if (DamageMeters_IsQuantityPS(quantity)) then
				formatString = "%0.1f";
			else
				formatString = "%d";
			end
		end

		return string.format(formatString, value);
	else
		return "-";
	end
end

function DamageMeters_GetQuantityString(quantity, forcePSFlag)
	if (DamageMeters_IsQuantityPS(quantity, forcePSFlag)) then
		return DM_QUANTDEFS[quantity].psName;
	end

	return DM_QUANTDEFS[quantity].name;
end

function DamageMeters_GetPlayerIndex(player, searchTableIndex)
	local searchTable;
	if (nil == searchTableIndex) then
		searchTable = DamageMeters_tables[DMT_ACTIVE];
	else
		searchTable = DamageMeters_tables[searchTableIndex];
	end

	local i;
	for i = 1, table.getn(searchTable) do
		if (searchTable[i].player == player) then
			return i;
		end
	end
	
	return nil;
end

DMSortTemp_sortType = 1;
DMSortTemp_quantity = 1;
DMSortTemp_dmi = 1;

-- This could be broken into two separate increasing/decreasing functions
-- for increased performance.
function DMSortFunc_Default(a,b) 	
	local result;
	if (a.q[DMSortTemp_dmi] == b.q[DMSortTemp_dmi]) then
		if (DMSortTemp_sortType == DamageMeters_Sort_INCREASING) then
			result = a.player > b.player;
		else
			result = a.player < b.player;
		end
	else
		if (DMSortTemp_sortType == DamageMeters_Sort_INCREASING) then
			result = a.q[DMSortTemp_dmi] < b.q[DMSortTemp_dmi];
		else
			result = a.q[DMSortTemp_dmi] > b.q[DMSortTemp_dmi];
		end
	end

	return result;
end

function DMSortFunc_Alphabetical(a, b)
	return a.player < b.player;
end

function DMSortFunc_Time(a, b)
	local result;
	if (a.lastTime == b.lastTime) then
		result = a.player < b.player;
	else
		result = a.lastTime < b.lastTime;
	end

	if (DMSortTemp_sortType == DamageMeters_Sort_INCREASING) then
		result = not result;
	end
	return result;
end

function DMSortFunc_Custom(a, b)
	local valfunc = DM_QUANTDEFS[DMSortTemp_quantity].pfnGetValue;
	local aValue = valfunc(a);
	local bValue = valfunc(b);
	local result;
	if (aValue == bValue) then
		if (DMSortTemp_sortType == DamageMeters_Sort_INCREASING) then
			result = a.player > b.player;
		else
			result = a.player < b.player;
		end
	else
		if (DMSortTemp_sortType == DamageMeters_Sort_INCREASING) then
			result = aValue < bValue;
		else
			result = aValue > bValue;
		end
	end

	return result;
end

-- In the case of a tie, sort alphabetically.
function DamageMeters_DoSort(tableToSort, quantity, sortType)
	if (nil == sortType) then
		sortType = DamageMeters_sort;
	end
	DMSortTemp_sortType = sortType;
	DMSortTemp_quantity = quantity;
	DMSortTemp_dmi = DM_QUANTDEFS[quantity].dmi;

	if (DamageMeters_Sort_ALPHABETICAL == sortType) then
		table.sort(tableToSort, DMSortFunc_Alphabetical);
		return;
	end

	if (quantity == DamageMeters_Quantity_TIME) then
		table.sort(tableToSort, DMSortFunc_Time);
		return;
	elseif (DM_QUANTDEFS[quantity].pfnGetValue ~= nil) then
		table.sort(tableToSort, DMSortFunc_Custom);
		return;
	else
		DMSortTemp_quantity = DamageMeters_GetQuantityDMI(quantity);
		table.sort(tableToSort, DMSortFunc_Default);
		return;
	end
end

-- No reason to believe this doesn't work but it has never been used.
--[[
function DamageMeters_BuildSortHash(sortType)
	DamageMeters_tableSortHash = {};

	-- Build the unsorted hash.
	local quant;
	for quant = 1, DamageMeters_Quantity_MAX do
		DamageMeters_tableSortHash[quant] = {};

		local quantTable = (DM_QUANTDEFS[quant].bUsesFightTable) and DMT_FIGHT or DMT_ACTIVE;

		-- Populate the table for this quantity.
		local playerIndex;
		for playerIndex = 1, table.getn(DamageMeters_tables[quantTable]) do
			DamageMeters_tableSortHash[quant][playerIndex] = {};
			DamageMeters_tableSortHash[quant][playerIndex].playerName = DamageMeters_tables[quantTable][playerIndex].player;
			DamageMeters_tableSortHash[quant][playerIndex].playerIndex = playerIndex;
			DamageMeters_tableSortHash[quant][playerIndex].value = DamageMeters_GetQuantityValue(quant, quantTable, playerIndex);
		end

		-- Sort this quantity.
		table.sort(DamageMeters_tableSortHash[quant],
			function(a,b)
				if (a.value == b.value or DamageMeters_Sort_ALPHABETICAL == sortType) then
					return a.playerName < b.playerName;
				elseif (DamageMeters_Sort_INCREASING == sortType) then
					return a.value > b.value;
				else -- DamageMeters_Sort_DECREASING implied.
					return a.value < b.value;
				end
			end	
			);
	end
end
]]--

-- The bRankQuantities parameter is a hack.  Its only used by TitanDamageMeters.lua.
-- It will only work as expected if the tableIx isn't DMT_FIGHT already.
-- If true, this function will determine the ranks of -quantities-, not DMIs.
function DamageMeters_DetermineRanks(tableIx, bRankQuantities)

	local fakeTable = {};
	for index, struct in DamageMeters_tables[tableIx] do
		fakeTable[index] = {};
		fakeTable[index].player = struct.player;
		fakeTable[index].lastTime = struct.lastTime;
		fakeTable[index].q = {};
		for dmi, info in struct.q do
			fakeTable[index].q[dmi] = info;
		end
	end

	local fakeTablePS = {};
	if (bRankQuantities) then
		for index, struct in DamageMeters_tables[DMT_FIGHT] do
			fakeTablePS[index] = {};
			fakeTablePS[index].player = struct.player;
			fakeTablePS[index].lastTime = struct.lastTime;
			fakeTablePS[index].q = {};
			for dmi, info in struct.q do
				fakeTablePS[index].q[dmi] = info;
			end
		end
	end

	-----------

	local count = table.getn(DamageMeters_tables[tableIx]);
	local countPS = table.getn(DamageMeters_tables[DMT_FIGHT]);

	DamageMeters_rankTable = {};

	local quantity;
	local max = bRankQuantities and DamageMeters_Quantity_MAX or DMI_MAX;
	for quantity = 1, max do
		local fakeTableToUse;
		local countToUse;
		if (DamageMeters_IsQuantityPS(quantity)) then
			fakeTableToUse = fakeTablePS;
			countToUse = countPS;
		else
			fakeTableToUse = fakeTable;
			countToUse = count;
		end
		DamageMeters_DoSort(fakeTableToUse, quantity, DamageMeters_Sort_DECREASING);

		local index;
		for index = 1, countToUse do
			local playerName = fakeTableToUse[index].player;
			if (DamageMeters_rankTable[playerName] == nil) then
				DamageMeters_rankTable[playerName] = {};
			end	
			DamageMeters_rankTable[playerName][quantity] = index;
		end
	end
end

function DamageMeters_DetermineTotals()
	DamageMeters_totalsTable = {};
	DamageMeters_DetermineTotalsForATable(DMT_ACTIVE);	
	DamageMeters_DetermineTotalsForATable(DMT_FIGHT);	
end

function DamageMeters_DetermineTotalsForATable(tableIx)
	DamageMeters_totalsTable[tableIx] = {};
	local dmi;
	for dmi = 1, DMI_MAX do
		DamageMeters_totalsTable[tableIx][dmi] = 0;
	end

	local index, info;
	for index,info in DamageMeters_tables[tableIx] do 
		for dmi = 1, DMI_MAX do
			DamageMeters_totalsTable[tableIx][dmi] = DamageMeters_totalsTable[tableIx][dmi] + info.q[dmi];
		end
	end
end

function DamageMeters_DoReport(reportQuantity, destination, invert, start, count, tellTarget)
	local msg;

	if (destination == "BUFFER") then
		DamageMeters_reportBuffer = "";
	elseif (destination == "PARTY") then
		if (GetNumPartyMembers() == 0) then
			DMPrint(DM_ERROR_NOPARTY);
			return;
		end
	elseif (destination == "RAID") then
		if (GetNumRaidMembers() == 0) then
			DMPrint(DM_ERROR_NORAID);
			return;
		end
	end

	local tableIx = DMT_ACTIVE;
	if (DamageMeters_IsQuantityFight(reportQuantity)) then
		tableIx = DMT_FIGHT;
	end

	-- Determine bounds.
	local finish = start + count - 1;
	if (finish > table.getn(DamageMeters_tables[tableIx])) then
		finish = table.getn(DamageMeters_tables[tableIx]);
	end

	local step = 1;
	if (invert) then
		start = finish;
		finish = 1;
		step = -1;
	end

	------------
	-- Header --
	------------
	if (reportQuantity == DamageMeters_ReportQuantity_Total) then
		msg = string.format(DM_MSG_FULLREPORTHEADER, count, table.getn(DamageMeters_tables[tableIx]));
	elseif (reportQuantity == DamageMeters_ReportQuantity_Leaders) then
		local header = string.format(DM_MSG_LEADERREPORTHEADER, count, table.getn(DamageMeters_tables[tableIx]));
		local q;
		for q = 1, DMI_REPORT_MAX do
			header = string.format("%s| %-21s", header, DM_QUANTDEFS[q].name);
		end
		msg = header.."\n-------------------------------------------------------------------------------------------";
	elseif (reportQuantity == DamageMeters_ReportQuantity_Events) then
		msg = string.format(DM_MSG_EVENTREPORTHEADER, count, table.getn(DamageMeters_tables[tableIx]));
	else
		msg = string.format(DM_MSG_REPORTHEADER, DamageMeters_GetQuantityString(reportQuantity), count, table.getn(DamageMeters_tables[tableIx]));
	end
	DamageMeters_SendReportMsg(msg, destination, tellTarget);

	if (reportQuantity > 0) then
		DamageMeters_DoSort(DamageMeters_tables[tableIx], reportQuantity);
	end

	local reportQuantityDMI = nil;
	if (reportQuantity > 0) then
		reportQuantityDMI = DamageMeters_GetQuantityDMI(reportQuantity);
	end

	-- Calculate totals.
	local totalValue = 0;
	local index;
	local info;
	local totals = {0, 0, 0, 0, 0, 0};
	if (reportQuantity > 0) then
		if (DamageMeters_Quantity_TIME ~= reportQuantity) then
			local playerIndex;
			for playerIndex = 1, table.getn(DamageMeters_tables[tableIx]) do 
				totalValue = totalValue + DamageMeters_GetQuantityValue(reportQuantity, tableIx, playerIndex);
			end
		end
	elseif (reportQuantity == DamageMeters_ReportQuantity_Total or
			reportQuantity == DamageMeters_ReportQuantity_Leaders) then
		for index,info in DamageMeters_tables[tableIx] do 
			totals[1] = totals[1] + info.q[DMI_1];
			totals[2] = totals[2] + info.q[DMI_2];
			totals[3] = totals[3] + info.q[DMI_3];
			totals[4] = totals[4] + info.q[DMI_4];
			totals[5] = totals[5] + info.hitCount[DMI_DAMAGE];
			totals[6] = totals[6] + info.critCount[DMI_DAMAGE];
		end

		DamageMeters_DetermineRanks(tableIx);
	end


	---------------
	-- Main Loop --
	---------------
	local formatStrTotalMain_A = "%-12s %7d[%2d] %7d[%2d] %7d[%2d] %7d[%2d] %7d %7d";
	local formatStrTotalTotals = "%-12s %11d %11d %11d %11d %7d %7d";
	-- Careful here--if there isn't a space after each | it can lock up.
	local formatStrTotalMain_B = "%2d| %8d %-12s| %8d %-12s| %8d %-12s| %8d %-12s";
	local formatStrLeaderTotals= " =| %-20d | %-20d | %-20d | %-20d";
	local currentTime = GetTime();
	local i;
	local showThis;
	local visibleTotal = 0;
	--DMPrintD("start = "..start..", finish = "..finish..", quantity = "..reportQuantity);
	if (count > 0) then
		for i = start, finish, step do
			local value;
			msg = "";

			if (reportQuantity == DamageMeters_ReportQuantity_Total) then
				msg = string.format(formatStrTotalMain_A, DamageMeters_tables[tableIx][i].player, 
						DamageMeters_tables[tableIx][i].q[DMI_1], DamageMeters_rankTable[DamageMeters_tables[tableIx][i].player][1], 
						DamageMeters_tables[tableIx][i].q[DMI_2], DamageMeters_rankTable[DamageMeters_tables[tableIx][i].player][2], 
						DamageMeters_tables[tableIx][i].q[DMI_3], DamageMeters_rankTable[DamageMeters_tables[tableIx][i].player][3], 
						DamageMeters_tables[tableIx][i].q[DMI_4], DamageMeters_rankTable[DamageMeters_tables[tableIx][i].player][4], 
						DamageMeters_tables[tableIx][i].hitCount[DMI_DAMAGE], DamageMeters_tables[tableIx][i].critCount[DMI_DAMAGE]);
			elseif(reportQuantity == DamageMeters_ReportQuantity_Leaders) then
				local leaders = {};
				local leaderIndexes = {};
				local qIx;
				for qIx = 2, DMI_MAX do
					local leaderName, rank;
					for leaderName, rank in DamageMeters_rankTable do
						--DMPrint(i.." "..leaderName.." "..rank[qIx]);
						if (rank[qIx] == i) then
							leaders[qIx] = leaderName;
							leaderIndexes[qIx] = DamageMeters_GetPlayerIndex(leaderName);
							break;
						end
					end
				end

				msg = string.format(formatStrTotalMain_B, i, 
						DamageMeters_tables[tableIx][i].q[DMI_1], DamageMeters_tables[tableIx][i].player,	
						DamageMeters_tables[tableIx][leaderIndexes[2]].q[DMI_2], leaders[2], 
						DamageMeters_tables[tableIx][leaderIndexes[3]].q[DMI_3], leaders[3], 
						DamageMeters_tables[tableIx][leaderIndexes[4]].q[DMI_4], leaders[4]); 
			elseif (reportQuantity == DamageMeters_ReportQuantity_Events) then
				DamageMeters_DumpPlayerEvents(DamageMeters_tables[tableIx][i].player, destination, true, i, totals);
			else
				if (DamageMeters_Quantity_TIME == reportQuantity) then
					local idleTime = currentTime - DamageMeters_tables[tableIx][i].lastTime;
					msg = string.format("#%.2d: %-16s  %d:%.02d", i, DamageMeters_tables[tableIx][i].player, idleTime / 60, math.mod(idleTime, 60));
				else
					local value = DamageMeters_GetQuantityValue(reportQuantity, tableIx, i);
					if (value > 0) then
						visibleTotal = visibleTotal + value;
						if (DamageMeters_IsQuantityPS(reportQuantity)) then
							msg = string.format("#%.2d: %-16s  %.1f", i, DamageMeters_tables[tableIx][i].player, value);
						else
							local percentage = (totalValue > 0) and (100 * value / totalValue) or 0;
							msg = string.format("#%.2d:  %.2f%%  %-16s  %d", i, percentage, DamageMeters_tables[tableIx][i].player, value);
						end
					end
				end
			end
			
			if (msg ~= "") then
				DamageMeters_SendReportMsg(msg, destination, tellTarget);
			end
		end
	end

	------------
	-- Totals --
	------------
	if (reportQuantity == DamageMeters_ReportQuantity_Total or
		reportQuantity == DamageMeters_ReportQuantity_Leaders) then

		if (reportQuantity == DamageMeters_ReportQuantity_Total) then
			msg = string.format(formatStrTotalTotals, DM_MSG_TOTAL, totals[1], totals[2], totals[3], totals[4], totals[5], totals[6]);
		else
			msg = string.format(formatStrLeaderTotals, totals[1], totals[2], totals[3], totals[4], totals[5], totals[6]);
		end
		DamageMeters_SendReportMsg(msg, destination, tellTarget);

		-- Print a list of contributors.
		if (DamageMeters_flags[DMFLAG_haveContributors]) then
			msg = string.format(DM_MSG_COLLECTORS, UnitName("Player"));
			for contrib, unused in DamageMeters_contributorList do
				msg = msg..", "..contrib;
			end
			DamageMeters_SendReportMsg(msg, destination, tellTarget);
		end
	elseif (DamageMeters_Quantity_DPS == reportQuantity) then
		msg = string.format(DM_MSG_COMBATDURATION, DamageMeters_combatEndTime - DamageMeters_combatStartTime);
		DamageMeters_SendReportMsg(msg, destination, tellTarget);
	end

	if (reportQuantity > 0) then
		if (DamageMeters_Quantity_TIME == reportQuantity) then
			-- No total.
		elseif (DamageMeters_Quantity_DPS == reportQuantity) then
			msg = string.format(DM_MSG_REPORTTOTALDPS, totalValue, visibleTotal);
			DamageMeters_SendReportMsg(msg, destination, tellTarget);
		else
			msg = string.format(DM_MSG_REPORTTOTAL, totalValue, visibleTotal);
			DamageMeters_SendReportMsg(msg, destination, tellTarget);
		end
	end
end

function DamageMeters_DumpPlayerEvents(player, destination, bIncludeName, index, totals, singleQuantity)
	local tellTarget = nil;

	local playerIndex = DamageMeters_GetPlayerIndex(player, DMT_VISIBLE);
	local playerEventStruct = DamageMeters_tables[DMT_VISIBLE][playerIndex].events;
	if (nil == playerEventStruct) then
		-- Makes spam.
		--DMPrintD("Player "..player.." not found.", nil, true);
		return;
	end

	local prefix = "";
	if (bIncludeName) then
		if (index) then
			str = index..": "..player..":";
		else
			str = player..":";
		end
		prefix = "  ";
		DamageMeters_SendReportMsg(str, destination, tellTarget);
	end

	if (totals == nil) then
		totals = {};
		local ii;
		for ii = 1, table.getn(DamageMeters_tables[DMT_VISIBLE]) do
			local q;
			for q = 1, DMI_MAX do
				if (totals[q] == nil) then
					totals[q] = 0;
				end
				totals[q] = totals[q] + DamageMeters_tables[DMT_VISIBLE][ii].q[q];
			end
		end
	end

	if (DamageMeters_debugEnabled) then
		if (playerIndex and DamageMeters_tables[DMT_VISIBLE][playerIndex].firstMsg and DamageMeters_tables[DMT_VISIBLE][playerIndex].firstMsg["event"]) then
			local msg = "Last message: "..DamageMeters_tables[DMT_VISIBLE][playerIndex].firstMsg.event.." ("..DamageMeters_tables[DMT_VISIBLE][playerIndex].firstMsg.desc..")";
			DamageMeters_SendReportMsg(msg, destination, tellTarget);
			msg = "  "..DamageMeters_tables[DMT_VISIBLE][playerIndex].firstMsg.fullMsg.."\n";
			DamageMeters_SendReportMsg(msg, destination, tellTarget);
		end
	end

	local headerDest = destination;
	if (headerDest == "TOOLTIP") then
		headerDest = "TOOLTIP_TITLE";
	end

	local dmi, quantityStruct;
	if (singleQuantity) then
		dmi = DM_QUANTDEFS[singleQuantity].dmi;
		quantityStruct = playerEventStruct[dmi];
		if (quantityStruct) then
			DamageMeters_DumpQuantityEvents(dmi, quantityStruct, totals, headerDest, destination, tellTarget, prefix);
		end
	else
		for dmi, quantityStruct in playerEventStruct do
			DamageMeters_DumpQuantityEvents(dmi, quantityStruct, totals, headerDest, destination, tellTarget, prefix);
		end
	end

	DamageMeters_SendReportMsg("", destination, tellTarget);
end

function DamageMeters_DumpQuantityEvents(dmi, quantityStruct, totals, headerDest, destination, tellTarget, prefix)
	-- Calculate total.
	local total = 0;
	for spell, spellStruct in quantityStruct.spellTable do
		-- Spells with "*" at the end are duplicates, and are not to be counted towards the total.
		if (string.sub(spell, -1) ~= "*") then
			total = total + spellStruct.value;
		end
	end
	local percentageOfTotal = (totals[dmi] > 0) and (100 * total / totals[dmi]) or (0);
	str = string.format("%s = %s (%.1f%%)", prefix..DMI_NAMES[dmi], total, percentageOfTotal);
	DamageMeters_SendReportMsg(str, headerDest, tellTarget);

	-- Cannot sort spells, as that table is indexed by string.
	if (quantityStruct.dirty) then
		DamageMeters_BuildSpellHash(quantityStruct);
	end

	-- Print
	for hashIndex = 1, table.getn(quantityStruct.hash) do
		local spell = quantityStruct.hash[hashIndex].spell;
		spellStruct = quantityStruct.spellTable[spell];
		--DMPrint("Hash "..hashIndex.." = "..spell);

		local percentageOfTotal = (total > 0) and (100 * spellStruct.value / total) or (0);
		local critPercentage = (spellStruct.counts[DM_HIT] > 0) and (100 * spellStruct.counts[DM_CRIT] / spellStruct.counts[DM_HIT]) or 0.0;
		local average = string.format("%.1f Avg", (spellStruct.counts[DM_HIT] and spellStruct.value / spellStruct.counts[DM_HIT] or 0));

		str = string.format(prefix.."  %s = %d (%.1f%%)  %d/%d %.1f%% %s", spell, spellStruct.value, percentageOfTotal, spellStruct.counts[DM_CRIT], spellStruct.counts[DM_HIT], critPercentage, average);

		-- Show resistance info.
		if (dmi == DMI_DAMAGED and 
			(spellStruct.damageType <= DM_DMGTYPE_RESISTMAX or spellStruct.resistanceSum > 0)) then
			local avgResist = spellStruct.resistanceSum / spellStruct.resistanceCount;
			str = string.format("%s (%d %s)", str, avgResist, DM_DMGTYPENAMES[spellStruct.damageType]);
		end

		DamageMeters_SendReportMsg(str, destination, tellTarget);
	end
end

function DamageMeters_BuildSpellHash(quantityStruct)
	local hashIndex = 1;
	for spell, spellStruct in quantityStruct.spellTable do
		quantityStruct.hash[hashIndex] = {};
		quantityStruct.hash[hashIndex].spell = spell;
		quantityStruct.hash[hashIndex].value = spellStruct.value;
		hashIndex = hashIndex + 1;
	end

	table.sort(quantityStruct.hash, 
		function(a,b) 
			return a.value > b.value;
		end
		);

	quantityStruct.dirty = false;
end