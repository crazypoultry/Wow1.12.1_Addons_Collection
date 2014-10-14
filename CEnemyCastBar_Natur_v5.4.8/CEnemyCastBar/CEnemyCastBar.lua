--[[ 

Natur EnemyCastBar

Revision History:
-----------------
.
. Deleted the original History to achive some less scrolling! Sorry Limited ;-)
. This mod was mainly coded by "Limited" - I, Naturfreund, added all codes after Limited's version Carnival Enemy Cast Bar 1.5c
.

=================================
Read Changelog.txt for more info!
=================================

Info for Burning Crusade version (+search for "--BC" here):
string.gfind was renamed string.gmatch;
math.mod was renamed math.fmod; You can now use % as the modulus operator. eg. print (19 % 4)  --> 3 (math.mod)
table.getn -> #table -> table.maxn or select("#", ...); print (#"Nick Gammon") --> 11; t = { 1, 2, 3 }; print (#t) --> 3
string.find may be replaced by string.match in three lines (search for "local _,_,")

Change gcinfo use collectgarbage("count"); lines prepared for testing, s. other textfile for new GC commands (evtl. "setstepmul 10000" + "collect" beim öffnen, beim schließen wieder auf 200 setzen :D)
Change "necb cast spell" function; solution presented in function and change "help" MIGHT still work anyway? Test it.
Search for "--["" in spells (BC).

Many new Events/Functions will be added to recognize spell casting of Units! s. Ablage!
New Player focus UnitName("focus") parallel zu UnitName("target")?
]]--

CECB_status_version_txt = "5.4.8";

function CEnemyCastBar_DefaultVars()

		CEnemyCastBar = { };
		CEnemyCastBar.bStatus = true;
		CEnemyCastBar.bPvP = true;
		CEnemyCastBar.bPvE = true;
		CEnemyCastBar.bLocked = true;
		CEnemyCastBar.bTimer = true;
		CEnemyCastBar.bScale = 1;
		CEnemyCastBar.bAlpha = 1;
		CEnemyCastBar.bShowafflict = true;
		CEnemyCastBar.bTargetM = true;
		CEnemyCastBar.bCDown = false;
		CEnemyCastBar.bAfflictuni = false;
		CEnemyCastBar.bNumBars = 15;
		-- new variables for new versions (check onload variables!)
		CEnemyCastBar.bParseC = true;
		CEnemyCastBar.bGains = true;
		CEnemyCastBar.bFlipB = false;
		CEnemyCastBar.bSmallTSize = false;
		CEnemyCastBar.bFlashit = true;
		CEnemyCastBar.bGlobalFrag = true;
		CEnemyCastBar.bCDownShort = false;
		CEnemyCastBar.bBCaster = false;
		CEnemyCastBar.bSoloD = false;
		CEnemyCastBar.bSpace = 20;
		CEnemyCastBar.bDRTimer = false;
		CEnemyCastBar.bMageC = false;
		CEnemyCastBar.bMiniMap = 356;
		CEnemyCastBar.bClassDR = false;
		CEnemyCastBar.bShowIcon = true;
		CEnemyCastBar.bSDoTs = false;
		CEnemyCastBar_SetBarColors();
		CEnemyCastBar.bGlobalPvP = false;
		CEnemyCastBar.bnecbCBLBias = 0;
		CEnemyCastBar.bPvEWarn = false;
		CEnemyCastBar.bGainsOnly = false;
		CEnemyCastBar.bTempFPSBar = false;
		CEnemyCastBar.bThrottle = 0.05;
		CEnemyCastBar.bSpellBreakLight = true;
		CEnemyCastBar.bDisableInterrupt = nil; -- currently not an option, set manually!
		CEnemyCastBar.bUseCDDB = false;

end

function CEnemyCastBar_SetBarColors(msg)

		--initialize colors
		cecbcolors = {"Hostile", "Friendly", "Cooldown", "Gains", "Grey", "Afflict", "Stuns", "Cursetype"};

		if (msg == "SetColors") then
			local i = 1
			while (CEnemyCastBar.tColor[i]) do
				getglobal("CECBPickColorOptions_"..cecbcolors[i].."NormalTexture"):SetVertexColor(CEnemyCastBar.tColor[i][1], CEnemyCastBar.tColor[i][2], CEnemyCastBar.tColor[i][3]);

				for j=1, 3 do
					getglobal("CECBPickColorOptions_"..cecbcolors[i])[j] = CEnemyCastBar.tColor[i][j];
				end
			i = i + 1;
			end

		else
			--default colors
			CEnemyCastBar.tColor = {
				{ 1, 0 ,0 },		--Hostile
				{ 0, 1 ,0 },		--Friendly
				{ 0, 0 ,1 },		--Cooldown
	 			{ 1, 0 ,1 },		--Gains
				{ 0.8, 0.8, 0.8 },	--Grey
				{ 0.8, 0.8, 0 },   	--Afflict						
				{ 0.5, 0.2, 0.1 },	--Stuns, also in 'Variables Loaded'!
				{ 0, 0.8, 0.8 },	--DoTs
			}
		end
end

function CEnemyCastBar_RegisterEvents(unregister)

	local eventpacket = {	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
				"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
				"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
				"CHAT_MSG_SPELL_PARTY_DAMAGE", "CHAT_MSG_SPELL_PARTY_BUFF", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
				"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",
				"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
				"CHAT_MSG_SPELL_BREAK_AURA", "CHAT_MSG_SPELL_AURA_GONE_OTHER", "CHAT_MSG_SPELL_AURA_GONE_SELF", "CHAT_MSG_SPELL_AURA_GONE_PARTY",
				"PLAYER_TARGET_CHANGED",
				"CHAT_MSG_MONSTER_YELL", "CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_RAID", "CHAT_MSG_PARTY", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_ADDON",
				"CHAT_MSG_COMBAT_HOSTILE_DEATH", "CHAT_MSG_COMBAT_FRIENDLY_DEATH", "CHAT_MSG_COMBAT_XP_GAIN",
				"PLAYER_REGEN_DISABLED", "CHAT_MSG_SPELL_SELF_DAMAGE", "PLAYER_COMBO_POINTS", "CHAT_MSG_SPELL_FAILED_LOCALPLAYER"};
			--	"CHAT_MSG_SPELL_SELF_BUFF", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "CHAT_MSG_COMBAT_SELF_HITS" -- for testing only
				--CarniEnemyCastBarFrame:RegisterEvent("CHAT_MSG_CHANNEL"); -- (register for debugging)
				--BC add "UNIT_SPELLCAST_DELAYED"
	local i = 1;

	while (eventpacket[i]) do

		if (unregister) then
			CarniEnemyCastBarFrame:UnregisterEvent(eventpacket[i]);
		else
			CarniEnemyCastBarFrame:RegisterEvent(eventpacket[i]);
		end

		i = i + 1;
	end

	--CarniEnemyCastBarFrame:RegisterAllEvents(); --for debug purposes

	if (CEnemyCastBar.bDebug) then
		i = i - 1;
		if (unregister) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, |cffff0000"..i.." GameEvents UNRegistered!");
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, |cff00ff00"..i.." GameEvents Registered!");
		end
	end

end

function CEnemyCastBar_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	
	SLASH_CARNIVALENEMYCASTBAR1 = "/necb";  
	SlashCmdList["CARNIVALENEMYCASTBAR"] = function(msg)
		CEnemyCastBar_Handler(msg);
	end

end

