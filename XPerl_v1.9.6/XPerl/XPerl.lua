-- Colour tables now taken from WoW values (Since 1.6.4) - Well, we want to be ready when there's Paladin and Shaman in same raid
-- and we can leave the colour choice up to Blizzard and it'll just all work.

-- We craeted our string based colour table from Blizzard's raid colour table in
local function MashXX(class)
	local c = RAID_CLASS_COLORS[class]
	XPerlColourTable[class] = string.format("|c00%02X%02X%02X", 255 * c.r, 255 * c.g, 255 * c.b)
end
XPerlColourTable = {}
MashXX("HUNTER")
MashXX("WARLOCK")
MashXX("PRIEST")
MashXX("PALADIN")
MashXX("MAGE")
MashXX("ROGUE")
MashXX("DRUID")
MashXX("SHAMAN")
MashXX("WARRIOR")

-- XPerl_GetClassColour
function XPerl_GetClassColour(class)
	if (class) then
		local color = RAID_CLASS_COLORS[class];		-- Now using the WoW class color table
		if (color) then
			return color
		end
	end
	return {r = 0.5, g = 0.5, b = 1}
end

-- OtherClickHandlers
local function OtherClickHandlers(button, unitid)

	if (CastParty and CastParty.Event) then
		CastParty.Event.OnClickByUnit(button, unitid)			-- Cast Party v4
		return true

	elseif (CastParty_OnClickByUnit and CastPartyConfig) then		-- Cast Party (old version)
   		local function CastParty_BuildActionKey(button)
			local action_key = ""
			if IsAltKeyDown() then
				action_key = action_key .. 'Alt'
			end
			if IsControlKeyDown() then
				action_key = action_key .. 'Ctrl'
			end
			if IsShiftKeyDown() then
				action_key = action_key .. 'Shift'
			end
			if action_key == "" then
				action_key = "None"
			end
			return action_key
   		end

		local action_key = CastParty_BuildActionKey()
   		local action = CastPartyConfig.key_bindings[button][action_key]

		if (action ~= "CastParty_WoWDefaultClick" and action ~= "CastParty_PartyDropDown" and action ~= CASTPARTY_KEYBINDINGS_NONE) then
			CastParty_OnClickByUnit(button, unitid)
			return true
		end

	elseif (Heart_MouseHeal) then					-- Heart
		if (Heart_MouseHeal(unitid, button)) then
			return true
		end

	elseif (Genesis_MouseHeal) then					-- Genesis Clicks (no longer updated, replaced by Heart)
		if (Genesis_MouseHeal(unitid, button)) then
			return true
		end

	elseif (JC_CatchKeyBinding) then				-- JustClick
		if (JC_CatchKeyBinding(button, unitid)) then
			return true
		end

	elseif (CH_Config and CH_Config.PCUFEnabled and CH_UnitClicked) then	-- Click Heal
  		local mb = CH_BuildMouseButton(button)
  		actionType = CH_MouseSpells.Friend[mb]
		if (actionType ~= "MENU" and actionType ~= "TARGET" and actionType ~= "TOOLTIP") then
			CH_UnitClicked(unitid, button)
			return true
		end

	elseif (SmartHeal and SmartHeal.DefaultClick and SmartHeal.ClickHeal and SmartHeal.GetClickHealButton and SmartHeal.Loaded and SmartHeal.getConfig and SmartHeal:getConfig("enable") and SmartHeal:getConfig("enable", "clickmode")) then
		local KeyDownType = SmartHeal:GetClickHealButton()		-- Smart Heal
		if(KeyDownType and KeyDownType ~= "undetermined") then
			SmartHeal:ClickHeal(KeyDownType..button, unitid)
			return true
		end
	end
end

-- XPerl_Frame_FindID
-- Compatibility function
-- Same function used as Perl_Party_FindID, Perl_Party_Pet_FindID, Perl_Raid_FindID
function XPerl_Frame_FindID(object)
	local _, _, num = strfind(object:GetName(), "(%d+)")
	return tonumber(num)
end

-- XPerl_OnClick_Handler
function XPerl_OnClick_Handler(button, unitid)

	if (XPerlConfig.CastParty == 1) then
		if (XPerlConfig.CastPartyRaidOnly == 0 or string.sub(unitid, 1, 4) == "raid") then
			local frame = getglobal(this:GetParent():GetName().."_NameFrame")
			if (not frame or not MouseIsOver(frame)) then
				-- Name frame gives default behaviour

				if (type(Perl_Custom_ClickFunction) == "function") then
					if (Perl_Custom_ClickFunction(button, unitid)) then
						-- Perl_Custom_ClickFunction should return true if handled, then we do nothing more.
						-- no return and we'll continue with default X-Perl behaviour
						return true
					end
				end

				if (OtherClickHandlers(button, unitid)) then
					return true
				end
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit(unitid)
			return true
		elseif (CursorHasItem()) then
      			if (UnitIsUnit("player", unitid)) then
         			AutoEquipCursorItem()
			else
				DropItemOnUnit(unitid)
			end
			return true
		else
			TargetUnit(unitid)
			return true
		end

	elseif (button == "RightButton") then
		if (SpellIsTargeting()) then
			SpellStopTargeting()
			return true
		end
	end
end

-- XPerl_IsFeignDeath(unit)
function XPerl_IsFeignDeath(unit)
	for i = 1,20 do
		local buff = UnitBuff(unit, i)

		if (buff) then
			if (strfind(strlower(buff), "feigndeath")) then
				return true
			end
		else
			break
		end
	end
end

---------------------------------
--Loading Function             --
---------------------------------

-- XPerl_DisallowClear
--function XPerl_DisallowClear()
--	return AceLibrary and AceLibrary:HasInstance("Jostle-2.0")
--end

