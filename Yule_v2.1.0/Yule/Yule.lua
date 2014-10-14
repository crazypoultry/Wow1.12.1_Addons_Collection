-- Global variables
Yule = {};
Yule.version = "2.1.0";
Yule.tab = 1;
Yule.color = { };
Yule.color["physical"]={r = 1.00, g = 1.00, b = 1.00};
Yule.color["holy"]   = {r = 1.00, g = 1.00, b = 0.00};
Yule.color["arcane"] = {r = 0.70, g = 0.70, b = 0.75};
Yule.color["fire"]   = {r = 0.85, g = 0.00, b = 0.00};
Yule.color["nature"] = {r = 0.00, g = 0.70, b = 0.00};
Yule.color["frost"]  = {r = 0.25, g = 0.25, b = 1.00};
Yule.color["shadow"] = {r = 0.80, g = 0.40, b = 0.90};
Yule.color["health"] = {r = 0.00, g = 1.00, b = 0.00};
Yule.color["mana"]   = {r = 0.60, g = 0.60, b = 1.00};
Yule.color["rage"]   = {r = 1.00, g = 0.20, b = 0.20};
Yule.color["energy"] = {r = 1.00, g = 1.00, b = 0.00};
Yule.color["FRIEND"] = {r = 0.20, g = 1.00, b = 0.20};
Yule.color["ENEMY"]  = {r = 1.00, g = 0.20, b = 0.20};
Yule.color["NEUTRAL"]= {r = 0.75, g = 0.75, b = 0.75};
Yule.color["linenormal"] = {r = 1, g = 1, b = 1};
Yule.color["linemiss"] = {r = 0.7, g = 0.7, b = 0.7};
Yule.color["linecrit"] = {r = 1, g = 1, b = 0};
Yule.color["linebuff"] = {r = 0.6, g = 0.6, b = 1};
Yule.color["linedebuff"] = {r = 1, g = 0.6, b = 0.6};

YuleOptions = { };

YuleOptions[1]  = {s = "playermelee", t = "melee attacks"};
YuleOptions[2]  = {s = "playercasts", t = "spell casts"};
YuleOptions[3]  = {s = "playerspells", t = "damage spells"};
YuleOptions[4]  = {s = "playerheals", t = "heals recieved"};
YuleOptions[5]  = {s = "playerhealsvother", t = "heals on others"};
YuleOptions[6]  = {s = "playerpower", t = "power gains"};
YuleOptions[7]  = {s = "playerbuffs", t = "buffs"};
YuleOptions[8]  = {s = "playerdebuffs", t = "debuffs"};
YuleOptions[9]  = {s = "playerperdmg", t = "periodic damage"};
YuleOptions[10]  = {s = "playerenvdmg", t = "env. damage"};
YuleOptions[11] = {s = "playerfade", t = "fading effects"};

YuleOptions[12] = {s = "petmelee", t = "melee attacks"};
YuleOptions[13] = {s = "petcasts", t = "spell casts"};
YuleOptions[14] = {s = "petspells", t = "damage spells"};
YuleOptions[15] = {s = "petheals", t = "heals recieved"};
YuleOptions[16] = {s = "petbuffs", t = "buffs"};
YuleOptions[17] = {s = "petdebuffs", t = "debuffs"};
YuleOptions[18] = {s = "petperdmg", t = "periodic damage"};
YuleOptions[19] = {s = "petenvdmg", t = "env. damage"};
YuleOptions[20] = {s = "petfade", t = "fading effects"};

YuleOptions[21] = {s = "partymelee", t = "melee attacks"};
YuleOptions[22] = {s = "partycasts", t = "spell casts"};
YuleOptions[23] = {s = "partyspells", t = "damage spells"};
YuleOptions[24] = {s = "partyheals", t = "heals recieved"};
YuleOptions[25] = {s = "partypower", t = "power gains"};
YuleOptions[26] = {s = "partybuffs", t = "buffs"};
YuleOptions[27] = {s = "partydebuffs", t = "debuffs"};
YuleOptions[28] = {s = "partyperdmg", t = "periodic damage"};
YuleOptions[29] = {s = "partyenvdmg", t = "env. damage"};

YuleOptions[30] = {s = "fplayermelee", t = "melee attacks"};
YuleOptions[31] = {s = "fplayercasts", t = "spell casts"};
YuleOptions[32] = {s = "fplayerspells", t = "damage spells"};
YuleOptions[33] = {s = "fplayerheals", t = "heals recieved"};
YuleOptions[34] = {s = "fplayerpower", t = "power gains"};
YuleOptions[35] = {s = "fplayerbuffs", t = "buffs"};
YuleOptions[36] = {s = "fplayerdebuffs", t = "debuffs"};
YuleOptions[37] = {s = "fplayerperdmg", t = "periodic damage"};
YuleOptions[38] = {s = "fplayerenvdmg", t = "env. damage"};

