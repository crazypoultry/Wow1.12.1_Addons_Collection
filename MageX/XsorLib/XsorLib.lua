	function IsBuffActive(SpellID) 
		local i = 1;
	  	local Buff = GetSpellTexture(SpellID, 0);
	  	while (UnitBuff("player", i)) do
	    		if (UnitBuff("player", i) == Buff) then
	      			return true;
	    		end
	    		i = i + 1;
	  	end
	  	return false;
	end

	function PlayerHasSpell(spellname)
		local i,done,name,id=1,false;
		while not done do
			name = GetSpellName(i,BOOKTYPE_SPELL);
			if not name then
				done=true;
			elseif name==spellname then
				return true;
			end
			i = i+1;
		end

		return false;
	end



	function GetHigherSpellRank(spellname)
		local rank, RankFound;
		local i,done,name,id=1,false;
		while not done do
			name,rank = GetSpellName(i,BOOKTYPE_SPELL);
			if not name then
				done=true;
			elseif name==spellname then
				id = i;
				RankFound = rank;
			end
			i = i+1;
		end
		if id then return GetRankText(RankFound); end
	end

	function GetHigherRankSpellName(spellname)
		local rank, NameFound;
		local i,done,name,id=1,false;

		NameFound = spellname;
		while not done do
			name,rank = GetSpellName(i,BOOKTYPE_SPELL);
			if not name then
				done=true;
			elseif name==spellname then
				id = i;
				NameFound = name..GetRankText(rank);
			end
			i = i+1;
		end

		return NameFound;
	end

	function GetHigherRankSpellID(spellname)
		local i,done,name,id=1,false;
		id=0;
		while not done do
			name = GetSpellName(i,BOOKTYPE_SPELL);
			if not name then
				done=true;
			elseif name==spellname then
				id = i;
			end
			i = i+1;
		end

		return id;
	end

	function CheckCooldown(SpellID)
		local CooldownIsActive = GetSpellCooldown(SpellID, 0);
  		if (CooldownIsActive == 0) then -- 1 = Cooldown active, 0 = Ready to cast
			return true;
		else
			return false;
		end
	end

	function SelfCastSpell(spellID)
		if(spellID > 0) then
			TargetUnit("player");
			--DEFAULT_CHAT_FRAME:AddMessage("|cffaabbff[Xsor]|r:SelfCastSpell("..spellID..")");
			CastSpell(spellID, BOOKTYPE_SPELL);
			TargetLastTarget();
		end
	end

	function CastSpellOnFriend(spellID)
		if (spellID > 0 and UnitIsFriend("player","target")) then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffaabbff[Xsor]|r:CastSpellOnFriend("..spellID..")");
			CastSpell(spellID, BOOKTYPE_SPELL);
		end
	end

	function CastSpellOnEnemy(spellID)
		if (spellID > 0 and UnitIsEnemy("player","target")) then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffaabbff[Xsor]|r:CastSpellOnEnemy("..spellID..")");
			CastSpell(spellID, BOOKTYPE_SPELL);
		end
	end

function GetRankText(rank)
	if((rank == nil) or (rank == "")) then
		return "";
	else
		return "("..rank..")";
	end
end