local estimates, wd_unitinfo= {}, {}
wd_spells, wd_cures = {},{}
local wd_textformat = {}
local cure_lookup = {
	[WATCHDOG.CURE_DISEASE_1]   = { WATCHDOG.AILMENT_DISEASE },
	[WATCHDOG.CURE_DISEASE_2]   = { WATCHDOG.AILMENT_DISEASE },
	[WATCHDOG.CURE_PURIFY_1]    = { WATCHDOG.AILMENT_DISEASE, WATCHDOG.AILMENT_POISON },
	[WATCHDOG.CURE_CLEANSE_1]   = { WATCHDOG.AILMENT_DISEASE, WATCHDOG.AILMENT_POISON, WATCHDOG.AILMENT_MAGIC },
	[WATCHDOG.CURE_MAGIC_1]    = { WATCHDOG.AILMENT_MAGIC },
	[WATCHDOG.CURE_POISON_1]   = { WATCHDOG.AILMENT_POISON },
	[WATCHDOG.CURE_POISON_2]   = { WATCHDOG.AILMENT_POISON },
	[WATCHDOG.CURE_CURSE_1]      = { WATCHDOG.AILMENT_CURSE },
	[WATCHDOG.CURE_CURSE_2]      = { WATCHDOG.AILMENT_CURSE },
}
 
wd_visible = {player=true,party1=true,party2=true,party3=true,party4=true,target=true,pet=true,partypet1=true,partypet2=true,partypet3=true,partypet4=true,targettarget=true};
local precision_count, recent_damage, total_damage = 0,0,0,0,0
local start_percent, last_percent = 100,100
local CurrentClass = ""
local wd_curhp,wd_maxhp = 0,0;
local wd_tset,wd_tins = table.setn, table.insert;
local toftcount,frames = nil,nil;

-- Use AceHooks for blizz and xraid hooks
WDHooks = {}
AceHookLib:Embed(WDHooks, "1.3")

local StickyFrames = StickyFramesLib:GetInstance("1.0")

------- WatchDog_xxx Functions -----------
--
-- 	OnLoad       : Registers Events, initialize some shortcut variables to avoid global lookups
--
--  OnEvent      : Handles traffic direction for the events, events are ordered in the if/else tree
--                 based on the frequency which they get called.
--
--  UpdateFrame  : Ensures the entire frame is up-to-date in terms of what should be shown and
--                 what should not.  target/player/party frames, borders/backdrops, etc.  
--                 This function is not called very often.
--
--  AnchorAll    : Anchors all the frames relative to the WatchDogFrame so they can be moved
--								 as one group
--
--  UnitInformation : Table of functions for unit gathering information
--
--  GetHex       : passed either a table {r,g,b} or 3 individual r,g,b values from 0 - 1.0 and converts them
--                 to a |cFFRRGGBB string for textual coloring
--
--  UpdateUnit   : Updates the text / coloring for a unit.  Gets all of the information for the unit
--                 that was called and outputs it according to user formatting. hp, mana, level, etc.
--
--  UpdateAura   : Updates buffs / debuffs for unit which this was called on.
--
--  OnClick      : Handles the click-casting for when clicking on the player/target/party frames
--
--  CastSpell    : passed (name,id).  One or the other sent, either name of spell or CastSpell id of spell
--                 handles both player spells and pet spells
--
--  UpdateSpells : Parses through player spellbook and stores ids/names of spells into wd_spells
--                 so click-casting will function quickly & easily.  Called only when entering world
--                 or when the player's spellbook changes.
--
--  UpdatePetSpells: Does similiar functionality to UpdateSpells except for your pet.
--
--  TargetChanged: When the player's target changes this is called.  Adjusts font-coloring based on
--                 attackability of target, and resets TargetHP information if  enabled.
--
--  EstimateHP   : Called on hostile targets to estimate their actual HP.  Number of times this is called
--                 is based on user setting. WatchDog.precision = 8 will usually get the HP within +/- 2% accuracy.
--                 Relatively has some overhead, so lower precision = better performance. (atleast on slower machines)
--
--  GetMPSeverity  : Gets RGB based on unit MP type
--
--  GetHPSeverity  : Gets a smooth coloring RGB based on unit HP percentage.  100=green, 0=red.  Smooth transition in between.
--
--  SetBorders   : Sets the visibility of the button borders. true/false is passed to this.
--
--  AnchorButton : After moving individual frames, sets their anchor-point relative to the WatchDogFrame parent
--                 so after reentering lock-mode, all frames can be moved as one piece, regardless of their position.
--
--  CheckSavedVariables: Ensures that the WatchDog variable table has all the proper variables, either from SavedVariables.lua
--                       or from default values if they don't exist.
--
--  UpdateVisibility: Populates the wd_visible helper table wd_visible["unit"] returns if that unit is visible or not.  I use this
--                    in addition to WatchDog main table, because this has some values that would just take extra space in SavedVariables.lua
--                    also handles showing/hiding of default UI elements
--
--  Hide         :  Hides WatchDog, simply.
--
--  Show         :  Shows WatchDog, updates everything too.
--
--  GetValues    :  Gets the unit info from the WatchDog_UnitInformation table of functions
--
--	SetTextFormats : Sets the local tables to have the unitframe formatting correctly
--
--	ToFormat:  Converts a human readable text-formatting into the setup necessary for string.format
--
--------------------------------------------

function WatchDog_OnLoad()	
	WatchDog_CheckSavedVariables();	
	
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_RAGE");		
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_HAPPINESS");	
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("PLAYER_UPDATE_RESTING");
	
	for k,v in wd_visible do
		getglobal("WatchDogFrame_"..k).unit = k
		getglobal("WatchDogFrame_"..k).text1left = getglobal("WatchDogFrame_"..k.."_Text1Left")
		getglobal("WatchDogFrame_"..k).text1center = getglobal("WatchDogFrame_"..k.."_Text1Center")
		getglobal("WatchDogFrame_"..k).text1right = getglobal("WatchDogFrame_"..k.."_Text1Right")
		getglobal("WatchDogFrame_"..k).StatusBar1 = getglobal("WatchDogFrame_"..k.."_StatusBar1")
		getglobal("WatchDogFrame_"..k).text2left = getglobal("WatchDogFrame_"..k.."_Text2Left")
		getglobal("WatchDogFrame_"..k).text2center = getglobal("WatchDogFrame_"..k.."_Text2Center")
		getglobal("WatchDogFrame_"..k).text2right = getglobal("WatchDogFrame_"..k.."_Text2Right")
		getglobal("WatchDogFrame_"..k).StatusBar2 = getglobal("WatchDogFrame_"..k.."_StatusBar2")
		getglobal("WatchDogFrame_"..k).unitformat = (string.find(k,"pet")) and "pet" 
															                or (string.find(k,"party")) and "party" 
															                or (string.find(k,"target")) and "target" 
															                or k

		frames = {WatchDogFrame_player, WatchDogFrame_pet, WatchDogFrame_target, WatchDogFrame_party1, WatchDogFrame_party2, WatchDogFrame_party3, WatchDogFrame_party4, WatchDogFrame_partypet1, WatchDogFrame_partypet2, WatchDogFrame_partypet3, WatchDogFrame_partypet4, WatchDogFrame_targettarget}
																			
		local f = getglobal("WatchDogFrame_"..k)
		local start = function()
			if WatchDog.locked then return end
			if IsAltKeyDown() then
				StickyFrames:StartMoving(f, frames, 3, 3, 3, 3)
				--StickyFrames:StartMoving(f, frames, 0, 0, 0, 0)
				f.isMoving = true
				wd_moving = f
			else
				WatchDogFrame:StartMoving()
				WatchDogFrame.isMoving = true
				wd_moving = WatchDogFrame
			end
		end
		
		local stop = function()
			if WatchDog.locked then return end
			if WatchDogFrame.isMoving then 
				WatchDogFrame:StopMovingOrSizing()
				WatchDogFrame.isMoving = false
				wd_moving = nil
			else
				StickyFrames:StopMoving(f)
				f.isMoving = false
				StickyFrames:AnchorFrame(f)
				wd_moving = nil
			end
			WatchDog_SaveFramePositions()
		end
		
		f:SetScript("OnDragStart", start)
		f:SetScript("OnDragStop", stop)
		
	end	
		
	_, CurrentClass = UnitClass("player");
	
	WatchDog_UpdateFrame();
	WatchDog_UpdateSpells();		
	if WatchDog_ShowHideDefaults then WatchDog_ShowHideDefaults() end;
