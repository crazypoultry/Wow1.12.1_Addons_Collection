--
-- CooldownHud
-- Copyright 2005,2006 original author. 
-- Copyright is expressly not transferred to Blizzard.
-- 
--
-- During combat will show icons above your chat window 
-- (slightly transparent) showing the icons for spells 
-- currently awaiting cooldown. Disappears entirely when 
-- combat ends. Less watching the actionbar, and is closer 
-- to the action on the screen.
-- 
-- Author: Marc aka Saien on Hyjal
-- WoWSaien@gmail.com
-- http://64.168.251.69/wow
--
-- Recent changes
-- 2005.10.10
--   TOC change to 1800 and adjust to 1.8 changes
-- 2005.09.13
--   TOC change to 1700 and adjust to 1.7 changes
--   1.6 changed event firing so if you zoned while in combat, CooldownHud would think 
--     you were still in combat until you entered and left combat again.
-- 2005.06.17
--   New commands "/cooldownhud min" and "/cooldownhud max" to set minimum and maximum lengths to show. Use this to avoid showing global cooldown when using bows/wands with a delay in excess of 1.5 seconds.
--   New TOC 1500
-- 2005.04.20
--   Fixup various MORE localization errors. Too much effort. 
--      Shouldn't have done it
--   Fix popup error on login that's only happened to me once.
-- 2005.03.24
--   TOC change to 1300
-- 2005.03.05
--   Updated TOC to 4216
--   Fix bugs introduced by localizing everything
-- 2005.02.20
--   Option to show cooldownhud out of combat: "/hud show always" or "/hud show in combat"
--   Updated toc to 4211
-- 2005.02.13
--   When moving locks from one button to another without doing the unlock inbetween, 
--     it will now do what you intended, and not what you told it to do.
--   Yeah ok, click through instead of hiding the buttons is in
--   Do /cooldownhud hideformouse to return to the previous behavior.
-- 2005.01.18
--   Hunters have screwing half second cooldowns, so change rounding.
-- 2005.01.10
--   Added Digital display for cooldowns, default is ON
--     /cooldownhud digital to toggle off and on
--   When cooldown is working, mousing over the displays will turn that display off 
--     (This is because if you're mousing over you're probably trying to click a new target, 
--     loot, or something, and the display is getting in the way. Since I can't find a way 
--     to "click through", this will have to do.)
--   Copy command, copy button positions from one character to another
--     /hud copy <source playername>
--   Exclude list implemented
--     /hud exclude <spellname>
--     /hud include <spellname>
--     Spellnames are case insensitive, and nothing nasty will happen if you misspell.
--   Lock spells to certain buttons
--     /hud lock 12 Insta Gib Paladin -- Will lock button 12 to the "Insta Gib Paladin" spell
--     /hud unlock 12 -- Will unlock button 12
--

COOLDOWNHUD_VERSION = "2005.10.10" -- Notice the cleverly disguised date.

local COOLDOWNHUD_ALPHA = 0.5;
local CooldownHud_InCombat = nil;
local CooldownHud_OnHateList = nil;
local CooldownHud_Config_Loaded = nil;
local CooldownHud_Player = nil;
local CooldownHud_PlayerClass = nil;
local CooldownHud_SetupMode = nil;
local CooldownHud_LastUpdate = 0;

local CooldownHud_Default = {};
CooldownHud_Default.buttons = {};
CooldownHud_Default.buttons[1] = "477,500";
CooldownHud_Default.buttons[2] = "511,500";
CooldownHud_Default.buttons[3] = "443,483";
CooldownHud_Default.buttons[4] = "545,483";
CooldownHud_Default.buttons[5] = "409,466";
CooldownHud_Default.buttons[6] = "579,466";
CooldownHud_Default.buttons[7] = "409,432";
CooldownHud_Default.buttons[8] = "579,432";
CooldownHud_Default.buttons[9] = "409,398";
CooldownHud_Default.buttons[10] = "579,398";
CooldownHud_Default.buttons[11] = "409,364";
CooldownHud_Default.buttons[12] = "579,364";
CooldownHud_DefaultComputed = nil;

