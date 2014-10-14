---------------
-- Variables --
---------------
Perl_Player_Buff_Config = {};
local Perl_Player_Buff_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_Player_Buff_GetVars)
local buffalerts = 1;		-- alerts are enabled by default
local showbuffs = 1;		-- mod is on be default
local scale = 1;		-- default scale
local hideseconds = 0;		-- seconds are shown by default
local horizontalspacing = 10;	-- default horizontal spacing

-- Default Local Variables
local BuffAlphaMax = 1;		-- Max alpha.
local BuffAlphaMin = 0.25;	-- Minimum alpha for the sine modulation.
local BuffCycleSpeed = 0.75;	-- Cycles per second.
local BuffWarnTime = 31;	-- Onset of flashing
local Initialized = nil;	-- waiting to be initialized
local transparency = 1;		-- 0.8 default from perl
local debuffcheck = {		-- table used for debuff stuff below
	[0] = 0,
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0,
	[7] = 0,
	[8] = 0,
	[9] = 0,
	[10] = 0,
	[11] = 0,
	[12] = 0,
	[13] = 0,
	[14] = 0,
	[15] = 0,
	[16] = 0,
	[17] = 0,
	[18] = 0,
	[19] = 0,
	[20] = 0,
	[21] = 0,
	[22] = 0,
	[23] = 0,
	[24] = 0,
}


----------------------
-- Loading Function --
----------------------
function Perl_Player_Buff_OnLoad()
	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_Player_Buff_OnEvent);
	this:SetScript("OnUpdate", Perl_Player_Buff_UpdateAll);
end

function Perl_Player_Buff_Buff_OnLoad()
	this:RegisterForClicks("RightButtonUp");
end


---------------------------
-- Event/Update Handlers --
---------------------------
function Perl_Player_Buff_OnEvent()
	local func = Perl_Player_Buff_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Player Buff: Report the following event error to the author: "..event);
	end
end

function Perl_Player_Buff_Events:VARIABLES_LOADED()
	Perl_Player_Buff_Initialize();
end
Perl_Player_Buff_Events.PLAYER_ENTERING_WORLD = Perl_Player_Buff_Events.VARIABLES_LOADED;


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Player_Buff_Initialize()
	-- Code to be run after zoning or logging in goes here
	if (Initialized) then
		Perl_Player_Buff_Set_Scale();
		Perl_Player_Buff_Allign();
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Player_Buff_Config[UnitName("player")]) == "table") then
		Perl_Player_Buff_GetVars();
	else
		Perl_Player_Buff_UpdateVars();
	end

	-- Major config options.
	Perl_Player_BuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_BuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_UseBuffs(showbuffs);

	-- MyAddOns Support
	Perl_Player_Buff_myAddOns_Support();

	Initialized = 1;
end


