BINDING_HEADER_MCPOLYHEADER = "MCPoly";

function isPolyUp(id) 
  local i = 1;
  while (UnitDebuff("raid"..id, i)) do
      if (string.find(UnitDebuff("raid"..id, i), "Polymorph")) or (string.find(UnitDebuff("raid"..id, i), "Polymorph: Pig")) or (string.find(UnitDebuff("raid"..id, i), "Polymorph: Turtle"))then
         return true;
      end
      i = i + 1;
   end
   return false;
end

function doPoly(Pom)
    MCFound = false;
    local PolyTypes = {};
    local i = 1;
    local spellname, rank = GetSpellName(i, "spell");
    for id=1, GetNumRaidMembers()  do
        if  (UnitIsFriend("player", "raid"..id) and UnitIsEnemy("player", "raid"..id)) then
            if  (isPolyUp(id)) then
            	MCFound = true;
            	UIErrorsFrame:AddMessage("MCPoly: Skipping - "..UnitName("raid"..id), 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
            	DEFAULT_CHAT_FRAME:AddMessage("MCPoly: Skipping - "..UnitName("raid"..id));
            elseif (not CheckInteractDistance("raid"..id, 4)) then
            	MCFound = true;
            	UIErrorsFrame:AddMessage("MCPoly: Out of Range - "..UnitName("raid"..id), 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
            	DEFAULT_CHAT_FRAME:AddMessage("MCPoly: Out of Range - "..UnitName("raid"..id));
            else
            	DEFAULT_CHAT_FRAME:AddMessage("MCPoly: Polymorphing - "..UnitName("raid"..id));
                MCFound = true;            
                if (Pom) then
                  CastSpellByName("Presence of Mind");		
   	        end						
                TargetUnit("raid"..id);


		while spellname do
			if ( string.find(spellname, "Polymorph") ) then
				local match = false;
				for j = 1, table.getn(PolyTypes), 1 do
					if ( PolyTypes[j] == spellname ) then
						match = true;
					end
				end
				if ( not match ) then
					table.insert(PolyTypes, spellname);
				end
			end
			i = i + 1;
			spellname, rank = GetSpellName(i, "spell");
		end
		if ( table.getn(PolyTypes) > 0 ) then
			local rand = math.random(1, table.getn(PolyTypes));
			SpellStopCasting();
			CastSpellByName(PolyTypes[rand]);
		else
			RandomPoly_PrintMessage("No polymorph spells found.");
		end
		
                TargetLastTarget();
                break;
           end
        end
    end
    
    if (not MCFound) then
    	DEFAULT_CHAT_FRAME:AddMessage("MCPoly: No Mind-Control found");
  	end
  	
end

