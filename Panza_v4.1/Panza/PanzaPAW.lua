--[[

PanzaPAW.lua
for Panza

Revision 4.0

Panza PAW Dialog and Whisper Handling Functions
Saves and Modifies Saved Blessing List based on whispers received.

10-01-06 "for in pairs()" completed for BC
--]]

---------------------------------------------------------------------------------------------------------------------------------------------
-- Trigger from chat text (only accept commands for long term DCB table buffs)
-- When fully implemented, communicate, or set WhisperCast values to ignore
-- our DCB blessings. Let it handle the short term buff requests, and requests
-- for curing. Here DCB, RGS, and Cycle will handle the longer term blessings.
---------------------------------------------------------------------------------------------------------------------------------------------
--	Index			Trigger shortcut	english		french			german		exact match
---------------------------------------------------------------------------------------------------------------------------------------------
function PA:SetupPAWTriggers()
	PA["trigger"]		= {};
	PA:AddTrigger("bom",	"might",	"puissance",		"Macht");
	PA:AddTrigger("bow",	"wisdom",	"sagesse", 			"Weisheit");
	PA:AddTrigger("bol",	"light",	"lumi\195\168re",	"Lichts");
	PA:AddTrigger("bok",	"kings",	"rois",				"K\195\182nige");
	PA:AddTrigger("bosal",	"salvation","salut",			"Rettung");
	PA:AddTrigger("bosan",	"sancturay","sanctuaire",		"Refugiums");
	PA:AddTrigger("fort",	"fortitude","fortitude",		"Seelenst\195\164rke");
	PA:AddTrigger("sprot",	"shadow",	"shadow",			"Schattenschutz");
	PA.AddTrigger("motw",	"motw",		"motw",				"Wildnis");
	PA.AddTrigger("thorns",	"thorns",	"thorns",			"Dornen");
	PA.AddTrigger("dsprt",  "spirit",	"spirit",			"spirit");
	-- PA:AddTrigger("bosaf",	"sacrifice",				"Opferung");

	-----------------------
	-- Build Exclusion list
	-----------------------
	PA["nontrigger"]	= {}
	PA.nontrigger["PAW"]	= { trigger={"paw","= bo", " or ", " and ", " is ", " use ", " you ", " i ", " be ", " good ", " before ", " drop "}};
end

function PA:AddTrigger(spell, ...)
	if (PA:SpellInSpellBook(spell)) then
		PA.trigger[spell] 	= {trigger={spell, unpack(arg), PA.SpellBook[spell].Name }};
	end
end

