--[[
Radar
        Author:         Karsten
        Thanks:			Awen who created the original Radar v1.0
        Version:        1.5
        Change Log :
        	2005.06.22	version 1.0 by Awen
        	2005.11.08	version 1.1
        	2005.12.18	version 1.2
        	2006.01.06	version 1.3
        	2006.01.24	version 1.4
        	2006.02.07	version 1.5
]]


--****************************************

-- Configuration variables
RadarOptions = {			-- Saved structure for options
    Version = nil;
	Display = {				-- Everything involving display
  		MaxSize;            -- Number of mobs showing
		ShowGuild;	        -- Show/Hide mob guild
		ShowBorder;	        -- Border visibility
		Lock;		        -- lock/unlock window position
		Colors = {			-- Color/Opacity
		};	
		Time = {
		    HThreat;        -- Time an enemy is high threat
		    MThreat;        -- Time an enemy is medium threat
		    LThreat;        -- Time an enemy is low threat
		};
	};
	MobListSize;		    -- Number of mobs stored
	Sound;                  -- Enable/Disable sound
	Enable;		            -- Turning on/off Radar
	Debug;			        -- Show/Hide debug information
};

--****************************************

-- Local variables
rd_data = {};
rd_friends = {};
rd_mobs = {};
rd_lasttarget = nil;
rd_lastUpdateTime = 0;

local RD_MAX_LOG_SHOW = 16;
local RD_ONUPDATE_TIME = 2;

local RD_SUMMONS = {
	["Grounding Totem"] = 1,
	["Windfury Totem"] = 1,
	["Searing Totem"] = 1,
	["Earthbind Totem"] = 1,
	["Magma Totem"] = 1,
	["Fire Nova Totem"] = 1, 
};

local RD_CLASSGUESS = {
	["Fire Bolt"] = "Pet",
	--["Claw"] = "Pet",						    -- DRUIDS got the same ability
	["Bite"] = "Pet",
	
	["Fade"] = "Priest",
	["Flash Heal"] = "Priest",
	["Inner Fire"] = "Priest",
	["Mind Blast"] = "Priest",
	["Mana Burn"] = "Priest",
	["Psychic Scream"] = "Priest",
	["Renew"] = "Priest",
	["Power Word: Shield"] = "Priest",
	
	["1 Rage"] = "Warrior",						-- OK
	["6 Rage"] = "Warrior",
	["15 Rage"] = "Warrior",					-- OK
	["Battle Shout"] = "Warrior",
	["Battle Stance"] = "Warrior",
	["Berserker Stance"] = "Warrior",
	["Execute"] = "Warrior",
	["Hamstring"] = "Warrior",
	["Heroic Strike"] = "Warrior",
	["Howl of Terror"] = "Warrior",
	["Intercept Stun"] = "Warrior",
	["Mortal Strike"] = "Warrior",				-- OK
	["Thunder Clap"] = "Warrior",				-- OK
	
	["Aimed Shot"] = "Hunter",	
	["Arcane Shot"] = "Hunter",					-- OK
	["Aspect of the Monkey"] = "Hunter",
	["Auto Shot"] = "Hunter",					-- OK
	["Concussive Shot"] = "Hunter",
	["Multi-Shot"] = "Hunter",					-- OK
	["Scatter Shot"] = "Hunter",
	["Serpent Sting"] = "Hunter",
	["Track Humanoids"] = "Hunter",
	["Trueshot Aura"] = "Hunter",
	
	["Arcane Explosion"] = "Mage",				-- OK
	["Arcane Power"] = "Mage",
	["Blink"] = "Mage",
	["Cone of Cold"] = "Mage",					-- OK
	["Fireball"] = "Mage",
	["Fire Blast"] = "Mage",					-- OK
	["Frostbolt"] = "Mage",
	["Frost Nova"] = "Mage",					-- OK
	["Ice Barrier"] = "Mage",
	["Pyroblast"] = "Mage",
	["Scorch"] = "Mage",
	
	["Chain Lightning"] = "Shaman",
	["Earth Shock"] = "Shaman",
	["Earthbind Totem"] = "Shaman",
	["Flurry"] = "Shaman",
	["Frost Shock"] = "Shaman",					-- OK
	["Lightning Bolt"] = "Shaman",
	["Lightning Shield"] = "Shaman",			-- OK
	["Lesser Healing Wave"] = "Shaman",
	["Magma Totem"] = "Shaman",
	["Purge"] = "Shaman",
	["2 extra attacks through Windfury Attack"] = "Shaman",
	
	["Curse of Agony"] = "Warlock",
	["Corruption"] = "Warlock",					-- OK
	["Demon Armor"] = "Warlock",
	["Immolate"] = "Warlock",
	["Lash of Pain"] = "Warlock",
	["Shadow Bolt"] = "Warlock",				-- OK
	["Soul Siphon"] = "Warlock",
	["Summon Felhunter"] = "Warlock",
	["Summon Felsteed"] = "Warlock",
	
	["Cat Form"] = "Druid",
	--["Claw"] = "Druid",						-- PETS got the same ability
	["Dire Bear Form"] = "Druid",
	["Ferocious Bite"] = "Druid",
	["Innervate"] = "Druid",
	["Mark of the Wild"] = "Druid",
	["Moonfire"] = "Druid",
	["Regrowth"] = "Druid",
	["Shred"] = "Druid",
	["Tiger's Fury"] = "Druid",
	["Thorns"] = "Druid",
	["Wrath"] = "Druid",
	
	["Ambush"] = "Rogue",
	["Backstab"] = "Rogue",						-- OK
	["Cold Blood"] = "Rogue",
	["Detect Traps"] = "Rogue",
	["Eviscerate"] = "Rogue",					-- OK
	["Gouge"] = "Rogue",						-- OK
	["Sinister Strike"] = "Rogue",				-- OK
	["Sprint"] = "Rogue",
};