-- XPerl_BlizzFramesDisable
function XPerl_BlizzFramesDisable()
	local XPerl_DummyFrame
	local XPerl_DummyFunc

	--if (XPerl_DisallowClear()) then
	--	XPerlConfig.ClearBlizzardFrames = 0
	--end

	if (XPerlConfig.ClearBlizzardFrames == 1) then
		XPerl_DummyFrame = CreateFrame("Frame")
		XPerl_DummyFunc = function() end
	end

	if (XPerl_Player) then
		-- Blizz Player Frame Events
		PlayerFrame:UnregisterAllEvents()
		PlayerFrameHealthBar:UnregisterAllEvents()
		PlayerFrameManaBar:UnregisterAllEvents()
		PlayerFrame:Hide()
		-- Make it so it won't be visible, even if shown by another mod
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			PlayerFrame = XPerl_DummyFrame

			PlayerFrame_OnLoad = nil
			PlayerFrame_Update = nil
			PlayerFrame_UpdatePartyLeader = nil
			PlayerFrame_UpdatePvPStatus = nil
			PlayerFrame_OnEvent = nil
			PlayerFrame_OnUpdate = nil
			PlayerFrame_OnClick = nil
			PlayerFrame_OnReceiveDrag = nil
			PlayerFrame_UpdateStatus = nil
			PlayerFrame_UpdateGroupIndicator = nil
			PlayerFrameDropDown_OnLoad = nil
			PlayerFrame_UpdatePlaytime = nil
		end
	end

	if (XPerl_Player_Pet) then
		-- Blizz Pet Frame Events
		PetFrame:UnregisterAllEvents()
		PetFrame:Hide()
		PetFrame:ClearAllPoints()
		PetFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			PetFrame = XPerl_DummyFrame

			PetFrame_OnLoad = nil
			PetFrame_Update = nil
			PetFrame_OnEvent = nil
			PetFrame_OnUpdate = nil
			PetFrame_OnClick = nil
			PetFrame_SetHappiness = nil
			PetFrameDropDown_OnLoad = nil
		end
	end

	if (XPerl_Target) then
		-- Blizz Target Frame Events
		TargetFrame:UnregisterAllEvents()
		TargetFrameHealthBar:UnregisterAllEvents()
		TargetFrameManaBar:UnregisterAllEvents()
		TargetFrame:Hide()
		TargetofTargetFrame:UnregisterAllEvents()
		TargetofTargetFrame:Hide()
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)
		TargetofTargetFrame:ClearAllPoints()
		TargetofTargetFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			TargetFrame = XPerl_DummyFrame
			TargetofTargetFrame = XPerl_DummyFrame

			TargetFrame_OnLoad = nil
			TargetFrame_Update = nil
			TargetFrame_OnEvent = nil
			TargetFrame_OnShow = nil
			TargetFrame_OnHide = nil
			TargetFrame_CheckLevel = nil
			TargetFrame_CheckFaction = nil
			TargetFrame_CheckClassification = nil
			TargetFrame_CheckDead = nil
			TargetFrame_CheckDishonorableKill = nil
			TargetFrame_OnClick = nil
			TargetFrame_OnUpdate = nil
			TargetDebuffButton_Update = nil
			TargetFrame_HealthUpdate = nil
			TargetHealthCheck = nil
			TargetFrameDropDown_OnLoad = nil
			TargetFrame_UpdateRaidTargetIcon = nil

			TargetofTarget_OnUpdate = nil
			TargetofTarget_Update = nil
			TargetofTarget_OnClick = nil
			TargetofTarget_CheckDead = nil
			TargetofTargetHealthCheck = nil
		end
	end

	if (XPerl_party1) then
		-- Blizz Party Events
		ShowPartyFrame = function() end
		HidePartyFrame = ShowPartyFrame
		for num = 1, 4 do
			local f = getglobal("PartyMemberFrame"..num)
			f:Hide()
			f:UnregisterAllEvents()
			getglobal("PartyMemberFrame"..num.."HealthBar"):UnregisterAllEvents()
			getglobal("PartyMemberFrame"..num.."ManaBar"):UnregisterAllEvents()

			f:ClearAllPoints()
			f:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", 0, 50)
		end

		if (XPerlConfig.ClearBlizzardFrames == 1) then
			for num = 1, 4 do
				setglobal("PartyMemberFrame"..num, XPerl_DummyFrame)
			end
			PartyMemberFrame_OnLoad = nil
			PartyMemberFrame_UpdateMember = nil
			PartyMemberFrame_UpdatePet = XPerl_DummyFunc		-- Called when you press OK on interface options
			PartyMemberFrame_UpdateMemberHealth = nil
			PartyMemberFrame_UpdateLeader = nil
			PartyMemberFrame_UpdatePvPStatus = nil
			PartyMemberFrame_OnEvent = nil
			PartyMemberFrame_OnUpdate = nil
			PartyMemberFrame_OnClick = nil
			PartyMemberPetFrame_OnClick = nil
			PartyMemberFrame_RefreshPetBuffs = nil
			PartyMemberBuffTooltip_Update = nil
			PartyMemberHealthCheck = nil
			PartyFrameDropDown_OnLoad = nil
			UpdatePartyMemberBackground = nil
			PartyMemberBackground_ToggleOpacity = nil
			PartyMemberBackground_SetOpacity = nil
			PartyMemberBackground_SaveOpacity = nil
		end
	end
	XPerl_BlizzFramesDisable = nil
end