end

function WatchDog_OnEvent(event)

	if (not WatchDog.visible and not event=="VARIABLES_LOADED") then return; end;	
	
	if (event=="UNIT_HEALTH" or 
	    event=="UNIT_MANA" or 
	    event=="UNIT_NAME_UPDATE" or
	    event=="UNIT_RAGE" or
	    event=="UNIT_ENERGY" or 
		event=="UNIT_PVP_UPDATE") then
		if (wd_visible[arg1]) then
			WatchDog_UpdateUnit(arg1);
		end	

	elseif (event=="UNIT_AURA") then
		if (wd_visible[arg1]) then
			WatchDog_UpdateAura(arg1);
		end
		
	elseif (event=="UNIT_COMBAT") then
		if (arg1=="target") then
			recent_damage = recent_damage + arg4;
			total_damage = total_damage + arg4;							
		end			

	elseif (event=="PLAYER_TARGET_CHANGED") then		
		if (wd_visible.target and UnitExists("target")) then
			WatchDogFrame_target:Show();
			WatchDog_TargetChanged();
			PlaySound("igCharacterNPCSelect")
			toftcount=1		
		else			
			WatchDogFrame_target:Hide();
			PlaySound("INTERFACESOUND_LOSTTARGETUNIT");
			toftcount=0			
		end		
		
		if  wd_moving then	
			wd_moving:StopMovingOrSizing()
			wd_moving.isMoving=false
			wd_moving = nil
		end
			
	elseif (event=="PLAYER_REGEN_DISABLED" or event=="PLAYER_ENTER_COMBAT") then
		WatchDog_UpdateUnit("player")
	
	elseif (event=="PLAYER_LEAVE_COMBAT" or event=="PLAYER_REGEN_ENABLED") then
		WatchDog_UpdateUnit("player")
	
	elseif (event=="PLAYER_UPDATE_RESTING") then
		WatchDog_UpdateUnit("player")			
		
	elseif (event=="PLAYER_COMBO_POINTS") then		
		WatchDog_UpdateUnit("player")			
		
	elseif (event=="UNIT_PET") then
		local xunit,_,unit,id = string.find(arg1,"(%a+)(%d*)")
		
		if (unit=="partypet" or unit=="raidpet") then	xunit = arg1
		elseif ( strlen(id)>0 ) then xunit = unit.."pet"..id
		elseif ( unit=="player" ) then xunit = "pet"
		else xunit = ""	end
		
		if getglobal("WatchDogFrame_"..xunit) then
			if UnitExists(xunit) and wd_visible[xunit] then 
				getglobal("WatchDogFrame_"..xunit):Show()
				WatchDog_UpdateUnit(xunit)
				WatchDog_UpdateAura(xunit)
			else getglobal("WatchDogFrame_"..xunit):Hide() end	
			if HasPetSpells() then WatchDog_UpdatePetSpells() end
		end		
		
	elseif (event=="PARTY_MEMBERS_CHANGED") then
		if (WatchDog.party.visible) then		
			WatchDog_UpdateFrame();			
		end
	
	elseif (event=="PLAYER_ENTERING_WORLD") then
		WatchDog_UpdateFrame();
		WatchDog_UpdateSpells();		
		WatchDogFrame:SetScale(WatchDog.scale);
		WatchDog_AnchorAll();
		WatchDog_RestoreFramePositions()					
		WatchDog_ShowHideDefaults();
	
	elseif (event=="LEARNED_SPELL_IN_TAB") then
		WatchDog_UpdateSpells();		
	
			
	elseif (event=="UNIT_HAPPINESS") then
		if (arg1=="pet") then WatchDog_UpdateUnit("pet") end;		
	
	elseif (event=="VARIABLES_LOADED") then
		WatchDog_CheckSavedVariables();
		if WatchDog.visible then 
			WatchDog_Show();
		else WatchDog_Hide(); end														
	end	
end

function WatchDog_SaveFramePositions()	
	local f = WatchDogFrame
	local x,y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
	
	x,y = x*s,y*s

	if not WatchDog.pos then WatchDog.pos = {} end
	WatchDog.pos["master"] = {}
	WatchDog.pos["master"].x = x
	WatchDog.pos["master"].y = y
	f:SetUserPlaced(false)
	
	for k,v in wd_visible do
		f = getglobal("WatchDogFrame_"..k)
		x,y = f:GetLeft(), f:GetTop()
		s = f:GetEffectiveScale()
		
		x,y = x*s,y*s
		
		WatchDog.pos[k] = WatchDog.pos[k] or {}
		WatchDog.pos[k].x = x
		WatchDog.pos[k].y = y
		f:SetUserPlaced(false)
	end
end

function WatchDog_RestoreFramePositions()

	if not WatchDog.pos then return end
	
	local f = WatchDogFrame
	local s = f:GetEffectiveScale()
	local x,y = WatchDog.pos["master"].x, WatchDog.pos["master"].y

	x,y = x/s,y/s

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
	f:SetUserPlaced(false)
	
	for k,v in wd_visible do
		f = getglobal("WatchDogFrame_"..k)
		s = f:GetEffectiveScale()
		x,y = WatchDog.pos[k].x, WatchDog.pos[k].y
		
		x,y = x/s,y/s
		
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
		f:SetUserPlaced(false)
		StickyFrames:AnchorFrame(f, WatchDogFrame)
	end
end

function WatchDog_ReAnchor(frame)
	
	local parent = WatchDogFrame
	local xF,yF = frame:GetLeft(), frame:GetTop()
	local xP,yP = parent:GetLeft(), frame:GetTop()
	local sF,sP = frame:GetEffectiveScale(), parent:GetEffectiveScale()

	xP,yP = (xP*sP)/sF, (yP*sP)/sF
	
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", parent, "TOPLEFT", xP, yP)
end
	
function WatchDog_UpdateFrame()	
	
	for k,v in wd_visible do
		if (v and UnitExists(k)) then
			getglobal("WatchDogFrame_"..k):Show()
			WatchDog_UpdateUnit(k)
			WatchDog_UpdateAura(k)
		else
			getglobal("WatchDogFrame_"..k):Hide()
		end
		
		if (WatchDog.newbars) then 
			getglobal("WatchDogFrame_"..k.."_StatusBar1_Texture"):SetTexture("Interface\\TargetingFrame\\UI-StatusBar");			
			getglobal("WatchDogFrame_"..k.."_StatusBar2_Texture"):SetTexture("Interface\\TargetingFrame\\UI-StatusBar");			
		else 
			getglobal("WatchDogFrame_"..k.."_StatusBar1_Texture"):SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
			getglobal("WatchDogFrame_"..k.."_StatusBar2_Texture"):SetTexture("Interface\\Tooltips\\UI-Tooltip-Background");
		end
	end
	
	WatchDog_SetBorders(WatchDog.showborder);	
	
	if (WatchDog.showhpbar) then
		for k,v in wd_visible do getglobal("WatchDogFrame_"..k).StatusBar1:Show()	end
	else
		for k,v in wd_visible do getglobal("WatchDogFrame_"..k).StatusBar1:Hide()	end
	end	

	if (WatchDog.showmpbar) then
		for k,v in wd_visible do getglobal("WatchDogFrame_"..k).StatusBar2:Show() end
	else
		for k,v in wd_visible do getglobal("WatchDogFrame_"..k).StatusBar2:Hide()	end
	end		
