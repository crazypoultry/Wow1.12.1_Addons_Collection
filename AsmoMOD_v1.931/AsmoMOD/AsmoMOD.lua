--AsmoMOD made by Asmodius, Arthas Server
--All rights reserved.

-- Declare Needed Variables
AsmoMOD_UpdateInterval = 1.0;
local TimeSinceLastUpdate = 0;
local bgtime = -1;
local reztime = -1;
local sumtime = -1;
local manastart = 999;
local AsmoMOD_Color = "|c000566FF";
local AsmoMOD_ColorR = "|c00FF0000";
local RipID = 0;
local RipAction = 0;
local opID = 0;
local opAction = 0;
local berID = 0;
local berAction = 0;
local rejuvID = 0;
local rejuvAction = 0;
local counterID = 0;
local counterAction = 0;
local regID = 0;
local regAction = 0;
local swiftID = 0;
local WotfID = 0;
local healID = 0;
local LightID = 0;
local touchID = 0;
local feignID = 0;
local trapID = 0;
local nsID = 1;
local stoneID = 0;
local gemID = 0;
local escapeID = 0;
local inCombat = false;
local herbID = 0;
local mineID = 0;
local executeID = 0;
local herbmineme = 0;
local gemme = 0;
local swiftme = -1;
local emerlist = -1;
local nslightning = 0;
local feigntrap = 0;
local justenabled = 0;
local rejuvcheck = false;
local growthcheck = false;
local FullStormrage = 0;
local rejuvreset = 0;
local regreset = 0;
local rejuvtoadd;
local regtoadd;
local autoDelay = 0;
local KidneyCheck = 0;
local AutoBreak = {};
local wotflock = false;
local trinketlock = false;
local resetTimeWotf = 0;
local resetTimeTrinket = 0;
local swiftAction = 0;

-- Load Event
function AsmoMOD_OnLoad()

	-- Load Temp Vars to prevent errors if they have an old version
	AsmoMOD_LoadTempVars();

	this.TimeSinceLastUpdate = 0;
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
        this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("RESURRECT_REQUEST");
	this:RegisterEvent("CONFIRM_SUMMON");
	this:RegisterEvent("PARTY_INVITE_REQUEST");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("PLAYER_UNGHOST");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("BAG_UPDATE");
	AsmoMOD_Chat("AsmoMOD v1.931 loaded.");

	SLASH_Asmo1 = "/Asmo";
	SlashCmdList["Asmo"] = AsmoMOD_showMenu;

	SLASH_nsheal1 = "/nsheal";
	SlashCmdList["nsheal"] = AsmoMOD_nsheal;

	SLASH_nslight1 = "/nslight";
	SlashCmdList["nslight"] = AsmoMOD_nslight;

	SLASH_feigntrap1 = "/feigntrap";
	SlashCmdList["feigntrap"] = AsmoMOD_feigntrap;

	SLASH_timer1 = "/timer";
	SlashCmdList["timer"] = ExecuteCheck;

	SLASH_asmomap1 = "/asmomap";
	SlashCmdList["asmomap"] = AsmoMOD_MinimapToggle;

	SLASH_showbuffs1 = "/showbuffs";
	SlashCmdList["showbuffs"] = AsmoMOD_ShowBuffs;

	-- Add my options frame to the global UI panel list
	UIPanelWindows["AsmoMODOptions"] = {area = "center", pushable = 1};
end

-- Load Needed Variables
function AsmoMOD_Load()

	-- Update the Guild Roster so that if players send you invites the auto accept feature will work correctly
	if(IsInGuild()) then
		GuildRoster();
	end

	-- Find all spell IDs
	local a = 1
	while true do
		local spellName, spellRank = GetSpellName(a, BOOKTYPE_SPELL)
		if not spellName then
      			do break end
   		end

		-- Find Riposte ID
		if (spellName == "Riposte") then
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			RipID = a
			-- Find Action Bar Number for Riposte
			local j;
			for j=1,72, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						RipAction = j
						do break end
					end	
				end
			end
		end

		-- Find Overpower ID
		if (spellName == "Overpower") then
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			opID = a
			-- Find Action Bar Number for Overpower
			local j;
			for j=1,108, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						opAction = j
						do break end
					end	
				end
			end
		end	

		-- Find Berserker Rage ID
		if (spellName == "Berserker Rage") then
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			berID = a
			-- Find Action Bar Number for Berserker Rage
			local j;
			for j=1,108, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						berAction = j
						do break end
					end	
				end
			end
		end

		-- Find Regrowth ID
		if (spellName == "Regrowth") then
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			regID = a
			-- Find Action Bar Number for Regrowth
			local j;
			for j=1,108, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						regAction = j
						do break end
					end	
				end
			end
		end

		-- Find Rejuvenation ID
		if (spellName == "Rejuvenation") then
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			rejuvID = a
			-- Find Action Bar Number for Rejuvenation
			local j;
			for j=1,108, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						rejuvAction = j
						do break end
					end	
				end
			end
		end


		-- Find Counterattack ID
		if(spellName == "Counterattack") then
			counterID = a
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			-- Find Action Bar Number for Counterattack
			local j;
			for j=1,108, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						counterAction = j
						do break end
					end	
				end
			end
		end
	
		-- Find Swiftmend
		if (spellName == "Swiftmend") then
			swiftID = a
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			-- Find Action Bar Number for Swiftmend
			local j;
			for j=1,108, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						swiftAction = j
						do break end
					end	
				end
			end
		end
		
		-- Find Will of the Forsaken
		if (spellName == "Will of the Forsaken") then
			WotfID = a
		end

		-- Find Healing Wave ID
		if (spellName == "Healing Wave") then
			healID = a
		end

		-- Find Chain Lightning ID
		if (spellNamed == "Chain Lightning") then
			LightID = a
		end

		--Find Healing Touch
		if (spellName == "Healing Touch") then
			touchID = a	
		end
	
		-- Find NS for Shaman and Druid
		if (spellName == "Nature's Swiftness") then
			nsID = a
		end

		-- Find Feign ID
		if (spellName == "Feign Death") then
			feignID = a
		end

		-- Find Trap ID
		if (spellName == "Freezing Trap") then
			trapID = a
		end

		-- Find Herb ID
		if (spellName == "Find Herbs") then
			herbID = a
		end

		-- Find Minerals ID
		if (spellName == "Find Minerals") then
			mineID = a
		end
	
		-- Escape Artist ID
		if(spellName == "Escape Artist") then
			escapeID = a
		end

		-- Stoneform ID
		if(spellName == "Stoneform") then
			stoneID = a
		end

		-- Find Treasure ID
		if(spellName == "Find Treasure") then
			gemID = a
		end

		-- Find Execute ID
		if(spellName == "Execute") then
			executeID = a
		end

		a = a + 1;
	end

	-- Load Saved Data
	AsmoMOD_LoadVars();

	-- Set Swiftmend Bars and their Icon Positions
	AsmoMOD_SetBars();
end	

