
--[[

--------------------------------
PVPCooldown Reborn v2.9.1 by Kisk
--------------------------------

	Original code by Kisk
	Additional code/localizations by Alyssa_D, ArKoS, and others
	Addon lost and now reborn again by Kisk..

--------------------------------
Description:
--------------------------------

	Shows time remaining on your PVP status, or shows PVP zoneinfo.
	The infoframe will automatically popup or hide depending on PVP status.
	Frame can be moved to any position on the screen.


        Different status text is displayed depending on your PVP status:

		"PVP:  0:00"    -- Displays the amount of time till your pvp flag is removed
		"PVP:  On"      -- Displayed when your /pvp is toggled on
		"Contested"     -- You are in a contested area
		"Cont/On"       -- You are in a contested area and your /pvp is toggled on
		"Hostile"       -- You are in a hostile area
		"Hostile/On"    -- You are in a hostile area and your /pvp is toggled on
		"BG"            -- You are in a battleground
		"BG/On"         -- You are in a battleground and your /pvp is toggled on


	Options:	
		/pvp 		toggles PVP mode
		/pvp show	shows the infoframe
		/pvp hide	hides the infoframe

		<shift> + <leftclick> to drag the infoframe

--------------------------------
 ToDO:
--------------------------------

	Post comments/suggestions/bugs at:
	http://www.curse-gaming.com/en/wow/addons-244-1-pvpcooldown-reborn.html

--------------------------------
 History:
--------------------------------

	2006-11-06 v2.9.1, TOC 11200
	--------------------------
		- Fixed a bug that was causing a concatenation error when first loading the addon
		- Fixed a folder name conflict that was causing the addon not to load

	2006-11-05 v2.9, TOC 11200
	--------------------------
		- Code re-written for better organization and to removed redundant code
		- Added status/zone texts for the infobar
		- Minor cosmetic fixes

	2006-08-19 v2.7, TOC 5464
	--------------------------
		- Some bugfixes have been implemented and should work correctly with the 1.11 patch.

	2005-11-08 v2.6, TOC 1800
	--------------------------
		- The infoframe is now moveable only by pressing SHIFT + Left Mousebutton

	2005-09-21 v2.52, TOC 1700
	--------------------------
		- Bugfix on EN and FR; added FR localization (thanks ArKoS)

	2005-09-20 v2.51, TOC 1700
	--------------------------
		- Minor cosmetic fixes

	2005-09-18 v2.5, TOC 1700
	--------------------------
		- Modified and localized by Alyssa_D (Alyssand of Antonidas, Rafnuk of Frostwolf)


]]



BINDING_HEADER_PVPCOOLDOWNHEADER = "PVPCooldown Reborn";
BINDING_NAME_PVPCOOLDOWN = "Toggle PVP";


PVP_Properties = {};

local factionGroup;
local remainingTime = 300;
local elapsedTime = 0;
local isPVPFLAGED = false;
local sTemp = 0;
local mTemp = 0;


function PVPCooldown_OnLoad()
	this:RegisterEvent("UNIT_FACTION");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD"); 
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_SYSTEM");

	SLASH_PVPCooldown1 = "/pvp";

	SlashCmdList["PVPCooldown"] = PVPCooldown_SlashHandler;

	if (ChatFrame1) then
        	ChatFrame1:AddMessage("|cffffaf0FPvPCooldown Reborn v2.9|r "..PVP_COOLDOWN_LOADMSGA);
	        ChatFrame1:AddMessage("|cff40ff40Commands: /pvp [show] [hide] |r");
	end
end


