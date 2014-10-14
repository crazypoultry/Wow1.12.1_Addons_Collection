--[[
	ArcanePartyBars
	 	Tracks Party Casting via Telepathy and displays it on their party frame.
	
	By: AnduinLothar
	
	Special Thanks:
	Lelik (Healix): Initial Target Guessing code,
	Zlixar (ArcaneBar): Event and Casting Tecqunique,
	Mudgendai (CastOptions): Troubleshooting, Self/Friendly Targeting Spell Textures, container gathering code
	Legorol (EquipCompare): Troubleshooting, Timing and Theoretical Support
	
	
	$Id: ArcanePartyBars.lua 3955 2006-08-22 12:14:37Z zespri $
	$Rev: 3955 $
	$LastChangedBy: zespri $
	$Date: 2006-08-22 07:14:37 -0500 (Tue, 22 Aug 2006) $
	
	
	Spell Targeting wont be correct if you Queue a spell and then use any of the following Target functions:
	
    TargetNearestFriend(), TargetNearestPartyMember(), TargetNearestRaidMember() 
]]--

--------------------------------------------------
-- Globals
--------------------------------------------------
ArcanePartyBars = {};
ArcanePartyBars.DefaultColors = {
	["MAIN"] = {	--Yellow
		r=1.0;
		g=0.7;
		b=0.0;		
	};
	["CHANNEL"] = {	--Green
		r=0.0;
		g=1.0;
		b=0.0;
	};
	["SUCCESS"] = {	--Green
		r=0.0;
		g=1.0;
		b=0.0;
	};
	["FAILURE"] = {	--Red
		r=1.0;
		g=0.0;
		b=0.0;
	};	
};
ArcanePartyBars.FriendlyColors = {
	["MAIN"] = {	--Yellow
		r=1.0;
		g=0.7;
		b=0.0;		
	};
	["CHANNEL"] = {	--Green
		r=0.0;
		g=1.0;
		b=0.0;
	};
	["SUCCESS"] = {	--Green
		r=0.0;
		g=1.0;
		b=0.0;
	};
	["FAILURE"] = {	--Red
		r=1.0;
		g=0.0;
		b=0.0;
	};	
};
ArcanePartyBars.HostileColors = {
	["MAIN"] = {	--Orange
		r=1.0;
		g=0.5;
		b=0.1;
	};
	["CHANNEL"] = {	--Orange
		r=1.0;
		g=0.6;
		b=0.2;
	};
	["SUCCESS"] = {
		r=0.0;
		g=1.0;
		b=0.0;
	};
	["FAILURE"] = {
		r=1.0;
		g=0.0;
		b=0.0;
	};	
};
ArcanePartyBars.RaidBarUsers = {};

ArcanePartyBars.TIME_LEFT = "%.1fs";

ArcanePartyBars.TELEPATHY_ID = "APB";

--------------------------------------------------
-- Configuration Functions
--------------------------------------------------

ArcanePartyBars_Config = {

	OnUpdateSimulationPeriod = .07;
	Enabled = true;
	Mobile = false;
	UIParent = false;
	SpellTextures = true;
	OnlyOnTarget = true;
	SendCastingEvents = true;
	ShowGroupCasting = true;
	
	SimulateOnUpdate = false;
	OnUpdateSimulationPeriod = .07;

	DebugParty1 = false;
	
};

--ArcanePartyBars[ArcanePartyBars.ConfigTable[var][ArcanePartyBars_Config[var] and 1 or 0]]()
ArcanePartyBars.ConfigTable = {
	Enabled = {[1]="Enable", [0]="Disable", text="MASTER_ENABLE", id="ArcanePartyBars", default=true, disabled=false, difficulty=1, com="/apb"};
	Mobile = {[1]="Show", [0]="Hide", text="MAKE_DRAGGABLE", id="MakeMobile", default=false, disabled=false, difficulty=2, subcom="mobile"};
	UIParent = {[1]="SetUIParent", [0]="SetPartyFrameParent", text="UIPARENT", id="UIParent", default=false, disabled=false, difficulty=2, subcom="uiparent"};
	SpellTextures = {[1]="ShowSpellTextures", [0]="HideSpellTextures", text="SPELL_TEXTURES", id="SpellTextures", default=true, disabled=true, difficulty=2, subcom="texture"};
	OnlyOnTarget = {[1]="emptyfunc", [0]="emptyfunc", text="ONLY_ON_TARGET", id="OnlyOnTarget", default=false, disabled=false, difficulty=2, subcom="target"};
	SimulateOnUpdate = {[1]="SimulateOnUpdate", [0]="EnableOnUpdate", text="SIMULATE_ONUPDATE", id="SimulateOnUpdate", default=false, disabled=false, difficulty=4, subcom="sim"};
	TopText = {[1]="TopText", [0]="RightText", text="TOP_TEXT", id="TopText", default=false, disabled=false, difficulty=2, subcom="toptext"};
	SendCastingEvents = {[1]="emptyfunc", [0]="emptyfunc", text="SEND_CASTS", id="SendCasts", default=true, disabled=false, difficulty=3, subcom="sendcasts"};
	ShowGroupCasting = {[1]="emptyfunc", [0]="emptyfunc", text="SHOW_CASTS", id="ShowCasts", default=true, disabled=false, difficulty=3, subcom="showcasts"};
};

ArcanePartyBars.Enable = function()
	ArcanePartyBars.Register(ArcanePlayerBarsFrame);
	ArcanePartyBars.RegisterForTelepathyMessages();
	ArcanePartyBars.Hide();
	ArcanePartyBars_Config.Enabled = true;
end

ArcanePartyBars.Disable = function()
	ArcanePartyBars.Unregister(ArcanePlayerBarsFrame);
	ArcanePartyBars.UnregisterForTelepathyMessages();
	ArcanePartyBars.Hide();
	ArcanePartyBars_Config.Enabled = false;
