local version = 0.9;

SimpleCompass_Saved = {};

BINDING_HEADER_SIMPLECOMPASS = "Simple Compass"
BINDING_NAME_TOGGLESIMPLECOMPASS = "Toggle Compass";
BINDING_NAME_TOGGLESIMPLECOMPASSOPTIONS= "Toggle Options";

-- From the Minimap frame object's minimapPlayerModel setting in the XML.
local minimapPlayerModel;

local lastMouseY, scaleOffset, DesiredHeading, delta, DrawRadians;
local ActualHeading, Velocity, Acceleration, VelDecay, AccelFactor, AccelDecay = 0, 0, 0, 0.1, 15, 0.5;
local l, Sin, Cos, scale, x, y = 0.7;

local strataTable = { "FULLSCREEN", "DIALOG", "HIGH", "MEDIUM", "LOW", "BACKGROUND" };

local function GetFacing()	
	-- convert to degrees for sanity
	return 360 - (minimapPlayerModel:GetFacing() / (math.pi/180));
end

tinsert(UISpecialFrames, "SimpleCompassOptions");

function SimpleCompass_Setup()
	local s = SimpleCompass_Saved;
	if ( s.hide ) then
		SimpleCompassFrame:Hide();
		return;
	else
		SimpleCompassFrame:Show();
	end
	SimpleCompassBody:SetScale(s.scale or 1.0);
	SimpleCompassBody:EnableMouse(s.lock or s.hardlock or 1);
	SimpleCompassFrame:SetAlpha(s.alpha or 1.0);
	SimpleCompassLock:EnableMouse(s.hardlock or 1)
	if ( s.lock or s.hardlock ) then
		SimpleCompassButton:Hide();
	else
		SimpleCompassButton:Show();
	end
	if ( s.strata ) then
		SimpleCompassFrame:SetFrameStrata(strataTable[s.strata]);
		SimpleCompassFrame:SetFrameLevel(0);
	end
end

function SimpleCompass_OnLoad()
	SlashCmdList["SIMPLECOMPASS"] = SimpleCompass_Console;
	SLASH_SIMPLECOMPASS1 = "/simplecompass";
	SLASH_SIMPLECOMPASS2 = "/compass";
	
	SimpleCompass_Setup();
	
	DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass "..version.." - loaded - /compass" );
	
	-- Create a table of all the Minimap's children objectSimpleCompass_Saved.
	local children = {Minimap:GetChildren()};
	
	for i=getn(children), 1, -1 do
		-- Iterate over them all, starting from the end of the list to see if the object reference is a model.
		-- If it is, and it has no name (in case some addon attached a model to it), it's probably the right one.
		if children[i]:IsObjectType("Model") and not children[i]:GetName() then
			-- Found, setting as the addon's local to keep the reference.
			minimapPlayerModel = children[i];
			return;
		end
	end
end

function SimpleCompass_OnUpdate()
	DesiredHeading = GetFacing();
	delta = min(arg1,0.1);
	
	if ( delta < 1 and not SimpleCompass_Saved.stable) then
		Velocity = Velocity * VelDecay ^ delta;
		Acceleration = Acceleration * AccelDecay ^ delta;
		local Distance = DesiredHeading - ActualHeading;
		if ( Distance > 180 ) then
			Distance = Distance - 360;
		end
		Acceleration = Acceleration + AccelFactor * Distance * delta;
		if( (Acceleration > 0 and Distance < 0) or (Acceleration < 0 and Distance > 0) ) then
			Acceleration = -Acceleration;
		end
		Velocity = Velocity + Acceleration * delta; 
		ActualHeading = ActualHeading + Velocity * delta;
		if ( ActualHeading > 180 ) then
			ActualHeading = ActualHeading - 360;
		elseif ( ActualHeading < -180 ) then
			ActualHeading = ActualHeading + 360
		end
	else
		ActualHeading = DesiredHeading;
		Velocity = 0;
		Acceleration = 0;
	end
	
	-- convert back to radians
	-- The texture rotation is off by 135 degrees, so we fix it here.
	DrawRadians = ActualHeading * (math.pi/180) + (math.pi*0.75);

	Sin = math.sin(DrawRadians) * l;
	Cos = math.cos(DrawRadians) * l;

	SimpleCompassBack:SetTexCoord(0.5-Sin, 0.5+Cos,
		 0.5+Cos, 0.5+Sin,
		 0.5-Cos, 0.5-Sin,
		 0.5+Sin, 0.5-Cos);
	
	if ( lastMouseY ) then
		x, lastMouseY = GetCursorPosition();
		if ( lastMouseY > 0 ) then
			SimpleCompass_Saved.scale = max(min((y*scale-lastMouseY)/scaleOffset,4),0.5);
		else
			SimpleCompass_Saved.scale = max(min(-(y*scale-lastMouseY)/scaleOffset,4),0.5);
		end
		SimpleCompassBody:SetScale(SimpleCompass_Saved.scale);
		if ( SimpleCompassOptions:IsVisible() ) then
			SC_Scale:SetValue(SimpleCompass_Saved.scale);
		end
	end
end

function SimpleCompass_Toggle()
	if ( SimpleCompass_Saved.hide ) then
		SimpleCompass_Saved.hide = nil;
	else
		SimpleCompass_Saved.hide = 1;
	end
	SimpleCompass_Setup();
end

