local IsQuickClickKeyDown = IsControlKeyDown;
local MouseButton = "LeftButton";
local BlizzardFrames = {"PlayerFrame","PetFrame","TargetFrame","TargetofTarget","PartyMemberFrame","PartyMemberPetFrame"};
QuickClick_OldOnClick = {};

--[ Click event handlers ]--

local function QuickClick(button,unit)
    if IsQuickClickKeyDown() and button == MouseButton then 
        QuickHeal(unit);
        return true;
    else return false end
end

-- PlayerFrame
function QuickClick_PlayerFrame_OnClick(button)
    if not QuickClick(button,this.unit) then QuickClick_OldOnClick.PlayerFrame(button) end
end
-- PetFrame
function QuickClick_PetFrame_OnClick(button)
    if not QuickClick(button,this.unit) then QuickClick_OldOnClick.PetFrame(button) end
end
-- TargetFrame
function QuickClick_TargetFrame_OnClick(button)
    if not QuickClick(button,this.unit) then QuickClick_OldOnClick.TargetFrame(button) end
end
-- TargetofTarget
function QuickClick_TargetofTarget_OnClick(button)
    if not QuickClick(button,this.unit) then QuickClick_OldOnClick.TargetofTarget(button) end
end
-- PartyMemberFrame
function QuickClick_PartyMemberFrame_OnClick(partyFrame)
    if not QuickClick(arg1,this.unit) then QuickClick_OldOnClick.PartyMemberFrame(partyFrame) end
end
-- PartyMemberPetFrame
function QuickClick_PartyMemberPetFrame_OnClick()
    if not QuickClick(arg1,this.unit) then QuickClick_OldOnClick.PartyMemberPetFrame() end
end

--[[ Loading and Unloading ]]--

function QuickClick_Load()
    -- Hook all Blizzard provided player frames
    for i,v in ipairs(BlizzardFrames) do
        loadstring("if type("..v.."_OnClick) == \"function\" then QuickClick_OldOnClick."..v..","..v.."_OnClick = "..v.."_OnClick,QuickClick_"..v.."_OnClick end")();
    end

    -- Hook CT_RA_CustomOnClickFunction
    QuickClick_OldOnClick.CT_RA_CustomOnClickFunction,CT_RA_CustomOnClickFunction = CT_RA_CustomOnClickFunction,QuickClick;

    -- Hook EasyRaid
    if IsAddOnLoaded("EasyRaid") then
        if (type(ER_RaidPulloutButton_OnClick) == "function") and (type(ER_MainTankButton_OnClick) == "function") then
            QuickClick_OldOnClick.ER_RaidPulloutButton,ER_RaidPulloutButton_OnClick = ER_RaidPulloutButton_OnClick,function() if not QuickClick(arg1, this.unit or this:GetParent().unit) then QuickClick_OldOnClick.ER_RaidPulloutButton() end end;
            QuickClick_OldOnClick.ER_MainTankButton,ER_MainTankButton_OnClick = ER_MainTankButton_OnClick,function() if not QuickClick(arg1, this.unit or this:GetParent().unit) then QuickClick_OldOnClick.ER_MainTankButton() end end;
        end
    end

    -- Hook Perl Classic Unit Frames and X-Perl
    QuickClick_OldOnClick.Perl_Custom_ClickFunction,Perl_Custom_ClickFunction = Perl_Custom_ClickFunction,QuickClick;

    -- Hook Discord Unit Frames
    if IsAddOnLoaded("DiscordUnitFrames") then
        if (type(DUF_UnitFrame_OnClick) == "function") and (type(DUF_Element_OnClick) == "function") then
            QuickClick_OldOnClick.DUF_UnitFrame,DUF_UnitFrame_OnClick = DUF_UnitFrame_OnClick,function(button) if not QuickClick(button, this.unit) then QuickClick_OldOnClick.DUF_UnitFrame(button) end end;
            QuickClick_OldOnClick.DUF_Element,DUF_Element_OnClick = DUF_Element_OnClick,function(button) if not QuickClick(button, this.unit or this:GetParent().unit) then QuickClick_OldOnClick.DUF_Element(button) end end;
        end
    end

    -- Hook sRaidFrames
    QuickClick_OldOnClick.sRaidFramesCustomOnClickFunction,sRaidFramesCustomOnClickFunction = sRaidFramesCustomOnClickFunction,QuickClick;

    -- Hook PerfectRaid
    QuickClick_OldOnClick.PerfectRaidCustomClick,PerfectRaidCustomClick = PerfectRaidCustomClick,QuickClick;

    -- Hook Squishy 
    QuickClick_OldOnClick.SquishyCustomClick,SquishyCustomClick = SquishyCustomClick,QuickClick;

    -- Hook oRA2 Main Tank Frames
    QuickClick_OldOnClick.oRA_MainTankFramesCustomClick,oRA_MainTankFramesCustomClick = oRA_MainTankFramesCustomClick,QuickClick;
end

function QuickClick_Unload()
    -- Unhook all Blizzard provided player frames
    for i,v in ipairs(BlizzardFrames) do
        loadstring("if type(QuickClick_OldOnClick."..v..") == \"function\" then "..v.."_OnClick = QuickClick_OldOnClick."..v.." end")();
    end

    -- Unhook CT_RA_CustomOnClickFunction
    CT_RA_CustomOnClickFunction = QuickClick_OldOnClick.CT_RA_CustomOnClickFunction;

    -- Unhook EasyRaid
    if IsAddOnLoaded("EasyRaid") then
        if (type(QuickClick_OldOnClick.ER_RaidPulloutButton) == "function") and (type(QuickClick_OldOnClick.ER_MainTankButton) == "function") then
            ER_RaidPulloutButton_OnClick = QuickClick_OldOnClick.ER_RaidPulloutButton;
            ER_MainTankButton_OnClick = QuickClick_OldOnClick.ER_MainTankButton;
        end
    end

    -- Unhook Perl Classic Unit Frames and X-Perl
    Perl_Custom_ClickFunction = QuickClick_OldOnClick.Perl_Custom_ClickFunction;

    -- Unhook Discord Unit Frames
    if IsAddOnLoaded("DiscordUnitFrames") then
        if (type(QuickClick_OldOnClick.DUF_UnitFrame) == "function") and (type(QuickClick_OldOnClick.DUF_Element) == "function") then
            DUF_UnitFrame_OnClick = QuickClick_OldOnClick.DUF_UnitFrame;
            DUF_Element_OnClick = QuickClick_OldOnClick.DUF_Element;
        end
    end

    -- Unhook sRaidFrames
    sRaidFramesCustomOnClickFunction = QuickClick_OldOnClick.sRaidFramesCustomOnClickFunction;

    -- Unhook PerfectRaid
    PerfectRaidCustomClick = QuickClick_OldOnClick.PerfectRaidCustomClick;

    -- Unhook Squishy
    SquishyCustomClick = QuickClick_OldOnClick.SquishyCustomClick;

    -- Unhook oRA2 Main Tank Frames
    oRA_MainTankFramesCustomClick = QuickClick_OldOnClick.oRA_MainTankFramesCustomClick;

    QuickClick_OldOnClick = {};
end


