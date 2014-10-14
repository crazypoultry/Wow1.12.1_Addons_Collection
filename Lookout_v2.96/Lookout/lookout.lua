-- Globals:
-- ========
-- LookoutSavedVars = {};

LookoutVersion=2.9;
LookoutOptions_variablesLoaded = false;
LookoutRaidInfoByName ={};
Lookout_Debug=false;
Lookout_ShowEvent=false;
LookoutDoneComplaining=false;
LookoutPrefs_PanelFrames =

{
	"LookoutBossPanel",
	"LookoutSummonerPanel",
	"LookoutFusePanel",
	"LookoutHelpPanel"
};
LookoutPrefs_CurrentPanel=0;

LookoutNonEnemyBuffs={};
LookoutNonEnemyBuffs["Spell_Nature_Sleep"]= true;
LookoutNonEnemyBuffs["Spell_Nature_Polymorph"]= true;
LookoutNonEnemyBuffs["Shadow_Cripple"]= true; -- warlock banis
LookoutNonEnemyBuffs["Ability_Sap"]= true;
LookoutNonEnemyBuffs["Spell_Nature_Sleep"]= true; -- druid sleep
LookoutNonEnemyBuffs["Spell_Shadow_MindSteal"]= true; -- succubus charm, rogue blind, 
LookoutNonEnemyBuffs["Spell_Shadow_EnslaveDemon"]= true; -- warlock enslave demon
-- LookoutNonEnemyBuffs["Spell_Shadow_ShadowWordDominate"]= true; -- priest mind control (not needed becaus it is non-combatant)
-- add charmed, banished, 
if (SchnoggoAlert_FontFileBig) then
	Lookout_FontFileBig=SchnoggoAlert_FontFileBig;
else
	Lookout_FontFileBig="Interface\\AddOns\\Lookout\\Fonts\\BorisBlackBloxx.ttf";
end 
-- debugging stuff:
LookoutTestEvent="CHAT_MSG_MONSTER_EMOTE";
LookoutTestArg1="The living are here!";
LookoutTestArg2="Eye of Naxxramas";


-- Locals:
-- =======

local MYADDON_NAME = "lookout";
local MYADDON_VERSION = "2.9";
local MYADDON_AUTHOR = "Schnoggo";
local MYADDON_EMAIL = "schnoggo@gmail.com";
local MYADDON_WEBSITE = "http://schnoggo.com";
local OPTIONS_FRAME = "LookoutPrefsFrame";




local myPlayerRealm=GetCVar("realmName");
local myPlayerName=UnitName("player");
local myPlayerClassText, myPlayerClassType = UnitClass("player");

-- default config settings   
local LookoutDefaults={
		LookoutPrefsFrameMandokirAlert=true,
		LookoutPrefsFrameMandokirAction = true,
		LookoutPrefsFrameGeddonMeAlert = true,
		LookoutPrefsFrameGeddonOtherAlert = true,
		LookoutPrefsFrameNaxxramasAlert = true,
		LookoutPrefsFrameNaxxramasAction = true,
		LookoutPrefsFrameKilroggAlert = true,
		LookoutPrefsFrameKilroggAction = true,
		LookoutPrefsFrameBlackhandSummonerAlert = true,
		LookoutPrefsFrameBlackhandSummonerAction = true,
		LookoutPrefsFrameMobileAlertSystemAlert = true,
		LookoutPrefsFrameMobileAlertSystemAaction = true,
		LookoutPrefsDomoShields = true,
		LookoutPrefsDomoMagic = true,
		LookoutPrefsDomoPhysical = true,
		LookoutPrefsFrameZGBatRider = true,
		LookoutPrefsFrameArlokkAction = false,
		LookoutPrefsFramePoisonCloud = true,
		LookoutPrefsFrameOnyAlert=true
	};


-- Adjust defaults based on class:
if (myPlayerClassType == "PRIEST") then
	LookoutDefaults["LookoutPrefsFrameArlokkAction"] = true;
	LookoutDefaults["LookoutPrefsFrameNaxxramasAction"] = false;
	LookoutDefaults["LookoutPrefsFrameBlackhandSummonerAction"] = false;
	LookoutDefaults["LookoutPrefsFrameMobileAlertSystemAaction"] = false;
end

if (myPlayerClassType == "MAGE") then
	LookoutDefaults["LookoutPrefsDomoPhysical"] = false;
end


if (myPlayerClassType == "ROGUE") then
	LookoutDefaults["LookoutPrefsDomoMagic"] = false;
end

