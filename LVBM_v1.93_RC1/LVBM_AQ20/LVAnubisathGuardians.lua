-- 
-- Anubisath Guardians v0.1
--

LVBM.AddOns.AnubisathGuardians = { 
	["Name"] = LVBM_GUARDIAN_NAME,
	["Abbreviation1"] = "guardians", 
	["Version"] = "0.1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_GUARDIAN_INFO,
	["Instance"] = LVBM_AQ20,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["Summon"] = false,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.AnubisathGuardians.Options.Whisper",
			["text"] = LVBM_SEND_WHISPER,
			["func"] = function() LVBM.AddOns.AnubisathGuardians.Options.Whisper = not LVBM.AddOns.AnubisathGuardians.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.AnubisathGuardians.Options.Summon",
			["text"] = LVBM_GUARDIAN_SUMMON_INFO,
			["func"] = function() LVBM.AddOns.AnubisathGuardians.Options.Summon = not LVBM.AddOns.AnubisathGuardians.Options.Summon; end,
		},
	},
	["Sort"] = 27,
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,

		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = true,

		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,

		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
	
		if (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
			if (arg1 == LVBM_GUARDIAN_EXPLODE_EXPR) then
				LVBM.Announce( LVBM_GUARDIAN_EXPLODE_ANNOUNCE );
			elseif (arg1 == LVBM_GUARDIAN_ENRAGE_EXPR) then
				LVBM.Announce( LVBM_GUARDIAN_ENRAGE_ANNOUNCE );
			end

		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" 
		     or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" 
		     or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") then
			if (string.find(arg1, LVBM_GUARDIAN_THUNDERCLAP_EXPR)) then
			 	LVBM.Announce( LVBM_GUARDIAN_THUNDERCLAP_ANNOUNCE );
			end

		elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" 
		     or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" 
		     or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
			local _, _, sArg1, sArg2 = string.find(arg1, LVBM_GUARDIAN_PLAGUE_EXPR);
			if ( sArg1 ) then
				if ( sArg2 == LVBM_ARE and sArg1 == LVBM_YOU ) then
					sArg1 = UnitName("player");
					LVBM.AddSpecialWarning(LVBM_GUARDIAN_PLAGUE_WHISPER, true, true);
				else
					if (LVBM.AddOns.AnubisathGuardians.Options.Whisper) then
						LVBM.SendHiddenWhisper(LVBM_GUARDIAN_PLAGUE_WHISPER, sArg1)
					end
				end
				LVBM.Announce( string.format(LVBM_GUARDIAN_PLAGUE_ANNOUNCE, sArg1) );
			end

		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and LVBM.AddOns.AnubisathGuardians.Options.Summon ) then
			if ( arg1 == LVBM_GUARDIAN_SUMMONGUARD_EXPR ) then
				LVBM.Announce( LVBM_GUARDIAN_SUMMONEDGUARD_ANNOUNCE );
			elseif ( arg1 == LVBM_GUARDIAN_SUMMONWARRIOR_EXPR ) then
				LVBM.Announce( LVBM_GUARDIAN_SUMMONEDWARRIOR_ANNOUNCE );
			end
		end

		-- Reflection
		-- Sekir's Shadow Word: Pain is reflected back by Anubisath Guardian.
		-- Kjaska's Life Steal is reflected back by Anubisath Guardian.
			
		-- Skills
		-- Anubisath Guardian's Shadow Storm hits Sekir for 2102 Shadow damage.
		-- Anubisath Guardian casts Summon Anubisath Warrior.
	end,		
};
