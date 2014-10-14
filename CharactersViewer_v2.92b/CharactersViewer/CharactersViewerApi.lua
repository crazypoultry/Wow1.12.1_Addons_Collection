if ( CharactersViewer.Api == nil ) then
	CharactersViewer.Api = {};
end

CharactersViewer.CP = {};
CharactersViewer.CP.Slot ={"Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Ranged","Tabard"};CharactersViewer.CP.Slot[0]="Ammo";
CharactersViewer.CP.StatsLowerCase ={"strength", "agility", "stamina", "intellect", "spirit"};
CharactersViewer.CP.Stats ={"Strength", "Agility", "Atamina", "Intellect", "Spirit"};
CharactersViewer.CP.ResistLowerCase ={"arcane", "fire", "nature", "frost", "shadow"};

 
CharactersViewer.Api.GetInventoryItem = function ( SlotId, param)
	--[[ Api description
		Required input: 
			SlotId	-> must be numerical, it correspond to the Blizzard SlotId
		Optional input:
			param	-> if set to true, will return full information, else the function will return only the itemLink
	--]]
	
	local temp = {};
	temp["itemLink"] = nil;
	if ( param == nil or param ~= true ) then 
		param = false;
	end
	
	if ( CharactersViewerConfig == nil or CharactersViewerConfig.source == nil or CharactersViewerConfig.source == "CP" ) then
	-- Implement the CharacterProfiler Data return
		if ( myProfile ~= nil
			and CharactersViewer["CP"]["Slot"][SlotId] ~= nil
			and myProfile ~= nil
			and myProfile[CharactersViewer.indexServer] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][SlotId]] ~= nil ) then 
				temp["itemLink"] 		= myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][SlotId]].Item;
				if ( param == true) then 
					temp["itemTexture"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][SlotId]].Texture;
					temp["itemCount"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][SlotId]].Quantity;
					temp["itemColor"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][SlotId]].Color;
					temp["itemName"] 		= myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][SlotId]].Name;
					temp["itemTooltip"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][SlotId]].Tooltip;
				end
		end
	end
	
	-- Output the data according to the desired param
	if ( param == true ) then 
		return temp;
	else
		return temp.itemLink;
	end
end;

CharactersViewer.Api.GetInventorySlot = function ( param )
	--[[ Api description
		Purpose: This function is meant to return the  list of slot with information available for the current selected CV player
		Optional input:
			param	-> not used yet
	--]]
	
	local temp = {};
	local index, i;
	i=0;
	
	if ( param == nil or param ~= true ) then 
		param = false;
	end
	
	-- Implement the CharacterProfiler Data return
	if ( myProfile ~= nil	
		and myProfile[CharactersViewer.indexServer] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"] ~= nil ) then
			for index = 0, 19 do
				if ( CharactersViewer["CP"]["Slot"][index] ~= nil and myProfile[CharactersViewer.indexServer][CharactersViewer.index]["Equipment"][CharactersViewer["CP"]["Slot"][index]] ~= nil ) then 
					temp[i] = index;
					i=i+1;
				end
			end
	end
	return temp;
end;

CharactersViewer.Api.getContainerSize= function (id)
	local section, bag = CharactersViewer.Api.getCPContainer(id);
	if ( myProfile ~= nil
		and myProfile[CharactersViewer.indexServer] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section] ~= nil  
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag] ~= nil ) then
			return  myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Slots	
	--elseif ( id == -2 ) then
	--	return 4;
	else
		return 0;
	end
end

CharactersViewer.Api.getContainerTexture= function (id)
	local section, bag = CharactersViewer.Api.getCPContainer(id);
	if ( myProfile ~= nil
		and myProfile[CharactersViewer.indexServer] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section] ~= nil  
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag] ~= nil ) then
			return  myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Texture	
	else
		return nil;
	end
end

CharactersViewer.Api.getContainerName= function (id)
	local section, bag = CharactersViewer.Api.getCPContainer(id);
	if ( myProfile ~= nil
		and myProfile[CharactersViewer.indexServer] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section] ~= nil  
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag] ~= nil ) then
			return  myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Name;	
	else
		return nil;
	end
end

