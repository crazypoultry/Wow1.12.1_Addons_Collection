--[[ ********************************************************************* --]]
--[[ MyQuestsWizard.lua                                                    --]]
--[[   All functionality unique to the quest create/edit wizard.           --]]
--[[ ********************************************************************* --]]

local g_CurrentPage = 1;
local g_MaxPages = 8;

-- reference to the quest currently being created or edited
local MQWizard_Quest = nil;

MQWizard_EditQuestNo = nil;

local MQWizard_ItemArray = nil;

UIPanelWindows["MyQuestsWizard_Parent"] = { area = "left", pushable = 3 };

--[[ ********************************************************************* --]]
--[[ MyQuestsWizard_NextPage                                               --]]
--[[   ??                                                                  --]]
function MyQuestsWizard_NextPage()
  -- hide the current page
  HideUIPanel(getglobal("MyQuestsWizard_Page" .. g_CurrentPage));

  -- increment the page counter
  g_CurrentPage = g_CurrentPage + 1;
  MQWizard_PrevButton:Enable();
  if (g_CurrentPage == g_MaxPages) then
    MQWizard_NextButton:Disable();
  end
  MyQuestsWizard_TabTextUpdate();
  
  --if (MQWizard_Quest.title and MQWizard_Quest.descText ~= "" and MQWizard_Quest.objectiveText ~= "") then
  --  MQWizard_SaveButton:Enable();
  --else
  --  MQWizard_SaveButton:Disable();
  --end
  
  -- show the next page
  ShowUIPanel(getglobal("MyQuestsWizard_Page" .. g_CurrentPage));
end

--[[ ********************************************************************* --]]
--[[ MyQuestsWizard_PrevPage                                               --]]
--[[   ??                                                                  --]]
function MyQuestsWizard_PrevPage()
  -- hide the current page
  HideUIPanel(getglobal("MyQuestsWizard_Page" .. g_CurrentPage));
  
  -- decrease the page counter
  g_CurrentPage = g_CurrentPage - 1;
  MQWizard_NextButton:Enable();
  if (g_CurrentPage == 1) then
    MQWizard_PrevButton:Disable();
  end
  MyQuestsWizard_TabTextUpdate();

  --if (MQWizard_Quest.title and MQWizard_Quest.descText ~= "" and MQWizard_Quest.objectiveText ~= "") then
  --  MQWizard_SaveButton:Enable();
  --else
  --  MQWizard_SaveButton:Disable();
  --end
  
  -- show the next page
  ShowUIPanel(getglobal("MyQuestsWizard_Page" .. g_CurrentPage));
end

--[[ ********************************************************************* --]]
--[[ MyQuestsWizard_OnShow                                                 --]]
--[[   ??                                                                  --]]
function MyQuestsWizard_OnShow()
  -- show the appropriate title text
  --MQWizard_Page1Title:SetText(MQ_QUEST_WIZARD_NEWQUESTHEADER);
  --MQWizard_Page1Intro:SetText(MQ_QUEST_WIZARD_NEWQUESTINTRO);

  MyQuestsWizard_TabTextUpdate();
  
  ShowUIPanel(MyQuestsWizard_Page1);
  
  
  --if (MQWizard_EditQuestNo==nil) then 
  --  MQWizard_SaveButton:Disable();
  --else
    MQWizard_SaveButton:Enable();
  --end
  
  MQWizard_NextButton:Enable();
  MQWizard_PrevButton:Disable();
end

--[[ ********************************************************************* --]]
--[[ MyQuestsWizard_OnCancel                                               --]]
--[[   ??                                                                  --]]
function MyQuestsWizard_OnCancel()
  --mq.IO.dprint("[MyQuestsWizard_OnCancel]");

  -- hide the current step (Page1 will appear when reopened)  
  getglobal("MyQuestsWizard_Page" .. g_CurrentPage):Hide();
  HideUIPanel(MyQuestsWizard_Parent);

  MQWizard_Quest = nil;
  MQWizard_EditQuestNo = nil;

  for i=1, 5, 1 do
    MQWizard_ObjectiveDropDown_Reset("MQWizard_Objective" .. i);
  end
  
  g_CurrentPage = 1;
end

--[[ ********************************************************************* --]]
--[[ MyQuestsWizard_TabTextUpdate                                          --]]
--[[   Updates the the "Step x of y" text shown above the edit area.       --]]
function MyQuestsWizard_TabTextUpdate()
  MQWizard_StepNumberText:SetText("Step " .. g_CurrentPage .." of " .. g_MaxPages);
end

