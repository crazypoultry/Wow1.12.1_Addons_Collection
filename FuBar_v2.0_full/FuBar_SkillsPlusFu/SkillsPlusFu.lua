SkillsPlusFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0",
                                              "AceConsole-2.0", 
                                              "AceDB-2.0",
                                              "AceEvent-2.0",
                                              "AceHook-2.0"
                                              )
-- variables
local L          = AceLibrary("AceLocale-2.1"):GetInstance("SkillsPlusFu", true)
local BR         = AceLibrary("Babble-Race-2.0")
local BS         = AceLibrary("Babble-Spell-2.0")
local tablet     = AceLibrary("Tablet-2.0")
local dewdrop    = AceLibrary("Dewdrop-2.0")
local metrognome = AceLibrary("Metrognome-2.0") 
local chosenProfession = L["FUBAR_LABEL"]
local toonSaveKey = ''
local toonFaction = ''

-- set properties                                             
SkillsPlusFu.clickableTooltip = true
SkillsPlusFu.canHideText      = true
SkillsPlusFu.defaultPosition  = "RIGHT"
SkillsPlusFu.hasIcon          = BS:GetSpellIcon("Engineering")
SkillsPlusFu.hasNoColor       = true

-- register stuff
SkillsPlusFu:RegisterDB("SkillsPlusFuDB")
SkillsPlusFu:RegisterDefaults("char", {hidden = {}} )
SkillsPlusFu:RegisterDefaults("profile", {
                                  -- flags
                                  showBooleanSkills = false,
                                  showCrossFactionSkills = false,
                                  showNotification = false,
                                  showOtherToonSkills = false,
                                  showPlayerNames = true,
                                  showSkillLabel = true,
                                  -- lists
                                  cooldownSave = {},
                                  toonSave = {},
                                  skillsSave = {},
                                  }
                              )

-- menu toggles

function SkillsPlusFu:IsShowingSkillLabel()
	return self.db.profile.showSkillLabel
end

function SkillsPlusFu:ToggleShowingSkillLabel()
	self.db.profile.showSkillLabel = not self.db.profile.showSkillLabel
	self:UpdateText()
	return self.db.profile.showSkillLabel
end

function SkillsPlusFu:IsShowingOtherToonSkills()
	return self.db.profile.showOtherToonSkills
end

function SkillsPlusFu:ToggleOtherToonSkills()
	self.db.profile.showOtherToonSkills = not self.db.profile.showOtherToonSkills
    self:Update()
	return self.db.profile.showOtherToonSkills
end

function SkillsPlusFu:IsShowingCrossFactionSkills()
	return self.db.profile.showCrossFactionSkills
end

function SkillsPlusFu:ToggleCrossFactionSkills()
	self.db.profile.showCrossFactionSkills = not self.db.profile.showCrossFactionSkills
    self:Update()
	return self.db.profile.showCrossFactionSkills
end

function SkillsPlusFu:IsShowingBooleanSkills()
	return self.db.profile.showBooleanSkills
end

function SkillsPlusFu:ToggleShowingBooleanSkills()
	self.db.profile.showBooleanSkills = not self.db.profile.showBooleanSkills
	self:UpdateTooltip()
	return self.db.profile.showBooleanSkills
end

function SkillsPlusFu:IsShowingPlayerNames()
	return self.db.profile.showPlayerNames
end

function SkillsPlusFu:ToggleShowingPlayerNames()
	self.db.profile.showPlayerNames = not self.db.profile.showPlayerNames
	self:UpdateTooltip()
	return self.db.profile.showPlayerNames
end

function SkillsPlusFu:IsShowNotification()
	return self.db.profile.showNotification
end

function SkillsPlusFu:ToggleShowNotification()
	self.db.profile.showNotification = not self.db.profile.showNotification
	self:UpdateTooltip()
	return self.db.profile.showNotification
end

-- update

