--[[
    This file contains all the GUI instructions.
    I decided on creating the entire gui via lua instead of xml for several reasons.
    There is a "LOT" of optimization still to be done in this file I am more interested
    in generating a base form and set of files to update from.
    ]]

function xcalc_windowframe()
    --Main Window Frame (container) and title bar
    local frame = CreateFrame("Frame","xcalc_window",UIParent);
    frame:SetFrameStrata("HIGH");
    frame:EnableMouse(true);
    frame:EnableKeyboard(true);
    frame:SetMovable(true);
    frame:SetHeight(307);
    frame:SetWidth(240);
    frame:SetScript("OnMouseDown", function() frame:StartMoving() end);
    frame:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() end);
    frame:SetScript("OnShow", function() xcalc_rebind() end);
    frame:SetScript("OnHide", function() xcalc_unbind() end);
    frame:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
                        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                        tile = true, tileSize = 32, edgeSize = 32,
                        insets = { left = 11, right = 12, top = 12, bottom = 11 }});
    frame:SetPoint("CENTER",0,0);
    local titletexture = frame:CreateTexture("xcalc_window_titletexture");
    titletexture:SetHeight(32);
    titletexture:SetWidth(160);
    titletexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header");
    titletexture:SetTexCoord(0.2, 0.8, 0, 0.6);
    titletexture:SetPoint("TOP",0,5);
    local titlefont = frame:CreateFontString("xcalc_windowtest_titlefont");
    titlefont:SetHeight(0);
    titlefont:SetWidth(140);
    titlefont:SetFont("Fonts/FRIZQT__.TTF",12);
    titlefont:SetPoint("TOP",0,-4);
    titlefont:SetTextColor(1,0.8196079,0);
    titlefont:SetText("xcalc v" .. XCALC_VERSION);
    --Number Display box
    local numberdisplaybackground = frame:CreateTexture("xcalc_numberdisplaybackground");
    numberdisplaybackground:SetHeight(34);
    numberdisplaybackground:SetWidth(215);
    numberdisplaybackground:SetTexture("interface/chatframe/ui-chatinputborder");
    numberdisplaybackground:SetPoint("TOPLEFT",10,-33);
    local numberdisplay = frame:CreateFontString("xcalc_numberdisplay","GameFontWhite");
    numberdisplay:SetHeight(34);
    numberdisplay:SetWidth(205);
    numberdisplay:SetFont("Fonts/FRIZQT__.TTF",12);
    numberdisplay:SetJustifyH("RIGHT");
    numberdisplay:SetPoint("TOPLEFT",10,-33);
    numberdisplay:SetText(XCALC_NUMBERDISPLAY);
    --Memory Display
    local memorydisplay = frame:CreateFontString("xcalc_memorydisplay","GameFontNormal");
    memorydisplay:SetWidth(29);
    memorydisplay:SetHeight(29);
    memorydisplay:SetFont("Fonts/FRIZQT__.TTF",12);
    memorydisplay:SetPoint("TOPLEFT",15,-73);
    --memorydisplay:SetText("M");
    --ExitButton
    local exitbutton = CreateFrame("Button", "xcalc_exitbutton",frame,"UIPanelCloseButton");
    exitbutton:SetPoint("TOPRIGHT",-4,-4);
    --Backspace Button
    local backspacebutton = CreateFrame("Button", "backspacebutton",frame,"UIPanelButtonTemplate");
    backspacebutton:SetWidth(75);
    backspacebutton:SetHeight(29);
    backspacebutton:SetPoint("TOPLEFT",50,-73);
    backspacebutton:SetText("Backspace");
    backspacebutton:SetScript("OnClick", function() xcalc_backspace() end);
    --CE button
    local cebutton = CreateFrame("Button", "cebutton",frame,"UIPanelButtonTemplate");
    cebutton:SetWidth(41);
    cebutton:SetHeight(29);
    cebutton:SetPoint("TOPLEFT",131,-73);
    cebutton:SetText("CE");
    cebutton:SetScript("OnClick", function() xcalc_ce() end);
    --Clear Button
    local cbutton = CreateFrame("Button", "cbutton",frame,"UIPanelButtonTemplate");
    cbutton:SetWidth(41);
    cbutton:SetHeight(29);
    cbutton:SetPoint("TOPLEFT",178,-73);
    cbutton:SetText("C");
    cbutton:SetScript("OnClick", function() xcalc_clear() end);
    --Equals Button
    local equalbutton = CreateFrame("Button", "equalbutton",frame,"UIPanelButtonTemplate");
    equalbutton:SetWidth(29);
    equalbutton:SetHeight(70);
    equalbutton:SetPoint("TOPLEFT",190,-183);
    equalbutton:SetText("=");
    equalbutton:SetScript("OnClick", function() xcalc_funckey("=") end);
    --Exp Button
    local expbutton = CreateFrame("Button", "expbutton",frame,"UIPanelButtonTemplate");
    expbutton:SetWidth(29);
    expbutton:SetHeight(32);
    expbutton:SetPoint("TOPLEFT",190,-146);
    expbutton:SetText("^");
    expbutton:SetScript("OnClick", function() xcalc_funckey("^") end);
    --Plus Minus Button
    local pmbutton = CreateFrame("Button", "pmbutton",frame,"UIPanelButtonTemplate");
    pmbutton:SetWidth(29);
    pmbutton:SetHeight(32);
    pmbutton:SetPoint("TOPLEFT",190,-108);
    pmbutton:SetText("+/-");
    pmbutton:SetScript("OnClick", function() xcalc_plusminus() end);
    --Plus Button
    local plusbutton = CreateFrame("Button", "plusbutton",frame,"UIPanelButtonTemplate");
    plusbutton:SetWidth(29);
    plusbutton:SetHeight(32);
    plusbutton:SetPoint("TOPLEFT",155,-221);
    plusbutton:SetText("+");
    plusbutton:SetScript("OnClick", function() xcalc_funckey("+") end);
    --Minus Button
    local minuxbutton = CreateFrame("Button", "minusbutton",frame,"UIPanelButtonTemplate");
    minusbutton:SetWidth(29);
    minusbutton:SetHeight(32);
    minusbutton:SetPoint("TOPLEFT",155,-183);
    minusbutton:SetText("-");
    minusbutton:SetScript("OnClick", function() xcalc_funckey("-") end);
    --Multiply Button
    local multiplybutton = CreateFrame("Button", "multiplybutton",frame,"UIPanelButtonTemplate");
    multiplybutton:SetWidth(29);
    multiplybutton:SetHeight(32);
    multiplybutton:SetPoint("TOPLEFT",155,-146);
    multiplybutton:SetText("*");
    multiplybutton:SetScript("OnClick", function() xcalc_funckey("*") end);
    --Divide Button
    local dividebutton = CreateFrame("Button", "dividebutton",frame,"UIPanelButtonTemplate");
    dividebutton:SetWidth(29);
    dividebutton:SetHeight(32);
    dividebutton:SetPoint("TOPLEFT",155,-108);
    dividebutton:SetText("/");
    dividebutton:SetScript("OnClick", function() xcalc_funckey("/") end);
    --Copper Button
    local copperbutton = CreateFrame("Button", "copperbutton",frame,"UIPanelButtonTemplate");
    copperbutton:SetWidth(29);
    copperbutton:SetHeight(32);
    copperbutton:SetPoint("TOPLEFT",120,-259);
    copperbutton:SetText("c");
    copperbutton:SetScript("OnClick", function() xcalc_statecopper() end);
    --Silver Button
    local silverbutton = CreateFrame("Button", "silverbutton",frame,"UIPanelButtonTemplate");
    silverbutton:SetWidth(29);
    silverbutton:SetHeight(32);
    silverbutton:SetPoint("TOPLEFT",85,-259);
    silverbutton:SetText("s");
    silverbutton:SetScript("OnClick", function() xcalc_statesilver() end);
    --Gold Button
    local goldbutton = CreateFrame("Button", "goldbutton",frame,"UIPanelButtonTemplate");
    goldbutton:SetWidth(29);
    goldbutton:SetHeight(32);
    goldbutton:SetPoint("TOPLEFT",50,-259);
    goldbutton:SetText("g");
    goldbutton:SetScript("OnClick", function() xcalc_stategold() end);
    --Decimal Button
    local decimalbutton = CreateFrame("Button", "decimalbutton",frame,"UIPanelButtonTemplate");
    decimalbutton:SetWidth(29);
    decimalbutton:SetHeight(32);
    decimalbutton:SetPoint("TOPLEFT",120,-221);
    decimalbutton:SetText(".");
    decimalbutton:SetScript("OnClick", function() xcalc_numkey(".") end);
    --0 button
    local zerobutton = CreateFrame("Button", "zerobutton",frame,"UIPanelButtonTemplate");
    zerobutton:SetWidth(64);
    zerobutton:SetHeight(32);
    zerobutton:SetPoint("TOPLEFT",50,-222);
    zerobutton:SetText("0");
    zerobutton:SetScript("OnClick", function() xcalc_numkey("0") end);
    --3 button
    local threebutton = CreateFrame("Button", "threebutton",frame,"UIPanelButtonTemplate");
    threebutton:SetWidth(29);
    threebutton:SetHeight(32);
    threebutton:SetPoint("TOPLEFT",120,-183);
    threebutton:SetText("3");
    threebutton:SetScript("OnClick", function() xcalc_numkey("3") end);
    --2 Button
    local twobutton = CreateFrame("Button", "twobutton",frame,"UIPanelButtonTemplate");
    twobutton:SetWidth(29);
    twobutton:SetHeight(32);
    twobutton:SetPoint("TOPLEFT",85,-183);
    twobutton:SetText("2");
    twobutton:SetScript("OnClick", function() xcalc_numkey("2") end);
    --1 Button
    local onebutton = CreateFrame("Button", "onebutton",frame,"UIPanelButtonTemplate");
    onebutton:SetWidth(29);
    onebutton:SetHeight(32);
    onebutton:SetPoint("TOPLEFT",50,-184);
    onebutton:SetText("1");
    onebutton:SetScript("OnClick", function() xcalc_numkey("1") end);
    --6 Button
    local sixbutton = CreateFrame("Button", "sixbutton",frame,"UIPanelButtonTemplate");
    sixbutton:SetWidth(29);
    sixbutton:SetHeight(32);
    sixbutton:SetPoint("TOPLEFT",120,-146);
    sixbutton:SetText("6");
    sixbutton:SetScript("OnClick", function() xcalc_numkey("6") end);
    --5 Button
    local fivebutton = CreateFrame("Button", "fivebutton",frame,"UIPanelButtonTemplate");
    fivebutton:SetWidth(29);
    fivebutton:SetHeight(32);
    fivebutton:SetPoint("TOPLEFT",85,-146);
    fivebutton:SetText("5");
    fivebutton:SetScript("OnClick", function() xcalc_numkey("5") end);
    --4 Button
    local fourbutton = CreateFrame("Button", "fourbutton",frame,"UIPanelButtonTemplate");
    fourbutton:SetWidth(29);
    fourbutton:SetHeight(32);
    fourbutton:SetPoint("TOPLEFT",50,-146);
    fourbutton:SetText("4");
    fourbutton:SetScript("OnClick", function() xcalc_numkey("4") end);
    --9 Button
    local ninebutton = CreateFrame("Button", "ninebutton",frame,"UIPanelButtonTemplate");
    ninebutton:SetWidth(29);
    ninebutton:SetHeight(32);
    ninebutton:SetPoint("TOPLEFT",120,-108);
    ninebutton:SetText("9");
    ninebutton:SetScript("OnClick", function() xcalc_numkey("9") end);
    --8 Button
    local eightbutton = CreateFrame("Button", "eightbutton",frame,"UIPanelButtonTemplate");
    eightbutton:SetWidth(29);
    eightbutton:SetHeight(32);
    eightbutton:SetPoint("TOPLEFT",85,-108);
    eightbutton:SetText("8");
    eightbutton:SetScript("OnClick", function() xcalc_numkey("8") end);
    --7 Button
    local sevenbutton = CreateFrame("Button", "sevenbutton",frame,"UIPanelButtonTemplate");
    sevenbutton:SetWidth(29);
    sevenbutton:SetHeight(32);
    sevenbutton:SetPoint("TOPLEFT",50,-108);
    sevenbutton:SetText("7");
    sevenbutton:SetScript("OnClick", function() xcalc_numkey("7") end);
    --Memory Add Button
    local mabutton = CreateFrame("Button", "mabutton",frame,"UIPanelButtonTemplate");
    mabutton:SetWidth(29);
    mabutton:SetHeight(32);
    mabutton:SetPoint("TOPLEFT",15,-221);
    mabutton:SetText("MA");
    mabutton:SetScript("OnClick", function() xcalc_ma() end);
    --Memory Store Button
    local msbutton = CreateFrame("Button", "msbutton",frame,"UIPanelButtonTemplate");
    msbutton:SetWidth(29);
    msbutton:SetHeight(32);
    msbutton:SetPoint("TOPLEFT",15,-183);
    msbutton:SetText("MS");
    msbutton:SetScript("OnClick", function() xcalc_ms() end);
    --Memory Recall Button
    local mrbutton = CreateFrame("Button", "mrbutton",frame,"UIPanelButtonTemplate");
    mrbutton:SetWidth(29);
    mrbutton:SetHeight(32);
    mrbutton:SetPoint("TOPLEFT",15,-146);
    mrbutton:SetText("MR");
    mrbutton:SetScript("OnClick", function() xcalc_mr() end);
    --Memory Clear Button
    local mcbutton = CreateFrame("Button", "mcbutton",frame,"UIPanelButtonTemplate");
    mcbutton:SetWidth(29);
    mcbutton:SetHeight(32);
    mcbutton:SetPoint("TOPLEFT",15,-108);
    mcbutton:SetText("MC");
    mcbutton:SetScript("OnClick", function() xcalc_mc() end);
    --Option show button
    local optionbutton = CreateFrame("Button", "xcalc_optionwindow_button",frame,"UIPanelButtonTemplate");
    optionbutton:SetWidth(70);
    optionbutton:SetHeight(25);
    optionbutton:SetPoint("BOTTOMRIGHT",-15,15)
    optionbutton:SetText("Options");
    optionbutton:SetScript("OnClick", function() xcalc_optiondisplay() end);
    xcalc_rebind();
    frame:Show();
    tinsert(UISpecialFrames,"xcalc_window");
