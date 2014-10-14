-- RABuffs_ui.lua
--  Handles command line user interaction and addon-to-addon / addon-to-people communications.
-- Version 0.10.1

RAB_Sync_HideMasks = 	{
				"^<RAB> Version",
				"^<RAB> Requesting ",
			};

RAB_Versions = {}; -- [Realm.Name] = {name=Name,v=display,d=compare,l=lastseen}.
RAB_VersionTime = 0;

RAB_Chat_Colors = {
	Hunter ="|cffaad372",
	Warrior="|cffc69b6d",
	Rogue  ="|cfffff468",
	Mage   ="|cff68ccef",
	Priest ="|cffffffff",
	Warlock="|cff9382c9",
	Druid  ="|cffff7c0a",
	Shaman ="|cfff48cba",
	Paladin="|cfff48cba"};

StaticPopupDialogs["RAB_MSG"] = {
	button1 = TEXT(OKAY),
	whileDead = 1,
	timeout = 0,
	hideOnEscape = 1
};

function RAB_Print(text,type)
 local r,g,b = 0.3,0.5, 1;
 if (type == "warn") then r,g,b = 1,0.8,0; end
 if (type == "ok") then r,g,b = 0,0.7,0; end
 DEFAULT_CHAT_FRAME:AddMessage(text,r,g,b);
end

function RAB_Loaded()
 local key, val, key2, val2, ar;
 if (RABui_Settings.lastVersion ~= nil and RABui_Settings.lastVersion ~= RABuffs_Version) then
  RAB_LoadShow = "changelog";
  RAB_Print(string.format(sRAB_UpdateComplete,RABui_Settings.lastVersion,RABuffs_Version, RABuffs_Version));
  RABui_Settings.lastVersion = RABuffs_Version;
 elseif (RABui_Settings.firstRun == true) then
  RAB_LoadShow = "welcome";
  RABui_Settings.firstRun = false;
 end
 if (RABui_Settings.newestVersion == "fresh" or RABui_Settings.newestVersion < RABuffs_DeciVersion) then
  RABui_Settings.newestVersion = RABuffs_DeciVersion;
  RABui_Settings.newestVersionTitle = RABuffs_Version;
  RABui_Settings.newestVersionPlayer = UnitName("player");
  RABui_Settings.newestVersionRealm = GetCVar("realmName");
 end
 
 local cltemp = sRAB_Localization_UI  .. " / " .. sRAB_Localization_Output .. " / " .. sRAB_Localization_SpellLayer;

 if (RABui_Settings.newestVersion ~= nil and RABui_Settings.newestVersion > RABuffs_DeciVersion) then
  RAB_Print(string.format(sRAB_OutOfDate,RABui_Settings.newestVersionTitle,RABui_Settings.newestVersionPlayer,RABui_Settings.newestVersionRealm),"warn");
  RAB_Print(sRAB_DownloadLink,"warn");
  StaticPopupDialogs["RAB_MSG"].text = string.format(sRAB_OutOfDate_Box, RABui_Settings.newestVersionTitle);
  RAB_LoadShow = "versionwarn";
  sRAB_Settings_Version = string.format(sRAB_Settings_Version,RED_FONT_COLOR_CODE .. RABuffs_Version .. "|r"  .. string.format(sRAB_Settings_VersionOutdated,RABui_Settings.newestVersionTitle,RABui_Settings.newestVersionPlayer,RABui_Settings.newestVersionRealm),cltemp,GetLocale());
 else
  sRAB_Settings_Version = string.format(sRAB_Settings_Version,GREEN_FONT_COLOR_CODE .. RABuffs_Version .. "|r" .. sRAB_Settings_VersionNewest,cltemp,GetLocale());
 end
end

SLASH_RABUFFSQ1 = "/rq";
SLASH_RABUFFSQ2 = "/rabq";
SlashCmdList["RABUFFSQ"] = function(msg)
 msg = strlower(msg);
 RAB_Lock = 0;
 if (msg == "help" or msg == "") then
  local key, val;
  for key, val in sRAB_Slash_QHelp do
   RAB_Print(val);
  end
  return;
 end

 local target = "CONSOLE";
 if (strsub(msg,1,4) == "raid") then
  target = "RAID";
  msg = strsub(msg,6);
 elseif (strsub(msg,1,5) == "party") then
  target = "PARTY";
  msg = strsub(msg,7);
 elseif (strsub(msg,1,7) == "officer") then
  target = "OFFICER";
  msg = strsub(msg,9);
 elseif (string.find(msg,"w (%a+) (.+)") ~= nil) then
  _, _, target, msg =  string.find(msg,"w (%a+) (.+)");
 elseif (string.find(msg,"c (%w+) (.+)") ~= nil) then
  _, _, target, msg =  string.find(msg,"c (%w+) (.+)");
  target = "CHANNEL:" .. target;
 end

 local invert = (string.find(msg,"not (.+)") ~= nil);
 if (invert) then
  _, _, msg = string.find(msg,"not (.+)");
 end

 if (string.find(msg,"^(%a+) ?([1-8]*) ?([mlprdhswa]*)$") ~= nil) then
  RAB_BuffCheckOutput(msg,target,invert);
 else
  RAB_Print(sRAB_Slash_UnrecognizedQuery,"warn");
 end
