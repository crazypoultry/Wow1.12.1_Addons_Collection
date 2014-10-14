--[[ File: Friend List Lua file
     borrowed lots of code from Asher (Warsong) and his original KOS List .)    			 
     ////////////////////////////////////////////////////////////////////
     18-Mar-05  code hijacked and messed up for FriendList - alpha release
     xoxo Zmrzlina

]]


--[[

Friendlist globals.

]]--
FRIENDLIST_VERSION_NUM = "0.5.6";
FRIENDLIST_TITLE = "Friendlist";
FRIENDLIST_NAMES_TO_DISPLAY = 8;
FRIENDLIST_FRAME_HEIGHT = 34;


--[[

Friendlist library functions.

]]--
Friendlist = {
   tabs = {
      --{Tooltip text, icon, object, reset}
      {"", "Interface\\Icons\\INV_Misc_Book_08", "FRIENDLISTFrame"},
      --{"", "Interface\\Icons\\INV_Feather_11", "FriendlistAdminFrame"},
      {"", "Interface\\Icons\\INV_Misc_Note_02", "FriendlistCharFrame", true}
      --{"", "Interface\\Icons\\INV_Misc_Wrench_01", "FriendlistConfigFrame"}
   };

   editBoxes = {
      FriendlistCharFramePg1ScrollFrameChildFrameEditBox = {
	 "FriendlistCharFramePg1TitleBox",
	 "FriendlistCharFramePg1SurnameBox"
      },
      FriendlistCharFramePg1TitleBox = {
	 "FriendlistCharFramePg1SurnameBox",
	 "FriendlistCharFramePg1ScrollFrameChildFrameEditBox"
      },
      FriendlistCharFramePg1SurnameBox = {
	 "FriendlistCharFramePg1ScrollFrameChildFrameEditBox",
	 "FriendlistCharFramePg1TitleBox"
      },
      FRIENDLISTStaticPopUpAddEditBox1 = {
	 "FRIENDLISTStaticPopUpAddScrollFrameChildFrameEditBox",
	 "FRIENDLISTStaticPopUpAddEditBox2"
      },
      FRIENDLISTStaticPopUpAddEditBox2 = {
	 "FRIENDLISTStaticPopUpAddEditBox1",
	 "FRIENDLISTStaticPopUpAddEditBox3"
      },
      FRIENDLISTStaticPopUpAddEditBox3 = {
	 "FRIENDLISTStaticPopUpAddEditBox2",
	 "FRIENDLISTStaticPopUpAddScrollFrameChildFrameEditBox"
      },
      FRIENDLISTStaticPopUpAddScrollFrameChildFrameEditBox = {
	 "FRIENDLISTStaticPopUpAddEditBox3",
	 "FRIENDLISTStaticPopUpAddEditBox1"
      },
      FRIENDLISTStaticPopUpAddGuildEditBox1 = {
	 "FRIENDLISTStaticPopUpAddGuildScrollFrameChildFrameEditBox",
	 "FRIENDLISTStaticPopUpAddGuildScrollFrameChildFrameEditBox"
      },
      FRIENDLISTStaticPopUpAddGuildScrollFrameChildFrameEditBox = {
	 "FRIENDLISTStaticPopUpAddGuildEditBox1",
	 "FRIENDLISTStaticPopUpAddGuildEditBox1",
      },
      FRIENDLISTStaticPopUpEditEditBox1 = {
	 "FRIENDLISTStaticPopUpEditScrollFrameChildFrameEditBox",
	 "FRIENDLISTStaticPopUpEditEditBox2"
      },
      FRIENDLISTStaticPopUpEditEditBox2 = {
	 "FRIENDLISTStaticPopUpEditEditBox1",
	 "FRIENDLISTStaticPopUpEditEditBox3"
      },
      FRIENDLISTStaticPopUpEditEditBox3 = {
	 "FRIENDLISTStaticPopUpEditEditBox2",
	 "FRIENDLISTStaticPopUpEditScrollFrameChildFrameEditBox"
      },
      FRIENDLISTStaticPopUpEditScrollFrameChildFrameEditBox = {
	 "FRIENDLISTStaticPopUpEditEditBox3",
	 "FRIENDLISTStaticPopUpEditEditBox1"
      },
   };
   
   pageButtons = {
      FriendlistCharFrameNextPageButton = {type="turn", activePage=1, pages={"FriendlistCharFramePg1", "FriendlistCharFramePg2"}},
   };
   
   scrollFrames ={
      FRIENDLISTStaticPopUpAddScrollFrameChildFrameEditBox = {
	 height = 150;
      },
      FRIENDLISTStaticPopUpAddGuildScrollFrameChildFrameEditBox = {
	 height = 150;
      },
      FRIENDLISTStaticPopUpEditScrollFrameChildFrameEditBox = {
	 height = 150;
      }
   };

   dropDowns = {
      FRIENDLISTStaticPopUpAddDropDown = {
	 initialize = "Friendlist_DropDownInitializer",
	 width = 250,
	 buttons = {
	    {
	       text = FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[0],
	       value = 0,
	       checked = true
	    },
	    {
	       text = FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[10],
	       value = 10,
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[-10],
	       value = -10,
	       checked = false
	    },
	 },
	 selectedValue = 0,
	 selectedText = FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[0],
	 readFunction = "",
	 writeFunction = ""
      },
      FRIENDLISTStaticPopUpAddGuildDropDown = {
	 initialize = "Friendlist_DropDownInitializer",
	 width = 250,
	 buttons = {
	    {
	       text = FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[0],
	       value = 0,
	       checked = true
	    },
	    {
	       text = FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[10],
	       value = 10,
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[-10],
	       value = -10,
	       checked = false
	    },
	 },
	 selectedValue = 0,
	 selectedText = FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[0],
	 readFunction = "",
	 writeFunction = ""
      },
      FRIENDLISTStaticPopUpEditDropDown = {
      initialize = "Friendlist_DropDownInitializer",
	 width = 250,
	 buttons = {
	    {
	       text = "",
	       value = 0,
	       checked = true
	    }
	 },
	 selectedValue = 0,
	 selectedText = "",
	 readFunction = "",
	 writeFunction = ""
      },
      FriendlistCharFramePg2RPDropDown = {
	 initialize = "Friendlist_DropDownInitializer",
	 width = 250,
	 buttons = {
	    {
	       text = FRIENDLIST_LOCALE_DropDownRP0,
	       value = 0,
	       checked = true
	    },
	    {
	       text = FRIENDLIST_LOCALE_DropDownRP1,
	       value = 1,
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_DropDownRP4,
	       value = 4,
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_DropDownRP2,
	       value = 2,
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_DropDownRP3,
	       value = 3,
	       checked = false
	    }
	    
	 },
	 selectedValue = 0,
	 selectedText = "StartText",
	 readFunction = "DropDown_getRPFlag",
	 writeFunction = "DropDown_setRPFlag"
      },
      FriendlistCharFramePg2CSDropDown = {
	 initialize = "Friendlist_DropDownInitializer",
	 width = 250,
	 buttons = {
	    {
	       text = FRIENDLIST_LOCALE_DropDownCSNone,
	       value = "none",
	       checked = true
	    },
	    {
	       text = FRIENDLIST_LOCALE_DropDownCSOOC,
	       value = "ooc",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_DropDownCSIC,
	       value = "ic",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_DropDownCSFFAIC,
	       value = "ffa-ic",
	       checked = false
	    },
	    {
   	       text = FRIENDLIST_LOCALE_DropDownCSST,
	       value = "st",
	       checked = false
	    }
	 },
	 selectedValue = "ic",
	 selectedText = "StartText",
	 readFunction = "DropDown_getCStatus",
	 writeFunction = "DropDown_setCStatus"
      },
      Friendlist_SortDropDown = {
	 initialize = "Friendlist_DropDownInitializer",
	 width = 250,
	 buttons = {
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_AlphOnlineSurname,
	       value = "FLSorting_onlineCompSurname",
	       checked = true
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_AlphOnline,
	       value = "FLSorting_onlineCompName",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_TypeOnline,
	       value = "FLSorting_onlineCompType",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_FStateOnline,
	       value = "FLSorting_onlineCompFState",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_EDateOnline,
	       value = "FLSorting_onlineCompEDate",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_AlphSurname,
	       value = "FLSorting_alphCompSurname", 
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_Alph,
	       value = "FLSorting_alphCompName",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_Type,
	       value = "FLSorting_typeComp",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_FState,
	       value = "FLSorting_fStateComp",
	       checked = false
	    },
	    {
	       text = FRIENDLIST_LOCALE_SortDropDown_EDate,
	       value = "FLSorting_eDateComp",
	       checked = false
	    }
	 },
	 selectedValue = "FLSorting_eDateComp",
	 selectedText = FRIENDLIST_LOCALE_SortDropDown_AlphOnlineSurname,
	 readFunction = "DropDown_getSortSettings",
	 writeFunction = "DropDown_setSortSettings",
	 instantSave = true
      }
   };

   addEditDialogs = {
      FRIENDLISTStaticPopUpAdd = {
	 titleText = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_TITLE,
	 acceptText = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ADD_BUTTON,
	 closeText = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ABORT_BUTTON,
	 
	 initialize = "Friendlist_initAddFriendDialog",
	 acceptClicked = "Friendlist_addFriendOnAccept",
	 
	 textsVisibility = {true, true, true, true, true}
      },
      FRIENDLISTStaticPopUpAddGuild = {
	 titleText = FRIENDLIST_LOCALE_ADD_GUILD_FRAME_TITLE,
	 acceptText = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ADD_BUTTON,
	 closeText = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ABORT_BUTTON,
	 
	 initialize = "Friendlist_initAddGuildDialog",
	 acceptClicked = "Friendlist_addGuildOnAccept",
	 
	 textsVisibility = {true, false, false, true, true}
      },
      FRIENDLISTStaticPopUpEdit = {
	 titleText = FRIENDLIST_LOCALE_EDITENTRY_FRAME_TITLE,
	 acceptText = FRIENDLIST_LOCALE_EDITENTRY_FRAME_OK_BUTTON,
	 closeText = FRIENDLIST_LOCALE_EDITENTRY_FRAME_ABORT_BUTTON,
	 
	 initialize = "Friendlist_initEditEntryDialog",
	 acceptClicked = "Friendlist_editEntryOnAccept",
	 
	 textsVisibility = nil,
	 guildTextsVisibility = {true, false, false, true, true},
	 charTextsVisibility = {true, true, true, true, true}
      },
   };

   rpTypeExplanations = {
      [0] = FRIENDLIST_LOCALE_DropDownRP0Expl,
      [1] = FRIENDLIST_LOCALE_DropDownRP1Expl,
      [2] = FRIENDLIST_LOCALE_DropDownRP2Expl,
      [3] = FRIENDLIST_LOCALE_DropDownRP3Expl,
      [4] = FRIENDLIST_LOCALE_DropDownRP4Expl
   };

   csExplanations = {
      ["none"] = FRIENDLIST_LOCALE_DropDownCSNoneExpl,
      ["ooc"] = FRIENDLIST_LOCALE_DropDownCSOOCExpl,
      ["ic"] = FRIENDLIST_LOCALE_DropDownCSICExpl,
      ["ffa-ic"] = FRIENDLIST_LOCALE_DropDownCSFFAICExpl;
      ["st"] = FRIENDLIST_LOCALE_DropDownCSSTExpl;
   };

   currentTab = 1;
   
   --descBuffer = "";
   --descBoxHeight = 0;
   --descTick = 0;
   descBoxWarningSeen = false;

   updateInterval = 3;
   updateInfoBoxInterval = 1;
   resortInterval = 1;
   updateEntryInterval = 10;
   updateTick = 0;
   updateTickInfoBox = 0;
   resortTick = 0;
   updateEntryTick = 10;

   doubleClickTick = 0;
   soundTick = 0;

   friendsFrameOpened = 0;
   friendsFrameOpenedTick = 0;   

   onlineBufferList = {};
};


--[[

Friendlist.updateEntry(name,type)

-- Update entry for <name>. <type> determines how to update.

]]--
function Friendlist.updateEntry(name,type)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end
   
   if type == "flagRSP" then
      Friendlist.setEntrySurname(name,TooltipHandler.getSurname(name));
      Friendlist.setEntryTitle(name,TooltipHandler.getTitle(name));
   elseif type == "unitID" then
      Friendlist.setEntryClass(UnitName(name),UnitClass(name));
      Friendlist.setEntryGuild(UnitName(name),GetGuildInfo(name));
      Friendlist.setEntryLevel(UnitName(name),UnitLevel(name));
      Friendlist.setEntryRace(UnitName(name),UnitRace(name));
      Friendlist.setEntryRank(UnitName(name),GetPVPRankInfo(UnitPVPRank(name), name));
   elseif type == "flist" then
      for i=1, GetNumFriends() do
	 name, level, class, area, connected = GetFriendInfo(i);

	 if level ~= 0 then
	    --FlagRSP.printDebug(level);
	    --FlagRSP.printDebug(class);
	    
	    if friendData[realmName][playerName].FRIEND[name] ~= nil then
	       friendData[realmName][playerName].FRIEND[name].level = level;
	       friendData[realmName][playerName].FRIEND[name].class = class;
	    end
	 end
      end
   end
end


--[[

Friendlist.setEntrySurname(name, surname)

-- Update surname for entry <name>.

]]--
function Friendlist.setEntrySurname(name, surname)
   if friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name] ~= nil then
      friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].surname = surname;
      --friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].nachname = ;
   end
end


--[[

Friendlist.setEntryGuild(name, guild)

-- Update guild for entry <name>.

]]--
function Friendlist.setEntryGuild(name, guild)
   if friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name] ~= nil then
      friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].guild = guild;
      --friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].nachname = ;
   end
end


--[[

Friendlist.setEntryLevel(name, level)

-- Update guild for entry <name>.

]]--
function Friendlist.setEntryLevel(name, level)
   if friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name] ~= nil then
      friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].level = level;
      --friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].nachname = ;
   end
end


--[[

Friendlist.setEntryClass(name, class)

-- Update guild for entry <name>.

]]--
function Friendlist.setEntryClass(name, class)
   if friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name] ~= nil then
      friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].class = class;
      --friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].nachname = ;
   end
end


--[[

Friendlist.setEntryRace(name, race)

-- Update race for entry <name>.

]]--
function Friendlist.setEntryRace(name, race)
   if friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name] ~= nil then
      friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].race = race;
      --friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].nachname = ;
   end
end


--[[

Friendlist.setEntryRank(name, rank)

-- Update race for entry <name>.

]]--
function Friendlist.setEntryRank(name, rank)
   --FlagRSP.printDebug("Rank: " .. rank);
   if friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name] ~= nil then
      friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].rank = rank;
      --friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].nachname = ;
   end
end


--[[

Friendlist.setEntryTitle(name, title)

-- Update surname for entry <name>.

]]--
function Friendlist.setEntryTitle(name, title)
   if friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name] ~= nil then
      friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].title = title;
      --friendData[FlagRSP.rName][FlagRSP.pName].FRIEND[name].nachname = ;
   end
end


--[[

Friendlist.getSurname(name)

- Get player names surname.

]]--
function Friendlist.getSurname(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].surname ~= nil then
      return friendData[realmName][playerName].FRIEND[name].surname;
   else 
      return "";
   end
end


--[[

Friendlist.getTitle(name)

-- Get player name's title.

]]--
function Friendlist.getTitle(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].title ~= nil then
      return friendData[realmName][playerName].FRIEND[name].title;
   else 
      return "";
   end
end


--[[

Friendlist.getRace(name)

-- Get player name's race.

]]--
function Friendlist.getRace(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].race ~= nil then
      return friendData[realmName][playerName].FRIEND[name].race;
   else 
      return "";
   end
end


--[[

Friendlist.getLevel(name)

-- Get player name's level.

]]--
function Friendlist.getLevel(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].level ~= nil then

      -- Although guilds will not be supported in normal view for future releases we have to capture their level for now.
      if friendData[realmName][playerName].FRIEND[name].notes ~= nil and friendData[realmName][playerName].FRIEND[name].notes ~= "Gilde" and friendData[realmName][playerName].FRIEND[name].type == "char" then
	 return friendData[realmName][playerName].FRIEND[name].level;
      else
	 return "";
      end
   else 
      return "";
   end
end


--[[

Friendlist.getClass(name)

-- Get player name's class.

]]--
function Friendlist.getClass(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].class ~= nil then
      return friendData[realmName][playerName].FRIEND[name].class;
   else 
      return "";
   end
end


--[[

Friendlist.getGuild(name)

-- Get player name's guild.

]]--
function Friendlist.getGuild(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].guild ~= nil then
      return friendData[realmName][playerName].FRIEND[name].guild;
   else 
      return "";
   end