local function CooldownHud_SetupDefault()
	if (not CooldownHud_DefaultComputed and UIParent:GetScale() ~= 1) then
		local i;
		CooldownHud_DefaultComputed = 1;
		for i = 1, 12, 1 do
			local idx = string.find(CooldownHud_Default.buttons[i],",");
			local left = string.sub(CooldownHud_Default.buttons[i],1,idx-1);
			local top = string.sub(CooldownHud_Default.buttons[i],idx+1);
			left = left / UIParent:GetScale();
			top = top / UIParent:GetScale();
			CooldownHud_Default.buttons[i] = left..","..top;
		end
		CooldownHud_DefaultComputed = 1;
	end
end

local function CooldownHud_FindSpell (spellName, caseinsensitive)
	local id = 1;
	local subName;
	local searchName;
	searchName, subName = GetSpellName(id,BOOKTYPE_SPELL);
	if (searchName and caseinsensitive) then 
		searchName = string.lower(searchName);
	end
	while (searchName and searchName ~= spellName) do
		id = id + 1;
		searchName, subName = GetSpellName(id,BOOKTYPE_SPELL);
		if (searchName and caseinsensitive) then 
			searchName = string.lower(searchName);
		end
	end
	if (not searchName) then
		id = nil;
	end
	return id;
end

local function CooldownHud_UnExcludeDisplay (searchName)
	CooldownHud_Config[CooldownHud_Player].exclude[searchName] = nil;
end

local function CooldownHud_ExcludeDisplay (searchName)
	CooldownHud_Config[CooldownHud_Player].exclude[searchName] = true;
end

local function CooldownHud_SetLocations()
	local i;
	for i = 1, 12, 1 do
		local button = getglobal ("CooldownHud_Button"..i);
		if (button) then
			local idx = nil;
			local left = nil;
			local top = nil;
			if (CooldownHud_Config[CooldownHud_Player].buttons[i]) then
				idx = string.find(CooldownHud_Config[CooldownHud_Player].buttons[i],",");
				left = string.sub(CooldownHud_Config[CooldownHud_Player].buttons[i],1,idx-1);
				top = string.sub(CooldownHud_Config[CooldownHud_Player].buttons[i],idx+1);
			end
			if (not left or not top) then
				idx = string.find(CooldownHud_Default.buttons[i],",");
				left = string.sub(CooldownHud_Default.buttons[i],1,idx-1);
				top = string.sub(CooldownHud_Default.buttons[i],idx+1);
			end
			left = left * 1; -- Force numerical type
			top = top * 1;
			button:ClearAllPoints();
			button:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",left,top);
		end
	end
end

local function CooldownHud_SetSpell(button, id)
	button.spellID = id;
	local texture = GetSpellTexture(id, BOOKTYPE_SPELL);
	local icon = getglobal(button:GetName().."Icon");
	-- local normalTexture = getglobal(button:GetName().."NormalTexture");
	icon:SetTexture(texture);
	-- normalTexture:SetVertexColor(1.0, 1.0, 1.0);
end


local function CooldownHud_SetLocks()
	local i;
	for i = 1, 12, 1 do
		local button = getglobal("CooldownHud_Button"..i);
		if (button.spellID == button.lockID) then button.spellID = nil; end
		button.lockID = nil;
		if (CooldownHud_Config[CooldownHud_Player].locklist[i]) then
			local spellNum = CooldownHud_FindSpell (CooldownHud_Config[CooldownHud_Player].locklist[i]);
			if (spellNum) then
				button.lockName = CooldownHud_Config[CooldownHud_Player].locklist[i];
				button.lockID = spellNum;
				button.spellID = spellNum;
				CooldownHud_SetSpell(button, spellNum)
			else
				CooldownHud_Config[CooldownHud_Player].locklist[i] = nil;
			end
		end
	end