end

ArcanePartyBars.ToggleMobility = function()
	if (ArcanePartyBars_Config.Mobile) then
		ArcanePartyBars.Hide();
	else
		ArcanePartyBars.Show();
	end
end

ArcanePartyBars.Register = function(frame)
	if (not frame) then
		frame = this;
	end
	frame:RegisterEvent("SPELLCAST_START");
	--frame:RegisterEvent("SPELLCAST_STOP");
	--frame:RegisterEvent("SPELLCAST_FAILED");
	frame:RegisterEvent("SPELLCAST_INTERRUPTED");
	frame:RegisterEvent("SPELLCAST_DELAYED");
	frame:RegisterEvent("SPELLCAST_CHANNEL_START");
	frame:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	frame:RegisterEvent("SPELLCAST_CHANNEL_STOP");
end

ArcanePartyBars.Unregister = function(frame)
	if (not frame) then
		frame = this;
	end
	frame:UnregisterEvent("SPELLCAST_START");
	--frame:UnregisterEvent("SPELLCAST_STOP");
	--frame:UnregisterEvent("SPELLCAST_FAILED");
	frame:UnregisterEvent("SPELLCAST_INTERRUPTED");
	frame:UnregisterEvent("SPELLCAST_DELAYED");
	frame:UnregisterEvent("SPELLCAST_CHANNEL_START");
	frame:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE");
	frame:UnregisterEvent("SPELLCAST_CHANNEL_STOP");
end

ArcanePartyBars.Reset = function(bar)
	bar:ClearAllPoints();
	bar:SetPoint("BOTTOMLEFT", bar:GetParent(), "BOTTOMRIGHT", 7, 43);
	bar:SetUserPlaced(0);
end

ArcanePartyBars.ResetAll = function()
	for i=1, MAX_PARTY_MEMBERS do
		ArcanePartyBars.Reset(getglobal("ArcanePartyBar"..i));
	end
end

ArcanePartyBars.Show = function()
	local bar;
	local targetText = "["..UnitName("player").."] >>"..UnitName("player").."<<";
	for i=1, MAX_PARTY_MEMBERS do
		bar = getglobal("ArcanePartyBar"..i);
		bar:Show();
		bar:SetAlpha(1);
		bar:EnableMouse(1);
		bar.Name:SetText(format(ArcanePartyBars.localization.PARTY_BAR_TITLE, i));
		bar.Time:SetText("(10.0)");
		bar.Target:SetText(targetText);
	end
	for i=1, ArcanePartyBar_GUI.NUM_RAID_BARS do
		bar = getglobal("ArcaneRaidBar"..i);
		bar:Show();
		bar:SetAlpha(1);
		--bar:EnableMouse(1);
		bar.Name:SetText(format(ArcanePartyBars.localization.RAID_BAR_TITLE, i));
		bar.Time:SetText("(10.0)");
		bar.Target:SetText(targetText);
	end
	ArcaneRaidBarFrameBackdrop:Show()
	ArcaneRaidBarFrame:EnableMouse(1);
	ArcanePartyBars_Config.Mobile = true;
end

ArcanePartyBars.Hide = function()
	local bar;
	for i=1, MAX_PARTY_MEMBERS do
		bar = getglobal("ArcanePartyBar"..i);
		bar:Hide();
		bar:SetAlpha(0);
		bar:EnableMouse(0);
		bar.Name:SetText("");
		bar.Time:SetText("");
		bar.Target:SetText("");
	end
	for i=1, ArcanePartyBar_GUI.NUM_RAID_BARS do
		bar = getglobal("ArcaneRaidBar"..i);
		bar:Hide();
		bar:SetAlpha(0);
		--bar:EnableMouse(0);
		bar.Name:SetText("");
		bar.Time:SetText("");
		bar.Target:SetText("");
	end
	ArcaneRaidBarFrameBackdrop:Hide()
	ArcaneRaidBarFrame:EnableMouse(0);
	ArcanePartyBars_Config.Mobile = false;
end

ArcanePartyBars.TopText = function()
	local bar;
	for i=1, MAX_PARTY_MEMBERS do
		bar = getglobal("ArcanePartyBar"..i);
		bar.Target:ClearAllPoints();
		bar.Target:SetPoint("BOTTOM", bar, "TOP", -10, 5);
		bar.Time:ClearAllPoints();
		bar.Time:SetPoint("LEFT", bar.Target, "RIGHT", 3, 0);
	end
	ArcanePartyBars_Config.TopText = true;
end

ArcanePartyBars.RightText = function()
	local bar;
	for i=1, MAX_PARTY_MEMBERS do
		bar = getglobal("ArcanePartyBar"..i);
		bar.Time:ClearAllPoints();
		bar.Time:SetPoint("LEFT", bar, "RIGHT", 7, 0);
		bar.Target:ClearAllPoints();
		bar.Target:SetPoint("LEFT", bar.Time, "RIGHT", 3, 0);
	end
	ArcanePartyBars_Config.TopText = false;
end

ArcanePartyBars.ToggleTextLocation = function()
	if (ArcanePartyBars_Config.TopText) then
		ArcanePartyBars.RightText();
	else
		ArcanePartyBars.TopText();
	end
end

ArcanePartyBars.SetUIParent = function()
	local bar;
	for i=1, MAX_PARTY_MEMBERS do
		bar = getglobal("ArcanePartyBar"..i);
		bar:SetParent( UIParent );
	end
	ArcanePartyBars_Config.UIParent = true;
end

