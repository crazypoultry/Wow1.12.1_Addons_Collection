--$Id: locals.lua 12749 2006-10-03 02:19:17Z kergoth $ 

local AL = AceLibrary("AceLocale-2.1")

AL:RegisterTranslation("OneRing", "enUS", function()
    return {
		["'s Keyring"] = true,
    }
end)

AL:RegisterTranslation("OneRing", "frFR", function()
    return {
		["'s Keyring"] = " : Cl\195\169s",
    }
end)

AL:RegisterTranslation("OneRing", "zhCN", function()
    return {
		["'s Keyring"] = "的钥匙链",
    }
end)

AL:RegisterTranslation("OneRing", "deDE", function()
    return {
		["'s Keyring"] = "'s Schl\195\188sselbund",
    }
end)

AL:RegisterTranslation("OneRing", "koKR", function()
    return {
		["'s Keyring"] = "의 열쇠고리",
    }
end)
