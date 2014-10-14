
coolDownOptions = { }

local defaultOptions = {
	frameScale = 1,
	buttonDock = "Top",
	iconDock = "Right",
	minSpellDuration = 2.0,
	maxSpellDuration = 7200,
	minItemDuration = 3.0,
	backdropColor = { r = 0, g = 0, b = 0, a = 1 },
	barColor = { r = 0.4, g = 0.4, b = 0.95, a = 1 },
	textColor = { r = 1, g = 0.82, b = 0, a = 1 },
}


local function checkOption(option)
	coolDownOptions[option] = coolDownOptions[option] or defaultOptions[option]
end

local frameDockTable = {
	["Top"] = { "BOTTOM", nil, "TOP", 0, -2 },
    ["Bottom"] = { "TOP", nil, "BOTTOM", 0, 2 },
    ["Left"] = { "RIGHT", nil, "LEFT", 1, 0 },
    ["Right"] = { "LEFT", nil, "RIGHT", -1, 0 },
}


function coolDownOptionsValidate()
	checkOption("frameScale")
	
	checkOption("buttonDock")
	local buttonDirectionInfo = frameDockTable[coolDownOptions.buttonDock]
	if (buttonDirectionInfo == nil) then
		coolDownOptions.buttonDock = "Top"
	end

	checkOption("iconDock")
	local iconDockInfo = frameDockTable[coolDownOptions.iconDock]
	if (iconDockInfo == nil) then
		coolDownOptions.iconDock = "Right"
	end

	checkOption("minSpellDuration")
	checkOption("maxSpellDuration")
	checkOption("minItemDuration")
	checkOption("backdropColor")
	checkOption("barColor")
	checkOption("textColor")
end
