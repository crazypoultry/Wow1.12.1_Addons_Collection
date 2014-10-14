--[[

	Spirit Versus Intellect (SVI) v1.11.0

	Compares the effectiveness of spirit, concentration, and intellect.
	
	By: Ted Vessenes

	Jun 19, 2006

]]--


--------------------------------------------------
--
-- Variable Declarations
--
--------------------------------------------------

-- Mod ID
SVI_ID = "SpiritVersusIntellect";
SVI_VERSION = "1.9.2";

-- Mana each point of intellect gives at base
SVI_MANA_PER_INT = 15;

-- Number of seconds that elapse between concentration ticks
SVI_CONCENTRATION_RATE = 5;

-- Number of seconds that elapse between spirit regen ticks
SVI_SPIRIT_RATE = 2;

-- Spirit stops regenerating mana for this many seconds after a spell cast
SVI_REGEN_PENALTY_TIME = 5;

-- This much spirit regenerates 1 mana per tick for most classes
SVI_SPIRIT_PER_MANA_DEFAULT = 5;

-- How much spirit regenerates 1 mana per tick for some classes
SVI_SPIRIT_PER_MANA = {
	["Priest"] = 4,
};

-- Resume recording the same session if the gap between recordings is
-- less than this many seconds
SVI_MAX_RESUME_DURATION = 12;

-- Wait this many seconds before doing another update, assuming
-- nothing interesting has changed
SVI_MIN_UPDATE_ELAPSED = 0.25;

-- A pattern that matches tooltip text describing what set an item belongs to
SVI_SEARCH_SET_NAME = "^(.*) %(%d/%d%)$";

-- The chat frame to output to
SVI_ChatFrame = ChatFrame1;

-- Variables saved between sessions
SVI_Saved = {	version,
		sound, };

-- Status variables
SVI_Stat = {	caster,
		regen_setup,
		recording,
		record_stop_time,
		spirit_per_mana	};

-- Variables used in processing
SVI_Tick = {	last_process,
		last_spellcast,
		autoshoot,
		cast_time_end,
		channel_time_start,
		ooc_mana_per_spirit,
		ooc_mana_per_concentration };

-- Variables used in output
SVI_Out = {	regen_rate = 1.0,		-- Percentage of mana regen currently active
		mana_per_int = SVI_MANA_PER_INT,-- Amount of mana each point of int provided
		mana_per_spirit = 0,		-- Amount of mana each point of spirit provided
		mana_per_concentration = 0,	-- Amount of mana each point of mana/5 provided
		int_per_spirit = 0,		-- One spirit equals this much intellect
		int_per_concentration = 0,	-- One mana/5 equals this much intellect
		spirit_per_concentration = nil,	-- One mana/5 equals this much spirit
		};

-- Handlers registered to display data from SVI
SVI_Displays = {
};

-- The player's current mana regeneration status
SVI_RegenStatus = {
	["Spirit"]	= 1.0,
	["Int"]		= 1.0,
	["Mana"]	= 1.0,
	["Regen"]	= 1.0,
	["CastRegen"]	= 0.0,
};

-- The modifications equipped items provide to regeneration
SVI_EquipRegenStatus = {
};

-- Current status of each buff/debuff aura
SVI_AuraStatus = {
};


--------------------------------------------------
--
-- Text Functions
--
--------------------------------------------------

-- Color code the inputted text using color values from 0 to 1
function SVI_ColorText(text, red, green, blue)
	return "|cff" .. format("%02x%02x%02x", red * 255, green * 255, blue * 255) ..
		text .. FONT_COLOR_CODE_CLOSE;
end

-- Color code the inputted text the white
function SVI_ColorTextWhite(text)
	return SVI_ColorText(text, 1, 1, 1);
end

-- Color code the inputted text the color for int
function SVI_ColorTextInt(text)
	return SVI_ColorText(text, .2, 1, 1);
end

-- Color code the inputted text the color for spirit
function SVI_ColorTextSpirit(text)
	return SVI_ColorText(text, .7, .2, 1);
end

-- Color code the inputted text the color for mana/5
function SVI_ColorTextMana(text)
	return SVI_ColorText(text, .2, 1, .2);
end

-- Print message
function SVI_Print(text)
	SVI_ChatFrame:AddMessage(text, 1.0, 1.0, 0.1);
end

-- Get the localization for a given message
function SVI_GetOutput(id)
	return SVI_OutputText[id] or id;
end


