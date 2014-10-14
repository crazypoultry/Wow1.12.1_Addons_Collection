-------------------------------------------------------------------
-- Killing Blows addon for Scrolling Combat Text
-- by Robert Sinton (Makari)
-- This addon WILL NOT work with versions of SCT before v5.0
-------------------------------------------------------------------

if ((SCT) and (ParserLib)) then

-- You can edit the following if you wish to change the where SCT displays Killing Blow messages
SCT_KillingBlows_Option = {
	['display'] = 3;
};

-------------------------------------------------------------------
-- DO NOT EDIT FROM HERE DOWN
-------------------------------------------------------------------

local locale = GetLocale();
local KILLED = "You killed %s";
if (locale == "deDE") then KILLED = "Sie toteten %s"; end -- German
if (locale == "frFR") then KILLED = "Vous avez tue %s"; end -- French
if (locale == "spSP") then KILLED = "Usted mato a %s"; end -- Spanish

local parser = ParserLib:GetInstance("1.1")
local battleground = {
	["Alterac Valley"] = true,
	["Arathi Basin"] = true,
	["Warsong Gulch"] = true,
}

function SCT_KillingBlows_OnLoad()
	local addon = "sct_killingblows";
	local title = GetAddOnMetadata(addon, "TITLE");
	local version = GetAddOnMetadata(addon, "VERSION");
	local author = GetAddOnMetadata(addon, "AUTHOR");
	DEFAULT_CHAT_FRAME:AddMessage(title .. " v" .. version .. " by " .. author);
	parser:RegisterEvent("sct_killingblows", "CHAT_MSG_COMBAT_HOSTILE_DEATH", SCT_KillingBlows_ParseCombat);
end

function SCT_KillingBlows_ParseCombat()
	local info = parser.info;
	local option = SCT_KillingBlows_Option;
	local zone = GetRealZoneText();
	local registered = SCT:IsEventRegistered("COMBAT_TEXT_UPDATE");
	if ((registered) and (battleground[zone]) and (info.type == "death") and (info.source == 103)) then
		local msg = string.format(KILLED, info.victim);
		local rgbcolor = {r=1, g=0, b=0};
		if (option.display == 1) then
			SCT:DisplayText(msg, rgbcolor, true, "event", SCT.FRAME1);
		elseif (option.display == 2) then
			SCT:DisplayText(msg, rgbcolor, true, "event", SCT.FRAME2);
		else
			SCT:DisplayMessage(msg, rgbcolor);
		end
	end
end

end