local tablet = AceLibrary("Tablet-2.0")

local L = AceLibrary("AceLocale-2.2"):new("SilverDragon")

SilverDragon = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

SilverDragon.version = "2.0." .. string.sub("$Revision: 19293 $", 12, -3)
SilverDragon.date = string.sub("$Date: 2006-12-05 21:56:21 -0500 (Tue, 05 Dec 2006) $", 8, 17)
SilverDragon.hasIcon = L["DefaultIcon"]

function SilverDragon:OnInitialize()
	SilverDragon:RegisterDB("SilverDragonDB")
	SilverDragon:RegisterDefaults('profile', {
		mobs = {
			--zone
			["*"] = {},
		},
		notesdb = {},
		notes = true,
		scan = true,
		announce = {
			chat = true,
			error = true,
		},
	})
	local optionsTable = {
		type="group",
		args={
			settings = {
				name=L["Settings"], desc=L["Configuration options"],
				type="group",
				args={
					scan = {
						name=L["Scan"], desc=L["Scan for nearby rares at a regular interval"],
						type="toggle",
						get=function() return self.db.profile.scan end,
						set=function(t)
							self.db.profile.scan = t
							if t then self:ScheduleRepeatingEvent('SilverDragon_Scan', self.CheckNearby, 5, self)
							else self:CancelScheduledEvent('SilverDragon_Scan') end
						end,
					},
					announce = {
						name=L["Announce"], desc=L["Display a message when a rare is detected nearby"],
						type="group", args={
							chat = {
								name=L["Chat"], desc=L["In the chatframe"],
								type="toggle",
								get=function() return self.db.profile.announce.chat end,
								set=function(t) self.db.profile.announce.chat = t end,
							},
							error = {
								name=L["Error"], desc=L["In the errorframe"],
								type="toggle",
								get=function() return self.db.profile.announce.error end,
								set=function(t) self.db.profile.announce.error = t end,
							},
						},
					},
					notes = {
						name=L["Notes"], desc=L["Make notes in Cartographer"],
						type="toggle",
						get = function() return self.db.profile.notes end,
						set = function(t)
							self.db.profile.notes = t
							self:ToggleCartographer(t)
						end,
						disabled = function()
							if Cartographer_Notes then return false
							else return true end
						end,
					}
				},
			},
			scan = {
				name=L["Do scan"], desc=L["Scan for nearby rares"],
				type="execute", func="CheckNearby",
			},
		}
	}
	self:RegisterChatCommand(L["ChatCommands"], optionsTable)
	self.OnMenuRequest = optionsTable
	self.lastseen = {}
end

function SilverDragon:OnEnable()
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	if self.db.profile.scan then
		self:ScheduleRepeatingEvent('SilverDragon_Scan', self.CheckNearby, 5, self)
	end
	self:ToggleCartographer(self.db.profile.notes)
end

function SilverDragon:OnDisable()
	self:ToggleCartographer(false)
end

function SilverDragon:ToggleCartographer(enable)
	if Cartographer_Notes then
		if enable then
			Cartographer_Notes:RegisterIcon("Rare", {text = L["Rare mob"], path = "Interface\\Icons\\INV_Misc_Head_Dragon_01", width=12, height=12})
			Cartographer_Notes:RegisterNotesDatabase("SilverDragon", self.db.profile.notesdb, SilverDragon)
		else
			Cartographer_Notes:UnregisterIcon("Rare")
			Cartographer_Notes:UnregisterNotesDatabase("SilverDragon")
		end
	end
end

function SilverDragon:SetNoteHere(text)
	local x,y = GetPlayerMapPosition('player')
	Cartographer_Notes:SetNote(GetRealZoneText(), x, y, 'Rare', 'SilverDragon', 'title', text)
end

function SilverDragon:PLAYER_TARGET_CHANGED()
	self:IsRare('target')
end

function SilverDragon:UPDATE_MOUSEOVER_UNIT()
	self:IsRare('mouseover')