end
SLASHHELP_RABUFFSQ = function (text)
 if (RABui_Settings.syntaxhelp == false) then
  return; -- Disabled this.
 end

 local key, val, i, pref;

 text = strlower(text);
 text = strsub(text,strlen("/rabq ")+1); -- just the params
 _, _, pref = string.find(text,"^(%a+) "); 

 if (pref ~= nil) then
  pref = strlower(pref);
  if (pref == "raid" or pref == "party" or pref == "officer") then
   text = strsub(text,strlen(pref) +2);
  elseif (pref == "w" or pref == "c") then
   _, _, val = string.find(text,"^" .. pref .. " (%w+) ");
   if (val == nil) then
    RAB_SSH_QueryO("target"); return;
   else
    text = strsub(text,strlen(pref) + strlen(val) + 3);
   end
  end

  if (string.find(text,"^(%a+) ")) then
   _, _, pref = string.find(text,"(%a+) ");
   if (pref == "not") then
    text = strsub(text,strlen(pref) + 2);
    _, _, pref = string.find(text,"(%a+) ");  
   end
   if (pref == nil) then
    RAB_SSH_QueryO("buffquery"); return;
   elseif (RAB_Buffs[pref] == nil) then
    RAB_SSH_QueryO("buffqueryinvalid");
    return;
   else
    text = strsub(text,strlen(pref) + 2);
    local _, _, lg, lc = string.find(text,"(%d*)( ?%a*)");
    if (lg == nil or (lg == "" and lc == "")) then
     RAB_SSH_QueryO("limits"); 
    elseif (lc == "") then
     RAB_SSH_QueryO("limitg"); 
    else
     RAB_SSH_QueryO("limitc"); 
    end
    return true;
   end
  else
   RAB_SSH_QueryO("buffquery"); return true;
  end
 else
  RAB_SSH_QueryO("target");
 end
 return true;
end
function RAB_SSH_QueryO(item)
 local key, val, spaceprefix = 0,0,"";
 if (sRAB_Slash_QSyntaxHelp[item] ~= nil) then
  for key, val in sRAB_Slash_QSyntaxHelp[item] do
   if (key == 1 and  string.find(val,"(%b-+)") ~= nil) then -- title, must have a green part to align stuff after
    local _,_, highlight = string.find(val,"(%b-+)");
    spaceprefix = "         ";
   elseif (string.find(val,"(%b_=)") ~= nil and spaceprefix ~= "") then
    local _,_, highlight = string.find(val,"(%b_=)");
    val = string.gsub(val,"^(%b_=)","_" .. spaceprefix .. strsub(highlight,2,-2) .. "=");
   end
   SlashHelp_AddLine(RABui_SSH_Color(val));
  end
 else
  SlashHelp_AddLine("[qo error: missing '" .. item .. "']")
 end
 return true;
end

