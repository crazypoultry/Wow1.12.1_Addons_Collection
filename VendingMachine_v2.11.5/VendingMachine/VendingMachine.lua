--Auther: Watermaker of kalecgos
--Version: 2.11.5 



--saved variables
VM_TOTAL_WATER_LIFETIME = {0,0,0,0,0,0,0};
VM_REPORT_OPTIONS = {["MinW"] = 1,["MinF"] = 1,["MaxF"] = 7,["MaxW"] = 7,["medium"] = 1};
VM_GENERAL_OPTIONS = {["autowelcome"] = true}
VM_TOTAL_FOOD_LIFETIME = {0,0,0,0,0,0,0};


--global variables
VM_lastCastWater = false; --true if last spell cast was food/water
VM_itemsQued = 0; --number of casts of food & water not yet acounted for
VM_mediumNames = {}; --mediums for reporting
VM_tradeReady = false; --items are in and mod is ready to trade them
VM_sortVariables = 0; --global variables used by the sort alg.

VM_foodNames = {""}; --names of each rank of food
VM_waterNames = {""}; --names of each rank of water

VM_foodCCs = nil -- # of food conjured per cast for each rank
VM_waterCCs = nil;-- # of food conjured per cast for each rank

VM_highestFood = nil;  --rank of highest food
VM_highestWater = nil; --rank of highest water

--counts of water in inventory and made this session
VM_totalWaterSession = {0,0,0,0,0,0,0};
VM_currentWaterCount = {-1,-1,-1,-1,-1,-1,-1};
VM_totaFoodSession = {0,0,0,0,0,0,0};
VM_currentFoodCount = {-1,-1,-1,-1,-1,-1,-1};

--Debug variables
VM_debug = false; -- set to false for debuging
--VM_debug = true; -- set to false for debuging
VM_sortInstance = 0;



function VM_onLoad()
	
	--do not load if its not a mage
    if(not (UnitClass("player") ==  "Mage")) then
    	return
    end

	VM_foodNames = {
		"Conjured Muffin",
		"Conjured Bread",	
		"Conjured Rye",	
		"Conjured Pumpernickle",	
		"Conjured Sourdough",	
		"Conjured Sweet Roll",	
		"Conjured Cinnamon Roll"};
	VM_waterNames = {
		"Conjured Water",
		"Conjured Fresh Water",	
		"Conjured Purified Water",	
		"Conjured Spring Water",	
		"Conjured Mineral Water",	
		"Conjured Sparkling Water",	
		"Conjured Crystal Water"};

  	VM_init(0); -- initialize local variables
    
	--slash cmds
	SLASH_VM1 = "/vm";
	SlashCmdList["VM"] = VM_command;

	--water creation and counts
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("BAG_UPDATE");

	--trade management
	this:RegisterEvent("TRADE_SHOW");
	this:RegisterEvent("TRADE_ACCEPT_UPDATE");
	this:RegisterEvent("TRADE_CLOSED");
	this:RegisterEvent("TRADE_MONEY_CHANGED");
	this:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
	this:RegisterEvent("TRADE_REQUEST");
	this:RegisterEvent("TRADE_REQUEST_CANCEL");

	--farmer ward and autoreply
	--like fire ward but it can't be improved to reflect
	--coming soon
	this:RegisterEvent("CHAT_MSG_WHISPER");
	DEFAULT_CHAT_FRAME:AddMessage("Vedning Machine version 2.11.5 loaded! Type /vm for a command list", 0,0,200);
end

function VM_otherEvent(ename)
--	if(VM_tradeReady and VMAutoTrade:GetChecked()) then
--		AcceptTrade();
--	end
  	VM_msg("Event: "..ename, 255,255,255);
--  	water_made = false;
end

--trade tools

function VM_tradeShow()
	VM_tradeReady = false;
	--width of TradeFrame = 384	
	VM_TradeAssistFrame:Show();
	VM_WaterLable:SetText("Water: "..VM_currentWaterCount[VM_highestWater])
	VM_FoodLable:SetText("Food: "..VM_currentFoodCount[VM_highestFood])
	
end

function VM_tradeClose()
	VM_TradeAssistFrame:Hide();
