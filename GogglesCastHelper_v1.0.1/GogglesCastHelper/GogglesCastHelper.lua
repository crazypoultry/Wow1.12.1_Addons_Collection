--[[
--
-- Objects
--
--]]

-- GogglesCastHelper
GogglesCastHelper = {
 version = "1.0.1",
 events = {
  "VARIABLES_LOADED",
  "PLAYER_REGEN_ENABLED",
  "PLAYER_REGEN_DISABLED",
  "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
  "CHAT_MSG_SPELL_AURA_GONE_SELF",
  "SPELLCAST_CHANNEL_START",
  "SPELLCAST_CHANNEL_STOP",
  "SPELLCAST_START",
  "SPELLCAST_STOP",
  "SPELLCAST_FAILED",
  "SPELLCAST_INTERRUPTED"
 },
 states = {
  -- Casting
  {
   class="NONE",
   name="Casting",
   onEvent={"SPELLCAST_CHANNEL_START","SPELLCAST_STOP"}, 
   onArgs={}, 
   offEvent={"SPELLCAST_CHANNEL_STOP","SPELLCAST_STOP","SPELLCAST_FAILED","SPELLCAST_INTERRUPTED"   }, 
   offArgs={},
   continue=0,
   state=0
  },
  -- Netherwind
  {
   class="MAGE",
   name=GogglesLanguage.netherwindName,
   onEvent={"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"}, 
   onArgs={GogglesLanguage.netherwindOn}, 
   offEvent={"CHAT_MSG_SPELL_AURA_GONE_SELF"}, 
   offArgs={GogglesLanguage.netherwindOff},
   continue=1,
   state=0
  },
  -- Clearcasting
  {
   class="MAGE",
   name=GogglesLanguage.clearcastName,
   onEvent={"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"}, 
   onArgs={GogglesLanguage.clearcastOn}, 
   offEvent={"CHAT_MSG_SPELL_AURA_GONE_SELF"}, 
   offArgs={GogglesLanguage.clearcastOff},
   continue=1,
   state=0
  }
 },
 current = 1,
 class = "",
 combat = 0,
 cursorSpellId = 0,
 cursorBookType = "",
 maxSpells = 0,
 maxStates = 0,
 maxWhispers = 0,
 maxRangeChecks = 0,
 whisperQueue = {}, -- for "whisper cast"
 rangeChecks = {},
 nextRangeCheck = 0,
}

-- Saved Variables
GogglesCastHelperSV = { 

}

-- Saved Variables Per Character
GogglesCastHelperSVPC = { 
 rangeCheck = nil,
 whisperCast = nil,
 spells = {}
}

--[[
--
-- Functions
--
--]]

-- Slash handler
function GogglesCastHelper_Slash(msg)
 local showOptions = false;
 if (msg ~= nil) then
  local actions, commandString, i = {}, msg, 1;
  while commandString ~= nil and i < 10 do
   i = i + 1;
   local a,b,c = strfind(commandString, "(%S+)");
   if (a) then
    commandString = strsub(commandString, b+2);  
    tinsert(actions,strlower(c));
   else
    commandString = nil;
   end   
  end
  if (table.getn(actions) > 0) then
   if (actions[1] == "config") then 
    GogglesCastHelperMainFrame:Show();
   elseif (actions[1] == "cast") then
    table.remove(actions,1);
    if (table.getn(actions) > 0) then
     GogglesCastHelper:Cast(actions);
    else 
     showOptions = true;
    end
   else
    showOptions = true;
   end
  else
   showOptions = true;
  end
 else
  showOptions = true;
 end
 if (showOptions) then
  GogglesCastHelper:Out(string.format(GogglesLanguage.slash.header,GogglesCastHelper.version),0,0.5,1,1);
  GogglesCastHelper:Out(GogglesLanguage.slash.usage,0,1,1,1);
  GogglesCastHelper:Out(GogglesLanguage.slash.config,0.5,1,1,1);
  GogglesCastHelper:Out(GogglesLanguage.slash.cast,0.5,1,1,1);
 end
end

-- On load
function GogglesCastHelper:OnLoad() 
 self:Init();
 self:RegisterEvents();
