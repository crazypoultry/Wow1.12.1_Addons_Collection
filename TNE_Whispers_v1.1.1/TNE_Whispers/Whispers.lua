
function TNE_Whispers_OnLoad()

  TNE_Whispers_Version = "1.1.1"

  -- set default values. these will be overriden when variables are loaded
  TNE_Whispers_Default_Enabled = true
  TNE_Whispers_Default_NotificationDuration = 60
  TNE_Whispers_Default_FlashOnce = false

  TNE_Whispers_Default_FadeInTime = 0.4
  TNE_Whispers_Default_FadeOutTime = 0.8
  TNE_Whispers_Default_FadeInDelay = 0
  TNE_Whispers_Default_FadeOutDelay = 3

  TNE_Whispers_Default_Color = { 1, 1, 1 } -- r,g,b


  TNE_Whispers_Enabled = TNE_Whispers_Default_Enabled
  TNE_Whispers_NotificationDuration = TNE_Whispers_Default_NotificationDuration
  TNE_Whispers_FlashOnce = TNE_Whispers_Default_FlashOnce

  TNE_Whispers_FadeInTime = TNE_Whispers_Default_FadeInTime
  TNE_Whispers_FadeOutTime = TNE_Whispers_Default_FadeOutTime
  TNE_Whispers_FadeInDelay = TNE_Whispers_Default_FadeInDelay
  TNE_Whispers_FadeOutDelay = TNE_Whispers_Default_FadeOutDelay

  TNE_Whispers_Color = TNE_Whispers_Default_Color

  -- command line
  SlashCmdList["WhispersCMD"] = TNE_Whispers_CMD
  SLASH_WhispersCMD1 = "/whispers"

  this:SetAlpha(0)
  this:Show()
  this:RegisterEvent("VARIABLES_LOADED")

end

function TNE_Whispers_ApplySettings()

  local frame = getglobal("WhispersFrame")

  UIFrameFlashRemoveFrame(frame)
  UIFrameFadeRemoveFrame(frame)
  UIFrameFadeOut(frame, 1, frame:GetAlpha(), 0)

  -- register or unregister when turning modes on or off
  if (TNE_Whispers_Enabled) then
    frame:RegisterEvent("CHAT_MSG_WHISPER")
    frame:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
    TNE_Whispers_LastSentWhisper = 0
    WhispersFrameTexture:SetVertexColor(unpack(TNE_Whispers_Color))
  else
    frame:UnregisterEvent("CHAT_MSG_WHISPER")
    frame:UnregisterEvent("CHAT_MSG_WHISPER_INFORM")
  end

end


function TNE_Whispers_OnEvent(event)

  local now, frame = GetTime(), WhispersFrame

  if (frame.locked) then
    return
  end

  if (event == "CHAT_MSG_WHISPER") then
    if not (TNE_Whispers_LastSentWhisper > now - TNE_Whispers_NotificationDuration) then
      UIFrameFlash(frame, TNE_Whispers_FadeInTime, TNE_Whispers_FadeOutTime, TNE_Whispers_FlashOnce and 2 or -1, nil, TNE_Whispers_FadeOutDelay, TNE_Whispers_FadeInDelay)
    end
  elseif (event == "CHAT_MSG_WHISPER_INFORM") then
    TNE_Whispers_LastSentWhisper = now
    UIFrameFlashRemoveFrame(frame)
    UIFrameFadeRemoveFrame(frame)
    UIFrameFadeOut(frame, 1, frame:GetAlpha(), 0)
  end

end

function TNE_Whispers_CMD(arg1)

  if (not arg1) then
    return
  end

  ShowUIPanel(WhispersSettingsFrame)

end
