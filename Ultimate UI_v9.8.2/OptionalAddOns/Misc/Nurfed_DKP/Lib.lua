
if (not Nurfed_DKP) then

	local dkpvalues = Nurfed_DKPValues;

	Nurfed_DKP = {};

	Nurfed_DKP.sortvar = "dkp";
	Nurfed_DKP.sortdir = ">";

	Nurfed_DKP.lootcolor = {
		[2] = "ff1eff00",
		[3] = "ff0070dd",
		[4] = "ffa335ee",
		[5] = "ffff8000",
	};

	Nurfed_DKP.display = {};
	Nurfed_DKP.displayloot = {};
	Nurfed_DKP.displayrolls = {};

	function Nurfed_DKP:New()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_DKP:AddDKP(tooltip)
		if (not tooltip) then
			tooltip = "GameTooltip";
		end

		local text = getglobal (tooltip.."TextLeft1"):GetText();
		if (text == nil) then
			return;
		end
		local dkp, secondary = self:GetDKP(tooltip);

		tooltip = getglobal(tooltip);

		if (dkp and dkp > 0) then
			dkp = dkp * 10;
			dkp = "DKP Value: "..format("%.3f", dkp);
			tooltip:AddLine("\n"..dkp, 1.0, 1.0, 0.0);
		end

		if (secondary and secondary > 0) then
			secondary = "Secondary Value: "..format("%.3f", secondary);
			tooltip:AddLine(secondary, 0.0, 1.0, 1.0);
		end

		tooltip_updated = true;
		tooltip:Show();
	end

	function Nurfed_DKP:findpattern(text, pattern, start)
		return string.sub(text, string.find(text, pattern, start));
	end;

	function Nurfed_DKP:WeighStat(string, stat, weight)
		local num = 0;
		if (strfind(string, stat) ~= nil) then
			local value = strfind(string, "%d+");
			if (value ~= nil) then
				value = self:findpattern(string, "(%d+)");
				num = num + (value * weight);
				--DEFAULT_CHAT_FRAME:AddMessage("Stat: "..string.." Amount: "..num);
			end
		end
		return num;
	end;

	function Nurfed_DKP:GetWeight(weight, playerclass)
		if (dkpvalues.class[playerclass][weight]) then
			return dkpvalues.class[playerclass][weight];
		else
			return 0;
		end
	end

	function Nurfed_DKP:GetDKP(tooltip)
		local itemname = getglobal (tooltip.."TextLeft1"):GetText();
		if (dkpvalues.static[itemname]) then
			return dkpvalues.static[itemname];
		end

		local DKP = 0;
		local Secondary = 0;
		local DKPValues = {};
		DKPValues.Multi = 1;

		local comptable = {};
		local priest = 0;
		local druid = 0;
		local rogue = 0;
		local shaman = 0;
		local paladin = 0;
		local hunter = 0;
		local warrior = 0;
		local index = 2;
		local rtext;
		local ltext = getglobal (tooltip.."TextLeft"..index):GetText();
		while (ltext) do
			--Detect Class Restriction
			if (not DKPValues.class) then
				for class in string.gfind(ltext, "Classes: (.+)") do
					if (class and dkpvalues.class[class]) then
						DKPValues.class = class;
					end
				end
			end

			--Detect Weapon
			if (not DKPValues.weapon) then
				if (dkpvalues.weapons[ltext]) then
					DKPValues.weapon = ltext;
					if (getglobal(tooltip.."TextRight"..index):GetText()) then
						DKPValues.weapontype = getglobal(tooltip.."TextRight"..index):GetText();
					end
				end
			end

			--Detect Low and Top end
			if (not DKPValues.low) then
				for low, top in string.gfind(ltext, "(%d+) %- (%d+) Damage") do
					if (low) then
						DKPValues.low = low;
					end
					if (top) then
						DKPValues.top = top;
					end
				end
			end

			--Detect Armor Type
			if (not DKPValues.armortype) then
				if (dkpvalues.armor[ltext]) then
					if (getglobal(tooltip.."TextRight"..index):GetText()) then
						DKPValues.armortype = getglobal(tooltip.."TextRight"..index):GetText();
					end
				end
			end

			--Detect Speed
			if (not DKPValues.speed) then
				rtext = getglobal (tooltip.."TextRight"..index):GetText();
				if (rtext) then
					for speed in string.gfind(rtext, "Speed (%d+.%d+)") do
						if (speed) then
							DKPValues.speed = speed;
						end
					end
				end
			end

			--Detect Armor
			if (not DKPValues.armor and (DKPValues.weapontype == "Shield")) then
				for armor in string.gfind(ltext, "(%d+) Armor") do
					DKPValues.armor = armor;
				end
			end

			--Detect Caster Weapon
			if (not DKPValues.casterweapon) then
				for _, stat in dkpvalues.caster do
					if (strfind(ltext, stat) ~= nil) then
						DKPValues.casterweapon = true;
					end
				end
			end

			if (strfind(ltext, "DKP Value: (%d+)")) then
				return;
			end

			index = index + 1;
			ltext = getglobal (tooltip.."TextLeft"..index):GetText();
		end

		index = 2;
		ltext = getglobal (tooltip.."TextLeft"..index):GetText();
		while (ltext) do
			if (DKPValues.class) then
				for k,v in dkpvalues.stats do
					DKP = DKP + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, DKPValues.class));
				end
			else
				for k,v in dkpvalues.stats do
					priest = priest + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, "Priest"));
					druid = druid + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, "Druid"));
					rogue = rogue + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, "Rogue"));
					shaman = shaman + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, "Shaman"));
					paladin = paladin + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, "Paladin"));
					hunter = hunter + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, "Hunter"));
					warrior = warrior + self:WeighStat(ltext, v.list, self:GetWeight(v.stat, "Warrior"));
				end
			end
			index = index + 1;
			ltext = getglobal (tooltip.."TextLeft"..index):GetText();
		end

		if (DKPValues.weapon and DKPValues.weapon ~= "Wand" and DKPValues.low) then
			local weaponweight, sub;
			local dps = ((DKPValues.low + DKPValues.top) / 2) / DKPValues.speed;
			local weapon = DKPValues.weapon;
			local weapontype = DKPValues.weapontype;

			--Hybrid Weapons
			if (DKPValues.casterweapon and (weapon == "Two-Hand")) then
				if (dkpvalues.hybridweap[weapon][weapontype]) then
					weaponweight = (DKPValues.top * dkpvalues.hybridweap[weapon][weapontype].top) + (dps * dkpvalues.hybridweap[weapon][weapontype].dps);
					sub = dkpvalues.hybridweap[weapon][weapontype].sub;
					DKPValues.WeaponDKP = ((weaponweight - sub) * 2) * 0.35;
					DKPValues.HybridWeapon = true;
				end
			end

			--Warrior/Rogue Weapons
			if (not DKPValues.casterweapon and dkpvalues.warweap[weapon] and dkpvalues.warweap[weapon][weapontype]) then
				weaponweight = (DKPValues.top * dkpvalues.warweap[weapon][weapontype].top) + (dps * dkpvalues.warweap[weapon][weapontype].dps);
				sub = dkpvalues.warweap[weapon][weapontype].sub;
				DKPValues.WarriorWeaponDKP = weaponweight - sub;
				if (weapon == "Two-Hand") then
					DKPValues.WarriorWeaponDKP = DKPValues.WarriorWeaponDKP * 2;
				end

				if (dkpvalues.rogueweap[weapon] and dkpvalues.rogueweap[weapon][weapontype]) then
					weaponweight = (DKPValues.top * dkpvalues.rogueweap[weapon][weapontype].top) + (dps * dkpvalues.rogueweap[weapon][weapontype].dps);
					sub = dkpvalues.rogueweap[weapon][weapontype].sub;
					DKPValues.RogueWeaponDKP = weaponweight - sub;
				end

				if (dkpvalues.hybridweap[weapon] and dkpvalues.hybridweap[weapon][weapontype]) then
					weaponweight = (DKPValues.top * dkpvalues.hybridweap[weapon][weapontype].top) + (dps * dkpvalues.hybridweap[weapon][weapontype].dps);
					sub = dkpvalues.hybridweap[weapon][weapontype].sub;
					DKPValues.HybridWeaponDKP = weaponweight - sub;
					if (weapon == "Two-Hand") then
						DKPValues.HybridWeaponDKP = DKPValues.HybridWeaponDKP * 2;
					end
				end

				if (dkpvalues.hunterweap[weapon] and dkpvalues.hunterweap[weapon][weapontype]) then
					weaponweight = dps * dkpvalues.hunterweap[weapon][weapontype].dps;
					sub = dkpvalues.hunterweap[weapon][weapontype].sub;
					DKPValues.HunterWeaponDKP = weaponweight - sub;
					if (weapon == "Two-Hand") then
						DKPValues.HunterWeaponDKP = DKPValues.HunterWeaponDKP * 2;
					end
				end
			end

			--Ranged Weapons
			if (dkpvalues.rangedweap[weapon]) then
				weaponweight = (DKPValues.top * dkpvalues.rangedweap[weapon].top) + (dps * dkpvalues.rangedweap[weapon].dps);
				sub = dkpvalues.rangedweap[weapon].sub;
				DKPValues.WeaponDKP = weaponweight - sub;
				DKPValues.RangedWeapon = true;

				weaponweight = dps * dkpvalues.rangedmelee[weapon].dps;
				sub = dkpvalues.rangedmelee[weapon].sub;
				DKPValues.SecondaryWeaponDKP = (weaponweight - sub) * .35;
				if (rogue > warrior) then
					DKPValues.SecondaryWeaponDKP = DKPValues.SecondaryWeaponDKP + rogue;
				else
					DKPValues.SecondaryWeaponDKP = DKPValues.SecondaryWeaponDKP + warrior;
				end
			end
			if (dkpvalues.rangedweap[weapontype]) then
				weaponweight = (DKPValues.top * dkpvalues.rangedweap[weapontype].top) + (dps * dkpvalues.rangedweap[weapontype].dps);
				sub = dkpvalues.rangedweap[weapontype].sub;
				DKPValues.WeaponDKP = weaponweight - sub;
				DKPValues.RangedWeapon = true;

				weaponweight = dps * dkpvalues.rangedmelee[weapontype].dps;
				sub = dkpvalues.rangedmelee[weapontype].sub;
				DKPValues.SecondaryWeaponDKP = (weaponweight - sub) * .35;
				if (rogue > warrior) then
					DKPValues.SecondaryWeaponDKP = DKPValues.SecondaryWeaponDKP + rogue;
				else
					DKPValues.SecondaryWeaponDKP = DKPValues.SecondaryWeaponDKP + warrior;
				end
			end
		end

		if (DKPValues.RogueWeaponDKP and DKPValues.RogueWeaponDKP > DKPValues.WarriorWeaponDKP) then
			DKPValues.WeaponDKP = DKPValues.RogueWeaponDKP;
		elseif (DKPValues.WarriorWeaponDKP) then
			DKPValues.WeaponDKP = DKPValues.WarriorWeaponDKP;
			if (not DKPValues.RogueWeaponDKP) then
				rogue = 0;
			end
		end

		--Find Highest DKP Value
		if (not DKPValues.class) then
			if (DKPValues.armortype == "Cloth") then
				table.insert(comptable, priest);
			elseif (DKPValues.armortype == "Leather") then
				table.insert(comptable, druid);
				table.insert(comptable, rogue);
			elseif (DKPValues.armortype == "Mail") then
				table.insert(comptable, shaman);
				table.insert(comptable, hunter);
			elseif (DKPValues.armortype == "Plate") then
				table.insert(comptable, paladin);
				table.insert(comptable, warrior);
			elseif (DKPValues.HybridWeapon) then
				table.insert(comptable, shaman);
			elseif (DKPValues.weapon == "Wand") then
				table.insert(comptable, priest);
			elseif (DKPValues.RangedWeapon) then
				table.insert(comptable, hunter);
			elseif (DKPValues.WeaponDKP) then
				table.insert(comptable, warrior);
				table.insert(comptable, rogue);
			elseif (DKPValues.armor) then
				table.insert(comptable, warrior);
				table.insert(comptable, shaman);
			else
				table.insert(comptable, priest);
				table.insert(comptable, druid);
				table.insert(comptable, rogue);
				table.insert(comptable, shaman);
				table.insert(comptable, hunter);
				table.insert(comptable, paladin);
				table.insert(comptable, warrior);
			end

			table.sort(comptable, function(x, y) return x > y end);
			DKP = comptable[1];
		end

		if (DKPValues.armor) then
			local ac = 2379 + DKPValues.armor;
			local miti = ac / (ac + 5500);
			miti = miti - 0.45;
			miti = miti * 100;
			DKP = DKP + miti;
		end

		if (dkpvalues.multi[itemname]) then
			if (DKPValues.WeaponDKP) then
				DKPValues.WeaponDKP = DKPValues.WeaponDKP * dkpvalues.multi[itemname];
				DKPValues.Multi = dkpvalues.multi[itemname];
			else
				DKP = DKP * dkpvalues.multi[itemname];
			end
		end

		if (DKPValues.HybridWeaponDKP and DKPValues.HunterWeaponDKP) then
			DKPValues.HybridWeaponDKP = ((DKPValues.HybridWeaponDKP * DKPValues.Multi) * .35) + shaman;
			DKPValues.HunterWeaponDKP = ((DKPValues.HunterWeaponDKP * DKPValues.Multi) * .35) + hunter;
			if (DKPValues.HybridWeaponDKP > DKPValues.HunterWeaponDKP) then
				DKPValues.SecondaryWeaponDKP = DKPValues.HybridWeaponDKP;
			else
				DKPValues.SecondaryWeaponDKP = DKPValues.HunterWeaponDKP;
			end
		elseif (DKPValues.HybridWeaponDKP and not DKPValues.HunterWeaponDKP) then
			DKPValues.SecondaryWeaponDKP = ((DKPValues.HybridWeaponDKP * DKPValues.Multi) * .35) + shaman;
		elseif (DKPValues.HunterWeaponDKP and not DKPValues.HybridWeaponDKP) then
			DKPValues.SecondaryWeaponDKP = ((DKPValues.HunterWeaponDKP * DKPValues.Multi) * .35) + hunter;
		end

		if (DKPValues.SecondaryWeaponDKP) then
			Secondary = DKPValues.SecondaryWeaponDKP;
		end

		if (DKPValues.WeaponDKP) then
			DKP = DKP + DKPValues.WeaponDKP;
		end

		if (Secondary > DKP) then
			DKP = Secondary;
			Secondary = 0;
		end

		return DKP, Secondary;
	end

	function Nurfed_DKP:ItemInfo(link)
		local _, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
		local itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(id);
		local info = {};

		if (itemRarity > 1) then
			info.id = id;
			info.name = name;
			info.link = itemLink;
			info.rarity = itemRarity;
			info.icon = itemTexture;
			info.dkp = 0;
			info.secdkp = 0;

			Nurfed_DKPToolTip:SetHyperlink(itemLink);

			local dkp, secondary = self:GetDKP("Nurfed_DKPToolTip");

			if (dkp and dkp > 0) then
				info.dkp = format("%.3f", dkp);
			end

			if (secondary and secondary > 0) then
				info.secdkp = format("%.3f", secondary);
			end

			return info;
		end
		return nil;
	end

	function Nurfed_DKP:CheckName(name, tablename)
		local i;
		for i = 1, table.getn(tablename) do
			if (tablename[i].name == name) then
				return i;
			end
		end
		return nil;
	end

	function Nurfed_DKP:DisplayRoll(name, roll)
		local index = self:CheckName(name, self.displayrolls);
		if (index == nil) then
			local info = {
				name = name,
				roll = roll,
			};
			table.insert(self.displayrolls, info);
		end
		table.sort(self.displayrolls, function(x, y) return x.roll > y.roll end);
		self:UpdateRollDisplay();
		Nurfed_DKPPlayerScrollUpdate();
	end

	function Nurfed_DKP:UpdateRollDisplay()
		local row, namerow, rollrow, info;
		for i = 1, 10 do
			info = self.displayrolls[i];
			row = getglobal("Nurfed_DKPRollFrameRoll"..i);
			if (info) then
				namerow = getglobal("Nurfed_DKPRollFrameRoll"..i.."Name");
				rollrow = getglobal("Nurfed_DKPRollFrameRoll"..i.."Roll");
				namerow:SetText(info.name);
				rollrow:SetText(info.roll);
				row:Show();
			else
				row:Hide();
			end
		end
	end

	function Nurfed_DKP:ClearRolls()
		self.displayrolls = nil;
		self.displayrolls = {};
		self:UpdateRollDisplay();
		Nurfed_DKPPlayerScrollUpdate();
	end

	function Nurfed_DKP:ClearLoot()
		NURFED_SAVED_DKPLOOT = nil;
		NURFED_SAVED_DKPLOOT = {};
	end

	function Nurfed_DKP:GetClass(player)
		local num = GetNumRaidMembers();
		local name, subgroup, class;
		for i=1, num do
			name, _, _, _, class, _, _, _, _ = GetRaidRosterInfo(i);
			if (name == player) then
				return class;
			end
		end
		return "Priest";
	end

	function Nurfed_DKP:DisplayPlayer(var, name, down)
		local info;
		if (var == "chat" and name) then
			name = string.lower(name);
			name = string.gsub(name, "^%l", string.upper);
			local index = self:CheckName(name, self.display);
			if (index == nil) then
				if (NurfedDKPPlayers[name]) then
					local player = NurfedDKPPlayers[name];
					info = {
						rank = player.rank,
						name = name,
						dkp = player.dkp,
						class = player.class,
						att = player.att,
					};
				else
					info = {
						name = name,
						dkp = 0,
						class = self:GetClass(name),
						att = 0,
					};
				end
				if (info) then
					if (down) then
						info.down = true;
					end
					table.insert(self.display, info);
				end
			else
				if (down) then
					self.display[index].down = true;
				else
					self.display[index].down = nil;
				end
			end
		elseif (var == "input") then
			if (name) then
				name = string.lower(name);
			end
			for k, v in NurfedDKPPlayers do
				if (k ~= "raids") then
					info = {
						rank = v.rank,
						name = k,
						dkp = v.dkp,
						class = v.class,
						att = v.att,
					};
					local index = self:CheckName(info.name, self.display);
					if (index == nil) then
						if (name) then
							if (string.find(string.lower(info.name), name) or string.find(string.lower(info.class), name)) then
								table.insert(self.display, info);
							end
						else
							table.insert(self.display, info);
						end
					end
				end
			end
		end
		table.sort(self.display, function(x, y)
						if (self.sortdir == ">") then
							return x[self.sortvar] > y[self.sortvar];
						else
							return x[self.sortvar] < y[self.sortvar];
						end
					end);
		Nurfed_DKPPlayerScrollUpdate();
	end

	function Nurfed_DKP:GetRoll(name)
		for k, v in self.displayrolls do
			if (name == v.name) then
				return v.roll;
			end
		end
		return nil;
	end

	function Nurfed_DKP:UpdateList(offset, max_line)
		for row=1,8 do
			local line = row + offset;
			local playerrow = getglobal("Nurfed_DKPPlayerFrameRows"..row);
			if (line <= max_line) then
				local rank = getglobal("Nurfed_DKPPlayerFrameRows"..row.."FieldRank");
				local name = getglobal("Nurfed_DKPPlayerFrameRows"..row.."FieldName");
				local roll = getglobal("Nurfed_DKPPlayerFrameRows"..row.."FieldRoll");
				local dkp = getglobal("Nurfed_DKPPlayerFrameRows"..row.."FieldDKP");
				local class = getglobal("Nurfed_DKPPlayerFrameRows"..row.."FieldClass");
				local att = getglobal("Nurfed_DKPPlayerFrameRows"..row.."FieldAtt");
				local highlight = getglobal("Nurfed_DKPPlayerFrameRows"..row.."FieldHighlight");
				local info = self.display[line];
				local classinfo = dkpvalues.class[info.class];
				local playerroll = self:GetRoll(info.name);
				if (info.down) then
					if (info.rank) then
						rank:SetText("|cffff0000(-|r"..info.rank.."|cffff0000-)|r");
					else
						rank:SetText("|cffff0000(-|r |cffff0000-)|r");
					end
				else
					if (info.rank) then
						rank:SetText(info.rank);
					end
				end
				name:SetText("|cff"..classinfo.color..info.name.."|r");
				roll:SetText(playerroll);
				if (info.dkp < 0) then
					dkp:SetText("|cffff9999"..info.dkp.."|r");
				else
					dkp:SetText("|cff99ff99"..info.dkp.."|r");
				end
				class:SetText("|cff"..classinfo.color..info.class.."|r");
				if (info.att < 50) then
					att:SetText("|cffff9999"..info.att.."%|r");
				else
					att:SetText("|cff99ff99"..info.att.."%|r");
				end
				if (Nurfed_DKPPlayerFrame.highlight and Nurfed_DKPPlayerFrame.highlight == line) then
					highlight:Show();
				else
					highlight:Hide();
				end
				playerrow:Show();
			else
				playerrow:Hide();
			end
		end
	end

	function Nurfed_DKP:DisplayLoot(name, offset, max_line)
		if (not offset) then
			if (NURFED_SAVED_DKPLOOT[name]) then
				self.displayloot = {};
				local i = 1;
				local info;
				for itemname,v in NURFED_SAVED_DKPLOOT[name] do
					info = {};
					info.icon = v.icon;
					info.link = v.link;
					info.item = itemname;
					info.rarity = v.rarity;
					info.count = v.count;
					info.dkp = v.dkp;
					info.secdkp = v.secdkp;
					self.displayloot[i] = info;
					i = i + 1;
				end
			end
			if (NurfedDKPPlayers[name]) then
				local dkp = NurfedDKPPlayers[name].dkp;
				local class = NurfedDKPPlayers[name].class;
				local info = dkpvalues.class[class];
				if (dkp < 0) then
					dkp = " (|cffff9999"..dkp.."|r)";
				else
					dkp = " (|cff99ff99"..dkp.."|r)";
				end
				Nurfed_DKPLootFrameClassIcon:SetTexCoord(info.right, info.left, info.top, info.bottom);
				Nurfed_DKPLootFrameClassIcon:Show();
				Nurfed_DKPLootFrameName:SetText("|cff"..info.color..name.."|r"..dkp);
			else
				Nurfed_DKPLootFrameName:SetText(name);
				Nurfed_DKPLootFrameClassIcon:Hide();
			end
			Nurfed_DKPLootFrame.name = name;
		else
			for row = 1, 5 do
				local line = row + offset;
				local itemrow = getglobal("Nurfed_DKPLoot"..row);
				if (NURFED_SAVED_DKPLOOT[name]) then
					if (line <= max_line) then
						local icon = getglobal("Nurfed_DKPLoot"..row.."ItemIcon");
						local count = getglobal("Nurfed_DKPLoot"..row.."ItemCount");
						local text = getglobal("Nurfed_DKPLoot"..row.."Name");
						local dkp = getglobal("Nurfed_DKPLoot"..row.."DKP");
						local info = self.displayloot[line];
						icon:SetTexture(info.icon);
						itemrow.link = info.link;
						itemrow.item = info.item;
						itemrow.player = name;
						text:SetText("|c"..self.lootcolor[info.rarity]..info.item.."|r");
						if (info.count > 1) then
							count:SetText(info.count);
							count:Show();
						else
							count:Hide();
						end
						if (tonumber(info.dkp) > 0) then
							dkp:SetText(info.dkp);
							dkp:Show();
						else
							dkp:Hide();
						end
						itemrow:Show();
					else
						itemrow:Hide();
					end
				else
					itemrow:Hide();
				end
			end
		end
	end

	function Nurfed_DKP:ItemRemove(name, item, all)
		if (all or NURFED_SAVED_DKPLOOT[name][item]["count"] == 1) then
			NURFED_SAVED_DKPLOOT[name][item] = nil;
		else
			NURFED_SAVED_DKPLOOT[name][item]["count"] = NURFED_SAVED_DKPLOOT[name][item]["count"] - 1
		end
		self:DisplayLoot(name);
		Nurfed_DKPItemScrollUpdate();
	end
end