---------------------------------
--Smooth Health Bar Color      --
---------------------------------
function XPerl_SetSmoothBarColor (bar, percentage)
	if (bar) then
		local r, g, b
		if (XPerlConfig.ClassicHealthBar == 1) then
			if (percentage < 0.5) then
				r = 1
				g = 2*percentage
				b = 0
			else
				g = 1
				r = 2*(1 - percentage)
				b = 0
			end
		else
			r = XPerlConfig.ColourHealthEmpty.r + ((XPerlConfig.ColourHealthFull.r - XPerlConfig.ColourHealthEmpty.r) * percentage)
			g = XPerlConfig.ColourHealthEmpty.g + ((XPerlConfig.ColourHealthFull.g - XPerlConfig.ColourHealthEmpty.g) * percentage)
			b = XPerlConfig.ColourHealthEmpty.b + ((XPerlConfig.ColourHealthFull.b - XPerlConfig.ColourHealthEmpty.b) * percentage)
		end

		if (r >= 0 and g >= 0 and b >= 0 and r <= 1 and g <= 1 and b <= 1) then
			bar:SetStatusBarColor(r, g, b)

			local backBar = getglobal(bar:GetName().."BG")
			if (backBar) then
				backBar:SetVertexColor(r, g, b, 0.25)
			end
		end
	end
end

-- XPerl_SetHealthBar
function XPerl_SetHealthBar(bar, hp, max, healerMode, healerModeType)
	bar:SetMinMaxValues(0, max)
	if (XPerlConfig.InverseBars == 1) then
		bar:SetValue(max - hp)
	else
		bar:SetValue(hp)
	end

	local percent = hp / max
	local healthPct = string.format("%3.0f", percent * 100)

	XPerl_SetSmoothBarColor(bar, percent)

	local barPct = getglobal(bar:GetName().."Percent")
	if (barPct) then
		barPct:SetText(healthPct.."%")
	end

	local barText = getglobal(bar:GetName().."Text")
	if (barText) then
		if (healerMode == 1) then
			if (healerModeType == 1) then
				barText:SetText(string.format("%d/%d", hp - max, max))
			else
				barText:SetText(hp - max)
			end
		else
			barText:SetText(hp.."/"..max)
		end
	end
end

---------------------------------
--Class Icon Location Functions--
---------------------------------
function XPerl_ClassPos (class)
	if(class=="WARRIOR") then return 0,    0.25,    0,	0.25;	end
	if(class=="MAGE")    then return 0.25, 0.5,     0,	0.25;	end
	if(class=="ROGUE")   then return 0.5,  0.75,    0,	0.25;	end
	if(class=="DRUID")   then return 0.75, 1,       0,	0.25;	end
	if(class=="HUNTER")  then return 0,    0.25,    0.25,	0.5;	end
	if(class=="SHAMAN")  then return 0.25, 0.5,     0.25,	0.5;	end
	if(class=="PRIEST")  then return 0.5,  0.75,    0.25,	0.5;	end
	if(class=="WARLOCK") then return 0.75, 1,       0.25,	0.5;	end
	if(class=="PALADIN") then return 0,    0.25,    0.5,	0.75;	end
	return 0.25, 0.5, 0.5, 0.75	-- Returns empty next one, so blank
end

-- XPerl_Toggle
function XPerl_Toggle()
	if (XPerlLocked == 1) then
		XPerl_UnlockFrames()
	else
		XPerl_LockFrames()
	end
end

-- XPerl_UnlockFrames
function XPerl_UnlockFrames()
	EnableAddOn("XPerl_Options")
	if (not IsAddOnLoaded("XPerl_Options")) then
		UIParentLoadAddOn("XPerl_Options")
	end

	XPerlLocked = 0
	if (XPerl_RaidShowAllTitles) then
		XPerl_RaidShowAllTitles()
	end

	if (XPerl_Options) then
		XPerl_Options:Show()
		XPerl_Options:SetAlpha(0)
		XPerl_Options.Fading = "in"
	end
end

-- XPerl_LockFrames
function XPerl_LockFrames()
	XPerlLocked = 1
	if (XPerl_Options) then
		XPerl_Options.Fading = "out"
	end

	if (XPerl_RaidTitles) then
		XPerl_RaidTitles()
	end
end

-- Minimap Icon
function XPerl_MinimapButton_OnClick()
	XPerl_Toggle()
end

-- XPerl_MinimapButton_Init
function XPerl_MinimapButton_Init()
	if(XPerlConfig.MinimapButtonShown == 1) then
		XPerl_MinimapButton_Frame:Show()
	else
		XPerl_MinimapButton_Frame:Hide()
	end
end

-- XPerl_MinimapButton_UpdatePosition
function XPerl_MinimapButton_UpdatePosition()
	XPerl_MinimapButton_Frame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(XPerlConfig.MinimapButtonPosition)),
		(78 * sin(XPerlConfig.MinimapButtonPosition)) - 55
	)
	XPerl_MinimapButton_Init()
end

-- XPerl_MinimapButton_Dragging
function XPerl_MinimapButton_Dragging()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	XPerl_MinimapButton_SetPosition(math.deg(math.atan2(ypos,xpos)))
end

-- XPerl_MinimapButton_SetPosition
function XPerl_MinimapButton_SetPosition(v)
	if (v < 0) then
		v = v + 360
	end

	XPerlConfig.MinimapButtonPosition = v
	XPerl_MinimapButton_UpdatePosition()
end

-- XPerl_MinimapButton_OnEnter
function XPerl_MinimapButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT")
	GameTooltip:SetText(XPerl_Version, 1, 1, 1)
	GameTooltip:AddLine(XPERL_MINIMAP_HELP1)
	GameTooltip:AddLine(XPERL_MINIMAP_HELP2)
	GameTooltip:Show()
end