--------------------
-- Buff Functions --
--------------------
function Perl_Player_Buff_UpdateAll()
	if (UnitName("player") and showbuffs == 1) then
		Perl_Player_BuffFrame:Show();

		for buffnum=1,24 do
			local button = getglobal("Perl_Player_Buff"..buffnum);
			local buffIndex, untilCancelled = GetPlayerBuff((buffnum - 1), "HELPFUL|HARMFUL");

			if (buffIndex > -1) then
				local icon = getglobal(button:GetName().."Icon");
				local debuff = getglobal(button:GetName().."DebuffBorder");
				local timetext = getglobal(button:GetName().."DurationText");
				local buffname = Perl_Player_GetBuffName(buffIndex);
				local debuffCount = getglobal(button:GetName().."Count");

				icon:SetTexture(GetPlayerBuffTexture(buffIndex));

				local debuffApplications = GetPlayerBuffApplications(buffIndex);
				if (debuffApplications > 1) then
					debuffCount:SetText(debuffApplications);
					debuffCount:Show();
				else
					debuffCount:Hide();
				end

				local isbuffadebuff = Perl_Player_BuffIsDebuff(buffIndex);
				if (isbuffadebuff == -1) then
					button.isdebuff = 0;
				else
					if (isbuffadebuff == -1 and buffIndex == 0) then
						debuffcheck[0] = 1;
					else
						debuffcheck[(isbuffadebuff + buffIndex)] = 1;
					end
					button.isdebuff = 1;
				end

				debuff:Hide();				-- Set this to hidden so the debuff loop below can properly set it
				timetext:SetTextColor(1, 1, 0, 1);	-- Set this to default color so the debuff loop below can properly set it

				if (untilCancelled == 0) then
					local timeleft = GetPlayerBuffTimeLeft(buffIndex);
					timetext:SetText(Perl_Player_GetStringTime(timeleft));
					timetext:Show();

					if (timeleft < BuffWarnTime) then
						local BuffAlpha;
						if (timeleft > 0) then
							BuffAlpha = BuffAlphaMin + 0.5 * (BuffAlphaMax - BuffAlphaMin) * (1 + math.sin(2 * math.pi * timeleft));
						else
							BuffAlpha = 0;
						end

						if (BuffAlpha > 1) then
							BuffAlpha = 1;
						elseif (BuffAlpha < 0) then
							BuffAlpha = 0;
						end
						button:SetAlpha(BuffAlpha);

						if ((button.isdebuff == 0) and (button.notwarned == 1) and (button.name == buffname) and (buffalerts == 1)) then
							if (GetLocale() == "zhCN") then
								UIErrorsFrame:AddMessage(buffname.." 将在30秒后消失.", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
								DEFAULT_CHAT_FRAME:AddMessage("|cffffffff<"..buffname..">|cffffff00 将在30秒后消失.");
							else
								UIErrorsFrame:AddMessage(buffname.." will expire in 30 seconds", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
								DEFAULT_CHAT_FRAME:AddMessage("|cffffffff<"..buffname..">|cffffff00 will expire in 30 seconds");
							end
							button.notwarned = 0;
						else
							button.notwarned = 0;
						end
					else
						button:SetAlpha(1);
						if (button.notwarned ~= 1) then
							button.notwarned = 1;
						end
					end
				else
					timetext:Hide();
					button:SetAlpha(1);
					button.notwarned = 0;
				end

				if ((buffname ~= nil) and (button.name ~= buffname)) then
					button.name = buffname;
					button.notwarned = 0;
				end
				button:Show();
			else
				button:Hide();
				button.notwarned = 0;
			end
		end

		for buffnum=0,24 do			-- Read the debuff table and set debuffs accordingly
			if (debuffcheck[buffnum] ~= 0) then
				local adjustedbuffnum = buffnum + 1;
				local debuff = getglobal("Perl_Player_Buff"..adjustedbuffnum.."DebuffBorder");
				local timetext = getglobal("Perl_Player_Buff"..adjustedbuffnum.."DurationText");

				-- If you know how to fix this to make it work with the below commented call, by all means, please do, I can't seem to figure it out.
--				local debuffType = Perl_Player_GetDebuffType(buffnum+1);
--				if (debuffType) then
--					color = DebuffTypeColor[debuffType];
--				else
--					color = DebuffTypeColor[PERL_LOCALIZED_BUFF_NONE];
--				end
--				debuff:SetVertexColor(color.r, color.g, color.b);

				local color = DebuffTypeColor[PERL_LOCALIZED_BUFF_NONE];
				debuff:SetVertexColor(color.r, color.g, color.b);

				debuff:Show();
				timetext:SetTextColor(1, 0, 0, 1);
			end
		end

		for buffnum=0,24 do			-- Reset the debuff table
			debuffcheck[buffnum] = 0;
		end
	else
		Perl_Player_BuffFrame:Hide();
	end

	if (not UIParent:IsShown()) then		-- Ugly way of making the buffs hide when ALT+Z is pressed, mod is still working when hidden
		Perl_Player_BuffFrame:Hide();
	else
		if (showbuffs == 1) then
			Perl_Player_BuffFrame:Show();
		else
			Perl_Player_BuffFrame:Hide();
		end
	end
end

function Perl_Player_BuffIsDebuff(index)
		local debuffIndex = GetPlayerBuff(index, "HARMFUL");
		if (debuffIndex == -1) then
			return -1;
		else
			return debuffIndex;
		end
end

function Perl_Player_GetStringTime(timenum)
	local minutes = math.floor(timenum / 60);
	local seconds = math.floor(timenum - 60 * minutes);
	local timestring;

	if (string.len(seconds) == 1) then
		seconds = "0"..seconds;
	end

	if (minutes > 60) then
		local hours = math.floor(minutes / 60);
		minutes = minutes - 60 * hours;
		if (string.len(minutes) == 1) then
			minutes = "0"..minutes;
		end
		if (hideseconds == 1) then
			timestring = hours.."h "..minutes.."m";
		else
			timestring = hours..":"..minutes..":"..seconds;
		end
		
	else
		if (hideseconds == 1) then
			if (minutes < 1) then
				timestring = seconds.."s";
			else
				timestring = minutes.."m";
			end
		else
			timestring = minutes..":"..seconds;
		end
	end

	return timestring;
end

function Perl_Player_SetBuffTooltip()
	local buffIndex = GetPlayerBuff((this:GetID() - 1), "HELPFUL|HARMFUL");

	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetPlayerBuff(buffIndex);
end

function Perl_Player_GetBuffName(buffIndex)
	if ((buffIndex < 24) and (buffIndex > -1)) then
		local tooltip = Perl_Player_Buff_Tooltip;
		if (tooltip) then
			tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
			tooltip:SetPlayerBuff(buffIndex);
		end

		local toolTipText = getglobal("Perl_Player_Buff_TooltipTextLeft1");
		if (toolTipText) then
			local name = toolTipText:GetText();
			if (name ~= nil) then
				return name;
			end
		end
	end

	return nil;
end

-- If you know how to fix this to make it work with the above commented call, by all means, please do, I can't seem to figure it out.
--function Perl_Player_GetDebuffType(buffIndex)
--	if ((buffIndex < 24) and (buffIndex > -1)) then
--		--local tooltip = Perl_Player_Buff_DebuffName_Tooltip;
--		if (tooltip) then
--			--tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
--			--tooltip:SetPlayerBuff(buffIndex);
--			Perl_Player_Buff_DebuffName_Tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
--			Perl_Player_Buff_DebuffName_Tooltip:SetPlayerBuff(buffIndex);
--		end
--
--		--local toolTipText = getglobal("Perl_Player_Buff_DebuffName_TooltipTextRight1");
--		local toolTipText = Perl_Player_Buff_DebuffName_TooltipTextRight1:GetText();
--		--DEFAULT_CHAT_FRAME:AddMessage("Perl_Player_Buff_DebuffName_TooltipTextRight1 = "..Perl_Player_Buff_DebuffName_TooltipTextRight1:GetText());
--		--DEFAULT_CHAT_FRAME:AddMessage("toolTipText = "..toolTipText);
--		if (toolTipText) then
--			--local name = toolTipText:GetText();
--			--if (name ~= nil) then
--			--	return name;
--			--end
--			return toolTipText;
--		end
--	end
--
--	return nil;
--end

function Perl_Player_BuffClicked(button)
	if (button == "RightButton") then
		local buffIndex = GetPlayerBuff((this:GetID() - 1), "HELPFUL|HARMFUL");
		CancelPlayerBuff(buffIndex);
		this.notwarned = 0;
	end
end

function Perl_Player_UseBuffs(useperlbuffs)
	if (useperlbuffs == 1) then
		BuffFrame:Hide();
	else
		BuffFrame:Show();
	end
end

function Perl_Player_Buff_Allign()
	Perl_Player_Buff2:SetPoint("TOPLEFT", Perl_Player_Buff1, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff3:SetPoint("TOPLEFT", Perl_Player_Buff2, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff4:SetPoint("TOPLEFT", Perl_Player_Buff3, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff5:SetPoint("TOPLEFT", Perl_Player_Buff4, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff6:SetPoint("TOPLEFT", Perl_Player_Buff5, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff7:SetPoint("TOPLEFT", Perl_Player_Buff6, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff8:SetPoint("TOPLEFT", Perl_Player_Buff7, "TOPRIGHT", horizontalspacing, 0);

	Perl_Player_Buff10:SetPoint("TOPLEFT", Perl_Player_Buff9, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff11:SetPoint("TOPLEFT", Perl_Player_Buff10, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff12:SetPoint("TOPLEFT", Perl_Player_Buff11, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff13:SetPoint("TOPLEFT", Perl_Player_Buff12, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff14:SetPoint("TOPLEFT", Perl_Player_Buff13, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff15:SetPoint("TOPLEFT", Perl_Player_Buff14, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff16:SetPoint("TOPLEFT", Perl_Player_Buff15, "TOPRIGHT", horizontalspacing, 0);

	Perl_Player_Buff18:SetPoint("TOPLEFT", Perl_Player_Buff17, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff19:SetPoint("TOPLEFT", Perl_Player_Buff18, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff20:SetPoint("TOPLEFT", Perl_Player_Buff19, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff21:SetPoint("TOPLEFT", Perl_Player_Buff20, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff22:SetPoint("TOPLEFT", Perl_Player_Buff21, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff23:SetPoint("TOPLEFT", Perl_Player_Buff22, "TOPRIGHT", horizontalspacing, 0);
	Perl_Player_Buff24:SetPoint("TOPLEFT", Perl_Player_Buff23, "TOPRIGHT", horizontalspacing, 0);
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Player_Buff_Set_ShowBuffs(newvalue)
	showbuffs = newvalue;
	Perl_Player_Buff_UpdateVars();
	Perl_Player_UseBuffs(showbuffs);
end

function Perl_Player_Buff_Set_Alerts(newvalue)
	buffalerts = newvalue;
	Perl_Player_Buff_UpdateVars();
end

function Perl_Player_Buff_Set_Hide_Seconds(newvalue)
	hideseconds = newvalue;
	Perl_Player_Buff_UpdateVars();
end

function Perl_Player_Buff_Set_Horizontal_Spacing(number)
	if (number ~= nil) then
		horizontalspacing = number;
		Perl_Player_Buff_UpdateVars();
	end
	Perl_Player_Buff_Allign();
end

function Perl_Player_Buff_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Player_BuffFrame:SetScale(unsavedscale);
	Perl_Player_Buff_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Player_Buff_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	buffalerts = Perl_Player_Buff_Config[name]["BuffAlerts"];
	showbuffs = Perl_Player_Buff_Config[name]["ShowBuffs"];
	scale = Perl_Player_Buff_Config[name]["Scale"];
	hideseconds = Perl_Player_Buff_Config[name]["HideSeconds"];
	horizontalspacing = Perl_Player_Buff_Config[name]["HorizontalSpacing"];

	if (buffalerts == nil) then
		buffalerts = 1;
	end
	if (showbuffs == nil) then
		showbuffs = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (hideseconds == nil) then
		hideseconds = 0;
	end
	if (horizontalspacing == nil) then
		horizontalspacing = 10;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Player_Buff_UpdateVars();

		-- Call any code we need to activate them
		Perl_Player_UseBuffs(showbuffs);
		Perl_Player_Buff_Set_Scale();
		return;
	end

	local vars = {
		["buffalerts"] = buffalerts,
		["showbuffs"] = showbuffs,
		["scale"] = scale,
		["hideseconds"] = hideseconds,
		["horizontalspacing"] = horizontalspacing,
	}
	return vars;
end

function Perl_Player_Buff_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["BuffAlerts"] ~= nil) then
				buffalerts = vartable["Global Settings"]["BuffAlerts"];
			else
				buffalerts = nil;
			end
			if (vartable["Global Settings"]["ShowBuffs"] ~= nil) then
				showbuffs = vartable["Global Settings"]["ShowBuffs"];
			else
				showbuffs = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["HideSeconds"] ~= nil) then
				hideseconds = vartable["Global Settings"]["HideSeconds"];
			else
				hideseconds = nil;
			end
			if (vartable["Global Settings"]["HorizontalSpacing"] ~= nil) then
				horizontalspacing = vartable["Global Settings"]["HorizontalSpacing"];
			else
				horizontalspacing = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (buffalerts == nil) then
			buffalerts = 1;
		end
		if (showbuffs == nil) then
			showbuffs = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (hideseconds == nil) then
			hideseconds = 0;
		end
		if (horizontalspacing == nil) then
			horizontalspacing = 10;
		end

		-- Call any code we need to activate them
		Perl_Player_UseBuffs(showbuffs);
		Perl_Player_Buff_Set_Scale();
	end

	Perl_Player_Buff_Config[UnitName("player")] = {
		["BuffAlerts"] = buffalerts,
		["ShowBuffs"] = showbuffs,
		["Scale"] = scale,
		["HideSeconds"] = hideseconds,
		["HorizontalSpacing"] = horizontalspacing,
	};
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Player_Buff_myAddOns_Support()
	-- Register the addon in myAddOns
	if(myAddOnsFrame_Register) then
		local Perl_Player_Buff_myAddOns_Details = {
			name = "Perl_Player_Buff",
			version = "Version 11200.4",
			releaseDate = "November 3, 2006",
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Player_Buff_myAddOns_Help = {};
		Perl_Player_Buff_myAddOns_Help[1] = "/perlplayerbuff\n/ppb\n";
		myAddOnsFrame_Register(Perl_Player_Buff_myAddOns_Details, Perl_Player_Buff_myAddOns_Help);
	end
end