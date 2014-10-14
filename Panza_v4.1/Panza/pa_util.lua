--[[
pa_util.lua
Revision 4.0
General PA Utility Functions

10-01-06 "for in pairs()" completed for BC
--]]

function PA:table_minmax(tab)
    local min,max,k,v=nil,nil,nil,nil;
    if (tab==nil) then return nil,nil;end
    for k,v in pairs(tab) do
        local k_num = tonumber(k)
        if ( k_num ) then
            if ( not min or k_num < min ) then
                min = k_num
            end
            if ( not max or k_num > max ) then
                max = k_num
            end
        end
    end
    return min,max
end

function PA:table_first(tab)
    local min = PA:table_minmax(tab)
    if ( min ) then
        return min, tab[min]
    else
        for k,v in pairs(tab) do
            return k,v
        end
    end
    return nil,nil
end

function PA:TableSize(tableList)
	if (tableList==nil) then
		return 0;
	end
	local Size = 0;
	local FirstEntry = nil;
	if (tableList~=nil) then
		for key, value in pairs(tableList) do
			if (FirstEntry==nil) then
				FirstEntry = value;
			end
			Size = Size + 1;
		end
	end
	return Size, FirstEntry;
end

function PA:TableFirst(tableList)
	for key, value in pairs(tableList) do
		return value;
	end
	return nil;
end

function PA:TableFirstKey(tableList)
	for key, value in pairs(tableList) do
		return key, value;
	end
	return nil;
end

function PA:TableLast(tableList)
	local LastValue = nil;
	for key, value in pairs(tableList) do
		LastValue = value;
	end
	return LastValue;
end

function PA:TableEmpty(tableList)
	return (PA:TableFirst(tableList)==nil);
end

function PA:CopyTable(t, lookup_table, original)
	if (type(t)=="table") then
		local copy;
		if (original==nil) then
			copy = {};
		else
			copy = original;
		end
		for i,v in pairs(t) do
			if (type(v)~="function") then
				if (type(v)~="table") then
					copy[i] = v;
				else
					lookup_table = lookup_table or {};
					lookup_table[t] = copy;
					if lookup_table[v] then
						copy[i] = lookup_table[v]; -- we already copied this table. reuse the copy.
					else
						copy[i] = PA:CopyTable(v, lookup_table); -- not yet copied. copy it.
					end
				end
			end
		end
		return copy
	else
		return t;
	end
end

function PA:SplitString(text)
	local args = { };
	local i = 0;

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("Splitting: "..text);
	end

	for w in string.gfind(text, "%w+") do
		i = i + 1;
		args[i] = w;
	end

	return args;
end

-------------------------------------------------------------
-- Capitalize 1st letter and lower case all other text passed
-------------------------------------------------------------
function PA:Capitalize(txt)
	if (txt==nil) then
		return nil;
	end
	local Start,End,First,Other=string.find(txt,'^(%w)(.+)$')
	if (GetLocale() == "zhCN") then
    	return txt
	else
		return string.upper(First)..string.lower(Other)
	end
end

------------------------
-- Convert to percentage
------------------------
function PA:Percent(value, total)
	if (total>0) then
		return format("%.1f%%", 100 * value / total);
	else
		return "N/A";
	end
end

----------------------------------
-- Determine owner's name for pet
----------------------------------
function PA:GetUnitsOwner(unit)
	local Owner = nil;
	local PetText = nil;
	if (unit~=nil) then
		PA:ResetTooltip();
		PanzaTooltip:SetUnit(unit);
		PetText = PanzaTooltipTextLeft2:GetText();
		if (PetText~=nil) then
			_,_,Owner = string.find(PetText, PANZA_MATCH_PET);
			if (Owner==nil) then
				_,_,Owner = string.find(PetText, PANZA_MATCH_MINION);
				if (Owner==nil) then
					_,_,Owner = string.find(PetText, PANZA_MATCH_GUARDIAN);
					if (Owner==nil) then
						_,_,Owner = string.find(PetText, PANZA_MATCH_CREATION);
						if (Owner==nil) then
							_,_,Owner = string.find(PetText, PANZA_MATCH_CHARM);
						end
					end
				end
			end
		end
	end
	return Owner, PetText;
end