function CharactersViewer.Api.getContainer(id)
	local section, bag = CharactersViewer.Api.getCPContainer(id);
	if ( myProfile ~= nil
		and myProfile[CharactersViewer.indexServer] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section] ~= nil  
		and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag] ~= nil ) then
			local temp = {};
			temp["itemLink"] 		= myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Item;
			temp["itemTexture"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Texture;
			temp["itemCount"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Quantity;
			temp["itemColor"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Color;
			temp["itemName"] 		= myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Name;
			temp["itemTooltip"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Tooltip;
			temp["itemSlots"] 	= myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag].Slots;
			return temp;
	else
		return nil;
	end
end

CharactersViewer.Api.getContainerItem = function(id, j)
	local section, bag = CharactersViewer.Api.getCPContainer(id);
	local arraytemp = {};
	local array = {}
	if ( bag ~= nil ) then 
		if ( myProfile ~= nil
			and myProfile[CharactersViewer.indexServer] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section] ~= nil  
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag]["Contents"] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag]["Contents"][j] ~= nil ) then
				arraytemp = myProfile[CharactersViewer.indexServer][CharactersViewer.index][section][bag]["Contents"][j];
		else
			return nil;
		end
	else
		if ( myProfile ~= nil
			and myProfile[CharactersViewer.indexServer] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section] ~= nil  
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section]["Contents"] ~= nil
			and myProfile[CharactersViewer.indexServer][CharactersViewer.index][section]["Contents"][j] ~= nil ) then
				arraytemp = myProfile[CharactersViewer.indexServer][CharactersViewer.index][section]["Contents"][j];
		else
			return nil;
		end
	end

	array.Texture = arraytemp["Texture"];
	array.Quantity = arraytemp.Quantity;
	array.Size = arraytemp.Slots;
	array.Name = arraytemp.Name;
	array.Color = arraytemp.Color;
	array.Tooltip = arraytemp.Tooltip;
	array.itemLink = arraytemp.Item;

	return array;
end;

CharactersViewer.Api.getCPContainer = function (id)
	local section, bag;
	if ( id == -2 ) then
		section = "Inventory";
		bag = "Bag" .. tostring(5);
	elseif ( id >= 0 and id <= 4 ) then
		section = "Inventory";
		bag = "Bag" .. tostring(id);
	elseif (id >= 5 and id <= 10) then
		section = "Bank";
		bag = "Bag" .. tostring(id-4)
	elseif (id == 19 ) then
		section = "Bank";
		bag = nil;
	end
	return section, bag;
end

CharactersViewer.Api.splitstring = function ( input )                      -- CharactersViewer.library.splitstrin
	 local list = {};
	 local i = 0;
	 for w in string.gfind(input, "([^ ]+)") do
		  list[i] = w;
		  i = i + 1;
	 end
	 return list
end;

CharactersViewer.Api.splitstats = function ( input )
	if ( input ~= nil ) then
		local list = {};
		local i = 0;
		for w in string.gfind(input, "(%d+)") do
		  list[i] = tonumber(w);
		  i = i + 1;
		end
		return list[0], list[1], list[2], list[3], list[4];
	else
		return 0,0,0,0,0;
	end
end;

CharactersViewer.Api.MakeLink = function(link)                               -- CharactersViewer.library.MakeLink
	local temp = link;
	if( link and string.sub(link,1,5) == "item:") then
		local name,_,quality = GetItemInfo(link);
		local color = CharactersViewer.Api.returnColor(quality);
		if(name) then
			temp = "|c"..color.."|H"..link.."|h["..name.."]|h|r";
		else
			temp = false;
		end
	end
	return temp;
end;

CharactersViewer.Api.returnColor = function (quality)                        -- CharactersViewer.library.returnColor
	color = {
		[0] = "ff9d9d9d",    -- poor, gray
		[1] = "ffffffff",    -- common, white
		[2] = "ff1eff00",    -- uncommon, green
		[3] = "ff0070dd",    -- rare, blue
		[4] = "ffa335ee",    -- epic, purple
		[5] = "ffff8000",    -- legendary, orange
	}
	return color[quality];
end;

