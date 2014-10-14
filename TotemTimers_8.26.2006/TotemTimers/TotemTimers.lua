--[[
original author: Donald Ephraim Curtis 
current author: Grumpey (grumpy.walker@gmail.com)
new current author:  Zulah
TotemTimers: Movable Totem Timers and Totem Expiration Notification
]]

-- functions
function TotemTimers( msg )
	command = string.lower(msg);

	local i = 1;
	arg = { };
	local tmparg = nil;
	--for tmparg in string.gfind(command, "%w+") do
	for tmparg in string.gfind(command, "%S+") do
		arg[i] = tmparg;
		i = i + 1;
	end

	if( not arg[1] ) then
		for i = 1, 5 do
			DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[i]);
		end
		DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[TT_ARRANGE]);
		DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[TT_ALIGN]);
		DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[TT_WARN]);
		DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[TT_NOTIFY]);
		DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[TT_STYLE]);
		DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[TT_TIME]);
		DEFAULT_CHAT_FRAME:AddMessage(TT_SLASH[TT_ORDER]);

	elseif( arg[1] == TT_UNLOCK ) then
		TTData.lock = 0;
		DEFAULT_CHAT_FRAME:AddMessage(TT_UNLOCKED);
	elseif( arg[1] == TT_LOCK ) then
		TTData.lock = 1;
		DEFAULT_CHAT_FRAME:AddMessage(TT_LOCKED);
	elseif( arg[1] == TT_SHOW ) then
		TTData.show = 1;
		getglobal("TotemTimersFrame"):Show();
		DEFAULT_CHAT_FRAME:AddMessage(TT_VISIBLE);
	elseif( arg[1] == TT_HIDE ) then
		TTData.show = 0;
		getglobal("TotemTimersFrame"):Hide();
		DEFAULT_CHAT_FRAME:AddMessage(TT_DISABLED);
	elseif( arg[1] == TT_ORDER ) then
		local j;
		if( arg[2] ) then
			for j = 2, 5 do
				if( arg[j] ) then
					arg[j] = string.upper(string.sub(arg[j],1,1)) .. string.lower(string.sub(arg[j],2));
					if( TotemTimers_ValidElement(arg[j]) ) then
						TTData[TT_ORDER][j-1] = arg[j];
					else 
						TotemTimers_PrintUsage(TT_SLASH[TT_ORDER]);
					end
				else
					TTData[TT_ORDER][j-1] = nil;
				end
			end
		else
			TotemTimers_PrintUsage(TT_ORDER_USAGE);
		end
		local ordermsg = "";
		for j, element in TTData[TT_ORDER] do
			ordermsg = ordermsg.. element .. " ";
		end
		TotemTimers_UpdateButtons();
		DEFAULT_CHAT_FRAME:AddMessage(format(TT_SETTING[TT_ORDER], ordermsg));
	elseif( TT_OPTION[arg[1]] ) then
		if( arg[2] ) then
			if( TT_OPTION[arg[1]][arg[2]] ) then
				TTData[arg[1]] = TT_OPTION[arg[1]][arg[2]];
			end
		end
		if( arg[1] == TT_ARRANGE ) then
			TotemTimers_SetOrientation();
		elseif( arg[1] == TT_ALIGN or arg[1] == TT_STYLE ) then
			TotemTimers_UpdateButtons();
		end
		DEFAULT_CHAT_FRAME:AddMessage(format(TT_SETTING[arg[1]], TTData[arg[1]]));
	elseif( arg[1] == "reset" ) then
		DEFAULT_CHAT_FRAME:AddMessage(TT_RESET);
		TTData = { };
		TTData.show = 1;
		TTData.lock = 0;
		TTData.flash = 10;
		TTData[TT_ALIGN] = TT_LEFT;
		TTData[TT_TIME] = TT_CT;
		TTData[TT_NOTIFY] = TT_ON;
		TTData[TT_WARN] = TT_ON;
		TTData[TT_ARRANGE] = TT_HORIZONTAL;
		TTData[TT_STYLE] = TT_STICKY;
		TTData[TT_ORDER] = { TT_AIR, TT_WATER, TT_FIRE, TT_EARTH };
		TTData.dragging = 0;
		TTData.Default = { };
		TTData.Default.expireMsg = TT_DESTROYED
		TTData.Default.expireColor = { 1.0, 1.0, 0.0 };
		TTData.Default.warningMsg = TT_WARNING;
		TTData.Default.warningColor = { 0.0, 1.0, 0.0 };
		TTData.Default.warningTime = 10;
		TTData.Totems = { };
		TTData.Totems[TT_DISEASE_CLEANSING] = {};
		TTData.Totems[TT_EARTHBIND] = {};
		TTData.Totems[TT_FIRE_NOVA] = {};
		TTData.Totems[TT_FIRE_RESISTANCE] = {};
		TTData.Totems[TT_FLAMETONGUE] = {};
		TTData.Totems[TT_FROST_RESISTANCE] = {};
		TTData.Totems[TT_GRACE_OF_AIR] = {};
		TTData.Totems[TT_GROUNDING] = {};
		TTData.Totems[TT_HEALING_STREAM] = {} ;
		TTData.Totems[TT_MAGMA] = { warningTime=5 };
		TTData.Totems[TT_MANA_SPRING] = {};
		TTData.Totems[TT_MANA_TIDE] = { warningTime=-5 };
		TTData.Totems[TT_NATURE_RESISTANCE] = {};
		TTData.Totems[TT_POISON_CLEANSING] = {};
		TTData.Totems[TT_SEARING] = {};
		TTData.Totems[TT_SENTRY] = {};
		TTData.Totems[TT_STONECLAW] = {};
		TTData.Totems[TT_STONESKIN] = {};
		TTData.Totems[TT_STRENGTH_OF_EARTH] = {};
		TTData.Totems[TT_TREMOR] = {};
		TTData.Totems[TT_TRANQUIL_AIR] = {};
		TTData.Totems[TT_WINDFURY] = {};
		TTData.Totems[TT_WINDWALL] = {};
		TTData.Totems[TT_ANCIENT_MANA_SPRING] = {};
		TTActiveTotems = { };
		
		TotemTimersFrame:ClearAllPoints();
		TotemTimersFrame:SetPoint("Right", "UIParent", "TopRight", -200,-120);
		TotemTimer2:ClearAllPoints();
		TotemTimer2:SetPoint("Right","TotemTimer1","Left",-7,0);
		TotemTimer3:ClearAllPoints();
		TotemTimer3:SetPoint("Right","TotemTimer2","Left",-7,0);
		TotemTimer4:ClearAllPoints();
		TotemTimer4:SetPoint("Right","TotemTimer3","Left",-7,0);
		TotemTimers_UpdateButtons();
	end

