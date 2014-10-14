------------------------------
-- From A View To A Kill Fu --
------------------------------

----------------
-- Main Setup --
----------------

FuBar_FromAViewToAKillFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0")
FuBar_FromAViewToAKillFu.hasIcon = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\icon.tga"

local L = AceLibrary("AceLocale-2.1"):GetInstance("FuBar_FromAViewToAKillFu", true)
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")


--------------
-- Database --
--------------

FuBar_FromAViewToAKillFu:RegisterDB("FuBar_FromAViewToAKillFuDB", "FuBar_FromAViewToAKillFuDBPC")
FuBar_FromAViewToAKillFu:RegisterDefaults("profile", {
	UpdateRate		= 0.25,		-- update rate for the changing RTIs, don't change
	AllowSwitching	= true,		-- currently unused
} )

------------
-- Locals --
------------

local RTI = {}		-- this table will carry the RTI's number and the assigned raidmember
local ICON = {}		-- this table will carry the raidtargeticon textures

for i = 1, 8 do
	local temp = nil
	if i == 1 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\01_star.tga"
	elseif i == 2 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\02_circle.tga"
	elseif i == 3 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\03_diamond.tga"
	elseif i == 4 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\04_triangle.tga"
	elseif i == 5 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\05_moon.tga"
	elseif i == 6 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\06_square.tga"
	elseif i == 7 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\07_cross.tga"
	elseif i == 8 then temp = "Interface\\AddOns\\FuBar_FromAViewToAKillFu\\Textures\\08_skull.tga"
	else temp = nil
	end
		
	ICON[i] = temp	-- filling the table with texture paths. it's done this way, because now you can get them via ICON[i]
	temp = nil	
end


---------------------------------------
-- Functions regarding the RTI table --
---------------------------------------

function FuBar_FromAViewToAKillFu:RTISet(number)
	if UnitName("target") == nil then return end
	RTI[number] = {}											-- creating a new row in the RTI table for this specific player - IMPORTANT -
	RTI[number].name	= UnitName("target")					-- can only insert stuff into a row that was created
	RTI[number].raidid	= FuBar_FromAViewToAKillFu:GetRaidUnitByName(RTI[number].name)
	RTI[number].draw	= true
	if RTI[number].raidid == nil then
		self:Print (L["unit"].."|cffCC2222<"..RTI[number].name..">|cffFFFFFF"..L["hasnoRaidID"])
		RTI[number] = nil
		return
	end
	self:ScheduleRepeatingEvent("icon"..number, self.MarkTarget, self.db.profile.UpdateRate, self, number)
end

function FuBar_FromAViewToAKillFu:RTIRemove(number)
	self:CancelScheduledEvent("icon"..number)
	SetRaidTarget(RTI[number].raidid.."target",0);
	RTI[number]			= nil
end

function FuBar_FromAViewToAKillFu:RTIsAreSet()
	for i = 1, 8 do
		if RTI[i] ~= nil then
			return true;
		end
	end
	return false;
end

function FuBar_FromAViewToAKillFu:GetRaidUnitByName(name)
	for i = 1, GetNumRaidMembers() do
		local unit = "raid"..i
		if (UnitName(unit) == name) then
			return unit
		end
	end
	return nil
end

function FuBar_FromAViewToAKillFu:GetUnitColor(unitname)
	local unitnumber = FuBar_FromAViewToAKillFu:GetRaidUnitByName(unitname);
	local classcolor = "000000";	-- setting color to black to see if something goes wrong
	
	if unitnumber == nil then		-- setting the classcolor to dark red for 'out-of-raid-units'
		classcolor = "CC2222"		-- this is just for checking, the plugin won't work with OOR units due to them not having a raidindex
		return classcolor
	end
	
	local _ ,class = UnitClass(unitnumber)

--~ classcolors as defined by oRA_MainTankFrames
	if class == "PALADIN" then classcolor = "F48CBA"
	elseif class == "WARRIOR" then classcolor = "C69B6D"
	elseif class == "WARLOCK" then classcolor = "9382C9"
	elseif class == "PRIEST" then classcolor = "FFFFFF"
	elseif class == "DRUID" then classcolor = "FF7C0A"
	elseif class == "MAGE" then classcolor = "68CCEF"
	elseif class == "ROGUE" then classcolor = "FFF468"
	elseif class == "SHAMAN" then classcolor = "F48CBA"
	elseif class == "HUNTER" then classcolor = "AAD372"
	else classcolor = "000000"		-- in case of no proper class: setting color to black to see if something goes wrong
	end
	return classcolor;
