
--[[

EmoteButtons

author: QuippeR		<quipper@gmail.com>

Adds a menu to access emotes and slash commands.

Feel free to contact me if you've got questions, comments, requests or additions.

Shift click a button to get to the options.


]]--


--------------------------------------------------------------
--      Don't change code unless you know what you do!      --
--------------------------------------------------------------


EmoteButtons_FirstLevel =
	{"EmoteButtons_01", "EmoteButtons_02", "EmoteButtons_03", "EmoteButtons_04",
	 "EmoteButtons_05", "EmoteButtons_06", "EmoteButtons_07", "EmoteButtons_08"};
EmoteButtons_FirstLevelCount = getn(EmoteButtons_FirstLevel);

EmoteButtons_WingCount = 6;

EmoteButtons_LeftWingCount = 6;
EmoteButtons_LeftWing = 
	{"EmoteButtons_10", "EmoteButtons_11", "EmoteButtons_12",
	 "EmoteButtons_14", "EmoteButtons_15", "EmoteButtons_16"};
EmoteButtons_LeftWing_Deck = "#0";

EmoteButtons_RightWingCount = 6;
EmoteButtons_RightWing = 
	{"EmoteButtons_20", "EmoteButtons_21", "EmoteButtons_22",
	 "EmoteButtons_24", "EmoteButtons_25", "EmoteButtons_26"};
EmoteButtons_RightWing_Deck = "#0";

EmoteButtons_DeckList =
	{"Deck 1", "Deck 2", "Deck 3", "Deck 4", "Deck 5", "Deck 6", "Deck 7", "Deck 8"};
EmoteButtons_DecksCount = getn(EmoteButtons_DeckList);

EmoteButtons_FirstLevelName = "Main";

EmoteButtons_LevelShown = 0;

EmoteButtons_ConfigDeck = "#0";
EmoteButtons_ConfigButton = 0;

--needed hack
EmoteButtons_CanChangeSlider = false;

--image slider
EmoteButtons_ImageSlideCenter = floor(EmoteButtons_ImageCount/2);
EmoteButtons_LastSlide = 0;


function EmoteButtons_WipeVars()
	local i,j;
	local inr = EmoteButtons_ImageCount;
