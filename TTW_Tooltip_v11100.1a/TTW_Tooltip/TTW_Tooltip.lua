--[[

	Tooltip Wrangler
	
	- Allows the user to move the tooltips freely about the screen.  
	Works great with most other tooltip mod programs including AF_Tooltip and GypsyMod.
	
]]

--------------------------------------------------------------------------------------------------
-- Localizable strings
--------------------------------------------------------------------------------------------------
local TTW_LOCK;
local TTW_UNLOCK;
local TTW_HELP;
local TTW_FOLLOWMOUSE;
local TTW_USETARGET;
local TTW_RESET;
local TTW_ENABLE;
local TTW_DISABLE;
local TTW_ANCHOR;
local TTW_OFFSET;
local TTW_SCALE;
local TTW_ATTACH;
local TTW_LOCKED;
local TTW_UNLOCKED;
local TTW_INVALID;
local TTW_TARGET_MSG;
local TTW_MOUSE_MSG;
local TTW_DISABLE_MSG;
local TTW_ENABLE_MSG;
local TTW_ATTACH_MSG;
local TTW_HELP_MSGS;
local TTW_ANCHOR_INFO_MSG;
local TTW_OWNER_INFO_MSG;
local TTW_BUTTON_TOOLTIPS;
local TTW_ANCHOR_LOCALIZED;

local TTW_LOCALIZATION = GetLocale();
if( TTW_LOCALIZATION == "NEED TRANSLATIONS" ) then
else --Default translation - ENGLISH
	TTW_USETARGET = "target";
	TTW_LOCK = TTW_USETARGET.."lock";		-- must be lowercase; locks the window in position
	TTW_UNLOCK = TTW_USETARGET.."unlock";		-- must be lowercase; unlocks the window so that it can be dragged
	TTW_HELP = "help";
	TTW_FOLLOWMOUSE = "mouse";
	TTW_ENABLE = "enable";
	TTW_DISABLE = "disable";
	TTW_ATTACH = "owner";

	TTW_RESET = "reset";
	TTW_ANCHOR = "anchor";
	TTW_OFFSET = "offset";
	TTW_SCALE = "scale";

	TTW_LOCKED = "Tooltip Wrangler: Locked in place.";
	TTW_UNLOCKED = "Tooltip Wrangler: Unlocked.  Position at will.";
	TTW_INVALID = "Tooltip Wrangler: Invalid command. Type /ttw help for a list of valid commands.";
	TTW_TARGET_MSG = "Tooltip Wrangler: Tooltips have been placed at %s.";
	TTW_MOUSE_MSG = "Tooltip Wrangler: Tooltips have been placed at the cursor.";
	TTW_DISABLE_MSG = "Tooltip Wrangler: Disabled.";
	TTW_ENABLE_MSG = "Tooltip Wrangler: Enabled.";
	TTW_ATTACH_MSG = "Tooltip Wrangler: Attach to owner if able is %s.";
	TTW_ANCHOR_INFO_MSG = "Tooltip Wrangler:\n  Attached to: %s\n  Anchored by: %s\n  Offsets: %d, %d\n  Scale: %f";
	TTW_OWNER_INFO_MSG = "  Owner anchored by:  %s\n  Owner offsets: %d, %d\n  Scale: %f";
	TTW_HELP_MSGS = {
		"Tooltip Wrangler: Below is a listing of valid commands \(use /ttw <command>\):",
		"disable: Disables the addon.",
		"enable: Enables the addon.",
		"help: Lists valid Tooltip Wrangler commands.",
		"mouse [<cursor|default>]: Attach the tooltip to the mouse cursor.",
		"mouseanchor <position>: set corner tooltip anchors from.",
		"mouseoffset <x> <y>: set mouse offset to x, y.",
		"mousereset: Resets the owner anchor settings.",
		"mousescale <scale>: Sets scale for mouse tooltip.",
		"owner [<frame|default|smart>]: toggle to attach tooltip to owner if able.",
		"owneranchor <position>: set corner tooltip anchors from.",
		"owneroffset <x> <y>: set attach offset to x, y.",
		"ownerreset: Resets the owner anchor settings.",
		"ownerscale <scale>: Sets scale for owner tooltip.",
		"target [<frame|default>]: Target to with the tooltip will stick.",
		"targetanchor <position>: set corner tooltip anchors from.",
		"targetlock: Lock the tooltip in place \(hides the placement window\).",
		"targetoffset <x> <y>: set target offset to x, y.",
		"targetreset: Resets the target anchor settings.",
		"targetscale <scale>: Sets scale for target tooltip.",
		"targetunlock: Unlock the tooltip placement window \(Shows the placement window\).",
	};

	--must remain in the same order of the IDs given to the anchor buttons in XML
	TTW_BUTTON_TOOLTIPS = {
		"Anchor the \"Top Left\" corner of the\ntooltip to the center of the target.\n\(Right and Bottom edges will grow\)",
		"Anchor the \"Top Right\" corner of the\ntooltip to the center of the target.\n\(Left and Bottom edges will grow\)",
		"Anchor the \"Bottom Left\" corner of the\ntooltip to the center of the target.\n\(Right and Top edges will grow\)",
		"Anchor the \"Bottom Right\" corner of the\ntooltip to the center of the target.\n\(Left and Top edges will grow\)",
		"Anchor the \"Top Center\" side of the\ntooltip to the center of the target.\n\(Bottom, Left and Right edges will grow\)",
		"Anchor the \"Bottom Center\" side of the\ntooltip to the center of the target.\n\(Top, Left and Right edges will grow\)",
		"Anchor the \"Left Center\" side of the\ntooltip to the center of the target.\n\(Top, Bottom and Right edges will grow\)",
		"Anchor the \"Right Center\" side of the\ntooltip to the center of the target.\n\(Top, Bottom and Left edges will grow\)",
		"Anchor the \"Center\" of the\ntooltip to the center of the target.\n\(All edges will grow\)",
	};

	--must remain in the same order of the IDs given to the anchor buttons in XML
	TTW_ANCHOR_LOCALIZED = {
		"topleft",
		"topright",
		"bottomleft",
		"bottomright",
		"top",
		"bottom",
		"left",
		"right",
		"center",
	};
