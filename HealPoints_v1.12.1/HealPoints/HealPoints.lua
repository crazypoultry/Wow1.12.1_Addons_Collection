
HealPoints = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceHook-2.1", "AceEvent-2.0", "AceDB-2.0")
HealPoints:RegisterDB("HEALPOINTS_CONFIG", "HEALPOINTS_CONFIG");
HealPoints:RegisterDefaults("char", {
    power = {
      spell = "",
      auto = true,
      duration = 1,
      rank = 1,
      mana = 100,
    },
    endurance = {
      spell = "",
      auto = true,
      duration = 5,
      rank = 1,
      mana = 0,
    },
    hot = {
      numtargets = 3,
    },
    tooltips = 1
  });
HealPoints:RegisterChatCommand({ "/healpoints" }, {
  type = "group",
  args = {
    bscan = {
      type = "execute",
      name = "Scan bonuses",
      desc = "List special set/equip bonuses detected",
      func = "listScannedBonuses"
    },
    config = {
      type = "execute",
      name = "Config",
      desc = "Open the configuration window",
      func = function()
        if (HealPoints.ENABLED) then
  			  HealPoints_ConfigFrame:Show();
  			end
      end
    },
    calc = {
      type = "execute",
      name = "Calculator",
      desc = "Open the calculator window",
      func = function()
        if (HealPoints.ENABLED) then
  			  HealPoints_CalcFrame:Show();
  			end
      end
    },
    tooltips = {
      type = "toggle",
      name = "Tooltip display",
      desc = "Toggles the display of HealPoints change in item tooltips",
      get = function()
        return HealPoints.db.char.tooltips == 1;
      end,
      set = function()
        HealPoints.db.char.tooltips = 1 - HealPoints.db.char.tooltips;
      end
    },
  },
});

HealPoints.ENABLED = nil;
HealPoints.lastLink = nil;
HealPoints.diff1  = nil;
HealPoints.diff2 = nil;
HealPoints.diff3 = nil;
HealPoints.diff4 = nil;

function HealPoints:OnInitialize()
	local _, className = UnitClass("player");
	if (className == "PALADIN" or className == "PRIEST" or className == "DRUID" or className == "SHAMAN") then
		HealPoints.ENABLED = 1;
  else
    return;
	end

  self:SecureHook(GameTooltip, "SetBagItem", function(this, bag, slot)
			HealPoints:DrawTooltip(GameTooltip, GetContainerItemLink(bag, slot));
    end
  );

  self:SecureHook(GameTooltip, "SetLootItem", function(this, slot)
			HealPoints:DrawTooltip(GameTooltip, GetLootSlotLink(slot));
    end
  );

  self:SecureHook(GameTooltip, "SetQuestItem", function(this, unit, slot)
			HealPoints:DrawTooltip(GameTooltip, GetQuestItemLink(unit, slot));
    end
  );

  self:SecureHook(GameTooltip, "SetQuestLogItem", function(this, sOpt, slot)
			HealPoints:DrawTooltip(GameTooltip, GetQuestLogItemLink(sOpt, slot));
    end
  );

  self:SecureHook(GameTooltip, "SetTradeSkillItem", function(this, skill, slot)
			local link = (slot) and GetTradeSkillReagentItemLink(skill, slot) or GetTradeSkillItemLink(skill);
			HealPoints:DrawTooltip(GameTooltip, link);
    end
  );

  self:SecureHook(GameTooltip, "SetMerchantItem", function(this, slot)
			HealPoints:DrawTooltip(GameTooltip, GetMerchantItemLink(slot));
    end
  );

  self:SecureHook(GameTooltip, "SetAuctionItem", function(this, unit, slot)
			HealPoints:DrawTooltip(GameTooltip, GetAuctionItemLink(unit, slot));
    end
  );

  self:SecureHook(GameTooltip, "SetLootRollItem", function(this, id)
			HealPoints:DrawTooltip(GameTooltip, GetLootRollItemLink(id));
    end
  );

  self:Hook(GameTooltip, "SetInventoryItem", function(this, unit, slot)
			local sItem, sCooldown, sRepair = self.hooks[GameTooltip]["SetInventoryItem"](this, unit, slot);
			if(not sItem) then return nil; end
			if (slot > 39) then -- bank
				HealPoints:DrawTooltip(GameTooltip, GetInventoryItemLink(unit, slot));
			end
			return sItem, sCooldown, sRepair;
    end
  );

  self:SecureHook("SetItemRef", function(link, name, button)
			if(link and name and ItemRefTooltip) then 
        if( strsub(link, 1, 6) ~= "Player" ) then
          if( ItemRefTooltip:IsVisible()) then
            if(not DressUpFrame:IsVisible()) then
              HealPoints:DrawTooltip(ItemRefTooltip, link);
            end
            ItemRefTooltip.isDisplayDone = nil;
          end
        end
      end
    end
  );

  self:SecureHook(HealPointsBS, "update", HealPoints.GearChanged);

  -- Remove old settings
  HEALPOINTS_CONFIG['endurance'] = nil;
  HEALPOINTS_CONFIG['power'] = nil;
  HEALPOINTS_CONFIG['tooltips'] = nil;
  HEALPOINTS_CONFIG['regen'] = nil;
  HEALPOINTS_CONFIG['hot'] = nil;