end

-- On event
function GogglesCastHelper:OnEvent()
 self:CheckStates(event,arg1);
 if (event == "PLAYER_REGEN_DISABLED") then
  -- In combat
  self.combat = 1; 
 elseif (event == "PLAYER_REGEN_ENABLED") then
  -- Out of combat
  self.combat = 0;
 elseif (event == "VARIABLES_LOADED") then
  this:UnregisterEvent("VARIABLES_LOADED");
  
  self:RangeCheckInit();
    
  SlashCmdList["GOGGLESCASTHELPER"] = GogglesCastHelper_Slash;
  SLASH_GOGGLESCASTHELPER1 = "/gch";
  SLASH_GOGGLESCASTHELPER2 = "/gogglescasthelper"; 
 end
end

-- On update
function GogglesCastHelper:OnUpdate()
 if (GetTime() > self.nextRangeCheck) then
  self.nextRangeCheck = GetTime() + 1;
  GogglesCastHelper:RangeCheckUpdate();
 end
end

-- Output text
function GogglesCastHelper:Out(text, r, g, b, a)
 DEFAULT_CHAT_FRAME:AddMessage(text, r, g, b, a);
end

-- Register events
function GogglesCastHelper:RegisterEvents()
 local key,val;
 for key,val in self.events do
  this:RegisterEvent(val);
 end 
end

-- Initialise variables
function GogglesCastHelper:Init()
 local key,val;
 -- get player class
 _,self.class = UnitClass("player");
 -- hook chatframe event
 GogglesCastHelper_ChatFrame_OnEventOrig = ChatFrame_OnEvent; 
 ChatFrame_OnEvent = function (event) 
  GogglesCastHelper:ChatFrame_OnEventHandler(event, arg1, arg2);
 end 
 -- hook spell pickup
 GogglesCastHelper_PickupSpellOrig = PickupSpell; 
 PickupSpell = function (spellId, bookType) 
  GogglesCastHelper:PickupSpellHandler(spellId, bookType); 
 end
end

-- Initialise main frame
function GogglesCastHelper:MainFrameInit()
 -- Set labels
 GogglesCastHelperMainFrameTitle:SetText(GogglesLanguage.ui.mainTitle);
 GogglesCastHelperMainFrameGlobals:SetText(GogglesLanguage.ui.mainGlobals);
 GogglesCastHelperMainFrameOptions:SetText(GogglesLanguage.ui.mainOptions);
 GogglesCastHelperMainFrameStates:SetText(GogglesLanguage.ui.mainStates);
 GogglesCastHelperMainFrameWhisperCastLabel:SetText(GogglesLanguage.ui.mainWhisperCastLabel);
 GogglesCastHelperMainFrameRangeCheckLabel:SetText(GogglesLanguage.ui.mainRangeCheckLabel);
 GogglesCastHelperMainFrameShortNameLabel:SetText(GogglesLanguage.ui.mainShortNameLabel);
 GogglesCastHelperMainFrameRangeLabel:SetText(GogglesLanguage.ui.mainRangeLabel);
 GogglesCastHelperMainFrameTargetLabel:SetText(GogglesLanguage.ui.mainTargetLabel);
 GogglesCastHelperMainFrameActionSlotLabel:SetText(GogglesLanguage.ui.mainActionSlotLabel);
 GogglesCastHelperMainFrameGlobalCooldownLabel:SetText(GogglesLanguage.ui.mainGlobalCooldownLabel);
 GogglesCastHelperMainFrameWhisperLabel:SetText(GogglesLanguage.ui.mainWhisperLabel);
end

-- Initialise range check
function GogglesCastHelper:RangeCheckInit()
 local key,val;
 for key,val in GogglesCastHelperSVPC.spells do
  if (val.actionSlot ~= nil and val.actionSlot > 0 and val.range ~= nil and val.range > 0) then
   if (val.range > table.getn(self.rangeChecks)) then
    table.setn(self.rangeChecks,val.range);
   end
   self.rangeChecks[val.range] = val;
  end
 end
end

