-- Initialize data
FrowningCircle_Data = {
  IDs = {
    [1] = {};
    [2] = {};
    [3] = {};
    [4] = {};
  };
  -- Spellname to be used by CastSpellByName
  Spells = {
    [1] = {};
    [2] = {};
    [3] = {};
    [4] = {};
  };
  Totems = {
    [1] = {};
    [2] = {};
    [3] = {};
    [4] = {};
  };
  Offensive = {
    [1] = {};
    [2] = {};
    [3] = {};
    [4] = {};
  };

  Initialized = false;
};

function FrowningCircle_ScanSpells()
  local count = {};
  count[1] = 2;
  count[2] = 2;
  count[3] = 2;
  count[4] = 2;

  local last = nil;
  local i = 1

  while true do

    local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
    if not spellName then
      break;
    end

    if (string.find(spellName, '.* Totem$') ~= nil) then

      local school = nil;

      TotemHTT:SetSpell(i, BOOKTYPE_SPELL);
      local text = getglobal("TotemHTTTextLeft4");
      if (text ~= nil) then
        local s1, s2, schoolname = string.find(text:GetText(), "Tools: (%w*) Totem");
        if (schoolname ~= nil) then
          local j = 0;
          for j=1, 4 do
            if (TotemSchools[j] == schoolname) then
              school = j;
              break;
            end
          end
        end
      end

      if (school ~= nil) then
        if (last == spellName) then
          count[school] = count[school] - 1;
        else
          last = spellName;
        end

        FrowningCircle_Data.Offensive[school][count[school]] = FrowningCircle_TotemIsOffensive();
        FrowningCircle_Data.Spells[school][count[school]] = spellName .. '(' .. spellRank .. ')';
        FrowningCircle_Data.Totems[school][count[school]] = spellName;
        FrowningCircle_Data.IDs[school][count[school]] = i;

        count[school] = count[school] + 1;
       end
    end

    i = i + 1
  end


  for i = 1, 4 do
    for j = count[i], 7 do
      FrowningCircle_Data.Offensive[i][j] = nil;
      FrowningCircle_Data.Spells[i][j] = nil;
      FrowningCircle_Data.Totems[i][j] = nil;
      FrowningCircle_Data.IDs[i][j] = nil;
    end
  end

  FrowningCircle_Data.Initialized = true;
end

function FrowningCircle_TotemIsOffensive()
  local i, j;
  for i = 1, TotemHTT:NumLines() do
    local text = getglobal("TotemHTTTextLeft" .. i);
    j = 1;
    while (FrowningCircle_OffensiveDetection[j] ~= nil) do
      if (string.find(text:GetText(), FrowningCircle_OffensiveDetection[j]) ~= nil) then
        return true;
      end
      j = j + 1;
    end
    j = 1;
    while (FrowningCircle_FriendlyDetection[j] ~= nil) do
      if (string.find(text:GetText(), FrowningCircle_FriendlyDetection[j]) ~= nil) then
        return false;
      end
      j = j + 1;
    end
  end
  return true;
end