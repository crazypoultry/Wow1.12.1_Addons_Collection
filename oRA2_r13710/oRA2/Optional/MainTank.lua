assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRAOMainTank")
local roster = AceLibrary("RosterLib-2.0")
local paintchips = AceLibrary("PaintChips-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["maintankoptional"] = true,
	["mt"] = true,
	["MainTank"] = true,
	["Optional/MainTank"] = true,
	["Options for the maintanks."] = true,
	["Targettarget"] = true,
	["Toggle TargetTarget frames."] = true,
	["Scale"] = true,
	["Set frame scale."] = true,
	["Alpha"] = true,
	["Set frame alpha."] = true,
	["Raidicon"] = true,
	["Toggle raid icons."] = true,
	["Frames"] = true,
	["Options for the maintank frames."] = true,
	["Growup"] = true,
	["Toggle growup."] = true,
	["Inverse"] = true,
	["Toggle inverse healthbar."] = true,
	["Deficit"] = true,
	["Toggle deficit health."] = true,
	["Clickcast"] = true,
	["Toggle clickcast support."] = true,
	["Clicktarget"] = true,
	["Define clicktargets."] = true,
	["Define the clicktarget for maintank."] = true,
	["Define the clicktarget for target."] = true,
	["Define the clicktarget for targettarget."] = true,
	["Target"] = true,
	["Maintank"] = true,
	["TargetTarget"] = true,
	["Nr of Maintanks shown."] = true,
	["Nr Maintanks"] = true,
	["Nr"] = true,
	["Classcolor"] = true,
	["Color healthbars by class."] = true,
	["Enemycolor"] = true,
	["Set the color for enemies. (used when classcolor is enabled)"] = true,
	["Coloraggro"] = true,
	["Color Aggro"] = true,
	["Color aggro status for MTs on their names. Orange has target, Green is tanking, Red has no aggro."] = true,
	["Backdrop"] = true,
	["Toggle the backdrop."] = true,
	["Highlight"] = true,
	["Toggle highlighting your target."] = true,
	["Reverse"] = true,
	["Toggle reverse order MT|MTT|MTTT or MTTT|MTT|MT."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
--	["maintankoptional"] = "메인탱커부가",
--	["mt"] = "메인탱커",

	["MainTank"] = "메인탱커창",
	["Optional/MainTank"] = "부가/메인탱커",
	["Options for the maintanks."] = "메인탱커 설정",
	["Targettarget"] = "대상의대상",
	["Toggle TargetTarget frames."] = "대상의 대상창을 토글합니다.",
	["Scale"] = "크기",
	["Set frame scale."] = "창의 크기를 설정합니다.",
	["Alpha"] = "투명도",
	["Set frame alpha."] = "창의 투명도를 설정합니다.",
	["Raidicon"] = "공격대아이콘",
	["Toggle raid icons."] = "공격대 아이콘 표시를 토글합니다",
	["Frames"] = "창",
	["Options for the maintank frames."] = "메인탱커 창에 관한 설정",
	["Growup"] = "방향",
	["Toggle growup."] = "창의 진행 방향을 토글합니다.",
	["Inverse"] = "반전",
	["Toggle inverse healthbar."] = "생명력바 반전기능을 토글합니다.",
	["Deficit"] = "결손치",
	["Toggle deficit health."] = "생명력바 결손치 표시기능을 토글합니다.",
	["Clickcast"] = "Clickcast",
	["Toggle clickcast support."] = "clickcast 지원 토글.",
	["Clicktarget"] = "클릭타겟",
	["Define clicktargets."] = "클릭타겟 지정.",
	["Define the clicktarget for maintank."] = "메인탱커에 대한 클릭타겟 지정.",
	["Define the clicktarget for target."] = "대상에 대한 클릭타겟 지정.",
	["Define the clicktarget for targettarget."] = "대상의 대상에 대한 클릭타겟 지정.",
	["Target"] = "대상",
	["Maintank"] = "메인탱커",
	["TargetTarget"] = "대상의대상",
	["Nr of Maintanks shown."] = "표시할 메인탱커의 번호",
	["Nr Maintanks"] = "메인텅커 번호",
	["Nr"] = "번호",
	["Classcolor"] = "직업색상",
	["Color healthbars by class."] = "직업에 따른 생명력바 색상",
	["Enemycolor"] = "적색상",
	["Set the color for enemies. (used when classcolor is enabled)"] = "적에 대한 색상 설정. (직업색상이 활성화되었을 때 적용)",
	["Coloraggro"] = "Coloraggro",
	["Color Aggro"] = "어그로 색상",
	["Color aggro status for MTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "Color aggro status for MTs on their names. Orange has target, Green is tanking, Red has no aggro.",
	["Backdrop"] = "배경",
	["Toggle the backdrop."] = "배경을 토글합니다.",
	["Highlight"] = "강조",
	["Toggle highlighting your target."] = "당신의 대상 강조기능을 토글합니다.",
	["Reverse"] = "반전",
	["Toggle reverse order MT|MTT|MTTT or MTTT|MTT|MT."] = "메인탱커 순서 반전 전환.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["maintankoptional"] = "MT选项",
	["mt"] = "MT",
	["MainTank"] = "MT",
	["Optional/MainTank"] = "Optional/MainTank",
	["Options for the maintanks."] = "MT选项",
	["Targettarget"] = "目标的目标",
	["Toggle TargetTarget frames."] = "激活目标的目标框体",
	["Scale"] = "大小",
	["Set frame scale."] = "设定框体大小",
	["Alpha"] = "透明度",
	["Set frame alpha."] = "设置框体透明度",
	["Raidicon"] = "raid图标",
	["Toggle raid icons."] = "激活raid图标",
	["Frames"] = "框体",
	["Options for the maintank frames."] = "MT框体选项",
	["Growup"] = "往上增添",
	["Toggle growup."] = "激活往上增添",
	["Inverse"] = "翻转",
	["Toggle inverse healthbar."] = "锁定翻转血条",
	["Deficit"] = "少血量",
	["Toggle deficit health."] = "激活少血量",
	["Clickcast"] = "点击施法",
	["Toggle clickcast support."] = "激活点击施法",
	["Clicktarget"] = "点击设定目标",
	["Define clicktargets."] = "定义点击设定目标",
	["Define the clicktarget for maintank."] = "定义点击MT",
	["Define the clicktarget for target."] = "定义点击目标",
	["Define the clicktarget for targettarget."] = "定义点击目标的目标",
	["Target"] = "目标",
	["Maintank"] = "MT",
	["TargetTarget"] = "目标的目标",
	["Nr of Maintanks shown."] = "Nr of Maintanks shown.",
	["Nr Maintanks"] = "Nr Maintanks",
	["Nr"] = "Nr",
} end )

L:RegisterTranslations("deDE", function() return {
	["Options for the maintanks."] = "Einstellungen f\195\188r die Maintanks.",
	["Toggle TargetTarget frames."] = "Aktiviere TargetTarget Frames.",
	["Scale"] = "Gr\195\182\195\159e",
	["Set frame scale."] = "Setze Framegr\195\182\195\159e",
	["Set frame alpha."] = "Setze Framealpha",
	["Toggle raid icons."] = "Aktiviert Raidicons.",
	["Options for the maintank frames."] = "Einstellungen fr die Maintanks-Frames.",
	["Toggle growup."] = "Aktiviert das aufbauen nach oben.",
	["Inverse"] = "Invertieren",
	["Toggle inverse healthbar."] = "Aktiviert invertierte Lebensbalken.",
	["Deficit"] = "Defizit",
	["Toggle deficit health."] = "Aktiviert Lebensdefizit",
	["Toggle clickcast support."] = "Aktiviert Clickcast support.",
	["Define clicktargets."] = "Definiert Clicktargets.",
	["Define the clicktarget for maintank."] = "Definiert Clicktarget f\195\188r Maintank.",
	["Define the clicktarget for target."] = "Definiert Clicktarget f\195\188r target.",
	["Define the clicktarget for targettarget."] = "Definiert Clicktarget f\195\188r targettarget.",
	["Nr of Maintanks shown."] = "Nr der Maintanks anzeigen.",
	["Color healthbars by class."] = "F\195\164rbt Lebensbalken nach Klassen",
	["Set the color for enemies. (used when classcolor is enabled)"] = "Setzt die Farbe f\195\188r Gegner. (nur mit Classcolor aktiv)",
	["Color aggro status for MTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "Farbaggro status f\195\188r die MTs. Orange hat ein Ziel, Gr\195\188n tankt, Rot hat keine aggro.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAOMainTank = oRA:NewModule(L["maintankoptional"])
oRAOMainTank.defaults = {
	targettarget = true,
	raidicon = true,
	alpha = 1,
	scale = 1,
	growup = false,
	inverse = false,
	deficit = false,
	clickcast = true,
	ctmaintank = L["Maintank"],
	cttarget = L["Target"],
	cttargettarget = L["TargetTarget"],
	nrmts = 10,
	classcolor = true,
	enemycolor = "cc2200",
	coloraggro = true,
	backdrop = true,
	highlight = true,
	reverse = false,
}
oRAOMainTank.optional = true
oRAOMainTank.name = L["Optional/MainTank"]
oRAOMainTank.consoleCmd = L["mt"]
oRAOMainTank.consoleOptions = {
	type = "group",
	desc = L["Options for the maintanks."],
	name = L["MainTank"],
	args = {
		[L["Nr"]] = {
			type = "range",
			name = L["Nr Maintanks"],
			desc = L["Nr of Maintanks shown."],
			get = function() return oRAOMainTank.db.profile.nrmts end,
			set = function(v) oRAOMainTank:SetNrMaintanks(v) end,
			min = 0, max = 10, step = 1,
		},	
		[L["Frames"]] = {
			type = "group",
			desc = L["Options for the maintank frames."],
			name = L["Frames"],
			args = {
				[L["Classcolor"]] = {
					type = "toggle",
					name = L["Classcolor"],
					desc = L["Color healthbars by class."],
					get = function() return oRAOMainTank.db.profile.classcolor end,
					set = function(v) oRAOMainTank:SetClassColor(v) end,
				},
				[L["Enemycolor"]] = {
					type = "color",
					name = L["Enemycolor"],
					desc = L["Set the color for enemies. (used when classcolor is enabled)"],
					get = function()
						local _, r, g, b = paintchips:GetRGBPercent( oRAOMainTank.db.profile.enemycolor )
						return r, g, b
					end,
					set = function(r, g, b)
						local hex = format("%02x%02x%02x", r*255, g*255, b*255)
						paintchips:RegisterHex( hex )
						oRAOMainTank.db.profile.enemycolor = hex
					end,
					disabled = function() return not oRAOMainTank.db.profile.classcolor end,					
				},
				[L["Coloraggro"]] = {
					type = "toggle",
					name = L["Color Aggro"],
					desc = L["Color aggro status for MTs on their names. Orange has target, Green is tanking, Red has no aggro."],
					get = function() return oRAOMainTank.db.profile.coloraggro end,
					set = function(v) oRAOMainTank.db.profile.coloraggro = v end,
				},
				[L["Backdrop"]] = {
					type = "toggle",
					name = L["Backdrop"],
					desc = L["Toggle the backdrop."],
					get = function() return oRAOMainTank.db.profile.backdrop end,
					set = function(v) oRAOMainTank.db.profile.backdrop = v end,
				},
				[L["Highlight"]] = {
					type = "toggle",
					name = L["Highlight"],
					desc = L["Toggle highlighting your target."],
					get = function() return oRAOMainTank.db.profile.highlight end,
					set = function(v) oRAOMainTank.db.profile.highlight = v end,
				},
				[L["Targettarget"]] = {
					type = "toggle",
					name = L["Targettarget"],
					desc = L["Toggle TargetTarget frames."],
					get = function() return oRAOMainTank.db.profile.targettarget end,
					set = function(v) oRAOMainTank:ToggleTargetTarget(v) end,
				},
		
				[L["Scale"]] = {
					type = "range",
					name = L["Scale"],
					desc = L["Set frame scale."],
					get = function() return oRAOMainTank.db.profile.scale end,
					set = function(v) oRAOMainTank:SetScale(v) end,
					min = 0.1,
					max = 2,
				},				

				[L["Alpha"]] = {
					type = "range",
					name = L["Alpha"],
					desc = L["Set frame alpha."],
					get = function() return oRAOMainTank.db.profile.alpha end,
					set = function(v) oRAOMainTank:SetAlpha(v) end,
					min = 0.1,
					max = 1,
				},
	
				[L["Raidicon"]] = {
					type = "toggle",
					name = L["Raidicon"],
					desc = L["Toggle raid icons."],
					get = function() return oRAOMainTank.db.profile.raidicon end,
					set = function(v) oRAOMainTank:ToggleRaidIcon(v) end,
				},

				[L["Growup"]] = {
					type = "toggle",
					name = L["Growup"],
					desc = L["Toggle growup."],
					get = function() return oRAOMainTank.db.profile.growup end,
					set = function(v) oRAOMainTank:ToggleGrowup(v) end,
				},

				[L["Inverse"]] = {
					type = "toggle",
					name = L["Inverse"],
					desc = L["Toggle inverse healthbar."],
					get = function() return oRAOMainTank.db.profile.inverse end,
					set = function(v) oRAOMainTank:ToggleInverse(v) end,
				},
				[L["Reverse"]] = {
					type = "toggle",
					name = L["Reverse"],
					desc = L["Toggle reverse order MT|MTT|MTTT or MTTT|MTT|MT."],
					get = function() return oRAOMainTank.db.profile.reverse end,
					set = function(v) oRAOMainTank:ToggleReverse(v) end,
				},
				[L["Deficit"]] = {
					type = "toggle",
					name = L["Deficit"],
					desc = L["Toggle deficit health."],
					get = function() return oRAOMainTank.db.profile.deficit end,
					set = function(v) oRAOMainTank:ToggleDeficit(v) end,
				},
				
				[L["Clickcast"]] = {
					type = "toggle",
					name = L["Clickcast"],
					desc = L["Toggle clickcast support."],
					get = function() return oRAOMainTank.db.profile.clickcast end,
					set = function(v) oRAOMainTank.db.profile.clickcast = v end,
				},
				[L["Clicktarget"]] = {
					type = "group", name = L["Clicktarget"], desc = L["Define clicktargets."],
					args = {
						[L["Maintank"]] = {
							name = L["Maintank"], type = "text", desc = L["Define the clicktarget for maintank."],
							get = function() return oRAOMainTank.db.profile.ctmaintank end,
							set = function(v) oRAOMainTank.db.profile.ctmaintank = v end,
							validate = { L["Maintank"], L["Target"], L["TargetTarget"] }
						},
						[L["Target"]] = {
							name = L["Target"], type = "text", desc = L["Define the clicktarget for target."],
							get = function() return oRAOMainTank.db.profile.cttarget end,
							set = function(v) oRAOMainTank.db.profile.cttarget = v end,
							validate = { L["Maintank"], L["Target"], L["TargetTarget"] }
						},
						[L["TargetTarget"]] = {
							name = L["TargetTarget"], type = "text", desc = L["Define the clicktarget for targettarget."],
							get = function() return oRAOMainTank.db.profile.cttargettarget end,
							set = function(v) oRAOMainTank.db.profile.cttargettarget = v end,
							validate = { L["Maintank"], L["Target"], L["TargetTarget"] }
						},
					},
				},
			},
		},	
	}	
}


------------------------------
--      Initialization      --
------------------------------

function oRAOMainTank:OnInitialize()
	self.debugFrame = ChatFrame5
end


function oRAOMainTank:OnEnable()
	self.mtf = {}
	self.mttf = {}
	self.mtttf = {}

	paintchips:RegisterHex(self.db.profile.enemycolor or "cc2200" )

	self:SetupFrames()

	self:RegisterEvent("oRA_MainTankUpdate")
	self:RegisterEvent("oRA_LeftRaid")
	self:RegisterEvent("oRA_JoinedRaid", "oRA_MainTankUpdate")
	self:RegisterEvent("RosterLib_RosterChanged", function() self:oRA_MainTankUpdate() end)

	self:RegisterEvent("oRA_BarTexture")

	-- Check for Watchdog
	if (WatchDog_OnClick) then
		oRA_MainTankFramesCustomClick = WatchDog_OnClick
	end
end


function oRAOMainTank:OnDisable()
	self:UnregisterAllEvents()
end



------------------------------
--      Event Handlers      --
------------------------------

function oRAOMainTank:oRA_LeftRaid()
	self.mainframe:Hide()
end

function oRAOMainTank:oRA_MainTankUpdate( maintanktable )
	maintanktable = maintanktable or self.core.maintanktable
	if not maintanktable then return end

	local showmt, unitid


	for i = 1, self.db.profile.nrmts do
		unitid = roster:GetUnitIDFromName(maintanktable[i])

		if unitid then
			if not self.mtf[i] then	self.mtf[i] = self:CreateUnitFrame( self.mainframe, i, "mt" ) end
			if not self.mttf[i] then self.mttf[i] = self:CreateUnitFrame( self.mainframe, i, "mtt" ) end

			self.mtf[i].unit = unitid
			self.mttf[i].unit = unitid

			if self.db.profile.targettarget then
				if not self.mtttf[i] then self.mtttf[i] = self:CreateUnitFrame( self.mainframe, i, "mttt" ) end
				self.mtttf[i].unit = unitid
			end

			showmt = true

		else -- unit nolonger in the raid or unknown
			if self.mtf[i] then self.mtf[i].unit = nil end
			if self.mttf[i] then self.mttf[i].unit = nil end
			if self.mtttf[i] then self.mtttf[i].unit = nil end
		end
	end


	if showmt then
		self.mainframe:Show()
	else
		self.mainframe:Hide()
	end
end

function oRAOMainTank:oRA_BarTexture( texture )
	for _, f in pairs({ self.mtf, self.mttf, self.mtttf }) do
		for _, f in pairs(f) do
			f.bar:SetStatusBarTexture(self.core.bartextures[texture])
			f.bar.texture:SetTexture(self.core.bartextures[texture])
		end
	end
end


------------------------------
-- ConsoleOption Functions  --
------------------------------

function oRAOMainTank:SetScale(scale)
	self.db.profile.scale = scale

	self.mainframe:SetScale(scale)
	self:RestorePosition()
end


function oRAOMainTank:SetAlpha(alpha)
	self.db.profile.alpha = alpha

	self.mainframe:SetAlpha(alpha)
end

function oRAOMainTank:SetClassColor(state)
	self.db.profile.classcolor = state
        for _, f in pairs(self.mtf) do
		self:UpdateHealthBar(f.bar, self:GetUnit(f))
	end

	for _, f in pairs(self.mttf) do
		self:UpdateHealthBar(f.bar, self:GetUnit(f))
	end

	for _, f in pairs(self.mtttf) do
		self:UpdateHealthBar(f.bar, self:GetUnit(f))
	end
	
end


function oRAOMainTank:ToggleTargetTarget(state)
	self.db.profile.targettarget = state

	if state then
		self:oRA_MainTankUpdate()
	else
		for _, f in pairs(self.mtttf) do
			f:Hide()
		end
	end
end


function oRAOMainTank:ToggleRaidIcon(state)
	self.db.profile.raidicon = state

	if state then return end

	for _, f in pairs({ self.mtf, self.mttf, self.mtttf }) do
		for _, f in pairs(f) do
			f.raidicon:Hide()
		end
	end
end

function oRAOMainTank:ToggleGrowup(state)
	self.db.profile.growup = state


	for _, f in pairs(self.mtf) do
		self:SetStyle(f)
	end

	for _, f in pairs(self.mttf) do
		self:SetStyle(f)
	end

	for _, f in pairs(self.mtttf) do
		self:SetStyle(f)
	end

end

function oRAOMainTank:ToggleInverse(state)
	self.db.profile.inverse = state
end

function oRAOMainTank:ToggleReverse(state)
	self.db.profile.reverse = state
	for _, f in pairs(self.mtf) do
		self:SetStyle(f)
	end

	for _, f in pairs(self.mttf) do
		self:SetStyle(f)
	end

	for _, f in pairs(self.mtttf) do
		self:SetStyle(f)
	end
end

function oRAOMainTank:ToggleDeficit(state)
	self.db.profile.deficit = state


        for _, f in pairs(self.mtf) do
		self:UpdateHealthBar(f.bar, self:GetUnit(f))
	end

	for _, f in pairs(self.mttf) do
		self:UpdateHealthBar(f.bar, self:GetUnit(f))
	end

	for _, f in pairs(self.mtttf) do
		self:UpdateHealthBar(f.bar, self:GetUnit(f))
	end

end


function oRAOMainTank:SetNrMaintanks( nr )
	self.db.profile.nrmts = nr

	for i = ( nr + 1 ), 10 do
		if self.mtf[i] then self.mtf[i].unit = nil end
		if self.mttf[i] then self.mttf[i].unit = nil end
		if self.mtttf[i] then self.mtttf[i].unit = nil end
	end
	self:oRA_MainTankUpdate()
	
end

------------------------------
--     Utility Functions    --
------------------------------

function oRAOMainTank:SavePosition()
	local f = self.mainframe
	local s = f:GetEffectiveScale()
		
	self.db.profile.posx = f:GetLeft() * s
	self.db.profile.posy = f:GetTop() * s	
end


function oRAOMainTank:RestorePosition()
	local x = self.db.profile.posx
	local y = self.db.profile.posy
		
	if not x or not y then return end
				
	local f = self.mainframe
	local s = f:GetEffectiveScale()

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
end


function oRAOMainTank:SetupFrames()
	local f = CreateFrame("Frame", nil, UIParent)
	f:Hide()
	f:SetMovable(true)
	f:SetScript("OnUpdate", function() self:OnUpdate() end)
	f:SetWidth(100)
	f:SetHeight(100)
	f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	f:SetAlpha(self.db.profile.alpha)
	f:SetScale(self.db.profile.scale)

	f.update = 0

	self.mainframe = f
	self:RestorePosition()
end


function oRAOMainTank:CreateUnitFrame( parent, id, type )
	-- Main frame
	-- local f = CreateFrame("Button", "oRA_MainTankFrames_" .. type .. id, parent)
	local f = CreateFrame("Button", nil, parent)
	f:Hide()
	f:EnableMouse(true)
	f:SetMovable(true)
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnEnter", function() self:OnEnter() end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f:SetScript("OnClick", function() self:OnClick() end)
	f:SetScript("OnDragStart", function() if IsAltKeyDown() then parent:StartMoving() end end)
	f:SetScript("OnDragStop", function() parent:StopMovingOrSizing() self:SavePosition() end)

	-- Tank Statusbar
	f.bar = CreateFrame("StatusBar", nil, f)
	f.bar:SetMinMaxValues(0,100)

	-- Tank Statusbar background texture, visible when the bar depleats
	f.bar.texture = f.bar:CreateTexture(nil, "BORDER")
	f.bar.texture:SetVertexColor(1, 0, 0, 0.5)

	-- Tank Statusbar text
	f.bar.text = f.bar:CreateFontString(nil, "OVERLAY")
	f.bar.text:SetFontObject(GameFontHighlightSmall)
	f.bar.text:SetJustifyH("RIGHT")

	-- Tank Number
	f.number = f.bar:CreateFontString(nil, "OVERLAY")
	f.number:SetFontObject(GameFontHighlightSmall)
	f.number:SetJustifyH("RIGHT")

	-- Tank Name
	f.name = f.bar:CreateFontString(nil, "OVERLAY")
	f.name:SetFontObject(GameFontHighlightSmall)
	f.name:SetJustifyH("LEFT")

	-- Raid Icons
	f.raidicon = f.bar:CreateTexture(nil, "OVERLAY")
	f.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	f.raidicon:Hide()

	-- Set static stuff and style
	f.number:SetText(id..".")
	f.type = type
	f:SetID(id)

	self:SetStyle(f)
	self:SetPosition(f)

	return f
end


function oRAOMainTank:SetStyle(f)
	local relframe, relx, rely
	
	if f.type == "mt" then
		relframe = self.mainframe
		relx = 0
		if self.db.profile.growup then
			rely = 21 * (f:GetID() - 1)
		else 
			rely = -21 * (f:GetID() - 1)
		end
	elseif f.type == "mtt" then
		relframe = self.mtf[f:GetID()]
		relx = 120
		if self.db.profile.reverse then relx = -120 end
		rely = 0
	elseif f.type == "mttt" then
		relframe = self.mttf[f:GetID()]
		relx = 120
		if self.db.profile.reverse then relx = -120 end
		rely = 0
	end

	self:SetWHP(f, 120, 21, "TOPLEFT", relframe, "TOPLEFT", relx , rely)

	f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})

	if self.db.profile.backdrop then
		f:SetBackdropColor(0, 0, 0, .5)
	else 
		f:SetBackdropColor(0, 0, 0, 0)
	end
	
	f.bar:SetStatusBarTexture(self.core.bartextures[self.core.db.profile.bartexture])
	f.bar.texture:SetTexture(self.core.bartextures[self.core.db.profile.bartexture])
	f.bar.texture:SetVertexColor(.5, .5, .5, .5)
	
	self:SetWHP(f.bar, 112, 16, "LEFT", f, "LEFT", 4, 0)
	self:SetWHP(f.bar.texture, 112, 16, "CENTER", f.bar, "CENTER", 0, 0)
	if self.db.profile.reverse then
		f.number:SetJustifyH("LEFT")
	else
		f.number:SetJustifyH("RIGHT")
	end
	self:SetWHP(f.number, 32, 14, self.db.profile.reverse and "LEFT" or "RIGHT", f, self.db.profile.reverse and "RIGHT" or "LEFT", 0, 0)
	if f.type ~= "mt" then
		f.number:Hide()
	end

	self:SetWHP(f.raidicon, 14, 14, "LEFT", f.bar, "LEFT", 1, 0)		
	self:SetWHP(f.name, 62, 14, "LEFT", f.bar, "LEFT", 18, 0)
	self:SetWHP(f.bar.text, 32, 14, "RIGHT", f.bar, "RIGHT", 0, 0)

end


function oRAOMainTank:SetPosition( f )

end


function oRAOMainTank:SetWHP(f, width, height, p1, relative, p2, x, y)
	if not f then return end

	f:SetWidth(width)
	f:SetHeight(height)

	if p1 then
		f:ClearAllPoints()
		f:SetPoint(p1, relative, p2, x, y)
	end
end


function oRAOMainTank:GetUnit(f, click)
	if not f or not f.type then return end

	if not click then
		if f.type == "mt" then return f.unit end
		if f.type == "mtt" then return f.unit .. "target" end
		if f.type == "mttt" then return f.unit .. "targettarget" end
	else
		local c
		if f.type == "mt" then c = self.db.profile.ctmaintank end
		if f.type == "mtt" then c = self.db.profile.cttarget end
		if f.type == "mttt" then c = self.db.profile.cttargettarget end
		if c == L["Maintank"] then return f.unit end
		if c == L["Target"] then return f.unit .. "target" end
		if c == L["TargetTarget"] then return f.unit .. "targettarget" end
	end
end


function oRAOMainTank:UpdateFrames(f)
	for _, f in pairs(f) do
		if f.unit then
			local unit = self:GetUnit(f)

			if UnitExists(unit) then
				f.name:SetText(UnitName(unit))

				self:UpdateHealthBar(f.bar, unit)

				if self.db.profile.raidicon then
					self:UpdateRaidIcon(f, unit)
				end

				if f.type == "mt" and self.db.profile.coloraggro then
					if UnitExists( unit .. "target" ) then
						f.name:SetTextColor( 1, 0.5, 0.25, 1 )
						if UnitExists( unit .. "targettarget") then
							if UnitIsUnit(unit, unit .. "targettarget") then
								f.name:SetTextColor(0.5, 1, 0.5, 1)
							else
								f.name:SetTextColor(1, 0, 0, 1)
							end
						end
					else
						f.name:SetTextColor( 1, 1, 1, 1)
					end
				else 
					if UnitIsEnemy(unit, "player") then f.name:SetTextColor( 1, 0, 0, 1)
					else f.name:SetTextColor( 1, 1, 1, 1) end
				end
				
				if UnitIsUnit( unit, "target") and self.db.profile.highlight then
					f:SetBackdropColor(1, .84, 0, 1 )
				elseif self.db.profile.backdrop then
					f:SetBackdropColor(0, 0, 0, .5)
				else
					f:SetBackdropColor(0, 0, 0, 0)
				end
				
				f:Show()
			else
				f:Hide()
			end

		else
			f:Hide()
		end
	end
end


function oRAOMainTank:UpdateHealthBar(bar, unit)
	local cur, max = UnitHealth(unit) or 0, UnitHealthMax(unit) or 0
	local perc = cur / max

	bar:SetMinMaxValues(0, max)
	
	if self.db.profile.inverse then
		bar:SetValue(max - cur)
	else
		bar:SetValue(cur)
	end

	if self.db.profile.classcolor then
		if not UnitIsEnemy(unit, "player") then 
			local _, class = UnitClass( unit )
			local _, r,g,b = paintchips:GetRGBPercent( class )
			bar:SetStatusBarColor(r,g,b)
		else
			local _, r,g,b = paintchips:GetRGBPercent( self.db.profile.enemycolor )
			bar:SetStatusBarColor(r,g,b)
		end
	else
		bar:SetStatusBarColor(self:GetHealthBarColor(perc))
	end
	
	if self.db.profile.deficit then
		local val = max - cur
		if val > 1000 then
			val = ceil(val/100)/10 .. "k"
		elseif val == 0 then
			val = ""
		end
		
		bar.text:SetText(val)
	else
		bar.text:SetText(ceil(perc * 100) .. "%")
	end

	bar:Show()
end


function oRAOMainTank:GetHealthBarColor(perc)
	local r, g

	if perc > 0.5 then
		r = (1.0 - perc) * 2
		g = 1.0
	else
		r = 1.0
		g = perc * 2
	end

	return r, g, 0
end


function oRAOMainTank:UpdateRaidIcon(f, unit)
	local icon = GetRaidTargetIndex(unit)

	if icon then
		SetRaidTargetIconTexture(f.raidicon, icon)
		f.raidicon:Show()
	else
		f.raidicon:Hide()
	end
end

-------------------------------
--    Key Binding Handlers   --
-------------------------------

function oRAOMainTank:BindingAssist( nr )
	if self.mtf[nr] and self.mtf[nr].unit then
		local unit = self:GetUnit( self.mtf[nr] )
		if unit and UnitExists( unit .."target") then
			AssistUnit(unit)
		end
	end
end


-------------------------------
--   Frame Script Functions  --
-------------------------------

function oRAOMainTank:OnUpdate()
	this.update = this.update + arg1

	if this.update >= 0.5 then
		self:UpdateFrames(self.mtf)
		self:UpdateFrames(self.mttf)

		if self.db.profile.targettarget then
			self:UpdateFrames(self.mtttf)
		end

		this.update = 0
	end
end


function oRAOMainTank:OnEnter()
	local unit = self:GetUnit(this)

	GameTooltip_SetDefaultAnchor(GameTooltip, this)

	if unit and GameTooltip:SetUnit(unit) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME
	else
		this.updateTooltip = nil
	end
end


function oRAOMainTank:OnClick()
	local unit = self:GetUnit(this,true)
	if self.db.profile.clickcast and oRA_MainTankFramesCustomClick then
		oRA_MainTankFramesCustomClick(arg1, unit)
	elseif UnitExists(unit) then
		TargetUnit(unit)
	end
	-- this following piece of code is specifically for attack on assist.
--	if unit == this.unit .. "target" and UnitExists( this.unit ) then
--			AssistUnit("player")
--	end

end
