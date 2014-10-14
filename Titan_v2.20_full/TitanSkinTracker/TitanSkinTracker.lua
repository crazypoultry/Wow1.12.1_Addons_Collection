--------------------------------------------------------------------------------------------------
-- Titan [SkinTracker]
-- Author: Xytro (Shattered Hand)
-- Credits: - WalleniuM for his Titan[ReagentBuff] mod.
--			- Telo for linkloot
--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
-- Some vars for color and some for saving settings/player
--------------------------------------------------------------------------------------------------

TITAN_SKINTRACKER_RED = 10; --It's a complete stack !

--------------------------------------------------------------------------------------------------
-- ItemAmount Variables (do not change)
--------------------------------------------------------------------------------------------------	
local light_leather_bank = 0;
local medium_leather_bank = 0;
local heavy_leather_bank = 0;
local thick_leather_bank = 0;
local rugged_leather_bank = 0;

local black_dragon_mail = 0;
local blue_dragon_mail = 0;
local green_dragon_mail = 0;

local black_dragon_bank = 0;
local blue_dragon_bank = 0;
local green_dragon_bank = 0;

--------------------------------------------------------------------------------------------------
-- Globals Variables (do not change)
--------------------------------------------------------------------------------------------------

-- names
TITAN_SKINTRACKER_ID =  "SkinTracker";
TITAN_SKINTRACKER_VERSION = " 2.1";
TITAN_SKINTRACKER_BUTTON_TEXT = "%s";

-- colors
TEXT_COLOR_WHITE = "|cffffffff";
TEXT_COLOR_GOLD = "|cffCEA208";
TEXT_COLOR_RED = "|cffff0000";
TEXT_COLOR_GREEN = "|cff00ff00";

--
TITAN_SKINTRACKER_SHOWDRAGONSCALES = "Show dragonscales";
TITAN_SKINTRACKER_SHOWDIAMOND = "Show black diamonds";
TITAN_SKINTRACKER_SHOWSTACKS = "Show quantity in stacks";

bank_opened = false;
--------------------------------------------------------------------------------------------------
-- OnLoad Functions
--------------------------------------------------------------------------------------------------
function xy_OnLoad()

	TITAN_SKINTRACKER_BUTTON_ICON = "Interface\\Icons\\Trade_LeatherWorking";


	this.registry = { 
		id = TITAN_SKINTRACKER_ID,
		menuText = TITAN_SKINTRACKER_ID, 
		buttonTextFunction = "TitanPanelSkinTracker_GetButtonText", 
		tooltipTitle = TITAN_SKINTRACKER_ID.." "..TITAN_SKINTRACKER_VERSION,
		tooltipTextFunction = "xy_getToolTip", 
		icon = TITAN_SKINTRACKER_BUTTON_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredButton = TITAN_NIL,
			iDragonscale = 0,
			iDiamond = 0,
			iStack = 0,
		},
	};
	
	xy_Msg("SkinTracker v2 : Database loaded!"); 
	SkinTracker_DBInit();
	
	-- register Events to update the Buttons
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_CLOSED");
	this:RegisterEvent("MAIL_CLOSED");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("ITEM_PUSH"); -- Fired when an item is pushed onto the "inventory-stack". For instance when you manufacture something with your trade skills or picks something up.
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
end

--------------------------------------------------------------------------------------------------
-- NameFromLink function
--------------------------------------------------------------------------------------------------
function SkinTracker_NameFromLink(link)
	local name
	if (link) then
		for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
			return name
		end
	end
end

