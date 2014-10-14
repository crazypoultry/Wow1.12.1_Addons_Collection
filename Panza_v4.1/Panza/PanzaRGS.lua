--[[ 

PanzaRGS.lua
Panza Raid Group Selection Dialog 
Revision 4.0

]]

       
function PA:RGS_OnLoad()
	PA.OptionsMenuTree[12] = {Title="Raid Group Selection", Frame=this, Tooltip="Raid Group Selection"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

-------------------------------------------------------------------------------------
-- 3.0 PA RGS Defaults Button Handler for PanzaRGSFrame
-------------------------------------------------------------------------------------
function PA:RGS_Defaults()
	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4(PANZA_RGS_ENTERRESET)
	end
	-- Raid Group Settings
	---------------------------------------
	PASettings["RaidGrp"]		= {};
	for i = 1, PANZA_MAX_RAID/PANZA_MAX_PARTY do
		PASettings.RaidGrp[i]	= {Enabled=true,Heal=true,Bless=true,Cure=true,Free=true,Panic=true};
	end
	if (PanzaRGSFrame:IsVisible()) then
		PA:RGS_SetValues()
	end
	if (PA:CheckMessageLevel("Core",1)) then
		PA:Message4(PANZA_RGS_RESET)
	end
end


function PA:RGS_SetValues()
	local members,i=0,0;

	members = GetNumRaidMembers();

	if (members > 1) then
		txt = format("Active Raid with %.0f Members.", members);
		txtPanzaRGSL1:SetText(txt);
	else
		txtPanzaRGSL1:SetText("Raid is not Active.");
	end

	for i=1, PANZA_MAX_RAID/PANZA_MAX_PARTY do
	
		getglobal("cbxPanzaRGS"..i):SetChecked(PA:RaidGroupStatus(i,"Enabled") == true);
		getglobal("cbxPanzaRGS"..i.."Heal"):SetChecked(PA:RaidGroupStatus(i,"Heal") == true);
		getglobal("cbxPanzaRGS"..i.."Bless"):SetChecked(PA:RaidGroupStatus(i,"Bless") == true);
		getglobal("cbxPanzaRGS"..i.."Cure"):SetChecked(PA:RaidGroupStatus(i,"Cure") == true)
		getglobal("cbxPanzaRGS"..i.."Free"):SetChecked(PA:RaidGroupStatus(i,"Free") == true)
		getglobal("cbxPanzaRGS"..i.."Panic"):SetChecked(PA:RaidGroupStatus(i,"Panic") == true)
		--[[ Old design had 40 checkboxes. 

		for j=1, PANZA_MAX_PARTY do

			getglobal("cbxPanzaRGS"..i.."M"..j):SetChecked(PASettings.Raid[((i-1)*j)+j] == true);
		end			

		]]	
	end									
end


function PA:RGS_OnShow()
	PA:Reposition(PanzaRGSFrame, "UIParent", true);
	PanzaRGSFrame:SetAlpha(PASettings.Alpha);
	PA:RGS_SetValues();
end

function PA:RGS_OnHide()
	-- place holder
end

function PA:RGS_btnDone_OnClick()

	HideUIPanel(PanzaRGSFrame);
end


--------------------------------------
-- Dynamic Tooltip Function
--------------------------------------
function PA:RGS_ShowDynTooltip(item, groupid)
	local txt, name, rank, subgroup, level, class, filename, zone, zonetxt, online, isDead, status;

	local PartyTxt	= {};
			
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);		

	if (PA:IsInRaid()) then
	
		count = 0;
		for i = 1, PANZA_MAX_RAID do
			name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if (subgroup == groupid) then

				if (not count) then
					count = 1;
				else
					count = count + 1;
				end

				---------------------------------
				-- Check for Leader and Assistant
				---------------------------------
				if (rank == 2 and name) then
					name = format("%s(L)%s%s",PA_WHITE,PA_BLUE,name);
				elseif (rank == 1 and name) then
					name = format("%s(A)%s%s",PA_WHITE,PA_BLUE,name);
				end

				---------------------------------------------
				-- format green text for alive, grey for dead
				---------------------------------------------
				if (isDead) then
					status = format("%s%s",PA_GREY,"Dead");
				else
					status = format("%s%s",PA_GREN,"Alive");
				end

				--------------------------------------------------------
				-- Sometimes zone returns nil so grey unknown (nil) zone
				--------------------------------------------------------
				if (not zone) then 
					zonetxt=format("%sUnknown",PA_GREY);
				else
					zonetxt=format("%s%s",PA_GREN, zone); 
				end

				------------------------------
				-- If name was found format it
				------------------------------
				if (name and level and class) then
					txt1 = format("%s%s %s %s", PA_BLUE, name, level, class);
									
					PartyTxt[count] = txt1;

					count = count + 1;
					
					-----------------------------------
					-- Now Format the Zone and Lifesign
					-----------------------------------
					if (zone and status) then
						txt2 = format("%sZone: %s %sStatus: %s", PA_WHITE, zonetxt, PA_WHITE, status);
					else
						txt2 = format("%sZone: %sUnavailabe %sStatus: %sUnavailable",PA_WHITE, PA_GREY, PA_WHITE, PA_GREY);
					end

					PartyTxt[count] = txt2;

				-----------------------------------------------------------
				-- Enpty records with group Ids are common. do not add them
				-----------------------------------------------------------
				else
					if (count > 1) then
						count = count - 1;
					else
						count = 1;
					end
				end
			end
		end
	
		--------------------
		-- Display the Title
		--------------------
		if (count > 2) then
			GameTooltip:AddLine("Raid Group "..groupid.." - ".. format("%.0f", (count/2)) .." Members.");
		else
			GameTooltip:AddLine("Raid Group "..groupid);
		end
			
		-----------------------------------------------------------------------
		-- Display members and locations and status 2 (actual) lines per member
		-----------------------------------------------------------------------
		for i = 1, count do		
			GameTooltip:AddLine(PartyTxt[i],1,1,1,1,1 );
		end

		if (count == 0) then
			GameTooltip:AddLine("No Raid members are in group "..groupid..".",1,1,1,1,1);
		end
		

	else
		GameTooltip:AddLine("Raid Group "..groupid);
	
 		GameTooltip:AddLine("Raid is not Active", 1, 1, 1, 1, 1 );
		GameTooltip:AddLine("Join a Raid to use these features.", 1, 1, 1, 1, 1 );
	end
		
	GameTooltip:Show();
