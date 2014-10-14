if ( GetLocale() == "deDE" ) then

	--Commands
	DMGCALC_COMMAND_RESET		= "reset";

	DMGCALC_PARSING_WORD_HEALING  = "heilung"
	DMGCALC_PARSING_WORD_DAMAGE   = "schaden"
	DMGCALC_PARSING_WORD_EQUIP    = "anlegen" -- changed from verwenden to anlegen
	DMGCALC_PARSING_WORD_SET	  = "set"
	DMGCALC_PARSING_WORD_USE	  = "benutzen"
	DMGCALC_PARSING_WORD_ON       = " "
    DMGCALC_PROMPT_EQUIP          = "Anlegen:" -- changed from Verwenden: to Anlegen:
    DMGCALC_PROMPT_USE            = "Benutzen:"

	DMGCALC_SUBPROMPT = DMGCALC .. ">|r "
	DMGCALC_PROMPT    = DMGCALC_COLOR_MAIN .. DMGCALC_SUBPROMPT

	DMGCALC_WELCOME = DMGCALC_PROMPT .. DMGCALC_VERSION .. " geladen, benutze /" ..
	                  DMGCALC_COMMAND .. " oder /" .. DMGCALC_COMMAND_SHORT .. " als Kommandos. Deutsche Loc: IcyErasor - Aegwynn"

	DMGCALC_HELP = { DMGCALC_PROMPT .. " " .. DMGCALC_VERSION,
	                 "  " .. DMGCALC_COMMAND_RESET .. " - Setze alle Werte auf Standardwerte zur\195\188ck."
	                 };

	DMGCALC_PARSING_KEY_ARCANE   = "arkan"
	DMGCALC_PARSING_KEY_FIRE     = "feuer"
	DMGCALC_PARSING_KEY_NATURE   = "natur"
	DMGCALC_PARSING_KEY_FROST    = "frost"
	DMGCALC_PARSING_KEY_SHADOW   = "schatten"
	DMGCALC_PARSING_KEY_MAGICAL  = "magische" -- magische
	DMGCALC_PARSING_KEY_CRITICAL = "kritischen"
	DMGCALC_PARSING_KEY_HEALING  = "heilung"
	DMGCALC_PARSING_KEY_HIT      = "trefferchance"
	DMGCALC_PARSING_KEY_MANAREGEN = "manaregen"

--Verwenden: Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu 49. -- magicalschool dmgitems
--Verwenden: Erhöht durch Zauber und magische Effekte zugefügten Schaden um bis zu 44. -- normal +alldmg items
--Benutzen:  Erhöht durch magische Zauber und magische Effekte zugefügten Schaden und Heilung 15 Sek. um bis zu 175. -- TOEP

  DMGCALC_PARSING_DMG      = "(.+): erh\195\182ht durch (.*)zauber und (.*)effekte zugef\195\188gten (.*)um bis zu (%d+)."
--Verwenden: Erhöht durch Zauber und Effekte verursachte Heilung um bis zu 73.
	DMGCALC_PARSING_HEAL     = "(.+): erh\195\182ht durch zauber und effekte verursachte (.*)um bis zu (%d+)."
	DMGCALC_PARSING_CRITS    = "(.+): erh\195\182ht eure chance, einen kritischen schlag durch zauber zu erzielen, um (%d+)%%."
	DMGCALC_PARSING_HITS     = "(.+): erh\195\182ht eure chance mit zaubern zu treffen um (%d+)%%."
	DMGCALC_PARSING_SETS     = "(.+) %(%d%/%d%)$"
	DMGCALC_PARSING_DMGENCH  = "%+(%d+) (.*)zauberschaden"
	DMGCALC_PARSING_HEALENCH = "heilzauber %+(%d+)"
	DMGCALC_PARSING_OTHERHEAL = "%+(%d+) heilzauber"
	DMGCALC_PARSING_MANAREGEN = "(.+): stellt alle (%d+) sek. (%d+) punkt%(e%) mana wieder her."
	DMGCALC_PARSING_DMGENCH2 = "(.*)zauber%-schaden %+(%d+)";

	DMGCALC_TOOLTIPS_TITLE   = { "Arkanschaden",
	                             "Feuerschaden",
	                             "Naturschaden",
	                             "Frostschaden",
	                             "Schattenschaden",
	                             "Boni auf kritische Treffer",
	                             "Heilungszauber",
	                             "Boni auf Wahrscheinlichkeit mit Zaubern zu treffen",
	                             "Manapregen pro 5 Sekunden"
	                           };

	-- option labels, tooltips and variables
	DmgCalcToolTips = {
		DmgCalcFrame = { title=DMGCALC_COLOR_MAIN .. DMGCALC .. " " .. DMGCALC_VERSION , text=DMGCALC_COLOR_MAIN .. "by Kurtzo.Medivh <Ascent>|r\n" }
	}

	function DmgCalc_LocalizationParse(aText,aInventoryID)

    local dmgAlreadyProcessed = false;


	  for mode,critsPct in string.gfind(string.lower(aText),DMGCALC_PARSING_CRITS) do
	    if mode ~= nil and critsPct ~= nil then