EmoteButtons_Vars = {
	Actions = {
		["Main"] = {
				{action="", tooltip="", image="", wing="Left"},
				{action="", tooltip="", image="", wing="Left"},
				{action="", tooltip="", image="", wing="Left"},
				{action="", tooltip="", image="", wing="Left"},
				{action="", tooltip="", image="", wing="Right"},
				{action="", tooltip="", image="", wing="Right"},
				{action="", tooltip="", image="", wing="Right"},
				{action="", tooltip="", image="", wing="Right"} },
		["Deck 1"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
		["Deck 2"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
		["Deck 3"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
		["Deck 4"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
		["Deck 5"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
		["Deck 6"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
		["Deck 7"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
		["Deck 8"] = { {action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""},
				{action="", tooltip="", image=""} },
	},
	Main_Ratio = 42,
	Main_Shift = 0,
	Wing_Shift = 0,
};
	for i=1, EmoteButtons_FirstLevelCount do
		EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][i].action = EMOTEBUTTONS_SE[EmoteButtons_FirstLevelName][i].action;
		EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][i].tooltip = EMOTEBUTTONS_SE[EmoteButtons_FirstLevelName][i].tooltip;
		EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][i].image = EmoteButtons_ImageList[math.random(inr)];
	end

	for i=1, EmoteButtons_DecksCount do
		for j=1, EmoteButtons_WingCount do
			EmoteButtons_Vars.Actions[EmoteButtons_DeckList[i]][j].action = EMOTEBUTTONS_SE[EmoteButtons_DeckList[i]][j].action;
			EmoteButtons_Vars.Actions[EmoteButtons_DeckList[i]][j].tooltip = EMOTEBUTTONS_SE[EmoteButtons_DeckList[i]][j].tooltip;
			EmoteButtons_Vars.Actions[EmoteButtons_DeckList[i]][j].image = EmoteButtons_ImageList[math.random(inr)];
		end
	end
end

EmoteButtons_WipeVars();

function EmoteButtons_Reset()
	EmoteButtons_LeftWing_Deck = "#0";
	EmoteButtons_RightWing_Deck = "#0";
	EmoteButtons_ToggleFirstLevel();
	EmoteButtons_WipeVars();
end

function EmoteButtons_Init()
	local i;
	for i = 1, EmoteButtons_FirstLevelCount do
		CreateFrame("Button", EmoteButtons_FirstLevel[i], EmoteButtons_Main, "EmoteButtons_template");
	end
	for i = 1, EmoteButtons_LeftWingCount do
		CreateFrame("Button", EmoteButtons_LeftWing[i], EmoteButtons_Main, "EmoteButtons_template");
	end
	for i = 1, EmoteButtons_RightWingCount do
		CreateFrame("Button", EmoteButtons_RightWing[i], EmoteButtons_Main, "EmoteButtons_template");
	end
	
	EmoteButtons_Config_SetMainShiftTitle:SetText(EMOTEBUTTONS_ROTATION);
	EmoteButtons_Config_SetMainSizeTitle:SetText(EMOTEBUTTONS_SIZE);

	UIErrorsFrame:AddMessage(EMOTEBUTTONS_INIT_TEXT, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

end

function EmoteButtons_LoadedVars()

	EmoteButtons_Config_SetMainShift:SetValue(EmoteButtons_Vars.Main_Shift);
	EmoteButtons_Config_SetMainSize:SetValue(EmoteButtons_Vars.Main_Ratio);


	EmoteButtons_ArrangeFrames();

end

function EmoteButtons_ArrangeFrames()

	local i, obj, correction;

--button size
	local mra = EmoteButtons_Vars.Main_Ratio;
--icon size inside the button
	local mri = floor(0.6*mra);
--main deck distance from center
	local mr = floor(mra*1.29);
--main deck shift in degrees
	local ms = EmoteButtons_Vars.Main_Shift;
--main deck correction to get eclipse
	local mrc = floor(mr/5);
--wings distance from center
	local wr = floor(mra*2.29);
--wings shift in degrees
	local ws = EmoteButtons_Vars.Wing_Shift;


	--main button
	obj=EmoteButtons_Main;
	obj:SetWidth(mra);
	obj:SetHeight(mra);
	obj = getglobal(obj:GetName().."_Icon");
	obj:SetWidth(mri);
	obj:SetHeight(mri);

	--main deck
	local size = EmoteButtons_FirstLevelCount+2;
	local deg = floor(360/size);
	local shift = 0;
	for i=1, size-1 do
		if i ~= size/2 then
			if (i == 1) or (i == (size/2-1)) then
				correction = mrc;
			elseif (i == (size/2+1)) or (i == size - 1) then
				correction = - mrc;
			else
				correction = 0;
			end
			obj = getglobal(EmoteButtons_FirstLevel[i+shift]);
			obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", - mr*sin(i*deg+ms)+correction*cos(ms),mr*cos(i*deg+ms)+correction*sin(ms));
			obj:SetWidth(mra);
			obj:SetHeight(mra);
			obj = getglobal(obj:GetName().."_Icon");
			obj:SetWidth(mri);
			obj:SetHeight(mri);
		else
			shift = -1;
		end
	end
	
	--left wing
	size = EmoteButtons_LeftWingCount+3;
	deg = floor(180/size)
	shift = -1;
	for i=2, size-2 do
		obj = getglobal(EmoteButtons_LeftWing[i+shift]);
		obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", - wr*sin(i*deg+ws),wr*cos(i*deg+ws));
		obj:SetWidth(mra);
		obj:SetHeight(mra);
		obj = getglobal(obj:GetName().."_Icon");
		obj:SetWidth(mri);
		obj:SetHeight(mri);
	end

	--right wing
	size = EmoteButtons_RightWingCount+3;
	deg = floor(180/size)
	shift = -1;
	for i=2, size-2 do
		obj = getglobal(EmoteButtons_RightWing[i+shift]);
		obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", wr*sin(i*deg-ws),wr*cos(i*deg-ws));
		obj:SetWidth(mra);
		obj:SetHeight(mra);
		obj = getglobal(obj:GetName().."_Icon");
		obj:SetWidth(mri);
		obj:SetHeight(mri);
	end
end

function FadeOutFrame( frame, time )
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = frame:GetAlpha()
	fadeInfo.endAlpha = 0
	fadeInfo.finishedFunc = FadeFinished
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "OUT"
	UIFrameFade( frame, fadeInfo );
	frame:EnableMouse( false );
end

function FadeInFrame( frame, time )
	local fadeInfo = {}
	fadeInfo.mode = "IN"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1
	fadeInfo.finishedFunc = FadeFinished
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "IN"
	UIFrameFade( frame, fadeInfo );
	frame:Show();
	frame:EnableMouse( true );
end

function EmoteButtons_FadeIn(frame, time, alpha)
	local fadeInfo = {}
	fadeInfo.mode = "IN"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = frame:GetAlpha()
	fadeInfo.endAlpha = alpha
	fadeInfo.finishedFunc = nil
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "IN"
	UIFrameFade( frame, fadeInfo );
end

function EmoteButtons_FadeOut( frame, time, alpha )
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = frame:GetAlpha()
	fadeInfo.endAlpha = alpha
	fadeInfo.finishedFunc = nil
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "OUT"
	UIFrameFade( frame, fadeInfo );
end

function FadeFinished( frame )
	if ( frame.fadeMode == "OUT" ) then
		frame:Hide()
	end
	frame.fadeMode = nil
end

function EmoteButtons_ToggleFirstLevel()
	local i=0;
	local image;
	local obj;
	local flc = getn(EmoteButtons_FirstLevel);
	if (getglobal(EmoteButtons_LeftWing[1])):IsShown() then
		EmoteButtons_ToggleLeftWing();
	end
	if (getglobal(EmoteButtons_RightWing[1])):IsShown() then
		EmoteButtons_ToggleRightWing();
	end
	for i=1, flc do
		obj = getglobal(EmoteButtons_FirstLevel[i]);
		if EmoteButtons_LevelShown > 0 then
			FadeOutFrame(obj,0.1*i);
		else
			image = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][i].image;
			getglobal(EmoteButtons_FirstLevel[i].."_Icon"):SetTexture("Interface\\Icons\\"..image);
			FadeInFrame(obj,0.15*(flc-i));
		end
	end
	if EmoteButtons_LevelShown == 0 then
		EmoteButtons_LevelShown = 1;
	else
		EmoteButtons_LevelShown = 0;
	end
end

function EmoteButtons_ToggleLeftWing()
	local i=0
	local obj;
	local lwc = getn(EmoteButtons_LeftWing);
	for i=1, lwc do
		obj = getglobal(EmoteButtons_LeftWing[i]);
		if ((EmoteButtons_LevelShown == 3) or (EmoteButtons_LevelShown == 6)) then
			FadeOutFrame(obj, 0.1*i);
		else
			FadeInFrame(obj,0.15*(lwc-i));
		end
	end
	if ((EmoteButtons_LevelShown == 3) or (EmoteButtons_LevelShown == 6)) then
		EmoteButtons_LevelShown = EmoteButtons_LevelShown - 2;
	else
		EmoteButtons_LevelShown = EmoteButtons_LevelShown + 2;
	end
end

function EmoteButtons_ToggleRightWing()
	local i=0
	local obj;
	local rwc = getn(EmoteButtons_RightWing);
	for i=1, rwc do
		obj = getglobal(EmoteButtons_RightWing[i]);
		if ((EmoteButtons_LevelShown == 4) or (EmoteButtons_LevelShown == 6)) then
			FadeOutFrame(obj, 0.1*i);
		else
			FadeInFrame(obj,0.15*(rwc-i));
		end
	end
	if ((EmoteButtons_LevelShown == 4) or (EmoteButtons_LevelShown == 6)) then
		EmoteButtons_LevelShown = EmoteButtons_LevelShown - 3;
	else
		EmoteButtons_LevelShown = EmoteButtons_LevelShown + 3;
	end
end

function EmoteButtons_FadeWing(wing)
	local i=0;
	local obj;
	local wingT, wingC;
	if wing == "left" then
		wingT=EmoteButtons_LeftWing;
	else
		wingT=EmoteButtons_RightWing;
	end
	wingC=getn(wingT);
	for i=1, wingC do
		obj=getglobal(wingT[i]);
		FadeInFrame(obj, 0.1*i);
	end
end

function EmoteButtons_ClickAction(framename)
	local i;
	local found = 0;
	local action = "";
	local tooltip = "";
	local wing = "";

	for i=1, EmoteButtons_FirstLevelCount do
		if EmoteButtons_FirstLevel[i] == framename then
			found = i;
		end
	end
	if found~=0 then
		action = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].action;
		tooltip = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].tooltip;
		wing = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].wing;
	--configure
		if IsShiftKeyDown() then
			EmoteButtons_ConfigDeck = EmoteButtons_FirstLevelName;
			EmoteButtons_ConfigButton = found;
			EmoteButtons_UpdateConfig();
		elseif EmoteButtons_IsADeck(action) then
			EmoteButtons_ToggleDeck(action, wing);
		else
			EmoteButtons_DoAction(action);
		end
	else
		for i=1, EmoteButtons_LeftWingCount do
			if EmoteButtons_LeftWing[i] == framename then
				found = i;
			end
		end
		if found~=0 then
			action = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].action;		
			if IsShiftKeyDown() then
				EmoteButtons_ConfigDeck = EmoteButtons_LeftWing_Deck;
				EmoteButtons_ConfigButton = found;
				EmoteButtons_UpdateConfig();
			else
				EmoteButtons_DoAction(action);
			end
		else
			for i=1, EmoteButtons_RightWingCount do
				if EmoteButtons_RightWing[i] == framename then
					found = i;
				end
			end
			action = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].action;		
			if IsShiftKeyDown() then
				EmoteButtons_ConfigDeck = EmoteButtons_RightWing_Deck;
				EmoteButtons_ConfigButton = found;
				EmoteButtons_UpdateConfig();
			else
				EmoteButtons_DoAction(action);
			end
		end
	end
