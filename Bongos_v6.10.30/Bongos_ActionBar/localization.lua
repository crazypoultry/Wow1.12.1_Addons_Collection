--[[
	Bongos_Actionbar Localization
--]]

--Stance IDs
--Names of stances, should be what people call them
BONGOS_STANCE_LIST = {
	['DRUID'] = {[0] = 'Caster', 'Bear', 'Aquatic', 'Cat', 'Travel', 'Moonkin', 'Prowl'},
	['ROGUE'] = {[0] = 'Unstealth', 'Stealth'},
	['WARRIOR'] = {'Battle Stance', 'Defensive Stance', 'Berserker Stance'},
	['PRIEST'] = {[0] = 'Healer', 'Shadowform'},
}

--[[ UI Component names ]]--

BONGOS_ROWS = "Rows"
BONGOS_SIZE = "Size"
BONGOS_ONE_BAG = "One Bag"
BONGOS_VERTICAL = "Vertical"

--[[ Buff/Spell Names ]]--

BONGOS_DRUID_PROWL = "Prowl" --Name of the buff you get when prowling
BONGOS_PRIEST_SHADOWFORM = "Shadowform" --Name of the buff you get when in shadowform

--[[ Keybindings ]]--

BINDING_HEADER_BGPAGE = "Bongos Paging"
BINDING_HEADER_BACTIONBAR2 = "Bongos Actionbar 2"
BINDING_HEADER_BACTIONBAR3 = "Bongos Actionbar 3"
BINDING_HEADER_BACTIONBAR4 = "Bongos Actionbar 4"
BINDING_HEADER_BACTIONBAR5 = "Bongos Actionbar 5"
BINDING_HEADER_BACTIONBAR6 = "Bongos Actionbar 6"
BINDING_HEADER_BACTIONBAR7 = "Bongos Actionbar 7"
BINDING_HEADER_BACTIONBAR8 = "Bongos Actionbar 8"
BINDING_HEADER_BACTIONBAR9 = "Bongos Actionbar 9"
BINDING_HEADER_BACTIONBAR10 = "Bongos Actionbar 10"
BINDING_HEADER_BQUICKPAGE = "Quick Paging"
BINDING_HEADER_BBARS = "Bongos Bar Visibility"

BINDING_NAME_BMENUBAR_TOGGLE = "Toggle the MenuBar"
BINDING_NAME_BBAGBAR_TOGGLE = "Toggle the BagBar"

--some german localization, thanks to Archiv
if GetLocale() == "deDE" then
	BINDING_HEADER_BACTIONBAR2 = "Bongos Aktionbar 2"
	BINDING_HEADER_BACTIONBAR3 = "Bongos Aktionbar 3"
	BINDING_HEADER_BACTIONBAR4 = "Bongos Aktionbar 4"
	BINDING_HEADER_BACTIONBAR5 = "Bongos Aktionbar 5"
	BINDING_HEADER_BACTIONBAR6 = "Bongos Aktionbar 6"
	BINDING_HEADER_BACTIONBAR7 = "Bongos Aktionbar 7"
	BINDING_HEADER_BACTIONBAR8 = "Bongos Aktionbar 8"
	BINDING_HEADER_BACTIONBAR9 = "Bongos Aktionbar 9"
	BINDING_HEADER_BACTIONBAR10 = "Bongos Aktionbar 10"
	BINDING_HEADER_BQUICKPAGE = "Schnelles Paging"
	BINDING_HEADER_BBARS = "Bongos Bar Transparent"

	BINDING_NAME_BMENUBAR_TOGGLE = "Verstecke/Zeige die Men\195\188bar"
	BINDING_NAME_BBAGBAR_TOGGLE = "Verstecke/Zeige die Taschen Bar"
end