end

function WatchDog_BuffAxis(name, dir, stack)

	if dir == "EAST" then 
		dir="LEFT"; otherdir="RIGHT"
	elseif dir == "WEST" then 
		dir="RIGHT"; otherdir="LEFT"
	end

	for i=2,8 do
		getglobal(name..i):ClearAllPoints()
		getglobal(name..i):SetPoint("TOP"..dir, name..(i-1), "TOP"..otherdir, 0,0)
	end

	local a,b = nil, nil
	
	if stack == "UP" then
		a = "BOTTOMLEFT"
		b = "TOPLEFT"
	elseif stack == "DOWN" then
		a = "TOPLEFT"
		b = "BOTTOMLEFT"
	end
	
	if stack then
		getglobal(name.."9"):ClearAllPoints()
		getglobal(name.."9"):SetPoint(a, name.."1", b, 0,0)
	else
		getglobal(name.."9"):ClearAllPoints()
		getglobal(name.."9"):SetPoint("TOP"..dir, name..(8), "TOP"..otherdir, 0,0)
	end
	
	for i=10,16 do
		getglobal(name..i):ClearAllPoints()
		getglobal(name..i):SetPoint("TOP"..dir, name..(i-1), "TOP"..otherdir, 0,0)
	end
	
end

function WatchDog_AnchorAll()
	
	local ba,da = nil,nil
	local bx,by,dx,dy = nil,nil,nil,nil
	local bs, ds = nil, nil
	
	local b,d = WatchDog.buffsanchor,WatchDog.debuffsanchor
		
	if b=="RIGHT" then ba="TOPRIGHT" bx=0 by=-2 baxis="EAST" bb="TOPLEFT" bc="TOPLEFT" bs="DOWN"
	elseif b=="LEFT" then ba="TOPLEFT" bx=0 by=-2 baxis="WEST" bb="TOPRIGHT" bc="TOPRIGHT" bs="DOWN"
	elseif b=="BOTTOM" then ba="BOTTOMLEFT" bx=0 by=0 baxis="EAST" bb="TOPLEFT" bc="TOPLEFT" bs=nil end

	if d=="RIGHT" then da="BOTTOMRIGHT" dx=0 dy=2 daxis="EAST" db="BOTTOMLEFT" dc="BOTTOMLEFT" ds="UP"
	elseif d=="LEFT" then da="BOTTOMLEFT" dx=0 dy=2 daxis="WEST" db="BOTTOMRIGHT" dc="BOTTOMRIGHT" ds="UP"
	elseif d=="BOTTOM" then da="BOTTOMLEFT" dx=0 dy=0 daxis="EAST" db="TOPLEFT" dc="TOPLEFT" ds=nil end
	
	for k,v in wd_visible do
		local buff, debuff = "WatchDogFrame_"..k.."_Buff", "WatchDogFrame_"..k.."_Debuff"

		-- Anchor the buff frame
		getglobal(buff):ClearAllPoints()
		getglobal(buff):SetPoint(bb,"WatchDogFrame_"..k,ba,bx,by)
		getglobal(buff.."1"):ClearAllPoints()
		getglobal(buff.."1"):SetPoint(bb, buff, bc, 0, 0)
		
		if b == d then
			if b == "BOTTOM" then
				getglobal(debuff):ClearAllPoints()
				getglobal(debuff):SetPoint("TOPLEFT","WatchDogFrame_"..k.."_Buff1","BOTTOMLEFT",0,0)
				getglobal(debuff.."1"):ClearAllPoints()
				getglobal(debuff.."1"):SetPoint("TOPLEFT", debuff, "TOPLEFT", 0, 0)
			else
				getglobal(debuff):ClearAllPoints()
				getglobal(debuff):SetPoint(db,"WatchDogFrame_"..k,da,dx,dy)
				getglobal(debuff.."1"):ClearAllPoints()
				getglobal(debuff.."1"):SetPoint(db, debuff, dc, 0, 0)
				bs, ds = nil, nil
			end
		else
			getglobal(debuff):ClearAllPoints()
			getglobal(debuff):SetPoint(db,"WatchDogFrame_"..k,da,dx,dy)
			getglobal(debuff.."1"):ClearAllPoints()
			getglobal(debuff.."1"):SetPoint(db, debuff, dc, 0, 0)
		end
		
		WatchDog_BuffAxis(buff, baxis, bs)
		WatchDog_BuffAxis(debuff, daxis, ds)
	end	
end


function WatchDog_UpdateAura(unit)	
	
	local frame = getglobal("WatchDogFrame_"..unit);
	if (not frame) then return; end
	
	local buff,debuff =  "WatchDogFrame_"..unit.."_Buff", "WatchDogFrame_"..unit.."_Debuff"
	local wd_isenemy = UnitIsEnemy("player",unit)
	
	local buffInsert, debuffInsert = 1,1
	
	if (WatchDog.buffs) then		
		for i=1,16 do		
			local texture,count = UnitBuff(unit,i)
			local show = nil
			
			if (texture) then
				if (WatchDog.filterbuffs) then										
					WatchDogTooltip:SetUnitBuff(unit, i);
					local name = WatchDogTooltipTextLeft1:GetText()					
					if (wd_spells[name] or (CurrentClass=="SHAMAN" and wd_spells[name.." Totem"] or name=="Grounding Totem Effect") or (CurrentClass=="PRIEST" and name=="Inspiration")) then
						show=true
					end
				else show=true end
			end
			
			if show then
				getglobal(buff..buffInsert.."_Icon"):SetTexture(texture);
				if count <= 1 then count = nil end
				getglobal(buff..buffInsert.."_Count"):SetText(count)
				getglobal(buff..buffInsert):Show();
				getglobal(buff..buffInsert).id = i
				buffInsert = buffInsert + 1
			else
				getglobal(buff..buffInsert):Hide();
			end
		end
	end

	debuffInsert = 1
	
	if (WatchDog.debuffs) then		
		for i=1,16 do
			local texture,count = UnitDebuff(unit,i)
			local show = nil

			if (texture) then
				if (WatchDog.filterdebuffs and not wd_isenemy) then
					WatchDogTooltipTextLeft1:SetText(nil)
					WatchDogTooltipTextRight1:SetText(nil)					
					WatchDogTooltip:SetUnitDebuff(unit,i)
					local name = WatchDogTooltipTextLeft1:GetText()	
					local type = WatchDogTooltipTextRight1:GetText()					
					if (wd_cures[type] or (CurrentClass=="PRIEST" and name==WATCHDOG.AILMENT_WEAKENED_SOUL) ) then
						show=true
					end
				else show=true end
			end
			
			if show then
				getglobal(debuff..debuffInsert.."_Icon"):SetTexture(texture);
				getglobal(debuff..debuffInsert):Show();
				if count <= 1 then count = nil end
				getglobal(debuff..debuffInsert.."_Count"):SetText(count)
				getglobal(debuff..debuffInsert).id=i
				debuffInsert = debuffInsert + 1
			else
				getglobal(debuff..debuffInsert):Hide()
			end			
		end
	end	
	
	-- Hide the unused buffs
	
	for i=buffInsert,16 do getglobal(buff..i):Hide(); end
	for i=debuffInsert,16 do getglobal(debuff..i):Hide(); end
end


