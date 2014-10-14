-- Baden's ManaSaver Mod - Version 2.4.6
-- Baden - Dragonmarch - Silvermoon Server
-- Arax - Dragonmarch - Silvermoon Server

-- code from DPH and Healix
-- Used to analyze the right level of healing spells to cast the lowest
-- and most mana efficient level of the spell.
-- See readme.txt for more information

local playerIds = {player = 0, party1 = 1, party2 = 2, party3 = 3, party4 = 4}
local playerUnits = {[0] = 'player', 'party1', 'party2', 'party3', 'party4'};
local err_event = nil;


-- Player's Talent collection
ManaSave_PlayerTalents = {};

-- Player's Spell collection
ManaSave_PlayerSpells = {};
boolFirstMSaverCall = true;


-- **************************************************
-- *********** Spell Libraries **********************
-- **************************************************

-- Healing Spells, the median amount healed by any spell level, or
-- the minimum amount for heal over time spells
local healvalues = {
	[MANASAVE_SPELL_HEALTOUCH] = {50,100,219,404,633,818,1028,1313,1656,2060,2475},
	[MANASAVE_SPELL_REGROWTH] = {91,176,257,339,431,543,685,857,1061},						
	[MANASAVE_SPELL_REJUVENATION] = {32,56,116,180,244,304,388,488,608,756,888},			
	[MANASAVE_SPELL_LESSHEAL] = {50,78,146},
	[MANASAVE_SPELL_HEAL] = {318,460,604,758},
	[MANASAVE_SPELL_GRTHEAL] = {956,1219,1523,1902,2080},
	[MANASAVE_SPELL_ALLHEAL] = {50,78,146,318,460,604,758,956,1219,1523,1902,2080},
	[MANASAVE_SPELL_FLASHHEAL] = {215,286,360,439,567,704,885},
	[MANASAVE_SPELL_RENEW] = {45,100,175,245,315,400,510,650,810,970},
	[MANASAVE_SPELL_HOLYLIGHT] = {50,83,173,333,522,744,999,1317,1680},
	[MANASAVE_SPELL_FLASHOFLIGHT] = {67,103,154,209,233,363},
	[MANASAVE_SPELL_HEALWAVE] = {40,71,142,292,408,579,797,1092,1464,1735},
	[MANASAVE_SPELL_LESSHEALWAVE] = {174,264,359,486,668,880},
	[MANASAVE_SPELL_CHAINHEAL] = {345,435,589},
};

-- Levels at which spells are learned, used for level-dependant spells like regrowth
local heallevels = {
	[MANASAVE_SPELL_HEALTOUCH] = {1,8,14,20,26,32,38,44,50,56,60},
	[MANASAVE_SPELL_REGROWTH] = {12,18,24,30,36,42,48,54,60},
	[MANASAVE_SPELL_REJUVENATION] = {4,10,16,22,28,34,40,46,52,58,60},
	[MANASAVE_SPELL_LESSHEAL] = {1,4,10},
	[MANASAVE_SPELL_HEAL] = {16,22,28,34},
	[MANASAVE_SPELL_GRTHEAL] = {40,46,52,58,60},
	[MANASAVE_SPELL_ALLHEAL] = {1,4,10,16,22,28,34,40,46,52,58,60},
	[MANASAVE_SPELL_FLASHHEAL] = {20,26,32,38,44,50,56},
	[MANASAVE_SPELL_RENEW] = {8,14,20,26,32,38,44,50,56,60},
	[MANASAVE_SPELL_HOLYLIGHT] = {1,6,14,22,30,38,46,54,60},
	[MANASAVE_SPELL_FLASHOFLIGHT] = {20,26,34,42,50,58},
	[MANASAVE_SPELL_HEALWAVE] = {1,6,12,18,24,32,40,48,56,60},
	[MANASAVE_SPELL_LESSHEALWAVE] = {20,28,36,44,52,60},
	[MANASAVE_SPELL_CHAINHEAL] = {40,46,54},
};

