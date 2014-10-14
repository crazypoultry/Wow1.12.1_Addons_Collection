--[[
*******************************************
 File:		VendorBags.lua
 Author: 	Goldark
 Version: 	0.8
 Feedback:	PM Goldark on the cosmosui.org forums

 0.9	Added (optional) opening of bank bags when at bank
 0.8	Support for 1300, Added mail event & configuration options, options saved
 0.7	Support for 4216			
 0.6	Added bank event
 0.5	New release for interface 4196 (no change to the .lua)
 0.4	Reworked to use Events rather than function overrides or hooks - thanks Sarf!
 0.3	Fixed bags closing if you had 4 or 5 already open
 0.2	Removed Sea dependency
 0.1	Original Version

 A little AddOn that will open all your bags when at a vendor, closing them all again afterwards.
 The original implementation has since been expanded to work at banks and post boxes too.
 
 Commands:
 /vb on/off - On will switch on anything enabled below, plus vendors. Off will switch off everywhere. 
	Bank and mail settings will be remembered so if you switch it off everywhere and 
	then later back on, the on functionality will be for vendors + whatever else it was
	on for before.
 /vb bank - toggle on/off at banks (enabled by default)
 /vb bankBags - toggle whether bank bags are also opened when at bank (enabled by default)
 /vb mail - toggle on/off at mailboxes (disabled by default)
 /vb show - will list current settings (as will any of the above)

 Credits:
 Tasarion for the original idea
 Gramner for the non-Sea solution
 Sarf for suggesting the use of Events
 Sarf, Alex and the rest of the Cosmos team
 All the contributors to www.wowwiki.com, such a great resource for UI development
 GDI for Reagent Watch, I used some code ideas from there
 Thorin for bugging me to update this; its great having an enthusiastic user to 
 get feedback from!
 *******************************************
]]

local version = 0.9;

local DEBUG=10;
local INFO=20;
local WARNING=30;
local ERROR=40;

-- only output INFO level messages or higher. Change to DEBUG for full debug output.
local debugLevel = INFO;

-- not configurable in-game but will add if people ask!
local alwaysCloseBackpack = true;

-- Saved variables values
vb_isEnabled = true; -- addon is enabled
vb_isEnabledAtBank = true; -- bags will open & close at bank
vb_isEnabledAtMail = false; -- bags will open & close at mail boxes
vb_isOpenBankBags = true; -- will open bags in the bank too (when at bank)

local vb_variablesLoaded = false; -- unused at present (but is set correctly)

-- ----------------------------------------------- 
-- 				Startup stuff
-- ------------------------------------------------

function VendorBags_OnLoad()
	VendorBags_Debug(DEBUG, "Loading");
	-- register events
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_CLOSED");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("MAIL_SHOW");
	this:RegisterEvent("MAIL_CLOSED");	
	this:RegisterEvent("VARIABLES_LOADED");
	
	-- register commands
	VendorBags_Register();
	
	VendorBags_Debug(INFO, "VendorBags "..version.." Loaded");
end -- OnLoad end

function VendorBags_Register()
	VendorBags_Debug(DEBUG, ">>Register()");
	
	--Slash command Setup
	SLASH_VENDOR_BAGS1 = "/vendorbags";
	SLASH_VENDOR_BAGS2 = "/vb";
	SlashCmdList["VENDOR_BAGS"] = function(msg)
			VendorBags_HandleMessage(msg);
	end

end -- Register end

-------------------------------------------------------
-- 				Events Handling
-------------------------------------------------------

function VendorBags_OnEvent(event)
	if ( (	event == "MERCHANT_SHOW" or 
			event == "BANKFRAME_OPENED" or
			event == "MAIL_SHOW"
		  ) and VendorBags_isEnabled (event) 
	) then 
	
		-- open bags	
		VendorBags_Debug(DEBUG, "SHOW event");
		OpenAllBags(true); -- this won't open bank bags though.....	
		
		-- ....so now we try to open bank bags too
		if (vb_isOpenBankBags == true and event == "BANKFRAME_OPENED") then
			VendorBags_OpenBankBags()
		end
		
	elseif ((	event == "MERCHANT_CLOSED" or
				event == "BANKFRAME_CLOSED" or
				event == "MAIL_CLOSED"
			) and VendorBags_isEnabled (event)
	) then 
	
		-- close bags
		
		-- The closed event gets called twice for some reason, doesn't matter tho!
		VendorBags_Debug(DEBUG, "CLOSED event");
		
		if (alwaysCloseBackpack) then
			-- This method will close all bags regardless of current or previous states
			VendorBags_CloseAllBags();
		else
			-- Blizzards version (from ContainerFrame.lua) will keep the backpack open if it was 
			-- already open prior to talking to the vendor
			CloseAllBags();
		end	
		
	elseif (event == "VARIABLES_LOADED") then
		vb_variablesLoaded = true;
	else
		-- unknown event or disabled event
		
		VendorBags_Debug(DEBUG, "Event: "..event.." ignored");
	end