-- Event Handler	
function AsmoMOD_OnEvent(event)
	
	-- Load default vars if this is first time running the mod
	if (event == "PLAYER_LOGIN") then
		AsmoMOD_Load();
	end

	-- Auto-Cast find herbs/minerals
	if (event == "PLAYER_ENTERING_WORLD") then
		if(AsmoMOD_Save.herbmineenabled) then
			herbmineme = 1;
		elseif(AsmoMOD_Save.findgemenabled) then
			gemme = 1;
		end
	end

	-- Determine if player is in combat
	if (event == "PLAYER_REGEN_ENABLED") then 
		inCombat = false;
	end
	if (event == "PLAYER_REGEN_DISABLED") then 
		inCombat = true;
	end

	-- Auto-release to the GY
	if ( event == "PLAYER_DEAD" ) then
		AsmoMOD_Release();
	end

	-- Auto-join the BG when its your turn
	if ( event == "UPDATE_BATTLEFIELD_STATUS" ) then
		if( AsmoMOD_Save.bgjoinenabled ) then
			for i=1, MAX_BATTLEFIELD_QUEUES do
				local status, _, _ = GetBattlefieldStatus(i);
				if (status == "confirm") then
					if(AsmoMOD_Save.bgtime == 0) then
						AsmoMOD_bgJoin();
					else
						bgtime = AsmoMOD_Save.bgtime;
						AsmoMODBGTime:SetText(AsmoMOD_Save.bgtime);
						AsmoMODBGChoice:Show();
					end
				end
			end
		end
	end

	-- Auto-Repair when you see a merchant
	if ( event == "MERCHANT_SHOW") then
		AsmoMOD_RepairInventory();
		AsmoMOD_RepairEquipment();
	end		

	-- Auto-Ressurect
	if ( event == "RESURRECT_REQUEST" ) then
		if(AsmoMOD_Save.rezenabled) then
			if(AsmoMOD_Save.reztime == 0) then
				AsmoMOD_Resurrect();
			else
				reztime = AsmoMOD_Save.reztime;
				AsmoMODRessTime:SetText(AsmoMOD_Save.reztime);
				AsmoMODRessChoice:Show();
			end
		end
	end
	
	-- Auto-Summon
	if ( event == "CONFIRM_SUMMON" ) then
		if(AsmoMOD_Save.summonenabled) then
			if(AsmoMOD_Save.sumtime == 0) then
				AsmoMOD_Summon();
			else
				sumtime = AsmoMOD_Save.sumtime;
				AsmoMODSummTime:SetText(AsmoMOD_Save.sumtime);
				AsmoMODSummChoice:Show();
			end
		end
	end

	-- Auto-Group
	if (event == "PARTY_INVITE_REQUEST") then
		if(AsmoMOD_Save.groupfriendonly) then
			local isFriendorGuildmate = false;
			isFriendorGuildmate = AsmoMOD_FriendGuildCheck(arg1);
			if(isFriendorGuildmate) then
				AsmoMOD_Group();
			end
		else
			AsmoMOD_Group();
		end
	end

	-- Do not do anything if entering/leaving a BG
	if (event == "ZONE_CHANGED_NEW_AREA") then
		AsmoMOD_ResetBreakVars();
	end
	
	-- Auto-Break Variables Turn On
	if(event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
		if(arg1 == "You are afflicted by Seduction.") then
			AutoBreak.charmed = true;
		elseif(arg1 == "You are afflicted by Mind Control.") then
			AutoBreak.charmed = true;
		elseif(arg1 == "You are afflicted by Gnomish Mind Control Cap.") then
			AutoBreak.charmed = true;
		elseif(string.find(arg1, "You are afflicted by Polymorph") ~= nil) then
			AutoBreak.polymorphed = true;
		elseif(arg1 == "You are afflicted by Intimidating Shout.") then
			AutoBreak.feared = true;
		elseif(arg1 == "You are afflicted by Psychic Scream.") then
			AutoBreak.feared = true;
		elseif(arg1 == "You are afflicted by Howl of Terror.") then
			AutoBreak.feared = true;
		elseif(arg1 == "You are afflicted by Bellowing Roar.") then
			AutoBreak.feared = true;
		elseif(arg1 == "You are afflicted by Fear.") then
			AutoBreak.feared = true;
		elseif(arg1 == "You are afflicted by Cheap Shot.") then
			AutoBreak.stunned = true;
		elseif(arg1 == "You are afflicted by Intercept.") then
			AutoBreak.stunned = true;
		elseif(arg1 == "You are afflicted by Kidney Shot.") then
			KidneyCheck = 1;
		elseif(arg1 == "You are afflicted by Hammer of Justice.") then
			AutoBreak.stunned = true;
		elseif(arg1 == "You are afflicted by Bash.") then
			AutoBreak.stunned = true;
		elseif(arg1 == "You are afflicted by Gouge.") then
			AutoBreak.gouged = true;
		elseif(arg1 == "You are afflicted by Frost Nova.") then
			AutoBreak.entangled = true;
		elseif(arg1 == "You are afflicted by Net-o-Matic.") then
			AutoBreak.entangled = true;
		elseif(arg1 == "You are afflicted by Entangling Roots.") then
			AutoBreak.entangled = true;
		elseif(arg1 == "You are afflicted by Crippling Poison.") then
			AutoBreak.impaired = true;
			AutoBreak.poisoned = true;
		elseif(arg1 == "You are afflicted by Hamstring.") then
			AutoBreak.impaired = true;
		elseif(arg1 == "You are afflicted by Wing Clip.") then
			AutoBreak.impaired = true;
		elseif(arg1 == "You are afflicted by Wyvern Sting.") then
			AutoBreak.slept = true;
		end
	end
		
	-- AutoBreak Variables Turn Off
	if(event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then
		if(arg1 == "Seduction fades from you.") then
			AutoBreak.charmed = false;
		elseif(arg1 == "Mind Control fades from you.") then
			AutoBreak.charmed = false;
		elseif(arg1 == "Gnomish Mind Control Cap fades from you.") then
			AutoBreak.charmed = false;
		elseif(string.find(arg1, "Polymorph") ~= nil) then
			AutoBreak.polymorphed = false;
		elseif(arg1 == "Intimidating Shout fades from you.") then
			AutoBreak.feared = false;
		elseif(arg1 == "Psychic Scream fades from you.") then
			AutoBreak.feared = false;
		elseif(arg1 == "Howl of Terror fades from you.") then
			AutoBreak.feared = false;
		elseif(arg1 == "Bellowing Roar fades from you.") then
			AutoBreak.feared = false;
		elseif(arg1 == "Fear fades from you.") then
			AutoBreak.feared = false;
		elseif(arg1 == "Cheap Shot fades from you.") then
			AutoBreak.stunned = false;
		elseif(arg1 == "Bash fades from you.") then
			AutoBreak.stunned = false;
		elseif(arg1 == "Intercept fades from you.") then
			AutoBreak.stunned = false;
		elseif(arg1 == "Hammer of Justice fades from you.") then
			AutoBreak.stunned = false;
		elseif(arg1 == "Kidney Shot fades from you.") then
			AutoBreak.stunned = false;
			KidneyCheck = 0;
		elseif(arg1 == "Gouge fades from you..") then
			AutoBreak.gouged = false;
		elseif(arg1 == "Frost Nova fades from you.") then
			AutoBreak.entangled = false;
		elseif(arg1 == "Entangling Roots fades from you.") then
			AutoBreak.entangled = false;
		elseif(arg1 == "Net-o-Matic fades from you.") then
			AutoBreak.entangled = false;
		elseif(arg1 == "Crippling Poison fades from you.") then
			AutoBreak.impaired = false;
			AutoBreak.poisoned = false;
		elseif(arg1 == "Hamstring fades from you.") then
			AutoBreak.impaired = false;
		elseif(arg1 == "Wing Clip fades from you.") then
			AutoBreak.impaired = false;
		elseif(arg1 == "Wyvern Sting fades from you.") then
			AutoBreak.slept = false;
		end
	end

	-- Auto-Herb/Mine
	if(event == "PLAYER_UNGHOST") then
		if(AsmoMOD_Save.herbmineenabled) then
			herbmineme = 1;
		elseif(AsmoMOD_Save.findgemenabled) then
			gemme = 1;
		end
		AsmoMOD_ResetBreakVars();
	end

	-- Player Target Changed Hook
	if(event == "PLAYER_TARGET_CHANGED") then
		ExecuteCheck();
	end

	-- Detect Regrowth Casts and Ability Casts
	if(event == "CHAT_MSG_SPELL_SELF_BUFF" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		if(string.find(arg1, "You gain Will of the Forsaken") ~= nil) then
			AutoBreak.feared = false;
			AutoBreak.charmed = false;
			AutoBreak.slept = false;
			trinketlock = false;
		elseif(string.find(arg1, "You gain Berserker Rage") ~= nil) then
			AutoBreak.feared = false;
			AutoBreak.gouged = false;
			wotflock = false;
			trinketlock = false;
		elseif(string.find(arg1, "You gain Escape Artist") ~= nil) then
			AutoBreak.entangled = false;
			AutoBreak.impaired = false;
		elseif(string.find(arg1, "You gain Stoneform") ~= nil) then
			AutoBreak.poisoned = false;
		end
		if(string.find(arg1, "Your Regrowth heals") ~= nil) then
			local spacelocation = string.find(arg1, " ", 21);
			regtoadd = string.sub(arg1, 21, spacelocation - 1);
			if(regtoadd == "you") then
				regtoadd = UnitName("player");
			end
			growthcheck = true;
			regreset = GetTime() + 3;
		elseif(string.find(arg1, "Your Regrowth critically heals") ~= nil) then
			local spacelocation = string.find(arg1, " ", 30);
			regtoadd = string.sub(arg1, 30, spacelocation - 1);
			if(regtoadd == "you") then
				regtoadd = UnitName("player");
			end
			growthcheck = true;
			regreset = GetTime() + 3;
		end
	end

	-- Detect if they have added/removed full Stormrage
	if((event == "BAG_UPDATE") and (AsmoMOD_Save.monitorenabled) and (UnitClass("player") == "Druid")) then
		FullStormrage = 3;
		local link = GetInventoryItemLink("player", 1);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Cover") == nil) then
			FullStormrage = 0;
		end
		link = GetInventoryItemLink("player", 3);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Pauldrons") == nil) then
			FullStormrage = 0;
		end
		link = GetInventoryItemLink("player", 5);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Chestguard") == nil) then
			FullStormrage = 0;
		end
		link = GetInventoryItemLink("player", 6);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Belt") == nil) then
			FullStormrage = 0;
		end
		link = GetInventoryItemLink("player", 7);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Legguards") == nil) then
			FullStormrage = 0;
		end
		link = GetInventoryItemLink("player", 8);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Boots") == nil) then
			FullStormrage = 0;
		end
		link = GetInventoryItemLink("player", 9);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Bracers") == nil) then
			FullStormrage = 0;
		end
		link = GetInventoryItemLink("player", 10);
		if(link == nil) then
			FullStomrage = 0;
		elseif(string.find(link, "Stormrage Handguards") == nil) then
			FullStormrage = 0;
		end
	end

	-- Mana Conserve Detect
	if((event == "SPELLCAST_START") and (AsmoMOD_Save.conserveenabled)) then
		if((UnitIsFriend("target", "player")) and AsmoMOD_Save.conservedelay ~= 0) then
			manastart = GetTime() + arg2 / 1000 - AsmoMOD_Save.conservedelay;
		elseif((UnitIsFriend("target", "player")) and AsmoMOD_Save.conservedelay == 0) then
			manastart = 0;
		end
	end

	-- Stop Conserve on Spellcast Cancel or Finish
	if(event == "SPELLCAST_STOP") then
		if(AsmoMOD_Save.conserveenabled) then
			manastart = 0;
		end
	end
end	

-- Cast spells
function ExecuteCheck()

	-- Auto-Break Implimentation
	if(AsmoMOD_Save.trinketenabled) then
		if(AsmoMOD_Save.fearenabled and AutoBreak.feared) then
			-- Use Berserker Rage if it is active
			if ((UnitClass("player") == "Warrior") and (AsmoMOD_Save.zerkenabled) and (berID ~= 0)) then
				-- Cast Berserker Rage
				local duration = GetSpellCooldown(berID, 1);
				if((duration == 0) and IsUsableAction(berAction)) then 
					CastSpell(berID, BOOKTYPE_SPELL);
					wotflock = true;
					trinketlock = true;
					resetTimeWotf = GetTime() + 3;
				end
			end

			-- Use WoTF if it is active
			if (UnitRace("player") == "Undead" and AsmoMOD_Save.wotfenabled and (not wotflock)) then
				-- Cast Will of the Forsaken
				local duration = GetSpellCooldown(WotfID, 1);
				if(duration == 0) then 
					CastSpell(WotfID, BOOKTYPE_SPELL);
					trinketlock = true;
					resetTimeTrinket = GetTime() + 3;
				end
			end

			-- Use the PvP Trinket if it is active
			if((UnitClass("player") == "Mage") or (UnitClass("player") == "Warlock") or (UnitClass("player") == "Druid") or (UnitClass("player") == "Priest") or (UnitClass("player") == "Rogue")) then
				if(not trinketlock) then
					AsmoMOD_AutoTrinketUse();
				end
			end
		elseif(AutoBreak.charmed and AsmoMOD_Save.charmenabled) then
			-- Use WoTF if it is active
			if ((UnitRace("player") == "Undead") and (AsmoMOD_Save.wotfenabled)) then
				-- Cast Will of the Forsaken
				local duration = GetSpellCooldown(WotfID, 1);
				if(duration == 0) then 
					CastSpell(WotfID, BOOKTYPE_SPELL);
					trinketlock = true;
					resetTimeTrinket = GetTime() + 3;
				end
			end
			-- Use the PvP Trinket if it is active
			if((UnitClass("player") == "Warlock") or (UnitClass("player") == "Druid") or (UnitClass("player") == "Rogue")) then
				if(not trinketlock) then
					AsmoMOD_AutoTrinketUse();
				end
			end
		elseif(AutoBreak.stunned and AsmoMOD_Save.stunenabled) then
			-- Use the PvP Trinket if it is active
			if((UnitClass("player") == "Shaman") or (UnitClass("player") == "Druid") or (UnitClass("player") == "Priest") or (UnitClass("player") == "Warrior") or (UnitClass("player") == "Hunter")) then
				AsmoMOD_AutoTrinketUse();
			end
		elseif(AutoBreak.entangled and AsmoMOD_Save.entangleenabled) then
			-- Use Escape Artist if it is active
			if (UnitRace("player") == "Gnome" and AsmoMOD_Save.escapeenabled) then
				-- Cast Escape Artist
				local duration = GetSpellCooldown(escapeID, 1);
				if(duration == 0) then 
					CastSpell(escapeID, BOOKTYPE_SPELL);
				end
			end
			-- Use the PvP Trinket if it is active
			if ((UnitClass("player") == "Warrior") or (UnitClass("player") == "Hunter") or (UnitClass("player") == "Shaman")) then
				AsmoMOD_AutoTrinketUse();
			end
		elseif(AutoBreak.polymorphed and AsmoMOD_Save.polymorphenabled) then
			-- Use the PvP Trinket if it is active
			if((UnitClass("player") == "Mage") or (UnitClass("player") == "Warlock") or (UnitClass("player") == "Priest") or (UnitClass("player") == "Rogue")) then
				AsmoMOD_AutoTrinketUse();
			end
		elseif(AutoBreak.impaired and AsmoMOD_Save.impairenabled) then	
			-- Use Escape Artist if it is active
			if (UnitRace("player") == "Gnome" and AsmoMOD_Save.escapeenabled) then
				-- Cast Escape Artist
				local duration = GetSpellCooldown(escapeID, 1);
				if(duration == 0) then 
					CastSpell(escapeID, BOOKTYPE_SPELL);
				end
			end
			-- Use the PvP Trinket if it is active
			if((UnitClass("player") == "Mage") or (UnitClass("player") == "Shaman") or (UnitClass("player") == "Warrior") or (UnitClass("player") == "Hunter")) then
				AsmoMOD_AutoTrinketUse();
			end
		elseif(AutoBreak.gouged and AsmoMOD_Save.zerkenabled) then
			-- Use Berserker Rage if it is active
			if ((UnitClass("player") == "Warrior") and (berID ~= 0)) then
				-- Cast Berserker Rage
				local duration = GetSpellCooldown(berID, 1);
				if((duration == 0) and IsUsableAction(berAction)) then 
					CastSpell(berID, BOOKTYPE_SPELL);
				end
			end
		elseif(AutoBreak.poisoned and AsmoMOD_Save.stoneenabled) then
			-- Use Stoneform if it is active
			if (UnitRace("player") == "Dwarf") then
				-- Cast Stoneform
				local duration = GetSpellCooldown(stoneID, 1);
				if(duration == 0) then 
					CastSpell(stoneID, BOOKTYPE_SPELL);
				end
			end
		elseif(AutoBreak.slept and AsmoMOD_Save.wotfenabled) then
			-- Cast Will of the Forsaken
			local duration = GetSpellCooldown(WotfID, 1);
			if(duration == 0) then 
				CastSpell(WotfID, BOOKTYPE_SPELL);
			end
		end
	end

	-- Auto-Riposte
	if(AsmoMOD_Save.riposteenabled and (UnitClass("player") == "Rogue") and (RipID ~= 0)) then
		duration = GetSpellCooldown(RipID, 1);
		if(IsUsableAction(RipAction) and (duration == 0)) then
			CastSpellByName("Riposte");
		end
	end

	-- Auto-Counterattack
	if(AsmoMOD_Save.counterenabled and (UnitClass("player") == "Hunter") and (counterID ~= 0)) then
		duration = GetSpellCooldown(counterID, 1);
		if(IsUsableAction(counterAction) and (duration == 0)) then
			CastSpellByName("Counterattack");
		end
	end

	-- Auto-Overpower
	if(AsmoMOD_Save.overpowerenabled and (UnitClass("player") == "Warrior") and (opID ~= 0)) then
		duration = GetSpellCooldown(opID, 1);
		if(IsUsableAction(opAction) and (duration == 0)) then
				CastSpellByName("Overpower");
		end
	end

	-- Auto-Execute
	if((AsmoMOD_Save.executeenabled) and (UnitClass("player") == "Warrior") and (executeID ~= 0)) then
		--Check to see if the target is at 20% or less
		local tpercent;
		tpercent = (UnitHealth("target") / UnitHealthMax("target")) * 100;
		if(tpercent <= 20) then
			if((UnitMana("player") >= 15) and (UnitMana("player") <= AsmoMOD_Save.executerage)) then 
				CastSpellByName("Execute");
			end
		end
	end

	-- Auto-NSheal
	if(AsmoMOD_Save.nsenabled and nsID ~= 1 and ((AsmoMOD_Save.nscombatenabled and inCombat) or (not AsmoMOD_Save.nscombatenabled))) then
		--Check to see if the player is below nspercent
 		local ppercent;
		ppercent = (UnitHealth("player") / UnitHealthMax("player")) * 100;
		if(ppercent <= AsmoMOD_Save.nspercent) then
			duration = GetSpellCooldown(nsID, 1);
			if(duration == 0) then 
				CastSpellByName("Nature's Swiftness");
			end
			SpellStopCasting();
			local i = 1;
			local nsup = AsmoMOD_UnitHasBuff("player", "Spell_Nature_RavenForm");
			if(nsup == 0) then
				return;
			end
			if((UnitClass("player") == "Druid")) then
				duration = GetSpellCooldown(touchID, 1);
				if(duration == 0) then 
					if(UnitIsEnemy("target", "player")) then
						local onPlayer = 0;
						if(UnitName("player") == UnitName("target")) then
							onPlayer = 1;
						end
						TargetUnit("player");
						CastSpellByName("Healing Touch");
						if(onPlayer == 0) then
							TargetLastTarget();
						end
						if (UnitIsDead("target")) then
							TargetNearestEnemy()
						end
					else
						TargetUnit("player");
						CastSpellByName("Healing Touch");
					end
				end
			elseif((UnitClass("player") == "Shaman")) then
				duration = GetSpellCooldown(healID, 1);
				if(duration == 0) then 
					if(UnitIsEnemy("target", "player")) then
						local onPlayer = 0;
						if(UnitName("player") == UnitName("target")) then
							onPlayer = 1;
						end
						TargetUnit("player");
						CastSpellByName("Healing Wave");
						if(onPlayer == 0) then
							TargetLastTarget();
						end
						if (UnitIsDead("target")) then
							TargetNearestEnemy()
						end
					else
						TargetUnit("player");
						CastSpellByName("Healing Wave");
					end
				end
			end
		end
	end	

	-- Mana Conserve
	if(AsmoMOD_Save.conserveenabled and UnitIsFriend("target", "player") and (manastart == 0)) then		
		local cpercent;
		cpercent = (UnitHealth("target") / UnitHealthMax("target")) * 100;
		if(cpercent >= AsmoMOD_Save.conservepercent) then
			SpellStopCasting();
			manastart = 999;
		end
	end

	-- Auto-Find herbs/minerals
	if(AsmoMOD_Save.herbmineenabled and herbmineme == 1) then
		local notBG = true;
		for i=1, MAX_BATTLEFIELD_QUEUES do
			local _, _, instanceID = GetBattlefieldStatus(i);
			if ( instanceID ~= 0 ) then
				notBG = false;
			end
		end
		if (notBG) and (not UnitOnTaxi("player")) and (not UnitIsDeadOrGhost("player")) and (not inCombat)  then
			if(herbID ~= 0) then
				CastSpellByName("Find Herbs");
			end
			if(mineID ~= 0) then
				CastSpellByName("Find Minerals");
			end
			herbmineme = 0;
		end
	end

	-- Auto-Find Treasure
	if(AsmoMOD_Save.findgemenabled and gemme == 1) then
		local notBG = true;
		for i=1, MAX_BATTLEFIELD_QUEUES do
			local _, _, instanceID = GetBattlefieldStatus(i);
			if ( instanceID ~= 0 ) then
				notBG = false;
			end
		end
		if (notBG) and (not UnitOnTaxi("player")) and (not UnitIsDeadOrGhost("player")) and (not inCombat)  then
			if(gemID ~= 0) then
				CastSpellByName("Find Treasure");
			end
			gemme = 0;
		end
	end

	-- Swiftmend Conserve
	if((AsmoMOD_Save.autoswiftenabled) and (swiftme ~= -1) and (swiftID ~= 0)) then
		duration = GetSpellCooldown(swiftID, 1);
		if(duration == 0) then
			local ontar = 0;
			local castbari = getglobal("Asmo_ECB_"..swiftme);
			if(castbari.endTime ~= nil) then
				if(not UnitIsDead(castbari.tindex)) then
					if(UnitName("target") == castbari.name) then
						ontar = 1;
					else
						TargetByName(castbari.name);
					end
					if((not UnitIsDead("target")) and IsUsableAction(swiftAction)) then
						CastSpellByName("Swiftmend");
					end
					if(ontar == 0) then
						TargetLastTarget();
					end
				end
				AsmoMOD_SwiftRemove(castbari.name, swiftme, false);
				swiftme = -1;
			else
				swiftme = -1;
			end
		end
	end

	-- Auto-Emergency Swiftmend Player Only
	if(AsmoMOD_Save.emerswiftenabled and swiftID ~= 0) then
		duration = GetSpellCooldown(swiftID, 1);
		if(duration == 0) then 
			--Check to see if the player is below emerpercent
 			local ppercent;
			ppercent = (UnitHealth("player") / UnitHealthMax("player")) * 100;
			if(ppercent <= AsmoMOD_Save.emerpercent) then
				if(not UnitIsDead("player")) then
					local hotup = AsmoMOD_UnitHasBuff("player", "Spell_Nature_Rejuvenation");
					if(hotup == 0) then
						hotup = AsmoMOD_UnitHasBuff("player", "Spell_Nature_ResistNature");
					end
					if(hotup ~= 0) then
						local ontar = 0;
						if(UnitName("target") == UnitName("player")) then
							ontar = 1;
						else
							TargetUnit("player");
						end
						if(IsUsableAction(swiftAction)) then
							CastSpellByName("Swiftmend");
							local indextoremove = -1;
							for i=0, 4 do
								local castbari = getglobal("Asmo_ECB_"..i);
								if(castbari.name == UnitName("player")) then
									indextoremove = i;
								end
							end
							if(indextoremove ~= -1) then
								AsmoMOD_SwiftRemove(UnitName("player"), indextoremove, false);
							end
						end
						if(ontar == 0) then
							TargetLastTarget();
						end
					end
				end
			end
		end	
	end	

	-- Auto-Emergency Swiftmend Non-Player
	if((AsmoMOD_Save.emerswiftenabled) and (emerlist ~= -1) and (not AsmoMOD_Save.playerswiftonenabled) and (SwiftID ~= 0)) then
		duration = GetSpellCooldown(swiftID, 1);
		if(duration == 0) then
			local castbari = getglobal("Asmo_ECB_"..emerlist);
			local ontar = 0;
			if(not UnitIsDead(castbari.tindex)) then
				if(UnitName("target") == castbari.name) then
					ontar = 1;
				else
					TargetByName(castbari.name);
				end
				if((not UnitIsDead("target")) and IsUsableAction(swiftAction)) then
					CastSpellByName("Swiftmend");
				end
				if(ontar == 0) then
					TargetLastTarget();
				end
			end
			AsmoMOD_SwiftRemove(castbari.name, emerlist, false);
			emerlist = -1;
		end
	end
end

-- Use AutoBreak Abilities
function AsmoMOD_AutoTrinketUse()
	-- Use PvP Trinket if it is equipped and active
	myTrinket0 =  GetInventoryItemLink("player", GetInventorySlotInfo("Trinket0Slot"))
	myTrinket1 =  GetInventoryItemLink("player", GetInventorySlotInfo("Trinket1Slot"))

	if (myTrinket0 == nil) then myTrinket0 = "empty" end
	if (myTrinket1 == nil) then myTrinket1 = "empty" end
		
	if ((string.find(myTrinket0, "Insignia of the Horde") ~= nil) or (string.find(myTrinket0, "Insignia of the Alliance") ~= nil)) then
		myTrinketUse = GetInventorySlotInfo("Trinket0Slot")
	elseif ((string.find(myTrinket1, "Insignia of the Horde") ~= nil) or (string.find(myTrinket1, "Insignia of the Alliance") ~= nil)) then
		myTrinketUse = GetInventorySlotInfo("Trinket1Slot")
	else
		myTrinketUse = nil
	end
	if(myTrinketUse ~= nil) then
		UseInventoryItem(myTrinketUse);
	end
end
	
-- Auto-Release Implimentation
function AsmoMOD_Release()
	if( AsmoMOD_Save.bgrelenabled ) then
		for i=1, MAX_BATTLEFIELD_QUEUES do
			local _, _, instanceID = GetBattlefieldStatus(i);
			if ( instanceID ~= 0 ) then
				local ssup = AsmoMOD_UnitHasBuff("player", "Spell_Shadow_SoulGem");
				if(ssup == 0) then
					RepopMe();
				end
			end
		end
	end
end

-- Auto-Join BG Implimentation
function AsmoMOD_bgJoin()
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, _, _ = GetBattlefieldStatus(i);
		if (status == "confirm") then
			PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
			AcceptBattlefieldPort(i, 1);
			getglobal("StaticPopup1"):Hide();
		end	
	end
end

-- Auto-Ressurect Implimentation
function AsmoMOD_Resurrect()
	AcceptResurrect();
	getglobal("StaticPopup1"):Hide();
end

-- Auto-Repair Equipment Implimentation
function AsmoMOD_RepairEquipment()
	if( (AsmoMOD_Save.repairenabled) and (CanMerchantRepair()) ) then
		RepairAllItems();	
	end
end

-- Auto-Repair Inventory Implimentation
function AsmoMOD_RepairInventory()
	if( (AsmoMOD_Save.repairenabled) and (CanMerchantRepair()) ) then
		local total = GetRepairAllCost();
		total = total + AsmoMOD_GetInventoryCost();
		total = total / 10000;
		AsmoMOD_Chat("All items repaired. Total Cost: " .. total .. " gold.");

		ShowRepairCursor();
		for bag = 0,4,1 do	
			for slot = 1, GetContainerNumSlots(bag) , 1 do
				local hasCooldown, repairCost = GameTooltip:SetBagItem(bag,slot);
				if (repairCost and repairCost > 0) then
					UseContainerItem(bag,slot);
				end
			end
		end
		HideRepairCursor();	
	end
end

-- Get Cost of Repairing Inventory
function AsmoMOD_GetInventoryCost()
	
	local AsmoMOD_InventoryCost = 0;

	for bag = 0,4,1 do	
		for slot = 1, GetContainerNumSlots(bag) , 1 do
			local hasCooldown, repairCost = GameTooltip:SetBagItem(bag,slot);
			if (repairCost) then
				AsmoMOD_InventoryCost = AsmoMOD_InventoryCost + repairCost;
			end
		end
	end

	return AsmoMOD_InventoryCost;
end

-- Auto-Join Group Implimentation
function AsmoMOD_Group()
	if( AsmoMOD_Save.groupenabled ) then
		AcceptGroup();
		AsmoMOD_HideWindow("PARTY_INVITE");
	end
end

-- Automatic Accept Summon Implimentation
function AsmoMOD_Summon()
	ConfirmSummon();
	getglobal("StaticPopup1"):Hide();
end

-- NS-Heal Start
function AsmoMOD_nsheal()
	duration = GetSpellCooldown(nsID, 1);
	if(duration == 0) then 
		CastSpellByName("Nature's Swiftness")
	end
	SpellStopCasting();
	if((UnitClass("player") == "Druid")) then
		duration = GetSpellCooldown(touchID, 1);
		if(duration == 0) then 
			if(UnitIsEnemy("target", "player")) then
				local onPlayer = 0;
				if(UnitName("player") == UnitName("target")) then
					onPlayer = 1;
				end
				TargetUnit("player");
				CastSpellByName("Healing Touch");
				if(onPlayer == 0) then
					TargetLastTarget();
				end
				if (UnitIsDead("target")) then
					TargetNearestEnemy();
				end
			elseif(UnitIsFriend("target", "player")) then
				CastSpellByName("Healing Touch");
			else
				TargetUnit("player");
				CastSpellByName("Healing Touch");
			end
		end
	elseif((UnitClass("player") == "Shaman")) then
		duration = GetSpellCooldown(healID, 1);
		if(duration == 0) then 
			if(UnitIsEnemy("target", "player")) then
				local onPlayer = 0;
				if(UnitName("player") == UnitName("target")) then
					onPlayer = 1;
				end
				TargetUnit("player");
				CastSpellByName("Healing Wave");
				if(onPlayer == 0) then
					TargetLastTarget();
				end
				if (UnitIsDead("target")) then
					TargetNearestEnemy();
				end
			elseif(UnitIsFriend("target", "player")) then
				CastSpellByName("Healing Wave");
			else
				TargetUnit("player");
				CastSpellByName("Healing Wave");
			end
		end
	end
end

-- NS Lightning Start
function AsmoMOD_nslight()
	duration = GetSpellCooldown(nsID, 1);
	if(duration == 0) then 
		CastSpellByName("Nature's Swiftness")
		nslightning = 1;
	end
	SpellStopCasting();
	duration = GetSpellCooldown(LightID, 1);
	if(duration == 0) then 
		if(nslightning == 2) then
			nslightning = 0;
			return;
		end
		nslightning = 2;
		if(UnitIsEnemy("target", "player")) then
			CastSpellByName("Chain Lightning");
		else
			TargetNearestEnemy();
			CastSpellByName("Chain Lightning");
		end
	end
end

-- Feign-Trap Start
function AsmoMOD_feigntrap()
	PetFollow();
	duration = GetSpellCooldown(feignID, 1);
	if(duration == 0) then 
		CastSpellByName("Feign Death")
		feigntrap = 1;
	end
	SpellStopCasting();
	duration = GetSpellCooldown(trapID, 1);
	if(duration == 0) then 
		if(feigntrap == 2) then
			feigntrap = 0;
			return;
		end
		feigntrap = 2;
		CastSpellByName("Freezing Trap");
	end
end

-- Determine if name is in friends list or guild list
function AsmoMOD_FriendGuildCheck(name)

	local i = 1;
	if(IsInGuild()) then
		while true do
			local gname = nil;
			gname = GetGuildRosterInfo(i);
			if(not gname) then
				break;
			end
			if(gname == name) then
				return true;
			end
			i = i + 1;
		end
	end
	
	i = 1;
	local friends = GetNumFriends();
	if(friends ~= 0) then
		while true do
			local fname = nil;
			fname = GetFriendInfo(i);
			if(not fname) then
				return false;
			end
			if(fname == name) then
				return true;
			end
			i = i + 1;
		end
	end
end

-- Hide Popupbox Implimentation
function AsmoMOD_HideWindow(windowToHide)
	local windowIndex
		for windowIndex = 1, STATICPOPUP_NUMDIALOGS do
			local currentFrame = getglobal("StaticPopup" .. windowIndex)
				if currentFrame:IsVisible() and (currentFrame.which == windowToHide) then
					currentFrame:Hide();
				end
		end
end

-- Basic Text send function
function AsmoMOD_Chat(text)
	DEFAULT_CHAT_FRAME:AddMessage(AsmoMOD_Color..text);
end

function AsmoMOD_ChatR(text)
	DEFAULT_CHAT_FRAME:AddMessage(AsmoMOD_ColorR..text);
end

--Timer Functions and Swiftmend Monitor Implimentation
function AsmoMOD_OnUpdate(elapsed)
	local now = GetTime();
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed;

	-- Mana Conserve Spell Timer
	if((AsmoMOD_Save.conserveenabled) and (manastart ~= 0) and (manastart ~= 999)) then
		if(now >= manastart) then
			manastart = 0;
		end
	end

	-- Reset Swiftmend Bar Variables if no HoT is detected within a set time
	if((now >= rejuvreset) and rejuvcheck) then
		rejuvcheck = false;
		rejuvtoadd = nil;
	end
	if((now >= regreset) and growthcheck) then
		growthcheck = false;
		regtoadd = nil;
	end

	-- Someone has attempted to cast rejuv, check to see if the HoT is on the target and if it is,
	-- add it to the swiftmend monitor
	if(AsmoMOD_Save.monitorenabled and rejuvcheck and (TimeSinceLastUpdate >= 0.20)) then
		-- Seamless target switching
		local stayed = 0;

		-- Remove the targeting sound by redirecting the right events to an empty function
		-- I cut away all UI sound because this is in a flash of a second anyhow, and custom target frame
		-- addons would otherwise still play their appearing/disappearing sounds
		local original_PlaySound = PlaySound;
		PlaySound = AsmoMOD_nil;
		
		-- Temporarily clear some error messages which could be shown
		local orig_ERR_UNIT_NOT_FOUND = ERR_UNIT_NOT_FOUND;
		ERR_UNIT_NOT_FOUND = "";
		local orig_ERR_GENERIC_NO_TARGET = ERR_GENERIC_NO_TARGET;
		ERR_GENERIC_NO_TARGET = "";  

		if(UnitName("target") == rejuvtoadd) then
			stayed = 1;
		else 
			TargetByName(rejuvtoadd);
			if(UnitIsDead("target")) then
				rejuvtoadd = nil;
				rejuvcheck = false;
			end
		end

		local foundsame = 0;
		local rejuvup = AsmoMOD_UnitHasBuff("target", "Spell_Nature_Rejuvenation");

		if(rejuvup ~= 0 and rejuvcheck) then
			foundsame = 0;
			for i=0, 4 do
				local labelstring = getglobal("Asmo_ECB_"..i).label;
				if((labelstring ~= nil) and (rejuvtoadd ~= nil)) then
					if((string.find(labelstring, rejuvtoadd) ~= nil) and (string.find(labelstring, "Rejuv") ~= nil)) then
						foundsame = 1;	
						getglobal("Asmo_ECB_"..i).startTime = GetTime();
						getglobal("Asmo_ECB_"..i).active = true;
						getglobal("Asmo_ECB_"..i).endTime = getglobal("Asmo_ECB_"..i).startTime + 12 + FullStormrage;
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetValue(getglobal("Asmo_ECB_"..i).startTime);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetMinMaxValues(getglobal("Asmo_ECB_"..i).startTime, getglobal("Asmo_ECB_"..i).startTime + 12 + FullStormrage);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetStatusBarColor(0, 0, 1, 1);
						getglobal("AsmoFauxTargetBtn"..i):SetScale(1);
						getglobal("AsmoFauxTargetBtn"..i):Show();
						getglobal("Asmo_ECB_"..i):SetScale(1);
						getglobal("Asmo_ECB_"..i):Show();
						getglobal("Asmo_ECB_"..i.."_Icon"):SetTexture("Interface\\Icons\\Spell_Nature_Rejuvenation");
						getglobal("Asmo_ECB_"..i.."_Icon"):Show();
					end
				end
			end
			rejuvtoadd = nil;
			rejuvcheck = false;
			if(foundsame == 0) then
				for i=0, 4 do
					if(not getglobal("Asmo_ECB_"..i).active) then
						getglobal("Asmo_ECB_"..i).startTime = GetTime();
						getglobal("Asmo_ECB_"..i).active = true;
						getglobal("Asmo_ECB_"..i).label = UnitName("target") .." - Rejuv";
						getglobal("Asmo_ECB_"..i).type = "rejuv";
						getglobal("Asmo_ECB_"..i).name = UnitName("target");
						getglobal("Asmo_ECB_"..i).endTime = getglobal("Asmo_ECB_"..i).startTime + 12 + FullStormrage;
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetValue(getglobal("Asmo_ECB_"..i).startTime);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetMinMaxValues(getglobal("Asmo_ECB_"..i).startTime, getglobal("Asmo_ECB_"..i).startTime + 12 + FullStormrage);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetStatusBarColor(0, 0, 1, 1);
						getglobal("AsmoFauxTargetBtn"..i):SetScale(1);
						getglobal("AsmoFauxTargetBtn"..i):Show();
						getglobal("Asmo_ECB_"..i):SetScale(1);
						getglobal("Asmo_ECB_"..i):Show();
						getglobal("Asmo_ECB_"..i.."_Icon"):SetTexture("Interface\\Icons\\Spell_Nature_Rejuvenation");
						getglobal("Asmo_ECB_"..i.."_Icon"):Show();
						break;
					end
				end
			end
		end

		if(stayed == 0) then
			TargetLastTarget();
		end

		-- Restore error messages
		ERR_UNIT_NOT_FOUND = orig_ERR_UNIT_NOT_FOUND;
		ERR_GENERIC_NO_TARGET = orig_ERR_GENERIC_NO_TARGET;
	
		-- Unhook
		PlaySound = original_PlaySound;
	end

	-- Someone has attempted to cast regrowth, check to see if the HoT is on the target and if it is,
	-- add it to the swiftmend monitor
	if(AsmoMOD_Save.monitorenabled and growthcheck and (TimeSinceLastUpdate >= 0.20)) then
		-- Seamless target switching
		local stayed = 0;

		-- Remove the targeting sound by redirecting the right events to an empty function
		-- I cut away all UI sound because this is in a flash of a second anyhow, and custom target frame
		-- addons would otherwise still play their appearing/disappearing sounds
		local original_PlaySound = PlaySound;
		PlaySound = AsmoMOD_nil;
		
		-- Temporarily clear some error messages which could be shown
		local orig_ERR_UNIT_NOT_FOUND = ERR_UNIT_NOT_FOUND;
		ERR_UNIT_NOT_FOUND = "";
		local orig_ERR_GENERIC_NO_TARGET = ERR_GENERIC_NO_TARGET;
		ERR_GENERIC_NO_TARGET = "";  

		if(UnitName("target") == regtoadd) then
			stayed = 1;
		else 
			TargetByName(regtoadd);
			if(UnitIsDead("target")) then
				regtoadd = nil;
				growthcheck = false;
			end
		end


		local regup = AsmoMOD_UnitHasBuff("target", "Spell_Nature_ResistNature");

		if(regup ~= 0 and growthcheck) then
			foundsame = 0;
			for i=0, 4 do
				local labelstring = getglobal("Asmo_ECB_"..i).label;
				if((labelstring ~= nil) and (regtoadd ~= nil)) then
					if((string.find(labelstring, regtoadd) ~= nil) and (string.find(labelstring, "Regrowth") ~= nil)) then
						foundsame = 1;
						getglobal("Asmo_ECB_"..i).startTime = GetTime();
						getglobal("Asmo_ECB_"..i).active = true;
						getglobal("Asmo_ECB_"..i).endTime = getglobal("Asmo_ECB_"..i).startTime + 21;
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetValue(getglobal("Asmo_ECB_"..i).startTime);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetMinMaxValues(getglobal("Asmo_ECB_"..i).startTime, getglobal("Asmo_ECB_"..i).startTime + 21);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetStatusBarColor(0, 0, 1, 1);
						getglobal("AsmoFauxTargetBtn"..i):SetScale(1);
						getglobal("AsmoFauxTargetBtn"..i):Show();
						getglobal("Asmo_ECB_"..i):SetScale(1);
						getglobal("Asmo_ECB_"..i):Show();
						getglobal("Asmo_ECB_"..i.."_Icon"):SetTexture("Interface\\Icons\\Spell_Nature_ResistNature");
						getglobal("Asmo_ECB_"..i.."_Icon"):Show();
					end
				end
			end
			regtoadd = nil;
			growthcheck = false;
			if(foundsame == 0) then
				for i=0, 4 do
					if(not getglobal("Asmo_ECB_"..i).active) then
						getglobal("Asmo_ECB_"..i).startTime = GetTime();
						getglobal("Asmo_ECB_"..i).active = true;
						getglobal("Asmo_ECB_"..i).label = UnitName("target") .." - Regrowth";
						getglobal("Asmo_ECB_"..i).type = "regrowth";
						getglobal("Asmo_ECB_"..i).name = UnitName("target");
						getglobal("Asmo_ECB_"..i).endTime = getglobal("Asmo_ECB_"..i).startTime + 21;
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetValue(getglobal("Asmo_ECB_"..i).startTime);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetMinMaxValues(getglobal("Asmo_ECB_"..i).startTime, getglobal("Asmo_ECB_"..i).startTime + 21);
						getglobal("Asmo_ECB_"..i.."_StatusBar"):SetStatusBarColor(0, 0, 1, 1);
						getglobal("AsmoFauxTargetBtn"..i):SetScale(1);
						getglobal("AsmoFauxTargetBtn"..i):Show();
						getglobal("Asmo_ECB_"..i):SetScale(1);
						getglobal("Asmo_ECB_"..i):Show();
						getglobal("Asmo_ECB_"..i.."_Icon"):SetTexture("Interface\\Icons\\Spell_Nature_ResistNature");
						getglobal("Asmo_ECB_"..i.."_Icon"):Show();
						break;
					end
				end
			end
		end

		if(stayed == 0) then
			TargetLastTarget();
		end

		-- Restore error messages
		ERR_UNIT_NOT_FOUND = orig_ERR_UNIT_NOT_FOUND;
		ERR_GENERIC_NO_TARGET = orig_ERR_GENERIC_NO_TARGET;
	
		-- Unhook
		PlaySound = original_PlaySound;
	end
	
	-- Update the monitor's bars constantly for smooth movement
	local index = -1;
	local timeleft = -1;	

	if((AsmoMOD_Save.monitorenabled) and (UnitClass("player") == "Druid")) then
		for i=0, 4 do	
			index = i;		
			local castbari = getglobal("Asmo_ECB_"..i);
			local fauxi = getglobal("AsmoFauxTargetBtn"..i)
			local now = GetTime();
				
			if(castbari.endTime ~= nil) then
				if(castbari.type ~= "moveable") then
					-- Find if unit is in the player's raidgroup
					if(UnitInRaid("player")) then
						for j=1, 40 do
							if(UnitExists("raid" .. j)) then
								-- If Unit is found in raid get hp info
								if(UnitName("raid" .. j) == castbari.name) then
									castbari.hp = (UnitHealth("raid" .. j) / UnitHealthMax("raid" .. j)) * 100;
									castbari.tindex = "raid" .. j;
									if((UnitName("player") ~= UnitName("raid" .. j)) and AsmoMOD_Save.emerswiftenabled and (castbari.hp <= AsmoMOD_Save.emerpercent) and (not AsmoMOD_Save.playerswiftonenabled)) then
										emerlist = index;
									end
								end	
							end
						end
					end

					-- Find if unit is in player's group
					for j=1, 4 do 
						if(UnitExists("party" .. j)) then
							-- If Unit is found in party get hp info
							if(UnitName("party" .. j) ==castbari.name) then
								castbari.hp = (UnitHealth("party" .. j) / UnitHealthMax("party" .. j)) * 100;
								castbari.tindex = "party" .. j;
								if((UnitName("player") ~= UnitName("party" .. j)) and AsmoMOD_Save.emerswiftenabled and (castbari.hp <= AsmoMOD_Save.emerpercent) and (not AsmoMOD_Save.playerswiftonenabled)) then
									emerlist = index;
								end
							end
							if(UnitName("player") == castbari.name) then
								castbari.hp = (UnitHealth("player") / UnitHealthMax("player")) * 100;
								castbari.tindex = "player";
							end	
						end
					end
				end

				if((castbari.hp ~= nil) and (castbari.type == "regrowth")) then
					castbari.label = castbari.name .."(".. string.format("%3d", castbari.hp) .. "%) - Regrowth";
					local hp = castbari.hp / 100;
					local r, g = 1, 1;
					if ( hp > 0.5 ) then
						r = (1.0 - hp) * 2;
						g = 1.0;
					else
						r = 1.0;
						g = hp * 2;
					end
					if ( r < 0 ) then r = 0; elseif ( r > 1 ) then r = 1; end
					if ( g < 0 ) then g = 0; elseif ( g > 1 ) then g = 1; end
					getglobal("Asmo_ECB_"..i.."_StatusBar"):SetStatusBarColor(r, g, 0, 1);
				elseif(castbari.hp ~= nil) and (castbari.type == "rejuv") then
					castbari.label = castbari.name .."(".. string.format("%3d", castbari.hp) .. "%) - Rejuv";
					local hp = castbari.hp / 100;
					local r, g = 1, 1;
					if ( hp > 0.5 ) then
						r = (1.0 - hp) * 2;
						g = 1.0;
					else
						r = 1.0;
						g = hp * 2;
					end
					if ( r < 0 ) then r = 0; elseif ( r > 1 ) then r = 1; end
					if ( g < 0 ) then g = 0; elseif ( g > 1 ) then g = 1; end
					getglobal("Asmo_ECB_"..i.."_StatusBar"):SetStatusBarColor(r, g, 0, 1);
				end

				-- Update the spark, status bar and label
				local remains = castbari.endTime - now;
				local countup = (now - castbari.startTime);
				timeleft = remains;

				if((3 >= remains) and (AsmoMOD_Save.autoswiftenabled) and (0 <= remains) and (castbari.hp ~= nil)) then
					if(castbari.hp <= AsmoMOD_Save.swiftpercent) then
						swiftme = i;
					end
				end

				--label
				local sparkPos = 195 - ((now - castbari.startTime) / (castbari.endTime - castbari.startTime)) * 195;
				
				getglobal(castbari:GetName() .. "_StatusBar"):SetValue(castbari.endTime - countup);
				getglobal(castbari:GetName() .. "_Text"):SetText( castbari.label );	
				getglobal(castbari:GetName() .. "_StatusBar_Spark"):SetPoint("CENTER", getglobal(castbari:GetName() .. "_StatusBar"), "LEFT", sparkPos, 0);
				getglobal(castbari:GetName() .. "_CastTimeText"):SetText(string.format("%.1f", remains));
				
				if (0 >= remains) then
					if(i == emerlist) then
						emerlist = -1;
					elseif(i == swiftme) then
						swiftme = -1;
					end
					if(castbari.type == "moveable") then
						castbari:EnableMouse(0);
						castbari:StopMovingOrSizing();
						fauxi:EnableMouse(1);
						AsmoMOD_SetBars();
					end
					AsmoMOD_SwiftRemove("nobody", i, true);
				end	
			end
		end
	end

	-- Timer section that updates once every second
	-- Auto-accept timers
	if(TimeSinceLastUpdate > AsmoMOD_UpdateInterval) then

		-- Timers for auto-accepts
		if(bgtime >= 0) then
			bgtime = bgtime - 1;
			AsmoMODBGTime:SetText(bgtime);
			if(bgtime == 0) then
				bgtime = -1;
				AsmoMODBGChoice:Hide();
				AsmoMOD_bgJoin();
			elseif(not getglobal("StaticPopup1"):IsVisible()) then
				bgtime = -1;
				AsmoMODBGChoice:Hide();
			end
		end
		if(reztime >= 0) then
			reztime = reztime - 1;
			AsmoMODRessTime:SetText(reztime);
			if((reztime == 0) or (not getglobal("StaticPopup1"):IsVisible())) then
				reztime = -1;
				AsmoMODRessChoice:Hide();
				AsmoMOD_Resurrect();
			end
		end
		if(sumtime >= 0) then
			sumtime = sumtime - 1;
			AsmoMODSummTime:SetText(sumtime);
			if((sumtime == 0) or (not getglobal("StaticPopup1"):IsVisible())) then
				sumtime = -1;
				AsmoMODSummChoice:Hide();
				AsmoMOD_Summon();
			end
		end
		
		TimeSinceLastUpdate = 0;
	end

	-- Kidney Shot Duration Detect
	if(KidneyCheck == 1) then
		local buffIndex = AsmoMOD_UnitHasBuff("player", "Ability_Rogue_KidneyShot");
		local buffTimeLeft = GetPlayerBuffTimeLeft(buffIndex);
		if(buffTimeLeft >= 2) then
			AutoBreak.stunned = true;
		end
		KidneyCheck = 0;
	end

	-- Auto-Break Reset Timers
	if ((UnitClass("player") == "Warrior") and (AsmoMOD_Save.zerkenabled) and wotflock) then
		local rageup = AsmoMOD_UnitHasBuff("player", "Spell_Nature_AncestralGuardian");
		if(rageup ~= 0) then
			wotflock = false;
			trinketlock = false;
		end
	end
	if ((UnitRace("player") == "Undead") and (AsmoMOD_Save.wotfenabled) and trinketlock) then
		local wotfup = AsmoMOD_UnitHasBuff("player", "Spell_Shadow_RaiseDead");
		if(wotfup ~= 0) then
			trinketlock = false;
		end
	end
	if(now >= resetTimeWotf and wotflock) then
		wotflock = false;
	end
	if(now >= resetTimeTrinket and trinketlock) then
		trinketlock = false;
	end
end

-- Save Functions
function AsmoMOD_LoadVars()
	AsmoMOD.PROFILE = UnitName("player").." of "..GetCVar("RealmName");
	if(AsmoMOD_SavedLoad == nil) then
		AsmoMOD_SavedLoad = {};
		AsmoMOD_ResetBarPos();
	end
	if(AsmoMOD_Save == nil) then
		AsmoMOD_Save = {};
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE] == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE] = {};
		AsmoMOD_Chat("AsmoMOD created profile: " .. AsmoMOD.PROFILE);
	else
		AsmoMOD_Chat("AsmoMOD loaded profile: " .. AsmoMOD.PROFILE);
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgrelenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgrelenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgjoinenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgjoinenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].repairenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].repairenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].rezenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].rezenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].summonenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].summonenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].trinketenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].trinketenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].fearenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].fearenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].entangleenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].entangleenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].impairenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].impairenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nsenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nsenabled = false;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nscombatenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nscombatenabled = false;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].playerswiftonenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].playerswiftonenabled = false;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupfriendonly == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupfriendonly = false;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].minimapenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].minimapenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].escapeenabled == nil) then
		if(UnitRace("player") == "Gnome") then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].escapeenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].escapeenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].wotfenabled == nil) then
		if(UnitRace("player") == "Undead") then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].wotfenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].wotfenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].findgemenabled == nil) then
		if(UnitRace("player") == "Dwarf") then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].findgemenabled = true;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stoneenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].findgemenabled = false;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stoneenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conserveenabled == nil) then
		if((UnitClass("player") == "Priest") or (UnitClass("player") == "Shaman") or (UnitClass("player") == "Druid") or (UnitClass("player") == "Paladin")) then 
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conserveenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conserveenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].monitorenabled == nil) then
		if(UnitClass("player") == "Druid") then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].monitorenabled = true;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].autoswiftenabled = true;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerswiftenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].monitorenabled = false;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].autoswiftenabled = false;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerswiftenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executeenabled == nil) then
		if(UnitClass("player") == "Warrior") then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executeenabled = true;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].overpowerenabled = true;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].zerkenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executeenabled = false;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].overpowerenabled = false;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].zerkenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].riposteenabled == nil) then
		if(RipID ~= 0) then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].riposteenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].riposteenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].herbmineenabled == nil) then
		if((herbID ~= 0) or (mineID ~= 0)) then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].herbmineenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].herbmineenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].counterenabled == nil) then
		if(counterID ~= 0) then
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].counterenabled = true;
		else
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].counterenabled = false;
		end
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nspercent == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nspercent = 20;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservepercent == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservepercent = 80;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].swiftpercent == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].swiftpercent = 80;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerpercent == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerpercent = 20;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgtime == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgtime = 15;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgtime == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgtime = 15;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].reztime == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].reztime = 15;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].sumtime == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].sumtime = 15;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservedelay == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservedelay = 0.3;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executerage == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executerage = 100;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].polymorphenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].polymorphenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stunenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stunenabled = true;
	end
	if(AsmoMOD_SavedLoad[AsmoMOD.PROFILE].charmenabled == nil) then
		AsmoMOD_SavedLoad[AsmoMOD.PROFILE].charmenabled = true;
	end

	-- Update Array with saved data
	AsmoMOD_Save.bgrelenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgrelenabled;
	AsmoMOD_Save.bgjoinenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgjoinenabled;
	AsmoMOD_Save.repairenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].repairenabled;
	AsmoMOD_Save.rezenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].rezenabled;
	AsmoMOD_Save.summonenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].summonenabled;
	AsmoMOD_Save.groupenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupenabled;
	AsmoMOD_Save.trinketenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].trinketenabled;
	AsmoMOD_Save.riposteenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].riposteenabled;
	AsmoMOD_Save.nsenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nsenabled;
	AsmoMOD_Save.executeenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executeenabled;
	AsmoMOD_Save.overpowerenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].overpowerenabled;
	AsmoMOD_Save.conserveenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conserveenabled;
	AsmoMOD_Save.herbmineenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].herbmineenabled;
	AsmoMOD_Save.fearenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].fearenabled;
	AsmoMOD_Save.entangleenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].entangleenabled;
	AsmoMOD_Save.impairenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].impairenabled;
	AsmoMOD_Save.escapeenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].escapeenabled;
	AsmoMOD_Save.zerkenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].zerkenabled;
	AsmoMOD_Save.wotfenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].wotfenabled;
	AsmoMOD_Save.monitorenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].monitorenabled;
	AsmoMOD_Save.autoswiftenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].autoswiftenabled;
	AsmoMOD_Save.emerswiftenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerswiftenabled;
	AsmoMOD_Save.playerswiftonenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].playerswiftonenabled;
	AsmoMOD_Save.nspercent = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nspercent;
	AsmoMOD_Save.conservepercent = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservepercent;
	AsmoMOD_Save.swiftpercent = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].swiftpercent;
	AsmoMOD_Save.emerpercent = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerpercent;
	AsmoMOD_Save.bgtime = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgtime;
	AsmoMOD_Save.reztime = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].reztime;
	AsmoMOD_Save.sumtime = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].sumtime;
	AsmoMOD_Save.conservedelay = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservedelay;	
	AsmoMOD_Save.findgemenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].findgemenabled;
	AsmoMOD_Save.stoneenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stoneenabled;
	AsmoMOD_Save.groupfriendonly = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupfriendonly;
	AsmoMOD_Save.minimapenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].minimapenabled;
	AsmoMOD_Save.executerage = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executerage;
	AsmoMOD_Save.polymorphenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].polymorphenabled;
	AsmoMOD_Save.charmenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].charmenabled;
	AsmoMOD_Save.stunenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stunenabled;
	AsmoMOD_Save.counterenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].counterenabled;
	AsmoMOD_Save.nscombatenabled = AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nscombatenabled;

	-- Correct options frame to saved values
	if(AsmoMOD_Save.bgrelenabled) then
		bgrelenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.bgjoinenabled) then
		bgjoinenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.rezenabled) then
		RessEnabled:SetChecked(1);
	end
	if(AsmoMOD_Save.summonenabled) then
		SummonEnabled:SetChecked(1);
	end
	if(AsmoMOD_Save.repairenabled) then
		repairenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.groupenabled) then
		groupenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.trinketenabled) then
		trinketenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.riposteenabled) then
		riposteenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.nsenabled) then
		nshealenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.executeenabled) then
		executeenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.conserveenabled) then
		conserveenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.herbmineenabled) then
		herbmineenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.overpowerenabled) then
		openabled:SetChecked(1);
	end
	if(AsmoMOD_Save.fearenabled) then
		fearenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.entangleenabled) then
		entangleenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.impairenabled) then
		impairenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.wotfenabled) then
		wotfenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.escapeenabled) then
		escapeenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.zerkenabled) then
		zerkenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.autoswiftenabled) then
		autoswiftenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.emerswiftenabled) then
		emerswiftenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.monitorenabled) then
		swiftmonitorenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.monitorenabled) then
		swiftmonitorenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.playerswiftonenabled) then
		playerswiftonenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.stoneenabled) then
		stoneenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.findgemenabled) then
		findgemenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.groupfriendonly) then
		friendguildenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.polymorphenabled) then
		polymorphenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.stunenabled) then
		stunenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.charmenabled) then
		charmenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.counterenabled) then
		counterenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.nscombatenabled) then
		nscombatenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.minimapenabled) then
		AsmoMOD_SetsFrame:Show();
		mapenabled:SetChecked(1);
	else
		AsmoMOD_SetsFrame:Hide();
		AsmoMOD_ChatR("You have disabled the minimap button.  The only way you can access the options menu is by typing /asmo");
	end
	nshealpercentage:SetValue(AsmoMOD_Save.nspercent);
	conservepercentage:SetValue(AsmoMOD_Save.conservepercent);
	swiftpercent:SetValue(AsmoMOD_Save.swiftpercent);
	emerpercent:SetValue(AsmoMOD_Save.emerpercent);
	restimer:SetValue(AsmoMOD_Save.reztime);
	bgtimer:SetValue(AsmoMOD_Save.bgtime);
	summontimer:SetValue(AsmoMOD_Save.sumtime);
	conservetime:SetValue(AsmoMOD_Save.conservedelay);
	executerage:SetValue(AsmoMOD_Save.executerage);