function SkillsPlusFu:OnUpdate(difference)
	if(self:IsShowNotification()) then
		for k, v in self.db.profile.cooldownSave do
			for itemName, itemTable in v do
				local remaining = ((itemTable.Cooldown + itemTable.LastCheck) - time())
				if (remaining <= COOLDOWN_NOTIFYTIME) then
					if (self.db.profile.cooldownSave[k][itemName].IsReady ~= 1) then
        				local _, _, realm, player = string.find(k, '^(.+)\|(.+)$')
        				if (remaining <= 0) then
							DEFAULT_CHAT_FRAME:AddMessage(format(L["COOLDOWN_IS_READY"], itemName, realm, player))
						else
							DEFAULT_CHAT_FRAME:AddMessage(format(L["COOLDOWN_WILL_BE_READY"], itemName, realm, player))
						end
						PlaySound('AuctionWindowOpen')
						self.db.profile.cooldownSave[k][itemName].IsReady = 1
						self:Update()
					end
				end
			end
		end
	end
end

-- init/exit functions

function SkillsPlusFu:OnInitialize()
	self.skillList = {}
end

function SkillsPlusFu:OnEnable()
    -- skills management
	self:RegisterEvent('SKILL_LINES_CHANGED','Update') 
	self:RegisterEvent('PLAYER_LEVEL_UP','Update')
	
    -- cooldown management
   	metrognome:Register(self.name, self.OnUpdate, COOLDOWN_TIMER_FREQUENCY, self)
	metrognome:Start(self.name)
    self:RegisterEvent('TRADE_SKILL_UPDATE')
    self:RegisterEvent('CHAT_MSG_SPELL_TRADESKILLS')
    self:RegisterEvent('CHAT_MSG_LOOT')
    
    -- variables
    toonSaveKey = GetCVar('realmName')..'|'..UnitName('player')
    local toonRace = UnitRace('player')
    if (toonRace == BR"Orc") or
       (toonRace == BR"Tauren") or
       (toonRace == BR"Troll") or
       (toonRace == BR"Undead") then 
        toonFaction = L["SP_FACTION_HORDE"] 
    else toonFaction = L["SP_FACTION_ALLIANCE"] end
    self:UpdateToonInfo()
 end

function SkillsPlusFu:OnDisable()
	metrognome:Unregister(self.name)
end

-- toon management

function SkillsPlusFu:UpdateToonInfo()
    if (self.db.profile.toonSave[toonSaveKey] == nil) then
        self.db.profile.toonSave[toonSaveKey] = {}
    end
    if self.db.profile.toonSave[toonSaveKey].Faction == nil then
        self.db.profile.toonSave[toonSaveKey].Faction = toonFaction
    end
    if (chosenProfession == L["FUBAR_LABEL"]) and 
       (self.db.profile.toonSave[toonSaveKey].LastUsed ~= nil) then
        chosenProfession = self.db.profile.toonSave[toonSaveKey].LastUsed
    else 
        self.db.profile.toonSave[toonSaveKey].LastUsed = chosenProfession
    end
end

function SkillsPlusFu:ShowEntry(toonKey)
    if self.db.profile.toonSave[toonKey] == nil then
        return self:IsShowingCrossFactionSkills()
    else 
        if self.db.profile.toonSave[toonKey].Faction == nil then
            return self:IsShowingCrossFactionSkills()
       else
            return (toonFaction == self.db.profile.toonSave[toonKey].Faction) or (self:IsShowingCrossFactionSkills())
        end
    end
end
-- cooldown management

function SkillsPlusFu:CooldownRemaining(timeStamp)
    local timeRemaining = {}
          timeRemaining.d = 0
          timeRemaining.h = 0
          timeRemaining.m = 0
          timeRemaining.s = 0

    -- 86,400 seconds equals one day
    if (timeStamp >= 86400) then
        timeRemaining.d = floor(timeStamp / 86400)
        timeStamp = (timeStamp - (timeRemaining.d * 86400))
    end
    -- 3,600 seconds equals one hour
    if (timeStamp >= 3600) then
        timeRemaining.h = floor(timeStamp / 3600)
        timeStamp = (timeStamp - (timeRemaining.h * 3600))
    end
    -- 60 seconds equals one minute
    if ( timeStamp >= 60 ) then
        timeRemaining.m = floor(timeStamp / 60)
        timeStamp = (timeStamp - (timeRemaining.m * 60))
    end
    -- add remaining seconds
    timeRemaining.s = timeStamp
    
    return timeRemaining
