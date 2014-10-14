--[[
This mod is a rewrite of RPPolice found at: http://www.curse-gaming.com/en/wow/addons-4580-rppolice.html
by Smellyfeet, Steamwheedle Cartel (EU) - Horde
]]--

Ticket = { }; -- The ticket.

-------------------------------------------------------------------------------------------
-- OnLoad function to load the slash commands and to definde the entry in the UnitPopup.
-------------------------------------------------------------------------------------------
function GoldSpammer_OnLoad()
  SlashCmdList["GoldSpammerCOMMAND"] = GoldSpammer_SlashHandler;
  SLASH_GoldSpammerCOMMAND1 = "/gs";
  -- add to the UnitPopup
  UnitPopupButtons["GOLDSPAMMER"] = { text = "GoldSpammer", dist = 0 }
  UnitPopupButtons["ISBOT"] = { text = "isBot", dist = 0 }
  table.insert(UnitPopupMenus["PLAYER"], 8, "GOLDSPAMMER");
  table.insert(UnitPopupMenus["FRIEND"], 4, "GOLDSPAMMER");
  table.insert(UnitPopupMenus["PLAYER"], 9, "ISBOT");
  table.insert(UnitPopupMenus["FRIEND"], 5, "ISBOT");
  pre_GoldSpammer_UnitPopup_OnClick = UnitPopup_OnClick;
  UnitPopup_OnClick = GoldSpammer_UnitPopup_OnClick;
end

-------------------------------------------------------------------------------------------
-- The SlashHandler to call the corresponding functions.
-------------------------------------------------------------------------------------------
function GoldSpammer_SlashHandler(arg1)
  if(arg1 == "clear") then
    GoldSpammer_Clearlist();
  end
end

-------------------------------------------------------------------------------------------
-- Adds the name to the spam/bot list
-------------------------------------------------------------------------------------------
function GoldSpammer_AddName(arg1, arg2)
  local zonetext = GetZoneText();
  local hour,minute = GetGameTime();
  if(hour<10) then
    hour = "0"..hour;
  end
  if(minute<10) then
    minute = "0"..minute;
  end

  if(arg1 == "bot") then
    TicketText = "Today at "..hour..":"..minute..", I observed "..arg2.." in "..zonetext..", who seemed to be using 3rd party programs to control his character\n";
    table.insert(Ticket, TicketText);
    -- DEFAULT_CHAT_FRAME:AddMessage("arg1: "..arg1);
    -- DEFAULT_CHAT_FRAME:AddMessage("arg2: "..arg2);
  elseif(arg1 == "spam") then
       TicketText = "Today at "..hour..":"..minute..", "..arg2.." was advertising websites where ingame gold can be bought\n";
       table.insert(Ticket, TicketText);
       AddIgnore(arg2);
      -- DEFAULT_CHAT_FRAME:AddMessage("arg1: "..arg1);
      -- DEFAULT_CHAT_FRAME:AddMessage("arg2: "..arg2);
    end
end
-------------------------------------------------------------------------------------------
-- Flush the names, assuming your ticket has been answered
-------------------------------------------------------------------------------------------
function GoldSpammer_Clearlist(arg1)
  for index = 1, table.getn(Ticket) do
    table.remove(Ticket);
  end
end


-------------------------------------------------------------------------------------------
-- Open the Ticket that for the given player that is a slimy goldseller :P.
-------------------------------------------------------------------------------------------
function GoldSpammer_OpenTicket(tickettype, player)
  if not ( HelpFrameOpenTicket.hasTicket ) then
    -- Clearing the list as we assume the other names has been registred by the GM
    GoldSpammer_Clearlist();
    -- insert the new name and open the ticket
    GoldSpammer_AddName(tickettype, player);
    NewGMTicket(2, GoldSpammer_MakeText());
  else
    GoldSpammer_AddName(tickettype, player);
    UpdateGMTicket(2, GoldSpammer_MakeText());
  end
end

-------------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------------
function GoldSpammer_ListTicket()
  for index,values in Ticket do
      DEFAULT_CHAT_FRAME:AddMessage(values.."\n");
  end
end

-------------------------------------------------------------------------------------------
-- Make the Tickettext
-------------------------------------------------------------------------------------------
function GoldSpammer_MakeText(arg1)
  local text = "";
  for index,values in Ticket do
    text = text .."\n" .. values;
  end
  return text;
end

-------------------------------------------------------------------------------------------
-- Check if this click on the UnitPopup is handled here and to the needed things.
-------------------------------------------------------------------------------------------
function GoldSpammer_UnitPopup_OnClick()
  local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
  local button = this.value;
  local unit = dropdownFrame.unit;
  local name = dropdownFrame.name;

  -- When it is the button we want to check
  if button == "GOLDSPAMMER" then
    -- Let's check if there is a name or a unit. If it is the unit, get the name.
    if ( unit and not name) then
      name = UnitName(unit);
    end
    -- And then lets open the ticket.
    GoldSpammer_OpenTicket("spam", name);
  elseif button == "ISBOT" then
    -- Let's check if there is a name or a unit. If it is the unit, get the name.
    if ( unit and not name) then
      name = UnitName(unit);
    end
    -- And then lets open the ticket.
    GoldSpammer_OpenTicket("bot", name);
  else
    pre_GoldSpammer_UnitPopup_OnClick();
  end
end