end

local function CooldownHud_ConfigInit()
	if (not CooldownHud_Player or not CooldownHud_Config_Loaded) then
		return;
	end
	if (not CooldownHud_Config) then
		CooldownHud_Config = {};
	end
	if (not CooldownHud_Config[CooldownHud_Player]) then
		CooldownHud_Config[CooldownHud_Player] = {};
	end
	if (not CooldownHud_Config[CooldownHud_Player].buttons) then
		CooldownHud_Config[CooldownHud_Player].buttons = {};
	end
	if (not CooldownHud_Config[CooldownHud_Player].exclude) then
		CooldownHud_Config[CooldownHud_Player].exclude = {};
	end
	if (not CooldownHud_Config[CooldownHud_Player].locklist) then
		CooldownHud_Config[CooldownHud_Player].locklist = {};
	end
	if (not CooldownHud_Config[CooldownHud_Player].digital) then
		CooldownHud_Config[CooldownHud_Player].digital = 1;
	end

	if (CooldownHud_Config[CooldownHud_Player].hideformouse) then
		local i;
		for i = 1, 12, 1 do
			getglobal("CooldownHud_Button"..i.."_Hider"):Show();
		end
	end
	CooldownHud_SetLocks();
end


local function CooldownHud_SlashCmd(msg)
	msg = string.lower(msg);
	local firstword = nil;
	local restwords = nil;
	local idx = string.find(msg," ");
	if (idx) then
		firstword = string.sub(msg,1,idx-1);
		restwords = string.sub(msg,idx+1);
	else
		firstword = msg;
	end

	if (firstword == "reset") then
		DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Resetting display positions.");
		CooldownHud_Config[CooldownHud_Player].buttons = {};
		CooldownHud_ConfigInit();
		CooldownHud_SetLocations();
	elseif (firstword == "digital") then
		if (restwords == "on") then
			CooldownHud_Config[CooldownHud_Player].digital = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Digital Display on.");
		elseif (restwords == "off") then
			CooldownHud_Config[CooldownHud_Player].digital = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Digital Display off.");
		else
			if (CooldownHud_Config[CooldownHud_Player].digital == 1) then
				CooldownHud_Config[CooldownHud_Player].digital = 0;
				DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Digital Display off.");
			else
				CooldownHud_Config[CooldownHud_Player].digital = 1;
				DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Digital Display on.");
			end
		end
	elseif (firstword == "min") then
		local newmin = restwords * 1;
		if (newmin > 0) then
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Spells cooling for "..newmin.." seconds or less are not shown.");
			if (newmin == 1.5) then newmin = nil; end
			CooldownHud_Config[CooldownHud_Player].mincooldown = newmin;
		end
	elseif (firstword == "max") then
		local newmax = restwords * 1;
		if (newmax > 0) then
			CooldownHud_Config[CooldownHud_Player].maxcooldown = newmin;
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Spells cooling for "..newmax.." seconds or or more are not shown.");
		end
	elseif (firstword == "setup") then
		if (CooldownHud_SetupMode) then
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Leaving setup mode.");
			CooldownHud_SetupMode = nil;
			local i;
			for i = 1, 12, 1 do
				local move = getglobal("CooldownHud_Button"..i.."_Move");
				local text = getglobal ("CooldownHud_Button"..i.."Text");
				text:SetText("");
				move.moving = nil;
				move:Hide();
				getglobal("CooldownHud_Button"..i):Hide();
				if (CooldownHud_Config[CooldownHud_Player].hideformouse) then
					getglobal("CooldownHud_Button"..i.."_Hider"):Show();
				end
			end
			CooldownHud_SetLocations();
			CooldownHud_OnUpdate(1);
		else
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Entering setup mode.");
			local i;
			for i = 1, 12, 1 do
				local button = getglobal("CooldownHud_Button"..i);
				local text = getglobal ("CooldownHud_Button"..i.."Text");
				text:SetText(i);
				getglobal("CooldownHud_Button"..i):Show();
				getglobal("CooldownHud_Button"..i.."_Move"):Show();
				getglobal("CooldownHud_Button"..i.."_Hider"):Hide();
			end
			CooldownHud_SetupMode = 1;
			CooldownHud_SetLocations();
			CooldownHud_OnUpdate(1);
		end
	elseif (firstword == "hideformouse" or firstword == "hidewithmouse") then
		if (CooldownHud_Config[CooldownHud_Player].hideformouse) then
			CooldownHud_Config[CooldownHud_Player].hideformouse = nil;
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: No longer hiding icons at mouseover.");
			local i;
			for i = 1, 12, 1 do
				getglobal("CooldownHud_Button"..i.."_Hider"):Hide();
			end
		else
			CooldownHud_Config[CooldownHud_Player].hideformouse = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Now hiding icons at mouseover.");
			local i;
			for i = 1, 12, 1 do
				getglobal("CooldownHud_Button"..i.."_Hider"):Show();
			end
		end
	elseif (firstword == "show") then
		if (restwords == "combat" or restwords == "in combat" or restwords == "incombat") then
			CooldownHud_Config[CooldownHud_Player].showwhen = nil;
		elseif (restwords == "always") then
			CooldownHud_Config[CooldownHud_Player].showwhen = "ALWAYS";
		end
		local showwhen = "";
		if (CooldownHud_Config[CooldownHud_Player].showwhen == "ALWAYS") then
			showwhen = "Always";
		elseif (not CooldownHud_Config[CooldownHud_Player].showwhen) then
			showwhen = "In Combat";
		end
		DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Buttons shown: "..showwhen);
	elseif (firstword == "unlock" and restwords) then
		local buttonNum = tonumber(restwords);
		if (buttonNum and buttonNum > 0 and buttonNum <= 12) then
			CooldownHud_Config[CooldownHud_Player].locklist[buttonNum] = nil;
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Button "..buttonNum.." unlocked.");
		end
	elseif (firstword == "lock") then
		local spellName;
		local buttonNum = nil;
		if (restwords) then
			local idx = string.find(restwords," ");
			if (idx) then
				buttonNum = tonumber(string.sub(restwords,1,idx-1));
				spellName = string.sub(restwords,idx+1);
			end
		end
		if (buttonNum and buttonNum > 0 and buttonNum <= 12) then
			local spellNum = CooldownHud_FindSpell (spellName, true)
			if (spellNum) then
				local spellName, spellSub = GetSpellName(spellNum,BOOKTYPE_SPELL);
				for i = 1, 12, 1 do
					if (CooldownHud_Config[CooldownHud_Player].locklist[i] and CooldownHud_Config[CooldownHud_Player].locklist[i] == spellName) then
						CooldownHud_Config[CooldownHud_Player].locklist[i] = nil;
					end
				end
				CooldownHud_Config[CooldownHud_Player].locklist[buttonNum] = spellName;
				DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Button "..buttonNum.." locked to "..spellName);
				CooldownHud_SetLocks();
			else
				DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Spell name \""..spellName.."\" not found.");
			end
		else
			local msg = "Cooldown Hud: Current locks: ";
			local i;
			local spoke = false;
			for i = 1, 12, 1 do
				if (CooldownHud_Config[CooldownHud_Player].locklist[i]) then
					if (spoke) then
						msg = msg..", ";
					end
					msg = msg..i.."="..CooldownHud_Config[CooldownHud_Player].locklist[i];
					spoke = true;
				end
			end
			if (spoke) then 
				DEFAULT_CHAT_FRAME:AddMessage(msg);
			else
				DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: No locks");
			end

		end
		
	elseif (firstword == "copy" and restwords) then
		local charname = string.upper(string.sub(restwords,1,1))..string.sub(restwords,2);
		if (CooldownHud_Config[charname]) then
			CooldownHud_Config[CooldownHud_Player].buttons = {};
			local i;
			for i = 1, 12, 1 do
				if (CooldownHud_Config[charname].buttons[i]) then
					CooldownHud_Config[CooldownHud_Player].buttons[i] = CooldownHud_Config[charname].buttons[i];
					DEFAULT_CHAT_FRAME:AddMessage("Button "..i.." copied.");
				else
					DEFAULT_CHAT_FRAME:AddMessage("Button "..i.." in default position.");
				end
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: No such config \""..charname.."\" to copy from.");
		end
		CooldownHud_SetLocations();
		CooldownHud_OnUpdate(1);
	elseif (firstword == "exclude" and restwords) then
		local spellNum = CooldownHud_FindSpell (restwords, true)
		if (spellNum) then
			local searchName, subName = GetSpellName(spellNum,BOOKTYPE_SPELL);
			CooldownHud_ExcludeDisplay (searchName);
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Spell \""..searchName.."\" will be excluded.");
		else
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Spell \""..restwords.."\" was not found.");
		end
	elseif (firstword == "include" and restwords) then
		local spellNum = CooldownHud_FindSpell (restwords, true)
		if (spellNum) then
			local searchName, subName = GetSpellName(spellNum,BOOKTYPE_SPELL);
			CooldownHud_UnExcludeDisplay (searchName);
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Spell \""..searchName.."\" will be included.");
		else
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Spell \""..restwords.."\" was not found.");
		end
	elseif (firstword == "exclude" or firstword == "include") then
		local msg = "Cooldown Hud: Exclude List: ";
		local spoke = false;
		for spellName in CooldownHud_Config[CooldownHud_Player].exclude do 
			if (spoke) then
				msg = msg..", ";
			end
			msg = msg..spellName;
			spoke = true;
		end
		if (spoke) then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		else
			DEFAULT_CHAT_FRAME:AddMessage("Cooldown Hud: Exclude list is empty.");
		end
	else

		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud (or /cooldown or /cool or /hud)");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud setup -- Toggle setup mode.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud reset -- Reset display positions");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud digital -- Toggle digital cooldown display.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud lock <num> <spell> -- Lock button <num> to <spell>.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud unlock <num> -- Unlock button <num>.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud copy <character> -- Copy button locations from <character>'s config.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud exclude <spell> -- Exclude <spell> from display.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud include <spell> -- Include <spell> in display.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud hideformouse -- Toggle hiding icons at mouseover.");
		DEFAULT_CHAT_FRAME:AddMessage("/cooldownhud show [in combat|always] -- Show cooldown counters in combat/always");
	end