-- XPerl_SetManaBarType
local ManaColours = {"ColourMana", "ColourRage", "ColourFocus", "ColourEnergy"}
function XPerl_SetManaBarType(argUnit, argFrame)
	local power = UnitPowerType(argUnit)
	if (power) then
		local colour = XPerlConfig[ManaColours[power + 1]]

		argFrame:SetStatusBarColor(colour.r, colour.g, colour.b, 1)

		local argFrameBG = getglobal(argFrame:GetName().."BG")
		argFrameBG:SetVertexColor(colour.r, colour.g, colour.b, 0.25)
	end
end

-- XPerl_PlayerTip
function XPerl_PlayerTip(unitid)

	if (XPerlLocked == 0) then
		-- No tooltips when frames are unlocked
		return
	end

        if (SpellIsTargeting()) then
                if (SpellCanTargetUnit(unitid)) then
                        SetCursor("CAST_CURSOR")
                else
                        SetCursor("CAST_ERROR_CURSOR")
                end
        end

	GameTooltip_SetDefaultAnchor(GameTooltip, this)
	GameTooltip:SetUnit(unitid)

	if (XPerl_RaidTipExtra) then
		XPerl_RaidTipExtra(unitid)
	end

	if (XPerlConfig.XPerlTooltipInfo == 1 and XPerl_GetUsage) then
		local xpUsage = XPerl_GetUsage(UnitName(unitid))
		if (xpUsage) then
			local xp, any = "|cFFD00000X-Perl|r "
			if (xpUsage.version) then
				xp = xp..xpUsage.version
			else
				xp = xp..XPerl_VersionNumber
			end
			any = true

			if (xpUsage.mods and IsShiftKeyDown()) then
				local modList = XPerl_DecodeModuleList(xpUsage.mods)
				if (modList) then
					xp = xp.." : |c00909090"..modList
				end
			end
			if (any) then
				GameTooltip:AddLine(xp, 1, 1, 1, 1)
				GameTooltip:Show()
			end
		end
	end
end

-- XPerl_PlayerTipHide
function XPerl_PlayerTipHide()
	if (XPerlConfig.FadingTooltip == 1) then
		GameTooltip:FadeOut()
	else
		GameTooltip:Hide()
	end
end

-- XPerl_ToolTip_AddBuffDuration
function XPerl_ToolTip_AddBuffDuration(partyid, x)
	if (XPerl_Raid_AddBuffDuration) then
		XPerl_Raid_AddBuffDuration(partyid, x)
	end
end

-- XPerl_ToolTip_AddBuffDuration
function XPerl_ToolTip_AddDebuffDuration(partyid, x, index, cureCast)
	if (XPerl_Raid_AddDebuffDuration) then
		XPerl_Raid_AddDebuffDuration(partyid, x, index, cureCast)
	end
end

-- XPerl_ColourFriendlyUnit
function XPerl_ColourFriendlyUnit(frame, partyid)
	local color
	if (UnitCanAttack("player", partyid) and UnitIsEnemy("player", partyid)) then	-- For dueling
		color = XPerlConfig.ColourReactionEnemy
	else
		if (XPerlConfig.ClassColouredNames == 1) then
			local _, engClass = UnitClass(partyid)
			color = XPerl_GetClassColour(engClass)
		else
			if (UnitIsPVP(partyid)) then
				color = XPerlConfig.ColourReactionFriend
			else
				color = XPerlConfig.ColourReactionNone
			end
		end
	end

	frame:SetTextColor(color.r, color.g, color.b, XPerlConfig.TextTransparency)
end

-- XPerl_ReactionColour
function XPerl_ReactionColour(argUnit)

        if (UnitPlayerControlled(argUnit) or not UnitIsVisible(argUnit)) then
                if (UnitFactionGroup("player") == UnitFactionGroup(argUnit)) then
                        if (UnitIsEnemy("player", argUnit)) then
				-- Dueling
				return XPerlConfig.ColourReactionEnemy

                        elseif (UnitIsPVP(argUnit)) then
				return XPerlConfig.ColourReactionFriend
			end
		else
                        if (UnitIsPVP(argUnit)) then
				if (UnitIsPVP("player")) then
					return XPerlConfig.ColourReactionEnemy
				else
					return XPerlConfig.ColourReactionNeutral
				end
			end
		end
	else
                if (UnitIsTapped(argUnit) and not UnitIsTappedByPlayer(argUnit)) then
                        color = XPerlConfig.ColourTapped
                else
			local reaction = UnitReaction(argUnit, "player")
			if (reaction) then
				if (reaction >= 5) then
					return XPerlConfig.ColourReactionFriend
				elseif (reaction <= 2) then
					return XPerlConfig.ColourReactionEnemy
				elseif (reaction == 3) then
					return XPerlConfig.ColourReactionUnfriendly
				else
					return XPerlConfig.ColourReactionNeutral
				end
			else
				if (UnitFactionGroup("player") == UnitFactionGroup(argUnit)) then
					return XPerlConfig.ColourReactionFriend
				elseif (UnitIsEnemy("player", argUnit)) then
					return XPerlConfig.ColourReactionEnemy
				else
					return XPerlConfig.ColourReactionNeutral
				end
			end
		end
	end

	return XPerlConfig.ColourReactionNone
end

-- XPerl_SetUnitNameColor
function XPerl_SetUnitNameColor(argUnit,argFrame)

        if (UnitPlayerControlled(argUnit) or not UnitIsVisible(argUnit)) then
		-- 1.8.3 - Changed to override pvp name colours
		if (XPerlConfig.ClassColouredNames == 1) then
			local _, class = UnitClass(argUnit)
			color = XPerl_GetClassColour(class)
		else
			color = XPerl_ReactionColour(argUnit)
		end
	else
                if (UnitIsTapped(argUnit) and not UnitIsTappedByPlayer(argUnit)) then
                        color = XPerlConfig.ColourTapped
                else
			color = XPerl_ReactionColour(argUnit)
		end
	end

	argFrame:SetTextColor(color.r, color.g, color.b, XPerlConfig.TextTransparency)