ArcanePartyBars.SetPartyFrameParent = function()
	local bar;
	for i=1, MAX_PARTY_MEMBERS do
		bar = getglobal("ArcanePartyBar"..i);
		bar:SetParent( getglobal("PartyMemberFrame"..i) );
	end
	ArcanePartyBars_Config.UIParent = false;
end

ArcanePartyBars.TogglePartyFrameParent = function()
	if (ArcanePartyBars_Config.UIParent) then
		ArcanePartyBars.SetUIParent();
	else
		ArcanePartyBars.SetPartyFrameParent();
	end
end

ArcanePartyBars.SimulateOnUpdate = function()
	if (not Chronos or not Chronos.scheduleRepeating) then
		Sea.io.print(ArcanePartyBars.localization.SIMULATION_FAILURE);
		return;
	end
	for i=1, MAX_PARTY_MEMBERS do
		local  bar = getglobal("ArcanePartyBar"..i);
		if (bar:IsVisible()) then
			Chronos.scheduleRepeating(bar:GetName().."_OnUpdateSimulator", ArcanePartyBars_Config.OnUpdateSimulationPeriod, function() ArcanePartyBars.OnUpdateEvaluation(bar) end);
		end
	end
	ArcanePartyBars_Config.SimulateOnUpdate = true;
end

ArcanePartyBars.EnableOnUpdate = function()
	local bar;
	for i=1, MAX_PARTY_MEMBERS do
		local bar = getglobal("ArcanePartyBar"..i);
		Chronos.unscheduleRepeating(bar:GetName().."_OnUpdateSimulator");
	end
	ArcanePartyBars_Config.SimulateOnUpdate = false;
end

ArcanePartyBars.ToggleOnUpdateSimulation = function()
	if (ArcanePartyBars_Config.SimulateOnUpdate) then
		ArcanePartyBars.EnableOnUpdate();
	else
		ArcanePartyBars.SimulateOnUpdate();
	end
end

ArcanePartyBars.ShowGroupCasting = function()
	ArcanePartyBars.RegisterForTelepathyMessages()
	ArcanePartyBars_Config.ShowGroupCasting = true;
end

ArcanePartyBars.HideGroupCasting = function()
	ArcanePartyBars.UnregisterForTelepathyMessages()
	ArcanePartyBars_Config.ShowGroupCasting = false;
end

ArcanePartyBars.TogglePartyCasting = function()
	if (ArcanePartyBars_Config.ShowGroupCasting) then
		ArcanePartyBars.ShowGroupCasting();
	else
		ArcanePartyBars.ShowGroupCasting();
	end
end

ArcanePartyBars.MoveTextToTop = function()
	local frame;
	for i=1, MAX_PARTY_MEMBERS do
		local frame = getglobal("ArcanePartyBar"..i);
		frame.Target:ClearAllPoints();
		frame.Target:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0);
		frame.Time:ClearAllPoints();
		frame.Time:SetPoint("LEFT", frame.Target, "RIGHT", 3, 0);
	end
	ArcanePartyBars_TextOnTop_Enabled = true;
end

ArcanePartyBars.MoveTextToSide = function()
	local frame;
	for i=1, MAX_PARTY_MEMBERS do
		local frame = getglobal("ArcanePartyBar"..i);
		frame.Time:ClearAllPoints();
		frame.Time:SetPoint("LEFT", frame, "RIGHT", 7, 0);
		frame.Target:ClearAllPoints();
		frame.Target:SetPoint("LEFT", frame.Time, "RIGHT", 3, 0);
	end
	ArcanePartyBars_TextOnTop_Enabled = false;
end

ArcanePartyBars.ToggleMoveText = function()
	if (ArcanePartyBars_TextOnTop_Enabled) then
		ArcanePartyBars.MoveTextToSide();
	else
		ArcanePartyBars.MoveTextToTop();
	end
end

ArcanePartyBars.ShowSpellTextures = function()
	local frame;
	for i=1, MAX_PARTY_MEMBERS do
		local frame = getglobal("ArcanePartyBar"..i);
		frame.SpellTexture:Show();
	end
	for i=1, ArcanePartyBar_GUI.NUM_RAID_BARS do
		local frame = getglobal("ArcaneRaidBar"..i);
		frame.SpellTexture:Show();
	end
end

ArcanePartyBars.HideSpellTextures = function()
	local frame;
	for i=1, MAX_PARTY_MEMBERS do
		local frame = getglobal("ArcanePartyBar"..i);
		frame.SpellTexture:Hide();
	end
	for i=1, ArcanePartyBar_GUI.NUM_RAID_BARS do
		local frame = getglobal("ArcaneRaidBar"..i);
		frame.SpellTexture:Hide();
	end
end

--------------------------------------------------
-- Bar Scripts
--------------------------------------------------

ArcanePartyBars.OnLoad = function(frame)
	if (not frame) then
		frame = this;
	end
	frame.casting = nil;
	frame.holdTime = 0;
	frame.Enabled = 0;
	frame.Overrided = 0;
end

ArcanePartyBars.OnUpdate = function(frame)
	if (not ArcanePartyBars_Config.SimulateOnUpdate) then
		ArcanePartyBars.OnUpdateEvaluation(frame);
	end
end

