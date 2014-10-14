--	ArcaneBar
--		Adds a second casting bar to the player frame.
--	
--	By: Zlixar
--	
--	Adds a second casting bar to the player frame.
--	
--	Modified by Nymbia for Nymbia's Perl Unitframes
--	Modified again by Global for Perl Classic Unit Frames

---------------
-- Variables --
---------------
Perl_ArcaneBar_Config = {};
local Perl_ArcaneBar_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_ArcaneBar_GetVars)
local enabled = 1;
local hideoriginal = 0;
local showtimer = 1;
local transparency = 1;
local namereplace = 0;
local lefttimer = 0;

-- Default Local Variables
local Initialized = nil;	-- waiting to be initialized
local Perl_ArcaneBar_Colors = {	-- declaring this up here like it should be
	["MAINR"] = 1.0,
	["MAING"] = 0.7,
	["MAINB"] = 0.0,
	["CHANNELR"] = 0.0,
	["CHANNELG"] = 1.0,
	["CHANNELB"] = 0.0,
	["SUCCESSR"] = 0.0,
	["SUCCESSG"] = 1.0,
	["SUCCESSB"] = 0.0,
	["FAILURER"] = 1.0,
	["FAILUREG"] = 0.0,
	["FAILUREB"] = 0.0,
}


----------------------
-- Loading Function --
----------------------
function Perl_ArcaneBar_OnLoad()
	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_STOP");
	this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	this:RegisterEvent("SPELLCAST_DELAYED");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_ArcaneBar_OnEvent);
	this:SetScript("OnUpdate", Perl_ArcaneBar_OnUpdate);

	-- Some Defaults
	this.casting = nil;
	this.holdTime = 0;
end


---------------------------
-- Event/Update Handlers --
---------------------------
function Perl_ArcaneBar_OnEvent()
	local func = Perl_ArcaneBar_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - ArcaneBar: Report the following event error to the author: "..event);
