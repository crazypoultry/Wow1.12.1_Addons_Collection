local init;
local MHSave = nil;
local theunmarked = {};
local waitforcooldownmessages;
local showall = nil;
local mhprefix = "<MageHelper>";
function MHelper_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
	SlashCmdList["MHELPERSLASH"] = MHelper_Enable_ChatCommandHandler;
	SLASH_MHELPERSLASH1 = "/mh";
	SLASH_MHELPERSLASH2 = "/mhelper";
end
groupstowatch = {};
function MHelper_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		 if not MHChan then MHChan = "trsmage"; end
		 local _, cls = UnitClass("player");
		 init = cls;
	elseif init and init == "MAGE" and MHKey then
		if event == "CHAT_MSG_ADDON" and arg1 == mhprefix then
			if strfind(arg2, "G:") then
				showall = nil;
				local start, finish = strfind(strlower(arg2), "%["..strlower(UnitName("player")).." %d+%]");
				local msg;
				if start then
					msg = strsub(arg2, start, finish);
					showall = msg;
					msg = gsub(strlower(msg), "%["..strlower(UnitName("player")).." (%d+)%]", "%1");
					groupstowatch = {};
					for i = 1, strlen(msg), 1 do
						groupstowatch[i] = strsub(msg, i, i);
					end
					local ret = "MageHelper: You are currently watching groups ";
					for i = 1, getn(groupstowatch) do
						ret = ret..groupstowatch[i].." ";
					end
					MHelper_Print(ret);
				else
					groupstowatch = {};
					MHelper_Print("MageHelper: No groups for you!");
				end
			elseif strfind(arg2, "bc") then
				SendAddonMessage(mhprefix, MHSave, "RAID");
			end
		elseif event == "CHAT_MSG_CHANNEL_JOIN" and strfind(strlower(arg9), MHChan) and MHSave then
			SendAddonMessage(mhprefix, MHSave, "RAID");
		end
	end
end