end


---------------------------------------------------
-- Functions regarding raidtargeticon management --
---------------------------------------------------

function FuBar_FromAViewToAKillFu:MarkTarget(number)
	local id		= RTI[number].raidid
	local name		= RTI[number].name
	local target	= UnitName(id.."target")

	if (target) == nil then
		if RTI[number].draw then
			SetRaidTarget(id,number);
			SetRaidTarget(id,0);
			RTI[number].draw = false
		end
	else
		RTI[number].draw = true
		if not (GetRaidTargetIndex(id.."target") == number) then
			SetRaidTarget(id.."target",number);
		end


	end
	if number == GetRaidTargetIndex(id) then
		if not (name == target) then
			SetRaidTarget(id,0);
		end
	end
end


-------------
-- Tooltip --
-------------

function FuBar_FromAViewToAKillFu:OnTooltipUpdate()		-- the tooltip is dynamic depending on the player's status (not raid / raid / raid leader)
	local cat = tablet:AddCategory()
	
	if not UnitInRaid("player") then
		cat:AddLine()
		cat:AddLine(
			'text', "|cffff0000"..L["younotinraid"]
		)
		cat:AddLine(
			'text', "|cffff0000"..L["funcdisabled"]
		)
		
	else
		if not IsRaidLeader() then
			cat:AddLine(
				'text', "|cffff0000"..L["younotleader"]
			)
			cat:AddLine(
				'text', "|cffff0000"..L["funcdisabled"]
			)
		else
			cat:AddLine(
				'text', "|cff00ff00"..L["youleader"]
			)
			cat:AddLine(
				'text', "|cff00ff00"..L["funcenabled"]
			)
			cat:AddLine()
			cat:AddLine(
				'text', "|cffffffff"..L["RMBclick"].."|cff00ff00"..L["access"]
			)
			if self.RTIsAreSet() then
				cat:AddLine(
					'text', "|cffffffff"..L["CtrlLMBclick"].."|cff00ff00"..L["clear"]
				)
			else
				cat:AddLine(
					'text', "|cff777777"..L["CtrlLMBclick"].."|cff555555"..L["clear"]
				)
			end
		end
	end
end

function FuBar_FromAViewToAKillFu:OnClick()
	local cleared = 0
	if IsControlKeyDown() then
		if self.RTIsAreSet() then
			for i = 1, 8 do
				if RTI[i] ~= nil then
					self.RTIRemove(self, i)
					cleared = 1
				end
			end
		else
			self:Print(L["noRTIsset"]);
		end
	end
	if cleared == 1 then
		self:Print(L["listcleared"])
	end
end


----------
-- Menu --
----------

function FuBar_FromAViewToAKillFu:OnMenuRequest()
	if not UnitInRaid("player")
		then
			dewdrop:AddLine(
				'text', "|cffff0000"..L["younotinraid"],
				'notClickable', true
			)
			dewdrop:AddLine(
				'text', "|cffff0000"..L["funcdisabled"],
				'notClickable', true
			)
	else
		for i=1, 8 do		-- filling the dropdown list with names/unassigned
			local RTInumber = i
			if RTI[i] == nil then
				dewdrop:AddLine(
					'text', "|c00666666"..L["unassigned"],
					'checked', true,
					'checkIcon', ICON[i],
					'func', self.RTISet,
					'arg1', self,
					'arg2', RTInumber
				)
			else
				color = FuBar_FromAViewToAKillFu:GetUnitColor(RTI[RTInumber].name)
				dewdrop:AddLine(
					'text', "|cff"..color..RTI[i].name,
					'checked', true,
					'checkIcon', ICON[i],
					'func', self.RTIRemove,
					'arg1', self,
					'arg2', RTInumber
				)
			end
		end
	end
	dewdrop:AddLine('text', " ", 'notClickable', true)
end