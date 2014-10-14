KTMD_VERSION = 0.33;
KTMD_UPDATE_INTERVAL = 0.1;
KTMD_LAST_UPDATE = 0;
KTMD_DISPLAY_ROWS = 10;
KTMD_DEBUG = 1;

BINDING_HEADER_KTMD = "KTMD";
BINDING_NAME_KTMDTOGGLE = "Toggle the KTMD window";

updatePeriods = { };
lastThreat = { };
totalThreat = { };
aggroGain = 0;
maxTPS = 0;

function calculateTPS(elapsed)
  KTMD_LAST_UPDATE = KTMD_LAST_UPDATE + elapsed;

  if( KTMD_LAST_UPDATE > KTMD_UPDATE_INTERVAL ) then
    clearRows();
    local data, playerCount, _ = KLHTM_GetRaidData();

    for i = 1, math.min(playerCount, KTMD_DISPLAY_ROWS) do
      local currentThreat = data[i].threat;
      local threatPerSecond = 0;
      local name = data[i].name;

      if( currentThreat > 0 ) then
        if( updatePeriods[name] ) then
          updatePeriods[name] = updatePeriods[name] + 1;
        else
          updatePeriods[name] = 1;
        end
        totalThreat[name] = getTotalThreat(name) + (currentThreat - getLastThreat(name));
        threatPerSecond = (getTotalThreat(name) / updatePeriods[name]) * (1 / KTMD_UPDATE_INTERVAL);
        lastThreat[name] = currentThreat;

        if (i == 1) then
          aggroGain = data[i].threat;
          maxTPS = threatPerSecond;
        end

        KTMD_DisplayThreat(i, name, threatPerSecond, getTotalThreat(name));

        maxDPS = 0;
        if( ((data[1].name == "Aggro Gain") and (data[2].name ~= UnitName("Player"))) or ((data[1].name ~= "Aggro Gain") and (data[1].name ~= UnitName("Player"))) ) then
          maxDPS = maxTPS / klhtm.my.globalthreat.value;
        end
        KTMD_DisplayMaxDPS(maxDPS);
      else
        updatePeriods[name] = 0;
        lastThreat[name] = 0;
        totalThreat[name] = 0;
      end
    end

    if( not UnitAffectingCombat("Player") ) then
      resetData();
      clearRows();
      KTMDMainFrame:SetBackdropColor(0, 0, 0, 1);
    end

    KTMD_LAST_UPDATE = KTMD_LAST_UPDATE - KTMD_UPDATE_INTERVAL;
  end
end

function getLastThreat(name)
  if(lastThreat[name]) then
    return(lastThreat[name]);
  else
    return(0);
  end
end

function getTotalThreat(name)
  if(totalThreat[name]) then
    return(totalThreat[name]);
  else
    return(0);
  end
end

function resetData()
  updatePeriods = { };
  lastThreat = { };
  totalThreat = { };
  aggroGain = 0;
  maxTPS = 0;
end