--------------------------------------------------
--
-- Utility Functions
--
--------------------------------------------------

-- Get the number of seconds between concentration ticks
function SVI_GetConcentrationRate()
	return SVI_CONCENTRATION_RATE;
end

-- Test if two times are close enough that the associated events probably happened concurrantly
function SVI_TimesClose(t1, t2)
	return (math.abs(t1-t2) < 0.1);
end


--------------------------------------------------
--
-- Aura Functions
--
--------------------------------------------------

-- Generate a string describing an aura's effect(s)
function SVI_AuraDescription(aura)
	local desc = "";

	-- Check each possible field
	for field, name in SVI_AuraStatText do

		-- Only add fields that exist
		if (aura[field] and aura[field] ~= 0) then
			-- Separate from the previous entry if necessary
			if (desc ~= "") then
				desc = desc .. ", ";
			end

			-- Add a + for positive numbers
			if (aura[field] > 0.0) then
				desc = desc .. "+";
			end

			-- Add the number as a percentage and qualify the units
			desc = desc .. (aura[field] * 100) .. "% " .. name;
		end

	end

	-- Describe non-auras
	if (desc == "") then
		desc = SVI_GetOutput("NoEffect");
	end

	-- Return the completed description
	return desc;
end

-- Print that an aura was detected
function SVI_AuraDetected(name, aura)
	SVI_Print(	"SVI: " .. name .. " " .. SVI_GetOutput("Detected") ..
			": " .. SVI_AuraDescription(aura)	);
end

-- Adds the effects of an aura on the inputted mana regeneration state
function SVI_AuraAdd(status, aura)
	-- Add each stat in the aura
	for stat, effect in aura do
		if (status[stat]) then
			status[stat] = status[stat] + effect;
		else
			status[stat] = effect;
		end
	end
end

-- Removes the effects of an aura on the inputted mana regeneration state
function SVI_AuraRemove(status, aura)
	-- Remove each stat in the aura
	for stat, effect in aura do
		if (status[stat]) then
			status[stat] = status[stat] - effect;
		else
			status[stat] = -effect;
		end
	end
end

-- Scales an aura by the inputted amount and returns the resulting aura
function SVI_AuraScale(aura, scale)

	-- Scale each entry in the aura
	local scaled_aura = {};
	for stat, effect in aura do
		scaled_aura[stat] = effect * scale;
	end

	-- Give the caller the scaled aura
	return scaled_aura;
end

-- Test if two auras are equivalent
function SVI_AurasEqual(aura1, aura2)

	-- Add one aura and subtract the other
	local difference = {};
	SVI_AuraAdd(difference, aura1);
	SVI_AuraRemove(difference, aura2);

	-- The auras are not equal if any field differs
	for stat, effect in difference do
		if (effect ~= 0) then
			return false;
		end	
	end

	-- The auras are equivalent
	return true;
end

-- Adds all auras in a table and returns their sum
function SVI_AurasSum(aura_table)

	-- Add each aura to the total
	local total = {};
	for _, aura in aura_table do
		SVI_AuraAdd(total, aura);
	end

	-- Give the caller the total of all auras
	return total;
end


--------------------------------------------------
--
-- Equipment Functions
--
--------------------------------------------------

