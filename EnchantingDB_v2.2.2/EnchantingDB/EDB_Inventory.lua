
-- Update the count for each reagent in a player's inventory.
function EDB_UpdateItemCountInBags()

	if ( not EDB_CSI ) then
		EDB_CSI = {};
	end

	if ( not EDB_CSI.reagent ) then
		EDB_CSI.reagent = {};
	end

	if ( not EDB_CSI.rod ) then
		EDB_CSI.rod = {};
	end

	local i, link;

	for i in EDB_Reagent do
		if ( not EDB_CSI.reagent[i] ) then
			EDB_CSI.reagent[i] = {};
		end
		EDB_CSI.reagent[i].bag = 0;
	end

	for i in EDB_Rod do
		if ( not EDB_CSI.rod[i] ) then
			EDB_CSI.rod[i] = {};
		end
		EDB_CSI.rod[i].bag = 0;
	end

	-- Check every inventory space.
	for bag = 0, 4 do
		local slots = GetContainerNumSlots(bag);
		for slot = 1, slots do
			local item = EDB_HItemFromLink(GetContainerItemLink(bag, slot));
			for i, link in EDB_Reagent do
				if ( item == EDB_HItemFromLink(link) ) then
					local _, count = GetContainerItemInfo(bag, slot);
					if count then EDB_CSI.reagent[i].bag = EDB_CSI.reagent[i].bag + count; end
				end
			end
			for i, link in EDB_Rod do
				if ( item == EDB_HItemFromLink(link) ) then
					local _, count = GetContainerItemInfo(bag, slot);
					if count then EDB_CSI.rod[i].bag = EDB_CSI.rod[i].bag + count; end
				end
			end
		end
	end

end

-- Update the count for each reagent in a player's bank.
function EDB_UpdateItemCountInBank(link)

	local i, link;

	if ( not EDB_CSI ) then
		EDB_CSI = {};
	end

	if ( not EDB_CSI.reagent ) then
		EDB_CSI.reagent = {};
	end

	if ( not EDB_CSI.rod ) then
		EDB_CSI.rod = {};
	end

	local numBankbags = GetNumBankSlots() + 4;

	for i in EDB_Reagent do
		if ( not EDB_CSI.reagent[i] ) then
			EDB_CSI.reagent[i] = {};
		end
		EDB_CSI.reagent[i].bank = 0;
	end

	for i in EDB_Rod do
		if ( not EDB_CSI.rod[i] ) then
			EDB_CSI.rod[i] = {};
		end
		EDB_CSI.rod[i].bank = 0;
	end

	-- Check every bank slot
	for bag = -1, numBankbags do
		if ( bag == 0 ) then bag = 5; end
		local slots = GetContainerNumSlots(bag);
		for slot = 1, slots do
			local item = EDB_HItemFromLink(GetContainerItemLink(bag, slot));
			for i, link in EDB_Reagent do
				if (item == EDB_HItemFromLink(link)) then
					local _, count = GetContainerItemInfo(bag, slot);
					if count then EDB_CSI.reagent[i].bank = EDB_CSI.reagent[i].bank + count; end
				end
			end
			for i, link in EDB_Rod do
				if (item == EDB_HItemFromLink(link) ) then
					local _, count = GetContainerItemInfo(bag, slot);
					if count then EDB_CSI.rod[i].bank = EDB_CSI.rod[i].bank + count; end
				end
			end
		end
	end

end

function EDB_ItemKeyFromLink(link)

	if ( not link ) then
		return;
	end

	for key in string.gfind(link, "|c%x+|Hitem:(%d+:%d+:%d+):%d+|h%[.-%]|h|r") do
		return key;
	end

end

function EDB_HItemFromLink(link)

	local hitem;

	if ( not link ) then
		return nil;
	end

	for hitem in string.gfind(link, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[.-%]|h|r") do
		return tonumber(hitem);
	end

	return nil;

end

function EDB_CodeFromLink(link)

	if ( not link ) then
		return nil;
	end

	local _, _, code = strfind(link, "(%d+:%d+:%d+:%d+)");

	local code = code and string.gsub(code, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:0");

	return code;

end

function EDB_NameFromLink(link)

	local name;

	if ( not link ) then
		return nil;
	end

	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end

	return nil;

end

function EDB_ColorFromLink(link)

	local color

	if ( not link ) then
		return nil;
	end

	for color in string.gfind(link, "|c(%x+)|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r") do
		return color;
	end
	
	return nil;
end