function CEnemyCastBar_OnEvent(event) --onevent

	--[[if (not arg1) then
		arg1 = "";
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, Gfind: "..arg1.." (event: |cffffff00"..event.."|r)"); --!
	]]-- for debug purposes

	if (event == "PLAYER_COMBO_POINTS") then

		if(CECBownCPsLast and GetComboPoints() < CECBownCPsLast) then

			CECBownCPsHit = CECBownCPsLast;
			CECBownCPsHitTime = GetTime();

			-- check if there was a finishing move right before you lost all CPs (the server might create a difference up to 500ms between those two events!)
			--CECBownCPsHitBuffer = {mob, spell, GetTime(), DRTimer }; -- just to understand what 1,2,3,4 stands for; defined in 'control' function (affliction)^
			if (CECBownCPsHitBuffer and (CECBownCPsHitTime - CECBownCPsHitBuffer[3]) < 1) then

				local CPSpell = CECBownCPsHitBuffer[2];
				castime = CEnemyCastBar_Afflictions[CPSpell].t - (CEnemyCastBar_Afflictions[CPSpell].cpinterval * (5 - CECBownCPsHit));

				local CPDRTimer = CECBownCPsHitBuffer[4];
				if (CPDRTimer == 4 or CPDRTimer == 6) then
					castime = castime / (CPDRTimer - 2);
				end

				CEnemyCastBar_UniqueCheck(CPSpell, castime - (CECBownCPsHitTime - CECBownCPsHitBuffer[3]), CECBownCPsHitBuffer[1], "trueupdate"); --update bar duration
				CECBownCPsHitTime = nil; -- spell already updated no need to wait 3 secs for new afflictions
			end
		end
		CECBownCPsLast = GetComboPoints();
		CECBownCPsHitBuffer = nil;

	elseif (event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER") then

		if (NECBCustomCasted) then 
			NECBCustomCasted = nil;
		end

	--[[--BC add this to detect casttime delays; might cause update trouble with debuffs that have the same name; much to check out! possibly deregister event if PvP disabled or Onlygains enabled
	elseif (event == "UNIT_SPELLCAST_DELAYED") then
		if (arg1 == "target") then
			local UCI_spell, _, _, _, UCI_startTime, UCI_endTime = UnitCastingInfo("target");
			if (CEnemyCastBar_Spells[UCI_spell]) then
				CEnemyCastBar_UniqueCheck(UCI_spell, UCI_endTime, UnitName("target"), "trueupdate", "delay");
				--BC changes made to unique function to support this
			end
		end
	]]

	elseif (event == "CHAT_MSG_MONSTER_YELL") then
	
		CEnemyCastBar_Yells(arg1, arg2);

	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
	
		CEnemyCastBar_Emotes(arg1, arg2);

	elseif (event == "PLAYER_LEAVING_WORLD" and CEnemyCastBar.bStatus) then

		CEnemyCastBar_RegisterEvents("unregister");

	elseif (event == "PLAYER_ENTERING_WORLD" and CEnemyCastBar.bStatus) then

		CEnemyCastBar_RegisterEvents();
		if ( not necbdisabledyell and CEnemyCastBar.tDisabledSpells and table.getn(CEnemyCastBar.tDisabledSpells) > 0 ) then
			CEnemyCastBar_Handler("disabled");
			necbdisabledyell = true;
		end

		-- check for loaded localized code and warn if unknown client language
		if (NECB_client_unknown) then
			UIErrorsFrame:AddMessage("Your client language is not beeing supported by NECB!", 1, 1, 1, 1, 5);
			PlaySoundFile("Sound\\Spells\\PVPFlagTakenHorde.wav");
			NECB_client_unknown = nil;
		else
			NECB_client_known = nil;
		end

	elseif (event == "PLAYER_REGEN_DISABLED" and CEnemyCastBar.bPvE) then

		CEnemyCastBar_Player_Enter_Combat();

	elseif (event == "PLAYER_TARGET_CHANGED" and CEnemyCastBar.bCDown and CEnemyCastBar.bUseCDDB) then

		CEnemyCastBar_Player_Target_Changed();

	elseif (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER") then

		CEnemyCastBar_Parse_RaidChat(arg1, arg2, "Raid");

	elseif (event == "CHAT_MSG_PARTY") then

		CEnemyCastBar_Parse_RaidChat(arg1, arg2, "Party");

	elseif (event == "CHAT_MSG_ADDON") then
	
		if (string.sub(arg1, 1, 4) == "NECB") then

			-- necb network infos + calls the parse function: CEnemyCastBar_Parse_RaidChat(arg2, arg4, arg1="NECB, NECBCHAT, NECBCTRA");

			local msg = arg2;
			local msgsender = arg4;

			local necbcmdcheck, necbtcolor = CEnemyCastBar_Parse_RaidChat(msg, msgsender, arg1); -- calls the parse function!
			if (not necbtcolor) then
				necbtcolor = "|cffcccccc";
			end
			if (necbcmdcheck) then

				if ( ParserCollect[100] ) then
					table.remove (ParserCollect, 1);
				end

				local startpos;
				if (string.sub (msg, 1, 11) == ".cecbspell ") then
					startpos = 12;
					if (numspellcast == 99) then
						numspellcast = 0;
						numsender = " (|cffffffffS|cffffaaaa):";
					elseif (wrongclient) then
						numsender = " (|cffccccccC|cffffaaaa):";
					elseif (numspellcast > 0 and msgsender ~= UnitName("player")) then
						numsender = " (|cffffff00"..numspellcast.."|cffffaaaa):";
					else
						numsender = ":";
					end

				elseif (string.sub (msg, 1, 7) == "<NECB> ") then
					startpos = 8;
					numsender = ":";
					
				else
					startpos = 1;
					numsender = ":";
				end

				-- reduce length of line
				local i, cropped = 0, "";
				CECBParserFauxText:SetText("|cffffaaaa"..msgsender..numsender.." |cffcccccc"..string.sub (msg, startpos, string.len (msg)));
				if(necbprint2combat and ChatFrame2) then
					ChatFrame2:AddMessage("|cffaaaaaaNECB: [ |cffffaaaa"..msgsender..numsender.." "..necbtcolor..string.sub (msg, startpos, string.len (msg)) .."|cffaaaaaa ]");
				end
				while (CECBParserFauxText:GetStringWidth() > 410) do
					i = i + 1;
					CECBParserFauxText:SetText("|cffffaaaa"..msgsender..numsender.." |cffcccccc"..string.sub (msg, startpos, string.len (msg) -i));
				end

				if (i ~= 0) then
					cropped = "|cffffaaaa...";
				else
					cropped = "";
				end

				table.insert (ParserCollect, "|cffffaaaa"..msgsender..numsender.." "..necbtcolor..string.sub (msg, startpos, string.len (msg) -i)..cropped);

				if (CECBParser) then
					if (parserline == 0) then
						CEnemyCastBar_ParserOnClick();
					else
						CECBCTRAParserFrameBOTTOMArrowFlash:Show();
						CEnemyCastBar_ParserOnClick("up");
					end
				end

			end
		end

	elseif ( event == "VARIABLES_LOADED" ) then

		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffffffff AddOn loaded. Use |cff00ff00/necb|cffffffff to configure.");
		VersionDB = { };
		VersionNames = { };
		ParserCollect = { };
		NECBtchangeSource = { };
		DisabledSpells = { };
		NECB_CD_DB = { };

		if ( not CEnemyCastBar ) then
			CEnemyCastBar_DefaultVars();
		end

		-- my addons support, used for helpframe, too!

			CEnemyCastBarHelp = {}; 
			CEnemyCastBarHelp[1] = "|cff00ff00/necb |cffffffff- Toggles the options window.";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb |cffff0000clear |cffffffff- Removes all castbars from screen";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb |cffff0000gcinfo |cffffffff- Display memory usage of all addons";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb |cffff0000versions |cffffffffor |cff00ff00gversions |cffffffff- Show Group/GuildMembers NECB versions.";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb |cffff0000parser |cffffffff- Opens the NECB - AddOn Channel parser.";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb |cffff0000chat |cff00ff00Text |cffffffff- Sends 'Text' to other NECB's in your group.";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb |cffff0000cooldowns |cffffffff- Displays all Cooldowns currently in Database.";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb |cffff0000setrange |cffffff99allmax/cmax |cffffffff- Adjusts the CombatLogRange! |cffffff99allmax|r = set all Ranges to max, |cffffff99cmax|r = only creature messages maxed, |cffffff99leave blank|r = defaults.";

			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n\n".."|cff00ff00/necb |cffff0000cast|cff00ff00 Spell |cffffffff- Use in macros to 1. Cast the spell and 2. Show a CastBar without waiting for any combatlog message!";
			--After BC use this and clear above and below:
			--CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n\n".."|cff00ff00/necb |cffff0000cast|cff00ff00 Spell |cffffffff- Macro that won't trigger a Bar on most errors: \n|cff99ffff /script NECBCustomCasted = true; \n /cast Spell \n /necb cast Spell\n|cffffffff to renew DoT/HoT Bars almost correctly w/o combatlog!";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cffffffffThis allows you to renew DoTs/HoTs before they run out!";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb deletebar Label |cffffffff- Deletes ALL CBs which inherit 'Label' and match your targets name! Try |cff00ff00/cast |cffffff99DoT-HoT-Name|cffffffff after it.";
			CEnemyCastBarHelp[1] = CEnemyCastBarHelp[1].."\n".."|cff00ff00/necb showbar Spell |cfffffffftriggers a bar for your current target. (Some rules!)\n\n";

			CEnemyCastBarHelp[2] = "|cff00ff00/necb |cffff0000countsec|cff00ff00 sss Label |cffffffff- Starts a countdown of sss seconds";
			CEnemyCastBarHelp[2] = CEnemyCastBarHelp[2].."\n".."|cff00ff00/necb countmin mmm Label |cffffffff- Starts a countdown of mmm minutes";
			CEnemyCastBarHelp[2] = CEnemyCastBarHelp[2].."\n".."|cff00ff00/necb repeat sss Label |cffffffff- Repeated countdown of sss seconds";
			CEnemyCastBarHelp[2] = CEnemyCastBarHelp[2].."\n".."|cff00ff00/necb stopcount Label |cffffffff- Stops all grey CastBars which inherit 'label'";
			CEnemyCastBarHelp[2] = CEnemyCastBarHelp[2].."\n".."|cffffffffYou may also try |cffff0000.|cff00ff00countsec|cffffffff, |cff00ff00.countmin|cffffffff, |cff00ff00.stopcount|cffffffff.";
			CEnemyCastBarHelp[2] = CEnemyCastBarHelp[2].."\n".."|cffffff99Example: |cffffffffType |cff00ff00.countsec |cffffff9910 Ten Seconds|cffffffff into the raid-channel. Everyone in your Raid with NECB and enabled Channel-Parsing will see the bar!";
			CEnemyCastBarHelp[2] = CEnemyCastBarHelp[2].."\n".."|cffff0000/script NECB_SendMessage(\"|cffffff99.countmin 15 Nefe respawn|cffff0000\"); |cffffffffwill trigger a bar for all your group members in a |cffcccccc'silent'|cffffffff way!";
			CEnemyCastBarHelp[2] = CEnemyCastBarHelp[2].."\n\n".."|cffff0000SHIFT + LeftClick |cffffffffdeletes the bar, |cffff0000ALT + click |cffffffffdeletes all bars\n";

			CEnemyCastBarHelp[3] = "|cffff0000SHIFT + RightClick |cffffffffdisables the Spell for the rest of your session!";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n".."|cff00ff00/necb disabled |cfffffffflists disabled spells.";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n".."|cff00ff00/necb restore |cffffffffrestores ALL disabled spells!";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n".."|cff00ff00/necb load |cffffffffloads disabled spells.";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n".."|cff00ff00/necb save |cffffffffsaves disabled spells. Settings reloaded after every login!";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n".."|cff00ff00/necb remove xyz or No. |cffffffffremoves xyz from the list of disabled spells!";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n".."|cff00ff00/necb add xyz |cffffffffadds spell xyz to the list of disabled spells!";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n\n".."|cff00ff00/necb |cffff0000forcebc|cff00ff00 Raidmember |cffffffffwill force '|cffffff99Raidmember|cffffffff' to broadcast CastBars by changing his/her settings!";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n".."|cff00ff00/necb stopbc Raidmember |cffffffffstops broadcasting CBs!\n|cffffff99Hint:|cffffffff Instead of using 'raidmember' you may simply target the player.\nBoth, force and stop, require 'leader' or 'promoted'!";
			CEnemyCastBarHelp[3] = CEnemyCastBarHelp[3].."\n\n".."|cffff0000=> |cffffffffOpen 'Changelog.txt' (addon's folder) for more detailed description.";

		if (myAddOnsFrame_Register) then

			CEnemyCastBarDetails = { 
				name = "CEnemyCastBar", 
				version = CECB_status_version_txt, 
				releaseDate = "2006", 
				author = "Naturfreund", 
				email = "Use my forum or curse-gaming.com", 
				website = "http://www.digital-joker.de/forum", 
				category = MYADDONS_CATEGORY_COMBAT
				};

			myAddOnsFrame_Register(CEnemyCastBarDetails, CEnemyCastBarHelp); 
		end 
                
		-- new variables for new versions
		if (CEnemyCastBar.bParseC == nil) then
			CEnemyCastBar.bParseC = true;
		end
		if (CEnemyCastBar.bGains == nil) then
			CEnemyCastBar.bGains = true;
		end
		if (CEnemyCastBar.bFlashit == nil) then
			CEnemyCastBar.bFlashit = true;
		end
		if (CEnemyCastBar.bGlobalFrag == nil) then
			CEnemyCastBar.bGlobalFrag = true;
		end
		if (CEnemyCastBar.bSpace == nil) then
			CEnemyCastBar.bSpace = 20;
		end
		if (CEnemyCastBar.bMiniMap == nil) then
			CEnemyCastBar.bMiniMap = 360;
		end
		if (CEnemyCastBar.bShowIcon == nil) then
			CEnemyCastBar.bShowIcon = true;
		end
		if (CEnemyCastBar.bnecbCBLBias == nil) then
			CEnemyCastBar.bnecbCBLBias = 0;
		end
		if (CEnemyCastBar.bThrottle == nil) then
			CEnemyCastBar.bThrottle = 0.05;
		end

		if (CEnemyCastBar.bSpellBreakLight == nil) then
			CEnemyCastBar.bSpellBreakLight = true;
		end

		if ( CEnemyCastBar.tDisabledSpells and table.getn(CEnemyCastBar.tDisabledSpells) > 0 ) then
			CEnemyCastBar_LoadDisabledSpells("mute");
		else
			CEnemyCastBar.tDisabledSpells = { };
		end

		if (CEnemyCastBar.tColor == nil) then
			CEnemyCastBar_SetBarColors();
		elseif (CEnemyCastBar.tColor[8] == nil) then
			table.insert(CEnemyCastBar.tColor, 7, { 0.5, 0.2, 0.1 } );
		end

		if (CEnemyCastBar.bTempFPSBar) then
			CECB_FPSBarFree:Show();
		end

		CEnemyCastBar.bLocked = true; -- remove if lock-option is inserted again
		CEnemyCastBar.bDebug = false; -- same here
		CEnemyCastBar_FlipBars();
		CEnemyCastBar_SetTextSize();
		CECBownCPsHit = 5; -- Set Combopoints to max for all classes, Rogue/DruidClass will fire an event to change this dynamically

		-- setpos of Minimap button
		if (CEnemyCastBar.bMiniMap == 0) then
			CECBMiniMapButton:Hide();
		else
			CECBMiniMapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(CEnemyCastBar.bMiniMap)), (80 * sin(CEnemyCastBar.bMiniMap)) - 52);
			CECBMiniMapButton:Show();
		end

 		-- variables for the addon channel parser
		numspellcast = 0; parserline = 0;
		for i=1, 85 do
			table.insert (ParserCollect, "|cffcccccc- |cff666666"..i.."|cffcccccc -");
		end
		table.insert (ParserCollect, " ");
		table.insert (ParserCollect, "|r==================================");
		table.insert (ParserCollect, "|cffffff00Welcome to the NECB AddOn Channel Parser!");
		table.insert (ParserCollect, "This parser displays all NECB commands/broadcasts received by your client.");
		table.insert (ParserCollect, " ");
		table.insert (ParserCollect, "It follows this pattern:");
		table.insert (ParserCollect, "|cffffaaaaBroadcaster: |cffccccccDetected AddOn Message [, ClientLanguage, Latency]|cffffff00");
		table.insert (ParserCollect, "|cffccccccgrey|cffffff00 = automatic message; |cffffffccbright yellow|cffffff00 = triggered by user input");
		table.insert (ParserCollect, "|cffffaaaa(|cffffffffS|cffffaaaa)|cffffff00 = Sender who triggered a castbar for you. |cffffaaaa(|cffccccccC|cffffaaaa)|cffffff00 = Wrong client!");
		table.insert (ParserCollect, "|cffffaaaa(|cffffff00n|cffffaaaa)|cffffff00 = n useless broadcasts of this spell event.|cffffff00");
		table.insert (ParserCollect, " ");
		table.insert (ParserCollect, "100 lines are buffered. Use up/down at topright to scroll the lines.");
		table.insert (ParserCollect, "I tried to make it work like the default chatframe :D");
		table.insert (ParserCollect, "|r==================================");
		table.insert (ParserCollect, " ");
		-- ctra parser finished

		necbEPTime = 180; -- Duration (in s) until the Engage Protection is shut off

	else

		CEnemyCastBar_Gfind(arg1, event);
	
	end
	
end

function CEnemyCastBar_FauxUpdater()

	if (necbengagedelay and GetTime() - necbengagedelay[2] > necbengagedelay[4]) then

		CEnemyCastBar_Player_Enter_Combat();
	end
end

function CEnemyCastBar_ParserOnClick(msg)

	if (msg) then
		if ((msg == "down" or msg == -1) and parserline < 0) then
			parserline = parserline + 1;
	
		elseif ((msg == "up"  or msg == 1) and parserline > -80) then
			parserline = parserline - 1;
	
		elseif (msg == 0) then
			parserline = 0;
			CECBCTRAParserFrameUPArrow:Enable();
		end

		if (parserline == -80) then
			CECBCTRAParserFrameUPArrow:Disable();
		elseif (parserline == 0) then
			CECBCTRAParserFrameDOWNArrow:Disable();
			CECBCTRAParserFrameBOTTOMArrow:Disable();
			CECBCTRAParserFrameBOTTOMArrowFlash:Hide();
		else
			CECBCTRAParserFrameUPArrow:Enable();
			CECBCTRAParserFrameDOWNArrow:Enable();
			CECBCTRAParserFrameBOTTOMArrow:Enable();
		end
	end

	CECBCTRAParserFrameLineText:SetText(parserline);
	local parserstring = table.concat (ParserCollect, "\n", 81 + parserline, 100 + parserline);
	CECBCTRAParserFrameBGText:SetText(parserstring);
	
end

function CEnemyCastBar_ParserButton_OnUpdate(elapsed)
	if (this:GetButtonState() == "PUSHED") then
		this.clickDelay = this.clickDelay - elapsed;
		if ( this.clickDelay < 0 ) then
			local name = this:GetName();
			if ( name == this:GetParent():GetName().."DOWNArrow" ) then
				CEnemyCastBar_ParserOnClick("down");
			elseif ( name == this:GetParent():GetName().."UPArrow" ) then
				CEnemyCastBar_ParserOnClick("up");
			end
			this.clickDelay = MESSAGE_SCROLLBUTTON_SCROLL_DELAY;
		end
	end
end

function CEnemyCastBar_TargetPlayer(num)

	if (CEnemyCastBar.bTargetM == true) then

		TargetByName(getglobal("Carni_ECB_"..num).mob);
		--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Targetting \""..getglobal("Carni_ECB_"..num).mob.."\"");

	end
	
end

function CEnemyCastBar_DelBar(msg) --delete castbar by label

	for i=1, CEnemyCastBar.bNumBars do
		local label = getglobal("Carni_ECB_"..i).label;
		if (label and string.find(label, msg) ) then
				CEnemyCastBar_HideBar(i);
		end
	end
end

function CEnemyCastBar_HideBar(num, shiftright, useradd) --hide + disable spells

	local button, fauxbutton;

	if (num) then
		button = getglobal("Carni_ECB_"..num);
		fauxbutton = getglobal("FauxTargetBtn"..num);
	end

	if (shiftright or useradd) then
		local disabled = false;
		local spell;

		if (useradd) then
			spell = useradd;
		else
			spell = button.spell;
			spell = string.gsub(spell, " %(D%)", "");
			if (spell ~= CECB_SPELL_FRENZY_CD) then
				spell = string.gsub(spell, " %(CD%)", "");
			end
		end

		if (spell ~= CECB_SPELL_STUN_DR and not string.find(spell, "DR:") ) then

			if (CEnemyCastBar_Raids[spell]) then
				CEnemyCastBar_Raids[spell].disabled = true;
				disabled = true;
			end
	
			if (CEnemyCastBar_Spells[spell]) then
				CEnemyCastBar_Spells[spell].disabled = true;
				disabled = true;
			end
	
			if (CEnemyCastBar_Afflictions[spell]) then
				CEnemyCastBar_Afflictions[spell].disabled = true;
				disabled = true;
			end
		end

		if (disabled) then
			local spellexists = false;
			for i=1, table.getn (DisabledSpells) do
				if (DisabledSpells[i] and DisabledSpells[i] == spell) then
					spellexists = true;
					break;
				end
			end

			if (spellexists) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffaaaa Spell is already disabled!");
			else
				table.insert (DisabledSpells, spell);
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Disabled \"|cffffff00"..spell.."|r\" (|cffffff00"..table.getn (DisabledSpells).."|r total) for this session.");
				if (not necbdisabledyell) then
					necbdisabledyell = true;
				end
			end
		else
			if (num and button.ctype == "grey" ) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |rManual timers are not allowed to disable spells!");
			else
				if (useradd) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffaaaa Entered Spell not found! |r(Spellname is case sensitive.)");
				else
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffaaaa Spell not found! |rMaybe it was a DR of some spell?");
				end
			end
		end
	end

	if (num) then
		fauxbutton:Hide();
		button:Hide();
		--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Deleted \""..button.label.."\"");
		button.spell = "";
		button.mob = "";
		button.ctype = "";
		button.label = "";
	end
	
end

