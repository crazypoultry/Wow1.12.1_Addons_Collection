--------------------------------------------------------------------------------------------------
-- Titan [ClothTracker]
-- Author: AxaliaN (Freyalise/Evanescent on Chromaggus (EU))
-- Credits: 
-- WalleniuM for his Titan[ReagentBuff] mod.
-- Xytro for his Titan[SkinTracker] mod.
--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
-- User edit Variables (change if needed)
--------------------------------------------------------------------------------------------------

TITAN_CLOTHTRACKER_RED = 5; -- amount of cloth which gives a red value
TITAN_CLOTHTRACKER_GREEN = 10; -- amount of cloth which gives a green value

--------------------------------------------------------------------------------------------------
-- Globals Variables (do not change)
--------------------------------------------------------------------------------------------------

-- names
TITAN_CLOTHTRACKER_ID =  "ClothTracker";
TITAN_CLOTHTRACKER_VERSION = " 2.0";
TITAN_CLOTHTRACKER_BUTTON_TEXT = "%s";

-- colors
TEXT_COLOR_WHITE = "|cffffffff";
TEXT_COLOR_GOLD = "|cffCEA208";
TEXT_COLOR_RED = "|cffff0000";
TEXT_COLOR_GREEN = "|cff00ff00";

--------------------------------------------------------------------------------------------------
-- OnLoad Functions
--------------------------------------------------------------------------------------------------
function ax_OnLoad()

	TITAN_CLOTHTRACKER_BUTTON_ICON = "Interface\\Icons\\Trade_Tailoring";


	this.registry = { 
		id = TITAN_CLOTHTRACKER_ID,
		menuText = TITAN_CLOTHTRACKER_ID, 
		buttonTextFunction = "TitanPanelClothTracker_GetButtonText", 
		tooltipTitle = TITAN_CLOTHTRACKER_ID.." "..TITAN_CLOTHTRACKER_VERSION,
		tooltipTextFunction = "ax_getClothToolTip", 
		icon = TITAN_CLOTHTRACKER_BUTTON_ICON,
		iconWidth = 16,
		category = "Profession",
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredButton = TITAN_NIL,

			AlternateDisplay = 0,
		},
	};
	-- register Events to update the Buttons
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_CLOSED");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	this:RegisterEvent("MAIL_CLOSED");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");

	this:RegisterForClicks("LeftButtonUp");
end

--------------------------------------------------------------------------------------------------
-- COUNT THE NUMBER OF ITEMS
--------------------------------------------------------------------------------------------------
function ax_NameFromLink(link)
	local name
	if (link) then
		for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
			return name
		end
	end
end 

----------------------------------
-- Cloth Classes
----------------------------------
function ax_GetLinenCloth()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName ==ax_CLOTH_LINEN) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetWoolCloth()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_CLOTH_WOOL) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetSilkCloth()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_CLOTH_SILK) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetMageweaveCloth()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_CLOTH_MAGEWEAVE) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetRuneCloth()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_CLOTH_RUNE) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetMoonCloth()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_CLOTH_MOON) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetFelCloth()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_CLOTH_FEL) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

----------------------------------
-- Bolt Classes
----------------------------------

function ax_GetLinenBolt()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_BOLT_LINEN) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetWoolBolt()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_BOLT_WOOL) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetSilkBolt()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_BOLT_SILK) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetMageweaveBolt()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_BOLT_MAGEWEAVE) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end

function ax_GetRuneBolt()
	local cloth = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = ax_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
                        			if (itemName == ax_BOLT_RUNE) then
							cloth  = cloth + itemCount;
						end
					end
				end
			end            
		end
	end	
	return cloth
end


--------------------------------------------------------------------------------------------------
-- OnEvent
--------------------------------------------------------------------------------------------------

function ax_OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( TCT_SETTINGS == nil ) then
			ax_Initialize(); -- init
		end
		if ( TCT_SETTINGS["VERSION"] ~= TITAN_CLOTHTRACKER_VERSION ) then
			ax_Update(TCT_SETTINGS["VERSION"]);
		end
		TitanPanelButton_UpdateButton(TITAN_CLOTHTRACKER_ID);
		TitanPanelButton_UpdateTooltip();
		--DEFAULT_CHAT_FRAME:AddMessage(TMC_ROGUE_WOUND..TMC_NUMBER_1);
		return;
	end
	
	if (event == "VARIABLES_LOADED") then

	   ax_Msg(TITAN_CLOTHTRACKER_ID.." "..TITAN_CLOTHTRACKER_NAME_VERSION.." "..TITAN_CLOTHTRACKER_VERSION.." "..TITAN_CLOTHTRACKER_LOADED..".");
	   end
		-- update variables for button events
		if ( event == "MAIL_CLOSED") or ( event == "BAG_UPDATE") or ( event == "BANKFRAME_CLOSED") or ( event == "UNIT_INVENTORY_CHANGED") then
          TitanPanelButton_UpdateButton(TITAN_CLOTHTRACKER_ID);
		return;
	end
	
	if ( event == "SPELLCAST_STOP") or ( event == "MERCHANT_CLOSED") or ( event == "SPELLS_CHANGED") or ( event == "SPELL_UPDATE_COOLDOWN") or ( event == "MERCHANT_SHOW") then
          TitanPanelButton_UpdateButton(TITAN_CLOTHTRACKER_ID);
		return;
	end	
