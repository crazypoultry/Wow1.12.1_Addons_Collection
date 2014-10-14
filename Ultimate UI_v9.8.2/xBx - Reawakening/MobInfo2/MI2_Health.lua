--[[

	Name:		MobHealth2
	Version:	2.6
	Author:		Wyv (wyv@wp.pl)
	Description:	Displays health value for mobs.
			Original version by Telo.
	URL:		http://www.curse-gaming.com/mod.php?addid=1087
			http://ui.worldofwar.net/ui.php?id=681
			http://www.wowinterface.com/downloads/fileinfo.php?id=3938
			
]]


-- Current target data
local lTargetData;

local COLOR_BLUE	= "|c009090FF";
local COLOR_WHITE	= "|c00FFFFFF";
local TITLE		= "|c003060FFMobHealth2"..COLOR_WHITE;


-- to fix a mysterious bug where "MobHealthPlayerDB" was reported as nil
local MobHealthPlayerDB = { };


--------------------------------------------------------------------------------------------------
-- external functions for macros / scripts
--------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- MobHealth_GetTargetCurHP()  
--
-- Return current health points value for the current target as an integer
-- value. Return nil if there is no current target.
--
-- Example:
--   local targetCurrentHealth = MobHealth_GetTargetCurHP();
--   if  targetCurrentHealth  then
--      .......
--   end
-----------------------------------------------------------------------------
function MobHealth_GetTargetCurHP()
	if ( lTargetData ) then
		return math.floor(lTargetData.currentHealthPercent * lTargetData.PPP + 0.5);
	end
	
	return nil;
end  -- of MobHealth_GetTargetCurHP()


-----------------------------------------------------------------------------
-- MobHealth_GetTargetMaxHP()  
--
-- Return maximum health points value for the current target as an integer
-- value. Return nil if there is no current target.
--
-- Example:
--   local targetMaxHealth = MobHealth_GetTargetMaxHP();
--   if  targetMaxHealth  then
--      .......
--   end
-----------------------------------------------------------------------------
function MobHealth_GetTargetMaxHP()
	if ( lTargetData ) then
		return math.floor(100 * lTargetData.PPP + 0.5);
	end		
	
	return nil;
end  -- of MobHealth_GetTargetMaxHP()


-----------------------------------------------------------------------------
-- MobHealth_PPP( index )  
--
-- Return the Points-Per-Percent (PPP) value for a Mob identified by its index.
-- The index is the concatination of the Mob name and the Mob level (see
-- example below). 0 is returned if the PPP value is not available for
-- the given index. The example also shows how to calculate the actual
-- health points from the health percentage and the PPP value
--
-- Example:
--    local name  = UnitName("target");
--    local level = UnitLevel("target");
--    local index = name..":"..level;
--    local ppp = MobHealth_PPP( index );
--    local healthPercent = UnitHealth("target");
--    local curHealth = math.floor( healthPercent * ppp + 0.5);
--    local maxHealth = math.floor( 100 * ppp + 0.5);
-----------------------------------------------------------------------------
function MobHealth_PPP( index )
	if ( index and MobHealthDB[index] ) then
		local s, e;
		local pts;
		local pct;
		
		s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
		if ( pts and pct ) then
			pts = pts + 0;
			pct = pct + 0;
			if ( pct ~= 0 ) then
				return pts / pct;
			end
		end
	end
	return 0;
end

