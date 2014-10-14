-- Localized Functions for the European Version; I am too lazy to exclude the localizations in a more seperate way!
-- Outsorced functions:
-- _Yell, _Emote, _GFind, _Enter_Combat

if ( GetLocale() == "deDE" or GetLocale() == "enGB" or GetLocale() == "enUS" or GetLocale() == "frFR") then

	NECB_client_known = true;

	function CEnemyCastBar_Yells(arg1, arg2) --Yell
	
			if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then
		
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, YELL: "..arg1.."\nMOB="..arg2)
			
			end
	
		if (CEnemyCastBar.bStatus) then
		
			if (arg2 == "Nefarian") then
	
				if (string.find(arg1, CEnemyCastBar_NEFARIAN_SHAMAN_CALL)) then 
					CEnemyCastBar_Control("Shamans", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_DRUID_CALL)) then 
					CEnemyCastBar_Control("Druids", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_WARLOCK_CALL)) then 
					CEnemyCastBar_Control("Warlocks", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_PRIEST_CALL)) then 
					CEnemyCastBar_Control("Priests", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_HUNTER_CALL)) then 
					CEnemyCastBar_Control("Hunters", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_WARRIOR_CALL)) then 
					CEnemyCastBar_Control("Warriors", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_ROGUE_CALL)) then 
					CEnemyCastBar_Control("Rogues", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_PALADIN_CALL)) then 
					CEnemyCastBar_Control("Paladins", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_MAGE_CALL)) then 
					CEnemyCastBar_Control("Mages", "Nefarian calls", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_LAND)) then
				
					CEnemyCastBar_Control("Nefarian", "Landing", "pve");
					return;
	
				end
	
			elseif (arg2 == "Lord Victor Nefarius") then
		
				if (string.find(arg1, CEnemyCastBar_NEFARIAN_STARTING)) then
				
					CEnemyCastBar_Control("Nefarian", "Mob Spawn", "pve");
					return;
				
				end
	
			elseif (arg2 == "Ragnaros") then
			
				if (string.find(arg1, CEnemyCastBar_RAGNAROS_STARTING)) then
			
					CEnemyCastBar_Control("Ragnaros", "Submerge", "pve");
					return;
					
				elseif (string.find(arg1, CEnemyCastBar_RAGNAROS_KICKER)) then
				
					CEnemyCastBar_Control("Ragnaros", "Knockback", "pve");
					return;
					
				elseif (string.find(arg1, CEnemyCastBar_RAGNAROS_SONS)) then
				
					CEnemyCastBar_Control("Ragnaros", "Sons of Flame", "pve");
					return;
				
				end
	
			elseif (string.find(arg2, "Grethok ") ) then
	
				if (string.find(arg1, CEnemyCastBar_RAZORGORE_CALL)) then
				
					CEnemyCastBar_Control("Razorgore", "Mob Spawn (45sec)", "pve");
					return;
				
				end
	
			elseif (string.find(arg2, " Sartura") ) then
			
				if (string.find(arg1, CEnemyCastBar_SARTURA_CALL)) then
	
					CEnemyCastBar_Control("Sartura", "Enraged mode", "pve");
					return;
				
				end
	
			elseif (arg2 == "Hakkar") then
			
				if (string.find(arg1, CEnemyCastBar_HAKKAR_YELL)) then
	
					CEnemyCastBar_Control("Hakkar", "Enraged mode", "pve");
	
					CEnemyCastBar_Control("Hakkar", "Blood Siphon", "pve", nil, "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
					CEnemyCastBar_Control("Hakkar", "Bluttrinker", "pve", nil, "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
					CEnemyCastBar_Control("Hakkar", "Siphon de sang", "pve", nil, "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
					return;
				
				end
	
			elseif (arg2 == CEnemyCastBar_PATCHWERK_NAME) then
			
				if (string.find(arg1, CEnemyCastBar_PATCHWERK_NAME) ) then
			
					CEnemyCastBar_Control("Patchwerk", "Enraged Mode", "pve");
					return;
					
				end
	
			elseif (string.find(arg2, " Razuvious") ) then
	
					CEnemyCastBar_Control("Razuvious", "Disrupting Shout", "engage");
					CEnemyCastBar_Control("Razuvious", "Unterbrechungsruf", "engage");
					CEnemyCastBar_Control("Razuvious", "Cri perturbant", "engage");
	
					CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
					CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
					return;
		 
			elseif (string.find(arg2, " Faerlina") ) then
	
				if (string.find(arg1, CEnemyCastBar_FAER_YELL1) or string.find(arg1, CEnemyCastBar_FAER_YELL2) or string.find(arg1, CEnemyCastBar_FAER_YELL3) or string.find(arg1, CEnemyCastBar_FAER_YELL4) ) then
			
					CEnemyCastBar_Control("Faerlina", "Enrage", "pve");
					CEnemyCastBar_Control("Faerlina", "Wutanfall", "pve");
					CEnemyCastBar_Control("Faerlina", "Enrager", "pve");
					return;
					
				end
			
			elseif (string.find(arg2, "Gothik ") ) then
			
				if (string.find(arg1, CEnemyCastBar_GOTHIK_YELL) ) then

					CEnemyCastBar_Control("Gothik", "Comes Down", "pve");
					CEnemyCastBar_Control("Gothik", "First Trainees", "pve");
					CEnemyCastBar_Control("Gothik", "First Deathknights", "pve");
					CEnemyCastBar_Control("Gothik", "First Rider", "pve");
					return;

				end
	
			elseif (arg2 == "Anub'Rekhan") then
	
				if (string.find(arg1, CEnemyCastBar_ANUB_YELL1) or string.find(arg1, CEnemyCastBar_ANUB_YELL2) or string.find(arg1, CEnemyCastBar_ANUB_YELL3) ) then
				
					CEnemyCastBar_Control("Anub'Rekhan", "First Locust Swarm", "pve");
					return;
	
				end
	
			elseif (string.find(arg2, "Noth ") ) then
			
					CEnemyCastBar_Control("Noth", "First Teleport", "engage");
					return;
	
			elseif (string.find(arg2, "Heigan ") ) then
			
				if (string.find(arg1, CEnemyCastBar_HEIGAN_YELL1) or string.find(arg1, CEnemyCastBar_HEIGAN_YELL2) or string.find(arg1, CEnemyCastBar_HEIGAN_YELL3) ) then
				
					CEnemyCastBar_Control("Heigan", "Teleport CD", "pve");
					return;
				
				end
				
				if (string.find(arg1, CEnemyCastBar_HEIGAN_TELEPORT_YELL) ) then
				
					CEnemyCastBar_Control("Heigan", "On Platform", "pve");
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
			
					CEnemyCastBar_Control("Flamegor", "Frenzy (CD)", "pve");
					return;
					
				end
			
			elseif (arg2 == "Chromaggus") then
			
				if (string.find(arg1, CEnemyCastBar_CHROMAGGUS_FRENZY)) then
			
					CEnemyCastBar_Control("Chromaggus", "Killing Frenzy", "pve");
					return;
					
				end
	
			elseif (arg2 == "Moam") then
			
				if (string.find(arg1, CEnemyCastBar_MOAM_STARTING)) then
			
					CEnemyCastBar_Control("Moam", "Until Stoneform", "pve");
					return;
					
				end
	
			elseif (string.find(arg2, " Sartura") ) then
			
				if (string.find(arg1, CEnemyCastBar_SARTURA_CRAZY)) then
	
					CEnemyCastBar_DelBar("Enraged mode");
					CEnemyCastBar_Control("Sartura", "Enters Enraged mode", "pve");
					return;
					
				end
	
			elseif (string.find(arg2, " Huhuran") ) then
			
				if (string.find(arg1, CEnemyCastBar_FLAMEGOR_FRENZY)) then
			
					CEnemyCastBar_Control("Huhuran", "Frenzy (CD)", "pve");
					return;
	
				elseif (string.find(arg1, CEnemyCastBar_HUHURAN_CRAZY)) then
	
					CEnemyCastBar_DelBar("Berserk mode");
					CEnemyCastBar_Control("Huhuran", "Enters Berserk mode", "pve");
					return;
					
				end
	
			elseif (string.find(CEnemyCastBar_CTHUN_NAME1, arg2) ) then
			
				if (string.find(arg1, CEnemyCastBar_CTHUN_WEAKENED)) then
	
					CEnemyCastBar_Control("C'Thun", "Weakened!", "pve", "true");
					return;
					
				end
	
			elseif (arg2 == "Onyxia") then
			
				if (string.find(arg1, CEnemyCastBar_ONY_DB)) then
				
					CEnemyCastBar_Control("Onyxia", "Deep Breath", "pve");
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
	
						CEnemyCastBar_DelBar("Dark Glare");
						CEnemyCastBar_DelBar("Small Eyes P1");
						CEnemyCastBar_Control("C'Thun", "First Small Eyes P2", "pve");
					end 
	
					CEnemyCastBar_Control(mob, mob, "died");
					return;
				end
	
				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_GAINS) do
						
					CEnemyCastBar_Control(mob, spell, "gains", nil, event);
					return;
				end
			
				-- return if Spell damage from other players/mobs is detected -> german client problem (without it DoTs from everyone will be displayed, see next clause)
				if (string.find(arg1, CEnemyCastBar_SPELL_DAMAGE) ) then
	
					return;
				end
	
				if ( GetLocale() == "frFR" ) then
	
					for spell, damage, mob in string.gfind(arg1, CEnemyCastBar_SPELL_DAMAGE_SELFOTHER) do
	
							CEnemyCastBar_Control(mob, spell, "periodicdmg");
						return;
					end
	
					-- spell hits (Razuvious + others)
					for spell, mob, target, damage in string.gfind(arg1, CEnemyCastBar_SPELL_HITS) do
						if (
							string.find(mob, " Razuvious")
							or mob == "Gluth"
							) then
	
							CEnemyCastBar_Control(mob, spell, "casts", nil, event);
						end
						return;
					end
	
				else
					-- periodic debuff damage routine for enUS and deDE pattern, No.1
					for mob, damage, spell in string.gfind(arg1, CEnemyCastBar_SPELL_DAMAGE_SELFOTHER) do
	
							CEnemyCastBar_Control(mob, spell, "periodicdmg");
						return;
					end
	
					-- spell hits (Razuvious + others)
					for mob, spell, target, damage in string.gfind(arg1, CEnemyCastBar_SPELL_HITS) do
						if (
							string.find(mob, " Razuvious")
							or mob == "Gluth"
							) then
	
							CEnemyCastBar_Control(mob, spell, "casts", nil, event);
						end
						return;
					end
	
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
	
				if ( GetLocale() == "deDE" ) then
	
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
	
					for spell, mob in string.gfind(arg1, CEnemyCastBar_SPELL_REMOVED) do
	
						CEnemyCastBar_Control(mob, spell, "fades");
						return;
					end
	
					-- event == "CHAT_MSG_SPELL_SELF_DAMAGE"
					for spell, mob in string.gfind(arg1, CEnemyCastBar_SPELL_INTERRUPTED) do
	
						NECB_interrupt_casting(" ", mob);
						return;
					end
	
					-- event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"
					for interrupter, spell, mob in string.gfind(arg1, CEnemyCastBar_SPELL_INTERRUPTED_OTHER) do
	
						NECB_interrupt_casting(" ", mob);
						return;
					end
	
				else
	
					for mob, crap, spell in string.gfind(arg1, CEnemyCastBar_SPELL_AFFLICTED) do
	
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

			CEnemyCastBar_Control(targetmob, "First Wingbuffet", "engage");
			return;

		elseif (GetRealZoneText() == "Ahn'Qiraj") then

			if (string.find (targetmob, " Yauj") or string.find (targetmob, " Kri") or targetmob == "Vem" ) then

				CEnemyCastBar_Control("Detected", "Boss incoming", "engage"); -- to allow the (protected) fear, "Boss incoming".t = 0 ^^
				return;

			elseif (string.find (targetmob, "Huhuran") ) then
	
				CEnemyCastBar_Control("Huhuran", "Berserk mode", "engage");
				return;
	
			elseif (targetmob == "Ouro" ) then
			
				CEnemyCastBar_Control("Ouro", "Possible Ouro Submerge", "engage");
				return;
	
			elseif (string.find (targetmob, CEnemyCastBar_CTHUN_NAME1) ) then
	
				CEnemyCastBar_Control("C'Thun", "First Dark Glare", "engage");
				return;

			elseif ( (string.find (targetmob, "Vek'lor") or string.find (targetmob, "Vek'nilash") ) ) then

				CEnemyCastBar_Control("Twins", "Enraged mode", "engage");
				CEnemyCastBar_Control("Twins", "Twin Teleport", "pve");
				CEnemyCastBar_Control("Twins", "Zwillingsteleport", "pve");
				CEnemyCastBar_Control("Twins", "T\195\169l\195\169portation des jumeaux", "pve");
				return;

			end

		elseif (GetRealZoneText() == "Naxxramas") then

			if (targetmob == "Gluth" ) then
	
				CEnemyCastBar_Control("Gluth", "Decimate", "engage");
				CEnemyCastBar_Control("Gluth", "Dezimieren", "engage");
				CEnemyCastBar_Control("Gluth", "D\195\169cimer", "engage");
				CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
				CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
				return;
	
			elseif (targetmob == "Maexxna" ) then
	
				CEnemyCastBar_Control("Maexxna", "Web Spray", "engage");
				CEnemyCastBar_Control("Maexxna", "Gespinstschauer", "engage");
				CEnemyCastBar_Control("Maexxna", "Jet de rets", "engage");
				return;
	
			elseif (targetmob == "Loatheb" ) then
	
				CEnemyCastBar_Control("Loatheb", "15 sec Doom CD!", "engage");
				CEnemyCastBar_Control("Loatheb", "First Inevitable Doom", "pve");
				return;

			elseif (targetmob == "Sapphiron" or targetmob == "Saphiron" ) then
	
				CEnemyCastBar_Control(targetmob, "Enraged mode", "engage");
				return;

			end

		end
	
	end

	function CEnemyCastBar_Player_Enter_Combat_Exception() -- C'Thun exception

		if (GetRealZoneText() == "Ahn'Qiraj" and UnitName("target")) then

			if (string.find (UnitName("target"), CEnemyCastBar_CTHUN_NAME1) ) then
	
				CEnemyCastBar_Control("C'Thun", "First Dark Glare", "engage");
				CEnemyCastBar_Control("C'Thun", "Small Eyes P1", "pve");
			end
		end
	end

end