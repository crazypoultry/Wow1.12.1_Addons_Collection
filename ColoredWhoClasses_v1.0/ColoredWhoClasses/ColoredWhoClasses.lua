ColoredWhoClasses = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceHook-2.1")

function ColoredWhoClasses:Hook_WhoList_Update()
  local nums;
  if GetNumWhoResults() > WHOS_TO_DISPLAY then
    nums = WHOS_TO_DISPLAY
  else
    nums = GetNumWhoResults()
  end
  
  local offset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
  for i = 1, nums do
    local whoIndex = i + offset
    _, _, _, _, class = GetWhoInfo(whoIndex)
    local colors = RAID_CLASS_COLORS[strupper(class)]
    getglobal("WhoFrameButton"..i.."Class"):SetTextColor(colors.r, colors.g, colors.b)
  end
end

function ColoredWhoClasses:OnEnable()
  self:SecureHook("WhoList_Update", "Hook_WhoList_Update");
end
