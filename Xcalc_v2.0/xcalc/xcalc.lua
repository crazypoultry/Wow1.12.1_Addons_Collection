--[[
    Xcalc see version onload.
    author: moird
    email: peirthies@gmail.com
    
    Change ideas:
        -Rewrite of the parsing and togsc fromgsc functions
        -Possibly adding a scientific option set to enable the calculator
            window for more functions that can be achieved already through
            the chatline but would give the window a lot better functionality
        -Maybe having a history of the last couple of calculations
]]


--Initialization stuff
function xcalc_initialize()
	-- add our very first chat command!
	SlashCmdList["XCALC"] = xcalc_command;
	SLASH_XCALC1 = "/xcalc";
	SLASH_XCALC2 = "/calc";
	SLASH_XCALC3 = "/=";
    xcalc_optionvariables();
    xcalc_minimap_init();
end

--Fuction for setting up Saved Variables
function xcalc_optionvariables()
    if (Xcalc_Settings.Binding == nil) then
        Xcalc_Settings.Binding = 1;
    end
    if (Xcalc_Settings.Minimapdisplay == nil) then
        Xcalc_Settings.Minimapdisplay = 1;
    end
    if (Xcalc_Settings.Minimappos == nil) then
        Xcalc_Settings.Minimappos = 295;
    end
end

--[[---------------------------------------------------------------------
    Proccess for setting the display in the main xcalc calculator window
    streamlined the whole process doing it this way so that the function
    can be called instead of calling both the variable, setting the new
    variable then passing the settext string to change the display.
    this also handles the M for memory being displayed on the main window
    ---------------------------------------------------------------------]]
function xcalc_display(displaynumber, memoryset)
    if ( displaynumber == nil or displaynumber == "" ) then
        displaynumber = "0";
    elseif ( memoryset == "1" ) then
        xcalc_memorydisplay:SetText ( XCALC_MEMORYINDICATORON );
    elseif ( memoryset == "0" ) then
        xcalc_memorydisplay:SetText( XCALC_MEMORYINDICATOR );
    end
    XCALC_NUMBERDISPLAY = displaynumber;
    xcalc_numberdisplay:SetText( displaynumber );
end

--[[--------------------------------------------------------------------
    Function for adding Debug messages via xcalc_debug("message"); call
    Haven't decided on adding a variable to add lots of debugging messages
    if set, will look into that idea as the code evolves a bit.
    --------------------------------------------------------------------]]
function xcalc_debug(debugmsg)
    ChatFrame1:AddMessage("xcalc_debug:" .. debugmsg);
end

--Function for handling the chat slash commands
function xcalc_command(msg)
	-- this function handles our chat command
	if (msg == nil or msg == "") then
		xcalc_windowdisplay();
		return nil;
	end

	local expression = msg;

	newexpression = xcalc_parse(expression);

	local result = xcalc_xcalculate(newexpression);

	if ( result == nil ) then
		result = 'nil';
	end

	XCALC_CONSOLE_LAST_ANS = result;

	--message(result);
	ChatFrame1:AddMessage("Xcalc Result: " .. expression .. " = " .. result, 1.0, 1.0, 0.5);
end

--Display Main calculator Window
function xcalc_windowdisplay()
	if (xcalc_window == nil) then
		xcalc_windowframe();
	elseif (xcalc_window:IsVisible()) then
		xcalc_window:Hide();
    else
        xcalc_window:Show();
	end
end

--Display options window (if one existed)
function xcalc_optiondisplay()
	if (xcalc_optionwindow == nil) then
		xcalc_optionframe();
	elseif (xcalc_optionwindow:IsVisible()) then
        xcalc_optionwindow:Hide();
    else
		xcalc_optionwindow:Show();
	end
end

--Function for handeling Binding checkbox
function xcalc_options_binding()
    if (xcalc_options_bindcheckbox:GetChecked() == 1) then
        Xcalc_Settings.Binding = 1;
    else
        xcalc_unbind();
        Xcalc_Settings.Binding = 0;
    end
end

-- Function for Handeling Minimap Display checkbox
function xcalc_options_minimapdisplay()
    if (xcalc_options_minimapcheckbox:GetChecked() == 1) then
        Xcalc_Settings.Minimapdisplay = 1;
        if (xcalc_minimap_button == nil) then
            xcalc_minimap_init();
        else
            xcalc_minimap_button:Show();
        end
    else
        Xcalc_Settings.Minimapdisplay = 0;
        xcalc_minimap_button:Hide();
    end
