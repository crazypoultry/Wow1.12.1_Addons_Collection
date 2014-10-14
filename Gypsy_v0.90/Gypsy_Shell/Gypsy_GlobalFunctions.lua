--[[
	Gypsy_GlobalFunctions.lua
	GypsyVersion++2004.11.07++		
	
	Functions useful to any file, and debug functions.
]]

-- Print out a message prefixed by GypsyMsg to the default chat frame
function Gypsy_Print(msg, r, g, b)
	if(r == nil) then r = 1; end
	if(g == nil) then g = 1; end
	if(b == nil) then b = 1; end
	DEFAULT_CHAT_FRAME:AddMessage("GypsyMsg: " .. msg, r, g, b);
end

-- Printer for GypsyMod errors that don't need to break the interface or reference code
function Gypsy_Error(msg)
	DEFAULT_CHAT_FRAME:AddMessage("GypsyMod: "..msg, 1, 0.25, 0.25);
end

-- ** DEBUG FUNCTIONS ** --

-- Debug-specific printer
function Gypsy_DebugPrint (msg, r, g, b)
	if(r == nil) then r = 1; end
	if(g == nil) then g = 1; end
	if(b == nil) then b = 1; end
	DEFAULT_CHAT_FRAME:AddMessage(">]"..msg, r, g, b);
end

-- Print our entire registration table
function Gypsy_PrintAllRegistrations()
	local n = getn(GYPSY_REGISTRATIONS);
	for i=1, n do
		local id = GYPSY_REGISTRATIONS[i][GYPSY_ID];
		Gypsy_PrintRegistration(id);
	end
end

-- Print a registration at index 'i'
function Gypsy_PrintRegistration(i)
	if (Gypsy_RetrieveOption(i) ~= nil) then
		local id = Gypsy_RetrieveOption(i)[GYPSY_ID];
		local type = Gypsy_RetrieveOption(i)[GYPSY_TYPE];
		local value = Gypsy_RetrieveOption(i)[GYPSY_VALUE];
		local name = Gypsy_RetrieveOption(i)[GYPSY_NAME];
		local func = Gypsy_RetrieveOption(i)[GYPSY_FUNC];
		local label = Gypsy_RetrieveOption(i)[GYPSY_LABEL];
		local tooltip = Gypsy_RetrieveOption(i)[GYPSY_TOOLTIP];
		local slidermin = Gypsy_RetrieveOption(i)[GYPSY_SLIDMIN];
		local slidermax = Gypsy_RetrieveOption(i)[GYPSY_SLIDMAX];
		local sliderstep = Gypsy_RetrieveOption(i)[GYPSY_SLIDSTEP];
		local sliderunit = Gypsy_RetrieveOption(i)[GYPSY_SLIDUNIT];
		
									Gypsy_DebugPrint("GYPSY_REGISTRATIONS[".. i.."] = {");
									Gypsy_DebugPrint("   ["..GYPSY_ID.."] = "..id..",");
									Gypsy_DebugPrint("   ["..GYPSY_TYPE.."] = "..type..",");
		if (value ~= nil) then		Gypsy_DebugPrint("   ["..GYPSY_VALUE.."] = "..value..",");				end
		if (name ~= nil) then		Gypsy_DebugPrint("   ["..GYPSY_NAME.."] = "..name..",");				end
		if (func ~= nil) then		Gypsy_DebugPrint("   ["..GYPSY_FUNC.."] = NOT NIL,");					end
									Gypsy_DebugPrint("   ["..GYPSY_LABEL.."] = "..label..",");
		if (tooltip ~= nil) then	Gypsy_DebugPrint("   ["..GYPSY_TOOLTIP.."] = "..tooltip..",");			end
		if (slidermin ~= nil) then	Gypsy_DebugPrint("   ["..GYPSY_SLIDMIN.."] = "..slidermin..",");		end
		if (slidermax ~= nil) then	Gypsy_DebugPrint("   ["..GYPSY_SLIDMAX.."] = "..slidermax..",");		end
		if (sliderstep ~= nil) then	Gypsy_DebugPrint("   ["..GYPSY_SLIDSTEP.."] = "..sliderstep..",");		end
		if (sliderunit ~= nil) then	Gypsy_DebugPrint("   ["..GYPSY_SLIDUNIT.."] = "..sliderunit);			end
									Gypsy_DebugPrint("}");
	else
		Gypsy_DebugPrint('Nil argument');
	end
end

-- Print our entire saves array
function Gypsy_PrintAllSaves()
	Gypsy_DebugPrint("GYPSY_SAVED = {");
	local n = getn(GYPSY_REGISTRATIONS);
	for i=1, n do
		local id = GYPSY_REGISTRATIONS[i][GYPSY_ID];
		if (Gypsy_RetrieveOption(id)[GYPSY_NAME] ~= nil) then
			local name = Gypsy_RetrieveOption(id)[GYPSY_NAME];
			Gypsy_PrintSaved(name);
		end
	end
	Gypsy_DebugPrint("}");
end			

-- Print a saved value at 'name'
function Gypsy_PrintSaved(name)
	local value = GYPSY_SAVED[name];
	Gypsy_DebugPrint("   ["..name.."] = "..value..",");
end	

-- Function to print out memory used
function Gypsy_MemoryUsage()
	local memory = gcinfo();
	Gypsy_DebugPrint(memory);
end