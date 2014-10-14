BGAlerts_Addons = { }

function BGAlerts_OnLoad()
	table.insert(UISpecialFrames,"BGAlertsMainFrame");
	this:RegisterEvent("VARIABLES_LOADED");
end

function BGAlerts_InitVars()	
	if (not BGAlerts_ButtonPosition) then
		BGAlerts_ButtonPosition = 0;
	end
	
	if (not BGAlerts_MinimapButtonShow) then
		BGAlerts_MinimapButtonShow = 1;
	end
	
	BGAlerts_ShowHideMiniButton();
end

function BGAlerts_RegisterAddon(addonName,saveFunction,showFunction,optionsPanel)
	-- addonName: Name of addons
	-- saveFunction: Function to call to save the set stuff
	-- showFunction: Function to call when dialog box shown
	-- optionsPanel: The frame to show for options
	if (not ((type(saveFunction) == "function") and (type(optionsPanel) == "table")
			and (type(showFunction) == "function"))) then
			message("Error registering addon with BGAlerts.");
			return;
	end
			
	local tempTable		= {
							name = addonName,
							save = saveFunction,
							show = showFunction,
							tab = CreateFrame("Button","BGAlertsMainFrameTab" .. table.getn(BGAlerts_Addons) + 1,BGAlertsMainFrame,"BGAlerts_Tab"),
							panel = optionsPanel
						  };
		  
	table.insert(BGAlerts_Addons,tempTable);
	
	local i = table.getn(BGAlerts_Addons);
	
	BGAlerts_Addons[i].tab:SetText(BGAlerts_Addons[i].name);
	BGAlerts_Addons[i].tab:SetID(i);

	PanelTemplates_TabResize(0,getglobal("BGAlertsMainFrameTab" .. i))
	getglobal("BGAlertsMainFrameTab".. i .. "HighlightTexture"):
	SetWidth(getglobal("BGAlertsMainFrameTab".. i):GetTextWidth() + 31);
	getglobal("BGAlertsMainFrameTab" .. i .. "LeftDisabled"):SetTexture("Interface\\OptionsFrame\\OptionsFrameTab-Active");
	getglobal("BGAlertsMainFrameTab" .. i .. "MiddleDisabled"):SetTexture("Interface\\OptionsFrame\\OptionsFrameTab-Active");
	getglobal("BGAlertsMainFrameTab" .. i .. "RightDisabled"):SetTexture("Interface\\OptionsFrame\\OptionsFrameTab-Active");
	
	
	BGAlerts_UpdateTabs();
end

function BGAlerts_ShowAddonPanel(addon)
	local i = 0;
	local found = nil;
	
	for i = 1, table.getn(BGAlerts_Addons) do
		if (BGAlerts_Addons[i].name == addon) then
			found = i;
		end
	end
	
	if (found) then
		getglobal("BGAlertsMainFrameTab" .. found):Click();
	end
end

function BGAlerts_UpdateTabs()
	local i = 0;
	
	PanelTemplates_SetNumTabs(BGAlertsMainFrame,table.getn(BGAlerts_Addons));
	
	for i = 1, table.getn(BGAlerts_Addons) do
		BGAlerts_Addons[i].tab:ClearAllPoints();
		if (i == 1) then		
			BGAlerts_Addons[i].tab:SetPoint("TOPLEFT","BGAlertsMainFrame_ContentFrame","TOPLEFT",11,-22);
		else
			BGAlerts_Addons[i].tab:SetPoint("BOTTOMLEFT","BGAlertsMainFrameTab" .. tostring(i-1),"BOTTOMRIGHT",3,0);
		end
	end
end

function BGAlerts_TabClicked()
	local i = 0;
	
	for i = 1, table.getn(BGAlerts_Addons) do
		BGAlerts_Addons[i].panel:Hide();
	end
	
	BGAlerts_Addons[this:GetID()].panel:Show();
end

function BGAlerts_ShowHideMiniButton()
	if (BGAlerts_MinimapButtonShow == 1) then
		BGAlerts_MinimapFrame:Show();
	else
		BGAlerts_MinimapFrame:Hide();
	end
end

function BGAlerts_Accept()
	-- Assign the minimap button option to the saved variable
	BGAlerts_MinimapButtonShow = BGAlerts_MiniButton_Check:GetChecked();
	
	if (not BGAlerts_MinimapButtonShow) then
		-- Make sure it's 0 not nil
		BGAlerts_MinimapButtonShow = 0;
	end
	
	BGAlerts_ShowHideMiniButton();
	
	local i = 0;
	
	for i = 1, table.getn(BGAlerts_Addons) do
		BGAlerts_Addons[i]:save();
	end
end

function BGAlerts_Show()	
	BGAlerts_MiniButton_Check:SetChecked(BGAlerts_MinimapButtonShow);

	local i = 0;
	
	for i = 1, table.getn(BGAlerts_Addons) do
		BGAlerts_Addons[i]:show();
		if (i == 1) then
			BGAlerts_Addons[i].panel:Show();
		else
			BGAlerts_Addons[i].panel:Hide();
		end
	end

	SetupFullscreenScale(this);	
	PanelTemplates_SetTab(this,1);

end

-- BGAlerts Minimap button Functions

function BGAlerts_MinimapUpdatePosition()
	BGAlerts_MinimapFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(BGAlerts_ButtonPosition)),
		(78 * sin(BGAlerts_ButtonPosition)) - 55
	);
end

function BGAlerts_MinimapSetPosition(v)    
    if(v < 0) then
        v = v + 360;
    end
    
    BGAlerts_ButtonPosition = v;
    BGAlerts_MinimapUpdatePosition();
end

function BGAlerts_BeingDragged()
	-- Thanks to Yatlas for this code
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    BGAlerts_MinimapSetPosition(math.deg(math.atan2(ypos,xpos)));
end	