-------------------------------------
-- Determine we are in a battleground
-------------------------------------
function PA:IsInBG()
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local bgstatus, BGName, instanceID = GetBattlefieldStatus(i);
		if (instanceID~=0  and bgstatus=="active") then
			return true, BGName;
		end
	end
	return false, nil;
end

--------------------------
-- Determine we are in WSG
--------------------------
function PA:IsInWSG()
	local InBG, BGName = PA:IsInBG();
	return (InBG==true and string.find(BGName, "Warsong")~=nil);
end

----------------------------------------------------------------
-- Determine if unit is a friend and does not have Mind* Debuffs
----------------------------------------------------------------
function PA:UnitIsMyFriend(unit)
	local IsFriend = (UnitExists(unit) and UnitIsFriend(unit, "player") and not PA:UnitHasDebuff(unit, "MindControl") and not PA:UnitHasDebuff(unit, "MindVision"));
	PA:Debug("UnitIsMyFriend unit=", unit, " IsFriend=", IsFriend);
	return (IsFriend==true);
end

-------------------------------------------------------
-- Counts number of Reagents currently in player's bags.
-- ToDo:	Make the return values, class specific.
--		The Status dialog, and TitanPA uses
--		this function. Other functions will need
--		to use this function to retrieve item
--		counts. ex. Druids for Rez.
--
-- Druids need to track
--
-- "Wild Berries"
-- "Wild Thornroot"
-- "Maple Seed"
-- "Strangle Thorn Seed"
-- "Ashwood Seed"
-- "Hornbeam Seed"
-- "Ironwood Seed"
--------------------------------------------------------
function PA:AddCount(totals, component, count)
	if (totals[component]==nil) then
		totals[component] = count;
		return
	end
	totals[component] = totals[component] + count;
end

function PA:UpdateComponents()
	PA.ComponentTotals = PA:SymbolCount();
end

function PA:Components(component)
	return PA.ComponentTotals[component] or 0;
end

function PA:SymbolCount()
	local bag, slot = 0, 0;
	local Totals = {};

	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				-- Paladins use divinity and kings for spells
				if (PA.PlayerClass=="PALADIN") then

					local texture, count = GetContainerItemInfo(bag, slot);
					if string.find(itemName, "%["..PANZA_KINGSCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "kings", count);
					elseif string.find(itemName, "%["..PANZA_DIVINITYCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "divinity", count);
					end

				-- Priests use Candles
				elseif (PA.PlayerClass=="PRIEST") then
					local texture, count = GetContainerItemInfo(bag, slot);

					if string.find(itemName, "%["..PANZA_FEATHERCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "feathers", count);

					elseif string.find(itemName, "%["..PANZA_HOLYCANCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "holycandles", count);

					elseif string.find(itemName, "%["..PANZA_SACREDCANCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "sacredcandles", count);
					end

				-- Mages use Feathers
				elseif (PA.PlayerClass=="MAGE") then
					local texture, count = GetContainerItemInfo(bag, slot);

					if string.find(itemName, "%["..PANZA_FEATHERCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "feathers", count);
					end

				-- Druids use Seeds/Roots (lots of them)
				elseif (PA.PlayerClass=="DRUID") then

					local texture, count = GetContainerItemInfo(bag, slot);
					if string.find(itemName, "%["..PANZA_BERRIESCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "berries", count);
					elseif string.find(itemName, "%["..PANZA_THORNROOTCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "thornroot", count);
					elseif string.find(itemName, "%["..PANZA_MAPLECOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "maple", count);
					elseif string.find(itemName, "%["..PANZA_THORNCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "thorn", count);
					elseif string.find(itemName, "%["..PANZA_ASHWOODCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "ashwood", count);
					elseif string.find(itemName, "%["..PANZA_HORNBEAMCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "hornbeam", count);
					elseif string.find(itemName, "%["..PANZA_IRONWOODCOUNT_ITEMNAME.."%]") then
						PA:AddCount(Totals, "ironwood", count);
					end

				-- Shaman use ?
				elseif (PA.PlayerClass=="SHAMAN") then

				end
			end
		end
	end

	return Totals;
end

-----------------------------------------
-- 3.0 Determine if unit could have a pet
-----------------------------------------
function PA:CanHavePet(class) -- UnitTest
	if (class==nil) then
		return false;
	end
	if (PA:CheckMessageLevel("Bless", 5)) then
		PA:Message4("CanHavePet Class="..class);
	end
	return (class=="HUNTER" or class=="WARLOCK");