function CEnemyCastBar_LockPos() --lockpos
	
	CEnemyCastBar.bLocked = not CEnemyCastBar.bLocked;
	
	if (CEnemyCastBar.bLocked) then
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
			frame:StopMovingOrSizing();
			frame:EnableMouse(0);
			fauxframe:EnableMouse(1);
			
		end

	else
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
			frame:EnableMouse(1);
			fauxframe:EnableMouse(0);
			
		end	

	end
	
end

function CEnemyCastBar_ResetPos() --resetpos

	local frame = getglobal("Carni_ECB_1");
	local fauxframe = getglobal("FauxTargetBtn1");
	frame:Hide();
	fauxframe:Hide();
	frame:ClearAllPoints();
	frame:SetPoint("TOPLEFT", "UIParent", 50, -500);

	CEnemyCastBar_FlipBars();
end

function CEnemyCastBar_FlipBars() --flipbars; sets the SPACE, ICONSIZE and BarLength, too! Called when variables loaded

	for i=2, 21 do
	
		local o = i - 1;
		if (i <= 20) then
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
	
			if (CEnemyCastBar.bFlipB) then
				frame:SetPoint("TOPLEFT", "Carni_ECB_"..o, "TOPLEFT", 0, -CEnemyCastBar.bSpace);
			else
				frame:SetPoint("TOPLEFT", "Carni_ECB_"..o, "TOPLEFT", 0, CEnemyCastBar.bSpace);
			end
		end
		local buttonicon = getglobal("Carni_ECB_"..o.."_Icon");
		buttonicon:SetHeight(CEnemyCastBar.bSpace);
		buttonicon:SetWidth(CEnemyCastBar.bSpace);
		buttonicon:SetPoint("LEFT", "Carni_ECB_"..o, "LEFT", -CEnemyCastBar.bSpace + 4, 5);

		-- set bar length
		getglobal("Carni_ECB_"..o):SetWidth(206 + CEnemyCastBar.bnecbCBLBias);
		getglobal("Carni_ECB_"..o.."_Text"):SetWidth(185 + CEnemyCastBar.bnecbCBLBias);
		getglobal("Carni_ECB_"..o.."_Border"):SetWidth(205 + CEnemyCastBar.bnecbCBLBias);
		getglobal("Carni_ECB_"..o.."_StatusBar"):SetWidth(195 + CEnemyCastBar.bnecbCBLBias);
		getglobal("FauxTargetBtn"..o):SetWidth(205 + CEnemyCastBar.bnecbCBLBias);
		getglobal("Carni_ECB_"..o.."_CastTimeText"):SetPoint("LEFT", getglobal("Carni_ECB_"..o), "LEFT", 205 + CEnemyCastBar.bnecbCBLBias, 6);
		
	end

end

function CEnemyCastBar_SetTextSize() --settextsize, called when variables loaded

	for i=1, 20 do
	
		local buttontext = getglobal("Carni_ECB_"..i.."_Text");
		local buttonttext = getglobal("Carni_ECB_"..i.."_CastTimeText");
		
		if (CEnemyCastBar.bSmallTSize) then
			buttontext:SetFontObject(GameFontHighlightSmall);
			buttonttext:SetFontObject(GameFontHighlightSmall);
		else
			buttontext:SetFontObject(GameFontHighlight);
			buttonttext:SetFontObject(GameFontHighlight);
		end
	end
end

function CEnemyCastBar_Boolean(var)

	if (var) then
	
		return "on";
		
	else
	
		return "off";
		
	end

end

