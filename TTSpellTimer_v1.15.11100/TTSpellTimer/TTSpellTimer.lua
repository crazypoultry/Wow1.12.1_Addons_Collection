-- ============================================================================
-- TTSpellTimer.lua
--
-- Copyright (c) Matthew Johnson.  All rights reserved.
--
-- This work may be freely adapted and distributed as long as this notice remains intact.
-- This work may NOT be (re)sold or included in any compilations that are (re)sold.
--
-- ============================================================================

-- ============================================================================
-- Global defines.
-- ============================================================================
TTST_MAX_TIMERS = 8;
TTST_MAX_TIMERSEX = 8;

TTST_EVENT_EXPIRES = 3;

TTST_Hooks =
	{
	Default_CastPetAction = nil,
	Default_CastSpell = nil,
	Default_CastSpellByName = nil,
	Default_SpellStopTargeting = nil,
	Default_SpellTargetUnit = nil,
	Default_TargetUnit = nil,
	Default_UseAction = nil,
	};

TTST_HookState =
	{
	Spell = nil,
	Rank = nil,
	Target = nil,
	UnitId = nil,
	};

TTST_RequiredEvents =
	{
	"PET_UI_CLOSE",
	"SPELLCAST_FAILED",
	"SPELLCAST_INTERRUPTED",
	"SPELLCAST_START",
	"SPELLCAST_STOP",
	"UNIT_AURA",
	"UNIT_COMBAT",
	"UNIT_PET",
	"VARIABLES_LOADED",
	};

-- ============================================================================
-- Global variables.
-- ============================================================================
TTST_EventQueue = {};

TTST_Table_Timers = {};
TTST_Table_TimersEx = {};

TTST_ComboPoints = 0;

-- ============================================================================
-- OnEvent
-- ============================================================================
function TTST_OnEvent()

	-- Only call our generic handlers if we're enabled.
	if (TTST_SpellDataUser.Settings.Disabled == nil or TTST_SpellDataUser.Settings.Disabled == "no") then

		-- Call the generic spell handler.
		TTST_EventHandler_Generic(event, arg1, arg2, arg3, arg4, arg5);

		-- Call the default handler.
		TTST_EventHandler_Default(event, arg1, arg2, arg3, arg4, arg5);

	end

	if (event == "VARIABLES_LOADED") then

		if (TTST_SpellDataUser.Settings.TimerFrameAnchor == nil) then
			TTST_SpellDataUser.Settings.TimerFrameAnchor = "TOPLEFT";
		end

		if (TTST_SpellDataUser.Settings.HideBackground == nil) then
			TTST_SpellDataUser.Settings.HideBackground = "yes";
		end

		-- Adjust the location.
		if (TTST_SpellDataUser.Settings.TimerFramePosition ~= nil and TTST_SpellDataUser.Settings.TimerFramePosition.x ~= nil and TTST_SpellDataUser.Settings.TimerFramePosition.y ~= nil) then

			TTST_TimerFrame:ClearAllPoints();
			TTST_TimerFrame:SetPoint(TTST_SpellDataUser.Settings.TimerFrameAnchor, "UIParent", "BOTTOMLEFT", TTST_SpellDataUser.Settings.TimerFramePosition.x, TTST_SpellDataUser.Settings.TimerFramePosition.y);
			TTST_TimerFrame:SetMovable(true);
			TTST_TimerFrame:SetUserPlaced(true);

		end

		-- Adjust the scaling.
		if (TTST_SpellDataUser.Settings.TimerScaling == nil) then
			TTST_SpellDataUser.Settings.TimerScaling = TTST_SpellDataDefault.Settings.TimerScaling;
		end
		TTST_TimerFrame:SetScale(TTST_SpellDataUser.Settings.TimerScaling);

	elseif (event == "UNIT_COMBAT" and GetComboPoints() > 0) then

		TTST_ComboPoints = GetComboPoints();

	end

end

