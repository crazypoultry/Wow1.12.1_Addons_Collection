-- ClassicTooltip by Link

local VERSION = "1.12.0";
local RELEASEDATE = "October 11, 2006";

-- myAddons support variables
ClassicTooltipDetails = {
	name = "ClassicTooltip",
	description = "Reverts tooltips to the old style (about the 1.0 release)",
	version = VERSION,
	releaseDate = RELEASEDATE,
	author = "Link Dupont",
	email = "link.dupont@gmail.com",
	website = "http://link.stikipad.com/wiki/show/WowAddOns",
	category = MYADDONS_CATEGORY_OTHERS,
	frame = "ClassicTooltipFrame",
};

ClassicTooltipHelp = {};
ClassicTooltipHelp[1] = "ClassicTooltip reverts the tooltip to the older style.\n\n* Backdrop coloring, instead of coloring the unit's name\n* Less information is displayed on mouseover. For players, the name is on the first line, race and class on the second, and level on the third. No PvP text is displayed anywhere.\n* NPCs have their \"city\" association removed. Elite creatures have the + added after their level."

function ClassicTooltip_OnLoad()
	ClassicTooltip_Toggle("on");

	-- Sets the hostile faction color to the old value.
	-- This is from the ReputationFrame.lua file, extracted from interface.mpq.
	FACTION_BAR_COLORS[2].r = 0.8;
	FACTION_BAR_COLORS[2].g = 0.0;
	FACTION_BAR_COLORS[2].b = 0.0;

	this:RegisterEvent("VARIABLES_LOADED");

	SLASH_CLASSICTOOLTIP1 = "/classictooltip";
	SLASH_CLASSICTOOLTIP2 = "/ct";
	SlashCmdList["CLASSICTOOLTIP"] = ClassicTooltip_Toggle;
	
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("ClassicTooltip " .. VERSION .. " loaded.");
	end
end

function ClassicTooltip_OnEvent()
	if(event == "VARIABLES_LOADED") then
		-- Register the addon in myAddOns
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(ClassicTooltipDetails, ClassicTooltipHelp);
		end
	end
end

function ClassicTooltip_Toggle(arg)
	if(arg == "on") then
		Original_GameTooltip_OnEvent = GameTooltip:GetScript("OnEvent");
		GameTooltip:SetScript("OnEvent", ClassicTooltip_GameTooltip_OnEvent);

		Original_UnitFrame_OnEnter = UnitFrame_OnEnter;
		UnitFrame_OnEnter = ClassicTooltip_UnitFrame_OnEnter;

		Original_GameTooltip_UnitColor = GameTooltip_UnitColor;
		GameTooltip_UnitColor = ClassicTooltip_GameTooltip_UnitColor;

		Original_UnitFrame_OnUpdate = UnitFrame_OnUpdate;
		UnitFrame_OnUpdate = ClassicTooltip_UnitFrame_OnUpdate;

		Original_GameTooltip_OnHide = GameTooltip:GetScript("OnHide");
		GameTooltip:SetScript("OnHide", ClassicTooltip_GameTooltip_OnHide);

		Original_TargetFrameHealthBar_OnEnter = TargetFrameHealthBar:GetScript("OnEnter");
		TargetFrameHealthBar:SetScript("OnEnter", ClassicTooltip_TextStatusBar_OnEnter);

		Original_TargetFrameManaBar_OnEnter = TargetFrameManaBar:GetScript("OnEnter");
		TargetFrameManaBar:SetScript("OnEnter", ClassicTooltip_TextStatusBar_OnEnter);
	elseif(arg == "off") then
		GameTooltip:SetScript("OnEvent", Original_GameTooltip_OnEvent);
		UnitFrame_OnUpdate = Original_UnitFrame_OnUpdate;
		GameTooltip_UnitColor = Original_GameTooltip_UnitColor;
		UnitFrame_OnEnter = Original_UnitFrame_OnEnter;
		GameTooltip:SetScript("OnHide", Original_GameTooltip_OnHide);
		TargetFrameHealthBar:SetScript("OnEnter", Original_TextStatusBar_OnEnter);
		TargetFrameManaBar:SetScript("OnEnter", Original_TextStatusBar_OnEnter);
		ClassicTooltip_GameTooltip_OnHide();
	end
