
local IFrameFactory = IFrameFactory("1.0")

coolDownButton = { }

local frameDockTable = {
	["Top"] = { "BOTTOM", nil, "TOP", 0, -2 },
    ["Bottom"] = { "TOP", nil, "BOTTOM", 0, 2 },
    ["Left"] = { "RIGHT", nil, "LEFT", 1, 0 },
    ["Right"] = { "LEFT", nil, "RIGHT", -1, 0 },
}

coolDown = { }

local iface = IFrameManager:Interface()
function iface:getName(frame)
    return "coolDown"
end

function coolDown:onLoad()
    coolDownDock:RegisterEvent("VARIABLES_LOADED")
    coolDownDock:RegisterEvent("PLAYER_ENTERING_WORLD")
    coolDownDock:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
    coolDownDock:RegisterEvent("SPELLS_CHANGED")
    coolDownDock:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    coolDownDock:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")
    coolDownDock:RegisterEvent("BAG_UPDATE_COOLDOWN")
    coolDownDock:RegisterEvent("UNIT_INVENTORY_CHANGED")

    coolDownDock:SetBackdropBorderColor(0, 0, 0, 1)
    coolDownDock:SetBackdropColor(0, 0, 0, 1)

    coolDownDock:Hide()

    IFrameManager:Register(coolDownDock, iface)
end

function coolDown:onEvent()
	coolDownDock:Show()
end

function coolDown:onUpdate()
	coolDownDock:Hide()

	IFrameFactory:Clear("coolDown", "Button")
	IFrameFactory:Clear("coolDown", "Icon")

	coolDownOptionsValidate()
	
	coolDownDock:SetScale(coolDownOptions.frameScale)

    local buttonDockInfo = frameDockTable[coolDownOptions.buttonDock]
    local iconDockInfo = frameDockTable[coolDownOptions.iconDock]
	local frameParent = coolDownDock
	for _, tbl in coolDownState do
		local buttonFrame = IFrameFactory:Create("coolDown", "Button")
		buttonFrame:SetScale(coolDownOptions.frameScale)
		
		buttonFrame.tbl = tbl
		buttonFrame.bar:SetMinMaxValues(0, tbl[3])
		buttonFrame:ClearAllPoints()
		buttonDockInfo[2] = frameParent
		if (frameParent == coolDownDock) then
			local relativeTo = buttonDockInfo[3]
			buttonDockInfo[3] = buttonDockInfo[1]
			buttonDockInfo[5], buttonDockInfo[4] = 0, 0
			buttonFrame:SetPoint(unpack(buttonDockInfo))
			buttonDockInfo[3] = relativeTo
		else
			buttonFrame:SetPoint(unpack(buttonDockInfo))
		end
		

		local iconParent = buttonFrame

		for iconIndex, spellInfo in tbl[4] do
			local iconFrame = IFrameFactory:Create("coolDown", "Icon")
			
			iconFrame:ClearAllPoints()
			iconDockInfo[2] = iconParent
			iconFrame:SetPoint(unpack(iconDockInfo))
			iconFrame.texture:SetTexture(iconIndex)
			iconFrame:SetParent(buttonFrame)

			iconParent = iconFrame
		end

		frameParent = buttonFrame
	end
end