YuleOptions[39] = {s = "hplayermeleevyou", t = "melee attacks on you"};
YuleOptions[40] = {s = "hplayermeleevother", t = "melee attacks on others"};
YuleOptions[41] = {s = "hplayercasts", t = "spell casts"};
YuleOptions[42] = {s = "hplayerspellsvyou", t = "damage spells on you"};
YuleOptions[43] = {s = "hplayerspellsvother", t = "damage spells on others"};
YuleOptions[44] = {s = "hplayerheals", t = "heals recieved"};
YuleOptions[45] = {s = "hplayerpower", t = "power gains"};
YuleOptions[46] = {s = "hplayerbuffs", t = "buffs"};
YuleOptions[47] = {s = "hplayerdebuffs", t = "debuffs"};
YuleOptions[48] = {s = "hplayerperdmgyou", t = "periodic damage from you"};
YuleOptions[49] = {s = "hplayerperdmgother", t = "periodic damage from others"};
YuleOptions[50] = {s = "hplayerenvdmg", t = "env. damage"};

YuleOptions[51] = {s = "mobmeleevyou", t = "melee attacks on you"};
YuleOptions[52] = {s = "mobmeleevother", t = "melee attacks on others"};
YuleOptions[53] = {s = "mobcasts", t = "spell casts"};
YuleOptions[54] = {s = "mobspellsvyou", t = "damage spells on you"};
YuleOptions[55] = {s = "mobspellsvother", t = "damage spells on others"};
YuleOptions[56] = {s = "mobheals", t = "heals recieved"};
YuleOptions[57] = {s = "mobbuffs", t = "buffs"};
YuleOptions[58] = {s = "mobdebuffs", t = "debuffs"};
YuleOptions[59] = {s = "mobperdmgyou", t = "periodic damage from you"};
YuleOptions[60] = {s = "mobperdmgother", t = "periodic damage from others"};

YuleOptions[61] = {s = "custom1source", t = "Events with unit as source"};
YuleOptions[62] = {s = "custom1target", t = "Events with unit as target"};
YuleOptions[63] = {s = "custom1ability", t = "Events with this ability"};

YuleOptions[64] = {s = "custom2source", t = "Events with unit as source"};
YuleOptions[65] = {s = "custom2target", t = "Events with unit as target"};
YuleOptions[66] = {s = "custom2ability", t = "Events with this ability"};

YuleGenericOptions = { };

YuleGenericOptions[1] = {s = "cflags", t = "Combat Flags"};
YuleGenericOptions[2] = {s = "debug", t = "Debug Messages"};
YuleGenericOptions[3] = {s = "timestamp", t = "Time Stamps"};
YuleGenericOptions[4] = {s = "hourstamp", t = "Hours"};
YuleGenericOptions[5] = {s = "minutestamp", t = "Minutes"};
YuleGenericOptions[6] = {s = "secondstamp", t = "Seconds"};
YuleGenericOptions[7] = {s = "millisecondstamp", t = "Milliseconds"};

-- YuleOptions[] = {s = "", t = ""};

function Yule:UpdateTabs()

	if not YuleConfig then return; end
	if not YuleConfig.frames[1].chatframe then YuleConfig.frames[1].chatframe = 1; end

	for i = 1, 6 do
		getglobal("YuleMenuFrameTab"..i):SetChecked(i == Yule.tab);
		getglobal("YuleMenuFrameMiscFrameEB"..i):SetText(YuleConfig.frames[i].chatframe or "");
		if YuleConfig and YuleConfig.frames[i].chatframe then
			getglobal("YuleMenuFrameTab"..i):Show();
		else
			getglobal("YuleMenuFrameTab"..i):Hide();
		end
	end

	for i = 1, 62 do
		getglobal("YuleMenuOption"..i):SetChecked(YuleConfig.frames[Yule.tab][YuleOptions[i].s]);
	end
	
	YuleMenuFrameCustom1:SetText(YuleConfig.custom1 or "Custom 1");
	YuleMenuFrameCustom1FrameUnitNameBox:SetText(YuleConfig.custom1 or "");
	
	YuleMenuFrameCustom2:SetText(YuleConfig.custom2 or "Custom 2");
	YuleMenuFrameCustom2FrameUnitNameBox:SetText(YuleConfig.custom2 or "");

end

function Yule:Print(msg)

	if ( not msg ) then
		msg = "nil";
	end

	DEFAULT_CHAT_FRAME:AddMessage("Yule: "..msg);

end

function Yule:Log(msg, setting)

	if ( not msg ) then
		msg = "nil";
	end
	
	local stamp = "";

	if YuleConfig and YuleConfig.timestamp then

		if YuleConfig.hourstamp then
			stamp = strsub(date(), 10, 11);
			if YuleConfig.minutestamp or YuleConfig.secondstamp then
				stamp = stamp..":";
			end
		end

		if YuleConfig.minutestamp then
			stamp = stamp..strsub(date(), 13, 14);
			if YuleConfig.secondstamp then
				stamp = stamp..":";
			end
		else
			if YuleConfig.hourstamp and YuleConfig.secondstamp then
				stamp = stamp.."00:";
			end
		end

		if YuleConfig.secondstamp then
			stamp = stamp..strsub(date(), 16, 17);
		end

		if YuleConfig.millisecondstamp then
			stamp = stamp.."."..string.format("%03d", floor(mod(GetTime()*1000, 1000)));
		end

		stamp = "["..stamp.."] ";

	end
	
	msg = stamp..msg;

	if setting then
		for i = 1, 6 do
			if YuleConfig.frames[i][setting] and YuleConfig.frames[i].chatframe and getglobal("ChatFrame"..YuleConfig.frames[i].chatframe) then
				getglobal("ChatFrame"..YuleConfig.frames[i].chatframe):AddMessage(msg);
			end
		end
	elseif YuleConfig and YuleConfig.frames[1].chatframe then
		(getglobal("ChatFrame"..YuleConfig.frames[1].chatframe) or ChatFrame1):AddMessage(msg);
	else
		ChatFrame2:AddMessage(msg);
	end

