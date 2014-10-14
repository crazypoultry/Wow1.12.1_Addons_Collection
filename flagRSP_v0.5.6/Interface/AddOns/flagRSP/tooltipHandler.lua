TooltipHandler = {
   skinnableTableBuild = false;
   skinnableTable = {};

   skinnableColours = {};

   guildMembers = {};
   friendEntries = {};
   ignoredList = {};
};


--[[

TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, modifier)

- Reorders and replaces tooltip lines <tooltipLinesLeft/Right> for tooltipModifier <modifier>.

]]--
function TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, modifier, tooltipString, playerID, numLines)
   
   if numLines == nil then 
      numLines = 30;
   end

   --for t = 1, 30 do
      --if tooltipLinesLeft[t] ~= "" then
	 --FlagRSP.printDebug("Left" .. t .. " is: " .. tooltipLinesLeft[t]);
      --end
      --if tooltipLinesRight[t] ~= "" then
	 --FlagRSP.printDebug("Right" .. t .. " is: " .. tooltipLinesRight[t]);
      --end
   --end

   --TooltipHandler.getSkinningSkill()

   --FlagRSP.printDebug("Compiling tooltip");

   --local linesBefore = {};

   if tooltipString == "" or tooltipString == nil then tooltipString = "GameTooltip"; end
   if playerID == "" or playerID == nil then playerID = "mouseover"; end

   --for i=1, numLines do
      --ttRight = getglobal(tooltipString .. "TextRight" .. i);
      --linesBefore[i] = tooltipLinesLeft[i];
      --if tooltipLinesRight[i] ~= nil and tooltipLinesRight[i] ~= "" then
	 --FlagRSP.printDebug("line " .. i .. " left: " .. tooltipLinesLeft[i]);
	 --if ttRight:IsVisible() then
	    --FlagRSP.printDebug("visible line " .. i .. " right: " .. tooltipLinesRight[i]);
	 --else
	    --FlagRSP.printDebug("invisible line " .. i .. " right: " .. tooltipLinesRight[i]);
	 --end
      --end

      --FlagRSP.printDebug("line before: " .. i);
      --FlagRSP.printDebug(linesBefore[i]);
   --end
   
   tt = getglobal(tooltipString);

   local i = 0;
   local j = 0;
   local t = 1;

   while modifier[i] ~= nil do
      t = 1;
      
      --FlagRSP.printDebug(numLines);

      while t <= numLines do
	 
	 --FlagRSP.printDebug("t" .. t);

	 if TooltipHandler.checkCondition(modifier[i].conditionType, modifier[i].conditionValue, modifier[i].conditionValue2, "l", t, tooltipLinesLeft[t], playerID) then
	    j = 0;
	    while modifier[i].modifierType[j] ~= nil do
	       tooltipLinesLeft, tooltipLinesRight = TooltipHandler.modifyLine(modifier[i].modifierType[j], modifier[i].modifierValue[j], t, tooltipLinesLeft, tooltipLinesRight, playerID);
	       j = j + 1;
	    end
	 end
	 t = t + 1;
      end
      i = i + 1;
   end

   tt:ClearLines();
   tt:SetHeight(0);

   local l = 1;
   local r = 1;
   --local ttext;
   for t = 1, 30 do
      ttRight = getglobal(tooltipString .. "TextRight" .. t);
      ttRight:SetText("");
      if tooltipLinesLeft[t] ~= "" then
	 if tooltipLinesRight[t] == nil then
	    tooltipLinesRight[t] = "";
	 end
	 tt:AddDoubleLine(tooltipLinesLeft[t], tooltipLinesRight[t], 1, 1, 1, 1, 1, 1);
	 l = l + 1;
      end
   end

   -- Add MonkeyQuest support because MonkeyQuest does not understand coloured tooltips.
   if MonkeyQuest_SearchQuestListItem ~= nil and (playerID == "target" or playerID == "mouseover") then
      MonkeyQuest_SearchQuestListItem(UnitName(playerID));
   end

   tt:Show();
end


--[[

TooltipHandler.checkCondition(type, value, value2, side, linenum, line)

- checks modifier condition <type, value, value2> for line <side, linenum, line>.

]]--
function TooltipHandler.checkCondition(type, value, value2, side, linenum, line, playerID)
   condition = false;

   if type == "true" then 
      condition = true;
   elseif type == "matchString" then
      if line ~= nil and value ~= "" and line ~= "" then
	 value = TooltipHandler.compileString(value, playerID);
	 value = TooltipHandler.removeColourCode(value);
	 line = TooltipHandler.removeColourCode(line);
	 
	 if value ~= "" then
	    if string.find(string.lower(line), string.lower(value)) ~= nil then 
	       condition = true; 
	    end
	 end
      end
   elseif type == "matchExactString" then
      if line ~= nil and value ~= "" and line ~= "" then
	 value = TooltipHandler.compileString(value, playerID);
	 value = TooltipHandler.removeColourCode(value);
	 line = TooltipHandler.removeColourCode(line);
	 
	 if value ~= "" then
	    if string.lower(line) == string.lower(value) then condition = true; end
	 end
      end
   elseif type == "lineNumber" then
      --FlagRSP.printDebug(type);
      --FlagRSP.printDebug(value);
      
      if string.lower(value) ~= "last" then
	 local vside = string.sub(string.lower(value), 1, 1);
	 local vnum = tonumber(string.sub(string.lower(value), 2));
	 
	 if side == vside and linenum == vnum then
	    condition = true;
	 end
      end
   end   
   
   return condition;
end


--[[

TooltipHandler.modifyLine(type, value, linenum, lines)

- modifies <type, value> for line <linenum> in <lines>.

]]--
function TooltipHandler.modifyLine(type, value, linenum, lines, linesRight, playerID)
   local tline = "";

   --FlagRSP.printDebug("running modifier... " .. type .. ", " .. value .. ", " .. linenum);

   if type == "delete" then
      lines[linenum] = "";
      linesRight[linenum] = "";
   elseif type == "replace" then
      tline = TooltipHandler.compileString(value, playerID);
      if tline ~= "" then lines[linenum] = tline; end
   elseif type == "insertLine" then
      table.insert(lines, linenum, TooltipHandler.compileString(value, playerID));
      table.insert(linesRight, linenum, " ");
   elseif type == "appendLine" then
      table.insert(lines, linenum+1, TooltipHandler.compileString(value, playerID));
      table.insert(linesRight, linenum+1, " ");
   elseif type == "colorLine" then
      lines[linenum] = "|cFF" .. value .. lines[linenum] .. "|r" ;
   end

   return lines, linesRight;
end