function PVPCooldown_OnEvent(event)

	if ((event == "UNIT_FACTION") and (arg1 == "player")) then
        --ChatFrame2:AddMessage("UNIT_FACTION event occoured");
        isPVPFLAGED = PVPCooldown_GetPVP();
        if (isPVPFLAGED) then
        	remainingTime = 300;
        	PVPCooldownFrame:Show();
        else
        	PVPCooldownFrame:Hide();
        end

	elseif (event == "VARIABLES_LOADED") then
		--ChatFrame2:AddMessage("VARIABLES_LOADED event occoured");

	elseif (event == "PLAYER_ENTERING_WORLD") then
		--ChatFrame2:AddMessage("PLAYER_ENTERING_WORLD event occoured");
        isPVPFLAGED = PVPCooldown_GetPVP();
        if (isPVPFLAGED) then
        	remainingTime = 300;
        	PVPCooldownFrame:Show();
        else
        	PVPCooldownFrame:Hide();
        end

	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		--ChatFrame2:AddMessage("ZONE_CHANGED_NEW_AREA event occoured: " .. '"' .. GetZonePVPInfo("pvpType") .. '"');
		isPVPFLAGED = PVPCooldown_GetPVP();
        if (isPVPFLAGED) then
        	remainingTime = 300;
        	PVPCooldownFrame:Show();
        else
        	PVPCooldownFrame:Hide();
        end
		PVPCooldown_ZoneCheck();

	elseif ((event == "CHAT_MSG_SYSTEM") and (arg1 == PVP_TOGGLE_OFF_VERBOSE)) then
		--ChatFrame2:AddMessage("PVP_TOGGLE_OFF_VERBOSE event occoured");
		PVP_Properties.PVPON = false;
		remainingTime = 300;
		PVPCooldownFrame:Show();

	elseif ((event == "CHAT_MSG_SYSTEM") and (arg1 == PVP_TOGGLE_ON_VERBOSE)) then
		--ChatFrame2:AddMessage("PVP_TOGGLE_ON_VERBOSE event occoured");
		PVP_Properties.PVPON = true;
		remainingTime = 300;
		PVPCooldownFrame:Show();

	end

end


function PVPCooldown_OnUpdate(elapse)

	if (isPVPFLAGED) then

		if (PVP_Properties.PVPON) and (PVP_Properties.inBattleground) then
			PVPCooldownText:SetText("BG/On");

		elseif (not PVP_Properties.PVPON) and (PVP_Properties.inBattleground) then
            PVPCooldownText:SetText("BG");

        elseif (PVP_Properties.PVPON) and (GetZonePVPInfo("pvpType") == "contested") then
            PVPCooldownText:SetText("Cont/On");

		elseif (not PVP_Properties.PVPON) and (GetZonePVPInfo("pvpType") == "contested") then
            PVPCooldownText:SetText("Contested");

		elseif (PVP_Properties.PVPON) and (GetZonePVPInfo("pvpType") == "hostile") then
            PVPCooldownText:SetText("Hostile/On");

		elseif (not PVP_Properties.PVPON) and (GetZonePVPInfo("pvpType") == "hostile") then
            PVPCooldownText:SetText("Hostile");

        elseif (PVP_Properties.PVPON) then            -- PVP Toggled only
            PVPCooldownText:SetText("PVP:   On");

        else
           	elapsedTime = elapsedTime + elapse;

            if (elapsedTime > 1) then
                PVPCooldown_ConvertTimer(remainingTime);
                elapsedTime = elapsedTime - 1;
                remainingTime = remainingTime - 1;
				PVPCooldownText:SetText("PVP:  " .. mTemp .. ":" .. sTemp);

			elseif (remainingTime < 1) then
				PVPCooldownFrame:Hide();
			end

		end
	end
end


function PVPCooldown_ZoneCheck()

	if (string.find (GetZoneText(), BG_WARSONG_NAME) ~= nil) then 
		PVP_Properties.inBattleground = true;

	elseif (string.find (GetZoneText(), BG_ALTERAC_NAME) ~= nil) then 
		PVP_Properties.inBattleground = true;

	elseif (string.find (GetZoneText(), BG_ARATHI_NAME) ~= nil) then 
		PVP_Properties.inBattleground = true;

	else
        PVP_Properties.inBattleground = false;
	end


	if (isPVPFLAGED) or (PVP_Properties.PVPON) or (GetZonePVPInfo("pvpType") == "contested") or (GetZonePVPInfo("pvpType") == "hostile") or (PVP_Properties.inBattleground) then
        remainingTime = 300;
        PVPCooldownFrame:Show();
	end



end


function PVPCooldown_ConvertTimer(CurrentTime)
	sTemp = CurrentTime;
	mTemp = 0;

	while (sTemp >= 60) do
		sTemp = sTemp - 60;
		mTemp = mTemp + 1;
	end

	if (sTemp < 10) then
		sTemp = "0" .. sTemp;
	end
end


function PVPCooldown_GetPVP()
	if (UnitIsPVP("player") == 1) then
		return true;
	else
		return false;
	end
end


function PVPCooldown_SlashHandler(msg)
	if ((not msg) or (msg == "")) then
		TogglePVP();

	elseif (msg == "show") then
		PVPCooldownFrame:Show();
		
	elseif (msg == "hide") then
		PVPCooldownFrame:Hide();
	end
end