-- ChatFrame event handler
function GogglesCastHelper:ChatFrame_OnEventHandler(event,arg1,arg2)
 if (GogglesCastHelperSVPC.whisperCast == 1 and event == "CHAT_MSG_WHISPER") then
  local validMsg = self:WhisperHandler(arg1,arg2);
  if (validMsg == false) then
   GogglesCastHelper_ChatFrame_OnEventOrig(event);
  end    
 else
  GogglesCastHelper_ChatFrame_OnEventOrig(event);
 end
end

-- ChatFrame event handler
function GogglesCastHelper:WhisperHandler(msg,author)
 local key,val;
 if (msg == "gch") then
  SendChatMessage(GogglesLanguage.whisperResponse, "WHISPER", nil, author);  
  for key,val in GogglesCastHelperSVPC.spells do
   if (val.whisper == 1 and val.shortName ~= nil) then
    local spellInfo = " - " .. val.shortName .. " : " .. val.name;
    if (val.rank ~= nil) then
     spellInfo = spellInfo .. " (" .. string.format(GogglesLanguage.spellRank,val.rank) .. ")";
    end
    SendChatMessage(spellInfo, "WHISPER", nil, author);   
   end
  end
  return true;
 else
  for key,val in GogglesCastHelperSVPC.spells do
   -- check if need to add to queue
   if (val.shortName ~= nil and strlower(msg) == strlower(val.shortName) and val.whisper == 1) then
    tinsert(self.whisperQueue,{spellId=key,spellTexture=val.texture,player=author});
    self:WhisperUpdate();     
    return true;
   end
  end
 end
 return false;
end

-- Pickup spell handler
function GogglesCastHelper:PickupSpellHandler(spellId, bookType)
 self.cursorSpellId = spellId;
 self.cursorBookType = bookType;
 GogglesCastHelper_PickupSpellOrig(spellId, bookType);
end

-- Update states
function GogglesCastHelper:CheckStates(event,arg1)
 local i,j,k,state,onE,onA,offE,offA;
 for i,state in self.states do
  if (state.class == "NONE" or state.class == "ALL" or state.class == self.class) then
   for j,onE in state.onEvent do
    if (onE == event) then
     if (table.getn(state.onArgs) > 0) then
      for k,onA in state.onArgs do
       if (onA == arg1) then
        state.state=1;
       end
      end
     else
      state.state=1;
     end   
    end
   end
   for j,offE in state.offEvent do
    if (offE == event) then
     if (table.getn(state.offArgs) > 0) then
      for k,offA in state.offArgs do
       if (offA == arg1) then
        state.state=0;
       end
      end
     else
      state.state=0;
     end
    end
   end  
  end
 end 
end

-- Cast actions
function GogglesCastHelper:Cast(actions)
 local key,val,key2,val2;
 for key,val in actions do
  if (val == "trinket") then
   self:CastTrinket();
  elseif (val == "whisper") then
   self:CastWhisper(1);
  else
   for key2,val2 in GogglesCastHelperSVPC.spells do
    if ((val2.shortName ~= nil and strlower(val) == strlower(val2.shortName)) or strlower(val) == strlower(val2.name)) then
     self:CastSpell(val2);
     break;
    end
   end
  end
 end
end

-- Cast trinket
function GogglesCastHelper:CastTrinket()
 if (GetInventoryItemCooldown("player",13) == 0) then
  UseInventoryItem(13); 
  SpellStopCasting(); 
 end 
 if (GetInventoryItemCooldown("player",14) == 0) then
  UseInventoryItem(14); 
  SpellStopCasting(); 
 end 
end

-- Cast whisper
function GogglesCastHelper:CastWhisper(id)
 if (self.whisperQueue[id] ~= nil) then
  self:CastSpell(GogglesCastHelperSVPC.spells[self.whisperQueue[id].spellId],self.whisperQueue[id].player,id);
 end
end

