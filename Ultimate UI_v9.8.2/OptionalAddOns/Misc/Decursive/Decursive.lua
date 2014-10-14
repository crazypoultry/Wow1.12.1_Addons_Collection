--TODO add mana check to the decursive... so it won't cast the spell if out of mana

-------------------------------------------------------------------------------
-- Debug commands
--
-- These are commands to change any of the default actions of Decursive.
-- Change these to customize how you want things. The purpose of these flags
-- is for mod developers to customize the behavour, or for confidant people
-- to muck with things
-------------------------------------------------------------------------------

-- this will spam... really only use it for testing
local Dcr_Print_Spell_Found = false;

-- turning this off will disable all status messages except error
local Dcr_Print_Anything    = true;

-- this will disable error messages
local Dcr_Print_Error       = true;

-- check for abolish XXX before curing poison or disease
local Dcr_Check_For_Abolish = true;

-- this is "fix" for the fact that rank 1 of dispell magic does not always remove
-- the high level debuffs properly. This carrys over to other things.
local Dcr_AlwaysUseBestSpell = true;

-- if nothign is cleaned... and we have an enemy selected... cast combat remove magic
local Dcr_CastDispellMagic  = false;

-- how many seconds... can be fractional... needs to be more than 0.4... 1.0 is optimal
local Dcr_SpellCombatDelay  = 1.0;

-- how many seconds to "black list" someone with a failed spell
local Dcr_CureBlacklist     = 3.0;

-- print out a fuckload of info
local Dcr_Print_DEBUG       = false;

-- should we do the orders randomly?
local Dcr_Random_Order      = false;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- here is the global variables, these should not be changed. These basically
-- are the limits of WoW client.
-------------------------------------------------------------------------------
DCR_MAXDEBUFFS = 16;
DCR_MAXBUFFS   = 16;
DCR_START_SLOT = 1;
DCR_END_SLOT   = 120;

-- this is something i use for remote debugging
DCR_DEBUG_STUFF = { };

-- then this is the priority list of people to cure
Dcr_PriorityList = { };


-------------------------------------------------------------------------------
-- and the printing functions
-------------------------------------------------------------------------------
function Dcr_debug( Message)
	if (Dcr_Print_DEBUG) then
		table.insert(DCR_DEBUG_STUFF, Message);
		DEFAULT_CHAT_FRAME:AddMessage(Message, 0.1, 0.1, 1);
	end
end

function Dcr_println( Message)
	if (Dcr_Print_Anything) then
		DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 1, 1);
	end
end

function Dcr_errln( Message)
	if (Dcr_Print_Error) then
		DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 0.1, 0.1);
	end
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- variables
-------------------------------------------------------------------------------
local Dcr_Range_Icons = {
};

local DCR_HAS_SPELLS = false;
local DCR_SPELL_MAGIC_1 = 0;
local DCR_SPELL_MAGIC_2 = 0;
local DCR_CAN_CURE_MAGIC = false;
local DCR_SPELL_ENEMY_MAGIC_1 = 0;
local DCR_SPELL_ENEMY_MAGIC_2 = 0;
local DCR_CAN_CURE_ENEMY_MAGIC = false;
local DCR_SPELL_DISEASE_1 = 0;
local DCR_SPELL_DISEASE_2 = 0;
local DCR_CAN_CURE_DISEASE = false;
local DCR_SPELL_POISON_1 = 0;
local DCR_SPELL_POISON_2 = 0;
local DCR_CAN_CURE_POISON = false;
local DCR_SPELL_CURSE = 0;
local DCR_CAN_CURE_CURSE = false;
local DCR_SPELL_COOLDOWN_CHECK = 0;

local Dcr_Casting_Spell_On = nil;
local Dcr_Blacklist_Array = { };

-------------------------------------------------------------------------------
-- configuration functions
-------------------------------------------------------------------------------
function Dcr_Init()
	-- Dcr_println(DCR_VERSION_STRING);

	Dcr_debug( "Registering the slash commands");
	-- Register our slash commands
	SLASH_DECURSIVE1 = DCR_MACRO_COMMAND;
	SlashCmdList["DECURSIVE"] = function(msg)
		Dcr_Clean();
	end
	SLASH_DECURSIVEADD1 = DCR_MACRO_ADD;
	SlashCmdList["DECURSIVEADD"] = function(msg)
		Dcr_AddTargetToPriorityList();
	end
	SLASH_DECURSIVECLEAR1 = DCR_MACRO_CLEAR;
	SlashCmdList["DECURSIVECLEAR"] = function(msg)
		Dcr_ClearPriorityList();
	end
	SLASH_DECURSIVELIST1 = DCR_MACRO_LIST;
	SlashCmdList["DECURSIVELIST"] = function(msg)
		Dcr_PrintPriorityList();
	end
	SLASH_DECURSIVESHOW1 = DCR_MACRO_SHOW;
	SlashCmdList["DECURSIVESHOW"] = function(msg)
		Dcr_ShowHidePriorityListUI();
	end

	Dcr_Configure();
