WitchHunt = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")

local parser = ParserLib:GetInstance("1.1")

local times = {}

function WitchHunt:OnInitialize()
	local defaults = {
		combatonly = false,
		targetonly = false,
		display = "Default",
		font = "Normal",
		lock = true,
	}
	local args = {
		type="group",
		args = {
			combatonly = {
				name = "Combat Only", type = "toggle",
				desc = "Toggle combat only mode.",
				get = function() return self.db.profile.combatonly end,
				set = function(v)
					self.db.profile.combatonly = v
				end,
			},
			targetonly = {
				name = "Target Only", type = "toggle",
				desc = "Toggle target only mode.",
				get = function() return self.db.profile.targetonly end,
				set = function(v)
					self.db.profile.targetonly = v
				end,
			},
			lock = {
				name = "Lock", type = "toggle",
				desc = "Toggle locking of the WitchHunt frame.",
				get = function() return self.db.profile.lock end,
				set = function(v)
					self.db.profile.lock = v
					self:UpdateLock()
				end,
			},
			display = {
				name = "Display Mode", type = "text",
				desc = "Select behavior for display of messages.",
				validate = {"None", "Default", "Error Frame"},
				get = function() return self.db.profile.display end,
				set = function(v)
					self.db.profile.display = v
					if v == "None" then
						if self:IsEventRegistered("WitchHunt_Message") then self:UnregisterEvent("WitchHunt_Message") end
					else 
						if not self:IsEventRegistered("WitchHunt_Message") then self:RegisterEvent("WitchHunt_Message") end
					end
				end,
			},
			font = {
				name = "Font", type = "text",
				desc = "Set the font for the display of messages in the Default frame.",
				validate = {"Small", "Normal", "Large", "Huge"},
				get = function() return self.db.profile.font end,
				set = function(v)
					self.db.profile.font = v
					self:SetFont()
				end,
			},
			test = {
				name = "Test", type = "execute",
				desc = "Test with some dummy WitchHunt messages.",
				func = function()
					self:TriggerEvent("WitchHunt_Message", "[Ammo: See it works!]", "Orange")
					self:ScheduleEvent("WitchHunt_Message", 1, "*Ammo: extra code*", "Yellow")
					self:ScheduleEvent("WitchHunt_Message", 2, "+Ammo: Super duper strength+", "LtBlue")
				end,
			}
		}
	}

	if MikSBT then
		table.insert(args.args.display.validate, "Mik's Scrolling Battle Text")
	end

	if SCT_Display or ( SCT and SCT.DisplayText ) then
		table.insert(args.args.display.validate, "Scrolling Combat Text")
		table.insert(args.args.display.validate, "Scrolling Combat Text Message")
	end

	self.colors = {
		Red    = {r=1, g=0, b=0}, Orange = {r=1, g=0.5, b=0},
		Yellow = {r=1, g=1, b=0}, Green  = {r=0, g=1, b=0},
		LtBlue = {r=0, g=1, b=1}, Blue   = {r=0, g=0, b=1},
		Purple = {r=1, g=0, b=1}, White  = {r=1, g=1, b=1},
		Black  = {r=0, g=0, b=0},
	}

	self.formats = {
		default = "$c: $e",
		emote = "[$c $e]",
		spell = "*$c: $e*",
	 	totem = "$c: $e",
		gain = "$c: +$e+",
		fade = "$c: -$e-",
	}

	self:RegisterDB("WitchHuntDB")
	self:RegisterDefaults('profile', defaults )
	
	self:RegisterChatCommand({ "/wh", "/witchhunt" }, args )
end

