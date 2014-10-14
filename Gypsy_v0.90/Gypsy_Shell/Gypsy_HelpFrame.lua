--[[
	Gypsy_HelpFrame.lua
	GypsyVersion++2004.10.27++
	
	Help frame functions.
]]

-- ** FIRST LOAD FUNCTIONS ** --

function Gypsy_FirstLoadFrameOnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:SetBackdropBorderColor(0, 0, 0);
	this:SetBackdropColor(0, 0, 0);	
	UIPanelWindows["Gypsy_FirstLoadFrame"] = {area = "center", pushable = 1};
end

function Gypsy_FirstLoadFrameTextFrameOnLoad ()
	this:SetBackdropBorderColor(1, 1, 1);
	this:SetBackdropColor(0.1, 0.1, 0.1);
end

function Gypsy_FirstLoadFrameOnEvent(event)
	if (event == "VARIABLES_LOADED") then
		if (GYPSY_FIRSTLOAD == nil) then
			ShowUIPanel(Gypsy_FirstLoadFrame);
			GYPSY_FIRSTLOAD = 0;
		else
			HideUIPanel(Gypsy_FirstLoadFrame);
		end
		--RegisterForSave("GYPSY_FIRSTLOAD");
		return;
	end
end