end

--------------------------------------------------------------------------------------------------
-- Local Variables
--------------------------------------------------------------------------------------------------
local TTW_MOUSE	= 0;
local TTW_TARGET = 1;

local TTW_ISHOVERING = false;
local TTW_ISOWNED = nil;

local TTW_UIP;
local TTW_SAVESTATE = {};

--Anchor, flipAnchor, athX, athY, anchorX, anchorY
--must remain in the same order of the IDs given to the anchor buttons in XML
local TTW_ANCHOR_INFO = {
	{ "TOPLEFT", "BOTTOMRIGHT", -1, 1, "LEFT", "TOP" },
	{ "TOPRIGHT", "BOTTOMLEFT", 1, 1, "RIGHT", "TOP" },
	{ "BOTTOMLEFT", "TOPRIGHT", -1, -1, "LEFT", "BOTTOM" },
	{ "BOTTOMRIGHT", "TOPLEFT", 1, -1, "RIGHT", "BOTTOM" },
	{ "TOP", "BOTTOM", 0, 1, "", "TOP" },
	{ "BOTTOM", "TOP", 0, -1, "", "BOTTOM" },
	{ "LEFT", "RIGHT", -1, 0, "LEFT", "" },
	{ "RIGHT", "LEFT", 1, 0, "RIGHT", "" },
	{ "CENTER", "CENTER", 0, 0, "", "" },
};

--Saved functions
local oldGameTooltip_SDA;
local oldGameTooltipHide;
local oldGameTooltipSetOwner;

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

