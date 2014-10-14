--MainAssist Version 2.1 by Nargiddley
--Last Update 05/11/2006

BINDING_HEADER_MAINASSISTHEADER = "Main Assist";

MainAssist = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")
local L = AceLibrary("AceLocale-2.2"):new("MainAssist")

---------------------
-- On___ Functions --
---------------------

function MainAssist:OnInitialize()
	self.LEFT_RAID_MATCH ="^"..string.gsub(ERR_RAID_MEMBER_REMOVED_S,"%%s","([^%%s]+)").."$"
	
	self:RegisterDB("MainAssistDB")
	self:RegisterDefaults('profile', {
		showtot = false,
		scale = 1,
		locked = false,
		hidewhenlocked = false,
		hidewhenempty = false,
		shownumtargeting = true,
		growup = false,
		ctra = {
			enable = true,
			autoparty = false,
		},
		custom = {
			enable = true,
			hidectra = true,
			list = {}
		},
		smartassist = {
			ctra = true,
			custom = true,
			position = "FIRST"
		},
		coloring = "Self",
	})
	self:RegisterDefaults('account', {
			tanks = {
				ctra = {},
				custom = {}
			},
			anchor = {
				x = 200,
				y = 200
			}
	})
	self.dewdrop = AceLibrary("Dewdrop-2.0")
	self.opts = {
		type = "group",
		args = {
			Add = {
				guiHidden = true,
				name = L["ADD"],
				type = "text",
				usage = L["ADD_USAGE"],
				desc = L["ADD_DESC"],
				order = 1,
				get = false,
				set = function(name) self:AddCustomTank(name) end
			},
			TankLists = {
				type = "header",
				name = L["TANK_LIST_HEADER"],
				order = 100,
			},
			Custom = {
				type = "group",
				name = L["CUSTOM"],
				desc = L["CUSTOM_DESC"],
				order = 101,
				args = {
					Add = {
						guiName = L["ADDNAME"],
						cmdName = L["ADD"],
						type = "text",
						usage = L["ADD_USAGE"],
						desc = L["ADD_DESC"],
						order = 1,
						get = false,
						set = function(name) self:AddCustomTank(name) end
					},
					AddTar = {
						guiName = L["ADDTARGET"],
						cmdName = L["ADDTARGET_SHORT"],
						type = "execute",
						desc = L["ADDTARGET_DESC"],
						order = 2,
						func = function() self:AddCustomTankFromTarget() end
					},
					Remove = {
						name = L["REMOVE"],
						desc = L["REMOVE_DESC"],
						order = 3,
						type = "text",
						current = "",
						get = function() return "" end,
						validate = {},
						set = function(value) self:RemoveCustomTank(value) end
					},
					Arrange = {
						name = L["ARRANGE"],
						desc = L["ARRANGE_DESC"],
						cmdHidden = true,
						order = 4,
						type = "text",
						current = "",
						get = function() return "" end,
						validate = {},
						set = 	function(value)	self:MoveCustomTank(value,IsShiftKeyDown()) end
					},
					Clear = {
						name = L["CLEAR"],
						type = "execute",
						desc = L["CLEAR_CUSTOM_DESC"],
						order = 5,
						func = function() self:ClearCustomTanks() end
					},
					HideCTRA = {
						name = L["HIDE_CTRA"],
						type = "toggle",
						desc = L["HIDE_CTRA_DESC"],
						order = 6,
						get = function() return self.db.profile.custom.hidectra end,
						set = function(value) self.db.profile.custom.hidectra = value self:RebuildTankList() end
					},
					Enable = {
						name = L["ENABLE"],
						type = "toggle",
						desc = L["ENABLE_CUSTOM_DESC"],
						order = 7,
						get = function() return self.db.profile.custom.enable end,
						set = function(value) self.db.profile.custom.enable = value self:RebuildTankList() end
					}
				}
			},
			CTRA = {
				type = "group",
				name = L["CTRA"],
				desc = L["CTRA_DESC"],
				order = 102,
				args = {
					Enable = {
						name = L["ENABLE"],
						type = "toggle",
						desc = L["ENABLE_CTRA_DESC"],
						get = function() return self.db.profile.ctra.enable end,
						set = function(value) self.db.profile.ctra.enable = value self:RebuildTankList() end
					},
					AutoParty = {
						name = L["CTRA_AUTOPARTY"],
						type = "toggle",
						desc = L["CTRA_AUTOPARTY_DESC"],
						get = function() return self.db.profile.ctra.autoparty end,
						set = function(value) self.db.profile.ctra.autoparty = value self:AutoPartyToCTRATanks() end
					}, 
				},				
			},
			SmartAssist = {
				type = "group",
				name = L["SMART_ASSIST"],
				desc = L["SMART_ASSIST_OPTIONS"],
				order = 103,
				args = {
					List = {
						name = L["SMART_ASSIST_LIST"],
						type = "header",
						order = 1,
					},
					CTRA = {
						name = L["CTRA"],
						type = "toggle",
						order = 2,
						desc = L["CTRA"],
						get = function() return self.db.profile.smartassist.ctra end,
						set = function(value) self.db.profile.smartassist.ctra = value end
					},
					Custom = {
						name = L["CUSTOM"],
						type = "toggle",
						order = 3,
						desc = L["CUSTOM"],
						get = function() return self.db.profile.smartassist.custom end,
						set = function(value) self.db.profile.smartassist.custom = value end
					},		
					
					Position = {
						name = L["SMART_ASSIST_POSITION"],
						type = "header",
						order = 10,

					},
					First = {
						name = L["SMART_ASSIST_FIRST"],
						type = "toggle",
						desc = L["SMART_ASSIST_FIRST_DESC"],
						order = 11,
						get = function() return self.db.profile.smartassist.position == "FIRST" end,
						set = function(value) self.db.profile.smartassist.position = "FIRST" end
					},
					Last = {
						name = L["SMART_ASSIST_LAST"],
						type = "toggle",
						desc = L["SMART_ASSIST_LAST_DESC"],
						order = 11,
						get = function() return self.db.profile.smartassist.position == "LAST" end,
						set = function(value) self.db.profile.smartassist.position = "LAST" end
					}	
					
				}
			},
			ShowToT = {
				name = L["SHOWTOT_SHORT"],
				guiName = L["SHOWTOT"],
				type = "toggle",
				desc = L["SHOWTOT_DESC"],
				order = 104,
				get = function() return self.db.profile.showtot end,
				set = function(value) self.db.profile.showtot = value end,
			},
			ShowNumTargeting = {
				name = L["SHOWNUMTARGETING_SHORT"],
				guiName = L["SHOWNUMTARGETING"],
				type = "toggle",
				desc = L["SHOWNUMTARGETING_DESC"],
				order = 105,
				get = function() return self.db.profile.shownumtargeting end,
				set = function(value) self.db.profile.shownumtargeting = value end,
			},
			Coloring = {
				name = L["COLORING"],
				type = "group",
				desc = L["COLORING_DESC"],
				order = 105,
				args = {
					Unique = {
						name = L["UNIQUE"],
						type = "toggle",
						desc = L["UNIQUE_DESC"],
						get = function() return self.db.profile.coloring == "Unique" end,
						set = function() self.db.profile.coloring = "Unique" end,
					},
					Self = {
						name = L["SELF"],
						type = "toggle",
						desc = L["SELF_DESC"],
						get = function() return self.db.profile.coloring == "Self" end,
						set = function() self.db.profile.coloring = "Self" end,
					}
				},

			},
			GrowUp = {
				guiName = L["GROWUP_GUI"],
				cmdName = L["GROWUP_CMD"],
				type = "toggle",
				desc = L["GROWUP_DESC"],
				order = 202,
				get = function() return self.db.profile.growup end,
				set = function(value) self.db.profile.growup = value 	
							self:LayoutTankFrames()
						end
			},
			spacer1 = {
				type = "header",
				order = 199,
			},
			Options = {
				name = L["OPTIONS"],
				type = "header",
				order = 200,
			},
			Scale = {
				name = L["SCALE"],
				type = "range",
				desc = L["SCALE_DESC"],
				order = 201,
				min = 0.5,
				max = 2,
				step = 0.1,
				get = function() return self.db.profile.scale end,
				set = function(value) self:ChangeScale(value) end
			},
			Lock = {
				name = L["LOCK"],
				type = "toggle",
				desc = L["LOCK_DESC"],
				order = 202,
				get = function() return self.db.profile.locked end,
				set = function(value) self.db.profile.locked = value 	
							self:UpdateAnchorVisible()
						end
			},
			Hide = {
				name = L["HIDELOCKED"],
				guiName = L["HIDELOCKED_GUI"],
				type = "toggle",
				desc = L["HIDELOCKED_DESC"],
				order = 203,
				get = function() return self.db.profile.hidewhenlocked end,
				set = function(value) self.db.profile.hidewhenlocked = value 	
							self:UpdateAnchorVisible()
						end
			},
			HideEmpty = {
				name = L["HIDEEMPTY"],
				guiName = L["HIDEEMPTY_GUI"],
				type = "toggle",
				desc = L["HIDEEMPTY_DESC"],
				order = 204,
				get = function() return self.db.profile.hidewhenempty end,
				set = function(value) self.db.profile.hidewhenempty = value 	
							self:UpdateAnchorVisible()
						end
			},			
			Reset = {
				guiName = L["RESET_GUI"],
				name = L["RESET"],
				desc = L["RESET_DESC"],
				type = "execute",
				order = 204,
				func = function() self.db.account.anchor.x = 200 self.db.account.anchor.y = 200 self:LoadAnchorPosition() end,
			},
			Menu = {
				name = L["MENU"],
				type = "execute",
				desc = L["MENU_DESC"],
				guiHidden = true,
				cmdHidden = false,
				func = function() self:ShowMenu() end
			}
		}
	}
	
	self:InitColors()
	self:RefreshCustomRemoveMenu()
	
	self.TankList = {}
	self.UniqueTargets = {}
	self.TargetingCounts = {}
	self.AssistFrameCache = {}
	self.HeaderFrameCache = {}

	self:RegisterChatCommand({ "/mainassist", "/ma" }, self.opts )
