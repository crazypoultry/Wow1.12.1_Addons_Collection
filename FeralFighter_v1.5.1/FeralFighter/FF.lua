
BINDING_HEADER_FERALFIGHTER = "FeralFighter"

FeralFighter_Data_Default = {}
FeralFighter_Data_Default["opener"] = 		"auto"
FeralFighter_Data_Default["tf_opener"] = 	false
FeralFighter_Data_Default["always_cower"] = 	false
FeralFighter_Data_Default["agro_cower"] = 	true
FeralFighter_Data_Default["bufftime"] = 	60
FeralFighter_Data_Default["omen"] = 		true
FeralFighter_Data_Default["motw"] = 		true
FeralFighter_Data_Default["thorns"] = 		true
FeralFighter_Data_Default["thorns_me"] = 	true
FeralFighter_Data_Default["thorns_warrior"] = 	false
FeralFighter_Data_Default["thorns_paladin"] = 	false
FeralFighter_Data_Default["no_dot"] = 	        false
FeralFighter_Data_Default["ttkef"] = 	        6
FeralFighter_Data_Default["debug"] = 		false
FeralFighter_Data_Default["verbose"] = 		false

local FeralFighter_Version = "1.5.1";
local FeralFighter_BuffTarget = nil

function FeralFighter_println(Message)
	DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 1, 1);
end

local function println(s)
	FeralFighter_println(s)
end

local function print_verbose(s)
	if FeralFighter_Data["verbose"] then println(s) end
end

function ff_debug(Message)
	if (FeralFighter_Data["debug"]) then
		DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 1, 1);
	end
end

function FeralFighter_alert(Message)
	UIErrorsFrame:AddMessage(Message, 1.0, .5, .5, 1.0, UIERRORS_HOLD_TIME);
end

local function color_text(text, color)
	return color .. text .. "|cffffffff"
end

function FeralFighter_OnLoad()
	FeralFighter_DefaultSettings()

	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("VARIABLES_LOADED");

	SLASH_FERALFIGHTER1 = "/feralfighter";
	SLASH_FERALFIGHTER2 = "/feral";
	SLASH_FERALFIGHTER3 = "/ff";

	SlashCmdList["FERALFIGHTER"] = function(msg)
		FeralFighter_SlashCommandHandler(msg);
	end

	FeralFighter_println(format("FeralFighter (v%s) loaded", FeralFighter_Version));
end

function FeralFighter_OnEvent(event)
	if (event == "PLAYER_TARGET_CHANGED") then
		FeralFighter_ResetTimer()

	elseif (event == "PLAYER_REGEN_DISABLED") then
		FeralFighter_ResetTimer()

	elseif (event == "VARIABLES_LOADED") then
		FeralFighter_CheckNewSettings()

	else
		ff_debug(format("unexpected FF event: %s", event))
	end
end

function FeralFighter_DefaultSettings()
	FeralFighter_Data = {}
	FeralFighter_CheckNewSettings()
end

function FeralFighter_CheckNewSettings()
	local i = next(FeralFighter_Data_Default, nil)
	while (i) do
		if (FeralFighter_Data[i] == nil) then
			FeralFighter_Data[i] = FeralFighter_Data_Default[i]
		end
		i = next(FeralFighter_Data_Default, i)
	end
end