end

function Dcr_ShowHidePriorityListUI()
	if (DecursivePriorityListFrame:IsVisible()) then
		DecursivePriorityListFrame:Hide();
	else
		DecursivePriorityListFrame:Show();
	end
end

function Dcr_AddTargetToPriorityList()
	Dcr_debug( "Adding the target to the priority list");
	if (UnitExists("target")) then
		if (UnitIsPlayer("target")) then
			local name = UnitName( "target");
			for _, pname in Dcr_PriorityList do
				if (name == pname) then
					return;
				end
			end
			table.insert(Dcr_PriorityList,name);
		end
	end
end

function Dcr_RemoveIDFromPriorityList(id)
	table.remove( Dcr_PriorityList,id);
end

function Dcr_ClearPriorityList()
	local i;
	local max = table.getn(Dcr_PriorityList);
	for i = 1, max do
		table.remove( Dcr_PriorityList);
	end
end

function Dcr_PrintPriorityList()
	for id, name in Dcr_PriorityList do
		Dcr_println( id.." - "..name);
	end
end


function Dcr_GetUnitArray()
	local Dcr_Unit_Array = { };
	-- create the array of curable units

	-- first... the priority list... names that go first!
	local pname;
	for _, pname in Dcr_PriorityList do
		local unit = Dcr_NameToUnit( pname);
		if (unit) then
			table.insert(Dcr_Unit_Array,unit);
		end
	end

	-- then everything else
	local i;
	local raidnum = GetNumRaidMembers();
	local temp_table = { };

	-- add your self
	table.insert(Dcr_Unit_Array, "player");

	-- add the party members... if they exist
	for i = 1, 4 do
		if (UnitExists("party"..i)) then
			if (Dcr_Random_Order) then
				table.insert(temp_table,"party"..i);
			else
				table.insert(Dcr_Unit_Array,"party"..i);
			end
		end
	end
	if (Dcr_Random_Order) then
		local temp_max = table.getn(temp_table);
		for i = 1, temp_max do
			table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
		end
	end

	-- add the raid IDs that are valid...
	-- add it from the sub group after yours... and then loop
	-- around to the group right before yours
	if ( raidnum > 0 ) then
		local currentGroup = 0;
		local name = UnitName( "player");

		for i = 1, raidnum do
			local rName, _, rGroup = GetRaidRosterInfo(i);
			if (rName == name) then
				currentGroup = rGroup;
				break;
			end
		end

		-- first the groups that are after yours
		for i = 1, raidnum do
			local _, _, rGroup = GetRaidRosterInfo(i);
			if (rGroup > currentGroup) then
				if (Dcr_Random_Order) then
					table.insert(temp_table,"raid"..i);
				else
					table.insert(Dcr_Unit_Array,"raid"..i);
				end
			end
		end
		-- the the ones that are before yours
		for i = 1, raidnum do
			local _, _, rGroup = GetRaidRosterInfo(i);
			if (rGroup < currentGroup) then
				if (Dcr_Random_Order) then
					table.insert(temp_table,"raid"..i);
				else
					table.insert(Dcr_Unit_Array,"raid"..i);
				end
			end
		end
		-- don't bother with your own group... since its also party 1-4

		if (Dcr_Random_Order) then
			local temp_max = table.getn(temp_table);
			for i = 1, temp_max do
				table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
			end
		end
	end

	-- now the pets

	-- your own pet
	if (UnitExists("pet")) then
		table.insert(Dcr_Unit_Array,"pet");
	end

	-- the perties pets if they have them
	for i = 1, 4 do
		if (UnitExists("partypet"..i)) then
			if (Dcr_Random_Order) then
				table.insert(temp_table,"partypet"..i);
			else
				table.insert(Dcr_Unit_Array,"partypet"..i);
			end
		end
	end
	if (Dcr_Random_Order) then
		local temp_max = table.getn(temp_table);
		for i = 1, temp_max do
			table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
		end
	end

	-- and then the raid pets if they are out
	-- don't worry about the fancier logic with the pets
	if ( raidnum > 0 ) then
		for i = 1, raidnum do
			if (UnitExists("raidpet"..i)) then
				if (Dcr_Random_Order) then
					table.insert(temp_table,"raidpet"..i);
				else
					table.insert(Dcr_Unit_Array,"raidpet"..i);
				end
			end
		end
		if (Dcr_Random_Order) then
			local temp_max = table.getn(temp_table);
			for i = 1, temp_max do
				table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
			end
		end
	end

	return Dcr_Unit_Array;