-- Scans the player's current equipment for mana regen modifying auras.
-- Returns a table whose values are auras and keys are the name of the
-- item or set that provides the aura.
function SVI_EquipmentAuras()

	-- All possible slots for equipment
	local equip_slots = {
		"HeadSlot",
  		"NeckSlot",
  		"ShoulderSlot",
  		"ShirtSlot",
  		"ChestSlot",
  		"WaistSlot",
  		"LegsSlot",
  		"FeetSlot",
  		"WristSlot",
  		"HandsSlot",
  		"Finger0Slot",
  		"Finger1Slot",
  		"Trinket0Slot",
  		"Trinket1Slot",
  		"BackSlot",
  		"MainHandSlot",
  		"SecondaryHandSlot",
  		"RangedSlot",
  		"TabardSlot",
	};

	-- Make sure each item set text is only processed once
	local processed_sets = {};

	-- No auras from equipment have yet been found
	local equip_auras = {};

	-- Check each item slot in turn
	--
	-- NOTE: This function alone serves as an excellent example of why Lua
	-- should allow a "continue" statement in loops.  Remember, languages
	-- exist to serve the programmer, not the other way around.  Lua might
	-- think it's always cleaner to write code such that no premature returns
	-- or continues are necessary, but it is simply wrong.

	for _, slot in equip_slots do

		-- Test if the player has anything in that slot
		local id, _ = GetInventorySlotInfo(slot);
		SVI_Tooltip:Hide()
		SVI_Tooltip:SetOwner(this, "ANCHOR_LEFT");
		local equipped = SVI_Tooltip:SetInventoryItem("player", id);

		-- Process the equipment data if it exists
		if (equipped) then

			-- The first line is the equipped item's name
			local item_name = SVI_TooltipTextLeft1:GetText();

			-- It's unknown if this item belongs to a set
			local set_name = nil;

			-- Scan each other line in the item's tooltip for aura data
			local lines = SVI_Tooltip:NumLines();
			for line = 2, lines, 1 do

				-- Look up this line's text and process it
				line_var = getglobal("SVI_TooltipTextLeft" .. line);
				if (line_var) then

					-- Test if the line is an equip or set bonus
					local text = line_var:GetText();
					local equip = string.find(text, SVI_SEARCH_EQUIP);
					local set = set_name
						and not processed_sets[set_name] 
						and string.find(text, SVI_SEARCH_SET);

					-- Scan for equip or set effects for lines that describe them
					if (equip or set) then

						-- Check each item aura for a match
						for pattern, aura in SVI_ManaRegenEquip do

							-- Add auras for texts that match
							local _, _, value = string.find(text, pattern);
							if (value) then

								-- Make an aura for this item or set if necessary
								local aura_name = item_name;
								if (equip) then
									aura_name = item_name;
								else
									aura_name = set_name;
								end
								if (not equip_auras[aura_name]) then
									equip_auras[aura_name] = {};
								end

								-- Add this aura to the aura's total effect
								SVI_AuraAdd(equip_auras[aura_name],
									SVI_AuraScale(aura, value));
							end
						end

					-- Check for lines that assign the item to a set
					else
						local _, _, matched_set = string.find(text, SVI_SEARCH_SET_NAME);
						if (matched_set) then
							set_name = matched_set;
						end
					end
				end
			end
			
			-- If this item had a set, note that it was processed
			if (set_name) then
				processed_sets[set_name] = true;
			end
		end
	end
	SVI_Tooltip:Hide()

	-- Give the caller the completed table of items and sets that provide
	-- auras modifying the mana regeneration state
	return equip_auras;
end


--------------------------------------------------
--
-- Buff Functions
--
--------------------------------------------------

--  Returns true if the player has the named buff
function SVI_PlayerHasBuff(buff)

	-- Look for a buff if one was specified
	if ( buff ~= "" ) then
		local buffNum = 1;
		
		-- Loop through the buffs
		while ( UnitBuff("player", buffNum) ) do

			-- Initialize the tooltip
			SVI_TooltipTextLeft1:SetText("");
			SVI_Tooltip:SetUnitBuff("player", buffNum);
			
			-- Succeed if the player has the buff we're searching for
			if ( SVI_TooltipTextLeft1:GetText() == buff ) then
				return 1;
			end
			
			buffNum = buffNum + 1;
			
		end
	end

	-- The buff was not found
	return nil;
end

--  Returns true if the player has the named debuff
function SVI_PlayerHasDebuff(debuff)

	-- Look for a buff if one was specified
	if ( debuff ~= "" ) then
		local debuffNum = 1;
		
		-- Loop through the debuffs
		while ( UnitDebuff("player", debuffNum) ) do

			-- Initialize the tooltip
			SVI_TooltipTextLeft1:SetText("");
			SVI_Tooltip:SetUnitDebuff("player", debuffNum);
			
			-- Succeed if the player has the buff we're searching for
			if ( SVI_TooltipTextLeft1:GetText() == debuff ) then
				return 1;
			end
			
			debuffNum = debuffNum + 1;
			
		end
	end

	-- The buff was not found
	return nil;
end

--------------------------------------------------
--
-- Output Functions
--
--------------------------------------------------

