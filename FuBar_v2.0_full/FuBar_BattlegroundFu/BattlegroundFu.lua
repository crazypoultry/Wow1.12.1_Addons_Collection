BattlegroundFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")

BattlegroundFu.version      = "2.0." .. string.sub("$Revision: 1$", 12, -3)
BattlegroundFu.date         = string.sub("$Date: 2006-08-25 01:18:28 -0400 (Fri, 25 Aug 2006) $", 8, 17)
BattlegroundFu.hasIcon      = true

BattlegroundFu:RegisterDB("BattlegroundFu2DB")

BattlegroundFu:RegisterDefaults('profile', {
	hideMinimapButton               =   false,
	invertQueueProgress             =   false,
	clickShowsScoreboard            =   false,
	hideBattleFrame                 =   false,
	showTeamSizes                   =   true,
	showTeamScores                  =   true,
	showNumBases                    =   true,
	showResourceTTV                 =   true,
	showObjectiveStatus             =   true,
	showUncontestedObjectives       =   true,
	showCTFFlagCarriers             =   true,
	showPlayerStats                 =   true,
	showQueues                      =   true,
	hideQueueText                   =   {},
})

local Abacus  = AceLibrary("Abacus-2.0")
local Crayon  = AceLibrary("Crayon-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")
local Glory   = AceLibrary("Glory-2.0")
local L       = AceLibrary("AceLocale-2.1"):GetInstance("BatFu", true)
local Metro   = AceLibrary("Metrognome-2.0")
local Tablet  = AceLibrary("Tablet-2.0")
local Z       = AceLibrary("Babble-Zone-2.0")

local playerFaction = UnitFactionGroup("player")
local FACTION_ICON_PATH = "Interface\\GroupFrame\\UI-Group-PVP-"

--User Options Methods=========================================================
function BattlegroundFu:IsHidingMinimapButton()
	return self.db.profile.hideMinimapButton
end

function BattlegroundFu:ToggleHidingMinimapButton()
	self.db.profile.hideMinimapButton = not self.db.profile.hideMinimapButton
	if self.db.profile.hideMinimapButton then
		MiniMapBattlefieldFrame:Hide()
	else
		MiniMapBattlefieldFrame:Show()
	end
end

function BattlegroundFu:IsHidingBattleFrame()
	return self.db.profile.hideBattleFrame
end

function BattlegroundFu:ToggleHidingBattleFrame()
	self.db.profile.hideBattleFrame = not self.db.profile.hideBattleFrame
	if self.db.profile.hideBattleFrame then
		WorldStateAlwaysUpFrame:Hide()
	else
		WorldStateAlwaysUpFrame:Show()
	end
end

function BattlegroundFu:IsInvertQueueProgress()
	return self.db.profile.invertQueueProgress
end

function BattlegroundFu:ToggleInvertQueueProgress()
	self.db.profile.invertQueueProgress = not self.db.profile.invertQueueProgress
	self:UpdateDisplay()
end

function BattlegroundFu:IsClickShowsScoreboard()
	return self.db.profile.clickShowsScoreboard
end

function BattlegroundFu:ToggleClickShowsScoreboard()
	self.db.profile.clickShowsScoreboard = not self.db.profile.clickShowsScoreboard
	self:UpdateDisplay()
end

function BattlegroundFu:IsShowingTeamSizes()
	return self.db.profile.showTeamSizes
end

function BattlegroundFu:ToggleShowingTeamSizes()
	self.db.profile.showTeamSizes = not self.db.profile.showTeamSizes
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingTeamScores()
	return self.db.profile.showTeamScores
end

function BattlegroundFu:ToggleShowingTeamScores()
	self.db.profile.showTeamScores = not self.db.profile.showTeamScores
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingNumBases()
	return self.db.profile.showNumBases
end

function BattlegroundFu:ToggleShowingNumBases()
	self.db.profile.showNumBases = not self.db.profile.showNumBases
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingResourceTTV()
	return self.db.profile.showResourceTTV
end

function BattlegroundFu:ToggleShowingResourceTTV()
	self.db.profile.showResourceTTV = not self.db.profile.showResourceTTV
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingPlayerStats()
	return self.db.profile.showPlayerStats
