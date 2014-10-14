FLSorting = {
   simplifyTable = {
      {s="\195\188", n="u", o=1},
      {s="\195\187", n="u", o=2},
      {s="\195\186", n="u", o=3},
      {s="\195\185", n="u", o=4},
      {s="\195\182", n="o", o=1},
      {s="\195\180", n="o", o=2},
      {s="\195\179", n="o", o=3},
      {s="\195\178", n="o", o=4},
      {s="\195\164", n="a", o=1},
      {s="\195\162", n="a", o=2},
      {s="\195\161", n="a", o=3},
      {s="\195\160", n="a", o=4},
      {s="\195\170", n="e", o=1},
      {s="\195\169", n="e", o=2},
      {s="\195\168", n="e", o=3},
      {s="\195\174", n="i", o=1},
      {s="\195\173", n="i", o=2},
      {s="\195\172", n="i", o=3},
      {s="\195\159", n="ss", o=1},
   }
};


--[[

FLSorting.getRealEntry(buffTable, listIndex)

-- Get friendData index for entry <listIndex> in buffer table <buffTable>.

]]--
function FLSorting.getRealEntry(buffTable, listIndex)
   local newIndex = listIndex;

   --FlagRSP.printDebug("We are looking for entry #" .. listIndex);
   if buffTable[listIndex] ~= nil and buffTable[listIndex].index ~= nil then  
      --FlagRSP.printDebug("This is: " .. buffTable[listIndex].name);
      --FlagRSP.printDebug("and old index: " .. buffTable[listIndex].index);

      newIndex = buffTable[listIndex].index;
   end

   return newIndex;
end


--[[

FLSorting.simplifyString(s)

-- Simplifys string <s>. All non a-z characters (like צהüגפû...) are 
-- converted to corresponding a-z characters.

]]--
function FLSorting.simplifyString(s)
   for i=1, table.getn(FLSorting.simplifyTable) do
      --FlagRSP.printDebug("replacing " .. FLSorting.simplifyTable[i].s .. " by " .. FLSorting.simplifyTable[i].n);
      s = string.gsub(s, FLSorting.simplifyTable[i].s, FLSorting.simplifyTable[i].n);
   end

   --FlagRSP.printDebug("string is " .. s);

   return s;
end


--[[

FLSorting.alphCompare(s1,s2)

-- Compares to strings <s1> and <s2> and returns true if s1<s2.

]]--
function FLSorting.alphCompare(s1,s2)
   s1 = string.lower(s1);
   s2 = string.lower(s2);
  
   --s1 = FLSorting.simplifyString(s1);
   --s2 = FLSorting.simplifyString(s2);

   --FlagRSP.printDebug("char1: k, byte: " .. string.byte("k"));
   --FlagRSP.printDebug("char2: y, byte: " .. string.byte("y"));

   if string.byte(s1) == string.byte(s2) then
      if string.len(s1) == 1 and string.len(s2) == 1 then
	 return true;
      end
      if string.len(s1) > 1 then
	 s1 = string.sub(s1,2,string.len(s1));
      end
      if string.len(s2) > 1 then
	 s2 = string.sub(s2,2,string.len(s2));
      end
      
      return FLSorting.alphCompare(s1,s2)
   else
      -- check for special characters.
      local b1 = string.byte(FLSorting.simplifyString(s1));
      local b2 = string.byte(FLSorting.simplifyString(s2));

      local c1 = string.sub(s1,1,1);
      local c2 = string.sub(s2,1,1);
      
      for i=1, table.getn(FLSorting.simplifyTable) do
	 if b1 == b2 then
	    if string.find(s1, FLSorting.simplifyTable[i].s) == 1 then
	       b1 = b1 + FLSorting.simplifyTable[i].o;
	    end
	    if string.find(s2, FLSorting.simplifyTable[i].s) == 1 then
	       b2 = b2 + FLSorting.simplifyTable[i].o;
	    end
	 end
      end

      return b1<b2;
   end
end


--[[

FLSorting_eDateComp(a,b)

-- Compares to entrys <a> and <a> and returns true if a.index<b.index.

]]--
function FLSorting_eDateComp(a,b)
   --FlagRSP.printDebug("a: " .. a.index .. ", b: " .. b.index);
   return a.index<b.index;
end


--[[

FLSorting_alphCompName(a,b)

-- Compares to entrys <a> and <a> and returns true if a.name<b.name.

]]--
function FLSorting_alphCompName(a,b)
   bool = FLSorting.alphCompare(a.name, b.name);

   return bool;
end