end


-------------------------------------
-- returns true if you are in a party
-------------------------------------
function PA:IsInParty()
	return GetNumPartyMembers()~=0;
end

------------------------------------------
-- returns true if you are in a raid party
------------------------------------------
function PA:IsInRaid()
	return GetNumRaidMembers()~=0;
end

function PA:Escape(text)
	if (text==nil) then
		return nil;
	end
	return string.gsub(string.gsub(text, "\n", "<LF>"), "\r", "<CR>");
end

function PA:ResetTooltip()
	PanzaTooltipTextLeft1:SetText(nil);
	PanzaTooltipTextLeft2:SetText(nil);
	PanzaTooltipTextLeft3:SetText(nil);
	PanzaTooltipTextLeft4:SetText(nil);
	PanzaTooltipTextLeft5:SetText(nil);
	PanzaTooltipTextRight1:SetText(nil);
	PanzaTooltipTextRight2:SetText(nil);
	PanzaTooltipTextRight3:SetText(nil);
	PanzaTooltipTextRight4:SetText(nil);
	PanzaTooltipTextRight5:SetText(nil);
	PanzaTooltip:ClearLines();
	PanzaTooltip:SetOwner(PanzaTooltip, "ANCHOR_NONE");
end

function PA:CaptureTooltip(store)
	store["Tooltip"] = {};
	store.Tooltip["Left1"] = PA:Escape(PanzaTooltipTextLeft1:GetText());
	store.Tooltip["Left2"] = PA:Escape(PanzaTooltipTextLeft2:GetText());
	store.Tooltip["Left3"] = PA:Escape(PanzaTooltipTextLeft3:GetText());
	store.Tooltip["Left4"] = PA:Escape(PanzaTooltipTextLeft4:GetText());
	store.Tooltip["Left5"] = PA:Escape(PanzaTooltipTextLeft5:GetText());
	store.Tooltip["Right1"] = PA:Escape(PanzaTooltipTextRight1:GetText());
	store.Tooltip["Right2"] = PA:Escape(PanzaTooltipTextRight2:GetText());
	store.Tooltip["Right3"] = PA:Escape(PanzaTooltipTextRight3:GetText());
	store.Tooltip["Right4"] = PA:Escape(PanzaTooltipTextRight4:GetText());
	store.Tooltip["Right5"] = PA:Escape(PanzaTooltipTextRight5:GetText());
end

--------------------------------------
-- Return UnitID knowing only the Name
--------------------------------------
function PA:FindUnitFromName(name, defaultUnit)
	if (name==PA.PlayerName) then
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("FindUnitFromName() - Is Player.");
		end
		return "player";
	end

	if (PA:IsInParty()) then
		for Index = 1, PANZA_MAX_PARTY - 1 do
			local PartyUnit = "party"..Index;
			if (PA:UnitName(PartyUnit)==name) then
				return PartyUnit;
			end
		end
	else
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("FindUnitFromName() - Not in Party.");
		end
	end

	if (PA:IsInRaid()) then
		for Index = 1, PANZA_MAX_RAID do
			local RaidUnit = "raid"..Index;
			if (PA:UnitName(RaidUnit)==name) then
				return RaidUnit;
			end
		end
	else
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("FindUnitFromName() - Not in Raid.");
		end

	end
	return defaultUnit;
end

--------------------------------------------------------
-- Return UnitID knowing only the target or targettarget
--------------------------------------------------------
function PA:FindUnitFromTarget(target, defaultUnit)
	if (UnitIsUnit("player", target)) then
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("FindUnitFromTarget() - Is Player.");
		end
		return "player";
	end

	if (PA:IsInParty()) then
		for Index = 1, PANZA_MAX_PARTY - 1 do
			local PartyUnit = "party"..Index;
			if (UnitIsUnit(PartyUnit, target)) then
				return PartyUnit;
			end
		end
	else
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("FindUnitFromName() - Not in Party.");
		end
	end

	if (PA:IsInRaid()) then
		for Index = 1, PANZA_MAX_RAID do
			local RaidUnit = "raid"..Index;
			if (UnitIsUnit(RaidUnit, target)) then
				return RaidUnit;
			end
		end
	else
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("FindUnitFromTarget() - Not in Raid.");
		end
	end
	return defaultUnit;
end