ArcanePartyBars.OnUpdateEvaluation = function(frame)
	if (not frame) then
		frame = this;
	end
	if ( ArcanePartyBars_Config.ShowGroupCasting ) then
		if ( frame.channeling ) then
			local time = GetTime();
			if ( time > frame.endTime ) then
				time = frame.endTime
			end
			if ( time == frame.endTime ) then
				frame.channeling = nil;
				frame.fadeOut = 1;
				return;
			end
			local barValue = frame.startTime + (frame.endTime - time);
			frame.StatusBar:SetValue( barValue );
			frame.Flash:Hide();
			local sparkPosition = ((barValue - frame.startTime) / (frame.endTime - frame.startTime)) * frame:GetWidth();
			frame.Spark:SetPoint("CENTER", frame.StatusBar, "LEFT", sparkPosition, 0);
			frame.Time:SetText("("..ArcanePartyBars.GetTimeLeft(frame.StatusBar)..")");
		elseif ( frame.casting ) then
			local status = GetTime();
			if ( status > frame.maxValue ) then
				status = frame.maxValue
			end
			frame.StatusBar:SetValue(status);
			frame.Flash:Hide();
			local sparkPosition = ((status - frame.startTime) / (frame.maxValue - frame.startTime)) * frame:GetWidth();
			if ( sparkPosition < 0 ) then
				sparkPosition = 0;
			end
			frame.Spark:SetPoint("CENTER", frame.StatusBar, "LEFT", sparkPosition, 0);
			frame.Time:SetText("("..ArcanePartyBars.GetTimeLeft(frame.StatusBar)..")");
			if ( status == frame.maxValue ) then
				ArcanePartyBars.SpellcastStop(frame);
			end
		elseif ( GetTime() < frame.holdTime ) then
			return;
		elseif ( frame.flash ) then
			local alpha = frame.Flash:GetAlpha() + CASTING_BAR_FLASH_STEP;
			if ( alpha < 1 ) then
				frame.Flash:SetAlpha(alpha);
			else
				frame.flash = nil;
			end
		elseif ( frame.fadeOut ) then
			local alpha = frame:GetAlpha() - CASTING_BAR_ALPHA_STEP;
			if ( alpha > 0 ) then
				frame:SetAlpha(alpha);
			else
				frame.fadeOut = nil;
				frame:Hide();
				ArcanePartyBars.ClearRaidMembersArcaneBar(frame.caster, frame:GetID());
			end
		end
	end
end

ArcanePartyBars.OnEnter = function(frame)
	if (not frame) then
		frame = this;
	end
	if (ArcanePartyBars_Config.Mobile) and (frame.isRaidFrame) then
		APB_Tooltip:SetOwner(frame, "ANCHOR_CURSOR");
		APB_Tooltip:SetText(format(ArcanePartyBars.localization.TOOLTIP_TEXT, format(ArcanePartyBars.localization.PARTY_BAR_TITLE, frame:GetID())));
	end
end

ArcanePartyBars.OnLeave = function(frame)
	if (not frame) then
		frame = this;
	end
	APB_Tooltip:Hide();
end

ArcanePartyBars.OnMouseUp = function(frame)
	if (not frame) then
		frame = this;
	end
	if ( frame.isMoving ) then
		frame:StopMovingOrSizing();
		frame.isMoving = false;
	end
end

ArcanePartyBars.OnMouseDown = function(frame)
	if (not frame) then
		frame = this;
	end
	if (arg1 == "RightButton") and (IsShiftKeyDown()) and (not frame.isRaidFrame) then
		APB_DropDown.displayMode = "MENU";
		ToggleDropDownMenu(1, frame:GetID(), APB_DropDown, frame:GetName());
	elseif (arg1 == "LeftButton") then
		if (not frame.isLocked) or (frame.isLocked == 0) then
			frame:StartMoving();
			frame.isMoving = true;
			APB_Tooltip:Hide();
		end
	end
end

ArcanePartyBars.OnShow = function(frame)
	if (not frame) then
		frame = this;
	end
	if (ArcanePartyBars_Config.SimulateOnUpdate) then
		--Simulate OnUpdate
		Chronos.scheduleRepeating("ArcanePartyBar1_OnUpdateSimulator", ArcanePartyBars_Config.OnUpdateSimulationPeriod, function() ArcanePartyBars.OnUpdateEvaluation(ArcanePartyBar1) end);
	end
end

ArcanePartyBars.OnHide = function(frame)
	if (not frame) then
		frame = this;
	end
	if (Chronos and Chronos.unscheduleRepeating) then
		Chronos.unscheduleRepeating(frame:GetName().."_OnUpdateSimulator");
	end
	if ( frame.isMoving ) then
		frame:StopMovingOrSizing();
		frame.isMoving = false;
	end
end


--------------------------------------------------
-- Bar Functions
--------------------------------------------------

ArcanePartyBars.GetTimeLeft = function(statusBar)
	local min, max = statusBar:GetMinMaxValues();
	local current_time;
	if ( this.channeling ) then
		current_time = statusBar:GetValue() - min;
	else
		current_time = max - statusBar:GetValue();
	end
	return format(ArcanePartyBars.TIME_LEFT, math.max(current_time,0)+0.001);
end

ArcanePartyBars.SpellcastStart = function(frame, durration, name, target, caster, texture)
	if (not frame) then
		frame = this;
	end
	ArcanePartyBars.RaidBarUsers[caster] = frame:GetID();
	frame.caster = caster;
	if (ArcanePartyBars.CheckIfNameIsInGroup(target)) then
		--Friendly
		frame.StatusBar:SetStatusBarColor(ArcanePartyBars.FriendlyColors["MAIN"].r,ArcanePartyBars.FriendlyColors["MAIN"].g, ArcanePartyBars.FriendlyColors["MAIN"].b);
		frame.targetIsFriendly = 1;
	else
		--Hostile
		frame.StatusBar:SetStatusBarColor(ArcanePartyBars.HostileColors["MAIN"].r, ArcanePartyBars.HostileColors["MAIN"].g, ArcanePartyBars.HostileColors["MAIN"].b);
		frame.targetIsFriendly = nil;
	end
	if (texture) then
		frame.SpellTexture:SetTexture(texture);
		if (ArcanePartyBars_Config.SpellTextures == 1) then
			frame.SpellTexture:Show();
		end
	else
		frame.SpellTexture:Hide();
	end
	frame.Spark:Show();
	frame.startTime = GetTime();
	frame.maxValue = frame.startTime + (durration / 1000);
	frame.StatusBar:SetMinMaxValues(frame.startTime, frame.maxValue);
	frame.StatusBar:SetValue(frame.startTime);
	frame:SetAlpha(1.0);
	frame.holdTime = 0;
	frame.casting = 1;
	frame.fadeOut = nil;
	frame:Show();
	
	local timeReadable = ArcanePartyBars.GetTimeLeft(frame.StatusBar)
	if (name) then
		frame.Name:SetText(name);
	end
	frame.Time:SetText("("..timeReadable..")");
	
	local targetText = "";
	if (frame.isRaidFrame) then
		targetText = "["..caster.."] ";
	end
	if (target) and (target ~= "") then
		frame.targetName = target;
		if (ArcanePartyBars_Config.OnlyOnTarget ~= 1) then
			targetText = targetText..">>"..target.."<<";
		end
	else
		frame.targetName = nil;
	end
	frame.Target:SetText(targetText);

	frame.mode = "casting";