CharactersViewer.gui = {};
CharactersViewer.gui.ItemButton = {};
CharactersViewer.gui.ItemButton.OnClick = function (button)
	rpgoCP_EventHandler('RPGOCP_SCAN');
	local id, item, link, longlink;
	id = this:GetID();
	
	if(id >= 0 and id <= 19) then
		-- Equipement slot
		item = CharactersViewer.Api.GetInventoryItem( id, true );
	elseif ( ( id > -100 and id < 0 ) or  (id >=100 and id <=599 ) or (id >= 600 and id <= 1199) or ( id >= 2000 and id < 2100 ) ) then
		local Slot, Container = CharactersViewer.Api.ContainerSlotFromId( id );
		item = CharactersViewer.Api.getContainerItem  ( Container,  Slot);
	end
	
	if( item ~= nil and item["itemLink"] ) then
		link = item["itemLink"];
		longlink = CharactersViewer.Api.MakeLink( "item:"..link )
	
		if ( button == "LeftButton" ) then
			if ( IsControlKeyDown() and not ignoreModifiers ) then
				DressUpItemLink("item:"..link);
			elseif ( IsShiftKeyDown() and not ignoreModifiers ) then
				if ( ChatFrameEditBox:IsShown() ) then
					ChatFrameEditBox:Insert(longlink);
				else
					-- PlaceHolder
				end
			else
				-- PlaceHolder
			end
		end	
		
		-- Component interaction, http://www.curse-gaming.com/mod.php?addid=1256, added by Flisher 2005-06-16
		-- CharactersViewerItemButton_OnClick must be kept in backtracking ability CharactersViewer.button.onclick();
		if(Comp_TestOnClick and Comp_TestOnClick() and link) then
			return Comp_OnClick(arg1, link);
		end
	end
end;


