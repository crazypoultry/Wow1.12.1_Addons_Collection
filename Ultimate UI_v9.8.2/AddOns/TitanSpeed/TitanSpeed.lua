--[[
	titanSpeed:
	A simple speedometer.
	
	Author: Trentin
	Resurrected by: Quel
	Altered for TitanPanel +general messing with the code by: tainted (aka "Baou" @ Magtherion, EU realm)
	Further altered by: Total Package 01/23/2006
--]]

TITAN_SPEED_MENU_TEXT = "TitanSpeed";
TITAN_SPEED_BUTTON_LABEL = "Speed: ";
TITAN_SPEED_ID = "Speed";
TITAN_SPEED_BUTTON_TEXT = "%s";
TITAN_SPEED_FREQUENCY= 0.5;
TITAN_SPEED_NSR = "Set new rate (while running 100%)";
TITAN_SPEED_RSR = "Reset all rates";

local TitanSpeedName = "TitanSpeed";
local TitanSpeedVersion = "1.9.0";

titanSpeed = {};
titanSpeed.m_iDeltaTime = 0;
titanSpeed.m_fSpeed = 0.0;
titanSpeed.m_fSpeedDist = 0.0;
titanSpeed.m_bLoaded = false;
titanSpeed.m_bVariablesLoaded = false;
titanSpeed.m_strPlayer = "";
titanSpeed.m_vCurrPos = {};
titanSpeed.m_setRate = false;
StaticPopupDialogs["TITANSPEED_RESET"] = {
	text = TEXT("Are you sure you want to reset all base-rates for TitanSpeed?"),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		TitanSpeed_Reset();
	end,
	timeout = 0,
	exclusive = 1
};

titanSpeedZoneBaseline2 = 
{ 
	{zid=1, rate=0.00375},	-- Alterac Mtns
	{zid=2, rate=0.0029167},	-- Arathi Highlands
	{zid=3, rate=0.0042},	-- Bad Lands
	{zid=4, rate=0.00313},	-- Blasted Lands
	{zid=5, rate=0.0035847},	-- Burning Steppes
	{zid=6, rate=0.00420},	-- Deadwind pass
	{zid=7, rate=0.0021319},	-- Dun Morogh
	{zid=8, rate=0.00388896},	-- Duskwood
	{zid=9, rate=0.00271},	-- Eastern Plaguelands
	{zid=10, rate=0.00302},	-- Elwynn Forest
	{zid=11, rate=0.00328},	-- Hillsbrad
	{zid=12, rate=0.013273},	-- Iron Forge
	{zid=13, rate=0.00381},	-- Loch Modan
	{zid=14, rate=0.00484},	-- Redridge Mnts
	{zid=15, rate=0.00471}, -- Searing Gorge
	{zid=16, rate=0.00250},	-- Rut'Theran Village might be 0.00209 or 0.00250
	{zid=17, rate=0.00781},	-- Stormwind
	{zid=18, rate=0.0016456},	-- Stranglethorn Vale
	{zid=19, rate=0.00458},	-- Swamp of Sorrows
	{zid=20, rate=0.00273},	-- Hinterlands
	{zid=21, rate=0.00232375},	-- Tristfall Glades
	{zid=22, rate=0.01094},	-- Undercity
	{zid=23, rate=0.00244},	-- Western Plaguelands
	{zid=24, rate=0.00300},	-- Westfall
	{zid=25, rate=0.002539}	-- Wetlands
};
titanSpeedZoneBaseline1 = 
{
	{zid=1, rate=0.00182097},	-- Ashenvale
	{zid=2, rate=0.00207},	-- Azshara
	{zid=3, rate=0.00160},	-- Darkshore
	{zid=4, rate=0.00992},	-- Darnassus
	{zid=5, rate=0.002335},	-- Desolace
	{zid=6, rate=0.00199},	-- Durotar
	{zid=7, rate=0.00200},	-- dustwallow marsh
	{zid=8, rate=0.00183},	-- felwood
	{zid=9, rate=0.00151},	-- feralas
	{zid=10, rate=0.00455},	-- Moonglade
	{zid=11, rate=0.00204},	-- Mulgore
	{zid=12, rate=0.00748},	-- Orgrimmar
	{zid=13, rate=0.0030135},	-- Silithus
	{zid=14, rate=0.00215},	-- Stonetalon Mtns
	{zid=15, rate=0.0015216},	-- Tanaris
	{zid=16, rate=0.00206},	-- Teldrassil
	{zid=17, rate=0.001036177},	-- The Barrens
	{zid=18, rate=0.00239},	-- Thousand Needles
	{zid=19, rate=0.01006},	-- Thunderbluff
	{zid=20, rate=0.00284},	-- Un'Goro Crater
	{zid=21, rate=0.00148},	-- Winterspring
	{zid=22, rate=0.0001},
	{zid=23, rate=0.0001},
	{zid=24, rate=0.0001},
	{zid=25, rate=0.0001}	
};	
titanSpeedOthers = 
{
	["Blackrock Mountain"] = {
		["rate"] = 0.0002983199214410154,
	},
	["Warsong Gulch"] = {
		["rate"] = 0.009159138767039199,
	},
	["Alterac Valley"] = {
		["rate"] = 0.002477872662261515,
	},
	["Arathi Basin"] = {
		["rate"] = 0.005978692329518227,
	},
};