end

-- Raid/Party Name Check Function
-- this returns the UnitID that the Name points to
-- this does not check "target" or "mouseover"
function Dcr_NameToUnit( Name)
	if (not Name) then
		return false;
	elseif (Name == UnitName("player")) then
		return "player";
	elseif (Name == UnitName("pet")) then
		return "pet";
	elseif (Name == UnitName("party1")) then
		return "party1";
	elseif (Name == UnitName("party2")) then
		return "party2";
	elseif (Name == UnitName("party3")) then
		return "party3";
	elseif (Name == UnitName("party4")) then
		return "party4";
	elseif (Name == UnitName("partypet1")) then
		return "partypet1";
	elseif (Name == UnitName("partypet2")) then
		return "partypet2";
	elseif (Name == UnitName("partypet3")) then
		return "partypet3";
	elseif (Name == UnitName("partypet4")) then
		return "partypet4";
	else
		local numRaidMembers = GetNumRaidMembers();
		if (numRaidMembers > 0) then
			-- we are in a raid
			local i;
			for i=1, numRaidMembers do
				local RaidName = GetRaidRosterInfo(i);
				if ( Name == RaidName) then
					return "raid"..i;
				end
				if ( Name == UnitName("raidpet"..i)) then
					return "raidpet"..i;
				end
			end
		end
	end
	return false;
end

function Dcr_Configure()

	-- first empty out the old spellbook
	DCR_HAS_SPELLS = false;
	DCR_SPELL_MAGIC_1 = 0;
	DCR_SPELL_MAGIC_2 = 0;
	DCR_CAN_CURE_MAGIC = false;
	DCR_SPELL_ENEMY_MAGIC_1 = 0;
	DCR_SPELL_ENEMY_MAGIC_2 = 0;
	DCR_CAN_CURE_ENEMY_MAGIC = false;
	DCR_SPELL_DISEASE_1 = 0;
	DCR_SPELL_DISEASE_2 = 0;
	DCR_CAN_CURE_DISEASE = false;
	DCR_SPELL_POISON_1 = 0;
	DCR_SPELL_POISON_2 = 0;
	DCR_CAN_CURE_POISON = false;
	DCR_SPELL_CURSE = 0;
	DCR_CAN_CURE_CURSE = false;


	-- parse through the entire library...
	-- look for known cleaning spells...
	-- this will be called everytime the spellbook changes

	-- this is just used to make things simpler in the spellbook
	local Dcr_Name_Array = {
		[DCR_SPELL_CURE_DISEASE]        = true,
		[DCR_SPELL_ABOLISH_DISEASE]     = true,
		[DCR_SPELL_PURIFY]              = true,
		[DCR_SPELL_CLEANSE]             = true,
		[DCR_SPELL_DISPELL_MAGIC]       = true,
		[DCR_SPELL_CURE_POISON]         = true,
		[DCR_SPELL_ABOLISH_POISON]      = true,
		[DCR_SPELL_REMOVE_LESSER_CURSE] = true,
		[DCR_SPELL_REMOVE_CURSE]        = true,
		[DCR_SPELL_PURGE]               = true,
		[DCR_SPELL_WATER_BREATHING]     = true,
		[DCR_SPELL_SHADOW_BOLT]         = true,
	}

	local i = 1

	while (true) do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		if (not spellName) then
			do break end
		end

		Dcr_debug( "Checking for spell - "..spellName);

		if (Dcr_Name_Array[spellName]) then
			Dcr_debug( "Its one we care about");
			DCR_HAS_SPELLS = true;
			DCR_SPELL_COOLDOWN_CHECK = i;

			-- put it in the range icon array
			local icon = GetSpellTexture(i, BOOKTYPE_SPELL)
			Dcr_Range_Icons[icon] = spellName;

			-- print out the spell
			Dcr_debug( string.gsub(DCR_SPELL_FOUND, "$s", spellName));
			if (Dcr_Print_Spell_Found) then
		   		Dcr_println( string.gsub(DCR_SPELL_FOUND, "$s", spellName));
			end

			-- big ass if statement... due to the way that the different localizations work
			-- I used to do this more elegantly... but the german WoW broke it

			if ((spellName == DCR_SPELL_CURE_DISEASE) or (spellName == DCR_SPELL_ABOLISH_DISEASE) or
					(spellName == DCR_SPELL_PURIFY) or (spellName == DCR_SPELL_CLEANSE)) then
				DCR_CAN_CURE_DISEASE = true;
				if ((spellName == DCR_SPELL_CURE_DISEASE) or (spellName == DCR_SPELL_PURIFY)) then
					Dcr_debug( "Adding to disease 1");
					DCR_SPELL_DISEASE_1 = i;
				else
					Dcr_debug( "Adding to disease 2");
					DCR_SPELL_DISEASE_2 = i;
				end
			end
			
			if ((spellName == DCR_SPELL_CURE_POISON) or (spellName == DCR_SPELL_ABOLISH_POISON) or
					(spellName == DCR_SPELL_PURIFY) or (spellName == DCR_SPELL_CLEANSE)) then
				DCR_CAN_CURE_POISON = true;
				if ((spellName == DCR_SPELL_CURE_POISON) or (spellName == DCR_SPELL_PURIFY)) then
					Dcr_debug( "Adding to poison 1");
					DCR_SPELL_POISON_1 = i;
				else
					Dcr_debug( "Adding to poison 2");
					DCR_SPELL_POISON_2 = i;
				end
			end
			
			if ((spellName == DCR_SPELL_REMOVE_CURSE) or (spellName == DCR_SPELL_REMOVE_LESSER_CURSE)) then
				Dcr_debug( "Adding to curse");
				DCR_CAN_CURE_CURSE = true;
				DCR_SPELL_CURSE = i;
			end
			
			if ((spellName == DCR_SPELL_DISPELL_MAGIC) or (spellName == DCR_SPELL_CLEANSE)) then
				DCR_CAN_CURE_MAGIC = true;
				if (spellName == DCR_SPELL_CLEANSE) then
					Dcr_debug( "Adding to magic 1");
					DCR_SPELL_MAGIC_1 = i;
				else
					if (spellRank == DCR_SPELL_RANK_1) then
						Dcr_debug( "Adding to magic 1");
						DCR_SPELL_MAGIC_1 = i;
					else
						Dcr_debug( "adding to magic 2");
						DCR_SPELL_MAGIC_2 = i;
					end
				end
			end
			
			if ((spellName == DCR_SPELL_DISPELL_MAGIC) or (spellName == DCR_SPELL_PURGE)) then
				DCR_CAN_CURE_ENEMY_MAGIC = true;
				if (spellRank == DCR_SPELL_RANK_1) then
					Dcr_debug( "Adding to enemy magic 1");
					DCR_SPELL_ENEMY_MAGIC_1 = i;
				else
					Dcr_debug( "Adding to enemy magic 2");
					DCR_SPELL_ENEMY_MAGIC_2 = i;
				end
			end

		end

		i = i + 1
	end