end

function xcalc_optionframe()
    --Options window Frame
    local frame = CreateFrame("Frame","xcalc_optionwindow",xcalc_window);
    frame:SetFrameStrata("HIGH");
    frame:EnableMouse(true);
    frame:SetWidth(220);
    frame:SetHeight(200);
    frame:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
                        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                        tile = true, tileSize = 32, edgeSize = 32,
                        insets = { left = 11, right = 12, top = 12, bottom = 11 }});
    frame:SetPoint("CENTER",230,0);
    local titletexture = frame:CreateTexture("xcalc_optionwindow_titletexture");
    titletexture:SetHeight(32);
    titletexture:SetWidth(160);
    titletexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header");
    titletexture:SetTexCoord(0.2, 0.8, 0, 0.6);
    titletexture:SetPoint("TOP",0,5);
    local titlefont = frame:CreateFontString("xcalc_optionwindow_titlefont");
    titlefont:SetHeight(0);
    titlefont:SetWidth(140);
    titlefont:SetFont("Fonts/FRIZQT__.TTF",12);
    titlefont:SetPoint("TOP",0,-4);
    titlefont:SetTextColor(1,0.8196079,0);
    titlefont:SetText("Xcalc Options");
    --Options Okay Button
    local okaybutton = CreateFrame("Button", "xcalc_optionokaybutton",frame,"UIPanelButtonTemplate");
    okaybutton:SetWidth(70);
    okaybutton:SetHeight(29);
    okaybutton:SetPoint("BOTTOM",0,20);
    okaybutton:SetText("Okay");
    okaybutton:SetScript("OnClick", function() xcalc_optiondisplay() end);
    --Binding Check box
    local bindingcheckbox = CreateFrame("CheckButton","xcalc_options_bindcheckbox",frame,"OptionsCheckButtonTemplate");
    bindingcheckbox:SetPoint("TOPLEFT",15,-40);
    bindingcheckbox:SetChecked(Xcalc_Settings.Binding);
    bindingcheckbox:SetScript("OnClick", function() xcalc_options_binding() end);
    local bindingcheckboxtext = frame:CreateFontString("xcalc_options_bindcheckboxtext");
    bindingcheckboxtext:SetWidth(200);
    bindingcheckboxtext:SetHeight(0);
    bindingcheckboxtext:SetFont("Fonts/FRIZQT__.TTF",10);
    bindingcheckboxtext:SetTextColor(1,0.8196079,0);
    bindingcheckboxtext:SetJustifyH("LEFT");
    bindingcheckboxtext:SetText("Use Automatic Key Bindings");
    bindingcheckboxtext:SetPoint("LEFT","xcalc_options_bindcheckbox",30,0);
    --Display Minimap Check Box
    local minimapcheckbox = CreateFrame("CheckButton","xcalc_options_minimapcheckbox",frame,"OptionsCheckButtonTemplate");
    minimapcheckbox:SetPoint("TOPLEFT",15,-70);
    minimapcheckbox:SetChecked(Xcalc_Settings.Minimapdisplay);
    minimapcheckbox:SetScript("OnClick", function() xcalc_options_minimapdisplay() end);
    local minimapcheckboxtext = minimapcheckbox:CreateFontString("xcalc_options_minimapcheckboxtext");
    minimapcheckboxtext:SetWidth(200);
    minimapcheckboxtext:SetHeight(0);
    minimapcheckboxtext:SetFont("Fonts/FRIZQT__.TTF",10);
    minimapcheckboxtext:SetTextColor(1,0.8196079,0);
    minimapcheckboxtext:SetJustifyH("LEFT");
    minimapcheckboxtext:SetText("Display Minimap Icon");
    minimapcheckboxtext:SetPoint("LEFT","xcalc_options_minimapcheckbox",30,0);
    --Minimap Position Slider
    local minimapslider = CreateFrame("Slider","xcalc_options_minimapslider",frame,"OptionsSliderTemplate");
    minimapslider:SetWidth(180);
    minimapslider:SetHeight(16);
    minimapslider:SetMinMaxValues(0, 360);
    minimapslider:SetValueStep(1);
    minimapslider:SetScript("OnValueChanged", function() xcalc_options_minimapslidercontrol() end);
    xcalc_options_minimapsliderHigh:SetText();
    xcalc_options_minimapsliderLow:SetText();
    xcalc_options_minimapsliderText:SetText("Minimap Button Position");
    minimapslider:SetPoint("TOPLEFT",15,-120);
    minimapslider:SetValue(Xcalc_Settings.Minimappos);

    frame:Show();
end

function xcalc_minimap_init()
    if (Xcalc_Settings.Minimapdisplay == 1) then
        local frame = CreateFrame("Button","xcalc_minimap_button",Minimap);
        frame:SetWidth(34);
        frame:SetHeight(34);
        frame:SetFrameStrata("LOW");
        frame:SetToplevel(1);
        frame:SetNormalTexture("Interface\\AddOns\\xcalc\\xcalc_ButtonRoundNormal.tga");
        frame:SetPushedTexture("Interface\\AddOns\\xcalc\\xcalc_ButtonRoundPushed.tga");
        frame:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");
        frame:SetScript("OnClick", function() xcalc_windowdisplay() end);
        frame:SetScript("OnEnter", function() xcalc_tooltip("minimap") end);
        frame:SetScript("OnLeave", function() xcalc_tooltip("hide") end);
        xcalc_minimapbutton_updateposition();
        frame:Show();
    end
end

function xcalc_minimapbutton_updateposition()

   xcalc_minimap_button:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
         54 - (78 * cos(Xcalc_Settings.Minimappos)),
         (78 * sin(Xcalc_Settings.Minimappos)) - 55)

end