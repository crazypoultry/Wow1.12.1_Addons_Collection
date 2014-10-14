-- by Maia (obviously)

local L = AceLibrary("AceLocale-2.2"):new("Squishy")

L:RegisterTranslations("enUS", function() return {

	-- bindings
	["Target unit with highest priority"] = true,
	["Target unit with 2nd highest priority"] = true,
	["Target unit with 3rd highest priority"] = true,

	-- from combatlog
	["(.+) begins to cast (.+)."] = true,
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = true,
	
	-- options
	["Default"]     = true,
	["Smooth"]		= true,
	["Button"]		= true,
	["BantoBar"]	= true,
	["Charcoal"]	= true,
	["Otravi"]		= true,
	["Perl"]		= true,
	["Smudge"]		= true,
	
	["always"] = true,
	["grouped"] = true,
	
	["Frame options"] = true,
	["Show Border"] = true,
	["Shows/hides the frame border."] = true,
	["Show Header"] = true,
	["Shows/hides the frame header."] = true,
	["Scale"] = true,
	["Scales the Emergency Monitor."] = true,
	["Number of units"] = true,
	["Number of max visible units."] = true,
	["Frame lock"] = true,
	["Locks/unlocks the emergency monitor."] = true,
	["Show Frame"] = true,
	["Sets when the Squishy frame is visible: Choose 'always' or 'grouped'."] = true,
	["Pet support"] = true,
	["Toggles the display of pets in the emergency frame."] = true,
	
	["Unit options"] = true,
	["Alpha"] = true,
	["Changes background+border visibility"] = true,
	["Style"] = true,
	["Color bar either by health, class or use the CTRA style."] = true,
	["Health"] = true,
	["Class"] = true,
	["CTRA"] = true,
	["Texture"] = true,
	["Sets the bar texture. Choose 'Default', 'BantoBar', 'Button', 'Charcoal', 'Otravi', 'Perl', 'Smooth' or 'Smudge'."] = true,
	["Health deficit"] = true,
	["Toggles the display of health deficit in the emergency frame."] = true,
	["Unit bar height"] = true,
	["Unit bar width"] = true,
	["Bar Spacing"] = true,
	["Change the spacing between bars"] = true,
	["Inside Bar"] = true,
	["Outside Bar"] = true,
	["Name position inside bar"] = true,
	["Show name position inside bar"] = true,
	["Class colored name"] = true,
	["Color names by class"] = true,
	
	["Class options"] = true,
	
	["Various options"] = true,
	["Audio alert on aggro"] = true,
	["Toggle on/off audio alert on aggro."] = true,
	["Log range"] = true,
	["Changes combat log range. Set it to your max healing range"] = true,
	["Version Query"] = true,
	["Checks the group for Squishy users and prints their version data."] = true,
	["Checking group for Squishy users, please wait."] = true,
	["using"] = true,
	
	-- notifications in frame
	[" is healing you."] = true,
	[" healing your group."] = true,
	[" died."] = true,
	
	-- frame header
	["Squishy Emergency"] = true,

	["Hide minimap icon"] = true,

	-- debuffs and other spell related locals
	["Mortal Strike"] = true,
	["Mortal Cleave"] = true,
	["Gehennas\' Curse"] = true,
	["Curse of the Deadwood"] = true,
	["Blood Fury"] = true,
	["Brood Affliction: Green"] = true,
	["Necrotic Poison"] = true,
	["Conflagration"] = true,
	["Petrification"] = true,
} end)
