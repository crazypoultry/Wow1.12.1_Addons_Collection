lazyRogueLoad.metadata:updateRevisionFromKeyword("$Revision: 627 $")

function lazyRogueLoad.LoadRogueLocalization(locale)

   lazyRogueLocale.enUS.IMPORTED = "LazyRogue v3.1 settings, forms, interrupt exception criteria and tracked immunities have been imported."

   lazyRogueLocale.enUS.ACTION_TTS.adrenaline        = "Adrenaline Rush"
   lazyRogueLocale.enUS.ACTION_TTS.ambush            = "Ambush"
   lazyRogueLocale.enUS.ACTION_TTS.bladeFlurry       = "Blade Flurry"
   lazyRogueLocale.enUS.ACTION_TTS.blind             = "Blind"
   lazyRogueLocale.enUS.ACTION_TTS.bs                = "Backstab"
   lazyRogueLocale.enUS.ACTION_TTS.cs                = "Cheap Shot"
   lazyRogueLocale.enUS.ACTION_TTS.coldBlood         = "Cold Blood"
   lazyRogueLocale.enUS.ACTION_TTS.distract          = "Distract"
   lazyRogueLocale.enUS.ACTION_TTS.evasion           = "Evasion"
   lazyRogueLocale.enUS.ACTION_TTS.evisc             = "Eviscerate"
   lazyRogueLocale.enUS.ACTION_TTS.expose            = "Expose Armor"
   lazyRogueLocale.enUS.ACTION_TTS.feint             = "Feint"
   lazyRogueLocale.enUS.ACTION_TTS.garrote           = "Garrote"
   lazyRogueLocale.enUS.ACTION_TTS.ghostly           = "Ghostly Strike"
   lazyRogueLocale.enUS.ACTION_TTS.gouge             = "Gouge"
   lazyRogueLocale.enUS.ACTION_TTS.hemo              = "Hemorrhage"
   lazyRogueLocale.enUS.ACTION_TTS.kick              = "Kick"
   lazyRogueLocale.enUS.ACTION_TTS.ks                = "Kidney Shot"
   lazyRogueLocale.enUS.ACTION_TTS.pickPocket        = "Pick Pocket"
   lazyRogueLocale.enUS.ACTION_TTS.premeditation     = "Premeditation"
   lazyRogueLocale.enUS.ACTION_TTS.preparation       = "Preparation"
   lazyRogueLocale.enUS.ACTION_TTS.riposte           = "Riposte"
   lazyRogueLocale.enUS.ACTION_TTS.rupture           = "Rupture"
   lazyRogueLocale.enUS.ACTION_TTS.sap               = "Sap"
   lazyRogueLocale.enUS.ACTION_TTS.snd               = "Slice and Dice"
   lazyRogueLocale.enUS.ACTION_TTS.sprint            = "Sprint"
   lazyRogueLocale.enUS.ACTION_TTS.ss                = "Sinister Strike"
   lazyRogueLocale.enUS.ACTION_TTS.stealth           = "Stealth"
   lazyRogueLocale.enUS.ACTION_TTS.vanish            = "Vanish"

   -- assume english, unless overridden below
   lazyRogueLocale.enUS.EVISCERATE_HIT = "Your Eviscerate hits (.+) for (%d+)."
   lazyRogueLocale.enUS.EVISCERATE_CRIT = "Your Eviscerate crits (.+) for (%d+).";

   if (locale == "deDE") then -- German
      lazyRogueLocale.deDE.EVISCERATE_HIT = "Ausweiden von Euch trifft (.+) f\195\188r (%d+) Schaden."
      lazyRogueLocale.deDE.EVISCERATE_CRIT = "Euer Ausweiden trifft (.+) kritisch. Schaden: (%d+).";

   elseif (locale == "frFR") then -- French
      lazyRogueLocale.frFR.EVISCERATE_HIT = "Votre Evisc\195\169ration touche (.+) et inflige (%d+) points de d\195\169g\195\162ts."
      lazyRogueLocale.frFR.EVISCERATE_CRIT = "Votre Evisc\195\169ration inflige un coup critique \195\160 (.+) %((%d+) points de d\195\169g\195\162ts%).";
   end
end