function WitchHunt:OnEnable()
	-- Setup the frame
	self:SetupFrames()

	-- Register our own events
	if self.db.profile.display ~= "None" then
		self:RegisterEvent("WitchHunt_Message")
	end

	-- Register the WoW events
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")

	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", function(event, info) self:EventHandler(event, info) end)
	parser:RegisterEvent("WitchHunt", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS", function(event, info) self:EventHandler(event, info) end)
end

function WitchHunt:OnDisable()
	-- no more events to handle
	parser:UnregisterAllEvents("WitchHunt")
	self:UnregisterAllEvents()
end

function WitchHunt:SetFont()
	if self.db.profile.font == "Huge" then
		self.msgframe:SetFontObject(GameFontNormalHuge)
	elseif self.db.profile.font == "Small" then
		self.msgframe:SetFontObject(GameFontNormalSmall)
	elseif self.db.profile.font == "Large" then
		self.msgframe:SetFontObject(GameFontNormalLarge)
	else
		self.msgframe:SetFontObject(GameFontNormal)
	end
end

function WitchHunt:SetupFrames()
	self.dragbutton = CreateFrame("Button",nil,UIParent)
	self.dragbutton.owner = self
	self.dragbutton:Hide()
	self.dragbutton:ClearAllPoints()
	self.dragbutton:SetWidth(200)
	self.dragbutton:SetHeight(25)
	
	if self.db.profile.x and self.db.profile.y then
		self.dragbutton:SetPoint("TOPLEFT", UIParent, "TOPLEFT", self.db.profile.x, self.db.profile.y)
	else 
		self.dragbutton:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, 0)
	end	
	self.dragbutton:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = false, tileSize = 16, edgeSize = 16,
                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})
	self.dragbutton:SetBackdropColor(1,0,0,.4)	
	
	self.dragbutton:SetMovable(true)
	self.dragbutton:RegisterForDrag("LeftButton")
	self.dragbutton:SetScript("OnDragStart", function() this.owner.dragbutton:StartMoving() end )
	self.dragbutton:SetScript("OnDragStop",
		function()
			this.owner.dragbutton:StopMovingOrSizing()
			local _,_,_,x,y = this:GetPoint("CENTER")
			this.owner.db.profile.x = x
			this.owner.db.profile.y = y
		end
                )
	
	self.dragtext = self.dragbutton:CreateFontString(nil, "OVERLAY")
	self.dragtext.owner = self
	self.dragtext:SetFontObject(GameFontNormalSmall)
	self.dragtext:ClearAllPoints()
	self.dragtext:SetTextColor(1, 1, 1, 1)
	self.dragtext:SetWidth(200)
	self.dragtext:SetHeight(25)
	self.dragtext:SetPoint("TOPLEFT", self.dragbutton, "TOPLEFT")
	self.dragtext:SetJustifyH("CENTER")
	self.dragtext:SetJustifyV("MIDDLE")
	self.dragtext:SetText("DRAG HERE")
	
	self.msgframe = CreateFrame("MessageFrame")
	self.msgframe.owner = self
	self.msgframe:ClearAllPoints()
	self.msgframe:SetWidth(600)
	self.msgframe:SetHeight(160)
	self.msgframe:SetPoint("TOP", self.dragbutton, "TOP", 0, 0)
	self.msgframe:SetInsertMode("TOP")
	self.msgframe:SetFrameStrata("HIGH")
	self.msgframe:SetToplevel(true)

	self:UpdateLock()
	self:SetFont()

	self.msgframe:Show()
end

function WitchHunt:UpdateLock()
	if not self.msgframe then self:SetupFrames() end
	if self.db.profile.lock then
		self.dragbutton:SetMovable(false)
		self.dragbutton:RegisterForDrag()
		self.msgframe:SetBackdrop(nil)
		self.msgframe:SetBackdropColor(0,0,0,0)
		self.dragbutton:Hide()
	else
		self.dragbutton:Show()
		self.dragbutton:SetMovable(true)
		self.dragbutton:RegisterForDrag("LeftButton")
		self.msgframe:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = false, tileSize = 16, edgeSize = 16,
                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})
		self.msgframe:SetBackdropColor(1,0,0,.4)
	end
end