----------------------------------
-- Leather Classes
----------------------------------
function SkinTracker_CheckMailLeather()
   	--Leather vars
   	local light_leather = 0;
   	local medium_leather = 0;
   	local heavy_leather = 0;
   	local thick_leather = 0;
   	local rugged_leather = 0;
   	local black_dragon = 0;
   	local blue_dragon = 0;
   	local green_dragon = 0;
   	local black_diamond = 0;
  	
  	--Mailbox vars
   	local items = GetInboxNumItems();
   	local name, icon, quantity;
   	local iItem = 0;
   	local dragonscaleswitch = 0;
   	local diamondswitch = 0;

	if(items > 0) then -- if your mailbox contains something
		for index = 1, items, 1 do
			itemName, itemIcon, itemQuantity = GetInboxItem(index);
	 		if( itemName == XY_SKIN_LIGHT ) then
				light_leather = light_leather + itemQuantity;
			end
			if( itemName == XY_SKIN_MEDIUM ) then
				medium_leather = medium_leather + itemQuantity;
			end
			if( itemName == XY_SKIN_HEAVY ) then
				heavy_leather = heavy_leather + itemQuantity;
			end
			if( itemName == XY_SKIN_THICK ) then
				thick_leather = thick_leather + itemQuantity;
			end
			if( itemName == XY_SKIN_RUGGED ) then
				rugged_leather = rugged_leather + itemQuantity;
			end
			
			if(itemName == XY_DRAGONSCALE_BLACK) then
				--xy_Msg(XY_DRAGONSCALE_BLACK);
				black_dragon = black_dragon + itemQuantity;
			end
			if(itemName == XY_DRAGONSCALE_BLUE) then
				--xy_Msg(XY_DRAGONSCALE_BLUE);
				blue_dragon = blue_dragon + itemQuantity;
			end
			if(itemName == XY_DRAGONSCALE_GREEN) then
				--xy_Msg(XY_DRAGONSCALE_GREEN);
				green_dragon = green_dragon + itemQuantity;
			end
			if(itemName == XY_DIAMOND_BLACK) then
				--xy_Msg(XY_DRAGONSCALE_GREEN);
				black_diamond = black_diamond_dragon + itemQuantity;
			end
			
		end
	end
	-- Save the vars
	SkinTracker_SetVar("SKINTRACKER_MAIL_LIGHT", 		light_leather);
	SkinTracker_SetVar("SKINTRACKER_MAIL_MEDIUM", 		medium_leather);
	SkinTracker_SetVar("SKINTRACKER_MAIL_HEAVY", 		heavy_leather);
	SkinTracker_SetVar("SKINTRACKER_MAIL_THICK", 		thick_leather);
	SkinTracker_SetVar("SKINTRACKER_MAIL_RUGGED", 		rugged_leather);
	SkinTracker_SetVar("SKINTRACKER_MAIL_DRAGONBLACK", 	black_dragon);
	SkinTracker_SetVar("SKINTRACKER_MAIL_DRAGONGREEN", 	green_dragon);
	SkinTracker_SetVar("SKINTRACKER_MAIL_DRAGONBLUE", 	blue_dragon);
	SkinTracker_SetVar("SKINTRACKER_MAIL_DIAMONDBLACK", 	black_diamond);
			
end