end

local BasicEvents = {"UNIT_RAGE", "UNIT_MAXRAGE", "UNIT_ENERGY", "UNIT_MAXENERGY",
			"UNIT_MANA", "UNIT_MAXMANA", "UNIT_HEALTH", "UNIT_MAXHEALTH",
			"UNIT_LEVEL", "UNIT_COMBAT", "UNIT_DISPLAYPOWER", "UNIT_NAME_UPDATE"}

-- XPerl_RegisterBasics
function XPerl_RegisterBasics(argFrame)
	if (argFrame == nil) then
		argFrame = this
	end
	for i,event in pairs(BasicEvents) do
		argFrame:RegisterEvent(event)
	end
end

-- XPerl_UnregisterBasics
function XPerl_UnregisterBasics(argFrame)
	if (argFrame == nil) then
		argFrame = this
	end
	for i,event in pairs(BasicEvents) do
		argFrame:UnregisterEvent(event)
	end
end

-- PerlSetPortrait3D
function XPerlSetPortrait3D(argFrame, argUnit)
	argFrame:ClearModel()
	argFrame:SetUnit(argUnit)
	argFrame:SetCamera(0)
end

-- XPerl_CombatFlashSet
function XPerl_CombatFlashSet (elapsed, argFrame, argNew, argGreen)
	if (XPerlConfig.PerlCombatFlash == 0) then
		argFrame.PlayerFlash = nil
		return false
	end

	if (argFrame) then
		if (argNew) then
			argFrame.PlayerFlash = 1
			argFrame.PlayerFlashGreen = argGreen
		else
			if (argFrame.PlayerFlash and elapsed) then
				argFrame.PlayerFlash = argFrame.PlayerFlash - elapsed

				if (argFrame.PlayerFlash <= 0) then
					argFrame.PlayerFlash = 0
					argFrame.PlayerFlashTime = nil
					argFrame.PlayerFlashGreen = nil
				end
			else
				return false
			end
		end

		return true
	end
end

-- XPerl_CombatFlashSetFrames
function XPerl_CombatFlashSetFrames(argFrame)
	if (argFrame.PlayerFlash) then
		local baseColour
		if (argFrame.forcedColour) then
			baseColour = argFrame.forcedColour
		else
			baseColour = XPerlConfig.BorderColour
		end

		local r, g, b, a
		if (argFrame.PlayerFlash > 0) then
			local flashOffsetColour = argFrame.PlayerFlash / 2
			if (argFrame.PlayerFlashGreen) then
				r = baseColour.r - flashOffsetColour
				g = baseColour.g + flashOffsetColour
				b = baseColour.b - flashOffsetColour
				a = baseColour.a + flashOffsetColour
			else
				r = baseColour.r + flashOffsetColour
				g = baseColour.g - flashOffsetColour
				b = baseColour.b - flashOffsetColour
				a = baseColour.a + flashOffsetColour
			end

			if (r < 0) then r = 0; elseif (r > 1) then r = 1; end
			if (g < 0) then g = 0; elseif (g > 1) then g = 1; end
			if (b < 0) then b = 0; elseif (b > 1) then b = 1; end
			if (a < 0) then a = 0; elseif (a > 1) then a = 1; end
		else
			r, g, b = baseColour.r, baseColour.g, baseColour.b, baseColour.a
		end

		if (not a) then
			a = XPerlConfig.BorderColour.a
		end
		for i, frame in pairs(argFrame.FlashFrames) do
			frame:SetBackdropBorderColor(r, g, b, a)
		end

		if (argFrame.PlayerFlash == 0) then
			argFrame.PlayerFlash = nil
		end
	end
end

local bgDef = {bgFile = "Interface\\Addons\\XPerl\\Images\\XPerl_FrameBack",
	       edgeFile = "",
	       tile = true, tileSize = 32, edgeSize = 16,
	       insets = { left = 5, right = 5, top = 5, bottom = 5 }
		}

-- XPerl_CheckDebuffs
function XPerl_CheckDebuffs(unit, frames)

	local conf = XPerlConfig
	if (conf.HighlightDebuffs == 0) then
		-- Reset the frame edges back to normal in case they changed options while debuffed.
		bgDef.edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border"
		for i, f in pairs(frames) do
			f:SetBackdrop(bgDef)
			f:SetBackdropColor(conf.BackColour.r, conf.BackColour.g, conf.BackColour.b, conf.BackColour.a)
			f:SetBackdropBorderColor(conf.BorderColour.r, conf.BorderColour.g, conf.BorderColour.b, conf.BorderColour.a)
		end
		return
	end

	local show
	local Curses = {}
	local debuffCount = 0

	for i = 1, MAX_TARGET_DEBUFFS do
		local debuff, debuffStack, debuffType = UnitDebuff(unit, i)

		if (not debuff) then
			break
		end

		if (debuffType) then
			Curses[debuffType] = debuffType
			debuffCount = debuffCount + 1
		end
	end

	if (debuffCount > 0) then
		if (XPerlConfig.HighlightDebuffsClass == 0) then
			show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
		end

		-- We also re-set the colours here so that we highlight best colour per class
		local _, class = UnitClass("player")
		if (class == "MAGE") then
			show = Curses.Curse

		elseif (class == "DRUID") then
			show = Curses.Curse or Curses.Poison

		elseif (class == "PRIEST") then
			show = Curses.Magic or Curses.Disease

		elseif (class == "WARLOCK") then
			show = Curses.Magic

		elseif (class == "PALADIN") then
			show = Curses.Magic or Curses.Poison or Curses.Disease

		elseif (class == "SHAMAN") then
			show = Curses.Poison or Curses.Disease
		end
	end

	local colour, borderColour
	if (show) then
		colour = DebuffTypeColor[show]
		colour.a = 1

		if (conf.HighlightDebuffsBorder > 0) then
			borderColour = colour
		else
			borderColour = conf.BorderColour
		end
	else
		colour = conf.BackColour
		borderColour = conf.BorderColour
	end

	for i, f in pairs(frames) do
		if (show and conf.HighlightDebuffsBorder > 0) then
			f:GetParent().forcedColour = borderColour
			bgDef.edgeFile = "Interface\\Addons\\XPerl\\Images\\XPerl_Curse"
			f:SetBackdrop(bgDef)
		else
			f:GetParent().forcedColour = nil
			bgDef.edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border"
			f:SetBackdrop(bgDef)
		end

		if (XPerlConfig.HighlightDebuffsBorder == 2) then
			colour = conf.BackColour
		end
		f:SetBackdropColor(colour.r, colour.g, colour.b, colour.a)
		f:SetBackdropBorderColor(borderColour.r, borderColour.g, borderColour.b, borderColour.a)
	end
