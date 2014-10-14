-- CTRaid commands for FuBar
-- Written by MetaHawk aka Urshurak

local Tablet = AceLibrary("Tablet-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0");
CTRaidFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
ToggleFriendsFrame(4)
ToggleFriendsFrame()

CTRaidFu.hasIcon = true;
CTRaidFu.version = "2.1";
CTRaidFu.category = "map";
CTRaidFu.hasNoText = true;
CTRaidFu.defaultPosition = "RIGHT";

function CTRaidFu:OnClick()
	if(IsShiftKeyDown()) then
		ExecuteChatCommand("/tm");
	elseif(IsControlKeyDown()) then
		ExecuteChatCommand("/raready");
	else
		ExecuteChatCommand("/raoptions");
	end
end

function CTRaidFu:OnTooltipUpdate()
	if(GetNumSavedInstances() > 0) then
		cat = Tablet:AddCategory(
			"text", "\nSaved Instances:",
			"columns", 2,
			"child_textR", 1,
			"child_textG", 0,
			"child_textB", 1,
			"child_text2R", 1,
			"child_text2G", 0.85,
			"child_text2B", 0
		)
		for i=1, GetNumSavedInstances() do
			local name, ID, remaining = GetSavedInstanceInfo(i);
			remaining = SecondsToTime(remaining);
			cat:AddLine("text", name, "text2", remaining);
			cat:AddLine("text2", "|cff00ff00"..ID);
		end
	else
		local cat = Tablet:AddCategory(
			"text", "\nSaved Instances:",
			"child_textR", 1,
			"child_textG", 0,
			"child_textB", 0
		)
		cat:AddLine("text", "No saved instances found")
	end
	cat = Tablet:AddCategory(
		"text", "Hint:",
		"columns", 2,
		"child_textR", 0,
		"child_textG", 1,
		"child_textB", 0,
		"child_text2R", r,
		"child_text2G", g,
		"child_text2B", b
	)
	cat:AddLine("text", "RightClick:", "text2", "Functions")
	cat:AddLine("text", "LeftClick:", "text2", "RA Options")
	cat:AddLine("text", "ShiftClick:", "text2", "Manage Targets"	)
	cat:AddLine("text", "CtrlClick:", "text2", "Ready Check")
end

function CTRaidFu:OnMenuRequest(level, value)
	if(value == "Control Functions") then
		Dewdrop:AddLine(
			'text', value,
			'textR', 1,
			'textG', 1,
			'textB', 0
		)
		Dewdrop:AddLine(
			'text', "Broadcast Channel",
			'func', function() ExecuteChatCommand("/rabroadcast") end
		)
		Dewdrop:AddLine(
			'text', "Disband Raid",
			'func', function() ExecuteChatCommand("/radisband") end
		)
		Dewdrop:AddLine(
			'text', "Update Raid Stats",
			'func', function() ExecuteChatCommand("/raupdate") end
		)
		Dewdrop:AddLine(
			'text', "Start Ragnaros Timer",
			'func', function() ExecuteChatCommand("/ragstart") end
		)
	elseif(value == "Check Functions") then
		Dewdrop:AddLine(
			'text', value,
			'textR', 1,
			'textG', 1,
			'textB', 0
		)
		Dewdrop:AddLine(
			'text', "Durability Check",
			'func', function() ExecuteChatCommand("/radur") end
		)
		Dewdrop:AddLine(
			'text', "Ready Check",
			'func', function() ExecuteChatCommand("/raready") end
		)
		Dewdrop:AddLine(
			'text', "Reagent Check",
			'func', function() ExecuteChatCommand("/rareg") end
		)
		Dewdrop:AddLine(
			'text', "Resistance Check",
			'func', function() ExecuteChatCommand("/raresist") end
		)
		Dewdrop:AddLine(
			'text', "RLY Check",
			'func', function() ExecuteChatCommand("/rarly") end
		)
		Dewdrop:AddLine(
			'text', "Zone Check",
			'func', function() ExecuteChatCommand("/razone") end
		)
		Dewdrop:AddLine(
			'text', "Version Check",
			'func', function() ExecuteChatCommand("/raversion") end
		)
	else
		Dewdrop:AddLine(
			'text', "Show Options",
			'func', function() ExecuteChatCommand("/raoptions") end
		)
		Dewdrop:AddLine(
			'text', "Target Management",
			'func', function() ExecuteChatCommand("/tm") end
		)
		Dewdrop:AddLine(
			'text', "Show Status Monitor",
			'func', function() CT_RAMetersFrame:Show() end
		)
		Dewdrop:AddLine(
			'text', "Show Res Monitor",
			'func', function() ExecuteChatCommand("/rares show") end
		)
		Dewdrop:AddLine(
			'text', "Show All Groups",
			'func', function() ExecuteChatCommand("/rashow all") end
		)
		Dewdrop:AddLine(
			'text', "Hide All Groups",
			'func', function() ExecuteChatCommand("/rahide") end
		)
		Dewdrop:AddLine(
			'text', "Control Functions",
			'textR', 1,
			'textG', 1,
			'textB', 0,
			'hasArrow', true, 
			'value',  "Control Functions"
		)
		Dewdrop:AddLine(
			'text', "Check Functions",
			'textR', 1,
			'textG', 1,
			'textB', 0,
			'hasArrow', true, 
			'value',  "Check Functions"
		)
		Dewdrop:AddLine(
			'text', "Current Change Log",
			'func', function() ExecuteChatCommand("/ralog") end
		)
		Dewdrop:AddLine(
			'text', "Help",
			'func', function() ExecuteChatCommand("/rahelp") end
		)
		Dewdrop:AddLine('text', " ")
	end
end

function ExecuteChatCommand(arg)
	if( not DEFAULT_CHAT_FRAME ) then return end
	DEFAULT_CHAT_FRAME.editBox:SetText(arg);
	ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox);
end
