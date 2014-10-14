
BFC_Options = {};

local DefaultOptions = {
	opacity = 0.7,
	locked = false,
	showPlayers = true,
	size = {
	w = 175,
	h = 131},
	settingsversion = 1,
	channel = "",
	narrow = false,
	enableRadio = true,
	autoShowBg = false,
	iframe_bgcolor = {
		r = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
		g = TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
		b = TOOLTIP_DEFAULT_BACKGROUND_COLOR.b,
		opacity = 0.25 },
	iframe_hideborder = false,
	iframe_hideframe = false,
	iframe_hidedefaultscore = false,
	iframe_lock = false,
};

-- Initialize the options from SavedVariablesByCharacter, handle any version
-- mismatches if they appear
function BFC_Options.Init()
	BFC.Log(BFC.LOG_DEBUG, "Loading options");
	if(not BattlefieldCommanderOptions) then
		-- could not load options, use defaults
		BFC.Log(BFC.LOG_PRINT, BFC_Strings.Errors.defaultoptions);
		BattlefieldCommanderOptions = DefaultOptions;
	else
		BFC_Options.CheckNewOption("iframe_bgcolor");
		BFC_Options.CheckNewOption("iframe_lock");
		BFC_Options.CheckNewOption("iframe_hidedefaultscore");
		BFC_Options.CheckNewOption("iframe_hideframe");
		BFC_Options.CheckNewOption("iframe_hideborder");
	end
end

-- Use this to handle version conflicts
function BFC_Options.CheckNewOption(name)
	if(not BattlefieldCommanderOptions[name]) then
		BattlefieldCommanderOptions[name] = DefaultOptions[name];
	end
end

-- Retrieve a setting
function BFC_Options.get(name)
	return BattlefieldCommanderOptions[name];
end

-- Store a setting
function BFC_Options.set(name, value)
	BattlefieldCommanderOptions[name] = value;
end

-- Toggle a true/false setting
function BFC_Options.toggle(name)
	BattlefieldCommanderOptions[name] = not BattlefieldCommanderOptions[name];
	return BattlefieldCommanderOptions[name];
end




-- ################# OPTIONS UI STUFF ###################

local BFC_OPTIONS_PLUGINS_SHOWN = 6;


function BFC_Options.Show()
	BFC_Options_Frame:Show();
	BFC_Options.SetSelectedPlugin(1);
	--Reset scrollbar
	BFC_Options_PluginListScrollFrameScrollBar:SetMinMaxValues(0, 0); 
	BFC_Options_PluginListScrollFrameScrollBar:SetValue(0);
end


function BFC_Options.Hide()
	BFC_Options_Frame:Hide();
end


function BFC_Options.SetSelectedPlugin(id)
	BFC_Options.selectedPlugin = id;
	BFC_Options.SelectPlugin(id);
	BFC_Options.Frame_Update();
end

function BFC_Options.GetSelectedIndex()
	return BFC_Options.selectedPlugin;
end