--[[ ********************************************************************* --]]
--[[ MQWizard_PlaceItem                                                    --]]
--[[   Called when the user places an item into the ItemBox of the reward  --]]
--[[     or objective pages.                                               --]]
function MQWizard_PlaceItem(source, type)
  -- pull out the objective or reward we are working with
  local objRef = getglobal("MQWizard_" .. type .. source:GetParent():GetID());
  
  if(CursorHasItem() and MQBypass_CursorItem) then
    local icon = getglobal(this:GetName().."Icon");
    icon:SetTexture(MQBypass_CursorItem.texture);

    PickupSpell(1, "spell"); -- Doing this twice is a safe way to clear cursor
    PickupSpell(1, "spell");

    -- extract the item name from the link and string the brackets
    local tmpName = string.gsub(MQBypass_CursorItem.link, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%3");
    tmpName = string.sub(tmpName, 2, string.len(tmpName)-1);


    objRef.item = {}
    objRef.item.name = tmpName;
    objRef.item.link = MQBypass_CursorItem.link;
    objRef.item.texture = MQBypass_CursorItem.texture;
    objRef.item.isUseable = MQBypass_CursorItem.isUseable;

    MQBypass_CursorItem = nil;
  end
end

function MQWizard_ChainDropDown_OnLoad()
  -- initialize the quest chain drop down
  UIDropDownMenu_Initialize(this, MQWizard_ChainDropDown_Initialize);
  UIDropDownMenu_SetSelectedValue(this, "none");
  UIDropDownMenu_SetWidth(90, this);
end

function MQWizard_ChainDropDown_Initialize()
  local info;

  local selectedValue = UIDropDownMenu_GetSelectedValue(MQWizard_ChainDropDown);
  
  info = {};
  info.text = "None";
  info.func = MQWizard_ChainDropDown_OnClick;
  info.value = "none";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);
  
  if (myquests) then
    for i=1, table.getn(myquests.Quests), 1 do
      info = {};
      info.text = myquests.Quests[i].title;
      info.func = MQWizard_ChainDropDown_OnClick;
      info.value = myquests.Quests[i].id;
      if (info.value == selectedValue) then
        info.checked = 1;
      end
      UIDropDownMenu_AddButton(info);
    end
  end
  
end

function MQWizard_ChainDropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_ChainDropDown, this.value);
end

--[[ ********************************************************************* --]]
--[[ MQWizard_ObjectiveTypeDropDown_OnLoad                                 --]]
--[[ ********************************************************************* --]]
function MQWizard_ObjectiveDropDown_OnLoad(id)
  UIDropDownMenu_Initialize(this, MQWizard_ObjectiveDropDown_Initialize);
  
  --local tmpQuest = MyQuestsWizard_Parent.quest;  
  --if (tmpQuest and tmpQuest.objectives[id]) then
  --  UIDropDownMenu_SetSelectedValue(this, tmpQuest.objectives[id].type);
  --else
  --  UIDropDownMenu_SetSelectedValue(this, "None");
  --end
  
  UIDropDownMenu_SetWidth(90, this);
end

function MQWizard_ObjectiveDropDown_Initialize()
  local s, e, id = string.find(this:GetName(), "MQWizard_Objective(%d)DropDown");
  local ddRef = "MQWizard_Objective"..id.."DropDown";

  local selectedValue = UIDropDownMenu_GetSelectedValue(getglobal(ddRef));
  local info;
  
  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_NONE;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "None";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

--[[
  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_EMOTE;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "Emote";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);
--]]

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_EXPLORE;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "Explore";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_DUEL_ANY;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "DuelAny";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_DUEL_CLASS;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "DuelClass";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_DUEL_GUILD;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "DuelGuild";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_DUEL_PLAYER;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "DuelPlayer";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_DUEL_RACE;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "DuelRace";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_GATHER_ITEM;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "GatherItem";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_KILL_MONSTER;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "KillMonster";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_MONEY;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "Money";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_PVP_ANY;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "PvpAny";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_PVP_CLASS;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "PvpClass";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_PVP_GUILD;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "PvpGuild";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_PVP_SPECIFIC;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "PvpPlayer";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_PVP_RACE;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "PvpRace";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.text = MYQUESTS_WIZARD_OBJECTIVE_TAME;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "Tame";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);
  
end

function MQWizard_ObjectiveDropDown_Reset(ddref)
  UIDropDownMenu_SetSelectedValue(getglobal(ddref .. "DropDown", "None"));
  getglobal(ddref .. "NameBox"):SetText("");
  getglobal(ddref .. "CountBox"):SetText("");
  getglobal(ddref .. "MinLevel"):SetText("");
  getglobal(ddref .. "MaxLevel"):SetText("");
  --getglobal(ddref .. "RequiredMoney"):SetCopper(0);
  MoneyInputFrame_SetCopper(getglobal(ddref .. "RequiredMoney"), 0);
  getglobal(ddref .. "ItemBoxIcon"):SetTexture(nil);