SLASH_RABUFFS1 = "/rab";
SLASH_RABUFFS2 = "/rabuffs";
SlashCmdList["RABUFFS"] = function(msg)
 local target = "";
 local out = "";
 local obuff = "";

 local _, _, cmd, param = string.find(msg,"(%a+) (.+)");
 if (cmd == nil) then
  cmd = msg;
 end

 if (msg == "") then
  for key, val in sRAB_Slash_Help do
   RAB_Print (val);
  end
 elseif (cmd == "show") then
  RABui_UpdateBars();
  RABFrame:Show();
 elseif (cmd == "hide") then
  RABFrame:Hide();
  RAB_Print(sRAB_Menu_HiddenWindow);
 elseif (cmd == "versioncheck") then
  if (param == "") then
   param = nil;
  end
  if (param == "guild") then
   RAB_Print(sRAB_VersionCheck_BeginGuild);
   RAB_VersionCheck_RequestsExpire = time()+10;
   RAB_SendMessage(RAB_RequestingVersion,"GUILD");
  elseif (UnitInRaid("player") and (param == nil or param == "raid")) then
   RAB_Print(sRAB_VersionCheck_BeginRaid);
   RAB_VersionCheck_RequestsExpire = time()+10;
   RAB_SendMessage(RAB_RequestingVersion,"RAID");
  elseif (GetNumPartyMembers()>0 and (param == nil or param == "party")) then
   RAB_Print(sRAB_VersionCheck_BeginParty);
   RAB_VersionCheck_RequestsExpire = time()+10;
   RAB_SendMessage(RAB_RequestingVersion,"PARTY");
  elseif (param ~= nil and param ~= "party" and param ~= "raid") then
   RAB_Print(string.format(sRAB_VersionCheck_BeginWhisper,param));
   RAB_VersionCheck_RequestsExpire = time()+10;
   RAB_SendMessage(RAB_RequestingVersion, "WHISPER:" .. param);
  else
   RAB_Print(sRAB_VersionCheck_NotInGroup,"warn");
  end
 elseif (cmd == "hookchat") then
  if (RAB_RealChatFrame_OnEvent == nil) then
   RAB_RealChatFrame_OnEvent = ChatFrame_OnEvent;
   ChatFrame_OnEvent = RAB_ChatFrame_OnEvent;
  else
   ChatFrame_OnEvent = RAB_RealChatFrame_OnEvent;
   RAB_RealChatFrame_OnEvent = nil;
  end
  RAB_Print("[RABuffs] " .. ((RAB_RealChatFrame_OnEvent == nil) and "Unhooked" or "Hooked") .. " chatframe events.");
 elseif (string.find(cmd,"^regtest") ~= nil) then
  RAB_Print("[RABuffs] Performing query test.");
  local pass, fail, m = 0,0, gcinfo();
  for key, val in RAB_Buffs do 
   ok, res = pcall(RAB_CallRaidBuffCheck,key,false,false);
   if (not ok) then
    RAB_Print("[RABuffs] " .. key .. " failed: " .. tostring(res),"warn");
    fail = fail + 1;
   else
    local m2 = gcinfo();
    for i=1,100 do
     RAB_CallRaidBuffCheck(key,false,false);
    end
    pass = pass + 1;
    if (gcinfo()-m2 > 0) then
     RAB_Print("[RABuffs] " .. key .. ": " .. gcinfo()-m2 .. " kB / 100 runs.");
    end
   end
  end
  m = gcinfo()-m;
  RAB_Print("[RABuffs] Query test complete. " .. pass .. " passed, " .. fail .. " failed. " .. m ..  " kB.",(fail > 0 and "warn" or "ok"));
 elseif (cmd == "coreinfo") then
  RAB_Core_List();
 else
  RAB_Print(sRAB_Slash_UnrecognizedCommand,"warn");
 end
end
SLASHHELP_RABUFFS = function (text)
 text = strlower(text);
 if (RABui_Settings.syntaxhelp == false) then
  return; -- Disabled this.
 end
 local ckey, ckeyl,i, key, val = 0,0;
 for key, val in sRAB_Slash_SyntaxHelp do
  if (string.find(text,val[1]) ~= nil and strlen(val[1]) > ckeyl) then
   ckey = key; ckeyl = strlen(val[1]);
  end
 end
 if (ckey == 0) then
  return;
 end

 local th, hlen, obj,spaceprefix  = 0, 0, 0, "";
 for key, val in sRAB_Slash_SyntaxHelp[ckey] do
  if (key ~= 1) then
   if (key == 2) then -- title, must have a green part to align stuff after
    local _,_, highlight = string.find(val,"(%b-+)");
    spaceprefix = "         ";
   elseif (string.find(val,"(%b_=)") ~= nil) then
    local _,_, highlight = string.find(val,"(%b_=)");
    val = string.gsub(val,"(%b_=)","_" .. spaceprefix .. strsub(highlight,2,-2) .. "=");
   end
   SlashHelp_AddLine(RABui_SSH_Color(val));
  end
 end
 return true;
end

function RAB_ChatFrame_OnEvent(poparg1,poparg2) -- Hiding RABuffs Chat / Whispers
	if (event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_PARTY") then
		local key, val;
		for key,val in RAB_Sync_HideMasks do
			if (string.find(arg1,val) ~= nil) then
				return;
			end
		end
	end
	if (RABui_Settings.colorizechat and (event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_GUILD" or event == "CHAT_MSG_OFFICER") and
	    string.find(arg1,"^<Buffs> ") ~= nil) then
		arg1 = string.gsub(arg1,"([^ ]+) %[(%w+); G(%d)%]",RAB_ChatFrame_Color);
	end
	RAB_RealChatFrame_OnEvent(poparg1,poparg2);
end
function RAB_ChatFrame_Color(full,class, arg3)
 return RAB_Chat_Colors[class] .. full .. "|r [G" .. arg3 .. "]";
end

function RAB_UpdatePeople(nick,display,version)
 if (version > RABuffs_DeciVersion and version > RABui_Settings.newestVersion) then
	RABui_Settings.newestVersion = version;
	RABui_Settings.newestVersionTitle = display;
	RABui_Settings.newestVersionPlayer = nick;
	RABui_Settings.newestVersionRealm = GetCVar("realmName");
 end
 local key = GetCVar("realmName") .. "." .. nick;
 if (RAB_Versions[key] == nil) then
  RAB_Versions[key] = {name=nick,v=display,d=version,l=time()};
 else
  RAB_Versions[key].v, RAB_Versions[key].d, RAB_Versions[key].l = display, version, time();
 end
end

RAB_Core_Register("PLAYER_LOGIN", "load", RAB_Loaded);