if (myPlayerClassType == "HUNTER") then
	LookoutDefaults["LookoutPrefsDomoMagic"] = false;
end

if (myPlayerClassType == "PALADIN") then
	LookoutDefaults["LookoutPrefsDomoPhysical"] = false;
end



-- My local functions:
-- ====================



-- Event functions
-- Onload:
function Lookout_OnLoad()
	-- this:RegisterEvent("ADDON_LOADED");

	-- Register the slash command
	-- --------------------------
	SLASH_LOOKOUT1 = "/lookout";
	SlashCmdList["LOOKOUT"] = Lookout_CommandLine;



-- Register the event handlers:
-- =============================	
-- this:RegisterEvent("VARIABLES_LOADED"); -- eventually will call OnEvent	
this:RegisterEvent("CHAT_MSG");
this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
this:RegisterEvent("CHAT_MSG_MONSTER_SAY");
this:RegisterEvent("CHAT_MSG_MONSTER_WHISPER");
this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"); -- "afflicted by"
this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"); -- "afflicted by"
this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"); -- "badguy gains Damge Shield."
this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER"); -- "Damge Shield fades" (from bad guy)


 
this:RegisterEvent("CHAT_MSG_EMOTE");
this:RegisterEvent("CHAT_MSG_TEXT_EMOTE");
-- this:RegisterEvent("CHAT_MSG_SAY");
this:RegisterEvent("CHAT_MSG_YELL");



-- raid command stuff:
this:RegisterEvent("CHAT_MSG_RAID");
this:RegisterEvent("CHAT_MSG_PARTY");

-- Party/Roster stuff:
this:RegisterEvent("RAID_ROSTER_UPDATE");
this:RegisterEvent("PARTY_LEADER_CHANGED");
this:RegisterEvent("CHAT_MSG_CHANNEL"); -- debug only
this:RegisterEvent("VARIABLES_LOADED");



-- researching:
-- CHAT_MSG_RAID_BOSS_EMOTE
-- 
-- arg1 
--    emote message 
-- arg2 
--    Name of the boss 

-- this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF");

-- CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF
-- 
-- Fired when a mob begins casting a beneficial spell and again when the casting is completed. 
-- arg1 is the full combat chat text. Examples: Mob begins to cast Heal. 
-- Mob's Heal heals Mob for 20. 


-- specifics:
-- High Priestess Jeklik begins to cast a Great Heal
-- Gurubashi Bat Rider fully engulfs in flame and a maddened look appears in his eyes!





	if (not myPlayerName) then
		myPlayerName = UnitName("player");
	end

	DEFAULT_CHAT_FRAME:AddMessage(LOOKOUT_TITLE.." loaded. Type /lookout to change settings.",  0.5, 1.0, 0.5, 1);


	

end -- OnLoad





	
function Lookout_Event(event)
if (event==nil) then
	event=LookoutTestEvent;
	arg1=LookoutTestArg1;
	arg2=LookoutTestArg2;
	DEFAULT_CHAT_FRAME:AddMessage("Lookout: event="..event .. " arg1="..arg1.." arg2="..arg2,  0.5, 1.0, 0.5, 1);
end
local eventHandled = false;
local msgText = "";
local currentTarget=UnitName("target");
-- oh to have a case statement!

-- debug
if (Lookout_ShowEvent) then
	DEFAULT_CHAT_FRAME:AddMessage("Lookout: event "..event,  0.5, 1.0, 0.5, 1);
end


if (LookoutRaidInfoByName[myPlayerName] == nil) then
	Lookout_UpdateRaidtable();
end



-- VARIABLES_LOADED
-- ================

	if ( event == "VARIABLES_LOADED" ) then
		LookoutFixDefaults();
		
		
		-- record that we have been loaded
		LookoutOptions_variablesLoaded = true;
		eventHandled = true;
	end -- ( event == "VARIABLES_LOADED" )
	
	
	
	
-- Raid update event
-- ===========================
	if (eventHandled == false) then
		if ((event == "RAID_ROSTER_UPDATE") or (event == "PARTY_LEADER_CHANGED") or (event == "PARTY_MEMBERS_CHANGED")) then 
			Lookout_UpdateRaidtable();
			eventHandled = true;
		end
		
	end

	
	
