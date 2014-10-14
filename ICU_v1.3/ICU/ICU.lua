--[[
History:

Version 1.3 - Massive graphical update, you can now mouseover dots while holding ctrl to automatically aquire them.
Version 1.2 - Sorren's modded
- Added the ability to more easily change the docking behavior and the announce behavior
1.2.1
- Added aquiring indoor units. Turns out that the color was part of the string, and that's why it futzed up.

Version 1.2 (10 Feb 2005)
- Added ReadMe.txt
- Added health percentage to player targets in dialog display.
- Removed "PLAYER: -" from player targets in dialog display. ICU is made for PvP, too much information is not good.
- Tweaked somewhat, and added more comments. It seems declaring local global table causes memory leaks in LUA.
- Added ##OptionalDeps: MapNotes to the toc file. It should work with Cosmo MapNotes. Thanks to Diungo on curse-gaming.com

Version 1.1 (28 Jan 2005)
- Fixed bug with crashing when targetting indoor units.

Version 1.0 (26 Jan 2005)
- Initial release.

Known issues:
This Addon works great as a targetting mechanism in PvP but very poorly
in PvE. A word of warning, refrain from clicking on a bunch of mob blips
on the radar while in combat. One to three mob blips should be fine.
Otherwise, you may just end up shooting something else and draw aggro.

TargetByName() works by taking a provided name string, and searches for
the a target nearest to the player. However, NPC names (mobs included) are
NOT unique. So you will see many odd behaviour when you attempt to target
NPCs. This cannot be help unless Blizzard provides some better targetting
mechanism.

As it is, this Addon provides sufficient advantages to the Hunter Class
in PvP for the Battlegrounds. That was my goal.
]]

------------------------------------------------------------------------------
-- Globals
------------------------------------------------------------------------------

-- Version
ICU_VERSION = "Sorren's modded 1.2.1";

-- Maximum number of lines for the popup menu, as defined in the XML file.
ICU_MAX_LINES = 10;

ICU_CLASSES = {
	["Warrior"] = { .25, 0, 0, .25; },
	["Mage"] = { .5, .25, 0, .25; },
	["Rogue"] = { .75, .5, 0, .25; },
	["Druid"] = { 1, .75, 0, .25; },
	["Hunter"] = { .25, 0, .25, .5; },
	["Shaman"] = { .5, .25, .25, .5; },
	["Priest"] = { .75, .5, .25, .5; },
	["Warlock"] = { 1, .75, .25, .5; },
	["Paladin"] = { .25, 0, .5, .75; }
};
	

-- Last known ping position
ICU_PING_X = 0;
ICU_PING_Y = 0;

local icu_prevtooltip = nil;

------------------------------------------------------------------------------
-- OnFoo() functions
------------------------------------------------------------------------------

function ICU_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	-- Function hook. ICU depends on Blizzard's
	-- Minimap_OnClick() event function to activate.
	lOriginal_Minimap_OnClick_Event = Minimap_OnClick;
	Minimap_OnClick = ICU_Minimap_OnClick_Event;

	-- Inform user ICU is loaded.
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage( "ICU " .. ICU_VERSION .. " AddOn loaded" );
	end
	
	SlashCmdList["ICU"] = function(msg)
		ICU_Slash(msg);
	end
	
	SLASH_ICU1 = "/icu";
	SLASH_ICU2 = "/ICU";

end