function CEnemyCastBar_Handler(msg) --Handler

	if (msg == "help" or msg == "?") then

		if (CECBHELPFrame:IsVisible() and CECBHELPFrameText:GetText() == "NECB - HELP" ) then
			CECBHELPFrame:Hide();
		else
			CECBHELPFrameBGText:SetText("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffff0000 /necb help\n\n" .. table.concat (CEnemyCastBarHelp, "") );
			CECBHELPFrame:SetHeight(550);
			CECBHELPFrameBG:SetHeight(520);
			CECBHELPFrameBGText:SetHeight(510);

			--[[
			local NECB_ResWidth = 400;
			if (GetCurrentResolution() == 1) then
				NECB_ResWidth = 450;
			end
			CECBHELPFrame:SetWidth(NECB_ResWidth);
			CECBHELPFrameBG:SetWidth(NECB_ResWidth-20);
			CECBHELPFrameBGText:SetWidth(NECB_ResWidth-30); ]]

			CECBHELPFrameText:SetText("NECB - HELP");
			CECBHELPFrame:Show();
			CECBHELPFrameWhisper:Hide();
		end


	elseif (msg == "" or msg == nil) then

		local loaded, reason = LoadAddOn("CECB_Options");
		if (loaded) then
			if (CECBOptionsFrame:IsVisible()) then
				necbfademenue = 1;
			else
				CECBOptionsFrame:SetAlpha(0);
				necbfademenue = 2;
				CECB_ShowHideOptionsUI();
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffffff00'CECB_Options' |rAddOn |cffff9999can not be loaded! |rReason: |cffff0000"..reason)
		end

	elseif (msg == "gcinfo") then

		if (CECBGCFrame:IsVisible()) then
			CECBGCFrame:Hide();
			cecbgc_last = nil;
			--collectgarbage("setstepmul 200"); --BC
		else
			CECBGCFrame:Show();
			--collectgarbage("setstepmul 10000"); --BC
			--collectgarbage("collect"); --BC
		end

	-- see "printversions" in OPTIONS part!
	elseif (msg == "versions") then

		if (CEnemyCastBar.bStatus) then

			if (CEnemyCastBar.bParseC and (GetNumRaidMembers() ~= 0 or GetNumPartyMembers() ~= 0 or GetNumBattlefieldStats() > 1) ) then
				CECBHELPFrameBGText:SetText("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffff0000 /necb versions\n\n|cffaaaaaaNECB: |cffffff00Requesting Versions from Raidmembers! |cffff0000Please wait...");
				
				CECBHELPFrameText:SetText("NECB - VERSIONS");
				CECBHELPFrame:SetHeight(100);
				CECBHELPFrameBG:SetHeight(70);
				CECBHELPFrameBGText:SetHeight(60);
				CECBHELPFrame:Show();
	
				NECB_SendMessage("<NECB> Force version collection.");
	
			else
				if (not CEnemyCastBar.bParseC) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to enable NECB's channel parsing to use this!")
				else
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to be in a Group to use this command!")
				end
			end

		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Enable NECB to use this feature!")

		end

	-- see "printversions" in OPTIONS part!
	elseif (msg == "gversions") then

		if (CEnemyCastBar.bStatus) then

			if (CEnemyCastBar.bParseC and IsInGuild() ) then
				CECBHELPFrameBGText:SetText("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffff0000 /necb gversions\n\n|cffaaaaaaNECB: |cffffff00Requesting Versions from Guildmembers! |cffff0000Please wait...");
				
				CECBHELPFrameText:SetText("NECB - GVERSIONS");
				CECBHELPFrame:SetHeight(100);
				CECBHELPFrameBG:SetHeight(70);
				CECBHELPFrameBGText:SetHeight(60);
				CECBHELPFrame:Show();
	
				NECB_SendMessage("<NECB> Force gversion collection.", nil, "toguild");
	
			else
				if (not CEnemyCastBar.bParseC) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to enable NECB's channel parsing to use this!")
				else
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to be in a Guild to use this command!")
				end
			end

		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Enable NECB to use this feature!")

		end

	elseif (msg == "parser") then

		if (CECBParser) then
	
			CECBParser = false;
			CECBCTRAParserFrame:Hide();
			--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Parser |cffff9999disabled")
	
		else
		
			CECBParser = true;
				CEnemyCastBar_ParserOnClick(0);
			CECBCTRAParserFrame:Show();
			--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Parser |cff99ff99temporary enabled")
		
		end

	elseif (msg == "clear") then		

		lockshow = 0;

			if (not CEnemyCastBar.bLocked) then

				CEnemyCastBar_LockPos();
				
			end

		for i=1, 20 do
	
			CEnemyCastBar_HideBar(i);
			
		end

	elseif (msg == "restore") then		

		local i = 1;
		while (i <= table.getn (DisabledSpells)) do
			local spell = DisabledSpells[i];

			if (CEnemyCastBar_Raids[spell]) then
				CEnemyCastBar_Raids[spell].disabled = nil;
			end
	
			if (CEnemyCastBar_Spells[spell]) then
				CEnemyCastBar_Spells[spell].disabled = nil;
			end
	
			if (CEnemyCastBar_Afflictions[spell]) then
				CEnemyCastBar_Afflictions[spell].disabled = nil;
			end

			i = i + 1;
		end			

		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Restored (|cffffff00"..table.getn (DisabledSpells).."|r) spells which were disabled by Shift + RightClick");
		DisabledSpells = { };

	elseif (msg == "disabled") then

		local DSpells = "";
		local SpellsTotal = table.getn (DisabledSpells);
		
		if (SpellsTotal == 0) then
			DSpells = "-.-";
		else
			for i=1, SpellsTotal do
				DSpells = DSpells .. table.concat (DisabledSpells, "", i, i) .. " |cffffffff(|r" .. i .. "|cffffffff)";
				if (i < SpellsTotal ) then
					DSpells = DSpells .. "|cffff0000 | |r";
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffffff Disabled Spells: |r"..DSpells, 1, 1, 0);

	elseif (msg == "cooldowns") then

		local DSpells = "";
		local SpellsTotal = table.getn (NECB_CD_DB);
		
		if (SpellsTotal == 0) then
			DSpells = "-.-";
		else
			for i=1, SpellsTotal do
				local CDLeft = floor (NECB_CD_DB[i][3] + NECB_CD_DB[i][4] - GetTime() );
				if ( CDLeft < 0 ) then
					CDLeft = 0;
				end
				DSpells = DSpells .. NECB_CD_DB[i][1] .. "|cffffffff - |r" .. NECB_CD_DB[i][2] .. " |cffffffff(|r" .. CDLeft .. "|cffffffff)|r";
				if (i < SpellsTotal ) then
					DSpells = DSpells .. "|cffff0000 | |r";
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffffff Cooldowns: |r"..DSpells, 1, 1, 0);

	elseif (string.sub (msg, 1, 4) == "add " and CEnemyCastBar.bStatus) then

		local msg1 = string.sub (msg, 5, string.len(msg) );
		CEnemyCastBar_HideBar(nil, nil, msg1); -- Hidebar also used for disabled spell commands! Shift + Rightclick...

	elseif (msg == "save") then

		CEnemyCastBar.tDisabledSpells = { };

		local i = 1;
		while (DisabledSpells[i]) do
			table.insert (CEnemyCastBar.tDisabledSpells, DisabledSpells[i]);
			i = i + 1;
		end

		if (table.getn (DisabledSpells) == 0) then
			DSpells = "Nothing disabled! |rEmpty table saved.";
		else
			i = i - 1;
			DSpells = i.." |rDisabled Spells saved.";
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffff00 "..DSpells);

	elseif (msg == "load") then

		CEnemyCastBar_LoadDisabledSpells();

	elseif (string.sub (msg, 1, 7) == "remove " and CEnemyCastBar.bStatus) then

		local msg1 = string.sub (msg, 8, string.len(msg) );
		local spellfound = false;

		local i = 1;
		while (DisabledSpells[i]) do

			if (string.lower(DisabledSpells[i]) == string.lower(msg1) or ( tonumber(msg1) and DisabledSpells[tonumber(msg1)] ) ) then

					local spell;
					if (tonumber(msg1) and DisabledSpells[tonumber(msg1)] ) then
						i = tonumber(msg1);
					end

					spell = DisabledSpells[i];

					if (CEnemyCastBar_Raids[spell]) then
						CEnemyCastBar_Raids[spell].disabled = nil;
					end
			
					if (CEnemyCastBar_Spells[spell]) then
						CEnemyCastBar_Spells[spell].disabled = nil;
					end
			
					if (CEnemyCastBar_Afflictions[spell]) then
						CEnemyCastBar_Afflictions[spell].disabled = nil;
					end

				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffffff Restored Spell: |r".. table.concat (DisabledSpells, "", i, i), 1, 1, 0);
				table.remove (DisabledSpells, i);
				spellfound = true;
				break;
			end
			i = i + 1;
		end

		if (not spellfound) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffaaaa Spell not found!");
		end

	elseif (string.sub (msg, 1, 7) == "forcebc" and CEnemyCastBar.bStatus) then

		local msg1 = string.sub (msg, 9, string.len(msg) );

		if (msg1 == "") then
			msg1 = UnitName("target");
		end

		if (msg1 == nil) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999No name specified and no target selected!")

		elseif (CEnemyCastBar_CheckRaidStatus( UnitName("player") ) == false ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to be leader or promoted to do this!")

		elseif (CEnemyCastBar_CheckRaidStatus( msg1 ) == nil ) then
			if (UnitInRaid("player") ) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999The name/target you selected is not found in your raid!")
			else
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to be in a RaidGroup!")
			end

		else
			NECB_SendMessage("<NECB> FORCE "..msg1.." to Broadcast! Change Settings!");
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |rForced |cffffff00"..msg1.." |rto broadcast!")
		end

	elseif (string.sub (msg, 1, 6) == "stopbc" and CEnemyCastBar.bStatus) then

		local msg1 = string.sub (msg, 8, string.len(msg) );

		if (msg1 == "") then
			msg1 = UnitName("target");
		end

		if (msg1 == nil) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999No name specified and no target selected!")

		elseif (CEnemyCastBar_CheckRaidStatus( UnitName("player") ) == false ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to be leader or promoted to do this!")

		elseif (CEnemyCastBar_CheckRaidStatus( msg1 ) == nil ) then
			if (UnitInRaid("player") ) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999The name/target you selected is not found in your raid!")
			else
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to be in a RaidGroup!")
			end

		else
			NECB_SendMessage("<NECB> STOP "..msg1.." to Broadcast! Change Settings!");
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |rStopped broadcasts of |cffffff00"..msg1.." |r!")
		end

	elseif (string.sub (msg, 1, 9) == "countsec " and CEnemyCastBar.bStatus) then

		local msg1 = tonumber (string.sub (msg, 10, 12));

		local textlen = string.len (msg);
		local textinput = string.sub (msg, 10, textlen);
		local firstspace = string.find (textinput, " ");
		local msg2;
		if (firstspace and textlen >= (firstspace + 10)) then
			msg2 = string.sub (msg, firstspace + 10, textlen);
			if ((firstspace +8) <= 12) then
				msg1 = tonumber (string.sub (msg, 10, firstspace + 8));
			end
		end

		if (msg1) then

			if (msg1 < 0) then
	
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Invalid value to start the countdown!")
		
			else
		
				if (msg2 == nil) then msg2 = "Countdown";
				end
	
				if ( CEnemyCastBar_UniqueCheck(msg2, msg1, "("..msg1.." Seconds)") == 0 ) then
					CEnemyCastBar_Show("("..msg1.." Seconds)", msg2, msg1, "grey", nil, "INV_Misc_Bomb_03.blp");
				end

			end

		end

	elseif (string.sub (msg, 1, 9) == "countmin " and CEnemyCastBar.bStatus) then

		local msg1 = tonumber (string.sub (msg, 10, 12));

		local textlen = string.len (msg);
		local textinput = string.sub (msg, 10, textlen);
		local firstspace = string.find (textinput, " ");
		local msg2;
		if (firstspace and textlen >= (firstspace + 10)) then
			msg2 = string.sub (msg, firstspace + 10, textlen);
			if ((firstspace +8) <= 12) then
				msg1 = tonumber (string.sub (msg, 10, firstspace + 8));
			end
		end

		if (msg1) then

			if (msg1 * 60 < 0) then
	
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Invalid value to start the countdown!")
	
			else
			
				if (msg2 == nil) then msg2 = "Countdown";
				end
	
				if ( CEnemyCastBar_UniqueCheck(msg2, msg1 * 60, "("..msg1.." Minutes)") == 0 ) then
					CEnemyCastBar_Show("("..msg1.." Minutes)", msg2, msg1 * 60, "grey", nil, "INV_Misc_Bomb_03.blp");
				end
				
	
			end

		end
		
	elseif (string.sub (msg, 1, 7) == "repeat " and CEnemyCastBar.bStatus) then

		local msg1 = tonumber (string.sub (msg, 8, 10));

		local textlen = string.len (msg);
		local textinput = string.sub (msg, 8, textlen);
		local firstspace = string.find (textinput, " ");
		local msg2;
		if (firstspace and textlen >= (firstspace + 8)) then
			msg2 = string.sub (msg, firstspace + 8, textlen);
			if ((firstspace +6) <= 10) then
				msg1 = tonumber (string.sub (msg, 8, firstspace + 6));
			end
		end

		if (msg1) then

			if (msg1 < 0) then
	
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Invalid value to start the repeater!")

			else

				if (msg2 == nil) then msg2 = "Repeater";
				else msg2 = "Repeater: "..msg2;
				end
				if ( CEnemyCastBar_UniqueCheck(msg2, msg1, "("..msg1.." Seconds)") == 0 ) then
					CEnemyCastBar_Show("("..msg1.." Seconds)", msg2, msg1, "grey", nil, "INV_Misc_Bomb_04.blp");
				end
					
			end

		end
		
	elseif (string.sub (msg, 1, 10) == "stopcount " and CEnemyCastBar.bStatus) then

		local msg1;
		local textlen = string.len (msg);
		if (textlen >= 11) then
			msg1 = string.sub (msg, 11, textlen);
		end

		if (msg1) then

			if (msg1 == "all") then msg1 = " ";
			end

			for i=1, CEnemyCastBar.bNumBars do
			
				local label = getglobal("Carni_ECB_"..i).label;

				if (label and string.find (label, msg1) and getglobal("Carni_ECB_"..i).ctype == "grey" ) then
						CEnemyCastBar_HideBar(i);
				end
			end
		end

	elseif (string.sub (msg, 1, 10) == "deletebar " and CEnemyCastBar.bStatus) then

		local msg1;
		local textlen = string.len (msg);
		if (textlen >= 11) then
			msg1 = string.sub (msg, 11, textlen);
		end

		if (msg1) then

			if (msg1 == "all") then msg1 = " ";
			end

			for i=1, CEnemyCastBar.bNumBars do
			
				local label = getglobal("Carni_ECB_"..i).label;
				local mob = getglobal("Carni_ECB_"..i).mob;
				--local r,g,b = getglobal("Carni_ECB_"..i.."_StatusBar"):GetStatusBarColor(); -- to delete specific colored bar
				--and ceil(r*10) == ceil(CEnemyCastBar.tColor[8][1]*10) and ceil(g*10) == ceil(CEnemyCastBar.tColor[8][2]*10) and ceil(b*10) == ceil(CEnemyCastBar.tColor[8][3]*10)

				if (label and string.find(label, msg1) and mob == UnitName("target") ) then
						CEnemyCastBar_HideBar(i);
				end
			end

		end

	elseif (string.sub (msg, 1, 8) == "showbar " and CEnemyCastBar.bStatus) then
	
		local spell;
		local textlen = string.len (msg);
		if (textlen >= 9) then
			spell = string.sub (msg, 9, textlen);
		end

		local mob = UnitName("target");
		if (not mob) then
			return;
		end

		if (CEnemyCastBar_Afflictions[spell]) then
			if (not UnitIsFriend("player", "target") ) then
				if (CEnemyCastBar_Afflictions[spell].periodicdmg) then
					CEnemyCastBar_Control(mob, spell, "periodicdmg", nil, "customdot");
				else
					CEnemyCastBar_Control(mob, spell, "afflicted");
				end
			end

		elseif (CEnemyCastBar_Spells[spell]) then
			if (UnitIsFriend("player", "target") ) then
				CEnemyCastBar_Control(mob, spell, "gains");
			end

		end

	elseif (string.sub (msg, 1, 5) == "cast " and CEnemyCastBar.bStatus) then
	
		local spell;
		local textlen = string.len (msg);
		if (textlen >= 6) then
			spell = string.sub (msg, 6, textlen);
		end

		NECBCustomCasted = true;
		CastSpellByName(spell); -- fires "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" very fast on most errors which will set NECBCustomCasted = nil;
		-- for BC use this macro and comment out two lines above!:
		-- /script NECBCustomCasted = true;
		-- /cast SpellName
		-- /necb cast SpellName
		if (NECBCustomCasted) then
			CEnemyCastBar_Handler("showbar "..spell);
		end

	elseif (msg == "combatlog") then

		if (necbprint2combat) then
	
			necbprint2combat = nil;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Also write parser messages to combatlog |cffff9999disabled")
		
		else
		
			necbprint2combat = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Also write parser messages to combatlog |cff99ff99enabled")

		end
	
	elseif (string.sub (msg, 1, 5) == "chat " and CEnemyCastBar.bStatus) then

		if (GetNumPartyMembers() ~= 0 or GetNumRaidMembers() ~= 0 ) then
			local text;
			local textlen = string.len (msg);
			if (textlen >= 6) then
				text = string.sub (msg, 6, textlen);
			end
			
			NECB_SendMessage(text, "CHAT");

		else 
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999You have to be in a Group to use NECB's Chat!")
		end

	elseif ((string.sub (msg, 1, 9) == "setrange " or msg == "setrange") and CEnemyCastBar.bStatus) then

		local text;
		local textlen = string.len (msg);
		if (textlen >= 10) then
			text = string.sub (msg, 10, textlen);
		end
		-- "allmax", "cmax", nil for defaults
		CEnemyCastBar_SetRange(text);

	elseif (msg == "debug") then

		if (CEnemyCastBar.bDebug) then
	
			CEnemyCastBar.bDebug = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r DebugMode |cffffff99disabled")
		
		else
		
			CEnemyCastBar.bDebug = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r DebugMode |cffffff99enabled")

		end
	end
end


-- Options Handler -----------------------
function CEnemyCastBar_InternalHandler(msg) --Options

	if (msg == "printversions") then

		local VersionDBTemp = { };

		if (VersionDB and VersionDB[1]) then
			for i=1, table.getn (VersionDB) do
				table.insert (VersionDBTemp, "|cffaaaaaaNECB: |rVersion |cff00ff00"..VersionDB[i].."|r is used by "..VersionNames[i]..".");
				VersionDBTemp[i] = string.gsub (VersionDBTemp[i], ", BCASTER", "");
			end


			table.sort (VersionDBTemp);
			local vcounter = 1;
	
			for i=1, table.getn (VersionDBTemp) do
				local o = i + 1;
				if (VersionDBTemp[o]) then
					local _,_,nextversion = string.find (VersionDBTemp[o], "Version (.+) is used")
					local _,_,thisversion = string.find (VersionDBTemp[i], "Version (.+) is used")
	
					if (nextversion and thisversion and nextversion == thisversion) then
						local _,_,nextname = string.find (VersionDBTemp[o], "is used by (.+).")
						table.remove (VersionDBTemp, o);
						VersionDBTemp[i] = string.sub (VersionDBTemp[i], 1, string.len( VersionDBTemp[i] ) - 1 ) .. ", " ..nextname ..".";
						i = i - 1;
						vcounter = vcounter + 1;
					else
						if (vcounter > 1) then
							VersionDBTemp[i] = VersionDBTemp[i] .. " (|cff00ff00" ..vcounter.. "|r Users)";
						end
						vcounter = 1;
					end
	
				else
	
					if (vcounter > 1 and VersionDBTemp[i]) then
						VersionDBTemp[i] = VersionDBTemp[i] .. " (|cff00ff00" ..vcounter.. "|r Users)";
					end
	
				end
	
			end
	
			CECBHELPFrameBGText:SetText("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffff0000 /necb (g)versions\n\n|cffaaaaaaNECB: |cffffff00Client versions which answered (|cff9999ffblue|cffffff00 = broadcaster):\n\n");
			local necblinebreak = 0;

			for i=table.getn (VersionDBTemp), 1, -1 do
				--DEFAULT_CHAT_FRAME:AddMessage(VersionDBTemp[i]);
				CECBHELPFrameBGText:SetText(CECBHELPFrameBGText:GetText()..VersionDBTemp[i].."\n" );

				CECBParserFauxText:SetText(VersionDBTemp[i]);
				if (CECBParserFauxText:GetStringWidth() > 410) then
					necblinebreak = necblinebreak + floor(CECBParserFauxText:GetStringWidth() / 410);
				end

			end

			-- recolor
			for i=1, table.getn (VersionDB) do
				local necbbccolor = "|cffcccc00";
				if (string.find(VersionDB[i], ", BCASTER") ) then
					necbbccolor = "|cff9999ff";
				end
				CECBHELPFrameBGText:SetText(string.gsub(CECBHELPFrameBGText:GetText(), VersionNames[i], necbbccolor..VersionNames[i].."|r") );
			end

			local necbpixellines = (table.getn (VersionDBTemp) + necblinebreak ) *10;
			--CECBHELPFrameText:SetText("NECB - VERSIONS");
			CECBHELPFrame:SetHeight(90 + necbpixellines);
			CECBHELPFrameBG:SetHeight(60 + necbpixellines);
			CECBHELPFrameBGText:SetHeight(50 + necbpixellines);
			--CECBHELPFrame:Show();
			if (table.getn (VersionDBTemp) > 1) then
				CECBHELPFrameWhisper:Show();
			end

		else
			CECBHELPFrameBGText:SetText("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffff0000 /necb (g)versions\n\n|cffaaaaaaNECB: |cffff0000Unknown error! No data found :/");
		end

	elseif (msg == "WhisperToObsolete") then

		local VersionDBTemp = { };
		for i=1, table.getn (VersionDB) do
			table.insert (VersionDBTemp, VersionDB[i]);
			VersionDBTemp[i] = string.gsub (VersionDBTemp[i], ", BCASTER", "");
		end

		local necb_newest = " ";
		local necb_whispered;
		for i=1, table.getn (VersionDBTemp) do
			local necb_checked = string.sub( VersionDBTemp[i], 1, string.len(VersionDBTemp[i]) - 6 );
			if ( necb_checked > necb_newest) then
				necb_newest = necb_checked;
			end
		end

		for i=1, table.getn (VersionDBTemp) do
			local necb_checked = string.sub( VersionDBTemp[i], 1, string.len(VersionDBTemp[i]) - 6 );
			if ( necb_checked < necb_newest and VersionNames[i] ~= UnitName("player") ) then
				if (not necb_whispered) then
					NECB_SendMessage("<NECB> Whisper old versions of NECB to update!");
				end
				SendChatMessage("*** NECB: Your version ("..necb_checked..") is outdated! Update to the newest detected version ("..necb_newest..") please! ***", "WHISPER", nil, VersionNames[i]);
				necb_whispered = true;
			end
		end

		if (CECB_status_version_txt < necb_newest) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffffff00Your own version is out of date!")

		elseif (not necb_whispered) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Noone is using an outdated version!")
		end

	end
end

function CEnemyCastBar_CheckRaidStatus(checkplayer) -- check players raidstatus, leader or promoted -> 1,2 else false or nil

	local plrank, plfileName;
	for i = 1, GetNumRaidMembers() do
		if ( UnitName("raid" .. i) == checkplayer ) then
			_, plrank, _, _, _, plfileName = GetRaidRosterInfo(i);
			break;
		end
	end

	if (plrank == 0) then
		plrank = false;
	end

	return plrank, plfileName;

end

function CEnemyCastBar_Show(mob, spell, castime, ctype, turnlabel, icontexture, starttime) --Show

 if (lockshow ~= 1) then

	for i=1, CEnemyCastBar.bNumBars do
	
		local button = getglobal("Carni_ECB_"..i);
		local fauxbutton = getglobal("FauxTargetBtn"..i);
	
		if (not button:IsVisible()) then
		
			if (ctype == "hostile") then
			
				red = CEnemyCastBar.tColor[1][1];
				green = CEnemyCastBar.tColor[1][2];
				blue = CEnemyCastBar.tColor[1][3];					
			
			elseif (ctype == "friendly") then
			
				red = CEnemyCastBar.tColor[2][1];
				green = CEnemyCastBar.tColor[2][2];
				blue = CEnemyCastBar.tColor[2][3];
				
			elseif (ctype == "cooldown") then
			
				red = CEnemyCastBar.tColor[3][1];
				green = CEnemyCastBar.tColor[3][2];
				blue = CEnemyCastBar.tColor[3][3];	
			
			elseif (ctype == "gains") then
				red = CEnemyCastBar.tColor[4][1];
				green = CEnemyCastBar.tColor[4][2];
				blue = CEnemyCastBar.tColor[4][3];

			elseif (ctype == "grey") then
				red = CEnemyCastBar.tColor[5][1];
				green = CEnemyCastBar.tColor[5][2];
				blue = CEnemyCastBar.tColor[5][3];

			elseif (ctype == "afflict") then

				red = CEnemyCastBar.tColor[6][1];
				green = CEnemyCastBar.tColor[6][2];
				blue = CEnemyCastBar.tColor[6][3];

			elseif (ctype == "stuns") then

				red = CEnemyCastBar.tColor[7][1];
				green = CEnemyCastBar.tColor[7][2];
				blue = CEnemyCastBar.tColor[7][3];

			elseif (ctype == "cursetype") then

				red = CEnemyCastBar.tColor[8][1];
				green = CEnemyCastBar.tColor[8][2];
				blue = CEnemyCastBar.tColor[8][3];
			
			end

			if (starttime) then
				getglobal("Carni_ECB_"..i).startTime = starttime;
			else
				getglobal("Carni_ECB_"..i).startTime = GetTime();
			end

			if (turnlabel) then
				getglobal("Carni_ECB_"..i).label = mob .." - ".. spell;
			else
				getglobal("Carni_ECB_"..i).label = spell .." - ".. mob;
			end

			if (mob == UnitName("player")) then
				getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(1,0,0);
			elseif (turnlabel) then
				getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(0,0,1);
			else
				getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(0,0,0);
			end

			if (CEnemyCastBar.bShowIcon and icontexture and icontexture ~= "") then
				getglobal("Carni_ECB_"..i.."_Icon"):SetTexture("Interface\\Icons\\"..icontexture);
				getglobal("Carni_ECB_"..i.."_Icon"):Show();
			else
				getglobal("Carni_ECB_"..i.."_Icon"):Hide();
			end

			getglobal("Carni_ECB_"..i).spell = spell;
			getglobal("Carni_ECB_"..i).mob = mob;
			getglobal("Carni_ECB_"..i).ctype = ctype;
			getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
			getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
			getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);
			getglobal("Carni_ECB_"..i.."_StatusBar"):SetStatusBarColor(red, green, blue);
			fauxbutton:SetScale(CEnemyCastBar.bScale);
			fauxbutton:Show();				
			button:SetAlpha(0);
			button:SetScale(CEnemyCastBar.bScale);
			button:Show();

			break;
			
		end
		
	end
	
 end  

end

function CEnemyCastBar_UniqueCheck(spellname, castime, mob, gspell, DRText, turnit) --Unique

	local ashowing, drstate = 0;

	-- check only, no update
	if (gspell == "true") then

		for i=1, CEnemyCastBar.bNumBars do
		
			local spell = getglobal("Carni_ECB_"..i).spell;
			
			if (spell == spellname and mob == getglobal("Carni_ECB_"..i).mob) then

				ashowing = 1;

				break; -- there can be only one :D
			end
		end

	-- check + update if mob AND spell are the same
	elseif (gspell == "trueupdate") then

		for i=1, CEnemyCastBar.bNumBars do
		
			local spell = getglobal("Carni_ECB_"..i).spell;
			
			if (spell == spellname and mob == getglobal("Carni_ECB_"..i).mob) then

				ashowing = 1;

					local button = getglobal("Carni_ECB_"..i); --START unique updater

					if (DRText == "delay") then
						getglobal("Carni_ECB_"..i).endTime = castime; --BC same time zone?
					else
						getglobal("Carni_ECB_"..i).startTime = GetTime();
						getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
					end
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);

					if (DRText) then
						if (turnit) then
							getglobal("Carni_ECB_"..i).label = mob.." - "..spell .." "..DRText;
						else
							getglobal("Carni_ECB_"..i).label = spell .." "..DRText.." - "..mob;
						end
					end

				break; -- there can be only one :D
			end
		end

	-- check + update if spell is the same
	else

		for i=1, CEnemyCastBar.bNumBars do
		
			local spell = getglobal("Carni_ECB_"..i).spell;
			
			if (spell == spellname) then
	
				ashowing = 1;

					local button = getglobal("Carni_ECB_"..i); --START unique updater

					if (mob == UnitName("player")) then
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(1,0,0);
					else
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(0,0,0);
					end

					if (DRText) then
						if (string.find(button.label, "1/2")) then
							drstate = 4; DRText = "(|cffff00001/4|r)"; castime = castime/2 + 15;
						elseif (string.find(button.label, "1/4")) then
							drstate = 6; DRText = "(|cffff0000"..CECB_MISC_IMMUNE.."|r)"; castime = castime/4 + 15;
						elseif (string.find(button.label, CECB_MISC_IMMUNE)) then
							drstate = 2; DRText = "(|cffff00001/2|r)"; castime = castime + 15;
						end

						getglobal("Carni_ECB_"..i).label = spell .." "..DRText.." - "..mob;
					else
						getglobal("Carni_ECB_"..i).label = spell .." - ".. mob;
					end

					getglobal("Carni_ECB_"..i).startTime = GetTime();
					getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);

					getglobal("Carni_ECB_"..i).mob = mob; --END unique updater
					
				break; -- there can be only one :D
			end
		end
	end

	return ashowing, drstate;
