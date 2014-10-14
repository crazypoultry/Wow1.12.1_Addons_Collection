-- This keeps track of all the units we are monitoring
ffy_Unit_Array        = { };
ffy_LastUnitChecked   = 0;

-- used to test for posession of a spell and its index in the spell system
ffy_SpellID           = nil;
ffy_SpellIconSlot     = nil;
ffy_RecastTimes       = nil;
ffy_IsChanneling      = false;

-- Debug flags - set them to true if you want garbage spam
ffy_Print_DEBUG       = false;

-- These are all the ffy_Options that are saved on logout
ffy_Options = {
    Version = "unknown",
	NotifyGroup = true,
	ShowPanel = true,
	ReplyWhisper = FFY_REPLY_AUTO,
	Enabled = { },
	PanelMovable = true,
	CastOnPets = false,
	TellBuffs = false,
	DutyCycle = FFY_DUTY_ALL,
	ManaConserve = 4000,
	RescanTimer = 10.0,
	ReminderAudio = true,
    ReminderText = true,
    ReminderTimer = 60.0,
    MainHand = 1,
    OffHand = 1,
};

-- Have we started or finished casting?
ffy_Is_Buffing        = false;
ffy_People_Missed     = "";

-- What paladin blessings have we cast on people?
ffy_Paladin_Blessings = { };

-- When did we last cast a buff on someone?
ffy_NextBuffTime = { };
ffy_RecastList = { };

-- This is the overall list we find by scanning your spellbook
ffy_MyData = nil;
ffy_SpellRanks = { };
ffy_UI_Lookup = { };
ffy_MainHandDropDown = false;

-- Game Constants
FFY_MAXBUFFS   = 16;
FFY_START_SLOT = 1;
FFY_END_SLOT   = 120;

-- A couple useful variables we track
ffy_AttackOnDelay   = 0.0;
ffy_InCombatMode    = false;
ffy_IsPaladin       = false;
ffy_IsRogue         = false;
ffy_Clock           = 0.0;
ffy_RecastTimer     = 30.0;
ffy_FullRecastMode  = false;
ffy_NextRescan      = 30.0;
ffy_NextReminder    = 0.0;



-------------------------------------------------------------------------------
-- and the printing functions
-------------------------------------------------------------------------------
function ffy_debug(Message)
    if (ffy_Print_DEBUG) then
        DEFAULT_CHAT_FRAME:AddMessage(Message, 0.1, 0.1, 1);
    end
end

function ffy_println(Message)
    DEFAULT_CHAT_FRAME:AddMessage(FFY_TAG .. Message, 1, 1, 1);
end

function ffy_print(Message)
    DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 1, 1);
end

function ffy_errln(Message)
    DEFAULT_CHAT_FRAME:AddMessage(FFY_TAG .. Message, 1, 0.1, 0.1);
end

function ffy_speak(Message)
    if (ffy_Options.NotifyGroup) then
        ffy_forcespeak(Message);
    else
        ffy_println(Message);
    end
end

function ffy_forcespeak(Message)
    if (GetNumRaidMembers() > 0) then
        SendChatMessage(FFY_TAG .. Message, 'raid');
    elseif (GetNumPartyMembers() > 0) then
        SendChatMessage(FFY_TAG .. Message, 'party');
    else
        ffy_println(Message);
    end
end


-------------------------------------------------------------------------------
-- Create a full properized spell name - handles spells that have no ranks
-------------------------------------------------------------------------------
function ffy_BuildSpellName(spell, rank)
    if (spell == FFY_BLESSING_KINGS) or (spell == FFY_BLESSING_SALVATION) then
        return spell;
    else
        return spell .. "(" .. FFY_RANK .. " " .. rank .. ")";
    end
end


-------------------------------------------------------------------------------
-- Find a spell by checking both its full name and its shortcuts
-------------------------------------------------------------------------------
function ffy_FindSpellByName(label)
    local spell, settings, i;

    -- Only check if we have some spells
    if (ffy_MyData) then
        for spell, settings in ffy_MyData do
            i = 1;
            if (spell) then
                -- If the user went to all the trouble to type it out completely
                if (spell == label) then
                    return spell;
                end
        
                -- Otherwise check all the shortcuts
                while (settings.shortcut[i]) do
                    if (label == settings.shortcut[i]) then
                        return spell;
                    end
                    i = i + 1;
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- These are updated range functions, hopefully better than the last attempt
-------------------------------------------------------------------------------
function ffy_UnitInRange(Unit, SpellName)

    -- If they're us, we're cool
    if UnitIsUnit(Unit, "player") then
        return true;
    end
    
	-- What a nifty utility function :)
	if (not UnitIsVisible(Unit)) then
		return false;
	end

    -- Try targeting them; if we accidentally get someone else, that's a dead giveaway
	TargetUnit(Unit);
	if not UnitIsUnit("target", Unit) then
	    return false;
	end
	
    -- Check to see if we have this spell in the buttonbar
    local i = ffy_SpellIconSlot[SpellName];
    if (i ~= nil) then
        ffy_debug("Spell " .. SpellName .. " is in icon bar #" .. i .. ", checking range.");
        local result = (IsActionInRange(i) == 1);
        if (result) then
            ffy_debug("In Range");
        else
            ffy_debug("Out of Range");
        end
		return result;
    end
    
	-- Guess that the unit is targetable
	return true;
