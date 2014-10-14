--[[
OPIUM (Opium Personal Identification User Manager)
KoS manager and player info, by Oystein
]]

local OPIUM_STATS_ITEMS_SHOWN = 19;



function OpiumStatsDropDown_OnClick()
   UIDropDownMenu_SetSelectedID(OpiumStatsDropDown, this:GetID());
   OpiumData.config.statsdropdown = this:GetID();
   Opium_BuildStatsDisplayIndices();
   Opium_StatsUpdate();
end

function OpiumStatsDropDown_OnShow()
     if( not OpiumData.config.statsdropdown ) then
        OpiumData.config.statsdropdown = 1;
     end

     UIDropDownMenu_Initialize(this, OpiumStatsDropDown_Initialize);
     UIDropDownMenu_SetSelectedID(this, OpiumData.config.statsdropdown);
     
     UIDropDownMenu_SetWidth(70);
end

function OpiumStatsDropDown_Initialize()
	local info = { };

	info = { };
	info.text = OPIUM_TEXT_STATS_TODAY;
	info.func = OpiumStatsDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	info.text = OPIUM_TEXT_STATS_TOTAL;
	UIDropDownMenu_AddButton(info);  
	
end



function Opium_KillStatsComparison(elem1, elem2)
   return Opium_GenericComparison(elem1[1], elem2[1], elem2[2], elem1[2])
end


function Opium_AccumulateStats(index, value, wins, losses)
	   if( wins ) then

              OpiumTempData.totalkills = OpiumTempData.totalkills + wins;


	      if( value[OPIUM_INDEX_LEVEL] > 0 ) then
                 OpiumTempData.totalpeoplekilled = OpiumTempData.totalpeoplekilled + 1;
                 OpiumTempData.totallevelskilled = OpiumTempData.totallevelskilled + wins 
	                                    * value[OPIUM_INDEX_LEVEL];
	      end


	      if( value[OPIUM_INDEX_GUILD] ) then
   	         if( OpiumTempData.guildTotalKills[value[OPIUM_INDEX_GUILD]] ) then
  	            OpiumTempData.guildTotalKills[value[OPIUM_INDEX_GUILD]] = 
	               OpiumTempData.guildTotalKills[value[OPIUM_INDEX_GUILD]] + wins;
	         else
	            OpiumTempData.guildTotalKills[value[OPIUM_INDEX_GUILD]] = wins;
	         end	         

	      end

	      if( OpiumTempData.classTotalKills[value[OPIUM_INDEX_CLASS]] ) then
                 OpiumTempData.classTotalKills[value[OPIUM_INDEX_CLASS]] = 
		    OpiumTempData.classTotalKills[value[OPIUM_INDEX_CLASS]] + wins;
	      else
                 OpiumTempData.classTotalKills[value[OPIUM_INDEX_CLASS]] =  wins;
	      end

	      if( OpiumTempData.raceTotalKills[value[OPIUM_INDEX_RACE]] ) then
                 OpiumTempData.raceTotalKills[value[OPIUM_INDEX_RACE]] = 
		    OpiumTempData.raceTotalKills[value[OPIUM_INDEX_RACE]] + wins;
	      else
                 OpiumTempData.raceTotalKills[value[OPIUM_INDEX_RACE]] =  wins;
	      end

	      if( OpiumTempData.playerTotalKills[index] ) then
                 OpiumTempData.playerTotalKills[index] = 
		    OpiumTempData.playerTotalKills[index] + wins;
	      else
                 OpiumTempData.playerTotalKills[index] =  wins;
	      end

	   end

	   if( losses ) then

              OpiumTempData.totaldeaths = OpiumTempData.totaldeaths + losses;

	      if( value[OPIUM_INDEX_LEVEL] > 0 ) then
                 OpiumTempData.totalpeopledeaths = OpiumTempData.totalpeopledeaths + 1;
                 OpiumTempData.totallevelsdeaths = OpiumTempData.totallevelsdeaths + losses 
	                                    * value[OPIUM_INDEX_LEVEL];
	      end

              if( value[OPIUM_INDEX_GUILD] ) then
   	         if( OpiumTempData.guildTotalDeaths[value[OPIUM_INDEX_GUILD]] ) then
  	            OpiumTempData.guildTotalDeaths[value[OPIUM_INDEX_GUILD]] = 
	               OpiumTempData.guildTotalDeaths[value[OPIUM_INDEX_GUILD]] + losses;
	         else
	            OpiumTempData.guildTotalDeaths[value[OPIUM_INDEX_GUILD]] = losses;
	         end	         

	      end


	      if( OpiumTempData.classTotalDeaths[value[OPIUM_INDEX_CLASS]] ) then
                 OpiumTempData.classTotalDeaths[value[OPIUM_INDEX_CLASS]] = 
		    OpiumTempData.classTotalDeaths[value[OPIUM_INDEX_CLASS]] + losses;
	      else
                 OpiumTempData.classTotalDeaths[value[OPIUM_INDEX_CLASS]] =  losses;
	      end

	      if( OpiumTempData.raceTotalDeaths[value[OPIUM_INDEX_RACE]] ) then
                 OpiumTempData.raceTotalDeaths[value[OPIUM_INDEX_RACE]] = 
		    OpiumTempData.raceTotalDeaths[value[OPIUM_INDEX_RACE]] + losses;
	      else
                 OpiumTempData.raceTotalDeaths[value[OPIUM_INDEX_RACE]] =  losses;
	      end

	      if( OpiumTempData.playerTotalDeaths[index] ) then
                 OpiumTempData.playerTotalDeaths[index] = 
		    OpiumTempData.playerTotalDeaths[index] + losses;
	      else
                 OpiumTempData.playerTotalDeaths[index] =  losses;
	      end

	   end