--
--		-- The following three lines are from the Blizzard code, not sure what there are for since it would never be called. (I'll come back to this after 2.0 is pushed live.)
--		this.delaySum = 0;
--		this.sign = "+";
--		Perl_ArcaneBar_CastTime:Hide();
	end
end

function Perl_ArcaneBar_Events:SPELLCAST_START()
	Perl_ArcaneBar:SetStatusBarColor(Perl_ArcaneBar_Colors["MAINR"], Perl_ArcaneBar_Colors["MAING"], Perl_ArcaneBar_Colors["MAINB"], transparency);
	Perl_ArcaneBarSpark:Show();
	this.startTime = GetTime();
	this.maxValue = this.startTime + (arg2 / 1000);
	Perl_ArcaneBar:SetMinMaxValues(this.startTime, this.maxValue);
	Perl_ArcaneBar:SetValue(this.startTime);
	this:SetAlpha(0.8);
	this.holdTime = 0;
	this.casting = 1;
	this.fadeOut = nil;
	this:Show();
	this.delaySum = 0;
	if (showtimer == 1) then
		Perl_ArcaneBar_CastTime:Show();
	else
		Perl_ArcaneBar_CastTime:Hide();
	end
	this.mode = "casting";
	if (namereplace == 1) then
		if (Perl_Player_NameFrame:GetWidth() > 199) then
			if (strlen(arg1) > (25)) then
				arg1 = strsub(arg1, 1, 24).."...";
			end
			Perl_Player_NameBarText:SetText(arg1);
		else
			if (strlen(arg1) > (20)) then
				arg1 = strsub(arg1, 1, 19).."...";
			end
			Perl_Player_NameBarText:SetText(arg1);
		end
	end
end

function Perl_ArcaneBar_Events:SPELLCAST_STOP()
	this.delaySum = 0;
	this.sign = "+";
	if (not this.casting) then
		Perl_ArcaneBar_CastTime:Hide();
	end
	if (not this:IsVisible()) then
		this:Hide();
	end
	if (this:IsShown()) then
		Perl_ArcaneBar:SetValue(this.maxValue);
		Perl_ArcaneBar:SetStatusBarColor(Perl_ArcaneBar_Colors["SUCCESSR"], Perl_ArcaneBar_Colors["SUCCESSG"], Perl_ArcaneBar_Colors["SUCCESSB"], transparency);
		Perl_ArcaneBarSpark:Hide();
		Perl_ArcaneBarFlash:SetAlpha(0.0);
		Perl_ArcaneBarFlash:Show();
		if (event == "SPELLCAST_STOP") then
			this.casting = nil;
		else
			this.channeling = nil;
		end
		this.flash = 1;
		this.fadeOut = 1;
		this.mode = "flash";
	end
	if (namereplace == 1) then
		if (this.channeling) then
			Perl_Player_NameBarText:SetText(PERL_LOCALIZED_ARCANEBAR_CHANNELING);
			if (showtimer == 1) then
				Perl_ArcaneBar_CastTime:Show();
			end
		else
			Perl_Player_NameBarText:SetText(UnitName("player"));
		end
	end
end
Perl_ArcaneBar_Events.SPELLCAST_CHANNEL_STOP = Perl_ArcaneBar_Events.SPELLCAST_STOP;

function Perl_ArcaneBar_Events:SPELLCAST_FAILED()
	if (this:IsShown()) then
		Perl_ArcaneBar:SetValue(this.maxValue);
		Perl_ArcaneBar:SetStatusBarColor(Perl_ArcaneBar_Colors["FAILURER"], Perl_ArcaneBar_Colors["FAILUREG"], Perl_ArcaneBar_Colors["FAILUREB"], transparency);
		Perl_ArcaneBarSpark:Hide();
		this.casting = nil;
		this.fadeOut = 1;
		this.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
	end
	if (namereplace == 1) then
		Perl_Player_NameBarText:SetText(UnitName("player"));
	end
end
Perl_ArcaneBar_Events.SPELLCAST_INTERRUPTED = Perl_ArcaneBar_Events.SPELLCAST_FAILED;

function Perl_ArcaneBar_Events:SPELLCAST_DELAYED()
	if(this:IsShown()) then
		if (arg1) then
			this.startTime = this.startTime + (arg1 / 1000);
			this.maxValue = this.maxValue + (arg1 / 1000);
			this.delaySum = this.delaySum + arg1;
			Perl_ArcaneBar:SetMinMaxValues(this.startTime, this.maxValue);
		end
	end
end

function Perl_ArcaneBar_Events:SPELLCAST_CHANNEL_START()
	Perl_ArcaneBar:SetStatusBarColor(Perl_ArcaneBar_Colors["CHANNELR"], Perl_ArcaneBar_Colors["CHANNELG"], Perl_ArcaneBar_Colors["CHANNELB"], transparency);
	Perl_ArcaneBarSpark:Show();
	this.maxValue = 1;
	this.startTime = GetTime();
	this.endTime = this.startTime + (arg1 / 1000);
	this.duration = arg1 / 1000;
	Perl_ArcaneBar:SetMinMaxValues(this.startTime, this.endTime);
	Perl_ArcaneBar:SetValue(this.endTime);
	this:SetAlpha(0.8);
	this.holdTime = 0;
	this.casting = nil;
	this.channeling = 1;
	this.fadeOut = nil;
	this:Show();
	this.delaySum = 0;
	if (showtimer == 1) then
		Perl_ArcaneBar_CastTime:Show();
	else
		Perl_ArcaneBar_CastTime:Hide();
	end
end

function Perl_ArcaneBar_Events:SPELLCAST_CHANNEL_UPDATE()
	if (arg1 == 0) then
		this.channeling = nil;
		this.delaySum = 0;
		Perl_ArcaneBar_CastTime:Hide();
	elseif (this:IsShown()) then
		local origDuration = this.endTime - this.startTime
		local elapsedTime = GetTime() - this.startTime;
		local losttime = origDuration*1000 - elapsedTime*1000 - arg1;
		this.delaySum = this.delaySum + losttime;
		this.startTime = this.endTime - origDuration;
		this.endTime = GetTime() + (arg1 / 1000);
		Perl_ArcaneBar:SetMinMaxValues(this.startTime, this.endTime);
	end
end

function Perl_ArcaneBar_Events:VARIABLES_LOADED()
	Perl_ArcaneBar_Initialize();
end
Perl_ArcaneBar_Events.PLAYER_ENTERING_WORLD = Perl_ArcaneBar_Events.VARIABLES_LOADED;


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_ArcaneBar_Initialize()
	-- Code to be run after zoning or logging in goes here
	if (Initialized) then
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_ArcaneBar_Config[UnitName("player")]) == "table") then
		Perl_ArcaneBar_GetVars();
	else
		Perl_ArcaneBar_UpdateVars();
	end

	-- Make the player name appear above the casting bar
	Perl_ArcaneBar:SetFrameLevel(Perl_Player_NameFrame:GetFrameLevel() + 1);
	Perl_Player_Name:SetFrameLevel(Perl_Player_NameFrame:GetFrameLevel() + 2);

	if (enabled == 1) then
		Perl_ArcaneBar_Register("Perl_ArcaneBarFrame");
	else
		Perl_ArcaneBar_Unregister("Perl_ArcaneBarFrame");
	end
	if (hideoriginal == 1) then
		Perl_ArcaneBar_Unregister("CastingBarFrame");
	else
		Perl_ArcaneBar_Register("CastingBarFrame");
	end

	Perl_ArcaneBarFlashTex:SetTexture("Interface\\AddOns\\Perl_ArcaneBar\\Perl_ArcaneBarFlash");
	Perl_ArcaneBarTex:SetTexture("Interface\\AddOns\\Perl_ArcaneBar\\Perl_StatusBar.tga");

	-- MyAddOns Support
	Perl_ArcaneBar_myAddOns_Support();

	Initialized = 1;