-- Gets text descriptions of the mana regen rate and comparing mana, int, spirit, and concentration
function SVI_GetRegenText()

	-- Translate the "not applicable" message
	local na = SVI_GetOutput("NA")

	-- Non-casters have no descriptions
	if (not SVI_Stat.caster) then
		return	na, na, na, na, na, na, na;
	end

	-- Look up the regeneration rate
	local regen = format("%3i%% ", floor(SVI_Out.regen_rate * 100));

	-- Compare mana, intellect, spirit, and concentration
	local mpi = format("%.1f", SVI_Out.mana_per_int);
	local mps = format("%.1f", SVI_Out.mana_per_spirit);
	local ips = format("%.1f", SVI_Out.int_per_spirit);
	local mpc = format("%.1f", SVI_Out.mana_per_concentration);
	local ipc = format("%.1f", SVI_Out.int_per_concentration);
	local spc = na;
	if (SVI_Out.spirit_per_concentration) then
		spc = format("%.1f", SVI_Out.spirit_per_concentration);
	end

	-- Return these descriptions
	return	regen,
		mpi,
		mps, ips,
		mpc, ipc, spc;
end


--------------------------------------------------
--
-- Initialization Functions
--
--------------------------------------------------

-- Processed when the game loads
function SVI_OnLoad()

	-- Register for notification of these events
	this:RegisterEvent("VARIABLES_LOADED"); 
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_DELAYED");
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");

	-- Find out whether this player cares about mana	
	local _, player_class = UnitClass("player");  
	SVI_Stat.caster = (player_class ~= "ROGUE") and (player_class ~= "WARRIOR");
  
	-- Initialize data for casters
	if (SVI_Stat.caster) then
		
		-- Initialize Status Variables
		SVI_Stat.regen_setup = false;
		SVI_Stat.recording = false;
		SVI_Stat.record_stop_time = nil;
		SVI_Stat.spirit_per_mana = (SVI_SPIRIT_PER_MANA[player_class] or
						SVI_SPIRIT_PER_MANA_DEFAULT)
					* SVI_SPIRIT_RATE;

		-- Initialize Tick Variables
		SVI_Tick.last_process = GetTime();
		SVI_Tick.last_spellcast = 0.0;
		SVI_Tick.autoshoot = false;
		SVI_Tick.cast_time_end = nil;
		SVI_Tick.channel_time_start = nil;
		SVI_Tick.ooc_mana_per_spirit = 0;
		SVI_Tick.ooc_mana_per_concentration = 0;
	end

end

-- Initialize SVI after everything has been loaded
function SVI_Initialize()

	-- Initialize the saved variables if they need to be
	if (not SVI_Saved.version or SVI_Saved.version ~= SVI_VERSION) then

		SVI_Saved.version = SVI_VERSION;
		SVI_Saved.sound = true;
	end

end

-- Test if it's possible to setup the base regeneration state
function SVI_CanSetupRegen()

	-- It can take a while before talent data can be read.  Before the data
	-- is loaded, all talents are 0/0.  So if any talent has a max of 0 points,
	-- it's not safe to setup.  Just lookup the first talent in the first tree.
	local _, _, _, _, _, max_rank = GetTalentInfo(1, 1);
	if (max_rank and max_rank > 0) then
		return true;
	else
		return false;
	end
end

-- Detect the talents, racial abilities, and buffs that define the mana regeneration state
function SVI_DoSetupRegen()

	-- Start with the default regeneration state
	SVI_RegenStatus = {
		["Spirit"]	= 1.0,
		["Int"]		= 1.0,
		["Mana"]	= 1.0,
		["Regen"]	= 1.0,
		["CastRegen"]	= 0.0,
	};

	-- Apply any racial auras the player has
	-- NOTE: The race for undead will be "Scourge" not "Undead".
	local _, player_race = UnitRace("player");
	if (SVI_ManaRegenRacials[player_race]) then

		-- Add each racial aura and announce its detection
		for racial, aura in SVI_ManaRegenRacials[player_race] do
			SVI_AuraAdd(SVI_RegenStatus, aura)
			SVI_AuraDetected(racial, aura);
		end
	end

	-- Check for auras from talents the player has
	-- NOTE: The class name is fully capitalized.
	local _, player_class = UnitClass("player");
	if (SVI_ManaRegenTalents[player_class]) then

		-- Check each mana regen talent this class could have
		for talent_name, talent_data in SVI_ManaRegenTalents[player_class] do

			-- Find out how many points this player spent
			local _, _, _, _, cur_rank, max_rank =
				GetTalentInfo(talent_data["Tree"], talent_data["Talent"]);

			-- Scale the talent's aura by the number of points spent
			local talent_aura = SVI_AuraScale(talent_data["Aura"], cur_rank);

			-- Add the aura to the regeneration state
			SVI_AuraAdd(SVI_RegenStatus, talent_aura);

			-- Announce the detection of this aura
			SVI_AuraDetected(
				cur_rank .. "/" .. max_rank .. " " .. talent_name,
				talent_aura);
		end
	end

	-- Check for set bonuses that affect regeneration
	local equip_auras = SVI_EquipmentAuras();
	for aura_name, aura in equip_auras do
		SVI_AuraDetected(aura_name, aura);
	end

	-- Generate a composite aura from all equipment and add it to the regeneration state
	SVI_EquipRegenStatus = SVI_AurasSum(equip_auras);
	SVI_AuraAdd(SVI_RegenStatus, SVI_EquipRegenStatus);

	-- Check for buffs that modify spirit regeneration rates
	SVI_AuraStatus = {
	};
	for aura_name, aura_data in SVI_ManaRegenBuffs do

		-- Note whether the player has this aura
		SVI_AuraStatus[aura_name] = 
			SVI_PlayerHasBuff(aura_name) or SVI_PlayerHasDebuff(aura_name);

		-- Add this aura to the regeneration state if they do
		if (SVI_AuraStatus[aura_name]) then
			SVI_AuraAdd(SVI_RegenStatus, aura_data["Aura"])
			SVI_AuraDetected(aura_name, aura_data["Aura"]);
		end
	end

	-- Reset recorded data
	SVI_ResetRecordedData();

	-- The state is now setup
	SVI_Stat.regen_setup = true;

	-- Make these changes gets displayed
	SVI_PublishUpdate();