end

function AsmoMOD_LoadTempVars()
	if(AsmoMOD_Save == nil) then
		AsmoMOD_Save = {};
	end
	AsmoMOD_Save.bgrelenabled = true;
	AsmoMOD_Save.bgjoinenabled = true;
	AsmoMOD_Save.repairenabled =true;
	AsmoMOD_Save.rezenabled = true;
	AsmoMOD_Save.summonenabled = true;
	AsmoMOD_Save.groupenabled = true;
	AsmoMOD_Save.trinketenabled = true;
	AsmoMOD_Save.riposteenabled = true;
	AsmoMOD_Save.nsenabled = true;
	AsmoMOD_Save.executeenabled = true;
	AsmoMOD_Save.overpowerenabled = true;
	AsmoMOD_Save.conserveenabled = true;
	AsmoMOD_Save.herbmineenabled = true;
	AsmoMOD_Save.fearenabled = true;
	AsmoMOD_Save.entangleenabled = true;
	AsmoMOD_Save.impairenabled = true;
	AsmoMOD_Save.escapeenabled = true;
	AsmoMOD_Save.zerkenabled = true;
	AsmoMOD_Save.wotfenabled = true;
	AsmoMOD_Save.monitorenabled = true;
	AsmoMOD_Save.autoswiftenabled = true;
	AsmoMOD_Save.emerswiftenabled = true;
	AsmoMOD_Save.playerswiftonenabled = true;
	AsmoMOD_Save.nspercent = 20;
	AsmoMOD_Save.conservepercent = 20;
	AsmoMOD_Save.swiftpercent = 20;
	AsmoMOD_Save.emerpercent = 20;
	AsmoMOD_Save.bgtime = 15;
	AsmoMOD_Save.reztime = 15;
	AsmoMOD_Save.sumtime = 15;
	AsmoMOD_Save.conservedelay = 0.3;
	AsmoMOD_Save.findgemenabled = true;
	AsmoMOD_Save.stoneenabled = true;
	AsmoMOD_Save.groupfriendonly = true;
	AsmoMOD_Save.minimapenabled = true;
	AsmoMOD_Save.executerage = 50;
	AsmoMOD_Save.autodelayenabled = true;
	AsmoMOD_Save.polymorphenabled = true;
	AsmoMOD_Save.stunenabled = true;
	AsmoMOD_Save.charmenabled = true;
	AsmoMOD_Save.counterenabled = true;
	AsmoMOD_Save.nscombatenabled = true;