local function TTW_PositionTooltip(tooltip, parent)
	tooltip:SetOwner(parent, "ANCHOR_NONE");
	if( TTWState.AttachIfAble and parent ~= "UIParent" and parent ~= UIParent ) then
		local target = nil;
		local anchor = TTWState.ownerAnchor;
		local flip = TTW_ANCHOR_INFO[anchor][2];
		local athX = TTW_ANCHOR_INFO[anchor][3];
		local athY = TTW_ANCHOR_INFO[anchor][4];
		local ancX = TTW_ANCHOR_INFO[anchor][5];
		local ancY = TTW_ANCHOR_INFO[anchor][6];
		--anchor = TTW_ANCHOR_INFO[anchor][1];
		if( TTWState.ownerScale ) then
			tooltip:SetScale(TTWState.ownerScale);
		else
			tooltip:SetScale(1.0);
		end
		local scale = tooltip:GetEffectiveScale();
		local xPos, yPos =  TTWState.ownerXOffset, TTWState.ownerYOffset;
		TTW_ISHOVERING = false;
		TTW_ISOWNED = nil;
		local getSmart = false;
		target = type(parent) == "table" and parent or getglobal(parent);
		if( TTWState.ownerTarget ) then --smart positioning
			local temptarget = getglobal(TTWState.ownerTarget);
			if( not temptarget ) then
				getSmart = true;
			else
				target = temptarget;
			end
		end
		TTW_SAVESTATE.lastOwner = target:GetName();

		if( getSmart ) then
			local width = tooltip:GetWidth() * scale;
			local height = tooltip:GetHeight() * scale;
			local leftOwn = target:GetLeft();
			local rightOwn = target:GetRight();
			local topOwn = target:GetTop();
			local bottomOwn = target:GetBottom();
			--anchor position check
			if( athX == -1 ) then
				if( xPos + rightOwn + width > TTW_UIP.right ) then --right side check
					ancX = "RIGHT";
					xPos = 0;
				end
			elseif( athX == 1 ) then
				if( xPos + leftOwn - width < TTW_UIP.left ) then --left side check
					ancX = "LEFT";
					xPos = 0;
				end
			elseif( athX == 0 ) then
				width = math.floor(width / 2); --only dealing with half width if top or bottom anchor
				if( xPos + leftOwn - width < TTW_UIP.left ) then --left side check
					ancX = "LEFT";
					xPos = 0;
				end
				if( xPos + rightOwn + width > TTW_UIP.right ) then --right side check
					ancX = "RIGHT";
					xPos = 0;
				end
			end
			if( athY == -1 ) then
				if( yPos + topOwn + height > TTW_UIP.top ) then --top side check
					ancY = "TOP";
					yPos = 0;
				end
			elseif( athY == 1 ) then
				if( yPos + bottomOwn - height < TTW_UIP.bottom ) then --bottom side check
					ancY = "BOTTOM";
					yPos = 0;
				end
			elseif( athY == 0 ) then
				height = math.floor(height / 2); --only dealing with half height if left or right anchor
				if( yPos + bottomOwn - height < TTW_UIP.bottom ) then --bottom side check
					ancY = "BOTTOM";
					yPos = 0;
				end
				if( yPos + topOwn + height > TTW_UIP.top ) then --top side check
					ancY = "TOP";
					yPos = 0;
				end
			end
		end
		anchor = ancY .. ancX;

		tooltip:ClearAllPoints();
		tooltip:SetPoint(anchor, target:GetName(), flip, xPos, yPos);
	elseif(TTWState.AnchorType == TTW_MOUSE) then
		if( TTWState.mouseScale ) then
			tooltip:SetScale(TTWState.mouseScale);
		else
			tooltip:SetScale(1.0);
		end
		local scale = tooltip:GetEffectiveScale();
		TTW_SAVESTATE.lastOwner = "UIParent";
		TTW_ISOWNED = nil;
		if( TTWState.mouseTarget ) then
			TTW_ISHOVERING = false;

			tooltip:SetOwner(parent, "ANCHOR_CURSOR");
			if( TTWState.mouseScale ) then
				tooltip:SetScale(TTWState.mouseScale);
			else
				tooltip:SetScale(1.0);
			end
		else
			--mouse positioning setup, SetPoint in OnUpdate listener
			TTW_ISHOVERING = true;

			TTW_SAVESTATE.scale = scale;
			TTW_SAVESTATE.tooltip = tooltip;
			TTW_SAVESTATE.anchor = TTW_ANCHOR_INFO[TTWState.mouseAnchor];
			TTW_SAVESTATE.xPos = -1;
			TTW_SAVESTATE.yPos = -1;
		end
	else
		if( not TTWState.targetTarget ) then
			TTWState.targetTarget = "TTW_RecticleFrame";
		end
		if( TTWState.targetScale ) then
			tooltip:SetScale(TTWState.targetScale);
		else
			tooltip:SetScale(1.0);
		end
		local scale = tooltip:GetEffectiveScale();
		TTW_SAVESTATE.lastOwner = TTWState.targetTarget;
		TTW_ISHOVERING = false;
		TTW_ISOWNED = nil;

		local anchor = TTWState.targetAnchor;
		local flip = TTW_ANCHOR_INFO[anchor][2];
		anchor = TTW_ANCHOR_INFO[anchor][1];
		local xPos, yPos =  TTWState.targetXOffset, TTWState.targetYOffset;

		if( TTWState.targetTarget == "TTW_RecticleFrame" ) then
			flip = "CENTER";
		end

		tooltip:ClearAllPoints();
		tooltip:SetPoint(anchor, TTWState.targetTarget, flip, xPos, yPos);
	end
	tooltip.default = 1;
