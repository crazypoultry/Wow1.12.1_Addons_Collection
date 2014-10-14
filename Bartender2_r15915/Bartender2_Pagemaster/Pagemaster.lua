--[[-------------------------------------------------------------------------
-- Bartender2_Pagemaster - Performs page swaps on bar 1 when you hold shift, ctrl, alt, etc.
--  original version by Khyax and Mikma
--  extended by PProvost to include features from Greywind's Bartender2_Druidbar
--
--  Last Modified: $Date: 2006-10-19 00:39:17 -0400 (Thu, 19 Oct 2006) $
--  Revision: $Revision: 14374 $
--
-- TODO:
--  * Add support for alternate forms like DruidCat/DruidBear/DruidMoonkin (are there enough bars? -Mikma)
--  * Add another check for AtWar flag, and in this case if match, change to hostile bar (-Mikma)
--
--  Known Bugs:
--  * N/A
--]]-------------------------------------------------------------------------

--[[ Local Constants ]]
local MAJOR_VERSION = "0.3"
local MINOR_VERSION = tonumber((string.gsub("$Revision: 14374 $", "^.-(%d+).-$", "%1")))

--[[ Utility Libraries ]]
local L = AceLibrary("AceLocale-2.2"):new("Bartender_Pagemaster")
local Babble = AceLibrary("Babble-Spell-2.2")

--[[ Initialize Addon Instance as a Bartender Module ]]
BT2Pagemaster = Bartender:NewModule("Bartender_Pagemaster")
BT2Pagemaster.version = MAJOR_VERSION .. "." .. MINOR_VERSION
BT2Pagemaster.date = string.gsub("$Date: 2006-10-19 00:39:17 -0400 (Thu, 19 Oct 2006) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")


function BT2Pagemaster:OnInitialize()
	self.db = Bartender:AcquireDBNamespace("Bartender_Pagemaster")
	Bartender:RegisterDefaults("Bartender_Pagemaster", "profile", {
		altPage = 3,
		targetFriendlyPage = 4,
		controlPage = 5,
		shiftPage = 6,
		prowlPage = 8,
		shadowformPage = 8,
	})
	Bartender.options.args.pagemaster = self:GetOptions()
	BT2Pagemaster.defaultPage = 1
end 
	
function BT2Pagemaster:OnEnable() 
	self:UnbindMetaKeys() 
	self:RegisterEvent("SpecialEvents_PlayerBuffGained") 
	self:RegisterEvent("SpecialEvents_PlayerBuffLost") 
	self:ScheduleRepeatingEvent(self.TimerCallback, 0.1, self) 
	for i,v in ipairs(AllActionButtons) do v:SetScript("OnClick", function() self:DisableShift() end) end 
end

function BT2Pagemaster:SpecialEvents_PlayerBuffGained(buffName, buffIndex) 
	if self.db.profile.prowlPage > 0 and buffName == Babble["Prowl"] then 
		self.defaultPage = self.db.profile.prowlPage 
	elseif self.db.profile.shadowformPage > 0 and buffName == Babble["Shadowform"] then
		self.defaultPage = self.db.profile.shadowformPage
	end
end

function BT2Pagemaster:SpecialEvents_PlayerBuffLost(buffName)
	if (self.db.profile.prowlPage > 0 and buffName == Babble["Prowl"]) or 
		(self.db.profile.shadowformPage > 0 and buffName == Babble["Shadowform"]) then 
		self.defaultPage = 1
	end
end

function BT2Pagemaster:DisableShift()
	if ( MacroFrame_SaveMacro ) then 
		MacroFrame_SaveMacro(); 
	end 
	UseAction(ActionButton_GetPagedID(this), 1); 
	ActionButton_UpdateState(); 
end

function BT2Pagemaster:TimerCallback()
	if ChatFrameEditBox:IsShown() then return end

	local reaction = UnitReaction("target", "player")
	local newPage = self.defaultPage

	if IsShiftKeyDown() then
		newPage = self.db.profile.shiftPage
	elseif IsAltKeyDown() then
		newPage = self.db.profile.altPage
	elseif IsControlKeyDown() then
		newPage = self.db.profile.controlPage
	elseif self.db.profile.targetFriendlyPage > 0 and reaction and reaction > 4 then
		newPage = self.db.profile.targetFriendlyPage
	end

	self:ChangePage(newPage)
end

function BT2Pagemaster:ChangePage(num)
	if num and num > 0 and CURRENT_ACTIONBAR_PAGE ~= num then
		CURRENT_ACTIONBAR_PAGE = num
		ChangeActionBarPage()
	end
end

--Loops through active buffs looking for a string match
--Origin Zorlen's hunter functions 
function BT2Pagemaster:IsUnitBuffUp(sUnitname, sBuffname) 
  local iIterator = 1
  while (UnitBuff(sUnitname, iIterator)) do
    if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then
      return true
    end
    iIterator = iIterator + 1
  end
  return false
end

function BT2Pagemaster:IsPlayerBuffUp(sBuffname)
  return self:IsUnitBuffUp("player", sBuffname) 
end

function BT2Pagemaster:UnbindMetaKeys() -- Remove the bindings from US-keyboard and EU-keyboard

-- TODO: Store them off so we can restore them when the addon unloads or if they disable one of the metakeys?
-- That might be nice. (And you are right -Mikma)

--[[ Here's some help on how to get the bindings from buttons. All actionbuttons are marked below :) have fun -Mikma

command, key1, key2 = GetBinding(174);
DEFAULT_CHAT_FRAME:AddMessage(command.." has the following keys bound:",1.0,1.0,1.0);
if (key1) then DEFAULT_CHAT_FRAME:AddMessage(key1,1.0,1.0,1.0); end
if (key2) then DEFAULT_CHAT_FRAME:AddMessage(key2,1.0,1.0,1.0); end

-- 30 - 41 = Actionbutton1-12 (MainMenuBar)
-- 42 - 53 = Selfactionbutton1-12
-- 54 - 63 = Shapeshiftbutton1-10
-- 64 - 73 = Bonusactionbutton1-10
-- 163 - 174 = Multiactionbar1button1-12 (MultiBarBottomLeft)
-- 176 - 187 = Multiactionbar2button1-12 (MultiBarBottomRight)
-- 189 - 200 = Multiactionbar3button1-12 (MultiBarRight)
-- 202 - 213 = Multiactionbar4button1-12 (MultiBarLeft)
]]--

	for i=1,9 do SetBinding("ALT-"..i) end
	SetBinding("ALT-0")
	SetBinding("ALT--")	-- US keyb (1234567890-=)
	SetBinding("ALT-=")	-- US keyb (1234567890-=)
	SetBinding("ALT-+")	-- EU keyb (1234567890+�)
	SetBinding("ALT-´")	-- EU keyb (1234567890+�)

	for i=1,9 do SetBinding("SHIFT-"..i) end
	SetBinding("SHIFT-0")
	SetBinding("SHIFT--")	-- US keyb (1234567890-=)
	SetBinding("SHIFT-=")	-- US keyb (1234567890-=)
	SetBinding("SHIFT-+")	-- EU keyb (1234567890+�)
	SetBinding("SHIFT-´")	-- EU keyb (1234567890+�)

	for i=1,9 do SetBinding("CTRL-"..i) end
	SetBinding("CTRL-0")
	SetBinding("CTRL--")	-- US keyb (1234567890-=)
	SetBinding("CTRL-=")	-- US keyb (1234567890-=)
	SetBinding("CTRL-+")	-- EU keyb (1234567890+�)
	SetBinding("CTRL-´")	-- EU keyb (1234567890+�)
end