function SkinTracker_CheckInvLeather()
	local bag_light = 0;
	local bag_medium = 0;
	local bag_heavy = 0;
	local bag_thick = 0;
	local bag_rugged = 0;
	local bag_dragonblack = 0;
	local bag_dragongreen = 0;
	local bag_dragonblue  = 0;
	local bag_diamondblack = 0;

	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = SkinTracker_NameFromLink(GetContainerItemLink(bag, slot));
					if ((itemName) and (itemName ~= "")) then
						if(itemName == XY_SKIN_LIGHT) then
							bag_light = bag_light + itemCount;
						end
						if(itemName == XY_SKIN_MEDIUM) then
							bag_medium = bag_medium + itemCount;
						end
						if(itemName == XY_SKIN_HEAVY) then
							bag_heavy = bag_heavy + itemCount;
						end
						if(itemName == XY_SKIN_THICK) then
							bag_thick = bag_thick + itemCount;
						end
						if(itemName == XY_SKIN_RUGGED) then
							bag_rugged = bag_rugged + itemCount;
						end
						--
						if(itemName == XY_DRAGONSCALE_BLACK) then
							bag_dragonblack = bag_dragonblack + itemCount;
						end
						if(itemName == XY_DRAGONSCALE_GREEN) then
							bag_dragongreen = bag_dragongreen + itemCount;
						end
						if(itemName == XY_DRAGONSCALE_BLUE) then
							bag_dragonblue = bag_dragonblue + itemCount;
						end
						--
						if(itemName == XY_DIAMOND_BLACK) then
							bag_diamondblack = bag_diamondblack + itemCount;
						end
					end
				end
			end
		end
	end
	SkinTracker_SetVar("SKINTRACKER_INV_LIGHT", 			bag_light);
	SkinTracker_SetVar("SKINTRACKER_INV_MEDIUM", 		bag_medium);
	SkinTracker_SetVar("SKINTRACKER_INV_HEAVY", 			bag_heavy);
	SkinTracker_SetVar("SKINTRACKER_INV_THICK", 			bag_thick);
	SkinTracker_SetVar("SKINTRACKER_INV_RUGGED", 		bag_rugged);
	SkinTracker_SetVar("SKINTRACKER_INV_DRAGONBLACK", 	bag_dragonblack);
	SkinTracker_SetVar("SKINTRACKER_INV_DRAGONGREEN", 	bag_dragongreen);
	SkinTracker_SetVar("SKINTRACKER_INV_DRAGONBLUE", 	bag_dragonblue);
	SkinTracker_SetVar("SKINTRACKER_INV_DIAMONDBLACK", 	bag_diamondblack);	