WatchDog_UnitInformation = {	
	["name"] = 
	function (u) 
		if type(u) == "string" then
			return (UnitName(u) or "Unknown")
		elseif type(u) == "table" then
			local name = UnitName(u.unit) or "Unknown"
			if string.len(name) > u.length then
				return string.sub(name, 1, u.length) .. "..."
			else
				return name
			end
		else
			return ""
		end end,
		
	["status"] = function (u) if UnitIsDead(u) then return "Dead" elseif UnitIsGhost(u) then return "Ghost" elseif (not UnitIsConnected(u)) then return "Offline" elseif (UnitAffectingCombat(u)) then return "Combat" elseif (u== "player" and IsResting()) then return "Resting" else return "" end end,
	["statuscolor"] = function (u) if UnitIsDead(u) then return "|cffff0000" elseif UnitIsGhost(u) then return "|cff9d9d9d" elseif (not UnitIsConnected(u)) then return "|cffff8000" elseif (UnitAffectingCombat(u)) then return "|cffFF0000" elseif (u== "player" and IsResting()) then return GetHex(UnitReactionColor[4]) else return "" end end,
	["happycolor"] = function (u) local x=GetPetHappiness() return ( (x==2) and "|cffFFFF00" or (x==1) and "|cffFF0000" or "" ) end,

	["curhp"] = function (u) return wd_curhp end,
	["maxhp"] = function (u) return wd_maxhp end,
	["percenthp"] = function (u) return ( (wd_maxhp~=0) and floor(wd_curhp/wd_maxhp*100+0.5) or 0) end,
	["missinghp"] = function (u) return ((wd_maxhp - wd_curhp) or 0) end,
	
	["curmp"] = function (u) return wd_curmp end,
	["maxmp"] = function (u) return wd_maxmp end,
	["percentmp"] = function (u) return wd_permp end,
	["missingmp"] = function (u) return (wd_maxmp - wd_curmp) end,
	["typemp"] = function (u) local p=UnitPowerType(u) return ( (p==1) and "Rage" or (p==2) and "Focus" or (p==3) and "Energy" or "Mana" ) end,
	["level"] = function (u) local x = UnitLevel(u) return ((x>0) and x or "??") end,
	["class"] = function (u) return (UnitClass(u) or "Unknown") end,
	["creature"] = function (u) return (UnitCreatureFamily(u) or UnitCreatureType(u) or "Unknown") end,
	["smartclass"] = function (u) if UnitIsPlayer(u) then return WatchDog_UnitInformation["class"](u) else return WatchDog_UnitInformation["creature"](u) end end,
	["combos"] = function (u) return (GetComboPoints() or 0) end,
	["combos2"] = function (u) return string.rep("@", GetComboPoints()) end,
	["classification"] = function (u) if UnitClassification(u) == "rare" then return "Rare " elseif UnitClassification(u) == "eliterare" then return "Rare Elite " elseif UnitClassification(u) == "elite" then return "Elite " elseif UnitClassification(u) == "worldboss" then return "Boss " else return "" end end, 
	["faction"] = function (u) return (UnitFactionGroup(u) or "") end,
	["connect"] = function (u) return ( (UnitIsConnected(u)) and "" or "Offline" ) end,
	["race"] = function (u) return ( UnitRace(u) or "") end,
	["pvp"] = function (u) return ( UnitIsPVP(u) and "PvP" or "" ) end,
	["plus"] = function (u) return ( UnitIsPlusMob(u) and "+" or "" ) end,
	["sex"] = function (u) local x = UnitSex(u) return ( (x==0) and "Male" or (x==1) and "Female" or "" ) end,
	["rested"] = function (u) return (GetRestState()==1 and "Rested" or "") end,
	["leader"] = function (u) return (UnitIsPartyLeader(u) and "(L)" or "") end,
	["leaderlong"] = function (u) return (UnitIsPartyLeader(u) and "(Leader)" or "") end,
	
	["happynum"] = function (u) return (GetPetHappiness() or 0) end,
	["happytext"] = function (u) return ( getglobal("PET_HAPPINESS"..(GetPetHappiness() or 0)) or "" ) end,
	["happyicon"] = function (u) local x=GetPetHappiness() return ( (x==3) and ":)" or (x==2) and ":|" or (x==1) and ":(" or "" ) end,
		
	["curxp"] = function (u) return (UnitXP(u) or "") end,
	["maxxp"] = function (u) return (UnitXPMax(u) or "") end,
	["percentxp"] = function (u) local x=UnitXPMax(u) if (x>0) then return floor( UnitXP(u)/x*100+0.5) else return 0 end end,
	["missingxp"] = function (u) return (UnitXPMax(u) - UnitXP(u)) end,
	["restedxp"] = function (u) return (GetXPExhaustion() or "") end,

	["tappedbyme"] = function (u) if UnitIsTappedByPlayer("target") then return "*" else return "" end end,
	["istapped"] = function (u) if UnitIsTapped(u) and (not UnitIsTappedByPlayer("target")) then return "*" else return "" end end,
	["pvpranknum"] = function (u) return (UnitPVPRank(u) or "") end,
	["pvprank"] = function (u) if (UnitPVPRank(u) >= 1) then return (GetPVPRankInfo(UnitPVPRank(u), u) or "" ) else return "" end end,
	["fkey"] = function (u) local _,_,fkey = string.find(u, "^party(%d)$") if not fkey then return "" else return "F"..fkey end end,
	
	["white"] = function (u) return "|cFFFFFFFF" end,
	["aggro"] = function (u) local reaction = UnitReaction(u, "player"); return UnitPlayerControlled(u) and (UnitCanAttack(u, "player") and UnitCanAttack("player", u) and "|cffFF0000" or UnitCanAttack("player", u) and "|cffffff00" or UnitIsPVP("target") and "|cff00ff00" or "|cFFFFFFFF") or (UnitIsTapped(u) and (not UnitIsTappedByPlayer(u)) and "|cff808080") or ((reaction == 1) and "|cffff0000" or (reaction == 2) and "|cffff0000" or (reaction == 4) and "|cffffff00" or (reaction == 5) and "|cff00ff00") or "|cFFFFFFFF"; end,
	["difficulty"] = function (u) if UnitCanAttack("player",u) then local x = (UnitLevel(u)>0) and UnitLevel(u) or 99 return GetHex( GetDifficultyColor(x) ) else return "" end end,
	["colormp"] = function (u) local x = ManaBarColor[UnitPowerType(u)] return GetHex(x.r, x.g, x.b) end,  
	["inmelee"] = function (u) if PlayerFrame.inCombat then return "|cffFF0000" else return "" end end,
	["incombat"] = function (u) if UnitAffectingCombat(u) then return "|cffFF0000" else return "" end end,
	["raidcolor"] = function (u) local _,x=UnitClass(u) if x then return (GetHex(RAID_CLASS_COLORS[x]) or "") else return "" end end,
	["lowhpcolor"] = function (u) if wd_perhp <= 20 then return "|cffFF0000" else return "" end end,
	["lowmpcolor"] = function (u) if wd_permp <= 20 then return "|cff0000FF" else return "" end end,
}

function GetHex(r,g,b)
	if g then
		return string.format("|cFF%02X%02X%02X", (255*r), (255*g), (255*b))
	elseif r then
		return string.format("|cFF%02X%02X%02X", (255*r.r), (255*r.g), (255*r.b))
	else
		return ""
	end
end
	