end

function MainAssist:OnEnable()
    --initilisation that needs to happen after PLAYER_LOGIN, but only needs to happen once
    if not self.Loaded then
    	self.Loaded = true
    	self:CreateAnchorFrame()
    end 
    self:RegisterEvent("CHAT_MSG_ADDON")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	
	self:AutoPartyToCTRATanks()
	self:UpdateAnchorVisible()
    self:RebuildTankList()
    
    --schedule an update every 300ms
	self.UpdateID = self:ScheduleRepeatingEvent(function() self:OnUpdate() end, 0.4)
end

function MainAssist:OnDisable()
	self:CancelScheduledEvent(self.UpdateID)
	self:EmptyTankList()
	self:HideAnchor()
end

function MainAssist:OnUpdate()
	self:UpdateTankFrames()
end

--------------------------
-- Frame Pool Functions --
--------------------------

function MainAssist:GetFrame(frametype)

	local cache
	local frameclass
	if frametype == "assist" then
		--chatmsg("Getting assist frame")
		cache = self.AssistFrameCache
		frameclass = MA_AssistFrame
	elseif frametype == "header" then
		--chatmsg("Getting header frame")
		cache = self.HeaderFrameCache
		frameclass = MA_HeaderFrame
	else
		return nil
		
	end
	
	local numcached = getn(cache)
	local f
	if numcached > 0 then
		--return a cached frame and remove it from the cache
		--chatmsg("Getting cached frame "..numcached)
		f = cache[numcached]
		table.remove(cache,numcached)
	else
		--no frames cached, create a new one and return it
		--chatmsg("Getting new frame")
		f = frameclass:new(self.AnchorFrame.frame)
	end

	return f
