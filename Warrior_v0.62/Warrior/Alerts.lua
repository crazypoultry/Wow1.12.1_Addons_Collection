WARRIOR.Alerts = {};

WARRIOR.Alerts._database = {};
WARRIOR.Alerts._enabled = true;
WARRIOR.Alerts._locked = false
WARRIOR.Alerts._type = "all";
WARRIOR.Alerts._timer = false;
WARRIOR.Alerts._fade = 3;


-- *****************************************************************************
-- Function: Reset
-- Purpose: resets the alerts
-- *****************************************************************************
function WARRIOR.Alerts:Reset()
	self._database = {};
	self._timer = false;
	WARRIORAlertsFrame:Hide();
end

-- *****************************************************************************
-- Function: OnUpdate
-- Purpose: puts alert messages up on the screen when an ability is ready
-- *****************************************************************************
function WARRIOR.Alerts:OnUpdate()
	-- hide the alert after the alotted time
	if (self._timer and self._timer + self._fade < GetTime()) then
		WARRIORAlertsFrame:Hide();
		self._timer = false;
	end

	-- alerts are disabled or target is dead
	if (not WARRIOR.Alerts._enabled or WARRIOR.Player._idle or not UnitExists("target") or UnitIsDead("target")) then return; end

	-- update the internal alert history
	for spell,time in self._database do
		if (GetTime() - time > 5) then 
			self._database[spell] = nil;
			table.sort(self._database);
			WARRIOR.Utils:Debug(3,"OnUpdate: %s removed from alert history.",spell);
		end
	end

	-- check for new alerts
	for _,spell in WARRIOR.Classes._database["ALERTS"].spells do
		if (not self._database[spell] and (self._type == "all" or (self._type == "class" and WARRIOR.Utils.Table:Find(WARRIOR.Classes._database[WARRIOR.Classes._active].spells,spell))) and not WARRIOR.Spells:IsReady(spell)) then
			self._timer = GetTime();
			self._database[spell] = self._timer;
			WARRIOR.Utils:Debug(3,"OnUpdate: %s is ready to cast.",spell);
			self:Show(spell);
			return;
		end
	end
end

-- *****************************************************************************
-- Function: Lock
-- Purpose: lock the alerts and hide draggable frame
-- *****************************************************************************
function WARRIOR.Alerts:Lock()
	if (self._locked) then
		self._locked = false;
		WARRIORAlertsFrame:Hide();
	end
end

-- *****************************************************************************
-- Function: Warrior_UnlockAlerts
-- Purpose: unlock the alerts and show draggable frame
-- *****************************************************************************
function WARRIOR.Alerts:Unlock()
	if (not self._locked) then
		self._locked = true;
		WARRIORAlertsFrame:Show();
	end
end

-- *****************************************************************************
-- Function: Show
-- Purpose: prints an alert message on the screen
-- *****************************************************************************
function WARRIOR.Alerts:Show(spell)
	if (not self._locked) then
		WARRIORAlertsFrame.spellName = spell;
		WARRIORAlertsFrame_Icon:SetTexture(WARRIOR.Spells._spellbook[spell].texture);
		WARRIORAlertsFrame_Text:SetText(strupper(spell), 0.0, 0.8, 0.6, 1.0, self._fade);
		WARRIORAlertsFrame:SetWidth(100 + WARRIORAlertsFrame_Text:GetStringWidth());
--[[
		local x,y = WARRIORAlertsFrame:GetCenter();
		WARRIORAlertsFrame:ClearAllPoints();
		WARRIORAlertsFrame:SetPoint("CENTER",UIParent,"BOTTOMLEFT",x,y);
]]--
		WARRIORAlertsFrame:Show();
	end
end

-- *****************************************************************************
-- Function: Show
-- Purpose: prints an alert message on the screen
-- *****************************************************************************
function WARRIOR.Alerts:Cast()
	if (WARRIORAlertsFrame.spellName) then
		WARRIOR.Spells:Cast(WARRIORAlertsFrame.spellName);
		WARRIORAlertsFrame.spellName = nil;
		WARRIORAlertsFrame:Hide();
	end
end
