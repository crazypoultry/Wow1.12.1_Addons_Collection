local oldCastSpellByName, oldCastSpell, oldUseAction, waittoconfirm, init;
local DHSave = nil;
local doCheck = nil;
local innSpellNumber;
local rezSpellNumber;
local theunmarked = {};
local waitforcooldownmessages, watchcooldown;
local cooldowntimer = 0;
local cooldowncount = 0;
local cooldowntype = "";
local cooldownnames = "";
local updatetimer = 0;
local waittoconfirm;
local showall = nil;
local dhprefix = "<DruidHelper>";
dhtimer = {{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0},{nil,"",0}};
function DHelper_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("SPELLCAST_STOP");
	SlashCmdList["DHELPERSLASH"] = DHelper_Enable_ChatCommandHandler;
	SLASH_DHELPERSLASH1 = "/dh";
	SLASH_DHELPERSLASH2 = "/dhelper";
	DHHiddenTip:SetOwner(DHHiddenTip, "ANCHOR_NONE");
end
groupstowatch = {};

function DHelper_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		 local _, cls = UnitClass("player");
		 init = cls;
		 if not DHChan then DHChan = "trsdruids"; end
		 oldCastSpellByName = CastSpellByName;
		 CastSpellByName = DHelper_CastSpellByName;
		 oldCastSpell = CastSpell;
		 CastSpell = DHelper_CastSpell;
		 oldUseAction = UseAction;
		 UseAction = DHelper_UseAction;
	elseif init and init == "DRUID" and DHKey then
		if event == "SPELLCAST_STOP" then
			if waittoconfirm then
				doCheck = true;
				waittoconfirm = nil;
				--DEFAULT_CHAT_FRAME:AddMessage("waiting");
			end
		elseif event == "CHAT_MSG_ADDON" and arg1 == dhprefix then
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
					local ret = "DruidHelper: You are currently watching groups ";
					for i = 1, getn(groupstowatch) do
						ret = ret..groupstowatch[i].." ";
					end
					DHelper_Print(ret);
				else
					groupstowatch = {};
					DHelper_Print("DruidHelper: No groups for you!");
				end
			elseif strfind(arg2, "bc") and DHSave then
				SendAddonMessage(dhprefix, DHSave, "RAID");
			elseif strfind(arg2, "I") then
				DHDoCooldowns(1,arg4);
			elseif strfind(arg2, "R") then
				DHDoCooldowns(2,arg4);
			end
		elseif event == "CHAT_MSG_CHANNEL_JOIN" and strfind(strlower(arg9), DHChan) and DHSave then
			SendAddonMessage(dhprefix, DHSave, "RAID");
		end
	end
end

