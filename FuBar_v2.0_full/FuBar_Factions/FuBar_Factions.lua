local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')
local crayon = CrayonLib:GetInstance('1.0')

FuBar_Factions = FuBarPlugin:GetInstance("1.2"):new({
	name          = FuBar_FactionsLocals.NAME,
	description   = FuBar_FactionsLocals.DESCRIPTION,
	version       = "1.2.1",
	releaseDate   = "06-14-2006",
	aceCompatible = 103,
	author        = "Corgi",
	email         = "corgiwow@gmail.com",
	website       = "http://corgi.wowinterface.com",
	category      = "interface",
	db            = AceDatabase:new("FuBar_FactionsDB"),
	defaults      = {
		showPercent = FALSE,
		showBoth  = FALSE,
		monitor	  = FALSE,
	},
	cmd           = AceChatCmd:new(FuBar_FactionsLocals.COMMANDS, FuBar_FactionsLocals.CMD_OPTIONS),
	loc 		  = FuBar_FactionsLocals,
	hasIcon       = TRUE,
	hasNoText	  = FALSE,
	canHideText	  = TRUE,
})
		
function FuBar_Factions:Enable() 
	self:RegisterEvent("UPDATE_FACTION","Update")
end
   
function FuBar_Factions:Initialize()
	if ( self.charData.monitor ~= nil or self.charData.monitor ~= "" ) then
		self.data.monitor = self.charData.monitor
	else
		self.data.monitor = ""
	end
	self:UpdateText()
end
	
function FuBar_Factions:OnClick() 
	ToggleCharacter("ReputationFrame")
end
	
function FuBar_Factions:Report()
	self.cmd:report({
		{text=self.loc.ARGUMENT_PERCENT, val=(self:IsShowingPercent() and 1 or 0), map=FuBarLocals.MAP_ONOFF},
	})
end
	
function FuBar_Factions:MenuSettings(level, value)		
	local info = {}
	
	if ( level == 1 ) then
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_AS_PERCENTAGE,
			'func', function()
				self:ToggleShowingPercent()
				self:Update()
			end,
			'checked', self:IsShowingPercent(),
			'level', 1,
			'closeWhenClicked', false
		)
				
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_BOTH,
			'func', function()
				self:ToggleShowingBoth()
				self:Update()
			end,
			'checked', self:IsShowingBoth(),
			'level', 1,
			'closeWhenClicked', false
		)
		
		dewdrop:AddLine()
			
		dewdrop:AddLine(
			'text', self.loc.MENU_MONITOR,
			'value', self.loc.MENU_MONITOR,
			'level', 1,
			'hasArrow', true
		)		
		
	elseif ( level == 2 ) then
	
		if ( value == self.loc.MENU_MONITOR ) then
			local NumFactions = GetNumFactions()
			local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith
			local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed
	
			local factionIndex
			local standingText = ""
					
			for factionIndex=1, NumFactions do
				
				local tmpStanding = ""
					
				faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed = GetFactionInfo(factionIndex)
				
				if ( not faction_isHeader ) then
						
					standingText = self:FindRep(faction_standingID)
						
					if ( self:IsShowingPercent() ) then
						local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
						tmpStanding = crayon:Green(faction_name)..":"..standingText.." ("..bval.."%)"
					elseif ( self:IsShowingBoth() ) then
						local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
						tmpStanding = crayon:Green(faction_name)..":"..standingText.." ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")".."["..bval.."%]"
					else
						tmpStanding = crayon:Green(faction_name)..":"..standingText.." ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")"	
					end
								
					info = {}
					info.text = tmpStanding
					info.checked = nil
					if ( info.text == self.data.monitor ) then
						info.checked = 1
					end
					
					dewdrop:AddLine(
						'text', tmpStanding,
						'arg1', tmpStanding,
						'value', tmpStanding,
						'func', function(val)
							self:SetMonitor(val)
						end,
						'level', 2,
						'checked', info.checked
					)
						
				else
					dewdrop:AddLine(
						'text', faction_name,
						'value', faction_name,
						'level', 2
					)
				end
			end
		end
	end
end
	
