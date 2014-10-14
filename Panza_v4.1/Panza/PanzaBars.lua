--[[

PanzaBars.lua
Real-Time Healing Status Support

Revision 4.0

--]]

-- Setup Healing bars Position (All Healing)
-- Function will create 5 on-screen bars allowing for position setting.
-- Data is placed into the PA.Healing database.
-- Panza will see this data and update it as if it were real healing data.

function PA:SetAllHealBarsPosition()
	local i 	= 	nil;
	local bars	=	1;
	local names = {
			[1] = "Sam",
			[2] = "Anne",
			[3] = "Stephan",
			[4] = "Tom",
			[5] = "Ian",
			[6] = "Jross",
			[7] = "Lei",
			[8] = "Mike",
			[9] = "Jerry",
			[10] = "George",
			};
	
	if (PASettings.Heal.Bars.OwnBars==true) then
	
		-- Setup Initial Current Heal Status Bars
		-----------------------------------------
		PanzaFrame_HealCurrentSpell.isLocked=0;
		PanzaFrame_HealCurrentSpell:SetMinMaxValues(0, 20);
		PanzaFrame_HealCurrentSpell:SetValue(20);
		PanzaFrame_HealCurrentTarget:SetMinMaxValues(0, UnitHealthMax("player"));
		PanzaFrame_HealCurrentTarget:SetValue(UnitHealth("player") * 0.40);
		PanzaFrame_HealCurrentAfter:SetMinMaxValues(0, UnitHealthMax("player") * 1.50);
		PanzaFrame_HealCurrentAfter:SetValue(UnitHealth("player"));
		PanzaFrame_HealCurrent:Show();
		PA:PHMAdvanced_UpdateBarLock();
	
	end
	
	-- Set Test Flag and Reset Timers
	---------------------------------
	PA.BarTest = true;
	PA.Cycles.Spell.BarsCheckTimer = 0.0
	PA.Cycles.Spell.BarsTestTimer = 0.0
	
	-- Create Dummy PA.Heal Data 
	----------------------------
	
	local casttime	=	15;
	local healtype	=	"HEAL";
	local spell		=	"Heal"
	local hot		=	0;

	if (PASettings.Heal.Bars.OtherBars==true) then
		-- Create 5 dummy healing spells using 5 open slots in the set of 20 available windows.
		-- healing 5 targets between 440 and 2048 between 30 and 60 secs with a cast time of 60 secs.
		
		-- Unlock these bars
		PanzaFrame_HealBars1.isLocked=0;
		PA:PHMAdvanced_UpdateBarLock();
				
		for i = 1, 20 do
			local author = names[math.random(1,10)];
			local who = names[math.random(1,10)];
			local heal = math.random(440,2048);
			local timeleft = math.random(10,20);
	
			PA.Healing[who] = (PA.Healing[who] or {});
			PA.Healing[who][author] = (PA.Healing[who][author] or {});
			PA.Healing[who][author][healtype] = (PA.Healing[who][author][healtype] or {});
		
			PA.Healing[who][author][healtype]["CastTime"] = casttime;
			PA.Healing[who][author][healtype]["TimeLeft"] = timeleft;
			PA.Healing[who][author][healtype]["Heal"] = heal;
			PA.Healing[who][author][healtype]["HoT"] = hot;
			PA.Healing[who][author][healtype]["Spell"] = spell;
			PA.Healing[who][author][healtype]["Status"] = "Active";
	
			bar = getglobal("PanzaFrame_HealBars" .. i);
		
			-- Reset all Bars
			bar:SetMinMaxValues(666, 1337);
		
			if (bar:GetMinMaxValues() == 666) then
				PA.Healing[who][author][healtype]["Bar"] = i;

				bar:SetMinMaxValues(0, PA.Healing[who][author][healtype]["CastTime"]);
				bar:SetValue(timeleft);
				getglobal(bar:GetName() .. "Text"):SetText(author .. " (" .. string.format('%.0f',PA.Healing[who][author][healtype]["Heal"]) .. ") -> " .. who);
		
				getglobal(bar:GetName() .. "BarTexture"):SetVertexColor(1.0, 0.7, 0.0, 0.5);
				bar:SetAlpha(1.0);
				bar:Show();
				bars = bars + 1;
			end	
		
			-- check that we only create 5 bars
			if (bars == 5) then
				i = 20;
			end	
		end	
	end
end	

--------------------------------------
-- Tooltip Function
--------------------------------------
function PA:Bars_ShowTooltip(item)
	GameTooltip:SetOwner(item, "ANCHOR_TOPRIGHT", 0, 10);
	GameTooltip:ClearLines();
	GameTooltip:AddLine( PA.Bars_Tooltips[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PA.Bars_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end

