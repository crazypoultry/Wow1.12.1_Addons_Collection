--[[--------------------------------------------------------------------------------
  Duplicated_ItemChk Parse Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]


---------------------------------------------------
-- ISync:Duplicated_ItemChk
---------------------------------------------------
function ISync:Duplicated_ItemChk()


	--This function only removes items that are duplicated and of the rarity, gray, white, and green.
	--Items that are beyond this rarity are not touched in any way


	local iNew, iLost, index, value;

	ISync_Dup_SortIndex 	= { };

	if(not ISyncDB) then return nil; end
	if(not ISync_RealmNum) then return nil; end
	if(not ISyncDB[ISync_RealmNum]) then return nil; end

	--set default
	iNew = 1;

	--do the loop for regular name search
	for index, value in ISyncDB[ISync_RealmNum] do


		--now check to see if we have already added it
		if(ISync_Dup_SortIndex[index]) then

			--delete it
			ISyncDB[ISync_RealmNum][index] = nil;
		else
			--add it cause it's new
			ISync_Dup_SortIndex[index] = iNew; 

			iNew = iNew + 1;

		end

		

	end
	
	--reset
	ISync_Dup_SortIndex 	= nil;
	ISync_Dup_SortIndex 	= { };

	--set default
	iNew = 1;
	
	--do the loop for itemid duplicate check
	for index, value in ISyncDB[ISync_RealmNum] do

		local s1, s2, sParseInfo = string.find(value, "»(.-)»");

		if(sParseInfo) then
		
			--now check to see if we have already added it
			if(ISync_Dup_SortIndex[sParseInfo]) then

				--delete it
				ISyncDB[ISync_RealmNum][index] = nil;
			else
				--add it cause it's new
				ISync_Dup_SortIndex[sParseInfo] = iNew; 

				iNew = iNew + 1;

			end
		
		end

		

	end
	
	


	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_DUPEITEMDELETED..".|r");
	end

	ISync_Dup_SortIndex 	= nil;
	ISync:Main_Refresh();

		
		
end