end

function CEnemyCastBar_BCast_Control(bcasted) --BCast Control

	local down, up, latency = GetNetStats();

	if (not bcasted and latency < 750 and CEnemyCastBar.bBCaster and CEnemyCastBar.bParseC and (GetNumRaidMembers() ~= 0 or GetNumPartyMembers() ~= 0 or GetNumBattlefieldStats() > 1 ) ) then
		if (LastSentBCPacket) then
			if (BCPacket[1] == LastSentBCPacket[1] and BCPacket[2] == LastSentBCPacket[2] and BCPacket[3] == LastSentBCPacket[3] and (GetTime() - LastSentBCPacket[4]) < 5) then
				return false, latency;
			end
		end
		return true, latency;
	end
	return false, latency;
end

function NECB_interrupt_casting(spell, mob) --INTERRUPTING Function, idea by Lazarus

	if (	CEnemyCastBar.bDisableInterrupt
		or ( CEnemyCastBar.bSpellBreakLight and UnitInRaid("player") )
		or CEnemyCastBar.bGainsOnly
		or not CEnemyCastBar.bPvP
		or (not CEnemyCastBar.bGlobalPvP and UnitName("target") ~= mob)
		) then
		return;

	elseif ( string.find(NECB_Interruptions, spell) ) then
		CEnemyCastBar_Control(mob, mob, "interrupt");
	end
end

function CEnemyCastBar_Player_Target_Changed() --Target changed

	-- remove other Player CD Bars first
	for i=1, CEnemyCastBar.bNumBars do
		local spell = getglobal("Carni_ECB_"..i).spell;

		if (spell and string.find(spell, " %(CD%)") ) then

			spell = string.gsub(spell, " %(CD%)", "");
			if (CEnemyCastBar_Spells[spell]) then
				CEnemyCastBar_HideBar(i);
			end
		end
	end

	-- display CDs from Database for new target and remove obsolete CDs
	local i = 1;
	while i <= table.getn(NECB_CD_DB) do
		if ( GetTime() > ( NECB_CD_DB[i][3] + NECB_CD_DB[i][4] ) ) then
			table.remove(NECB_CD_DB, i);
			i = i - 1;
		else
			if (NECB_CD_DB[i][1] == UnitName("target") ) then
				if (UnitIsPlayer("target") and not CEnemyCastBar_Spells[NECB_CD_DB[i][2]].disabled) then
					CEnemyCastBar_Show(NECB_CD_DB[i][1], NECB_CD_DB[i][2].." (CD)", NECB_CD_DB[i][4], "cooldown", nil, CEnemyCastBar_Spells[NECB_CD_DB[i][2]].icontex, NECB_CD_DB[i][3]);
				else
					table.remove(NECB_CD_DB, i);
					i = i - 1;
				end
			end
		end
		i = i + 1;
	end

end