function FeralFighter_SlashCommandHandler( msg )
	if (string.lower(msg)=="catattack") then
		FeralFighter_CatAttack(false)

	elseif (string.lower(msg)=="attackbehind") then
		FeralFighter_CatAttack(true)

	elseif (string.lower(msg)=="rip") then
		FeralFighter_dechi()
	elseif (string.lower(msg)=="bite") then
		FeralFighter_morsu()
	elseif (string.lower(msg)=="nodot") then
		FeralFighter_nodot()
	elseif (string.lower(msg)=="dot") then
		FeralFighter_nodot()
	elseif (string.find(msg, "ttkef")) then
		FeralFighter_ttkef(msg)
	elseif (string.lower(msg)=="autobuff") then
		FeralFighter_Autobuff()

	elseif (string.lower(msg)=="listbuffs") then
		FeralFighter_ListTargetBuffs()

	elseif (string.lower(msg)=="help") then
		FeralFighter_println("--FeralFighter--")
		FeralFighter_println("/ff catattack - Claw");
		FeralFighter_println("/ff attackbehind - Shred");
		FeralFighter_println("/ff autobuff - Buff");

	elseif (string.lower(msg)=="rl") then
		ReloadUI();

	elseif(string.lower(msg)=="class") then
		FeralFighter_TargetClass()

	elseif(string.lower(msg)=="settings") then
		FeralFighter_ListSettingsDebug()

	elseif(string.lower(msg)=="default") then
		FeralFighter_println("Resetting defaults")
		FeralFighter_DefaultSettings()

	else
                FeralFighter:Show(); 
	end
end

function FeralFighter_ListSettingsDebug()
	local dex = next(FeralFighter_Data, nil)
	while (dex) do
		FeralFighter_println(format("%s: %s", dex, tostring(FeralFighter_Data[dex])))
		dex = next(FeralFighter_Data, dex)
	end
end	

function FeralFighter_Multikey()
	local form = FeralFighter_GetForm()

	if (form == CATFORM) then
		FeralFighter_Cower()
	elseif (form == BEARFORM) then
		CastSpellByName(ATTACK_BASH)
		CastSpellByName(ATTACK_CHARGE)
	else
		FeralFighter_SetForm()
		if not Dcr_Clean() and not UnitAffectingCombat("player") then FeralFighter_Autobuff() end
	end
end

function FeralFighter_SpellReady(seeking)
	for i = 1, 999 do
		local name = GetSpellName(i, BOOKTYPE_SPELL)

		if (not name) then break end

		if (string.find(name, seeking)) then
			return (GetSpellCooldown(i, 1) == 0)
		end
	end

	ff_debug("FeralFighter_SpellReady: spell not found")
	return false
end

function FeralFighter_HaveMana(min)
	if (UnitMana("player") >= min) then return true end
	if (FeralFighter_UnitHasBuff("player", "Spell_Shadow_ManaBurn", false)) then return true end
	return false
end

function FeralFighter_Pounce()
	if (FeralFighter_HaveMana(50)) then
		CastSpellByName(ATTACK_POUNCE)
	end
end

function FeralFighter_Ravage()
	if (FeralFighter_HaveMana(60)) then
		CastSpellByName(ATTACK_RAVAGE)
	end
end

function FeralFighter_Rip()
	if (FeralFighter_HaveMana(30)) then
		CastSpellByName(ATTACK_RIP)
	end
end

function FeralFighter_FerociousBite()
	if (FeralFighter_HaveMana(35)) then
		CastSpellByName(ATTACK_FB)
	end
end

function FeralFighter_Rake()
	local cost = 40 - FeralFighter_TalentRank(2, 1)
	if (FeralFighter_HaveMana(cost)) then
		CastSpellByName(ATTACK_RAKE)
	end
end

function FeralFighter_Claw()
	local cost = 45 - FeralFighter_TalentRank(2, 1)
	if (FeralFighter_HaveMana(cost)) then
		CastSpellByName(ATTACK_CLAW)
	end
end

function FeralFighter_Shred()
	local cost = 60 - 6 * FeralFighter_TalentRank(2, 9)
	if (FeralFighter_HaveMana(cost)) then
		CastSpellByName(ATTACK_SHRED)
	end
end

function FeralFighter_Cower()
	if FeralFighter_HaveMana(20) and FeralFighter_SpellReady(ATTACK_COWER) then
		CastSpellByName(ATTACK_COWER)
	end
end

function FeralFighter_TigersFury()
	if (FeralFighter_HaveMana(30)) then
		CastSpellByName(ATTACK_TF)
	end