end

local function CooldownHud_AddWatch(id)
	local buttonNum = 1;
	local placed = nil;
	while (not placed and buttonNum <= 12) do
		button = getglobal("CooldownHud_Button"..buttonNum);
		-- Check if this spell has been shown before
		if (button.spellID == id or button.lockID == id) then
				button.cooling = 1;
				this:SetAlpha(COOLDOWNHUD_ALPHA);
				button:Show();
				placed = 1;
		end
		buttonNum = buttonNum + 1;
	end
	buttonNum = 1;
	while (not placed and buttonNum <= 12) do
		button = getglobal("CooldownHud_Button"..buttonNum);
		-- Nope, find an empty spot
		if (button) then
			if (not button.spellID) then
				CooldownHud_SetSpell(button, id);
				button.cooling = 1;
				this:SetAlpha(COOLDOWNHUD_ALPHA);
				button:Show();
				placed = 1;
			end
		end
		buttonNum = buttonNum + 1;
	end
	buttonNum = 1;
	while (not placed and buttonNum <= 12) do
		button = getglobal("CooldownHud_Button"..buttonNum);
		-- None, look for something to overwrite
		if (button) then
			if (not button.lockID and not button.cooling) then
				CooldownHud_SetSpell(button, id);
				button.cooling = 1;
				this:SetAlpha(COOLDOWNHUD_ALPHA);
				button:Show();
				placed = 1;
			end
		end
		buttonNum = buttonNum + 1;
	end