function FuBar_Factions:UpdateTooltip()

	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 0,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 0
	)
	
	local NumFactions = GetNumFactions()

	local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith
	local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed

	local factionIndex
	local standingText = ""
		
	for factionIndex=1, NumFactions do
			
		local tooltipRichText = ""
		local atWarText = ""
			
		faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed = GetFactionInfo(factionIndex)
	
		if ( not faction_isHeader ) then
			
			standingText = self:FindRep(faction_standingID)
				
			if ( faction_atWarWith ) then
				atWarText = crayon:Red(" AW")
			else
				atWarText = ""
			end
				
			if ( self:IsShowingPercent() ) then
				local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
				tooltipRichText = standingText.." ("..bval.."%)"..atWarText
				cat:AddLine(
					'text', faction_name,
					'text2', tooltipRichText
				)
				
			elseif ( self:IsShowingBoth() ) then
				local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
				tooltipRichText = standingText.." ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")".."["..bval.."%]"
				cat:AddLine(
					'text', faction_name,
					'text2', tooltipRichText
				)
			else
				tooltipRichText = standingText.." ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")"..atWarText
				cat:AddLine(
					'text', faction_name,
					'text2', tooltipRichText
				)
			end
		else
			cat:AddLine(
				'text', faction_name,
				'textR', 1,
				'textG', 1,
				'textB', 1,
				'text2', ""
			)
		end
	end
end
	
function FuBar_Factions:UpdateText()
	if ( self.data.monitor ~= nil and self.data.monitor ~= "" ) then
		self:SetText(self.data.monitor)
	else
		self:SetText("Factions")
	end
end
	
function FuBar_Factions:UpdateData()
	local NumFactions = GetNumFactions()

	local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith
	local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed

	local factionIndex
	local standingText = ""
				
	for factionIndex=1, NumFactions do
			
		local tmpStanding = ""
			
		faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed = GetFactionInfo(factionIndex)
		
		if ( not faction_isHeader ) then
										
			if ( self.data.monitor ~= nil and string.find(self.data.monitor, faction_name) ) then
				
				standingText = self:FindRep(faction_standingID)
					
				tmpStanding = crayon:Green(faction_name)..":"..standingText
					
				if ( self:IsShowingPercent() ) then
					local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
					tmpStanding = tmpStanding.." ("..bval.."%)"
				elseif ( self:IsShowingBoth() ) then
					local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100)
					tmpStanding = crayon:Green(faction_name)..":"..standingText.." ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")".."["..bval.."%]"
				else
					tmpStanding = tmpStanding.." ("..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")"	
				end
					
				self.data.monitor = tmpStanding
				self.charData.monitor = tmpStanding
				return
			end
		end
	end
end
	
function FuBar_Factions:FindRep(standingID)
	local standingText = ""
	if ( standingID == 0 ) then
		standingText = UNKNOWN -- unknown
	elseif ( standingID == 1 ) then
		standingText = self.loc.FactionTextHated 	-- hated
	elseif ( standingID == 2) then
		standingText = self.loc.FactionTextHostile 	-- hostile
	elseif ( standingID == 3) then
		standingText = self.loc.FactionTextUnfriendly -- unfriendly
	elseif ( standingID == 4) then
		standingText = self.loc.FactionTextNeutral 	-- neutral
	elseif ( standingID == 5) then
		standingText = self.loc.FactionTextFriendly -- friendly
	elseif ( standingID == 6) then
		standingText = self.loc.FactionTextHonored 	-- honored
	elseif ( standingID == 7) then
		standingText = self.loc.FactionTextRevered 	-- revered
	elseif ( standingID == 8) then
		standingText = self.loc.FactionTextExalted 	-- exalted
	end
	return standingText
end
	
function FuBar_Factions:IsShowingPercent()
	return self.data.showPercent
end
	
function FuBar_Factions:ToggleShowingPercent(loud)
	self.data.showPercent = not self.data.showPercent
	if loud then
		self.cmd:status(self.loc.ARGUMENT_PERCENT, self.data.showPercent and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	
	if ( self.data.showPercent ) then
		if ( self.data.showBoth ) then
			self:ToggleShowingBoth()
		end
	end
		
	return self.data.showPercent
end
	
function FuBar_Factions:IsShowingBoth()
		return self.data.showBoth
end
	
function FuBar_Factions:ToggleShowingBoth(loud)
	self.data.showBoth = not self.data.showBoth
	if loud then
		self.cmd:status(self.loc.ARGUMENT_BOTH, self.data.showBoth and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	
	if ( self.data.showBoth ) then
		if ( self.data.showPercent ) then
			self:ToggleShowingPercent()
		end
	end
	
	return self.data.showBoth
end
	
function FuBar_Factions:SetMonitor(arg)
	if ( self.data.monitor == arg ) then
		self.data.monitor = ""
		self.charData.monitor = ""
	else
		self.data.monitor = arg
		self.charData.monitor = arg
	end
	self:Update()
end

FuBar_Factions:RegisterForLoad()