end

function EmoteButtons_IsADeck(text)
	local isDeck = false;
	local i;
	for i=1, EmoteButtons_DecksCount do
		if text==EmoteButtons_DeckList[i] then
			isDeck = true;
		end
	end
	return isDeck;
end

function EmoteButtons_ToggleDeck(deck, wing)	
	if wing=="Left" then
		if EmoteButtons_LeftWing_Deck==deck then
			EmoteButtons_ToggleLeftWing();
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_LevelShown~=3 and EmoteButtons_LevelShown~=6) then
				EmoteButtons_ToggleLeftWing();
			else
				EmoteButtons_FadeWing("left");
			end
		end
	else
		if EmoteButtons_RightWing_Deck==deck then
			EmoteButtons_ToggleRightWing();
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_LevelShown~=4 and EmoteButtons_LevelShown~=6) then
				EmoteButtons_ToggleRightWing();
			else
				EmoteButtons_FadeWing("right");
			end
		end
	end
end

function EmoteButtons_LoadDeck(deck, wing)
	local i;
	local image;
	if deck== EmoteButtons_FirstLevelName then
		for i=1, EmoteButtons_FirstLevelCount do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_FirstLevel[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing == "Left" then
		EmoteButtons_LeftWing_Deck = deck
		for i=1, EmoteButtons_LeftWingCount do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_LeftWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	else
		EmoteButtons_RightWing_Deck = deck
		for i=1, EmoteButtons_RightWingCount do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_RightWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	end
end

function EmoteButtons_DoAction(text)
	EmoteButtons_EditBox:SetText(text);
	ChatEdit_SendText(EmoteButtons_EditBox);
end

function EmoteButtons_ShowTooltip(framename)
	local i,x,anchor;
	local found = 0;
	local tooltip = "";
	local action = "";
	local setup = EMOTEBUTTONS_SETTINGSWARN;
	local fulltext = "";
	for i=1, EmoteButtons_FirstLevelCount do
		if EmoteButtons_FirstLevel[i] == framename then
			found = i;
		end
	end
	if found~=0 then
		tooltip = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].tooltip;
		action = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].action;
		if found>floor(EmoteButtons_FirstLevelCount/2) then
			anchor = "ANCHOR_BOTTOMRIGHT"
			x = 30;
		else
			anchor = "ANCHOR_BOTTOMLEFT"
			x = -30;
		end
	else
		for i=1, EmoteButtons_LeftWingCount do
			if EmoteButtons_LeftWing[i] == framename then
				found = i;
			end
		end
		if found~=0 then
			tooltip = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].tooltip;
			action = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].action;
			anchor = "ANCHOR_BOTTOMLEFT"
			x = -30;
		else
			for i=1, EmoteButtons_RightWingCount do
				if EmoteButtons_RightWing[i] == framename then
					found = i;
				end
			end
			tooltip = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].tooltip;
			action = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].action;
			anchor = "ANCHOR_BOTTOMRIGHT"
			x = 30;
		end
	end
	GameTooltip:SetOwner(getglobal(framename), anchor);
	fulltext = "|cFFFFFFFF"..tooltip.."|n|r"..action;
	if EmoteButtons_Config:IsShown() then
		fulltext = fulltext..setup;
	end
	GameTooltip:SetText(fulltext);
	GameTooltip:Show();
