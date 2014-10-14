-- Simple Tranq Shot
--
-- This mod watches for the player to cast Tranquilizing Shot on
-- an enemy and sends a message to the desired channel based on if
-- the shot hits or misses the target.  This will catch any casts
-- of tranqilizing shot, regardless of how it's cast, but is
-- designed to remove the need for a macro to do the cast for you
-- preventing multiple spams of the broadcasted message in
-- situations where the shot is not actually cast.
--
-- All messages can be changed to the ones desired via console
-- commands, and the error message displayed on the ui when the
-- cast misses can be changed to any color.
--
-- /simpletranqshot
--
--

STranqVersion = "2.0 beta29";
STranqTitle = STRANQ_TITLE .. STranqVersion;

STranq_Saved = {};

STranq_Hunters = {};
local STranq_Frenzy = {};

--== Local variables ==--
local loaded, seenUpdate;

local DragFrame;
local dragX, dragY, dragID = 0,0;

local STranq_ChanList = {};

local STranq_LastFrame = "Stranq_FrenzyTimer";
local STranq_LastVisible = "Stranq_FrenzyTimer";

local STranq_Default = {
	["PerGroup"] = 2;
	["NumGroups"] = 2;
	["MaxShown"] = 5;
	["BarAlpha"] = 1;
	["BarScale"] = 1;
	["CastMsg"] = STRANQ_STRINGS.CASTMSG;
	["MissMsg"] = STRANQ_STRINGS.MISSMSG;
	["MissErr"] = STRANQ_STRINGS.MISSERR;
	["RaidErr"] = STRANQ_STRINGS.RAIDERR;
	["FailMsg"] = STRANQ_STRINGS.FAILMSG;
	["FailErr"] = STRANQ_STRINGS.FAILERR;
	["RaidFailErr"] = STRANQ_STRINGS.RAIDFAILERR;
	["CastType"] = 1;
	["MissColor"] = { r = 1.0, g = 1.0, b = 0.0 };
	["RaidMissColor"] = { r = 1.0, g = 0.5, b = 0.0 };
};

local STranq_Types = { "Yell", "Channel", "Raid", "Party", "Emote", "Say", "Whisper", "/rs" };

local STranq_Mobs = {
	-- 15 Second frenzy
	[STRANQ_STRINGS.MAGMADAR] = {frenzy=15,range=5};
	[STRANQ_STRINGS.CHROMAGGUS] = {frenzy=15};
	[STRANQ_STRINGS.MAWS] = {frenzy=15};

	-- 10 second frenzy
	[STRANQ_STRINGS.PRINCESS_HUHURAN] = {frenzy=10,range=20};
	[STRANQ_STRINGS.FLAMEGOR] = {frenzy=10};
	[STRANQ_STRINGS.GLUTH] = {frenzy=10};

	-- trash mob random frenzy
	[STRANQ_STRINGS.QIRAJI_SLAYER] = {};
	[STRANQ_STRINGS.DEATH_TALON_SEETHER] = {};

	-- ignore
	[STRANQ_STRINGS.VEKNISS_DRONE] = {ignore=1};
	[STRANQ_STRINGS.VEKNISS_SOLDIER] = {ignore=1};
	[STRANQ_STRINGS.ROACH] = {ignore=1};
	[STRANQ_STRINGS.BEETLE] = {ignore=1};
	[STRANQ_STRINGS.SCORPION] = {ignore=1};
};

local STranq_DataHeader = "$Tranq "; -- §

local STranq_TranqCooldown = 20;
local STranq_TranqMana = 270;

--== local copies of strings that are used a lot ==--
local STranq_string_Tranq = STRANQ_STRINGS.TRANQ;
local STranq_string_SpellSelf = STRANQ_STRINGS.SPELLSELF;
local STranq_string_SpellOther = STRANQ_STRINGS.SPELLOTHER;
local STranq_string_SpellOtherMiss = STRANQ_STRINGS.SPELLOTHERMISS;
local STranq_string_Frenzy = STRANQ_STRINGS.FRENZY;
local STranq_string_FailSelf = STRANQ_STRINGS.FAILSELF;
local STranq_string_FailOther = STRANQ_STRINGS.FAILOTHER;
local STranq_string_GainFrenzy = STRANQ_STRINGS.GAINFRENZY;
local STranq_string_Removed = STRANQ_STRINGS.REMOVED;
local STranq_string_FrenzyEmote = STRANQ_STRINGS.FRENZYEMOTE;

local STranq_string_Dead = STRANQ_STRINGS.DEAD;
local STranq_string_LowMana = STRANQ_STRINGS.LOWMANA;
local STranq_string_Offline = STRANQ_STRINGS.OFFLINE;

local iconPath = "Interface\\Icons\\";

local STranq_Debuffs = {
	[iconPath.."Spell_Shadow_DeathScream"] = {8,STRANQ_STRINGS.PANIC};
	[iconPath.."Spell_Arcane_PortalOrgrimmar"] = {8,STRANQ_STRINGS.TIMELAPSE};
	[iconPath.."INV_Misc_Head_Dragon_Bronze"] = {4,STRANQ_STRINGS.TIMESTOP};
	[iconPath.."INV_Spear_02"] = {12,STRANQ_STRINGS.WYVERNSTING};
	[iconPath.."Spell_Shadow_ManaBurn"] = {8,STRANQ_STRINGS.MANABURN};
	[iconPath.."Spell_Shadow_SiphonMana"] = {6,STRANQ_STRINGS.MINDFLAY,STRANQ_STRINGS.FEAR};
	[iconPath.."Spell_Shadow_ShadowWordDominate"] = {10,STRANQ_STRINGS.CAUSEINSANITY};
	};

--== Options menu setup ==--
local options = {
};

local function CopyTable(copyTable)
	-- properly copies a table instead of referencing the same table, thanks Sallust.
	if ( not copyTable ) then return; end
	if ( type(copyTable) ~= "table" ) then
		return copyTable;
	else
		local returnTable = {};
		for k, v in pairs(copyTable) do
			returnTable[k] = CopyTable(v);
		end
		return returnTable;
	end
end

function STranq_Hover_OnUpdate()
	local over = MouseIsOver(this);
	if ( STranq_Timers.over ~= over ) then
		STranq_Timers.over = over;
		STranq_StatusBar_Display();
	end
end

--== Rotation Setup UI Functions ==--
function STranq_TimersMoveBar_OnUpdate()
	local curX, curY = GetCursorPosition();
	local scale = this:GetEffectiveScale();
	local frame = Stranq_FrenzyTimer;
	for i=1, getglobal(STranq_LastVisible):GetID() do
		local nextFrame = getglobal("Stranq_TranqTimer"..i);
		if ( nextFrame ) then
			local x, y = nextFrame:GetCenter();

			if ( STranq_Saved["BarsGrowUp"] and y * scale < curY ) then
				frame = nextFrame;
			elseif ( not STranq_Saved["BarsGrowUp"] and y * scale > curY ) then
				frame = nextFrame;
			else
				break;
			end
		end
	end

	local id, frameid = this:GetID(), frame:GetID();
	if ( id == 2 ) then
		STranq_Saved["MaxShown"] = frameid;
	elseif ( id == 1 ) then
		if ( frame:GetID() > 1 ) then
			STranq_Saved["PerGroup"] = frameid;
		else
			STranq_Saved["PerGroup"] = 0;
		end
	elseif ( id == 3 ) then
		local per = (STranq_Saved["PerGroup"] or 2);
		STranq_Saved["NumGroups"] = max(ceil(frameid/per),1);
	end

	local text = "";


	local perGroup = STranq_Saved["PerGroup"] or 2
	local numGroups = STranq_Saved["NumGroups"] or 2;
	local num = min(getn(STranq_Saved["Order"]),STranq_Saved["MaxShown"] or 5);
	if ( num < numGroups * perGroup ) then
		numGroups = ceil(num/perGroup);
	end

	if ( perGroup < 2 or perGroup >= num ) then
		local per = perGroup;
		if ( per == 0 ) then
			per = num;
		end
		text = string.format(STRANQ_STRINGS.ROTATION_OF, num);
	elseif ( numGroups == 1 ) then
		text = string.format(STRANQ_STRINGS.ROTATION_OF, perGroup);
	else
		if ( num >= numGroups * perGroup ) then
			text = string.format(STRANQ_STRINGS.GROUPS_OF, numGroups, perGroup);
		else
			if ( numGroups-1 > 1 ) then
				text = string.format(STRANQ_STRINGS.GROUPS_OF, numGroups-1, perGroup);
			else
				text = string.format(STRANQ_STRINGS.GROUP_OF, perGroup);
			end
			text = text .. ", "..string.format(STRANQ_STRINGS.GROUP_OF, mod(num,perGroup));
		end
	end
	if ( perGroup ~= 0 and num > numGroups * perGroup ) then
		text = text..", "..string.format(STRANQ_STRINGS.IN_RESERVE, num - numGroups*perGroup);
	end

	STranqToolTip:SetOwner(Stranq_FrenzyTimerButton, "ANCHOR_TOPLEFT");
	STranqToolTip:SetText(text, 1, 1, 1, 1);
	STranqToolTip:ClearAllPoints();
	STranqToolTip:SetPoint("BOTTOM", Stranq_FrenzyTimerButton, "TOP");

	STranq_StatusBar_Display();
end

function STranq_TimersMoveBar_OnMouseDown()
	this:LockHighlight();
	STranq_Timers.showExtra = 1;
	STranq_Timers.resizing = this;
	this:SetScript("OnUpdate", STranq_TimersMoveBar_OnUpdate);
end

function STranq_TimersMoveBar_OnMouseUp()
	STranq_Timers.showExtra = nil;
	STranq_Timers.resizing = nil;
	this:UnlockHighlight();
	STranqToolTip:Hide();
	this:SetScript("OnUpdate", nil);
	STranq_StatusBar_Display();
end

function STranq_CreateDragBar()
	DragFrame = CreateFrame("STATUSBAR", "STranq_DragFrame", UIParent, "STranqStatusBarTemplate");
	DragFrame:EnableMouse(0);
	DragFrame:SetFrameStrata("TOOLTIP");
	DragFrame:ClearAllPoints();
	local scale = STranq_Saved["BarScale"] or 1;
	DragFrame:SetScale(scale);
	DragFrame:SetWidth((STranq_Saved["BarWidth"] or 128) / scale);
	DragFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0);
	DragFrame:Hide();
	DragFrame:SetScript("OnShow", function() this.name:SetText(this.Name); end);
	local button = getglobal(DragFrame:GetName().."Button");
	button:EnableMouse(0);
	button:SetScript("OnUpdate", function()
			if ( not DragFrame.Name or not STranq_Hunters[DragFrame.Name] ) then
				DragFrame:Hide();
			end
			local curX, curY = GetCursorPosition();
			local scale = this:GetEffectiveScale();
			this:GetParent():SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", (curX + dragX)/scale, (curY + dragY)/scale);
		end);
end

function STranq_StatusBar_OnMouseDown()
	if ( DragFrame and DragFrame.Name ) then
		STranq_StatusBar_OnDragStop((arg1 == "RightButton"));
	elseif ( arg1 == "LeftButton" ) then
		local curX, curY, scale = GetCursorPosition();
		local barX, barY = this:GetLeft(), this:GetBottom();
		local scale = this:GetEffectiveScale();
		dragX = barX * scale - curX;
		dragY = barY * scale - curY;
		dragID = this:GetParent():GetID();
	end
end

function STranq_StatusBar_OnDragStart()
	if ( STranq_Saved["LockRot"] and not IsShiftKeyDown() ) then return; end

	if ( not DragFrame ) then
		STranq_CreateDragBar();
	end
	local scale = STranq_Saved["BarScale"] or 1;
	DragFrame:SetScale(scale);
	DragFrame:SetWidth((STranq_Saved["BarWidth"] or 128) / scale);
	DragFrame.Name = this:GetParent().Name;
	DragFrame:Show();
	STranq_StatusBar_Display();
end

function STranq_StatusBar_OnDragStop(force)
	if ( DragFrame and DragFrame.Name ) then
		local bar = GetMouseFocus():GetParent();
		local name = STranq_Saved["Order"][dragID];
		if ( force or (bar and string.find(bar:GetName() or "", "^Stranq_TranqTimer%d+$")) ) then
			if ( force ) then
				tremove(STranq_Saved["Order"], dragID);
				tinsert(STranq_Saved["Order"], name);
			else
				local id = bar:GetID();
				local tempName = STranq_Saved["Order"][id];
				STranq_Saved["Order"][id] = name;
				STranq_Saved["Order"][dragID] = tempName;
			end
			STranq_StatusBar_Setup();
			STranq_StatusBar_Display();
		end
		DragFrame.Name = nil;
		DragFrame:Hide();
		STranq_StatusBar_Display();
	end
end