end

function Perl_ArcaneBar_Register(frame)
	-- Registers "frame" (passed as a string) to spellcast events.
	getglobal(frame):RegisterEvent("SPELLCAST_START");
	getglobal(frame):RegisterEvent("SPELLCAST_STOP");
	getglobal(frame):RegisterEvent("SPELLCAST_FAILED");
	getglobal(frame):RegisterEvent("SPELLCAST_INTERRUPTED");
	getglobal(frame):RegisterEvent("SPELLCAST_DELAYED");
	getglobal(frame):RegisterEvent("SPELLCAST_CHANNEL_START");
	getglobal(frame):RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	getglobal(frame):RegisterEvent("SPELLCAST_CHANNEL_STOP");
end

function Perl_ArcaneBar_Unregister(frame)
	-- Unregisters "frame" (passed as a string) from spellcast events.
	getglobal(frame):UnregisterEvent("SPELLCAST_START");
	getglobal(frame):UnregisterEvent("SPELLCAST_STOP");
	getglobal(frame):UnregisterEvent("SPELLCAST_FAILED");
	getglobal(frame):UnregisterEvent("SPELLCAST_INTERRUPTED");
	getglobal(frame):UnregisterEvent("SPELLCAST_DELAYED");
	getglobal(frame):UnregisterEvent("SPELLCAST_CHANNEL_START");
	getglobal(frame):UnregisterEvent("SPELLCAST_CHANNEL_UPDATE");
	getglobal(frame):UnregisterEvent("SPELLCAST_CHANNEL_STOP");
end