end

function BattlegroundFu:ToggleShowingPlayerStats()
	self.db.profile.showPlayerStats = not self.db.profile.showPlayerStats
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingObjectiveStatus()
	return self.db.profile.showObjectiveStatus
end

function BattlegroundFu:ToggleShowingObjectiveStatus()
	self.db.profile.showObjectiveStatus = not self.db.profile.showObjectiveStatus
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingUncontestedObjectives()
	return self.db.profile.showUncontestedObjectives
end

function BattlegroundFu:ToggleShowingUncontestedObjectives()
	self.db.profile.showUncontestedObjectives = not self.db.profile.showUncontestedObjectives
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingCTFFlagCarriers()
	return self.db.profile.showCTFFlagCarriers
end

function BattlegroundFu:ToggleShowingCTFFlagCarriers()
	self.db.profile.showCTFFlagCarriers = not self.db.profile.showCTFFlagCarriers
	self:UpdateTooltip()
end

function BattlegroundFu:IsShowingQueues()
	return self.db.profile.showQueues
end

function BattlegroundFu:ToggleShowingQueues()
	self.db.profile.showQueues = not self.db.profile.showQueues
	self:UpdateTooltip()
end    

function BattlegroundFu:IsHidingQueueText(q)
	return self.db.profile.hideQueueText[q]
end

function BattlegroundFu:ToggleHidingQueueText(q)
	self.db.profile.hideQueueText[q] = not self.db.profile.hideQueueText[q]
	self:UpdateText()
end
--End User Options Methods=====================================================
--Options======================================================================
local options = {
	type = 'group',
	args = {
		minimap = {
			type = 'toggle',
			name = L["Hide minimap button"],
			desc = L["Toggle display of the Battlegrounds minimap button"],
			get  = "IsHidingMinimapButton",
			set  = "ToggleHidingMinimapButton",
		},
		battleframe = {
			type = 'toggle',
			name = L["Hide default battle objectives frame"],
			desc = L["Toggle display of the default battle objectives frame"],
			get  = "IsHidingBattleFrame",
			set  = "ToggleHidingBattleFrame",
		},
		invert = {
			type = 'toggle',
			name = L["Inverted queue timers"],
			desc = L["Toggle whether BatFu's queue timer displays count down from the estimated queue duration or up from zero."],
			get  = "IsInvertQueueProgress",
			set  = "ToggleInvertQueueProgress",
		},
		clickscores = {
			type = 'toggle',
			name = L["Click displays scoreboard"],
			desc = L["Toggle in-battle behavior for clicking on the BatFu plugin (scoreboard only/scoreboard and battlefield instance frames)."],
			get  = "IsClickShowsScoreboard",
			set  = "ToggleClickShowsScoreboard",
		},
		tooltip = {
			type = 'group',
			name = L["Tooltip Options"],
			desc = L["Toggles display of elements of the tooltip."],
			args = {
				teamsizes = {
					type = 'toggle',
					name = L["Team sizes"],
					desc = L["Toggle the Team Size line on the in-battle tooltip."],
					get  = "IsShowingTeamSizes",
					set  = "ToggleShowingTeamSizes",
				},
				teamscores = {
					type = 'toggle',
					name = L["Team scores"],
					desc = L["Toggle the Team Score line on the in-battle tooltip."],
					get  = "IsShowingTeamScores",
					set  = "ToggleShowingTeamScores",
				},
				bases = {
					type = 'toggle',
					name = L["Bases held"],
					desc = L["Toggle the Bases Held line on the in-battle tooltip."],
					get  = "IsShowingNumBases",
					set  = "ToggleShowingNumBases",
				},
				ttv = {
					type = 'toggle',
					name = L["Time-to-victory"],
					desc = L["Toggle the Time-To-Victory (TTV) line on the in-battle tooltip (for resource collection Battlegrounds)."],
					get  = "IsShowingResourceTTV",
					set  = "ToggleShowingResourceTTV",
				},
				stats = {
					type = 'toggle',
					name = L["Player stats"],
					desc = L["Toggle the player statistics (kills, deaths, killing blows, bonus honor) on the in-battle tooltip."],
					get  = "IsShowingPlayerStats",
					set  = "ToggleShowingPlayerStats",
				},
				objectives = {
					type = 'toggle',
					name = L["Objective status"],
					desc = L["Toggle the display of objective status (node controllers, capture timers, etc.) on the in-battle tooltip."],
					get  = "IsShowingObjectiveStatus",
					set  = "ToggleShowingObjectiveStatus",
				},
				uncontested = {
					type = 'toggle',
					name = L["Uncontested objectives"],
					desc = L["Show only the status of those nodes which are currently in conflict or not yet claimed."],
					get  = "IsShowingUncontestedObjectives",
					set  = "ToggleShowingUncontestedObjectives",
				},
				flags = {
					type = 'toggle',
					name = L["Flag Carriers"],
					desc = L["Toggle click-to-target (alt-click if tooltip is locked) display of CTF flag carriers on the in-battle tooltip."],
					get  = "IsShowingUncontestedObjectives",
					set  = "ToggleShowingUncontestedObjectives",
				},
				queues = {
					type = 'toggle',
					name = L["Queues"],
					desc = L["Toggle display of pending battlefield queues on the tooltip."],
					get  = "IsShowingQueues",
					set  = "ToggleShowingQueues",
				}
			}
		}
	}
}
--End Options==================================================================

