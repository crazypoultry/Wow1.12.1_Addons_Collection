--[[
    A big thanks to otravi and his castingbar, most of the bar code is taken 
	from his addon and warped for my evil purposes here.
    
    Textures for the castbar taken from agUF and oCB
--]]


local Colors = 
{
	complete	= {r=0, g=1, b=0},
	autoShot	= {r=1, g=.7, b=0},
	aimedShot	= {r=.3, g=.3, b=1},
	failed		= {r=1, g=0, b=0},
}

local Textures  =
{
	["Perl"]    = "Interface\\AddOns\\BigTrouble\\textures\\perl",
	["Smooth"]	= "Interface\\AddOns\\BigTrouble\\textures\\smooth",
	["Glaze"]	= "Interface\\AddOns\\BigTrouble\\textures\\glaze",
	["Default"]	= "Interface\\TargetingFrame\\UI-StatusBar",
    ["BantoBar"]    = "Interface\\AddOns\\BigTrouble\\textures\\BantoBar",
    ["Gloss"] 	= "Interface\\AddOns\\BigTrouble\\textures\\Gloss",
}

local startTime, endTime, delay, duration
local aimedShot, autoShot, spellFailed, skipSpellCastStop
local thresHold, delayString

BigTrouble = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceHook-2.1", "AceDB-2.0", "AceConsole-2.0")
local L = AceLibrary("AceLocale-2.2"):new("BigTrouble")
local gratuity = AceLibrary("Gratuity-2.0")
local gratuityTextLeft1 = gratuity.vars.Llines[1]

function BigTrouble:OnInitialize()

	self:RegisterDB("BigTroubleDB")
	self:RegisterChatCommand( {"/btrouble"}, self.options )
	self:RegisterDefaults('profile', {
	    Bar = {
			width		= 255,
			height		= 25,
			timeSize	= 12,
			spellSize	= 12,
			delaySize	= 14,
			border		= true,
            texture	    = "Default",
	    },
	    aimedDelay	= 0.35,
		pos			= {},
		autoShotBar	= true,
		aimedShotBar	= true
	})
	
	self:SetDebugging(false)

end

function BigTrouble:OnEnable()

	self.locked = true
	self.opt = self.db.profile
    
	self:CreateFrameWork()

	self:RegisterEvent("START_AUTOREPEAT_SPELL", function() autoShot = true end)
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL", function() autoShot = false end)
	self:RegisterEvent("SPELLCAST_INTERRUPTED","SpellFailed")
	self:RegisterEvent("SPELLCAST_FAILED", "SpellFailed")
	self:RegisterEvent("SPELLCAST_DELAYED", "SpellCastDelayed")
	self:RegisterEvent("SPELLCAST_STOP", "SpellCastStop")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "PlayerEnteringWorld")

	self:Hook("UseAction")
	self:Hook("CastSpell")
	self:Hook("CastSpellByName")
	
end

function BigTrouble:SavePosition()

	local x, y = self.master:GetLeft(), self.master:GetTop()
	local s = self.master:GetEffectiveScale()

	self.opt.pos.x = x * s
	self.opt.pos.y = y * s

end

function BigTrouble:SetPosition()

	if self.opt.pos.x then
		local x = self.opt.pos.x
		local y = self.opt.pos.y
	
		local s = self.master:GetEffectiveScale()

		self.master:ClearAllPoints()
		self.master:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
	else
		self.master:ClearAllPoints()
		self.master:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end

end

function BigTrouble:CreateFrameWork()

	self.master = CreateFrame("Frame", "BigTroubleFrame", UIParent)
	self.master:Hide()
    
	self.master:SetScript( "OnUpdate", self.OnUpdate )
	self.master:SetMovable(true)
	self.master:EnableMouse(true)
	self.master:RegisterForDrag("LeftButton")
	self.master:SetScript("OnDragStart", function() if not self.locked then self["master"]:StartMoving() end end)
	self.master:SetScript("OnDragStop", function() self["master"]:StopMovingOrSizing() self:SavePosition() end)

	self.master.Bar   = CreateFrame("StatusBar", nil, self.master)
	self.master.Spark = self.master.Bar:CreateTexture(nil, "OVERLAY")
	self.master.Time  = self.master.Bar:CreateFontString(nil, "OVERLAY")
	self.master.Spell = self.master.Bar:CreateFontString(nil, "OVERLAY")
	self.master.Delay = self.master.Bar:CreateFontString(nil, "OVERLAY")
    
    self:Layout()

