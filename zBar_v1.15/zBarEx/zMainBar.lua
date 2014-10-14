--[[
	zMainBar.lua
	author: Zero Fire
	make the original bars under controll of zBar
--]]
local zEnableDebug = true
local function zDebug(msg) if zEnableDebug then DEFAULT_CHAT_FRAME:AddMessage(msg) end end
-- override bar list
ZBARS = {
	"zBar1","zBar2","zBar3","zBar4",
	"MultiBarLeft","MultiBarRight",
	"MultiBarBottomRight","MultiBarBottomLeft",
	"zBar9","zMainBar",
	"zPetBar","zBagBar","zMicroBar","zShapeshiftBar","zXPBar",
}
local tmp
--[[
	Frame for initial
--]]
local EventFrame = CreateFrame("Frame")
local function OnEvent()
	-- temporary options, should delete after Option Frame finished
	for i=5,6 do
		if not zBar.Bars[i] then
			zBar.Bars[i] = {num = 12, inset = 0, arrangement = "line", linenum = 1}
		end
	end
	for i=7,8 do
		if not zBar.Bars[i] then
			zBar.Bars[i] = {num = 12, inset = 0, arrangement = "line", linenum = 12, hideTab=true}
		end
	end
	if not zBar.Bars[10] then
		zBar.Bars[10] = {num = 12, inset = 0, arrangement = "line", linenum = 12, hideTab=true}
	end
	if not zBar.Bars[11] then
		zBar.Bars[11] = {num = 10, inset = 6, arrangement = "line", linenum = 10, max = 10, scale=0.8}
	end
	zBar.Bars[11].hide = nil
	if not zBar.Bars[12] then
		zBar.Bars[12] = {num=6, inset = 0, arrangement = "line", linenum=6, max=6, scale=0.8}
	end
	if not zBar.Bars[13] then
		zBar.Bars[13] = {num=8, inset = -2, arrangement = "line", linenum=8, max=8, scale=0.8}
	end
	if not zBar.Bars[14] then
		zBar.Bars[14] = {num=10, inset = 10, arrangement = "line", linenum = 10, max = 10, scale = 0.8}
	end
	zBar.Bars[14].hide = nil
	if not zBar.Bars[15] then
		zBar.Bars[15] = {hide = nil}
	end
	
	--[[ main bar ]]--
	tmp = CreateFrame("Frame", "zMainBar", zBarFrame)
	tmp:SetID(10)
	tmp:SetWidth(36)
	tmp:SetHeight(36)
	tmp:SetMovable(true)
	--tmp:EnableMouse(true)
	--tmp:SetToplevel(true)
	tmp:SetFrameStrata("LOW")
	tmp:SetClampedToScreen(true)
	tmp:SetPoint("BOTTOM", "UIParent", "BOTTOM", -120, 30)
	tmp:RegisterEvent("PLAYER_REGEN_ENABLED")
	tmp:RegisterEvent("PLAYER_REGEN_DISABLED")
	tmp:RegisterEvent("PLAYER_TARGET_CHANGED")
	tmp:RegisterEvent("PLAYER_LEAVING_WORLD")
	tmp:SetScript("OnEvent", zBar_OnEvent)
	-- create tab
	CreateFrame("Button","zMainBarTab",zMainBar,"zBarTabTemplate")
	for i=1, NUM_ACTIONBAR_BUTTONS do
		tmp = getglobal("ActionButton"..i)
		tmp:SetParent(zMainBar)
		setglobal("zMainBarButton"..i, tmp)
	end
	-- new position
	ActionButton1:ClearAllPoints()
	ActionButton1:SetPoint("TOP",zMainBar,"TOP",0,0)
    
    --[[ BonusActionButtons ]]--
	setglobal("BonusAction", BonusActionBarFrame)
	tmp = BonusAction
	tmp:SetParent(zMainBar)
	tmp:SetID(10)
	tmp:SetWidth(36)
	tmp:SetHeight(36)
	tmp:SetMovable(nil)
	--tmp:EnableMouse(nil)
	--tmp:SetToplevel(true)
	tmp:SetFrameStrata("LOW")
	tmp:SetClampedToScreen(true)
	tmp:SetPoint("TOP", zMainBar, "TOP", 0, 0)
	-- tab
	setglobal("BonusActionTab", zMainBarTab)
	setglobal("BonusActionBarFrameTab", zMainBarTab)
	-- button
	BonusActionButton1:ClearAllPoints()
	BonusActionButton1:SetPoint("TOP",BonusAction,"TOP",0,0)
	for i=1, NUM_ACTIONBAR_BUTTONS do
		tmp = getglobal("BonusActionButton"..i)
		tmp:SetScript("OnEnter",zActionButton_OnEnter)
		tmp:SetScript("OnLeave",zActionButton_OnLeave)
		tmp:SetScript("OnEvent",zActionButton_OnEvent)
		tmp:SetScript("OnShow",ActionButton_Update)
	end

	-- override
	BonusActionBarFrame.SetScale = function(bar, scale) zMainBar:SetScale(scale) end
	BonusActionBarFrame.GetScale = function() return zMainBar:GetScale() end

	BonusActionBarTexture0:SetParent(MainMenuBar)
	BonusActionBarTexture1:SetParent(MainMenuBar)
	
	--[[ multi bars ]]--
	-- new position
	MultiBarBottomLeft:ClearAllPoints()
	MultiBarBottomLeft:SetPoint("BOTTOM", "UIParent", "BOTTOM", -120, 66)
	MultiBarBottomRight:ClearAllPoints()
	MultiBarBottomRight:SetPoint("BOTTOM", "UIParent", "BOTTOM", -120, 102)
	MultiBarRight:ClearAllPoints()
	MultiBarRight:SetPoint("TOPRIGHT","UIParent","TOPRIGHT", -7, -200)
    
	for i=5,8 do
		tmp = getglobal(ZBARS[i])
		tmp:SetID(i)
		--tmp:EnableMouse(true)
		--tmp:SetToplevel(true)
		tmp:SetWidth(36)
		tmp:SetHeight(36)
		tmp:SetMovable(true)
		tmp:SetFrameStrata("LOW")
		tmp:SetClampedToScreen(true)
		tmp:RegisterEvent("PLAYER_REGEN_ENABLED")
		tmp:RegisterEvent("PLAYER_REGEN_DISABLED")
		tmp:RegisterEvent("PLAYER_TARGET_CHANGED")
		tmp:RegisterEvent("PLAYER_LEAVING_WORLD")
		tmp:SetScript("OnEvent", zBar_OnEvent)
		-- override (to prevent other addon - like moveAnything - refresh position)
		tmp.ClearAllPoints = function() return end
		tmp.SetPoint = function() return end
		-- Tab Creation
		CreateFrame("Button", ZBARS[i].."Tab", tmp, "zBarTabTemplate")
	end
	
	--[[ pet bar ]]--
	PetActionBarFrame:SetParent(zBarFrame)
	PetActionBarFrame:SetWidth(0)
	PetActionBarFrame:SetHeight(0)
	tmp = CreateFrame("Frame", "zPetBar", PetActionBarFrame)
	tmp:SetID(11)
	tmp:SetWidth(30)
	tmp:SetHeight(30)
	tmp:SetMovable(true)
	--tmp:EnableMouse(true)
	--tmp:SetToplevel(true)
	tmp:SetFrameStrata("LOW")
	tmp:SetClampedToScreen(true)
	tmp:SetPoint("BOTTOM", "UIParent", "BOTTOM", -120, 185)
	-- tab
	tmp = CreateFrame("Button","zPetBarTab",zPetBar,"zBarTabTemplate")
	tmp:SetScale(0.9)
	-- buttons
	for i=1,NUM_PET_ACTION_SLOTS do
		tmp = getglobal("PetActionButton"..i)
		tmp:SetParent(zPetBar)
		setglobal("zPetBarButton"..i, tmp)
		tmp = getglobal("PetActionButton"..i.."NormalTexture2")
		tmp:SetWidth(52)
		tmp:SetHeight(52)
	end
	-- reset button1 position
	zPetBarButton1:ClearAllPoints()
	zPetBarButton1:SetPoint("TOP",zPetBar,"TOP",0,0)
	-- hide texture
	SlidingActionBarTexture0:SetAlpha(0)
	SlidingActionBarTexture1:SetAlpha(0)

	
	--[[ bag bar ]]--
	tmp = CreateFrame("Frame","zBagBar",zBarFrame)
	tmp:SetID(12)
	tmp:SetWidth(37)
	tmp:SetHeight(37)
	tmp:SetMovable(true)
	--tmp:EnableMouse(true)
	--tmp:SetToplevel(true)
	tmp:SetFrameStrata("LOW")
	tmp:SetClampedToScreen(true)
	tmp:SetPoint("BOTTOMLEFT",CharacterMicroButton,"TOPLEFT",0,-18)
	-- Tab Creation
	CreateFrame("Button", "zBagBarTab", tmp, "zBarTabTemplate")
	zBagBarTab:SetScale(1.1)
    -- buttons
