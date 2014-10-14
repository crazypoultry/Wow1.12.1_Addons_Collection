--[[ 
	Target Raid Icon (TRI)
]]--

BINDING_NAME_TRISTAR 		= "Target Star"			-- 1
BINDING_NAME_TRICIRCLE		= "Target Circle"		-- 2
BINDING_NAME_TRIDIAMOND		= "Target Diamond"		-- 3
BINDING_NAME_TRITRIANGLE	= "Target Triangle"		-- 4
BINDING_NAME_TRIMOON		= "Target Moon"			-- 5
BINDING_NAME_TRISQUARE		= "Target Square"		-- 6
BINDING_NAME_TRICROSS		= "Target Cross"		-- 7
BINDING_NAME_TRISKULL		= "Target Skull"		-- 8
BINDING_NAME_TRISELECT		= "Target Default Icon"

----------------------------------------------------------------------------------------

tri = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "FuBarPlugin-2.0")
tri:RegisterDB("triDB")
tri:RegisterDefaults('profile', {
	range = 60,
	radius = 30,
	icon = 8,
	autotarget = true,
})
tri.hasIcon = true

----------------------------------------------------------------------------------------

tri.icons  = { "Star","Circle","Diamond","Triangle","Moon","Square","Cross","Skull" }
tri.ricons = { Star=1,Circle=2,Diamond=3,Triangle=4,Moon=5,Square=6,Cross=7,Skull=8 }  -- reverse lookup

function tri:OnInitialize()
	local Options = {
		type="group", handler = tri,
		args = {
			notify = {
				name = 'notify',
				type = 'toggle',
				desc = 'Notify when new targets are assigned',
				get = function() return self.db.profile.notify end,
				set = function(v) 
					self.db.profile.notify = v 
					if v then 
						self:RegisterEvent("RAID_TARGET_UPDATE") 
					else 
						self:UnregisterEvent("RAID_TARGET_UPDATE")
					end
				end,
			},
			icon = {
				type = 'text',
				name = 'icon',
				usage = '<value>',
				desc = 'Set your default icon',
				get = function() return self.db.profile.icon end,
				set = function(icon) 
					self.db.profile.icon = tonumber(self.ricons[icon])
					self:Update()
				end,
				validate = self.icons,
			},
			radius = {
				type = 'range',
				name = 'radius',
				desc = 'max scan radius',
				get = function() return self.db.profile.radius end,
				set = function(v) self.db.profile.radius = v end,
				min = 15,
				max = 50,
				step = 1,
			},
			range = {
				type = 'range',
				name = 'range',
				desc = 'max scan distance',
				get = function() return self.db.profile.range end,
				set = function(v) self.db.profile.range = v end,
				min = 40,
				max = 120,
				step = 1,
			},
		}
	}

	self.compost = AceLibrary("Compost-2.0")
	
	self.defaultPosition = "LEFT"
	self.defaultMinimapPosition = 250
	
	self.tnd = GetCVar("targetNearestDistance")
	self.tndr = GetCVar("targetNearestDistanceRadius")

	self:RegisterChatCommand({ "/targetraidicon","/tri"}, Options)
	self.OnMenuRequest = Options
end

function tri:OnEnable()
	self.group_cache = self.compost:Acquire()
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	if (self.db.profile.notify) then self:RegisterEvent("RAID_TARGET_UPDATE") end
end

function tri:OnDisable()
	self.compost:Reclaim(self.group_cache)
end

----------------------------------------------------------------------------------------

function tri:RAID_TARGET_UPDATE()
	--self:Print("Raid Target Update|"..arg1 or "".."|"..arg2 or "")
	if not (UnitExists("target") and GetRaidTargetIndex("target") == self.db.profile.icon) then
		self:Notify("New targets have been assigned!", 0, 0.8, 0)
		--self:ScanGroupForIcon(self.db.profile.icon)
	end
end

function tri:PARTY_MEMBERS_CHANGED()
	self.compost:Erase(self.group_cache)
	self:IterateGroup("party",GetNumPartyMembers())
end

function tri:RAID_ROSTER_UPDATE()
	self.compost:Erase(self.group_cache)
	self:IterateGroup("raid",GetNumRaidMembers())
end

----------------------------------------------------------------------------------------

function tri:FindRaidTarget(icon)
	if self:ScanMobsForIcon(icon) then return end
	if self:ScanGroupForIcon(icon) then return end	
	ClearTarget()
	self:Print("No Target Found")
end

function tri:ScanMobsForIcon(icon)
	SetCVar("targetNearestDistance",self.db.profile.range)
	SetCVar("targetNearestDistanceRadius",self.db.profile.radius)
	for i = 1,16 do
		TargetNearestEnemy()
		if UnitExists("target") and GetRaidTargetIndex("target") == icon then
			self:Notify("Targeting "..UnitName("target"), 0, 0.8, 0)
			SetCVar("targetNearestDistance",self.tnd)
			SetCVar("targetNearestDistanceRadius",self.tndr)
			return true
		end
	end
	SetCVar("targetNearestDistance",self.tnd)
	SetCVar("targetNearestDistanceRadius",self.tndr)
end

function tri:ScanGroupForIcon(icon)
	for _,unit in pairs(self.group_cache) do
		if (UnitExists(unit) and GetRaidTargetIndex(unit) == icon) then
			TargetUnit(unit)
			self:Notify("Targeting "..UnitName("target"), 0, 0.8, 0)
			return true
		end
	end	
end

function tri:IterateGroup(group,count)
	for i=1,count do
		unit = group..i
		table.insert(self.group_cache, unit.."target")
		if UnitExists(unit.."pet") then
			table.insert(self.group_cache, unit.."pettarget")
		end
	end
end

function tri:OnTextUpdate()
	self:SetText(self.icons[self.db.profile.icon])
	self:SetIcon(tostring(self.icons[self.db.profile.icon]) .. ".tga")
end

function tri:Notify(msg, red, green, blue )
	if ( MikSBT ) then
		MikSBT.DisplayMessage(msg, MikSBT.DISPLAYTYPE_NOTIFICATION, true, red * 255, green * 255, blue * 255,24)
	elseif ( SCT ) then
		--SCT_MSG_FRAME:AddMessage(msg, red, green, blue, 1.0, UIERRORS_HOLD_TIME);
		SCT:DisplayText(msg,{r = red,g = green,b = blue}, true, "event", 1)
	else
		RaidWarningFrame:AddMessage(msg, red, green, blue, 1.0, UIERRORS_HOLD_TIME)
	end
end