-------------------------------------------------------------------------------
-- printing/utlity functions
-------------------------------------------------------------------------------
function HateMe_println( Message)
	DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 1, 1);
end
function HateMe_debug( Message)
	-- comment this out to see all the ugly debug info
	if (HateMe_Debug_Flag) then
		DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 1, 0);
	end
end
function HateMe_printSpell( SpellName)
	-- comment this out to see all the spells cast
	if (HateMe_Debug_Flag) then
		DEFAULT_CHAT_FRAME:AddMessage("Casting "..SpellName, 1, 1, 1);
	end
end
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- this is the "aggro" tool functions
-------------------------------------------------------------------------------

-- Check for Immunity (Somna 09Feb06)
function HateMe_SpellAffect(arg1)
	if (HateMe_SpellBook) then
		if (HateMe_checkForImmunityEnabled()) then
			local currspell, currtarget, strstart, strstop;
			if string.find(arg1, "Your%s.+%sfailed%.%s.+%sis%simmune%.") then
				-- immunity detected
				if HateMe_checkForTempImmunity() then
					HateMe_println(HateMe_TEMP_IMMUNE_ERROR);
				else
					_, strstart = string.find(arg1, "Your%s");
					strstop, _ = string.find(arg1, "%sfailed%.%s.+%sis%simmune%.", strstart);
					currspell = string.sub(arg1, strstart +1, strstop -1);


					if (HateMe_SpellBook[currspell]) then
						_, strstart = string.find(arg1, "Your%s.+%sfailed%.%s");
						strstop, _ = string.find(arg1, "%sis%simmune%.", strstart);
						currtarget = string.sub(arg1, strstart +1, strstop -1);

						if currspell and currtarget then
							HateMe_println(currtarget..HateMe_IMMUNE_FOUND..currspell);

							if not HateMe_Immunity[currtarget] then
								HateMe_Immunity[currtarget] = { };
							end

							-- set current Spell to True for Immune
							HateMe_Immunity[currtarget][currspell] = true;

							HateMe_println(HateMe_IMMUNE_SAVED);
						end
					end
				end
			end
		end
	end
end

-- Check for runners
function HateMe_RunnerDetect(arg1, arg2)
	if (arg1 == "%s attempts to run away in fear!") then
		HateMe_Runners[arg2] = true;
	end
end

function HateMe_checkForTempImmunity()
	if (HateMe_CheckForDebuff(HateMe_SPELL_BANISH, "target")) then
		return true;
	elseif (HateMe_CheckForBuff(HateMe_SPELL_DIVINE_PROTECTION, "target")) then
		return true;
	elseif ((UnitName("target")) == "Charlga Razorflank") then
	    return true;
	end

	return false;
end

function HateMe_checkForImmunityEnabled()
	if (UnitPlayerControlled("target")) then
		return false;
	elseif (not HateMe_Settings["Immune Check"]) then
		return false;
	else
		return true;
	end
end

function HateMe_checkForImmunity(currTarget, spellName)
	if (HateMe_checkForImmunityEnabled()) then
		if (HateMe_checkForTempImmunity()) then
			HateMe_println(HateMe_TEMP_IMMUNE_ERROR);
			return false;
		elseif (HateMe_Immunity[currTarget] == nil) then
			return false;
		elseif (HateMe_Immunity[currTarget][spellName]) then
			return true;
		end
	end

	return false;
end

-- range valuses: 1 = 11.11 yards, 2 = 11.11 yards, 3 = 10 yards, 4 = 30 yards
function checkPartyRange(range)
	local groupType = "party";
	local InRange = 1;
	local PartyNum = GetNumPartyMembers();

	while PartyNum > 0 do
		if (CheckInteractDistance(groupType..PartyNum, range)) then
			InRange = InRange + 1;
		end

		if (CheckInteractDistance(groupType.."pet"..PartyNum, range)) then
			InRange = InRange + 1;
		end

		PartyNum = PartyNum -1;
	end

	return InRange;
end