-----------------------
-- OnUpdate Function --
-----------------------
function Perl_ArcaneBar_OnUpdate()
	Perl_ArcaneBarFrame:SetPoint("TOPLEFT", "Perl_Player_NameFrame", "TOPLEFT", 5, -5);	-- hard code these in so other mods can't hijack it by accident
	Perl_ArcaneBar_CastTime:ClearAllPoints();
	if (lefttimer == 0) then
		Perl_ArcaneBar_CastTime:SetPoint("LEFT", "Perl_Player_NameFrame", "RIGHT", 0, 0);
	else
		if (Perl_Player_PortraitFrame:IsVisible()) then
			Perl_ArcaneBar_CastTime:SetPoint("RIGHT", "Perl_Player_PortraitFrame", "LEFT", 0, 0);
		else
			Perl_ArcaneBar_CastTime:SetPoint("RIGHT", "Perl_Player_NameFrame", "LEFT", 0, 0);
		end
	end
	
	Perl_ArcaneBarFrame:SetWidth(Perl_Player_NameFrame:GetWidth() - 10);			-- this line and the two following it allow for compact mode detection in the player frame, and any other player frame tweak
	Perl_ArcaneBar:SetWidth(Perl_Player_NameFrame:GetWidth() - 10);
	Perl_ArcaneBarFlash:SetWidth(Perl_Player_NameFrame:GetWidth() + 5);

	if (not Perl_ArcaneBar:IsShown()) then
		Perl_ArcaneBar_CastTime:Hide();
	end

	local current_time = this.maxValue - GetTime();
	if (this.channeling) then
		current_time = this.endTime - GetTime();
	end

	if (showtimer == 1) then
		local text = string.sub(math.max(current_time,0)+0.001,1,4);
		if (this.delaySum ~= 0) then
			local delay = string.sub(math.max(this.delaySum/1000, 0)+0.001,1,4);
			if (this.channeling == 1) then
				this.sign = "-";
			else
				this.sign = "+";
			end
			text = "|cffcc0000"..this.sign..delay.."|r "..text;
		end
		Perl_ArcaneBar_CastTime:SetText(text);
	else
		Perl_ArcaneBar_CastTime:SetText();
	end

	if (this.casting) then
		local status = GetTime();
		if (status > this.maxValue) then
			status = this.maxValue
		end
		Perl_ArcaneBar:SetValue(status);
		Perl_ArcaneBarFlash:Hide();
		local sparkPosition = ((status - this.startTime) / (this.maxValue - this.startTime)) * (Perl_Player_NameFrame:GetWidth() - 10);
		if (sparkPosition < 0) then
			sparkPosition = 0;
		end
		Perl_ArcaneBarSpark:SetPoint("CENTER", "Perl_ArcaneBar", "LEFT", sparkPosition, 0);
	elseif (this.channeling) then
		local time = GetTime();
		if (time > this.endTime) then
			time = this.endTime
		end
		if (time == this.endTime) then
			this.channeling = nil;
			this.fadeOut = 1;
			return;
		end
		local barValue = this.startTime + (this.endTime - time);
		Perl_ArcaneBar:SetValue(barValue);
		Perl_ArcaneBarFlash:Hide();
		local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime)) * (Perl_Player_NameFrame:GetWidth() - 10);
		Perl_ArcaneBarSpark:SetPoint("CENTER", "Perl_ArcaneBar", "LEFT", sparkPosition, 0);
	elseif (GetTime() < this.holdTime) then
		return;
	elseif (this.flash) then
		local alpha = Perl_ArcaneBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP;
		if (alpha < 1) then
			Perl_ArcaneBarFlash:SetAlpha(alpha);
		else
			this.flash = nil;
		end
	elseif (this.fadeOut) then
		local alpha = this:GetAlpha() - CASTING_BAR_ALPHA_STEP;
		if (alpha > 0) then
			this:SetAlpha(alpha);
		else
			this.fadeOut = nil;
			this:Hide();
		end
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_ArcaneBar_Set_Enabled(newvalue)
	enabled = newvalue;
	Perl_ArcaneBar_UpdateVars();
	if (enabled == 0) then
		Perl_ArcaneBar_Unregister("Perl_ArcaneBarFrame");
	else
		Perl_ArcaneBar_Register("Perl_ArcaneBarFrame");
	end
end

function Perl_ArcaneBar_Set_Timer(newvalue)
	showtimer = newvalue;
	Perl_ArcaneBar_UpdateVars();
end

function Perl_ArcaneBar_Set_Hide(newvalue)
	hideoriginal = newvalue;
	Perl_ArcaneBar_UpdateVars();
	if (hideoriginal == 0) then
		Perl_ArcaneBar_Register("CastingBarFrame");
	else
		Perl_ArcaneBar_Unregister("CastingBarFrame");
	end
end

function Perl_ArcaneBar_Set_Name_Replace(newvalue)
	namereplace = newvalue;
	Perl_ArcaneBar_UpdateVars();
	Perl_Player_NameBarText:SetText(UnitName("player"));