local raidmembersgroup = {};
local raidmembersid = {};
function DHelper_OnUpdate(elapsed)
	if init and init == "DRUID" and DHKey then
		if not DruidHelper:IsVisible() then DruidHelper:Show(); end
		local totalunmarkedinagroup = 0;
		if DHLock then
			if DHDragButton:IsVisible() then DHDragButton:Hide(); end
			if DHBarDragButton:IsVisible() then DHBarDragButton:Hide(); end
		else
			if not DHDragButton:IsVisible() then DHDragButton:Show(); end
			if not DHBarDragButton:IsVisible() then DHBarDragButton:Show(); end
		end
			--???

		updatetimer = updatetimer + elapsed;
		if updatetimer >= 1 then
			if groupstowatch then
				raidmembersgroup = {};
				raidmembersid = {};
				for i = 1, GetNumRaidMembers() do
					local _, _, subgroup = GetRaidRosterInfo(i);
					local proceed;
					for j = 1, getn(groupstowatch) do
						if tonumber(groupstowatch[j]) == subgroup then proceed = true; end
					end
					if proceed then
						local j = 1;
						local mark;
						while UnitBuff("raid"..i, j) do
							DHHiddenTip:SetUnitBuff("raid"..i, j);
							if strfind(DHHiddenTipTextLeft1:GetText(), "Gift of the Wild") or strfind(DHHiddenTipTextLeft1:GetText(), "Mark of the Wild") then
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
				if totalunmarkedinagroup < 1 then
					DHwindow1:Hide(); DHwindow2:Hide(); DHwindow3:Hide();
				else
					if totalunmarkedinagroup == 1 then 
						local window1array = {raidmembersgroup[1], raidmembersid[1]};
							DHwindow1Text:SetText(UnitName("raid"..window1array[2]).."(G"..window1array[1]..")");
							theunmarked[1] = window1array[2];
							DHelper_Color(DHwindow1, "raid"..window1array[2]);
							DHwindow1:Show(); 
							DHwindow2:Hide(); 
							DHwindow3:Hide();
					elseif totalunmarkedinagroup == 2 then 
						local window1array = {raidmembersgroup[1], raidmembersid[1]};
						local window2array = {raidmembersgroup[2], raidmembersid[2]};
						DHwindow1Text:SetText(UnitName("raid"..window1array[2]).."(G"..window1array[1]..")");
						theunmarked[1] = window1array[2];
						DHelper_Color(DHwindow1, "raid"..window1array[2]);
						DHwindow2Text:SetText(UnitName("raid"..window2array[2]).."(G"..window2array[1]..")");
						theunmarked[2] = window2array[2];
						DHelper_Color(DHwindow2, "raid"..window2array[2]);
						DHwindow1:Show(); 
						DHwindow2:Show(); 
						DHwindow3:Hide();
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
						DHwindow1Text:SetText(UnitName("raid"..window1array[2]).."(G"..window1array[1]..")");
						theunmarked[1] = window1array[2];
						DHelper_Color(DHwindow1, "raid"..window1array[2]);
						DHwindow2Text:SetText(UnitName("raid"..window2array[2]).."(G"..window2array[1]..")");
						theunmarked[2] = window2array[2];
						DHelper_Color(DHwindow2, "raid"..window2array[2]);
						DHwindow3Text:SetText(UnitName("raid"..window3array[2]).."(G"..window3array[1]..")");
						theunmarked[3] = window3array[2];
						DHelper_Color(DHwindow3, "raid"..window3array[2]);
						DHwindow1:Show(); 
						DHwindow2:Show(); 
						DHwindow3:Show(); 
					end
				end
			end
			
			for i = 1, 12 do	
				if dhtimer[i][1] then
					if dhtimer[i][3] > 0 then
						dhtimer[i][3] = dhtimer[i][3] - updatetimer;
					else
						dhtimer[i] = dhtimer[i+1];
						dhtimer[i+1] = {nil, "",0}
					end
				else
					if i < 12 and dhtimer[i+1][1] then
						dhtimer[i] = dhtimer[i+1];
						dhtimer[i+1] = {nil, "", 0};
						dhtimer[i][3] = dhtimer[i][3] - updatetimer;
					end
				end
			end
			updatetimer = 0;
		end
		if not innSpellNumber then innSpellNumber = FindSpell("Innervate"); end
		if not rezSpellNumber then rezSpellNumber = FindSpell("Rebirth"); end
		if doCheck and innSpellNumber and rezSpellNumber then
			--DEFAULT_CHAT_FRAME:AddMessage("Doing now.");
			local start, duration;
			start, duration = GetSpellCooldown(innSpellNumber, BOOKTYPE_SPELL);
			if duration > 1.5 and (GetTime() - start) < 1.5 then
				SendAddonMessage(dhprefix, "I", "RAID");
			end
			start, duration = GetSpellCooldown(rezSpellNumber, BOOKTYPE_SPELL);
			if duration > 1.5 and (GetTime() - start) < 1.5 then
				SendAddonMessage(dhprefix, "R", "RAID");
			end
			doCheck = nil;
		end
		for i = 1, 12 do
			local frame = "DHBar"..i;
			if dhtimer[i][1] and DHBar then
				local min, sec;
				if dhtimer[i][3] > 60 then
					min = floor(dhtimer[i][3] / 60);
					sec = floor(dhtimer[i][3] - (min*60));
					min = min..":";
					if sec < 10 then sec = "0"..sec; end
				else
					min = "";
					sec = floor(dhtimer[i][3]);
				end
				if dhtimer[i][3] > 0 then
					getglobal(frame.."Text"):SetText(dhtimer[i][1].."("..min..sec..")");
					if dhtimer[i][2] == "Innervate" then getglobal(frame.."Bar"):SetMinMaxValues(0, 360); getglobal(frame.."Bar"):SetStatusBarColor(0,0,1); else getglobal(frame.."Bar"):SetMinMaxValues(0,1800); getglobal(frame.."Bar"):SetStatusBarColor(1,0.7,0);end
					getglobal(frame.."Bar"):SetValue(dhtimer[i][3]);
					getglobal(frame.."Bar"):SetFrameLevel(0);
					getglobal(frame):Show();
				else
					getglobal(frame):Hide();
				end
			else
				getglobal(frame):Hide();
			end
				--???
		end
		
	else
		DruidHelper:Hide();
		DHwindow1:Hide();
		DHwindow2:Hide();
		DHwindow3:Hide();
		DHDragButton:Hide();
	end
