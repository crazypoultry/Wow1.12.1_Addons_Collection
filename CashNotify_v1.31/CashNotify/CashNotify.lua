--[[
	* CashNotify *

	Provides text notifications of any cash gains or
	expenditures in the chat pane.

	Version    : 1.10.0
	Last Update: 28 Oct 2006
]]

-- ========================================================
-- Global Data
-- ========================================================
CashNotify_Loaded = false; -- Vars loaded
CashNotify_InWorld = false; -- Player loaded

-- ========================================================
-- AddOn-only Global Data
-- ========================================================
local CN_GlobalDebug = false;
local CN_Coins = nil;
local CN_Merchant = nil;

-- ========================================================
-- AddOn Saved Variables
-- ========================================================
CashNotify = nil; -- Options Variable

-- ========================================================
-- Functions
-- ========================================================

-- ========================================================
-- Purpose: Initialises the AddOn first script-load
-- Called : <OnLoad>
-- Args   : -
-- Returns: -
--
function CashNotify_OnLoad()

	if (not div) then
		function div(nom,denom)
			return floor(nom/denom);
		end
	end

	-- Initialisation events
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	-- Merchant Frame events
	this:RegisterEvent("MERCHANT_CLOSED");
	this:RegisterEvent("MERCHANT_SHOW");

	-- Money Update event
	this:RegisterEvent("PLAYER_MONEY");

	-- Display version & help thingie (always to default chatframe)
	CN_Print(CN_LOADED.." - v"..CN_VersionText().." - |cffFFFF00/cn ?|r "..CN_DISPHELP, nil,nil,nil, CN_DCF);
end

-- ========================================================
-- Purpose: Act upon various events when they occur
-- OnEvent: <OnEvent> - (various)
-- Args   : event - string (global scope)
--          arg1..9 - (various, optional, global scope)
-- Returns: -
--
function CashNotify_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		CashNotify_VarsLoaded();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		CashNotify_EnterWorld();
	elseif (event == "MERCHANT_SHOW") then
		CashNotify_MerchantShow();
	elseif (event == "MERCHANT_CLOSED") then
		CashNotify_MerchantClosed();
	elseif (event == "PLAYER_MONEY") then
		CashNotify_MoneyChanged();
	end
end

-- ========================================================
-- Purpose: Initialise the AddOn once variables are loaded
-- OnEvent: VARIABLES_LOADED
-- Args   : -
-- Returns: -
--
function CashNotify_VarsLoaded()
	CNPrD(CN_VARLOAD);

	if (not CashNotify) then
		CashNotify = {};
		CashNotify.Enabled = true; -- Display stuff? (default: yes)
	end
	if (not CashNotify.Colours or
		((CashNotify.Version or 0) < 130)) then
		-- Initialize if non-existant or "only one colour" (v1.2)
		CashNotify_ResetColours();
	end
	if (not CashNotify.Frame) then
		-- DEFAULT_CHAT_FRAME
		CashNotify.Frame = CN_DCF;
	end
	-- 'CashNotify.Merchant' defaults to nil (off), so ignore.

	if ((CashNotify.Version or 0) < CN_VERSION) then
		CashNotify.Version = CN_VERSION;
	end
	if ((CashNotify.Interface or 0) ~= CN_IFACE) then
		CashNotify.Interface = CN_IFACE;
	end

	-- For merchant summaries
	CN_Merchant = {open	= false}; --other table-members are initiated when needed.

	SlashCmdList["CashNotify"] = CashNotify_CMD;
	SLASH_CashNotify1 = "/cashnotify";
	SLASH_CashNotify2 = "/cn";

	SlashCmdList["CashNotifyDBG"] = CashNotify_CMD_Debug;
	SLASH_CashNotifyDBG1 = "/cndbg";

	CashNotify_myAddOns_Registration();

	CashNotify_Loaded = true;
end

-- ========================================================
-- Purpose: Initialise certain things when player is
--          actually -in- the world and active.
-- OnEvent: PLAYER_ENTERING_WORLD
-- Args   : -
-- Returns: -
--
function CashNotify_EnterWorld()
	CNPrD(CN_ENTWORLD);

	-- Initialise current total
	CN_Coins = GetMoney();

	-- Note player as active
	CashNotify_InWorld = true;