function STranq_DropDown_Initialize()
	local info = {};
	if ( UIDROPDOWNMENU_MENU_VALUE == STRANQ_DROPDOWN_BARS_TEXT ) then
		info = {};
		info.notCheckable = 1;
		if ( STranq_Saved["LockBars"] ) then
			info.text = STRANQ_MENU_UNLOCK_POSITION;
		else
			info.text = STRANQ_MENU_LOCK_POSITION;
		end
		info.func = STranq_DropDown_OnClick;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.notCheckable = 1;
		if ( STranq_Saved["BarsGrowUp"] ) then
			info.text = STRANQ_MENU_GROW_DOWN;
		else
			info.text = STRANQ_MENU_GROW_UP;
		end
		info.func = STranq_DropDown_OnClick;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.notCheckable = 1;
		info.text = "Auto Hide";
		if ( STranq_Saved["AutoHideBars"] ) then
			info.text = STRANQ_MENU_SHOW_OUTSIDE_RAID;
		else
			info.text = STRANQ_MENU_HIDE_OUTSIDE_RAID;
		end
		info.func = STranq_DropDown_OnClick;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = STRANQ_HIDEBARS_TEXT;
		info.notCheckable = 1;
		info.func = STranq_DropDown_OnClick;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	elseif ( UIDROPDOWNMENU_MENU_VALUE == STRANQ_DROPDOWN_ROT_TEXT ) then
		info = {};
		info.notCheckable = 1;
		info.func = STranq_DropDown_OnClick;
		if ( STranq_Saved["LockRot"] ) then
			info.text = STRANQ_MENU_UNLOCK_ROTATION;
		else
			info.text = STRANQ_MENU_LOCK_ROTATION;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		if ( STranq_Saved["HideExtra"] ) then
			info.text = STRANQ_MENU_SHOW_EXTRA;
		else
			info.text = STRANQ_MENU_HIDE_EXTRA;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.disabled = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		if ( GetNumRaidMembers() > 0 ) then
			info.disabled = nil;
		end
		info.notCheckable = 1;
		info.text = STRANQ_MENU_BROADCAST_ROT;
		info.func = STranq_DropDown_OnClick;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	else
		info = {};
		if ( STranq_Options and STranq_Options:IsVisible() ) then
			info.text = STRANQ_MENU_CLOSE_OPTIONS;
		else
			info.text = STRANQ_MENU_OPEN_OPTIONS;
		end
		info.notCheckable = 1;
		info.func = STranq_Options_Toggle;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = STRANQ_DROPDOWN_BARS_TEXT;
		info.hasArrow = 1;
		info.notCheckable = 1;
		info.func = nil;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = STRANQ_DROPDOWN_ROT_TEXT;
		info.hasArrow = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end
end

function STranq_DropDown_OnClick()
	local id = this:GetID();
	HideDropDownMenu(1);
	if ( UIDROPDOWNMENU_MENU_VALUE == STRANQ_DROPDOWN_BARS_TEXT ) then
		if ( id == 1 ) then
			if ( STranq_Saved["LockBars"] ) then
				STranq_Saved["LockBars"] = nil;
				STranq_TimersResize:Show();
			else
				STranq_Saved["LockBars"] = 1;
				STranq_TimersResize:Hide();
			end
		elseif ( id == 2 ) then
			if ( STranq_Saved["BarsGrowUp"] ) then
				STranq_Saved["BarsGrowUp"] = nil;
			else
				STranq_Saved["BarsGrowUp"] = 1;
			end
			STranq_StatusBar_Display();
		elseif ( id == 3 ) then
			if ( STranq_Saved["AutoHideBars"] ) then
				STranq_Saved["AutoHideBars"] = nil;
			else
				STranq_Saved["AutoHideBars"] = 1;
				if ( GetNumRaidMembers() == 0 ) then
					STranq_Timers:Hide();
				end
			end
		elseif ( id == 4 ) then
			STranq_StatusBars_Toggle();
		end
	elseif ( UIDROPDOWNMENU_MENU_VALUE == STRANQ_DROPDOWN_ROT_TEXT ) then
		if ( id == 4 ) then
			STranq_SendRotation();
		elseif ( id ==1 ) then
			if ( STranq_Saved["LockRot"] ) then
				STranq_Saved["LockRot"] = nil;
			else
				STranq_Saved["LockRot"] = 1;
			end
		elseif ( id == 2 ) then
			if ( STranq_Saved["HideExtra"] ) then
				STranq_Saved["HideExtra"] = nil;
			else
				STranq_Saved["HideExtra"] = 1;
			end
		end
		STranq_StatusBar_Display();
	end
end

function STranq_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, STranq_DropDown_Initialize, "MENU");
end

--== Frenzy Timer ==--
function STranq_Frenzy_OnLoad()
	local barname = this:GetName();
	this.name = getglobal(barname.."Name");
	this.count = getglobal(barname.."Count")
	this.warn = getglobal(barname.."Warn")
	this.spark = getglobal(barname.."Spark");
	this.flash = getglobal(barname.."Flash");
	this.flash2 = getglobal(barname.."Flash2");
	this.border1 = getglobal(barname.."Border1");
	this.border2 = getglobal(barname.."Border2");
	this.border3 = getglobal(barname.."Border3");
	this.icon = getglobal(barname.."Icon");
	this.button = getglobal(barname.."Button");
	this.flash:Hide();
	this.flash:SetVertexColor(1.0,1,0,0.98);
	this.flash2:Hide();
	this.flash2:SetVertexColor(1.0,1,0,0.98);
	this.spark:Hide();
	this.icon:Hide();
	this.name:SetText(STranq_string_Frenzy);
	this.warn:SetText(STranq_string_Frenzy);
	this.warn:Hide();
	this.MaxValue = 15;
	this:SetMinMaxValues(0,1);
	this:SetStatusBarColor(1, 0.25, 0);
	getglobal(this.button:GetName().."Highlight"):SetVertexColor(0.5,0.5,1,0.5);

	this.button:SetScript("OnMouseDown", function() if ( arg1 == "LeftButton" and not STranq_Saved["LockBars"] ) then STranq_Timers:StartMoving(); end end);

	this.button:SetScript("OnMouseUp", function() STranq_Timers:StopMovingOrSizing(); end);

	this.button:SetScript("OnClick", function()
			if ( arg1 == "RightButton" ) then
				STranq_DropDown.point = "TOP";
				STranq_DropDown.relativePoint = "BOTTOM";
				ToggleDropDownMenu(1, nil, STranq_DropDown, "Stranq_FrenzyTimerButton", 0, 0);
			end
		end
		);

	this.button:SetScript("OnEnter", function()
			if ( STranq_Saved["LockBars"] or STranq_Timers.resizing ) then
				Stranq_FrenzyTimerButtonHighlight:Hide();
			else
				Stranq_FrenzyTimerButtonHighlight:Show();
			end
			if ( not STranq_Timers.resizing ) then
				STranqToolTip:SetOwner(this, "ANCHOR_TOPLEFT");
				STranqToolTip:SetText(STranqTitle, 1, 1, 1, 1);
				STranqToolTip:ClearAllPoints();
				STranqToolTip:SetPoint("BOTTOM", this, "TOP");
			end
		end
		);

	this.button:SetScript("OnLeave", function()
			STranqToolTip:Hide();
		end
		);
	this.button:SetScript("OnDragStart", nil);
	this.button:SetScript("OnDragStop", nil);

	local _,_,_,_,_,_,_,_,_,_,_,bar = this:GetRegions();
	bar:SetDrawLayer("BACKGROUND");
end

function STranq_Frenzy_OnUpdate()
	local curtime = GetTime();
	local warn = this.icon:IsVisible();

	this.flash:Hide();
	this.flash2:Hide();

	if ( STranq_Frenzy.Flash ) then
		local alpha = 1 - (curtime-STranq_Frenzy.Flash)*5;
		if ( alpha > 0 ) then
			this.flash:Show();
			this.flash:SetAlpha(alpha);
		else
			STranq_Frenzy.Flash = nil;
			this.flash:Hide();
		end
	end

	if ( warn ) then
		this.warn:Show();
		this.warn:SetAlpha(1);
		this:SetStatusBarColor(1,0,0);
		STranq_Frenzy.WarnTime = curtime;
	elseif ( STranq_Frenzy.WarnTime ) then
		this:SetStatusBarColor(1,0.33,0);
		if ( curtime - STranq_Frenzy.WarnTime > 1 ) then
			this.warn:Hide();
		else
			this.warn:SetAlpha((STranq_Frenzy.WarnTime-curtime)/1);
		end
	end

	if ( STranq_Frenzy.StartTime ) then
		this.flash2:Hide();
		local status = curtime-STranq_Frenzy.StartTime;
		if ( status > STranq_Frenzy.MaxValue ) then
			this:SetStatusBarColor(1, 0.33, 0);
			STranq_Frenzy.StartTime = nil;
			this.count:SetText("");
			this.spark:Hide();
			if ( STranq_Frenzy.Range ) then
				STranq_Frenzy.RangeStart = curtime;
			else
				STranq_Frenzy.Flash = curtime;
				STranq_Frenzy.End = curtime;
			end
			this:SetValue(1);
		else
			if ( status < 0 ) then
				status = 0;
			elseif ( status < 0.2 ) then
				this.flash2:Show();
				this.flash2:SetAlpha(1-status/0.2);
			end

			this.count:SetText("("..format("%2.1f",STranq_Frenzy.MaxValue-status)..")");
			local percent = max(min(status/STranq_Frenzy.MaxValue,1),0);
			this:SetValue(percent);

			local sparkPosition = percent * (STranq_Saved["BarWidth"] or 128) / (STranq_Saved["BarScale"] or 1);
			this.spark:Show();
			this.spark:SetPoint("CENTER", this, "LEFT", sparkPosition, -1);
			if ( warn ) then
				this:SetStatusBarColor(1,0,0);
			else
				this:SetStatusBarColor(1,(1-percent)/1.33+0.33,0);
			end
		end
	end

	if ( STranq_Frenzy.RangeStart ) then
		if ( curtime <= STranq_Frenzy.RangeStart + STranq_Frenzy.Range ) then
			this.flash2:Show();
			this.flash:Show();
			local alpha = abs(sin(360*(curtime-STranq_Frenzy.RangeStart)));
			this.flash2:SetAlpha(alpha);
			this.flash:SetAlpha(1-alpha);

			local percent = 1-max(min((curtime-STranq_Frenzy.RangeStart)/STranq_Frenzy.Range,1),0);
			local sparkPosition = percent * (STranq_Saved["BarWidth"] or 128) / (STranq_Saved["BarScale"] or 1);
			this.spark:Show();
			this.spark:SetPoint("CENTER", this, "LEFT", sparkPosition, -1);
		else
			this.spark:Hide();
			this.flash2:Hide();
			this.Flash = curtime;
			STranq_Frenzy.End = curtime;
			STranq_Frenzy.RangeStart = nil;
			STranq_Frenzy.Range = nil;
		end
	end

	if ( STranq_Frenzy.Frenzies and STranq_Frenzy.Frenzies < 0 ) then
		Stranq_FrenzyTimerNum:SetText("!");
	else
		Stranq_FrenzyTimerNum:SetText("");
	end

	if ( STranq_Frenzy.End ) then
		if ( curtime - STranq_Frenzy.End > 60 ) then
			STranq_Frenzy.Frenzies = nil;
			this.name:SetText(STranq_string_Frenzy);
			this.icon:Hide();
		end
	end
end

--== Hunter Timers ==--
function STranq_StatusBar_OnLoad()
	local id = this:GetID();
	local barname = this:GetName();
	this.name = getglobal(barname.."Name");
	this.count = getglobal(barname.."Count")
	this.warn = getglobal(barname.."Warn")
	this.spark = getglobal(barname.."Spark");
	this.flash = getglobal(barname.."Flash");
	this.flash2 = getglobal(barname.."Flash2");
	this.border1 = getglobal(barname.."Border1");
	this.border2 = getglobal(barname.."Border2");
	this.border3 = getglobal(barname.."Border3");
	this.icon = getglobal(barname.."Icon");
	this.button = getglobal(barname.."Button");
	this.flash:SetVertexColor(1.0,1,0,0.98);
	this.flash2:SetVertexColor(1.0,1,0,0.98);
	this.MaxValue = 20;
	this:SetMinMaxValues(0,1);
	this:SetStatusBarColor(0, 1, 0);
	getglobal(this.button:GetName().."Highlight"):SetVertexColor(0.5,0.5,1,0.5);
	local _,_,_,_,_,_,_,_,_,_,_,bar = this:GetRegions();
	bar:SetDrawLayer("BACKGROUND");
end