end

local function TTW_SetClickState(state)
	local buttons = { TTW_RecticleFrame:GetChildren() };
	for ind, button in buttons do
		if( button:GetID() == state ) then
			button:SetButtonState("PUSHED", 1);
		else
			button:SetButtonState("NORMAL", 0);
		end
	end
end

local function TTW_Reset(offType)
	TTW_ISHOVERING = false;
	TTW_ISOWNED = nil;
	local anc = offType.."Anchor";
	TTWState[anc] = 4;
	TTWState[offType.."XOffset"] = 0;
	TTWState[offType.."YOffset"] = 0;
	TTWState[offType.."Target"] = nil;
	TTWState[offType.."Scale"] = 1.0;
	if( offType == TTW_USETARGET ) then
		TTWState.targetTarget = "TTW_RecticleFrame";
		TTW_SetClickState(TTWState[anc]);
		TTW_RecticleFrame:ClearAllPoints();
		TTW_RecticleFrame:SetPoint("CENTER", "UIParent", "BOTTOMRIGHT", -200, 200);
	end
end

local function TTW_TooltipHide(frame)
	TTW_ISHOVERING = false;
	TTW_ISOWNED = nil;
	oldGameTooltipHide(frame);
end

local function TTW_TooltipSetOwner(frame, owner, anchor, x, y)
	TTW_ISHOVERING = false;
	TTW_ISOWNED = nil;
	frame:SetScale(1.0);
	oldGameTooltipSetOwner(frame, owner, anchor, x, y);
end

local function TTW_TooltipEnableAddOn(override)
	if( TTWState.Enabled and not override ) then
		DEFAULT_CHAT_FRAME:AddMessage("Tooltip Wrangler is already enabled.");
		return;
	end
	GameTooltip:Hide();
	TTWState.Enabled = true;
	TTW_ISHOVERING = false;
	TTW_ISOWNED = nil;
	if(TTWState.Lock) then
		TTW_RecticleFrame:EnableMouse(false);
		TTW_RecticleFrame:Hide();
	elseif(TTWState.AnchorType == TTW_TARGET) then
		TTW_RecticleFrame:Show();
	end
	if( GameTooltip_SetDefaultAnchor ~= TTW_PositionTooltip ) then
		oldGameTooltip_SDA = GameTooltip_SetDefaultAnchor;
		GameTooltip_SetDefaultAnchor = TTW_PositionTooltip;
	end
	if( GameTooltip.Hide ~= TTW_TooltipHide ) then
		oldGameTooltipHide = GameTooltip.Hide;
		GameTooltip.Hide = TTW_TooltipHide;
	end
	if( GameTooltip.SetOwner ~= TTW_TooltipSetOwner ) then
		oldGameTooltipSetOwner = GameTooltip.SetOwner;
		GameTooltip.SetOwner = TTW_TooltipSetOwner;
	end
	DEFAULT_CHAT_FRAME:AddMessage(TTW_ENABLE_MSG);
end