end

function TotemTimers_PrintUsage(usage)
	if(usage) then
		DEFAULT_CHAT_FRAME:AddMessage(TT_USAGE.." "..usage);
	end

end

function TotemTimers_ValidElement(element)
	if(element) then
		if( element == TT_EARTH or
			element == TT_FIRE or
			element == TT_AIR or
			element == TT_WATER ) then
			return 1;
		end

	end
	return nil;

end
function TotemTimers_SetOrientation()
	if(TTData[TT_ARRANGE] == TT_VERTICAL) then
		TotemTimer2:ClearAllPoints();
		TotemTimer2:SetPoint("Top","TotemTimer1","Bottom",0,-15);
		TotemTimer3:ClearAllPoints();
		TotemTimer3:SetPoint("Top","TotemTimer2","Bottom",0,-15);
		TotemTimer4:ClearAllPoints();
		TotemTimer4:SetPoint("Top","TotemTimer3","Bottom",0,-15);
	elseif(TTData[TT_ARRANGE] == TT_BOX) then
		TotemTimer2:ClearAllPoints();
		TotemTimer2:SetPoint("Right","TotemTimer1","Left",-7,0);
		TotemTimer3:ClearAllPoints();
		TotemTimer3:SetPoint("Top","TotemTimer1","Bottom",0,-15);
		TotemTimer4:ClearAllPoints();
		TotemTimer4:SetPoint("Right","TotemTimer3","Left",-7,0);
	else
		TotemTimer2:ClearAllPoints();
		TotemTimer2:SetPoint("Right","TotemTimer1","Left",-7,0);
		TotemTimer3:ClearAllPoints();
		TotemTimer3:SetPoint("Right","TotemTimer2","Left",-7,0);
		TotemTimer4:ClearAllPoints();
		TotemTimer4:SetPoint("Right","TotemTimer3","Left",-7,0);
	end
		
end

function TotemTimers_Disable() 
	TotemTimersFrame:UnregisterEvent("VARIABLES_LOADED");
	TotemTimersFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	TotemTimersFrame:UnregisterEvent("PLAYER_LEVEL_UP");
	TotemTimersFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
	TotemTimersFrame:UnregisterEvent("SPELLCAST_STOP");
  TotemTimersFrame:UnregisterEvent("PLAYER_DEAD");
	TotemTimersFrame:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
	TotemTimersFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	TotemTimersFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	TotemTimersFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	TotemTimersFrame:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");

end