--------------------------------------------------------------------------------------------------
-- Internal functions
--   - all MobHealthDB access functions are left intact for compatiblity
--   - MobHealth is no longer local (but it's not a recomended way to access mob health - even tho
--     it's better than using MobHealthDB directly)
--------------------------------------------------------------------------------------------------

local function MobHealth_Pts(index)
	if ( index and MobHealthDB[index] ) then
		local s, e;
		local val;
		
		s, e, val = string.find(MobHealthDB[index], "^(%d+)/");
		
		if ( val ) then
			return val + 0;
		end
	end
	return 0;
end

local function MobHealth_Pct(index)
	if ( index and MobHealthDB[index] ) then
		local s, e;
		local val;
		
		s, e, val = string.find(MobHealthDB[index], "/(%d+)$");
		
		if ( val ) then
			return val + 0;
		end
	end
	return 0;
end

local function MobHealth_Set(index, pts, pct)
	if ( index ) then
		if ( pts ) then
			pts = pts + 0;
		else
			pts = 0;
		end
		if ( pct ) then
			pct = pct + 0;
		else
			pct = 0;
		end
		if ( pts == 0 and pct == 0 ) then
			MobHealthDB[index] = nil;
		else
			MobHealthDB[index] = pts.."/"..pct;
		end
	end
end



local function MobHealthPlayer_Pts(index)
	if ( index and MobHealthPlayerDB[index] ) then
		local s, e;
		local val;
		
		s, e, val = string.find(MobHealthPlayerDB[index], "^(%d+)/");
		
		if ( val ) then
			return val + 0;
		end
	end
	return 0;
end

local function MobHealthPlayer_Pct(index)
	if ( index and MobHealthPlayerDB[index] ) then
		local s, e;
		local val;
		
		s, e, val = string.find(MobHealthPlayerDB[index], "/(%d+)$");
		
		if ( val ) then
			return val + 0;
		end
	end
	return 0;
end

local function MobHealthPlayer_Set(index, pts, pct)
	if ( index ) then
		if ( pts ) then
			pts = pts + 0;
		else
			pts = 0;
		end
		if ( pct ) then
			pct = pct + 0;
		else
			pct = 0;
		end
		if ( pts == 0 and pct == 0 ) then
			MobHealthPlayerDB[index] = nil;
		else
			MobHealthPlayerDB[index] = pts.."/"..pct;
		end
	end
end

local function MobHealth_Display( currentPct, index )
	local healthText = "";
	local manaText = "";
	
	if ( MI2_MobHealthText ) then
		if ( lTargetData and lTargetData.PPP > 0 ) then
			local maxhp;
			if  MobInfoConfig.StableMax == 1  and  lTargetData.maxHP  then
				maxhp = lTargetData.maxHP;
			else
				maxhp = (100 * lTargetData.PPP) + 0.5;
			end
			if ( currentPct ) then
			    local curhp = (currentPct * lTargetData.PPP) + 0.5
			    if  MobInfoConfig.ShowPercent == 1  then
				    healthText = string.format("%d/%d (%d%%)", curhp, maxhp, math.floor(100.0 * curhp / maxhp));
				else
				    healthText = string.format("%d / %d", curhp, maxhp);
				end
			else
				healthText = string.format("??? / %d", maxhp);
			end
			
            local mana    = UnitMana("target") or 0;
		    local maxmana = UnitManaMax("target") or 0;
		    if  MobInfoConfig.ShowPercent == 1  then
			    manaText = string.format("%d / %d (%d%%)", mana, maxmana, math.floor(100.0 * mana / maxmana));
		    else
			    manaText = string.format("%d / %d", mana, maxmana );
		    end
		end
		
		MI2_MobHealthText:SetText(healthText);
		MI2_MobManaText:SetText(manaText);
	end
end


function MI2_MobHealth_SetPos( )
	MI2_MobHealthText:SetPoint("TOP", "TargetFrameHealthBar", "BOTTOM", MobInfoConfig.HealthPosX, MobInfoConfig.HealthPosY );
	MI2_MobManaText:SetPoint("TOP", "TargetFrameHealthBar", "BOTTOM", MobInfoConfig.HealthPosX, MobInfoConfig.HealthPosY+MobInfoConfig.ManaDistance );
	
	if  lTargetData  then
	  MobHealth_Display( lTargetData.currentHealthPercent, lTargetData.index );
	end
end


function MI2_MobHealth_VariablesLoaded()
	if (not MobHealthDB ) then
		MobHealthDB = { };
	else
		local index, value;
		
		for index, value in MobHealthDB do
			-- Convert the old-style data into the newer, more compact form
			if( type(value) == "table" ) then
				MobHealth_Set(index, value.damPts, value.damPct);
			end
		end
	end
	
	if (not MobHealthConfig ) then
		MobHealthConfig = {};
	end

	if (not MobHealthPlayerDB) then
		MobHealthPlayerDB = {};
	end

end

local function MobHealth_Reset()
	DEFAULT_CHAT_FRAME:AddMessage(TITLE.." reseting database");
	MobHealthDB = {};
	MobHealthConfig = {};
	MobHealthPlayerDB = {}; -- this is not saved variable
end

local function MobHealth_SaveTargetData()
	if (lTargetData) then
		if( lTargetData.PPP > 0 and lTargetData.totalChangeHP < 10000 ) then
			if (lTargetData.mob) then
				MobHealth_Set(lTargetData.index, lTargetData.totalDamagePoints, lTargetData.totalChangeHP);
			else
				MobHealthPlayer_Set(lTargetData.index, lTargetData.totalDamagePoints, lTargetData.totalChangeHP);
			end
		end
	end	
end

local function MobHealth_ClearTargetData()
	if (lTargetData) then
		DEFAULT_CHAT_FRAME:AddMessage(TITLE.." reseting data for "..lTargetData.index);
		lTargetData.PPP = 0;
		lTargetData.firstBattle = true;
		lTargetData.totalDamagePoints = 0;
		lTargetData.totalChangeHP = 0;
		lTargetData.maxHP = nil;

		MobHealth_Display(nil, nil);

		if (lTargetData.mob) then
			MobHealthDB[lTargetData.index] = nil;
		else
			MobHealthPlayerDB[lTargetData.index] = nil;
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(TITLE.." no target with hp information in DB found.");
	end

end


function MI2_MobHealth_CMD(msg)
	local _, _, cmd, param1 = string.find(msg, "(%w+)[ ]?([-%w]*)"); 

  chattext( "MI_DBG: msg=["..msg.."], cmd=["..cmd.."], param1=["..param1.."]" );
  
	if (cmd == "reset" and arg1 == "all") then
		MobHealth_Reset();
	elseif (cmd == "reset" or cmd == "del" or cmd == "delete" or cmd == "rem" or cmd == "remove" or cmd == "clear") then
		MobHealth_ClearTargetData();
	else
		DEFAULT_CHAT_FRAME:AddMessage(TITLE.." commands:");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_BLUE.."  /mobhealth2 pos [position]");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_WHITE.."    set position to [position]");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_WHITE.."    (relative to target frame, default 22, negatives also work)");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_BLUE.."  /mobhealth2 stablemax");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_WHITE.."    updates Max mob HP less often (only in first battle with mob");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_WHITE.."    and between battles)");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_BLUE.."  /mobhealth2 unstablemax");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_WHITE.."    always updates Max mob HP");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_BLUE.."  /mobhealth2 reset all");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_WHITE.."    clears whole database!");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_BLUE.."  /mobhealth2 reset/del/delete/rem/remove/clear");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_WHITE.."    clear data for current target");
	end
