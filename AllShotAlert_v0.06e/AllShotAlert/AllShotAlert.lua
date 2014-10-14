--[[

	AllShot Alert by theArk0s: ---------
		Based off "AimedShot Alert" code
		copyright 2005 by malivil
		Based off "Overpower Alert" code
		copyright 2005 by Interceptor
		Inspired by "Combat Sentry Gizmo" code
	V 0.06e-11100

]]--

------------------------------------------------------------------

ALLSAon_Default = 1;
ALLSAsoundon_Default = 1;
ALLSAmessageon_Default = 1;
ALLSAsoundfile_Default = 0;
local ALLSAplayerclass = UnitClass("player");
ALLSA_variablesLoaded = false;

-- // Register slash commands // --

function ALLSA_SlashCommand(msg)
	AllShotAlertOptions:Hide();
	if ( msg == "help" or msg == "" ) then
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND1);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND2);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND3);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND4);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND5);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND6);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND7);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND8);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND9);
	elseif ( msg == "on" ) then
		ALLSA.on = ALLSAon_Default;			
		ALLSA.soundon = ALLSAsoundon_Default;		
		ALLSA.soundfile = ALLSAmessageon_Default;	
		ALLSA.messageon = ALLSAmessageon_Default;			
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_ON);
	elseif ( msg == "off" ) then
		ALLSA.on = 0;			
		ALLSA.soundon = 0;			
		ALLSA.soundfile = 0;
		ALLSA.messageon = 0;			
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_OFF);
	elseif ( msg == "toggle" ) then
		if ( ALLSA.on == 0 ) then
			ALLSA.on = ALLSAon_Default;			
			ALLSA.soundon = ALLSAsoundon_Default;		
			ALLSA.soundfile = ALLSAmessageon_Default;	
			ALLSA.messageon = ALLSAmessageon_Default;		
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_ON);
		else
			ALLSA.on = 0;			
			ALLSA.soundon = 0;		
			ALLSA.soundfile = 0;			
			ALLSA.messageon = 0;			
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_OFF);
		end
	elseif ( msg == "status" ) then
		if ( ALLSA.on == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_STON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_STOFF);
		end
		if ( ALLSA.messageon == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_MESSAGE_STON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_MESSAGE_STOFF);
		end
		if ( ALLSA.soundon == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUND_STON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUND_STOFF);
		end
		if ( ALLSA.soundfile == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUNDFILE_1);
		else
			DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUNDFILE_0);
		end
	elseif ( (msg == "messageon") or (msg == "mon") ) then
		ALLSA.messageon = 1;		
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_MESSAGE_ON);
	elseif ( (msg == "messageoff") or (msg == "moff") ) then
		ALLSA.messageon = 0;		
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_MESSAGE_OFF);
	elseif ( (msg == "soundon") or (msg == "son") ) then
		ALLSA.soundon = 1;		
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUND_ON);
	elseif ( (msg == "soundoff") or (msg == "soff") ) then
		ALLSA.soundon = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUND_OFF);
	elseif ( (msg == "sound0") or (msg == "s0") ) then
		ALLSA.soundfile = 0;		
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUNDFILE_0);
	elseif ( (msg == "sound1") or (msg == "s1") ) then
		ALLSA.soundfile = 1;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUNDFILE_1);
	elseif ( (msg == "options") or (msg == "option") ) then
		AllShotAlertOptions:Show();
	elseif ( (msg == "reset") ) then
		ALLSA_Reset();
	elseif ( (msg == "record") ) then
		ALLSA_Show_Record();
	else		
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND1);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND2);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND3);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND4);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND5);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND6);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND7);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND8);
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SLASHCOMMAND9);
	end
end
function ALLSA_OnLoad()
	-- Register events
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	SLASH_ALLSA1 = "/allshotalert";
	SLASH_ALLSA2 = "/allsa";
	SlashCmdList["ALLSA"] = ALLSA_SlashCommand;
end