BattlegroundFu:RegisterChatCommand({ "/batfu", "/battlegroundfu" }, options)

--FuBar Standard Methods=======================================================
function BattlegroundFu:OnEnable()
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	self:RegisterEvent("UPDATE_WORLD_STATES", "UpdateTooltip")

	Metro:Register("BatFu", self.Update, 1, self)
	Metro:Start("BatFu")

	if IsHidingBattleFrame then WorldStateAlwaysUpFrame:Hide() end
end

function BattlegroundFu:OnDisable()
	Metro:Stop("BatFu")
end

function BattlegroundFu:OnMenuRequest(level, value, inTooltip)
	local hasQueue = false
	if level == 1 then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local i = i
			local status, mapName = GetBattlefieldStatus(i)
			if status == "queued" or status == "confirm" then
				hasQueue = true
				Dewdrop:AddLine()
				Dewdrop:AddLine(
					'text', mapName,
					'textR', 1,
					'textG', 0.843,
					'textB', 0,
					'arg1', self,
					'arg2', mapName,
					'func', "ToggleHidingQueueText",
					'checked', not self:IsHidingQueueText(mapName)
				)
				if status == "queued" then
					Dewdrop:AddLine(
						'text', CHANGE_INSTANCE,
						'func',	function ()
							ShowBattlefieldList(i)
						end
					)
				elseif status == "confirm" then
					Dewdrop:AddLine(
						'text', ENTER_BATTLE,
						'func', function ()
							AcceptBattlefieldPort(i, 1)
						end
					)
				end
				Dewdrop:AddLine(
					'text', LEAVE_QUEUE,
					'func', function ()
						AcceptBattlefieldPort(i)
						if not IsShiftKeyDown() then
							Dewdrop:Close(1)
						end
					end
				)
			end
		end
	end
	if hasQueue then Dewdrop:AddLine() end
	Dewdrop:FeedAceOptionsTable(options)
end

local j = 1
function BattlegroundFu:OnClick()
	if Glory:IsInBattlegrounds() and self:IsClickShowsScoreboard() then
		if WorldStateScoreFrame:IsVisible() then
			HideUIPanel(WorldStateScoreFrame)
		else
			ShowUIPanel(WorldStateScoreFrame)
		end
	elseif GetBattlefieldStatus(j) == "active" then
		ShowUIPanel(WorldStateScoreFrame)
		j = j + 1
	elseif GetBattlefieldStatus(j) == "queued" or GetBattlefieldStatus(j) == "confirm" then
		HideUIPanel(WorldStateScoreFrame)
		ShowBattlefieldList(j)
		j = j + 1
	else
		HideUIPanel(WorldStateScoreFrame)
		HideUIPanel(BattlefieldFrame)
		j = 1
	end
end

function BattlegroundFu:OnDataUpdate()
	if Glory:IsInBattlegrounds() then
		RequestBattlefieldScoreData()
	end
end

