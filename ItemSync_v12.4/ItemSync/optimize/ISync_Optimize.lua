--[[--------------------------------------------------------------------------------
  ItemSyncCore Optimize Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

local ISync_OptCount = 0;
local ISync_OptCount_Current = 0;
local ISync_Opt_List = { };

---------------------------------------------------
-- ISync:Optimize_Load
---------------------------------------------------
function ISync:Optimize_Load()

	--initiate the timer variables
  	ISync_Optimize_Timer.Todo = {};
  	ISync_Optimize_Timer.Todo.n = 0;
  
end


---------------------------------------------------
-- ISync:Optimize_Update()
---------------------------------------------------
function ISync:Optimize_Update()

	while(ISync_Optimize_Timer.Todo[1] and 
	
		ISync_Optimize_Timer.Todo[1].time <= GetTime()) do
		
		--load the todo variable
		local todo = table.remove(ISync_Optimize_Timer.Todo,1);
		
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
-- ISync:Optimize_Add()
---------------------------------------------------
function ISync:Optimize_Add(when,handler,...)

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
	while(ISync_Optimize_Timer.Todo[i] and
	
		--syncronize the time
		ISync_Optimize_Timer.Todo[i].time < todo.time) do
		i = i + 1;
	end
	
	--insert the finished product into the frame's todo array
	table.insert(ISync_Optimize_Timer.Todo,i,todo);

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------
-- ISync:Optimize
---------------------------------------------------
function ISync:Optimize(sNum)
local upNum = 0;
local sParseLink;
local storeProcessedLink;

	if(sNum == 0) then
		ISync_Optimize_Timer.Todo = {};
  		ISync_Optimize_Timer.Todo.n = 0;
  		ISync_OptCount = 0;
  		ISync_OptCount_Current = 0;
  		ISync_Opt_List = nil;
  		ISync_Opt_List = { };
  		sNum = 1; --MAKE SURE TO SET THIS TO 1
  	end


	--check on database
	if(not ISyncDB) then return nil; end
	if(not ISync_RealmNum) then return nil; end
	if(not ISyncDB[ISync_RealmNum]) then return nil; end
	if(not sNum and ISync_OptCount_Current) then sNum = ISync_OptCount_Current; end
	if(not sNum and ISync_OptCount_Current == 0) then return nil; end
	if(not ISync_Opt_List) then ISync_Opt_List = { }; end
	
	--disable the button
	ISync_OptionsOptimizeButton:Disable();
	
	--get the itemcount only if it hasn't been done already
	if(ISync_OptCount == 0) then
	
		for index, value in ISyncDB[ISync_RealmNum] do
			table.insert(ISync_Opt_List, index);
			ISync_OptCount = ISync_OptCount + 1;
		end
	
		--check for errors
		if(not ISync_OptCount) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end
			
			--Enable the button
			ISync_OptionsOptimizeButton:Enable();

			return nil;

		elseif(ISync_OptCount == 0) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end

			--Enable the button
			ISync_OptionsOptimizeButton:Enable();
			
			return nil;

		else
			--set the status bar
			ISync_Optimize_Bar:SetAlpha(1);
			ISync_Optimize_BarFrameStatusBar:SetStatusBarColor(1, 1, 0);
			ISync_Optimize_BarFrameStatusBar:SetMinMaxValues(0, ISync_OptCount);
			ISync_Optimize_Bar:Show();
		end
		
		
	
	end

	--CHECK AGAIN
	--You cannot have an element of zero
	if(sNum == 0) then sNum = 1; end


	--check count
	if(ISync_Opt_List[sNum]) then
	
		--lets do 500 of them
		for iCount=sNum , (sNum + 500) , 1 do
		
			--increment
			ISync_OptCount_Current = ISync_OptCount_Current + 1;
		
		
			--do a check
			if(ISync_Opt_List[iCount]) then
				
				--check the data
				ISync:Optimize_ChkData(ISync_Opt_List[iCount]);
			
			--it doesn't exist so lets break
			elseif(not ISync_Opt_List[iCount]) then

				break; --break the for loop and end at the bottom
			
			end
		
		
			--check to repeat
			if(ISync_Opt_List[iCount] and iCount >= (sNum + 500)) then
			
				--fix the count
				if(ISync_OptCount_Current > ISync_OptCount) then 
					ISync_Optimize_BarText:SetText( ISync_OptCount.."/"..ISync_OptCount );
				else
					ISync_Optimize_BarText:SetText( ISync_OptCount_Current.."/"..ISync_OptCount );
				end
			
				--do the value
				ISync_Optimize_BarFrameStatusBar:SetValue(ISync_OptCount_Current);
			
				ISync:Optimize_Add(7, ISync.Optimize, ISync_OptCount_Current);

				return nil;
				
			end
		
		
		
		
		end--for iCount=sNum , (sNum + 500) , 1 do
	
	end--if(ISync_Opt_List[sNum]) then


	--clear out
	ISync_Opt_List = nil;
	

	--everything fails so lets show
	--do a clean first
	ISync:CleanDatabase();
	
	ISync_Optimize_BarText:SetText( ISync_OptCount_Current.."/"..ISync_OptCount );
	ISync_Optimize_BarFrameStatusBar:SetValue(ISync_OptCount_Current);
	ISync_Optimize_Bar:Hide(); --hide it

	DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: "..ISYNC_OPTIMIZE_COMPLETE.."!");

	--Enable the button
	ISync_OptionsOptimizeButton:Enable();

	--do a clean again
	ISync:CleanDatabase();
	
	

end



---------------------------------------------------
-- ISync:Optimize_ChkData()
---------------------------------------------------
function ISync:Optimize_ChkData(sName)

	if(not sName) then return nil; end
	
	--attach variable
	local index = sName;
	local sParseLink;
	local storeProcessedLink;
	local storeLink;
	
	---------------------------------------------------------------------------
	if(index and ISync:GetData(index, "item") and ISync:GetData(index, "info")) then

		storeProcessedLink = nil;
		storeProcessedLink = ISync:GetData(index, "item");

		--check link
		local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..storeProcessedLink);

		if(name_X and link_X and ISync_RealmNum) then

			--get id
			sParseLink = nil; --reset
			sParseLink = string.gsub(ISync:GetData(index, "info"), "^(.-):(.-):(.-):(.-):(.-):(.-):(.-):(.-):(.-):(.-)$", "%1");

			--update quality if wrong
			local storeQuality = sParseLink;

			--only continue if there was something
			if(storeQuality and storeQuality ~= "") then
				storeQuality = tonumber(storeQuality);

				--if it doesn't match then store the correct one
				if(storeQuality ~= quality_X) then
					ISync:SetData(index, "quality", quality_X);
				end

			end

			--check the filter!
			--if it's a no no then delete it
			if(not ISync:CheckFilter(quality_X)) then
				ISyncDB[ISync_RealmNum][index] = nil;


			else


				--update the search information
				if(ISync.ParseTooltip and ISyncDB[ISync_RealmNum] and ISyncDB[ISync_RealmNum][index]) then
					UIParent.TooltipButton = 1;
					ISyncTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
					ISyncTooltip:SetHyperlink(link_X);
					ISync:ParseTooltip(index, ISync_RealmNum, storeProcessedLink);
					ISyncTooltip:Hide();
				end


			end

		--CHK INVALIDS
		else

			sParseLink = nil;
			sParseLink = string.gsub(storeProcessedLink, "^(%d+):(%d+):(%d+):(%d+)$", "%1");
			storeLink = storeProcessedLink;

			--make sure we have something
			if(sParseLink and tonumber(sParseLink) and storeLink) then

				--make sure it isn't the same one stored
				if(storeLink ~= tonumber(sParseLink)..":0:0:0") then

					local name_Y, link_Y, quality_Y, minLevel_Y, class_Y, subclass_Y, maxStack_Y = GetItemInfo("item:"..tonumber(sParseLink)..":0:0:0");

					--if we have something to work with check the main database
					if(name_Y and link_Y and not ISyncDB[ISync_RealmNum][name_Y] and ISync:CheckFilter(quality_Y) == 1) then

						--add it
						ISync:SetData(name_Y, "item", tonumber(sParseLink)..":0:0:0");
						ISync:SetData(name_Y, "quality", quality_Y);


						--PARSE TOOLTIP FOR SEARCH OPTIONS
						if(ISync.ParseTooltip) then
							UIParent.TooltipButton = 1;
							ISyncTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
							ISyncTooltip:SetHyperlink(link_Y);
							ISync:ParseTooltip(name_Y, ISync_RealmNum, tonumber(sParseLink)..":0:0:0");
							ISyncTooltip:Hide();
						end


					--already in storage check itemid's
					elseif(name_Y and link_Y and storeLink and ISync:CheckFilter(quality_Y) == 1) then

						if(storeLink ~= tonumber(sParseLink)..":0:0:0") then

							--update it
							ISync:SetData(name_Y, "item", tonumber(sParseLink)..":0:0:0");
							ISync:SetData(name_Y, "quality", quality_Y);

							--PARSE TOOLTIP FOR SEARCH OPTIONS
							if(ISync.ParseTooltip) then
								UIParent.TooltipButton = 1;
								ISyncTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
								ISyncTooltip:SetHyperlink(link_Y);
								ISync:ParseTooltip(name_Y, ISync_RealmNum, tonumber(sParseLink)..":0:0:0");
								ISyncTooltip:Hide();
							end


						end

						--else do nothing

					end


				end--if(storeLink ~= tonumber(sParseLink)..":0:0:0") then


			end--if(sParseLink and tonumber(sParseLink) and storeLink) then


		end--if(name_X and link_X and ISync_RealmNum) then


	end
	------------------------------------------------------------------------------


end