-- Cast spell
function GogglesCastHelper:CastSpell(spell,player,whisperId)
 local i,j,state,state2;
 local castSpell, spellId, bookType, globalCooldown, target = true, spell.spellId, spell.bookType, spell.globalCooldown, spell.target;
 for i, state in self.states do
  if (state.class == "NONE" and state.state == 1 and state.continue == 0) then
   castSpell = false;
   break;
  elseif ((state.class == "ALL" or state.class == self.class) and state.state == 1) then
   local success = false;
   for j, state2 in spell.states do
    if (state2.stateId == i) then
     spellId = state2.spellId;
     bookType = state2.bookType;
     success = true;
     break;  
    end
   end
   if (success == true) then
    break;
   end
  end
 end
 if (castSpell == true and GetSpellCooldown(spellId, bookType) == 0) then 
  if (player ~= nil and target == "target" and target == "none") then
   TargetByName(player,true);
   CastSpell(spellId, bookType);
   if (SpellIsTargeting()) then
    SpellStopTargeting(); 
   end
   TargetLastTarget();
  elseif (target == "none" or target == "target") then
   CastSpell(spellId, bookType);
   if (SpellIsTargeting()) then
    SpellTargetUnit("player"); -- Cast on self if invalid target
   end
  elseif (target == "self") then
   TargetUnit("player");
   CastSpell(spellId, bookType);
   TargetLastTarget();
  end
  if (globalCooldown == nil) then
   SpellStopCasting();      
  end
  if (whisperId ~= nil and self.whisperQueue[whisperId] ~= nil) then
   table.remove(self.whisperQueue,id);
   self:WhisperUpdate();
  end  
 end
end

-- Add spell
function GogglesCastHelper:AddSpell(id)
 if (self.cursorSpellId ~= nil and self.cursorSpellId > 0 and CursorHasSpell()) then  
  local spellName, spellRank = GetSpellName(self.cursorSpellId, self.cursorBookType);
  local spellTexture = GetSpellTexture(self.cursorSpellId, self.cursorBookType);
  if (spellRank ~= nil) then
   _,_,spellRank = strfind(spellRank, GogglesLanguage.rankMask);
  end
  
  if (id ~= nil) then
   GogglesCastHelperSVPC.spells[id].name = spellName;
   GogglesCastHelperSVPC.spells[id].rank = spellRank;
   GogglesCastHelperSVPC.spells[id].texture = spellTexture;
   GogglesCastHelperSVPC.spells[id].spellId = self.cursorSpellId;
   GogglesCastHelperSVPC.spells[id].bookType = self.cursorBookType;
  else
   local i, spellStates = 0, {};
   for i=1,table.getn(self.states) do
    if (self.states[i].class == self.class or self.states[i].class == "ALL") then
     tinsert(spellStates,{name=spellName,rank=spellRank,texture=spellTexture,spellId=self.cursorSpellId,bookType=self.cursorBookType,stateId=i,stateType=self.states[i].name});
    end
   end
   tinsert(GogglesCastHelperSVPC.spells,{name=spellName,rank=spellRank,texture=spellTexture,spellId=self.cursorSpellId,bookType=self.cursorBookType,states=spellStates,target="none",globalCooldown=1,whisper=nil,range=0,shortName="",actionSlot=0});
   self.current = table.getn(GogglesCastHelperSVPC.spells);
  end 
  self:SpellListScrollFrameUpdate(); 
  self:StateListScrollFrameUpdate(); 
  self:OptionsUpdate();
  DeleteCursorItem();
 end
end

-- Set current spell
function GogglesCastHelper:SetCurrent(id) 
 self.current = id;
 self:SpellListScrollFrameUpdate(); 
 self:StateListScrollFrameUpdate(); 
 self:OptionsUpdate();
end

-- Remove spell
function GogglesCastHelper:RemoveSpell(id)
 local key, val;
 for key, val in self.whisperQueue do
  if (val.spellId == id) then
   table.remove(self.whisperQueue,key);
  end
 end
 table.remove(GogglesCastHelperSVPC.spells,id);
 self:SpellListScrollFrameUpdate(); 
 self:StateListScrollFrameUpdate(); 
 self:OptionsUpdate();
end