end

function EmoteButtons_HideTooltip()
	GameTooltip:Hide();
end

function EmoteButtons_UpdateConfig()
	local i;
	local found = 0;
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	local action = EmoteButtons_Vars.Actions[deck][button].action;
	local tooltip = EmoteButtons_Vars.Actions[deck][button].tooltip;
	local image = EmoteButtons_Vars.Actions[deck][button].image;

	
	EmoteButtons_Config_ButtonName:SetText(deck.." - "..EMOTEBUTTONS_BUTTON.." "..button);

	EmoteButtons_Config_Action:SetText(action);
	EmoteButtons_Config_Tooltip:SetText(tooltip);
	
	EmoteButtons_Config:Show();
    EmoteButtons_PopupImageSelector(); 
end

function EmoteButtons_SliderChanged(sender, units)
	local val = "err";
	if sender=="EmoteButtons_Config_SetMainShift" then
		val = EmoteButtons_Config_SetMainShift:GetValue();
		EmoteButtons_Vars.Main_Shift = val;
		EmoteButtons_Vars.Wing_Shift = val;
	else
		val = EmoteButtons_Config_SetMainSize:GetValue();
		EmoteButtons_Vars.Main_Ratio = val;
	end
	getglobal(sender.."Value"):SetText(val..units);
	EmoteButtons_ArrangeFrames();

