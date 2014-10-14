Prat_FuBar2 = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

Prat_FuBar2:RegisterDB("Prat_FuBar2DB")
Prat_FuBar2.title = "Prat"
Prat_FuBar2.name = "Prat"

Prat_FuBar2.hasIcon = true
Prat_FuBar2.cannotDetachTooltip = true

Prat_FuBar2.OnMenuRequest = Prat.Options

-- from oRA2/Options.lua
-- total hack
local args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(Prat_FuBar2)
for k,v in pairs(args) do
	if Prat_FuBar2.OnMenuRequest.args[k] == nil then
        Prat_FuBar2.OnMenuRequest.args[k] = v
    	end
end
-- end hack