--[[

TooltipHandler.compileString(str)

- Replaces all % values or variables in string str.

]]--
function TooltipHandler.compileString(str, playerID, name)
   local compiledString = str;

   if playerID == "" or playerID == nil then playerID = "mouseover"; end
   
   if name == nil then
      name = TooltipHandler.getName(playerID);
   end
   
   --FlagRSP.printDebug("compiling... " .. str .. " for " .. playerID);

   if string.find(compiledString, "%%flagRSPVersion") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPVersion", FlagRSP.VERSION);
   end
   if string.find(compiledString, "%%flagRSPAltLevelEnemy") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPAltLevelEnemy", TooltipHandler.getAlternativeEnemyLevelText(playerID));
   end
   if string.find(compiledString, "%%UnitClass") ~= nil then
      compiledString = string.gsub(compiledString, "%%UnitClass", TooltipHandler.getClass(playerID));
   end
   if string.find(compiledString, "%%UnitRace") ~= nil then
      compiledString = string.gsub(compiledString, "%%UnitRace", TooltipHandler.getRace(playerID));
   end
   if string.find(compiledString, "%%UnitLevel") ~= nil then
      compiledString = string.gsub(compiledString, "%%UnitLevel", TooltipHandler.getLevel(playerID));
   end
   if string.find(compiledString, "%%UnitName") ~= nil then
      compiledString = string.gsub(compiledString, "%%UnitName", name);
   end
   if string.find(compiledString, "%%UnitRank") ~= nil then
      compiledString = string.gsub(compiledString, "%%UnitRank", TooltipHandler.getPVPRank(playerID));
   end
   if string.find(compiledString, "%%UnitTitle") ~= nil then
      compiledString = string.gsub(compiledString, "%%UnitTitle", TooltipHandler.getTitle(name));
   end
   if string.find(compiledString, "%%UnitGuild") ~= nil then
      compiledString = string.gsub(compiledString, "%%UnitGuild", TooltipHandler.getGuild(playerID));
   end
   if string.find(compiledString, "%%flagRSPFriendlistText") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPFriendlistText", TooltipHandler.getFriendlistTooltipText(UnitName(playerID)));
   end
   if string.find(compiledString, "%%flagRSPGuildFriendlistText") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPGuildFriendlistText", TooltipHandler.getFriendlistGuildTooltipText(playerID));
   end
   if string.find(compiledString, "%%flagRSPRPFlag") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPRPFlag", TooltipHandler.getRPTag(UnitName(playerID)));
   end
   if string.find(compiledString, "%%flagRSPPVPRank") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPPVPRank", TooltipHandler.getPVPRank(playerID));
   end
   if string.find(compiledString, "%%flagRSPPetOwnerSubLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPPetOwnerSubLine", TooltipHandler.getMouseoverPetOwnerTooltipSubText());
   end
   if string.find(compiledString, "%%flagRSPPetOwnerLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPPetOwnerLine", TooltipHandler.getMouseoverPetOwnerTooltipText());
   end
   if string.find(compiledString, "%%flagRSPPetOwner") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPPetOwner", TooltipHandler.getMouseoverPetOwner());
   end
   if string.find(compiledString, "%%flagRSPSurname") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPSurname", TooltipHandler.getSurname(name));
   end
   if string.find(compiledString, "%%flagRSPLevelLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPLevelLine", TooltipHandler.getLevelTooltipText(playerID));
   end
   if string.find(compiledString, "%%flagRSPLevel") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPLevel", TooltipHandler.getLevelText(playerID));
   end
   if string.find(compiledString, "%%flagRSPNameLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPNameLine", TooltipHandler.getNameTooltipText(playerID));
   end
   if string.find(compiledString, "%%flagRSPRankLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPRankLine", TooltipHandler.getPVPRankTooltipText(playerID));
   end
   if string.find(compiledString, "%%flagRSPRPLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPRPLine", TooltipHandler.getRPTooltipText(name, playerID));
   end
   if string.find(compiledString, "%%flagRSPTitleLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPTitleLine", TooltipHandler.getTitleTooltipText(playerID));
   end
   if string.find(compiledString, "%%flagRSPGuildLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPGuildLine", TooltipHandler.getGuildTooltipText(playerID));
   end
   if string.find(compiledString, "%%flagRSPCivilianLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPCivilianLine", TooltipHandler.getCivilianLine(playerID));
   end
   if string.find(compiledString, "%%flagRSPSkinnableLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPSkinnableLine", TooltipHandler.getSkinnableLine(playerID));
   end
   if string.find(compiledString, "%%flagRSPCStatus") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPCStatus", TooltipHandler.getCharStatus(name));
   end
   if string.find(compiledString, "%%flagRSPCSText") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPCSText", TooltipHandler.getCharStatusText(name));
   end
   if string.find(compiledString, "%%flagRSPCharStatusLine") ~= nil then
      compiledString = string.gsub(compiledString, "%%flagRSPCharStatusLine", TooltipHandler.getCharStatusTooltipText(name, playerID));
   end
   if string.find(compiledString, "%%FriendlistFriendstateText") ~= nil then
      compiledString = string.gsub(compiledString, "%%FriendlistFriendstateText", Friendlist.getFriendstateText(name));
   end
   if string.find(compiledString, "%%FriendlistFriendstateColour") ~= nil then
      compiledString = string.gsub(compiledString, "%%FriendlistFriendstateColour", Friendlist.getFriendstateColour(name));
   end
      
   return compiledString;
end


--[[

TooltipHandler.getAlternativeEnemyLevelText(playerID)

- Returns alternative level information for enemies.

]]--
function TooltipHandler.getAlternativeEnemyLevelText(playerID)
   local Type, prefix;
   local level;

   if string.sub(playerID,1,5) == "index" then
      local iname = TooltipHandler.getName(playerID);
      level = Friendlist.getLevel(iname);
   else
      level = UnitLevel(playerID);
   end      

   if level ~= nil and level ~= "" and level ~= 0 then
      --FlagRSP.printDebug("level is: " .. level);
      Diff = level - UnitLevel("player");
      
      if string.sub(playerID,1,5) ~= "index" and UnitClassification(playerID) == "elite" then
	 Diff = Diff + 7;
      end
      
      local r,g,b;
      if Diff >= 10 then 
	 r=1; g=0.13; b=0.13; 
      elseif Diff < 10 and Diff >= 5 then
	 r = 1;
	 g = -0.074*Diff+0.87;
	 b = 0.026*Diff-0.13;
      elseif Diff < 5 and Diff >= 0 then
	 r = 1;
	 g = -0.1*Diff+1;
	 b = 0;
      elseif Diff < 0 and Diff >= -2 then
	 r = 0.5*Diff+1;
	 g = 0.25*Diff+1;
	 b = 0;
      elseif Diff < -2 and Diff >= -7 then
	 r = -0.134*Diff-0.268;
	 g = -0.034*Diff+0.432;
	 b = -0.134*Diff-0.268;
      else
	 r=0.67; g=0.67; b=0.67;      
      end
      if level == -1 then r=1; g=0.13; b=0.13; end
      
      prefix = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2);
      
      --DEFAULT_CHAT_FRAME:AddMessage("DEBUG: r: " .. r .. " g: " .. g .. " b: " .. b,1.0, 1.0, 0.0);   
      
      if Diff <= -7 and (Diff > -(UnitLevel("player") + 1)) then Type = prefix .. FlagRSP_Locale_Epuny; end
      if Diff <= -5 and Diff > -7 then Type = prefix .. FlagRSP_Locale_Puny; end
      if Diff < -1 and Diff > -5 then Type = prefix .. FlagRSP_Locale_Weak; end
      if Diff >= -1 and Diff <= 1 then Type = prefix .. FlagRSP_Locale_Equal; end
      if Diff > 1 and Diff < 4 then Type = prefix .. FlagRSP_Locale_Strong; end
      if Diff >= 4 and Diff < 7 then Type = prefix .. FlagRSP_Locale_Vstrong; end
      if Diff >= 7 and Diff < 10 then Type = prefix .. FlagRSP_Locale_Estrong; end
      if Diff >= 10 then Type = prefix .. FlagRSP_Locale_Impossible; end
      if level == -1 then Type = prefix .. FlagRSP_Locale_Impossible; end
      
      if string.sub(playerID,1,5) ~= "index" and UnitClassification(playerID) == "elite" then
	 Type = Type .. FlagRSP_Locale_Elite;
      elseif string.sub(playerID,1,5) ~= "index" and UnitClassification(playerID) == "worldboss" then
	 Type = Type .. FlagRSP_Locale_Boss;
      end
      
      Type = Type .. "|r";

   else
      Type = "";
   end

   return Type;
end


--[[

TooltipHandler.getFriendlistTooltipText(name)

- Returns text for friend/foe entry of Friendlist in tooltip for player name.

]]--
function TooltipHandler.getFriendlistTooltipText(name)
   local friendstateText = "";
   local r,g,b,text,friendstate;
   friendstate = Friendlist.getFriendstate(name);

   if friendstate ~= nil then

      --FlagRSP.printDebug("friendstate is: " .. friendstate);

      text = ""; 
      r,g,b,text = Friendlist.getFriendstateInfo(friendstate);
      
      if text ~= nil and text ~= "" then
	 friendstateText = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2) .. text .. "|r";     
      end
   end

   return friendstateText;
end


