--[[
	This is a slightly modified version IsBuffActive by Tyndral, which you can find at:
		http://www.wowinterface.com/downloads/fileinfo.php?id=3994
--]]

function Bongos_IsBuffActive(buffname, unit)
	if not buffname then return end

	BIsBuffActiveTooltip:SetOwner(UIParent, "ANCHOR_NONE")

	if not unit then unit = "player" end

	if string.lower(unit) == "mainhand" then
		BIsBuffActiveTooltip:ClearLines()
		BIsBuffActiveTooltip:SetInventoryItem("player",GetInventorySlotInfo("MainHandSlot"))
		for i = 1,BIsBuffActiveTooltip:NumLines() do
			if string.find((getglobal("BIsBuffActiveTooltipTextLeft"..i):GetText() or ""),buffname) then
				return true
			end
		end
		return false
	end
	if string.lower(unit) == "offhand" then
		BIsBuffActiveTooltip:ClearLines()
		BIsBuffActiveTooltip:SetInventoryItem("player",GetInventorySlotInfo("SecondaryHandSlot"))
		for i=1,BIsBuffActiveTooltip:NumLines() do
			if string.find((getglobal("BIsBuffActiveTooltipTextLeft"..i):GetText() or ""),buffname) then
				return true
			end
		end
		return false
	end
  local i = 1
  while UnitBuff(unit, i) do
		BIsBuffActiveTooltip:ClearLines()
		BIsBuffActiveTooltip:SetUnitBuff(unit,i)
    if string.find(BIsBuffActiveTooltipTextLeft1:GetText() or "", buffname) then
      return true, i
    end
    i = i + 1
  end
  local i = 1
  while UnitDebuff(unit, i) do
		BIsBuffActiveTooltip:ClearLines()
		BIsBuffActiveTooltip:SetUnitDebuff(unit,i)
    if string.find(BIsBuffActiveTooltipTextLeft1:GetText() or "", buffname) then
      return true, i
    end
    i = i + 1
  end
end

local tooltip = CreateFrame("GameTooltip", "BIsBuffActiveTooltip", UIParent, "GameTooltipTemplate")
tooltip:Hide()