end


function Opium_BuildStatsDisplayIndices()
	local iNew = 1;
        local activeList;
        local numarr;
        OpiumTempData.totalkills = 0;
	OpiumTempData.totaldeaths = 0;
	OpiumTempData.totallevelskilled = 0;
        OpiumTempData.totalpeoplekilled = 0;

	OpiumTempData.totallevelsdeaths = 0;
        OpiumTempData.totalpeopledeaths = 0;

	OpiumTempData.guildTotalKills = { };
        OpiumTempData.classTotalKills = { };
        OpiumTempData.raceTotalKills = { };
        OpiumTempData.playerTotalKills = { };

        OpiumTempData.guildTotalDeaths = { };
        OpiumTempData.classTotalDeaths = { };
        OpiumTempData.raceTotalDeaths = { };
        OpiumTempData.playerTotalDeaths = { };

        statsDisplayIndices = { };
        local tmpname;
        
        if( OpiumData.config.statsdropdown == 2 ) then
           for index, value in OpiumData.playerLinks[realmName] do
              Opium_AccumulateStats(index, value, value[OPIUM_INDEX_WINS], value[OPIUM_INDEX_LOSSES]);
           end
	elseif( OpiumData.config.statsdropdown == 1 ) then
           for index, value in OpiumTempData.CombatPlayers do
              tmpname = OpiumData.playerLinks[realmName][string.lower(index)];
	      if( tmpname ) then
	         Opium_AccumulateStats(string.lower(index), tmpname, value.w, value.l);
	      end
	   end
	end

        if( OpiumTempData.totallevelskilled > 0 ) then
           OpiumTempData.totallevelskilled = OpiumTempData.totallevelskilled / OpiumTempData.totalkills;
	else
	   OpiumTempData.totallevelskilled = nil;
	end

        if( OpiumTempData.totallevelsdeaths > 0 ) then
           OpiumTempData.totallevelsdeaths = OpiumTempData.totallevelsdeaths / OpiumTempData.totaldeaths;
	else
	   OpiumTempData.totallevelsdeaths = nil;
	end

        local totalFights = OpiumTempData.totalkills + OpiumTempData.totaldeaths;
	local survivability;
	if( totalFights > 0 ) then
	   survivability = (100/totalFights)*OpiumTempData.totalkills;
	else
	   survivability = 100;
	end

	survivability = string.sub(survivability, 0, 4) .. '%';

	if( OpiumTempData.totallevelskilled and OpiumTempData.totallevelskilled > 0 ) then
	  OpiumTempData.totallevelskilled = string.sub(OpiumTempData.totallevelskilled, 0, 4)
        end

        if( OpiumTempData.totallevelsdeaths and OpiumTempData.totallevelsdeaths > 0 ) then
	   OpiumTempData.totallevelsdeaths = string.sub(OpiumTempData.totallevelsdeaths, 0, 4);
	end

        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOTALKILLS, OpiumTempData.totalkills});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_UNIQUEKILLS, OpiumTempData.totalpeoplekilled});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_AVERAGELEVEL, OpiumTempData.totallevelskilled});
        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOTALDEATHS, OpiumTempData.totaldeaths});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_UNIQUEKILLERS, OpiumTempData.totalpeopledeaths});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_AVERAGELEVEL, OpiumTempData.totallevelsdeaths});

        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_SURVIVABILITY, survivability  });

        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOP10KILLEDPLAYERS, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.playerTotalKills do
           tinsert(numarr, {opiumCapitalizeWords(index), value});
        end

        table.sort(numarr, Opium_KillStatsComparison);

        for z=1, 10, 1 do
	   if( numarr[z] ) then
              tinsert(statsDisplayIndices, numarr[z]);
	   end
	end


        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOP10KILLEDGUILDS, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.guildTotalKills do
           tinsert(numarr, {index, value});
        end

        table.sort(numarr, Opium_KillStatsComparison);

        for z=1, 10, 1 do
	   if( numarr[z] ) then
              tinsert(statsDisplayIndices, numarr[z]);
	   end
	end


        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOPKILLEDCLASSES, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.classTotalKills do
           tinsert(numarr, {index, value});
        end

        table.sort(numarr, Opium_KillStatsComparison);
        for index, value in numarr do
	   tinsert(statsDisplayIndices, {OPIUM_CLASSINDEX[value[1]], value[2]});

        end


        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOPKILLEDRACES, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.raceTotalKills do
           tinsert(numarr, {index, value});
        end

        table.sort(numarr, Opium_KillStatsComparison);
        for index, value in numarr do
	   tinsert(statsDisplayIndices, {OPIUM_RACEINDEX[value[1]], value[2]});

        end


        -------------------------

        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_KILLEDBYPLAYERS, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.playerTotalDeaths do
           tinsert(numarr, {opiumCapitalizeWords(index), value});
        end

        table.sort(numarr, Opium_KillStatsComparison);

        for z=1, 10, 1 do
	   if( numarr[z] ) then
              tinsert(statsDisplayIndices, numarr[z]);
	   end
	end

        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_KILLEDBYGUILDS, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.guildTotalDeaths do
           tinsert(numarr, {index, value});
        end

        table.sort(numarr, Opium_KillStatsComparison);

        for z=1, 10, 1 do
	   if( numarr[z] ) then
              tinsert(statsDisplayIndices, numarr[z]);
	   end
	end


        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOPKILLEDBYCLASSES, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.classTotalDeaths do
           tinsert(numarr, {index, value});
        end

        table.sort(numarr, Opium_KillStatsComparison);
        for index, value in numarr do
	   tinsert(statsDisplayIndices, {OPIUM_CLASSINDEX[value[1]], value[2]});

        end


        tinsert(statsDisplayIndices, {nil, nil});
        tinsert(statsDisplayIndices, {OPIUM_TEXT_STATS_TOPKILLEDBYRACES, ""});
        tinsert(statsDisplayIndices, {"------------------------", nil});

        numarr = { };
        for index, value in OpiumTempData.raceTotalDeaths do
           tinsert(numarr, {index, value});
        end

        table.sort(numarr, Opium_KillStatsComparison);
        for index, value in numarr do
	   tinsert(statsDisplayIndices, {OPIUM_RACEINDEX[value[1]], value[2]});

        end


	statsDisplayIndices.last = getn(statsDisplayIndices);
