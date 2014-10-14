-- $Id: ChatAssistOptions.lua 112 2006-09-21 08:33:12Z ayu $
-- $URL: svn://freesia.commun.jp/chatassist/trunk/ChatAssistOptions/ChatAssistOptions.lua $

ChatAssistOptions_Version = "0.28";
local ChatAssistOptions_Panels = {"ChatAssistOptions_GeneralFrame", "ChatAssistOptions_KeywordFrame", "ChatAssistOptions_EventFrame", "ChatAssistOptions_UBFrame"};
local ChatAssistOptions_DefaultChats = {"Say", "Party", "Raid", "Guild", "Officer"}

function ChatAssistOptions_OnLoad()
  PanelTemplates_SetNumTabs(ChatAssistOptions_TabContainerFrame, table.getn(ChatAssistOptions_Panels));
  ChatAssistOptions_TabContainerFrame.selectedTab = 1;
  PanelTemplates_UpdateTabs(ChatAssistOptions_TabContainerFrame);

  -- register for myAddOns
  if(myAddOnsFrame_Register ~= nil) then
    local info = {
      name = CA_OPTIONS_CHATASSISTOPTIONS;
      version = ChatAssistOptions_Version;
      author = "ayu";
      website = "http://fed.commun.jp";
      category = MYADDONS_CATEGORY_CHAT;
      optionsframe = "ChatAssistOptionsFrame";
    };
    myAddOnsFrame_Register(info);
  end

  -- Load Complete
  DEFAULT_CHAT_FRAME:AddMessage(string.format(CA_OPTIONS_LOADED, ChatAssistOptions_Version));
end

function ChatAssistOptions_OnShow()
  ChatAssistOptions_CheckTimestamp:SetChecked(ChatAssist_Config.Timestamp);
  ChatAssistOptions_EditTimestampFormat:SetText(ChatAssist_Config.TimestampFormat);
  ChatAssistOptions_CheckColorName:SetChecked(ChatAssist_Config.ColorName);
  ChatAssistOptions_CheckShortTag:SetChecked(ChatAssist_Config.ShortTag);
  ChatAssistOptions_CheckHideTag:SetChecked(ChatAssist_Config.HideTag);
  ChatAssistOptions_CheckHideChannel:SetChecked(ChatAssist_Config.HideChannel);
  ChatAssistOptions_CheckChannelSticky:SetChecked(ChatAssist_Config.ChannelSticky);
  ChatAssistOptions_CheckOfficerSticky:SetChecked(ChatAssist_Config.OfficerSticky);
  ChatAssistOptions_CheckWhisperSticky:SetChecked(ChatAssist_Config.WhisperSticky);
  ChatAssistOptions_CheckLogging:SetChecked(ChatAssist_Config.Logging);
  ChatAssistOptions_CheckUBEnable:SetChecked(ChatAssist_Config.UnicodeBlock["enable"]);
  ChatAssistOptions_CheckUBParty:SetChecked(ChatAssist_Config.UnicodeBlock["party"]);
  ChatAssistOptions_CheckUBRaid:SetChecked(ChatAssist_Config.UnicodeBlock["raid"]);
  ChatAssistOptions_CheckUBRaidWarning:SetChecked(ChatAssist_Config.UnicodeBlock["raidwarning"]);
  ChatAssistOptions_CheckUBGuild:SetChecked(ChatAssist_Config.UnicodeBlock["guild"]);
  ChatAssistOptions_CheckUBOfficer:SetChecked(ChatAssist_Config.UnicodeBlock["officer"]);
  ChatAssistOptions_SliderOnScreenFontSize:SetValue(ChatAssist_Config.OnScreenFontSize);

  local name, info;
  for name, info in ChatAssist_Config.Event do
    if(getglobal("ChatAssistOptions_Event" .. name) ~= nil) then
      getglobal("ChatAssistOptions_Event" .. name .. "CheckOnScreen"):SetChecked(info.OnScreen);
      getglobal("ChatAssistOptions_Event" .. name .. "SwatchNormalTexture"):SetVertexColor(info.OnScreenColor.r, info.OnScreenColor.g, info.OnScreenColor.b);
    end
  end
end

function ChatAssistOptions_TabContainerTab_OnClick()
  local selectedTab = ChatAssistOptions_TabContainerFrame.selectedTab;
  for id,panel in pairs(ChatAssistOptions_Panels) do
    if(id == selectedTab) then
      getglobal(panel):Show();
    else
      getglobal(panel):Hide();
    end
  end
end