end

function EmoteButtons_ChangeTooltip()
	StaticPopupDialogs["EMOTEBUTTONS_CHANGETOOLTIP"]={
		text=TEXT(EMOTEBUTTONS_CHANGELABEL),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=200,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGETOOLTIP");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGETOOLTIP")):GetName().."EditBox"):SetText(EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip);
end


function EmoteButtons_ChangeEmote()
	StaticPopupDialogs["EMOTEBUTTONS_CHANGEEMOTE"]={
		text=TEXT(EMOTEBUTTONS_CHANGECOMMAND),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=255,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGEEMOTE");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGEEMOTE")):GetName().."EditBox"):SetText(EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action);
end

function EmoteButtons_SetDeck(number)
	if number <= EmoteButtons_DecksCount then
		EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = "Deck "..number;		
		EmoteButtons_UpdateConfig();
		EmoteButtons_SelectAction:Hide();
	end
end

function EmoteButtons_SetAction()
	if EmoteButtons_ConfigDeck == EmoteButtons_FirstLevelName then
		if EmoteButtons_SelectAction:IsShown() then
			EmoteButtons_SelectAction:Hide();
		else
			EmoteButtons_SelectAction:Show();
		end
	else
		EmoteButtons_ChangeEmote();
	end

end

function EmoteButtons_PopupImageSelector()
	local i, parent, x, y, pos, f, t;
	i = 1;
	while i<EmoteButtons_ImageCount and EmoteButtons_ImageList[i]~=EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].image do
		i = i + 1;
	end
	if (EmoteButtons_ImageSelect1~=nil) then
		EmoteButtons_NormalizeImages();
		EmoteButtons_ImageSelected(nil);
		EmoteButtons_ImageSlideCenter = i;
		if not (EmoteButtons_ImageSelect1:IsShown()) then
			EmoteButtons_ImageSelect1:Show();
		end
	else
	for i=1, EmoteButtons_ImageCount do
		parent = "EmoteButtons_ImageSelect"..(i-1);
		if (i==1) then
			f = CreateFrame("Button","EmoteButtons_ImageSelect1", UIParent, "EmoteButtons_SelectImage_Init");
		else
			f = CreateFrame("Button","EmoteButtons_ImageSelect"..i, getglobal(parent) , "EmoteButtons_SelectImage_template");
		end
		f:SetFrameStrata("HIGH");
		f:SetWidth(16);
		f:SetHeight(16);
		
		t = f:CreateTexture(nil,"BACKGROUND");
		t:SetTexture("Interface\\Icons\\"..EmoteButtons_ImageList[i]);
		t:SetAllPoints(f);
		f.texture = t;
		
		if (i==1) then
			f:SetPoint("CENTER", "UIParent", "CENTER", -((EmoteButtons_ImageSlideCenter)*16+112), 0);
		else
			f:SetPoint("LEFT","EmoteButtons_ImageSelect"..i-1, "RIGHT",0,0);
		end
		f:SetID(i);
		f:Show();
	end
	EmoteButtons_ImageSlideCenter = i;
	end
	EmoteButtons_SlideImageSelector(EmoteButtons_ImageSlideCenter);
