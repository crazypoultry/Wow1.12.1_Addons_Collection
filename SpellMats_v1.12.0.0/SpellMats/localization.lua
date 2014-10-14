--------------------------------------------------
-- localization.lua (English)
--------------------------------------------------

SPELLMATS_CONFIG_HEADER = "Spell Mats";
SPELLMATS_CONFIG_HEADER_INFO = "Displays on action bar how many times a spell that requires reagents can be cast before reagents run out. Type /spellmats for more options";
SPELLMATS_TOGGLE_INFO = "Enable Spell Mats addon";
SPELLMATS_FASTUPDATE = "Fast Update";
SPELLMATS_FASTUPDATE_INFO = "Please read spellmats/readme.txt on this option description and enable in it *only* when you did.";

SpellMats_PrintChatCommandHelp = function()
	local cc = HIGHLIGHT_FONT_COLOR_CODE;
	local ct = FONT_COLOR_CODE_CLOSE;
	local yl = LIGHTYELLOW_FONT_COLOR_CODE;
	DEFAULT_CHAT_FRAME:AddMessage(cc .. "/sm or /spellmats" .. ct .. yl .. " - Displays this help. Please read readme.txt for more details" .. ct);
	DEFAULT_CHAT_FRAME:AddMessage(cc .. "/smt or /smtoggle on|off" .. ct .. yl .. " - Turns SpellMats addon on or off. Please note that on or off command line parameter is mandatory" .. ct);
	DEFAULT_CHAT_FRAME:AddMessage(cc .. "/sml or /smlimits reagent yellow red" .. ct .. yl .. " - Set limits for a given reagent when this reagent count turns red or yellow" .. ct);
	DEFAULT_CHAT_FRAME:AddMessage(yl .. "For example /sml [Shiny Fish Scales] 10 5 will dislpay the count in white when it's more then 10, in yellow if it's between 10 and 5 and in red when it's 5 or less" .. ct);
	DEFAULT_CHAT_FRAME:AddMessage(yl .. "The reagent name should be in square brackets or be an item link" .. ct);
	DEFAULT_CHAT_FRAME:AddMessage(yl .. "/sml without parameters will print out current limits" .. ct);
	DEFAULT_CHAT_FRAME:AddMessage(cc .. "/smf or /smfastupdate on|off" .. ct .. yl .. " - Turns the Fast Update Mode on or off. Please read readme.txt and use it only after you fully understood what it does" .. ct);
end

SpellMats_ReagentNotFoundMessage = function(reagent)
	local ct = FONT_COLOR_CODE_CLOSE;
	local rd = RED_FONT_COLOR_CODE;
	DEFAULT_CHAT_FRAME:AddMessage(rd .. "Reagent [" .. reagent .. "] not found. Drag a spell that uses this reagent to an action bar first." .. ct);
end

SpellMats_ReagentLimitsMessage = function(reagent, yellow, red)
	local ct = FONT_COLOR_CODE_CLOSE;
	local yl = LIGHTYELLOW_FONT_COLOR_CODE;
	local rd = RED_FONT_COLOR_CODE;
	DEFAULT_CHAT_FRAME:AddMessage("Reagent [" .. reagent .. "]: Yellow: " .. yl .. yellow .. ct .. " Red: " .. rd .. red  .. ct);
end

SpellMats_PrintStatus = function(setting, enabled)
	local cc = HIGHLIGHT_FONT_COLOR_CODE;
	local ct = FONT_COLOR_CODE_CLOSE;
	local yl = LIGHTYELLOW_FONT_COLOR_CODE;
	if (enabled) then
		DEFAULT_CHAT_FRAME:AddMessage(cc .. setting .. " is " .. ct .. yl .. "on" .. ct);
	else
		DEFAULT_CHAT_FRAME:AddMessage(cc .. setting .. " is " .. ct .. yl .. "off" .. ct);
	end
end
