----------------------
-- Loading Function --
----------------------

function PRD_Event()
	Perl_Raid_Distance:UnregisterEvent("VARIABLES_LOADED");
	PRD_Init();
	PRD_Event = PRD_EventHandler;
end

function PRD_Init()

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Perl Classic: Raid_Distance loaded successfully. (3rd party)");
	end
	
	-- Load saved config, if exists
	PRD_LoadConfig();

	-- Define spells to use
	PRD_SelectSpell();
	
	if (PRD_Running["Enable"] == 1) then PRD_Enable(); end
	
end

----------------------
-- Saved variables --
----------------------
function PRD_LoadConfig()

	if ( PRD_Config["Yards"] == nil ) then
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Default config"); end
	else
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Loaded personal config"); end
		
		PRD_Running["Enable"]			= PRD_Config["Enable"];
		PRD_Running["Yards"]			= PRD_Config["Yards"];
		PRD_Running["RetriveMethod"]	= PRD_Config["RetriveMethod"];
		PRD_Running["DisplayMethod"]	= PRD_Config["DisplayMethod"];

		PRD_Running["Alpha"] = {
			["Range"]	= PRD_Config["Alpha"]["Range"],
			["Offline"]	= PRD_Config["Alpha"]["Offline"],
			["Dead"]	= PRD_Config["Alpha"]["Dead"]
		};

		PRD_Running["AwayBorderColor"] = {
			PRD_Config["AwayBorderColor"][1],
			PRD_Config["AwayBorderColor"][2],
			PRD_Config["AwayBorderColor"][3]
		};
		
		PRD_Running["CloseBorderColor"] = {
			PRD_Config["CloseBorderColor"][1],
			PRD_Config["CloseBorderColor"][2],
			PRD_Config["CloseBorderColor"][3]
		};
		
		PRD_Running["DefaultBorderColor"] = {
			PRD_Config["DefaultBorderColor"][1],
			PRD_Config["DefaultBorderColor"][2],
			PRD_Config["DefaultBorderColor"][3]
		};
	
	end
	
	PRD_UpdateMethouds();
	PRD_UpdateGUI();
	
end


function PRD_SaveConfig()

	if (PRD_State == -1) then return end;

	if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Saving personal config"); end
	PRD_Config["Enable"]		= PRD_Running["Enable"];
	PRD_Config["Yards"]			= PRD_Running["Yards"];
	PRD_Config["RetriveMethod"]	= PRD_Running["RetriveMethod"];
	PRD_Config["DisplayMethod"]	= PRD_Running["DisplayMethod"];

	PRD_Config["Alpha"] = {
		["Range"]	= PRD_Running["Alpha"]["Range"],
		["Offline"]	= PRD_Running["Alpha"]["Offline"],
		["Dead"]	= PRD_Running["Alpha"]["Dead"]
	};

	PRD_Config["AwayBorderColor"] = {
		PRD_Running["AwayBorderColor"][1],
		PRD_Running["AwayBorderColor"][2],
		PRD_Running["AwayBorderColor"][3]
	};
	
	PRD_Config["CloseBorderColor"] = {
		PRD_Running["CloseBorderColor"][1],
		PRD_Running["CloseBorderColor"][2],
		PRD_Running["CloseBorderColor"][3]
	};
	
	PRD_Config["DefaultBorderColor"] = {
		PRD_Running["DefaultBorderColor"][1],
		PRD_Running["DefaultBorderColor"][2],
		PRD_Running["DefaultBorderColor"][3]
	};
	
	if (PRD_Debug) then PRD_DisplayConfig(); end
	
	PRD_UpdateMethouds();
	PRD_UpdateGUI();
	
end


