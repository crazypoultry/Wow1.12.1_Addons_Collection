
local class = UnitClass("player");
local classSpells = GroupHeal_ClassSpells[class]; --shortcut to the spells of the current class

-----------------------------------------------------------------------------------
-- local variable table pointers for global tables
-----------------------------------------------------------------------------------

local STRINGS = GROUPHEAL_STRINGS;
local buttonEvents = GroupHeal.ButtonEvents;
local inRange = GroupHeal.InRange;
local spellInfo = GroupHeal.SpellInfo;
local rankByTarget = GroupHeal.RankByTarget;
local copyButtons = GroupHeal.CopyButtons;
local targetButtons = GroupHeal.TargetButtons;
local healButtons = GroupHeal.HealButtons;
local selfHealButtons = GroupHeal.SelfHealButtons;
local spellUpdateFunctions = GroupHeal.SpellUpdateFunctions;

local classSpells = GroupHeal_ClassSpells[class]

-----------------------------------------------------------------------------------


local disabled = false;
RaidHeal_Mode = "None";  --indicates what Raid UI we are using
RaidHeal_Modes = { CT_Raid = "CT_RaidAssist";
                   Perl = "Perl";
                   DefaultUI = "Blizzard_RaidUI";
                 };

BINDING_HEADER_RAIDHEAL_BIGHEAL = "Raid Heal - ";
BINDING_HEADER_RAIDHEAL_FASTHEAL = "Raid Heal - ";
BINDING_HEADER_RAIDHEAL_OVERTIMEHEAL = "Raid Heal - ";
BINDING_HEADER_RAIDHEAL_SHIELD = "Raid Heal - ";

BINDING_NAME_RAIDHEAL_MT1_BIGHEAL = "Heal Main Tank 1";
BINDING_NAME_RAIDHEAL_MT2_BIGHEAL = "Heal Main Tank 2";
BINDING_NAME_RAIDHEAL_MT3_BIGHEAL = "Heal Main Tank 3";
BINDING_NAME_RAIDHEAL_MT4_BIGHEAL = "Heal Main Tank 4";
BINDING_NAME_RAIDHEAL_MT5_BIGHEAL = "Heal Main Tank 5";

BINDING_NAME_RAIDHEAL_MT1_FASTHEAL = "Heal Main Tank 1";
BINDING_NAME_RAIDHEAL_MT2_FASTHEAL = "Heal Main Tank 2";
BINDING_NAME_RAIDHEAL_MT3_FASTHEAL = "Heal Main Tank 3";
BINDING_NAME_RAIDHEAL_MT4_FASTHEAL = "Heal Main Tank 4";
BINDING_NAME_RAIDHEAL_MT5_FASTHEAL = "Heal Main Tank 5";

BINDING_NAME_RAIDHEAL_MT1_OVERTIMEHEAL = "Heal Main Tank 1";
BINDING_NAME_RAIDHEAL_MT2_OVERTIMEHEAL = "Heal Main Tank 2";
BINDING_NAME_RAIDHEAL_MT3_OVERTIMEHEAL = "Heal Main Tank 3";
BINDING_NAME_RAIDHEAL_MT4_OVERTIMEHEAL = "Heal Main Tank 4";
BINDING_NAME_RAIDHEAL_MT5_OVERTIMEHEAL = "Heal Main Tank 5";

BINDING_NAME_RAIDHEAL_MT1_SHIELD = "Shield Main Tank 1";
BINDING_NAME_RAIDHEAL_MT2_SHIELD = "Shield Main Tank 2";
BINDING_NAME_RAIDHEAL_MT3_SHIELD = "Shield Main Tank 3";
BINDING_NAME_RAIDHEAL_MT4_SHIELD = "Shield Main Tank 4";
BINDING_NAME_RAIDHEAL_MT5_SHIELD = "Shield Main Tank 5";


RaidHeal_Defaults = { ['enabled'] = true,
                      
                      ["positions"] = { "LEFTTOP", "NONE", "NONE" },
                      
                      ["xOffset"] = 0,
                      ["yOffset"] = 0,
                      ["spacing"] = 0,
                      
                      ['raidToSay'] = false,
                      ['raidToParty'] = false,
                      ['setMode'] = nil,
                    };
RaidHeal_Settings = RaidHeal_Defaults;

RaidHeal_Positions = {};

local parents = {};
local buttonRegister = {};
for i = 1, GROUPHEAL_MAX_SPELLS do
	if ( classSpells[i] ) then
		buttonRegister[i] = {};
		RaidHeal_Positions[i] = { ['pos'] = "LEFT", ['relPos'] = "RIGHT", ['xOffset'] = 0, ['yOffset'] = 0 };
	end