-- do we have a shield for the shield based spells
function HateMe_CheckForShield()
	if (GetInventoryItemLink("player", HateMe_OFFHAND_SLOT)) then
		-- we don't actually care about the "link"... nil is nothing there
		HateMe_debug( "You have off hand item");

		-- fill in our tooltip
		HateMe_Tooltip:ClearLines();
		HateMe_Tooltip:SetInventoryItem("player", HateMe_OFFHAND_SLOT);

		-- and see if the item there is a shield
		-- this will change in 1.7.0

		--Change shield check to something I know will work (Somna 06Feb06)
		local offHandLink = GetInventoryItemLink("player",HateMe_OFFHAND_SLOT)
		local _, _, itemCode = strfind(offHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == "Shields") then
			return true;
		end

		--Remove old shield check method (Somna 06Feb06)
		--if (HateMe_TooltipTextRight3:IsVisible()) then
		--	local text = HateMe_TooltipTextRight3:GetText();
		--	HateMe_debug("It is a "..text);
		--	if (text == HateMe_INVENTORY_SHIELD) then
		--		return true;
		--	end
		--end
	else
		HateMe_debug( "No off hand weapons");
	end

	return false;
end



-- find the action bar slot fo the spell listed. must be in the texture cache
function HateMe_FindActionSlot(spellName)

	local i = 0;
	for i = HateMe_START_SLOT, HateMe_END_SLOT do
		if (HasAction(i)) then
			-- there is something here!

			if (GetActionText(i) == nil) then
				-- and it is a spell or ability... (macros are not nil)

				-- lets grab both icons and compare
				-- (faster then using a tool tip)
				local icon = GetActionTexture(i);
				local spellTexture = HateMe_SpellTextureCache[spellName];

				if (spellTexture == icon) then
					-- they match... now lets check the tool tip... just in case
					HateMe_Tooltip:ClearLines();
					HateMe_Tooltip:SetAction(i);
					local slotName = HateMe_TooltipTextLeft1:GetText();
					if (spellName == slotName) then
						HateMe_debug( "Slot found for "..spellName.." - "..i);
						return i;
					end
				end
			end
		end
	end
	return 0;
end

-- see if the unit is debuffed with the named item
function HateMe_CheckForDebuff( DebuffName, unit)
	local debuffApplications = 0;

	for i = 1, HateMe_MAXDEBUFFS do
		local debuff_texture = UnitDebuff(unit, i);		--"target", i);
		-- the textures do not always match spell icon... so we
		-- can't check that for a fast check

		if debuff_texture then
			-- there is some debuff, check the name
			HateMe_Tooltip:ClearLines();
			HateMe_Tooltip:SetUnitDebuff(unit, i);		--"target", i);
			if (HateMe_TooltipTextLeft1:GetText() == DebuffName) then
				debuff, debuffApplications = UnitDebuff(unit, i);	--"target", i);
				HateMe_debug( "Debuff "..DebuffName.." found! Count: " .. debuffApplications);
				return true, debuffApplications;
			end
		end
	end
	return false, 0;
end

-- check to see if unit is buffed
function HateMe_CheckForBuff( BuffName, unit)
	for i = 1, HateMe_MAXBUFFS do
		local buff_texture = UnitBuff(unit, i);		--"player", i);
		-- the textures do not always match spell icon... so we
		-- can't check that for a fast check

		if buff_texture then
			-- there is some buff, check the name

			HateMe_Tooltip:ClearLines();
			HateMe_Tooltip:SetUnitBuff(unit, i);		--"player", i);

			if (HateMe_TooltipTextLeft1:GetText() == BuffName) then
				HateMe_debug( "Buff "..BuffName.." found!");
				return true;
			end
		end
	end
	return false;
end

function HateMe_IsMobTargetingPlayer()
	if (UnitExists("targettarget")) then
		if (UnitIsUnit( "targettarget", "player")) then
			return true
		else
			HateMe_debug("target is looking at somone else.");
		end
	else
		HateMe_debug("target is looking at nobody.");
	end
	return false;
end

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- the spell casting functions... only cast a spell based on "blah"
-------------------------------------------------------------------------------

-- if the target is not targeting "player"
function HateMe_UseSpellBasedOnTargetTarget( spellName, bank)
	if (UnitExists("targettarget")) then
		-- the mob is targeting someone (would bug out on stunns before)
		if (not UnitIsUnit( "targettarget", "player")) then
			-- the mob is targeting something else but "me"
			if (UnitIsFriend( "targettarget", "player")) then
			    -- the mob is targeting a friend
			    
			    -- put logic for not taunting if targettarget is tank HERE
			    
				HateMe_debug("target is lookging at someone else!");
				return HateMe_UseSpell(spellName, bank);
			end
		end
	else
		HateMe_debug("target is looking at nobody.");
	end
	return false;
