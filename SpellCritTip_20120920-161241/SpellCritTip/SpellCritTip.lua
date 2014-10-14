local spcUnitName = nil;
local _, class = UnitClass("player");
local Spells = {};
local hookState = false;
local timer = 0;
local playerItemsStr = "";
local DBid = 1;
local stopUpdate = false;

function SpellCritTipBaseLoad()
	if (SPC_state == nil) then SPC_state = true; end;

	InitializeSpells();
	if (not SpellTipsBase) then
		SpellTipsBase = {};
		InitializeSpellTipBase();
	end
end

local function spellCrit_OnUpdate()
	local tInterval = GetFramerate() / 2;
	if tInterval < 20 then
		tInterval = 20;
	end;

	if (hookState) then
		timer = timer + 1;
		-- if timer == 0 then
			--SendChatMessage(".get spellcritchance "..SpellTipsBase[Spells[DBid]]["id"], "SAY");
		if (timer >= tInterval) and (stopUpdate == true) then
			timer = 0;
			hookState = false;
			stopUpdate = false;
			DBid = 1;
		end

		if (timer >= tInterval) and (stopUpdate == false) then
			timer = 0;

			if (DBid <= getn(Spells)) then
			SendChatMessage(".get spellcritchance "..SpellTipsBase[Spells[DBid]]["id"], "SAY");
-- Print(Spells[DBid]);
			end
			DBid = DBid + 1;
			if (DBid > getn(Spells)) then
				stopUpdate = true;
			end
			
		end
	end

	if GameTooltip:IsShown() and UnitHealth("player") ~= 1 then 
		if (spcUnitName ~= GameTooltipTextLeft1:GetText()) then
			spcUnitName = GameTooltipTextLeft1:GetText();

			local isSpell = false;
			local SpellName = nil;
			for i = 1,getn(Spells),1 do
				if Spells[i] == spcUnitName then 
					isSpell = true;
					SpellName = Spells[i];
				end
			end
			if (isSpell) and (SPC_state) and SpellTipsBase[SpellName]["chance"] ~= nil then
				GameTooltip:AddLine("|cffc7b26fШанс критического удара:|r |cffff6600"..SpellTipsBase[SpellName]["chance"].."%|r", 1, 1, 1,1);
			  	GameTooltip:Show();
			end			
		end
	else
		spcUnitName = nil;
	end;
end;

local ChatFrame_OnEvent_Old;
local function spellCrit_OnEvent()

	local function getPlayerItemsID()
		local charItems = {
			[0] = "Ammo",
			"Head 1",
			"Neck",
			"Shoulder 2",
			"Shirt",
			"Chest 3",
			"Waist 4",
			"Legs 5",
			"Feet 6",
			"Wrist 7",
			"Hands 8",
			"Finger0",
			"Finger1",
			"Trinket0",
			"Trinket1",
			"Back",
			"MainHand 9",
			"SecondaryHand 10",
			"Ranged 11",
			"Tabard",
		}

		local str,Id = "";
		for i, value in pairs(charItems) do
			local itemLink = GetInventoryItemLink("player", i)
			if (itemLink ~= nil) then
				_, _, id = string.find(itemLink, "item:(%d+):");
				str = str..id;
			end
		end
		return str;
	end

	if strsub(event, 1, 16) == "VARIABLES_LOADED" then
		SpellCritTipBaseLoad();

		if ChatFrame_OnEvent_Org == nil then
			ChatFrame_OnEvent_Old = ChatFrame_OnEvent;
			ChatFrame_OnEvent = ChatFrame_OnEvent_New;
		end

		-- local st = nil;
		-- if (SPC_state) then
		-- 	st = "|cffaaf200включен|r"
		-- else
		-- 	st = "выключен"
		-- end
		-- local count = 0;
		-- if Spells ~= {} then count = getn(Spells); end
		-- DEFAULT_CHAT_FRAME:AddMessage("|cffff6600SpellCritTip загружен ("..count..") и |r"..st.."|cffff6600 (/spc).|r")
	end
	
	if string.find(event, "PLAYER_UNGHOST") then
		UpdateSpellTipBase();
		playerItemsStr = getPlayerItemsID();
	end

	if string.find(event, "PLAYER_ENTERING_WORLD") then
		UpdateSpellTipBase();
		playerItemsStr = getPlayerItemsID();
	end

	if string.find(event, "UNIT_INVENTORY_CHANGED") then
		if playerItemsStr ~= getPlayerItemsID() then
			UpdateSpellTipBase();
		end
	end

	if string.find(event, "PLAYER_TALENT_UPDATE") then
		UpdateSpellTipBase(); 
	end