-- Update state
function GogglesCastHelper:UpdateState(id)
 if (self.cursorSpellId ~= nil and CursorHasSpell()) then  
  local spellName, spellRank = GetSpellName(self.cursorSpellId, self.cursorBookType);
  local spellTexture = GetSpellTexture(self.cursorSpellId, self.cursorBookType);
  if (spellRank ~= nil) then
   _,_,spellRank = strfind(spellRank, GogglesLanguage.rankMask);
  end
  
  if (id ~= nil) then
   GogglesCastHelperSVPC.spells[self.current].states[id].name = spellName;
   GogglesCastHelperSVPC.spells[self.current].states[id].rank = spellRank;
   GogglesCastHelperSVPC.spells[self.current].states[id].texture = spellTexture;
   GogglesCastHelperSVPC.spells[self.current].states[id].spellId = self.cursorSpellId;
   GogglesCastHelperSVPC.spells[self.current].states[id].bookType = self.cursorBookType;
  end 
  self:StateListScrollFrameUpdate(); 
 end
end

-- SpellListScrollFrame update
function GogglesCastHelper_SpellListScrollFrameUpdate()
 GogglesCastHelper:SpellListScrollFrameUpdate();
end

function GogglesCastHelper:SpellListScrollFrameUpdate()
 FauxScrollFrame_Update(GogglesCastHelperMainFrameSpellListScrollFrame,table.getn(GogglesCastHelperSVPC.spells),10,36);
 local line; 
 local offset = max(1,FauxScrollFrame_GetOffset(GogglesCastHelperMainFrameSpellListScrollFrame)+1);
 for line = 1,table.getn(GogglesCastHelperSVPC.spells) do
  if (line >= offset and line < offset+10) then
   if (GogglesCastHelperSVPC.spells[line] ~= nil) then
    if (getglobal("GogglesCastHelperSpellItemButton"..line) == nil) then
     CreateFrame("BUTTON", "GogglesCastHelperSpellItemButton" .. line, GogglesCastHelperMainFrame, "GogglesCastHelperSpellItemButton");  
     self.maxSpells = max(self.maxSpells,line);
    end
    getglobal("GogglesCastHelperSpellItemButton"..line):SetPoint("TOPLEFT",GogglesCastHelperMainFrameSpellListScrollFrame,"TOPLEFT",4,36-(36*(line-offset+1)));
    getglobal("GogglesCastHelperSpellItemButton"..line):SetID(line);
    getglobal("GogglesCastHelperSpellItemButton"..line .. "Name"):SetText(GogglesCastHelperSVPC.spells[line].name);
    if (GogglesCastHelperSVPC.spells[line].rank ~= nil) then
     getglobal("GogglesCastHelperSpellItemButton"..line .. "Description"):SetText(string.format(GogglesLanguage.spellRank, GogglesCastHelperSVPC.spells[line].rank));
    else
     getglobal("GogglesCastHelperSpellItemButton"..line .. "Description"):SetText("");
    end
    getglobal("GogglesCastHelperSpellItemButton"..line .. "IcoIconTexture"):SetTexture(GogglesCastHelperSVPC.spells[line].texture);
    getglobal("GogglesCastHelperSpellItemButton"..line .. "Ico"):SetID(line); 
    getglobal("GogglesCastHelperSpellItemButton"..line .. "Ico").spellId = GogglesCastHelperSVPC.spells[line].spellId;
    getglobal("GogglesCastHelperSpellItemButton"..line .. "Ico").bookType = GogglesCastHelperSVPC.spells[line].bookType;      
    getglobal("GogglesCastHelperSpellItemButton"..line):Show();
   end
  else
   if (getglobal("GogglesCastHelperSpellItemButton"..line) ~= nil) then
    getglobal("GogglesCastHelperSpellItemButton"..line):Hide();
   end
  end
 end
 for line = table.getn(GogglesCastHelperSVPC.spells)+1, self.maxSpells do
  if (getglobal("GogglesCastHelperSpellItemButton"..line) ~= nil) then
   getglobal("GogglesCastHelperSpellItemButton"..line):Hide();
  end  
 end
end

-- StateListScrollFrame update
function GogglesCastHelper_StateListScrollFrameUpdate()
 GogglesCastHelper:StateListScrollFrameUpdate();