-- The cost of each spell level in mana
local healmana = {
	[MANASAVE_SPELL_HEALTOUCH] = {30,55,110,185,270,335,405,495,600,720,800},
	[MANASAVE_SPELL_REGROWTH] = {120,205,280,350,420,510,615,740,880},
	[MANASAVE_SPELL_REJUVENATION] = {25,40,75,105,135,160,195,235,280,335,360},
	[MANASAVE_SPELL_LESSHEAL] = {25,45,75},
	[MANASAVE_SPELL_HEAL] = {155,205,255,305},
	[MANASAVE_SPELL_GRTHEAL] = {370,455,545,655,710},
	[MANASAVE_SPELL_ALLHEAL] = {25,45,75,155,205,255,305,370,455,545,655,710},
	[MANASAVE_SPELL_FLASHHEAL] = {125,155,185,215,265,315,380},
	[MANASAVE_SPELL_RENEW] = {30,65,105,140,170,205,250,305,365,410},
	[MANASAVE_SPELL_HOLYLIGHT] = {30,60,110,190,275,365,465,580},
	[MANASAVE_SPELL_FLASHOFLIGHT] = {35,50,70,90,115,140},
	[MANASAVE_SPELL_HEALWAVE] = {25,45,80,155,200,265,340,440,560,610},
	[MANASAVE_SPELL_LESSHEALWAVE] = {105,145,185,235,305,380},
	[MANASAVE_SPELL_CHAINHEAL] = {260,315,405},
};

-- Library of Talents with bonus healing values, numbers are percent bonus to heal
local talentpercentbonus = {
	[MANASAVE_TALENT_IMPREJUVE] = {["Spells"] = {MANASAVE_SPELL_REJUVENATION},["Ranks"] = {5,10,15}},
	[MANASAVE_TALENT_GIFTNATURE] = {["Spells"] = {"All"},["Ranks"] = {2,4,6,8,10}},
	[MANASAVE_TALENT_HEALLIGHT] = {["Spells"] = {MANASAVE_SPELL_HOLYLIGHT,MANASAVE_SPELL_FLASHOFLIGHT},["Ranks"] = {4,8,12}},
	[MANASAVE_TALENT_IMPRENEW] = {["Spells"] = {MANASAVE_SPELL_RENEW},["Ranks"] = {5,10,15}},
	[MANASAVE_TALENT_SPIRITHEAL] = {["Spells"] = {"All"},["Ranks"] = {2,4,6,8,10}},
	[MANASAVE_TALENT_PURIFICATION] = {["Spells"] = {"All"},["Ranks"] = {2,4,6,8,10}},
	[MANASAVE_TALENT_SPIRITGUIDANCE] = {["Spells"] = {"All"},["Ranks"] = {0.05,0.10,0.15,0.20,0.25}},
};

-- Library of Talents which lessen the mana cost of certain spells
local talentlessmana = {
	[MANASAVE_TALENT_TRANQSPIRIT] = {["Spells"] = {MANASAVE_SPELL_HEALTOUCH},["Ranks"] = {2,4,6,8,10}},
	[MANASAVE_TALENT_IMPHEALING] = {["Spells"] = {MANASAVE_SPELL_LESSHEAL,MANASAVE_SPELL_HEAL,MANASAVE_SPELL_GRTHEAL},["Ranks"] = {5,10,15}},
	[MANASAVE_TALENT_TIDALFOCUS] = {["Spells"] = {"All"},["Ranks"] = {1,2,3,4,5}},
};

-- Can't cast Regrowth Rank 10 on a Lv.3 noob now can we?
local levelmatters = {
	[MANASAVE_SPELL_REGROWTH] = true,
	[MANASAVE_SPELL_REJUVENATION] = true,
	[MANASAVE_SPELL_RENEW] = true,
};

-- **************************************************
-- *********** Initialization and Event Procedures **
-- **************************************************


function MSaver_initialize()
	-- Save Variables
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_FAILED");
    this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELL_FAILED_OUT_OF_RANGE");
	this:RegisterEvent("SPELL_FAILED_LINE_OF_SIGHT");
	this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
	this:RegisterEvent("CHARACTER_POINTS_CHANGED");
	this:RegisterEvent("SPELLS_CHANGED");
	
	-- Slash Command Syntax
	SlashCmdList["MANASAVERQUIET"] = MSaver_Quiet;
	SLASH_MANASAVERQUIET1 = "/msaverq";
	SlashCmdList["MANASAVEROPTIONS"] = MSaver_SlashOpenOptions;
	SLASH_MANASAVEROPTIONS1 = "/msaveroptions";	
	
	-- add our very first chat command!
	--DEFAULT_CHAT_FRAME:AddMessage(string.format(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_VERSION, ManaSaverVersion));	
	DEFAULT_CHAT_FRAME:AddMessage(string.gsub(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_VERSION, "NUMVER", MANASAVE_VERSION));
	-- initialize talents
	MSaver_GetTalents();
	-- initialize spells
	MSaver_GetSpells();
	
	-- works with the initialized options in ManaSaverOptions.lua
	ManaSaver_OptionsLoaded();

	-- initialize heal items bonus, after checking to see if BonusScanner mod is active
	--BScanActive = BonusScanner.active;
	--if (BScanActive == 1) then
	--	ManaSaverSV.PlusHeal = BonusScanner:GetBonus('HEAL');
	--else
	--	ManaSaverSV.PlusHeal = 0;
	--end
	