end

-------------------------------------------------------------------------------
-- Cast the appropriate level of a spell on a unit
-------------------------------------------------------------------------------
function ffy_Cast_Spell(spellName, Unit)
    local res = false;
    local unit_level = UnitLevel(Unit);
    local fullspellname;
    local settings = ffy_MyData[spellName];
    
    -- level hide, so set a factice level 999.
    if (unit_level <= 0) then
        unit_level = 999;
    end
    
    -- There is only one rank of these blessings
    if (settings.levels[2] == nil) then
        fullspellname = spellName;

    -- Otherwise, select the appropriate version of the spell
    else
        local selected_rank = 0;
        local i = ffy_SpellRanks[spellName];
        while (i > 0) do
            if (unit_level >= settings.levels[i] - 10) then
                fullspellname = spellName .. "(" .. FFY_RANK .. " " .. i .. ")";
                selected_rank = i;
                do break end;
            end
            i = i - 1;
        end

        -- Maybe nothing is valid
        if (selected_rank < 1) then
            return false;
        end
    end
    
    -- Identify the spell we're casting
    ffy_debug("Starting cast of '" .. fullspellname .. "' on " .. UnitName(Unit) .. ".");
    local spellid = ffy_SpellID[fullspellname];
    
    -- Was this person out of range during the last round?
    if (string.find(ffy_People_Missed, ", " .. UnitName(Unit)) ~= nil) then
        ffy_debug("Person " .. UnitName(Unit) .. " was already missed once.");
        return false;

    -- If not, check them and see if we are in range
    else
        if (not ffy_UnitInRange(Unit, spellName)) then
            ffy_People_Missed = ffy_People_Missed .. ", " .. UnitName(Unit);
            return false;
        end
    end

    -- Final sanity check to make sure the spell exists.
    if (not spellid) then
        ffy_debug("The spell " .. fullspellname .. " was not found.");
        
    -- If we actually have this spell, then yay - give it a shot
    else
        -- ffy_println( string.gsub( string.gsub(FFY_BUFF_STRING, "$t", UnitName(Unit)), "$s", fullspellname));
        ffy_debug("Spell ID is " .. spellid .. ", book type is " .. SpellBookFrame.bookType);
        TargetByName(UnitName(Unit));
        CastSpell(spellid, SpellBookFrame.bookType);
        res = true;
        
        -- Keep track of when we should next rebuff them with this spell
        ffy_debug("Clock is " .. ffy_Clock .. " and duration is " .. settings.duration[1]);
        ffy_NextBuffTime[UnitName(Unit) .. "-" .. spellName] = ffy_Clock + settings.duration[1];
        if (ffy_FullRecastMode) then
            ffy_RecastList[UnitName(Unit) .. "-" .. spellName] = true;
        end

        -- Optionally, notify the person that we cast on them
        if (ffy_Options.TellBuffs) and (Unit ~= "player") then
            SendChatMessage(FFY_TAG .. string.gsub(FFY_TELLBUFF_MSG, "$s", spellName), "WHISPER", nil, UnitName(Unit));
        end
    end
    
    return res;
end


-------------------------------------------------------------------------------
-- Find an item based on the name provided
-------------------------------------------------------------------------------
function ffy_FindItemByName(SearchString)

    -- No such item exists, sorry!
    if SearchString == nil then
        return nil, nil, nil;
    end
    
    -- Search for what they want
    local s = string.lower(SearchString)
    for bag = 0,4 do
        for slot = 1,GetContainerNumSlots(bag) do
            itemlink = GetContainerItemLink(bag,slot);
            if (itemlink) then
                if (itemlink == SearchString) or (string.find(string.lower(itemlink), s)) then
                    return bag, slot, itemlink;
                end
            end
        end
    end
    
    -- Nothing found, sorry!
    return nil, nil, nil;
end


