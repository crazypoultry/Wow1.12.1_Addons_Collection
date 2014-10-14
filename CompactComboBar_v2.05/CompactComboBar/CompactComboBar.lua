
------------------------------------------------------
-- Colors
------------------------------------------------------

local GRN="|cff20ff20";
local YEL="|cffffff40";
local RED="|cffff2020";
local WHT="|cffffffff";
local MAG="|cffff00ff";


------------------------------------------------------
-- Variables
------------------------------------------------------

local CCB_Enable;
local CCB_Debug = false;
local CCB_PlayerClass;
local CCB_PlayerClassUS;
local CCB_NoRogue = false;
local CCB_InCombat = false;


------------------------------------------------------
-- Help Messages
------------------------------------------------------

CCB_SPLASH = "CompactComboBar "..WHT.."("..YEL.."with MobHealth"..WHT..")";
CCB_HELLO1 = CCB_SPLASH.." Syntax: /ccb ["..YEL.."command"..WHT.."] (eg. /ccb "..YEL.."help"..WHT..")";

local CCB_MSG1  = CCB_SPLASH..GRN.." Help:";
local CCB_MSG2  = "/ccb "..GRN.."switch"..WHT.." -> to "..GRN.."Enable"..WHT.."/"..RED.."Disable"..WHT.." the panel.";
local CCB_MSG3  = "/ccb "..GRN.."combat"..WHT.." -> to show the panel only when you are in combat and hide it otherwise.";
local CCB_MSG4  = "/ccb "..GRN.."rogueonly"..WHT.." -> to show the panel only when you are a rogue or druid in cat form and hide it otherwise.";
local CCB_MSG5  = "/ccb "..GRN.."toggle "..WHT.."<"..YEL.."combo"..WHT.."/"..YEL.."t-health"..WHT.."/"..YEL.."t-mana"..WHT.."/"..YEL.."health"..WHT.."/"..YEL.."energy"..WHT.."> -> toggle shown/hidden status of each bar (ie. /ccb "..GRN.."toggle"..YEL.." health"..WHT..").";
local CCB_MSG6  = "/ccb "..GRN.."color "..WHT.."<"..YEL.."cp"..WHT.."/"..YEL.."hp"..WHT.."/"..YEL.."pow"..WHT.."> -> toggle the color option on a bar (ie. /ccb "..GRN.."color"..YEL.." cp"..WHT..").";
local CCB_MSG7  = "/ccb "..GRN.."text "..WHT.."<"..YEL.."hp "..WHT.."/"..YEL.."myhp"..WHT.."/"..YEL.."energy"..WHT.."/"..YEL.."all"..WHT.."> -> toggle text modes on bars (ie. /ccb "..GRN.."text "..YEL.."hp"..WHT..").";
local CCB_MSG8  = "/ccb "..GRN.."size "..WHT.."<"..YEL.."num"..WHT.."> -> resize [0.5 - 1.8] (ie. /ccb "..GRN.."size"..YEL.." 1.2"..WHT..").";
local CCB_MSG9  = "/ccb "..GRN.."lock"..WHT.." -> locks the panel.";
local CCB_MSG10  = "/ccb "..GRN.."unlock"..WHT.." -> unlocks the panel.";
local CCB_MSG11 = "/ccb "..GRN.."status"..WHT.." -> shows current settings.";


------------------------------------------------------
-- Functions
------------------------------------------------------

local function CompactComboBar_Print(msg)
  	if not DEFAULT_CHAT_FRAME then return end
  	if (type(msg) == "table") then
		for i=0, table.getn(msg) do
			DEFAULT_CHAT_FRAME:AddMessage(msg[i]);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end


local function CompactComboBar_Debug(msg)
  	if not DEFAULT_CHAT_FRAME then return end
  	if not CCB_Debug then return end
  	if (type(msg) ~= "string") then
		for i=0, table.getn(msg) do
			DEFAULT_CHAT_FRAME:AddMessage(msg[i]);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end


function CompactComboBar_CheckCatForm()
	if (CCB_PlayerClassUS == "ROGUE") then
		return true;
	elseif (CCB_PlayerClassUS == "DRUID") then
		local res = false;
		if (GetNumShapeshiftForms() > 0) then
			for i=1,GetNumShapeshiftForms(),1 do
				texture,name,isActive,isCastable=GetShapeshiftFormInfo(i);
				if (string.find(texture, "Ability_Druid_CatForm", 1, true) and isActive) then
					res = true;
				end
			end
		end
		return res;
	else
		return false;
	end
end


function CompactComboBar_OnDragStart()
	if ( not CompactComboBar_Config[User].locked ) then
		CompactComboBarFrame:StartMoving()
	else
		CompactComboBar_Print(CCB_SPLASH.." is "..RED.."locked"..WHT..", type /ccb "..GRN.."unlock"..WHT.." to unlock it.")
	end
end


function CompactComboBar_OnDragStop()
	CompactComboBarFrame:StopMovingOrSizing()
	CompactComboBar_Config[User].posx = CompactComboBarFrame:GetLeft()/CompactComboBarFrame:GetScale();
	CompactComboBar_Config[User].posy = CompactComboBarFrame:GetTop()/CompactComboBarFrame:GetScale();
	-- CompactComboBar_Debug(CCB_SPLASH.." now stopped.");
	-- CompactComboBar_Debug(CCB_SPLASH.." new pos "..GRN.."X"..WHT..": "..YEL..CompactComboBarFrame:GetLeft()..WHT..", "..GRN.."Y"..WHT..": "..YEL..CompactComboBarFrame:GetTop());
end


function CompactComboBar_Initialize()
	playerName = UnitName("player");
	realmName = GetCVar("realmName");
	User = UnitName("player").."|"..GetCVar("realmName");

	----------------------------------------------
	--- Setting up a Config
	----------------------------------------------
	CompactComboBar_Print(CCB_HELLO1);
	if ( CompactComboBar_Config == nil ) then
		CompactComboBar_Config = {};
		CompactComboBar_Print(CCB_SPLASH.." No config file found!");
	end

	if ( CompactComboBar_Config.rogueonly == nil ) then
		CompactComboBar_Config.rogueonly = false;
	end

	if ( CompactComboBar_Config[User] == nil ) then
		CompactComboBar_Config[User] = {
			size = 1,
			hpcolor = true,
			cpcolor = true,
			powcolor = true,
			hptbartext = 1,
			hppbartext = 1,
			text = true,
			show = true,
			hidecombo = false,
			hidetargethealth = false,
			hidetargetmana = false,
			hidehealth = false,
			hideenergy = false,
			combat = false,
			locked = false,
			posx = 400,
			posy = 400,
			energytext = 1,
		};
		CompactComboBar_Print(CCB_SPLASH.." no profile for "..playerName.." on "..realmName.." was found, creating new profile.");
	else
		CompactComboBar_Print(CCB_SPLASH.." "..playerName.." on "..realmName.." loaded.");
		CompactComboBar_CheckConfig();
	end