end

function ChatFrame_OnEvent_New()

	local function checkTooltip(arg1)
		if string.find(arg1, "(%d%.%d*)%%") then 
				return true
			else
				return false
			end
		end

	function checkTooltip2()
		local text = "";
		for i=1, GameTooltip:NumLines(), 1 do
			if getglobal("GameTooltipTextLeft"..i):IsVisible() and getglobal("GameTooltipTextLeft"..i):GetText() then 
				text=text..getglobal("GameTooltipTextLeft"..i):GetText();
			end
			if string.find(text,"Шанс критического удара:") then 
				return true;
			end
		end
		return false;
	end
	if event == "CHAT_MSG_SYSTEM" and checkTooltip(arg1) and (SPC_state) and (not checkTooltip2()) and (hookState) then --  
	 	 GetSpellCritChance(arg1);
	else
		ChatFrame_OnEvent_Old(event);
	end
end

function GetSpellCritChance(arg1)
	local function AddCritTipToBase(spellName, critChance)
		SpellTipsBase[spellName]["chance"] = critChance; 
	end	

	if (arg1) then
		for i = 1,getn(Spells),1 do
			if string.find(arg1, Spells[i]) then
				local _,_, critChance = string.find(arg1, "(%d*.%d*)%%");
-- SPC_Print ("Adding to Spells["..i.."] - "..Spells[i]..". Chance: "..critChance)
				AddCritTipToBase(Spells[i], critChance)
			end
		end
	end
end 

function SpellCritChance_SlashCommand(cmd)
	local cmd = string.lower(cmd);
	if  ( cmd == "on") and (not SPC_state)  then
		SPC_state = true;
		DEFAULT_CHAT_FRAME:AddMessage("|cffc7b26fSpellCritTip|r |cffaaf200включен.|r")
		elseif (cmd == "off") then
			SPC_state = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffc7b26fSpellCritTip|r |cffff6600выключен.|r")
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffc7b26fSpellCritTip:|r Используем команды /spc on/off для включения/выключения.")
	end
end

local f=CreateFrame("frame");
f:RegisterEvent("VARIABLES_LOADED");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("PLAYER_TALENT_UPDATE");
f:RegisterEvent("CHAT_MSG_SYSTEM");
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_UNGHOST")

SlashCmdList["SPC"] = SpellCritChance_SlashCommand;
SLASH_SPC1 = "/spc";

f:SetScript("OnEvent",spellCrit_OnEvent)
f:SetScript("OnUpdate",spellCrit_OnUpdate)

function InitializeSpells()
	if class == "MAGE" then
		Spells = {"Arcane Explosion", "Arcane Missiles", "Blast Wave", "Blizzard", "Cone of Cold", "Fire Blast", "Fireball", "Flamestrike", "Frost Nova", "Frostbolt",  "Pyroblast", "Scorch"};
	elseif class == "PRIEST" then
		Spells = {"Mind Blast", "Smite", "Holy Fire", "Touch of Weakness", "Flash Heal", "Greater Heal", "Heal", "Lesser Heal", "Prayer of Healing", "Mana Burn"};
	elseif class == "WARLOCK" then
		Spells = {"Shadow Bolt", "Immolate", "Searing Pain", "Shadowburn", "Conflagrate", "Soul Fire"};
	end