end

function MSaver_OnEvent(event)
	-- Registers the events, used for error handling
	if (event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER") then	
		local failReason = string.sub(arg1,strfind(arg1,": ")+2);	
		err_event = failReason;
		return;
	end	
	-- If the talent points change, collect the new talents and spells
	if (event == "CHARACTER_POINTS_CHANGED") then
		MSaver_GetTalents();
		MSaver_GetSpells();
	end
	-- If the spellbook changes, collect the new spells
	if (event == "CHARACTER_POINTS_CHANGED") then
		--DEFAULT_CHAT_FRAME:AddMessage("Spells changed");
		MSaver_GetSpells();
	end
end

-- Opens the option frame from a slash command
function MSaver_SlashOpenOptions()
	ManaSaverOptionsFrame:Show();
end

function MSaver_Quiet(msg)
 	-- Manages the Quiet Mode       
	if(msg == 'on') then
		ManaSaverSV.QuietMode = "On";
    	MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETON)
    elseif(msg == 'off') then
		ManaSaverSV.QuietMode = "Off";
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETOFF)
	elseif(msg == 'default') then
		ManaSaverSV.QuietMode = "Default";
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETDEF)
	elseif(msg == 'self') then
		ManaSaverSV.QuietMode = "Self";
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETSELF)
	elseif(msg == 'menu') then
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU1)
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU2)
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU3)
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU4)
	else
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETPROPER)
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU1)
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU2)
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU3)
		MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_QUIETMENU4)
    end
    
    --Updates the options window
	MSaver_OptionsQuietOnClick(ManaSaverSV.QuietMode);
end


-- **************************************************
-- *********** Chat Posting Functions ***************
-- **************************************************

function MSaver_writeLine(s)
   if DEFAULT_CHAT_FRAME then
	   DEFAULT_CHAT_FRAME:AddMessage(s)
   end
end

function MSaver_PostSpellInChat(vartarget, strSpell, numRank)
-- Function posts spell information to the chat window, either using SpeakSpell or the error message
	
	
	-- Checks to see if the user has enabled the custom messages
	if ManaSaverSV.CustomError then
		if (err_event == "Out of range.") then				
			MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_SPELLFAILRANGE)
			err_event = nil;
			return;										
		elseif (err_event == "Target not in line of sight.") then		
			MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_SPELLFAILSIGHT)
			err_event = nil;
			return;			
		elseif (err_event == "Not enough mana.") then		
			MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_SPELLFAILMANA)
			err_event = nil;
			return;		
		elseif (err_event == "A more powerfull spell is already active.") then	
			MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_SPELLFAILPOWER)
			err_event = nil;
			return;	
		elseif (err_event == "Can't do that while moving.") then	
			MSaver_writeLine(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_SPELLFAILMOVE)
			err_event = nil;
			return;	
		end
	end

	-- If no other conditions are met, then post speakspell
	MSaver_SpeakSpell(vartarget, strSpell, numRank)
end