function TitanSpeed_Init()		
	if ((titanSpeed.m_bLoaded == false) and (titanSpeed.m_bVariablesLoaded == true)) then		
		titanSpeed.m_strPlayer = GetCVar("realmName").."|"..titanSpeed.m_strPlayer;	
		if (not titanSpeedConfig) then
			titanSpeedConfig = { };
		end	
		titanSpeed.m_vLastPos = {};
		titanSpeed.m_vLastPos.x, titanSpeed.m_vLastPos.y = GetPlayerMapPosition("player");	
		if (not titanSpeedConfig[titanSpeed.m_strPlayer]) then
			titanSpeedConfig[titanSpeed.m_strPlayer] = {};
		end	
		if (titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplay == nil) then
			titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplay = true;
		end
		if (titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplayPercent == nil) then
			titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplayPercent = true;
		end
		if (titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplayBar == nil) then
			titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplayBar = true;
		end
		if (titanSpeedConfig[titanSpeed.m_strPlayer].m_fUpdateRate == nil) then
			titanSpeedConfig[titanSpeed.m_strPlayer].m_fUpdateRate = 0.5;
		end
		if (titanSpeedConfig[titanSpeed.m_strPlayer].m_bDebugMode == nil) then
			titanSpeedConfig[titanSpeed.m_strPlayer].m_bDebugMode = false;
		end
		if (titanSpeedConfig[titanSpeed.m_strPlayer].m_bLocked == nil) then
			titanSpeedConfig[titanSpeed.m_strPlayer].m_bLocked = false;
		end		
		titanSpeed.m_bLoaded = true;
	end
end


function TitanPanelSpeedButton_OnLoad()
	this.registry={
		id=TITAN_SPEED_ID,
		menuText=TITAN_SPEED_MENU_TEXT,
		buttonTextFunction="TitanPanelSpeedButton_GetButtonText",
		frequency=TITAN_SPEED_FREQUENCY,
		icon = "Interface\\Icons\\Ability_Rogue_Sprint.blp",
		iconWidth = 16,
		savedVariables = {
				ShowIcon = 1,
				ShowLabelText = 1,
		},
	};	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");	
	SlashCmdList["TITANSPEED_RESET"] = TitanSpeed_ToggleReset;
		SLASH_TITANSPEED_RESET1 = "/rsr";
		SLASH_TITANSPEED_RESET2 = "/resetspeedrates";
	SlashCmdList["TITANSPEED_RATE"] = TitanSpeed_ToggleRate;
		SLASH_TITANSPEED_RATE1 = "/nsr";
		SLASH_TITANSPEED_RATE2 = "/newspeedrate";
end


function TitanPanelSpeedButton_GetButtonText(id)
	local speed = titanSpeed.m_fSpeed;
	return TITAN_SPEED_BUTTON_LABEL,format(TITAN_SPEED_BUTTON_TEXT,TitanUtils_GetHighlightText(speed.."%"));
end


function TitanPanelSpeedButton_OnEvent(event)	
	if (event == "VARIABLES_LOADED") then	
		titanSpeed.m_bVariablesLoaded = true;	
		if (not titanSpeed.m_bLoaded) then		
			titanSpeed.m_strPlayer = UnitName("player");		
			if (titanSpeed.m_strPlayer ~= nil and titanSpeed.m_strPlayer ~= UNKNOWNOBJECT) then
				TitanSpeed_Init();
			end
		end	
		if (not ZoneBaseline2) then
			TitanSpeed_Reset()
		end
		return;	
	end	
	if (event == "PLAYER_ENTERING_WORLD") then	
		if (not titanSpeed.m_bLoaded) then		
			titanSpeed.m_strPlayer = UnitName("player");		
			if (titanSpeed.m_strPlayer ~= nil and titanSpeed.m_strPlayer ~= UNKNOWNOBJECT) then		
				TitanSpeed_Init();
			end
		end	
		return;	
	end
end