end

-- This is the GameTooltip_UnitColor function taken straight out of the interface.mpq.
-- It is the "release" version of the function, with the old colors.
-- I have not modified it at all (I think).
function ClassicTooltip_GameTooltip_UnitColor(unit)
	local r, g, b;
	if ( UnitPlayerControlled(unit) ) then
		if ( UnitCanAttack(unit, "player") ) then
			-- Hostile players are red
			if ( not UnitCanAttack("player", unit) ) then
				--[[
				r = 1.0;
				g = 0.5;
				b = 0.5;
				]]
				r = 0.0;
				g = 0.0;
				b = 1.0;
			else
				r = FACTION_BAR_COLORS[2].r;
				g = FACTION_BAR_COLORS[2].g;
				b = FACTION_BAR_COLORS[2].b;
			end
		elseif ( UnitCanAttack("player", unit) ) then
			-- Players we can attack but which are not hostile are yellow
			r = FACTION_BAR_COLORS[4].r;
			g = FACTION_BAR_COLORS[4].g;
			b = FACTION_BAR_COLORS[4].b;
		elseif ( UnitIsPVP(unit) ) then
			-- Players we can assist but are PvP flagged are green
			r = FACTION_BAR_COLORS[6].r;
			g = FACTION_BAR_COLORS[6].g;
			b = FACTION_BAR_COLORS[6].b;
		else
			-- All other players are blue (the usual state on the "blue" server)
			r = 0.0;
			g = 0.0;
			b = 1.0;
		end
	else
		local reaction = UnitReaction(unit, "player");
		if ( reaction ) then
			r = FACTION_BAR_COLORS[reaction].r;
			g = FACTION_BAR_COLORS[reaction].g;
			b = FACTION_BAR_COLORS[reaction].b;
		else
			r = 0.0;
			g = 0.0;
			b = 1.0;
		end
	end
	return r, g, b;
end

-- This is the GameTooltip_OnEvent function from the later releases (1600),
-- modified only by reverting the commented line (to set the backdrop instead of the text color).
-- I will continue to sync changes with future versions of this function.
function ClassicTooltip_GameTooltip_OnEvent()
	if ( event == "UPDATE_MOUSEOVER_UNIT" ) then
		if ( UnitExists("mouseover") ) then
			GameTooltip_SetDefaultAnchor(this, UIParent);
			this:SetUnit("mouseover");
			local r, g, b = GameTooltip_UnitColor("mouseover");
			this:SetBackdropColor(r, g, b);
			--getglobal(this:GetName().."TextLeft1"):SetTextColor(r, g, b);
		else
			this:FadeOut();
		end
	elseif ( event == "CLEAR_TOOLTIP" ) then
		GameTooltip_ClearMoney();
	elseif ( event == "TOOLTIP_ADD_MONEY" ) then
		if ( arg1 == this:GetName() ) then
			SetTooltipMoney(this, arg2);
		end
	elseif ( event == "TOOLTIP_ANCHOR_DEFAULT" ) then
		GameTooltip_SetDefaultAnchor(this, UIParent);
	end

	-- Function call added 8/14/05: revert tooltip text to old style.
	if(event ~= "TOOLTIP_ADD_MONEY") then
		ClassicTooltip_Revert("mouseover");
	end
end

-- Wrapper around the normal OnHide function; this clears the tooltip lines.
-- Neccessary because my current ClassicTooltip_Revert function is somewhat clunky.
function ClassicTooltip_GameTooltip_OnHide()
	Original_GameTooltip_OnHide();
	--ClassicTooltip_Clear();
end