end

-- Function for managing options slider
function xcalc_options_minimapslidercontrol()
    Xcalc_Settings.Minimappos = xcalc_options_minimapslider:GetValue();
    xcalc_minimapbutton_updateposition();
end

--Processes for binding and unbinding numberpad keys to Xcalc
function xcalc_rebind()
    if (Xcalc_Settings.Binding == 1) then
        for x = 1, GetNumBindings() do
            currBinding = GetBinding(x);
            keyone, keytwo = GetBindingKey(currBinding);

            for key,value in pairs(XCALC_REMAPPED) do
                if (keyone == key or keytwo == key) then
                    XCALC_REMAPPED[key] = currBinding;
                end
            end

        end
        --steal numlock away from anything else
        SetBinding("NUMLOCK", "XC_NUMLOCK");
        SetBinding("HOME", "XC_CLEAR");
        SetBinding("END", "XC_CLOSE");

        --set numlock on keys
        SetBinding("NUMPADDIVIDE", "XC_DIV");
        SetBinding("NUMPADMULTIPLY", "XC_MUL");
        SetBinding("NUMPADMINUS", "XC_SUB");
        SetBinding("NUMPADPLUS", "XC_ADD");
        SetBinding("ENTER", "XC_EQ");
        SetBinding("NUMPAD0", "XC_0");
        SetBinding("NUMPAD1", "XC_1");
        SetBinding("NUMPAD2", "XC_2");
        SetBinding("NUMPAD3", "XC_3");
        SetBinding("NUMPAD4", "XC_4");
        SetBinding("NUMPAD5", "XC_5");
        SetBinding("NUMPAD6", "XC_6");
        SetBinding("NUMPAD7", "XC_7");
        SetBinding("NUMPAD8", "XC_8");
        SetBinding("NUMPAD9", "XC_9");
        SetBinding("NUMPADDECIMAL", "XC_DEC");

        SaveBindings(2);
    end
end

function xcalc_unbind()
    if (Xcalc_Settings.Binding == 1) then
        for key,value in pairs(XCALC_REMAPPED) do
            SetBinding(key, value);
            XCALC_REMAPPED[key] = "";
        end

        SaveBindings(2);
    end
end

--Bound Key management
function xcalc_onkeydown()
	key = arg1;
	--message(key);

	if ( key == "END" ) then
		
	elseif ( key == "NUMPAD0" ) then
		xcalc_numkey("0")
	elseif ( key == "NUMPAD1" ) then
		xcalc_numkey("1")
	elseif ( key == "NUMPAD2" ) then
		xcalc_numkey("2")
	elseif ( key == "NUMPAD3" ) then
		xcalc_numkey("3")
	elseif ( key == "NUMPAD4" ) then
		xcalc_numkey("4")
	elseif ( key == "NUMPAD5" ) then
		xcalc_numkey("5")
	elseif ( key == "NUMPAD6" ) then
		xcalc_numkey("6")
	elseif ( key == "NUMPAD7" ) then
		xcalc_numkey("7")
	elseif ( key == "NUMPAD8" ) then
		xcalc_numkey("8")
	elseif ( key == "NUMPAD9" ) then
		xcalc_numkey("9")
	end
end

--Button Clear
function xcalc_clear()
    XCALC_RUNNINGTOTAL = "";
    XCALC_PREVIOUSKEYTYPE = "none";
    XCALC_PREVIOUSOP = "";
    xcalc_display("0");
end

--Button CE
function xcalc_ce()
    xcalc_display("0");
end

--Button Backspace
function xcalc_backspace()
    currText = XCALC_NUMBERDISPLAY;
    if (currText == "0") then
        return;
    else
        length = string.len(currText)-1;
        if (length < 0) then
            length = 0;
        end
        currText = string.sub(currText,0,length);
        if (string.len(currText) < 1) then
            xcalc_display("0");
        else
            xcalc_display(currText);
        end
    end
end

--Button Plus Minus Key
function xcalc_plusminus()
    currText = XCALC_NUMBERDISPLAY;
    if (currText ~= "0") then
		if (string.find(currText, "-")) then
            currText = string.sub(currText, 2);
		else
			currText = "-" .. currText;
		end
	end
    XCALC_PREVIOUSKEYTYPE = "state";
    xcalc_display(currText);
end