end


--[[

Friendlist.getRank(name)

-- Get player name's guild.

]]--
function Friendlist.getRank(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].rank ~= nil then
      --FlagRSP.printDebug(friendData[realmName][playerName].FRIEND[name].rank);
      return friendData[realmName][playerName].FRIEND[name].rank;
   else 
      return "";
   end
end


--[[

Friendlist.getNotes(name)

- Get player names notes.

]]--
function Friendlist.getNotes(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end
   
   notes = "";

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].notes ~= nil then
      --FlagRSP.print(name);
      --if friendData[realmName][playerName].FRIEND[name].notes ~= nil then
	 notes = friendData[realmName][playerName].FRIEND[name].notes;
      --end
   end

   --if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil then
   --   return friendData[realmName][playerName].FRIEND[name].surname;
   --end

   return notes;
end


--[[

Friendlist.getType(name)

- Get type for entry <name>.

]]--
function Friendlist.getType(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end
   
   local uType = "";

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil and friendData[realmName][playerName].FRIEND[name].type ~= nil then
      --FlagRSP.print(name);
      --if friendData[realmName][playerName].FRIEND[name].notes ~= nil then
	 uType = friendData[realmName][playerName].FRIEND[name].type;
      --end
   end

   --if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil then
   --   return friendData[realmName][playerName].FRIEND[name].surname;
   --end

   return uType;
end


--[[

Friendlist.getFriendstate(name)

- Get player names friend status (currently only -10 for foe and 10 for friend).

]]--
function Friendlist.getFriendstate(name)
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   --FlagRSP.printDebug("name: " .. name);
   --FlagRSP.printDebug("name: " .. name);

   if name ~= nil and name ~= "" and friendData[realmName][playerName].FRIEND[name] ~= nil then
      return friendData[realmName][playerName].FRIEND[name].friendstate;
   end
end


--[[

Friendlist.getIndex(name)

- Returns index for entry <name>.

]]--
function Friendlist.getIndex(name)
   local index = nil;

   if friendData[realmName][playerName].FRIEND[name] ~= nil then
      index = friendData[realmName][playerName].FRIEND[name].index;
   end

   return index;
end


--[[

Friendlist.getFriendstateInfo(friendstate)

- Get info (r,g,b,text) for friend status friendstate.

]]--
function Friendlist.getFriendstateInfo(friendstate)
   local r,g,b,text;

   text = FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[friendstate];
   r=1; g=1; b=1;

   if friendstate == -10 then
      r=1; g=0; b=0;
   elseif friendstate == 10 then
      r=0; g=1; b=0;
   elseif friendstate == 0 then
      r=1; g=1; b=1;
   else
      r=1; g=1; b=1;
   end

   if text == nil then text = ""; end

   return r,g,b,text;
end


--[[

Friendlist.getFriendstateGuildInfo(friendstate)

- Get info (r,g,b,text) for guild friend status friendstate.

]]--
function Friendlist.getFriendstateGuildInfo(friendstate)
   local r,g,b,text;

   text = FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[friendstate];
   r=1; g=1; b=1;

   if friendstate == -10 then
      r=1; g=0.33; b=0.33;
   elseif friendstate == 10 then
      r=0.33; g=1; b=0.33;
   end

   return r,g,b,text;
end


--[[

Friendlist.getFriendstateText(name)

- Get player names friend status text.

]]--
function Friendlist.getFriendstateText(name)
   local friendstate = Friendlist.getFriendstate(name);
   local text = "";

   if friendstate ~= nil then
      --FlagRSP.printDebug("Name is: " .. name);
      --FlagRSP.printDebug("FS is: " .. friendstate);

      if Friendlist.getType(name) ~= "guild" then
	 local r,g,b,t = Friendlist.getFriendstateInfo(friendstate);
	 if t ~= nil and t ~= "" then
	    --text = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2) .. t .. "|r";
	    text = t;
	 end
      else
	 local r,g,b,t = Friendlist.getFriendstateGuildInfo(friendstate);
	 if t ~= nil and t ~= "" then
	    --text = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2) .. t .. "|r";
	    text = t;
	 end
      end
   end

   return text;
end


--[[

Friendlist.getFriendstateColour(name)

- Get player names friend status text colour code.

]]--
function Friendlist.getFriendstateColour(name)
   local friendstate = Friendlist.getFriendstate(name);
   local text = "";

   if friendstate ~= nil then
      if Friendlist.getType(name) ~= "guild" then
	 local r,g,b,t = Friendlist.getFriendstateInfo(friendstate);
	 --if t ~= nil and t ~= "" then
	 text = FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2);
	 --text = t;
	 --end
      else
	 local r,g,b,t = Friendlist.getFriendstateGuildInfo(friendstate);
	 --if t ~= nil and t ~= "" then
	 text = FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2);
	 --text = t;
	 --end
      end
   end

   return text;
end


--[[

Friendlist.checkOnline(name)

-- checks if player is online and puts information into an online buffer.

]]--
function Friendlist.checkOnline(name)
   local isOnline = 0;

   --FlagRSP.printDebug("checking online state for: " .. name);

   for i=1, GetNumFriends() do
      n, level, class, area, connected = GetFriendInfo(i);

      if n == name then
	 if connected then
	    isOnline = 1;
	 else 
	    isOnline = -1;
	 end
      end

      --if name == FlagRSP.pName then
	 --onlineInfo = "|cff00c400" .. FRIENDLIST_LOCALE_OnlineLine .. "|r";
      --end
   end

   if isOnline == 0 and flagRSP_IntervalListHigh[name] ~= nil and flagRSP_LastSeenListHigh[name] ~= nil then
      --FlagRSP.printDebug("check if " .. name .. " is online. Now it is: " .. math.ceil(GetTime()) .. " and user will post again at " .. math.ceil(flagRSP_IntervalListHigh[name]+flagRSP_LastSeenListHigh[name]));

      if GetTime() > flagRSP_IntervalListHigh[name]*2+flagRSP_LastSeenListHigh[name] then
	 --isOnline = false; 
      else
	 isOnline = 1; 
      end
   elseif isOnline == 0 and flagRSP_IntervalList[name] ~= nil and flagRSP_LastSeenList[name] ~= nil then
      if GetTime() > flagRSP_IntervalList[name]*2+flagRSP_LastSeenList[name] then
	 --isOnline = false; 
      else
	 isOnline = 1; 
      end
   end

   if Friendlist.onlineBufferList[name] == nil then
      Friendlist.onlineBufferList[name] = {};
   end

   Friendlist.onlineBufferList[name].isOnline = isOnline;
   Friendlist.onlineBufferList[name].timeStamp = GetTime();

   return isOnline;
end


--[[

Friendlist.isOnline(name)

-- returns true if player <name> is online.

]]--
function Friendlist.isOnline(name)
   local isOnline = 0;

   if Friendlist.onlineBufferList[name] ~= nil and (GetTime()-Friendlist.onlineBufferList[name].timeStamp) <= 10  then
      isOnline = Friendlist.onlineBufferList[name].isOnline;
   else 
      isOnline = Friendlist.checkOnline(name);
   end

   return isOnline;
end


--[[

Friendlist.getOnlineInfo(name)

-- Get information if player name is online.

]]--
function Friendlist.getOnlineInfo(name)
   local onlineInfo = "";
   local isOnline = Friendlist.isOnline(name);

   if isOnline == 1 then
      onlineInfo = "|cff00c400" .. FRIENDLIST_LOCALE_OnlineLine .. "|r";
   elseif isOnline == -1 then
      onlineInfo = "|cff808080" .. FRIENDLIST_LOCALE_OfflineLine .. "|r";
   end

   return onlineInfo;
end


--[[

Friendlist.getOnlineLocation(name)

-- Get information where player name currently is.

]]--
function Friendlist.getOnlineLocation(name)
   local onlineLoc = "";

   for i=1, GetNumFriends() do
      n, level, class, area, connected = GetFriendInfo(i);

      if n == name then
	 if connected then
	    onlineLoc = area;
	 end
      end
   end

   if name == FlagRSP.pName then
      onlineLoc = GetRealZoneText();
   end

   return onlineLoc;
end


--[[

Friendlist.getOnlineStatus(name)

-- Get status line for player's online status.

]]--
function Friendlist.getOnlineStatus(name, playerID)
   local status = "";

   if Friendlist.getType(name) == "char" then
      local onlineInfo = Friendlist.getOnlineInfo(name);

      if onlineInfo ~= "" then
	 local onlineLoc = Friendlist.getOnlineLocation(name);
	 
	 if onlineLoc ~= "" then
	    status = "[" .. onlineInfo .. ", " .. onlineLoc .. "]";
	    --TooltipHandler.compileString(FRIENDLIST_LOCALE_OnlineStatusLoc, playerID);
	 else
	    status = "[" .. onlineInfo .. "]";
	    --TooltipHandler.compileString(FRIENDLIST_LOCALE_OnlineStatusNoLoc, playerID);
	 end
      end
   end

   return status;
end


--[[

Friendlist.isFriend(name)

- Check if player/object/guild is on Friendlist.

]]--
function Friendlist.isFriend(name)
   --We can't check our FRIEND list if the variables aren't loaded or
   --our data structure isn't created yet
   if((name == nil) or (name == "")) then
      return false;
   end

   if (not initialized) then
      FRIENDLIST_Initialize();
      return false;
   end

   SetupfriendData();

   --If we get here, we are initialized and have valid data...check for FRIEND status	
   if(friendData[realmName][playerName].FRIEND[name] == nil) then
      return false;
   else
      return friendData[realmName][playerName].FRIEND[name].value;
   end
end


--[[

Friendlist.setButtonPosition(pos)

- Set position of Minimap button.

]]--
function Friendlist.setButtonPosition(pos)
   -- Save position.
   Friendlist_Settings[realmName][playerName].buttonPosition = pos;

   -- Convert degree to radiant.
   pos_rad = pos*2*3.1415926536/360;
   -- Raduis of Minimap
   --r = 82.735;
   r = 81.500;
   --r = 93.735;
   
   -- Polar coordinates, yummy.
   x = math.floor(r * math.cos(pos_rad)+0.5)-12;
   y = math.floor(r * math.sin(pos_rad)+0.5)+12;

   FRIENDLISTMinimapButton:SetPoint("TOPLEFT", "Minimap", "CENTER", x, y);
end


--[[

Friendlist.loadSettings()

- Loads Friendlists settings.

]]--
function Friendlist.loadSettings()
   if (not initialized) then
      FRIENDLIST_Initialize();
      return "";
   end

   SetupfriendData();

   if not settingsLoaded then
      if (Friendlist_Settings == nil) then 
	 --First time use
	 Friendlist_Settings = {};
	 Friendlist_Settings[realmName] = {};
	 Friendlist_Settings[realmName][playerName] = {};
	 
	 Friendlist_Settings[realmName][playerName].buttonPosition = 288;
	 
      elseif (Friendlist_Settings[realmName] == nil) then
	 --First time use on this realm
	 Friendlist_Settings[realmName] = {};
	 Friendlist_Settings[realmName][playerName] = {};
	 
	 Friendlist_Settings[realmName][playerName].buttonPosition = 288;
      elseif (Friendlist_Settings[realmName][playerName] == nil) then
	 --First time use for this player
	 Friendlist_Settings[realmName][playerName] = {};
	 
	 Friendlist_Settings[realmName][playerName].buttonPosition = 288;
      end

      -- Convert old friend/foe values into new system.
      -- convert field "nachname" to "surname"
      for pName,value in friendData[realmName][playerName].FRIEND do
	 if friendData[realmName][playerName].FRIEND[pName].friendstate == nil or friendData[realmName][playerName].FRIEND[pName].friendstate == "" then
	    if friendData[realmName][playerName].FRIEND[pName].friendly then
	       friendData[realmName][playerName].FRIEND[pName].friendstate = 10;
	    elseif not friendData[realmName][playerName].FRIEND[pName].friendly then
	       friendData[realmName][playerName].FRIEND[pName].friendstate = -10;
	    end
	 end

	 if friendData[realmName][playerName].FRIEND[pName].surname == nil then
	    if friendData[realmName][playerName].FRIEND[pName].nachname ~= nil then
	       friendData[realmName][playerName].FRIEND[pName].surname = friendData[realmName][playerName].FRIEND[pName].nachname;
	    end
	 end

	 if friendData[realmName][playerName].FRIEND[pName].type == nil then
	    if friendData[realmName][playerName].FRIEND[pName].notes == "Gilde" then
	       friendData[realmName][playerName].FRIEND[pName].type = "guild";
	    else
	       friendData[realmName][playerName].FRIEND[pName].type = "char";
	    end
	 end
      end

      for i=1, table.getn(Friendlist.tabs) do
	 tab = Friendlist.tabs[i][3];
	 table.insert(UISpecialFrames, tab);
      end
	 
      
      Friendlist.setButtonPosition(Friendlist_Settings[realmName][playerName].buttonPosition);
      settingsLoaded = true;

      --DEFAULT_CHAT_FRAME:AddMessage("Friendlist " .. FRIENDLIST_VERSION_NUM  .. " initialized.", 1.0, 1.0, 0.0);
   end
end


--[[

Friendlist.updateMainFrame()

- Updates the settings (checkboxes) in the main frame of Friendlist.

]]--
function Friendlist.updateMainFrame()
end



------------------
-- Locals
------------------
playerName = nil;
playerRealm = nil;
initialized = false;
settingsLoaded = false;
originalName = "";
originalNotes = "";

--***************************--
-- Setup Event Handling 
--***************************--

-------------------------------
-- Handle the OnLoad Event 
-------------------------------
function FRIENDLIST_OnLoad()

   -- Define a few Print functions for cleaner code
   if (not Print_Chat) then 
      Print_Chat = function(x) DEFAULT_CHAT_FRAME:AddMessage(x, 1.0, 1.0, 0.0); end
   end
   if (not Print_UI) then
      Print_UI = function(x) UIErrorsFrame:AddMessage(x, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME); end
   end
   
   -- Setup handling <slash> commands
   SlashCmdList["FRIENDLISTCOMMAND"] = FRIENDLIST_SlashHandler;
   SLASH_FRIENDLISTCOMMAND1 = "/fl";
   SLASH_FRIENDLISTCOMMAND2 = "/friendlist";
   -- mmmh Zmrzlina likes it simple :)
   SlashCmdList["ADD"] = addfriend_Msg;
   SLASH_ADD1 = "/add";
   
   -- Register for required Events
   this:RegisterEvent("VARIABLES_LOADED");  -- Fires when saved FRIEND variables are loaded
   this:RegisterEvent("PLAYER_TARGET_CHANGED"); -- Fires when your target changes
   
   -- Version 2.0 additions
   this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
   
   --if 1 == 0 then
   -- MobileMinimapButtons support.
   --MOBILE_MINIMAP_BUTTONS_DESCRIPTIONS[FRIENDLISTMinimapButton] = "Friendlist";
   FRIENDLISTMinimapButton:Raise();

   -- Update GUI and GUI settings
   FRIENDLISTFrame.selectedMember = 0;
   
   FRIENDLISTMiniMap_OnLoad();
   --end
end

function Friendlist_OnUpdate()
   --
   Friendlist.loadSettings();

   if (not initialized) then 
      FRIENDLIST_Initialize();
   else
      --friendsFrameOpened = 0;
      --friendsFrameOpenedTick = 0;   

      if Friendlist.friendsFrameOpened == 0 or Friendlist.friendsFrameOpened == 1 then
	 FriendsFrame:Show();
	 --FriendlistMetaFrame:Show();
	 --Friendlist.friendsFrameOpenedTick = GetTime() + 2500;

	 if FriendsFrame:IsVisible() and Friendlist.friendsFrameOpened ~= 1 then 
    --FlagRSP.print(GetTime() + 2500);
	    Friendlist.friendsFrameOpenedTick = GetTime() + 0.5;
	    Friendlist.friendsFrameOpened = 1;
	 end
      end
	 	  
      if Friendlist.friendsFrameOpened == 1 then
	 if Friendlist.friendsFrameOpenedTick < GetTime() and Friendlist.friendsFrameOpened == 1 then
	    FriendsFrame:Hide();
	    --FriendlistMetaFrame:Hide();
	    Friendlist.friendsFrameOpened = 2;
	 end
      end
   end
end

