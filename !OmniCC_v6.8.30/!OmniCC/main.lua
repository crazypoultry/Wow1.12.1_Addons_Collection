--[[
	Omni Cooldown Count
		A universal cooldown count, based on Gello's spec
--]]

local function PrintMsg(message)
	DEFAULT_CHAT_FRAME:AddMessage(message or "error");
end

--[[ Variable Loading ]]--

local function LoadDefaults(currentVersion)
	OmniCC = {
		min = 3, --minimum duration to show text
		font = STANDARD_TEXT_FONT, --cooldown text font; ClearFont loads before OmniCC and will be used if its there.
		size = 20, --cooldown text size
		vlong = {r = 0.8, g = 0.8, b = 0.9, s = 0.6}, --settings for cooldowns greater than an hour
		long = {r = 0.8, g = 0.8, b = 0.9, s = 0.8}, --settings for cooldowns greater than one minute
		medium = {r = 1, g = 1, b = 0.4, s = 1}, --settings for cooldowns under a minute
		short = {r = 1, g = 0, b = 0, s = 1.3}, --settings for cooldowns less than five seconds
		shine = nil,
		shineScale = 4,
		version = currentVersion,
	}
	PrintMsg("OmniCC: Default Settings Loaded.");
end

local function LoadVariables()
	local version = GetAddOnMetadata("!OmniCC", "Version");
	
	if not(OmniCC and OmniCC.version) then
		LoadDefaults(version);
	elseif OmniCC.version ~= version then
		OmniCC.version = version;
		PrintMsg("OmniCC: Updated to v" .. OmniCC.version);
	end
	
	--this font is created solely for testing if the user's selection is a valid font or not.
	if not OmniCCFont then
		CreateFont("OmniCCFont");
		if not OmniCCFont:SetFont(OmniCC.font, OmniCC.size) then
			PrintMsg("OmniCC: Saved font is invalid. Reverting to default font.")			
			OmniCC.font = STANDARD_TEXT_FONT;
			if not OmniCCFont:SetFont(OmniCC.font, OmniCC.size) then
				OmniCC.font = "Fonts\\FRIZQT__.TTF";
			end
		end
	end
end

--[[ Slash Command Handler ]]--

local function PrintCommands()
	PrintMsg("OmniCC Commands:");
	PrintMsg("/omnicc size <value> - Set font size.  20 is default.");
	PrintMsg("/omnicc font <value> - Set the font to use.  " .. STANDARD_TEXT_FONT .. " is default.");
	PrintMsg("/omnicc color <duration> <red> <green> <blue> - Set the color to use for cooldowns of <duration>.  Duration can be vlong, long, medium or short.");
	PrintMsg("/omnicc scale <duration> <value> - Set the scale to use for cooldowns of <duration>.  Duration can be vlong, long, medium or short.");
	PrintMsg("/omnicc min <value> - Set the minimum duration (seconds) a cooldown should be to show text.  Default value of 3.");
	PrintMsg("/omnicc model - Toggles the cooldown model");
	PrintMsg("/omnicc shine - Toggles a brighter flash on finished cooldowns");
	PrintMsg("/omnicc shinescale <value> - Sets how big the bright cooldown flash is.  4 is default");
	PrintMsg("/omnicc reset - Go back to default settings.");
end

SlashCmdList["OmniCCCOMMAND"] = function(msg)
	if not msg or msg == "" or msg == "help" or msg == "?" then
		PrintCommands();
	else
		local args = {};
		for word in string.gfind(msg, "[^%s]+") do
			table.insert(args, word);
		end
		cmd = string.lower(args[1]);
		
		--/omnicc size <size>
		if cmd == "size" then
			if(tonumber(args[2]) and tonumber(args[2]) > 0) then
				OmniCC.size = tonumber(args[2]);
			else
				PrintMsg("OmniCC: Invalid font size.");
			end
		--/omnicc font <font>
		elseif cmd == "font" then
			if args[2] then	
				if OmniCCFont:SetFont(args[2], OmniCC.size) then
					OmniCC.font = args[2];
					PrintMsg("OmniCC: Set font to " .. OmniCC.font);
				else
					PrintMsg(args[2] .. " is an invalid font.  Using previous selection.");
				end
			end
		--/omnicc min <size>
		elseif cmd == "min" then
			if tonumber(args[2]) then
				OmniCC.min  = tonumber(args[2]);
			end
		elseif cmd == "model" then
			if OmniCC.hideModel then
				OmniCC.hideModel = nil;
				PrintMsg("OmniCC: Now showing cooldown models.");
			else
				OmniCC.hideModel = 1;
				PrintMsg("OmniCC: Now hiding cooldown models.");
			end
		elseif cmd == "color" then
			if args[2] and tonumber(args[3]) and tonumber(args[4]) and tonumber(args[5]) then
				local index = string.lower(args[2]);
				if index == "vlong" or index == "long" or index == "short" or index == "medium" then
					OmniCC[index].r = tonumber(args[3]);
					OmniCC[index].g = tonumber(args[4]);
					OmniCC[index].b = tonumber(args[5]);
				end
			end
		elseif cmd == "scale" then
			if args[2] and tonumber(args[3]) then
				local index = string.lower(args[2]);
				if index == "vlong" or index == "long" or index == "short" or index == "medium" then
					OmniCC[index].s = tonumber(args[3]);
				end
			end
		elseif cmd == "shine" then
			if OmniCC.shine then
				OmniCC.shine = nil;
				PrintMsg("OmniCC: Disabled bright cooldown shines.");
			else
				OmniCC.shine = 1;
				PrintMsg("OmniCC: Now shining brightly.");
			end
		elseif cmd == "shinescale" then
			if args[2] and tonumber(args[2]) then
				OmniCC.shineScale = tonumber(args[2]);
			end
		elseif cmd == "reset" then
			LoadDefaults();
		end
	end
end
SLASH_OmniCCCOMMAND1 = "/omnicc";

--[[ Event Handler ]]--

CreateFrame("Frame", "OmniCCMain");
OmniCCMain:SetScript("OnEvent", function()
	if arg1 == "!OmniCC" then
		OmniCCMain:UnregisterEvent("ADDON_LOADED");
		LoadVariables();
	end
end);
OmniCCMain:RegisterEvent("ADDON_LOADED");