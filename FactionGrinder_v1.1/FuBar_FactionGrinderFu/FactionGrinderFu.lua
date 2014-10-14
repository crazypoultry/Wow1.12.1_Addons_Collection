FactionGrinderFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceConsole-2.0")
FactionGrinderFu:RegisterDB("FactionGrinderFuDB")

FactionGrinderFu.hasIcon = true
FactionGrinderFu.cannotDetachTooltip = true
FactionGrinderFu.defaultPosition = "LEFT"
FactionGrinderFu.folderName = "FuBar_FactionGrinderFu"

local Tablet = AceLibrary("Tablet-2.0")
local Crayon = AceLibrary("Crayon-2.0")

function FactionGrinderFu:OnEnable()
end

function FactionGrinderFu:OnTextUpdate()	
	self:SetText(""); --No text, just the icon.
end

function FactionGrinderFu:OnTooltipUpdate()
	Tablet:SetHint(FG_TEXT["FUBAR_Toggle Selected Trackers\tLeft-Click\nToggle Settings Screen\tRight-Click"]);
end

function FactionGrinderFu:OnClick()
	FactionGrinder_ToggleFrameDisplay(not FactionGrinderSettings["SHOW_FRAMES"]);
end

function FactionGrinderFu:OpenMenu()
    local frame = getglobal("FactionGrinderSettingsFrame")
    if (frame) then
    if(frame:IsVisible()) then
       	frame:Hide();
       	frame:ClearAllPoints();
       	frame:SetPoint("CENTER",nil,"CENTER",0,0);
    else
       	frame:Show();
       	frame:ClearAllPoints();
       	--Check where on the Titan Panels the button is.
       	local button = FactionGrinderFu:GetFrame();
       	if(button:GetTop()+frame:GetHeight() > GetScreenHeight())then
	    frame:SetPoint("TOP",nil,"TOP",0,-15);    
	else
	    frame:SetPoint("BOTTOM",nil,"BOTTOM",0,15);
	end
    end
    end
end
