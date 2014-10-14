--$Id: OneCore.lua 12749 2006-10-03 02:19:17Z kergoth $-- 

local AL = AceLibrary("AceLocale-2.1")
AL:RegisterTranslation("OneCore", "enUS", function()
   return {
      ["Quiver"]	= true,
      ["Soul Bag"]	= true,
      ["Container"]	= true,
      ["Bag"]	= true,
    }
end)

AL:RegisterTranslation("OneCore", "zhCN", function()
   return {
      ["Quiver"]	= "箭袋",
      ["Soul Bag"]	= "灵魂袋",
      ["Container"]	= "背包",
      ["Bag"]	    = "包裹",
   }
end)

AL:RegisterTranslation("OneCore", "deDE", function()
   return {
      ["Quiver"]	= "K\195\182cher",
      ["Soul Bag"]	= "Seelentasche",
      ["Container"]	= "Beh\195\164lter",
      ["Bag"]	    = "Beh\195\164lter",
   }
end)

AL:RegisterTranslation("OneCore", "koKR", function()
   return {
      ["Quiver"]	= "화살통",
      ["Soul Bag"]	= "영혼의 가방",
      ["Container"]	= "가방",
      ["Bag"]	    = "가방",
   }
end)

AL:RegisterTranslation("OneCore", "frFR", function()
  return {
     ["Quiver"]        = "Carquois",
     ["Soul Bag"]      = "Sac d'\195\162me",
     ["Container"]     = "Conteneur",
     ["Bag"]   = "Conteneur",
  }
end)