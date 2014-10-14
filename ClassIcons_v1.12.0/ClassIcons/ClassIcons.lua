-- Global variables
CLASSICONS_VERSION = "1.1.0";

function ClassIcons_OnLoad()

	-- Set up slash commands
	SlashCmdList["CLASSICONS"] = ClassIcons_CmdHandler;
	SLASH_CLASSICONS1 = "/classicons";
	SLASH_CLASSICONS2 = "/ci";

	-- Register for events
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");

end

function ClassIcons_Print(msg, header)

	if ( msg == nil ) then
		msg = "nil";
	end

	if ( header == nil ) then
		header = true;
	end

	if ( header == true ) then
		msg = "[ClassIcons] "..msg;
	end

	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 0.5, 0.5, 1.0);
	end

end

function Ternary(condition, valtrue, valfalse)

	if ( condition ) then
		return valtrue;
	else
		return valfalse;
	end
	
end

function ClassIcons_CmdHandler(msg)

	msg = strlower(msg);
	local _, _, cmd, arg1, arg2 = string.find(msg, "(%w+)[ ]?(%w*)[ ]?([-%w]*)");

	if ( cmd == "on" ) then
		CLASSICONS_CONFIG.Active = true;
		ClassIcons_Print("Activated.");

		ClassIcons_OnEvent("PLAYER_ENTERING_WORLD");
		ClassIcons_OnEvent("PLAYER_TARGET_CHANGED");
		ClassIcons_OnEvent("PARTY_MEMBERS_CHANGED");

		return;
	end

	if ( cmd == "off" ) then
		CLASSICONS_CONFIG.Active = false;
		ClassIcons_Print("Deactivated.");

		ClassIcons_OnEvent("PLAYER_ENTERING_WORLD");
		ClassIcons_OnEvent("PLAYER_TARGET_CHANGED");
		ClassIcons_OnEvent("PARTY_MEMBERS_CHANGED");

		return;
	end

	if ( cmd == "player" ) then

		if ( arg1 == "on" ) then
			CLASSICONS_CONFIG.Player = true;
		elseif ( arg1 == "off" ) then
			CLASSICONS_CONFIG.Player = false;
		else
			CLASSICONS_CONFIG.Player = not CLASSICONS_CONFIG.Player;
		end

		ClassIcons_Print("Player icon "..Ternary(CLASSICONS_CONFIG.Player, "on.", "off."));

		ClassIcons_OnEvent("PLAYER_ENTERING_WORLD");

		return;
	end

	if ( cmd == "target" ) then

		if ( arg1 == "on" ) then
			CLASSICONS_CONFIG.Target = true;
		elseif ( arg1 == "off" ) then
			CLASSICONS_CONFIG.Target = false;
		else
			CLASSICONS_CONFIG.Target = not CLASSICONS_CONFIG.Target;
		end

		ClassIcons_Print("Target icon "..Ternary(CLASSICONS_CONFIG.Target, "on.", "off."));

		ClassIcons_OnEvent("PLAYER_TARGET_CHANGED");

		return;
	end

	if ( cmd == "party" ) then

		if ( arg1 == "on" ) then
			CLASSICONS_CONFIG.Party = true;
		elseif ( arg1 == "off" ) then
			CLASSICONS_CONFIG.Party = false;
		else
			CLASSICONS_CONFIG.Party = not CLASSICONS_CONFIG.Party;
		end

		ClassIcons_Print("Party icons "..Ternary(CLASSICONS_CONFIG.Party, "on.", "off."));

		ClassIcons_OnEvent("PARTY_MEMBERS_CHANGED");

		return;
	end

	if ( cmd == "angle" ) then

		arg2 = tonumber(arg2);

		if ( arg2 == nil ) or ( arg2 < 0 ) or ( arg2 > 359 ) then
			ClassIcons_Print("Please enter a number between 0 and 359.");
			return;
		end

		if ( arg1 == "player" ) then
			CLASSICONS_CONFIG.PlayerAngle = arg2;
		elseif ( arg1 == "target" ) then
			CLASSICONS_CONFIG.TargetAngle = arg2;
		elseif ( arg1 == "party" ) then
			CLASSICONS_CONFIG.PartyAngle = arg2;
		else
			ClassIcons_Print("Please enter one of player / party / target.");
			return;
		end

		ClassIcons_UpdateIconPositions();

		return;

	end
	
	if ( cmd == "mobsuse" ) then

		if ( arg1 == "class" ) or ( arg1 == "type" ) or ( arg1 == "none" ) then
			CLASSICONS_CONFIG.MobsUse = arg1;
		else
			ClassIcons_Print("Please enter one of class, type, or none.");
			return;
		end

		ClassIcons_Print("Mob icons set to use "..CLASSICONS_CONFIG.MobsUse);

		ClassIcons_OnEvent("PLAYER_TARGET_CHANGE");

		return;

	end

	-- Unknown command input, print usage statement

	ClassIcons_Print("Command list: ");
	ClassIcons_Print("on/off - control all icon visibility.", false);
	ClassIcons_Print("player/party/target [on/off] - control individual icon visibility.", false);
	ClassIcons_Print("angle [player/party/target] [number] - control the angle icons are set to.", false);
	ClassIcons_Print("mobsuse [class/type/none] - control whether monster icons display class, type, or are hidden.", false);

end