--[[

TooltipHandler.getFriendlistGuildTooltipText(playerID)

- Returns text for friend/foe entry of Friendlist in tooltip for guild.

]]--
function TooltipHandler.getFriendlistGuildTooltipText(playerID)
   local friendstateText = "";
   local r,g,b,text,friendstate;

   local a,b, guildname;
   guildname, a, b = GetGuildInfo(playerID);
   
   friendstate = Friendlist.getFriendstate(guildname);

   if friendstate ~= nil then
      r,g,b,text = Friendlist.getFriendstateGuildInfo(friendstate);
      
      friendstateText = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2) .. text .. "|r";     
   end

   return friendstateText;
end


--[[

TooltipHandler.getLevel(playerID)

- Returns level of player.

]]--
function TooltipHandler.getLevel(playerID)
   local Level = "";

   if string.sub(playerID,1,5) == "index" then
      local iname = TooltipHandler.getName(playerID);
      Level = Friendlist.getLevel(iname);
      
   else
      if UnitLevel(playerID) >= 1 then
	 Level = UnitLevel(playerID);
      else
	 Level = "??";
      end
   end
   
   return Level;
end


--[[

TooltipHandler.isPet(playerID)

- Returns true if <playerID> is a pet.

]]--
function TooltipHandler.isPet(playerID)
   local isPet = false;

   if (not UnitIsPlayer(playerID)) and (UnitPlayerControlled(playerID)) then isPet = true; end
   
   return isPet;
end


--[[

TooltipHandler.getPetOwner(tooltipLines)

-- Returns the name of the pet's owner.

]]--
function TooltipHandler.getPetOwner(tooltipLines)
   local ownerName = "";
   --local ownerLine = "";

   for t=1, 30 do
      if tooltipLines[t] ~= nil then
	 --if TooltipHandler.isPet("mouseover") then 
	 --local match, match2, match3 = string.find("Begleiter von Ulsdfsdfsdfdfsdfsfi", "Begleiter von (.+)");  
	 --FlagRSP.printDebug(match .. " " .. match2 .. " " .. match3);
	 --end
	 local i = 0;
	 while FlagRSP_Locale_MinionLine[i] ~= nil do
	    --if tooltipLines[t] ~= "" then
	       --FlagRSP.printDebug("Line: " .. tooltipLines[t] .. ", Minion line: " .. FlagRSP_Locale_MinionLine[i]);
	    --end

	    local s, e, match = string.find(tooltipLines[t], FlagRSP_Locale_MinionLine[i]);

	    --if s ~= nil then
	       --FlagRSP.printDebug("s" .. s);
	    --end
	    --if e ~= nil then
	       --FlagRSP.printDebug("e" .. e);
	    --end
	    --if match ~= nil then
	       --FlagRSP.printDebug("m" .. match);
	    --end
	     
	    if match ~= nil and match ~= "" then 
	       ownerName = match; 
	       --FlagRSP.printDebug("m" .. match);
	       --ownerLine = tooltipLines[t];
	    end
	    i = i + 1;
	 end
      end
   end
   
   return ownerName;
end


--[[

TooltipHandler.getPetOwnerLine(tooltipLines)

-- Returns the line for the pet's owner.

]]--
function TooltipHandler.getPetOwnerLine(tooltipLines)
   --local ownerName = "";
   local ownerLine = "";

   for t=1, 30 do
      if tooltipLines[t] ~= nil then
	 --if TooltipHandler.isPet("mouseover") then 
	 --local match, match2, match3 = string.find("Begleiter von Ulsdfsdfsdfdfsdfsfi", "Begleiter von (.+)");  
	 --FlagRSP.printDebug(match .. " " .. match2 .. " " .. match3);
	 --end
	 local i = 0;
	 while FlagRSP_Locale_MinionLine[i] ~= nil do
	    local s, e, match = string.find(tooltipLines[t], FlagRSP_Locale_MinionLine[i]);
	    if match ~= nil and match ~= "" then 
	       --ownerName = match; 
	       ownerLine = tooltipLines[t];
	    end
	    i = i + 1;
	 end
      end
   end
   
   return ownerLine;
end


--[[

TooltipHandler.getMouseoverPetOwner()

-- Returns the name of the pet's owner.

]]--
function TooltipHandler.getMouseoverPetOwner()
   local Lines = {};
   local ttext;

   --FlagRSP.printDebug("looking for owner");

   --GameTooltip:AddLine("test");

   for t = 1, 30 do
      ttext = getglobal("GameTooltipTextLeft" .. t);
      tline = ttext:GetText();
      if tline == nil then tline = ""; end
      Lines[t] = tline;
      --if tline ~= "" then FlagRSP.printDebug(tline); end
      --if Lines[t] ~= "" then FlagRSP.printDebug(Lines[t]); end
   end   

   --FlagRSP.print(TooltipHandler.getPetOwner(Lines));

   return TooltipHandler.getPetOwner(Lines);
end


--[[

TooltipHandler.getMouseoverPetOwnerLine()

-- Returns the owner's tooltip line of the pet.

]]--
function TooltipHandler.getMouseoverPetOwnerLine()
   local Lines = {};
   local ttext;
   
   --FlagRSP.printDebug("looking for owner");
   
   --GameTooltip:AddLine("test");
   
   for t = 1, 30 do
      ttext = getglobal("GameTooltipTextLeft" .. t);
      tline = ttext:GetText();
      if tline == nil then tline = ""; end
      Lines[t] = tline;
      --if Lines[t] ~= "" then FlagRSP.printDebug(Lines[t]); end
   end   
   
   --FlagRSP.print(TooltipHandler.getPetOwner(Lines));
   
   return TooltipHandler.getPetOwnerLine(Lines);
end


--[[

TooltipHandler.getClass(playerID)

- Returns class of player.

]]--
function TooltipHandler.getClass(playerID)
   local Class = "";
   
   -- capture self-made playerID for Friendlist
   if string.sub(playerID,1,5) == "index" then
      local iname = TooltipHandler.getName(playerID);
      Class = Friendlist.getClass(iname);
   else
      if UnitClass(playerID) ~= nil then
	 Class = UnitClass(playerID);
      end
      if UnitCreatureType(playerID) ~= nil and UnitCreatureType(playerID) ~= "" and not UnitIsPlayer(playerID) and not UnitPlayerControlled(playerID) then
	 Class = UnitCreatureType(playerID);
      end
      if UnitCreatureFamily(playerID) ~= nil and UnitCreatureFamily(playerID) ~= "" then
	 Class = UnitCreatureFamily(playerID);
      end
   end
   
   return Class;
end


--[[

TooltipHandler.getRace(playerID)

- Returns race of player.

]]--
function TooltipHandler.getRace(playerID)
   local Race = "";

   -- capture self-made playerID for Friendlist
   if string.sub(playerID,1,5) == "index" then
      local iname = TooltipHandler.getName(playerID);
      Race = Friendlist.getRace(iname);
   else
      if UnitRace(playerID) ~= nil then
	 Race = UnitRace(playerID);
      end
   end
   
   return Race;
end


--[[

TooltipHandler.getName(playerID)

- Returns name of player.

]]--
function TooltipHandler.getName(playerID)
   local Name = "";

   -- capture self-made playerID for Friendlist
   if string.sub(playerID,1,5) == "index" then
      local index = tonumber(string.sub(playerID,6,string.len(playerID)));
      if index ~= nil then
	 for key,value in friendData[realmName][playerName].FRIEND do
	    if value.index ~= nil and index == value.index then
	       -- we found our entry, key is wanted name
	       Name = key;
	    end
	 end
      end
   else
      if UnitName(playerID) ~= nil then
	 Name = UnitName(playerID);
      end
   end
   
   return Name;
end


--[[

TooltipHandler.getPVPRank(playerID)

- Returns name of player.

]]--
function TooltipHandler.getPVPRank(playerID)
   local Rank = "";

   -- capture self-made playerID for Friendlist
   if string.sub(playerID,1,5) == "index" then
      local iname = TooltipHandler.getName(playerID);
      Rank = Friendlist.getRank(iname);
   else
      if UnitPVPRank(playerID) ~= nil and GetPVPRankInfo(UnitPVPRank(playerID), playerID) ~= nil then
	 Rank = GetPVPRankInfo(UnitPVPRank(playerID), playerID);
	 --FlagRSP.printDebug("flagRSP: DEBUG: Selected Unit's PVP rank is: " .. Rank .. ", rank number is: " .. UnitPVPRank(playerID));
      end
   end
   
   return Rank;