end

-- ========================================================
-- Purpose: Initialise 'merchant summary' variable when the
--          merchant frame is opened.
-- OnEvent: MERCHANT_SHOW
-- Args   : -
-- Returns: -
--
function CashNotify_MerchantShow()
	CNPrD("MERCHANT_SHOW");
	if (not CashNotify.Merchant) then
		return;
	end

	CN_Merchant.open = true;
	CN_Merchant.gain = 0;
	CN_Merchant.spend = 0;
end

-- ========================================================
-- Purpose: Alert the player to their money having changed
--          via appropriate "gain", "spend" and "overall"
--          messages.
-- OnEvent: MERCHANT_CLOSED
-- Args   : -
-- Returns: -
--
function CashNotify_MerchantClosed()
	CNPrD("MERCHANT_CLOSED");
	if (not CashNotify.Merchant or not CN_Merchant.open) then
		return;
	end
	CN_Merchant.open = false;

	-- Check gain/spend amounts and display as required.
	if (CN_Merchant.gain > 0) then
		-- If you've gained money, it's from 'sales' to the merchant.
		CashNotify_DisplayMoneyChange(CN_Merchant.gain, " ("..CN_SALES..")");
	end
	if (CN_Merchant.spend > 0) then
		-- If you've lost money, it's due to 'purchases' from the merchant.
		CashNotify_DisplayMoneyChange(-CN_Merchant.spend, " ("..CN_PURCHASE..")");
	end

	-- Show a "final change" message, if required.
	local diff = CN_Merchant.gain - CN_Merchant.spend;
	if (diff ~= 0 and CN_Merchant.gain > 0 and CN_Merchant.spend > 0) then
		CashNotify_DisplayMoneyChange(diff, " ("..CN_OVERALL..")");
	end

	-- Clean up.
	CN_Merchant.spend = nil;
	CN_Merchant.gain = nil;
end

-- ========================================================
-- Purpose: Alert the player to their money having changed
--          via appropriate "gain" or "spend" text or take
--          note of it, if "Merchant summaries" is enabled
--          and the Merchant Frame is active.
-- OnEvent: PLAYER_MONEY
-- Args   : -
-- Returns: -
--
function CashNotify_MoneyChanged()
	CNPrD("PLAYER_MONEY - "..CNFormVar(arg1).." - "..CNFormVar(arg2));
	if (not CashNotify_InWorld) then
		return;
	end

	CN_OldCash, CN_Coins = CN_Coins, GetMoney();
	local diff = CN_Coins - CN_OldCash;

	-- update merchant totals if that's enabled (and merch window is open)
	if (CashNotify.Merchant and CN_Merchant.open) then
		if (diff > 0) then
			CN_Merchant.gain = CN_Merchant.gain + diff;
			CNPrD(format("Added %d to CN_Merchant.gain (now %d)", diff, CN_Merchant.gain));
		elseif (diff < 0) then
			CN_Merchant.spend = CN_Merchant.spend - diff; -- subtract -ve = addition ;)
			CNPrD(format("Added %d to CN_Merchant.spend (now %d)", -diff, CN_Merchant.spend));
		end
	elseif ( diff ~= 0 ) and (GetNumPartyMembers() == 0) then
		CashNotify_DisplayMoneyChange(diff);
	end
end

-- ========================================================
-- Purpose: Display a message for how much money has been
--          spent/gained and include a merchant flag if it
--          was done whilst "summarised".
-- Args   : amount - signed number (+gain, -spend)
--          suffix - string [optional]
-- Returns: -
--
function CashNotify_DisplayMoneyChange(amount, suffix)
	-- Only show messages if we're enabled.
	if (not CashNotify.Enabled) then
		return;
	end
	if (not suffix) then suffix = "."; end
	local fmt = CN_GAIN;
	local style = CN_NGAIN;
	if ( amount < 0 ) then
		fmt = CN_SPEND;
		style = CN_NSPEND;
	end
	CN_Print(format(fmt, CashNotify_FormatCoins(abs(amount))) .. suffix, CashNotify.Colours[style]);
end