function WatchDog_UpdateUnit(unit)
	local frame = getglobal("WatchDogFrame_"..unit);
	if not frame or not UnitExists(unit) then return; end
	
	wd_curhp = (UnitHealth(unit) or 0);
	wd_maxhp = (UnitHealthMax(unit) or 0);
	wd_perhp = ( (wd_maxhp~=0) and floor(wd_curhp/wd_maxhp*100+0.5) or 0)
	wd_curmp = UnitMana(unit) or 1
	wd_maxmp = UnitManaMax(unit) or 0
	wd_permp = ( (wd_maxmp > 0) and floor(wd_curmp/wd_maxmp*100+0.5) or 0)

	if (wd_maxhp == 100 and unit=="target" and WatchDog.targethp) then		
		wd_curhp,wd_maxhp = WatchDog_EstimateHP(wd_curhp);
	end	
 	
	local unitformat = frame.unitformat
	
	frame.text1left:SetText( string.format(wd_textformat[unitformat].format1.left.format, GetValues(wd_textformat[unitformat].format1.left.args, wd_textformat[unitformat].format1.left.argwidth,unit)) );
	frame.text1center:SetText( string.format(wd_textformat[unitformat].format1.center.format, GetValues(wd_textformat[unitformat].format1.center.args,wd_textformat[unitformat].format1.center.argwidth,unit)) );
	frame.text1right:SetText( string.format(wd_textformat[unitformat].format1.right.format, GetValues(wd_textformat[unitformat].format1.right.args,wd_textformat[unitformat].format1.right.argwidth,unit)) );

	frame.text2left:SetText( string.format(wd_textformat[unitformat].format2.left.format, GetValues(wd_textformat[unitformat].format2.left.args,wd_textformat[unitformat].format2.left.argwidth,unit)) );
	frame.text2center:SetText( string.format(wd_textformat[unitformat].format2.center.format, GetValues(wd_textformat[unitformat].format2.center.args,wd_textformat[unitformat].format2.center.argwidth,unit)) );
	frame.text2right:SetText( string.format(wd_textformat[unitformat].format2.right.format, GetValues(wd_textformat[unitformat].format2.right.args,wd_textformat[unitformat].format2.right.argwidth,unit)) );

	local width = nil
	
	if WatchDog.dynamicwidth then	
		local l,c,r =
		wd_textformat[unitformat].format1.left.width or frame.text1left:GetStringWidth(),
		wd_textformat[unitformat].format1.center.width or frame.text1center:GetStringWidth(), 
		wd_textformat[unitformat].format1.right.width or frame.text1right:GetStringWidth()
		frame.text1left:SetWidth(l) frame.text1center:SetWidth(c) frame.text1right:SetWidth(r)
		width = l+c+r
		
		l,c,r=	 
		wd_textformat[unitformat].format2.left.width or frame.text2left:GetStringWidth(),
		wd_textformat[unitformat].format2.center.width or frame.text2center:GetStringWidth(), 
		wd_textformat[unitformat].format2.right.width or frame.text2right:GetStringWidth()
		frame.text2left:SetWidth(l) frame.text2center:SetWidth(c) frame.text2right:SetWidth(r)
		width = (width > (l+c+r)) and width or (l+c+r)				
	else
		width = WatchDog.fixedwidth
		local total=100
		local tl,tc,tr = frame.text1left:GetStringWidth(),frame.text1center:GetStringWidth(),frame.text1right:GetStringWidth()
		local l,c,r = wd_textformat[unitformat].format1.left.width, wd_textformat[unitformat].format1.center.width, wd_textformat[unitformat].format1.right.width
		if l then	total=total-l tl=0 end if c then total=total-c tc=0 end if r then total=total-r tr=0 end		
		if not l then l = tl/(tl+tc+tr)*total end if not c then c = tc/(tl+tc+tr)*total end	if not r then r = tr/(tl+tc+tr)*total end
		frame.text1left:SetWidth(l*width/100) frame.text1center:SetWidth(c*width/100) frame.text1right:SetWidth(r*width/100)
			
		total=100
		tl,tc,tr = frame.text2left:GetStringWidth(),frame.text2center:GetStringWidth(),frame.text2right:GetStringWidth()
		l,c,r= wd_textformat[unitformat].format2.left.width, wd_textformat[unitformat].format2.center.width, wd_textformat[unitformat].format2.right.width
		if l then	total=total-l tl=0 end if c then total=total-c tc=0 end if r then total=total-r tr=0 end
		if not l then l = tl/(tl+tc+tr)*total end if not c then c = tc/(tl+tc+tr)*total end	if not r then r = tr/(tl+tc+tr)*total end
		frame.text2left:SetWidth(l*width/100) frame.text2center:SetWidth(c*width/100) frame.text2right:SetWidth(r*width/100)
	end
	
	frame:SetWidth(width+12);
		
	
	if WatchDog.showhpbar then
		local hpp = WatchDog_UnitInformation["percenthp"](unit)
		frame.StatusBar1:SetStatusBarColor(GetHPSeverity(unit,hpp/100,WatchDog.hpsmooth))	
		if WatchDog.hpreverse then frame.StatusBar1:SetValue(100-hpp)			
		else frame.StatusBar1:SetValue(hpp) end
	end
		
	if WatchDog.showmpbar then
		local mpp = WatchDog_UnitInformation["percentmp"](unit)		
		frame.StatusBar2:SetStatusBarColor(GetMPSeverity(unit,mpp/100))		
		if WatchDog.mpreverse then frame.StatusBar2:SetValue(100-mpp)
		else frame.StatusBar2:SetValue(mpp) end
	end
	
	if WatchDog.colorback.a~=0 then
		frame:SetBackdropColor(WatchDog.colorback.r,WatchDog.colorback.g,WatchDog.colorback.b,WatchDog.colorback.a)
	end
end

function WatchDog_OnClick(button,argunit)
    if WatchDog_CustomClick and WatchDogCustomClick(button, argunit) then return end
    
	wd_unit = argunit or this.unit	
	
	if not UnitExists(wd_unit) then return; end
	
	if SpellIsTargeting() then
		if (button=="LeftButton") then SpellTargetUnit(wd_unit);
		elseif (button=="RightButton") then	SpellStopTargeting();	end
		return;
	end

	if CursorHasItem() then
		if (button=="LeftButton") then
			if (unit=="player") then	AutoEquipCursorItem();
			else DropItemOnUnit(wd_unit); end
		else PutItemInBackpack(); end
		return;
	end
    
    if button == "LeftButton" then
        TargetUnit(wd_unit)
    elseif button == "RightButton" then
        WD_Menu(wd_unit)
    end
    
	--[[
	local keydown,click_type ="",(UnitCanAttack("player",wd_unit)) and "enemy_click" or "friendly_click";	
	
	if IsAltKeyDown() then keydown="Alt";
	elseif IsShiftKeyDown() then keydown="Shift";
	elseif IsControlKeyDown() then keydown="Control"; 
	end
	
	local action = (WatchDog[CurrentClass][click_type][button..keydown]) or (WatchDog["GLOBAL"][click_type][button..keydown]);
	
	if ( type(getglobal(action))=="function" ) then
		getglobal(action)(wd_unit);
	
	elseif action then
		if wd_spells[action] then			
			WatchDog_CastSpell(action,wd_unit)
		elseif ( string.find(action,"/script") ) then		
			RunScript( (string.gsub(action,"/script(.*)","%1")) )
		end
	end
	
	if (WatchDog.targetless) then
		return true;
	end
    --]]
end

function WatchDog_CastSpell(spellid,theunit)
	
	local id,unit = wd_spells[spellid] or tonumber(spellid), theunit or wd_unit
	
	if WatchDog.bestrank then
		id,unit = WD_BestRank(spellid,unit)
	end

	if id then
		local mytarget = UnitName("target");		
		if (id>2000) then
			TargetUnit(unit)
			CastSpell((id-2000),BOOKTYPE_PET);
		else
			if unit=="targettarget" then unit=GetFriendlyTarget("targettarget"); end
			
			if ( UnitCanAttack("player",unit) and unit~="target") then TargetUnit(unit)
			elseif ( UnitIsFriend("player","target") and (not UnitIsUnit(unit,"target")) ) then
				if unit=="targettarget" then TargetUnit("targettarget") 
				else ClearTarget();	end
			elseif ( UnitCanAttack("player", "target") and (not UnitIsUnit(unit, "target")) ) then
				local dispelCast = (string.find(spellid, WATCHDOG.CURE_MAGIC_1))
				if not dispelCast then dispelCast = (string.find(spellid, WATCHDOG.HOLY_SHOCK)) end
				if dispelCast then 
					ClearTarget();
					mytarget="LastEnemy";
				else mytarget=nil; end
			else mytarget=nil; end
			
			CastSpell(id,BOOKTYPE_SPELL);			
			if SpellIsTargeting() then SpellTargetUnit(unit); end
			-- stop targeting just in case we did not apply the spell successfully
   			if SpellIsTargeting() then SpellStopTargeting() end
		end
		
		if mytarget == "LastEnemy" then TargetLastEnemy() 
		elseif mytarget then TargetByName(mytarget); end		
	end