end

function HealPoints:OnEnable()
  if (HealPoints.ENABLED == 1) then
    HealPointsSpells:init();
    HealPointsConfigUI:init();
    HealPointsCalculator:init();
    self:RegisterEvent("UNIT_AURA", "StatsChanged");
    self:RegisterEvent("UNIT_LEVEL", "StatsChanged");
    self:RegisterEvent("UNIT_MAXMANA", "StatsChanged");
    self:RegisterEvent("UNIT_STATS", "StatsChanged");
    self:RegisterEvent("LEARNED_SPELL_IN_TAB", "SpellsChanged");
    self:RegisterEvent("CHARACTER_POINTS_CHANGED", "TalentsChanged");
  end
end

function HealPoints:StatsChanged(target)
--[[
  local iIterator = 1
  while (UnitBuff("player", iIterator)) do
    self:Print("Buff: "..UnitBuff("player", iIterator));
    iIterator = iIterator + 1
  end
]]
  if (UnitIsUnit(target, "player")) then
    if (HealPoints_CalcFrame:IsVisible()) then
      HealPointsCalculator:updateStats();
      HealPointsCalculator:updateSpellStats();
    end
    HealPointsCalculator:updateHealPoints();
  end
end

function HealPoints:SpellsChanged(spelltabnr)
  HealPointsCalculatorUI:updateSpellLists();
  HealPointsCalculatorUI:updateSpellTable();
  if (HealPoints_CalcFrame:IsVisible()) then
    HealPointsCalculator:updateStats();
    HealPointsCalculator:updateSpellStats();
  end
  HealPointsCalculator:updateHealPoints();
  HealPointsConfigUI:spellsChanged();
end

function HealPoints:TalentsChanged(delta)
  HealPointsCalculator:talentsChanged();
  HealPointsCalculatorUI:updateSpellLists();
  HealPointsCalculatorUI:updateSpellTable();
  if (HealPoints_CalcFrame:IsVisible()) then
    HealPointsCalculator:updateStats();
    HealPointsCalculator:updateSpellStats();
  end
  HealPointsCalculator:updateHealPoints();
end

function HealPoints:GearChanged()
  HealPoints.lastLink = nil;
  if (HealPoints_CalcFrame:IsVisible()) then
    HealPointsCalculatorUI:updateSpellTable();
    HealPointsCalculator:updateStats();
    HealPointsCalculator:updateSpellStats();
  end
  HealPointsCalculator:updateHealPoints();
end

