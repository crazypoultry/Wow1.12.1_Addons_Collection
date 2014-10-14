--[[ 
GatherSage by Dsanai of Whisperwind
Adds skill-level and other information to gathering item tooltips.

Thanks go to EasyUnlock for portions of code that were borrowed and modified to work with Herbalism and Mining. For chests and lockboxes, get EasyUnlock! The code for notifying on skill changes was borrowed from TrainerSkills; again, a mod worth getting.

PATCH NOTES

v11200-1 [UNRELEASED]
-- French translation added (courtesy Abysse from Kael'thas)

v11100-2
-- Tells you what things you can mine/pick as your skill increases.
-- Split the localization files so translations can be provided more easily.

v11100-1
-- Initial Release.

]]--

local initdone = nil;
local character = "";
local realmName = "";

function GatherSage_OnLoad()		
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SKILL_LINES_CHANGED");
end

function GatherSage_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		character = UnitName("player");
		realmName = GetCVar("realmName");
		if (not GatherSageDB) then
			GatherSageDB = {};
		end
		if (not GatherSageDB[realmName]) then
			GatherSageDB[realmName] = {};
		end
		if (not GatherSageDB[realmName][character]) then
			GatherSageDB[realmName][character] = {
				[gsMINING] = 0,
				[gsHERBING] = 0
			};
		end
		initDone = true;
	elseif ( event == "SKILL_LINES_CHANGED" ) then
		if ( not arg1 and initDone ) then
			GatherSage_UpdateSkills();
		end
	end
end

function GatherSage_UpdateSkills()
	local numSkills = GetNumSkillLines();
	local myCraftSkills = {};
	
	for i = 1, numSkills, 1 do
		local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);

		if ( not header and skillName ) then
			myCraftSkills[skillName] = skillRank;
		end

	end
	
	if (myCraftSkills[gsMINING]) then
		for mineType in gsMine do
			if (gsMine[mineType]["baseskill"]==myCraftSkills[gsMINING]) then
				if (GatherSageDB[realmName][character][gsMINING] < myCraftSkills[gsMINING]) then -- Only do it once per skill level shift
					GatherSage_Print("You can now mine "..mineType..".");
				end
			end
		end
		GatherSageDB[realmName][character][gsMINING] = myCraftSkills[gsMINING];
	end
	if (myCraftSkills[gsHERBING]) then
		for herbType in gsHerb do
			if (gsHerb[herbType]["baseskill"]==myCraftSkills[gsHERBING]) then
				if (GatherSageDB[realmName][character][gsHERBING] < myCraftSkills[gsHERBING]) then -- Only do it once per skill level shift
					GatherSage_Print("You can now pick "..herbType..".");
				end
			end
		end
		GatherSageDB[realmName][character][gsHERBING] = myCraftSkills[gsHERBING];
	end
	
end

function GatherSage_AddTooltipInfo(frame, itemname)
    if (gsMine[itemname]) then
        local levelreq;
        if(gsMine[itemname]["baseskill"] == 0) then
            levelreq = "?";
        else
            levelreq = gsMine[itemname]["baseskill"];
        end
        local myskilllevel = GatherSage_GetLevel("mining");
        local reqmsg = " ("..levelreq..")";
				local ttLine1 = getglobal(frame:GetName().."TextLeft1"):GetText()
				local ttLine2 = getglobal(frame:GetName().."TextLeft2"):GetText()
				local r,g,b,a = getglobal(frame:GetName().."TextLeft2"):GetTextColor()
				frame:ClearLines();
        if(levelreq == "?") then
					frame:SetText(ttLine1,1,0.5,0,1,true);
        elseif(levelreq <= myskilllevel) then
					frame:SetText(ttLine1,0,1,0,1,true);
				else
					frame:SetText(ttLine1,1,0,0,1,true);
				end
				--frame:SetText(ttLine1,1,1,1,1,true);
        frame:AppendText(reqmsg);
				if ttLine2 then
					frame:AddLine(ttLine2,r,g,b,a);
					frame:SetHeight(frame:GetHeight() + 14);
				end
				if (gsMineHasStone[itemname]) then
					local myminehasstone = "Chance of: "..gsMineHasStone[itemname];
					frame:AddLine(myminehasstone,1,1,1);
					frame:SetHeight(frame:GetHeight() + 14);
					local setwidthnumber = ceil(strlen(myminehasstone)*7.5);
					if (frame:GetWidth() < setwidthnumber) then frame:SetWidth(setwidthnumber); end
				end
		elseif (gsHerb[itemname]) then
        local levelreq;
        if(gsHerb[itemname]["baseskill"] == 0) then
            levelreq = "?";
        else
            levelreq = gsHerb[itemname]["baseskill"];
        end
        local myskilllevel = GatherSage_GetLevel("herbing");
        local reqmsg = " ("..levelreq..")";
				local ttLine1 = getglobal(frame:GetName().."TextLeft1"):GetText()
				local ttLine2 = getglobal(frame:GetName().."TextLeft2"):GetText()
				local r,g,b,a = getglobal(frame:GetName().."TextLeft2"):GetTextColor()
				frame:ClearLines();
        if(levelreq == "?") then
					frame:SetText(ttLine1,1,0.5,0,1,true);
        elseif(levelreq <= myskilllevel) then
					frame:SetText(ttLine1,0,1,0,1,true);
				else
					frame:SetText(ttLine1,1,0,0,1,true);
				end
				--frame:SetText(ttLine1,1,1,1,1,true);
        frame:AppendText(reqmsg);
				if ttLine2 then
					frame:AddLine(ttLine2,r,g,b,a);
					frame:SetHeight(frame:GetHeight() + 14);
				end
				if (gsHerbHasHerb[itemname]) then
					local myherbhasherb = "Chance of: "..gsHerbHasHerb[itemname];
					frame:AddLine(myherbhasherb,1,1,1);
					frame:SetHeight(frame:GetHeight() + 14);
					local setwidthnumber = ceil(strlen(myherbhasherb)*7.5);
					if (frame:GetWidth() < setwidthnumber) then frame:SetWidth(setwidthnumber); end
				end
    end
end
-- Resize
--frame:SetHeight(frame:GetHeight() + 14);
--frame:SetWidth(frame:GetWidth());

function GatherSage_Tooltip_OnShow()
    local parentFrame = this:GetParent();
    local parentFrameName = parentFrame:GetName();
    local itemName = getglobal(parentFrameName.."TextLeft1"):GetText()
    GatherSage_AddTooltipInfo(parentFrame, itemName);
end

function GatherSage_GetLevel(skilltype)
	if (skilltype=="mining" or skilltype=="herbing") then
    local numskills = GetNumSkillLines();
    for i=1,numskills do
        local skillname, _, _, skillrank = GetSkillLineInfo(i);
        if (skillname == gsMINING and skilltype=="mining") then
          return skillrank;
				elseif (skillname == gsHERBING and skilltype=="herbing") then
          return skillrank;
        end     
    end
    return 0;  -- Return 0 if no mining skill was found
	else
		return 0;
	end
end

function GatherSage_Print(text)
	if (text) then DEFAULT_CHAT_FRAME:AddMessage("|cff5e9ae4GatherSage"..FONT_COLOR_CODE_CLOSE..": "..text); end
end
