-- All Languages

ERRORREDIRECT_NAME = "Error Redirect";
ERRORREDIRECT_VERSION = "11000c";
ERRORREDIRECT_LOCALIZATION = GetLocale();
ERRORREDIRECT_PERFILTER = "PERFILTER";
ERRORREDIRECT_DISCARDFILTER = "";

ErrorRedirect_Colors = {
	["red"]    = {  a = 1.0, r = 1.0, g = 0.0, b = 0.0  },
	["green"]  = {  a = 1.0, r = 0.0, g = 1.0, b = 0.0  },
	["blue"]   = {  a = 1.0, r = 0.0, g = 0.0, b = 1.0  },
	["yellow"] = {  a = 1.0, r = 1.0, g = 1.0, b = 0.0  },
	["white"]  = {  a = 1.0, r = 1.0, g = 1.0, b = 1.0  },
	["black"]  = {  a = 1.0, r = 0.0, g = 0.0, b = 0.0  },
	["purple"] = {  a = 1.0, r = 1.0, g = 0.0, b = 1.0  },
	["gray"]   = {  a = 1.0, r = 0.7, g = 0.7, b = 0.7  },
	["orange"] = {  a = 1.0, r = 1.0, g = 0.4, b = 0.2  },
	--add your own colors here
};

ErrorRedirect_Filter_FixedErrorMessages = {
	-- Add here your filter strings which are displayed by other addons
	-- Every line has to be terminated by a comma
	-- eg:
	-- ["Flexbar settings loading"] = { true, "red" },

	-- Add here your filter strings for ERROR Message (these are the red ones)
	-- Add here your filter strings for INFO Messages (these are the yellow ones)
	-- Every line has to be terminated by a comma
	-- schema: [<Name from Globalstrings.lua>] = { active, color, frame },
	--   active is a boolean value, true or false only, required
	--   color is a value from the color list above, required
	--   frame is ChatFrameX where X is 1 thru 7, optional

	[CANT_USE_ITEM] = { true, "red" },
	[ERR_2HANDED_EQUIPPED] = { true, "red" },
	[ERR_ABILITY_COOLDOWN] = { true, "red" },            -- "Ability is not ready yet."
	[ERR_ATTACK_CHARMED] = { true, "red" },              -- "Can't attack while charmed."
	[ERR_ATTACK_DEAD] = { true, "red" },                 -- "Can't attack while dead."
	[ERR_ATTACK_FLEEING] = { true, "red" },              -- "Can't attack while fleeing."
	[ERR_ATTACK_MOUNTED] = { true, "red" },
	[ERR_ATTACK_PACIFIED] = { true, "red" },             -- "Can't attack while pacified."
	[ERR_ATTACK_STUNNED] = { true, "red" },              -- "Can't attack while stunned."
	[ERR_AUTOFOLLOW_TOO_FAR] = { true, "red" },          -- "Target is too far away."
	[ERR_BADATTACKFACING] = { true, "red" },             -- "You are facing the wrong way!"; -- Melee combat error
	[ERR_BADATTACKPOS] = { true, "red" },                -- "You are too far away!"; -- Melee combat error
	[ERR_CANTATTACK_NOTSTANDING]= { true, "red" },       -- "You have to be standing to attack anything!"
	[ERR_CANT_INTERACT_SHAPESHIFTED] = { true, "red" },  -- "Can't speak while shapeshifted."
	[ERR_CHEST_IN_USE] = { true, "yellow" },
	[ERR_CLIENT_LOCKED_OUT] = { true, "red" },
	[ERR_DUEL_CANCELLED] = { true, "yellow" },
	[ERR_EXHAUSTION_WELLRESTED] = { true, "yellow" },	-- "You feel well reseted."
	[ERR_FISH_ESCAPED] = { true, "yellow" },			-- "Your fish got away!"
	[ERR_FISH_NOT_HOOKED] = { true, "yellow" },			-- "No fish are hooked."
	[ERR_GENERIC_NO_TARGET] = { true, "red" },           -- "You have no target."
	[ERR_INV_FULL] = { true, "red" },                    -- "Inventory is full."
	[ERR_INVALID_ATTACK_TARGET] = { true, "red" },       -- "You cannot attack that target."
	[ERR_INVALID_FOLLOW_TARGET] = { true, "red" },       -- "You can't follow that unit."
	[ERR_INVALID_PROMOTION_CODE] = { true, "red" },
	[ERR_ITEM_COOLDOWN] = { true, "red" },
	[ERR_ITEM_MAX_COUNT] = { true, "red" },
	[ERR_LOOT_BAD_FACING] = { true, "red" },             -- "You must be facing the corpse to loot it."
	[ERR_LOOT_DIDNT_KILL] = { true, "red" },             -- "You don't have permission to loot that corpse."
	[ERR_LOOT_GONE] = { true, "red" },                   -- "Already looted"
	[ERR_LOOT_LOCKED] = { true, "red" },                 -- "Someone is already looting that corpse."
	[ERR_LOOT_NOTSTANDING] = { true, "red" },            -- "You need to be standing up to loot something!"
	[ERR_LOOT_NO_UI] = { true, "red" },                  -- "You can't loot right now."
	[ERR_LOOT_ROLL_PENDING] = { true, "red" },
	[ERR_LOOT_STUNNED] = { true, "red" },                -- "You can't loot anything while stunned!"
	[ERR_LOOT_TOO_FAR] = { true, "red" },                -- "You are too far away to loot that corpse."
	[ERR_LOOT_WHILE_INVULNERABLE] = { true, "red" },     -- "Cannot loot while invulnerable."
	[ERR_MAIL_DATABASE_ERROR] = { true, "red" },         -- "Internal mail database error."
	[ERR_MAIL_SENT] = { true, "yellow" },
	[ERR_NEWTAXIPATH] = { true, "green" },
	[ERR_NO_ATTACK_TARGET] = { true, "red" },            -- "There is nothing to attack."
	[ERR_NOT_EQUIPPABLE] = { true, "red" },
	[ERR_NOT_ENOUGH_MONEY] = { true, "red" },            -- "You don't have enough money."
	[ERR_NOT_WHILE_SHAPESHIFTED] = { true, "red" },
	[ERR_OBJECT_IS_BUSY] = { true, "red" },
	[ERR_OUT_OF_ENERGY] = { true, "red" },               -- "Not enough energy."
	[ERR_OUT_OF_FOCUS] = { true, "red" },                -- "Not enough focus."
	[ERR_OUT_OF_HEALTH] = { true, "red" },               -- "Not enough health."
	[ERR_OUT_OF_MANA] = { true, "red" },                 -- "Not enough mana."
	[ERR_OUT_OF_RAGE] = { true, "red" },                 -- "Not enough rage."
	[ERR_OUT_OF_RANGE] = { true, "red" },                -- "Out of range."
	[ERR_PET_SPELL_DEAD] = { true, "red" },              -- "Your pet is dead."
	[ERR_PLAYER_DEAD] = { true, "red" },
	[ERR_POTION_COOLDOWN] = { true, "red" },
	[ERR_PROFICIENCY_NEEDED] = { true, "red" },
	[ERR_QUEST_LOG_FULL] = { true, "red" },
	[ERR_SPELL_COOLDOWN] = { true, "red" },              -- "Spell is not ready yet."
	[ERR_SPELL_FAILED_ALREADY_AT_FULL_HEALTH] = { true, "yellow" },
	[ERR_TRADE_CANCELLED] = { true, "yellow" },
	[ERR_TRADE_COMPLETE] = { true, "yellow" },
	[ERR_TRADE_TARGET_MAX_COUNT_EXCEEDED] = { true, "red" },
	[ERR_USE_TOO_FAR] = { true, "red" },
	[ERR_VENDOR_NOT_INTERESTED] = { true, "yellow" },
	[ERR_VENDOR_TOO_FAR] = { true, "red" },
	[PET_SPELL_NOPATH] = { true, "red" },
	[PETTAME_DEAD] = { true, "red" },                    -- "Your pet is dead"
	[PETTAME_NOPETAVAILABLE] = { true, "red" },
	[PETTAME_NOTDEAD] = { true, "red" },                 -- "Your pet is not dead"
	[SPELL_FAILED_AFFECTING_COMBAT] = { true, "red" },   -- "You are in combat"
	[SPELL_FAILED_AURA_BOUNCED] = { true, "red" },
	[SPELL_FAILED_BAD_TARGETS] = { true, "red" },        -- "Bad target."
	[SPELL_FAILED_CASTER_AURASTATE] = { true, "red" },   -- "You can't do that yet"
	[SPELL_FAILED_CASTER_DEAD] = { true, "red" },        -- "You are dead"
	[SPELL_FAILED_CHEST_IN_USE] = { true, "yellow" },
	[SPELL_FAILED_INTERRUPTED] = { true, "red" },        -- "Interrupted"
	[SPELL_FAILED_INTERRUPTED_COMBAT] = { true, "red" }, -- "Interrupted"
	[SPELL_FAILED_ITEM_NOT_READY] = { true, "red" },
	[SPELL_FAILED_LINE_OF_SIGHT] = { true, "red" },
	[SPELL_FAILED_MOVING] = { true, "red" },             -- "Can't do that while moving"
	[SPELL_FAILED_NO_COMBO_POINTS] = { true, "red" },    -- "That ability requires combo points"
	[SPELL_FAILED_NO_ITEMS_WHILE_SHAPESHIFTED] = { true, "red" },
	[SPELL_FAILED_NO_MOUNTS_ALLOWED] = { true, "red" },
	[SPELL_FAILED_NO_PET] = { true, "red" },
	[SPELL_FAILED_NOPATH] = { true, "red" },
	[SPELL_FAILED_NOT_BEHIND] = { true, "red" },
	[SPELL_FAILED_NOT_MOUNTED] = { true, "red" },        -- "Cannot use while mounted"
	[SPELL_FAILED_NOT_SHAPESHIFT] = { true, "red" },
	[SPELL_FAILED_NOT_STANDING] = { true, "red" },       -- "You have to be standing to do that"
	[SPELL_FAILED_ONLY_STEALTHED] = { true, "red" },     -- "You must be in stealth mode"
	[SPELL_FAILED_OUT_OF_RANGE] = { true, "red" },       -- "Out of range"
	[SPELL_FAILED_SPELL_IN_PROGRESS] = { true, "red" },  -- "Another action is in progress"
	[SPELL_FAILED_STUNNED] = { true, "red" },            -- "Can't do that while stunned"
	[SPELL_FAILED_TARGET_AURASTATE] = { true, "red" },   -- "You can't do that yet"
	[SPELL_FAILED_TARGET_NOT_IN_INSTANCE] = { true, "red" },
	[SPELL_FAILED_TARGET_NOT_IN_PARTY] = { true, "red" },
	[SPELL_FAILED_TARGET_NOT_IN_RAID] = { true, "red" },
	[SPELL_FAILED_TARGET_NO_POCKETS] = { true, "red" },
	[SPELL_FAILED_TARGET_NO_WEAPONS] = { true, "red" },
	[SPELL_FAILED_TARGETS_DEAD] = { true, "red" },       -- "Your target is dead"
	[SPELL_FAILED_TOO_CLOSE] = { true, "red" },          -- "Target to close."
	[SPELL_FAILED_TOO_MANY_OF_ITEM] = { true, "red" },
	[SPELL_FAILED_TRY_AGAIN] = { true, "red" },
	[SPELL_FAILED_UNIT_NOT_INFRONT] = { true, "red" },   -- "Target needs to be in front of you"
	[SPELL_FAILED_WRONG_PET_FOOD] = { true, "red" },
};