function ChatAssistOptions_ScrollKeyword_Update()
  FauxScrollFrame_Update(ChatAssistOptions_ScrollKeyword, table.getn(ChatAssist_Config.Keywords), 10, 20);
  local offset = FauxScrollFrame_GetOffset(ChatAssistOptions_ScrollKeyword);

  for i = 1, 10 do
    if(i + offset <= table.getn(ChatAssist_Config.Keywords)) then
      getglobal("ChatAssistOptions_KeywordItem"..i.."Text"):SetText(ChatAssist_Config.Keywords[i+offset]);
      getglobal("ChatAssistOptions_KeywordItem"..i):Show();
      getglobal("ChatAssistOptions_KeywordItem"..i).KeywordId = i + offset;
    else
      getglobal("ChatAssistOptions_KeywordItem"..i):Hide();
    end

    if(getglobal("ChatAssistOptions_KeywordItem"..i).KeywordId == ChatAssistOptionsFrame.selectedKeyword) then      getglobal("ChatAssistOptions_KeywordItem"..i):LockHighlight();
    else
      getglobal("ChatAssistOptions_KeywordItem"..i):UnlockHighlight();
    end
  end
end

function ChatAssistOptions_KeywordItem_OnClick()
  ChatAssistOptionsFrame.selectedKeyword = this.KeywordId;
  ChatAssistOptions_ScrollKeyword_Update();
end

function ChatAssistOptions_ButtonOK_OnClick()
  ChatAssist_Config.Timestamp = ChatAssistOptions_Check(ChatAssistOptions_CheckTimestamp:GetChecked());
  ChatAssist_Config.TimestampFormat = ChatAssistOptions_EditTimestampFormat:GetText();
  ChatAssist_Config.ColorName = ChatAssistOptions_Check(ChatAssistOptions_CheckColorName:GetChecked());
  ChatAssist_Config.ShortTag = ChatAssistOptions_Check(ChatAssistOptions_CheckShortTag:GetChecked());
  ChatAssist_Config.HideTag = ChatAssistOptions_Check(ChatAssistOptions_CheckHideTag:GetChecked());
  ChatAssist_Config.HideChannel = ChatAssistOptions_Check(ChatAssistOptions_CheckHideChannel:GetChecked());
  ChatAssist_Config.ChannelSticky = ChatAssistOptions_Check(ChatAssistOptions_CheckChannelSticky:GetChecked());
  ChatAssist_Config.OfficerSticky = ChatAssistOptions_Check(ChatAssistOptions_CheckOfficerSticky:GetChecked());
  ChatAssist_Config.WhisperSticky = ChatAssistOptions_Check(ChatAssistOptions_CheckWhisperSticky:GetChecked());
  ChatAssist_Config.Logging = ChatAssistOptions_Check(ChatAssistOptions_CheckLogging:GetChecked());
  ChatAssist_Config.UnicodeBlock["enable"] = ChatAssistOptions_Check(ChatAssistOptions_CheckUBEnable:GetChecked());
  ChatAssist_Config.UnicodeBlock["party"] = ChatAssistOptions_Check(ChatAssistOptions_CheckUBParty:GetChecked());
  ChatAssist_Config.UnicodeBlock["raid"] = ChatAssistOptions_Check(ChatAssistOptions_CheckUBRaid:GetChecked());
  ChatAssist_Config.UnicodeBlock["raidwarning"] = ChatAssistOptions_Check(ChatAssistOptions_CheckUBRaidWarning:GetChecked());
  ChatAssist_Config.UnicodeBlock["guild"] = ChatAssistOptions_Check(ChatAssistOptions_CheckUBGuild:GetChecked());
  ChatAssist_Config.UnicodeBlock["officer"] = ChatAssistOptions_Check(ChatAssistOptions_CheckUBOfficer:GetChecked());
  ChatAssist_Config.DefaultChat = string.lower(ChatAssistOptions_DefaultChats[UIDropDownMenu_GetSelectedID(ChatAssistOptions_DropDownDefaultChat)]);
  ChatAssist_Config.OnScreenFontSize = ChatAssistOptions_SliderOnScreenFontSize:GetValue();

  local name, info;
  for name, info in ChatAssist_Config.Event do
    if(getglobal("ChatAssistOptions_Event" .. name) ~= nil) then
      local r, g, b = getglobal("ChatAssistOptions_Event" .. name .. "SwatchNormalTexture"):GetVertexColor();
      ChatAssist_Config.Event[name].OnScreen = ChatAssistOptions_Check(getglobal("ChatAssistOptions_Event" .. name .. "CheckOnScreen"):GetChecked());
      ChatAssist_Config.Event[name].OnScreenColor.r = r;
      ChatAssist_Config.Event[name].OnScreenColor.g = g;
      ChatAssist_Config.Event[name].OnScreenColor.b = b;
    end
  end

  ChatTypeInfo["CHANNEL"].sticky = ChatAssist_Config.ChannelSticky;
  ChatTypeInfo["OFFICER"].sticky = ChatAssist_Config.OfficerSticky;
  ChatTypeInfo["WHISPER"].sticky = ChatAssist_Config.WhisperSticky;

  -- MessageFont
  if(ChatAssist_MessageFont:SetFont(ChatAssist_ChatFont, ChatAssist_Config.OnScreenFontSize) == nil) then
    ChatAssist_MessageFont:SetFont("Fonts\\FRIZQT__.TTF", ChatAssist_Config.OnScreenFontSize);
  end

  HideUIPanel(ChatAssistOptionsFrame);