end

function MainAssist:ReleaseFrame(frametype,frame)
	--make sure the frame is hidden
	if frametype and frame then 
		frame:Hide()
		frame:ClearAllPoints()
		if frametype == "assist" then
			cache = self.AssistFrameCache
		elseif frametype == "header" then
			cache = self.HeaderFrameCache
		else
			--unknown frame type
			return nil
		end
		--put it into the cache
		table.insert(cache,frame)
	end
end

----------------------------
-- Anchor Frame Functions --
----------------------------

function MainAssist:UpdateAnchorVisible()
	local numtanks = self:CountCTRATanks() + self:CountCustomTanks()
	
	if (self.db.profile.locked and self.db.profile.hidewhenlocked) or (self.db.profile.hidewhenempty and numtanks == 0) then
		self:HideAnchor()
	else
		self:ShowAnchor()
	end 
end

function MainAssist:CreateAnchorFrame()

	self.AnchorFrame = MA_HeaderFrame:new(UIParent)
	local f = self.AnchorFrame
	
	f:SetText("MainAssist")
	f.frame:EnableMouse(true)
	f.frame:SetMovable(true)
	f.frame:SetClampedToScreen(true)
	
	f:SetScript("OnMouseDown",	function() 
									if not self.db.profile.locked then 
										this:StartMoving() 
									end 
								end )

	f:SetScript("OnMouseUp", 	function()
									this:StopMovingOrSizing()
									self:SaveAnchorPosition()
								end )

    self.dewdrop:Register(f.frame,
   		'children', function()
   			self.dewdrop:FeedAceOptionsTable(self.opts)
   		end
	)
	f.frame:SetScale(self.db.profile.scale)
	
	self:LoadAnchorPosition()
	
	f:Show()
	
	self:UpdateAnchorVisible()
	
