--[[
    - Talent Text Link

    - Makes it possible to link talent descriptions in chat.

    - Version: 1.23

    - Copyright © 2005, Viper (http://www.viper.dk/WoW/)
]]


---- Register global variables ----
TALENTTEXTLINK_VERSION = "1.23";

local oldTalentFrameTalent_OnClick;


function TalentTextLink_OnLoad()
  TalentFrame_LoadUI();
  this:RegisterEvent("VARIABLES_LOADED");
end


function TalentTextLink_OnEvent(event) 
  if (event == "VARIABLES_LOADED") then
    if (VipersAddonsLoaded) then
      local tablePos = table.getn(VipersAddonsLoaded)+1;
      VipersAddonsLoaded[tablePos] = {};
      VipersAddonsLoaded[tablePos]["NAME"] = "Talent Text Link";
      VipersAddonsLoaded[tablePos]["VERSION"] = TALENTTEXTLINK_VERSION;
      VipersAddonsLoaded[tablePos]["OPTIONSFRAME"] = nil;
    end

    -- Hook the new function instead of the old.
    ttlTalentFrameTalent_OnClick = TalentFrameTalent_OnClick;
    TalentFrameTalent_OnClick = TalentTextLink_TalentFrameTalent_OnClick;

    if ((not VipersAddonsSettings) or ((VipersAddonsSettings) and (not VipersAddonsSettings["SURPRESSLOADMSG"])) and (DEFAULT_CHAT_FRAME)) then
      DEFAULT_CHAT_FRAME:AddMessage("|cffffffff- |cff00f100Viper's Talent Text Link is loaded (version "..TALENTTEXTLINK_VERSION..").");
    end
  end
end


function TalentTextLink_TalentFrameTalent_OnClick()
  if ((IsShiftKeyDown()) and (GameTooltip:IsShown())) then
    local temp, talentFrame, talentName, talentRank, talentDescription, talentDescriptionTmp, talentDescription1, talentDescription2, talentAttributes, talentNextRank, talentNextDescription, chatFrame, chatType, frameOffset;
    for i = 1, GameTooltip:NumLines() do
      talentFrame = getglobal("GameTooltipTextLeft"..i);
      temp = talentFrame:GetText();
      if (i == 1) then
        talentName = temp;
      else
        if ((not string.find(strlower(temp), "requires")) and (not string.find(strlower(temp), "tools"))) then
          if (((string.find(strlower(temp), "instant")) or (string.find(strlower(temp), "channeled")) or (string.find(strlower(temp), "sec cast"))) and (strlen(temp) < 16)) then
            talentAttributes = temp;
            if (getglobal("GameTooltipTextRight"..i):GetText()) then
              talentAttributes = talentAttributes.." - "..getglobal("GameTooltipTextRight"..i):GetText();
            end
          elseif ((string.find(strlower(temp), "rank")) and (not string.find(strlower(temp), "next rank"))) then
            talentRank = temp;
            frameOffset = 1;
            if ((getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()) and (string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "requires"))) then
              frameOffset = frameOffset + 1;
            end
            if ((getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()) and (string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "requires"))) then
              frameOffset = frameOffset + 1;
            end
            if ((getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()) and ((string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "energy")) or (string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "mana")) or (string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "rage"))) and (strlen(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()) < 16)) then
              frameOffset = frameOffset + 1;
            end
            if (((getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()) and ((string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "instant")) or (string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "channeled")) or (string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "sec cast")))) and (strlen(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()) < 16)) then
              frameOffset = frameOffset + 1;
            end
            if ((getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()) and (string.find(strlower(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText()), "tools"))) then
              frameOffset = frameOffset + 1;
            end
            talentDescription = TalentTextLink_Trim(getglobal("GameTooltipTextLeft"..(i+frameOffset)):GetText());
            if (string.len(talentDescription) > 210) then
              talentDescriptionTmp = string.sub(talentDescription, 1, 210);
              local offset = 1;
              local cutpos = 1;
              while (true) do
                offset = string.find(talentDescriptionTmp, ".", offset, true);
                if (offset) then
                  cutpos = offset;
                  offset = offset + 1;
                else
                  break;
                end
              end
              talentDescription1 = TalentTextLink_Trim(string.gsub(string.sub(talentDescription, 1, cutpos), "%c", " "));
              talentDescription2 = TalentTextLink_Trim(string.gsub(string.sub(talentDescription, cutpos+1), "%c", " "));
            else
              talentDescription1 = string.gsub(talentDescription, "%c", " ");
            end
          elseif (string.find(strlower(temp), "next rank")) then
            talentNextRank = temp;
            talentNextDescription = getglobal("GameTooltipTextLeft"..(i+1)):GetText();
          end
        end
      end
    end

    if (not chatFrame) then
      chatFrame = DEFAULT_CHAT_FRAME;
    end
    chatType = chatFrame.editBox.chatType;

    if ((talentName) and (talentRank) and (talentDescription1)) then
      if (ChatFrameEditBox:IsVisible()) then
        ChatFrameEditBox:Insert(talentName..": "..talentDescription1.." ("..talentRank..")");
      else
        SendChatMessage("Talent: "..talentName, chatType);
        SendChatMessage(talentRank..": "..talentDescription1, chatType);
        if (talentDescription2) then
          SendChatMessage(talentDescription2, chatType);
        end
        if (talentAttributes) then
          SendChatMessage(talentAttributes, chatType);
        end
        if ((talentNextRank) and (talentNextDescription)) then
          SendChatMessage(talentNextRank..": "..talentNextDescription, chatType);
        end
      end
    end
  else
    LearnTalent(PanelTemplates_GetSelectedTab(TalentFrame), this:GetID());
  end
end


function TalentTextLink_Trim(s)
  local s = s;
  while (string.sub(s, 1, 1) == " ") do
    s = string.sub(s, 2);
  end
  while (string.find(s, "  ")) do
    s = string.gsub(s, "  ", " ");
  end
  return s;
end