end


--[[

TooltipHandler.getGuild(playerID)

- Returns guild of player.

]]--
function TooltipHandler.getGuild(playerID)
   local guild = "";
   
   -- capture self-made playerID for Friendlist
   if string.sub(playerID,1,5) == "index" then
      local iname = TooltipHandler.getName(playerID);
      guild = Friendlist.getGuild(iname);
   else
      local a,b;
      guild, a, b = GetGuildInfo(playerID);
      
      if guild == nil then guild = ""; end
   end

   return guild;
end


--[[

TooltipHandler.getTitle(name)

- Returns title for player name.

]]--
function TooltipHandler.getTitle(name)
   local title = "";

   --if xTP_CTList2[name] ~= "" and xTP_CTList2[name] ~= nil then
      --title = xTP_CTList2[name];
   if FlagHandler.getFlag("Title", name) ~= "" then
      title = FlagHandler.getFlag("Title", name);
   elseif Friendlist.getTitle(name) ~= nil then
      title = Friendlist.getTitle(name);
   end

   return title;
end


--[[

TooltipHandler.getSkinningSkill()

- Returns skinnung skill for player.

]]--
function TooltipHandler.getSkinningSkill()
   local skill = 0;
   local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType;

   for i=1, GetNumSkillLines() do
      skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);
      if skillName == FlagRSP_Locale_Skinning then
	 --FlagRSP.printDebug("Name: " .. skillName);
	 --FlagRSP.printDebug("Rank: " .. skillRank);
	 --FlagRSP.printDebug("TempPoints: " .. numTempPoints);
	 --FlagRSP.printDebug("Mod: " .. skillModifier);
	 --FlagRSP.printDebug("SkillCostType: " .. skillCostType);

	 skill = skillRank + skillModifier;
      end
   end

   return skill;
end


--[[

TooltipHandler.getSkinningColor(playerID)

- Returns skinnung skill for player.

]]--
function TooltipHandler.getSkinningColor(playerID)
   local r,g,b;
   local level = UnitLevel(playerID);
   local skillReal = TooltipHandler.getSkinningSkill();

   if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].SkinnableFancy then

      --FlagRSP.printDebug("Not doing fancy skinnable line.");

      local foundColour = "";
      
      --FlagRSP.printDebug("Skill: " .. skill);
      --FlagRSP.printDebug("Mod: " .. math.mod(skill,5));
      
      local skill = skillReal - math.mod(skillReal,5);
      
      r = 1; g = 1; b = 1;
      
      --FlagRSP.printDebug("Skill is: " .. skill .. " UnitLevel is: " .. level);
      
      local found = false;
      
      local colours = {};
      colours[0] = "grey";
      colours[1] = "green";
      colours[2] = "yellow";
      colours[3] = "orange";
      
      for i=0, 3 do
	 --FlagRSP.printDebug(TooltipHandler.skinnableTable[colours[i]][skill]);
	 if not found and TooltipHandler.skinnableTable[colours[i]][skill] >= level then
	    foundColour = colours[i];
	    found = true;
	    break;
	 end
      end
      
      --FlagRSP.printDebug("Found: " .. foundColour);
      
      if not found or skillReal == 0 then
	 r = TooltipHandler.skinnableColours["red"].r;
	 g = TooltipHandler.skinnableColours["red"].g;
	 b = TooltipHandler.skinnableColours["red"].b;
      else
	 r = TooltipHandler.skinnableColours[foundColour].r;
	 g = TooltipHandler.skinnableColours[foundColour].g;
	 b = TooltipHandler.skinnableColours[foundColour].b;
      end
   else
      --FlagRSP.printDebug("Doing fancy skinnable line.");

      local lSkill = skillReal - math.mod(skillReal,5);
      local hSkill = skillReal - math.mod(skillReal,5) + 5;

      local quotSkill = (skillReal - lSkill)*0.2;

      --FlagRSP.printDebug("Skill is: " .. skillReal .. ", high skill: " .. hSkill .. ", low skill: " .. lSkill .. ", quot: " .. quotSkill);

      local colours = {};
      colours[1] = "grey";
      colours[2] = "green_a";
      colours[3] = "yellow_a";
      colours[4] = "orange_a";
      colours[5] = "red";

      local colourLevel = {};
      
      for i=1, 4 do
	 colourLevel[i] = TooltipHandler.skinnableTable[colours[i]][lSkill] + (TooltipHandler.skinnableTable[colours[i]][hSkill] - TooltipHandler.skinnableTable[colours[i]][lSkill])*quotSkill;
	 
	 --FlagRSP.printDebug("Colour is: " .. colours[i] .. ", colourLevel: " .. colourLevel[i]);
      end      
      -- red is special.
      colourLevel[5] = TooltipHandler.skinnableTable["orange"][lSkill]+1 + (TooltipHandler.skinnableTable["orange"][hSkill] - TooltipHandler.skinnableTable["orange"][lSkill])*quotSkill;
      --FlagRSP.printDebug("Colour is: red, colourLevel: " .. colourLevel[4]);
      colourLevel[0] = -1;
      colourLevel[6] = 1000;

      -- find the two colours that are interesting for us.
      local lColour, hColour;
      for i=1, 6 do
	 --FlagRSP.printDebug("level is: " .. level);
	 --FlagRSP.printDebug("i: " .. i);
	 --FlagRSP.printDebug("i is: " .. colourLevel[i]);
	 --FlagRSP.printDebug("i-1 is: " .. colourLevel[i-1]);
	 if colourLevel[i] >= level and colourLevel[i-1] < level then
	    lColour = i-1;
	    hColour = i;
	 end
      end

      --FlagRSP.printDebug("lColour is: " .. lColour);
      --FlagRSP.printDebug("hColour is: " .. hColour);

      -- special case: level for lColour is -1. Then  hColour is our colour.
      if colourLevel[lColour] <= -1 then
	 --FlagRSP.printDebug("colour: " .. colours[hColour]);
	 r = TooltipHandler.skinnableColours[colours[hColour]].r;
	 g = TooltipHandler.skinnableColours[colours[hColour]].r;
	 b = TooltipHandler.skinnableColours[colours[hColour]].r;
      elseif colourLevel[hColour] == 1000 then
	 r = TooltipHandler.skinnableColours["red"].r;
	 g = TooltipHandler.skinnableColours["red"].g;
	 b = TooltipHandler.skinnableColours["red"].b;
      else
	 local quotColour = 1/(colourLevel[hColour] - colourLevel[lColour]);

	 local hQuot, lQuot;

	 hQuot = quotColour*(level-colourLevel[lColour]);
	 lQuot = quotColour*(colourLevel[hColour]-level);

	 r = hQuot*TooltipHandler.skinnableColours[colours[hColour]].r + lQuot*TooltipHandler.skinnableColours[colours[lColour]].r;
	 g = hQuot*TooltipHandler.skinnableColours[colours[hColour]].g + lQuot*TooltipHandler.skinnableColours[colours[lColour]].g;
	 b = hQuot*TooltipHandler.skinnableColours[colours[hColour]].b + lQuot*TooltipHandler.skinnableColours[colours[lColour]].b;
	 
      end

      if skillReal == 0 then
	 r = TooltipHandler.skinnableColours["red"].r;
	 g = TooltipHandler.skinnableColours["red"].g;
	 b = TooltipHandler.skinnableColours["red"].b;
      end
   end

   if level == -1 then
      r = TooltipHandler.skinnableColours["red"].r;
      g = TooltipHandler.skinnableColours["red"].g;
      b = TooltipHandler.skinnableColours["red"].b;
   end

   return r,g,b;
end


