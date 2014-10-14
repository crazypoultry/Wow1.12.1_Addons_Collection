

-- Whispers localization
--------------------------------------------------------------------------------

TNE_WhispersSettings_Labels = {
  [1] = "Whispers' Settings",
  [2] = "Version",
}

TNE_WhispersSettings_Buttons = {
  [1] = DEFAULTS,
  [2] = CANCEL,
  [3] = OKAY,
  [4] = "Preview",
}

TNE_WhispersSettings_Stop = "Stop"

TNE_WhispersSettings_Sliders = {
  ["General"] = {
    [1] = { "Delay after outgoing", "Do not flash for whispers recieved within %d seconds of my last whisper.", },
  },
  ["Parameters"] = {
    [1] = { "Fade in duration:", "Fade in time: %.1f seconds", },
    [2] = { "Fade out duration:", "Fade out time: %.1f seconds", },
    [3] = { "Remain visible for:", "Remain visible for %d seconds after fade in.", },
    [4] = { "Remain hidden for:", "Remain hidden for %d seconds after fade out.", },
  },
}

TNE_WhispersSettings_CheckButtons = {
  ["General"] = {
    [1] = { "Enable Whispers effect", "Check to enable the addon.", },
    [2] = { "Flash once only", "Check to only flash once when a whisper is recieved (instead of flashing until you send a whisper).", },
  },
  ["Parameters"] = {
  },
}


-- French localization by Feu
-- Last update: 07/25/07

if (GetLocale() == "frFR") then

  TNE_WhispersSettings_Labels = {
    [1] = "Param\195\168tres de Whispers",
    [2] = "Version",
  }

  TNE_WhispersSettings_Buttons = {
    [1] = DEFAULTS,
    [2] = CANCEL,
    [3] = OKAY,
    [4] = "Aper\195\167u",
  }

  TNE_WhispersSettings_Stop = "Stop"

  TNE_WhispersSettings_Sliders = {
    ["General"] = {
      [1] = { "D\195\169lai avant prochain flash", "Pas de flash \195\160 la r\195\169ception d'un message dans les %d secondes apr\195\168s le dernier message.", },
    },
    ["Parameters"] = {
      [1] = { "Dur\195\169e d'apparition :", "Temps d'apparition : %.1f secondes", },
      [2] = { "Dur\195\169e de disparition :", "Temps de disparition : %.1f secondes", },
      [3] = { "Reste visible pendant :", "Reste visible pendant %d secondes apr\195\168 apparition.", },
      [4] = { "Reste cach\195\169 pendant :", "Reste cach\195\169 pendant %d secondes apr\195\168 disparition.", },
    },
  }

  TNE_WhispersSettings_CheckButtons = {
    ["General"] = {
      [1] = { "Activer l'effet Whispers", "Cochez pour activer l'addon.", },
      [2] = { "Flash une seule fois", "Cochez pour falsher une seule fois lorsqu'un message est re\195\167u (au lieu de falsher jusqu'\195\160 ce vous envoyez un message).", },
    },
    ["Parameters"] = {
    },
  }

end