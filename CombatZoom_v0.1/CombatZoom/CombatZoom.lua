local cbz_toggle
local cbz_playername
local cbz_mountedalready
local cbz_unmounted_already

function CombatZoom_OnEvent(event)
  
if (cbz_toggle == "on") then

  if (UnitIsMounted("player")) then
	cbz_unmountedalready = "no"
	if (cbz_mountedalready == "no") then
	  cbz_mountedalready = "yes";
	  SetView(4);
	end
  else 
	cbz_mountedalready = "no"
	if (cbz_unmountedalready == "no") then
	  cbz_unmountedalready = "yes";
	  SetView(5);
	end
    if (event == "PLAYER_REGEN_DISABLED") then
  	
      SetView(2);
    end
  
    if (event == "PLAYER_REGEN_ENABLED") then
  	
      SetView(5);
    end
  end
end


end




function CombatZoom_OnLoad()
	cbz_toggle ="on"
	cbz_mountedalready = "no"
	cbz_unmountedalready = "yes"

	SLASH_COMBATZOOM1 = "/combatzoom";
	SLASH_COMBATZOOM2 = "/cbz";
	SlashCmdList["COMBATZOOM"] = cbz_slashfunction; 
end

function cbz_slashfunction(msg)
	if (string.lower(msg) == "toggle") then
		CombatZoom_Toggle();
	elseif (string.lower(msg) == "combat") then
	    SaveView(2);
	    DEFAULT_CHAT_FRAME:AddMessage("** CombatZoom: Combat View Saved **", 0.5, 1.0, 0.0);
	elseif (string.lower(msg) == "foot") then
	    SaveView(5);
	    DEFAULT_CHAT_FRAME:AddMessage("** CombatZoom: Foot View Saved **", 0.5, 1.0, 0.0);
	elseif (string.lower(msg) == "mount") then
	    SaveView(4);
	    DEFAULT_CHAT_FRAME:AddMessage("** CombatZoom: Mounted View Saved **", 0.5, 1.0, 0.0);
	elseif (string.lower(msg) == "reset") then
	    ResetView(4);
	    ResetView(2);
	    ResetView(5);
	    DEFAULT_CHAT_FRAME:AddMessage("** CombatZoom: Mounted View Saved **", 0.5, 1.0, 0.0);
	else
		DEFAULT_CHAT_FRAME:AddMessage("** CombatZoom **    Usage: '/cbz argument' or '/combatzoom argument' ", 0.5, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   ------------------------------  ", 0.5, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   /cbz toggle  - Enable / disable CombatZoom", 0.5, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   /cbz combat  - Saves current camera angle as the combat view", 0.5, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   /cbz foot    - Saves current camera angle as view when on foot out of combat", 0.5, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   /cbz mount   - Saves current camera angle as mounted view", 0.5, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   /cbz reset   - Resets all camera angles to their defaults", 0.5, 1.0, 0.0);
		
  	end
end

function CombatZoom_Toggle() 
	if (cbz_toggle == "on") then 
		cbz_toggle = "off";
		DEFAULT_CHAT_FRAME:AddMessage("** CombatZoom is now off **", 0.5, 1.0, 0.0);
	else
		cbz_toggle = "on";
		DEFAULT_CHAT_FRAME:AddMessage("** CombatZoom is now on **", 0.5, 1.0, 0.0);
	end
end