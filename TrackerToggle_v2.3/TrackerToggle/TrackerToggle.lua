--------------------------------------------------------------------------
-- TrackerToggle.lua 
--------------------------------------------------------------------------
--[[
TrackerToggle
	Control your tracking spells with a handy minimap menu.
	Binding for Tracking Mode Cycling

v2.3
-DropDownList1 is now clamped to screen so it wont go off.

v2.2
-Fixed Tracking Cycling

v2.1
-Updated German spelling of elemental tracking.
-Code Cleaning

v2.0
-No longer has any requirements. Optionally uses SeaHooks when availible.
-Menu is now openned by right-clicking on the Minimap (now you can open it with no tracking up)

v1.0
- Tooltip now changes when Tracking is cycled if mouse is still over
  MiniMapTrackingFrame

v0.3
- cycleTracking now works if you only have 1 tracking ability. it will start up that 1 ability.
  This was done so you could use the key bound to cycleTracking for all characters even ones w/ just 1
  tracking mode.

v0.2
- ReImplemented as a Class structure.
- Set default to disabled, initSpells will enable if needed. Prevents bringing up menu before it is ready.
- Fixed initSpells so that it re-enables TrackerToggle if 2 or more trackers available.
- Moved SortTable population/sorting to onLoad instead of afterInit to guarantee population before
  initSpells has happened.
  
v0.1
- MobileFrames Optional, if included can left-click on Tracking button to cycle tracking
- Added Keybinding for TrackerToggle_CycleTracking
- TrackerToggle_CycleTracking hides tooltip if mouse is over MiniMapTrackingFrame for now
  Possibly change tooltip to be accurate later.
- Right click brings up menu, current tracking checked, click to choose new one.
- SortTable created at startup based on values in TrackingAbilities for ordering
  Only have to add new abilities to 1 table now.


$Id: TrackerToggle.lua 3059 2006-02-10 22:23:51Z karlkfi $
$Rev: 3059 $
$LastChangedBy: karlkfi $
$Date: 2006-02-10 16:23:51 -0600 (Fri, 10 Feb 2006) $

]]--

TrackerToggleData = {
	-- Default to off.
	Disabled = true;
	-- false if numTrackers == 0 or > 2, spellNum otherwise
	oneTracking = false;

	-- Auto populated
	SortTable = { };
	-- Function to populate SortTable
	initSort = function()
		for k,v in TrackerToggleData.TrackingAbilities do
			local newOrderInfo = { name = k, order = v.spellNum };
			tinsert(TrackerToggleData.SortTable, newOrderInfo);
		end
		table.sort(TrackerToggleData.SortTable, function(a,b) return (a.order < b.order); end);
	end;

	-- Format: [SpellName from Localization] = { spellnum = orderNumber, header = trackingType }
	TrackingAbilities = {
		[TT_SPELL_TYPE_FIND]        = { spellNum = 1, header = nil },
		[TT_SPELL_FIND_HERBS]       = { spellNum = 2, header = TT_SPELL_TYPE_FIND },
		[TT_SPELL_FIND_MINERALS]    = { spellNum = 3, header = TT_SPELL_TYPE_FIND },
		[TT_SPELL_FIND_TREASURE]    = { spellNum = 4, header = TT_SPELL_TYPE_FIND },
		[TT_SPELL_TYPE_TRACK]       = { spellNum = 5, header = nil },
		[TT_SPELL_TRACK_BEASTS]     = { spellNum = 6, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TRACK_DEMONS]     = { spellNum = 7, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TRACK_DRAGONKIN]  = { spellNum = 8, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TRACK_ELEMENTALS] = { spellNum = 9, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TRACK_GIANTS]     = { spellNum = 10, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TRACK_HIDDEN]     = { spellNum = 11, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TRACK_HUMANOIDS]  = { spellNum = 12, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TRACK_UNDEAD]     = { spellNum = 13, header = TT_SPELL_TYPE_TRACK },
		[TT_SPELL_TYPE_SENSE]       = { spellNum = 14, header = nil },
		[TT_SPELL_SENSE_DEMONS]     = { spellNum = 15, header = TT_SPELL_TYPE_SENSE },
		[TT_SPELL_SENSE_UNDEAD]     = { spellNum = 16, header = TT_SPELL_TYPE_SENSE },
	};
}