if( ERRORREDIRECT_LOCALIZATION == "deDE" ) then
	--
	-- German
	--

	ERRORREDIRECT_MYADDONS_RELEASEDATE = "M\195\164rz 23, 2006";

	ERRORREDIRECT_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/error_redirect" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Konfigurationsdialog anzeigen.\nLeitet einige der großen roten Fehlermeldungen in das Kampflog um.\nDer Bildschirm bleibt frei für die wirklich wichtigen Nachrichten.";

	ERRORREDIRECT_COMBOTEXT = { "Deaktivert", "Aktiviert, keine Umleitung", "Enable, no redirect", "Aktiviert, Umleitung nach Allgemein", "Aktiviert, Umleitung ins Kampflog" }
	ERRORREDIRECT_CUSTOMCOLOR = "Eigene Farben f\195\188r Nachrichten aktivieren";
	ERRORREDIRECT_SUPPRESSNIL = "Programmfehler umleiten";

	ERRORREDIRECT_ACTIVE  = "Active";
	ERRORREDIRECT_DISCARD = "Discard";
	ERRORREDIRECT_DEFAULT = "Default";
	ERRORREDIRECT_NOREDIRECT = "No Redirect";

	ErrorRedirect_Filter_PartialErrorMessages = {
		-- Add here your filter strings for ERROR Message (these are the red ones)
		-- Every line has to be terminated by a comma
		-- use the following scheme (without the two dashes):
		-- ["irgendwas"] = { true, "red" },
	};
