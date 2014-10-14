--[[

Options.lua

This file contains all the options and the slash command handler

]]

-- Function: Slashcommand handler
function EFM_SlashCommandHandler(msg)
	if (msg == '') then msg = nil end

	if (msg) then
		--msg = string.lower(msg);
		local msgLower = string.lower(msg);
		
		if (msgLower == EFM_CMD_CLEAR) then
			DEFAULT_CHAT_FRAME:AddMessage(EFM_CLEAR_HELP, 0.2, 1.0, 0.2);
			return;

		elseif (msgLower == EFM_CMD_CLEAR_ALL) then
			EFM_Data_ClearAll();
			return;

		elseif (string.find(msgLower, EFM_CMD_CLEAR) ~= nil) then
			value = EFM_SF_SlashClean(EFM_CMD_CLEAR, msg);
			value = string.lower(value);
			if (value == string.lower(FACTION_ALLIANCE)) then
				EFM_Data_Clear("Alliance");
			elseif (value == string.lower(FACTION_HORDE)) then
				EFM_Data_Clear("Horde");
			end
			return;

		-- Flight map when not at the flight master....
		elseif (msgLower == EFM_CMD_MAP) then
			EFM_FM_TaxiMapRemote(EFM_FMCMD_CURRENT);
			return;

		elseif (string.find(msgLower, EFM_CMD_MAP) ~= nil) then
			value = EFM_SF_SlashClean(EFM_CMD_MAP, msg);
			if ((value == EFM_FMCMD_KALIMDOR) or (value == EFM_FMCMD_AZEROTH)) then
				EFM_FM_TaxiMapRemote(value);
				return;
			end

--[[
		-- Delete a single flight node...
		elseif (string.find(msgLower, EFM_CMD_DELETENODE) ~= nil) then		
			value = EFM_SF_SlashClean(EFM_CMD_DELETENODE, msg);
			EFM_Clear_FlightNode(value);
			return;
]]
		-- Options screen details
		elseif (msgLower == EFM_CMD_GUI) then		
			EFM_GUI_Toggle();
			return;

		-- Report on flight times
		elseif (string.find(msgLower, EFM_CMD_REPORT)) then
			value = EFM_SF_SlashClean(EFM_CMD_REPORT, msg);
			EFM_Report_Flight(value);
			return;

		end
	end
	
	-- Display help when all else fails...
	local index = 0;
	local value = getglobal("EFM_HELP_TEXT"..index);
	while( value ) do
		DEFAULT_CHAT_FRAME:AddMessage(value, 0.2, 1.0, 0.2);
		index = index + 1;
		value = getglobal("EFM_HELP_TEXT"..index);
	end
end
