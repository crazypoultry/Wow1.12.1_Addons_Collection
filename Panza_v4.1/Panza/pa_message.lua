--[[

pa_message.lua
Panza General Message Functions
Revision 4.0

--]]


--------------------------
-- Colors used in messages
--------------------------
PA_BLUE 			= "|cff6666ff";
PA_GREY 			= "|cff999999";
PA_GREN				= "|cff66cc33";
PA_RED				= "|cffff2020";
PA_YEL				= "|cffffff40";
PA_BGREY			= "|c00D0D0D0";
PA_WHITE			= "|c00FFFFFF";
PA_ORANGE			= "|cffff9930";

local LevelColor = {
		[1] = PA_GREN,
		[2] = PA_GREN,
		[3] = PA_YEL,
		[4] = PA_YEL,
		[5] = PA_WHITE
		};

-- Anti-spam messages we check
local MessageFilter = {
		PANZA_MSG_HEAL_NO,
		PANZA_MSG_CURE_NO,
		PANZA_MSG_FREE_NO,
		};

-----------------
-- send a Message
-----------------
function PA:Chat(msg, channel)
	SendChatMessage(msg, channel, nil, nil);
end

----------------------------------------------------------------------------------------
-- This function will print a Message to the GUI screen (not the chat window) then fade.
----------------------------------------------------------------------------------------
function PA:Error( msg, color, size, holdtime )
	if (holdtime==nil) then
		holdtime = UIERRORS_HOLD_TIME;
	end
	UIErrorsFrame:AddMessage(msg, 0.75, 0.75, 1.0, 1.0, holdtime);
end

----------------------------------------
-- General PA:Chat local Message
-- Uses the configured chat frame
----------------------------------------
function PA:Message(msg)
	if (PA.chatframe~=nil) then
			getglobal("ChatFrame"..PA.chatframe):AddMessage(msg, 1, 1, 0.5);
	else
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 0.5);
		end
	end
end

------------------------------------------------------------
-- General PA:Chat local Message
-- Check if message should be output, before we construct it
------------------------------------------------------------
function PA:CheckMessageLevel(area, level)
	PA.CurrentMessage = {Area=area, Level=level};
	return (_Paladin_is_Ready==true and area~=nil and level~=nil and PASettings~=nil and PASettings.Switches.MsgLevel[area]~=nil and (level==0 or PASettings.Switches.MsgLevel[area]>=level));
end

-----------------------------------------------------------------------
-- General PA:Chat local Message with Level and Area Input (PAM Compliant)
-- Color table for each level message. 0 = error message = red.
-- Now redundant
-----------------------------------------------------------------------
function PA:Message3(area, level, msg)
	if (PA:CheckMessageLevel(area, level)) then
		PA:Message4(msg);
	end
end

-----------------------------------------------------------------------
-- General PA:Chat local Message
-- Color table for each level message. 0 = error message = red.
-- External checks
-----------------------------------------------------------------------
function PA:Message4(msg)
	if (msg~=nil and PA.CurrentMessage~=nil) then
		local Level = PA.CurrentMessage.Level;
		local Area = PA.CurrentMessage.Area;
		if (PASettings.Switches.MsgLevel[Area]>=Level) then
			if (Level >= 1 and Level <= 5) then		-- Normal message, use the color table
				-- Filter Messages here because colors are not in the MessageFilter and will not match
				for __, filter in MessageFilter do
					if (msg==filter) then
						PA.LastMsg[msg] = (PA.LastMsg[msg] or {});
						if (not PA.LastMsg[msg].Seen) then
							PA.LastMsg[msg]["Seen"] = GetTime();
						else
							if (GetTime() <= (PA.LastMsg[msg].Seen + 3)) then
								return;
							else
								PA.LastMsg[msg]["Seen"] = GetTime();
							end
						end
					end
				end
				PA:Message(LevelColor[Level]..msg);
			else
				PA:Message(msg);
			end
		elseif (Level==0) then
			PA:Message(PA_RED..msg);
		end
	end
end

------------------------------------------------------------------
-- Send Message to party or local if not in party
--
-- 1.21 	Addition. New setting to specify if we tell
--		the Raid Group in verbose mode.
-- 1.31 	Transition this function out of use. Obseleted
--		by PA:Notify2. Simplified because MsgType is unknown.
------------------------------------------------------------------
function PA:Notify(msg)
	local channel,echo;

	if (PA:IsInRaid()) then
		channel = "RAID";
	elseif (PA:IsInParty()) then
		channel = "PARTY";
	else
		echo = true;
	end

	if (echo) then
		PA:Message(msg);
	else
		PA:Chat(msg, channel);
	end

end

----------------------------------------------------
-- Send Message to party, Raid, or Say if not in one
----------------------------------------------------
function PA:Notify2(channel, msg)

	if (channel==nil) then
		channel = "SAY"
	end

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("Notify2 channel set to "..channel);
		PA:Message4("Notify2 message="..msg);
	end

	if (PA:IsInRaid() and channel=="RAID") then
		PA:Chat(msg, channel);
	elseif (PA:IsInParty() and channel=="PARTY") then
		PA:Chat(msg, channel);
	elseif (channel=="EMOTE") then
		PA:Chat(msg, channel);
	else
		PA:Chat(msg, "SAY");
	end
end