end

-- Setup the initial mana regeneration state if necessary
function SVI_SetupRegen()

	-- Only update the regeneration state if all variables have been loaded and
	-- the UI is loaded (meaning talent data is accessable), and if necessary
	if (	SVI_Stat.caster and
		not SVI_Stat.regen_setup and
		SVI_CanSetupRegen())
	then
		SVI_DoSetupRegen();
	end
end

-- Reset all data used in output
function SVI_ResetRecordedData()

	-- One intellect provides this much additional mana pool
	SVI_Out.mana_per_int = SVI_MANA_PER_INT * SVI_RegenStatus["Int"] * SVI_RegenStatus["Mana"];

	-- Spirit and concentration haven't provided anything useful yet
	SVI_Out.mana_per_spirit = 0.0;
	SVI_Out.mana_per_concentration = 0.0;
	SVI_Out.int_per_spirit = 0.0;
	SVI_Out.int_per_concentration = 0.0;
	SVI_Out.spirit_per_concentration = nil;

	-- Current mana regeneration rate is unknown but it's probably normal
	SVI_Out.regen_rate = 1.0;
end


--------------------------------------------------
--
-- Command/Control Functions
--
--------------------------------------------------

-- Toggles sound effects when mana regeneration buffs are detected
function SVI_ToggleSound()
	SVI_Saved.sound = not SVI_Saved.sound;
end

-- Manually starts and stops recording
function SVI_ToggleRecording()

	-- Only caster classes can activate recording
	if (SVI_Stat.caster) then

		-- Toggle the recording state and inform the user of the change
		if (SVI_Stat.recording) then
			SVI_StopRecording();
		else
			SVI_StartRecording();
		end
	end

end


--------------------------------------------------
--
-- Processing Functions
--
--------------------------------------------------

-- Starts recording data
function SVI_StartRecording()

	-- Update data since the last processing
	SVI_ProcessManaRegen();

	-- Start recording
	SVI_Stat.recording = true;

	-- Resume recording the same session if the break was small enough; otherwise
	-- reset the recording data
	if ( 	(SVI_Stat.record_stop_time) and
		(SVI_Tick.last_process - SVI_Stat.record_stop_time < SVI_MAX_RESUME_DURATION) ) then

		-- Apply the out of combat data to this recording session
		SVI_Out.mana_per_spirit = SVI_Out.mana_per_spirit + SVI_Tick.ooc_mana_per_spirit;
		SVI_Out.mana_per_concentration = SVI_Out.mana_per_concentration +
						SVI_Tick.ooc_mana_per_concentration;

		-- Account for these changes in the data that's outputted
		SVI_RecomputeOutput();

	else
		-- Reset recording data
		SVI_ResetRecordedData();

		-- Reset out of combat data		
		SVI_Tick.ooc_mana_per_spirit = 0;
		SVI_Tick.ooc_mana_per_concentration = 0;
	end

	-- Make these changes gets displayed
	SVI_PublishUpdate();

end

