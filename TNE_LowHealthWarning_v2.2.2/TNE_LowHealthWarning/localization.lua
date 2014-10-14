

-- LowHealthWarning localization
--------------------------------------------------------------------------------

TNE_LowHealthSettings_Labels = {
  [1] = "Low Health Warning",
  [2] = "Version",
}

TNE_LowHealthSettings_Buttons = {
  [1] = DEFAULTS,
  [2] = CANCEL,
  [3] = OKAY,
}

TNE_LowHealthSettings_Sliders = {
  ["Sound"] = {
    [1] = { "Health", "Activate heartbeat when health is below: %d%%", },
  },
  ["Health"] = {
    [1] = { "Health", "Health: %d%%", },
    [2] = { "Critical health", "Critical health: %d%%", },
  },
  ["Mana"] = {
    [1] = { "Mana", "Mana: %d%%", },
    [2] = { "Critical mana", "Critical mana: %d%%", },
  },
}

TNE_LowHealthSettings_CheckButtons = {
  ["General"] = {
    [1] = { "Enable Low Health Warning", "Check to enable the addon.", },
    [2] = { "Large effects", "Check to use bolder textures.", },
  },
  ["Sound"] = {
    [1] = { "Enable heartbeat effect", "Check to enable a heartbeat sound effect.", },
    [2] = { "Only in combat", "Check to play sounds when in combat only.", },
  },
  ["Health"] = {
    [1] = { "Enable health effect", "Check to enable the health warning effect.", },
    [2] = { "Only in combat", "Check to display health warning in combat only.", },
    [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds. This will synchronize the flash with the heartbeat." },
    [4] = { "Emote when critical", "Check to automatically perform the /healme emote when your health is critical.", },
  },
  ["Mana"] = {
    [1] = { "Enable mana effect", "Check to enable the health warning effect.", },
    [2] = { "Only in combat", "Check to display mana warning in combat only.", },
    [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds.", },
    [4] = { "Emote when critical", "Check to automatically perform the /oom emote when your mana is below critical.", },
  },
}

if (GetLocale() == "deDE") then 

  -- German localization originally by Myr of European Gul'dan

  TNE_LowHealthSettings_Labels = {
    [1] = "Low Health Warnung",
    [2] = "Version",
  }

  TNE_LowHealthSettings_Buttons = {
    [1] = "Standard",
    [2] = "Abbrechen",
    [3] = "Ok",
  }

  TNE_LowHealthSettings_Sliders = {
    ["Sound"] = { -- do not translate this line
      [1] = { "Leben", "Activate heartbeat when health is below: %d%%", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Leben", "Leben: %d%%", },
      [2] = { "Kritische Lebenspunkte", "Kritische Lebenspunkte: %d%%", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Mana", "Mana: %d%%", },
      [2] = { "Kritisches Mana", "Kritisches Mana: %d%%", },
    },
  }

  TNE_LowHealthSettings_CheckButtons = {
    ["General"] = { -- do not translate this line
      [1] = { "Enable Low Health Warning", "Check to enable the addon.", },
      [2] = { "Large effects", "Check to use bolder textures.", },
    },
    ["Sound"] = { -- do not translate this line
      [1] = { "Enable heartbeat effect", "Check to enable a heartbeat sound effect.", },
      [2] = { "Only in combat", "Check to play sounds when in combat only.", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Enable health effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display health warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds. This will synchronize the flash with the heartbeat." },
      [4] = { "Emote when critical", "Check to automatically perform the /healme emote when your health is critical.", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Enable mana effect", "Check to enable the health warning effect.", },
      [2] = { "Only in combat", "Check to display mana warning in combat only.", },
      [3] = { "Variable flash rate", "Check to smoothly increase or decrease flash rate instead of using the two thresholds.", },
      [4] = { "Emote when critical", "Check to automatically perform the /oom emote when your mana is below critical.", },
    },
  }

end

if (GetLocale() == "frFR") then

  -- French localization originally by Trucifix
  -- Updated for 2.0+ by Feu

  TNE_LowHealthSettings_Labels = {
    [1] = "Low Health Warning",
    [2] = "Version",
  }

  TNE_LowHealthSettings_Buttons = {
    [1] = DEFAULTS,
    [2] = CANCEL,
    [3] = OKAY,
  }

  TNE_LowHealthSettings_Sliders = {
    ["Sound"] = { -- do not translate this line
      [1] = { "Vie", "Active le battement de coeur lorsque la vie est en-dessous de %d%%", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Vie", "Vie : %d%%", },
      [2] = { "Vie critique", "Vie critique : %d%%", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Mana", "Mana : %d%%", },
      [2] = { "Mana critique", "Mana critique : %d%%", },
    },
  }

  TNE_LowHealthSettings_CheckButtons = {
    ["General"] = { -- do not translate this line
      [1] = { "Activer Low Health Warning", "Cocher pour activer l'addon.", },
      [2] = { "Effets larges", "Cocher pour utiliser des textures plus fonc\195\169es.", },
    },
    ["Sound"] = { -- do not translate this line
      [1] = { "Effet Battement de coeur", "Cocher pour activer l'effet sonore de battement de coeur.", },
      [2] = { "Seulement en combat", "Cocher pour jouer les sons seulement en combat.", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "Effet Vie faible", "Cocher pour activer l'effet d'avertissement de la vie.", },
      [2] = { "Seulement en combat", "Cocher pour afficher l'effet d'avertissement de la vie seulement en combat.", },
      [3] = { "Taux de clignotement", "Cocher pour doucement augmenter ou diminuer le tauxde clignotement au lieu d'utiliser les deux limites. Ceci synchronisera le clignotement avec le battement de coeur." },
      [4] = { "Emote critique", "Cocher pour faire automatiquement l'emote /healme lorsque votre vie est critique.", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "Effet Mana faible", "Cocher pour activer l'effet d'avertissement de la mana.", },
      [2] = { "Seulement en combat", "Cocher pour afficher l'effet d'avertissement de la mana seulement en combat.", },
      [3] = { "Taux de clignotement", "Cocher pour doucement augmenter ou diminuer le tauxde clignotement au lieu d'utiliser les deux limites.", },
      [4] = { "Emote critique", "Cocher pour faire automatiquement l'emote /healme lorsque votre mana est critique.", },
    },
  }

end

if (GetLocale() == "koKR") then

  -- Korean localization originally by Mars

  TNE_LowHealthSettings_Labels = {
    [1] = "Low Health Warning",
    [2] = "버젼",
  }

  TNE_LowHealthSettings_Buttons = {
    [1] = DEFAULTS,
    [2] = CANCEL,
    [3] = OKAY,
  }
  
  TNE_LowHealthSettings_Sliders = {
    ["Sound"] = { -- do not translate this line
      [1] = { "생명력", "생명력이 다음과 같을 때 심장박동 효과가 작동합니다: %d%%", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "생명력", "생명력: %d%%", },
      [2] = { "치명적인 생명력", "치명적인 생명력: %d%%", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "마나", "마나: %d%%", },
      [2] = { "치명적인 마나", "치명적인 마나: %d%%", },
    },
  }

  TNE_LowHealthSettings_CheckButtons = {
    ["General"] = { -- do not translate this line
      [1] = { "Low Life Warning 활성화", "Low Life Warning를 활성화시키려면 체크하세요.", },
      [2] = { "큰 화면효과", "굵은 화면텍스쳐를 사용하려면 체크하세요.", },
    },
    ["Sound"] = { -- do not translate this line
      [1] = { "심장박동 효과 활성화", "심장박동 사운드 효과를 활성화시키려면 체크하세요.", },
      [2] = { "전투시에만 사용", "전투시에만 음향효과를 재생하려면 체크하세요.", },
    },
    ["Health"] = { -- do not translate this line
      [1] = { "생명력 효과 활성화", "생명력 경고 효과를 활성화시키려면 체크하세요.", },
      [2] = { "전투시에만 사용", "전투시에만 생명력 경고를 표시하려면 체크하세요.", },
      [3] = { "부드러운 플래시 효과", "두 한계값을 이용하는 대신에 부드럽게 증가 또는 감소되는 플래시 효과를 사용하려면 체크하세요. 심장박동 음향효과와 플래시 시각효과는 일치됩니다." },
      [4] = { "치명적 상태시 감정표현", "생명력이 치명적인 상태 시 자동으로 '/치료' 감정표현을 이용하여 알리려면 체크하세요.", },
    },
    ["Mana"] = { -- do not translate this line
      [1] = { "마나 효과 활성화", "마나 경고 효과를 활성화시키려면 체크하세요.", },
      [2] = { "전투시에만 사용", "전투시에만 마나 경고를 표시하려면 체크하세요.", },
      [3] = { "부드러운 플래시 효과", "두 한계값을 이용하는 대신에 부드럽게 증가 또는 감소되는 플래시 효과를 사용하려면 체크하세요.", },
      [4] = { "치명적 상태시 감정표현", "마나가 치명적인 상태시 자동으로 '마나' 감정표현을 이용하여 알리려면 체크하세요.", },
    },
  }

end