--Button Gold (state)
function xcalc_stategold()
    currText = XCALC_NUMBERDISPLAY;
	if (string.find(currText, "c") == nil) then
		if (string.find(currText, "s") == nil) then
			if (string.find(currText, "g") == nil) then
				currText = currText .. "g";
			end
		end
	end
    XCALC_PREVIOUSKEYTYPE = "state";
    xcalc_display(currText);
end

--Button Silver (state)
function xcalc_statesilver()
    currText = XCALC_NUMBERDISPLAY;
	if (string.find(currText, "c") == nil) then
		if (string.find(currText, "s") == nil) then
			currText = currText .. "s";
		end
	end
    XCALC_PREVIOUSKEYTYPE = "state";
    xcalc_display(currText);
end

--Button Copper (state)
function xcalc_statecopper()
    currText = XCALC_NUMBERDISPLAY;
	if (string.find(currText, "c") == nil) then
		currText = currText .. "c";
	end
    XCALC_PREVIOUSKEYTYPE = "state";
    xcalc_display(currText);
end

--Button Memory Clear
function xcalc_mc()
    XCALC_MEMORYNUMBER = "0";
    xcalc_display(XCALC_NUMBERDISPLAY, "0");
end

--Button Memory Add
function xcalc_ma()
    temp = xcalc_parse(XCALC_MEMORYNUMBER .. "+" .. XCALC_NUMBERDISPLAY);
    XCALC_MEMORYNUMBER = xcalc_xcalculate(temp);
    xcalc_display("0","1");
    xcalc_clear();
end

--Button Memory Store
function xcalc_ms()
    XCALC_MEMORYNUMBER = xcalc_parse(XCALC_NUMBERDISPLAY);
    xcalc_display("0","1");
    xcalc_clear();
end

--Button Memory Recall
function xcalc_mr()
    xcalc_display(XCALC_MEMORYNUMBER);
end

--Sets up the function keys ie, + - * / =
function xcalc_funckey(key)
	currText = XCALC_NUMBERDISPLAY;
    if ( IsShiftKeyDown() and key == "=" ) then
        ChatFrame_OpenChat("");
        return;
    end
	if (XCALC_PREVIOUSKEYTYPE=="none" or XCALC_PREVIOUSKEYTYPE=="num" or XCALC_PREVIOUSKEYTYPE=="state") then
			if (key == "/" or key == "*" or key == "-" or key == "-" or key == "+" or key == "^") then
					
				if (XCALC_PREVIOUSOP~="") then
					temp = xcalc_parse(XCALC_RUNNINGTOTAL .. XCALC_PREVIOUSOP .. currText);
					currText = xcalc_xcalculate(temp);
				end
				XCALC_RUNNINGTOTAL = currText;
				XCALC_PREVIOUSOP = key;
			elseif (key == "=") then
				if (XCALC_PREVIOUSOP~="=" and XCALC_PREVIOUSOP~="") then
					temp = xcalc_parse(XCALC_RUNNINGTOTAL .. XCALC_PREVIOUSOP .. currText);
					currText = xcalc_xcalculate(temp);
					XCALC_RUNNINGTOTAL = currText;
					XCALC_PREVIOUSOP="=";
				end
			else
			
			end
				
	else --must be a func key, a second+ time
		if (key == "/" or key == "*" or key == "-" or key == "-" or key == "+" or key == "^") then
			XCALC_PREVIOUSOP=key;
		else
			XCALC_PREVIOUSOP="";
		end 
	end
	XCALC_PREVIOUSKEYTYPE = "func";
	xcalc_display(currText);
end

--Manage Number Inputs
function xcalc_numkey(key)
	currText = XCALC_NUMBERDISPLAY;

	if (XCALC_PREVIOUSKEYTYPE=="none" or XCALC_PREVIOUSKEYTYPE=="num" or XCALC_PREVIOUSKEYTYPE=="state")then
		if (key == ".") then
			if (string.find(currText, "c") == nil) then
				if (string.find(currText, "s") == nil) then
					if (string.find(currText, "g") == nil) then
						if (string.find(currText, "%.") == nil) then
							currText = currText .. ".";
						end
					end
				end
			end
		else
			if (currText == "0") then
				currText = "";
			end	

			currText = currText .. key;
		end
	else
		if (key == ".") then
			currText = "0.";
		else
			currText = key;
		end
	end

	XCALC_PREVIOUSKEYTYPE = "num";
    xcalc_display(currText);
end

