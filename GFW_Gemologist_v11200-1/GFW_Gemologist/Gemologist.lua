------------------------------------------------------
-- Gemologist.lua
------------------------------------------------------
FGO_VERSION = "11200.1";
------------------------------------------------------

FGO_INDENT = "  ";

-- Configuration
FGO_Config = { };
FGO_Config.Tooltip = true;
FGO_Config.ShowCost = false;

local function FGO_Tooltip_Hook(frame, name, link, source)

	if ( FGO_Config.Tooltip and link ~= nil) then
		local _, _, itemID  = string.find(link, "item:(%d+):%d+:%d+:%d+");
		itemID = tonumber(itemID);
		local itemInfo = FGO_ItemInfo[itemID];

		if (itemInfo ~= nil) then
			local color = GFW_FONT_COLOR;
			local localizedSources = {};
			for _, source in itemInfo do
				table.insert(localizedSources, getglobal(source));
			end
			if (table.getn(localizedSources) == 0) then
				GFWUtils.DebugLog(link.." listed but missing sources.");
				return false;
			elseif (table.getn(localizedSources) == 1) then
				frame:AddLine(string.format(FGO_FOUND_ONLY_IN_FORMAT, localizedSources[1]), color.r, color.g, color.b);
				return true;
			else
				frame:AddLine(FGO_FOUND_IN_HEADER, color.r, color.g, color.b);
				frame:AddLine(table.concat(localizedSources, ", "), color.r, color.g, color.b);
				return true;
			end
		end
	end
	
end

function FGO_OnLoad()

	-- Register Slash Commands
	SLASH_FGO1 = "/gemologist";
	SLASH_FGO2 = "/gems";
	SlashCmdList["FGO"] = function(msg)
		FGO_ChatCommandHandler(msg);
	end
	
	GFWTooltip_AddCallback("GFW_Gemologist", FGO_Tooltip_Hook);

	GFWUtils.Print("Fizzwidget Gemologist "..FGO_VERSION.." initialized!");
end

function FGO_ChatCommandHandler(msg)

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Gemologist "..FGO_VERSION..":");
		GFWUtils.Print("/gemologist (or /gems)");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("status").." - Check current settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("tooltip on").." | "..GFWUtils.Hilite("off").." - Enable/disable display of mining info in gem tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("info <item link>").." - Show mining info for a gem in the chat window.");
		return;
	end
	
	if (msg == "version") then
		GFWUtils.Print("Fizzwidget Gemologist "..FGO_VERSION);
		return;
	end
	
	if (msg == "tooltip on") then
		FGO_Config.Tooltip = true;
		GFWUtils.Print("Showing mining information in tooltips for gems.");
		return;
	end
	if (msg == "tooltip off") then
		FGO_Config.Tooltip = false;
		GFWUtils.Print(GFWUtils.Hilite("Not").." showing mining information in tooltips for gems.");
		return;
	end
	
	
	if ( msg == "status" ) then
		if ( FGO_Config.Tooltip ) then
			GFWUtils.Print("Showing mining information in tooltips for gems.");
		else
			GFWUtils.Print(GFWUtils.Hilite("Not").." showing mining information in tooltips for gems.");
		end
		return;
	end
	
	local _, _, cmd, itemLink = string.find(msg, "(%w+) (.+)");
	if (cmd == "info") then
		local _, _, itemID  = string.find(itemLink, ".Hitem:(%d+):%d+:%d+:%d+.h%[[^]]+%].h");
		if (itemID == nil or itemID == "") then
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/gem info <item link>"));
			return;
		end
		itemID = tonumber(itemID);
		
		local itemInfo = FGO_ItemInfo[itemID];
		if (itemInfo ~= nil) then
			local localizedSources = {};
			for _, source in itemInfo do
				table.insert(localizedSources, getglobal(source));
			end
			if (table.getn(localizedSources) == 0) then
				GFWUtils.DebugLog(itemLink.." is listed but missing sources.");
				return false;
			elseif (table.getn(localizedSources) == 1) then
				GFWUtils.Print(string.format(FGO_LINK_FOUND_ONLY_IN_FORMAT, itemLink, localizedSources[1]));
				return true;
			else
				GFWUtils.Print(string.format(FGO_LINK_FOUND_IN_HEADER_FORMAT, itemLink));
				GFWUtils.Print(table.concat(localizedSources, ", "));
				return true;
			end
		end

		GFWUtils.Print("Nothing known about "..itemLink..".");
		return;
	end
	
	-- if we made it down here, there were args we didn't understand... time to remind the user what to do.
	FGO_ChatCommandHandler("help");

end

------------------------------------------------------
-- Runtime loading
------------------------------------------------------

FGO_OnLoad();