end

function MainAssist:ShowAnchor()
	self.AnchorFrame:SetText("MainAssist")
	self.AnchorFrame.frame:EnableMouse(true)
end

function MainAssist:HideAnchor()
	self.AnchorFrame:SetText("")
	self.AnchorFrame.frame:EnableMouse(false)
end

function MainAssist:SaveAnchorPosition()
	local s = MainAssist.AnchorFrame.frame:GetEffectiveScale()
	self.db.account.anchor.x = this:GetLeft() * s
	self.db.account.anchor.y = this:GetTop() * s
end

function MainAssist:LoadAnchorPosition()				
	local s = self.AnchorFrame.frame:GetEffectiveScale()
	self.AnchorFrame:ClearAllPoints()
	self.AnchorFrame:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT", self.db.account.anchor.x / s, self.db.account.anchor.y / s)
end

function MainAssist:ChangeScale(newscale)
	self.db.profile.scale = newscale
	self.AnchorFrame.frame:SetScale(newscale)
	self:LoadAnchorPosition()
end
----------------------------------
-- Unique Target List Functions --
----------------------------------

function MainAssist:UpdateUniqueTargetList()
	local NextID = 1
	local unitlist = self.UniqueTargets
	local countlist = self.TargetingCounts
	
	--empty the current lists
	for k,v in pairs(unitlist) do
		unitlist[k] = nil
	end
	for k,v in pairs(countlist) do
		countlist[k] = nil
	end
	
	--init the unit list
	for k,v in pairs(self.TankList) do
		if v.type == "assist" then
			if v.unit then
				unitlist[v.unit] = 0
			end
		end
	end
	
	for unit,id in pairs(unitlist) do
		if UnitExists(unit) and UnitExists(unit.."target") then
			--if unit exists and has a target
			for unit2,id2 in pairs(unitlist) do
				--if this isnt the same unit but has the same target then tag as the same
				if unit ~= unit2 and UnitIsUnit(unit.."target",unit2.."target") then
					unitlist[unit] = id2
					break
				end
			end
			if unitlist[unit] == 0 then
				unitlist[unit] = NextID
				NextID = NextID + 1
			end
		else
			unitlist[unit] = 0
		end
		if not countlist[unitlist[unit]] then
			countlist[unitlist[unit]] = self:NumTargeting(unit.."target")
		end
	end
end