function STranq_StatusBar_OnUpdate()
	local hunter = STranq_Hunters[this.Name];

	local r, g, b = 0, 1, 0;

	if ( not hunter or (DragFrame and this ~= DragFrame and DragFrame.Name == this.Name) ) then
		this:SetValue(0);
		this.name:Hide();
		this.flash:Hide();
		this.flash2:Hide();
		this.warn:Hide();
		this.icon:Hide()
		this.spark:Hide();
		this.count:Hide();
		return;
	end

	local curtime = GetTime();

	this.name:Show();
	this.count:Show();
	this.name:SetVertexColor(1,1,1);
	this.count:SetVertexColor(1,1,1);
	this.icon:Hide();
	this.spark:Hide();
	this.flash:Hide();
	this.flash2:Hide();
	this:SetValue(1);

	if ( hunter.Flash ) then
		local alpha = 1 - (curtime-hunter.Flash)*5;
		if ( alpha > 0 ) then
			this.flash:Show();
			this.flash:SetAlpha(alpha);
		else
			hunter.Flash = nil;
			this.flash:Hide();
		end
	end

	if ( hunter.Warn ) then
		if ( hunter.Warn > curtime ) then
			this.warn:Show();
			this.warn:SetAlpha(min(hunter.Warn-curtime,1));
			this.warn:SetText(hunter.WarnText);
		else
			hunter.Warn = nil;
			this.warn:Hide();
		end
	else
		this.warn:Hide();
	end

	if ( hunter.StartTime ) then
		this.flash2:Hide();
		local status = curtime-hunter.StartTime;
		local ping = hunter.Ping or 0;
		if ( status + ping > hunter.MaxValue ) then
			status = hunter.MaxValue;
			this:SetStatusBarColor(0, 1, 0);
			hunter.Flash = curtime;
			hunter.StartTime = nil;
			this.count:SetText("");
			this.spark:Hide();
			if ( hunter.Debuff ) then
				hunter.Debuff = nil;
				hunter.MaxValue = STranq_TranqCooldown;
				this.icon:Hide();
			end
			return;
		elseif ( status < 0 ) then
			status = 0;
		elseif ( status < 0.2 ) then
			this.flash2:Show();
			this.flash2:SetAlpha(1-status/0.2);
		end
		status = status + ping;
		this.count:SetText("("..format("%2.1f",hunter.MaxValue-status)..")");
		local percent = max(min(status/hunter.MaxValue,1),0);
		this:SetValue(percent);

		local sparkPosition = percent * (STranq_Saved["BarWidth"] or 128) / (STranq_Saved["BarScale"] or 1);
		this.spark:Show();
		this.spark:SetPoint("CENTER", this, "LEFT", sparkPosition, -1);

		if ( hunter.Debuff ) then
			r, g, b = 1-percent, percent, 0;
			this.icon:Show();
			this.icon:SetTexture(hunter.DebuffTexture);
		elseif ( hunter.WarnText ) then
			r, g, b = 1-percent, percent, 0;
		else
			r, g, b = 0, percent, 1-percent;
		end
	end

	if ( hunter.Offline ) then
		this.count:SetText(STranq_string_Offline);
		r, g, b = 0, 0.25, 0;
		this.name:SetVertexColor(0.5,0.5,0.5);
		this.count:SetVertexColor(0.5,0.5,0.5);
		this:SetValue(1);
		hunter.StartTime = nil;
		this.flash:Hide();
		this.icon:SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
		this.icon:Show();
		this.spark:Hide();
		this.warn:Hide();
	elseif ( hunter.FD ) then
		this.icon:SetTexture("Interface\\Icons\\Ability_Rogue_FeignDeath");
		this.icon:Show();
		r, g, b = 0, 0.25, 0;
		this.count:SetVertexColor(0.5,0.5,0.5);
	elseif ( hunter.Dead ) then
		this.count:SetText(STranq_string_Dead);
		r, g, b = 0, 0.25, 0;
		this.name:SetVertexColor(0.5,0.5,0.5);
		this.count:SetVertexColor(0.5,0.5,0.5);
		this:SetValue(1);
		this.flash:Hide();
		this.spark:Hide();
		this.warn:Hide();
		this.icon:SetTexture("Interface\\LootFrame\\LootPanel-Icon");
		this.icon:Show();
	elseif ( hunter.Oom and not hunter.Debuff ) then
		this.count:SetText(STranq_string_LowMana);
		r, g, b = 0, 0.25, 0;
		this.count:SetVertexColor(0.5,0.5,0.5);
	elseif ( not hunter.StartTime ) then
		this.count:SetText("");
		r, g, b = 0, 1, 0;
	end

	if ( hunter.Ver ) then
		local color = "|cffffffff";
		this.warn:Show();
		local text = STRANQ_TITLESHORT.." "..(hunter.VerText or STRANQ_STRINGS.NOTFOUND);
		if ( hunter.AcceptRot or not hunter.VerText ) then
			if ( hunter.AcceptRot == 1 ) then
				color = "|cff00ff00";
			else
				color = "";
			end
		end
		this.warn:SetText(color..text);
		if ( curtime - hunter.Ver >= 6 ) then
			hunter.Ver = nil;
			hunter.AcceptRot = nil;
		end
	end

	if ( this.button.MouseOver ) then
		STranq_StatusBar_OnEnter(this.button);
	end

	if ( this:GetID() > (STranq_Saved["MaxShown"] or 5) ) then
		this.name:SetVertexColor(0.5,0.5,0.5);
		this.count:SetVertexColor(0.5,0.5,0.5);
		local z = (r+g+b)/3;
		r, g, b = r*0.1+z*0.9, g*0.1+z*0.9, b*0.1+z*0.9;
	elseif ( this:GetID() > ((STranq_Saved["PerGroup"] or 2) * (STranq_Saved["NumGroups"] or 2)) and STranq_Saved["PerGroup"] ~= 0 ) then
		b, g = b+g*0.3, g*0.7;
	end

	this:SetStatusBarColor(r, g, b);
end

function STranq_StatusBar_OnEnter(button)
	if ( (STranq_Saved["LockRot"] and not IsShiftKeyDown() and not (DragFrame and DragFrame.Name)) or STranq_Timers.resizing ) then
		getglobal(button:GetName().."Highlight"):Hide();
	else
		getglobal(button:GetName().."Highlight"):Show();
	end
	if ( not STranq_Timers.resizing ) then
		local curx, cury = STranq_Hover:GetCenter();
		local scale = STranq_Hover:GetEffectiveScale();
		curx, cury = curx*scale, cury*scale;
		if ( curx < UIParent:GetWidth()/2 ) then
			if ( cury < 384 ) then
				STranqToolTip:SetOwner(button, "ANCHOR_RIGHT");
			else
				STranqToolTip:SetOwner(button, "ANCHOR_BOTTOMRIGHT");
			end
		else
			if ( cury < 384 ) then
				STranqToolTip:SetOwner(button, "ANCHOR_LEFT");
			else
				STranqToolTip:SetOwner(button, "ANCHOR_BOTTOMLEFT");
			end
		end
		local bar = button:GetParent();
		local hunter = STranq_Hunters[bar.Name]
				STranqToolTip:AddLine(bar.Name, 1, 1, 1, 1);
		if ( hunter ) then
		local perGroup = (STranq_Saved["PerGroup"] or 2);
		local numGroups = (STranq_Saved["NumGroups"] or 2);
		if ( (STranq_Saved["PerGroup"] or 2) > 1 ) then
			local id = button:GetParent():GetID();
			if ( id > (STranq_Saved["MaxShown"] or 5) ) then
				STranqToolTip:AddLine(STRANQ_TOOLTIP_INACTIVE, 0.6, 0.6, 0.6, 1);
			elseif ( id > perGroup*numGroups ) then
				STranqToolTip:AddLine(STRANQ_TOOLTIP_RESERVE, 0.6, 0.6, 0.6, 1);
			else
				local group = max(ceil(id/perGroup),1);
				if ( numGroups > 1 and getglobal(STranq_LastVisible):GetID() > perGroup) then
					STranqToolTip:AddLine(STRANQ_TOOLTIP_GROUP.." "..group, 0.6, 0.6, 0.6, 1);
				else
					STranqToolTip:AddLine(STRANQ_TOOLTIP_IN_ROTATION, 0.6, 0.6, 0.6, 1);
				end
			end
		end
			if ( bar.Name == UnitName("player") ) then
				STranqToolTip:AddLine(STRANQ_TITLESHORT.." "..STranqVersion, 0.6, 0.6, 0.6, 1);
			elseif ( hunter.VerText ) then
				STranqToolTip:AddLine(STRANQ_TITLESHORT.." "..hunter.VerText, 0.6, 0.6, 0.6, 1);
			end
			if ( hunter.Dead ) then
				STranqToolTip:AddLine(STRANQ_TOOLTIP_DEAD, 1, 0, 0, 1);
			elseif ( hunter.FD ) then
				STranqToolTip:AddLine(STRANQ_TOOLTIP_FEIGN_DEATH, 1, 0, 0, 1);
			elseif ( hunter.Warn ) then
				STranqToolTip:AddLine(hunter.WarnText, 1, 0, 0, 1);
			end
		else
			STranqToolTip:AddLine("Does not exist?", 0.6, 0.6, 0.6, 1);
		end
		STranqToolTip:Show();
	end
end

function STranq_StatusBar_OnClick()
	if ( not IsShiftKeyDown() or not DragFrame or not DragFrame.Name ) then
		if ( arg1 == "LeftButton" ) then
			local name = this:GetParent().Name;
			for i=1, GetNumRaidMembers() do
				if ( UnitName("raid"..i) == name ) then
					TargetUnit("raid"..i);
				end
			end
		else

		end
	end
end;

function STranq_StatusBar_Setup()
	local order = STranq_Saved["Order"];
	if ( not order ) then
		order = {};
		STranq_Saved["Order"] = order;
	end
	local num = GetNumRaidMembers();
	if ( num > 0 ) then
		local savedList = {};
		for k, v in order do
			savedList[v]=1;
		end
		local playername = UnitName("player");
		for i=1, num do
			local name, _, _, _, _, fileName = GetRaidRosterInfo(i);
			if ( fileName == "HUNTER" ) then
				if ( not savedList[name] ) then
					tinsert( order, name );
				else
					savedList[name] = nil;
				end
				if ( not STranq_Hunters[name] ) then
					STranq_Hunters[name] = {};
					if ( name == playername ) then
						STranq_Hunters[name].VerText = STranqVersion;
					end
				end
				STranq_ScanDebuffs("raid"..i);
				STranq_CheckHealth("raid"..i);
			end
		end
		for i=getn(order), 1, -1 do
			local name = order[i];
			if ( savedList[name] ) then
				tremove( order, i );
				savedList[name] = nil;
			end
		end
	else
		for k in pairs(order) do
			order[k] = nil;
		end
	end
	STranq_StatusBar_Display();
end

local StatusBarSpace = -22;
local StatusBarNoSpace = -14;

function STranq_StatusBar_SetBorder(bar, style, up)
	if ( up and style ) then
		style = style * -1;
	end
	if ( style == 0 ) then
		-- Single
		local point, frame, relative = bar:GetPoint("TOPLEFT");
		if ( up ) then
			bar:SetPoint(point,frame,relative,0,-StatusBarSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,-StatusBarSpace);
		else
			bar:SetPoint(point,frame,relative,0,StatusBarSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,StatusBarSpace);
		end
		bar.border1:ClearAllPoints();
		bar.border1:SetPoint("LEFT",bar,"LEFT", -3, 0);
		bar.border1:SetTexCoord(0,0.0625,0,1);
		bar.border1:SetHeight(22);
		bar.border2:ClearAllPoints();
		bar.border2:SetPoint("RIGHT",bar,"RIGHT", 3, 0);
		bar.border2:SetTexCoord(0.9375,1,0,1);
		bar.border2:SetHeight(22);
		bar.border3:SetTexCoord(0.0625,0.9375,0,1);
		bar.border3:SetHeight(22);
	elseif ( style == 1 ) then
		-- Top
		local point, frame, relative = bar:GetPoint("TOPLEFT");
		if ( up ) then
			bar:SetPoint(point,frame,relative,0,-StatusBarNoSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,-StatusBarNoSpace);
		else
			bar:SetPoint(point,frame,relative,0,StatusBarSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,StatusBarSpace);
		end
		bar.border1:ClearAllPoints();
		bar.border1:SetPoint("BOTTOMLEFT",bar,"BOTTOMLEFT", -3, 0);
		bar.border1:SetHeight(18);
		bar.border1:SetTexCoord(0,0.0625,0,0.8);
		bar.border2:ClearAllPoints();
		bar.border2:SetPoint("BOTTOMRIGHT",bar,"BOTTOMRIGHT", 3, 0);
		bar.border2:SetHeight(18);
		bar.border2:SetTexCoord(0.9375,1,0,0.8);
		bar.border3:SetHeight(18);
		bar.border3:SetTexCoord(0.0625,0.9375,0,0.8);
	elseif ( style == -1 ) then
		-- Bottom
		local point, frame, relative = bar:GetPoint("TOPLEFT");
		if ( up ) then
			bar:SetPoint(point,frame,relative,0,-StatusBarSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,-StatusBarSpace);
		else
			bar:SetPoint(point,frame,relative,0,StatusBarNoSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,StatusBarNoSpace);
		end
		bar.border1:ClearAllPoints();
		bar.border1:SetPoint("TOPLEFT",bar,"TOPLEFT", -3, 0);
		bar.border1:SetHeight(18);
		bar.border1:SetTexCoord(0,0.0625,0.2,1);
		bar.border2:ClearAllPoints();
		bar.border2:SetPoint("TOPRIGHT",bar,"TOPRIGHT", 3, 0);
		bar.border2:SetHeight(18);
		bar.border2:SetTexCoord(0.9375,1,0.2,1);
		bar.border3:SetHeight(18);
		bar.border3:SetTexCoord(0.0625,0.9375,0.2,1);
	else
		-- Between
		local point, frame, relative = bar:GetPoint("TOPLEFT");
		if ( up ) then
			bar:SetPoint(point,frame,relative,0,-StatusBarNoSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,-StatusBarNoSpace);
		else
			bar:SetPoint(point,frame,relative,0,StatusBarNoSpace);
			bar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,StatusBarNoSpace);
		end
		bar.border1:ClearAllPoints();
		bar.border1:SetPoint("LEFT",bar,"LEFT", -3, 0);
		bar.border1:SetTexCoord(0,0.0625,0.2,0.8);
		bar.border1:SetHeight(14);
		bar.border2:ClearAllPoints();
		bar.border2:SetPoint("RIGHT",bar,"RIGHT", 3, 0);
		bar.border2:SetTexCoord(0.9375,1,0.2,0.8);
		bar.border2:SetHeight(14);
		bar.border3:SetTexCoord(0.0625,0.9375,0.2,0.8);
		bar.border3:SetHeight(14);
	end
end