end
-------------------------
-- Bank
-------------------------
function SkinTracker_CheckBankLeather()
	local maxContainerItems;
	local containerItemNum;
	local bagNum;
	local link;
	local quantity;
	local icon;
	local itemName;
	--
	local bank_light = 0;
	local bank_medium = 0;
	local bank_heavy = 0;
	local bank_thick = 0;
	local bank_rugged = 0;
	local bank_dragonblack = 0;
	local bank_dragongreen = 0;
	local bank_dragonblue  = 0;
	local bank_diamondblack = 0;
	--

	maxContainerItems = GetContainerNumSlots(BANK_CONTAINER);
	if ( maxContainerItems ) then
		for containerItemNum = 1, maxContainerItems do
			link = GetContainerItemLink(BANK_CONTAINER, containerItemNum);
			icon, quantity = GetContainerItemInfo(BANK_CONTAINER, containerItemNum);
			if( link ) then
				--LinkToName
				itemName = SkinTracker_NameFromLink(link);
				if(itemName == XY_SKIN_LIGHT) then
					bank_light = bank_light + quantity;
				end
				if(itemName == XY_SKIN_MEDIUM) then
					bank_medium = bank_medium + quantity;
				end
				if(itemName == XY_SKIN_HEAVY) then
					bank_heavy = bank_heavy + quantity;
				end
				if(itemName == XY_SKIN_THICK) then
					bank_thick = bank_thick + quantity;
				end
				if(itemName == XY_SKIN_RUGGED) then
					bank_rugged = bank_rugged + quantity;
				end
				
				if(itemName == XY_DRAGONSCALE_BLACK) then
					bank_dragonblack = bank_dragonblack + quantity;
				end
				if(itemName == XY_DRAGONSCALE_BLUE) then
					bank_dragonblue = bank_dragonblue + quantity;
				end
				if(itemName == XY_DRAGONSCALE_GREEN) then
					bank_dragongreen = bank_dragongreen + quantity;
				end
				if(itemName == XY_DRAGONSCALE_GREEN) then
					bank_dragongreen = bank_dragongreen + quantity;
				end
				if(itemName == XY_DIAMOND_BLACK) then
					bank_diamondblack = bank_diamondblack + quantity;
				end					
			end
		end
	end

	for bagNum = 5, 10 do
		maxContainerItems = GetContainerNumSlots(bagNum);
		if( maxContainerItems ) then
			local id = BankButtonIDToInvSlotID(bagNum, 1);
			link = GetInventoryItemLink("player", id);
			icon = GetInventoryItemTexture("player", id);
			for containerItemNum = 1, maxContainerItems do
				link = GetContainerItemLink(bagNum, containerItemNum);
				icon, quantity = GetContainerItemInfo(bagNum, containerItemNum);
				if( link ) then
					--LinkToName
					itemName = SkinTracker_NameFromLink(link);
					if(itemName == XY_SKIN_LIGHT) then
						bank_light = bank_light + quantity;
					end
					if(itemName == XY_SKIN_MEDIUM) then
						bank_medium = bank_medium + quantity;
					end
					if(itemName == XY_SKIN_HEAVY) then
						bank_heavy = bank_heavy + quantity;
					end
					if(itemName == XY_SKIN_THICK) then
						bank_thick = bank_thick + quantity;
					end
					if(itemName == XY_SKIN_RUGGED) then
						bank_rugged = bank_rugged + quantity;
					end

					if(itemName == XY_DRAGONSCALE_BLACK) then
						bank_dragonblack = bank_dragonblack + quantity;
					end
					if(itemName == XY_DRAGONSCALE_BLUE) then
						bank_dragonblue = bank_dragonblue + quantity;
					end
					if(itemName == XY_DRAGONSCALE_GREEN) then
						bank_dragongreen = bank_dragongreen + quantity;
					end
					if(itemName == XY_DIAMOND_BLACK) then
						bank_diamondblack = bank_diamondblack + quantity;
					end
				end
			end
		end
	end
	SkinTracker_SetVar("SKINTRACKER_BANK_LIGHT", 		bank_light);
	SkinTracker_SetVar("SKINTRACKER_BANK_MEDIUM", 		bank_medium);
	SkinTracker_SetVar("SKINTRACKER_BANK_HEAVY", 		bank_heavy);
	SkinTracker_SetVar("SKINTRACKER_BANK_THICK", 		bank_thick);
	SkinTracker_SetVar("SKINTRACKER_BANK_RUGGED", 		bank_rugged);
	SkinTracker_SetVar("SKINTRACKER_BANK_DRAGONBLACK", 	bank_dragonblack);
	SkinTracker_SetVar("SKINTRACKER_BANK_DRAGONGREEN", 	bank_dragongreen);
	SkinTracker_SetVar("SKINTRACKER_BANK_DRAGONBLUE", 	bank_dragonblue);
	SkinTracker_SetVar("SKINTRACKER_BANK_DIAMONDBLACK", 	bank_diamondblack)
end
--------------------------------------------------------------------------------------------------
-- OnEvent
--------------------------------------------------------------------------------------------------

function xy_OnEvent(event)		

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( SKINTRACKER_SETTINGS == nil ) then
			xy_Initialize(); -- init
		end
		if ( SKINTRACKER_SETTINGS["VERSION"] ~= TITAN_SKINTRACKER_VERSION ) then
			xy_Update(SKINTRACKER_SETTINGS["VERSION"]);
		end
		TitanPanelButton_UpdateButton(TITAN_SKINTRACKER_ID);
		TitanPanelButton_UpdateTooltip();
		return;
	end
	
	if (event == "VARIABLES_LOADED") then
	   xy_Msg(TITAN_SKINTRACKER_ID.." "..TITAN_SKINTRACKER_NAME_VERSION.." "..TITAN_SKINTRACKER_VERSION.." "..TITAN_SKINTRACKER_LOADED..".");
	end

	-- update variables for vutton events
	if ( event == "MAIL_CLOSED") or ( event == "BAG_UPDATE") or ( event == "BANKFRAME_OPENED") or (event == "PLAYERBANKSLOTS_CHANGED") or (event == "ITEM_PUSH") or ( event == "UNIT_INVENTORY_CHANGED") then
		
		SkinTracker_CheckBankLeather();
		SkinTracker_CheckMailLeather();

		TitanPanelButton_UpdateButton(TITAN_SKINTRACKER_ID);
		return;
	end
	
	if ( event == "SPELLCAST_STOP") or ( event == "MERCHANT_CLOSED") or ( event == "SPELLS_CHANGED") or ( event == "SPELL_UPDATE_COOLDOWN") or ( event == "MERCHANT_SHOW") then
          TitanPanelButton_UpdateButton(TITAN_SKINTRACKER_ID);
		return;
	end	
