EROS_SLASH_COMMAND = "/erosconserve";
eros_CastTimer = 0;

function ErosConserve_Command(args)
	local spellToCast, threshold = Eros_ParseArgs(args);
	if(not (spellToCast and threshold)) then message("Check arguments passed to "..EROS_SLASH_COMMAND..". Example: Greater Heal(Rank 4),2000");end
	spellToCast = Eros_TrimOnlyString(spellToCast);
	threshold = Eros_TrimOnlyString(threshold);
  	ErosConserve(spellToCast, threshold);
end

function ErosConserve(spellToCast,threshold) 
	threshold = tonumber(threshold);
	if(not (threshold and spellToCast)) then message("Check arguments passed to "..EROS_SLASH_COMMAND..". Example: Greater Heal(Rank 4),2000");return; end
	local tmpMaxVal = CastingBarFrame.maxValue;
	if(CastingBarFrame.casting)then
		if eros_mc_originalTarget then
			local newTarget = UnitName("target");
			TargetByName(eros_mc_originalTarget);
			if(UnitInParty("target") or UnitInRaid("target") or Eros_AmTargettingSelf()) then
				if ((UnitHealthMax("target") - UnitHealth("target"))  < threshold) then
					eros_CastTimer = GetTime();
					SpellStopCasting();
				end
			end
			if(newTarget) then
				--We have a current target set it back
				TargetByName(newTarget);
			else
				--No one selected so re-clear it
				ClearTarget();
			end
		end
	else
		if Eros_IsValidTarget() then
			local timeDiff = ((GetTime() - eros_CastTimer));
			if(timeDiff > 0.50)then
				eros_mc_originalTarget = UnitName("target");
				CastSpellByName(spellToCast);
			end
		end
	end
end

function Eros_TrimOnlyString(aString)
	if(type(aString)=="number") then return aString;end
	if(aString) then
		return (string.gsub(aString, "^%s*(.-)%s*$", "%1"))
	end
end

function Eros_AmTargettingSelf()
	return (UnitName("target") == UnitName("player"));
end

function Eros_ParseArgs(args)
	local a,b=strfind(args, ",");
 		if a then
 			return strsub(args,1,a-1), strsub(args, b+1);
 		else	
 			return "";
 		end
end

function Eros_IsValidTarget()	
	if UnitExists("target") then
		return ((UnitCanCooperate("player", "target")) or (Eros_AmTargettingSelf()));
	else
		return false;
	end
end

function ErosManaConserve_OnLoad()
	--Do something complex enough to use this ever? Not likely.
end