end

local function canBeEnabled()
	if class and GroupHeal_ClassSpells[class] and ( spellInfo[1] or spellInfo[2] and spellInfo[3] ) then
		return true;
	end
	
	return false;
end

local function PrintMsg(msg)
	if msg then
		DEFAULT_CHAT_FRAME:AddMessage("RaidHeal: "..msg);
	end
end 

local function GetUnit(button)
	if ( RaidHeal_Mode == "DefaultUI" ) then
		return button.unit;
	elseif ( RaidHeal_Mode == "CT_Raid" ) then
		return "raid"..button:GetID();
	elseif ( RaidHeal_Mode == "Perl" ) then
		return "raid"..button:GetID();
	else
		return "raid1";
	end
end

function RaidHeal_ShowButtons() 
	if ( RaidHeal_Mode == "DefaultUI" ) then
		for k, v in parents do
			if ( v["parent"]:IsVisible() ) then
				for i = 1, v["numButtons"] do
					if ( v[i]:IsVisible() ) then
						local unit = GetUnit(v[i]);
						for key, value in buttonRegister do
							value[unit]:SetParent(v[i]);
							RaidHeal_SetButtonPosition(value[unit])
						end
					end
				end
			end
		end
	end
end

function RaidHeal_OnLoad()

	if not classSpells then
		disabled = true;
		this:Hide();
		return;
	end
	
	--setup binding names
	local HealNames = { "Big Heal", "Fast Heal", "Over Time Heal", "Shield" };
	if classSpells then 
		for k, v in classSpells do
			HealNames[k] = "Cast "..v['name']
		end
	end
	BINDING_HEADER_RAIDHEAL_BIGHEAL = BINDING_HEADER_RAIDHEAL_BIGHEAL..HealNames[1];
	BINDING_HEADER_RAIDHEAL_FASTHEAL = BINDING_HEADER_RAIDHEAL_FASTHEAL..HealNames[2];
	BINDING_HEADER_RAIDHEAL_OVERTIMEHEAL = BINDING_HEADER_RAIDHEAL_OVERTIMEHEAL..HealNames[3];
	BINDING_HEADER_RAIDHEAL_SHIELD = BINDING_HEADER_RAIDHEAL_SHIELD..HealNames[4];
	
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("ADDON_LOADED");
	
	--Slash Command
	SLASH_RAIDHEAL1 = "/raidheal";
	SlashCmdList["RAIDHEAL"] = RaidHeal_SlashCommands;
	
	if LoadAddOn("CT_RaidAssist") then
		RaidHeal_Mode = "CT_Raid";
	elseif LoadAddOn("Perl") then
		RaidHeal_Mode = "Perl";
	else
		local enabled, reason = UIParentLoadAddOn("Blizzard_RaidUI");
		if enabled then
			RaidHeal_Mode = "DefaultUI";
		end
	end
	
	RaidHeal_DefineParentAddOnMode();
end

function RaidHeal_ParentOnShow()
	if ( this.RaidHeal_oldOnShow ~= nil ) then
		this.RaidHeal_oldOnShow();
	end
	local unit = GetUnit(this);
	for k, v in buttonRegister do
		v[unit]:SetParent(this);
		RaidHeal_SetButtonPosition(v[unit]);
		if RaidHeal_Settings["positions"][k] ~= "NONE" then
			v[unit]:Show();
		end
	end
end

function RaidHeal_ChangeMode( mode )
	if ( RaidHeal_Modes[mode] ) then
		local enabled, reason = UIParentLoadAddOn(RaidHeal_Modes[mode]);
		if ( enabled ) then
			RaidHeal_Mode = mode;
			RaidHeal_Settings.setMode = mode;
			RaidHeal_DefineParentAddOnMode();
			for i = 1, GROUPHEAL_MAX_SPELLS do
				RaidHeal_SetSpellButtonPositions(i);
			end
		end
	else
		PrintMsg("Unable to initiate "..mode.." mode because the selected mode is invalid.");
	end
end
		
	