function TotemTimers_Enable() 
	TotemTimersFrame:RegisterEvent("VARIABLES_LOADED");
	TotemTimersFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	TotemTimersFrame:RegisterEvent("PLAYER_LEVEL_UP");
	TotemTimersFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	TotemTimersFrame:RegisterEvent("SPELLCAST_STOP");
	TotemTimersFrame:RegisterEvent("PLAYER_DEAD");
	TotemTimersFrame:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
	TotemTimersFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	TotemTimersFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	TotemTimersFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	TotemTimersFrame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
end
	
function TotemTimers_OnLoad()
	TotemTimers_Enable();

	--TotemTimers_SetupGlobals();
	TotemTimers_SetupHooks();

	this:RegisterForDrag("LeftButton");

end

function TotemTimers_DestroyTotem(totem)
	TTActiveTotems[totem].active = nil;
	--local element = TTActiveTotems[totem].element;
	--TTActiveTotems[element] = nil;
	--TTActiveTotems[totem] = nil;
	TotemTimers_UpdateButtons();
end

function TotemTimers_ProcessAlias(text)
	if (TT_ALIAS) then
		for num, data in TT_ALIAS do
			text = string.gsub(text, data.alias, data.string);
		end
	end
	return text;
end

function TotemTimers_CastSpell(id, book)
	local start, duration, enable = GetSpellCooldown(id,book);
--	DEFAULT_CHAT_FRAME:AddMessage("CastSpell Called");
	if( start <= 0 and duration <= 0 and TTState == 0 ) then
		TT = {};
		TT["spell"] = id;
		TT["book"] = book;
		TT["totem"], TT["rank"] = GetSpellName(id, book);
		TT["totem"] = string.gfind(TT["totem"], TT_TOTEM_REGEX)();
		if( TT["totem"] ) then
			TTState = 1;
			TT["rank"] = string.gfind(TT["rank"], TT_RANK_REGEX)();
			if( not TT["rank"] ) then
				TT["rank"] = 0;
			else
				TT["rank"] = tonumber(TT["rank"]);
			end
			local oldVar = GetCVar("UberTooltips");
			SetCVar("UberTooltips", 1);
			TotemTimersTooltip:SetSpell(id,book);
			SetCVar("UberTooltips", oldVar);
			local ttdata = getglobal("TotemTimersTooltipTextLeft4"):GetText();
			TT["element"] = string.gfind(ttdata, TT_ELEMENT_REGEX)();
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Spell = "..TT["spell"]);
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Book = "..TT["book"]);
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Totem = "..TT["totem"]);
			--if( TT["rank"] ) then
				--DEFAULT_CHAT_FRAME:AddMessage("[TT] Rank = "..TT["rank"]);
			--end
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Element = "..TT["element"]);
		else
			TTState = 2;
		end
	end
end

function TotemTimers_UseAction(id, number, target)
--	DEFAULT_CHAT_FRAME:AddMessage("--------------------UseAction");
	local start, duration, enable = GetActionCooldown(id);
	local isUsable, notEnoughMana = IsUsableAction(id)
	if( start <= 0 and duration <= 0 and TTState == 0 and isUsable and not notEnoughMana ) then
		TT = {};
		TT["action"] = id;
		TT["number"] = number;
		TT["target"] = target;
		local oldVar = GetCVar("UberTooltips");
		SetCVar("UberTooltips", 1);
		TotemTimersTooltip:SetAction(id);
		SetCVar("UberTooltips", oldVar);
		local ttdata = getglobal("TotemTimersTooltipTextLeft1"):GetText();
		if( ttdata ) then
			TT["totem"] = string.gfind(ttdata, TT_TOTEM_REGEX)();
			tt_trinket = string.gfind(ttdata, TT_TRINKET_REGEX)();
		end
		if( TT["totem"] ) then
			TTState = 1;
			local ttdata = getglobal("TotemTimersTooltipTextRight1"):GetText();
			if( not ttdata ) then
				TT["rank"] = 0;
			else
				TT["rank"] = string.gfind(ttdata, TT_RANK_REGEX)();
				TT["rank"] = tonumber(TT["rank"]);
				getglobal("TotemTimersTooltipTextRight1"):SetText(nil);	
			end
			ttdata = getglobal("TotemTimersTooltipTextLeft4"):GetText();
			TT["element"] = string.gfind(ttdata, TT_ELEMENT_REGEX)();
      --DEFAULT_CHAT_FRAME:AddMessage("[TT] Action = "..TT["action"]);
			--if( TT["number"] ) then
				--DEFAULT_CHAT_FRAME:AddMessage("[TT] Number = "..TT["number"]);
			--end
			--if( TT["target"] ) then
				--DEFAULT_CHAT_FRAME:AddMessage("[TT] Target = "..TT["target"]);
			--end
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Totem = "..TT["totem"]);
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Rank = "..TT["rank"]);
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Element = "..TT["element"]);
		elseif (tt_trinket == TT_ENAMORED_WATER_SPIRIT) then
			TT["totem"] = TT_ANCIENT_MANA_SPRING;
			TT["Slot_Id"] = Slot_ID;
			TT["element"] = TT_WATER;
			TT["rank"] = 0;
			TotemTimers_CreateTotem();	
		else
			local inRange = IsActionInRange(id);
			if( inRange ) then
				TTState = 2;
				TT = {};
			end
		end
	end