local function TTW_TooltipDisableAddOn()
	if( not TTWState.Enabled ) then
		DEFAULT_CHAT_FRAME:AddMessage("Tooltip Wrangler is already disabled.");
		return;
	end
	GameTooltip:Hide();
	TTWState.Enabled = false;
	TTW_ISHOVERING = false;
	TTW_ISOWNED = nil;
	TTW_RecticleFrame:Hide();
	if( GameTooltip_SetDefaultAnchor == TTW_PositionTooltip ) then
		GameTooltip_SetDefaultAnchor = oldGameTooltip_SDA;
		oldGameTooltip_SDA = nil;
	end
	if( GameTooltip.Hide == TTW_TooltipHide ) then
		GameTooltip.Hide = oldGameTooltipHide;
		oldGameTooltipHide = nil;
	end
	if( GameTooltip.SetOwner == TTW_TooltipSetOwner ) then
		GameTooltip.SetOwner = oldGameTooltipSetOwner;
		oldGameTooltipSetOwner = nil;
	end
	DEFAULT_CHAT_FRAME:AddMessage(TTW_DISABLE_MSG);
end

local function TTW_PrintAnchorInformation()
	local aT = ((TTWState.AnchorType == TTW_TARGET) and TTW_USETARGET or TTW_FOLLOWMOUSE);
	local bT = ((aT == TTW_USETARGET) and TTWState.targetTarget or aT);
	local cT = TTWState[aT.."Scale"] or 1.0;
	local outInfo = string.format(
									TTW_ANCHOR_INFO_MSG,
									bT,
									TTW_ANCHOR_LOCALIZED[TTWState[aT.."Anchor"]],
									TTWState[aT.."XOffset"],
									TTWState[aT.."YOffset"],
									cT
								);
	DEFAULT_CHAT_FRAME:AddMessage(outInfo);
	if( aT == TTW_FOLLOWMOUSE and TTWState.mouseTarget ) then
		DEFAULT_CHAT_FRAME:AddMessage("Mouse type cursor set, offsets ignored.");
	end
	if( not TTWState.AttachIfAble ) then
		return;
	end
	cT = TTWState.ownerScale or 1.0;
	outInfo = string.format(
							TTW_OWNER_INFO_MSG,
							TTW_ANCHOR_LOCALIZED[TTWState.ownerAnchor],
							TTWState.ownerXOffset,
							TTWState.ownerYOffset,
							cT
						);
	DEFAULT_CHAT_FRAME:AddMessage(outInfo);
end

