local tablet = AceLibrary("Tablet-2.0")
local compost = AceLibrary("Compost-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local babbleclass = AceLibrary("Babble-Class-2.0")
local deformatter = AceLibrary("Deformat-2.0")
local crayon = AceLibrary("Crayon-2.0")

local L = AceLibrary("AceLocale-2.1"):GetInstance("GroupFu", true)

GroupFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
GroupFu:RegisterDB("GroupFuDB")
GroupFu:RegisterDefaults(
    'profile', {
        RollOnClick = true,
        ShowMLName = false,
        OutputChannel = "PARTY",
        OutputDetail = "SHORT",
        ClearTimer = 30,
        StandardRollsOnly = true,
        ShowRollCount = false,
        AnnounceRollCountdown = false,
        IgnoreDuplicates = true,
        DeleteRolls = true,
        ShowClassLevel = false,
        TextMode = "GROUPFU",
    }
)

GroupFu.name = L["Name"]
GroupFu.title = L["Name"]
GroupFu.notes = L["Description"]
GroupFu.version = "2.0" .. string.sub("$Rev: 11078 $", 12, -3)
GroupFu.date = string.sub("$Date: 2006-09-16 14:16:53 -0600 (Sat, 16 Sep 2006) $", 8, 17);
GroupFu.category = "Miscellaneous"
GroupFu.email = "idbrain@gmail.com"
GroupFu.website = "http://etten.wowinterface.com"

GroupFu.hasIcon = L["DefaultIcon"]
GroupFu.clickableTooltip = false
GroupFu.cannotHideText = true

local tmpdata = {}
local garbage

-- Build the menu
function GroupFu:OnMenuRequest(level, value, inTooltip)
	if not inTooltip then
		if level == 1 then
            -- Text Mode Menu
			dewdrop:AddLine(
				'text', L["MenuMode"],
				'value', "MenuMode",
				'hasArrow', true
			);
            
            -- Roll Options Menu
			dewdrop:AddLine(
				'text', L["MenuRollOpts"],
				'value', "MenuRollOpts",
                'disabled', self:IsTextMode("LOOTTYFU"),
				'hasArrow', true
			);

            -- Loot Options Menu
			dewdrop:AddLine(
				'text', L["MenuLootDispOpts"],
				'value', "MenuLootDispOpts",
				'hasArrow', true
			);

            -- Group Management Menu
			dewdrop:AddLine(
				'text', L["MenuGroup"],
				'value', "MenuGroup",
				'hasArrow', true
			);
        
		elseif level == 2 then
		
            if value == "MenuMode" then
			
                -- GroupFu Mode Radio
				dewdrop:AddLine(
					'text', L["MenuModeGroupFu"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleTextMode("GROUPFU") end,
					'checked', self:IsTextMode("GROUPFU")
				)
				
                -- RollsFu Mode Radio
				dewdrop:AddLine(
					'text', L["MenuModeRollsFu"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleTextMode("ROLLSFU") end,
					'checked', self:IsTextMode("ROLLSFU")
				)
				
                -- LootTyFu Mode Radio
				dewdrop:AddLine(
					'text', L["MenuModeLootTyFu"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleTextMode("LOOTTYFU") end,
					'checked', self:IsTextMode("LOOTTYFU")
				)
                
            elseif value == "MenuRollOpts" then
                
                -- Roll on click Checkbox
                dewdrop:AddLine(
                    'text', L["MenuRollOptsPerformRoll"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("RollOnClick") end,
                    'checked', self.db.profile.RollOnClick
                )
                
                -- Accept Standard Rolls Only Checkbox
                dewdrop:AddLine(
                    'text', L["MenuRollOptsStdRollsOnly"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("StandardRollsOnly") end,
                    'checked', self.db.profile.StandardRollsOnly
                )	
                
                -- Show roll counts checkbox
                dewdrop:AddLine(
                    'text', L["MenuRollOptsShowRollCount"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("ShowRollCount") end,
                    'checked', self.db.profile.ShowRollCount
                )	
                
                -- Ignore duplicate Rolls
                dewdrop:AddLine(
                    'text', L["MenuRollOptsIgnoreDupes"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("IgnoreDuplicates") end,
                    'checked', self.db.profile.IgnoreDuplicates
                )
                
                -- Auto delete rolls when clear timer reached
                dewdrop:AddLine(
                    'text', L["MenuRollOptsAutoDelRolls"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("DeleteRolls") end,
                    'checked', self.db.profile.DeleteRolls
                )

                -- Announce Roll Countdown
                dewdrop:AddLine(
                    'text', L["MenuRollOptsUseRollCntdwn"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("AnnounceRollCountdown") end,
                    'checked', self.db.profile.AnnounceRollCountdown
                )

                -- Show class and level in tooltip
                dewdrop:AddLine(
                    'text', L["MenuRollOptsShowClassNLevel"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("ShowClassLevel") end,
                    'checked', self.db.profile.ShowClassLevel
                )
                
                -- Where to spam Menu
                dewdrop:AddLine(
                    'text', L["MenuRollOptsOutput"],
                    'value', "MenuRollOptsOutput",
                    'hasArrow', true
                )
                
                -- Clear Timer
                dewdrop:AddLine(
                    'text', L["MenuRollOptsClear"],
                    'value', "MenuRollOptsClear",
                    'hasArrow', true
                )
                
                -- Output Detail Menu
                dewdrop:AddLine(
                    'text', L["MenuRollOptsDetail"],
                    'value', "MenuRollOptsDetail",
                    'hasArrow', true
                )
                
                
            elseif value == "MenuLootDispOpts" then
                
                -- Show master looter's name checkbox
                dewdrop:AddLine(
                    'text', L["MenuLootDispOptsShowMLName"],
                    'closeWhenClicked', true,
                    'func', function() self:ToggleOption("ShowMLName") end,
                    'checked', self.db.profile.ShowMLName
                )
                
            elseif value == "MenuGroup" then
                
                -- Leave group button
				dewdrop:AddLine(
					'text', L["MenuGroupLeave"],
					'notCheckable', true,
                    'closeWhenClicked', true,
					'func', function() LeaveParty() end,
                    'disabled', not self:IsInParty()
				)
                
                -- Convert to raid button
                dewdrop:AddLine(
                    'text', L["MenuGroupConvRaid"],
                    'notCheckable', true,
                    'closeWhenClicked', true,
                    'func', function() ConvertToRaid() end,
                    'disabled', not self:IsPartyOrRaidLeader()
                )
                
                -- Group Loot Method Menu
                dewdrop:AddLine(
                    'text', L["MenuGroupLootMethod"],
                    'value', "MenuGroupLootMethod",
                    'hasArrow', true,
                    'disabled', not self:IsPartyOrRaidLeader()
                )
                
                -- Group Loot Threshold Menu
                dewdrop:AddLine(
                    'text', L["MenuGroupLootThreshold"],
                    'value', "MenuGroupLootThreshold",
                    'hasArrow', true,
                    'disabled', not self:IsPartyOrRaidLeader()
                )
                
                -- Convert to raid button
                dewdrop:AddLine(
                    'text', L["MenuGroupResetInstance"],
                    'notCheckable', true,
                    'closeWhenClicked', true,
                    'func', function() ResetInstances() end,
                    'disabled', not CanShowResetInstances()
                )
                
            end
			
		elseif level == 3 then

			if value == "MenuRollOptsOutput" then
			
				dewdrop:AddLine(
					'text', L["MenuRollOptsOutputAuto"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputChannel("AUTO") end,
					'checked', self:IsOutputChannel("AUTO")
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsOutputLocal"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputChannel("LOCAL") end,
					'checked', self:IsOutputChannel("LOCAL")
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsOutputSay"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputChannel("SAY") end,
					'checked', self:IsOutputChannel("SAY")
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsOutputParty"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputChannel("PARTY") end,
					'checked', self:IsOutputChannel("PARTY")
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsOutputRaid"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputChannel("RAID") end,
					'checked', self:IsOutputChannel("RAID")
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsOutputGuild"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputChannel("GUILD") end,
					'checked', self:IsOutputChannel("GUILD")
				)
				
			elseif value == "MenuRollOptsClear" then
			
				dewdrop:AddLine(
					'text', L["MenuRollOptsClearNever"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleClearTimer(0) end,
					'checked', self:IsClearTimer(0)
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsClear15Sec"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleClearTimer(15) end,
					'checked', self:IsClearTimer(15)
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsClear30Sec"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleClearTimer(30) end,
					'checked', self:IsClearTimer(30)
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsClear45Sec"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleClearTimer(45) end,
					'checked', self:IsClearTimer(45)
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsClear60Sec"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleClearTimer(60) end,
					'checked', self:IsClearTimer(60)
				)
				
			elseif value == "MenuRollOptsDetail" then
			
				dewdrop:AddLine(
					'text', L["MenuRollOptsDetailShort"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputDetail("SHORT") end,
					'checked', self:IsOutputDetail("SHORT")
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsDetailLong"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputDetail("LONG") end,
					'checked', self:IsOutputDetail("LONG")
				)
				
				dewdrop:AddLine(
					'text', L["MenuRollOptsDetailFull"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:ToggleOutputDetail("FULL") end,
					'checked', self:IsOutputDetail("FULL")
				)
				
			elseif value == "MenuGroupLootMethod" then
                
				dewdrop:AddLine(
					'text', L["TextGroup"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:SetLootType("group") end,
					'checked', self:IsLootType("group")
				)
				
				dewdrop:AddLine(
					'text', L["TextFFA"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:SetLootType("freeforall") end,
					'checked', self:IsLootType("freeforall")
				)
				
				dewdrop:AddLine(
					'text', L["TextMaster"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:SetLootType("master") end,
					'checked', self:IsLootType("master")
				)
				
				dewdrop:AddLine(
					'text', L["TextNBG"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:SetLootType("needbeforegreed") end,
					'checked', self:IsLootType("needbeforegreed")
				)
				
				dewdrop:AddLine(
					'text', L["TextRR"],
					'isRadio', true,
                    'closeWhenClicked', true,
					'func', function() self:SetLootType("roundrobin") end,
					'checked', self:IsLootType("roundrobin")
				)
				
			elseif value == "MenuGroupLootThreshold" then
				local _, mnuGroupThrshldHex
				for j=0,6 do
					
					_, _, _, mnuGroupThrshldHex = GetItemQualityColor(j);

					dewdrop:AddLine(
						'text', crayon:Colorize(strsub(mnuGroupThrshldHex,5), getglobal("ITEM_QUALITY".. j .. "_DESC")),
						'func', function(val) self:SetLootThreshold(val) end,
						'arg1', j,
                        'closeWhenClicked', true,
						'isRadio', true,
						'checked', self:IsLootThreshold(j)
					)

				end
			end
		end
	end
end

function GroupFu:OnInitialize()

	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "Update")
	self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED", "Update")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "Update")

end

function GroupFu:OnEnable()

	self:ClearRolls()
    tmpdata.TimeSinceLastRoll = 0	
	self:ScheduleRepeatingEvent("MGtimer", self.CheckRollTimeout, 1, self)

end

function GroupFu:OnDisable()
	self:ClearRolls()
    tmpdata.TimeSinceLastRoll = 0	
end

function GroupFu:OnDataUpdate()

	if (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
		tmpdata.LootType = GetLootMethod()
		tmpdata.Threshold = GetLootThreshold()
	else
		tmpdata.LootType, tmpdata.Threshold = nil, nil
	end
	
	local i, highRoll, rollLink
	highRoll = 0
	if(tmpdata.RollCount > 0) then
	
		for i = 1, tmpdata.RollCount do
		
			if ((tmpdata.Rolls[i].Roll > highRoll) and ((not self.db.profile.StandardRollsOnly) or ((tmpdata.Rolls[i].Min == 1) and (tmpdata.Rolls[i].Max == 100))))  then
			
				highRoll = tmpdata.Rolls[i].Roll
				rollLink = i
				
			end
		end
		
		tmpdata.LastWinner = tmpdata.Rolls[rollLink].Player .. " [" .. crayon:Colorize("00FF00", highRoll) .. "]"
		
		if((tmpdata.Rolls[rollLink].Min ~= 1) or (tmpdata.Rolls[rollLink].Max ~= 100)) then
		
			tmpdata.LastWinner = tmpdata.LastWinner .. " (" .. tmpdata.Rolls[rollLink].Min .. "-" .. tmpdata.Rolls[rollLink].Max .. ")"
			
		end
		
	else
	
		tmpdata.LastWinner = nil
		
	end
end

function GroupFu:OnTextUpdate()

	if self.db.profile.TextMode == "ROLLSFU" then
	
		if tmpdata.LastWinner ~= nil then
		
			if self.db.profile.ShowRollCount then
			
				if GetNumRaidMembers() > 0 then
				
					self:SetText( string.format(L["FormatTextRollCount"], tmpdata.LastWinner, tmpdata.RollCount, GetNumRaidMembers()) )
				
				elseif GetNumPartyMembers() > 0 then
				
					self:SetText( string.format(L["FormatTextRollCount"], tmpdata.LastWinner, tmpdata.RollCount, GetNumPartyMembers()+1) )
				
				else
				
					self:SetText(tmpdata.LastWinner)
				
				end
			
			else
				
				self:SetText(tmpdata.LastWinner)
				
			end
			
		else
		
			self:SetText(L["TextNoRolls"])
			
		end	
		
	elseif self.db.profile.TextMode == "LOOTTYFU" then
	
			if tmpdata.LootType == solo then
				self:SetText(crayon:Colorize("888888", self:GetLootTypeText()))
			else
				if not tmpdata.Threshold then
					self:UpdateData()
				end
                local _,_,_,hex = GetItemQualityColor(tmpdata.Threshold)
				self:SetText(crayon:Colorize(strsub(hex,5), self:GetLootTypeText()))
			end
		
	else
	
		if tmpdata.LastWinner ~= nil then
		
			if self.db.profile.ShowRollCount then
			
				if GetNumRaidMembers() > 0 then
				
					self:SetText( string.format(L["FormatTextRollCount"], tmpdata.LastWinner, tmpdata.RollCount, GetNumRaidMembers()) )
				
				elseif GetNumPartyMembers() > 0 then
				
					self:SetText( string.format(L["FormatTextRollCount"], tmpdata.LastWinner, tmpdata.RollCount, GetNumPartyMembers()+1) )
				
				else
				
					self:SetText(tmpdata.LastWinner)
				
				end
			
			else
				
				self:SetText(tmpdata.LastWinner)
				
			end
			
		else
		
			if tmpdata.LootType == solo then
				self:SetText(crayon:Colorize("888888", self:GetLootTypeText()))
			else
				if not tmpdata.Threshold then
					self:UpdateData()
				end
                local _,_,_,hex = GetItemQualityColor(tmpdata.Threshold)
				self:SetText(crayon:Colorize(strsub(hex,5), self:GetLootTypeText()))
			end
			
		end
	end
end


function GroupFu:OnTooltipUpdate()
	
	local cat
	
	cat = tablet:AddCategory(
		'text', L["TooltipCatLooting"],
		'columns', 2
	)
	
	if tmpdata.LootType == "group" then
	
		if not tmpdata.Threshold then
			self:OnUpdateData()
		end
		cat:AddLine(
			'text', L["TooltipMethod"] .. ":",
			'text2', crayon:Colorize(crayon:GetThresholdHexColor(tmpdata.Threshold), L["TextGroup"])
		)
		
	elseif tmpdata.LootType == "master" then 
	
		if self.db.profile.ShowMLName and tmpdata.MLName then
		
			if not tmpdata.Threshold then
				self:OnUpdateData()
			end
			cat:AddLine(
				'text', L["TooltipMethod"] .. ":",
				'text2', crayon:Colorize(crayon:GetThresholdHexColor(tmpdata.Threshold), L["TextMaster"] .. "(" .. tmpdata.MLName .. ")")
			)
			
		else
		
			if not tmpdata.Threshold then
				self:OnUpdateData()
			end
			cat:AddLine(
				'text', L["TooltipMethod"] .. ":",
				'text2', crayon:Colorize(crayon:GetThresholdHexColor(tmpdata.Threshold), L["TextMaster"])
			)
			
		end
		
	elseif tmpdata.LootType == "freeforall" then
	
		if not tmpdata.Threshold then
			self:OnUpdateData()
		end
		cat:AddLine(
			'text', L["TooltipMethod"] .. ":",
			'text2', crayon:Colorize(crayon:GetThresholdHexColor(tmpdata.Threshold), L["TextFFA"])
		)
		
	elseif tmpdata.LootType == "roundrobin" then
	
		if not tmpdata.Threshold then
			self:UpdateData()
		end
		cat:AddLine(
			'text', L["TooltipMethod"] .. ":",
			'text2', crayon:Colorize(crayon:GetThresholdHexColor(tmpdata.Threshold), L["TextRR"])
		)
		
	elseif tmpdata.LootType == "needbeforegreed" then
	
		if not tmpdata.Threshold then
			self:UpdateData()
		end
		cat:AddLine(
			'text', L["TooltipMethod"] .. ":",
			'text2', crayon:Colorize(crayon:GetThresholdHexColor(tmpdata.Threshold), L["TextNBG"])
		)
		
	else 
	
		if not tmpdata.Threshold then
			self:UpdateData()
		end
		cat:AddLine(
			'text', L["TooltipMethod"] .. ":",
			'text2', crayon:Colorize("888888", L["TextSolo"])
		)
		
	end

	cat = tablet:AddCategory(
		'text', L["TooltipCatRolls"],
		'columns', 2
	)
	
	if(tmpdata.RollCount > 0) then
	
		local a, b, highRoll, rollLink, tallied, color, l, r

		if self.db.profile.ShowRollCount then
		
			if GetNumRaidMembers() > 0 then
			
				cat:AddLine(
					'text', string.format(L["FormatTooltipRollCount"], tmpdata.RollCount, GetNumRaidMembers() )
				)
			
			elseif GetNumPartyMembers() > 0 then
			
				cat:AddLine(
					'text', string.format(L["FormatTooltipRollCount"], tmpdata.RollCount, GetNumPartyMembers()+1 )
				)
			
			end
		
		end

		tallied = {}
		for a=1,tmpdata.RollCount do
			tallied[a] = 0
		end
		
		for a=1,tmpdata.RollCount do
		
			highRoll = 0
			rollLink = 0
			for b=1,tmpdata.RollCount do
			
				if((self.db.profile.StandardRollsOnly) and ((tmpdata.Rolls[b].Min ~= 1) or (tmpdata.Rolls[b].Max ~= 100))) then
					
					tallied[b] = 1
					
				end
				
				if((tmpdata.Rolls[b].Roll > highRoll) and (tallied[b] == 0)) then
					
					highRoll = tmpdata.Rolls[b].Roll
					rollLink = b
					
				end
				
			end
			
			if(rollLink ~= 0) then
			
				r = tmpdata.Rolls[rollLink].Player
				if(self.db.profile.ShowClassLevel) then
				
					local hexcolor = babbleclass:GetHexColor(tmpdata.Rolls[rollLink].Class)
					r = string.format("|cff%s%s %d %s%s", hexcolor, r, tmpdata.Rolls[rollLink].Level, string.sub(tmpdata.Rolls[rollLink].Class,1,1), string.lower(string.sub(tmpdata.Rolls[rollLink].Class,2)))
					
				end
				
				l = tmpdata.Rolls[rollLink].Roll	
				if((tmpdata.Rolls[rollLink].Min ~= 1) or (tmpdata.Rolls[rollLink].Max ~= 100)) then
				
					l = l .. " (" .. tmpdata.Rolls[rollLink].Min .. "-" .. tmpdata.Rolls[rollLink].Max .. ")"
					
				end
				
				cat:AddLine(
					'text', r,
					'text2', l
				)
				
				tallied[rollLink] = 1
				
			end
		end
		
	else
	
		cat:AddLine (
			'text', L["TextNoRolls"],
			'text2', ""
		)
		
	end
	
	if(self.db.profile.RollOnClick) then
	
		tablet:SetHint(L["TooltipHint"])
		
	else
	
		tablet:SetHint(L["TooltipHintNoRolls"])
		
	end
end


function GroupFu:OnClick()

	if(IsControlKeyDown()) then
	
		if(tmpdata.RollCount > 0) then
		
			local i, highRoll, highRoller
	
			highRoll = 0
			highRoller = ""
			for i = 1, tmpdata.RollCount do
			
				if ((tmpdata.Rolls[i].Roll > highRoll) and ((not self.db.profile.StandardRollsOnly) or ((tmpdata.Rolls[i].Min == 1) and (tmpdata.Rolls[i].Max == 100)))) then
					
					highRoll = tmpdata.Rolls[i].Roll
					highRoller = tmpdata.Rolls[i].Player
					
				end
			end
			
			-- Output the winner to the specified output channel
			self:AnnounceOutput(format(L["FormatAnnounceWin"], highRoller, highRoll, tmpdata.RollCount))
			
			if((self.db.profile.OutputDetail == "LONG") or (self.db.profile.OutputDetail == "FULL")) then
				local a, b, rollLink, tallied, message, count
	
				tallied = {}
				count = 0
				message = ""
				
				for a=1,tmpdata.RollCount do
					tallied[a] = 0
				end
				
				for a=1,tmpdata.RollCount do
					highRoll = 0
					rollLink = 0
					
					for b=1,tmpdata.RollCount do
					
						if((self.db.profile.StandardRollsOnly) and ((tmpdata.Rolls[b].min ~= 1) or (tmpdata.Rolls[b].max ~= 100))) then
						
							tallied[b] = 1
							
						end
						
						if((tmpdata.Rolls[b].Roll > highRoll) and (tallied[b] == 0)) then
						
							highRoll = tmpdata.Rolls[b].Roll
							rollLink = b
							
						end
					end
					
					if(rollLink ~= 0) then
					
						message = message .. "#" .. a .. " " .. tmpdata.Rolls[rollLink].Player .. " [" .. tmpdata.Rolls[rollLink].Roll .. "]"
						if((self.db.profile.OutputDetail == "FULL") and ((tmpdata.Rolls[rollLink].Min ~= 1) or (tmpdata.Rolls[rollLink].Max ~= 100))) then
						
							message = message .. " (" .. tmpdata.Rolls[rollLink].Min .. "-" .. tmpdata.Rolls[rollLink].Max .. ")"
							
						end
						message = message .. ", "
						count = count + 1
						tallied[rollLink] = 1
						
					end
					
					if((count == 10) or (a == tmpdata.RollCount)) then
					
						message = string.sub(message, 1, -3)
						self:AnnounceOutput(message)
						message = ""
						count = 0
						
					end
				end
			end
			
			if(self.db.profile.DeleteRolls) then
			
				self:ClearRolls()
				
			end
		end
		
	elseif(IsShiftKeyDown()) then
	
		self:ClearRolls()
		
	else
	
		if(self.db.profile.RollOnClick) then
		
			RandomRoll("1", "100")
			
		end
	end
end

function GroupFu:CHAT_MSG_SYSTEM()
	local player, roll, min_roll, max_roll, mlname
	
	-- Trap name of master looter if it has changed
	mlname = deformatter(arg1, ERR_NEW_LOOT_MASTER_S)
	if mlname then
	
		tmpdata.MLName = mlname
		self:Update()
		
	end
	
	-- Trap rolls
    if (self.db.profile.TextMode ~= "LOOTTYFU") then
        player, roll, min_roll, max_roll = deformatter(arg1, RANDOM_ROLL_RESULT )
        if(player) then
        
            if((self.db.profile.StandardRollsOnly) and ((tonumber(min_roll) ~= 1) or (tonumber(max_roll) ~= 100))) then
            
                return
                
            end
            
            if((tmpdata.RollCount > 0) and (self.db.profile.IgnoreDuplicates)) then
                local i
        
                for i=1,tmpdata.RollCount do
                
                    if(tmpdata.Rolls[i].Player == player) then
                        return
                    end
                    
                end
            end
            
            tmpdata.RollCount = tmpdata.RollCount + 1
            tmpdata.Rolls[tmpdata.RollCount] = {}
            tmpdata.Rolls[tmpdata.RollCount].Roll = tonumber(roll)
            tmpdata.Rolls[tmpdata.RollCount].Player = player
            tmpdata.Rolls[tmpdata.RollCount].Min = tonumber(min_roll)
            tmpdata.Rolls[tmpdata.RollCount].Max = tonumber(max_roll)
            
            if(player == UnitName("player")) then
            
                tmpdata.Rolls[tmpdata.RollCount].Class, garbage = UnitClass("player")
                tmpdata.Rolls[tmpdata.RollCount].Level = UnitLevel("player")
                
            elseif(GetNumRaidMembers() > 0) then
                local i, z
        
                z = GetNumRaidMembers()
                for i=1,z do
                
                    if(player == UnitName("raid"..i)) then
                    
                        tmpdata.Rolls[tmpdata.RollCount].Class, garbage = UnitClass("raid"..i)
                        tmpdata.Rolls[tmpdata.RollCount].Level = UnitLevel("raid"..i)
                        break
                        
                    end
                end
                
            elseif(GetNumPartyMembers() > 0) then
                local i, z
        
                z = GetNumPartyMembers()
                for i=1,z do
                
                    if(player == UnitName("party"..i)) then
                    
                        tmpdata.Rolls[tmpdata.RollCount].Class, garbage = UnitClass("party"..i)
                        tmpdata.Rolls[tmpdata.RollCount].Level = UnitLevel("party"..i)
                        
                    end
                end
                
            else
            
                tmpdata.Rolls[tmpdata.RollCount].Class = ""
                tmpdata.Rolls[tmpdata.RollCount].Level = 0
                
            end
            
            if (self.db.profile.ClearTimer > 0) and not self.db.profile.AnnounceRollCountdown then
                tmpdata.TimeSinceLastRoll = 0
            end	
		end
        
		self:Update()
		
	end
end

function GroupFu:ToggleOption(opt)

	self.db.profile[opt] = not self.db.profile[opt]
	self:Update()
	return self.db.profile[opt]
	
end

function GroupFu:ToggleOutputChannel(channel)

	self.db.profile.OutputChannel = channel
	self:Update()
	return self.db.profile.OutputChannel
	
end

function GroupFu:IsOutputChannel(channel)

	if self.db.profile.OutputChannel == channel then
		return true
	else
		return false
	end
	
end

function GroupFu:ToggleOutputDetail(detail)

	self.db.profile.OutputDetail = detail
	self:Update()
	return self.db.profile.OutputDetail
	
end


function GroupFu:IsOutputDetail(detail)

	if self.db.profile.OutputDetail == detail then
		return true
	else
		return false
	end
	
end

function GroupFu:ToggleTextMode(mode)

	self.db.profile.TextMode = mode
	self:Update()
	return self.db.profile.TextMode
	
end

function GroupFu:IsTextMode(mode)

	if self.db.profile.TextMode == mode then
		return true
	else
		return false
	end
	
end

function GroupFu:ToggleClearTimer(timeout)

	self.db.profile.ClearTimer = timeout
	self:Update()
	return self.db.profile.ClearTimer
	
end

function GroupFu:IsClearTimer(timeout)

	if self.db.profile.ClearTimer == timeout then
		return true
	else
		return false
	end
	
end

function GroupFu:ClearRolls()

	tmpdata.Rolls = {}
	tmpdata.RollCount = 0
	tmpdata.TimeSinceLastRoll = 0
	self:Update()
	
end

function GroupFu:IsLootType(loottype)

	if GetLootMethod() == loottype then
		return true
	else 
		return false
	end
	
end

function GroupFu:SetLootType(loottype)

	if loottype == "master" then
		SetLootMethod(loottype,UnitName("player"),2)
	else
		SetLootMethod(loottype)
	end
	
	self:Update()

end

function GroupFu:IsLootThreshold(threshold)

	if GetLootThreshold() == threshold then
		return true
	else 
		return false
	end
	
end

function GroupFu:SetLootThreshold(threshold)

	SetLootThreshold(threshold)
	self:Update()

end

function GroupFu:GetLootTypeText()

	if tmpdata.LootType == "group" then
	
		return L["TextGroup"]
		
	elseif tmpdata.LootType == "master" then
	
		if self.db.profile.ShowMLName and tmpdata.MLName then
			return L["TextMasterSrt"] .. "(" .. tmpdata.MLName .. ")"
		else
			return L["TextMaster"]
		end
		
	elseif tmpdata.LootType == "freeforall" then
	
		return L["TextFFA"]
		
	elseif tmpdata.LootType == "roundrobin" then
	
		return L["TextRR"]
		
	elseif tmpdata.LootType == "needbeforegreed" then
	
		return L["TextNBG"]
	
	else
	
		return L["TextSolo"]
		
	end
end

function GroupFu:CheckRollTimeout()

	if ((tmpdata.RollCount > 0) and (self.db.profile.ClearTimer > 0)) then
        
		tmpdata.TimeSinceLastRoll = tmpdata.TimeSinceLastRoll + 1
        
		if (self.db.profile.AnnounceRollCountdown) then
            
            if( tmpdata.TimeSinceLastRoll == (self.db.profile.ClearTimer-5) ) then
                    
				if GetNumRaidMembers() > 0 then
                    
					self:AnnounceOutput( string.format(L["RollEnding5"], tmpdata.RollCount, GetNumRaidMembers()) )
                    
				elseif GetNumPartyMembers() > 0 then
                    
					self:AnnounceOutput( string.format(L["RollEnding5"], tmpdata.RollCount, GetNumPartyMembers()+1) )
                    
				else
                    
					self:AnnounceOutput( string.format(L["RollEnding5"], tmpdata.RollCount, 1) )
                    
				end
                
			elseif( tmpdata.TimeSinceLastRoll == (self.db.profile.ClearTimer-4) ) then
				
				self:AnnounceOutput( L["RollEnding4"] )
				
			elseif( tmpdata.TimeSinceLastRoll == (self.db.profile.ClearTimer-3) ) then
				
				self:AnnounceOutput( L["RollEnding3"] )
				
			elseif( tmpdata.TimeSinceLastRoll == (self.db.profile.ClearTimer-2) ) then
				
				self:AnnounceOutput( L["RollEnding2"] )
				
			elseif( tmpdata.TimeSinceLastRoll == (self.db.profile.ClearTimer-1) ) then
				
				self:AnnounceOutput( L["RollEnding1"] )
				
			elseif( tmpdata.TimeSinceLastRoll == self.db.profile.ClearTimer ) then

				if GetNumRaidMembers() > 0 then
                    
					self:AnnounceOutput( string.format(L["RollOver"], tmpdata.RollCount, GetNumRaidMembers()) )
                    
				elseif GetNumPartyMembers() > 0 then
                    
					self:AnnounceOutput( string.format(L["RollOver"], tmpdata.RollCount, GetNumPartyMembers()+1) )
                    
				else
                    
					self:AnnounceOutput( string.format(L["RollOver"], tmpdata.RollCount, 1) )
                    
				end
                    
				if(tmpdata.RollCount > 0) then
                    
					local i, highRoll, highRoller
                    
					highRoll = 0
					highRoller = ""
					for i = 1, tmpdata.RollCount do
                        
						if ((tmpdata.Rolls[i].Roll > highRoll) and ((not self.db.profile.StandardRollsOnly) or ((tmpdata.Rolls[i].Min == 1) and (tmpdata.Rolls[i].Max == 100)))) then
							
							highRoll = tmpdata.Rolls[i].Roll
							highRoller = tmpdata.Rolls[i].Player
							
						end
					end
                    
					self:AnnounceOutput(format(L["FormatAnnounceWin"], highRoller, highRoll, tmpdata.RollCount))
				end
				
				self:ClearRolls()
				
			end
			
		elseif( tmpdata.TimeSinceLastRoll == self.db.profile.ClearTimer ) then 
		
			self:ClearRolls()
			
		end
	end
end

function GroupFu:AnnounceOutput( mymessage )

	if( self.db.profile.OutputChannel == "LOCAL" ) then
	
		DEFAULT_CHAT_FRAME:AddMessage(mymessage)
		
	elseif ( self.db.profile.OutputChannel == "AUTO" ) then
	
		if ( GetNumRaidMembers() > 0 ) then

			SendChatMessage(mymessage, "RAID")
		
		elseif ( GetNumPartyMembers() > 0 ) then
		
			SendChatMessage(mymessage, "PARTY")
		
		else
			
			DEFAULT_CHAT_FRAME:AddMessage(mymessage)
			
		end
	
	else
	
		SendChatMessage(mymessage, self.db.profile.OutputChannel)
		
	end

end

function GroupFu:IsInParty()
    if GetNumPartyMembers() == 0 then 
        return false 
    else 
        return true 
    end
end

function GroupFu:IsPartyOrRaidLeader()
    if IsPartyLeader() or IsRaidLeader() then
        return true
    else
        return false
    end
end
