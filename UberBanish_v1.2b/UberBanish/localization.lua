--[[
--
-- Aule's UberBanish
--
-- Localization strings.
--
--]]

-- English
UB_TITLE                     = "UberBanish";
UB_VERSION                   = "1.2b";
UB_TITLE_VERSION             = UB_TITLE .. " v" .. UB_VERSION;
UB_DESCRIPTION               = "Banish enhancements for Warlocks.";
UB_LOADED                    = "|cffffff00" .. UB_TITLE .. " v" .. UB_VERSION .. " loaded";

UB_CONFIRM_RESET             = "Okay to reset " .. UB_TITLE .. " settings to default values?";

UB_WARLOCK                   = "Warlock";

UB_L8N_BANISH					= "Banish";
UB_L8N_BANISH_RANK1				= "Banish(Rank 1)";
UB_L8N_BANISH_RANK2				= "Banish(Rank 2)";
UB_L8N_MOB_BROKE_YOUR_BANISH	= "MOB BROKE YOUR BANISH!!!";
UB_L8N_HAS_BANISHED				= " has banished ";
UB_L8N_BANISH_BREAKS_IN			= "Banish breaks in ";
UB_L8N_SECONDS					= " seconds...";
UB_L8N_MY_BANISH_EXPIRES		= "My Banish expires now!";
UB_L8N_WARLOCKS					= "WARLOCKS";
UB_L8N_HAS_DIED_WHILE_BANISHING	= " has died while banishing!";
--UB_L8N_SPELL_RESISTED			= "Your (.+) was resisted by (.+).";
--UB_L8N_SPELL_IMMUNE				= "Your (.+) failed. (.+) is immune.";
--UB_L8N_EVENT_FADE 				= "(.+) fades from (.+).";


if ( GetLocale() == "frFR" ) then
    UB_WARLOCK                   = "D\195\169moniste";
    UB_DESCRIPTION               = "Timers important pour D\195\169moniste.";

	UB_L8N_BANISH					= "Banish";
	UB_L8N_BANISH_RANK1				= "Banish(Rank 1)";
	UB_L8N_BANISH_RANK2				= "Banish(Rank 2)";
	UB_L8N_MOB_BROKE_YOUR_BANISH	= "Le mob a cass le votre banissent!!";
	UB_L8N_HAS_BANISHED				= " bani votre ";
	UB_L8N_BANISH_BREAKS_IN			= "Coupures de banissez en ";
	UB_L8N_SECONDS					= " secondes...";
	UB_L8N_MY_BANISH_EXPIRES		= "Mon banissez expire maintenant !";
	UB_L8N_WARLOCKS					= "D\195\169MONISTES";
	UB_L8N_HAS_DIED_WHILE_BANISHING	= " est mort tout en banissant.";
	--UB_L8N_SPELL_RESISTED			= "Your (.+) was resisted by (.+).";
	--UB_L8N_EVENT_FADE 				= "(.+) fades from (.+).";
end


if ( GetLocale() == "deDE" ) then
    UB_WARLOCK                   = "Hexenmeister";
    UB_DESCRIPTION               = "Important timers for Warlocks.";

	UB_L8N_BANISH					= "Banish";
	UB_L8N_BANISH_RANK1				= "Banish(Rank 1)";
	UB_L8N_BANISH_RANK2				= "Banish(Rank 2)";
	UB_L8N_MOB_BROKE_YOUR_BANISH	= "MOB brach Ihr verbannen!";
	UB_L8N_HAS_BANISHED				= " hat verbannt ";
	UB_L8N_BANISH_BREAKS_IN			= "Verbannen Sie Brche in ";
	UB_L8N_SECONDS					= " Sekunden...";
	UB_L8N_MY_BANISH_EXPIRES		= "Mein verbannen Sie abluft jetzt.";
	UB_L8N_WARLOCKS					= "HEXENMEISTERS";
	UB_L8N_HAS_DIED_WHILE_BANISHING	= " ist beim Verbannen gestorben.";
	--UB_L8N_SPELL_RESISTED			= "Your (.+) was resisted by (.+).";
	--UB_L8N_EVENT_FADE 				= "(.+) schwindet von (.+).";
end


local function UB_Localize(in_pattern)

    local pattern = in_pattern;

	local i,k,field,idx;

	pattern = string.gsub(pattern,"%.$",""); -- strip trailing .
	pattern = string.gsub(pattern,"%%s","(.+)"); -- %s to (.+)
	pattern = string.gsub(pattern,"%%d","(%%d+)"); -- %d to (%d+)
	if string.find(pattern,"%$") then
		-- entries need reordered, ie: SPELLMISSOTHEROTHER = "%2$s von %1$s verfehlt %3$s.";

		pattern = string.gsub(pattern,"%%%d%$s","(.+)");
		pattern = string.gsub(pattern,"%%%d%$d","(%%d+)");
	end

    return pattern;
end


UB_SPELLCASTOTHERSTART = UB_Localize( SPELLCASTOTHERSTART );
UB_AURAADDEDOTHERHARMFUL = UB_Localize( AURAADDEDOTHERHARMFUL );    -- %s is afflicted by %s.
UB_SPELLRESISTSELFOTHER = UB_Localize( SPELLRESISTSELFOTHER );      -- Your %s was resisted by %s.
UB_SPELLIMMUNESELFOTHER = UB_Localize( SPELLIMMUNESELFOTHER );      -- Your %s failed. %s is immune.
UB_SPELLEVADEDSELFOTHER = UB_Localize( SPELLEVADEDSELFOTHER );      -- Your %s was evaded by %s.
UB_AURAREMOVEDOTHER = UB_Localize( AURAREMOVEDOTHER );              -- %s fades from %s.
UB_SPELLCASTOTHERSTART = UB_Localize( SPELLCASTOTHERSTART );        -- %s begins to cast %s.
UB_UNITDIESOTHER = UB_Localize( UNITDIESOTHER );                    -- %s dies.