end

--------------------------------------------------
-- 1.31 Return the Status for Raid Group Blessings
--------------------------------------------------
function PA:RaidSettingsStatus()
	if (PA:IsInRaid())	then
		for i = 1, PANZA_MAX_RAID do
			if (UnitExists("raid"..i)) then
				local UName = PA:UnitName("raid"..i);
				if (UName~="target") then
					if (PASettings.Raid[i]) then
						PA:Message(UName.." will be interacted with.");
					else
						PA:Message(UName.." will not be interacted with.");
					end
				end
			end
		end
	else
		PA:Message("You must part of a Raid to utilize this feature.");
	end
end

-----------------------------------------------------------------------------------------------
-- 3.00 Return the Status of a Raid Group for Group, Blessings, Healing, Curing, Free, or Panic
-----------------------------------------------------------------------------------------------

function PA:RaidGroupStatus(groupid, setting)

	if (PASettings.RaidGrp[groupid].Enabled) then
		return (PASettings.RaidGrp[groupid][setting]);
	else 
		return false;
	end
end

----------------------------------------------------------------------------------------------
-- 3.0 Toggle the Status of a Raid Group for Group, Blessings, Healing, Curing, Free, or Panic
----------------------------------------------------------------------------------------------
function PA:SetRaidGroupStatus(groupid, setting)

	------------------
	-- Check Arguments
	------------------
	if (not groupid) then
		PA:Message("Invalid call to PA:SetRaidGroupStatus(groupid,setting) with nil groupid argument.");
		return;
	end
	if (groupid < 1 or groupid > (PANZA_MAX_RAID/PANZA_MAX_PARTY)) then
		PA:Message("Invalid call to PA:SetRaidGroupStatus(groupid,setting) with groupid="..groupid..". Allowed is 1-".. (PANZA_MAX_RAID/PANZA_MAX_PARTY) ..".");
		return;
	end
	if (not setting) then
		PA:Message("Invalid call to PA:SetRaidGroupStatus(groupid,setting) will nil setting argument.");
		return;
	end
	if (PASettings.RaidGrp[groupid][setting]==nil) then
		PA:Message("Invalid call to PA:SetRaidGroupStatu("..groupid..","..setting..")");
		return;
	end 

	-----------------------------------
	-- Make changes to setting supplied
	-----------------------------------
	PASettings.RaidGrp[groupid][setting] = not PASettings.RaidGrp[groupid][setting];

	if (not PASettings.RaidGrp[groupid].Enabled) then
		PASettings.RaidGrp[groupid].Heal  = false;
		PASettings.RaidGrp[groupid].Bless = false;
		PASettings.RaidGrp[groupid].Cure  = false;
		PASettings.RaidGrp[groupid].Free  = false;
		PASettings.RaidGrp[groupid].Panic = false;

	elseif (setting == "Enabled" and PASettings.RaidGrp[groupid].Enabled) then
		PASettings.RaidGrp[groupid].Heal  = true;
		PASettings.RaidGrp[groupid].Bless = true;
		PASettings.RaidGrp[groupid].Cure  = true;
		PASettings.RaidGrp[groupid].Free  = true;
		PASettings.RaidGrp[groupid].Panic = true;
	end

	if(PanzaRGSFrame:IsVisible()) then
		PA:RGS_SetValues();
	end
end