local raidmembersgroup = {};
local raidmembersid = {};
function MHelper_OnUpdate(arg1)
	if init and init == "MAGE" and MHKey then
		MageHelper:Show();
		MHHiddenTip:SetOwner(MageHelperScripts, "ANCHOR_NONE");
		local totalunmarkedinagroup = 0;
		if MHLock then
			if MHDragButton:IsVisible() then MHDragButton:Hide(); end
		else
			if not MHDragButton:IsVisible() then MHDragButton:Show(); end
		end
		if groupstowatch then
			for i = 1, GetNumRaidMembers() do
				local _, _, subgroup = GetRaidRosterInfo(i);
				local proceed;
				for j = 1, getn(groupstowatch) do
					if tonumber(groupstowatch[j]) == subgroup then proceed = true; end
				end
				if proceed then
					local j = 1;
					local mark;
					local _, eclass = UnitClass("raid"..i);
					if eclass == "WARRIOR" or eclass == "ROGUE" then
						--Do nothing.
					else

						while UnitBuff("raid"..i, j) do
							MHHiddenTip:SetUnitBuff("raid"..i, j);
							if strfind(MHHiddenTipTextLeft1:GetText(), "Arcane Intellect") or strfind(MHHiddenTipTextLeft1:GetText(), "Arcane Brilliance") then
								mark = true;
							end
							j = j + 1;
							if mark then break; end
						end
						if not mark and UnitIsConnected("raid"..i) and not UnitIsDeadOrGhost("raid"..i) then
							totalunmarkedinagroup = totalunmarkedinagroup + 1;
							raidmembersgroup[totalunmarkedinagroup] = subgroup;
							raidmembersid[totalunmarkedinagroup] = i;
						end
					end
				end
			end
		end
				if totalunmarkedinagroup < 1 then
					MHwindow1:Hide(); MHwindow2:Hide(); MHwindow3:Hide();
				else
					if totalunmarkedinagroup == 1 then 
						local window1array = {raidmembersgroup[1], raidmembersid[1]};
							MHwindow1Text:SetText(UnitName("raid"..window1array[2]).."(G"..window1array[1]..")");
							theunmarked[1] = window1array[2];
							MHelper_Color(MHwindow1, "raid"..window1array[2]);
							MHwindow1:Show(); 
							MHwindow2:Hide(); 
							MHwindow3:Hide();
					elseif totalunmarkedinagroup == 2 then 
						local window1array = {raidmembersgroup[1], raidmembersid[1]};
						local window2array = {raidmembersgroup[2], raidmembersid[2]};
						MHwindow1Text:SetText(UnitName("raid"..window1array[2]).."(G"..window1array[1]..")");
						theunmarked[1] = window1array[2];
						MHelper_Color(MHwindow1, "raid"..window1array[2]);
						MHwindow2Text:SetText(UnitName("raid"..window2array[2]).."(G"..window2array[1]..")");
						theunmarked[2] = window2array[2];
						MHelper_Color(MHwindow2, "raid"..window2array[2]);
						MHwindow1:Show(); 
						MHwindow2:Show(); 
						MHwindow3:Hide();
					elseif totalunmarkedinagroup >= 3 then
						local window1array = {raidmembersgroup[1], raidmembersid[1]};
						local window2array = {9, 9}; 
						local window3array = {9, 9};
						for i = 2, totalunmarkedinagroup do
							if raidmembersgroup[i] <= window1array[1] then
								window3array = window2array;
								window2array = window1array;
								window1array = {raidmembersgroup[i], raidmembersid[i]};
							elseif raidmembersgroup[i] <= window2array[1] then
								window3array = window2array;
								window2array = {raidmembersgroup[i], raidmembersid[i]};
							elseif raidmembersgroup[i] <= window3array[1] then
								window3array = {raidmembersgroup[i], raidmembersid[i]};
							end
						end
						MHwindow1Text:SetText(UnitName("raid"..window1array[2]).."(G"..window1array[1]..")");
						theunmarked[1] = window1array[2];
						MHelper_Color(MHwindow1, "raid"..window1array[2]);
						MHwindow2Text:SetText(UnitName("raid"..window2array[2]).."(G"..window2array[1]..")");
						theunmarked[2] = window2array[2];
						MHelper_Color(MHwindow2, "raid"..window2array[2]);
						MHwindow3Text:SetText(UnitName("raid"..window3array[2]).."(G"..window3array[1]..")");
						theunmarked[3] = window3array[2];
						MHelper_Color(MHwindow3, "raid"..window3array[2]);
						MHwindow1:Show(); 
						MHwindow2:Show(); 
						MHwindow3:Show(); 
					end
				end
	else
		MageHelper:Hide();
		MHwindow1:Hide();
		MHwindow2:Hide();
		MHwindow3:Hide();
		MHDragButton:Hide();
	end
end

local TotalSpells
function FindSpell(name, rank)
	if not TotalSpells then 
		local _, _, offset, spells = GetSpellTabInfo(GetNumSpellTabs())
		TotalSpells = offset + spells;
	end
	local savespell;
	for i = 1, TotalSpells do
		local Iname, Irank = GetSpellName(i, BOOKTYPE_SPELL);
		if strfind(Iname, name) then
			if rank then
				if Irank then
					if strfind(Irank, rank) then
						savespell = i;
						break;
					end
				end
			else
				savespell = i;
				break;
			end
		end
	end
	if savespell then return savespell; else return nil; end
end

function MHelper_Color(frame, unit)
	local _, eclass = UnitClass(unit);
	if eclass then 
		local cola = MageHelper_ColorScheme[strlower(eclass)];
		frame:SetBackdropColor(cola.r, cola.g, cola.b, cola.a);
		frame:SetBackdropBorderColor(cola.br, cola.bg, cola.bb, cola.ba);
	end
end

function MHelper_TargetPerson()
	TargetUnit("raid"..theunmarked[this:GetID()]);
end

function MHelper_DoMarks()
	local retar;
	if UnitExists("target") then ClearTarget(); retar = true end
	CastSpellByName("Arcane Intellect(Rank 5)"); 
	if SpellIsTargeting() then SpellTargetUnit("raid"..theunmarked[this:GetParent():GetID()]); end
	if retar then TargetLastTarget(); end
end