end

function EmoteButtons_RegisterForSlide(number)
	if abs(EmoteButtons_ImageSlideCenter-number)<20 then
		EmoteButtons_SlideNumber = number;
	end
end

function EmoteButtons_SlideImageUpdate()
	if (EmoteButtons_LastSlide+1)<floor(GetTime()*17) and EmoteButtons_SlideNumber then
		EmoteButtons_SlideImageSelector();
	end
end

function EmoteButtons_SlideImageSelector()
	local i,offset;
	local number = EmoteButtons_SlideNumber;
	local obj;
	local moved=false;

	if number == nil then
		number = EmoteButtons_ImageSlideCenter;
	end
	if (number+3<EmoteButtons_ImageSlideCenter) or (number<4 and EmoteButtons_ImageSlideCenter>1)then
		EmoteButtons_ImageSlideCenter = EmoteButtons_ImageSlideCenter - 1;
		moved=true;
	elseif (number-3>EmoteButtons_ImageSlideCenter) or (number>EmoteButtons_ImageCount-4 and EmoteButtons_ImageSlideCenter<EmoteButtons_ImageCount) then
		EmoteButtons_ImageSlideCenter = EmoteButtons_ImageSlideCenter + 1;
		moved=true;
	end
	for i=-4, 4 do
		obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+i);
		if obj~=nil then
			obj:SetWidth(16*(5-abs(i)));
			obj:SetHeight(16*(5-abs(i)));
		end
	end
	number = EmoteButtons_ImageSlideCenter;

	obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter-19);
	if obj~=nil then
		EmoteButtons_ImageSelect1:SetAlpha(255);
		EmoteButtons_ImageSelect1:SetAlpha(0);
		obj:SetAlpha(255);
		
	end
	obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+20);
	if obj~=nil then
		getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+19):SetAlpha(255);
		obj:SetAlpha(0);
	end

    if number==4 then
        offset=104;
    elseif number==3 then
        offset=80;
    elseif number==2 then
        offset=40;
    elseif number==1 then
        offset=-16;
    else
        offset=112;
    end
	EmoteButtons_SlideNumber = nil;
	EmoteButtons_ImageSelect1:SetPoint("CENTER", "UIParent", "CENTER", -((EmoteButtons_ImageSlideCenter)*16+offset), 0);
	EmoteButtons_LastSlide = floor(GetTime()*17);
end

function EmoteButtons_ImageSelected(number)
	local pos = number;
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;

	if pos ~= nil then
		EmoteButtons_Vars.Actions[deck][button].image = EmoteButtons_ImageList[pos];
		if EmoteButtons_LeftWing_Deck==deck then
			EmoteButtons_LoadDeck(deck, "Left");
		end
		if EmoteButtons_RightWing_Deck==deck then
			EmoteButtons_LoadDeck(deck, "Right");
		end
		if EmoteButtons_FirstLevelName == deck then
			EmoteButtons_LoadDeck(deck, "");
		end
		PlaySound("igChatScrollUp");

	EmoteButtons_NormalizeImages();
        EmoteButtons_ImageSlideCenter = pos;
        EmoteButtons_PopupImageSelector();
	end
end

function EmoteButtons_SlideImageMouseLeave(number)
	if EmoteButtons_SlideNumber==number then
		EmoteButtons_SlideNumber = nil;
	end
end

function EmoteButtons_NormalizeImages()
	local i, obj;
	for i=-4, 4 do
		obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+i);
		if obj~=nil then
			obj:SetWidth(16);
			obj:SetHeight(16);
		end
	end
	if EmoteButtons_ImageSelect1~=nil then
		EmoteButtons_ImageSelect1:SetAlpha(255);
	end
end

function EmoteButtons_HideSelector()
	EmoteButtons_NormalizeImages();
	EmoteButtons_ImageSelect1:Hide();
end