end

-- if we can find the slot, AND it is lit up, cast the spell
function HateMe_UseSpellBasedOnSlot( spellName, bank)
	local slotIndex = HateMe_FindActionSlot(spellName);
	-- first find where the spell is in the action bars

	if (slotIndex ~= 0) then
		-- the spell is somewhere!
		if (IsUsableAction(slotIndex)) then
			-- and useable
			return HateMe_UseSpell(spellName, bank);
		else
			HateMe_debug(spellName.." is not lit up");
		end
	else
		HateMe_debug( "Slot for "..spellName.." not found!");
	end
	return false;
end

-- only use the spell if the target is not debuffed with it
function HateMe_UseSpellBasedOnDebuff( spellName, bank)
	if (HateMe_SpellBook[spellName]) then
		-- first check that we even have the spell
		if (not HateMe_CheckForDebuff(spellName, "target")) then
			-- the debuff is not on the mob@
			return HateMe_UseSpell(spellName, bank);
		else
			HateMe_debug( spellName.." already afflicting target");
		end
	end
	return false;
end

-- only cast a spell if you, your self, are not buffed with it
function HateMe_UseSpellBasedOnBuff( spellName, bank)
	if (HateMe_SpellBook[spellName]) then
		-- first check that we even have the spell
		if (not HateMe_CheckForBuff(spellName, "player")) then
			-- we don't have the buff... cast away!
			return HateMe_UseSpell(spellName, bank);
		else
			HateMe_debug( spellName.." is already effecting you");
		end
	end
	return false;
end

local lastSpellCast = GetTime();
-- this uses a spell, only checking for a general cooldown
-- spells with out a cool down will always pass
function HateMe_UseSpell( spellName, bank)
	HateMe_debug("trying to cast - "..spellName);
	if (HateMe_SpellBook[spellName]) then			-- first check that we even have the spell
		-- get its cool down effect
		local start, duration = GetSpellCooldown(HateMe_SpellBook[spellName], BOOKTYPE_SPELL);
		HateMe_debug("About to check its cooldown "..start.." - "..duration);
		if ((start == 0) and (duration == 0)) then	-- i could only check one of them... but i do both just in case
			if ((lastSpellCast + HateMe_SpellCooldownLag) >= GetTime()) then
				HateMe_debug("It has not been a tick of "..HateMe_SpellCooldownLag);
				return true;
			end

			-- we have a bank of rage to keep
			if (not HateMe_CheckBank( spellName, bank)) then
				-- but not enough rage to use this ability and keep the bank...
				HateMe_debug(" we don't have enough rage");
				return true;
			end

			HateMe_debug("Casting... "..spellName);

			if HateMe_Settings["Test Mode"] then
				HateMe_println("Casting... "..spellName);
			end

			if (spellName == HateMe_SPELL_SUNDER_ARMOR and KLHTM_Sunder) then
				KLHTM_Sunder();
			else
				CastSpell( HateMe_SpellBook[spellName], BOOKTYPE_SPELL);
			end


			lastSpellCast = GetTime();
			HateMe_printSpell(spellName.." b-"..bank.." c-"..HateMe_RageCost[spellName]);
			return true;
		else
			HateMe_debug( spellName.." is not ready yet!");
		end
	else
		HateMe_debug("spell not found!!!!");
	end
	return false;
end

function HateMe_GetBankAmount(spellName)
	local bank = 0;
	if (HateMe_RageCost[spellName]) then
		bank = HateMe_RageCost[spellName];
	end
	return bank;
end

function HateMe_CheckBank(spellName, bank)
	local playerRage = UnitMana("player");
	if (not HateMe_RageCost[spellName]) then
		HateMe_debug( spellName.." does not cost rage!");
		return true;
	end

	if ((HateMe_RageCost[spellName] + bank) <= playerRage) then
		return true;
	else
		return false;
	end
end

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- the ability functions
-------------------------------------------------------------------------------