function HealPoints:DrawTooltip(frame, reference)
	local function addLine(text, diff1, diff2)
		if (diff1 == diff2) then
			frame:AddDoubleLine(text, HealPointsUtil:colorValue(diff1),
			NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
			NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		else
			frame:AddDoubleLine(text, HealPointsUtil:colorValue(diff1).." / "..HealPointsUtil:colorValue(diff2), 		
			NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
			NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);			
		end		
	end
	
	if (HealPoints.db.char.tooltips ~= 0 and reference ~= nil and string.find(reference, "item", 0, true) ~= nil) then
		if (reference ~= HealPoints.lastLink) then
			HealPoints.diff1, HealPoints.diff2, HealPoints.diff3, HealPoints.diff4 = HealPointsCalculator:computeHealpointsDiff(frame, reference)
			HealPoints.lastLink = reference;
		end
		if (HealPoints.diff3 ~= nil and HealPoints.diff3 ~= 0 and HealPoints.diff4 ~= nil and HealPoints.diff4 ~= 0) then
			addLine("HealPoints difference, top slot:", HealPoints.diff1, HealPoints.diff2);
			addLine("HealPoints difference, bottom slot:", HealPoints.diff3, HealPoints.diff4);
			frame:Show();
		elseif (HealPoints.diff1 ~= 0 or HealPoints.diff2 ~= 0) then
			addLine("HealPoints difference:", HealPoints.diff1, HealPoints.diff2);
			frame:Show();
		end;
	end;
end

function HealPoints:listScannedBonuses()
  local _, className = UnitClass("player");
  DEFAULT_CHAT_FRAME:AddMessage("Special set/equip bonuses detected by HealPoints:",1,1,1);
  DEFAULT_CHAT_FRAME:AddMessage("==========================================",1,1,1);
  DEFAULT_CHAT_FRAME:AddMessage("# % mana regeneration while casting: "..HealPointsBS:GetBonus('CASTINGREG'),1,1,1);		
  DEFAULT_CHAT_FRAME:AddMessage("# Increased spell crit chance in %: "..HealPointsBS:GetBonus('SPELLCRIT'),1,1,1);
  if (className == "PALADIN") then
    DEFAULT_CHAT_FRAME:AddMessage("# Reduced casting time Holy Light: 0."..HealPointsBS:GetBonus('CASTINGHOLYLIGHT'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Additional +healing for Flash of Light: "..HealPointsBS:GetBonus('IMPFLASHOFLIGHT'),1,1,1);
  elseif (className == "PRIEST") then
    DEFAULT_CHAT_FRAME:AddMessage("# Reduced casting time Flash Heal: 0."..HealPointsBS:GetBonus('CASTINGFLASHHEAL'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Increased duration Renew: "..HealPointsBS:GetBonus('DURATIONRENEW'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Increased Holy spell crit chance in %: "..HealPointsBS:GetBonus('HOLYCRIT'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Greater Heals also gives a renew effect equal to renew rank "..HealPointsBS:GetBonus('GHEALRENEW'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Reduced mana cost Renew in %: "..HealPointsBS:GetBonus('CHEAPERRENEW'),1,1,1);
  elseif (className == "DRUID") then
    DEFAULT_CHAT_FRAME:AddMessage("# Reduced casting time Regrowth: 0."..HealPointsBS:GetBonus('CASTINGREGROWTH'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Reduced casting time Healing Touch: 0."..HealPointsBS:GetBonus('CASTINGHEALINGTOUCH'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Increased duration Rejuvenation: "..HealPointsBS:GetBonus('DURATIONREJUV'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Increased Nature spell crit chance in %: "..HealPointsBS:GetBonus('NATURECRIT'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Additional +healing for Rejuvenation: "..HealPointsBS:GetBonus('IMPREJUVENATION'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Reduced mana cost healing spells in %: "..HealPointsBS:GetBonus('CHEAPERDRUID'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# On Healing Touch critical hits, you regain "..HealPointsBS:GetBonus('REFUNDHTCRIT').."% of its mana cost",1,1,1);
  elseif (className == "SHAMAN") then
    DEFAULT_CHAT_FRAME:AddMessage("# Reduced casting time Chain Heal: 0."..HealPointsBS:GetBonus('CASTINGCHAINHEAL'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Increased Nature spell crit chance in %: "..HealPointsBS:GetBonus('NATURECRIT'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Additional +healing for Lesser Healing Wave: "..HealPointsBS:GetBonus('IMPLESSERHEALINGWAVE'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Increased amount healed by Chain Heal to targets beyond first in %: "..HealPointsBS:GetBonus('IMPCHAINHEAL'),1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# 25% chance when casting (Lesser) Healing Wave to get "..HealPointsBS:GetBonus('REFUNDHEALINGWAVE').. "% of the mana cost refunded",1,1,1);
    DEFAULT_CHAT_FRAME:AddMessage("# Healing Wave jumps to two targets with an effect reduction of : "..HealPointsBS:GetBonus('JUMPHEALINGWAVE').."% (0% = no jumping)",1,1,1);
  end
end