end

function GogglesCastHelper:StateListScrollFrameUpdate()
 local hideFrom = 1;
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then
  hideFrom = table.getn(GogglesCastHelperSVPC.spells[self.current].states)+1;
  FauxScrollFrame_Update(GogglesCastHelperMainFrameStateListScrollFrame,table.getn(GogglesCastHelperSVPC.spells[self.current].states),3,36);
  local line; 
  local offset = max(1,FauxScrollFrame_GetOffset(GogglesCastHelperMainFrameStateListScrollFrame)+1);
  for line = 1,table.getn(GogglesCastHelperSVPC.spells[self.current].states) do
   if (line >= offset and line < offset+3) then
    if (GogglesCastHelperSVPC.spells[self.current].states[line] ~= nil) then
     if (getglobal("GogglesCastHelperStateItemButton"..line) == nil) then
      CreateFrame("BUTTON", "GogglesCastHelperStateItemButton" .. line, GogglesCastHelperMainFrame, "GogglesCastHelperStateItemButton");  
      self.maxStates = max(self.maxStates,line);
     end     
     getglobal("GogglesCastHelperStateItemButton"..line):SetPoint("TOPLEFT",GogglesCastHelperMainFrameStateListScrollFrame,"TOPLEFT",220,36-(36*(line-offset+1)));
     getglobal("GogglesCastHelperStateItemButton"..line):SetID(line);
     local name = GogglesCastHelperSVPC.spells[self.current].states[line].name;
     if (GogglesCastHelperSVPC.spells[self.current].states[line].rank ~= nil) then
      name = name .. " (" .. GogglesCastHelperSVPC.spells[self.current].states[line].rank .. ")";
     end
     getglobal("GogglesCastHelperStateItemButton"..line .. "Name"):SetText(name);
     getglobal("GogglesCastHelperStateItemButton"..line .. "Description"):SetText(GogglesCastHelperSVPC.spells[self.current].states[line].stateType);
     getglobal("GogglesCastHelperStateItemButton"..line .. "IcoIconTexture"):SetTexture(GogglesCastHelperSVPC.spells[self.current].states[line].texture);
     getglobal("GogglesCastHelperStateItemButton"..line .. "Ico"):SetID(line); 
     getglobal("GogglesCastHelperStateItemButton"..line .. "Ico").spellId = GogglesCastHelperSVPC.spells[self.current].states[line].spellId;
     getglobal("GogglesCastHelperStateItemButton"..line .. "Ico").bookType = GogglesCastHelperSVPC.spells[self.current].states[line].bookType;      
     getglobal("GogglesCastHelperStateItemButton"..line):Show();        
    end
   else
    if (getglobal("GogglesCastHelperStateItemButton"..line) ~= nil) then
     getglobal("GogglesCastHelperStateItemButton"..line):Hide();
    end
   end
  end
 else
  FauxScrollFrame_Update(GogglesCastHelperMainFrameStateListScrollFrame,0,3,36);
 end
 for line = hideFrom, self.maxStates do
  if (getglobal("GogglesCastHelperStateItemButton"..line) ~= nil) then
   getglobal("GogglesCastHelperStateItemButton"..line):Hide();
  end  
 end
end

-- Update options 
function GogglesCastHelper:OptionsUpdate()
 GogglesCastHelperMainFrameWhisperCast:SetChecked(GogglesCastHelperSVPC.whisperCast);
 GogglesCastHelperMainFrameRangeCheck:SetChecked(GogglesCastHelperSVPC.rangeCheck);
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then
  GogglesCastHelperMainFrameShortName:SetText(GogglesCastHelperSVPC.spells[self.current].shortName);
  GogglesCastHelperMainFrameRange:SetNumber(max(GogglesCastHelperSVPC.spells[self.current].range,0));
  GogglesCastHelperMainFrameTarget:SetText(GogglesCastHelperSVPC.spells[self.current].target);
  GogglesCastHelperMainFrameActionSlot:SetNumber(max(GogglesCastHelperSVPC.spells[self.current].actionSlot,0));
  GogglesCastHelperMainFrameGlobalCooldown:SetChecked(GogglesCastHelperSVPC.spells[self.current].globalCooldown);
  GogglesCastHelperMainFrameWhisper:SetChecked(GogglesCastHelperSVPC.spells[self.current].whisper);
 end
