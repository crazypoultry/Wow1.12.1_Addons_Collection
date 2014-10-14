-- **********************************************************************
--  This code modified adopted as his own by Kerloh on August 14, 2006
--  in the following ways:
--            *The public messages displaying cooldown times for Innervate
--            and Rebirth have been re-written as private system messages
--            for the user.
--            *Parsing for the display of cooldown times on Innervate and
--            Rebirth improved to include the preceeding '0' in single
--            digit seconds (thanks Lain).
--            *Rejuvenation casting code improved to avoid a bug
--            which caused Rank 1 Rejuv to be cast when the command was
--            activated with no target. Now the highest rank of Rejuv the
--            player has is cast.
--            *The "hspell" function has been made defunct, because I
--            consider it weird and inefficient, and I like my code more.
--            *A new command, "/re mallark", has been added! This feature
--            will provide a noob service to noobs like Mallark, who
--            requested its inclusion. "/re mallark" will automatically
--            cast Swiftmend if the player has the spell and the target
--            has the Rejuv buff active. Otherwise it will act the same
--            as "/re reju".
--            *Essentially, it allows a player to hit their macro button
--            twice and either cast and consume a Rejuv with Swiftmend
--            immediately, or consume the buff and then cast it again.
-- **********************************************************************

-- **********************************************************************
--  This code modified and added to by Kerloh on July 3, 2006 in the
--  following ways:
--            *Innervate functionality has been expanded to allow casting
--            when the player has no target. However, no whisper will be
--            sent to the player targeted notifying them of the cast.
--            *Added Rebirth functionality. Type /re rebirth to cast your
--            highest level of the Rebirth spell. Displays a message in
--            the default chat window if the first rank of the spell has
--            not yet been learned.
--            */re rebirth has the following feature:
--                 -It will whisper a pre-chosen target when the spell
--                 begins casting.
--                 -It will not whisper a living target or an out-of-range
--                 target.
--                 -Will not whisper if Rebirth cooldown is still present,
--                 instead will "SAY" the Rebirth cooldown in the
--                 MINUTES:SECONDS format.
--                 -If the player has no target, the spell will still cast
--                 but the receiving target will not be whispered.
--
-- **********************************************************************

-- **********************************************************************
--  This code modified and added to by Kerloh on June 30, 2006 to improve
--  Innervate functionality in the following ways:
--            *Whispers target that is innervated.
--            *Will not whisper dead or out of range targets
--            *Will not whisper if Innervate cooldown is still present,
--            instead will "SAY" the Innervate cooldown in the
--            MINUTES:SECONDS format.
--            *Currently you must have a target selected to cast.
-- **********************************************************************

-- **********************************************************************
--  This code modified and added to by Kerloh on June 24, 2006 to include
--  Innervate functionality
--            *In game, type or make a macro of /re innerv to cast.
--            *Using this command will prevent innervate stacking.
-- **********************************************************************

---------------------------------
--  Mod loaded
---------------------------------
function Re_OnLoad()
  	out(RE_TITLE .. RE_LOADED);
  	SLASH_RE1 = "/re";
  	SlashCmdList["RE"] = function(msg)
		Re_SlashCommandHandler(msg);
	end
--~ 	Player = (UnitName("player").." of "..GetCVar("realmName"))
	
