--[[
	Stuff to track spell casting
	
	Main usage in SW Stats: Track mana efficiency of spells
	Might add more here
	
	Basic idea from:
	http://www.wowwiki.com/HOWTO:_Detecting_Instant_Cast_Spells
	
	approach for cancel, stop is different
	
	for ae we accept the spell at SPELLCAST_CHANNEL_START
	Stop messages for instant casts are never made pending, stop + instant = ok
	
	The idea of the "pending cast" is used because a fail message can come after a stop message for "normal" spells.
	
	Thought of removing this for 2.0 because the parser now catches most stuff... but
	There would be no way to calc mana efficiency AND no way to see how often somebody casted an AE
--]]

-- holds mana / spell info for cast by name
SW_CastByNameLookup = {};
-- holds mana / spell info for cast by name without rank
SW_CastByNameLookupMax = {};

--spells that are instant
SW_InstantLookup = {};

-- holds info until know if a spell failed
SW_PendingCast = {
	spellName = nil,
	manaCost = 0,
	
	setToSelected = function (self)
		self.spellName = SW_SelectedSpell.spellName;
		self.manaCost = SW_SelectedSpell.manaCost;
	end,
};
-- holds info of the spell to cast
SW_SelectedSpell = {
	spellName = nil,
	manaCost = 0,
	isInstant = false,
	
	setData = function (self, name, mana, instant)
		self.spellName = name;
		self.manaCost = mana;
		self.isInstant = instant;
	end,
};

local SW_ManaRegEx = string.gsub(MANA_COST, "%%d","(%%d+)");

function SW_GetManaCost(str)
	if str == nil then return nil; end
	local _,_, spellCost = string.find(str, SW_ManaRegEx);
	if spellCost == nil then return nil; end
	return tonumber(spellCost);
end

function SW_AcceptPendingCast()
	if not SW_PendingCast.spellName then
		return;
	end
	SW_DataCollection:addCT(SW_PendingCast.spellName, SW_PendingCast.manaCost);
	
	SW_PendingCast.spellName = nil;
end
-- used in special cases see SPELLCAST_STOP in core.lua
function SW_AcceptSelectedCast()
	if not SW_SelectedSpell.spellName then
		return;
	end
	SW_DataCollection:addCT(SW_SelectedSpell.spellName, SW_SelectedSpell.manaCost);
	SW_SelectedSpell.spellName = nil;
end
function SW_UpdateCastByNameLookup()
	local i = 1
	local spellCost;
	--SW_printStr("SW_CastByNameLookup rebuilt");
	SW_CastByNameLookup = {};
	SW_CastByNameLookupMax = {};
	SW_InstantLookup = {};
	SW_SpellHookTT:SetOwner(UIParent, "ANCHOR_NONE");

	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		SW_SpellHookTT:SetSpell(i, BOOKTYPE_SPELL);
		if ( spellRank and (strlen(spellRank) > 0) ) then
			
			spellCost = SW_GetManaCost(SW_SpellHookTTTextLeft2:GetText());
			if spellCost == nil then
				SW_CastByNameLookup[ spellName .. '(' .. spellRank .. ')' ] = {spellName, spellRank, 0};
			else
				SW_CastByNameLookup[ spellName .. '(' .. spellRank .. ')' ] = {spellName, spellRank, spellCost};
			end
			
		else
			spellCost = SW_GetManaCost(SW_SpellHookTTTextLeft2:GetText());
			if spellCost == nil then
				SW_CastByNameLookup[ spellName ] = {spellName, nil, 0};
			else
				SW_CastByNameLookup[ spellName ] = {spellName, nil, spellCost};
			end
		end
		if SW_CastByNameLookupMax[spellName] == nil or spellCost > SW_CastByNameLookupMax[spellName] then
			SW_CastByNameLookupMax[spellName] = spellCost;
		end
		if (SPELL_CAST_TIME_INSTANT == SW_SpellHookTTTextLeft3:GetText()) then
			SW_InstantLookup[ spellName ] = true;
		end
		
		i = i + 1
	end
end