end

-- Set whisper stop value
function GogglesCastHelper:WhisperCastClick()
 GogglesCastHelperSVPC.whisperCast = GogglesCastHelperMainFrameWhisperCast:GetChecked();
 self:WhisperUpdate(); 
end

-- Set range check value
function GogglesCastHelper:RangeCheckClick()
 GogglesCastHelperSVPC.rangeCheck = GogglesCastHelperMainFrameRangeCheck:GetChecked();
 self:RangeCheckUpdate(); 
end

-- Set short name value
function GogglesCastHelper:ShortNameChange()
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then 
  GogglesCastHelperSVPC.spells[self.current].shortName = GogglesCastHelperMainFrameShortName:GetText();
 end
end

-- Set range value
function GogglesCastHelper:RangeChange()
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then 
  GogglesCastHelperSVPC.spells[self.current].range = GogglesCastHelperMainFrameRange:GetNumber();
  if (GogglesCastHelperSVPC.spells[self.current].actionSlot ~= nil and GogglesCastHelperSVPC.spells[self.current].actionSlot > 0 and GogglesCastHelperSVPC.spells[self.current].range ~= nil and GogglesCastHelperSVPC.spells[self.current].range > 0) then
   if (GogglesCastHelperSVPC.spells[self.current].range > table.getn(self.rangeChecks)) then
    table.setn(self.rangeChecks,GogglesCastHelperSVPC.spells[self.current].range);
   end
   self.rangeChecks[GogglesCastHelperSVPC.spells[self.current].range] = GogglesCastHelperSVPC.spells[self.current];
  end  
  self:RangeCheckUpdate();  
 end
end

-- Set target value
function GogglesCastHelper:TargetChange()
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then 
  local target = GogglesCastHelperMainFrameTarget:GetText();
  if (target == "none" or target == "self" or target == "target") then
   GogglesCastHelperSVPC.spells[self.current].target = target;
  end
 end
end

-- Set action slot value
function GogglesCastHelper:ActionSlotChange()
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then
  GogglesCastHelperSVPC.spells[self.current].actionSlot = GogglesCastHelperMainFrameActionSlot:GetNumber();
  if (GogglesCastHelperSVPC.spells[self.current].actionSlot ~= nil and GogglesCastHelperSVPC.spells[self.current].actionSlot > 0 and GogglesCastHelperSVPC.spells[self.current].range ~= nil and GogglesCastHelperSVPC.spells[self.current].range > 0) then
   if (GogglesCastHelperSVPC.spells[self.current].range > table.getn(self.rangeChecks)) then
    table.setn(self.rangeChecks,GogglesCastHelperSVPC.spells[self.current].range);
   end
   self.rangeChecks[GogglesCastHelperSVPC.spells[self.current].range] = GogglesCastHelperSVPC.spells[self.current];
  end  
  self:RangeCheckUpdate();
 end
end

-- Set global cooldown value
function GogglesCastHelper:GlobalCooldownClick()
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then 
  GogglesCastHelperSVPC.spells[self.current].globalCooldown = GogglesCastHelperMainFrameGlobalCooldown:GetChecked();
 end
end

-- Set whisper value
function GogglesCastHelper:WhisperClick()
 if (GogglesCastHelperSVPC.spells[self.current] ~= nil) then
  GogglesCastHelperSVPC.spells[self.current].whisper = GogglesCastHelperMainFrameWhisper:GetChecked();
 end
end

-- Remove whisper
function GogglesCastHelper:RemoveWhisper(id)
 if (self.whisperQueue[id] ~= nil) then
  table.remove(self.whisperQueue,id);
  self:WhisperUpdate();
 end
end