end

-- Swiftmend Functions
function AsmoMOD_IDCheck(idvalue)
	if(idvalue == rejuvAction) then
		if(UnitName("target") == nil) then
			rejuvtoadd = UnitName("player");
		else
			rejuvtoadd = UnitName("target");
		end
		rejuvcheck = true;
		rejuvreset = GetTime() + 3;
	end
end

function AsmoMOD_ManualSwift(buttonID)
	if(swiftID ~= 0) then
		duration = GetSpellCooldown(swiftID, 1);
		if(duration == 0) then	
			local ontar = 0;
			if(UnitName("target") == getglobal("Asmo_ECB_"..buttonID).name) then
				ontar = 1;
			else
				TargetByName(getglobal("Asmo_ECB_"..buttonID).name);
			end
			if((UnitName("target") == getglobal("Asmo_ECB_"..buttonID).name) and (not UnitIsDead("target"))) then
				CastSpellByName("Swiftmend");
			end
			if(ontar == 0) then
				TargetLastTarget();
			end
			AsmoMOD_SwiftRemove(getglobal("Asmo_ECB_"..buttonID).name, buttonID, true);
		end
	else
		TargetByName(getglobal("Asmo_ECB_"..buttonID).name);
	end
end

function AsmoMOD_SwiftRemove(name, buttonNumber, controldown)
	local nametwice = 0;
	local rejuvNumber;
	local growthNumber;
	if(not controldown) then
		for i=0, 4 do
			local castbari = getglobal("Asmo_ECB_"..i);
			if(castbari.name == name) then
				nametwice = nametwice + 1;
				if(castbari.type ~= nil) then
					if((string.find(castbari.type, "rejuv") ~= nil)) then
						rejuvNumber = i;
					else
						growthNumber = i;
					end
				end
			end
		end
	end
	if(nametwice == 2) then
		if(growthNumber ~= nil and rejuvNumber ~= nil) then
			if(getglobal("Asmo_ECB_"..growthNumber).endTime < getglobal("Asmo_ECB_"..rejuvNumber).endTime) then
				getglobal("Asmo_ECB_"..growthNumber):Hide();
				getglobal("Asmo_ECB_"..growthNumber).type = nil;
				getglobal("Asmo_ECB_"..growthNumber).name = nil;
				getglobal("Asmo_ECB_"..growthNumber).hp = nil;
				getglobal("Asmo_ECB_"..growthNumber).label = nil;
				getglobal("Asmo_ECB_"..growthNumber).tindex = nil;
				getglobal("Asmo_ECB_"..growthNumber).active = false;
				getglobal("AsmoFauxTargetBtn"..growthNumber):Hide();
				getglobal("Asmo_ECB_"..growthNumber.."_Icon"):Hide();
			else
				getglobal("Asmo_ECB_"..rejuvNumber):Hide();
				getglobal("Asmo_ECB_"..rejuvNumber).type = nil;
				getglobal("Asmo_ECB_"..rejuvNumber).name = nil;
				getglobal("Asmo_ECB_"..rejuvNumber).label = nil;
				getglobal("Asmo_ECB_"..rejuvNumber).hp = nil;
				getglobal("Asmo_ECB_"..rejuvNumber).tindex = nil;
				getglobal("Asmo_ECB_"..rejuvNumber).active = false;
				getglobal("AsmoFauxTargetBtn"..rejuvNumber):Hide();
				getglobal("Asmo_ECB_"..rejuvNumber.."_Icon"):Hide();
			end
		end
	elseif(buttonNumber >= 0) then
		getglobal("Asmo_ECB_"..buttonNumber):Hide();
		getglobal("Asmo_ECB_"..buttonNumber).type = nil;
		getglobal("Asmo_ECB_"..buttonNumber).name = nil;
		getglobal("Asmo_ECB_"..buttonNumber).hp = nil;
		getglobal("Asmo_ECB_"..buttonNumber).tindex = nil;
		getglobal("Asmo_ECB_"..buttonNumber).label = nil;
		getglobal("Asmo_ECB_"..buttonNumber).active = false;
		getglobal("AsmoFauxTargetBtn"..buttonNumber):Hide();
		getglobal("Asmo_ECB_"..buttonNumber.."_Icon"):Hide();
	end