end

ArcanePartyBars.SpellcastStop = function(frame)
	if (not frame) then
		frame = this;
	end
	if ( not frame:IsVisible() ) then
		frame:Hide();
	end
	if ( frame:IsShown() ) then
		if (frame.channeling) then
			frame.StatusBar:SetValue(frame.endTime);
		else
			frame.StatusBar:SetValue(frame.maxValue);
		end
		if (frame.targetIsFriendly) then
			--Friendly
			frame.StatusBar:SetStatusBarColor(ArcanePartyBars.FriendlyColors["SUCCESS"].r,ArcanePartyBars.FriendlyColors["SUCCESS"].g, ArcanePartyBars.FriendlyColors["SUCCESS"].b);
		else
			--Hostile
			frame.StatusBar:SetStatusBarColor(ArcanePartyBars.HostileColors["SUCCESS"].r, ArcanePartyBars.HostileColors["SUCCESS"].g, ArcanePartyBars.HostileColors["SUCCESS"].b);
		end
		frame.Spark:Hide();
		frame.Flash:SetAlpha(0.0);
		frame.Flash:Show();
		frame.casting = nil;
		frame.channeling = nil;
		frame.flash = 1;
		frame.fadeOut = 1;
		
		frame.mode = "flash";
	end
end

ArcanePartyBars.SpellcastFailed = function(frame)
	if (not frame) then
		frame = this;
	end
	if ( frame:IsShown() ) then
		frame.StatusBar:SetValue(frame.maxValue);
		if (frame.targetIsFriendly) then
			--Friendly
			frame.StatusBar:SetStatusBarColor(ArcanePartyBars.FriendlyColors["FAILURE"].r,ArcanePartyBars.FriendlyColors["FAILURE"].g, ArcanePartyBars.FriendlyColors["FAILURE"].b);
		else
			--Hostile
			frame.StatusBar:SetStatusBarColor(ArcanePartyBars.HostileColors["FAILURE"].r, ArcanePartyBars.HostileColors["FAILURE"].g, ArcanePartyBars.HostileColors["FAILURE"].b);
		end
		frame.Spark:Hide();
		frame.casting = nil;
		frame.fadeOut = 1;
		frame.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
	end
end

ArcanePartyBars.SpellcastDelayed = function(frame, durration)
	if (not frame) then
		frame = this;
	end
	if( frame:IsShown() ) then
		frame.startTime = frame.startTime + (durration / 1000);
		frame.maxValue = frame.maxValue + (durration / 1000);
		frame.StatusBar:SetMinMaxValues(frame.startTime, frame.maxValue);
	end
end

ArcanePartyBars.SpellcastChannelStart = function(frame, durration, name, target, caster, texture)
	if (not frame) then
		frame = this;
	end
	ArcanePartyBars.RaidBarUsers[caster] = frame:GetID();
	frame.caster = caster;
	if (ArcanePartyBars.CheckIfNameIsInGroup(target)) then
		--Friendly
		frame.StatusBar:SetStatusBarColor(ArcanePartyBars.FriendlyColors["CHANNEL"].r,ArcanePartyBars.FriendlyColors["CHANNEL"].g, ArcanePartyBars.FriendlyColors["CHANNEL"].b);
		frame.targetIsFriendly = 1;
	else
		--Hostile
		frame.StatusBar:SetStatusBarColor(ArcanePartyBars.HostileColors["CHANNEL"].r, ArcanePartyBars.HostileColors["CHANNEL"].g, ArcanePartyBars.HostileColors["CHANNEL"].b);
		frame.targetIsFriendly = nil;
	end
	if (texture) then
		frame.SpellTexture:SetTexture(texture);
		if (ArcanePartyBars_Config.SpellTextures == 1) then
			frame.SpellTexture:Show();
		end
	else
		frame.SpellTexture:Hide();
	end
	frame.Spark:Hide();
	frame.maxValue = 1;
	frame.startTime = GetTime();
	frame.endTime = frame.startTime + (durration / 1000);
	frame.duration = durration / 1000;
	frame.StatusBar:SetMinMaxValues(frame.startTime, frame.endTime);
	frame.StatusBar:SetValue(frame.endTime);
	frame:SetAlpha(1.0);
	frame.holdTime = 0;
	frame.casting = nil;
	frame.channeling = 1;
	frame.fadeOut = nil;
	frame:Show();
	
	local timeReadable = ArcanePartyBars.GetTimeLeft(frame.StatusBar)
	if (name) then
		frame.Name:SetText(name);
	end
	frame.Time:SetText("("..timeReadable..")");
	
	local targetText = "";
	if (frame.isRaidFrame) then
		targetText = "["..caster.."] ";
	end
	if (target) and (target ~= "") then
		frame.targetName = target;
		if (ArcanePartyBars_Config.OnlyOnTarget ~= 1) then
			targetText = targetText..">>"..target.."<<";
		end
	else
		frame.targetName = nil;
	end
	frame.Target:SetText(targetText);
