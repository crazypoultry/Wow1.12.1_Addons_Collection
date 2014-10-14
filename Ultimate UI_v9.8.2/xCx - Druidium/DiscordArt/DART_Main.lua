function DART_Compile_Scripts()
	local ti = 0;
	while (true) do
		ti = ti + 1;
		local texture = getglobal("DART_Texture_"..ti);
		if (not texture) then break; end
		for i=1,DART_NUMBER_OF_SCRIPTS do
			if (DART_Settings[DART_INDEX][ti].scripts[i]) then
				RunScript("function DART_Texture"..ti.."_Script_"..DART_SCRIPT_LABEL[i].."(param, ti)\n  "..DART_Settings[DART_INDEX][ti].scripts[i].." \nend");
			else
				RunScript("function DART_Texture"..ti.."_Script_"..DART_SCRIPT_LABEL[i].."()\nend");
			end
			if (i == 14) then
				this = getglobal("DART_Texture_"..ti);
				getglobal("DART_Texture"..ti.."_Script_"..DART_SCRIPT_LABEL[i])("", ti);
			end
		end
	end
end

function DART_Get_Offsets(element, baseframe, settings)
	baseframe = getglobal(baseframe);
	local xoffset, yoffset = DL_Get_Offsets(element, baseframe, DART_ATTACH_POINTS[settings.attachpoint[1]], DART_ATTACH_POINTS[settings.attachto[1]]);
	return xoffset, yoffset;
end

function DART_Get_Position(frame, attach, scale)
	local x, y;
	attach = DART_ATTACH_POINTS[attach];
	if (attach == "TOPLEFT") then
		x = frame:GetLeft();
		y = frame:GetTop();
	elseif (attach == "TOP") then
		x = frame:GetLeft() + (frame:GetRight() - frame:GetLeft()) / 2;
		y = frame:GetTop();
	elseif (attach == "TOPRIGHT") then
		x = frame:GetRight();
		y = frame:GetTop();
	elseif (attach == "LEFT") then
		x = frame:GetLeft();
		y = frame:GetBottom() + (frame:GetTop() - frame:GetBottom()) / 2;
	elseif (attach == "CENTER") then
		x = frame:GetLeft() + (frame:GetRight() - frame:GetLeft()) / 2;
		y = frame:GetBottom() + (frame:GetTop() - frame:GetBottom()) / 2;
	elseif (attach == "RIGHT") then
		x = frame:GetRight();
		y = frame:GetBottom() + (frame:GetTop() - frame:GetBottom()) / 2;
	elseif (attach == "BOTTOMLEFT") then
		x = frame:GetLeft();
		y = frame:GetBottom();
	elseif (attach == "BOTTOM") then
		x = frame:GetLeft() + (frame:GetRight() - frame:GetLeft()) / 2;
		y = frame:GetBottom();
	elseif (attach == "BOTTOMRIGHT") then
		x = frame:GetRight();
		y = frame:GetBottom();
	end
	x = DL_round(x, 2);
	y = DL_round(y, 2);
	return x, y;
end

function DART_Initialize()
	if (DART_INITIALIZED) then return; end

	if (DART_DL_VERSION > DL_VERSION) then
		ScriptErrors_Message:SetText("** You need to install the latest version of the Discord Library, v"..DART_DL_VERSION..", for Discord Art to work right.  It should be included in the same .zip file from which you extracted this mod. **");
		ScriptErrors:Show();
		return;
	end

	if (not DART_Settings) then
		DART_Settings = {};
		DART_Settings.CustomTextures = {};
	end

	if (not DART_Settings[DART_TEXT.Default]) then
		DART_Initialize_DefaultSettings();
	end

	DART_PROFILE_INDEX = UnitName("player").." : "..GetCVar("realmName");
	if (DART_Settings[DART_PROFILE_INDEX]) then
		DART_INDEX = DART_Settings[DART_PROFILE_INDEX];
	else
		DART_INDEX = DART_TEXT.Default;
		DART_Settings[DART_PROFILE_INDEX] = DART_TEXT.Default;
	end

	DART_INITIALIZED = true;

	if (DART_CUSTOM_SETTINGS) then
		local index = DART_TEXT.Custom;
		DART_Settings[index] = {};
		DL_Copy_Table(DART_CUSTOM_SETTINGS, DART_Settings[index]);
		local ti = 0;
		while (true) do
			ti = ti + 1;
			local texture = getglobal("DART_Texture_"..ti);
			if (not texture) then break; end
			if (not DART_Settings[index][ti]) then
				DART_Set_DefaultSettings(index, ti);
			end
		end
	end

	DART_Initialize_NewSettings();
	DART_Initialize_Everything();