local function UpdateText_PlayerStats()
	local red, green, white = Crayon.COLOR_HEX_RED, Crayon.COLOR_HEX_GREEN, Crayon.COLOR_HEX_WHITE
	return format("#: |cff%s%s|r KB: |cff%s%s|r K: |cff%s%s|r D: |cff%s%s|r H: |cff%s%s|r", white, Glory:GetStanding(), green, Glory:GetKillingBlows(), green, Glory:GetHonorableKills(), red, Glory:GetDeaths(), white, Glory:GetBonusHonor())
end

function BattlegroundFu:UpdateText_QueuedBattlefields()
	local usingDefaultText, defText
	local queueText = L["No Queues"]
	local numQueues = 0
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName = GetBattlefieldStatus(i)
		if status == "queued" then
			numQueues = numQueues + 1
			if not self:IsHidingQueueText(mapName) then
				local bgTimeQueued = GetBattlefieldTimeWaited(i)/1000
				local bgEstimatedTime = GetBattlefieldEstimatedWaitTime(i)/1000
				local timeColor = Crayon:GetThresholdHexColor(1-bgTimeQueued/bgEstimatedTime, -0.25, -0.1, 0.1, 0.5, 0.9)
				local progress = self:IsInvertQueueProgress() and
					format("|cff%s%s|r/%s", timeColor, Abacus:FormatDurationFull(bgEstimatedTime - bgTimeQueued, nil, 1), Abacus:FormatDurationFull(bgEstimatedTime, nil, 1)) or
					format("|cff%s%s|r/%s", timeColor, Abacus:FormatDurationFull(bgTimeQueued, nil, 1), Abacus:FormatDurationFull(bgEstimatedTime, nil, 1))
				defText = usingDefaultText or queueText == L["No Queues"]
				queueText = defText and
					Glory:GetBGAcronym(mapName) .. ": " .. progress or
					queueText .. " || " ..  Glory:GetBGAcronym(mapName) .. ": " .. progress
				usingDefaultText = false
			end
			defText = usingDefaultText or queueText == L["No Queues"]
			queueText = defText and format("%s: %d", L["Queues"], numQueues) or queueText
			usingDefaultText = defText
		end
	end
	return queueText
end

function BattlegroundFu:OnTextUpdate()
	self:SetIcon(FACTION_ICON_PATH .. playerFaction)
	self:SetText(Glory:IsInBattlegrounds() and Glory:GetStanding() and UpdateText_PlayerStats() or self:UpdateText_QueuedBattlefields())
end

local function UpdateTooltip_BattlefieldMatchInfo(label, textA, textH)
	local aR, aG, aB = Glory:GetFactionColor(FACTION_ALLIANCE)
	local hR, hG, hB = Glory:GetFactionColor(FACTION_HORDE)
	local cat = Tablet:AddCategory(
		'hideBlankLine', true,
		'columns', 3,
		'child_textR', aR,
		'child_textG', aG,
		'child_textB', aB,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1,
		'child_text3R', hR,
		'child_text3G', hG,
		'child_text3B', hB
	)

	cat:AddLine(
		'text', textA,
		'text2', label,
		'text3', textH
	)
end

local function UpdateTooltip_PlayerStats()
	local cat = Tablet:AddCategory(
		'columns', 2,
		'text', L["Player Stats"],
		'child_textR', 1,
		'child_textG', 0.843,
		'child_textB', 0
	)

	local standing = Glory:GetStanding()
	cat:AddLine(
		'text', L["Standing"],
		'text2', standing,
		'text2R', 1,
		'text2G', 1,
		'text2B', 1
	)

	local kbs = Glory:GetKillingBlows()
	cat:AddLine(
		'text', L["Killing Blows"],
		'text2', kbs,
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	)

	local hks = Glory:GetHonorableKills()
	cat:AddLine(
		'text', L["Kills"],
		'text2', hks, 
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	)

	local deaths = Glory:GetDeaths()
	cat:AddLine(
		'text', L["Deaths"],
		'text2', deaths,
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	)
	
	local honor = Glory:GetBonusHonor()
	cat:AddLine(
		'text', L["Bonus Honor"],
		'text2', honor,
		'text2R', 1,
		'text2G', 1,
		'text2B', 1
	)