end

ArcanePartyBars.SpellcastChannelUpdate = function(frame, durration)
	if (not frame) then
		frame = this;
	end
	
	if ( durration == 0 ) then
		frame.channeling = nil;
	elseif ( frame:IsShown() ) then
		local origDuration = frame.endTime - frame.startTime
		frame.endTime = GetTime() + (durration / 1000)
		frame.startTime = frame.endTime - origDuration
		--this.endTime = this.startTime + (arg1 / 1000);
		frame.StatusBar:SetMinMaxValues(frame.startTime, frame.endTime);
	end
	
	local timeReadable = ArcanePartyBars.GetTimeLeft(frame.StatusBar)
	if (name) then
		frame.Name:SetText(name);
	end
	frame.Time:SetText("("..timeReadable..")");
end


--------------------------------------------------
-- ArcanePartyBarFrame Functions
--------------------------------------------------

ArcanePartyBars.emptyfunc = function()
end

ArcanePartyBars.MasterOnLoad = function(frame)
	if (not frame) then
		frame = this;
	end
	ArcanePartyBars.Register(frame);
	ArcanePartyBars.RegisterForTelepathyMessages();
	if (Hx_OnSpellCast) then
		--Hijack Healix!
		Sea.util.hook("Hx_OnSpellCast", "ArcanePartyBars.emptyfunc", "hide");
		ArcanePartyBars.Hx_OnSpellCast = Sea.util.Hooks.Hx_OnSpellCast.orig;
	end
	if (MCom) then
		ArcanePartyBars.RegisterForMCom();
	end
	--if ( Meteorologist_RegisterAddon ) then
	--	Meteorologist_RegisterAddon( "ArcanePartyBars" );
	--end
end

ArcanePartyBars.MasterOnEvent = function(frame)
	if (not frame) then
		frame = this;
	end
	local method = "RAID";
	if ( event == "SPELLCAST_START" ) then
		--arg1: Name
		--arg2: cast time
		local target = IsCasting.GetSpellTargetName();
		Sea.io.dprint("ArcanePartyBarDebug", arg1, arg2, target);
		--[[
		if (type(tonumber(arg2)) == "number") then
			--Acount for Upload Time
			local down, up, lag = GetNetStats();
			arg2 = tonumber(arg2) - up*1000;
		end
		]]--
		local texture = IsCasting.GetSpellTexture();
		if (not texture) then
			texture = "";
		end
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"t,"..arg2..","..arg1..","..target..","..texture, 
				method, nil, "ALERT"
			);
		end
	elseif ( event == "SPELLCAST_STOP" ) then
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) and (IsCasting.GetSpellCastTime() > 0) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"s,,,,", 
				method, nil, "ALERT"
			);
		end
	elseif ( event == "SPELLCAST_FAILED" ) then
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) and (IsCasting.GetSpellCastTime() > 0) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"f,,,,", 
				method, nil, "ALERT"
			);
		end
	elseif ( event == "SPELLCAST_INTERRUPTED" ) then
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) and (IsCasting.GetSpellCastTime() > 0) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"f,,,,", 
				method, nil, "ALERT"
			);
		end
	elseif ( event == "SPELLCAST_DELAYED" ) then
		--arg1: delayed time
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"d,"..arg1..",,,", 
				method, nil, "ALERT"
			);
		end
	elseif ( event == "SPELLCAST_CHANNEL_START" ) then
		--arg1: cast time
		--arg2: "Channeling"
		local target = IsCasting.GetSpellTargetName();
		local spellName = IsCasting.GetSpellName()
		Sea.io.dprint("ArcanePartyBarDebug", arg1, arg2, spellName, target);
		--[[
		if (type(tonumber(arg1)) == "number") then
			--Acount for Upload Time
			local down, up, lag = GetNetStats();
			arg1 = tonumber(arg1) - up*1000;
		end
		]]--
		local texture = IsCasting.GetSpellTexture();
		if (not texture) then
			texture = "";
		end
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"c,"..arg1..","..spellName..","..target..","..texture, 
				method, nil, "ALERT"
			);
		end
	elseif ( event == "SPELLCAST_CHANNEL_UPDATE" ) then
		--arg1: delayed time
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"u,"..arg1..",,,", 
				method, nil, "ALERT"
			);
		end
	elseif ( event == "SPELLCAST_CHANNEL_STOP" ) then
		--arg1: delayed time
		if (UnitInParty("party1") or UnitInRaid("player")) and (ArcanePartyBars_Config.SendCastingEvents) then
			Telepathy.sendMessage(ArcanePartyBars.TELEPATHY_ID, 
				"s,,,,", 
				method, nil, "ALERT"
			);
		end
	end
end

--------------------------------------------------
-- Telepathy Addon Registration
--------------------------------------------------


ArcanePartyBars.RegisterForTelepathyMessages = function()
	Telepathy.registerListener("APB", {"RAID", "PARTY"}, ArcanePartyBars.TelepathyAlertProccessing);
end

ArcanePartyBars.UnregisterForTelepathyMessages = function()
	Telepathy.unregisterListener("APB");
end