function PRD_DisplayConfig()
	DEFAULT_CHAT_FRAME:AddMessage("--------------------");
	DEFAULT_CHAT_FRAME:AddMessage("Enabled: |cffffff00"..PRD_Config["Enable"]);
	DEFAULT_CHAT_FRAME:AddMessage("Yards: |cffffff00"..PRD_Config["Yards"]);
	DEFAULT_CHAT_FRAME:AddMessage("RetrMeth: |cffffff00"..PRD_Config["RetriveMethod"]);
	DEFAULT_CHAT_FRAME:AddMessage("DispMeth: |cffffff00"..PRD_Config["DisplayMethod"]);
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	DEFAULT_CHAT_FRAME:AddMessage("Alpha Ra: |cffffff00"..PRD_Config["Alpha"]["Range"]);
	DEFAULT_CHAT_FRAME:AddMessage("Alpha Of: |cffffff00"..PRD_Config["Alpha"]["Offline"]);
	DEFAULT_CHAT_FRAME:AddMessage("Alpha De: |cffffff00"..PRD_Config["Alpha"]["Dead"]);
	DEFAULT_CHAT_FRAME:AddMessage(" ");
	DEFAULT_CHAT_FRAME:AddMessage("Color AB: |cffffff00"..PRD_ReturnColor(PRD_Config["AwayBorderColor"]));
	DEFAULT_CHAT_FRAME:AddMessage("Color CB: |cffffff00"..PRD_ReturnColor(PRD_Config["CloseBorderColor"]));
	DEFAULT_CHAT_FRAME:AddMessage("Color DB: |cffffff00"..PRD_ReturnColor(PRD_Config["DefaultBorderColor"]));
	DEFAULT_CHAT_FRAME:AddMessage("--------------------");
end

function PRD_ReturnBool(v)
	if (v) then return "Yes"; else return "No"; end
end

function PRD_ReturnColor(tab)
	return "["..tab[1]..", "..tab[2]..", "..tab[3].."]";
end

-------------------------
-- Dummy functions --
-------------------------
function PRD_CreateGUI() end;
function PRD_UpdateGUI() end;

----------------------
-- Select spell to use --
----------------------
function PRD_SelectSpell()

	local _, englishClass = UnitClass("player");
	PRD_CurrentSpell = PRD_Spells[PRD_Running["Yards"]][englishClass];
	
	if ( PRD_CurrentSpell ~= nil ) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Spell selected: "..PRD_CurrentSpell);
	else
		PRD_Retrive = PRD_RetriveMethod_2;
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00No spell selected, using InteractDistance.");
	end
	
end


----------------------
-- Event Function --
----------------------
function PRD_Enable()

	-- Raid related
	Perl_Raid_Distance:RegisterEvent("PARTY_MEMBERS_CHANGED");
	Perl_Raid_Distance:RegisterEvent("RAID_ROSTER_UPDATE");
	Perl_Raid_Distance:RegisterEvent("PLAYER_ALIVE");
	Perl_Raid_Distance:RegisterEvent("PLAYER_ENTERING_WORLD");
	
	-- Casting related
	Perl_Raid_Distance:RegisterEvent("SPELLCAST_START");
	Perl_Raid_Distance:RegisterEvent("SPELLCAST_STOP");
	Perl_Raid_Distance:RegisterEvent("SPELLCAST_CHANNEL_START");
	Perl_Raid_Distance:RegisterEvent("SPELLCAST_CHANNEL_STOP");
	Perl_Raid_Distance:RegisterEvent("SPELLCAST_FAILED");
	Perl_Raid_Distance:RegisterEvent("SPELLCAST_INTERRUPTED");
	
	-- Mounts
	Perl_Raid_Distance:RegisterEvent("PLAYER_AURAS_CHANGED");
	
	-- Normal status
	PRD_State = 1;
end

function PRD_Disable()

	-- Raid related
	Perl_Raid_Distance:UnregisterEvent("PARTY_MEMBERS_CHANGED");
	Perl_Raid_Distance:UnregisterEvent("RAID_ROSTER_UPDATE");
	Perl_Raid_Distance:UnregisterEvent("PLAYER_DEAD");
	Perl_Raid_Distance:UnregisterEvent("PLAYER_ENTERING_WORLD");
	
	-- Casting related
	Perl_Raid_Distance:UnregisterEvent("SPELLCAST_START");
	Perl_Raid_Distance:UnregisterEvent("SPELLCAST_STOP");
	Perl_Raid_Distance:UnregisterEvent("SPELLCAST_CHANNEL_START");
	Perl_Raid_Distance:UnregisterEvent("SPELLCAST_CHANNEL_STOP");
	Perl_Raid_Distance:UnregisterEvent("SPELLCAST_FAILED");
	Perl_Raid_Distance:UnregisterEvent("SPELLCAST_INTERRUPTED");
	
	-- Mounts
	Perl_Raid_Distance:UnregisterEvent("PLAYER_AURAS_CHANGED");
	
	-- Disabled status
	PRD_State = -1;
