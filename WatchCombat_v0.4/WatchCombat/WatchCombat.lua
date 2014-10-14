-- WatchCombat code

-- The SKIP_MAP lists transitions which are boring and dont deserve a
-- message
local SKIP_MAP = {
   ["oov-free"] = true,
   ["free-oov"] = true,

   ["dead-oov"] = true,
   ["oov-dead"] = true,

   ["dead-free"] = true,
}

-- Messages for party members (and other things - basically not you)
local PARTY_MSG = {
   ["combat"]  = "%s has been engaged by the enemy.",
   ["oov-combat"]  = "%s is engaged by the enemy.",
   ["combat-oov"]  = "%s is no longer visible (from combat).",
   ["free"] = "%s is free from the enemy.",
   ["dead"] = "%s is dead."
}
-- Messages for you
local SELF_MSG = {
   ["combat"]  = "%s have been engaged by the enemy.",
   ["oov-combat"]  = "%s are engaged by the enemy.",
   ["combat-oov"]  = "%s are no longer visible (from combat).",
   ["free"] = "%s are free from the enemy.",
   ["dead"] = "%s are dead."
}
-- Colors for eventual transitions
local PARTY_COLOR = {
   ["combat"]  = {
      ["r"]=1.0, ["g"]=0.3, ["b"]=0.1,
   },
   ["free"] = {
      ["r"]=0.1, ["g"]=1.0, ["b"]=0.3,
   },
   ["oov"] = {
      ["r"]=0.7, ["g"]=0.7, ["b"]=0.7,
   },
   ["dead"]  = {
      ["r"]=1.0, ["g"]=0.3, ["b"]=0.1,
   }
}

-- Come up with a reasonable substitute name in the event the real one
-- isn't available yet.
local function DeriveSubstituteUnitName(unit)
   if (unit == 'pet') then
      return "Your pet";
   end
   local pet = string.gsub(unit, 'pet', '');
   if (pet ~= unit) then
      base = DeriveSubstituteUnitName(pet);
      if (string.find(base, "s$")) then
	 return base .. "' pet";
      else
	 return base .. "'s pet";
      end
   end
   local name = UnitName(unit);
   if (name == UNKNOWNOBJECT) then
      return unit;
   else
      return name;
   end
end

-- Display the notification message to the UIError area.
local function NotifyUIErrors(unit, oldState, state)
   local transCode = string.format("%s-%s",oldState,state);
   -- Ignore uninteresting transitions
   if (SKIP_MAP[transCode]) then
      return;
   end
   
   local name = UnitName(unit);
   local msgSet = PARTY_MSG;
   local colorSet = PARTY_COLOR;
   if (not name) then
      return;
   end
   if (unit == "player") then
      name = "You";
      msgSet = SELF_MSG;
   elseif (name == UNKNOWNOBJECT) then
      return DeriveSubstituteUnitName(unit);
   end

   msg = msgSet[transCode] or msgSet[state];
   color = colorSet[state];

   if (msg and color) then
      UIErrorsFrame:AddMessage(string.format(msg, name),
			       color.r, color.g, color.b, 1.0,
			       UIERRORS_HOLD_TIME);
   end
end

local Notify = NotifyUIErrors;

-- Handy debugging function
local function ShowArg(label,value)
   if (value ~= nil) then
      DEFAULT_CHAT_FRAME:AddMessage("[" .. label .. "] " .. value);
   end
end

-- Event handler for testing, unused now
--function WatchCombat_OnEvent(event)
   --[[
   ShowArg("event", event);
   for i=1,9 do
   local arg = "arg" .. i;
    ShowArg(arg, getglobal(arg));
 end
]]
--end

local curState = {};
local raidState = nil;
local partyState = nil;

-- Check for a state transition and notify
local function checkState(states, unit) 
   local old = states[unit] or 'oov';
   local now = "oov"; 
   if (UnitExists(unit)) then
      if (UnitIsDead(unit)) then
	 now = "dead";
      elseif (not UnitIsVisible(unit)) then
	 now = "oov";
      elseif (UnitAffectingCombat(unit)) then
	 now = "combat";
      else
	 now = "free";
      end
   end

   local changed = now ~= old;

   if (changed) then
      states[unit] = now;
      Notify(unit, old, now);
   end
end

local nextCheck = 0;
-- Check 20 times a second
local UPDATE_INTERVAL = 0.05;

-- The actual update handler, check for changes periodically
function WatchCombat_OnUpdate()
   local now = GetTime();
   if (now < nextCheck) then
      return;
   end
   nextCheck = now + UPDATE_INTERVAL;

   checkState(curState, "player");
   checkState(curState, "pet");

   if (GetNumRaidMembers() > 0) then
      if (not raidState) then
	 partyState = nil
	 raidState = {};
      end
      -- Raid code commented out for sanity reasons, feel free to
      -- uncomment it on your end.
      --for i=1,GetNumRaidMembers(),1 do
      --  checkState(raidState, "raid" .. i);
      --  checkState(raidState, "raidpet" .. i);
      --end
   else
      if (not partyState) then
	 raidState = nil
	 partyState = {};
      end
      for i=1,GetNumPartyMembers(),1 do
	 checkState(partyState, "party" .. i);
	 checkState(partyState, "partypet" .. i);
      end
   end
end

-- Load method, simply shows update frame to enable
function WatchCombat_OnLoad()
   this:Show();
end

