-------------------------------------------------------------------------------
-- Fortify
--
-- A modded version of Decursive used to buff everyone in your party automatically.
-- Created by Pravetz (Proudmoore)
--
-- Date      Rev    Description
-- --------  -----  -----------------------
-- 06/12/05  0.5    Initial version of Fortify casts Inner Fire, Fortitude, Divine Spirit,
--                  and Shadow Protection.
--                  Added Feedback (weapon buff).
--                  Casts the appropriate ranks of spells for lower level chars.
--                  Check to see that we actually have the spells before casting.
--                  Corrected unusual targeting error messages.
-- 06/13/05  0.7    Add Elune's Grace for night elf priests.
--                  Only cast divine spirit on people who have mana.
-- 06/15/05  1.0    Fix this wierd range thing when people are in different zones.
--                  Added clearer party/raid-announce messages.
--                  Released mod.
-- 06/18/05  1.1    Trimmed out some excess code and removed some unused logic.
--                  Sped up the spell selection routines.  It does fewer searches through
--                  the spellbook now.
--                  Added message to indicate nothing to do.
--                  Added a user interface button for quick use.
-- 06/19/05  1.2    Added a "quiet" command for SilvioG.  Type "/fortify quiet".
--                  Added a texture for the user interface button.
--                  Moved all the speaking stuff into a separate function.
--                  Sped up the range checking (check once per unit instead of once per spell).
-- 06/20/05         Added a "move" command so the icon can be relocated.  Doesn't work yet.
--                  Check to see if the player is mounted.
--                  Allow the player to turn off certain buffs if not desired.
-- 06/21/05  1.3    Corrected the bad version 1.2 that I posted.
--                  Added "just" and "all" commands.
--                  Added "show" to show all current settings.
--                  Remembers your settings.
--                  Added Paladin blessings.
--                  Use "whispercast" style requests to let users select their paladin blessings.
--                  Added Troll racial spell Shadowguard.
-- 06/28/05  1.4    Added user interface.  Properly movable.
--                  Shows Decursive button as well.
--                  Ignores dead and offline units.
-- 06/28/05  1.5    Added "Mark of the Wild" and "Thorns" - apparently I forgot to include them in BuffUnit.
--                  Moved all spell data into data.lua.
-- 08/05/05  1.6    Revised code to use better data structures.
--                  Added an "auto-reply" toggle to disable the automatic replies.
--                  There are three reply modes: auto, fail, and off.
--                  Improved the range checking code - at least, it won't get stuck on people.
-- 08/07/05  1.7    Corrected a problem with spell overrides.
--                  Also, typing "/ffy all" will correct any bugs with misconfigured spell data.
--                  Returned the paladin code back into place - sorry, guys.
--                  /ffy toggle now uses shortcuts to identify spells.
-- 08/10/05  1.8    Yet another problem with spell overrides.
--                  A little more work on Paladin blessings.
-- 08/17/05  1.9    Re-tested and validated paladin blessings.
--                  Added (optional) pet buffs.
--                  Corrected problem with whispering when you have no buff spells to cast.
--                  Fixed the error in paladin blessings that was causing it to lose track of preferred blessings.
--                  Added "party blessings" flag to properly handle salvation.
--                  Added optional tell notification.
-- 08/21/05  1.91   Corrected minor typo.
-- 09/05/05  2.00   Added UI icon checking for range.
--                  Added Mage self-cast spells.
--                  Added improved re-attack after fortify is cast.
--                  Added /ffy announce command.
--                  Added /ffy bless selection for Paladins.
--                  Added demon skin for warlocks.
--                  Added PVP detection to not buff people if they'd alter your PVP status
--                  Added recast when the buff is about to expire - it's fixed at 30 secs till expiration
--                  But, it won't recast if the buff is still on the person after the 30 secs are up, in
--                  case someone else cast it on the target.
--                  The "/ffy Recast" command will now force all buffs to recast - before a boss, etc.
-- 01/01/06  2.1    Buff selects Kings as the first preference for non-casters.
--                  Hunters get Wisdom before Kings.
--                  Added testing for dropped buffs every 30 seconds.
--                  Flag the user interface to indicate some buffs need to be cast.
--                  "Stop-at" for mana conservation.
--                  Only attack the unit specified if they are attackable (don't fight dead units)
-- 02/20/06  2.2    Fixed bug with Paladin blessings.  They cast now.
--                  Added french translations from mymycracra (Thank you!)
-- 04/06/06  2.3    Upgraded to latest Blizzard UI revision.
--                  Inner fire is now ten minutes.
--                  Feedback is no longer a buff.
-- 08/02/06  2.4    Configuration user interface.
--                  Improved paladin functions - single target blessings are fixed.
--                  Set up party blessing code for salvation.
--                  Added warlock demon armor.
--                  Added link on button panel to configuration dialog.
--                  Added audible / textual reminders.
--                  Eliminated text messages to the player.
--                  Reminder timer is on a 60-second clock.
--                  Fixed Divine Spirit ranks and costs.
--                  Fortify now works on Rogue poisons.
-- 08/14/06  2.5    Add new divine spirit group / shadow prot group buffs.
--                  Fixed the "lock UI in place" button.
--                  Moved Config stuff & tools functions into separate files.
--                  Updated interface version to patch 1.12.
--                  Added warrior battle shout.
--                  Don't attempt to fortify while channeling or crafting.
--                  Added french translations from Laurent Chevalier.
--                  Fixed bug with salvation.
--                  Added main-hand/off-hand weapon buff items.
--                  Short-circuit buff checking for people with only item buffs
--                  Update buff status as soon as spells are cast
--                  
--                  
--
-- To Do:
-- Calculate total mana costs for all buffs.
-- Separate buffs into cast-in-combat vs no cast in combat
-- Add group-selection for raids
-- Fix buffing warlock pets when they go stealthed
-- Fix people within range alerts
-- User interface should let users customize their cast lists
-- Convert behavior values in data.lua to be flags rather than IDs
-- Properly handle group buffs (determine when most efficient)
-- Add class-based buffs (paladin raid buffs)
-- Add potions (?) and food (?)
-- Buffing statistics
-- Ensure that weapon buffs don't overwrite previous weapon buffs (SpellStopTargeting() cancels them).
-- Add a blacklist for people out of range and only check them periodically
-- Add option for cast-on-people-who-are-flagged-pvp
-- Remove text user interface
-- Add "announce" UI for Paladins
-- Make sure weapons in hands are actually weapons
-- Calculate cost of Salvation for paladins
--


-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Start up Fortify
-------------------------------------------------------------------------------
function ffy_Init()

    -- Announce ourselves
    ffy_println(FFY_VERSION_STRING);

    -- Register our slash commands
    SlashCmdList["FORTIFY"] = ffy_Commands;
    SLASH_FORTIFY1 = FFY_MACRO_COMMAND;
    SLASH_FORTIFY2 = FFY_MACRO_COMMAND2;
    
    -- Register all the events we handle
    this:RegisterEvent("CHAT_MSG_WHISPER");
    this:RegisterEvent("SPELLS_CHANGED");

    -- If the reminder timer is blank set to 60
    if (ffy_Options.ReminderTimer == nil) then
        ffy_Options.ReminderTimer = 60.0;
    end
    if (ffy_Options.MainHand == nil) then
        ffy_Options.MainHand = 1;
        ffy_Options.OffHand = 1;
    end
    
    -- Configure the spell book
    ffy_Configure();

    -- create the array of curable items
    ffy_CreateTargetList();
end

-------------------------------------------------------------------------------
-- Create the target list based on the current duty cycle
-------------------------------------------------------------------------------
function ffy_OnUpdate(arg1)

	-- Imitated from Decursive (right on quu)
	if (ffy_AttackOnDelay > 0) then
		ffy_AttackOnDelay = ffy_AttackOnDelay - arg1;
		if (ffy_AttackOnDelay <= 0) then
			if (not ffy_InCombatMode) then
			    if (UnitCanAttack("player", "target")) then
    				AttackTarget();
                    ffy_debug("Attacking on delay.");
                end
			end
		end
	end
	
	-- Check if it's time to run a scan - once every 30 seconds
	if (ffy_NextRescan < ffy_Clock) then
	    ffy_Rescan();
	    ffy_NextRescan = ffy_NextRescan + ffy_Options.RescanTimer;
	end
	
	-- Update the fortify clock
	ffy_Clock = ffy_Clock + arg1;
end


-------------------------------------------------------------------------------
-- Notify the user to cast a buff
-------------------------------------------------------------------------------
function ffy_WarnUser(needtocast)
    if (needtocast) then
    
        -- Visual reminder
        ffy_ButtonFrame_FortifyButton:SetAlpha(1.0);

        -- All the annoying reminders are on a 60-second timer
        if (ffy_NextReminder < ffy_Clock) then
            -- Audio reminder
            if (ffy_Options.ReminderAudio) then
                PlaySoundFile("Interface\\AddOns\\Fortify\\reminder.wav");
            end
    
            -- Text reminder
            if (ffy_Options.ReminderText) then
                ffy_ReminderFrame:AddMessage(FFY_UI_REMINDER, 1, 1, 1, 1, UIERRORS_HOLD_TIME);
            end
            ffy_NextReminder = ffy_Clock + ffy_Options.ReminderTimer;
        end
        
    -- If no buffs are required then skip out
    else
        ffy_ButtonFrame_FortifyButton:SetAlpha(0.25);
    end
end


-------------------------------------------------------------------------------
-- Create the target list based on the current duty cycle
-------------------------------------------------------------------------------
function ffy_Rescan()
    ffy_WarnUser(ffy_AnyBuffsToCast());
end


-------------------------------------------------------------------------------
-- Create the target list based on the current duty cycle
-------------------------------------------------------------------------------
function ffy_CreateTargetList()
    local i;
    
    -- Re-Initialize the unit array
    ffy_Unit_Array = { };
    
    -- Add yourself first
    table.insert(ffy_Unit_Array, "player");
    if (ffy_Options.CastOnPets) then
        table.insert(ffy_Unit_Array, "pet");
    end
    
    -- Then your target
    table.insert(ffy_Unit_Array, "target");
    
    -- Then your party
    for i = 1, 4 do
        table.insert(ffy_Unit_Array, "party"..i);
        if (ffy_Options.CastOnPets) then
            table.insert(ffy_Unit_Array, "partypet"..i);
        end
    end
    
    -- Then the whole raid
    for i = 1, 40 do
        table.insert(ffy_Unit_Array, "raid"..i);
        if (ffy_Options.CastOnPets) then
            table.insert(ffy_Unit_Array, "raidpet"..i);
        end
    end
end

-------------------------------------------------------------------------------
-- Fortify text user interface
-------------------------------------------------------------------------------
function ffy_Commands(msg)

    -- The command is the next text off the message
    local command, args, p;
    p = string.find(msg," ");
    if (p ~= nil) then
        args = string.sub(msg,p + 1);
        command = string.lower(string.sub(msg,1,p - 1));
        ffy_debug("Selected [" .. command .. "] [" .. args .. "]");
    else
        command = string.lower(msg);
        ffy_debug("Selected [" .. command .. "]");
    end
    
    -- If fortify is done as a macro
    if (command == "") then
        ffy_Fortify();
        
    -- Toggle group notifications
    elseif (command == FFY_CMD_QUIET) then
        ffy_Options.NotifyGroup = not ffy_Options.NotifyGroup;
        if (ffy_Options.NotifyGroup) then
            ffy_println(FFY_MODE_NOTIFY);
        else
            ffy_println(FFY_MODE_QUIET);
        end
        
    -- Change mana conservation levels
    elseif (command == FFY_CMD_CONSERVE) then
        ffy_Options.ManaConserve = tonumber(args);
        if (ffy_Options.ManaConserve == nil) or (ffy_Options.ManaConserve < 0) then
            ffy_Options.ManaConserve = 0;
        end
        if (ffy_Options.ManaConserve > UnitManaMax("player")) then
            ffy_Options.ManaConserve = UnitManaMax("player");
        end
        ffy_println(string.gsub(FFY_CONSERVE_MSG, "$m", ffy_Options.ManaConserve));
        ffy_Rescan();
        
    -- Toggle responses to whispercast requests
    elseif (command == FFY_CMD_REPLY) then
        if (args == FFY_REPLY_AUTO) then
            ffy_Options.ReplyWhisper = args;
            ffy_println(FFY_MODE_AUTOREPLY);
        elseif (args == FFY_REPLY_FAIL) then
            ffy_Options.ReplyWhisper = args;
            ffy_println(FFY_MODE_FAILREPLY);
        elseif (args == FFY_REPLY_OFF) then
            ffy_Options.ReplyWhisper = args;
            ffy_println(FFY_MODE_NOREPLY);
        else
            ffy_println(FFY_REPLY_CHOICES);
        end
        
    -- Show or hide the UI panel
    elseif (command == FFY_CMD_TOGGLEUI) then
        ffy_Options.ShowPanel = not ffy_Options.ShowPanel;
        ffy_ButtonFrame_Update();
        
    -- Toggle individual spells notifications
    elseif (command == FFY_CMD_TOGGLESPELL) then
        if (args == nil) then
            ffy_println(FFY_TOGGLE_SYNTAX);
        else
            local spellname = ffy_FindSpellByName(args);
            if (spellname == nil) then
                ffy_println(string.gsub(FFY_TOGGLE_SPELLING, "$s", args));
            else
                ffy_Options.Enabled[spellname] = not ffy_Options.Enabled[spellname];
                if (ffy_Options.Enabled[spellname]) then
                    ffy_println(string.gsub(FFY_TOGGLE_YESCAST, "$s", spellname));
                else
                    ffy_println(string.gsub(FFY_TOGGLE_NOCAST, "$s", spellname));
                end
            end
        end
        ffy_Rescan();
        
    -- Toggle individual spells notifications
    elseif (command == FFY_CMD_SINGLESPELL) then
        local spellname, spellstate, onlyspell;
        
        -- If the spell name can be found, turn it on and all else off
        onlyspell = ffy_FindSpellByName(args)
        if (onlyspell) then
            for spellname, settings in ffy_MyData do
                ffy_Options.Enabled[spellname] = (spellname == onlyspell);
            end
            ffy_println(string.gsub(FFY_TOGGLE_SINGLE, "$s", onlyspell));
            
        -- Otherwise print an error message
        else
            ffy_println(FFY_ONLY_SYNTAX);
        end
        ffy_Rescan();
    
    -- Toggle individual spells notifications
    elseif (command == FFY_CMD_ALLSPELLS) then
        local playerClass, englishClass = UnitClass("player");
        ffy_MyData = FFY_SPELL_DATA[englishClass];
        for spellname, settings in ffy_MyData do
            ffy_Options.Enabled[spellname] = true;
        end
        ffy_println(FFY_TOGGLE_ALL);
        ffy_Rescan();
    
    -- Toggle individual spells notifications
    elseif (command == FFY_CMD_SHOW) then
        local playername, spellname, spellstate, showline, ignoreline
        ffy_println(FFY_SHOW_SETTINGS);
        showline = "";
        ignoreline = "";
        for spellname, settings in ffy_MyData do
            if (ffy_SpellRanks[spellname] > 0) then
                if (ffy_Options.Enabled[spellname]) then
                    showline = showline .. " " .. spellname .. " (" .. FFY_RANK .. " " .. ffy_SpellRanks[spellname] .. ")  "
                else
                    ignoreline = ignoreline .. " " .. spellname .. " (" .. FFY_RANK .. " " .. ffy_SpellRanks[spellname] .. ")  "
                end
            end
        end
        if (showline ~= "") then
            ffy_print(string.gsub(FFY_SHOWLINE, "$l", showline));
        end
        if (ignoreline ~= "") then
            ffy_print(string.gsub(FFY_IGNORELINE, "$l", ignoreline));
        end
        if (ffy_Options.NotifyGroup) then
            ffy_print(FFY_MODE_NOTIFY);
        else
            ffy_print(FFY_MODE_QUIET);
        end
        if ffy_Print_DEBUG then
            ffy_print(FFY_DEBUGON)
        end
        if (ffy_Options.ReplyWhisper == FFY_REPLY_AUTO) then
            ffy_print(FFY_MODE_AUTOREPLY);
        elseif (ffy_Options.ReplyWhisper == FFY_REPLY_FAIL) then
            ffy_print(FFY_MODE_FAILREPLY);
        elseif (ffy_Options.ReplyWhisper == FFY_REPLY_OFF) then
            ffy_print(FFY_MODE_NOREPLY);
        end
        if (ffy_Options.CastOnPets) then
            ffy_print(FFY_PETSMSG_ON);
        else
            ffy_print(FFY_PETSMSG_OFF);
        end
        if (ffy_Options.TellBuffs) then
            ffy_print(FFY_TELLBUFF_ON);
        else
            ffy_print(FFY_TELLBUFF_OFF);
        end
        for playername, spellname in ffy_Paladin_Blessings do
            ffy_print(string.gsub(string.gsub(FFY_WHISPERREQUEST, "$s", spellname), "$t", playername));
        end
        ffy_println(string.gsub(FFY_CONSERVE_MSG, "$m", ffy_Options.ManaConserve));
    
    -- Toggle individual spells notifications
    elseif (command == FFY_CMD_DEBUG) then
        ffy_Print_DEBUG = not ffy_Print_DEBUG;
        if ffy_Print_DEBUG then
            ffy_println(FFY_DEBUGON)
        else
            ffy_println(FFY_DEBUGOFF)
        end
        
    -- Show a list of supported commands
    elseif (command == FFY_CMD_HELP) then
        ffy_println(FFY_HELP_MSG);
        ffy_println(FFY_CMD_TOGGLEUI .. " / " .. FFY_CMD_QUIET .. " / " .. FFY_CMD_TOGGLESPELL .. " / " .. FFY_CMD_SINGLESPELL .. " / " .. FFY_CMD_ALLSPELLS .. " / " .. FFY_CMD_SHOW .. " / " .. FFY_CMD_REPLY .. " / " .. FFY_CMD_PETS .. " / " .. FFY_CMD_TELLBUFF .. " / " .. FFY_CMD_ANNOUNCE .. " / " .. FFY_CMD_BLESS .. " / " .. FFY_CMD_RECAST .. " / " .. FFY_CMD_CONSERVE);
        
    -- Recast all buffs on members of raids
    elseif (command == FFY_CMD_RECAST) then
        ffy_FullRecastMode = true;
        ffy_RecastList = { };
        ffy_println(FFY_RECAST_MSG);
        ffy_Rescan();
    
    -- Show a list of supported commands
    elseif (command == FFY_CMD_PETS) then
        if (args == FFY_ON) then
            ffy_Options.CastOnPets = true;
            ffy_println(FFY_PETSMSG_ON);
        else
            ffy_Options.CastOnPets = false;
            ffy_println(FFY_PETSMSG_OFF);
        end
        ffy_CreateTargetList();
        
    -- Show a list of supported commands
    elseif (command == FFY_CMD_TELLBUFF) then
        if (args == FFY_ON) then
            ffy_Options.TellBuffs = true;
            ffy_println(FFY_TELLBUFF_ON);
        else
            ffy_Options.TellBuffs = false;
            ffy_println(FFY_TELLBUFF_OFF);
        end
        
    -- Announce to the world our supported commands
    elseif (command == FFY_CMD_ANNOUNCE) then
        if (ffy_IsPaladin) then
            local fulllist = ffy_GetBuffList();
            local announcemsg = string.gsub(FFY_ANNOUNCE_MSG, "$l", fulllist);
            ffy_forcespeak(announcemsg);
        else
            ffy_println(FFY_BADANNOUNCE_MSG);
        end
        
    -- Select a blessing for someone manually
    elseif (command == FFY_CMD_BLESS) then
        local arg2;
        p = string.find(args," ");
        if (p ~= nil) then
            arg2 = string.sub(args,p + 1);
            args = string.sub(args,1,p - 1);
            ffy_debug("Bless [" .. args .. "] [" .. arg2 .. "]");
            
            -- Now that we've got our arguments, select the spell and record it
            local spell = ffy_FindSpellByName(arg2);
            if (spell) then
                local settings = ffy_MyData[spell];
                if (ffy_SpellRanks[spell] > 0) then
                    ffy_Paladin_Blessings[string.lower(args)] = spell;
                    ffy_println(string.gsub(string.gsub(FFY_BLESS_MSG, "$s", spell), "$p", args));
                else
                    ffy_println(FFY_BADBLESS_MSG);
                end
            else
                ffy_println(FFY_BADBLESS_MSG);
            end
        else
            ffy_println(FFY_BADBLESS_MSG);
        end
        
    -- Let them know the command syntax
    else
        ffy_errln(FFY_MACRO_ERROR);
    end
end

-------------------------------------------------------------------------------
-- Configure our spellbook
-------------------------------------------------------------------------------
function ffy_Configure()

    -- Check mana conservation settings
    if (ffy_Options.ManaConserve == nil) or (ffy_Options.ManaConserve < 0) then
        ffy_Options.ManaConserve = 0;
    end
    if (ffy_Options.ManaConserve > UnitManaMax("player")) then
        ffy_Options.ManaConserve = UnitManaMax("player");
    end

    -- Fix the rescan timer
    if (ffy_Options.RescanTimer == nil) then
        ffy_Options.RescanTimer = 10.0;
    end
    
    -- Check if we're a paladin
    local playerClass, englishClass = UnitClass("player");
    if (englishClass == FFY_CLASS_PALADIN) then
        ffy_IsPaladin = true;
        ffy_debug("Unit is a paladin.");
    else
        ffy_IsPaladin = false;
        ffy_debug("Unit is NOT a paladin.");
    end
    
    -- first empty out the old spellbook
    if (ffy_MyData == nil) then
        ffy_debug("Setting spellbook for " .. englishClass);
        ffy_MyData = FFY_SPELL_DATA[englishClass];
    end

    -- If the spellbook has any spells
    if (ffy_MyData ~= nil) then
        
        -- Clear out a few variables
        local s2, s3;
        ffy_SpellID = {};
        ffy_SpellRanks = {};
        for s2, s3 in ffy_MyData do
            ffy_SpellRanks[s2] = 0;
        end
        
        -- Only overwrite preferences if this is our first go
        if (ffy_Options.Version ~= PRAVETZ_FORT) then
            ffy_println(string.gsub(string.gsub(FFY_UPGRADE_MSG, "$v1", ffy_Options.Version), "$v2", PRAVETZ_FORT));
            ffy_Options.Version = PRAVETZ_FORT;
            ffy_Options.Enabled = {};
            
            -- Set some default values
            for s2, s3 in ffy_MyData do
                if (not ffy_Options.Enabled[s2]) then
                    ffy_Options.Enabled[s2] = true;
                end
            end
        end
    
        -- parse through the entire library...
        local i = 1;
        while (true) do
            local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
            if (not spellName) then
                do break end
            end
    
            -- Keep track of the highest rank of each spell possessed
    		if (ffy_MyData[spellName]) then
                ffy_debug("Spell named [" .. spellName .. "] Rank is [" .. spellRank .. "]");
                
                -- Salvation and Kings have just one rank
                if (spellRank == "") then
                    ffy_SpellRanks[spellName] = 1;
    
                -- Everything else has multiple ranks
                else
                    if (spellRank) then
                        local numRank = string.sub(spellRank, string.find(spellRank, " ") + 1);
                        if (ffy_SpellRanks[spellName]) then
                		    ffy_SpellRanks[spellName] = max(numRank, ffy_SpellRanks[spellName]);
                        else
                		    ffy_SpellRanks[spellName] = numRank;
                        end
                        ffy_debug("Highest rank found is [" .. ffy_SpellRanks[spellName] .. "]");
            		end
                    spellName = spellName .. "(" .. spellRank .. ")";
                end
    		end
    
            -- add it to the cached ID list
            ffy_debug("Adding " .. spellName);
            ffy_SpellID[spellName] = i;
    
            i = i + 1;
        end
    end
    
    -- Now, for rogues, set all the poisons active
    if (englishClass == FFY_CLASS_ROGUE) then
        ffy_IsRogue = true;
    end
    
    -- Update the button panel
    ffy_ButtonFrame_Update();
    ffy_ScanActionBar();    
	return 0;
end


-------------------------------------------------------------------------------
-- Rescan the action bar to make sure we have all the spells lined up correctly
-------------------------------------------------------------------------------
function ffy_ScanActionBar()

    -- Now update all of our icon slots
    ffy_Tooltip:SetOwner(Fortify, "ANCHOR_NONE");
    ffy_SpellIconSlot = { };
	i = 0;
	for i = FFY_START_SLOT, FFY_END_SLOT do
		if (HasAction(i)) then
            ffy_Tooltip:ClearLines();
            ffy_Tooltip:SetAction(i);
            local slotName = ffy_TooltipTextLeft1:GetText();
    		if (slotName ~= nil) then
    			ffy_debug("Icon Slot " .. i .. " is spell '" .. slotName .. "'.");
    			ffy_SpellIconSlot[slotName] = i;
			end
		end
	end
end


-------------------------------------------------------------------------------
-- Cast a specific buff on a specific weapon
-------------------------------------------------------------------------------
function ffy_WeaponBuff(itemname, weaponslot)
    ffy_debug("Attempting to cast " .. itemname .. " on " .. weaponslot);
    
    -- Find the appropriate poison in our inventory
    local bag, slot, link = ffy_FindItemByName(itemname);
    if (bag == nil) then
        ffy_debug("Weapon buff item not found in inventory");
        if (ffy_Options.ReminderText) then
            ffy_ReminderFrame:AddMessage(string.gsub(FFY_UI_NOITEM, "$s", itemname), 1, 1, 1, 1, UIERRORS_HOLD_TIME);
        end
        
    -- Use the weapon buff
    else
        ffy_debug("Using weapon buff");
        UseContainerItem(bag, slot);

        -- Cast the enchant on the appropriate weapon, if successful
        if (SpellIsTargeting()) then
            PickupInventoryItem(GetInventorySlotInfo(weaponslot));
            return true;
        end
    end
    return false;
end


-------------------------------------------------------------------------------
-- Scanning functionalty... this scans the parties and groups
-------------------------------------------------------------------------------
function ffy_Fortify()

    -- First check to see if this person is even capable of casting spells right now
    -- if (not ffy_SpellID) then
    --     ffy_errln(FFY_NO_SPELLS);
    --     return false;
    -- end

    -- Is the unit mounted, or otherwise busy?
    if (UnitOnTaxi("player") == 1) or (ffy_IsChanneling) then
        ffy_errln(FFY_NO_SPELLS_RDY);
        return false;
    end
    
    -- Keep track of the original target, to switch back later
    local targetName    = "";
    local targetEnemy   = false;
    local casted        = false;
    ffy_People_Missed   = "";

    -- Properly select a target for after we cast a buff
	if (UnitExists("target")) then
		targetName = UnitName("target");
		if (not UnitIsFriend("target", "player")) then
			targetEnemy = true;
		end
	end;

    -- Try to buff everyone in your party or raid
    if (not casted) then
        casted, ffy_LastUnitChecked = ffy_BuffArray(ffy_Unit_Array, ffy_LastUnitChecked);
    end;
    
    -- Lastly, try to buff your weapons as requested
    if (not casted) then
        local mainenchant, offhandenchant;
        mainenchant, _, _, offhandenchant, _, _ = GetWeaponEnchantInfo();
        if (not mainenchant) and (ffy_Options.MainHand > 1) then
            casted = ffy_WeaponBuff(FFY_WEAPONBUFF_DATA[ffy_Options.MainHand].text, "MainHandSlot");
        end
        if (not casted) and (not offhandenchant) and (OffhandHasWeapon()) and (ffy_Options.OffHand > 1) then
            ffy_WeaponBuff(FFY_WEAPONBUFF_DATA[ffy_Options.OffHand].text, "SecondaryHandSlot");
        end
    end

    -- Done with buffing.  Restore the original target
    if (targetName == "") then
        ClearTarget();
    else
        if (targetEnemy) then
            TargetLastEnemy();
            ffy_AttackOnDelay = 1.0;
            ffy_debug("Targetting last enemy; attack on delay set to 1.0 secs.");
        else
            TargetByName(targetName);
        end
    end

    -- If we didn't find anything to do, say so to the player's channel
    if (not casted) and (not ffy_Is_Buffing) then
        ffy_WarnUser(false);
        -- ffy_println(FFY_NOTHING);
    end
    
    -- If we're all buffed up, warn people
    if (not casted) and (ffy_Is_Buffing) then
        ffy_WarnUser(false);
        -- ffy_speak(FFY_DONE_BUFFS);
        if (ffy_People_Missed ~= "") then
            ffy_speak(string.gsub(FFY_PEOPLE_MISSED, "$m", strsub(ffy_People_Missed, 2)))
        end
        ffy_LastUnitChecked = 0;
        ffy_LastPetChecked = 0;
        ffy_Is_Buffing = false;
        ffy_FullRecastMode = false;
        ffy_RecastList = { };
    end
    
    -- If we're just starting to cast buffs, warn people
    if (casted) and (not ffy_Is_Buffing) then
        ffy_WarnUser(true);

        -- ffy_speak(FFY_STARTING_BUFFS);
        ffy_Is_Buffing = true;
    end
end


-------------------------------------------------------------------------------
-- Check the full array of units and try to buff everyone
-------------------------------------------------------------------------------
function ffy_BuffArray(UnitArray, LastChecked)
    local casted = false;

    -- this is just to save us from going to far
    ffy_debug("Checking array");
    if (LastChecked >= table.getn(UnitArray)) then
        LastChecked = 0;
    end

    if (LastChecked > 0) then
        -- looks like we ended somewhere else.. start at index+1
        local i;

        ffy_debug( "Starting the check at "..(LastChecked+1));
        for i = LastChecked + 1, table.getn(UnitArray) do
            if (ffy_BuffUnit(UnitArray[i])) then
                return true, i;
            end
        end

        ffy_debug( "redoing check from 1... ending at "..LastChecked);
        for i = 1, LastChecked do
            if (ffy_BuffUnit(UnitArray[i])) then
                return true, i;
            end
        end
    else
        local i;
        ffy_debug( "Starting the check at 1");
        for i = 1, table.getn(UnitArray) do
            if (ffy_BuffUnit(UnitArray[i])) then
                return true, i;
            end
        end
    end
    return false, 0;
end

-------------------------------------------------------------------------------
-- Is this unit buffable?
-------------------------------------------------------------------------------
function ffy_OkToBuff(Unit)

    -- Sanity check
    if (Unit == nil) then
        return false;
    end
    
    -- If the unit is bugged, disconnected, or dead, skip it
    if (not UnitExists(Unit)) or (UnitIsDead(Unit)) then
        return false;
    end
    
    -- If the unit is a player and disconnected, skip it
    if (UnitIsPlayer(Unit)) and (not UnitIsConnected(Unit)) then
        return false;
    end
    
    -- Ignore charmed units
    if (UnitIsCharmed(Unit)) then
        return false;
    end

    -- If this isn't a friendly unit, skip it
    if (not UnitIsFriend("player", Unit)) then
        return false;
    end
    
    -- If this person is PVP flagged and we're not, skip them
    if (UnitIsPVP(Unit)) and (not (UnitIsPVP("player"))) then
        return false;
    end
    
    -- Yay!
    return true;
end


-------------------------------------------------------------------------------
-- Does unit have enough mana to cast the spell?
-------------------------------------------------------------------------------
function ffy_HasEnoughMana(spellname)

    -- First some sanity checks - does the spell have a rank?
    local rank = ffy_SpellRanks[spellname];
    if (rank == nil) or (rank < 1) then
        ffy_debug(spellname .. " does not have a valid rank.");
        return false;
    end

    -- Does spell have a cost?
    local cost = ffy_MyData[spellname].manacost[rank];
    if (cost == nil) or (cost <= 0) then
        ffy_debug(spellname .. " rank " .. rank .. " does not have a valid cost.");
        return false;
    end
    
    -- Determine how much mana is available, adjust for conserve level
    local mana = UnitMana("player");
    if (ffy_Options.ManaConserve ~= nil) and (ffy_Options.ManaConserve >= 0) then
        mana = mana - ffy_Options.ManaConserve;
    else
        ffy_debug("Mana conserve disabled.");
    end
    
    -- Check current mana versus maximum mana for spell
    return (mana >= cost);
end


-------------------------------------------------------------------------------
-- Select which buffs are needed for a unit
-------------------------------------------------------------------------------
function ffy_SelectNeeds(Unit)
    -- If buff list is empty, nothing to see here!
    if (ffy_MyData == nil) then
        return {};
    end
    
    -- Set up the default flags for each person
    local PreferredBlessing;
    local Needs = {};
    local spellname, settings;
    for spellname, settings in ffy_MyData do
        if (ffy_SpellRanks[spellname] > 0) then
            Needs[spellname] = false;

            -- If we're below our mana conserve level, skip this spell
            if not ffy_HasEnoughMana(spellname) then
                -- not enough mana to cast
            
            -- Spells of type "weapon buff" only go on caster if no existing buff is there
            elseif (ffy_MyData[spellname].behavior == FFY_TYPE_WEAPON) then
                if (Unit == "player") then
                    local hasenchant, x1, x2, x3, x4, x5;
                    hasenchant, x1, x2, x3, x4, x5 = GetWeaponEnchantInfo();
                    if (not hasenchant) then
                        Needs[spellname] = true;
                    end
                end

            -- Check spells of type "casters only"
            elseif (ffy_MyData[spellname].behavior == FFY_TYPE_CASTERSONLY) then
                if (UnitPowerType(Unit) == 0) then
                    Needs[spellname] = true;
                end
                
            -- Check spells of type "self buff"
            elseif (ffy_MyData[spellname].behavior == FFY_TYPE_SELF) then
                if (Unit == "player") then
                    Needs[spellname] = true;
                end
            
            -- Check spells of type "party blessing" - can only be cast on party members, not raid members
            elseif (ffy_MyData[spellname].behavior == FFY_TYPE_PARTYBLESSING) then
                if (Unit == "player") or (Unit == "party1") or (Unit == "party2") or (Unit == "party3") or (Unit == "party4") or (Unit == "party5") then
                    Needs[spellname] = true;
                end

            -- All other spells are general buffs
            else
                Needs[spellname] = true;
                ffy_debug(Unit .. " needs " .. spellname);
            end
        end
    end

    -- Check through all buffs on this unit
    ffy_debug( "Buffing - "..Unit);
    local TClass, UClass = UnitClass(Unit);
    for i = 1, FFY_MAXBUFFS do
        local buff_texture = UnitBuff(Unit, i);

        -- If this is an active buff, inspect it
        if buff_texture then
			ffy_Tooltip:SetOwner(Fortify, "ANCHOR_NONE");
            ffy_TooltipTextRight1:SetText(nil);
            ffy_Tooltip:SetUnitBuff(Unit, i);
            local buff_name = ffy_TooltipTextLeft1:GetText();
            local timetext;

            if (buff_name ~= nil) then
                ffy_debug( buff_name.." found!");
            end

            -- Check if this spell is a buff we should keep track of
            for spellname in Needs do
                if (buff_name == spellname) then
                    
                    -- Special handling code for spell pairs / overrides
                    if (spellname == FFY_SPELL_PRYR_FORTITUDE) or (spellname == FFY_SPELL_FORTITUDE) then
                        Needs[FFY_SPELL_PRYR_FORTITUDE] = false;
                        Needs[FFY_SPELL_FORTITUDE] = false;
                    elseif (spellname == FFY_SPELL_GIFTWILD) or (spellname == FFY_SPELL_MARKWILD) then
                        Needs[FFY_SPELL_GIFTWILD] = false;
                        Needs[FFY_SPELL_MARKWILD] = false;
                    elseif (spellname == FFY_SPELL_ARCANEBRILLIANCE) or (spellname == FFY_SPELL_ARCANEINT) then
                        Needs[FFY_SPELL_ARCANEBRILLIANCE] = false;
                        Needs[FFY_SPELL_ARCANEINT] = false;
                    elseif (spellname == FFY_SPELL_AMPLIFYMAGIC) or (spellname == FFY_SPELL_DAMPENMAGIC) then
                        Needs[FFY_SPELL_AMPLIFYMAGIC] = false;
                        Needs[FFY_SPELL_DAMPENMAGIC] = false;
                    elseif (spellname == FFY_SPELL_PRYR_SPIRIT) or (spellname == FFY_SPELL_DIVINESPIRIT) then
                        Needs[FFY_SPELL_PRYR_SPIRIT] = false;
                        Needs[FFY_SPELL_DIVINESPIRIT] = false;
                    elseif (spellname == FFY_SPELL_PRYR_SHADOWPROT) or (spellname == FFY_SPELL_SHADOWPROT) then
                        Needs[FFY_SPELL_PRYR_SHADOWPROT] = false;
                        Needs[FFY_SPELL_SHADOWPROT] = false;
                    else
                    
                        -- If the user has requested a full recast, do everyone once
                        if (ffy_FullRecastMode) then
                            Needs[spellname] = (ffy_RecastList[UnitName(Unit) .. "-" .. spellname] == nil);
                        
                        -- Otherwise check the recast timer: if the buff is about to expire, recast it
                        else
                            local timer = ffy_NextBuffTime[UnitName(Unit) .. "-" .. spellname];
                            if (timer == nil) then
                                Needs[spellname] = false;
                            else
                                timer = timer - ffy_Clock;
                                ffy_debug("Checking timer " .. timer .. " vs clock " .. ffy_Clock .. " vs recast timer " .. ffy_RecastTimer);
                                if (timer < 0) or (timer > ffy_RecastTimer) then
                                    Needs[spellname] = false;
                                end
                            end
                        end
                    end
                    do break end;
                end
            end
            
            -- Check to see if we've already cast our blessing on this person
            if (buff_name == PreferredBlessing) and (PreferredBlessing ~= nil) then
                NeedsBlessing = false;
                ffy_debug("This person already has our blessing " .. PreferredBlessing .. ".");
            end
        end
    end

    -- If this unit is a paladin, make sure we've selected one (and only one) blessing for them
    if (ffy_IsPaladin) then
        PreferredBlessing = ffy_Paladin_Blessings[string.lower(UnitName(Unit))];

        -- If they haven't requested something, select a harmless blessing for them
        if (PreferredBlessing == nil) then

            -- If this person is a caster, choose wisdom
            local c = string.upper(UnitClass(Unit));
            if (c == FFY_CLASS_DRUID) or (c == FFY_CLASS_PRIEST) or (c == FFY_CLASS_WARLOCK) or (c == FFY_CLASS_MAGE) or (c == FFY_CLASS_SHAMAN) then
                if (Needs[FFY_BLESSING_WISDOM]) and (ffy_SpellRanks[FFY_BLESSING_WISDOM] > 0) then
                    PreferredBlessing = FFY_BLESSING_WISDOM;
                elseif (Needs[FFY_BLESSING_SALVATION]) and (ffy_SpellRanks[FFY_BLESSING_SALVATION] > 0) then
                    PreferredBlessing = FFY_BLESSING_SALVATION;
                elseif (Needs[FFY_BLESSING_KINGS]) and (ffy_SpellRanks[FFY_BLESSING_KINGS] > 0) then
                    PreferredBlessing = FFY_BLESSING_KINGS;
                elseif (Needs[FFY_BLESSING_SANCTUARY]) and (ffy_SpellRanks[FFY_BLESSING_SANCTUARY] > 0) then
                    PreferredBlessing = FFY_BLESSING_SANCTUARY;
                elseif (Needs[FFY_BLESSING_LIGHT]) and (ffy_SpellRanks[FFY_BLESSING_LIGHT] > 0) then
                    PreferredBlessing = FFY_BLESSING_LIGHT;
                elseif (Needs[FFY_BLESSING_MIGHT]) and (ffy_SpellRanks[FFY_BLESSING_MIGHT] > 0) then
                    PreferredBlessing = FFY_BLESSING_MIGHT;
                end
    
            -- Hunters need wisdom first, then other fighter blessings
            elseif (c == FFY_CLASS_HUNTER) then
                if (Needs[FFY_BLESSING_WISDOM]) and (ffy_SpellRanks[FFY_BLESSING_WISDOM] > 0) then
                    PreferredBlessing = FFY_BLESSING_WISDOM;
                elseif (Needs[FFY_BLESSING_KINGS]) and (ffy_SpellRanks[FFY_BLESSING_KINGS] > 0) then
                    PreferredBlessing = FFY_BLESSING_KINGS;
                elseif (Needs[FFY_BLESSING_MIGHT]) and (ffy_SpellRanks[FFY_BLESSING_MIGHT] > 0) then
                    PreferredBlessing = FFY_BLESSING_MIGHT;
                elseif (Needs[FFY_BLESSING_SANCTUARY]) and (ffy_SpellRanks[FFY_BLESSING_SANCTUARY] > 0) then
                    PreferredBlessing = FFY_BLESSING_SANCTUARY;
                elseif (Needs[FFY_BLESSING_LIGHT]) and (ffy_SpellRanks[FFY_BLESSING_LIGHT] > 0) then
                    PreferredBlessing = FFY_BLESSING_LIGHT;
                end
            
            -- Otherwise people like Kings the most, then might.
            else
                if (Needs[FFY_BLESSING_KINGS]) and (ffy_SpellRanks[FFY_BLESSING_KINGS] > 0) then
                    PreferredBlessing = FFY_BLESSING_KINGS;
                elseif (Needs[FFY_BLESSING_MIGHT]) and (ffy_SpellRanks[FFY_BLESSING_MIGHT] > 0) then
                    PreferredBlessing = FFY_BLESSING_MIGHT;
                elseif (Needs[FFY_BLESSING_SANCTUARY]) and (ffy_SpellRanks[FFY_BLESSING_SANCTUARY] > 0) then
                    PreferredBlessing = FFY_BLESSING_SANCTUARY;
                elseif (Needs[FFY_BLESSING_LIGHT]) and (ffy_SpellRanks[FFY_BLESSING_LIGHT] > 0) then
                    PreferredBlessing = FFY_BLESSING_LIGHT;
                end
            end
            
            -- Set this up as the unit's preferred blessing, if we found one
            if (PreferredBlessing ~= nil) then
                ffy_Paladin_Blessings[string.lower(UnitName(Unit))] = PreferredBlessing;
                ffy_println(string.gsub(string.gsub(FFY_AUTOSELECT_MSG, "$s", PreferredBlessing), "$p", UnitName(Unit)));
            end
        end
        
        -- Now make sure there is one blessing in the needs list only
        for blessname in Needs do
            Needs[blessname] = (blessname == PreferredBlessing) and Needs[blessname];
        end
    end
    
    -- Return what this unit needs
    return Needs;
end

-------------------------------------------------------------------------------
-- Shortcut to test if any buffs are needed at all
-------------------------------------------------------------------------------
function ffy_AnyBuffsToCast()

    -- Check for any weapon buffs that need to be cast
    local mainenchant, offhandenchant;
    mainenchant, _, _, offhandenchant, _, _ = GetWeaponEnchantInfo();
    if (not mainenchant) and (ffy_Options.MainHand > 1) then
        local bag, _, _ = ffy_FindItemByName(FFY_WEAPONBUFF_DATA[ffy_Options.MainHand].text);
        if (bag ~= nil) then
            return true;
        end
    end
    if (not casted) and (not offhandenchant) and (OffhandHasWeapon()) and (ffy_Options.OffHand > 1) then
        local bag, _, _ = ffy_FindItemByName(FFY_WEAPONBUFF_DATA[ffy_Options.OffHand].text);
        if (bag ~= nil) then
            return true;
        end
    end

    -- If no spells available return blank
    if (ffy_MyData == nil) then
        return false;
    end

    -- Check the whole party to see if anyone needs any buffs at the moment
    for i = 1, table.getn(ffy_Unit_Array) do
        if (ffy_OkToBuff(ffy_Unit_Array[i])) then
            local Needs = ffy_SelectNeeds(ffy_Unit_Array[i]);
            for spellname in Needs do
                ffy_debug("Checking " .. UnitName(ffy_Unit_Array[i]) .. " for " .. spellname);
                if (Needs[spellname]) and (ffy_Options.Enabled[spellname]) then
                    ffy_debug("Unit " .. UnitName(ffy_Unit_Array[i]) .. " needs " .. spellname .. " and it is enabled.");
                    return true;
                end
            end
        end
    end
    
    -- Nope, all buffs are up
    return false;
end

-------------------------------------------------------------------------------
-- Cast buffs on a unit
-------------------------------------------------------------------------------
function ffy_BuffUnit(Unit)

    -- Abandon ship if this unit should not be buffed
    if not (ffy_OkToBuff(Unit)) then
        return false;
    end
    
    -- Figure out what buffs this person needs
    local Needs = ffy_SelectNeeds(Unit);

    -- Try to cast a spell on this unit
    local result = false;
    for spellname in Needs do
        if (Needs[spellname]) and (ffy_Options.Enabled[spellname]) then
            ffy_debug("Unit needs " .. spellname .. " and it is enabled.");
        
            -- Handle paladin blesssings
            if (ffy_MyData[spellname].behavior == FFY_TYPE_BLESSING) or (ffy_MyData[spellname].behavior == FFY_TYPE_PARTYBLESSING) then
            
                -- Some blessings are only available to people grouped with you
                ffy_debug("Behavior is " .. ffy_MyData[spellname].behavior);
                if ((ffy_MyData[spellname].behavior == FFY_TYPE_PARTYBLESSING) and (Unit == "target")) then
                    ffy_debug("Can't cast " .. spellname .. " on target; this spell is for group members only.");
                else
                    result = ffy_Cast_Spell(spellname, Unit);
                    ffy_Paladin_Blessings[string.lower(UnitName(Unit))] = spellname;
                    return result;
                end
            
            -- All other spells are general buffs
            else
                ffy_debug(Unit .. " needs " .. spellname .. ".");
                return ffy_Cast_Spell(spellname, Unit);
            end

        -- Buff is not needed
        else
            ffy_debug(Unit .. " doesn't need " .. spellname .. ".");
        end
    end

    return false;
end

-------------------------------------------------------------------------------
-- Parse through all the events that Fortify needs to know about
-------------------------------------------------------------------------------
function ffy_OnEvent(event)
    ffy_debug("Event " .. event);
	if (event == "VARIABLES_LOADED") then
		ffy_Init();
	elseif (event == "SPELLS_CHANGED") then
		ffy_Configure();
	elseif (event == "SPELLCAST_CHANNEL_START") then
		ffy_IsChanneling = true;
	elseif (event == "SPELLCAST_CHANNEL_STOP") then
		ffy_IsChanneling = false;
    elseif (event == "ACTIONBAR_SLOT_CHANGED") then
        ffy_ScanActionBar();
	elseif (event == "CHAT_MSG_WHISPER") then
        ffy_CheckWhisper(arg2, arg1);
    elseif (event == "PLAYER_ENTER_COMBAT") then
    	ffy_InCombatMode = true;
        ffy_debug("Now in combat.");
    elseif (event == "PLAYER_LEAVE_COMBAT") then
    	ffy_InCombatMode = false;
        ffy_debug("Leaving combat.");
	end
end

-------------------------------------------------------------------------------
-- Show a list of buffs we can cast
-------------------------------------------------------------------------------
function ffy_GetBuffList()
    local fulllist, replymsg;
    local s2, s3;
    for s2, s3 in ffy_MyData do
        if (ffy_SpellRanks[s2] > 0) then
            if (fulllist) then
                fulllist = s2 .. ", " .. fulllist;
            else
                fulllist = s2;
            end
        end
    end
    return fulllist;
end

-------------------------------------------------------------------------------
-- Check to see if this person is requesting a particular blessing
-------------------------------------------------------------------------------
function ffy_CheckWhisper(name, message)

    -- Check to see if this is a recognized whisper
    if (ffy_IsPaladin) then
        if (strlen(message) <= 15) then
            local spell = ffy_FindSpellByName(string.lower(message));
            if (spell) then
                local settings = ffy_MyData[spell];
                ffy_debug("Person '" .. name .. "' wants '" .. spell .. "'.");
                if (ffy_SpellRanks[spell] > 0) then
                    ffy_Paladin_Blessings[string.lower(name)] = spell;
                    
                    -- If the user selected auto reply mode, acknowledge the request
                    if (ffy_Options.ReplyWhisper == FFY_REPLY_AUTO) then
                        ffy_debug("Replying: " .. string.gsub(FFY_RECEIVE_WHISPER, "$s", spell));
                        SendChatMessage(FFY_TAG .. string.gsub(FFY_RECEIVE_WHISPER, "$s", spell), "WHISPER", nil, name);
                    end
                else
                
                    -- If the user selected auto or fail reply mode, let the whisperer know what they can ask for
                    if (ffy_Options.ReplyWhisper == FFY_REPLY_AUTO) or (ffy_Options.ReplyWhisper == FFY_REPLY_FAIL) then
                        local fulllist = ffy_GetBuffList();
                        replymsg = string.gsub(string.gsub(FFY_BAD_WHISPER, "$s", spell), "$l", fulllist);
                        ffy_debug("Replying: " .. replymsg);
                        SendChatMessage(FFY_TAG .. replymsg .. ".", "WHISPER", nil, name);
                    end
                end
            end
        end
    end
end


