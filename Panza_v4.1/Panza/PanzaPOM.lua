--[[

PanzaPOM.lua
for Panza

Revision 4.0

Panza POM Dialog Panza-Offensive-Module

10-01-06 "for in pairs()" completed for BC

--]]

PA.SealMenu = {}

PA.SealMenu.MaxSeals = 9 -- add more to PASealMenu_MenuFrame if this changes

PA.SealMenu.NumberOfSeals = 0 -- number of seals in the menu

PA.SealMenu.ScalingTime = 0 -- time since last scaling OnUpdate
PA.SealMenu.ScalingUpdateTimer = .1 -- frequency (in seconds) of scaling OnUpdates
PA.SealMenu.FrameToScale = nil -- handle to the frame (_MainFrame or _MenuFrame) being scaled
PA.SealMenu.ScalingWidth = 0 -- width of the frame being scaled

PA.SealMenu.DockingTime = 0 -- time since last docking OnUpdate
PA.SealMenu.DockingUpdateTimer = .25 -- frequency (in seconds) of docking OnUpdates

PA.SealMenu.InventoryTime = 0 -- time since last inventory/bag change
PA.SealMenu.InventoryUpdateTimer = .25 -- time after last inventory/bag change before doing an update

PA.SealMenu.MenuFrameTime = 0 -- time since last MenuFrame OnUpdate
PA.SealMenu.MenuFrameUpdateTimer = .2 -- time before menu disappears after leaving main/menu frames

PA.SealMenu.CooldownCountTime = 0 -- time since last cooldown numbers update
PA.SealMenu.CooldownCountUpdateTimer = 1 -- frequency (in seconds) of updating cooldown numbers
PA.SealMenu.CurrentTime = 0 -- time when a cooldown pass begins


function PA:POM_OnLoad()
	PA.OptionsMenuTree[10] = {Title="Offense", Frame=this, Tooltip="Offensive Options", Filter={Class="PALADIN"}};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end
------------------------
-- Set the POM UI values
------------------------
function PA:POM_SetValues()

	cbxPanzaPOMHSOnlyOnDF:SetChecked(PASettings.Switches.Offense.HSOnlyOnDF==true);
	cbxPanzaPOMHSAlwaysOnDF:SetChecked(PASettings.Switches.Offense.HSAlwaysOnDF==true);
	cbxPanzaPOMHS:SetChecked(PASettings.Switches.Offense.hs==true);
	cbxPanzaPOMEXO:SetChecked(PASettings.Switches.Offense.exo==true);
	cbxPanzaPOMHOW:SetChecked(PASettings.Switches.Offense.how==true);
	cbxPanzaPOMSoC:SetChecked(PASettings.Switches.Offense.soc==true);
	cbxPanzaPOMStunned:SetChecked(PASettings.Switches.Offense.stunned==true);
	cbxPanzaPOMSoR:SetChecked(PASettings.Switches.Offense.sor==true);
	cbxPanzaPOMOffAll:SetChecked(PASettings.Switches.Offense.offall==true);
	cbxPanzaSMPvP:SetChecked(PASettings.SealMenu.IgnorePvP==true);

	cbxPanzaSMShow:SetChecked(PASettings.SealMenu.Visible==true);
	cbxPanzaSMLocked:SetChecked(PASettings.SealMenu.Locked==true);
	cbxPanzaSMKeepOpen:SetChecked(PASettings.SealMenu.KeepOpen==true);
	cbxPanzaSMKeepDocked:SetChecked(PASettings.SealMenu.KeepDocked==true);
	cbxPanzaSMMenuOnShift:SetChecked(PASettings.SealMenu.MenuOnShift==true);
	cbxPanzaSMTooltips:SetChecked(PASettings.SealMenu.Tooltips==true);

	if (PASettings.SealMenu.Text=="top") then
		cbxPanzaSMTextTop:SetChecked(true);
		cbxPanzaSMTextBottom:SetChecked(false);
		cbxPanzaSMTextOff:SetChecked(false);
		PASealMenu_MainFrameNextTextTop:Show();
		PASealMenu_MainFrameNextTextBottom:Hide();
	elseif(PASettings.SealMenu.Text=="bot") then
		cbxPanzaSMTextTop:SetChecked(false);
		cbxPanzaSMTextBottom:SetChecked(true);
		cbxPanzaSMTextOff:SetChecked(false);
		PASealMenu_MainFrameNextTextTop:Hide();
		PASealMenu_MainFrameNextTextBottom:Show();
	else
		cbxPanzaSMTextTop:SetChecked(false);
		cbxPanzaSMTextBottom:SetChecked(false);
		cbxPanzaSMTextOff:SetChecked(true);
		PASealMenu_MainFrameNextTextTop:Hide();
		PASealMenu_MainFrameNextTextBottom:Hide();
	end