end

-- XPerl_SavePosition(frame)
function XPerl_SavePosition(frame)
	if (not XPerlConfig.SavedPositions) then
		XPerlConfig.SavedPositions = {}
	end
	XPerlConfig.SavedPositions[frame:GetName()] = {top = frame:GetTop(), left = frame:GetLeft()}
end

-- XPerl_RestorePosition(frame)
function XPerl_RestorePosition(frame)
	if (XPerlConfig.SavedPositions) then
		local pos = XPerlConfig.SavedPositions[frame:GetName()]
		if (pos) then
			if (pos.left or pos.right) then
				frame:ClearAllPoints()
				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pos.left, pos.top)
			end
		end
	end
end

-- XPerl_SetBuffSize
function XPerl_SetBuffSize(prefix, sizeBuff, sizeDebuff)
	for i = 1,20 do
		local buff = getglobal(prefix.."BuffFrame_Buff"..i)
		if (buff) then
			buff:SetHeight(sizeBuff)
			buff:SetWidth(sizeBuff)
		end

		local buff = getglobal(prefix.."BuffFrame_DeBuff"..i)
		if (buff) then
			buff:SetHeight(sizeDebuff)
			buff:SetWidth(sizeDebuff)
		end
	end
end

-- true indicates the buff is valid on anyone, otherwise a class string dictates we only count it if the player with the buff matches
local BuffExceptions = {
	--ALL = {Spell_Misc_Food = true},	-- Enable this for food
	PRIEST = {Spell_Nature_ResistNature = true, Spell_Nature_Rejuvenation = true},	-- Druid regens
	DRUID = {Spell_Holy_Renew = true},		-- Priest regens
	WARLOCK = {Spell_Shadow_SoulGem = true},	-- Soulstone Resurrection
	HUNTER = {Spell_Nature_RavenForm = "HUNTER", Ability_Mount_JungleTiger = "HUNTER", Ability_Mount_WhiteTiger = true, Ability_Mount_PinkTiger = "HUNTER", Ability_Hunter_AspectOfTheMonkey = "HUNTER", Spell_Nature_ProtectionformNature = true, Ability_Rogue_FeignDeath = "HUNTER", Ability_Hunter_RunningShot = "HUNTER", Ability_TrueShot = true, Ability_Hunter_BeastTraining = "WARRIOR"},
	ROGUE = {Ability_Stealth = "ROGUE", Spell_Shadow_ShadowWard = "ROGUE", Ability_Vanish = "ROGUE", Ability_Rogue_Sprint = "ROGUE"}
}

local DebuffExceptions = {
	ALL = {INV_Misc_Bandage_08 = true},		-- Recently Bandaged
	PRIEST = {Spell_Holy_AshesToAshes = true}	-- Weakened Soul
}

-- BuffException
--local showInfo
local function BuffException(unit, index, flag, func, exceptions)

	local buff, count, debuffType
	if (not flag or flag == 0 or flag == "0") then
		-- Not filtered, just return it
		buff, count, debuffType = func(unit, index)
		return buff, count, debuffType, index
	end

	buff, count, debuffType = func(unit, index, 1)
	if (buff) then
		--if (showInfo) then
		--	ChatFrame7:AddMessage("Found buff with normal filter at index "..index)
		--end
		-- We need the index of the buff unfiltered later for tooltips
		for i = 1,20 do
			local buff1, count1, debuffType1 = func(unit, i)
			if (buff == buff1 and count == count1) then
				index = i
				break
			end
		end

		return buff, count, debuffType, index
	end

	-- See how many filtered buffs WoW has returned by default
	local normalBuffFilterCount = 0
	for i = 1,20 do
		buff, count, debuffType = func(unit, i, 1)
		if (not buff) then
			normalBuffFilterCount = i - 1
			break
		end
	end

	-- Nothing found by default, so look for exceptions
	local _, class = UnitClass("player")
	local _, unitClass = UnitClass(unit)
	local foundValid = 0
	for i = 1,20 do
		buff, count, debuffType = func(unit, i)

		if (not buff) then
			break
		end

		if (strsub(buff, 1, 16) == "Interface\\Icons\\") then
			local test = strsub(buff, 17)
			local good

			if (exceptions[class]) then
				good = exceptions[class][test]
			elseif (exceptions.ALL) then
				good = exceptions.ALL[test]
			end

			-- Enable this for potions
			--if (not good) then
			--	if (exceptions == BuffExceptions and strsub(test, 1, 11) == "INV_Potion_") then
			--		good = true
			--	end
			--end

			if (good and type(good) == "string" and good ~= unitClass) then
				good = nil
			end

			if (good) then
				foundValid = foundValid + 1
				if (foundValid + normalBuffFilterCount == index) then
					--if (showInfo) then
					--	ChatFrame7:AddMessage("Found extra: "..buff..", requested index == "..index..", actual buff index == "..i)
					--end
					return buff, count, debuffType, i
				end
			end
		end
	end
