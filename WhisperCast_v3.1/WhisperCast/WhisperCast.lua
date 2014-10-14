WhisperCast_Version = "3.0"

-- Recode by Sarris of Blackhand, originally by Valconeye
-- Original BestBuff by Gello

WHISPERCAST_ADDON_PATH = "Interface\\AddOns\\WhisperCast\\"

BINDING_HEADER_WHISPERCAST = WCLocale.UI.text.BINDING_HEADER;
BINDING_NAME_WHISPERCAST = WCLocale.UI.text.BINDING_NAME_CAST;
BINDING_NAME_WHISPERCAST_SHOW = WCLocale.UI.text.BINDING_NAME_SHOW;

local CHAT_RED = "|cFFFF0000"
local CHAT_GREEN = "|cFF00FF00"
local CHAT_END = "|r"

-- main spell queue
WhisperCast = { min=1, next=1, n=0 };

-- saved variable
WhisperCast_Profile = {}

-- loaded with current players spells
WhisperCast_Spells = nil;

-- unit names of people in my current group/raid
WhisperCast_Group = {}

-- hold information about runtime state
WhisperCast_Runtime = {
    queueBrief = "",
    queueBriefColor = NORMAL_FONT_COLOR,
    queueDetail = "",
    guis = {},
};

-- internal profile keys are not localized
local WhisperCast_defaultProfile = {
    ['profileversion'] = 2,
    ['enable'] = 1,
    ['failures'] = 4, -- failures before a spell is dequeued
    ['failuregracetime'] = 1, -- second between counted failures
    ['grouponly'] = 1,
    ['restrictcombat'] = 0,
    ['mainalpha'] = 1,
    ['backalpha'] = 0.6,
    ['match'] = "start",
    ['disabledSpells'] = {},
    ['hidewhispers'] = 0,
    ['feedbackwhisper'] = 1,
    ['playsound'] = {
        ['firstqueue'] = 1,
        ['emptyqueue'] = 0,
    },
    ['gui'] = {
        ['hidden'] = 0,
        ['minimize'] = 0,
        ['flashqueue'] = 1,
    },
};