function WitchHunt:IsFriendly( name )
	local i,n,unit
	if name == UnitName("player") then
		return true
	end
	if name == UnitName("pet") and UnitIsFriend("player", "pet") then
		return true
	end
	for i = 1, 4 do 
		unit = "party"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end
		unit = "partypet"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end			
	end
	n = GetNumRaidMembers()
	if n > 0 then
		for i = 1, n do
			unit = "raid"..i
			if name == UnitName(unit) and UnitIsFriend("player", unit) then
				return true
			end
			unit = "raidpet"..i
                        if name == UnitName(unit) and UnitIsFriend("player", unit) then
                                return true
			end
		end
	end
end

function WitchHunt:GetColor( color )
	local c = (type(color) == "string" and self.colors[color]) or color
	if type(c) == "table" then
		if c[1] then return c[1], c[2], c[3]
		elseif c.r and c.g and c.b then return c.r, c.g, c.b end
	end
end

-- Burn the witch!
function WitchHunt:Burn(caster, effect, format, color)
	if not caster or not effect then return end

	-- Are we even on a hunt?
	if self.db.profile.combatonly and not UnitAffectingCombat("player") then return end

	-- Check if this witch requires burning
	if self:IsFriendly(caster) then return end
	if self.db.profile.targetonly then
		if not UnitExists("target") then return
		elseif UnitName("target") ~= caster then return end		
	end

	-- Can we build this pyre?
	if not self.formats[format] then format = "Default" end

	-- Prepare the pyre!
	local text = string.gsub( string.gsub( self.formats[format], "$c", caster), "$e", effect )

	-- Light the Fire!
	local t = GetTime()
	if ( not times[text] ) or ( times[text] and (times[text] + 3) <= t ) then
		times[text] = t
		self:TriggerEvent("WitchHunt_Message", text, color)
	end
end


-- -- -- -- -- -- -- -- -- -- -- -- -- --
-- All events we watch out for         --
-- -- -- -- -- -- -- -- -- -- -- -- -- --

function WitchHunt:WitchHunt_Message(msg, color)
	if not msg then return end
	local red, green, blue = self:GetColor(color)
	local display = self.db.profile.display

	local frame = nil

	if MikSBT and display == "Mik's Scrolling Battle Text" then
		MikSBT.DisplayMessage(msg, MikSBT.DISPLAYTYPE_NOTIFICATION, false, red * 255, green * 255, blue * 255)
		return
	elseif ( SCT_Display or ( SCT and SCT.DisplayText ) ) and display == "Scrolling Combat Text" then
		if SCT_Display then
			SCT_Display( msg, self.colors[color] )
		else 
			SCT:DisplayText( msg, self.colors[color] )
		end
		return
	elseif ( SCT_Display or ( SCT and SCT.DisplayText ) ) and display == "Scrolling Combat Text Message" then
		if SCT_Display then
			SCT_Display_Message( msg, self.colors[color] )
		else
			SCT:DisplayMessage( msg, self.colors[color] )
		end
		return
	elseif display == "Error Frame" then
		frame = UIErrorsFrame
	elseif display == "Default" then
		frame = self.msgframe
	end

	if frame then frame:AddMessage(msg, red or 1, green or 1, blue or 1, 1, UIERRORS_HOLD_TIME) end
end


function WitchHunt:CHAT_MSG_MONSTER_EMOTE(msg, monster)
	msg = string.gsub( msg, "%%s", "")
	self:Burn( monster, msg, "emote", "Orange")
end


function WitchHunt:EventHandler(event, info)
    if info.type == "cast" then
        if info.isBegin then
            self:Burn( info.source, info.skill, "spell", "Yellow")
        else 
            if string.find(info.skill, "Totem") then
                self:Burn( info.source, info.skill, "totem", "Green")
            else
                self:Burn( info.source, info.skill, "spell", "Purple")
            end
        end
    elseif info.type == "buff" and not info.amount then 
        self:Burn( info.victim, info.skill, "gain", "LtBlue")
    end
end

