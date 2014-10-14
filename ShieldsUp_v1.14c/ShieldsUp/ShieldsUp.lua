------------------------------------------------------------------------------------------------------------
-- ShieldsUp
-- Created by Towrac (Mal'Ganis EU)
--
-- This Addon tries to activate all Mage "shields" and use other useful mage stuff in the most effective way with binding just a single key.
------------------------------------------------------------------------------------------------------------
-- just copy/paste help for the colors
-- red     		 |cFFFF0050
-- blue    		 |cFF0090FF
-- light blue 	 |cFF00FFFF
-- green         |cFF00FF00
-- ShieldsUp     |cFF0040FFS|cFF0090FFh|cFF00FFFFi|cFFFFFFFFe|cFF00FFFFl|cFF0090FFd|cFF00FFFFs|cFFFFFFFFU|cFF0090FFp

SHIELDSUP_VERSION = "1.14c";
BINDING_HEADER_SHIELDSUP = "ShieldsUp";
SHIELDSUP_BOOKTYPE_SPELL = "spell";

--these variables save the time when you took the last dmg of the appropriate damage type.
local anyDmgTime = nil;
local physDmgTime = nil;
local holyDmgTime = nil;
local fireDmgTime = nil;
local unknDmgTime = nil;
local frostDmgTime = nil;
local shadowDmgTime = nil;
local arcaneDmgTime = nil;

--local lastFunctionCall = nil;

local debug = false;

local unitClass = nil;
local dummy = nil;              --this dummy is to get the second return value (dont know if I could get it another way)

--local frame = nil;
local f_NOTHING, f_FIREWARD, f_FROSTWARD, f_MANASHIELD, f_ICEBARRIER, f_ICEBLOCK, f_COLDSNAP = nil;
local t_NOTHING, t_FIREWARD, t_FROSTWARD, t_MANASHIELD, t_ICEBARRIER, t_ICEBLOCK, t_COLDSNAP = nil;
--local f_PARENT = nil;     --to use when inheriting frames is included!
--local t_PARENT = nil;
--these variables are for checking if Frames were setup. This is done to prevent any undefined behavior concerning Frames!
local firewardFrame = false;
local frostwardFrame = false;
local manashieldFrame = false;
local iceblockFrame = false;
local icebarrierFrame = false;
local coldsnapFrame = false;

local lastSpell = nil;
local noSpellIsCast = nil;
local noChannelledSpell = nil;

function ShieldsUp_OnLoad()

 	dummy, unitClass = UnitClass("player");
 	if (unitClass == "MAGE") then
		--registering Events
		this:RegisterEvent("UNIT_COMBAT");
		this:RegisterEvent("ADDON_LOADED");
		this:RegisterEvent("LEARNED_SPELL_IN_TAB");
		this:RegisterEvent("SPELLCAST_START");
		this:RegisterEvent("SPELLCAST_CHANNEL_START");
		this:RegisterEvent("SPELLCAST_FAILED");
		this:RegisterEvent("SPELLCAST_INTERRUPTED");
		this:RegisterEvent("SPELLCAST_STOP");
		this:RegisterEvent("SPELLCAST_CHANNEL_STOP");
		
		--setting up slash commands
		SLASH_SHIELDSUP1 = "/shieldsup";
		SLASH_SHIELDSUP2 = "/su";
		SlashCmdList["SHIELDSUP"] = ShieldsUp_Command;
		
	else
	    ShieldsUp_SendMessage("Charakter is |cFFFF0050not |ra Mage! Not loading Addon!");
	end
	
end


function ShieldsUp_OnEvent(event)
 	if (event == "UNIT_COMBAT" and arg1 == "player") then
 		--if player is affected
 		if (debug) then
 			ShieldsUp_SendMessage("Action: |cFF00FFFF" .. arg2);
 			ShieldsUp_SendMessage("Damage: |cFF00FFFF" .. arg4);
 		end
   		
 		if (arg2 == "RESIST" or arg2 == "DODGE" or arg2 == "MISS") then 
			if (debug) then
				ShieldsUp_SendMessage("You resisted, dodged or enemy missed. No damage taken!");
			end
 		else
 			DmgType(arg5);
 		end

   		
    elseif (event == "ADDON_LOADED" and arg1 == "ShieldsUp") then
       --show loaded message
		ShieldsUp_SendMessage("Addon loaded! Version: |cFF00FFFF" .. SHIELDSUP_VERSION .." |rType  |cFF00FFFF/su help |rfor more info.");
		ShieldsUp_SendMessage("Type |cFF00FFFF/su setup |rto setup spell IDs. This is only required for the first time you load this Addon!"); 
		--calling init function
		ShieldsUp_Init();
		--TEST------------------------------------------
		--frame = getglobal("ShieldsUpFrame");
		--frame:Show();
		--TEST------------------------------------------
		
	elseif (event == "SPELLCAST_START") then
        noSpellIsCast = false;
		if (debug) then
            ShieldsUp_SendMessage("Spell starts casting.");
	    end
	elseif (event == "SPELLCAST_CHANNEL_START") then
	    noSpellIsCast = false;
	    noChannelledSpell = false;
	    if (debug) then
            ShieldsUp_SendMessage("Channelled spell started casting.");
	    end
	
	elseif (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
		noSpellIsCast = true;
		if (debug) then
            ShieldsUp_SendMessage("Spell was interrupted or spell failed.");
	    end

    --elseif (event == "SPELLCAST_STOP" and time()-lastFunctionCall <= 1 and noSpellIsCast) then
	elseif (event == "SPELLCAST_STOP") then
        if (noSpellIsCast) then         --this only happens if spell was instantcast!==> instant cast Spells dont fire SPELLCAST_START events!
        	ShieldsUp_ShowIcon();
           	if (debug) then
            	ShieldsUp_SendMessage("Instant Cast Spell was cast.");
	    	end

      	else
      	    if (noChannelledSpell) then
		    	noSpellIsCast = true;
		    	if (debug) then
            		ShieldsUp_SendMessage("Spell with casttime was cast.");
	    		end
			else
                if (debug) then
            		ShieldsUp_SendMessage("Channelled spell is beeing cast.");
	    		end
			end
		end
		lastSpell = "nothing";
    	if (debug) then
			ShieldsUp_SendMessage("Information about last spell is reset.");
		end

	elseif (event == "SPELLCAST_CHANNEL_STOP") then
	    noSpellIsCast = true;
	    noChannelledSpell = true;
	    if (debug) then
            ShieldsUp_SendMessage("Channelled Spell stopped casting.");
	    end
    elseif (event == "LEARNED_SPELL_IN_TAB") then
		ShieldsUp_SendMessage("Detected new spell... updating IDs!");
		ShieldsUp_Setup();
		
  	end
end

function ShieldsUp_Options_Init()

	if (not SHIELDSUP_Options) then SHIELDSUP_Options = { }; end
		if (SHIELDSUP_Options.timeElapsed == nil) then SHIELDSUP_Options.timeElapsed = 5; end
		if (SHIELDSUP_Options.hpPercent == nil) then SHIELDSUP_Options.hpPercent = 20; end
		if (SHIELDSUP_Options.lowHpIceBlock == nil) then SHIELDSUP_Options.lowHpIceBlock = true; end
		if (SHIELDSUP_Options.changeKey == nil) then SHIELDSUP_Options.changeKey = false; end
		if (SHIELDSUP_Options.visual == nil) then SHIELDSUP_Options.visual = true; end
		
		if (SHIELDSUP_Options.fireward == nil) then SHIELDSUP_Options.fireward = true; end
		if (SHIELDSUP_Options.frostward == nil) then SHIELDSUP_Options.frostward = true; end
		if (SHIELDSUP_Options.manashield == nil) then SHIELDSUP_Options.manashield = true; end
		if (SHIELDSUP_Options.icebarrier == nil) then SHIELDSUP_Options.icebarrier = true; end

		-- These are the Standards paths (there is actually NO reason why these should change. However the Textures will be updated
		-- when you type /su setup just to be sure... ;)
		if (SHIELDSUP_Options.firewardTexture == nil) then SHIELDSUP_Options.firewardTexture = "Interface\\Icons\\Spell_Fire_FireArmor.blp"; end
		if (SHIELDSUP_Options.frostwardTexture == nil) then SHIELDSUP_Options.frostwardTexture = "Interface\\Icons\\Spell_Frost_FrostWard.blp"; end
		if (SHIELDSUP_Options.manashieldTexture == nil) then SHIELDSUP_Options.manashieldTexture = "Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility"; end
		-- the Texture name for Icebarrier is still unknown to me :(
		if (SHIELDSUP_Options.icebarrierTexture == nil) then SHIELDSUP_Options.icebarrierTexture = "Interface\\Icons\\"; end
		if (SHIELDSUP_Options.iceblockTexture == nil) then SHIELDSUP_Options.iceblockTexture = "Interface\\Icons\\Spell_Frost_Frost"; end
		if (SHIELDSUP_Options.coldsnapTexture == nil) then SHIELDSUP_Options.coldsnapTexture = "Interface\\Icons\\Spell_Frost_WizardMark"; end
		
		if (SHIELDSUP_Options.firewardId == nil) then SHIELDSUP_Options.firewardId = 0; end
		if (SHIELDSUP_Options.frostwardId == nil) then SHIELDSUP_Options.frostwardId = 0; end
		if (SHIELDSUP_Options.manashieldId == nil) then SHIELDSUP_Options.manashieldId = 0; end
		if (SHIELDSUP_Options.icebarrierId == nil) then SHIELDSUP_Options.icebarrierId = 0; end
		if (SHIELDSUP_Options.iceblockId == nil) then SHIELDSUP_Options.iceblockId = 0; end
		if (SHIELDSUP_Options.coldsnapId == nil) then SHIELDSUP_Options.coldsnapId = 0; end
		
end
function ShieldsUp_Init()

	--initializing variable with time on startup
	globalTime = time();
	anyDmgTime = time();
	physDmgTime = time();
	holyDmgTime = time();
	fireDmgTime = time();
	unknDmgTime = time();
	frostDmgTime = time();
	shadowDmgTime = time();
	arcaneDmgTime = time();
	--lastFunctionCall = time();
	
	lastSpell = "nothing";
	noSpellIsCast = true;
	noChannelledSpell = true;

	ShieldsUp_Options_Init()
	ShieldsUp_ShowSpellStatus();
	ShieldsUp_SetupFrames();
	
end


function ShieldsUp_SetupFrames()

    --create standard frame
	f_NOTHING = CreateFrame("Frame","ShieldsUpFrame_NOTHING",UIParent);
	f_NOTHING:SetFrameStrata("BACKGROUND");
	f_NOTHING:SetWidth(80);  -- Set These to whatever height/width is needed
	f_NOTHING:SetHeight(80); -- for your Texture

	t_NOTHING = f_NOTHING:CreateTexture(nil,"BACKGROUND");
	t_NOTHING:SetTexture("Interface\\Icons\\Spell_Nature_Polymorph.blp");
	--t_NOTHING:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark.blp");
	t_NOTHING:SetAllPoints(f_NOTHING);
	f_NOTHING.texture = t_NOTHING;

	f_NOTHING:SetPoint("CENTER",0,150);
	f_NOTHING:Hide();
	
	if (SHIELDSUP_Options.firewardId > 0) then
		f_FIREWARD = CreateFrame("Frame","ShieldsUpFrame_FIREWARD",UIParent);
		f_FIREWARD:SetFrameStrata("BACKGROUND");
		f_FIREWARD:SetWidth(80);  -- Set These to whatever height/width is needed
		f_FIREWARD:SetHeight(80); -- for your Texture

		t_FIREWARD = f_FIREWARD:CreateTexture(nil,"BACKGROUND");
		t_FIREWARD:SetTexture(SHIELDSUP_Options.firewardTexture);
		t_FIREWARD:SetAllPoints(f_FIREWARD);
		f_FIREWARD.texture = t_FIREWARD;

		f_FIREWARD:SetPoint("CENTER",0,150);
		f_FIREWARD:Hide();
		firewardFrame = true;
	else
	    firewardFrame = false;
	end
	
	if (SHIELDSUP_Options.frostwardId > 0) then
		f_FROSTWARD = CreateFrame("Frame","ShieldsUpFrame_FROSTWARD",UIParent);
		f_FROSTWARD:SetFrameStrata("BACKGROUND");
		f_FROSTWARD:SetWidth(80);  -- Set These to whatever height/width is needed
		f_FROSTWARD:SetHeight(80); -- for your Texture

		t_FROSTWARD = f_FROSTWARD:CreateTexture(nil,"BACKGROUND");
		t_FROSTWARD:SetTexture(SHIELDSUP_Options.frostwardTexture);
		t_FROSTWARD:SetAllPoints(f_FROSTWARD);
		f_FROSTWARD.texture = t_FROSTWARD;

		f_FROSTWARD:SetPoint("CENTER",0,150);
		f_FROSTWARD:Hide();
		frostwardFrame = true;
	else
	    frostwardFrame = false;
	end
	
	if (SHIELDSUP_Options.manashieldId > 0) then
		f_MANASHIELD = CreateFrame("Frame","ShieldsUpFrame_MANASHIELD",UIParent);
		f_MANASHIELD:SetFrameStrata("BACKGROUND");
		f_MANASHIELD:SetWidth(80);  -- Set These to whatever height/width is needed
		f_MANASHIELD:SetHeight(80); -- for your Texture

		t_MANASHIELD = f_MANASHIELD:CreateTexture(nil,"BACKGROUND");
		t_MANASHIELD:SetTexture(SHIELDSUP_Options.manashieldTexture);
		t_MANASHIELD:SetAllPoints(f_MANASHIELD);
		f_MANASHIELD.texture = t_MANASHIELD;

		f_MANASHIELD:SetPoint("CENTER",0,150);
		f_MANASHIELD:Hide();
		manashieldFrame = true;
	else
	    manashieldFrame = false;
	end
	
	if (SHIELDSUP_Options.icebarrierId > 0) then
		f_ICEBARRIER = CreateFrame("Frame","ShieldsUpFrame_ICEBARRIER",UIParent);
		f_ICEBARRIER:SetFrameStrata("BACKGROUND");
		f_ICEBARRIER:SetWidth(80);  -- Set These to whatever height/width is needed
		f_ICEBARRIER:SetHeight(80); -- for your Texture

		t_ICEBARRIER = f_ICEBARRIER:CreateTexture(nil,"BACKGROUND");
		t_ICEBARRIER:SetTexture(SHIELDSUP_Options.icebarrierTexture);
		t_ICEBARRIER:SetAllPoints(f_ICEBARRIER);
		f_ICEBARRIER.texture = t_ICEBARRIER;

		f_ICEBARRIER:SetPoint("CENTER",0,150);
		f_ICEBARRIER:Hide();
		icebarrierFrame = true;
	else
	    icebarrierFrame = false;
	end
	
	if (SHIELDSUP_Options.iceblockId > 0) then
		f_ICEBLOCK = CreateFrame("Frame","ShieldsUpFrame_ICEBLOCK",UIParent);
		f_ICEBLOCK:SetFrameStrata("BACKGROUND");
		f_ICEBLOCK:SetWidth(80);  -- Set These to whatever height/width is needed
		f_ICEBLOCK:SetHeight(80); -- for your Texture

		t_ICEBLOCK = f_ICEBLOCK:CreateTexture(nil,"BACKGROUND");
		t_ICEBLOCK:SetTexture(SHIELDSUP_Options.iceblockTexture);
		t_ICEBLOCK:SetAllPoints(f_ICEBLOCK);
		f_ICEBLOCK.texture = t_ICEBLOCK;

		f_ICEBLOCK:SetPoint("CENTER",0,150);
		f_ICEBLOCK:Hide();
		iceblockFrame = true;
	else
	    iceblockFrame = false;
	end
	
	if (SHIELDSUP_Options.coldsnapId > 0) then
		f_COLDSNAP = CreateFrame("Frame","ShieldsUpFrame_COLDSNAP",UIParent);
		f_COLDSNAP:SetFrameStrata("BACKGROUND");
		f_COLDSNAP:SetWidth(80);  -- Set These to whatever height/width is needed
		f_COLDSNAP:SetHeight(80); -- for your Texture

		t_COLDSNAP = f_COLDSNAP:CreateTexture(nil,"BACKGROUND");
		t_COLDSNAP:SetTexture(SHIELDSUP_Options.coldsnapTexture);
		t_COLDSNAP:SetAllPoints(f_COLDSNAP);
		f_COLDSNAP.texture = t_COLDSNAP;

		f_COLDSNAP:SetPoint("CENTER",0,150);
		f_COLDSNAP:Hide();
		coldsnapFrame = true;
	else
	    coldsnapFrame = false;
	end
	
end

function ShieldsUp_ShowIcon()

	if (SHIELDSUP_Options.visual) then
		if (lastSpell == "fireward" and firewardFrame) then
            UIFrameFlash (f_FIREWARD, 0.5, 0.5, 1, false, 0, 0);
            if (debug) then
            	ShieldsUp_SendMessage("Fire Ward Frame is shown.");
	    	end
    	elseif (lastSpell == "frostward" and frostwardFrame) then
            UIFrameFlash (f_FROSTWARD, 0.5, 0.5, 1, false, 0, 0);
            if (debug) then
            	ShieldsUp_SendMessage("Frost Ward Frame is shown.");
	    	end
		elseif (lastSpell == "manashield" and manashieldFrame) then
            UIFrameFlash (f_MANASHIELD, 0.5, 0.5, 1, false, 0, 0);
            if (debug) then
            	ShieldsUp_SendMessage("Mana Shield Frame is shown.");
	    	end
		elseif (lastSpell == "iceblock" and iceblockFrame) then
            UIFrameFlash (f_ICEBLOCK, 0.5, 0.5, 1, false, 0, 0);
            if (debug) then
            	ShieldsUp_SendMessage("Iceblock Frame is shown.");
	    	end
		elseif (lastSpell == "coldsnap" and coldsnapFrame) then
            UIFrameFlash (f_COLDSNAP, 0.5, 0.5, 1, false, 0, 0);
            if (debug) then
            	ShieldsUp_SendMessage("Cold Snap Frame is shown.");
	    	end
		elseif (lastSpell == "icebarrier"and icebarrierFrame) then
            UIFrameFlash (f_ICEBARRIER, 0.5, 0.5, 1, false, 0, 0);
            if (debug) then
            	ShieldsUp_SendMessage("Icebarrier Frame is shown.");
	    	end
		elseif (lastSpell == "nothing") then
            if (debug) then
	    		ShieldsUp_SendMessage("No spell was cast through ShieldsUp!");
			end
		else
			ShieldsUp_SendMessage("Error! No supported spell.");
 		end
	else
	    if (debug) then
	    	ShieldsUp_SendMessage("Visual Mode is disabled.");
		end
	end

end

function ShieldsUp_GetSpellIdsAndTextures()
	SHIELDSUP_Options.firewardId = ShieldsUp_GetSpellId(SHIELDSUP_FIREWARD);
	SHIELDSUP_Options.frostwardId = ShieldsUp_GetSpellId(SHIELDSUP_FROSTWARD);
	SHIELDSUP_Options.manashieldId = ShieldsUp_GetSpellId(SHIELDSUP_MANASHIELD);
	SHIELDSUP_Options.iceblockId = ShieldsUp_GetSpellId(SHIELDSUP_ICEBLOCK);
	SHIELDSUP_Options.coldsnapId = ShieldsUp_GetSpellId(SHIELDSUP_COLDSNAP);
	SHIELDSUP_Options.icebarrierId = ShieldsUp_GetSpellId(SHIELDSUP_ICEBARRIER);
	if not (SHIELDSUP_Options.firewardId == 0) then
		SHIELDSUP_Options.firewardTexture = GetSpellTexture(SHIELDSUP_Options.firewardId, SHIELDSUP_BOOKTYPE_SPELL);
	end
	if not (SHIELDSUP_Options.frostwardId == 0) then
		SHIELDSUP_Options.frostwardTexture = GetSpellTexture(SHIELDSUP_Options.frostwardId, SHIELDSUP_BOOKTYPE_SPELL);
	end
	if not(SHIELDSUP_Options.manashieldId == 0) then
		SHIELDSUP_Options.manashieldTexture = GetSpellTexture(SHIELDSUP_Options.manashieldId, SHIELDSUP_BOOKTYPE_SPELL);
	end
	if not (SHIELDSUP_Options.iceblockId == 0) then
		SHIELDSUP_Options.iceblockTexture = GetSpellTexture(SHIELDSUP_Options.iceblockId, SHIELDSUP_BOOKTYPE_SPELL);
	end
	if not (SHIELDSUP_Options.coldsnapId == 0) then
		SHIELDSUP_Options.coldsnapTexture = GetSpellTexture(SHIELDSUP_Options.coldsnapId, SHIELDSUP_BOOKTYPE_SPELL);
	end
	if not (SHIELDSUP_Options.icebarrierId == 0) then
		SHIELDSUP_Options.icebarrierTexture = GetSpellTexture(SHIELDSUP_Options.icebarrierId, SHIELDSUP_BOOKTYPE_SPELL);
	end
	
	ShieldsUp_ShowSpellIds();
	ShieldsUp_ShowSpellTextures();
end

function ShieldsUp_ShowSpellStatus()
	
	if (SHIELDSUP_Options.fireward) then
	    ShieldsUp_SendMessage("Fire Ward is |cFF00FF00enabled");
	else
	    ShieldsUp_SendMessage("Fire Ward is |cFFFF0050disabled");
	end
	if (SHIELDSUP_Options.frostward) then
	    ShieldsUp_SendMessage("Frost Ward is |cFF00FF00enabled");
	else
	    ShieldsUp_SendMessage("Frost Ward is |cFFFF0050disabled");
	end
	if (SHIELDSUP_Options.manashield) then
	    ShieldsUp_SendMessage("Mana Shield is |cFF00FF00enabled");
	else
	    ShieldsUp_SendMessage("Mana Shield is |cFFFF0050disabled");
	end
	if (SHIELDSUP_Options.icebarrier) then
	    ShieldsUp_SendMessage("Ice Barrier is |cFF00FF00enabled");
	else
	    ShieldsUp_SendMessage("Ice Barrier is |cFFFF0050disabled");
	end

	DEFAULT_CHAT_FRAME:AddMessage(" ");
	if (SHIELDSUP_Options.lowHpIceBlock) then
	    ShieldsUp_SendMessage("Casting Iceblock on low hitpoints is |cFF00FF00enabled");
	else
	    ShieldsUp_SendMessage("Casting Iceblock on low hitpoints is |cFFFF0050disabled");
	end
	if (SHIELDSUP_Options.changeKey) then
	    ShieldsUp_SendMessage("Alt- and Ctrl-key functionality is |cFFFF0050reversed");
	else
	    ShieldsUp_SendMessage("Alt- and Ctrl-key functionality is |cFF00FF00normal");
	end
    if (SHIELDSUP_Options.visual) then
	    ShieldsUp_SendMessage("Visual Mode is |cFF00FF00enabled");
	else
	    ShieldsUp_SendMessage("Visual Mode is |cFFFF0050disabled");
	end
end

function DmgType(type)

   	local dmgType = nil;

	anyDmgTime = time();
	if (type == 0) then
		physDmgTime = time();
   		dmgType = "physical"
	elseif (type == 1) then
		holyDmgTime = time();
		dmgType = "holy"
	elseif (type == 2) then
		fireDmgTime = time();
		dmgType = "fire"
	elseif (type == 3) then
		unknDmgTime = time();
		dmgType = "nature"
	elseif (type == 4) then
		frostDmgTime = time();
		dmgType = "frost"
	elseif (type == 5) then
		shadowDmgTime = time();
		dmgType = "shadow"
	elseif (type == 6) then
		arcaneDmgTime = time();
		dmgType = "arcane"
	else
		ShieldsUp_SendMessage("|cFFFF0050ERROR: |rUnknown Damage Type!");
	end
	if (debug) then
		ShieldsUp_SendMessage("You took |cFF00FFFF" .. dmgType .. " |rDamage.");
	end
end

-------------------------------------------------------------------------------------------------------------
-- todo for this function:
--								
--                              
--
--								
--
--								code cleanup
--
--                              
--                              
--
--                              
--
--                              
--                              
-------------------------------------------------------------------------------------------------------------

function ShieldsUp_All()
	--showAllUnitBuffs("player"); 													--this is just for testing, ignore it
	lastSpell = "nothing";
 	if (IsControlKeyDown()) then

		if (SHIELDSUP_Options.changeKey) then

			if (SHIELDSUP_Options.iceblockId > 0 and ShieldsUp_GetCooldown(SHIELDSUP_Options.iceblockId) == 0) then
				CastSpellByName(SHIELDSUP_ICEBLOCK);
    			lastSpell = "iceblock";
    			if (debug) then
                    ShieldsUp_SendMessage("Iceblock should have been cast.");
				end
			else
				if (debug) then 
					ShieldsUp_SendMessage("No Iceblock detected or cooldown!");
				end
			end
			
		else
		
			if (SHIELDSUP_Options.coldsnapId > 0 and ShieldsUp_GetCooldown(SHIELDSUP_Options.coldsnapId) == 0) then
				CastSpellByName(SHIELDSUP_COLDSNAP);
   				lastSpell = "coldsnap";
   				if (debug) then
                    ShieldsUp_SendMessage("Cold Snap should have been cast.");
				end
			else
				if (debug) then
					ShieldsUp_SendMessage("No Cold Snap detected or cooldown!");
				end
			end
			
		end
		
	elseif (IsAltKeyDown()) then

		if (SHIELDSUP_Options.changeKey) then

			if (SHIELDSUP_Options.coldsnapId > 0 and ShieldsUp_GetCooldown(SHIELDSUP_Options.coldsnapId) == 0) then
				CastSpellByName(SHIELDSUP_COLDSNAP);
   				lastSpell = "coldsnap";
   				if (debug) then
                    ShieldsUp_SendMessage("Cold Snap should have been cast.");
				end
			else
				if (debug) then
					ShieldsUp_SendMessage("No Cold Snap detected or cooldown!");
				end
			end
			
		else

			if (SHIELDSUP_Options.iceblockId > 0 and ShieldsUp_GetCooldown(SHIELDSUP_Options.iceblockId) == 0) then
				CastSpellByName(SHIELDSUP_ICEBLOCK);
				lastSpell = "iceblock";
				if (debug) then
                    ShieldsUp_SendMessage("Iceblock should have been cast.");
				end
			else
				if (debug) then 
					ShieldsUp_SendMessage("No Iceblock detected or cooldown!");
				end
			end
			
		end
	   
	elseif (SHIELDSUP_Options.iceblockId > 0 and ((UnitHealth("player") / UnitHealthMax("player"))*100) <= SHIELDSUP_Options.hpPercent and SHIELDSUP_Options.lowHpIceBlock and ShieldsUp_GetCooldown(SHIELDSUP_Options.iceblockId) == 0) then

		CastSpellByName(SHIELDSUP_ICEBLOCK);
  		lastSpell = "iceblock";
  		if (debug) then
            ShieldsUp_SendMessage("Iceblock should have been casted");
		end

	elseif (SHIELDSUP_Options.firewardId > 0 and time()-fireDmgTime <= SHIELDSUP_Options.timeElapsed and SHIELDSUP_Options.fireward and ShieldsUp_GetCooldown(SHIELDSUP_Options.firewardId) == 0) then				--fire dmg

		CastSpellByName(SHIELDSUP_FIREWARD);
 		lastSpell = "fireward";
 		if (debug) then
            ShieldsUp_SendMessage("Fire Ward should have been cast.");
		end

	elseif (SHIELDSUP_Options.frostwardId > 0 and time()-frostDmgTime <= SHIELDSUP_Options.timeElapsed and SHIELDSUP_Options.frostward and ShieldsUp_GetCooldown(SHIELDSUP_Options.frostwardId) == 0) then			--frost dmg

		CastSpellByName(SHIELDSUP_FROSTWARD);
  		lastSpell = "frostward";
  		if (debug) then
            ShieldsUp_SendMessage("Frost Ward should have been cast.");
		end

	elseif (SHIELDSUP_Options.icebarrierId > 0 and SHIELDSUP_Options.icebarrier and ShieldsUp_GetCooldown(SHIELDSUP_Options.icebarrierId) == 0) then
	
		CastSpellByName(SHIELDSUP_ICEBARRIER);
  		lastSpell = "icebarrier";
  		if (debug) then
            ShieldsUp_SendMessage("Icebarrier should have been cast.");
		end

	elseif (SHIELDSUP_Options.manashieldId > 0 and time()-physDmgTime <= SHIELDSUP_Options.timeElapsed and SHIELDSUP_Options.manashield) then 								--i know its a double check

		if (isPlayerBuffUp("DetectLesserInvisibility") == true) then
				ShieldsUp_SendMessage("Manashield already up!");
		else
				CastSpellByName(SHIELDSUP_MANASHIELD);
  				lastSpell = "manashield";
  				if (debug) then
            		ShieldsUp_SendMessage("Mana Shield should have been cast.");
				end
		end
		
	elseif (time()-anyDmgTime > SHIELDSUP_Options.timeElapsed) then

		ShieldsUp_SendMessage("|cFFFF0050Not casting! |rYou took damage too long ago: |cFF00FFFF" .. time()-anyDmgTime .. "|r seconds.");
		if (SHIELDSUP_Options.visual) then
			UIFrameFlash (f_NOTHING, 0.5, 0.5, 1, false, 0, 0);
			PlaySoundFile("Interface\\AddOns\\ShieldsUp\\Sounds\\PolyMorphTarget.wav");
			--lastSpell = "nothing";
		elseif (debug) then
		        ShieldsUp_SendMessage("Visual Mode is disabled!");
		end
				
	else

		ShieldsUp_SendMessage("|cFFFF0050Not casting! |rAbsorb spells on cooldown or damage type cannot be absorbed!");
		if (SHIELDSUP_Options.visual) then
			UIFrameFlash (f_NOTHING, 0.5, 0.5, 1, false, 0, 0);
			PlaySoundFile("Interface\\AddOns\\ShieldsUp\\Sounds\\PolyMorphTarget.wav");
			--lastSpell = "nothing";
		elseif (debug) then
		        ShieldsUp_SendMessage("Visual Mode is disabled!");
		end
	end
	--lastFunctionCall = time();
	
end


function ShieldsUp_Command(cmd)
	if (cmd == "debug") then
		ShieldsUp_ToggleDebug();
	elseif (cmd == "help") then
	    ShieldsUp_ShowHelp();
	elseif (cmd == "fireward") then
		if (SHIELDSUP_Options.fireward) then
			SHIELDSUP_Options.fireward = false;
			ShieldsUp_SendMessage("Fire Ward now |cFFFF0050disabled");
		else 
			SHIELDSUP_Options.fireward = true;
			ShieldsUp_SendMessage("Fire Ward now |cFF00FF00enabled");
		end	
	elseif (cmd == "frostward") then
	    if (SHIELDSUP_Options.frostward) then
			SHIELDSUP_Options.frostward = false;
			ShieldsUp_SendMessage("Frost Ward now |cFFFF0050disabled");
		else 
			SHIELDSUP_Options.frostward = true;
			ShieldsUp_SendMessage("Frost Ward now |cFF00FF00enabled");
		end	
	elseif (cmd == "manashield") then
	    if (SHIELDSUP_Options.manashield) then
			SHIELDSUP_Options.manashield = false;
			ShieldsUp_SendMessage("Mana Shield now |cFFFF0050disabled");
		else 
			SHIELDSUP_Options.manashield = true;
			ShieldsUp_SendMessage("Mana Shield now |cFF00FF00enabled");
		end	
	elseif (cmd == "icebarrier") then
	    if (SHIELDSUP_Options.icebarrier) then
			SHIELDSUP_Options.icebarrier = false;
			ShieldsUp_SendMessage("Ice Barrier now |cFFFF0050disabled");
		else 
			SHIELDSUP_Options.icebarrier = true;
			ShieldsUp_SendMessage("Ice Barrier now |cFF00FF00enabled");
		end
  	elseif (cmd == "icetoggle") then
	    if (SHIELDSUP_Options.lowHpIceBlock) then
			SHIELDSUP_Options.lowHpIceBlock = false;
			ShieldsUp_SendMessage("Casting Iceblock on low hitpoints is |cFFFF0050disabled");
		else
			SHIELDSUP_Options.lowHpIceBlock = true;
			ShieldsUp_SendMessage("Casting Iceblock on low hitpoints is |cFF00FF00enabled");
		end
	elseif (cmd == "keytoggle") then
	    if (SHIELDSUP_Options.changeKey) then
			SHIELDSUP_Options.changeKey = false;
			ShieldsUp_SendMessage("Alt- and Ctrl-key functionality is now |cFF00FF00normal");
		else
			SHIELDSUP_Options.changeKey = true;
			ShieldsUp_SendMessage("Alt- and Ctrl-key functionality is now |cFFFF0050reversed");
		end
	elseif (cmd == "visual") then
	    if (SHIELDSUP_Options.visual) then
			SHIELDSUP_Options.visual = false;
			ShieldsUp_SendMessage("Visaul Mode |cFFFF0050disabled");
		else
			SHIELDSUP_Options.visual = true;
			ShieldsUp_SendMessage("Visual Mode |cFF00FF00enabled");
		end
	elseif (cmd == "setup") then
		ShieldsUp_SendMessage("Detecting Spell IDs! You only have to do this once!");
		ShieldsUp_Setup();
	elseif (cmd == "show") then
		ShieldsUp_ShowSpellStatus();
	    ShieldsUp_ShowSpellIds();
	else
		ShieldsUp_SendMessage("|cFFFF0050Unknown Command!")
	end
	
	if (debug) then
  		ShieldsUp_SendMessage("Command sent to function: |cFF00FFFF" .. cmd);
   	end
end

function ShieldsUp_Setup()
	
	ShieldsUp_GetSpellIdsAndTextures();
	ShieldsUp_SetupFrames();
end

function ShieldsUp_ShowHelp()
    ShieldsUp_SendMessage("Helpfile =======================================");
    DEFAULT_CHAT_FRAME:AddMessage("Use /shieldsup |cFF00FFFFCOMMAND |ror /su |cFF00FFFFCOMMAND|r!");
    DEFAULT_CHAT_FRAME:AddMessage("Commands are:");
	DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFdebug |renables debug mode.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFhelp |rshows this Helpfile.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFfireward |rtoggles Fire Ward on and off.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFfrostward |rtoggles Frost Ward on and off.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFmanashield |rtoggles Mana Shield on and off.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFicebarrier |rtoggles Ice Barrier on and off.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFicetoggle |rtoggles casting Iceblock with low hitpoints on and off.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFvisual |rtoggles Visual Mode on and off.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFkeytoggle |rreverses Alt- and Ctrl-key functionality.");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFshow |rshows several options. If all spell IDs are 0 type  |cFF00FFFF/su setup");
    DEFAULT_CHAT_FRAME:AddMessage("- |cFF00FFFFsetup |rgets spell IDs (usually needed on first load only)");
    --DEFAULT_CHAT_FRAME:AddMessage("- \t|cFF00FFFFtime  |rexplanation here.");
    DEFAULT_CHAT_FRAME:AddMessage(" ");
    if (SHIELDSUP_Options.changeKey) then
        DEFAULT_CHAT_FRAME:AddMessage("- pressing Alt-key + bound key activates Cold Snap.");
    	DEFAULT_CHAT_FRAME:AddMessage("- pressing Ctrl-key + bound key activates Iceblock.");
	else
    	DEFAULT_CHAT_FRAME:AddMessage("- pressing Alt-key + bound key activates Iceblock.");
    	DEFAULT_CHAT_FRAME:AddMessage("- pressing Ctrl-key + bound key activates Cold Snap.");
    end
    DEFAULT_CHAT_FRAME:AddMessage(" ");
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0050Important! |rIf anything weird or nothing happens type |cFF00FFFF/su show |rand check if all appropriate spells you have in your spellbook are enabled or disabled if you dont have them yet! Then type |cFF00FFFF/su setup |rto update spell IDs! This should solve most problems!");  
    
end

function ShieldsUp_ToggleDebug()
	if (debug == false) then
	    debug = true;
	    ShieldsUp_SendMessage("Debugmode: |cFF00FFFFon");
    else
	    debug = false;
	    ShieldsUp_SendMessage("Debugmode: |cFF00FFFFoff");
    end
end
----------------------------------------------------------------------------------------------------
--ShieldsUp_SendMessage
----------------------------------------------------------------------------------------------------
function ShieldsUp_SendMessage(msg)

     DEFAULT_CHAT_FRAME:AddMessage("|cFF0040FFS|cFF0090FFh|cFF00FFFFi|cFFFFFFFFe|cFF00FFFFl|cFF0090FFd|cFF00FFFFs|cFFFFFFFFU|cFF0090FFp|cFF00FFFF: |r" .. msg);
end
----------------------------------------------------------------------------------------------------
function isPlayerBuffUp(sBuffname)
  local iIterator = 1
  while (UnitBuff("player", iIterator)) do
  	--ShieldsUp_SendMessage(UnitBuff("player", iIterator));
    if (string.find(UnitBuff("player", iIterator), sBuffname)) then
      return true
    end
    iIterator = iIterator + 1
  end
  return false
end

function ShieldsUp_GetCooldown(spellid)
	local start, duration, enabled = GetSpellCooldown(spellid, SHIELDSUP_BOOKTYPE_SPELL);
	if (debug) then
		ShieldsUp_SendMessage("Spell ID: " .. spellid .. " Cooldown duration: " .. duration);
	end
	return duration;
end

function ShieldsUp_GetSpellId(spell)
local i = 1
	while true do
   		local spellName, spellRank = GetSpellName(i, SHIELDSUP_BOOKTYPE_SPELL)
   		if (spell == spellName) then
   			do break end
		elseif (not spellName) then
    		return 0;
   		end
   
   		-- use spellName and spellRank here
   		--DEFAULT_CHAT_FRAME:AddMessage( spellName .. '(' .. spellRank .. ')' );
   
   		i = i + 1;
	end
	return i;
	--DEFAULT_CHAT_FRAME:AddMessage("Spell ID of: " .. spell .. ": " ..i);
end

function ShieldsUp_ShowSpellIds()
	
    ShieldsUp_SendMessage("Fire Ward ID: |cFF00FFFF" .. SHIELDSUP_Options.firewardId); 
    ShieldsUp_SendMessage("Frost Ward ID: |cFF00FFFF" .. SHIELDSUP_Options.frostwardId);
    ShieldsUp_SendMessage("Mana Shield ID: |cFF00FFFF" .. SHIELDSUP_Options.manashieldId);
    ShieldsUp_SendMessage("Ice Barrier ID: |cFF00FFFF" .. SHIELDSUP_Options.icebarrierId);
    ShieldsUp_SendMessage("Iceblock ID: |cFF00FFFF" .. SHIELDSUP_Options.iceblockId);
    ShieldsUp_SendMessage("Cold Snap ID: |cFF00FFFF" .. SHIELDSUP_Options.coldsnapId);
end

function ShieldsUp_ShowSpellTextures()
	
    ShieldsUp_SendMessage("Fire Ward Texture: |cFF00FFFF" .. SHIELDSUP_Options.firewardTexture); 
    ShieldsUp_SendMessage("Frost Ward Texture: |cFF00FFFF" .. SHIELDSUP_Options.frostwardTexture);
    ShieldsUp_SendMessage("Mana Shiel Texture: |cFF00FFFF" .. SHIELDSUP_Options.manashieldTexture);
    ShieldsUp_SendMessage("Ice Barrier Texture: |cFF00FFFF" .. SHIELDSUP_Options.icebarrierTexture);
    ShieldsUp_SendMessage("Iceblock Texture: |cFF00FFFF" .. SHIELDSUP_Options.iceblockTexture);
    ShieldsUp_SendMessage("Cold Snap Texture: |cFF00FFFF" .. SHIELDSUP_Options.coldsnapTexture);
end
-----------------------------------------------------------------------------------
-- These Functions are just for development. Will probably be removed in the future
-----------------------------------------------------------------------------------
function showAllUnitBuffs(sUnitname)
  local iIterator = 1
  ShieldsUp_SendMessage(format("[%s] Buffs", sUnitname))
  while (UnitBuff(sUnitname, iIterator)) do
    ShieldsUp_SendMessage(UnitBuff(sUnitname, iIterator), 1, 1, 0)
    iIterator = iIterator + 1
  end
  ShieldsUp_SendMessage("---", 1, 1, 0)
end

function ShieldsUp_ShowSpellsInSpellbook()
local i = 1
	while true do
   		local spellName, spellRank = GetSpellName(i, SHIELDSUP_BOOKTYPE_SPELL)
   		if not spellName then
    		do break end
   		end
   
   		-- use spellName and spellRank here
   		DEFAULT_CHAT_FRAME:AddMessage( spellName .. '(' .. spellRank .. ')' )
   
   		i = i + 1
	end
end

---------------------------------------------------------------------------------
--these functions are only for debugging. They "simulate" that you just took dmg.
---------------------------------------------------------------------------------
function physTime()
	anyDmgTime = time();
	physDmgTime = time();
end

function fireTime()
	anyDmgTime = time();
	fireDmgTime = time();
	ShieldsUp_SendMessage("Set Fire Dmg Timer");
	--UIFrameFlash (f_NOTHING, 0.1, 0.1, 1, false, 0, 0);
end

function frostTime()
	anyDmgTime = time();
	frostDmgTime = time();
	ShieldsUp_SendMessage("Set Frost Dmg Timer");
end

--[[function shTest()
	if (f2:IsVisible()) then
	    f2:Hide();
   	else
        f2:Show();
   	end
end ]]

--this functions shows all buffs the player has.
function showTheBuffs()
	showAllUnitBuffs("player");
end
---------------------------------------------------------------------------------