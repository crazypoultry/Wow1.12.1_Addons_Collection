local L = AceLibrary("AceLocale-2.2"):new("Grid")

local strings_enUS = {
	--{{{ GridCore
	["Debugging"] = true,
	["Module debugging menu."] = true,
	["debug"] = true,
	["Debug"] = true,
	["Toggle debugging."] = true,
	["Toggle debugging for "] = true,
	
	--}}}
	--{{{ GridStatus
	["group"] = true,
	["options"] = true,
	["Options for "] = true,
	["Enable"] = true,
	["Status"] = true,
	["Send"] = true,
	["Color"] = true,
	["Color for "] = true,
	["Priority"] = true,
	["Priority for "] = true,
	["Range filter"] = true,
	["Range filter for "] = true,
	
	--}}}
	--{{{ GridStatusAggro
	["Aggro"] = true,
	["Aggro alert"] = true,
	
	--}}}
	--{{{ GridStatusName
	["Unit Name"] = true,
	["Letters"] = true,
	["Number of unit name letters."] = true,
	["Color by class"] = true,
	
	--}}}
	--{{{ GridStatusMana
	["Mana threshold"] = true,
	["Set the percentage for the low mana warning."] = true,
	["Low Mana warning"] = true,
	["Low Mana"] = true,
	
	--}}}
	--{{{ GridStatusHeals
	["Heals"] = true,
	["Incoming heals"] = true,
	["(.+) begins to cast (.+)."] = true,
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = true,
	["^Corpse of (.+)$"] = true,
	
	--}}}
	--{{{ GridStatusHealth
	["Unit health"] = true,
	["Health deficit"] = true,
	["Low HP warning"] = true,
	["Death warning"] = true,
	["Offline warning"] = true,
	["Health"] = true,
	["Show dead as full health"] = true,
	["Treat dead units as being full health."] = true,
	["Use class color"] = true,
	["Color health based on class."] = true,
	["Health threshold"] = true,
	["Only show deficit above % damage."] = true,
	["Color deficit based on class."] = true,
	["Low HP threshold"] = true,
	["Set the HP % for the low HP warning."] = true,

	--}}}
	--{{{ GridStatusAuras
	["Debuff type: "] = true,
	["Poison"] = true,
	["Disease"] = true,
	["Magic"] = true,
	["Curse"] = true,
	["Add new Buff"] = true,
	["Adds a new buff to the status module"] = true,
	["Add new Debuff"] = true,
	["Adds a new debuff to the status module"] = true,
	["Delete (De)buff"] = true,
	["Deletes an existing debuff from the status module"] = true,
	["Remove %s from the menu"] = true,
	["Debuff: "] = true,
	["Buff: "] = true,

	--}}}
	
	--{{{ GridLayout
	["Layout"] = true,
	["Options for GridLayout."] = true,
	["Padding"] = true,
	["Adjust frame padding."] = true,
	["Spacing"] = true,
	["Adjust frame spacing."] = true,
	["Scale"] = true,
	["Adjust Grid scale."] = true,
	["Border"] = true,
	["Adjust border color and alpha."] = true,
	["Background"] = true,
	["Adjust background color and alpha."] = true,
	["Frame lock"] = true,
	["Locks/unlocks the grid for movement."] = true,
	["Horizontal groups"] = true,
	["Switch between horzontal/vertical groups."] = true,
	["Show Frame"] = true,
	["Sets when the Grid is visible: Choose 'always' or 'grouped'."] = true,
	["always"] = true,
	["grouped"] = true,
	["Show Party in Raid"] = true,
	["Show party/self as an extra group."] = true,
	["Raid Layout"] = true,
	["Select which raid layout to use."] = true,
	--}}}
	
	--{{{ GridLayoutLayouts
	["None"] = true,
	["By Group 40"] = true,
	["By Group 25"] = true,
	["By Group 20"] = true,
	["By Group 15"] = true,
	["By Group 10"] = true,
	["By Class"] = true,
	["Onyxia"] = true,
	
	--}}}
	
	--{{{ GridFrame
	["Center Text"] = true,
	["Border"] = true,
	["Health Bar"] = true,
	["Bottom Left Corner"] = true,
	["Bottom Right Corner"] = true,
	["Top Right Corner"] = true,
	["Top Left Corner"] = true,
	["Center Icon"] = true,
	["Frame"] = true,
	["Options for GridFrame."] = true,
	["Invert Bar Color"] = true,
	["Swap foreground/background colors on bars."] = true,
	--}}}
	
}

L:RegisterTranslations("enUS", function() return strings_enUS end)
