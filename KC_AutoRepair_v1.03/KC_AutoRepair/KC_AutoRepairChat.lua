-- Chat Command Handlers

function KC_AutoRepair:TogPrompt()
	if (not self.prompt.initialized) then
		self.Msg(self, self.locals.errors.noacegui);
		return;
	end
	self.Tog(self, "Prompt", self.locals.chat.togmsg);
end

function KC_AutoRepair:TogSkipinv()
	self.Tog(self, "SkipInv", self.locals.chat.togmsg);
end

function KC_AutoRepair:TogVerbose()
	self.Tog(self, "Verbose", self.locals.chat.togmsg);
end

function KC_AutoRepair:SetMinCost(copper)
	copper = tonumber(copper);
	if (not copper) then self.Msg(self, self.locals.errors.notcopper); return; end
	self.Set(self, "mincost", copper);
	self.Msg(self, format(self.locals.chat.togmsg, "MinCost", self:CashString(copper)))
end

function KC_AutoRepair:SetThreshold(copper)
	copper = tonumber(copper);
	if (not copper) then self.Msg(self, self.locals.errors.notcopper); return; end
	self.Set(self, "threshold", copper);
	self.Msg(self, format(self.locals.chat.togmsg, "Threshold", self:CashString(copper)))
end

function KC_AutoRepair:TogConfig()
	if (not self.config.initialized) then
		self.Msg(self, self.locals.errors.noacegui);
		return;
	end

	if (self.config:IsVisible()) then
		self.config:Hide();
	else
		self.config:Show();
	end
end

function KC_AutoRepair:Report()
	self.Msg(self, format(self.locals.chat.togmsg, "Threshold", self:CashString(self.Get(self, "threshold"))))
	self.Msg(self, format(self.locals.chat.togmsg, "MinCost", self:CashString(self.Get(self, "mincost"))))
	self.Msg(self, format(self.locals.chat.togmsg, "Verbose", self.Get(self, "verbose") and self.locals.on or self.locals.off))
	self.Msg(self, format(self.locals.chat.togmsg, "SkipInv", self.Get(self, "skipinv") and self.locals.on or self.locals.off))
	self.Msg(self, format(self.locals.chat.togmsg, "Prompt", self.Get(self, "prompt") and self.locals.on or self.locals.off))
end