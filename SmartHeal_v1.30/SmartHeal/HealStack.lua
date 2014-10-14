SmartHeal.default['healstack']=1
SmartHeal.StackValue=0
SmartHeal.HealStack={}
SmartHeal.AddOnMessagePrefix="SMH"

function SmartHeal:HealStackOnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
end

function SmartHeal:HealStackOnEvent(event)

	if (event=="VARIABLES_LOADED") then

		this:RegisterEvent("SPELLCAST_START")
		this:RegisterEvent("SPELLCAST_STOP")
		this:RegisterEvent("SPELLCAST_FAILED")
		this:RegisterEvent("SPELLCAST_INTERRUPTED")
		this:RegisterEvent("CHAT_MSG_ADDON")
	
	elseif(event=="SPELLCAST_START") then

		SmartHeal.CastedSpell=arg1
		SmartHeal.StackUnitId=SmartHeal.CacheUnitId
		SmartHeal.StackValue=SmartHeal.HealedValue or 0
		if (SmartHeal.StackUnitId=="player" or SmartHeal.StackUnitId=="pet") then
			SmartHeal:HealStackUpdate(UnitName("player").." "..floor(SmartHeal.StackValue))
		else
			SmartHeal:HealStack_OnCast(1)
		end
		
	elseif(event=="SPELLCAST_STOP" or event=="SPELLCAST_INTERRUPTED") then
		
		if (SmartHeal.StackUnitId=="player" or SmartHeal.StackUnitId=="pet") then
			SmartHeal:HealStackUpdate(UnitName("player").." "..floor(SmartHeal.StackValue*-1))
		else
			SmartHeal:HealStack_OnCast(-1)
		end
		
		SmartHeal.CastedSpell=nil
		SmartHeal.StackUnitId=nil
		SmartHeal.StackValue=0
	
	elseif (event=="CHAT_MSG_ADDON" and arg1==SmartHeal.AddOnMessagePrefix) then
		
		SmartHeal:HealStack_ParseMsg()
	
	end

end

function SmartHeal:HealStack_OnCast(stacktype)

	
	if (	not SmartHeal.CastedSpell 
		or not SmartHeal.StackUnitId  
		or not SmartHeal.spellList 
		or (GetNumRaidMembers()==0 and GetNumPartyMembers()==0)
	
	) then return end
	
	local TargetName=UnitName(SmartHeal.StackUnitId)
	
	if (	SmartHeal:getConfig("healstack") 
		and (SmartHeal.spellList[SmartHeal.CastedSpell] and not SmartHeal.spellList[SmartHeal.CastedSpell].HoT)
		and TargetName
	) then
		
		if(not stacktype) then stacktype=1 end
		local msg="STACK "..TargetName.." "..floor(SmartHeal.StackValue*stacktype)
		SendAddonMessage(SmartHeal.AddOnMessagePrefix,msg,"RAID")
	end
	
end

function SmartHeal:HealStack_ParseMsg()

	local _,_,cmd,msg=string.find(arg2,"^(%w+) (.*)")
	if(cmd=="STACK") then
		SmartHeal:HealStackUpdate(msg)
	end


end

function SmartHeal:HealStackUpdate(msg)

	local _,_,TargetName,StackValue=string.find(msg,"^(%w+) (%-?%d+)$")
	
	if (not TargetName or not StackValue) then return end
	
	if (SmartHeal.HealStack[TargetName]) then
		SmartHeal.HealStack[TargetName]=SmartHeal.HealStack[TargetName]+tonumber(StackValue)
	else
		SmartHeal.HealStack[TargetName]=tonumber(StackValue)
	end
	
	if (SmartHeal.HealStack[TargetName]<0) then
		SmartHeal.HealStack[TargetName]=0
	end

end