-- Stop the data recording and possibly output results
function SVI_StopRecording()

	-- Do the processing for mana regenerated from the last frame and now
	SVI_ProcessManaRegen();

	-- Remember when recording stopped
	SVI_Stat.recording = false;
	SVI_Stat.record_stop_time = GetTime();

end

-- Handle the gaining of an aura from a buff or debuff
function SVI_HandleAuraGained(aura_name, aura_data)

	-- Add the aura if the player doesn't yet have it
	if (not SVI_AuraStatus[aura_name]) then

		-- Remember that the player has this aura
		SVI_AuraStatus[aura_name] = true;

		-- Update the player's mana regeneration state
		SVI_AuraAdd(SVI_RegenStatus, aura_data["Aura"]);

		-- Remove any conflicting buffs that exist
		if (aura_data["ConflictingBuffs"]) then

			-- Try to remove each conflicting buff
			for conflict, _ in aura_data["ConflictingBuffs"] do
				SVI_HandleAuraLost(conflict, SVI_ManaRegenBuffs[conflict]);
			end
		end

		-- Notify the player if the aura data requests it
		if (aura_data["Sound"] and SVI_Saved.sound) then
			PlaySoundFile(aura_data["Sound"]);
		end

		-- Uncomment this line to announce the detection of auras at any time
		--SVI_AuraDetected(aura_name, aura_data["Aura"]);

	end

end

-- Handle the loss of an aura from a buff or debuff
function SVI_HandleAuraLost(aura_name, aura_data)

	-- Remove the aura if it hasn't been already
	if (SVI_AuraStatus[aura_name]) then

		-- The player no longer has the aura
		SVI_AuraStatus[aura_name] = false;

		-- Remove the aura
		SVI_AuraRemove(SVI_RegenStatus, aura_data["Aura"]);

	end

end

-- Recomputes the output values after the mana to int, spirit,
-- and concentration values have been updated.
function SVI_RecomputeOutput()

	-- Recompute the relative effectiveness of int, spirit, and concentration
	SVI_Out.int_per_spirit = SVI_Out.mana_per_spirit / SVI_Out.mana_per_int;
	SVI_Out.int_per_concentration = SVI_Out.mana_per_concentration / SVI_Out.mana_per_int;
	if (SVI_Out.mana_per_spirit > 0) then
		SVI_Out.spirit_per_concentration = SVI_Out.mana_per_concentration / SVI_Out.mana_per_spirit;
	else
		SVI_Out.spirit_per_concentration = nil;
	end
end

-- Account for the mana regenerated since the last processing
function SVI_ProcessManaRegen()

	-- Setup the base regeneration state if it hasn't been yet
	SVI_SetupRegen();

	-- Process the next frame of data if ready
	if (SVI_Stat.regen_setup) then

		-- This much time has elapsed since the last update
		local now = GetTime();
		local elapsed = now - SVI_Tick.last_process;

		-- Normal mana regeneration resumes at this time
		local normal_regen_start = SVI_Tick.last_spellcast + SVI_REGEN_PENALTY_TIME;

		-- Determine how much time the player spent in each mana regeneration state
		local low_time;
		if (now <= normal_regen_start) then
			low_time = elapsed;
		elseif (SVI_Tick.last_process >= normal_regen_start) then
			low_time = 0.0;
		else
			low_time = normal_regen_start - SVI_Tick.last_process;
		end
		local normal_time = elapsed - low_time;

		-- Compute the normal and low mana regeneration rates
		local normal_regen_rate = SVI_RegenStatus["Regen"];
		local low_regen_rate = normal_regen_rate * SVI_RegenStatus["CastRegen"];

		-- The regeneration rate while casting cannot excede non-casting regeneration
		if (low_regen_rate > normal_regen_rate) then
			low_regen_rate = normal_regen_rate;
		end

		-- Store the current regeneration rate to display
		if (normal_time > 0) then
			SVI_Out.regen_rate = normal_regen_rate;
		else
			SVI_Out.regen_rate = low_regen_rate;
		end		

		-- Each point of spirit regenerates this much mana per second under normal and low regen
		local normal_spirit_rate = SVI_RegenStatus["Spirit"] * normal_regen_rate / SVI_Stat.spirit_per_mana;
		local low_spirit_rate = SVI_RegenStatus["Spirit"] * low_regen_rate / SVI_Stat.spirit_per_mana;

		-- Account for the mana regenerated from spirit and concentration
		local extra_spirit_mana = normal_spirit_rate * normal_time + low_spirit_rate * low_time;
		local extra_concentration_mana = elapsed / SVI_CONCENTRATION_RATE;

		-- Cache the main gains when out of combat but update directly when recording
		if (SVI_Stat.recording) then

			-- Update these values
			SVI_Out.mana_per_spirit = SVI_Out.mana_per_spirit + extra_spirit_mana;
			SVI_Out.mana_per_concentration = SVI_Out.mana_per_concentration +
							extra_concentration_mana;

			-- Recompute the output data
			SVI_RecomputeOutput();
		else
			-- Save the values in case the player quickly reenters combat
			SVI_Tick.ooc_mana_per_spirit = SVI_Tick.ooc_mana_per_spirit + extra_spirit_mana;
			SVI_Tick.ooc_mana_per_concentration = SVI_Tick.ooc_mana_per_concentration +
							extra_concentration_mana;
		end

		-- Completed processing this frame
		SVI_Tick.last_process = now;

		-- Publish an update
		SVI_PublishUpdate();

	end
