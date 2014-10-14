--[[

pa_bless.lua
Panza Blessing functions
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

function PA:SetupBuffs()

	-- Paladin Auras

	PA.buffKeys["ret"]				= "AuraOfLight";
	PA.buffKeys["devo"]				= "DevotionAura";
	PA.buffKeys["conc"]				= "MindSooth";
	PA.buffKeys["shadow"]			= "Shadow_SealOfKings";
	PA.buffKeys["frost"]			= "Frost_WizardMark";
	PA.buffKeys["fire"]				= "Fire_SealOfFire";

	-- Buffs we must identify

	PA.buffKeys["impPS"]			= "Shadow_ImpPhaseShift";				-- Phase Shift
	PA.buffKeys["amp"]				= "Holy_FlashHeal";						-- Amplify Magic
	PA.buffKeys["damp"]				= "Nature_AbolishMagic";				-- Dampen Magic
	PA.buffKeys["renew"]			= "Holy_Renew";							-- Priest Renew HOT
	PA.buffKeys["regro"]			= "Nature_ResistNature";  				-- Druids Regrowth HOT
	PA.buffKeys["rejuv"]			= "Nature_Rejuvenation";				-- Druids Rejuvenation HOT
	PA.buffKeys["Druid-Bear"]		= "Ability_Racial_BearForm";			-- Druids Bear Form
	PA.buffKeys["Druid-Cat"]		= "Ability_Druid_CatForm";				-- Druids Cat Form
	PA.buffKeys["Druid-Moon"]  		= "Nature_MoonGlow";					-- Druids MoonKin Form
	PA.buffKeys["Prowl"]  			= "Ability_Druid_SupriseAttack";		-- Hunters' Pet Prowl
	PA.buffKeys["hway"]				= "Nature_HealingWay";					-- Shamans' Healing Way
	PA.buffKeys["usp"]				= "Lighting_LighteningBolt01";			-- Unstable Power (Zandalarian Hero Charm)

	PA.buffKeys["adis"]				= "Nature_NullifyDisease";				-- Abolish Disease
	PA.buffKeys["apoi"]				= "Nature_NullifyPoison_02";			-- Abolish Poison
	PA.buffKeys["amag"]				= "Nature_AbolishMagic";				-- Abolish Magic
	PA.buffKeys["cc"]				= "Spell_Shadow_ManaBurn";				-- Druid's ClearCasting State


	-- Debuffs we must identify

	PA.debuffKeys = {};
	PA.debuffKeys["MindControl"]	= "Spell_Shadow_ShadowWordDominate";	-- Priests' Mind Control
	PA.debuffKeys["VaelBuff"]		= "Spell_Fire_LavaSpawn";				-- Vael's Buff 500 mana/sec
	PA.debuffKeys["Burning"]		= "INV_Gauntlets_03";					-- Burning from Vael 100% attack speed. Death is 12 secs away.
	PA.debuffKeys["MindVision"]		= "Spell_Holy_MindVision";				-- Priests' Mind Vision
	PA.debuffKeys["Forbearance"]	= "Spell_Holy_RemoveCurse";				-- After Pally shielded
	PA.debuffKeys["WeakSoul"]		= "Spell_Holy_AshesToAshes";			-- After Priest shielded
	PA.debuffKeys["Bandage"]		= "INV_Misc_Bandage_";					-- Recently bandaged
	PA.debuffKeys["DeadwoodCurse"]	= "Spell_Shadow_GatherShadows";			-- Curse of the Deadwood
	PA.debuffKeys["MortalStrike"]	= "Ability_Warrior_SavageBlow";			-- Mortal Strike
	PA.debuffKeys["BloodFury"]		= "Ability_Rogue_FeignDeath";			-- Blood Fury
	PA.debuffKeys["HexWeakness"]	= "Spell_Shadow_FingerOfDeath";			-- Hex of Weakness
	PA.debuffKeys["BroodAffliction"]= "INV_Misc_Head_Dragon_Green";			-- Brood Affliction: Green

	PA.GoodDebuffs = {};
	PA.GoodDebuffs["Nature_Sleep"]	= PANZA_DREAMLESS;						-- Dreamless Sleep
end

-------------------------------------------------------------------------------
-- Find out if Unit has a blessing by using short name (i.e. "bom", "bol", etc)
-- Returns the index for the buff or false if the buff is not found.
-------------------------------------------------------------------------------
function PA:UnitHasBlessing(unit, blessing, gtCheck)
	local index = false;

	if (unit==nil) then
		return false, false;
	end

	local IsGroup = false;

	if (PA.buffKeys[blessing]~=nil) then
		--PA:Debug("blessing=", blessing);
		--PA:Debug("Match=", PA.buffKeys[blessing]);
		if (PA.buffKeysTooltips[blessing]~=nil) then
			index = PA:UnitHasBuff(unit, PA.buffKeys[blessing], PA:GetSpellProperty(blessing, "Name"));
		else
			index = PA:UnitHasBuff(unit, PA.buffKeys[blessing], nil);
		end
	end
	--PA:Debug("index=", index, " gtCheck=", gtCheck);

	--Check for Group blessing too
	if (index==false and gtCheck==true) then
		local GroupBlessing = PA.SingleToGroup[blessing];
		--PA:Debug("GtBlessing=", GroupBlessing);
		if (GroupBlessing~=nil) then
			--PA:Debug("Match=", PA.buffKeys[GroupBlessing]);
			if (PA.buffKeysTooltips[GroupBlessing]~=nil) then
				index = PA:UnitHasBuff(unit, PA.buffKeys[GroupBlessing], PA:GetSpellProperty(GroupBlessing, "Name"));
			else
				index = PA:UnitHasBuff(unit, PA.buffKeys[GroupBlessing], nil);
			end
			IsGroup = (index~=false);
		end
	end

	--PA:Debug("index=", index);
	return index, IsGroup;
end


-----------------------------------------------------------------------
-- Find out if unit has a specified buff (buffs are listed in buffkeys)
-- Return the index at which the buff was found, or false if not found
-----------------------------------------------------------------------
function PA:UnitHasBuff(unit, buffMatch, tooltipMatch)
	if (buffMatch==nil) then
		return false;
	end
	if (buffMatch=="WeaponEnchant") then
		return GetWeaponEnchantInfo() or false;
	end
	local index = 1;
	local Buff = UnitBuff(unit, index);
	if (tooltipMatch~=nil) then
		PA:ResetTooltip();
	end
	while (Buff~=nil) do
		--PA:Debug("Buff=", Buff);
		if (string.find(Buff, buffMatch.."$")) then
			if (tooltipMatch~=nil) then
				--PA:Debug("tooltipMatch=", tooltipMatch);
				PanzaTooltipTextLeft1:SetText(nil);
				PanzaTooltip:SetUnitBuff(unit, index);
				--PA:Debug("Left1=", (PanzaTooltipTextLeft1:GetText()));
				if (PanzaTooltipTextLeft1:GetText()==tooltipMatch) then
					--PA:Debug("Found via tooltip Index=", index);
					return index;
				end
			else
				--PA:Debug("Found Index=", index);
				return index;
			end
		end
		index = index + 1;
		Buff = UnitBuff(unit, index);
	end
	return false;
end

-----------------------------------------------------------------------
-- Find out if unit has a specified debuff (debuffs are listed in debuffkeys)
-- Return the index at which the debuff was found, or false if not found
-----------------------------------------------------------------------
function PA:UnitHasDebuff(unit, debuffMatch)
	--PA:ShowText("PA:UnitHasDebuff match=", debuffMatch);
	return PA:FindUnitDebuff(unit, PA.debuffKeys[debuffMatch]);
end

function PA:FindUnitDebuff(unit, searchTexture)
	--PA:ShowText("PA:FindUnitDebuff search=", searchTexture);
	if (searchTexture~=nil and unit~=nil) then
		local index = 1;
		local Debuff = UnitDebuff(unit, index);
		while (Debuff~=nil) do
			--PA:Debug("Index=", Index, " Debuff=", Debuff);
			if (string.find(Debuff, searchTexture.."$")) then
				--PA:Debug("Found Index=", index);
				return index;
			end
			index = index + 1;
			Debuff = UnitDebuff(unit, index);
		end
	end
	return false;
end
-----------------------------------------
-- List all Buffs on the target specified
-----------------------------------------
function PA:ShowAllBuffs(unit)
	local i = 1;

	if (not unit or not UnitExists(unit)) then
		unit = "player";
	end

	PA:Message(PA:UnitName(unit).." Buffs:");
	local Buff = UnitBuff(unit, i);
	PA:ResetTooltip();
	while (Buff) do
		PanzaTooltipTextLeft1:SetText(nil);
		PanzaTooltip:SetUnitBuff(unit, i);
		PA:Message("  "..Buff.." TooltipText="..tostring(PanzaTooltipTextLeft1:GetText()));
		i = i + 1;
		Buff = UnitBuff(unit, i);
	end
end

-----------------------------------------
-- List all Debuffs on the target specified
-----------------------------------------
function PA:ShowAllDebuffs(unit)

	if (not unit or not UnitExists(unit)) then
		unit = "player";
	end

	PA:Message(PA:UnitName(unit).." Debuffs:");
	local i = 1;
	local Debuff = UnitDebuff(unit, i);
	PA:ResetTooltip();
	while (Debuff) do
		PanzaTooltipTextLeft2:SetText(nil);
		PanzaTooltip:SetUnitDebuff(unit, i);
		PA:Message("  "..Debuff.." TooltipText="..tostring(PanzaTooltipTextLeft2:GetText()));
		i = i + 1;
		Debuff = UnitDebuff(unit, i);
	end
end

------------------------------------------------------------------------
-- Command line utility to clear a name from the BlessList Manually
------------------------------------------------------------------------
function PA:ClearName(name)
	local total,i=0,0;

	if (name == nil) then
		PA:Message(PA_GREN..PANZA_CLEARNAME_USAGE);
		return false;
	end

	if (PASettings.BlessList[name] ~= nil) then
		if (PA.PlayerName==name) then
			if (PA:CheckMessageLevel("Bless", 1)) then
				PA:Message4(PA_RED..PANZA_CLEARNAME_PLAYER);
			end
			return;
		end
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(PA_GREN..format(PANZA_CLEARNAME_NAME, name));
		end
		PASettings.BlessList[name] = {};
	else
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(PA_RED..format(PANZA_CLEARNAME_NOCLEAR, name));
		end
	end
end



-----------------------------------------------------
-- List the results of Last Cycle, Near or CycleBless
-----------------------------------------------------
function PA:ListCycle()
	local Empty = true;
	PA:Message(PA_GREN.."CycleBless blessed "..PA_WHITE.." "..PA:TableSize(PACurrentSpells.Indi).." "..PA_GREN.."Players.");
	PA:Message(PA_GREN.."Name Id"..PA_WHITE.." - "..PA_BLUE.."Spell (Shortname), "..PA_WHITE.."Time, "..PA_GREN.."Remaining Duration.");
	PA:Message("--------------------------------");
	for Name, Set in pairs(PACurrentSpells.Indi) do
		for Id, value in pairs(Set) do
			PA:Message(PA_GREN..Name.." "..Id..""..PA_WHITE.." - "..PA_BLUE..""..value.Spell.." ("..value.Short.."), "..PA_WHITE.." "..format("%.0f",value.Time)..", "..PA_GREN..""..format("%.0f", PA.SpellBook[value.Short].Duration - GetTime() + value.Time));
			Empty = false;
		end
	end
	if (Empty) then
		PA:Message(PA_GREN.."List Empty");
	end
end

------------------------------------------
-- List current Group Blessings by Class
------------------------------------------
function PA:ListGroup()
	local Empty = true;
	PA:Message(PA_YEL.."Class, Spell, TimeSet, TimeLeft Total/Cast");
	PA:Message("--------------------------------");
	for Class, Set in pairs(PACurrentSpells.Group) do
		for Id, Info in pairs(Set) do
			PA:Message(PA_GREN..PA:Capitalize(PA.ClassName[Class]).." "..Id..""..PA_WHITE.." - "..PA_BLUE..""..Info.Spell.." ("..Info.Short.."), "..PA_WHITE.." "..format("%.0f", Info.Time)..", "..PA_GREN..""..format("%.0f", PA.SpellBook[Info.Short].Duration - GetTime() + Info.Time).." "..Info.TotalInGroup.."/"..Info.Count);
			Empty = false;
		end
	end
	if (Empty) then
		PA:Message(PA_GREN.."List Empty");
	end
end

----------------------------------------
-- List all current Failed Units by Name
----------------------------------------
function PA:ListFailed()
	local key, value = nil, nil;

	PA:Message(PA_YEL.."CycleBless had"..PA_WHITE.." "..PA:TableSize(PA.Cycles.Group.Fail).." "..PA_YEL.."failed player bless attempts.");
	PA:Message(PA_YEL.."Name (Unit), Count, Seconds Since Fail - Last fail reason");
	PA:Message("--------------------------------");
	for key, value in pairs(PA.Cycles.Group.Fail) do
		PA:Message(format(PA_BLUE.."%s (%s) %s %.0fs - %s", key, value.unit, value.count, GetTime() - value.Time, value.LastReason));
	end
end


function PA:GetIndiSavedListIndexed()
	IndiTable = {};
	for Name, _ in pairs(PASettings.BlessList) do
		if (Name~=PA.PlayerName) then
			table.insert(IndiTable, Name);
		end
	end
    table.sort(IndiTable);
	return IndiTable;
end

function PA:ListIndiSaved()
	local IndiTable = PA:GetIndiSavedListIndexed();
	total = getn(IndiTable)
	PA:Message(PA_GREN.."Panza: "..PA.PlayerName.."'s Blessing list has "..total.." Entries.");
	for i, Name in pairs(IndiTable) do
		if (PASettings.BlessList[Name]~=nil and PASettings.BlessList[Name].Spell~=nil) then
			PA:Message(PA_GREN..Name..""..PA_WHITE.." - "..PA_BLUE..""..PA.SpellBook[PASettings.BlessList[Name].Spell].Name..".");
		else
			PA:Message("Bless",1,Name.." does not have a spell. use /pa clearall to reset.");
		end
	end
end
-----------------------------------------------------
-- Blessing List Functions
-----------------------------------------------------
function PA:BlessList(action)
	local unit, name, total, i = nil,nil,nil,0,0;

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4(PA_WHITE.."BlessList Action: "..action);
	end

	if (action == "clearall") then
		PA:Message(PA_GREN.."Clearing "..PA.PlayerName.."'s Blessing List of all entries");
		PASettings.BlessList 		= {};
		PASettings.BlessList[PA.PlayerName] = {Spell=PA.DefaultBuff};
		PA:Message(PA_GREN.."Blessing list for "..PA.PlayerName.." cleared and re-created with default \"player\" entry.");
		return;
	end

	if (action == "cleartarget") then
		if (UnitExists("target")) then
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4(PA_WHITE.."Panza: Clearing current target from the list.");
			end
			-- Do not delete the root entry
			if (not UnitIsUnit("target", "player")) then
				name = PA:UnitName("target");
				if (PASettings.BlessList[name]) then
					PA:Message("Clearing the Saved Blessing for "..name);
					PASettings.BlessList[name] = nil;
				else
					PA:Message(PA:UnitName("target").." does not have a saved blessing in this list.");
				end
			else
				PA:Message(PA_RED.."Panza: You may only modify "..PA.PlayerName.."'s blessing, not remove it.");
			end
		end
		return;
	end

	if (action == "listraid") then
		for i = 1, 40 do
			unit = "raid"..i;
			if (UnitExists(unit)) then
				local UName = PA:UnitName(unit);
				if (UName~="target") then
					if (PASettings.BlessList[UName]) then
						PA:Message(UName.." ", PA:GetSpellProperty(PASettings.BlessList[UName].Spell, "Name"), ".");
					else
						PA:Message(UName.." does not have a saved blessing.");
					end
				end
			end
		end
		return;
	end

	if (action == "listparty") then
		for i = 1, 5 do
			unit = "party"..i;

			if (UnitExists(unit)) then
				local UName = PA:UnitName(unit);
				if (UName~="target") then
					if (PASettings.BlessList[UName]) then
						PA:Message(UName.." ", PA:GetSpellProperty(PASettings.BlessList[UName].Spell, "Name"), ".");
					else
						PA:Message(UName.." does not have a saved blessing.");
					end
				end
			end
		end
		return;
	end

	if (action == "listall") then
		PA:ListIndiSaved();
		return;
	end

	if (action == "listcycle") then
		PA:ListCycle();
		return;
	end

	if (action == "listspells") then
		PA:ListAllSpells();
		return;
	end

	if (action == "showspells") then
		PA:ShowSpells();
		return;
	end

	if (action == "listfailed") then
		PA:ListFailed();
		return;
	end

	if (action == "listgroup") then
		PA:ListGroup();
		return;
	end

	if (action=="listrez") then
		PA:Message("Rezed list:");
		for key, value in pairs(PA.Rez) do
			PA:Message(key.." "..value);
		end
		return;
	end

	if (action == "showdamage") then
		for Spell, Short in pairs(PA.SpellBook.Damage) do
			PA:Message(Spell);
		end
		return;
	end

	if (action == "showbuffs") then
    	for Buff, _ in pairs(PA.SpellBook.Buffs) do
			PA:Message(PA:GetSpellProperty(Buff, "Name").." ("..Buff..")");
		end
		return;
	end

	if (action == "listactions") then
		for i = 1, 120 do
			if (HasAction(i)) then
				icon = GetActionTexture(i);
				text = GetActionText(i);
				if (text==nil) then
					text = "";
				end
				PA:Message(PA_GREN..i..""..PA_WHITE.." - "..PA_BLUE..""..text.." "..icon);
			end
		end
		return;
	end

end

-----------------------------------------------------
-- Pick Blessing to cast according to level of Target
-- and fix any known level issues here
-----------------------------------------------------
function PA:BlessByLevel(blessing, unit, override, skipTargetCheck, forceGroup)
	local targetlvl;

	--PA:ShowText("BlessByLevel skip=", skipTargetCheck);

	if (unit==nil) then
		unit = "target";
	end

	if (PA:CheckMessageLevel("Bless", 5)) then
		PA:Message4("BlessByLevel "..unit.." "..blessing);
	end

	if (skipTargetCheck or UnitExists(unit)) then
		targetlvl = UnitLevel(unit);

		if (override and targetlvl<=4 and blessing~=PA.DefaultBuff and blessing~="pws") then
			blessing = PA.DefaultBuff
			if (PA:CheckMessageLevel("Bless", 4)) then
				 PA:Message4(PA_GREN.."Auto-switch blessing to "..PA.SpellBook[PA.DefaultBuff].Name.." because of target level.");
			end
		end

		if (forceGroup==true and PA.SingleToGroup[blessing]~=nil) then
			if (PA:SpellInSpellBook(PA.SingleToGroup[blessing])) then
				blessing = PA.SingleToGroup[blessing];
			end
		end

		if (blessing~=nil and PA:SpellInSpellBook(blessing)) then
			return PA:BuffByLevel(blessing, PA.Spells.Levels[blessing], unit, skipTargetCheck);
		end
	end
	return false;
end

function PA:BlessingRankCheck(spell, levels, self, tlevel, unit)

	-------------------
	-- No blessings yet
	------------------
	if (self < 4) then
		return;
	end
	--------------------
	-- Check lowest Rank
	--------------------
	if (tlevel < (levels[1]-10)) then
		if (PA:CheckMessageLevel("Bless", 4)) then
			PA:Message4(PA:UnitName(unit).." is too low in levels to receive "..spell..".");
			PA:Message4(PA:UnitName(unit).." must be at least level "..(levels[1]-10)..".");
		end
		return;
	end

	------------------------------------------------
	-- Check self for lowest level to cast at Rank 1
	------------------------------------------------
	if (self < levels[1]) then
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4("You do not have enough levels for "..spell..".");
			PA:Message4("You must attain level "..levels[1].." to cast it.");
		end
	end
end

function PA:ProcessRankedBlessing(spell, levels, self, tlevel, unit)
	local total=0;

	if (levels~=nil and type(levels)=="table") then
		total = getn(levels);
	else
		return false, spell, nil;
	end

	for i = total, 1, -1 do
		--PA:ShowText("i=", i);
		--PA:ShowText("self=", self);
		--PA:ShowText("tlevel=", tlevel);
		--PA:ShowText("levels[i]=", levels[i]);
		--PA:ShowText("SpellInSpellBook=", PA:SpellInSpellBook(spell, i));
		if (self >= levels[i] and tlevel >= (levels[i]-10) and PA:SpellInSpellBook(spell, i)) then
			return true, spell, i;
		else
			PA:BlessingRankCheck(spell, levels, self, tlevel, unit);
		end
	end
	return false, spell, nil;
end

--------------------------------------------------------------------------------------------------------
-- Check rank to unit level and ( check spells that are valid only for party or raid (noMessage ~= nil))
--------------------------------------------------------------------------------------------------------
function PA:ProcessBlessing(spell, levels, self, tlevel, unit, minRank, noMessage, defaultReplace)

	--PA:ShowText("minRank=", minRank);
	if (minRank>0) then
		return PA:ProcessRankedBlessing(spell, levels, self, tlevel, unit)
	end

	if (self >= levels[1] and tlevel >= (levels[1]-10) and PA:SpellInSpellBook(spell, minRank)) then

		--- Check spells that are valid for player or only party/raid memnbers
		if (noMessage~=nil) then
			if ((UnitIsUnit(unit, "player") or (UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit) ))) then
				return true, spell, 0;
			else
				--PA:ShowText("unit=", unit);
				--PA:ShowText("PA:IsInParty()=", PA:IsInParty());
				--PA:ShowText("PA:IsInRaid()=", PA:IsInRaid());
				--PA:ShowText("unit==player=", UnitIsUnit("player", unit));
				--PA:ShowText("UnitInParty(unit)=", UnitPlayerOrPetInParty(unit));
				--PA:ShowText("UnitInRaid(unit)=", UnitPlayerOrPetInRaid(unit));
 				if (PASettings.Switches.QuietOnNotRequired~=true) then
 					if (PA:CheckMessageLevel("Bless", 1)) then
						PA:Message4(noMessage);
					end
				end
			end
		else
			return true, spell, 0;
		end
	else
		PA:BlessingRankCheck(spell, levels, self, tlevel, unit);
		if (not PA:SpellInSpellBook(spell)) then
			if (PA:CheckMessageLevel("Bless", 1)) then
				PA:Message4(spell.." is not in your spellbook.");
			end
		end
		if (defaultReplace) then
			if (PA:CheckMessageLevel("Bless", 3)) then
				PA:Message4("You will cast "..PA.SpellBook[PA.DefaultBuff].Name.." instead.");
			end
			return PA:ProcessRankedBlessing(PA.DefaultBuff, PA.Spells.Levels[PA.DefaultBuff], self, tlevel, unit)
		end
	end
	return false, spell, nil;
end

-----------------------------------------------------------------------------------------------
-- Bless selected target with blessing
-- 1.0  Fix to default action. No such thing as rank 0 (ok later in life I found out there was)
-- 1.1  addition. Process Spells with no Rank
-- 1.11 addition. Improved error reporting
-- 1.2  addition. Added logic to save buffs with alt+macro
-- 1.21 addition. Use settings for monitoring Alt+ key
-- 2.0  fix for level checking (Bok, SoSal, and Bof)
-- 2.0	Treat Druids in Forms differently
-- 2.0	Use BOM as a backup spell to BoK in all cases.
------------------------------------------------------------------------------------------------
function PA:BuffByLevel(spell, levels, unit, skipTargetCheck)
	--PA:ShowText("BuffByLevel");
	Spell, Rank = PA:GetBuffAndLevel(spell, levels, unit, skipTargetCheck);
	if (Spell==nil) then
		return false;
	end
	if (PA:GetSpellCooldown(Spell)) then
		return PA:DoBuff(Spell, Rank, unit, nil);
	end
	return false;

end

function PA:DoBuff(spell, rank, unit, owner)

	----------------------------------------------------------
	-- Set the Internal Spell Tracker Type of Spell being Cast
	-- 1.31 Update the PA.Cycles.Spell Tracking data.
	----------------------------------------------------------
	PA.Cycles.Spell["Type"] 		= "Bless";
	PA.Cycles.Spell.Active.spell	= PA.SpellBook[spell].Name;
	PA.Cycles.Spell.Active.rank		= rank;
	PA.Cycles.Spell.Active.target	= unit;
	_, PA.Cycles.Spell.Active.Class = UnitClass(unit);
	if (owner~=nil) then
		PA.Cycles.Spell.Active.owner = owner;
	elseif (PA.Cycles.Spell.Active.owner==nil) then
		local PetText = nil;
		PA.Cycles.Spell.Active.owner, PetText = PA:GetUnitsOwner(unit);
		if (PA.Cycles.Spell.Active.owner~=nil and PetText~=nil) then
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4("Blessing "..PetText);
			end
		end
	end

	if (PA:CastSpell(PA:CombineSpell(PA.SpellBook[spell].Name, rank), unit)) then
		PA.Cycles.Spell.Active.success 	= true;
		return true;
	end

end

-- Get the spell and rank to buff with
function PA:GetBuffAndLevel(shortSpell, levels, unit, skipTargetCheck)

	--PA:ShowText("GetBuffAndLevel skip=", skipTargetCheck);
	local range = 0;
	local found = false;
	local total = 0;

	if (unit==nil) then
		unit = "target";
	end

	if (shortSpell==nil or PA.SpellBook[shortSpell]==nil) then
		return nil;
	end

	local self = UnitLevel("player");

	if (levels and type(levels)=="table") then
		total = getn(levels);
	else
		total = 1;
	end

	if (skipTargetCheck or UnitExists(unit)) then
		local tlevel = UnitLevel(unit);
		local ClassLoc, Class = UnitClass(unit);

		if (PA:CheckMessageLevel("Bless", 5)) then
			PA:Message4(shortSpell.." for a level "..tlevel.." "..ClassLoc..".");
		end

		local TargetOK = true;
		local Exists, Status, InRange;
		if (not skipTargetCheck) then
			TargetOK, Exists, Status = PA:CheckTarget(unit, false, PA.Spells.Default.Bless, PASettings.Switches.UseActionRange.Bless);
			--if (not TargetOK) then
			--	PA:ShowText("Buff target not OK Status=", Status, " InRange=", InRange);
			--end
		end

		if (TargetOK) then

			if (levels and type(levels)=="table") then sort(levels); end

			local rank = PA.SpellBook[shortSpell].MinRank;
			--PA:ShowText("shortSpell=", shortSpell);
			--PA:ShowText("MinRank=", rank);

			local MightReplace = (shortSpell=="bok" or shortSpell=="gbok");
			local NoMessage = nil;
			if (ShortSpell=="bosal" or shortSpell == "gbosal") then
				NoMessage = PANZA_MSG_SAL_NO;
			end
			found, shortSpell, rank = PA:ProcessBlessing(shortSpell, levels, self, tlevel, unit, rank, NoMessage, MightReplace);

			--PA:ShowText("shortSpell=", shortSpell);
			if (shortSpell==nil or PA.SpellBook[shortSpell]==nil) then
				return nil;
			end
			--PA:ShowText("Found=", found);
			--PA:ShowText("Spell=", spell);
			--PA:ShowText("Rank=", rank);
			local spell = PA.SpellBook[shortSpell].Name;
			if (found==true and rank>=0) then
				-------------------------------------------------------------------------
				-- 1.2  Save Blessings for Players
				-- 1.21 Use settings to determine if we monitor the Control key
				-- 1.31 Trap moved to cli
				-------------------------------------------------------------------------
				if (PA.Cycles.Buff.Saving == true) then
					PA.Cycles.Buff.Saving = false; 		-- reset it asap

					---------------------------------------------------------
					-- Create a new entry if it does not exist for the player
					---------------------------------------------------------
					if (UnitIsPlayer(unit)) then
						if UnitIsUnit(unit, "player") then
							--------------------------
							-- 2.0 Update DCB "Me" Row
							--------------------------
							local MyStateText = PA:DCB_GetStateText();
							PASettings.DCB[MyStateText].SELF = shortSpell;
							if (PA:CheckMessageLevel("Bless", 1)) then
								PA:Message4("Updating DCB("..MyStateText..") for Me with "..spell);
							end

							---------------------------------------
							-- Update the DCB dialog if it is shown
							---------------------------------------
							if (PanzaDCBFrame:IsVisible()) then
								PA:DCB_SetValues();
							end
						else
							local UName = PA:UnitName(unit);
							if (UName~="target") then
								if (PASettings.BlessList[UName]==nil) then
									PASettings.BlessList[UName] = {};
								end
								-----------------------------------------------------------------
								-- If it wasn't created, this will modify the spell entry anyway.
								-----------------------------------------------------------------
								PASettings.BlessList[UName].Spell = shortSpell;
								PASettings.BlessList[UName].ClassLoc = ClassLoc;
								PASettings.BlessList[UName].Class = Class;
								if (PA:CheckMessageLevel("Bless", 1)) then
									PA:Message4("Saving "..spell.." to Blessing List for "..UName..".");
								end
								if (PanzaPBMIndiFrame and PanzaPBMIndiFrame:IsVisible()) then
									PA:PBMIndi_SetValues();
								end

							end
						end
					else
						if (PA:CheckMessageLevel("Bless", 1)) then
							PA:Message4("Panza: Blessings may only be saved for players.");
						end
					end
				end
				return shortSpell, rank;
			else
				if (PA:CheckMessageLevel("Bless", 1)) then
					PA:Message4("Spell "..spell.."("..shortSpell..") invalid.");
				end
			end
		end
	end
	return nil;
end

---------------------------------------------------------------
-- Blesses Druid depending on shapeshift
---------------------------------------------------------------
function PA:AdjustClassForShapeShifting(unit, ClassEn)

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("PA:AdjustClassForShapeShifting() is checking a "..ClassEn);
	end

	if (ClassEn == "DRUID" and PA.Cycles.UseGreaterBlessings==false) then

		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Checking for Druid Shape Shifts...");
		end

		if (PA:UnitHasBlessing(unit, "Druid-Bear")) then
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4(PA:UnitName(unit).." is in Bear form. Changing Class to "..PANZA_WARRIOR);
			end
			return "WARRIOR";

		elseif (PA:UnitHasBlessing(unit, "Druid-Moon")) then
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4(PA:UnitName(unit).." is in MoonKin form. Changing Class to "..PANZA_MAGE);
			end
			return "MAGE";

		elseif (PA:UnitHasBlessing(unit, "Druid-Cat")) then
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4(PA:UnitName(unit).." is in Cat form. Changing Class to "..PANZA_ROGUE);
			end
			return "ROGUE";
		end
	end
	return ClassEn;
end

--------------------------------------------------------------------------------------------------------------
-- Call this function from a macro in with "/paladin autobless" to autobless your target
-- according to class and level and location.
---------------------------------------------------------------------------------------------------------------
function PA:AutoBless(unit, forceSelf)

	--PA:ShowText("AutoBless");
	if (PA:AbortHealCheck()) then
		return false;
	end

	local Blessing = PA:GetAutoBlessing(unit, forceSelf);
	local Success = false
	if (Blessing~="SKIP" and Blessing~="NOREQ") then
		Success = PA:BlessByLevel(Blessing, unit, true, false);
	end
	if (not Success and PASettings.Switches.QuietOnNotRequired~=true) then
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(PA_YEL..PANZA_BLESS_DONE_NONE);
		end
	end
	return Success;
end

--------------------------------------
-- Determines best blessing for target
--------------------------------------
function PA:GetAutoBlessing(unit, forceSelf)

	--PA:Debug("PA:AutoBless unit=", unit);
	-------------------------------------------------------------------
	-- Use settings to determine if we monitor the alt+key for anything
	-------------------------------------------------------------------
	if (forceSelf==true) then
		unit = "player";
	elseif (unit==nil) then
		unit = "target";
	end

	if (PA:CheckMessageLevel("Bless", 5)) then
		PA:Message4("PA:AutoBless unit="..unit);
	end

	if (UnitExists(unit)) then
		local class, classEn = UnitClass(unit);
		if (PA:CheckMessageLevel("Bless", 5)) then
			PA:Message4("Autobless class: "..class.."("..classEn..")");
		end

		------------------------------------------
		-- Blessing of Wisdom override if mana low
		------------------------------------------
		if (unit~=nil and classEn~=nil and PASettings.Switches.BlessBowOnLowMana.enabled and PA:CheckMana(unit)) then
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4("Switching blessing to Wisdom. Target has low mana");
			end
			PA.Cycles.Spell.Active.defclass = "(LowMana)";
			return "bow";
		end

		-----------------------------------------------------------
		-- 1.2  Addition Saved Blessing gets used if it exists
		-- 1.21 Addition of root key for unique lists per character
		-- 2.0  For Player, Use DCB Instead
		-----------------------------------------------------------

		local Name = PA:UnitName(unit);
		if (Name~="target" and PASettings.BlessList[Name]~=nil and not UnitIsUnit(unit, "player")) then
			PA.Cycles.Spell.Active.defclass = "(Saved)";
			return PASettings.BlessList[Name].Spell;
		end

		local ShortState;
		-------------------------------------
		-- 2.0 We are special (pun intended)
		-------------------------------------
		if (UnitIsUnit(unit, "player")) then

			-----------------------------------------------------
			-- Disable Me Row if Group Blessings are being used
			-----------------------------------------------------
			if (PA:IsInBG() and PASettings.Switches.GreaterBlessings["BG"]==true) then
				ShortState = "bg";
			elseif (PA:IsInRaid() and PASettings.Switches.GreaterBlessings["RAID"]==true) then
				ShortState = "raid";
			elseif (PA:IsInParty() and PASettings.Switches.GreaterBlessings["PARTY"]==true) then
				ShortState = "party";
			else
				ShortState = PA:DCB_GetStateText();
				classEn = "SELF";
			end
			--PA:Debug("ShortState=", ShortState, " classEn=", classEn);

		--------------------------------------------------------------
		-- 2.0 Use bg buff for party and raid if inside a battlefield
		---------------------------------------------------------------
		elseif (PA:IsInBG() and UnitPlayerOrPetInRaid(unit)) then
			ShortState = "bg";

		-------------------------------------------------------------------------------------------------------------------------------------
		-- 2.1 If we are in a Raid Group, and the target is NOT in our Party (unless IgnorePartyInRaid set) , use the Raid blessing default.
		-------------------------------------------------------------------------------------------------------------------------------------
		elseif (PA:IsInRaid() and UnitPlayerOrPetInRaid(unit) and (PASettings.Switches.IgnorePartyInRaid.enabled or not UnitInParty(unit))) then
			ShortState = "raid";

		----------------------------------------------------------------------------------------------------------------------------------
		-- 1.21 Update. The "Party" setting will be used for members of our party even if we are in a Raid (unless IgnorePartyInRaid set).
		----------------------------------------------------------------------------------------------------------------------------------
		elseif (PA:IsInParty() and UnitPlayerOrPetInParty(unit)) then
			ShortState = "party";

		-----------------------------------------------
		-- 1.21 Update. Use the Solo setting otherwise.
		-- 2.0  Use the DCB Table
		-----------------------------------------------
		else
			ShortState = "solo";
		end
		return PA:ActiveBless(unit, classEn, ShortState)

	end
	return "NOREQ";
end

------------------------------------------------------------
-- Find buff depending on class, and skip non-active classes
------------------------------------------------------------
function PA:ActiveBless(unit, classEn, state)
	local Blessing;
	--PA:Debug("PA:ActiveBless unit=", unit, " Class=", classEn, " state=", state);
	local Class = PA:AdjustClassForShapeShifting(unit, classEn);
	--PA:Debug("Ajusted class=", Class);
	Blessing, PA.Cycles.Spell.Active.defclass = PA:DCBlessing(Class, state, unit);
	if (PA:CheckMessageLevel("Bless", 5)) then
		PA:Message4("DCB Table returns "..Blessing.." for "..Class..", with state="..state);
	end

	if (Blessing=="SKIP") then
		--------------------------------------------
		-- Mimic Spellcast Stop event for CycleBless
		--------------------------------------------
		if (PA.Cycles.Spell.Active.msgtype ~= nil and PA.Cycles.Spell.Active.msgtype == "CycleBless") then
			PA.Cycles.Spell.Active.msginfo = PA:UnitName(PA.Cycles.Spell.Active.target).." was skipped (DCB).";
			-- Blessing 'succeeded', remove from failed list
			PA:RemoveFromFailed(PA.Cycles.Spell.Active.target);
		end
	end
	return Blessing
end

function PA:FailWeight(fail)
	return PANZA_IGNORE_FAILED - GetTime() + fail.Time + math.floor(fail.count / 5) * PANZA_FAILED_INC;
end

--------------------
-- Auto Select Bless
--------------------
function PA:AsBless(unit, forceReset, forceSelf)

	if (PA:AbortHealCheck()) then
		return false;
	end

	if (not PA:SpellInSpellBook(PA.Spells.Default.Bless)) then
		return false;
	end

	if (unit==nil) then
		unit = "target";
	end

	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("PA:AsBless Target="..unit);
	end

	if (forceReset==true) then
		PA:SpellListReset();
	end

	if (forceSelf==true) then
		return PA:AutoBless("player", false);
	end

	local Castable = PA:SpellCastableCheck(unit, PA.Spells.Default.Bless, PASettings.Switches.UseActionRange.Bless);
	----------------------------------------------------------------------------------
	-- Target is self or unfiendly or vanity pet or out of range, then buff self according to CycleBless flag
	----------------------------------------------------------------------------------
	local Owner, PetText = PA:GetUnitsOwner(unit);
	if (UnitIsUnit(unit, "player") or PA:IsVanityPet(unit)
		or not PA:UnitIsMyFriend(unit) or not Castable) then
		if (PASettings.Switches.EnableCycle) then
			return PA:CycleBless(false);
		end
		return PA:AutoBless("player", false);
	end

	-------------------------
	-- We are in a Party/Raid
	-------------------------
	if (PA:IsInParty() or PA:IsInRaid()) then
		----------------------------------------------------------------------
		-- Target is in out Party/Raid, then buff according to CycleBless flag
		----------------------------------------------------------------------
		if (UnitPlayerOrPetInParty(unit) or UnitPlayerOrPetInRaid(unit)) then
			if (PASettings.Switches.EnableCycle) then
				return PA:CycleBless(false);
			end
			return PA:AutoBless(unit, false);
		------------------------------------------------------------------------------
		-- Friendly target is not in out Party/Raid and we can look outside, then buff
		------------------------------------------------------------------------------
		elseif (PASettings.Switches.EnableOutside == true) then
			return PA:AutoBless(unit, false);
		end
	---------------------------------------------------------------------
	-- Not in a party/raid, but must be friendly player or pet, then buff
	---------------------------------------------------------------------
	else
		return PA:AutoBless(unit, false);
	end

	return false;
end

function PA_CastBlessing(unitInfo)
	PA.Cycles.Spell.Active.msgtype = "CycleBless";
	PA.Cycles.Spell.Active.owner = unitInfo.Owner;
	PA.Cycles.Spell.Active.defclass = unitInfo.Defclass;
	return PA:BlessByLevel(unitInfo.ShortSpell, unitInfo.Unit, true, true);
end

--------------------
-- Reset cycle bless
--------------------
function PA:SpellListReset()
	if (PACurrentSpells~=nil) then
		if (PACurrentSpells.Indi~=nil) then
			for Name, Set in pairs(PACurrentSpells.Indi) do
				--PA:ShowText("Name=", Name);
				for Id, SpellInfo in pairs(Set) do
					SpellInfo.Reset = true;
				end
			end
		end
		PACurrentSpells.Group = {};
	end
	PA:CleanupSpells();
	if (PA:CheckMessageLevel("Bless", 1)) then
		PA:Message4("Cycle Buff reset");
	end
end

------------------------------
-- Bless group members in turn
------------------------------
function PA:CycleBless(forceReset)

	if (PA:AbortHealCheck()) then
		return false;
	end

	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("Cycle Bless");
	end
	--PA:Message(PA_WHITE.."BEGIN! Cycle Bless");

	PA.Cycles.Group.NextBless = -1;

	local State = PA:DCB_GetStateText();
	PA.Cycles.UseGreaterBlessings = (PASettings.Switches.GreaterBlessings[string.upper(State)]==true);
	PA.Cycles.Group.Done			= 0;
	PA.Cycles.Group.DoneWho			= {};
	PA.Cycles.Group.Dead			= {};
	PA.Cycles.Group.OutOfRange		= {};
	PA.Cycles.Group.NoPVP 			= {};
	PA.Cycles.Group.Disconnected 	= {};
	PA.Cycles.Group.Skipped 		= {};

	if (forceReset==true) then
		PA:SpellListReset();
	end

	local MessageLevel = PASettings.Switches.MsgLevel.Bless;
	local Blessed = false;
	local ExcludedCount = 0;
	local Unit;
	Blessed, Unit, PA.Cycles.Group.Count, ExcludedCount = PA:AutoGroup({PreCheck=PA_BuffPreCheck, Weighting=PA_BuffWeighting, Cast=PA_CastBlessing}, MessageLevel, "Bless", PASettings.Switches.Pets.Bless, "Bless");
	--PA:Debug("Blessed=", Blessed);
	PA:Debug("Blessed=", Blessed, " Done=", PA.Cycles.Group.Done);
	if (Blessed) then
		return true;
	end

 	-- If we get here no blessings have been attempted
 	if (PASettings.Switches.QuietOnNotRequired~=true) then
		if (PA.Cycles.Group.NextBless>0) then
			if (PA.Cycles.Group.NextBless<1) then
				if (PA:CheckMessageLevel("Bless", 1)) then
					PA:Message4(PA_YEL..format(PANZA_BLESS_DONE_LOW, PA.Cycles.Group.NextBless));
				end
			elseif (PA.Cycles.Group.NextBless>60) then
				if (PA:CheckMessageLevel("Bless", 1)) then
					PA:Message4(PA_YEL..format(PANZA_BLESS_DONE_HIGH, math.floor(PA.Cycles.Group.NextBless/60), math.mod(PA.Cycles.Group.NextBless, 60)));
				end
			else
				if (PA:CheckMessageLevel("Bless", 1)) then
					PA:Message4(PA_YEL..format(PANZA_BLESS_DONE, PA.Cycles.Group.NextBless));
				end
			end
		else
			if (PA:CheckMessageLevel("Bless", 1)) then
				PA:Message4(PA_YEL..PANZA_BLESS_DONE_NONE);
			end
		end
	end
	if (PA.Cycles.Group.Count>1 or MessageLevel>3) then
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(format(PANZA_BLESS_COUNT, PA.Cycles.Group.Done, PA.Cycles.Group.Count, PA:Percent(PA.Cycles.Group.Done, PA.Cycles.Group.Count)));
		end
		PA:DisplayMissingBlessings();
	end
	return false;
end

function PA:NotBlessedMessage(formatTxt, unitList, totalCount)
	local UnitCount = PA:TableSize(unitList);
	if (UnitCount>0) then
		local UnitText = "";
		if (PASettings.NotBlessedCount>0) then
			UnitText = " - "..PA_BLUE;
			local Sep = "";
			local DisplayCount = 0;
			for key, value in pairs(unitList) do
				DisplayCount = DisplayCount + 1;
				if (DisplayCount>PASettings.NotBlessedCount) then
					UnitText = UnitText.."...";
					break;
				end
				local Start, End, OwnerName, PetName = string.find(key, "([^_]+)_([^_]+)");
				if (PetName==nil) then
					UnitText = UnitText..Sep..key;
				else
					UnitText = UnitText..Sep..PA_BGREY..PetName..PA_BLUE;
				end
				Sep = ", ";
			end
		end
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(format(formatTxt, UnitCount, PA:Percent(UnitCount, totalCount))..UnitText);
		end
	end
end

function PA:DisplayMissingBlessings()
	PA:NotBlessedMessage(PANZA_BLESS_DEAD, PA.Cycles.Group.Dead, PA.Cycles.Group.Count);
	PA:NotBlessedMessage(PANZA_BLESS_OUTOFRANGE, PA.Cycles.Group.OutOfRange, PA.Cycles.Group.Count);
	PA:NotBlessedMessage(PANZA_BLESS_DISCONNECTED, PA.Cycles.Group.Disconnected, PA.Cycles.Group.Count);
	PA:NotBlessedMessage(PANZA_BLESS_NOPVP, PA.Cycles.Group.NoPVP, PA.Cycles.Group.Count);
	PA:NotBlessedMessage(PANZA_BLESS_SKIPPED, PA.Cycles.Group.Skipped, PA.Cycles.Group.Count);
	PA:NotBlessedMessage(PANZA_BLESS_FAILED, PA.Cycles.Group.Fail, PA.Cycles.Group.Count);
end

function PA:CheckMana(unit)
	if (UnitPowerType(unit)==0) then
		if (PA:CheckMessageLevel("Bless", 5)) then
			PA:Message4("Mana check for "..unit);
		end
		local Mana = UnitMana(unit);
		local ManaMax = UnitManaMax(unit);
		local ManaPercent = 100.0 * Mana / ManaMax;
		if (PA:CheckMessageLevel("Bless", 5)) then
			PA:Message4("Mana= "..Mana.."  Max="..ManaMax.." ("..ManaPercent.."%)");
		end
		return (ManaPercent<PASettings.BoWManaLimit);
	else
		return false;
	end
end

function PA:AddEntry(entryTable, unit, name)
	--PA:ShowText("AddEntry name="..name.." unit=", unit);
	if (entryTable[name]==nil) then
		entryTable[name] = {unit=unit};
	end
end

function PA:GetCycleBlessing(info)
	------------------------------------------
	-- Blessing of Wisdom override if mana low
	------------------------------------------
	if (info.Unit~=nil and info.Class~=nil and PASettings.Switches.BlessBowOnLowMana.enabled and PA:CheckMana(info.Unit) and not PA:UnitHasBlessing(info.Unit, "bow")) then
		if (PA:CheckMessageLevel("Bless", 4)) then
			PA:Message4("Switching blessing to Wisdom. Target has low mana");
		end
		return "bow", "(LowMana)", PA:GetSpellState(info.Unit, info.Name, "bow");
	end

	-----------------
	-- Saved blessing
	-----------------
	if (not info.IsSelf and info.Owner==nil and PASettings.BlessList[info.Name]~=nil) then
		return PASettings.BlessList[info.Name].Spell, "(Saved)", PA:GetSpellState(info.Unit, info.Name, PASettings.BlessList[info.Name].Spell);
	end

	local Class = info.Class;
	if (info.IsSelf) then
		Class = "SELF";
	end
	if (Class==nil) then
		return;
	end
	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("Class="..Class);
	end
	Class = PA:AdjustClassForShapeShifting(info.Unit, Class);
	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("Adjusted Class="..Class);
	end

	local State = info.State;
	if (info.InRaid and info.InParty and not PASettings.Switches["IgnorePartyInRaid"].enabled) then
		State = "party";
	end
	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("State="..State);
	end
	local Blessing, Defclass, SpellState, LastSpell, Expires = PA:DCBlessing(Class, State, info.Unit, info.Name);
	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("Blessing="..tostring(Blessing));
	end
	return Blessing, Defclass, SpellState, LastSpell, Expires;
end

-------------------------------
-- Check if buff should be cast
-------------------------------
function PA_BuffPreCheck(info)
	info.ShortSpell, info.Defclass, info.SpellState, info.LastSpell, info.Expires = PA:GetCycleBlessing(info);
	--PA:ShowText("    Blessing=", info.ShortSpell, " Defclass=", info.Defclass);
	--PA:ShowText("    SpellState=", info.SpellState, " LastSpell=", info.LastSpell, " Expires=", info.Expires);
	if (info.ShortSpell==nil) then
		--PA:Message(PA_YEL.."  BadBuff");
		PA:Debug("  Bad Buff");
		info.Message = "Bad Buff";
		return false;
	end

	if (info.ShortSpell=="SKIP" or info.ShortSpell=="NOREQ" or info.SpellState==PA_SPELL_EXTERNAL) then
		if (PA:CheckMessageLevel("Bless", 4)) then
			PA:Message4("No buff required");
		end
		if (info.ShortSpell=="SKIP") then
			PA:AddEntry(PA.Cycles.Group.Skipped, info.Unit, info.Name);
		else
			if (info.Expires~=nil) then
				local NextBless = info.Expires - PASettings.Switches["Rebless"];
				if (NextBless<PA.Cycles.Group.NextBless or PA.Cycles.Group.NextBless<0) then
					PA.Cycles.Group.NextBless = NextBless;
				end
			end
		end
		PA:IncDone(info.Name);
		if (info.ShortSpell=="SKIP" or info.ShortSpell=="NOREQ") then
			info.Message = "Spell="..info.ShortSpell;
		else
			info.Message = "SpellState="..PA_SPELL_EXTERNAL;
		end
		return false;
	end

	-- If group buff on self then check PCB (unless solo)
	PA:Debug("  IsSelf=", info.IsSelf, " Spell=", info.ShortSpell, " InParty=", info.InParty, " InRaid=", info.InRaid);
	if (info.IsSelf==true and PA.SpellBook.GroupBuffs[info.ShortSpell]~=nil and (info.InParty==true or info.InRaid==true)) then
		if (PASettings.Switches.ClassSelect[PA.PlayerClass].Bless==false) then
			info.Message = "Unit="..info.Unit.." excluded by PCS ("..PA.PlayerClass..")";
			PA:Debug("  ", info.Message);
			PA.ExcludedCount = PA.ExcludedCount + 1;
			PA:IncDone(info.Name);
			return false;
		end
	end

	return true;
end

function PA:IncDone(name)
	if (name~=nil and name~="target" and PA.Cycles.Group.DoneWho~=nil and PA.Cycles.Group.DoneWho[name]~=true) then
		PA.Cycles.Group.Done = PA.Cycles.Group.Done + 1;
		PA.Cycles.Group.DoneWho[name] = true;
		PA:Debug("  ", name, ": Inc Done to ", PA.Cycles.Group.Done);
	end
end

-----------------------------------------------------------------
-- Determine if group member needs buffing and assign a weighting
-----------------------------------------------------------------
function PA_BuffWeighting(info)

	if (info.FailBias<0) then
		--PA:Debug("  FailBias=", info.FailBias);
		info.Affected = PASettings.Switches["Rebless"] + info.FailBias;
		if (info.Affected<0) then
			info.Affected = 0;
		end
		info.FailBias = 0;
	end

	if (info.SpellState~=PA_SPELL_FREE) then
		if (PA:CheckMessageLevel("Bless", 4)) then
			PA:Message4("Found previous buff "..info.LastSpell.Spell.."("..info.LastSpell.Short..") "..format("%.1f", GetTime() - info.LastSpell.Time).."s ago");
		end
		local ShortDurationBuff = (PA:GetSpellProperty(info.LastSpell.Short, "Duration")<300);
		if (info.SpellState==PA_SPELL_SET or ShortDurationBuff) then
			-- Refresh
			if (info.Expires<0) then
				if (PA:CheckMessageLevel("Bless", 4)) then
					PA:Message4("  Buff expired");
				end
				--PA:Message(PA_YEL.."  Expired");
				info.Affected = 0;
			elseif (ShortDurationBuff or info.Expires>=PASettings.Switches.Rebless) then
				local NextBless = info.Expires;
				if (ShortDurationBuff) then
					if (PA:CheckMessageLevel("Bless", 4)) then
						PA:Message4("  Short buff");
					end
				else
					if (PA:CheckMessageLevel("Bless", 4)) then
						PA:Message4("  Current buff OK");
					end
					NextBless = NextBless - PASettings.Switches.Rebless;
				end
				if (NextBless<PA.Cycles.Group.NextBless or PA.Cycles.Group.NextBless<0) then
					PA.Cycles.Group.NextBless = NextBless;
				end
				PA:IncDone(Name);
				return false;
			else
				if (PA:CheckMessageLevel("Bless", 4)) then
					PA:Message4("Setting Affected to "..info.Expires);
				end
				info.Affected = info.Expires;
			end
		else
			info.Affected = 0;
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4("Updating with new buff");
			end
		end
	else
		info.Affected = 0;
		if (PA:CheckMessageLevel("Bless", 4)) then
			PA:Message4("No previous buff");
		end
	end
	if (info.IsSelf) then
		info.Affected = info.Affected - 2; -- Ensure we come first
	elseif (info.InRange==true) then
		info.Affected = info.Affected - 1; -- Next Priority to those in range
	end
	return true;
end

---------------------------------
-- Find our current target's name
---------------------------------
function PA:TargetCycleNear()
	local Name = PA:UnitName("target");

	if (Name~="target") then
		local DisplayName = Name;
		local Owner, PetText = PA:GetUnitsOwner("target");
		if (Owner~=nil) then
			DisplayName = Name.." ("..PetText..")";
			Name = Owner.."_"..Name;
		end
		return Name, DisplayName, Owner;
	else
		return nil, nil;
	end
end

------------------------------------------------------
-- Bless nearby players with autobless()
------------------------------------------------------
function PA:CycleBlessNear(forceReset, forceSelf)

	if (not PA:GetSpellCooldown(PA.CycleBuff)) then
		return; -- This stops spamming the key from locking-up WoW
	end
	
	-- Temporarily turn off target update code, for speed
	local PA_TargetFrame_Update = TargetFrame_Update;
	TargetFrame_Update = PA_DummyTargetFrame_Update;

	local Status, Err = pcall(PA_CycleBlessNear_Safe, forceReset, forceSelf);

	-- Restore target update code
	TargetFrame_Update = PA_TargetFrame_Update;
	PA_TargetFrame_Update = nil;

	-- Update the target
	if (PA.LastTargetFrame~=nil) then
		local OldThis = this;
		this = PA.LastTargetFrame;
		TargetFrame_OnEvent("PLAYER_TARGET_CHANGED");
		this = OldThis;
	else
		-- ClearTarget(); -- Clear target for now (Causes CycleNear to buff same target over and over) - Removed.
		-- Blizzard TargetFrame has been replaced, [TODO] add target update for other addons
	end

	if (not Status) then
		PA:ShowText(PA_RED.."Error in target protected call: ", Err);
	end

end

------------------------------------------------------
-- Bless nearby players with autobless() Safe verion
------------------------------------------------------
function PA_CycleBlessNear_Safe(forceReset, forceSelf)

	if unexpected_condition then error() end
	local InBG = PA:IsInBG();

	if (forceReset==true) then
		PA:SpellListReset();
	end
	TargetNearestFriend();

	local Name, DisplayName, Owner =  PA:TargetCycleNear();
	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("CycleNear: First Target="..Name);
	end

	----------------------------------
	-- 2.0 Skipping NPCs now default.
	----------------------------------
	local BlessNPCs = PASettings.Switches.EnableNPC;

	for i = 1, (PASettings.Switches.NPCount + 1) do
		--PA:ShowText("BlessNPCs=", tostring(BlessNPCs));
		--PA:ShowText("IsPlayer=", tostring(UnitIsPlayer("target")));
		--PA:ShowText("Owner=", Owner);
		--PA:ShowText("Name=", Name);
		-- Vanity Pet check
		if (not PA:IsVanityPet("target")) then
			if (BlessNPCs or (Owner~=nil and PASettings.Switches.Pets.Bless==true) or UnitIsPlayer("target")) then
				if (Name~=nil) then

					local Blessing = PA:GetAutoBlessing("target", forceSelf);

					--PA:ShowText("Name=", DisplayName, " Blessing=", Blessing);
					if (Blessing~="SKIP" and Blessing~="NOREQ") then
						local ShortSpell, Rank = PA:GetBuffAndLevel(Blessing, PA.Spells.Levels[Blessing], "target", false);
						if (ShortSpell~=nil) then
							--PA:ShowText("ShortSpell=", ShortSpell);
							if (PA:GetSpellCooldown(ShortSpell)) then

								local SpellState, LastSpell = PA:GetSpellState("target", Name, ShortSpell);
								if (SpellState~=PA_SPELL_SET) then

									if (PA:DoBuff(ShortSpell, Rank, "target", Owner)) then
										if (PA:CheckMessageLevel("Bless", 4)) then
											PA:Message4("CycleNear: Buff("..ShortSpell..") cast OK.");
										end
										return true;
									else
										if (PA:CheckMessageLevel("Bless", 4)) then
											PA:Message4("CycleNear: Buff("..ShortSpell..") can't be cast.");
										end
									end

								else
									if (PA:CheckMessageLevel("Bless", 4)) then
										PA:Message4("CycleNear: "..DisplayName.." Already buffed.");
									end
								end
							else
								if (PA:CheckMessageLevel("Bless", 4)) then
									PA:Message4("CycleNear: "..DisplayName.." "..ShortSpell.." on cool-down");
								end
							end
						else
							if (PA:CheckMessageLevel("Bless", 4)) then
								PA:Message4("CycleNear: "..DisplayName.." can't buff.");
							end
						end
					else
						if (PA:CheckMessageLevel("Bless", 4)) then
							PA:Message4("CycleNear: "..DisplayName.."  No buff set.");
						end
					end
				else
					if (PA:CheckMessageLevel("Bless", 4)) then
						PA:Message4("CycleNear: Name is nil");
					end
				end

			else
				if (PA:CheckMessageLevel("Bless", 4)) then
					PA:Message4("CycleNear: Skipping NPC");
				end
			end
		else
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4("CycleNear: Skipping Vanity Pet");
			end
		end
		--TargetLastTarget();
		TargetNearestFriend();
		Name, DisplayName, Owner = PA:TargetCycleNear();
	end

	-----------------------------------
	-- 2.0 Report on a completed Cycle
	-----------------------------------
 	if (PASettings.Switches.QuietOnNotRequired~=true) then
	 	if (PA:CheckMessageLevel("Bless", 1)) then
		 	PA:Message4("No more more nearby players found to buff. ");
		 end		 
	end
	
	if (PA.LastTargetFrame==nil) then
		ClearTarget();
	end	
	
	return false;
end
