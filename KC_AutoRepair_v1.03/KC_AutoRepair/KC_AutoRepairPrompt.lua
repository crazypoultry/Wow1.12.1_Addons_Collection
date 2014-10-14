KC_AUTOREPAIRPROMPT = {}
local locals   = KC_AUTOREPAIR_LOCALS;

KC_AUTOREPAIRPROMPT.config = {
	name		= "KC_AutoRepairPrompt",
	type		= ACEGUI_DIALOG,
	title		= locals.prompt.title,
	backdrop	= "small",
	isSpecial	= TRUE,
	width		= 428,
	height		= 160,
	OnShow		= "OnShow",
	elements	= {
		Frame	 = {
			type	 = ACEGUI_OPTIONSBOX,
			title	 = "",
			width	 = 396,
			height	 = 85,
			anchors	 = {
				topleft	= {xOffset = 16, yOffset = -31}
			},
			elements = {
				Line1L = {
					type	= ACEGUI_FONTSTRING, 
					value   = locals.prompt.line1,
					anchors	 = {
						clear = TRUE,
						topleft = {relTo = "KC_AutoRepairPromptFrame", relPoint= "topleft", xOffset = 10, yOffset = -18},
					},
				},
				Line2L = {
					type	= ACEGUI_FONTSTRING, 
					value   = locals.prompt.line2,
					anchors	 = {
						clear = TRUE,
						topleft = {relTo = "KC_AutoRepairPromptFrameLine1L", relPoint= "bottomleft", xOffset = 0, yOffset = -3},
					},
				},
				Line3L = {
					type	= ACEGUI_FONTSTRING, 
					value   = locals.prompt.line3,
					anchors	 = {
						clear = TRUE,
						topleft = {relTo = "KC_AutoRepairPromptFrameLine2L", relPoint= "bottomleft", xOffset = 0, yOffset = -3},
					},
				},
				Line1R = {
					type	= ACEGUI_FONTSTRING, 
					value   = "",
					anchors	 = {
						clear = TRUE,
						bottomleft = {relTo = "KC_AutoRepairPromptFrameLine2R", relPoint= "topleft", xOffset = 0, yOffset = 3},
					},
				},
				Line2R = {
					type	= ACEGUI_FONTSTRING, 
					value   = "",
					anchors	 = {
						clear = TRUE,
						left = {relTo = "KC_AutoRepairPromptFrameLine2L", relPoint= "right", xOffset = 5, yOffset = 0},
					},
				},
				Line3R = {
					type	= ACEGUI_FONTSTRING, 
					value   = "",
					anchors	 = {
						clear = TRUE,
						topleft = {relTo = "KC_AutoRepairPromptFrameLine2R", relPoint= "bottomleft", xOffset = 0, yOffset = -3},
					},
				},
			}
		},
		Inventory  = {
			type	 = ACEGUI_BUTTON,
			title	 = locals.prompt.inventory,
			width	 = 98,
			height	 = 26,
			anchors	 = {
				topright = {relTo = "$parentEquipment", relPoint = "topleft", xOffset = -2, yOffset = 0}
			},
			OnClick	 = "RepairInventory"
		},
		Equipment  = {
			type	 = ACEGUI_BUTTON,
			title	 = locals.prompt.equipment,
			width	 = 98,
			height	 = 26,
			anchors	 = {
				topright = {relTo = "$parentBoth", relPoint = "topleft", xOffset = -2, yOffset = 0}
			},
			OnClick	 = "RepairEquipment"
		},
		Both  = {
			type	 = ACEGUI_BUTTON,
			title	 = locals.prompt.both,
			width	 = 98,
			height	 = 26,
			anchors	 = {
				topright = {relTo = "$parentClose", relPoint = "topleft", xOffset = -2, yOffset = 0}
			},
			OnClick	 = "RepairBoth"
		},
	}
}

if (AceGUI) then
	KC_AUTOREPAIRPROMPT.prompt = AceGUI:new();	
else
	KC_AUTOREPAIRPROMPT.prompt = AceGUIDummy:new();
end



local frame = KC_AUTOREPAIRPROMPT.prompt;

function frame:OnShow()
	local equipCost = GetRepairAllCost();
	local invCost	= self.app:GetInvRepairCost();
	local totalCost = equipCost + invCost;
	
	local funds = GetMoney();
	
	if (equipCost == 0 or equipCost > funds) then
		self.Equipment:Disable();
	else
		self.Equipment:Enable();
	end

	if (invCost == 0 or invCost > funds) then
		self.Inventory:Disable();
	else
		self.Inventory:Enable();
	end

	if (invCost > 0 and equipCost > 0 and totalCost < funds) then
		self.Both:Enable();
	else
		self.Both:Disable();
	end

	self.Frame.Line1R:SetValue(self.app:CashString(invCost));
	self.Frame.Line2R:SetValue(self.app:CashString(equipCost));
	self.Frame.Line3R:SetValue(self.app:CashString(totalCost));
end

function frame:RepairBoth()
	self.app:RepairEquipment();
	self.app:RepairInventory();
	self.app:MessageLogic()
	self:Hide();
end

function frame:RepairEquipment()
	self.app:RepairEquipment();
	self.app:MessageLogic()
	self:Hide();
end

function frame:RepairInventory()
	self.app:RepairInventory();
	self.app:MessageLogic()
	self:Hide();
end