end

function SilverDragon:IsRare(unit)
	local c12n = UnitClassification(unit)
	if c12n == 'rare' or c12n == 'rareelite' then
		local x, y = GetPlayerMapPosition("player")
		if x == 0 and y == 0 then return end
		
		local seen = time()
		local name = UnitName(unit)
		if (not self.lastseen[name]) or (self.lastseen[name] < (seen - 600)) then
			-- Only grab each rare every 10 minutes, preventing spam.
			-- Store as: x:y:level:elite:type:subzone:lastseen
			self.db.profile.mobs[GetRealZoneText()][name] = string.format("%d:%d:%d:%d:%s:%s:%d", math.floor(x * 100), math.floor(y * 100), UnitLevel(unit), c12n=='rareelite' and 1 or 0, UnitCreatureType(unit), GetSubZoneText(), seen)
			self.lastseen[name] = seen
			self:ScheduleEvent(self.Announce, 1, self, name, UnitIsDead(unit))
			self:Update()
			
			if self.db.profile.notes and Cartographer_Notes then
				self:SetNoteHere(name)
			end
		end
	end
end

function SilverDragon:Announce(name, dead)
	if self.db.profile.announce.error then
		UIErrorsFrame:AddMessage(string.format(L["%s seen!"], name), 1, 0, 0, 1, UIERRORS_HOLD_TIME)
		if dead then
			UIErrorsFrame:AddMessage(L["(it's dead)"], 1, 0, 0, 1, UIERRORS_HOLD_TIME)
		end
	end
	if self.db.profile.announce.chat then
		self:Print(string.format(L["%s seen!"], name), dead and L["(it's dead)"] or nil)
	end
end

function SilverDragon:CheckNearby()
	if not UnitAffectingCombat("player") then
		UIErrorsFrame:Hide() -- This can spam some "Unknown Unit" errors to the error frame.
		local startTarget = UnitName("target")
		for name,_ in pairs(self.db.profile.mobs[GetRealZoneText()]) do
			TargetByName(name, true)
			local newTarget = UnitName('target')
			if (startTarget and not (newTarget and newTarget == startTarget)) then
				TargetLastTarget()
			elseif (newTarget and not (newTarget == startTarget)) then
				ClearTarget()
			end
		end
		UIErrorsFrame:Clear(); UIErrorsFrame:Show()
	end
end

function SilverDragon:OnTooltipUpdate()
	local zone, subzone = GetRealZoneText(), GetSubZoneText()
	cat = tablet:AddCategory('text', zone, 'columns', 5)
	for name,mob in pairs(self.db.profile.mobs[zone]) do
		local _,_,x,y,level,elite,ctype,csubzone,lastseen = string.find(mob, "^(%d+):(%d+):(%d+):(%d+):(.+):(.+):(%d+)")
		cat:AddLine(
			'text', name, 'textR', subzone == csubzone and 0 or nil, 'textR', subzone == csubzone and 1 or nil, 'textR', subzone == csubzone and 0 or nil,
			'text2', string.format("level %s%s %s", level and level or '?', elite==1 and '+' or '', ctype and ctype or '?'),
			'text3', csubzone,
			'text4', (lastseen == 0) and L["Never"] or self:LastSeen(lastseen),
			'text5', string.format("%d, %d", x, y)
		)
	end
end

function SilverDragon:LastSeen(t)
	local lastseen
	local currentTime = time()
	local minutes = math.ceil((currentTime - t) / 60)
	if minutes > 59 then
		local hours = math.ceil((currentTime - t) / 3600)
		if hours > 23 then
			lastseen = math.ceil((currentTime - t) / 86400)..L[" day(s)"]
		else
			lastseen = hours..L[" hour(s)"]
		end
	else
		lastseen = minutes..L[" minute(s)"]
	end
	return lastseen
end

function SilverDragon:OnTextUpdate()
	self:SetText(L["Rares"])
end