end

-- XPerl_UnitBuff
function XPerl_UnitBuff(unit, index, flag)
	return BuffException(unit, index, flag, UnitBuff, BuffExceptions)
end

-- XPerl_UnitBuff
function XPerl_UnitDebuff(unit, index, flag)
	return BuffException(unit, index, flag, UnitDebuff, DebuffExceptions)
end

-- XPerl_TooltipSetUnitBuff
-- Retreives the index of the actual unfiltered buff, and uses this on unfiltered tooltip call
function XPerl_TooltipSetUnitBuff(tooltip, unit, ind, flag)
	--showInfo = true
	local buff, count, _, index = BuffException(unit, ind, flag, UnitBuff, BuffExceptions)
	--showInfo = nil
	tooltip:SetUnitBuff(unit, index)
end

-- XPerl_TooltipSetUnitDebuff
-- Retreives the index of the actual unfiltered debuff, and uses this on unfiltered tooltip call
function XPerl_TooltipSetUnitDebuff(tooltip, unit, ind, flag)
	local buff, count, debuffType, index = BuffException(unit, ind, flag, UnitDebuff, DebuffExceptions)
	tooltip:SetUnitDebuff(unit, index)
end

local oldGuildStatus_Update
local oldWhoList_Update
local colourList = {
		[XPERL_LOC_CLASS_WARRIOR]	= "WARRIOR",
		[XPERL_LOC_CLASS_MAGE]		= "MAGE",
		[XPERL_LOC_CLASS_ROGUE]		= "ROGUE",
		[XPERL_LOC_CLASS_DRUID]		= "DRUID",
		[XPERL_LOC_CLASS_HUNTER]	= "HUNTER",
		[XPERL_LOC_CLASS_SHAMAN]	= "SHAMAN",
		[XPERL_LOC_CLASS_PRIEST]	= "PRIEST",
		[XPERL_LOC_CLASS_WARLOCK]	= "WARLOCK",
		[XPERL_LOC_CLASS_PALADIN]	= "PALADIN"}

-- XPerl_GuildStatusUpdate()
function XPerl_GuildStatusUpdate()
	oldGuildStatus_Update()

	if (XPerlConfig.ClassColouredNames == 1 or XPerlConfig.XPerlTooltipInfo == 1) then

		local myZone = GetRealZoneText()

		local guildOffset = FauxScrollFrame_GetOffset(GuildListScrollFrame)
		for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
			local guildIndex = guildOffset + i

			local button = getglobal("GuildFrameButton"..i);
			button.guildIndex = guildIndex;
			local name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(guildIndex)
			if (not name) then
				break
			end

			if (XPerlConfig.XPerlTooltipInfo == 1 and XPerl_GetUsage) then
				local u = XPerl_GetUsage(name)

				if (u) then
					if (online) then
						getglobal("GuildFrameButton"..i.."Name"):SetTextColor(1, 0.4, 0.4)
						getglobal("GuildFrameGuildStatusButton"..i.."Name"):SetTextColor(1, 0.4, 0.4)
					else
						getglobal("GuildFrameButton"..i.."Name"):SetTextColor(0.5, 0.2, 0.2)
						getglobal("GuildFrameGuildStatusButton"..i.."Name"):SetTextColor(0.5, 0.2, 0.2)
					end
				end
			end

			if (XPerlConfig.ClassColouredNames == 1 and XPerlConfig.ApplyToGuildList == 1) then
				class = colourList[class]

				if (class) then
					local color = XPerl_GetClassColour(class)
					if (color) then
						if (online) then
							getglobal("GuildFrameButton"..i.."Class"):SetTextColor(color.r, color.g, color.b)
						else
							getglobal("GuildFrameButton"..i.."Class"):SetTextColor(color.r / 2, color.g / 2, color.b / 2)
						end
					end
				end

				if (zone == myZone) then
					if (online) then
						getglobal("GuildFrameButton"..i.."Zone"):SetTextColor(0, 1, 0)
					else
						getglobal("GuildFrameButton"..i.."Zone"):SetTextColor(0, 0.5, 0)
					end
				end

				local color = GetDifficultyColor(level)
				if (online) then
					getglobal("GuildFrameButton"..i.."Level"):SetTextColor(color.r, color.g, color.b)
				else
					getglobal("GuildFrameButton"..i.."Level"):SetTextColor(color.r / 2, color.g / 2, color.b / 2)
				end
			end
		end
	end
end

if (GuildStatus_Update ~= XPerl_GuildStatusUpdate) then
	oldGuildStatus_Update = GuildStatus_Update
	GuildStatus_Update = XPerl_GuildStatusUpdate
end