function MSaver_SpeakSpell(varTarget, strSpell, numRank)
	-- Used to post spell information, funny or not
    local rand = math.random(1,24)
    local read = "ManaSaver_Mod_Is_Broken"
	local OnSelf = false;
	local spellTarget = UnitName(varTarget)
	local NumRaid = GetNumRaidMembers()
	if UnitExists(varTarget) and (varTarget == "player") then
		OnSelf = true;
	elseif (spellTarget == "nil") then
		OnSelf = true; 
	end		
	if (ManaSaverSV.QuietMode == "Off") then	
		if rand == 1 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE1, spellTarget, strSpell, numRank); end
        if rand == 2 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE2, spellTarget, strSpell, numRank); end
        if rand == 3 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE3, spellTarget, strSpell, numRank); end
        if rand == 4 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE4, spellTarget, strSpell, numRank); end
        if rand == 5 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE5, spellTarget, strSpell, numRank); end
        if rand == 6 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE6, spellTarget, strSpell, numRank); end
        if rand == 7 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE7, spellTarget, strSpell, numRank); end
		if rand == 8 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE8, spellTarget, strSpell, numRank); end
		if rand == 9 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE9, spellTarget, strSpell, numRank); end
		if rand == 10 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE10, spellTarget, strSpell, numRank); end
		if rand == 11 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE11, spellTarget, strSpell, numRank); end
		if rand == 12 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE12, spellTarget, strSpell, numRank); end
        if rand == 13 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE13, spellTarget, strSpell, numRank); end
        if rand == 14 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE14, spellTarget, strSpell, numRank); end
        if rand == 15 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE15, spellTarget, strSpell, numRank); end
        if rand == 16 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE16, spellTarget, strSpell, numRank); end
        if rand == 17 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE17, spellTarget, strSpell, numRank); end
        if rand == 18 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE18, spellTarget, strSpell, numRank); end
		if rand == 19 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE19, spellTarget, strSpell, numRank); end
		if rand == 20 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE20, spellTarget, strSpell, numRank); end
		if rand == 21 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE21, spellTarget, strSpell, numRank); end
		if rand == 22 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE22, spellTarget, strSpell, numRank); end
		if rand == 23 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE23, spellTarget, strSpell, numRank); end
		if rand == 24 then read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTJOKE24, spellTarget, strSpell, numRank); end		
	else		
		read = MSaver_InsertSpellInfo(MANASAVE_CHAT_POSTDEFAULT, spellTarget, strSpell, numRank);		
	end	
	
	-- ManaSaverq Self mode
	if (ManaSaverSV.QuietMode == "Self") then
		DEFAULT_CHAT_FRAME:AddMessage(MANASAVE_FONT_LTYELLOW..read)
	-- ManaSaverq Default or Off mode
	elseif (ManaSaverSV.QuietMode == "Default") or (ManaSaverSV.QuietMode == "Off") then
		-- Post to raid if target is in raid or is raid pet
		if ((UnitInRaid(varTarget)) and (not OnSelf)) or (MSaver_IsPartyRaidPet(varTarget) and (NumRaid > 0)) then
			SendChatMessage(read, "Raid")
		-- Post to party if target in party or party pet
		elseif ((UnitInParty(varTarget)) and (not OnSelf)) or (MSaver_IsPartyRaidPet(varTarget)) then
			SendChatMessage(read, "Party")
		-- Post to tell if player
		elseif (UnitIsPlayer("player", varTarget) and (not UnitCreatureFamily(varTarget)) and (not OnSelf)) then
			SendChatMessage(read, "WHISPER", nil, spellTarget)
		 -- must be a pet
		elseif (not OnSelf) then 
			SendChatMessage(read, "Say")
		-- If on player, nothing posted
		end
	-- ManaSaverq = ON mode means nothing is posted
	end
end


-- Function that inserts the target, spell name, and rank in a string using the following convetion:
-- XPLAYER = spellTarget
-- XSPELLNAME = strSpell
-- XRANK = numRank
function MSaver_InsertSpellInfo (strMessage,spellTarget, strSpell, numRank)
	local strReturn = strMessage;
	
	if (spellTarget) then
		strReturn = string.gsub(strReturn, "XPLAYER", spellTarget);
	end
	if (strSpell) then
		strReturn = string.gsub(strReturn, "XSPELLNAME", strSpell);
	end	
	if (numRank) then
		strReturn = string.gsub(strReturn, "XRANK", numRank);
	end	

	return strReturn;
end

-- **************************************************
-- *********** Talent Functions *********************
-- **************************************************

-- This function is run on initialization and then rerun every time
-- the player closes the talent window, which is registered as event
-- Functionality taken from http://www.wowwiki.com/API_GetTalentInfo
function MSaver_GetTalents ()
	local numTabs = GetNumTalentTabs();

	ManaSave_PlayerTalents = {};  -- Reset the talent table

	for t=1, numTabs do
	    --DEFAULT_CHAT_FRAME:AddMessage(GetTalentTabInfo(t)..":");
	    local numTalents = GetNumTalents(t);
	    for i=1, numTalents do
	        nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(t,i);
	        -- Eliminate the talents with no ranks
	        if currRank > 0 then
	        	ManaSave_PlayerTalents[nameTalent] = currRank;
	       		--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
	    	end
	    end
	end
end


-- This is the function that gathers information about the players talents
-- and determines if the talents yield any increase in healing % for a particular spell
-- Returns the actual multiplier, so a 2% increase returns 1.02
function MSaver_CalcTalentsHealPercent(strSpell)
	local numHealPercent = 0;
	local varTalentDetail
	local name,rank

	-- Cycle through known talents
	for name, rank in pairs(ManaSave_PlayerTalents) do
		varTalentDetail = talentpercentbonus[name];
		if (varTalentDetail) then    -- If the talent is listed in the library
			local varSpells = varTalentDetail.Spells
			--Cycle through the applicable spells
			for y,talentspell in ipairs(varSpells) do
				if (talentspell == "All") or (talentspell == strSpell) then
					local numGet
					numGet = varTalentDetail.Ranks[rank];
					numHealPercent = numHealPercent + numGet;
					break
				end
			end
		end
	end
	--DEFAULT_CHAT_FRAME:AddMessage(string.format("Percent is - %g",(1 + (numHealPercent*0.01))));
	
	-- Check to see if the user has enabled talent calculations to be included
	if ManaSaverSV.IncTalents then
		return (1 + (numHealPercent*0.01));
	else
		return 1;
	end