end

function xy_OnClick(button)
	if ( button == "LeftButton" and IsShiftKeyDown() ) then
	end
end

--------------------------------------------------------------------------------------------------
-- Database Functions
--------------------------------------------------------------------------------------------------

function xy_Initialize()
	xy_DEBUG("Initializing ...");
	SKINTRACKER_SETTINGS = {};
	SKINTRACKER_SETTINGS["VERSION"] = TITAN_SKINTRACKER_VERSION;
	SKINTRACKER_SETTINGS["COUNT"] = 0;
	xy_DEBUG("Initializing done !");
end

function xy_Update(version)
	--xy_Msg(TITAN_SKINTRACKER_ID.." "..TITAN_SKINTRACKER_SYS_UPDATING.." "..version.." !");
	if ( version == nil or version == "UNKNOWN" ) then
		xy_Initialize();
	else
		xy_Msg(TITAN_SKINTRACKER_SYS_NOUPDATE.." !");
		SKINTRACKER_SETTINGS["VERSION"] = TITAN_SKINTRACKER_VERSION;
		return;
	end
	xy_Msg(TITAN_SKINTRACKER_SYS_UPDATE.." !");
end

function xy_Reset()
	xy_DEBUG("Resetting database ...");
	xy_Initialize();
	xy_DEBUG("Resetting done !");
end

--------------------------------------------------------------------------------------------------
-- Titan Panel Functions
--------------------------------------------------------------------------------------------------
function TitanPanelSkinTracker_GetButtonText(id)
	local light_leather_bag;
	local medium_leather_bag;
	local heavy_leather_bag;
	local thick_leather_bag;
	local rugged_leather_bag;
	
	light_leather_bag = SkinTracker_GetVar("SKINTRACKER_INV_LIGHT");
	medium_leather_bag = SkinTracker_GetVar("SKINTRACKER_INV_MEDIUM");
	heavy_leather_bag = SkinTracker_GetVar("SKINTRACKER_INV_HEAVY");
	thick_leather_bag = SkinTracker_GetVar("SKINTRACKER_INV_THICK");
	rugged_leather_bag = SkinTracker_GetVar("SKINTRACKER_INV_RUGGED");
	
	local buttonText;
	buttonText = light_leather_bag.."/"..medium_leather_bag.."/"..heavy_leather_bag.."/"..thick_leather_bag.."/"..rugged_leather_bag;
	
	return TITAN_SKINTRACKER_BUTTON_LABEL, buttonText;
end

function TitanPanelSkinTrackerButton_GetDragonVar()
	local retval = 0;
	local showDragon = TitanGetVar(TITAN_SKINTRACKER_ID, "iDragonscale");
	SkinTracker_SetVar("SHOW_DRAGON",showDragon);
end

function TitanPanelSkinTrackerButton_GetDiamondVar()
	local retval = 0;
	local showDiamond = TitanGetVar(TITAN_SKINTRACKER_ID, "iDiamond");
	SkinTracker_SetVar("SHOW_DIAMOND",showDiamond);
end

function TitanPanelSkinTrackerButton_GetStackVar()
	local retval = 0;
	local showStack = TitanGetVar(TITAN_SKINTRACKER_ID, "iStack");
	SkinTracker_SetVar("SHOW_STACK",showStack);