--[[
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("CENTER",tmp,"CENTER")
	]]
	MainMenuBarBackpackButton:SetParent(tmp)
	setglobal("zBagBarButton5", MainMenuBarBackpackButton)
	for i=3,0,-1 do
		getglobal("CharacterBag"..i.."Slot"):SetParent(tmp)
		setglobal("zBagBarButton"..i+1, getglobal("CharacterBag"..i.."Slot"))
	end
	CharacterBag0Slot:ClearAllPoints()
	CharacterBag0Slot:SetPoint("CENTER", tmp, "CENTER")
    -- keyring and performance bar
	tmp = CreateFrame("Frame","zBagBarButton6",zBagBar)
	tmp:SetWidth(37)
	tmp:SetHeight(37)
	KeyRingButton:SetParent(zBagBarButton6)
	KeyRingButton:ClearAllPoints()
	KeyRingButton:SetPoint("TOPLEFT",zBagBarButton6,"TOPLEFT",4,1)
	function MainMenuBar_UpdateKeyRing()
		if ( SHOW_KEYRING == 1 ) then
			KeyRingButton:Show();
		end
	end
	MainMenuBarPerformanceBarFrame:SetParent(zBagBarButton6)
	MainMenuBarPerformanceBarFrame:ClearAllPoints()
	MainMenuBarPerformanceBarFrame:SetPoint("LEFT",KeyRingButton,"RIGHT",2,2)
    
	--[[ micro bar ]]--
	tmp = CreateFrame("Frame","zMicroBar",zBarFrame)
	tmp:SetID(13)
	tmp:SetWidth(29)
	tmp:SetHeight(36)
	tmp:SetMovable(true)
	--tmp:EnableMouse(true)
	--tmp:SetToplevel(true)
	tmp:SetFrameStrata("LOW")
	tmp:SetClampedToScreen(true)
	tmp:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMRIGHT",-220,40)
	-- Tab Creation
	CreateFrame("Button", "zMicroBarTab", tmp, "zBarTabTemplate")
	-- arrangement
	CharacterMicroButton:SetParent(tmp)
	CharacterMicroButton:ClearAllPoints()
	CharacterMicroButton:SetPoint("BOTTOM",tmp,"BOTTOM",0,0)
	SpellbookMicroButton:SetParent(tmp)
	TalentMicroButton:SetParent(tmp)
	QuestLogMicroButton:SetParent(tmp)
	SocialsMicroButton:SetParent(tmp)
	WorldMapMicroButton:SetParent(tmp)
	MainMenuMicroButton:SetParent(tmp)
	HelpMicroButton:SetParent(tmp)
	setglobal("zMicroBarButton1", CharacterMicroButton)
	setglobal("zMicroBarButton2", SpellbookMicroButton)
	setglobal("zMicroBarButton3", TalentMicroButton)
	setglobal("zMicroBarButton4", QuestLogMicroButton)
	setglobal("zMicroBarButton5", SocialsMicroButton)
	setglobal("zMicroBarButton6", WorldMapMicroButton)
	setglobal("zMicroBarButton7", MainMenuMicroButton)
	setglobal("zMicroBarButton8", HelpMicroButton)
	
	--[[ ShapeshiftBar ]]--
	ShapeshiftBarFrame:SetParent(zBarFrame)
	ShapeshiftBarFrame:SetWidth(0)
	ShapeshiftBarFrame:SetHeight(0)
	tmp = CreateFrame("Frame", "zShapeshiftBar", ShapeshiftBarFrame)
	tmp:SetID(14)
	tmp:SetWidth(29)
	tmp:SetHeight(32)
	tmp:SetMovable(true)
	--tmp:EnableMouse(true)
	--tmp:SetToplevel(true)
	tmp:SetFrameStrata("LOW")
	tmp:SetClampedToScreen(true)
	tmp:ClearAllPoints()
	tmp:SetPoint("BOTTOM", "UIParent", "BOTTOM", -120, 185)
	-- Tab Creation
	tmp = CreateFrame("Button", "zShapeshiftBarTab", tmp, "zBarTabTemplate")
	tmp:SetScale(0.85)
	-- arrangement
	for i=1, NUM_SHAPESHIFT_SLOTS do
		tmp = getglobal("ShapeshiftButton"..i)
		tmp:SetParent(zShapeshiftBar)
		setglobal("zShapeshiftBarButton"..i, tmp)
        
		tmp = getglobal("ShapeshiftButton"..i.."NormalTexture")
		tmp:SetWidth(50)
		tmp:SetHeight(50)
	end
	-- reset button1 position
	ShapeshiftButton1:ClearAllPoints()
	ShapeshiftButton1:SetPoint("TOP",zShapeshiftBar,"TOP",0,0)
	-- hide texture
	ShapeshiftBarLeft:SetParent(MainMenuBar)
	ShapeshiftBarRight:SetParent(MainMenuBar)
	ShapeshiftBarMiddle:SetParent(MainMenuBar)
    
	-- XP bar
	setglobal("zXPBar", MainMenuExpBar)
	MainMenuExpBar:SetID(15)
	MainMenuExpBar:SetParent(UIParent)
	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetPoint("BOTTOM",UIParent,"BOTTOM",0,0)
    
	-- Reputation bar
	ReputationWatchBar:SetParent(UIParent)
	ReputationWatchBar:ClearAllPoints()
	ReputationWatchBar:SetPoint("BOTTOM",MainMenuExpBar,"BOTTOM",0,0)
	
	-- hide MainMenuBar
	MainMenuBar:Hide()
	MainMenuBarArtFrame:Hide()
	
	-- job done, destroy it
	EventFrame:SetScript("OnEvent", nil)
	EventFrame:UnregisterAllEvents()
	EventFrame = nil
	OnEvent = nil
	tmp = nil
