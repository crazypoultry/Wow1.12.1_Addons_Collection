--[[ 

PanzaPCS.lua
Panza Class Selection Dialog 
Revision 4.0

]]
       
function PA:PCS_OnLoad()
	PA.OptionsMenuTree[13] = {Title="Class Selection", Frame=this, Tooltip="Class Selection Options"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

-- Class order on-screen
function PA:SetupPCS()
	PA.PCSClassIndex = {"DRUID", "HUNTER", "MAGE", PA["HybridClass"], "PRIEST", "ROGUE", "WARLOCK", "WARRIOR"};
end

function PA:PCS_SetValues()
	for i = 1, 8 do
		local ClassSelect = PASettings.Switches.ClassSelect[PA.PCSClassIndex[i]];
		getglobal("cbxPanzaPCS"..i):SetChecked(ClassSelect["Enabled"]==true);
		getglobal("cbxPanzaPCS"..i.."Heal"):SetChecked(ClassSelect["Heal"]==true);
		getglobal("cbxPanzaPCS"..i.."Bless"):SetChecked(ClassSelect["Bless"]==true);
		getglobal("cbxPanzaPCS"..i.."Cure"):SetChecked(ClassSelect["Cure"]==true);
		getglobal("cbxPanzaPCS"..i.."Free"):SetChecked(ClassSelect["Free"]==true);
		getglobal("cbxPanzaPCS"..i.."Panic"):SetChecked(ClassSelect["Panic"]==true);
	end									
	cbxPanzaPCSRaid:SetChecked(PASettings.Switches.ClassSelect.Raid==true);
	cbxPanzaPCSParty:SetChecked(PASettings.Switches.ClassSelect.Party==true);
	cbxPanzaPCSBG:SetChecked(PASettings.Switches.ClassSelect.BG==true);
end

---------------
-- PCS Defaults
---------------
function PA:PCS_Defaults()
	PASettings.Switches.ClassSelect = {};
	for i = 1, 8 do
		PASettings.Switches.ClassSelect[PA.ClassIndex[i]] = {Enabled=true, Heal=true, Bless=true, Cure=true, Free=true, Panic=true};
	end
	PASettings.Switches.ClassSelect["Party"]	= false;
	PASettings.Switches.ClassSelect["BG"] 		= false;
	PASettings.Switches.ClassSelect["Raid"] 	= true;
end

function PA:PCS_OnShow()
	PA:Reposition(PanzaPCSFrame, "UIParent", true);
	PanzaPCSFrame:SetAlpha(PASettings.Alpha);
	PA:PCS_SetValues();
end

function PA:PCS_OnHide()
	-- place holder
end

function PA:PCS_btnDone_OnClick()
	HideUIPanel(PanzaPCSFrame);
end

--------------------------------------
-- Dynamic Tooltip Function
--------------------------------------
function PA:PCS_ShowDynTooltip(item, class)		
	PA:PCS_DisplayTootip(item, "Class Selctions for "..PA:Capitalize(PA.ClassName[class]));
end

function PA:PCS_RaidTootip(item)
	local Txt;
	local Members = GetNumRaidMembers();
	if (Members > 1) then
		Txt = format("Active Raid with %.0f Members.", Members);
	else
		Txt = "Raid is not Active.";
	end
	PA:PCS_DisplayTootip(item, "Enable/Disable for raid (excludes Party and BG):\n"..Txt);
end

function PA:PCS_PartyTootip(item)
	PA:PCS_DisplayTootip(item, "Enable/Disable for party.");
end

function PA:PCS_BGTootip(item)
	local Txt;
	local IsIn, BGName = PA:IsInBG();
	if (IsIn) then
		Txt = "Currently in "..BATTLEFIELD_NAME..BGName;
	else
		Txt = "Currently not in a Battleground.";
	end
	PA:PCS_DisplayTootip(item, "Enable/Disable for Battleground (excludes Party):\n"..Txt);
end

function PA:PCS_DisplayTootip(item, text)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine(text);
	GameTooltip:Show();
end

function PA:SetPCSFlag(switchType)
	PASettings.Switches.ClassSelect[switchType] = (not PASettings.Switches.ClassSelect[switchType]);
end

-------------------------------------------------------------------------------------------------
-- Toggle the Status of a Class Selection for Class, Blessings, Healing, Curing, Freeing or Panic
-------------------------------------------------------------------------------------------------
function PA:SetClassSelection(class, setting)

	------------------
	-- Check Arguments
	------------------
	if (class==nil) then
		PA:Message("Invalid call to PA:SetClassSelection class is nil");
		return;
	end 
	if (PASettings.Switches.ClassSelect[class][setting]==nil) then
		PA:Message("Invalid call to PA:SetClassSelection("..classid..","..setting..")");
		return;
	end 

	-----------------------------------
	-- Make changes to setting supplied
	-----------------------------------
	PASettings.Switches.ClassSelect[class][setting] = (not PASettings.Switches.ClassSelect[class][setting]);

	if (not PASettings.Switches.ClassSelect[class].Enabled) then
		PASettings.Switches.ClassSelect[class].Heal  = false;
		PASettings.Switches.ClassSelect[class].Bless = false;
		PASettings.Switches.ClassSelect[class].Cure  = false;
		PASettings.Switches.ClassSelect[class].Free  = false;
		PASettings.Switches.ClassSelect[class].Panic = false;

	elseif (setting == "Enabled" and PASettings.Switches.ClassSelect[class].Enabled) then
		PASettings.Switches.ClassSelect[class].Heal  = true;
		PASettings.Switches.ClassSelect[class].Bless = true;
		PASettings.Switches.ClassSelect[class].Cure  = true;
		PASettings.Switches.ClassSelect[class].Free  = true;
		PASettings.Switches.ClassSelect[class].Panic = true;
	end

	if(PanzaPCSFrame:IsVisible()) then
		PA:PCS_SetValues();
	end
end
