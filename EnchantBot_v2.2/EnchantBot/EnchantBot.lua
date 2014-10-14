OnOrOff = 1;

function EnchantBot_OnLoad()

   this:RegisterEvent("CHAT_MSG_WHISPER")
   SlashCmdList["BLAH"] = SlashHandler;
   SLASH_BLAH1 = "/enchantbot";
   SLASH_BLAH2 = "/eb";
   CountIt = 0;

end

function SlashHandler()
   if(OnOrOff == 1) then
      OnOrOff = 0;
      this:UnregisterEvent("CHAT_MSG_WHISPER")
      DEFAULT_CHAT_FRAME:AddMessage("EnchantBot is Off");
   else
      OnOrOff = 1;
      this:RegisterEvent("CHAT_MSG_WHISPER")
      DEFAULT_CHAT_FRAME:AddMessage("EnchantBot is On");
   end
end

function SendChat(user, text)
   SendChatMessage(text, "WHISPER", this.language, user);
end

   

function EnchantBot_OnEvent()

   if(OnOrOff == 0) then --UnregisterEvent does not seem to work.
      return;
   end

   if(event ~= "CHAT_MSG_WHISPER") then
      return;
   else
      user = arg2;

   if(arg1 == "ebhelp") then
      SendChat(user, "EnchantBot: Whisper me \"ebsearch\" followed by a part of the enchant's name (Agility, Weapon, 2H Weap, Resist, Cloak...) to browse. Click the links for the reagents!");
      return;
   end


   local X = 0;
   local tmp2 = strlower(arg1);
   local Y = nil;

   --strip "search " from the string
   local p, n = string.find(tmp2, "ebsearch ");
   if(p == nil and n == nil) then
      local p, n = string.find(tmp2, "ebreagents ");
      if(p == nil and n == nil) then
         return;
      else
         local Z = string.sub(tmp2, n, strlen(tmp2));
         Y = tonumber(Z);
                 
      end
   else
      tmp2 = string.sub(tmp2, n, strlen(tmp2));
      Y = nil;
   end


   

   if(Y == nil) then -- requesting search of description and recipe name

      for i=1, GetNumCrafts()-1 do
         local tmp1;
         local tmp3;

         local craftName, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(i);
         local desc, two, three = GetCraftDescription(i);

         tmp1 = strlower(craftName);

         if(desc ~= nil) then
            tmp3 = strlower(desc);
         end
         local foo = string.find(tmp1,tmp2)

         if(desc ~= nil) then
            local foo2 = string.find(tmp3,tmp2);
         end
         if(foo ~= nil) then
            X = 1;
            CountIt = CountIt + 1;
            if(user == UnitName("player")) then
               if(desc ~= nil) then
                  DEFAULT_CHAT_FRAME:AddMessage("[N°" .. i .. "] " .. GetCraftItemLink(i));
               end
            else
               if(desc ~= nil) then
                  SendChat(user, "[N°" .. i .. "] " .. GetCraftItemLink(i));
               end
            end
         end

      end

      if(X == 1) then
         if(user == UnitName("player")) then
            DEFAULT_CHAT_FRAME:AddMessage("Check the link given for the reagents!");
         else
            SendChat(user,                "Check the link given for the reagents!");
            DEFAULT_CHAT_FRAME:AddMessage("Request on " .. arg1 .. " by " .. user .. ". "..CountIt.." results found."); --DEFAULT_CHAT_FRAME:AddMessage("Request on |cCC0000" .. arg1 .. " by " .. user .. ".|r");
         end
      else
         if(user == UnitName("player")) then
            DEFAULT_CHAT_FRAME:AddMessage("No matches found for that query, try refining your request.");

         else
            SendChat(user, "No matches found for that query, try refining your request. Whisper me ebhelp for help.");
            DEFAULT_CHAT_FRAME:AddMessage("Request on " .. arg1 .. " by " .. user .. ". No result found.");
         end
      end
   CountIt = 0;
   else --requesting ingredients
      local reagents = " ";
      local rtmp = nil;
      local foo = false;
      for m=1, GetCraftNumReagents(Y) do
         local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(Y, m);

         rtmp = reagents .. " " .. reagentCount .. "x " .. GetCraftReagentItemLink(Y,m);
         if(strlen(rtmp) > 255) then
            if(user == UnitName("player")) then
               local craftName, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(Y);
               DEFAULT_CHAT_FRAME:AddMessage(reagents);
            else
               local craftName, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(Y);
               SendChat(user, "Reagents for " .. GetCraftItemLink(Y,m) .. " :");
               SendChat(user, reagents);
            end

            rtmp = "(continued) " .. reagentCount .. "x" .. GetCraftReagentItemLink(Y,m);
            reagents = rtmp;
            foo = true;
         end
         reagents = rtmp;
      end
      local craftName, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(Y);

      if(user == UnitName("player")) then
         DEFAULT_CHAT_FRAME:AddMessage(reagents);
      else
         SendChat(user, "Reagents for " .. GetCraftItemLink(Y,m) .. " :");
         SendChat(user, reagents);
      end
   end
   end -- if(event == "CHAT_MSG_WHISPER")


end