WhisperCast_SpellLibrary = {
    PRIEST = {
        {
            spell = WCLocale.PRIEST.Prayer_of_Fortitude,
            trigger = WCLocale.PRIEST.Prayer_of_Fortitude_trigger,
            level = 48,
	    cooldowncheck = 0,
            rank = { 48, 60 }
        },
	{
            spell = WCLocale.PRIEST.Prayer_of_Spirit,
            trigger = WCLocale.PRIEST.Prayer_of_Spirit_trigger,
            level = 60,
	    cooldowncheck = 0,
            rank = { 60 }
        },
	{
            spell = WCLocale.PRIEST.Prayer_of_Shadow_Protection,
            trigger = WCLocale.PRIEST.Prayer_of_Shadow_Protection_trigger,
            level = 56,
	    cooldowncheck = 0,
            rank = { 56 }
        },
        {
            spell = WCLocale.PRIEST.Power_Word_Fortitude,
            trigger = WCLocale.PRIEST.Power_Word_Fortitude_trigger,
            level = 1,
	    cooldowncheck = 0,
            rank = { 1, 12, 24, 36, 48, 60 }
        },
        {
            spell = WCLocale.PRIEST.Shadow_Protection,
            trigger = WCLocale.PRIEST.Shadow_Protection_trigger,
            level = 30,
	    cooldowncheck = 0,
            rank = { 30, 42, 56 }
        },
        {
            spell = WCLocale.PRIEST.Divine_Spirit,
            trigger = WCLocale.PRIEST.Divine_Spirit_trigger,
            level = 30,
	    cooldowncheck = 0,
            rank = { 30, 40, 50, 60 }
        },
	{
            spell = WCLocale.PRIEST.Power_Infusion,
            trigger = WCLocale.PRIEST.Power_Infusion_trigger,
            level = 40,
	    cooldowncheck = 1
        },
        {
            spell = WCLocale.PRIEST.Power_Word_Shield,
            trigger = WCLocale.PRIEST.Power_Word_Shield_trigger,
            level = 6,
	    cooldowncheck = 0,
            rank = { 6, 12, 18, 24, 30, 36, 42, 48, 54, 60 },
            combat = true
        },
        {
            spell = WCLocale.PRIEST.Dispel_Magic,
            trigger = WCLocale.PRIEST.Dispel_Magic_trigger,
            level = 18,
	    cooldowncheck = 0,
            rank = { 18 --[[only use rank 1, rank 2 level 36]] },
            combat = true
        },
	{
            spell = WCLocale.PRIEST.Cure_Disease,
            trigger = WCLocale.PRIEST.Cure_Disease_trigger,
            level = 14,
	    cooldowncheck = 0,
            combat = true
        },
        {
            spell = WCLocale.PRIEST.Abolish_Disease,
            trigger = WCLocale.PRIEST.Abolish_Disease_trigger,
            level = 24,
	    cooldowncheck = 0,
            combat = true
        },
        {
            spell = WCLocale.PRIEST.Fear_Ward,
            trigger = WCLocale.PRIEST.Fear_Ward_trigger,
            level = 20,
	    cooldowncheck = 0,
            rank = WCLocale.PRIEST.Fear_Ward_rank,
            combat = true
        },
    },
    MAGE = {
        {
            spell = WCLocale.MAGE.Arcane_Brilliance,
            trigger = WCLocale.MAGE.Arcane_Brilliance_trigger,
            level = 56,
	    cooldowncheck = 0,
            rank = { 56 }
        },
        {
            spell = WCLocale.MAGE.Arcane_Intellect,
            trigger = WCLocale.MAGE.Arcane_Intellect_trigger,
            level = 1,
	    cooldowncheck = 0,
            rank = { 1, 14, 28, 42, 56 }
        },
        {
            spell = WCLocale.MAGE.Dampen_Magic,
            trigger = WCLocale.MAGE.Dampen_Magic_trigger,
            level = 12,
	    cooldowncheck = 0,
            rank = { 12, 24, 36, 48, 60 }
        },
        {
            spell = WCLocale.MAGE.Amplify_Magic,
            trigger = WCLocale.MAGE.Amplify_Magic_trigger,
            level = 18,
	    cooldowncheck = 0,
            rank = { 18, 30, 42, 54 }
        },
        {
            spell = WCLocale.MAGE.Remove_Lesser_Curse,
            trigger = WCLocale.MAGE.Remove_Lesser_Curse_trigger,
            level =  16,
	    cooldowncheck = 0,
            combat = true
        },
    },
    DRUID = {
        {
            spell = WCLocale.DRUID.Gift_of_the_Wild,
            trigger = WCLocale.DRUID.Gift_of_the_Wild_trigger,
            level = 50,
	    cooldowncheck = 0,
            rank = { 50, 60 }
        },
        {
            spell = WCLocale.DRUID.Mark_of_the_Wild,
            trigger = WCLocale.DRUID.Mark_of_the_Wild_trigger,
            level = 1,
	    cooldowncheck = 0,
            rank = { 1, 10, 20, 30, 40, 50, 60 }
        },
        {
            spell = WCLocale.DRUID.Thorns,
            trigger = WCLocale.DRUID.Thorns_trigger,
            level = 6,
	    cooldowncheck = 0,
            rank = { 6, 14, 24, 34, 44, 54 }
        },
        {
            spell = WCLocale.DRUID.Innervate,
            trigger = WCLocale.DRUID.Innervate_trigger,
            level = 40,
	    cooldowncheck = 1,
            combat = true
        },
        {
            spell = WCLocale.DRUID.Remove_Curse,
            trigger = WCLocale.DRUID.Remove_Curse_trigger,
            level = 24,
	    cooldowncheck = 0,
            combat = true
        },
        {
            spell = WCLocale.DRUID.Abolish_Poison,
            trigger = WCLocale.DRUID.Abolish_Poison_trigger,
            level = 26,
	    cooldowncheck = 0,
            combat = true
        },
    },
    PALADIN = {
        {
            spell = WCLocale.PALADIN.Blessing_of_Might,
            trigger = WCLocale.PALADIN.Blessing_of_Might_trigger,
            level = 4,
	    cooldowncheck = 0,
            rank = { 4, 12, 22, 32, 42, 52, 60 }
        },
        {
            spell = WCLocale.PALADIN.Blessing_of_Wisdom,
            trigger = WCLocale.PALADIN.Blessing_of_Wisdom_trigger,
            level = 14,
	    cooldowncheck = 0,
            rank = { 14, 24, 34, 44, 54, 60 },
            combat = true
        },
        {
            spell = WCLocale.PALADIN.Blessing_of_Freedom,
            trigger = WCLocale.PALADIN.Blessing_of_Freedom_trigger,
            level = 18,
	    cooldowncheck = 0,
            rank = WCLocale.PALADIN.Blessing_of_Freedom_rank
        },
        {
            spell = WCLocale.PALADIN.Blessing_of_Light,
            trigger = WCLocale.PALADIN.Blessing_of_Light_trigger,
            level = 40,
	    cooldowncheck = 0,
            rank = { 40, 50, 60 }
        },
        {
            spell = WCLocale.PALADIN.Blessing_of_Sacrifice,
            trigger = WCLocale.PALADIN.Blessing_of_Sacrifice_trigger,
            level = 46,
	    cooldowncheck = 1,
            rank = { 46, 54 }
        },
        {
            spell = WCLocale.PALADIN.Blessing_of_Kings,
            trigger = WCLocale.PALADIN.Blessing_of_Kings_trigger,
            level = 40,
	    cooldowncheck = 0
        },
        {
            spell = WCLocale.PALADIN.Blessing_of_Salvation,
            trigger = WCLocale.PALADIN.Blessing_of_Salvation_trigger,
            level = 26,
	    cooldowncheck = 0
        },
        {
            spell = WCLocale.PALADIN.Blessing_of_Sanctuary,
            trigger = WCLocale.PALADIN.Blessing_of_Sanctuary_trigger,
            level = 20,
	    cooldowncheck = 0,
            rank = { 20, 30, 40, 50, 60 }
        },
        {
            spell = WCLocale.PALADIN.Cleanse,
            trigger = WCLocale.PALADIN.Cleanse_trigger,
            level = 32,
	    cooldowncheck = 0,
            combat = true
        },
        {
            spell = WCLocale.PALADIN.Purify,
            trigger = WCLocale.PALADIN.Purify_trigger,
            level = 18,
	    cooldowncheck = 0,
            combat = true
        },
	{
            spell = WCLocale.PALADIN.Greater_Blessing_of_Might,
            trigger = WCLocale.PALADIN.Greater_Blessing_of_Might_trigger,
            level = 52,
	    cooldowncheck = 0,
	    rank = { 52, 60 }
        },
	{
            spell = WCLocale.PALADIN.Greater_Blessing_of_Wisdom,
            trigger = WCLocale.PALADIN.Greater_Blessing_of_Wisdom_trigger,
            level = 54,
	    cooldowncheck = 0,
	    rank = { 54, 60 }
        },
	{
            spell = WCLocale.PALADIN.Greater_Blessing_of_Light,
            trigger = WCLocale.PALADIN.Greater_Blessing_of_Light_trigger,
            level = 60,
	    cooldowncheck = 0,
	    rank = { 60 }
        },
	{
            spell = WCLocale.PALADIN.Greater_Blessing_of_Kings,
            trigger = WCLocale.PALADIN.Greater_Blessing_of_Kings_trigger,
            level = 60,
	    cooldowncheck = 0
        },
	{
            spell = WCLocale.PALADIN.Greater_Blessing_of_Salvation,
            trigger = WCLocale.PALADIN.Greater_Blessing_of_Salvation_trigger,
            level = 60,
	    cooldowncheck = 0
        },
	{
            spell = WCLocale.PALADIN.Greater_Blessing_of_Sanctuary,
            trigger = WCLocale.PALADIN.Greater_Blessing_of_Sanctuary_trigger,
            level = 60,
	    cooldowncheck = 0,
	    rank = { 60 }
        },
    },
    SHAMAN = {
        {
            spell = WCLocale.SHAMAN.Cure_Poison,
            trigger = WCLocale.SHAMAN.Cure_Poison_trigger,
            level = 16,
	    cooldowncheck = 0,
            combat = true
        },
        {
            spell = WCLocale.SHAMAN.Cure_Disease,
            trigger = WCLocale.SHAMAN.Cure_Disease_trigger,
            level = 22,
	    cooldowncheck = 0,
            combat = true
        },
        {
            spell = WCLocale.SHAMAN.Water_Breathing,
            trigger = WCLocale.SHAMAN.Water_Breathing_trigger,
            level = 22,
	    cooldowncheck = 0,
            combat = true
        },
    },
    WARLOCK = {
        {
            spell = WCLocale.WARLOCK.Unending_Breath,
            trigger = WCLocale.WARLOCK.Unending_Breath_trigger,
            level = 16,
	    cooldowncheck = 0,
            combat = true
        },
        {
            spell = WCLocale.WARLOCK.Detect_Greater_Invisibility,
            trigger = WCLocale.WARLOCK.Detect_Greater_Invisibility_trigger,
            level = 50,
	    cooldowncheck = 0
        },
        {
            spell = WCLocale.WARLOCK.Ritual_of_Summoning,
            trigger = WCLocale.WARLOCK.Ritual_of_Summoning_trigger,
            level = 20,
	    cooldowncheck = 0,
            leavetargeted = true,
        },
    },
};

-- chat frame where queue messages go
local WhisperCast_messages = DEFAULT_CHAT_FRAME;

-- keep track of if we are in combat
local WhisperCast_playerInCombat = false

function WhisperCast_registerGUI( params )
    wc_insert( WhisperCast_Runtime.guis, params );
end

function WhisperCast_executeGUIs( funcName, param1, param2, param3, param4 )
    local result = false
    for k,v in WhisperCast_Runtime.guis do
        if ( v ) then
            local func = getglobal(v[funcName]);
            if ( func ) then
                if ( func(param1, param2, param3, param4) ) then
                    result = true
                end
            end
        end
    end
    return result
end

local function WhisperCast_getQueueTextColor(cast)
    if ( WhisperCast_Profile.restrictcombat == 1 and 
         WhisperCast_playerInCombat and
         not WhisperCast_Spells[cast["spell"]].combat ) then

         return "|cFF909090","|r", false;
    else
        if ( cast["fail"] ) then
            return "|cFF00FF00","|r|cFFFF0000"..format(WCLocale.UI.text.queueSummaryFail,cast["fail"]).."|r", true;
        else
            return "|cFF00FF00","|r",true;
        end
    end
end

local function WhisperCast_updateQueue()
    local castableQueue=0
    local queueDetail=""
    for i=WhisperCast.min,WhisperCast.next-1,1 do

        local cast = WhisperCast[i]
        if ( cast ) then
            local c1,c2,canCast = WhisperCast_getQueueTextColor(cast);
            if ( canCast ) then
                castableQueue = castableQueue + 1
            end
            queueDetail=queueDetail..
                c1..
                format(WCLocale.UI.text.queueSummary, cast["name"], cast["spell"])..
                c2.."\n"
        end
    end

    local queueBrief = ""
    local queueBriefColor = nil

    if ( WhisperCast_Profile.enable == 0 ) then
        queueBrief = WCLocale.UI.text.queueBriefDisabled
        queueBriefColor = RED_FONT_COLOR
    elseif ( castableQueue == 0 ) then
        queueBrief = WCLocale.UI.text.queueBriefEmpty
        queueBriefColor = NORMAL_FONT_COLOR
    else
        queueBrief = format(WCLocale.UI.text.queueBriefQueued, castableQueue)
        queueBriefColor = GREEN_FONT_COLOR
    end

    WhisperCast_Runtime.queueLength = castableQueue
    WhisperCast_Runtime.queueBrief = queueBrief
    WhisperCast_Runtime.queueDetail = queueDetail
    WhisperCast_Runtime.queueBriefColor = queueBriefColor

    WhisperCast_executeGUIs("sync", "queue");