function STranq_StatusBar_Resize()
	local up = STranq_Saved["BarsGrowUp"];
	local curX, curY = GetCursorPosition();
	local scale, effscale = STranq_TimersScaler:GetScale(), STranq_Timers:GetEffectiveScale();

	local left, top = effscale * STranq_Timers:GetLeft(), effscale * STranq_Timers:GetTop();
	local voff = abs(top - curY);

	if ( not this.offset ) then
		this.offset = left + effscale*STranq_Timers:GetWidth() - curX;
		this.voffset = voff;
		this.vscale = scale;
	else
		scale = max(min((voff*this.vscale)/this.voffset,1.5),0.5);
		local width = max(min((curX - left + this.offset)/effscale,384),64*scale);

		if ( IsShiftKeyDown() ) then
			scale = scale - mod(scale, 0.125);
			width = width - mod(width, 16);
		end

		if ( STranq_Options_BarScale:IsVisible() ) then
			STranq_Options_BarScale:SetValue( scale );
		end

		STranq_TimersScaler:SetScale( scale );
		STranq_Saved["BarScale"] = scale;

		STranq_Timers:SetWidth(width);
		STranq_Saved["BarWidth"] = width;

		if ( up and curY < top-6 ) then
			STranq_Saved["BarsGrowUp"] = nil;
			STranq_StatusBar_Display();
		elseif ( not up and curY > top-6 ) then
			STranq_Saved["BarsGrowUp"] = 1;
			STranq_StatusBar_Display();
		end
	end
end

function STranq_StatusBar_ResizeStart()
	this:SetScript("OnUpdate", STranq_StatusBar_Resize );
	this:LockHighlight();
	STranq_Timers.resizing = this;
end

function STranq_StatusBar_ResizeStop()
	this:SetScript("OnUpdate", nil );
	this:UnlockHighlight();
	this.offset = nil;
	this.voffset = nil;
	STranq_Timers.resizing = nil;
end

function STranq_StatusBar_Display()
	local alpha, scale = (STranq_Saved["BarAlpha"] or 1), (STranq_Saved["BarScale"] or 1);
	local width, up = (STranq_Saved["BarWidth"] or 128), STranq_Saved["BarsGrowUp"];
	local lockbar, lockrot = STranq_Saved["LockBars"], STranq_Saved["LockRot"];
	local hide, hideextra, show = STranq_Saved["HideBars"], STranq_Saved["HideExtra"], (STranq_Timers.over or STranq_Timers.resizing);

	if ( STranqTimers:IsVisible() ) then
		show = 1;
		scale = STranq_Options_BarScale:GetValue();
		lockbar = STranq_Options_LockBars:GetChecked();
		lockrot = STranq_Options_LockRot:GetChecked();
		alpha = STranq_Options_BarAlpha:GetValue()
		up = STranq_Options_BarsGrowUp:GetChecked();
		hide = STranq_Options_HideBars:GetChecked();
		hideextra = STranq_Options_HideExtra:GetChecked();
	end

	if ( not STranqTimers:IsVisible() and ( hide or ( STranq_Saved["AutoHideBars"] and ( GetNumRaidMembers() == 0 or GetNumBattlefieldScores() > 0 ))) ) then
		STranq_Timers:Hide();
		return;
	else
		STranq_Timers:Show();
	end

	STranq_Timers:SetAlpha(alpha);
	STranq_Timers:SetWidth(width);
	STranq_TimersScaler:SetScale(scale);

	STranq_LastVisible = "Stranq_FrenzyTimer";

	if ( not STranq_Saved["Order"] ) then
		STranq_Saved["Order"] = {};
	end

	local maxShown = (STranq_Saved["MaxShown"] or 5);
	local perGroup = (STranq_Saved["PerGroup"] or 2);
	local numGroups = (STranq_Saved["NumGroups"] or 2);
	local num = getn(STranq_Saved["Order"]);
	local rem = num - numGroups*perGroup;

	local loop = num;
	if ( STranq_Timers.num and num < STranq_Timers.num ) then
		loop = STranq_Timers.num;
	end

	for i=1, loop do
		local name = STranq_Saved["Order"][i];
		local bar = getglobal("Stranq_TranqTimer"..i);
		if ( name ) then
			if ( not bar ) then
				bar = CreateFrame("STATUSBAR", "Stranq_TranqTimer"..i, STranq_TimersScaler, "STranqStatusBarTemplate");
				bar:SetAlpha(alpha);
				bar:SetID(i);
				STranq_Timers.num = (STranq_Timers.num or 0) + 1;
				bar:SetPoint("TOPLEFT", STranq_LastFrame, "TOPLEFT");
				STranq_LastFrame = bar:GetName();
			end
			bar:Show();
			bar.name:SetText(name);
			bar.Name = name;
			local style;
			if ( i == 1 or (i <= maxShown and i <= numGroups*perGroup+1 and mod(i,perGroup)-1 == 0 ) or i == maxShown+1) then
				style = (style or 0) + 1;
			end
			if ( i == num or ( i <= maxShown and i <= numGroups*perGroup and mod(i,perGroup) == 0 ) or i == maxShown) then
				style = (style or 0) - 1;
			end
			STranq_StatusBar_SetBorder(bar,style,up);
			if ( hideextra and i > maxShown ) then
				if ( (DragFrame and DragFrame.Name) or (show and not lockrot) ) then
					STranq_LastVisible = bar:GetName();
				else
					bar:Hide();
				end
			else
				STranq_LastVisible = bar:GetName();
			end
		elseif ( bar ) then
			bar:Hide();
		end
	end

	local lastid = getglobal(STranq_LastVisible):GetID();

	if ( up ) then
		STranq_TimersResize:ClearAllPoints();
		STranq_TimersResize:SetPoint("TOPRIGHT", STranq_LastVisible, "TOPRIGHT", 4, 4 );
		STranq_TimersResizeNormal:SetTexCoord(0.6,0.8,0.2,0.4);
		STranq_TimersResizePushed:SetTexCoord(0.58,0.78,0.22,0.42);
		STranq_TimersResizeHighlight:SetPoint("CENTER", STranq_TimersResize, "CENTER", 2, 2);
		STranq_TimersGroup:SetPoint("CENTER", getglobal("Stranq_TranqTimer"..min(min(perGroup,maxShown),lastid)) or Stranq_FrenzyTimer, "LEFT", 4, 11);
		STranq_TimersGroups:SetPoint("CENTER", getglobal("Stranq_TranqTimer"..min(min(perGroup*numGroups,maxShown),lastid)) or Stranq_FrenzyTimer,"RIGHT", -4, 11);
		STranq_TimersBackup:SetPoint("LEFT", getglobal("Stranq_TranqTimer"..min(maxShown,lastid)) or Stranq_FrenzyTimer, "LEFT", 0, 11);

		STranq_Hover:ClearAllPoints();
		STranq_Hover:SetPoint("BOTTOMLEFT", STranq_Timers, "BOTTOMLEFT", -20, -20);
		STranq_Hover:SetPoint("BOTTOMRIGHT", STranq_Timers, "BOTTOMRIGHT", 20, -20);
		STranq_Hover:SetPoint("TOP", ((not lockrot and getglobal("Stranq_TranqTimer"..num)) or STranq_LastVisible), "TOP", 0, 20);
	else
		STranq_TimersResize:ClearAllPoints();
		STranq_TimersResize:SetPoint("BOTTOMRIGHT", STranq_LastVisible, "BOTTOMRIGHT", 4, -4 );
		STranq_TimersResizeNormal:SetTexCoord(0.6,0.8,0.6,0.8);
		STranq_TimersResizePushed:SetTexCoord(0.58,0.78,0.58,0.78);
		STranq_TimersResizeHighlight:SetPoint("CENTER", STranq_TimersResize, "CENTER", 2, -2);
		STranq_TimersGroup:SetPoint("CENTER", getglobal("Stranq_TranqTimer"..min(min(perGroup,maxShown),lastid)) or Stranq_FrenzyTimer,"LEFT", 4, -11);
		STranq_TimersGroups:SetPoint("CENTER", getglobal("Stranq_TranqTimer"..min(min(perGroup*numGroups,maxShown),lastid)) or Stranq_FrenzyTimer,"RIGHT", -4, -11);
		STranq_TimersBackup:SetPoint("LEFT", getglobal("Stranq_TranqTimer"..min(maxShown,lastid)) or Stranq_FrenzyTimer, "LEFT", 0, -11);

		STranq_Hover:ClearAllPoints();
		STranq_Hover:SetPoint("TOPLEFT", STranq_Timers, "TOPLEFT", -20, 20);
		STranq_Hover:SetPoint("TOPRIGHT", STranq_Timers, "TOPRIGHT", 20, 20);
		STranq_Hover:SetPoint("BOTTOM", ((not lockrot and getglobal("Stranq_TranqTimer"..num)) or STranq_LastVisible), "BOTTOM", 0, -20);
	end

	local level = getglobal(STranq_LastFrame).button:GetFrameLevel() + 1;
	STranq_TimersResize:SetFrameLevel(level+1);
	STranq_TimersBackup:SetFrameLevel(level);
	STranq_TimersGroup:SetFrameLevel(level);
	STranq_TimersGroups:SetFrameLevel(level);

	if ( (not DragFrame or not DragFrame.Name) and show and not lockrot and num > 0) then
		STranq_TimersBackup:Show();
		if ( maxShown > 2 and num > 2 and perGroup > 0 and perGroup < num ) then
			STranq_TimersGroups:Show();
		else
			STranq_TimersGroups:Hide();
		end
		if ( maxShown > 2 and num > 2 ) then
			STranq_TimersGroup:Show();
		else
			STranq_TimersGroup:Hide();
		end
	else
		STranq_TimersGroup:Hide();
		STranq_TimersBackup:Hide();
		STranq_TimersGroups:Hide();
	end
	if ( (not DragFrame or not DragFrame.Name) and show and not lockbar ) then
		STranq_TimersResize:Show();
	else
		STranq_TimersResize:Hide();
	end
end

function STranq_StatusBar_SetFrenzy(mob,sender)
	if ( STranq_Mobs[mob] and not STranq_Mobs[mob].ignore ) then
		local curtime = GetTime();
		if ( not STranq_Frenzy.LastFrenzy or curtime - STranq_Frenzy.LastFrenzy > 2 ) then
			if ( STranq_Mobs[mob].frenzy) then
				STranq_Frenzy.MaxValue = STranq_Mobs[mob].frenzy;
				STranq_Frenzy.Range = STranq_Mobs[mob].range;
				STranq_Frenzy.RangeStart = nil;
				STranq_Frenzy.End = nil;
				STranq_Frenzy.Frenzies = 0;
			else
				if ( not STranq_Frenzy.Frenzies or STranq_Frenzy.Frenzies > 0 ) then
					STranq_Frenzy.Frenzies = 0;
				elseif ( STranq_Frenzy.Frenzies > -4 ) then
					STranq_Frenzy.Frenzies = STranq_Frenzy.Frenzies - 1;
					if ( sender ) then
						STranq_Frenzy[sender] = curtime;
					end
				end
				STranq_Frenzy.MaxValue = 0;
				STranq_Frenzy.Range = nil;
			end
			STranq_Frenzy.LastFrenzy = curtime;
			STranq_Frenzy.StartTime = curtime;
			STranq_Frenzy.RangeStart = nil;
			STranq_Frenzy.End=nil;
			Stranq_FrenzyTimerIcon:Show();
			Stranq_FrenzyTimerName:SetText(mob);
		end
	end
end

local STranq_StatusBar_Warnings = {STRANQ_STRINGS.MISSED,STRANQ_STRINGS.FAILED};

function STranq_StatusBar_Event(name, mob, warn, offset)
	local hunter = STranq_Hunters[name];
	if ( hunter ) then
		local curtime = GetTime();
		hunter.WarnText = nil;
		hunter.MaxValue = STranq_TranqCooldown;
		hunter.Debuff = nil;

		if ( warn ~= 2 ) then
			if ( not hunter.StartTime or curtime - hunter.StartTime > 10 ) then
				hunter.StartTime = curtime;
			end
			if ( offset ) then
				hunter.Ping = offset/1000;
			end
		elseif ( not hunter.Warn and STranq_Frenzy.Frenzies ) then
			STranq_Frenzy.Frenzies = STranq_Frenzy.Frenzies - 1;
		end

		if ( warn ) then
			if ( hunter.Warn ) then
				return;
			elseif ( not STranq_Saved["HideRaidMisses"] ) then
				if ( warn == 1 ) then
					UIErrorsFrame:AddMessage( STranq_Name(STranq_Saved.RaidErr,name,mob), STranq_Saved.MissColor.r, STranq_Saved.MissColor.g, STranq_Saved.MissColor.b , 1.0, UIERRORS_HOLD_TIME);
				elseif ( warn == 2 ) then
					UIErrorsFrame:AddMessage( STranq_Name(STranq_Saved.RaidFailErr,name,mob), STranq_Saved.MissColor.r, STranq_Saved.MissColor.g, STranq_Saved.MissColor.b , 1.0, UIERRORS_HOLD_TIME);
				end
				if ( not STranq_Saved["NoSound"] ) then
					PlaySound("RaidWarning");
				end
			end

			hunter.Warn = curtime + 10;
			hunter.WarnText = STranq_StatusBar_Warnings[warn];
		elseif ( STranq_Frenzy.Frenzies ) then
			STranq_Frenzy.Frenzies = STranq_Frenzy.Frenzies + 1;
		end

		if ( not STranq_Frenzy.Frenzies or STranq_Frenzy.Frenzies > 0 ) then
			Stranq_FrenzyTimerIcon:Hide();
		else
			Stranq_FrenzyTimerIcon:Show();
		end
	end
end