-- ============================================================================
-- OnLoad
-- ============================================================================
function TTST_OnLoad()

	-- Register events required for the spells used in this addon.
	for index, event in TTST_RequiredEvents do
		this:RegisterEvent(event);
	end
	
	-- In order to detect instant cast spells, we need to hook a number of
	-- default API functions.
	TTST_Hooks.Default_CastPetAction = CastPetAction;
	CastPetAction = TTST_Override_CastPetAction;

	TTST_Hooks.Default_CastSpell = CastSpell;
	CastSpell = TTST_Override_CastSpell;

	TTST_Hooks.Default_CastSpellByName = CastSpellByName;
	CastSpellByName = TTST_Override_CastSpellByName;

	TTST_Hooks.Default_SpellStopTargeting = SpellStopTargeting;
	SpellStopTargeting = TTST_Override_SpellStopTargeting;

	TTST_Hooks.Default_SpellTargetUnit = SpellTargetUnit;
	SpellTargetUnit = TTST_Override_SpellTargetUnit;

	TTST_Hooks.Default_TargetUnit = TargetUnit;
	TargetUnit = TTST_Override_TargetUnit;

	TTST_Hooks.Default_UseAction = UseAction;
	UseAction = TTST_Override_UseAction;

	TTST_InitializeSpellMapping();

end

-- ============================================================================
-- OnUpdate
-- ============================================================================
function TTST_OnUpdate()

	-- Update each timer group.
	TTST_OnUpdate_TimerGroup(TTST_Table_Timers, "TTST_Timers", TTST_MAX_TIMERS);
	TTST_OnUpdate_TimerGroup(TTST_Table_TimersEx, "TTST_TimersEx", TTST_MAX_TIMERSEX);

	-- Update the size of the timer frame.
	TTST_OnUpdate_TimerSize();

end

-- ============================================================================
-- OnUpdate_TimerGroup
-- ============================================================================
function TTST_OnUpdate_TimerGroup(timerGroup, timerGroupName, maxTimers)

	-- Loop through all of the active timers and update them.
	local cActiveTimers = 0;

	-- Loop through all of the timers.
	for index=1, getn(timerGroup), 1 do

		-- Bail if there are more timers then we have timer frames.
		if (index > maxTimers) then
			break;
		end

		local value = timerGroup[index];

		if (value == nil) then
			break;
		end

		-- Remove the timer if we're not in combat and the timer's auto remove
		-- flag is set to true.
		if (not UnitAffectingCombat("player") and TTST_GetSpellUserProperties(value.SpellName).AutoRemove) then
			TTST_RemoveTimer(timerGroup, index);
		end

		-- Compute the time remaining, in seconds.
		local timeLeft = value.Expires - GetTime();

		-- Remove the timer if it has expired.
		if (timeLeft < 0) then

			TTST_RemoveTimer(timerGroup, index);

		-- Otherwise, update the timer.
		else

			cActiveTimers = cActiveTimers + 1;

			local colorArray;
			local spellData = TTST_GetSpellProperties(value.SpellName);
			local timerFrameName = timerGroupName .. "_Timer" .. cActiveTimers;
			local timeLeftFrame = getglobal(timerFrameName .. "_TimeLeft");
			local textureFrame = getglobal(timerFrameName .. "_Texture");

			-- Set the timer's texture.
			textureFrame:SetTexture(value.Texture);

			-- Set the time remaining.
			timeLeftFrame:SetText(TTST_SecondsToTime(timeLeft));

			-- Adjust the timer text color.
			local start, warning, critical = TTST_GetSpellDuration(value.SpellName, value.SpellRank);
			if (timeLeft <= critical) then
				colorArray = TTST_SpellDataDefault.Settings.TimerColors.Critical;
			elseif (timeLeft <= warning) then
				colorArray = TTST_SpellDataDefault.Settings.TimerColors.Warning;
			else
				colorArray = TTST_SpellDataDefault.Settings.TimerColors.Default;
			end

			timeLeftFrame:SetTextColor(colorArray.r, colorArray.g, colorArray.b);

			-- If this is an ex timer, then we should update the spell name and spell target.
			if (timerGroupName == "TTST_TimersEx") then

				local spellNameFrame = getglobal(timerFrameName .. "_SpellName");
				local targetNameFrame = getglobal(timerFrameName .. "_TargetName");

				spellNameFrame:SetText("");
				targetNameFrame:SetText("");

				local userProperties = TTST_GetSpellUserProperties(value.SpellName);

				if (userProperties.ShowSpellName) then
					spellNameFrame:SetText(value.SpellName);
				end

				if (userProperties.ShowTargetName) then
					targetNameFrame:SetText(value.SpellTarget);
				end

			end

			-- Set some properties on the timer frame so we can access them later.
			getglobal(timerFrameName).SpellName = value.SpellName;
			getglobal(timerFrameName).TargetName = value.SpellTarget;

			-- Make sure the timer is visible.
			getglobal(timerFrameName):Show();

		end

	end

	-- Loop through any unused timers and hide them.
	for i=cActiveTimers+1, maxTimers, 1 do
		getglobal(timerGroupName .. "_Timer" .. i):Hide();
	end