end

local function WhisperCast_queue(cast)
    WhisperCast[WhisperCast.next] = cast;
    WhisperCast.next = WhisperCast.next + 1;
    WhisperCast.n = WhisperCast.n + 1;

    WhisperCast_updateQueue();
end

local function WhisperCast_requeue(cast)

    if ( cast ) then

        local timeNow = GetTime();

        if ( not cast.fail ) then
            cast.fail = 1
            cast.failtime = timeNow
        else
            -- only add a failure if it has been longer than the grace time
            if ( timeNow - cast.failtime > WhisperCast_Profile.failuregracetime ) then
                cast.fail = cast.fail + 1
                cast.failtime = timeNow
            end
        end

        -- still some fails left, append to the end of queue
        if ( cast.fail < WhisperCast_Profile.failures ) then
            WhisperCast[WhisperCast.next] = cast;
            WhisperCast.next = WhisperCast.next + 1;
            WhisperCast.n = WhisperCast.n + 1;

            WhisperCast_updateQueue();

            return true
        end
    end
    return false
end

local function WhisperCast_dequeue(i, mightWorkLater)

    local wasDequeued = true

    if ( WhisperCast[i] ) then

        -- this can work later, requeue if there are failures remaining
        if ( mightWorkLater ) then
            wasDequeued = not WhisperCast_requeue( WhisperCast[i] )
        end

        -- remove and reset min index
        WhisperCast[i] = nil
        WhisperCast.n = WhisperCast.n - 1;
        if ( WhisperCast.min == i ) then
            local minReset = false
            for j=WhisperCast.min,WhisperCast.next-1 do
                if ( WhisperCast[j] ) then
                    WhisperCast.min = j
                    minReset = true
                    break
                end
            end
            if ( not minReset ) then
                WhisperCast.min = WhisperCast.next
            end
        end

        WhisperCast_updateQueue();
    end

    return wasDequeued
end

local function WhisperCast_clear()
    if ( WhisperCast_Profile.feedbackwhisper == 1 ) then

        for i=WhisperCast.min,WhisperCast.next-1,1 do

            local cast = WhisperCast[i]
            if ( cast ) then
                WhisperCast_sendWhisper( cast.name,
                    format(WCLocale.UI.text.feedbackWhisperCleared, cast.spell) )
            end
        end
    end

    WhisperCast = { min=1, next=1, n=0 }
    WhisperCast_updateQueue()

    WhisperCast_messages:AddMessage(WCLocale.UI.text.queueFeedbackCleared)
end

