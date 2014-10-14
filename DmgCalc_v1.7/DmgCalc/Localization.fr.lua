if ( GetLocale() == "frFR" ) then
	--Commands
	DMGCALC_COMMAND_RESET		= "reset";
	
	DMGCALC_PARSING_WORD_HEALING  = "soins"
	DMGCALC_PARSING_WORD_DAMAGE   = "d\195\169g\195\162ts"
	DMGCALC_PARSING_WORD_EQUIP    = "equip\195\169 "
	DMGCALC_PARSING_WORD_SET	    = "complet "
	DMGCALC_PARSING_WORD_USE	    = "utilis\195\169 "
	DMGCALC_PARSING_WORD_ON       = " "
  DMGCALC_PROMPT_EQUIP          = "Equip:"
  DMGCALC_PROMPT_USE            = "Use:"
		
	DMGCALC_SUBPROMPT = DMGCALC .. ">|r "
	DMGCALC_PROMPT    = DMGCALC_COLOR_MAIN .. DMGCALC_SUBPROMPT
	
	DMGCALC_WELCOME = DMGCALC_PROMPT .. DMGCALC_VERSION .. " Charg\195\169"
	                    
	DMGCALC_HELP = { DMGCALC_PROMPT .. " " .. DMGCALC_VERSION,
	                 "  " .. DMGCALC_COMMAND_RESET .. " - Rinitialise toute les variables"
	                 };
	
	DMGCALC_PARSING_KEY_ARCANE   = "d'arcane"
	DMGCALC_PARSING_KEY_FIRE	   = "de feu"
	DMGCALC_PARSING_KEY_NATURE   = "de nature"
	DMGCALC_PARSING_KEY_FROST    = "de givre"
	DMGCALC_PARSING_KEY_SHADOW   = "d'ombre"
	DMGCALC_PARSING_KEY_MAGICAL  = "magiques"
	DMGCALC_PARSING_KEY_CRITICAL = "critique"
	DMGCALC_PARSING_KEY_HEALING  = "soins"
	DMGCALC_PARSING_KEY_HIT      = "toucher"
	DMGCALC_PARSING_KEY_MANAREGEN = "regenmana"

	DMGCALC_PARSING_CRITS     = "(.+): augmente vos chances d'infliger des coups critiques avec vos sorts de (%d+)%%"
	DMGCALC_PARSING_HITS      = "(.+): augmente vos chances de toucher avec des sorts de (%d+)%%"
	DMGCALC_PARSING_SETS      = "(.+) %(%d%/%d%)$"
	
	DMGCALC_PARSING_DMG       = "(.+): augmente (.+) les sorts et les effets (.+)de (%d+) au maximum."
	DMGCALC_PARSING_DMGENCH   = "d\195\169g\195\162ts des sorts %+(%d+)"
	DMGCALC_PARSING_DMGENCHZG = "soins et d\195\169g\195\162ts des sorts %+(%d+)"
	DMGCALC_PARSING_OTHERDMG  = "%+(%d+) aux d\195\169g\195\162ts des sorts (.+)"

  DMGCALC_PARSING_MANAREGEN = "(.+): rend (%d+) points de mana toutes les (%d+) sec"
  DMGCALC_PARSING_MANAENCH  = "r\195\169cup. mana (%d+)/(%d+) sec."
  DMGCALC_PARSING_MANAENCHZG = "r\195\169cup. mana %+(%d+)"
  DMGCALC_PARSING_OTHERMANA = "%+(%d+) mana every (%d+) sec."  -- Still need FR

	DMGCALC_PARSING_HEALENCH  = "sorts de soins %+(%d+)"
	DMGCALC_PARSING_OTHERHEAL = "%+(%d+) aux sorts de soins"
	
	DMGCALC_TOOLTIPS_TITLE   = { "D\195\169g\195\162ts d'arcane",
	                             "D\195\169g\195\162ts de feu",
	                             "D\195\169g\195\162ts de nature",
	                             "D\195\169g\195\162ts de froid",
	                             "D\195\169g\195\162ts d'ombre",
	                             "Critiques",
	                             "Soins",
	                             "Chanches de toucher",
	                             "Mana toutes les 5 sec"
	                           };
	
	-- option labels, tooltips and variables
	DmgCalcToolTips = {
		DmgCalcFrame = { title=DMGCALC_COLOR_MAIN .. DMGCALC .. " " .. DMGCALC_VERSION , text=DMGCALC_COLOR_MAIN .. "by Kurtzo.Medivh <Ascent>|r\n" }
	}
	
	function DmgCalc_LocalizationParse(aText,aInventoryID)

    local dmgAlreadyProcessed = false;