function HateMe_CastSpell_Execute(bank)
	-- ignore bank

	local mobHealth = UnitHealth("target") / UnitHealthMax("target");
	local playerRage   = UnitMana("player");
	if ( mobHealth <= 0.2) then
		local start, duration = GetSpellCooldown(HateMe_SpellBook[HateMe_SPELL_EXECUTE], BOOKTYPE_SPELL);
		HateMe_debug("About to check Execute's cooldown "..start.." - "..duration);
		if ((start == 0) and (duration == 0)) then
			if (playerRage  >= (HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"] +  HateMe_GetBankAmount(HateMe_SPELL_EXECUTE) ) ) then
				if (HateMe_UseSpell(HateMe_SPELL_EXECUTE, 0)) then
					return true;
				end
			end
		else
			-- we still want to return true... to keep other spells from eating our rage
			return true;
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_EXECUTE] = HateMe_CastSpell_Execute;

function HateMe_CastSpell_BloodRage(bank)
	HateMe_debug( "doing bloodrage");
	-- ignore bank

	local playerHealth = UnitHealth("player") / UnitHealthMax("player");
	local playerRage   = UnitMana("player");
	if ( (playerHealth > HateMe_Bloodrage_MinHealth) and (playerRage < HateMe_BloodRage_MinRage) ) then
		HateMe_debug("going to check to see if it can be cast");
		if (HateMe_UseSpell(HateMe_SPELL_BLOODRAGE, 0)) then
			return true;
		end
		HateMe_debug("it was not");
	end
	HateMe_debug("all done");
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_BLOODRAGE] = HateMe_CastSpell_BloodRage;

function HateMe_CastSpell_ShieldBlock(bank)
	-- ignore bank
	-- shield block is done manually... since it is not n the global cooldown
	-- shield block helps us get revenge up...
	if (not HateMe_SpellBook[HateMe_SPELL_SHIELD_BLOCK]) then
		return false;
	end

	if (HateMe_CheckForShield()) then
		if (HateMe_IsMobTargetingPlayer()) then
			local start, duration = GetSpellCooldown(HateMe_SpellBook[HateMe_SPELL_REVENGE], BOOKTYPE_SPELL);
			-- get its cool down effect
			if ((duration - HateMe_ShieldBlockAdvance) <= 0) then


				start, duration = GetSpellCooldown(HateMe_SpellBook[HateMe_SPELL_SHIELD_BLOCK], BOOKTYPE_SPELL);
				-- getw its cool down effect
				if ((start == 0) and (duration == 0)) then
					if (not HateMe_CheckBank( HateMe_SPELL_SHIELD_BLOCK, 0)) then
						HateMe_printSpell("we need to shield block, but need rage");
						return true;
					end

					-- i could only check one of them... but i do both just in case
					HateMe_debug("Casting... "..HateMe_SPELL_SHIELD_BLOCK);
					CastSpell( HateMe_SpellBook[HateMe_SPELL_SHIELD_BLOCK], BOOKTYPE_SPELL);
					HateMe_printSpell(HateMe_SPELL_SHIELD_BLOCK);
					return true;
				else
					HateMe_printSpell("Shield block on cooldown");
				end
			else
				HateMe_printSpell("Not blocking, Revenge on cooldown");
			end
		else
			HateMe_printSpell("Mob not targeting player for shield block");
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SHIELD_BLOCK] = HateMe_CastSpell_ShieldBlock;

function HateMe_CastSpell_BerserkerRage(bank)
	if (UnitExists("targettarget")) then 	-- the mob is targeting someone
		if (UnitIsUnit( "targettarget", "player")) then
			if (HateMe_UseSpellBasedOnBuff(HateMe_SPELL_BERSERKER_RAGE, bank)) then
				return true;
			end
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_BERSERKER_RAGE] = HateMe_CastSpell_BerserkerRage;

function HateMe_CastSpell_SweepingStrikes(bank)
	if (HateMe_UseSpellBasedOnBuff(HateMe_SPELL_SWEEPING_STRIKES, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SWEEPING_STRIKES] = HateMe_CastSpell_SweepingStrikes;

function HateMe_CastSpell_BattleShout(bank)
	if (HateMe_Settings["Optimize "..HateMe_SPELL_BATTLE_SHOUT.." Threat"]) then
		if (HateMe_Type == "HateYou") then
			if (checkPartyRange(2) > 4) then
				return false;
			elseif (HateMe_UseSpellBasedOnBuff(HateMe_SPELL_BATTLE_SHOUT, bank)) then
				return true;
			end
		else
			if (checkPartyRange(2) > 4) then
				if (HateMe_UseSpell(HateMe_SPELL_BATTLE_SHOUT, bank)) then
					return true;
				end
			else
				if (HateMe_UseSpellBasedOnBuff(HateMe_SPELL_BATTLE_SHOUT, bank)) then
					return true;
				end
			end
		end
	else
		if (HateMe_UseSpellBasedOnBuff(HateMe_SPELL_BATTLE_SHOUT, bank)) then
			return true;
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_BATTLE_SHOUT] = HateMe_CastSpell_BattleShout;