end

function DART_Initialize_DefaultSettings()
	local index = DART_TEXT.Default;
	DART_Settings[index] = {};
	if (DART_DEFAULT_SETTINGS) then
		DL_Copy_Table(DART_DEFAULT_SETTINGS, DART_Settings[index]);
		local ti = 0;
		while (true) do
			ti = ti + 1;
			local texture = getglobal("DART_Texture_"..ti);
			if (not texture) then break; end
			if (not DART_Settings[index][ti]) then
				DART_Set_DefaultSettings(index, ti);
			end
		end
	else
		DART_Settings[index].updatespeed = 30;
		DART_Settings[index].optionsscale = 1;
		local ti = 0;
		while (true) do
			ti = ti + 1;
			local texture = getglobal("DART_Texture_"..ti);
			if (not texture) then break; end
			DART_Set_DefaultSettings(index, ti);
		end
	end
end

function DART_Initialize_Everything()
	DART_Set_OnUpdateSpeed();
	local ti = 0;
	while (true) do
		ti = ti + 1;
		local texture = getglobal("DART_Texture_"..ti);
		if (not texture) then break; end
		DART_Initialize_Texture(ti);
	end
	if (DART_Options) then
		DART_Initialize_TextureList();
		DART_Set_OptionsScale();
		DART_Initialize_TextureOptions();
		DART_Initialize_MiscOptions();
	end
	DART_Compile_Scripts();
end

function DART_Initialize_NewSettings()
	local ti = 0;
	while (true) do
		ti = ti + 1;
		local texture = getglobal("DART_Texture_"..ti);
		if (not texture) then break; end
		if (not DART_Settings[DART_INDEX][ti]) then
			DART_Set_DefaultSettings(DART_INDEX, ti);
		end
	end
	if (not DART_Settings[DART_INDEX]["INITIALIZED1.0d"]) then
		local ti = 0;
		while (true) do
			ti = ti + 1;
			local texture = getglobal("DART_Texture_"..ti);
			if (not texture) then break; end
			DART_Settings[DART_INDEX][ti].parent = "UIParent";
			DART_Settings[DART_INDEX][ti].strata = "BACKGROUND";
			DART_Settings[DART_INDEX][ti].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
			DART_Settings[DART_INDEX][ti].bordertexture = "Interface\\Tooltips\\UI-Tooltip-Border";
			DART_Settings[DART_INDEX][ti].Backdrop = { tile=true, tileSize=16, edgeSize=16, left=5, right=5, top=5, bottom=5};
		end
	end
	if (not DART_Settings[DART_INDEX]["INITIALIZED1.1"]) then
		local ti = 0;
		while (true) do
			ti = ti + 1;
			local texture = getglobal("DART_Texture_"..ti);
			if (not texture) then break; end
			DART_Settings[DART_INDEX][ti].framelevel = 0;
		end
	end

	DART_Settings[DART_INDEX]["INITIALIZED1.1"] = true;
	DART_Settings[DART_INDEX]["INITIALIZED1.0d"] = true;
end