end

-- ============================================================================
-- OnUpdate_TimerSize
--
-- Adjusts the size of the timer window's background color so that it
-- encompasses all of the timers.  This will also update the width of each
-- individual timer to a minimal width based on the text.
-- ============================================================================
function TTST_OnUpdate_TimerSize()

	local dx = 0;

	local cTimers = min(getn(TTST_Table_Timers), TTST_MAX_TIMERS);
	local cTimersEx = min(getn(TTST_Table_TimersEx), TTST_MAX_TIMERSEX);

	-- Loop through any active ex timers and find a minimal width.
	for index=1, cTimersEx, 1 do

		local timerFrameName = "TTST_TimersEx_Timer" .. index;
		local spellNameFrame = getglobal(timerFrameName .. "_SpellName");
		local targetNameFrame = getglobal(timerFrameName .. "_TargetName");

		local width = 36 + max(spellNameFrame:GetStringWidth(), targetNameFrame:GetStringWidth());
		if (width > dx) then
			dx = width;
		end

	end

	local dxTimers = 0;
	local dxTimersEx = 0;

	-- Compute the size of the timer frame.
	if (cTimers > 4) then
		dxTimers = 64;
	elseif (cTimers > 0) then
		dxTimers = 32;
	end

	-- Compute the size of the timer ex frame.
	if (cTimersEx > 0) then
		dxTimersEx = 32 * cTimersEx;
	end

	-- Compute the width of the parent frame.
	dx = max(min(128, cTimers * 32), dx);

	-- Adjust the size of the frames.
	TTST_Timers:SetHeight(dxTimers);
	TTST_TimersEx:SetHeight(dxTimersEx);

	-- We need this case to make sure the timer frame appears
	-- properly when the user wants to explicitly move it.
	if (dxTimers == 0 and dxTimersEx == 0 and dx == 0) then
		dxTimers = 56;
		dx = 56;
	end

	-- Adjust the size of the parent frame.
	TTST_TimerFrame:SetHeight(8 + dxTimers + dxTimersEx);
	TTST_TimerFrame:SetWidth(8 + dx);

	-- Adjust the visibility of the timer frame.
	if (cTimers > 0) then
		TTST_Timers:Show();
	else
		TTST_Timers:Hide();
	end

	-- Adjust the visibility of the timer ex frame.
	if (cTimersEx > 0) then
		TTST_TimersEx:Show();
	else
		TTST_TimersEx:Hide();
	end

	-- Adjust the visibility of the parent frame.
	TTST_ShowTimerFrame(cTimers > 0 or cTimersEx > 0);

end

-- ============================================================================
-- TimerButton_OnClick
-- ============================================================================
function TTST_TimerButton_OnClick(button)

	if (button == "LeftButton") then

		if (IsShiftKeyDown()) then

			-- On a shift-click, we remove the timer.
			local groupName = this:GetParent():GetName();
			local timerGroup = nil;

			if (groupName == "TTST_Timers") then
				timerGroup = TTST_Table_Timers;
			elseif (groupName == "TTST_TimersEx") then
				timerGroup = TTST_Table_TimersEx;
			end

			TTST_RemoveTimer(timerGroup, this:GetID());

		else

			-- On a left-click, we'll try to target the first named mob that is
			-- still alive.
			local timerFrame = getglobal(this:GetParent():GetName() .. "_Timer" .. this:GetID());
			local targetName = timerFrame.TargetName;

			if (targetName == nil) then
				return;
			end

			TargetByName(targetName);

			-- If the target is dead, try to find a new target.
			if (UnitIsDead("target")) then
			
				local cLoops = 0;
				while (cLoops < 10) do

					TargetNearestEnemy();

					if (UnitName("target") == targetName and not UnitIsDead("target")) then
						break;
					end

					cLoops = cLoops + 1;

				end

				-- No target found.
				ClearTarget();

			end
					
		end

	end

end