end

--------------------------------------------------------------------------------------------------
-- Event handlers
--------------------------------------------------------------------------------------------------

function MI2_MH_EventUnitHealth()
	if (arg1 == "target") then
		if( lTargetData ) then
			local health = UnitHealth("target");
			if( health and health ~= 0 ) then
				local change = lTargetData.currentHealthPercent - health;
				local damage = lTargetData.tempDamagePoints;
				if( change > 0 and damage > 0 ) then
					lTargetData.totalDamagePoints = lTargetData.totalDamagePoints + damage;
					lTargetData.totalChangeHP = lTargetData.totalChangeHP + change;
					if( lTargetData.totalChangeHP ~= 0 and lTargetData.totalDamagePoints ~= 0 ) then
						lTargetData.PPP = lTargetData.totalDamagePoints / lTargetData.totalChangeHP;
					end
					if (lTargetData.firstBattle) then
						-- this is needed for other addons reading directly from DB
						MobHealth_SaveTargetData()
					end
					lTargetData.tempDamagePoints = 0;
				elseif ( change ~= 0 ) then -- could be negative so let's be safe
					lTargetData.tempDamagePoints = 0;
				end
				lTargetData.currentHealthPercent = health;
			    MobHealth_Display(health, lTargetData.index);
			    return true;
			end
		end
		MobHealth_Display( nil, nil );
	end
	return false
end

function MI2_MH_EventUnitCombat()
	if( lTargetData and arg1 == "target" ) then
		lTargetData.tempDamagePoints = lTargetData.tempDamagePoints + arg4;
	end
end

function MI2_MobHealth_OnTargetChange()
	if (lTargetData) then
		-- we have old target, so we should update it's HP in database
		MobHealth_SaveTargetData();
	end

	local name = UnitName("target");
	if( name ) then
		if( UnitCanAttack("player", "target") and not UnitIsDead("target") and not UnitIsFriend("player", "target") ) then
			-- Attackable, alive, non-player target
			lTargetData = { };
			lTargetData.name = name;
			lTargetData.level = UnitLevel("target");
			lTargetData.currentHealthPercent = UnitHealth("target");
			lTargetData.tempDamagePoints = 0;

			if (UnitIsPlayer("target") ) then
				lTargetData.player = true;
				lTargetData.index = lTargetData.name;
				lTargetData.totalDamagePoints = MobHealthPlayer_Pts(lTargetData.index);
				lTargetData.totalChangeHP = MobHealthPlayer_Pct(lTargetData.index);
			else
				lTargetData.mob = true;
				lTargetData.index = lTargetData.name..":"..lTargetData.level;
				lTargetData.totalDamagePoints = MobHealth_Pts(lTargetData.index);
				lTargetData.totalChangeHP = MobHealth_Pct(lTargetData.index);
			end

			
			if( lTargetData.totalChangeHP ~= 0 and lTargetData.totalDamagePoints ~= 0 ) then
				lTargetData.PPP = lTargetData.totalDamagePoints / lTargetData.totalChangeHP;
			else
				lTargetData.PPP = 0;
			end

			if (lTargetData.totalChangeHP == 0) then
				-- first battle with mob/player
				lTargetData.firstBattle = true;
			else
				lTargetData.maxHP = math.floor(lTargetData.PPP * 100 + 0.5);
			end

			MobHealth_Display(lTargetData.currentHealthPercent, lTargetData.index);
			return;
		end
	end

	-- Unusable target
	lTargetData = nil;

	MobHealth_Display(nil, nil);
end