--[[

FLSorting_alphComSurname(a,b)

-- Compares to entrys <a> and <a> and returns true if a.surname<b.surname.
-- Uses name if no surname set.

]]--
function FLSorting_alphCompSurname(a,b)
   local aname = TooltipHandler.getSurname(a.name);
   local bname = TooltipHandler.getSurname(b.name);

   if aname == bname then
      aname = a.name;
      bname = b.name;
   end
   if aname == "" then 
      aname = a.name;
   end
   if bname == "" then 
      bname = b.name;
   end

   bool = FLSorting.alphCompare(aname, bname);

   return bool;
end


--[[

FLSorting_fStateComp(a,b)

-- Compares to entrys <a> and <a> and returns true if 
-- a.friendstate>b.friendstate (we want friendstate descending).
-- Uses surname if friendstate equal.

]]--
function FLSorting_fStateComp(a,b)
   local bool;

   if a == nil or b == nil then
      FlagRSP.print("GOT A NIL PROBLEM!"); 
      return true;
   else
      --FlagRSP.printDebug("a: " .. a.name);
      --FlagRSP.printDebug("b: " .. b.name);
      
      if a.friendstate == b.friendstate then
	 bool = FLSorting_alphCompSurname(a,b);
      else
	 bool = a.friendstate > b.friendstate;
      end
   end

   return bool;
end


--[[

FLSorting_typeComp(a,b)

-- Compares to entrys <a> and <a> and returns true if 
-- a is name and b guild, false if a guild and b name.
-- Uses surname if type equal.

]]--
function FLSorting_typeComp(a,b)
   local bool;

   if a == nil or b == nil then
      FlagRSP.print("GOT A NIL PROBLEM!"); 
      return true;
   else
      
      if a.type == b.type then
	 bool = FLSorting_alphCompSurname(a,b);
      elseif a.type == "char" and b.type == "guild" then
	 --FlagRSP.print("a is a char: " .. a.name .. ", b is a guild: " .. b.name); 
	 bool = true;
      elseif b.type == "char" and a.type == "guild" then
	 --FlagRSP.print("a is a guild: " .. a.name .. ", b is a char: " .. b.name); 
	 bool = false;
      else
	 FlagRSP.print("GOT A NO CATCH PROBLEM!"); 
      end
   end

   return bool;
end


--[[

FLSorting.onlineComp(a,b,secComp)

-- Compares to entrys <a> and <a> and returns true if 
-- a is online and b not. Uses <secComp> if same online status.

]]--
function FLSorting.onlineComp(a,b,secComp)
   local bool;

   if a == nil or b == nil then
      FlagRSP.print("GOT A NIL PROBLEM!"); 
      return true;
   else
      --local aonline = Friendlist.getOnlineInfo(a.name);
      --local bonline = Friendlist.getOnlineInfo(b.name);
      local aonline = Friendlist.isOnline(a.name);
      local bonline = Friendlist.isOnline(b.name);
      local astatus = 3
      local bstatus = 3;

      --FlagRSP.printM(string.sub(aonline,2));
      --FlagRSP.printM(string.sub(bonline,2));
      --FlagRSP.printM(FRIENDLIST_LOCALE_OnlineLine);
      --FlagRSP.printM(FRIENDLIST_LOCALE_OfflineLine);

      --if string.find(aonline, FRIENDLIST_LOCALE_OnlineLine, 1, true) ~= nil then
      if aonline == 1 then
	 astatus = 0;
      --elseif string.find(aonline, FRIENDLIST_LOCALE_OfflineLine, 1, true) ~= nil or aonline == "" then
      else
	 astatus = 1;
      end
      --if string.find(bonline, FRIENDLIST_LOCALE_OnlineLine, 1, true) ~= nil then
      if bonline == 1 then
	 bstatus = 0;
      --elseif string.find(bonline, FRIENDLIST_LOCALE_OfflineLine, 1, true) ~= nil or bonline == "" then
      else
	 bstatus = 1;
      end

      if astatus == 3 or bstatus == 3 then
	 FlagRSP.printA(1);
      end

      --FlagRSP.printDebug("compare for: " .. a.name .. " and " .. b.name .. ", " .. aonline .. ", " .. bonline .. "=> " .. astatus .. ", " .. bstatus);

      --if (string.find(aonline, FRIENDLIST_LOCALE_OfflineLine) ~= nil and string.find(bonline, FRIENDLIST_LOCALE_OfflineLine) ~= nil) or (string.find(aonline, FRIENDLIST_LOCALE_OnlineLine) ~= nil and string.find(bonline, FRIENDLIST_LOCALE_OnlineLine) ~= nil) or (string.find(aonline, FRIENDLIST_LOCALE_OfflineLine) ~= nil and bonline == "") or (string.find(bonline, FRIENDLIST_LOCALE_OfflineLine) ~= nil and aonline == "") then
	 --FlagRSP.printDebug("name compare for: " .. a.name .. " and " .. b.name);
	 
	 --bool = secComp(a,b);
      --elseif string.find(aonline, FRIENDLIST_LOCALE_OnlineLine) ~= nil then
	 --FlagRSP.printDebug("a online, b offline: " .. a.name .. " and " .. b.name);

	 --bool = true;
      --else
	 --FlagRSP.printDebug("b online, a offline: " .. a.name .. " and " .. b.name);

	 --bool = false;
      --end

      if astatus ~= bstatus then
	 return astatus<bstatus;
      else
	 return secComp(a,b);
      end
   end
   
   return bool;