end


--Additions for hooking CastSpellByName
function GetSpellID(spellname)
    local i,done,name,id,spellrank=1,false;
    _,_,spellrank = string.find(spellname,"%((Rank %d+)%)");
    spellname = string.gsub(spellname,"%(Rank %d+%)","");
    if not spellrank then
	  --DEFAULT_CHAT_FRAME:AddMessage("No Spell Rank");
          spellname = string.gsub(spellname, "%(%)", "");
  	end
	while not done do
        name,rank = GetSpellName(i,BOOKTYPE_SPELL);
        if not name then
            done=true;
        elseif (name==spellname and not spellrank) or (name==spellname and rank==spellrank) then
            id = i;
        end i = i+1;
    end
    --DEFAULT_CHAT_FRAME:AddMessage(id);
    return id

	
end

--Additions for hooking CastSpellByName
function TotemTimers_CastSpellByName(Spell_Name)
--	DEFAULT_CHAT_FRAME:AddMessage("CastSpellByName Called");
--	DEFAULT_CHAT_FRAME:AddMessage(Spell_Name)
	local id = GetSpellID(Spell_Name)
--	DEFAULT_CHAT_FRAME:AddMessage(id)
	if not id then
		return;
	end
	local start, duration, enable = GetSpellCooldown(id, BOOKTYPE_SPELL);
	if( start <= 0 and duration <= 0 and TTState == 0 ) then
		TT = {};
		TT["spell"] = id;
		TT["book"] = BOOKTYPE_SPELL;
		TT["totem"], TT["rank"] = GetSpellName(id, BOOKTYPE_SPELL);
		TT["totem"] = string.gfind(TT["totem"], TT_TOTEM_REGEX)();
			if( TT["totem"] ) then
				TTState = 1;
				TT["rank"] = string.gfind(TT["rank"], TT_RANK_REGEX)();
				if( not TT["rank"] ) then
					TT["rank"] = 0;
				else
				TT["rank"] = tonumber(TT["rank"]);
				end
			local oldVar = GetCVar("UberTooltips");
			SetCVar("UberTooltips", BOOKTYPE_SPELL);
			TotemTimersTooltip:SetSpell(id,BOOKTYPE_SPELL);
			SetCVar("UberTooltips", oldVar);
			local ttdata = getglobal("TotemTimersTooltipTextLeft4"):GetText();
			TT["element"] = string.gfind(ttdata, TT_ELEMENT_REGEX)();
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Spell = "..TT["spell"]);
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Book = "..TT["book"]);
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Rank = "..TT["rank"]);
			--DEFAULT_CHAT_FRAME:AddMessage("[TT] Totem = "..TT["totem"]);
			else
			TTState = 2;
			end
	end
end

--Additions for hooking UseInventoryItem 
function TotemTimers_UseInventoryItem(Slot_ID) 
--DEFAULT_CHAT_FRAME:AddMessage("UseInventoryItem Called");
--DEFAULT_CHAT_FRAME:AddMessage(Slot_ID);
--Check to see if it's slot id 13/14 for trinkets
	if Slot_ID==13 or Slot_ID==14 then
		linktext = GetInventoryItemLink("player", Slot_ID);
		--DEFAULT_CHAT_FRAME:AddMessage(linktext)
			if linktext then
    				local _,_,ttdata = string.find(linktext, "^.*%[(.*)%].*$");
				--DEFAULT_CHAT_FRAME:AddMessage("ttdata is here");
				TT = {};
				tt_trinket = string.gfind(ttdata, TT_TRINKET_REGEX)();
				--DEFAULT_CHAT_FRAME:AddMessage(TT["totem"]) 	
				else 
				--DEFAULT_CHAT_FRAME:AddMessage("no totem");
				return;
				end
			if( tt_trinket == TT_ENAMORED_WATER_SPIRIT ) then
				TT["totem"] = TT_ANCIENT_MANA_SPRING;
				--DEFAULT_CHAT_FRAME:AddMessage("Totem Attack");
				TT["Slot_Id"] = Slot_ID;
				TT["element"] = TT_WATER;
				TT["rank"] = 0;
				--DEFAULT_CHAT_FRAME:AddMessage(TT["Slot_Id"])
				--DEFAULT_CHAT_FRAME:AddMessage("[TT] Totem = "..TT["totem"]);
				--DEFAULT_CHAT_FRAME:AddMessage("[TT] Rank = "..TT["rank"]);
				--DEFAULT_CHAT_FRAME:AddMessage("[TT] Element = "..TT["element"]);
				TotemTimers_CreateTotem();
			else
				return;
			end
		else
		return;
	end