function ICU_Slash(msg)
	msg = string.upper(msg);
	if( string.find( msg, "ANNOUNCE" ) ) then
		for announce in string.gfind( msg, "ANNOUNCE (%a+)" ) do
			if( announce == "RAID" ) or ( announce == "PARTY" ) or (announce == "SAY" ) or ( announce == "YELL" ) or ( announce == "SELF" ) or ( announce == "OFF" ) or ( announce == "PR" ) then
				ICUvars.announce = announce;
				DEFAULT_CHAT_FRAME:AddMessage("ICU announce set to: "..ICUvars.announce, 1, 1, 1 );
			else
				DEFAULT_CHAT_FRAME:AddMessage("ICU: Invalid announce.", 1, 1, 1 );
				DEFAULT_CHAT_FRAME:AddMessage("ICU: Valid announces are: pr, say, yell, party, raid, self, off", 1, 1, 1 );
			end
		end
	elseif( string.find( msg, "ANCHOR" ) ) then
		for anchor in string.gfind( msg, "ANCHOR (%a+)" ) do
			if (anchor == "TOP") or (anchor == "TOPLEFT") or (anchor == "TOPRIGHT") or (anchor == "BOTTOM") or (anchor == "BOTTOMRIGHT") or (anchor == "BOTTOMLEFT") or (anchor == "RIGHT") or (anchor == "LEFT") then
				ICUvars.anchor = anchor;
				ICU_SetPoints();
				DEFAULT_CHAT_FRAME:AddMessage("ICU anchor Set to: "..ICUvars.anchor, 1, 1, 1 );
			else
				DEFAULT_CHAT_FRAME:AddMessage("ICU: Invalid anchor.", 1, 1, 1 );
				DEFAULT_CHAT_FRAME:AddMessage("ICU: Valid anchors are: top, topright, topleft, bottom, bottomright, bottomleft.", 1, 1, 1 );
			end
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("ICU: Sorrens version. 1.2.1", 1, 1, 1 );
		DEFAULT_CHAT_FRAME:AddMessage("ICU: /icu announce (pr, raid, party, yell, say, self, off)", 1, 1, 1 );
		DEFAULT_CHAT_FRAME:AddMessage("ICU: Sets who you will announce to. PR will announce to raid, party or self depending on whether you're in a raid/party or not.", 1, 1, 1 );
		DEFAULT_CHAT_FRAME:AddMessage("ICU: /icu anchor (topleft, topright, top, bottomleft, bottomright, bottom)", 1, 1, 1 );
		DEFAULT_CHAT_FRAME:AddMessage("ICU: Sets where the popup menu will appear in relation to the minimap", 1, 1, 1 );
		DEFAULT_CHAT_FRAME:AddMessage("ICU: Current settings", 1, 1, 1 );
		DEFAULT_CHAT_FRAME:AddMessage("ICU: Announce: "..ICUvars.announce.." Anchor: "..ICUvars.anchor, 1, 1, 1 );
	end
end

				


function ICU_OnEvent(event)
	if( event == "VARIABLES_LOADED" ) then
		if( not ICUvars ) then
			ICUvars = {};
			ICUvars.anchor = "BOTTOMRIGHT";
			ICUvars.announce = "PR";
		end
		ICU_SetPoints();
		
	end
end

function ICU_SetPoints()
	ICU_Popup:ClearAllPoints();
	if( ICUvars.anchor == "BOTTOMRIGHT" ) then
		ICU_Popup:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", 0, 0 );
	elseif( ICUvars.anchor == "TOPRIGHT" ) then
		ICU_Popup:SetPoint("BOTTOMRIGHT", "MinimapCluster", "TOPRIGHT", 0, 0 );
	elseif( ICUvars.anchor == "BOTTOM" ) then
		ICU_Popup:SetPoint("TOP", "MinimapCluster", "BOTTOM", 0, 0 );
	elseif( ICUvars.anchor == "TOP" ) then
		ICU_Popup:SetPoint("BOTTOM", "MinimapCluster", "TOP", 0, 0 );
	elseif( ICUvars.anchor == "BOTTOMLEFT" ) then
		ICU_Popup:SetPoint("TOPLEFT", "MinimapCluster", "BOTTOMLEFT", 0, 0 );
	elseif( ICUvars.anchor == "TOPLEFT" ) then
		ICU_Popup:SetPoint("BOTTOMLEFT", "MinimapCluster", "TOPLEFT", 0, 0 );
	elseif( ICUvars.anchor == "RIGHT" ) then
		ICU_Popup:SetPoint("RIGHT", "MinimapCluster", "LEFT", 0, 0 );
	elseif( ICUvars.anchor == "LEFT" ) then
		ICU_Popup:SetPoint("LEFT", "MinimapCluster", "RIGHT", 0, 0 );
	end
end
		

function ICU_Popup_OnUpdate()
	-- Called every tick when popup is activated. Clears the popup menu if mouse is not over it or the Minimap.
	if( not MouseIsOver( MinimapCluster ) and not MouseIsOver( ICU_Popup ) ) then
		ICU_Clear_Popup();
	end
end