function CEnemyCastBar_Control(mob, spell, special, bcasted, event) --Control

		if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then

			if (event) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, Con: "..mob.." (event: "..event..")");
			end
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, Con: "..mob.." ("..spell.." "..special..")");
		
		end

	if (not CEnemyCastBar.bStatus) then
		return;
	end

	-- Convert "You" into Playername, important for broadcasts
	if (mob == CECB_SELF1 or mob == CECB_SELF2) then
		mob = UnitName("player");
	end

	local spelllength = string.len (spell);
	-- crop the german aposthrophes from some spells (')
	local spell_de = string.sub(spell, 2, spelllength - 1);
	if (CEnemyCastBar_Raids[spell_de]) then spell = spell_de;
	end

	-- Network BC TempBCaster
	local clientlang = GetLocale();

	-- initialize vars
	local ctype, castime;

		-- stop mirroring spells! only specified Mob, Zone, Event produces castbars else check pvp, debuff section
	if (
		special ~= "fades"
		and CEnemyCastBar_Raids[spell]
		and not (CEnemyCastBar_Raids[spell].mcheck and not string.find(CEnemyCastBar_Raids[spell].mcheck, mob))
		and not (CEnemyCastBar_Raids[spell].aZone and GetRealZoneText() ~= CEnemyCastBar_Raids[spell].aZone)
		and (bcasted or not (CEnemyCastBar_Raids[spell].checkevent and (not event or not string.find(CEnemyCastBar_Raids[spell].checkevent, event) ) ) )
		) then
		
		if (CEnemyCastBar.bPvE) then

			-- stop Boss CDs from beeing updated by fault when player enters combat
			if (special == "engage") then
				if (CEnemyCastBar_EngageProtection() ) then
					necbengagecd = GetTime();
					return;
				end
				necbengagecd = GetTime();
			else
				if (CEnemyCastBar_EngageProtection() ) then
					necbengagecd = GetTime();
					-- if more than necbEPTime secs have passed without a countdown restart it will be nil'ed in enter combat function later!
				end
			end

			-- logical barrier (+if clause at beginning!):
			if (
						-- only allow instant casts with a flag pass to avoid spell mirroring
					(special == "instcast" and not CEnemyCastBar_Raids[spell].icasted)
						-- stop mirroring spells! only if casted actively
				or	(CEnemyCastBar_Raids[spell].active and not (special == "casts" or special == "performs" or special == "engage") )
						-- check if previously disabled with shift + rightclick;
				or	(CEnemyCastBar_Raids[spell].disabled)
						-- only show bar if player has this target (if defined)
				or	(CEnemyCastBar_Raids[spell].checktarget and UnitName("target") ~= mob)
				or	(CEnemyCastBar_Raids[spell].checkengage and not CEnemyCastBar_EngageProtection() )

				) then
				return;
			end

			local icontex = CEnemyCastBar_Raids[spell].icontex; -- > get icon texture
			local globalspell = CEnemyCastBar_Raids[spell].global; -- > This castbar won't be updated if already active!
			castime = CEnemyCastBar_Raids[spell].t;
			ctype = CEnemyCastBar_Raids[spell].c;
			
			-- Spell might have the same name but a different cast time on another mob, ie. Onyxia/Nefarian on Bellowing Roar
			if (CEnemyCastBar_Raids[spell].r) then
			
				if ( string.find(CEnemyCastBar_Raids[spell].r, mob) ) then
				
					castime = CEnemyCastBar_Raids[spell].a;
				
				end
			
			end

			if (CEnemyCastBar_Raids[spell].m) then

				mobbuffer = mob;
				mob = CEnemyCastBar_Raids[spell].m;
			
			end

			alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,globalspell);

			if (alreadyshowing == 0) then

				CEnemyCastBar_Show(mob, spell, castime, ctype, nil, icontex);
			
			end
			
			if (CEnemyCastBar_Raids[spell].i) then

				castime = CEnemyCastBar_Raids[spell].i;

				alreadyshowing = CEnemyCastBar_UniqueCheck(spell.." (D)",castime,mob,globalspell);
		
				if (alreadyshowing == 0) then

					CEnemyCastBar_Show(mob, spell.." (D)", castime, "hostile", nil, icontex);
				
				end
			
			end

			-- delete bar if defined
			if (CEnemyCastBar_Raids[spell].delBar) then
				CEnemyCastBar_DelBar(CEnemyCastBar_Raids[spell].delBar);
			end

			-- trigger next bars if defined
			if (CEnemyCastBar_Raids[spell].pBar) then
				CEnemyCastBar_Control(mob, CEnemyCastBar_Raids[spell].pBar, "casts", "true"); -- won't be broadcasted!
			end

			-- Network BCasting
			-- restore unchanged mobname
			if (mobbuffer) then
				mob = mobbuffer;
				mobbuffer = nil;
			end

			if (special == "afflicted" and mob ~= CEnemyCastBar_Raids[spell].mcheck) then
				mob = "CECBName"; -- so no channel spam appears after the raid got feared etc.
			end

			BCPacket = {mob, spell, special};
			local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted);
			if ( freetosend ) then
				NECB_SendMessage(".cecbspell "..mob..", "..spell..", "..special..", "..clientlang..", "..latency);
				LastSentBCPacket = {mob, spell, special, GetTime()};
				LastGotBCPacket = {mob, spell, special, GetTime()};
				numspellcast = 0;
			end

			-- recall control function for mobs dying (Obsidian Destroyer) to clear all bars
			if (special == "died") then
				if (mobbuffer) then
					CEnemyCastBar_Control(mobbuffer, "dummy_xyz", "died");
				else
					CEnemyCastBar_Control(mob, "dummy_xyz", "died");
				end
			end

		end
		
	else
	
		if (CEnemyCastBar.bPvP) then

			-- crop the german aposthrophes from some spells (')
			local spell_de = string.sub(spell, 2, spelllength - 1);
			if (CEnemyCastBar_Spells[spell_de]) then spell = spell_de;
			end

			-- CD Buffer Routine
			if (CEnemyCastBar.bUseCDDB and CEnemyCastBar.bCDown and CEnemyCastBar_Spells[spell] and CEnemyCastBar_Spells[spell].d and not (UnitName("target") and not UnitIsPlayer("target")) ) then

				if (special == "casts" or special == "gains" or special == "performs") then

					castime = CEnemyCastBar_Spells[spell].d;
	
					if (not (castime > 60 and CEnemyCastBar.bCDownShort) ) then
	
						if (special == "casts" and CEnemyCastBar_Spells[spell].t) then
							castime = castime + CEnemyCastBar_Spells[spell].t;
						end
	
						local i = 1;
						local CDDBUpdated = false;
						-- add CD to database
						while i <= table.getn(NECB_CD_DB) do
							if ( NECB_CD_DB[i][1] == mob and NECB_CD_DB[i][2] == spell ) then
								NECB_CD_DB[i][3] = GetTime();
								CDDBUpdated = true;
							end
							if ( GetTime() > ( NECB_CD_DB[i][3] + NECB_CD_DB[i][4] ) ) then
								table.remove(NECB_CD_DB, i);
								i = i - 1;
							end
							i = i + 1;
						end
	
						if ( table.getn(NECB_CD_DB) < 50 and not CDDBUpdated and mob ~= UnitName("player") and not CEnemyCastBar_Spells[spell].disabled) then
							table.insert(NECB_CD_DB, { mob, spell, GetTime(), castime } );
							--DEFAULT_CHAT_FRAME:AddMessage("Mob: "..mob.." |Spell: "..spell); --!
						end
					end
				end
			end
			-- CD Buffer Routine finished

			if ((UnitName("target") == mob or CEnemyCastBar.bGlobalPvP) and mob ~= UnitName("player")) then

			    if (special == "casts" or special == "gains" or special == "performs") then

	 			-- check if spell stacks
				local fbracket,_,spellstacks = string.find(spell, "(%(%d+%))" );
				if (fbracket) then
					spell = string.sub(spell, 1, fbracket - 2);
					spelllength = string.len (spell);
				end

				if (CEnemyCastBar_Spells[spell]) then


					if (
							-- check if previously disabled with shift + leftclick
						CEnemyCastBar_Spells[spell].disabled
							-- check if only gains are allowed
						or (CEnemyCastBar.bGainsOnly and CEnemyCastBar.bGains and special ~= "gains")
						) then
						return;
					end

					local icontex = CEnemyCastBar_Spells[spell].icontex; -- > get icon texture
						
					if (UnitIsEnemy("player", "target")) then
						ctype = "hostile";
					else
						ctype = "friendly";
					end
			
					if (CEnemyCastBar_Spells[spell].i) then
					
						castime = CEnemyCastBar_Spells[spell].i;
						CEnemyCastBar_Show(mob, spell, castime, ctype, nil, icontex);					
					
					end
					
					if (CEnemyCastBar_Spells[spell].d and CEnemyCastBar.bCDown and ( UnitIsPlayer("target") or CEnemyCastBar.bGlobalPvP) ) then

						if (special == "gains" and CEnemyCastBar.bGains) then

							castime = CEnemyCastBar_Spells[spell].d;
							if (not (castime > 60 and CEnemyCastBar.bCDownShort) ) then

								if (CEnemyCastBar_UniqueCheck(spell.." (CD)", castime, mob, "trueupdate") == 0) then
									CEnemyCastBar_Show(mob, spell.." (CD)", castime, "cooldown", nil, icontex);
								end
							end
						end
					end

					castime = CEnemyCastBar_Spells[spell].t; -- but if only "d=" is applied then "t=nil", so check at end of this block
					
					-- Spell might have the same name but a different cast time on another mob, ie. Death Talon Hatchers/Players on Bellowing Roar
					if (CEnemyCastBar_Spells[spell].r) then
					
						if (mob == CEnemyCastBar_Spells[spell].r) then
						
							castime = CEnemyCastBar_Spells[spell].a;
						
						end
					
					end

					if (special == "gains") then

						if (CEnemyCastBar.bGains) then

							ctype = "gains";
							if (CEnemyCastBar_Spells[spell].g) then
							
								castime = CEnemyCastBar_Spells[spell].g;
							
							end
							alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate",spellstacks);
						else

							return;

						end

					--[[--BC casttime and spell adjustment; won't show multiple bars if mobs with same name cast! excessive testing needed!
					elseif (special == "casts" and castime and UnitName("target") == mob) then
						local UCI_spell, _, _, _, UCI_startTime, UCI_endTime = UnitCastingInfo("target");
						if (UCI_spell == spell) then
							castime = UCI_endTime - UCI_startTime;
							if (CEnemyCastBar_UniqueCheck(spell, castime, mob, "trueupdate") == 1) then
								return;
							end
						else
							return;
						end
					]]

					end

					if (CEnemyCastBar_Spells[spell].c) then
					
						ctype = CEnemyCastBar_Spells[spell].c;
					
					end
					
					if (castime and not (special == "gains" and alreadyshowing == 1) ) then
						CEnemyCastBar_Show(mob, spell, castime, ctype, nil, icontex);
						if (spellstacks) then
							CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate",spellstacks);
						end
					end

			 	end
			
			    end

			end
				
		end
	-- new block
	-- other than PvE, independent of PvP
		-- now check everytime, since some gains shall be removed, too (see REMOVALS in afflictions section of localization.lua)
		if (special == "fades") then -- spells fading earlier than bar, not very important since most spells can't end earlier and aren't listed in c-log after recast and still afflicted

			-- crop the german aposthrophes from some spells (')
			local spell_de = string.sub(spell, 2, spelllength - 1);
			if (CEnemyCastBar_Afflictions[spell_de] or CEnemyCastBar_Spells[spell_de]) then spell = spell_de;
			end

			local NECBAfflictSpell = false;
			if (CEnemyCastBar_Afflictions[spell]) then
				NECBAfflictSpell = true;
			end

			if (NECBAfflictSpell or CEnemyCastBar_Spells[spell]) then

				if (NECBAfflictSpell and CEnemyCastBar_Afflictions[spell].periodicdmg) then
					return; -- don't hide dmg debuffs, can be other player's fade!
				end

				-- correct DR if a DR Spell fades earlier
				if (CEnemyCastBar.bClassDR and NECBAfflictSpell and CEnemyCastBar_Afflictions[spell].spellDR) then
					local drshare = CEnemyCastBar_Afflictions[spell].drshare;
					if (drshare) then
						CEnemyCastBar_UniqueCheck("DR: "..drshare, 15, mob, "trueupdate");
					else
						CEnemyCastBar_UniqueCheck("DR: "..spell, 15, mob, "trueupdate");
					end
				end

				for i=1, CEnemyCastBar.bNumBars do
	
					local spellrunning = getglobal("Carni_ECB_"..i).spell;
					if (spellrunning) then
	
						local mobrunning = getglobal("Carni_ECB_"..i).mob;
						if (mob == mobrunning and spell == spellrunning and not (NECBAfflictSpell and CEnemyCastBar_Afflictions[spell].multi) and getglobal("Carni_ECB_"..i).ctype ~= "cooldown") then
							
							CEnemyCastBar_HideBar(i);

							if (NECBAfflictSpell and (CEnemyCastBar_Afflictions[spell].global or CEnemyCastBar_Afflictions[spell].fragile) ) then
							-- Network BCasting
								BCPacket = {mob, spell, special};
								local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted);
								if ( freetosend ) then
									NECB_SendMessage(".cecbspell "..mob..", "..spell..", "..special..", "..clientlang..", "..latency);
									LastSentBCPacket = {mob, spell, special, GetTime()};
									LastGotBCPacket = {mob, spell, special, GetTime()};
									numspellcast = 0;
								end
							end

							break; -- there can be only one :D
					
						end
					end
				end
			end

		-- LAZARUS Interrupt effect, modified by Natur
		elseif (special == "interrupt") then

			for i=1, CEnemyCastBar.bNumBars do

				local spellrunning = getglobal("Carni_ECB_"..i).spell;
				if (spellrunning) then

					if (CEnemyCastBar_Spells[spellrunning]) then
						local mobrunning = getglobal("Carni_ECB_"..i).mob;

						if (mob == mobrunning and ( getglobal("Carni_ECB_"..i).ctype == "hostile" or getglobal("Carni_ECB_"..i).ctype == "friendly" ) ) then
							CEnemyCastBar_HideBar(i);

							-- Clear Spell in CD Buffer
							if (CEnemyCastBar.bUseCDDB and CEnemyCastBar.bCDown and CEnemyCastBar_Spells[spellrunning].d ) then
								local cdi = 1;
								while cdi <= table.getn(NECB_CD_DB) do
									if ( NECB_CD_DB[cdi][1] == mobrunning and NECB_CD_DB[cdi][2] == spellrunning ) then
										table.remove(NECB_CD_DB, cdi);
										-- clear visible bar now
										for i=1, CEnemyCastBar.bNumBars do
											local cdspell = getglobal("Carni_ECB_"..i).spell;
											if (cdspell and string.find(cdspell, " %(CD%)") ) then

												cdspell = string.gsub(cdspell, " %(CD%)", "");
												if (CEnemyCastBar_Spells[cdspell] and cdspell == spellrunning) then
													CEnemyCastBar_HideBar(i);
												end
											end
										end
										break;
									end
									cdi = cdi + 1;
								end
							end
							-- Clear Spell in CD Buffer finished

							return; -- no one is able to cast more than one spell at once
						end
					end
				end
			end

		-- clear on mob died; to save some CPU time breackit it out
		elseif (special == "died") then

			for i=1, CEnemyCastBar.bNumBars do

				local spellrunning = getglobal("Carni_ECB_"..i).spell;
				if (spellrunning) then

					-- remove DR Timers upon death
					if (string.find(spellrunning, "DR:")) then
						spellrunning = CECB_SPELL_STUN_DR;
					end

					local mobrunning = getglobal("Carni_ECB_"..i).mob;
					if (CEnemyCastBar_Afflictions[spellrunning]) then

						-- "if" mob can't die without removing the debuff, so this wasn't the 'afflicted' mob
						-- "death" negates the above
						local fragile = CEnemyCastBar_Afflictions[spellrunning].fragile;
						local death = CEnemyCastBar_Afflictions[spellrunning].death;

						if (mob == mobrunning and (not fragile or death)) then
							
							CEnemyCastBar_HideBar(i);

							if (CEnemyCastBar_Afflictions[spellrunning].global or CEnemyCastBar_Afflictions[spellrunning].fragile) then
							-- Network BCasting
								BCPacket = {mob, spell, special};
								local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted);
								if ( freetosend ) then
									NECB_SendMessage(".cecbspell "..mob..", "..spell..", "..special..", "..clientlang..", "..latency);
									LastSentBCPacket = {mob, spell, special, GetTime()};
									LastGotBCPacket = {mob, spell, special, GetTime()};
									numspellcast = 0;
								end
							end
						
						end

					-- to clear all but CD bars if mob dies
					elseif (CEnemyCastBar_Spells[spellrunning]) then

						if (mob == mobrunning and (CEnemyCastBar.bCDownShort or not string.find(getglobal("Carni_ECB_"..i).label, "(CD)") ) ) then
							CEnemyCastBar_HideBar(i);
						end --
					end
				end
			end

		-- other than faded/died
		elseif (CEnemyCastBar.bShowafflict) then

	 		-- only 'afflicted', DoTs allowed!
			if (special == "afflicted" or (CEnemyCastBar.bSDoTs and (special == "periodicdmg" or special == "periodichitdmg") ) ) then

	 			-- check if spell stacks
				local fbracket,_,spellstacks = string.find(spell, "(%(%d+%))" );
				if (fbracket) then
					spell = string.sub(spell, 1, fbracket - 2);
					spelllength = string.len (spell);
				end

				-- crop the german aposthrophes from some spells (')
				local spell_de = string.sub(spell, 2, spelllength - 1);
				if (CEnemyCastBar_Afflictions[spell_de]) then spell = spell_de;
				end
	
				-- database check
				if (CEnemyCastBar_Afflictions[spell]) then
	
					if (
								-- check if previously disabled with shift + leftclick
							(CEnemyCastBar_Afflictions[spell].disabled)
								-- break if 'mage cold debuff' but disabled
						or	(CEnemyCastBar_Afflictions[spell].magecold and not CEnemyCastBar.bMageC)
								-- periodic dmg spells shall only be triggered if they do damage, otherwise the affliction might be from another player!
						or	( (special == "afflicted" and CEnemyCastBar_Afflictions[spell].periodicdmg) or ((special == "periodicdmg" or special == "periodichitdmg") and not CEnemyCastBar_Afflictions[spell].periodicdmg) )
						or 	(CEnemyCastBar_Afflictions[spell].aZone and GetRealZoneText() ~= CEnemyCastBar_Afflictions[spell].aZone)
						or	(CEnemyCastBar_Afflictions[spell].blockZone and GetRealZoneText() == CEnemyCastBar_Afflictions[spell].blockZone)
								-- don't trigger castbars for your own debuffs if other than boss debuffs
						or	(mob == UnitName("player") and not CEnemyCastBar_Afflictions[spell].global)

						) then
						return;
					end
	
					alreadyshowing = 0;
					local icontex = CEnemyCastBar_Afflictions[spell].icontex; -- > get icon texture
					local globalspell = CEnemyCastBar_Afflictions[spell].global; -- > castbars without a target check (Raidencounter)!
					local fragile = CEnemyCastBar_Afflictions[spell].fragile; -- > for option to show "fragiles" without a target!
	
					if (UnitName("target") == mob or globalspell or (fragile and CEnemyCastBar.bGlobalFrag) or special == "periodicdmg" or special == "periodichitdmg") then
	
						castime = CEnemyCastBar_Afflictions[spell].t;

						local _, playersclass = UnitClass("player");

						-- Consider player level to modify duration
						if (CEnemyCastBar_Afflictions[spell].plevel) then
							local lcounter = 2;
							while (CEnemyCastBar_Afflictions[spell].plevel[lcounter] > UnitLevel("player") ) do
								lcounter = lcounter + 1;
							end
							castime = castime - (lcounter - 2)*CEnemyCastBar_Afflictions[spell].plevel[1];
						end

						-- Consider talent points to modify duration
						if (CEnemyCastBar_Afflictions[spell].tskill) then
							local _, _, _, _, currRank = GetTalentInfo(CEnemyCastBar_Afflictions[spell].tskill[1], CEnemyCastBar_Afflictions[spell].tskill[2]);
							if (currRank and currRank > 0 and playersclass == CEnemyCastBar_Afflictions[spell].tskill[4]) then
								if (CEnemyCastBar_Afflictions[spell].tskill[3] ~= 0) then
									castime = castime + currRank*CEnemyCastBar_Afflictions[spell].tskill[3];
								else
									castime = castime * (1 + currRank*CEnemyCastBar_Afflictions[spell].tskill[6] );
								end

								castime = castime + CEnemyCastBar_Afflictions[spell].tskill[5];
							end
						end

						-- Consider Combo points for duration; wait 3 secs for 'Rupture's first DoT damage!
						if (CEnemyCastBar_Afflictions[spell].cpinterval and playersclass == CEnemyCastBar_Afflictions[spell].cpclass and CECBownCPsHitTime and (GetTime() - CECBownCPsHitTime) < 3) then
							castime = castime - (CEnemyCastBar_Afflictions[spell].cpinterval * (5 - CECBownCPsHit));
							--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, castime="..castime.." -CECBownCPsHit="..CECBownCPsHit.." -cpinterval="..CEnemyCastBar_Afflictions[spell].cpinterval.." -timediff="..GetTime() - CECBownCPsHitTime) --!
						end
	
						if (special == "periodicdmg" or special == "periodichitdmg") then
							ctype = "cursetype";
						elseif (CEnemyCastBar_Afflictions[spell].stun or CEnemyCastBar_Afflictions[spell].stuntype) then
							ctype = "stuns";
						else
							ctype = "afflict";
						end
	
						-- DR START
						local DRTimer = 0;
						-- subfunction for DR Timer; CASTIME will be modified in Uni function (if DRText transmitted to funcion = last flag and label found -> after ELSE)
						local function CEnemyCastBar_DRBar(msg)
							if (CEnemyCastBar_UniqueCheck(msg, castime, mob, "true") == 0) then
								if (CEnemyCastBar_UniqueCheck(msg, castime, mob) == 0) then
									if (msg == CECB_SPELL_STUN_DR) then
										CEnemyCastBar_Show(mob, msg, castime, "cooldown", nil, "Spell_Frost_Stun");
									else
										CEnemyCastBar_Show(mob, msg, castime, "cooldown", nil, icontex);
									end
								end
								CEnemyCastBar_UniqueCheck(msg, 15 + castime, mob, nil, "(|cffff00001/2|r)");
							else
								_, DRTimer = CEnemyCastBar_UniqueCheck(msg, castime, mob, nil, "trigger label check in uni function");
							end
						end
	
						-- stun diminishing returns bar
						if (not CEnemyCastBar.bAfflictuni and CEnemyCastBar.bDRTimer and mob ~= UnitName("player") and CEnemyCastBar_Afflictions[spell].stun) then
	
							CEnemyCastBar_DRBar(CECB_SPELL_STUN_DR);
						end
	
						-- pvp diminishing returns bar
						-- playersclass already defined above
						if (CEnemyCastBar.bClassDR and not CEnemyCastBar.bAfflictuni and CEnemyCastBar_Afflictions[spell].spellDR and playersclass == CEnemyCastBar_Afflictions[spell].sclass and (UnitIsPlayer("target") or CEnemyCastBar_Afflictions[spell].affmob) and mob ~= UnitName("player")) then
							local drshare = CEnemyCastBar_Afflictions[spell].drshare;
							if (drshare) then
								CEnemyCastBar_DRBar("DR: "..drshare);
							else
								CEnemyCastBar_DRBar("DR: "..spell);
							end
						end

						if (DRTimer == 4 or DRTimer == 6) then
							castime = castime / (DRTimer - 2);
						end
						-- DR END

						if (
								-- only show this spell for specified class
								(CEnemyCastBar_Afflictions[spell].checkclass and playersclass ~= CEnemyCastBar_Afflictions[spell].checkclass)
								-- break if 'solo spell' but disabled
							or	(CEnemyCastBar_Afflictions[spell].solo and not CEnemyCastBar.bSoloD)
							) then
							return;
						end
	
						if (CEnemyCastBar_Afflictions[spell].m) then
						
							mob = CEnemyCastBar_Afflictions[spell].m
						
						end
	
						-- unique check; Raidspells (globalspell) won't be updated; Fragiles will be updated and multiple bars allowed
						if (fragile) then
							alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate");
						elseif (spellstacks) then
							if (globalspell) then
								alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate",spellstacks,"turnit");
							else
								alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,nil,spellstacks);
							end
						elseif (special == "periodicdmg" or special == "periodichitdmg") then
							if (special == "periodichitdmg" and CEnemyCastBar_Afflictions[spell].directhit) then
								alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate");
								castime = castime + 1.0;
							else
								if (event == "customdot") then
									local down, up, latency = GetNetStats();
									castime = castime + 1.0 + latency/1000; -- lag compensation to be 'safe' the bar does not run out before the DoT!
									alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate");
								else
									castime = castime - 1.5;
									alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"true");
								end

							end
						else
							alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,globalspell);
						end
	
						-- to detect if CPs are cleared AFTER a skill has been used, to update with correct duration afterwards if event "PLAYER_COMBO_POINTS" is fired
						if (CEnemyCastBar_Afflictions[spell].cpinterval and playersclass == CEnemyCastBar_Afflictions[spell].cpclass and not CEnemyCastBar_Afflictions[spell].periodicdmg) then
							CECBownCPsHitBuffer = {mob, spell, GetTime(), DRTimer };
						end
		
						if (globalspell or fragile) then
							-- Network BCasting
							BCPacket = {mob, spell, special};
							local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted);
							if ( freetosend ) then
								local modspell = spell;
								if (spellstacks) then
									modspell = spell.." "..spellstacks;
								end
								NECB_SendMessage(".cecbspell "..mob..", "..modspell..", "..special..", "..clientlang..", "..latency);
								LastSentBCPacket = {mob, modspell, special, GetTime()};
								LastGotBCPacket = {mob, modspell, special, GetTime()};
								numspellcast = 0;
							end
						end
	
						if (alreadyshowing == 0) then
	
							-- Check for non-Raiddebuff and if they are switched off
							-- turnaroundlabel through "globalspell" (turnlabel), because the name is more important then
							if (not (globalspell ~= "true" and CEnemyCastBar.bAfflictuni) ) then
	
								CEnemyCastBar_Show(mob, spell, castime, ctype, globalspell, icontex);
								if (spellstacks) then
									if (globalspell) then
										alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate",spellstacks,"turnit");
									else
										alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,nil,spellstacks);
									end
								end
							end
						end
					end

				end -- is spell in database?
		 	end -- check for afflicted/ DoTs option + periodicdmg

		end -- clear on mob fades/dies, elseif check option, afflictions set on?
		------ block end (afflictions+)

	end -- finishes pve 'else' pvp, died if afflictions/fades
		