function PA:PAW_OnLoad()
	PA.OptionsMenuTree[9] = {Title="Whisper", Frame=this, Tooltip="Whisper Options"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

------------------------
-- Set the PAW UI values
------------------------
function PA:PAW_SetValues()

	cbxPanzaPAWEnable:SetChecked(PASettings.Switches.Whisper.enabled == true);
	cbxPanzaPAWResponse:SetChecked(PASettings.Switches.Whisper.feedback == true);

end

---------------
-- PAW Defaults
---------------
function PA:PAW_Defaults()
	PASettings.Switches.Whisper = {enabled=false,feedback=true,rgs=true,match="any"};
end

function PA:PAW_OnShow()
	PA:Reposition(PanzaPAWFrame, "UIParent", true);
	PanzaPAWFrame:SetAlpha(PASettings.Alpha);
	PA:PAW_SetValues();
end

function PA:PAW_OnHide()
	-- place holder
end

function PA:PAW_btnDone_OnClick()
	PA:FrameToggle(PanzaPAWFrame);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PAW_ShowTooltip(item)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine( PA.PAW_Tooltips[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PA.PAW_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end

-----------------------------
-- Match whispers to triggers
-----------------------------
function PA:MatchSpellTrigger(msg)

	if (PA.Spells~=nil and msg~=nil) then
		local lower_msg = string.lower(msg);

		------------------------------------------------------
		-- Search for messages we will exclude from processing
		------------------------------------------------------
		for pasubsys, attrib in pairs(PA.nontrigger) do

			for _,trigger in pairs(attrib.trigger) do

				if (string.find(lower_msg, trigger)) then
					if (PA:CheckMessageLevel("Core",5)) then
						PA:Message4("(PAW) Ignoring "..pasubsys.." message.");
					end
					--PA:Debug("(PAW) Ignoring ", pasubsys, " message: ", trigger);
					return nil;
				end
			end
		end

		--------------------------------------------
		-- find a spell matching the trigger message
		--------------------------------------------
		for spell, attrib in pairs(PA.trigger) do

			for _, trigger in pairs(attrib.trigger) do

				-- match exactly, ignore any white space or punctuation
				if (string.find(lower_msg, "^[%p%s]*"..trigger.."[%p%s]*$")) then
					--PA:Debug("(PAW) Match exact (no whitespace): ", trigger);
					return spell
				end

				if (PASettings.Switches.Whisper.match == "start" or
					PASettings.Switches.Whisper.match == "any") then
					-- match message that starts with trigger
					if (string.find(lower_msg,"^[%p%s]*"..trigger.."[%p%s]+")) then
						--PA:Debug("(PAW) Match start: ", trigger);
						return spell
					end
				end

				if ( PASettings.Switches.Whisper.match == "any" ) then
					-- match any message with a complete trigger word
					if (string.find(lower_msg,"[%p%s]+"..trigger.."[%p%s]*$") or
						string.find(lower_msg,"[%p%s]+"..trigger.."[%p%s]+")) then
						--PA:Debug("(PAW) Match trigger: ", trigger);
						return spell
					end
				end
			end

			if (lower_msg==trigger) then
				--PA:Debug("(PAW) Match exact: ", trigger);
				return spell;
			end
		end
	end

	--PA:Debug("(PAW) No Match");
	return nil;
end

----------------------------
-- Match a spell in whispers
----------------------------
function PA:MatchSpellFromWhisper(name, trigger)
	if ( not name ) then return nil end

	local spellName = PA:MatchSpellTrigger(trigger);
	if ( not spellName ) then return nil end

	return spellName
end

--------------------------------------------------------------
-- PAW Announcement. Send PAW Help to Say, Party, or Raid Chat
--------------------------------------------------------------
function PA:PAW_Annc()
	local LongSpell, total, rank = "", 0, 0;

	---------------------------------------------------------------
	-- If we are disabled, then there is no point talking about PAW
	---------------------------------------------------------------
	if (not PASettings.Switches.Whisper.enabled == true) then
		if (PA:CheckMessageLevel("Bless",1)) then
			PA:Message4(PANZA_PAW_DISABLED);
		end
		return false;
	end

	----------------------
	-- Announce our header
	----------------------

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("Header being sent.");
	end

	if (PA:IsInRaid()) then
		PA:Notify2("RAID",PANZA_PAW_HEADER);
	elseif (PA:IsInParty()) then
		PA:Notify2("PARTY",PANZA_PAW_HEADER);
	else
		PA:Notify2("SAY",PANZA_PAW_HEADER);
	end

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("PAW_Annc() Looping spells and triggers to supply help.");
	end

	---------------------------------------
	-- Loop through the spell/trigger table
	---------------------------------------
	for spell,attrib in pairs(PA.trigger) do
		-------------------------------
		-- Only announce spells we have
		-------------------------------
		if (PA:SpellInSpellBook(spell)) then
			-------------------------
			-- Get the full spellname
			-------------------------
			LongSpell = PA.SpellBook[spell].Name;
			if (PA:CheckMessageLevel("Core",5)) then
				PA:Message4("(PAW) looking for ("..spell..") "..LongSpell);
			end

			_,trigger = PA:table_first(attrib.trigger)

			if (PA:IsInRaid()) then
				PA:Notify2("RAID",format(PANZA_PAW_ANNCSPELLS, LongSpell, trigger));
			elseif (PA:IsInParty()) then
				PA:Notify2("PARTY",format(PANZA_PAW_ANNCSPELLS, LongSpell, trigger));
			else
				PA:Notify2("SAY",format(PANZA_PAW_ANNCSPELLS, LongSpell, trigger));
			end
        end
	end

	-------------------
	-- Send our Trailer
	-------------------
	if (PA:IsInRaid()) then
		PA:Notify2("RAID",PANZA_PAW_TRAILER);
	elseif (PA:IsInParty()) then
		PA:Notify2("PARTY",PANZA_PAW_TRAILER);
	else
		PA:Notify2("SAY",PANZA_PAW_TRAILER);
	end
end

-------------------------------
-- Process a whisper sent to us
-------------------------------
function PA:ProcessWhisper(name, trigger)
	local localplayer, LongSpell, SpellName, total, rank = false, "", "", 0, 0;
	local unit;

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("Msg Received="..trigger.." from: "..name);
	end

	-----------------------------------------
	-- see if we are testing, prevent looping
	-----------------------------------------
	if (name==PA.PlayerName) then
		localplayer = true;
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("Local Test detected. Msg received from Player");
		end
		unit = "player";
	else
		unit = PA:FindUnitFromName(name);
		
		-- if not found then look-up via /who
	end

	-------------------------------------------------------------------------
	-- Did they ask for PAW, or add a bunch of.. what is paw? just send it.
	-- ( I see dead.. uhh stupid people... they are everywhere )
	-------------------------------------------------------------------------
	if (string.find(string.lower(trigger),"^ *"..PANZA_PAW_CMDANNOUNCE.." *$") or
	    string.find(string.lower(trigger)," +"..PANZA_PAW_CMDANNOUNCE.." *$") or
	    string.find(string.lower(trigger)," +"..PANZA_PAW_CMDANNOUNCE.." +")) then

		local sentHeader = false;

		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("Found help request.");
		end

		-------------------
		-- Are we enabled ?
		-------------------
		if (PASettings.Switches.Whisper.enabled == false) then
			if (PA:CheckMessageLevel("Core",5)) then
				PA:Message4("(PAW) is disabled in the config.");
			end
			if ( PASettings.Switches.Whisper.feedback == true ) then
				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("(PAW) Responses are enabled.");
				end

				--------------------------------------------------------
				-- If WC is installed and queueing is enabled, don't NAK
				--------------------------------------------------------
				if (WhisperCast_Version and
					WhisperCast_Profile and
					WhisperCast_Profile.enable and
					WhisperCast_Profile.enable == 1 ) then
					if (localplayer) then
						if (PA:CheckMessageLevel("Bless",1)) then
							PA:Message4(PANZA_PAW_WC_PASS);
						end
					else
						SendChatMessage(PANZA_PAW_WC_PASS, "WHISPER", PANZA_CHATLANGUAGE, name);
					end
					return false;
				end

				if (localplayer) then
					if (PA:CheckMessageLevel("Bless",1)) then
						PA:Message4(PANZA_PAW_DISABLED);
					end
				else
                	SendChatMessage(PANZA_PAW_DISABLED, "WHISPER", PANZA_CHATLANGUAGE, name);
				end
            end
            return false;
		end

		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("Looping spells and triggers to supply help.");
		end

		---------------------------------------
		-- Loop through the spell/trigger table
		---------------------------------------
		for spell,attrib in pairs(PA.trigger) do

			---------------------------------------------
			-- Announce ourself via whisper feedback once
			---------------------------------------------
			if ( not sentHeader ) then

				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("Header has not been sent.");
				end

				if (localplayer) then
					if (PA:CheckMessageLevel("Bless",1)) then
						PA:Message4(PANZA_PAW_HEADER);
					end
				else
					SendChatMessage(PANZA_PAW_HEADER, 'WHISPER', PANZA_CHATLANGUAGE, name);
				end
				sentHeader = true
			end

			-------------------------------
			-- Only announce spells we have
			-------------------------------
			if (PA:SpellInSpellBook(spell)) then
				-------------------------
				-- Get the full spellname
				-------------------------
				LongSpell = PA.SpellBook[spell].Name;
				if (PA:CheckMessageLevel("Core",5)) then
					-- PA:Message4("(PAW) looking for ("..spell..") "..LongSpell);
				end
				_,trigger = PA:table_first(attrib.trigger)

				if (localplayer) then
					if (PA:CheckMessageLevel("Bless",1)) then
						PA:Message4(format(PANZA_PAW_ANNCSPELLS, LongSpell, trigger));
					end
				else
					SendChatMessage(format(PANZA_PAW_ANNCSPELLS, LongSpell, trigger), 'WHISPER', PANZA_CHATLANGUAGE, name);
				end
			end
		end

		---------------------------------------------------------------------------------
		-- If we do not have any spells that are in the Spells/Trigger table announce it.
		---------------------------------------------------------------------------------
		if ( not sentHeader ) then
			SendChatMessage(PANZA_PAW_NOSPELLS, 'WHISPER', PANZA_CHATLANGUAGE, name);
		end

	---------------------------------
	-- Or did they ask for a Blessing
	----------------------------------
	else
		local shortspell = PA:MatchSpellFromWhisper( name, trigger )
		if (shortspell==nil) then
			return false;
		end

		if (not PA:SpellInSpellBook(shortspell)) then
			if (localplayer) then
				if (PA:CheckMessageLevel("Bless",1)) then
					PA:Message4(format(PANZA_PAW_NOSPELL, shortspell))
				end
			else
				SendChatMessage(format(PANZA_PAW_NOSPELL, shortspell), "WHISPER", PANZA_CHATLANGUAGE, name);
			end

			-- Report what we are supplying - Cant w/o Class

			return false;
		end

		LongSpell = PA.SpellBook[shortspell].Name;

		-----------------------------------------------------------------------------------
		-- 1st Check to see if they have an active spell now, and if feedback is enabled...
		-----------------------------------------------------------------------------------
		if (PACurrentSpells.Indi[name]~=nil and PA.SpellBook~=nil and PASettings.Switches.Whisper.feedback == true) then
			--MULTIBUFF -FIXED!!--
			
			-- PA:Message("Checking PACurrentSpells.Indi["..name.."]");
				
			for Id, SpellInfo in pairs(PACurrentSpells.Indi[name]) do
				-- PA:Message("ID="..Id);
				local Duration = (PA:GetSpellProperty(SpellInfo.Short, "Duration") - GetTime()) + SpellInfo.Time;
				if (Duration==nil) then
					break; --Spells not set-up yet
				end
						
				local SpellName = PA:GetSpellProperty(SpellInfo.Short, "Name");
				--PA:Message("SpellName="..SpellName.." Short="..SpellInfo.Short);
				
				if (SpellName) then --(SpellName == LongSpell) then
					--PA:ShowText("Id=", Name, " Time=", GetTime() - SpellInfo.Time, " ", Duration);
					-- PA:Message("Spell is already Active");
					-- Spell is Good to Go
					if (Duration > 60) then
						if (localplayer) then
							if (PA:CheckMessageLevel("Bless",1)) then
								PA:Message4(format(PANZA_PAW_BLESSINGOK,SpellName,Duration));
							end
						else
							SendChatMessage(format(PANZA_PAW_BLESSINGOK, SpellName, Duration), "WHISPER", PANZA_CHATLANGUAGE, name);
						end
							
					-- Expiring soon
					elseif (Duration and Duration <= 60 and Duration >= 30) then
						if (localplayer) then
							if (PA:CheckMessageLevel("Bless",1)) then
								PA:Message4(format(PANZA_PAW_BLESSINGEXPIRING,SpellName,Duration));
							end
						else
							SendChatMessage(format(PANZA_PAW_BLESSINGEXPIRING, SpellName, Duration), "WHISPER", PANZA_CHATLANGUAGE, name);
						end
		
					-- Fading fast
					elseif (Duration~=nil and Duration <= 30 and Duration >= 0) then
						if (localplayer) then
							if (PA:CheckMessageLevel("Bless",1)) then
								PA:Message4(format(PANZA_PAW_BLESSINGFADING,SpellName,Duration));
							end
						else
							SendChatMessage(format(PANZA_PAW_BLESSINGFADING, SpellName, Duration), "WHISPER", PANZA_CHATLANGUAGE, name);
						end

					-- Expired
					else
						if (localplayer) then
							if (PA:CheckMessageLevel("Bless",1)) then
								PA:Message4(format(PANZA_PAW_BLESSINGEXPIRED,SpellName));
							end
						else
							SendChatMessage(format(PANZA_PAW_BLESSINGEXPIRED, SpellName), "WHISPER", PANZA_CHATLANGUAGE, name);
						end
					end
				end
			
				-- Now take a look for a GBo, and end it here.
				if (string.find(SpellInfo.Short,"gbo")) then
					if (PA:SpellInSpellBook(SpellInfo.Short)) then
						if (localplayer) then
							if (PA:CheckMessageLevel("Bless",1)) then
								PA:Message4(format(PANZA_PAW_GB,SpellName, SpellInfo.Short));
							end
						else
							SendChatMessage(format(PANZA_PAW_GB, SpellName, SpellInfo.Short),  "WHISPER", PANZA_CHATLANGUAGE, name);
						end
					else
						if (PA:CheckMessageLevel("Core",1)) then
							PA:Message4("Spell lookup on request was nil. Response not sent.");
						end
					end
					return false;
				end	
			end	
		
		----------------------------------------------------------------------------------------------
		-- Otherwise if we are disabled, and have feedback enabled, tell the player what we are doing.
		----------------------------------------------------------------------------------------------
		elseif (PASettings.Switches.Whisper.enabled == false ) then
			if ( PASettings.Switches.Whisper.feedback == true ) then

				--------------------------------------------------------
				-- If WC is installed and queueing is enabled, don't NAK
				--------------------------------------------------------
				if (WhisperCast_Version and
					WhisperCast_Profile and
					WhisperCast_Profile.enable and
					WhisperCast_Profile.enable == 1 ) then
					return false;
				end

				if (localplayer) then
					if (PA:CheckMessageLevel("Bless",1)) then
						PA:Message4(format(PANZA_PAW_SPELLDISABLED, LongSpell));
					end
				else
					SendChatMessage(format(PANZA_PAW_SPELLDISABLED, LongSpell), "WHISPER", PANZA_CHATLANGUAGE, name);
				end

            else
				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("(PAW) Responses Disabled. Skipped Spell Disabled Response.");
				end
			end


			if (PA:CheckMessageLevel("Core",5)) then
				PA:Message4(PANZA_PAW_DISABLED);
			end
			return false;
		end

		-----------------------------------------------------------------------------------
        	-- See if this spell is already saved, overwrite a exiting spell, or save a new one
		-----------------------------------------------------------------------------------

		---------------------------------------
		-- Check for an existing saved Blessing
		----------------------------------------
		if (PASettings.BlessList[name]~=nil and PASettings.BlessList[name].Spell~=nil) then
			if (PA:CheckMessageLevel("Core",5)) then
				PA:Message4("(PAW) "..name.." requested "..LongSpell.." with "..trigger..".");
			end
			if (PA:CheckMessageLevel("Core",5)) then
				PA:Message4("(PAW) Existing spell:"..PA.SpellBook[PASettings.BlessList[name].Spell].Name);
			end

			--------------------------------------------------------------
			-- if its the same spell, tell the player we are already setup
			--------------------------------------------------------------
			if (PASettings.BlessList[name].Spell==shortspell) then
				if (PASettings.Switches.Whisper.feedback == true and PASettings.Switches.Whisper.enabled==true) then

					-- Its not active now, but we know about it.
					if (localplayer) then
						if (PA:CheckMessageLevel("Bless",1)) then
							PA:Message4(format(PANZA_PAW_DUP, LongSpell));
						end
					else
						SendChatMessage(format(PANZA_PAW_DUP, LongSpell), "WHISPER", PANZA_CHATLANGUAGE, name);
					end
				else
					if (PA:CheckMessageLevel("Core",5)) then
						PA:Message4("(PAW) Responses disabled. No Duplicate Setup response.");
					end
				end

			---------------------------------------------------------------
			-- Otherwise setup a new entry in the list if we have the spell
			---------------------------------------------------------------
			elseif (PASettings.Switches.Whisper.enabled==true) then
				if (PASettings.Switches.Whisper.feedback == true) then
					if (localplayer) then
						if (PA:CheckMessageLevel("Bless",1)) then
							PA:Message4(format(PANZA_PAW_SAVED, LongSpell));
						end
					else
						SendChatMessage(format(PANZA_PAW_SAVED, LongSpell), "WHISPER", PANZA_CHATLANGUAGE, name);
					end
				else
					if (PA:CheckMessageLevel("Core",5)) then
						PA:Message4("(PAW) Responses Disabled. No Setup OK Response.");
					end
				end

				-----------------
				-- Save the entry
				-----------------
				
				---------------------------------------------------------
				-- Create a new entry if it does not exist for the player
				---------------------------------------------------------
				if (PASettings.BlessList[name]==nil) then
					PASettings.BlessList[name] = {};
				end
				-----------------------------------------------------------------
				-- If it wasn't created, this will modify the spell entry anyway.
				-----------------------------------------------------------------
				PASettings.BlessList[name].Spell = shortspell;
				if (unit~=nil) then
					local ClassLoc, Class = UnitClass(unit);
					PASettings.BlessList[name].ClassLoc = ClassLoc;
					PASettings.BlessList[name].Class = Class;
				end
				if (PA:CheckMessageLevel("Bless", 1)) then
					PA:Message4("Saving "..LongSpell.." to Blessing List for "..name..".");
				end

			end

		----------------------------------
		-- Otherwise this is a New Request
		----------------------------------
		elseif (PASettings.Switches.Whisper.enabled==true) then
			if (PA:CheckMessageLevel("Core",5)) then
				PA:Message4("(PAW) "..name.." requested "..LongSpell.."with "..trigger..".");
			end
			if (PASettings.Switches.Whisper.feedback == true) then
				if (localplayer) then
					if (PA:CheckMessageLevel("Bless",1)) then
						PA:Message4(format(PANZA_PAW_SAVED, LongSpell));
					end
				else
					SendChatMessage(format(PANZA_PAW_SAVED, LongSpell), "WHISPER", PANZA_CHATLANGUAGE, name);
				end
			else
				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("(PAW) Responses Disabled. Skipped New Setup Response.");
				end
			end

			-----------------
			-- Save the entry
			-----------------
			---------------------------------------------------------
			-- Create a new entry if it does not exist for the player
			---------------------------------------------------------
			if (PASettings.BlessList[name]==nil) then
				PASettings.BlessList[name] = {};
			end
			-----------------------------------------------------------------
			-- If it wasn't created, this will modify the spell entry anyway.
			-----------------------------------------------------------------
			PASettings.BlessList[name].Spell = shortspell;
			if (unit~=nil) then
				local ClassLoc, Class = UnitClass(unit);
				PASettings.BlessList[name].ClassLoc = ClassLoc;
				PASettings.BlessList[name].Class = Class;
			end
			if (PA:CheckMessageLevel("Bless", 1)) then
				PA:Message4("Saving "..LongSpell.." to Blessing List for "..name..".");
			end
		end

        return true
	end
end