end

function Perl_ArcaneBar_Set_Left_Timer(newvalue)
	lefttimer = newvalue;
	Perl_ArcaneBar_UpdateVars();
end

function Perl_ArcaneBar_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_ArcaneBar_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_ArcaneBar_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	enabled = Perl_ArcaneBar_Config[name]["Enabled"];
	hideoriginal = Perl_ArcaneBar_Config[name]["HideOriginal"];
	showtimer = Perl_ArcaneBar_Config[name]["ShowTimer"];
	transparency = Perl_ArcaneBar_Config[name]["Transparency"];
	namereplace = Perl_ArcaneBar_Config[name]["NameReplace"];
	lefttimer = Perl_ArcaneBar_Config[name]["LeftTimer"];

	if (enabled == nil) then
		enabled = 1;
	end
	if (hideoriginal == nil) then
		hideoriginal = 0;
	end
	if (showtimer == nil) then
		showtimer = 1;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (namereplace == nil) then
		namereplace = 0;
	end
	if (lefttimer == nil) then
		lefttimer = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_ArcaneBar_UpdateVars();

		-- Call any code we need to activate them
		Perl_ArcaneBar_Set_Enabled(enabled);
		Perl_ArcaneBar_Set_Hide(hideoriginal);
		Perl_ArcaneBar_Set_Name_Replace(namereplace);
		Perl_ArcaneBar_Set_Transparency();
		return;
	end

	local vars = {
		["enabled"] = enabled,
		["hideoriginal"] = hideoriginal,
		["showtimer"] = showtimer,
		["transparency"] = transparency,
		["namereplace"] = namereplace,
		["lefttimer"] = lefttimer,
	}
	return vars;
end

function Perl_ArcaneBar_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Enabled"] ~= nil) then
				enabled = vartable["Global Settings"]["Enabled"];
			else
				enabled = nil;
			end
			if (vartable["Global Settings"]["HideOriginal"] ~= nil) then
				hideoriginal = vartable["Global Settings"]["HideOriginal"];
			else
				hideoriginal = nil;
			end
			if (vartable["Global Settings"]["ShowTimer"] ~= nil) then
				showtimer = vartable["Global Settings"]["ShowTimer"];
			else
				showtimer = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["NameReplace"] ~= nil) then
				namereplace = vartable["Global Settings"]["NameReplace"];
			else
				namereplace = nil;
			end
			if (vartable["Global Settings"]["LeftTimer"] ~= nil) then
				lefttimer = vartable["Global Settings"]["LeftTimer"];
			else
				lefttimer = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (enabled == nil) then
			enabled = 1;
		end
		if (hideoriginal == nil) then
			hideoriginal = 0;
		end
		if (showtimer == nil) then
			showtimer = 1;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (namereplace == nil) then
			namereplace = 0;
		end
		if (lefttimer == nil) then
			lefttimer = 0;
		end

		-- Call any code we need to activate them
		Perl_ArcaneBar_Set_Enabled(enabled);
		Perl_ArcaneBar_Set_Hide(hideoriginal);
		Perl_ArcaneBar_Set_Name_Replace(namereplace);
		Perl_ArcaneBar_Set_Transparency();
	end

	Perl_ArcaneBar_Config[UnitName("player")] = {
		["Enabled"] = enabled,
		["HideOriginal"] = hideoriginal,
		["ShowTimer"] = showtimer,
		["Transparency"] = transparency,
		["NameReplace"] = namereplace,
		["LeftTimer"] = lefttimer,
	};
end


----------------------
-- myAddOns Support --
----------------------
function Perl_ArcaneBar_myAddOns_Support()
	-- Register the addon in myAddOns
	if(myAddOnsFrame_Register) then
		local Perl_ArcaneBar_myAddOns_Details = {
			name = "Perl_ArcaneBar",
			version = "Version 11200.4",
			releaseDate = "November 3, 2006",
			author = "Zlixar; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_ArcaneBar_myAddOns_Help = {};
		Perl_ArcaneBar_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_ArcaneBar_myAddOns_Details, Perl_ArcaneBar_myAddOns_Help);
	end
end