function HateMe_CastSpell_Bloodthirst(bank)
	local playerRage   = UnitMana("player");
	if (playerRage  >= (bank +  HateMe_GetBankAmount(HateMe_SPELL_BLOODTHIRST) ) ) then
		if (HateMe_UseSpellBasedOnBuff(HateMe_SPELL_BLOODTHIRST, bank)) then
			return true;
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_BLOODTHIRST] = HateMe_CastSpell_Bloodthirst;

function HateMe_CastSpell_ShieldSlam(bank)
	local playerRage   = UnitMana("player");
	if HateMe_CheckForShield() then
		if (playerRage  >= (bank +  HateMe_GetBankAmount(HateMe_SPELL_SHIELD_SLAM) ) ) then
			if (HateMe_UseSpell(HateMe_SPELL_SHIELD_SLAM, bank)) then
				return true;
			end
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SHIELD_SLAM] = HateMe_CastSpell_ShieldSlam;

function HateMe_CastSpell_Whirlwind(bank)
	if (HateMe_UseSpell(HateMe_SPELL_WHIRLWIND, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_WHIRLWIND] = HateMe_CastSpell_Whirlwind;

function HateMe_CastSpell_Slam(bank)
	if (HateMe_UseSpell(HateMe_SPELL_SLAM, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SLAM] = HateMe_CastSpell_Slam;

function HateMe_CastSpell_MortalStrike(bank)
-- People have asked to have it go off even if the mob has the debuff.
--	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_MORTAL_STRIKE, bank)) then
	if (HateMe_UseSpell(HateMe_SPELL_MORTAL_STRIKE, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_MORTAL_STRIKE] = HateMe_CastSpell_MortalStrike;

function HateMe_CastSpell_Pummel(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_PUMMEL, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_PUMMEL] = HateMe_CastSpell_Pummel;

function HateMe_CastSpell_ShieldBash(bank)
	if HateMe_CheckForShield() then
		if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_SHIELD_BASH, bank)) then
			return true;
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SHIELD_BASH] = HateMe_CastSpell_ShieldBash;

function HateMe_CastSpell_ConcussionBlow(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_CONCUSSION_BLOW, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_CONCUSSION_BLOW] = HateMe_CastSpell_ConcussionBlow;

function HateMe_CastSpell_Rend(bank)
	local mobHealth = UnitHealth("target") / UnitHealthMax("target");
	local playerHealth = UnitHealth("player") / UnitHealthMax("player");

	if ((mobHealth > 0.4) and (playerHealth > 0.5)) then
		if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_REND, bank)) then
			return true;
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_REND] = HateMe_CastSpell_Rend;

function HateMe_CastSpell_DemoralizingShout(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_DEMORALIZING_SHOUT, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_DEMORALIZING_SHOUT] = HateMe_CastSpell_DemoralizingShout;

function HateMe_CastSpell_ThunderClap(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_THUNDER_CLAP, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_THUNDER_CLAP] = HateMe_CastSpell_ThunderClap;

function HateMe_CastSpell_PiercingHowl(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_PIERCING_HOWL, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_PIERCING_HOWL] = HateMe_CastSpell_PiercingHowl;

function HateMe_CastSpell_Hamstring(bank)
	local tempImmune = false;
	
	if (HateMe_CheckForBuff(HateMe_SPELL_BLESSING_OF_FREEDOM, "target")) then
	    tempImmune = true;
	elseif (HateMe_CheckForBuff(HateMe_BUFF_FREE_ACTION, "target")) then
	    tempImmune = true;
	elseif (HateMe_CheckForBuff(HateMe_BUFF_IMMUNE_ROOT, "target")) then
	    tempImmune = true;
	end
	
	if (not tempImmune) then
		if (UnitPlayerControlled("target")) then
			if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_HAMSTRING, bank)) then
				return true;
			end
		else
			local mobHealth = UnitHealth("target") / UnitHealthMax("target");
			local mobName = UnitName("target")
			if (HateMe_Runners[mobName]) then
				if (mobHealth < 0.4) then
					if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_HAMSTRING, bank)) then
						return true;
					end
				end
			end
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_HAMSTRING] = HateMe_CastSpell_Hamstring;