-- ============================================================================
-- CreateTimer
-- ============================================================================
function TTST_CreateTimer(spellName, spellRank, spellTarget)

	local properties = TTST_GetSpellProperties(spellName);
	local userProperties = TTST_GetSpellUserProperties(spellName);

	-- If the timer is unique, then make sure we remove any old timers with
	-- the same spell name.
	if (properties.Unique) then
		TTST_RemoveTimerByName(spellName);
	end

	-- Only bother creating a timer if the duration is > 0.
	if ((userProperties.Enabled) and (TTST_GetSpellDuration(spellName, spellRank) > 0)) then

		local timerData =
			{
			Expires = GetTime() + TTST_GetSpellDuration(spellName, spellRank) + TTST_GetTalentTimeModifier(spellName),
			SpellName = spellName,
			SpellRank = spellRank,
			SpellTarget = spellTarget,
			Texture = properties.Texture;
			};

		-- Adjust the timer to account for combo points.
		if (properties.ComboModifier) then
			timerData.Expires = timerData.Expires + properties.ComboModifier * (TTST_ComboPoints - 1);
		end

		-- Add the timer to the appropriate timer group.
		if (userProperties.ShowSpellName or userProperties.ShowTargetName) then
			tinsert(TTST_Table_TimersEx, timerData);
		else
			tinsert(TTST_Table_Timers, timerData);
		end

		-- We just added a timer, so make sure the window is visible.
		TTST_ShowTimerFrame(true);

	end

	-- Broadcast a message, if any.
	if ((userProperties.EnabledAutoMessage) and (userProperties.AutoChat.Message ~= nil)) then
		if (spellTarget == nil) then
			spellTarget = "";
		end
		TTST_BroadcastMessage(spellName, string.gsub(userProperties.AutoChat.Message, "%%target%%", spellTarget));
	end

	-- Any time we create a timer, reset the spell's state.
	TTST_GetSpellProperties(spellName).State = TTST_SpellState.None;

end

-- ============================================================================
-- RemoveTimer
-- ============================================================================
function TTST_RemoveTimer(timerGroup, index)

	tremove(timerGroup, index);

end

-- ============================================================================
-- RemoveTimerByName
-- ============================================================================
function TTST_RemoveTimerByName(spellName)

	-- Search all of our timers and remove the first one we find that matches
	-- the given spell name.
	for index=1, getn(TTST_Table_Timers), 1 do

		local value = TTST_Table_Timers[index];

		if (value ~= nil) then

			if (value.SpellName == spellName) then

				TTST_RemoveTimer(TTST_Table_Timers, index);
				return;

			end

		end

	end

	for index=1, getn(TTST_Table_TimersEx), 1 do

		local value = TTST_Table_TimersEx[index];

		if (value ~= nil) then

			if (value.SpellName == spellName) then

				TTST_RemoveTimer(TTST_Table_TimersEx, index);
				return;

			end

		end

	end

end

-- ============================================================================
-- ShowTimerFrame
--
-- Used to show/hide the timer frame.
-- ============================================================================
function TTST_ShowTimerFrame(show)

	-- Make sure the timer frame is positioned properly, if the position hasn't
	-- been customized.
	if (not TTST_TimerFrame:IsUserPlaced()) then

		local dx = -26;
		local dy = 0;

		if (MinimapCluster:IsVisible()) then
			dy = dy - MinimapCluster:GetHeight() - 8;
		end
		if (MultiBarRight:IsVisible()) then
			dx = dx - MultiBarRight:GetWidth();
		end
		if (MultiBarLeft:IsVisible()) then
			dx = dx - MultiBarLeft:GetWidth();
		end
		if (QuestWatchFrame:IsVisible()) then
			dy = dy - QuestWatchFrame:GetHeight() - 16;
		end

		-- Adjust dx and dy to account for scaling.
		local general = TTST_GetGeneralSettings();
		dx = dx / general.TimerScaling;
		dy = dy / general.TimerScaling;

		TTST_TimerFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", dx, dy);

	end

	-- Determine if the background should be visible.
	if (TTST_Settings_InMove or (TTST_SpellDataUser.Settings.HideBackground and TTST_SpellDataUser.Settings.HideBackground == "no")) then
		TTST_TimerFrame_Background:Show();
	else
		TTST_TimerFrame_Background:Hide();
	end

	-- Set the timer frame visibility.
	if (show) then
		TTST_TimerFrame:Show();
	elseif (not TTST_Settings_InMove) then
		TTST_TimerFrame:Hide();
	end

end

