local OPIUMOPTIONS_STORE_DROPDOWN_LIST = {
        { name = OPIUM_TEXT_NONE, index = OPIUM_AUTOSTORE_NONE },
	{ name = OPIUM_TEXT_ALLIES, index = OPIUM_AUTOSTORE_ALLIES },
	{ name = OPIUM_TEXT_ENEMIES, index = OPIUM_AUTOSTORE_ENEMIES },
        { name = OPIUM_TEXT_ALL, index = OPIUM_AUTOSTORE_ALL },
	{ name = OPIUM_TEXT_COMBAT, index = OPIUM_AUTOSTORE_COMBAT }
        
};


function OpiumOptionsOnlyEnemyAlerts_Toggle()
   OpiumData.config.alertsonlyonenemy = not OpiumData.config.alertsonlyonenemy;
end

function OpiumOptionsBlockSenders_Toggle()
   OpiumData.config.blockallsends = not OpiumData.config.blockallsends;
end

function OpiumOptionsColorWho_Toggle()
   OpiumData.config.colorwho = not OpiumData.config.colorwho;
end

						
function OpiumOptionsStoreDropDown_OnClick()
   UIDropDownMenu_SetSelectedID(OpiumOptionsStoreDropDown, this:GetID());
   OpiumData.config.autostore = this:GetID() - 1;
end

function OpiumOptionsStoreDropDown_OnShow()
     UIDropDownMenu_Initialize(this, OpiumOptionsStoreDropDown_Initialize);
     UIDropDownMenu_SetSelectedID(this, OpiumData.config.autostore + 1);
     UIDropDownMenu_SetWidth(80);
end

function OpiumOptionsStoreDropDown_Initialize()
	local info;

	for i = 1, getn(OPIUMOPTIONS_STORE_DROPDOWN_LIST), 1 do
		info = { };
		info.text = OPIUMOPTIONS_STORE_DROPDOWN_LIST[i].name;
		info.func = OpiumOptionsStoreDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
       
end

function OpiumOptionsStorePvPRank_Toggle()
   OpiumData.config.trackpvpranks = not OpiumData.config.trackpvpranks;
end

function OpiumOptionsTrackPvPStats_Toggle()
   OpiumData.config.trackpvpstats = not OpiumData.config.trackpvpstats;
end

function OpiumOptionsTargetbutton_Toggle()
   OpiumData.config.targetbutton = not OpiumData.config.targetbutton;
end

function OpiumOptionsTextalert_Toggle()
   OpiumData.config.textalert = not OpiumData.config.textalert;
end

function OpiumOptionsSoundalert_Toggle()
   OpiumData.config.soundalert = not OpiumData.config.soundalert;
end

function OpiumOptionsGuildname_Toggle()
  OpiumData.config.guilddisplay = not OpiumData.config.guilddisplay;
end

function OpiumOptions_Toggle()
	if(OpiumOptionsFrame:IsVisible()) then
		OpiumOptionsFrame:Hide();
	else
		OpiumOptionsFrame:Show();
	end
end

function OpiumOptions_OnLoad()
	UIPanelWindows['OpiumOptionsFrame'] = {area = 'center', pushable = 0};
end


function OpiumOptions_OnShow()
   OpiumOptions_Init();
end

function OpiumOptions_Init()
	OpiumOptionsFrameToggleButton:SetChecked(OpiumData.config.mmbutton);
	OpiumSliderButtonPos:SetValue(OpiumData.config.mmbuttonposition);

        OpiumOptionsGuildnameToggleButton:SetChecked( OpiumData.config.guilddisplay );
	OpiumOptionsTextalertToggleButton:SetChecked( OpiumData.config.textalert );
	OpiumOptionsSoundalertToggleButton:SetChecked( OpiumData.config.soundalert );
	OpiumOptionsTargetbuttonToggleButton:SetChecked( OpiumData.config.targetbutton );
	OpiumOptionsTrackPvPStatsToggleButton:SetChecked( OpiumData.config.trackpvpstats );
	OpiumOptionsStorePvPRankToggleButton:SetChecked( OpiumData.config.trackpvpranks );
        OpiumOptionsBlockSendersToggleButton:SetChecked( OpiumData.config.blockallsends );
        OpiumOptionsColorWhoToggleButton:SetChecked( OpiumData.config.colorwho );
        OpiumOptionsOnlyEnemyAlertsToggleButton:SetChecked( OpiumData.config.alertsonlyonenemy );

        OK_ChatFrameEditBox:SetText(OpiumData.config.chatframe);
end

function OpiumOptions_OnHide()
   OpiumData.config.chatframe = OK_ChatFrameEditBox:GetText();

	if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		ShowUIPanel(myAddOnsFrame);
	end
end