end

EventFrame:SetScript("OnEvent", OnEvent)
EventFrame:RegisterEvent("VARIABLES_LOADED")
--[[
    General Override
--]]
--UIPARENT_MANAGED_FRAME_POSITIONS["MultiBarBottomLeft"] = nil
--UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil

MultiActionBar_Update = function() VIEWABLE_ACTION_BAR_PAGES = {1,1} end

local zOld_ChangeActionBarPage = ChangeActionBarPage
function ChangeActionBarPage()
	zOld_ChangeActionBarPage()
	zBar_UpdateButtons(zMainBar)
end

--[[
    Override for BonusActionButtons
--]]
BONUSACTIONBAR_YPOS = 36;
BONUSACTIONBAR_XPOS = 0;

local zOld_ShowBonusActionBar = ShowBonusActionBar
local zOld_HideBonusActionBar = HideBonusActionBar
function ShowBonusActionBar()
	zOld_ShowBonusActionBar()
	ZBARS[10] = "BonusAction"
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		getglobal("ActionButton"..i):SetAlpha(0)
	end
	zBar_UpdateHotkeys(BonusAction)
	zBar_UpdateButtons(BonusAction)
	zBar_UpdateArrangement(BonusAction)
	zBar_SetAlpha(0.3, BonusAction)
	
	zBar_UpdateButtons(zMainBar)
	zBar_UpdateArrangement(zMainBar)
