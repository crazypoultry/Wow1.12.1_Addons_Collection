-- Normal Stuff --
function TitanIFA_OnLoad()
  this:RegisterEvent("PLAYER_LEAVING_WORLD");
  this:RegisterEvent("PLAYER_ENTERING_WORLD");
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("SPELLCAST_FAILED");
  this:RegisterEvent("SPELLCAST_STOP");
  this:RegisterEvent("SPELLCAST_INTERRUPTED");
  this:RegisterEvent("UNIT_COMBAT");
end

function TitanIFA_OnEvent()
	if (event == "VARIABLES_LOADED") then
		InnerfireAlert_Initialize();
	end
	if (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
		if (VAR_TITAN_IFA_ENDCAST) then 
			VAR_TITAN_IFA_SPELL = nil;
			VAR_TITAN_IFA_ENDCAST = nil;
			VAR_TITAN_IFA_TARGET = nil;
		end
	elseif (event == "SPELLCAST_STOP") then
		if (VAR_TITAN_IFA_ENDCAST) then
			IFA_OnSpellCast(VAR_TITAN_IFA_ENDCAST, VAR_TITAN_IFA_TARGET);
			VAR_TITAN_IFA_SPELL = nil;
			VAR_TITAN_IFA_ENDCAST = nil;
			VAR_TITAN_IFA_TARGET = nil;
		end
	end
	
	if (event == "UNIT_COMBAT") then
		if (arg1 == "player" and arg5 == 0) then
			if (arg4 ~= 0 and arg2 == "WOUND") then
				if (not VAR_TITAN_IFA_CHARGESLEFT) then
					VAR_TITAN_IFA_CHARGESLEFT = 0;
					if (VAR_TITAN_IFA_CHARGESLEFT <= 0) then
						VAR_TITAN_IFA_CHARGESLEFT = 0;
					end
				else 
					if (not isPlayerBuffUp("Spell_Holy_InnerFire")) then
						VAR_TITAN_IFA_CHARGESLEFT = 0;
					else
						VAR_TITAN_IFA_CHARGESLEFT = VAR_TITAN_IFA_CHARGESLEFT - 1;
					end
				end
			end
		end
	end
	
	if (event == "PLAYER_ENTERING_WORLD") then
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("SPELLCAST_FAILED");
		this:RegisterEvent("SPELLCAST_STOP");
		this:RegisterEvent("SPELLCAST_INTERRUPTED");
		this:RegisterEvent("UNIT_COMBAT");
	end
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("VARIABLES_LOADED");
		this:UnregisterEvent("SPELLCAST_FAILED");
		this:UnregisterEvent("SPELLCAST_STOP");
		this:UnregisterEvent("SPELLCAST_INTERRUPTED");
		this:UnregisterEvent("UNIT_COMBAT");
	end
end

function IFA_OnSpellCast(spellName, Target)
	if (spellName == "Inner Fire") then
		VAR_TITAN_IFA_CHARGESLEFT = 20;
	end
end

-- Titan Stuff --
function TitanPanelIFAButton_OnLoad()

	this.registry = {
		id = TITAN_IFA_ID,
		menuText = TITAN_IFA_MENU_TEXT,
		version = TITAN_IFA_VERSION,
		buttonTextFunction = "TitanPanelIFAButton_GetButtonText",
		frequency = TITAN_IFA_FREQ,
		icon = "Interface\\AddOns\\TitanIFA\\Artwork\\Spell_Holy_InnerFire",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
		},
	}

end
function TitanPanelIFAButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_IFA_ID);
end

function TitanPanelIFAButton_GetButtonText(id)
	local cColor, eColor, cText, eTime, cRichText, eRichText, eNum
	
	
	eNum = GetBuffTimeleft("Spell_Holy_InnerFire")
	cText = VAR_TITAN_IFA_CHARGESLEFT
	eTime = AbbrTimeText(eNum)
	
	if (not VAR_TITAN_IFA_CHARGESLEFT) then
		cText = "N/A";
	end
	if (not isPlayerBuffUp("Spell_Holy_InnerFire")) then
		cText = "N/A";
	end
	
	if (not eNum) then eNum = "N/A"
	elseif (eNum <= 0) then eNum = "N/A"
	end
	
	if ( TitanGetVar(TITAN_IFA_ID, "ShowColoredText") ) then
		
		if (not VAR_TITAN_IFA_CHARGESLEFT) then 
			cColor = TitanUtils_GetThresholdColor(TITAN_IFA_CHARGES_THRESHOLD_TABLE, 0);
			eColor = TitanUtils_GetThresholdColor(TITAN_IFA_EXPIRES_THRESHOLD_TABLE, eNum);
		else
			cColor = TitanUtils_GetThresholdColor(TITAN_IFA_CHARGES_THRESHOLD_TABLE, cText);
			eColor = TitanUtils_GetThresholdColor(TITAN_IFA_EXPIRES_THRESHOLD_TABLE, eNum);
		end
		
		cRichText = TitanUtils_GetColoredText(cText, cColor);
		eRichText = TitanUtils_GetColoredText(eTime, eColor);
		
	else
		cRichText = TitanUtils_GetHighlightText(cText);
		eRichText = TitanUtils_GetHighlightText(eTime);
	end
	
	return TITAN_IFA_CHARGES, cRichText, TITAN_IFA_EXPIRES, eRichText;
end

function TitanIFAButton_UpdateTooltip(id)

end