end

function Yule:Report()

	if ( YuleConfig.debug ) then
		Yule:Print("|cff00CCCC"..event.." - "..arg1.."|r");
	end

end

-- Return a color string with the given colors
function Yule:FormatHexColor(color)

	if color and color.r and color.g and color.b then
		return string.format("%02x%02x%02x", (color.r*255), (color.g*255), (color.b*255));
	else
		return "ffffff";
	end

end

function Yule:FormatDamage(damage, type, prefix)
	return "|cff"..Yule:FormatHexColor(Yule.color[strlower(type)])..(prefix or "")..damage.." "..type.."|r";
end

function Yule:FormatUnit(name, type)
	if Yule.color then
		return "[|cff"..Yule:FormatHexColor(Yule.color[type])..(name or "").."|r]";
	else
		return "["..(name or "").."]";
	end
end

function Yule:LogAttack(setting, source, source_reaction, target, target_reaction, ability, value, type, crit, miss, glancing, crushing, blocked, absorbed, resisted)

	local s = "";
	
	if source and source_reaction then s = s..Yule:FormatUnit(source, source_reaction).." "; end

	if ability then if crit then
		if ability == "crit" then s = s.."|cff"..Yule:FormatHexColor(Yule.color.linecrit).."crit|r ";
		else s = s.."|cff"..Yule:FormatHexColor(Yule.color.linecrit)..ability.." crit|r "; end
	elseif miss then s = s.."|cff"..Yule:FormatHexColor(Yule.color.linemiss)..ability.."|r ";
	else s = s.."|cff"..Yule:FormatHexColor(Yule.color.linenormal)..ability.."|r "; end end

	if target and target_reaction then s = s..Yule:FormatUnit(target, target_reaction); end

	if value then
		if type then s = s.." "..Yule:FormatDamage(value, type);
		else s = s.." "..value; end
	end

	if glancing then s = s.." (glancing)"; end
	if crushing then s = s.." (crushing)"; end
	if blocked  then s = s.." ("..blocked.." blocked)"; end
	if absorbed then s = s.." ("..absorbed.." absorbed)"; end
	if resisted then s = s.." ("..resisted.." resisted)"; end

	if YuleConfig.custom1 then
		if source and (source == YuleConfig.custom1) then Yule:Log(s, "custom1source"); end
		if target and (target == YuleConfig.custom1) then Yule:Log(s, "custom1target"); end
		if ability and (ability == YuleConfig.custom1) then Yule:Log(s, "custom1ability"); end
	end

	if YuleConfig.custom2 then
		if source and (source == YuleConfig.custom2) then Yule:Log(s, "custom2source"); end
		if target and (target == YuleConfig.custom2) then Yule:Log(s, "custom2target"); end
		if ability and (ability == YuleConfig.custom2) then Yule:Log(s, "custom2ability"); end
	end

	Yule:Log(s, setting);

end

function Yule.Command(cmd)

	YuleMenuFrame:Show();

end

function Yule:Parse(msg, type)

	local i, t, s, a1, a2, a3, a4, a5, a6;

	for i = 1, getn(Yule.combat[type]) do
		s, _, a1, a2, a3, a4, a5, a6 = string.find(msg, Yule.combat[type][i].r);
		if s then return Yule.combat[type][i].f(a1, a2, a3, a4, a5, a6); end
	end

end

function Yule:ParseTrailers(msg, setting, source, source_reaction, target, target_reaction, ability, damage, damage_type, crit, miss)

	local glancing = string.find(msg, "%(glancing%)");
	local crushing = string.find(msg, "%(crushing%)");
	local _, _, blocked = string.find(msg, "%((%d+) blocked%)");
	local _, _, absorbed = string.find(msg, "%((%d+) absorbed%)");
	local _, _, resisted = string.find(msg, "%((%d+) resisted%)");

	Yule:LogAttack(setting, source, source_reaction, target, target_reaction, ability, damage, damage_type, crit, miss, glancing, crushing, blocked, absorbed, resisted);

end