end


function CompactComboBar_CheckConfig()
	if ( CompactComboBar_Config[User].size == nil ) then
		CompactComboBar_Config[User].size = 1;
	end
	if ( CompactComboBar_Config[User].hpcolor == nil ) then
		CompactComboBar_Config[User].hpcolor = true;
	end
	if ( CompactComboBar_Config[User].cpcolor == nil ) then
		CompactComboBar_Config[User].cpcolor = true;
	end
	if ( CompactComboBar_Config[User].powcolor == nil ) then
		CompactComboBar_Config[User].powcolor = true;
	end
	if ( CompactComboBar_Config[User].hptbartext == nil ) then
		CompactComboBar_Config[User].hptbartext = 1;
	end
	if ( CompactComboBar_Config[User].hppbartext == nil ) then
		CompactComboBar_Config[User].hppbartext = 1;
	end
	if ( CompactComboBar_Config[User].text == nil ) then
		CompactComboBar_Config[User].text = true;
	end
	if ( CompactComboBar_Config[User].show == nil ) then
		CompactComboBar_Config[User].show = true;
	end
	if ( CompactComboBar_Config[User].hidecombo == nil ) then
		CompactComboBar_Config[User].hidecombo = false;
	end
	if ( CompactComboBar_Config[User].hidetargethealth == nil ) then
		CompactComboBar_Config[User].hidetargethealth = false;
	end
	if ( CompactComboBar_Config[User].hidetargetmana == nil ) then
		CompactComboBar_Config[User].hidetargetmana = false;
	end
	if ( CompactComboBar_Config[User].hidehealth == nil ) then
		CompactComboBar_Config[User].hidehealth = false;
	end
	if ( CompactComboBar_Config[User].hideenergy == nil ) then
		CompactComboBar_Config[User].hideenergy = false;
	end
	if ( CompactComboBar_Config[User].combat == nil ) then
		CompactComboBar_Config[User].combat = false;
	end
	if ( CompactComboBar_Config[User].locked == nil ) then
		CompactComboBar_Config[User].locked = false;
	end
	if ( CompactComboBar_Config[User].posx == nil ) then
		CompactComboBar_Config[User].posx = 400;
	end
	if ( CompactComboBar_Config[User].posy == nil ) then
		CompactComboBar_Config[User].posy = 400;
	end
	if ( CompactComboBar_Config[User].energytext == nil ) then
		CompactComboBar_Config[User].energytext = 1;
	end

end


function CompactComboBar_OnLoad()
	for i = 1, 5, 1 do
		local barname = getglobal("CompactCombo"..i);
		barname:SetStatusBarColor(1, 0, 0);
		barname:SetMinMaxValues(0, 1);
		barname:SetValue(0);
	end
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	SlashCmdList["COMPACTCOMBOBARCOMMAND"] = CompactComboBar_SlashHandler;
	SLASH_COMPACTCOMBOBARCOMMAND1 = "/ccb";

	CompactTargetHealthBar:SetStatusBarColor(1, 0, 0);
	CompactTargetManaBar:SetStatusBarColor(0, 0, 1);
	CompactEnergyBar:SetStatusBarColor(1, 1, 0);
end


function CompactComboBar_Color(bar)
	if ((bar == "cp") or (bar == "combo") or (bar == "combopoint")) then
		if (CompactComboBar_Config[User].cpcolor) then
			CompactComboBar_Config[User].cpcolor = false;
			CompactComboBar_Print(CCB_SPLASH.." is now using "..GRN.."one color "..WHT.."on "..YEL.."CP"..WHT.." bar.")
		else
			CompactComboBar_Config[User].cpcolor = true;
			CompactComboBar_Print(CCB_SPLASH.." is now using "..GRN.."status colors "..WHT.."on "..YEL.."CP"..WHT.." bar.")
		end
	elseif ((bar == "hp") or (bar == "health")) then
			if (CompactComboBar_Config[User].hpcolor) then
				CompactComboBar_Config[User].hpcolor = false;
				CompactComboBar_Print(CCB_SPLASH.." is now using "..GRN.."one color "..WHT.."on "..YEL.."HP"..WHT.." bar.")
			else
				CompactComboBar_Config[User].hpcolor = true;
				CompactComboBar_Print(CCB_SPLASH.." is now using "..GRN.."status colors "..WHT.."on "..YEL.."HP"..WHT.." bar.")
			end
	elseif ((bar == "pow") or (bar == "power")) then
		if (CompactComboBar_Config[User].powcolor) then
			CompactComboBar_Config[User].powcolor = false;
			CompactComboBar_Print(CCB_SPLASH.." is now using "..GRN.."one color "..WHT.."on "..YEL.."Power"..WHT.." bar.")
		else
			CompactComboBar_Config[User].powcolor = true;
			CompactComboBar_Print(CCB_SPLASH.." is now using "..GRN.."power color "..WHT.."on "..YEL.."Power"..WHT.." bar.")
		end
	else
		if ( CompactComboBar_Config[User].hpcolor ) then
			CompactComboBar_Print(CCB_SPLASH..GRN.." hpbarcolor "..WHT..": "..YEL.."status color"..WHT..".");
		else
			CompactComboBar_Print(CCB_SPLASH..GRN.." hpbarcolor "..WHT..": "..YEL.."one color"..WHT..".");
		end
		if ( CompactComboBar_Config[User].cpcolor ) then
			CompactComboBar_Print(CCB_SPLASH..GRN.." cpbarcolor "..WHT..": "..YEL.."status color"..WHT..".");
		else
			CompactComboBar_Print(CCB_SPLASH..GRN.." cpbarcolor "..WHT..": "..YEL.."one color"..WHT..".");
		end
		if ( CompactComboBar_Config[User].powcolor ) then
			CompactComboBar_Print(CCB_SPLASH..GRN.." powbarcolor "..WHT..": "..YEL.."power color"..WHT..".");
		else
			CompactComboBar_Print(CCB_SPLASH..GRN.." powbarcolor "..WHT..": "..YEL.."one color"..WHT..".");
		end
	end
	CompactComboBar_UpdateComboBar();
	CompactComboBar_UpdateTargetHealthBar();
	CompactComboBar_UpdateTargetManaBar();
	CompactComboBar_UpdateHealthBar();
	CompactComboBar_UpdateEnergyBar();