function PA:EnableCheckBox(checkBox, colors)
	checkBox:Enable();
	if (colors==nil or colors.r==nil) then
		getglobal(checkBox:GetName().."Text"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		getglobal(checkBox:GetName().."Text"):SetVertexColor(colors.r, colors.g, colors.b);
	end
end

function PA:DisableCheckBox(checkBox, colors)
	checkBox:Disable();
	if (colors==nil or colors.r==nil) then
		getglobal(checkBox:GetName().."Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	else
		getglobal(checkBox:GetName().."Text"):SetVertexColor(colors.r, colors.g, colors.b);
	end
end

function PA:EnableDropDown(dropDown, colors)
	if (colors==nil or colors.r==nil) then
		getglobal(dropDown:GetName().."Text"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		getglobal(dropDown:GetName().."Text"):SetVertexColor(colors.r, colors.g, colors.b);
	end
	getglobal(dropDown:GetName().."Button"):Enable();
end

function PA:DisableDropDown(dropDown, colors)
	if (colors==nil or colors.r==nil) then
		getglobal(dropDown:GetName().."Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	else
		getglobal(dropDown:GetName().."Text"):SetVertexColor(colors.r/2, colors.g/2, colors.b/2);
	end
	getglobal(dropDown:GetName().."Button"):Disable();
end

------------------------------------------
-- Trims spaces from both ends of a string
------------------------------------------
function PA:Trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

-------------------------------------------
-- Activate trinket if you have it equipped
-------------------------------------------
function PA:ActivateTrinket(trinket)

	local TrinketSlot0 =  GetInventorySlotInfo("Trinket0Slot");
	local TrinketSlot1 =  GetInventorySlotInfo("Trinket1Slot");
	local Trinket0 =  GetInventoryItemLink("player", TrinketSlot0)
	local Trinket1 =  GetInventoryItemLink("player", TrinketSlot1)
	local TrinketSlot;

	if (Trinket0~=nil and string.find(Trinket0, trinket)~= nil) then
		TrinketSlot = TrinketSlot0;
	elseif (Trinket1~=nil and string.find(Trinket1, trinket)~= nil) then
		TrinketSlot = TrinketSlot1;
	end

	if (TrinketSlot ~= nil) then
		if (GetInventoryItemCooldown("player", TrinketSlot) == 0) then
			--PA:Debug("Using Trinket ", TrinketSlot);
			UseInventoryItem(TrinketSlot);
			SpellStopCasting();
			return true;
		end
	end
	return false;
end

--------------------------------
-- Return if a target is stunned
--------------------------------
function PA:CheckStunned(unit, index, predict)
	PanzaTooltipTextLeft2:SetText(nil);
	PanzaTooltip:SetUnitDebuff(unit, index);
	local Text = PanzaTooltipTextLeft2:GetText();
	if (predict~=true) then
		if (PA:CheckMessageLevel("Offen", 3)) then
			PA:Message4("(CheckStunned) unit="..tostring(unit).." index="..tostring(index).." Text="..tostring(Text));
		end
	end
	if (Text~=nil) then
		return (string.find(Text, PANZA_STUNNED) ~= nil
			 or string.find(Text, PANZA_DISORIENTED) ~= nil
			 or string.find(Text, PANZA_INCAPACITATED) ~= nil);
	end
	return false;
end

-----------------------------------------------
-- Return if target is undead or demon type mob
-----------------------------------------------
function PA:UnitIsUndeadOrDemon(unit)
	local CreatureType = UnitCreatureType(unit);
	return ((CreatureType==PANZA_UNDEAD) or (CreatureType==PANZA_DEMON));
end

-------------------------------------------------------------------------
--Moves a frame within the bounds of parent if it's totally out of bounds
-------------------------------------------------------------------------
function PA:Reposition(frame, parent, center)
	--PA:ShowText("Reposition");
	if (type(frame)=="string") then
		frame = getglobal(frame);
	end
	if (type(parent)=="string") then
		parent = getglobal(parent);
	end
	if (frame:GetBottom() and frame:GetTop() and frame:GetLeft() and frame:GetRight()) then
		local xoff = 0;
		local yoff = 0;
		local ratio = frame:GetScale();

		--check and see if the frame is completely off the screen
		--Y bounds checking
		if (  frame:GetTop() < 0) then
			yoff = 0 - frame:GetTop();
		elseif ( frame:GetBottom()  > (parent:GetTop() / ratio ) ) then
			yoff = (parent:GetBottom() / ratio) - frame:GetTop();
		end

		--X bounds checking
		if ( frame:GetRight() < 0 ) then
			xoff = 0  - frame:GetRight();
		elseif ( frame:GetLeft()  > ( parent:GetRight() / ratio )  ) then
			xoff = (parent:GetLeft() / ratio) - frame:GetRight();
		end

		--PA:ShowText("xoff=", xoff, " yoff=", yoff);

		--Reposition if anything was out of bounds
		if (xoff~=0 or yoff~=0) then
			--PA:ShowText("Frame out of bounds!");
			if (center==true) then
				frame:ClearAllPoints();
				frame:SetPoint("CENTER", parent, "CENTER", 0 , 0);
			else
				local x = frame:GetLeft() + xoff;
				local y = frame:GetTop() + yoff;
				frame:ClearAllPoints();
				frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", x , y);
			end
			--PA:ShowText("Bot=", frame:GetBottom(), " Top=", frame:GetTop(), " L=", frame:GetLeft(), " R=", frame:GetRight());
		end
	end
end

--------------------------------------------------------
-- Modify Various UI Pieces that are specific to a class
--------------------------------------------------------
function PA:ModifyUIClass(class)
	if (class==nil or cbxPanzaUseDF==nil or SliderPanzaPHMCritRank==nil or cbxPanzaOnDF==nil) then
		return;
	end
	if (PA:CheckMessageLevel("Core", 2)) then
		PA:Message4("(Panza) Adapting Panza UI for the "..class.." Class.");
	end

	if (class=="PRIEST") then

		-- Change Control Text
		getglobal(cbxPanzaUseDFAll:GetName().."Text"):SetText(PANZA_PHM_USEDFALL_PRIEST);
		getglobal(cbxPanzaUseDF:GetName().."Text"):SetText(PANZA_PHM_USEDF_PRIEST);
		getglobal(SliderPanzaPHMCritRank:GetName().."Text"):SetText(PANZA_PHM_CRITRANK_PRIEST);
		getglobal(cbxPanzaOnDF:GetName().."Text"):SetText(PANZA_TRINKET_DF_PRIEST);
		getglobal(cbxPanzaPPMStage1:GetName().."Text"):SetText(PANZA_PPM_STAGE1_PRIEST.." ----------------->");
		getglobal(cbxPanzaPPMStage5:GetName().."Text"):SetText(PANZA_PPM_STAGE5_PRIEST.." -->");

		-- Change Tooltips
		PA.PHM_Tooltips["cbxPanzaUseDFAll"] = PA.PHM_Tooltips["cbxPanzaUseDFAll.Priest"];
		PA.PHM_Tooltips["cbxPanzaUseDF"] = PA.PHM_Tooltips["cbxPanzaUseDF.Priest"];
		PA.PHM_Tooltips["SliderPanzaPHMCritRank"] = PA.PHM_Tooltips["SliderPanzaPHMCritRank.Priest"];
		PA.PHM_Tooltips["cbxPanzaOnDF"] = PA.PHM_Tooltips["cbxPanzaOnDF.Priest"];
		PA.PHM_Tooltips["cbxPanzaOnDFOOC"] = PA.PHM_Tooltips["cbxPanzaOnDFOOC.Priest"];
		PA.PPM_Tooltips["cbxPanzaPPMStage1"] = PA.PPM_Tooltips["cbxPanzaPPMStage1.Priest"];
		PA.PPM_Tooltips["cbxPanzaPPMStage5"] = PA.PPM_Tooltips["cbxPanzaPPMStage5.Priest"];

	elseif (class=="DRUID") then
		local druidtype="SWIFT";  -- default probable Restro Druid's choice

		if (PA:SpellInSpellBook("HEALSPECIAL")) then
			-- PA:Message("Druid HEALSPECIAL = "..PA.SpellBook["HEALSPECIAL"].Name);
			if (string.find(PA.SpellBook["HEALSPECIAL"].Name,"Clarity")) then
				duridtype="OMEN";
				-- Change Control Text
				getglobal(cbxPanzaUseDFAll:GetName().."Text"):SetText(PANZA_PHM_USEDFALL_DRUIDOMEN);
				getglobal(cbxPanzaUseDF:GetName().."Text"):SetText(PANZA_PHM_USEDF_DRUIDOMEN);
				getglobal(SliderPanzaPHMCritRank:GetName().."Text"):SetText(PANZA_PHM_CRITRANK_DRUIDOMEN);
				getglobal(cbxPanzaOnDF:GetName().."Text"):SetText(PANZA_TRINKET_DF_DRUIDOMEN);

			elseif (string.find(PA.SpellBook["HEALSPECIAL"].Name,"Swiftness")) then
				PA:Message("Druid with Natures Swiftness");
				druidtype="SWIFT";
				-- Change Control Text
				getglobal(cbxPanzaUseDFAll:GetName().."Text"):SetText(PANZA_PHM_USEDFALL_DRUIDSWIFT);
				getglobal(cbxPanzaUseDF:GetName().."Text"):SetText(PANZA_PHM_USEDF_DRUIDSWIFT);
				getglobal(SliderPanzaPHMCritRank:GetName().."Text"):SetText(PANZA_PHM_CRITRANK_DRUIDSWIFT);
				getglobal(cbxPanzaOnDF:GetName().."Text"):SetText(PANZA_TRINKET_DF_DRUIDSWIFT);
				getglobal(cbxPanzaPPMStage5:GetName().."Text"):SetText(PANZA_PPM_STAGE5_DRUIDSWIFT.." -->");
			end
		else
			getglobal(cbxPanzaUseDFAll:GetName().."Text"):SetText(PANZA_PHM_USEDFALL_DRUIDSWIFT);
			getglobal(cbxPanzaUseDF:GetName().."Text"):SetText(PANZA_PHM_USEDF_DRUIDSWIFT);
			getglobal(SliderPanzaPHMCritRank:GetName().."Text"):SetText(PANZA_PHM_CRITRANK_DRUIDSWIFT);
			getglobal(cbxPanzaOnDF:GetName().."Text"):SetText(PANZA_TRINKET_DF_DRUIDSWIFT);
			getglobal(cbxPanzaPPMStage5:GetName().."Text"):SetText(PANZA_PPM_STAGE5_DRUIDSWIFT.." -->");
		end

		-- Change Tooltips
		PA.PHM_Tooltips["cbxPanzaUseDFAll"] = PA.PHM_Tooltips["cbxPanzaUseDFAll.Druid"..druidtype];
		PA.PHM_Tooltips["cbxPanzaUseDF"] = PA.PHM_Tooltips["cbxPanzaUseDF.Druid"..druidtype];
		PA.PHM_Tooltips["cbxPanzaUseDFOOC"] = PA.PHM_Tooltips["cbxPanzaUseDFOOC.Druid"..druidtype];
		PA.PHM_Tooltips["SliderPanzaPHMCritRank"] = PA.PHM_Tooltips["SliderPanzaPHMCritRank.Druid"..druidtype];
		PA.PHM_Tooltips["cbxPanzaOnDF"] = PA.PHM_Tooltips["cbxPanzaOnDF.Druid"..druidtype];
		PA.PPM_Tooltips["cbxPanzaPPMStage5"] = PA.PPM_Tooltips["cbxPanzaPPMStage5"..druidtype];

	elseif (class=="SHAMAN") then

		-- Change Control Text
		getglobal(cbxPanzaUseDFAll:GetName().."Text"):SetText(PANZA_PHM_USEDFALL_SHAMAN);
		getglobal(cbxPanzaUseDF:GetName().."Text"):SetText(PANZA_PHM_USEDF_SHAMAN);
		getglobal(SliderPanzaPHMCritRank:GetName().."Text"):SetText(PANZA_PHM_CRITRANK_SHAMAN);
		getglobal(cbxPanzaOnDF:GetName().."Text"):SetText(PANZA_TRINKET_DF_SHAMAN);
		getglobal(cbxPanzaPPMStage5:GetName().."Text"):SetText(PANZA_PPM_STAGE5_SHAMAN.." -->");

		-- Change Tooltips
		PA.PHM_Tooltips["cbxPanzaUseDFAll"] = PA.PHM_Tooltips["cbxPanzaUseDFAll.Shaman"];
		PA.PHM_Tooltips["cbxPanzaUseDF"] = PA.PHM_Tooltips["cbxPanzaUseDF.Shaman"];
		PA.PHM_Tooltips["cbxPanzaUseDFOOC"] = PA.PHM_Tooltips["cbxPanzaUseDFOOC.Shaman"];
		PA.PHM_Tooltips["SliderPanzaPHMCritRank"] = PA.PHM_Tooltips["SliderPanzaPHMCritRank.Shaman"];
		PA.PHM_Tooltips["cbxPanzaOnDF"] = PA.PHM_Tooltips["cbxPanzaOnDF.Shaman"];
		PA.PPM_Tooltips["cbxPanzaPPMStage5"] = PA.PPM_Tooltips["cbxPanzaPPMStage5.Shaman"];

	end
end

----------------------------------
-- List Mouse Function Data
----------------------------------
function PA:listMouse()
	local active, size, class, key, classdata, value, valuedata = nil, nil, nil, nil, nil, nil, nil;

	if (PA:CheckMessageLevel("Core",1)) then
		PA:Message4(PA_WHITE..PA:TableSize(PA.clickmodeList).." Available Mouse Class Settings");
		for class, classdata in pairs(PA.clickmodeList) do
			size=PA:TableSize(PA.clickmodeList[class]);
			PA:Message4(PA_WHITE..class.." with "..PA_BLUE..size.." functions");
			for value, valuedata in pairs(PA.clickmodeList[class]) do
				PA:Message4("  "..valuedata);
			end
		end

		PA:Message4(PA_WHITE..PA:TableSize(PA.defaultClick[PA.PlayerClass]).." Mouse Functions setup for "..PA.PlayerClass);
		for key, value in pairs(PA.defaultClick[PA.PlayerClass]) do
			PA:Message4("  "..key.." - "..value.." - "..PA.clickmodeList[PA.PlayerClass][value]);
		end

		PA:Message4("Frames "..PA_ORANGE.."saved "..PA_GREN.."by PMM and "..PA_YEL.."enabled "..PA_GREN.."status.");
		for key, value in pairs(PA.PMMSupport) do
			if (PASettings.PMM[key]==true) then active="enabled" else active="disabled" end;
			PA:Message4("  "..key.." - "..PA_ORANGE..tostring(value).." - "..PA_YEL..active);
		end
	end
end

------------------------------------------------------------------------------------------------
-- Extracts numbers from a string
-- countList may be:
--  nil - Extracts first number
--  Number - Extracts nth number
--  Table  - Extracts numbers at positions in given table and returns them in the order specified
-- Returns nil for no matches (unless zeroIfMissing is true) or a list of numbers
------------------------------------------------------------------------------------------------
function PA:ExtractNumbers(text, countList, zeroIfMissing)
	local ResultList = {};
	if (countList==nil) then
		countList = {1};
	end
	if (type(countList)=="number") then
		countList = {countList};
	end
	if (text~=nil) then
		local Index = 1;
		--PA:Debug("ExtractNumbers text=", text);
		for Number in string.gfind(text, "%d+[.,]?%d*") do
			--PA:Debug(" Number=", Number, " Index=", Index);
			for CountIndex, Count in pairs(countList) do
				--PA:Debug("  Count=", Count);
				if (Count==Index) then
					Number = gsub(Number, "," , ".");
					--PA:Debug("EnNumber=", gsub(Number, "," , "."));
					ResultList[CountIndex] = tonumber(Number);
					--PA:Debug("    ResultList["..CountIndex.."]=", ResultList[CountIndex]);
				end
			end
			Index = Index + 1;
		end
	end
	if (zeroIfMissing==true) then
		for Index in countList do
			if (ResultList[Index]==nil) then
				ResultList[Index] = 0;
			end
		end
	end
	--PA:Debug("countList Size=", getn(countList), " ResultList Size=", getn(ResultList));
	return PA:Unpack(ResultList, getn(countList));
end

-- An unpack that maintains order even if some elements are nil
function PA:Unpack(t, limit, i)
	i = i or 1;
	--PA:Debug("i=", i, " limit=", limit);
	if (i<=limit) then
		return t[i], PA:Unpack(t, limit, i + 1);
	end
	return nil;
end

--Simulates old 5.0 format behaviour that got axed in lua 5.1
function PA:Format(pattern, ...)
	if (arg==nil or arg.n==0) then
		return pattern;
	end
	local NewArg = {};
	local ArgIndex = 1;

	local function FixPattern(index, code)
		if (index==nil or string.len(index)==0) then
			index = ArgIndex;
		end
		--print("index=", index, "code=", code, "arg=", arg[tonumber(index)]);
	 	NewArg[ArgIndex] = string.format("%"..code, arg[tonumber(index)]);
		ArgIndex = ArgIndex + 1;
		return "%s";
	end

	--print("before pattern=", pattern);
	pattern = string.gsub(pattern, "%%(%d*)$?(%a)", FixPattern);
	--print("after  pattern=", pattern);
	--for Index, Arg in pairs(arg) do
	--	print(Index, " ", Arg, " ", NewArg[Index]);
	--end
	return string.format(pattern, unpack(NewArg));
end

-- Attempt to determine if the supplied unit is a vanity pet
function PA:IsVanityPet(unit)
	return (UnitDefense(unit)==0 and UnitManaMax(unit)==0 and UnitAttackBothHands(unit)==0 and UnitIsPlayer(unit)==nil and PA:GetUnitsOwner(unit)~=nil);
end

-- Determine MainTanks from other apps
--	CTRA, RDX, oRA
function PA:GetMainTanks()
	local MainTanks = {};
	local Done = {};
	-- CTRA MainTanks
	if (CT_RA_MainTanks~=nil) then
		for Index, MTName in pairs(CT_RA_MainTanks) do
			if (Done[MTName]==nil) then
				table.insert(MainTanks, MTName);
				Done[MTName] = true;
			end
		end
	end
	-- RDX MainTanks
	if (RDX~=nil and RDXM.Assists~=nil and RDXM.Assists.cfg~=nil and RDXM.Assists.cfg.mtarray~=nil) then
		for Index, MTName in pairs(RDXM.Assists.cfg.mtarray) do
			if (Done[MTName]==nil) then
				table.insert(MainTanks, MTName);
				Done[MTName] = true;
			end
		end
	end
	-- oRA MainTanks
	if (oRA_MainTank~=nil and oRA_MainTank.MainTankTable~=nil) then
		for Index, MTName in pairs(oRA_MainTank.MainTankTable) do
			if (Done[MTName]==nil) then
				table.insert(MainTanks, MTName);
				Done[MTName] = true;
			end
		end
	end	
	return MainTanks;
end

-- Determine if we can get MainTanks from other apps
function PA:MainTanksAvailable()
	return (CT_RA_MainTanks~=nil or RDX~=nil or oRA_MainTank~=nil);
end


-- Get List of Ignored Players
function PA:GetIgnores()
	local totalignores, i, IgnoreList = 0, 0, {};
	
	totalignores = GetNumIgnores();
	-- PA:ShowText("Total Ignored Players=",totalignores);
	
	for i=1, totalignores do
		table.insert(IgnoreList, GetIgnoreName(i));
	end
	
	return IgnoreList;
end	

-- See if "name" is ignored
function PA:IsIgnored(name)
	if (PASettings.Switches.UseIgnore.enabled==false or name==nil) then return false; end
	local IgnoreList = PA:GetIgnores();
	for index, ignored in pairs(IgnoreList) do
		--PA:ShowText("(Panza) Checking ",ignored);
		if (ignored==name) then 
			--PA:ShowText("(Panza) Ignoring ",name);
			return true;
		end
	end	
	return false;
end

-- Test Ignore list
function PA:ListIgnores()
	local IgnoreList = PA:GetIgnores();
	
	for index, name in pairs(IgnoreList) do
		PA:DiaplayText(name);
	end
end

-- for use with main/menu frames with UIParent parent when relocated by the mod, to register for layout-cache.txt
function PA:ReallySetPoint(frame, point, relativeTo, relativePoint, xoff, yoff)
	if (frame~=nil) then
		frame:SetPoint(point, relativeTo, relativePoint, xoff, yoff);
		PA:Reposition(frame, relativeTo, true);
	end
end

function PA:WandCheck()
	if (PA:CheckMessageLevel("Offen", 5)) then
		PA:Message4("Wand Check Called ActionBarId="..tostring(PA.ShootActionId));
	end
	if (PA.ShootActionId~=nil) then
		if (IsAutoRepeatAction(PA.ShootActionId)==1) then
			if (PA:CheckMessageLevel("Offen", 3)) then
				PA:Message4("Wand in use, cancelling");
			end
			UseAction(PA.ShootActionId);
			return true;
		end
	end
	return false;
end