end

-- This is the function used for Spiritual Guidance, a Priest talent that increases + heal as a percentage of spirit
-- The function checks to see if the Spiritual Guidance talent is known, and if it is to calculate the bonus to + heal
-- If not, then the function returns 0
function MSaver_CalcTalentsSpiritGuidance()
	local numPlusHeal = 0;
	local numSpiritMult;
	local numUnitSpirit;
	
	-- Cycle through known talents
	for name, rank in pairs(ManaSave_PlayerTalents) do
		-- Check to see if Spiritual Guidance is known
		if (name == MANASAVE_TALENT_SPIRITGUIDANCE) then
			numSpiritMult = talentpercentbonus[name].Ranks[rank];
			-- Get the unit's spirit, which includes buffs and debuffs at the time of cast
			base, numUnitSpirit, posBuff, negBuff = UnitStat("player", 5);
			numPlusHeal = numSpiritMult * (ManaSaverSV.PlusSpirit + numUnitSpirit);
			break
		end
	end
	--DEFAULT_CHAT_FRAME:AddMessage(string.format("Spiritual Guidance Plus Heal is - %g",(numPlusHeal)));
	
	-- Check to see if the user has enabled talent calculations to be included
	if ManaSaverSV.IncTalents then
		return numPlusHeal;
	else
		return 0;
	end
end

-- This is the function that gathers information about the players talents
-- and determines if the talents yield any reduction in healing spell mana cost
-- Returns the actual multiplier, so a 2% reduction returns 0.98
function MSaver_CalcTalentsLessManaPercent(strSpell)
	local numManaPercent = 0;
	local varTalentDetail
	local name,rank

	-- Cycle through known talents
	for name, rank in pairs(ManaSave_PlayerTalents) do
		varTalentDetail = talentlessmana[name];
		if (varTalentDetail) then    -- If the talent is listed in the library
			local varSpells = varTalentDetail.Spells
			--Cycle through the applicable spells
			for y,talentspell in ipairs(varSpells) do
				if (talentspell == "All") or (talentspell == strSpell) then
					local numGet
					numGet = varTalentDetail.Ranks[rank];
					numManaPercent = numManaPercent + numGet;
					break
				end
			end
		end
	end
	--DEFAULT_CHAT_FRAME:AddMessage(string.format("Percent less mana is - %g",(1 - (numManaPercent*0.01))));

	-- Check to see if the user has enabled talent calculations to be included
	if ManaSaverSV.IncTalents then
		return (1 - (numManaPercent*0.01));
	else
		return 1;
	end
end

-- **************************************************
-- *********** Spell Functions ********************
-- **************************************************

-- Returns a boolean value if the spell is known or not
function MSaver_SpellRankKnown(strSpell, numRank)
    local id, searchName, r = 1
	local boolReturn = false;
	local strRank
	if (strSpell == MANASAVE_SPELL_ALLHEAL) then
    	if (numRank > 7) then numRank = numRank - 7; strSpell = MANASAVE_SPELL_GRTHEAL;
		elseif (numRank > 3) then numRank = numRank - 3; strSpell = MANASAVE_SPELL_HEAL;
		else strSpell = MANASAVE_SPELL_LESSHEAL; end
    end
    boolReturn = (ManaSave_PlayerSpells[strSpell][numRank]);
    --strRank = MANASAVE_RANK.." "..numRank;
    --repeat
    --    searchName, r = GetSpellName(id, BOOKTYPE_SPELL)
    --    if (searchName == strSpell and strRank == r) then boolReturn = true; end 
    --    id = id + 1
    --until not searchName
    
    return boolReturn
end

