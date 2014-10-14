------------------------------------------------------------------------------
-- Utility library for SmartAssist
------------------------------------------------------------------------------

-- table.getn is basicly this but it doesn't work on all lists/maps ?
function SA_TableSize(t)
	size = 0;
	for k,v in t do
		size = size + 1;
	end
	return size;
end

function SA_TableIndex(tbl, value)
	for k,v in tbl do
		if (v==value) then
			return k
		end	
	end
	return -1
end

function SA_GetAccountID()
	return UnitName("player").." of "..GetCVar("realmName");
end

------------------------------------------------------------------------------
-- Message methods
------------------------------------------------------------------------------

function SA_Verbose(message, color, crit, nochat)
	local color = color or COLOR_DEFAULT;
	if (MikSBT) then
		MikSBT.DisplayMessage(message, MikSBT.DISPLAYTYPE_NOTIFICATION, false, color.r*255, color.g*255, color.b*255);
	elseif (SCT) then
		SCT:DisplayCustomEvent(message, color, crit, false, 1);
	elseif (not nochat) then
		DEFAULT_CHAT_FRAME:AddMessage(message, color.r, color.g, color.b);
	end
end

function printInfo(message, color)
	local color = color or COLOR_DEFAULT;
	DEFAULT_CHAT_FRAME:AddMessage(message, color.r, color.g, color.b);
end

------------------------------------------------------------------------------
-- Debug methods
------------------------------------------------------------------------------

function SA_Debug(message, level)
	local level = level or 5;
	if (SA_OPTIONS.DebugLevel >= level) then
		DEFAULT_CHAT_FRAME:AddMessage(message, 0, 0.8, 1);
	end
end

function SA_DebugCandidates(candidates)
	for k,c in candidates do
		if (c==nil) then
			SA_Debug("THERE IS NIL VALUE ON ARRAY!", 1);
		end
		SA_DebugCandidate(c);
	end
end

function SA_DebugCandidate(c)
	SA_Debug("candidate name="..tostring(c.unitName).." | id="..tostring(c.unitId).." | health="..tostring(c.health).." | class="..tostring(c.class).." | pet="..tostring(c.pet), 1);
end

function SA_DebugTable(t)
	SA_Debug("table length: "..SA_TableSize(t));
	for k,v in t do
		SA_Debug("table: key="..k.." value="..tostring(v), 1);
	end
end

-----------------------------------------------------------------------------------------
-- Return true if unit is in combat or has target (VERY likelly to be in combat soon)
-----------------------------------------------------------------------------------------

function SA_UnitIsInCombat(unit)
	return UnitAffectingCombat(unit) or UnitName(unit.."target");
end

------------------------------------------------------------------------------
-- Is the target valid for targetting
------------------------------------------------------------------------------

function isValidTarget(unit, oocInvalid)
	if (UnitExists(unit)) then
		-- Don't target dead units
		if (UnitIsDead(unit)) then
			--SA_Debug("Dead, not targeting "..SA_TargetInfo(unit));
			return false;
		end
		-- Don't target friendlies
		if (UnitIsFriend(unit, "player")) then
			--SA_Debug("Friendly, not targeting "..SA_TargetInfo(unit));
			return false;
		end
		-- Don't target if we can't attack it
        if (not UnitCanAttack(unit, "player")) then
        	SA_Debug("Can't attack, not targeting "..tostring(UnitName(unit)));
			return false;
        end
		-- Don't target CCd mobs
		if (isUnitCC(unit)) then
			SA_Debug("CCd, not targeting "..tostring(UnitName(unit)));
			return false;
		end
		-- if oocInvalid flag enabled, test that unit is in combat
		if (oocInvalid) then
			if (not SA_UnitIsInCombat(unit)) then
				return false;
			end
		end
	else
		return false;
	end
	return true;
end

-----------------------------------------------------------------------------------------
-- Check if the targeted unit has any CC methods applied to it (seduce, charm, polymorph)
-- return true if the unit is CCd
-- basic idea taken from pet leash. I've added many more spells to the list tough :)
-----------------------------------------------------------------------------------------

