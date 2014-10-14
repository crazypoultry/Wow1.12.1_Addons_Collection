KTMD_BUTTON_HIDE = 1;
KTMD_BUTTON_RESET = 2;
KTMD_MIN_SCALE = 0.5;
KTMD_MAX_SCALE = 1.1;

windowHidden = 0;

function KTMD_OnLoad()
  SLASH_KTMD1 = "/ktmd";
  SlashCmdList["KTMD"] = KTMD_Command;
end

function KTMD_Frame_OnLoad()
  KTMDMainFrame_Title:SetText("KTMD Version " .. KTMD_VERSION);
  this:RegisterForDrag("LeftButton");
  KTMDMainFrame:SetBackdropColor(0, 0, 0, 1);
  KTMD_Show();
end

function KTMD_OnUpdate(elapsed)
  calculateTPS(elapsed);
end

function KTMD_Hide()
  KTMDMainFrame:Hide();
  windowHidden = 1;
end

function KTMD_Show()
  KTMDMainFrame:Show();
  windowHidden = 0;
end

function KTMD_Message(msg)
  DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function KTMD_Command(cmd)
	local commandlist = { };
	local command;
	
	for command in string.gfind(cmd, "[^ ]+") do
		table.insert(commandlist, string.lower(command));
	end

  if (commandlist[1] == "show") then
    KTMD_Show();
    KTMD_Message("Showing KTMD window.");
  elseif (commandlist[1] == "hide") then
    KTMD_Hide();
    KTMD_Message("Hiding KTMD window.");
  elseif (commandlist[1] == "reset") then
    clearRows();
    resetData();
    KTMD_Message("KTMD data reset.");
  elseif (commandlist[1] == "scale") then
    if( commandlist[2] ) then
      if( (tonumber(commandlist[2]) >= KTMD_MIN_SCALE) and (tonumber(commandlist[2]) <= KTMD_MAX_SCALE) ) then
        KTMD_Message("Setting KTMD scale to " .. commandlist[2]);
        KTMDMainFrame:SetScale(commandlist[2]);
        KTMDMainFrame:ClearAllPoints();
        KTMDMainFrame:SetPoint("CENTER", "UIParent");
      else
        KTMD_Message("Please enter a number between " .. KTMD_MIN_SCALE .. " and " .. KTMD_MAX_SCALE .. " to scale the window.");
      end
    else
      KTMD_Message("Usage: ");
      KTMD_Message("/ktmd scale <" .. KTMD_MIN_SCALE .. "-" .. KTMD_MAX_SCALE .. "> \-\- Scales the KTMD window");
    end
  else
    KTMD_Message("KTMD Version " .. KTMD_VERSION .. " by Terannar @ Khaz Modan\n\n");
    KTMD_Message("Usage: ");
    KTMD_Message("/ktmd show \-\- Shows the KTMD window");
    KTMD_Message("/ktmd hide \-\- Hides the KTMD window");
    KTMD_Message("/ktmd reset \-\- Resets the KTMD data");
    KTMD_Message("/ktmd scale <" .. KTMD_MIN_SCALE .. "-" .. KTMD_MAX_SCALE .. "> \-\- Scales the KTMD window");
  end
end

function KTMD_OnClick(arg1)
  id = this:GetID();

  if(id == KTMD_BUTTON_HIDE) then
    KTMD_Hide();
  elseif(id == KTMD_BUTTON_RESET) then
    resetData();
    clearRows();
    KTMD_Message("KTMD data reset.");
  end
end

function KTMD_DisplayThreat(i, name, threatPerSecond, totalThreat)
  getglobal("KTMDMainFrame_NameRow" .. i): SetText(name);
  getglobal("KTMDMainFrame_ThreatRow" .. i): SetText(totalThreat);
  getglobal("KTMDMainFrame_TPSRow" .. i): SetText(string.format("%.2d", threatPerSecond));

  TTA = (aggroGain - totalThreat) / threatPerSecond;

  if TTA == nil then
    TTA = 0;
  end

  if ((name == UnitName("Player")) and (TTA < 10)) then
    KTMDMainFrame:SetBackdropColor(1, 0, 0, 1);
  else
    KTMDMainFrame:SetBackdropColor(0, 0, 0, 1);
  end

  getglobal("KTMDMainFrame_TTARow" .. i): SetText(string.format("%2d", TTA));
end

function KTMD_DisplayMaxDPS(maxDPS)
  if( maxDPS > 0 ) then
    KTMDMainFrame_MaxDPSRow:SetText(string.format("%.2d", maxDPS) .. " Max DPS/HPS");
  else
    KTMDMainFrame_MaxDPSRow:SetText("Lower your threat!");
  end
end

function clearRows()
  for i = 1, KTMD_DISPLAY_ROWS do
    getglobal("KTMDMainFrame_NameRow" .. i): SetText("");
    getglobal("KTMDMainFrame_ThreatRow" .. i): SetText("");
    getglobal("KTMDMainFrame_TPSRow" .. i): SetText("");
    getglobal("KTMDMainFrame_TTARow" .. i): SetText("");
  end

  KTMDMainFrame_MaxDPSRow:SetText("Out of combat");
end

function KTMD_ToggleWindow()
  if( windowHidden == 1 ) then
    KTMD_Show();
  else
    KTMD_Hide();
  end
end