end


function DHelper_CastSpell(spell, book)
	if GetSpellName(spell, book) == "Innervate" or GetSpellName(spell, book) == "Rebirth" then
		waittoconfirm = true;
		--DEFAULT_CHAT_FRAME:AddMessage("!");
	else
		waittoconfirm = nil;
	end
	--DEFAULT_CHAT_FRAME:AddMessage("CS:"..spell);
	oldCastSpell(spell, book);
end

function DHelper_CastSpellByName(spell, self)
	if spell == "Innervate" or strfind(spell, "Rebirth") then
		waittoconfirm = true;
		--DEFAULT_CHAT_FRAME:AddMessage("!");
	else
		waittoconfirm = nil;
	end
	--DEFAULT_CHAT_FRAME:AddMessage("CSBN:"..spell);
	oldCastSpellByName(spell, self);
end

function DHelper_UseAction(a, b, c)
	if not GetActionText(a) and GetActionCooldown(a) < 1.5 then
		if GetActionTexture(a) == "Interface\\Icons\\Spell_Nature_Lightning" or GetActionTexture(a) == "Interface\\Icons\\Spell_Nature_Reincarnation" then
			waittoconfirm = true;
			--DEFAULT_CHAT_FRAME:AddMessage("!");
		else
			waittoconfirm = nil;
		end
	end
	--DEFAULT_CHAT_FRAME:AddMessage("UA:"..a);
	oldUseAction(a,b,c);
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

function DHelper_Color(frame, unit)
	local _, eclass = UnitClass(unit);
	if eclass then 
		local cola = DruidHelper_ColorScheme[strlower(eclass)];
		frame:SetBackdropColor(cola.r, cola.g, cola.b, cola.a);
		frame:SetBackdropBorderColor(cola.br, cola.bg, cola.bb, cola.ba);
	end
end

function DHelper_TargetPerson()
	TargetUnit("raid"..theunmarked[this:GetID()]);
end

function DHelper_DoMarks()
	local retar;
	if UnitExists("target") then ClearTarget(); retar = true end
	CastSpellByName("Mark of the Wild(Rank 7)"); 
	if SpellIsTargeting() then SpellTargetUnit("raid"..theunmarked[this:GetParent():GetID()]); end
	if SpellIsTargeting() then SpellStopCasting(); end
	if retar then TargetLastTarget(); end
end

function DHelper_DoGifts()
	local retar;
	if UnitExists("target") then ClearTarget(); retar = true end
	CastSpellByName("Gift of the Wild(Rank 2)");
	if SpellIsTargeting() then SpellTargetUnit("raid"..theunmarked[this:GetParent():GetID()]); end
	if SpellIsTargeting() then SpellStopCasting(); end
	if retar then TargetLastTarget(); end
end

