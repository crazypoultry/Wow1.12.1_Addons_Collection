-------------------------------------------------------------------------------
-- Initialize the panel
-------------------------------------------------------------------------------
function ffy_ButtonFrame_OnLoad()

    -- Set up the decursive options
	if (DCR_VERSION_STRING) then
	    ffy_ButtonFrame_LabelDecurse:SetText(BINDING_HEADER_DECURSIVE);
	    ffy_ButtonFrame_DecurseButton:Show();
	    ffy_ButtonFrame_LabelDecurse:Show();
	    ffy_ButtonFrame_PanelDecurse:Show();
	end
	
	-- Set up the panel's text
	ffy_ButtonFrame_LabelFortify:SetText(BINDING_HEADER_FORTIFY);
	ffy_ButtonFrame_ConfigButton:SetText(FFY_UI_CONFIGBUTTON);
end


-------------------------------------------------------------------------------
-- Show configuration user interface
-------------------------------------------------------------------------------
function ffy_ButtonFrame_Config()
    if (ffy_ConfigFrame:IsVisible()) then
		HideUIPanel(ffy_ConfigFrame);
    else
		ShowUIPanel(ffy_ConfigFrame);
    end
end


-------------------------------------------------------------------------------
-- Begin moving the Fortify button panel
-------------------------------------------------------------------------------
function ffy_ButtonFrame_StartMoving()
	if (ffy_Options.PanelMovable) then
		ffy_ButtonFrame:StartMoving();
	end
end


-------------------------------------------------------------------------------
-- Show the fortify panel
-------------------------------------------------------------------------------
function ffy_ButtonFrame_Update()

    -- Show or hide the button panel as desired
	if (ffy_Options.ShowPanel) then
	    ffy_ButtonFrame:Show();

        -- Make the frame draggable if desired
        if (ffy_Options.PanelMovable) then
    	    ffy_ButtonFrame:RegisterForDrag("LeftButton");
        else
        	ffy_ButtonFrame:RegisterForDrag(nil);
        end    
	else
	    ffy_ButtonFrame:Hide();
	end
end
