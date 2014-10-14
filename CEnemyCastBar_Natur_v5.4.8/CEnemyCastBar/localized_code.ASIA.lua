-- Localized Functions for the Asian Version; I am too lazy to exclude the localizations in a more seperate way!
-- Outsorced functions:
-- _Yell, _Emote, _GFind, _Enter_Combat

if ( GetLocale() == "zhTW" ) then

	NECB_client_known = true;

	function CEnemyCastBar_Yells(arg1, arg2) --Yell
	
			if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then
	
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, YELL: "..arg1.."\nMOB="..arg2)
	
			end
	
		if (CEnemyCastBar.bStatus) then
	
			if (arg2 == CEnemyCastBar_NEFARIAN_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_NEFARIAN_SHAMAN_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_SHAMANS, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_DRUID_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_DRUIDS, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_WARLOCK_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_WARLOCKS, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_PRIEST_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_PRIESTS, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_HUNTER_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_HUNTERS, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_WARRIOR_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_WARRIORS, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_ROGUE_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_ROGUES, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_PALADIN_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_PALADINS, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_MAGE_CALL)) then
					CEnemyCastBar_Control(CECB_CLASS_MAGES, CECB_SPELL_NEF_CALLS, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_LAND)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_NEFARIAN_NAME, CECB_SPELL_LANDING, "pve");
					return;
	
				end
	
			elseif (arg2 == CEnemyCastBar_NEFARIUS_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_NEFARIAN_STARTING)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_NEFARIAN_NAME, CECB_SPELL_MOB_SPAWN, "pve");
					return;
	
				end
	
			elseif (arg2 == CEnemyCastBar_RAGNAROS_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_RAGNAROS_STARTING)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_RAGNAROS_NAME, CECB_SPELL_SUBMERGE, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_RAGNAROS_KICKER)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_RAGNAROS_NAME, CECB_SPELL_KNOCKBACK, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_RAGNAROS_SONS)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_RAGNAROS_NAME, CECB_SPELL_SONS_OF_FLAME, "pve");
					return;
	
				end
	
			elseif (string.find(arg2, CEnemyCastBar_GRETHOK_NAME_PAT) ) then
	
				if (string.find(arg1, CEnemyCastBar_RAZORGORE_CALL)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_RAZORGORE_NAME, CECB_SPELL_MOB_SPAWN_45SEC, "pve");
					return;
	
				end
	
			elseif (string.find(arg2, CEnemyCastBar_SARTURA_NAME_PAT) ) then
	
				if (string.find(arg1, CEnemyCastBar_SARTURA_CALL)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_SARTURA_NAME, CECB_SPELL_ENRAGED_MODE2, "pve");
					return;
	
				end
	
			elseif (arg2 == CEnemyCastBar_HAKKAR_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_HAKKAR_YELL)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_HAKKAR_NAME, CECB_SPELL_ENRAGED_MODE2, "pve");
					CEnemyCastBar_Control(CEnemyCastBar_HAKKAR_NAME, CECB_SPELL_BLOOD_SIPHON, "pve", nil, "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
					return;
	
				end
	
			elseif (arg2 == CEnemyCastBar_PATCHWERK_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_PATCHWERK_NAME) ) then
	
					CEnemyCastBar_Control(CEnemyCastBar_PATCHWERK_NAME, CECB_SPELL_ENRAGED_MODE1, "pve");
					return;
	
				end
	
			elseif (string.find(arg2, CEnemyCastBar_RAZUVIOUS_NAME_PAT) ) then
	
					CEnemyCastBar_Control(CEnemyCastBar_RAZUVIOUS_NAME, CECB_SPRLL_DISRUPTING_SHOUT, "engage");
					CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
					CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
					return;
	
			elseif (string.find(arg2, CEnemyCastBar_FAERLINA_NAME_PAT) ) then
	
				if (string.find(arg1, CEnemyCastBar_FAER_YELL1) or string.find(arg1, CEnemyCastBar_FAER_YELL2) or string.find(arg1, CEnemyCastBar_FAER_YELL3) or string.find(arg1, CEnemyCastBar_FAER_YELL4) ) then
	
					CEnemyCastBar_Control(CEnemyCastBar_FAERLINA_NAME, CECB_SPELL_ENRAGE, "pve");
					return;
	
				end
	
			elseif (string.find(arg2, CEnemyCastBar_GOTHIK_NAME_PAT) ) then
	
				if (string.find(arg1, CEnemyCastBar_GOTHIK_YELL) ) then

					CEnemyCastBar_Control(CEnemyCastBar_GOTHIK_NAME, CECB_SPELL_COMES_DOWN, "pve");
					CEnemyCastBar_Control(CEnemyCastBar_GOTHIK_NAME, CECB_SPELL_1ST_TRAINEES_INCOME, "pve");
					CEnemyCastBar_Control(CEnemyCastBar_GOTHIK_NAME, CECB_SPELL_1ST_DK_INCOME, "pve");
					CEnemyCastBar_Control(CEnemyCastBar_GOTHIK_NAME, CECB_SPELL_1ST_RIDER_INCOME, "pve");
					return;
	
				end
	
			elseif (arg2 == CEnemyCastBar_ANUB_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_ANUB_YELL1) or string.find(arg1, CEnemyCastBar_ANUB_YELL2) or string.find(arg1, CEnemyCastBar_ANUB_YELL3) ) then
	
					CEnemyCastBar_Control(CEnemyCastBar_ANUB_NAME, CECB_SPELL_FIRST_LOCUST_SWARM, "pve");
					return;
	
				end
	
			elseif (string.find(arg2, CEnemyCastBar_NOTH_NAME_PAT) ) then
	
					CEnemyCastBar_Control(CEnemyCastBar_NOTH_NAME, CECB_SPELL_FIRST_TELEPORT, "engage");
					return;
	
			elseif (string.find(arg2, CEnemyCastBar_HEIGAN_NAME_PAT) ) then
	
				if (string.find(arg1, CEnemyCastBar_HEIGAN_YELL1) or string.find(arg1, CEnemyCastBar_HEIGAN_YELL2) or string.find(arg1, CEnemyCastBar_HEIGAN_YELL3) ) then
	
					CEnemyCastBar_Control(CEnemyCastBar_HEIGAN_NAME, CECB_SPELL_TELEPORT_CD, "pve");
					return;
	
				end
	
				if (string.find(arg1, CEnemyCastBar_HEIGAN_TELEPORT_YELL) ) then
	
					CEnemyCastBar_Control(CEnemyCastBar_HEIGAN_NAME, CECB_SPELL_ON_PLATFORM, "pve");
					return;
	
				end
	
			end
	
		end
	
	end
	
	function CEnemyCastBar_Emotes(arg1, arg2) --Emote
	
		if (CEnemyCastBar.bStatus) then
	
			if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then
	
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, EMOTE: "..arg1.."\nMOB="..arg2)
	
			end
	
			if (arg2 == CEnemyCastBar_FLAMEGOR_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_FLAMEGOR_FRENZY)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_FLAMEGOR_NAME, CECB_SPELL_FRENZY_CD, "pve");
					return;
	
				end
	
			elseif (arg2 == CEnemyCastBar_CHROMAGGUS) then
	
				if (string.find(arg1, CEnemyCastBar_CHROMAGGUS_FRENZY)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_CHROMAGGUS, CECB_SPELL_KILLING_FRENZY, "pve");
					return;
	
				end
	
			elseif (arg2 == CEnemyCastBar_MOAM_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_MOAM_STARTING)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_MOAM_NAME, CECB_SPELL_UNTIL_STONEFORM, "pve");
					return;
	
				end
	
			elseif (string.find(arg2, CEnemyCastBar_SARTURA_NAME_PAT) ) then
	
				if (string.find(arg1, CEnemyCastBar_SARTURA_CRAZY)) then
	
					CEnemyCastBar_DelBar(CECB_SPELL_ENRAGED_MODE2);
					CEnemyCastBar_Control(CEnemyCastBar_SARTURA_NAME, CECB_SPELL_ENTER_ENRAGED_MODE, "pve");
					return;
	
				end
	
			elseif (string.find(arg2, CEnemyCastBar_HUHURAN_NAME_PAT) ) then
	
				if (string.find(arg1, CEnemyCastBar_FLAMEGOR_FRENZY)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_HUHURAN_NAME, CECB_SPELL_FRENZY_CD, "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_HUHURAN_CRAZY)) then
	
					CEnemyCastBar_DelBar(CECB_SPELL_BERSERK_MODE);
					CEnemyCastBar_Control(CEnemyCastBar_HUHURAN_NAME, CECB_SPELL_ENTER_BERSERK_MODE, "pve");
					return;
	
				end
	
			elseif (string.find(CEnemyCastBar_CTHUN_NAME1, arg2) ) then
	
				if (string.find(arg1, CEnemyCastBar_CTHUN_WEAKENED)) then
	
					CEnemyCastBar_Control(CEnemyCastBar_CTHUN_NAME2, CECB_SPELL_WEAKENED, "pve", "true");
					return;
	
				end
	
			elseif (arg2 == CenemyCastBar_ONYXIA_NAME) then
	
				if (string.find(arg1, CEnemyCastBar_ONY_DB)) then
	
					CEnemyCastBar_Control(CenemyCastBar_ONYXIA_NAME, CECB_SPELL_DEEP_BREATH, "pve");
					return;
	
				end
	
			end
	
		end
	
	end

	function CEnemyCastBar_Gfind(arg1, event) --Gfind
		
		if (CEnemyCastBar.bStatus) then
	
			if (arg1) then
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_CAST) do
	
					CEnemyCastBar_Control(mob, spell, "casts", nil, event);
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_PERFORM) do
	
					CEnemyCastBar_Control(mob, spell, "performs", nil, event);
					return;
				end
	
				for mob in string.gfind(arg1, CEnemyCastBar_MOB_DIES) do
	
					if (mob == CEnemyCastBar_CTHUN_NAME1) then
	
						CEnemyCastBar_DelBar(CECB_SPELL_DARK_GLARE);
						CEnemyCastBar_DelBar(CECB_SPELL_SMALL_EYE_P1);
						CEnemyCastBar_Control(CEnemyCastBar_CTHUN_NAME2, CECB_SPELL_FIRST_SMALL_EYE_P2, "pve");
					end
	
					CEnemyCastBar_Control(mob, mob, "died");
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_GAINS) do
	
					CEnemyCastBar_Control(mob, spell, "gains", nil, event);
					return;
				end
	
				-- return if Spell damage from other players/mobs is detected -> german client problem (without it DoTs from everyone will be displayed, see next clause)
				for target in string.gfind(arg1, CEnemyCastBar_SPELL_DAMAGE) do

				    if (target ~= CECB_SELF1) then
				        return;
				    end
				end
	
				for spell, mob, damage in string.gfind(arg1, CEnemyCastBar_SPELL_DAMAGE_SELFOTHER) do
	
					CEnemyCastBar_Control(mob, spell, "periodicdmg");
					return;
				end
	
				-- spell hits (Razuvious + others)
				for mob, spell, target, damage in string.gfind(arg1, CEnemyCastBar_SPELL_HITS) do
					if (
						string.find(mob, CEnemyCastBar_RAZUVIOUS_NAME_PAT)
						or mob == CEnemyCastBar_GLUTH_NAME
						) then
	
						CEnemyCastBar_Control(mob, spell, "casts", nil, event);
					end
					return;
				end
	
				-- periodic debuff damage routine for frFR, enUS and deDE pattern, No.2 - crit! has to be checked first!
				for spell, mob, damage in string.gfind(arg1, CEnemyCastBar_SPELL_CRITS_SELFOTHER) do
	
					CEnemyCastBar_Control(mob, spell, "periodichitdmg");
					return;
				end
	
				-- periodic debuff damage routine for frFR, enUS and deDE pattern, No.3 - noncrit! has to be checked after crit!
				for spell, mob, damage in string.gfind(arg1, CEnemyCastBar_SPELL_HITS_SELFOTHER) do
	
					CEnemyCastBar_Control(mob, spell, "periodichitdmg");
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_AFFLICTED) do
	
                   			NECB_interrupt_casting(spell, mob); -- spell interrupting idea from Lazarus
					CEnemyCastBar_Control(mob, spell, "afflicted", nil, event);
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_AFFLICTED2) do
					
					NECB_interrupt_casting(spell, mob); -- spell interrupting idea from Lazarus
					CEnemyCastBar_Control(mob, spell, "afflicted", nil, event);
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_REMOVED) do
	
					CEnemyCastBar_Control(mob, spell, "fades");
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_INTERRUPTED) do
	
					NECB_interrupt_casting(" ", mob);
					return;
				end
	
				for interrupter, mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_INTERRUPTED_OTHER) do
	
					NECB_interrupt_casting(" ", mob);
					return;
				end
	
				for spell, mob in string.gfind(arg1, CEnemyCastBar_SPELL_FADE) do
	
					CEnemyCastBar_Control(mob, spell, "fades");
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_CASTS) do
	
					CEnemyCastBar_Control(mob, spell, "instcast", nil, event);
					return;
				end
	
			end
		end
	end

	function CEnemyCastBar_Player_Enter_Combat_Execute(targetmob) --enter combat execution, called by the enter combat preprocessor in main lua
	
		if (targetmob == CEnemyCastBar_FIREMAW_NAME or targetmob == CEnemyCastBar_FLAMEGOR_NAME or targetmob == CEnemyCastBar_EBONROC_NAME) then

			CEnemyCastBar_Control(targetmob, CECB_SPELL_FIRST_WINGBUFFET, "engage");
			return;

		elseif (GetRealZoneText() == CECB_ZONE_AHNQIRAJ) then

			if (string.find (targetmob, CEnemyCastBar_YAUJ_NAME_PAT) or string.find (targetmob, CEnemyCastBar_KRI_NAME_PAT) or targetmob == CEnemyCastBar_VEM_NAME ) then

				CEnemyCastBar_Control(CEnemyCastBar_DETECTED_NAME, CECB_SPELL_BOSS_INCOMING, "engage"); -- to allow the (protected) fear, "Boss incoming".t = 0 ^^
				return;

			elseif (string.find (targetmob, CEnemyCastBar_HUHURAN_NAME) ) then

				CEnemyCastBar_Control(CEnemyCastBar_HUHURAN_NAME, CECB_SPELL_BERSERK_MODE, "engage");
				return;

			elseif (targetmob == CEnemyCastBar_OURO_NAME ) then

				CEnemyCastBar_Control(CEnemyCastBar_OURO_NAME, CECB_SPELL_POSSIBLE_OURO_SUBMERGE, "engage");
				return;

			elseif (string.find (targetmob, CEnemyCastBar_CTHUN_NAME1) ) then

				CEnemyCastBar_Control(CEnemyCastBar_CTHUN_NAME2, CECB_SPELL_FIRST_DARK_GLARE, "engage");
				return;

			elseif ( (string.find (targetmob, CEnemyCastBar_VEKLOR_NAME) or string.find (targetmob, CEnemyCastBar_VEKNILASH_NAME) ) ) then

				CEnemyCastBar_Control(CEnemyCastBar_TWINS_NAME, CECB_SPELL_ENRAGED_MODE2, "engage");
				CEnemyCastBar_Control(CEnemyCastBar_TWINS_NAME, CECB_SPELL_TWIN_TELEPORT, "pve");
				return;

			end

		elseif (GetRealZoneText() == CECB_ZONE_NAXXRAMAS) then

			if (targetmob == CEnemyCastBar_GLUTH_NAME ) then

				CEnemyCastBar_Control(CEnemyCastBar_GLUTH_NAME, CECB_SPELL_DECIMATE, "engage");
				CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
				CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
				return;

			elseif (targetmob == CEnemyCastBar_MAEXXAN_NAME ) then

				CEnemyCastBar_Control(CEnemyCastBar_MAEXXAN_NAME, CECB_SPELL_WEB_SPRAY, "engage");
				return;

			elseif (targetmob == CEnemyCastBar_LOATHEB_NAME ) then

				CEnemyCastBar_Control(CEnemyCastBar_LOATHEB_NAME, CECB_SPELL_15SEC_DOOM_CD, "engage");
				CEnemyCastBar_Control(CEnemyCastBar_LOATHEB_NAME, CECB_SPELL_FIRST_INVITABLE_DOOM, "pve");
				return;

			elseif (targetmob == CEnemyCastBar_SAPPHIRON_NAME ) then
	
				CEnemyCastBar_Control(targetmob, CECB_SPELL_ENRAGED_MODE2, "engage");
				return;

			end

		end
	
	end

	function CEnemyCastBar_Player_Enter_Combat_Exception() -- C'Thun exception

		if (GetRealZoneText() == CECB_ZONE_AHNQIRAJ and UnitName("target")) then

			if (string.find (UnitName("target"), CEnemyCastBar_CTHUN_NAME1) ) then

				CEnemyCastBar_Control(CEnemyCastBar_CTHUN_NAME2, CECB_SPELL_FIRST_DARK_GLARE, "engage");
				CEnemyCastBar_Control(CEnemyCastBar_CTHUN_NAME2, CECB_SPELL_SMALL_EYE_P1, "pve");
			end
		end
	end

end