local function TTW_SlashCommandHandler(msg)
	if( not msg or msg == "" ) then
		msg = TTW_HELP;
	end
	local tokens = {};
	string.gsub(msg, "([%S]+)", function(w) table.insert(tokens, w); end);
	local command = string.lower(tokens[1]);
	if( command == TTW_ENABLE ) then
		TTW_TooltipEnableAddOn();
		return;
	elseif( command == TTW_DISABLE ) then
		TTW_TooltipDisableAddOn();
		return;
	end
	if( not TTWState.Enabled ) then
		DEFAULT_CHAT_FRAME:AddMessage(TTW_DISABLE_MSG);
		return;
	end
	if ( command == TTW_HELP ) then
		for i, line in TTW_HELP_MSGS do
			DEFAULT_CHAT_FRAME:AddMessage(line);
		end
		return;
	elseif( command == TTW_LOCK ) then
		if( not TTWState.Lock ) then
			TTW_RecticleFrame:EnableMouse(false);
			TTW_RecticleFrame:Hide();
			TTWState.Lock = true;
			GameTooltip:Hide();
			DEFAULT_CHAT_FRAME:AddMessage(TTW_LOCKED);
		end
		return;
	elseif( command == TTW_UNLOCK ) then
		if( TTWState.Lock ) then
			TTW_RecticleFrame:EnableMouse(true);
			TTWState.Lock = nil;
			TTW_RecticleFrame:Show();
			GameTooltip:Hide();
			DEFAULT_CHAT_FRAME:AddMessage(TTW_UNLOCKED);
		end
		return;
	elseif( command == TTW_ATTACH ) then
		if( tokens[2] ) then
			TTWState.AttachIfAble = true;
			if( tokens[2] == "default" ) then
				TTWState.ownerTarget = nil;
			elseif( tokens[2] == "smart" ) then
				TTWState.ownerTarget = true;
			else
				local target = getglobal(tokens[2]);
				if( target ) then
					TTWState.ownerTarget = target:GetName();
				end
			end
		else
			TTWState.AttachIfAble = not TTWState.AttachIfAble;
		end
		TTW_PrintAnchorInformation();
		return;
	elseif( command == TTW_FOLLOWMOUSE ) then
		if( tokens[2] ) then
			if( tokens[2] == "cursor" ) then
				TTWState.mouseTarget = true;
			else
				TTWState.mouseTarget = nil;
			end
		end
		TTWState.AnchorType = TTW_MOUSE;
		TTW_RecticleFrame:Hide();
		GameTooltip:Hide();
		DEFAULT_CHAT_FRAME:AddMessage(TTW_MOUSE_MSG);
		TTW_PrintAnchorInformation();
		return;
	elseif ( command == TTW_USETARGET ) then
		if( tokens[2] ) then
			local target = getglobal(tokens[2]);
			if( tokens[2] == "default" ) then
				TTWState.targetTarget = "TTW_RecticleFrame";
			elseif( not target ) then
				TTWState.targetTarget = TTWState.targetTarget or "TTW_RecticleFrame";
			else
				TTWState.targetTarget = target:GetName();
			end
		end
		TTWState.AnchorType = TTW_TARGET;
		GameTooltip:Hide();
		TTW_PrintAnchorInformation();
		return;
	end
	local offType = string.lower(tokens[1]);
	if( string.find(offType, TTW_FOLLOWMOUSE) ) then
		offType = TTW_FOLLOWMOUSE;
	elseif( string.find(offType, TTW_ATTACH) ) then
		offType = TTW_ATTACH;
	elseif( string.find(offType, TTW_USETARGET) ) then
		offType = TTW_USETARGET;
	else
		DEFAULT_CHAT_FRAME:AddMessage(TTW_INVALID);
		return;
	end
	command = gsub(string.lower(tokens[1]), offType.."(%a+)", "%1");
	if ( command == TTW_RESET ) then
		TTW_Reset(offType);
		TTW_PrintAnchorInformation();
		return;
	elseif( command == TTW_ANCHOR ) then
		local point = string.lower(tokens[2]);
		if( not point ) then
			point = "FOO";
		end
		for index, value in TTW_ANCHOR_LOCALIZED do
			if( point == value ) then
				TTWState[offType.."Anchor"] = index;
				if( offType == TTW_USETARGET ) then
					TTW_SetClickState(index);
				end
				TTW_PrintAnchorInformation();
				return;
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage("Tooltip Wrangler: Anchor NOT changed.");
		DEFAULT_CHAT_FRAME:AddMessage("Valid anchors are:");
		DEFAULT_CHAT_FRAME:AddMessage(table.concat(TTW_ANCHOR_LOCALIZED, ", "));
		return;
	elseif( command == TTW_OFFSET ) then
		local xoff = tokens[2];
		local yoff = tokens[3];
		xoff = tonumber(xoff);
		yoff = tonumber(yoff);
		if( xoff ) then
			TTWState[offType.."XOffset"] = xoff;
		end
		if( yoff ) then
			TTWState[offType.."YOffset"] = yoff;
		end
		TTW_PrintAnchorInformation();
		return;
	elseif( command == TTW_SCALE ) then
		local scale = tokens[2];
		scale = tonumber(scale);
		DEFAULT_CHAT_FRAME:AddMessage(tokens[2].." "..scale);
		if( scale and scale > 0.0 and scale <= 2.0 ) then
			TTWState[offType.."Scale"] = scale;
		else
			TTWState[offType.."Scale"] = 1.0;
		end
		TTW_PrintAnchorInformation();
		return;
	end
	DEFAULT_CHAT_FRAME:AddMessage(TTW_INVALID);
end

--------------------------------------------------------------------------------------------------
-- Handler functions
--------------------------------------------------------------------------------------------------