function DART_Initialize_Texture(textureIndex)
	local settings = DART_Settings[DART_INDEX][textureIndex];
	local texture = getglobal("DART_Texture_"..textureIndex);

	texture:ClearAllPoints();
	for i=1,4 do
		if (settings.attachframe[i] and settings.attachframe[i] ~= "") then
			if (not getglobal(settings.attachframe[i])) then
				settings.attachframe[i] = "UIParent";
			end
			texture:SetPoint(DART_ATTACH_POINTS[settings.attachpoint[i]], settings.attachframe[i], DART_ATTACH_POINTS[settings.attachto[i]], settings.xoffset[i], settings.yoffset[i]);
			
		end
	end

	texture:SetBackdrop({bgFile = settings.bgtexture, edgeFile = settings.bordertexture, tile = settings.Backdrop.tile, tileSize = settings.Backdrop.tileSize, edgeSize = settings.Backdrop.edgeSize, insets = { left = settings.Backdrop.left, right = settings.Backdrop.right, top = settings.Backdrop.top, bottom = settings.Backdrop.bottom }});

	if (getglobal(settings.parent)) then
		texture:SetParent(settings.parent);
	else
		DART_Settings[DART_INDEX][textureIndex].parent = "UIParent";
		texture:SetParent(settings.parent);
	end
	texture:SetFrameStrata(settings.strata);

	DART_Texture(textureIndex, settings.texture, settings.coords);
	DART_Scale(textureIndex, settings.scale);
	DART_Height(textureIndex, settings.height);
	DART_Width(textureIndex, settings.width);
	DART_Color(textureIndex, settings.color.r, settings.color.g, settings.color.b, settings.alpha);
	DART_BackgroundColor(textureIndex, settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	DART_BorderColor(textureIndex, settings.bordercolor.r, settings.bordercolor.g, settings.bordercolor.b, settings.borderalpha);
	DART_HighlightColor(textureIndex, settings.highlightcolor.r, settings.highlightcolor.g, settings.highlightcolor.b, settings.highlightalpha);
	if (settings.hide) then
		DART_Hide(textureIndex);
	else
		DART_Show(textureIndex);
	end
	if (settings.hidebg) then
		texture:SetBackdropColor(0, 0, 0, 0);
		texture:SetBackdropBorderColor(0, 0, 0, 0);
	end
	DART_Padding(textureIndex, settings.padding);
	if (settings.disablemouse) then
		texture:EnableMouse();
	else
		texture:EnableMouse(1);
	end
	if (settings.disableMousewheel) then
		texture:EnableMouseWheel();
	else
		texture:EnableMouseWheel(1);
	end

	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (settings.font) then
		if (string.find(settings.font, "\\")) then
			text:SetFont(settings.font, settings.text.height);
		elseif (settings.font == "") then
			text:SetFont("Fonts\\FRIZQT__.TTF", 12);
		else
			text:SetFont("Interface\\AddOns\\DiscordArt\\CustomFonts\\"..settings.font, settings.text.height);
		end
	end

	DART_Text(textureIndex, settings.text.text);
	DART_TextAlpha(textureIndex, settings.text.alpha);
	DART_TextColor(textureIndex, settings.text.color.r, settings.text.color.g, settings.text.color.b, settings.text.alpha);
	DART_TextHeight(textureIndex, settings.text.height);
	DART_TextWidth(textureIndex, settings.text.width);
	DART_TextFontSize(textureIndex, settings.text.fontsize);
	if (settings.text.hide) then
		DART_TextHide(textureIndex);
	else
		DART_TextShow(textureIndex);
	end

	text:ClearAllPoints();
	text:SetPoint(DART_ATTACH_POINTS[settings.text.attachpoint], texture:GetName(), DART_ATTACH_POINTS[settings.text.attachto], settings.text.xoffset, settings.text.yoffset);
	text:SetJustifyV(DART_ATTACH_POINTS[settings.text.justifyV]);
	text:SetJustifyH(DART_ATTACH_POINTS[settings.text.justifyH]);

	if (settings.highlighttexture) then
		if (string.find(settings.highlighttexture, "\\")) then
			getglobal("DART_Texture_"..textureIndex.."_Highlight"):SetTexture(settings.highlighttexture);
		else
			getglobal("DART_Texture_"..textureIndex.."_Highlight"):SetTexture("Interface\\AddOns\\DiscordArt\\CustomTextures\\"..settings.highlighttexture);
		end
	end

	setglobal("BINDING_NAME_DART_TEXTURE_"..textureIndex, settings.name);

	if (not settings.framelevel) then settings.framelevel = 0; end
	local frameLvl = texture.baseframelevel + settings.framelevel;
	frameLvl = DL_round(frameLvl, 0);
	if (frameLvl <= 0) then
		frameLvl = 1;
	end
	texture:SetFrameLevel(frameLvl);
end

function DART_Load_Options()
	if (DART_Options) then return; end
	UIParentLoadAddOn("DiscordArtOptions");
	DART_Initialize_TextureList();
	DART_Initialize_ProfileList();
	DL_Set_OptionsTitle("DART_Options", "DiscordArtOptions\\title", DART_VERSION);
	DL_Layout_Menu("DART_DropMenu");
	DL_Layout_ScrollButtons("DART_ScrollMenu_Button", 10, DART_Options_SelectTexture);
	DL_Init_MenuControl(DART_BaseOptions_SelectTexture, DART_TEXTURE_INDEX);
	DL_Init_MenuControl(DART_TextureOptions_NudgeIndex, DART_NUDGE_INDEX);
	DART_TextureOptions_FrameLevel_Label:ClearAllPoints();
	DART_TextureOptions_FrameLevel_Label:SetPoint("BOTTOM", DART_TextureOptions_FrameLevel, "TOP", 0, 0);
	DART_Set_OptionsScale();
	DART_Initialize_TextureOptions();
	DART_Initialize_MiscOptions();
end

function DART_Main_OnLoad()
	DiscordLib_RegisterInitFunc(DART_Initialize);

	SlashCmdList["DART"] = DART_Slash_Handler;
	SLASH_DART1 = "/dart";
	SLASH_DART2 = "/discordart";
end

function DART_Options_SetProfile(index)
	if (not index) and DART_Options then
		index = DART_MiscOptions_SetProfile_Setting:GetText();
	end
	if (index == "" or (not index)) then return; end
	DART_INDEX = index;
	DART_Settings[DART_PROFILE_INDEX] = index;
	DART_Initialize_NewSettings();
	DART_Initialize_Everything();
	DL_Feedback(DART_TEXT.ProfileLoaded..index);
end

function DART_Options_Toggle()
	if (not DART_Options) then
		DART_Load_Options();
	end
	if (DART_Options:IsVisible()) then
		DART_Options:Hide();
	else
		DART_Options:Show();
	end
end

function DART_Set_DefaultSettings(index, ti)
	DART_Settings[index][ti] = {};
	DART_Settings[index][ti].hide = true;
	DART_Settings[index][ti].hidebg = true;
	DART_Settings[index][ti].xoffset = {};
	DART_Settings[index][ti].yoffset = {};
	DART_Settings[index][ti].attachpoint = {};
	DART_Settings[index][ti].attachto = {};
	for i=1,4 do
		DART_Settings[index][ti].xoffset[i] = 0;
		DART_Settings[index][ti].yoffset[i] = 0;
		DART_Settings[index][ti].attachpoint[i] = 5;
		DART_Settings[index][ti].attachto[i] = 5;
	end
	DART_Settings[index][ti].attachframe = {};
	DART_Settings[index][ti].attachframe[1] = "UIParent";
	DART_Settings[index][ti].alpha = 1;
	DART_Settings[index][ti].height = 50;
	DART_Settings[index][ti].width = 50;
	DART_Settings[index][ti].scale = 1;
	DART_Settings[index][ti].color = {r=1, g=1, b=1};
	DART_Settings[index][ti].bgcolor = {r=0, g=0, b=0};
	DART_Settings[index][ti].bordercolor = {r=1, g=1, b=1};
	DART_Settings[index][ti].highlightcolor = {r=1, g=1, b=0};
	DART_Settings[index][ti].bgalpha = 1;
	DART_Settings[index][ti].borderalpha = 1;
	DART_Settings[index][ti].highlightalpha = .3;
	DART_Settings[index][ti].padding = 5;
	DART_Settings[index][ti].texture = "";
	DART_Settings[index][ti].coords = { 0, 1, 0, 1 };
	DART_Settings[index][ti].text = { text="", hide=true, color={r=1, g=1, b=1}, height=20, width=100, attachpoint=2, attachto=2, xoffset=0, yoffset=0, justifyH=5, justifyV=5, alpha=1, fontsize=16};
	DART_Settings[index][ti].name = DART_TEXT.Texture..ti;
	DART_Settings[index][ti].scripts = {};
	DART_Settings[index][ti].parent = "UIParent";
	DART_Settings[index][ti].strata = "BACKGROUND";
	DART_Settings[index][ti].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
	DART_Settings[index][ti].bordertexture = "Interface\\Tooltips\\UI-Tooltip-Border";
	DART_Settings[index][ti].Backdrop = { tile=true, tileSize=16, edgeSize=16, left=5, right=5, top=5, bottom=5};
	DART_Settings[index][ti].framelevel = 0;
end

function DART_Set_OnUpdateSpeed()
	if (not DART_Settings[DART_INDEX].updatespeed) then
		DART_Settings[DART_INDEX].updatespeed = 30;
	end
	DART_UPDATE_SPEED = 1 / DART_Settings[DART_INDEX].updatespeed;
end

function DART_Set_OptionsScale()
	DART_Options:SetScale(DART_Settings[DART_INDEX].optionsscale);
	DART_Options:ClearAllPoints();
	DART_Options:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
end

function DART_Slash_Handler(msg)
	local command, param;
	local index = string.find(msg, " ");

	if( index) then
		command = string.sub(msg, 1, (index - 1));
		param = string.sub(msg, (index + 1)  );
	else
		command = msg;
	end

	DART_Options_Toggle();
end

function DART_Texture_OnDragStart()
	if (not DART_DRAGGING_UNLOCKED) then return; end
	if ((not DART_Settings[DART_INDEX][this:GetID()].attachframe[2]) or DART_Settings[DART_INDEX][this:GetID()].attachframe[2] == "") then
		this.moving = true;
		this:StartMoving();
	else
		DL_Debug(DART_TEXT.DragWarning);
	end
end

function DART_Texture_OnDragStop()
	if (this.moving) then
		this.moving = nil;
		this:StopMovingOrSizing();
		local settings = DART_Settings[DART_INDEX][this:GetID()];
		local xoffset, yoffset = DART_Get_Offsets(this, settings.attachframe[1], settings);
		this:ClearAllPoints();
		this:SetPoint(DART_ATTACH_POINTS[settings.attachpoint[1]], settings.attachframe[1], DART_ATTACH_POINTS[settings.attachto[1]], xoffset, yoffset);
		DART_Settings[DART_INDEX][this:GetID()].xoffset[1] = xoffset;
		DART_Settings[DART_INDEX][this:GetID()].yoffset[1] = yoffset;
		if (DART_Options and this:GetID() == DART_TEXTURE_INDEX) then
			DART_Initialize_TextureOptions();
		end
	end
end

function DART_Texture_OnEnter()
	if (DART_Settings[DART_INDEX][this:GetID()].highlight) then
		getglobal(this:GetName().."_Highlight"):Show();
	end
end

function DART_Texture_OnHide()
	if (this.moving) then
		this.moving = nil;
		this:StopMovingOrSizing();
	end
end

function DART_Texture_OnLeave()
	if (DART_Settings[DART_INDEX][this:GetID()].highlight) then
		getglobal(this:GetName().."_Highlight"):Hide();
	end
end

function DART_Texture_OnLoad()
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
	this.baseframelevel = this:GetFrameLevel();
end

function DART_Texture_OnUpdate(elapsed)
	if (not DART_INITIALIZED) then return; end
	if (this.flashing) then
		this.flashtime = this.flashtime - elapsed;
		if (this.flashtime < 0) then
			this.flashtime = .5;
			if (this.direction) then
				this.direction = nil;
			else
				this.direction = 1;
			end
		end
		if (this.direction) then
			this:SetAlpha(1 - this.flashtime);
		else
			this:SetAlpha(.5 + this.flashtime);
		end
	end
	if (this.scale and this:GetScale() ~= this.scale) then
		this:SetScale(this.scale);
	end
end

function DART_Texture_Process(script, param, textureIndex)
	if (not DART_INITIALIZED) then return; end
	if (not textureIndex) then
		textureIndex = this:GetID();
	end
	if (DART_Options and DART_ScriptOptions_ScrollFrame_Text:IsVisible()) then return; end
	if (script == 1) then
		if (not this.timer) then
			this.timer = DART_UPDATE_SPEED;
		end
		this.timer = this.timer - param;
		if (this.timer > 0) then
			return;
		else
			this.timer = DART_UPDATE_SPEED;
		end
	end
	if (getglobal("DART_Texture"..textureIndex.."_Script_"..DART_SCRIPT_LABEL[script])) then
		getglobal("DART_Texture"..textureIndex.."_Script_"..DART_SCRIPT_LABEL[script])(param, textureIndex);
	end
end

function DART_Toggle_Dragging()
	if (DART_DRAGGING_UNLOCKED) then
		DART_DRAGGING_UNLOCKED = nil;
		if (DART_Options) then
			DART_Options_DragToggle:SetText(DART_TEXT.UnlockDragging);
		end
	else
		DART_DRAGGING_UNLOCKED = true;
		if (DART_Options) then
			DART_Options_DragToggle:SetText(DART_TEXT.LockDragging);
		end
	end
end