function ICU_ButtonClick()

	if( string.len( this.ICU_DATA ) ~= string.len( this:GetText() ) ) then
		-- Squelch error messages
		local lOriginal_ERR_UNIT_NOT_FOUND = ERR_UNIT_NOT_FOUND;
		local lOriginal_ERR_GENERIC_NO_TARGET = ERR_GENERIC_NO_TARGET;
		ERR_UNIT_NOT_FOUND = "";
		ERR_GENERIC_NO_TARGET = "";

		-- Target selection
		TargetByName( this.ICU_DATA );

		-- Don't target dead units, better off having no targets
		if( UnitIsDead( "target" ) ) then
			ClearTarget();
		end

		-- Ping the last known location of selected target.
		if( not IsControlKeyDown() ) then 
			Minimap:PingLocation( ICU_PING_X, ICU_PING_Y );
	
			-- Display the target in party chatbox if player is in a party
			if( ICUvars.announce ~= "SELF" ) and (ICUvars.announce ~= "OFF") then
				if( ICUvars.announce ~= "PR" ) then
					SendChatMessage( "ICU -> " .. this:GetText() .. ".", ICUvars.announce );
				else
					if( GetNumRaidMembers() > 0 ) then
						SendChatMessage( "ICU -> " .. this:GetText() .. ".", "RAID" );
					elseif ( GetNumPartyMembers() > 0 ) then
						SendChatMessage( "ICU -> " .. this:GetText() .. ".", "PARTY" );
					else
						DEFAULT_CHAT_FRAME:AddMessage("ICU ->  " .. this:GetText() .. ".", 1, 1, 1 );
					end
				end
			elseif( ICUvars.announce == "SELF" ) then
				DEFAULT_CHAT_FRAME:AddMessage("ICU ->  " .. this:GetText() .. ".", 1, 1, 1 );
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("ICU ->  " .. this:GetText() .. ".", 1, 1, 1 );
		end

		ERR_UNIT_NOT_FOUND = lOriginal_ERR_UNIT_NOT_FOUND;
		ERR_GENERIC_NO_TARGET = lOriginal_ERR_GENERIC_NO_TARGET;

	end

end

------------------------------------------------------------------------------
-- OnFoo() hooked function
------------------------------------------------------------------------------

function ICU_Minimap_OnClick_Event()
	if( IsShiftKeyDown() ) then
		-- SHIFT key is pressed, returns control to original function.
		lOriginal_Minimap_OnClick_Event();
	else
		-- Shift key is up
		if ( GameTooltip:IsVisible() ) then

			-- Grab the cursor x/y position within Minimap and saves it
			local x, y = GetCursorPosition();
			x = x / Minimap:GetEffectiveScale();
			y = y / Minimap:GetEffectiveScale();
		
			local cx, cy = Minimap:GetCenter();
			ICU_PING_X = x + CURSOR_OFFSET_X - cx;
			ICU_PING_Y = y + CURSOR_OFFSET_Y - cy;

			-- Clear all display
			ICU_Clear_Popup();

			-- Grab the tooltip and send it to be processed
			ICU_Process_Tooltip( GameTooltipTextLeft1:GetText() );

			-- Play a clicky sound
			PlaySound( "UChatScrollButton" );

		end
	end

end

------------------------------------------------------------------------------
-- Internal functions
------------------------------------------------------------------------------

