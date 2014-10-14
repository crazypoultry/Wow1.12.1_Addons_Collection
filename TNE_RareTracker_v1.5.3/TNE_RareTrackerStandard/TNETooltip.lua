
TNETooltipVersion = 1

function TNE_Local_Release()
  GameTooltip:ClearLines()
  GameTooltip:Hide()
end

function TNE_Local_AnchorTo(frame)

  if (not frame) then return end

  local point = "TOPRIGHT"
  local relativePoint = "BOTTOMLEFT"

  GameTooltip:SetOwner(frame, "ANCHOR_NONE")
  GameTooltip:SetPoint(point, frame, relativePoint)

end

function TNE_Local_KeepOnScreen(frame)

  local offX = GameTooltip:GetLeft() * GameTooltip:GetEffectiveScale() < UIParent:GetLeft() * UIParent:GetEffectiveScale()
  local offY = GameTooltip:GetBottom() * GameTooltip:GetEffectiveScale() > UIParent:GetBottom() * UIParent:GetEffectiveScale()
  local point = TNEUtils.Select(offY, "TOP", "BOTTOM")
  point = point.. TNEUtils.Select(offX, "LEFT", "RIGHT")
  local relativePoint = "TOP" --TNEUtils.Select(offY, "TOP", "BOTTOM")
  relativePoint = relativePoint.. TNEUtils.Select(offX, "RIGHT", "LEFT")

  GameTooltip:ClearAllPoints()
  GameTooltip:SetPoint(point, frame, relativePoint)

end

function TNE_Local_SetHeader(header)
  GameTooltip:ClearLines()
  local color = TNEUtils.RGB["white"]
  GameTooltip:SetText(header, color.r, color.g, color.b)
end


function TNE_Local_Add(left, right, leftColor, rightColor)

  leftColor = leftColor or TNEUtils.RGB["white"]
  rightColor = rightColor or TNEUtils.RGB["white"]

  if (left and right) then
    GameTooltip:AddDoubleLine(left, right, leftColor.r, leftColor.g, leftColor.b, rightColor.r, rightColor.g, rightColor.b)
  elseif (left and not right) then
    GameTooltip:AddLine(left, leftColor.r, leftColor.g, leftColor.b)
  elseif (right and not left) then
    GameTooltip:AddLine(right, rightColor.r, rightColor.g, rightColor.b)
  else
    GameTooltip:AddLine("\n")
  end     

end


-- use only the latest copy of these functions

if (not TNETooltip) then
  TNETooltip = {}
end

local Tooltip = TNETooltip

if ((not Tooltip.version) or Tooltip.version < TNETooltipVersion) then

  Tooltip.Release = TNE_Local_Release
  Tooltip.Add = TNE_Local_Add
  Tooltip.SetHeader = TNE_Local_SetHeader
  Tooltip.AnchorTo = TNE_Local_AnchorTo
  Tooltip.KeepOnScreen = TNE_Local_KeepOnScreen

  Tooltip.version = TNETooltipVersion

end