end

function BigTrouble:Layout()

	local gameFont, _, _ = GameFontHighlightSmall:GetFont()
    
	self.master:SetWidth( self.opt.Bar.width + 9 )
	self.master:SetHeight( self.opt.Bar.height + 10 )

    local edgeFile, edgeSize
	if self.opt.Bar.border then 
		edgeFile, edgeSize = "Interface\\Tooltips\\UI-Tooltip-Border", 16 
	end
	
	self.master:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = edgeFile or "", 
		edgeSize = edgeSize or "",
		insets = {left = 5, right = 5, top = 5, bottom = 5},
	})

    self.master:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
	self.master:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)

	self.master.Bar:ClearAllPoints()
	self.master.Bar:SetPoint("CENTER", self.master, "CENTER", 0, 0)
	self.master.Bar:SetWidth( self.opt.Bar.width )
	self.master.Bar:SetHeight( self.opt.Bar.height )
	self.master.Bar:SetStatusBarTexture( Textures[self.opt.Bar.texture] )

	self.master.Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	self.master.Spark:SetWidth(16)
	self.master.Spark:SetHeight( self.opt.Bar.height + 25 )
	self.master.Spark:SetBlendMode("ADD")

	self.master.Time:SetJustifyH("RIGHT")
	self.master.Time:SetFont( gameFont, self.opt.Bar.timeSize )
	self.master.Time:SetText("X.Y")
	self.master.Time:ClearAllPoints()
	self.master.Time:SetPoint("RIGHT", self.master.Bar, "RIGHT",-10,0)

	self.master.Spell:SetJustifyH("CENTER")
	self.master.Spell:SetWidth( self.opt.Bar.width - self.master.Time:GetWidth() )
	self.master.Spell:SetFont( gameFont, self.opt.Bar.spellSize )
	self.master.Spell:ClearAllPoints()
	self.master.Spell:SetPoint("LEFT", self.master, "LEFT",10,0)

	self.master.Delay:SetTextColor(1,0,0,1)
	self.master.Delay:SetJustifyH("RIGHT")
	self.master.Delay:SetFont( gameFont, self.opt.Bar.delaySize )
	self.master.Delay:SetText("X.Y")
	self.master.Delay:ClearAllPoints()
	self.master.Delay:SetPoint("TOPRIGHT", self.master.Bar, "TOPRIGHT",-10,20)

	self:SetPosition()

end

function BigTrouble:UseAction( id, book, onself )

	spellFailed = false
	self.hooks["UseAction"]( id, book, onself )
	if spellFailed then return end

	gratuity:SetAction( id )
	local name = gratuityTextLeft1:GetText()
    
	if( name == L["Aimed Shot"] ) then
		if not aimedShot then
			self:AimedShot()
		end
	elseif( name ~= L["Auto Shot"] ) then
		skipSpellCastStop = true
	end

end

function BigTrouble:CastSpell( id, book )

	spellFailed = false
	self.hooks["CastSpell"]( id, book )
	if spellFailed then return end

	local name = GetSpellName( id, book )
    
	if( name == L["Aimed Shot"] ) then
		if not aimedShot then
			self:AimedShot()
		end
	elseif( name ~= L["Auto Shot"] ) then
		skipSpellCastStop = true
	end

end

function BigTrouble:CastSpellByName( spellName )

	spellFailed = false
	self.hooks["CastSpellByName"]( spellName )
	if spellFailed then return end

	local _, _, name = string.find( spellName, "([%w%s]+)" )
    
	if( name == L["Aimed Shot"] ) then
		if not aimedShot then
			self:AimedShot()
		end
	elseif( name ~= L["Auto Shot"] ) then
		skipSpellCastStop = true
	end

end

--[[
	My appology neronix. The duration code down below was 
	blantanly stolen from neronix, i did so without concern or consideration
	for his feeling. I could at this point say that im sorry and it wont happen
	again, but knowing what an evil git i am that would prolly be a lie.
	But i can say that it is a clever solution to the haste problem and you deserve
	kudos for thinking of it neronix.
--]]