---------------------------------------------------------------
-- This function is needed because it appears the player name
-- and possibly the realm name do not load at the same time
-- the VARIABLES_LOADED event fires.  We need to make sure
-- the player name exists before creating our data structure
---------------------------------------------------------------
function FRIENDLIST_Initialize()
   playerName=UnitName("player");
   realmName=GetCVar("realmName");
   initialized = true;
   
   --if not FlagRSPConfigure_IsInitialized() then
   --   return false;
   --end

   --if playerName ~= nil then
   --   DEFAULT_CHAT_FRAME:AddMessage("DEBUG: Friendlist: playerName: " .. playerName, 1.0, 1.0, 0.0);
   --end

   if (playerName == nil) or (realmName == nil) or (playerName == UNKNOWNOBJECT) or (playerName == UKNOWNBEING) then
      initialized = false;
   end
   
   return initialized;
end

-------------------------------
-- Handle registered Events
-------------------------------
function FRIENDLIST_OnEvent(event)
   -----------------------------------------
   -- Fires when Saved Variables are loaded
   -----------------------------------------
   if (event == "VARIABLES_LOADED") or (event == "UNIT_NAME_UPDATE" and arg1 == 'player') then
      if (not initialized) then 
	 FRIENDLIST_Initialize();
      end
      if not FlagRSPConfigure_IsInitialized() then
	 return "";
      end
      
      if (initialized) then
	 SetupfriendData();
	 FRIENDLIST_Update();
	 
	 Friendlist.loadSettings();
      end
   end
   
   ----------------------------------------------
   -- Fires when "player" selects a new "target"
   ----------------------------------------------
   if (event == "PLAYER_TARGET_CHANGED" ) then
      -- Make sure target frame is back to original color
      TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
      
      Friendlist.updateEntry("target","unitID");

      if UnitExists("target") and UnitPlayerControlled("target") then
	 
	 local targetName = UnitName("target");
	 
	 local guildName = GetGuildInfo("target");
	 
	 local r,g,b,t;
	 
	 if (Friendlist.isFriend(targetName)) then
	    r,g,b,t = Friendlist.getFriendstateInfo(Friendlist.getFriendstate(targetName));

	    TargetFrameTexture:SetVertexColor(r, g, b, TargetFrameTexture:GetAlpha());
	    
	    TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");

	 elseif (Friendlist.isFriend(guildName)) then
	    r,g,b,t = Friendlist.getFriendstateGuildInfo(Friendlist.getFriendstate(guildName));
	    
	    TargetFrameTexture:SetVertexColor(r, g, b, TargetFrameTexture:GetAlpha());

	    TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
	 else
	    -- Not FRIEND target, make sure Texture Overlay is back to original color
	    if UnitClassification("target") == "elite" then
	       TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");	       
	    else 
	       TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
	    end

	    TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
	 end
      end
      --FRIENDLIST_Update();
   end
   
   
   ------------------------------------------------------------------------------------------
   
   -- Tooltip updates  	
   if (event == "UPDATE_MOUSEOVER_UNIT") then
      
      Friendlist.updateEntry("mouseover","unitID");
      
      --		if UnitIsPlayer("mouseover") then
      --Grab the name of who we've moused-over
      local name = UnitName("mouseover");
      local guildName = GetGuildInfo("mouseover");
      
      --if 1==0 then
      --If they are on our list, update the tooltip and play a sound
      if (Friendlist.isFriend(name)) then
	 
	 --Make room for new text line
	 --GameTooltip:SetHeight(GameTooltip:GetHeight() + 10);
	 if (friendData[realmName][playerName].FRIEND[name].friendstate <= -10) then
	    if (friendData[realmName][playerName].playSounds == true) then
	       
	       if GetTime() > Friendlist.soundTick then 
		  --FlagRSP.printM("Hey!");
		  PlaySound("igMiniMapZoomIn");
		  Friendlist.soundTick = GetTime() + 0.5; 
	       end	       

	       --PlaySoundFile("Interface\\Addons\\Friendlist\\STAB_006_mastered_16_bit.wav");
	       --FlagRSP.printM("sound");
	       --PlaySoundFile("Interface\\Addons\\flagRSP\\uiMiniMapZoom.wav");
	    end
	 end
      elseif (Friendlist.isFriend(guildName)) then
	 if (friendData[realmName][playerName].FRIEND[guildName].friendstate <= -10) then
	    if (friendData[realmName][playerName].playSounds == true) then
	       --PlaySound("TellMessage");
	       --PlaySoundFile("Interface\\Addons\\Friendlist\\STAB_006_masteredd_16_bit.wav");
	       --PlaySound("igMiniMapZoomIn");
	       
	       if GetTime() > Friendlist.soundTick then 
		  --FlagRSP.printM("Hey!");
		  PlaySound("igMiniMapZoomIn");
		  Friendlist.soundTick = GetTime() + 0.5; 
	       end	       

	       --PlaySoundFile("Interface\\Addons\\flagRSP\\ping.mp3");
	    end
	 end
      end
   end
end


--*************************--
--   Utility Functions
--*************************--

-----------------------------
-- Handle <slash> commands
-----------------------------
function FRIENDLIST_SlashHandler(msg)
   --By the time the user is entering <slash> commands, the "player" and "realm"
   --have to be loaded.  
   if (not initialized) then
      FRIENDLIST_Initialize();
   end
   
   SetupfriendData();
   
   if ( (msg == "help") or (msg == "") or (msg == nil) ) then
      t = 0;
      while FRIENDLIST_LOCALE_HELP[t] ~= nil do
	 DEFAULT_CHAT_FRAME:AddMessage(FRIENDLIST_LOCALE_HELP[t],1.0, 1.0, 1.0);
	 t = t + 1;
      end      
   elseif (msg == "show") then
      --FRIENDLISTFrame:Show();
      FRIENDLIST_ToggleGUI();
      
   elseif (msg == "hide") then
      FRIENDLISTFrame:Hide();
      
   elseif (msg == "print") then
      PrintFRIENDLIST();
      
   elseif (msg == "reset") then
      ResetFRIENDLIST();
      
   elseif(msg=="import") then
      ImportFriendlist();
      
   elseif(msg=="export") then
      ExportFriendlist();
      
   else
      local idIndex = 1;
      local word = nil;
      local name = nil;
      local cmd = nil;
      local noteString = "";
      local nachnameString ="";
      
      --Iterate over space separated command string		
      --<cmd> <name> <notes>*
      for word in string.gfind(msg, "%S+") do
	 if (idIndex == 1) then
	    cmd = string.lower(word);
	 elseif (idIndex == 2) then
	    name = word;
	 elseif (idIndex == 3) then
	    nachnameString = word;
	 elseif (idIndex > 3) then
	    nachnameString = nachnameString .. " " .. word;
	 end
	 idIndex = idIndex + 1;
      end
      
      --User can enter just /FRIEND add <name> (with no notes)
      if ( (idIndex == 3) and (cmd == "add") ) then
	 nachnameString = nil;
      end
      
      --Fire off appropriate command
      if(cmd ~= nil) then
	 if(cmd == "add") then
	    if (name ~= nil) then
	       if (nachnameString ~= nil) then
		  AddFRIEND(name, "", nachnameString);
	       else
		  AddFRIEND(name, "", "");
	       end
	    end
	 elseif (cmd == "del") then
	    DelFRIEND(name);               
	 elseif (cmd == "mm") then
	    local switch = string.lower(name);
	    if (switch == "an") then
	       FRIENDLISTMinimapButton:Show();
	       friendData[realmName][playerName].showMM = true;
	    elseif (switch == "aus") then
	       FRIENDLISTMinimapButton:Hide();
	       friendData[realmName][playerName].showMM = false;
	    end
	 elseif (cmd == "addguild") then
	    --Guilds can have spaces in their names
	    if ( idIndex > 3) then
	       --Guild had spaces in their name, string it together
	       name = name .." "..noteString;
	    end
	    AddFRIEND(name, "Gilde", "");
	 elseif cmd == "buttonpos" then
	    if name ~= nil then
	       local pos=tonumber(name);
	       if pos >=0 and pos <= 360 then
		  Friendlist.setButtonPosition(pos);
	       end
	    end
	 end
      end
   end
end