end



function Opium_StatsUpdate()
   local iItem;
   local activeList;

   if( statsDisplayIndices == nil ) then
      Opium_BuildStatsDisplayIndices();
   end

   if( statsDisplayIndices == nil ) then
      return;
   end


   FauxScrollFrame_Update(OpiumStatsListScrollFrame, statsDisplayIndices.last, 
      OPIUM_STATS_ITEMS_SHOWN, OPIUM_ITEM_HEIGHT);

   

	for iItem = 1, OPIUM_STATS_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(OpiumStatsListScrollFrame);
		local statsItem = getglobal("OpiumStatsItem" .. iItem);
		local statsEntryName = getglobal("OpiumStatsItem" .. iItem .. "Name");
		local statsEntryReason = getglobal("OpiumStatsItem" .. iItem .. "Reason");	

		if( itemIndex <= statsDisplayIndices.last ) then
			local entry;
			entry = statsDisplayIndices[itemIndex];

			statsEntryName:SetText(entry[1]);
                        statsEntryReason:SetText( entry[2]);
			statsEntryName:SetTextColor(1.0, 1.0, 0.0);
                        statsEntryReason:SetTextColor(1.0, 1.0, 1.0);
			
			statsItem:Show();
		else
			statsItem:Hide();
		end
	end