end

function ChatAssistOptions_ButtonAddKeyword_OnClick()
  local text = ChatAssistOptions_EditKeyword:GetText();
  if(text == nil or text == "") then
    return;
  end

  -- Already exists?
  for key,value in pairs(ChatAssist_Config.Keywords) do
    if(text == value) then
      return;
    end
  end

  table.insert(ChatAssist_Config.Keywords, text);
  ChatAssistOptions_ScrollKeyword_Update();
  ChatAssistOptions_EditKeyword:SetText("");
  ChatAssistOptions_EditKeyword:ClearFocus();
end

function ChatAssistOptions_ButtonDeleteKeyword_OnClick()
  if(ChatAssistOptionsFrame.selectedKeyword ~= nil and ChatAssistOptionsFrame.selectedKeyword ~= 0) then
    table.remove(ChatAssist_Config.Keywords, ChatAssistOptionsFrame.selectedKeyword);
  end
  ChatAssistOptionsFrame.selectedKeyword = 0;
  ChatAssistOptions_ScrollKeyword_Update();
end

function ChatAssistOptions_ButtonColorNameRebuild_OnClick()
  ChatAssist_SlashCommandHandler("ccrebuild");
end

function ChatAssistOptions_CheckShortTag_OnClick()
  if(ChatAssistOptions_CheckShortTag:GetChecked() == 1) then
    ChatAssistOptions_CheckHideTag:SetChecked(false);
  end
end

function ChatAssistOptions_CheckHideTag_OnClick()
  if(ChatAssistOptions_CheckHideTag:GetChecked() == 1) then
    ChatAssistOptions_CheckShortTag:SetChecked(false);
  end
end

function ChatAssistOptions_Event_Swatch_OnClick(type)
  local frame = this:GetParent();
  local r, g, b = getglobal(this:GetName() .. "NormalTexture"):GetVertexColor();
  frame.r = r;
  frame.g = g;
  frame.b = b;
  frame.swatchFunc = ChatAssistOptions_Event_Swatch_SetColor;
  frame.cancelFunc = ChatAssistOptions_Event_Swatch_Cancel;
  ColorPickerFrame.frame = frame;
  UIDropDownMenuButton_OpenColorPicker(frame);
end

function ChatAssistOptions_Event_Swatch_SetColor()
  local r, g, b = ColorPickerFrame:GetColorRGB();
  getglobal(ColorPickerFrame.frame:GetName() .. "SwatchNormalTexture"):SetVertexColor(r, g, b);
end

function ChatAssistOptions_Event_Swatch_Cancel()
  local type = string.sub(ColorPickerFrame.frame:GetName(), 24);
  local info = ChatAssist_Config.Event[type];
  getglobal(ColorPickerFrame.frame:GetName() .. "SwatchNormalTexture"):SetVertexColor(info.OnScreenColor.r, info.OnScreenColor.g, info.OnScreenColor.b);
end

function ChatAssistOptions_DropDownDefaultChat_OnLoad()
  UIDropDownMenu_Initialize(this, ChatAssistOptions_DropDownDefaultChat_Initialize);
  UIDropDownMenu_SetWidth(80);
end

function ChatAssistOptions_DropDownDefaultChat_Initialize()
  local info, id, name, selected;

  for id, name in ChatAssistOptions_DefaultChats do
    info = {};
    info.text = name;
    info.func = ChatAssistOptions_DropDownDefaultChat_OnClick;
    UIDropDownMenu_AddButton(info);
    if(ChatAssist_Config.DefaultChat == string.lower(name)) then
      selected = id;
    end
  end
  if(selected ~= nil) then
    UIDropDownMenu_SetSelectedID(ChatAssistOptions_DropDownDefaultChat, selected);
  else
    UIDropDownMenu_SetSelectedID(ChatAssistOptions_DropDownDefaultChat, 1);
  end
end

function ChatAssistOptions_DropDownDefaultChat_OnClick()
  UIDropDownMenu_SetSelectedID(ChatAssistOptions_DropDownDefaultChat, this:GetID());
end

function ChatAssistOptions_Check(bool)
  if(bool == nil) then
    return 0;
  end
  return 1;
end