end

local function CooldownHud_CheckAllCooldown()
	local id = 1;
	local subName;
	local searchName;
	local secondName;
	local start, duration, enable;
	searchName, subName = GetSpellName(id,BOOKTYPE_SPELL);
	if (CooldownHud_Config and CooldownHud_Config[CooldownHud_Player] and CooldownHud_Config[CooldownHud_Player].exclude) then
		while (searchName) do
			if (not CooldownHud_Config[CooldownHud_Player].exclude[searchName]) then
				secondName, subName = GetSpellName(id+1,BOOKTYPE_SPELL);
				while (searchName == secondName) do
					id = id + 1;
					secondName, subName = GetSpellName(id+1,BOOKTYPE_SPELL);
				end
				start, duration, enable = GetSpellCooldown(id, BOOKTYPE_SPELL);
				local mincool = CooldownHud_Config[CooldownHud_Player].mincooldown;
				local maxcool = CooldownHud_Config[CooldownHud_Player].maxcooldown;
				if (not mincool) then mincool = 1.5; end
				if (not maxcool) then maxcool = 901; end
				if (start > 0 and duration > mincool and duration < maxcool and enable > 0) then
					CooldownHud_AddWatch(id);
				end
			end
			id = id + 1;
			searchName, subName = GetSpellName(id,BOOKTYPE_SPELL);
		end
	end
