MetaHud_variables = {
	["<spellname>"] = { 
		func    = function(text, unit)
			local time = MetaHud.spellname;
			if time then
				text = MetaHud:gsub(text, '<spellname>', time);
			else
				text = MetaHud:gsub(text, '<spellname>', "");
			end
			return text;
		end,
		events  = { },
		hideval = "", 
	},
    
	["<casttime>"] = { 
		func    = function(text, unit)
			local time = MetaHud.casting_time;
			if time then
				text = MetaHud:gsub(text, '<casttime>', time);
			else
				text = MetaHud:gsub(text, '<casttime>', "");
			end
			return text;
		end,
		events  = { },
		hideval = "", 
	},
    
	["<casttime_remain>"] = { 
		func    = function(text, unit)
			local time = MetaHud.casting_time_rev;
			if time then
				text = MetaHud:gsub(text, '<casttime_remain>', time);
			else
				text = MetaHud:gsub(text, '<casttime_remain>', "");
			end
			return text;
		end,
		events  = { },
		hideval = "", 
	},
    
	["<casttime_delay>"] = { 
		func    = function(text, unit)
			local time = MetaHud.casting_time_del;
			if time then
				if tonumber(time) == 0 then 
					time = "";
				end
				text = MetaHud:gsub(text, '<casttime_delay>', time);
			else
				text = MetaHud:gsub(text, '<casttime_delay>', "");
			end
			return text;
		end,
		events  = { },
		hideval = "", 
	},
    
	["<name>"] = { 
		func    = function(text, unit)
			if unit then
				local unitname = UnitName(unit);
				if unitname then
					text = MetaHud:gsub(text, '<name>', unitname);
				else
					text = MetaHud:gsub(text, '<name>', "");
				end
			end
			return text;
		end,
		events  = { "UNIT_NAME_UPDATE" },
		hideval = "", 
	},
        
	["<hp_percent>"] = { 
		func = function(text, unit)
			local percent = 0;
			local health = UnitHealth(unit);
			local healthmax = UnitHealthMax(unit);
			if (healthmax > 0) then
				percent = math.floor(health/healthmax * 100);
			else
				percent = 0;
			end
			text = MetaHud:gsub(text, '<hp_percent>', percent.."%%");
			return text;
		end,
		events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
		hideval = "0%%", 
	},

	["<hp_value>"] = { 
		func = function(text, unit)
			local h;
			if unit == "target" then
				--- mobhealth2
				if MobHealth_GetTargetCurHP then
					h = MobHealth_GetTargetCurHP();
				--- mobinfo
				elseif MobHealth_PPP and UnitName(unit) and UnitLevel(unit) then
					local mi = UnitName(unit)..":"..UnitLevel(unit);
					local p = MobHealth_PPP(mi);
					h = math.floor(UnitHealth(unit) * p + 0.5);
				--- telos mobhealth
				elseif MobHealthDB and UnitName(unit) and UnitLevel(unit) then
					local mi = UnitName(unit)..":"..UnitLevel(unit);
					local p = MetaHud_MobHealth_PPP(mi);
					h = math.floor(UnitHealth(unit) * p + 0.5);
				--- blizz
				else
					h = UnitHealth(unit);
				end
			else
				h = UnitHealth(unit);
			end
			if ((not h) or h == 0) then 
				h = UnitHealth(unit); 
			end                                
			text = MetaHud:gsub(text, '<hp_value>', h);
			return text;
		end,
		events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
		hideval = "0", 
	},
   
	["<hp_max>"] = { 
		func = function(text, unit)
			local h;
			if unit == "target" then
				--- mobhealth2
				if MobHealth_GetTargetMaxHP and UnitHealth(unit) > 0 then
					h = MobHealth_GetTargetMaxHP();
				--- mobinfo
				elseif MobHealth_PPP and UnitName(unit) and UnitLevel(unit) then
					local mi = UnitName(unit)..":"..UnitLevel(unit);
					local p = MobHealth_PPP(mi);
					h = math.floor(100 * p + 0.5);
				--- telos mobhealth
				elseif MobHealthDB and UnitName(unit) and UnitLevel(unit) then
					local mi = UnitName(unit)..":"..UnitLevel(unit);
					local p = MetaHud_MobHealth_PPP(mi);
					h = math.floor(100 * p + 0.5);
				--- blizz
				else
					h = UnitHealthMax(unit);
				end
			else
				h = UnitHealthMax(unit);
			end
			if ((not h) or h == 0) then 
				h = UnitHealthMax(unit); 
			end                                
			text = MetaHud:gsub(text, '<hp_max>', h);
			return text;
		end,
		events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
		hideval = "0", 
	},
   
	["<hp_diff>"] = { 
		func = function(text, unit)
			local m;
			if unit == "target" then
				--- mobhealth2
				if MobHealth_GetTargetMaxHP and UnitHealth(unit) > 0 then
					m = MobHealth_GetTargetMaxHP();
					h = MobHealth_GetTargetCurHP();
				--- mobinfo
				elseif MobHealth_PPP and UnitName(unit) and UnitLevel(unit) then
					local mi = UnitName(unit)..":"..UnitLevel(unit);
					local p = MobHealth_PPP(mi);
					m = math.floor(100 * p + 0.5);
					h = math.floor(UnitHealth(unit) * p + 0.5);
				--- telos mobhealth
				elseif MobHealthDB and UnitName(unit) and UnitLevel(unit) then
					local mi = UnitName(unit)..":"..UnitLevel(unit);
					local p = MetaHud_MobHealth_PPP(mi);
					m = math.floor(100 * p + 0.5);
					h = math.floor(UnitHealth(unit) * p + 0.5);
				--- blizz
				else
					m = UnitHealthMax(unit);
					h = UnitHealth(unit);
				end
			else
				m = UnitHealthMax(unit);
				h = UnitHealth(unit);
			end
			if ((not h) or h == 0) then 
				m = UnitHealthMax(unit); 
				h = UnitHealth(unit);
			end    
			local d = m - h;                            
			if d > 0 and d < m then
				d = "-"..d;
			else
				d = "";
			end
			text = MetaHud:gsub(text, '<hp_diff>', d);
			return text;
		end,
		events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
		hideval = "", 
	},
   
	["<mp_percent>"] = { 
		func = function(text, unit)
			local percent = 0;
			local mana = UnitMana(unit);
			local manamax = UnitManaMax(unit);
			if (manamax > 0) then
				percent = math.floor(mana/manamax * 100);
			else
				percent = 0;
			end
			text = MetaHud:gsub(text, '<mp_percent>', percent.."%%");
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
		hideval = "0%%", 
	},
  
	["<mp_value>"] = { 
		func = function(text, unit)
			local m = UnitMana(unit);
			text = MetaHud:gsub(text, '<mp_value>', m);
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
		hideval = "0", 
	},
  
	["<mp_value_druid>"] = { 
		func = function(text, unit)
			local dm;
			if UnitPowerType("player") ~= 0 and DruidBarKey then
				dm = math.floor(DruidBarKey.keepthemana);
			else
				dm = "";
			end
			text = MetaHud:gsub(text, '<mp_value_druid>', dm);
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER","UPDATE_SHAPESHIFT_FORMS" },
		hideval = "", 
	},  
  
	["<mp_max_druid>"] = { 
		func = function(text, unit)
			local dm;
			if UnitPowerType("player") ~= 0 and DruidBarKey then
				dm = math.floor(DruidBarKey.maxmana);
			else
				dm = "";
			end
			text = MetaHud:gsub(text, '<mp_max_druid>', dm);
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER","UPDATE_SHAPESHIFT_FORMS" },
		hideval = "", 
	}, 

	["<mp_percent_druid>"] = { 
		func = function(text, unit)
			local dm;
			if UnitPowerType("player") ~= 0 and DruidBarKey then
				dm = math.floor(DruidBarKey.keepthemana / DruidBarKey.maxmana * 100);
			else
				dm = "";
			end
			text = MetaHud:gsub(text, '<mp_percent_druid>', dm);
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER","UPDATE_SHAPESHIFT_FORMS" },
		hideval = "", 
	}, 
      
	["<mp_max>"] = { 
		func = function(text, unit)
			local m = UnitManaMax(unit);
			text = MetaHud:gsub(text, '<mp_max>', m);
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
		hideval = "0", 
	},

	["<mp_diff>"] = { 
		func = function(text, unit)
			local m = UnitManaMax(unit) - UnitMana(unit);
			if m > 0 and m < UnitManaMax(unit) then
				m = "-"..m;
			else
				m = "";
			end
			text = MetaHud:gsub(text, '<mp_diff>', m);
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
		hideval = "", 
	},

	["<color>"] = { 
		func = function(text, unit)
			text = MetaHud:gsub(text, '<color>', '|cff');
			return text;
		end,
		events  = { },
		hideval = "|cff", 
	},

	["</color>"] = { 
		func = function(text, unit)
			text = MetaHud:gsub(text, '</color>', '|r');
			return text;
		end,
		events  = { },
		hideval = "|r", 
	},

	["<level>"] = { 
		func = function(text, unit)
			local level = UnitLevel(unit);
			if level > 90 or level < 0 then
				level = "??";
			end
			text = MetaHud:gsub(text, '<level>', level );
			return text;
		end,
		events  = { "UNIT_LEVEL" },
		hideval = "0", 
	},

	["<color_level>"] = { 
		func = function(text, unit)
			local level = UnitLevel(unit);
			if level < 0 then
				level = 99;
			end
			local color = GetDifficultyColor(level);
			if color and UnitExists(unit) then
				text = MetaHud:gsub(text, '<color_level>', "|cff"..MetaHud_DecToHex(color.r,color.g,color.b) );
			else
				text = MetaHud:gsub(text, '<color_level>', "|cffffffff" );
			end
			return text;
		end,
		events  = { "UNIT_LEVEL" },
		hideval = "|cffffffff", 
	},

	["<color_class>"] = { 
		func = function(text, unit)
			local targetclass, eclass = UnitClass(unit);
			local color = RAID_CLASS_COLORS[eclass or nil];
			if color and UnitExists(unit) then
				text = MetaHud:gsub(text, '<color_class>', "|cff"..MetaHud_DecToHex(color.r,color.g,color.b) );
			else
				text = MetaHud:gsub(text, '<color_class>', "");
			end
			return text;
		end,
		events  = { "UNIT_NAME_UPDATE" },
		hideval = "", 
	},		          

	["<elite>"] = { 
		func = function(text, unit)
			local elite;
			if(MetaHudOptions.showelitetext == 1) then
				elite = MetaHud:CheckElite(unit, 1);
			else
				elite = MetaHud:CheckElite(unit);
			end
			text = MetaHud:gsub(text, '<elite>', elite );
			return text;
		end,
		events  = { "UNIT_CLASSIFICATION_CHANGED" },
		hideval = "", 
	},

	["<color_reaction>"] = { 
		func = function(text, unit)
			local color = MetaHud:GetReactionColor(unit);
			if color and UnitExists(unit) then
				text = MetaHud:gsub(text, '<color_reaction>', "|cff"..color );
			else
				text = MetaHud:gsub(text, '<color_reaction>', "");
			end
			return text;
		end,
		events  = { "UNIT_CLASSIFICATION_CHANGED" },
		hideval = "", 
	},

	["<type>"] = { 
		func = function(text, unit)
			local creatureType = UnitCreatureType(unit);	
			if (UnitIsPlayer(unit)) then creatureType = ""; end
			if MetaHud:TargetIsNPC() then creatureType = ""; end
			if MetaHud:TargetIsPet() then creatureType = ""; end
			text = MetaHud:gsub(text, '<type>', creatureType );
			return text;
		end,
		events  = { "UNIT_CLASSIFICATION_CHANGED" },
		hideval = "", 
	},

	["<class>"] = { 
		func = function(text, unit)
			local targetclass, eclass = UnitClass("target");
			if not UnitIsPlayer(unit) then targetclass = ""; end
			text = MetaHud:gsub(text, '<class>', targetclass );
			return text;
		end,
		events  = { "UNIT_NAME_UPDATE" },
		hideval = "", 
	},

	["<pet>"] = { 
		func = function(text, unit)
			if MetaHud:TargetIsPet() then 
				text = MetaHud:gsub(text, '<pet>', "Pet" );
			else
				text = MetaHud:gsub(text, '<pet>', "" );
			end
			return text;
		end,
		events  = { "UNIT_NAME_UPDATE" },
		hideval = "", 
	},

	["<npc>"] = { 
		func = function(text, unit)
			if MetaHud:TargetIsNPC() then 
				text = MetaHud:gsub(text, '<npc>', "NPC" );
			else
				text = MetaHud:gsub(text, '<npc>', "" );
			end
			return text;
		end,
		events  = { "UNIT_NAME_UPDATE" },
		hideval = "", 
	},

	["<faction>"] = { 
		func = function(text, unit)
			local value = UnitFactionGroup(unit);
			if (not UnitName(unit)) then value = ""; end
			text = MetaHud:gsub(text, '<faction>', value);
			return text;
		end,
		events = {"UNIT_FACTION"},
		hideval = "", 
	},  

	["<combopoints>"] = { 
		func = function(text, unit)
			unit = target;
			local value = GetComboPoints();
			if value == 0 then value = ""; end;
			text = MetaHud:gsub(text, '<combopoints>', value);
			return text;
		end,
		events = {"PLAYER_COMBO_POINTS"},
		hideval = "", 
	},

	["<pvp_rank>"] = { 
		func = function(text, unit)
			local value = GetPVPRankInfo(UnitPVPRank(unit), unit);
			text = MetaHud:gsub(text, '<pvp_rank>', value);
			return text;
		end,
		events = {"UNIT_PVP_UPDATE"} ,
		hideval = "", 
	},

	["<color_hp>"] = { 
		func = function(text, unit)
			local percent;
			local health = UnitHealth(unit);
			local healthmax = UnitHealthMax(unit);
			if (healthmax > 0 and UnitExists(unit) ) then
				percent = health/healthmax;
				local typunit = MetaHud:getTypUnit(unit,"health")
				local color = MetaHud_DecToHex(MetaHud:Colorize(typunit,percent));
				text = MetaHud:gsub(text, '<color_hp>', "|cff"..color );
			else
				text = MetaHud:gsub(text, '<color_hp>', "|cffffffff" );
			end
			return text;
		end,
		events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
		hideval = "|cffffffff", 
	},

	["<color_mp>"] = { 
		func = function(text, unit)
			local percent;
			local health    = UnitMana(unit);
			local healthmax = UnitManaMax(unit);
			local uc        = 0;
			if DruidBarKey and MetaHud.player_class == "DRUID" and unit == "pet" then
				healthmax = DruidBarKey.maxmana;
				health    = DruidBarKey.keepthemana;
				unit      = "player";
				uc        =  1;
			end
			if (healthmax > 0 and UnitExists(unit)) then
				percent = health/healthmax;
				local typunit = MetaHud:getTypUnit(unit,"mana");
				if DruidBarKey and MetaHud.player_class == "DRUID" and uc == 1 then
					typunit = "mana_player";
				end
				local color = MetaHud_DecToHex(MetaHud:Colorize(typunit,percent));
				if uc == 1 and UnitPowerType("player") == 0 then
					color = "ffffff";
				end
				text = MetaHud:gsub(text, '<color_mp>', "|cff"..color);
			else
				text = MetaHud:gsub(text, '<color_mp>', "|cffffffff" );
			end
			return text;
		end,
		events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX" },
		hideval = "|cffffffff", 
	},

	["<raidgroup>"] = { 
		func = function(text, unit)
			local value;
			for i = 1, GetNumRaidMembers() do
				if (UnitIsUnit("raid"..i, unit)) then
					_, _, value = GetRaidRosterInfo(i);
					value = "[grp"..value.." id"..i.."]";
					break;
				end
			end
			if value then
				text = MetaHud:gsub(text, '<raidgroup>', value);
			else
				text = MetaHud:gsub(text, '<raidgroup>', "");
			end
			return text;
		end,
		events = { "RAID_ROSTER_UPDATE" },
		hideval = "", 
	},  

	["<guild>"] = { 
		func = function(text, unit)
			local g = "";
			if(MetaHudOptions["showguild"] == 1) then
				if(GetGuildInfo(unit) ~= nil) then
					g = "|cff00ff00<"..GetGuildInfo(unit)..">|r";
				end
			end
			text = MetaHud:gsub(text, '<guild>', g);
			return text;
		end,
		events = {"UNIT_NAME_UPDATE","PLAYER_TARGET_CHANGED"},
		hideval = "", 
	},    

	["<range>"] = { 
		func = function(text, unit)
			local r = "";
			if(this.onTaxi ~= nil) then
				local destination, started, ended = MetaHud:FlightTimer();
				if(ended ~= nil) then
					r = "|cff00ffff"..destination..": "..MetaHud:FormatTime(this.duration).."  [|r"..MetaHud:FormatTime(ended - GetTime()).."|cff00ffff]";
				else
					r = "|cff00ffff"..destination.."  [|rTiming...|cff00ffff]";
				end
			elseif(UnitExists("target") and MetaHudOptions["showrange"] == 1) then
				local R1,R2,R3,R4,R5;
				if(CheckInteractDistance("target", 1)) then R1 = 1; else R1 = 0; end
				if(CheckInteractDistance("target", 2)) then R2 = 1; else R2 = 0; end
				if(CheckInteractDistance("target", 3)) then R3 = 1;	else R3 = 0; end
				if(CheckInteractDistance("target", 4)) then R4 = 1; else R4 = 0; end
				if(CheckInteractDistance("target", 4) == nil) then R5 = 1; else R5 = 0; end
				if(R1 == 1) then
					r = "|cff00ffffRange:|r|cff"..MetaHud_DecToHex(0,1,0).." 0-5";
				elseif(R2 == 1 or R3 == 1) then
					r = "|cff00ffffRange:|r|cff"..MetaHud_DecToHex(1,1,0).." 5-10";
				elseif(R4 == 1 and R3 == 0) then
					r = "|cff00ffffRange:|r|cff"..MetaHud_DecToHex(1,0.5,0).." 10-28";
				elseif(R5 == 1) then
					r = "|cff00ffffRange:|r|cff"..MetaHud_DecToHex(1,0,0).." 28+";
				end
			end				
			text = MetaHud:gsub(text, '<range>', r);
			return text;
		end,
		events = {  },
		hideval = "", 
    },    

	["<totarget>"] = { 
		func = function(text, unit)
			local tot = "";
			if(UnitExists("targettarget") and MetaHudOptions["showtotarget"] == 1) then
				tot = UnitName("targettarget");
				MetaHud_ToT_Frame:Show();
	      MetaHud_ToTargetHealth_Bar:SetMinMaxValues(0, UnitHealthMax("targettarget"));
	      MetaHud_ToTargetHealth_Bar:SetValue(UnitHealth("targettarget"));
				getglobal("MetaHud_ToTarget_Text"):EnableMouse(true);
				if(UnitIsUnit("player", "targettarget") and UnitIsEnemy("player", "target") and MetaHudOptions["showflash"] == 1) then
					if(not UIFrameIsFading(MetaHud_ToTarget_Text)) then
						UIFrameFlash(MetaHud_ToTarget_Text, 0.25, 0.25, 30, true, 0.15, 0.15);
						if(MetaHudOptions["playsound"] == 1) then
							PlaySoundFile(MetaHud.SoundFile[MetaHudOptions.soundfile]);
						end
					end
				elseif(UIFrameIsFading(MetaHud_ToTarget_Text)) then
					UIFrameFlashRemoveFrame(MetaHud_ToTarget_Text);
				end
				MetaHud_ToTarget_Text:Show();
				MetaHud_ToTarget_Text_Text:Show();
			else
				getglobal("MetaHud_ToTarget_Text"):EnableMouse(false);
				MetaHud_ToT_Frame:Hide();
			end
			text = MetaHud:gsub(text, '<totarget>', tot);
			return text;
		end,
		events = { },
		hideval = "", 
    },    
}