-- ========================================================
-- Purpose: Parse and act upon entered slash-commands
-- Args   : param - string
-- Returns: -
--
function CashNotify_CMD(param)
	local cmd, param = CashNotify_ParseParam(param);

	-- /cn
	if (cmd == "") then

		-- Toggle notification state
		CashNotify_ToggleState();

	-- /cn color
	elseif (cmd == CN_PARAM_COLOR) then

		-- Check that picker isn't visible
		if ( CN_CPFrame:IsVisible() ) then return; end

		CashNotify_InvokeColourPicker();

	-- /cn color# r g b
	elseif (cmd == CN_PARAM_COLORGAIN or cmd == CN_PARAM_COLORSPEND) then

		-- Check that picker isn't visible
		if ( CN_CPFrame:IsVisible() ) then return; end

		-- Get RGB from parameter line, if they exist
		local r, g, b;
		if (param ~= "") then
			local _s, _e;
			_s, _e, r, g, b = strfind(param, "^([-]?%d+)%s+([-]?%d+)%s+([-]?%d+)");
			if (not CN_ChkRGB(r) or not CN_ChkRGB(g) or not CN_ChkRGB(b)) then
				CN_Print(CN_USAGE.." /cn "..cmd.." "..CN_RGB.." - "..CN_VALUES_ARE);
				return;
			end
			r = (r-1)/254; -- 1-255 to 0.0-1.0
			g = (g-1)/254;
			b = (b-1)/254;
		end

		local col = {r=r, g=g, b=b};
		if (cmd == CN_PARAM_COLORGAIN) then
			CashNotify_SetTextColor(CN_NGAIN, col);
		else
			CashNotify_SetTextColor(CN_NSPEND, col);
		end

	-- /cn frame
	elseif (cmd == CN_PARAM_FRAME) then

		-- Toggle the frame that text goes to.
		CashNotify_ToggleFrame();

	-- /cn merchant
	elseif (cmd == CN_PARAM_MERCHANT) then

		-- Toggle merchant expenditure summary state
		CashNotify_ToggleMerchantSummaries();

	-- /cn ? (or unrecognised command)
	else
		-- Show localised syntax/usage details
		--[[

		    <CN> CashNotify - vX.Y.IFACE (LANG)
		    <CN>
			<CN> Commands: (/cashnotify or /cn)
			<CN> /cn - Toggle notification on/off
			<CN> /cn ? - Show this help
			<CN> /cn color - Set notification text-color (using the 'Color Picker')
			<CN> /cn color1 <r> <g> <b> - Set 'gains' text-color (values are 1-255)
			<CN> /cn color2 <r> <g> <b> - Set 'spends' text-color (values are 1-255)
			<CN> /cn frame - Toggle output frame (between 'default' or 'selected')
			<CN> /cn merchant - Toggle merchant summaries on/off
		]]--
		local n = nil;
		CN_Print(n);
		CN_Print(CASH_NOTIFY.." - v"..CN_VersionText()..CN_LANG, n,n,n,CN_SCF);
		CN_Print("", n,n,n,CN_SCF);
		CN_Print(CN_COMMANDS.." (/cashnotify "..CN_OR.." /cn)", n,n,n,CN_SCF);
		CN_Print("/cn - "..CN_TOGGLE, n,n,n,CN_SCF);
		CN_Print("/cn ? - "..CN_SHOWHELP, n,n,n,CN_SCF);
		CN_Print("/cn "..CN_PARAM_COLOR.." - "..CN_SET_NOTIF_COLOR.." ("..CN_USING_PICKER..")", n,n,n,CN_SCF);
		CN_Print("/cn "..CN_PARAM_COLORGAIN.." "..CN_RGB.." - "..CN_SET_GAIN_COLOR.." ("..CN_VALUES_ARE..")", n,n,n,CN_SCF);
		CN_Print("/cn "..CN_PARAM_COLORSPEND.." "..CN_RGB.." - "..CN_SET_SPEND_COLOR.." ("..CN_VALUES_ARE..")", n,n,n,CN_SCF);
		CN_Print("/cn "..CN_PARAM_FRAME.." - "..CN_TOGGLE_FRAME, n,n,n,CN_SCF);
		CN_Print("/cn "..CN_PARAM_MERCHANT.." - "..CN_TOGGLE_MERCHANT, n,n,n,CN_SCF);
	end
end