end

-- Disable Auto-Join Temporarily
function AsmoMOD_BGJoinDisable()
	bgtime = -1;
end

function AsmoMOD_RessAcceptDisable()
	reztime = -1;
end

function AsmoMOD_SummAcceptDisable()
	sumtime = -1;
end

-- Show the Options Menu
function AsmoMOD_showMenu()
	PlaySound("igMainMenuOpen");
	AsmoMODOptions:Show();
end

-- Reset Auto-Break Variables
function AsmoMOD_ResetBreakVars()
	AutoBreak.charmed = false;
	AutoBreak.feared = false;
	AutoBreak.polymorphed = false;
	AutoBreak.gouged = false;
	AutoBreak.stunned = false;
	AutoBreak.entangled = false
	AutoBreak.impaired = false;
	AutoBreak.poisoned = false;
	AutoBreak.slept = false;
	KidneyCheck = 0;
end

-- Find if a unit has a specified buff
function AsmoMOD_UnitHasBuff(unit, buffname)
	if(returnNum == nil) then
		returnNum = false;
	end
	local buff;
	local i = 1;
	while true do
		buff = UnitBuff(unit, i);
		if not buff then
      			do break end;
   		end
		if(string.find(buff, buffname) ~= nil) then
			return i;
		end
		i = i + 1;
	end
	return 0;
