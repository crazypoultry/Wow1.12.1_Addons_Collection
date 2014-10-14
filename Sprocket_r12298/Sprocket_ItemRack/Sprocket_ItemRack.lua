local AceOO = AceLibrary("AceOO-2.0")

-- -----------------------------------------
-- AutoBarModule
--
-- Custom Sprocket module class
-- -----------------------------------------

-- Create our module
ItemRackModule = Sprocket:NewModule( "ItemRackModule" )
ItemRackModule.title = "ItemRack Set"
ItemRackModule.tooltipText = "Use to switch ItemRack Sets."

-- Called when the module is enabled
function ItemRackModule:OnEnable()
	-- Register the module with Sprocket
	self:RegisterItemModule()
end

function ItemRackModule:OnDisable()
	-- Unregister the module with Sprocket
	self:UnregisterItemModule()
end

-- Get our item class
function ItemRackModule:GetItemClass()
	return AceLibrary("ItemRackSet-2.0")
end

-- -----------------------------------------
-- ItemRackSet
--
-- Custom Sprocket item class/library
-- This class must be registered with AceLibrary!
-- -----------------------------------------

local ItemRackSet = AceOO.Class( AceLibrary("ModuleDef-2.0") )

function ItemRackSet.prototype:init( object )
	AceLibrary("ItemRackSet-2.0").super.prototype.init( self ) -- very important. Will fail without this.

	self.name = (object.name or "<None>");
end

function ItemRackSet.prototype:GetAceOptionsTable()
	local user = UnitName("player").." of "..GetRealmName();
	local options = {
				type = "group",
				args = {
					dispensor = {
						type = "group",
						desc = ItemRackModule.title,
						name = self.name,
						args = {},
					},
				},
			}
	local j = 1;
	for i in Rack_User[user].Sets do
		if (not string.find(i,"^ItemRack") and not string.find(i,"^Rack-")) then
			local name = i;
			options.args.dispensor.args["button"..j] = {};
			options.args.dispensor.args["button"..j].name = name;
			options.args.dispensor.args["button"..j].type = 'execute';
			options.args.dispensor.args["button"..j].desc = name;
			options.args.dispensor.args["button"..j].order = j;
			options.args.dispensor.args["button"..j].func = function() self.name = name end;
			j = j+1;
		end
	end
	return options;
end

function ItemRackSet.prototype:GetSavedVariables()
	return 	{
		name = self.name,
	}
end

function ItemRackSet.prototype:IsEnabled()
	return true
end

function ItemRackSet.prototype:GetTitle()
	return self.name
end

function ItemRackSet.prototype:GetIconTexture()
	local user = UnitName("player").." of "..GetRealmName();
	if (self.name ~= "<None>") then
		return Rack_User[user].Sets[self.name].icon;
	else
		return "Interface\\AddOns\\ItemRack\\ItemRack-Icon";
	end
end

function ItemRackSet.prototype:ExecItem()
	EquipSet(self:GetTitle());
	return true
end

function ItemRackSet.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( ItemRackModule.title )
	GameTooltip:AddLine( self.name )
end

AceLibrary:Register( ItemRackSet, "ItemRackSet-2.0", 1 )
ItemRackSet = nil
