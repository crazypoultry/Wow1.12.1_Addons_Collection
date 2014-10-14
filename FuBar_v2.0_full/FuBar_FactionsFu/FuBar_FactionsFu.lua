local compost = AceLibrary("Compost-2.0")
local tablet = AceLibrary("Tablet-2.0")

FuBar_FactionsFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "FuBarPlugin-2.0")
FuBar_FactionsFu.hasIcon = "Interface\\Icons\\Spell_Holy_SealOfSalvation"
FuBar_FactionsFu.hasNoText = true
FuBar_FactionsFu.clickableTooltip = true

-- function FuBar_FactionsFu:OnInitialize()
-- end

function FuBar_FactionsFu:OnEnable()
	self:RegisterEvent("UPDATE_FACTION")
	self:Update()
end

-- function FuBar_FactionsFu:OnDisable()
-- end

function FuBar_FactionsFu:OnDataUpdate()
	if self.factions then
		self.factions = compost.Reclaim(self.factions, 1)
	end
	self.factions = compost:Acquire()

	local header = UNKNOWN
	
	local numFactions = GetNumFactions();
	local factionIndex, factionName, factionCheck, factionStanding, factionBar, factionHeader, color, tooltipStanding;
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched;
	local atWarIndicator, rightBarTexture;

	for i=1, numFactions, 1 do
		name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(i);
		if ( isHeader ) then
			header = name
			table.insert(self.factions, compost:AcquireHash("name", header, "isHeader", true, "isCollapsed", isCollapsed))
		else
			if header ~= UNKNOWN then
				-- Normalize values
				barMax = barMax - barMin;
				barValue = barValue - barMin;
				barMin = 0;
				table.insert(self.factions, compost:AcquireHash("name", name, "isHeader", false, "standing", standingID, "repIs", barValue, "repMax", barMax, "atWarWith", atWarWith, "canToggleAtWar", canToggleAtWar, "isWatched", isWatched))
			end
		end
	end
end

-- function FuBar_FactionsFu:OnTextUpdate()
-- 	self:SetText("")
-- end

function FuBar_FactionsFu:OnTooltipUpdate()
	local cat
	local gender = UnitSex("player")
	for i = 1, table.getn(self.factions), 1 do
		if self.factions[i].isHeader then
			cat = tablet:AddCategory(
				'text', self.factions[i].name,
				'columns', 3,
				'hideBlankLine', true,
				'showWithoutChildren', true,
				'hasCheck', true,
				'checked', true,
				'checkIcon', self.factions[i].isCollapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up",
				'func', 'OnClickGroup',
				'arg1', self,
				'arg2', i
			)
		else
			cat:AddLine(
				'text', self.factions[i].name,
				'textR', self.factions[i].atWarWith and 1 or self.factions[i].canToggleAtWar and 1 or 0,
				'textG', self.factions[i].atWarWith and 0 or self.factions[i].canToggleAtWar and 1 or 1,
				'textB', self.factions[i].atWarWith and 0 or self.factions[i].canToggleAtWar and 0 or 0,
				'text2', GetText("FACTION_STANDING_LABEL"..self.factions[i].standing, gender),
				'text2R', FACTION_BAR_COLORS[self.factions[i].standing].r,
				'text2G', FACTION_BAR_COLORS[self.factions[i].standing].g,
				'text2B', FACTION_BAR_COLORS[self.factions[i].standing].b,
				'text3', self.factions[i].repIs.." / "..self.factions[i].repMax,
				'text3R', FACTION_BAR_COLORS[self.factions[i].standing].r,
				'text3G', FACTION_BAR_COLORS[self.factions[i].standing].g,
				'text3B', FACTION_BAR_COLORS[self.factions[i].standing].b,
				'hasCheck', true,
				'checked', self.factions[i].isWatched,
				'func', 'OnClickFaction',
				'arg1', self,
				'arg2', i
			)
		end
	end
end

function FuBar_FactionsFu:OnClick()
	ToggleCharacter("ReputationFrame")
end

function FuBar_FactionsFu:UPDATE_FACTION()
	self:Update()
end

function FuBar_FactionsFu:OnClickGroup(id)
	if (self.factions[id].isCollapsed) then
		ExpandFactionHeader(id)
	else
		CollapseFactionHeader(id)
	end
	self:Update()
end

function FuBar_FactionsFu:OnClickFaction(id)
	if IsShiftKeyDown() then
		if ( ChatFrameEditBox:IsVisible() ) then
			local gender = UnitSex("player")
			ChatFrameEditBox:Insert(self.factions[id].name..": "..GetText("FACTION_STANDING_LABEL"..self.factions[id].standing, gender).." ("..self.factions[id].repIs.."/"..self.factions[id].repMax..")")
		end
	else
		if ( self.factions[id].isWatched ) then
			PlaySound("igMainMenuOptionCheckBoxOff")
			SetWatchedFactionIndex(0)
		else
			PlaySound("igMainMenuOptionCheckBoxOn")
			SetWatchedFactionIndex(id)
		end
		self:Update()
	end
end