end

function FeralFighter_CatAttack(behind)
--	if (UnitIsFriend("player", "target")) then return end

	local energy = UnitMana("player");
	local prowling = FeralFighter_UnitHasBuff("player", "Ability_Ambush", false)
	local unraked = not FeralFighter_TargetHasDebuff("Ability_Druid_Disembowel")
	local combo_points = GetComboPoints()
	local in_group = UnitExists("party1") or (GetNumRaidMembers() > 0)
	local pvp = UnitIsPlayer("target");

	local timeto_kill = FeralFighter_TimeToKill()
	local timeto_finisher = max(((5 - combo_points) * 40 - energy) / 10 / (1 + FeralFighter_TalentRank(2, 11) / 10), (5 - combo_points) * 2) + 1
	local will_not_finish = timeto_finisher > timeto_kill

	--println("ttk: " .. math.floor(timeto_kill+.5) .. " finish: " .. math.floor(timeto_finisher+.5) .. " combo: " .. combo_points)

	if (FeralFighter_Data["agro_cower"] and (not prowling) and (not pvp) and in_group and behind and UnitIsUnit("player", "targettarget")) then
		ClearTarget()
		TargetLastTarget()
		FeralFighter_Cower()

		return
	end

	if FeralFighter_Data["always_cower"] and (energy < 50) then
		FeralFighter_Cower()
		SpellStopCasting()
	end

	if ((will_not_finish and (timeto_kill > FeralFighter_Data["ttkef"]) and (not behind)) or (prowling and FeralFighter_Data["tf_opener"] and (energy == 100))) then
		if (not FeralFighter_UnitHasBuff("player", "Ability_Mount_JungleTiger", false)) then
			FeralFighter_TigersFury()
			SpellStopCasting()
		end
	end




	if (will_not_finish and (timeto_kill < FeralFighter_Data["ttkef"]) and (combo_points > 2)) then
		--println("early finisher")
		FeralFighter_FerociousBite()
		return
	end


	if prowling then
		if (FeralFighter_Data["opener"] == "auto") then
			if (in_group) then
				FeralFighter_Pounce()
			else
				FeralFighter_Ravage()
			end
			return

		elseif (FeralFighter_Data["opener"] == "pounce") then
			FeralFighter_Pounce()
			return

		elseif (FeralFighter_Data["opener"] == "ravage") then
			FeralFighter_Ravage()
			return
		end
	end

	if (combo_points == 5) then
		if (not pvp) and (timeto_kill > 15) and ( not FeralFighter_Data["no_dot"]) then
			FeralFighter_Rip()
		else
			FeralFighter_FerociousBite()
		end
		return
	end

	if (behind) then
		FeralFighter_Shred()
	else
		if (unraked and (timeto_kill > 8) and ( not FeralFighter_Data["no_dot"])) then
			FeralFighter_Rake()
		else
			FeralFighter_Claw()
		end
	end
end

function FeralFighter_nodot()
	FeralFighter_Data["no_dot"] = not FeralFighter_Data["no_dot"]
	if (FeralFighter_Data["no_dot"]) then
	        FeralFighter_println("FF - Dot disabled")
	else
		FeralFighter_println("FF - Dot enabled")
	end
end

function FeralFighter_ttkef(msg)
	local value = strsub(msg,6,8) 
	if (string.len(value)==0) then
		println("FF - Current value for Early Finisher ttk " .. FeralFighter_Data["ttkef"]);
	else
		value = tonumber(value)
		if ((value > 0) and (value < 11)) then
			println("FF -- early finisher old value : " .. FeralFighter_Data["ttkef"] .." new value : " .. value) 
			FeralFighter_Data["ttkef"] = value
		else
			println("FF - Value for Early Finisher should be in range 1 - 10");
		end
	end
end

-- Ma fonction pour dechirure après serie de shred