end

function SkillsPlusFu:TRADE_SKILL_UPDATE()
	local numSkills = GetNumTradeSkills()
	for i=1, numSkills do
		local itemName = GetTradeSkillInfo(i)
		local cooldown = GetTradeSkillCooldown(i)

		-- check for transmute only, all transmutes share the same cooldown
		if (string.find(itemName, L["COOLDOWN_TRANSMUTE_MATCH"])) then
			itemName = L["COOLDOWN_TRANSMUTES"]
		end
		if (itemName == L["COOLDOWN_TRANSMUTES"] or
            itemName == L["COOLDOWN_MOONCLOTH"]) then
			if (cooldown == nil) then
				cooldown = 0
			end
		    if (self.db.profile.cooldownSave[toonSaveKey] == nil) then
    		    self.db.profile.cooldownSave[toonSaveKey] = {}
	        end
            if (self.db.profile.cooldownSave[toonSaveKey][itemName] == nil) then
			    self.db.profile.cooldownSave[toonSaveKey][itemName] = {}
	        end
            self.db.profile.cooldownSave[toonSaveKey][itemName].Cooldown = cooldown
    	    self.db.profile.cooldownSave[toonSaveKey][itemName].LastCheck = time()
    	    self.db.profile.cooldownSave[toonSaveKey][itemName].IsReady = 0
  	    end
	end
	self:Update()
end

function SkillsPlusFu:CHAT_MSG_SPELL_TRADESKILLS()
	local _, _, created
    created = string.find(arg1, L["COOLDOWN_CREATE_ITEM"]);
    if (created and string.find(arg1, L["COOLDOWN_SNOWBALL"])) then
        -- we found a snowball
      	local itemName = L["COOLDOWN_SNOWMASTER"]
        if (self.db.profile.cooldownSave[toonSaveKey] == nil) then
       	    self.db.profile.cooldownSave[toonSaveKey] = {}
        end
        if (cooldownSave[toonSaveKey][itemName] == nil) then
    	    cooldownSave[toonSaveKey][itemName] = {}
        end
        self.db.profile.cooldownSave[toonSaveKey][itemName].Cooldown = 86400
        self.db.profile.cooldownSave[toonSaveKey][itemName].LastCheck = time()
        self.db.profile.cooldownSave[toonSaveKey][itemName].IsReady = 0
    elseif (created and string.find(arg1, L["COOLDOWN_REFINED_SALT"])) then
        -- we found refined salt
		local itemName = L["COOLDOWN_SALT_SHAKER"]
        if (self.db.profile.cooldownSave[toonSaveKey] == nil) then
         	self.db.profile.cooldownSave[toonSaveKey] = {}
        end
        if (self.db.profile.cooldownSave[toonSaveKey][itemName] == nil) then
        	self.db.profile.cooldownSave[toonSaveKey][itemName] = {}
        end
        self.db.profile.cooldownSave[toonSaveKey][itemName].Cooldown = 259200
        self.db.profile.cooldownSave[toonSaveKey][itemName].LastCheck = time()
        self.db.profile.cooldownSave[toonSaveKey][itemName].IsReady = 0
    end
    self:Update()
end