function STranq_ScanDebuffs(raidid)
	local name = UnitName(raidid);
	local hunter = STranq_Hunters[name];
	if ( hunter ) then
		local i, debuffs, texture = 1, {};
		repeat
			texture = UnitDebuff(raidid,i);
			if ( STranq_Debuffs[texture] ) then
				local debufftime, debuffname, pattern = unpack(STranq_Debuffs[texture]);
				STranqHiddenToolTip:SetUnitDebuff(raidid,i);
				if ( STranqHiddenToolTipTextLeft1:GetText() == debuffname and ( not pattern or string.find(STranqHiddenToolTipTextLeft2:GetText() or "", pattern) ) ) then
					debuffs[texture] = 1;
				end
			end
			i = i + 1;
		until not texture;

		local curtime = GetTime();

		for k, v in STranq_Debuffs do
			local debufftime, debuffname, pattern = unpack(v);
			if ( debuffs[k] and not hunter[debuffname] ) then
				hunter[debuffname] = curtime;
				if ( not hunter.StartTime or hunter.MaxValue - curtime + hunter.StartTime < debufftime ) then
					hunter.Debuff = debuffname;
					hunter.DebuffTexture = k;
					hunter.MaxValue = debufftime;
					hunter.WarnText = debuffname;
					hunter.Warn = curtime+debufftime;
					hunter.StartTime = curtime;
				end
			elseif ( not debuffs[k] and hunter[debuffname] ) then
				if ( hunter.WarnText == debuffname ) then
					hunter.Warn = nil;
				end
				if ( hunter[debuffname] == hunter.StartTime ) then
					hunter.StartTime = nil;
				end
				hunter[debuffname] = nil;
			end
		end

		i, texture, hunter.FD = 1;
		repeat
			texture = UnitBuff( raidid, i );
			if ( texture == "Interface\\Icons\\Ability_Rogue_FeignDeath" ) then
				hunter.FD = 1;
				return;
			end
			i = i + 1;
		until not texture;
	end
end

function STranq_CheckHealth( raidid )
	local id = tonumber(string.sub( raidid, 5));
	if ( not id ) then return; end
	local name, rank, subgroup, level, class, fileName, zone, online, dead = GetRaidRosterInfo(id);
	local hunter = STranq_Hunters[name];
	if ( hunter ) then
		hunter.Offline = nil;
		hunter.Dead = nil;
		if ( not online ) then
			hunter.Offline = 1;
		elseif ( dead or UnitIsGhost(raidid) ) then
			hunter.Dead = 1;
		end
	end
end

function STranq_CheckMana( raidid )
	local hunter = STranq_Hunters[UnitName(raidid)];
	if ( hunter ) then
		if ( UnitMana(raidid) < STranq_TranqMana and UnitHealth(raidid) ~= 0 ) then
			hunter.Oom = 1;
		else
			hunter.Oom = nil;
		end
	end
end

-- \188 = ¼
-- \189 = ½
-- \190 = ¾
-- \166 = ¦
-- \176 = °

function STranq_SendRotation()
	local order = STranq_Saved["Order"];
	local total = getn(order);

	if ( not order or total == 0 ) then return; end

	local groups = STranq_Saved["NumGroups"] or 2;
	local per = STranq_Saved["PerGroup"] or 2;
	local num = min((STranq_Saved["MaxShown"] or 5),total);
	local rem = 0;

	local syncper, syncnum, syncgroups = strrep("\188",per), strrep("\189",num), strrep("\190",groups);

	local synctext = syncper..syncnum..syncgroups;
	for i, v in ipairs(order) do
		synctext = synctext.."\166"..v.."\176";
	end

	STranq_DataMessage("rot", synctext);

	if ( not STranq_Saved["HideRot"] ) then
		local text = STRANQ_STRINGS.BROADCASTROTHEADER.." ";
		if ( per < 2 ) then
			groups = 1;
			per = num;
		elseif ( num > groups*per ) then
			rem = num - groups*per;
		else
			groups = ceil(num/per);
		end

		for i=1, groups do
			local gtext;
			for j=1, per do
				if ( i*per - per + j > num ) then
					break;
				end
				if ( gtext ) then
					gtext = gtext .. ", ".. order[i*per - per + j];
				else
					gtext = order[i*per - per + j];
				end
			end
			if ( groups > 1 ) then
				text = text .. format(STRANQ_STRINGS.GROUP, i, gtext);
			else
				text = text .. gtext.."  ";
			end
		end

		if ( rem > 0 ) then
			local gtext;
			for i=num-rem+1, num do
				if ( gtext ) then
					gtext = gtext .. ", ".. order[i];
				else
					gtext = order[i];
				end
			end
			text = text .. format(STRANQ_STRINGS.BACKUP, gtext);
		end

		local chanindex;
		if ( STranq_Saved.CastType == 2 and STranq_Saved.CastChan ) then
			chanindex = GetChannelName(STranq_Saved.CastChan);
		end
		if ( chanindex and chanindex ~= 0 ) then
			SendChatMessage(text, "CHANNEL", nil, chanindex);
		else
			SendChatMessage(text, "RAID");
		end
	end

	for k, v in pairs(STranq_Hunters) do
		if ( v.VerText ) then
			v.Ver = GetTime();
		end
	end
end

function STranq_SetupRotation(msg)
	local _,_,perGroup,maxShown,numGroups = string.find( msg, "(\188+)" );
	_,_,maxShown = string.find(msg, "(\189+)" );
	_,_,numGroups = string.find(msg, "(\190+)" );
	if ( perGroup ) then
		STranq_Saved["PerGroup"] = strlen(perGroup);
	end
	if ( maxShown ) then
		STranq_Saved["MaxShown"] = strlen(maxShown);
	end
	if ( numGroups ) then
		STranq_Saved["NumGroups"] = max(strlen(numGroups),1);
	end

	local hunters;
	local raid = {};

	for i=1, GetNumRaidMembers() do
		local _,class = UnitClass("raid"..i);
		if ( class == "HUNTER" ) then
			raid[UnitName("raid"..i)] = i;
		end
	end

	for name in string.gfind(msg, "\166(%a+)\176") do
		if ( raid[name] ) then
			if ( not hunters ) then
				hunters = {};
			end
			tinsert( hunters, name );
		end
	end

	for k in pairs(raid) do
		raid[k] = nil;
	end

	if ( not STranq_Saved["Debug"] ) then
		STranq_Saved["LockRot"] = 1;
	end

	if ( hunters ) then
		local order = STranq_Saved["Order"];
		if ( order ) then
			for k in pairs(order) do
				order[k] = nil;
			end
		end

		STranq_Saved["Order"] = hunters;
	end

	STranq_StatusBar_Setup();
	STranq_StatusBar_Display()
end

function STranq_VersionCompare( version, sender )
	if ( not seenUpdate and version and STranqVersion ~= version ) then
		local _,_,localver,localrem = string.find(STranqVersion, "^([%d%.]+)(.*)$");
		local _,_,otherver,otherrem = string.find(version, "^([%d%.]+)(.*)$");
		localver, otherver = tonumber(localver), tonumber(otherver)
		if ( (not otherver or not localver) or localver > otherver ) then
			return;
		elseif ( otherver == localver ) then
			_,_,localver = string.find(localrem, "[%a ]*([%d%.]+)");
			_,_,otherver = string.find(otherrem, "[%a ]*([%d%.]+)");
			localver, otherver = tonumber(localver), tonumber(otherver)
			if ( ( localver == otherver ) or ( localver and ( not otherver or localver > otherver ) ) ) then
				return;
			end
		end
		STranq_Print( string.format( STRANQ_STRINGS.VERSIONCOMPARE, sender, version ) );
		seenUpdate = 1;
	end
end

function STranq_Parse(prefix,msg,sender)
	local Debug = STranq_Saved["Debug"];
	if ( Debug ) then
		local chatframe = getglobal("ChatFrame"..Debug);
		if ( chatframe and strfind( prefix, "^"..STranq_DataHeader ) ) then
			chatframe:AddMessage(prefix.." : "..msg.." : "..sender);
		end
	end
	if ( not Debug and sender == UnitName("player") ) then return; end

	if ( not prefix ) then
		return;
	end

	if ( prefix == STranq_DataHeader.."H" ) then
		STranq_StatusBar_Event(sender,nil,nil,tonumber(msg));
	elseif ( prefix == STranq_DataHeader.."M" ) then
		STranq_StatusBar_Event(sender,nil,1,tonumber(msg));
	elseif ( prefix == STranq_DataHeader.."F" ) then
		STranq_StatusBar_Event(sender,nil,2);
	elseif ( prefix == STranq_DataHeader.."Z" ) then
		STranq_StatusBar_SetFrenzy(msg);
	elseif ( prefix == STranq_DataHeader.."vercheck" ) then
		if ( msg and msg ~= "" ) then
			STranq_VersionCompare( msg, sender );
			local hunter = STranq_Hunters[sender];
			if ( hunter ) then
				hunter.VerText = msg;
			end
		end
		STranq_DataMessage( "ver", sender.." "..STranqVersion );
	elseif ( prefix == STranq_DataHeader.."ver" ) then
		local _,_,name,version = string.find(msg,"(%a+) (.+)");
		local hunter = STranq_Hunters[sender];
		if ( hunter and version ) then
			hunter.VerText = version;
		end
		STranq_VersionCompare( version, sender );
	elseif ( prefix == STranq_DataHeader.."rot" ) then
		local officer, hunter;
		for i=1, GetNumRaidMembers() do
			local name, rank, _, _, _, class = GetRaidRosterInfo(i);
			if ( name == sender ) then
				if ( rank > 0 ) then
					officer = rank;
				end
				if ( class == "HUNTER" ) then
					hunter = 1;
				end
				break;
			end
		end
		if ( not officer and not hunter ) then
			local dialog = StaticPopup_Show( STRANQ_NEWROTATION, sender );
			if ( dialog ) then
				dialog.data = msg;
			end
			return;
		end
		if ( not hunter or ( STranq_Saved["OfficersOnly"] and not officer ) ) then
			STranq_DataMessage( "I", sender );
			return;
		end
		STranq_DataMessage( "A", sender );
		STranq_SetupRotation(msg);
		STranq_Print(string.format(STRANQ_STRINGS.ROTBROADCASTEDBY,sender));
	elseif ( prefix == STranq_DataHeader.."A" and msg == UnitName("player") ) then
		local hunter = STranq_Hunters[sender];
		if ( hunter ) then
			hunter.AcceptRot = 1;
			hunter.Ver = GetTime();
		end
	elseif ( prefix == STranq_DataHeader.."I" and msg == UnitName("player") ) then
		local hunter = STranq_Hunters[sender];
		if ( hunter ) then
			hunter.AcceptRot = 0;
			hunter.Ver = GetTime();
		end
	end
end

function STranq_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
end