function FeralFighter_dechi()
--	if (UnitIsFriend("player", "target")) then return end

	local energy = UnitMana("player");
	local prowling = FeralFighter_UnitHasBuff("player", "Ability_Ambush", false)
	local unraked = not FeralFighter_TargetHasDebuff("Ability_Druid_Disembowel")
	local combo_points = GetComboPoints()
	local in_group = UnitExists("party1") or (GetNumRaidMembers() > 0)
	local pvp = UnitIsPlayer("target");

	local timeto_kill = FeralFighter_TimeToKill()
	local timeto_finisher = max(((5 - combo_points) * 40 - energy) / 10 / (1 + FeralFighter_TalentRank(2, 11) / 10), (5 - combo_points) * 2) + 1
	local will_not_finish = timeto_finisher > timeto_kill

	--println("ttk: " .. math.floor(timeto_kill+.5) .. " finish: " .. math.floor(timeto_finisher+.5) .. " combo: " .. combo_points)

	if (FeralFighter_Data["agro_cower"] and (not prowling) and (not pvp) and in_group and behind and UnitIsUnit("player", "targettarget")) then
		ClearTarget()
		TargetLastTarget()
		FeralFighter_Cower()

		return
	end

	if FeralFighter_Data["always_cower"] and (energy < 50) then
		FeralFighter_Cower()
		SpellStopCasting()
	end

	if ((will_not_finish and (timeto_kill > FeralFighter_Data["ttkef"]) and (not behind)) or (prowling and FeralFighter_Data["tf_opener"] and (energy == 100))) then
		if (not FeralFighter_UnitHasBuff("player", "Ability_Mount_JungleTiger", false)) then
			FeralFighter_TigersFury()
			SpellStopCasting()
		end
	end

	if (will_not_finish and (timeto_kill < FeralFighter_Data["ttkef"]) and (combo_points > 2)) then
		--println("early finisher")
		FeralFighter_FerociousBite()
		return
	end


	if (combo_points == 5) then
		FeralFighter_Rip()
		return
	end

	FeralFighter_Shred()

end

-- idem pour morsure feroce

function FeralFighter_morsu()
--	if (UnitIsFriend("player", "target")) then return end

	local energy = UnitMana("player");
	local prowling = FeralFighter_UnitHasBuff("player", "Ability_Ambush", false)
	local unraked = not FeralFighter_TargetHasDebuff("Ability_Druid_Disembowel")
	local combo_points = GetComboPoints()
	local in_group = UnitExists("party1") or (GetNumRaidMembers() > 0)
	local pvp = UnitIsPlayer("target");

	local timeto_kill = FeralFighter_TimeToKill()
	local timeto_finisher = max(((5 - combo_points) * 40 - energy) / 10 / (1 + FeralFighter_TalentRank(2, 11) / 10), (5 - combo_points) * 2) + 1
	local will_not_finish = timeto_finisher > timeto_kill

	--println("ttk: " .. math.floor(timeto_kill+.5) .. " finish: " .. math.floor(timeto_finisher+.5) .. " combo: " .. combo_points)

	if (FeralFighter_Data["agro_cower"] and (not prowling) and (not pvp) and in_group and behind and UnitIsUnit("player", "targettarget")) then
		ClearTarget()
		TargetLastTarget()
		FeralFighter_Cower()

		return
	end

	if FeralFighter_Data["always_cower"] and (energy < 50) then
		FeralFighter_Cower()
		SpellStopCasting()
	end

	if ((will_not_finish and (timeto_kill > FeralFighter_Data["ttkef"]) and (not behind)) or (prowling and FeralFighter_Data["tf_opener"] and (energy == 100))) then
		if (not FeralFighter_UnitHasBuff("player", "Ability_Mount_JungleTiger", false)) then
			FeralFighter_TigersFury()
			SpellStopCasting()
		end
	end

	if (will_not_finish and (timeto_kill < FeralFighter_Data["ttkef"]) and (combo_points > 2)) then
		--println("early finisher")
		FeralFighter_FerociousBite()
		return
	end


	if (combo_points == 5) then
		FeralFighter_FerociousBite()
		return
	end

	FeralFighter_Shred()