-- Populates ManaSave_PlayerSpells with spell names, ranks and spell IDs
function MSaver_GetSpells()
	local id = 1
	local spellname,r = GetSpellName(id,BOOKTYPE_SPELL);
	local samespellname = spellname
	
	-- Reset spells
	ManaSave_PlayerSpells = {};
	
    while ( spellname ) do
        spellname, r = GetSpellName(id, BOOKTYPE_SPELL)
        
        if (healvalues[spellname]) then
        	-- Checks to see if the spell name is the same
			if (not(samespellname == spellname)) then
				ManaSave_PlayerSpells[spellname] = {};
				samespellname = spellname;
			end
          	--ManaSave_PlayerSpells[spellname] = tonumber(r);
          	--DEFAULT_CHAT_FRAME:AddMessage(spellname..", "..r..","..id)
          	local _,numEnd = string.find(r,MANASAVE_RANK);
          	local numEndRank = tonumber(string.sub(r,(numEnd+2)))
          	ManaSave_PlayerSpells[spellname][numEndRank] = id; 
        end
        id = id + 1
        spellname,r = GetSpellName(id,BOOKTYPE_SPELL);
    end
    
    --for a,b in pairs(ManaSave_PlayerSpells) do
    --	for c,d in pairs(ManaSave_PlayerSpells[a]) do
    --		DEFAULT_CHAT_FRAME:AddMessage(a..", "..c..", "..d)
    --	end
    --end
end

-- Finds the highest rank spell that a player has enough mana to cast
function MSaver_FindHighSpellMana(numHighRank,strSpell,target)
	local numManaMult = MSaver_CalcTalentsLessManaPercent(strSpell);
	for y=numHighRank,1,-1 do
		if ((numManaMult * healmana[strSpell][y]) <= UnitMana("player")) then
			CastSpell(ManaSave_PlayerSpells[strSpell][y],"spell");
			CastSpellByName(strSpell.."("..MANASAVE_RANK.." "..y..")");
			SpellTargetUnit(target);
			MSaver_PostSpellInChat(target, strSpell, y);
			break;
		end
	end
end

-- **************************************************
-- *********** Error Testing Functions **************
-- **************************************************
function MSaver_ListT(strName)
	local strTName
	
	if strName == "talents" then
		strTName = ManaSave_PlayerTalents;
		for c,d in pairs(strTName) do
    			DEFAULT_CHAT_FRAME:AddMessage(c..", "..d)
    	end
	elseif strName == "spells" then
		strTName = ManaSave_PlayerSpells;
		if (strTName) then
		for a,b in pairs(strTName) do
    		DEFAULT_CHAT_FRAME:AddMessage(a)
			--for c,d in pairs(strTName[a]) do
    		--	DEFAULT_CHAT_FRAME:AddMessage(a..", "..c..", "..d)
    		--end
    	end
    end
	end

end

function MSaver_TestT()
	local tbl = {}
	
	tbl["Field1"] = {};
	tbl["Field1"]["Field21"] = 1;
	tbl["Field1"]["Field22"] = 2;

    for y,x in pairs(tbl.Field1) do
    	DEFAULT_CHAT_FRAME:AddMessage(y..", "..x)
    end
end

function MSaver_Test()
	local IsEnemy = UnitIsEnemy("player","target");
	local IsPVP = UnitIsPVP("target");
	local isPVPFFA = UnitIsPVPFreeForAll("target");

	if IsEnemy then DEFAULT_CHAT_FRAME:AddMessage("Unit IS Enemy");
	else DEFAULT_CHAT_FRAME:AddMessage("Unit IS NOT Enemy"); end

	if IsPVP then DEFAULT_CHAT_FRAME:AddMessage("Unit IS PVP");
	else DEFAULT_CHAT_FRAME:AddMessage("Unit IS NOT PVP"); end

	if IsPVPFFA then DEFAULT_CHAT_FRAME:AddMessage("Unit IS PVP Free For All");
	else DEFAULT_CHAT_FRAME:AddMessage("Unit IS NOT PVP Free For All"); end

end

-- **************************************************
-- *********** Utility Functions ********************
-- **************************************************

-- Calculates the overheal amount, if passed in the original function call
function MSaver_CalcOverhealRank(numRank,i,varOverheal)
	if (i + varOverheal) > numRank then return numRank;
	elseif (i + varOverheal) < 1 then return 1 		--Provides for a negative varOverheal that would take the spell below rank 1
	else return i + varOverheal; end
end

-- Returns true if the target is a party or raid pet
-- Assumes that if the pet's maximum health = 100, then that must be a % and then the pet is outside of the party or raid
function MSaver_IsPartyRaidPet(varTarget)
	local boolReturn = false;

	if ((UnitIsPlayer("player", varTarget) and (UnitCreatureFamily(varTarget))) and (not (UnitHealthMax(varTarget) == 100))) then boolReturn = true; end
	
	--if boolReturn then DEFAULT_CHAT_FRAME:AddMessage("Party pet");
	--	else DEFAULT_CHAT_FRAME:AddMessage("Not a party pet"); end
	return boolReturn