function CharactersViewer.gui.ItemButton.OnEnter(tooltip, id)                        -- Cleaned by Flisher 2005-05-31
	--rpgoCP_EventHandler('RPGOCP_SCAN');
	local item, link, text, flag
	-- Detecting if it's from the inventory or equipment
	text = UNKNOWN;
	if ( id == nil ) then
		id = this:GetID();
		flag = true;
	else
		flag = false;
	end
	if ( tooltip == nil ) then
		tooltip = getglobal("GameTooltip");
	end
		
	if(id >= 0 and id <= 19) then
		-- Equipement slot
		item = CharactersViewer.Api.GetInventoryItem( id, true );
		text = CharactersViewer.constant.inventorySlot.Name[id];
	elseif ( ( id > -100 and id < 0 ) or  (id >=100 and id <=599 ) or (id >= 600 and id <= 1199) or ( id >= 2000 and id < 2100 ) ) then
		local Slot, Container = CharactersViewer.Api.ContainerSlotFromId( id );
		item = CharactersViewer.Api.getContainerItem  ( Container,  Slot);
		if ( item == nil ) then
			text = EMPTY;
		end
	end

	---- todo: Regenate full link
	if ( flag == true ) then
		ShowUIPanel(tooltip);
		tooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	
	if( item ~= nil and item["itemLink"] ) then
		if( GetItemInfo("item:" .. item["itemLink"]) ) then
			tooltip:SetHyperlink("item:" .. item["itemLink"]);
		else
		tooltip:SetText(item["itemTooltip"]);
		end
	else
		tooltip:SetText(text);
	end

	if ( CharactersViewer.index ~= nil and CharactersViewer.index ~= UnitName("player") and CharactersViewer.indexServer ~= nil and CharactersViewer.indexServer ~= GetRealmName()) then
		tooltip:AddLine(CharactersViewer.index .. " " .. INVENTORY_TOOLTIP);
		tooltip:Show();
	else
		tooltip:Show();
	end

	-- Book of Crafts inter-operability (http://www.curse-gaming.com/mod.php?addid=1397)
	if(BookOfCrafts_UpdateGameToolTips and link) then
		BookOfCrafts_UpdateGameToolTips();
	end
	-- Receipe Book inter-operability (http://www.curse-gaming.com/mod.php?addid=914)
	if( RecipeBook_DoHookedFunction and link) then
		RecipeBook_DoHookedFunction();
	end
	
end;

CharactersViewer.Api.GetParam = function (param, character, server)
	if ( character == nil ) then
		character = CharactersViewer.index;
	end
	if ( server == nil ) then
		server = CharactersViewer.indexServer;
	end

	if ( myProfile ~= nil and myProfile[server] ~= nil and myProfile[server][character] ~= nil ) then
		if ( param == "level" ) then
			return tostring( myProfile[server][character].Level);
		elseif ( param == "name" ) then
			return tostring( myProfile[server][character].Name);
		elseif ( param == "server" ) then
			return tostring( myProfile[server][character].Server);
		elseif ( param == "class" ) then	
			return tostring( myProfile[server][character].Class);
		elseif ( param == "race" ) then	
			return tostring( myProfile[server][character].Race);
		elseif ( param == "raceen" ) then	
			return tostring( myProfile[server][character].RaceEn);
		elseif ( param == "sex" ) then	
			return tostring( myProfile[server][character].Sex);
		elseif ( param == "sexid" ) then	
			return tonumber( myProfile[server][character].SexId) or 0;
		
		elseif ( param == "isresting" ) then	
			return myProfile[server][character].IsResting;

		elseif ( param == "xptimestamp" ) then	
			if ( myProfile[server][character].timestamp ~= nil and myProfile[server][character].timestamp.Stats ~= nil ) then
				return myProfile[server][character].timestamp.Stats;
			else
				return nil;
			end

		elseif ( param == "xp" ) then	
			return myProfile[server][character].XP;

		elseif ( param == "health" ) then
			return tostring( myProfile[server][character].Health);
		elseif ( param == "mana" ) then
			return tostring( myProfile[server][character].Mana);
		elseif ( param == "powertype" ) then
			return tostring( myProfile[server][character].Power);		

		elseif ( param == "crit" ) then
			return myProfile[server][character].CritPercent;		
		elseif ( param == "block" ) then
			return myProfile[server][character].BlockPercent;		
		elseif ( param == "dodge" ) then
			return myProfile[server][character].DodgePercent;		
		elseif ( param == "parry" ) then
			return myProfile[server][character].ParryPercent;		
		elseif ( param == "defense" ) then
			return myProfile[server][character].Defense;		

		elseif ( param == "money" ) then
			if ( myProfile[server][character].Money ) then
				local temp = 0;
				if ( myProfile [server][character].Money.Copper ) then
					temp = temp + myProfile[server][character].Money.Copper;
				end
				if ( myProfile [server][character].Money.Silver ) then
					temp = temp + myProfile[server][character].Money.Silver * 100;
				end
				if ( myProfile [server][character].Money.Gold ) then
					temp = temp + myProfile[server][character].Money.Gold * 10000;
				end
				return temp;
			else
				return 0;
			end
		elseif ( param == "splitmoney" ) then
			local gold = 0;
			local copper = 0;
			local silver = 0;
			if ( myProfile[server][character].Money ) then
				if ( myProfile [server][character].Money.Copper ) then
					copper = myProfile[server][character].Money.Copper;
				end
				if ( myProfile [server][character].Money.Silver ) then
					silver = myProfile[server][character].Money.Silver;
				end
				if ( myProfile [server][character].Money.Gold ) then
					gold = myProfile[server][character].Money.Gold;
				end
			end
				return gold, silver, copper;

		elseif ( param == "alliancemoney" ) then
			local temp = 0;
			for index, character in  myProfile[server] do
				if ( character.FactionEn ~= nil and character.FactionEn == "Alliance" and character.Money ~= nil) then
					if ( character.Money.Copper ) then
						temp = temp + character.Money.Copper;
					end
					if ( character.Money.Silver ) then
						temp = temp + character.Money.Silver * 100;
					end
					if ( character.Money.Gold ) then
						temp = temp + character.Money.Gold * 10000;
					end	
				end
			end		
			return temp;	

		elseif ( param == "hordemoney" ) then
			local temp = 0;
			for index, character in  myProfile[server] do
				if ( character.FactionEn ~= nil and character.FactionEn == "Horde" and character.Money ~= nil) then
					if ( character.Money.Copper ) then
						temp = temp + character.Money.Copper;
					end
					if ( character.Money.Silver ) then
						temp = temp + character.Money.Silver * 100;
					end
					if ( character.Money.Gold ) then
						temp = temp + character.Money.Gold * 10000;
					end	
				end
			end		
			return temp;
	
		elseif ( param == "servermoney" ) then
			return CharactersViewer.Api.GetParam("alliancemoney") + CharactersViewer.Api.GetParam("hordemoney");
			
		elseif ( param == "faction" ) then
			return myProfile[server][character].Faction;		
		elseif ( param == "factionEn" ) then
			return myProfile[server][character].Faction;		
				
		elseif ( param == "strength" ) then
			return myProfile[server][character]["Stats"].Strength;
		elseif ( param == "agility" ) then
			return myProfile[server][character]["Stats"].Agility;
		elseif ( param == "stamina" ) then
			return myProfile[server][character]["Stats"].Stamina;
		elseif ( param == "intellect" ) then
			return myProfile[server][character]["Stats"].Intellect;
		elseif ( param == "spirit" ) then
			return myProfile[server][character]["Stats"].Spirit	;
		
		elseif ( param == "armor" ) then
			return myProfile[server][character].Armor;

		elseif ( param == "guildname" ) then		
			if ( myProfile[server][character]["Guild"] ~= nil ) then
				return myProfile[server][character]["Guild"].GuildName;
			end
		elseif ( param == "guildrank" ) then				
			if ( myProfile[server][character]["Guild"] ~= nil ) then
				return myProfile[server][character]["Guild"].Rank;
			end
		elseif ( param == "guildtitle" ) then				
			if ( myProfile[server][character]["Guild"] ~= nil ) then
				return myProfile[server][character]["Guild"].Title;
			end
		
		elseif ( param == "pvprank" ) then				
			if ( myProfile[server][character]["Honor"] ~= nil and myProfile[server][character]["Honor"].Current ~= nil ) then
				return myProfile[server][character]["Honor"].Current.Rank or "";
			else
				return "";
			end
		elseif ( param == "hk" ) then				
			if ( myProfile[server][character]["Honor"] ~= nil) then
				return myProfile[server][character]["Honor"].LifetimeHK or "";
			else
				return 0;
			end
		elseif ( param == "dk" ) then				
			if ( myProfile[server][character]["Honor"] ~= nil) then
				return myProfile[server][character]["Honor"].LifetimeDK or "";
			else
				return 0;
			end
		elseif ( param == "weekhk" ) then				
			if ( myProfile[server][character]["Honor"] ~= nil and myProfile[server][character]["Honor"]["ThisWeek"] ~= nil) then
				return myProfile[server][character]["Honor"]["ThisWeek"].HK or 0;
			else
				return 0;
			end
		elseif ( param == "weekcontrib" ) then				
			if ( myProfile[server][character]["Honor"] ~= nil and myProfile[server][character]["Honor"]["ThisWeek"] ~= nil) then
				return myProfile[server][character]["Honor"]["ThisWeek"].Contribution or 0;
			else
				return 0;
			end
			


		elseif ( param == "resistfrost" ) then				
			return myProfile[server][character]["Resists"].Frost;
		elseif ( param == "resistfire" ) then				
			return myProfile[server][character]["Resists"].Fire;
		elseif ( param == "resistnature" ) then			
			return myProfile[server][character]["Resists"].Nature;
		elseif ( param == "resistshadow" ) then			
			return myProfile[server][character]["Resists"].Shadow;
		elseif ( param == "resistarcane" ) then			
			return myProfile[server][character]["Resists"].Arcane;

		elseif ( param == "damagerange1" ) then			
			if ( myProfile[server][character]["Melee Attack"] ~= nil) then
				return myProfile[server][character]["Melee Attack"].DamageRangeBase;
			end
		elseif ( param == "damagerange2" ) then			
			if ( myProfile[server][character]["Melee Attack"] ~= nil) then
				return myProfile[server][character]["Melee Attack"].DamageRange2;
			end 
			
		elseif ( param == "attackspeed1" ) then			
			if ( myProfile[server][character]["Melee Attack"] ~= nil) then
				return myProfile[server][character]["Melee Attack"].AttackSpeed;
			end
		elseif ( param == "attackspeed2" ) then			
			if ( myProfile[server][character]["Melee Attack"] ~= nil) then
				return myProfile[server][character]["Melee Attack"].AttackSpeed2;
			end
		elseif ( param == "attackpower" ) then			
			if ( myProfile[server][character]["Melee Attack"] ~= nil) then
				return myProfile[server][character]["Melee Attack"].AttackPower2;
			end

		elseif ( param == "hasrelic" ) then			
			return myProfile[server][character].HasRelic;
		
		elseif ( param == "rangeddamage" ) then			
			if ( myProfile[server][character]["Ranged Attack"] ~= nil) then
				return myProfile[server][character]["Ranged Attack"].DamageRangeBase;
			end	
		elseif ( param == "rangedattackrating" ) then			
			if ( myProfile[server][character]["Ranged Attack"] ~= nil) then
				return myProfile[server][character]["Ranged Attack"].AttackRating;
			end	
		elseif ( param == "rangedattackspeed" ) then			
			if ( myProfile[server][character]["Ranged Attack"] ~= nil) then
				return myProfile[server][character]["Ranged Attack"].AttackSpeed;
			end
		elseif ( param == "rangedttackpower" ) then			
			if ( myProfile[server][character]["Ranged Attack"] ~= nil) then
				return myProfile[server][character]["Ranged Attack"].AttackPower;
			end
		elseif ( param == "haswandequipped" ) then
			return myProfile[server][character].HasWandEquipped;
		elseif ( param == "hasranged" ) then
			return myProfile[server][character]["Ranged Attack"] ~= nil or false;
		elseif ( param == "location" ) then			
			local temp = "";
			if ( myProfile[server][character].SubZone ~= nil) then
				temp = " (" .. myProfile[server][character].SubZone .. ")";
			end
			if ( myProfile[server][character].Zone ~= nil) then
				temp = myProfile[server][character].Zone .. temp;
			end
			return temp;
		
		elseif ( param == "bankexist" ) then
			if (myProfile[server][character].Bank ~= nil ) then
				return true;
			else
				return false;
			end
		elseif (param == "banktimestamp" ) then
			if (myProfile[server][character].timestamp ~= nil and myProfile[server][character].timestamp.Bank ~= nil) then
				return date("!%m/%d/%y %H:%M:%S", myProfile[server][character].timestamp.Bank);
			else
				return "";
			end
		else 
			return "N/A";
		end
	end

end;

CharactersViewer.Api.ContainerSlotFromId = function( id )
		return mod(id+100,100) , floor((id-100)/100) ;
end;

function CharactersViewer.Api.CalcRestedXP(data, isresting, timestamp)
	 local temp = {
		  estimated = 0;
		  levelratio = 0;
		  percentrested = 0;
	 }
	 local current,level,bonus;
	 
	 _,_,current,level,bonus = string.find(data,"(%d+):(%d+):(%d+)");
	 	 
	 if(data and bonus and isresting ~= nil and level and timestamp) then
		  local speed = isresting and 4 or 1;
		  local estimated = bonus;
		  if(timestamp < time()) then
				estimated = bonus + floor((time()-timestamp) * level * 1.5 / 864000 / 4 * speed);
				if(estimated  > (level * 1.5) ) then
					 estimated = (level * 1.5);
				end
		  end
		  temp = {
				estimated = estimated;
				levelratio = floor(estimated/level *10)/10;
				percentrested = floor(estimated / (level  *1.5) *100)/100;
		  }
	 end
	 return temp;
end;

function CharactersViewer.Api.GetConfig(param)
	if ( CharactersViewerConfig ~= nil and param ~= nil) then
		return CharactersViewerConfig[param];
	else
		return nil;
	end
end

function CharactersViewer.Api.SetConfig(param, value)
	if ( CharactersViewerConfig == nil ) then
		CharactersViewerConfig = {};
	end
	CharactersViewerConfig[param] = value; 
end
				
--function CharactersViewer.Api.GetCharactersList(option)			-> In CharactersViewer.lua

-- Legacy Support
CharactersViewer.Switch = CharactersViewer.Api.Switch;
CharactersViewerItemButton_OnClick = CharactersViewer.gui.ItemButton.OnClick;
CharactersViewer_Tooltip_SetInventoryItem = CharactersViewer.gui.ItemButton.OnEnter;