--Send the number display to an open chatbox
function xcalc_numberdisplay_click(button, ignoreShift)
	if ( button == "LeftButton" ) then
		if ( IsShiftKeyDown() and not ignoreShift ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(XCALC_NUMBERDISPLAY);
			end
		end
	end
end

--Tooltip display
function xcalc_tooltip(mouseover)
    if ( mouseover == "minimap" ) then
        GameTooltip:SetOwner(xcalc_minimap_button , "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetText("Show/Hide xcalc")
    else
        GameTooltip : Hide ()
    end
end

--[[-----------------------------------------------------------------------------------
    Where the Calculations occur
    On a side note, Simple is easier, getting into complex if/then/elseif/else statements
    to perform math functions may introduce unexpected results... maybe.
    -----------------------------------------------------------------------------------]]
function xcalc_xcalculate(expression)
	local tempvar = "QCExpVal";

	setglobal(tempvar, nil);
	RunScript(tempvar .. "=(" .. expression .. ")");
	local result = getglobal(tempvar);

	return result;
end

--This function parses the input for the money functions
function xcalc_parse(expression)
	local ismoney = false;

	newexpression = expression

	local newexpression = string.gsub(newexpression, "ans", XCALC_CONSOLE_LAST_ANS);

	-- g s c
	local newexpression = string.gsub(newexpression, "%d+g%d+s%d+c", function (a)
			ismoney = true;
			return FromGSC(a);
		end );

	-- g s
	local newexpression = string.gsub(newexpression, "%d+g%d+s", function (a)
			ismoney = true;
			return FromGSC(a);
		end );


	-- g   c
	local newexpression = string.gsub(newexpression, "%d+g%d+c", function (a)
			ismoney = true;
			return FromGSC(a);
		end );

	-- g         allows #.#
	local newexpression = string.gsub(newexpression, "%d+%.?%d*g", function (a)
			ismoney = true;
			return FromGSC(a);
		end );

	--   s c
	local newexpression = string.gsub(newexpression, "%d+s%d+c", function (a)
			ismoney = true;
			return FromGSC(a);
		end );

	--   s       allows #.#
	local newexpression = string.gsub(newexpression, "%d+%.?%d*s", function (a)
			ismoney = true;
			return FromGSC(a);
		end );

	--     c
	local newexpression = string.gsub(newexpression, "%d+c", function (a)
			ismoney = true;
			return FromGSC(a);
		end );


	if (ismoney) then
		newexpression = "ToGSC(" .. newexpression .. ")";
	end

	return newexpression
end

--The following two functions do the to and from gold calculations
function ToGSC(decimal, std)
	local gold = 0;
	local silver = 0;
	local copper = 0;

	if (std == "gold") then
		copper = math.mod(decimal, .01);
		decimal = decimal - copper;
		copper = copper * 10000

		silver = math.mod(decimal, 1);
		decimal = decimal - silver;
		silver = silver * 100;

		gold = decimal;
	elseif (std == "silver") then
		copper = math.mod(decimal, 1);
		decimal = decimal - copper;
		copper = copper * 100;

		silver = math.mod(decimal, 100);
		decimal = decimal - silver;

		gold = decimal / 100;
	else
		copper = math.mod(decimal, 100);
		decimal = decimal - copper;

		silver = math.mod(decimal, 10000);
		decimal = decimal - silver;
		silver = silver / 100;

		gold = decimal / 10000;
	end

	local temp = "";

	if (gold > 0) then
		temp = temp .. gold .. "g";
	end
	if (silver > 0 or (gold > 0 and copper > 0)) then
		temp = temp .. silver .. "s";
	end
	if (copper > 0) then
		temp = temp .. copper .. "c";
	end

	return temp;
end

function FromGSC(gold, silver, copper)
	if (gold == nil) then
		return "";
	end

	local total = 0;

	if (type(gold) == "string" and (not silver or type(silver) == "nil") and (not copper or type(copper) == "nil")) then
		local temp = gold;
		
		golds,golde = string.find(temp, "%d*%.?%d*g");
		if (golds == nil) then
			gold = 0;
		else
			gold = string.sub(temp, golds, golde - 1);
		end
	
		silvers,silvere = string.find(temp, "%d*%.?%d*s");
		if (silvers == nil) then
			silver = 0;
		else
			silver = string.sub(temp, silvers, silvere - 1);
		end

		coppers,coppere = string.find(temp, "%d*c");
		if (coppers == nil) then
			copper = 0;
		else
			copper = string.sub(temp, coppers, coppere - 1);
		end
	end

	total = total + copper;
	total = total + (silver * 100);
	total = total + (gold * 10000);

	return "" .. total;
end