-- ============================================================================
-- BroadcastMessage
--
-- Broadcasts a message based on the user settings for that spell.  Priority
-- order for messages is always: raid, party, yell, say.
-- ============================================================================
function TTST_BroadcastMessage(spellName, msg)

	-- Don't post anything if the message is nil.
	if (msg == nil) then
		return;
	end

	-- Don't do anything if the user disabled auto chat messages.
	if (TTST_SpellDataUser.Settings.DisableAutoMessages and TTST_SpellDataUser.Settings.DisableAutoMessages == "yes") then
		return;
	end

	local system;
	local messageData = TTST_GetSpellUserProperties(spellName).AutoChat.Enabled;

	-- Check to see if we should emote.
	if (messageData.Emote) then

		system = "EMOTE";

	-- Check to see if we should broadcast to the entire raid.
	elseif (messageData.Raid and GetNumRaidMembers() > 0) then

		system = "RAID";

	-- Check to see if we should broadcast to the party.
	elseif (messageData.Party and GetNumPartyMembers() > 0) then

		system = "PARTY";

	-- Check to see if we should yell.
	elseif (messageData.Yell) then

		system = "YELL";

	-- Check to see if we should just say it.
	elseif (messageData.Say) then

		system = "SAY";

	-- No messages are enabled, so do nothing.
	else
	
		return;

	end

	SendChatMessage(msg, system);		

end

-- ============================================================================
-- SecondsToTime
-- ============================================================================
function TTST_SecondsToTime(time)

	local timeFormat = TTST_GetGeneralSettings().TimeFormat;

	if (timeFormat == TTST_TimeFormat.MMSSTT) then

		local tempTime = "";

		local hours = math.floor(time / 3600);
		time = math.mod(time, 3600);
		if (hours ~= 0) then
			tempTime = hours .. ":";
		end
		
		local minutes = math.floor(time / 60);
		time = math.mod(time, 60);
		if (minutes ~= 0 or tempTime ~= "") then
			tempTime = tempTime .. minutes;
		end
		
		-- Only show seconds and tenths if we don't have hours or minutes.
		if (hours == 0 and minutes == 0) then

			local seconds = math.floor(time);
			tempTime = tempTime .. seconds;

			local tenths = math.floor(math.mod(time * 10, 10));
			tempTime = tempTime .. "." .. tenths;
				
		else
			tempTime = tempTime .. " m";
		end

		return tempTime;

	else

		return SecondsToTimeAbbrev(time);

	end

end

-- ============================================================================
-- FindDebuffByName
-- ============================================================================
function TTST_FindDebuffByName(targetUnit, debuffSubString)

	if (debuffSubString == nil) then
		return false;
	end

	-- Search the target for the debuff.
	local i = 1;

	while (UnitDebuff(targetUnit, i)) do

		if (string.find(UnitDebuff(targetUnit, i), debuffSubString)) then

			-- Found the debuff.
			return true;

		end

		i = i + 1;

	end

	return false;

end

-- ============================================================================
-- GetTalentTimeModifier
-- ============================================================================
function TTST_GetTalentTimeModifier(spellName)

	local properties = TTST_GetSpellProperties(spellName);

	if (properties ~= nil and properties.Talents ~= nil) then

		for key, value in properties.Talents do

			-- Look up the talent to see if the player has any points in it.
			local name, texture, x, y, rank = GetTalentInfo(value.TreeId, value.TalentId);

			-- Verify the talent name matches the key.
			if (key == name and rank > 0) then
				return value.Ranks[rank];
			end

		end

	end

	return 0;

end

-- ============================================================================
-- Override_CameraOrSelectOrMoveStart
-- ============================================================================
function TTST_Override_CameraOrSelectOrMoveStart()

	-- We do this before calling the default function because the default will
	-- update the cursor and the mouseover target won't be valid.

	-- Make sure we have a valid spell name and that the cursor has a spell
 	-- attached to it.
	if (TTST_HookState.Spell ~= nil and UnitName("mouseover")) then
	
		-- Now that we have the mouse target, update our hook state with the target
		-- that was actually targetted by the spell.
		TTST_HookState.Target = UnitName("mouseover");
		TTST_HookState.UnitId = "mouseover";

		-- Create the timer by mimicing a SPELLCAST_STOP event.
		TTST_EventHandler_Generic("SPELLCAST_STOP");

	end

	-- Call the original function.
	TTST_Hooks.Default_CameraOrSelectOrMoveStart();

end