-- Debug stuff. La la la. :P"
function CashNotify_CMD_Debug(param)
	param = strlower(param);
	if (param == "") then param = "1"; if (CN_GlobalDebug) then param = "0"; end; end
	if (param == "1") then
		CN_GlobalDebug = true; --done first, or no msg is shown :P
		CNPrD(CN_ENABLED..".");
	elseif (param == "0") then
		CNPrD(CN_DISABLED..".");
		CN_GlobalDebug = false; --done last or no msg is shown :P
	else
		CN_Print(CN_USAGE.." /cndbg [0|1|"..CN_HELP.."] -- "..CN_NOOPT);
	end
end

-- ========================================================
-- Purpose: Register ourself with 'myAddOns' addon.
--          <http://www.curse-gaming.com/mod.php?addid=358>
-- Args   : -
-- Returns: -
--
function CashNotify_myAddOns_Registration()
	-- Register with myAddOns internal list
	if(myAddOnsList) then
		myAddOnsList.CashNotify = {
				name		= CASH_NOTIFY,
				description	= CN_MYADDONS_DESC,
				version		= CN_VersionText(),
				category	= MYADDONS_CATEGORY_OTHERS,
				frame		= "CashNotifyFrame"
			};
	end
end

-- ========================================================
-- Purpose: Set the notification state (on/off)
-- Args   : state - boolean
-- Returns: -
--
function CashNotify_SetState(state)
	CashNotify.Enabled = state;
	local msg = CN_ACTIVE;
	if (not state) then
		msg = CN_INACTIVE;
	end
	CN_Print(msg, nil,nil,nil,CN_SCF); -- 'Disabled' message
end

-- ========================================================
-- Purpose: Toggle the notification state to the opposite
--          of what it was (via slash-command or binding)
-- Args   : -
-- Returns: -
--
function CashNotify_ToggleState()
	CashNotify_SetState(not CashNotify.Enabled);
end

-- ========================================================
-- Purpose: Toggle the frame that CN_Print() displays
--          messages to.
-- Args   : -
-- Returns: -
--
function CashNotify_ToggleFrame()
	local frame = CN_DCF;
	local msg = CN_NOTIF_DEFAULT;
	if (CashNotify.Frame == CN_DCF) then
		frame = CN_SCF;
		msg = CN_NOTIF_CURRENT;
	end
	CashNotify.Frame = frame;
	CN_Print(msg, nil,nil,nil, CN_SCF);
end

-- ========================================================
-- Purpose: Toggle whether merchant transactions are
--          summarised or not.
-- Args   : -
-- Returns: -
--
function CashNotify_ToggleMerchantSummaries()
	local state = true;
	local msg = CN_MERCH_ENABLED;
	if (CashNotify.Merchant) then
		state = nil;
		msg = CN_MERCH_DISABLED;
	end
	CashNotify.Merchant = state;
	CN_Print(msg, nil,nil,nil, CN_SCF);
end

-- ========================================================
-- Purpose: Format given 'copper' total into a text-version
--          of gold, silver and copper where there is at
--          least 1 of that type of coin.
-- Args   : copper - number
-- Returns: string
--
function CashNotify_FormatCoins(copper)
	local gold = div(copper, COPPER_PER_GOLD);
	local silver = mod(div(copper, COPPER_PER_SILVER), SILVER_PER_GOLD);
	local copper = mod(copper, COPPER_PER_SILVER);

	local s = "";
	if ( gold == 0 ) then gold = nil; end
	if ( silver == 0 ) then silver = nil; end
	if ( copper == 0 ) then copper = nil; end

	if ( gold ) then
		s = gold .. CN_GOLD;
		if ( silver and copper ) then
			s = s .. ", ";
		elseif ( silver or copper ) then
			s = s .. " "..CN_AND.." ";
		end
	end
	if ( silver ) then
		s = s .. silver .. CN_SILVER;
		if ( copper ) then
			s = s .. " "..CN_AND.." ";
		end
	end
	if ( copper ) then
		s = s .. copper .. CN_COPPER;
	end

	return s;
end

-- ========================================================
function CashNotify_ResetColours()
	local color;
	if (not CashNotify.Colours) then
		CashNotify.Colours = {};
	end
	if (CashNotify.Colours.r) then
		color = CashNotify.Colours; --{r,g,b}
		CashNotify.Colours = {}; -- reset it
	else
		color = {r = 1, g = 1, b = 1};
	end
	CashNotify.Colours[CN_NGAIN] = color;
	CashNotify.Colours[CN_NSPEND] = color;