end



function ToggleOpiumStats()
   if( OpiumStatsFrame:IsVisible() ) then
      HideUIPanel(OpiumStatsFrame);
   else
      Opium_BuildStatsDisplayIndices();
      Opium_StatsUpdate();
      ShowUIPanel(OpiumStatsFrame);
   end
end


function Opium_PvPStats(currentPlayer)
   local str = "";

   if( not currentPlayer ) then
      return "";
   end

	if( currentPlayer[OPIUM_INDEX_WINS] or currentPlayer[OPIUM_INDEX_LOSSES] ) then
	   str = "(";

           if( currentPlayer[OPIUM_INDEX_WINS] ) then
	      str = str .. currentPlayer[OPIUM_INDEX_WINS];
	   else
	      str = str .. "0";
	   end

	   str = str .. "/";

           if( currentPlayer[OPIUM_INDEX_LOSSES] ) then
	      str = str .. currentPlayer[OPIUM_INDEX_LOSSES];
	   else
	      str = str .. "0";
	   end

	   str = str .. ")";
	end

	return str;

end




function Opium_RegisterDeath()
   local damager;

   if( OpiumData.config.trackpvpstats and opiumLastDamagerToMe ) then
      damager = OpiumData.playerLinks[realmName][string.lower(opiumLastDamagerToMe)];
   end

   if( OpiumTempData.CombatPlayers[opiumLastDamagerToMe] ) then
      if( OpiumTempData.CombatPlayers[opiumLastDamagerToMe].l == nil) then
         OpiumTempData.CombatPlayers[opiumLastDamagerToMe].l = 1;
      else
         OpiumTempData.CombatPlayers[opiumLastDamagerToMe].l = OpiumTempData.CombatPlayers[opiumLastDamagerToMe].l + 1;
      end
   end


      if( damager ) then
         Opium_PrintMessage(OPIUM_TEXT_STATS_LOGGINGDEATH .. " " .. opiumLastDamagerToMe );
         opiumLastDamagerToMe = nil;

         if( damager[OPIUM_INDEX_LOSSES] == nil ) then
            damager[OPIUM_INDEX_LOSSES] = 1;
         else
            damager[OPIUM_INDEX_LOSSES] = damager[OPIUM_INDEX_LOSSES] + 1;
         end
     
      end



end


function Opium_RegisterKill()
   local killed;

   if( OpiumData.config.trackpvpstats  ) then
      local index = string.find( arg1, opiumDeathString );
      if( not index ) then
         return;
      end

      local found = false;
      local value = string.sub( arg1, 0, index-1 );
      local killed = nil;

      if( value ) then
         table.foreach( opiumDamagedTargets, 
                       function(i, v)
                          if( v == value and found == false) then
			     killed = value;                            
			     return 1;
			  end
                       end);
      end

      if( killed ) then
         
         killedplayer = OpiumData.playerLinks[realmName][string.lower(killed)];
	 if( killedplayer ) then
            Opium_PrintMessage(OPIUM_TEXT_STATS_LOGGINGKILL .. " " .. killed );
  
            if( killedplayer[OPIUM_INDEX_WINS] == nil ) then
               killedplayer[OPIUM_INDEX_WINS] = 1;
            else
               killedplayer[OPIUM_INDEX_WINS] = killedplayer[OPIUM_INDEX_WINS] + 1;
            end
         end

         if( OpiumTempData.CombatPlayers[value] ) then
            if( OpiumTempData.CombatPlayers[value].w == nil) then
               OpiumTempData.CombatPlayers[value].w = 1;
            else
               OpiumTempData.CombatPlayers[value].w = OpiumTempData.CombatPlayers[value].w + 1;
            end
	 end

      end   
   
   end