function RaidHeal_DefineParentAddOnMode()
	if RaidHeal_Mode == "CT_Raid" and IsAddOnLoaded("CT_RaidAssist") then
		for i = 1, MAX_RAID_MEMBERS do
			parent = getglobal("CT_RAMember"..i);
			for k, v in buttonRegister do
				v["raid"..i]:SetParent(parent);
			end
		end
	
	elseif RaidHeal_Mode == "Perl" and IsAddOnLoaded("Perl") then
		for i = 1, MAX_RAID_MEMBERS do
			parent = getglobal("Perl_Raid"..i);
			for k, v in buttonRegister do
				v["raid"..i]:SetParent(parent);
			end
		end
	
	elseif RaidHeal_Mode == "DefaultUI" and LoadAddOn("Blizzard_RaidUI") then
		for i = 1, MAX_RAID_PULLOUT_FRAMES do
			parents[i] = {}
			parents[i]["numButtons"] = MAX_RAID_PULLOUT_BUTTONS;
			parents[i]["parent"] = getglobal("RaidPullout"..i);
			for x = 1, parents[i]["numButtons"] do
				parents[i][x] = getglobal("RaidPullout"..i.."Button"..x);
				parents[i][x].RaidHeal_oldOnShow = parents[i][x]:GetScript("OnShow");
				parents[i][x]:SetScript("OnShow", RaidHeal_ParentOnShow)
			end
		end
	
	else
		PrintMsg("Unable to initiate "..RaidHeal_Mode.." mode because either the mode is invalid or a dependency is missing.");
	end
end

function RaidHeal_HealButton_OnLoad()
	if ( classSpells[this.spellId] ) then
		buttonRegister[this.spellId][this.target] = this;
	end
end

function RaidHeal_OnUpdate(elapsed)

end

function RaidHeal_VariablesLoaded()
	
	-- remove old settings
	for k, v in RaidHeal_Defaults do
		if ( RaidHeal_Settings[k] == nil ) then
			RaidHeal_Settings[k] = v;
		end
	end
	
	-- convert old settings
	if ( RaidHeal_Settings['bigHeal'] ~= nil ) then
		if RaidHeal_Settings['bigHeal'] then
			RaidHeal_Settings["positions"][1] = "LEFTTOP";
		else
			RaidHeal_Settings["positions"][1] = "NONE";
		end
		RaidHeal_Settings['bigHeal'] = nil;
	end
	if ( RaidHeal_Settings['fastHeal'] ~= nil ) then
		if RaidHeal_Settings['fastHeal'] then
			RaidHeal_Settings["positions"][2] = "LEFTBOTTOM";
		else
			RaidHeal_Settings["positions"][2] = "NONE";
		end
		RaidHeal_Settings['fastHeal'] = nil;
	end
	
	for i = 1, GROUPHEAL_MAX_SPELLS do
		if ( not RaidHeal_Settings.positions[i] ) then
			RaidHeal_Settings.positions[i] = "NONE";
		end
	end
	
	if UnitExists("player") then
		RaidHeal_OnEvent("PLAYER_LOGIN");
	end
	
	if ( RaidHeal_Settings.setMode ) then
		RaidHeal_ChangeMode( RaidHeal_Settings.setMode );
	end
end


function RaidHeal_OnEvent(event)
	if ( event == "SPELLS_CHANGED" )  then
		RaidHeal_ShowButtons();
	
	elseif ( event == "PLAYER_LOGIN" )  then
		RaidHeal_PlayerEnteringWorld();
	
	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		RaidHeal_ShowButtons();
	
	elseif ( event == "ADDON_LOADED" ) then
		if ( arg1 == "RaidHeal" ) then
			RaidHeal_VariablesLoaded();
		end
	
	else
		PrintMsg(event);
	end
end

function RaidHeal_PlayerEnteringWorld() 
	for i = 1, GROUPHEAL_MAX_SPELLS do
		RaidHeal_SetSpellButtonPositions(i);
	end
	RaidHeal_ShowButtons();
end

function RaidHeal_SlashCommands(msg)
	local command_index,command_index_end, command, params= strfind(msg,'(%w*) *(.*)')
	local args = {};
	local i = 1;
	while (strlen(params) > 0) do
		command_index,command_index_end, nextParam, params= strfind(params,'(%w*) *(.*)')
		args[i] = nextParam;
		i = i + 1;
		if (i >= 10) then return; end;
	end

	command = strlower(command);
	
	if command == "" then
		ShowUIPanel(RaidHealConfigFrame);
	
	elseif command == "healmt" then
		local MT = 1;
		if args[1] then
			MT = tonumber(args[1]);
		end
		RaidHeal_HealMainTank(MT);
	
	elseif command == "bigheal" then
		p = strlower(args[1]);
		if p == "on" then
			RaidHeal_Settings['bigHeal'] = true;
		elseif p == "off" then
			RaidHeal_Settings['bigHeal'] = false;
		else
			RaidHeal_Settings['bigHeal'] = not RaidHeal_Settings['bigHeal'];
		end
		if RaidHeal_Settings['bigHeal'] then
			PrintMsg("Showing Big Heal button.");
		else
			PrintMsg("Hiding Big Heal button.");
		end
		RaidHeal_ShowButtons();
	
	elseif command == "fastheal" then
		p = strlower(args[1]);
		if p == "on" then
			RaidHeal_Settings['fastHeal'] = true;
		elseif p == "off" then
			RaidHeal_Settings['fastHeal'] = false;
		else
			RaidHeal_Settings['fastHeal'] = not RaidHeal_Settings['fastHeal'];
		end
		if RaidHeal_Settings['bigHeal'] then
			PrintMsg("Showing Fast Heal button.");
		else
			PrintMsg("Hiding Fast Heal button.");
		end
		RaidHeal_ShowButtons();
	end
	