end

function FeralFighter_ListTargetBuffs()
	FeralFighter_println("Target buffs/debuffs:");
	for i = 1, 16 do
		buff = UnitBuff("target", i);
		if (buff) then
			FeralFighter_println(format("Target buffed with '%s'", buff));
		end
	end
	for i = 1, 16 do
		debuff = UnitDebuff("target", i);
		if (debuff) then
			FeralFighter_println(format("Target debuffed with '%s'", debuff));
		end
	end
end


local FeralFighter_start_health = 100
local FeralFighter_start_time = 0

function FeralFighter_ResetTimer()
	FeralFighter_start_health = UnitHealth("target")
	FeralFighter_start_time = GetTime()
end

function FeralFighter_TimeToKill()
	local remaining_health = UnitHealth("target")
	local elapsed_health = FeralFighter_start_health - remaining_health
	local elapsed_time = GetTime() - FeralFighter_start_time
	local dps, time_to_kill
	if (elapsed_time < 3) then
		return 600
	else
		dps = elapsed_health / elapsed_time
	end
	if (dps == 0) then
		return 600
	else
		time_to_kill = remaining_health / dps
	end

	return time_to_kill
end

function UseContainerItemByName(search_string)
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local s = GetContainerItemLink(bag, slot)
			if s and string.find(s, search_string) then
				UseContainerItem(bag,slot)
			end
		end
	end
end

function FeralFighter_SetForm(form)
	for i = 0, 16 do
		current = GetPlayerBuffTexture(i)
		if (current == nil) then break end
		if string.find(current, "CatForm") or
		   string.find(current, "BearForm") or
		   string.find(current, "TravelForm") or
		   string.find(current, "AquaticForm") or
		   string.find(current, "Ability_Mount") then
			if form and (string.find(current, "CatForm") or string.find(current, "BearForm")) then
				if ((form == CATFORM) and not FeralFighter_UnitHasBuff("player", "Ability_Ambush", false)) then
					println(current)
					CastSpellByName(SKILL_PROWL)
				elseif (form == BEARFORM) then
					CastSpellByName(SKILL_ENRAGE)
				end
			else
				CancelPlayerBuff(i)
			end
			return
		end
	end

	if (form) then
		if ( GetLocale() == "frFR" ) then
			if (form == BEARFORM) then form = BEAR2 end
			CastSpellByName("Forme " .. form)
		else
			if (form == BEARFORM) then form = BEAR2 end
				CastSpellByName(form .. " Form")
		end
	end
end

function FeralFighter_GetForm()
	for i = 1, 16 do
		current = GetPlayerBuffTexture(i)
		if (current == nil) then break end

		if (string.find(current, "CatForm")) then
			return CATFORM
		elseif (string.find(current, "BearForm")) then
			return BEARFORM
		elseif (string.find(current, "TravelForm")) then
			return TRAVELFORM
		elseif (string.find(current, "AquaticForm")) then
			return AQUATICFORM
		end
	end
	return "caster"
end

function FeralFighter_BuffTimeLeft(buff)
	local i = 0
	
	while (GetPlayerBuffTexture(i)) do
		current = GetPlayerBuffTexture(i)
		if (string.find(current, buff)) then
			--ff_debug(format("%i seconds left on %s", time, buff))
			return GetPlayerBuffTimeLeft(i)
		end
		i = i + 1
	end
	return 0
end

function FeralFighter_UnitHasBuff(unit, buff, ignore_short)
	for i = 1, 16 do
		current = UnitBuff(unit, i)
		if (current == nil) then return false end

		if (string.find(current, buff)) then
			if (ignore_short) then
				if (FeralFighter_BuffTimeLeft(buff) <= FeralFighter_Data["bufftime"]) then return false end
			end
			return true
		end
	end
	return false
