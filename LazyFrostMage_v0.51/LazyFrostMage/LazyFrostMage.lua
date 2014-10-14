LazyFrostMage_Status = "Disabled"
LazyFrostMage_Debug = "Disabled"

function LazyFrostMage_Msg(msg)
    if( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage(msg);
    end
end

function LazyFrostMage_DebugMsg(msg)
    if( DEFAULT_CHAT_FRAME ) and LazyFrostMage_Debug == "Enabled" then
        DEFAULT_CHAT_FRAME:AddMessage(msg);
    end
end

function LazyFrostMage_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");

	SLASH_LazyFrostMageCMD1 = "/LFM";
	SLASH_LazyFrostMageCMD2 = "/LazyFrostMage";
	SlashCmdList["LazyFrostMageCMD"] = LazyFrostMage_Command;
end

function LazyFrostMage_Command(param1)
	LazyFrostMage_DebugMsg("--------LFM debug: LazyFrostMage Pulse!-----------") 
	local start, finish, command, value = string.find(param1, "(%w+) (%w+)");
	if string.lower(param1) == "party" then param1 = "party" end;
	if string.lower(param1) == "farm" then param1 = "farm" end;
	if string.lower(param1) == "disable" then param1 = "disable" end;
	if string.lower(param1) == "help" then param1 = "help" end;
	if string.lower(param1) == "action" then param1 = "action" end;
	if string.lower(param1) == "status" then param1 = "status" end;
	if string.lower(param1) == "debug" then param1 = "debug" end;
	if (string.lower(param1) == "party") then 
		LazyFrostMage_Status = "PartyMode"
		LazyFrostMage_Msg("LFM Current Status:"..LazyFrostMage_Status)
		
	elseif (string.lower(param1) == "farm") then
		LazyFrostMage_Status = "Farming"
		LazyFrostMage_Msg("LFM Current Status:"..LazyFrostMage_Status)
		
	elseif (string.lower(param1) == "disable") then
		LazyFrostMage_Status = "Disabled"
		LazyFrostMage_Msg("LFM Current Status:"..LazyFrostMage_Status)
	
	elseif (string.lower(param1) == "help") then
		LazyFrostMage_Help();
	elseif (string.lower(param1) == "status") then
		LazyFrostMage_Msg("LFM Current Status:"..LazyFrostMage_Status)
	elseif (string.lower(param1) == "debug") then
		if LazyFrostMage_Debug == "Disabled" then
			LazyFrostMage_Debug = "Enabled"
			LazyFrostMage_Msg("LFM Debug mode enabled")
		else
			LazyFrostMage_Debug = "Disabled"
			LazyFrostMage_Msg("LFM Debug mode disabled")
		end
	elseif (string.lower(param1) == "action") then
		LazyFrostMage_Action();
		
	else
		LazyFrostMage_Usage();
	end
end

function LazyFrostMage_Action()
	if LazyFrostMage_Status == "PartyMode" then
		LazyFrostMage_RunParty();
		
	elseif LazyFrostMage_Status == "Farming" then
		LazyFrostMage_RunFarming();
		
	else
	LazyFrostMage_DebugMsg("LFM debug: Will only attempt to cast Frostbolt") 
	CastSpellByName("Frostbolt")
	end
end

function LazyFrostMage_RunParty()
	LazyFrostMage_DebugMsg("LFM debug: Going Party Mode") 
	if IsAltKeyDown() then 
		MA=UnitName("target")
		LazyFrostMage_Msg("LFM: "..MA.." is now Main Assist for Party Mode.")
	end
	
	if UnitAffectingCombat("target") then
		if not FindDrink() then
			SlashStand(); --Just to make sure you are standing incase you still sits after drinking
			if MA ~= nil then
				AssistByName(MA)
				LazyFrostMage_DebugMsg("LFM debug: Assisting: "..MA) 
			else
				LazyFrostMage_DebugMsg("LFM debug: Nobody to assist.") 
			end
			
			if not UnitIsDead("target") and UnitIsEnemy("target", "Player") then 
				LazyFrostMage_DebugMsg("LFM debug: Target is alive and enemy, will cast frostbolt.") 
				CastSpellByName("Frostbolt")
			else
				LazyFrostMage_DebugMsg("LFM debug: Target is dead or player, wont cast.") 
			end
		else
			LazyFrostMage_DebugMsg("LFM debug: Still drinking, will attempt to fighting after the drink.") 
		end
	else
		DrinkWater()
	end
end

function DrinkWater()
	if not FindDrink() then
		if (UnitMana("player") / UnitManaMax("player")) < 0.85 then
		LazyFrostMage_DebugMsg("LFM debug: Low mana, attempts to drink..") 
			local WaterBag,WaterSlot,WaterTexture,WaterCount = FindWater()
			if WaterBag==nil then
				LazyFrostMage_DebugMsg("LFM debug: Out of water, attempts to conjure more.") 
				
				SlashStand();
				CastSpellByName("Conjure Water()")
			else
				LazyFrostMage_DebugMsg("LFM debug: Water found, attempts to drink; bag: "..WaterBag.."; slot: "..WaterSlot) 
				UseContainerItem(WaterBag,WaterSlot)
			end
		end
	end
end

function FindDrink()
	local i=1;
	while UnitBuff("Player",i) do
		GameTooltipTextLeft1:SetText(nil);
		GameTooltip:SetUnitBuff("Player",i);
		local BuffName = GameTooltipTextLeft1:GetText();
		if BuffName == "Drink" then
			return true;
		end
		i = i + 1;
	end
	return false;
end

function FindShield()
	local i=1;
	while UnitBuff("Player",i) do
		GameTooltipTextLeft1:SetText(nil);
		GameTooltip:SetUnitBuff("Player",i);
		local BuffName = GameTooltipTextLeft1:GetText();
		if BuffName == "Mana Shield" or BuffName == "Ice Barrier" then
			return true;
		end
		i = i + 1;
	end
	return false;
end

function FindIntelBuff()
	local i=1;
	while UnitBuff("Player",i) do
		GameTooltipTextLeft1:SetText(nil);
		GameTooltip:SetUnitBuff("Player",i);
		local BuffName = GameTooltipTextLeft1:GetText();
		if BuffName == "Arcane Intellect" then
			return true;
		end
		i = i + 1;
	end
	return false;
end

function FindFrostBuff()
	local i=1;
	while UnitBuff("Player",i) do
		GameTooltipTextLeft1:SetText(nil);
		GameTooltip:SetUnitBuff("Player",i);
		local BuffName = GameTooltipTextLeft1:GetText();
		if BuffName == "Frost Armor" then
			return true;
		end
		i = i + 1;
	end
	return false;
end

function FindDampenMagic()
	local i=1;
	while UnitBuff("Player",i) do
		GameTooltipTextLeft1:SetText(nil);
		GameTooltip:SetUnitBuff("Player",i);
		local BuffName = GameTooltipTextLeft1:GetText();
		if BuffName == "Dampen Magic" then
			return true;
		end
		i = i + 1;
	end
	return false;
end

function FindWater()
	item = string.lower("Water");
	local link;
	local count, bag, slot, texture;
	local totalcount = 0;
	for i = 0,NUM_BAG_FRAMES do
		for j = 1,MAX_CONTAINER_ITEMS do
			link = GetContainerItemLink(i,j);
			if ( link ) then
				oldlink = link
				link = string.find(string.lower(link), item, 12, true)
				if ( link ) then
					LazyFrostMage_DebugMsg("LFM debug: Water is found by FindWater() at "..i.."."..j.."named: "..oldlink) 
					bag, slot = i, j;
					texture, count = GetContainerItemInfo(i,j);
					totalcount = totalcount + count;
				end
			end
		end
	end
	return bag, slot, texture, totalcount;
end

function FindManaRuby()
	item = string.lower("Mana Ruby");
	local link;
	local count, bag, slot, texture;
	local totalcount = 0;
	for i = 0,NUM_BAG_FRAMES do
		for j = 1,MAX_CONTAINER_ITEMS do
			link = GetContainerItemLink(i,j);
			if ( link ) then
				oldlink = link
				link = string.find(string.lower(link), item, 1, true)
				if ( link ) then
					LazyFrostMage_DebugMsg("LFM debug: Mana Ruby is found by FindManaRuby() at "..i.."."..j.."named: "..oldlink) 
					bag, slot = i, j;
					texture, count = GetContainerItemInfo(i,j);
					totalcount = totalcount + count;
				end
			end
		end
	end
	return bag, slot, texture, totalcount;
end

function FindManaCitrine()
	item = string.lower("Mana Citrine");
	local link;
	local count, bag, slot, texture;
	local totalcount = 0;
	for i = 0,NUM_BAG_FRAMES do
		for j = 1,MAX_CONTAINER_ITEMS do
			link = GetContainerItemLink(i,j);
			if ( link ) then
				oldlink = link
				link = string.find(string.lower(link), item, 1, true)
				if ( link ) then
					LazyFrostMage_DebugMsg("LFM debug: Mana Citrine is found by FindManaCitrine() at "..i.."."..j.."named: "..oldlink) 
					bag, slot = i, j;
					texture, count = GetContainerItemInfo(i,j);
					totalcount = totalcount + count;
				end
			end
		end
	end
	return bag, slot, texture, totalcount;
end

function FindManaJade()
	item = string.lower("Mana Jade");
	local link;
	local count, bag, slot, texture;
	local totalcount = 0;
	for i = 0,NUM_BAG_FRAMES do
		for j = 1,MAX_CONTAINER_ITEMS do
			link = GetContainerItemLink(i,j);
			if ( link ) then
				oldlink = link
				link = string.find(string.lower(link), item, 1, true)
				if ( link ) then
					LazyFrostMage_DebugMsg("LFM debug: Mana Jade is found by FindManaJade() at "..i.."."..j.."named: "..oldlink) 
					bag, slot = i, j;
					texture, count = GetContainerItemInfo(i,j);
					totalcount = totalcount + count;
				end
			end
		end
	end
	return bag, slot, texture, totalcount;
end

function FindManaAgate()
	item = string.lower("Mana Agate");
	local link;
	local count, bag, slot, texture;
	local totalcount = 0;
	for i = 0,NUM_BAG_FRAMES do
		for j = 1,MAX_CONTAINER_ITEMS do
			link = GetContainerItemLink(i,j);
			if ( link ) then
				oldlink = link
				link = string.find(string.lower(link), item, 1, true)
				if ( link ) then
					LazyFrostMage_DebugMsg("LFM debug: Mana Agate is found by FindManaAgate() at "..i.."."..j.."named: "..oldlink) 
					bag, slot = i, j;
					texture, count = GetContainerItemInfo(i,j);
					totalcount = totalcount + count;
				end
			end
		end
	end
	return bag, slot, texture, totalcount;
end

function UseManaRuby()
	local GemBag,GemSlot,GemTexture,GemCount = FindManaRuby()
	if GemBag~=nil then
		UseContainerItem(GemBag,GemSlot)
	end
end

function UseManaCitrine()
	local GemBag,GemSlot,GemTexture,GemCount = FindManaCitrine()
	if GemBag~=nil then
		UseContainerItem(GemBag,GemSlot)
	end
end

function UseManaJade()
	local GemBag,GemSlot,GemTexture,GemCount = FindManaJade()
	if GemBag~=nil then
		UseContainerItem(GemBag,GemSlot)
	end
end

function UseManaAgate()
	local GemBag,GemSlot,GemTexture,GemCount = FindManaAgate()
	if GemBag~=nil then
		UseContainerItem(GemBag,GemSlot)
	end
end

function ConjureGems()
	ManaRuby=0
	ManaCitrine=0
	ManaJade=0
	ManaAgate=0
	
	local i = 1
	while true do
	   local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
	   if not spellName then
		  do break end
	   end


	if string.find(spellName, "Conjure Mana Ruby", 1, true) then
		ManaRuby=1
	end
	if string.find(spellName, "Conjure Mana Citrine", 1, true) then
		ManaCitrine=1
	end
	if string.find(spellName, "Conjure Mana Jade", 1, true) then
		ManaJade=1
	end
	if string.find(spellName, "Conjure Mana Agate", 1, true) then
		ManaAgate=1
	end
	   i = i + 1
	end
	LazyFrostMage_DebugMsg("LFM debug: Mana Gems avaliable in spellbook: ManaRuby: "..ManaRuby.."; ManaCitrine: "..ManaCitrine.."; ManaJade: "..ManaJade.."; ManaAgate: "..ManaAgate..";.") 
	
	if ManaRuby==1 and not FindManaRuby() then
		LazyFrostMage_DebugMsg("LFM debug: Out of mana Ruby, Conjuring Mana Ruby") 
		CastSpellByName("Conjure Mana Ruby")
	end
	if ManaCitrine==1 and not FindManaCitrine() then
		LazyFrostMage_DebugMsg("LFM debug: Out of mana Citrine, Conjuring Mana Citrine") 
		CastSpellByName("Conjure Mana Citrine")
	end
	if ManaJade==1 and not FindManaJade() then
		LazyFrostMage_DebugMsg("LFM debug: Out of mana Jade, Conjuring Mana Jade") 
		CastSpellByName("Conjure Mana Jade")
	end
	if ManaAgate==1 and not FindManaAgate() then
		LazyFrostMage_DebugMsg("LFM debug: Out of mana Agate, Conjuring Mana Agate") 
		CastSpellByName("Conjure Mana Agate")
	end
end

function UseBestGem()
	UseManaRuby()
	UseManaCitrine()
	UseManaJade()
	UseManaAgate()
end

function SlashStand()
	text = gsub( "/Stand", "\n", ""); -- cannot send newlines, will disconnect
	ChatFrameEditBox:SetText(text);
	ChatEdit_SendText(ChatFrameEditBox);
end


function LazyFrostMage_RunFarming()
	LazyFrostMage_DebugMsg("LFM debug: Going Farming Mode") 
	
	if UnitAffectingCombat("Player") then
		if not FindDrink() then
			SlashStand(); --Just to make sure you are standing incase you still sits after drinking
						
			if not UnitIsDead("target") and UnitIsEnemy("target", "Player") then 
				LazyFrostMage_DebugMsg("LFM debug: Target is alive and enemy, will do actions...") 
				if FindShield() then
					LazyFrostMage_DebugMsg("LFM debug: Shield on, Nuking...") 
					if (UnitHealth("target") / UnitHealthMax("target")) > 0.15 then
						LazyFrostMage_DebugMsg("LFM debug: target is healty, Nuking frostbolt...") 
						CastSpellByName("Frostbolt")
					else
						LazyFrostMage_DebugMsg("LFM debug: target is near death, attempting to cast Fire Blast as a finnishing move") 
						CastSpellByName("Fire Blast")
					end
				else
					LazyFrostMage_DebugMsg("LFM debug: Shield off, attempting to set up shield.") 
					CastSpellByName("Ice Barrier")
					CastSpellByName("Mana Shield")
				end
				if (UnitMana("player") / UnitManaMax("player")) < 0.15 then
					UseBestGem()
				end
			else
				LazyFrostMage_DebugMsg("LFM debug: Target is dead or player, wont cast.") 
				TargetNearestEnemy(reverse)
				if UnitAffectingCombat("target") then
					CastSpellByName("Frost Nova")
				end
			end
		else
			LazyFrostMage_DebugMsg("LFM debug: Still drinking, will attempt to fighting after the drink.") 
		end
	else
		if not FindShield() and not FindDrink() then
			LazyFrostMage_DebugMsg("LFM debug: Shield off, attempting to set up shield.") 
			SlashStand()
			CastSpellByName("Ice Barrier")
			CastSpellByName("Mana Shield")
		end
		if not FindFrostBuff() and not FindDrink() then
			LazyFrostMage_DebugMsg("LFM debug: Recasting frost armor.") 
			SlashStand()
			CastSpellByName("Frost Armor")
		end
		if not FindDampenMagic() and not FindDrink() then
			LazyFrostMage_DebugMsg("LFM debug: Recasting dampen magic.") 
			SlashStand()
			CastSpellByName("Dampen Magic")
		end
		if not FindIntelBuff() and not FindDrink() then
			LazyFrostMage_DebugMsg("LFM debug: Recasting arcane intellect.") 
			SlashStand()
			TargetUnit("Player")
			CastSpellByName("Arcane Intellect")
			TargetLastEnemy()
		end


		
		ConjureGems()
		
		DrinkWater()
		if not FindDrink() and (UnitMana("player") / UnitManaMax("player")) > 0.85 and (UnitHealth("player") / UnitHealthMax("player")) > 0.85 and FindFrostBuff() and FindIntelBuff() then
			LazyFrostMage_DebugMsg("LFM debug: Buffs, health and mana restored pulling nearest enemy.") 
			TargetNearestEnemy(reverse)
			SlashStand()
			CastSpellByName("Frostbolt")
		end
	end
end

function LazyFrostMage_Usage() 
    LazyFrostMage_Msg("|cffffff00 Usage:\n");
    LazyFrostMage_Msg("   Type /LFM and then the command that you wish to use\n");
    LazyFrostMage_Msg("   /LFM help\n");
	LazyFrostMage_Msg("   /LFM party \n");
    LazyFrostMage_Msg("   /LFM farm\n");
    LazyFrostMage_Msg("   /LFM disable\n");
	LazyFrostMage_Msg("   /LFM action\n");
	LazyFrostMage_Msg("   /LFM debug\n");
end

function LazyFrostMage_Help() 
    LazyFrostMage_Msg("|cffffff00 Debug Mode:\n");
    LazyFrostMage_Msg("   The debug command toggles the debug mode. .\n")

    LazyFrostMage_Msg("|cffffff00 Party mode:\n");
    LazyFrostMage_Msg("   Hold down ALT key when targetting main tank to begin, then when you clicks the button no matter of who you targets it will spam frostbolt on maintanks target if his target is alive and enemy, when out of combat you will automaticly drink and eat if neccesary(hp/mana < 85%), if you are out of water and food, it will conjure more.\n")
	LazyFrostMage_Msg(" when you are done drinking it will automatically stand again and continue to assist Main Tank.\n");
	
    LazyFrostMage_Msg("|cffffff00 Farming mode:\n");
    LazyFrostMage_Msg("   When out of combat: you will activate Arcane Intellect, Frost Armor and Dampen Magic if neccessary, then attempt to eat and drink if neccessary(hp/mana < 85%), if your out of water/food it will craft more.\n")
	LazyFrostMage_Msg(" when your all buffed up, and got all mana and health back it will attempt to stand in case you sits, then target nearest enemy.\n")
	LazyFrostMage_Msg(" Ice barrier or manashield will be cast if neccessary.\n")
	LazyFrostMage_Msg(" when either of those are activated, it will spam forstbolts and recast ice barrier/mana shield if neccessary.\n")
	LazyFrostMage_Msg(" when target hp < 15% it will cast fire blast.\n");
	
    LazyFrostMage_Msg("|cffffff00 Disable:\n");
    LazyFrostMage_Msg("   Disables the function, if you clicks the button it will only attemp to cast frostbolt on target.\n");
   	
	LazyFrostMage_Msg("|cffffff00 To do the actions:\n");
	LazyFrostMage_Msg("  Setup a macro (or you could just type it in chat window each time? >_>), the macro must containt this command: /LFM action \n");
end

function LazyFrostMage_OnEvent()
end