--[[

TooltipHandler.getRPTag(name)

- Returns rp flag for player name (no colours, just the string).

]]--
function TooltipHandler.getRPTag(name)
   local rptag = "";

   --if xTP_RPList[name] ~= nil then
      --if xTP_RPList[name] >= 1 then
   if FlagHandler.getFlag("RPFlag", name) ~= "" and FlagHandler.getFlag("RPFlag", name) >= 1 then

      if FlagHandler.getFlag("RPFlag", name) == 1 then
	 rptag = FlagRSP_Locale_RP;
      elseif FlagHandler.getFlag("RPFlag", name) == 2 then
	 rptag = FlagRSP_Locale_RP2;
      elseif FlagHandler.getFlag("RPFlag", name) == 3 then
	 rptag = FlagRSP_Locale_RP3;
      elseif FlagHandler.getFlag("RPFlag", name) == 4 then
	 rptag = FlagRSP_Locale_RP4;
      end
   end

   --if xTP_RP2List[name] ~= nil and xTP_RP2List[name] then
   -- rptag = rptag .. "\n" .. FlagRSP_Locale_Unicorn;
   --end
    
   return rptag;
end


--[[

TooltipHandler.getRP2Tag(name)

- Returns rp flag for player name (no colours, just the string).

]]--
function TooltipHandler.getRP2Tag(name)
   local rptag = "";

   if xTP_RP2List[name] ~= nil and xTP_RP2List[name] then
      if UList_Installed and UList[FlagRSP.rName] ~= nil and UList[FlagRSP.rName][name] then
	 rptag = FlagRSP_Locale_UnicornOfficial;
      else
	 rptag = FlagRSP_Locale_UnicornNonOfficial;
      end
   end
    
   return rptag;
end


--[[

TooltipHandler.getLevelTooltipText(playerID)

- Returns text for level line in tooltip depending on levelchange.
- Needed: Other level description for friends.

]]--
function TooltipHandler.getLevelTooltipText(playerID)
   local levelText = "";

   --if string.sub(playerID,1,5) == "index" then
      --local iname = TooltipHandler.getName(playerID);
      --pvpRankText = TooltipHandler.compileString(FlagRSP_Locale_PVPRankLine, playerID);
      --surname = Friendlist.getSurname(iname);
   --else

   local isplayer;
   local iname = TooltipHandler.getName(playerID);

   if string.sub(playerID,1,5) == "index" then
      isplayer = true;
   else
      isplayer = UnitIsPlayer(playerID);
   end

   level = TooltipHandler.getLevel(playerID);

   --FlagRSP.printDebug("level is: " .. level .. ", name: " .. iname);

   if level ~= "" and level ~= 0 then
      if isplayer then
	 --FlagRSP.print("Catchpoint A.");
	 if FlagRSP.getLevelDisp() then
	    --levelText = FlagRSP_Locale_AltLevelPrefix .. TooltipHandler.getAlternativeEnemyLevelText();
	    levelText = FlagRSP_Locale_AltLevelLine .. TooltipHandler.getAlternativeEnemyLevelText(playerID);
	 else
	    levelText = FlagRSP_Locale_TradLevelLine .. TooltipHandler.getLevel(playerID) .. " " .. TooltipHandler.getRace(playerID) .. " " .. TooltipHandler.getClass(playerID);
	    --FlagRSP.printDebug("trad level line.");
	 end
      else
	 --FlagRSP.print("Catchpoint B.");
	 if FlagRSP.getLevelDisp() then
	    --levelText = FlagRSP_Locale_AltLevelPrefix .. TooltipHandler.getAlternativeEnemyLevelText();
	    levelText = FlagRSP_Locale_AltLevelLine .. TooltipHandler.getAlternativeEnemyLevelText(playerID);
	 end
      end
   end
   
   return levelText;
end


--[[

TooltipHandler.getLevelText(playerID)

- Returns text for level line in tooltip depending on levelchange.
- Needed: Other level description for friends.

]]--
function TooltipHandler.getLevelText(playerID)
   local levelText = "";
   --local level = TooltipHandler.getLevel(playerID);

   if FlagRSP.getLevelDisp() then 
      --levelText = FlagRSP_Locale_AltLevelPrefix .. TooltipHandler.getAlternativeEnemyLevelText();
      levelText = FlagRSP_Locale_AltLevelLine .. TooltipHandler.getAlternativeEnemyLevelText(playerID);
   else
      if TooltipHandler.getLevel(playerID) ~= 0 then
	 levelText = FRIENDLIST_LOCALE_LevelLine .. TooltipHandler.getLevel(playerID);
      end      

      --levelText = FlagRSP_Locale_TradLevelPrefix .. UnitLevel(playerID) .. " " .. UnitRace(playerID) .. " " .. UnitClass(playerID);
   end
   
   return levelText;
end


--[[

TooltipHandler.updateFriendEntries()

-- Updates the list of standard friend list entries.

]]--
function TooltipHandler.updateFriendEntries()
   TooltipHandler.friendEntries = nil;
   TooltipHandler.friendEntries = {};

   FlagRSP.printDebug("updating friend list.");   
   for t = 1, GetNumFriends() do
      local fName = GetFriendInfo(t);
   
      TooltipHandler.friendEntries[t] = fName;
   end
end


--[[

TooltipHandler.updateIgnoredList()

-- Updates the list of ignored players.

]]--
function TooltipHandler.updateIgnoredList()
   TooltipHandler.ignoredList = nil;
   TooltipHandler.ignoredList = {};
   
   FlagRSP.printDebug("updating ignored list.");
   for t = 1, GetNumIgnores() do
      local iName = GetIgnoreName(t);

      TooltipHandler.ignoredList[t] = iName;
   end
end


--[[

TooltipHandler.updateGuildMembers()

-- Updates the list of own guild members.

]]--
function TooltipHandler.updateGuildMembers()
   TooltipHandler.guildMembers = nil;
   TooltipHandler.guildMembers = {};
   
   FlagRSP.printDebug("updating guild list.");
   local u = GetNumGuildMembers();
   for t = 1, u do
      local gName = GetGuildRosterInfo(t);
      
      TooltipHandler.guildMembers[t] = gName;
   end
end


--[[

TooltipHandler.playerIsGuildMember(name)

- Checks, if player <name> is a guild member of the user.
- Returns true if so, false if not.

]]--
function TooltipHandler.playerIsGuildMember(name)
   local isMember = false;

   --FlagRSP.printDebug("searching in list of guild members. Number of entries: " .. table.getn(TooltipHandler.guildMembers));
   for i=1, table.getn(TooltipHandler.guildMembers) do
      if TooltipHandler.guildMembers[i] == name then
	 isMember = true;
      end
      --FlagRSP.printDebug("entry #" .. i .. " is: " .. TooltipHandler.guildMembers[i]);
   end

   return isMember;
end


--[[

TooltipHandler.playerIsFriendEntry(name)

- Checks, if player <name> is a guild member of the user.
- Returns true if so, false if not.

]]--
function TooltipHandler.playerIsFriendEntry(name)
   local isFriend = false;

   --FlagRSP.printDebug("searching in list of friends. Number of entries: " .. table.getn(TooltipHandler.friendEntries));
   for i=1, table.getn(TooltipHandler.friendEntries) do
      if TooltipHandler.friendEntries[i] == name then
	 isMember = true;
      end
      --FlagRSP.printDebug("entry #" .. i .. " is: " .. TooltipHandler.friendEntries[i]);
   end

   return isFriend;
end


--[[

TooltipHandler.playerIsIgnored(name)

- Checks, if player <name> is a guild member of the user.
- Returns true if so, false if not.

]]--
function TooltipHandler.playerIsIgnored(name)
   local isIgnored = false;

   --FlagRSP.printDebug("searching in list of ignored players. Number of entries: " .. table.getn(TooltipHandler.ignoredList));
   for i=1, table.getn(TooltipHandler.ignoredList) do
      if TooltipHandler.ignoredList[i] == name then
	 isMember = true;
      end
      --FlagRSP.printDebug("entry #" .. i .. " is: " .. TooltipHandler.ignoredList[i]);
   end

   return isIgnored;
end


