local L = AceLibrary("AceLocale-2.2"):new("ag_UnitFrames")

aUF.UnitInformation = {
	["name"] = function(u)
		local type = string.gsub(u, "%d", "")
		if aUF.db.profile[type].RaidColorName and UnitIsPlayer(u) then
			local _,x=UnitClass(u)
			return string.format("%s%s%s",aUF.RaidColors[x] or "",UnitName(u) or "","|cFFFFFFFF")
		else
			return UnitName(u) or ""
		end
	end,
	["status"] = function (u)
		if UnitIsDead(u) then
			return L["Dead"]
		elseif UnitIsGhost(u) then
			return L["Ghost"]
		elseif (not UnitIsConnected(u)) then
			return L["Offline"]
		elseif (UnitAffectingCombat(u)) then
			return L["Combat"]
		elseif (u == "player" and IsResting()) then
			return L["Resting"]
		else
			return ""
		end
	end,
	["statuscolor"] = function (u)
		if UnitIsDead(u) then
			return "|cffff0000"
		elseif UnitIsGhost(u) then
			return "|cff9d9d9d"
		elseif (not UnitIsConnected(u)) then
			return "|cffff8000"
		elseif (UnitAffectingCombat(u)) then
			return "|cffFF0000"
		elseif (u== "player" and IsResting()) then
			return aUF:GiveHex(UnitReactionColor[4].r, UnitReactionColor[4].g, UnitReactionColor[4].b)
		else
			return ""
		end
	end,
	["happycolor"] = function (u) local x=GetPetHappiness() return ( (x==2) and "|cffFFFF00" or (x==1) and "|cffFF0000" or "" ) end,

	["aghp"] = function(u) return aUF:Tag_aghp(u) or "" end,
	["agpercenthp"] = function(u) return aUF:Tag_aghp(u,1) or "" end,
	["agmissinghp"] = function(u) return aUF:Tag_aghp(u,2) or "" end,
	["agsmarthp"] = function(u) return aUF:Tag_aghp(u,3) or "" end,
	
	["agmana"] = function(u) return aUF:Tag_agmana(u) or "" end,
	["agpercentmana"] = function(u) return aUF:Tag_agmana(u,1) or "" end,
	["agmissingmana"] = function(u) return aUF:Tag_agmana(u,2) or "" end,
	["agsmartmana"] = function(u) return aUF:Tag_agmana(u,3) or "" end,
	
	["agclass"] = function (u) if UnitIsPlayer(u) then return (UnitClass(u) or L["Unknown"]) else return (UnitCreatureFamily(u) or UnitCreatureType(u) or "") end end,
	["agrace"] = function (u) if string.find(u,"target") then return UnitRace(u) or "" else return "" end end,
	["agtype"] = function (u) if (UnitIsPlusMob(u)) then return aUF:TargetGetMobType(u) or "" else return "" end end,
	
	["curhp"] = function (u) return UnitHealth(u) or 0 end,
	["maxhp"] = function (u) return UnitHealthMax(u) or 1 end,
	["percenthp"] = function (u) local hpmax = UnitHealthMax(u) return (hpmax ~= 0) and floor((UnitHealth(u) / hpmax) * 100) or 0 end,
	["missinghp"] = function (u) return UnitHealthMax(u) - UnitHealth(u) or 0 end,
	
	["curmana"] = function (u) return UnitMana(u) or 1 end,
	["maxmana"] = function (u) return UnitManaMax(u) or 0 end,
	["percentmana"] = function (u) local mpmax = UnitManaMax(u) return (mpmax ~= 0) and floor((UnitMana(u) / mpmax) * 100) or 0 end,
	["missingmana"] = function (u) return UnitHealthMax(u) - UnitHealth(u) or 0 end,

	["typemana"] = function (u) local p=UnitPowerType(u) return ( (p==1) and L["Rage"] or (p==2) and L["Focus"] or (p==3) and L["Energy"] or L["Mana"] ) end,
	["level"] = function (u) local x = UnitLevel(u) return ((x>0) and x or "??") end,
	["class"] = function (u) return (UnitClass(u) or L["Unknown"]) end,
	["creature"] = function (u) return (UnitCreatureFamily(u) or UnitCreatureType(u) or L["Unknown"]) end,
	["smartclass"] = function (u) if UnitIsPlayer(u) then return aUF.UnitInformation["class"](u) else return aUF.UnitInformation["creature"](u) end end,
	["combos"] = function (u) return (GetComboPoints() or 0) end,
	["combos2"] = function (u) return string.rep("@", GetComboPoints()) end,
	["classification"] = function (u)
		if UnitClassification(u) == "rare" then
			return L["Rare"]
		elseif UnitClassification(u) == "eliterare" then
			return L["Rare Elite"]
		elseif UnitClassification(u) == "elite" then
			return L["Elite"]
		elseif UnitClassification(u) == "worldboss" then
			return L["Boss"]
		else
			return ""
		end
	end,
	["faction"] = function (u) return (UnitFactionGroup(u) or "") end,
	["connect"] = function (u) return ( (UnitIsConnected(u)) and "" or L["Offline"] ) end,
	["race"] = function (u) return ( UnitRace(u) or "") end,
	["pvp"] = function (u) return ( UnitIsPVP(u) and "PvP" or "" ) end,
	["plus"] = function (u) return ( UnitIsPlusMob(u) and "+" or "" ) end,
	["sex"] = function (u) local x = UnitSex(u) return ( (x==0) and L["Male"] or (x==1) and L["Female"] or "" ) end,
	["rested"] = function (u) return (GetRestState()==1 and L["Rested"] or "") end,
	["leader"] = function (u) return (UnitIsPartyLeader(u) and L["(L)"] or "") end,
	["leaderlong"] = function (u) return (UnitIsPartyLeader(u) and L["(Leader)"] or "") end,

	["happynum"] = function (u) return (GetPetHappiness() or 0) end,
	["happytext"] = function (u) return ( getglobal("PET_HAPPINESS"..(GetPetHappiness() or 0)) or "" ) end,
	["happyicon"] = function (u) local x=GetPetHappiness() return ( (x==3) and ":)" or (x==2) and ":|" or (x==1) and ":(" or "" ) end,

	["curxp"] = function (u) return (UnitXP(u) or "") end,
	["maxxp"] = function (u) return (UnitXPMax(u) or "") end,
	["percentxp"] = function (u) local x=UnitXPMax(u) if (x>0) then return floor( UnitXP(u)/x*100+0.5) else return 0 end end,
	["missingxp"] = function (u) return (UnitXPMax(u) - UnitXP(u)) end,
	["restedxp"] = function (u) return (GetXPExhaustion() or "") end,

	["tappedbyme"] = function (u) if UnitIsTappedByPlayer("target") then return "*" else return "" end end,
	["istapped"] = function (u) if UnitIsTapped(u) and (not UnitIsTappedByPlayer("target")) then return L["Tapped"] else return "" end end,
	["pvpranknum"] = function (u) if (UnitPVPRank(u) >= 1) then return ((UnitPVPRank(u)-4) or "") else return "" end end,
	["pvprank"] = function (u) if (UnitPVPRank(u) >= 1) then return (GetPVPRankInfo(UnitPVPRank(u), u) or "" ) else return "" end end,
	["fkey"] = function (u)
		local _,_,fkey = string.find(u, "^party(%d)$")
		if u == "player" then
			fkey = 0
		end
		if not fkey then
			return ""
		else
			return "F"..(fkey+1)
		end
	end,
	["white"] = function (u) return "|cFFFFFFFF" end,
	["aggro"] = function (u)
		local x = (UnitReaction("player",u) or 5)
		return aUF:GiveHex(UnitReactionColor[x].r, UnitReactionColor[x].g, UnitReactionColor[x].b)
	end,
	["difficulty"] = function (u)
		if UnitCanAttack("player",u) then
			local x = (UnitLevel(u)>0) and UnitLevel(u) or 99
			local color = GetDifficultyColor(x)
			return aUF:GiveHex(color.r,color.g,color.b)
		else
			return ""
		end
	end,
	["colormp"] = function (u) local x = ManaBarColor[UnitPowerType(u)] return aUF:GiveHex(x.r, x.g, x.b) end,
	["inmelee"] = function (u) if PlayerFrame.inCombat then return "|cffFF0000" else return "" end end,
	["incombat"] = function (u) if UnitAffectingCombat(u) then return "|cffFF0000" else return "" end end,
	["raidcolor"] = function (u) local _,x=UnitClass(u) if x and UnitIsPlayer(u) then return (aUF.RaidColors[x] or "") else return "" end end,
    ["raidgroup"] = function (u) for i=1, GetNumRaidMembers() do local name, rank, subgroup = GetRaidRosterInfo(i) if (name == UnitName(u)) then return "(" .. subgroup .. ")"  end end return "" end,
}