end

function CEnemyCastBar_EngageProtection()

	if (necbengagecd and (GetTime() - necbengagecd) < necbEPTime) then
		return true;
	else
		return false;
	end
end

function CEnemyCastBar_Player_Enter_Combat() --enter combat (Aggro etc., not only melee autoattack -> "regen. disabled" event)

	if (CEnemyCastBar.bStatus and necbengagecd and (GetTime() - necbengagecd) > necbEPTime) then
		-- unregister additional Events used for Bosses (fight seems to be over)
		CarniEnemyCastBarFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
		CarniEnemyCastBarFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
		necbengagecd = nil;

		-- reset modified 't' to default
		while (NECBtchangeSource[1]) do
			CEnemyCastBar_Raids[CEnemyCastBar_Raids[ NECBtchangeSource[1] ].tchange[1]].t = CEnemyCastBar_Raids[ NECBtchangeSource[1] ].tchange[2];
			table.remove (NECBtchangeSource, 1);
		end

	end

	local targetmob;
	-- do not check the following with TargetOfTarget and ActiveCombat
	if (CEnemyCastBar.bStatus and not CEnemyCastBar_EngageProtection() ) then

		CEnemyCastBar_Player_Enter_Combat_Exception(); -- localized exceptions (C'Thun)

		if (UnitName("targettarget") or UnitAffectingCombat("target") ) then
			targetmob = UnitName("target");
		--DEFAULT_CHAT_FRAME:AddMessage("NECB: |cffffff00-= GO GO GO GO GO =-") --!
		else
			-- recharge the above check, because this event mostly is fired too fast for following checks or Warrior used Bloodrage right before engaging
			if (not necbengagedelay) then
				necbengagedelay = { GetTime(), GetTime(), 10, 0.5 }; -- 1) fixed, 2) resetted every check, 3) time checked, 4) check intervall
				CECBFauxFrameButton:Show();
			--DEFAULT_CHAT_FRAME:AddMessage("NECB: REDOING") --!
				return;
	
			elseif (GetTime() - necbengagedelay[1] < necbengagedelay[3]) then
				necbengagedelay[2] = GetTime();
			--DEFAULT_CHAT_FRAME:AddMessage("NECB: REDOING - "..GetTime() - necbengagedelay[1])
				return;
			end
		end

	end

	necbengagedelay = nil;
	CECBFauxFrameButton:Hide();

	if (CEnemyCastBar.bStatus and targetmob and not CEnemyCastBar_EngageProtection() ) then
		--DEFAULT_CHAT_FRAME:AddMessage("NECB: ENGAGE - |cffffff00Name Check: "..targetmob) --!
		CEnemyCastBar_Player_Enter_Combat_Execute(targetmob); --calls the localized part of 'enter combat'
	end

end

function CEnemyCastBar_Parse_RaidChat(msg, author, origin) --parse Raid/PartyChat for commands

	local detectedCECBcommand = true;

	if (CEnemyCastBar.bParseC and origin ~= "NECBCHAT") then

		if (
			string.sub (msg, 1, 10) == ".countsec "
			or string.sub (msg, 1, 10) == ".countmin "
			or string.sub (msg, 1, 8) == ".repeat "
			or string.sub (msg, 1, 11) == ".stopcount "
			or string.sub (msg, 1, 11) == ".cecbspell "
			or string.sub (msg, 1, 32) == "<NECB> version request detected."
			or string.sub (msg, 1, 33) == "<NECB> gversion request detected."
			) then


			--Network BC
			if (string.sub (msg, 1, 11) == ".cecbspell ") then

				wrongclient = false;
				if (UnitName("player") == author and origin ~= "NECBCTRA") then return detectedCECBcommand;
				end

				for bcmob, bcspell, bcspecial, bcclientlang, bclatency in string.gfind (msg, ".cecbspell (.+), (.+), (.+), (.+), (.+)") do

					if (bcclientlang ~= GetLocale()) then
						wrongclient = true;
						return detectedCECBcommand;
					end

					-- Check if last receive was the same packet within 5 seconds -> then break!
					if (LastGotBCPacket) then
						if (bcmob == LastGotBCPacket[1] and bcspell == LastGotBCPacket[2] and bcspecial == LastGotBCPacket[3] and (GetTime() - LastGotBCPacket[4]) < 5) then
							numspellcast = numspellcast + 1; 
							return detectedCECBcommand;
						end
					end

				--DEFAULT_CHAT_FRAME:AddMessage("m:"..bcmob.." s:"..bcspell.." t:"..bcspecial) --!
				numspellcast = 99;
				LastGotBCPacket = {bcmob, bcspell, bcspecial, GetTime()};
				CEnemyCastBar_Control(bcmob, bcspell, bcspecial, "true");
				return detectedCECBcommand;
				end

			else

				-- version harvester
				if (CECBHELPFrame:IsVisible() and CECBHELPFrameText:GetText() == "NECB - VERSIONS" ) then
					for version in string.gfind(msg, "<NECB> version request detected. (.+)") do
							version = string.sub(version, 2, string.len (version) - 1); -- remove brackets
							table.insert (VersionDB, version);
							table.insert (VersionNames, author);
							CEnemyCastBar_InternalHandler("printversions");
						return detectedCECBcommand;
					end

				-- gversion harvester
				elseif (CECBHELPFrame:IsVisible() and CECBHELPFrameText:GetText() == "NECB - GVERSIONS" ) then
					for version in string.gfind(msg, "<NECB> gversion request detected. (.+)") do
							version = string.sub(version, 2, string.len (version) - 1); -- remove brackets
							table.insert (VersionDB, version);
							table.insert (VersionNames, author);
							CEnemyCastBar_InternalHandler("printversions");
						return detectedCECBcommand;
					end
				end

				local msg1 = string.sub (msg, 2, string.len(msg));
				CEnemyCastBar_Handler(msg1);
				return detectedCECBcommand, "|cffffffcc";
			end

		end

	end

	if (origin == "NECB") then

		if string.find(msg, "<NECB> Force version collection.") then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Version request detected. Sending data.", 1, 0.5, 0);
			VersionDB = { };
			VersionNames = { };
			local playerbcaster = "";
			if (CEnemyCastBar.bBCaster and CEnemyCastBar.bParseC) then
				playerbcaster = ", BCASTER";
			end
			NECB_SendMessage("<NECB> version request detected. ("..CECB_status_version_txt..", "..GetLocale()..playerbcaster..")");
			return detectedCECBcommand, "|cffffffcc";

		elseif string.find(msg, "<NECB> Force gversion collection.") then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r GVersion request detected. Sending data.", 1, 0.5, 0);
			VersionDB = { };
			VersionNames = { };
			local playerbcaster = "";
			if (CEnemyCastBar.bBCaster and CEnemyCastBar.bParseC) then
				playerbcaster = ", BCASTER";
			end
			NECB_SendMessage("<NECB> gversion request detected. ("..CECB_status_version_txt..", "..GetLocale()..playerbcaster..")", nil, "toguild");
			return detectedCECBcommand, "|cffffffcc";

		elseif string.find(msg, "<NECB> Whisper old versions of NECB to update!") then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffffff00"..author.."|r notified some users!");
			return detectedCECBcommand, "|cffffffcc";

		elseif string.find(msg, "<NECB> FORCE (.+) to Broadcast! Change Settings!") then

			for forceplayer in string.gfind(msg, "<NECB> FORCE (.+) to Broadcast! Change Settings!") do

				if (forceplayer == UnitName("player") and CEnemyCastBar_CheckRaidStatus(author) ) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffffff00"..author.."|r has FORCED your NECB client to broadcast!");
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Settings have been changed.");

					CEnemyCastBar.bPvE = true;
					CEnemyCastBar.bShowafflict = true;
					CEnemyCastBar.bGlobalFrag = true;
					CEnemyCastBar.bParseC = true;
					CEnemyCastBar.bBCaster = true;

					if (CECBOptionsFrame and CECBOptionsFrame:IsVisible()) then
						CECB_ReloadOptionsUI();
					end
				end
			end
			return detectedCECBcommand, "|cffffffcc";

		elseif string.find(msg, "<NECB> STOP (.+) to Broadcast! Change Settings!") then

			for forceplayer in string.gfind(msg, "<NECB> STOP (.+) to Broadcast! Change Settings!") do

				if (forceplayer == UnitName("player") and CEnemyCastBar_CheckRaidStatus(author) ) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffffff00"..author.."|r has STOPPED your NECB client to broadcast!");
					DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffff9999Settings have been changed.");

					CEnemyCastBar.bBCaster = false;

					if (CECBOptionsFrame and CECBOptionsFrame:IsVisible()) then
						CECB_ReloadOptionsUI();
					end
				end
			end
			return detectedCECBcommand, "|cffffffcc";

		end

	elseif (origin == "NECBCHAT") then

		local rank, fileName = CEnemyCastBar_CheckRaidStatus(author);
		local color = { };
		if ( not fileName ) then
			color.r, color.g, color.b = 1, 1, 1;
		else
			color = RAID_CLASS_COLORS[fileName];
		end

		DEFAULT_CHAT_FRAME:AddMessage("|cffcc99ff\[NECB\] \[|r"..author.."|cffcc99ff\]: "..msg, color.r, color.g, color.b);
	end
end

function NECB_SendMessage(msgs, prefixadd, toguild) --send

	-- patch 1.12
	if (not prefixadd) then
		prefixadd = "";
	end

	if (GetNumBattlefieldStats() > 1 ) then
		SendAddonMessage("NECB"..prefixadd, msgs, "BATTLEGROUND");
	elseif (GetNumRaidMembers() ~= 0) then
		SendAddonMessage("NECB"..prefixadd, msgs, "RAID");
	elseif (GetNumPartyMembers() ~= 0 ) then
		SendAddonMessage("NECB"..prefixadd, msgs, "PARTY");
	elseif (toguild) then
		SendAddonMessage("NECB"..prefixadd, msgs, "GUILD");
	end

end