end

function MQWizard_Objective1DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Objective1DropDown, this.value);
  MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective1", this.value);
end

function MQWizard_Objective2DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Objective2DropDown, this.value);
  MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective2", this.value);
end

function MQWizard_Objective3DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Objective3DropDown, this.value);
  MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective3", this.value);
end

function MQWizard_Objective4DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Objective4DropDown, this.value);
  MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective4", this.value);
end

function MQWizard_Objective5DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Objective5DropDown, this.value);
  MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective5", this.value);
end


function MQWizard_CommonObjectiveDropDown_OnClick(ddref, value)
  if (value == "None") then
    getglobal(ddref .. "NameLabel"):Hide();
    getglobal(ddref .. "NameBox"):Hide();
    
    getglobal(ddref .. "CountLabel"):Hide();
    getglobal(ddref .. "CountBox"):Hide();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "Emote") then
    getglobal(ddref .. "NameLabel"):Show();
    getglobal(ddref .. "NameBox"):Show();

    getglobal(ddref .. "CountLabel"):Hide();
    getglobal(ddref .. "CountBox"):Hide();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "Explore") then
    getglobal(ddref .. "NameLabel"):Show();
    getglobal(ddref .. "NameBox"):Show();

    getglobal(ddref .. "CountLabel"):Hide();
    getglobal(ddref .. "CountBox"):Hide();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "DuelAny") then
    getglobal(ddref .. "NameLabel"):Hide();
    getglobal(ddref .. "NameBox"):Hide();
    
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "LevelLabel"):Show();
    getglobal(ddref .. "MinLevel"):Show();
    getglobal(ddref .. "MaxLevel"):Show();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "DuelClass" or value == "DuelGuild" or value == "DuelRace") then
    getglobal(ddref .. "NameLabel"):Show();
    getglobal(ddref .. "NameBox"):Show();
    
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "LevelLabel"):Show();
    getglobal(ddref .. "MinLevel"):Show();
    getglobal(ddref .. "MaxLevel"):Show();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "DuelPlayer") then
    getglobal(ddref .. "NameLabel"):Show();
    getglobal(ddref .. "NameBox"):Show();
    
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "GatherItem") then
    getglobal(ddref .. "NameLabel"):Hide();
    getglobal(ddref .. "NameBox"):Hide();
    
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Show();
    getglobal(ddref .. "ItemNoTrade"):Show();
    getglobal(ddref .. "ItemNoDisplay"):Show();

    if (ISync) then
      getglobal(ddref .. "ISyncButton"):Show();
    end
  elseif (value == "PvpAny") then
    getglobal(ddref .. "NameLabel"):Hide();
    getglobal(ddref .. "NameBox"):Hide();
    
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "PvpClass" or value == "PvpGuild" or value == "PvpPlayer" or value == "PvpRace") then
    getglobal(ddref .. "NameLabel"):Show();
    getglobal(ddref .. "NameBox"):Show();
    
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "KillMonster") then
    getglobal(ddref .. "NameLabel"):Show();
    getglobal(ddref .. "NameBox"):Show();
    
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();  
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "Money") then
    getglobal(ddref .. "NameLabel"):Hide();
    getglobal(ddref .. "NameBox"):Hide();
    
    getglobal(ddref .. "CountLabel"):Hide();
    getglobal(ddref .. "CountBox"):Hide();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Show();

    getglobal(ddref .. "ItemBox"):Hide();
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  elseif (value == "Tame") then
    getglobal(ddref .. "NameLabel"):Show();
    getglobal(ddref .. "NameBox"):Show();
    
    getglobal(ddref .. "CountLabel"):Hide();
    getglobal(ddref .. "CountBox"):Hide();
    
    getglobal(ddref .. "LevelLabel"):Hide();
    getglobal(ddref .. "MinLevel"):Hide();
    getglobal(ddref .. "MaxLevel"):Hide();
    
    getglobal(ddref .. "RequiredMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();  
    getglobal(ddref .. "ItemNoTrade"):Hide();
    getglobal(ddref .. "ItemNoDisplay"):Hide();
    getglobal(ddref .. "ISyncButton"):Hide();
  end
end

--[[ ********************************************************************* --]]
--[[ MQWizard_RewardDropDown_OnLoad                                        --]]
--[[   ??                                                                  --]]
function MQWizard_RewardDropDown_OnLoad()
  -- the quest we are currently editing
  --MyQuestsWizard_Parent.quest

  UIDropDownMenu_Initialize(this, MQWizard_RewardDropDown_Initialize);
  --UIDropDownMenu_SetSelectedValue(this, "None");
  --UIOptionsFrameClickCameraDropDown.tooltip = "Select Quest Type.";
  UIDropDownMenu_SetWidth(90, this);
end

--[[ ********************************************************************* --]]
--[[ MQWizard_RewardDropDown_Initialize                                    --]]
--[[   ??                                                                  --]]
function MQWizard_RewardDropDown_Initialize()
  local s, e, id = string.find(this:GetName(), "MQWizard_Reward(%d)DropDown");
  local ddRef = "MQWizard_Reward"..id.."DropDown";

  local selectedValue = UIDropDownMenu_GetSelectedValue(getglobal(ddRef));
  local info;
  
  info = {};
  info.text = MQ_QUEST_WIZARD_REWARD_NONE;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "None";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MQ_QUEST_WIZARD_REWARD_PROMOTION;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "GuildPromotion";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MQ_QUEST_WIZARD_REWARD_INVITATION;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "GuildInvite";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MQ_QUEST_WIZARD_REWARD_ITEM;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "ItemReward";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);

  info = {};
  info.text = MQ_QUEST_WIZARD_REWARD_MONEY;
  info.func = getglobal(ddRef.."_OnClick");
  info.value = "Money";
  if (info.value == selectedValue) then
    info.checked = 1;
  end
  UIDropDownMenu_AddButton(info);