end
function HideBonusActionBar()
	zOld_HideBonusActionBar()
	ZBARS[10] = "zMainBar"
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		getglobal("BonusActionButton"..i):Hide()
		getglobal("ActionButton"..i):SetAlpha(1)
	end
	zBar_UpdateHotkeys(zMainBar)
	zBar_UpdateButtons(zMainBar)
	zBar_UpdateArrangement(zMainBar)
	zBar_SetAlpha(0.3, zMainBar)
	
	zBar_UpdateButtons(BonusAction)
	zBar_UpdateArrangement(BonusAction)
end
--[[
    Override when ReputationWatchBar Updates
--]]
MainMenuExpBar:SetScript("OnShow", function()
	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetPoint("BOTTOM",UIParent,"BOTTOM",0,0)
end)
MainMenuExpBar:SetScript("OnHide", function()
	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetPoint("TOP",UIParent,"BOTTOM",0,0)
end)

local zOld_ReputationWatchBar_Update = ReputationWatchBar_Update
function ReputationWatchBar_Update(newLevel)
	zOld_ReputationWatchBar_Update(newLevel)
	-- reset reputation bar on top of the XP bar
	ReputationWatchBar:ClearAllPoints()
	ReputationWatchBar:SetPoint("BOTTOM",MainMenuExpBar,"TOP",0,0)
	-- reset XP bar position, if hidden, move it below the bottom of the Screen
	-- otherwise, reset it above the bottom of the Screen.
	if zBar.Bars[15].hide then
		zXPBar:Hide()
	end
end