-- ============================================================================
-- Override_CastPetAction
--
-- This is so we can hook into the cast spell functionality of pets so we can
-- properly detect pet spells.
-- ============================================================================
function TTST_Override_CastPetAction(slotId)

	-- Call the original function.
	TTST_Hooks.Default_CastPetAction(slotId);

	TTST_TooltipFrame:SetOwner(WorldFrame, "ANCHOR_NONE");

	-- Set our tooltip so we can get the spell name.
	TTST_TooltipFrame:SetPetAction(slotId);

	-- Get the spell name.
	local spellName = TTST_TooltipFrameTextLeft1:GetText();

	-- Get the spell rank.
	local spellRank = TTST_TooltipFrameTextRight1:GetText();

	if (spellName ~= nil) then

		TTST_CreateEventQueue(spellName, "UNIT_COMBAT", spellRank, UnitName("target"));

	end

end

-- ============================================================================
-- Override_CastSpell
--
-- This is so we can hook into the cast spell functionality so we can properly
-- detect instant cast spells.
-- ============================================================================
function TTST_Override_CastSpell(spellId, spellbookTabNum)

	-- Call the original function.
	TTST_Hooks.Default_CastSpell(spellId, spellbookTabNum);

	-- We don't hook passive skills/spells.
	if (not IsSpellPassive(spellId, spellbookTabNum)) then

		TTST_HookState.Spell, TTST_HookState.Rank = GetSpellName(spellId, BOOKTYPE_SPELL);
		TTST_HookState.Target = UnitName("target");
		TTST_HookState.UnitId = "target";

	end

end

-- ============================================================================
-- Override_CastSpellByName
-- ============================================================================
function TTST_Override_CastSpellByName(spellName, targetSelf)

	-- Call the original function.
	TTST_Hooks.Default_CastSpellByName(spellName, targetSelf);

	local spell, rank;

	-- Capture the spell name and rank.
	for s, r in string.gfind(spellName, "(.*)%((.*)%)") do
		spell = s;
		rank = r;
	end

	-- If the capture failed, then their is no rank.
	if (spell == nil and rank == nil) then
		spell = spellName;
	end

	-- Properly case the rank string.
	if (rank == nil) then
		rank = TTST_SPELL_RANK_DEFAULT;
	else
		rank = strupper(strsub(rank, 1, 1)) .. strsub(rank, 2);
	end

	-- Look up the properly cased spell name from our table.
	local spell = TTST_SpellMapping[strupper(spell)];

	if (spell == nil) then
		-- The spell is not one we time, so exit.
		return;
	end

	TTST_HookState.Spell = spell;
	TTST_HookState.Rank = rank;

	if (targetSelf) then
		TTST_HookState.Target = UnitName("player");
		TTST_HookState.UnitId = "player";
	end

end

-- ============================================================================
-- Override_SpellStopTargeting
-- ============================================================================
function TTST_Override_SpellStopTargeting()

	-- Call the original function.
	TTST_Hooks.Default_SpellStopTargeting();

	-- Reset the hook states.
	TTST_HookState.Spell = nil;
	TTST_HookState.Rank = nil;
	TTST_HookState.Target = nil;
	TTST_HookState.UnitId = nil;

end

-- ============================================================================
-- Override_SpellTargetUnit
-- ============================================================================
function TTST_Override_SpellTargetUnit(unit)

	-- We do this before calling the default function because the default will
	-- update the cursor and the mouseover target won't be valid.

	-- Make sure we have a valid spell name and that the cursor has a spell
 	-- attached to it.
	if (TTST_HookState.Spell ~= nil) then
	
		-- Now that we have the mouse target, update our hook state with the target
		-- that was actually targetted by the spell.
		TTST_HookState.Target = UnitName(unit);
		TTST_HookState.UnitId = unit;

		-- Create the timer by mimicing a SPELLCAST_STOP event.
		TTST_EventHandler_Generic("SPELLCAST_STOP");

	end

	-- Call the original function.
	TTST_Hooks.Default_SpellTargetUnit(unit);

end

-- ============================================================================
-- Override_TargetUnit
-- ============================================================================
function TTST_Override_TargetUnit(unit)

	-- Call the original function.
	TTST_Hooks.Default_TargetUnit(unit);

	TTST_HookState.Target = UnitName(unit);
	TTST_HookState.UnitId = unit;

end