function SkillsPlusFu:CHAT_MSG_LOOT()
	if (string.find(arg1, L["COOLDOWN_ELUNE_STONE"])) then
     	local itemName = L["COOLDOWN_ELUNES_LANTERN"]
      	if (self.db.profile.cooldownSave[toonSaveKey] == nil) then
          	self.db.profile.cooldownSave[toonSaveKey] = {}
        end
        if (self.db.profile.cooldownSave[toonSaveKey][itemName] == nil) then
        	self.db.profile.cooldownSave[toonSaveKey][itemName] = {}
        end
        self.db.profile.cooldownSave[toonSaveKey][itemName].Cooldown = 86400
        self.db.profile.cooldownSave[toonSaveKey][itemName].LastCheck = time()
        self.db.profile.cooldownSave[toonSaveKey][itemName].IsReady = 0
    end
    self:Update()
end

function SkillsPlusFu:ClearCooldownData()
	self.db.profile.cooldownSave = {}
	self:Update()
end

-- skills management

function SkillsPlusFu:AddProfessionMenu(skillName)
        if (skillName == BS"Alchemy") then
       		dewdrop:AddLine(
        		'text', BS"Alchemy",
	        	'func', function() CastSpellByName(BS"Alchemy")
                                   self:UpdateText(BS"Alchemy",BS:GetSpellIcon("Alchemy"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Blacksmithing") then
       		dewdrop:AddLine(
        		'text', BS"Blacksmithing",
	        	'func', function() CastSpellByName(BS"Blacksmithing")
                                   self:UpdateText(BS"Blacksmithing",BS:GetSpellIcon("Blacksmithing"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Cooking") then
       		dewdrop:AddLine(
        		'text', BS"Cooking",
	        	'func', function() CastSpellByName(BS"Cooking")
                                   self:UpdateText(BS"Cooking",BS:GetSpellIcon("Cooking"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Enchanting") then
       		dewdrop:AddLine(
        		'text', BS"Disenchant",
	        	'func', function() CastSpellByName(BS"Disenchant")
                                   self:UpdateText(BS"Disenchant",BS:GetSpellIcon("Disenchant"))
                        end,
       			'arg1', self
                )
       		dewdrop:AddLine(
        		'text', BS"Enchanting",
	        	'func', function() CastSpellByName(BS"Enchanting")
                                   self:UpdateText(BS"Enchanting",BS:GetSpellIcon("Enchanting"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Engineering") then
       		dewdrop:AddLine(
        		'text', BS"Engineering",
	        	'func', function() CastSpellByName(BS"Engineering")
                                   self:UpdateText(BS"Engineering",BS:GetSpellIcon("Engineering"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"First Aid") then
       		dewdrop:AddLine(
        		'text', BS"First Aid",
	        	'func', function() CastSpellByName(BS"First Aid")
                                   self:UpdateText(BS"First Aid",BS:GetSpellIcon("First Aid"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Fishing") then
       		dewdrop:AddLine(
        		'text', BS"Fishing",
	        	'func', function() CastSpellByName(BS"Fishing")
                                   self:UpdateText(BS"Fishing",BS:GetSpellIcon("Fishing"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Leatherworking") then
       		dewdrop:AddLine(
        		'text', BS"Leatherworking",
	        	'func', function() CastSpellByName(BS"Leatherworking")
                                   self:UpdateText(BS"Leatherworking",BS:GetSpellIcon("Leatherworking"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Lockpicking") then
       		dewdrop:AddLine(
        		'text', BS"Lockpicking",
	        	'func', function() CastSpellByName(BS"Pick Lock")
                                   self:UpdateText(BS"Pick Lock",BS:GetSpellIcon("Pick Lock"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Mining") then
       		dewdrop:AddLine(
        		'text', BS"Smelting",
	        	'func', function() CastSpellByName(BS"Smelting")
                                   self:UpdateText(BS"Smelting",BS:GetSpellIcon("Smelting"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Poisons") then
       		dewdrop:AddLine(
        		'text', BS"Poisons",
	        	'func', function() CastSpellByName(BS"Poisons")
                                   self:UpdateText(BS"Poisons",BS:GetSpellIcon("Poisons"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Tailoring") then
       		dewdrop:AddLine(
        		'text', BS"Tailoring",
	        	'func', function() CastSpellByName(BS"Tailoring")
                                   self:UpdateText(BS"Tailoring",BS:GetSpellIcon("Tailoring"))
                        end,
       			'arg1', self
                )
        end
end

function SkillsPlusFu:OnMenuRequest(level, value)
	if level == 1 then
        	for _,category in self.skillList do
	        	if category.nonBooleanSkills > 0 then
        		        for _,skill in category.skills do
                                        self:IsProfession(skill.name)
                                end
                        end
                end
       		if (GetNumSkillLines() > 0) then dewdrop:AddLine() end
		dewdrop:AddLine(
			'text', L["MENU_SHOW_BOOLEAN_SKILLS"],
			'func', 'ToggleShowingBooleanSkills',
			'arg1', self,
			'checked', self:IsShowingBooleanSkills()
		)
	end
end

function SkillsPlusFu:SaveProfession(skillName,skillRank,skillMaxRank,skillModifier)
    if (skillName == BS"Alchemy") or
       (skillName == BS"Blacksmithing") or
       (skillName == BS"Cooking") or
       (skillName == BS"Enchanting") or
       (skillName == BS"Enchanting") or
       (skillName == BS"First Aid") or
       (skillName == BS"Leatherworking") or
       (skillName == BS"Tailoring") then
      	if (self.db.profile.skillsSave[toonSaveKey] == nil) then
          	self.db.profile.skillsSave[toonSaveKey] = {}
         end
         if (self.db.profile.skillsSave[toonSaveKey][skillName] == nil) then
        	self.db.profile.skillsSave[toonSaveKey][skillName] = {}
        end
        self.db.profile.skillsSave[toonSaveKey][skillName].Rank = skillRank
        self.db.profile.skillsSave[toonSaveKey][skillName].MaxRank = skillMaxRank
        self.db.profile.skillsSave[toonSaveKey][skillName].Modifier = skillModifier
    end
end

-- general

function SkillsPlusFu:OnMenuRequest(level, value)
	if level == 1 then
        local cooldownFound = false
    	for _,category in self.skillList do
            -- items are added with other toon skills following cooldown items
            -- just stop adding skill menus when cooldown entry is found to stop
            -- other toon skills showing up in the menu
            if not cooldownFound then
  	    	    if category.nonBooleanSkills > 0 then
    		        for _,skill in category.skills do 
                        self:AddProfessionMenu(skill.name)
                    end
                end
                cooldownFound = category.category == L["COOLDOWN_CATEGORY"]                
            end
        end
        
       	if (GetNumSkillLines() > 0) then dewdrop:AddLine() end
       	-- add regular menu options
		dewdrop:AddLine(
			'text', L["MENU_SHOW_SKILL_LABEL"],       -- toggles skill name in fubar menu
    		'func', 'ToggleShowingSkillLabel',
 			'arg1', self,
			'checked', self:IsShowingSkillLabel()
		)
		dewdrop:AddLine(
			'text', L["MENU_SHOW_BOOLEAN_SKILLS"],    -- toggles boolean skill visibility
			'func', 'ToggleShowingBooleanSkills',
			'arg1', self,
			'checked', self:IsShowingBooleanSkills()
		)
		dewdrop:AddLine(
			'text', L["MENU_SHOW_OTHER_TOON_SKILLS"], -- toggles other player skills
			'func', 'ToggleOtherToonSkills',
			'arg1', self,
			'checked', self:IsShowingOtherToonSkills()
		)
		dewdrop:AddLine(
			'text', L["MENU_SHOW_CROSS_FACTION_SKILLS"], -- toggles cross faction skills
			'func', 'ToggleCrossFactionSkills',
			'arg1', self,
			'checked', self:IsShowingCrossFactionSkills()
		)
		dewdrop:AddLine()                                 -- separator
		dewdrop:AddLine(
			'text', L["MENU_SHOW_TOON_NAMES"],        -- toggles player names in cooldown items
			'func', 'ToggleShowingPlayerNames',
			'arg1', self,
			'checked', self:IsShowingPlayerNames()
		)
		dewdrop:AddLine(
			'text', L["MENU_SHOW_NOTIFICATION"],      -- toggles cooldown notification
			'func', 'ToggleShowNotification',
			'arg1', self,
			'checked', self:IsShowNotification ()
		)
		dewdrop:AddLine(
			'text', L["MENU_CLEAR_COOLDOWN_DATA"],    -- clears saved cooldown data
			'func', 'ClearCooldownData',
			'arg1', self
		)
	end
end

function SkillsPlusFu:OnDataUpdate()
	local skillIndex = 0
	local skillList = {}
	local headerIndex = 0
	
	local numSkills = GetNumSkillLines()
	
	for skillIndex=1, numSkills do
		local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank,
              isAbandonable, stepCost, rankCost, minLevel, skillCostType,
              skillDesc = GetSkillLineInfo(skillIndex)
		
		if isHeader then
			headerIndex = headerIndex + 1
			table.insert(skillList, {category=skillName, skills={}, nonBooleanSkills = 0})
		else
			if skillMaxRank > 1 then
              skillList[headerIndex].nonBooleanSkills = skillList[headerIndex].nonBooleanSkills + 1
            end
			table.insert(skillList[headerIndex].skills, {name = skillName,  rank = skillRank,
                         maxrank = skillMaxRank, rankbonus = skillModifier})
            self:SaveProfession(skillName,skillRank,skillMaxRank,skillModifier)
 		end
	end
	
	-- add cooldown header and items
	local toonName = ''
	headerIndex = headerIndex + 1
	table.insert(skillList, {category=L["COOLDOWN_CATEGORY"], skills={}, nonBooleanSkills = 0})
    for k, v in self.db.profile.cooldownSave do
        if self:IsShowingPlayerNames() then
          toonName = string.sub(k,string.find(k,'|')+1)..': '
        end
        for itemName, itemTable in v do
            skillList[headerIndex].nonBooleanSkills = skillList[headerIndex].nonBooleanSkills + 1
            table.insert(skillList[headerIndex].skills, {name = toonName..itemName,
                         rank = itemTable.Cooldown,
                         maxrank = itemTable.LastCheck,
                         rankbonus = itemTable.IsReady}
                        )
        end
    end
    
    -- add other toon skills
    if self.db.profile.showOtherToonSkills then
        for k, v in self.db.profile.skillsSave do
            toonName = string.sub(k,string.find(k,'|')+1)
            local realmName = string.sub(k,1,string.find(k,'|')-1)
            if (toonName ~= UnitName('player')) and
               (self:ShowEntry(k)) and
               (realmName == GetCVar('realmName')) then
  	            headerIndex = headerIndex + 1
	            table.insert(skillList, {category=toonName, skills={}, nonBooleanSkills = 0})
	            for skillName, skillTable in v do
                    skillList[headerIndex].nonBooleanSkills = skillList[headerIndex].nonBooleanSkills + 1
                    table.insert(skillList[headerIndex].skills, {name = skillName,
                                 rank = skillTable.Rank,
                                 maxrank = skillTable.MaxRank,
                                 rankbonus = skillTable.Modifier}
                                )
    	        end
	        end
        end
    end
    
	self.skillList = skillList
end

function SkillsPlusFu:UpdateText(newProfession,newIcon)
    if newProfession ~= nil then 
        chosenProfession = newProfession 
        self:UpdateToonInfo()  -- set lastUsed variable
    end
    if newIcon ~= nil then self:SetIcon(newIcon) end

    -- add cooldown information
	local cooldownInfo = ''
    local totalItems = 0
    local readyItems = 0
    
    -- loop and add items and ready items
    for k, v in self.db.profile.cooldownSave do
  	    for itemName, itemTable in v do
	        local remaining = ((itemTable.Cooldown + itemTable.LastCheck) - time())
    	        totalItems = totalItems + 1
	        if (remaining <= 0) then
  	  	        readyItems = readyItems + 1
    	    end
  	    end
    end
    
    -- only show cooldownInfo if there are cooldown items
    if (totalItems > 0) then
        -- set label text count colours
        local colorCode = L["COOLDOWN_COLOR_READY"]
        if (readyItems == 0) then
            colorCode = L["COOLDOWN_COLOR_NOTREADY"]
        end
        cooldownInfo = format(colorCode..L["COOLDOWN_FORMAT"]..FONT_COLOR_CODE_CLOSE, readyItems, totalItems)
    end
    
    -- add skill label is toggle is true
    if self:IsShowingSkillLabel() then
        self.labelName = chosenProfession..' '..cooldownInfo
	else
	    self.labelName = cooldownInfo
    end
    
    -- set the actual label
	self:SetText(self.labelName)
	
	dewdrop:Close()
end

function SkillsPlusFu:ToggleCategory(id, button)
    -- hidden is character specific data
    self.db.char.hidden[id] = not self.db.char.hidden[id]
	-- refresh in place
	self:UpdateTooltip()
end

function SkillsPlusFu:OnTooltipUpdate()
	tablet:SetHint(L["TOOLTIP_HINT"])
	-- skills
	for _,category in self.skillList do
		if category.nonBooleanSkills > 0 or self:IsShowingBooleanSkills() then
			local tooltipLine = tablet:AddCategory('id', category.category, 'columns', 2,
				    		       'text', category.category,
							       'func', 'ToggleCategory', 'arg1', self, 'arg2', category.category,
							       'child_textR', 1, 'child_textG', 1, 'child_textB', 0,
							       'showWithoutChildren', true,
							       'checked', true, 'hasCheck', true, 'checkIcon',
                                   self.db.char.hidden[category.category] and 'Interface\\Buttons\\UI-PlusButton-Up' or 'Interface\\Buttons\\UI-MinusButton-Up'
			)
			if not self.db.char.hidden[category.category] then
				for _,skill in category.skills do
                    if category.category ~= L["COOLDOWN_CATEGORY"] then
                        -- is either current toon skill or other toon skill
					    if skill.maxrank > 1 then
					    	local rank = skill.rank
						    if skill.rankbonus > 0  then
							    rank = rank..'(+'..skill.rankbonus..')'
						    end
						    rank = rank..'/'..skill.maxrank
						    local r,g,b = FuBarUtils.GetThresholdColor((skill.rank+(skill.rankbonus or 0)) / skill.maxrank)
						    tooltipLine:AddLine('text', skill.name, 'text2', rank,
							                    'text2R', r, 'text2G', g, 'text2B', b)
					    elseif self:IsShowingBooleanSkills() then
						    tooltipLine:AddLine('text', skill.name)
                        end
                    else  -- is cooldown item
                        -- rank contains itemTable.Cooldown, max rank contains itemTable.LastCheck
    	       	       	local timeRemaining = ((skill.rank + skill.maxrank) - time())
    	       	       	local timeRemainingText = ''

    	       	       	if (timeRemaining <= 0) then
            	    	    timeRemainingText = L["COOLDOWN_COLOR_READY"]..L["COOLDOWN_READY"]
         	       	    else
      	                    local timeTable = self:CooldownRemaining(timeRemaining)
                            local timeString = string.format('%dD %02d:%02d', timeTable.d, timeTable.h, timeTable.m)
                            if ((timeTable.d == 0) and (timeTable.h == 0)) then
    	                       timeRemainingText = L["COOLDOWN_COLOR_ALMOSTREADY"]..timeString
                            else
    	                        timeRemainingText = L["COOLDOWN_COLOR_NOTREADY"]..timeString
                            end
                        end
					    tooltipLine:AddLine('text', skill.name, 'text2', timeRemainingText)
					end
				end
			end
		end
	end
end

function SkillsPlusFu:OnClick()
    if self.chosenProfession == L["FUBAR_LABEL"] then
        ToggleCharacter('SkillFrame')
    else
    	CastSpellByName(chosenProfession)
    end
end