end

function InitializeSpellTipBase()

	local _, class = UnitClass("player");

		if class == "MAGE" then
			Spells = {"Arcane Explosion", "Arcane Missiles", "Blast Wave", "Blizzard", "Cone of Cold", "Fire Blast", "Fireball", "Flamestrike", "Frost Nova", "Frostbolt",  "Pyroblast", "Scorch"};
		elseif class == "PRIEST" then
			Spells = {"Mind Blast", "Smite", "Holy Fire", "Touch of Weakness", "Flash Heal", "Greater Heal", "Heal", "Lesser Heal", "Prayer of Healing", "Mana Burn"};
		elseif class == "WARLOCK" then
			Spells = {"Shadow Bolt", "Immolate", "Searing Pain", "Shadowburn", "Conflagrate", "Soul Fire"};
		end

		for i = 1,getn(Spells),1 do
			SpellTipsBase[Spells[i]] = {};
		end


	if class == "MAGE" then
		SpellTipsBase["Arcane Explosion"]["id"] = 1449;
		SpellTipsBase["Arcane Missiles"]["id"] = 5143;
		SpellTipsBase["Blast Wave"]["id"] = 11113;
		SpellTipsBase["Blizzard"]["id"] = 10;
		SpellTipsBase["Cone of Cold"]["id"] = 120;
		SpellTipsBase["Fire Blast"]["id"] = 2136;
		SpellTipsBase["Fireball"]["id"] = 133;
		SpellTipsBase["Flamestrike"]["id"] = 2120;
		SpellTipsBase["Frost Nova"]["id"] = 122;
		SpellTipsBase["Frostbolt"]["id"] = 116;
		SpellTipsBase["Pyroblast"]["id"] = 11366;
		SpellTipsBase["Scorch"]["id"] = 2948;
	end

	if class == "PRIEST" then 
		SpellTipsBase["Mind Blast"]["id"] = 8092;
		SpellTipsBase["Smite"]["id"] = 585;
		SpellTipsBase["Holy Fire"]["id"] = 14914;
		SpellTipsBase["Touch of Weakness"]["id"] = 2652;
		SpellTipsBase["Flash Heal"]["id"] = 2061;
		SpellTipsBase["Greater Heal"]["id"] = 2060;
		SpellTipsBase["Heal"]["id"] = 2054;
		SpellTipsBase["Lesser Heal"]["id"] = 2050;
		SpellTipsBase["Prayer of Healing"]["id"] = 596;
		SpellTipsBase["Mana Burn"]["id"] = 8129;
	end

	if class == "WARLOCK" then
		SpellTipsBase["Shadow Bolt"]["id"] = 686;
		SpellTipsBase["Immolate"]["id"] = 348;
		SpellTipsBase["Searing Pain"]["id"] = 5676;
		SpellTipsBase["Shadowburn"]["id"] = 17877;
		SpellTipsBase["Conflagrate"]["id"] = 17962;
		SpellTipsBase["Soul Fire"]["id"] = 6353;
	end
end;

function UpdateSpellTipBase()
	if UnitIsDeadOrGhost("player") ~= 1 then

		timer = 0;
		hookState = false;
		stopUpdate = false;
		DBid = 1;

		hookState = true;
	end
end

function SPC_Print(str)
	if ( DEFAULT_CHAT_FRAME ) then 
		ChatFrame1:AddMessage("SPC DEBUG: "..str, 1.0, 0.5, 0.25);
	end
end

function SPC_ShowDB()
	for i = 1,getn(Spells),1 do
		ChatFrame1:AddMessage("SPC DEBUG: "..Spells[i]..": "..SpellTipsBase[Spells[i]]["chance"].."%", 1.0, 0.5, 0.25);
	end
end