-- Update whisper frame
function GogglesCastHelper:WhisperUpdate()
 if (GogglesCastHelperSVPC.whisperCast == nil or self.whisperQueue == nil or table.getn(self.whisperQueue) == 0) then
  GogglesCastHelperWhisperFrame:Hide();
 else
  local i;
  for i=1,table.getn(self.whisperQueue) do
   if (getglobal("GogglesCastHelperWhisperItemButton"..i) == nil) then
    CreateFrame("BUTTON", "GogglesCastHelperWhisperItemButton" .. i, GogglesCastHelperWhisperFrame, "GogglesCastHelperWhisperItemButton");  
    self.maxWhispers = max(self.maxWhispers,i);
   end
   getglobal("GogglesCastHelperWhisperItemButton"..i):SetPoint("TOPLEFT",GogglesCastHelperWhisperFrame,"TOPLEFT",8,12-(18*i));
   getglobal("GogglesCastHelperWhisperItemButton"..i):SetID(i); 
   getglobal("GogglesCastHelperWhisperItemButton"..i .. "Name"):SetText(self.whisperQueue[i].player);
   getglobal("GogglesCastHelperWhisperItemButton"..i .. "Ico"):SetID(i);
   getglobal("GogglesCastHelperWhisperItemButton"..i .. "IcoIconTexture"):SetTexture(self.whisperQueue[i].spellTexture);     
   getglobal("GogglesCastHelperWhisperItemButton"..i):Show();    
  end
  for i=table.getn(self.whisperQueue)+1,self.maxWhispers do 
   if (getglobal("GogglesCastHelperWhisperItemButton"..i) ~= nil) then
    getglobal("GogglesCastHelperWhisperItemButton"..i):Hide();
   end    
  end
  GogglesCastHelperWhisperFrame:SetHeight(12+(18*table.getn(self.whisperQueue)));
  GogglesCastHelperWhisperFrame:Show();
 end
end

-- Update range check frame
function GogglesCastHelper:RangeCheckUpdate()
 if (GogglesCastHelperSVPC.rangeCheck == 1 and self.rangeChecks ~= nil and table.getn(self.rangeChecks) > 0) then
  local i;
  local inRange = 0;
  for i=1,table.getn(self.rangeChecks) do
   if (self.rangeChecks[i] ~= nil) then
    if (IsActionInRange(self.rangeChecks[i].actionSlot) == 1) then
     if (getglobal("GogglesCastHelperRangeCheckTexture"..i) == nil) then
      GogglesCastHelperRangeCheckFrame:CreateTexture("GogglesCastHelperRangeCheckTexture"..i,"ARTWORK",GogglesCastHelperRangeCheckTexture);
     end    
     getglobal("GogglesCastHelperRangeCheckTexture"..i):SetTexture(self.rangeChecks[i].texture);      
     getglobal("GogglesCastHelperRangeCheckTexture"..i):SetWidth(24);
     getglobal("GogglesCastHelperRangeCheckTexture"..i):SetHeight(24);
     getglobal("GogglesCastHelperRangeCheckTexture"..i):SetPoint("BOTTOMLEFT",3,3+(inRange*24));
     getglobal("GogglesCastHelperRangeCheckTexture"..i):Show();
     inRange = inRange + 1;
    else
     if (getglobal("GogglesCastHelperRangeCheckTexture"..i) ~= nil) then
      getglobal("GogglesCastHelperRangeCheckTexture"..i):Hide();
     end 
    end
   else
    if (getglobal("GogglesCastHelperRangeCheckTexture"..i) ~= nil) then
     getglobal("GogglesCastHelperRangeCheckTexture"..i):Hide();
    end  
   end
  end
  for i=table.getn(self.rangeChecks)+1,self.maxRangeChecks do 
   if (getglobal("GogglesCastHelperRangeCheckTexture"..i) ~= nil) then
    getglobal("GogglesCastHelperRangeCheckTexture"..i):Hide();
   end
  end 
  if (inRange > 0) then
   GogglesCastHelperRangeCheckFrame:SetHeight(6+(24*inRange));
   GogglesCastHelperRangeCheckFrame:Show();
  else
   GogglesCastHelperRangeCheckFrame:Hide();
  end
 else
  GogglesCastHelperRangeCheckFrame:Hide();
 end
end