end


function CompactComboBar_TextToggle(arg1)
	if ( arg1 == "hp" ) then
		if ( (CompactComboBar_Config[User].hptbartext < 3) or (CompactComboBar_Config[User].hptbartext == nil) ) then
			CompactComboBar_Config[User].hptbartext = CompactComboBar_Config[User].hptbartext + 1;
		else
			CompactComboBar_Config[User].hptbartext = 1;
		end
		if ( CompactComboBar_Config[User].hptbartext == 1) then
			CompactComboBar_Print(CCB_SPLASH.." target health format"..WHT..": "..YEL.."HP"..WHT..".");
		end
		if ( CompactComboBar_Config[User].hptbartext == 2) then
			CompactComboBar_Print(CCB_SPLASH.." target health format"..WHT..": "..YEL.."HP %"..WHT..".");
		end
		if ( CompactComboBar_Config[User].hptbartext == 3) then
			CompactComboBar_Print(CCB_SPLASH.." target health format"..WHT..": "..YEL.."% HP"..WHT..".");
		end
	elseif ( arg1 == "myhp" ) then
		if ( (CompactComboBar_Config[User].hppbartext < 3) or (CompactComboBar_Config[User].hppbartext == nil) ) then
			CompactComboBar_Config[User].hppbartext = CompactComboBar_Config[User].hppbartext + 1;
		else
			CompactComboBar_Config[User].hppbartext = 1;
		end
		if ( CompactComboBar_Config[User].hppbartext == 1) then
			CompactComboBar_Print(CCB_SPLASH.." player health format"..WHT..": "..YEL.."HP"..WHT..".");
		end
		if ( CompactComboBar_Config[User].hppbartext == 2) then
			CompactComboBar_Print(CCB_SPLASH.." player health format"..WHT..": "..YEL.."HP %"..WHT..".");
		end
		if ( CompactComboBar_Config[User].hppbartext == 3) then
			CompactComboBar_Print(CCB_SPLASH.." player health format"..WHT..": "..YEL.."% HP"..WHT..".");
		end
	elseif ( arg1 == "energy" ) then
		if ( (CompactComboBar_Config[User].energytext < 2) or (CompactComboBar_Config[User].energytext == nil) ) then
			CompactComboBar_Config[User].energytext = CompactComboBar_Config[User].energytext + 1;
		else
			CompactComboBar_Config[User].energytext = 1;
		end

		if ( CompactComboBar_Config[User].energytext == 1) then
			CompactComboBar_Print(CCB_SPLASH.." player energy format"..WHT..": "..YEL.."Energy/Max"..WHT..".");
		end
		if ( CompactComboBar_Config[User].energytext == 2) then
			CompactComboBar_Print(CCB_SPLASH.." player energy format"..WHT..": "..YEL.."Energy"..WHT..".");
		end
	elseif ( arg1 == "all" or arg1 == "" or arg1 == nil) then
		if (CompactComboBar_Config[User].text) then
			CompactComboBar_Config[User].text = false;
			CompactComboBar_Print(CCB_SPLASH.." text is now "..GRN.."hidden.")
		else
			CompactComboBar_Config[User].text = true;
			CompactComboBar_Print(CCB_SPLASH.." text is now "..GRN.."visible.")
		end
	end
	CompactComboBar_UpdateTargetHealthBar();
	CompactComboBar_UpdateTargetManaBar();
	CompactComboBar_UpdateHealthBar();
	CompactComboBar_UpdateEnergyBar();
end


function CompactComboBar_BarToggle(bar)
	if ( bar == "combo" ) then
		if ( CompactComboBar_Config[User].hidecombo ) then
			CompactComboBar_Config[User].hidecombo = false;
			CompactComboBar_Print(CCB_SPLASH.." Combo Points now visible (if rogue).");
			CompactComboBar_UpdateComboBar();
		else
			CompactComboBar_Config[User].hidecombo = true;
			CompactComboBar_Print(CCB_SPLASH.." Combo Points now hidden.");
			CompactComboBar_UpdateComboBar();
		end
	elseif ( bar == "t-health" ) then
		if ( CompactComboBar_Config[User].hidetargethealth ) then
			CompactComboBar_Config[User].hidetargethealth = false;
			CompactComboBar_Print(CCB_SPLASH.." Target Health now visible.");
			CompactComboBar_UpdateTargetHealthBar();
		else
			CompactComboBar_Config[User].hidetargethealth = true;
			CompactComboBar_Print(CCB_SPLASH.." Target Health now hidden.");
			CompactComboBar_UpdateTargetHealthBar();
		end
	elseif ( bar == "t-mana" ) then
		if ( CompactComboBar_Config[User].hidetargetmana ) then
			CompactComboBar_Config[User].hidetargetmana = false;
			CompactComboBar_Print(CCB_SPLASH.." Target Mana now visible.");
			CompactComboBar_UpdateTargetManaBar();
		else
			CompactComboBar_Config[User].hidetargetmana = true;
			CompactComboBar_Print(CCB_SPLASH.." Target Mana now hidden.");
			CompactComboBar_UpdateTargetManaBar();
		end
	elseif ( bar == "health" ) then
		if ( CompactComboBar_Config[User].hidehealth ) then
			CompactComboBar_Config[User].hidehealth = false;
			CompactComboBar_Print(CCB_SPLASH.." Health now visible.");
			CompactComboBar_UpdateHealthBar();
		else
			CompactComboBar_Config[User].hidehealth = true;
			CompactComboBar_Print(CCB_SPLASH.." Health now hidden.");
			CompactComboBar_UpdateHealthBar();
		end
	elseif ( bar == "energy" ) then
		if ( CompactComboBar_Config[User].hideenergy ) then
			CompactComboBar_Config[User].hideenergy = false;
			CompactComboBar_Print(CCB_SPLASH.." Energy now visible.");
			CompactComboBar_UpdateEnergyBar();
		else
			CompactComboBar_Config[User].hideenergy = true;
			CompactComboBar_Print(CCB_SPLASH.." Energy now hidden.");
			CompactComboBar_UpdateEnergyBar();
		end
	else
		if (DEFAULT_CHAT_FRAME) then
			CompactComboBar_Print(CCB_MSG1);
			CompactComboBar_Print(CCB_MSG2);
			CompactComboBar_Print(CCB_MSG3);
			CompactComboBar_Print(CCB_MSG4);
			CompactComboBar_Print(CCB_MSG5);
			CompactComboBar_Print(CCB_MSG6);
			CompactComboBar_Print(CCB_MSG7);
			CompactComboBar_Print(CCB_MSG8);
			CompactComboBar_Print(CCB_MSG9);
			CompactComboBar_Print(CCB_MSG10);
			CompactComboBar_Print(CCB_MSG11);
		end
	end