--[[

TooltipHandler.playerIsKnown(name)

- Checks, if player name is known to us (self, friends, ignore, guild, Friendlist).
- Returns true if known, false if unknown.

]]--
function TooltipHandler.playerIsKnown(name)
   local isKnown = false;

   --FlagRSP.printDebug("hey: " .. name);

   if name == UnitName("player") then isKnown = true; end
   
   ----FlagRSP.printDebug("Owner's name: " .. );

   if TooltipHandler.playerIsFriendEntry(name) then
      isKnown = true;
   end

   if 1 == 0 then
      for t = 1, GetNumFriends() do
	 local fName = GetFriendInfo(t);
	 if fName == name then 
	    isKnown = true;
	    break; 
	 end
      end
   end

   if TooltipHandler.playerIsIgnored(name) then
      isKnown = true;
   end

   if 1 == 0 then
      for t = 1, GetNumIgnores() do
	 local iName = GetIgnoreName(t);
	 if iName == name then 
	    isKnown = true; 	
	    break; 
	 end
      end
   end

   --FlagRSP.printDebug("is this player known?");

   if TooltipHandler.playerIsGuildMember(name) then
      isKnown = true;
   end

   if 1 == 0 then
      local u = GetNumGuildMembers();
      
      for t = 1, u do
	 local gName = GetGuildRosterInfo(t);
	 if gName == name then 
	    isKnown = true;
	    break; 
	 end
      end
   end
   
   if Friendlist.isFriend(name) then 
      isKnown = true;
   end

   return isKnown;
end


--   -- capture self-made playerID for Friendlist
--   if string.sub(playerID,1,5) == "index" then
--      local iname = TooltipHandler.getName(playerID);
--      surname = Friendlist.getSurname(iname);
--   else


--[[

TooltipHandler.getSurname(name)

- Returns surname for player name.

]]--
function TooltipHandler.getSurname(name)
   local surname = "";
   
   --if xTP_CTList[name] ~= "" and xTP_CTList[name] ~= nil then
      --surname = xTP_CTList[name];
   if FlagHandler.getFlag("Surname", name) ~= "" then
      surname = FlagHandler.getFlag("Surname", name);
   elseif Friendlist.getSurname(name) ~= "" and Friendlist.getSurname(name) ~= nil then
      surname = Friendlist.getSurname(name);
   end
   
   return surname;
end


--[[

TooltipHandler.getCharStatus(name)

- Returns character status for player <name>.

]]--
function TooltipHandler.getCharStatus(name)
   local charstatus = "";

   -- Check to be sure not to get malformed status.
   if flagRSP_CharStatusList[name] == "ooc" or flagRSP_CharStatusList[name] == "ic" or flagRSP_CharStatusList[name] == "ffa-ic" or flagRSP_CharStatusList[name] == "st" then
      charstatus = flagRSP_CharStatusList[name];
   end      

   return charstatus;
end


--[[

TooltipHandler.getNameTooltipText(playerID)

- Returns text for name line in tooltip.

]]--
function TooltipHandler.getNameTooltipText(playerID)
   local nameText = "";
   local prefix;

   --if UnitIsPlayer(playerID) then
   
   local r, g, b = TooltipHandler.getTooltipNameColor(playerID);
   prefix = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2);

   --if UnitReaction(playerID, "player") >= 5 then prefix = "|cFF" .. FlagRSP.getHexString(0*255,2) .. FlagRSP.getHexString(0.75*255,2) .. FlagRSP.getHexString(0*255,2); end
   --if UnitReaction(playerID, "player") < 4 then prefix = "|cFF" .. FlagRSP.getHexString(0.75*255,2) .. FlagRSP.getHexString(0*255,2) .. FlagRSP.getHexString(0*255,2); end
   --if UnitReaction(playerID, "player") == 4 then prefix = "|cFF" .. FlagRSP.getHexString(0.95*255,2) .. FlagRSP.getHexString(0.95*255,2) .. FlagRSP.getHexString(0*255,2); end
   
   local name = UnitName(playerID);

   if UnitIsPlayer(playerID) then
      nameText = prefix .. name .. " " .. TooltipHandler.getSurname(name) .. "|r";
   elseif TooltipHandler.isPet(playerID) then
      nameText = prefix .. name .. "|r";
   else
      nameText = prefix .. name .. "|r";
   end

   if FlagRSP.getNameDisp() then
      if not TooltipHandler.playerIsKnown(name) then
	 if UnitIsPlayer(playerID) then 
	    nameText = prefix .. FlagRSP_Locale_Unknown .. "|r";
	 elseif TooltipHandler.isPet(playerID) then
	    if playerID == "mouseover" then
	       if TooltipHandler.playerIsKnown(TooltipHandler.getMouseoverPetOwner()) then
		  if TooltipHandler.getMouseoverPetOwner() ~= FlagRSP.pName then	       
		     nameText = prefix .. "<" .. TooltipHandler.getMouseoverPetOwnerTooltipText() .. ">|r";
		  end
	       else
		  nameText = prefix .. FlagRSP_Locale_UnknownPet .. "|r";
	       end
	    else
	       nameText = prefix .. FlagRSP_Locale_UnknownPet .. "|r";
	    end
	 end
      end	    
   end
   --end
   
   --nameText = nameText .. "|r";
   
   return nameText;
end


--[[

TooltipHandler.getMouseoverPetOwnerTooltipText()

- Returns text for pet owner line in tooltip.

]]--
function TooltipHandler.getMouseoverPetOwnerTooltipText()
   local ownerline = "";
   local ownerName, origLine;

   --FlagRSP.printDebug("invoked");

   --if xTP_NameChange[UnitName("player")] == 0 or TooltipHandler.playerIsKnown(UnitName("mouseover")) then
   --FlagRSP.printDebug("known");
   if TooltipHandler.getMouseoverPetOwner() ~= "" then
      --FlagRSP.printDebug("owner known");
      --if FlagRSP_Locale_KnownPetOwnerLine ~= nil and FlagRSP_Locale_KnownPetOwnerLine ~= "" then
	 --ownerline = TooltipHandler.compileString(FlagRSP_Locale_KnownPetOwnerLine, "mouseover");
      --else
	 ownerline = TooltipHandler.getMouseoverPetOwnerLine();
      --end
      --FlagRSP.printDebug(ownerLine);
   end
   --end

   --FlagRSP.printDebug("line is" .. ownerline);
   
   return ownerline;
end


--[[

TooltipHandler.getMouseoverPetOwnerTooltipText()

- Returns text for pet owner subline in tooltip.

]]--
function TooltipHandler.getMouseoverPetOwnerTooltipSubText()
   local line = "";

   if not FlagRSP.getNameDisp() or TooltipHandler.playerIsKnown(UnitName("mouseover")) or TooltipHandler.getMouseoverPetOwner() == UnitName("player") then
      line = TooltipHandler.getMouseoverPetOwnerTooltipText();
   end

   --FlagRSP.printDebug("subline is" .. line);

   return line;
end


--[[

TooltipHandler.getPVPRankTooltipText(playerID)

- Returns text for pvp rank text in tooltip.

]]--
function TooltipHandler.getPVPRankTooltipText(playerID)
   local pvpRankText = "";

   -- capture self-made playerID for Friendlist
   if string.sub(playerID,1,5) == "index" then
      --local iname = TooltipHandler.getName(playerID);
      if TooltipHandler.getPVPRank(playerID) ~= "" then
	 pvpRankText = FlagRSP_Locale_PVPRankLine .. TooltipHandler.getPVPRank(playerID);
      end
      --surname = Friendlist.getSurname(iname);
   else
      
      --DEFAULT_CHAT_FRAME:AddMessage(UnitPVPRank("mouseover") .. " " .. GetPVPRankInfo(UnitPVPRank("mouseover")));
      if UnitIsPlayer(playerID) and FlagRSP.getRankDisp() and TooltipHandler.getPVPRank(playerID) ~= "" then
	 pvpRankText = FlagRSP_Locale_PVPRankLine .. TooltipHandler.getPVPRank(playerID);
	 --FlagRSP.printDebug("rank");
      end
   end

   return pvpRankText;