elseif( ERRORREDIRECT_LOCALIZATION == "frFR" ) then
	--
	-- French
	--

	ERRORREDIRECT_MYADDONS_RELEASEDATE = "March 23, 2006";

	ERRORREDIRECT_CHATHELP1 = "Error Redirect\nError Redirect filters some of this big red\nmessages into the selected chat frame instead of\ncluttering your screen.  Now your screen keeps clear\nfor the real important messages.\nFirst argument [list] can be fixed or partial only.\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  options" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Change setup.\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] add [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Adds [filter] to [list] with default options.\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] delete [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Deletes [filter] from [list].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] find [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Displays info about [filter].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] toggle [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Toggles active status of [filter].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] color [filter] [color]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Sets [filter] to display in [color].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] reset" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Resets [list] to defaults.";

	ERRORREDIRECT_COMBOTEXT = { "Disable", "Enable, discard", "Enable, no redirect", "Enable, redirect to general log", "Enable, redirect to combat log" }
	ERRORREDIRECT_CUSTOMCOLOR = "Enable individual message color";
	ERRORREDIRECT_SUPPRESSNIL = "Redirect program errors to";

	ERRORREDIRECT_ACTIVE  = "Active";
	ERRORREDIRECT_DISCARD = "Discard";
	ERRORREDIRECT_DEFAULT = "Default";
	ERRORREDIRECT_NOREDIRECT = "No Redirect";

	ErrorRedirect_Filter_PartialErrorMessages = {
		-- Add here your filter strings for ERROR Message (these are the red ones)
		-- Every line has to be terminated by a comma
		-- use the following scheme (without the two dashes):
		-- ["french word"] = { true, "red" },
		-- ["french word2"] = { true, "red" },
	};