end


function CompactComboBar_Switch()
	local frame = getglobal("CompactComboBarFrame");
	if ( not CCB_Enable ) then
		frame:Hide();
		return;
	elseif ( not CompactComboBar_Config[User].show ) then
		frame:Hide();
		return;
	elseif ( CompactComboBar_Config.rogueonly and CCB_NoRogue ) then
		frame:Hide();
		return;
	elseif ( CompactComboBar_Config.rogueonly and not CompactComboBar_CheckCatForm() ) then
		frame:Hide();
		return;
	elseif ( CompactComboBar_Config[User].combat and not CCB_InCombat ) then
		frame:Hide();
		return;
	else
		frame:Show();
		CompactComboBar_UpdateComboBar();
		CompactComboBar_UpdateTargetHealthBar();
		CompactComboBar_UpdateTargetManaBar();
		CompactComboBar_UpdateHealthBar();
		CompactComboBar_UpdateEnergyBar();
		return;
	end
end


function CompactComboBar_Move(frame, framex, framey)
	frame:ClearAllPoints();
	frame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",framex,framey);
	CompactComboBar_Config[User].posx = framex/frame:GetScale();
	CompactComboBar_Config[User].posy = framey/frame:GetScale();
end


function CompactComboBar_Scale(scale)
	local frame = getglobal("CompactComboBarFrame");

	if ( (scale ~= nil) and not (scale == "") ) then
		local oldscale = frame:GetScale() or 1;
		framex, framey = (frame:GetLeft() or 0)*oldscale, (frame:GetTop() or 0)*oldscale;
		-- CompactComboBar_Debug(CCB_SPLASH..framex.." - "..framey);
		if ( tonumber(scale) > 1.8 ) then scale = 1.8; end
		if ( tonumber(scale) < 0.5 ) then scale = 0.5; end
		frame:SetScale(tonumber(scale));
		CompactComboBar_Move(frame,framex/frame:GetScale(),framey/frame:GetScale());
		CompactComboBar_Print(CCB_SPLASH.." new size "..YEL..string.format("%.1f", frame:GetScale())..WHT..".");
		CompactComboBar_Config[User].size = tonumber(scale);
	else
		CompactComboBar_Print(CCB_SPLASH.." current size "..YEL..frame:GetScale()..WHT..".");
	end
end


function CompactComboBar_ExtractCMDParams(msg)
  local params = msg;
  local command = params;
  local index = strfind(command, " ");
  if ( index ) then
    command = strsub(command, 1, index-1);
    params = strsub(params, index+1);
  else
    params = "";
  end

  return command, params;
end


function CompactComboBar_Status()
	local buffmsg = "";
	CompactComboBar_Print(CCB_SPLASH..GRN.." size "..WHT..": "..YEL..CompactComboBar_Config[User].size..WHT..".");
	if ( CompactComboBar_Config[User].hpcolor ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." hpbarcolor "..WHT..": "..YEL.."status color"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." hpbarcolor "..WHT..": "..YEL.."one color"..WHT..".");
	end
	if ( CompactComboBar_Config[User].cpcolor ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." cpbarcolor "..WHT..": "..YEL.."status color"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." cpbarcolor "..WHT..": "..YEL.."one color"..WHT..".");
	end
	if ( CompactComboBar_Config[User].powcolor ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." powbarcolor "..WHT..": "..YEL.."power color"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." powbarcolor "..WHT..": "..YEL.."one color"..WHT..".");
	end
	if ( CompactComboBar_Config[User].combat ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." visible in combat only "..WHT..": "..YEL.."true"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." visible in combat only "..WHT..": "..YEL.."false"..WHT..".");
	end
	if ( CompactComboBar_Config.rogueonly ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." visible for rogues and druid-cats only "..WHT..": "..YEL.."true"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." visible for rogues and druid-cats only "..WHT..": "..YEL.."false"..WHT..".");
	end
	if ( CompactComboBar_Config[User].hidecombo ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." Combo Point bar hidden "..WHT..": "..YEL.."true"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." Combo Point bar hidden "..WHT..": "..YEL.."false"..WHT..".");
	end
	if ( CompactComboBar_Config[User].hidetargethealth ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." Target Health bar hidden "..WHT..": "..YEL.."true"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." Target Health bar hidden "..WHT..": "..YEL.."false"..WHT..".");
	end
	if ( CompactComboBar_Config[User].hidetargetmana ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." Target Mana bar hidden "..WHT..": "..YEL.."true"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." Target Mana bar hidden "..WHT..": "..YEL.."false"..WHT..".");
	end
	if ( CompactComboBar_Config[User].hidehealth ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." Health bar hidden "..WHT..": "..YEL.."true"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." Health bar hidden "..WHT..": "..YEL.."false"..WHT..".");
	end
	if ( CompactComboBar_Config[User].hideenergy ) then
		CompactComboBar_Print(CCB_SPLASH..GRN.." Energy bar hidden "..WHT..": "..YEL.."true"..WHT..".");
	else
		CompactComboBar_Print(CCB_SPLASH..GRN.." Energy bar hidden "..WHT..": "..YEL.."false"..WHT..".");
	end
	CompactComboBar_Print(CCB_SPLASH..GRN.." posX "..WHT..": "..YEL..string.format("%d",CompactComboBar_Config[User].posx)..WHT..","..GRN.." posY "..WHT..": "..YEL..string.format("%d",CompactComboBar_Config[User].posy));
	buffmsg = CCB_SPLASH..GRN.." text "..WHT.."settings: ";

	if ( CompactComboBar_Config[User].text ) then
		buffmsg = buffmsg..YEL.." all"..GRN.." on"..WHT..", ";
	else
		buffmsg = buffmsg..YEL.." all"..RED.." off"..WHT..", ";
	end

	if ( CompactComboBar_Config[User].hptbartext == 1 ) then
		buffmsg = buffmsg..YEL.."target hp"..WHT.." mode "..YEL.."1"..WHT..", ";
	elseif ( CompactComboBar_Config[User].hptbartext == 2 ) then
		buffmsg = buffmsg..YEL.."target hp"..WHT.." mode "..YEL.."2"..WHT..", ";
	elseif ( CompactComboBar_Config[User].hptbartext == 3 ) then
		buffmsg = buffmsg..YEL.."target hp"..WHT.." mode "..YEL.."3"..WHT..", ";
	end

	if ( CompactComboBar_Config[User].hppbartext == 1 ) then
		buffmsg = buffmsg..YEL.."player hp"..WHT.." mode "..YEL.."1"..WHT..", ";
	elseif ( CompactComboBar_Config[User].hppbartext == 2 ) then
		buffmsg = buffmsg..YEL.."player hp"..WHT.." mode "..YEL.."2"..WHT..", ";
	elseif ( CompactComboBar_Config[User].hppbartext == 3 ) then
		buffmsg = buffmsg..YEL.."player hp"..WHT.." mode "..YEL.."3"..WHT..", ";
	end

	if ( CompactComboBar_Config[User].energytext == 1 ) then
			buffmsg = buffmsg..YEL.."energy"..WHT.." mode "..YEL.."1"..WHT..".";
		else
			buffmsg = buffmsg..YEL.."energy"..WHT.." mode "..YEL.."2"..WHT..".";
	end
	CompactComboBar_Print(buffmsg);
	if ( CompactComboBar_Config[User].show ) then
		buffmsg = CCB_SPLASH.." is"..GRN.." Enabled"..WHT..".";
	else
		buffmsg = CCB_SPLASH.." is"..RED.." Disabled"..WHT..".";
	end
	if ( CompactComboBar_Config[User].locked ) then
		buffmsg = buffmsg.." and"..RED.." Locked"..WHT..".";
	else
		buffmsg = buffmsg.." and"..GRN.." Unlocked"..WHT..".";
	end
	CompactComboBar_Print(buffmsg);
