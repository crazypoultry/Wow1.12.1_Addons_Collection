--[[--------------------------------------------------------------------------------
  ItemSync Cleaner Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

local ISync_OptCleanCount = 0;
local ISync_OptCleanCount_Current = 0;
local ISync_OptClean_List = { };


---------------------------------------------------
-- ISync:Cleaner_Load
---------------------------------------------------
function ISync:Cleaner_Load()

	--initiate the timer variables
  	ISync_Cleaner_Timer.Todo = {};
  	ISync_Cleaner_Timer.Todo.n = 0;
  
end


---------------------------------------------------
-- ISync:Cleaner_Update()
---------------------------------------------------
function ISync:Cleaner_Update()

	while(ISync_Cleaner_Timer.Todo[1] and 
	
		ISync_Cleaner_Timer.Todo[1].time <= GetTime()) do
		
		--load the todo variable
		local todo = table.remove(ISync_Cleaner_Timer.Todo,1);
		
		--check if there are arguments if so then load them
		if(todo.args) then
			todo.handler(unpack(todo.args));
		--otherwise run the function
		else
			todo.handler();
		end--if(todo.args) then
		
	end--end while
	
end


---------------------------------------------------
-- ISync:Cleaner_Add()
---------------------------------------------------
function ISync:Cleaner_Add(when,handler,...)

	--load the todo variable
	local todo = {};
	local i = 1;

	--set the time so that we can determine time passed later
	todo.time = when + GetTime();
	--save the handler for processing later
	todo.handler = handler;
	--save the arguements if there are any
	todo.args = arg;
	
	--start the while loop
	while(ISync_Cleaner_Timer.Todo[i] and
	
		--syncronize the time
		ISync_Cleaner_Timer.Todo[i].time < todo.time) do
		i = i + 1;
	end
	
	--insert the finished product into the frame's todo array
	table.insert(ISync_Cleaner_Timer.Todo,i,todo);

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------




---------------------------------------------------
-- ISync:CleanInvalid
---------------------------------------------------
function ISync:CleanInvalid(sNum)
local upNum = 0;
local upNum2 = 0;
local stopChk = 0;
local sParseLink;
local storeProcessedLink;

	if(sNum == 0) then
		ISync_Cleaner_Timer.Todo = {};
  		ISync_Cleaner_Timer.Todo.n = 0;
  		ISync_OptCleanCount = 0;
  		ISync_OptCleanCount_Current = 0;
    		ISync_OptClean_List = nil;
    		ISync_OptClean_List = { };
  		sNum = 1; --MAKE SURE TO SET THIS TO 1
  	end


	--check on database
	if(not ISyncDB) then return nil; end
	if(not ISync_RealmNum) then return nil; end
	if(not ISyncDB[ISync_RealmNum]) then return nil; end
	if(not sNum and ISync_OptCleanCount_Current) then sNum = ISync_OptCleanCount_Current; end
	if(not sNum and ISync_OptCleanCount_Current == 0) then return nil; end
	if(not ISync_OptClean_List) then ISync_OptClean_List = { }; end

	
	--disable the button
	ISYNC_Options_CleanerButton:Disable();
	
	--get the itemcount only if it hasn't been done already
	if(ISync_OptCleanCount == 0) then
	
	
		--get the number of invalids
		for index, value in ISyncDB[ISync_RealmNum] do

			local sChk = ISync:GetData(index, "item");

			if(sChk) then

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..sChk);

				if(not name_X or not link_X) then
					
					--insert it
					table.insert(ISync_OptClean_List, index);
					ISync_OptCleanCount = ISync_OptCleanCount + 1;
				end

			end
		end
		

	
		--check for errors
		if(not ISync_OptCleanCount) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end
			
			--Enable the button
			ISYNC_Options_CleanerButton:Enable();

			return nil;

		elseif(ISync_OptCleanCount == 0) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end

			--Enable the button
			ISYNC_Options_CleanerButton:Enable();
			
			return nil;

		else
			--set the status bar
			ISync_Cleaner_Bar:SetAlpha(1);
			ISync_Cleaner_BarFrameStatusBar:SetStatusBarColor(1, 0, 0);
			ISync_Cleaner_BarFrameStatusBar:SetMinMaxValues(0, ISync_OptCleanCount);
			ISync_Cleaner_Bar:Show();
		end
		
		
		
	else
	
			--set the status bar
			ISync_Cleaner_Bar:SetAlpha(1);
			ISync_Cleaner_BarFrameStatusBar:SetStatusBarColor(1, 0, 0);
			ISync_Cleaner_BarFrameStatusBar:SetMinMaxValues(0, ISync_OptCleanCount);
			ISync_Cleaner_Bar:Show();
		
	
	end

	
	
	
	

	--CHECK AGAIN
	--You cannot have an element of zero
	if(sNum == 0) then sNum = 1; end


	--check count
	if(ISync_OptClean_List[sNum]) then
	
		--lets do 500 of them
		for iCount=sNum , (sNum + 500) , 1 do
		
			--increment
			ISync_OptCleanCount_Current = ISync_OptCleanCount_Current + 1;
		
		
			--do a check
			if(ISync_OptClean_List[iCount]) then
				
				--check the data
				ISync:Clean_ChkData(ISync_OptClean_List[iCount]);
				
			--it doesn't exist so lets break
			elseif(not ISync_OptClean_List[iCount]) then

				break; --break the for loop and end at the bottom
			
			end
		
		
			--check to repeat
			if(ISync_OptClean_List[iCount] and iCount >= (sNum + 500)) then
			
				--fix the count
				if(ISync_OptCleanCount_Current > ISync_OptCleanCount) then 
					ISync_Cleaner_BarText:SetText( ISync_OptCleanCount.."/"..ISync_OptCleanCount );
				else
					ISync_Cleaner_BarText:SetText( ISync_OptCleanCount_Current.."/"..ISync_OptCleanCount );
				end
			
				--do the value
				ISync_Cleaner_BarFrameStatusBar:SetValue(ISync_OptCleanCount_Current);
			
				ISync:Cleaner_Add(4, ISync.CleanInvalid, ISync_OptCleanCount_Current);

				return nil;
				
			end
		
		
		
		
		end--for iCount=sNum , (sNum + 500) , 1 do
	
	end--if(ISync_OptClean_List[sNum]) then


	--clear out
	ISync_OptClean_List = nil;
	

	--everything fails so lets show
	--do a clean first
	ISync:CleanDatabase();
	
	ISync_Cleaner_BarText:SetText( ISync_OptCleanCount_Current.."/"..ISync_OptCleanCount );
	ISync_Cleaner_BarFrameStatusBar:SetValue(ISync_OptCleanCount_Current);
	ISync_Cleaner_Bar:Hide(); --hide it

	DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: "..ISYNC_CLEANER_COMPLETE);

	--Enable the button
	ISYNC_Options_CleanerButton:Enable();

	--do a clean again
	ISync:CleanDatabase();
	
	

end


---------------------------------------------------
-- ISync:Clean_ChkData()
---------------------------------------------------
function ISync:Clean_ChkData(sName)

	if(not sName) then return nil; end
	
	--attach variable
	local index = sName;
	local sParseLink;
	local storeProcessedLink;
	local storeLink;

	---------------------------------------------------------------------------
	--don't do legendary items
	if(index and ISync:GetData(index, "item") and ISync:GetData(index, "info") and ISync:GetData(index, "quality") and tonumber(ISync:GetData(index, "quality")) < 5) then

		storeProcessedLink = nil;
		storeProcessedLink = ISync:GetData(index, "item");

		if(storeProcessedLink) then

			--check link
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..storeProcessedLink);

			--it doesn't exist try to grab tooltip
			if(not name_X or not link_X) then

					ISync_Cleaner_Bar.TooltipButton = this:GetID();
					GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
					GameTooltip:SetHyperlink("item:"..storeProcessedLink);
					GameTooltip:Show();

			end


		end--storeProcessedLink

	end
	------------------------------------------------------------------------------
				


end