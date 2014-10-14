--[[

	Class Viewer: Shows the class of the player selected or the type of monster/npc
	
	Made by: Edswor
	
	Commands: /classviewer  or  /cv

]]

--------------------------------------------------------------------------------------------------
-- Other variables
--------------------------------------------------------------------------------------------------

local classPlayer = "";
local alreadyInitialized = 0;

--------------------------------------------------------------------------------------------------
-- OnLoad, Initialize
--------------------------------------------------------------------------------------------------

function ClassV_OnLoad()
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");

	SLASH_CLASSV1 = "/classviewer";
	SLASH_CLASSV2 = "/clv";
	SlashCmdList["CLASSV"] = ClassV_ShowOptions;

	if ( ClassV_Save == nil ) then
		ClassV_Initialize()
	elseif( ClassV_Save["Version"] == nil or ClassV_Save["Version"] ~= CLASSV_VERSION) then
		ClassV_Initialize()
	end

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Class Viewer|r, made by: |cffff3300Edswor|r, Version: |cffffff00"..CLASSV_VERSION.."|r, loaded.");
	end
end

function ClassV_Initialize()
	ClassV_Save = {
		["Version"] = CLASSV_VERSION,
		["Locked"] = 0,
		["NoTarget"] = 0,
		["Player"] = 0,
		["NPC"] = 0,
		["Monster"] = 0,
		["Unknown"] = 0,
		["Tooltip"] = 1
	};
end

--------------------------------------------------------------------------------------------------
-- ShowOptions, HideOptions, Toggle();
--------------------------------------------------------------------------------------------------

function ClassV_ShowOptions()
	ShowUIPanel(ClassVOptionsFrame);
end

function ClassV_HideOptions()
	HideUIPanel(ClassVOptionsFrame);
end

function ClassV_Toggle()
	if(ClassVOptionsFrame:IsVisible()) then
		HideUIPanel(ClassVOptionsFrame);
	else
		ShowUIPanel(ClassVOptionsFrame);
	end
end

--------------------------------------------------------------------------------------------------
-- Set, Get
--------------------------------------------------------------------------------------------------

function ClassV_Get(option)
	if (ClassV_Save[option] ~= nil) then
		return ClassV_Save[option];
	end
end

function ClassV_Set(option, val)
	if (ClassV_Save ~= nil) then
		if ( option ) then
			ClassV_Save[option] = val;
		end
	end
end

--------------------------------------------------------------------------------------------------
-- OnUpdate, OnEvent, OnDragStart, OnDragStop
--------------------------------------------------------------------------------------------------

function ClassV_OnUpdate(arg1)
	if ( not UnitExists("target") ) then
		if( ClassVFrame:IsVisible() and ClassV_Get("NoTarget")==0 ) then
			HideUIPanel(ClassVFrame);
		end
	end
end

function ClassV_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
 		if(myAddOnsFrame) then
			myAddOnsList.HelloWorld = {name = "ClassViewer", description = "Shows the class of the player selected or the type of monster/npc.", version = "1.3", category = MYADDONS_CATEGORY_COMBAT, frame = "ClassVFrame", optionsframe = "ClassVOptionsFrame"};
		end
		return;
	end
	if( event == "PLAYER_TARGET_CHANGED" ) then
		local type = 0;	
		if(UnitName("target") and UnitIsPlayer("target")) then
			classPlayer = UnitClass("target");
			type = 1;
			if (classPlayer==CLASSV_SHAMAN) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Shaman");
			elseif (classPlayer==CLASSV_DRUID) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Druid");
			elseif (classPlayer==CLASSV_HUNTER) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Hunter");
			elseif (classPlayer==CLASSV_MAGE) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Mage");
			elseif (classPlayer==CLASSV_PALADIN) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Paladin");
			elseif (classPlayer==CLASSV_PRIEST) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Priest");
			elseif (classPlayer==CLASSV_ROGUE) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Rogue");
			elseif (classPlayer==CLASSV_WARLOCK) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Warlock");
			elseif (classPlayer==CLASSV_WARRIOR) then
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Warrior");
			end
		elseif ( UnitCreatureType("target") ) then
			if( UnitCanAttack("player","target") ) then
				classPlayer = UnitCreatureType("target");
				type = 3;
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Infernal");
			else
				--classPlayer = UnitCreatureType("target");
				classPlayer = "NPC or Neutral";
				type = 2;
				ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Gryphon");
			end
		else
			classPlayer="Unknown";
			type = 0;
			ClassName:SetTexture("Interface\\AddOns\\ClassViewer\\ClassIcons\\Unknown");
		end
		if( not ClassVFrame:IsVisible() ) then
			if ( type ==1 and ClassV_Get("Player")==1 ) then
				ShowUIPanel(ClassVFrame);
			elseif  ( type==2 and ClassV_Get("NPC")==1 ) then
				ShowUIPanel(ClassVFrame);
			elseif  ( type==3 and ClassV_Get("Monster")==1 ) then
				ShowUIPanel(ClassVFrame);
			elseif  ( type==0 and ClassV_Get("Unknown")==1 ) then
				ShowUIPanel(ClassVFrame);
			end
		end
		if( ClassVFrame:IsVisible() ) then
			if ( type==1 and ClassV_Get("Player")==0 ) then
				HideUIPanel(ClassVFrame);
			elseif  ( type==2 and ClassV_Get("NPC")==0 ) then
				HideUIPanel(ClassVFrame);
			elseif  ( type==3 and ClassV_Get("Monster")==0 ) then
				HideUIPanel(ClassVFrame);
			elseif  ( type==0 and ClassV_Get("Unknown")==0 ) then
				HideUIPanel(ClassVFrame);
			end
		end
		return;	
	end
end


function ClassV_OnDragStart()
	if(ClassV_Get("Locked")==0 and ClassVFrame:IsVisible()) then
		ClassVFrame:StartMoving();
	end
end

function ClassV_OnDragStop()
	if(ClassV_Get("Locked")==0 and ClassVFrame:IsVisible()) then
		ClassVFrame:StopMovingOrSizing();
	end
end

--------------------------------------------------------------------------------------------------
-- OnEnter
--------------------------------------------------------------------------------------------------

function ClassV_OnEnter()
	if( ClassVFrame:IsVisible() and ClassV_Get("Tooltip")==1 ) then
		GameTooltip:SetOwner(ClassVFrame, "ANCHOR_CURSOR");
		
		local text = "|cff00ff00"..classPlayer.."|r\n";

		local MainhandSpeed, OffhandSpeed = UnitAttackSpeed("target");		
		local speedText = "|cffffffffSpeed:|r ";
		if (MainhandSpeed and MainhandSpeed ~= 0) then
			text = text..speedText.."|cffff0000"..string.sub(MainhandSpeed, 1, 4).."|r";	
		end

		GameTooltip:SetText(text);
	end
end
