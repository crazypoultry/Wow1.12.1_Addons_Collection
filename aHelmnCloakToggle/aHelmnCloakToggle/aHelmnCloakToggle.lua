
if (GetLocale() == "deDE") then
	HELM_TOGGLE_TOOLTIP	 = "Helm ein- bzw. ausblenden."
	CLOAK_TOGGLE_TOOLTIP	 = "Umhang ein- bzw. ausblenden."

	HELM_VIEW_OFF		 = "Helmansicht: |cFFFF0000Aus|r"
	HELM_VIEW_ON		 = "Helmansicht: |cff00ff00An|r"

	CLOAK_VIEW_OFF		 = "Umhangansicht: |cFFFF0000Aus|r"
	CLOAK_VIEW_ON		 = "Umhangansicht: |cff00ff00An|r"


else


	HELM_TOGGLE_TOOLTIP	 = "Toggles the view of the Head item."
	CLOAK_TOGGLE_TOOLTIP	 = "Toggles the view of the Back item."
	
	HELM_VIEW_OFF		 = "Helmview: |cFFFF0000Off|r"
	HELM_VIEW_ON		 = "Helmview: |cff00ff00On|r"

	CLOAK_VIEW_OFF		 = "Cloakview: |cFFFF0000Off|r"
	CLOAK_VIEW_ON		 = "Cloakview: |cff00ff00On|r"
end


-- Tooltips show BEGINN
function aHelmToggleTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(HELM_TOGGLE_TOOLTIP); -- , 1.0, 1.0, 1.0
end


function aCloakToggleTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(CLOAK_TOGGLE_TOOLTIP); -- , 1.0, 1.0, 1.0
end
-- Tooltips show END

function aHelmOnLoad()	 -- Helm Checkbox setzen
	if ( ShowingHelm() ) then
		HelmCheckBox:SetChecked(1);
	elseif (not ShowingHelm() ) then
		HelmCheckBox:SetChecked(0);
	end
end

function aCloakOnLoad()	-- Umhang Checkbox setzen
	if ( ShowingCloak() ) then
		CloakCheckBox:SetChecked(1);
	elseif (not ShowingCloak() ) then
		CloakCheckBox:SetChecked(0);
	end
end


function aHelmToggle()	
	if ( ShowingHelm() ) then
			ShowHelm(0); -- Helm verstecken
			DEFAULT_CHAT_FRAME:AddMessage(HELM_VIEW_OFF);
			HelmCheckBox:SetChecked(0);
	elseif (not ShowingHelm() ) then	
			ShowHelm(1); -- Helm anzeigen
			DEFAULT_CHAT_FRAME:AddMessage(HELM_VIEW_ON);
			HelmCheckBox:SetChecked(1);
	end
end

function aCloakToggle()
	if ( ShowingCloak() ) then
			ShowCloak(0); -- Umhang verstecken
			DEFAULT_CHAT_FRAME:AddMessage(CLOAK_VIEW_OFF);
			CloakCheckBox:SetChecked(0);
	elseif (not ShowingCloak() ) then
			ShowCloak(1); -- Umhang anzeigen
			DEFAULT_CHAT_FRAME:AddMessage(CLOAK_VIEW_ON);
			CloakCheckBox:SetChecked(1);
	end
end