end
--------------------------------------------------------------------------------------------------
-- BuffReagent Menu
--------------------------------------------------------------------------------------------------

function TitanPanelRightClickMenu_PrepareSkinTrackerMenu()
	xy_DEBUG("Preparing "..TITAN_SKINTRACKER_ID.." menu ...");
	local id = TITAN_SKINTRACKER_ID;
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText..TITAN_SKINTRACKER_VERSION);
	TitanPanelRightClickMenu_AddToggleIcon(id);
	TitanPanelRightClickMenu_AddToggleLabelText(id);
	TitanPanelRightClickMenu_AddSpacer();
    local info = {};
    
	info.text = TITAN_SKINTRACKER_MENU_RESET;
	info.func = xy_Reset;
	UIDropDownMenu_AddButton(info);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
	
	--Adding toggle function for switching on/off display of dragonscales
	TitanPanelRightClickMenu_AddToggleVar(TITAN_SKINTRACKER_SHOWDRAGONSCALES, TITAN_SKINTRACKER_ID, 'iDragonscale');
	TitanPanelRightClickMenu_AddToggleVar(TITAN_SKINTRACKER_SHOWDIAMOND, TITAN_SKINTRACKER_ID, 'iDiamond');
	TitanPanelRightClickMenu_AddToggleVar(TITAN_SKINTRACKER_SHOWSTACKS, TITAN_SKINTRACKER_ID, 'iStack');
	

	xy_DEBUG("Preparing done !");
end

function TitanPanelSkinTracker_ToggleColoredButton()
	TitanToggleVar(TITAN_SKINTRACKER_ID, "ShowColoredButton");
	TitanPanelButton_UpdateButton(TITAN_SKINTRACKER_ID);
end


--------------------------------------------------------------------------------------------------
-- Misc Help Functions
--------------------------------------------------------------------------------------------------

function xy_Msg(msg)
	if ( msg == nil ) then
		msg = "------------------------------";
	end
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.82, 0);
	end
end

function xy_DEBUG(msg)
	if ( msg == nil or msg == false ) then
		msg = "nil";
	end
	if ( DEFAULT_CHAT_FRAME and TDC_DEBUG ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.22, 0);
	end
end

function xy_Round(num)
	if(num - math.floor(num) >= 0.5) then
		num = num + 0.5;
	end
	return math.floor(num);
end

--------------------------------------------------------------------------------------------------
-- Color, Buttoncolor Functions
--------------------------------------------------------------------------------------------------

function xy_COLOR(color, msg)
	if ( msg == nil ) then
		msg = color;
		color = TEXT_COLOR_GOLD;
	end
	return color..msg..FONT_COLOR_CODE_CLOSE;
end

function xy_ButtonColor(lalala)
	local r, g, b;
	local returnvalue;
	if(lalala == nil) then
	--	r = 1.0;
	--	g = 1.0;
	--	b = 1.0;
		returnvalue = lalala;
	else
		if(TITAN_SKINTRACKER_RED  and lalala < TITAN_SKINTRACKER_RED ) then
			r = 1.0;
			g = 0;
			b = 0;	
		else
		    r = 0;
			g = 1.0;
			b = 0;
		end
		
		local rcode = format("%02x", r * 255);
		local gcode = format("%02x", g * 255);
		local bcode = format("%02x", b * 255);
		local colorcode = "|cff"..rcode..gcode..bcode;
		returnvalue = colorcode..format(TITAN_SKINTRACKER_BUTTON_TEXT,lalala).."|r";
	end
	
	return returnvalue;
end