end

function VM_tradeFood(stacks)
	VM_doTrade(stacks, VM_foodNames[VM_highestFood]);
end

function VM_tradeWater(stacks)
	VM_doTrade(stacks, VM_waterNames[VM_highestWater]);
end

function VM_doTrade(stacks, iname)
	local lastBag, lastSlot;
	local lastSize = 0;
	local currentStack = 1
	local itemsSkipped = 0;
	local openSlots = {};
	local openSlotCount = 0;
	
	for slot=1,6 do
		if(GetTradePlayerItemLink(slot) == nil) then
			openSlotCount = openSlotCount + 1;
			openSlots[openSlotCount] = slot;
		end
	end
	
	if(stacks > openSlotCount) then
		local msg = "VendingMachine: Errror: Not enoug slots";
		msg = msg .. "open in trade window! " .. openSlotCount;
		msg = msg .. " items will be added.";
		DEFAULT_CHAT_FRAME:AddMessage(msg, 255,0,0)
		stacks = openSlotCount;
		if(stacks == 0) then return end
	end
	
--	local waterGiven = 0;
--	local waterNeeded = 20 * stacks;
	
	for bag=0,4 do
	   	for slot=1,GetContainerNumSlots(bag) do
     		if (GetContainerItemLink(bag,slot)) then
    	   		if (string.find(GetContainerItemLink(bag,slot), iname)
       				and currentStack <= stacks ) then
					local t, count, l, q, r = GetContainerItemInfo(bag, slot)
        			if(count == 20) then
        				PickupContainerItem(bag,slot);
       					ClickTradeButton(openSlots[currentStack]);
        				currentStack = currentStack + 1;
					else
						--remeber the biggest stack
						if(count>lastSize) then
       						lastBag = bag;
    	   					lastSlot = slot;
	       					lastSize = count;
       					end
        			end
       			end
			end
  		end
	end
	
	--if we ran out, put the biggest incomplete stack in the trade
	if(currentStack <= stacks) then
        PickupContainerItem(lastBag,lastSlot);
       	ClickTradeButton(openSlots[currentStack]);
	end

	VM_tradeReady = true;
	if(VMAutoTrade:GetChecked()) then
		AcceptTrade();
	end
end

function VM_showStats()
	for rank=1,7 do
		getglobal("VM_SW".. rank):SetText(tostring(VM_totalWaterSession[rank]))
		getglobal("VM_SF".. rank):SetText(tostring(VM_totaFoodSession[rank]));
		getglobal("VM_LW".. rank):SetText(tostring(VM_TOTAL_WATER_LIFETIME[rank]));
		getglobal("VM_LF".. rank):SetText(tostring(VM_TOTAL_FOOD_LIFETIME[rank]));
	end
	VM_StatsFrame:Show();
	
	--set saved options
	if(VM_REPORT_OPTIONS == {}) then
		return;
	end
	local opts = VM_REPORT_OPTIONS; --it will make the lines shorter
DEFAULT_CHAT_FRAME:AddMessage("med: " .. opts.medium);
	UIDropDownMenu_SetSelectedID(VM_MediumDD, 1);
	UIDropDownMenu_SetSelectedID(VM_MinWaterDD, opts.MinW);
	UIDropDownMenu_SetSelectedID(VM_MinFoodDD, opts.MinF);	
	UIDropDownMenu_SetSelectedID(VM_MaxWaterDD, opts.MaxW);
	UIDropDownMenu_SetSelectedID(VM_MaxFoodDD, opts.MaxF);
	
	--for those of you [atmepting] to follow my code, im not sure
	--why exactly this is nessacary for the pulldown to show up
	--correctly for this one and not the others. Regardless it
	--fixed the bug so i can't complain too much
	UIDropDownMenu_SetSelectedValue(VM_MediumDD, VM_mediumNames[opts.medium]);
--	local optionName =  UIDropDownMenu_GetText(VM_MediumDD);
--	VM_msg("OptionName: " .. optionName);
end

function VM_checkWaterToggle()
end

function VM_checkFoodToggle()
end