-- Raid chat events (incoming)
-- ===========================
	if (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_PARTY" or event =="CHAT_MSG_CHANNEL") then
		-- arg1 = messsage text
		-- arg2 = message sender
		local sendingMember = nil;
		local inStr;
		local msgStr;
		local cmdStr;
		local toss;
		local toss2;
		
		
		-- end -- (string.find( arg1, "::")
		
	end -- event=CHAT_MSG_RAID et. al.
	
	
	if (eventHandled == false) then
		msgText = string.lower(arg1);
	end 
	
-- Monster yells and emotes:
-- ===========================
	if (string.find(event, "MSG_MONSTER") ) then	
		-- CHAT_MSG_MONSTER_YELL, arg1= message text
		-- CHAT_MSG_MONSTER_YELL, CHAT_MSG_MONSTER_EMOTE, CHAT_MSG_MONSTER_SAY, CHAT_MSG_MONSTER_WHISPER"
		Lookout_DBM(event..":"..arg1);
		
		-- Mandokir's message is in CHAT_MSG_MONSTER_YELL channel
		-- Mandokir's gaze: 
		if (arg1 ~= nil and myPlayerName ~= nil) then
			if (string.find(arg1, myPlayerName))   then
				if ((string.find( msgText, "eye on"))   or (string.find( string.lower(arg1), "watching you")) ) then
					if (LookoutSavedVars["LookoutPrefsFrameMandokirAction"]) then
						-- ClearTarget(); -- no longer sufficient
						TargetUnit("player");
					end	
				
					if (LookoutSavedVars["LookoutPrefsFrameMandokirAlert"]) then
						PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
						message( " Lookout! Mandokir has his eye on you! ");
					end	
				eventHandled = true; -- whether we take action or not, this is the event
				Lookout_DBM("Event handled for Mandokir");
				end -- Mandokirs' eye message
			end -- message contains player name
		end -- params not nil	
			

			
	
	if (eventHandled == false) then
		if (arg2 ~= nil) then -- did the message come from a specific source?			
			-- Eye of Naxxramas: CHAT_MSG_MONSTER_YELL
			if (string.find( string.lower(arg2), "eye of naxxramas")) then
				if (LookoutSavedVars["LookoutPrefsFrameNaxxramasAlert"]) then
					LookoutAlertHandler(" Kill the eye! ");
				end	
	
	
				if (LookoutSavedVars["LookoutPrefsFrameNaxxramasAction"]) then
					TargetByName(arg2);
					-- UseAction(4);
					-- AttackTarget();
				end	
			eventHandled = true; -- whhether we take action or not, this is the event
			Lookout_DBM("Event handled for Eye of Naxxramas");
			end -- Eye of Naxxramas
		end -- arg2 not nil
	end --- not handled
	
	
	
		
	if (eventHandled == false) then
		-- Eye of Kilrogg:
		if (string.find( msgText, "opens a nether portal")) then -- announces in EMOTE?
			if (LookoutSavedVars["LookoutPrefsFrameKilroggAlert"]) then
				LookoutAlertHandler(" Kill the eye! ");
			end	
	
	
			if (LookoutSavedVars["LookoutPrefsFrameKilroggAction"]) then
				TargetByName("Wandering Eye of Kilrogg");
				-- UseAction(4);
				-- AttackTarget();
			end	
			eventHandled = true; -- whether we take action or not, this is the event
			Lookout_DBM("Event handled for Eye of Kilrogg");
		end -- Wandering Eye of Kilrogg
	end --- not handled
	
	
	
	
	
	
	
	if (eventHandled == false) then	

		-- Blackhand Summoner:
		if (string.find( msgText, "begins to summon in")) then -- blackhand summoner begins
		
			Lookout_DBM("summoner detected.");
			if (LookoutSavedVars["LookoutPrefsFrameBlackhandSummonerAlert"]) then
				LookoutAlertHandler(" Kill the Summoner! ");
			end	
-- dbc...
			local targetName=arg2;
			if (targetName == nil) then
				targetName="Blackhand Summoner";
			end
			Lookout_ScanForTarget(targetName);

-- ...dbc
	
	
	
			if (LookoutSavedVars["LookoutPrefsFrameBlackhandSummonerAction"]) then
			local targetName=arg2;
			if (targetName == nil) then
				targetName="Blackhand Summoner";
			end 
			Lookout_FindTargetInCrowd(targetName);				
			-- UseAction(4);
			-- AttackTarget();
			end	
			eventHandled = true; -- whether we take action or not, this is the event
			Lookout_DBM("Event handled for Blackhand Summoner");
		end -- Blackhand Summoner
	end --- not handled

	
		
	if (eventHandled == false) then	
		-- Arlokk:
		local strStart, strEnd, otherPlayerName = string.find(arg1, "Feast on ([^%s]+), my pretties"); -- leave it case sensitive
		if (otherPlayerName) then -- Arlokk has targetted a player
			Lookout_DBM("Arlokk set target");

			if (LookoutSavedVars["LookoutPrefsFrameArlokkAction"]) then
				LookoutAlertHandler(otherPlayerName.."is marked. HEAL!");
				TargetByName(otherPlayerName);
			end	

			eventHandled = true; -- whether we take action or not, this is the event
			Lookout_DBM("Event handled for Arlokk");

		end -- Blackhand Summoner
	end --- not handled

	
	
	if (eventHandled == false) then
		if not (arg2 == nil) then -- did the message come from a specific source?			
			-- Mobile Alert System (Alarm-bot)
			if (string.find( string.lower(arg2), "mobile alert system")) then
				if (LookoutSavedVars["LookoutPrefsFrameMobileAlertSystemAlert"]) then
					LookoutAlertHandler(" Destroy the Mobile Alert System! ");
				end	
	
	
				if (LookoutSavedVars["LookoutPrefsFrameMobileAlertSystemAaction"]) then
					Lookout_FindTargetInCrowd(arg2);
				end	
			eventHandled = true; -- whether we take action or not, this is the event
			Lookout_DBM("Event handled for Mobile Alert System");
			end -- Mobile Alert System (Alarm-bot)
		end -- arg2 not nil
	end --- not handled
	
	
	
-- Onyxia	
	if (eventHandled == false) then
		if (arg2 ~= nil) then -- did the message come from a specific source?			
			-- Eye of Naxxramas: CHAT_MSG_MONSTER_YELL
			if (string.find( string.lower(arg2), "onyxia")) then
				if (string.find( string.lower(arg1), "deep breath")) then 
					-- if (LookoutSavedVars["LookoutPrefsFrameNaxxramasAlert"]) then
						LookoutAlertHandler("Onyxia Breaths Deep - Get out of the way!");
					-- end	
		
				eventHandled = true; -- whhether we take action or not, this is the event
				Lookout_DBM("Event handled for Eye of Naxxramas");
			end
			end -- onyxia
		end -- arg2 not nil
	end --- not handled
	
	
	
	
-- explosion emotes:
	if (eventHandled == false) then
		-- Gurubashi Bat Rider:
		if (string.find( msgText, "fully engulfs")) then -- announces in EMOTE?
			if (LookoutSavedVars["LookoutPrefsFrameZGBatRider"]) then
				LookoutAlertHandler(" Bat Rider is going to blow! RUN! ");
			end	

			eventHandled = true; -- whether we take action or not, this is the event
		end -- "fully engulfs" aka Bat Rider
	end --- not handled
	
	
end --  MSG_MONSTER




-- Check for buffs:
-- ===========================
	if (string.find(event, "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")) then	
		Lookout_DBM("SELF_DAMAGE:"..arg1);
		-- "You are afflicted by Living Bomb."
		if (string.find(arg1, "You are afflicted by Living Bomb")) then
			 if (LookoutSavedVars["LookoutPrefsFrameGeddonMeAlert"]) then
				LookoutAlertHandler(" You are the bomb! Get away from the group! ");
		 	end	
		end -- living bomb
		
		if (string.find(arg1, "Poison Cloud")) then
			LookoutAlertHandler(" Cloud!! ");
		end
		
	end
	
	if (string.find(event, "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")) then	
		Lookout_DBM("FRIENDLYPLAYER_DAMAGE:"..arg1);
		-- "You are afflicted by Living Bomb."
		local strStart, strEnd, otherPlayerName = string.find(arg1, "([^%s]+) is afflicted by Living Bomb");
		
		if (otherPlayerName) then
			 if (LookoutSavedVars["LookoutPrefsFrameGeddonOtherAlert"]) then
				LookoutAlertHandler(otherPlayerName.." is the bomb!");
		 	end	
		end -- living bomb
	end
	
	-- message("MSGTYPE:".. event .."MSG:"..arg1.." from: "..arg2 .. "arg3="..arg3);
	-- TakeScreenshot();
-- message("Zone:"..ZoneName);
	



if (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
	if (string.find(arg1, "gains Magic Reflection")) then
		if (LookoutSavedVars["LookoutPrefsDomoShields"]) then
			LookoutAlertHandler("Magic Reflection UP");
		end
		if (LookoutSavedVars["LookoutPrefsDomoMagic"]) then
			TargetUnit("player");
		end
		
	end
	if (string.find(arg1, "gains Damage Shield")) then
		if (LookoutSavedVars["LookoutPrefsDomoShields"]) then
			LookoutAlertHandler("Physical Damage Shield UP");
		end
		if (LookoutSavedVars["LookoutPrefsDomoPhysical"]) then
			TargetUnit("player");
		end
	end
end

if (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then -- "Damge Shield fades" (from bad guy)

end



-- RESEARCH
-- show which channel an unknown even is occuring in

if (Lookout_Debug) then
	local i=0; -- if I new LUA better, I'd know a better way to limit the scope here. :)
	if (arg1 ~= nil) then
	-- do tests for arg 1
	
		for i = 1,4 do
			if (string.find(arg1, Lookout_Research[i])) then
				-- elliminate damage stuff:
				if (string.find(arg1, "hits you")) then
				
				else
					Lookout_DBM("R&D: channel="..event.." arg1="..arg1);
				end
			end
		end
	end
	
if (arg2 ~= nil) then
	-- do tests for arg 1
		for i = 1,4 do
			if (string.find(arg2, Lookout_Research[i])) then
				-- elliminate damage stuff:
				if (string.find(arg2, "hits you")) then
				else
					Lookout_DBM("R&D: channel="..event.." arg2="..arg2);
				end
			end
		end
	end
	
end





-- "gains Magic Reflection";
-- 	= "gains Damage Shield";
--  "Magic Reflection fades";
-- = "Damage Shield fades";






end -- end of function
 


-- command line parameters: (slash command handler)
function Lookout_CommandLine(msg)
	cmd=string.lower(msg);

	if ( ( msg=="1") or (msg=="")) then
		LookoutPrefsFrame:Show();
	end

	if ( msg =="0") then
		LookoutPrefsFrame:Hide();
	end
		

	if ( msg =="debug") then
		Lookout_Debug = (not Lookout_Debug);
	end	
	if ( msg =="showevent") then
		Lookout_ShowEvent = (not Lookout_ShowEvent);
	end	
	
		if ( msg =="pop") then
		LookoutAlertHandler(" Lookout is functional ");
	end	
	
	if ( msg =="reset") then
		LookoutSavedVars = {};
		LookoutSavedVars=LookoutDefaults;
		LookoutSavedVars["Version"]=LookoutVersion;
		LookoutAlertHandler(" Variables reset ");
	end	
end





function LookoutFixDefaults()
-- inputs:
-- LookoutSavedVars
-- ouputs:
-- LookoutSavedVars
	if not (LookoutSavedVars) then
		LookoutSavedVars = {};
		LookoutSavedVars=LookoutDefaults;
		LookoutSavedVars["Version"]=LookoutVersion;
		DEFAULT_CHAT_FRAME:AddMessage("Lookout loading defaults.", 0.5, 1.0, 0.5, 3);
		
	end
		
	if (LookoutSavedVars["Version"] == nil) then
		LookoutSavedVars["Version"]=LookoutVersion;
	end
	
	if (LookoutSavedVars["Version"] < LookoutVersion) then
		LookoutSavedVars = {};
		LookoutSavedVars=LookoutDefaults;
		LookoutSavedVars["Version"]=LookoutVersion;
		DEFAULT_CHAT_FRAME:AddMessage("Lookout version change. Loading defaults.", 0.5, 1.0, 0.5, 3);
	end
	
end

function Lookout_ScanForTarget(tName)
-- Inputs:
-- a unit name [string]
-- buff {optional}
	local partyCount=GetNumRaidMembers();
	local playerPrefix="";
	local winningVote=nil;
	local votes={};
	if (partyCount>0) then -- raiding
		playerPrefix="raid";
	else
		partyCount=GetNumPartyMembers();
		playerPrefix="party";
	end
	
	if (partyCount>0) then -- in some sort of group
		for i = 1, partyCount, 1 do
			local targetUnit=playerPrefix..i.."target";
			local targetName=UnitName(targetUnit);
			local groupMemberName=UnitName(playerPrefix..i);
			if ((targetName ~= nil) and (targetName ~= UNKNOWNOBJECT)) then -- UNKNOWNOBJECT is a global constant
				if (targetName==tName) then
					-- this target has the right name
					-- DEFAULT_CHAT_FRAME:AddMessage(groupMemberName .." is targeting:"..targetName,  0.5, 1.0, 0.5, 1);
					-- LookoutShowBuffs(playerPrefix..i.."target");
					if (UnitIsDead(targetUnit)) then
						-- skip this one
					else
						if (Lookout_IsTargetPassive(targetUnit)) then
							-- skip stuff that is not active
						else
							winningVote=targetUnit;
						end
					
					end
				else
					-- DEFAULT_CHAT_FRAME:AddMessage("--->"..groupMemberName .." is targeting:"..targetName,  0.5, 1.0, 0.5, 1);
					-- LookoutShowBuffs(targetUnit);
				end
			end
		end -- for loop
	end

	if (winningVote) then
		target(winningVote);
	end

end


function Lookout_UpdateRaidtable()
-- Inputs None
-- outputs:
-- global array LookoutRaidInfoByName. One entry per group member.
-- each entry: name, rank, subgroup, level, classText, classType, zone, isOnline
	LookoutRaidInfoByName = {};
	local rosterCount=0;
	local name, rank, subgroup, level, classText, classType, zone, isOnline ;
	local leader;
	debugStr= "Raid members:";
	if (GetNumRaidMembers()>0) then
		-- this is a raid
		for i = 1, GetNumRaidMembers(), 1 do
			name, rank, subgroup, level, classText, classType, zone, isOnline = GetRaidRosterInfo(i); 
			if ( name ~= nil) then
				LookoutRaidInfoByName[name]={
					rank = rank,
					subgroup = subgroup,
					level = level,
					class = classType,
					zone = isOnline,
					online = online
				};
			
				rosterCount = rosterCount+1;
				debugStr = debugStr .. name .. " ("..rank.."), ";
			end -- valid player entry ( name ~= nil)
		end -- for loop
		-- DEFAULT_CHAT_FRAME:AddMessage("Raid leader:"..leader,  0.5, 1.0, 0.5, 1);
	else
		-- not a raid check to see if we have a party
		-- add ourselves to the party: (whether there is a party or not)
		rank=0;
		if ( (IsPartyLeader()) or (GetNumPartyMembers() == 0)) then
			rank=2;
		end
		
		LookoutRaidInfoByName[myPlayerName]={
			name=myPlayerName,
			rank=rank,
			level=UnitLevel("player"),
			class=myPlayerClassType,
			zone=GetRealZoneText(),
			online=true
		};
		debugStr = debugStr .. myPlayerName .. " ("..rank.."), ";
		rosterCount = rosterCount+1; -- count ourselves
		
		if (GetNumPartyMembers()>0) then -- ranges from 0 to 4

			for partyIndex = 1,4 do
				if (GetPartyMember(partyIndex)) then -- arg! returns a number....
					partyUnitName="party"..GetPartyMember(partyIndex);
					local partyMemberName=UnitName(partyUnitName);
					rank=0;
					if UnitIsPartyLeader(partyUnitName) then -- Returns true if the unit is the leader of its party.
						rank=2;
					end
					-- level=UnitLevel(partyMemberName);
					level=UnitLevel(partyUnitName);
					
					-- classText, classType = UnitClass(partyMemberName);
					classText, classType = UnitClass(partyUnitName);
					-- isOnline=UnitIsConnected(partyMemberName) -- Returns 1 if the specified unit is connected or npc, nil if offline or not a valid unit. 
				isOnline=UnitIsConnected(partyUnitName)
				
				LookoutRaidInfoByName[partyMemberName]={
					name=partyMemberID,
					rank=rank,
					level=UnitLevel(partyUnitName),
					class=classType,
					zone=GetRealZoneText(), -- can't  find a way to get this for real
					online=isOnline
				};
				debugStr = debugStr .. partyMemberName .. " ("..rank.."), ";
				rosterCount = rosterCount+1; -- count each party member
				end -- this slot has a party member (if)
			end -- for loop

		
		else
		-- Just us in the group!
		
		end
		
			
		
	end -- the raid/party IF

		-- DEFAULT_CHAT_FRAME:AddMessage(debugStr,  0.5, 1.0, 0.5, 1);


end



function DumpLookout_UpdateRaidtable()
	table.foreach(LookoutRaidInfoByName,
		function(k,v)
			DEFAULT_CHAT_FRAME:AddMessage(LookoutRaidInfoByName[v],  0.5, 1.0, 0.5, 1);

			--getglobal(k):SetChecked(v);
		end
	
	);
end



-- Target Debuffs:
-- =================

function LookoutShowDebuffs()  -- sUnitname
  local i = 1
  DEFAULT_CHAT_FRAME:AddMessage("--- Debuff LookoutShowDebuffs()", 1, 1, 0)
  while (UnitDebuff("target", i)) do
 	DEFAULT_CHAT_FRAME:AddMessage("["..UnitDebuff("target", i).."] ", 1, 1, 0)
    
    i = i + 1;
	DEFAULT_CHAT_FRAME:AddMessage("---", 1, 1, 0)  ;  
  end
end


function LookoutShowBuffs(sUnitname)  -- sUnitname
	if (sUnitname == nil) then
		sUnitname="target";
	end
  local i = 1
 -- DEFAULT_CHAT_FRAME:AddMessage("--- Buff LookoutShowBuffs()", 1, 1, 0)
  while (UnitBuff(sUnitname, i)) do
 	DEFAULT_CHAT_FRAME:AddMessage("["..UnitBuff(sUnitname, i).."] ", .6, .6, .6, 1)
    
    i = i + 1;
	DEFAULT_CHAT_FRAME:AddMessage("---", 1, 1, 0)  ;  
  end
end



function Lookout_FindTargetInCrowd(desiredTarget)
	local foundTarget=false;
	local currentTarget, targetRealm =UnitName("target");
-- theory of operation:

-- Is our current Target alive?
	if (UnitIsDead("target")) then
		-- we need a better target!
		-- leave foundTarget=false
	else
-- Step 1: Do we already have it targetted? Is it alive?

		if (desiredTarget == currentTarget) then
			foundTarget=true; -- already targeting
		end

-- Step 2: Do we already have _A_ target?
		if (foundTarget==false) then
			if (currentTarget) then -- SOMETHING is targeted already
				foundTarget=true; -- keep our current non-dead target
			end
			
		end
		
	end -- target is dead
	
	if (foundTarget==false) then
		Lookout_ScanForTarget(desiredTarget); -- no name given
	end
end


function Lookout_IsTargetPassive(sUnit)  -- sUnitname
  local i = 1;
  passive=false;
  if (sUnit ~= nil) then
  	sUnit="target";
  end
 
	if (UnitAffectingCombat(sUnit)) then
		-- DEFAULT_CHAT_FRAME:AddMessage("Unit in combat - testing buffs:", 1, 1, 0)
			
		while (UnitDebuff(sUnit, i)) do
			local deBuffString = UnitDebuff(sUnit, i);
			-- DEFAULT_CHAT_FRAME:AddMessage(" testing "..deBuffString , 1, 1, 0)

			local toss, toss2, deBuff = string.find (deBuffString, "^.*\\(.*)$", 1, false ); -- everything up to last backslash, rest of string

			-- DEFAULT_CHAT_FRAME:AddMessage(" testing debuff "..i.."  ".. deBuff , 1, 1, 0)
			if (LookoutNonEnemyBuffs[deBuff] == true) then
				-- DEFAULT_CHAT_FRAME:AddMessage("["..deBuff.."] ", 1, 1, 0)
				passive=true;
				break;
			end
			i = i + 1;
			-- DEFAULT_CHAT_FRAME:AddMessage("---", 1, 1, 0)  ;  
	  end
	else
	-- DEFAULT_CHAT_FRAME:AddMessage("Unit not in combat", 1, 1, 0)
	  passive=true; -- unit not in combat
	end -- unit in combat
	return passive;
end


function Lookout_StopDPS(tUnit)

	if (Lookout_IsTargetPassive()) then
	-- target is passive - don't worry about it
	
	else
		if (tUnit ~= nil) then
			TargetByName(tUnit);
		else
			-- ClearTarget(); -- no longer sufficient for bloodlord
			TargetUnit("player");
		end
		
	end


end




function Lookout_SendMsg(msg)

-- optionally parse
local minimapzonetext = GetMinimapZoneText();

-- local parsedMsg=string.gsub(msg,"%z",minimapzonetext, 1, true); -- start at character 1, true means to not use regular expressions

local parsedMsg=string.gsub(msg,"%%z",minimapzonetext); 


	if GetNumRaidMembers()>0 then
		-- we are in a raid
		SendChatMessage("::msg"..parsedMsg, "RAID");
	else
		if (GetNumPartyMembers()>0) then -- ranges from 0 to 4
			-- we are in a party
			SendChatMessage("::msg"..parsedMsg, "PARTY");
		else
			-- not a party or raid
			SendChatMessage(msg, "SAY");
		end	
	end

end

function Lookout_SendCmd(msg)

	if GetNumRaidMembers()>0 then
		-- we are in a raid
		SendChatMessage(msg, "RAID");
	else
		if (GetNumPartyMembers()>0) then -- ranges from 0 to 4
			-- we are in a party
			SendChatMessage(msg, "PARTY");
		else
			-- not a party or raid
			SendChatMessage(msg, "SAY");
		end	
	end

end

function Lookout_DBM(msg)
	if (Lookout_Debug) then
		 DEFAULT_CHAT_FRAME:AddMessage("Lookout debug: "..msg,  0.5, 1.0, 0.5, 1);
	end

end


-- GUI Handlers:
-- =============================

-- prefs:
function LookoutOptions_OnClick(arg1)
	id = this:GetID()
	-- message("LookoutOptions_OnClick: OnClick: " .. this:GetName() .. " ,ID: " .. id .. " ,Button:" ..arg1)
	local buttonName=this:GetName()
	-- message("LookoutOptions_OnClick: OnClick: " .. buttonName .. " ,ID: " .. id);
	LookoutDefaults[buttonName] =getglobal(buttonName):GetChecked();
	LookoutSavedVars[buttonName] =getglobal(buttonName):GetChecked();
end


 -- OnShow
 function LookoutPrefsFrameOnShow()

	-- DEFAULT_CHAT_FRAME:AddMessage("Lookout Showing", 0.5, 1.0, 0.5, 4);
	-- make sure our profile has been loaded
	-- if ( not LookoutOptions_variablesLoaded ) then -- config not loaded
		-- this:Hide(); -- hide the config pane
		-- return;
	-- end
	-- read settings from profile, and change our checkbuttons and slider to represent them

	LookoutPrefsTitle:SetFont(Lookout_FontFileBig, 18); 
	
	 
	LookoutPrefsFrame_Help_Text:SetText(LOOKOUT_TEXT["PREF_HELP"]);
	
	local currentOptions = getglobal(this:GetName().."Options");
	if (not currentOptions) then
		currentOptions=LookoutDefaults;
	end
	-- draw the current settings:
	table.foreach(LookoutSavedVars,
		function(k,v)
			if (getglobal(k) ~= nil) then
				if string.find("Text",k) then
					
				else
					getglobal(k):SetChecked(v);
				end
	
			end
		end

	);
	

	
	LookoutPrefs_CurrentPanel=-1;
	Lookout_HidePanel(4);
	Lookout_HidePanel(3);
	Lookout_HidePanel(2);
	-- PanelTemplates_Tab_OnClick(1);
	Lookout_ShowPanel(1); -- default to panel 1
	
 end
 
 
 
 function Lookout_ShowPanel(whichPanel)

 	if (LookoutPrefs_CurrentPanel > 0) then
 		Lookout_HidePanel(LookoutPrefs_CurrentPanel);
	end

	
	getglobal(LookoutPrefs_PanelFrames[whichPanel]):Show();
 	LookoutPrefs_CurrentPanel=whichPanel;
 end


function Lookout_HidePanel(whichPanel)
	getglobal(LookoutPrefs_PanelFrames[whichPanel]):Hide();
	LookoutPrefs_CurrentPanel = 0;
end
	






function LookoutPop2(msg)
	StaticPopupDialogs["EXAMPLE_HELLOWORLD"] = {
		text = "|cffff0022Danger, Will Robinson!|r",
		-- button1 = "Yes",
		-- button2 = "No",
		OnAccept = function()
			UIErrorsFrame:AddMessage(" Kill the eye! ", 1.0, 0.0, 0.0, 1.0, 1.5);
		end,
		timeout = 3,
		whileDead = 1,
		hideOnEscape = 1
	};
	StaticPopup_Show ("EXAMPLE_HELLOWORLD");
end





function LookoutAlertHandler(msg)
	if (msg == nil) then
		msg=" Kill the eye! ";
	end
	if (SchnoggoShowAlert == nil) then

		PlaySoundFile("Interface\\AddOns\\Lookout\\pok.wav");
		local font,fontSize,fontFlags = LookoutMessageFrame:GetFont(); 
		LookoutMessageFrame:SetFont(Lookout_FontFileBig, 36, "OUTLINE"); 
		LookoutMessageFrame:SetFadeDuration(1);
		LookoutMessageFrame:SetTimeVisible(2);
		LookoutMessageFrame:AddMessage(msg, .2, 1, .3, 1, 1);
		-- "text", red, green, blue, alpha, holdTime
		PlaySound("igQuestFailed");
	else
		SchnoggoShowAlert(msg);
	end
end



--     CheckButton:GetChecked() - Get the status of the checkbox. 
--    CheckButton:SetChecked([state]) - Set the status of the checkbox. 
--    CheckButton:SetCheckedTexture("texture") - Set the texture to use for a checked box. 
--    CheckButton:SetDisabledCheckedTexture("texture") - Set the texture to use for an unchecked box.
    