-- Receives the tooltip and process it. Tooltip is in this format:
-- "Target1" or "Target1\nTarget2\nTarget3\nTarget4"
function ICU_Process_Tooltip( tooltip, silent )

	local pos = 0;
	local width = 0;
	local result_line, r, g, b, target, class, health, rank;
	local prev_trg = nil;

	-- Hook the functions TargetFrame_OnShow() and TargetFrame_OnHide() in TargetFrame.lua
	-- The purpose is to stop it from playing sound when we cycle targets. Playing targetting
	-- sound while cycling targets makes the CPU crawl.
    local lOriginal_TargetFrame_OnShow_Event = TargetFrame_OnShow;
    local lOriginal_TargetFrame_OnHide_Event = TargetFrame_OnHide;
    TargetFrame_OnShow = ICU_TargetFrame_OnShow_Event;
    TargetFrame_OnHide = ICU_TargetFrame_OnHide_Event;
	local lOriginal_ERR_UNIT_NOT_FOUND = ERR_UNIT_NOT_FOUND;
	local lOriginal_ERR_GENERIC_NO_TARGET = ERR_GENERIC_NO_TARGET;
	ERR_UNIT_NOT_FOUND = "";
	ERR_GENERIC_NO_TARGET = "";

	prev_trg = UnitName( "target" );
	ClearTarget();

	-- Grabs anything that's not control character \newline
	-- one at a time within the following loop
	for target in string.gfind( tooltip, "[^\n]*" ) do

		-- string.gfind will return an empty string when it
		-- encounters "not \newline", skip it
		if( string.len( target ) > 0 ) then

			-- Get all information from a single target
			result_line, class, health, rank, r, g, b = ICU2_Process_Trg( target );
			--DEFAULT_CHAT_FRAME:AddMessage(result_line.." "..class.." "..health);
			-- Bad targets receive bad result
			if( result_line ~= nil ) then
				-- The target's position on popup menu
				pos = pos + 1;
				if( not health ) then
					health = 0;
				end
				-- Get the button position and display the result_line
				local button = getglobal("ICU_PopupButton"..pos.."Button");
				local bar = getglobal("ICU_PopupButton"..pos.."ButtonBar");
				local bg = getglobal("ICU_PopupButton"..pos.."ButtonBGBar");
				local ranktex = getglobal("ICU_PopupButton"..pos.."ButtonRankIcon");
			
				SetPortraitTexture(getglobal("ICU_PopupButton"..pos.."ButtonPortraitIcon"), "target");
				if( ICU_CLASSES[class] ) then
					getglobal("ICU_PopupButton"..pos.."ButtonClassIcon"):SetTexCoord(unpack(ICU_CLASSES[class]));
				else
					getglobal("ICU_PopupButton"..pos.."ButtonClassIcon"):SetTexCoord(0, .25, 0, .25);
				end
				getglobal("ICU_PopupButton"..pos.."ButtonClassIcon"):SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
				if( rank ) and (rank ~= 0 ) then
					ranktex:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank", rank-4));
					ranktex:Show();
				else	
					ranktex:Hide();
				end
				getglobal("ICU_PopupButton"..pos):SetBackdropBorderColor(r, g, b);
				bar:SetStatusBarColor( r, g, b, 0.75 );
				bar:SetValue( health );
				bg:SetStatusBarColor( r, g, b, 0.1 );
				button:SetTextColor ( r+0.3, g+0.3, b+0.3 );
				button:SetText( result_line );

				-- Store name of Target in self defined slot
				button.ICU_DATA = target;
				button:GetParent():Show();
				button:Show();

				-- Get the width of the longest result_line
				local w = button:GetTextWidth();
				if( w > width ) then
					width = w;
				end
			end
			
			ClearTarget();
		end

		-- Process at most 10 lines as defined in the xml.
		if( pos >= ICU_MAX_LINES ) then
			break
		end;
	end

	-- Returns to original target if it exist.
	if( prev_trg ) then
		TargetByName( prev_trg );
		if( not UnitExists( "target" ) or not UnitName( "target" ) ) then
			ClearTarget();
		end
	else
		ClearTarget();
	end

	-- We are done, unhook the functions
    TargetFrame_OnShow = lOriginal_TargetFrame_OnShow_Event;
    TargetFrame_OnHide = lOriginal_TargetFrame_OnHide_Event;
	ERR_UNIT_NOT_FOUND = lOriginal_ERR_UNIT_NOT_FOUND;
	ERR_GENERIC_NO_TARGET = lOriginal_ERR_GENERIC_NO_TARGET;

	-- Show popup iff there is something to show.
	if( pos > 0 ) then
		ICU_Display_Popup( pos, width+10 );
	else
		ICU_Clear_Popup();
	end
end

-- Attempts to gather information on trg
function ICU2_Process_Trg( trg )
	
	--strips color information for targets that are inside
	for name in string.gfind( trg, "|c%x%x%x%x%x%x%x%x([^|]+)|r" ) do 
		--DEFAULT_CHAT_FRAME:AddMessage( name );
		trg = name;
	end
	
	local result_strn = nil;
	local health, rank;

	TargetByName( trg );

	if ( UnitExists ( "target" ) and UnitName( "target" ) ) then

		result_strn = trg .. " " .. UnitLevel( "target" );
		if ( UnitIsPlayer ( "target" ) ) then
			result_strn = result_strn .. " " .. UnitRace( "target" ) .. " " .. UnitClass ( "target" );
			rank = UnitPVPRank("target");
			local guildname, _, _ = GetGuildInfo( "target" );
			if( guildname ~= nil ) then
				result_strn = result_strn .. " <" .. guildname .. ">";
			end
			if UnitInParty("target") or UnitInRaid("target") then
				result_strn = result_strn .. " ["..UnitHealth( "target" ).. "/"..UnitHealthMax("target").."]";
				health = (UnitHealth("target")/UnitHealthMax("target"))*100;
			else
				result_strn = result_strn .. " [" .. UnitHealth( "target" ) .. "%]";
				health = UnitHealth("target");
			end
		else
			result_strn = "NPC:- " .. result_strn;
			result_strn = result_strn .. " [" .. UnitHealth( "target" ) .. "%]";
			health = UnitHealth("target");
		end

		-- Grab color coding of target according to Blizzard's tooltip colors.
		local r, g, b = GameTooltip_UnitColor( "target" );

		--ClearTarget();
		return result_strn, UnitClass("target"), health, rank, r, g, b;		
	end

	--ClearTarget();
	
	-- Need asserts, but anyways...
	return result_strn;