end


-------------------------------------------------------------------------------
-- the combat saver functions and events. These keep us in combat mode
-------------------------------------------------------------------------------
local Dcr_CombatMode = false;
function Dcr_EnterCombat()
	Dcr_debug("Entering combat");
	Dcr_CombatMode = true;
end

function Dcr_LeaveCombat()
	Dcr_debug("Leaving combat");
	Dcr_CombatMode = false;
end


local Dcr_DelayTimer = 0;
function Dcr_OnUpdate(arg1)

	-- clean up the blacklist
	for unit in Dcr_Blacklist_Array do
		Dcr_Blacklist_Array[unit] = Dcr_Blacklist_Array[unit] - arg1;
		if (Dcr_Blacklist_Array[unit] < 0) then
			Dcr_Blacklist_Array[unit] = nil;
		end
	end

	-- wow the next command SPAMS alot
	-- Dcr_debug("got update "..arg1);

	-- this is the fix for the AttackTarget() bug
	if (Dcr_DelayTimer > 0) then
		Dcr_DelayTimer = Dcr_DelayTimer - arg1;
		if (Dcr_DelayTimer <= 0) then
			if (not Dcr_CombatMode) then
				Dcr_debug("trying to reset the combat mode");
				AttackTarget();
			else
				Dcr_debug("already in combat mode");
			end
		end;
	end
end