TrackerToggle = {
	-- Initialize spellName to spellNum table, headers = -1 * (number of spells known for that header)
	initSpells = function()
		local i, numTrackers = 1,0;
		local headerRef = nil;
		local ttAbil = TrackerToggleData.TrackingAbilities;
		TrackerToggleData.oneTracking = false;
		TrackerToggleData.Disabled = true;
		
		-- Reset Tracking List
		for k,v in ttAbil do
			ttAbil[k].spellNum = 0;
		end
		
		-- Add Tracking Spells
		while (true) do
			local spellName, spellRank = GetSpellName(i, SpellBookFrame.bookType);
			if (not spellName) then
				break;
			elseif (ttAbil[spellName]) then
				numTrackers = numTrackers + 1;
				TrackerToggleData.oneTracking = i;
				TrackerToggleData.Disabled = false;
				ttAbil[spellName].spellNum = i;
				ttAbil[ttAbil[spellName].header].spellNum = ttAbil[ttAbil[spellName].header].spellNum - 1;
			end
			i = i + 1;
		end
		
		if (numTrackers > 1) then
			TrackerToggleData.oneTracking = false;
		end
	end;

	openMenu = function()
		ToggleDropDownMenu(1, nil, TrackerToggleDropDown, "cursor", 0, 0);
		--TrackerToggle.moveMenuOnScreen();
	end;

	-- Creates menu, spellNum > 0 = known spell, < 0 = header, =0 = not known or no known spells under header.
	initializeMenu = function()
		local info = {};
		local trackingTexture = GetTrackingTexture();
		local ttAbil = TrackerToggleData.TrackingAbilities;

		tinsert(info, { text = TRACKERTOGGLE_MENU_CLOSE, func = function () end; });
		tinsert(info, { text = "|cFFCCCCCC------------|r", disabled = 1, notClickable = 1 });

		for k,v in TrackerToggleData.SortTable do
			if ( ttAbil[v.name].spellNum < 0 ) then
				if (table.getn(info) > 3) then
					tinsert(info, { text = "", notClickable = 1 });
				end
				tinsert(info, { text = v.name, isTitle = 1, notClickable = 1 });
			elseif ( ttAbil[v.name].spellNum > 0 ) then
				tinsert(info, { text = v.name, value = ttAbil[v.name].spellNum, func = TrackerToggle.castSpell, checked = (trackingTexture == GetSpellTexture(ttAbil[v.name].spellNum, 1)) });
			end
		end

		tinsert(info, { text = "|cFFCCCCCC------------|r", disabled = 1, notClickable = 1 });
		tinsert(info, { text = TRACKERTOGGLE_STOP_TRACKING, func = CancelTrackingBuff });

		for index, menuLine in info do
			UIDropDownMenu_AddButton(menuLine);
		end
	end;
	
	moveMenuOnScreen = function()
		listFrame = DropDownList1;
		if (not listFrame:IsVisible()) then return end
		-- Determine whether the menu is off the screen or not
		if  not ( listFrame:GetRight() > UIParent:GetRight()*UIParent:GetScale() ) then return end
		local top = listFrame:GetTop();
		local left = listFrame:GetLeft();
		listFrame:ClearAllPoints();
		listFrame:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", left, top);
	end,

	-- EarthMenu passes info.checked and info.value to info.func, we only need the
	-- info.value, so here is an intermediary function to use it.
	castSpell = function()
		CastSpell(this.value, 1);
	end;

	cycleTracking = function()
		if (TrackerToggleData.Disabled) then return end;
		if (TrackerToggleData.oneTracking) then
			local spellNum = TrackerToggleData.oneTracking;
			if (spellNum) then
				-- Dont cast if its already up.
				if (GetTrackingTexture() ~= GetSpellTexture(spellNum, 1)) then
					CastSpell(spellNum, 1);
				end
			end
			return; 
		end
		local foundTracking = false;
		local firstTracking = nil;
		local trackingTexture = GetTrackingTexture();
		local ttAbil = TrackerToggleData.TrackingAbilities;

		for k,v in TrackerToggleData.SortTable do
			if ( ttAbil[v.name].spellNum > 0 ) then
				if (not firstTracking) then
					-- First Tracking mode found.
					firstTracking = v.name;
				end
				if (foundTracking) then
					CastSpell(ttAbil[v.name].spellNum, 1);
					return;
				elseif (trackingTexture == GetSpellTexture(ttAbil[v.name].spellNum, 1)) then
					foundTracking = true;
				end
			end
		end

		-- Either nothing was found, or the last one was found, so start at top.
		if (firstTracking) then
			CastSpell(ttAbil[firstTracking].spellNum, 1);
		end
	end;

	onLoad = function()
		-- Populate and sort SortTable before anything else is done.
		TrackerToggleData.initSort();
		
		--Initialize Menu
		UIDropDownMenu_Initialize(TrackerToggleDropDown, TrackerToggle.initializeMenu, "MENU");
		-- Right click tracking menu functionality
		if (Sea and Sea.util and Sea.util.hook) then
			Sea.util.hook("Minimap_OnClick", "TrackerToggle_Minimap_OnClick", "replace");
		else
			TrackerToggle_Minimap_OnClick_orig = Minimap_OnClick;
			Minimap_OnClick = function() if(TrackerToggle_Minimap_OnClick()) then TrackerToggle_Minimap_OnClick_orig() end end;
		end

		this:RegisterEvent("SPELLS_CHANGED");
		this:RegisterEvent("LEARNED_SPELL_IN_TAB");
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
		
		DropDownList1:SetClampedToScreen(1);
	end;

	onEvent = function(event)
		TrackerToggle.initSpells();
	end;
}

function TrackerToggle_Minimap_OnClick()
	if (TrackerToggleData.Disabled) then return true; end;
	if (arg1 == "RightButton") then
		TrackerToggle.openMenu();
		return false;
	end
	return true;
end