ArcanePartyBars.TelepathyAlertProccessing = function(msg, sender, method)
	if ( type(msg) == "string" ) and (strlen(msg) > 0) then
		Sea.io.dprint("ArcanePartyBarDebug", msg);
		local key, count, name, target, texture = string.gfind(msg, "([tdfscu]),(.-),(.-),(.-),(.*)")();
		if (key) then
			--[[
			if (type(tonumber(count)) == "number") then
				--Acount for Downlaod Time
				local down, up, lag = GetNetStats();
				count = tonumber(count) - down*1000;
			end
			]]--
			local bar;
			if (target) and (target ~= "") and (ArcanePartyBars_Config.OnlyOnTarget == 1) and (target ~= UnitName("target")) then
				return;
			elseif (method == "RAID") then
				bar = ArcanePartyBars.GetRaidMembersArcaneBar(sender);
			elseif (method == "PARTY") then
				bar = ArcanePartyBars.GetPartyMembersArcaneBar(sender);
			end
			if (bar) then
				if (key == "t") then
					ArcanePartyBars.SpellcastStart(bar, tonumber(count), name, target, sender, texture);
					Sea.io.dprint("ArcanePartyBarDebug", sender.." Casting: ".. name..".");
				elseif (key == "d") then
					ArcanePartyBars.SpellcastDelayed(bar, tonumber(count));
					Sea.io.dprint("ArcanePartyBarDebug", sender.."'s cast is being delayed.");
				elseif (key == "f") then
					ArcanePartyBars.SpellcastFailed(bar);
					Sea.io.dprint("ArcanePartyBarDebug", sender.."'s cast has failed.");
				elseif (key == "s") then
					ArcanePartyBars.SpellcastStop(bar);
					Sea.io.dprint("ArcanePartyBarDebug", sender.."'s cast has ended.");
				elseif (key == "c") then
					ArcanePartyBars.SpellcastChannelStart(bar, tonumber(count), name, target, sender, texture);
					Sea.io.dprint("ArcanePartyBarDebug", sender.." Channeling: ".. name..".");
				elseif (key == "u") then
					ArcanePartyBars.SpellcastChannelUpdate(bar, tonumber(count));
					Sea.io.dprint("ArcanePartyBarDebug", sender.." Channeling '".. name.."' Updated To: ".. count..".");
				end
			end
		end
	end
end

ArcanePartyBars.GetPartyMembersArcaneBar = function(name)
	if (ArcanePartyBars_Config.DebugParty1) then
		--Show your casts on party1.
		return ArcanePartyBar1;
	else
		for i=1, MAX_PARTY_MEMBERS do
			if (UnitName("party"..i) == name) then
				return getglobal("ArcanePartyBar"..i);
			end
		end
	end
end

ArcanePartyBars.GetRaidMembersArcaneBar = function(name)
	if (ArcanePartyBars_Config.DebugParty1) then
		--Show your casts on raid1.
		return ArcaneRaidBar1;
	elseif (name ~= UnitName("player")) then
	--else
		local id = ArcanePartyBars.RaidBarUsers[name]
		if (id) then
			return getglobal("ArcaneRaidBar"..id)
		else
			local indexableBarUsers = {}
			for name, id in ArcanePartyBars.RaidBarUsers do
				indexableBarUsers[id] = name
			end
			for id=1, ArcanePartyBar_GUI.NUM_RAID_BARS do
				if (not indexableBarUsers[id]) then
					return getglobal("ArcaneRaidBar"..id)
				end
			end
			-- All raid bars in use, make another
			return ArcanePartyBar_GUI.AddNewArcaneRaidBar()
		end
	end
end

ArcanePartyBars.ClearRaidMembersArcaneBar = function(name, id)
	if (name) and (ArcanePartyBars.RaidBarUsers[name] == id) then
		ArcanePartyBars.RaidBarUsers[name] = nil;
	end
end

ArcanePartyBars.CheckIfNameIsInGroup = function(name)
	if (name == UnitName("player")) then
		return true;
	end
	for i=0, GetNumRaidMembers() do
		if (name == UnitName("raid"..i)) then
			return true;
		end
	end
	for i=0, GetNumPartyMembers() do
		if (name == UnitName("party"..i)) then
			return true;
		end
	end
end

--------------------------------------------------
-- Menu (From MobileFrames)
--------------------------------------------------

ArcanePartyBars.LoadDropDownMenu = function()
	if (not UIDROPDOWNMENU_MENU_VALUE) then
		return;
	end
	--Title
	local info = {};
	info.text = format(ArcanePartyBars.localization.PARTY_BAR_TITLE, UIDROPDOWNMENU_MENU_VALUE)
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, 1);
	
	--Reset
	local info = {};
	info.text = RESET;
	info.value = "Reset";
	info.func = function() ArcanePartyBars.Reset(getglobal("ArcanePartyBar"..UIDROPDOWNMENU_MENU_VALUE)); end;
	if (getglobal("ArcanePartyBar"..UIDROPDOWNMENU_MENU_VALUE)) and (not getglobal("ArcanePartyBar"..UIDROPDOWNMENU_MENU_VALUE):IsUserPlaced()) then
		info.disabled = 1;
	end
	UIDropDownMenu_AddButton(info, 1);
	
	--Reset All
	local info = {};
	info.text = RESET_ALL;
	info.value = "ResetAll";
	info.func = ArcanePartyBars.ResetAll;
	UIDropDownMenu_AddButton(info, 1);
	
end

ArcanePartyBars.DropDownOnLoad = function()
	UIDropDownMenu_Initialize(this, ArcanePartyBars.LoadDropDownMenu, "MENU");
	DropDownList1:SetClampedToScreen(1);
end

--------------------------------------------------
-- Configuration Registeration
--------------------------------------------------

ArcanePartyBars.GetLocal = function(index)
	return ArcanePartyBars.localization[index];
end

ArcanePartyBars.GetInfoLocal = function(index)
	return ArcanePartyBars.localization[index].."\n"..ArcanePartyBars.localization.info[index];
end