function xy_ButtonColor_yesno(lalazu)
	local r, g, b;
	if(lalazu == 1) then
		r = 0;
		g = 1.0;
		lalazu = TITAN_SKINTRACKER_YES;
	else
	    r = 1.0;
		g = 0;
		lalazu = TITAN_SKINTRACKER_NO;
	end
	b = 0;
	local rcode = format("%02x", r * 255);
	local gcode = format("%02x", g * 255);
	local bcode = format("%02x", b * 255);
	local colorcode = "|cff"..rcode..gcode..bcode;
	local returnvalue = colorcode..format(TITAN_SKINTRACKER_BUTTON_TEXT ,lalazu).."|r";
	--xy_DEBUG("xy_ButtonColor = "..returnvalue);
	return returnvalue;
end

function xy_getToolTip()
	
	SkinTracker_CheckInvLeather();
	SkinTracker_CheckMailLeather();
	SkinTracker_CheckBankLeather();
	
	TitanPanelSkinTrackerButton_GetDragonVar();
	TitanPanelSkinTrackerButton_GetDiamondVar();
	TitanPanelSkinTrackerButton_GetStackVar();
	 
	local light_leather_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_LIGHT");
	local medium_leather_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_MEDIUM");
	local heavy_leather_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_HEAVY");
	local thick_leather_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_THICK");
	local rugged_leather_bag =	SkinTracker_GetVar("SKINTRACKER_INV_RUGGED");
	local black_dragon_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_DRAGONBLACK");
	local blue_dragon_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_DRAGONBLUE");
	local green_dragon_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_DRAGONGREEN");
	local black_diamond_bag = 	SkinTracker_GetVar("SKINTRACKER_INV_DIAMONBLACK");
	
	text = "";
	text = text.."\n"..TitanUtils_GetHighlightText("Leather");
		
	if(SkinTracker_GetVar("SHOW_STACK")==1) then
		local light_stack =0;
		local medium stack =0;
		local heavy_stack =0;
		local thick_stack =0;
		local rugged_stack =0;
		local light_mod =0;
		local medium_mod =0;
		local heavy_mod =0;
		local thick_mod =0;
		local rugged_mod =0;
		
		lolight_stack = math.floor((SkinTracker_GetVar("SKINTRACKER_INV_LIGHT")/10));
		light_mod = math.mod(SkinTracker_GetVar("SKINTRACKER_INV_LIGHT"), 10);
		medium_stack = math.floor((SkinTracker_GetVar("SKINTRACKER_INV_MEDIUM")/10));
		medium_mod = math.mod(SkinTracker_GetVar("SKINTRACKER_INV_MEDIUM"), 10);
		heavy_stack = math.floor((SkinTracker_GetVar("SKINTRACKER_INV_HEAVY")/10));
		heavy_mod = math.mod(SkinTracker_GetVar("SKINTRACKER_INV_HEAVY"), 10);
		thick_stack = math.floor((SkinTracker_GetVar("SKINTRACKER_INV_THICK")/10));
		thick_mod = math.mod(SkinTracker_GetVar("SKINTRACKER_INV_THICK"), 10);
		rugged_stack = math.floor((SkinTracker_GetVar("SKINTRACKER_INV_RUGGED")/10));
		rugged_mod = math.mod(SkinTracker_GetVar("SKINTRACKER_INV_RUGGED"), 10);
		
		text = text.."\n"..xy_COLOR(XY_SKIN_LIGHT) .."\t"..light_mod.." [stack: "..light_stack.." ]".." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_LIGHT")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_LIGHT")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_MEDIUM).."\t"..medium_mod.." [stack: "..medium_stack.." ]".." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_MEDIUM")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_MEDIUM")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_HEAVY) .."\t"..heavy_mod.." [stack: "..heavy_stack.." ]".." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_HEAVY")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_HEAVY")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_THICK) .."\t"..thick_mod.." [stack: "..thick_stack.." ]".." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_THICK")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_THICK")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_RUGGED).."\t"..rugged_mod.." [stack: "..rugged_stack.." ]".." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_RUGGED")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_RUGGED")..")";	
		 
	else
		text = text.."\n"..xy_COLOR(XY_SKIN_LIGHT).."\t"..SkinTracker_GetVar("SKINTRACKER_INV_LIGHT").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_LIGHT")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_LIGHT")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_MEDIUM).."\t"..SkinTracker_GetVar("SKINTRACKER_INV_MEDIUM").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_MEDIUM")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_MEDIUM")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_HEAVY).."\t"..SkinTracker_GetVar("SKINTRACKER_INV_HEAVY").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_HEAVY")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_HEAVY")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_THICK).."\t"..SkinTracker_GetVar("SKINTRACKER_INV_THICK").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_THICK")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_THICK")..")";
		text = text.."\n"..xy_COLOR(XY_SKIN_RUGGED).."\t"..SkinTracker_GetVar("SKINTRACKER_INV_RUGGED").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_RUGGED")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_RUGGED")..")";
	end