function isUnitCC(unit)
	for i = 1, 20 do
		if (UnitDebuff(unit,i)) then
			currentDebuff = UnitDebuff(unit,i)
			SA_Debug("currentDebuff "..currentDebuff, 5);
			if (currentDebuff == "Interface\\Icons\\Spell_Shadow_Possession") then
				SA_Debug("-- Possessed, not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Spell_Shadow_MindSteal") then
				SA_Debug("-- Charmed, not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Spell_Nature_Polymorph") then
				SA_Debug("-- Polymorphed (sheep), not valid "..tostring(UnitName(unit)));
				return true;
			end
			-- not sure if this is ingame, nevertheless file exists
			if (currentDebuff == "Interface\\Icons\\Spell_Magic_PolymorphChicken") then
				SA_Debug("-- Polymorphed (chicken?), not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Spell_Magic_PolymorphPig") then
				SA_Debug("-- Polymorphed (pig), not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Ability_Hunter_Pet_Turtle") then
				SA_Debug("-- Polymorphed (turtle), not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Spell_Frost_ChainsOfIce") then
				SA_Debug("-- Ice trapped, not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Spell_Nature_Slow") then
				SA_Debug("-- Shackle Undead, not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Spell_Nature_Sleep") then
				SA_Debug("-- Sleeped, not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Ability_Sap") then
				SA_Debug("-- Sapped, not valid "..tostring(UnitName(unit)));
				return true;
			end
			if (currentDebuff == "Interface\\Icons\\Spell_Shadow_Cripple") then
				SA_Debug("-- Banished, not valid "..tostring(UnitName(unit)));
				return true;
			end
		else
			-- no more debuffs on unit, stop the loop
			break;
		end
	end
	return false;
end

------------------------------------------------------------------------------
-- return true if unit is marked with hunter's mark
------------------------------------------------------------------------------

function SA_IsMarked(unit)
	for i = 1, 20 do
		if (UnitDebuff(unit, i)) then
			currentDebuff = UnitDebuff(unit,i)
			if (currentDebuff == "Interface\\Icons\\Ability_Hunter_SniperShot") then return true; end
		else
			-- no more debuffs on unit, stop the loop
			break;
		end
	end
	return false;
end

------------------------------------------------------------------------------
-- return true if unitName is tank (in smartassist or in ct raidassist)
------------------------------------------------------------------------------

function SA_IsTank(unitName)
	if (unitName == SA_OPTIONS.puller) then return true; end;
	if (CT_RA_MainTanks) then
		for _,v in CT_RA_MainTanks do
			if (unitName == v) then return true; end
		end
	end
	return false;
end

------------------------------------------------------------------------------
-- Convert RGB values to text color values
------------------------------------------------------------------------------

function SA_ToTextCol(r,g,b)
	return string.lower("|cff"..string.format("%.2X",255*r)..string.format("%.2X",255*g)..string.format("%.2X",255*b));
end

-------------------------------------------------------------------------------
-- togle a boolean option plus play a tick sound
-------------------------------------------------------------------------------

function SA_ToggleOption(option)
	if (SA_OPTIONS[option]==nil or SA_OPTIONS[option]==false) then
		SA_OPTIONS[option] = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		SA_OPTIONS[option] = false;
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
end

------------------------------------------------------------------------------
-- misc
------------------------------------------------------------------------------

function SA_StringSplit(str)
	local t={n=0}
	local function helper(word) table.insert(t, word) end
	string.find(string.gsub(str, "%w+", helper), "%S")
	return t
end

function SA_GetSlotName(slot)
	SAActionTip:SetAction(slot);
	return SAActionTipTextLeft1:GetText();
end

-- return true if player can have pet
function SA_IsPetClass()
	local _, englishClass = UnitClass("player");
	if (englishClass=="HUNTER") then return true; end;
	if (englishClass=="WARLOCK") then return true; end;
end


-- clears table, reduces need for gc in lua 5.0
-- will be deprecated once wow moves into lua 5.1 !
-- NOT IN USE, DOES NOT WORK!
function SA_ClearTable(t)
	local tables = {};
	for key, value in t do
		if (type(value)=="table") then
			table.insert(tables,key);
		else
			t[key]=nil;
		end
	end
	for _,key in tables do
		SA_ClearTable( t[key] );
		t[key]=nil;
	end
	t.reset = 1
	t.reset = nil
	table.setn(t, 0)
end