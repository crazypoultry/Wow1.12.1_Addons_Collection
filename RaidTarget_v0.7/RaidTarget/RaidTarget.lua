--====================================================================================
--== RaidTarget by Imrcly (Shadow Council)                    					    ==
--== Version 0.7                                                                    ==
--====================================================================================


	i = nil;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
	
function RaidTargetSlash(cmd)
	if cmd == "star" then
		i = 1;RaidTargetshape();
	elseif cmd == "circle" then
		i = 2;RaidTargetshape();
	elseif cmd == "diamond" then
		i = 3;RaidTargetshape();
	elseif cmd == "triangle" then
		i = 4;RaidTargetshape();
	elseif cmd == "moon" then
		i = 5;RaidTargetshape();
	elseif cmd == "square" then
		i = 6;RaidTargetshape();
	elseif cmd == "cross" then
		i = 7;RaidTargetshape();
	elseif cmd == "skull" then
		i = 8;RaidTargetshape();
	elseif cmd == "show" then
		RaidTarget:Show();
	else
		DEFAULT_CHAT_FRAME:AddMessage("use /rt /rst or /raidtarget followed by shape");
		DEFAULT_CHAT_FRAME:AddMessage("star circle diamond triangle moon square cross skull");
		DEFAULT_CHAT_FRAME:AddMessage("Works best when facing attackable mob");
		DEFAULT_CHAT_FRAME:AddMessage("using /**** show dispalys gui");
	end
end

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
function RaidTargetOnLoad()
	SLASH_RaidTarget1 = "/raidtarget";
	SLASH_RaidTarget2 = "/rt";
	SLASH_RaidTarget3 = "/rst";
	SlashCmdList["RaidTarget"] = RaidTargetSlash;
	DEFAULT_CHAT_FRAME:AddMessage("You can target now");
end


--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

function RaidTargetshape()
	local t = 8;
	local stop = 0;
	
	for z = 1, 16, 1 do 
		TargetNearestEnemy()
		if (GetRaidTargetIndex("target")==i) then 
			i=-1;break;
		end;
	end; 

	for z=1,40 do 
		if (GetRaidTargetIndex("raid"..z)==i) then 
			TargetUnit("raid"..z);
			i=-1;break;
		end;
	end;
	
	
	if (i>0) then
		for z=1,GetNumPartyMembers(), 1 do
			t="party"..z
			if GetRaidTargetIndex(t)==i then 
				TargetUnit(t);
				i=-1;break;
			end; 
		end;
	end

	if (i>0) then
		for z=1,GetNumRaidMembers(), 1 do
			t="raid"..z.."target"
			if GetRaidTargetIndex(t)==i then 
				TargetUnit(t);
				i=-1;break;
			end; 
		end;
	end
	
	if (i>0) then
		for z = 1, 50, 1 do 
			TargetNearestFriend()
			if (GetRaidTargetIndex("target")==i) then 
				i=-1;break;
			end;
		end; 
	end;
	
	
	if (i>0) then ClearTarget();end;
	
	

end 