end


function CooldownHud_OnLoad()
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLS_CHANGED");

	SLASH_COOLDOWNHUD1 = "/cooldownhud";
	SLASH_COOLDOWNHUD2 = "/cooldown";
	SLASH_COOLDOWNHUD3 = "/cool"; -- As in, I'm so...
	SLASH_COOLDOWNHUD4 = "/hud";
	SlashCmdList["COOLDOWNHUD"] = function (msg)
		CooldownHud_SlashCmd(msg);
	end

	local playerName = UnitName("player");
	if (playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
		CooldownHud_PlayerClass = UnitClass("player");
		CooldownHud_Player = playerName;
	end

	-- DEFAULT_CHAT_FRAME:AddMessage("CooldownHud ("..COOLDOWNHUD_VERSION..") loaded. '/cooldownhud' for command list.");
end

function CooldownHud_OnEvent(event)
	if (event == "SPELL_UPDATE_COOLDOWN") then
		if (CooldownHud_Player and CooldownHud_Config_Loaded and (CooldownHud_Config[CooldownHud_Player].showwhen == "ALWAYS" or CooldownHud_InCombat or CooldownHud_OnHateList)) then
			CooldownHud_CheckAllCooldown();
		end
	elseif (event == "PLAYER_ENTER_COMBAT") then
		CooldownHud_InCombat = 1;
		CooldownHud_CheckAllCooldown();
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		CooldownHud_InCombat = nil;
	elseif (event == "PLAYER_REGEN_DISABLED") then
		CooldownHud_OnHateList = 1;
		CooldownHud_CheckAllCooldown();
	elseif (event == "PLAYER_REGEN_ENABLED") then
		CooldownHud_OnHateList = nil;
	elseif (event == "SPELLS_CHANGED" and CooldownHud_Player and CooldownHud_Config_Loaded) then
		CooldownHud_SetLocks();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		CooldownHud_OnHateList = nil;
		CooldownHud_InCombat = nil;
		if (not CooldownHud_Config_Loaded) then
			CooldownHud_Config_Loaded = 1;
			CooldownHud_ConfigInit();
			CooldownHud_SetupDefault();
			CooldownHud_SetLocations();
		end
	end
end

function CooldownHud_OnUpdate(elapsed)
	CooldownHud_LastUpdate = CooldownHud_LastUpdate + elapsed;
	if (not CooldownHud_Config or not CooldownHud_Player or not CooldownHud_Config[CooldownHud_Player]) then
		return;
	end
	if (CooldownHud_LastUpdate > 0.1) then
		CooldownHud_LastUpdate = 0;
		if (CooldownHud_SetupMode) then
			local i;
			for i = 1, 12, 1 do
				local button = getglobal("CooldownHud_Button"..i);
				local text = getglobal ("CooldownHud_Button"..i.."Text");
				local icon = getglobal("CooldownHud_Button"..i.."Icon");
				if (button.spellID) then
					local texture = GetSpellTexture(button.spellID, BOOKTYPE_SPELL);
					text:SetText(i);
					button.oldtexture = texture;
				end
				icon:SetTexture("Interface\\Icons\\Spell_Shadow_SummonImp");
				button:Show();
			end
		elseif (CooldownHud_Config[CooldownHud_Player].showwhen == "ALWAYS" or CooldownHud_InCombat or CooldownHud_OnHateList) then
			local i;
			for i = 1, 12, 1 do
				local button = getglobal("CooldownHud_Button"..i);
				local text = getglobal ("CooldownHud_Button"..i.."Text");
				if (button.spellID and button.cooling) then
					local cooldown = getglobal("CooldownHud_Button"..i.."Cooldown");
					local start, duration, enable = GetSpellCooldown (button.spellID, BOOKTYPE_SPELL);
					if (start > 0 and duration > 0 and enable > 0) then
						local timeleft = duration-(GetTime()-start);
						if (timeleft - math.floor(timeleft) > 0.5) then
							timeleft = math.floor(timeleft)+1;
						end
						timeleft = math.floor(timeleft);
						if (button.oldtexture) then
							local icon = getglobal("CooldownHud_Button"..i.."Icon");
							icon:SetTexture(button.oldtexture);
							button.oldtexture = nil;
						end
						button:SetAlpha(COOLDOWNHUD_ALPHA);
						if (button.mouseover and button.mouseover < (GetTime()-1)) then
							button.mouseover = nil;
							button:Show();
							
						end
						if (CooldownHud_Config[CooldownHud_Player].digital == 1) then
							text:SetText(timeleft);
						else
							text:SetText("");
						end
						CooldownFrame_SetTimer(cooldown, start, duration, enable);
					else
						button.cooling = nil;
						button:Hide();
						text:SetText("");
					end
				else
					button:Hide();
					button.mouseover = nil;
				end
			end
		else
			local i;
			for i = 1, 12, 1 do
				local button = getglobal("CooldownHud_Button"..i);
				button.cooling = nil;
				button:Hide();
				button.mouseover = nil;
			end
		end
	end
end

function CooldownHud_Moving()
	if (this.moving) then
		this.moving = nil;
		local xPos, yPos = GetCursorPosition();
		if (UIParent:GetScale() ~= 1) then
			xPos = xPos / UIParent:GetScale();
			yPos = yPos / UIParent:GetScale();
		end
		xPos = xPos - 16;
		yPos = yPos + 16;
		button = this:GetParent();
		button:ClearAllPoints();
		button:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",xPos,yPos);
		CooldownHud_Config[CooldownHud_Player].buttons[button:GetID()] = xPos..","..yPos;
	else
		this.moving = 1;
	end
end

function CooldownHud_Button_OnUpdate(elapsed)
	if (this.moving) then
		local xPos, yPos = GetCursorPosition();
		if (UIParent:GetScale() ~= 1) then
			xPos = xPos / UIParent:GetScale();
			yPos = yPos / UIParent:GetScale();
		end
		xPos = xPos - 16;
		yPos = yPos + 16;
		local button = this:GetParent();
		button:ClearAllPoints();
		button:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",xPos,yPos);
	end
end