end


function CompactComboBar_SlashHandler(msg)
	if ( CCB_Enable ) then

		cmd, params = CompactComboBar_ExtractCMDParams(string.lower(msg));
		local frame = getglobal("CompactComboBarFrame");

		if (cmd == "switch") then
			if ( frame:IsVisible() ) then
				frame:Hide();
				CompactComboBar_Config[User].show = false;
				CompactComboBar_Print(CCB_SPLASH..RED.." disabled"..WHT..".");
			elseif ( not frame:IsVisible() and CompactComboBar_Config[User].combat ) then
				CompactComboBar_Print(CCB_SPLASH.." visible in combat only.");
			elseif ( not frame:IsVisible() and CompactComboBar_Config.rogueonly ) then
				CompactComboBar_Print(CCB_SPLASH.." visible for rogues and druid-cats only.");
			elseif ( not frame:IsVisible() and not CompactComboBar_Config[User].combat and not CompactComboBar_Config.rogueonly ) then
				frame:Show();
				CompactComboBar_Config[User].show = true;
				CompactComboBar_Print(CCB_SPLASH..GRN.." enabled"..WHT..".");
			end
			return;
		elseif (cmd == "combat") then
			if ( CompactComboBar_Config[User].show ) then
				if ( CompactComboBar_Config[User].combat ) then
					CompactComboBar_Config[User].combat = false;
					CompactComboBar_Print(CCB_SPLASH.." visible at all time.");
					CompactComboBar_Switch();
				else
					CompactComboBar_Config[User].combat = true;
					CompactComboBar_Print(CCB_SPLASH.." visible in combat only.");
					CompactComboBar_Switch();
				end
			end
			return;
		elseif (cmd == "rogueonly") then
			if ( CompactComboBar_Config[User].show ) then
				if ( CompactComboBar_Config.rogueonly ) then
					CompactComboBar_Config.rogueonly = false;
					CompactComboBar_Print(CCB_SPLASH.." visible for all classes.");
					CompactComboBar_Switch();
				else
					CompactComboBar_Config.rogueonly = true;
					CompactComboBar_Print(CCB_SPLASH.." visible for rogues and druid-cats only.");
					CompactComboBar_Switch();
				end
			end
			return;
		elseif (cmd == "toggle") then
			CompactComboBar_BarToggle(params);
			return;
		elseif (cmd == "color") then
			if ( CompactComboBar_Config[User].show ) then
				CompactComboBar_Color(params);
			end
			return;
		elseif (cmd == "text") then
			if ( CompactComboBar_Config[User].show ) then
				CompactComboBar_TextToggle(params);
			end
			return;
		elseif (cmd == "size") then
			if ( CompactComboBar_Config[User].show ) then
				CompactComboBar_Scale(params);
			end
			return;
		elseif (cmd == "unlock") then
			if ( CompactComboBar_Config[User].show ) then
				CompactComboBar_Config[User].locked = false;
				CompactComboBar_Print(CCB_SPLASH.." is now "..GRN.."unlocked"..WHT..".")
			end
			return;
		elseif (cmd == "lock") then
			if( CompactComboBar_Config[User].show ) then
				CompactComboBar_Config[User].locked = true;
				CompactComboBar_Print(CCB_SPLASH.." is now "..RED.."locked"..WHT..".")
			end
			return;
		elseif (cmd == "status") then
			CompactComboBar_Status()
			return;
		end
		if (DEFAULT_CHAT_FRAME) then
			CompactComboBar_Print(CCB_MSG1);
			CompactComboBar_Print(CCB_MSG2);
			CompactComboBar_Print(CCB_MSG3);
			CompactComboBar_Print(CCB_MSG4);
			CompactComboBar_Print(CCB_MSG5);
			CompactComboBar_Print(CCB_MSG6);
			CompactComboBar_Print(CCB_MSG7);
			CompactComboBar_Print(CCB_MSG8);
			CompactComboBar_Print(CCB_MSG9);
			CompactComboBar_Print(CCB_MSG10);
			CompactComboBar_Print(CCB_MSG11);
		end
	end
end


function CompactComboBar_FrameHeight()
	local bars = 5;
	local height = 58;

	if (CompactComboBar_Config[User].hidecombo or CCB_NoRogue) then bars=bars-1; end
	if (CompactComboBar_Config[User].hidetargethealth) then bars=bars-1; end
	if (CompactComboBar_Config[User].hidetargetmana or UnitManaMax("target") == 0) then bars=bars-1; end
	if (CompactComboBar_Config[User].hidehealth) then bars=bars-1; end
	if (CompactComboBar_Config[User].hideenergy) then bars=bars-1; end

	height = (bars * 10) + 8;
	if (height == 8) then height = 58; end

	return height;
end