--== Event Handler ==--
function STranq_OnEvent()
	if ( event == "CHAT_MSG_SPELL_SELF_DAMAGE" ) then
		if ( string.find( string.lower(arg1), string.lower(STranq_string_Tranq) ) ) then
			local name, text = UnitName("player");
			local mob = UnitName("target");
			local _,_,latency = GetNetStats();
			if ( string.find( arg1, STranq_string_SpellSelf ) ) then
				text = STranq_Name( STranq_Saved.CastMsg, name, mob );
				STranq_StatusBar_Event( name, mob );
				STranq_DataMessage( "H", latency );
			else
				text = STranq_Name( STranq_Saved.MissMsg, UnitName("player"), mob );
				UIErrorsFrame:AddMessage( STranq_Name( STranq_Saved.MissErr, UnitName("player"), UnitName("target")), STranq_Saved.MissColor.r, STranq_Saved.MissColor.g, STranq_Saved.MissColor.b , 1.0, UIERRORS_HOLD_TIME);
				if ( not STranq_Saved["NoSound"] ) then
					PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
				end
				STranq_StatusBar_Event( name, mob, 1 );
				STranq_DataMessage( "M", latency );
			end

			STranq_SendMessage( text );
		end
	elseif ( event == "CHAT_MSG_SPELL_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" ) then
		if ( GetNumRaidMembers() == 0 ) then
			return; end

		local _,_,name,mob = string.find( arg1, STranq_string_SpellOther );
		if ( name and STranq_Hunters[name] ) then
			STranq_StatusBar_Event( name, mob );
		else
			_,_,name,mob = string.find( arg1, STranq_string_SpellOtherMiss );
			if ( name and STranq_Hunters[name] ) then
				STranq_StatusBar_Event( name, mob, 1 );
			end
		end
	elseif ( event == "CHAT_MSG_SPELL_SELF_BUFF" ) then
		local _,_,mob = string.find( arg1, STranq_string_FailSelf );
		if ( mob ) then
			local name = UnitName("player");
			UIErrorsFrame:AddMessage( STranq_Name(STranq_Saved.FailErr,name,mob), STranq_Saved.MissColor.r, STranq_Saved.MissColor.g, STranq_Saved.MissColor.b , 1.0, UIERRORS_HOLD_TIME);
			if ( not STranq_Saved["NoSound"] ) then
				PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
			end
			local text = STranq_Name( STranq_Saved.FailMsg,name, mob );
			STranq_StatusBar_Event( name, mob, 2 );
			STranq_DataMessage("F");
			STranq_SendMessage( text );
		end
	elseif ( event == "CHAT_MSG_SPELL_PARTY_BUFF" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" ) then
		if ( GetNumRaidMembers() == 0 ) then
			return; end

		local _,_,name, mob = string.find( arg1, STranq_string_FailOther );
		if ( name and STranq_Hunters[name] ) then
			STranq_StatusBar_Event( name, mob, 2 );
		end
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( string.find( arg1, STranq_string_FrenzyEmote ) ) then
			if ( STranq_Mobs[arg2] and STranq_Mobs[arg2].frenzy ) then
				STranq_StatusBar_SetFrenzy(arg2);
			end
		end
	elseif ( event == "CHAT_MSG_SPELL_BREAK_AURA" ) then
		local _,_,mob = string.find( arg1, STranq_string_Removed );
		if ( mob ) then
			STranq_MobCheck( mob );
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		local _,_,mob = string.find( arg1, STranq_string_GainFrenzy );
		if ( mob ) then
			STranq_StatusBar_SetFrenzy( mob );
			STranq_DataMessage("Z", mob);
			STranq_MobCheck( mob );
		end
	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		STranq_StatusBar_Setup();
		STranq_RegisterRaidEvents();
	elseif ( event == "UNIT_AURA" ) then
		STranq_ScanDebuffs(arg1);
	elseif ( event == "PLAYER_AURAS_CHANGED" ) then
		STranq_ScanDebuffs("player");
	elseif ( event == "UNIT_HEALTH" ) then
		STranq_CheckHealth(arg1);
	elseif ( event == "UNIT_MANA" ) then
		STranq_CheckMana(arg1);
	elseif ( event == "CHAT_MSG_ADDON" and arg3 == "RAID") then
		STranq_Parse(arg1,arg2,arg4);
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		SlashCmdList["SIMPLETRANQ"] = STranq_Console;
		SLASH_SIMPLETRANQ1 = STRANQ_SLASH1;
		SLASH_SIMPLETRANQ2 = STRANQ_SLASH2;

		local _,class = UnitClass("player");
		if ( class == "HUNTER" or STranq_Saved["ShowNonHunters"] ) then
			STranq_Load();
		end

		if ( STranq_Saved["Debug"] ) then
			STranq_TestDebuff = {};
			for k, v in pairs(STranq_Debuffs) do
				tinsert( STranq_TestDebuff, k );
			end
		end
	end
end

function STranq_VerCheck(show)
	STranq_DataMessage("vercheck",STranqVersion);
	local hunter = STranq_Hunters[UnitName("player")];
	if ( hunter ) then
		hunter.VerText = STranqVersion;
	end
	if ( show ) then
		for k, v in STranq_Hunters do
			v.Ver = GetTime();
		end
	end
end

function STranq_Print(text)
	if ( text ) then
		DEFAULT_CHAT_FRAME:AddMessage( "|cffffffff"..STRANQ_TITLE.." |cff999999: "..text );
	end
end

function STranq_DataMessage(datatype, msg)
	SendAddonMessage( STranq_DataHeader .. (datatype or ""), (msg or ""), "RAID" );
end

function STranq_SendMessage(text)
	if ( STranq_Saved["RS"] or STranq_Saved.CastType == 8 ) then
		if ( CT_RA_Channel and CT_RA_Level > 0 ) then
			CT_RA_AddMessage("MS " .. text);
		elseif ( STranq_Saved["RS"] and not STranq_Saved.CastType == 8 ) then
			if ( CastType ~= 3 ) then
				SendChatMessage( text, "RAID" );
			end
		else
			if ( CastType ~= 1 ) then
				SendChatMessage( text, "YELL" );
			end
		end
	end

	if ( STranq_Saved.CastType == 2 or STranq_Saved.CastType == 7 ) then
		local ChanIndex;
		if ( STranq_Saved["CastChan"] ) then
			if ( STranq_Saved.CastType == 7 ) then
				ChanIndex = STranq_Saved["CastChan"];
			else
				ChanIndex = GetChannelName(STranq_Saved["CastChan"]);
				if ( ChanIndex == 0 ) then
					ChanIndex = nil;
				end
			end
		end
		if ( ChanIndex ) then
			SendChatMessage( text, STranq_Types[STranq_Saved.CastType], nil, ChanIndex );
		else
			if ( STranq_Saved["CastChan"] ) then
				STranq_Print( string.format( STRANQ_BROADCAST_ERROR_CHANNEL, STranq_Saved["CastChan"] ) );
			else
				STranq_Print( STRANQ_BROADCAST_ERROR_NOCHANNEL );
			end
			SendChatMessage( text, "YELL" );
		end
	elseif ( STranq_Saved.CastType < 8 ) then
		SendChatMessage( text, STranq_Types[STranq_Saved.CastType] );
	end
end

--== Load ==--
function STranq_Load()
	loaded = 1;
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	STranq_RegisterRaidEvents();

	tinsert(UISpecialFrames,"STranq_Options");

	DEFAULT_CHAT_FRAME:AddMessage( STranqTitle..STRANQ_LOADED );

	STranq_Options_CastType_DropDown.tooltip = STRANQ_CASTTYPE_TIP;
	STranq_Options_CastChan_DropDown.tooltip = STRANQ_CASTCHAN_TIP;
	STranq_Options_Color.tooltip = STRANQ_MISSCOLOR_TIP;
	STranq_Options_RaidColor.tooltip = STRANQ_RAIDCOLOR_TIP;
	STranq_Options_RaidMisses.tooltip = STRANQ_RAIDMISS_TIP;
	STranq_Options_Sounds.tooltip = STRANQ_SOUND_TIP;
	STranq_Options_RS.tooltip = STRANQ_RS_TIP;
	STranq_Options_HideBars.tooltip = STRANQ_HIDEBARS_TIP;
	STranq_Options_AutoHideBars.tooltip = STRANQ_AUTOHIDEBARS_TIP;
	STranq_Options_LockBars.tooltip = STRANQ_LOCKBARS_TIP;
	STranq_Options_BarsGrowUp.tooltip = STRANQ_BARSGROWUP_TIP;
	STranq_Options_LockRot.tooltip = STRANQ_LOCKROT_TIP;
	STranq_Options_HideExtra.tooltip = STRANQ_HIDEEXTRA_TIP;
	STranq_Options_ShowNonHunters.tooltip = STRANQ_SHOWOTHERCLASSES_TIP;
	STranq_Options_HideRot.tooltip = STRANQ_HIDEROT_TIP;
	STranq_Options_OfficersOnly.tooltip = STRANQ_OFFICERSONLY_TIP

	STranq_Setup();
	STranq_StatusBar_Setup();
end

--== Register Events in Raid ==--
local RaidEvents = {
	"CHAT_MSG_MONSTER_EMOTE",

	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_SPELL_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",

	"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_PARTY_BUFF",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",

	"CHAT_MSG_SPELL_BREAK_AURA",
	"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",

	"PLAYER_AURAS_CHANGED",
	"UNIT_AURA",
	"UNIT_HEALTH",
	"UNIT_MANA",

	"CHAT_MSG_ADDON",
	};
function STranq_RegisterRaidEvents()
	if ( GetNumRaidMembers() > 0 ) then
		if ( not this.RegisteredEvents ) then
			for i, v in ipairs(RaidEvents) do
				this:RegisterEvent(v);
			end
			this.RegisteredEvents = 1;
			STranq_VerCheck();
		end
	elseif ( this.RegisteredEvents ) then
		this.RegisteredEvents = nil;
		for i, v in ipairs(RaidEvents) do
			this:UnregisterEvent(v);
		end
	end
end

--== Console command handler ==--
function STranq_Console(msg)
	local _,_,param = string.find(msg, "^(%a+).+");
	local _,class = UnitClass("player");
	local lower = string.lower(msg);
	if ( not loaded and class ~= "HUNTER" and not STranq_Saved["ShowNonHunters"] ) then
		if ( string.lower(msg) == STRANQ_COMMAND_ENABLEALL ) then
			STranq_Saved["ShowNonHunters"] = 1;
			STranq_Load();
		else
			STranq_Print( STRANQ_CONSOLE_NOTHUNTER );
		end
		return;
	end
	if lower == STRANQ_COMMAND_RESET then
		STranq_Options:ClearAllPoints();
		STranq_Options:SetPoint("CENTER",UIParent,"CENTER");
		STranq_Print( STRANQ_CONSOLE_RESETTING );
		STranq_Saved = { };
		STranq_Setup();
	elseif lower == STRANQ_COMMAND_VER then
		STranq_VerCheck(1);
	elseif lower == STRANQ_COMMAND_ROT then
		STranq_SendRotation();
	elseif lower == STRANQ_COMMAND_DISABLEALL then
		STranq_Saved["ShowNonHunters"] = 1;
		STranq_Print( STRANQ_CONSOLE_DISABLEALL );
	elseif param and string.lower(param) == "debug" then
		local _,_,num = string.find(string.lower(msg), "debug (%d+)");
		STranq_Saved["Debug"] = tonumber(num or "");
	elseif ( lower == STRANQ_COMMAND_SHOWBARS ) then
		STranq_StatusBars_Toggle(1);
	elseif ( lower == STRANQ_COMMAND_HIDEBARS ) then
		STranq_StatusBars_Toggle(0);
	elseif ( lower == STRANQ_COMMAND_BARS ) then
		STranq_StatusBars_Toggle();
	elseif ( lower == "" ) then
		ShowUIPanel(STranq_Options);
	else
		STranq_Console_Help();
	end
end
function STranq_Console_Help()
	for i, text in ipairs(STRANQ_CONSOLE_HELP) do
		if i == 1 then
			STranq_Print(text);
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff999999"..text);
		end
	end
end

--== Setup ==--
function STranq_Setup()
	if ( not STranq_Saved ) then
		STranq_Saved = {};
	elseif ( STranq_Saved["CastType"] ) then
		if ( not tonumber(STranq_Saved["CastType"]) ) then
			DEFAULT_CHAT_FRAME:AddMessage("upgrading variables"); -- upgrade from 1.4
			for i=1, 6 do
				if ( STranq_Types[i] == STranq_Saved["CastType"] ) then
					STranq_Saved["CastType"] = nil;
					STranq_Saved["CastType"] = i;
					break;
				end
			end
		end
	end
	for k, v in pairs(STranq_Default) do
		if ( not STranq_Saved[k] ) then
			STranq_Saved[k] = CopyTable(v);
		elseif ( type(STranq_Saved[k]) == "table" and type(v) == "table" ) then
			for j, z in pairs(v) do
				if ( not STranq_Saved[k][j] ) then
					STranq_Saved[k][j] = CopyTable(z);
				end
			end
		end
	end
	if ( not STranq_Saved["Mobs"] ) then
		STranq_Saved["Mobs"] = CopyTable(STranq_Mobs);
	else
		for k, v in pairs(STranq_Mobs) do
			if ( not STranq_Saved["Mobs"][k] ) then
				STranq_Saved["Mobs"][k] = CopyTable(v);
			end
		end
	end
end

--== Add to Valid Target list ==--
function STranq_MobCheck( mob )
	-- double check against already added list to prevent log spam
	if ( STranq_Saved["Mobs"] ) then
		for k, v in STranq_Saved["Mobs"] do
			if ( mob == k ) then
				return;
			end
		end
	end
	STranq_Print( string.format( STRANQ_STRINGS.NEW_FRENZY_MOB, mob ) );
	if ( not STranq_Saved["Mobs"] ) then STranq_Saved["Mobs"] = {}; end
	STranq_Saved["Mobs"][mob] = {};
end

--== Name Sub ==--
function STranq_Name(text, name, mob)
	if ( not text ) then
		return;
	end
	if ( not mob ) then
		mob = UKNOWNBEING;
	end
	if ( not name ) then
		name = PLAYER;
	end
	mob = tostring(mob);
	text = string.gsub( text, STRANQ_STRINGS.SUB_NORMALCASE_TARGET, mob );
	text = string.gsub( text, STRANQ_STRINGS.SUB_UPPERCASE_TARGET, string.upper(mob) );
	name = tostring(name);
	text = string.gsub( text, STRANQ_STRINGS.SUB_NORMALCASE_PLAYER, name );
	text = string.gsub( text, STRANQ_STRINGS.SUB_UPPERCASE_PLAYER, string.upper(name) );
	return text;
end

--== Miss Color ==--
function STranq_MissColor()
		ColorPickerFrame.func = STranq_MissColorFunc;
		ColorPickerFrame.hasOpacity = nil;
		ColorPickerFrame.opacityFunc = nil;
		ColorPickerFrame.opacity = nil;
		ColorPickerFrame:SetColorRGB( STranq_Options.MissColor.r, STranq_Options.MissColor.g, STranq_Options.MissColor.b );
		ColorPickerFrame.previousValues = { r = STranq_Options.MissColor.r, g = STranq_Options.MissColor.g, b = STranq_Options.MissColor.b };
		ColorPickerFrame.cancelFunc = STranq_MissColorCancelFunc;
		ShowUIPanel(ColorPickerFrame);
end
function STranq_MissColorFunc()
	local newR, newG, newB = ColorPickerFrame:GetColorRGB();
	STranq_Options_ColorNormalTexture:SetVertexColor(newR, newG, newB);
	STranq_Options.MissColor = { r = newR, g = newG, b = newB };
end
function STranq_MissColorCancelFunc(previousValues)
	if ( previousValues.r ) then
		STranq_Options_ColorNormalTexture:SetVertexColor(previousValues.r, previousValues.g, previousValues.b);
		STranq_Options.MissColor = { r = previousValues.r, g = previousValues.g, b = previousValues.b };
	end
end

--== Raid Miss Color ==--
function STranq_RaidColor()
		ColorPickerFrame.func = STranq_RaidColorFunc;
		ColorPickerFrame.hasOpacity = nil;
		ColorPickerFrame.opacityFunc = nil;
		ColorPickerFrame.opacity = nil;
		ColorPickerFrame:SetColorRGB( STranq_Options.RaidMissColor.r, STranq_Options.RaidMissColor.g, STranq_Options.RaidMissColor.b );
		ColorPickerFrame.previousValues = { r = STranq_Options.RaidMissColor.r, g = STranq_Options.RaidMissColor.g, b = STranq_Options.RaidMissColor.b };
		ColorPickerFrame.cancelFunc = STranq_RaidColorCancelFunc;
		ShowUIPanel(ColorPickerFrame);
end
function STranq_RaidColorFunc()
	local newR, newG, newB = ColorPickerFrame:GetColorRGB();
	STranq_Options_RaidColorNormalTexture:SetVertexColor(newR, newG, newB);
	STranq_Options.RaidMissColor = { r = newR, g = newG, b = newB };
end
function STranq_RaidColorCancelFunc(previousValues)
	if ( previousValues.r ) then
		STranq_Options_RaidColorNormalTexture:SetVertexColor(previousValues.r, previousValues.g, previousValues.b);
		STranq_Options.RaidMissColor = { r = previousValues.r, g = previousValues.g, b = previousValues.b };
	end
end

--== Cast Msg Test ==--
function STranq_Options_Test_Msg(text)
	local savedid, savedchan, savedrs = STranq_Saved["CastType"], STranq_Saved["CastChan"], STranq_Saved["RS"];

	local id = UIDropDownMenu_GetSelectedID(STranq_Options_CastType_DropDown);
	if ( id == 2 or id == 7 ) then
		local newChan = STranq_Options_CastChan_DropDownText:GetText();
		if ( newChan and not ( newChan == STRANQ_NOCHANNEL_TEXT or newChan == STRANQ_NOPLAYER_TEXT ) ) then
			STranq_Saved["CastChan"] = newChan;
			STranq_Saved["CastType"] = id;
		else
			StaticPopup_Show("STRANQ_NOVALID_MSG");
			return;
		end
	else
		STranq_Saved["CastChan"] = nil;
		STranq_Saved["CastType"] = id;
	end
	STranq_Saved["RS"] = STranq_Options_RS:GetChecked();

	STranq_SendMessage( STranq_Name( text, UnitName("player") ) );

	STranq_Saved["CastType"] = savedid;
	STranq_Saved["CastChan"] = savedchan;
	STranq_Saved["RS"] = savedrs;
end

--== Self Error Test ==--
function STranq_Options_Test_SelfErr(text)
	UIErrorsFrame:AddMessage( STranq_Name( text, UnitName("player") ), STranq_Options.MissColor.r, STranq_Options.MissColor.g, STranq_Options.MissColor.b , 1.0, UIERRORS_HOLD_TIME);
	if ( STranq_Options_Sounds:GetChecked() ) then
		PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
	end
end

--== Raid Error Test ==--
function STranq_Options_Test_RaidErr(text)
	UIErrorsFrame:AddMessage( STranq_Name( text, UnitName("player") ), STranq_Options.RaidMissColor.r, STranq_Options.RaidMissColor.g, STranq_Options.RaidMissColor.b , 1.0, UIERRORS_HOLD_TIME);
	if ( STranq_Options_Sounds:GetChecked() ) then
		PlaySound("RaidWarning")
	end
end

--== Cast Types Dropdown ==--
function STranq_Options_CastType_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, STranq_Options_CastType_DropDown_Initialize);
	UIDropDownMenu_SetWidth(155);
	UIDropDownMenu_SetSelectedID(STranq_Options_CastType_DropDown, 1);