function HateMe_CastSpell_Cleave(bank)
	if (HateMe_UseSpell(HateMe_SPELL_CLEAVE, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_CLEAVE] = HateMe_CastSpell_Cleave;

function HateMe_CastSpell_HeroicStrike(bank)
	local sunderCount;

	if ((HateMe_Type == "HateYou") or HateMe_Settings[HateMe_SPELL_HEROIC_STRIKE.." between "..HateMe_SPELL_SUNDER_ARMOR]) then
		if (HateMe_UseSpell(HateMe_SPELL_HEROIC_STRIKE, bank)) then
			return true;
		end
	else
		if HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"] then
			return false;
		else
 			_,sunderCount = HateMe_CheckForDebuff( HateMe_SPELL_SUNDER_ARMOR, "target")

			-- lets see if the sunders have been stacked to our max
			if (sunderCount < HateMe_SunderMaxCount) then
				-- we have not sundered enough times
				return false;
			else
				if (HateMe_UseSpell(HateMe_SPELL_HEROIC_STRIKE, bank)) then
					return true;
				end
			end
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_HEROIC_STRIKE] = HateMe_CastSpell_HeroicStrike;

function HateMe_CastSpell_OverPower(bank)
	-- ignore bank
	if (HateMe_UseSpellBasedOnSlot(HateMe_SPELL_OVERPOWER, 0)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_OVERPOWER] = HateMe_CastSpell_OverPower;

function HateMe_CastSpell_MockingBlow(bank)
	-- ignore bank
	if (HateMe_UseSpellBasedOnTargetTarget(HateMe_SPELL_MOCKING_BLOW, 0)) then
		return true;
	end
	return false;

end
HateMe_FunctionLinks[HateMe_SPELL_MOCKING_BLOW] = HateMe_CastSpell_MockingBlow;

function HateMe_CastSpell_Revenge(bank)
	-- ignore bank
	if (HateMe_UseSpellBasedOnSlot(HateMe_SPELL_REVENGE, 0)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_REVENGE] = HateMe_CastSpell_Revenge;

function HateMe_CastSpell_Taunt(bank)
	-- ignore bank
	if (HateMe_UseSpellBasedOnTargetTarget(HateMe_SPELL_TAUNT, 0)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_TAUNT] = HateMe_CastSpell_Taunt;

function HateMe_CastSpell_Growl(bank)
	--ignore bank
	if (HateMe_UseSpellBasedOnTargetTarget(HateMe_SPELL_GROWL, 0)) then
		return
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_GROWL] = HateMe_CastSpell_Growl;

function HateMe_CastSpell_FaerieFire(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_FAERIE_FIRE_BEAR, bank)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_FAERIE_FIRE_BEAR] = HateMe_CastSpell_FaerieFire;

function HateMe_CastSpell_DemoralizingRoar(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_DEMORALIZING_ROAR, bank)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_DEMORALIZING_ROAR] = HateMe_CastSpell_DemoralizingRoar;

function HateMe_CastSpell_Bash(bank)
	if (HateMe_UseSpell(HateMe_SPELL_BASH, bank)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_BASH] = HateMe_CastSpell_Bash;

function HateMe_CastSpell_Swipe(bank)
	local playerRage = UnitMana("player");
    if (playerRage  >= ((HateMe_GetBankAmount(HateMe_SPELL_MAUL) ) + 5) ) then
		if (HateMe_UseSpell(HateMe_SPELL_SWIPE, bank)) then
			return true;
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SWIPE] = HateMe_CastSpell_Swipe;

function HateMe_CastSpell_Maul(bank)
	if (HateMe_UseSpell(HateMe_SPELL_MAUL, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_MAUL] = HateMe_CastSpell_Maul;


function HateMe_CastSpell_SunderArmor(bank)
	local sunderCount;

	if HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"] then
		if (HateMe_UseSpell(HateMe_SPELL_SUNDER_ARMOR, bank)) then
			return true;
		end
	else
		_,sunderCount = HateMe_CheckForDebuff( HateMe_SPELL_SUNDER_ARMOR, "target")

		-- lets see if the sunders have been stacked to our max
		if (sunderCount < HateMe_SunderMaxCount) then
			-- we have not sundered enough times
			if (HateMe_UseSpell(HateMe_SPELL_SUNDER_ARMOR, bank)) then
				return true;
			end
		end
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SUNDER_ARMOR] = HateMe_CastSpell_SunderArmor;

