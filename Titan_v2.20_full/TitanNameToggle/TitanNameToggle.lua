--[[
    Name:           NameToggle
	Description:	Titan Panel plugin to toggle Player names/guilds/titles and NPC names.
	Author:		    Blueforge (blueforge@gmail.com)
    Version:        1.0
--]]

TITAN_NAMETOGGLE_ID = "NameToggle";

function TitanPanelNameToggleButton_OnLoad()
	this.registry = { 
		id = TITAN_NAMETOGGLE_ID,
		menuText = "NameToggle", 
		tooltipTitle = "NameToggle";
		tooltipTextFunction = "TitanPanelNameToggleButton_GetTooltipText", 
        icon = "Interface\\GossipFrame\\BinderGossipIcon.blp",
		iconWidth = 16,
		iconButtonWidth = 16,	 
	};
    
    this:RegisterEvent("CVAR_UPDATE");
end

function TitanPanelNameToggleButton_OnEvent()
    if (event == "CVAR_UPDATE") then
        if (arg1 == "UnitNamePlayer" or arg1 == "UnitNamePlayerGuild" or arg1 == "UnitNamePlayerPVPTitle" or arg1 == "UnitNameNPC") then
            TitanPanelButton_UpdateTooltip();
        end
    end
end

function TitanPanelNameToggleButton_GetTooltipText()
    local text = "Left click to toggle player names\nRight click to toggle NPC names\n\nPlayer Names: ";
    if (GetCVar("UnitNamePlayer") == "1") then
        text = text .. TitanUtils_GetGreenText("Enabled\n");
    else
        text = text .. TitanUtils_GetRedText("Disabled\n");
    end

    text = text .. "Player Guilds: ";
    if (GetCVar("UnitNamePlayerGuild") == "1") then
        text = text .. TitanUtils_GetGreenText("Enabled\n");
    else
        text = text .. TitanUtils_GetRedText("Disabled\n");
    end
    
    text = text .. "Player Titles: ";
    if (GetCVar("UnitNamePlayerPVPTitle") == "1") then
        text = text .. TitanUtils_GetGreenText("Enabled\n\n");
    else
        text = text .. TitanUtils_GetRedText("Disabled\n\n");
    end

    text = text .. "NPC Names: ";
    if (GetCVar("UnitNameNPC") == "1") then
        text = text .. TitanUtils_GetGreenText("Enabled");
    else
        text = text .. TitanUtils_GetRedText("Disabled");
    end    

    return text;
end

function TitanPanelNameToggleButton_OnClick(button)
    if (button == "LeftButton") then
        local uname = GetCVar("UnitNamePlayer");
        local uguild = GetCVar("UnitNamePlayerGuild");
        local utitle = GetCVar("UnitNamePlayerPVPTitle");
        
        if (uname == "0") then
            SetCVar("UnitNamePlayer", "1")
            SetCVar("UnitNamePlayerGuild", "0")
            SetCVar("UnitNamePlayerPVPTitle", "0")
        else
            if (uguild == "0") then
                SetCVar("UnitNamePlayerGuild", "1")
            else
                if (utitle == "0") then
                    SetCVar("UnitNamePlayerGuild", "0")
                    SetCVar("UnitNamePlayerPVPTitle", "1")
                else
                    SetCVar("UnitNamePlayer", "0")
                    SetCVar("UnitNamePlayerGuild", "0")
                    SetCVar("UnitNamePlayerPVPTitle", "0")
                end

            end
        end
    elseif (button == "RightButton") then
        local unpc = GetCVar("UnitNameNPC");
        if (unpc == "0") then
            SetCVar("UnitNameNPC", "1");
        else
            SetCVar("UnitNameNPC", "0");
        end
    end
    TitanPanelButton_UpdateTooltip();
end