-- XPerl_WhoList_Update
function XPerl_WhoList_Update()
	oldWhoList_Update()

	local numWhos, totalCount = GetNumWhoResults()
	local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)

	local myZone = GetRealZoneText()
	local myRace = UnitRace("player")
	local myGuild = GetGuildInfo("player")

	for i=1, WHOS_TO_DISPLAY, 1 do
		local name, guild, level, race, class, zone = GetWhoInfo(whoOffset + i)
		local color
		if (not name) then
			break
		end

		getglobal("WhoFrameButton"..i.."Name"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		if (XPerlConfig.XPerlTooltipInfo == 1 and XPerl_GetUsage) then
			local u = XPerl_GetUsage(name)
			if (u) then
				getglobal("WhoFrameButton"..i.."Name"):SetTextColor(1, 0.4, 0.4)
			end
		end

		if (XPerlConfig.ClassColouredNames == 1 and XPerlConfig.ApplyToGuildList == 1) then
			if (UIDropDownMenu_GetSelectedID(WhoFrameDropDown) == 1) then
				-- Zone
				if (zone == myZone) then
					getglobal("WhoFrameButton"..i.."Variable"):SetTextColor(0, 1, 0)
				else
					getglobal("WhoFrameButton"..i.."Variable"):SetTextColor(1, 1, 1)
				end
			elseif (UIDropDownMenu_GetSelectedID(WhoFrameDropDown) == 2) then
				if (guild == myGuild) then
					getglobal("WhoFrameButton"..i.."Variable"):SetTextColor(0, 1, 0)
				else
					getglobal("WhoFrameButton"..i.."Variable"):SetTextColor(1, 1, 1)
				end

			elseif (UIDropDownMenu_GetSelectedID(WhoFrameDropDown) == 3) then
				if (race == myRace) then
					getglobal("WhoFrameButton"..i.."Variable"):SetTextColor(0, 1, 0)
				else
					getglobal("WhoFrameButton"..i.."Variable"):SetTextColor(1, 1, 1)
				end
			end

			getglobal("WhoFrameButton"..i.."Class"):SetTextColor(1, 1, 1)
			class = colourList[class]
			if (class) then
				local color = XPerl_GetClassColour(class)
				if (color) then
					getglobal("WhoFrameButton"..i.."Class"):SetTextColor(color.r, color.g, color.b)
				end
			end

			local color = GetDifficultyColor(level)
			getglobal("WhoFrameButton"..i.."Level"):SetTextColor(color.r, color.g, color.b)
		else
			getglobal("WhoFrameButton"..i.."Variable"):SetTextColor(1, 1, 1)
			getglobal("WhoFrameButton"..i.."Level"):SetTextColor(1, 1, 1)
			getglobal("WhoFrameButton"..i.."Class"):SetTextColor(1, 1, 1)
		end
	end
end

if (WhoList_Update ~= XPerl_WhoList_Update) then
	oldWhoList_Update = WhoList_Update
	WhoList_Update = XPerl_WhoList_Update
end

----------------------
-- Fading Bar Stuff --
----------------------
local fadeBars = {}
local freeFadeBars = {}
local tempDisableFadeBars

function XPerl_NoFadeBars(tempDisable)
	tempDisableFadeBars = tempDisable
end

-- CheckOnUpdate
local function CheckOnUpdate()
	local any
	for k,v in pairs(fadeBars) do
		any = true
		break
	end

	if (any) then
		XPerl_Globals:SetScript("OnUpdate", XPerl_BarUpdate)
	else
		XPerl_Globals:SetScript("OnUpdate", nil)
	end
end

-- XPerl_BarUpdate
--local speakerTimer = 0
--local speakerCycle = 0
function XPerl_BarUpdate()
	local did
	for k,v in pairs(fadeBars) do
		if (k:IsShown()) then
			v:SetAlpha(k.fadeAlpha)
			k.fadeAlpha = k.fadeAlpha - (arg1 / XPerlConfig.FadingBarsTime)

			local r, g, b = v.Tex:GetVertexColor()
			v:SetStatusBarColor(r, g, b)
		else
			-- Not shown, so end it
			k.fadeAlpha = 0
		end

		if (k.fadeAlpha <= 0) then
			tinsert(freeFadeBars, v)
			fadeBars[k] = nil
			k.fadeAlpha = nil
			k.fadeBar = nil
			v:SetValue(0)
			v:Hide()
			v.Tex = nil
			did = true
		end
	end

	if (did) then
		CheckOnUpdate()
	end
end

-- GetFreeFader
local function GetFreeFader(parent)
	local bar = freeFadeBars[1]
	if (bar) then
		tremove(freeFadeBars, 1)
		bar:SetParent(parent)
	else
		bar = CreateFrame("StatusBar", nil, parent)
	end

	if (bar) then
		fadeBars[parent] = bar
		CheckOnUpdate()

		bar.Tex = getglobal(parent:GetName().."Tex")

		local tex = parent:GetStatusBarTexture()
		bar:SetStatusBarTexture(tex:GetTexture())

		local r, g, b = bar.Tex:GetVertexColor()
		bar:SetStatusBarColor(r, g, b)

		bar:SetFrameLevel(parent:GetFrameLevel())

		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", 0, 0)
		bar:SetPoint("BOTTOMRIGHT", 0, 0)

		return bar
	end
end

-- XPerl_StatusBarSetValue
function XPerl_StatusBarSetValue(self, val)
	if (not tempDisableFadeBars and XPerlConfig.FadingBars == 1 and self:GetName()) then
		local min, max = self:GetMinMaxValues()
		local current = self:GetValue()

		if (val < current and val <= max and val >= min) then
			local bar = fadeBars[self]

			if (not bar) then
				bar = GetFreeFader(self)
			end

			if (bar) then
				if (not self.fadeAlpha) then
					self.fadeAlpha = 1
					bar:SetValue(current)
				end

				bar:SetMinMaxValues(min, max)
				bar:SetAlpha(self.fadeAlpha)
				bar:Show()
			end
		end
	end

	XPerl_OldStatusBarSetValue(self, val)
end