function CompactComboBar_ArrangeBars()
	if (CompactComboBarFrame:IsVisible()) then
		local y = -1;

		-- CompactComboBar_Debug(CCB_SPLASH.." arranging bars..");

		if ( not CompactComboBar_Config[User].hidecombo and not CCB_NoRogue ) then
			local i = 0;
        		local width = 3;
        		for i = 1, 5 do
            			local obj = getglobal("CompactBorder" .. i);
            			obj:SetPoint("TOPLEFT", "CompactComboBarFrame", "TOPLEFT", width, y);

            			obj = getglobal("CompactBorder" .. i .. "Texture");
            			obj:SetPoint("TOPLEFT", "CompactBorder" .. i, "TOPLEFT", width, y);

            			obj = getglobal("CompactCombo" .. i);
            			obj:SetPoint("TOPLEFT", "CompactBorder" .. i, "TOPLEFT", width+2, y-2);

            			width = width + 10;
        		end
        		-- CompactComboBar_Debug(CCB_SPLASH.." ComboPoints   y == " ..y);
        		y=y-5;
		end

		if ( not CompactComboBar_Config[User].hidetargethealth ) then
			CompactBorderTargetHealth:SetPoint("TOPLEFT", "CompactComboBarFrame", "TOPLEFT", 2, y);
        		CompactBorderTargetHealthTexture:SetPoint("TOPLEFT", "CompactBorderTargetHealth", "TOPLEFT", 2, y);
        		CompactTargetHealthText:SetPoint("CENTER", "CompactBorderTargetHealth", "CENTER", 2, y);
        		CompactTargetHealthBar:SetPoint("TOPLEFT", "CompactBorderTargetHealth", "TOPLEFT", 4, y-2);
        		-- CompactComboBar_Debug(CCB_SPLASH.." TargetHealth   y == " ..y);
        		y=y-5;
       		end

		if ( not CompactComboBar_Config[User].hidetargetmana and UnitManaMax("target") > 0 ) then
			CompactBorderTargetMana:SetPoint("TOPLEFT", "CompactComboBarFrame", "TOPLEFT", 2, y);
        		CompactBorderTargetManaTexture:SetPoint("TOPLEFT", "CompactBorderTargetMana", "TOPLEFT", 2, y);
        		CompactTargetManaText:SetPoint("CENTER", "CompactBorderTargetMana", "CENTER", 2, y);
        		CompactTargetManaBar:SetPoint("TOPLEFT", "CompactBorderTargetMana", "TOPLEFT", 4, y-2);
        		-- CompactComboBar_Debug(CCB_SPLASH.." TargetMana   y == " ..y);
			y=y-5;
		end

		if ( not CompactComboBar_Config[User].hidehealth ) then
			CompactBorderHealth:SetPoint("TOPLEFT", "CompactComboBarFrame", "TOPLEFT", 2, y);
        		CompactBorderHealthTexture:SetPoint("TOPLEFT", "CompactBorderHealth", "TOPLEFT", 2, y);
        		CompactHealthText:SetPoint("CENTER", "CompactBorderHealth", "CENTER", 2, y);
        		CompactHealthBar:SetPoint("TOPLEFT", "CompactBorderHealth", "TOPLEFT", 4, y-2);
        		-- CompactComboBar_Debug(CCB_SPLASH.." Health   y == " ..y);
        		y=y-5;
		end

		if ( not CompactComboBar_Config[User].hideenergy ) then
			CompactBorderEnergy:SetPoint("TOPLEFT", "CompactComboBarFrame", "TOPLEFT", 2, y);
        		CompactBorderEnergyTexture:SetPoint("TOPLEFT", "CompactBorderEnergy", "TOPLEFT", 2, y);
        		CompactEnergyText:SetPoint("CENTER", "CompactBorderEnergy", "CENTER", 2, y);
        		CompactEnergyBar:SetPoint("TOPLEFT", "CompactBorderEnergy", "TOPLEFT", 4, y-2);
        		-- CompactComboBar_Debug(CCB_SPLASH.." Energy   y == " ..y);
		end
	end
end


function CompactComboBar_UpdateComboBar()
	if (CompactComboBarFrame:IsVisible()) then
		local mainframe = getglobal("CompactComboBarFrame");
		mainframe:SetHeight(CompactComboBar_FrameHeight());

		local combo = GetComboPoints();
		local combobar = {0, 0, 0, 0, 0};
		local barcolor = {[0] = {1, 1, 1}, {0, 1, 0}, {0.5, 1, 0}, {1, 1, 0}, {1, 0.5, 0}, {1, 0, 0}};

		if ( CompactComboBar_Config[User].hidecombo or CCB_NoRogue ) then
        		for i = 1, 5 do
        	    	local barname = getglobal("CompactBorder" .. i);
        	    	barname:Hide();
        	    	barname = getglobal("CompactBorder" .. i .. "Texture");
        	    	barname:Hide();
        	    	barname = getglobal("CompactCombo" .. i);
        	    	barname:Hide();
	        	end
		else
			for i = 1, 5 do
        	    	local barname = getglobal("CompactBorder" .. i);
        	    	barname:Show();
        	    	barname = getglobal("CompactBorder" .. i .. "Texture");
        	    	barname:Show();
        	    	barname = getglobal("CompactCombo" .. i);
        	    	barname:Show();
        		end
		end

		if (CompactComboBar_Config[User].cpcolor) then
			barcolor = {[0] = {1, 1, 1}, {0, 1, 0}, {0.5, 1, 0}, {1, 1, 0}, {1, 0.5, 0}, {1, 0, 0}};
		else
			barcolor = {[0] = {1, 0, 0}, {1, 0, 0}, {1, 0, 0}, {1, 0, 0}, {1, 0, 0}, {1, 0, 0}};
		end

		for i = 1, combo, 1 do
			combobar[i] = 1;
		end
		for i = 1, 5, 1 do
			local barname = getglobal("CompactCombo"..i);
			barname:SetStatusBarColor(barcolor[combo][1], barcolor[combo][2], barcolor[combo][3]);
			barname:SetValue(combobar[i]);
		end

		CompactComboBar_ArrangeBars();
	end;
end