end

-- ========================================================
-- Purpose: Parse slash-command into "cmd" and "params"
-- Args   : param - string
-- Returns: string, string
--
function CashNotify_ParseParam(param)
	if (not param or param == "") then return "", ""; end
	local _s, _e, first, rest = strfind(param, "^%s*([^%s]+)%s*(.-)%s*$");
	if (not first) then return "", ""; end
	return first, rest;
end

-- ========================================================
-- Purpose: Invoke the 'Colour Picker' for user to choose
--          colours for notification text.
-- Args   : -
-- Returns: -
--
function CashNotify_InvokeColourPicker()
	-- Invoke Colour Picker
	CN_CPFrame:SetColorTblRGB(CashNotify.Colours);
	CN_CPFrame.previousValues = CashNotify.Colours;
	CN_CPFrame.updateFunc = CashNotify_CPFUpdate; -- called when colour changes or "Okay" is clicked (param==true)
	CN_CPFrame.cancelFunc = CashNotify_CPFCancel; -- called when "Cancel" is clicked or "ESCAPE" pressed
	ShowUIPanel(CN_CPFrame);
end

-- ========================================================
-- Purpose: Set the colour that "CN_Print()" uses to
--          display text for notifications.
-- Args   : which - number (1-n)
--          r,g,b - number (0.0-1.0)
-- Returns: -)
--
function CashNotify_SetTextColor(which, rgb)
	if (not CN_ChkRGB1(rgb.r) or not CN_ChkRGB1(rgb.g) or not CN_ChkRGB1(rgb.b)) then
		CN_Print(CN_INVALID_COLOUR, nil);
	else

		-- Store the new colour (show message if it's different)
		local old = CashNotify.Colours[which];
		if (rgb.r ~= old.r or rgb.g ~= old.g or rgb.b ~= old.b) then
			CashNotify.Colours[which] = rgb;
			CN_Print(CN_COLOR_UPDATED[which], rgb,nil,nil, CN_SCF);
		end

	end
end

-- ========================================================
-- *HOOK FUNCTION*
-- Purpose: Called when a new colour is picked or the
--          "Okay" button is clicked in the Colour Picker
--          Frame. Only actually updates on "Okay".
-- Args   : -
-- Returns: -
--
function CashNotify_CPFUpdate(isOkay)
	-- Did they click "Okay"? If not, we ignore it!
	-- Haaaahahahahah! *hic*
	if (not isOkay) then
		return;
	end

	CashNotify_SetTextColor(CN_NGAIN, CN_CPFrame:GetColorTblRGB(CN_NGAIN));
	CashNotify_SetTextColor(CN_NSPEND, CN_CPFrame:GetColorTblRGB(CN_NSPEND));
end

-- ========================================================
-- *HOOK FUNCTION*
-- Purpose: Revert colour values to the settings from
--          before the Colour Picker Frame was made visible
-- Args   : previous - table ( [keys] = table(r, g, b) )
-- Returns: -
--
function CashNotify_CPFCancel(previous)
	-- We don't actually care what's in previous :P
	-- But at least give visible feedback. Ho hum.
	CN_Print(CN_COLPICK_CANCEL);
end


-- ========================================================
-- (XML) Color Picker-specific Functions
-- ========================================================
function CashNotify_InitialisePicker(frame)
	tinsert(getglobal("UISpecialFrames"),frame:GetName());

	if (not frame.GetColorTblRGB) then		frame.GetColorTblRGB	= CNCP_GetColorTblRGB;		end
	if (not frame.SetColorTblRGB) then		frame.SetColorTblRGB	= CNCP_SetColorTblRGB;		end
	if (not frame.SetCurrentTexture) then	frame.SetCurrentTexture	= CNCP_SetCurrentTexture;	end
	if (not frame.GetSwatchID) then			frame.GetSwatchID		= CNCP_GetSwatchID;			end
	if (not frame.SetSwatchID) then			frame.SetSwatchID		= CNCP_SetSwatchID;			end

	frame.ColorTable = {};
	frame:SetSwatchID(1);
end

function CNCP_GetColorTblRGB(cncp, index)
	return cncp.ColorTable[index] or {r=1,g=1,b=1};
end

function CNCP_SetColorTblRGB(cncp, idxOrTbl, r, g, b)
	if (not cncp.ColorTable) then
		cncp.ColorTable = {};
	end
	if (type(idxOrTbl) == "table") then
		for i,v in idxOrTbl do
			cncp.ColorTable[i] = {r=v.r, g=v.g, b=v.b};
		end
		return;
	end
	local color = {r=(r or 1), g=(g or 1), b=(b or 1)};
	cncp.ColorTable[idxOrTbl] = color;
end

function CNCP_SetCurrentTexture(cncp, arg1, arg2, arg3)
	local i = cncp:GetSwatchID();
	local swatch = getglobal(cncp:GetName().."Button"..i.."Swatch");
	return swatch:SetTexture(arg1, arg2, arg3);
end

function CNCP_GetSwatchID(cncp)
	return cncp.swatchIdx;
end

function CNCP_SetSwatchID(cncp, index)
	cncp.swatchIdx = index;
	return index;
end

function CNCP_SwatchButton_OnClick()
	local frame = this:GetParent(); --thisButton->Frame
	local id = this:GetID();
	frame:SetSwatchID(id);

	local fbutton = frame:GetName().."Button";
	for i=1,2 do
		local button = getglobal(fbutton..i);
		if (i == id) then
			button:LockHighlight(); --highlight button
			local col = frame:GetColorTblRGB(i); --get {r,g,b}
			frame:SetColorRGB(col.r, col.g, col.b); --set actual picker RGB
		else
			button:UnlockHighlight(); --darken button
		end
	end
end

-- ========================================================
-- Utility Functions
-- ========================================================

-- ========================================================
-- Purpose: Returns version text as a string: X.Y.IFACE
-- Args   : -
-- Returns: string
--
function CN_VersionText()
	-- X.Y.IFACE
	return tostring(CN_VERSION/100).."."..tostring(CN_IFACE);
end

-- ========================================================
-- Purpose: Print stuff to a frame
-- Args   : msg - string
--          r - number (0.0 - 1.0) or table (r,g,b) [optional]
--          g,b - number (0.0 - 1.0) [optional]
--          frame - varname of valid frame object [optional]
-- Returns: -
--
function CN_Print(msg, r, g, b, frame)
	if (r and type(r) == "table") then
		g = r.g;
		b = r.b;
		r = r.r; --do this last, so table isn't o/w. duh.
	end
	if (not CN_ChkRGB1(r) or not CN_ChkRGB1(g) or not CN_ChkRGB1(b)) then
		r,g,b = 1,1,1; -- white
	end
	if (not frame) then
		frame = "ChatFrame1"; --fallback frame
		if (CashNotify and CashNotify.Frame) then
			frame = CashNotify.Frame; --use the CN setting
		elseif (getglobal(CN_DCF)) then
			frame = CN_DCF; --use default if it's set
		end
	end
	-- 'frame' holds the varname of the frame to use
	frame = getglobal(frame);
	if (not msg) then
		msg = " ";
	else
		msg = CN_TAG..msg;
	end
	frame:AddMessage(msg,r,g,b);
end
function CNPrD(msg, r, g, b, frame)
	if (CN_GlobalDebug) then
		if (not frame) then frame = CN_SCF; end
		return CN_Print(CN_DEBUG..msg, r, g, b, frame);
	end
end

-- ========================================================
-- Purpose: Check if given value is valid RGB
--          ChkRGB: (1-255)   ChkRGB1: 0.0-1.0
-- Args   : val - number (1-255) / (0.0-1.0)
-- Returns: boolean
--
function CN_ChkRGB(val,l,h)
	if (not l) then l=1; h=255; end
	if (type(val) ~= "number") then val = tonumber(val); end
	if (not val) then return nil; end
	if (val < l or val > h) then return nil; end
	return true;
end
function CN_ChkRGB1(val)
	return CN_ChkRGB(val,0.0,1.0);
end

-- ========================================================
-- Purpose: Debug helper func
function CNFormVar(v)
	return tostring(v).." ("..type(v)..")";
end

-- ========================================================