end

function GetFriendlyTarget(unit)
	if UnitIsUnit("player",unit) then	return "player"
	elseif UnitIsUnit("party1",unit) then	return "party1"
	elseif UnitIsUnit("party2",unit) then	return "party2"
	elseif UnitIsUnit("party3",unit) then	return "party3"
	elseif UnitIsUnit("party4",unit) then	return "party4"
	elseif UnitIsUnit("pet",unit) then	return "pet"
	elseif UnitIsUnit("partypet1",unit) then	return "partypet1"
	elseif UnitIsUnit("partypet2",unit) then	return "partypet2"
	elseif UnitIsUnit("partypet3",unit) then	return "partypet3"
	elseif UnitIsUnit("partypet4",unit) then	return "partypet4"
	else return "targettarget"	end
end

function WatchDog_UpdateSpells()

	wd_cures = {}

	local i = 1;
	while true do
		local name, rank = GetSpellName(i,BOOKTYPE_SPELL);
		
		if (not name) then
			break
		end
		
		if (cure_lookup[name]) then
			for a,b in cure_lookup[name] do
				wd_cures[b] = name
			end
		end
					
		if ( not IsSpellPassive(i, BOOKTYPE_SPELL) ) then			
			wd_spells[name] = i;
			if (string.find(rank,WATCHDOG.RANK)) then
				wd_spells[name.."("..rank..")"] = i;
			end						
		end		
		i=i+1;	
	end	
	if HasPetSpells() then WatchDog_UpdatePetSpells()	end	
end

function WatchDog_UpdatePetSpells()
	local i=1
	while true do
		local name, rank = GetSpellName(i,BOOKTYPE_PET)
		
		if (not name) then
			break
		end
		
		wd_spells[name] = (2000+i);
		if (string.find(rank,WATCHDOG.RANK)) then
			wd_spells[name.."("..rank..")"] = (2000+i);
		end
		i=i+1
	end		
end

function WatchDog_TargetChanged()				
		if (WatchDog.targethp) then
			estimates = {}
			precision_count, recent_damage, total_damage = 0,0,0;
			start_percent = UnitHealth("target");
			last_percent = start_percent;
			thecount=0;
		end
		
		WatchDog_UpdateUnit("target");
		WatchDog_UpdateAura("target");		
end

function WatchDog_EstimateHP(current)	

	if (current==start_percent or current==0) then
			
	elseif (current > last_percent or start_percent>100) then		
		last_percent = current;
		start_percent = current;
		recent_damage=0;
		total_damage=0;
				
	elseif (precision_count <= WatchDog.precision and recent_damage>0) then			 						
		
		table.insert(estimates, floor( (total_damage*100) / (start_percent-current) + 0.5 ) );	
		
		if (current~=last_percent) then				
			table.insert(estimates, floor( (recent_damage*100) / (last_percent-current) + 0.5 ) );
			recent_damage = 0;
			last_percent = current;
			precision_count = precision_count + 1;
		end			
		
		table.sort(estimates);
	end
	
	local hpmax = estimates[ floor(getn(estimates)/2) ];
	
	if (hpmax) then
		return ( floor(hpmax/100*current) ), hpmax;
	else
		return current,100;
	end
	
end

function GetMPSeverity(unit,percent)
	local x = ManaBarColor[UnitPowerType(unit)]
	return x.r, x.g, x.b	
end

function GetHPSeverity(unit,percent,smooth)
	if (percent<=0 or percent>1.0) then return 0.35,0.35,0.35 end

       	if smooth then	
		if (percent >= 0.5) then
			return (1.0-percent)*2, 1.0, 0.0;
		else
			return 1.0, percent*2, 0.0;
		end
	else
		return 0,1,0
	end
end

function WatchDog_SetBorders(arg1)
	arg1 = arg1 and 1.0 or 0.0;	
	for k,v in wd_visible do
		getglobal("WatchDogFrame_"..k):SetBackdropBorderColor(1.0,1.0,1.0,arg1);
	end
end

function WatchDog_AnchorButton(frame,anchorname)
	
	if (not frame:GetLeft() or not anchorname:GetLeft()) then return end
	frame:SetPoint("TOPLEFT",anchorname:GetName(),"TOPLEFT",((anchorname:GetLeft() - frame:GetLeft())*-1),((anchorname:GetTop() - frame:GetTop())*-1));
end


function WatchDog_CheckSavedVariables()

	if not WatchDog then WatchDog = {} end
	if nil==WatchDog.visible then	WatchDog.visible = true; end		
	if nil==WatchDog.player then		
		WatchDog.player = {
			visible = true,	
			format1 = "[name] Health:[curhp]/[maxhp] ([percenthp]%)",
			format2 = "[level] [class]  [typemp]:[percentmp]%",
		}
	end	
	if nil==WatchDog.party then		
		WatchDog.party = {
			visible = true,
			format1 = "[name] Health:[curhp]/[maxhp] ([percenthp]%)",
			format2 = "[level] [class]  [typemp]:[percentmp]%",
		}
	end
	if nil==WatchDog.pet then		
		WatchDog.pet = {
			visible = true,
			format1 = "[name] Health:[curhp]/[maxhp] ([percenthp]%)",
			format2 = "[level] [class]  [typemp]:[percentmp]%",
		}
	end		
	if nil==WatchDog.target then		
		WatchDog.target = {
			visible = true,
			format1 = "[name] Health:[curhp]/[maxhp] ([percenthp]%)",
			format2 = "[level] [class]  [typemp]:[percentmp]%",
		}
	end	
	if nil==WatchDog.showborder then WatchDog.showborder=true; end	
	if nil==WatchDog.colorback then WatchDog.colorback = {r=0.0,g=0.0,b=0.0,a=0.0} end
	if nil==WatchDog.buffs then WatchDog.buffs=true; end

	if nil==WatchDog.tooltips then WatchDog.tooltips=true; end
	if nil==WatchDog.partypets then WatchDog.partypets=true; end
	
	-- Fix for anchor change
	if WatchDog.buffsanchor == "TOPRIGHT" then WatchDog.buffsanchor = "LEFT" end
	if WatchDog.buffsanchor == "TOPLEFT" then WatchDog.buffsanchor = "RIGHT" end
	if WatchDog.debuffsanchor == "TOPRIGHT" then WatchDog.debuffsanchor = "LEFT" end
	if WatchDog.debuffsanchor == "TOPLEFT" then WatchDog.debuffsanchor = "RIGHT" end
	
	if nil==WatchDog.buffsanchor then WatchDog.buffsanchor="RIGHT"; end
	if nil==WatchDog.debuffsanchor then WatchDog.debuffsanchor="LEFT"; end
	if nil==WatchDog.filterbuffs then WatchDog.filterbuffs=false end
	if nil==WatchDog.debuffs then WatchDog.debuffs=true; end
	if nil==WatchDog.filterdebuffs then WatchDog.filterdebuffs=false end	
	if nil==WatchDog.locked then WatchDog.locked=false; end
	if nil==WatchDog.targethp then WatchDog.targethp=true; end
	if nil==WatchDog.precision then WatchDog.precision=50; end
	if nil==WatchDog.scale then WatchDog.scale=1.0; end
	if nil==WatchDog.fixedwidth then WatchDog.fixedwidth = 150; end
	if nil==WatchDog.dynamicwidth then WatchDog.dynamicwidth = true; end
	
	if nil==WatchDog.toft then WatchDog.toft = true; end
	if nil==WatchDog.toftprecision then WatchDog.toftprecision=0.25 end
	
	if nil==WatchDog.showhpbar then WatchDog.showhpbar=true; end
	if nil==WatchDog.hpreverse then WatchDog.hpreverse=false; end
	if nil==WatchDog.hpsmooth then WatchDog.hpsmooth=true; end
	if nil==WatchDog.hpheight then WatchDog.hpheight=12; end
	
	if nil==WatchDog.showmpbar then WatchDog.showmpbar=true; end
	if nil==WatchDog.mpreverse then WatchDog.mpreverse=false; end
	
	if nil==WatchDog.defaultplayer then WatchDog.defaultplayer=true; end
	if nil==WatchDog.defaulttarget then WatchDog.defaulttarget=true; end
	if nil==WatchDog.defaultparty then WatchDog.defaultparty=true; end
	if nil==WatchDog.defaultbuffs then WatchDog.defaultbuffs=true; end
	if nil==WatchDog.defaultbirds then WatchDog.defaultbirds=true; end
	if nil==WatchDog.newbars then WatchDog.newbars = true; end
	if nil==WatchDog.targetless then WatchDog.targetless = true; end
	if nil==WatchDog.ctraidassist then WatchDog.ctraidassist = true; end
	if nil==WatchDog.blizzraid then WatchDog.blizzraid = true; end
	
	if nil==WatchDog["GLOBAL"] then
		WatchDog["GLOBAL"] = { 
			friendly_click = {RightButton='WD_Menu', LeftButton='TargetUnit', RightButtonAlt='WD_CureAny',},
			enemy_click = {RightButton='AssistUnit',},
		}
	end		
	if nil==WatchDog["PRIEST"] then
		WatchDog["PRIEST"] = { friendly_click = {}, enemy_click = {}, }
	end	
	if nil==WatchDog["WARRIOR"] then
		WatchDog["WARRIOR"] = { friendly_click = {}, enemy_click = {}, }
	end
	if nil==WatchDog["WARLOCK"] then
		WatchDog["WARLOCK"] = { friendly_click = {}, enemy_click = {}, }
	end
	if nil==WatchDog["SHAMAN"] then
		WatchDog["SHAMAN"] = { friendly_click = {}, enemy_click = {}, }
	end
	if nil==WatchDog["ROGUE"] then
		WatchDog["ROGUE"] = { friendly_click = {}, enemy_click = {}, }
	end
	if nil==WatchDog["MAGE"] then
		WatchDog["MAGE"] = { friendly_click = {}, enemy_click = {}, }
	end
	if nil==WatchDog["DRUID"] then
		WatchDog["DRUID"] = { friendly_click = {}, enemy_click = {}, }
	end
	if nil==WatchDog["HUNTER"] then
		WatchDog["HUNTER"] = { friendly_click = {}, enemy_click = {}, }
	end
	if nil==WatchDog["PALADIN"] then
		WatchDog["PALADIN"] = { friendly_click = {}, enemy_click = {}, }
	end	
	
	WatchDog_SetTextFormats();
	WatchDog_UpdateVisibility();		
	--WDHooks:RunHooks();