function ClassIcons_UpdateIcon(frame, unit, setting)

	if ( not frame ) or ( not unit ) then
		return;
	end

	local icon = getglobal(frame.."ClassIcon");
	local texture = getglobal(frame.."ClassIconTexture");

	if ( not icon ) or ( not texture ) then
		return;
	end
	
	local UnitIsMob = not UnitIsPlayer(unit);

	if ( CLASSICONS_CONFIG.Active == false ) or ( setting == false ) or ( ( CLASSICONS_CONFIG.MobsUse == "none" ) and UnitIsMob )then
		if icon:IsVisible() then icon:Hide(); end
		return;
	end

	local _, texturefile = UnitClass(unit);

	if ( UnitIsMob ) and ( CLASSICONS_CONFIG.MobsUse == "type" ) then
		texturefile = UnitCreatureType(unit);
	end

	if ( not texturefile ) or ( texturefile == "Not specified" ) then
		texturefile = "UNKNOWN";
	end

	if ( not icon:IsVisible() ) then
		icon:Show();
	end

	texture:SetTexture("Interface\\AddOns\\ClassIcons\\Icons\\"..texturefile..".tga");

end

function ClassIcons_UpdateIconPositions()

	local framecenterx, framecentery, offsetx, offsety;

	framecenterx = 78;
	framecentery = -12;
	offsetx = ceil(32*cos(CLASSICONS_CONFIG.PlayerAngle));
	offsety = ceil(32*sin(CLASSICONS_CONFIG.PlayerAngle));

	PlayerFrameClassIcon:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", framecenterx+offsetx-16, framecentery+offsety-16);


	framecenterx = -78;
	framecentery = -12;
	offsetx = ceil(32*cos(CLASSICONS_CONFIG.TargetAngle));
	offsety = ceil(32*sin(CLASSICONS_CONFIG.TargetAngle));

	TargetFrameClassIcon:SetPoint("TOPRIGHT", "TargetFrame", "TOPRIGHT", framecenterx+offsetx+16, framecentery+offsety-16);


	framecenterx = 25;
	framecentery = -5;
	offsetx = ceil(20*cos(CLASSICONS_CONFIG.PartyAngle));
	offsety = ceil(20*sin(CLASSICONS_CONFIG.PartyAngle));

	PartyMemberFrame1ClassIcon:SetPoint("TOPLEFT", "PartyMemberFrame1", "TOPLEFT", framecenterx+offsetx-10, framecentery+offsety-10);
	PartyMemberFrame2ClassIcon:SetPoint("TOPLEFT", "PartyMemberFrame2", "TOPLEFT", framecenterx+offsetx-10, framecentery+offsety-10);
	PartyMemberFrame3ClassIcon:SetPoint("TOPLEFT", "PartyMemberFrame3", "TOPLEFT", framecenterx+offsetx-10, framecentery+offsety-10);
	PartyMemberFrame4ClassIcon:SetPoint("TOPLEFT", "PartyMemberFrame4", "TOPLEFT", framecenterx+offsetx-10, framecentery+offsety-10);

end

function ClassIcons_OnEvent(event)

	if ( event == "VARIABLES_LOADED" ) then

		if ( CLASSICONS_CONFIG == nil ) then
			CLASSICONS_CONFIG = { };
		end

		if ( CLASSICONS_CONFIG.Active == nil ) then
			CLASSICONS_CONFIG.Active = true;
		end

		if ( CLASSICONS_CONFIG.Player == nil ) then
			CLASSICONS_CONFIG.Player = true;
		end

		if ( CLASSICONS_CONFIG.Party == nil ) then
			CLASSICONS_CONFIG.Party = true;
		end

		if ( CLASSICONS_CONFIG.Target == nil ) then
			CLASSICONS_CONFIG.Target = true;
		end
		
		if ( CLASSICONS_CONFIG.MobsUse == nil ) then
			CLASSICONS_CONFIG.MobsUse = "type";
		end

		if ( CLASSICONS_CONFIG.PlayerAngle == nil ) then
			CLASSICONS_CONFIG.PlayerAngle = 45;
		end

		if ( CLASSICONS_CONFIG.PartyAngle == nil ) then
			CLASSICONS_CONFIG.PartyAngle = 45;
		end

		if ( CLASSICONS_CONFIG.TargetAngle == nil ) then
			CLASSICONS_CONFIG.TargetAngle = 135;
		end

		ClassIcons_UpdateIconPositions();

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then

		ClassIcons_UpdateIcon("PlayerFrame", "player", CLASSICONS_CONFIG.Player);

	elseif ( event == "PLAYER_TARGET_CHANGED" ) then

		ClassIcons_UpdateIcon("TargetFrame", "target", CLASSICONS_CONFIG.Target);

	elseif ( event == "PARTY_MEMBERS_CHANGED" ) or
		   ( event == "PARTY_MEMBER_ENABLE"   ) then

		ClassIcons_UpdateIcon("PartyMemberFrame1", "party1", CLASSICONS_CONFIG.Party);
		ClassIcons_UpdateIcon("PartyMemberFrame2", "party2", CLASSICONS_CONFIG.Party);
		ClassIcons_UpdateIcon("PartyMemberFrame3", "party3", CLASSICONS_CONFIG.Party);
		ClassIcons_UpdateIcon("PartyMemberFrame4", "party4", CLASSICONS_CONFIG.Party);

	end

end

function ClassIcons_Icon_OnLoad()
	this:SetFrameLevel(this:GetFrameLevel()+2);
end