--        DmgCalc.DebugVars("Crits:",mode,critsPct);

        dmgAlreadyProcessed = false;
		    if mode == DMGCALC_PARSING_WORD_SET then
	        dmgAlreadyProcessed = DmgCalc.isSetAlreadyProcessed(aText,aInventoryID);
	        mode = DMGCALC_PARSING_WORD_EQUIP;
	      end

	      if not dmgAlreadyProcessed then
          DmgCalc.DebugVars(DMGCALC_PARSING_CRITS,DMGCALC_PARSING_KEY_CRITICAL,mode,critsPct);
	        DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_CRITICAL,mode,critsPct);
        end
	    end
	  end

    -- dmgClass and what are inversed in german translation
	  for mode,dmgClass,dmgClassIdem,what,dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMG) do
	    dmgClass = dmgClassIdem; -- dmgClass will ALMOST!! always return nil (except Talisman of ephermeral power and other exceptions where afaik DmgClassIdem = DmgClass!)
	    if dmgClass ~= nil and what ~= nil and mode ~= nil and dmgAdd ~= nil then
	      DmgCalc.DebugVars("DMGCALC_PARSING_DMG:",mode,dmgClass,what,dmgAdd);

	      dmgClass = DmgCalc.Trim(dmgClass);
	      what     = DmgCalc.Trim(what);

        dmgAlreadyProcessed = false;
		    if mode == DMGCALC_PARSING_WORD_SET then
	        dmgAlreadyProcessed = DmgCalc.isSetAlreadyProcessed(aText,aInventoryID);
	        mode = DMGCALC_PARSING_WORD_EQUIP;
	      end

				local pos = string.find(what,DMGCALC_PARSING_WORD_HEALING);
	      if pos ~= nil then
	        if not dmgAlreadyProcessed then
 	          DmgCalc.DebugVars("DMGCALC_PARSING_DMG Healing: ",DMGCALC_PARSING_WORD_HEALING,mode,dmgAdd)
	          DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,mode,dmgAdd);
	        end
	      end

	      local pos = string.find(what,DMGCALC_PARSING_WORD_DAMAGE);
	      if pos ~= nil then
	        if not dmgAlreadyProcessed then
            DmgCalc.DebugVars("DMGCALC_PARSING_DMG Damage: ",dmgClass,mode,dmgAdd)
	          DmgCalc.AddItemDmg(dmgClass,mode,dmgAdd);
	        end
	      end

      end
    end

    -- dmgClass and what are inversed in german translation
	  for mode,dmgClass,dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_HEAL) do
	    if dmgClass ~= nil and mode ~= nil and dmgAdd ~= nil then
	      DmgCalc.DebugVars("DMGCALC_PARSING_HEAL:",mode,dmgClass,dmgAdd);

	      dmgClass = DmgCalc.Trim(dmgClass);

        dmgAlreadyProcessed = false;
		    if mode == DMGCALC_PARSING_WORD_SET then
	        dmgAlreadyProcessed = DmgCalc.isSetAlreadyProcessed(aText,aInventoryID);
	        mode = DMGCALC_PARSING_WORD_EQUIP;
	      end

        if not dmgAlreadyProcessed then
          DmgCalc.DebugVars("AddItem Dmg DMGCALC_PARSING_HEAL:",dmgClass,mode,dmgAdd)
          DmgCalc.AddItemDmg(dmgClass,mode,dmgAdd);
        end
      end
    end

	  for dmgAdd,dmgClass in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGENCH) do
      dmgClass = DmgCalc.Trim(dmgClass);
      DmgCalc.DebugVars("DMGCALC_PARSING_DMGENCH:",dmgAdd,dmgClass);
	    if dmgAdd ~= nil then
        if dmgClass ~= "" then
          DmgCalc.DebugVars("DMGCALC_PARSING_DMGENCH AddItemDmg:",dmgClass,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	        DmgCalc.AddItemDmg(dmgClass,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
        else
          DmgCalc.DebugVars("DMGCALC_PARSING_DMGENCH AddItemDmg:",DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	        DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
        end
	    end
	  end

	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_HEALENCH) do
	--      DmgCalc.DebugVars("LineEnch:",aText,dmgAdd);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
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

	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_OTHERHEAL) do
	    DmgCalc.DebugVars("OtherHeal:",aText,dmgAdd,dmgClass);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

-- Mana regen -- mode,secs,mana in germany
	  for mode,secs,mana in string.gfind(string.lower(aText),DMGCALC_PARSING_MANAREGEN) do
       if mana ~= nil and secs ~= nil then
        DmgCalc.DebugVars("Mana regen:",mode,mana,secs);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,mode,mana);
	   end
	  end

-- Winters might "Frostzauber-Schaden +7"
      for dmgClass,dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGENCH2) do
      dmgClass = DmgCalc.Trim(dmgClass);
      DmgCalc.DebugVars("DMGCALC_PARSING_DMGENCH:",dmgAdd,dmgClass);
	    if dmgAdd ~= nil then
        if dmgClass ~= "" then
          DmgCalc.DebugVars("DMGCALC_PARSING_DMGENCH AddItemDmg:",dmgClass,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	        DmgCalc.AddItemDmg(dmgClass,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
        else
          DmgCalc.DebugVars("DMGCALC_PARSING_DMGENCH AddItemDmg:",DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	        DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
        end
	    end
	  end

	end;
end