--	else
	
--	end
	if(SkinTracker_GetVar("SHOW_DRAGON")==1) then
		text= text.."\n";
		text= text.."\n"..TitanUtils_GetHighlightText("Dragonscales");
		text= text.."\n"..XY_DRAGONSCALE_BLACK.."\t"..SkinTracker_GetVar("SKINTRACKER_INV_DRAGONBLACK").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_DRAGONBLACK")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_DRAGONBLACK")..")";
		text= text.."\n"..XY_DRAGONSCALE_BLUE.."\t"..SkinTracker_GetVar("SKINTRACKER_INV_DRAGONBLUE").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_DRAGONBLUE")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_DRAGONBLUE")..")";
		text= text.."\n"..XY_DRAGONSCALE_GREEN.."\t"..SkinTracker_GetVar("SKINTRACKER_INV_DRAGONGREEN").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_DRAGONGREEN")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_DRAGONGREEN")..")";
	end
	
	if(SkinTracker_GetVar("SHOW_DIAMOND")==1) then
		text= text.."\n";
		text= text.."\n"..TitanUtils_GetHighlightText("Black Diamonds");
		text= text.."\n"..XY_DIAMOND_BLACK.."\t"..SkinTracker_GetVar("SKINTRACKER_INV_DIAMONDBLACK").." - ".."(bank:"..SkinTracker_GetVar("SKINTRACKER_BANK_DIAMONDBLACK")..")".."(mail:"..SkinTracker_GetVar("SKINTRACKER_MAIL_DIAMONDBLACK")..")";
	end
	
	return text;
end


-- DATABASE FUNCTIONS
function SkinTracker_DBInit()
	SKINTRACKER_COUNT = {};
	
	SKINTRACKER_COUNT["SKINTRACKER_INV_LIGHT"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_MEDIUM"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_HEAVY"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_THICK"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_RUGGED"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_DRAGONBLACK"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_DRAGONBLUE"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_DRAGONGREEN"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_INV_DIAMONBLACK"] = 10;
	
	SKINTRACKER_COUNT["SKINTRACKER_BANK_LIGHT"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_MEDIUM"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_HEAVY"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_THICK"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_RUGGED"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_DRAGONBLACK"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_DRAGONGREEN"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_DRAGONBLUE"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_BANK_DIAMONDBLACK"] = 10;
	
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_LIGHT"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_MEDIUM"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_HEAVY"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_THICK"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_RUGGED"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_DRAGONBLACK"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_DRAGONGREEN"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_DRAGONBLUE"] = 10;
	SKINTRACKER_COUNT["SKINTRACKER_MAIL_DIAMONDBLACK"] = 10;
	
	SKINTRACKER_COUNT["SHOW_DRAGON"] = 0;
	SKINTRACKER_COUNT["SHOW_DIAMOND"] = 0;
	SKINTRACKER_COUNT["SHOW_STACK"] = 0;
	
	
end

function SkinTracker_SetVar(var, value)
	SKINTRACKER_COUNT[var] = value;
end

function SkinTracker_GetVar(var)
	return SKINTRACKER_COUNT[var];
end