function BFC_Options.Frame_Update()
	local numPlugins = BFC_Common.GetNumHelperModules();
	local pluginOffset = FauxScrollFrame_GetOffset(BFC_Options_PluginListScrollFrame);
	
	--BFC.Log(BFC.LOG_DEBUG, "there are plugins: " .. numPlugins);
	-- If selectedService is nil hide everything
	--if ( not ClassTrainerFrame.selectedService ) then
	--	ClassTrainer_HideSkillDetails();
	--end


	-- ScrollFrame update
	FauxScrollFrame_Update(BFC_Options_PluginListScrollFrame, numPlugins, BFC_OPTIONS_PLUGINS_SHOWN, 16, nil, nil, nil, BFC_Options_PluginHighlightFrame, 293, 316 )
	
	BFC_Options_PluginHighlightFrame:Hide();
	-- Fill in the plugin buttons
	for i=1, BFC_OPTIONS_PLUGINS_SHOWN, 1 do
		local pluginIndex = i + pluginOffset;
		local pluginButton = getglobal("BFC_Options_Plugin"..i); 
		local serviceName, serviceSubText, serviceType, isExpanded;

		if ( pluginIndex <= numPlugins ) then
			plugin = BFC_Common.GetHelperModule(pluginIndex);
			--BFC.Log(BFC.LOG_DEBUG, "got plugin " .. pluginIndex);
			serviceName = plugin.Name;
			serviceSubText = plugin.Author;
			serviceType = plugin.Type;
			isExpanded = true;
			
			if ( not serviceName ) then
				serviceName = TEXT(UNKNOWN);
			end
			-- Set button widths if scrollbar is shown or hidden
			if ( BFC_Options_PluginListScrollFrame:IsVisible() ) then
				pluginButton:SetWidth(150);
			else
				pluginButton:SetWidth(230);
			end
			local pluginSubText = getglobal("BFC_Options_Plugin"..i.."SubText");
			-- Type stuff
			if ( serviceType == "header" ) then
				pluginButton:SetText(serviceName);
				pluginButton:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				pluginSubText:Hide();
				if ( isExpanded ) then
					pluginButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
				else
					pluginButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				end
				getglobal("BFC_Options_Plugin"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
			else
				pluginButton:SetNormalTexture("");
				getglobal("BFC_Options_Plugin"..i.."Highlight"):SetTexture("");
				pluginButton:SetText(serviceName);
				if ( serviceSubText and serviceSubText ~= "" ) then
					pluginSubText:SetText(format(TEXT(PARENS_TEMPLATE), serviceSubText));
					pluginSubText:SetPoint("LEFT", "BFC_Options_Plugin"..i.."Text", "RIGHT", 10, 0);
					pluginSubText:Show();
				else
					pluginSubText:Hide();
				end
			end
			pluginButton:SetID(pluginIndex);
			pluginButton:Show();
			-- Place the highlight and lock the highlight state
			if ( BFC_Options_Frame.selectedPlugin and BFC_Options.GetSelectedIndex() == pluginIndex ) then
				--BFC_Options_PluginHighlightFrame:SetPoint("TOPLEFT", "BFC_Options_Plugin"..i, "TOPLEFT", 0, 0);
				--BFC_Options_PluginHighlightFrame:Show();
				pluginButton:LockHighlight();
			else
				pluginButton:UnlockHighlight();
			end
		else
			pluginButton:Hide();
		end
	end
		

--		-- Show details if selected plugin is visible
--		if ( BFC_Options_Frame.selectedPlugin and BFC_Options.GetSelectedIndex() == i ) then
--			showDetails = 1;
--		end
--	end
--	-- Show plugin details if the plugin is visible
--	if ( showDetails ) then
--		--ClassTrainer_ShowSkillDetails();
--	else	
--		--ClassTrainer_HideSkillDetails();
--	end
end


function BFC_Options.SelectPlugin(id)
	
	-- General Info
	if ( not id ) then
		--ClassTrainer_HideSkillDetails();
		return;
	end
	local plugin = BFC_Common.GetHelperModule(id);
	local pluginName = plugin.Name;
	local pluginSubText = plugin.Author;
	local pluginType = plugin.Type;
	local isExpanded = true;

	--BFC_Options_PluginHighlightFrame:Show();
	


	if ( not pluginName ) then
		pluginName = TEXT(UNKNOWN);
	end
	BFC_Options_PluginName:SetText(pluginName);

	if ( not pluginSubText ) then
		pluginSubText = "";
	end
	
	if(BFC_Options_Frame.optionsFrame) then
		BFC_Options_Frame.optionsFrame:Hide();
	end
	if(plugin.OptionsFrame) then
		BFC_Options_Frame.optionsFrame = getglobal(plugin.OptionsFrame);
		BFC_Options_Frame.optionsFrame:Show();
	else
		BFC_Options_Frame.optionsFrame = getglobal("BFC_Options_DefaultOptionsFrame");
		BFC_Options_Frame.optionsFrame:Show();
	end
	
	
	
	--ClassTrainerSubSkillName:SetText(format(TEXT(PARENS_TEMPLATE), serviceSubText));
	--ClassTrainerFrame.selectedService = id;
	--BFC_Options.SetSelectedPlugin(id);

	--ClassTrainerSkillIcon:SetNormalTexture(GetTrainerServiceIcon(id));
	-- Build up the requirements string
end

function BFC_Options.PluginButton_OnClick(button)
	if ( button == "LeftButton" ) then
		BFC_Options.SetSelectedPlugin(this:GetID());
	end
end