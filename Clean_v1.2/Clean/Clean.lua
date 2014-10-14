C = {}

-- This value most be the heigest Button id

local C_Ant_Frames = 10;

function C_OnLoad()
	ChatFrame1:AddMessage("Clean is loaded", 1.0, 1.0, 0.0, 1.0);	
	
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("ADDON_LOADED");
	
	SLASH_Clean1 = "/clean"; 
	SlashCmdList["Clean"] = function (msg)
		Clean_Slash(msg);
	end
	
end

function Clean_Slash(msg)
	msg = string.lower(msg)
	
	if (msg =="close") then
		for i=1, C_Ant_Frames, 1 do
				C.Frame[i] = false;
				getglobal("CleanButton"..i):SetChecked(C.Frame[i]);
		end
		C_MouseOver();
	elseif (msg =="open") then
		for i=1, C_Ant_Frames, 1 do
				C.Frame[i] = true;
				getglobal("CleanButton"..i):SetChecked(C.Frame[i]);
		end
		C_MouseOver();
	elseif (msg =="lock") then
			C.Lock = true;
		
			C.Locked = {}
			for i=1, C_Ant_Frames, 1 do
				C.Locked[i] = C.Frame[i];
			end
			ChatFrame1:AddMessage("Clean: Frames are locked" , 1.0, 1.0, 0.0, 1.0);	
	elseif (msg =="unlock") then		
			C.Lock = false;
			ChatFrame1:AddMessage("Clean: Frames are unlocked" , 1.0, 1.0, 0.0, 1.0);	
	elseif (msg =="casting") then
	--	if (C.CastingBar == false) then
	--		C.CastingBar = true;
	--		ChatFrame1:AddMessage("Clean: CastingBarFrame is now shown" , 1.0, 1.0, 0.0, 1.0);	
	--	else
	--		C.CastingBar = false;
	--		ChatFrame1:AddMessage("Clean: CastingBarFrame is now hidden" , 1.0, 1.0, 0.0, 1.0);	
	--	end
	elseif (msg =="button") then
		if (C.Button == false) then
			C.Button = true;
			ChatFrame1:AddMessage("Clean: Checkbox is now shown" , 1.0, 1.0, 0.0, 1.0);	
		else
			C.Button = false;
			ChatFrame1:AddMessage("Clean: Checkbox is now hidden" , 1.0, 1.0, 0.0, 1.0);	
		end
	else
		ChatFrame1:AddMessage("Clean commands is open, close, lock, unlock, button[on/off]: " , 1.0, 1.0, 0.0, 1.0);	
	end
end

-- Event

function C_Event(event)
	if (event == "PLAYER_REGEN_DISABLED") then
		C.Combat = true;
	end	
  		
  	if (event == "PLAYER_REGEN_ENABLED") then
  		C.Combat = false;
  	end
  	
  	if (event == "ADDON_LOADED") then
  		
  		C_Init();
  		C_Load();	
  		
  		C_BottomScreen:SetWidth(WorldFrame:GetWidth()+1);
  		
  		--ChatFrame1:AddMessage("Number of hidden frames: " .. getn(C.Frame), 1.0, 1.0, 0.0, 1.0);	
  		
  		--	for i=1, 23, 1 do
  		--		getglobal("BuffButton"..i):Show();
  		--	end
  	end
end

function C_Load()
	for i=1, C_Ant_Frames, 1 do
		getglobal("CleanButton"..i):SetChecked(C.Frame[i]);
	end
end
	
function C_Init()
	if (not C.Frame or C_Ant_Frames ~= getn(C.Frame)) then
		C.Frame = {}
		
		for i=1, C_Ant_Frames, 1 do
			C.Frame[i] = false;
		end
		ChatFrame1:AddMessage("Clean: Reseted saved frame file and added data for " .. C_Ant_Frames .. " frames", 1.0, 1.0, 0.0, 1.0);	
	end

	if (not C.CastingBar) then
		C.CastingBar = false;
	end

	C.Combat = false;
	
	if (not C.Locked) then
		C.Locked = {}
		
		for i=1, C_Ant_Frames, 1 do
			C.Locked[i] = false;
		end
	end
	
	if (not C.Lock) then
		C.Lock = false;
	end
	
	if (not C.Button) then
		C.Button = true;
	end
end