function HateMe_CastSpell_TigerFury(bank)
	if (HateMe_UseSpellBasedOnBuff(HateMe_SPELL_TIGER_FURY, bank)) then
		return true;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_TIGER_FURY] = HateMe_CastSpell_TigerFury;

function HateMe_CastSpell_Rake(bank)
	if (HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_RAKE, bank)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_RAKE] = HateMe_CastSpell_Rake;

function HateMe_CastSpell_Shred(bank)
	if (HateMe_UseSpell(HateMe_SPELL_SHRED, bank)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_SHRED] = HateMe_CastSpell_Shred;

function HateMe_CastSpell_Claw(bank)
	if (HateMe_UseSpell(HateMe_SPELL_CLAW, bank)) then
		return;
	end
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_CLAW] = HateMe_CastSpell_Claw;

function HateMe_CastSpell_Cat(bank)
	if (HateMe_CurrentForm == "Default") then
		if (HateMe_UseSpell(HateMe_CAT, bank)) then
		    return;
		end
	else
	    if (HateMe_CurrentForm ~= HateMe_CAT) then
			HateMe_debug("Casting... "..HateMe_CurrentForm);

			if HateMe_Settings["Test Mode"] then
				HateMe_println("Casting... "..HateMe_CurrentForm);
			end

   			CastSpellByName(HateMe_CurrentForm);
		    return true;
	    end
	end
	return;
end
HateMe_FunctionLinks[HateMe_CAT] = HateMe_CastSpell_Cat;

function HateMe_CastSpell_Bear1(bank)
	if (HateMe_CurrentForm == "Default") then
		if (HateMe_UseSpell(HateMe_BEAR1, bank)) then
		    return;
		end
	else
	    if ((HateMe_CurrentForm == HateMe_BEAR1) or (HateMe_CurrentForm == HateMe_BEAR2)) then
	        return false;
		else
			HateMe_debug("Casting... "..HateMe_CurrentForm);

			if HateMe_Settings["Test Mode"] then
				HateMe_println("Casting... "..HateMe_CurrentForm);
			end

   			CastSpellByName(HateMe_CurrentForm);
		    return true;
	    end
	end
	return;
end
HateMe_FunctionLinks[HateMe_BEAR1] = HateMe_CastSpell_Bear1;

function HateMe_CastSpell_Bear2(bank)
	if (HateMe_CurrentForm == "Default") then
		if (HateMe_UseSpell(HateMe_BEAR2, bank)) then
		    return;
		end
	else
	    if ((HateMe_CurrentForm == HateMe_BEAR1) or (HateMe_CurrentForm == HateMe_BEAR2)) then
	        return false;
		else
			HateMe_debug("Casting... "..HateMe_CurrentForm);

			if HateMe_Settings["Test Mode"] then
				HateMe_println("Casting... "..HateMe_CurrentForm);
			end

   			CastSpellByName(HateMe_CurrentForm);
		    return true;
	    end
	end
	return;
end
HateMe_FunctionLinks[HateMe_BEAR2] = HateMe_CastSpell_Bear2;

function HateMe_CastSpell_Enrage(bank)
	HateMe_debug( "doing enrage");
	-- ignore bank

	local playerHealth = UnitHealth("player") / UnitHealthMax("player");
	local playerRage   = UnitMana("player");
	if ( (playerHealth > HateMe_Bloodrage_MinHealth) and (playerRage < HateMe_BloodRage_MinRage) ) then
		HateMe_debug("going to check to see if it can be cast");
		if (HateMe_UseSpell(HateMe_SPELL_ENRAGE, 0)) then
			return true;
		end
		HateMe_debug("it was not");
	end
	HateMe_debug("all done");
	return false;
end
HateMe_FunctionLinks[HateMe_SPELL_ENRAGE] = HateMe_CastSpell_Enrage;

function HateMe_CastSpell_Rip(bank)
    if ( GetComboPoints() == 5 ) then
    	if(HateMe_UseSpellBasedOnDebuff(HateMe_SPELL_RIP, bank)) then
    	    return true;
		end
    end
    return false;
end
HateMe_FunctionLinks[HateMe_SPELL_RIP] = HateMe_CastSpell_Rip;