function MainAssist:NumTargeting(unit) 
	local PartyType = "";
	local NumMembers = 0;
	local Count = 0;
	if GetNumRaidMembers() > 0 then
		PartyType = "raid";
		NumMembers = GetNumRaidMembers();
	else
		PartyType = "party";
		NumMembers = GetNumPartyMembers();
		if UnitIsUnit("target",unit) then
			Count = Count + 1
		end
	end
	
	if NumMembers > 0 then
		for i = 1, NumMembers, 1 do
			if UnitIsUnit(PartyType..i.."target",unit) then
				Count = Count + 1
			end
		end
	end
	
	return Count
end

-------------------------
-- Tank List Functions --
-------------------------
function MainAssist:EmptyTankList()
	local f	
	--empty the tank list releasing frames as we go
	if self.TankList then
		while getn(self.TankList) > 0 do
			f = table.remove(self.TankList)
			self:ReleaseFrame(f.type,f.frame)
		end
	end
end

function MainAssist:RebuildTankList()
	local newframe
	self:EmptyTankList()
	
	if self.db.profile.ctra.enable and self:CountCTRATanks() > 0 then
		table.insert(self.TankList, { type="header", name="CTRA Tanks",frame=self:GetFrame("header") } )
		local lastID
		for k,v in pairs(self.db.account.tanks.ctra) do
			if lastID and (lastID + 1) ~= k then
				table.insert(self.TankList, { type="header", name="", frame=self:GetFrame("header") } )
			end
			lastID = k
			newframe = self:GetFrame("assist")
			newframe:SetList("CTRA")
			table.insert(self.TankList, { type="assist", name=v, id=k, frame=newframe, unit=nil } )			
		end
	end
	
	if self.db.profile.custom.enable and self:CountCustomTanks() > 0 then
		table.insert(self.TankList, { type="header", name="Custom Tanks",frame=self:GetFrame("header") } )
		for k,v in pairs(self.db.account.tanks.custom) do
			local isCTRATank = false
			
			if self.db.profile.ctra.enable then
				for _,ct in pairs(self.db.account.tanks.ctra) do
					if v == ct then
						isCTRATank = true
					end
				end
			end
			if (not self.db.profile.custom.hidectra) or (not isCTRATank) then
				newframe = self:GetFrame("assist")
				newframe:SetList("Custom")
				table.insert(self.TankList, { type="assist", name=v, frame=newframe, unit=nil } )
			end
		end
	end
	
	self:LayoutTankFrames()
	self:UpdateTankFrames()
	--self:CheckSmartAssistCustomName()
end

function MainAssist:FindTankListUnits()
	for k,v in pairs(self.TankList) do
		if v.type == "assist" then
			v.unit = self:NameToUnitID(v.name)
		end
	end
end

--anchor the tank list items
function MainAssist:LayoutTankFrames()
	local prev = nil
	if self.db.profile.growup then
		for k,v in pairs(self.TankList) do
			v.frame.frame:ClearAllPoints()
			if prev then
				prev:SetPoint("BOTTOMLEFT",v.frame.frame,"TOPLEFT",0,0)
			end			
			v.frame.frame:Show()
			prev = v.frame.frame
		end
		if prev then
			prev:SetPoint("BOTTOMLEFT",self.AnchorFrame.frame,"TOPLEFT",0,0)
		end
	else
		prev = self.AnchorFrame.frame
		for k,v in pairs(self.TankList) do
			v.frame.frame:ClearAllPoints()
			v.frame.frame:SetPoint("TOPLEFT",prev,"BOTTOMLEFT",0,0)
			v.frame.frame:Show()
			prev = v.frame.frame
		end
	end	
end