function ALLSA_OnEvent()
	if (event == "VARIABLES_LOADED") then
		ALLSA_VARIABLES_LOADED();
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_WELCOME);
	end
	
	if (ALLSA_variablesLoaded == false) then
		ALLSA_VARIABLES_LOADED();
	end

		if (not ALLSA.on or ALLSA.on == 0) then
			return;
		end
		
		if (ALLSAplayerclass == "Hunter") then
			classTabletoUse = attackTable.hunter;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);
	
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT6, ALLSA_L_YOU, 6);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT7, ALLSA_L_YOU, 7);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT8, ALLSA_L_YOU, 8);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_HCRIT9, ALLSA_L_YOU, 9);
		end
	
		if (ALLSAplayerclass == "Warlock") then
	
			classTabletoUse = attackTable.warlock;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);
	
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_LCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_LCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_LCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_LCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_LCRIT6, ALLSA_L_YOU, 6);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_LCRIT7, ALLSA_L_YOU, 7);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_LCRIT8, ALLSA_L_YOU, 8);
		end
	
		if (ALLSAplayerclass == "Paladin") then
			classTabletoUse = attackTable.paladin;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);
	
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_PCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_PCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_PCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_PCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_PCRIT6, ALLSA_L_YOU, 6);
		end
	
		if (ALLSAplayerclass == "Priest") then
			classTabletoUse = attackTable.priest;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);
	
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT6, ALLSA_L_YOU, 6);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT7, ALLSA_L_YOU, 7);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT8, ALLSA_L_YOU, 8);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_ICRIT9, ALLSA_L_YOU, 9);
		end

		if (ALLSAplayerclass == "Mage") then
			classTabletoUse = attackTable.mage;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);

			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT6, ALLSA_L_YOU, 6);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT7, ALLSA_L_YOU, 7);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT8, ALLSA_L_YOU, 8);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT9, ALLSA_L_YOU, 9);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_MCRIT10, ALLSA_L_YOU, 10);
		end
	
		if (ALLSAplayerclass == "Rogue") then
			classTabletoUse = attackTable.rogue;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);

			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT6, ALLSA_L_YOU, 6);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT7, ALLSA_L_YOU, 7);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT8, ALLSA_L_YOU, 8);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT9, ALLSA_L_YOU, 9);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT10, ALLSA_L_YOU, 10);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT11, ALLSA_L_YOU, 11);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT12, ALLSA_L_YOU, 12);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_RCRIT13, ALLSA_L_YOU, 13);
		end

		if (ALLSAplayerclass == "Warrior") then
			classTabletoUse = attackTable.warrior;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);

			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT6, ALLSA_L_YOU, 6);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT7, ALLSA_L_YOU, 7);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT8, ALLSA_L_YOU, 8);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT9, ALLSA_L_YOU, 9);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT10, ALLSA_L_YOU, 10);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_WCRIT11, ALLSA_L_YOU, 11);
		end

		if (ALLSAplayerclass == "Shaman") then
			classTabletoUse = attackTable.shaman;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);

			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_SCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_SCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_SCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_SCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_SCRIT6, ALLSA_L_YOU, 6);
		end

		if (ALLSAplayerclass == "Druid") then
			classTabletoUse = attackTable.druid;
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_CRIT1, ALLSA_L_YOU1, 1);

			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT2, ALLSA_L_YOU, 2);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT3, ALLSA_L_YOU, 3);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT4, ALLSA_L_YOU, 4);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT5, ALLSA_L_YOU, 5);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT6, ALLSA_L_YOU, 6);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT7, ALLSA_L_YOU, 7);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT8, ALLSA_L_YOU, 8);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT9, ALLSA_L_YOU, 9);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT10, ALLSA_L_YOU, 10);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT11, ALLSA_L_YOU, 11);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT12, ALLSA_L_YOU, 12);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT13, ALLSA_L_YOU, 13);
			ALLSA_Parse0(event, arg1, ALLSA_ASHOT_DCRIT14, ALLSA_L_YOU, 14);
		end
end
	
function ALLSA_VARIABLES_LOADED()

	DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_VARIABLES);

		if (not ALLSA) then
			ALLSA = {};
		end
		if (not ALLSA.on) then
			ALLSA.on = ALLSAon_Default;	
		end
		if (not ALLSA.messageon) then
			ALLSA.messageon = ALLSAmessageon_Default;
		end
		if (not ALLSA.soundon) then
			ALLSA.soundon = ALLSAsoundon_Default;
		end
		if (not ALLSA.soundfile) then
			ALLSA.soundfile = ALLSAsoundfile_Default;
		end
		if (not attackTable) then
			attackTable = {};
		end

		if (ALLSAplayerclass == "Hunter") then
			ALLSA_LOAD_HUNTER();
		end
		if (ALLSAplayerclass == "Warlock") then
			ALLSA_LOAD_WARLOCK();
		end
		if (ALLSAplayerclass == "Paladin") then
			ALLSA_LOAD_PALADIN();
		end
		if (ALLSAplayerclass == "Priest") then
			ALLSA_LOAD_PRIEST();
		end
		if (ALLSAplayerclass == "Mage") then
			ALLSA_LOAD_MAGE();
		end
		if (ALLSAplayerclass == "Rogue") then
			ALLSA_LOAD_ROGUE();
		end
		if (ALLSAplayerclass == "Warrior") then
			ALLSA_LOAD_WARRIOR();
		end
		if (ALLSAplayerclass == "Shaman") then
			ALLSA_LOAD_SHAMAN();
		end
		if (ALLSAplayerclass == "Druid") then
			ALLSA_LOAD_DRUID();
		end

	ALLSA_variablesLoaded = true;