end
function STranq_Options_CastType_DropDown_Initialize()
	for k, v in STranq_Types do
		if ( k == 8 and not IsAddOnLoaded("CT_RaidAssist") ) then
			break;
		end
		local info = {};
		info.text = STranq_Types[k];
		info.func = STranq_Options_CastType_DropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end
function STranq_Options_CastType_DropDown_OnClick()
	StaticPopup_Hide("STRANQ_NOVALID_MSG");
	StaticPopup_Hide("STRANQ_NOVALID_SAVE");
	UIDropDownMenu_SetSelectedID(STranq_Options_CastType_DropDown, this:GetID());
	if ( this:GetID() == 2 or this:GetID() == 7 ) then
		UIDropDownMenu_Initialize(STranq_Options_CastChan_DropDown, STranq_Options_CastChan_DropDown_Initialize);
		if ( STranq_Saved["CastChan"] and GetChannelName(STranq_Saved["CastChan"]) > 0 ) then
			UIDropDownMenu_SetSelectedName(STranq_Options_CastChan_DropDown, STranq_Saved["CastChan"]);
		else
			UIDropDownMenu_SetSelectedID(STranq_Options_CastChan_DropDown, 1);
			if ( getn(STranq_ChanList) > 0 ) then
				STranq_Options_CastChan_DropDownText:SetTextColor(1, 1, 1);
			else
				if ( this:GetID() == 2 ) then
					STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOCHANNEL_TEXT);
				else
					STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOPLAYER_TEXT);
				end
				STranq_Options_CastChan_DropDownText:SetTextColor(0.3, 0.3, 0.3);
			end
		end
		STranq_Options_CastChan_Text:SetTextColor(1, 1, 1);
		STranq_Options_CastChan_DropDownButton:Enable();
	else
		STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOCHANNEL_TEXT);
		STranq_Options_CastChan_Text:SetText(STRANQ_CASTCHAN_TEXT);
		STranq_Options_CastChan_Text:SetTextColor(0.3, 0.3, 0.3);
		STranq_Options_CastChan_DropDownButton:Disable();
		STranq_Options_CastChan_DropDownText:SetTextColor(0.3, 0.3, 0.3);
	end
	if ( this:GetID() == 8 or not IsAddOnLoaded("CT_RaidAssist") ) then
		STranq_Options_RS:Disable()
		STranq_Options_RS_Text:SetTextColor(0.3, 0.3, 0.3);
	else
		STranq_Options_RS:Enable()
		STranq_Options_RS_Text:SetTextColor(1, 0.82, 0.0);
	end
end

--== Cast Channel Drowndown ==--
function STranq_Options_CastChan_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, STranq_Options_CastChan_DropDown_Initialize);
	UIDropDownMenu_SetWidth(155);
	if ( STranq_Saved["CastChan"] and GetChannelName(STranq_Saved["CastChan"]) ) then
		UIDropDownMenu_SetSelectedID(STranq_Options_CastChan_DropDown, GetChannelName(STranq_Saved["CastChan"]));
	else
		UIDropDownMenu_SetSelectedID(STranq_Options_CastChan_DropDown, 1);
	end
end
function STranq_Options_CastChan_DropDown_Initialize()
	 STranq_ChannelCheck();

	if ( getn(STranq_ChanList) > 0 ) then
		for k, v in STranq_ChanList do
			local info = {};
			info.text = STranq_ChanList[k];
			info.func = STranq_Options_CastChan_DropDown_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	else
		local id = UIDropDownMenu_GetSelectedID(STranq_Options_CastType_DropDown);
		if ( id == 2 ) then
			STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOCHANNEL_TEXT);
		else
			STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOPLAYER_TEXT);
		end
		STranq_Options_CastChan_DropDownText:SetTextColor(0.3, 0.3, 0.3);
	end
end
function STranq_ChannelCheck()
	while STranq_ChanList[1] do
		tremove( STranq_ChanList, 1 );
	end
	if ( UIDropDownMenu_GetSelectedID(STranq_Options_CastType_DropDown) == 2 ) then
		local channelList = {GetChannelList()};
		local serverChanList = {EnumerateServerChannels()};
		if ( channelList and serverChanList ) then
			local i = 2;
			while channelList[i] do
				local cullMe;
				local chan = channelList[i];
				for k, v in ipairs(serverChanList) do
					if ( chan == v ) then
						cullMe = true;
					end
				end
				if ( CT_RA_Channel and chan == CT_RA_Channel ) then
					cullMe = true;
				end
				if ( DamageMeters_syncChannel and chan == DamageMeters_syncChannel ) then
					cullMe = true;
				end
				if ( Sky ) then
					if ( SkyChannelManager.isSkyChannel( chan ) ) then
						cullMe = true;
					end
				end
				if ( not cullMe ) then
					tinsert(STranq_ChanList, chan);
				end
				i = i+2;
			end
		end
	else
		for i=1, GetNumRaidMembers() do
			local _,class = UnitClass("raid"..i );
			if ( class == "HUNTER" and not UnitIsUnit("raid"..i, "player") ) then
				tinsert(STranq_ChanList, (UnitName("raid"..i)));
			end
		end
	end
end
function STranq_Options_CastChan_DropDown_OnClick()
	STranq_Options_CastChan_DropDownText:SetTextColor(1, 1, 1);
	UIDropDownMenu_SetSelectedID(STranq_Options_CastChan_DropDown, this:GetID());
end

--== Options Menu Open ==--
function STranq_Options_Open()
	StaticPopup_Hide("STRANQ_NEEDSAVE");
	STranq_Options_CastMsg:SetText(STranq_Saved.CastMsg);
	STranq_Options_MissMsg:SetText(STranq_Saved.MissMsg);
	STranq_Options_MissErr:SetText(STranq_Saved.MissErr);
	STranq_Options_RaidErr:SetText(STranq_Saved.RaidErr);
	STranq_Options_FailMsg:SetText(STranq_Saved.FailMsg);
	STranq_Options_FailErr:SetText(STranq_Saved.FailErr);
	STranq_Options_RaidFailErr:SetText(STranq_Saved.RaidFailErr);
	STranq_Options_ColorNormalTexture:SetVertexColor(STranq_Saved.MissColor.r, STranq_Saved.MissColor.g, STranq_Saved.MissColor.b);
	STranq_Options.MissColor = STranq_Saved.MissColor;
	STranq_Options_RaidColorNormalTexture:SetVertexColor(STranq_Saved.RaidMissColor.r, STranq_Saved.RaidMissColor.g, STranq_Saved.RaidMissColor.b);
	STranq_Options.RaidMissColor = STranq_Saved.RaidMissColor;
	STranq_Options_RaidMisses:SetChecked( not STranq_Saved["RaidMisses"] );
	STranq_Options_Sounds:SetChecked( not STranq_Saved["NoSound"] );
	STranq_Options_RS:SetChecked( STranq_Saved["RS"] );
	STranq_Options_HideRot:SetChecked( not STranq_Saved["HideRot"] );
	STranq_Options_HideBars:SetChecked( STranq_Saved["HideBars"] );
	STranq_Options_AutoHideBars:SetChecked( STranq_Saved["AutoHideBars"] );
	STranq_Options_LockBars:SetChecked( STranq_Saved["LockBars"] );
	STranq_Options_LockRot:SetChecked( STranq_Saved["LockRot"] );
	STranq_Options_HideExtra:SetChecked( STranq_Saved["HideExtra"] );
	STranq_Options_ShowNonHunters:SetChecked( STranq_Saved["ShowNonHunters"] );
	STranq_Options_OfficersOnly:SetChecked( STranq_Saved["OfficersOnly"] );
	STranq_Options_BarsGrowUp:SetChecked( STranq_Saved["BarsGrowUp"] );
	STranq_Options_BarAlpha:SetValue( STranq_Saved["BarAlpha"] or 1 );
	STranq_Options_BarScale:SetValue( STranq_Saved["BarScale"] or 1 );
	UIDropDownMenu_SetSelectedID(STranq_Options_CastType_DropDown, STranq_Saved.CastType);
	STranq_Options_CastType_DropDownText:SetText(STranq_Types[STranq_Saved.CastType]);
	if ( STranq_Saved.CastType == 2 or STranq_Saved.CastType == 7 ) then
		UIDropDownMenu_Initialize(STranq_Options_CastChan_DropDown, STranq_Options_CastChan_DropDown_Initialize);
		if ( STranq_Saved["CastChan"] and GetChannelName(STranq_Saved["CastChan"]) > 0 ) then
			UIDropDownMenu_SetSelectedName(STranq_Options_CastChan_DropDown, STranq_Saved["CastChan"]);
		else
			UIDropDownMenu_SetSelectedID(STranq_Options_CastChan_DropDown, 1);
		end
		STranq_Options_CastChan_Text:SetTextColor(1, 1, 1);
		STranq_Options_CastChan_DropDownButton:Enable();
		if ( getn(STranq_ChanList) > 0 ) then
			STranq_Options_CastChan_DropDownText:SetTextColor(1, 1, 1);
		else
			if ( STranq_Saved.CastType == 2 ) then
				STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOCHANNEL_TEXT);
			else
				STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOPLAYER_TEXT);
			end
			STranq_Options_CastChan_DropDownText:SetTextColor(0.3, 0.3, 0.3);
		end
	else
		UIDropDownMenu_SetSelectedID(STranq_Options_CastChan_DropDown, 1);
		STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOCHANNEL_TEXT);
		STranq_Options_CastChan_Text:SetTextColor(0.3, 0.3, 0.3);
		STranq_Options_CastChan_DropDownButton:Disable();
		STranq_Options_CastChan_DropDownText:SetTextColor(0.3, 0.3, 0.3);
	end
	if ( CastType == 8 or not IsAddOnLoaded("CT_RaidAssist") ) then
		STranq_Options_RS:Disable()
		STranq_Options_RS_Text:SetTextColor(0.3, 0.3, 0.3);
	else
		STranq_Options_RS:Enable()
		STranq_Options_RS_Text:SetTextColor(1, 0.82, 0);
	end
	STranq_Options_Update();
end