function MainAssist:UpdateTankFrames()
	self:ResetColors()
	self:FindTankListUnits()
	self:UpdateUniqueTargetList()
	self:FindSmartAssistName()
	
	for k,v in pairs(self.TankList) do
		if v.type == "assist" then
			v.frame:ShowToT(self.db.profile.showtot)
			
			if v.name == self.db.profile.smartassist.name then
				v.frame:SetNameColor(self.Colors["Text-Assist"])
			else
				v.frame:SetNameColor(self.Colors["Text"])
			end
				
			if v.unit then
				
				local numtargeting = nil
				if self.db.profile.shownumtargeting then
					numtargeting = self.TargetingCounts[self.UniqueTargets[v.unit]]
				end
			
				v.frame:UpdateFromUnit(v.unit,numtargeting)
				
				if UnitExists(v.unit.."target") then
					if self.db.profile.coloring == "Unique" then
						local found = false
						for k2,v2 in pairs(self.TankList) do
							if k ~= k2 and v2.unit then
								if UnitIsUnit(v.unit.."target",v2.unit.."target") then
									found = true
									break
								end
							end
						end
						if not found then
							v.frame:SetColor(self.Colors["Targeted"])
						else
							v.frame:SetColor(self:GetColor(self.UniqueTargets[v.unit]))
						end
					else
						if UnitIsUnit(v.unit.."target","target") then
							v.frame:SetColor(self.Colors["Targeted"])
						else
							v.frame:SetColor(self:GetColor(self.UniqueTargets[v.unit]))
						end
					end
					
				else
					v.frame:SetColor(self.Colors["NoTarget"])
				end
			else

				v.frame:Update(v.name,L["STATUS_NOTHERE"],0)
				v.frame:SetColor(self.Colors["NoTarget"])
			end	
		elseif v.type == "header" then
			v.frame:SetText(v.name)
		end
	end
end

-------------------------
-- CTRA Tank Functions --
-------------------------

function MainAssist:SetCTRATank(id,name)
	self:RemoveCTRATank(name)
	self.db.account.tanks.ctra[tonumber(id)] = name
	self:RebuildTankList()
	self:UpdateAnchorVisible()
end

function MainAssist:RemoveCTRATank(name)
	for k, v in pairs(self.db.account.tanks.ctra) do
		if v == name then
			self.db.account.tanks.ctra[k] = nil
		end
	end
	self:RebuildTankList()
	self:UpdateAnchorVisible()
end

function MainAssist:ClearCTRATanks()
	for k, v in pairs(self.db.account.tanks.ctra) do
		self.db.account.tanks.ctra[k] = nil
	end
end

--if not in a raid and the option is set, add all party members to the CTRA tank list
function MainAssist:AutoPartyToCTRATanks()
	if GetNumRaidMembers() == 0 then
		if GetNumPartyMembers() > 0 and self.db.profile.ctra.autoparty then
			self:ClearCTRATanks()
			for num = 1,GetNumPartyMembers() do
				self:SetCTRATank(num,UnitName("party"..num))
			end
		else
			self:ClearCTRATanks()
		end
		self:RebuildTankList()
	end	
	self:UpdateAnchorVisible()
end

function MainAssist:CountCTRATanks()
	--has to be a better way to do this?
	local count = 0
	for k, v in pairs(self.db.account.tanks.ctra) do
		count = count+1
	end
	return count
end

---------------------------
-- Custom Tank Functions --
---------------------------

function MainAssist:AddCustomTank(name)
	for k, v in pairs(self.db.account.tanks.custom) do
		if v == name then
			return
		end
	end
	table.insert(self.db.account.tanks.custom, name)
	self:RebuildTankList()
	self:RefreshCustomRemoveMenu()
	self:UpdateAnchorVisible()
end

function MainAssist:AddCustomTankFromTarget()
	if UnitExists("target") then 
		self:AddCustomTank(UnitName("target"))
	end 
end

function MainAssist:RemoveCustomTank(name)
	for k, v in pairs(self.db.account.tanks.custom) do
		if v == name then
			table.remove(self.db.account.tanks.custom, k)
		end
	end
	self:RebuildTankList()
	self:RefreshCustomRemoveMenu()
	self:UpdateAnchorVisible()
end

function MainAssist:ClearCustomTanks()
	while getn(self.db.account.tanks.custom) > 0 do
		table.remove(self.db.account.tanks.custom)
	end
	self:RebuildTankList()
	self:RefreshCustomRemoveMenu()
	self:UpdateAnchorVisible()
end

function MainAssist:CountCustomTanks()
	return getn(self.db.account.tanks.custom)
end

function MainAssist:RefreshCustomRemoveMenu()
	self.opts.args.Custom.args.Remove.validate = self.db.account.tanks.custom
	self.opts.args.Custom.args.Arrange.validate = self.db.account.tanks.custom
	self.dewdrop:Refresh(3)