-- OnUpdate Function (heavily based off code in Telo's Clock)
function TitanPanelSpeedButton_OnUpdate(arg1)
	if (not titanSpeed.m_bLoaded) then
		return;
	end
	titanSpeed.m_iDeltaTime = titanSpeed.m_iDeltaTime + arg1;
	titanSpeed.m_vCurrPos.x, titanSpeed.m_vCurrPos.y = GetPlayerMapPosition("player");
	titanSpeed.m_vCurrPos.x = titanSpeed.m_vCurrPos.x + 0.0;
	titanSpeed.m_vCurrPos.y = titanSpeed.m_vCurrPos.y + 0.0;
	if (titanSpeed.m_vCurrPos.x) then
		local dist;	
		dist = math.sqrt(
				((titanSpeed.m_vLastPos.x - titanSpeed.m_vCurrPos.x) * (titanSpeed.m_vLastPos.x - titanSpeed.m_vCurrPos.x) * 2.25 ) +
				((titanSpeed.m_vLastPos.y - titanSpeed.m_vCurrPos.y) * (titanSpeed.m_vLastPos.y - titanSpeed.m_vCurrPos.y))
		);	
		titanSpeed.m_fSpeedDist = titanSpeed.m_fSpeedDist + dist;
		if (titanSpeed.m_iDeltaTime >= .5) then	
			local zonenum;
			local contnum;
			local baserate;
			local rate;
			local zonename;
			zonenum = GetCurrentMapZone();
			zonename = GetZoneText();
			
			if (zonenum ~= 0) then
				contnum = GetCurrentMapContinent();
				f,h,w = GetMapInfo();
				if (titanSpeed.m_setRate == true) then
					rate = (titanSpeed.m_fSpeedDist / titanSpeed.m_iDeltaTime);
					if (contnum == 2) then
						ZoneBaseline2[zonenum].rate = rate;
					else
						ZoneBaseline1[zonenum].rate = rate;
					end
					DEFAULT_CHAT_FRAME:AddMessage(format("TitanSpeed :: Baserate for zone "..zonenum.." set to "..rate));
					titanSpeed.m_setRate = false;
				end
				
				if (contnum == 2) then
					baserate = ZoneBaseline2[zonenum].rate;
				else
					baserate = ZoneBaseline1[zonenum].rate;
				end		
				titanSpeed.m_fSpeed = TitanSpeed_Round(((titanSpeed.m_fSpeedDist / titanSpeed.m_iDeltaTime) / baserate) * 100);	
				titanSpeed.m_fSpeedDist = 0.0;
				titanSpeed.m_iDeltaTime = 0.0;		
				if (titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplayPercent) then
					TitanPanelButton_UpdateButton("Speed");
					TitanPanelButton_UpdateTooltip();
				end
			else
				if( Others == nil ) then 
				  Others = titanSpeedOthers;
				end		
		
				if (titanSpeed.m_setRate == true) then
					rate = (titanSpeed.m_fSpeedDist / titanSpeed.m_iDeltaTime);
					if ( Others[zonename] == nil ) then
						Others[zonename] = {};
					end
					Others[zonename].rate = rate;
					
					DEFAULT_CHAT_FRAME:AddMessage(format("TitanSpeed :: Baserate for zone "..zonename.." set to "..rate));
					titanSpeed.m_setRate = false;
				end
				
				if( Others[zonename] ~= nil ) then
					baserate = Others[zonename].rate;
					if( baserate ~= 0 ) then
						titanSpeed.m_fSpeed = TitanSpeed_Round(((titanSpeed.m_fSpeedDist / titanSpeed.m_iDeltaTime) / baserate) * 100);
					else
						titanSpeed.m_fSpeed = "??";
					end
				else
					titanSpeed.m_fSpeed = "??";
				end
				
				titanSpeed.m_fSpeedDist = 0.0;
				titanSpeed.m_iDeltaTime = 0.0;		
				if (titanSpeedConfig[titanSpeed.m_strPlayer].m_bDisplayPercent) then
					 TitanPanelButton_UpdateButton("Speed");
					 TitanPanelButton_UpdateTooltip();
				end
			end
		end
		titanSpeed.m_vLastPos.x = titanSpeed.m_vCurrPos.x;
		titanSpeed.m_vLastPos.y = titanSpeed.m_vCurrPos.y;
		titanSpeed.m_vLastPos.z = titanSpeed.m_vCurrPos.z;
	end
end

function TitanSpeed_Round(x)
	if(x - floor(x) > 0.5) then
		x = x + 0.5;
	end
	return floor(x);
end

function TitanSpeed_ToggleRate()
	if (titanSpeed.m_bLoaded == false) then
		return;
	end
	titanSpeed.m_setRate = true;
end

function TitanSpeed_ToggleReset()
	StaticPopup_Show("TITANSPEED_RESET");
end

function TitanSpeed_Reset()
	ZoneBaseline2 = titanSpeedZoneBaseline2;
	ZoneBaseline1 = titanSpeedZoneBaseline1;
	Others = titanSpeedOthers;

	DEFAULT_CHAT_FRAME:AddMessage(format("TitanSpeed :: Base-rates initialize/reset for all zones."));
end


function TitanPanelRightClickMenu_PrepareSpeedMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_SPEED_ID].menuText);
	
	info = {};
	info.text = TITAN_SPEED_NSR;
	info.func = TitanSpeed_ToggleRate;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_SPEED_RSR;
	info.func = TitanSpeed_ToggleReset;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_SPEED_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_SPEED_ID);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_SPEED_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end