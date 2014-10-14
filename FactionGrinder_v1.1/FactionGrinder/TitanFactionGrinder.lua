-- Set Labels and ID
TITAN_FG_ID = "FactionGrinder"
TITAN_FG_MENU_TEXT = "FactionGrinder"
TITAN_FG_BUTTON_LABEL =  "FactionGrinder";
TITAN_FG_TOOLTIP = FG_TEXT["Faction Grinder"].." v1.0";
TITAN_FG_ICONPATH = "Interface\\Icons\\INV_Stone_GrindingStone_05"
TITAN_AND_FG_LOADED = nil;


function TitanPanelFactionGrinderButton_OnLoad()
	TITAN_AND_FG_LOADED = IsFGLoaded();
	if (TITAN_AND_FG_LOADED == 2) then		-- Only continue if FactionGrinder AND Titan Panel are loaded
		this.registry = { 
			id = TITAN_FG_ID,
			version = 1.0,
			menuText = TITAN_FG_MENU_TEXT, 
			buttonTextFunction = "TitanPanelFactionGrinderButton_GetButtonText", 
			tooltipTitle = TITAN_FG_TOOLTIP,
			tooltipTextFunction = "TitanPanelFactionGrinderButton_GetTooltipText", 
			icon = TITAN_FG_ICONPATH,
			iconWidth = 16,
			frequency = 0.1,
			category = "Information",
			savedVariables = {
				ShowIcon = 1,
				ShowLabelText = 1
			}
		};
	elseif (TITAN_AND_FG_LOADED == 1) then
		function TitanPanelButton_OnLoad() end  --TitanPanelButton_OnLoad not defined if Titan not loaded.
	end
end


function TitanPanelFactionGrinderButton_OnClick(button)
	if (TITAN_AND_FG_LOADED == 2) then
		if (button == "RightButton") then
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
			   local button = getglobal("TitanPanelFactionGrinderButton");
			   if(button:GetTop()+frame:GetHeight() > GetScreenHeight())then
				if(button:GetLeft() + frame:GetWidth() > GetScreenWidth())then
				    --Button is on the top right
				    frame:SetPoint("TOPRIGHT","TitanPanelFactionGrinderButton","BOTTOMRIGHT");
				else
				    --Button is on the top left
				    frame:SetPoint("TOPLEFT","TitanPanelFactionGrinderButton","BOTTOMLEFT",-15,0);
				end
			   else
				if(button:GetLeft() + frame:GetWidth() > GetScreenWidth())then
				    --Button is on the bottom right
    				    frame:SetPoint("BOTTOMRIGHT","TitanPanelFactionGrinderButton","TOPRIGHT");
				else
				    --Button is on the bottom left
				    frame:SetPoint("BOTTOMLEFT","TitanPanelFactionGrinderButton","TOPLEFT",-15,0);
				end
			   end
			end
			end
		elseif (button == "LeftButton")then
			FactionGrinder_ToggleFrameDisplay(not FactionGrinderSettings["Show Frames"]);
		end
	end
end


function TitanPanelFactionGrinderButton_GetButtonText(id)
	if (TITAN_AND_FG_LOADED == 2) then
		local button, id = TitanUtils_GetButton(id, true);
		local retstr = "";

		-- supports turning off labels
		if (TitanGetVar(TITAN_FG_ID, "ShowLabelText")) then
			
		end
		return retstr
	end
end


-- Get Tooltip Text
-- NB: You can use XML to format the text in the str, eg:
-- \n = New Line
-- \t = Tab space
-- Others may work but I have not tested them yet.

function TitanPanelFactionGrinderButton_GetTooltipText()
	return FG_TEXT["Toggle Selected Trackers\tLeft-Click\nToggle Settings Screen\tRight-Click"]
end


----------------------------------------------------------------------

function TitanADGPrintD(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg,0.50,0.50,1.00);
end

function IsFGLoaded()	-- Renamed from GetStatus() to prevent possible conflicts with Titan Mod Support Project Core Functions

	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("FactionGrinder")
	local _, _, _, titanEnabled, _, _, _ = GetAddOnInfo("Titan")

	if not titanEnabled then	-- If Titan is not running
		if not (enabled == 1) then						-- If ArgentDawnGrinder is not running
			return 0;							-- Return 0
		else
			return 1;							-- and return 1
		end

	elseif (enabled == 1) then							-- Otherwise Titan is running, so check ArgentDawnGrinder
		return 2;								-- return 2
	else										-- otherwise Titan is running but ArgentDawnGrinder is not
		return 3;								-- and return 3
	end
end