--------------------
--  modif diverses
--------------------
	--	Ce test est spcifique a la version francaise, pour les sort du type "Equipe : Augmente les soins prodigues par les sorts et effets de 22 au maximum"
	--  (a ete modifie)
	  local DMGCALC_PARSING_HEAL = "(.+): augmente les soins prodigu\195\169s par les sorts et effets de (%d+) au maximum."
	  for mode,healAdd in string.gfind(string.lower(aText),string.lower(DMGCALC_PARSING_HEAL)) do
	    if healAdd ~= nil then
	       DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,mode,healAdd);
	    end
	  end
	  
	--	Ce test est spcifique a la version francaise, pour Anatheme "Equipe : Augmente les degats des sorts et effets de l'Ombre de 69."
	--  (a ete modifie)
	  local DMGCALC_PARSING_ANATHEME = "(.+): augmente les d\195\169g\195\162ts des sorts et effets de l'ombre de (%d+)."
	  for mode,dmgAnatheme in string.gfind(string.lower(aText),string.lower(DMGCALC_PARSING_ANATHEME)) do
	    if dmgAnatheme ~= nil then
	       DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_SHADOW,mode,dmgAnatheme);
	    end
	  end

	--	Ce test est spcifique a la version francaise, pour les sort du type "Equipe : Augmente les degats et les soins produits par les sorts et effets magiques de 22 au maximum."
	  local DMGCALC_PARSING_DMGHEAL = "(.+): augmente les d\195\169g\195\162ts et les soins produits par les sorts et effets magiques de (%d+) au maximum."
	  for mode,dmgHealAdd in string.gfind(string.lower(aText),string.lower(DMGCALC_PARSING_DMGHEAL)) do
	    if dmgHealAdd ~= nil then
		    if mode == DMGCALC_PARSING_WORD_SET then
	         dmgAlreadyProcessed = DmgCalc.isSetAlreadyProcessed(aText,aInventoryID);
	         mode = DMGCALC_PARSING_WORD_EQUIP;
	      end
	      
	      if not dmgAlreadyProcessed then
	        DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,mode,dmgHealAdd);
	        DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,mode,dmgHealAdd);
	      end
	    end
	  end

-----------------------------
--  pourcentage de critique
-----------------------------
	  for mode,critsPct in string.gfind(string.lower(aText),DMGCALC_PARSING_CRITS) do
	    if mode ~= nil and critsPct ~= nil then
        DmgCalc.DebugVars("Crits:",mode,critsPct);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_CRITICAL,mode,critsPct);
	    end
	  end

------------------------
--  chances de toucher
------------------------
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

--------------------------------------------------
--  soins et degats des diverses ecoles de magie
--------------------------------------------------
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
	
----------------------------
--  enchantement de degats
----------------------------
	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGENCH) do
	--      DmgCalc.DebugVars("LineDmg:",aText,dmgAdd);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

---------------------------------------
--  enchantement de degats et soin ZG
---------------------------------------
	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_DMGENCHZG) do
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MAGICAL,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

------------------------------
--  autres sources de degats
------------------------------
	  for dmgAdd,dmgClass in string.gfind(string.lower(aText),DMGCALC_PARSING_OTHERDMG) do
	--      DmgCalc.DebugVars("OtherDmg:",aText,dmgAdd,dmgClass);
	    if dmgAdd ~= nil and dmgClass ~= nil then
	      DmgCalc.AddItemDmg(dmgClass,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

--------------------------
--  enchantement de soin
--------------------------
	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_HEALENCH) do
	--      DmgCalc.DebugVars("LineEnch:",aText,dmgAdd);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

----------------------------
--  autres sources de soin
----------------------------
	  for dmgAdd in string.gfind(string.lower(aText),DMGCALC_PARSING_OTHERHEAL) do
	    DmgCalc.DebugVars("OtherHeal:",aText,dmgAdd,dmgClass);
	    if dmgAdd ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_HEALING,DMGCALC_PARSING_WORD_EQUIP,dmgAdd);
	    end
	  end

-------------------------------------------------------
-- Regen mana toutes les 5 sec offerte par les objets
-------------------------------------------------------
	  for mode,mana,secs in string.gfind(string.lower(aText),DMGCALC_PARSING_MANAREGEN) do
	    if mana ~= nil and secs ~= nil then
 --       DmgCalc.DebugVars("Mana regen:",mode,mana,secs);
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,mode,mana);
	    end
	  end

--------------------------------------------------------------
--  regen mana toutes les 5 sec offerte par les enchantement
--------------------------------------------------------------
	  for mana,secs in string.gfind(string.lower(aText),DMGCALC_PARSING_MANAENCH) do
	    if mana ~= nil and secs ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,DMGCALC_PARSING_WORD_EQUIP,mana);
	    end
	  end

---------------------------------------------------------------------
--  regen mana toutes les 5 sec offerte par les enchantements de ZG
---------------------------------------------------------------------
	  for mana in string.gfind(string.lower(aText),DMGCALC_PARSING_MANAENCHZG) do
	    if mana ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,DMGCALC_PARSING_WORD_EQUIP,mana);
	    end
	  end

----------------------------------
--  autres sources de regen mana
----------------------------------
	  for mana,secs in string.gfind(string.lower(aText),DMGCALC_PARSING_OTHERMANA) do
	    if mana ~= nil and secs ~= nil then
	      DmgCalc.AddItemDmg(DMGCALC_PARSING_KEY_MANAREGEN,DMGCALC_PARSING_WORD_EQUIP,mana);
	    end
	  end	  
	end
end--Constant