end

-- defining hunter tables ---

function ALLSA_LOAD_HUNTER()
		if (not attackTable.hunter) then
			attackTable.hunter = {};
		end
			if (not attackTable.hunter[1]) then
			attackTable.hunter[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[2]) then
			attackTable.hunter[2] = {
				name = "Aimed Shot",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[3]) then
			attackTable.hunter[3] = {
				name = "Multi Shot",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[4]) then
			attackTable.hunter[4] = {
				name = "Auto Shot",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[5]) then
			attackTable.hunter[5] = {
				name = "Wing Clip",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[6]) then
			attackTable.hunter[6] = {
				name = "Arcane Shot",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[7]) then
			attackTable.hunter[7] = {
				name = "Counterattack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[8]) then
			attackTable.hunter[8] = {
				name = "Mongoose Bite",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.hunter[9]) then
			attackTable.hunter[9] = {
				name = "Raptor Strike",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining warlock tables ---

function ALLSA_LOAD_WARLOCK()
		if (not attackTable.warlock) then
			attackTable.warlock = {};
		end
			if (not attackTable.warlock[1]) then
			attackTable.warlock[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warlock[2]) then
			attackTable.warlock[2] = {
				name = "Shadow Bolt",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warlock[3]) then
			attackTable.warlock[3] = {
				name = "Shadowburn",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warlock[4]) then
			attackTable.warlock[4] = {
				name = "Searing Pain",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warlock[5]) then
			attackTable.warlock[5] = {
				name = "Soul Fire",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warlock[6]) then
			attackTable.warlock[6] = {
				name = "Death Coil",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warlock[7]) then
			attackTable.warlock[7] = {
				name = "Conflagrate",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warlock[8]) then
			attackTable.warlock[8] = {
				name = "Immolate",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining paladin tables ---

function ALLSA_LOAD_PALADIN()
		if (not attackTable.paladin) then
			attackTable.paladin = {};
		end
			if (not attackTable.paladin[1]) then
			attackTable.paladin[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.paladin[2]) then
			attackTable.paladin[2] = {
				name = "Judgement",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.paladin[3]) then
			attackTable.paladin[3] = {
				name = "Holy Shock",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.paladin[4]) then
			attackTable.paladin[4] = {
				name = "Exorcism",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.paladin[5]) then
			attackTable.paladin[5] = {
				name = "Holy Wrath",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.paladin[6]) then
			attackTable.paladin[6] = {
				name = "Hammer of Wrath",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining priest tables ---

function ALLSA_LOAD_PRIEST()

		if (not attackTable.priest) then
			attackTable.priest = {};
		end
			if (not attackTable.priest[1]) then
			attackTable.priest[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[2]) then
			attackTable.priest[2] = {
				name = "Smite",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[3]) then
			attackTable.priest[3] = {
				name = "Mind Blast",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[4]) then
			attackTable.priest[4] = {
				name = "Holy Fire",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[5]) then
			attackTable.priest[5] = {
				name = "Mind Flay",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[6]) then
			attackTable.priest[6] = {
				name = "Shadow Word: Pain",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[7]) then
			attackTable.priest[7] = {
				name = "Starshards",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[8]) then
			attackTable.priest[8] = {
				name = "Vampiric Embrace",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.priest[9]) then
			attackTable.priest[9] = {
				name = "Holy Nova",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining mage tables ---

function ALLSA_LOAD_MAGE()	
		if (not attackTable.mage) then
			attackTable.mage = {};
		end
			if (not attackTable.mage[1]) then
			attackTable.mage[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[2]) then
			attackTable.mage[2] = {
				name = "Frost Bolt",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[3]) then
			attackTable.mage[3] = {
				name = "Arcane Explosion",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[4]) then
			attackTable.mage[4] = {
				name = "Arcane Missiles",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[5]) then
			attackTable.mage[5] = {
				name = "Fireball",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[6]) then
			attackTable.mage[6] = {
				name = "Fire Blast",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[7]) then
			attackTable.mage[7] = {
				name = "Pyroblast",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[8]) then
			attackTable.mage[8] = {
				name = "Flamestrike",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[9]) then
			attackTable.mage[9] = {
				name = "Cone of Cold",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.mage[10]) then
			attackTable.mage[10] = {
				name = "Frost Nova",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining rogue tables ---

function ALLSA_LOAD_ROGUE()
		if (not attackTable.rogue) then
			attackTable.rogue = {};
		end
			if (not attackTable.rogue[1]) then
			attackTable.rogue[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[2]) then
			attackTable.rogue[2] = {
				name = "Eviscerate",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[3]) then
			attackTable.rogue[3] = {
				name = "Backstab",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[4]) then
			attackTable.rogue[4] = {
				name = "Slice and Dice",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[5]) then
			attackTable.rogue[5] = {
				name = "Kidney Shot",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[6]) then
			attackTable.rogue[6] = {
				name = "Gouge",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[7]) then
			attackTable.rogue[7] = {
				name = "Sinister Strike",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[8]) then
			attackTable.rogue[8] = {
				name = "Riposte",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[9]) then
			attackTable.rogue[9] = {
				name = "Kick",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[10]) then
			attackTable.rogue[10] = {
				name = "Ghostly Strike",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[11]) then
			attackTable.rogue[11] = {
				name = "Ambush",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[12]) then
			attackTable.rogue[12] = {
				name = "Rupture",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.rogue[13]) then
			attackTable.rogue[13] = {
				name = "Cheap Shot",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining warrior tables ---

function ALLSA_LOAD_WARRIOR()
		if (not attackTable.warrior) then
			attackTable.warrior = {};
		end
			if (not attackTable.warrior[1]) then
			attackTable.warrior[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[2]) then
			attackTable.warrior[2] = {
				name = "Cleave",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[3]) then
			attackTable.warrior[3] = {
				name = "Execute",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[4]) then
			attackTable.warrior[4] = {
				name = "Slam",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[5]) then
			attackTable.warrior[5] = {
				name = "Bloodthirst",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[6]) then
			attackTable.warrior[6] = {
				name = "Heroic Strike",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[7]) then
			attackTable.warrior[7] = {
				name = "Rend",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[8]) then
			attackTable.warrior[8] = {
				name = "Overpower",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[9]) then
			attackTable.warrior[9] = {
				name = "Deep Wounds",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[10]) then
			attackTable.warrior[10] = {
				name = "Mortal Strike",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.warrior[11]) then
			attackTable.warrior[11] = {
				name = "Shield Slam",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining shaman tables ---

function ALLSA_LOAD_SHAMAN()
		if (not attackTable.shaman) then
			attackTable.shaman = {};
		end
			if (not attackTable.shaman[1]) then
			attackTable.shaman[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.shaman[2]) then
			attackTable.shaman[2] = {
				name = "Lightning Bolt",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.shaman[3]) then
			attackTable.shaman[3] = {
				name = "Earth Shock",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.shaman[4]) then
			attackTable.shaman[4] = {
				name = "Frost Shock",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.shaman[5]) then
			attackTable.shaman[5] = {
				name = "Flame Shock",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.shaman[6]) then
			attackTable.shaman[6] = {
				name = "Chain Lightning",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

-- defining druid tables ---

function ALLSA_LOAD_DRUID()
		if (not attackTable.druid) then
			attackTable.druid = {};
		end
			if (not attackTable.druid[1]) then
			attackTable.druid[1] = {
				name = "attack",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[2]) then
			attackTable.druid[2] = {
				name = "Maul",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[3]) then
			attackTable.druid[3] = {
				name = "Bash",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[4]) then
			attackTable.druid[4] = {
				name = "Swipe",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[15]) then
			attackTable.druid[5] = {
				name = "Claw",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[6]) then
			attackTable.druid[6] = {
				name = "Rip",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[7]) then
			attackTable.druid[7] = {
				name = "Shred",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[8]) then
			attackTable.druid[8] = {
				name = "Rake",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[9]) then
			attackTable.druid[9] = {
				name = "Ferocious Bite",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[10]) then
			attackTable.druid[10] = {
				name = "Ravage",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[11]) then
			attackTable.druid[11] = {
				name = "Pounce",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[12]) then
			attackTable.druid[12] = {
				name = "Wrath",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[13]) then
			attackTable.druid[13] = {
				name = "Moonfire",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
			if (not attackTable.druid[14]) then
			attackTable.druid[14] = {
				name = "Starfire",
				recordDamage = "0",
				recordTarget = "target"
				};
			end
		DEFAULT_CHAT_FRAME:AddMessage('ALLSA Running for class: |cffff0000' .. ALLSAplayerclass );
end

function ALLSA_Parse0(event, arg1, stringDetails, playerPrefix, tableIndex)

	if (not arg1) then
		return;
	end
	tableIndex2 = tableIndex;

	------
	-- Begin processing chat events
	------

	if (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		if (ALLSAplayerclass == "Hunter" and tableIndex == 3) then
				local _,_,unitName,junk,targetName,damageNew = string.find(arg1, stringDetails)
					if (unitName ~= playerPrefix) then
						return;
					end
				ALLSA_Alert(targetName,damageNew,tableIndex2);
				return; 
		else
				local _,_,unitName,targetName,damageNew = string.find(arg1, stringDetails)
					if (unitName ~= playerPrefix) then
						return;
					end
				ALLSA_Alert(targetName,damageNew,tableIndex2);
				return;
		end
	end
end

function ALLSA_Alert(targetName,damageNew,tableIndex2)
	if ( ALLSA.on == 1 ) then

			tableIndex3 = tonumber(tableIndex2);
			damOld = tostring(classTabletoUse[tableIndex3].recordDamage);

		if ( ALLSA.soundon == 1 ) then
			if ( ALLSA.soundfile == 0 ) then
			PlaySoundFile("Interface\\AddOns\\AllShotAlert\\Sounds\\allsa.wav");
			end
			if ( ALLSA.soundfile == 1 ) then
			PlaySoundFile("Interface\\AddOns\\AllShotAlert\\Sounds\\headshot.wav");
			end
		end
		if ( ALLSA.messageon == 1 ) then
			ALLSAlertMessageFrame:AddMessage("Your "..tostring(classTabletoUse[tableIndex3].name).." crits "..targetName.."\n for "..tostring(damageNew).."!", 1, 1, 1, 1, 2);
			if ( damageNew > damOld ) then
				classTabletoUse[tableIndex3].recordDamage = tostring(damageNew);
				classTabletoUse[tableIndex3].recordTarget = tostring(targetName);
				DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_NEWRECORD);
			end
		end
	end
end

function ALLSA_Show_Record()

	x = table.getn(classTabletoUse);
	for y = 1,x do
		DEFAULT_CHAT_FRAME:AddMessage("|cffffffffRecord |cff628296"..tostring(classTabletoUse[y].name).."|cffffffff damage was |cffff0000"..tostring(classTabletoUse[y].recordDamage).."|cffffffff against |cff628296"..tostring(classTabletoUse[y].recordTarget).."|cffffffff.");
	end

end

function ALLSA_Reset()

	DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_RESET);

	zzz = table.getn(classTabletoUse);

	for y = 1,zzz do
		table.remove(classTabletoUse);
	end

	table.setn(classTabletoUse, zzz);

	local ALLSAplayerclass = UnitClass("player");
	ALLSA_variablesLoaded = false;

		if (ALLSAplayerclass == "Hunter") then
			ALLSA_LOAD_HUNTER();
		end
		if (ALLSAplayerclass == "Warlock") then
			ALLSA_LOAD_WARLOCK();
		end
		if (ALLSAplayerclass == "Paladin") then
			ALLSA_LOAD_PALADIN();
		end
		if (ALLSAplayerclass == "Priest") then
			ALLSA_LOAD_PRIEST();
		end
		if (ALLSAplayerclass == "Mage") then
			ALLSA_LOAD_MAGE();
		end
		if (ALLSAplayerclass == "Rogue") then
			ALLSA_LOAD_ROGUE();
		end
		if (ALLSAplayerclass == "Warrior") then
			ALLSA_LOAD_WARRIOR();
		end
		if (ALLSAplayerclass == "Shaman") then
			ALLSA_LOAD_SHAMAN();
		end
		if (ALLSAplayerclass == "Druid") then
			ALLSA_LOAD_DRUID();
		end

end

function ALLSA_OnOff()
	if ( ALLSA.on == 0 ) then
		ALLSA.on = 1;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_STON);
	else
		ALLSA.on = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_ALLSA_STOFF);
	end
end

function ALLSA_SoundOnOff()
	if ( ALLSA.soundon == 0 ) then
		ALLSA.soundon = 1;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUND_STON);
	else
		ALLSA.soundon = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUND_STOFF);
	end
end

function ALLSA_SoundSwap()
	if ( ALLSA.soundfile == 0 ) then
		ALLSA.soundfile = 1;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUNDFILE_1);
	else
		ALLSA.soundfile = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_SOUNDFILE_0);
	end
end

function ALLSA_MessageOnOff()
	if ( ALLSA.messageon == 0 ) then
		ALLSA.messageon = 1;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_MESSAGE_STON);
	else
		ALLSA.messageon = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ALLSA_TEXT_MESSAGE_STOFF);
	end
end