end

function TitanPanelClothTrackerButton_OnClick()
	if (arg1 == "LeftButton" and IsShiftKeyDown() == nil ) then
		TitanPanelClothTracker_ToggleVar_AlternateDisplay()
		TitanPanelButton_UpdateButton(TITAN_CLOTHTRACKER_ID);
		TitanPanelButton_UpdateTooltip();
	else
		TitanPanelButton_OnClick(arg1);
	end
end

function TitanPanelClothTracker_ToggleVar_AlternateDisplay()
	TitanToggleVar(TITAN_CLOTHTRACKER_ID, "AlternateDisplay");
	TitanPanelButton_UpdateButton(TITAN_CLOTHTRACKER_ID);
end

--------------------------------------------------------------------------------------------------
-- Database Functions
--------------------------------------------------------------------------------------------------

function ax_Initialize()
	ax_DEBUG("Initializing ...");
	TCT_SETTINGS = {};
	TCT_SETTINGS["VERSION"] = TITAN_CLOTHTRACKER_VERSION;
	TCT_SETTINGS["COUNT"] = 0;
	TCT_SETTINGS["TYPE"] = "cloth";
	ax_DEBUG("Initializing done !");

end

function ax_Update(version)
	ax_Msg(TITAN_CLOTHTRACKER_ID.." "..TITAN_CLOTHTRACKER_SYS_UPDATING.." "..TITAN_CLOTHTRACKER_VERSION.." !");
	if ( version == nil or version == "UNKNOWN" ) then
		ax_Initialize();
	else
		ax_Msg(TITAN_CLOTHTRACKER_SYS_NOUPDATE.." !");
		TCT_SETTINGS["VERSION"] = TITAN_CLOTHTRACKER_VERSION;
		return;
	end
	ax_Msg(TITAN_CLOTHTRACKER_SYS_UPDATE.." !");
end

function ax_Reset()
	ax_DEBUG("Resetting database ...");
	ax_Initialize();
	ax_DEBUG("Resetting done !");
end

--------------------------------------------------------------------------------------------------
-- Titan Panel Functions
--------------------------------------------------------------------------------------------------

function TitanPanelClothTracker_GetButtonText(id)
	if (TitanGetVar(TITAN_CLOTHTRACKER_ID, "AlternateDisplay") == 1) then
			local buttonText;
			buttonText = ax_ButtonColor(ax_GetLinenBolt()).."/"..ax_ButtonColor(ax_GetWoolBolt()).."/"..ax_ButtonColor(ax_GetSilkBolt()).."/"..ax_ButtonColor(ax_GetMageweaveBolt()).."/"..ax_ButtonColor(ax_GetRuneBolt());
			return TITAN_CLOTHTRACKER_BUTTON_LABEL_BOLT, buttonText;
	else
			local buttonText;
			buttonText = ax_ButtonColor(ax_GetLinenCloth()).."/"..ax_ButtonColor(ax_GetWoolCloth()).."/"..ax_ButtonColor(ax_GetSilkCloth()).."/"..ax_ButtonColor(ax_GetMageweaveCloth()).."/"..ax_ButtonColor(ax_GetRuneCloth()).."/"..ax_ButtonColor(ax_GetMoonCloth()).."/"..ax_ButtonColor(ax_GetFelCloth());
			return TITAN_CLOTHTRACKER_BUTTON_LABEL_CLOTH, buttonText;
	end
end

--------------------------------------------------------------------------------------------------
-- BuffReagent Menu
--------------------------------------------------------------------------------------------------

function TitanPanelRightClickMenu_PrepareClothTrackerMenu()
	ax_DEBUG("Preparing "..TITAN_CLOTHTRACKER_ID.." menu ...");
	local id = TITAN_CLOTHTRACKER_ID;
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText..TITAN_CLOTHTRACKER_VERSION);
	TitanPanelRightClickMenu_AddToggleIcon(id);
	TitanPanelRightClickMenu_AddToggleLabelText(id);
	TitanPanelRightClickMenu_AddSpacer();
    	
	local info = {};

	info.text = TITAN_CLOTHTRACKER_MENU_RESET;
	info.func = ax_Reset;
	UIDropDownMenu_AddButton(info);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
	ax_DEBUG("Preparing done !");