end

function WatchDog_UpdateVisibility()

	if not WatchDog.visible then
		for k,v in wd_visible do
			wd_visible[k]=false
		end
	else
		wd_visible.player = WatchDog.player.visible;
		if (WatchDog.pet.visible) then
			wd_visible.pet=true;
		else
			wd_visible.pet=false;
		end

		if (WatchDog.partypets) then
			wd_visible.partypet1=true;
			wd_visible.partypet2=true;
			wd_visible.partypet3=true;
			wd_visible.partypet4=true;
		else
			wd_visible.partypet1=false;
			wd_visible.partypet2=false;
			wd_visible.partypet3=false;
			wd_visible.partypet4=false;
		end
		
		if (WatchDog.party.visible) then
			wd_visible.party1=true;
			wd_visible.party2=true;
			wd_visible.party3=true;
			wd_visible.party4=true;
		else
			wd_visible.party1=false;
			wd_visible.party2=false;
			wd_visible.party3=false;
			wd_visible.party4=false;
		end	
		wd_visible.target = WatchDog.target.visible;		
	end
		
	for k,v in wd_visible do
		if WatchDog.debuffs then getglobal("WatchDogFrame_"..k.."_Debuff"):Show();
		else getglobal("WatchDogFrame_"..k.."_Debuff"):Hide() end

		if WatchDog.buffs then getglobal("WatchDogFrame_"..k.."_Buff"):Show();
		else getglobal("WatchDogFrame_"..k.."_Buff"):Hide() end	
	end				
	
	if WatchDog.defaultbuffs then BuffFrame:Show() else BuffFrame:Hide() end
	if WatchDog.defaultbirds then 
		MainMenuBarRightEndCap:Show(); MainMenuBarLeftEndCap:Show();
	else
		MainMenuBarRightEndCap:Hide(); MainMenuBarLeftEndCap:Hide(); 
	end

	WatchDogFrame:SetScale(WatchDog.scale)
	
	for k,v in wd_visible do
		getglobal("WatchDogFrame_"..k.."_StatusBar1"):SetHeight(WatchDog.hpheight);
	end
end

function WatchDog_Hide()
	WatchDog.visible = false
	WatchDogFrame:Hide();	
	WatchDog_UpdateVisibility()
end

function WatchDog_Show()
	WatchDog.visible = true
	WatchDog_UpdateVisibility();	
	WatchDogFrame:Show();	
	WatchDog_UpdateSpells();
	WatchDog_UpdateFrame();
end

function GetValues(args, wArgs, unit)	
	wd_tset(wd_unitinfo,0)

	for i,param in args do
		if not WatchDog_UnitInformation[param] then
			DEFAULT_CHAT_FRAME:AddMessage(GetHex(1.0, 0.1, 0.1) .. "WatchDog: Please report [" .. param .. "] to cladhaire@gmail.com or http://watchdog.brokendreams.net");
		elseif not WatchDog_UnitInformation[param](unit) then
			DEFAULT_CHAT_FRAME:AddMessage(GetHex(1.0, 0.1, 0.1) .. "WatchDog: Please report [" .. param .. "(" .. unit .. ")] to cladhaire@gmail.com or http://watchdog.brokendreams.net");
		else
			if param == "name" then
				local theUnit = unit
				if wArgs[i] and wArgs[i] ~= "" then theUnit = {unit=theUnit, length=wArgs[i]} end
				wd_tins(wd_unitinfo,WatchDog_UnitInformation[param](theUnit));
			else
				wd_tins(wd_unitinfo,WatchDog_UnitInformation[param](unit));
			end
		end
	end

	return unpack(wd_unitinfo);
end

function WatchDog_InitializeTextFormat()
wd_textformat = {
	player = { 
	format1 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	format2 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	},
	pet = {
	format1 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	format2 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	},
	party = {
	format1 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	format2 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	},
	target = {
	format1 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	format2 = {left = {width=false,format="",args={}},center = {width=false,format="",args={}},right = {width=false,format="",args={}} },
	},
}

end


function WatchDog_SetTextFormats()
	WatchDog_InitializeTextFormat()
	for a in wd_textformat do
		for b in wd_textformat[a] do
			local current_format = WatchDog[a][b]
			local endpoint,opentag=nil,"left"
			local shortcut = wd_textformat[a][b]
			
			for s,data,e in string.gfind(current_format,"()(%b[])()") do
				local _,_,arg,width = string.find(string.sub(data,2,-2),"(%S+)%s*(%d*)")
				if (arg=="left" or arg=="center" or arg=="right") then
					if opentag~=arg then
						shortcut[opentag].format = string.sub(current_format,(endpoint or 1),s-1)	
					end	
					endpoint=e opentag=arg
					shortcut[opentag].width = tonumber(width)
				end							
			end
			shortcut[opentag].format = string.sub(current_format,(endpoint or 1))
					
			shortcut.left.format, shortcut.left.args, shortcut.left.argwidth = WatchDog_ToFormat(shortcut.left.format)
			shortcut.center.format, shortcut.center.args, shortcut.center.argwidth = WatchDog_ToFormat(shortcut.center.format)
			shortcut.right.format, shortcut.right.args, shortcut.right.argwidth = WatchDog_ToFormat(shortcut.right.format)					
		end
	end	