function CompactComboBar_UpdateTargetHealthBar()
	if (CompactComboBarFrame:IsVisible()) then
		local TargetHealthMin = 0; -- Not of any use yet...
		local TargetHealthMax = 0;
		local TargetHealth = 0;
		local index;

		if ( CompactComboBar_Config[User].hidetargethealth ) then
			local mainframe = getglobal("CompactComboBarFrame");
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactTargetHealthBar:Hide();
			CompactBorderTargetHealthTexture:Hide();
			CompactTargetHealthText:SetText("");

			CompactComboBar_ArrangeBars();
		else
			local mainframe = getglobal("CompactComboBarFrame");
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactTargetHealthBar:Show();
			CompactBorderTargetHealthTexture:Show();

			if ( UnitExists("target") ) then

    				TargetHealth = UnitHealth("target");
	    			TargetHealthMax = UnitHealthMax("target");

				if (TargetHealthMax ~= 100) then
					-- CompactComboBar_Debug(CCB_SPLASH.." TargetHealthMax: "..TargetHealthMax);
					local percent = ((TargetHealth/TargetHealthMax)*100);
					if ( CompactComboBar_Config[User].hptbartext == 1) then
						CompactTargetHealthText:SetText(TargetHealth.."/"..TargetHealthMax);
					elseif ( CompactComboBar_Config[User].hptbartext == 2 ) then
						CompactTargetHealthText:SetText(TargetHealth.."/"..TargetHealthMax.." "..string.format("%d",percent).."%");
					elseif ( CompactComboBar_Config[User].hptbartext  == 3 ) then
						CompactTargetHealthText:SetText(string.format("%d",percent).."% "..TargetHealth.."/"..TargetHealthMax);
					end
				else
					-- MobHealth Stuff

					if ( MobHealth3 ) then
						local cur, max = MobHealth3:GetUnitHealth("target", TargetHealth, TargetHealthMax);
						local percent = ((TargetHealth/TargetHealthMax)*100);
						if ( CompactComboBar_Config[User].hptbartext == 1) then
							CompactTargetHealthText:SetText(string.format("%d", cur).."/"..string.format("%d", max));
						elseif ( CompactComboBar_Config[User].hptbartext == 2) then
							CompactTargetHealthText:SetText(string.format("%d", cur).."/"..string.format("%d", max).." "..string.format("%d",percent).."%");
						elseif ( CompactComboBar_Config[User].hptbartext == 3) then
							CompactTargetHealthText:SetText(string.format("%d",percent).."% "..string.format("%d", cur).."/"..string.format("%d", max));
						end
						-- CompactComboBar_Debug(CCB_SPLASH.." using MH3 current values.  cur: "..cur.."  max: "..max);

					elseif (( MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
						local s, e;
						local pts;
						local pct;

						if UnitIsPlayer("target") then
							index = UnitName("target");
						else
							index = UnitName("target")..":"..UnitLevel("target");
						end

						if MobHealthDB[index] then
							if ( type(MobHealthDB[index]) ~= "string" ) then
								CompactTargetHealthText:SetText(TargetHealth.."%..");
							end
							s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
						else
							if ( type(MobHealthPlayerDB[index]) ~= "string" ) then
								CompactTargetHealthText:SetText(TargetHealth.."%");
							end
							s, e, pts, pct = string.find(MobHealthPlayerDB[index], "^(%d+)/(%d+)$");
						end

						if ( pts and pct ) then
							pts = pts + 0;
							pct = pct + 0;
							if( pct ~= 0 ) then
								pointsPerPct = pts / pct;
							else
								pointsPerPct = 0;
							end
						end

						local currentPct = UnitHealth("target");

						if ( pointsPerPct > 0 ) then
							if ( CompactComboBar_Config[User].hptbartext == 1) then
								CompactTargetHealthText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
							elseif ( CompactComboBar_Config[User].hptbartext == 2) then
							CompactTargetHealthText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5).." "..currentPct.."%");
							elseif ( CompactComboBar_Config[User].hptbartext == 3) then
								CompactTargetHealthText:SetText(currentPct.."% "..string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
							end
						end
						-- CompactComboBar_Debug(CCB_SPLASH.." using MH-DB values.");

					else
						CompactTargetHealthText:SetText(TargetHealth.."%");
						-- CompactComboBar_Debug(CCB_SPLASH.." not using MH.");
					end
				end

				if (TargetHealth <= 0) then
					CompactTargetHealthText:SetText("Dead"); -- Unit is Dead (Mob)
				elseif ((TargetHealth == 1) and ((TargetHealthMax > 1) and (TargetHealthMax ~= 100))) then
					CompactTargetHealthText:SetText("Ghost"); -- Unit is Dead (Player)
				end

			else
				CompactTargetHealthText:SetText("No Target");
			end

			CompactComboBar_ArrangeBars();

			CompactTargetHealthBar:SetMinMaxValues(TargetHealthMin, TargetHealthMax);
			CompactTargetHealthBar:SetValue(TargetHealth);
			if (not CompactComboBar_Config[User].text) then
				CompactTargetHealthText:SetText("");
			end
		end
	end
end


function CompactComboBar_UpdateTargetManaBar()
	if (CompactComboBarFrame:IsVisible()) then
		local TargetManaType = 0; -- Used if we want to colorize the bar to appropiate mana type color (rage = red, energy = yellow...)
		local TargetManaMax = 0;
		local TargetMana = 0;
		local mainframe = getglobal("CompactComboBarFrame");

		TargetManaType = UnitPowerType("target");
		TargetMana = UnitMana("target");
		TargetManaMax = UnitManaMax("target");
		if ( CompactComboBar_Config[User].powcolor ) then
			if ( TargetManaType == 1) then -- Rage
				CompactTargetManaBar:SetStatusBarColor(1, 0 ,0);
			elseif ( TargetManaType == 2) then -- Focus
				CompactTargetManaBar:SetStatusBarColor(1, 0.5 ,0);
			elseif ( TargetManaType == 3) then -- Energy
				CompactTargetManaBar:SetStatusBarColor(1, 1 ,0);
			else -- Mana
				CompactTargetManaBar:SetStatusBarColor(0, 0 ,1);
			end
		else
			CompactTargetManaBar:SetStatusBarColor(0, 0 ,1);
		end

		if ( CompactComboBar_Config[User].hidetargetmana or TargetManaMax == 0 ) then
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactTargetManaBar:Hide();
			CompactBorderTargetManaTexture:Hide();
			CompactTargetManaText:SetText("");

			CompactComboBar_ArrangeBars();

		elseif ( (TargetManaMax > 0)  and not (UnitIsDead("target")) and not (UnitIsGhost("target")) ) then
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactTargetManaBar:Show();
			CompactBorderTargetManaTexture:Show();
			CompactTargetManaBar:SetMinMaxValues(0, TargetManaMax);
			CompactTargetManaBar:SetValue(TargetMana);

			CompactComboBar_ArrangeBars();

			if ( CompactComboBar_Config[User].text ) then
				CompactTargetManaText:SetText(TargetMana.."/"..TargetManaMax);
			else
				CompactTargetManaText:SetText("");
			end
		end
	end
end


function CompactComboBar_UpdateHealthBar()
	if (CompactComboBarFrame:IsVisible()) then
		if ( CompactComboBar_Config[User].hidehealth ) then
			local mainframe = getglobal("CompactComboBarFrame");
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactHealthBar:Hide();
			CompactBorderHealthTexture:Hide();
			CompactHealthText:SetText("");

			CompactComboBar_ArrangeBars();
		else
			local mainframe = getglobal("CompactComboBarFrame");
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactHealthBar:Show();
			CompactBorderHealthTexture:Show();

			local value, max = UnitHealth("player"), UnitHealthMax("player");
			local healthcolor;
			local healthtext;
			local percent;
			if (not CompactComboBar_Config[User].hpcolor) then
				healthcolor = {0, 1, 0};
			else
				if ((value / max) <= 0.1) then
						healthcolor = {1, 0, 0};
					elseif ((value / max) >= 0.9) then
						healthcolor = {0, 1, 0};
					else
						healthcolor = {1 - ((value / max) - 0.1) / 0.8, ((value / max) - 0.1) / 0.8, 0};
				end
			end
			local healthbar = getglobal("CompactHealthBar");
			healthbar:SetStatusBarColor(healthcolor[1], healthcolor[2], healthcolor[3]);
			healthbar:SetMinMaxValues(0, max);
			healthbar:SetValue(value);
			percent = ( (value / max) * 100 );
			if ( CompactComboBar_Config[User].hppbartext == 1 ) then
				healthtext = value.."/"..max;
			elseif ( CompactComboBar_Config[User].hppbartext == 2 ) then
				healthtext = value.."/"..max..string.format(" %d", percent).."%";
			elseif ( CompactComboBar_Config[User].hppbartext == 3 ) then
				healthtext = string.format("%d", percent).."% "..value.."/"..max;
			end
			if ( CompactComboBar_Config[User].text ) then
				CompactHealthText:SetText(healthtext);
			else
				CompactHealthText:SetText("");
			end

			CompactComboBar_ArrangeBars();
		end
	end
end


function CompactComboBar_UpdateEnergyBar()
	if (CompactComboBarFrame:IsVisible()) then
		if ( CompactComboBar_Config[User].hideenergy ) then
			local mainframe = getglobal("CompactComboBarFrame");
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactEnergyBar:Hide();
			CompactBorderEnergyTexture:Hide();
			CompactEnergyText:SetText("");

			CompactComboBar_ArrangeBars();
		else
			local mainframe = getglobal("CompactComboBarFrame");
			mainframe:SetHeight(CompactComboBar_FrameHeight());

			CompactEnergyBar:Show();
			CompactBorderEnergyTexture:Show();


			local value, max = UnitMana("player"), UnitManaMax("player");
			local PlayerPowerType = UnitPowerType("player");
			local energybar = getglobal("CompactEnergyBar");

			energybar:SetMinMaxValues(0, max);
			energybar:SetValue(value);

			if ( PlayerPowerType == 1) then -- Rage
				energybar:SetStatusBarColor(1,0,0);
			elseif ( PlayerPowerType == 2) then -- Focus
				energybar:SetStatusBarColor(1,0.5,0);
			elseif ( PlayerPowerType == 3) then -- Energy
				energybar:SetStatusBarColor(1,1,0);
			else -- Mana
				energybar:SetStatusBarColor(0,0,1);
			end

			local energytext;
			if (CompactComboBar_Config[User].energytext == 1) then
				energytext = value.."/"..max;
			elseif ( CompactComboBar_Config[User].energytext == 2) then
				energytext = value;
			end

			if (CompactComboBar_Config[User].text) then
				CompactEnergyText:SetText(energytext);
			else
				CompactEnergyText:SetText("");
			end

			CompactComboBar_ArrangeBars();
		end
	end
end


function CompactComboBar_OnEvent(event)
	if (event == "PLAYER_COMBO_POINTS") then
		CompactComboBar_UpdateComboBar();

	elseif ((event == "UNIT_HEALTH") or (event == "UNIT_MAXHEALTH")) then
		if arg1 == "player" then
			CompactComboBar_UpdateHealthBar();
		elseif arg1 == "target" then
			CompactComboBar_UpdateTargetHealthBar();
		end

	elseif ((event == "UNIT_MANA") or (event == "UNIT_MAXMANA") or (event == "UNIT_RAGE") or (event == "UNIT_MAXRAGE") or (event == "UNIT_ENERGY") or (event == "UNIT_MAXENERGY") or (event == "UNIT_FOCUS") or (event == "UNIT_MAXFOCUS")) then
		CompactComboBar_UpdateTargetManaBar();
		CompactComboBar_UpdateEnergyBar();

	elseif (event == "PLAYER_REGEN_DISABLED") then
		CCB_InCombat = true;
		CompactComboBar_Switch();

	elseif (event == "PLAYER_REGEN_ENABLED") then
		CCB_InCombat = false;
		CompactComboBar_Switch();

	elseif ((event == "UNIT_AURA") and (arg1 == "player")) then
		CompactComboBar_Switch();

	elseif (event == "PLAYER_AURAS_CHANGED") then
		CompactComboBar_Switch();

	elseif (event == "PLAYER_TARGET_CHANGED") then
		CompactComboBar_UpdateTargetHealthBar();
		CompactComboBar_UpdateTargetManaBar();

	elseif (event == "VARIABLES_LOADED") then
		CCB_PlayerClass,CCB_PlayerClassUS = UnitClass("player");
		CompactComboBar_Initialize();

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if ((CCB_PlayerClassUS == "ROGUE") or (CCB_PlayerClassUS == "DRUID")) then
			CCB_Enable = true;
			CompactComboBar_UpdateTargetHealthBar();
			CompactComboBar_UpdateTargetManaBar();
			CompactComboBar_UpdateHealthBar();
			CompactComboBar_UpdateEnergyBar();
			this:UnregisterEvent("PLAYER_ENTERING_WORLD");
			local frame = getglobal("CompactComboBarFrame");
			frame:SetScale(CompactComboBar_Config[User].size);
			frame:ClearAllPoints();
			frame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",CompactComboBar_Config[User].posx*CompactComboBar_Config[User].size,CompactComboBar_Config[User].posy*CompactComboBar_Config[User].size);
			CompactComboBar_Switch();
			CompactComboBar_UpdateComboBar();
		else
			CCB_Enable = true;
			CCB_NoRogue = true;
			CompactComboBar_UpdateTargetHealthBar();
			CompactComboBar_UpdateTargetManaBar();
			CompactComboBar_UpdateHealthBar();
			CompactComboBar_UpdateEnergyBar();
			this:UnregisterEvent("PLAYER_ENTERING_WORLD");
			this:UnregisterEvent("PLAYER_COMBO_POINTS");
			local frame = getglobal("CompactComboBarFrame");
			frame:SetScale(CompactComboBar_Config[User].size);
			frame:ClearAllPoints();
			frame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",CompactComboBar_Config[User].posx*CompactComboBar_Config[User].size,CompactComboBar_Config[User].posy*CompactComboBar_Config[User].size);
			CompactComboBar_Switch();
			CompactComboBar_UpdateComboBar();
		end
	end
end