end

function TotemTimers_CreateTotem()
	--DEFAULT_CHAT_FRAME:AddMessage("We've made it this far")
	local at;
	if( TT ) then
		if( TotemData[TT["totem"]] ) then

			at = {};

			if( not TotemData[TT["totem"]][TT["rank"]] ) then
				--DEFAULT_CHAT_FRAME:AddMessage("Default");
				at.duration = TotemData[TT["totem"]].duration;
				at.hits = TotemData[TT["totem"]].hits;
			else
				if( TotemData[TT["totem"]][TT["rank"]].duration ) then
					at.duration = TotemData[TT["totem"]][TT["rank"]].duration;
				else
					at.duration = TotemData[TT["totem"]].duration;
				end
				if( TotemData[TT["totem"]][TT["rank"]].hits ) then
					at.hits = TotemData[TT["totem"]][TT["rank"]].hits;
				else
					at.hits = TotemData[TT["totem"]].hits;
				end
			end

			at.damage = 0;
			if ( TT["totem"] == TT_FIRE_NOVA ) then
				local nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(1,9);
				if ( currRank == 1 ) then
					at.duration = at.duration - 1 ;
				elseif ( currRank == 2 ) then
					at.duration = at.duration - 2 ;
				end
			elseif ( TT["totem"] == TT_STONECLAW ) then
				local nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(1,3);
				if ( currRank == 1 ) then
					at.hits = at.hits + (at.hits * .25);
				elseif ( currRank == 2 ) then
					at.hits = at.hits + (at.hits * .5);
				end
			end
			
			--DEFAULT_CHAT_FRAME:AddMessage("Duration: "..at.duration);
			at.Slot_Id = TT["Slot_Id"];	
			at.spell = TT["spell"];
			at.book = TT["book"];
			at.action = TT["action"];
			at.number = TT["number"];
			at.target = TT["target"];
			at.totem = TT["totem"];
			at.rank = TT["rank"];
			at.element = TT["element"];
			at.flashTime = BUFF_FLASH_TIME_OFF;
			at.flashState = 0;
			at.active = 1;


			--TTActiveTotems[TT["element"]].duration = TotemData[TT["totem"]][TT["rank"]].duration;
			--TTActiveTotems[TT["element"]].
			--TTActiveTotems[TotemData[match[1]].element].duration = TotemData[match[1]].duration;
			--TTActiveTotems[TotemData[match[1]].element].totem = match[1];
			--TTActiveTotems[TotemData[match[1]].element].flashTime = BUFF_FLASH_TIME_OFF;
			--TTActiveTotems[TotemData[match[1]].element].flashState = 0;

			--Create the expiration data, defaults and such.
			if( TTData.Totems[TT["totem"]] ) then
				if( TTData.Totems[TT["totem"]].warningTime ) then
					at.warningTime = TTData.Totems[TT["totem"]].warningTime;
				elseif( TTData.Default.warningTime ) then
					at.warningTime = TTData.Default.warningTime;
				end
			end

			TTActiveTotems[TT["element"]] = at;
			TTActiveTotems[TT["totem"]] = at;

			TT = nil;

			TotemTimers_UpdateButtons();
		end
	end
end


function TotemTimers_SetupHooks()
	TT_HookFunctions = {};
	TT_HookFunctions["UseAction"] = UseAction;
	UseAction = function(id,book,onself) 
		TotemTimers_UseAction(id, book); 
		TT_HookFunctions["UseAction"](id,book,onself); 
	end;
	TT_HookFunctions["CastSpell"] = CastSpell;
	CastSpell = function(id,book) 
		TotemTimers_CastSpell(id, book); 
		TT_HookFunctions["CastSpell"](id,book); 
	end;
	--Additions for hooking CastSpellByName
	TT_HookFunctions["CastSpellByName"] = CastSpellByName;
	CastSpellByName = function(Spell_Name)
		TotemTimers_CastSpellByName(Spell_Name);
	TT_HookFunctions["CastSpellByName"](Spell_Name);
	end;
	--Additions for hooking UseInventoryItem
	TT_HookFunctions["UseInventoryItem"] = UseInventoryItem;
	UseInventoryItem = function(Slot_ID)
		TotemTimers_UseInventoryItem(Slot_ID);
		TT_HookFunctions["UseInventoryItem"](Slot_ID);
	end;