end

-- Handle a world update
function SVI_OnUpdate()

	-- Only casters update mana
	if (SVI_Stat.caster) then

		-- Account for mana regeneration since the last processing
		-- if enough time has elapsed
		if (GetTime() - SVI_Tick.last_process > SVI_MIN_UPDATE_ELAPSED) then
			SVI_ProcessManaRegen();
		end
	end
end


--------------------------------------------------
--
-- Display Plugin Functions
--
--------------------------------------------------


-- Register a function that handles display updates
function SVI_RegisterDisplay(id, registry)

	-- Only register properly configured handlers
	if (registry["UpdateHandler"]) then
		SVI_Displays[id] = registry;
	end
end

-- Remove a function that handles display updates
function SVI_UnregisterDisplay(id)
	SVI_Displays[id] = nil;
end

-- Publish a data update to display handlers
function SVI_PublishUpdate()

	-- Publish data to each display
	for _, registry in SVI_Displays do
		registry["UpdateHandler"]();
	end
end



--------------------------------------------------
--
-- Event Handling
--
--------------------------------------------------

-- Process the death of the player
function SVI_PlayerDead()

	-- Handle the regeneration before death
	SVI_ProcessManaRegen();

	-- Clear all auras
	for aura_name in SVI_AuraStatus do		
		SVI_HandleAuraLost(aura_name, SVI_ManaRegenBuffs[aura_name]);
	end
end

-- Handle a stopped spellcast that signifies an a successful spellcast
function SVI_RecordSpellcast(now)

	-- A spell was cast now
	SVI_Tick.last_spellcast = now;

	-- Update regeneration data now that regeneration rates have changed
	SVI_ProcessManaRegen();
end

-- Handle an event that says a spell stopped being casted
function SVI_SpellcastStop()

	-- It's this time right now
	local now = GetTime();

	-- Check for finished or interrupted casting of a non-instant spell
	if (SVI_Tick.cast_time_end) then

		-- Consider this a real spell cast if the spell stopped close
		-- to the spellcast finish time
		if (SVI_TimesClose(now, SVI_Tick.cast_time_end)) then
			SVI_RecordSpellcast(now);
		end

		-- No more spell cast is in progress
		SVI_Tick.cast_time_end = nil;

	-- Check for a stop event after the initial casting of a channeled spell
	elseif (SVI_Tick.channel_time_start and SVI_TimesClose(now, SVI_Tick.channel_time_start)) then
		SVI_RecordSpellcast(now);

	-- Only consider "spell casts" when not autoshooting
	elseif (not SVI_Tick.autoshoot) then

		-- If the player is channeling and they got a stop event, it just
		-- signifies the stop of the channeling, not a spell cast
		if (SVI_Tick.channel_time_start) then
			SVI_Tick.channel_time_start = nil;

		-- This was an instant spell cast
		else
			SVI_RecordSpellcast(now);
		end

	end

end

-- Handle the start of a non-instant spell cast
function SVI_SpellcastStart()
	-- Record the finish time of the spell being cast
	SVI_Tick.cast_time_end = GetTime() + (arg2 / 1000);
end

-- Handle the delay of a non-instant spell cast
function SVI_SpellcastDelayed()
	-- Extend the cast time duration if a spell was being cast
	if (SVI_Tick.cast_time_end) then
		SVI_Tick.cast_time_end = SVI_Tick.cast_time_end + (arg1 / 1000);
	end
end