end

local function UpdateTooltip_BattlefieldObjectiveTimers(showUncontested)
	if Glory.battlefieldObjectiveStatus and next(Glory.battlefieldObjectiveStatus) then
		local cat = Tablet:AddCategory(
			'columns', 2,
			'text', L["Base"],
			'text2', L["Status"]
		)
		for _, poi in Glory:IterateSortedObjectiveNodes() do
			local lR, lG, lB = Glory:GetFactionColor(Glory:GetDefender(poi))
			local rR, rG, rB = Glory:GetFactionColor(Glory:GetDefender(poi))
			local node = Glory:GetName(poi)
			local status
			if Glory:IsInConflict(poi) then
				rR, rG, rB = Glory:GetFactionColor(Glory:GetAttacker(poi))
				if Glory:GetTimeAttacked(poi) then
					status = Abacus:FormatDurationCondensed(Glory:GetTimeToCapture(poi))
				else        --when joining a battlefield where the node is already under attack
					status = L["In Conflict"]
				end
			elseif Glory:IsDestroyed(poi) then
				status = L["Destroyed"]
			else
				status = Glory:GetDefender(poi)
			end
			if showUncontested or Glory:IsInConflict(poi) then
				cat:AddLine(
					'text', node,
					'text2', status,
					'textR', lR,
					'textG', lG,
					'textB', lB,
					'text2R', rR,
					'text2G', rG,
					'text2B', rB
				)
			end
		end
	end
end

local function UpdateTooltip_CTFFlagCarriers()
	local aR, aG, aB = Glory:GetFactionColor(FACTION_ALLIANCE)
	local hR, hG, hB = Glory:GetFactionColor(FACTION_HORDE)
	local cat = Tablet:AddCategory(
		'columns', 2,
		'text', L["Flag"],
		'text2', L["Carrier"]
	)
	local carrier = Glory:GetHordeFlagCarrier()
	local rR, rG, rB
	if carrier then
		rR, rG, rB = Glory:GetFactionColor(FACTION_HORDE)
	else
		rR, rG, rB = Glory:GetFactionColor(FACTION_ALLIANCE)
	end
	cat:AddLine(
		'text', FACTION_ALLIANCE,
		'text2', carrier or L["N/A"],
		'textR', aR,
		'textG', aG,
		'textB', aB,
		'text2R', rR,
		'text2G', rG,
		'text2B', rB,
		'func', function()
			Glory:TargetHordeFlagCarrier()
		end
	)
	carrier = Glory:GetAllianceFlagCarrier()
	if carrier then
		rR, rG, rB = Glory:GetFactionColor(FACTION_ALLIANCE)
	else
		rR, rG, rB = Glory:GetFactionColor(FACTION_HORDE)
	end
	cat:AddLine(
		'text', FACTION_HORDE,
		'text2', carrier or L["N/A"],
		'textR', hR,
		'textG', hG,
		'textB', hB,
		'text2R', rR,
		'text2G', rG,
		'text2B', rB,
		'func', function()
			Glory:TargetAllianceFlagCarrier()
		end
	)
end