--== Set Defaults ==--
function STranq_Options_Defaults(all)
	local tab = STranq_Options.selectedTab;
	if ( all or tab == 1 ) then
		STranq_Options_CastMsg:SetText(STranq_Default["CastMsg"]);
		STranq_Options_MissMsg:SetText(STranq_Default["MissMsg"]);
		STranq_Options_FailMsg:SetText(STranq_Default["FailMsg"]);
		UIDropDownMenu_SetSelectedID(STranq_Options_CastType_DropDown, 1);
		UIDropDownMenu_SetSelectedID(STranq_Options_CastChan_DropDown, 1);
		STranq_Options_CastType_DropDownText:SetText("Yell");
		STranq_Options_CastChan_DropDownText:SetText(STRANQ_NOCHANNEL_TEXT);
		STranq_Options_CastChan_Text:SetTextColor(0.3, 0.3, 0.3);
		STranq_Options_CastChan_DropDownButton:Disable();
		STranq_Options_CastChan_DropDownText:SetTextColor(0.3, 0.3, 0.3);
		STranq_Options_RS:SetChecked( nil );
		STranq_Options_HideRot:SetChecked(1);
	end
	if ( all or tab == 2 ) then
		STranq_Options_MissErr:SetText(STranq_Default["MissErr"]);
		STranq_Options_RaidErr:SetText(STranq_Default["RaidErr"]);
		STranq_Options_FailErr:SetText(STranq_Default["FailErr"]);
		STranq_Options_RaidFailErr:SetText(STranq_Default["RaidFailErr"]);
		STranq_Options_ColorNormalTexture:SetVertexColor(STranq_Default["MissColor"].r, STranq_Default["MissColor"].g, STranq_Default["MissColor"].b);
		STranq_Options.MissColor = STranq_Default["MissColor"];
		STranq_Options_RaidColorNormalTexture:SetVertexColor(STranq_Default["RaidMissColor"].r, STranq_Default["RaidMissColor"].g, STranq_Default["RaidMissColor"].b);
		STranq_Options.RaidMissColor = STranq_Default["RaidMissColor"];
		STranq_Options_RaidMisses:SetChecked( 1 );
		STranq_Options_Sounds:SetChecked( 1 );
	end
	if ( all or tab == 3 ) then
		STranq_Options_HideBars:SetChecked( nil );
		STranq_Options_AutoHideBars:SetChecked( nil );
		STranq_Options_LockBars:SetChecked( nil );
		STranq_Options_HideExtra:SetChecked( nil );
		STranq_Options_BarsGrowUp:SetChecked( nil );
		STranq_Options_ShowNonHunters:SetChecked( nil );
		STranq_Options_OfficersOnly:SetChecked( nil );
		STranq_Options_BarAlpha:SetValue(1);
		STranq_Options_BarScale:SetValue(1);
	end

	STranq_Options_SaveCheck();
end

--== Save Options ==--
function STranq_Options_Save()
	local id = UIDropDownMenu_GetSelectedID(STranq_Options_CastType_DropDown);
	if ( id == 2 or id == 7 ) then
		local newChan = STranq_Options_CastChan_DropDownText:GetText();
		if ( newChan and not ( newChan == STRANQ_NOCHANNEL_TEXT or newChan == STRANQ_NOPLAYER_TEXT ) ) then
			STranq_Saved["CastChan"] = STranq_Options_CastChan_DropDownText:GetText();
			STranq_Saved["CastType"] = id;
		else
			StaticPopup_Show("STRANQ_NOVALID_SAVE");
			return;
		end
	else
		STranq_Saved["CastChan"] = nil;
		STranq_Saved["CastType"] = id;
	end
	STranq_Saved["CastMsg"] = STranq_Options_CastMsg:GetText();
	STranq_Saved["MissMsg"] = STranq_Options_MissMsg:GetText();
	STranq_Saved["MissErr"] = STranq_Options_MissErr:GetText();
	STranq_Saved["RaidErr"] = STranq_Options_RaidErr:GetText();
	STranq_Saved["FailMsg"] = STranq_Options_FailMsg:GetText();
	STranq_Saved["FailErr"] = STranq_Options_FailErr:GetText();
	STranq_Saved["RaidFailErr"] = STranq_Options_RaidFailErr:GetText();
	if ( STranq_Options_RaidMisses:GetChecked() ) then
		STranq_Saved["RaidMisses"] = nil;
	else
		STranq_Saved["RaidMisses"] = 1;
	end
	if ( STranq_Options_Sounds:GetChecked() ) then
		STranq_Saved["NoSound"] = nil;
	else
		STranq_Saved["NoSound"] = 1;
	end
	if ( STranq_Options_HideRot :GetChecked() ) then
		STranq_Saved["HideRot"] = nil;
	else
		STranq_Saved["HideRot"] = 1;
	end
	STranq_Saved["RS"] = STranq_Options_RS:GetChecked();
	STranq_Saved["HideBars"] = STranq_Options_HideBars:GetChecked();
	STranq_Saved["AutoHideBars"] = STranq_Options_AutoHideBars:GetChecked();
	STranq_Saved["LockBars"] = STranq_Options_LockBars:GetChecked();
	STranq_Saved["LockRot"] = STranq_Options_LockRot:GetChecked();
	STranq_Saved["BarsGrowUp"] = STranq_Options_BarsGrowUp:GetChecked();
	STranq_Saved["MissColor"] = {};
	STranq_Saved["MissColor"].r = STranq_Options.MissColor.r;
	STranq_Saved["MissColor"].g = STranq_Options.MissColor.g;
	STranq_Saved["MissColor"].b = STranq_Options.MissColor.b;
	STranq_Saved["RaidMissColor"] = {};
	STranq_Saved["RaidMissColor"].r = STranq_Options.RaidMissColor.r;
	STranq_Saved["RaidMissColor"].g = STranq_Options.RaidMissColor.g;
	STranq_Saved["RaidMissColor"].b = STranq_Options.RaidMissColor.b;
	STranq_Saved["BarAlpha"] = STranq_Options_BarAlpha:GetValue();
	STranq_Saved["BarScale"] = STranq_Options_BarScale:GetValue();
	STranq_Saved["HideExtra"] = STranq_Options_HideExtra:GetChecked();
	STranq_Saved["ShowNonHunters"] = STranq_Options_ShowNonHunters:GetChecked();
	STranq_Saved["OfficersOnly"] = STranq_Options_OfficersOnly:GetChecked();
	STranq_StatusBar_Display();
end

function STranq_Options_Update()
	STranq_Setup();

	STranqBroadcast:Hide();
	STranqError:Hide();
	STranqTimers:Hide();
	local tab = STranq_Options.selectedTab;
	if ( tab == 3 ) then
		STranqTimers:Show();
		if ( not STranq_Saved["HideBars"] ) then
			STranq_Timers:Show();
		end
		if ( STranq_Options_HideBars:GetChecked() ) then
			STranq_Options_AutoHideBars:Disable();
			STranq_Options_AutoHideBars_Text:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_LockBars:Disable();
			STranq_Options_LockBars_Text:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_LockRot:Disable();
			STranq_Options_LockRot_Text:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_HideExtra:Disable();
			STranq_Options_HideExtra_Text:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_BarsGrowUp:Disable();
			STranq_Options_BarsGrowUp_Text:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_BarAlpha:EnableMouse(0);
			STranq_Options_BarAlphaText:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_BarAlphaHigh:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_BarAlphaLow:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_BarScale:EnableMouse(0);
			STranq_Options_BarScaleText:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_BarScaleHigh:SetTextColor(0.3, 0.3, 0.3);
			STranq_Options_BarScaleLow:SetTextColor(0.3, 0.3, 0.3);
		else
			STranq_Options_AutoHideBars:Enable();
			STranq_Options_AutoHideBars_Text:SetTextColor(1, 0.82, 0);
			STranq_Options_LockBars:Enable();
			STranq_Options_LockBars_Text:SetTextColor(1, 0.82, 0);
			STranq_Options_LockRot:Enable();
			STranq_Options_LockRot_Text:SetTextColor(1, 0.82, 0);
			STranq_Options_HideExtra:Enable();
			STranq_Options_HideExtra_Text:SetTextColor(1, 0.82, 0);
			STranq_Options_BarsGrowUp:Enable();
			STranq_Options_BarsGrowUp_Text:SetTextColor(1, 0.82, 0);
			STranq_Options_BarAlpha:EnableMouse(1);
			STranq_Options_BarAlphaText:SetTextColor(1, 0.82, 0);
			STranq_Options_BarAlphaHigh:SetTextColor(1, 1, 1);
			STranq_Options_BarAlphaLow:SetTextColor(1, 1, 1);
			STranq_Options_BarScale:EnableMouse(1);
			STranq_Options_BarScaleText:SetTextColor(1, 0.82, 0);
			STranq_Options_BarScaleHigh:SetTextColor(1, 1, 1);
			STranq_Options_BarScaleLow:SetTextColor(1, 1, 1);
		end
	elseif ( tab == 2 ) then
		STranqError:Show();
	else
		STranqBroadcast:Show();
	end
	STranq_StatusBar_Display();
end

function STranq_Options_SaveCheck()
	local id = UIDropDownMenu_GetSelectedID(STranq_Options_CastType_DropDown);
	local newChan = STranq_Options_CastChan_DropDownText:GetText();
	if ( newChan and ( newChan == STRANQ_NOCHANNEL_TEXT or newChan == STRANQ_NOPLAYER_TEXT ) ) then
		newChan = nil;
	end

	if ( STranq_Saved["CastType"] ~= id or
		STranq_Saved["CastChan"] ~= newChan or
		STranq_Saved["CastMsg"] ~= STranq_Options_CastMsg:GetText() or
		STranq_Saved["MissMsg"] ~= STranq_Options_MissMsg:GetText() or
		STranq_Saved["MissErr"] ~= STranq_Options_MissErr:GetText() or
		STranq_Saved["RaidErr"] ~= STranq_Options_RaidErr:GetText() or
		STranq_Saved["FailMsg"] ~= STranq_Options_FailMsg:GetText() or
		STranq_Saved["FailErr"] ~= STranq_Options_FailErr:GetText() or
		STranq_Saved["RaidFailErr"] ~= STranq_Options_RaidFailErr:GetText() or
		STranq_Saved["RaidMisses"] == STranq_Options_RaidMisses:GetChecked() or
		STranq_Saved["NoSound"] == STranq_Options_Sounds:GetChecked() or
		STranq_Saved["RS"] ~= STranq_Options_RS:GetChecked() or
		STranq_Saved["HideRot"] == STranq_Options_HideRot:GetChecked() or
		STranq_Saved["HideBars"] ~= STranq_Options_HideBars:GetChecked() or
		STranq_Saved["AutoHideBars"] ~= STranq_Options_AutoHideBars:GetChecked() or
		STranq_Saved["LockBars"] ~= STranq_Options_LockBars:GetChecked() or
		STranq_Saved["LockRot"] ~= STranq_Options_LockRot:GetChecked() or
		STranq_Saved["BarsGrowUp"] ~= STranq_Options_BarsGrowUp:GetChecked() or
		STranq_Saved["HideExtra"] ~= STranq_Options_HideExtra:GetChecked() or
		STranq_Saved["ShowNonHunters"] ~= STranq_Options_ShowNonHunters:GetChecked() or
		STranq_Saved["OfficersOnly"] ~= STranq_Options_OfficersOnly:GetChecked() or
		STranq_Saved["MissColor"].r ~= STranq_Options.MissColor.r or
		STranq_Saved["MissColor"].g ~= STranq_Options.MissColor.g or
		STranq_Saved["MissColor"].b ~= STranq_Options.MissColor.b or
		STranq_Saved["RaidMissColor"].r ~= STranq_Options.RaidMissColor.r or
		STranq_Saved["RaidMissColor"].g ~= STranq_Options.RaidMissColor.g or
		STranq_Saved["RaidMissColor"].b ~= STranq_Options.RaidMissColor.b or
		STranq_Saved["BarAlpha"] ~= STranq_Options_BarAlpha:GetValue() or
		STranq_Saved["BarScale"] ~= STranq_Options_BarScale:GetValue()
		) then

		STranq_OptionsSave:Enable();
		this.NeedSave = 1;
	else
		STranq_OptionsSave:Disable();
		this.NeedSave = nil;
	end
end

function STranq_Options_Close()
	if ( STranq_Options.NeedSave ) then
		StaticPopup_Show("STRANQ_NEEDSAVE");
		StaticPopup_Hide("STRANQ_NOVALID_MSG");
		StaticPopup_Hide("STRANQ_NOVALID_SAVE");
	end
	HideUIPanel(STranq_Options);
end

function STranq_Options_Toggle()
	if ( not loaded ) then
		return;
	end
	if ( STranq_Options:IsVisible() ) then
		STranq_Options_Close();
	else
		ShowUIPanel(STranq_Options);
	end
end

function STranq_StatusBars_Toggle(show)
	if ( not loaded ) then
		return;
	end
	if ( show ) then
		if ( show == 1 ) then
			STranq_Saved["HideBars"] = nil;
		else
			STranq_Saved["HideBars"] = 1;
		end
	elseif ( STranq_Saved["HideBars"] ) then
		STranq_Saved["HideBars"] = nil
	else
		STranq_Saved["HideBars"] = 1;
	end
	if ( STranq_Options:IsVisible() ) then
		STranq_Options_HideBars:SetChecked(STranq_Saved["HideBars"]);
		STranq_Options_Update();
	end
	STranq_StatusBar_Display();
end

StaticPopupDialogs["STRANQ_DEFAULTS"] = {
	  text = STRANQ_DEFAULTS_POPUP,
	  button1 = YES,
	  button2 = NO,
	  OnAccept = function()
	      STranq_Options_Defaults();
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  showAlert = 1
};

StaticPopupDialogs["STRANQ_DEFAULTSALL"] = {
	  text = STRANQ_DEFAULTSALL_POPUP,
	  button1 = YES,
	  button2 = NO,
	  OnAccept = function()
	      STranq_Options_Defaults(1);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  showAlert = 1
};

StaticPopupDialogs["STRANQ_NEEDSAVE"] = {
	  text = STRANQ_NEEDSAVE_POPUP,
	  button1 = YES,
	  button2 = NO,
	  OnAccept = function()
	      STranq_Options_Save();
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
};

StaticPopupDialogs["STRANQ_NOVALID_MSG"] = {
	text = STRANQ_NOVALID_MSG_POPUP,
	button1 = OKAY,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
};

StaticPopupDialogs["STRANQ_NOVALID_SAVE"] = {
	text = STRANQ_NOVALID_SAVE_POPUP,
	button1 = OKAY,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
};

StaticPopupDialogs["STRANQ_NEWROTATION"] = {
	text = STRANQ_NEWROTATION_POPUP,
	button1 = ACCEPT,
	button2 = DECLINE,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
};