end

--will either swap the positon of the 2 names given
--or if only one is in the list will replace it with the other
function MainAssist:SwapCustomTanks(name1,name2)
	if name1 and name2 then
		for k, v in pairs(self.db.account.tanks.custom) do
			if v == name1 then
				self.db.account.tanks.custom[k] = name2
			end
			if v == name2 then
				self.db.account.tanks.custom[k] = name1
			end
		end
		self:RebuildTankList()
	end
end
--moves the custom tank up(or down if given) one place in the list
function MainAssist:MoveCustomTank(name,down)
	local prev
	local done = false
	if down then
		for k, v in pairs(self.db.account.tanks.custom) do
			if prev == name then
				self:SwapCustomTanks(prev,v)
				done = true
			end
			prev = v
			if done then break end
		end
	else
		for k, v in pairs(self.db.account.tanks.custom) do
			if v == name then
				self:SwapCustomTanks(prev,v)
				done = true
			end
			prev = v
			if done then break end
		end
	end
end

----------------------------
-- Smart Assist Functions --
----------------------------

function MainAssist:SmartAssist()
	
	self:CheckSmartAssistCustomName()
	local unit
	self:FindSmartAssistName()
	if self.db.profile.smartassist.name then
		unit = self:NameToUnitID(self.db.profile.smartassist.name)
		if unit then
			AssistUnit(unit)
		end
	else
		AssistUnit("target")
	end
end

function MainAssist:CheckSmartAssistCustomName()
	if self.db.profile.smartassist.customname then
		local found = false
		for k,v in pairs(self.TankList) do
			if v.name == self.db.profile.smartassist.customname then
				found = true
			end
		end

		if not found then
			self:Print("Resetting Custom Assist")
			self.db.profile.smartassist.customname = nil
		end
	end
end

function MainAssist:FindSmartAssistName()
	local comp
	if self.db.profile.smartassist.position == "LAST" then
		comp = math.max
	else
		comp = math.min
	end
	if self.db.profile.smartassist.customname then
		self.db.profile.smartassist.name = self.db.profile.smartassist.customname
	elseif self:CountCTRATanks() > 0 and self.db.profile.smartassist.ctra and self.db.profile.ctra.enable then
		local id
		for k,v in pairs(self.db.account.tanks.ctra) do
			if not id then
				id = k
			else
				id = comp(id,k)
			end
		end
		self.db.profile.smartassist.name =self.db.account.tanks.ctra[id]
	elseif self:CountCustomTanks() > 0 and self.db.profile.smartassist.custom and self.db.profile.custom.enable then
		local id
		for k,v in pairs(self.db.account.tanks.custom) do
			if not id then
				id = k
			else
				id = comp(id,k)
			end
		end
		self.db.profile.smartassist.name = self.db.account.tanks.custom[id]
	else
		self.db.profile.smartassist.name = nil	
	end
end

function MainAssist:SetCustomAssist(name)
	self.db.profile.smartassist.customname = name
end

function MainAssist:GetCustomAssist() 
	return self.db.profile.smartassist.customname
end

----------------------
-- Color Management --
----------------------

--returns a color, if called again with the same id will return the same color
--returns nil if there aren't enough colors defined
function MainAssist:GetColor(id)
	local c = nil
	for k,v in pairs(self.ColorCache) do
		if v.inUse == nil or v.inUse == id then
			self.ColorCache[k].inUse = id
			c = v.color
			break
		end
	end
	return c
end

--will reset the colors associated with id
function MainAssist:ResetColors()
	for k,v in pairs(self.ColorCache) do
		self.ColorCache[k].inUse = nil
	end
end