function CEnemyCastBar_OnUpdate() --Update

	local CECname=this:GetName();
	local CECno=this:GetID();
	local fauxbtn=getglobal("FauxTargetBtn"..CECno);

	local BarupTime = GetTime();
	if (not getglobal(CECname).updated or BarupTime - getglobal(CECname).updated > CEnemyCastBar.bThrottle) then
		getglobal(CECname).updated = BarupTime;

		if (this.endTime) then

			local now = GetTime();
			-- Update the spark, status bar and label
			local remains = this.endTime - now;
			local sparkPos = ((now - this.startTime) / (this.endTime - this.startTime)) * (195 + CEnemyCastBar.bnecbCBLBias);
			
			getglobal(CECname .. "_StatusBar"):SetValue(now);
			getglobal(CECname .. "_Text"):SetText( this.label );	
			getglobal(CECname .. "_StatusBar_Spark"):SetPoint("CENTER", getglobal(CECname .. "_StatusBar"), "LEFT", sparkPos, 0);
			
			if (CEnemyCastBar.bTimer) then
				
				getglobal(CECname .. "_CastTimeText"):SetText( CEnemyCastBar_NiceTime(remains) );
			
			end


			-- fantastic fading routine + flashing, fps independent :D
			local framerate = GetFramerate();
			local stepping = 2/framerate;
			if (stepping > 0.4 ) then stepping = 0.4; -- security for very low fps (< 5fps)
			elseif (stepping < CEnemyCastBar.bThrottle*2 ) then stepping = CEnemyCastBar.bThrottle*2; -- if fps is higher than barupdate
			end

			local baralpha = this:GetAlpha();
			local totalTime = this.endTime - this.startTime;
			if (CEnemyCastBar.bFlashit and (remains/totalTime) < 0.20 and remains < 10 and totalTime >= 20) then

				stepping2 = stepping/1.2 -- manipulate flashing-speed
				if ((baralpha - stepping2) >= 0.1) then
					baralpha = baralpha - stepping2;
					this:SetAlpha(baralpha);
				else
					this:SetAlpha(1);
				end

				-- Raidwarning /rw
				if (CEnemyCastBar.bPvEWarn and not this.warned and CEnemyCastBar_Raids[this.spell] ) then
					PlaySoundFile("Interface\\AddOns\\CEnemyCastBar\\Sounds\\bottleopen2.wav");
					this.warned = true;
				end

			else

				-- Raidwarning, reset to allow new warnings for this spell
				if (this.warned) then
					this.warned = nil;
				end

				if (baralpha + stepping <= CEnemyCastBar.bAlpha) then
					baralpha = baralpha + stepping;
					this:SetAlpha(baralpha);
				else
					if (baralpha ~= CEnemyCastBar.bAlpha) then
						this:SetAlpha(CEnemyCastBar.bAlpha);
					end
				end
			end
			-- fading routine finished

			if (remains < 0) then

				if (string.find (getglobal(CECname).label, "Repeater") ) then

					local castime = getglobal(CECname).endTime - getglobal(CECname).startTime;
					getglobal(CECname).startTime = GetTime();
					getglobal(CECname).endTime = getglobal(CECname).startTime + castime;
					getglobal(CECname.."_StatusBar"):SetMinMaxValues(getglobal(CECname).startTime,getglobal(CECname).endTime);
					getglobal(CECname.."_StatusBar"):SetValue(getglobal(CECname).startTime);

					if (castime == 0) then
						getglobal(CECname).label = "delete me!";
					end

				else

					local tmpmob = getglobal(CECname).mob;
					local tmpspell = getglobal(CECname).spell;
					if (tmpspell == "Move this bar!" and lockshow == 1) then
						lockshow = 0;
						if (CEnemyCastBar.bLocked == false) then
							CEnemyCastBar_LockPos();
						end

					-- check special flags for bars running out
					elseif ( UnitAffectingCombat("player") or UnitIsDead("player") ) then

	 					-- check for tchange flag; changes the 't' of castbars if current bar runs out
						if (CEnemyCastBar_Raids[tmpspell] and CEnemyCastBar_Raids[tmpspell].tchange) then
							CEnemyCastBar_Raids[CEnemyCastBar_Raids[tmpspell].tchange[1]].t = CEnemyCastBar_Raids[tmpspell].tchange[3];
							table.insert (NECBtchangeSource, tmpspell);
							necbengagecd = GetTime(); -- starts the EngageProtection to reset 't' to default for next combat
						end

						-- check for aBar flag; Fires 'aBar' if current bar runs out
						if (CEnemyCastBar_Raids[tmpspell] and CEnemyCastBar_Raids[tmpspell].aBar ) then
							CEnemyCastBar_HideBar(CECno);
							CEnemyCastBar_Control(tmpmob, CEnemyCastBar_Raids[tmpspell].aBar, "casts", "true"); -- won't be broadcasted!
							return;
						end

					end

					-- trigger cooldown bar at the end of the cast
					if ( CEnemyCastBar.bCDown and CEnemyCastBar_Spells[tmpspell] and ( getglobal(CECname).ctype == "hostile" or getglobal(CECname).ctype == "friendly" ) ) then

						if ( CEnemyCastBar_Spells[tmpspell].d and CEnemyCastBar_Spells[tmpspell].t and ( UnitIsPlayer("target") or CEnemyCastBar.bGlobalPvP) ) then
		
							local castime = CEnemyCastBar_Spells[tmpspell].d;
							if (not (castime > 60 and CEnemyCastBar.bCDownShort) ) then

								if (CEnemyCastBar_UniqueCheck(tmpspell.." (CD)", castime, tmpmob, "trueupdate") == 0) then
									CEnemyCastBar_HideBar(CECno);
									CEnemyCastBar_Show(tmpmob, tmpspell.." (CD)", castime, "cooldown", nil, CEnemyCastBar_Spells[tmpspell].icontex);
									return;
								end
							end
						end
					end

					CEnemyCastBar_HideBar(CECno);

				end


				-- pull the bars together
			elseif (remains >= 5 ) then

				local CECpre = CECno - 1;
				local cecbuttonpre = getglobal("Carni_ECB_"..CECpre);

				if (CECpre > 0 and not cecbuttonpre:IsShown()) then

					cecbuttonpre.startTime = this.startTime
					cecbuttonpre.label = this.label;
		
					local r,g,b = getglobal("Carni_ECB_"..CECno.."_Text"):GetShadowColor();
					getglobal("Carni_ECB_"..CECpre.."_Text"):SetShadowColor(r,g,b);
		
					if (getglobal("Carni_ECB_"..CECno.."_Icon"):IsShown()) then
						getglobal("Carni_ECB_"..CECpre.."_Icon"):SetTexture(getglobal("Carni_ECB_"..CECno.."_Icon"):GetTexture());
						getglobal("Carni_ECB_"..CECpre.."_Icon"):Show();
					end
		
					cecbuttonpre.spell = this.spell;
					cecbuttonpre.mob = this.mob;
					cecbuttonpre.ctype = this.ctype;
					cecbuttonpre.endTime = this.endTime;
					getglobal("Carni_ECB_"..CECpre.."_StatusBar"):SetMinMaxValues(getglobal("Carni_ECB_"..CECno.."_StatusBar"):GetMinMaxValues());
					getglobal("Carni_ECB_"..CECpre.."_StatusBar"):SetValue(getglobal("Carni_ECB_"..CECno.."_StatusBar"):GetValue());
					getglobal("Carni_ECB_"..CECpre.."_StatusBar"):SetStatusBarColor(getglobal("Carni_ECB_"..CECno.."_StatusBar"):GetStatusBarColor());
					getglobal("FauxTargetBtn"..CECpre):Show();
					cecbuttonpre:SetAlpha(CEnemyCastBar.bAlpha);
					cecbuttonpre:Show();
		
					CEnemyCastBar_HideBar(CECno);
				end
			end
		
		end
	end
end

-- Movable window
function CEnemyCastBar_OnDragStart()
    CarniEnemyCastBarFrame:StartMoving();
end

function CEnemyCastBar_OnDragStop()
    CarniEnemyCastBarFrame:StopMovingOrSizing();
end

-- Format seconds into m:ss
function CEnemyCastBar_NiceTime(secs)
	if (secs > 60) then
		secs = ceil(secs);
		return string.format("%d:%02d", secs / 60, math.mod(secs, 60));
	elseif (secs > 10) then
		secs = ceil(secs);
		return string.format("%.f", secs); -- I noticed sometimes the ceil command does not work, so it is formatted for that case as well
	else
		return string.format("%.1f", secs);
	end
end


function CEnemyCastBar_FPSBar_OnUpdate() --FPSBar

	local BarupTime = GetTime();
	if (not CECB_FPSBarFree_StatusBar.updated or BarupTime - CECB_FPSBarFree_StatusBar.updated > CEnemyCastBar.bThrottle) then
		CECB_FPSBarFree_StatusBar.updated = BarupTime;

		local framerate = GetFramerate();
		local g = framerate/30;
		local r = 30/framerate;
	
		if (g > 1) then g = 1;	end
		if (r > 1) then r = 1;	end
	
		if (framerate > 100) then frameratesafe = 100;
		else frameratesafe = framerate;
		end
	
		CECB_FPSBarFree_StatusBar:SetMinMaxValues(1,100);
		CECB_FPSBarFree_StatusBar:SetValue(frameratesafe);
		CECB_FPSBarFree_StatusBar_Spark:SetPoint("CENTER", "CECB_FPSBarFree_StatusBar", "LEFT", frameratesafe*1.95, 0);
		CECB_FPSBarFree_Text:SetText("|cffffffaaFPS: |cffffcc00"..ceil(framerate));
		CECB_FPSBarFree_StatusBar:SetStatusBarColor(r,g,0);

	end

end

function CECB_GCInfo_OnUpdate() --gcinfo

	local GCTime = GetTime();

	if (not lastgcupdate or GCTime - lastgcupdate > 0.5) then
		lastgcupdate = GCTime;

		local cecbgc_now, cecbgc_max = gcinfo();
		--local cecbgc_now = collectgarbage("count"); --BC after BC, delete above!

		if (not cecbgc_last or cecbgc_last > cecbgc_now) then
			cecbgc_last = cecbgc_now;
			cecbgc_min = cecbgc_now;
			--cecbgc_max = cecbgc_now*2; --BC after BC and use global
			cecbgc_minupdate = GCTime;
			lastgcdiffupdate = nil;
			cecbgc_purge30 = 0;
		end

		if (not lastgcdiffupdate or GCTime - lastgcdiffupdate > 5) then
			lastgcdiffupdate = GCTime;
	
			cecbgcdiff = (cecbgc_now - cecbgc_last) / 5;
			cecbgc_last = cecbgc_now;

			--BC, clear from here downwards, remove time presumption; BUT possibly not necessary!!! Might still work
			local GCPurgeCalcLength = 30;
			if ((GCTime - cecbgc_minupdate) > GCPurgeCalcLength) then
				if (cecbgc_min == cecbgc_now) then
					cecbgc_purge30 = 0;
				else
					cecbgc_purge30 = (cecbgc_max - cecbgc_now) * (GCTime - cecbgc_minupdate) / (cecbgc_now - cecbgc_min);
				end
				cecbgc_min = cecbgc_now;
				cecbgc_minupdate = GCTime;
			end

			if (cecbgc_min == cecbgc_now and cecbgc_purge30 == 0) then
				cecbgcpurge = "waiting...";
				-- cecbgcpurge = "collecting!"; --BC after BC
			else
				if (cecbgc_min == cecbgc_now) then
					cecbgcpurge = cecbgc_purge30;
				else
					if (GCTime - cecbgc_minupdate > GCPurgeCalcLength or cecbgc_purge30 == 0) then
						cecbgcpurge = (cecbgc_max - cecbgc_now) * (GCTime - cecbgc_minupdate) / (cecbgc_now - cecbgc_min);
					else
						cecbgcpurge = (cecbgc_purge30 * (GCPurgeCalcLength - (GCTime - cecbgc_minupdate)) / GCPurgeCalcLength) + (cecbgc_max - cecbgc_now) * (GCTime - cecbgc_minupdate) / (cecbgc_now - cecbgc_min) * (GCTime - cecbgc_minupdate) / GCPurgeCalcLength;
					end
				end

				if (cecbgcpurge >= 3600) then
					cecbgcpurge = string.format("%d:%02d (|cffffccccHour|r:|cffccffccMin|r)", cecbgcpurge / 3600, math.mod(cecbgcpurge / 60, 60));
				elseif (cecbgcpurge >= 60) then
					cecbgcpurge = string.format("%d:%02d (|cffccffccMin|r:|cffccccffSec|r)", cecbgcpurge / 60, math.mod(cecbgcpurge, 60));
				else
					cecbgcpurge = string.format("%d (|cffccccffSeconds|r)", cecbgcpurge);
				end
			end

		end

		local gctext1 = "|cffffff00This is a simple tool to observe the memory usage of all your addons!\n\n";
		local gctext2 = "|cffcccc00Estimated time until purge: |r"..cecbgcpurge.."\n\n";
		local gctext3 = "|cffccccffUsed Memory |r- |cffffccccGainRate |r- |cffccffccMaximum\n";
		local gctext4 = "|cff9999ff"..cecbgc_now.."|rkb - |cffff9999"..cecbgcdiff.."|rkb/s - |cff99ff99"..cecbgc_max.."|rkb";
		CECBGCFrameBGText:SetText(gctext1..gctext2..gctext3..gctext4, 0.8, 0.8, 0.8);

	end

end

function CEnemyCastBar_Validchar(msg) --validchar

	value = true;

	for i = 1, string.len(msg) do

		local ctable = string.byte(string.sub(msg,i,i));
		if ( not ( (ctable >= 48 and ctable <= 57) or (ctable >= 65 and ctable <= 90) or (ctable >= 97 and ctable <= 122) ) ) then
			value = false;
		end
	end

	return value;
end

function CEnemyCastBar_LoadDisabledSpells(msg) --loaddisabled

	DisabledSpells = { };

	local i = 1;
	while (CEnemyCastBar.tDisabledSpells[i]) do

			local spell = CEnemyCastBar.tDisabledSpells[i];
			if (CEnemyCastBar_Raids[spell]) then
				CEnemyCastBar_Raids[spell].disabled = true;
			end
	
			if (CEnemyCastBar_Spells[spell]) then
				CEnemyCastBar_Spells[spell].disabled = true;
			end
	
			if (CEnemyCastBar_Afflictions[spell]) then
				CEnemyCastBar_Afflictions[spell].disabled = true;
			end

		table.insert (DisabledSpells, CEnemyCastBar.tDisabledSpells[i]);
		i = i + 1;
	end

	if (not msg) then
		if (table.getn (DisabledSpells) == 0) then
			DSpells = "Nothing disabled found! |rEmpty table loaded.";
		else
			i = i - 1;
			DSpells = i.." |rDisabled Spells loaded. (see |cff00ff00/necb disabled|r)";
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffff00 "..DSpells);
	end

end

function CEnemyCastBar_SetRange(param) --setrange

	local RangeValues = { };

	if (param == "allmax") then
		RangeValues = {"150", "150", "150", "150", "150", "150", "150", "150"};
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r All CombatLogRanges set to |cffffff00maximum|r!");
	elseif (param == "cmax") then
		RangeValues = {"150", "150", "50", "50", "50", "50", "50", "50"};
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Creature CombatLogRanges set to |cffffff00maximum|r others set to defaults!");
	else
		RangeValues = {"60", "30", "50", "50", "50", "50", "50", "50"};
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r All CombatLogRanges set to |cffffff00defaults|r!");
	end

	SetCVar("CombatDeathLogRange" , RangeValues[1]);
	SetCVar("CombatLogRangeCreature" , RangeValues[2]); 
	SetCVar("CombatLogRangeFriendlyPlayers" , RangeValues[3]);
	SetCVar("CombatLogRangeFriendlyPlayersPets" , RangeValues[4]);
	SetCVar("CombatLogRangeHostilePlayers" , RangeValues[5]);
	SetCVar("CombatLogRangeHostilePlayersPets" , RangeValues[6]);
	SetCVar("CombatLogRangeParty" , RangeValues[7]);
	SetCVar("CombatLogRangePartyPet" , RangeValues[8]);
end