-- Import all contacts from wow friendlist
function ImportFriendlist()
   Print_Chat("Import Friendlist...");
   for i=1, GetNumFriends(), 1 do
      name, level, class, area, connected = GetFriendInfo(i);
      if(name) then 
	 if(name == "Unbekannt") then
	 else 
	    if(friendData[realmName][playerName].FRIEND[name] == nil) then
	       AddFRIEND(name, "", "");
	       -- Don't set friendstate...
	    end -- if(not friendData...
	 end -- if(name!=...
      end -- if(name)...
   end -- for i...
   
   -- Update UI
   FRIENDLIST_Update();
end -- ImportFriendlist()

------------------------------------------------------------------------------------------

-- Export friends to wow contactlist
function ExportFriendlist() 
   Print_Chat("Export Friendlist...");
   if ( (friendData == nil) or
       (friendData[realmName] == nil) or
	  (friendData[realmName][playerName] == nil) or
	  (friendData[realmName][playerName].FRIEND == nil) or 
	  (friendData[realmName][playerName].numFRIEND == 0) ) then
      Print_Chat("FRIEND Data is empty - nothing to export");
   else
      -- iterate through frendlist
      for key,value in friendData[realmName][playerName].FRIEND do		
	 found = false;
	 -- only add, if he doesn't exist allready
	 for i=1, GetNumFriends(), 1 do 
	    name, level, class, area, connected = GetFriendInfo(i);
	    if(name == key) then 
	       found = true;
	    end -- if(name...
	 end -- for i=1
	 if(found == false) then
	    AddFriend(key);
	 end -- if(found...
      end -- for key, value...
   end -- if((frienddata==nil)...
   
   -- Update UI
   FriendsList_Update();
end -- ExportFriendlist()


------------------------------------------------------------------------------------------

function addfriend_Msg(msg)
   
   if (not initialized) then
      FRIENDLIST_Initialize();
   end
   
   SetupfriendData();
   
   if (msg == "") or (msg == nil) then
      Print_Chat("Friend List version: "..FRIENDLIST_VERSION_NUM);
      Print_Chat("type /list for more help");	
   else
      local idIndex = 1;
      local word = nil;
      local name = nil;
      local nachnameString = "";
      local noteString = "";
      for word in string.gfind(msg, "%S+") do
	 if (idIndex == 1) then
	    name = word;
	 elseif (idIndex == 2) then
	    nachnameString = word;
	 elseif (idIndex == 3) then
	    noteString = word;
	 elseif (idIndex > 3) then
	    noteString = noteString .. " " .. word;
	 end
	 idIndex = idIndex + 1;
      end
      
      if ( (idIndex == 2) ) then
	 nachnameString = nil;
	 noteString = nil;
      end
      if (name ~= nil) then
	 if (nachnameString ~= nil) and (noteString ~= nil) then
	    AddFRIEND(name, noteString, nachnameString);
	 elseif (nachnameString ~= nil) and (noteString == nil) then
	    AddFRIEND(name, "", nachnameString);
	 else
	    AddFRIEND(name, "", "");
	 end
      end
   end
end

------------------------------------------------------------------------------------------

function AddFRIEND(name, noteString, nachnameString, title, friendstate, type, oldName)
   
   if name == nil or name == "" then 
      return; 
   end
   if noteString == nil then
      noteString = "";
   end
   if nachnameString == nil then
      nachnameString = "";
   end
   if title == nil then 
      title = "";
   end
   if friendstate == nil then
      friendstate = 0;
   end
   if type == nil or type == "" then
      type = "char";
   end
   if oldName == nil then
      oldName = "";
   end

   if Friendlist.isFriend(name) and oldName ~= "" and oldName ~= name then
      FlagRSP.printE(string.gsub(FRIENDLIST_LOCALE_NameExistsMsg,"%%n",name));   
   end

   -- old version compatibility
   if noteString == "Gilde" then
      type = "guild";
   end
      
   if oldName == "" then
      -- TODO: substitute direct friendData accesses through functions.
      if friendData[realmName][playerName].FRIEND[name] == nil then
	 friendData[realmName][playerName].FRIEND[name] = {};
	 friendData[realmName][playerName].FRIEND[name].value = true;
	 -- don't know what this was designed for, we keep it for safety.
	 friendData[realmName][playerName].FRIEND[name].index = friendData[realmName][playerName].numFRIEND + 1;
	 friendData[realmName][playerName].numFRIEND = friendData[realmName][playerName].numFRIEND + 1;
      end
      
      friendData[realmName][playerName].FRIEND[name].surname = nachnameString;
      friendData[realmName][playerName].FRIEND[name].notes = noteString;
      friendData[realmName][playerName].FRIEND[name].title = title;
      friendData[realmName][playerName].FRIEND[name].friendstate = friendstate;
      
      friendData[realmName][playerName].FRIEND[name].class = "";
      friendData[realmName][playerName].FRIEND[name].guild = "";
      friendData[realmName][playerName].FRIEND[name].level = 0;
      friendData[realmName][playerName].FRIEND[name].type = type;
      
      FlagRSP.printM(string.gsub(FRIENDLIST_LOCALE_AddFriendMsg, "%%n", name));
   else
      -- Editing entry.
      --oldEntry = friendData[realmName][playerName].FRIEND[oldName];
      
      if friendData[realmName][playerName].FRIEND[oldName] == nil then
	 return;
      end

      friendData[realmName][playerName].FRIEND[oldName].surname = nachnameString;
      friendData[realmName][playerName].FRIEND[oldName].notes = noteString;
      friendData[realmName][playerName].FRIEND[oldName].title = title;
      friendData[realmName][playerName].FRIEND[oldName].friendstate = friendstate;

      -- if name has been changed.
      if name ~= oldName then
	 friendData[realmName][playerName].FRIEND[name] = friendData[realmName][playerName].FRIEND[oldName];
	 friendData[realmName][playerName].FRIEND[oldName] = nil;
      end
   end
   
   FRIENDLIST_Update();
end

------------------------------------------------------------------------------------------

function DelFRIEND(name)
   if(name==nil) then return; end
   if(friendData[realmName][playerName].FRIEND == nil) then return; end
   if(friendData[realmName][playerName].FRIEND[name] == nil) then return; end
   
   -- Save the index of the Person we're deleting
   local deletedIndex = friendData[realmName][playerName].FRIEND[name].index;
   
   -- Delete the Person
   friendData[realmName][playerName].FRIEND[name] = nil;
   friendData[realmName][playerName].numFRIEND = friendData[realmName][playerName].numFRIEND - 1;
   FlagRSP.printM(string.gsub(FRIENDLIST_LOCALE_DelFriendMsg, "%%n", name));
   
   -- Update data structure's indices
   for key in friendData[realmName][playerName].FRIEND do
      if (friendData[realmName][playerName].FRIEND[key]["index"] > deletedIndex) then
	 friendData[realmName][playerName].FRIEND[key]["index"] = friendData[realmName][playerName].FRIEND[key]["index"] - 1;
      end
   end
   
   FRIENDLIST_Update(true);
   
end

------------------------------------------------------------------------------------------

function ResetFRIENDLIST()
    friendData[realmName][playerName].FRIEND = {};
    friendData[realmName][playerName].numFRIEND = 0;
    FRIENDLIST_Update();
end

------------------------------------------------------------------------------------------	

function SetupfriendData()
	if (friendData == nil) then 
		--First time use
		friendData = {};
		friendData[realmName] = {};
		friendData[realmName][playerName] = {};
		friendData[realmName][playerName].FRIEND = {};
		friendData[realmName][playerName].numFRIEND = 0;
		friendData[realmName][playerName].forceReset = false;
		--friendData[realmName][playerName].showNotes = true;
		friendData[realmName][playerName].showMM = true;
		friendData[realmName][playerName].playSounds = true;
		--friendData[realmName][playerName].EverPvp = false;
		friendData[realmName][playerName].RSP = false;
	elseif (friendData[realmName] == nil) then
		--First time use on this realm
		friendData[realmName] = {};
		friendData[realmName][playerName] = {};
		friendData[realmName][playerName].FRIEND = {};
		friendData[realmName][playerName].numFRIEND = 0;
		friendData[realmName][playerName].forceReset = false;
		--friendData[realmName][playerName].showNotes = true;
		friendData[realmName][playerName].showMM = true;
 		friendData[realmName][playerName].playSounds = true;
 		--friendData[realmName][playerName].EverPvp = false;
 		friendData[realmName][playerName].RSP = false;
	elseif (friendData[realmName][playerName] == nil) then
		--First time use for this player
		friendData[realmName][playerName] = {};
		friendData[realmName][playerName].FRIEND = {};
		friendData[realmName][playerName].numFRIEND = 0;
		friendData[realmName][playerName].forceReset = false;
		--friendData[realmName][playerName].showNotes = true;
		friendData[realmName][playerName].showMM = true;
		friendData[realmName][playerName].playSounds = true;
		--friendData[realmName][playerName].EverPvp = false;
		friendData[realmName][playerName].RSP = false;
	elseif (friendData[realmName][playerName].FRIEND == nil) then
		friendData[realmName][playerName].FRIEND = {};
		friendData[realmName][playerName].numFRIEND = 0;
		friendData[realmName][playerName].forceReset = false;
		--friendData[realmName][playerName].showNotes = true;
		friendData[realmName][playerName].showMM = true;
		friendData[realmName][playerName].playSounds = true;
		--friendData[realmName][playerName].EverPvp = false;
		friendData[realmName][playerName].RSP = false;
	end
end

------------------------------------------------------------------------------------------	
	

------------------------------------------------------------------------------------------

function FRIENDLIST_ToggleGUI()
   --FRIENDLIST_Update(true);
   --FRIENDLIST_Update(resort)

   if (FriendlistMetaFrame:IsVisible()) then
      FriendlistMetaFrame:Hide();

      --FRIENDLISTFrame:Hide();
			
      local tab;
      for i=1, table.getn(Friendlist.tabs) do
	 --tabbutton = getglobal("Friendlist_PageTab" .. i);
	 
	 if not Friendlist.tabs[i][4] then 
	    Friendlist.tabs[i][4] = true;
	 end

	 -- save char frame changes.
	 FriendlistCharFrame_Save();
    
	 if Friendlist.tabs[i][3] ~= "" then
	    tab = getglobal(Friendlist.tabs[i][3]);
	    tab:Hide();
	    PlaySound("igSpellBookClose");
	    --PlaySound("igMainMenuClose");
	 end
      end
   else
      FriendlistCharFrame_Load();

      FriendlistMetaFrame:Show();
      --ShowUIPanel(FriendlistMetaFrame);
      --FRIENDLISTFrame:Show();
      --PlaySound("igMainMenuOpen");
      PlaySound("igSpellBookOpen");
      
      Friendlist.updateTabs();
   end
end

------------------------------------------------------------------------------------------


--[[

FriendlistCharFrame_OnShow()

- OnShow function for character frame.

]]--
function FriendlistCharFrame_OnShow()
   FlagRSP.printDebug("Show Charframe!");

   Friendlist.updatePages("FriendlistCharFrameNextPageButton");

   SetPortraitTexture(FriendlistCharFramePortrait, "player");

   FriendlistCharFrameTitleText:SetText(TooltipHandler.compileString(FRIENDLIST_LOCALE_CharFrameTitle, "player"));

   FriendlistCharFramePg1CertTitle:SetTextHeight(20);

   FriendlistCharFramePg1CertText1:SetText(TooltipHandler.compileString(FRIENDLIST_LOCALE_CertText1,"player"));
   FriendlistCharFramePg1CertText1:SetWidth(283);
   FriendlistCharFramePg1CertText2:SetText(TooltipHandler.compileString(FRIENDLIST_LOCALE_CertText2,"player"));
   
   FriendlistCharFramePg1CertText3:SetText(TooltipHandler.compileString(FRIENDLIST_LOCALE_CertText3,"player"));
   FriendlistCharFramePg1CertText3:SetWidth(283);

   FriendlistCharFramePg1SurnameBox:SetPoint("TOPLEFT", "FriendlistCharFramePg1CertText2", "TOPRIGHT", 4, 2);
   FriendlistCharFramePg1SurnameBox:SetWidth(279-FriendlistCharFramePg1CertText2:GetWidth());

   FriendlistCharFramePg1SurnameBoxDummyFrame:SetPoint("TOPLEFT", "FriendlistCharFramePg1CertText2", "TOPRIGHT", 4, 2);
   FriendlistCharFramePg1SurnameBoxDummyFrame:SetWidth(279-FriendlistCharFramePg1CertText2:GetWidth());

   --FlagRSP.print( FriendlistCharFramePg1CertText1:GetHeight());

   FriendlistCharFramePg1ScrollFrame:SetHeight(150-FriendlistCharFramePg1CertText1:GetHeight());
   FriendlistCharFramePg1ScrollFrameDummyFrame:SetHeight(150-FriendlistCharFramePg1CertText1:GetHeight());

   --FriendlistCharFrameCertText4:SetPoint("TOPLEFT", "FriendlistCharFrameTitleBox", "BOTTOMLEFT", 0, 12);

   --FriendlistCharFrameCharDescBox:SetHeight(108);
   --FriendlistCharFrameCharDescBox:SetHeight(108);

   --FriendlistCharFramePg1ScrollFrameChildFrameEditBox:SetHeight(108);
   FriendlistCharFramePg1ScrollFrameChildFrameEditBox:SetHeight(150-FriendlistCharFramePg1CertText1:GetHeight());
   FriendlistCharFramePg1ScrollFrameChildFrameEditBox:Show();

   --FriendlistCharFrameScrollFrameChildFrameEditBox:SetFocus();
   
   FriendlistCharFrameNextPageButtonText:SetText(TooltipHandler.compileString(FRIENDLIST_LOCALE_TurnPageButton,"player"));

   -- load settings.
   --for i=1, table.getn(Friendlist.tabs) do
   --   if Friendlist.tabs[i][3] == "FriendlistCharFrame" and Friendlist.tabs[i][4] then
   --	 FriendlistCharFrame_Load();
   --   end
   --end

   -- page 2:
   --FriendlistCharFramePg2Text2:SetPoint("TOPLEFT", "FriendlistCharFramePg2RpDropDown", "BOTTOMRIGHT", -267, 15);
   --FriendlistCharFramePg2Text2:SetBackdropColor(0,0,0,0.2);

   FriendlistCharFramePg2Text1:SetTextHeight(14);
   FriendlistCharFramePg2Text2:SetTextHeight(14);
   FriendlistCharFramePg2Text4:SetTextHeight(14);
   FriendlistCharFramePg2Text5:SetTextHeight(14);

   --FriendlistCharFramePg2Text3:SetTextHeight(9.6);
   --FriendlistCharFramePg2Text6:SetTextHeight(9.6);

   FriendlistCharFramePg2Text3:SetTextHeight(9.5);
   FriendlistCharFramePg2Text6:SetTextHeight(9.5);

   FriendlistCharFramePg2Text3:SetWidth(283);
   FriendlistCharFramePg2Text3:SetText("a sample explanation...\nin two\nthree\nand four lines.");
   FriendlistCharFramePg2DummyFrame1:SetAlpha(0.05);
   

   --FriendlistCharFramePg2Text2:SetPoint("TOPLEFT", "FriendlistCharFramePg2RPDropDown", "BOTTOMLEFT", 0, -10);

   FriendlistCharFramePg2Text6:SetWidth(283);
   FriendlistCharFramePg2Text6:SetText("a sample explanation...\nin two\nthree\nand four lines.");
   FriendlistCharFramePg2DummyFrame2:SetAlpha(0.05);
   
   --Friendlist_DropDownHandler("FriendlistCharFramePg2RPDropDown");
   --Friendlist_DropDownHandler("FriendlistCharFramePg2CSDropDown");

   UIDropDownMenu_JustifyText("LEFT", FriendlistCharFramePg2CSDropDown);

      --

   FriendlistCharFrame:SetScale(2);
   FriendlistCharFrame:SetScale(1);

   
end


--[[

FriendlistCharFrame_OnUpdate()

- OnUpdate function for character frame.

]]--
function FriendlistCharFrame_OnUpdate()
   FriendlistCharFramePg2RPDropDown:SetPoint("TOPLEFT" , "FriendlistCharFramePg2Text1", "BOTTOMLEFT", -10, -8);
   FriendlistCharFramePg2CSDropDown:SetPoint("TOPLEFT" , "FriendlistCharFramePg2Text4", "BOTTOMLEFT", -10, -8);

   --FlagRSP.printDebug(Friendlist.dropDowns["FriendlistCharFramePg2CSDropDown"].selectedValue);

   FriendlistCharFramePg2Text3:SetText(Friendlist.rpTypeExplanations[Friendlist.dropDowns["FriendlistCharFramePg2RPDropDown"].selectedValue]);
   FriendlistCharFramePg2Text6:SetText(Friendlist.csExplanations[Friendlist.dropDowns["FriendlistCharFramePg2CSDropDown"].selectedValue]);

   FriendlistCharFramePg2DummyFrame1:SetHeight(FriendlistCharFramePg2Text3:GetHeight());
   FriendlistCharFramePg2DummyFrame1:SetPoint("TOPLEFT", "FriendlistCharFramePg2Text3", "TOPLEFT", 0, 0);
   FriendlistCharFramePg2DummyFrame2:SetHeight(FriendlistCharFramePg2Text6:GetHeight());
   FriendlistCharFramePg2DummyFrame2:SetPoint("TOPLEFT", "FriendlistCharFramePg2Text6", "TOPLEFT", 0, 0);
end



--[[

FriendlistCharFramePg1ScrollFrameChildFrameEditBox_OnDescBoxFocus()

-- Function to assure description warning is being displayed once.

]]--
function FriendlistCharFramePg1ScrollFrameChildFrameEditBox_OnDescBoxFocus()
   if not Friendlist.descBoxWarningSeen then
      FlagRSP.showEditBox();
   end
end


--[[

FriendlistCharFramePg1ScrollFrameChildFrameEditBox_UpdateDescBox()

-- Update function for character's description edit box. Correct height and
   assure that player has read warning for the description.

]]--
function FriendlistCharFramePg1ScrollFrameChildFrameEditBox_UpdateDescBox()
   local theight = 150-FriendlistCharFramePg1CertText1:GetHeight();
   
   if not Friendlist.descBoxWarningSeen then
      FriendlistCharFramePg1ScrollFrameChildFrameEditBox:SetText(FlagRSP.getOwnDesc());
   end
   
   local height = FriendlistCharFramePg1ScrollFrameChildFrameEditBox:GetHeight();
   
   if height < theight then
      height = theight;
   end
      
   FriendlistCharFramePg1ScrollFrameChildFrameEditBox:SetHeight(height);
end


--[[

FriendlistCharFrame_Load()

-- Loads options for Friendlist character frame.

]]--
function FriendlistCharFrame_Load()
   FriendlistCharFramePg1SurnameBox:SetText(FlagRSP.getOwnSurname());
   FriendlistCharFramePg1TitleBox:SetText(FlagRSP.getOwnTitle());
   FriendlistCharFramePg1ScrollFrameChildFrameEditBox:SetText(FlagRSP.getOwnDesc());
   
   Friendlist.dropDownRead("FriendlistCharFramePg2RPDropDown");   
   Friendlist.dropDownRead("FriendlistCharFramePg2CSDropDown");   
   
   --Friendlist.tabs[i][4] = false;
end


--[[

FriendlistCharFrame_Save()

-- Save options from Friendlist character frame.

]]--
function FriendlistCharFrame_Save()
   --FriendlistCharFramePg1SurnameBox:SetText(FlagRSP.getOwnSurname());
   --FriendlistCharFramePg1TitleBox:SetText(FlagRSP.getOwnTitle());
   --FriendlistCharFramePg1ScrollFrameChildFrameEditBox:SetText(FlagRSP.getOwnDesc());
   surnameChanged = FlagRSP.setSurname(FriendlistCharFramePg1SurnameBox:GetText());
   titleChanged = FlagRSP.setTitle(FriendlistCharFramePg1TitleBox:GetText());
   descChanged = FlagRSP.setDesc(FriendlistCharFramePg1ScrollFrameChildFrameEditBox:GetText());

   rpChanged = Friendlist.dropDownWrite("FriendlistCharFramePg2RPDropDown");
   csChanged = Friendlist.dropDownWrite("FriendlistCharFramePg2CSDropDown");

   --FlagRSP.newTickPost = FlagRSP.newTickPost - 60;
   local changed = false;

   if surnameChanged then
      changed = true;
   elseif titleChanged then
      changed = true;
   elseif descChanged then
      changed = true;
   elseif rpChanged then
      changed = true;
   elseif csChanged then
      changed = true;
   end
      
   if changed then
      --FlagRSP.printDebug("updating flags!");
      xTooltip_Post("all", rpChanged, surnameChanged, titleChanged, descChanged, csChanged);
   end
   if descChanged then
      FlagRSPInfo.pushDescription(false);
   end
end


function FRIENDLIST_OnShow()

   FRIENDLISTFrameTitleText:SetText(FRIENDLIST_TITLE);

   --DEFAULT_CHAT_FRAME:AddMessage("Before or after C?");

   --FRIENDLISTShowNotes_OnLoad();
   --FRIENDLISTPlaySound_OnLoad();
   --FRIENDLISTEverPvp_OnLoad();
   --FRIENDLISTRSP_OnLoad();
   FRIENDLIST_Update(true);
   Friendlist.resortTick = 0;
   --FlagRSP.newTickRescaleBox = 0;   

   --PlaySound("igMainMenuOpen");
   --FRIENDLISTFrameTopLeft:Show();
   
   --getglobal("CT_CPTab" .. i):SetNormalTexture(CT_CPTabs[i][3]);

   local tabbutton;
   for i=1, 2 do
      tabbutton = getglobal("Friendlist_Tab" .. i);

      --tabbutton:Lower();
      --tabbutton:Lower();
      --tabbutton:Lower();
      --tabbutton:Lower();
      --tabbutton:Lower();
      --tabbutton:Lower();

      tabbutton:Show();
   end
   
   Friendlist.updateTabs();

   --Friendlist_Tab2:SetPoint("LEFT", "Friendlist_Tab1", "RIGHT", 10, 0);
   Friendlist.dropDownRead("Friendlist_SortDropDown");
end
			
------------------------------------------------------------------------------------------			
			
function FRIENDLIST_OnHide()
   --PlaySound("igMainMenuClose");
   FRIENDLISTFrame.selectedMember = 0;
   --if FRIENDLISTStaticPopUpAdd:IsVisible() then 
   --FRIENDLISTStaticPopUpAdd:Hide();
   --end
   --if FRIENDLISTStaticPopUpAddNN:IsVisible() then 
   --FRIENDLISTStaticPopUpAddNN:Hide();
   --end

   local dialog;
   for name,value in Friendlist.addEditDialogs do
      --FlagRSP.printM(name);
      
      dialog = getglobal(name);
      
      if dialog ~= nil and dialog:IsVisible() then
	 dialog:Hide();
      end
   end
end

------------------------------------------------------------------------------------------

function FriendlistAddEditDialog_OnMouseDown()
   if arg1 == "LeftButton" then
      this:StartMoving();
   end
end


function FriendlistAddEditDialog_OnMouseUp()
   if arg1 == "LeftButton" then
      this:StopMovingOrSizing();
   end
end


function FRIENDLISTButton_OnClick(arg1)
  
end


function FRIENDLISTButton_OnMouseDown(arg1)

   --FlagRSP.printDebug("arg1: " .. arg1);

   if arg1 == "RightButton" and FRIENDLISTFrame.selectedMember == this:GetID() then
      FlagRSP.printDebug("Right button clicked");
      
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox then
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox = false;
      else
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox = true;
      end
      
      FriendlistMain_Update(true);
   elseif arg1 == "LeftButton" then
      FRIENDLISTFrame.selectedMember = this:GetID();
      --FlagRSP.printM("Hey!");
      FRIENDLIST_Update();
      FriendlistMain_Update(true);

      if GetTime() < Friendlist.doubleClickTick then 
	 --FlagRSP.printM("Hey!");
	 if (FRIENDLISTFrame.selectedMember > 0) then
	    if FRIENDLISTStaticPopUpEdit:IsVisible() then
	       FRIENDLISTStaticPopUpEdit:Hide();
	    end
	    FRIENDLISTStaticPopUpEdit:Show();
	 end
	 Friendlist.doubleClickTick = 0; 
      else
	 Friendlist.doubleClickTick = GetTime() + 0.33; 
      end
   end
end

function FRIENDLISTButton_OnMouseUp(arg1)
   if arg1 == "RightButton" then
      FRIENDLISTButton_OnClick(arg1);
   end
end

------------------------------------------------------------------------------------------

function FRIENDLIST_Update(resort)

   FlagRSP.printDebug("called: FRIENDLIST_Update");

   if resort == nil then
      resort = false;
   end

   if (not initialized) then
      FRIENDLIST_Initialize();
      return;
   end

   --FlagRSP.printDebug("Update called");
   
   SetupfriendData();
   
   --Version 1.1 additions
   --Need to force a reset of our data for version 1.0 upgrade
   if ( (friendData[realmName][playerName].forceReset == nil) or
       (friendData[realmName][playerName].forceReset == "") or
	  (friendData[realmName][playerName].forceReset == true) ) then
      
      FRIENDLIST_ResetData();
   end
   
   --Update Scrolling Frame
   local nameOffset = FauxScrollFrame_GetOffset(FRIENDLISTBFScrollFrame);
   local nameIndex;

   --if nameOffset ~= nil then
   --   FlagRSP.printDebug("nameOffset for Scrollframe is" .. nameOffset);
   --end

   -- update friends frame to assure we get correct coordinates.
   

   if GetTime() > Friendlist.updateEntryTick or resort then
      Friendlist.updateEntry("", "flist");
      Friendlist.updateEntryTick = GetTime() + Friendlist.updateEntryInterval;
   end      

   if GetTime() > Friendlist.resortTick or resort then
      buffTable = FLSorting.sortTable(friendData[realmName][playerName].FRIEND);
      Friendlist.resortTick = GetTime() + Friendlist.resortInterval;
   end

   --FLSorting.test(friendData[realmName][playerName].FRIEND);

   local ticks = {};

   for i=1, FRIENDLIST_NAMES_TO_DISPLAY, 1 do
      --FlagRSP.printDebug("entry: " .. i .. ". It is: " .. GetTime());
      ticks[i] = GetTime();
      
      listIndex = nameOffset + i;
      
      --FlagRSP.printM(i);

      nameIndex = FLSorting.getRealEntry(buffTable, listIndex);

      nameLine = getglobal("FRIENDLISTBFButton"..i.."ButtonTextName");
      classLine = getglobal("FRIENDLISTBFButton"..i.."ButtonTextClass");
      noteLine = getglobal("FRIENDLISTBFButton"..i.."ButtonTextNotes");
      btn = getglobal("FRIENDLISTBFButton" .. i);
      btnTex = getglobal("FRIENDLISTBFButton" .. i .. "NormalTexture");

      --lines = {};

      if Friendlist.isOnline(TooltipHandler.getName("index" .. nameIndex)) == 1 then
	 btnTex:SetTexture("Interface\\Addons\\flagRSP\\Art\\online-bg");
	 btnTex:SetAlpha(0.25);
      else
	 btnTex:SetTexture("");
	 --btnTex:SetAlpha(0.5);
      end      

      nameLine:SetTextColor(1,1,1);

      local entryName;

      for key,value in friendData[realmName][playerName].FRIEND do
	 if value.index ~= nil and nameIndex == value.index then
	    -- we found our entry, key is wanted name
	    entryName = key;
	 end
      end
      
      local notesText = Friendlist.getNotes(entryName);

      notesText = string.gsub(notesText, "\n", " ");
      if string.len(notesText) > 100 then
	 notesText = string.sub(notesText,1,100) .. "...";
      end

      local nameText;
      local surname = TooltipHandler.getSurname(entryName);
      if surname ~= nil and surname ~= "" then
	 nameText = entryName .. " " .. surname;
      else
	 nameText = entryName;
      end

      if nameText == nil then
	 nameText = "";
      end
	 
      local titleText = TooltipHandler.getTitle(entryName);
      if titleText ~= "" then
	 titleText = ", " .. titleText;
      end

      local raceText = Friendlist.getRace(entryName);
      --TooltipHandler.compileString("%UnitRace ","index" .. nameIndex);
      if raceText ~= "" then
	 raceText = raceText .. " ";
      end

      local classText = Friendlist.getClass(entryName);
      --TooltipHandler.compileString("%UnitClass","index" .. nameIndex);
         
      local levelText;   
      --TooltipHandler.compileString(", %flagRSPLevel","index" .. nameIndex);
      if Friendlist.getLevel(entryName) ~= 0 and Friendlist.getLevel(entryName) ~= "" then
	 levelText = ", " .. TooltipHandler.getLevelText("index" .. nameIndex);
      else
	 levelText = "";
      end
      
      local guildText = ", <" .. Friendlist.getGuild(iname) .. ">";
	 --TooltipHandler.compileString(", <%UnitGuild>","index" .. nameIndex);
      if guildText == ", <>" then
	 guildText = "";
      end

      --local rankText = TooltipHandler.compileString(", %UnitRank","index" .. nameIndex);
      --if rankText == ", " then
	 rankText = "";
      --end

      if notesText == "Gilde" then
	 notesText = FRIENDLIST_LOCALE_GuildLine;
      end

      local onlineText = Friendlist.getOnlineStatus(entryName, "index" .. nameIndex);

      -- (%FriendlistFriendstateText)
      --nameLine:SetText(TooltipHandler.compileString("|cff%FriendlistFriendstateColour" .. nameText .. "|r" .. titleText .. " %FriendlistOnlineStatus","index" .. nameIndex));
      nameLine:SetText("|cff" .. Friendlist.getFriendstateColour(entryName) .. nameText .. "|r" .. titleText .. " " .. onlineText);
      
      classLine:SetText(" " .. raceText .. classText .. levelText .. guildText .. rankText);
      noteLine:SetText(" " .. notesText);
      
      --nameLine:SetWidth(425);
      --classLine:SetWidth(425);
      --noteLine:SetWidth(425);
      
      nameWidth = nameLine:GetWidth();
      notesWidth = noteLine:GetWidth();

      local colourCode = Friendlist.getFriendstateColour(entryName);
           
      while nameWidth > 415 do
	 if string.len(nameText) <= string.len(titleText) then
	    if string.sub(titleText,string.len(titleText)-2,string.len(titleText)) ~= "..." then
	       titleText = titleText .. "...";
	    end
	    titleText = string.sub(titleText, 1, string.len(titleText)-4) .. "...";
	 else
	    if string.sub(nameText,string.len(nameText)-2,string.len(nameText)) ~= "..." then
	       nameText = nameText .. "...";
	    end
	    nameText = string.sub(nameText, 1, string.len(nameText)-4) .. "...";
	 end

	 nameLine:SetText("|cff" .. colourCode .. nameText .. "|r" .. titleText .. " " .. onlineText);

	 nameWidth = nameLine:GetWidth();
      end

      --FlagRSP.printDebug("nameLine height: line " .. i .. ", "  .. nameLine:GetWidth());

      --if notesWidth < 415 then
	 --notesText = notesText .. "...";
      --end

      while notesWidth > 415 do
	 if notesWidth > 450 then
	    notesText = string.sub(notesText, 1, string.len(notesText)-8) .. "...";
	 else
	    notesText = string.sub(notesText, 1, string.len(notesText)-5) .. "...";
	 end

	 noteLine:SetText(" " .. notesText);
	 notesWidth = noteLine:GetWidth();
      end
   
      nameButton = getglobal("FRIENDLISTBFButton"..i);
      nameButton:SetID(nameIndex);
      
      -- Update the highlight
      if ( nameIndex == FRIENDLISTFrame.selectedMember ) then
	 nameButton:LockHighlight();
      else
	 nameButton:UnlockHighlight();
      end
      
      -- Turn off Lines not in use
      if ( nameIndex > friendData[realmName][playerName].numFRIEND) then
	 nameButton:Hide();
      else
	 nameButton:Show();
      end
   end

   ticks[FRIENDLIST_NAMES_TO_DISPLAY+1] = GetTime();

   for i=1, FRIENDLIST_NAMES_TO_DISPLAY, 1 do
      FlagRSP.printDebug("entry: " .. i .. ". It is: " .. ticks[i+1]-ticks[i]);
   end

   -- ScrollFrame stuff
   FauxScrollFrame_Update(FRIENDLISTBFScrollFrame, friendData[realmName][playerName].numFRIEND, FRIENDLIST_NAMES_TO_DISPLAY, FRIENDLIST_FRAME_HEIGHT );
end


--[[

FriendlistMain_Update()

-- Updates the Friendlist main frame

]]--
function FriendlistMain_Update(update)

   if update == nil then
      update = false;
   end

   if not FlagRSPConfigure_IsInitialized() then
      return "";
   end

   if GetTime() > Friendlist.updateTickInfoBox or update then
      --FlagRSP.printDebug("called: FriendlistMain_Update");
      
      --DEFAULT_CHAT_FRAME:AddMessage("Before or after C?");
      FRIENDLISTFrameInfoBox:Show();
      
      local index = FRIENDLISTFrame.selectedMember;
      if FRIENDLISTFrame.selectedMember > 0 and TooltipHandler.getName("index" .. index) ~= "" then
	 
	 lines = {};
	 
	 if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox then 
	    if TooltipHandler.compileString("%flagRSPSurname","index" .. index) ~= "" then
	       lines[1] = TooltipHandler.compileString("|cff%FriendlistFriendstateColour%UnitName %flagRSPSurname|r","index" .. index);
	    else
	       lines[1] = TooltipHandler.compileString("|cff%FriendlistFriendstateColour%UnitName|r","index" .. index);
	    end
	    
	    -- (%FriendlistFriendstateText)
	    lines[2] = TooltipHandler.compileString("%FriendlistFriendstateText","index" .. index);
	    
	    lines[3] = TooltipHandler.compileString("%UnitTitle","index" .. index);
	    
	    lines[4] = TooltipHandler.compileString("<%UnitGuild>","index" .. index);
	    if lines[4] == "<>" then
	       lines[4] = "";
	    end
	    
	    if TooltipHandler.compileString("%UnitRace","index" .. index) == "" then
	       lines[5] = TooltipHandler.compileString("%UnitClass","index" .. index);
	    else
	       lines[5] = TooltipHandler.compileString("%UnitRace %UnitClass","index" .. index);
	    end
	    
	    --FlagRSP.printDebug("level of a guild: " .. TooltipHandler.getLevel("index" .. index));
	    
	    if TooltipHandler.getLevel("index" .. index) ~= 0 and TooltipHandler.getLevel("index" .. index) ~= "" then
	       lines[6] = TooltipHandler.compileString("%flagRSPLevel","index" .. index);
	    end
	    
	    lines[7] = TooltipHandler.compileString("%flagRSPRankLine","index" .. index);
	    
	    lines[8] = TooltipHandler.compileString("%flagRSPRPLine","index" .. index);
	    
	    lines[9] = TooltipHandler.compileString("%flagRSPCharStatusLine","index" .. index);
	    
	    local playerID = "index" .. index;
	    
	    if FlagRSPInfo.FLInfoIsExpanded then
	       notesText = Friendlist.getNotes(TooltipHandler.getName(playerID));
	       descText = FlagRSPInfo.getDescription(TooltipHandler.getName(playerID));
	    else
	       notesText = Friendlist.getNotes(TooltipHandler.getName(playerID));
	       
	       if string.len(notesText) > FlagRSPInfo.maxCharsUnExpanded then
		  notesText = string.sub(notesText, 1, FlagRSPInfo.maxCharsUnExpanded) .. "..."; 
	       end
	       
	       descText = FlagRSPInfo.getDescription(TooltipHandler.getName(playerID), playerID, FlagRSPInfo.maxCharsUnExpanded);
	    end
	    
	    if notesText == "Gilde" then
	       notesText = FRIENDLIST_LOCALE_GuildLine;
	    end
	    
	    if notesText ~= "" and notesText ~= nil then
	       lines[10] = "|cFFFFFF00" .. FlagRSP_Locale_InfoBoxNotes .. "|r |cFFFFFFFF" .. notesText .. "|r";
	    end
	    if descText ~= "" and descText ~= nil then
	       lines[11] = "|cFFFFFF00" .. FlagRSP_Locale_InfoBoxDesc .. "|r |cFFFFFFFF" .. descText .. "|r";
	    end
	 end
	 
	 if not FlagRSPInfo.FLInfoIsMoving then
	    FlagRSPInfo.updateBox("FRIENDLISTFrameInfoBox", lines, "FRIENDLISTFrame", false, FlagRSPInfo.FLInfoX, FlagRSPInfo.FLInfoY, 300, FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox);
	 end
      else
	 FlagRSPInfo.updateBox("FRIENDLISTFrameInfoBox", lines, "FRIENDLISTFrame", false, FlagRSPInfo.FLInfoX, FlagRSPInfo.FLInfoY, 300, false);
      end
      
      Friendlist.updateTickInfoBox = GetTime() + Friendlist.updateInfoBoxInterval;
   end
   
   if GetTime() > Friendlist.updateTick then
      FRIENDLIST_Update();
      Friendlist.updateTick = GetTime() + Friendlist.updateInterval;
   end
end


function FRIENDLISTFrameInfoBoxCloseButton_OnClick()
   FlagRSP.printDebug("Close!");
   FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox = false;
end

------------------------------------------------------------------------------------------

function GetFRIENDInfo(index)
   for key,value in friendData[realmName][playerName].FRIEND do
      for key2,value2 in friendData[realmName][playerName].FRIEND[key] do
	 if (key2 == "index") and (index == value2) then
	    name = key;
	    notes = friendData[realmName][playerName].FRIEND[key].notes;
	    class = friendData[realmName][playerName].FRIEND[key].class;
	    guild = friendData[realmName][playerName].FRIEND[key].guild;
	    level = friendData[realmName][playerName].FRIEND[key].level;
	    killCount = friendData[realmName][playerName].FRIEND[key].killCount;
	    killedByCount = friendData[realmName][playerName].FRIEND[key].killedByCount;
	    friendstate = friendData[realmName][playerName].FRIEND[key].friendstate;
	    nachname = friendData[realmName][playerName].FRIEND[key].surname;
	    
	    return name, notes, class, guild, level, killCount, killedByCount, friendstate, nachname;
	 end
      end
   end
   return "Unbekannt";
end

------------------------------------------------------------------------------------------

function FRIENDLIST_ResetData()
--Loop through the entire table
	for key,value in friendData[realmName][playerName].FRIEND do
		if (friendData[realmName][playerName].FRIEND[key].guild == nil) then
			friendData[realmName][playerName].FRIEND[key].guild = "";
		end
		if (friendData[realmName][playerName].FRIEND[key].notes == nil) then
			friendData[realmName][playerName].FRIEND[key].notes = "";
		end
		if (friendData[realmName][playerName].FRIEND[key].level == nil) then
			friendData[realmName][playerName].FRIEND[key].level = 0;
		end
		if (friendData[realmName][playerName].FRIEND[key].class == nil) then
		 	friendData[realmName][playerName].FRIEND[key].class = "Unbekannt";
		end
		if (friendData[realmName][playerName].FRIEND[key].friendstate == nil) then
			friendData[realmName][playerName].FRIEND[key].friendstate = 0;
		end
		if (friendData[realmName][playerName].FRIEND[key].killCount == nil) then
			friendData[realmName][playerName].FRIEND[key].killCount = 0;
		end
		if (friendData[realmName][playerName].FRIEND[key].killedByCount == nil) then
			friendData[realmName][playerName].FRIEND[key].killedByCount = 0;
		end
		if (friendData[realmName][playerName].FRIEND[key].surname == nil) then
			friendData[realmName][playerName].FRIEND[key].surname = "";
		end
	end

	friendData[realmName][playerName].forceReset = false;
	--friendData[realmName][playerName].showNotes = true;
	friendData[realmName][playerName].showMM = true;
	friendData[realmName][playerName].playSounds = true;
	--friendData[realmName][playerName].EverPvp = false;
	friendData[realmName][playerName].RSP = false;
end

------------------------------------------------------------------------------------------

function PrintFRIENDLIST()
	if ( (friendData == nil) or
		 (friendData[realmName] == nil) or
		 (friendData[realmName][playerName] == nil) or
		 (friendData[realmName][playerName].FRIEND == nil) or 
		 (friendData[realmName][playerName].numFRIEND == 0) ) then
		Print_Chat("FRIEND Data is empty");
	else
		for key,value in friendData[realmName][playerName].FRIEND do
			Print_Chat("Name: "..key);
			for key2,value2 in friendData[realmName][playerName].FRIEND[key] do
				Print_Chat("   Nachname: "..friendData[realmName][playerName].FRIEND[key].surname);
				Print_Chat("   Class: "..friendData[realmName][playerName].FRIEND[key].class);
				Print_Chat("   Guild: "..friendData[realmName][playerName].FRIEND[key].guild);
				Print_Chat("   Notes: "..friendData[realmName][playerName].FRIEND[key].notes);
				Print_Chat("   Level: "..friendData[realmName][playerName].FRIEND[key].level);
			--	Print_Chat("   Wins: "..friendData[realmName][playerName].FRIEND[key].killCount);
			--	Print_Chat("   Losses: "..friendData[realmName][playerName].FRIEND[key].killedByCount);
			end
		end
	end
end

------------------------------------------------------------------------------------------		
-- /////////////////////////////////////////////////////////////////////////////////////--
--   								GUI FUNCTIONALITY
-- /////////////////////////////////////////////////////////////////////////////////////--
------------------------------------------------------------------------------------------		

function FRIENDLISTRemoveButton_OnClick()
   local name, notes, class, guild, level, killCount, killedByCount, friendstate, nachname;
   
   if (FRIENDLISTFrame.selectedMember > 0) then
      name, notes, class, guild, level, killCount, killedByCount, friendstate, nachname = GetFRIENDInfo(FRIENDLISTFrame.selectedMember);
      DelFRIEND(name);
      FRIENDLIST_Update();
      --else
      --Print_Chat("Keine Person/Gilde zum l\195\182schen ausgew\195\164hlt");
   end
end

------------------------------------------------------------------------------------------

function FRIENDLISTMiniMap_OnLoad()
   	
   if (not initialized) then FRIENDLIST_Initialize(); return; end
   if (friendData == nil) then return; end
   if (friendData[realmName] == nil) then return; end
   if (friendData[realmName][playerName] == nil) then return; end
   
   if ( (friendData[realmName][playerName].showMM == false) or
       (friendData[realmName][playerName].showMM == nil) ) then
      friendData[realmName][playerName].showMM = false;
      FRIENDLISTMinimapButton:Hide();
   else
      friendData[realmName][playerName].showMM = true;
      FRIENDLISTMinimapButton:Show();
   end
end

------------------------------------------------------------------------------------------
--[[
function FRIENDLISTPlaySound_OnLoad()
	if (not initialized) then FRIENDLIST_Initialize(); return; end
	if (friendData == nil) then return; end
	if (friendData[realmName] == nil) then return; end
	if (friendData[realmName][playerName] == nil) then return; end
	if (friendData[realmName][playerName].playSounds == nil) then return; end
	
	if (friendData[realmName][playerName].playSounds == false) then
	    FRIENDLISTFramePlaySoundCheckButton:SetChecked(0);
	else
		FRIENDLISTFramePlaySoundCheckButton:SetChecked(1);
	end
end
]]--
------------------------------------------------------------------------------------------
--[[
function FRIENDLISTPlaySound_OnClick()	
	if (not initialized) then FRIENDLIST_Initialize(); return; end
	if (friendData == nil) then return; end
	
	if (not FRIENDLISTFramePlaySoundCheckButton:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
		friendData[realmName][playerName].playSounds = false;
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		friendData[realmName][playerName].playSounds = true;
	end
end
]]--
------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------
--[[
function FRIENDLISTRSP_OnLoad()
	if (not initialized) then FRIENDLIST_Initialize(); return; end
	if (friendData == nil) then return; end
	if (friendData[realmName] == nil) then return; end
	if (friendData[realmName][playerName] == nil) then return; end
	if (friendData[realmName][playerName].RSP == nil) then return; end
	
	if FlagRSP.getRPFlag() > 0 then 
	   friendData[realmName][playerName].RSP = true;
	else
	   friendData[realmName][playerName].RSP = false;
	end

	if (friendData[realmName][playerName].RSP == false) then
	    FRIENDLISTFrameRSPCheckButton:SetChecked(0);
	else
	   FRIENDLISTFrameRSPCheckButton:SetChecked(1);
	end
     end
]]--

------------------------------------------------------------------------------------------

--[[
function FRIENDLISTRSP_OnClick()	
   if (not initialized) then FRIENDLIST_Initialize(); return; end
   if (friendData == nil) then return; end
   
   if (not FRIENDLISTFrameRSPCheckButton:GetChecked()) then
      PlaySound("igMainMenuOptionCheckBoxOff");
      friendData[realmName][playerName].RSP = false;
      
      FlagRSP.disableRPTags();
   else
      PlaySound("igMainMenuOptionCheckBoxOn");
      friendData[realmName][playerName].RSP = true;

      FlagRSP.enableRPTags();   
   end
end
]]--

------------------------------------------------------------------------------------------
--======================================================================================--
-- STATIC POPUP ADD -- STATIC POPUP ADD -- STATIC POPUP ADD -- STATIC POPUP ADD         -- 
--======================================================================================--
------------------------------------------------------------------------------------------

function FRIENDLISTStaticPopUpAdd_OnClick(index)
   local name = nil;
   local nachnameString = nil;
   local noteString = nil;
   if (index == 1) then
      -- ADD button
      local editbox1 = getglobal(this:GetParent():GetName().."EditBox1");
      local editbox2 = getglobal(this:GetParent():GetName().."EditBox2");
      local editbox3 = getglobal(this:GetParent():GetName().."ScrollFrameChildFrameEditBox");
      local checkbox = getglobal(this:GetParent():GetName().."FRIENDCheckButton");
      
      
      --getglobal(this:GetName().."EditBox1"):Insert(name);
      --name = "TestName";
      --EditBox1:Insert(name);
      
      name = editbox1:GetText();
      nachnameString = editbox2:GetText();
      noteString = editbox3:GetText();
      
      if (checkbox:GetChecked() == 1) then 
	 checked = true;
      else
	 checked = false;
      end
      
      
      --Edit Boxes do not return nil when there is no text
      if (editbox1:GetNumLetters() <= 0) then
	 name = nil;
      end
      if (editbox2:GetNumLetters() <= 0) then
	 nachnameString = "";
      end
      if (editbox3:GetNumLetters() <= 0) then
	 noteString = "";
      end
      
      
      if ( (name ~= nil) and (name ~= "") ) then
	 if (noteString == nil) and (nachnameString == nil) then 
	    AddFRIEND(name, "", "");
	 else
	    AddFRIEND(name, noteString, nachnameString);
	 end
	 
	 --Update friendly status based on checkbox value
	 if (checked) then
	    --Enemy flagged
	    friendData[realmName][playerName].FRIEND[name].friendstate = -10;
	 else
	    friendData[realmName][playerName].FRIEND[name].friendstate = 10;
	 end
      end
      
      FRIENDLIST_Update();
      this:GetParent():Hide();
      
      elseif(index == 2) then
      -- CANCEL button
      this:GetParent():Hide();
   end
end


--[[

Friendlist.getEntryLines(i)

- Get lines for Friendlist entry with index i


function Friendlist.getEntryLines(i)
   local nameLine;
   local statusLine;
   local notesLine;

   name = Friendlist.getEntryName(i); --i
   surname = Friendlist.getSurname(name);
   r,g,b,friendstateText = Friendlist.getFriendstateInfo(Friendlist.getFriendstate(name));
   
   title = Friendlist.getTitle(name); --i
   online, currentLoc = Friendlist.getOnlineStats(name); --i
   class = Friendlist.getClass(name);
   if xTP_LevelChange[UnitName("player")] == 1 then
      levelDesc = TooltipHandler.getAlternativeEnemyLevelText(Friendlist.getLevel(name));
   else
      levelDesc = Friendlist.getLevel(name);
   end
end
]]--

------------------------------------------------------------------------------------------	

function FRIENDLISTStaticPopUpAdd_OnHide()
   getglobal(this:GetName().."EditBox1"):SetText("");
   getglobal(this:GetName().."EditBox2"):SetText("");
   getglobal(this:GetName().."EditBox3"):SetText("");
end

------------------------------------------------------------------------------------------	

function FriendlistAddEditDialog_getElements(base)
   titleText = getglobal(base .. "Title");
   texts = {
      getglobal(base .. "NameText"),
      getglobal(base .. "SurnameText"),
      getglobal(base .. "TitleText"),
      getglobal(base .. "FriendstateText"),
      getglobal(base .. "NotesText")
   }
   boxes = {
      { getglobal(base .. "EditBox1"), getglobal(base .. "EditBox1DummyFrame")},
      { getglobal(base .. "EditBox2"), getglobal(base .. "EditBox2DummyFrame")},
      { getglobal(base .. "EditBox3"), getglobal(base .. "EditBox3DummyFrame")},
      {},
      { getglobal(base .. "ScrollFrame"), getglobal(base .. "ScrollFrameDummyFrame"),  getglobal(base .. "ScrollFrameChildFrame"), getglobal(base .. "ScrollFrameChildFrameEditBox")},
   }
   dropDown = getglobal(base .. "DropDown");
   buttons = {
      getglobal(base .. "Accept"),
      getglobal(base .. "CloseButton")
   }

   return titleText, texts, boxes, dropDown, buttons;
end


function FRIENDLISTStaticPopUpAdd_OnShow()
   base = this:GetName();
   titleText, texts, boxes, dropDown, buttons = FriendlistAddEditDialog_getElements(base);

   local tVis = Friendlist.addEditDialogs[base].textsVisibility;
   local type = "char";

   if tVis == nil then
      --tVis = {};
      name = TooltipHandler.getName("index" .. FRIENDLISTFrame.selectedMember);
      getglobal(base .. "NameDummy"):SetText(name);
      FlagRSP.printDebug("editing " .. name);
      
      if friendData[realmName][playerName].FRIEND[name].type == "guild" then
	 FlagRSP.printDebug(name .. "is guild");
	 if Friendlist.addEditDialogs[base].guildTextsVisibility ~= nil then
	    FlagRSP.printDebug("is nil");
	 else
	    FlagRSP.printDebug("is not nil");
	 end
	 tVis = Friendlist.addEditDialogs[base].guildTextsVisibility;
	 Friendlist.dropDowns[dropDown:GetName()] = Friendlist.dropDowns["FRIENDLISTStaticPopUpAddGuildDropDown"];
	 type = "guild";
      elseif friendData[realmName][playerName].FRIEND[name].type == "char" then
	 FlagRSP.printDebug(name .. "is char");
	 if Friendlist.addEditDialogs[base].charTextsVisibility ~= nil then
	    FlagRSP.printDebug("is nil");
	 else
	    FlagRSP.printDebug("is not nil");
	 end
	 tVis = Friendlist.addEditDialogs[base].charTextsVisibility;


	 --tVis[1] = Friendlist.addEditDialogs[base].charTextsVisibility[1];
	 --tVis[2] = Friendlist.addEditDialogs[base].charTextsVisibility[2];
	 --tVis[3] = Friendlist.addEditDialogs[base].charTextsVisibility[3];
	 --tVis[4] = Friendlist.addEditDialogs[base].charTextsVisibility[4];
	 --tVis[5] = Friendlist.addEditDialogs[base].charTextsVisibility[5];
	 Friendlist.dropDowns[dropDown:GetName()] = Friendlist.dropDowns["FRIENDLISTStaticPopUpAddDropDown"];
      end
   end

   titleText:SetText("Title text here");
   titleText:SetTextHeight(16);

   this:SetScale(2);
   this:SetScale(1);
   
   local maxwidth = 0;
   local sumheight = 0;
   local width;

   local lastVisible = 1;
   for i=2, table.getn(texts) do
      if tVis[i] then
	 FlagRSP.printDebug("show " .. i);

	 texts[i]:SetPoint("TOPLEFT", texts[lastVisible]:GetName(), "BOTTOMLEFT", 0, -18);

	 if boxes[i][1] ~= nil then
	    boxes[i][1]:Show();
	    boxes[i][2]:Show();
	 end
	 texts[i]:Show();

	 lastVisible = i;
      else
	 FlagRSP.printDebug("hide " .. i);
	  
	 if boxes[i][1] ~= nil then
	    boxes[i][1]:Hide();
	    boxes[i][2]:Hide();
	 end
	 
	 texts[i]:Hide();
      end
   end

   for i=1, table.getn(texts) do
      if texts[i]:IsVisible() then
	 width = texts[i]:GetWidth();
	 sumheight = sumheight + texts[i]:GetHeight() + 18;
      else
	 width = 0;
	 FlagRSP.printDebug("text " .. i .. "is not visible");
      end
      if width > maxwidth then maxwidth = width; end
   end

   -- prepare window.   
   for i=1, table.getn(boxes) do
      if boxes[i][1] ~= nil then
	 --FlagRSP.printDebug("attaching " .. boxes[i][1]:GetName() .. " to " .. texts[i]:GetName());
	 --FlagRSP.printDebug("attaching " .. boxes[i][2]:GetName() .. " to " .. texts[i]:GetName());
	 boxes[i][1]:SetPoint("TOPLEFT",texts[i]:GetName(),"TOPLEFT",maxwidth+10,3);
	 boxes[i][2]:SetPoint("TOPLEFT",texts[i]:GetName(),"TOPLEFT",maxwidth+10,3);

	 boxes[i][1]:SetWidth(this:GetWidth()-45-maxwidth);
	 boxes[i][2]:SetWidth(this:GetWidth()-45-maxwidth);
	 
	 boxes[i][2]:SetTexture("Interface\\AddOns\\flagRSP\\BackDropWhite");

	 if boxes[i][3] ~= nil then
	    --FlagRSP.printDebug("scroll frame!");
	    boxes[i][1]:SetWidth(this:GetWidth()-67-maxwidth);
	    boxes[i][2]:SetWidth(this:GetWidth()-68-maxwidth);
	    boxes[i][3]:SetWidth(this:GetWidth()-68-maxwidth);
	    boxes[i][4]:SetWidth(this:GetWidth()-68-maxwidth);
	    
	    boxes[i][4]:SetTextColor(1,1,1);
	    boxes[i][4]:SetText("");
	 else
	    boxes[i][1]:SetTextColor(1,1,1);
	    boxes[i][1]:SetText("");
	 end
	 
	 --boxes[i][1]:Show();
      end
   end

   boxes[1][1]:SetFocus();

   dropDown:SetPoint("TOPLEFT",texts[4]:GetName(),"TOPLEFT",maxwidth-6,8);
   Friendlist_DropDownSetValue(dropDown:GetName(), 0);

   Friendlist.dropDowns[dropDown:GetName()].width = this:GetWidth()-65-maxwidth;
   FlagRSP.printDebug(boxes[table.getn(boxes)][4]:GetName());
   Friendlist.scrollFrames[boxes[table.getn(boxes)][4]:GetName()].height = this:GetHeight()-65-sumheight;
   
   --init = getglobal(Friendlist.dropDowns[dropDown:GetName()].initialize);
   --init(dropDown:GetName());
   dropDown:Hide();
   dropDown:Show();

   this:SetBackdropColor(0,0,0,0.9);
   
   titleText:SetText(Friendlist.addEditDialogs[base].titleText);
   buttons[1]:SetText(Friendlist.addEditDialogs[base].acceptText);
   buttons[2]:SetText(Friendlist.addEditDialogs[base].closeText);

   Friendlist.showFriendlistEntryBox = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox;
   FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox = false;

   local dialog;
   for name,value in Friendlist.addEditDialogs do
      --FlagRSP.printM(name);
      
      dialog = getglobal(name);

      if dialog ~= nil and dialog:IsVisible() and dialog ~= this then
	 dialog:Hide();
      end
   end
   
   --	getglobal(this:GetName().."EditBox1"):SetFocus();

   init = getglobal(Friendlist.addEditDialogs[base].initialize);

   if init ~= nil then
      init(boxes, type);
   else
      FlagRSP.printDebug("No init function for: " .. base);
   end   
end


--[[

FriendlistAddEditDialog_OnButtonClick(state)

-- Handler function for clicked buttons in add/edit dialogs.

]]--
function FriendlistAddEditDialog_OnButtonClick(state)
   base = this:GetParent():GetName();
   local returnLevel;

   FlagRSP.printDebug(base);
   titleText, texts, boxes, dropDown = FriendlistAddEditDialog_getElements(base);
   
   if state == 1 then
      onAccept = getglobal(Friendlist.addEditDialogs[base].acceptClicked);
      
      if onAccept ~= nil then
	 returnLevel = onAccept(boxes);
      else
	 FlagRSP.printDebug("No onAccept function for: " .. base);
      end   
      
   elseif state == 0 then
      this:GetParent():Hide();
   end

   if returnLevel == 0 or state == 0 then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showFriendlistEntryBox = Friendlist.showFriendlistEntryBox;
   end
end


--[[

Friendlist_initAddFriendDialog(boxes)

-- initialization function for the add friend dialog.

]]--
function Friendlist_initAddFriendDialog(boxes)
   FlagRSP.printDebug("Initializing add friend frame");
   
   targetName = UnitName("target");
      
   if targetName ~= nil then
      boxes[2][1]:SetFocus();      

      boxes[1][1]:SetText(targetName);
      surname = TooltipHandler.getSurname(targetName);
      boxes[2][1]:SetText(surname);
      title = TooltipHandler.getTitle(targetName);
      boxes[3][1]:SetText(title);
   end
end


--[[

Friendlist_initAddGuildDialog(boxes)

-- initialization function for the add guild dialog.

]]--
function Friendlist_initAddGuildDialog(boxes)
   FlagRSP.printDebug("Initializing add friend frame");
   
   guildName = GetGuildInfo("target");
      
   if guildName ~= nil then
      boxes[1][1]:SetText(guildName);
      
      boxes[5][4]:SetFocus();
   end
end


--[[

Friendlist_initEditEntryDialog(boxes,type)

-- initialization function for the edit dialog.

]]--
function Friendlist_initEditEntryDialog(boxes,type)
   FlagRSP.printDebug("Initializing edit friend frame");
   
   playerID = "index" .. FRIENDLISTFrame.selectedMember;
   name = TooltipHandler.getName(playerID);
   notes = Friendlist.getNotes(name);
   friendstate = Friendlist.getFriendstate(name);

   boxes[1][1]:SetText(name);
   boxes[5][4]:SetText(notes);

   Friendlist_DropDownSetValue(dropDown:GetName(), friendstate);

   if type == "char" then
      r,g,b,text = Friendlist.getFriendstateInfo(friendstate);

      Friendlist.dropDowns["FRIENDLISTStaticPopUpEditDropDown"].selectedText = text;
      
      FRIENDLISTStaticPopUpEditDropDown:Hide();
      FRIENDLISTStaticPopUpEditDropDown:Show();

      surname = TooltipHandler.getSurname(name);
      title = TooltipHandler.getTitle(name);

      boxes[2][1]:SetText(surname);
      boxes[3][1]:SetText(title);
   elseif type == "guild" then
      r,g,b,text = Friendlist.getFriendstateGuildInfo(friendstate);
       
      Friendlist.dropDowns["FRIENDLISTStaticPopUpEditDropDown"].selectedText = text;
      
      FRIENDLISTStaticPopUpEditDropDown:Hide();
      FRIENDLISTStaticPopUpEditDropDown:Show();
   else
      FlagRSP.printA(3);
   end
   
end


--[[

Friendlist_addFriendOnAccept(boxes)

-- function for add friend dialog after acccept click.

]]--
function Friendlist_addFriendOnAccept(boxes)
   FlagRSP.printDebug("Adding friend clicked.");

   local exitCode = 1;

   name = boxes[1][1]:GetText();
   surname = boxes[2][1]:GetText();
   title = boxes[3][1]:GetText();
   notes = boxes[5][4]:GetText();
   friendstate = Friendlist.dropDowns["FRIENDLISTStaticPopUpAddDropDown"].selectedValue;
   
   FlagRSP.printDebug("Adding " .. name .. " " .. surname .. ", title: " .. title .. " and notes: " .. notes .. ". Friendstate is: " .. friendstate);

   if name ~= nil and name ~= "" and not Friendlist.isFriend(name) then
      AddFRIEND(name, notes, surname, title, friendstate, "char");
      this:GetParent():Hide();
      exitCode = 0;
   elseif Friendlist.isFriend(name) then
      FlagRSP.printE(string.gsub(FRIENDLIST_LOCALE_NameExistsMsg,"%%n",name));
   end

   return exitCode;
end


--[[

Friendlist_addGuildOnAccept(boxes)

-- function for add guild dialog after acccept click.

]]--
function Friendlist_addGuildOnAccept(boxes)
   FlagRSP.printDebug("Adding guild clicked.");

   local exitCode = 1;

   name = boxes[1][1]:GetText();
   notes = boxes[5][4]:GetText();
   friendstate = Friendlist.dropDowns["FRIENDLISTStaticPopUpAddGuildDropDown"].selectedValue;
   
   FlagRSP.printDebug("Adding " .. name .. " and notes: " .. notes .. ". Friendstate is: " .. friendstate);

   if name ~= nil and name ~= "" and not Friendlist.isFriend(name) then
      AddFRIEND(name, notes, "", "", friendstate, "guild");
      this:GetParent():Hide();
      exitCode = 0;
   elseif Friendlist.isFriend(name) then
      FlagRSP.printE(string.gsub(FRIENDLIST_LOCALE_NameExistsMsg,"%%n",name));
   end
   
   return exitCode;
end


--[[

Friendlist_editEntryOnAccept(boxes, oldName)

-- function for edit entry dialog after acccept click.

]]--
function Friendlist_editEntryOnAccept(boxes, oldName)
   FlagRSP.printDebug("edit ok clicked.");

   local exitCode = 1;

   oldName = FRIENDLISTStaticPopUpEditNameDummy:GetText();
   name = boxes[1][1]:GetText();
   notes = boxes[5][4]:GetText();
   surname = boxes[2][1]:GetText();
   title = boxes[3][1]:GetText();
   notes = boxes[5][4]:GetText();
   friendstate = Friendlist.dropDowns["FRIENDLISTStaticPopUpEditDropDown"].selectedValue;

   
   FlagRSP.printDebug("Editing " .. oldName .. " to " .. name .. " " .. surname .. ", title: " .. title .. " and notes: " .. notes .. ". Friendstate is: " .. friendstate);

   if name ~= nil and name ~= "" then
      if not Friendlist.isFriend(name) or oldName == name then
	 AddFRIEND(name, notes, surname, title, friendstate, friendData[realmName][playerName].FRIEND[oldName].type, oldName);
	 this:GetParent():Hide();
	 exitCode = 0;
      else
	 FlagRSP.printE(string.gsub(FRIENDLIST_LOCALE_NameExistsMsg,"%%n",name)); 
      end
   end
   
   return exitCode;
end


--[[

flagRSPCharPageMultilineEditBox_Update()

-- sets correct height for multiline edit boxes.

]]--
function flagRSPCharPageMultilineEditBox_Update()
   height = Friendlist.scrollFrames[this:GetName()].height;

   scrollFrame = getglobal(string.sub(this:GetName(),1,string.len(this:GetName())-17));
   dummyFrame = getglobal(string.sub(this:GetName(),1,string.len(this:GetName())-17) .. "DummyFrame");

   scrollFrame:SetHeight(height);
   this:SetHeight(height);
   dummyFrame:SetHeight(height);
end


--function FRIENDLISTStaticPopUpAddScrollFrameChildFrameEditBox_UpdateDescBox()
--   FRIENDLISTStaticPopUpAddScrollFrames_Update();
--end


------------------------------------------------------------------------------------------		
	
function FRIENDLISTStaticPopUpAdd_EditBoxOnEnterPressed()
	FRIENDLISTStaticPopUpAdd_OnClick(1);

	FRIENDLISTStaticPopUpAddEditBox1:SetText("");
	FRIENDLISTStaticPopUpAddEditBox2:SetText("");
	FRIENDLISTStaticPopUpAddEditBox3:SetText("");
	FRIENDLISTStaticPopUpAddEditBox1:SetFocus();
end

------------------------------------------------------------------------------------------		

function FRIENDLISTStaticPopUpAdd_EditBoxOnEscapePressed()
	FRIENDLISTStaticPopUpAdd_OnClick(2);
end


------------------------------------------------------------------------------------------
--======================================================================================--
-- STATIC POPUP GUILD -- STATIC POPUP GUILD -- STATIC POPUP GUILD -- STATIC POPUP GUILD -- 
--======================================================================================--
------------------------------------------------------------------------------------------	

function FRIENDLISTStaticPopUpAddGuild_OnHide()
	getglobal(this:GetName().."EditBox1"):SetText("");
end

------------------------------------------------------------------------------------------	

function FRIENDLISTStaticPopUpAddGuild_OnShow()
	if FRIENDLISTStaticPopUpAdd:IsVisible() then FRIENDLISTStaticPopUpAdd:Hide(); end
	if FRIENDLISTStaticPopUpEdit:IsVisible() then FRIENDLISTStaticPopUpEdit:Hide(); end
	if FRIENDLISTStaticPopUpAddNN:IsVisible() then FRIENDLISTStaticPopUpAddNN:Hide(); end
	
	getglobal(this:GetName().."EditBox1"):SetFocus();
	getglobal(this:GetName().."EditBox1"):Insert(GetGuildInfo("target"));
end
	
------------------------------------------------------------------------------------------		
	
function FRIENDLISTStaticPopUpAddGuild_EditBoxOnEnterPressed()
	FRIENDLISTStaticPopUpAddGuild_OnClick(1);

	FRIENDLISTStaticPopUpAddEditBox1:SetText("");
	FRIENDLISTStaticPopUpAddEditBox1:SetFocus();
end

------------------------------------------------------------------------------------------		

function FRIENDLISTStaticPopUpAddGuild_EditBoxOnEscapePressed()
	FRIENDLISTStaticPopUpAddGuild_OnClick(2);
end

------------------------------------------------------------------------------------------

function FRIENDLISTStaticPopUpAddGuild_OnClick(index)
	local guildName = nil;
	
		
	if (index == 1) then
		-- ADD button
		local editbox1 = getglobal(this:GetParent():GetName().."EditBox1");
		local checkbox = getglobal(this:GetParent():GetName().."FRIENDCheckButton");
				
		guildName = editbox1:GetText();

		if (checkbox:GetChecked() == 1) then 
			checked = true;
		else
			checked = false;
		end

		--Edit Boxes do not return nil when there is no text and "" won't catch it either
		if (editbox1:GetNumLetters() <= 0) then
			guildName = nil;
		end
		
		if ( (guildName ~= nil) and (guildName ~= "") ) then
				AddFRIEND(guildName, "Gilde", "");
			
			--Update friendly status based on checkbox value

			if (checked) then
				--Enemy flagged
				friendData[realmName][playerName].FRIEND[guildName].friendstate = -10;
			else
				friendData[realmName][playerName].FRIEND[guildName].friendstate = 10;
			end	
			
		end

		
		FRIENDLIST_Update();
		this:GetParent():Hide();
	elseif(index == 2) then
		-- CANCEL button
		this:GetParent():Hide();
	end
end

------------------------------------------------------------------------------------------
--======================================================================================--
-- STATIC POPUP EDIT -- STATIC POPUP EDIT -- STATIC POPUP EDIT -- STATIC POPUP EDIT -- 
--======================================================================================--
------------------------------------------------------------------------------------------	

function FRIENDLISTStaticPopUpEdit_OnHide()
	getglobal(this:GetName().."EditBox1"):SetText("");
	getglobal(this:GetName().."EditBox2"):SetText("");
	getglobal(this:GetName().."EditBox3"):SetText("");
end

------------------------------------------------------------------------------------------	

function FRIENDLISTStaticPopUpEdit_OnShow()
	if FRIENDLISTStaticPopUpAdd:IsVisible() then FRIENDLISTStaticPopUpAdd:Hide(); end
	if FRIENDLISTStaticPopUpAddGuild:IsVisible() then FRIENDLISTStaticPopUpAddGuild:Hide(); end
	if FRIENDLISTStaticPopUpAddNN:IsVisible() then FRIENDLISTStaticPopUpAddNN:Hide(); end
	
	local name, notes, class, guild, level, killCount, killedByCount, friendstate, nachname;
		
	if (FRIENDLISTFrame.selectedMember > 0) then
		name, notes, class, guild, level, killCount, killedByCount, friendstate, nachname = GetFRIENDInfo(FRIENDLISTFrame.selectedMember);

		getglobal(this:GetName().."EditBox1"):Insert(name);
		getglobal(this:GetName().."EditBox2"):Insert(nachname);
		getglobal(this:GetName().."EditBox3"):Insert(notes);

		
		if (friendstate <= -10) then
			--Enemy
			getglobal(this:GetName().."FRIENDCheckButton"):SetChecked(1);
		else
			getglobal(this:GetName().."FRIENDCheckButton"):SetChecked(0);
		end
		
		FRIENDLIST_Update();
	end
	
	--Set global
	originalName = name;
	originalNachname = nachname;
	originalNotes = notes;
	
	-- catch error
	if originalNachname == NIL then originalNachname = ""; end
	if originalNotes == NIL then originalNotes = ""; end
	
	--Can't edit Guild Field
	if (string.lower(originalNotes) == "gilde") then
		getglobal(this:GetName().."EditBox2"):Hide();
		getglobal(this:GetName().."EditBox3"):Hide();
		getglobal(this:GetName().."NachnameFont"):Hide();
		getglobal(this:GetName().."NotesFont"):Hide();
		getglobal(this:GetName().."FRIENDCheckButton"):Show();
	else
		getglobal(this:GetName().."EditBox2"):Show();
		getglobal(this:GetName().."EditBox3"):Show();
		getglobal(this:GetName().."NachnameFont"):Show();
		getglobal(this:GetName().."NotesFont"):Show();
		getglobal(this:GetName().."FRIENDCheckButton"):Show();
	end
	getglobal(this:GetName().."EditBox1"):SetFocus();
end
	
------------------------------------------------------------------------------------------		
	
function FRIENDLISTStaticPopUpEdit_EditBoxOnEnterPressed()
	FRIENDLISTStaticPopUpEdit_OnClick(1);

	FRIENDLISTStaticPopUpEditEditBox1:SetText("");
	FRIENDLISTStaticPopUpEditEditBox1:SetFocus();
end

------------------------------------------------------------------------------------------		

function FRIENDLISTStaticPopUpEdit_EditBoxOnEscapePressed()
	FRIENDLISTStaticPopUpEdit_OnClick(2);
end

------------------------------------------------------------------------------------------

function FRIENDLISTStaticPopUpEdit_OnClick(index)
	local updatedName = nil;
	local updatedNachname = nil;
	local updatedNotes = nil;
	local updatedfriendstate = nil;
	
	if (index == 1) then
		-- Update button
		local editbox1 = getglobal(this:GetParent():GetName().."EditBox1");
		local editbox2 = getglobal(this:GetParent():GetName().."EditBox2");
		local editbox3 = getglobal(this:GetParent():GetName().."EditBox3");
		local checkbox = getglobal(this:GetParent():GetName().."FRIENDCheckButton");
		
		updatedName = editbox1:GetText();
		updatedNachname = editbox2:GetText();
		updatedNotes = editbox3:GetText();
		if (checkbox:GetChecked() == 1) then 
			--Checked means its an enemy
			updatedfriendstate = -10;
		else
			updatedfriendstate = 10;
		end
		
		--Edit Boxes do not return nil when there is no text and "" won't catch it either
		if (editbox1:GetNumLetters() <= 0) then
			updatedName = nil;
		end
		
		if (editbox2:GetNumLetters() <= 0) then
			updatedNachname = "";
		end
		
		if (editbox3:GetNumLetters() <= 0) then
			updatedNotes = "";
		end
		
		if ( (updatedName ~= nil) or (updatedName ~= "") ) then
			EditFRIEND(originalName, updatedName, updatedNotes, updatedfriendstate, updatedNachname);
		end
		FRIENDLIST_Update();
		this:GetParent():Hide();
	elseif(index == 2) then
		-- CANCEL button
		this:GetParent():Hide();
	end
end

------------------------------------------------------------------------------------------	

function EditFRIEND(origName, newName, newNotes, updatedfriendstate, updatedNachname)

   if ( (newName == nil) or (newName == "") ) then return; end
   local old = {};
   old = friendData[realmName][playerName].FRIEND[origName];
   -- ???
   if ( (old == nil) or (old == "") ) then return; end
   --
   old.notes = newNotes;
   old.friendstate = updatedfriendstate;
   old.surname = updatedNachname
   
   --Check that new name isn't a separate entry in the list already
   for key, value in friendData[realmName][playerName].FRIEND do
      --If the two names in the table match and they're NOT the same index, can't be allowed
      if ( (newName == key) and 
	  (friendData[realmName][playerName].FRIEND[origName]["index"] ~= friendData[realmName][playerName].FRIEND[key]["index"]) ) then
	 FlagRSP.printE(string.gsub(FRIENDLIST_LOCALE_NameExistsMsg,"%%n",newName));
	 return;
      end
   end
   
   if (friendData[realmName][playerName].FRIEND[newName] ~= nil) then
      --Name didnt change, maybe attributes did
      friendData[realmName][playerName].FRIEND[newName] = old;
   else
      friendData[realmName][playerName].FRIEND[newName] = {};
      friendData[realmName][playerName].FRIEND[newName] = old;
      friendData[realmName][playerName].FRIEND[origName] = nil;
   end
   FRIENDLIST_Update();
end

------------------------------------------------------------------------------------------
--======================================================================================--
-- STATIC POPUP ADD -- STATIC POPUP ADD -- LASTNAME & TITLES FOR YOU CHARACTER          -- 
--======================================================================================--
------------------------------------------------------------------------------------------

function FRIENDLISTStaticPopUpAddNN_OnClick(index)
   local name = nil;
   local noteString = nil;
   
   if (index == 1) then
      -- ADD button
      local editbox1 = getglobal(this:GetParent():GetName().."EditBox1");
      local editbox2 = getglobal(this:GetParent():GetName().."EditBox2");
      
      name = editbox1:GetText();
      noteString = editbox2:GetText();
      
      --Edit Boxes do not return nil when there is no text
      if (editbox1:GetNumLetters() <= 0) then
	 name = "";
      end
      if (editbox2:GetNumLetters() <= 0) then
	 noteString = "";
      end
      
      
      --if ( (name ~= nil) and (name ~= "") ) then
	-- if (noteString == "") then 
	  --  xTP_CustomTag[UnitName("player")] = name;				
	    
	    --DEFAULT_CHAT_FRAME:AddMessage("Von diesem Tage an seid ihr bekannt als " ..UnitName("player").. " " ..xTP_CustomTag[UnitName("player")]);
	    
	 --else
	   -- xTP_CustomTag[UnitName("player")] = name;
	   -- xTP_CustomTag2[UnitName("player")] = noteString;
	    
	    --DEFAULT_CHAT_FRAME:AddMessage("Von diesem Tage an seid ihr bekannt als " ..UnitName("player").. " " ..xTP_CustomTag[UnitName("player")].. ", " ..xTP_CustomTag2[UnitName("player")]);		
	    
	    
	 --end
      --end

      FlagRSP.setSurname(name);
      FlagRSP.setTitle(noteString);
      
      FRIENDLIST_Update();
      this:GetParent():Hide();
      
      elseif(index == 2) then
      -- CANCEL button
      this:GetParent():Hide();
   end
end

------------------------------------------------------------------------------------------	

function FRIENDLISTStaticPopUpAddNN_OnHide()
	getglobal(this:GetName().."EditBox1"):SetText("");
	getglobal(this:GetName().."EditBox2"):SetText("");
end

------------------------------------------------------------------------------------------	

function FRIENDLISTStaticPopUpAddNN_OnShow()
	if FRIENDLISTStaticPopUpAddGuild:IsVisible() then FRIENDLISTStaticPopUpAddGuild:Hide(); end
	if FRIENDLISTStaticPopUpEdit:IsVisible() then FRIENDLISTStaticPopUpEdit:Hide(); end
	if FRIENDLISTStaticPopUpAdd:IsVisible() then FRIENDLISTStaticPopUpAdd:Hide(); end
	--UIErrorsFrame:AddMessage("Spielt ihr ein Rollenspiel, so w\195\164hlt weise.", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);

	getglobal(this:GetName().."EditBox1"):Insert(FlagRSP.getOwnSurname());
	getglobal(this:GetName().."EditBox2"):Insert(FlagRSP.getOwnTitle());
	getglobal(this:GetName().."EditBox1"):SetFocus();
end
	
------------------------------------------------------------------------------------------		
	
function FRIENDLISTStaticPopUpAddNN_EditBoxOnEnterPressed()
	FRIENDLISTStaticPopUpAddNN_OnClick(1);

	FRIENDLISTStaticPopUpAddNNEditBox1:SetText("");
	FRIENDLISTStaticPopUpAddNNEditBox2:SetText("");
	FRIENDLISTStaticPopUpAddNNEditBox1:SetFocus();
end

------------------------------------------------------------------------------------------		

function FRIENDLISTStaticPopUpAddNN_EditBoxOnEscapePressed()
   FRIENDLISTStaticPopUpAddNN_OnClick(2);
end


--[[

Friendlist_TabHandler(id)

- Handler to change pages on Friendlist.

]]--
function Friendlist_TabHandler(id)
   if id == nil then
      id = this:GetID();
   end

   FlagRSP.printDebug("id is: " .. id);
  
   local tab;
   if Friendlist.tabs[Friendlist.currentTab][3] ~= "" then
      tab = getglobal(Friendlist.tabs[Friendlist.currentTab][3]);
      x = tab:GetLeft();
      y = tab:GetTop();
   end

   Friendlist.currentTab = id;
   Friendlist.updateTabs(x,y);
end


--[[

Friendlist_PageHandler(id)

- Handler to turn over pages on Friendlist sub frames.

]]--
function Friendlist_PageHandler(id)
   FlagRSP.printDebug("id is: " .. id)

   if Friendlist.pageButtons[id] ~= nil then
      FlagRSP.printDebug("Type is: " .. Friendlist.pageButtons[id].type);
      FlagRSP.printDebug("ActivePage is: " .. Friendlist.pageButtons[id].activePage);
      FlagRSP.printDebug("Page1 is: " .. Friendlist.pageButtons[id].pages[1]);
      FlagRSP.printDebug("Page2 is: " .. Friendlist.pageButtons[id].pages[2]);

      local numPages = table.getn(Friendlist.pageButtons[id].pages);
      local activePage = Friendlist.pageButtons[id].activePage;

      if activePage < numPages and (Friendlist.pageButtons[id].type == "turn" or Friendlist.pageButtons[id].type == "turnup") then
	 activePage = activePage + 1;
      elseif activePage == numPages and Friendlist.pageButtons[id].type == "turn" then
	 activePage = 1;
      elseif activePage > 1 and Friendlist.pageButtons[id].type == "turndown" then
	 activePage = activePage - 1;
      end

      Friendlist.pageButtons[id].activePage = activePage;

      FlagRSP.printDebug("New page is: " .. activePage);

      Friendlist.updatePages(id);

   end
end


--[[

Friendlist.updatePages(id)

-- Updates the subframe pages for page handler (i.e. button) id

]]--
function Friendlist.updatePages(id)
   if Friendlist.pageButtons[id] ~= nil then
      local numPages = table.getn(Friendlist.pageButtons[id].pages);
      local activePage = Friendlist.pageButtons[id].activePage;
      local page;
      
      for i=1, numPages do
	 page = getglobal(Friendlist.pageButtons[id].pages[i]);
	 if i == activePage then
	    page:Show();
	 else
	    page:Hide();
	 end
      end
   end
end


--[[

FriendlistMetaFrame_OnUpdate()

-- Update function for Metaframe. Checks if window should be hidden (after Escape e.g.)

]]--
function FriendlistMetaFrame_OnUpdate()
   local anythingVisible = false;
   local tab, tabbutton;

   for i=1, table.getn(Friendlist.tabs) do
      tab = getglobal(Friendlist.tabs[i][3]);
      if tab:IsVisible() then 
	 anythingVisible = true;
      end
   end
   
   --FlagRSP.printDebug("Updating FL!");

   if not anythingVisible then
      FRIENDLIST_ToggleGUI();
   end
end


--[[

Friendlist.updateTabs()

- Updates the tab buttons (sets checked, ...).

]]--
function Friendlist.updateTabs(x,y)
   --currentTab = 1;
   --Friendlist.currentTab
   
   local tabbutton;
   local tab;
   --local x=0;
   --local y=0;

   if Friendlist.tabs[Friendlist.currentTab] == nil then
      Friendlist.currentTab = 1;
   end

   if x == nil or y == nil then
      if Friendlist.tabs[Friendlist.currentTab][3] ~= "" then
	 tab = getglobal(Friendlist.tabs[Friendlist.currentTab][3]);
	 x = tab:GetLeft();
	 y = tab:GetTop();
      end
   end
   
   FlagRSP.printDebug(x);
   FlagRSP.printDebug(y);

   --x=400;
   --y=400;


   --for i=1, 4 do
   --   tabbutton = getglobal("Friendlist_PageTab" .. i);
   --end


   for i=1, table.getn(Friendlist.tabs) do
      tabbutton = getglobal("Friendlist_PageTab" .. i);
      
      tabbutton:SetNormalTexture(Friendlist.tabs[i][2]);
      
      tabbutton:SetWidth(32);
      tabbutton:SetHeight(32);
      
      if i == Friendlist.currentTab then 
	 tabbutton:SetChecked(1);
	 if Friendlist.tabs[i][3] ~= "" then
	    if i == 1 then
	       Friendlist_PageTab1:SetPoint("TOPLEFT", Friendlist.tabs[i][3], "TOPRIGHT", -33, -65);
	    else
	       Friendlist_PageTab1:SetPoint("TOPLEFT", Friendlist.tabs[i][3], "TOPRIGHT", -31, -65);
	    end

	    tab = getglobal(Friendlist.tabs[i][3]);

	    --FlagRSP.printDebug("Active tab is: " .. Friendlist.tabs[i][3] .. ", width: " .. tab:GetWidth());

	    tab:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);

	    --UIPanelWindows[tab:GetName()] = { area = "left", pushable = 0 };
	    UIPanelWindows[tab:GetName()] = nil;
	    
	    --tab:Show();
	    ShowUIPanel(tab);
	 end
      else
	 tabbutton:SetChecked(0);
	 if Friendlist.tabs[i][3] ~= "" then
	    tab = getglobal(Friendlist.tabs[i][3]);

	    --FlagRSP.printDebug("Unactive tab is: " .. Friendlist.tabs[i][3] .. ", width: " .. tab:GetWidth());

	    tab:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);

	    tab:Hide();
	 end
      end
      
      tabbutton:SetScale(1);
      
      tabbutton:Show();
   end
end


--[[

Friendlist_DropDownHandler(id)

-- Handler to initialize drop down boxes.

]]--
function Friendlist_DropDownHandler(id)
   --   dropDowns = {
   --   FriendlistCharFrameRPDropDown = {initialize=FriendlistCharFrameRPDropDown_Initialize},
   --};

   if FlagRSP ~= nil and Friendlist ~= nil then
      
      --FlagRSP.printDebug("DROPDOWNHANDLER id: " .. id);
      --FlagRSP.printDebug("DROPDOWNHANDLER init: " .. Friendlist.dropDowns[id]["initialize"]);
      --check = getglobal(Friendlist.dropDowns[id].initialize);
      --check();
      

      if Friendlist.dropDowns[id] ~= nil then
	 UIDropDownMenu_Initialize(getglobal(id), getglobal(Friendlist.dropDowns[id].initialize));
	 UIDropDownMenu_SetText(Friendlist.dropDowns[id].selectedText, getglobal(id));
	 UIDropDownMenu_SetWidth(Friendlist.dropDowns[id].width, getglobal(id));
      end
   end
end


--[[

Friendlist_DropDownInitializer()

-- Function to initialize drop down box and buttons.

]]--
function Friendlist_DropDownInitializer(dropDown)
   id = this:GetName();

   if dropDown ~= nil and getglobal(dropDown) ~= nil then
      --FlagRSP.printDebug("our id is: " .. dropDown);
      id = dropDown;
   end

   --FlagRSP.printDebug("we are initializing dropdown box: " .. id);

   if Friendlist.dropDowns[id] == nil and string.sub(id, string.len(id)-5, string.len(id)) == "Button" then
      --FlagRSP.printDebug("...but we get a button.");
      id = string.sub(id, 1, string.len(id)-6);
      --FlagRSP.printDebug("we are now initializing dropdown box: " .. id);
   end

   UIDropDownMenu_SetText(Friendlist.dropDowns[id].selectedText, getglobal(id));
   
   local info ={};
   local btab;

   for i=1, table.getn(Friendlist.dropDowns[id].buttons) do
      btab = Friendlist.dropDowns[id].buttons[i];
      --FlagRSP.printDebug("we are now adding button: " .. btab.text);
      info = {};
      info.text = btab.text;
      info.value = btab.value;
      info.checked = btab.checked;
      info.func = Friendlist_DropDownClicked;

      UIDropDownMenu_AddButton(info);
   end
end


--[[

Friendlist_DropDownClicked()

-- Function to handle clicked drop down elements.

]]--
function Friendlist_DropDownClicked()
   --id = this:GetParent():GetName();

   --FlagRSP.printDebug("clicked box: " .. id);

   --posxx = string.find(id, "Button..$");
   --posx = string.find(id, "Button.$");

   --if posxx ~= nil then
      --FlagRSP.printDebug("xx: " .. posxx);
      --id = string.sub(id,1,posxx-1);
   --elseif posx ~= nil then
      --FlagRSP.printDebug("x: " .. posx);
      --id = string.sub(id,1,posx-1);
   --end

   --FlagRSP.printDebug("clicked box: " .. id);
  
   FlagRSP.printDebug("Open Menu: " .. UIDROPDOWNMENU_OPEN_MENU);

   id = UIDROPDOWNMENU_OPEN_MENU;

   Friendlist_DropDownSetValue(id, this.value);

   UIDropDownMenu_SetText(Friendlist.dropDowns[id].selectedText, getglobal(id));

   -- instantly save option?
   if Friendlist.dropDowns[id].instantSave ~= nil and Friendlist.dropDowns[id].instantSave then
      FlagRSP.printDebug("saving option instantly.");
      Friendlist.dropDownWrite(id);
   end
end


--[[

Friendlist.dropDownRead(id)

-- Function to read out settings for a drop down box id.

]]--
function Friendlist.dropDownRead(id)
   local func = getglobal(Friendlist.dropDowns[id].readFunction);

   if func ~= nil then
      --FlagRSP.printDebug("read out: " .. Friendlist.dropDowns[id].readFunction);
      
      Friendlist_DropDownSetValue(id,func());
   else
      --FlagRSP.printDebug("read out: " .. Friendlist.dropDowns[id].readFunction .. " but it is nil.");
   end

   UIDropDownMenu_SetText(Friendlist.dropDowns[id].selectedText, getglobal(id));
end


--[[

Friendlist.dropDownWrite(id)

-- Function to write settings for a drop down box id.

]]--
function Friendlist.dropDownWrite(id)
   local func = getglobal(Friendlist.dropDowns[id].writeFunction);
   local changed = false;

   if func ~= nil then
      --FlagRSP.printDebug("write out: " .. Friendlist.dropDowns[id].readFunction .. " with argument: " .. Friendlist.dropDowns[id].selectedValue);
      
      changed = func(Friendlist.dropDowns[id].selectedValue);
   else
      --FlagRSP.printDebug("write out: " .. Friendlist.dropDowns[id].readFunction .. " but it is nil.");
   end

   return changed;
end


--[[

Friendlist_DropDownSetValue(id, value)

-- Function to set a selected value for a drop down box id.

]]--
function Friendlist_DropDownSetValue(id, value)
   local btab;
   
   for i=1, table.getn(Friendlist.dropDowns[id].buttons) do
      btab = Friendlist.dropDowns[id].buttons[i];
      
      if btab.value == value then
	 btab.checked = true;
	 Friendlist.dropDowns[id].selectedValue = value;
	 Friendlist.dropDowns[id].selectedText = btab.text;
      else
	 btab.checked = false;
      end
   end   
end


--[[
function FriendlistCharFrameRPDropDown_Initialize()
   FlagRSP.print("TADAA: " .. this:GetName());

   local info = {};
   info.text = "Test1";
   info.value = "t1";
   info.checked = true;
   info.func = TestBD;

   UIDropDownMenu_AddButton(info);

   info.text = "Test2";
   info.value = "t2";
   info.checked = false;
   info.func = TestBD;
   UIDropDownMenu_AddButton(info);
end

function FriendlistCharFrameCSDropDown_Initialize()
   FlagRSP.print("TADAA: " .. this:GetName());
end


function TestBD()
   FlagRSP.printDebug("Hello: " .. this:GetName());
   FlagRSP.printDebug("Hello: " .. this.value);
end
]]--


--[[

Friendlist.editBoxTabHandler(name, shift)

-- Function to handle tab events in edit boxes.

]]--
function Friendlist.editBoxTabHandler(name, shift)
   if shift then
      box = getglobal(Friendlist.editBoxes[name][1]);
      if box:IsVisible() then
	 box:SetFocus();
      else
	 FlagRSP.printDebug("problem, not visible.");
	 Friendlist.editBoxTabHandler(box:GetName(), shift);
      end
   else
      box = getglobal(Friendlist.editBoxes[name][2]);
      if box:IsVisible() then
	 box:SetFocus();
      else
	 FlagRSP.printDebug("problem, not visible.");
	 Friendlist.editBoxTabHandler(box:GetName(), shift);
      end
   end
end

function Friendlist_GameMenuAddButton( button )
   
   if 1==0 then
      if( GameMenu_InsertAfter == nil ) then
	 GameMenu_InsertAfter = GameMenuButtonMacros;
      end
      if( GameMenu_InsertBefore == nil ) then
	 GameMenu_InsertBefore = GameMenuButtonLogout;
      end
      
      button:ClearAllPoints();
      button:SetPoint( "TOP", GameMenu_InsertAfter:GetName(), "BOTTOM", 0, -1 );
      GameMenu_InsertBefore:SetPoint( "TOP", button:GetName(), "BOTTOM", 0, -1 );
      GameMenu_InsertAfter = button;
      GameMenuFrame:SetHeight( GameMenuFrame:GetHeight() + button:GetHeight() + 2 );
   end
end

--[[

Mapping functions

-- Mapping function to read/write settings for config UI.

]]--
function DropDown_getRPFlag()
   return FlagRSP.getRPFlag();
end

function DropDown_setRPFlag(val)
   return FlagRSP.setRPFlag(val);
end

function DropDown_getCStatus()
   return FlagRSP.getCharStatus();
end

function DropDown_setCStatus(val)
   return FlagRSP.setCharStatus(val);
end

function DropDown_getSortSettings()
   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].FriendlistSortOrder;
end

function DropDown_setSortSettings(val)
   local changed = false;

   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].FriendlistSortOrder ~= val then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].FriendlistSortOrder = val;
      changed = true;
   end

   return changed;
end