function SimpleCompass_OptionsToggle()
	if ( SimpleCompassOptions:IsVisible() ) then
		HideUIPanel(SimpleCompassOptions);
	else
		ShowUIPanel(SimpleCompassOptions);
	end
end

function SimpleCompass_OnEvent()
	if ( event == "ADDON_LOADED" ) then
		if ( arg1 == "SimpleCompass" ) then
			this:UnregisterEvent("ADDON_LOADED");
			SimpleCompass_OnLoad();
		end
	elseif ( event == "UNIT_COMBAT" and arg1 == "player") then
		SimpleCompass_Wiggle( (arg4 or 0)/UnitHealthMax(arg1) * 1000 )
	end
end

function SimpleCompass_Console(msg)
	if ( strlower(strsub( msg, 1, 4 )) == "hide" ) then
		SimpleCompass_Saved.hide = 1;
		DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - hidden" );
	elseif ( strlower(strsub( msg, 1, 4 )) == "show" ) then
		SimpleCompass_Saved.hide = nil;
		DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - shown" );
	elseif ( strlower(strsub( msg, 1, 5 )) == "scale" ) then
		local scale = tonumber(strsub( msg, 7 ));
		if ( scale ) then
			SimpleCompass_Saved.scale = max(min(scale,4),0.25);
			DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - scale set to "..SimpleCompass_Saved.scale );
		else
			DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - usage" );
			DEFAULT_CHAT_FRAME:AddMessage( "scale # - ranges from 0.25 to 4" );
		end
	elseif ( strlower(strsub( msg, 1, 5 )) == "alpha" ) then
		local alpha = tonumber(strsub( msg, 7 ));
		if ( alpha ) then
			SimpleCompass_Saved.alpha = max(min(alpha,1),0.2);
			DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - alpha set to "..SimpleCompass_Saved.alpha );
		else
			DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - usage" );
			DEFAULT_CHAT_FRAME:AddMessage( "alpha # - ranges from 0.2 to 1" );
		end
	elseif ( strlower(strsub( msg, 1, 4 )) == "lock" ) then
		SimpleCompass_Saved.lock = 0;
		DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - locked" );
	elseif ( strlower(strsub( msg, 1, 6 )) == "unlock" ) then
		SimpleCompass_Saved.lock = nil;
		DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - unlocked" );
	elseif ( strlower(strsub( msg, 1, 7 )) == "wobble" ) then
		if ( SimpleCompass_Saved.stable ) then
			SimpleCompass_Saved.stable = nil;
			DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - wobble on" );
		else
			SimpleCompass_Saved.stable = 1;
			DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - wobble off" );
		end
	elseif ( strlower(strsub( msg, 1, 5 )) == "reset" ) then
		SimpleCompassFrame:ClearAllPoints();
		SimpleCompassFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -90);
		SimpleCompassOptions:ClearAllPoints();
		SimpleCompassOptions:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		SimpleCompass_Saved = {};
		DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - reset" );
	elseif ( strlower(strsub( msg, 1, 5 )) == "help" or msg == "?" ) then 
		SimpleCompass_Help();
		return;
	else
		SimpleCompass_OptionsToggle();
		return;
	end
	SimpleCompass_Setup();
end

function SimpleCompass_Help()
	DEFAULT_CHAT_FRAME:AddMessage( "SimpleCompass - /compass" );
	DEFAULT_CHAT_FRAME:AddMessage( "show / hide - show and hide the compass" );
	DEFAULT_CHAT_FRAME:AddMessage( "scale # - scale the compass" );
	DEFAULT_CHAT_FRAME:AddMessage( "alpha # - set the opacity of the compass" );
	DEFAULT_CHAT_FRAME:AddMessage( "unlock / lock - enable and disable dragging" );
	DEFAULT_CHAT_FRAME:AddMessage( "wobble - toggle the wobble animation on/off" );
	DEFAULT_CHAT_FRAME:AddMessage( "reset - reset location and settings" );
	DEFAULT_CHAT_FRAME:AddMessage( "no command will bring up the options menu" );
end

function SimpleCompass_Wiggle(wiggle)
	if ( math.random() < 1 ) then
		wiggle = -wiggle;
	end
	Velocity = Velocity + wiggle;
end

function SimpleCompass_StartScaling()
	this:LockHighlight();
	SimpleCompassBody:LockHighlight();
	SimpleCompassHelpSetText("Scaling",1);
	scale = SimpleCompassFrame:GetEffectiveScale();
	x, y = SimpleCompassFrame:GetCenter();
	x, lastMouseY = GetCursorPosition();
	scaleOffset = (y*scale-lastMouseY)/(SimpleCompass_Saved.scale or 1);
end

function SimpleCompass_StopScaling()
	this:UnlockHighlight();
	SimpleCompassBody:UnlockHighlight();
	SimpleCompassHelpFadeText();
	lastMouseY = nil;
	scaleOffset = nil;
end

function SimpleCompassHelpSetText(text,hold)
	if ( text ) then
		SimpleCompassHelpText:SetText(text);
		SimpleCompassHelp.startTime = GetTime();
		if ( hold ) then
			SimpleCompassHelp.holdTime = 999;
		else
			SimpleCompassHelp.holdTime = 0.5;
		end
		SimpleCompassHelp:Show();
	end
end

function SimpleCompassHelpFadeText()
	SimpleCompassHelp.holdTime = GetTime() - SimpleCompassHelp.startTime;
end