--****************************************

function Radar_OnLoad()

	this:RegisterForDrag("LeftButton");
	
	-- Events to listen for
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");

	SLASH_RADAR1 = "/radar";
	SlashCmdList["RADAR"] = Radar_Options;

	RadarFrame:Show();

	-- Done!
	Radar_ChatMsg("Radar 1.2 loaded - Configure with /radar");
end

--****************************************

function Radar_OnEvent()
	local nothing;
	local mob, spell;
	
	if (event == "VARIABLES_LOADED") then
		Radar_DataLoaded();
		Radar_RefreshFriendList();
		return;
    end
    
	if (not RadarOptions.Enable) then
		return;
	end
	
	if (event == "UPDATE_MOUSEOVER_UNIT") then
		Radar_UpdateTarget("mouseover");
		return;
	elseif (event == "PARTY_MEMBERS_CHANGED") then
		Radar_RefreshFriendList();
		return;
	elseif (event == "PLAYER_TARGET_CHANGED") then
		Radar_UpdateTarget("target");
		return;
	elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		for mob, spell in string.gfind(arg1, "(.+) dies.") do
			Radar_UpdateDeath(mob);
			Radar_debug("1 " .. arg1);
			return;
		end
	elseif (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS") then
		for mob,nothing,nothing in string.gfind(arg1, "(.+) hits (.+) for (.+).") do
			Radar_UpdateMob(mob);
			Radar_debug("2 " .. arg1);
			return;
		end
		for mob,nothing,nothing in string.gfind(arg1, "(.+) crits (.+) for (.+).") do
			Radar_UpdateMob(mob);
			Radar_debug("3 " .. arg1);
			return;
		end
	elseif (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES") then
		for mob,nothing in string.gfind(arg1, "(.+) misses (.+).") do
			Radar_UpdateMob(mob);
			Radar_debug("4 " .. arg1);
			return;
		end
		for mob,nothing in string.gfind(arg1, "(.+) attacks(.+).") do
			Radar_UpdateMob(mob);
			Radar_debug("5 " .. arg1);
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
		for mob, spell in string.gfind(arg1, "(.+) gains (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("6 " .. arg1);
			return;
		end
		for mob, spell in string.gfind(arg1, "(.+) casts (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("7 " .. arg1);
			return;
		end
		for mob, spell in string.gfind(arg1, "(.+) begins to cast (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("8 " .. arg1);
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
		for mob, spell in string.gfind(arg1, "(.+) begins to cast (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("9 " .. arg1);
			return;
		end
		for mob, spell, nothing, nothing in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("10 " .. arg1);
			return;
		end
		for mob, spell, nothing, nothing in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("11 " .. arg1);
			return;
		end
		for mob, spell in string.gfind(arg1, "(.+) begins to perform (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("12 " .. arg1);
			return;
		end
		for mob, spell, nothing in string.gfind(arg1, "(.+)'s (.+) misses (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("13 " .. arg1);
			return;
		end
		for mob, spell, nothing in string.gfind(arg1, "(.+)'s (.+) was resisted by (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("14 " .. arg1);
			return;
		end
		for mob, spell in string.gfind(arg1, "You absorb (.+)'s (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("15 " .. arg1);
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS") then
		for mob, spell in string.gfind(arg1, "(.+) gains (.+).") do
			Radar_UpdateMob(mob, spell);
			Radar_debug("16 " .. arg1);
			return;
		end
	end
end

--****************************************

function Radar_DataLoaded()
    if( RadarOptions.Version == nil) then --first use
        RadarOptions.Version = 1.4;
        RadarOptions.Display.MaxSize = 7;
        RadarOptions.Display.ShowGuild = false;
        RadarOptions.Display.Lock = true;
        RadarOptions.Display.Colors.Window = {0.0, 0.0, 0.8, 0.8};
        RadarOptions.Display.Colors.HThreat = {1.0, 0.0, 0.0};
        RadarOptions.Display.Colors.MThreat = {1.0, 0.4, 0.0};
        RadarOptions.Display.Colors.LThreat = {1.0, 1.0, 0.0};
        RadarOptions.Display.ShowBorder = true;
        RadarOptions.MobListSize = 30;
        RadarOptions.Sound = true;
        RadarOptions.Enable = true;
        RadarOptions.Debug = true;
    end
    if( RadarOptions.Version < 1.5) then
        RadarOptions.Version = 1.5;
        RadarOptions.Display.Time = {};
        RadarOptions.Display.Time.HThreat = 30;
        RadarOptions.Display.Time.MThreat = 60;
        RadarOptions.Display.Time.LThreat = 180;
    end
           
	Radar_InitUI();
end

--****************************************

function Radar_OnUpdate()
	local i;
	local currtime = GetTime();
	local targetname = UnitName("target");

	if (not RadarOptions.Enable) then
		return;
	end

	if ( targetname and (targetname ~= rd_lasttarget)) then
		Radar_UpdateTarget("target");
		rd_lasttarget = targetname;
		return;
	end
	
	if ((currtime - rd_lastUpdateTime) > RD_ONUPDATE_TIME) then
		rd_lastUpdateTime = currtime;
		Radar_UpdateUI();
	end
end

--****************************************

function Radar_Options(msg)
	local text = msg;
	msg = string.lower(msg);

    firsti, lasti, command = string.find(msg, "(%w+)");
	   
	if (command == nil) then
		RadarOptions_Toggle();
	elseif (command == "clear") then
		Radar_ChatMsg("Radar: Data reset");
		Radar_ResetData();
	elseif (command == "enable") then
		Radar_SetEnable(true);
	elseif (command == "disable") then
		Radar_SetEnable(false);
		Radar_ResetData();
		return;
	else
		RadarDisplayUsage();     
	end
	
	Radar_UpdateUI();
end

--****************************************     
         
function RadarDisplayUsage()
   Radar_ChatMsg("Usage:");
   Radar_ChatMsg("   /radar [option], options are:");
   Radar_ChatMsg("   clear      <> resets enemy information");
   Radar_ChatMsg("   enable     <> enable Radar");
   Radar_ChatMsg("   disable    <> disable Radar");   
end         

--****************************************   
         
function Radar_ChatMsg(msg)
   if( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage(msg);
   end
end

--****************************************

function Radar_UpdateMob(mobname, spell)
	local now = GetTime();
	local mob = rd_mobs[mobname];
	local class = "";

	if( spell) then
		class = RD_CLASSGUESS[spell];
		if (class) then
			Radar_debug(mobname .. "'s spell: " .. spell .. " imply: " .. class);
		else
			Radar_debug(mobname .. "'s spell: " .. spell .. " is unknown");
		end
	end
	
	if (not mob) then
	    Radar_PlaySound(-1);
		Radar_AddMob(mobname, "", class, "", "");
	else
	    Radar_PlaySound(now-mob.LastSeen);
		if (mob.class == "") then
			mob.class = class;
		end
		mob.LastSeen = now;
		Radar_UpdatePosition(mob);
	end
	
	Radar_UpdateUI();
end

--****************************************

function Radar_UpdateTarget(target)
    -- if data hasn't been loaded yet, it can be unknown identity
	local name = UnitName(target);
	if (not name) then
		return;
	end
	
	local now = GetTime();
	local mob = rd_mobs[name];
	if (mob) then
	    Radar_PlaySound(now-mob.LastSeen);
		if (mob.level == "") then
			mob.level = UnitLevel(target);
			if (not mob.class) then
				Radar_debug(name .. "'s class is added because of target");
			end
			mob.class = UnitClass(target);
			mob.type = UnitRace(target);
			mob.guild = GetGuildInfo(target);		
		end
		mob.LastSeen = now;
		Radar_UpdatePosition(mob);				
	else
		-- We ignoring friendlies?
		if (not UnitIsEnemy(target,"player")) then
			return;
		end
		-- We ignoring NPC's?
		if (not UnitIsPlayer(target)) then
			return;
		end

        Radar_PlaySound(-1);
		Radar_debug(name .. " is added because of target");	
		local level = UnitLevel(target);
		local class = UnitClass(target);
		local type = UnitRace(target);
		local guild = GetGuildInfo(target);
		Radar_AddMob(name, level, class, type, guild);
	end
	
	Radar_UpdateUI();
end

--****************************************

function Radar_UpdateDeath(name)
	local now = GetTime();
	local mob = rd_mobs[name];
	if (mob) then
		mob.LastSeen = now - 60;
		Radar_UpdatePosition(mob)
		Radar_NegativeUpdatePosition(mob)
	end
	
	Radar_UpdateUI();
end

--****************************************

function Radar_AddMob(name, level, class, type, guild)
	if (rd_friends[name]) then
		return nil;
	end
	if (RD_SUMMONS[name]) then
		return nil;
	end

	if (name == "Unknown Entity") then
		return nil;
	end
	
	local mob = {};
	mob.name = name;
	mob.level = level;
	mob.type = type;
	mob.class = class;
	mob.guild = guild;
	mob.LastSeen = GetTime();

	local oldestTime = 999999999;
	local newi = table.getn(rd_data) + 1;
	if (newi > RadarOptions.MobListSize) then
		for i=1, table.getn(rd_data), 1 do 
			if (not rd_data[i]) then
				newi = i;
				break;
			elseif (rd_data[i].LastSeen < oldestTime) then
				oldestTime = rd_data[i].LastSeen;
				newi = i;
			end
		end
		-- remove the oldest one if the list is full
		rd_mobs[rd_data[newi].name] = nil;
	end
	
	-- Put the new one
	rd_data[newi] = mob;
	rd_mobs[name] = mob;
	
	Radar_UpdatePosition(mob);
end

--****************************************

function Radar_UpdatePosition(mob)
	for i=1,RadarOptions.MobListSize,1 do
		if (rd_data[i] == mob) then
			while (i>=2 and rd_data[i].LastSeen > rd_data[i-1].LastSeen) do
				local temp = rd_data[i-1];
				rd_data[i-1] = rd_data[i];
				rd_data[i] = temp;
			
				temp = rd_mobs[i-1];
				rd_mobs[i-1] = rd_mobs[i];
				rd_mobs[i] = temp;
				
				i=i-1;
			end
			
			break;
		end
	end
end

--****************************************

function Radar_NegativeUpdatePosition(mob)
	for i=1,RadarOptions.MobListSize,1 do
		if (rd_data[i] == mob and rd_data[i+1] == mob) then
			while (i<=RadarOptions.MobListSize-1 and rd_data[i].LastSeen < rd_data[i+1].LastSeen) do
				local temp = rd_data[i+1];
				rd_data[i+1] = rd_data[i];
				rd_data[i] = temp;
			
				temp = rd_mobs[i+1];
				rd_mobs[i+1] = rd_mobs[i];
				rd_mobs[i] = temp;
				
				i=i+1;
			end
			
			break;
		end
	end
end

--****************************************

function Radar_ResetData()
	rd_data = {};
	rd_mobs = {};
	Radar_UpdateUI();
end

--****************************************

function Radar_debug(msg)
	if (RadarOptions.Debug) then
		if (ChatFrame3) then
			ChatFrame3:AddMessage("Radar:" .. msg);
		end
	end
end

--****************************************

function Radar_SetEnable(bool)
	if( bool) then
		RadarOptions.Enable = true;
		RadarFrame:Show();
	else
		RadarOptions.Enable = false;
		RadarFrame:Hide();
	end
end

--****************************************

function Radar_OnDragStart()
	if (not RadarOptions.Display.Lock) then
		RadarFrame:StartMoving();
	end
end


function Radar_OnDragStop()
    RadarFrame:StopMovingOrSizing();
end

--****************************************

function Radar_LockMovement()
    RadarOptions.Display.Lock = true;
    Radar_UpdateUI();
end


function Radar_UnlockMovement()
    RadarOptions.Display.Lock = false;
    Radar_UpdateUI();
end

--****************************************

function Radar_InitUI()
	-- Update MaxSize (Hide buttons outside Window)
	for i=1,RD_MAX_LOG_SHOW,1 do
		button = getglobal("RadarButton"..i);
		button:Hide();
	end;

    -- Update Show/Hide guild
    if( RadarOptions.Display.ShowGuild) then
        RadarFrame:SetWidth(340);
    else
        RadarFrame:SetWidth(240);
    end;
    
    -- Update Show/Hide border
    if( RadarOptions.Display.ShowBorder) then
        RadarFrame:SetBackdropBorderColor(1,1,1,1);
    else
        RadarFrame:SetBackdropBorderColor(1,1,1,0);
    end;
    
    -- Update Window Color
    RadarFrame:SetBackdropColor(
	    RadarOptions.Display.Colors.Window[1],
	    RadarOptions.Display.Colors.Window[2],
	    RadarOptions.Display.Colors.Window[3],
	    1-RadarOptions.Display.Colors.Window[4]
	);
	
	Radar_UpdateUI();
end

--****************************************

function Radar_UpdateUI()
	local now = GetTime();
	local height;
	local currentSize = 0;

	-- Update the display frame
	for i=1,RadarOptions.Display.MaxSize,1 do
		local type;
		local class;
		local guild;
		local mob;
		local level;
		local desc;
		mob = rd_data[i];
		button = getglobal("RadarButton"..i);
		if (mob) then
			if ( (now - rd_data[i].LastSeen) > RadarOptions.Display.Time.LThreat) then
				button:Hide();
			else
				button:Show();
				currentSize = currentSize +1;
				
                -- Color
				if ( (now - rd_data[i].LastSeen) <= RadarOptions.Display.Time.HThreat) then
					getglobal("RadarButton"..i.."Name"):SetTextColor(RadarOptions.Display.Colors.HThreat[1],RadarOptions.Display.Colors.HThreat[2],RadarOptions.Display.Colors.HThreat[3])
					getglobal("RadarButton"..i.."Description"):SetTextColor(RadarOptions.Display.Colors.HThreat[1],RadarOptions.Display.Colors.HThreat[2],RadarOptions.Display.Colors.HThreat[3])
				elseif ( (now - rd_data[i].LastSeen) <= RadarOptions.Display.Time.MThreat) then
					getglobal("RadarButton"..i.."Name"):SetTextColor(RadarOptions.Display.Colors.MThreat[1],RadarOptions.Display.Colors.MThreat[2],RadarOptions.Display.Colors.MThreat[3])
					getglobal("RadarButton"..i.."Description"):SetTextColor(RadarOptions.Display.Colors.MThreat[1],RadarOptions.Display.Colors.MThreat[2],RadarOptions.Display.Colors.MThreat[3])
				else
				    getglobal("RadarButton"..i.."Name"):SetTextColor(RadarOptions.Display.Colors.LThreat[1],RadarOptions.Display.Colors.LThreat[2],RadarOptions.Display.Colors.LThreat[3])
				    getglobal("RadarButton"..i.."Description"):SetTextColor(RadarOptions.Display.Colors.LThreat[1],RadarOptions.Display.Colors.LThreat[2],RadarOptions.Display.Colors.LThreat[3])
				end

				-- Level
				level = mob.level;
				level = string.gsub(level,"^-1$","??");
			    getglobal("RadarButton"..i.."Level"):SetText(level);
				
				-- Name
				getglobal("RadarButton"..i.."Name"):SetText(mob.name);
	
				-- Type & Class
				if (mob.class) then
					class = mob.class;
				else
					class = "";
				end

				if (mob.type) then
					type = mob.type;
					type = string.gsub(type,"^Human$","Human");
					type = string.gsub(type,"^Night Elf$","N.Elf");
					type = string.gsub(type,"^Gnome$","Gnom.");
					type = string.gsub(type,"^Tauren$","Taur.");
					type = string.gsub(type,"^Undead$","Und.");
				else
					type = "";
				end
			 				 
				if (mob.guild and RadarOptions.Display.ShowGuild) then
					guild = "<" .. mob.guild .. ">";
				else
					guild = "";
				end
				
				desc = class .. " " .. type .. "  " .. guild;
				getglobal("RadarButton"..i.."Description"):SetText(desc);
			end
		else
			button:Hide();
		end
	end

	if(not RadarOptions.Display.Lock) then
		for i=currentSize+1,RadarOptions.Display.MaxSize,1 do
			button = getglobal("RadarButton"..i);
			button:Show();
			getglobal("RadarButton"..i.."Level"):SetText("??");
			
			getglobal("RadarButton"..i.."Name"):SetTextColor(RadarOptions.Display.Colors.HThreat[1],RadarOptions.Display.Colors.HThreat[2],RadarOptions.Display.Colors.HThreat[3])
			getglobal("RadarButton"..i.."Name"):SetText("name");
			
			getglobal("RadarButton"..i.."Description"):SetTextColor(RadarOptions.Display.Colors.HThreat[1],RadarOptions.Display.Colors.HThreat[2],RadarOptions.Display.Colors.HThreat[3])
			if (RadarOptions.Display.ShowGuild) then
			    getglobal("RadarButton"..i.."Description"):SetText("Class     Race            Guild");
			else
			    getglobal("RadarButton"..i.."Description"):SetText("Class     Race");
			end
		end
		currentSize = RadarOptions.Display.MaxSize;
	end			

	if( currentSize == 0) then
		RadarFrame:Hide();
	else
		height = (RadarButton1:GetHeight() * currentSize) + RadarFrameHeaderFrame:GetHeight() + 9;
		RadarFrame:SetHeight(height);
		RadarFrame:Show();
	end

end

--****************************************

function Radar_ListButton()
	local name;
	local chatstr;

	local cltime = GetTime();
	local i = this:GetID();
	
	-- if unlocked clicking is disabled
	if(not RadarOptions.Display.Lock) then
		return;
	end
		
	local wantname = rd_data[i].name;
	
	-- Handle double-click

	TargetByName(wantname);
	name = UnitName("target")
	if (name ~= wantname) then
		ClearTarget();
	end
end

--****************************************

function Radar_PlaySound(time)
    if( RadarOptions.Sound) then
        if( time < 0) then
            PlaySound("SHEATHINGSHIELDUNSHEATHE");
        elseif (time > RadarOptions.Display.Time.HThreat) then
            PlaySound("SHEATHINGSHIELDUNSHEATHE");
        end
	end
end

--****************************************

function Radar_RefreshFriendList()
	rd_friends = {};
	for i=1,40,1 do
		local name = UnitName("raid" .. i);
		if (name) then
			rd_friends[name] = 1;
			Radar_debug("Radar: raidfriend added: " .. name);
		end
	end
	for i=1,4,1 do
		local name = UnitName("party" .. i);
		if (name) then
			rd_friends[name] = 1;
			Radar_debug("Radar: partyfriend added: " .. name);
		end
	end
end


--[[

  RAID_ROSTER_UPDATE
 
Fired whenever a raid is formed or disbanded, players are leaving or joining a raid 
(unsure if rejected join requests also fire the event), or when looting rules are changed 
(regardless of being in raid or party!)
 
  PARTY_MEMBERS_CHANGED

Fired when the player's party changes.

As of 1.8.3 this event also fires when players are moved around in a Raid and when a player leaves the raid. 
This holds true even if the changes do not affect your party within the raid.

4-2-05 Edit: This event is called twice when the event PARTY_LOOT_METHOD_CHANGED is called.

7-28-05 EDIT: This event is generated whenever someone rejects an invite and your in a group, 
also generated obviously when someone joins or leaves the group. 
Also, if for instance you have 3 people in your group and you invite a 4th, 
it will generate 4 events. If you call GetNumPartyMembers() it will return 0, 1, 2, and 3. 
First event returing zero, 2nd event returning 1, etc etc. 

]]--