function Yule:ParseMeleeHit(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, type, crit = Yule:Parse(msg, "melee_hit");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:ParseTrailers(msg, setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, type, crit);
	return true;

end

function Yule:ParseMeleeMiss(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, type = Yule:Parse(msg, "melee_miss");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:LogAttack(setting, (source_match or source), source_reaction, (target_match or target), target_reaction, "hit", type, nil, nil, 1);
	return true;

end

function Yule:ParseEnvDamage(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, type = Yule:Parse(msg, "environmental_damage");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:LogAttack(setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, type);
	return true;

end

function Yule:ParseCast(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage = Yule:Parse(msg, "cast");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:LogAttack(setting,(source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage);
	return true;

end

function Yule:ParseMeleeSpell(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, crit, miss = Yule:Parse(msg, "melee_spell");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:ParseTrailers(msg, setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, nil, crit, miss);
	return true;

end

function Yule:ParseMagicSpell(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, type, crit, miss = Yule:Parse(msg, "magic_spell");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:ParseTrailers(msg, setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, type, crit, miss);
	return true;

end

function Yule:ParsePerDamage(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, type = Yule:Parse(msg, "periodic_damage");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:ParseTrailers(msg, setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, type);
	return true;

end

function Yule:ParseShield(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, type, resist = Yule:Parse(msg, "damage_shield");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:LogAttack(setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, type, nil, resist);
	return true;

end

function Yule:ParseHeal(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, type, crit = Yule:Parse(msg, "heal");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:LogAttack(setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, type, crit);
	return true;

end

function Yule:ParsePower(msg, setting, source_reaction, target_reaction, source_match, target_match)

	local source, target, ability, damage, type = Yule:Parse(msg, "power");

	if not source then return false; end
	if source_match and strlower(source) ~= strlower(source_match) then return false; end
	if target_match and strlower(target) ~= strlower(target_match) then return false; end

	Yule:LogAttack(setting, (source_match or source), source_reaction, (target_match or target), target_reaction, ability, damage, type);
	return true;

end

function Yule:ParseBuff(msg, setting, unit_reaction, unit_match)

	local _, _, unit, s, aura = string.find(msg, "(.+) gain(s-) (.+)%.");

	if not unit then return false; end
	if unit_match and strlower(unit) ~= strlower(unit_match) then return false; end

	Yule:Log(Yule:FormatUnit(unit_match or unit, unit_reaction).." gain"..s.." |cff"..Yule:FormatHexColor(Yule.color["linebuff"])..aura.."|r", setting);
	return true;

end

function Yule:ParseDebuff(msg, setting, unit_reaction, unit_match)

	local _, _, unit, s, aura = string.find(msg, "(.+) (.+) afflicted by (.+)%.");

	if not unit then return false; end
	if unit_match and strlower(unit) ~= strlower(unit_match) then return false; end

	Yule:Log(Yule:FormatUnit(unit_match or unit, unit_reaction).." "..s.." afflicted by |cff"..Yule:FormatHexColor(Yule.color["linedebuff"])..aura.."|r", setting);
	return true;

end

function Yule:ParseFade(msg, setting, unit_reaction, unit_match)

	local _, _, aura, unit = string.find(msg, "(.+) fades from (.+)%.");

	if not unit then return false; end
	if unit_match and strlower(unit) ~= strlower(unit_match) then return false; end

	Yule:Log(Yule:FormatUnit(unit_match or unit, unit_reaction).." "..aura.." fades", setting);
	return true;

end




function Yule:OnLoad()

	-- Register slash commands
	SlashCmdList["YULE"] = Yule.Command
	SLASH_YULE1 = "/yule";

	-- Register events
	this:RegisterEvent("VARIABLES_LOADED");

	-- Register Main Events
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
--	this:RegisterEvent("PLAYER_COMBO_POINTS");

--	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS");
--	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
--	this:RegisterEvent("CHAT_MSG_COMBAT_ERROR");
--	this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES");
--	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
--	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
--	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
--	this:RegisterEvent("CHAT_MSG_COMBAT_MISC_INFO");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
--	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
--	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
--	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
--	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS");
	this:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF");
--	this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
--	this:RegisterEvent("CHAT_MSG_SPELL_ITEM_ENCHANTMENTS");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");

	Yule:Log("Yule v"..Yule.version.." loaded.");

end

function Yule:OnEvent(event, msg)

	if ( Yule.eventHandler[event] ) then
		Yule.eventHandler[event]();
	elseif ( Yule.combat[event] ) then

		if not Yule.combat[event](msg) and YuleConfig.debug then
			Yule:Print("|cffffff00"..event.."|r: "..(msg or "nil"));
		end

	else
		if YuleConfig.debug then Yule:Print("|cffff0000"..event.."|r: "..(msg or "nil")); end
	end

end

Yule.eventHandler = {};

Yule.eventHandler["VARIABLES_LOADED"] = function ()

	if ( not YuleConfig ) then
		YuleConfig = { };
	end
	
	if ( not YuleConfig.frames ) then
		YuleConfig.frames = { };

		YuleConfig.frames[1] = { };
		YuleConfig.frames[2] = { };
		YuleConfig.frames[3] = { };
		YuleConfig.frames[4] = { };
		YuleConfig.frames[5] = { };
		YuleConfig.frames[6] = { };

		YuleConfig.frames[1].chatframe = 2;
	end

end

Yule.eventHandler["PLAYER_REGEN_DISABLED"] =  function ()
	Yule:Log("+Combat", "cflags");
end

Yule.eventHandler["PLAYER_REGEN_ENABLED"] = function ()
	Yule:Log("-Combat", "cflags");
end

Yule.combat = { };

Yule.combat["melee_hit"] = {
	[1] = {r = "(.+) hits- (.+) for (%d+)%.", f = function (source, target, dmg) return source, target, "hit", dmg; end},
	[2] = {r = "(.+) crits- (.+) for (%d+)%.", f = function (source, target, dmg) return source, target, "crit", dmg, nil, 1; end},
	[3] = {r = "(.+) hits- (.+) for (%d+) (.+) damage%.", f = function (source, target, dmg, type) return source, target, "hit", dmg, type; end},
	[4] = {r = "(.+) crits- (.+) for (%d+) (.+) damage%.", f = function (source, target, dmg, type) return source, target, "crit", dmg, type, 1; end},
};

Yule.combat["melee_miss"] = {
	[1] = {r = "(.+) misse-s- (.+)%.", f = function (source, target) return source, target, "(miss)"; end},
	[2] = {r = "(.+) attacks-%. (.+) dodges-%.", f = function (source, target) return source, target, "(dodge)"; end},
	[3] = {r = "(.+) attacks-%. (.+) parr[yi]e-s-%.", f = function (source, target) return source, target, "(parry)"; end},
	[4] = {r = "(.+) attacks-%. (.+) blocks-%.", f = function (source, target) return source, target, "(block)"; end},
	[5] = {r = "(.+) attacks-%. (.+) absorbs- all the damage%.", f = function (source, target) return source, target, "(absorb)"; end},
	[6] = {r = "(.+) attacks- but (.+) [ia][sr]e- immune%.", f = function (source, target) return source, target, "(immune)"; end},
	[7] = {r = "(.+) attacks-%. (.+) evades%.", f = function (source, target) return source, target, "(evade)"; end},
};

Yule.combat["environmental_damage"] = {
	[1] = {r = "(.+) falls- and loses- (%d+) health%.", f = function (target, damage) return "Gravity", target, "fall", damage; end},
	[2] = {r = "(.+) [ia][sr]e- drowning and loses- (%d+) health%.", f = function (target, damage) return "Water", target, "drown", damage; end},
	[3] = {r = "(.+) suffers- (%d+) points of (.+) damage%.", f = function (target, damage, type) return "Environment", target, "damage", damage, type; end},
	[4] = {r = "(.+) [ia][sr]e- exhausted and loses- (%d+) health%.", f = function (target, damage) return "Water", target, "exhaust", damage; end},
	[5] = {r = "(.+) loses- (%d+) health for swimming in lava%.", f = function (target, damage) return "Lava", target, "burn", damage, "fire"; end},
};

Yule.combat["cast"] = {
	[1] = {r = "(.+) begins- to cast (.+)%.", f = function (source, ability) return source, nil, ability; end},
	[2] = {r = "(.+) casts- (.+) on (.+)%.", f = function (source, ability, target) return source, target, ability; end},
	[3] = {r = "(.+) casts- (.+)%.", f = function (source, ability) return source, nil, ability; end},
	[4] = {r = "(.+) begins- to perform (.+)%.", f = function (source, ability) return source, nil, ability; end},
	[5] = {r = "(.+) performs- (.+) on (.+)%.", f = function (source, ability, target) return source, target, ability; end},
	[6] = {r = "(.+) performs- (.+)%.", f = function (source, ability) return source, nil, ability; end},
	[7] = {r = "(.+) interrupts- (.+)[r']s- (.+)%.", f = function (source, target, ability) return source, target, "interrupt", ability; end},
	[8] = {r = "(.-)[r']s- (.+) fail[se]d-%. (.+) [ia][sr]e- immune%.", f = function (source, ability, target) return source, target, ability, "(immune)"; end},
	[9] = {r = "(.+) fails- to dispel (.-)['r]s- (.+)%.", f = function (source, target, ability) return source, target, "dispel: "..ability, "(fail)"; end},
};

Yule.combat["melee_spell"] = {
	[1]  = {r = "(.-)[r']s- (.+) hits (.+) for (%d+)%.", f = function (source, ability, target, damage) return source, target, ability, damage; end},
	[2]  = {r = "(.-)[r']s- (.+) crits (.+) for (%d+)%.", f = function (source, ability, target, damage) return source, target, ability, damage, 1; end},
	[3]  = {r = "(.-)[r']s- (.+) misse[sd] (.+)%.", f = function (source, ability, target) return source, target, ability, "(miss)", nil, 1; end},
	[4]  = {r = "(.+)'s (.+) was dodged%.", f = function (source, ability) return source, "You", ability, "(dodge)", nil, 1; end},
	[5]  = {r = "(.-)[r']s- (.+) was dodged by (.+)%.", f = function (source, ability, target) return source, target, ability, "(dodge)", nil, 1; end},
	[6]  = {r = "(.+)'s (.+) was parried%.", f = function (source, ability) return source, "You", ability, "(parry)", nil, 1; end},
	[7]  = {r = "(.-)[r']s- (.+) [wi]a-s parried by (.+)%.", f = function (source, ability, target) return source, target, ability, "(parry)", nil, 1; end},
	[8]  = {r = "(.+)'s (.+) was blocked%.", f = function (source, ability) return source, "You", ability, "(block)", nil, 1; end},
	[9]  = {r = "(.-)[r']s- (.+) was blocked by (.+)%.", f = function (source, ability, target) return source, target, ability, "(block)", nil, 1; end},
	[10] = {r = "(.-)[r']s- (.+) fail[se]d-%. (.+) [ia][sr]e- immune%.", f = function (source, ability, target) return source, target, ability, "(immune)", nil, 1; end},
};

Yule.combat["magic_spell"] = {
	[1]  = {r = "(.-)[r']s- (.+) hits (.+) for (%d+) (.+) damage%.", f = function (source, ability, target, damage, type) return source, target, ability, damage, type; end},
	[2]  = {r = "(.-)[r']s- (.+) crits (.+) for (%d+) (.+) damage%.", f = function (source, ability, target, damage, type) return source, target, ability, damage, type, 1; end},
	[3]  = {r = "(.+)'s (.+) was resisted%.", f = function (source, ability) return source, "You", ability, "(resist)", nil, nil, 1; end},
	[4]  = {r = "(.-)[r']s- (.+) was resisted by (.+)%.", f = function (source, ability, target) return source, target, ability, "(resist)", nil, nil, 1; end},
	[5]  = {r = "(.+)'s (.+) is reflected back%.", f = function (source, ability) return source, "You", ability, "(reflect)", nil, nil, 1; end},
	[6]  = {r = "(.-)[r']s- (.+) is reflected back by (.+)%.", f = function (source, ability, target) return source, target, ability, "(reflect)", nil, nil, 1; end},
	[7]  = {r = "You absorb (.-)[r']s- (.+)%.", f = function (source, ability) return source, "You", ability, "(absorb)", nil, nil, 1; end},
	[8]  = {r = "(.-)[r']s- (.+) is absorbed by (.+)%.", f = function (source, ability, target) return source, target, ability, "(absorb)", nil, nil, 1; end},
	[9]  = {r = "(.-)[r']s- (.+) fails%. (.+) [ia][sr]e- immune%.", f = function (source, ability, target) return source, target, ability, "(immune)", nil, nil, 1; end},
	[10] = {r = "(.-)[r']s- (.+) was evaded by (.+)%.", f = function (source, ability, target) return source, target, ability, "(evade)", nil, nil, 1; end},
};

Yule.combat["heal"] = {
	[1] = {r = "(.+) gains- (%d+) health from (.+)'s (.+)%.", f = function (target, value, source, ability) return source, target, ability, "+"..value, "health"; end},
	[2] = {r = "(.+) gains- (%d+) health from (.+)%.", f = function (target, value, ability) return target, target, ability, "+"..value, "health"; end},
	[3] = {r = "(.-)[r']s- (.+) critically heals (.+) for (%d+)%.", f = function (source, ability, target, value) return source, target, ability, "+"..value, "health", 1; end},
	[4] = {r = "(.-)[r']s- (.+) heals (.+) for (%d+)%.", f = function (source, ability, target, value) return source, target, ability, "+"..value, "health"; end},
};

Yule.combat["power"] = {
	[1] = {r = "(.+) gains- (%d+) (.+) from (.-)[r']s- (.+)%.", f = function (target, value, type, source, ability) return source, target, ability, "+"..value, type; end},
	[2] = {r = "(.+) gains- (%d+) (.+) from (.+)%.", f = function (unit, value, type, ability) return unit, unit, ability, "+"..value, type; end},
	[3] = {r = "(.+) gains- (%d+) extra (.+) through (.+)%.", f = function (unit, value, type, ability) return unit, unit, ability, "+"..value, type; end},
};

Yule.combat["periodic_damage"] = {
	[1] = {r = "(.+) suffers- (%d+) (.+) damage from (.-)[r']s- (.+)%.", f = function (target, damage, type, source, ability) return source, target, ability, damage, type; end},
	[2] = {r = "(.-)[r']s- (.+) is absorbed by (.+)%.", f = function (source, ability, target) return source, target, ability, "(absorb)"; end},
	[3] = {r = "You absorb (.-)[r']s- (.+)%.", f = function (source, ability) return source, "You", ability, "(absorb)"; end},
	[4] = {r = "(.-)[r']s- (.+) drains (%d+) (.+) from (.+)%.", f = function (source, ability, damage, type, target) return source, target, ability, "-"..damage, type; end},
};

Yule.combat["damage_shield"] = {
	[1] = {r = "(.+) reflects- (%d+) (.+) damage to (.+)%.", f = function (source, damage, type, target) return source, target, "reflect", damage, type; end},
	[2] = {r = "(.-)[r']s- (.+) was resisted by (.+)%.", f = function (source, ability, target) return source, target, ability, "(resist)", nil, 1; end},
	[3] = {r = "(.+)'s (.+) was resisted%.", f = function (source, ability) return source, "You", ability, "(resist)", nil, 1; end},
	[4] = {r = "(.+) is immune to (.-)[r']s- (.+)%.", f = function (target, source, ability) return source, target, ability, "(immune)", nil, 1; end},
};


Yule.combat["CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS"] = function (msg) return
	Yule:ParseMeleeHit(msg, "mobmeleevother", "ENEMY", "FRIEND");
end

Yule.combat["CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES"] = function (msg) return
	Yule:ParseMeleeMiss(msg, "mobmeleevother", "ENEMY", "FRIEND");
end

Yule.combat["CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"] = function (msg) return
	Yule:ParseMeleeHit(msg, "mobmeleevyou", "ENEMY", "FRIEND", nil, "You");
end

Yule.combat["CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES"] = function (msg) return
	Yule:ParseMeleeMiss(msg, "mobmeleevyou", "ENEMY", "FRIEND", nil, "You");
end

Yule.combat["CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"] = function (msg) return
	Yule:ParseMeleeHit(msg, "fplayermelee", "FRIEND", "NEUTRAL") or
	Yule:ParseEnvDamage(msg, "fplayerenvdmg", "NEUTRAL", "FRIEND");
end

Yule.combat["CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES"] = function (msg) return
	Yule:ParseMeleeMiss(msg, "fplayermelee", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"] = function (msg) return
	Yule:ParseMeleeHit(msg, "hplayermeleevyou", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParseMeleeHit(msg, "hplayermeleevother", "ENEMY", "NEUTRAL") or
	Yule:ParseEnvDamage(msg, "hplayerenvdmg", "NEUTRAL", "ENEMY");
end

Yule.combat["CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES"] = function (msg) return
	Yule:ParseMeleeMiss(msg, "hplayermeleevyou", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParseMeleeMiss(msg, "hplayermeleevother", "ENEMY", "NEUTRAL");
end

Yule.combat["CHAT_MSG_COMBAT_PARTY_HITS"] = function (msg) return
	Yule:ParseMeleeHit(msg, "partymelee", "FRIEND", "ENEMY") or
	Yule:ParseEnvDamage(msg, "partyenvdmg", "NEUTRAL", "FRIEND");
end

Yule.combat["CHAT_MSG_COMBAT_PARTY_MISSES"] = function (msg) return
	Yule:ParseMeleeMiss(msg, "partymelee", "FRIEND", "ENEMY");
end

Yule.combat["CHAT_MSG_COMBAT_PET_HITS"] = function (msg) return
	Yule:ParseMeleeHit(msg, "petmelee", "FRIEND", "ENEMY") or
	Yule:ParseEnvDamage(msg, "petenvdmg", "NEUTRAL", "FRIEND");
end

Yule.combat["CHAT_MSG_COMBAT_PET_MISSES"] = function (msg) return
	Yule:ParseMeleeHit(msg, "petmelee", "FRIEND", "ENEMY");
end

Yule.combat["CHAT_MSG_COMBAT_SELF_HITS"] = function (msg) return
	Yule:ParseMeleeHit(msg, "playermelee", "FRIEND", "ENEMY") or
	Yule:ParseEnvDamage(msg, "playerenvdmg", "NEUTRAL", "FRIEND", nil, "You");
end

Yule.combat["CHAT_MSG_COMBAT_SELF_MISSES"] = function (msg) return
	Yule:ParseMeleeMiss(msg, "playermelee", "FRIEND", "ENEMY");
end

Yule.combat["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = function (msg) return
	Yule:ParseFade(msg, "otherfade", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_AURA_GONE_SELF"] = function (msg) return
	Yule:ParseFade(msg, "playerfade", "FRIEND", "You") or
	Yule:ParseFade(msg, "petfade", "FRIEND");
end

Yule.combat["CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF"] = function (msg)
	return false;
end

Yule.combat["CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"] = function (msg) return
	Yule:ParseMeleeSpell(msg, "mobmeleevother", "ENEMY", "FRIEND") or
	Yule:ParseMagicSpell(msg, "mobspellsvother", "ENEMY", "FRIEND") or
	Yule:ParseCast(msg, "mobcasts", "ENEMY", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF"] = function (msg)
	return false;
end

Yule.combat["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = function (msg) return
	Yule:ParseMeleeSpell(msg, "mobmeleevyou", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParseMagicSpell(msg, "mobspellsvyou", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParseCast(msg, "mobcasts", "ENEMY", "FRIEND", nil, "You");
end

Yule.combat["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS"] = function (msg) return
	Yule:ParseShield(msg, "perdmgvyou", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParseShield(msg, "otherdmgshield", "NEUTRAL", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF"] = function (msg) return
	Yule:ParseShield(msg, "playerspells", "FRIEND", "ENEMY", "You");
end

Yule.combat["CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF"] = function (msg) return
	Yule:ParseHeal(msg, "fplayerheals", "FRIEND", "FRIEND") or
	Yule:ParsePower(msg, "fplayerpower", "FRIEND", "FRIEND") or
	Yule:ParseCast(msg, "fplayercasts", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"] = function (msg) return
	Yule:ParseMeleeSpell(msg, "fplayermelee", "FRIEND", "NEUTRAL") or
	Yule:ParseMagicSpell(msg, "fplayerspells", "FRIEND", "NEUTRAL") or
	Yule:ParseCast(msg, "fplayercasts", "FRIEND", "NEUTRAL") or
	Yule:ParseShield(msg, "fplayerspells", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"] = function (msg) return
	Yule:ParseHeal(msg, "playerheals", "FRIEND", "FRIEND", nil, "You") or
	Yule:ParseHeal(msg, "hplayerheals", "ENEMY", "ENEMY") or
	Yule:ParsePower(msg, "hplayerpower", "ENEMY", "ENEMY") or
	Yule:ParseCast(msg, "hplayercasts", "ENEMY", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"] = function (msg) return
	Yule:ParseMeleeSpell(msg, "hplayermeleevyou", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParseMeleeSpell(msg, "hplayermeleevother", "ENEMY", "NEUTRAL") or
	Yule:ParseMagicSpell(msg, "hplayerspellsvyou", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParseMagicSpell(msg, "hplayerspellsvother", "ENEMY", "NEUTRAL") or
	Yule:ParseCast(msg, "hplayercasts", "ENEMY", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_PARTY_BUFF"] = function (msg) return
	Yule:ParseHeal(msg, "playerheals", "FRIEND", "FRIEND", nil, "You") or
	Yule:ParseHeal(msg, "partyheals", "FRIEND", "FRIEND") or
	Yule:ParsePower(msg, "partypower", "FRIEND", "FRIEND") or
	Yule:ParseCast(msg, "partycasts", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_PARTY_DAMAGE"] = function (msg) return
	Yule:ParseMeleeSpell(msg, "partymelee", "FRIEND", "ENEMY") or
	Yule:ParseMagicSpell(msg, "partyspells", "FRIEND", "ENEMY") or
	Yule:ParseCast(msg, "partycasts", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = function (msg) return
	Yule:ParseHeal(msg, "playerheals", "NEUTRAL", "FRIEND", nil, "You") or
	Yule:ParsePower(msg, "playerpower", "NEUTRAL", "FRIEND", nil, "You") or
	Yule:ParsePower(msg, "mobheals", "NEUTRAL", "NEUTRAL") or
	Yule:ParseBuff(msg, "mobbuffs", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = function (msg) return
	Yule:ParseDebuff(msg, "mobdebuffs", "NEUTRAL") or
	Yule:ParsePerDamage(msg, "mobperdmgyou", "FRIEND", "ENEMY", "You") or
	Yule:ParsePerDamage(msg, "mobperdmgother", "NEUTRAL", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"] = function (msg) return
	Yule:ParseHeal(msg, "playerhealsvother", "FRIEND", "FRIEND", "You") or
	Yule:ParseHeal(msg, "fplayerheals", "FRIEND", "FRIEND") or
	Yule:ParsePower(msg, "fplayerpower", "FRIEND", "FRIEND") or
	Yule:ParseBuff(msg, "fplayerbuffs", "FRIEND");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = function (msg) return
	Yule:ParseDebuff(msg, "fplayerdebuffs", "FRIEND") or
	Yule:ParsePerDamage(msg, "fplayerperdmg", "NEUTRAL", "FRIEND");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"] = function (msg) return
	Yule:ParseHeal(msg, "hplayerheals", "ENEMY", "ENEMY") or
	Yule:ParsePower(msg, "hplayerpower", "ENEMY", "ENEMY") or
	Yule:ParseBuff(msg, "hplayerbuffs", "ENEMY");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"] = function (msg) return
	Yule:ParseDebuff(msg, "hplayerdebuffs", "ENEMY") or
	Yule:ParsePerDamage(msg, "hplayerperdmgyou", "FRIEND", "ENEMY", "You") or
	Yule:ParsePerDamage(msg, "hplayerperdmgother", "FRIEND", "ENEMY");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS"] = function (msg) return
	Yule:ParseHeal(msg, "playerhealsvother", "FRIEND", "FRIEND", "You") or
	Yule:ParseHeal(msg, "partyheals", "FRIEND", "FRIEND") or
	Yule:ParsePower(msg, "partypower", "FRIEND", "FRIEND") or
	Yule:ParseBuff(msg, "partybuffs", "FRIEND");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = function (msg) return
	Yule:ParseDebuff(msg, "partydebuffs", "FRIEND") or
	Yule:ParsePerDamage(msg, "partyperdmg", "ENEMY", "FRIEND");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"] = function (msg) return
	Yule:ParseHeal(msg, "playerheals", "FRIEND", "FRIEND", nil, "You") or
	Yule:ParsePower(msg, "playerpower", "FRIEND", "FRIEND", nil, "You") or
	Yule:ParseBuff(msg, "playerbuffs", "FRIEND", "You") or
	Yule:ParseBuff(msg, "petbuffs", "FRIEND");
end

Yule.combat["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = function (msg) return
	Yule:ParseDebuff(msg, "playerdebuffs", "FRIEND", "You") or
	Yule:ParseDebuff(msg, "petdebuffs", "FRIEND") or
	Yule:ParsePerDamage(msg, "playerperdmg", "ENEMY", "FRIEND", nil, "You") or
	Yule:ParsePerDamage(msg, "petperdmg", "ENEMY", "FRIEND");
end

Yule.combat["CHAT_MSG_SPELL_PET_BUFF"] = function (msg) return
	Yule:ParseCast(msg, "petcasts", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_PET_DAMAGE"] = function (msg) return
	Yule:ParseMeleeSpell(msg, "petmelee", "FRIEND", "ENEMY") or
	Yule:ParseMagicSpell(msg, "petspells", "FRIEND", "ENEMY") or
	Yule:ParseCast(msg, "petcasts", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_SELF_BUFF"] = function (msg) return
	Yule:ParseHeal(msg, "playerheals", "FRIEND", "FRIEND", nil, "You") or
	Yule:ParseHeal(msg, "playerhealsvother", "FRIEND", "FRIEND") or
	Yule:ParsePower(msg, "playerpower", "FRIEND", "FRIEND", nil, "You") or
	Yule:ParseBuff(msg, "playerbuffs", "FRIEND") or
	Yule:ParseCast(msg, "playercasts", "FRIEND", "NEUTRAL");
end

Yule.combat["CHAT_MSG_SPELL_SELF_DAMAGE"] = function (msg) return
	Yule:ParseMeleeSpell(msg, "playermelee", "FRIEND", "ENEMY") or
	Yule:ParseMagicSpell(msg, "playerspells", "FRIEND", "ENEMY") or
	Yule:ParseCast(msg, "playercasts", "FRIEND", "NEUTRAL");
end