-- ============================================================================
-- Override_UseAction
-- ============================================================================
function TTST_Override_UseAction(arg1, arg2, arg3)

	-- Call the original function.
	TTST_Hooks.Default_UseAction(arg1, arg2, arg3);

	-- Is this a macro?
	if (GetActionText(arg1)) then
		return;
	end

	TTST_TooltipFrame:SetOwner(WorldFrame, "ANCHOR_NONE");

	-- Set our tooltip so we can get the spell name.
	TTST_TooltipFrame:SetAction(arg1);

	-- Get the spell name.
	TTST_HookState.Spell = TTST_TooltipFrameTextLeft1:GetText();

	-- Get the spell rank.
	TTST_HookState.Rank = TTST_TooltipFrameTextRight1:GetText();

	-- The spell is targetting self, so we should remember ourselves.
	if (arg3 == 1) then

		TTST_HookState.Target = UnitName("player");
		TTST_HookState.UnitId = "player";

	-- If the spell is being cast on current target, remember it.
	else -- if (not SpellIsTargeting()) then

		TTST_HookState.Target = UnitName("target");
		TTST_HookState.UnitId = "target";

	end	

end

-- ============================================================================
-- EventHandler_Default
-- ============================================================================
function TTST_EventHandler_Default()

	if (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_STOP") then

		TTST_HookState.Spell = nil;
		TTST_HookState.Rank = nil;
		TTST_HookState.Target = nil;
		TTST_HookState.UnitId = nil;

	end

end

-- ============================================================================
-- EventHandler_Generic
-- ============================================================================
function TTST_EventHandler_Generic()

	-- Spell cast start is a special event that we handle here to set the spell
	-- name to make sure it is valid next time around.
	if (event == "SPELLCAST_START" and arg1 ~= nil) then

		TTST_HookState.Spell = arg1;

		if (TTST_HookState.Target == nil) then

			TTST_HookState.Target = UnitName("target");
			TTST_HookState.UnitId = "target";

		end

	end

	-- What are the current spell, rank, and target, if any?
	local spellName = TTST_HookState.Spell;
	local spellRank = TTST_HookState.Rank;
	local spellTarget = TTST_HookState.Target;
	local spellUnitId = TTST_HookState.UnitId;

	-- If our spell information is nil and there are no items in the queue then
	-- there is nothing for us to do.
	if (spellName == nil and getn(TTST_EventQueue) == 0) then
		return;
	end

	-- We have a valid spell, now figure out what we should do with it.

	-- The spell name is valid, so process this event.
	if (spellName ~= nil) then

		local fHandled = false;
		local spellData = TTST_GetSpellData(spellName);

		-- Bail if the spell is not a spell we handle or the timer is not enabled.
		if (spellData ~= nil) then

			local fEnabledTimer = TTST_GetSpellUserProperties(spellName).Enabled;

			-- If the spell has a custom event handler, then pass the event off to it instead.
			if (fEnabledTimer and spellData.EventHandler ~= nil and not fHandled) then
				fHandled = spellData.EventHandler(event, arg1, arg2, arg3, arg4, arg5);
			end

			if (event == "SPELLCAST_START" and not fHandled) then

				-- Broadcast a precast message if there is one.
				local userProperties = TTST_GetSpellUserProperties(spellName);

				if ((userProperties.EnabledAutoMessage) and (userProperties.AutoChat.MessagePreCast ~= nil)) then
					if (spellTarget == nil) then
						spellTarget = "";
					end
					TTST_BroadcastMessage(spellName, string.gsub(userProperties.AutoChat.MessagePreCast, "%%target%%", spellTarget));
				end

			elseif (event == "SPELLCAST_STOP" and not fHandled) then

				-- If the spell data says we should look for a debuff, then queue up
				-- a debuff check for next time.
				if (spellData.Properties.DebuffName ~= nil) then

					-- If our unit id isn't valid, make a best guess.
					if (spellUnitId == nil) then
						spellUnitId = "target";
					end

					-- We need a special case for polymorph because when npcs are polymorphed
					-- before the first polymorph has worn off, there is no event that we can
					-- monitor.  The best bet is to just check for the debuff here and create
					-- the time immediately.
					if (string.find(spellName, TTST_SPELL_POLYMORPH) or spellName == TTST_SPELL_SHACKLE_UNDEAD) then

						local spellProperties = TTST_GetSpellProperties(spellName);

						if (TTST_FindDebuffByName("target", spellProperties.DebuffName)) then

							TTST_CreateTimer(spellName, spellRank, spellTarget);

						end

					end

					-- Even though we queued up a debuff check for next time, we may not
					-- actually do it if the "UNIT_AURA" never changes.  For example:
					-- recasting a spell on a target before that spell finishes wearing off.
					-- The unit's debuff list doesn't change, so no UNIT_AURA event is
					-- generated.  So instead, we're going to rely on another event, UNIT_COMBAT.
					-- But using this event is only safe if the unit is in combat.
					if (UnitAffectingCombat(spellUnitId) or playerInCombat) then
						TTST_CreateEventQueue(spellName, "UNIT_COMBAT", spellRank, spellTarget);
					else
						TTST_CreateEventQueue(spellName, "UNIT_AURA", spellRank, spellTarget);
					end

				elseif (spellData.Properties.TargetRequired and spellTarget ~= nil) then

					-- Create a timer and broadcast a message, if any.
					TTST_CreateTimer(spellName, spellRank, spellTarget);

				elseif (not spellData.Properties.TargetRequired) then

					-- Create a timer and broadcast a message, if any.
					TTST_CreateTimer(spellName, spellRank, spellTarget);

				end

			end

		end

	end

	-- If we have any events in our queue and the queued spell has a custom event
	-- handler, then pass the event off to it instead.
	for index, value in TTST_EventQueue do

		-- Pass the event to the queue handler if it matches the event we are
		-- processing.
		if (event == value.Event) then
		
			local spellData = TTST_GetSpellData(value.Spell);

			if (spellData.EventHandler ~= nil) then

				-- Call the custom event handler.
				if (spellData.EventHandler(event, arg1, arg2, arg3, arg4, arg5, value)) then

					-- Remove the item from the queue.
					TTST_RemoveEventQueue(index);

				end

			end

		end

	end

	-- Now handle any default or expected queued events.
	if ((event == "UNIT_AURA" or event == "UNIT_COMBAT") and arg1 == "target") then

		-- Do we have any debuff checks in our queue?
		for index, value in TTST_EventQueue do
			
			-- Found a debuff check, so process it.
			if (value.Event == "UNIT_AURA" or value.Event == "UNIT_COMBAT") then

				local spellProperties = TTST_GetSpellProperties(value.Spell);

				if (TTST_FindDebuffByName("target", spellProperties.DebuffName)) then

					-- We successfully processed the item in the queue, so remove it.
					TTST_RemoveEventQueue(index);

					TTST_CreateTimer(value.Spell, value.Rank, value.Target);

				end

			end

		end

	end

	-- Purge any expired events.
	TTST_PurgeExpiredEvents();

end

-- ============================================================================
-- CreateEventQueue
-- ============================================================================
function TTST_CreateEventQueue(spellName, event, spellRank, spellTarget, eventExpires)

	-- Not a supported spell, so don't do anything.
	if (TTST_GetSpellProperties(spellName) == nil) then
		return;
	end

	-- Only queue up spells that haven't already been queued.
	if (TTST_GetSpellProperties(spellName).State == TTST_SpellState.None) then

		if (eventExpires == nil) then
			eventExpires = GetTime() + TTST_EVENT_EXPIRES;
		end

		tinsert(TTST_EventQueue, { Spell = spellName, Event = event, Rank = spellRank, Target = spellTarget, Expires = eventExpires });

		-- Any time we queue an event, mark that spell as queued so we don't requeue
		-- it later.
		TTST_GetSpellProperties(spellName).State = TTST_SpellState.Queued;

	end

end

-- ============================================================================
-- RemoveEventQueue
-- ============================================================================
function TTST_RemoveEventQueue(index)

	local spellName = TTST_EventQueue[index].Spell;

	if (spellName ~= nil) then
		TTST_GetSpellProperties(spellName).State = TTST_SpellState.None;
	end

	-- Remove the item from the queue.
	tremove(TTST_EventQueue, index)
	
end

-- ============================================================================
-- PurgeExpiredEvents
--
-- Removes any expired events from the event queue.  This is necessary because
-- sometimes events can get trapped in the queue.
-- ============================================================================
function TTST_PurgeExpiredEvents()

	for index, value in TTST_EventQueue do

		-- Has the event expired?
		if (GetTime() > value.Expires) then

			-- Remove the item from the queue.
			TTST_RemoveEventQueue(index);

		end

	end

end