SWHook_oldCastSpell = CastSpell;
function SWHook_newCastSpell(spellId, spellbookTabNum)
	--SW_printStr("CastSpell");
	-- if we are casting something already, do normal stuff
	-- don't need to check .channeling a new cast abborts channeling
	if getglobal("CastingBarFrame").casting then
		SWHook_oldCastSpell(spellId, spellbookTabNum);
		return;
	end
	SW_SpellHookTT:SetOwner(UIParent, "ANCHOR_NONE");
	-- Load the tooltip with the spell information
	SW_SpellHookTT:SetSpell(spellId, spellbookTabNum);
	local spellName = SW_SpellHookTTTextLeft1:GetText();
	if spellName == nil then
		SWHook_oldCastSpell(spellId, spellbookTabNum);
		return;
	end
	
	--local spellCost = SW_GetManaCost(SW_SpellHookTTTextLeft2:GetText());
	local spellNRank = "";
	local spellCost;
	local instant = SW_InstantLookup[spellName];
	--local spellRank = SW_SpellHookTTTextRight1:GetText();
	local spell, spellRank = GetSpellName(spellId, BOOKTYPE_SPELL);

	if ( spellRank and (strlen(spellRank) > 0) ) then
		spellNRank = spell.."("..spellRank..")";
	else
		spellNRank = spell;
	end
	--SW_printStr("SWHook_newCastSpell");
	if SW_CastByNameLookup[spellNRank] then
		spellCost = SW_CastByNameLookup[spellNRank][3];
	elseif SW_CastByNameLookupMax[spell] then
		spellCost = SW_CastByNameLookupMax[spell];
	end
	
	if spellCost == nil then
		SW_SelectedSpell:setData(spellName, 0, instant);
	else
		SW_SelectedSpell:setData(spellName, spellCost, instant);
	end
	SWHook_oldCastSpell(spellId, spellbookTabNum);
end
CastSpell = SWHook_newCastSpell;

--1.3.2 changed this to be wow 1.10 ready (onSelf will be added)
SWHook_oldCastSpellByName = CastSpellByName;
function SWHook_newCastSpellByName(spellName, onSelf)
	if getglobal("CastingBarFrame").casting then
		SWHook_oldCastSpellByName(spellName, onSelf)
		return;
	end
	--SW_printStr("SWHook_newCastSpellByName");
	local spell, spellCost;
	
	if SW_CastByNameLookup[spellName] then
		spell = SW_CastByNameLookup[spellName][1];
		spellCost = SW_CastByNameLookup[spellName][3];
	elseif SW_CastByNameLookupMax[spellName] then
		spell = spellName;
		spellCost = SW_CastByNameLookupMax[spellName];
	end
	local instant = SW_InstantLookup[spellName];
	-- can happen if we are using a macro of a spell we dont have
	if spell and spellCost and spellCost > 0 then
		SW_SelectedSpell:setData(spell, spellCost, instant);
	end
	
	-- Call the original function
	SWHook_oldCastSpellByName(spellName, onSelf)

end
CastSpellByName = SWHook_newCastSpellByName;


SWHook_oldUseAction = UseAction

function SWHook_newUseAction(a1, a2, a3)
	--SW_printStr("Action");
	if getglobal("CastingBarFrame").casting then
		SWHook_oldUseAction(a1, a2, a3);
		return;
	end
	--SW_printStr("SWHook_newUseAction");
	-- Call the original function
	SWHook_oldUseAction(a1, a2, a3);
	
	-- Test to see if this is a macro
	if GetActionText(a1) then 
		return ;
	end
	SW_SpellHookTT:SetOwner(UIParent, "ANCHOR_NONE");
	
	SW_SpellHookTT:SetAction(a1)
	
	-- need to lookup the info this way because the "enhanced tooltip" could be turned off.
	-- name and rank are always displayed. 
	local spellNRank = "";
	local spellCost;
	local spell = SW_SpellHookTTTextLeft1:GetText();
	if spell == nil then 
		return;
	end
	local instant = SW_InstantLookup[spell];
	local spellRank = SW_SpellHookTTTextRight1:GetText();
	if ( spellRank and (strlen(spellRank) > 0) ) then
		spellNRank = spell.."("..spellRank..")";
	else
		spellNRank = spell;
	end
	--SW_printStr("'"..spellNRank.."'");
	if SW_CastByNameLookup[spellNRank] then
		spellCost = SW_CastByNameLookup[spellNRank][3];
	elseif SW_CastByNameLookupMax[spell] then
		spellCost = SW_CastByNameLookupMax[spell];
	end
	
	if spellCost == nil then
		--SW_printStr(spellName);
		SW_SelectedSpell:setData(spell, 0, instant);
	else
		SW_SelectedSpell:setData(spell, spellCost, instant);
	end
end
UseAction = SWHook_newUseAction

