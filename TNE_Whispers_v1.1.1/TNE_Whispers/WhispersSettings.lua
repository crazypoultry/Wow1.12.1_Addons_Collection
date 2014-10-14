
function TNE_WhispersSettings_OnLoad()

  local frame = "WhispersSettingsFrame"

  -- setup GUI labels
  for i, value in TNE_WhispersSettings_Labels do
    getglobal(frame.. "Label".. i):SetText(value)
  end
  getglobal(frame.. "Version"):SetText(TNE_Whispers_Version)

  -- fields and checkbuttons
  for field, buttons in TNE_WhispersSettings_CheckButtons do
    getglobal(frame.. field.. "Options".. "Title"):SetText(field)
    for i, data in buttons do
      local text, tooltip = unpack(data)
      local button = frame.. field.. "Options".. "CheckButton".. i
      getglobal(button.. "Text"):SetText(text)
      getglobal(button).tooltipText = tooltip
    end
  end

  -- sliders
  for field, sliders in TNE_WhispersSettings_Sliders do
    for i, data in sliders do
      getglobal(frame.. field.. "Options".. "ThresholdSlider".. i.. "Text"):SetText(data[1])
    end
  end

  -- regular buttons
  for i, value in TNE_WhispersSettings_Buttons do
    getglobal(frame.. "Button".. i.. "Text"):SetText(value)
  end

  -- make config window close on escape
  tinsert(UISpecialFrames, "WhispersSettingsFrame")

  -- add window to built-in UI window managment
  UIPanelWindows["WhispersSettingsFrame"] = { area = "left", pushable = 2, whileDead = 1 }

end


function TNE_WhispersSettings_SetValues(checkButtonValues, sliderValues)

  local frame = "WhispersSettingsFrame"

  -- set components
  for field, buttons in TNE_WhispersSettings_CheckButtons do
    for i in buttons do
      getglobal(frame.. field.. "Options".. "CheckButton".. i):SetChecked(checkButtonValues[field][i])
    end
  end

  -- sliders
  for field, sliders in TNE_WhispersSettings_Sliders do
    for i, _ in sliders do
      getglobal(frame.. field.. "Options".. "ThresholdSlider".. i):SetValue(sliderValues[field][i])
    end
  end

end


function TNE_WhispersSettings_OptionsSlider_OnValueChanged()

  -- set tooltip to reflect the changing value
  local frame = "WhispersSettingsFrame"
  local _, _, parent, id = string.find(this:GetName(), frame.. "(.+)OptionsThresholdSlider(.+)")
  this.tooltipText = format(TNE_WhispersSettings_Sliders[parent][tonumber(id)][2], this:GetValue())
  GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1)
  if (WhispersSettingsFrameButton4 and string.find(this:GetName(), "ParametersOptions")) then
    if (WhispersSettingsFrameButton4.state == "preview") then
      WhispersSettingsFrameButton4:Click()
    end
  end

end


function TNE_WhispersSettings_ApplySettings()

  local frame = "WhispersSettingsFrame"
  local ocb = "OptionsCheckButton"
  local ots = "OptionsThresholdSlider"

  -- set flags
  TNE_Whispers_Enabled = getglobal(frame.. "General".. ocb.. "1"):GetChecked() or false
  TNE_Whispers_FlashOnce = getglobal(frame.. "General".. ocb.. "2"):GetChecked() or false

  -- set thresholds
  TNE_Whispers_NotificationDuration = getglobal(frame.. "General".. ots.. 1):GetValue()
  TNE_Whispers_FadeInTime = getglobal(frame.. "Parameters".. ots.. 1):GetValue()
  TNE_Whispers_FadeOutTime = getglobal(frame.. "Parameters".. ots.. 2):GetValue()
  TNE_Whispers_FadeInDelay = getglobal(frame.. "Parameters".. ots.. 3):GetValue()
  TNE_Whispers_FadeOutDelay = getglobal(frame.. "Parameters".. ots.. 4):GetValue()

  -- propagate settings
  TNE_Whispers_ApplySettings()

end


function TNE_WhispersSettings_PrepareValues(default)

  default = default or ""

  local checkButtons = {
    ["General"] = {
      [1] = getglobal("TNE_Whispers".. default.. "_Enabled"),
      [2] = getglobal("TNE_Whispers".. default.. "_FlashOnce"),
    },
    ["Parameters"] = {
    },
  }

  local sliders = {
    ["General"] = { getglobal("TNE_Whispers".. default.. "_NotificationDuration"), },
    ["Parameters"] = { getglobal("TNE_Whispers".. default.. "_FadeInTime"),
                  getglobal("TNE_Whispers".. default.. "_FadeOutTime"),
                  getglobal("TNE_Whispers".. default.. "_FadeInDelay"),
                  getglobal("TNE_Whispers".. default.. "_FadeOutDelay"),
    },
  }

  TNE_WhispersSettings_SetValues(checkButtons, sliders)

end


function TNE_WhispersSettings_OnShow()

  TNE_WhispersSettings_PrepareValues()

end


function TNE_WhispersSettings_ResetSettings()

  TNE_WhispersSettings_PrepareValues("_Default")
  TNE_Whispers_Color = TNE_Whispers_Default_Color
  WhispersSettingsFrameGeneralOptionsColorSwatch:SetBackdropColor(unpack(TNE_Whispers_Color))
  WhispersFrameTexture:SetVertexColor(unpack(TNE_Whispers_Color))

end


function TNE_WhispersSettings_StopPreview()

  local frame = WhispersFrame
  UIFrameFlashRemoveFrame(frame)
  UIFrameFadeRemoveFrame(frame)
  UIFrameFadeIn(frame, 0.5, 0, 1)

end

function TNE_WhispersSettings_StartPreview()

  local ots = "OptionsThresholdSlider"

  local frame = "WhispersSettingsFrame"
  local fadeIn, fadeOut = getglobal(frame.. "Parameters".. ots.. 1):GetValue(), getglobal(frame.. "Parameters".. ots.. 2):GetValue()
  local delayIn, delayOut = getglobal(frame.. "Parameters".. ots.. 3):GetValue(), getglobal(frame.. "Parameters".. ots.. 4):GetValue()
  frame = WhispersFrame
  frame:SetAlpha(0)
  UIFrameFlash(frame, fadeIn, fadeOut, -1, nil, delayOut, delayIn)

end