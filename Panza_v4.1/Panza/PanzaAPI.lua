--[[
PanzaAPI.lua
Panza API Functions

Version 1.02

bool,unitid=PanzaWill("HEAL"|"CURE"|"BUFF"|"FREE"|"REZ"|"PANIC");
--]]

function PanzaWill(funcid)
	local fcall = "bool,unit=PanzaWill(\"HEAL\"|\"CURE\"|\"BUFF\"|\"FREE\"|\"REZ\"|\"PANIC\")";
	local func, will, unitid, OldMsgLevel = nil, false, nil;

	if (not funcid) then
		if (PA:CheckMessageLevel("Core",1)) then
			PA:Message4("(PanzaAPI) Invalid call to :"..fcall);
		end
		return will, unitid;
	end

	func = string.upper(funcid);

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("(PanzaAPI) Checking for "..func.." action.");
	end
	
	-- Call relevant AutoGroup to determine action, ensure no messages are produced and no spell is cast.
	if (func=="PANIC") then
		OldMsgLevel = PASettings.Switches.MsgLevel.Heal;
		PASettings.Switches.MsgLevel.Heal = nil;
		will, unitid = PA:AutoGroup({Weighting=PA_PanicCheck, Cast=PA_CastDummy}, 0, "Panic", false, "Heal");
		PASettings.Switches.MsgLevel.Heal = OldMsgLevel;		
	elseif (func=="HEAL") then
		OldMsgLevel = PASettings.Switches.MsgLevel.Heal;
		PASettings.Switches.MsgLevel.Heal = nil;
		will, unitid = PA:AutoGroup({Weighting=PA_HealWeighting, Cast=PA_CastDummy}, 0, "Heal", true, "Heal");
		PASettings.Switches.MsgLevel.Heal = OldMsgLevel;
	elseif (func=="CURE") then
		OldMsgLevel = PASettings.Switches.MsgLevel.Cure;
		PASettings.Switches.MsgLevel.Cure = nil;
		will, unitid = PA:AutoGroup({Weighting=PA_CureCheck, Cast=PA_CastDummy}, 0, "Cure", true, "Cure");
		PASettings.Switches.MsgLevel.Cure = OldMsgLevel;
	elseif (func=="BUFF") then
		OldMsgLevel = PASettings.Switches.MsgLevel.Bless;
		PASettings.Switches.MsgLevel.Bless = nil;
		will, unitid = PA:AutoGroup({PreCheck=PA_BuffPreCheck, Weighting=PA_BuffWeighting, Cast=PA_CastDummy}, 0, "Bless", PASettings.Switches.Pets.Bless, "Bless");
		PASettings.Switches.MsgLevel.Bless = OldMsgLevel;
	elseif (func=="FREE") then
		OldMsgLevel = PASettings.Switches.MsgLevel.Bless;
		PASettings.Switches.MsgLevel.Bless = nil;
		will, unitid = PA:AutoGroup({PreCheck=PA_FreePreCheck, Weighting=PA_FreeWeighting, Cast=PA_CastDummy}, 0, "Bless", PASettings.Switches.Pets.Free, "Free");
		PASettings.Switches.MsgLevel.Bless = OldMsgLevel;
	elseif (func=="REZ") then
		OldMsgLevel = PASettings.Switches.MsgLevel.Rez;
		PASettings.Switches.MsgLevel.Rez = nil;
		will, unitid = PA:AutoGroup({PreCheck=PA_ResurrectPreCheck, Weighting=PA_ResurrectWeighting, Cast=PA_CastDummy}, 0, "Rez", false, nil);
		PASettings.Switches.MsgLevel.Rez = OldMsgLevel;
	else
		if (PA:CheckMessageLevel("Core",1)) then
			PA:Message4("(PanzaAPI) "..tostring(func).." invalid for "..fcall);
		end
	end
		
	PA:Debug("PanzaWill() returning "..tostring(will)..","..tostring(unitid));	
	return will, unitid;	
end

function PA_CastDummy()
	return true;
end