function DHDoCooldowns(num, name)
	local cooldown = 0;
	local spell = "";
	if num == 1 then cooldown = 360; spell = "Innervate" 
	elseif num == 2 then cooldown = 1800; spell = "Rebirth" end
	local temp = {name, spell, cooldown};
	local temp1 = {}
	for i = 1, 12 do
		if dhtimer[i] and dhtimer[i][1] == name and dhtimer[i][2] == spell then return; end
	end
	for i = 1, 12 do
		if not dhtimer[i][1] then
			dhtimer[i] = temp;
			break;
		elseif dhtimer[i][3] > cooldown then
			temp1 = dhtimer[i];
			dhtimer[i] = temp;
			temp = temp1;
		end
	end
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
function DHelper_Print(msg,r,g,b,frame,id,unknown4th)
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

function DHelper_Enable_ChatCommandHandler(text)
	local msg = TextParse(text);
	if msg[1] == "ret" then
		local texts = "here:";
		for i = 1, getn(groupstowatch) do
			texts = texts..groupstowatch[i].." ";
		end
		DHelper_Print(texts);
	elseif msg[1] == "save" then 
		if msg[2] == "off" then
			DHSave = nil;
			DHelper_Print("Clearing saved data.");
		else
			DHSave = "G:"..strlower(strsub(text, 5));
			SendAddonMessage(dhprefix, DHSave, "RAID");
			DHelper_Print("Groups saved and broadcasted, and will broadcast anytime someone joins your class channel.");
		end
	elseif msg[1] == "on" then
		DHKey = true;
		DHelper_Print("DruidHelper Enabled.");
	elseif msg[1] == "off" then
		DHKey = nil;
		DHelper_Print("DruidHelper Disabled.");
	elseif msg[1] == "tog" then
		if DHKey then DHKey = nil; DHelper_Print("DruidHelper Disabled."); else DHKey = true; DHelper_Print("DruidHelper Enabled.");end
	elseif msg[1] == "lock" then
		if DHLock then DHLock = nil; DHelper_Print("DruidHelper Unlocked."); else DHLock = true; DHelper_Print("DruidHelper Locked.");end
	elseif msg[1] == "bar" then
		if DHBar then DHBar = nil; DHelper_Print("DruidHelper: Hiding Cooldown Statusbars"); else DHBar = true; DHelper_Print("DruidHelper: Showing Cooldown Statusbars"); end
	elseif msg[1] == "bc" and DHSave then
		SendAddonMessage(dhprefix, DHSave, "RAID");
	elseif msg[1] == "chan" then
		DHChan = msg[2];
		DHelper_Print("Channel name to watch changed to "..DHChan.."!");
		if GetChannelName(DHChan) == 0 then DHelper_Print("By the way...you're not in that channel currently. make sure to /join "..DHChan.." for this to work!"); end
	elseif msg[1] == "ad" then
		DHelper_Print("Administrative functions: save/bc");
		DHelper_Print("Save: saves the groups. don't use unless you're running the addon for the night! use format: /dh save [velora 14][kara 25][gothus 36][dellia 48]. can assign any groups to any person, doesn't have to be in order =P");
		DHelper_Print("Save off: Clears saved data, so that someone else can run the addon or just because the raid is over.");
		DHelper_Print("bc: Broadcasts the saved material to the group. Isn't needed unless someone doesn't update properly, it should be sent out whenever someone enters the channel.");
	elseif msg[1] == "req" then
		SendAddonMessage(dhprefix, "bc", "RAID");
	elseif msg[1] == "grp" then
		DHelper_Print("Current group setup is:"..showall);
	elseif msg[1] == "reset" then
		DHDragButton:ClearAllPoints();
		DHDragButton:SetPoint("CENTER", "UIParent", "CENTER");
	else
		DHelper_Print("Commands: on/off/tog/lock/ret/req/bar/chan/ad/grp. lock toggles moving the watcher frame. ret returns what groups you're watching. req requests a broadcast from whoever's running the addon. chan changes the channel name you want to listen to. ad shows you advanced features.");
	end
end


DruidHelper_ColorScheme = {
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