end -- onEvent end

-- takes an event and returns whether it's enabled or not
function VendorBags_isEnabled(event)
	local myEnabled;
	
	-- broken down in if-else to make more readable
	if ( -- merchant (vendor)
		(event == "MERCHANT_CLOSED" or event == "MERCHANT_SHOW") and
		(vb_isEnabled)
	) then
		myEnabled = true;
	elseif ( -- bank
		(event == "BANKFRAME_CLOSED" or event == "BANKFRAME_OPENED") and 
		(vb_isEnabledAtBank and vb_isEnabled)
	) then
		myEnabled = true;
	elseif ( -- mailbox
		(event == "MAIL_CLOSED" or event == "MAIL_SHOW") and 
		(vb_isEnabledAtMail and vb_isEnabled)
	) then
		myEnabled = true;
	else
		myEnabled = false;
	end
	return myEnabled;
end -- isEnabled end


--------------------------------------------------
-- 			Command Handling
--------------------------------------------------

function VendorBags_HandleMessage(msg)
	if( msg == "on") then
		vb_isEnabled = true;
		VendorBags_ShowEnabledStatus();
	elseif (msg == "off") then
		vb_isEnabled = false;
		VendorBags_ShowEnabledStatus();
	elseif (msg == "toggle") then
		vb_isEnabled = not vb_isEnabled;
		VendorBags_ShowEnabledStatus();
	elseif (msg == "bank") then
		vb_isEnabledAtBank = not vb_isEnabledAtBank;
		VendorBags_ShowEnabledStatus();
	elseif (msg == "bankBags") then
		vb_isOpenBankBags = not vb_isOpenBankBags;
		VendorBags_ShowEnabledStatus();
	elseif (msg == "mail") then
		vb_isEnabledAtMail = not vb_isEnabledAtMail;
		VendorBags_ShowEnabledStatus();
	elseif (msg == "show") then
		VendorBags_ShowEnabledStatus();
	else
		VendorBags_Debug(DEBUG, "Message:**"..msg.."**");
		VendorBags_ShowUsage();
	end
end -- HandleMessage end

-------------------------------------------------------
--				Utils
-------------------------------------------------------

function VendorBags_ShowUsage()
	VendorBags_Print("VendorBags Usage: ");
	VendorBags_Print("on/off - set overall functionality on or off");
	VendorBags_Print("bank - toggle on/off at bank");
	VendorBags_Print("bankBags - toggle opening of bank bags on/off (only relevent if bank is enabled)");
	VendorBags_Print("mail - toggle on/off at mailbox");
end

function VendorBags_Debug(level, msg)
	if( DEFAULT_CHAT_FRAME and level >= debugLevel) then
		DEFAULT_CHAT_FRAME:AddMessage("<VB> "..version..": "..msg, 0.0, 1.0, 0.0);
	elseif ( level >= debugLevel) then
		ChatFrame1:AddMessage("<VB> "..version..": "..msg, 0.0, 1.0, 0.0);
	end
end -- Debug end

function VendorBags_Print(msg)
	if( DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 1.0, 0.0);
	else
		ChatFrame1:AddMessage(msg, 1.0, 1.0, 0.0);
	end
end

-- displays the enabled status values in the chat screen
function VendorBags_ShowEnabledStatus()
	local statusString = "VendorBags: ";
	if (vb_isEnabled) then
		statusString = statusString.."Enabled\n";
	else
		statusString = statusString.."Disabled\n";
	end
	
	statusString = statusString.."Open at banks: ";
	if (vb_isEnabledAtBank) then
		statusString = statusString.."Enabled\n";
	else
		statusString = statusString.."Disabled\n";
	end
	
	statusString = statusString.."Open bank bags: ";
	if (vb_isOpenBankBags) then
		statusString = statusString.."Enabled\n";
	else
		statusString = statusString.."Disabled\n";
	end
	
	
	statusString = statusString.."Open at mailbox: ";
	if (vb_isEnabledAtMail) then
		statusString = statusString.."Enabled\n";
	else
		statusString = statusString.."Disabled\n";
	end
	
	VendorBags_Print(statusString);
end

-- really truly close ALL bags including backpack, regardless of prior state
function VendorBags_CloseAllBags()
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local containerFrame = getglobal("ContainerFrame"..i);
		if (containerFrame:IsVisible()) then
			containerFrame:Hide()
		end
	end
end -- CloseAllBags end

-- open bags from the bank (assumes bank is open)
function VendorBags_OpenBankBags()
	VendorBags_Debug(DEBUG, "Opening bank bags (5-10)");
	-- note that these bags might not exist
	for i = 5, 10 do
		OpenBag(i);
	end	
end