end
---------------
-- POM Defaults
---------------
function PA:POM_Defaults()
	PASettings.Switches.Offense = {how=true, hs=true, exo=true, HSOnlyOnDF=true, soc=true, stunned=true, sor=true, offall=false};
	if (PA:SpellInSpellBook("soc")) then
		PASettings.Switches.Offense.Auto = {Seal1="sow", Seal2="soc"};
		PASettings.Switches.Offense.AutoPVP = {Seal1="soc", Seal2="soc"};
	else
		if (PA:SpellInSpellBook("sotc")) then
			PASettings.Switches.Offense.Auto = {Seal1="sotc", Seal2="sor"};
			PASettings.Switches.Offense.AutoPVP = {Seal1="sotc", Seal2="sor"};
		else
			PASettings.Switches.Offense.Auto = {Seal1="sor", Seal2=nil};
			PASettings.Switches.Offense.AutoPVP = {Seal1="sor", Seal2=nil};
		end
	end
	PA:ValidateSeals();
	PA:SealMenu_Defaults();
end


function PA:POM_OnShow()
	PA:Reposition(PanzaPOMFrame, "UIParent", true);
	PanzaPOMFrame:SetAlpha(PASettings.Alpha);
	PA:POM_SetValues();
end

function PA:POM_OnHide()
	-- place holder
end

function PA:POM_btnDone_OnClick()
	PA:FrameToggle(PanzaPOMFrame);
end