end

function MQWizard_Reward1DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Reward1DropDown, this.value);
  MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward1", this.value);
end
function MQWizard_Reward2DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Reward2DropDown, this.value);
  MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward2", this.value);
end
function MQWizard_Reward3DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Reward3DropDown, this.value);
  MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward3", this.value);
end
function MQWizard_Reward4DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Reward4DropDown, this.value);
  MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward4", this.value);
end
function MQWizard_Reward5DropDown_OnClick()
  UIDropDownMenu_SetSelectedValue(MQWizard_Reward5DropDown, this.value);
  MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward5", this.value);
end

function MQWizard_CommonRewardDropDown_OnClick(ddref, value)
  if (value == "None" or value == "GuildPromotion" or value == "GuildInvite") then
    getglobal(ddref .. "CountLabel"):Hide();
    getglobal(ddref .. "CountBox"):Hide();
    
    getglobal(ddref .. "RewardMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Hide();
  elseif (value == "ItemReward") then
    getglobal(ddref .. "CountLabel"):Show();
    getglobal(ddref .. "CountBox"):Show();
    
    getglobal(ddref .. "RewardMoney"):Hide();

    getglobal(ddref .. "ItemBox"):Show();
  elseif (value == "Money") then
    getglobal(ddref .. "CountLabel"):Hide();
    getglobal(ddref .. "CountBox"):Hide();
    
    getglobal(ddref .. "RewardMoney"):Show();

    getglobal(ddref .. "ItemBox"):Hide();
  end
end

function MQWizard_ISyncImportClick()
  if (MQWizard_ISyncButtonRef) then
    MQWizard_ISyncImportAbort();
    return;
  end
  
  MQWizard_ISyncButtonRef = this;
  MQWizard_ISyncButtonRef:LockHighlight();
  MQWizard_ISyncButtonRef:SetButtonState("PUSHED", 1);
  
  if (not ISync_MainFrame:IsVisible()) then 
    ISync_MainFrame:Show();
    MQWizard_ISyncCloseFlag = 1;
  end

  -- save the real ISync:ButtonClick reference
  MQWizard_ISyncButtonClick_Save = ISync.ButtonClick;
  -- switch the ISync.ButtonClick to our own function
  ISync.ButtonClick = MQWizard_ISyncButtonClick;
end

function MQWizard_ISyncImportAbort()
  MQWizard_ISyncButtonRef:UnlockHighlight();
  MQWizard_ISyncButtonRef:SetButtonState("NORMAL");
  MQWizard_ISyncButtonRef = nil;

  -- close the ISync window if we opened it
  if (MQWizard_ISyncCloseFlag) then
    ISync_MainFrame:Hide();
    MQWizard_ISyncCloseFlag = nil;
  end

  -- restore the natural function reference
  ISync.ButtonClick = MQWizard_ISyncButtonClick_Save;
end

function MQWizard_ISyncButtonClick(sButton)
  -- pull out the information we need from the item
  local sName, sLink, iQuality, iLevel, sType, sSubType, iCount, sEquipLoc, sTexture = GetItemInfo("item:"..this.storeID);
  -- find the proper item box to populate
  local objRef = getglobal("MQWizard_Objective" .. MQWizard_ISyncButtonRef:GetParent():GetID());
  
  local icon = getglobal(objRef:GetName().."ItemBoxIcon");
  icon:SetTexture(sTexture);

  objRef.item = {}
  objRef.item.name = sName;
  objRef.item.link = sLink;
  objRef.item.texture = sTexture;
  objRef.item.isUseable = 1;

  MQWizard_ISyncImportAbort();  
end