end


-- **************************************************
-- *********** Actual MSaver Called Functions *******
-- **************************************************

-- This is the function that actually casts the healing spell
-- The only required arg is strSpell, the others are all optional
function MSaver(strSpell, numRank, overheal, targ)
	local varOverheal = overheal;
	if (not varOverheal) then varOverheal = 0; end
	
	local target = targ;
	if (not target) then target = "target"; end  -- no target was passed, use what the player's targetting
	if (not UnitIsFriend("player",target)) then target = "player"; end -- if enemy targeted we want to cast on "player"
	if UnitIsEnemy("player","target") then target = "player"; end -- if in PVP or dueling, then target self
	if (IsAltKeyDown()) then target = "player"; end  -- if the player uses the alt key when casting, then cast on self without changing target
	if (targ) then target = targ; end  -- Handle interface with click target based mods
	
	local numDelta = nil;  -- This is the health delta variable
	local stkLevel = healvalues[strSpell];
	local ranklevels = heallevels[strSpell];
	local lvlmatters = levelmatters[strSpell];
	local spellMana = healmana[strSpell];
	
	-- Check to see if the user has enabled the Plus Heal and Plus Spirit Items in calculations
	local numHealItemVal
	if ManaSaverSV.IncHealItems then
		BScanActive = BonusScanner.active;
		if (BScanActive == 1) then
			ManaSaverSV.PlusHeal = BonusScanner:GetBonus('HEAL');
			ManaSaverSV.PlusSpirit = BonusScanner:GetBonus('SPI');
			numHealItemVal = ManaSaverSV.PlusHeal
		else
			ManaSaverSV.PlusHeal = 0;
			ManaSaverSV.PlusSpirit = 0;
		end 	
		--numHealItemVal = ManaSaverSV.PlusHeal
		--ManaSaverSV.PlusHeal;
	else
		numHealItemVal = 0;
	end
	-- Include Spiritual Guidance if applicable
	numHealItemVal = numHealItemVal + (MSaver_CalcTalentsSpiritGuidance());
	
	local highrank = numRank;
	
	-- if player spell and talent library have not loaded, which they sometimes
	-- don't do when game first started, load them
	if (boolFirstMSaverCall) then
		MSaver_GetTalents();
		MSaver_GetSpells();
		boolFirstMSaverCall = false;
	end
	
	if (not highrank) then highrank = table.getn(ranklevels) end  -- no max rank was passed, use the highest available
		
	if (not stkLevel) then -- we don't have data for this spell, BAIL! BAIL!
		DEFAULT_CHAT_FRAME:AddMessage(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_MSAVERNOSPELL);
		return end 
		
	if (not(MSaver_SpellRankKnown(strSpell, numRank)) and not(strSpell == MANASAVE_SPELL_ALLHEAL)) then  -- the player does not know that spell or rank, BAIL
		DEFAULT_CHAT_FRAME:AddMessage(MANASAVE_FONT_LTYELLOW..MANASAVE_CHAT_PLAYERNOKNOWSPELL);
		return end
	
	if (strSpell == MANASAVE_SPELL_ALLHEAL) then		-- Handle priest's Less/Heal/Greater
		if ((UnitHealth(target) < 101) and (UnitHealthMax(target) ~= UnitHealth(target))) then -- HP info is only %, not absolute value
		--if (not (UnitInParty(target) or UnitInRaid(target) or MSaver_IsPartyRaidPet(target) or (target=="player"))	-- HP info is only %, not absolute value
		--	and (UnitHealthMax(target) ~= UnitHealth(target))) then		-- Target needs healing			
			local numModRank
			if (highrank > 7) then 
				strSpell = MANASAVE_SPELL_GRTHEAL;
				numModRank = highrank - 7;
			elseif (highrank > 3) then 
				strSpell = MANASAVE_SPELL_HEAL;
				numModRank = highrank - 3;
			else 
				strSpell = MANASAVE_SPELL_LESSHEAL;
				numModRank = highrank; 
			end
			
			MSaver_FindHighSpellMana(numModRank,strSpell,target)
		else -- Target is in party, we have full HP info to use.
			numDelta = (UnitHealthMax(target) - UnitHealth(target));
			if numDelta > 0 then
				local rankpicked;
				for i=1,highrank do
					local numCalc = MSaver_CalcTalentsHealPercent(strSpell);
					local numManaMult = MSaver_CalcTalentsLessManaPercent(strSpell);
					--DEFAULT_CHAT_FRAME:AddMessage(string.format("numDelta - %g", numDelta));
					--DEFAULT_CHAT_FRAME:AddMessage(string.format("Lvl-%d, Mult-%g, stkLev-%g, item-%g, numD-%g, calc-%g, mmult-%g, mana-%g, mcost-%g", i, numCalc, stkLevel[i], numHealItemVal, numDelta, (numCalc*(stkLevel[i]) + numHealItemVal),numManaMult,UnitMana("player"),spellMana[i]));
					
					if ((i == highrank) or (ranklevels[i+1] > UnitLevel("player"))) then rankpicked = i; break
					elseif (lvlmatters and (UnitLevel(target) + 10 < ranklevels[i+1])) then rankpicked = i; break
					elseif ((numManaMult * spellMana[i+1]) > UnitMana("player")) then rankpicked = i; break  -- next level spell is too much mana, so cast this one
					elseif (numDelta <= (numCalc*(stkLevel[i]) + numHealItemVal)) then rankpicked = MSaver_CalcOverhealRank(highrank,i,varOverheal); break
					elseif (i == highrank) then rankpicked = i; break
					end	
				end
				if (rankpicked) then 
					if (rankpicked > 7) then rankpicked = rankpicked - 7; strSpell = MANASAVE_SPELL_GRTHEAL;
					elseif (rankpicked > 3) then rankpicked = rankpicked - 3; strSpell = MANASAVE_SPELL_HEAL;
					else strSpell = MANASAVE_SPELL_LESSHEAL; end
					CastSpell(ManaSave_PlayerSpells[strSpell][rankpicked],"spell");
					--CastSpellByName(strSpell.."("..MANASAVE_RANK.." "..rankpicked..")");
					SpellTargetUnit(target);
					MSaver_PostSpellInChat(target, strSpell, rankpicked);			
				end
			end	
		end
	else  -- handle "normal" spells... this is a copy/paste job so see comments above.
		if ((UnitHealth(target) < 101) and (UnitHealthMax(target) ~= UnitHealth(target))) then -- HP info is only %, not absolute value
		--if (not (UnitInParty(target) or UnitInRaid(target) or MSaver_IsPartyRaidPet(target) or (target=="player"))
		--	and (UnitHealthMax(target) ~= UnitHealth(target))) then 
			--DEFAULT_CHAT_FRAME:AddMessage("Thinks we don't have health data");
			if(lvlmatters) then
				for i=highrank,1,-1 do 
					if ((UnitLevel(target) >= ranklevels[i]-10) and (ranklevels[i] <= UnitLevel("player"))) then 
						MSaver_FindHighSpellMana(i,strSpell,target)
						break;
					end;
				end;
			else
				-- Cast max spell, if enough mana, otherwise cycle down until they have enough mana
				MSaver_FindHighSpellMana(highrank,strSpell,target)
			end
		else
			numDelta = (UnitHealthMax(target) - UnitHealth(target));
			if numDelta > 0 then
				local rankpicked;
				for i=1,highrank do
					local numCalc = MSaver_CalcTalentsHealPercent(strSpell);
					local numManaMult = MSaver_CalcTalentsLessManaPercent(strSpell);
					--DEFAULT_CHAT_FRAME:AddMessage(string.format("numDelta - %g", numDelta));
					--DEFAULT_CHAT_FRAME:AddMessage(string.format("Lvl-%d, Mult-%g, stkLev-%g, item-%g, numD-%g, calc-%g, mmult-%g, mana-%g, mcost-%g", i, numCalc, stkLevel[i], numHealItemVal, numDelta, (numCalc*(stkLevel[i]) + numHealItemVal),numManaMult,UnitMana("player"),spellMana[i]));
					
					if ((i == highrank) or (ranklevels[i+1] > UnitLevel("player"))) then rankpicked = i; break
					elseif (lvlmatters and (UnitLevel(target) + 10 < ranklevels[i+1])) then rankpicked = i; break
					elseif ((numManaMult * spellMana[i+1]) > UnitMana("player")) then rankpicked = i; break  -- next level spell is too much mana, so cast this one
					elseif (numDelta <= (numCalc*(stkLevel[i]) + numHealItemVal)) then rankpicked = MSaver_CalcOverhealRank(highrank,i,varOverheal); break
					elseif (i == highrank) then rankpicked = i; break
					end	
				end
				if (rankpicked) then 
					CastSpell(ManaSave_PlayerSpells[strSpell][rankpicked],"spell");
					--CastSpellByName(strSpell.."("..MANASAVE_RANK.." "..rankpicked..")");
					SpellTargetUnit(target);
					MSaver_PostSpellInChat(target, strSpell, rankpicked);			
				end
			end
		end
	end
end