end


--[[

TooltipHandler.getTitleTooltipText()

- Returns text for title line in tooltip.

]]--
function TooltipHandler.getTitleTooltipText(playerID)
   local titleText = "";

   local name = UnitName(playerID);

   if UnitIsPlayer(playerID) and TooltipHandler.getTitle(name) ~= "" then
      titleText = TooltipHandler.getTitle(name);
      --TooltipHandler.compileString(FlagRSP_Locale_TitleLine, playerID, name);
   end
   
   return titleText;
end


--[[

TooltipHandler.getRPTooltipText(name)

- Returns text for rp tag line in tooltip for player name.

]]--
function TooltipHandler.getRPTooltipText(name, playerID)
   local RPTag = "";

   if playerID == nil then
      playerID = "";
   end

   --FlagRSP.printDebug("rp?");

   if ((playerID == "target" or playerID == "mouseover") and (UnitIsPlayer(playerID) or UnitPlayerControlled(playerID))) or (playerID ~= "target" and playerID ~= "mouseover") then
      
      --if xTP_RPList[name] ~= nil then
      if FlagHandler.getFlag("RPFlag", name) ~= "" and FlagHandler.getFlag("RPFlag", name) >= 1 then
	 RPTag = "|cFF" .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0.5*255,2);

	 --FlagRSP.printDebug("rp!");

	 RPTag = RPTag .. TooltipHandler.getRPTag(name);
	 
	 RPTag = RPTag .. "|r";
      end
   end

   return RPTag;
end


--[[

TooltipHandler.getRP2TooltipText(name)

- Returns text for rp tag line in tooltip for player name.

]]--
function TooltipHandler.getRP2TooltipText(name, playerID)
   local RPTag = "";

   if playerID == nil then
      playerID = "";
   end

   if ((playerID == "target" or playerID == "mouseover") and (UnitIsPlayer(playerID) or UnitPlayerControlled(playerID))) or (playerID ~= "target" and playerID ~= "mouseover") then
      
      if xTP_RP2List[name] ~= nil and xTP_RP2List[name] then
	 if UList_Installed and UList[FlagRSP.rName] ~= nil and UList[FlagRSP.rName][name] then
	    --FlagRSP.printDebug("OFF");
	    RPTag = "|cFF" .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0.667*255,2) .. FlagRSP.getHexString(0.1*255,2);
	 else
	    --FlagRSP.printDebug("UNOFF");
	    RPTag = "|cFF" .. FlagRSP.getHexString(0.33*255,2) .. FlagRSP.getHexString(0.33*255,2) .. FlagRSP.getHexString(0.33*255,2);
	 end
	 
	 RPTag = RPTag .. TooltipHandler.getRP2Tag(name);
	 
	 RPTag = RPTag .. "|r";
      end
   end
   
   return RPTag;
end


--[[

TooltipHandler.getCharStatusText(name)

- Returns text for character status for player <name>.

]]--
function TooltipHandler.getCharStatusText(name)
   local charstatus = "";

   if TooltipHandler.getCharStatus(name) ~= "" then
      charstatus = "|cFF" .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0.5*255,2);
	 
	 --DEFAULT_CHAT_FRAME:AddMessage("DEBUG: " .. xTP_RPList[name]);
	 
	 --DEFAULT_CHAT_FRAME:AddMessage(FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0.5*255,2));

      local cstatus = TooltipHandler.getCharStatus(name);
 
      if cstatus == "ooc" then
	 charstatus = charstatus .. FlagRSP_Locale_OOC;
      elseif cstatus == "ic" then
	 charstatus = charstatus .. FlagRSP_Locale_IC;
      elseif cstatus == "ffa-ic" then
	 charstatus = charstatus .. FlagRSP_Locale_FFAIC;
      elseif cstatus == "st" then
         charstatus = charstatus .. FlagRSP_Locale_ST;
      end

      charstatus = charstatus .. "|r";
   end
   
   return charstatus;
end


--[[

TooltipHandler.getCivilianLine(playerID)

- Returns colored civilian line.

]]--
function TooltipHandler.getCivilianLine(playerID)
   local prefix, line;

   prefix = "|cFF" .. FlagRSP.getHexString(0*255,2) .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0*255,2);

   line = prefix .. FlagRSP_Locale_CivilianLine .. "|r";

   return line;
end


--[[

TooltipHandler.getSkinnableLine(playerID)

- Returns colored skinnable line.

]]--
function TooltipHandler.getSkinnableLine(playerID)
   local prefix, line;
   local r,g,b;

   --FlagRSP.printDebug(TooltipHandler.getSkinningSkill());

   r, g, b = TooltipHandler.getSkinningColor(playerID);
   
   prefix = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2);

   line = prefix .. FlagRSP_Locale_SkinnableLine .. "|r";

   return line;
end


--[[

TooltipHandler.getCharStatusTooltipText(name, playerID)

- Returns text for character status for tooltip line for player <name>.

]]--
function TooltipHandler.getCharStatusTooltipText(name, playerID)
   local charstatus = "";

   if ((playerID == "target" or playerID == "mouseover") and (UnitIsPlayer(playerID) or UnitPlayerControlled(playerID))) or (playerID ~= "target" and playerID ~= "mouseover") then
      local cs = TooltipHandler.getCharStatusText(name);
      if cs ~= "" then
	 charstatus = FlagRSP_Locale_CharStatusLine .. cs;
      end
   end

   return charstatus;
end



--[[

TooltipHandler.getGuildTooltipText(playerID)

- Returns text for guild line in tooltip.

]]--
function TooltipHandler.getGuildTooltipText(playerID)
   local guildText = "";
   local guild = TooltipHandler.getGuild(playerID);


   if UnitIsPlayer(playerID) and FlagRSP.getGuildDisp() == 1 and guild ~= "" then
      --FlagRSP.printDebug(guild);
      --FlagRSP.printDebug(FlagRSP_Locale_GuildLine);
      --FlagRSP.printDebug(TooltipHandler.compileString(FlagRSP_Locale_GuildLine, playerID));
      guildText = "<" .. TooltipHandler.getGuild(playerID) .. ">";
   elseif UnitIsPlayer(playerID) and FlagRSP.getGuildDisp() == 0 and guild ~= "" then
      if Friendlist.isFriend(guild) and Friendlist.getType(guild) == "guild" then 
	 guildText = "<" .. TooltipHandler.getGuild(playerID) .. ">";
      end
   end
   
   return guildText;
end


--[[

TooltipHandler.getTooltipBGColor(playerID)

- Returns background color for tooltip.

]]--
function TooltipHandler.getTooltipBGColor(playerID)
   local r, g, b;
   r = 0.1;
   g = 0.1;
   b = 0.1;

   local reaction = UnitReaction(playerID, "player");

   if reaction ~= nil then   
      if not UnitIsPlayer(playerID) and not UnitPlayerControlled(playerID) then
	 if reaction >= 5 then r = 0.1; g = 0.2 b = 0.1; end
	 if reaction < 4 then r = 0.2; g = 0.1; b = 0.1; end
	 if reaction == 4 then r = 0.2; g = 0.2; b = 0.1; end
      elseif UnitIsPVP(playerID) then
	 if reaction >= 5 then r = 0.1; g = 0.2 b = 0.1; end
	 if reaction < 4 and not UnitIsPVP("player") then
	    r = 0.2; g = 0.2; b = 0.1; 
	 elseif reaction < 4 and UnitIsPVP("player") then
	    r = 0.2; g = 0.1; b = 0.1; 
	 end
	 if reaction == 4 then r = 0.2; g = 0.2; b = 0.1; end
      else
	 r = 0.1; g = 0.1; b = 0.2;
      end
   else
      if not UnitIsPlayer(playerID) and not UnitPlayerControlled(playerID) then
	 r = 0.2; g = 0.2; b = 0.1;
      else
	 r = 0.1; g = 0.1; b = 0.2;
      end
   end

   return r, g, b;
end