end

function PRD_EventHandler()

	if ( event == "PLAYER_DEAD" ) then
		PRD_State = 2;
		
	elseif ( event == "PLAYER_ALIVE" and PRD_State == 2 ) then
		PRD_State = 1;
		PRD_Reset();
		
	elseif ( event == "PLAYER_AURAS_CHANGED" ) then
		PRD_CheckMount();

	elseif ( event == "SPELLCAST_START" or event == "SPELLCAST_CHANNEL_START" ) then
	
		-- Save spell name, could be a mount?
		if ( event == "SPELLCAST_START" ) then
			PRD_LastSpell = arg1;
		else
			PRD_LastSpell = arg2;
		end
		
		if (PRD_State == 1) then
			PRD_State = 3;
			if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Event: |cffffff00 Casting..."); end
		end
		
	elseif ( event == "SPELLCAST_STOP" or event == "SPELLCAST_CHANNEL_STOP" or event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" ) then
		if (PRD_State == 3) then
			PRD_State = 1;
			if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Event: |cffffff00 Stoped casting!"); end
		end
		
	else
		PRD_Reset();

	end
	
end


function PRD_UpdateMethouds()
	
	PRD_Retrive = getglobal("PRD_RetriveMethod_"..PRD_Running["RetriveMethod"]);
	PRD_Display = getglobal("PRD_DisplayMethod_"..PRD_Running["DisplayMethod"]);

end

function PRD_CheckMount()
	if ( PRD_IsMounted() ) then
		PRD_State = 4;
	elseif ( PRD_State == 4 ) then
		PRD_State = 1;
	end
end

function PRD_IsMounted()

	for i = 1, 24 do
		buff = UnitBuff("player", i);
		
		if ( buff == nil ) then
			if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Not mounted, out of buffs(1)"); end
			return false;
		end;
		
		-- Some buff icons are both mounts and other buffs
		if ( PRD_MabyMounts[buff] ~= nil or string.find(buff,"QirajiCrystal_") ) then
			
			if (	string.find(PRD_LastSpell, "saber") ~= nil			-- NE mounts
				or	string.find(PRD_LastSpell, "Battle Tank") ~= nil	-- AQ40 mounts
				) then
				if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Mounted(1)"); end
				return true;
			else
				if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("NOT Mounted(1)"); end
			end
		
		-- Search for Mount_ in icon url
		elseif string.find(buff,"Mount_") then
			if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Mounted(2)"); end
			return true;
		end
	end
	
	if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Not mounted, out of buffs(2)"); end
	return false;
	
end


----------------------
-- Main function --
----------------------
function PRD_RetriveMethod_1()

	-- This function can't work if your allready casting
	-- dead, or mounted
	if (PRD_State ~= 1) then return end;
	
	if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("SpellCheck:"); DEFAULT_CHAT_FRAME:AddMessage("-----------------"); end
	
	local clearSpell;

	ClearTarget();
	
	if ( SpellIsTargeting() ) then
		clearSpell = false;
	else
		CastSpellByName(PRD_CurrentSpell);
		clearSpell = true;
	end
	
	-- If error, only display one
	if (SpellCanTargetUnit("player")) then
		for i = 1, 40, 1 do
			local unitid = "raid"..i;
			if (UnitExists(unitid)) then
			
				if (UnitIsDead(unitid) or UnitIsGhost(unitid)) then
					PRD_Display(i, 3);
				elseif (UnitIsConnected(unitid) == nil) then
					PRD_Display(i, 4);
				else
					if (not SpellCanTargetUnit(unitid)) then
						PRD_Display(i, 2);
					else
						PRD_Display(i, 1);
					end
				end
			end
		end
	end
	
	if ( clearSpell ) then
		SpellStopTargeting();
	end
	
	TargetUnit("playertarget");
	
end

function PRD_RetriveMethod_2()
	if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("InteractCheck:"); DEFAULT_CHAT_FRAME:AddMessage("-----------------"); end
	if (CheckInteractDistance("player", 4)) then
		for i = 1, 40, 1 do
			local unitid = "raid"..i;
			if (UnitExists(unitid)) then
			
				if (UnitIsDead(unitid) or UnitIsGhost(unitid)) then
					PRD_Display(i, 3);
				elseif (UnitIsConnected(unitid) == nil) then
					PRD_Display(i, 4);
				else
					if (not CheckInteractDistance(unitid, 4)) then
						PRD_Display(i, 2);
					else
						PRD_Display(i, 1);
					end
				end
			end
		end
	end
end

function PRD_RetriveMethod_3()
	if (PRD_State == 1) then
		PRD_RetriveMethod_1();
	else
		PRD_RetriveMethod_2();
	end;
end

function PRD_DisplayMethod_1(id, status)
	--if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage(UnitName(id)..":"); end
	if ( status == 1 or status == 1 ) then
		-- normal
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetAlpha(1);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Fast Normal"); end
	elseif ( status == 2 ) then
		-- Out of range
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetAlpha(PRD_Running["Alpha"]["Range"]);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Fast Out of range"); end
	elseif ( status == 3 ) then
		-- Dead
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetAlpha(PRD_Running["Alpha"]["Dead"]);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Fast Dead"); end
	elseif ( status == 4 ) then
		-- Offline
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetAlpha(PRD_Running["Alpha"]["Offline"]);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Fast Offline"); end
	end
	
end

-- 1, Alpha only   2, Alpha + CloseBorder   3, Alpha + AwayBorder,    4, Alpha + Close&Away-border
function PRD_DisplayMethod_2(id, status)

	--getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetAlpha(1);
	
	--if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage(UnitName(id)..":"); end
	if ( status == 0 ) then
		-- reset
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBar"):SetAlpha(1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBarBG"):SetAlpha(1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBar"):SetAlpha(1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBarBG"):SetAlpha(1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropBorderColor(0.3, 0.3, 0.3, 1);
		getglobal("Perl_Raid" .. id .. "_NameFrame"):SetBackdropBorderColor(0.3, 0.3, 0.3, 1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropColor(0, 0, 0, 1);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Slow Reset"); end
		
	elseif ( status == 1 ) then
		-- normal
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBar"):SetAlpha(1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBarBG"):SetAlpha(1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBar"):SetAlpha(1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBarBG"):SetAlpha(1);
		if (PRD_Running["DisplayMethod"] == 2 or PRD_Running["DisplayMethod"] == 4) then
			getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropBorderColor(PRD_Running["CloseBorderColor"][1], PRD_Running["CloseBorderColor"][2], PRD_Running["CloseBorderColor"][3], 1);
			getglobal("Perl_Raid" .. id .. "_NameFrame"):SetBackdropBorderColor(PRD_Running["CloseBorderColor"][1], PRD_Running["CloseBorderColor"][2], PRD_Running["CloseBorderColor"][3], 1);
		else
			getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropBorderColor(PRD_Running["DefaultBorderColor"][1], PRD_Running["DefaultBorderColor"][2], PRD_Running["DefaultBorderColor"][3], 1);
			getglobal("Perl_Raid" .. id .. "_NameFrame"):SetBackdropBorderColor(PRD_Running["DefaultBorderColor"][1], PRD_Running["DefaultBorderColor"][2], PRD_Running["DefaultBorderColor"][3], 1);
		end
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropColor(0, 0, 0, 1);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Slow Normal"); end
		
	elseif ( status == 2 ) then
		-- Out of range
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBar"):SetAlpha(PRD_Running["Alpha"]["Range"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBarBG"):SetAlpha(PRD_Running["Alpha"]["Range"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBar"):SetAlpha(PRD_Running["Alpha"]["Range"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBarBG"):SetAlpha(PRD_Running["Alpha"]["Range"]);
		if (PRD_Running["DisplayMethod"] == 3 or PRD_Running["DisplayMethod"] == 4) then
			getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropBorderColor(PRD_Running["AwayBorderColor"][1], PRD_Running["AwayBorderColor"][2], PRD_Running["AwayBorderColor"][3], 1);
			getglobal("Perl_Raid" .. id .. "_NameFrame"):SetBackdropBorderColor(PRD_Running["AwayBorderColor"][1], PRD_Running["AwayBorderColor"][2], PRD_Running["AwayBorderColor"][3], 1);
		else
			getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropBorderColor(PRD_Running["DefaultBorderColor"][1], PRD_Running["DefaultBorderColor"][2], PRD_Running["DefaultBorderColor"][3], 1);
			getglobal("Perl_Raid" .. id .. "_NameFrame"):SetBackdropBorderColor(PRD_Running["DefaultBorderColor"][1], PRD_Running["DefaultBorderColor"][2], PRD_Running["DefaultBorderColor"][3], 1);
		end
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropColor(0, 0, 0, 0);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Slow Out of Range"); end
		
	elseif ( status == 3 ) then
		-- Dead
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBar"):SetAlpha(PRD_Running["Alpha"]["Dead"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBarBG"):SetAlpha(PRD_Running["Alpha"]["Dead"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBar"):SetAlpha(PRD_Running["Alpha"]["Dead"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBarBG"):SetAlpha(PRD_Running["Alpha"]["Dead"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropBorderColor(0, 0, 0, 0);
		getglobal("Perl_Raid" .. id .. "_NameFrame"):SetBackdropBorderColor(PRD_Running["DefaultBorderColor"][1], PRD_Running["DefaultBorderColor"][2], PRD_Running["DefaultBorderColor"][3], 1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropColor(0, 0, 0, 0);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Slow Dead / Offline"); end
		
	elseif ( status == 4 ) then
		-- Offline
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBar"):SetAlpha(PRD_Running["Alpha"]["Offline"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_HealthBarBG"):SetAlpha(PRD_Running["Alpha"]["Offline"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBar"):SetAlpha(PRD_Running["Alpha"]["Offline"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame_ManaBarBG"):SetAlpha(PRD_Running["Alpha"]["Offline"]);
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropBorderColor(0, 0, 0, 0);
		getglobal("Perl_Raid" .. id .. "_NameFrame"):SetBackdropBorderColor(PRD_Running["DefaultBorderColor"][1], PRD_Running["DefaultBorderColor"][2], PRD_Running["DefaultBorderColor"][3], 1);
		getglobal("Perl_Raid" .. id .. "_StatsFrame"):SetBackdropColor(0, 0, 0, 0);
		if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Status: Slow Dead / Offline"); end
		
	end
end

function PRD_DisplayMethod_3(id, status)
	PRD_DisplayMethod_2(id, status);
end

function PRD_DisplayMethod_4(id, status)
	PRD_DisplayMethod_2(id, status);
end

----------------------
-- Reset alpha --
----------------------
function PRD_Reset()
	for i = 1, 40, 1 do
		local unitid = "raid"..i;
		if (UnitExists(unitid)) then
			if (UnitIsDead(unitid) or UnitIsGhost(unitid) or UnitIsConnected(unitid) == nil) then
				PRD_Display(i, 3);
			else
				PRD_Display(i, 0);
			end
		end
	end
	if (PRD_Debug) then DEFAULT_CHAT_FRAME:AddMessage("Reset distances"); end
end


----------------------
-- Add a Perl_Raid_Distance_Check infront of  Perl_Raid_MouseClick --
----------------------
Perl_Raid_MouseClick_Org = Perl_Raid_MouseClick;
function Perl_Raid_MouseClick(button)
	if (PRD_State ~= -1) then
		PRD_Retrive();
	end
	Perl_Raid_MouseClick_Org(button);
end