function SmartHeal:HealStackOnUpdate()

	if (SmartHeal.HealStackUpdating) then return end
	
	SmartHeal.HealStackUpdating=true
	-- HotList
	SmartHeal.HealStackAddOnHook="HealStack"
	SmartHeal:HealStack_StackOnFrame("SH_HotListFrameUnit%d","SH_SMHStackHotList%d",15)
	
	-- CTRA
	if (IsAddOnLoaded("CT_RaidAssist")) then
		SmartHeal.HealStackAddOnHook="CT_RaidAssist"
		SmartHeal:HealStack_StackOnFrame("CT_RAMember%d","SH_SMHSTACKRaid%d",40)
		SmartHeal:HealStack_StackOnFrame("CT_RA_EmergencyFrameFrame%d","SH_SMHSTACKEM%d",5)
		SmartHeal:HealStack_StackOnFrame("CT_RAMTGroupMember%dMTTT","SH_SMHSTACKMTTT%d",10)
		SmartHeal:HealStack_StackOnFrame("CT_RAPTGroupMember%d","SH_SMHSTACKPTGM%d",10)
	end
	-- X-Perl Unitframes
	--if (IsAddOnLoaded("X-Perl UnitFrames Core by |cFFFF8080Zek|r")) then
	--	SmartHeal.HealStackAddOnHook="XPerl"
	--	SmartHeal:HealStack_StackOnFrame("XPerl_raid%d_StatsFrame_HealthBar","SH_SMHSTACKRaid%d",40)
	--	--SmartHeal:HealStack_StackOnFrame("CT_RAMTGroupMember%dMTTT","SH_SMHSTACKMTTT%d",10)
	--end
	
	
	-- Player
	-- Blizzard Player/Pet Frames
	SmartHeal.HealStackAddOnHook="Player"
	SmartHeal:HealStack_StackOnFrame("PlayerFrameHealthBar","SH_SMHSTACKPLAYER")
	SmartHeal:HealStack_StackOnFrame("PetFrameHealthBar","SH_SMHSTACKPET")
	--X-Perl Player/Pet Frames
	--if (IsAddOnLoaded("X-Perl UnitFrames Core by |cFFFF8080Zek|r")) then
	--if (IsAddOnLoaded("X-Perl Player Frame by |cFFFF8080Zek|r")) then
	--	SmartHeal:HealStack_StackOnFrame("XPerl_Player_StatsFrame_HealthBar","SH_SMHSTACKPLAYER")
	--	SmartHeal:HealStack_StackOnFrame("XPerl_Player_Pet_StatsFrame_HealthBar","SH_SMHSTACKPET")
	--end
	
	-- Party
	-- Blizzard Party Frames
	SmartHeal.HealStackAddOnHook="Party"
	SmartHeal:HealStack_StackOnFrame("PartyMemberFrame%d","SH_SMHSTACKPARTY%d",4)
	SmartHeal:HealStack_StackOnFrame("PartyMemberFrame%dPetFrame","SH_SMHSTACKPARTYPET%d",4)
	-- X-Perl Party Frames
	--if (IsAddOnLoaded("X-Perl UnitFrames Core by |cFFFF8080Zek|r")) then
	--	SmartHeal:HealStack_StackOnFrame("XPerl_party%d_StatsFrame_","SH_SMHSTACKPARTY%d",4)
	--	SmartHeal:HealStack_StackOnFrame("XPerl_partypet%d_StatsFrame_","SH_SMHSTACKPARTYPET%d",4)
	--end
	
	SmartHeal.HealStackUpdating=nil

end

function SmartHeal:HealStack_StackOnFrame(pattern,maptopattern,count)

	local unitName,UnitId,HPBarFrameName

	if (count) then
	
		for i=1,count do
			
			local ParentFrameName=string.format(pattern,i)
			
			-- CTRA or HealStack
			if SmartHeal.HealStackAddOnHook=="CT_RaidAssist" or SmartHeal.HealStackAddOnHook=="HealStack" then
				if (pattern=="CT_RAMember%d") then
					UnitId="raid"..i
					unitName= UnitName("raid"..i)
				else
					UnitId=getglobal(ParentFrameName).UnitId
					unitName=getglobal(ParentFrameName).Name
				end
				
				HPBarFrameName=ParentFrameName.."HPBar"

			elseif (SmartHeal.HealStackAddOnHook=="XPerl") then
				
				UnitId="raid"..i
				unitName= UnitName("raid"..i)
				HPBarFrameName=ParentFrameName
			
			elseif SmartHeal.HealStackAddOnHook=="Party" then
				UnitId="party"..i
				unitName=UnitName("party"..i)
				HPBarFrameName=ParentFrameName.."HealthBar"
			end
			
			SmartHeal:DoStackUpdate(UnitId,unitName,HPBarFrameName,string.format(maptopattern,i))
			
		end
	
	else
		
		if SmartHeal.HealStackAddOnHook=="Player" then
			if maptopattern=="SH_SMHSTACKPLAYER" then
				UnitId="player"
				unitName=UnitName("player")
			elseif maptopattern=="SH_SMHSTACKPET" then
				UnitId="pet"
				unitName=UnitName("pet")
			end
			HPBarFrameName=pattern
		end

		SmartHeal:DoStackUpdate(UnitId,unitName,pattern,maptopattern)
	
	end -- end of if count
	

end

function SmartHeal:DoStackUpdate(UnitId,unitName,HPBarName,StackBarName)
	
		if (not unitName) then return end
		
		local HealStackFrameObj=getglobal(StackBarName)
		local HPBarObj=getglobal(HPBarName)
		local StackValue=0
		
		----- Do Stack -----
		if(UnitId and SmartHeal.HealStack[unitName] and SmartHeal.HealStack[unitName]>0) then 
			StackValue=min((UnitHealthMax(UnitId)-UnitHealth(UnitId)),SmartHeal.HealStack[unitName])
		end
		
		if(UnitId and UnitExists(UnitId) and not UnitIsDeadOrGhost(UnitId) and UnitIsConnected(UnitId) and UnitIsVisible(UnitId) 
			and StackValue>0 and HPBarObj and HPBarObj:IsShown()) then

			HealStackFrameObj:SetWidth(StackValue/UnitHealthMax(UnitId)*HPBarObj:GetWidth())
			HealStackFrameObj:SetHeight(HPBarObj:GetHeight())
			HealStackFrameObj:ClearAllPoints()
			HealStackFrameObj:SetParent(HPBarName)
			HealStackFrameObj:SetPoint("TOPLEFT","$parent","TOPLEFT",UnitHealth(UnitId)/UnitHealthMax(UnitId)*HPBarObj:GetWidth(),0)
			HealStackFrameObj:Show()
			
		else
			HealStackFrameObj:Hide()
		end
end

function SmartHeal:GetUnitIdFromName(name1)

	for i=1,40 do
		local name2, rank, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
		if (name1 == name2 and rank) then
		 	return "raid"..i
		end
	end

	return nil

end