else
	--
	-- English
	--

	ERRORREDIRECT_MYADDONS_RELEASEDATE = "May 09, 2006";

	ERRORREDIRECT_CHATHELP1 = "Error Redirect\n" .. ERRORREDIRECT_MYADDONS_RELEASEDATE .. " " .. ERRORREDIRECT_LOCALIZATION .. "\n\nError Redirect filters some of this big red\nmessages into the selected chat frame instead of\ncluttering your screen.  Now your screen keeps clear\nfor the real important messages.\nFirst argument [list] can be fixed or partial only.\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  options" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Change setup.\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] add [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Adds [filter] to [list] with default options.\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] delete [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Deletes [filter] from [list].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] find [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Displays info about [filter].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] toggle [filter]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Toggles active status of [filter].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] color [filter] [color]" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Sets [filter] to display in [color].\n" .. HIGHLIGHT_FONT_COLOR_CODE .. "  [list] reset" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Resets [list] to defaults.";

	ERRORREDIRECT_COMBOTEXT = { "Disable", "Enable, discard", "Enable, no redirect", "Enable, redirect to general log", "Enable, redirect to combat log" }
	ERRORREDIRECT_CUSTOMCOLOR = "Enable individual message color";
	ERRORREDIRECT_SUPPRESSNIL = "Redirect program errors to";

	ERRORREDIRECT_ACTIVE  = "Active";
	ERRORREDIRECT_DISCARD = "Discard";
	ERRORREDIRECT_DEFAULT = "Default";
	ERRORREDIRECT_NOREDIRECT = "No Redirect";

	ErrorRedirect_Filter_PartialErrorMessages = {
		-- Add here your filter strings for ERROR Message (these are the red ones)
		-- Every line has to be terminated by a comma
		-- use the following scheme (without the first two dashes):
		-- ["cast failed"] = { true, "red" }, -- just an example line
		-- ["range"] = { true, "red" }, -- just an example line

		["equipped"] = { true, "purple" },
		["Requires"] = { true, "red" },

		-- Add here your filter strings for INFO Messages (these are the yellow ones)
		-- Every line has to be terminated by a comma
	};
end
