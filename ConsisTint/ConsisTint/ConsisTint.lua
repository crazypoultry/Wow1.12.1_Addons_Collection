--[[
--
--	ConsisTint
--		Channel Color Saved by Name.
--
--	By Karl Isenberg (AnduinLothar)
--
--

local CONSISTINT_NAME 			= "ConsisTint"
local CONSISTINT_VERSION 		= 1.0
local CONSISTINT_LAST_UPDATED	= "August 1, 2006"
local CONSISTINT_AUTHOR 		= "AnduinLothar"
local CONSISTINT_EMAIL			= "karlkfi@cosmosui.org"
local CONSISTINT_WEBSITE		= "http://www.wowwiki.com/ConsisTint"

--]]

------------------------------------------------------------------------------
--[[ Frame Script Assignment ]]--
------------------------------------------------------------------------------

function ConsisTint_OnEvent()
	if (event == "UPDATE_CHAT_COLOR") then
		--[[
		arg1 - ChatType
		arg2 - r
		arg3 - g
		arg4 - b
		]]--
		if (arg1) then
			local number = string.gfind(arg1, "CHANNEL(%d+)")()
			if ( number ) then
				local _, name = GetChannelName(number);
				if ( name ) then
					local name, zoneSuffix = string.gfind(name, "(%w+)%s?(.*)")();
					if (not ConsisTint_Config) then
						ConsisTint_Config = {};
					end
					local color = ConsisTint_Config[name];
					if (not color) then
						ConsisTint_Config[name] = {r=arg2, g=arg3, b=arg4};
					else
						color.r=arg2;
						color.g=arg3;
						color.b=arg4;
					end
				end
			end
		end
	elseif (event == "CHAT_MSG_CHANNEL_NOTICE") then
		if (not strfind(arg4, "%d+%. .*")) then
			-- arg4 ex: 1. General - City
			-- YOU_LEFT, quickly followed by a YOU_CHANGED
			return;
		elseif (arg1 == "YOU_JOINED") then
			-- arg8 - channel number
			-- arg9 - name
			local name, zoneSuffix = string.gfind(arg9, "(%w+)%s?(.*)")();
			if (not ConsisTint_Config) then
				ConsisTint_Config = {};
			end
			local color = ConsisTint_Config[name];
			if (color) then
				ChangeChatColor("CHANNEL"..arg8, color.r, color.g, color.b);
			else
				color = ChatTypeInfo["CHANNEL"..arg8];
				ConsisTint_Config[name] = {r=color.r, g=color.g, b=color.b};
			end
		end
	end
end

--Event Driver
if (not ConsisTintFrame) then
	CreateFrame("Frame", "ConsisTintFrame");
end
ConsisTintFrame:Hide();
--Frame Scripts
ConsisTintFrame:SetScript("OnEvent", ConsisTint_OnEvent);
ConsisTintFrame:RegisterEvent("UPDATE_CHAT_COLOR");
ConsisTintFrame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	