function BigTrouble:AimedShot()

	skipSpellCastStop = true
    if not self.opt.aimedShotBar then return end
    
	aimedShot = true
	
    local speedCurrent = UnitRangedDamage("player")
    gratuity:SetInventoryItem("player", 18)
    local _, _, speedMax = gratuity:Find("([,%.%d]+)", nil, nil, true)
    
    -- Need to be done for our german clients, this should be localised for all clients.
    -- Although now that i think about it, what other punctuations are used besides , and . for
    -- numbers
    local speedMax = string.gsub( speedMax, ",", "." )
    
    local speed = speedMax / speedCurrent

    duration = ( 3.0 / speed ) + self.opt.aimedDelay
	self.master.Bar:SetStatusBarColor( Colors.aimedShot.r, Colors.aimedShot.g, Colors.aimedShot.b )
	self:BarCreate(L["Aimed Shot"])

end

function BigTrouble:BarCreate(s)

	if( s == L["Auto Shot"] and not self.opt.autoShotBar ) then return end
	if( s == L["Aimed Shot"] and not self.opt.aimedShotBar ) then return end

	startTime = GetTime()
	endTime = startTime + duration

	self.master.Bar:SetMinMaxValues( startTime, endTime )
	self.master.Bar:SetValue( startTime )
	self.master.Spell:SetText(s)
	self.master:SetAlpha(1)
	self.master.Time:SetText("")
	self.master.Delay:SetText("")

	delay = 0
	thresHold = false

	self.master:Show()
	self.master.Spark:Show()

end

function BigTrouble:OnUpdate()

	if( ( aimedShot or autoShot ) and not thresHold ) then
		local currentTime = GetTime()
	
		if( currentTime > endTime ) then
			currentTime = endTime
			thresHold = true

			if( aimedShot ) then
                aimedShot = false
                BigTrouble.master.Bar:SetStatusBarColor( Colors.complete.r, Colors.complete.g, Colors.complete.b )
            end
		end

		BigTrouble.master.Time:SetText( string.format( "%.1f", ( endTime - currentTime )))
		if( delay ~= 0 ) then BigTrouble.master.Delay:SetText( delayString ) end
		BigTrouble.master.Bar:SetValue( currentTime )

		local sparkProgress = (( currentTime - startTime ) / ( endTime - startTime )) * BigTrouble.opt.Bar.width
		BigTrouble.master.Spark:SetPoint("CENTER", BigTrouble.master.Bar, "LEFT", sparkProgress, 0)
	else
		local a = BigTrouble.master:GetAlpha() - .05

		if( a > 0 ) then
			BigTrouble.master:SetAlpha(a)
		else
			BigTrouble.master:Hide()
			BigTrouble.master.Time:SetText("")
			BigTrouble.master.Delay:SetText("")
			BigTrouble.master:SetAlpha(1)
		end
	end

end

--[[
	Stupid fix for reseting state when zoning and AutoShot or
	Aimed Shot is casting
--]]
function BigTrouble:PlayerEnteringWorld()

	autoShot = false
	aimedShot = false
	
	if( self.locked ) then self.master:Hide() end

end

function BigTrouble:SpellCastStop()

	if( skipSpellCastStop ) then skipSpellCastStop = false return end

	if( autoShot and not aimedShot ) then
		duration = UnitRangedDamage("player")
		self.master.Bar:SetStatusBarColor( Colors.autoShot.r, Colors.autoShot.g, Colors.autoShot.b )
		self:BarCreate(L["Auto Shot"]) 
	end

end

function BigTrouble:SpellFailed()

	if event == "SPELLCAST_FAILED" then spellFailed = true end
	
	--[[
		If we are still doing an Auto Shot while getting a here
		it means we failed/interrupted either a Aimed Shot or a sting during a cycle
		this we can safley ignore and just return from it.
		
		The exception to this being if were in the middle of an Aimed Shot and
		were still also Auto Shoting
	--]]
	if autoShot and not aimedShot then return end
    
	aimedShot = false

	--[[
		We use this to check if we are actaully shooting anything, this since
		autoShot is turned off before this event gets called and hence cannot
		be used to check if we are doing something
	--]]
	if( self.master:IsShown() ) then
		self.master.Spark:Hide()
        
		self.master.Bar:SetMinMaxValues( 0, duration + delay )
		self.master.Bar:SetValue( duration + delay )
		self.master.Bar:SetStatusBarColor( Colors.failed.r, Colors.failed.g, Colors.failed.b )
		self.master.Spell:SetText(L[event])
	end

end

function BigTrouble:SpellCastDelayed( d )

	if( self.master:IsShown() ) then
		d = d / 1000

		startTime = startTime + d
		endTime = endTime + d
		delay = delay + d
        
        delayString = "+"..string.format( "%.1f", delay )
        
		self.master.Bar:SetMinMaxValues( startTime, endTime )
	end

end