end

-- Show all buffs on a unit in chat
function AsmoMOD_ShowBuffs()
	local buff;
	local i = 1;
	while true do
		buff = UnitBuff("player", i);
		if not buff then
      			do break end;
   		end
		AsmoMOD_Chat(buff);
		i = i + 1;
	end
end

-- Create a moveable bar to move bars
function AsmoMOD_MoveableBar()
	if(UnitClass("player") == "Druid") then
		for i=0, 4 do
			AsmoMOD_SwiftRemove("nobody", i, true);	
		end
		local frame = getglobal("Asmo_ECB_0");
		local fauxframe = getglobal("AsmoFauxTargetBtn0");
		frame:EnableMouse(1);
		fauxframe:EnableMouse(0);
		frame.startTime = GetTime();
		frame.active = true;
		frame.label = "Move Me!";
		frame.type = "moveable";
		frame.name = nil;
		frame.endTime = frame.startTime + 15;
		getglobal("Asmo_ECB_0_StatusBar"):SetValue(frame.startTime);
		getglobal("Asmo_ECB_0_StatusBar"):SetMinMaxValues(frame.startTime, frame.startTime + 15);
		getglobal("Asmo_ECB_0_StatusBar"):SetStatusBarColor(0, 0, 1, 1);
		fauxframe:SetScale(1);
		fauxframe:Show();
		frame:SetScale(1);
		frame:Show();
		getglobal("Asmo_ECB_0_Icon"):Hide();
	else
		AsmoMOD_ChatR("You are not a druid, you cannot use any Swiftmend Monitor functions.");
	end