-- This is the UnitFrame_OnEnter function from the later releases (1600),
-- modified only by reverting the commented line (to set the backdrop instead of the text color).
-- I will continue to sync changes with future versions of this function.
function ClassicTooltip_UnitFrame_OnEnter()
	if ( SpellIsTargeting() ) then
		if ( SpellCanTargetUnit(this.unit) ) then
			SetCursor("CAST_CURSOR");
		else
			SetCursor("CAST_ERROR_CURSOR");
		end
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	-- If showing newbie tips then only show the explanation
	if ( SHOW_NEWBIE_TIPS == "1" and this:GetName() ~= "PartyMemberFrame1" and this:GetName() ~= "PartyMemberFrame2" and this:GetName() ~= "PartyMemberFrame3" and this:GetName() ~= "PartyMemberFrame4") then
		if ( this:GetName() == "PlayerFrame" ) then
			GameTooltip_AddNewbieTip(PARTY_OPTIONS_LABEL, 1.0, 1.0, 1.0, NEWBIE_TOOLTIP_PARTYOPTIONS);
			return;
		elseif ( UnitPlayerControlled("target") and not UnitIsUnit("target", "player") and not UnitIsUnit("target", "pet") ) then
			GameTooltip_AddNewbieTip(PLAYER_OPTIONS_LABEL, 1.0, 1.0, 1.0, NEWBIE_TOOLTIP_PLAYEROPTIONS);
			return;
		end
	end
	
	if ( GameTooltip:SetUnit(this.unit) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end

	this.r, this.g, this.b = GameTooltip_UnitColor(this.unit);
	GameTooltip:SetBackdropColor(this.r, this.g, this.b);
	--GameTooltipTextLeft1:SetTextColor(this.r, this.g, this.b)
	
	-- Function call added 8/14/05: revert tooltip text to old style.
	ClassicTooltip_Revert(this.unit);
end

function ClassicTooltip_TextStatusBar_OnEnter()
	TextStatusBar_UpdateTextString();
	ShowTextStatusBarText(this);
	if ( this.tooltipTitle ) then
		GameTooltip_AddNewbieTip(this.tooltipTitle, 1.0, 1.0, 1.0, this.tooltipText, 1);
	elseif ( this:GetParent() == TargetFrame ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		if ( GameTooltip:SetUnit(TargetFrame.unit) ) then
			TargetFrame.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			TargetFrame.updateTooltip = nil;
		end
		TargetFrame.r, TargetFrame.g, TargetFrame.b = GameTooltip_UnitColor(TargetFrame.unit);
		--GameTooltipTextLeft1:SetTextColor(TargetFrame.r, TargetFrame.g, TargetFrame.b);
		GameTooltip:SetBackdropColor(TargetFrame.r, TargetFrame.g, TargetFrame.b);
	end

	-- Function call added 9/13/05: revert tooltip text to old style.
	ClassicTooltip_Revert(TargetFrame.unit);
end

-- This is the UnitFrame_OnUpdate function from the later releases (1600),
-- modified only by reverting the commented line (to set the backdrop instead of the text color).
-- I will continue to sync changes with future versions of this function.
function ClassicTooltip_UnitFrame_OnUpdate(elapsed)
	if ( not this.updateTooltip ) then
		return;
	end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		if ( GameTooltip:SetUnit(this.unit) ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end
		GameTooltip:SetBackdropColor(this.r, this.g, this.b);
		--GameTooltipTextLeft1:SetTextColor(this.r, this.g, this.b);
	else
		this.updateTooltip = nil;
	end
end

-- This appears to do everything the above function can do.
--
-- Player tooltip:
-- Name
-- Race Class
-- Level #
--
-- NPC tooltip (with description):
-- Name
-- Description
-- Level # [CreatureType]
--
-- NPC tooltip (without description):
-- Name
-- Level # [CreatureType]
function ClassicTooltip_Revert(unit)
	local name, race, class, level, creaturetype;
	local r = nil;
	local g = nil;
	local b = nil;

	-- I think this is a decent way to ignore all non-player-NPC tooltips
	-- Works to fix the item comparison tooltips
	if(not UnitClass(unit)) then
		return;
	end
	
	-- Save off data from the tooltip if we're on an NPC, since we can't get stuff like NPC description without screenscraping
	local description = nil;
	if(not UnitIsPlayer(unit) and GameTooltipTextLeft2:GetText() and string.find(GameTooltipTextLeft2:GetText(),"^Level")) then
		-- Assume there's no description
		description = nil;
	else
		description = GameTooltipTextLeft2:GetText();
	end

	for i = 1, GameTooltip:NumLines() do
		if(string.find(getglobal("GameTooltipTextLeft" .. i):GetText(),"Skinnable")) then
			r, g, b = getglobal("GameTooltipTextLeft" .. i):GetTextColor();
		end
	end
	
	-- Now clear the tooltip, so we have a clean slate to drawn on
	GameTooltip:ClearLines();

	-- Set the unit's level
	if(UnitLevel(unit) == -1) then
		level = "??";
	else
		level = UnitLevel(unit);
	end

	-- Set the unit's name, race, class
	name = UnitName(unit);
	race = UnitRace(unit);
	class = UnitClass(unit);

	-- Construct the lines
	if(UnitIsPlayer(unit)) then
		GameTooltip:AddLine(name);
		GameTooltip:AddLine(race .. " " .. class,1,1,1);
		GameTooltip:AddLine("Level " .. level,1,1,1);
	else
		GameTooltip:AddLine(name);

		if(description) then
			GameTooltip:AddLine(description,1,1,1);
		end
		
		if(UnitLevel(unit) > 0) then
			-- Add the elite +
			if(UnitClassification(unit) == "elite" or UnitClassification(unit) == "rareelite") then
				level = level .. "+";
			end
		else
			if(UnitClassification(unit) == "worldboss") then
				level = "??+";
			else
				level = "??";
			end
		end
		
		if(UnitIsDead(unit)) then
			GameTooltip:AddLine("Level " .. level .. " Corpse",1,1,1);
			if(r and g and b) then
				GameTooltip:AddLine("Skinnable",r,g,b);
			end
		elseif(UnitReaction(unit, "player") and (UnitReaction(unit, "player") < 5)) then
			local creatureType = UnitCreatureType(unit);
			if(creatureType == "Not specified") then
				-- Handle the Ooze case, by adding a "Ooze" type
				if(string.find(UnitName(unit),"Ooze") or string.find(UnitName(unit),"Sludge") or string.find(UnitName(unit),"Slime")) then
					creatureType = "Ooze";
				-- Handle the Zukk'ash insects in Feralas
				elseif(string.find(UnitName(unit),"^Zukk'ash") or string.find(UnitName(unit),"^Centipaar")) then
					creatureType = "Insect";
				elseif(string.find(UnitName(unit), "Constrictor Vine") or string.find(UnitName(unit), "Barbed Lasher")) then
					creatureType = "Plant";
				end
			end
			GameTooltip:AddLine("Level " .. level .. " " .. creatureType,1,1,1);
		else
			GameTooltip:AddLine("Level " .. level,1,1,1);
		end
	end

	-- Resize the tooltip
	local maxWidth = 0;
	for i = 1, GameTooltip:NumLines() do
		local line = getglobal("GameTooltipTextLeft" .. i);
		if(line:GetWidth() > maxWidth) then
			maxWidth = line:GetWidth();
		end
	end

    if(UnitIsPlayer(unit)) then
        -- This still doesn't solve the padding issue on pet tooltips.
        -- FIXME: I'd rather flip this function around:
        -- if(UnitIsNPC(unit)) then ... etc.
        GameTooltip:SetHeight(GameTooltip:NumLines()*17+10);
    else
        GameTooltip:SetHeight(GameTooltip:NumLines()*17+12);
    end
	GameTooltip:SetWidth(maxWidth+24);
end

function ClassicTooltip_Clear()
	local lines = GameTooltip:NumLines();

	for i = 1, lines do
			getglobal("GameTooltipTextLeft" .. i):Hide();
			getglobal("GameTooltipTextLeft" .. i):SetText(nil);
	end
end
		