end

function TitanPanelClothTracker_ToggleColoredButton()
	TitanToggleVar(TITAN_CLOTHTRACKER_ID, "ShowColoredButton");
	TitanPanelButton_UpdateButton(TITAN_CLOTHTRACKER_ID);
end


--------------------------------------------------------------------------------------------------
-- Misc Help Functions
--------------------------------------------------------------------------------------------------

function ax_Msg(msg)
	if ( msg == nil ) then
		msg = "------------------------------";
	end
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.82, 0);
	end
end

function ax_DEBUG(msg)
	if ( msg == nil or msg == false ) then
		msg = "nil";
	end
	if ( DEFAULT_CHAT_FRAME and TDC_DEBUG ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.22, 0);
	end
end

function ax_Round(num)
	if(num - math.floor(num) >= 0.5) then
		num = num + 0.5;
	end
	return math.floor(num);
end

--------------------------------------------------------------------------------------------------
-- Color, Buttoncolor Functions
--------------------------------------------------------------------------------------------------

function ax_COLOR(color, msg)
	if ( msg == nil ) then
		msg = color;
		color = TEXT_COLOR_GOLD;
	end
	return color..msg..FONT_COLOR_CODE_CLOSE;
end

function ax_ButtonColor(lalala)
	local r, g, b;
	if(lalala <= TITAN_CLOTHTRACKER_RED) then
		r = 1.0;
		g = 0;
	elseif (lalala < TITAN_CLOTHTRACKER_GREEN and lalala > TITAN_CLOTHTRACKER_RED) then
	   	r = 1.0;
		g = 1.0;
	else
		g = 1.0;
		r = 0;		
	end
	b = 0;
	local rcode = format("%02x", r * 255);
	local gcode = format("%02x", g * 255);
	local bcode = format("%02x", b * 255);
	local colorcode = "|cff"..rcode..gcode..bcode;
	local returnvalue = colorcode..format(TITAN_CLOTHTRACKER_BUTTON_TEXT ,lalala).."|r";
	ax_DEBUG("ax_ButtonColor = "..returnvalue);
	return returnvalue;
end

function ax_ButtonColor_yesno(lalazu)
	local r, g, b;
	if(lalazu == 1) then
		r = 0;
		g = 1.0;
		lalazu = TITAN_CLOTHTRACKER_YES;
	else
	    r = 1.0;
		g = 0;
		lalazu = TITAN_CLOTHTRACKER_NO;
	end
	b = 0;
	local rcode = format("%02x", r * 255);
	local gcode = format("%02x", g * 255);
	local bcode = format("%02x", b * 255);
	local colorcode = "|cff"..rcode..gcode..bcode;
	local returnvalue = colorcode..format(TITAN_CLOTHTRACKER_BUTTON_TEXT ,lalazu).."|r";
	ax_DEBUG("ax_ButtonColor = "..returnvalue);
	return returnvalue;
end

function ax_getClothToolTip()
	text = "";
	text = text.."\n"..ax_COLOR(ax_CLOTH_LINEN).."\t"..ax_GetLinenCloth();
	text = text.."\n"..ax_COLOR(ax_CLOTH_WOOL).."\t"..ax_GetWoolCloth();
	text = text.."\n"..ax_COLOR(ax_CLOTH_SILK).."\t"..ax_GetSilkCloth();
	text = text.."\n"..ax_COLOR(ax_CLOTH_MAGEWEAVE).."\t"..ax_GetMageweaveCloth();
	text = text.."\n"..ax_COLOR(ax_CLOTH_RUNE).."\t"..ax_GetRuneCloth();
	text = text.."\n"..ax_COLOR(ax_CLOTH_MOON).."\t"..ax_GetMoonCloth();
	text = text.."\n"..ax_COLOR(ax_CLOTH_FEL).."\t"..ax_GetFelCloth();
	text = text.."\n";
	text = text.."\n"..ax_COLOR(ax_BOLT_LINEN).."\t"..ax_GetLinenBolt();
	text = text.."\n"..ax_COLOR(ax_BOLT_WOOL).."\t"..ax_GetWoolBolt();
	text = text.."\n"..ax_COLOR(ax_BOLT_SILK).."\t"..ax_GetSilkBolt();
	text = text.."\n"..ax_COLOR(ax_BOLT_MAGEWEAVE).."\t"..ax_GetMageweaveBolt();
	text = text.."\n"..ax_COLOR(ax_BOLT_RUNE).."\t"..ax_GetRuneBolt();

	return text;
end
