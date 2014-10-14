function UseByName_OnLoad()
	if not Print then Print = function (x)
    ChatFrame1:AddMessage(x, 1.0, 1.0, 1.0);
  	end
  end

  if not SlashCmdList["USEBYNAME"] then
  	SlashCmdList["USEBYNAME"] = UseByName_Execute;
    SLASH_USEBYNAME1 = "/usebyname";
  end
end

function UseByName_Execute(msg)
  return UseByName_ExecuteEx(msg,true);
end

function UseByName_ExecuteEx(needle,verbose)
	if not needle or (needle == "") then 
	  if verbose then
	    return Print("Usage: /UseByName <itemname>"); 
	  else
	    return nil; 
	  end
	end

  local item = string.lower(needle);
  
  for i=0, NUM_BAG_FRAMES do
    for j=1, GetContainerNumSlots(i) do
    	if string.find(string.lower(UseByName_GetItemName(i,j)), item) then
    	  --Print("Using item "..i..","..j);
				UseContainerItem(i,j);
				return true;
			end
    end
  end

  -- Also check inventory
	for i=0,19 do
  	if string.find(string.lower(UseByName_GetItemName(-1,i)), item) then
			UseInventoryItem(i);
  		return true;
		end
	end
	
  Print("Item "..needle.." not found");
  return nil;
end

function UseByName_GetItemName(bag, slot)
  local linktext = nil;
  
  if (bag == -1) then
  	linktext = GetInventoryItemLink("player", slot);
  else
  	linktext = GetContainerItemLink(bag, slot);
  end

  if linktext then
    local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
    return name;
  else
    return "";
  end
end
