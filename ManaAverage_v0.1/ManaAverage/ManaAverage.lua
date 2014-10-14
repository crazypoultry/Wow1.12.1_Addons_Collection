MANAAVERAGE_VERSION = "Mana Average v0.1";
MANAAVERAGEProfile = {}; --Every Char on every Server has its own.

local MANAAVERAGEData ={};   -- only need one for all chars
local PlayerName = nil; -- Logged in player name;





--------------------------------------------------------------------------------------------------
-- Default Settings & Vars
--------------------------------------------------------------------------------------------------

local MANAAVERAGEdurchlauf =0;  -- Mana event is always called twice. but we just react on the first.


c1           = "|cff00ff00";
c2           = "|cff22dd00";
c3           = "|cff44bb00";
c4           = "|cff669900";
c5           = "|cff887700";
c6           = "|cffaa5500";
c7           = "|cffcc3300";
c8           = "|cffee1100";
c9           = "|cffff0000";

ce =              "|r";

local Anzahl = 10;
local Players = {"player","pet","party1","party2","party3","party4","partypet1","partypet2","partypet3","partypet4"};



--------------------------------------------------------------------------------------------------
-- Initialize functions
--------------------------------------------------------------------------------------------------

function MANAAVERAGE_Trim (s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

function MANAAVERAGE_InitializeProfile()
	if ( UnitName("player") ) then
		PlayerName = UnitName("player").."|"..MANAAVERAGE_Trim(GetCVar("realmName"));
		MANAAVERAGE_LoadSettings();
	end
end


function MANAAVERAGE_LoadSettings()
	
	if ( MANAAVERAGEProfile[PlayerName] == nil ) then
		
		MANAAVERAGEProfile[PlayerName] = {};
	
		MANAAVERAGEProfile[PlayerName]["global"] = {};
		MANAAVERAGEProfile[PlayerName]["global"]["XPOS"] = 300;
		MANAAVERAGEProfile[PlayerName]["global"]["YPOS"] = 300;
		
 
	   
	   
	    --DEFAULT_CHAT_FRAME:AddMessage("*** " .. MANAAVERAGE_TRANS .. " ***");
	end
	
	
	


	local myFenster = "MANAAVERAGE_window";
	getglobal(myFenster):ClearAllPoints();

		
	local myFenster = "MANAAVERAGE_window" ;
	getglobal(myFenster):SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", MANAAVERAGEProfile[PlayerName]["global"]["XPOS"], MANAAVERAGEProfile[PlayerName]["global"]["YPOS"]);


	MANAAVERAGE_SetAllData();	

end

--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------


function MANAAVERAGE_OnLoad()
	
	
	
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
	 


	MANAAVERAGEdurchlauf=0;
	mana_super = c1 .. "H"  .. ce .. c2 .. "e"  .. ce.. c3 .. "a" .. ce .. c3 .. "l" .. ce .. c4 .. "t" .. ce .. c5 .. "h" .. ce .. c6  .. " " .. "A" .. ce .. c7 .. "v" .. ce .. c8 .. "g" .. ce ; 
	mana_super2 = c1 .. "*"  .. ce ..c1 .. "*"  .. ce ..c1 .. "*"  .. ce ..c1 .. "*"  .. ce ..c1 .. "*"  .. ce ..c1 .. "*"  .. ce .. c2 .. "*"  .. ce.. c3 .. "*" .. ce .. c3 .. "*" .. ce .. c4 .. "*" .. ce .. c5 .. "*" .. ce .. c6  .. "*" .. ce .. c7 .. "*" .. ce .. c8 .. "*" .. ce .. c9 .. "*" ..ce .. c9 .. "*" ..ce.. c9 .. "*" ..ce.. c9 .. "*" ..ce.. c9 .. "*" ..ce.. c9 .. "*" ..ce; 
	DEFAULT_CHAT_FRAME:AddMessage("       " .. mana_super2);
	DEFAULT_CHAT_FRAME:AddMessage("    ".. mana_super .. " v0.5 Loaded ");
	DEFAULT_CHAT_FRAME:AddMessage("       " .. mana_super2);
	
	
	
	
end

function MANAAVERAGE_OnEvent(event)


	if( event == "VARIABLES_LOADED" ) then
		---------------------
		-- support for myAddons
		---------------------
		if(myAddOnsFrame) then
			myAddOnsList.MANAAVERAGE = {
				name = "MANAAVERAGE",
				description = "Description of MANAAVERAGE",
				version = "0.1",
				category = MYADDONS_CATEGORY_CLASS,
				frame = "MANAAVERAGEFrame",
				optionsframe = "MANAAVERAGEOptionsFrame"
			};
		end
		
		MANAAVERAGE_InitializeProfile();
		
		-- Die beiden für minimap button
		MANAAVERAGE_Init();
		--MANAAVERAGE_UpdatePosition();
		getglobal("MANAAVERAGE_windowText"):SetText("Avg: 0"); 
		
	end
	
	if( event == "UNIT_MANA" ) then
		MANAAVERAGE_Update();
	end
	 
	if( event == "PARTY_MEMBERS_CHANGED" ) then
		MANAAVERAGE_Update();
	end
	
end




function MANAAVERAGE_SlashCommandHandler(msg)
	

	
end




function MANAAVERAGE_Update()
	

	if (MANAAVERAGEdurchlauf==0) then
	
		MANAAVERAGE_SetAllData();
		
	end
	
	
	MANAAVERAGEdurchlauf= MANAAVERAGEdurchlauf +1;
	if( MANAAVERAGEdurchlauf==2) then
		MANAAVERAGEdurchlauf=0;
	end	
	
end
	




function MANAAVERAGEProfileVar(varname, value)
	if ( PlayerName ) then
		if ( MANAAVERAGEProfile[PlayerName] ) then
			MANAAVERAGEProfile[PlayerName][varname] = value;
		end
	end
end


function MANAAVERAGE_SaveVar(d, value,my_player)
	if ( PlayerName ) then
		if ( MANAAVERAGEProfile[PlayerName] ) then
			MANAAVERAGEProfile[PlayerName][my_player][d] = value;
			
		end
	end
end

function MANAAVERAGE_Init()

	
	
	
end


function MANAAVERAGE_SetAllData()
	
	
	local sum =0;
	local numPlayers =0;
	local sumMana =0;
	local sumMax =0;
	for j = 1, 10, 1 do
		
		local player = Players[j];
		if ((UnitExists(Players[j]))) then 
			local mana = UnitMana(player);
			local max = UnitManaMax(player);
			local powerType = UnitPowerType(player);
			if (powerType == 0) then
				sum = sum + (max-mana);
				sumMana = sumMana + mana;
				sumMax = sumMax + max;
			end
			numPlayers = numPlayers +1;
		end
	end
	
	local proz = sumMana/sumMax;
	r= 1.0*(1-proz);
		g = 1.0*proz;
		b = 0;

		if (r >=0 and r<=1 and g<=1 and g >=0) then
			getglobal("MANAAVERAGE_windowText"):SetVertexColor(r,g,b,100/100);
			else
			getglobal("MANAAVERAGE_windowText"):SetVertexColor(0,1,0,100/100);
	end
	local avg = sum/numPlayers;
	local percent = proz * 100;
--	getglobal("MANAAVERAGE_windowText"):SetText("Avg: " .. string.format("%.1f", avg)); 
	getglobal("MANAAVERAGE_windowText"):SetText("Avg: " .. string.format("%d", percent) .. "%"); 
end


function MANAAVERAGESavePos(name)
	
	x = getglobal(name):GetLeft();
	y = getglobal(name):GetBottom();
	PlayerName = UnitName("player").."|"..MANAAVERAGE_Trim(GetCVar("realmName"));
	MANAAVERAGEProfile[PlayerName]["global"]["XPOS"] = x;
	MANAAVERAGEProfile[PlayerName]["global"]["YPOS"] = y;
end