function PA:POM_btnRepos_OnClick()
	PA:ReallySetPoint(PASealMenu_MainFrame, "TOPLEFT", "UIParent", "BOTTOMLEFT", 400, 400);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:POM_ShowTooltip(item)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine( PA.POM_Tooltips[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PA.POM_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end



-------------------------
-- SealMenu Functions
-------------------------

function PA:SealMenu_Defaults()
	PASettings.SealMenu = {};
	PASettings.SealMenu.Visible			= true;			-- whether to display the SealMenu

	PASettings.SealMenu.Locked			= false;		-- whether windows can be moved/scaled/rotated
	PASettings.SealMenu.KeepOpen		= false;		-- whether menu hides after use
	PASettings.SealMenu.KeepDocked		= true;			-- whether to keep menu docked at all times
	PASettings.SealMenu.MenuOnShift		= false;		-- whether menu requires Shift to display
	PASettings.SealMenu.IgnorePvP		= false;		-- whether to ignor PvP seals
	PASettings.SealMenu.Tooltips		= true;			-- Display Seal Menu Tooltips.

	PASettings.SealMenu.MainClickSJ		= true;			-- whether clicking on seals causes a SealJudge cycle
	PASettings.SealMenu.CooldownCount	= true;			-- whether to display numerical cooldown counters

	PASettings.SealMenu.MainDock		= "BOTTOMRIGHT";-- corner of main window docked to
	PASettings.SealMenu.MenuDock		= "BOTTOMLEFT";	-- corner menu window is docked from
	PASettings.SealMenu.MainOrient		= "HORIZONTAL";	-- direction of main window
	PASettings.SealMenu.MenuOrient		= "VERTICAL";	-- direction of menu window
	PASettings.SealMenu.MainScale		= 1;			-- scaling of main window
	PASettings.SealMenu.MenuScale		= 1;			-- scaling of menu window

	PASettings.SealMenu.Text			= "top";

	PA:ReallySetPoint(PASealMenu_MainFrame, "TOPLEFT", "UIParent", "BOTTOMLEFT", 400, 400);

end


--[[ Local functions ]]--

-- dock-dependant offset and directions: MainDock..MenuDock
-- x/yoff   = offset MenuFrame is positioned to MainFrame
-- x/ydir   = direction trinkets are added to menu
-- x/ystart = starting offset when building a menu, relativePoint MenuDock
local dock_stats = { ["TOPRIGHTTOPLEFT"] =		 { xoff=-4, yoff=0,  xdir=1,  ydir=-1, xstart=8,   ystart=-8 },
					 ["BOTTOMRIGHTBOTTOMLEFT"] = { xoff=-4, yoff=0,  xdir=1,  ydir=1,  xstart=8,   ystart=44 },
					 ["TOPLEFTTOPRIGHT"] =		 { xoff=4,  yoff=0,  xdir=-1, ydir=-1, xstart=-44, ystart=-8 },
					 ["BOTTOMLEFTBOTTOMRIGHT"] = { xoff=4,  yoff=0,  xdir=-1, ydir=1,  xstart=-44, ystart=44 },
					 ["TOPRIGHTBOTTOMRIGHT"] =   { xoff=0,  yoff=-4, xdir=-1, ydir=1,  xstart=-44,  ystart=44 },
					 ["BOTTOMRIGHTTOPRIGHT"] =   { xoff=0,  yoff=4,	 xdir=-1, ydir=-1, xstart=-44,  ystart=-8 },
					 ["TOPLEFTBOTTOMLEFT"] =	 { xoff=0,  yoff=-4, xdir=1,  ydir=1,  xstart=8,   ystart=44 },
					 ["BOTTOMLEFTTOPLEFT"] =	 { xoff=0,  yoff=4,  xdir=1,  ydir=-1, xstart=8,   ystart=-8 } }

-- returns offset and direction depending on current docking. ie: dock_info("xoff")
local function dock_info(arg1)

	local anchor = PASettings.SealMenu.MainDock..PASettings.SealMenu.MenuDock

	if dock_stats[anchor] and arg1 and dock_stats[anchor][arg1] then
		return dock_stats[anchor][arg1]
	else
		return 0
	end
end

-- hide the docking markers
local function clear_docking()

	local corners,i = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT" }

	for i=1,4 do
		getglobal("PASealMenu_MainDock_"..corners[i]):Hide()
		getglobal("PASealMenu_MenuDock_"..corners[i]):Hide()
	end
end

-- returns true if the two values are close to each other
local function near(arg1,arg2)

    local isnear = false

    if (math.max(arg1,arg2)-math.min(arg1,arg2)) < 15 then
		isnear = true
    end

    return isnear
end

-- returns true if windows unlocked
local function unlocked()
	return PASettings.SealMenu.Locked==false;
end

-- moves the MenuFrame to the dock position against MainFrame
local function dock_windows()

	clear_docking()

	if PASettings.SealMenu.KeepDocked==true then

		PASealMenu_MenuFrame:ClearAllPoints()
		if PASettings.SealMenu.Locked==false then
			PASealMenu_MenuFrame:SetPoint(PASettings.SealMenu.MenuDock,"PASealMenu_MainFrame",PASettings.SealMenu.MainDock,dock_info("xoff"),dock_info("yoff"))
		else
			PASealMenu_MenuFrame:SetPoint(PASettings.SealMenu.MenuDock,"PASealMenu_MainFrame",PASettings.SealMenu.MainDock,dock_info("xoff")*3,dock_info("yoff")*3)
		end
	end
end

-- displays windows vertically or horizontally
local function orient_windows()

	if (PASealMenu_InventoryFrame~=nil) then
		if PASettings.SealMenu.MainOrient=="HORIZONTAL" then
			PASealMenu_MainFrame:SetWidth(90)
			PASealMenu_MainFrame:SetHeight(52)
		else
			PASealMenu_MainFrame:SetWidth(52)
			PASealMenu_MainFrame:SetHeight(90)
		end

		PA.SealMenu.InventoryTime = 10 -- immediate update
		PASealMenu_InventoryFrame:Show();
	end

end


-- redisplay menu cooldowns only if they're on screen
local function update_menu_cooldowns()

	-- set cooldown timers on seals
	local i = 1;
	for Seal, _ in pairs(PA.SpellBook.Seals) do
		Spell = PA.SpellBook[Seal];
		CooldownFrame_SetTimer(getglobal("PASealMenu_Menu"..i.."Cooldown"), GetSpellCooldown(Spell.Index, BOOKTYPE_SPELL));
		i = i + 1;
	end
end

-- update selected seals cooldowns
local function update_cooldowns()
	if (PASettings.SealMenu.Visible==true) then
		local SpellId = PA:GetSpellProperty(PASealMenu_Seal0.Seal, "Index");
		if (SpellId~=nil) then
			CooldownFrame_SetTimer(PASealMenu_Seal0Cooldown, GetSpellCooldown(SpellId, BOOKTYPE_SPELL));
		end
		SpellId = PA:GetSpellProperty(PASealMenu_Seal1.Seal, "Index");
		if (SpellId~=nil) then
			CooldownFrame_SetTimer(PASealMenu_Seal1Cooldown, GetSpellCooldown(SpellId, BOOKTYPE_SPELL));
		end

		if PASealMenu_MenuFrame:IsVisible() and PA.SealMenu.NumberOfSeals>0 then
			update_menu_cooldowns()
		end
	end	
end

-- call this when any action can change the 'Cooldown Numbers'
-- both share the same OnUpdate frame, but either should work independently of other.
local function cooldown_opts_changed()

	local i;

	if (PASettings.SealMenu.CooldownCount==false) then
		PASealMenu_Seal0Time:Hide("");
		PASealMenu_Seal1Time:Hide("");
		for i=1,PA.SealMenu.MaxSeals do
			getglobal("PASealMenu_Menu"..i.."Time"):Hide("");
		end
	else
		PASealMenu_Seal0Time:Show();
		PASealMenu_Seal1Time:Show();
		for i=1,PA.SealMenu.MaxSeals do
			getglobal("PASealMenu_Menu"..i.."Time"):Show();
		end
	end
end


-- build list of seals
function PA:SealMenu_BuildMenu()

	PA.SealMenu.NumberOfSeals = PA:TableSize(PA.SpellBook.Seals);

	if PA.SealMenu.NumberOfSeals<1 then
		-- user has no seals
		PASealMenu_MenuFrame:Hide();
	else
		-- display seals outward from docking point
		local col, row, xpos, ypos = 0, 0, dock_info("xstart"), dock_info("ystart");
		local max_cols = 1;

		if (PA.SealMenu.NumberOfSeals>4) then
			max_cols = 2;
		end

		local i = 1;
		for Seal, Texture in pairs(PA.SpellBook.Seals) do
			local item = getglobal("PASealMenu_Menu"..i);
			item.Seal = Seal;
			getglobal("PASealMenu_Menu"..i.."Icon"):SetTexture(Texture);
			item:SetPoint("TOPLEFT", "PASealMenu_MenuFrame", PASettings.SealMenu.MenuDock, xpos, ypos);

			if PASettings.SealMenu.MenuOrient=="VERTICAL" then
				xpos = xpos + dock_info("xdir")*40;
				col = col + 1;
				if col==max_cols then
					xpos = dock_info("xstart");
					col = 0;
					ypos = ypos + dock_info("ydir")*40;
					row = row + 1;
				end
				item:Show();
			else
				ypos = ypos + dock_info("ydir")*40;
				col = col + 1;
				if col==max_cols then
					ypos = dock_info("ystart");
					col = 0;
					xpos = xpos + dock_info("xdir")*40;
					row = row + 1;
				end
				item:Show();
			end
			i = i + 1;
		end
		for i = PA.SealMenu.NumberOfSeals + 1, PA.SealMenu.MaxSeals do
			getglobal("PASealMenu_Menu"..i):Hide();
		end
		if (col==0) then
			row = row - 1;
		end

		if (PASettings.SealMenu.MenuOrient=="VERTICAL") then
			PASealMenu_MenuFrame:SetWidth(12+(max_cols*40));
			PASealMenu_MenuFrame:SetHeight(12+((row+1)*40));
		else
			PASealMenu_MenuFrame:SetWidth(12+((row+1)*40));
			PASealMenu_MenuFrame:SetHeight(12+(max_cols*40));
		end

		update_menu_cooldowns()
	end

end

-- sets window lock true or false
local function set_lock(arg1)

	PASettings.SealMenu.Locked = arg1;

	if arg1==true then
		PASealMenu_MainFrame:SetBackdropColor(0,0,0,0);
		PASealMenu_MainFrame:SetBackdropBorderColor(0,0,0,0);
		PASealMenu_MainResizeButton:Hide();
		PASealMenu_MenuFrame:SetBackdropColor(0,0,0,0);
		PASealMenu_MenuFrame:SetBackdropBorderColor(0,0,0,0);
		PASealMenu_MenuResizeButton:Hide();
	else
		PASealMenu_MainFrame:SetBackdropColor(1,1,1,1)
		PASealMenu_MainFrame:SetBackdropBorderColor(1,1,1,1);
		PASealMenu_MainResizeButton:Show();
		PASealMenu_MenuFrame:SetBackdropColor(1,1,1,1);
		PASealMenu_MenuFrame:SetBackdropBorderColor(1,1,1,1);
		PASealMenu_MenuResizeButton:Show();
	end
	dock_windows();
end


-- returns the name of the trinket in slot 0 or 1
local function trinket_name(slot)
	local _,_,name = string.find(GetInventoryItemLink("player",tonumber(slot)+13) or "","^.*%[(.*)%].*$");
	return name;
end

function PA:ValidateSeals()
	if (not PA:SpellInSpellBook(PASettings.Switches.Offense.Auto.Seal1)) then
		if (PA:SpellInSpellBook("sotc")) then
			PASettings.Switches.Offense.Auto.Seal1 = "sotc";
			if (PA:SpellInSpellBook("sor")) then
				PASettings.Switches.Offense.Auto.Seal2 = "sor";
			end
		elseif (PA:SpellInSpellBook("sor")) then
			PASettings.Switches.Offense.Auto.Seal1 = "sor";
		else
			PASettings.Switches.Offense.Auto.Seal1 = nil;
		end
	end
	if (not PA:SpellInSpellBook(PASettings.Switches.Offense.Auto.Seal2)) then
		PASettings.Switches.Offense.Auto.Seal2 = nil;
	end
	if (not PA:SpellInSpellBook(PASettings.Switches.Offense.AutoPVP.Seal1)) then
		if (PA:SpellInSpellBook("sotc")) then
			PASettings.Switches.Offense.AutoPVP.Seal1 = "sotc";
			if (PA:SpellInSpellBook("sor")) then
				PASettings.Switches.Offense.AutoPVP.Seal2 = "sor";
			end
		elseif (PA:SpellInSpellBook("sor")) then
			PASettings.Switches.Offense.AutoPVP.Seal1 = "sor";
		else
			PASettings.Switches.Offense.AutoPVP.Seal1 = nil;
		end
	end
	if (not PA:SpellInSpellBook(PASettings.Switches.Offense.AutoPVP.Seal2)) then
		PASettings.Switches.Offense.AutoPVP.Seal2 = nil;
	end
end

-- sets initial display
function PA:InitializeSealMenu()

	PA:ValidateSeals();

	if (PASealMenu_MainFrame~=nil) then
		if PASettings.SealMenu.MainScale then
			PASealMenu_MainFrame:SetScale(PASettings.SealMenu.MainScale);
		end
		if PASettings.SealMenu.MenuScale then
			PASealMenu_MenuFrame:SetScale(PASettings.SealMenu.MenuScale);
		end

		PA:Reposition(PASealMenu_MainFrame, "UIParent", true);
		orient_windows();
		dock_windows();

		if (UnitIsPVP("player") and PASettings.SealMenu.IgnorePvP==false) then
			PASealMenu_Seal0Icon:SetTexture(PA:GetSpellProperty(PASettings.Switches.Offense.AutoPVP.Seal1, "Texture"));
			PASealMenu_Seal1Icon:SetTexture(PA:GetSpellProperty(PASettings.Switches.Offense.AutoPVP.Seal2, "Texture"));
		else
			PASealMenu_Seal0Icon:SetTexture(PA:GetSpellProperty(PASettings.Switches.Offense.Auto.Seal1, "Texture"));
			PASealMenu_Seal1Icon:SetTexture(PA:GetSpellProperty(PASettings.Switches.Offense.Auto.Seal2, "Texture"));
		end

		if PASettings.SealMenu.KeepOpen==true then
			PASealMenu_MenuFrame:Show();
		end

		if (PASettings.SealMenu.Visible==false) then
			PASealMenu_MainFrame:Hide();
			PASealMenu_MenuFrame:Hide();
		end
	end

	cooldown_opts_changed();
end

local function cursor_empty()
	return (not (CursorHasItem() or CursorHasMoney() or CursorHasSpell()));
end


--[[ Window Movement ]]--

function PA:SealMenu_MainFrame_OnMouseUp(arg1)
	if arg1=="LeftButton" then
		update_cooldowns();
		this:StopMovingOrSizing();
	elseif unlocked() then
		if PASettings.SealMenu.MainOrient=="VERTICAL" then
			PASettings.SealMenu.MainOrient = "HORIZONTAL";
		else
			PASettings.SealMenu.MainOrient = "VERTICAL";
		end
		orient_windows();
	end

end

function PA:SealMenu_MainFrame_OnMouseDown(arg1)
	if arg1=="LeftButton" and unlocked() then
		this:StartMoving();
	end
end

--[[ MainFrame and MenuFrame Scaling ]]--

function PA:SealMenu_StartScaling(arg1, item)
	if arg1=="LeftButton" and unlocked() then
		item:LockHighlight();
		PA.SealMenu.FrameToScale = item:GetParent();
		PA.SealMenu.ScalingWidth = item:GetParent():GetWidth();
		PASealMenu_ScalingFrame:Show();
	end
end

function PA:SealMenu_StopScaling(arg1, item)
	if arg1=="LeftButton" then
		PASealMenu_ScalingFrame:Hide();
		PA.SealMenu.FrameToScale = nil;
		item:UnlockHighlight();
		if item:GetParent():GetName() == "PASealMenu_MainFrame" then
			PASettings.SealMenu.MainScale = PASealMenu_MainFrame:GetScale();
		else
			PASettings.SealMenu.MenuScale = PASealMenu_MenuFrame:GetScale();
		end
		update_cooldowns();
	end
end

function PA:SealMenu_ScaleFrame(scale)
	local frame = PA.SealMenu.FrameToScale;
	local oldscale = frame:GetScale() or 1;
	local framex = frame:GetLeft() * oldscale;
	local framey = frame:GetTop() * oldscale;

	if (scale<0.1) then
		scale = 0.1;
	end

	frame:SetScale(scale)
	if frame:GetName() == "PASealMenu_MainFrame" then
		PA:ReallySetPoint(PASealMenu_MainFrame,"TOPLEFT","UIParent","BOTTOMLEFT",framex/scale,framey/scale);
	elseif PASettings.SealMenu.KeepDocked==false then
		PASealMenu_MenuFrame:ClearAllPoints();
		PA:ReallySetPoint(PASealMenu_MenuFrame,"TOPLEFT","UIParent","BOTTOMLEFT",framex/scale,framey/scale);
	end
end

function PA:SealMenu_ScalingFrame_OnUpdate(arg1)
	if (PASettings.SealMenu.Visible==true) then
		PA.SealMenu.ScalingTime = PA.SealMenu.ScalingTime + arg1
		if (PA.SealMenu.ScalingTime > PA.SealMenu.ScalingUpdateTimer) then
			PA.SealMenu.ScalingTime = 0;

			local frame = PA.SealMenu.FrameToScale;
			if (frame~=nil) then
				local oldscale = frame:GetEffectiveScale();
				local framex, cursorx= frame:GetLeft()*oldscale, GetCursorPosition();

				if (cursorx-framex)>32 then
					local newscale = (cursorx-framex)/PA.SealMenu.ScalingWidth;
					PA:SealMenu_ScaleFrame(newscale);
				end
			end
		end
	end
end

--[[ Menu docking ]]--

function PA:SealMenu_MenuFrame_OnMouseUp(arg1)
	if arg1=="LeftButton" then
		update_cooldowns()
		PASealMenu_DockingFrame:Hide()
		PASealMenu_MenuFrame:StopMovingOrSizing()
		if PASettings.SealMenu.KeepDocked==true then
			dock_windows()
		end
		PA.SealMenu.InventoryTime = 1 -- reset time of last update
		PASealMenu_InventoryFrame:Show()
	elseif unlocked() then
		if PASettings.SealMenu.MenuOrient=="VERTICAL" then
			PASettings.SealMenu.MenuOrient="HORIZONTAL"
		else
			PASettings.SealMenu.MenuOrient="VERTICAL"
		end
		orient_windows()
	end
end

function PA:SealMenu_MenuFrame_OnMouseDown(arg1)
	if arg1=="LeftButton" and unlocked() then
		PASealMenu_MenuFrame:StartMoving()

		if PASettings.SealMenu.KeepDocked==true then
			PASealMenu_DockingFrame:Show()
		end
	end
end

function PA:SealMenu_DockingFrame_OnUpdate(arg1)
	if (PASettings.SealMenu.Visible==true and PASealMenu_MainFrame~=nil) then
		PA.SealMenu.DockingTime = PA.SealMenu.DockingTime + arg1;
		if PA.SealMenu.DockingTime > PA.SealMenu.DockingUpdateTimer then
			PA.SealMenu.DockingTime = 0;

			local main = PASealMenu_MainFrame;
			local menu = PASealMenu_MenuFrame;
			local mainscale = PASealMenu_MainFrame:GetScale();
			local menuscale = PASealMenu_MenuFrame:GetScale();

			if near(main:GetRight()*mainscale,menu:GetLeft()*menuscale) then
				if near(main:GetTop()*mainscale,menu:GetTop()*menuscale) then
					PASettings.SealMenu.MainDock = "TOPRIGHT";
					PASettings.SealMenu.MenuDock = "TOPLEFT";
				elseif near(main:GetBottom()*mainscale,menu:GetBottom()*menuscale) then
					PASettings.SealMenu.MainDock = "BOTTOMRIGHT";
					PASettings.SealMenu.MenuDock = "BOTTOMLEFT";
				end
			elseif near(main:GetLeft()*mainscale,menu:GetRight()*menuscale) then
				if near(main:GetTop()*mainscale,menu:GetTop()*menuscale) then
					PASettings.SealMenu.MainDock = "TOPLEFT";
					PASettings.SealMenu.MenuDock = "TOPRIGHT";
				elseif near(main:GetBottom()*mainscale,menu:GetBottom()*menuscale) then
					PASettings.SealMenu.MainDock = "BOTTOMLEFT";
					PASettings.SealMenu.MenuDock = "BOTTOMRIGHT";
				end
			elseif near(main:GetRight()*mainscale,menu:GetRight()*menuscale) then
				if near(main:GetTop()*mainscale,menu:GetBottom()*menuscale) then
					PASettings.SealMenu.MainDock = "TOPRIGHT";
					PASettings.SealMenu.MenuDock = "BOTTOMRIGHT";
				elseif near(main:GetBottom()*mainscale,menu:GetTop()*menuscale) then
					PASettings.SealMenu.MainDock = "BOTTOMRIGHT";
					PASettings.SealMenu.MenuDock = "TOPRIGHT";
				end
			elseif near(main:GetLeft()*mainscale,menu:GetLeft()*menuscale) then
				if near(main:GetTop()*mainscale,menu:GetBottom()*menuscale) then
					PASettings.SealMenu.MainDock = "TOPLEFT";
					PASettings.SealMenu.MenuDock = "BOTTOMLEFT";
				elseif near(main:GetBottom()*mainscale,menu:GetTop()*menuscale) then
					PASettings.SealMenu.MainDock = "BOTTOMLEFT";
					PASettings.SealMenu.MenuDock = "TOPLEFT";
				end
			end

			clear_docking()
			getglobal("PASealMenu_MainDock_"..PASettings.SealMenu.MainDock):Show();
			getglobal("PASealMenu_MenuDock_"..PASettings.SealMenu.MenuDock):Show();

		end
	end
end

--[[ Inventory ]]--

-- after a period of no seal updates since one happens, update
function PA:SealMenu_InventoryFrame_OnUpdate(elapsed)
	if (PASettings.SealMenu.Visible==true) then
		PA.SealMenu.InventoryTime = PA.SealMenu.InventoryTime + elapsed;
		if (PASealMenu_InventoryFrame~=nil and PA.SealMenu.InventoryTime>PA.SealMenu.InventoryUpdateTimer) then
			PASealMenu_InventoryFrame:Hide();
			PA.SealMenu.InventoryTime = 0;

			if (UnitIsPVP("player") and PASettings.SealMenu.IgnorePvP==false) then
				PASealMenu_Seal0.Seal = PASettings.Switches.Offense.AutoPVP.Seal1;
				PASealMenu_Seal1.Seal = PASettings.Switches.Offense.AutoPVP.Seal2;
			else
				PASealMenu_Seal0.Seal = PASettings.Switches.Offense.Auto.Seal1;
				PASealMenu_Seal1.Seal = PASettings.Switches.Offense.Auto.Seal2;
			end
			local t0texture = PA:GetSpellProperty(PASealMenu_Seal0.Seal, "Texture");
			local t1texture = PA:GetSpellProperty(PASealMenu_Seal1.Seal, "Texture");

			--PA:ShowText("t0texture=", t0texture, " t1texture=", t1texture);

			PASealMenu_Seal0Icon:SetTexture(t0texture or "Interface\\PaperDoll\\UI-PaperDoll-Slot-Seal");
			PASealMenu_Seal1Icon:SetTexture(t1texture or "Interface\\PaperDoll\\UI-PaperDoll-Slot-Seal");
			PASealMenu_Seal0:SetChecked(0);
			PASealMenu_Seal1:SetChecked(0);
			PASealMenu_Seal0Icon:SetVertexColor(1,1,1,1);
					
			--Seal2 will only fire if Seal1 produces a buff
			if (PASealMenu_Seal0.Seal~="soc" and PASealMenu_Seal0.Seal~="sor") then
				-- Enable Seal2
				if (PASealMenu_Seal1:IsEnabled()==0) then
					--PA:ShowText("Seal2 enable");
					PASealMenu_Seal1:Enable();
					PASealMenu_Seal1Icon:SetVertexColor(1.0, 1.0, 1.0);
				end
			else
				-- Disable Seal2
				if (PASealMenu_Seal1:IsEnabled()==1) then
					--PA:ShowText("Seal2 disable");
					PASealMenu_Seal1:Disable();
					PASealMenu_Seal1Icon:SetVertexColor(0.4, 0.4, 0.4);
				end
			end
				
			PA.SealMenu.CooldownCountTime = PA.SealMenu.CooldownCountUpdateTimer; -- immediate update of cooldown counters
			update_cooldowns();

			PA:SealMenu_BuildMenu();
			if (t0texture==nil and t1texture==nil and PA.SealMenu.NumberOfSeals<1) then
				-- user has no seal, hide window
				--PA:ShowText("Hiding SealMenu");
				PASealMenu_MainFrame:Hide();
			end
		end
	end
end

--[[ Menu popup ]]--

function PA:SealMenu_ResetMenuTimer()
	PA.SealMenu.MenuFrameTime = 0;
end

function PA:SealMenu_MenuFrame_OnUpdate(arg1)
	if (PASettings.SealMenu.Visible==true and PASealMenu_MainFrame~=nil) then
		PA.SealMenu.MenuFrameTime = PA.SealMenu.MenuFrameTime + arg1
		if (PA.SealMenu.MenuFrameTime>PA.SealMenu.MenuFrameUpdateTimer) then
			PA.SealMenu.MenuFrameTime = 0;
			if (not MouseIsOver(PASealMenu_MainFrame)) and (not MouseIsOver(PASealMenu_MenuFrame)) and (not PASealMenu_ScalingFrame:IsVisible()) and not IsShiftKeyDown() and (PASettings.SealMenu.KeepOpen==false) then
				PASealMenu_MenuFrame:Hide();
			end
		end
	end
end

function PA:SealMenu_ShowMenu()
	if (IsShiftKeyDown() or PASettings.SealMenu.MenuOnShift==false) then
		PA:SealMenu_BuildMenu();
		if PA.SealMenu.NumberOfSeals>0 then
			PA.SealMenu.MenuFrameTime = 0;
			PASealMenu_MenuFrame:Show();
		end
	end
end

function PA:SealMenu_Toggle()

	if (PASealMenu_MainFrame:IsVisible()) then
		PASettings.SealMenu.Visible = false;
		PASealMenu_MainFrame:Hide();
		PASealMenu_MenuFrame:Hide();
	else
		PASettings.SealMenu.Visible = true;
		PASealMenu_MainFrame:Show()
		if (PASettings.SealMenu.KeepOpen==true) then
			PASealMenu_MenuFrame:Show();
		end
	end
end


-- called from Seal0/1's OnClick
function PA:SealMenu_Seal_OnClick(item)
	item:SetChecked(0);
	if (PASettings.SealMenu.MainClickSJ==true) then
		PA:AutoSeal();
	else
		item:SetChecked(0);
		PA:CastSeal(item.Seal, true);
	end
end

-- called from Menu1-9's OnClick
function PA:SealMenu_SwapSeal(arg1, item)

	item:SetChecked(0);

	if (IsControlKeyDown()) then
		PA:CastSeal(item.Seal, true);
	else
		if cursor_empty() then
			if arg1=="LeftButton" then
				if (UnitIsPVP("player") and PASettings.SealMenu.IgnorePvP==false) then
					PASettings.Switches.Offense.AutoPVP.Seal1 = item.Seal;
				else
					PASettings.Switches.Offense.Auto.Seal1 = item.Seal;
				end
				PASealMenu_Seal0Icon:SetVertexColor(0.4, 0.4, 0.4);
			else
				if (UnitIsPVP("player") and PASettings.SealMenu.IgnorePvP==false) then
					PASettings.Switches.Offense.AutoPVP.Seal2 = item.Seal;
				else
					PASettings.Switches.Offense.Auto.Seal2 = item.Seal;
				end
				PASealMenu_Seal1Icon:SetVertexColor(0.4, 0.4, 0.4);
			end
		end
	end

	if (not IsShiftKeyDown() and PASettings.SealMenu.KeepOpen==false) then
		PASealMenu_MenuFrame:Hide();
	end
end

--[[ Tooltips ]]--

function PA:SealMenu_InventoryTooltip(item)
	--if (PA:GetSpellProperty(item.Seal, "Index")~=nil) then
	if (PASettings.SealMenu.Tooltips==true) then
		GameTooltip_SetDefaultAnchor(GameTooltip, item);
		GameTooltip:ClearLines();
		--GameTooltip:SetSpell(PA:GetSpellProperty(item.Seal, "Index"), BOOKTYPE_SPELL);
		GameTooltip:AddLine(PA.POM_Tooltips.SealMenu.tooltip1);
		local TipIndex = 2;
		local TipLine = PA.POM_Tooltips.SealMenu["tooltip"..TipIndex];
		while (TipLine~=nil) do
			GameTooltip:AddLine( TipLine, 1, 1, 1, 1, 1 );
			TipIndex = TipIndex + 1;
			TipLine = PA.POM_Tooltips.SealMenu["tooltip"..TipIndex];
		end
		GameTooltip:Show();
	end
end

function PA:SealMenu_Tooltip(item)
	if (PA:GetSpellProperty(item.Seal, "Index")~=nil) then
		GameTooltip_SetDefaultAnchor(GameTooltip, item);
		GameTooltip:SetSpell(PA:GetSpellProperty(item.Seal, "Index"), BOOKTYPE_SPELL);
		GameTooltip:Show();
	end
end


--[[ Cooldown Counters ]]--


local function format_time(seconds)

	if seconds<60 then
		return math.floor(seconds+.5).." s";
	else
		if seconds < 3600 then
			return math.ceil((seconds/60)).." m";
		else
			return math.ceil((seconds/3600)).." h";
		end
	end

end

local function write_cooldown(where, start, duration)

	local cooldown = duration - (PA.SealMenu.CurrentTime - start)

	--PA:ShowText("write_cooldown start=", start, " duration=", duration, " cooldown=", cooldown);

	if (start==0) then
		where:SetText("");
	elseif (cooldown<3 and not where:GetText()) then
		-- this is a global cooldown. don't display it. not accurate but at least not annoying
	else
		where:SetText(format_time(cooldown));
	end
end

function PA:SealMenu_CooldownCountFrame_OnUpdate(elasped)

	if (PASettings.SealMenu.Visible==true and PASealMenu_MainFrame~=nil) then
		PA.SealMenu.CooldownCountTime = PA.SealMenu.CooldownCountTime + elasped;
		if PA.SealMenu.CooldownCountTime > PA.SealMenu.CooldownCountUpdateTimer then
			-- update cooldowns
			PA.SealMenu.CooldownCountTime = 0

			if (_Paladin_is_Ready==true and PASettings.SealMenu.CooldownCount==true) then

				local i,start,duration;
				PA.SealMenu.CurrentTime = GetTime();

				if PASealMenu_MainFrame:IsVisible() then
					local SpellId = PA:GetSpellProperty(PASealMenu_Seal0.Seal, "Index");
					if (SpellId~=nil) then
						write_cooldown(PASealMenu_Seal0Time, GetSpellCooldown(SpellId, BOOKTYPE_SPELL));
					end
					SpellId = PA:GetSpellProperty(PASealMenu_Seal1.Seal, "Index");
					if (SpellId~=nil) then
						write_cooldown(PASealMenu_Seal1Time, GetSpellCooldown(SpellId, BOOKTYPE_SPELL));
					end
				end

				if (PASealMenu_MenuFrame:IsVisible()) then
					local i = 1;
					for Seal, _ in pairs(PA.SpellBook.Seals) do
						Spell = PA.SpellBook[Seal];
						write_cooldown(getglobal("PASealMenu_Menu"..i.."Time"), GetSpellCooldown(Spell.Index, BOOKTYPE_SPELL));
						i = i + 1;
					end
				end
			end
		end
	end
end

function PA:SealMenu_CooldownCountFrame_OnHide()

	local i

	PASealMenu_Seal0Time:SetText("");
	PASealMenu_Seal1Time:SetText("");

	for i=1,PA.SealMenu.MaxSeals do
		getglobal("PASealMenu_Menu"..i.."Time"):SetText("");
	end
end