--------------------------------------------------------------------------------------------------
-- This function will tell the Party or Raid the Message passed no matter what the verbose setting.
-- Currently only the /paladin di function uses this.
-- If not in a Party or Raid, the text will be sent to the default chat window locally.
--------------------------------------------------------------------------------------------------
function PA:ForceNotify(msg)
	local channel, echo;

	echo = false;

	if (PA:IsInRaid()) then
		channel = "RAID";
	elseif (PA:IsInParty()) then
		channel = "PARTY";
	else
		echo = true;
	end

	if (echo) then
		PA:Message(msg);
	else
		PA:Chat(msg, channel);
	end
end

function PA:MultiMessage(text, emoteText, whisperText, flags, unit, spellType, whisperToo)
	local IsSelf = false;
	local IsPlayer = false;
	local InParty = false;
	local InRaid = false;
	local UName = nil;
	local Done = false;
	
	if (unit~="Corpse" and UnitExists(unit)) then
		IsSelf = UnitIsUnit(unit, "player");
		IsPlayer = UnitIsPlayer(unit);
		InParty = UnitInParty(unit);
		InRaid = UnitInRaid(unit);
		UName = PA:UnitName(unit);
	end

	if (PASettings.Switches.MsgLevel[spellType]>=1) then
	
		if (not IsSelf) then
			-----------------------------------------------------------------------------------
			-- If we are informing Users via whisper and its not us and
			-- Not in our party or are but we are not informing party and
			-- Not in our raid or are but we are not informing raid
			-------------------------------------------------------------------------------
			if ( flags.Whisper==true and UName~="target" and IsPlayer and
			     ((not InParty) or (InParty and flags.Party==false)) and
			     ((not InRaid)  or (InRaid  and flags.Raid==false )) ) then
				if (whisperText~=nil) then
					SendChatMessage(whisperText, "WHISPER", PANZA_CHATLANGUAGE, UName);
				else
					SendChatMessage(text, "WHISPER", PANZA_CHATLANGUAGE, UName);
				end
				--if (PA:CheckMessageLevel(spellType, 1)) then
					--PA:Message4(text);
				--end
				if (whisperToo~=true) then
					return
				end
				Done = true;
			end
			------------------------------------------------------------
			-- Check for Emote enabled. It overrides everything
			-- Use emotes for everyone but us
			--------------------------------------------------------------
			if (flags.EM==true) then
				if (emoteText~=nil) then
					PA:Notify2("EMOTE", emoteText);
				else
					PA:Notify2("EMOTE", text);
				end
				return;
			end
			-------------------------------------
			-- Check for Say with same conditions
			-------------------------------------
			if (flags.Say==true) then
				PA:Notify2("SAY", text);
				return;
			end
		end

		--------------------------------
		-- Check if we announce to Party
		--------------------------------
		if (flags.Party==true and PA:IsInParty() and InParty) then
			PA:Notify2('PARTY', text);
			return;
		end

		-------------------------------
		-- Check if we announce to Raid
		-------------------------------
		if (flags.Raid==true and PA:IsInRaid() and InRaid) then
			PA:Notify2('RAID', text);
			return;
		end
	end

	--------------------------------
	-- Otherwise use a local Message
	--------------------------------
	if (not Done) then
		if (PA:CheckMessageLevel(spellType, 1)) then
			PA:Message4(text);
		end
	end
end

------------------------------------
-- Spell Damage message functions
------------------------------------
function PA_DamageHit(spell, target, damage, school)
	local Short = PA.SpellBook.Damage[spell];
	if (Short~=nil and PASettings.Damage[Short]~=nil and PASettings.Damage[Short].Enabled==true and PASettings.Damage[Short].Hit==true) then
		PA:DamageMessage(PASettings.Damage[Short].HitMessage, PASettings.Damage[Short].HitEmote, Short, spell, target, damage, school)
	end
end

function PA_DamageCrit(spell, target, damage, school)
	local Short = PA.SpellBook.Damage[spell];
	if (Short~=nil and PASettings.Damage[Short]~=nil and PASettings.Damage[Short].Enabled==true and PASettings.Damage[Short].Crit==true) then
		PA:DamageMessage(PASettings.Damage[Short].CritMessage, PASettings.Damage[Short].CritEmote, Short, spell, target, damage, school)
	end
end

function PA:DamageMessage(pattern, emotePattern, short, spell, target, damage, school)
	if (pattern~=nil) then
		PA:MultiMessage(format(pattern, PA.PlayerName, spell, target, damage, school), format(emotePattern, SelfName, spell, target, damage, school), nil, PASettings.Damage[short], "target", "Core")
	end
end


local function SetupMarsMessageParser()
	if (MarsMessageParser_RegisterFunction~=nil) then
		MarsMessageParser_RegisterFunction("Panza", SPELLLOGSCHOOLSELFOTHER, PA_DamageHit);
		MarsMessageParser_RegisterFunction("Panza", SPELLLOGCRITSCHOOLSELFOTHER, PA_DamageCrit);
	end
end

SetupMarsMessageParser();

-- Use this for temp debug messages
function PA:ShowText(...)
	if (arg==nil or arg.n==0) then
		return;
	end
	local Message = "";
	for i=1, arg.n do
		Message = Message..tostring(arg[i]);
	end
	PA:Message(Message);
end

-- Use this for real messages instead of ShowText
function PA:DisplayText(...)
	PA:ShowText(unpack(arg));
end

-- Dummy function, overriden by testing framework
function PA:Debug()
end