end

function WatchDog_ToFormat(thestring)
	local args, argwidth = {}, {}	
	if (thestring=="") then return "",args; end
	
	thestring = string.gsub(thestring,"%%","%%%%");
	thestring = string.gsub(thestring,"%b<>", function (n) return "|cFF"..string.sub(n,2,-2) end);
	thestring = string.gsub(thestring,"%b[]", function (n) 
											  local _,_,v,w = string.find(string.sub(n,2,-2),"(%S+)%s*(%d*)")
											  if WatchDog_UnitInformation[v] then
												table.insert(args,v);
												table.insert(argwidth, tonumber(w))
												return "%s"
											  else
												DEFAULT_CHAT_FRAME:AddMessage(GetHex(1.0, 0.1, 0.1) .. "WatchDog: There is an error in one of your strings.  ["..v.."] is not a valid string.");
												return ""
											  end end);
	return thestring, args, argwidth;	
end

function WatchDog_UpdateTOFT()	
	if UnitExists("targettarget") and not UnitIsUnit("player","target") then
		toftcount = toftcount + arg1
		if (toftcount >= WatchDog.toftprecision) then
			WatchDog_UpdateUnit("targettarget")
			WatchDog_UpdateAura("targettarget")
			toftcount = 0
			WatchDogFrame_targettarget:Show()
		end
	elseif WatchDogFrame_targettarget:IsVisible() then
		WatchDogFrame_targettarget:Hide()
		if wd_moving == WatchDogFrame_targettarget then
			StickyFrames:StopMoving(WatchDogFrame_targettarget)
			wd_moving = nil
		end
	end		
end

SLASH_WATCHDOG1 = "/wdog";
SLASH_WATCHDOG2 = "/wd";
SLASH_WATCHDOG3 = "/watchdog";

SlashCmdList["WATCHDOG"] = function(msg)
	if not IsAddOnLoaded("WatchDogOptions") then
		if not LoadAddOn("WatchDogOptions") then
			DEFAULT_CHAT_FRAME:AddMessage("|ffffff00WatchDog: Unable to load WatchDogOptions.")
		end
	end
	
	if (msg=="restoredefaults") then
		WatchDog = {}
		ReloadUI();
		WatchDog_CheckSavedVariables();
	elseif (msg=="cc") then
		--WatchDogOptions_ClickCastings:Show();
	elseif (msg=="resetframes") then
		WatchDogOptions_ResetFrames()
	elseif (msg=="lock") then
		WatchDog.locked = true
		WatchDog_UpdateVisibility()
		if WatchDog.gtt then 
			GameTooltip:Hide()
		end
	elseif msg == "showall" then
		WatchDog_ShowAll()
		WatchDog.locked = nil
	elseif msg == "hideall" then
		WatchDog_ResetAll()
		WatchDog.locked = true
		if WatchDog.gtt then 
			GameTooltip:Hide()
		end
		WatchDog_UpdateFrame()
	elseif (msg=="unlock") then
		WatchDog.locked = nil
		WatchDog_UpdateVisibility()
	else		
		if (WatchDogOptions:IsVisible()) then
			WatchDogOptions:Hide();
		else			
			WatchDogOptions:Show();	
		end
	end
end	

local oldUpdateVis = WatchDog_UpdateVisibility
local oldUpdateUnit = WatchDog_UpdateUnit
local oldOnEvent = WatchDog_OnEvent
local oldTOFT = WatchDog_UpdateTOFT

function WatchDog_ShowAll()
	WatchDog_UpdateVisibility = function() end
	WatchDog_UpdateUnit = function() end
	WatchDog_OnEvent = function() end
	WatchDog_UpdateTOFT = function() end

	for k,frame in frames do
		local buff,debuff =  "WatchDogFrame_"..frame.unit.."_Buff", "WatchDogFrame_"..frame.unit.."_Debuff"
		
		for i=1,16 do
--			getglobal(buff..i.."_Icon"):SetTexture("Interface\\Icons\\INV_Stone_02")
			getglobal(buff..i):Hide();
		end
		for i=1,16 do
--			getglobal(debuff..i.."_Icon"):SetTexture("Interface\\Icons\\INV_Stone_01")
			getglobal(debuff..i):Hide();
		end
		
		frame.text1left:SetText(tostring(frame.unit))
		frame.text1center:SetText(tostring(frame.unit))
		frame.text1right:SetText(tostring(frame.unit))
		frame.text2left:SetText(tostring(frame.unit))
		frame.text2center:SetText(tostring(frame.unit))
		frame.text2right:SetText(tostring(frame.unit))
		
		frame:SetWidth(150)
		frame:Show()
	end
end

function WatchDog_ResetAll()
	WatchDog_UpdateVisibility = oldUpdateVis
	WatchDog_UpdateUnit = oldUpdateUnit
	WatchDog_OnEvent = oldOnEvent
	WatchDog_UpdateTOFT = oldTOFT

	WatchDog_UpdateVisibility()

	for k,v in wd_visible do
		if v then
			getglobal("WatchDogFrame_"..k):Show()
			WatchDog_UpdateUnit(k)
		else
			getglobal("WatchDogFrame_"..k):Hide()
		end
	end
	
	if UnitExists("target") then WatchDog_UpdateUnit("target") end
	if UnitExists("targettarget") then WatchDog_UpdateUnit("targettarget") end
end

--[[---------------------------------------------------------------------------------
  Add hooks for the different unitframes out there, when asked to.
----------------------------------------------------------------------------------]]
--[[
function WDHooks:RunHooks()
	-- CTRaidAssist provides a nice function to use
 	if ((not CT_RA_CustomOnClickFunction) and WatchDog.ctraidassist) then
		if WatchDog.ctraidassist then
			CT_RA_CustomOnClickFunction = WatchDog_OnClick 
		end
	end
	
	-- Check for Blizzard Raid UI
	if IsAddOnLoaded("Blizzard_RaidUI") then 
		if WatchDog.blizzraid then
			if not self:IsHooked("RaidPulloutButton_OnClick") then
				self:Hook("RaidPulloutButton_OnClick", "BlizzRaidClick")
			end
		else
			if self:IsHooked("RaidPulloutButton_OnClick") then
				self:Unhook("RaidPulloutButton_OnClick")
			end
		end
		
		for i=1,12 do
			for k=1,15 do
				getglobal("RaidPullout"..i.."Button"..k.."ClearButton"):RegisterForClicks("LeftButtonUp","RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
			end
		end
	end
	
	if XRaid then
		if not self:IsHooked(XRaid, "OnClick") then
			self:Hook(XRaid, "OnClick", "XRaidClick")
			self:Hook(XRaid, "MouseUp", "XRaidMouseUp")
		end
	end
end

function WDHooks.BlizzRaidClick()
	local button = arg1
	local unit = this.unit
	
	-- If no unit assume that this is a manabar or healthbar and look at the parent's unit info
	if not unit then
		unit = this:GetParent().unit
	end
	if not WatchDog_OnClick(button, unit) then
		WDHooks.Hooks.RaidPulloutButton_OnClick.orig(button)
	end
end

function WDHooks:XRaidClick(button)
	WatchDog_OnClick(button, "raid"..this:GetID())
	self.Hooks[XRaid].OnClick.orig(XRaid, button)
end

function WDHooks:XRaidMouseUp(button)
	if IsControlKeyDown() and IsShiftKeyDown() and IsAltKeyDown() then
		if button == "LeftButton" or button == "RightButton" then 
			return self.Hooks[XRaid].MouseUp.orig(XRaid, button)
		end
	end
end

function WDHooks:RaidLoad()
    self.Hooks.RaidFrame_LoadUI.orig()
	self:RunHooks ()
end

WDHooks:Hook("RaidFrame_LoadUI", "RaidLoad")
--]]