local ttOpenBattlefieldFrame
local function UpdateTooltip_BGQueues(invert)
	local cat = Tablet:AddCategory(
		'columns', 2,
		'text', L["Battlefields Queued"],
		'text2', invert and L["Remaining"] or L["Progress"],
		'child_textG', 0.843,
		'child_teøt1B', 0
	)
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local i = i
		local status, mapName = GetBattlefieldStatus(i)
		if status == "queued" then
			local bgTimeQueued = GetBattlefieldTimeWaited(i)/1000
			local bgEstimatedTime = GetBattlefieldEstimatedWaitTime(i)/1000
			local timeR, timeG, timeB = Crayon:GetThresholdColor(1-bgTimeQueued/bgEstimatedTime, -0.25, -0.1, 0.1, 0.5, 0.9)
			local progress = invert and 
				Abacus:FormatDurationCondensed(bgEstimatedTime - bgTimeQueued) .. "|r|cffffd700/" .. Abacus:FormatDurationCondensed(bgEstimatedTime) or
				Abacus:FormatDurationCondensed(bgTimeQueued) .. "|r|cffffd700/" .. Abacus:FormatDurationCondensed(bgEstimatedTime)

			cat:AddLine(
				'text', mapName,
				'text2', progress,
				'text2R', timeR,
				'text2G', timeG,
				'text2B', timeB,
				'func', function ()
					if not BattlefieldFrame:IsVisible() or ttOpenBattlefieldFrame ~= i then
						ShowBattlefieldList(i)
						ttOpenBattlefieldFrame = i
					else
						HideUIPanel(BattlefieldFrame)
					end
				end
			)
		end
		if status == "confirm" then
			local bgPortExpiration = GetBattlefieldPortExpiration(i)/1000
			local timeR, timeG, timeB = Crayon:GetThresholdColor(bgPortExpiration/120)
			local progress = L["Confirm"] .. ":" .. Abacus:FormatDurationCondensed(bgPortExpiration)
			cat:AddLine(
				'text', mapName,
				'text2', progress,
				'text2R', timeR,
				'text2G', timeG,
				'text2B', timeB,
				'func', function ()
					if not BattlefieldFrame:IsVisible() or ttOpenBattlefieldFrame ~= i then
						ShowBattlefieldList(i)
						ttOpenBattlefieldFrame = i
					else
						HideUIPanel(BattlefieldFrame)
					end
				end
			)
		end
	end
end

function BattlegroundFu:OnTooltipUpdate()
	Tablet:SetHint(Glory:IsInBattlegrounds() and ((self:IsClickShowsScoreboard() and L["Click to toggle scoreboard display."]) or L["Click to cycle through Scoreboard/Battlefield List frames."]))

	local status, mapName, instanceID
	if Glory:IsInBattlegrounds() then
		Tablet:AddCategory():AddLine('text', Glory:GetActiveBattlefieldUniqueID(), 'textR', 1, 'textG', 1, 'textB', 1)
		if self:IsShowingTeamSizes() then
			UpdateTooltip_BattlefieldMatchInfo(L["Players"], Glory:GetNumAlliancePlayers(), Glory:GetNumHordePlayers())
		end
		if self:IsShowingTeamScores() and GetWorldStateUIInfo(1) then
			UpdateTooltip_BattlefieldMatchInfo(L["Score"], Glory:GetAllianceScoreString(), Glory:GetHordeScoreString())
		end
		local _, s = GetWorldStateUIInfo(1)
		if self:IsShowingNumBases() and s and string.find(s, L["Bases"]) then
			UpdateTooltip_BattlefieldMatchInfo(L["Bases"], Glory:GetNumAllianceBases(), Glory:GetNumHordeBases())
		end
		if self:IsShowingResourceTTV() and s and string.find(s, L["Resources"]) then
			UpdateTooltip_BattlefieldMatchInfo(L["TTV"], Abacus:FormatDurationCondensed(Glory:GetAllianceTTV()), Abacus:FormatDurationCondensed(Glory:GetHordeTTV()))
		end
		if self:IsShowingPlayerStats() then
			UpdateTooltip_PlayerStats()
		end
		if GetNumMapLandmarks() > 0 and self:IsShowingObjectiveStatus() then
			UpdateTooltip_BattlefieldObjectiveTimers(self:IsShowingUncontestedObjectives())
		end
		if self:IsShowingCTFFlagCarriers() and Glory:GetActiveBattlefieldZone() == Z"Warsong Gulch" then
			UpdateTooltip_CTFFlagCarriers()
		end
	end

	if self:IsShowingQueues() then
		for i=1, MAX_BATTLEFIELD_QUEUES do
			status = GetBattlefieldStatus(i)
			if status == "queued" or status == "confirm" then
				UpdateTooltip_BGQueues(self:IsInvertQueueProgress())
				break
			end
		end
	end
end
--End FuBar Standard Methods===================================================

--Game Events==================================================================
function BattlegroundFu:UPDATE_BATTLEFIELD_STATUS()
	if self:IsHidingMinimapButton() and MiniMapBattlefieldFrame:IsVisible() then
		MiniMapBattlefieldFrame:Hide()
	end
	self:UpdateDisplay()
end
--End Game Events==============================================================