--OnUpdate
function TTW_PT_ANCHOR_MOUSE(elapsed)
	if( not TTW_ISHOVERING ) then
		return;
	else --mouse positioning
		local xPos, yPos = GetCursorPosition();
		--if cursor didn't move, do nothing
		if( xPos == TTW_SAVESTATE.xPos and yPos == TTW_SAVESTATE.yPos ) then
			return;
		end
		TTW_SAVESTATE.xPos = xPos;
		TTW_SAVESTATE.yPos = yPos;
		local tooltip = TTW_SAVESTATE.tooltip;

		local scale = TTW_SAVESTATE.scale;
		local width = tooltip:GetWidth() * scale;
		local height = tooltip:GetHeight() * scale;

		local anchor = TTW_SAVESTATE.anchor[1];
		local athX = TTW_SAVESTATE.anchor[3];  -- -1 if check top of screen, 1 if check bottom, 0 if both
		local athY = TTW_SAVESTATE.anchor[4]; -- -1 if check left side of screen, 1 if check right, 0 if both

		xPos = (xPos + TTWState.mouseXOffset);
		yPos = (yPos + TTWState.mouseYOffset);

		tooltip:ClearAllPoints();
		xPos, yPos = xPos / scale, yPos / scale
		tooltip:SetPoint(anchor, "UIParent", "BOTTOMLEFT", xPos, yPos);
	end
end

--OnLoad
function TTW_TooltipOnLoad()
	--variables that do NOT change
	TTW_UIP = {};
	TTW_UIP.left = UIParent:GetLeft();
	TTW_UIP.right = UIParent:GetRight();
	TTW_UIP.top = UIParent:GetTop();
	TTW_UIP.bottom = UIParent:GetBottom();

	this:RegisterEvent("PLAYER_LOGIN");

	-- Register our slash command
	SLASH_TTW1 = "/tooltipwrangler";
	SLASH_TTW2 = "/ttw";
	SlashCmdList["TTW"] = TTW_SlashCommandHandler;
end

--OnEvent
function TTW_TooltipOnEvent(event)
	if( event == "PLAYER_LOGIN" ) then
		--load and check TTWState if available
		if( not TTWState ) then
			TTWState = {};
			TTWState.Enabled = true;
			TTWState.mouseAnchor = 4;
			TTWState.ownerAnchor = 4;
			TTWState.targetAnchor = 4;
			TTWState.AnchorType = TTW_TARGET;
			TTWState.ownerXOffset = 0;
			TTWState.ownerYOffset = 0;
			TTWState.mouseXOffset = 0;
			TTWState.mouseYOffset = 0;
			TTWState.targetXOffset = 0;
			TTWState.targetYOffset = 0;
		else
			TTWState.mouseAnchor = TTWState.mouseAnchor or 4;
			TTWState.ownerAnchor = TTWState.ownerAnchor or 4;
			TTWState.targetAnchor = TTWState.targetAnchor or 4;
			TTWState.mouseXOffset = TTWState.mouseXOffset or 0;
			TTWState.mouseYOffset = TTWState.mouseYOffset or 0;
			TTWState.ownerXOffset = TTWState.ownerXOffset or 0;
			TTWState.ownerYOffset = TTWState.ownerYOffset or 0;
			TTWState.targetXOffset = TTWState.targetXOffset or TTWState.XOffset or 0;
			TTWState.targetYOffset = TTWState.targetYOffset or TTWState.YOffset or 0;
			TTWState.Anchor = nil;
			TTWState.XOffset = nil;
			TTWState.YOffset = nil;
		end

		TTW_SetClickState(TTWState.targetAnchor);

		if(TTWState.Enabled) then
			TTW_TooltipEnableAddOn(true);
		else
			if(TTWState.Lock) then
				TTW_RecticleFrame:EnableMouse(false);
				TTW_RecticleFrame:Hide();
			end
			DEFAULT_CHAT_FRAME:AddMessage(TTW_DISABLE_MSG);
		end
		--Not really needed, just a nitpick
		this:UnregisterEvent("PLAYER_LOGIN");
	end
end

--OnMouseDown
function TTW_TooltipOnMouseDown()
	GameTooltip:Hide();
	TTW_RecticleFrame:StartMoving()
end

--OnMouseUp
function TTW_TooltipOnMouseUp()
	TTW_RecticleFrame:StopMovingOrSizing()
end

--OnClick
function TTW_AnchorButton_OnClick()
	PlaySound("igMainMenuClose");
	local ttw_id = this:GetID();
	TTW_SetClickState(ttw_id);
	TTWState.targetAnchor = ttw_id;
end

--OnEnter
function TTW_AnchorButton_Tooltip()
	local ttw_id = this:GetID();
	--ttw_id = TTW_ANCHOR_INFO[ttw_id][1];
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(TTW_BUTTON_TOOLTIPS[ttw_id]);
end