end

function FeralFighter_TargetHasDebuff(debuff)
	for i = 1, 16 do
		current = UnitDebuff("target", i)
		if (current == nil) then return false end
		if (string.find(current, debuff)) then return true end
	end

	return false
end

local already_tried

function FeralFighter_CheckBuff(unit, buff_texture, buff, color, ranks)
	if (not FeralFighter_UnitHasBuff(unit, buff_texture, (unit == "player"))) then
		local name = UnitName(unit)
		if already_tried[name] then return end
		already_tried[name] = true

		if ranks then
			local rank
			for i = 1, table.getn(ranks) do
				if UnitLevel(unit) >= ranks[i] - 10 then rank = i end
			end
			buff = buff .. "(" .. W_RANK .. " " .. rank .. ")"
		end

		print_verbose("Casting buff " .. color_text(buff, color) .. " on " .. name .. " (" .. unit .. ")")

		if UnitCanCooperate("player", "target") and not (unit == "target") then
			ClearTarget()
			CastSpellByName(buff)
			SpellTargetUnit(unit)
			SpellStopTargeting()
			TargetLastTarget()
		else
			CastSpellByName(buff)
			SpellTargetUnit(unit)
			SpellStopTargeting()
		end
		return true
	end

	return false
end

function FeralFighter_CheckStandardBuffs(dex, unit)
	--println("checking " .. unit);

	if (not UnitIsVisible(unit))				then return end
	if (not UnitIsFriend("player", unit)) 			then return end
	if (UnitCreatureType(unit) == "Demon") 			then return end
        if (UnitIsDeadOrGhost(unit))				then return end

	if (FeralFighter_Data["motw"]) then
		if FeralFighter_CheckBuff(unit, "Spell_Nature_Regeneration", BUFF_MOTW, "|cffff44ff", {1, 10, 20, 30, 40, 50, 60}) then
			return
		end
	end

	if (FeralFighter_Data["thorns"]) then
		unit_class = tostring(UnitClass(unit))
		if (unit == "player" and FeralFighter_Data["thorns_me"]) or
		   (unit_class == WARRIOR and FeralFighter_Data["thorns_warrior"]) or
		   (unit_class == PALADIN and FeralFighter_Data["thorns_paladin"]) then
			FeralFighter_CheckBuff(unit, "Spell_Nature_Thorns", BUFF_THORNS, "|cffdd8844", {6, 14, 24, 34, 44, 54})
		end
	end
end

local function pour_table(from_table, to_table)
	while (table.getn(from_table) > 0) do
		table.insert(to_table, table.remove(from_table, math.random(table.getn(from_table))))
	end
end

local last_cast_time = 0

function FeralFighter_Autobuff()
	if GetTime() - last_cast_time < 1.1 then return end
	last_cast_time = GetTime()

	local potential_target_list = {}
	local target_list = {"player", "target"}

	for i = 1, 4 do
		table.insert(potential_target_list, "party" .. i)
		table.insert(potential_target_list, "partypet" .. i)
	end
	pour_table(potential_target_list, target_list)

	if UnitInRaid("player") then
		for i = 0, 40 do
			table.insert(potential_target_list, "raid" .. i)
			table.insert(potential_target_list, "raidpet" .. i)
		end
		pour_table(potential_target_list, target_list)
	end

	already_tried = {}

	if ((FeralFighter_TalentRank(1, 9) == 1) and FeralFighter_Data["omen"]) then
		if FeralFighter_CheckBuff("player", "Spell_Nature_CrystalBall", BUFF_OMEN, "|cff00ffff") then return end
	end

	foreach(target_list, FeralFighter_CheckStandardBuffs)

	SpellStopTargeting()
end

function FeralFighter_TalentRank(tab, talent)
	local a, b, c, d, rank = GetTalentInfo(tab, talent)
	return rank
end		