end


--[[

FLSorting_onlineCompSurname(a,b)

-- Compares to entrys <a> and <a> and returns true if 
-- a is online and b not. Uses surname if same online status.

]]--
function FLSorting_onlineCompSurname(a,b)
   return FLSorting.onlineComp(a,b,FLSorting_alphCompSurname);
end


--[[

FLSorting_onlineCompName(a,b)

-- Compares to entrys <a> and <a> and returns true if 
-- a is online and b not. Uses name if same online status.

]]--
function FLSorting_onlineCompName(a,b)
   return FLSorting.onlineComp(a,b,FLSorting_alphCompName);
end


--[[

FLSorting_onlineCompFState(a,b)

-- Compares to entrys <a> and <a> and returns true if 
-- a is online and b not. Uses friendstate if same online status.

]]--
function FLSorting_onlineCompFState(a,b)
   return FLSorting.onlineComp(a,b,FLSorting_fStateComp);
end


--[[

FLSorting_onlineCompType(a,b)

-- Compares to entrys <a> and <a> and returns true if 
-- a is online and b not. Uses type if same online status.

]]--
function FLSorting_onlineCompType(a,b)
   return FLSorting.onlineComp(a,b,FLSorting_typeComp);
end


--[[

FLSorting_onlineCompEDate(a,b)

-- Compares to entrys <a> and <a> and returns true if 
-- a is online and b not. Uses entry date if same online status.

]]--
function FLSorting_onlineCompEDate(a,b)
   return FLSorting.onlineComp(a,b,FLSorting_eDateComp);
end



--[[

FLSorting.convertTable(tab)

-- Converts a Friendlist table (with names as keys) into an sortable array
-- table (with numbers as keys).

]]--
function FLSorting.convertTable(tab)
   local newTable = {};

   for key,value in tab do
      --FlagRSP.printDebug("convert: " .. key);
      value.name = key;

      table.insert(newTable, value);
   end

   return newTable;
end


--[[

FLSorting.sortTable(oldTable)

-- Sorts Friendlist table <oldTable> and returns sorted array table.

]]--
function FLSorting.sortTable(oldTable)
   --table0 = { albert={n=1}, franz={n=3}, peter={n=4}, hans={n=-6}};
   convTable = FLSorting.convertTable(oldTable);
   --table.setn(table1, 4);
   --table1 = { 1, 3, 4, -6};
      
   --FlagRSP.printDebug("Unsorted table, n is: " .. table.getn(convTable));
   --for key, value in convTable do
   --   FlagRSP.printDebug("key: " .. key .. ", value: " .. value);
   --end
   --for i=1, table.getn(convTable)  do
   --   FlagRSP.printDebug("i: " .. i .. ", value: " .. convTable[i].name);
   --end

   --table.sort(convTable, FLSorting.onlineCompFState);
   local compare = getglobal(Friendlist.dropDowns["Friendlist_SortDropDown"].selectedValue);
   
   --FlagRSP.printDebug("Sort called");

   if compare ~= nil then
      FLSorting.qsort(convTable, 1, table.getn(convTable), compare);
   else
      FlagRSP.printA(2);
   end

   --FlagRSP.printDebug("Sorted table");
   --for key, val in convTable do
   --   FlagRSP.printDebug("key: " .. key .. ", value: " .. val);
   --end
   --for i=1, table.getn(convTable) do
   --   FlagRSP.printDebug("i: " .. i .. ", value: " .. convTable[i].name);
   --end

   return convTable;
end


--[[

FLSorting.qsort(x,l,u,f)

-- Using own sorting method since table.sort is not sorting properly.

]]--
function FLSorting.qsort(x,l,u,f)
 if l<u then
  local m=math.random(u-(l-1))+l-1	-- choose a random pivot in range l..u
  x[l],x[m]=x[m],x[l]			-- swap pivot to first position
  local t=x[l]				-- pivot value
  m=l
  local i=l+1
  while i<=u do
    -- invariant: x[l+1..m] < t <= x[m+1..i-1]
    if f(x[i],t) then
      m=m+1
      x[m],x[i]=x[i],x[m]		-- swap x[i] and x[m]
    end
    i=i+1
  end
  x[l],x[m]=x[m],x[l]			-- swap pivot to a valid place
  -- x[l+1..m-1] < x[m] <= x[m+1..u]
  FLSorting.qsort(x,l,m-1,f)
  FLSorting.qsort(x,m+1,u,f)
 end
end