end

-- The original PlaySound(), do nothing here. Hopefully speeds up when we
-- cycle targets. Show for clarity, not really needed.
function ICU_TargetFrame_OnShow_Event()
	-- Do nothing
end

-- The original PlaySound(), remove relevant portion, but include
-- CloseDropDownMenus().
function ICU_TargetFrame_OnHide_Event()
	-- Do nothing
	CloseDropDownMenus();
end

-- Prepares the popup menu and displays it
function ICU_Display_Popup( numTrgs, width )
	-- Loop unrolled
	-- Set the width of every popup button, even if not shown
	
	--DEFAULT_CHAT_FRAME:AddMessage(width);
	for i=1, 10 do 
		getglobal("ICU_PopupButton"..i):SetWidth( width + 40 + 9 );
		getglobal("ICU_PopupButton"..i.."Button"):SetWidth( width + 40 );
		getglobal("ICU_PopupButton"..i.."ButtonBar"):SetWidth( width );
		getglobal("ICU_PopupButton"..i.."ButtonBGBar"):SetWidth( width );
	end
	--[[ICU_PopupButton1:SetWidth( width );
	ICU_PopupButton2:SetWidth( width );
	ICU_PopupButton3:SetWidth( width );
	ICU_PopupButton4:SetWidth( width );
	ICU_PopupButton5:SetWidth( width );
	ICU_PopupButton6:SetWidth( width );
	ICU_PopupButton7:SetWidth( width );
	ICU_PopupButton8:SetWidth( width );
	ICU_PopupButton9:SetWidth( width );
	ICU_PopupButton10:SetWidth( width );]]

	-- Set the width for the menu.
	ICU_Popup:SetWidth( width + 40 + UNITPOPUP_BORDER_WIDTH );

	-- Set the height for the menu.
	ICU_Popup:SetHeight( ( numTrgs * ICU_PopupButton1:GetHeight() ) + 12 );

	-- Shows the popupmenu
	ICU_Popup:Show();
end

-- Clears all text in buttons, hides all buttons and hides popup menu.
function ICU_Clear_Popup()
	
	-- Loop unrolled
	for i=1, 10 do
		getglobal("ICU_PopupButton"..i.."Button"):SetText("");
		getglobal("ICU_PopupButton"..i).ICU_DATA = "";
		getglobal("ICU_PopupButton"..i):Hide();
	end
	--[[
	ICU_PopupButton1:SetText( "" );
	ICU_PopupButton2:SetText( "" );
	ICU_PopupButton3:SetText( "" );
	ICU_PopupButton4:SetText( "" );
	ICU_PopupButton5:SetText( "" );
	ICU_PopupButton6:SetText( "" );
	ICU_PopupButton7:SetText( "" );
	ICU_PopupButton8:SetText( "" );
	ICU_PopupButton9:SetText( "" );
	ICU_PopupButton10:SetText( "" );
	ICU_PopupButton1.ICU_DATA = "";
	ICU_PopupButton2.ICU_DATA = "";
	ICU_PopupButton3.ICU_DATA = "";
	ICU_PopupButton4.ICU_DATA = "";
	ICU_PopupButton5.ICU_DATA = "";
	ICU_PopupButton6.ICU_DATA = "";
	ICU_PopupButton7.ICU_DATA = "";
	ICU_PopupButton8.ICU_DATA = "";
	ICU_PopupButton9.ICU_DATA = "";
	ICU_PopupButton10.ICU_DATA = "";
	ICU_PopupButton1:Hide();
	ICU_PopupButton2:Hide();
	ICU_PopupButton3:Hide();
	ICU_PopupButton4:Hide();
	ICU_PopupButton5:Hide();
	ICU_PopupButton6:Hide();
	ICU_PopupButton7:Hide();
	ICU_PopupButton8:Hide();
	ICU_PopupButton9:Hide();
	ICU_PopupButton10:Hide();]]
	ICU_Popup:Hide();
end

function ICU_MouseOverUpdate()
	if( ICUvars.mouseOver ) and ( IsControlKeyDown() ) and ( MouseIsOver(MinimapCluster) ) and ( GetMouseFocus():GetName() == "Minimap" ) then
		if( GameTooltip:IsVisible() ) then
			if( GameTooltipTextLeft1:GetText() ~= icu_prevtooltip ) then
				ICU_Clear_Popup();
				icu_prevtooltip = GameTooltipTextLeft1:GetText()
				ICU_Minimap_OnClick_Event();
			end	
		end
	end
end