--[[

TooltipHandler.getTooltipNameColor(playerID)

- Returns text color for tooltip name line.

]]--
function TooltipHandler.getTooltipNameColor(playerID)
   local r,g,b;

   r = 1;
   g = 1;   
   b = 1;

   local reaction = UnitReaction(playerID, "player");
   
   if reaction ~= nil then
      if not UnitIsPlayer(playerID) and not UnitPlayerControlled(playerID) then
	 if reaction >= 5 then r = 0; g = 0.75; b = 0; end
	 if reaction < 4 then r = 0.75; g = 0; b = 0; end
	 if reaction == 4 then r = 0.95; g = 0.95; b = 0; end
      elseif UnitIsPVP(playerID) then
	 if reaction >= 5 then r = 0; g = 0.75 b = 0; end
	 if reaction < 4 and not UnitIsPVP("player") then
	    r = 0.95; g = 0.95; b = 0.1; 
	 elseif reaction < 4 and UnitIsPVP("player") then
	    r = 0.75; g = 0; b = 0; 
	 end
	 if reaction == 4 then r = 0.95; g = 0.95; b = 0; end
      else
	 r = 0.5; g = 0.5; b = 0.95;
      end
   else
      if not UnitIsPlayer(playerID) and not UnitPlayerControlled(playerID) then
	 r = 0.95; g = 0.95; b = 0;
      else
	 r = 0.5; g = 0.5; b = 0.95;
      end
   end
   
   --if UnitReaction(playerID, "player") >= 5 then prefix = "|cFF" .. FlagRSP.getHexString(0*255,2) .. FlagRSP.getHexString(0.75*255,2) .. FlagRSP.getHexString(0*255,2); end
   --if UnitReaction(playerID, "player") < 4 then prefix = "|cFF" .. FlagRSP.getHexString(0.75*255,2) .. FlagRSP.getHexString(0*255,2) .. FlagRSP.getHexString(0*255,2); end
   --if UnitReaction(playerID, "player") == 4 then prefix = "|cFF" .. FlagRSP.getHexString(0.95*255,2) .. FlagRSP.getHexString(0.95*255,2) .. FlagRSP.getHexString(0*255,2); end
   
   return r,g,b;
end


--[[

TooltipHandler.buildSkinnableTable()

- Returns text color for tooltip name line.

]]--
function TooltipHandler.buildSkinnableTable()
   -- build standard table.
   local treshold = {};
   treshold["grey"] = 95;
   treshold["green"] = 45;
   treshold["yellow"] = 20;
   treshold["orange"] = -5;
   local i,d1,d2;

   for colour, t in treshold do
      d1 = 19-t/5;
      d2 = t/5+1;
      TooltipHandler.skinnableTable[colour] = {};
      
      for i=0, 65 do
	 if t>=(i*5) then
	    TooltipHandler.skinnableTable[colour][i*5] = -1;
	 elseif t<(i*5) then
	    if i+d1 <= 40 then
	       if math.mod(((i+d1)*5),10) == 0 then	    
		  TooltipHandler.skinnableTable[colour][i*5] = (i+d1)/2;
	       else
		  TooltipHandler.skinnableTable[colour][i*5] = (i+d1-1)/2;	  	       end
	    else
	       TooltipHandler.skinnableTable[colour][i*5] = i-d2;	  
	    end
	 end
      end
   end
   


   -- build dynamic table.
   TooltipHandler.skinnableTable["green_a"] = {};
   TooltipHandler.skinnableTable["yellow_a"] = {};
   TooltipHandler.skinnableTable["orange_a"] = {};
   for i=0, 65 do 
      TooltipHandler.skinnableTable["green_a"][i*5] = 0.5*(TooltipHandler.skinnableTable["green"][i*5] + TooltipHandler.skinnableTable["grey"][i*5] + 1);
      TooltipHandler.skinnableTable["yellow_a"][i*5] = 0.5*(TooltipHandler.skinnableTable["yellow"][i*5] + TooltipHandler.skinnableTable["green"][i*5] + 1);
      TooltipHandler.skinnableTable["orange_a"][i*5] = 0.5*(TooltipHandler.skinnableTable["orange"][i*5] + TooltipHandler.skinnableTable["yellow"][i*5] + 1);
   end
   
   --[[
   local c,s,cn;
   for i=1, 20 do
      s = math.random(0,65);
      cn = math.random(1,3);

      s=s*5;

      if cn == 1 then c = "green_a";
      elseif cn == 2 then c = "yellow_a";
      elseif cn == 3 then c = "orange_a";
      end

      FlagRSP.print("flagRSP: DEBUG: c: " .. c .. " s: " .. s .. " level: " .. TooltipHandler.skinnableTable[c][s]);
   end
   ]]--

   -- colours.
   TooltipHandler.skinnableColours["grey"]= {};
   TooltipHandler.skinnableColours["green"]= {};
   TooltipHandler.skinnableColours["yellow"]= {};
   TooltipHandler.skinnableColours["orange"]= {};
   TooltipHandler.skinnableColours["green_a"]= {};
   TooltipHandler.skinnableColours["yellow_a"]= {};
   TooltipHandler.skinnableColours["orange_a"]= {};
   TooltipHandler.skinnableColours["red"]= {};

   TooltipHandler.skinnableColours["grey"].r = 0.5;
   TooltipHandler.skinnableColours["grey"].g = 0.5;
   TooltipHandler.skinnableColours["grey"].b = 0.5;

   TooltipHandler.skinnableColours["green"].r = 0.25;
   TooltipHandler.skinnableColours["green"].g = 0.75;
   TooltipHandler.skinnableColours["green"].b = 0.25;

   TooltipHandler.skinnableColours["yellow"].r = 1;
   TooltipHandler.skinnableColours["yellow"].g = 1;
   TooltipHandler.skinnableColours["yellow"].b = 0;

   TooltipHandler.skinnableColours["orange"].r = 1;
   TooltipHandler.skinnableColours["orange"].g = 0.5;
   TooltipHandler.skinnableColours["orange"].b = 0.25;

   TooltipHandler.skinnableColours["green_a"].r = 0.25;
   TooltipHandler.skinnableColours["green_a"].g = 0.75;
   TooltipHandler.skinnableColours["green_a"].b = 0.25;

   TooltipHandler.skinnableColours["yellow_a"].r = 1;
   TooltipHandler.skinnableColours["yellow_a"].g = 1;
   TooltipHandler.skinnableColours["yellow_a"].b = 0;

   TooltipHandler.skinnableColours["orange_a"].r = 1;
   TooltipHandler.skinnableColours["orange_a"].g = 0.5;
   TooltipHandler.skinnableColours["orange_a"].b = 0.25;

   TooltipHandler.skinnableColours["red"].r = 1;
   TooltipHandler.skinnableColours["red"].g = 0;
   TooltipHandler.skinnableColours["red"].b = 0;
end


--[[

TooltipHandler.removeColourCode(s)

-- removes colour codes from string <s>.

]]--
function TooltipHandler.removeColourCode(s)
   --[0-9,a-f][0-9,a-f][0-9,a-f][0-9,a-f][0-9,a-f][0-9,a-f][0-9,a-f][0-9,a-f]
   local sNew = s;

   if sNew ~= nil then
      while string.find(sNew, "|[c,C][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F]") ~= nil do
	 sNew = string.gsub(sNew,"|[c,C][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F][0-9,a-f,A-F]", "");
      end
      while string.find(sNew, "|[r,R]") ~= nil do
	 sNew = string.gsub(sNew,"|[r,R]", "");
      end
   end
   
   return sNew;
end


--[[
function TooltipHandler.test(tooltip)
   tt = getglobal(tooltip);
   
   tt:SetOwner(UIParent, "ANCHOR_NONE");
   tt:SetPoint("TOP", "UIParent", "TOP", 0, -32);
   tt:AddLine("Test" .. GetTime());
   tt:AddLine("Test");
   tt:AddLine("Test");
   tt:Show();
end

function TooltipHandler.test2(tooltip)
   tt = getglobal(tooltip);
   
   tt:ClearLines();
   tt:SetHeight(0);

   tt:AddLine("Test2");
   tt:Show();
end

]]--