-------------------------------------------------------------------------------
-- Scanning functionalty... this scans the parties and groups
-------------------------------------------------------------------------------
function Dcr_Clean()
	-----------------------------------------------------------------------
	-- first we do the setup, make sure we can cast the spells
	-----------------------------------------------------------------------

	if (not DCR_HAS_SPELLS) then
	   	Dcr_errln(DCR_NO_SPELLS);
	   	return false;
	end

	local canCastSpell = false;

	local _, cooldown = GetSpellCooldown(DCR_SPELL_COOLDOWN_CHECK, SpellBookFrame.bookType)
	if (cooldown ~= 0) then
		-- this used to be an errline... changed it to debugg
		Dcr_debug(DCR_NO_SPELLS_RDY);
		return false;
	end

	-----------------------------------------------------------------------
	-----------------------------------------------------------------------
	-- then we see what our target looks like, if freindly, check them
	-----------------------------------------------------------------------

	local targetEnemy = false;
	local targetName = nil;
	local cleaned = false;
	local resetCombatMode = false;
	Dcr_Casting_Spell_On = nil;

	if (UnitExists("target")) then
		Dcr_debug("We have a target");
		-- if we are currently targeting something

		if (Dcr_CombatMode) then
			Dcr_debug("when done scanning... if switched target reset the mode!");
			resetCombatMode = true;
		end

		if (UnitIsFriend("target", "player")) then
			Dcr_debug(" It is friendly");

			-- try cleanign the current target first
			cleaned = Dcr_CureUnit("target");

			-- we are targeting a player, save the name to switch back later
			targetName = UnitName("target");

		else
			Dcr_debug(" It is not friendly");
			-- we are targeting an enemy... switch back when done
			targetEnemy = true;

			if ( UnitIsCharmed("target")) then
				Dcr_debug( "Unit is enemey... and charmed... so its a mind controlled friendly");
				-- try cleanign mind controlled person first
				cleaned = Dcr_CureUnit("target");
			end
		end
	end;

	-----------------------------------------------------------------------
	-----------------------------------------------------------------------
	-- now we check the partys (raid and local)
	-----------------------------------------------------------------------
	Dcr_debug( "Checking the arrays");

	-- this is the cleaning loops...
	local Dcr_Unit_Array = Dcr_GetUnitArray();
	-- the order is player, party1-4, raid, pet, partypet1-4, raidpet1-40
	-- the raid is current perty + 1 to 8... then 1 to current party - 1

	-- mind control first
	if( not cleaned) then
		Dcr_debug(" looking for mind controll");
		local _, class = UnitClass("player");
		if (DCR_CAN_CURE_ENEMY_MAGIC) then
			for _, unit in Dcr_Unit_Array do
				-- all of the units...
				if (not Dcr_Blacklist_Array[unit]) then
					-- if the unit is not black listed
					if (UnitIsVisible(unit)) then
						-- if the unit is even close by
						if (UnitIsCharmed(unit)) then
							-- if the unit is mind controlled
							if (Dcr_CureUnit(unit)) then
								cleaned = true;
								break;
							end
						end
					end
				end
			end
		end
	end

	-- normal cleaning
	if( not cleaned) then
		Dcr_debug(" normal loop");
		for _, unit in Dcr_Unit_Array do
			-- all of the units...
			if (not Dcr_Blacklist_Array[unit]) then
				-- if the unit is not black listed
				if (UnitIsVisible(unit)) then
					-- if the unit is even close by
					if (Dcr_CureUnit(unit)) then
						cleaned = true;
						break;
					end
				end
			end
		end
	end

	if ( not cleaned) then
		Dcr_debug(" double check the black list");
		for unit in Dcr_Blacklist_Array do
			-- now... all of the black listed units
			if (UnitExists(unit)) then
				-- if the unit still exists
				if (UnitIsVisible(unit)) then
					-- if the unit is even close by
					if (Dcr_CureUnit(unit)) then
						-- hey... we cleaned it... remove from the black list
						Dcr_Blacklist_Array[unit] = nil;
						cleaned = true;
						break;
					end
				end
			end
		end
	end

	-----------------------------------------------------------------------
	-----------------------------------------------------------------------
	-- ok... done with the cleaning... lets try to clean this up
	-- basically switch targets back if they were changed
	-----------------------------------------------------------------------

	if (targetEnemy) then
		-- we had somethign "bad" targeted
		if (not UnitIsEnemy("target", "player")) then
			-- and we scanned a pet, cast dispell magic, or some how broke target... switch back
			Dcr_debug("targeting enemy");
			TargetLastEnemy();
			if (resetCombatMode) then
				-- resetCombatMode is the fix
				Dcr_DelayTimer = Dcr_SpellCombatDelay;
				Dcr_debug("done... now we wait for the leave combat event");
			end
		end
		-- now that we are back on the enemy....
		-- lets see if we want to cast dispell magic if nothing was cleaned
		if (Dcr_CastDispellMagic and DCR_CAN_CURE_ENEMY_MAGIC and (not cleaned)) then
			Dcr_debug( "We are going to try to cast an offesnive spell on an enemy");
			if (not UnitIsFriend("target", "player")) then
				-- becasue neaturals can be attacked
				if (DCR_SPELL_ENEMY_MAGIC_1 ~= 0) then
					CastSpell(DCR_SPELL_ENEMY_MAGIC_1, SpellBookFrame.bookType);
				elseif (DCR_SPELL_ENEMY_MAGIC_2 ~= 0) then
					CastSpell(DCR_SPELL_ENEMY_MAGIC_2, SpellBookFrame.bookType);
				end
			end
		end

	elseif (targetName) then
		-- we had a freindly targeted... switch back if not still targeted
		if ( targetName ~= UnitName("target") ) then
			TargetByName(targetName);
		end
	else
		-- we had nobody targeted originally
		if (UnitExists("target")) then
			-- we checked for range
			ClearTarget();
		end
	end

	if (not cleaned) then
		Dcr_println( DCR_NOT_CLEANED);
	end

	return cleaned;