end


function RaidHeal_HealMainTank(MT, spellId)
	if disabled then return; end
	
	unit = nil;
	if not spellId then
		spellId = 1;
	end
	
	if ( RaidHeal_Mode == "CT_Raid" and CT_RA_MainTanks[MT] ) then
		for x=1, 40, 1 do 
			if UnitName('raid'..x) == CT_RA_MainTanks[MT] then 
				unit = "raid"..x
				break;
			end
		end
		--PrintMsg("Casting Heal on MT "..MT);
	
	elseif ( RaidHeal_Mode == "Perl" ) then
		--current setup of Perl Unit Frames does not allow this :(
		
	end
	
	if unit then
		GroupHeal_CastSpell(unit, spellId);
	end
end

function RaidHeal_SetButtonPosition(button)
	button:ClearAllPoints();
	button:SetPoint( RaidHeal_Positions[button.spellId].pos, button:GetParent(), RaidHeal_Positions[button.spellId].relPos, RaidHeal_Positions[button.spellId].xOffset, RaidHeal_Positions[button.spellId].yOffset );
end

function RaidHeal_ShowHideButtons( spellId, show )
	if ( show and spellInfo[spellId][1] ) then
		for k, v in buttonRegister[spellId] do
			v:Show();
		end
	else
		for k, v in buttonRegister[spellId] do
			v:Hide();
		end
	end
end

--re-anchors the buttons for a particlar spell, setting the parent, changing the anchor positions
--and adjusting the x, y placement
function RaidHeal_SetSpellButtonPositions( spellId )
	if not ( classSpells[spellId] ) then return end;
	
	local pos = "TOPRIGHT";
	local relpos = "TOPLEFT";
	
	local position = RaidHeal_Settings["positions"][spellId];
	if ( position == "NONE" ) then
		RaidHeal_ShowHideButtons( spellId, false );
		return;
	
	elseif ( strsub(position, 1, 4) == "LEFT" ) then
		local tb = strsub(position, 5);
		if ( tb == "TOP" ) then
			tb = "BOTTOM";
		else
			tb = "TOP";
		end
		pos = tb.."RIGHT";
		relpos = "LEFT";
	
	elseif ( strsub(position, 1, 5) == "RIGHT" ) then
		local tb = strsub(position, 6);
		if ( tb == "TOP" ) then
			tb = "BOTTOM";
		else
			tb = "TOP";
		end
		pos = tb.."LEFT";
		relpos = "RIGHT";
	
	end
	
	
	RaidHeal_Positions[spellId].pos = pos;
	RaidHeal_Positions[spellId].relPos = relpos;
	RaidHeal_ParseSpellButtonPlacements(spellId);
	
	for k, v in buttonRegister[spellId] do
		RaidHeal_SetButtonPosition(v);
	end
	
	RaidHeal_ShowHideButtons(spellId, true);
end

function RaidHeal_ParseSpellButtonPlacements( spellId )
	local yOffset = RaidHeal_Settings.spacing;
	if ( strsub(RaidHeal_Positions[spellId].pos, 1, 3 ) == "TOP" ) then
		yOffset = -yOffset;
	end
	
	local xOffset = RaidHeal_Settings.xOffset;
	if ( strsub(RaidHeal_Settings["positions"][spellId], 1, 4) == "LEFT" ) then
		xOffset = -xOffset;
	end
	
	RaidHeal_Positions[spellId].xOffset = xOffset;
	RaidHeal_Positions[spellId].yOffset = (yOffset/2) + RaidHeal_Settings["yOffset"];
end

--adjusts spacing and x,y placement for ALL buttons
--does not change parents, or the current anchor
--buttons for spells with a current position of "NONE" are skipped
function RaidHeal_AdjustSpellButtonPlacement()
	for spellId = 1, GROUPHEAL_MAX_SPELLS do
		if ( RaidHeal_Settings["positions"][spellId] ~= "NONE" ) then
			RaidHeal_ParseSpellButtonPlacements(spellId);
			for k, v in buttonRegister[spellId] do
				RaidHeal_SetButtonPosition(v);
			end
		end
	end
end