-- Handle the start of a channeled spell
function SVI_SpellcastChannel()
	SVI_Tick.channel_time_start = GetTime();
end

-- Handle the activation of autorepeating spells
function SVI_StartAutoRepeatSpell()
	SVI_Tick.autoshoot = true;
end

-- Handle the deactivation of autorepeating spells
function SVI_StopAutoRepeatSpell()
	SVI_Tick.autoshoot = false;
end

-- Check for gaining a buff or debuff
function SVI_CheckGainedBuff()

	-- Check what buff or debuff, if any, was found
	local _, _, aura_name = string.find(arg1, SVI_SEARCH_BUFF_GAIN);
	if (not aura_name) then
		_, _, aura_name = string.find(arg1, SVI_SEARCH_DEBUFF_GAIN);
	end

	-- Only process important buffs
	if (aura_name and SVI_ManaRegenBuffs[aura_name]) then

		-- Handle the regeneration before the aura was acquired
		SVI_ProcessManaRegen();

		-- Add it
		SVI_HandleAuraGained(aura_name, SVI_ManaRegenBuffs[aura_name]);
	end

end

-- Check for losing a buff or debuff
function SVI_CheckLostBuff()

	-- Check what buff or debuff, if any, was lost
	--
	-- NOTE: Losing buffs and debuffs use the same syntax, unlike gaining them.
	local _, _, aura_name = string.find(arg1, SVI_SEARCH_BUFF_LOSS);
	if (not aura_name) then
		_, _, aura_name = string.find(arg1, SVI_SEARCH_DEBUFF_LOSS);
	end

	-- Only process important buffs
	if (aura_name and SVI_ManaRegenBuffs[aura_name]) then

		-- Handle the regeneration before the aura was lost
		SVI_ProcessManaRegen();

		-- Remove it
		SVI_HandleAuraLost(aura_name, SVI_ManaRegenBuffs[aura_name]);
	end

end

-- Update the regeneration state when item bonuses change
function SVI_UpdateEquipBonuses()

	-- Find out what auras the current equipment provides and generate
	-- a new composite equipment aura
	local equip_auras = SVI_EquipmentAuras();
	local equip_regen_status = SVI_AurasSum(equip_auras);

	-- Update the regeneration status if it changed
	if (not SVI_AurasEqual(SVI_EquipRegenStatus, equip_regen_status)) then

		-- Process the last frame of updates before the change occured
		SVI_ProcessManaRegen();

		-- Remove the old composite and add the new one
		SVI_AuraRemove(SVI_RegenStatus, SVI_EquipRegenStatus);
		SVI_AuraAdd(SVI_RegenStatus, equip_regen_status);

		-- Save the new regeneration status
		SVI_EquipRegenStatus = equip_regen_status;
	end
end

-- Process incoming events
function SVI_OnEvent(event, arg1, arg2)

	-- Initialize as soon as possible
	if (event == "VARIABLES_LOADED") then
		SVI_Initialize();

	elseif (SVI_Stat.caster) then

		-- Automatically start and stop recording when entering and leaving combat;
		-- Also stop recording when changing zones
		if (event == "PLAYER_REGEN_DISABLED") then
			SVI_StartRecording();

		elseif (event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD") then
			SVI_StopRecording();

		-- Track other events that might change the player's regeneration state
		elseif (event == "PLAYER_DEAD") then
			SVI_PlayerDead();

		elseif (event == "SPELLCAST_STOP") then
			SVI_SpellcastStop();
		
		elseif (event == "SPELLCAST_START") then
			SVI_SpellcastStart();

		elseif (event == "SPELLCAST_DELAYED") then
			SVI_SpellcastDelayed();

		elseif (event == "SPELLCAST_CHANNEL_START") then
			SVI_SpellcastChannel();
		
		elseif (event == "START_AUTOREPEAT_SPELL") then
			SVI_StartAutoRepeatSpell();

		elseif (event == "STOP_AUTOREPEAT_SPELL") then
			SVI_StopAutoRepeatSpell();

		elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
			SVI_CheckGainedBuff();

		elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
			SVI_CheckGainedBuff();

		elseif (event == "CHAT_MSG_SPELL_AURA_GONE_SELF" or event == "CHAT_MSG_SPELL_BREAK_AURA") then
			SVI_CheckLostBuff();

		elseif (event == "UNIT_INVENTORY_CHANGED") then
			SVI_UpdateEquipBonuses();

		end

	end

end