end



-------------------------------------------------------------------------------
-- these are the spells used to clean a "unit" given
-------------------------------------------------------------------------------
function Dcr_CureUnit(Unit)
	Dcr_debug( "Scanning for cure - "..Unit);

	local Magic_Count = 0;
	local Disease_Count = 0;
	local Poison_Count = 0;
	local Curse_Count = 0;
	local TClass, UClass = UnitClass(Unit);

	for i = 1, DCR_MAXDEBUFFS do
		local debuff_texture = UnitDebuff(Unit, i);

		if debuff_texture then

			Dcr_TooltipTextRight1:SetText(nil);
			Dcr_Tooltip:SetUnitDebuff(Unit, i);
			local debuff_type = Dcr_TooltipTextRight1:GetText();
			local debuff_name = Dcr_TooltipTextLeft1:GetText();

			Dcr_debug( debuff_name.." found!");

			if (DCR_IGNORELIST[debuff_name]) then
				-- these are the BAD ones... the ones that make the target immune... abort the user
		   		Dcr_debug( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
				return false;
			end

			if (DCR_SKIP_LIST[debuff_name]) then
				-- these are just ones you don't care about
				Dcr_debug( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
				break;
			end
			if (DCR_SKIP_BY_CLASS_LIST[UClass]) then
				if (DCR_SKIP_BY_CLASS_LIST[UClass][debuff_name]) then
					-- these are just ones you don't care about by class
					Dcr_debug( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
					break;
				end
			end

			if (debuff_type) then
				if (debuff_type == DCR_MAGIC) then
					Dcr_debug( "it's magic");
					Magic_Count = Magic_Count + 1;
				elseif (debuff_type == DCR_DISEASE) then
					Dcr_debug( "it's disease");
					Disease_Count = Disease_Count + 1;
				elseif (debuff_type == DCR_POISON) then
					Dcr_debug( "it's poison");
					Poison_Count = Poison_Count + 1;
				elseif (debuff_type == DCR_CURSE) then
					Dcr_debug( "it's curse");
					Curse_Count = Curse_Count + 1
				else
					Dcr_debug( "it's unknown - "..debuff_type);
				end
			else
				Dcr_debug( "it's untyped");
			end

		end
	end

	local res = false;
	-- order these in the way you find most important
	if (not res) then
		res = Dcr_Cure_Magic(Magic_Count, Unit);
	end
	if (not res) then
		res = Dcr_Cure_Curse( Curse_Count, Unit);
	end
	if (not res) then
		res = Dcr_Cure_Poison( Poison_Count, Unit);
	end
	if (not res) then
		res = Dcr_Cure_Disease( Disease_Count, Unit);
	end

	return res;
end

function Dcr_Cure_Magic(Magic_Count, Unit)
	Dcr_debug( "magic count "..Magic_Count);
	if (DCR_CAN_CURE_MAGIC) then
		Dcr_debug( "Can cure magic");
	end
	if (DCR_CAN_CURE_ENEMY_MAGIC) then
		Dcr_debug( "Can cure enemy magic");
	end
	
	if ( (not (DCR_CAN_CURE_MAGIC or DCR_CAN_CURE_ENEMY_MAGIC)) or (Magic_Count == 0) ) then
		-- here is no magical effects... or
		-- we can't cure magic don't bother going forward
		Dcr_debug( "no magic");
		return false;
	end
	Dcr_debug( "curing magic");

	if (UnitIsCharmed(Unit) and DCR_CAN_CURE_ENEMY_MAGIC) then
		-- unit is charmed... and has magic debuffs on them
		-- there is a good chance that it is the mind controll
		if (DCR_SPELL_ENEMY_MAGIC_2 ~= 0 ) and (Dcr_AlwaysUseBestSpell or (Magic_Count > 1)) then
			return Dcr_Cast_CureSpell( DCR_SPELL_ENEMY_MAGIC_2, Unit, DCR_CHARMED, true);
		else
			return Dcr_Cast_CureSpell( DCR_SPELL_ENEMY_MAGIC_1, Unit, DCR_CHARMED, true);
		end
	elseif (DCR_CAN_CURE_MAGIC) then
		if (DCR_SPELL_MAGIC_2 ~= 0 ) and (Dcr_AlwaysUseBestSpell or (Magic_Count > 1)) then
			return Dcr_Cast_CureSpell( DCR_SPELL_MAGIC_2, Unit, DCR_MAGIC, DCR_CAN_CURE_ENEMY_MAGIC);
		else
			return Dcr_Cast_CureSpell( DCR_SPELL_MAGIC_1, Unit, DCR_MAGIC, DCR_CAN_CURE_ENEMY_MAGIC);
		end
	end
	return false;
end

function Dcr_Cure_Curse( Curse_Count, Unit)
	if ( (not DCR_CAN_CURE_CURSE) or (Curse_Count == 0)) then
		-- no curses or no curse curing spells
		Dcr_debug( "no curse");
		return false;
	end
	Dcr_debug( "curing curse");

	if (UnitIsCharmed(Unit)) then
		-- we can not cure a mind contorolled player
		return;
	end

	if (DCR_SPELL_CURSE ~= 0) then
		return Dcr_Cast_CureSpell(DCR_SPELL_CURSE, Unit, DCR_CURSE, false);
	end
	return false;
end

function Dcr_Cure_Poison(Poison_Count, Unit)
	if ( (not DCR_CAN_CURE_POISON) or (Poison_Count == 0)) then
		-- here is no magical effects... or
		-- we can't cure magic don't bother going forward
		Dcr_debug( "no poison");
		return false;
	end
	Dcr_debug( "curing poison");

	if (UnitIsCharmed(Unit)) then
		-- we can not cure a mind contorolled player
		return;
	end

	if (Dcr_CheckUnitForBuff(Unit, DCR_SPELL_ABOLISH_POISON)) then
		return false;
	end

	if (DCR_SPELL_POISON_2 ~= 0 ) and (Dcr_AlwaysUseBestSpell or (Poison_Count > 1)) then
		return Dcr_Cast_CureSpell( DCR_SPELL_POISON_2, Unit, DCR_POISON, false);
	else
		return Dcr_Cast_CureSpell( DCR_SPELL_POISON_1, Unit, DCR_POISON, false);
	end
end

function Dcr_Cure_Disease(Disease_Count, Unit)
	if ( (not DCR_CAN_CURE_DISEASE) or (Disease_Count == 0)	) then
		-- here is no magical effects... or
		-- we can't cure magic don't bother going forward
		Dcr_debug( "no disease");
		return false;
	end
	Dcr_debug( "curing disease");

	if (UnitIsCharmed(Unit)) then
		-- we can not cure a mind contorolled player
		return;
	end

	if (Dcr_CheckUnitForBuff(Unit, DCR_SPELL_ABOLISH_DISEASE)) then
		return false;
	end

	if (DCR_SPELL_DISEASE_2 ~= 0 ) and (Dcr_AlwaysUseBestSpell or (Disease_Count > 1)) then
		return Dcr_Cast_CureSpell( DCR_SPELL_DISEASE_2, Unit, DCR_DISEASE, false);
	else
		return Dcr_Cast_CureSpell( DCR_SPELL_DISEASE_1, Unit, DCR_DISEASE, false);
	end
end

function Dcr_Cast_CureSpell( spellID, Unit, AfflictionType, ClearCurrentTarget)
	local name = UnitName(Unit);
	-- check to see if we are in range
	if (not Dcr_UnitInRange(Unit)) then
		Dcr_errln( string.gsub( string.gsub(DCR_OUT_OF_RANGE, "$t", name), "$a", AfflictionType));
		return false;
	end
	local spellName = GetSpellName(spellID, SpellBookFrame.bookType);
	Dcr_debug( "casting - "..spellName);

	-- clear the target if it will interfear
	if (ClearCurrentTarget) then
		-- it can target enemys... do don't target ANYTHING else
		if ( not UnitIsUnit( "target", Unit) ) then
			ClearTarget();
		end
	elseif ( UnitIsFriend( "player", "target") ) then
		-- we can accedenally cure friendly targets...
		if ( not UnitIsUnit( "target", Unit) ) then
			-- and we want to cure someone else who is not targeted
			ClearTarget();
		end
	end

	Dcr_Casting_Spell_On = Unit;
	Dcr_println( string.gsub( string.gsub( string.gsub(DCR_CLEAN_STRING, "$t", name), "$a", AfflictionType), "$s", spellName));
	CastSpell(spellID, SpellBookFrame.bookType);
	SpellTargetUnit(Unit);

	return true;
end


function Dcr_SpellCastFailed()
	if (Dcr_Casting_Spell_On) then
		Dcr_Blacklist_Array[Dcr_Casting_Spell_On] = Dcr_CureBlacklist;
	end
end

function Dcr_SpellWasCast()
	Dcr_Casting_Spell_On = nil;
end

function Dcr_CheckUnitForBuff(Unit, BuffName)
	if (Dcr_Check_For_Abolish) then
		for i = 1, DCR_MAXBUFFS do
			local buff_texture = UnitBuff(Unit, i);

			if buff_texture then

				Dcr_TooltipTextRight1:SetText(nil);
				Dcr_Tooltip:SetUnitBuff(Unit, i);

				if (Dcr_TooltipTextLeft1:GetText() == BuffName) then
					return true;
				end
			end
		end
	end
	return false;
end


-------------------------------------------------------------------------------
-- now the range functions....
-------------------------------------------------------------------------------
function Dcr_UnitInRange(Unit)
	-- this means that we are not even fraking close...
	-- don't bother going further
	if (not UnitIsVisible(Unit)) then
		return false;
	end

	local Dcr_Range_Slot = Dcr_FindCureingActionSlot(Dcr_Range_Icons);

	if (Dcr_Range_Slot ~= 0) then
		TargetUnit(Unit);
		if UnitIsUnit("target", Unit) then
			return (IsActionInRange(Dcr_Range_Slot) == 1);
		else
			return false; -- if we can't target... then its out of range
		end
	end

	-- we don't know... return true just in case
	return true;

end

function Dcr_FindCureingActionSlot( iconArray)
	local i = 0;
	for i = DCR_START_SLOT, DCR_END_SLOT do
		if (HasAction(i)) then
			icon = GetActionTexture(i);
			if (iconArray[icon]) then
				if (GetActionText(i) == nil) then
					local spellName = iconArray[icon];
					Dcr_Tooltip:ClearLines();
					Dcr_Tooltip:SetAction(i);
					local slotName = Dcr_TooltipTextLeft1:GetText();
					if (spellName == slotName) then
						return i;
					end
				end
			end
		end
	end
	return 0;
end

-------------------------------------------------------------------------------
-- the UI code
-------------------------------------------------------------------------------

function Dcr_PriorityListEntryTemplate_OnClick()
	local id = this:GetID();
	if (id) then
		Dcr_RemoveIDFromPriorityList(id);
	end
end

function Dcr_PriorityListEntryTemplate_OnUpdate()
	local baseName = this:GetName();
	local NameText = getglobal(baseName.."Name");

	local id = this:GetID();
	if (id) then
		local name = Dcr_PriorityList[id];
		if (name) then
    		NameText:SetText(id.." - "..name);
		else
    		NameText:SetText("Error - ID Invalid!");
		end
    else
    	NameText:SetText("Error - No ID!");
	end
end

function Dcr_PriorityListFrame_Update()
	local baseName = this:GetName();
	local up = getglobal(baseName.."Up");
	local down = getglobal(baseName.."Down");


	local size = table.getn(Dcr_PriorityList);

	if (size < 11 ) then
		this.Offset = 0;
		up:Hide();
		down:Hide();
	else
		if (this.Offset <= 0) then
			this.Offset = 0;
			up:Hide();
			down:Show();
		elseif (this.Offset >= (size - 10)) then
			this.Offset = (size - 10);
			up:Show();
			down:Hide();
		else
			up:Show();
			down:Show();
		end
	end

	local i;
	for i = 1, 10 do
		local id = ""..i;
		if (i < 10) then
			id = "0"..i;
		end
		local btn = getglobal(baseName.."Index"..id);

		btn:SetID( i + this.Offset);

		if (i <= size) then
			btn:Show();
		else
			btn:Hide();
		end
	end

end

function Dcr_DisplayTooltip( Message)
	DcrDisplay_Tooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	DcrDisplay_Tooltip:ClearLines();
	DcrDisplay_Tooltip:SetText(Message);
	DcrDisplay_Tooltip:Show();
end
