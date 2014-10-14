lazyDruidLoad.metadata:updateRevisionFromKeyword("$Revision: 171 $")

function lazyDruidLoad.LoadDruidLocalization(locale)

   lazyDruidLocale.enUS.ACTION_TTS.bite               = "Ferocious Bite"
   lazyDruidLocale.enUS.ACTION_TTS.claw               = "Claw"
   lazyDruidLocale.enUS.ACTION_TTS.cower              = "Cower"
   lazyDruidLocale.enUS.ACTION_TTS.dash               = "Dash"
   lazyDruidLocale.enUS.ACTION_TTS.pounce             = "Pounce"
   lazyDruidLocale.enUS.ACTION_TTS.prowl              = "Prowl"
   lazyDruidLocale.enUS.ACTION_TTS.rake               = "Rake"
   lazyDruidLocale.enUS.ACTION_TTS.ravage             = "Ravage"
   lazyDruidLocale.enUS.ACTION_TTS.rip                = "Rip"
   lazyDruidLocale.enUS.ACTION_TTS.shred              = "Shred"
   lazyDruidLocale.enUS.ACTION_TTS.tigersFury         = "Tiger's Fury"
   lazyDruidLocale.enUS.ACTION_TTS.trackHumanoids     = "Track Humanoids"

   lazyDruidLocale.enUS.ACTION_TTS.bash               = "Bash"
   lazyDruidLocale.enUS.ACTION_TTS.challenge          = "Challenging Roar"
   lazyDruidLocale.enUS.ACTION_TTS.charge             = "Feral Charge"
   lazyDruidLocale.enUS.ACTION_TTS.demoralize         = "Demoralizing Roar"
   lazyDruidLocale.enUS.ACTION_TTS.enrage             = "Enrage"
   lazyDruidLocale.enUS.ACTION_TTS.frenziedRegen      = "Frenzied Regeneration"
   lazyDruidLocale.enUS.ACTION_TTS.growl              = "Growl"
   lazyDruidLocale.enUS.ACTION_TTS.maul               = "Maul"
   lazyDruidLocale.enUS.ACTION_TTS.swipe              = "Swipe"

   lazyDruidLocale.enUS.ACTION_TTS.abolishPoison      = "Abolish Poison"
   lazyDruidLocale.enUS.ACTION_TTS.barkskin           = "Barkskin"
   lazyDruidLocale.enUS.ACTION_TTS.curePoison         = "Cure Poison"
   lazyDruidLocale.enUS.ACTION_TTS.faerieFire         = "Faerie Fire"
   lazyDruidLocale.enUS.ACTION_TTS.feralFire          = "Faerie Fire (Feral)"
   lazyDruidLocale.enUS.ACTION_TTS.gotw               = "Gift of the Wild"
   lazyDruidLocale.enUS.ACTION_TTS.grasp              = "Nature's Grasp"
   lazyDruidLocale.enUS.ACTION_TTS.healingTouch       = "Healing Touch"
   lazyDruidLocale.enUS.ACTION_TTS.hibernate          = "Hibernate"
   lazyDruidLocale.enUS.ACTION_TTS.hurricane          = "Hurricane"
   lazyDruidLocale.enUS.ACTION_TTS.innervate          = "Innervate"
   lazyDruidLocale.enUS.ACTION_TTS.moonfire           = "Moonfire"
   lazyDruidLocale.enUS.ACTION_TTS.motw               = "Mark of the Wild"
   lazyDruidLocale.enUS.ACTION_TTS.ns                 = "Nature's Swiftness"
   lazyDruidLocale.enUS.ACTION_TTS.ooc                = "Omen of Clarity"
   lazyDruidLocale.enUS.ACTION_TTS.rebirth            = "Rebirth"
   lazyDruidLocale.enUS.ACTION_TTS.regrowth           = "Regrowth"
   lazyDruidLocale.enUS.ACTION_TTS.rejuv              = "Rejuvenation"
   lazyDruidLocale.enUS.ACTION_TTS.removeCurse        = "Remove Curse"
   lazyDruidLocale.enUS.ACTION_TTS.roots              = "Entangling Roots"
   lazyDruidLocale.enUS.ACTION_TTS.soothe             = "Soothe Animal"
   lazyDruidLocale.enUS.ACTION_TTS.starfire           = "Starfire"
   lazyDruidLocale.enUS.ACTION_TTS.swarm              = "Insect Swarm"
   lazyDruidLocale.enUS.ACTION_TTS.swiftmend          = "Swiftmend"
   lazyDruidLocale.enUS.ACTION_TTS.teleMoonglade      = "Teleport: Moonglade"
   lazyDruidLocale.enUS.ACTION_TTS.thorns             = "Thorns"
   lazyDruidLocale.enUS.ACTION_TTS.tranquility        = "Tranquility"
   lazyDruidLocale.enUS.ACTION_TTS.wrath              = "Wrath"

   lazyDruidLocale.enUS.ACTION_TTS.bear               = "Bear Form"
   lazyDruidLocale.enUS.ACTION_TTS.aquatic            = "Aquatic Form"
   lazyDruidLocale.enUS.ACTION_TTS.cat                = "Cat Form"
   lazyDruidLocale.enUS.ACTION_TTS.travel             = "Travel Form"
   lazyDruidLocale.enUS.ACTION_TTS.moonkin            = "Moonkin Form"


   -- assume english, unless overridden below
   lazyDruidLocale.enUS.BITE_HIT = "Your Ferocious Bite hits (.+) for (%d+)."
   lazyDruidLocale.enUS.BITE_CRIT = "Your Ferocious Bite crits (.+) for (%d+).";

   if (locale == "deDE") then -- German
      lazyDruidLocale.deDE.ACTION_TTS.prowl           = "Schleichen"
      lazyDruidLocale.deDE.ACTION_TTS.faerieFire      = "Feenfeuer"
      lazyDruidLocale.deDE.ACTION_TTS.feralFire       = "Feenfeuer (Tiergestalt)"
      lazyDruidLocale.deDE.ACTION_TTS.hibernate       = "Winterschlaf"
      lazyDruidLocale.deDE.ACTION_TTS.motw            = "Mal der Wildnis"
      lazyDruidLocale.deDE.ACTION_TTS.gotw            = "Gabe der Wildnis"

      lazyDruidLocale.deDE.BITE_HIT = nil
      lazyDruidLocale.deDE.BITE_CRIT = nil


   elseif (locale == "frFR") then -- French
      lazyDruidLocale.frFR.ACTION_TTS.prowl           = "R\195\180der"
      lazyDruidLocale.frFR.ACTION_TTS.faerieFire      = "Lucioles"
      lazyDruidLocale.frFR.ACTION_TTS.feralFire       = "Lucioles (farouche)"
      lazyDruidLocale.frFR.ACTION_TTS.hibernate       = "Hibernation"
      lazyDruidLocale.frFR.ACTION_TTS.motw            = "Marque du fauve"
      lazyDruidLocale.frFR.ACTION_TTS.gotw            = "Don du fauve"

      lazyDruidLocale.frFR.BITE_HIT = nil
      lazyDruidLocale.frFR.BITE_CRIT = nil

   end
end

