YAK_PARTYIDS = {
   "party1",
   "party2",
   "party3",
   "party4",
   "party5"
}

YAK_PARTYPETIDS = {
   "partypet1",
   "partypet2",
   "partypet3",
   "partypet4",
   "partypet5"
}

function yak_partyiditer(s,i)
   i = i+1
   if (i < 5) and GetPartyMember( i ) then
      return  i,YAK_PARTYIDS[i]
   end
end

function yak_eachPartyID()
    return yak_partyiditer, nil, 0
end

function yak_partypetiditer(s,i)
   i = i+1
   if (i < 5) and GetPartyMember( i ) then
      return  i,YAK_PARTYIDS[i]
   end
end

function yak_eachPartyPetID()
    return yak_partyiditer, nil, 0
end

function  yak_partynameiter(s,i)
   i = i+1
   if (i < 5) and GetPartyMember(i) then
      return i,UnitName(YAK_PARTYIDS[i])
   end
end

function yak_eachPartyName()
    return yak_partynameiter, nil, 0
end

YAK_RAIDIDS = {
   "raid1",
   "raid2",
   "raid3",
   "raid4",
   "raid5",
   "raid6",
   "raid7",
   "raid8",
   "raid9",
   "raid10",
   "raid11",
   "raid12",
   "raid13",
   "raid14",
   "raid15",
   "raid16",
   "raid17",
   "raid18",
   "raid19",
   "raid20",
   "raid21",
   "raid22",
   "raid23",
   "raid24",
   "raid25",
   "raid26",
   "raid27",
   "raid28",
   "raid29",
   "raid30",
   "raid31",
   "raid32",
   "raid33",
   "raid34",
   "raid35",
   "raid36",
   "raid37",
   "raid38",
   "raid39",
   "raid40" }

function yak_raididiter(s,i)
   if i >= GetNumRaidMembers() then --MAX_RAID_MEMBERS then
      return nil
   else
      i = i+1
--      if GetRaidRosterInfo(i) == nil then
--	 return yak_raididiter(s,i+1)
--      else
      return i, YAK_RAIDIDS[i]
--      end
   end
end

function yak_eachRaidID()
    return yak_raididiter, nil, 0
end

YAK_RAIDPETIDS = {
   "raidpet1",
   "raidpet2",
   "raidpet3",
   "raidpet4",
   "raidpet5",
   "raidpet6",
   "raidpet7",
   "raidpet8",
   "raidpet9",
   "raidpet10",
   "raidpet11",
   "raidpet12",
   "raidpet13",
   "raidpet14",
   "raidpet15",
   "raidpet16",
   "raidpet17",
   "raidpet18",
   "raidpet19",
   "raidpet20",
   "raidpet21",
   "raidpet22",
   "raidpet23",
   "raidpet24",
   "raidpet25",
   "raidpet26",
   "raidpet27",
   "raidpet28",
   "raidpet29",
   "raidpet30",
   "raidpet31",
   "raidpet32",
   "raidpet33",
   "raidpet34",
   "raidpet35",
   "raidpet36",
   "raidpet37",
   "raidpet38",
   "raidpet39",
   "raidpet40" }

function yak_raidpetiditer(s,i)
    if i > MAX_RAID_MEMBERS then
        return nil
    else
        i = i+1
        if GetRaidRosterInfo(i) == nil then
	   return yak_raidpetiditer(s,i+1)
        else
	   return i, YAK_RAIDPETIDS[i]
        end
    end
end

function yak_eachRaidPetID()
    return yak_raidpetiditer, nil, 0
end



function yak_nextTankID(t,k)
    local knew
    local vnew
    knew, vnew = next(t,k)
    if knew== nil or vnew == nil then
        return nil
    else
       return knew, YAK_RAIDIDS[vnew[1]]
    end
end


function yak_eachCTRATankID()
    return yak_nextTankID, CT_RATarget.MainTanks, nil
end

