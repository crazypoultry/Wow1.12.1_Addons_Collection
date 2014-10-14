
-- To use this template, simply	replace	all	occurances of KC_AutoRepair	with the
-- name	of your	addon.

local DEFAULT_OPTIONS = {
	prompt	= TRUE,
	skipinv = FALSE,
	verbose = TRUE,
	mincost = 0,
	threshold = 0,
}

--[[--------------------------------------------------------------------------------
  Class	Definition
-----------------------------------------------------------------------------------]]

KC_AutoRepair = AceAddonClass:new({
	name			= KC_AUTOREPAIR_LOCALS.name,
	description		= KC_AUTOREPAIR_LOCALS.desc,
	version			= "1.03",
	releaseDate		= "01/19/06",
	aceCompatible	= "100", 
	author			= "Kaelten",
	email			= "kaelten@gmail.com",
	website			= "http://kaelcycle.wowinterface.com",
	category		= "inventory",
	optionsFrame	= "KC_AutoRepairConfig",
	defaults		= DEFAULT_OPTIONS,
	defaults		= DEFAULT_OPTIONS,
	db				= AceDbClass:new("KC_AutoRepairDB"),
	cmd				= AceChatCmdClass:new(KC_AUTOREPAIR_LOCALS.chat.commands, KC_AUTOREPAIR_LOCALS.chat.options),
	locals			= KC_AUTOREPAIR_LOCALS,
	prompt			= KC_AUTOREPAIRPROMPT.prompt,
	prompt_config	= KC_AUTOREPAIRPROMPT.config,
	config			= KC_AUTOREPAIRCONFIG.frame,
	config_config	= KC_AUTOREPAIRCONFIG.config,

	Msg   = function(self, ...)
		self.cmd:msg(unpack(arg))
	end,
	Get   = function(self, var)
		return self.db:get(self.profilePath, var)
	end,
	Set   = function(self, var, val)
		self.db:set(self.profilePath, var, val)
	end,
	Tog   = function(self, var, chat)
		self.cmd:result(format(chat, var, self.db:toggle(self.profilePath, strlower(var)) and self.locals.on or self.locals.off))
	end,
})

--[[--------------------------------------------------------------------------------
  Addon	Enabling/Disabling
-----------------------------------------------------------------------------------]]
function KC_AutoRepair:Initialize()
	self.prompt:Initialize(self, self.prompt_config);
	self.config:Initialize(self, self.config_config);
end

function KC_AutoRepair:Enable()
	self:RegisterEvent("MERCHANT_SHOW", "MerchantHandler");
end

--[[--------------------------------------------------------------------------------
  Helpers
-----------------------------------------------------------------------------------]]

function KC_AutoRepair:GetInvRepairCost()
	local invcost = 0;

	for bag = 0,4 do	
		for slot = 1, GetContainerNumSlots(bag) do
			local _, repairCost = KCAutoRepairTip:SetBagItem(bag,slot);
			if (repairCost) then invcost = invcost + repairCost; end
		end
	end

	return invcost;
end


function KC_AutoRepair:CashString(amt)
	if (not amt) then error(self.locals.errors.noamt, 2); end

    local str = ""; local sep = " ";
	local silCol	= "|c00C0C0C0";
	local copCol	= "|c00CC9900";
	local golCol	= "|c00FFFF66";

    if (amt == 0) then
		return copCol .. "0 " .. self.locals.colors.copper;	
    end
    
	local copper = mod(floor(amt + .5),      100);
    local silver = mod(floor(amt/100),       100);
    local gold   = mod(floor(amt/(100*100)), 100);
    
    if ( gold   > 0 ) then str = golCol .. gold .. sep .. self.locals.colors.gold; end
    if ( silver > 0 ) then
        if ( str ~= "" ) then str = str .. sep end;
        str = str .. silCol .. silver .. sep .. self.locals.colors.silver;
    end;
    if ( copper > 0 ) then
        if ( str ~= "" ) then str = str .. sep end;
        str = str .. copCol .. copper .. sep .. self.locals.colors.copper;
    end;

    return str;
end

--[[--------------------------------------------------------------------------------
  Event Handlers
-----------------------------------------------------------------------------------]]
function KC_AutoRepair:MerchantHandler()
	if (CanMerchantRepair()) then	
		
		local equipCost = GetRepairAllCost();
		local invCost   = self:GetInvRepairCost();
		local totalCost = equipCost + invCost;

		local funds     = GetMoney();	
		
		local threshold = tonumber(self.Get(self, "threshold")) or 0;
		local mincost   = tonumber(self.Get(self, "mincost")) or 0;

		if (self.Get(self, "prompt") and totalCost > mincost) then
			if (totalCost > threshold) then
				self.prompt:Show();				
			elseif (totalCost < funds) then
				self:RepairEquipment();
				if (not self.Get(self, "skipinv")) then
					self:RepairInventory();					
				end
			end
		elseif (not self.Get(self, "prompt")) then
			if (totalCost > mincost) then
				self:RepairEquipment();

				if (not self.Get(self, "skipinv")) then
					self:RepairInventory();					
				end
				
			elseif (totalCost > threshold and totalCost > mincost) then
				--TODO: Add Chat Message On Verbose.
			end
		end
		self:MessageLogic();
	end
end

function KC_AutoRepair:RepairInventory()
	self.InventoryCost = self:GetInvRepairCost();
	ShowRepairCursor();
	local bag, slot;
	for bag = 0,4,1 do	
		for slot = 1, GetContainerNumSlots(bag) do
			local _, repairCost = KCAutoRepairTip:SetBagItem(bag,slot);
			if (repairCost and repairCost > 0) then
				PickupContainerItem(bag,slot);
			end
		end
	end
	HideRepairCursor();	
end

function KC_AutoRepair:RepairEquipment()
	self.EquipmentCost = GetRepairAllCost();
	RepairAllItems();
end

function KC_AutoRepair:MessageLogic()
	if (not self.Get(self, "verbose")) then return;	end
	
	if (self.InventoryCost and self.EquipmentCost) then
		self:BothMessage();
	elseif(self.InventoryCost) then
		self:InventoryMessage();
	elseif(self.EquipmentCost) then
		self:EquipmentMessage();
	end

	self.InventoryCost = nil;
	self.EquipmentCost = nil;
end

function KC_AutoRepair:EquipmentMessage()
	self.Msg(self, format(self.locals.msgs.equipment, self:CashString(self.EquipmentCost)))
end

function KC_AutoRepair:InventoryMessage()
	self.Msg(self, format(self.locals.msgs.inventory, self:CashString(self.InventoryCost)))
end

function KC_AutoRepair:BothMessage()
	self.Msg(self, format(self.locals.msgs.both, self:CashString(self.EquipmentCost + self.InventoryCost)))
end
--[[--------------------------------------------------------------------------------
  Create and Register Addon	Object
-----------------------------------------------------------------------------------]]

KC_AutoRepair:RegisterForLoad();