end



function Opium_ChatFrame_OnEvent()
  -- Some code borrowed from PvPLog

  -- Opium_PrintMessage(event);

  if( not OpiumData.config.trackpvpstats ) then
     return;
  end

  if( event and arg1 ) then
     local s, e, winner, loser = string.find(arg1, opiumDuelString);

     if( winner ) then       
        if( player == winner ) then
           local currentPlayer = OpiumData.playerLinks[realmName][loser];
	   if( currentPlayer == nil ) then
	      return;
	   end

	   currentPlayer[OPIUM_INDEX_WINS] = currentPlayer[OPIUM_INDEX_WINS] + 1;

	elseif( player == loser ) then
           local currentPlayer = OpiumData.playerLinks[realmName][winner];
	   if( currentPlayer == nil ) then
	      return;
	   end

	   currentPlayer[OPIUM_INDEX_LOSSES] = currentPlayer[OPIUM_INDEX_LOSSES] + 1;

	end
	return;
     end
  end


  if( event and arg1 and (strsub(event, 1, 15) == "CHAT_MSG_COMBAT" or strsub(event, 1, 14) == "CHAT_MSG_SPELL") ) then
 
	for index, value in opiumYourDamageMatch do
            local s, e;
            local results = { };
	
               s, e, results[0], results[1], results[2], results[3], results[4] = string.find(arg1, value.pattern);
               if( results[0] ~= nil ) then


                  if( OpiumTempData.CombatPlayers[results[value.mob]] == nil ) then
		     OpiumTempData.CombatPlayers[results[value.mob]] = { };
		  end

                  table.insert( opiumDamagedTargets, results[value.mob] );
		  if( table.getn( opiumDamagedTargets ) > OPIUM_NUMDAMAGED ) then
                     table.remove( opiumDamagedTargets, 1 );
                  end

		  local lcname = string.lower(results[value.mob]);
                  if( OpiumData.config.autostore == OPIUM_AUTOSTORE_COMBAT and
		      OpiumTempData.AllPlayers[lcname] ) then
		      if( not OpiumData.playerLinks[realmName] ) then
		         OpiumData.playerLinks[realmName] = { };
		      end

                      if( not OpiumData.playerLinks[realmName][lcname] ) then
		         OpiumData.playerLinks[realmName][lcname] = OpiumTempData.AllPlayers[lcname];
            
		      end

		      OpiumData.playerLinks[realmName][lcname][OPIUM_INDEX_LASTSEEN] = time() - OPIUM_TIMEOFFSET;
		         
		  end
                  return;

              end
        end

        for index, value in opiumDamageToYouMatch do
           local s, e;
           local results = { };
           s, e, results[0], results[1], results[2], results[3], results[4] = string.find(arg1, value.pattern);
       
           if( results[0] ~= nil ) then

           if( OpiumTempData.CombatPlayers[results[value.cause]] == nil ) then
              OpiumTempData.CombatPlayers[results[value.cause]] = { };
	   end

           opiumLastDamagerToMe = results[value.cause];

	      local lcname = string.lower(results[value.cause]);

              if( OpiumData.config.autostore == OPIUM_AUTOSTORE_COMBAT) then
                  if( OpiumTempData.AllPlayers[lcname] ) then

		      if( not OpiumData.playerLinks[realmName] ) then
		         OpiumData.playerLinks[realmName] = { };
		      end

                      if( not OpiumData.playerLinks[realmName][lcname] ) then
		         OpiumData.playerLinks[realmName][lcname] = OpiumTempData.AllPlayers[lcname];
	              end      

		  end
	      end
	      if( OpiumData.playerLinks[realmName] and OpiumData.playerLinks[realmName][lcname] ) then
  	         OpiumData.playerLinks[realmName][lcname][OPIUM_INDEX_LASTSEEN] = time() - OPIUM_TIMEOFFSET;
	      end
              
	    
	      return;
           end
        end
    
  end
  
end