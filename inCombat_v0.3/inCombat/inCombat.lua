local colorError = { r=0.0 , g=255.0, b=0.0 };
local colorChat = { r=1.0 , g=1.0, b=1.0 };
local colorIC = { r=0.0 , g=255.0, b=0.0 };
local colorOOC = { r=0.0 , g=255.0, b=0.0 };
local soundWarn = "RaidWarning";

-- colorSet define which color to change
-- 1 - in combat
-- 2 - out of combat
local colorSet;

local function inCombat_Print ( msg, color )
	if ( not color ) or (color == nil) then
		color = colorChat;
	end;
	DEFAULT_CHAT_FRAME:AddMessage(msg, color.r, color.g, color.b);
end;

local function inCombat_PrintError ( msg, color )
	if ( not color ) or (color == nil) then
		color = colorError;
	end;
	UIErrorsFrame:AddMessage(msg, color.r, color.g, color.b, 1.0 , UIERRORS_HOLD_TIME);
end;

local function inCombat_PrintHelp ()
	inCombat_Print ("");
	inCombat_Print ("inCombat command help:", colorError);
	inCombat_Print ("	/incombat <command>");
	inCombat_Print ("	sound - enable/disable sound warrning");
	inCombat_Print ("	coloric - let you choose color for in combat message");
	inCombat_Print ("	colorooc - let you choose color for out of combat message");
	inCombat_Print ("	reset - reset settings to default");
	if ( inCombatDB.Sound == 1 ) then
		inCombat_Print ("inCombat sound enabled.");
	else
		inCombat_Print ("inCombat sound disabled.");
	end;
	inCombat_Print ("");
end;

function inCombat_OnLoad()
	--Registering slash commands
	SLASH_INCOMBAT1 = "/incombat";
	SLASH_INCOMBAT2 = "/ic";
	SlashCmdList["INCOMBAT"] = inCombat_SlashHandler;
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	inCombat_Print("inCombat addon loaded.", colorError);
	inCombat_PrintError("inCombat addon loaded.");
end

function inCombat_OnEvent()
	if (event == "VARIABLES_LOADED") then
		if (not inCombatDB) then
			inCombatDB = { };
		end;
		if (not inCombatDB.Sound) then
			inCombatDB.Sound = 1;
		end;
		if (not inCombatDB.ColorIC) then
			inCombatDB.ColorIC = colorIC;
		end;
		if (not inCombatDB.ColorOOC) then
			inCombatDB.ColorOOC = colorOOC;
		end;
	elseif (event == "PLAYER_REGEN_DISABLED") then
		inCombat_PrintError("+IN COMBAT+", inCombatDB.ColorIC);
		if ( inCombatDB.Sound == 1 ) then
			PlaySound(soundWarn);
		end;
	elseif (event == "PLAYER_REGEN_ENABLED") then
		inCombat_PrintError("-OUT OF COMBAT-",inCombatDB.ColorOOC);
	end
end

function inCombat_ColorPicker_OK()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local color = { r=0, g=0, b=0 };
	
	color.r = r;
	color.b = b;
	color.g = g;
	
	if ( colorSet == 1 ) then
		inCombatDB.ColorIC = color;
	else
		inCombatDB.ColorOOC = color;
	end;
end

function inCombat_ColorPicker_Cancel()
	-- empty function
end

function inCombat_ColorPicker_Show ( color )
	ColorPickerFrame.func = inCombat_ColorPicker_OK;
	ColorPickerFrame.cancelFunc = inCombat_ColorPicker_Cancel;
	ColorPickerFrame:SetColorRGB(color.r, color.g , color.b);
	ColorPickerFrame:Show();
end;

function inCombat_SlashHandler (msg)
	local newColor = { r=0, g=0, b=0 };
	if ( msg ) then
		local command = string.lower(msg);
		if ( command == "" ) then
			inCombat_PrintHelp ();
		elseif ( command == "sound" ) then
			if ( inCombatDB.Sound == 1 ) then
				inCombatDB.Sound = 0;
				inCombat_Print ("inCombat: sound warning disabled.", colorError);
			else
				inCombatDB.Sound = 1;
				inCombat_Print ("inCombat: sound warning enabled.", colorError);
			end;
		elseif ( command == "coloric" ) then
			colorSet = 1;
			inCombat_ColorPicker_Show ( inCombatDB.ColorIC );
		elseif ( command == "colorooc" ) then
			colorSet = 2;
			inCombat_ColorPicker_Show ( inCombatDB.ColorOOC );
		elseif ( command == "reset" ) then
			inCombatDB.Sound = 1;
			inCombatDB.ColorIC = colorIC;
			inCombatDB.ColorOOC = colorOOC;
		end;
	else
		inCombat_PrintHelp ();
	end
end;