end

function TotemTimers_OnEvent(event)
--	DEFAULT_CHAT_FRAME:AddMessage("Got Event:"..event);
	local match = { };
	if ( event == "VARIABLES_LOADED" ) then
		TotemTimers_SetupVariables();
	elseif ( event == "PLAYER_DEAD" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(TT_PLAYERDEATH);
		data.duration = 0;
		for num, totem in TTActiveTotems do
			totem.active = nil;
		end
		TotemTimers_UpdateButtons();
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		TotemTimers_SetupGlobals();
		--TotemTimers_SetupHooks();
	elseif ( event == "PLAYER_LEVEL_UP" ) then
		--TotemTimers_AdjustTotemDurations(arg1);
	elseif ( event == "SPELLCAST_STOP" ) then
		if( TTState == 1 ) then
			TotemTimers_CreateTotem();
	end
		TTState = 0;
		--DEFAULT_CHAT_FRAME:AddMessage("[TT] Finished Cast");
		--[[
	elseif ( event == "CHAT_MSG_SPELL_SELF_BUFF" ) then
		--TotemTimers_AdjustTotemDurations(UnitLevel("player"));
		match = { string.gfind(arg1, TT_CAST_REGEX)() };
		if ( table.getn( match ) >= 1 ) then
			TotemTimers_CreateTotem(match);
		end
		]]--
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or 
			 event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or
			 event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or
			 event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" ) then

		for num, regex in TT_DAMAGE_REGEX do
			match = { string.gfind(arg1, regex)() };
			if ( table.getn(match) >= 1 ) then
				match[1] = TotemTimers_ProcessAlias(match[1]);
				TotemTimers_TotemDamage(match[1], match[3]);
				break;
			end
		end
	end
end

function TotemTimers_UpdateButtons()

	local i,inc,j;
	if( TTData[TT_ALIGN] == TT_LEFT ) then
		i = 4;
		inc = -1;
	else
		i = 1;
		inc = 1;
	end
	for j = 1, 4 do
		getglobal("TotemTimer"..j):SetAlpha(1.0);
		getglobal("TotemTimer"..j.."Icon"):SetTexture("");
		getglobal("TotemTimer"..j.."Time"):SetText("");
		getglobal("TotemTimer"..j).element = nil;
	end
	for num, element in TTData[TT_ORDER] do
		-- DEFAULT_CHAT_FRAME:AddMessage("Processing:"..element);
		if( TTActiveTotems[element] ) then
			data = TTActiveTotems[element];
			if( TTActiveTotems[element].active ) then
				getglobal("TotemTimer"..i.."Icon"):SetTexture("Interface\\Icons\\"..TotemData[data.totem].icon);
				getglobal("TotemTimer"..i).element = element;
				getglobal("TotemTimer"..i.."Icon"):SetAlpha(1.0);
				getglobal("TotemTimer"..i.."Time"):SetText(TotemTimer_FormatTime(data.duration));
				i = i + inc;
			elseif ( TTData[TT_STYLE] == TT_STICKY ) then
				getglobal("TotemTimer"..i.."Icon"):SetTexture("Interface\\Icons\\"..TotemData[data.totem].icon);
				getglobal("TotemTimer"..i).element = element;
				getglobal("TotemTimer"..i.."Icon"):SetAlpha(0.4);
				getglobal("TotemTimer"..i.."Time"):SetText("");
				i = i + inc;
			elseif ( TTData[TT_STYLE] == TT_ELEMENT ) then
				getglobal("TotemTimer"..i.."Icon"):SetTexture("Interface\\Icons\\"..TT_EMPTY_ICON);
				getglobal("TotemTimer"..i.."Time"):SetText(element);
				getglobal("TotemTimer"..i.."Icon"):SetAlpha(1.0);
				getglobal("TotemTimer"..i.."Time"):SetTextColor(1.0,.8,0);
				i = i + inc;
			elseif ( TTData[TT_STYLE] == TT_FIXED ) then
				i = i + inc;
			end
			TotemData[data.totem].button = getglobal("TotemTimer"..i);
		else
			if ( TTData[TT_STYLE] == TT_FIXED ) then
				i = i + inc;
			elseif ( TTData[TT_STYLE] == TT_STICKY ) then
				--[[  I don't like this.  changed my minde ;)
				getglobal("TotemTimer"..i.."Icon"):SetTexture("Interface\\Icons\\"..TT_EMPTY_ICON);
				getglobal("TotemTimer"..i.."Time"):SetText(element);
				getglobal("TotemTimer"..i):SetAlpha(0.4);
				getglobal("TotemTimer"..i.."Time"):SetTextColor(1.0,.8,0);
				]]--
				i = i + inc;
			elseif ( TTData[TT_STYLE] == TT_ELEMENT ) then
				getglobal("TotemTimer"..i.."Icon"):SetTexture("Interface\\Icons\\"..TT_EMPTY_ICON);
				getglobal("TotemTimer"..i.."Time"):SetText(element);
				getglobal("TotemTimer"..i.."Icon"):SetAlpha(1.0);
				getglobal("TotemTimer"..i.."Time"):SetTextColor(1.0,.8,0);
				i = i + inc;
			end
		end
	end
end
    
function TotemTimers_TotemWarn(totem)
	if( TTData.Totems[totem] ) then
		local rank = TTActiveTotems[totem].rank;
		if( rank and rank > 0 ) then
			TotemTimers_NotifyWarning(format(TT_NAME_LEVEL_STRING, totem, rank), TTData.Totems[totem]);
		else
			TotemTimers_NotifyWarning(format(TT_NAME_STRING, totem ), TTData.Totems[totem]);
		end
	end
end

function TotemTimers_TotemDeath(totem)
	if( TTData.Totems[totem] ) then
		local rank = TTActiveTotems[totem].rank;
		if( rank and rank > 0 ) then
			TotemTimers_NotifyDestroy(format(TT_NAME_LEVEL_STRING, totem, rank), TTData.Totems[totem]);
		else
			TotemTimers_NotifyDestroy(format(TT_NAME_STRING, totem ), TTData.Totems[totem]);
		end
	end
	TotemTimers_DestroyTotem(totem);

end

function TotemTimers_TotemDamage(totem, damage)

	if ( TTActiveTotems[totem] ) then
		TTActiveTotems[totem].damage = TTActiveTotems[totem].damage + damage;
		--DEFAULT_CHAT_FRAME:AddMessage("[TT] Damage: "..TTActiveTotems[totem].damage);
		--DEFAULT_CHAT_FRAME:AddMessage("[TT] Hits: "..TTActiveTotems[totem].hits);
		if ( TTActiveTotems[totem].damage >= TTActiveTotems[totem].hits ) then
			TotemTimers_TotemDeath(totem);
		end
	end


end

function TotemTimers_NotifyWarning(name,item)
	if( TTData[TT_WARN] == TT_ON ) then

		local warningMsg, warningColor;

		if ( item.warningMsg ) then
			warningMsg = item.warningMsg;
		else 
			if( TTData.Default.warningMsg ) then
				warningMsg = TTData.Default.warningMsg;
			else
				warningMsg = TT_WARNING;
			end
		end

		if ( item.warningColor ) then
			warningColor = item.warningColor;
		else
			if( TTData.Default.warningColor ) then
				warningColor = TTData.Default.warningColor;
			else
				warningColor =  { 1.0, 1.0, 1.0 } ;
			end
		end
		UIErrorsFrame:AddMessage(name.." "..warningMsg,  
			warningColor[1], 
			warningColor[2], 
			warningColor[3], 
			1.0, UIERRORS_HOLD_TIME);	

		if ( item.warningSound ) then
			PlaySoundFile(item.warningSound);
		elseif( TTData.Default.warningSound ) then
			PlaySoundFile(TTData.Default.warningSound);
		end
	end
		
end

function TotemTimers_NotifyDestroy(name,item)
	if( TTData[TT_NOTIFY] == TT_ON ) then
		local expireColor;

		if ( item.expireMsg ) then
			if ( item.expireColor ) then
				expireColor = item.expireColor;
			else
				if( TTData.Default.expireColor ) then
					expireColor = TTData.Default.expireColor;
				else
					expireColor =  { 1.0, 1.0, 1.0 } ;
				end
			end
			UIErrorsFrame:AddMessage(name.." "..item.expireMsg,  
				expireColor[1], 
				expireColor[2], 
				expireColor[3], 
				1.0, UIERRORS_HOLD_TIME);	
		elseif ( TTData.Default.expireMsg ) then
			if ( item.expireColor ) then
				expireColor = item.expireColor;
			else
				if( TTData.Default.expireColor ) then
					expireColor = TTData.Default.expireColor;
				else
					expireColor =  { 1.0, 1.0, 1.0 } ;
				end
			end
			UIErrorsFrame:AddMessage(name.." "..TTData.Default.expireMsg,  
				expireColor[1], 
				expireColor[2], 
				expireColor[3], 
				1.0, UIERRORS_HOLD_TIME);	
		end

		if ( item.expireSound ) then
			PlaySoundFile(item.expireSound);
		elseif ( TTData.Default.expireSound ) then
			PlaySoundFile(TTData.Default.expireSound);
		end
	end
		
end

function TotemTimers_SetupVariables()

	if( UnitClass("player") == TT_SHAMAN ) then
		DEFAULT_CHAT_FRAME:AddMessage(TT_LOADED.." : Variables");
		UIErrorsFrame:AddMessage(TT_LOADED, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

		if( not TTActiveTotems ) then
			TTActiveTotems = { };
		end

		if( not TTData ) then
			TTData = { };
			TTData.show = 1;
			TTData.lock = 0;
			TTData.flash = 10;
			TTData[TT_ALIGN] = TT_LEFT;
			TTData[TT_TIME] = TT_CT;
			TTData[TT_NOTIFY] = TT_ON;
			TTData[TT_WARN] = TT_ON;
			TTData[TT_ARRANGE] = TT_HORIZONTAL;
			TTData[TT_STYLE] = TT_STICKY;
			TTData.dragging = 0;
		end

		if( not TTData[TT_ORDER] ) then
			TTData[TT_ORDER] = { TT_AIR, TT_WATER, TT_FIRE, TT_EARTH };
		end

		if( not TTData.Default ) then
			TTData.Default = { };
			TTData.Default.expireMsg = TT_DESTROYED
			TTData.Default.expireColor = { 1.0, 1.0, 0.0 };
			TTData.Default.warningMsg = TT_WARNING
			TTData.Default.warningColor = { 0.0, 1.0, 0.0 };
			TTData.Default.warningTime = 10;
		end
		
		if( not TTData.Totems ) then
			TTData.Totems = { };
			TTData.Totems[TT_DISEASE_CLEANSING] = {};
			TTData.Totems[TT_EARTHBIND] = {};
			TTData.Totems[TT_FIRE_NOVA] = {};
			TTData.Totems[TT_FIRE_RESISTANCE] = {};
			TTData.Totems[TT_FLAMETONGUE] = {};
			TTData.Totems[TT_FROST_RESISTANCE] = {};
			TTData.Totems[TT_GRACE_OF_AIR] = {};
			TTData.Totems[TT_GROUNDING] = {};
			TTData.Totems[TT_HEALING_STREAM] = {} ;
			TTData.Totems[TT_MAGMA] = { warningTime=5 };
			TTData.Totems[TT_MANA_SPRING] = {};
			TTData.Totems[TT_MANA_TIDE] = { warningTime=-5 };
			TTData.Totems[TT_NATURE_RESISTANCE] = {};
			TTData.Totems[TT_POISON_CLEANSING] = {};
			TTData.Totems[TT_SEARING] = {};
			TTData.Totems[TT_SENTRY] = {};
			TTData.Totems[TT_STONECLAW] = {};
			TTData.Totems[TT_STONESKIN] = {};
			TTData.Totems[TT_STRENGTH_OF_EARTH] = {};
			TTData.Totems[TT_TREMOR] = {};
			TTData.Totems[TT_TRANQUIL_AIR] = {};
			TTData.Totems[TT_WINDFURY] = {};
			TTData.Totems[TT_WINDWALL] = {};
			TTData.Totems[TT_ANCIENT_MANA_SPRING] = {};
		end

		for totem, data in TTData.Totems do
			TTData.Totems[totem].dmg = 0;
		end

		for totem, data in TotemData do
			data.damage = 0;
		end
		
		if ( TTData.show == 0 ) then
			getglobal("TotemTimersFrame"):Hide();
		else
			getglobal("TotemTimersFrame"):Show();
		end

		for num, totem in TTActiveTotems do
			totem.active = nil;
		end

		TTState = 0;

		TotemTimers_SetOrientation();
	end

end

function TotemTimers_SetupGlobals()

	if( UnitClass("player") == TT_SHAMAN ) then
		DEFAULT_CHAT_FRAME:AddMessage(TT_LOADED.." : Globals");
		-- Register our slash command
		SLASH_TOTEMTIMERS1 = "/totemtimers";
		SLASH_TOTEMTIMERS2 = "/토템";
		SlashCmdList["TOTEMTIMERS"] = function(msg)
			TotemTimers(msg);
		end
		TotemTimers_UpdateButtons();
	else
		getglobal("TotemTimersFrame"):Hide();
		TotemTimers_Disable();
	end

end