function VM_report()
	--http://www.wowwiki.com/API_SendChatMessage
	--string.upper(
	--SendChatMessage("Hello","WHISPER",nil, "saph")
	local sesstr = nil;
	local lifstr = nil;
	local lenstr = nil;
	local medium = VM_mediumNames[VM_REPORT_OPTIONS.medium];
	
	--Water
	lenstr = VM_REPORT_OPTIONS.MinW .. " - " .. VM_REPORT_OPTIONS.MaxW;
	sesstr = "Water This Sesion (Ranks " .. lenstr .. "): ";
	lifstr = "Water Over Lifetime (Ranks " .. lenstr .. "): ";
	
	sesstr = sesstr .. VM_totalWaterSession[VM_REPORT_OPTIONS.MinW];
	lifstr = lifstr .. VM_TOTAL_WATER_LIFETIME[VM_REPORT_OPTIONS.MinW];
	
	if(VM_REPORT_OPTIONS.MinW < VM_REPORT_OPTIONS.MaxW) then
		for rank=VM_REPORT_OPTIONS.MinW + 1, VM_REPORT_OPTIONS.MaxW do
			sesstr = sesstr .. ", " .. VM_totalWaterSession[rank];
			lifstr = lifstr .. ", " .. VM_TOTAL_WATER_LIFETIME[rank];
		end
	end
	
	SendChatMessage(sesstr,string.upper(medium));
	SendChatMessage(lifstr,string.upper(medium));

	--Food
	lenstr = VM_REPORT_OPTIONS.MinF .. " - " .. VM_REPORT_OPTIONS.MaxF;
	sesstr = "Food This Sesion (Ranks " .. lenstr .. "): ";
	lifstr = "Food Over Lifetime (Ranks " .. lenstr .. "): ";
	
	sesstr = sesstr .. VM_totaFoodSession[VM_REPORT_OPTIONS.MinF];
	lifstr = lifstr .. VM_TOTAL_FOOD_LIFETIME[VM_REPORT_OPTIONS.MinF];
	
	if(VM_REPORT_OPTIONS.MinF < VM_REPORT_OPTIONS.MaxF) then
		for rank=VM_REPORT_OPTIONS.MinF + 1, VM_REPORT_OPTIONS.MaxF do
			sesstr = sesstr ..", " .. VM_totaFoodSession[rank];
			lifstr = lifstr ..", " .. VM_TOTAL_FOOD_LIFETIME[rank];
		end
	end
	
	SendChatMessage(sesstr,string.upper(medium));
	SendChatMessage(lifstr,string.upper(medium));
end

function VM_command(msg)
	if(msg == nil or msg == "") then
		DEFAULT_CHAT_FRAME:AddMessage("Use: /vm command");
		DEFAULT_CHAT_FRAME:AddMessage("Commands are as follows:");
		DEFAULT_CHAT_FRAME:AddMessage("  show    Shows the stats on water/food creation.");
		DEFAULT_CHAT_FRAME:AddMessage("  say     Announce in say how much food and water you have.");
		DEFAULT_CHAT_FRAME:AddMessage("  emote   Announce in emote...");
		DEFAULT_CHAT_FRAME:AddMessage("  yell    Announce in yell...");
		DEFAULT_CHAT_FRAME:AddMessage("  party   Announce in party...");
		DEFAULT_CHAT_FRAME:AddMessage("  raid    Announce in raid...");
		DEFAULT_CHAT_FRAME:AddMessage("  rw  Announce in raid warning (/rw)...");
		DEFAULT_CHAT_FRAME:AddMessage("  autowelcome on/off  Turns on/off auto \"Your welcome.\" to thank you or ty in a tell.");
		return;
	end
	msg = string.lower(msg);
	
	if(string.find(msg,"show")) then
		VM_showStats();
	elseif(string.find(msg,"autowelcome")) then
		if(string.find(msg,"on")) then
			VM_GENERAL_OPTIONS.autowelcome = true;
			DEFAULT_CHAT_FRAME:AddMessage("Autowelcome is |cff00ff00On|r");
		elseif(string.find(msg,"off")) then
			VM_GENERAL_OPTIONS.autowelcome = false;
			DEFAULT_CHAT_FRAME:AddMessage("Autowelcome is |cffff0000Off|r");
		else
			if(VM_GENERAL_OPTIONS.autowelcome == true) then
				DEFAULT_CHAT_FRAME:AddMessage("Autowelcome is |cff00ff00On|r");
			else
				DEFAULT_CHAT_FRAME:AddMessage("Autowelcome is |cffff0000Off|r");
			end	
		end
	else
		if(msg == "rw") then
			msg = "raid_warning";
		end
		local str ="Open Trade for Food(";
		str = str ..  VM_currentFoodCount[VM_highestFood] .. ") & Water(";
		str = str .. VM_currentWaterCount[VM_highestWater] .. ")";
		SendChatMessage(str,string.upper(msg));
	end
end

--track water creation	
function VM_spellInt()
  	VM_msg("Interupted", 255,255,255);
	if(VM_lastCastWater == true and VM_itemsQued > 0 ) then
		VM_itemsQued = VM_itemsQued - 1;
	end
end


function VM_spellStart(spellname)
	if(spellname == "Conjure Water") then
		VM_lastCastWater = true;
		VM_msg("Water made",0,0,0);
		VM_itemsQued = VM_itemsQued + 1;
	elseif(spellname == "Conjure Food") then
		VM_lastCastWater = true;
		VM_msg("Food made",0,0,0);
		VM_itemsQued = VM_itemsQued + 1;
	else
		VM_lastCastWater = false;
	end
end

function VM_trackWater()
	
	--if sorting has been initialized deal with it
	--picking up one partial stack and placing it on another
	--partial stack luanches two BAG_UPDATE events skip the first
	VM_msg("Track sort=" .. VM_sortVariables,200,0,0)
	if(VM_sortVariables == 1) then
		VM_sortVariables = 2;
	VM_msg("First Track Water skipping sort")
		return
	elseif(VM_sortVariables == 2) then
	VM_msg("Scond Track Water calling sort")
		VM_sortWater()
--		VM_sortVariables = 0;
	end
	
	local totalFood = {0,0,0,0,0,0,0};
	local totalWater = {0,0,0,0,0,0,0};

	VM_msg("Track Water", 0,200,0);
	--search through every slot of every bag and count all the water
	for bag=0,4 do
    	for slot=1,GetContainerNumSlots(bag) do
      		if (GetContainerItemLink(bag,slot)) then
      			for spellRank=1,7 do
	        		if (string.find(GetContainerItemLink(bag,slot), VM_waterNames[spellRank])) then
          				local t, count, l, q, r = GetContainerItemInfo(bag, slot)
          				totalWater[spellRank] = count + totalWater[spellRank];
        			elseif (string.find(GetContainerItemLink(bag,slot), VM_foodNames[spellRank])) then
        	  			local t, count, l, q, r = GetContainerItemInfo(bag, slot)
    	      			totalFood[spellRank] = count + totalFood[spellRank];
	        		end
        		end
      		end
    	end
  	end	
	--make sure a cast has occured
	if( VM_itemsQued <= 0) then
		VM_currentWaterCount = totalWater;
		VM_currentFoodCount = totalFood;
		VM_itemsQued = 0;
		return;
	end

	--no water can be made until the caster creats it so
	--waiting for water_made to be set through the SPELLCAST_START
	--event insures that no water is counted from glitches at logon
	--set the water have now as a starting point and exit
--	VM_msg("tW="..totalWater[VM_highestWater], 255, 0, 0);
--	VM_msg("tF="..totalFood[VM_highestFood], 255, 0, 0);

  	--if we have CC more water than we started with then water was made
	for spellRank=1,7 do
		if(spellRank <= VM_highestWater and 
			totalWater[spellRank] == (VM_waterCCs[spellRank] + VM_currentWaterCount[spellRank]) ) then

			local dif = totalWater[spellRank] - VM_currentWaterCount[spellRank];
			VM_totalWaterSession[spellRank] = VM_totalWaterSession[spellRank] + dif;
			VM_TOTAL_WATER_LIFETIME[spellRank] = VM_TOTAL_WATER_LIFETIME[spellRank] + dif;
			VM_itemsQued = VM_itemsQued - 1;
		elseif(spellRank <= VM_highestFood and 
			totalFood[spellRank] == (VM_foodCCs[spellRank] + VM_currentFoodCount[spellRank]) ) then

			local dif = totalFood[spellRank] - VM_currentFoodCount[spellRank];
			VM_totaFoodSession[spellRank] = VM_totaFoodSession[spellRank] + dif;
			VM_TOTAL_FOOD_LIFETIME[spellRank] = VM_TOTAL_FOOD_LIFETIME[spellRank] + dif;
			VM_itemsQued = VM_itemsQued - 1;
		end
		VM_currentWaterCount[spellRank] = totalWater[spellRank];
		VM_currentFoodCount[spellRank] = totalFood[spellRank];
	end
	VM_msg("Item made calling sort")
	VM_sortWater();
end



function VM_msg(mess)
	VM_msg(mess, 200,0,0)
end

function VM_msg(mess, r, g, b)
	if(VM_debug) then
		DEFAULT_CHAT_FRAME:AddMessage(mess, r, g, b);
	end
end

function VM_setDebug(flag)
	VM_debug = flag;
end

function VM_init(playerLevel)
	--get highest ranks of spells
	local i = 1;
	VM_highestFood = "0";
	VM_highestWater = "0";
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
   			do break end
		end
		   
		if(spellName == "Conjure Water") then
			VM_highestWater = spellRank;
		elseif(spellName == "Conjure Food") then
			VM_highestFood = spellRank;
		end
--		VM_msg("Spell: " .. spellName.. " Rank: " .. spellRank)
		i = i + 1
	end
	VM_highestWater = tonumber(string.sub(VM_highestWater,-1,-1));
	VM_highestFood = tonumber(string.sub(VM_highestFood,-1,-1));
	
	--calculate Conjure Counts
	if(playerLevel == 0) then
		playerLevel = UnitLevel("player");
	end
	--setup arrays with default values for level 60
	VM_foodCCs = {20,20,20,20,20,18,10};
	VM_waterCCs = {20,20,20,20,20,20,10};

	if( playerLevel < 60 ) then
		--fill in the lesser ranks for non 60 players
		for rank=1,6 do
			VM_waterCCs[rank] = math.min(20, (playerLevel - (rank - 1) * 10) * 2 + 2);
			VM_foodCCs[rank] = math.min(20, (playerLevel - (rank - 1) * 10) * 2 - 2);
		end
		
		--watch for levelup for non 60 players
		this:RegisterEvent("PLAYER_LEVEL_UP");
	end
	
	--watch for learning the new speslls if they don't
	--know the highest rank in the game
	if(VM_highestWater < 7 or VM_highestFood < 7) then
		this:RegisterEvent("SPELLS_CHANGED");
	end
end


--Drop Down Menus
function VM_waterRangePopulate()
	VM_msg("Init start: " .. this:GetName());

	--function selection
	local pulldownName = this:GetName();
	local onClickFunction = nil;
	if(string.find(pulldownName,"MinWaterDD")) then
		onClickFunction = VM_MinWDD_onClick;
	elseif(string.find(pulldownName,"MaxWaterDD")) then
		onClickFunction = VM_MaxWDD_onClick;
	elseif(string.find(pulldownName,"MinFoodDD")) then
		onClickFunction = VM_MinFDD_onClick;
	elseif(string.find(pulldownName,"MaxFoodDD")) then
		onClickFunction = VM_MaxFDD_onClick;
	end
	local info = {};

	--why didn't i use a loop? *bashes head against the table*
	info.text = "Rank 1";
	info.func = onClickFunction;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Rank 2";
	info.func = onClickFunction;
	UIDropDownMenu_AddButton(info);


	info = {};
	info.text = "Rank 3";
	info.func = onClickFunction;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Rank 4";
	info.func = onClickFunction;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Rank 5";
	info.func = onClickFunction;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Rank 6";
	info.func = onClickFunction;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Rank 7";
	info.func = onClickFunction;
	UIDropDownMenu_AddButton(info);

	VM_msg("Init Complete: " .. tostring(this));
end

function VM_MinWDD_onClick()
	VM_REPORT_OPTIONS.MinW = this:GetID()
	UIDropDownMenu_SetSelectedID(VM_MinWaterDD, this:GetID());
end

function VM_MaxWDD_onClick()
	VM_REPORT_OPTIONS.MaxW = this:GetID()
	UIDropDownMenu_SetSelectedID(VM_MaxWaterDD, this:GetID());
end

function VM_MinFDD_onClick()
	VM_REPORT_OPTIONS.MinF = this:GetID()
	UIDropDownMenu_SetSelectedID(VM_MinFoodDD, this:GetID());
end

function VM_MaxFDD_onClick()
	VM_REPORT_OPTIONS.MaxF = this:GetID()
	UIDropDownMenu_SetSelectedID(VM_MaxFoodDD, this:GetID());
end

function VM_mediumPopulate()
	VM_msg("Init start: " .. this:GetName());
	VM_mediumNames = {
		"Say",
		"Emote",
		"Yell",
		"Raid",
		"Party",
		"Raid_Warning"}

	local info = nil;

	for index=1,6 do
		info = {};
		info.text = VM_mediumNames[index];
		info.func = VM_mediumDD_onClick;
		UIDropDownMenu_AddButton(info);
	end
--	UIDropDownMenu_SetSelectedID(this, VM_REPORT_OPTIONS.medium)
	
	VM_msg("Init Complete: " .. tostring(this));
end

function VM_mediumDD_onClick()
	VM_REPORT_OPTIONS.medium = this:GetID()
	UIDropDownMenu_SetSelectedID(VM_MediumDD, this:GetID());
end

function VM_clearTrade()
	for slot=1,6 do
		if(GetTradePlayerItemLink(slot)) then
			ClickTradeButton(slot);
			PutItemInBackpack();
		end
	end
end

function VM_sortWater()	
	local lastBag = 0;
    local lastSlot = 0;
    local lastCount = 0;
    local skippedLast = false;
    
	if(not VM_debug) then
		return
	end
	
	VM_sortInstance = VM_sortInstance + 1;
	local sortI = VM_sortInstance;
	VM_msg("Sort Called Inst=".. sortI);
	local iname ="";
	--cycle through every rank of food and water
	for rank=1,7 do --for spacial reasons these two are indenting
	for itemType=1,2 do --to the same line
		if(itemType == 1) then
			iname = VM_foodNames[rank];
		else
			iname = VM_waterNames[rank];
		end
		
		for bag=0,4 do
	   	for slot=0,GetContainerNumSlots(bag) do
     		if (GetContainerItemLink(bag,slot)) then
    	   		if (string.find(GetContainerItemLink(bag,slot), iname)) then
					local t, count, l, q, r = GetContainerItemInfo(bag, slot)
        			if(count == 20) then
        				--just skip;
        			elseif(skippedLast) then
        				--reset
						if(lastCount + count < 20) then
							VM_sortVariables = 2;
						else
							VM_sortVariables = 1;
						end
        				PickupContainerItem(bag,slot);
        				PickupContainerItem(lastBag,lastSlot);
						VM_msg("Sort returing Inst=".. sortI);
						return;
					else
       					lastBag = bag;
       					lastSlot = slot;
       					lastCount = count;
       					skippedLast = true;					
        			end
       			end
			end
  		end	
		end
	end
	end
	VM_msg("Sort complete Inst=".. sortI);
	VM_sortVariables = 0;	
end

function VM_tell()
	if(VM_GENERAL_OPTIONS.autowelcome == false) then return end
	VM_msg("A tell has been recieved");
	
	--translate arg vars to something i can follow o.O
	local msg =" " .. string.lower(arg1) .. " ";
	local author = arg2;
	local isAthank = false;
	local thankMessages = {
		"[^%l]thanks[^%l]", 
		"[^%l]thank you[^%l]", 
		"[^%l]thankyou[^%l]", 
		"[^%l]ty[^%l]",
		"[^%l]thx[^%l]"}
	
	for idx=1,5 do
		if(string.find(msg,thankMessages[idx])) then
			isAthank = true;
		end
	end
	if(isAthank) then
		VM_msg("Was a ty, replying with yw");
		SendChatMessage("Your welcome!","WHISPER",nil, author);
	end
end
