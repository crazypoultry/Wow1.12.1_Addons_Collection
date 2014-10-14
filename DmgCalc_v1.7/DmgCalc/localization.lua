--Constant
DMGCALC        					= "DmgCalc";
DMGCALC_VERSION					= "v1.7";
DMGCALC_COMMAND_SHORT   = "dc";
DMGCALC_COMMAND 			  = "dmgcalc";

DMGCALC_COLOR_MAIN      = "|cff0088BB"
DMGCALC_COLOR_DEBUG     = "|cff00FF00"
DMGCALC_COLOR_ERR       = "|cffFF0000"
DMGCALC_COLOR_TEXT		  = "|cff888888"
DMGCALC_COLOR_TITLE     = "|cff00FF00"

if ( GetLocale() == "enUS" ) then
	--Commands
	DMGCALC_COMMAND_RESET		= "reset";
	
	DMGCALC_PARSING_WORD_HEALING  = "healing"
	DMGCALC_PARSING_WORD_DAMAGE   = "damage"
	DMGCALC_PARSING_WORD_EQUIP    = "equip"
	DMGCALC_PARSING_WORD_SET			= "set"
	DMGCALC_PARSING_WORD_USE		  = "use"
	DMGCALC_PARSING_WORD_ON       = " "
  DMGCALC_PROMPT_EQUIP          = "Equip:"			
  DMGCALC_PROMPT_USE            = "Use:"
	
	
	DMGCALC_SUBPROMPT = DMGCALC .. ">|r "
	DMGCALC_PROMPT    = DMGCALC_COLOR_MAIN .. DMGCALC_SUBPROMPT
	
	DMGCALC_WELCOME = DMGCALC_PROMPT .. DMGCALC_VERSION .. " Loaded, type /" .. 
	                  DMGCALC_COMMAND .. " or /" .. DMGCALC_COMMAND_SHORT .. " for usage"
	                    
	DMGCALC_HELP = { DMGCALC_PROMPT .. " " .. DMGCALC_VERSION,
	                 "  " .. DMGCALC_COMMAND_RESET .. " - Reset all default values."
	                 };
	
	DMGCALC_PARSING_KEY_ARCANE    = "arcane"
	DMGCALC_PARSING_KEY_FIRE		  = "fire"
	DMGCALC_PARSING_KEY_NATURE    = "nature"
	DMGCALC_PARSING_KEY_FROST     = "frost"
	DMGCALC_PARSING_KEY_SHADOW    = "shadow"
	DMGCALC_PARSING_KEY_MAGICAL   = "magical"
	DMGCALC_PARSING_KEY_CRITICAL  = "critical"
	DMGCALC_PARSING_KEY_HEALING   = "healing"
	DMGCALC_PARSING_KEY_HIT       = "hit"
  DMGCALC_PARSING_KEY_MANAREGEN = "manaregen"
	                         
	DMGCALC_PARSING_DMG      = "(.+): increases (.+) done by (.*)spells and effects by up to (%d+)";
	DMGCALC_PARSING_CRITS    = "(.+): improves your chance to get a critical strike with spells by (%d+)%%";
	DMGCALC_PARSING_HITS     = "(.+): improves your chance to hit with spells by (%d+)%%";
	DMGCALC_PARSING_HITENCH  = "spell hit %+(%d+)%%";
	DMGCALC_PARSING_SETS     = "(.+) %(%d%/%d%)$"
	DMGCALC_PARSING_DMGENCH  = "spell damage %+(%d+)"
	DMGCALC_PARSING_DMGENCH2 = "(.+) damage %+(%d+)"
	DMGCALC_PARSING_OTHERDMG = "%+(%d+) (.+) spell damage"
  DMGCALC_PARSING_MANAREGEN  = "(.+): restores (%d+) mana per (%d+) sec"    -- Still need FR and DE
  DMGCALC_PARSING_MANAREGEN2 = "(.+): mana regen (%d+) per (%d+) sec."      -- Still need FR and DE
  DMGCALC_PARSING_MANAREGEN3 = "mana regen (%d+) per (%d+) sec."            -- Still need FR and DE
	-- A verifier :
	DMGCALC_PARSING_HEALENCH   = "healing spells %+(%d+)"
	DMGCALC_PARSING_OTHERHEAL  = "%+(%d+) healing spells"
  DMGCALC_PARSING_DMGANDHEAL = "%+(%d+) damage and healing spells"	        -- Still need FR and DE
  DMGCALC_PARSING_DMGHEALENCH = "%+(%d+) spell damage and healing"
	
	DMGCALC_TOOLTIPS_TITLE   = { "Arcane Damage",
	                             "Fire Damage",
	                             "Nature Damage",
	                             "Frost Damage",
	                             "Shadow Damage",
	                             "Crits",
	                             "Healing",
	                             "Spell hit",
                               "Mana by 5 sec."                    	       -- Still need FR and DE
	                           };
	
	-- option labels, tooltips and variables
	DmgCalcToolTips = {
		DmgCalcFrame = { title=DMGCALC_COLOR_MAIN .. DMGCALC .. " " .. DMGCALC_VERSION , text=DMGCALC_COLOR_MAIN .. "by Kurtzo.Medivh <Ascent>|r\n" }
	}

	function DmgCalc_LocalizationParse(aText,aInventoryID)
	
    local dmgAlreadyProcessed = false;

	  for mode,critsPct in string.gfind(string.lower(aText),DMGCALC_PARSING_CRITS) do
	    if mode ~= nil and critsPct ~= nil then
        DmgCalc.DebugVars("Crits:",mode,critsPct);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_CRITICAL,mode,critsPct);
	    end
	  end
	
	  for mode,what,dmgClass,dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMG) do
	    if dmgClass ~= nil and what ~= nil and mode ~= nil and dmgAdd ~= nil then
	      DmgCalc.DebugVars("Line Damage:",mode,dmgClass,dmgAdd);
	
	      dmgClass = DmgCalc.Trim(dmgClass);
	      what     = DmgCalc.Trim(what);          
	
		    if mode == DMGCALC_PARSING_WORD_SET then
	        dmgAlreadyProcessed = DmgCalc.isSetAlreadyProcessed(aText,aInventoryID);
	        mode = DMGCALC_PARSING_WORD_EQUIP;
	      end
	
	      local pos = string.find(what,DMGCALC_PARSING_WORD_HEALING);
	      if pos ~= nil then
	        if not dmgAlreadyProcessed then
	--	          DmgCalc.DebugVars("Healing: ",DMGCALC_PARSING_WORD_HEALING,what,dmgAdd)
	          DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,mode,dmgAdd);
	        end
	      end
	
	      local pos = string.find(what,DMGCALC_PARSING_WORD_DAMAGE);
	      if pos ~= nil then
	        if not dmgAlreadyProcessed then
	--            DmgCalc.DebugVars("Damage: ",mode,DMGCALC_PARSING_WORD_DAMAGE,what,dmgAdd)
	          DmgCalc.AddItemDmg(dmgClass,mode,dmgAdd);
	        end
	      end
	    end
	  end
	
	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGENCH) do
	--      DmgCalc.DebugVars("LineDmg:",aText,dmgAdd);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end
	
	  for dmgClass,dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGENCH2) do
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(dmgClass,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGANDHEAL) do
	--      DmgCalc.DebugVars("DmgAndHeal:",aText,dmgAdd);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
     end      

		for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGHEALENCH) do
		--      DmgCalc.DebugVars("DmgAndHeal:",aText,dmgAdd);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
		end      

	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_HEALENCH) do
	--      DmgCalc.DebugVars("LineEnch:",aText,dmgAdd);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end
	
	  for dmgAdd,dmgClass in string.gfind(string.lower(aText),DMGCALC_PARSING_OTHERDMG) do
	--      DmgCalc.DebugVars("OtherDmg:",aText,dmgAdd,dmgClass);
	    if dmgAdd ~= nil and dmgClass ~= nil then
	      DmgCalc.AddItemDmg(dmgClass,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end
	
	  for mode,dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_HITS) do
	--      DmgCalc.DebugVars("OtherDmg:",aText,dmgAdd,dmgClass);
	    if dmgAdd ~= nil and mode ~= nil then
		    if mode == DMGCALC_PARSING_WORD_SET then
	        dmgAlreadyProcessed = DmgCalc.isSetAlreadyProcessed(aText,aInventoryID);
	        mode = DMGCALC_PARSING_WORD_EQUIP;
	      end
	      if not dmgAlreadyProcessed then
	        DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HIT,mode,dmgAdd);
	      end
	    end
	  end

	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_HITENCH) do
	  	--      DmgCalc.DebugVars("LineDmg:",aText,dmgAdd);
	  	    if dmgAdd ~= nil then
	  	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HIT,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	  	    end
	  end
	
	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_OTHERHEAL) do
	    DmgCalc.DebugVars("OtherHeal:",aText,dmgAdd,dmgClass);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

-- Mana regen
	  for mode,mana,secs in string.gfind(string.lower(aText),DMGCALC_PARSING_MANAREGEN) do
	    if mana ~= nil and secs ~= nil then
        DmgCalc.DebugVars("Mana regen:",mode,mana,secs);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,mode,mana);
	    end
	  end
	  for mode,mana,secs in string.gfind(string.lower(aText),DMGCALC_PARSING_MANAREGEN2) do
	    if mana ~= nil and secs ~= nil then
        DmgCalc.DebugVars("Mana regen:",mode,mana,secs);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,mode,mana);
	    end
	  end
	  for mana,secs in string.gfind(string.lower(aText),DMGCALC_PARSING_MANAREGEN3) do
	    if mana ~= nil and secs ~= nil then
        DmgCalc.DebugVars("Mana regen:",mana,secs);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,DMGCALC_PARSING_WORD_EQUIP,mana);
	    end
	  end
	end;
end