ArcanePartyBars.RegisterForMCom = function()
	
	local optionSet = {};
	
	--------------------------------------------------
	-- Presets Registering
	--------------------------------------------------
	
	table.insert(optionSet, {
		id="OptionsHeader";
		text=ArcanePartyBars.GetLocal("OPTIONS_HEADER");
		helptext=ArcanePartyBars.GetInfoLocal("OPTIONS_HEADER");
		type=K_HEADER;
		difficulty=1;
	});
	
	table.insert(optionSet, {
		id="Reset";
		type=K_BUTTON;
		text=ArcanePartyBars.GetLocal("RESET_BARS");
		helptext=ArcanePartyBars.GetInfoLocal("RESET_BARS");
		callback=ArcanePartyBars.ResetAll;
		setup={buttonText=RESET_ALL};
		mcopts = {
			subcom = string.lower("reset");
		};
	});
	
	local vars = { "TopText", "Mobile", "UIParent", "SpellTextures", "OnlyOnTarget", "SendCastingEvents", "ShowGroupCasting", "SimulateOnUpdate" };
	
	for index, varString in vars do
		local varName = varString;
		table.insert(optionSet, {
			id = ArcanePartyBars.ConfigTable[varString].id;
			check = true;
			type = K_TEXT;
			difficulty = 1;
			text = ArcanePartyBars.GetLocal(ArcanePartyBars.ConfigTable[varString].text);
			helptext = ArcanePartyBars.GetInfoLocal(ArcanePartyBars.ConfigTable[varString].text);
			difficulty = ArcanePartyBars.ConfigTable[varString].difficulty;
			default = {checked = ArcanePartyBars.ConfigTable[varString].default;};
			disabled = {checked = ArcanePartyBars.ConfigTable[varString].disabled;};
			mcopts = {
				subcom = ArcanePartyBars.ConfigTable[varString].subcom;
				varbool = "ArcanePartyBars_Config."..varString;
				update = function() ArcanePartyBars[ArcanePartyBars.ConfigTable[varName][ArcanePartyBars_Config[varName]]](); end;
				--noupdate = function(varName) ArcanePartyBars[ArcanePartyBars.ConfigTable[varName][ArcanePartyBars_Config[varName]]](); end;
			};
		});
	end
	
	table.insert(optionSet,  {
		id = "SimulationPeriod";
		type = K_SLIDER;
		difficulty = 4;
		text = ArcanePartyBars.GetLocal("SIM_PERIOD");
		helptext = ArcanePartyBars.GetInfoLocal("SIM_PERIOD");
		dependencies = {["SimulateOnUpdate"]={checked=true}};
		default = {slider=.07};
		disabled = {slider=.07};
		setup = {
			sliderMin = .01;
			sliderMax = .25;
			sliderStep = .01;
			sliderText = ArcanePartyBars.GetLocal("SIM_PERIOD_TEXT");
		};
		mcopts = {
			subcom = "simperiod";
			varnum = "ArcanePartyBars_Config.OnUpdateSimulationPeriod";
		};
	});
	
	--------------------------------------------------
	-- Config Set Registering
	--------------------------------------------------
			
	MCom.registerSmart(
		{
			supercom = ArcanePartyBars.ConfigTable["Enabled"].com;
			uifolder = "combat",
			uiset = {
				id = ArcanePartyBars.ConfigTable["Enabled"].id;
				text = ArcanePartyBars.GetLocal(ArcanePartyBars.ConfigTable["Enabled"].text);
				helptext = ArcanePartyBars.GetInfoLocal(ArcanePartyBars.ConfigTable["Enabled"].text);
				difficulty = ArcanePartyBars.ConfigTable["Enabled"].difficulty;
				default = true;
				options = optionSet;
			}
		}
	);
	
end

--/z ArcanePartyBar1StatusBarName:SetWidth(94)
--/z ArcanePartyBars_Config.DebugParty1=true;
--/z ArcanePartyBars.ToggleOnUpdateSimulation();
--/z PartyMemberFrame1:Show();PartyMemberFrame1Name:SetText("Anduinlothar");ArcanePartyBars.SpellcastChannelStart(ArcanePartyBar1, 2000, "Corruption", "Bob")
--/z PartyMemberFrame1:Show();PartyMemberFrame1Name:SetText("Anduinlothar");ArcanePartyBars.Show()
--/z ArcanePartyBars.SpellcastStop(ArcanePartyBar1)
--/z ArcanePartyBars.SpellcastChannelStart(ArcanePartyBar1, 10000, "Corruption", "Bob")
--/z ArcanePartyBar1Flash:SetWidth(160);ArcanePartyBar1StatusBarBorder:SetHeight(18);ArcanePartyBars.SpellcastStart(ArcanePartyBar1, 2000, "Corruption", "Bob")
--/z ArcanePartyBar1:ClearAllPoints();ArcanePartyBar1:SetPoint("LEFT", "PartyMemberFrame1", "RIGHT", 7, 0);ArcanePartyBars.SpellcastStart(ArcanePartyBar1, 2000, "Corruption", "Bob")
--/z ArcanePartyBar1StatusBarName:ClearAllPoints();ArcanePartyBar1StatusBarName:SetPoint("LEFT", "ArcanePartyBar1StatusBar", "RIGHT", 7, 1);ArcanePartyBars.SpellcastStart(ArcanePartyBar1, 2000, "Corruption", "Bob")
--/z ArcanePartyBar1StatusBarTime:ClearAllPoints();ArcanePartyBar1StatusBarTime:SetPoint("LEFT", "ArcanePartyBar1StatusBarName", "RIGHT", 3, 0)
--/z ArcanePartyBars.SpellcastStart(ArcanePartyBar1, 2000)
--/z ArcanePartyBars.SpellcastStop(ArcanePlayerBar1)
--/z ArcanePartyBars.SpellcastDelayed(ArcanePlayerBar1, 1000)
--/z ArcanePlayerBar1