--~ 	--Create user table if it doesnt exist (not used in this release
--~ 	if (Rejuvenation_Config == nil) then
--~ 		Rejuvenation_Config = {};
--~ 	end
--~ 	if (Rejuvenation_Config[Player] == nil) then
--~ 		Rejuvenation_reset();
--~ 	end
	-- Register the game events
	this:RegisterEvent("ADDON_LOADED");		-- Our saved variable.
	this:RegisterEvent("PLAYER_ENTERING_WORLD");		
end


------------------
-- Reset Variables not used in this release
------------------
--~ function Rejuvenation_reset()

--~         Rejuvenation_Config[Player] = {
--~ 			["Verbose"] = "ON";
--~ 	}

--~ 	
--~ end
----------------------------------
-- Output function
----------------------------------
function out(text, r, g, b)
	if (r ~= "" and g ~= "" and b ~= "") then
		DEFAULT_CHAT_FRAME:AddMessage(text, r, g, b);
	else
		DEFAULT_CHAT_FRAME:AddMessage(text);
	end
end
----------------------------------
-- Parse out option from / Command
----------------------------------
function Re_SlashCommandHandler(msg)
	if msg == "rejuv" then
		setRejuv();
	else
		if msg == "faerie"  then
			setFaerie();
		else
			if msg == "innerv" then
				setInnerv();
			else
                            if msg == "rebirth" then
				setRebirth();
                            else
                                if msg == "swift" then
                                   setSwiftmend();
                                else
                                    out(RE_NAME .. ": " .. RE_INSTR, 0.4, 0.8, 1.0);
                                end
                            end
                        end
		end
	end
end

----------------------------------
-- Search the highest rank of a spell
-- *Currently defunct
----------------------------------
--[
function hspell(spellMax)
	local i = 1
	local max ="00"
	local appo
        local spellName, spellRank;
	while true do
		spellName, spellRank = GetSpellName(i, "Restoration")
		if not spellName  then
			do break end
                end
		if spellName == spellMax then
			appo = string.sub(spellRank , 6);
			if not (appo=="11" or appo =="10") then
				appo = "0"..appo;
			end
			if appo > max then
 				max=appo;
 			end
		end
		i = i + 1;
	end
 	if not (max =="11" or max =="10") then
 		max = string.sub(max , 2);
 	end
	return max
end
--]
----------------------------------
-- Loops through active buffs looking for a string match
----------------------------------

 function isUnitBuffUp(sUnitname, sBuffname)
   local iIterator = 1
   while (UnitBuff(sUnitname, iIterator)) do
     if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then
       return true
     end
     iIterator = iIterator + 1
   end
   return false
 end

----------------------------------
-- Find Spell ID of entered spell and rank.
-- 'name' is the name of the spell (case sensitive)
-- 'rank' is the spell rank, where spells without rank are given a rank of 1 by default.
----------------------------------

function findSpellID(name, rank)
    if rank == nil then
       rank = 1;
    end
    for i=1, 250, 1 do
        if GetSpellName(i, "spell") == name then
           --out(GetSpellName((i + rank - 1), "spell"));
           if GetSpellName((i + rank - 1), "spell") == name then
              --out("Returning spellid "..(i+rank-1));
              return i + rank - 1
           else
               break;
           end
        end
    end
    return nil
end

----------------------------------
-- Spell Queries
----------------------------------
 local qryFaerie = "Spell_Nature_FaerieFire"
 local qryRejuv = "Spell_Nature_Rejuvenation"
 local qryInnerv = "Spell_Nature_Lightning"

 ----------------------------------
-- Check if the target has Faerie up
----------------------------------
function isFaerie()
   if UnitIsFriend("player","target") then return false end
  return isTargetDebuffUp(qryFaerie)
end


----------------------------------
-- Loops through active debuffs looking for a string match
----------------------------------
function isUnitDebuffUp(sUnitname, sDebuffname) 
  local iIterator = 1
  while (UnitDebuff(sUnitname, iIterator)) do
    if (string.find(UnitDebuff(sUnitname, iIterator), sDebuffname)) then
      return true
    end
    iIterator = iIterator + 1
  end
  return false
end
----------------------------------
-- Check if the target is debuffed
----------------------------------
function isTargetDebuffUp(sDebuffname)
  if not sDebuffname then dbg("isTargetDebuffUp:sBuffname empty")return false end
  return isUnitDebuffUp("target", sDebuffname)
end
----------------------------------
-- Check if a player is buffed
----------------------------------
function isPlayerBuffUp(sBuffname)
  return isUnitBuffUp("Target", sBuffname)
end

----------------------------------
-- Check if a player has FERAL Faerie Fire
----------------------------------
function castFeralFaerieFire()
         local spellid = 0;
         local iconBear, nameBear, activeBear = GetShapeshiftFormInfo( 1 );
         local iconCat, nameCat, activeCat = GetShapeshiftFormInfo( 3 );
         if activeBear == 1 or activeCat == 1 then
           for i=1, 4, 1 do
               -- Debug
               --out("Rank: "..i.." test");
               local id = findSpellID("Faerie Fire(Feral)", i);
               --out("Spellid returned as: "..id);
               if id ~= nil then
                  --out("Spellid variable updated.");
                  spellid = id;
               else
                   break;
               end
           end
           CastSpellByName("Faerie Fire(Feral)(Rank"..spellid..")");
         else
             return false;
         end;
         return true;
end;

----------------------------------
-- Cast Faerie Fire
----------------------------------
function setFaerie()
  castFeralFaerieFire()
  if (not isFaerie()) then
    CastSpellByName("Faerie Fire");
    return true
  else 
    return false
  end
end
----------------------------------
-- Cast Rejuvenation
----------------------------------
function setRejuv()
  if isPlayerBuffUp(qryRejuv) then
	return false
  else
      if not UnitIsFriend("player", "target") then
         CastSpellByName("Rejuvenation");
         return true
      end
        local id, r;
        r = 0;
	for i=1, 11, 1 do
	         --in this place, findSpellID is merely used in counting the number of ranks of Rejuvenation.
               id = findSpellID("Rejuvenation", i);
               if id ~= nil then
                  r = r + 1;
               else
                   break;
               end
        end
	l = {4,10,16,22,28,34,40,46,52,58,60};
 	t = UnitLevel("target");
        --In case of no target (where the level is zero), cast the highest rank.
        if t == 0 then
           out("no target!");
           CastSpellByName("Rejuvenation");
           return true;
 	end
 	for i = r,1,-1 do
 		if (t>=l[i]-10) then
 			CastSpellByName("Rejuvenation(Rank "..i..")");
			break;
		end
 	end
 	return true 
	end
end

----------------------------------
-- Cast Rejuv or cast Swiftmend if Rejuv is already up.
-- Made upon request by that crazy son of a grizzly, Mallark.
----------------------------------
function setSwiftmend()
  if isPlayerBuffUp(qryRejuv) then
	if findSpellID("Swiftmend") then
	   CastSpellByName("Swiftmend");
	   return true
        else
            return false
        end
  else
        local id, r;
        r = 0;
	for i=1, 11, 1 do
	         --in this place, findSpellID is merely used in counting the number of ranks of Rejuvenation.
               id = findSpellID("Rejuvenation", i);
               if id ~= nil then
                  r = r + 1;
               else
                   break;
               end
        end
	l = {4,10,16,22,28,34,40,46,52,58,60};
 	t = UnitLevel("target");
 	--In case of no target (where the level is zero), cast the highest rank.
        if t == 0 then
           CastSpellByName("Rejuvenation(Rank "..r..")");
           return true;
 	end
 	for i = r,1,-1 do
 		if (t>=l[i]-10) then
 			CastSpellByName("Rejuvenation(Rank "..i..")");
			break;
		end
 	end
 	return true
	end
end

----------------------------------
-- Cast Innervate
-- Note: will not whisper if target is not selected before casting.
----------------------------------
function setInnerv()

  local spellid = findSpellID("Innervate");

  local start, duration = GetSpellCooldown( spellid, "spell" );
  if isPlayerBuffUp(qryInnerv) then
     DEFAULT_CHAT_FRAME:AddMessage("Innervate has already been cast on that target.", 1, 1, 0)
     return false
  else
      if (start > 0) and (duration > 0) then
        local cooldown = duration - (GetTime() - start);
         DEFAULT_CHAT_FRAME:AddMessage(string.format("Innervate ready in: %d:%.02d.", math.floor(cooldown/60), math.mod(cooldown, 60)), 1, 1, 0)
         --SendChatMessage("Innervate ready in "..math.floor(cooldown/60)..":"..math.mod(math.floor(cooldown),60)..".", "SAY", (GetDefaultLanguage("player")));
         return false
      else
          if UnitName("target") == nil then
             CastSpellByName("Innervate");
             --while true do
               --    if not SpellIsTargeting() then
                 --     SendChatMessage("**Innervate Incoming**", "Whisper", (GetDefaultLanguage("player")), UnitName("target"));
                   --   break;
                  -- end
             --end
             return true;
          else
              if ( CheckInteractDistance("target", 4) and not UnitIsDead("target") ) then

                 CastSpellByName("Innervate");

                 if GetSpellCooldown( spellid, "spell" ) then
                    SendChatMessage("**Innervate Incoming**", "Whisper", (GetDefaultLanguage("player")), UnitName("target"));
                 end

                 return true
              else
                return false
              end
          end
      end
  end
end

----------------------------------
-- Cast Rebirth
-- Note: will not whisper if target is not selected before casting.
----------------------------------
function setRebirth()

  local spellid;
  -- Find the highest Rebirth Spell ID for the cooldown remaining message.
  if findSpellID("Rebirth") == nil then
     SendChatMessage("You have not yet learned the spell Rebirth.", "Whisper", (GetDefaultLanguage("player")), UnitName("player"));
     return false
  end
  for i=1, 5, 1 do
      local id = findSpellID("Rebirth", i);
      if id ~= nil then
         spellid = id;
      else
          break;
      end
  end

  local start, duration = GetSpellCooldown( spellid, "spell" );

      if (start > 0) and (duration > 0) then
        local cooldown = duration - (GetTime() - start);
         DEFAULT_CHAT_FRAME:AddMessage(string.format("Rebirth ready in: %d:%.02d.", math.floor(cooldown/60), math.mod(cooldown, 60)), 1, 1, 0)
         --SendChatMessage("Rebirth ready in "..math.floor(cooldown/60)..":"..math.mod(math.floor(cooldown),60)..".", "SAY", (GetDefaultLanguage("player")));
         return false
      else
          if UnitName("target") == nil then
             CastSpellByName("Rebirth");
             --while true do
               --    if not SpellIsTargeting() then
                 --     SendChatMessage("**Innervate Incoming**", "Whisper", (GetDefaultLanguage("player")), UnitName("target"));
                   --   break;
                 -- end
             --end
             return true;
          else
              if ( CheckInteractDistance("target", 4) and UnitIsDead("target") ) then
                 SendChatMessage("**Combat Rez Incoming**", "Whisper", (GetDefaultLanguage("player")), UnitName("target"));
                 CastSpellByName("Rebirth");
                 return true
              else
                return false
              end
          end
      end
end

----------------------------------
-- Find the queries name of buff and debuff
----------------------------------
-- debug
  function showAllUnitBuffs(sUnitname)
   local iIterator = 1
   DEFAULT_CHAT_FRAME:AddMessage(format("[%s] Buffs", sUnitname))
   while (UnitBuff(sUnitname, iIterator)) do
     DEFAULT_CHAT_FRAME:AddMessage(UnitBuff(sUnitname, iIterator), 1, 1, 0)
     iIterator = iIterator + 1
   end
   DEFAULT_CHAT_FRAME:AddMessage("---", 1, 1, 0)
 end

 function showAllUnitDebuffs(sUnitname)
   local iIterator = 1
   DEFAULT_CHAT_FRAME:AddMessage(string.format("%s", "Debuff"), 1, 1, 0)
   while (UnitDebuff(sUnitname, iIterator)) do
     DEFAULT_CHAT_FRAME:AddMessage(format(UnitDebuff("target", iIterator)), 1, 1, 0)
     iIterator = iIterator + 1
     DEFAULT_CHAT_FRAME:AddMessage("---", 1, 1, 0)
   end
 end