local function WhisperCast_findspell(msg)

    if ( WhisperCast_Spells ) then
        local lower_msg = string.lower(msg)

        -- find a spell that I can cast matching the trigger message
        for spell,attrib in WhisperCast_Spells do

            -- make sure there is atlest one spell in my spellbook
            if ( not wc_isempty(attrib.spellid) ) then

                for _, trigger in attrib.trigger do

                    -- match exactly, ignore any white space
                    if ( string.find(lower_msg,"^ *"..trigger.." *$" ) ) then
                        return spell
                    end
                    if ( WhisperCast_Profile.match == "start" or 
                         WhisperCast_Profile.match == "any" ) then
                        -- match message that starts with trigger
                        if ( string.find(lower_msg,"^ *"..trigger.." +") ) then
                            return spell
                        end
                    end
                    if ( WhisperCast_Profile.match == "any" ) then
                        -- match any ` with a complete trigger word
                        if ( string.find(lower_msg," +"..trigger.." *$") or
                             string.find(lower_msg," +"..trigger.." +") ) then
                            return spell
                        end
                    end

                    if ( lower_msg == trigger ) then
                        return spell
                    end
                end
            end
        end
    end

    return nil;
end

local function WhisperCast_isInMyGroup(unitName)

    if ( unitName == UnitName("player" ) ) then

        return true

    elseif ( GetNumRaidMembers() > 0 ) then

        for i=1,40,1 do
            local trialUnit = "raid"..i;
            if ( unitName == UnitName(trialUnit) ) then
                return true
            end
        end

    elseif ( GetNumPartyMembers() > 0 ) then

        for i, trialUnit in { "party1", "party2", "party3", "party4" } do
            if ( unitName == UnitName(trialUnit) ) then
                return true
            end
        end
    end
    return false
end

local function WhisperCast_findSpellFromWhisper(name, trigger)
    if ( not name ) then return nil end

    if ( WhisperCast_Profile.grouponly == 1 ) then
        if ( not WhisperCast_isInMyGroup( name ) ) then
            return nil
        end
    end

    local spellName = WhisperCast_findspell(trigger);
    if ( not spellName ) then return nil end

    -- don't queue if this spell is disabled
    if ( WhisperCast_Profile.disabledSpells[spellName] ) then return nil end

    return spellName
end

-- Function to check for spell cooldown
local function WhisperCast_CheckCooldown(spell)
	local i,done,name,id=1,false,secondsleft;
	while (not done) do
		local name = GetSpellName(i,BOOKTYPE_SPELL);
		local start, duration, enable = GetSpellCooldown(i, BOOKTYPE_SPELL);
		if (not name) then
			done=true;
		elseif (name == spell) then
			if ( start > 0 and duration > 0 and enable > 0) then
				-- Cooldown left
				secondsleft = 0;
				local time = GetTime();
				secondsleft = duration - ceil(( time - start ));
				secondsleft = floor(secondsleft/60) .. " min " .. mod(secondsleft,60) .. " sec.";
				return true, secondsleft;
			else
				-- There should be no cooldown
				return false;
			end
		end
		i = i+1;
	end
end

local function WhisperCast_isWhisperCastWhisper(name, trigger)

    if ( string.find(string.lower(trigger), "^ *"..WCLocale.UI.text.whisperCmdAnnounce.." *$") ) then
        return true
    elseif ( WhisperCast_findSpellFromWhisper(name, trigger) ) then
        return true
    end
    return false
end

local function WhisperCast_processWhisper(name, trigger)

    if ( string.find(string.lower(trigger), "^ *"..WCLocale.UI.text.whisperCmdAnnounce.." *$") ) then

        local sentHeader = false
        for spell,attrib in WhisperCast_Spells do

            if ( not WhisperCast_Profile.disabledSpells[spell] and
                 not wc_isempty(attrib.spellid) and
                 not wc_isempty(attrib.trigger) ) then

                if ( not sentHeader ) then
                    WhisperCast_sendWhisper( name, WCLocale.UI.text.whisperCmdAnnounceHeader );
                    sentHeader = true
                end

                _,trigger = wc_first(attrib.trigger)

                WhisperCast_sendWhisper( name, 
                    format(WCLocale.UI.text.whisperCmdAnnounceSpell, spell, trigger) )
            end
        end

        if ( not sentHeader ) then
            WhisperCast_sendWhisper( name, WCLocale.UI.text.whisperCmdAnnounceNoSpells );
        end
    else
        local spellName = WhisperCast_findSpellFromWhisper( name, trigger )
        if ( not spellName ) then return false end

        if ( WhisperCast_Profile.enable == 0 ) then
            if ( WhisperCast_Profile.feedbackwhisper == 1 ) then
                WhisperCast_sendWhisper( name, 
                    format(WCLocale.UI.text.feedbackWhisperDisabled, spellName) )
            end
            return false
        end

	-- get the non-localized player class
	_, class = UnitClass("player");

	if ( not WhisperCast_Spells ) then
		-- This is for when the game loads
	else
		if ( WhisperCast_Spells[spellName]["cooldowncheck"] == 1 ) then
			local hascooldown, secondsleft = WhisperCast_CheckCooldown(spellName);
			if ( hascooldown ) then
				WhisperCast_sendWhisper( name,
					format(WCLocale.UI.text.feedbackWhisperAnnounceCooldown, spellName, secondsleft) );
				return false;
			end
		end
	end
	

        -- make sure this spell isn't already queued
        for i=WhisperCast.min,WhisperCast.next-1,1 do
            local cast = WhisperCast[i]
            if ( cast ) then
                if ( cast.name == name and cast.spell == spellName ) then
                    -- reset failures if we are re-whispered
                    if ( cast.fail ) then
                        cast.fail = nil
                        WhisperCast_updateQueue()
                    end
                    WhisperCast_messages:AddMessage(
                        format(WCLocale.UI.text.queueFeedbackDuplicate, cast.spell, cast.name));

                    if ( WhisperCast_Profile.feedbackwhisper == 1 ) then
                        WhisperCast_sendWhisper( cast.name,
                            format(WCLocale.UI.text.feedbackWhisperDuplicate, cast.spell) )
                    end
                    return false
                end
            end
        end

        local newCast = {};
        newCast.name = name;
        newCast.spell = spellName;

        WhisperCast_messages:AddMessage(
            format(WCLocale.UI.text.queueFeedbackQueued, newCast.spell, newCast.name));

        if ( WhisperCast_Profile.feedbackwhisper == 1 ) then
            WhisperCast_sendWhisper( newCast.name,
                format(WCLocale.UI.text.feedbackWhisperQueued, newCast.spell) )
        end

        WhisperCast_queue(newCast)

        if ( WhisperCast_Profile.playsound.firstqueue == 1 and WhisperCast_Runtime.queueLength == 1 ) then
            PlaySoundFile(WHISPERCAST_ADDON_PATH.."firstqueue.wav")
        end

        return true
    end
end

function WhisperCast_sendWhisper(name,message)
    SendChatMessage(WCLocale.UI.text.sendWhisperPrefix..message, "WHISPER", nil, name)
end


local function WhisperCast_findRankedSpellName(spellName, targetLevel)
    local playerLevel = UnitLevel("player")

    if ( not WhisperCast_Spells ) then
        return nil, format(WCLocale.UI.text.spellsNone, UnitClass("player"))
    end

    local spell = WhisperCast_Spells[spellName]
    if ( not spell ) then
        return nil, format(WCLocale.UI.text.spellsUnknown, spellName)
    end

    if ( wc_isempty(spell.spellid) ) then
        return nil, format(WCLocale.UI.text.spellsNotLearned, spellName)
    end

    if ( spell.rank ) then

        local rankToCast = 0
        local actionIdRank = nil;

        -- Find the highest rank of the spell I know for our targets level.
        -- Also find the best action id to check castability.
        for spellRank,spellLevel in spell.rank do
            if ( spell.spellid[spellRank] ) then
                if ( rankToCast < spellRank and targetLevel >= spellLevel-10 ) then
                    rankToCast = spellRank;
                    if ( spell.actionid[spellRank] ) then
                        actionIdRank = spellRank
                    end
                else
                    -- make sure we have some actionid even if it doesn't match the
                    -- rank being cast
                    if ( not actionIdRank ) then
                        if ( spell.actionid[spellRank] ) then
                            actionIdRank = spellRank
                        end
                    end
                end
            end
        end

        -- we can cast some rank of this spell, has to be target level too low
        if ( rankToCast == 0 ) then
            return nil, WCLocale.UI.text.spellsLevelTooLow
        end

        return { name=spellName,
                 fullName=spellName..format(WCLocale.UI.rank, rankToCast),
                 spellRank=rankToCast, 
                 spellid=spell.spellid[rankToCast],
                 actionRank=actionIdRank,
                 actionid=spell.actionid[actionIdRank] }
    else
        -- spell isn't ranked, just return its name
        return { name=spellName, 
                 fullName=spellName,
                 spellRank=0,
                 spellid=spell.spellid[0],
                 actionRank=0,
                 actionid=spell.actionid[0] }
    end
end

local function WhisperCast_TargetByName( unitName )

    TargetByName( unitName )
    if ( unitName ~= UnitName("target") ) then
        for i, trialUnit in { "party1", "party2", "party3", "party4" } do
            if ( unitName == UnitName(trialUnit) ) then
                TargetUnit( trialUnit )
                return true, true
            end
        end
        for i=1,40,1 do
            local trialUnit = "raid"..i;
            if ( unitName == UnitName(trialUnit) ) then
                TargetUnit( trialUnit )
                return true, true
            end
        end
        return false, false
    else
        return true, false
    end
end

local WhisperCast_timeLastSpellCast = 0;
local WhisperCast_lastSpellCast = nil;
local WhisperCast_lastSpellErrorMessage = nil;

local function WhisperCast_cast()

    if ( WhisperCast.n == 0 ) then
        if ( WhisperCast_Profile.playsound.emptyqueue == 1 ) then
            PlaySound("igMainMenuOpen")
        end
        return
    end

    -- remember some stuff to restore target when finished
    local originalTargetWasEnemy = false
    local originalTargetName = nil
    if ( UnitExists("target" ) ) then
        if ( UnitCanAttack("player","target") ) then
            originalTargetWasEnemy = true
        elseif ( UnitIsPlayer("target") ) then
            originalTargetName = UnitName("target")
        end
    end

    local targetWasChanged = false
    local targetShouldBeRestored = true

    local qMin, qNext = WhisperCast.min, WhisperCast.next
    local i

    for i=qMin,qNext-1,1 do
        local cast = WhisperCast[i]
        if ( cast ) then
            -- only cast combat flagged spells while we are engaged
            if ( WhisperCast_Profile.restrictcombat == 0 or
                 not WhisperCast_playerInCombat or 
                 WhisperCast_Spells[cast.spell].combat ) then

                -- aquire target to gets its level
                ClearTarget()
                targetWasChanged = true;

                local gotTarget, longRangeTarget = WhisperCast_TargetByName( cast.name )
                if ( not gotTarget ) then
                    WhisperCast_messages:AddMessage(
                        format(WCLocale.UI.text.castingCantTarget, cast.name, cast.spell) );
                    WhisperCast_dequeue(i,true); -- can try later
                    ClearTarget();
                else
                    local rankedSpell, reason =
                        WhisperCast_findRankedSpellName( cast.spell, UnitLevel("target") )
                    if ( not rankedSpell ) then
                        WhisperCast_messages:AddMessage(
                            format(WCLocale.UI.text.castingCantCast, cast.spell, cast.name, reason) )
                        WhisperCast_dequeue(i,false); -- isn't going to work later
                    else
                        local castSpell = false
                        local userFailure = false
                        local userFailureMessage = ""

                        -- use smart spell checking if we have an action
                        -- button for this, it is only a user error if the
                        -- target is out of range
                        if ( rankedSpell.actionid ) then
                            local start, duration, enable = GetActionCooldown(rankedSpell.actionid)
                            if ( enable==1 and duration == 0) then
                                local isUsable,a = IsUsableAction(rankedSpell.actionid);
                                if ( isUsable==1 ) then
                                    local inRange,b = IsActionInRange(rankedSpell.actionid);
                                    if ( inRange==0 ) then
                                        UIErrorsFrame:AddMessage(
                                            format(WCLocale.UI.text.castingOutOfRange, cast.name, cast.spell), 1.0, 0, 0, 1.0, UIERRORS_HOLD_TIME);
                                        WhisperCast_messages:AddMessage(
                                            format(WCLocale.UI.text.castingOutOfRange, cast.name, rankedSpell.fullName) );
                                        userFailure = true
                                        userFailureMessage = ERR_SPELL_OUT_OF_RANGE
                                    else
                                        castSpell = true
                                    end
                                end
                            end
                        else
                            -- no smart cast so just try it and blame any
                            -- error on the target
                            castSpell = true
                            userFailure = true
                            userFailureMessage = ""
                        end

                        if ( castSpell ) then
                            WhisperCast_messages:AddMessage(
                                format(WCLocale.UI.text.castingCasting, rankedSpell.fullName, cast.name) );

                            -- save any ui error frame messages caused by the cast, some error message
                            -- come back instantly.  the other will be caught in our OnEvent handler
                            local spellCastFailed = false
                            WhisperCast_lastSpellCast = nil
                            WhisperCast_lastSpellErrorMessage = nil

                            CastSpell(rankedSpell.spellid,BOOKTYPE_SPELL);

                            -- client triggered an instant cast error
                            if ( WhisperCast_lastSpellErrorMessage ) then
                                WhisperCast_messages:AddMessage(
                                    format(WCLocale.UI.text.castingCantCast, rankedSpell.fullName, cast.name,
                                    WhisperCast_lastSpellErrorMessage) );

                                -- dequeue as a failure in these cases
                                if ( WhisperCast_lastSpellErrorMessage == ERR_SPELL_OUT_OF_RANGE ) then
                                    spellCastFailed = true
                                    userFailure = true
                                    userFailureMessage = ERR_SPELL_OUT_OF_RANGE
                                end

                                -- were were running, not the targets fault and we can possibly try another spell
                                if ( WhisperCast_lastSpellErrorMessage == SPELL_FAILED_MOVING ) then
                                    spellCastFailed = true
                                    userFailure = false
                                end

                                -- no need to go on and try other spells if we are not in a castable position
                                if ( WhisperCast_lastSpellErrorMessage == SPELL_FAILED_NOT_STANDING or
                                     WhisperCast_lastSpellErrorMessage == SPELL_FAILED_NOT_MOUNTED or
                                     WhisperCast_lastSpellErrorMessage == SPELL_FAILED_NOT_ON_TAXI ) then
                                    spellCastFailed = true
                                    break;
                                end
                            end


                            WhisperCast_lastSpellErrorMessage= nil

                            if ( not spellCastFailed ) then

                                if ( not SpellIsTargeting() ) then

                                    WhisperCast_timeLastSpellCast = GetTime();
                                    WhisperCast_lastSpellCast = cast;

                                    if ( WhisperCast_Spells[cast.spell].leavetargeted ) then
                                        targetShouldBeRestored = false
                                    end

                                    -- cast went off, dequeue
                                    -- NOTE: Target could have been out of
                                    -- sight and really failed.  I can't check
                                    -- for that since it is done on the server.
                                    WhisperCast_dequeue(i,false)
                                    break;
                                end
                            end

                            -- target wasn't valid for this spell, maybe in dual
                            -- or raid restricted like power of word: shield
                            SpellStopTargeting()

                            -- this was a long range group/raid target taht probably isn't even in the zone
                            if ( longRangeTarget ) then
                                UIErrorsFrame:AddMessage(
                                    format(WCLocale.UI.text.castingOutOfRange, cast.name, cast.spell), 1.0, 0, 0, 1.0, UIERRORS_HOLD_TIME);
                                WhisperCast_messages:AddMessage(
                                    format(WCLocale.UI.text.castingOutOfRange, cast.name, cast.spell) );

                                userFailure = true
                                userFailureMessage = ERR_SPELL_OUT_OF_RANGE
                            end
                        end

                        -- problem was with the target, retry as a failure
                        if ( userFailure ) then
                            if ( WhisperCast_dequeue(i,true) ) then
                                if ( WhisperCast_Profile.feedbackwhisper == 1 ) then
                                    WhisperCast_sendWhisper( cast.name,
                                        format(WCLocale.UI.text.feedbackWhisperCastingUserFailure, cast.spell, userFailureMessage) )
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if ( targetShouldBeRestored and targetWasChanged ) then
        if ( originalTargetWasEnemy ) then
            TargetLastEnemy()
        elseif ( originalTargetName ) then
            if ( not WhisperCast_TargetByName( originalTargetName ) ) then
                ClearTarget()
            end
        else
            -- what ever was targeted we can't restore, so clear
            ClearTarget();
        end
    end
end

local function WhisperCast_populateSpellIds()

    -- clear the old spell ids
    for k,v in WhisperCast_Spells do
        v.spellid = {}
    end

    -- populate our spells with their spell book id
    local id = 1;
    local spellName, subSpellName = GetSpellName(id,BOOKTYPE_SPELL);
    while ( spellName ) do
        if ( WhisperCast_Spells[spellName] ) then
            local spellid = WhisperCast_Spells[spellName].spellid
            if ( subSpellName and subSpellName ~= "" ) then
                local _, _, spellRank = string.find(subSpellName, WCLocale.UI.rankMatch);
                if ( spellRank and tonumber(spellRank) and not spellid[spellRank] ) then
                    wc_insert(spellid,tonumber(spellRank),id)
                end
            else
                if ( not spellid[0] ) then
                    wc_insert(spellid,0,id)
                end
            end
        end
        id = id + 1;
        spellName, subSpellName = GetSpellName(id,BOOKTYPE_SPELL);
    end
end

-- return name,rank of the spell on action button buttonId, concept borrowed
-- from UberActions
local function WhisperCast_getButtonNameAndRank( buttonId )

    -- a spell button has an action, don't have action text, and 
    -- has a texture, and no action count
    -- best way I know to determine if this is a spell or not
    if ( HasAction( buttonId ) and 
         not GetActionText( buttonId ) and
         GetActionTexture( buttonId ) and
         GetActionCount( buttonId ) == 0 ) then

	

        WCTooltipTextLeft1:SetText("")
        WCTooltipTextRight1:SetText("")

        -- In case money line is visible on GameTooltip, must protect it by
        -- overriding GameTooltip_ClearMoney. This is because calling SetOwner
        -- or SetxxxItem on any tooltip causes money line of GameTooltip to be
        -- cleared.
        local oldFunction = GameTooltip_ClearMoney;
        GameTooltip_ClearMoney = function() end;
            

	-- Fix Tooltip Error!
	GameTooltip_SetDefaultAnchor(WCTooltip, UIParent);

        WCTooltip:SetAction( buttonId )

        -- Restore GameTooltip_ClearMoney overriding.
        GameTooltip_ClearMoney = oldFunction;

        local name = WCTooltipTextLeft1:GetText();
        if ( name ) then
            local rightText = WCTooltipTextRight1:GetText()
            local rank = nil
            if ( rightText and rightText ~= "" ) then
                local _, _, spellRank = string.find(rightText, WCLocale.UI.rankMatch);
                if ( spellRank and tonumber(spellRank) ) then
                    rank = tonumber(spellRank);
                end
            end
            return name,rank
        end

	WCTooltip:Hide();

    end
    return nil,nil
end

local function WhisperCast_populateSpellActionButtons()

    -- clear the old action ids
    for k,v in WhisperCast_Spells do
        v.actionid = {}
    end

    -- 120 hard coded action buttons in the UI
    for id=1,120,1 do
        local spellName, spellRank = WhisperCast_getButtonNameAndRank( id )
	WCTooltip:Hide();

        if ( spellName ) then
            if ( WhisperCast_Spells[spellName] ) then
                local actionid = WhisperCast_Spells[spellName].actionid;
                if ( spellRank ) then
                    if ( not actionid[spellRank] ) then
                        wc_insert( actionid, spellRank, id )
                    end
                else
                    if ( not actionid[0] ) then
                        wc_insert( actionid, 0, id )
                    end
                end
            end
        end
    end
end

local function WhisperCast_reset()

    WhisperCast_Profile = WhisperCastUtil_copyTable( WhisperCast_defaultProfile )

    WhisperCast_clear()

    WhisperCast_executeGUIs("reset")
end

local function WhisperCast_initialize()

    -- wipe out the profile if it has changed to be inconsistant
    if ( WhisperCast_Profile.profileversion ~= WhisperCast_defaultProfile.profileversion ) then
        WhisperCast_Profile = WhisperCastUtil_copyTable( WhisperCast_defaultProfile )
    else
        -- make sure the player profile has all our default values in it
        for k1,v1 in WhisperCast_defaultProfile do
            if ( type(v1) == "table" ) then
                if ( not WhisperCast_Profile[k1] ) then
                    WhisperCast_Profile[k1]={}
                end
                for k2,v2 in v1 do
                    if ( not WhisperCast_Profile[k1][k2] ) then
                        WhisperCast_Profile[k1][k2]=v2
                    end
                end
            else
                if ( not WhisperCast_Profile[k1] ) then
                    WhisperCast_Profile[k1] = v1
                end
            end
        end
    end
    
    -- get the non-localized player class
    _, class = UnitClass("player");

    -- initialize our spells our of the library
    if ( WhisperCast_SpellLibrary[class] ) then

        WhisperCast_Spells = {}

        for _, spell in WhisperCast_SpellLibrary[class] do
            -- load all spells that have a locale translation
            if ( spell.spell ) then
                WhisperCast_Spells[spell.spell] = spell;
            end
        end
    end

    if ( WhisperCast_Spells ) then
        WhisperCast_populateSpellIds()
        WhisperCast_populateSpellActionButtons()

        WhisperCast_ToggleEnabled( true )

        WhisperCast_updateQueue()

        if ( DEFAULT_CHAT_FRAME ) then
            -- check to make sure all our spells have atleast one rank on
            -- an action button
            local spellsWithoutActions = {}
            for k,v in WhisperCast_Spells do
                if ( not wc_isempty(v.spellid) ) then
                    if ( wc_isempty(v.actionid) ) then
                        wc_insert(spellsWithoutActions,k)
                    end
                end
            end

            if ( not wc_isempty(spellsWithoutActions) ) then
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatActionIdError1,1,0,0)
                for _,v in spellsWithoutActions do
                    DEFAULT_CHAT_FRAME:AddMessage("    "..v,1,0,0);
                end
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatActionIdError2,1,0,0);
            end
        end
    end

    WhisperCast_executeGUIs("initialize")
end

------------------------------------------------------------------------------
-- Externally access functions
------------------------------------------------------------------------------

function WhisperCast_ToggleProfileKey(keyValues)
    if ( not keyValues ) then
        if ( not this ) then
            return
        end
        keyValues = this.value
    end

    local key = nil
    local profile = WhisperCast_Profile

    -- deal with multi-depth key
    if ( type(keyValues) == "table" ) then

        -- key is the last in list
        key = keyValues[wc_getn(keyValues)]

        -- find the sub-table for the compount keys
        for i=1,(wc_getn(keyValues)-1),1 do
            local subKey = keyValues[i]
            if ( type(profile[subKey]) ~= "table" ) then 
                return
            end
            profile = profile[subKey]
        end
    else
        key = keyValues
    end

    if ( profile[key] == 1 ) then
        profile[key] = 0;
    else
        profile[key] = 1;
    end
end

function WhisperCast_OnLoad()
    this:RegisterEvent("PLAYER_ENTERING_WORLD");

    this:RegisterEvent("CHAT_MSG_WHISPER");
    this:RegisterEvent("PLAYER_REGEN_DISABLED");
    this:RegisterEvent("PLAYER_REGEN_ENABLED");

    this:RegisterEvent("SPELLS_CHANGED");
    this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");

   	this:RegisterEvent("UI_ERROR_MESSAGE");

    -- reset queue message output to 2nd chat frame if it exists
    if ( ChatFrame2 ) then
        WhisperCast_messages = ChatFrame2
    end

    SlashCmdList["WHISPERCAST"] = WhisperCast_SlashCommandHandler;
    SLASH_WHISPERCAST1 = "/wc";
    SLASH_WHISPERCAST2 = "/whispercast";

    WhisperCast_ChatFrame_Initialize()
end

function WhisperCast_OnEvent(event)

    -- if we are not initialized, only process PLAYER_ENTERING_WORLD
    if ( not WhisperCast_Spells ) then
        if ( event == "PLAYER_ENTERING_WORLD" ) then
            WhisperCast_initialize();
        end

        -- ignore any other events until we are initialized
        return
    end

    if (event == "CHAT_MSG_WHISPER") then
        if ( arg1 and arg2 ) then
            WhisperCast_processWhisper(arg2, arg1);
        end
    elseif ( event == "PLAYER_REGEN_DISABLED" ) then
        WhisperCast_playerInCombat = true;
        WhisperCast_updateQueue();
    elseif ( event == "PLAYER_REGEN_ENABLED" ) then
        WhisperCast_playerInCombat = false;
        WhisperCast_updateQueue();
    elseif ( event == "SPELLS_CHANGED" ) then
        WhisperCast_populateSpellIds();
    elseif ( event == "ACTIONBAR_SLOT_CHANGED" ) then
        WhisperCast_populateSpellActionButtons();
    elseif ( event == "UI_ERROR_MESSAGE" ) then
        WhisperCast_lastSpellErrorMessage = arg1
        if ( WhisperCast_lastSpellCast ) then
            -- make sure the spell was just cast
            if ( GetTime() - WhisperCast_timeLastSpellCast < 0.75 ) then
                -- requeue the last spell if there was an issue our button 
                -- checks said was ok but the server kicked it back
                if ( arg1 == SPELL_FAILED_OUT_OF_RANGE or
                     arg1 == SPELL_FAILED_LINE_OF_SIGHT or
                     arg1 == SPELL_FAILED_TARGET_NOT_IN_PARTY ) then
                    -- requeue as a failure, will be back if there are attempts remaining
                    if ( not WhisperCast_requeue( WhisperCast_lastSpellCast ) ) then
                        if ( WhisperCast_Profile.feedbackwhisper == 1 ) then
                            WhisperCast_sendWhisper( WhisperCast_lastSpellCast.name,
                                format(WCLocale.UI.text.feedbackWhisperCastingUserFailure, WhisperCast_lastSpellCast.spell, arg1) )
                        end
                    end
                    WhisperCast_lastSpellCast = nil

                elseif ( arg1 == ERR_SPELL_COOLDOWN ) then
                    -- requeue without a failure
                    WhisperCast_queue( WhisperCast_lastSpellCast )
                    WhisperCast_lastSpellCast = nil
                end
            end
        end
    end
end

local WC_elapsedOnUpdateTime = 0
local WC_elapsedOnUpdateThreshold = 1/15

function WhisperCast_OnUpdate(arg1)

    -- limit the UnUpdate to only ever elapsedOnUpdateThreshold sec
    WC_elapsedOnUpdateTime = WC_elapsedOnUpdateTime + arg1
    if ( WC_elapsedOnUpdateTime < WC_elapsedOnUpdateThreshold ) then
        return
    end

    WhisperCast_executeGUIs("onupdate", WC_elapsedOnUpdateTime)

    WC_elapsedOnUpdateTime = mod(WC_elapsedOnUpdateTime,WC_elapsedOnUpdateThreshold);
end

-- storage of our hooked chatframe onevent handler
local WhisperCast_ChatFrame_OnEvent_Original = nil

function WhisperCast_ChatFrame_OnEvent_Hook(event)

    -- The actually queueing of spell requrests isn't handled in this OnEven hook

    --  Hooked functions have a nasty habit of being overriden and never called by other mobs
    --  if this happens only whisper hidding will break and not the entire mod.
    if ( arg1 and arg2 ) then
        if ( WhisperCast_Spells ) then
            if ( WhisperCast_Profile.hidewhispers == 1 ) then
                if ( WhisperCast_Profile.enable == 1 ) then
                    -- whisper too me
                    if ( event == "CHAT_MSG_WHISPER" ) then
                        if ( WhisperCast_isWhisperCastWhisper( arg2, arg1 ) ) then
                            -- don't display whispercast whisper
                            return
                        end
                    end
                end
                -- whisper I am sending
                if ( event == "CHAT_MSG_WHISPER_INFORM" ) then
                    if ( string.find(arg1,"^"..WCLocale.UI.text.sendWhisperPrefix ) ) then
                        -- hide whispers that I am sending
                        return
                    end
                end
            end
        end
    end

    -- call original function to display the whisper
    WhisperCast_ChatFrame_OnEvent_Original(event, arg1, name);
end

function WhisperCast_ChatFrame_Initialize()

    if ( ChatFrame_OnEvent ~= WhisperCast_ChatFrame_OnEvent_Hook ) then
        -- hook the chatframe onevent to allow us to hide the queue requrests if we want
        WhisperCast_ChatFrame_OnEvent_Original = ChatFrame_OnEvent
        ChatFrame_OnEvent = WhisperCast_ChatFrame_OnEvent_Hook
    end
end

-- button functions
function WhisperCast_Cast()
    -- make sure we are initialized
    if ( not WhisperCast_Spells ) then return end

    WhisperCast_cast()
end

function WhisperCast_Clear()
    -- make sure we are initialized
    if ( not WhisperCast_Spells ) then return end

    WhisperCast_clear()
end

function WhisperCast_ToggleEnabled(sync)
    -- make sure we are initialized
    if ( not WhisperCast_Spells ) then return end

    if ( not sync ) then
        WhisperCast_ToggleProfileKey("enable");
    end
    if ( WhisperCast_Profile.enable == 0 ) then
        WhisperCast_clear()
    else
        WhisperCast_updateQueue()
    end
    WhisperCast_executeGUIs("sync","enable");
end

-- menu functions
function WhisperCast_ToggleRestrictCombat()
    WhisperCast_ToggleProfileKey("restrictcombat");
    WhisperCast_updateQueue();
end

function WhisperCast_ToggleSpellDisable(spell)

    if ( not spell and this ) then spell = this.value end

    if ( spell and WhisperCast_Spells[spell] ) then
        if ( WhisperCast_Profile.disabledSpells[spell] ) then
            WhisperCast_Profile.disabledSpells[spell] = nil;
        else
            WhisperCast_Profile.disabledSpells[spell] = true;
        end
    end
end

function WhisperCast_SetMatch(match)
    if ( not match and this ) then match = this.value end

    if ( match ) then
        WhisperCast_Profile.match = match;
    end
end

function WhisperCast_SlashCommandHandler(msg)

    -- make sure we are initialized
    if ( not WhisperCast_Spells ) then
        DEFAULT_CHAT_FRAME:AddMessage(CHAT_GREEN..format(WCLocale.UI.text.whisperCastVersion, WhisperCast_Version)..CHAT_END);
        DEFAULT_CHAT_FRAME:AddMessage(CHAT_RED..WCLocale.UI.text.chatNoSpells..CHAT_END);
        return
    end

    if ( msg ) then
        lower_msg = string.lower(msg)

        local _,_,command = string.find(lower_msg,"(%l+)");
        local _,_,option = string.find(lower_msg,"%l+ +(%l+)")

        if( command ) then
            if( command == WCLocale.UI.text.chatCmdEnable ) then
                WhisperCast_Profile.enable = 1
                WhisperCast_ToggleEnabled(true)
            elseif( command == WCLocale.UI.text.chatCmdDisable ) then
                WhisperCast_Profile.enable = 0
                WhisperCast_ToggleEnabled(true)
            elseif( command == WCLocale.UI.text.chatCmdCast ) then
                WhisperCast_Cast();
            elseif( command == WCLocale.UI.text.chatCmdClear ) then
                WhisperCast_Clear();
            elseif( command == WCLocale.UI.text.chatCmdReset ) then
                WhisperCast_reset();
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdResetFeedback);
            elseif( command == WCLocale.UI.text.chatCmdMatch ) then
                local feedback = false
                if ( option ) then
                    local found = false
                    for k,v in WCLocale.UI.text.chatCmdMatchValues do
                        if ( v == option ) then
                            WhisperCast_Profile.match = k
                            found = true
                            feedback = true
                            break
                        end
                    end
                    if ( not found ) then
                        DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdMatchError)
                    end
                else
                    feedback = true
                end
                if ( feedback ) then
                    local localeMatchName = WhisperCastUtil_nvl(
                        WCLocale.UI.text.chatCmdMatchValues[WhisperCast_Profile.match], "" )
                    DEFAULT_CHAT_FRAME:AddMessage(
                        format(WCLocale.UI.text.chatCmdMatchFeedback, localeMatchName) )
                end
            elseif( command == WCLocale.UI.text.chatCmdStatus ) then
                DEFAULT_CHAT_FRAME:AddMessage(CHAT_GREEN..WCLocale.UI.text.chatCmdStatusHeader..CHAT_END)
                for spell,attrib in WhisperCast_Spells do
                    local stat = spell;
                    if ( wc_isempty(attrib.spellid) ) then
                        if ( UnitLevel("player") < attrib.level ) then
                            stat = stat..CHAT_RED.." ("..WCLocale.UI.text.chatCmdStatusLowLevel..")"..CHAT_END
                        else
                            stat = stat..CHAT_RED.." ("..WCLocale.UI.text.chatCmdStatusNotLearned..")"..CHAT_END
                        end
                        stat = stat.." "..CHAT_RED..WCLocale.UI.text.chatCmdStatusQueueDisabled..CHAT_END
                    else
                        if ( WhisperCast_Profile.disabledSpells[spell] ) then
                            stat = stat..CHAT_RED.." ("..WCLocale.UI.text.chatCmdStatusDisabled..")"..CHAT_END
                        elseif ( wc_isempty(attrib.actionid) ) then
                            stat = stat..CHAT_RED.." ("..WCLocale.UI.text.chatCmdStatusNoSmartCast..")"..CHAT_END
                        else
                            stat = stat..CHAT_GREEN.." ("..WCLocale.UI.text.chatCmdStatusSmartCast..")"..CHAT_END
                        end
                        if ( wc_isempty(attrib.trigger) ) then
                            stat = stat..WCLocale.UI.text.chatCmdStatusNoTriggers
                        else
                            stat = stat..WCLocale.UI.text.chatCmdStatusTriggerPrefix
                            for _,trigger in attrib.trigger do
                                stat = stat.." '"..trigger.."'"
                            end
                        end
                    end
                    DEFAULT_CHAT_FRAME:AddMessage(stat);
                end

            elseif( command == WCLocale.UI.text.chatCmdDebug ) then
                -- debug output not localized
                DEFAULT_CHAT_FRAME:AddMessage(CHAT_GREEN.."WhisperCast spell debug:"..CHAT_END)
                for spellName,attrib in WhisperCast_Spells do
                    DEFAULT_CHAT_FRAME:AddMessage("'"..spellName.."' - level="..attrib.level);
                    local stat
                    if ( not option or option == "rank" ) then
                        if ( attrib.rank ) then
                            stat = "     rank/level="
                            for spellRank,spellLevel in attrib.rank do
                                stat = stat..spellRank.."-"..spellLevel.." "
                            end
                        else
                            stat = "     (not ranked)"
                        end
                        DEFAULT_CHAT_FRAME:AddMessage(stat);
                    end
                    if ( not option or option == "spellid" ) then
                        stat = "     spellid="
                        for i,spellid in attrib.spellid do
                            stat = stat..i.."-"..spellid.." "
                        end
                        DEFAULT_CHAT_FRAME:AddMessage(stat);
                    end
                    if ( not option or option == "actionid" ) then
                        stat = "     actionid="
                        for i,actionid in attrib.actionid do
                            stat = stat..i.."-"..actionid.." "
                        end
                        DEFAULT_CHAT_FRAME:AddMessage(stat);
                    end
                end

            elseif( command == WCLocale.UI.text.chatCmdAnnounce ) then

                local channel = nil
                if ( GetNumRaidMembers() > 0 ) then
                    channel = "RAID"
                elseif ( GetNumPartyMembers() > 0 ) then
                    channel = "PARTY"
                end
                if ( channel ) then
                    SendChatMessage( format(WCLocale.UI.text.chatCmdAnnounceMessage, UnitName("player") ), channel )
                else
                    DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdAnnounceNotInGroup)
                end

            elseif( command == WCLocale.UI.text.chatCmdHelp ) then
                DEFAULT_CHAT_FRAME:AddMessage(CHAT_GREEN..format(WCLocale.UI.text.whisperCastVersion, WhisperCast_Version)..CHAT_END);
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine1)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine2)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine3)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine4)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine5)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine6)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine7)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine8)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine9)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine10)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine11)
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdHelpLine12)

            elseif ( not WhisperCast_executeGUIs( "slash", msg, command, option ) ) then
                DEFAULT_CHAT_FRAME:AddMessage(CHAT_GREEN..format(WCLocale.UI.text.whisperCastVersion, WhisperCast_Version)..CHAT_END);
                DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdUnknown)
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage(CHAT_GREEN..format(WCLocale.UI.text.whisperCastVersion, WhisperCast_Version)..CHAT_END);
            DEFAULT_CHAT_FRAME:AddMessage(WCLocale.UI.text.chatCmdDefault)
        end
    end
end

function WhisperCast_getChecked( toggle, value )
    if ( not value ) then value = 1 end

    if ( toggle == 1 ) then
        return true;
    else
        return false;
    end
end

function WhisperCast_DropDownInitialize()
    if ( not WhisperCast_Spells ) then return end

	local info = {};

    if ( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then

        info.text = format(WCLocale.UI.text.whisperCastVersion, WhisperCast_Version);
        info.isTitle = 1;
        info.justifyH = "LEFT";
        info.notCheckable = 1;
        UIDropDownMenu_AddButton(info);
        
        info = { };
        info.text = WCLocale.UI.text.dropdownEnable;
        info.keepShownOnClick = 1;
        info.checked = WhisperCast_getChecked( WhisperCast_Profile.enable );
        info.func = WhisperCast_ToggleEnabled;
        UIDropDownMenu_AddButton(info);

        info = { };
        info.text = WCLocale.UI.text.dropdownGroupOnly;
        info.value = {"grouponly"}
        info.keepShownOnClick = 1;
        info.checked = WhisperCast_getChecked( WhisperCast_Profile.grouponly );
        info.func = WhisperCast_ToggleProfileKey;
        UIDropDownMenu_AddButton(info);
        
        info = { };
        info.text = WCLocale.UI.text.dropdownCombatOnly;
        info.keepShownOnClick = 1;
        info.checked = not WhisperCast_getChecked( WhisperCast_Profile.restrictcombat );
        info.func = WhisperCast_ToggleRestrictCombat;
        UIDropDownMenu_AddButton(info);


        info = { };
        info.text = WCLocale.UI.text.dropdownHideWhispers;
        info.value = {"hidewhispers"}
        info.keepShownOnClick = 1;
        info.checked = WhisperCast_getChecked( WhisperCast_Profile.hidewhispers );
        info.func = WhisperCast_ToggleProfileKey;
        UIDropDownMenu_AddButton(info);

        info = { };
        info.text = WCLocale.UI.text.dropdownFeedbackWhispers;
        info.value = {"feedbackwhisper"}
        info.keepShownOnClick = 1;
        info.checked = WhisperCast_getChecked( WhisperCast_Profile.feedbackwhisper );
        info.func = WhisperCast_ToggleProfileKey;
        UIDropDownMenu_AddButton(info);

		info = {};
    	info.disabled = 1;
        UIDropDownMenu_AddButton(info);

        info = { };
        info.text = WCLocale.UI.text.dropdownSoundSub;
        info.value = "SOUND";
        info.notClickable = nil;
        info.hasArrow = 1;
        info.func = nil;
        info.notCheckable = 1;
        UIDropDownMenu_AddButton(info);
        
        info = { };
        info.text = WCLocale.UI.text.dropdownMatchingSub;
        info.value = "MATCHING";
        info.notClickable = nil;
        info.hasArrow = 1;
        info.func = nil;
        info.notCheckable = 1;
        UIDropDownMenu_AddButton(info);
        
        info = { };
        info.text = WCLocale.UI.text.dropdownDisabledSub;
        info.value = "DISABLED";
        info.notClickable = nil;
        info.hasArrow = 1;
        info.func = nil;
        info.notCheckable = 1;
        UIDropDownMenu_AddButton(info);

	elseif ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then

		if ( UIDROPDOWNMENU_MENU_VALUE == "SOUND" ) then

            info = { };
            info.text = WCLocale.UI.text.dropdownSoundFirstQueue;
            info.value = {"playsound","firstqueue"}
            info.keepShownOnClick = 1;
            info.checked = WhisperCast_getChecked( WhisperCast_Profile.playsound.firstqueue );
            info.func = WhisperCast_ToggleProfileKey;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

            info = { };
            info.text = WCLocale.UI.text.dropdownSoundQueueEmpty;
            info.value = {"playsound","emptyqueue"}
            info.keepShownOnClick = 1;
            info.checked = WhisperCast_getChecked( WhisperCast_Profile.playsound.emptyqueue );
            info.func = WhisperCast_ToggleProfileKey;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		elseif ( UIDROPDOWNMENU_MENU_VALUE == "MATCHING" ) then

            info = { };
            info.text = WCLocale.UI.text.dropdownMatchingExact;
            info.value = "exact";
            info.checked = ( WhisperCast_Profile.match == "exact" );
            info.func = WhisperCast_SetMatch;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

            info = { };
            info.text = WCLocale.UI.text.dropdownMatchingStart;
            info.value = "start";
            info.checked = ( WhisperCast_Profile.match == "start" );
            info.func = WhisperCast_SetMatch;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

            info = { };
            info.text = WCLocale.UI.text.dropdownMatchingAny;
            info.value = "any";
            info.checked = ( WhisperCast_Profile.match == "any" );
            info.func = WhisperCast_SetMatch;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		elseif ( UIDROPDOWNMENU_MENU_VALUE == "DISABLED" ) then

            for spell,attrib in WhisperCast_Spells do

                info = { };
                info.text = spell;
                info.value = spell;
                info.keepShownOnClick = 1;
                info.checked = WhisperCast_Profile.disabledSpells[spell];
                info.func = WhisperCast_ToggleSpellDisable;
                UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
             end
        end
    end
end

function WhisperCast_scanTrainer()

    if ( DEFAULT_CHAT_FRAME ) then

        local i=1
        local spellName, spellRank, skillStatus = GetTrainerServiceInfo(i)
        while ( spellName ) do

            if ( WhisperCast_Spells[spellName] ) then
                DEFAULT_CHAT_FRAME:AddMessage(i.." '"..spellName.."' '"..spellRank.."'")
            end
            i=i+1
            spellName, spellRank, skillStatus = GetTrainerServiceInfo(i)
        end
    end
end