function MHelper_DoGifts()
	local retar;
	if UnitExists("target") then ClearTarget(); retar = true end
	CastSpellByName("Arcane Brilliance(Rank 1)");
	if SpellIsTargeting() then SpellTargetUnit("raid"..theunmarked[this:GetParent():GetID()]); end
	if retar then TargetLastTarget(); end
end

--Text Parsing. Yay!
function TextParse(InputString)
--[[ By FERNANDO!
	This function should take a string and return a table with each word from the string in
	each entry. IE, "Linoleum is teh awesome" returns {"Linoleum", "is", "teh", "awesome"}
	Some good should come of this, I've been avoiding writing a text parser for a while, and
	I need one I understand completely. ^_^

	If you want to gank this function and use it for whatever, feel free. Just give me props
	somewhere. This function, as far as I can tell, is fairly foolproof. It's hard to get it
	to screw up. It's also completely self-contained. Just cut and paste.]]
   local Text = InputString;
   local TextLength = 1;
   local OutputTable = {};
   local OTIndex = 1;
   local StartAt = 1;
   local StopAt = 1;
   local TextStart = 1;
   local TextStop = 1;
   local TextRemaining = 1;
   local NextSpace = 1;
   local Chunk = "";
   local Iterations = 1;
   local EarlyError = false;

   if ((Text ~= nil) and (Text ~= "")) then
   -- ... Yeah. I'm not even going to begin without checking to make sure Im not getting
   -- invalid data. The big ol crashes I got with my color functions taught me that. ^_^

      -- First, it's time to strip out any extra spaces, ie any more than ONE space at a time.
      while (string.find(Text, "  ") ~= nil) do
         Text = string.gsub(Text, "  ", " ");
      end

      -- Now, what if text consisted of only spaces, for some ungodly reason? Well...
      if (string.len(Text) <= 1) then
         EarlyError = true;
      end

      -- Now, if there is a leading or trailing space, we nix them.
      if EarlyError ~= true then
        TextStart = 1;
        TextStop = string.len(Text);

        if (string.sub(Text, TextStart, TextStart) == " ") then
           TextStart = TextStart+1;
        end

        if (string.sub(Text, TextStop, TextStop) == " ") then
           TextStop = TextStop-1;
        end

        Text = string.sub(Text, TextStart, TextStop);
      end

      -- Finally, on to breaking up the goddamn string.

      OTIndex = 1;
      TextRemaining = string.len(Text);

      while (StartAt <= TextRemaining) and (EarlyError ~= true) do

         -- NextSpace is the index of the next space in the string...
         NextSpace = string.find(Text, " ",StartAt);
         -- if there isn't another space, then StopAt is the length of the rest of the
         -- string, otherwise it's just before the next space...
         if (NextSpace ~= nil) then
            StopAt = (NextSpace - 1);
         else
            StopAt = string.len(Text);
            LetsEnd = true;
         end

         Chunk = string.sub(Text, StartAt, StopAt);
         OutputTable[OTIndex] = Chunk;
         OTIndex = OTIndex + 1;

         StartAt = StopAt + 2;

      end
   else
      OutputTable[1] = "Error: Bad value passed to TextParse!";
   end

   if (EarlyError ~= true) then
      return OutputTable;
   else
      return {"Error: Bad value passed to TextParse!"};
   end
end

--Normal print job.
function MHelper_Print(msg,r,g,b,frame,id,unknown4th)
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end
				
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b,id,unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id,unknown4th);
		end
	end
end

function MHelper_Enable_ChatCommandHandler(text)
	local msg = TextParse(text);
	if msg[1] == "ret" then
		local texts = "here:";
		for i = 1, getn(groupstowatch) do
			texts = texts..groupstowatch[i].." ";
		end
		MHelper_Print(texts);
	elseif msg[1] == "save" then 
		if msg[2] == "off" then
			MHSave = nil;
			MHelper_Print("Clearing saved data.");
		else
			MHSave = "G:"..strlower(strsub(text, 5));
			SendAddonMessage(mhprefix, MHSave, "RAID");
			MHelper_Print("Groups saved and broadcasted, and will broadcast anytime someone joins");
		end
	elseif msg[1] == "on" then
		MHKey = true;
		MHelper_Print("MageHelper Enabled.");
	elseif msg[1] == "off" then
		MHKey = nil;
		MHelper_Print("MageHelper Disabled.");
	elseif msg[1] == "tog" then
		if MHKey then MHKey = nil; MHelper_Print("MageHelper Disabled."); else MHKey = true; MHelper_Print("MageHelper Enabled.");end
	elseif msg[1] == "lock" then
		if MHLock then MHLock = nil; MHelper_Print("MageHelper Unlocked."); else MHLock = true; MHelper_Print("MageHelper Locked.");end
	elseif msg[1] == "bc" then
		SendAddonMessage(mhprefix, MHSave, "RAID");
	elseif msg[1] == "req" then
		SendAddonMessage(mhprefix, "bc", "RAID");
	elseif msg[1] == "grp" then
		MHelper_Print("Current group setup is:"..showall);
	elseif msg[1] == "chan" then
		MHChan = msg[2];
		MHelper_Print("Channel name to watch changed to "..MHChan.."!");
		if GetChannelName(MHChan) == 0 then MHelper_Print("By the way...you're not in that channel currently. make sure to /join "..MHChan.." for this to work!"); end
	elseif msg[1] == "ad" then
		MHelper_Print("Administrative functions: save/bc");
		MHelper_Print("Save: saves the groups. don't use unless you're running the mages! use format: /MH save [velora 14][kara 25][gothus 36][dellia 48]. can assign any groups to any person, doesn't have to be in order =P");
		MHelper_Print("bc: Broadcasts the saved material to the group. Isn't needed unless someone's info stuffs up, it should be sent out whenever someone enters the channel.");
	elseif msg[1] == "reset" then
		MHDragButton:ClearAllPoints();
		MHDragButton:SetPoint("CENTER", "UIParent", "CENTER");
	else
		MHelper_Print("Commands: on/off/tog/lock/ret/req. lock toggles moving the watcher frame. ret returns what groups you're watching. req forces someone else to rebroadcast for you.");
	end
end


MageHelper_ColorScheme = {
		["warrior"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.470588,
					["ba"] = 1,
					["bb"] = 0.0431373,
					["b"] = 0.0431373,
					["bg"] = 0.470588,
					["br"] = 1,
			},
		["paladin"] = {
					["a"] = 1,
					["r"] = 0.909804,
					["g"] = 0.968627,
					["ba"] = 1,
					["bb"] = 1,
					["b"] = 1,
					["bg"] = 0.968627,
					["br"] = 0.909804,

			},
		["shaman"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.0627451,
					["ba"] = 1,
					["bb"] = 0.701961,
					["b"] = 0.701961,
					["bg"] = 0.0627451,
					["br"] = 1,
			},
		["rogue"] = {
					["a"] = 1,
					["r"] = 0.878431,
					["g"] = 1,
					["ba"] = 1,
					["bb"] = 0,
					["b"] = 0,
					["bg"] = 1,
					["br"] = 0.878431,
			},
		["mage"] = {
					["a"] = 1,
					["r"] = 0.109804,
					["g"] = 0,
					["ba"] = 1,
					["bb"] = 1,
					["b"] = 1,
					["bg"] = 0,
					["br"] = 0.109804,
			},
		["druid"] = {
					["a"] = 1,
					["r"] = 0.682353,
					["g"] = 0.419608,
					["ba"] = 1,
					["bb"] = 1,
					["b"] = 1,
					["bg"] = 0.419608,
					["br"] = 0.682353,
			},
		["priest"] = {
					["a"] = 1,
					["r"] = 0.431373,
					["g"] = 1,
					["ba"] = 1,
					["bb"] = 0.901961,
					["b"] = 0.901961,
					["bg"] = 1,
					["br"] = 0.431373,
			},
		["hunter"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 1,
					["ba"] = 1,
					["bb"] = 0.0862745,
					["b"] = 0.0862745,
					["bg"] = 1,
					["br"] = 0,
			},
		["warlock"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 0,
					["ba"] = 1,
					["bb"] = 0,
					["b"] = 0,
					["bg"] = 0,
					["br"] = 0,
			},
}