function MainAssist:InitColors()
	self.ColorCache = {
	    { color = { r=0.5, g=0.0, b=0.0 }}, --deep red
	    { color = { r=1.0, g=0.0, b=0.0 }}, --red
	    { color = { r=1.0, g=0.5, b=0.0 }}, --orange
	    { color = { r=1.0, g=1.0, b=0.0 }}, --yellow
	    { color = { r=0.0, g=1.0, b=1.0 }}, --teal  
	    { color = { r=0.0, g=0.5, b=1.0 }}, --light blue    
	    { color = { r=0.0, g=0.0, b=1.0 }}, --blue
	    { color = { r=0.0, g=0.0, b=0.5 }}, --dark blue
	    { color = { r=1.0, g=0.0, b=1.0 }}, --magenta   
	    { color = { r=0.5, g=0.0, b=1.0 }}, --deep purple   
	}
	
	self.Colors = {
		["Targeted"]    = { r=0.0, g=1.0, b=0.0 }, --green
    	["NoTarget"]    = { r=0.5, g=0.5, b=0.5 }, --grey
    	["Text"]        = { r=1.0, g=1.0, b=1.0 },
    	["Text-Assist"] = { r=0.2, g=1.0, b=0.2 } 
    }
end
-----------------------
-- Utility Functions --
-----------------------

--finds a unitid based on a name
--searches the following in order
-- player, party members, pet, target, party pets, party targets
function MainAssist:NameToUnitID(unitName)
    if UnitName("player") == unitName then
    	return "player"
    end

    local PartyType = "";
    local NumMembers = 0;
    if GetNumRaidMembers() > 0 then
        PartyType = "raid";
        NumMembers = GetNumRaidMembers();
    else
        PartyType = "party";
        NumMembers = GetNumPartyMembers();
    end
    
    if NumMembers > 0 then
        for i = 1, NumMembers, 1 do
            if UnitName(PartyType..i) == unitName then
            	return PartyType..i
            end
        end
    end
    
	if UnitName("target") == unitName then
		return "target"
	end
	if UnitName("pet") == unitName then
		return "pet"
    end
    
    if NumMembers > 0 then
		for i = 1, NumMembers, 1 do
			if UnitName(PartyType.."pet"..i) == unitName then
				return PartyType.."pet"..i
			end
		end
		for i = 1, NumMembers, 1 do
			if UnitName(PartyType..i.."target") == unitName then
				return PartyType..i.."target"
			end
        end
   	end
    
    return nil;
end

function MainAssist:ShowMenu()
	self.dewdrop:Open(self.AnchorFrame.frame)
end

--------------------
-- Event Handlers --
--------------------

function MainAssist:CHAT_MSG_ADDON(prefix,msg,type,sender)
	--CTRA messages, for watching changes to the Tank List
	if prefix == "CTRA" then
		if ( string.find(msg, "#") ) then
			--split the message and process the parts
   			local init, mstart, mend, value = 1;
		   	repeat
				mstart, mend, value = string.find(msg, "([^#]+)", init);
				if ( value ) then
					self:CHAT_MSG_ADDON(prefix,value,type,sender)
					init = mend + 1;
				end
		   	until not value;
		else	
			if ( strsub(msg, 1, 4) == "SET " ) then
				local _, _, id, name = string.find(msg, "^SET (%d+) (.+)$");
				--chatmsg("CTRA - Set Tank "..id.." to "..name)
				self:SetCTRATank(id, name)
			end
			
			if ( strsub(msg, 1, 2) == "R " ) then
				local _, _, name = string.find(msg, "^R (.+)$");
				--chatmsg("CTRA - Remove Tank "..name)
				for k, v in pairs(self.db.account.tanks.ctra) do
					if v == name then
						self:RemoveCTRATank(name)

					end
				end
			end
		end
	end
end

function MainAssist:CHAT_MSG_SYSTEM(msg)
	
	local match,_,name = string.find(msg, self.LEFT_RAID_MATCH) 
	if match then
		self:RemoveCTRATank(name)	
	end
	
	if string.find(msg, ERR_RAID_YOU_LEFT) then
		self:ClearCTRATanks()
		self:RebuildTankList()
	end
	
	if string.find(msg, ERR_RAID_YOU_JOINED) then
		self:ClearCTRATanks()
		self:RebuildTankList()
	end
end

function MainAssist:PARTY_MEMBERS_CHANGED()
	self:AutoPartyToCTRATanks()
end