end

-- Reset Swiftmend Bar Position
function AsmoMOD_ResetBarPos()
	if(UnitClass("player") == "Druid") then
		AsmoMOD_Chat("Swiftmend Bar Position Reset");
		local frame = getglobal("Asmo_ECB_0");
		local fauxframe = getglobal("AsmoFauxTargetBtn0");
		frame:Hide();
		fauxframe:Hide();
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", "UIParent", 730, -270);

		AsmoMOD_SetBars();
	else
		AsmoMOD_ChatR("You are not a druid, you cannot use any Swiftmend Monitor functions.");
	end
end

-- Set swiftmend Bar Spacing and Iconsize
function AsmoMOD_SetBars()
	for i=1, 4 do
		local o = i - 1;
		if (i <= 4) then
			local frame = getglobal("Asmo_ECB_"..i);
			local fauxframe = getglobal("AsmoFauxTargetBtn"..i);
			frame:SetPoint("TOPLEFT", "Asmo_ECB_"..o, "TOPLEFT", 0, 20);
		end
		local buttonicon = getglobal("Asmo_ECB_"..o.."_Icon");
		buttonicon:SetHeight(20);
		buttonicon:SetWidth(20);
		buttonicon:SetPoint("LEFT", "Asmo_ECB_"..o, "LEFT", -16, 5);
	end
end

-- Nil Function for Targeting
function AsmoMOD_nil()
end